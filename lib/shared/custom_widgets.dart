import 'package:flutter/material.dart';

Widget myConditionalBuilder(
    {required bool condition,
    required Widget builder,
    required Widget fallback}) {
  return condition ? builder : fallback;
}

PreferredSizeWidget myAppBar(
    {required String screenTitle,
    required Widget backScreen,
    required BuildContext context}) {
  return AppBar(
    title: Text(
      screenTitle,
    ),
    centerTitle: true,
    elevation: 0,
    leading: IconButton(
      onPressed: () {
        navigateTo(context: context, screen: backScreen);
      },
      icon: Icon(Icons.arrow_back),
    ),
  );
}

Widget productTextFormField(
    {required TextEditingController controller,
    required String validatorReturn,
    required String labelText}) {
  return TextFormField(
    controller: controller,
    validator: (String? value) {
      if (value!.isEmpty) {
        return validatorReturn;
      }
    },
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      labelText: labelText,
    ),
  );
}

Widget defaultButton({required Function() onPressed, required String text}) {
  return MaterialButton(
    onPressed: onPressed,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 24,
        color: Colors.white,
      ),
    ),
    color: Colors.brown,
    padding: const EdgeInsets.all(15),
  );
}

void navigateTo({required BuildContext context, required Widget screen}) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (BuildContext context) => screen));
}

void showToast(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      "Successfully Added",
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.green,
    duration: Duration(milliseconds: 500),
  ));
}
