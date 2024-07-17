import 'dart:developer';
import 'dart:io';
import 'package:admin_app/features/home/data/models/product_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:admin_app/core/error/error_dialog.dart';
import 'package:admin_app/core/widgets/custom_dialog.dart';
import 'package:admin_app/core/widgets/image_picker_service.dart';
import 'package:admin_app/core/widgets/text_title.dart';
import 'package:admin_app/features/home/presentation/manager/add_product_cubit/add_product_cubit.dart';
import 'package:admin_app/features/home/presentation/views/widgets/custom_button.dart';
import 'package:admin_app/features/home/presentation/views/widgets/custom_image_picked_widget.dart';
import 'package:admin_app/features/home/presentation/views/widgets/custom_product_image_pick_widget.dart';
import 'package:admin_app/features/home/presentation/views/widgets/custom_qty_button.dart';
import 'package:admin_app/features/home/presentation/views/widgets/custom_text_field.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewProductViewBody extends StatefulWidget {
  const AddNewProductViewBody({super.key, this.productModel});
  final ProductModel? productModel;

  @override
  State<AddNewProductViewBody> createState() => _AddNewProductViewBodyState();
}

class _AddNewProductViewBodyState extends State<AddNewProductViewBody> {
  var titleController = TextEditingController();
  var priceController = TextEditingController();
  var qtyController = TextEditingController();
  var descriptionController = TextEditingController();
  File? imagePicked;
  String? productImage;
  String? qtyValue;

  bool isEditing = false;
  @override
  void initState() {
    super.initState();
    if (widget.productModel != null) {
      isEditing = true;
      // productImage = widget.productModel!.productImage;
      titleController.text = widget.productModel!.productTitle;
      priceController.text = widget.productModel!.productPrice;
      qtyController.text = widget.productModel!.productQty;
      descriptionController.text = widget.productModel!.productDescription;
    } else {
      isEditing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddProductCubit, AddProductState>(
      listener: (context, state) {
        if (state is AddProductSuccess) {
          Fluttertoast.showToast(
              msg: 'Product uploaded',
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 20,
              ),
            ),
            title: TextTitle(
              label: isEditing ? 'Edit Product' : 'Upload a new product',
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  ConditionalBuilder(
                    condition: imagePicked == null,
                    builder: (context) => CusgtomProductImagePickWidget(
                      cameraPress: () async {
                        imagePicked =
                            await ImagePickerService.pickImageFromCamera(
                          image: imagePicked,
                        );
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                        setState(() {});
                      },
                      galleryPress: () async {
                        imagePicked =
                            await ImagePickerService.pickImageFromGallery(
                          image: imagePicked,
                        );
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                        setState(() {});
                      },
                      removePress: () {
                        imagePicked = null;
                        Navigator.pop(context);
                        setState(() {});
                      },
                    ),
                    fallback: (context) => CustomImagePickedWidget(
                      file: imagePicked,
                      removePress: () {
                        imagePicked = null;
                        setState(() {});
                      },
                      editPress: () {
                        customDialog(
                          context,
                          () async {
                            imagePicked =
                                await ImagePickerService.pickImageFromCamera(
                                    image: imagePicked);
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            setState(() {});
                          },
                          () async {
                            imagePicked =
                                await ImagePickerService.pickImageFromGallery(
                                    image: imagePicked);
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            setState(() {});
                          },
                          () {
                            imagePicked = null;
                            Navigator.pop(context);
                            setState(() {});
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomQuantityButton(),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    textController: titleController,
                    title: 'Product title',
                    maxLength: 80,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: CustomTextField(
                        textController: priceController,
                        keyboardType: TextInputType.number,
                        title: 'Price',
                        prefix: const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: TextTitle(
                            label: '\$',
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: CustomTextField(
                        textController: qtyController,
                        keyboardType: TextInputType.number,
                        title: 'Qty',
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    textController: descriptionController,
                    title: 'Product description',
                    maxLine: 3,
                    maxLength: 1000,
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.08,
                  ),
                ],
              ),
            ),
          ),
          bottomSheet: ConditionalBuilder(
            condition: state is AddProductLoading,
            builder: (context) => const Center(
                child: TextTitle(
              label: 'Loading...',
            )),
            fallback: (context) => Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  CustomButton(
                    onPressButton: () {
                      titleController.clear();
                      descriptionController.clear();
                      priceController.clear();
                      qtyController.clear();
                      BlocProvider.of<AddProductCubit>(context).categoryValue =
                          null;
                      imagePicked = null;

                      setState(() {});
                    },
                    title: 'Clear',
                    icon: Icons.close,
                    bgkColor: Colors.red,
                    iconColor: Colors.white,
                    textColor: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomButton(
                      onPressButton: () {
                        if (BlocProvider.of<AddProductCubit>(context)
                                .categoryValue ==
                            null) {
                          log('is NULLL');
                        } else if (imagePicked == null) {
                          customErrorDialog(context, 'Image is required');
                        } else {
                          if (isEditing) {
                            BlocProvider.of<AddProductCubit>(context)
                                .editProduct(
                              productId: widget.productModel!.productId,
                              productTitle: titleController.text,
                              productPrice: priceController.text,
                              productCategory:
                                  BlocProvider.of<AddProductCubit>(context)
                                      .categoryValue!,
                              productDescription: descriptionController.text,
                              pickedImage: imagePicked!,
                              productImage: imagePicked.toString(),
                              productQty: qtyController.text,
                            );
                          } else {
                            BlocProvider.of<AddProductCubit>(context)
                                .uploadProduct(
                              productTitle: titleController.text,
                              productPrice: priceController.text,
                              productCategory:
                                  BlocProvider.of<AddProductCubit>(context)
                                      .categoryValue!,
                              productDescription: descriptionController.text,
                              pickedImage: imagePicked!,
                              productImage: imagePicked.toString(),
                              productQty: qtyController.text,
                            );
                          }
                        }
                      },
                      title: isEditing ? 'Edit Product' : 'Upload product',
                      icon: Icons.upload,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
