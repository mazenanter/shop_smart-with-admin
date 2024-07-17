import 'package:ecommerce_app_firebase/core/widgets/cusom_product_item.dart';
import 'package:ecommerce_app_firebase/core/widgets/custom_app_title.dart';
import 'package:ecommerce_app_firebase/core/widgets/text_title.dart';
import 'package:ecommerce_app_firebase/features/home/data/repos/home_repo_impl.dart';
import 'package:ecommerce_app_firebase/features/search/data/models/product_model.dart';
import 'package:ecommerce_app_firebase/features/search/data/repos/search_repo_impl.dart';
import 'package:ecommerce_app_firebase/features/search/presentation/manager/search_product_cubit/search_product_cubit.dart';
import 'package:ecommerce_app_firebase/features/search/presentation/views/widgets/custom_search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody(
      {super.key, required this.categoryName, required this.appBarTitle});
  final String categoryName;
  final Widget appBarTitle;

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  final Map<String, bool> addedToCart = {};
  final Map<String, bool> addedToWishlist = {};
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchProductCubit, SearchProductState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
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
                widget.categoryName == ''
                    ? const CustomAppTitle()
                    : TextTitle(label: widget.categoryName),
              ],
            ),
            leading: widget.categoryName != ''
                ? IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 20,
                    ),
                  )
                : null,
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSearchTextField(
                  onChanged: (p0) {
                    BlocProvider.of<SearchProductCubit>(context)
                        .searchProducts(searchText: p0);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocProvider.of<SearchProductCubit>(context).searchList ==
                            null ||
                        BlocProvider.of<SearchProductCubit>(context)
                            .searchList!
                            .isEmpty
                    ? StreamBuilder<List<ProductModel>>(
                        stream: widget.categoryName == ''
                            ? SearchRepoImpl().fetchAllProducts()
                            : HomeRepoImpl().fetchProductsByCategory(
                                category: widget.categoryName),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Expanded(
                                child: Center(
                                    child: TextTitle(
                              label: 'Loading...',
                              fontSize: 22,
                            )));
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text(snapshot.error.toString()));
                          } else if (snapshot.data!.isEmpty) {
                            return const Expanded(
                              child: Center(
                                child: TextTitle(
                                  label: 'No Products Found ',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }
                          return Expanded(
                            child: GridView.builder(
                                itemCount: snapshot.data!.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 2 / 3,
                                  crossAxisSpacing: 12,
                                ),
                                itemBuilder: (context, index) {
                                  final product = snapshot.data![index];
                                  final isAdded =
                                      addedToCart[product.productId] ?? false;
                                  final isAddedToWishlist =
                                      addedToWishlist[product.productId] ??
                                          false;
                                  return CustomProductItem(
                                    isAddedToWishlist: isAddedToWishlist,
                                    onAddToWishlist: (productId) {
                                      setState(() {
                                        addedToWishlist[productId] = true;
                                      });
                                    },
                                    isAdded: isAdded,
                                    onAddToCart: (productId) {
                                      setState(() {
                                        addedToCart[productId] = true;
                                      });
                                    },
                                    productImage: product.productImage,
                                    productTitle: product.productTitle,
                                    productPrice: product.productPrice,
                                    productModel: product,
                                    productId: product.productId,
                                    qty: 1,
                                  );
                                }),
                          );
                        },
                      )
                    : Expanded(
                        child: GridView.builder(
                            itemCount:
                                BlocProvider.of<SearchProductCubit>(context)
                                    .searchList!
                                    .length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2 / 3,
                              crossAxisSpacing: 12,
                            ),
                            itemBuilder: (context, index) {
                              final product =
                                  BlocProvider.of<SearchProductCubit>(context)
                                      .searchList![index];
                              final isAdded =
                                  addedToCart[product.productId] ?? false;
                              final isAddedToWishlist =
                                  addedToWishlist[product.productId] ?? false;
                              return CustomProductItem(
                                isAddedToWishlist: isAddedToWishlist,
                                onAddToWishlist: (productId) {
                                  setState(() {
                                    addedToWishlist[productId] = true;
                                  });
                                },
                                isAdded: isAdded,
                                onAddToCart: (productId) {
                                  setState(() {
                                    addedToCart[productId] = true;
                                  });
                                },
                                productImage: product.productImage,
                                productTitle: product.productTitle,
                                productPrice: product.productPrice,
                                productModel: product,
                                productId: product.productId,
                                qty: 1,
                              );
                            }),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
