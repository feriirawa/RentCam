import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sewa_kamera1/constants/assets_images.dart';
import 'package:sewa_kamera1/constants/routes.dart';
import 'package:sewa_kamera1/screens/auth_ui/login/login.dart';
import 'package:sewa_kamera1/screens/auth_ui/sign_up/sign_up.dart';
import 'package:sewa_kamera1/widgets/primary_button/primary_button.dart';

class welcome extends StatelessWidget {
  const welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selamat Datang",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Taklukkan Setiap Momen dengan Lebih Banyak Kamera! Sewa Kamera Lebih Banyak, Abadikan Kenangan Lebih Indah. 📸✨",
                style: TextStyle(
                  fontSize: 16.0,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Image.asset(
                  AssetsImages.instance.welcomeimages,
                  scale: 1,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    child: Icon(
                      Icons.facebook,
                      size: 35,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  CupertinoButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    child: Image.asset(
                      AssetsImages.instance.googlelogo,
                      scale: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              PrimaryButton(
                title: "Masuk",
                onPressed: () {
                  Routes.instance.push(widget: Login(), context: context);
                },
              ),
              SizedBox(height: 20),
              PrimaryButton(
                title: "Daftar",
                onPressed: () {
                  Routes.instance.push(widget: SignUp(), context: context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
