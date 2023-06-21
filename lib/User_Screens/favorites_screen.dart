import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_app/User_Screens/specific_drink_details_screen.dart';
import 'package:coffee_shop_app/models/drink.dart';
import 'package:coffee_shop_app/models/favorite.dart';
import 'package:coffee_shop_app/models/user.dart';
import 'package:coffee_shop_app/shared/database.dart';
import 'package:flutter/material.dart';

class FavoriteDrinksScreen extends StatefulWidget {
  // const FavoriteDrinksScreen({Key? key}) : super(key: key);

  final UserModel user;
  FavoriteDrinksScreen(this.user);

  @override
  _FavoriteDrinksScreenState createState() => _FavoriteDrinksScreenState();
}

class _FavoriteDrinksScreenState extends State<FavoriteDrinksScreen> {
  List<Drink> favoriteDrinks = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(Database.currentUser.uId)
          .collection('favorites')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        List<Favorite> productNames = [];

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        productNames = snapshot.data!.docs.map((document) {
          return Favorite(document['product name'].toString(), document.id);
        }).toList();

        for (int i = 0; i < productNames.length;) {
          for (int j = 0; j < Database.globalDrinks.length; j++) {
            if (productNames[i].productName == Database.globalDrinks[j].name) {
              favoriteDrinks.add(Database.globalDrinks[j]);
              i++;
              break;
            }
          }
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 20),
            physics: BouncingScrollPhysics(),
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) => favoriteItem(
                  favoriteDrinks[index],
                  productNames[index],
                  widget.user,
                  index),
              separatorBuilder: (BuildContext context, int index) => Divider(
                thickness: 2,
                height: 25,
              ),
              itemCount: productNames.length,
            ),
          ),
        );
      },
    );
  }

  Widget favoriteItem(
      Drink drink, Favorite favorite, UserModel user, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SpecificDrinkDetailsScreen(drink, user)));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25)),
        padding: const EdgeInsets.all(5),
        child: Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) async {
            CollectionReference collectionReference = FirebaseFirestore.instance
                .collection('users')
                .doc(Database.currentUser.uId)
                .collection('favorites');

            await collectionReference.doc(favorite.uId).delete();
            setState(() {});
          },
          background: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.red,
            ),
            child: Row(
              children: [
                Icon(Icons.restore_from_trash),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Delete From \nFavorites',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          secondaryBackground: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.red,
            ),
            child: Row(
              children: [
                Expanded(child: SizedBox()),
                Icon(Icons.restore_from_trash),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Delete From \nFavorites',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(
                      drink.imageUrl,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      drink.name,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[700]),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      drink.ingredients,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[900],
                      ),
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
//
// class Drink {
//   late String imageUrl;
//   late String name;
//   late String description;
//
//   Drink(
//     this.imageUrl,
//     this.name,
//     this.description,
//   );
// }
