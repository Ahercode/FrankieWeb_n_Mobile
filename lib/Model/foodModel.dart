// import 'dart:convert';

// import 'package:flutter/Material.dart';

// // List<Product> ProductFrommap(String str) =>
// //     List<Product>.from(map.decode(str).map((x) => Product.frommap(x)));

// // String ProductTomap(List<Product> data) =>
// //     map.encode(List<dynamic>.from(data.map((x) => x.tomap())));

// class Product {
//   int? id;
//   String? code;
//   String? name;
//   String? description;
//   int? costPrice;
//   int? quantity;
//   double? price;
//   String? imgPath;
//   int? categoryId;
//   Category? category;
//   Location? location;
//   DateTime? timestamp;

//   Product({
//     this.id,
//     this.code,
//     this.name,
//     this.description,
//     this.price,
//     this.quantity,
//     this.imgPath,
//     this.categoryId,
//     this.category,
//     this.location,
//   });

//   factory Product.fromMapObject(Map<dynamic, dynamic> map) => Product(
//         id: map["id"],
//         code: map["code"],
//         name: map["name"],
//         description: map["description"],
//         price: map["price"],
//         quantity: map["quantity"],
//         imgPath: map["imgPath"],
//         categoryId: map["categoryId"],
//         category: Category.frommap(map["category"]),
//         location: Location.frommap(map["location"]),
//       );

//   Map<String, dynamic> tomap() => {
//         "id": id,
//         "code": code,
//         "name": name,
//         "description": description,
//         "price": price,
//         "quantity": quantity,
//         "imgPath": imgPath,
//         "categoryId": categoryId,
//         "category": category!.tomap(),
//         "location": location!.tomap(),
//       };

//   void incrementQuantity() {
//     this.quantity = this.quantity! + 1;
//   }

//   void decrementQuantity() {
//     this.quantity = this.quantity! - 1;
//   }

//   void clearList() {
//     this.quantity = 0;
//   }
// }

// class Category {
//   Category({
//     this.id,
//     this.name,
//     this.descriptoin,
//     this.imgPath,
//   });

//   int? id;
//   String? name;
//   String? descriptoin;
//   String? imgPath;

//   factory Category.frommap(Map<String, dynamic> map) => Category(
//         id: map["id"],
//         name: map["name"],
//         descriptoin: map["descriptoin"],
//         imgPath: map["imgPath"],
//       );

//   Map<String, dynamic> tomap() => {
//         "id": id,
//         "name": name,
//         "descriptoin": descriptoin,
//         "imgPath": imgPath,
//       };
// }

// class Location {
//   Location({
//     this.id,
//     this.name,
//     this.address,
//     this.telephoneNumber,
//     this.mobilePhoneNumber1,
//     this.mobilePhoneNumber2,
//   });

//   int? id;
//   String? name;
//   String? address;
//   String? telephoneNumber;
//   String? mobilePhoneNumber1;
//   String? mobilePhoneNumber2;

//   factory Location.frommap(Map<String, dynamic> map) => Location(
//         id: map["id"],
//         name: map["name"],
//         address: map["address"],
//         telephoneNumber: map["telephoneNumber"],
//         mobilePhoneNumber1: map["mobilePhoneNumber1"],
//         mobilePhoneNumber2: map["mobilePhoneNumber2"],
//       );

//   Map<String, dynamic> tomap() => {
//         "id": id,
//         "name": name,
//         "address": address,
//         "telephoneNumber": telephoneNumber,
//         "mobilePhoneNumber1": mobilePhoneNumber1,
//         "mobilePhoneNumber2": mobilePhoneNumber2,
//       };
// }

// class ProductList {
//   List<Product>? products;
//   ProductList({@required this.products});
// }

// ProductList productList = ProductList(products: []);

// class ProductModel with ChangeNotifier {
//   final TextEditingController _username = TextEditingController();
//   final TextEditingController _password = TextEditingController();
//   final TextEditingController _amountPaid = TextEditingController();
//   final TextEditingController _deliveryCost = TextEditingController();
//   final TextEditingController _momoNumber = TextEditingController();
//   final TextEditingController _cardNumber = TextEditingController();
//   String? _tableNumber, _selectedTab = "Restaurant";
//   String _foodCategory = "soups";
//   bool _isCash = false, _isMomo = false, _isCard = false;
//   String? _totalAmountDue, _totalAmoutDueAndDeliveryCost;
//   int _categoryId = 17;
//   String _change = "0.0";
//   String? _cartTotalCount;
//   //List<ProductSelected> userChoice = [];
//   //List cart = [];

//   TextEditingController get username => _username;
//   TextEditingController get password => _password;
//   TextEditingController get amountPaid => _amountPaid;
//   TextEditingController get deliveryCost => _deliveryCost;
//   TextEditingController get momoNumber => _momoNumber;
//   TextEditingController get cardNumber => _cardNumber;
//   String? get tableNumber => _tableNumber;
//   String get foodCategory => _foodCategory;
//   String? get selectedTab => _selectedTab;
//   bool get isCard => _isCard;
//   bool get isMomo => _isMomo;
//   bool get isCash => _isCash;
//   String? get totalAmountDue => _totalAmountDue;
//   String? get cartTotalCount => _cartTotalCount;
//   String? get totalAmoutDueAndDeliveryCost => _totalAmoutDueAndDeliveryCost;
//   String get change => _change;
//   int get categoryId => _categoryId;

//   // int get value => _categoryId;
//   //void addToCart(ProductSelected product) => userChoice.add(product);

//   updateCatID(value) async {
//     _categoryId = await value;
//     notifyListeners();
//   }

//   changeToGive(value) {
//     _change = value.toStringAsFixed(2).toString();
//     notifyListeners();
//   }

//   totalAmount(value) {
//     _totalAmountDue = value.toString();
//     //notifyListeners();
//   }

//   cartTotal(value) {
//     _cartTotalCount = value.toString();
//     //notifyListeners();
//   }

//   computeTotalAndDelivery(value) {
//     _totalAmoutDueAndDeliveryCost = value.toString();
//     notifyListeners();
//   }

//   selectTab(value) {
//     _selectedTab = value;
//     notifyListeners();
//   }

//   cardChecked(value) {
//     _isCard = value;
//     _isCash = false;
//     _isMomo = false;
//     notifyListeners();
//   }

//   momoChecked(value) {
//     _isMomo = value;
//     _isCard = false;
//     _isCash = false;
//     notifyListeners();
//   }

//   cashChecked(value) {
//     _isCash = value;
//     _isMomo = false;
//     _isCard = false;
//     notifyListeners();
//   }

//   /*getNewList(newList) {
//     _foodName = newList;
//     notifyListeners();
//   }*/

//   openTable(String? currentTableNumber) {
//     _tableNumber = currentTableNumber;
//     notifyListeners();
//   }

//   getFoodCategry(value) {
//     _foodCategory = value;
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     username.clear();
//     password.clear();
//     amountPaid.clear();
//     _change = "0.0";
//     _isCash = false;
//     _isMomo = false;
//     _isCard = false;
//     _totalAmountDue = null;
//     _totalAmoutDueAndDeliveryCost = null;
//     _foodCategory = "soups";
//     _categoryId = 17;
//     notifyListeners();
//   }
// }
