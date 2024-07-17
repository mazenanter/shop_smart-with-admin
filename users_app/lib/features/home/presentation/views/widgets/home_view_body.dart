import 'package:ecommerce_app_firebase/core/widgets/text_title.dart';
import 'package:ecommerce_app_firebase/features/home/presentation/consts.dart';
import 'package:ecommerce_app_firebase/features/home/presentation/views/widgets/custom_carousel_slider.dart';
import 'package:ecommerce_app_firebase/features/home/presentation/views/widgets/custom_categories_widget.dart';
import 'package:ecommerce_app_firebase/features/home/presentation/views/widgets/custom_latest_arrivel_list_view.dart';
import 'package:ecommerce_app_firebase/features/search/presentation/views/search_view.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomCarouselSlider(),
            const TextTitle(
              label: 'Latest arrivel',
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomLatestArrivelListView(),
            const SizedBox(
              height: 10,
            ),
            const TextTitle(
              label: 'Categories',
            ),
            Wrap(
              children: List.generate(
                cat.length,
                (index) => CustomCategoriesWidget(
                  onTapCategory: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchView(
                          categoryName: cat[index].category,
                          appbarTitle: TextTitle(label: cat[index].category),
                        ),
                      ),
                    );
                  },
                  image: cat[index].image,
                  text: cat[index].category,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
