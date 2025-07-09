
# 📍 Photon Location Search App (Flutter)

A lightweight Flutter app to search addresses and get locations using the **Photon API** (geocoding & reverse geocoding).

---

## 🚀 Getting Started

### 1. Clone the project

```bash
git clone https://github.com/transformatek/flutter-examples.git
cd geo_services
```
### 2. Install dependencies


```bash
flutter pub get
```

## 🔑 API Key Setup

### 1. Open the file

### 2. Replace the placeholder with your Photon API key from deploily

```dart
var response = await http.get(uri, headers: {
  'accept': 'application/json',
  'apikey': 'YOUR_API_KEY_HERE',
});
```

## ▶️ Run the app

```bash
flutter run
```