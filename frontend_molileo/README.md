# frontend_molileo

This project is a Flutter application. Bеlow you will find everything you need to get started and run this app on a device or Emulator.

## Getting Started 

### Prerequisites
IDE of your choice (popular ones are [androidstudio](https://developer.android.com/studio/), [IntelliJ Idea](https://www.jetbrains.com/idea/download/), and [Visual Studio Code](https://code.visualstudio.com/)), [Flutter SDK](https://flutter.dev/docs/get-started/install/), depending on OS some extra actions are required, before being able to execute `flutter doctor` (export environment variables and installing additional driver kits)

### Set up your Android device
To prepare to run and test your Flutter app on an Android device, you’ll need an Android device running Android 4.1 (API level 16) or higher.

Enable Developer options on your device by opening `> Settings > About Phone > and press 7 times on the Build Number` then toggle and USB debugging on. 
Install the [Google USB Driver](https://developer.android.com/studio/run/win-usb) (Windows-only).

### Set up the Android emulator
To prepare to run and test your Flutter app on the Android emulator, follow these steps:

Enable [VM acceleration](https://developer.android.com/studio/run/emulator-acceleration) on your machine.
Launch `Android Studio > Tools > Android > AVD Manager and select Create Virtual Device`
Define desired device and select Next.
Select a corresponding system image for your system architecture (x86 or x64) and emultethe Android version you want.
Under `Emulated Performance, select Hardware - GLES 2.0` to enable hardware acceleration.
Verify the AVD configuration is correct, and select Finish.

Now your device is to be found under `Android Virtual Device Manager`. After having installed all dependencies (see below), choose your device and select `Run`.

After cloning this project locally, you are good to go!

 ### Install dependencies from the terminal

 ```dart 
flutter pub get
```
This command will run your [pubspec.yaml](https://flutter.io/platform-plugins/) and install all dependencies declared for this projects.

### Run App

```dart 
flutter run
``` 
### Add Packages into Project
```dart
import 'package:camera/camera.dart';
```
In order to import  a new package into the code it needs to be declared under the dependencies section in the [pubspec.yaml](https://flutter.io/platform-plugins/) file.
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^0.1.2
  camera: ^0.4.2
```
When adding a new dependency, the [pubspec.yaml](https://flutter.io/platform-plugins/) will be automatically exicuted and the dependency installed. But you can also run the command above.


### Add assets into Project
The [pubspec.yaml](https://flutter.io/platform-plugins/) not only manages the dependencies but also the assets.
In this Project we reference everything that is in the assets folder as an asset but you can also place a specific paths to your assets that should be considered. 
```yaml
  assets:
   - assets/
```

## Usage

### Mole Object

We are managing the moles in objects as below. Every mole object has a list of `MoleDetail` in which
the mole history is beeing stored. Each time the user adds a new picture to an exsisting mole a new MoleDetail is beeing added to the list.
```dart
Mole mole = new Mole(String id, String name, List <MoleDetail> moleDetails, String moleLocation);
```

### MoleDetail Object
A MoleDetail contains an image, a riskStatus that has been newly analysed based on the new image and a date that documents when it has been added.

```dart
MoleDetail moleDetail = new MoleDetail(String date, String imagePath, String riskStatus);
```

## Database
 For the storage of the moles we use a sqlite database. The class `DatabaseHelper` manages our database actions.
 ```dart
 DatabaseHelper helper = DatabaseHelper()
 }
 ```

The following method initializes the database and returns it.
 ```dart
Future<Database> get db async {
 }
 ```
The following method closes the database.
 ```dart
 Future close() async {
 }
 ```
This method saves a mole into the database.
  ```dart
 Future<int> save(Mole mole) async {
 }
 ```
This method returns all the moles as List.
  ```dart
 Future<List<Mole>> getMoles() async {
 }
 ```
This method adds a new MoleDetail into the database.
  ```dart
 Future<int> updateMoleDetail(String id, MoleDetail moleDetail) async {
 }
 ```
This method deletes a mole from the database.
  ```dart
 Future<int> deleteMole(String id) async {
 }
 ```

### Reusable Widget
We have implemented the AppBar as a reusable Widget which can display a title and a subtitel. There are two types.

```dart
AppBar appBar(String title, String subtitle) {

}
```
This Widget overwrites the back button with a choosen navigation.
```dart
AppBar appBarWithAction(String title, String subtitle, BuildContext context, String navigateTo) {
  
}
```



<!-- - [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Please check the example for full usage.

## Note
- Works only on Android
- Tested only on image classification

## Contributing
I am new to Flutter and I haven't worked on iOS yet.
So if you are an iOS developer, i'd be glad to receive some contribution.
Just send a PR or open up an issue! -->
