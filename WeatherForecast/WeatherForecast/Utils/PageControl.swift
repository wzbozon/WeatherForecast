//
//  PageControl.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 27/04/2023.
//

import SwiftUI
import UIKit

struct PageControl: UIViewRepresentable {
    @Binding var currentPage: Int
    var numberOfPages: Int

    func makeCoordinator() -> Coordinator {
        return Coordinator(currentPage: $currentPage)
    }

    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = 1
        control.setIndicatorImage(UIImage(systemName: "location.fill"), forPage: 0)
        control.pageIndicatorTintColor = UIColor(.white)
        control.currentPageIndicatorTintColor = UIColor(.black)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.setContentHuggingPriority(.required, for: .horizontal)
        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.pageControlDidFire(_:)),
            for: .valueChanged)
        return control
    }

    func updateUIView(_ control: UIPageControl, context: Context) {
        context.coordinator.currentPage = $currentPage
        control.numberOfPages = numberOfPages
        control.currentPage = currentPage
    }

    class Coordinator {
        var currentPage: Binding<Int>

        init(currentPage: Binding<Int>) {
            self.currentPage = currentPage
        }

        @objc
        func pageControlDidFire(_ control: UIPageControl) {
            currentPage.wrappedValue = control.currentPage
        }
    }
}
