import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_provider/models/items_model.dart';
import 'package:state_management_provider/services/api_servies.dart';
import 'package:state_management_provider/views/cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiProvider? api;
  List<Items> items = [];

  @override
  Widget build(BuildContext context) {
    api = Provider.of<ApiProvider>(context, listen: false);
    final List<Items> _favList = context.watch<ApiProvider>().getCart;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Items List"),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.shop,
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
          if (snapshot.connectionState == ConnectionState.done) {
            items = snapshot.data;
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  trailing: IconButton(
                      onPressed: () {
                        if (!_favList.contains(items[index])) {
                          context.read<ApiProvider>().addtoCart(items[index]);
                        } else if (_favList.contains(items[index])) {
                          context.read<ApiProvider>().delCart(items[index]);
                        }
                      },
                      icon: const Icon(Icons.check)),
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
