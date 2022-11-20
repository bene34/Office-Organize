import 'package:flutter/material.dart';
import 'package:org_off_ia/models/user.dart';
import 'package:org_off_ia/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:org_off_ia/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:org_off_ia/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


      return StreamProvider<MyUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper()
      ),
    );
    }
  
}

