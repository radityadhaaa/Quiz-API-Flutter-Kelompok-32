import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:barayafood/core/app_color.dart';
import 'package:barayafood/core/app_style.dart';
import 'package:barayafood/core/app_extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:barayafood/src/data/model/barayafood.dart';
import 'package:barayafood/src/presentation/widget/distance_text.dart';
import 'package:barayafood/src/presentation/widget/color_picker.dart';
import 'package:barayafood/src/presentation/widget/counter_button.dart';
import 'package:barayafood/src/business_logic/provider/barayafood_provider.dart';

class BarayaFoodDetailScreen extends HookWidget {
  final BarayaFood barayafood;
  final int index;

  const BarayaFoodDetailScreen({
    super.key,
    required this.barayafood,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final List<BarayaFood> items =
        context.watch<BarayaFoodProvider>().state.mainItems;

    double height = MediaQuery.of(context).size.height;

    final selectedIndex = useState(0);

    Widget barayafoodImageSlider(double height) {
      return Container(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        height: height * 0.5,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              onPageChanged: (int index) {
                selectedIndex.value = index;
              },
              itemCount: barayafood.images.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Hero(
                      tag: index,
                      child: Image.asset(
                        barayafood.images[index],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 20,
              child: AnimatedSmoothIndicator(
                effect: const WormEffect(
                  dotColor: Colors.white38,
                  activeDotColor: Colors.white,
                ),
                activeIndex: selectedIndex.value,
                count: barayafood.images.length,
              ),
            ),
          ],
        ),
      );
    }

    PreferredSizeWidget appBar(BuildContext context) {
      return AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.arrowLeft, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(barayafood.title, style: h2Style),
      );
    }

    Widget bottomBar() {
      return Container(
        padding: const EdgeInsets.all(15),
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FittedBox(
                  child: Text(
                    'Price',
                    style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                FittedBox(child: Text("${barayafood.price}", style: h2Style))
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.lightBlack,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                context.read<BarayaFoodProvider>().addToCart(items[index]);
              },
              child: const Text("Add to cart"),
            )
          ],
        ),
      ).fadeAnimation(1.3);
    }

    return WillPopScope(
      onWillPop: () async {
        return Future.value(true);
      },
      child: Scaffold(
        bottomNavigationBar: bottomBar(),
        appBar: appBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                barayafoodImageSlider(height),
                Center(
                  child: DistanceText(
                    distance: barayafood.distance,
                  ).fadeAnimation(0.4),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: const Text(
                    "Deskripsi",
                    style: h2Style,
                    textAlign: TextAlign.end,
                  ).fadeAnimation(0.6),
                ),
                Text(
                  barayafood.description,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black45),
                ).fadeAnimation(0.8),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      "Color :",
                      style: h2Style,
                      textAlign: TextAlign.end,
                    ),
                    Expanded(
                      child: CounterButton(
                        label: items[index].quantity,
                        onIncrementSelected: () {
                          context
                              .read<BarayaFoodProvider>()
                              .increaseQuantity(items[index]);
                        },
                        onDecrementSelected: () {
                          context
                              .read<BarayaFoodProvider>()
                              .decreaseQuantity(items[index]);
                        },
                      ),
                    )
                  ],
                ).fadeAnimation(1.0)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
