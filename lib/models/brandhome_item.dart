class Shoe {
  final String id;
  final String name;
  final double price;
  final String imageAsset;
  final String desc;
  final String brand;

  bool isFavorite;

  Shoe({
    required this.id,
    required this.name,
    required this.price,
    required this.imageAsset,
    required this.desc,
    required this.brand,
    this.isFavorite = false,
  });
}
