import '../widget/distance_text.dart';
import 'package:flutter/material.dart';
import 'package:barayafood/core/app_style.dart';
import 'package:barayafood/core/app_extension.dart';
import 'package:barayafood/src/data/model/barayafood.dart';

class BarayaFoodListView extends StatelessWidget {
  final bool isHorizontal;
  final Function(BarayaFood barayafood, int index)? onTap;
  final List<BarayaFood> barayafoodList;

  const BarayaFoodListView({
    super.key,
    this.isHorizontal = true,
    this.onTap,
    required this.barayafoodList,
  });

  Widget _barayafoodScore(BarayaFood barayafood) {
    return Row(
      children: [
        DistanceText(distance: barayafood.distance),
      ],
    ).fadeAnimation(1.0);
  }

  Widget _barayafoodImage(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Image.asset(
        image,
        width: 150,
        height: 150,
      ),
    ).fadeAnimation(0.4);
  }

  Widget _listViewItem(BarayaFood barayafood, int index) {
    Widget widget;
    widget = isHorizontal == true
        ? Column(
            children: [
              Hero(tag: index, child: _barayafoodImage(barayafood.images[0])),
              const SizedBox(height: 10),
              Text(barayafood.title.addOverFlow, style: h4Style)
                  .fadeAnimation(0.8),
              _barayafoodScore(barayafood),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _barayafoodImage(barayafood.images[0]),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(barayafood.title, style: h4Style).fadeAnimation(0.8),
                      const SizedBox(height: 5),
                      _barayafoodScore(barayafood),
                      const SizedBox(height: 5),
                      Text(
                        barayafood.description,
                        style: h5Style.copyWith(fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ).fadeAnimation(1.4)
                    ],
                  ),
                ),
              )
            ],
          );

    return GestureDetector(
      onTap: () => onTap?.call(barayafood, index),
      child: widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return isHorizontal == true
        ? SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: barayafoodList.length,
              itemBuilder: (_, index) {
                BarayaFood barayafood = barayafoodList[index];
                return _listViewItem(barayafood, index);
              },
              separatorBuilder: (_, __) {
                return const Padding(padding: EdgeInsets.only(left: 15));
              },
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            reverse: true,
            physics: const ClampingScrollPhysics(),
            itemCount: barayafoodList.length,
            itemBuilder: (_, index) {
              BarayaFood barayafood = barayafoodList[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 15, top: 10),
                child: _listViewItem(barayafood, index),
              );
            },
          );
  }
}
