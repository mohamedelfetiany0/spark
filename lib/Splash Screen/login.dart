import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../dashboard/home.dart';
import 'register.dart';



class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false; 

Future<void> _loginUser(String email, String password) async {
  const url = 'https://aymantaher.com/Test/auth/login.php';

  setState(() {
    _isLoading = true;
  });

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      if (responseData['status'] == 'success') {
        final username = responseData['username'] ?? 'Guest';

        // Navigate to Home if login is successful
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home(username: username,
          email: email,)),
        );
      } else {
        // Handle incorrect login status
        String message = responseData['message'] ?? 'Unknown error';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $message')),
        );
      }
    } else {
      // Handle unexpected HTTP errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.statusCode}')),
      );
    }
  } catch (e) {
    // Handle network or other errors
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}


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
                    child: Text(
                      'SPARK',
                      style: TextStyle(
                        fontSize: screenSize.width * 0.07, // Adjust the font size proportionally
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 172, 134, 134),
                      ),
                    ),
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenSize.height * 0.06, // Adjust the sized box height proportionally
                    ),
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: screenSize.width * 0.06, // Adjust the font size proportionally
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.02), // Adjust the sized box height proportionally
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.height * 0.03,
                      ),
                      child: TextFormField(
                        controller: emailController,
                        cursorColor: Colors.purple,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Enter Your Email',
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty || !value.contains('@')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.03),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.height * 0.03,
                      ),
                      child: TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.trim().length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                        obscureText: true,
                        cursorColor: Colors.purple,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: 'Enter Your Password',
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.03),
                    _isLoading
                        ? const CircularProgressIndicator() // Show a loading spinner when logging in
                        : SizedBox(
                            width: screenSize.width * 0.7,
                            height: screenSize.height * 0.07,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  _loginUser(
                                    emailController.text,
                                    passwordController.text,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "Sign In",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                    SizedBox(height: screenSize.height * 0.01),
                    Row(
                      children: [
                        const Text(
                          ' Don\'t have an account ? ',
                          style: TextStyle(fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Register(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
