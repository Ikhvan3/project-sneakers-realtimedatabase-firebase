import 'package:flutter/material.dart';
import '../models/brandhome_item.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class ShoeProvider with ChangeNotifier {
  final List<Shoe> _allShoes = [
    //NIKE
    Shoe(
      id: '1',
      name: 'Air Jordan 1 Elevate',
      brand: 'Nike',
      price: 1500,
      desc:
          'Rise to the occasion in style that soars. This shoe reworks an icon\'s original magic with a platform sole and low-cut silhouette. Air cushioning keeps you lifted, and sleek leather in contrasting colours adds visual interest.\n \nColour Shown: Legend Light Brown\nStyle: DH7004-200\nSize: EU 38',
      imageAsset: 'images/nike/Air_Jordan_1_Elevate_Low.png',
    ),
    Shoe(
      id: '2',
      name: 'Air Jordan 1 Mid SE',
      brand: 'Nike',
      price: 1200,
      desc:
          'New colours and fresh textures update this all-time favourite without losing its classic look and familiar feel. Made from premium materials and pumped full of comfortable Nike Air cushioning, it features subtle details that make it a staple sneaker with a modern expression.\n \nColour Shown: Neutral Grey\nStyle: FQ7720-002\nSize: EU 40',
      imageAsset: 'images/nike/Air_Jordan_1_Mid_SE.png',
    ),
    Shoe(
      id: '3',
      name: 'Air Force 1 Shadow',
      brand: 'Nike',
      price: 1200,
      desc:
          'Everything you love about the AF-1—but doubled! The Air Force 1 Shadow puts a playful twist on a hoops icon to highlight the best of AF-1 DNA. With 2 eyestays, 2 mudguards, 2 backtabs and 2 Swoosh logos, you get a layered look with double the branding.\n \nColour Shown: Coconut Milk\nStyle: DZ1847-105\nSize: EU 36',
      imageAsset: 'images/nike/Nike_Air_Force_1_Shadow.png',
    ),
    Shoe(
      id: '4',
      name: 'Air Max 90 LV8',
      brand: 'Nike',
      price: 1200,
      desc:
          'The Air Max 90 LV8 takes your favourite silhouette to the next level with stacked Nike Air units. Not only do you get extra cushioning, but you get extra height, creating the perfect platform that\'s easy to style. Layers of mixed materials add texture and dimension, creating an elevated look you\'ll be reaching for again and again.\n \nColour Shown: White\nStyle: FD4328-106\nSize: EU 39',
      imageAsset: 'images/nike/Nike_Air_Max_90_LV8.png',
    ),
    Shoe(
      id: '5',
      name: 'Cortez Textile',
      brand: 'Nike',
      price: 1200,
      desc:
          'You spoke. We listened. Based on your feedback, we\'ve revamped the original Cortez while maintaining the retro appeal you know and love. Now with a wider toe area and firmer side panels, you can comfortably wear them day in and day out. Plus, re-engineered textile helps prevent warping or creasing. Cortez fans—this one\'s for you.\n \nColour Shown: Light Pumice\nStyle: DZ2795-002\nSize: EU 40',
      imageAsset: 'images/nike/Nike_Cortez_Textile.png',
    ),
    Shoe(
      id: '6',
      name: 'Tech Hera',
      brand: 'Nike',
      price: 1200,
      desc:
          'Inspired by early-2000s running, the Tech Hera is here to fulfil all of your chunky sneaker wishes. The wavy lifted midsole and suede accents level up your look while keeping you comfortable. Its durable design holds up beautifully to everyday wear—which is perfect, because you\'ll definitely want to wear these every day.\n \nColour Shown: Mica Blue\nStyle: DR9761-402\nSize: EU 36',
      imageAsset: 'images/nike/Nike_Tech_Hera.png',
    ),
    //CONVERSE
    Shoe(
      id: '7',
      name: 'Chuck Taylor All Star',
      brand: 'Converse',
      price: 1200,
      desc: 'x',
      imageAsset: 'images/converse/Chuck_Taylor_All_Star.png',
    ),
    Shoe(
      id: '8',
      name: 'Belmont',
      brand: 'Converse',
      price: 1200,
      desc: 'x',
      imageAsset: 'images/converse/Converse_Belmont.png',
    ),
    Shoe(
      id: '9',
      name: 'Chuck 70 High',
      brand: 'Converse',
      price: 1200,
      desc: 'x',
      imageAsset: 'images/converse/converse_chuck70_high.png',
    ),
    Shoe(
      id: '10',
      name: 'Pro Blaze Classic',
      brand: 'Converse',
      price: 1200,
      desc: 'x',
      imageAsset: 'images/converse/Pro_Blaze_Classic.png',
    ),
    Shoe(
      id: '11',
      name: 'Run Star Trainer',
      brand: 'Converse',
      price: 1200,
      desc: 'x',
      imageAsset: 'images/converse/Run_Star_Trainer.png',
    ),
    Shoe(
      id: '12',
      name: 'Star Player 76',
      brand: 'Converse',
      price: 1200,
      desc: 'x',
      imageAsset: 'images/converse/Star_Player_76.png',
    ),
    //VANS
    Shoe(
      id: '13',
      name: 'Authentic Canvas',
      brand: 'Vans',
      price: 1200,
      desc: 'x',
      imageAsset: 'images/vans/Authentic_Canvas_Shoe.png',
    ),
    Shoe(
      id: '14',
      name: 'Knu Stack',
      brand: 'Vans',
      price: 1200,
      desc: 'x',
      imageAsset: 'images/vans/Knu_Stack_Shoe.png',
    ),
    Shoe(
      id: '15',
      name: 'Knu Skool DR',
      brand: 'Vans',
      price: 1200,
      desc: 'x',
      imageAsset: 'images/vans/Knu_Skool_DR_Shoe.png',
    ),
    Shoe(
      id: '16',
      name: 'Knu Skool Mesh',
      brand: 'Vans',
      price: 1200,
      desc: 'x',
      imageAsset: 'images/vans/Knu_Skool_Mesh_Shoe.png',
    ),
    Shoe(
      id: '17',
      name: 'Sk8-Hi Pig Suede',
      brand: 'Vans',
      price: 1200,
      desc: 'x',
      imageAsset: 'images/vans/Sk8-Hi_Pig_Suede_Shoe.png',
    ),
    Shoe(
      id: '18',
      name: 'Star Player 76',
      brand: 'Vans',
      price: 1200,
      desc: 'x',
      imageAsset: 'images/vans/Youth_Sk8-Hi_Shoe.png',
    ),
  ];

  List<Shoe> get allShoes {
    return [..._allShoes];
  }

  List<Shoe> getShoesByBrand(String brand) {
    return _allShoes.where((shoe) => shoe.brand == brand).toList();
  }

  Shoe findById(String id) {
    return _allShoes.firstWhere((shoe) => shoe.id == id);
  }

  void addShoe(Shoe shoe) {
    _allShoes.add(shoe);
    notifyListeners();
  }

  void toggleFavorite(String id) {
    final index = _allShoes.indexWhere((shoe) => shoe.id == id);
    if (index >= 0) {
      _allShoes[index].isFavorite = !_allShoes[index].isFavorite;
      notifyListeners();
    }
  }

  Future<void> fetchAndSetShoes(String token) async {
    final url =
        'https://sneakers-e44c4-default-rtdb.firebaseio.com/shoes.json?auth=$token';
    try {
      final response = await http.get(url as Uri);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Shoe> loadedShoes = [];
      extractedData.forEach((shoeId, shoeData) {
        loadedShoes.add(Shoe(
          id: shoeId,
          name: shoeData['name'],
          brand: shoeData['brand'],
          price: shoeData['price'],
          desc: shoeData['desc'],
          imageAsset: shoeData['imageAsset'],
        ));
      });
      _allShoes.clear();
      _allShoes.addAll(loadedShoes);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
