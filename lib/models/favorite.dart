class FavoriteItem {
  String id;
  String createdAt;
  String name;
  double price;
  final String imageUrl;

  FavoriteItem({
    required this.id,
    required this.createdAt,
    required this.price,
    required this.name,
    required this.imageUrl,
  });
}
