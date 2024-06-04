# Introduction

iOS Weather Forecast App (SwiftUI + MVVM + Combine + URLSession async/await + CoreData)

# Features

- Display the weather for the selected city using Open-meteo API
- City name autocompletion using Google Places API
- Get city location using Google Places API
- Add cities to the local CoreData database

# Screenshots

<p float="left">
  <img src="/Screenshots/1.png" width="240" />
  <img src="/Screenshots/2.png" width="240" /> 
  <img src="/Screenshots/3.png" width="240" />
</p>

# How to run

1. Get key for Google Places API
2. Replace 'GooglePlacesAPIKey' in 'Info.plist' with your key

# Reference links

- [GitHub Repository](https://github.com/wzbozon/WeatherForecast)
- [Google Places API Documentation](https://developers.google.com/maps/documentation/places/web-service?hl=en)
- [Open-meteo API Documentation](https://open-meteo.com/en/docs)

# Stack

- iOS 16+
- Swift, SwiftUI, Combine, MVVM
- async / await, URLSession
- CoreData
- SPM

# Architecture

- MVVM, see templates folder
- Model consists of small Services
- Model is shared across modules using EnvironmentObject
- Services are injected to ViewModels
- ViewModels are injected to Views as @StateObject
- Each Service holds `LoadingStates(idle, data, error)` for it's data and state
- View and ViewModel can delegate routing to Router if there are many routes from a View
- Errors are passed using a `LoadingState` and displayed using `errorPopup` ViewModifier (see ErrorHandling.md)
