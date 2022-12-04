
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProjectPage extends StatelessWidget {
  ProjectPage({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController goalsController = TextEditingController();
  final TextEditingController dateStartController = TextEditingController();
  final TextEditingController dateFinishController = TextEditingController();
  final TextEditingController functionsController = TextEditingController();
  final TextEditingController technologiesController = TextEditingController();

  final MaskTextInputFormatter dateStartMask = MaskTextInputFormatter(mask: '##/##/####', filter: { '#' : RegExp('[0.9]')});
  final MaskTextInputFormatter dateFinishMask = MaskTextInputFormatter(mask: '##/##/####', filter: { '#' : RegExp('[0.9]')});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
