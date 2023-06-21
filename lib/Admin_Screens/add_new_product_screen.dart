import 'package:coffee_shop_app/Admin_Screens/admin_screen.dart';
import 'package:coffee_shop_app/models/drink.dart';
import 'package:coffee_shop_app/shared/custom_widgets.dart';
import 'package:coffee_shop_app/shared/database.dart';
import 'package:flutter/material.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({Key? key}) : super(key: key);

  @override
  _AddNewProductScreenState createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  var formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  TextEditingController typeController = TextEditingController();

  TextEditingController uIdController = TextEditingController();

  TextEditingController imageUrlController = TextEditingController();

  TextEditingController smallPriceController = TextEditingController();

  TextEditingController mediumPriceController = TextEditingController();

  TextEditingController largePriceController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          screenTitle: 'Add New Product',
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
                controller: nameController,
                labelText: 'Product Name',
                validatorReturn: 'value is needed',
              ),
              SizedBox(
                height: 20,
              ),
              productTextFormField(
                controller: typeController,
                labelText: 'Product Type',
                validatorReturn: 'value is needed',
              ),
              SizedBox(
                height: 20,
              ),
              productTextFormField(
                controller: uIdController,
                labelText: 'uId',
                validatorReturn: 'value is needed',
              ),
              SizedBox(
                height: 20,
              ),
              productTextFormField(
                controller: imageUrlController,
                labelText: 'Product image url',
                validatorReturn: 'value is needed',
              ),
              SizedBox(
                height: 20,
              ),
              productTextFormField(
                controller: smallPriceController,
                labelText: 'small size price',
                validatorReturn: 'value is needed',
              ),
              SizedBox(
                height: 20,
              ),
              productTextFormField(
                controller: mediumPriceController,
                labelText: 'medium size price',
                validatorReturn: 'value is needed',
              ),
              SizedBox(
                height: 20,
              ),
              productTextFormField(
                controller: largePriceController,
                labelText: 'large size price',
                validatorReturn: 'value is needed',
              ),
              SizedBox(
                height: 20,
              ),
              productTextFormField(
                controller: descriptionController,
                labelText: 'Product Description',
                validatorReturn: 'value is needed',
              ),
              SizedBox(
                height: 20,
              ),
              defaultButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    Drink d = new Drink(
                      uId: uIdController.text,
                      type: typeController.text,
                      imageUrl: imageUrlController.text,
                      name: nameController.text,
                      ingredients: descriptionController.text,
                      smallPrice: double.parse(smallPriceController.text),
                      mediumPrice: double.parse(mediumPriceController.text),
                      largePrice: double.parse(largePriceController.text),
                    );
                    await Database.addNewProduct(drink: d);

                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "Successfully Added",
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.green,
                        duration: Duration(milliseconds: 500),
                      ));
                    });

                    typeController.text = '';
                    uIdController.text = '';
                    imageUrlController.text = '';
                    nameController.text = '';
                    descriptionController.text = '';
                    smallPriceController.text = '';
                    mediumPriceController.text = '';
                    largePriceController.text = '';
                  }
                },
                text: 'Add Product',
              ),
            ],
          ),
        ),
      ),
    );
  }
  //
}
