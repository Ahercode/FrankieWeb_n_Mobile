import 'package:flutter/cupertino.dart';

/*class ProductSelected {
  String? name;
  double? cost;
  String? description;
  String? picture;

  ProductSelected({this.name, this.cost,this.description,this.picture});
}
*/
class FoodItem {
  int? id;
  String? name;
  String? description;
  double? price;
  String? imgPath;
  int? quantity = 1;
  int? categoryId;
  Location? location;

  DateTime? timestamp;

  FoodItem({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.price,
    @required this.imgPath,
    this.quantity,
    @required this.categoryId,
    this.timestamp,
    this.location,
  });

  FoodItem.fromMapObject(Map<dynamic, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'].toString().trim();
    this.description = map['description'];
    this.price = map['salePrice'];
    this.imgPath = map['image'];
    this.categoryId = map['categoryId'];
    this.location = Location.frommap(map["location"]);

    //this.quantity = map['quantity'];
  }
  void incrementQuantity() {
    this.quantity = this.quantity! + 1;
  }

  void countCartIncrease() {
    // this.count = this.count! + 1;
  }

  void decrementQuantity() {
    this.quantity = this.quantity! - 1;
  }

  void clearList() {
    this.quantity = 0;
  }
}

class Location {
  Location({
    this.id,
    this.name,
    this.address,
    this.telephoneNumber,
    this.mobilePhoneNumber1,
    this.mobilePhoneNumber2,
  });

  int? id;
  String? name;
  String? address;
  String? telephoneNumber;
  String? mobilePhoneNumber1;
  String? mobilePhoneNumber2;

  factory Location.frommap(Map<String, dynamic> map) => Location(
        id: map["id"],
        name: map["name"],
        address: map["address"],
        telephoneNumber: map["telephoneNumber"],
        mobilePhoneNumber1: map["mobilePhoneNumber1"],
        mobilePhoneNumber2: map["mobilePhoneNumber2"],
      );

  Map<String, dynamic> tomap() => {
        "id": id,
        "name": name,
        "address": address,
        "telephoneNumber": telephoneNumber,
        "mobilePhoneNumber1": mobilePhoneNumber1,
        "mobilePhoneNumber2": mobilePhoneNumber2,
      };
}

class FooditemList {
  List<FoodItem>? foodItems;

  FooditemList({@required this.foodItems});
}

FooditemList fooditemList = FooditemList(foodItems: [
  /*FoodItem(
    id: 1,
    name: "Beach BBQ Burger",
    description: "For your pleasure",
    price: 14.49,
    imgPath: "african_food.png",
  ),
  FoodItem(
    id: 2,
    name: "Kick Ass Burgers",
    description: "Eat healthy to stay healthy",
    price: 11.99,
    imgPath: "chinese.png",
  ),
  FoodItem(
    id: 3,
    name: "Supreme Pizza Burger",
    description:
        "This Burger is made from the best elements of the region for your pleasure.",
    price: 8.49,
    imgPath: "continental.png",
  ),
  FoodItem(
    id: 4,
    name: "Chilly Cheeze Burger",
    description:
        "Some delicious variety of Continental food made just for you.",
    price: 14.49,
    imgPath: "Hamburger meal, Zinger Tower.png",
  ),
  FoodItem(
    id: 5,
    name: "Beach BBQ Burger",
    description: "Made by the best just for you",
    price: 14.49,
    imgPath: "lebanese.png",
  ),
  FoodItem(
    id: 6,
    name: "Beach BBQ Burger",
    description: "Eat healthy to stay healthy",
    price: 14.49,
    imgPath: "salad.png",
  ),*/
]);

/*FooditemList fooditemList = FooditemList(foodItems: [
  /*FoodItem(
    id: 1,
    name: "Beach BBQ Burger",
    description: "For your pleasure",
    price: 14.49,
    imgPath: "african_food.png",
  ),
  FoodItem(
    id: 2,
    name: "Kick Ass Burgers",
    description: "Eat healthy to stay healthy",
    price: 11.99,
    imgPath: "chinese.png",
  ),
  FoodItem(
    id: 3,
    name: "Supreme Pizza Burger",
    description:
        "This Burger is made from the best elements of the region for your pleasure.",
    price: 8.49,
    imgPath: "continental.png",
  ),
  FoodItem(
    id: 4,
    name: "Chilly Cheeze Burger",
    description:
        "Some delicious variety of Continental food made just for you.",
    price: 14.49,
    imgPath: "Hamburger meal, Zinger Tower.png",
  ),
  FoodItem(
    id: 5,
    name: "Beach BBQ Burger",
    description: "Made by the best just for you",
    price: 14.49,
    imgPath: "lebanese.png",
  ),
  FoodItem(
    id: 6,
    name: "Beach BBQ Burger",
    description: "Eat healthy to stay healthy",
    price: 14.49,
    imgPath: "salad.png",
  ),*/
]);
*/
class Model with ChangeNotifier {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _amountPaid = TextEditingController();
  final TextEditingController _deliveryCost = TextEditingController();
  final TextEditingController _momoNumber = TextEditingController();
  final TextEditingController _cardNumber = TextEditingController();
  String? _tableNumber, _selectedTab = "Restaurant";
  String _foodCategory = "soups";
  bool _isCash = false, _isMomo = false, _isCard = false;
  String? _totalAmountDue, _totalAmoutDueAndDeliveryCost;
  int _categoryId = 17;
  String _change = "0.0";
  String _cartTotalCount = "2";
  //List<ProductSelected> userChoice = [];
  //List cart = [];

  TextEditingController get username => _username;
  TextEditingController get password => _password;
  TextEditingController get amountPaid => _amountPaid;
  TextEditingController get deliveryCost => _deliveryCost;
  TextEditingController get momoNumber => _momoNumber;
  TextEditingController get cardNumber => _cardNumber;
  String? get tableNumber => _tableNumber;
  String get foodCategory => _foodCategory;
  String? get selectedTab => _selectedTab;
  bool get isCard => _isCard;
  bool get isMomo => _isMomo;
  bool get isCash => _isCash;
  String? get totalAmountDue => _totalAmountDue;
  String? get cartTotalCount => _cartTotalCount;
  String? get totalAmoutDueAndDeliveryCost => _totalAmoutDueAndDeliveryCost;
  String get change => _change;
  int get categoryId => _categoryId;

  // int get value => _categoryId;

  //void addToCart(ProductSelected product) => userChoice.add(product);

  updateCatID(value) async {
    _categoryId = await value;
    notifyListeners();
  }

  changeToGive(value) {
    _change = value.toStringAsFixed(2).toString();
    notifyListeners();
  }

  totalAmount(value) {
    _totalAmountDue = value.toString();
    //notifyListeners();
  }

  cartTotal(value) {
    _cartTotalCount = value.toString();
    //notifyListeners();
  }

  computeTotalAndDelivery(value) {
    _totalAmoutDueAndDeliveryCost = value.toString();
    notifyListeners();
  }

  selectTab(value) {
    _selectedTab = value;
    notifyListeners();
  }

  cardChecked(value) {
    _isCard = value;
    _isCash = false;
    _isMomo = false;
    notifyListeners();
  }

  momoChecked(value) {
    _isMomo = value;
    _isCard = false;
    _isCash = false;
    notifyListeners();
  }

  cashChecked(value) {
    _isCash = value;
    _isMomo = false;
    _isCard = false;
    notifyListeners();
  }

  /*getNewList(newList) {
    _foodName = newList;
    notifyListeners();
  }*/

  openTable(String? currentTableNumber) {
    _tableNumber = currentTableNumber;
    notifyListeners();
  }

  getFoodCategry(value) {
    _foodCategory = value;
    notifyListeners();
  }

  @override
  void dispose() {
    username.clear();
    password.clear();
    amountPaid.clear();
    _change = "0.0";
    _isCash = false;
    _isMomo = false;
    _isCard = false;
    _totalAmountDue = null;
    _totalAmoutDueAndDeliveryCost = null;
    _foodCategory = "soups";
    _categoryId = 17;
    notifyListeners();
  }
}
