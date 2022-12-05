import 'package:comunidade_de_engenheiros_de_software/api/service/AuthService.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/login/create/create_account_page.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/login/login_view_model.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/login/recovery/recovery_password_page.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/main/main_page.dart';
import 'package:comunidade_de_engenheiros_de_software/util/app_color.dart';
import 'package:comunidade_de_engenheiros_de_software/util/base/constants.dart';
import 'package:comunidade_de_engenheiros_de_software/util/view/app_button.dart';
import 'package:comunidade_de_engenheiros_de_software/util/view/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController cpfController = TextEditingController();
  final MaskTextInputFormatter cpfMask = MaskTextInputFormatter(
      mask: "###.###.###-##", filter: {"#": RegExp('[0-9]')});

  final TextEditingController passwordController = TextEditingController();

  final LoginViewModel viewModel =
      LoginViewModel(authService: getIt<AuthService>());

  double _maxSize = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, viewportConstraints) {
            if (viewportConstraints.maxHeight > _maxSize) {
              _maxSize = viewportConstraints.maxHeight;
            }
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: _maxSize),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(75),
                      child: Image.asset(
                        'images/icon.jpg',
                        fit: BoxFit.cover,
                        width: 150,
                        height: 150,
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 32),
                      child: TextFormField(
                        controller: cpfController,
                        inputFormatters: [cpfMask],
                        decoration: const InputDecoration(
                          labelText: 'CPF',
                          hintText: 'CPF',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          hintText: 'Password',
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 32, right: 32, top: 32),
                      child: Row(
                        children: [
                          const Spacer(),
                          TextButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => RecoveryPasswordPage())),
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColor.buttonTextColor),
                                overlayColor:
                                    MaterialStateProperty.all(Colors.white10)),
                            child: const Text('Perdeu a senha?'),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    AppButton(
                      onPressed: () async {
                        final navigator = Navigator.of(context);
                        final loading = LoadingControl();
                        showDialog(
                            context: context,
                            builder: (_) => loading.create(),
                            barrierDismissible: false);
                        final isLogged = await viewModel.login(
                            cpfMask.getUnmaskedText(), passwordController.text);
                        loading.close();
                        if (isLogged) {
                          navigator.pushReplacement(MaterialPageRoute(
                              builder: (_) => const MainPage()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Email ou senha incorreto')));
                        }
                      },
                      text: 'Login',
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      minHeight: 56,
                      color: AppColor.secondColor,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AppButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CreateAccountPage())),
                      text: 'Não possui conta? Crie agora',
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      minHeight: 56,
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
