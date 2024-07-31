import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<Cart>(context).initialDataGet();
      isInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cardData = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "KERANJANG",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 0, 174, 145),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 126, 255, 242),
              Color.fromARGB(255, 238, 238, 238),
            ])),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cardData.items.length,
                itemBuilder: (context, index) {
                  final firebaseId = cardData.items.keys.toList()[index];
                  final cartItem = cardData.items[firebaseId]!;

                  return Card(
                    child: ListTile(
                      tileColor: Color.fromARGB(255, 0, 200, 167),
                      title: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                cartItem.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                              width:
                                  10.0), // Add spacing between image and text
                          // Text information
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Align text to the left
                            children: [
                              Text(
                                cartItem.name ?? "Item name not found",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                "\Jumlah : ${cardData.items.values.toList()[index].qty}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                "\Harga : Rp  ${cardData.formatHarga(cardData.items.values.toList()[index].price * cardData.items.values.toList()[index].qty)}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete,
                                color:
                                    const Color.fromARGB(255, 255, 255, 255)),
                            onPressed: () {
                              cardData.removeItem(firebaseId).then(
                                (_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Berhasil dihapus"),
                                      duration: Duration(milliseconds: 500),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Card(
              color: Color.fromARGB(255, 0, 200, 167),
              margin: EdgeInsets.all(20),
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "TOTAL : \Rp ${cardData.totalHarga}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    Card(
                      elevation: 3,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "BAYAR",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 174, 145),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
