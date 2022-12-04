import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/engineer.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/user/user.dart';
import 'package:comunidade_de_engenheiros_de_software/api/service/UserService.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/profile/edit/profile_view_model.dart';
import 'package:comunidade_de_engenheiros_de_software/util/app_color.dart';
import 'package:comunidade_de_engenheiros_de_software/util/base/constants.dart';
import 'package:comunidade_de_engenheiros_de_software/util/global/format.dart';
import 'package:comunidade_de_engenheiros_de_software/util/global/pair.dart';
import 'package:comunidade_de_engenheiros_de_software/util/view/app_button.dart';
import 'package:comunidade_de_engenheiros_de_software/util/view/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final MaskTextInputFormatter phoneMask = MaskTextInputFormatter(mask: "(##) #####-####", filter: {"#": RegExp('[0-9]')});

  final ProfileViewModel viewModel = ProfileViewModel(service: getIt<UserService>());

  Pair<Engineer, User>? _dataUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar perfil'),
      ),
      body: SafeArea(
        child: Builder(
          builder: (_) {
            final data = _dataUser;
            if (data == null) {
              return FutureBuilder<Pair<Engineer, User>>(
                future: viewModel.getEngineer(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
                  if (!snapshot.hasData) return const Center(child: Text('Ocorreu um erro interno'));
                  _dataUser = snapshot.data!;

                  final user = snapshot.data!.second;
                  final engineer = snapshot.data!.first;

                  nameController.text = engineer.nickname;
                  emailController.text = user.email ?? "";
                  birthdayController.text = Format.formatDate(engineer.birthday, format: "dd/MM/yyyy");
                  locationController.text = engineer.address;
                  phoneController.text = phoneMask.maskText(engineer.phone);

                  return _child(user, engineer);
                },
              );
            }

            return _child(data.second, data.first);
          },
        ),
      ),
    );
  }

  Widget _child(User user, Engineer engineer) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Wrap(
          spacing: 16,
          runSpacing: 24,
          children: [
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Nome',
                labelText: 'Nome',
              ),
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Email',
                labelText: 'Email',
              ),
            ),
            TextFormField(
              controller: birthdayController,
              keyboardType: TextInputType.none,
              decoration: const InputDecoration(
                hintText: 'Data de nascimento',
                labelText: 'Data de nascimento',
              ),
              onTap: () async {
                FocusScope.of(context).unfocus();
                final DateTime? startTime = await _getDate(context);
                if (startTime != null) {
                  birthdayController.text = Format.formatDateTime(startTime, format: 'dd/MM/yyyy');
                }
              },
            ),
            TextFormField(
              controller: locationController,
              keyboardType: TextInputType.streetAddress,
              decoration: const InputDecoration(
                hintText: 'Endereço',
                labelText: 'Endereço',
              ),
            ),
            TextFormField(
              controller: phoneController,
              inputFormatters: [phoneMask],
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Celular',
                labelText: 'Celular',
              ),
            ),
            const SizedBox(height: 32),
            AppButton(
              onPressed: () async {
                final navigator = Navigator.of(context);
                final scaffold = ScaffoldMessenger.of(context);

                final loading = LoadingControl();
                showDialog(context: context, builder: (_) => loading.create(), barrierDismissible: false);

                user.email = emailController.text;
                engineer.phone = phoneMask.getUnmaskedText();
                engineer.birthday = Format.formatDate(birthdayController.text, format: "yyyy-MM-dd", current: "dd/MM/yyyy");
                engineer.nickname = nameController.text;
                engineer.address = locationController.text;

                final bool isLogged = await viewModel.updateUser(user, engineer);

                loading.close();
                if (isLogged) {
                  navigator.pop(true);
                } else {
                  scaffold.showSnackBar(const SnackBar(content: Text('Não foi possível atualizar seu perfil')));
                }
              },
              text: 'Atualizar',
              padding: const EdgeInsets.symmetric(horizontal: 32),
              minHeight: 56,
              color: AppColor.secondColor,
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> _getDate(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.fromMicrosecondsSinceEpoch(0),
      lastDate: DateTime.now(),
    );
  }
}
