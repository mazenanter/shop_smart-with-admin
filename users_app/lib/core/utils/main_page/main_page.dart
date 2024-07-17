import 'package:ecommerce_app_firebase/core/widgets/custom_app_title.dart';
import 'package:ecommerce_app_firebase/features/cart/presentation/views/cart_view.dart';
import 'package:ecommerce_app_firebase/features/home/presentation/views/home_view.dart';
import 'package:ecommerce_app_firebase/features/profile/presentation/views/profile_view.dart';
import 'package:ecommerce_app_firebase/features/search/presentation/views/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 0;
  late PageController controller;
  late List<Widget> views;
  @override
  void initState() {
    super.initState();
    views = [
      const HomeView(),
      const SearchView(
        categoryName: '',
        appbarTitle: CustomAppTitle(),
      ),
      const CartView(),
      const ProfileView()
    ];
    controller = PageController(initialPage: currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: currentPage == 2 || currentPage == 1
          ? null
          : AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              title: Row(
                children: [
                  Image.asset(
                    'assets/images/shopping_cart.png',
                    height: MediaQuery.sizeOf(context).height * 0.07,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const CustomAppTitle(),
                ],
              ),
            ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: views,
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(
              IconlyBold.home,
            ),
            icon: Icon(
              IconlyLight.home,
            ),
            label: 'Home',
          ),
          NavigationDestination(
              selectedIcon: Icon(
                IconlyBold.search,
              ),
              icon: Icon(
                IconlyLight.search,
              ),
              label: 'Search'),
          NavigationDestination(
              selectedIcon: Icon(
                IconlyBold.bag2,
              ),
              icon: Badge(
                backgroundColor: Colors.red,
                label: Text(
                  '5',
                ),
                child: Icon(
                  IconlyLight.bag2,
                ),
              ),
              label: 'Cart'),
          NavigationDestination(
            selectedIcon: Icon(
              IconlyBold.profile,
            ),
            icon: Icon(
              IconlyLight.profile,
            ),
            label: 'Profile',
          ),
        ],
        selectedIndex: currentPage,
        onDestinationSelected: (value) {
          setState(() {
            currentPage = value;
          });
          controller.jumpToPage(currentPage);
        },
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        height: kBottomNavigationBarHeight,
      ),
    );
  }
}
