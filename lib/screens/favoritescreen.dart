import 'package:flutter/material.dart';
import 'package:menu_makanan/providers/favorite.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/brandhome.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'sneakers_detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = '/favorite';
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<Favorite>(context);
    // final id = ModalRoute.of(context)?.settings.arguments as String;
    // final product =
    //     Provider.of<ShoeProvider>(context, listen: false).findById(id);

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.10),
          ),
          color: Color.fromARGB(255, 0, 212, 177),
          elevation: 5,
          child: Container(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      HomeScreen.routeName,
                    );
                  },
                  icon: Icon(
                    Icons.home_outlined,
                    color: Color.fromARGB(255, 251, 249, 249),
                    size: 30,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      SearchScreen.routeName,
                    );
                  },
                  icon: Icon(
                      size: 30,
                      color: Color.fromARGB(255, 255, 255, 255),
                      Icons.search_outlined),
                ),

                IconButton(
                  icon: Icon(Icons.favorite_border),
                  color: Color.fromARGB(255, 255, 255, 255),
                  iconSize: 30,
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      FavoriteScreen.routeName,
                    );
                  },
                ),
                IconButton(
                  onPressed: () =>
                      Provider.of<Authen>(context, listen: false).logout(),
                  icon: Icon(color: Colors.white, Icons.logout),
                ),
                // IconButton(
                //   icon: Icon(Icons.account_circle_outlined),
                //   iconSize: 30,
                //   color: const Color.fromARGB(255, 10, 10, 10),
                //   onPressed: () {},
                // ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favorite.favorites.length,
        itemBuilder: (context, index) {
          {
            final firebaseId = favorite.favorites.keys.toList()[index];
            final favoriteItem = favorite.favorites[firebaseId]!;

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
                          favoriteItem.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0), // Add spacing between image and text
                    // Text information
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align text to the left
                      children: [
                        Text(
                          favoriteItem.name ?? "Item name not found",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          "\Harga : Rp  ${favorite.favorites.values.toList()[index].price}",
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
                          color: const Color.fromARGB(255, 255, 255, 255)),
                      onPressed: () {
                        favorite.removeFavorite(firebaseId).then(
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
                onTap: () {
                  Navigator.of(context).pushNamed(
                    DetailScreenSneakers.routeName,
                    arguments: firebaseId,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
