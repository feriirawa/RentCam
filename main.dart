 import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sewa_kamera1/constants/theme.dart';
import 'package:sewa_kamera1/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:sewa_kamera1/firebase_helper/firebase_options/firebase_options.dart';
import 'package:sewa_kamera1/provider/app_provider.dart';
import 'package:sewa_kamera1/screens/auth_ui/welcome/welcome.dart';
import 'package:sewa_kamera1/screens/custom_bottom_bar/custom_bottom_bar.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rent Cam',
        theme: themeData,
        home: StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData){
              return const CustomBottomBar();
            }
            return welcome();
          },
        )
      ),
    );
  }
}
