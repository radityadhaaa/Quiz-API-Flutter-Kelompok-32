import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:barayafood/src/data/model/barayafood.dart';

@immutable
class BarayaFoodState extends Equatable {
  final List<BarayaFood> mainItems;
  final double totalPrice;

  const BarayaFoodState.initial(List<BarayaFood> mainItems)
      : this(mainItems: mainItems);

  @override
  List<Object?> get props => [mainItems, totalPrice];

  const BarayaFoodState({
    required this.mainItems,
    this.totalPrice = 0.0,
  });

  BarayaFoodState copyWith({
    List<BarayaFood>? mainItems,
    double? totalPrice,
  }) {
    return BarayaFoodState(
      mainItems: mainItems ?? this.mainItems,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
