# Yalla Kora 
### iOS Sports Application 

---

## Project Overview

**Yalla Kora** is an iOS sports application built with UIKit and Swift. It allows users to browse sports, explore leagues, view detailed match information (upcoming & latest events), and save their favorite leagues locally using CoreData. Data is fetched from [AllSportsAPI](https://allsportsapi.com/) via Alamofire.

---

## Features

### 🏅 Sports Tab
- Displays all available sports from AllSportsAPI in a 2-column CollectionView
- Each item shows the sport thumbnail and name
- Tapping a sport navigates to the Leagues screen

### ⭐ Favorites Tab
- Displays user-saved favorite leagues (persisted via CoreData)
- UI mirrors the Leagues screen
- Tapping a favorite league while online navigates to League Details; offline shows a no-internet alert

### 🏆 Leagues Screen
- TableViewController showing leagues for the selected sport
- Custom cells with a circular league badge and league name
- Tapping a league navigates to League Details

### 📋 League Details Screen
- Add/remove league from favorites via a top-right button
- **Upcoming Events** — horizontal CollectionView showing event name, date, time, and team images
- **Latest Events** — vertical CollectionView showing teams, scores, date, and time
- **Teams** — horizontal CollectionView of circular team images; tapping navigates to Team Details

### 👕 Team Details Screen
- Displays key team information with an elegant, custom UI

### 🌙 Bonus Features
- Onboarding screen
- Dark theme support

---

## Tech Stack

| Category | Technology |
|----------|------------|
| Language | Swift |
| UI Framework | UIKit |
| Networking | Alamofire |
| Local Storage | CoreData |
| Architecture | MVC + Protocol-Oriented Networking |
| Testing | XCTest (Unit Tests) |
| API | [AllSportsAPI](https://allsportsapi.com/) |

---

## Project Structure

```

## Setup & Installation

1. Clone the repository
2. Install dependencies via CocoaPods:
   ```bash
   pod install
   ```
3. Open `YallaKora.xcworkspace` in Xcode
4. Add your AllSportsAPI key in `NetworkManager.swift`
5. Build and run on a simulator or device (iOS 15+)

---

## Notes

- All screens support Auto Layout constraints for full device compatibility
- Consistent UI/UX design across all screens
- Internet connectivity is checked before navigating from the Favorites tab

---
