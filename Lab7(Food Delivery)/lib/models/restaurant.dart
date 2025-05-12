class Restaurant {
  final String id;
  final String name;
  final String imageUrl;
  final String cuisine;
  final double rating;
  final int reviewCount;
  final int deliveryTime;
  final double distance;
  final String address;
  final bool freeDelivery;
  final double deliveryFee;
  final bool isPromoted;
  final bool isFavorite;

  Restaurant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.cuisine,
    required this.rating,
    required this.reviewCount,
    required this.deliveryTime,
    required this.distance,
    required this.address,
    required this.freeDelivery,
    required this.deliveryFee,
    required this.isPromoted,
    required this.isFavorite,
  });
}
