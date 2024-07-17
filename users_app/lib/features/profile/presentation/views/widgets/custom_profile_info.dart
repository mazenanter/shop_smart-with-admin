import 'package:ecommerce_app_firebase/core/widgets/sub_title_text.dart';
import 'package:ecommerce_app_firebase/core/widgets/text_title.dart';
import 'package:ecommerce_app_firebase/features/profile/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomProfileInfo extends StatelessWidget {
  const CustomProfileInfo({
    super.key,
    this.userModel,
  });
  final UserModel? userModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.1,
          width: MediaQuery.sizeOf(context).height * 0.1,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).cardColor,
            border: Border.all(
              width: 4,
              color: Theme.of(context).colorScheme.background,
            ),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                userModel?.image ??
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextTitle(
                label: userModel!.name,
                maxLines: 1,
              ),
              SubTitleText(
                label: userModel!.email,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
