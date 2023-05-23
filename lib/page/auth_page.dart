// ignore_for_file: library_private_types_in_public_api

import 'package:login/widget.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LoginWidget(
          onClickedSignUp: toggle,
        )
      : SignUpWidget(
          onClickedSignIn: toggle,
        );

  void toggle() => setState(() => isLogin = !isLogin);
}
