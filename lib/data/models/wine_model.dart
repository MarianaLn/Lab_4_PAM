import '../../domain/entities/wine.dart';

class WineModel extends Wine {
  WineModel({
    required String title,
    required String subtitle,
    required String country,
    required double price,
  }) : super(
    title: title,
    subtitle: subtitle,
    country: country,
    price: price,
  );

  factory WineModel.fromJson(Map<String, dynamic> json) {
    return WineModel(
      title: json['title'],
      subtitle: json['subtitle'],
      country: json['country'],
      price: double.parse(json['price']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'country': country,
      'price': price.toString(),
    };
  }
}
