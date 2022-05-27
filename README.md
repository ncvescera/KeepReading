![dart](	https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white) ![flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white) ![android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white) ![ios](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)
<p align="center">
    <img src="./KeepReading/assets/icon/icon.png">
    <h1 align="center">KeepReading</h1>
</p>

**KeepReading** is a Mobile (Android/IOS) Cross-Platform App wrapper for the _Keep Talking and Nobody Explodes_ manual.
It helps you to jump directly to a specific section of the manual with just a tap 🚀!

<p align="center"> <img src="./imgs/screen.gif" height="500px"></p>

## Features 🚀

<p align="center"> 
    <img src="./imgs/aperto.gif" height="350px">
    <img src="./imgs/utilizzo-pdf.gif" height="350px">
    <img src="./imgs/eliminato-pdf.gif" height="350px">
    <img src="./imgs/check-update.gif" height="350px">
    <img src="./imgs/update-onstart.gif" height="350px">
</p>

- Select and Import PDFs from phone storage
- Auto update check with GitHub Releases
- Quick Jump to PDFs section via buttons
- Pre-rendering PDF's pages to avoid lag when using the app

## Install ⬇️

Download the APK/IPA file from this link [Latest Release](https://github.com/ncvescera/KeepReading/releases/latest) and just install it !

_For now is only available APK installer (Android), I'll have to find a way to build for IOS too 🦽_

## Build from Source ⚙️

1. Clone the repo: 
    ```
    git clone https://github.com/ncvescera/KeepReading.git
    cd KeepReading/KeepReading
    ```
2. Get all required packages:
    ```
    flutter pub get
    ```
3. Build the apk/ipa with
    ```
    flutter build apk
    flutter build ipa
    ```

For more info see: 
- [Deploy on Android](https://docs.flutter.dev/deployment/android)
- [Deploy on IOS](https://docs.flutter.dev/deployment/ios)

## Future Updates 💪

- [ ] IOS release
- [ ] Page Helpers, some tools that help you with specific blocks e.g. pre-calculated intersections in complex cables, ecc
- [ ] Desktop version ??
- [ ] Better performance when PDF is pre-rendering pages (there is a problems with Isolate module and PDF reader: [issue](https://github.com/ScerIO/packages.flutter/issues/299))