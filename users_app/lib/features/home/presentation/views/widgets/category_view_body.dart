// import 'package:ecommerce_app_firebase/core/widgets/cusom_product_item.dart';
// import 'package:ecommerce_app_firebase/core/widgets/text_title.dart';
// import 'package:ecommerce_app_firebase/features/home/data/repos/home_repo_impl.dart';
// import 'package:ecommerce_app_firebase/features/search/data/models/product_model.dart';
// import 'package:ecommerce_app_firebase/features/search/presentation/views/widgets/custom_search_text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class CategoryViewBody extends StatelessWidget {
//   const CategoryViewBody({super.key, required this.categoryName});
//   final String categoryName;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const CustomSearchTextField(),
//           const SizedBox(
//             height: 20,
//           ),
//           StreamBuilder<List<ProductModel>>(
//             stream:
//                 HomeRepoImpl().fetchProductsByCategory(category: categoryName),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Expanded(
//                     child: Center(
//                         child: TextTitle(
//                   label: 'Loading...',
//                   fontSize: 22,
//                 )));
//               } else if (snapshot.hasError) {
//                 return Center(child: Text(snapshot.error.toString()));
//               } else if (snapshot.data!.isEmpty) {
//                 return const Expanded(
//                   child: Center(
//                     child: TextTitle(
//                       label: 'No Products Found ',
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 );
//               }
//               return Expanded(
//                 child: GridView.builder(
//                   itemCount: snapshot.data!.length,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 2 / 3,
//                     crossAxisSpacing: 12,
//                   ),
//                   itemBuilder: (context, index) => CustomProductItem(
//                     productImage: snapshot.data![index].productImage,
//                     productTitle: snapshot.data![index].productTitle,
//                     productPrice: snapshot.data![index].productPrice,
//                     productModel: snapshot.data![index],
//                     productId: snapshot.data![index].productId,
//                     qty: 1,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
