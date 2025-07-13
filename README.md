# Crypto.iOS

A cryptocurrency tracking app built with SwiftUI.

## Platform

**Swift (iOS)** - Built using SwiftUI

## Features

- View cryptocurrency prices
- Search for coins
- Add coins to wishlist
- Dark/Light mode support
- Tab navigation (Home & Wishlist)

## Setup Instructions

1. Clone the repository:
   ```
   git clone https://github.com/Pratik-ios/Crypto.iOS.git
   ```

2. Open the project:
   ```
   cd Crypto.iOS
   open CryptoApp.xcodeproj
   ```

3. Build and run in Xcode (iOS 15.0+)

## Requirements

- Xcode 14.0+
- iOS 15.0+
- Internet connection

## Tech Stack

- SwiftUI
- Combine
- URLSession
- UserDefaults
- SDWebImageSwiftUI

## API

Uses CoinGecko API for cryptocurrency data.

## Assumptions & Shortcuts

- **60-second auto-refresh timer not added** due to CoinGecko API rate limits
- Manual refresh available with pull-to-refresh
- Basic error handling implemented
- UserDefaults used for simple data persistence

## Author

Pratik Khopkar - [@Pratik-ios](https://github.com/Pratik-ios)
