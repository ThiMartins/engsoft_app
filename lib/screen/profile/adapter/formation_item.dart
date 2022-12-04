import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/formation.dart';
import 'package:comunidade_de_engenheiros_de_software/util/app_color.dart';
import 'package:comunidade_de_engenheiros_de_software/util/global/format.dart';
import 'package:flutter/material.dart';

class FormationItem extends StatelessWidget {
  final Formation formation;

  const FormationItem({Key? key, required this.formation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(color: AppColor.primaryColorDark, borderRadius: BorderRadius.circular(25)),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formation.institution,
                style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                '${Format.formatDate(formation.dateStart, format: "MMM'/'yyyy")} - ${Format.formatDate(formation.dateFinish, format: "MMM'/'yyyy")}',
                style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12),
              )
            ],
          )
        ],
      ),
    );
  }
}
