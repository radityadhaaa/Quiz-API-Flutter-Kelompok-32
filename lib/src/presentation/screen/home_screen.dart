import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:barayafood/core/app_data.dart';
import 'package:barayafood/core/app_color.dart';
import 'package:barayafood/src/presentation/screen/cart_screen.dart';
import 'package:barayafood/src/presentation/screen/status_screen.dart';
import 'package:barayafood/src/presentation/screen/barayafood_list_screen.dart';

class HomeScreen extends HookWidget {
  final List<Widget> screens = [
    BarayaFoodListScreen(),
    CartScreen(),
    StatusScreen(),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex.value,
        showUnselectedLabels: true,
        onTap: (int index) {
          selectedIndex.value = index;
        },
        fixedColor: AppColor.lightBlack,
        items: AppData.bottomNavigationItems
            .map(
              (element) => BottomNavigationBarItem(
                icon: element.icon,
                label: element.label,
              ),
            )
            .toList(),
      ),
      body: screens[selectedIndex.value],
    );
  }
}
