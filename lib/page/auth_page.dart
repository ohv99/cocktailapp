import 'package:cocktailapp/widget.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin=true;

  @override
  
  Widget build(BuildContext context) => isLogin 
  ? LoginWidget(onClickedSignUp: toggle,)
  : SignUpWidget(onClickedSignIn: toggle,);

  void toggle() => setState(() => isLogin = !isLogin);
}