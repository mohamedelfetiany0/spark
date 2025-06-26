import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Splash Screen/WelcomeScreen.dart';
import 'dashboard/DiseasePage.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       home: DiseasePage(),
//     ),
//   );
// }
void main() {
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
      ),
      home: const WelcomeScreen(), //home: const Home(username: "username",),
    );
  }
}
