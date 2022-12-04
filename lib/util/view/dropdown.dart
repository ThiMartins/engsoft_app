import 'package:comunidade_de_engenheiros_de_software/util/app_color.dart';
import 'package:flutter/material.dart';

class AppDropdown<T> extends StatefulWidget {
  final List<T> items;
  final ValueChanged<T> onChange;

  AppDropdown({
    Key? key,
    required this.items,
    required this.onChange,
  })
      : assert(items.isNotEmpty, "Não pode ser uma lista vazia"),
        super(key: key);

  @override
  State<AppDropdown> createState() => _AppDropdownState<T>();
}

class _AppDropdownState<T> extends State<AppDropdown<T>> {
  late T dropdownValue = widget.items.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      isExpanded: true,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward, size: 16,),
      elevation: 16,
      style: Theme
          .of(context)
          .textTheme
          .headline6,
      underline: Container(
        height: 1,
        width: double.infinity,
        color: AppColor.primaryColorDark,
      ),
      onChanged: (T? value) {
        setState(() {
          dropdownValue = value as T;
        });
        widget.onChange(value!);
      },
      items: widget.items.map<DropdownMenuItem<T>>((value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(value.toString()),
          );
        },
      ).toList(),
    );
  }
}
