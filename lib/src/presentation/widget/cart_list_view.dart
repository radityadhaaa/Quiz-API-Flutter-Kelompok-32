import 'package:flutter/material.dart';
import 'package:barayafood/core/app_style.dart';
import 'package:barayafood/core/app_extension.dart';
import 'package:barayafood/src/data/model/barayafood.dart';

class CartListView extends StatelessWidget {
  const CartListView({
    super.key,
    required this.counterButton,
    required this.barayafoodItems,
  });

  final Widget Function(BarayaFood barayafood, int index) counterButton;
  final List<BarayaFood> barayafoodItems;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: barayafoodItems.length,
      itemBuilder: (_, index) {
        BarayaFood barayafood = barayafoodItems[index];
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(barayafood.images[0]),
                ),
              ),
              const SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(barayafood.title.addOverFlow, style: h4Style),
                  const SizedBox(height: 5),
                  Text("${barayafood.price}", style: h2Style),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text("Color : ", style: h4Style),
                      CircleAvatar(
                        radius: 15,
                        child: Container(),
                      )
                    ],
                  )
                ],
              ),
              // Spacer(),
              counterButton(barayafood, index)
            ],
          ).fadeAnimation(0.4 * index),
        );
      },
      separatorBuilder: (_, __) {
        return const Padding(padding: EdgeInsets.only(bottom: 15));
      },
    );
  }
}
