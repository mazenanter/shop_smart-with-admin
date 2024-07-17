import 'dart:io';

import 'package:admin_app/features/home/data/repos/dashboard_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit(this.productRepo) : super(AddProductInitial());
  final DashboardRepo productRepo;
  String? categoryValue;
  void uploadProduct({
    required String productTitle,
    required String productPrice,
    required String productCategory,
    required String productDescription,
    required File pickedImage,
    required String productImage,
    required String productQty,
  }) async {
    emit(AddProductLoading());
    await productRepo.uploadProduct(
      productTitle: productTitle,
      productPrice: productPrice,
      productCategory: productCategory,
      productDescription: productDescription,
      productImage: productImage,
      productQty: productQty,
      pickedImage: pickedImage,
    );
    emit(AddProductSuccess());
  }

  void editProduct({
    required String productId,
    required String productTitle,
    required String productPrice,
    required String productCategory,
    required String productDescription,
    required File pickedImage,
    required String productImage,
    required String productQty,
  }) async {
    emit(AddProductLoading());
    await productRepo.editProduct(
      productId: productId,
      productTitle: productTitle,
      productPrice: productPrice,
      productCategory: productCategory,
      productDescription: productDescription,
      productImage: productImage,
      productQty: productQty,
      pickedImage: pickedImage,
    );
    emit(AddProductSuccess());
  }
}
