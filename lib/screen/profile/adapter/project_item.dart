import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/project.dart';
import 'package:comunidade_de_engenheiros_de_software/util/app_color.dart';
import 'package:flutter/material.dart';

class ProjectItem extends StatelessWidget {
  final Project project;

  const ProjectItem({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.name,
          style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          project.info,
          style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(color: AppColor.primaryColorDark, borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(width: 8),
            Text(
              project.functions,
              style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
            )
          ],
        ),
        const SizedBox(height: 8),
        Text(
          project.goals,
          style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12),
        ),
      ],
    );
  }
}
