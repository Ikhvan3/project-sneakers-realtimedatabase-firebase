import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/favorite.dart';

class Favorite with ChangeNotifier {
  bool _isInitialized = false;

  String? token, firebaseId;

  void updateData(tokenData, uid) {
    token = tokenData;
    firebaseId = uid;
    notifyListeners();
  }

  String urlMaster = "https://sneakers-e44c4-default-rtdb.firebaseio.com/";

  int get jumlah {
    return _favorites.length;
  }

  final Map<String, FavoriteItem> _favorites = {};
  final Map<String, String> _favoriteFirebaseIds = {};

  Map<String, FavoriteItem> get favorites => _favorites;

  bool get isInitialized => _isInitialized;

  void updateAuthData(String? newToken, String? newUserId) {
    token = newToken;
    firebaseId = newUserId;
    _isInitialized = token != null && firebaseId != null;
    if (_isInitialized) {
      fetchFavorites(); // Fetch favorites when auth data is updated
    } else {
      // Clear favorites when logged out
      _favorites.clear();
      _favoriteFirebaseIds.clear();
    }
    notifyListeners();
  }

  Future<void> addFavorite(
      String id, String name, double price, String imageUrl) async {
    if (!_isInitialized) {
      print('Error: Favorite provider is not initialized');
      return;
    }
    final userId = firebaseId;
    if (_favorites.containsKey(id)) {
      // Item already favorited, remove it
      removeFavorite(id);
    } else {
      // Add new favorite item
      final newFavoriteItem = FavoriteItem(
        createdAt: DateTime.now().toString(),
        name: name,
        id: id,
        price: price,
        imageUrl: imageUrl,
      );
      _favorites.putIfAbsent(id, () => newFavoriteItem);

      // Send data to Firebase
      Uri url = Uri.parse("$urlMaster/favorites.json?auth=$token");

      try {
        final response = await http.post(
          url,
          body: json.encode({
            'name': name,
            'id': id,
            'price': price,
            'createdAt': DateTime.now().toString(),
            'imageUrl': imageUrl,
            'userId': firebaseId,
          }),
        );

        if (response.statusCode >= 200 && response.statusCode < 300) {
          final responseData = json.decode(response.body);
          _favoriteFirebaseIds[id] = responseData['name'];
        } else {
          print('Error posting to Firebase: ${response.statusCode}');
          _favorites.remove(id);
        }
      } catch (error) {
        print('Error posting to Firebase: $error');
        _favorites.remove(id);
      }
    }
    notifyListeners();
  }

  Future<void> removeFavorite(String id) async {
    print('Current Favorite Firebase IDs: $_favoriteFirebaseIds');
    // Get Firebase ID
    final firebaseId = _favoriteFirebaseIds[id];
    if (firebaseId == null) {
      print('Error: Favorite Item ID not found in Firebase');
      return;
    }
    // Get Firebase URL for deleting the item
    Uri url = Uri.parse(
      "$urlMaster/favorites/$firebaseId.json?auth=$token",
    );

    try {
      // Delete data from Firebase
      final response = await http.delete(url);

      // Handle response
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Remove data from local map
        _favorites.remove(id);
        _favoriteFirebaseIds.remove(id);

        // Notify UI to update
        notifyListeners();
      } else {
        // Error handling if deletion from Firebase fails
        print('Error deleting from Firebase: ${response.statusCode}');
      }
    } catch (error) {
      print('Error deleting from Firebase: $error');
    }
  }

  Future<void> fetchFavorites() async {
    try {
      if (firebaseId == null) {
        print("Error: firebaseId is null.");
        return;
      }
      if (token == null) {
        print("Error: token is null.");
        return;
      }
      print("Fetching favorite data for user: $firebaseId with token: $token");

      Uri url = Uri.parse(
          '$urlMaster/favorites.json?auth=$token&orderBy="userId"&equalTo="$firebaseId"');

      var hasilGetData = await http.get(url);
      if (hasilGetData.statusCode < 200 || hasilGetData.statusCode >= 300) {
        throw (hasilGetData.statusCode);
      } else {
        if (hasilGetData.body == null || hasilGetData.body.isEmpty) {
          print("No data found in response.");
          _favorites.clear();
          _favoriteFirebaseIds.clear();
          notifyListeners();
          return;
        }
        var dataResponse = json.decode(hasilGetData.body);

        if (dataResponse == null) {
          print("Data is null.");
          return;
        }
        if (dataResponse is! Map<String, dynamic>) {
          print("Data is not of type Map<String, dynamic>.");
          return;
        }

        _favorites
            .clear(); // Clear existing favorites to ensure only the current user's favorites are loaded
        _favoriteFirebaseIds.clear(); // Clear existing Firebase IDs

        var favoriteData = dataResponse as Map<String, dynamic>;

        favoriteData.forEach((key, value) {
          DateTime dateTimeParse =
              DateFormat("yyyy-MM-dd HH:mm:ss").parse(value["createdAt"]);

          _favorites.putIfAbsent(
              value['id'],
              () => FavoriteItem(
                    id: value['id'],
                    createdAt: dateTimeParse.toString(),
                    price: value["price"],
                    name: value["name"],
                    imageUrl: value["imageUrl"],
                  ));
          _favoriteFirebaseIds[value['id']] = key;
        });
        print("Successfully fetched favorite data.");
        notifyListeners();
      }
    } catch (error) {
      print("Error fetching favorites: $error");
      notifyListeners();
      throw (error);
    }
  }
}
