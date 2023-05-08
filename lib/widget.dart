

import 'package:cocktailapp/utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'main.dart';


class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;
  
  const SignUpWidget({
    Key? key,
    required this.onClickedSignIn,
  }) : super (key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  Widget build(BuildContext context) {
     return SingleChildScrollView(
      
      padding: EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40,),
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: 'Correo Electronico'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (email) => 
            email != null && !EmailValidator.validate(email)
            ? 'Ingresa un correo valido'
            :null,
          ),
          TextFormField(
            controller: passwordController,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(labelText: 'Contraseña'),
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => value != null && value.length < 6
            ? 'Ingresa minimo 6 caracteres'
            :null,
          ),
          SizedBox(height: 20,),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
            ),
            icon: Icon(Icons.lock_open, size: 32,),
            label: Text(
              'Registrarse',
              style: TextStyle(fontSize: 24),
              ),
            onPressed: signUp,
          ),
          SizedBox(height: 24,),
          RichText(
            text: TextSpan(
              text: '¿Ya tienes una cuenta? ',
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                  ..onTap = widget.onClickedSignIn,
                  text: 'Inicia sesión',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).colorScheme.secondary
                  )
                  )
              ]
            )
            )
        ],
      ),
      )
    );
  }
  Future signUp() async{
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (context) => Center(child: CircularProgressIndicator(),));
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(), 
      password: passwordController.text.trim()
      );
  } on FirebaseAuthException catch (e) {
    print(e);

    Utils.showSnackBar(e.message);
  }
    //Navigator.of(context) not working!
    navigatorKey.currentState!.popUntil((route)=>route.isFirst);
  }

}


class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LoginWidget({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);
  



  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
          
          SizedBox(height: 40,),
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: 'Correo Electronico'),
          ),
          TextFormField(
            controller: passwordController,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(labelText: 'Contraseña'),
            obscureText: true,
          ),
          SizedBox(height: 20,),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
            ),
            icon: Icon(Icons.lock_open, size: 32,),
            label: Text(
              'Iniciar sesión',
              style: TextStyle(fontSize: 24),
              ),
            onPressed: signIn,
          ),
          SizedBox(height: 24,),
          RichText(
            text: TextSpan(
              text: '¿No tienes cuenta?',
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                  ..onTap = widget.onClickedSignUp,
                  text: 'Registrate',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).colorScheme.secondary
                  )
                  )
              ]
            )
            )
        ],
      ),


    );
    
  }
  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (context)=>Center(child: CircularProgressIndicator()),
      );

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(), 
        password: passwordController.text.trim(),
        );
    } on FirebaseAuthException catch (e) {
      print(e);
    }

    //Navigator.of(context) not working!
     navigatorKey.currentState!.popUntil((route)=>route.isFirst);
  }
}