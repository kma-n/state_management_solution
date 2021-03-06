import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_provider/provider/items_provider.dart';
import 'package:state_management_provider/services/api_servies.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    List<String> cartItems = Provider.of<ItemProvider>(context).getCart;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: cartItems.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            trailing: IconButton(
                onPressed: () {
                  context
                      .read<ItemProvider>()
                      .delCart(cartItems[index].toString());
                },
                icon: Icon(Icons.delete_forever)),
            title: Text(
              cartItems[index],
            ),
          );
        },
      ),
    );
  }
}
