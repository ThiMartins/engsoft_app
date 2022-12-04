import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/experience.dart';
import 'package:comunidade_de_engenheiros_de_software/util/app_color.dart';
import 'package:flutter/material.dart';

class ExperienceItem extends StatelessWidget {
  final Experience experience;

  const ExperienceItem({Key? key, required this.experience}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: AppColor.primaryColorDark,
            borderRadius: BorderRadius.circular(25)
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              experience.enterprise,
              style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              experience.info,
              style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12),
            )
          ],
        )
      ],
    );
  }
}
