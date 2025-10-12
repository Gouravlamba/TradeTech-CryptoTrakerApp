# 💼 TradeTech – Crypto Portfolio Tracker App

A cross-platform mobile app built using Flutter to help users track their cryptocurrency investments in real-time. Powered by the **CoinGecko API**, it allows users to add assets, monitor their total portfolio value, and stay updated with live market prices.

---

## 📑 Table of Contents

- [🎯 Objective](#-objective)
- [✨ Features](#-features)
- [🧰 Technologies Used](#-technologies-used)
- [🔌 API Integration](#-api-integration)
- [🛠️ Setup & Installation](#-setup--installation)
  - [1. Prerequisites](#1-prerequisites)
  - [2. Clone the Repository](#2-clone-the-repository)
  - [3. Install Dependencies](#3-install-dependencies)
  - [4. Run the App](#4-run-the-app)
- [📱 App Workflow](#-app-workflow)
- [📂 Folder Structure](#-folder-structure)
- [🚀 Usage Instructions](#-usage-instructions)
- [🧩 Future Enhancements](#-future-enhancements)
- [📸 Screenshots](#-screenshots)
- [📝 License](#-license)

---

## 🎯 Objective

The objective of **TradeTech** is to provide a user-friendly, responsive, and efficient mobile platform for cryptocurrency investors to:

- Track crypto holdings and overall portfolio value
- Fetch and display **live prices** using the **CoinGecko API**
- Persist user data locally for offline access
- Deliver a smooth user experience with a modern UI, animations, and state management

---

## ✨ Features

### ✅ Splash Screen
- Custom splash screen with subtle animation
- Auto-navigates to portfolio screen after a delay

### ✅ Real-Time Data Fetching
- Retrieves live prices from CoinGecko
- Only fetches data for assets added by the user (optimized API usage)

### ✅ Portfolio Management
- Add cryptocurrencies by searching from the full CoinGecko list
- Enter and manage quantity owned
- Automatically calculate and display total holding value
- Pull-to-refresh to update all prices

### ✅ Local Data Storage
- Persist data using `shared_preferences` or `sqflite`
- Automatically reload portfolio after app restart

### ✅ UI & UX Enhancements
- Clean, modern UI using Cards and Lists
- Fade-in, slide-in animations for list updates
- Swipe-to-delete functionality for removing assets
- Floating Action Button (FAB) for adding new assets

---

## 🧰 Technologies Used

| Technology            | Purpose                                    |
|-----------------------|--------------------------------------------|
| **Flutter**           | Frontend framework                         |
| **Dart**              | Programming language                       |
| **CoinGecko API**     | Live cryptocurrency data                   |
| **shared_preferences**| Local data storage                         |
| **sqflite (optional)**| Local database (alternative storage option)|
| **http**              | Networking and API requests                |
| **intl**              | Currency formatting                        |
| **Provider / Riverpod (optional)** | State management              |

---

## 🔌 API Reference – CoinGecko

1. **Get All Coins**
Returns a list of all supported cryptocurrencies (ID, Symbol, Name).

2. **Get Current Prices**
3. 
Replace `{coin_ids}` with comma-separated coin IDs (e.g., `bitcoin,ethereum,litecoin`).

---

## 📂 Folder Structure
lib/
├── main.dart
├── models/
│   └── coin_model.dart
├── screens/
│   ├── splash_screen.dart
│   ├── portfolio_screen.dart
│   └── add_asset_screen.dart
├── services/
│   ├── api_service.dart
│   └── storage_service.dart
├── widgets/
│   ├── coin_tile.dart
│   ├── add_asset_dialog.dart
│   └── loading_indicator.dart
├── utils/
│   └── constants.dart
│   └── formatters.dart
└── assets/
    └── images/


---

## 🛠️ Setup & Installation

Follow these steps to run the project locally:

### 1. **Clone the repository**

```bash
git clone https://github.com/Gouravlamba/TradeTech-CryptoTrakerApp.git
cd TradeTech-CryptoTrakerApp
flutter pub get
flutter run
