import 'dart:io';

import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/engineer.dart';
import 'package:comunidade_de_engenheiros_de_software/api/service/provider_test.dart';
import 'package:comunidade_de_engenheiros_de_software/util/app_color.dart';
import 'package:comunidade_de_engenheiros_de_software/util/base/constants.dart';
import 'package:comunidade_de_engenheiros_de_software/util/view/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../api/service/UserService.dart';
import '../../profile/edit/profile_view_model.dart';

class EngineerItem extends StatelessWidget {
  final Engineer engineer;
  final ValueChanged<Engineer> onClick;
  final ValueChanged<Engineer>? onClickState;
  final ValueChanged<Engineer>? onApprovedChange;
  final bool showSecondButton;

  const EngineerItem({
    Key? key,
    required this.engineer,
    required this.onClick,
    this.onClickState,
    this.showSecondButton = true,
    this.onApprovedChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Builder(builder: (_) {
                  final fileImg = usersImagesTest[engineer.id];
                  final urlImg = engineer.picture;

                  if (fileImg != null) {
                    return Image.file(
                      File(fileImg.path),
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                    );
                  }

                  if (urlImg == null || urlImg.isEmpty) {
                    return const Icon(
                      Icons.person,
                      size: 50,
                    );
                  }
                  return Image.network(
                    engineer.picture,
                    loadingBuilder: (_, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        color: AppColor.primaryColorDark,
                      );
                    },
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  );
                }),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    engineer.nickname,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    engineer.profile,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 12),
                  ),
                  Text(
                    engineer.address,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 12),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 66),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Visibility(
                    child: AppButton(
                      radius: 10,
                      color: Colors.transparent,
                      colorText: AppColor.textColor,
                      onPressed: () => onClick(engineer),
                      text: 'Exibir',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                /*
                Visibility(
                  visible: showSecondButton,
                  child: Expanded(
                    flex: 3,
                    child: Visibility(
                      child: AppButton(
                        radius: 10,
                        color: Colors.transparent,
                        colorText: AppColor.textColor,
                        onPressed: () {
                          if (onApprovedChange != null)
                            onApprovedChange!(engineer);
                        },
                        text: true ? 'Desativar' : 'Ativar',
                      ),
                    ),
                  ),
                ),
                */
                const SizedBox(width: 16),
                Visibility(
                  visible: showSecondButton,
                  child: Expanded(
                    flex: 3,
                    child: AppButton(
                      radius: 10,
                      color: Colors.transparent,
                      colorText: AppColor.textColor,
                      onPressed: () {
                        if (onClickState != null) onClickState!(engineer);
                      },
                      text: engineer.isApproved ? 'Desaprovar' : 'Aprovar',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: AppColor.primaryColorLight,
            margin: const EdgeInsets.only(left: 66),
          )
        ],
      ),
    );
  }
}
