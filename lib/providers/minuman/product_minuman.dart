import 'package:flutter/foundation.dart';

class DaftarMinuman with ChangeNotifier {
  final String name;
  final String id;
  final String description;
  final double price;
  final String imageAsset;

  bool isFavorite;

  DaftarMinuman({
    required this.name,
    required this.id,
    required this.description,
    required this.price,
    required this.imageAsset,
    this.isFavorite = false,
  });

  void statusFav() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
