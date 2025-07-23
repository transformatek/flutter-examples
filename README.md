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
<br />
<br />
<br />

# 🧭 ORS Directions (Routing)

This app also supports route calculation between two coordinates using the OpenRouteService (ORS) Directions API.

## 🔑 API Key Setup

### 1. Open the file ors service

### 2. Replace the placeholder with your Ors API key from deploily

```dart
http.Response response = await http.get(Uri.parse(url), headers: {
        'accept': 'application/geo+json, */*',
        'apikey': 'your_api_key', // Replace with your actual API key
      });
```

## ▶️ Run the app

```bash
flutter run
```
