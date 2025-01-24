import 'package:commcart/firebase_services/authentication.dart';
import 'package:commcart/firebase_services/authentication_google.dart';
import 'package:commcart/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class loginIn extends StatefulWidget {
  const loginIn({super.key});

  @override
  State<loginIn> createState() => _loginInState();
}

class _loginInState extends State<loginIn> {
  bool _isObscure = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              // Background Image
              Positioned.fill(
                  child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      const Color.fromARGB(0, 254, 254, 254)
                    ], // Define gradient colors
                    begin: Alignment.topLeft, // Start position of the gradient
                    end: Alignment.bottomRight, // End position of the gradient
                  ),
                ),
              )),

              // Content on top of the image
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.0,
                    MediaQuery.of(context).size.height * 0.00,
                    0,
                    MediaQuery.of(context).size.height * 0.05),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.12,
                          MediaQuery.of(context).size.height * 0.07,
                          0,
                          MediaQuery.of(context).size.height * 0.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'ComM',
                            style: TextStyle(
                                fontSize: 50,
                                color: Colors.white70,
                                fontWeight: FontWeight.w900),
                          ),
                          Text('Cart',
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w900,
                                  color: const Color.fromARGB(255, 27, 2, 95)))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0,
                          MediaQuery.of(context).size.height * 0.070,
                          0,
                          MediaQuery.of(context).size.height * 0.25),
                      child: Center(
                          child: Container(
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: Card(
                          color: const Color.fromARGB(255, 16, 0, 59)
                              .withOpacity(0.4),
                          elevation: 0,
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.05,
                                      MediaQuery.of(context).size.height * 0.02,
                                      MediaQuery.of(context).size.width * 0.05,
                                      MediaQuery.of(context).size.width * 0.05),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: TextFormField(
                                          validator: (value) {
                                            value!.isEmpty
                                                ? "Email can't be empty"
                                                : null;
                                          },
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                              fillColor: const Color.fromARGB(
                                                  255, 13, 13, 13),
                                              hintText: 'email address',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              label: Text('Email')),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: TextFormField(
                                          validator: (value) {
                                            value!.isEmpty
                                                ? "Password can't be empty"
                                                : null;
                                          },
                                          obscureText: _isObscure,
                                          controller: _passwordController,
                                          decoration: InputDecoration(
                                              fillColor: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                              hintText: 'Password',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              labelText: 'Password',
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _isObscure = !_isObscure;
                                                    // Toggle the obscure text state
                                                  });
                                                },
                                                icon: Icon(
                                                  _isObscure
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                ),
                                              )),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 5, 0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (Builder) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              'Reset yout password'),
                                                          content: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                TextFormField(
                                                                  controller:
                                                                      _emailController,
                                                                  decoration: InputDecoration(
                                                                      errorBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: Colors
                                                                                  .red)),
                                                                      fillColor: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          210,
                                                                          209,
                                                                          209),
                                                                      hintText:
                                                                          'email address',
                                                                      border:
                                                                          OutlineInputBorder(),
                                                                      label: Text(
                                                                          'Email')),
                                                                )
                                                              ]),
                                                          actions: [
                                                            TextButton(
                                                              child: Text(
                                                                  'cancel'),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                            TextButton(
                                                                onPressed: () {
                                                                  if (_emailController
                                                                      .text
                                                                      .isNotEmpty) {
                                                                    AuthService()
                                                                        .resetPassword(_emailController
                                                                            .text)
                                                                        .then(
                                                                            (value) {
                                                                      if (value ==
                                                                          'Mail sent') {
                                                                        Navigator.pop(
                                                                            context);
                                                                        ScaffoldMessenger(
                                                                            child:
                                                                                SnackBar(content: Text("Password Reset Email sent")));
                                                                      } else {
                                                                        ScaffoldMessenger(
                                                                            child:
                                                                                SnackBar(
                                                                          backgroundColor: const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              228,
                                                                              89,
                                                                              2),
                                                                          content:
                                                                              Text("account not found"),
                                                                          showCloseIcon:
                                                                              true,
                                                                        ));
                                                                      }
                                                                    });
                                                                  } else {
                                                                    ScaffoldMessenger(
                                                                        child: SnackBar(
                                                                            backgroundColor: const Color.fromARGB(
                                                                                255,
                                                                                225,
                                                                                59,
                                                                                48),
                                                                            content:
                                                                                Text("Invalid email")));
                                                                  }
                                                                },
                                                                child: Text(
                                                                    'submit'))
                                                          ],
                                                        );
                                                      });
                                                },
                                                child: Text(
                                                    'Forgot Password?  ',
                                                    style: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 27, 2, 95),
                                                    )),
                                              ))
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                      ),
                                      Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 27, 2, 95),
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.55,
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            150))),
                                            onPressed: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                AuthService()
                                                    .loginWithEmail(
                                                        _emailController.text,
                                                        _passwordController
                                                            .text)
                                                    .then((value) {
                                                  if (value ==
                                                      'Login Succesful') {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                'signIn succesful')));
                                                    Navigator
                                                        .restorablePushNamedAndRemoveUntil(
                                                            context,
                                                            '/home',
                                                            (route) => false);
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                        value,
                                                        style: TextStyle(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                255, 255, 255)),
                                                      ),
                                                      backgroundColor:
                                                          Colors.redAccent,
                                                    ));
                                                  }
                                                });
                                              }
                                            },
                                            child: Center(
                                              child: Text(
                                                'Sign In',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.025,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Divider(
                                              thickness: 1.5,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                9, 0, 9, 0),
                                            child: Text(
                                              'Continue with',
                                              style: TextStyle(
                                                  color: Colors.blue[600]),
                                            ),
                                          ),
                                          Expanded(
                                            child: Divider(
                                              thickness: 1.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          signInWithGoogle().then(
                                            (value) => {if (value != null) {}},
                                          );
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.08,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(0)),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(0)),
                                            elevation: 5,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Image.network(
                                                    'https://cdn-icons-png.flaticon.com/256/2875/2875404.png',
                                                  ),
                                                ),
                                                Text(
                                                  ' Continue With Google',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.1,
                                      0,
                                      0,
                                      0),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/signUp');
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "Don't have one?",
                                              style: TextStyle(
                                                color: Colors.white60,
                                              ),
                                            ),
                                            GestureDetector(
                                              child: Text(
                                                '  Create New',
                                                style: TextStyle(
                                                    color: const Color.fromARGB(
                                                        255, 27, 2, 95),
                                                    fontWeight:
                                                        FontWeight.w900),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
