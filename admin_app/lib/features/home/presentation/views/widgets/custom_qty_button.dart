import 'package:admin_app/core/widgets/text_title.dart';
import 'package:admin_app/features/home/presentation/consts.dart';
import 'package:admin_app/features/home/presentation/manager/add_product_cubit/add_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomQuantityButton extends StatefulWidget {
  const CustomQuantityButton({
    super.key,
  });

  @override
  State<CustomQuantityButton> createState() => _CustomQuantityButtonState();
}

class _CustomQuantityButtonState extends State<CustomQuantityButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: OutlinedButton.icon(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            context: context,
            builder: (context) {
              return SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.6,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Container(
                        height: 6,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              BlocProvider.of<AddProductCubit>(context)
                                  .categoryValue = AppConsts.categories[index];
                              setState(() {});
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: TextTitle(
                                      label: AppConsts.categories[index])),
                            ),
                          ),
                          itemCount: AppConsts.categories.length,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        label: TextTitle(
          label: BlocProvider.of<AddProductCubit>(context).categoryValue == null
              ? "Select category"
              : BlocProvider.of<AddProductCubit>(context).categoryValue!,
          color: Colors.deepPurple,
        ),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.deepPurple,
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Theme.of(context).scaffoldBackgroundColor,
          side: const BorderSide(width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }
}
