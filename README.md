<div align="center">12

![TradeTech Logo](assets/logo1.png)

# 💹 TradeTech - Crypto Portfolio Tracker

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-2.18+-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![GetX](https://img.shields.io/badge/GetX-4.6.5-8B5CF6?style=for-the-badge&logo=flutter&logoColor=white)](https://pub.dev/packages/get)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)
[![CoinGecko API](https://img.shields.io/badge/CoinGecko-API-00A300?style=for-the-badge&logo=bitcoin&logoColor=white)](https://www.coingecko.com/en/api)

**A modern, cross-platform cryptocurrency portfolio tracking application built with Flutter**

Track your crypto investments • Real-time market data • Beautiful UI • Dark/Light Themes

[Features](#-features) • [Architecture](#-architecture) • [Tech Stack](#-tech-stack) • [Installation](#-installation) • [Screenshots](#-screenshots)

</div>

---

## 📖 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Architecture](#-architecture)
  - [Application Architecture](#application-architecture)
  - [Backend Architecture](#backend-architecture)
  - [Data Flow](#data-flow)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Getting Started](#-getting-started)
- [API Integration](#-api-integration)
- [Screens](#-screens)
- [State Management](#-state-management)
- [Contributing](#-contributing)
- [License](#-license)
- [Contact](#-contact)

---

## 🎯 Overview

**TradeTech Crypto Portfolio Tracker** is a comprehensive mobile and desktop application that enables users to track their cryptocurrency investments in real-time. Built with Flutter and powered by the CoinGecko API, it provides live market data, interactive charts, and an intuitive interface for managing your crypto portfolio.

### Key Highlights:
- 📊 **Real-time Market Data** - Live prices from CoinGecko API
- 💰 **Portfolio Management** - Add, track, and remove crypto assets
- 📈 **Interactive Charts** - 7-day price charts with fl_chart
- 🌓 **Theme Support** - Beautiful dark and light mode
- 📱 **Cross-Platform** - Works on iOS, Android, Web, and Desktop
- ⚡ **Fast & Responsive** - Smooth animations and instant updates

---

## ✨ Features

### 💼 Portfolio Management
- ✅ Add cryptocurrency assets with custom quantities
- ✅ View real-time portfolio value
- ✅ Track individual coin performance
- ✅ Swipe to delete assets
- ✅ Automatic price updates
- ✅ Color-coded gain/loss indicators

### 📊 Market Analysis
- 📈 Interactive 7-day price charts
- 📉 24-hour price change tracking
- 💹 Market cap and volume data
- 🏆 All-time high/low tracking
- 📊 Supply and circulation metrics
- 🔄 Real-time data refresh

### 🎨 User Experience
- 🌙 **Dark Mode** - Eye-friendly dark theme
- ☀️ **Light Mode** - Clean light theme
- 🔄 Smooth theme transitions
- 🎬 Animated splash screen
- 🔍 Real-time search with suggestions
- 📱 Responsive design for all screen sizes
- 🎯 Intuitive navigation

### 👤 Profile & Settings
- 👤 User profile management
- 🖼️ Custom profile picture
- ⚙️ App settings and preferences
- 📊 Portfolio statistics

---

## 🏗️ Architecture

### Application Architecture

TradeTech follows the **Clean Architecture** pattern with **MVC (Model-View-Controller)** principles for maintainability and scalability. 

```
┌─────────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                        │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Screens    │  │   Widgets    │  │    Theme     │      │
│  │              │  │              │  │              │      │
│  │ • Splash     │  │ • Coin Card  │  │ • Colors     │      │
│  │ • Portfolio  │  │ • Charts     │  │ • Styles     │      │
│  │ • Details    │  │ • Buttons    │  │ • Dark/Light │      │
│  │ • Add Asset  │  │ • Banners    │  │              │      │
│  │ • Profile    │  │              │  │              │      │
│  └──────┬───────┘  └──────────────┘  └──────────────┘      │
└─────────┼──────────────────────────────────────────────────┘
          │
          │ GetX Bindings & State Management
          ▼
┌─────────────────────────────────────────────────────────────┐
│                      LOGIC LAYER                             │
│  ┌────────────────────────────────────────────────┐         │
│  │         Portfolio Controller (GetX)            │         │
│  │                                                 │         │
│  │  • State Management                            │         │
│  │  • Business Logic                              │         │
│  │  • Data Validation                             │         │
│  │  • UI Updates                                  │         │
│  │  • Navigation Control                          │         │
│  └────────────────┬───────────────────────────────┘         │
└───────────────────┼─────────────────────────────────────────┘
                    │
                    │ Service Calls
                    ▼
┌─────────────────────────────────────────────────────────────┐
│                       DATA LAYER                             │
│  ┌──────────────────┐         ┌──────────────────┐         │
│  │     Services     │         │   Local Storage  │         │
│  │                  │         │                  │         │
│  │ • CoinGecko API  │         │ • SharedPrefs    │         │
│  │ • HTTP Requests  │         │ • Cache          │         │
│  │ • Data Parsing   │         │ • User Data      │         │
│  │ • Error Handling │         │                  │         │
│  └────────┬─────────┘         └──────────────────┘         │
└───────────┼─────────���───────────────────────────────────────┘
            │
            ▼
┌─────────────────────────────────────────────────────────────┐
│                      CORE LAYER                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Helpers    │  │  Constants   │  │   Models     │      │
│  │              │  │              │  │              │      │
│  │ • Formatters │  │ • API URLs   │  │ • Coin       │      │
│  │ • Validators │  │ • App Config │  │ • Portfolio  │      │
│  │ • Utils      │  │ • Colors     │  │ • User       │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
```

### Backend Architecture

```
┌──────────────────────────────────────────────────────────────┐
│                    EXTERNAL SERVICES                          │
│                                                               │
│  ┌──────────────────────────────────────────────────┐        │
│  │            CoinGecko API (REST API)              │        │
│  │                                                   │        │
│  │  Endpoints:                                       │        │
│  │  • GET /coins/markets                            │        │
│  │  • GET /coins/{id}                               │        │
│  │  • GET /coins/{id}/market_chart                  │        │
│  │  • GET /search                                   │        │
│  └──────────────────┬───────────────────────────────┘        │
└─────────────────────┼──────────────────────────────────────┘
                      │ HTTPS
                      │ JSON Response
                      ▼
┌─────────────────────────────────────────────────────────────┐
│                   APPLICATION LAYER                          │
│                                                               │
│  ┌──────────────────────────────────────────────────┐        │
│  │          HTTP Service (Dart http package)        │        │
│  │                                                   │        │
│  │  • Request Interceptor                           │        │
│  │  • Response Parser                               │        │
│  │  • Error Handler                                 │        │
│  │  • Timeout Manager                               │        │
│  └──────────────────┬───────────────────────────────┘        │
│                     │                                         │
│                     ▼                                         │
│  ┌──────────────────────────────────────────────────┐        │
│  │         CoinGecko Service (Business Logic)       │        │
│  │                                                   │        │
│  │  fetchMarketData()                               │        │
│  │  getCoinDetails(coinId)                          │        │
│  │  getChartData(coinId, days)                      │        │
│  │  searchCoins(query)                              │        │
│  └──────────────────┬───────────────────────────────┘        │
└─────────────────────┼──────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────┐
│                    LOCAL STORAGE                             │
│                                                               │
│  ┌───────────────────────────────────��──────────────┐        │
│  │          SharedPreferences (Key-Value Store)     │        │
│  │                                                   │        │
│  │  Data Stored:                                    │        │
│  │  • User Portfolio Holdings                       │        │
│  │  • Theme Preference                              │        │
│  │  • User Settings                                 │        │
│  │  • Cache Data                                    │        │
│  └──────────────────────────────────────────────────┘        │
└─────────────────────────────────────────────────────────────┘
```

### Data Flow Architecture

```
┌─────────────┐
│    USER     │
│  INTERFACE  │
└──────┬──────┘
       │ User Action
       ▼
┌──────────────────┐
│   GetX          │
│   Controller    │ ◄─── State Management
└────────┬─────────┘
         │
         ├────► Local Check (SharedPreferences)
         │
         ├────► API Call (CoinGecko Service)
         │           │
         │           ├──► HTTP Request
         │           ├──► Parse JSON
         │           └──► Error Handling
         │
         ├────► Update State
         │
         └────► Notify UI
                │
                ▼
         ┌──────────────┐
         │   UI Update  │
         │  (Reactive)  │
         └──────────────┘
```

---

## 🛠️ Tech Stack

### Frontend Framework
| Technology | Version | Purpose |
|------------|---------|---------|
| ![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter) | 3.0+ | Cross-platform UI framework |
| ![Dart](https://img.shields.io/badge/Dart-2.18+-0175C2?logo=dart) | 2.18+ | Programming language |

### State Management
| Technology | Version | Purpose |
|------------|---------|---------|
| ![GetX](https://img.shields.io/badge/GetX-4.6.5-8B5CF6) | 4.6.5 | State management, routing, dependency injection |

### Networking & Data
| Package | Version | Purpose |
|---------|---------|---------|
| `http` | ^0.13.6 | HTTP client for API calls |
| `shared_preferences` | ^2.1.1 | Local data persistence |
| `intl` | ^0.18.0 | Internationalization & formatting |

### UI & Visualization
| Package | Version | Purpose |
|---------|---------|---------|
| `fl_chart` | ^0.69.0 | Interactive charts and graphs |
| `flutter_svg` | ^1.1.6 | SVG image support |
| `lottie` | ^2.2.0 | Animations |
| `cupertino_icons` | ^1.0.6 | iOS-style icons |

### External APIs
| Service | Purpose |
|---------|---------|
| [CoinGecko API](https://www.coingecko.com/en/api) | Real-time cryptocurrency data |

### Development Tools
- **IDE**: VS Code / Android Studio
- **Version Control**: Git & GitHub
- **Testing**: Flutter Test Framework

---

## 📁 Project Structure

```
TradeTech-CryptoTrackerApp/
│
├── android/                    # Android-specific files
├── ios/                        # iOS-specific files
├── linux/                      # Linux desktop files
├── macos/                      # macOS desktop files
├── web/                        # Web-specific files
├── windows/                    # Windows desktop files
│
├── assets/                     # Static assets
│   ├── logo1.png              # App logo
│   ├── logo22.png             # Alternative logo
│   └── image2.jpg             # Background images
│
├── lib/                        # Main application code
│   │
│   ├── core/                   # Core utilities and constants
│   │   ├── helpers/
│   │   │   └── formatters.dart        # Number & currency formatters
│   │   └── constants. dart              # App-wide constants
│   │
│   ├── data/                   # Data layer
│   │   ├── models/             # Data models
│   │   └── services/
│   │       └── coingecko_service.dart  # API service
│   │
│   ├── logic/                  # Business logic
│   │   └── controllers/
│   │       └── portfolio_controller.dart  # Main controller
│   │
│   ├── presentation/           # UI layer
│   │   ├── screens/
│   │   │   ├── splash/         # Splash screen
│   │   │   ├── portfolio/      # Portfolio view
│   │   │   ├── coin_details/   # Coin details screen
│   │   │   ├── add_asset/      # Add asset modal
│   │   │   └── profile/        # Profile screen
│   │   │
│   │   └── widgets/            # Reusable widgets
│   │       ├── total_value_banner.dart
│   │       ├── coin_card.dart
│   │       ├── loading_indicator.dart
│   │       └── chart_widget.dart
│   │
│   ├── theme/                  # Theme configuration
│   │   ├── app_colors.dart
���   │   └── app_theme.dart
│   │
│   └── main.dart               # Application entry point
│
├── test/                       # Unit and widget tests
│
├── pubspec.yaml               # Dependencies and assets
├── pubspec.lock               # Locked dependency versions
├── analysis_options.yaml      # Dart analyzer configuration
├── README.md                  # Project documentation
└── . gitignore                # Git ignore rules
```

---

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed: 

- ✅ **Flutter SDK** (3.0 or higher)
- ✅ **Dart SDK** (2.18 or higher)
- ✅ **Android Studio** or **VS Code**
- ✅ **Git**
- ✅ **Xcode** (for iOS development on macOS)
- ✅ **Android SDK** (for Android development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Gouravlamba/TradeTech-CryptoTrakerApp.git
   cd TradeTech-CryptoTrakerApp
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Verify Flutter installation**
   ```bash
   flutter doctor
   ```

4. **Run the app**
   ```bash
   # For mobile (iOS/Android)
   flutter run

   # For web
   flutter run -d chrome

   # For desktop (Windows/macOS/Linux)
   flutter run -d windows
   flutter run -d macos
   flutter run -d linux
   ```

### Building for Production

#### Android APK
```bash
flutter build apk --release
```

#### Android App Bundle
```bash
flutter build appbundle --release
```

#### iOS
```bash
flutter build ios --release
```

#### Web
```bash
flutter build web --release
```

#### Desktop
```bash
# Windows
flutter build windows --release

# macOS
flutter build macos --release

# Linux
flutter build linux --release
```

---

## 🌐 API Integration

### CoinGecko API

TradeTech uses the free tier of the CoinGecko API for fetching cryptocurrency data.

#### Base URL
```
https://api.coingecko.com/api/v3/
```

#### Endpoints Used

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/coins/markets` | GET | Fetch market data for multiple coins |
| `/coins/{id}` | GET | Get detailed information about a specific coin |
| `/coins/{id}/market_chart` | GET | Get historical price data |
| `/search` | GET | Search for coins by name/symbol |

#### Example Request
```dart
// Fetch market data
final response = await http.get(
  Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1'),
);
```

#### Rate Limits
- **Free Tier**: 10-50 calls/minute
- No API key required for basic usage
- Cached responses recommended

#### Sample Response
```json
{
  "id": "bitcoin",
  "symbol": "btc",
  "name": "Bitcoin",
  "current_price": 45000,
  "market_cap": 850000000000,
  "price_change_percentage_24h": 2.5
}
```

---

## 📱 Screens

### 1. Splash Screen
- Animated logo entrance
- Brand colors and smooth transitions
- Auto-navigates to main app

### 2. Portfolio Screen (Home)
- **Total Portfolio Value** - Aggregated value of all holdings
- **Asset List** - Card-based view of each cryptocurrency
- **Real-time Updates** - Live price refresh
- **Quick Actions** - Add asset button, refresh, settings

### 3. Coin Details Screen
- **Price Chart** - Interactive 7-day line chart
- **Market Stats**:
  - Current price
  - 24h change (%)
  - Market cap
  - Total volume
  - All-time high/low
  - Circulating supply
- **Color-coded Indicators** - Green for gains, red for losses

### 4. Add Asset Modal
- **Search Functionality** - Real-time coin search
- **Quantity Input** - Specify amount of coins
- **Validation** - Input validation and error handling
- **Instant Add** - Updates portfolio immediately

### 5. Profile Screen
- **User Information** - Name, email, profile picture
- **Portfolio Stats** - Total value, number of assets
- **Settings** - Theme toggle, preferences
- **Edit Profile** - Update user details

---

## 🔄 State Management

TradeTech uses **GetX** for state management, offering:

### Benefits
- ⚡ **Reactive State** - Automatic UI updates
- 🎯 **Dependency Injection** - Easy service management
- 🛣️ **Routing** - Simple navigation
- 💾 **Memory Efficient** - Automatic disposal
- 📦 **Minimal Boilerplate** - Clean code

### Controller Example
```dart
class PortfolioController extends GetxController {
  // Observable state
  var portfolio = <Coin>[].obs;
  var totalValue = 0.0.obs;
  var isLoading = false.obs;

  // Fetch data
  Future<void> fetchCoins() async {
    isLoading.value = true;
    portfolio.value = await CoinGeckoService.getMarketData();
    calculateTotalValue();
    isLoading.value = false;
  }

  // Update UI reactively
  void calculateTotalValue() {
    totalValue.value = portfolio.fold(0, (sum, coin) => sum + coin.value);
  }
}
```

---

## 🎨 Theming

### Dark Mode
- Deep blacks and dark grays
- Accent colors:  Purple, cyan
- Easy on the eyes for night usage

### Light Mode
- Clean whites and light grays
- Vibrant accent colors
- Professional and modern look

### Theme Toggle
Users can switch between themes with a single tap, with smooth animated transitions.

---

## 🧪 Testing

Run tests using: 

```bash
# Unit tests
flutter test

# Widget tests
flutter test test/widget_test.dart

# Integration tests
flutter test integration_test/
```

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/AmazingFeature
   ```
3. **Commit your changes**
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```
4. **Push to the branch**
   ```bash
   git push origin feature/AmazingFeature
   ```
5. **Open a Pull Request**

### Contribution Guidelines
- Follow Flutter best practices
- Write clean, documented code
- Add tests for new features
- Update README if needed

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2026 Gourav Lamba

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction... 
```

---

## 👨‍💻 Contact

**Gourav Lamba**

- GitHub: [@Gouravlamba](https://github.com/Gouravlamba)
- Repository: [TradeTech-CryptoTrackerApp](https://github.com/Gouravlamba/TradeTech-CryptoTrakerApp)

---

## 🙏 Acknowledgments

- [Flutter Team](https://flutter.dev) - For the amazing framework
- [CoinGecko](https://www.coingecko.com) - For providing free cryptocurrency data API
- [GetX](https://pub.dev/packages/get) - For excellent state management
- [fl_chart](https://pub.dev/packages/fl_chart) - For beautiful charts

---

## 📊 Project Stats

![GitHub stars](https://img.shields.io/github/stars/Gouravlamba/TradeTech-CryptoTrakerApp?style=social)
![GitHub forks](https://img.shields.io/github/forks/Gouravlamba/TradeTech-CryptoTrakerApp? style=social)
![GitHub watchers](https://img.shields.io/github/watchers/Gouravlamba/TradeTech-CryptoTrakerApp?style=social)

---

<div align="center">

### ⭐ Star this repository if you found it helpful!

Made with ❤️ by [Gourav Lamba](https://github.com/Gouravlamba)

**TradeTech** - Track Smart, Invest Smarter 💹

</div>
