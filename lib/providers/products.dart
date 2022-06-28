// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/http_exception.dart';
import 'package:flutter_application_1/providers/product.dart';
// ignore: unused_import
import 'package:flutter_application_1/widgets/product_item.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [
  //  Product(
//id: 'p1',
//title: 'My Personal Laptop',
//description: 'Mylaptop is so fast and colourful',
//price: 60000.55,
//imageUrl:
//'https://th.bing.com/th/id/OIP.hu4aNAOQaCQmWMmM3CEesQHaE7?w=270&h=180&c=7&r=0&o=5&pid=1.7',
//),
  //  Product(
//id: 'p2',
//title: 'Bangles',
//description: 'Bangles are very nice.And gold color',
//price: 250.65,
//imageUrl:
    //      'https://th.bing.com/th/id/OIP.klHXA0QY5VKt_hvQvFcg_wHaGn?w=207&h=185&c=7&r=0&o=5&pid=1.7',
//),
    //  Product(
    //   id: 'p3',
//title: 'Ear Rings',
//description: 'Ear Rings are so beautiful',
    //  price: 150.85,
//imageUrl:
//'https://th.bing.com/th/id/OIP.eGWJYVHzM2oglqd0KJGUwgHaHa?w=206&h=206&c=7&r=0&o=5&pd=1.7',
//),
//Product(
//id: 'p4',
//title: 'Red Shirt',
//description: 'Red shirt colitor is so nice.And i like ',
//price: 500.55,
    //imageUrl:
    //     'https://th.bing.com/th?q=Red+Nike+Shirt&w=120&h=120&c=1&rs=1&qlt=90&cb=1&pid=InlineBlock&mkt=en-IN&cc=IN&setlang=en&adlt=moderate&t=1&mw=247',
//),
  ];
  // var _showFavoriteOnly = false;

  final String authToken;
  final String userId;
  Products(this.authToken, this.userId, this._items);

  List<Product> get items {
    //if (_showFavoriteOnly) {
    // return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }

    return [..._items];
  }

  List<Product> get favoriteItems {
    // ignore: non_constant_identifier_names
    return _items.where((ProdItem) => ProdItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  // _showFavoriteOnly = true;
  // notifyListeners();
  // }
  // void showAll() {
  //  _showFavoriteOnly = false;
  //  notifyListeners();
  Future<void> fetchAndSetProducts([bool filterByuser = false]) async {
    final filterString =
        filterByuser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url = Uri.parse(
        'https://flutter-update-26fc7-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterString');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      // ignore: unnecessary_null_comparison
      if (extractedData == null) {
        return;
      }

      url = Uri.parse(
          'https://flutter-update-26fc7-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken');
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      // ignore: non_constant_identifier_names
      final List<Product> LoadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        LoadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite:
              favoriteData == null ? false : favoriteData[prodId] ?? false,
          imageUrl: prodData['imageUrl'],
        ));
      });
      _items = LoadedProducts;
      notifyListeners();
    } catch (error) {
      // ignore: use_rethrow_when_possible
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://flutter-update-26fc7-default-rtdb.firebaseio.com/products.json?auth=$authToken');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'creatorId': userId,
        }),
      );
      final newProduct = Product(
        description: product.description,
        title: product.title,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
    } catch (error) {
      print(error);
      // ignore: use_rethrow_when_possible
      throw (error);
    }
    //_items.insert(0,newProduct); //at the start of the List
    notifyListeners();
    // print(error);
    // throw (error);
  }
  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.parse(
          'https://flutter-update-26fc7-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }
  Future<void> deleteProducts(String id) async {
    final url = Uri.parse(
        'https://flutter-update-26fc7-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];

    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('could not delete product');
    }
    // ignore: unnecessary_null_comparison
    existingProduct == null;
  }
}
