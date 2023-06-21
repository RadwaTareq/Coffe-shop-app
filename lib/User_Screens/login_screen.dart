import 'package:coffee_shop_app/Admin_Screens/admin_screen.dart';
import 'package:coffee_shop_app/User_Screens/register_screen.dart';
import 'package:coffee_shop_app/User_Screens/user_layout.dart';
import 'package:coffee_shop_app/models/user.dart';
import 'package:coffee_shop_app/shared/database.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool passwordHidden = true;

  IconData passwordIcon = Icons.remove_red_eye_rounded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: 30, top: 80, right: 30),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.brown.withOpacity(0.8),
                      radius: 40,
                      child: Icon(Icons.person, color: Colors.white, size: 40),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: TextFormField(
                        controller: emailController,
                        // controller: EmailController,
                        keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: (String value) {
                          print('Login Successfully');
                        },
                        onChanged: (String value) {
                          print(value);
                        },
                        validator: (emailController) {
                          if (emailController!.isEmpty)
                            return 'Enter your email ,please!';
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.brown.withOpacity(0.6),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelText: 'Email ',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: TextFormField(
                        controller: passwordController,
                        cursorColor: Colors.grey,
                        // controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: passwordHidden,
                        onChanged: (String value) {
                          print(value);
                        },
                        validator: (passwordController) {
                          if (passwordController!.isEmpty)
                            return 'Enter your password ,please!';
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.brown.withOpacity(0.6),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)),
                          labelText: 'Password ',
                          labelStyle: TextStyle(color: Colors.white),
                          // labelStyle: TextStyle.s,
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
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      width: 225,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.brown.withOpacity(1),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          // assert(emailController != null && passwordController != null);
                          if (formKey.currentState!.validate()) {
                            Database.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text)!
                                .then((user) {
                              SnackBar loginSnack = SnackBar(
                                content: Text(
                                  'Login Successfully',
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: Colors.green,
                                duration: Duration(milliseconds: 500),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(loginSnack);
                              print('user Logged in successfully (userLogin)');
                              Database.currentUser = UserModel(user.user!.uid,
                                  user.user!.displayName, user.user!.email);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          UserLayout()));
                            }).catchError((error) {
                              SnackBar loginSnack = SnackBar(
                                content: Text(
                                  'Failed to  login',
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: Colors.red,
                                duration: Duration(milliseconds: 500),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(loginSnack);
                              print('user Failed to login (userLogin)');
                              print(error.toString());
                            });
                          }
                        },
                        splashColor: Colors.white,
                        highlightColor: Colors.white,
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forget Password ?',
                        style: TextStyle(
                          color: Colors.grey.withOpacity(0.6),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Registration()),
                            );
                          },
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      child: Text(
                        'Login to Admin Panel',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (emailController.text ==
                                'seifeldeenmostafa000@gmail.com' &&
                            passwordController.text == 'test1234') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AdminPanel()));
                        }
                      },
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

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
