import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_app/models/drink.dart';
import 'package:coffee_shop_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  static late UserModel currentUser;

  static List<Drink> globalDrinks = [];

  static List<String> favoriteItemsNames = [];

  static List<Drink> hotDrinks = [];

  static List<Drink> coldDrinks = [];

  static List<Drink> desserts = [];

  static List<Drink> addingList = [
    Drink(
        uId: '0',
        type: 'hot drink',
        imageUrl:
            'https://peets-shop.imgix.net/products/pumpkin-latte.png?v=1600894355&auto=format,compress&w=720',
        name: 'PUMPKIN LATTE',
        ingredients:
            'Hand-pulled espresso and steamed milk meet the richness of pumpkin. Topped with a sprinkling of baking spices for an essential autumn treat.',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '1',
        type: 'hot drink',
        imageUrl:
            'https://peets-shop.imgix.net/products/caffe-mocha.png?v=1597269393&auto=format,compress&w=720',
        name: 'CAFFE MOCHA',
        ingredients:
            'Chocolate and espresso meet for the ultimate indulgence. Rich espresso and house-made chocolate sauce rendezvous with creamy steamed milk under a blanket of fresh whipped cream.',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '2',
        type: 'hot drink',
        imageUrl:
            'https://peets-shop.imgix.net/products/caramel-macchiato.png?v=1597269393&auto=format,compress&w=720',
        name: 'CARAMEL MACCHIATO',
        ingredients:
            'For a sweet, smooth pairing, we brought together a Latte Macchiato with buttery caramel. A hand-pulled ristretto (short shot) swirls with caramel syrup before being added to silky steamed milk.',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '3',
        type: 'hot drink',
        imageUrl:
            'https://peets-shop.imgix.net/products/caffe-latte.png?v=1597269391&auto=format,compress&w=720',
        name: 'CAFFE LATTE',
        ingredients:
            '''The word "latte" means "milk" in Italian. In our Caffe Latte, milk rounds out espresso's assertive flavors in a soft, enjoyable drink. Rich, hand-pulled Espresso Forte meets smooth steamed milk, topped with a layer of silky foam.''',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '4',
        type: 'hot drink',
        imageUrl:
            'https://peets-shop.imgix.net/products/chai-latte.png?v=1597269392&auto=format,compress&w=720',
        name: 'CHAI LATTE',
        ingredients:
            'Our Masala Chai latte is Peets take on a traditional Indian cup. Our own blend of teas and spices, lightly sweetened, with steamed milk.',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '5',
        type: 'hot drink',
        imageUrl:
            'https://peets-shop.imgix.net/products/havana-cappuccino.png?v=1597269390&auto=format,compress&w=720',
        name: 'HAVANA CAPPUCCINO',
        ingredients:
            '''Sweet, bold, and lightly spiced, our Havana Cappuccino begins with hand-pulled Espresso Forte and sweetened condensed milk. They're swirled together before being topped with creamy steamed milk and a hint of cinnamon.''',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '6',
        type: 'hot drink',
        imageUrl:
            'https://peets-shop.imgix.net/products/cappuccino.png?v=1597269390&auto=format,compress&w=720',
        name: 'CAPPUCCINO',
        ingredients:
            '''This coffee-forward classic has just two ingredients, but requires the utmost barista skill. We hand-pull a perfect espresso and marble it with creamy microfoam (thick steamed milk), stretching the espresso's caramel notes and providing a smooth texture.''',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '7',
        type: 'hot drink',
        imageUrl:
            'https://peets-shop.imgix.net/products/caffe-americano.png?v=1597269387&auto=format,compress&w=720',
        name: 'AMERICANO',
        ingredients:
            'An Americano is two ingredients: espresso and hot water. When rich, hand-pulled Espresso Forte is poured into hot water, you retain the perfect crema in a pleasantly sippable cup with notes of malty hazelnut.',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '8',
        type: 'hot drink',
        imageUrl:
            'https://peets-shop.imgix.net/products/espresso.png?v=1597269388&auto=format,compress&w=720',
        name: 'ESPRESSO',
        ingredients:
            'Hand-pulled Espresso Forte blend delivers rich layers of flavor and perfect crema. Opening notes of hazelnut are followed by caramel and citrus zest',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '9',
        type: 'cold drink',
        imageUrl:
            'https://peets-shop.imgix.net/products/original-cold-brew-oat-latte_4ef106f6-9a2a-4b44-b6b6-de4702cd28df.png?v=1625017976&auto=format,compress&w=720',
        name: 'HONEY COLD BREW OAT LATTE',
        ingredients:
            'Golden honey syrup in creamy oat milk lightens up deep, dark cold brew, poured over ice for a chill summertime treat.',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '10',
        type: 'cold drink',
        imageUrl:
            'https://peets-shop.imgix.net/products/iced-maple-spiced-latte.png?v=1600894474&auto=format,compress&w=72',
        name: 'ICED MAPLE LATTE',
        ingredients:
            'Hand-pulled espresso and steamed milk meet the seasonal sweetness of maple, and served over ice.',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '11',
        type: 'cold drink',
        imageUrl:
            'https://peets-shop.imgix.net/products/ColdWebDrinksNew.png?v=1629831838&auto=format,compress&w=720',
        name: 'PUMPKIN OAT FOAM COLD BREW',
        ingredients:
            'A luscious layer of airy, pumpkin pie-spiced oat milk microfoam rests atop smooth and refreshing Baridi cold brew, for a sweet and quenching beverage without acidity or bitterness.',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '12',
        type: 'cold drink',
        imageUrl:
            'https://peets-shop.imgix.net/products/iced-vanilla-latte_53c95316-1873-43b7-9e10-08992e375eae.png?v=1625018131&auto=format,compress&w=720',
        name: 'CHOCOLATE COLD BREW OAT LATTE',
        ingredients:
            'Fudgy chocolate sauce in creamy oat milk boosts the boldness of icy cold brew, for a cool-down that sweetens up even the brightest days.',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '13',
        type: 'cold drink',
        imageUrl:
            'https://peets-shop.imgix.net/products/mocha-blended-iced_4a68ef2a-fc4d-46a4-9d56-caf25adc065f.png?v=1622071618&auto=format,compress&w=720',
        name: 'MOCHA FRAPPÉ',
        ingredients:
            '''Double-strength Baridi Cold Brew and Peet's housemade chocolate sauce are whipped with milk and ice for sweet refreshment topped with whipped cream.''',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '14',
        type: 'cold drink',
        imageUrl:
            'https://peets-shop.imgix.net/products/caramel-blended-iced_fe4adba1-db6a-4c3b-9fe4-655cc68d5482.png?v=1622071311&auto=format,compress&w=720',
        name: 'CARAMEL FRAPPÉ',
        ingredients:
            'Rich caramel adds some indulgence to our double-strength Baridi Blend cold brew. We top this coffee-forward whipped refreshment with whipped cream and a drizzle of caramel sauce.',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '15',
        type: 'cold drink',
        imageUrl:
            'https://peets-shop.imgix.net/products/iced-white-mocha.png?v=1597269394&auto=format,compress&w=720',
        name: 'ICED WHITE CHOCOLATE MOCHA',
        ingredients:
            'An icy cold take on our decadent White Chocolate Mocha. Smooth white chocolate and rich espresso meet cold milk, ice foam, and a dollop of whipped cream.',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '16',
        type: 'cold drink',
        imageUrl:
            'https://peets-shop.imgix.net/products/iced-espresso.png?v=1597269389&auto=format,compress&w=720',
        name: 'ICED ESPRESSO',
        ingredients:
            'When hand-pulled Espresso Forte blend is poured over ice, the result is a bold and refreshing drink with notes of caramel and citrus zest',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '17',
        type: 'cold drink',
        imageUrl:
            'https://peets-shop.imgix.net/products/iced-havana-cappuccino.png?v=1597269391&auto=format,compress&w=720',
        name: 'ICED HAVANA CAPPUCCINO',
        ingredients:
            'A cold, refreshing take on our Havana Cappuccino. Rich espresso, sweetened condensed milk, and cold milk poured over ice and fresh foam. Finished with a dash of cinnamon for a hint of spice.',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '18',
        type: 'cold drink',
        imageUrl:
            'https://peets-shop.imgix.net/products/iced-caffe-mocha.png?v=1597269393&auto=format,compress&w=720',
        name: 'ICED CAFFÈ MOCHA',
        ingredients:
            'Indulgence, served cold. Our rich espresso and house-made chocolate syrup swirl with cold milk in a bath of ice and foam before being topped with whipped cream.',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '19',
        type: 'dessert',
        imageUrl:
            'https://sugarspunrun.com/wp-content/uploads/2019/01/Best-Cheesecake-Recipe-2-1-of-1-4.jpg',
        name: 'Cheese cake',
        ingredients: 'non',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '20',
        type: 'dessert',
        imageUrl:
            'https://www.cookingclassy.com/wp-content/uploads/2019/10/chocolate-cake-3.jpg',
        name: 'Chocolate cake',
        ingredients: 'non',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '21',
        type: 'dessert',
        imageUrl:
            'https://images.herzindagi.info/image/2020/Jun/chocolate-parle-g-ice-cream.jpg',
        name: 'Ice cream',
        ingredients: 'non',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '22',
        type: 'dessert',
        imageUrl:
            'https://kristineskitchenblog.com/wp-content/uploads/2021/04/apple-pie-1200-square-592-2.jpg',
        name: 'Apple pie',
        ingredients: 'non',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '23',
        type: 'dessert',
        imageUrl:
            'https://i2.wp.com/lmld.org/wp-content/uploads/2020/08/Lemon-Loaf-6.jpg',
        name: 'Iced lemon pound cake',
        ingredients: 'non',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '24',
        type: 'dessert',
        imageUrl:
            'https://www.kitchentrials.com/wp-content/uploads/2018/02/Salted-Caramel-Bakery-Cake-recipe.jpg',
        name: 'salted caramel cake',
        ingredients: 'non',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '25',
        type: 'dessert',
        imageUrl:
            'https://www.spendwithpennies.com/wp-content/uploads/2019/06/classic-cinnamon-coffee-cake-1.jpg',
        name: 'classic coffee cake',
        ingredients: 'non',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '26',
        type: 'dessert',
        imageUrl:
            'https://d3lbhvavid9616.cloudfront.net/assets/products/54516/1601484371970.jpg',
        name: 'morning bun',
        ingredients: 'non',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
    Drink(
        uId: '27',
        type: 'dessert',
        imageUrl:
            'https://www.spendwithpennies.com/wp-content/uploads/2020/08/Blueberry-Scones-SpendWithPennies-13.jpg',
        name: 'blueberry scones',
        ingredients: 'non',
        smallPrice: 10,
        mediumPrice: 10,
        largePrice: 10),
  ];

  static bool homePageFirstTime = true;

  static Future<void> addNewProduct({required Drink drink}) async {
    await FirebaseFirestore.instance.collection('drinks').doc(drink.uId).set({
      'imageUrl': drink.imageUrl,
      'ingredients': drink.ingredients,
      'type': drink.type,
      'name': drink.name,
      'smallPrice': drink.smallPrice,
      'mediumPrice': drink.mediumPrice,
      'largePrice': drink.largePrice,
    });
  }

  static void addOnce() {
    addingList.forEach((drink) {
      FirebaseFirestore.instance.collection('drinks').add({
        'imageUrl': drink.imageUrl,
        'ingredients': drink.ingredients,
        'type': drink.type,
        'name': drink.name,
        'smallPrice': drink.smallPrice,
        'mediumPrice': drink.mediumPrice,
        'largePrice': drink.largePrice,
      }).then((value) {});
    });
  }

  static void addMessage({required String message}) {
    FirebaseFirestore.instance.collection('reviews').add({
      'message': message,
    }).then((value) {
      print('A new Reviewing message added successfully');
    });
  }

  static updateDate(String id, String key, String value) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('drinks');

    await collectionReference.doc('$id').update({'$key': '$value'});
  }

  static Future<UserCredential>? userLogin(
      {required String email, required String password}) async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  static void userLogOut() {
    FirebaseAuth.instance.signOut();
  }

  static Future<UserCredential> userRegister({
    required String email,
    required String password,
    required String username,
  }) async {
    return await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  static void userCreate(
      {required String name, required String email, required String uId}) {
    UserModel model = UserModel(uId, name, email);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      print('new user created successfully');
    }).catchError((error) {
      print(error.toString());
    });
  }

  static void createUserWithFavoriteList(
      {required String email, required String username, required String uId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set({'email': email, 'username': username, 'favorites': {}});
  }

  static void addProductToFavoritesList({String? uId, required String name}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('favorites')
        .add({'product name': name});
  }

  // Updates to the app

  // 1- To add values to a table and choosing the uid of the row
  static Future<void> addValueToTable(
      {required String tableName,
      required String rowUId,
      required String imageUrl,
      required String ingredients,
      required String type,
      required String name,
      required double smallPrice,
      required double mediumPrice,
      required double largePrice}) async {
    await FirebaseFirestore.instance.collection(tableName).doc(rowUId).set({
      'imageUrl': imageUrl,
      'ingredients': ingredients,
      'type': type,
      'name': name,
      'smallPrice': smallPrice,
      'mediumPrice': mediumPrice,
      'largePrice': largePrice,
    });

    // await FirebaseFirestore.instance.collection('drinks').doc('505050').set({
    //   'imageUrl': 'plapla',
    //   'ingredients': 'plapla',
    //   'type': 'plapla',
    //   'name': 'plapla',
    //   'smallPrice': 10,
    //   'mediumPrice': 15,
    //   'largePrice': 20,
    // });
  }

  // 2- Adding list of values to Table and sorted uId

  static Future<void> addListOfValuesOnce(
      {required List<Drink> myList, required String tableName}) async {
    for (int i = 0; i < myList.length; i++) {
      await addValueToTable(
          tableName: tableName,
          rowUId: myList[i].uId,
          imageUrl: myList[i].imageUrl,
          ingredients: myList[i].ingredients,
          type: myList[i].type,
          name: myList[i].name,
          smallPrice: 10,
          mediumPrice: 15,
          largePrice: 20);
    }

    // for (int i = 0; i < Database.addingList.length; i++) {
    //   await Database.addValue(
    //       tableName: 'drinks',
    //       rowUId: i.toString(),
    //       imageUrl: Database.addingList[i].imageUrl,
    //       ingredients: Database.addingList[i].ingredients,
    //       type: Database.addingList[i].type,
    //       name: Database.addingList[i].name,
    //       smallPrice: 10,
    //       mediumPrice: 15,
    //       largePrice: 20);
    // }
  }
}
