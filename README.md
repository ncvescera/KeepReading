<center>
    <img src="./KeepReading/assets/icon/icon.png">
    <h1>KeepReading</h1>
</center>

**KeepReading** is a Mobile (Android/IOS) Cross-Platform App wrapper for the _Keep Talking and Nobody Explodes_ manual.
It helps you to jump directly to a specific section of the manual with just a tap 🚀!

<center>
    <img src="./imgs/screen.gif" height="500px">
</center>


## Build from Source

1. Clone the repo: 
    ```
    git clone https://github.com/ncvescera/KeepReading.git
    cd KeepReading/KeepReading
    ```
2. Get all required packages:
    ```
    flutter pub get
    ```
3. Copy your manual inside `assets/`. You must have something like this:
    ```
    ls assets
    button_icons
    icon
    manual.pdf
    ```

4. Build the apk/ipa with
    ```
    flutter build apk
    flutter build ipa
    ```

For more info see: 
- [Deploy on Android](https://docs.flutter.dev/deployment/android)
- [Deploy on IOS](https://docs.flutter.dev/deployment/ios)