// import 'package:ecommerce_app_firebase/core/widgets/text_title.dart';
// import 'package:ecommerce_app_firebase/features/home/presentation/views/widgets/category_view_body.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class CategoryView extends StatelessWidget {
//   const CategoryView({super.key, required this.categoryName});
//   final String categoryName;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios_new_outlined,
//             size: 20,
//           ),
//         ),
//         title: TextTitle(
//           label: categoryName,
//         ),
//       ),
//       body: CategoryViewBody(
//         categoryName: categoryName,
//       ),
//     );
//   }
// }
