import 'package:admin_app/core/widgets/text_title.dart';
import 'package:admin_app/features/home/data/models/product_model.dart';
import 'package:admin_app/features/home/data/repos/dashboard_repo_impl.dart';
import 'package:admin_app/features/home/presentation/views/widgets/add_new_product_view_body.dart';
import 'package:admin_app/features/home/presentation/views/widgets/custom_product_item.dart';
import 'package:admin_app/features/home/presentation/views/widgets/custom_products_text_field.dart';
import 'package:flutter/material.dart';

class InspectAllProductsViewBody extends StatelessWidget {
  const InspectAllProductsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomSearchTextField(),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<List<ProductModel>>(
              stream: DashboardRepoImpl().fetchAllProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Expanded(
                    child: Center(
                      child: TextTitle(
                        label: 'Loading...',
                        fontSize: 22,
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return TextTitle(label: snapshot.error.toString());
                }
                return Expanded(
                  child: GridView.builder(
                    itemCount: snapshot.data!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 3.9,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 5,
                    ),
                    itemBuilder: (context, index) => CustomProductItem(
                      productImage: snapshot.data![index].productImage,
                      productTitle: snapshot.data![index].productTitle,
                      productPrice: snapshot.data![index].productPrice,
                      onPressItem: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddNewProductViewBody(
                              productModel: snapshot.data![index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
