# frontend_molileo

This project is a Flutter application. Blow you will find everything you need to get started and run this app on a device or Emulator.

## Getting Started 

For help getting started with Flutter, view our:
[Flutter Installation](https://flutter.dev/docs/get-started/install), a guide to setup your flutter environment.
[Flutter Documentation](https://flutter.dev/docs), which offers tutorials, samples, guidance on mobile development, and a full API reference.

After cloning and setting up your environment, you are good to go!

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

The following methode initializes the database and returns it.
 ```dart
Future<Database> get db async {
 }
 ```
The following methode closes the database.
 ```dart
 Future close() async {
 }
 ```
This methode saves a mole into the database.
  ```dart
 Future<int> save(Mole mole) async {
 }
 ```
This methode returns all the moles as List.
  ```dart
 Future<List<Mole>> getMoles() async {
 }
 ```
This methode adds a new MoleDetail into the database.
  ```dart
 Future<int> updateMoleDetail(String id, MoleDetail moleDetail) async {
 }
 ```
This methode deletes a mole from the database.
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
