import 'package:cocktailapp/page/auth_page.dart';
import 'package:cocktailapp/page/home_page.dart';
import 'package:cocktailapp/utils.dart';
import 'package:cocktailapp/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

 Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'CocktailApp',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,)
        .copyWith(secondary: Colors.tealAccent),
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }else if (snapshot.hasError){
          return Center(child: Text('Something went wrong!'));
        }
         else if (snapshot.hasData){
          return Homepage();
        } else {
          return AuthPage();
        }
      },
    )

  );
  }

  