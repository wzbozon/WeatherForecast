//
//  DataManager.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 25/04/2023.
//

import CoreData
import Foundation
import OrderedCollections

enum DataManagerType {
    case normal, preview, testing
}

class DataManager: NSObject, ObservableObject {

    static let shared = DataManager(type: .normal)
    static let preview = DataManager(type: .preview)
    static let testing = DataManager(type: .testing)

    @Published var cities: OrderedDictionary<UUID, City> = [:]

    var citiesArray: [City] {
        Array(cities.values)
    }

    fileprivate var managedObjectContext: NSManagedObjectContext
    private let citiesFRC: NSFetchedResultsController<CityMO>

    private init(type: DataManagerType) {
        switch type {
        case .normal:
            let persistentStore = PersistentStore()
            self.managedObjectContext = persistentStore.context
        case .preview:
            let persistentStore = PersistentStore(inMemory: true)
            self.managedObjectContext = persistentStore.context
            // Add Mock Data
            try? self.managedObjectContext.save()
        case .testing:
            let persistentStore = PersistentStore(inMemory: true)
            self.managedObjectContext = persistentStore.context
        }

        let cityFR: NSFetchRequest<CityMO> = CityMO.fetchRequest()
        cityFR.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        citiesFRC = NSFetchedResultsController(fetchRequest: cityFR,
                                              managedObjectContext: managedObjectContext,
                                              sectionNameKeyPath: nil,
                                              cacheName: nil)

        super.init()

        // Initial fetch to populate cities array
        citiesFRC.delegate = self
        try? citiesFRC.performFetch()
        if let newCities = citiesFRC.fetchedObjects {
            self.cities = OrderedDictionary(uniqueKeysWithValues: newCities.map({ ($0.id!, City(cityMO: $0)) }))
        }
    }

    func saveData() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                NSLog("Unresolved error saving context: \(error), \(error.userInfo)")
            }
        }
    }
}

extension DataManager: NSFetchedResultsControllerDelegate {

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let newCities = controller.fetchedObjects as? [CityMO] {
            self.cities = OrderedDictionary(uniqueKeysWithValues: newCities.map({ ($0.id!, City(cityMO: $0)) }))
        }
    }
}

extension City {

    fileprivate convenience init(cityMO: CityMO) {
        self.init()

        self.id = cityMO.id ?? UUID()
        self.name = cityMO.name ?? ""
        self.longitude = cityMO.longitude
        self.latitude = cityMO.latitude
    }
}
