# Introduction

iOS Weather Forecast App (SwiftUI + MVVM + Router + async/await + CoreData + CloudKit)

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
- TBD, feature toggles
- GitHub CI/CD, Unit + UI tests, Fastlane, SwiftLint
- Firebase Analytics, RemoteConfig, Crashlytics, OSLog

# Architecture

- MVVM, see templates folder
- Model consists of small Services
- Model is shared across modules using EnvironmentObject
- Services are injected to ViewModels
- ViewModels are injected to Views as @StateObject
- Each Service holds `LoadingStates(idle, data, error)` for it's data and state
- View and ViewModel can delegate routing to Router if there are many routes from a View
- Errors are passed using a `LoadingState` and displayed using `errorPopup` ViewModifier (see ErrorHandling.md)

# SwiftLint

To install Swiftlint: 

    % brew install SwiftLint

If you get Permission denied error, do from project folder:

    % chmod 755 scripts/swiftlint.sh
    
# Git LFS

We store large files in Git LFS (for example, video files)

To install Git LFS: 

    % brew install git-lfs

To pull Git LFS files after you pull a project itself:

    % git lfs pull

# Fastlane

Update version and build number manually.
To publish a version on AppStore TestFlight run following commands: 

    % bundle install
    % bundle exec fastlane beta

# Logging

To log anything in the app use Logger.default.info and always put a context:

    import OSLog
    Logger.default.info("[Context] Logs with \(string, privacy: .public) interpolation")
    
These logs can be exported using Debug Menu as a file.
