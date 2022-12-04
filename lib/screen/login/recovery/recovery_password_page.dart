import 'package:comunidade_de_engenheiros_de_software/api/service/AuthService.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/login/login_view_model.dart';
import 'package:comunidade_de_engenheiros_de_software/util/app_color.dart';
import 'package:comunidade_de_engenheiros_de_software/util/base/constants.dart';
import 'package:comunidade_de_engenheiros_de_software/util/view/app_button.dart';
import 'package:comunidade_de_engenheiros_de_software/util/view/loading_widget.dart';
import 'package:flutter/material.dart';

class RecoveryPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final LoginViewModel viewModel = LoginViewModel(authService: getIt<AuthService>());

  RecoveryPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recuperar senha'),
      ),
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 32, bottom: 32),
                child: Text(
                  'Digite o email para recuperação',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Email',
                ),
              ),
            ),
            const Spacer(),
            AppButton(
              onPressed: () async {
                final scaffold = ScaffoldMessenger.of(context);
                final navigator = Navigator.of(context);
                final loading = LoadingControl();

                showDialog(context: context, builder: (_) => loading.create(), barrierDismissible: false);
                final isSend = await viewModel.resetPassword(emailController.text);

                loading.close();
                if (isSend) {
                  scaffold.showSnackBar(const SnackBar(content: Text('Verifique sua caixa e email. para continuar a recuperação')));
                  await Future.delayed(const Duration(seconds: 10));
                  navigator.pop();
                } else {
                  scaffold.showSnackBar(const SnackBar(content: Text('Não foi possível enviar o email de recuperação')));
                }
              },
              text: 'Recuperar senha',
              padding: const EdgeInsets.symmetric(horizontal: 32),
              minHeight: 56,
              color: AppColor.secondColor,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
