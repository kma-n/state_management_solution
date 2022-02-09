import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_provider/models/items_model.dart';
import 'package:state_management_provider/services/api_servies.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    List<Items> cartItems = Provider.of<ApiProvider>(context).getCart;

    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: cartItems.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            trailing: const Icon(Icons.check),
            title: Text(
              cartItems[index].title.toString(),
            ),
          );
        },
      ),
    );
  }
}
