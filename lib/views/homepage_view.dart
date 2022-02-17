import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_provider/models/items_model.dart';
import 'package:state_management_provider/provider/items_provider.dart';
import 'package:state_management_provider/views/cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ItemProvider? api;
  List<Items> item = [];
  List<Items> items = [];

  @override
  Widget build(BuildContext context) {
    api = Provider.of<ItemProvider>(context, listen: false);

    final List<String> _favList = context.watch<ItemProvider>().getCart;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Items List"),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Cart()),
              );
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: api?.fetchList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done ||
              snapshot.connectionState == ConnectionState.waiting) {
            items = snapshot.data;
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  trailing: IconButton(
                      onPressed: () {
                        if (!_favList.contains(items[index].title)) {
                          context
                              .read<ItemProvider>()
                              .addtoCart(items[index].title.toString());
                        } else if (_favList.contains(items[index].title)) {
                          context
                              .read<ItemProvider>()
                              .delCart(items[index].title.toString());
                        }
                      },
                      icon: Icon(
                        Icons.check,
                        color: (_favList.contains(items[index].title))
                            ? Colors.green
                            : Colors.blueGrey,
                      )),
                  title: Text(
                    items[index].title.toString(),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
