import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:barayafood/src/data/model/barayafood_color.dart';

@immutable
class BarayaFood extends Equatable {
  final int id;
  final String title;
  final String description;
  final double price;
  final int quantity;
  final double distance;
  final List<String> images;
  final bool cart;

  const BarayaFood({
    required this.id,
    this.cart = false,
    required this.title,
    required this.description,
    required this.price,
    this.quantity = 1,
    required this.distance,
    required this.images,
  });

  @override
  List<Object?> get props =>
      [id, cart, title, description, price, quantity, distance, images];

  BarayaFood copyWith({
    int? id,
    String? title,
    String? description,
    double? price,
    int? quantity,
    double? distance,
    List<String>? images,
    bool? cart,
    List<BarayaFoodColor>? colors,
  }) {
    return BarayaFood(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      distance: distance ?? this.distance,
      images: images ?? this.images,
      cart: cart ?? this.cart,
    );
  }
}
