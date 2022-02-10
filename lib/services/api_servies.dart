import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:state_management_provider/models/items_model.dart';
import 'dart:convert' as convert;

class ApiProvider with ChangeNotifier {
  List<Items> items = [];

  final _baseUrl = "https://fakestoreapi.com/products";
  final List<String> _favList = [];

  Future<List<Items>> fetchList() async {
    List data;
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      data = convert.jsonDecode(response.body);
      items = data.map((e) => Items.fromJson(e)).toList();
      return items;
    } else {
      throw Exception('Error');
    }
  }

  List<Items> get getItems => items;

  List<String> get getCart => _favList;

  void addtoCart(String item) {
    _favList.add(item);
    notifyListeners();
  }

  void delCart(String item) {
    _favList.remove(item);
    notifyListeners();
  }
}
