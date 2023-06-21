import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_app/Admin_Screens/admin_screen.dart';
import 'package:coffee_shop_app/shared/custom_widgets.dart';
import 'package:flutter/material.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({Key? key}) : super(key: key);

  @override
  _UpdateProductScreenState createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  var formKey = GlobalKey<FormState>();

  TextEditingController oldNameController = TextEditingController();

  TextEditingController oldTypeController = TextEditingController();

  TextEditingController uIdController = TextEditingController();

  TextEditingController newNameController = TextEditingController();

  TextEditingController newTypeController = TextEditingController();

  TextEditingController smallPriceController = TextEditingController();

  TextEditingController mediumPriceController = TextEditingController();

  TextEditingController largePriceController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          screenTitle: 'Update Product',
          backScreen: AdminPanel(),
          context: context),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(25),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              productTextFormField(
                controller: uIdController,
                labelText: 'Enter product uId ',
                validatorReturn: 'Value is needed',
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'New Data',
                style: TextStyle(
                  fontSize: 26,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              productTextFormField(
                controller: newNameController,
                labelText: 'Product  name',
                validatorReturn: 'Value is needed',
              ),
              SizedBox(
                height: 20,
              ),
              productTextFormField(
                controller: newTypeController,
                labelText: 'Product Type',
                validatorReturn: 'Value is needed',
              ),
              SizedBox(
                height: 20,
              ),
              productTextFormField(
                controller: smallPriceController,
                labelText: 'small size price',
                validatorReturn: 'Value is needed',
              ),
              SizedBox(
                height: 20,
              ),
              productTextFormField(
                controller: mediumPriceController,
                labelText: 'medium size price',
                validatorReturn: 'Value is needed',
              ),
              SizedBox(
                height: 20,
              ),
              productTextFormField(
                controller: largePriceController,
                labelText: 'large size price',
                validatorReturn: 'Value is needed',
              ),
              SizedBox(
                height: 20,
              ),
              productTextFormField(
                  controller: descriptionController,
                  labelText: 'Product Description',
                  validatorReturn: 'Value is needed'),
              SizedBox(
                height: 20,
              ),
              productTextFormField(
                  controller: imageUrlController,
                  labelText: 'Product image Url',
                  validatorReturn: 'Value is needed'),
              SizedBox(
                height: 20,
              ),
              defaultButton(
                  onPressed: () async {
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "Successfully Updated",
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.green,
                        duration: Duration(milliseconds: 500),
                      ));
                    });

                    await FirebaseFirestore.instance
                        .collection('drinks')
                        .doc('${uIdController.text}')
                        .update({
                      'name': newNameController.text,
                      'type': newNameController.text,
                      'smallPrice': double.parse(smallPriceController.text),
                      'mediumPrice': double.parse(mediumPriceController.text),
                      'largePrice': double.parse(largePriceController.text),
                      'ingredients': descriptionController.text,
                      'imageUrl': imageUrlController.text,
                    });

                    newTypeController.text = '';
                    uIdController.text = '';
                    imageUrlController.text = '';
                    newNameController.text = '';
                    descriptionController.text = '';
                    smallPriceController.text = '';
                    mediumPriceController.text = '';
                    largePriceController.text = '';

                    // await FirebaseFirestore.instance
                    //     .collection('drinks')
                    //     .doc('0')
                    //     .update({
                    //   'name': newNameController.text,
                    //   'type': 'hot drink',
                    //   'smallPrice': double.parse('10'),
                    //   'mediumPrice': double.parse('15'),
                    //   'largePrice': double.parse('20'),
                    //   'ingredients':
                    //       'Hand-pulled espresso and steamed milk meet the richness of pumpkin. Topped with a sprinkling of baking spices for an essential autumn treat.',
                    //   'imageUrl':
                    //       'https://peets-shop.imgix.net/products/pumpkin-latte.png?v=1600894355&auto=format,compress&w=720',
                    // });
                  },
                  text: 'Update Product')
            ],
          ),
        ),
      ),
    );
  }
}
