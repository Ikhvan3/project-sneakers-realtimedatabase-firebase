import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import 'package:menu_makanan/providers/auth.dart';

const users = {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _loginUser(LoginData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async {
      try {
        await Provider.of<Authen>(context as BuildContext, listen: false)
            .login(data.name.toString(), data.password.toString());
      } catch (err) {
        print(err);
        return err.toString();
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async {
      try {
        await Provider.of<Authen>(context as BuildContext, listen: false)
            .signup(data.name.toString(), data.password.toString());
      } catch (err) {
        print(err);
        return err.toString();
      }

      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'ECORP',
      // logo: const AssetImage('assets/images/ecorp-lightblue.png'),
      onLogin: _loginUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Provider.of<Authen>(context, listen: false).tempData();
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
