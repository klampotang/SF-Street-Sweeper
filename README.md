# Street Sweeping App

A SwiftUI iOS app that shows San Francisco street sweeping schedules on an interactive map, powered by the [DataSF open data API](https://data.sfgov.org/resource/yhqp-riqs.geojson).

## Features

- **Live map overlay** — street sweeping routes are drawn as colored polylines directly on Apple Maps
- **Left/Right side distinction** — green lines indicate the right side of the street, orange lines indicate the left side
- **Day-of-week selector** — browse schedules for any day; defaults to today's day automatically
- **Location-aware** — centers on your current position and filters routes to the area around you
- **Location permission handling** — graceful banners guide the user through granting or re-enabling location access

## Screenshots
<img width="1206" height="2622" alt="IMG_5988" src="https://github.com/user-attachments/assets/24b10b2b-9860-473f-95fd-f94cae762376" />


## Requirements

| Requirement | Version |
|---|---|
| Xcode | 16+ |
| iOS Deployment Target | 17+ |
| Swift | 5.9+ |

## Getting Started

### 1. Clone the repo

```bash
git clone https://github.com/klampotang/Street-Sweeper-App-SwiftUI.git
cd Street-Sweeper-App-SwiftUI
```

### 2. Add your DataSF API token

The app uses the [DataSF Socrata API](https://data.sfgov.org/Transportation/Street-Sweeping-Schedule/yhqp-riqs/about_data). Requests work without a token but are rate-limited. To add your own token:

1. Register for a free app token at [data.sfgov.org](https://data.sfgov.org/login).
2. Duplicate `SecretsExample.swift` and rename the copy to `Secrets.swift`.
3. Uncomment the struct and replace `YOUR_TOKEN_HERE` with your token:

```swift
struct Config {
    static let dataSFAppToken = "your_token_here"
}
```

> `Secrets.swift` is excluded from version control. Never commit your token.

### 3. Open and run

Open `StreetSweepingApp.xcodeproj` in Xcode, select a simulator or device running iOS 17+, and press **Run**.

## Project Structure

```
StreetSweepingApp/
├── StreetSweepingAppApp.swift      # App entry point
├── MapScreen.swift                 # Main map view
├── StreetSweepingViewModel.swift   # Fetches and decodes DataSF GeoJSON
├── LocationManager.swift           # CoreLocation wrapper
├── GeoModels.swift                 # Decodable models for GeoJSON features
├── DayOfWeekEnum.swift             # Day-of-week enum with API string mapping
├── AppConstants.swift              # Shared colors (AppColor)
├── MapKeyView.swift                # Legend overlay (left/right color key)
├── PermissionBanner.swift          # Location permission status banner
├── SecretsExample.swift            # Token setup template (committed)
└── Secrets.swift                   # Your API token (not committed)
```

## Data Source

Street sweeping data is fetched live from the [SF Street Sweeping Schedule dataset](https://data.sfgov.org/Transportation/Street-Sweeping-Schedule/yhqp-riqs/about_data) via the Socrata GeoJSON endpoint. Queries are filtered by day of week and a bounding box around the user's location.

## License

MIT
