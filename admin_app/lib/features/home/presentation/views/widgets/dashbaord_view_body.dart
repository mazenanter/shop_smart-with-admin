import 'package:admin_app/core/utils/theme_cubit/theme_cubit.dart';
import 'package:admin_app/core/widgets/custom_app_title.dart';
import 'package:admin_app/features/home/presentation/consts.dart';
import 'package:admin_app/features/home/presentation/views/add_new_product_view.dart';
import 'package:admin_app/features/home/presentation/views/inspect_all_product_view.dart';
import 'package:admin_app/features/home/presentation/views/orders_view.dart';
import 'package:admin_app/features/home/presentation/views/widgets/custom_dashboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardViewBody extends StatelessWidget {
  const DashboardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Image.asset(
                height: 40,
                'assets/images/bag/shopping_cart.png',
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const CustomAppTitle(),
          ],
        ),
        actions: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  BlocProvider.of<ThemeCubit>(context).setDark(
                    value: !BlocProvider.of<ThemeCubit>(context).isDark,
                  );
                  BlocProvider.of<ThemeCubit>(context).changeIcon();
                },
                icon: Icon(
                  BlocProvider.of<ThemeCubit>(context).icon,
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemCount: 3,
          itemBuilder: (context, index) => CustomDashboardWidget(
            image: AppConsts.dashboardImages[index].image,
            title: AppConsts.dashboardImages[index].title,
            onTap: () {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddNewProductView(),
                  ),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InspectAllProductView(),
                  ),
                );
              } else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrdersView(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
