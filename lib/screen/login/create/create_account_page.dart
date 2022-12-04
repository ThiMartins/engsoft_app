import 'package:comunidade_de_engenheiros_de_software/api/model/user/create_user.dart';
import 'package:comunidade_de_engenheiros_de_software/api/service/AuthService.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/login/login_view_model.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/main/main_page.dart';
import 'package:comunidade_de_engenheiros_de_software/util/app_color.dart';
import 'package:comunidade_de_engenheiros_de_software/util/base/constants.dart';
import 'package:comunidade_de_engenheiros_de_software/util/global/format.dart';
import 'package:comunidade_de_engenheiros_de_software/util/view/app_button.dart';
import 'package:comunidade_de_engenheiros_de_software/util/view/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final MaskTextInputFormatter cpfMask = MaskTextInputFormatter(mask: "###.###.###-##", filter: {"#": RegExp('[0-9]')});
  final MaskTextInputFormatter phoneMask = MaskTextInputFormatter(mask: "(##) #####-####", filter: {"#": RegExp('[0-9]')});

  final LoginViewModel viewModel = LoginViewModel(authService: getIt<AuthService>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
      ),
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
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
                  controller: cpfController,
                  inputFormatters: [cpfMask],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'CPF',
                    labelText: 'CPF',
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
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    hintText: 'Senha',
                    labelText: 'Senha',
                  ),
                ),
                const SizedBox(height: 32),
                AppButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    final navigator = Navigator.of(context);
                    final scaffold = ScaffoldMessenger.of(context);

                    final loading = LoadingControl();
                    showDialog(context: context, builder: (_) => loading.create(), barrierDismissible: false);
                    final isLogged = await viewModel.create(CreateUser(
                      name: nameController.text,
                      cpf: cpfMask.getUnmaskedText(),
                      email: emailController.text,
                      password: passwordController.text,
                      birthday: Format.formatDate(birthdayController.text, format: "yyyy-MM-dd", current: "dd/MM/yyyy"),
                      location: locationController.text,
                      phone: phoneMask.getUnmaskedText(),
                    )).catchError((e) {
                      scaffold.showSnackBar(SnackBar(content: Text(e.message)));
                    });
                    loading.close();
                    if (isLogged != null) {
                      navigator.pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const MainPage()), (route) => false);
                    }
                  },
                  text: 'Criar conta',
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  minHeight: 56,
                  color: AppColor.secondColor,
                ),
              ],
            ),
          ),
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
