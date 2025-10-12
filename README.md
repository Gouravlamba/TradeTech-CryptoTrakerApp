# 💹 Crypto Portfolio Tracker  

A modern **Flutter-based cryptocurrency portfolio tracking app** that lets users manage, track, and analyze their crypto holdings in real time using live market data from the **CoinGecko API**.  

Beautifully designed with dark & light themes, charts, and smooth animations — built for both mobile and desktop screens.

---

## 📑 Table of Contents  

1. [🪙 Features](#-features)  
2. [⚙️ Technologies Used](#️-technologies-used)  
3. [🔌 API Used](#-api-used)  
4. [🧭 App Workflow](#-app-workflow)  
5. [🗂️ Folder Structure](#️-folder-structure)  
6. [🧑‍💻 Setup & Installation](#-setup--installation)  
7. [🖼️ Screenshots](#️-screenshots)  
8. [📜 License](#-license)  
9. [🙌 Credits](#-credits)

---

## 🪙 Features  

### 💰 Portfolio Management  
- Add, view, and remove crypto assets.  
- See real-time prices and total portfolio value.  
- Each coin card shows 24h change with color-coded gain/loss indicators.  

### 📈 Coin Details & Charts  
- View detailed market stats of each coin.  
- Interactive 7-day line chart.  
- Price change, market cap, all-time highs/lows, supply, and more.  

### 🌗 Dynamic Theming  
- Toggle between **Dark** 🌙 and **Light** ☀️ mode.  
- Smooth animated theme transitions for better UX.  

### 🧾 Live Search & Suggestions  
- Real-time coin search powered by CoinGecko.  
- Displays suggestions instantly as you type.  

### 👤 Profile Screen  
- User info section with editable profile picture.  
- UI-only demo for frontend presentation.  

### 🪄 Splash Screen  
- Animated splash with custom logo and brand color.  

### 💹 Dashboard Charts  
- Total portfolio chart with high/low markers.  
- Visual breakdown of coin performance.  

### 🧰 Responsive Design  
- Automatically adapts to mobile, tablet, and desktop screens.  
- Sidebar transforms into a drawer on small screens.  

---

## ⚙️ Technologies Used  

| Technology | Purpose |
|-------------|----------|
| 🧩 Flutter | Frontend framework |
| 🧠 GetX | State management, routing, and dependency injection |
| 🌐 CoinGecko API | Real-time cryptocurrency data |
| 📊 fl_chart | Line and bar charts for price visualization |
| 💾 Shared Preferences | Local storage for user holdings |
| 🎨 Lottie | Splash & animations |
| 💡 intl | Currency & number formatting |

---

## 🔌 API Used  

### **CoinGecko API**
- Base URL: `https://api.coingecko.com/api/v3/`
- Used for:
  - Fetching live market prices
  - 7-day chart data
  - Market statistics
  - Coin images, rank, and metadata  

---

## 🧭 App Workflow  

### 1️⃣ **Splash Screen**
Animated splash screen that transitions into the main app.

### 2️⃣ **MainApp Screen**
The home container managing navigation and layout.

### 3️⃣ **Portfolio Screen**
Displays:
- Total portfolio value  
- List of all held assets  
- Real-time price updates  
- Swipe to delete coins  

### 4️⃣ **Coin Details Screen**
Shows:
- Detailed stats, 24h performance, highs & lows  
- 7-day chart (🟢 green for high / 🔴 red for low)  
- Auto-adjusted layout, no scrolling required  

### 5️⃣ **Add Asset Screen**
Modal bottom sheet to add a new coin with quantity.

### 6️⃣ **Profile Screen**
Clean UI for personal info and demo avatar edit.

---
## 🗂️ Folder Structure 
lib/
├── core/
│ ├── helpers/formatters.dart
│ └── constants.dart
├── data/
│ └── services/coingecko_service.dart
├── logic/
│ └── controllers/portfolio_controller.dart
├── presentation/
│ ├── screens/
│ │ ├── splash/
│ │ ├── portfolio/
│ │ ├── coin_details/
│ │ ├── add_asset/
│ │ └── profile/
│ ├── widgets/
│ │ ├── total_value_banner.dart
│ │ └── loading_indicator.dart
│ └── theme/
│ └── app_colors.dart
└── main.dart


---

## 🧑‍💻 Setup & Installation  

### 🪜 Prerequisites  
- Flutter SDK (≥ 3.0)  
- Android Studio or VS Code  
- Internet connection (for live API data)  

---

### ⚡ Steps to Run Locally  

1. **Clone the repo**
   ```bash
   git clone https://github.com/yourusername/crypto_portfolio.git
cd crypto_portfolio
flutter pub get
flutter run
flutter build apk --release

---

Would you like me to:
- Add your **GitHub username + repo link** at the top (for visitors to find it easily)?
- Add **badges** (e.g., Flutter | License | API | Stars count) at the top header for a more professional GitHub look?


