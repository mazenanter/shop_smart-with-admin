import 'package:ecommerce_app_firebase/features/search/presentation/views/widgets/search_view_body.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView(
      {super.key, required this.categoryName, required this.appbarTitle});
  final String categoryName;
  final Widget appbarTitle;
  @override
  Widget build(BuildContext context) {
    return SearchViewBody(
      appBarTitle: appbarTitle,
      categoryName: categoryName,
    );
  }
}
