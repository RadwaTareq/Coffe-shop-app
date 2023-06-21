import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_app/Admin_Screens/add_new_product_screen.dart';
import 'package:coffee_shop_app/Admin_Screens/update_product_screen.dart';
import 'package:coffee_shop_app/shared/custom_widgets.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  bool deletePressed = false;
  TextEditingController uIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Panel',
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GridView.count(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 0,
                children: [
                  adminButton(
                      onPressed: () {
                        print('Add New Product');
                        navigateTo(
                            context: context, screen: AddNewProductScreen());
                      },
                      iconData: Icons.add_box_rounded,
                      buttonText: 'Add new\n Product'),
                  adminButton(
                      onPressed: () {
                        print('Delete Button Pressed');
                        setState(() {
                          deletePressed = true;
                        });
                      },
                      iconData: Icons.delete,
                      buttonText: 'Delete Product'),
                  adminButton(
                      onPressed: () {
                        print('Update Product');
                        navigateTo(
                            context: context, screen: UpdateProductScreen());
                      },
                      iconData: Icons.update,
                      buttonText: 'Update product\n data'),
                ],
              ),
            ],
          ),
          myConditionalBuilder(
            condition: deletePressed,
            builder: deleteScreen(),
            fallback: SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget adminButton(
      {required Function() onPressed,
      required IconData iconData,
      required String buttonText}) {
    return MaterialButton(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            width: 5,
            color: Colors.brown,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              size: 50,
              color: Colors.brown,
            ),
            Text(
              buttonText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, color: Colors.brown),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteScreen() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black26,
      child: Container(
        width: 300,
        height: 300,
        child: AlertDialog(
          scrollable: true,
          insetPadding: const EdgeInsets.all(10),
          title: Text(
            'Delete Product',
            style: TextStyle(fontSize: 28),
            textAlign: TextAlign.center,
          ),
          elevation: 0,
          content: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              productTextFormField(
                controller: uIdController,
                labelText: 'Product UId',
                validatorReturn: 'value is needed',
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  defaultButton(
                      onPressed: () {
                        print('cancel pressed');
                        setState(() {
                          deletePressed = !deletePressed;
                        });
                      },
                      text: 'Cancel'),
                  defaultButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('drinks')
                            .doc('${uIdController.text}')
                            .delete();

                        setState(() {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Successfully Deleted",
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.green,
                            duration: Duration(milliseconds: 500),
                          ));
                          deletePressed = false;
                          uIdController.text = '';
                        });
                      },
                      text: 'Delete'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
