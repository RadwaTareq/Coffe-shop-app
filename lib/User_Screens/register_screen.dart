import 'package:coffee_shop_app/User_Screens/login_screen.dart';
import 'package:coffee_shop_app/User_Screens/user_layout.dart';
import 'package:coffee_shop_app/models/user.dart';
import 'package:coffee_shop_app/shared/database.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  var formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  bool passwordHidden = true;
  bool confirmPasswordHidden = true;

  IconData passwordIcon = Icons.remove_red_eye_rounded;
  IconData confirmPasswordIcon = Icons.remove_red_eye_rounded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1587080413959-06b859fb107d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8Y29mZmVlJTIwY3VwfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.brown.withOpacity(0.8),
                      radius: 40,
                      child: Icon(Icons.person, color: Colors.white, size: 40),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.brown.withOpacity(0.8),
                      ),
                      width: 250,
                      height: 50,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: TextFormField(
                        controller: usernameController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Username is needed';
                          }
                        },
                        decoration: InputDecoration(
                          focusColor: Colors.brown,
                          hoverColor: Colors.brown,
                          fillColor: Colors.brown,
                          labelText: 'Username',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.person,
                              color: Colors.white, size: 20.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.brown.withOpacity(0.8)),
                      width: 250.0,
                      height: 50.0,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: TextFormField(
                        controller: emailController,
                        validator: (String? value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Email is needed';
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.email, color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.brown.withOpacity(0.8)),
                      width: 250,
                      height: 50,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: TextFormField(
                        controller: passwordController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Password is needed';
                          }
                        },
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: passwordHidden,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.lock, color: Colors.white),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                if (passwordHidden) {
                                  passwordHidden = false;
                                  passwordIcon = Icons.visibility_off;
                                } else {
                                  passwordHidden = true;
                                  passwordIcon = Icons.remove_red_eye_sharp;
                                }
                              });
                            },
                            icon: Icon(passwordIcon, color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.brown.withOpacity(0.8)),
                      width: 250,
                      height: 50,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: TextFormField(
                        controller: confirmPasswordController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != passwordController.text) {
                            return 'the confirm password do\'t match your password';
                          }
                        },
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: confirmPasswordHidden,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.lock, color: Colors.white),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                if (confirmPasswordHidden) {
                                  confirmPasswordHidden = false;
                                  confirmPasswordIcon = Icons.visibility_off;
                                } else {
                                  confirmPasswordHidden = true;
                                  confirmPasswordIcon =
                                      Icons.remove_red_eye_sharp;
                                }
                              });
                            },
                            icon:
                                Icon(confirmPasswordIcon, color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Center(
                    child: Container(
                      width: 180.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.brown,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Database.userRegister(
                              email: emailController.text,
                              password: passwordController.text,
                              username: usernameController.text,
                            ).then((user) {
                              print('new user registered successfully');
                              Database.createUserWithFavoriteList(
                                  username: usernameController.text,
                                  email: emailController.text,
                                  uId: user.user!.uid);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  "Successfully Registered",
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: Colors.green,
                                duration: Duration(milliseconds: 500),
                              ));

                              Database.currentUser = UserModel(user.user!.uid,
                                  user.user!.displayName, user.user!.email);

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          UserLayout()));
                            }).catchError((error) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  "Failed to Registered",
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: Colors.red,
                                duration: Duration(milliseconds: 500),
                              ));
                              print('fall in error while creating user');
                              print(error.toString());
                            });
                          }
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?',
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.white)),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Login()));
                        },
                        child: Text(
                          'SIGN IN',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
