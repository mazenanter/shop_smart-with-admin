import 'package:ecommerce_app_firebase/core/widgets/text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

AppBar customDetailsAppBar(BuildContext context, bool isShow, String title,
    {IconData icon = IconlyLight.bag,
    bool showBadge = true,
    void Function()? onPreess}) {
  return AppBar(
    elevation: 0,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back_ios_new,
      ),
    ),
    centerTitle: true,
    title: TextTitle(
      label: title,
      color: Colors.purple,
    ),
    actions: [
      if (isShow)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(12),
            child: showBadge
                ? Badge(
                    backgroundColor: Colors.red,
                    alignment: AlignmentDirectional.topStart,
                    label: const Text('5'),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        icon,
                        color: Colors.black,
                      ),
                    ),
                  )
                : IconButton(
                    onPressed: onPreess,
                    icon: Icon(
                      icon,
                      color: Colors.black,
                    ),
                  ),
          ),
        ),
    ],
  );
}
