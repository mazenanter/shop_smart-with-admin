import 'package:flutter/material.dart';

class CustomDashboardWidget extends StatelessWidget {
  const CustomDashboardWidget({
    super.key,
    required this.image,
    required this.title,
    this.onTap,
  });
  final String image, title;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              12,
            ),
            color: Colors.deepPurple[50],
            boxShadow: const [
              BoxShadow(blurRadius: 0.5, offset: Offset(1, 1)),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              width: MediaQuery.sizeOf(context).width * 0.2,
              height: MediaQuery.sizeOf(context).height * 0.1,
              image,
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
