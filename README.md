# reminder_flutter


<img src ="https://github.com/Mirzaazmath/flutter_reminder/blob/main/assets/Simulator%20Screen%20Recording%20-%20iPhone%20SE%20(3rd%20generation)%20-%202023-02-27%20at%2016.47.58.gif" height="400">

A new Flutter project.

## Getting Started

In This Application We are using the GetX 
Note : 
* Use const whenever possible


// notification set for ios

1. iOS Settings

In your project folder go to your ios folder and find AppDelegate.Swift



and add a code like above the picture. Add the code below

if #available(iOS 10.0, *) {
UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
}
With the above code you are done with basic iOS settings.

for more info :https://www.dbestech.com/tutorials/flutter-local-notification-explained-for-ios-and-android



This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
