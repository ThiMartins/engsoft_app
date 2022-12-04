import 'package:comunidade_de_engenheiros_de_software/util/app_color.dart';
import 'package:comunidade_de_engenheiros_de_software/util/view/app_button.dart';
import 'package:flutter/material.dart';

class ContentList extends StatelessWidget {
  final int length;
  final IndexedWidgetBuilder itemBuilder;
  final String title;
  final EdgeInsetsGeometry? padding;
  final bool canEdit;
  late final VoidCallback? onInsert;
  late final ValueChanged<int>? onDelete;
  late final ValueChanged<int>? onChange;

  late final bool _disableClick;

  ContentList({
    Key? key,
    this.padding,
    required this.length,
    required this.itemBuilder,
    required this.title,
    this.canEdit = false,
    VoidCallback? onInsert,
    ValueChanged<int>? onDelete,
    ValueChanged<int>? onChange,
    bool disableClick = true
  }) : super(key: key) {
    _disableClick = disableClick;
    if (disableClick) {
      this.onInsert = onInsert;
      this.onDelete = onDelete;
      this.onChange = onChange;
    } else {
      this.onInsert = null;
      this.onDelete = null;
      this.onChange = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColor.borderColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Text(
                title,
                style: Theme
                    .of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontSize: 20),
              ),
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final view = itemBuilder(context, index);
                if (!canEdit) return view;

                return InkWell(
                  onTap: () {
                    print("OnClick");
                    if (onChange != null) onChange!(index);
                    if (!_disableClick) _showDisableClick(context);
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: view,
                      ),
                      IconButton(
                        onPressed: () {
                          if (onDelete != null) onDelete!(index);
                          if (!_disableClick) _showDisableClick(context);
                        },
                        icon: const Icon(Icons.delete_forever),
                      ),
                    ],
                  ),
                );
              },
              itemCount: length,
              separatorBuilder: (BuildContext context, int index) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      color: AppColor.borderColor,
                      height: 1,
                    ),
                  ),
            ),
            Visibility(
              visible: canEdit,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
                child: AppButton(
                  onPressed: () {
                    if (onInsert != null) onInsert!();
                    if (!_disableClick) _showDisableClick(context);
                  },
                  text: 'Adicionar',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showDisableClick(BuildContext context) {
    showDialog(context: context, builder: (alert) {
      return AlertDialog(
        title: Text('Edição bloqueada', style: Theme.of(context).textTheme.headline2,),
        content: const Text('Seu perfil está desativado ou em aprovação'),
        actions: [
          TextButton(onPressed: () { Navigator.pop(alert); } , child: const Text('Ok'))
        ],
      );
    });
  }

}
