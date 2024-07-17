import 'package:ecommerce_app_firebase/core/widgets/cusom_product_item.dart';
import 'package:ecommerce_app_firebase/core/widgets/custom_dialog.dart';
import 'package:ecommerce_app_firebase/core/widgets/empty_bag_widget.dart';
import 'package:ecommerce_app_firebase/features/home/presentation/views/widgets/custom_details_app_bar.dart';
import 'package:ecommerce_app_firebase/features/profile/data/repos/profile_repo_impl.dart';
import 'package:ecommerce_app_firebase/features/profile/presentation/manager/fetch_wishlist_items_cubit/fetch_wishlist_items_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistViewBody extends StatelessWidget {
  const WishlistViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FetchWishlistItemsCubit(ProfileRepoImpl())..fetchWishlistItem(),
      child: BlocConsumer<FetchWishlistItemsCubit, FetchWishlistItemsState>(
        listener: (context, state) {
          if (state is RemoveAllItemSuccess) {
            BlocProvider.of<FetchWishlistItemsCubit>(context)
                .fetchWishlistItem();
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          var list =
              BlocProvider.of<FetchWishlistItemsCubit>(context).wishlistItems;
          return list.isEmpty
              ? const Scaffold(
                  body: EmptyBagWidget(
                    image: 'assets/images/bag/bag_wish.png',
                    title: 'Your wishlist is empty',
                    subTitle: 'Seems like you dont have any wishes here',
                    buttonTitle: 'Make a wish now',
                  ),
                )
              : Scaffold(
                  appBar: customDetailsAppBar(
                    context,
                    true,
                    state is FetchWishlistItemsSuccess
                        ? 'Wishlist(${state.wishlistItems.length})'
                        : '',
                    icon: Icons.delete_forever,
                    showBadge: false,
                    onPreess: () {
                      customDialog(
                        context,
                        () {
                          BlocProvider.of<FetchWishlistItemsCubit>(context)
                              .removeAllItemsFromWishlist();
                        },
                        'Are you sure to delete all items',
                      );
                    },
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: list.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) => CustomProductItem(
                        isAddedToWishlist: false,
                        onAddToWishlist: (p0) {},
                        isAdded: false,
                        onAddToCart: (p0) {},
                        productId: list[index].productId,
                        qty: 1,
                        tapItem: false,
                        productImage: list[index].productImage,
                        productPrice: list[index].productPrice,
                        productTitle: list[index].productTitle,
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
