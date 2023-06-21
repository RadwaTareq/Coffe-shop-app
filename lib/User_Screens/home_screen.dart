import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_app/User_Screens/specific_drink_details_screen.dart';
import 'package:coffee_shop_app/models/drink.dart';
import 'package:coffee_shop_app/models/user.dart';
import 'package:coffee_shop_app/shared/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  // const HomeScreen({Key? key}) : super(key: key);

  final UserModel user;

  HomeScreen(this.user);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                Image(
                  image: NetworkImage(
                    "https://img.freepik.com/free-photo/top-view-cup-coffee-with-copy-space_23-2148336691.jpg?size=626&ext=jpg",
                  ),
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 20.0,
                        top: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi,User",
                            style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            "A good day Starts with a \n good coffee, How do you \n want to start your day ?",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.yellow),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('drinks').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                Database.globalDrinks = snapshot.data!.docs.map((document) {
                  return new Drink(
                    uId: document.id,
                    name: document['name'],
                    type: document['type'],
                    imageUrl: document['imageUrl'],
                    ingredients: document['ingredients'],
                    smallPrice: double.parse(document['smallPrice'].toString()),
                    mediumPrice:
                        double.parse(document['mediumPrice'].toString()),
                    largePrice: double.parse(document['largePrice'].toString()),
                  );
                }).toList();

                // for (int i = 0; i < Database.globalDrinks.length; i++) {
                //   print(i);
                //   print(Database.globalDrinks);
                //   if (Database.globalDrinks[i].type.toLowerCase() ==
                //       'hot drink') {
                //     Database.hotDrinks.add(Database.globalDrinks[i]);
                //   } else if (Database.globalDrinks[i].type.toLowerCase() ==
                //       'cold drink') {
                //     Database.coldDrinks.add(Database.globalDrinks[i]);
                //   } else if (Database.globalDrinks[i].type.toLowerCase() ==
                //       'dessert') {
                //     Database.desserts.add(Database.globalDrinks[i]);
                //   }
                // }
                if (Database.homePageFirstTime) {
                  Database.homePageFirstTime = false;
                  Database.globalDrinks.forEach((element) {
                    if (element.type.toLowerCase() == 'hot drink') {
                      Database.hotDrinks.add(element);
                    } else if (element.type.toLowerCase() == 'cold drink') {
                      Database.coldDrinks.add(element);
                    } else if (element.type.toLowerCase() == 'dessert') {
                      Database.desserts.add(element);
                    }
                  });
                }

                return ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Text(
                        "Hot Coffees : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 191,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => buildProduct(
                                drink: Database.hotDrinks[index],
                                user: widget.user),
                            separatorBuilder: (context, index) => SizedBox(
                                  width: 20.0,
                                ),
                            itemCount: Database.hotDrinks.length),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Ice Coffees : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 191,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => buildProduct(
                              drink: Database.coldDrinks[index],
                              user: widget.user),
                          separatorBuilder: (context, index) => SizedBox(
                            width: 20.0,
                          ),
                          itemCount: Database.coldDrinks.length,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: Text(
                        "Dessert : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      height: 191,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => buildProduct(
                              drink: Database.desserts[index],
                              user: widget.user),
                          separatorBuilder: (context, index) => SizedBox(
                            width: 20.0,
                          ),
                          itemCount: Database.desserts.length,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProduct({required Drink drink, required UserModel user}) =>
      GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SpecificDrinkDetailsScreen(drink, user)));
        },
        child: Container(
          height: 195,
          width: 170,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    width: 100,
                    height: 100,
                    image: NetworkImage(drink.imageUrl),
                    fit: BoxFit.cover,
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.volunteer_activism,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        drink.mediumPrice.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.greenAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  drink.name,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );

  // Widget Build_iced_products({required Drink drink}) => Container(
  //       height: 191,
  //       width: 170,
  //       padding: const EdgeInsets.all(20.0),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(25.0),
  //         color: Colors.white,
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Stack(
  //             children: [
  //               Image(
  //                 width: 100,
  //                 height: 80,
  //                 image: NetworkImage(drink.imageUrl),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 100.0),
  //                 child: IconButton(
  //                     onPressed: () {},
  //                     icon: Icon(
  //                       Icons.volunteer_activism,
  //                       color: Colors.grey,
  //                     )),
  //               )
  //             ],
  //           ),
  //           SizedBox(
  //             height: 5,
  //           ),
  //           Stack(
  //             children: [
  //               Text(
  //                 drink.name,
  //                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 100),
  //                 child: Text(
  //                   drink.mediumPrice.toString(),
  //                   style: TextStyle(
  //                     fontSize: 22,
  //                     color: Colors.greenAccent,
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //           Text(
  //             drink.ingredients,
  //             maxLines: 2,
  //             overflow: TextOverflow.ellipsis,
  //             style: TextStyle(
  //               fontSize: 16,
  //               color: Colors.grey,
  //             ),
  //           ),
  //           SizedBox(
  //             height: 5,
  //           ),
  //         ],
  //       ),
  //     );
}
