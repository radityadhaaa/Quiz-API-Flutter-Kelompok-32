import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:barayafood/core/app_style.dart';
import 'package:barayafood/core/app_color.dart';
import 'package:barayafood/src/data/model/barayafood.dart';
import 'package:barayafood/src/presentation/widget/bottom_bar.dart';
import 'package:barayafood/src/presentation/widget/empty_widget.dart';
import 'package:barayafood/src/presentation/widget/cart_list_view.dart';
import 'package:barayafood/src/presentation/widget/counter_button.dart';
import 'package:barayafood/src/business_logic/provider/barayafood_provider.dart';
import 'package:barayafood/src/presentation/screen/pembayaran_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<BarayaFood> cartList =
        context.watch<BarayaFoodProvider>().getCartList;

    final totalPrice = context.watch<BarayaFoodProvider>().state.totalPrice;

    PreferredSizeWidget appBar() {
      return AppBar(
        title: const Text("Cart", style: h2Style),
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.arrowLeft, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            splashRadius: 20.0,
            onPressed: () {
              context.read<BarayaFoodProvider>().clearCart();
            },
            icon: const Icon(Icons.delete, color: AppColor.lightBlack),
          )
        ],
      );
    }

    return Scaffold(
      appBar: appBar(),
      bottomNavigationBar: BottomBar(
        priceLabel: "Total price",
        priceValue: "\$${totalPrice.toStringAsFixed(2)}",
        buttonLabel: "Checkout",
        onTap: totalPrice > 0
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PembayaranScreen()),
                );
              }
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: cartList.isNotEmpty
            ? CartListView(
                barayafoodItems: cartList,
                counterButton: (barayafood, index) {
                  return CounterButton(
                    orientation: Axis.vertical,
                    onIncrementSelected: () {
                      context.read<BarayaFoodProvider>().increaseQuantity(
                            cartList[index],
                          );
                    },
                    onDecrementSelected: () {
                      context
                          .read<BarayaFoodProvider>()
                          .decreaseQuantity(cartList[index]);
                    },
                    label: barayafood.quantity,
                  );
                },
              )
            : const EmptyWidget(title: "Empty cart"),
      ),
    );
  }
}
