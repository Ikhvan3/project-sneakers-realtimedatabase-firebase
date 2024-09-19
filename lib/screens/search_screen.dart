import 'package:flutter/material.dart';
import 'package:menu_makanan/screens/home_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/brandhome.dart';
import '../models/brandhome_item.dart';
import './sneakers_detail_screen.dart';
import 'favoritescreen.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Shoe> _hasilPencarian = [];

  void _lakukanPencarian(String kueri) {
    final penyediaSepatuProvider =
        Provider.of<ShoeProvider>(context, listen: false);
    setState(() {
      _hasilPencarian = penyediaSepatuProvider.allShoes
          .where((sepatu) =>
              sepatu.name.toLowerCase().contains(kueri.toLowerCase()) ||
              sepatu.brand.toLowerCase().contains(kueri.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(title: const Text('Cari Sepatu')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SearchBar(
              padding: const MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0)),
              onChanged: _lakukanPencarian,
              leading: const Icon(Icons.search),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _hasilPencarian.length,
                itemBuilder: (context, index) {
                  final sepatu = _hasilPencarian[index];
                  return ListTile(
                    title: Text(sepatu.name),
                    subtitle: Text(sepatu.brand),
                    leading:
                        Image.asset(sepatu.imageAsset, width: 50, height: 50),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        DetailScreenSneakers.routeName,
                        arguments: sepatu.id,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
