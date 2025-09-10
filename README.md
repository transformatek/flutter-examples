# 📍 Photon Location Search App (Flutter)

A lightweight Flutter app to search addresses and get locations using the **Photon API** (geocoding & reverse geocoding).

---

## 🚀 Getting Started

### 1. Install / Setup Java version

Ensure you have the right java version (17)
In `~/.bashrc` you should have 
(we suppose that android Sdk and flutter are installed in /opt)

```bash
sudo apt install openjdk-17-jdk
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

export PATH="$PATH:/op/flutter/bin:$JAVA_HOME/bin"
export ANDROID_HOME=/opt/Android/Sdk
export ANDROID_SDK_ROOT=/opt/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
```

Check that the java version is fine
```bash
java --version
sudo update-alternatives --config java
flutter config --jdk-dir=$JAVA_HOME
```


### 2. Clone the project

```bash
git clone https://github.com/transformatek/flutter-examples.git
cd flutter_examples
```

### 2. Install dependencies

```bash
flutter pub get
code .
```

Useful commands for project cache invalidation
```bash
flutter clean
cd ./android
./gradlew clean
rm -rf .gradle
./gradlew wrapper --gradle-version=7.3
```

Useful commands to run the project

```bash
adb start-server
emulator -list-avds
emulator -avd <AVD NAME>
flutter run -v
```

TO Build a release

- Follow this guide for project setup [https://docs.flutter.dev/deployment/android](https://docs.flutter.dev/deployment/android)
- [Flutter launcher icons documentation](https://pub.dev/packages/flutter_launcher_icons)

```bash
flutter pub get
flutter pub run flutter_launcher_icons:main
flutter clean && flutter build appbundle --release
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
