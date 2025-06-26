import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'login.dart';
import 'register.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.purple,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: screenSize.height * 0.2, // Adjust the top padding proportionally
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.pets,
                    color: const Color.fromARGB(255, 172, 134, 134),
                    size: screenSize.width * 0.2, // Adjust the icon size proportionally
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenSize.height * 0.03, // Adjust the top padding proportionally
                    ),
                    // child: Text(
                    //   'APP ICON',
                    //   style: TextStyle(
                    //     fontSize: screenSize.width * 0.07, // Adjust the font size proportionally
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.white,
                    //   ),
                    // ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: screenSize.height * 0.60), // Adjust the top margin proportionally
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              color: Color.fromARGB(190, 255, 255, 255),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                top: screenSize.height * 0.42, // Adjust the top margin proportionally
                left: screenSize.width * 0.05, // Adjust the left margin proportionally
                right: screenSize.width * 0.05, // Adjust the right margin proportionally
              ),
              height: screenSize.height * 0.50, // Adjust the container height proportionally
              width: screenSize.width, // Set the container width to match the screen width
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenSize.height * 0.06, // Adjust the sized box height proportionally
                  ),
                  Text(
                    "Welcome to SPARK",
                    style: TextStyle(
                      fontSize: screenSize.width * 0.06, // Adjust the font size proportionally
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'discover amazing things near to you',
                    style: TextStyle(
                      fontSize: screenSize.width * 0.04, // Adjust the font size proportionally
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.02), // Adjust the sized box height proportionally
                  SizedBox(
                    width: screenSize.width * 0.7, // Adjust the button width proportionally
                    height: screenSize.height * 0.07, // Adjust the button height proportionally
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const login(),
                  ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Sign In",
                      style: TextStyle(color: Colors.white)
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02, // Adjust the sized box height proportionally
                  ),
                  SizedBox(
                    width: screenSize.width * 0.7, // Adjust the button width proportionally
                    height: screenSize.height * 0.07, // Adjust the button height proportionally
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Register(),
                  ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: const BorderSide(
                            color: Colors.purple,
                          )),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.1, // Adjust the sized box height proportionally
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            indent: screenSize.width * 0.07, 
                            endIndent: screenSize.width * 0.07, 
                            color: Colors.black,
                            thickness: 0.5,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.03
                              ), 
                          child: Text(
                            'OR connect using',
                            style: TextStyle(
                              fontSize: screenSize.width * 0.04, // Adjust the font size proportionally
                              color: const Color.fromARGB(255, 177, 165, 175),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            indent: screenSize.width * 0.07, // Adjust the indent proportionally
                            endIndent: screenSize.width * 0.07, // Adjust the endIndent proportionally
                            color: Colors.black,
                            thickness: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenSize.width * 0.1, // Adjust the left padding proportionally
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.facebook,
                          size: screenSize.width * 0.1, // Adjust the icon size proportionally
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: screenSize.width * 0.15, // Adjust the sized box width proportionally
                        ),
                        Icon(
                          FontAwesomeIcons.twitter,
                          color: Colors.blue,
                          size: screenSize.width * 0.1, // Adjust the icon size proportionally
                        ),
                        SizedBox(
                          width: screenSize.width * 0.15, // Adjust the sized box width proportionally
                        ),
                        Icon(
                          FontAwesomeIcons.google,
                          color: Colors.red,
                          size: screenSize.width * 0.1, // Adjust the icon size proportionally
                        ),
                        SizedBox(
                          width: screenSize.width * 0.13, // Adjust the sized box width proportionally
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
