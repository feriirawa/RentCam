// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sewa_kamera1/constants/constants.dart';
import 'package:sewa_kamera1/constants/routes.dart';
import 'package:sewa_kamera1/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:sewa_kamera1/screens/auth_ui/sign_up/sign_up.dart';
import 'package:sewa_kamera1/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:sewa_kamera1/widgets/primary_button/primary_button.dart';
import 'package:sewa_kamera1/widgets/top_titles/top_titles.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              TopTitles(subtitle: "Selamat Datang Di Rent Cam", title: "Login"),
              Container(
                margin: EdgeInsets.only(right: 30),
                child: LottieBuilder.asset("assets/lottie/cam.json"),
              ),
              TextFormField(
                controller: email, // Tambahkan controller di sini
                decoration: const InputDecoration(
                  hintText: "E-mail",
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: password,
                obscureText: isShowPassword,
                decoration: InputDecoration(
                  hintText: "Kata Sandi",
                  prefixIcon: Icon(
                    Icons.lock_outlined,
                  ),
                  suffixIcon: CupertinoButton(
                      onPressed: () {
                        setState(() {
                          isShowPassword = !isShowPassword;
                          print(isShowPassword);
                        });
                      },
                      padding: EdgeInsets.zero,
                      child: Icon(
                        Icons.visibility,
                        color: Colors.grey,
                      )),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              PrimaryButton(
                  title: "Masuk",
                  onPressed: () async {
                    bool isVaildated =
                        loginVaildation(email.text, password.text);
                    if (isVaildated) {
                      bool isLogined = await FirebaseAuthHelper.instance
                          .login(email.text, password.text, context);
                      if (isLogined) {
                        Routes.instance.pushAndRemoveUtil(
                            widget: const CustomBottomBar(), context: context);
                      }
                    }
                  }),
              SizedBox(
                height: 10,
              ),
              Center(child: Text("Belum memilik akun?")),
              SizedBox(
                height: 10,
              ),
              Center(
                child: CupertinoButton(
                  onPressed: () {
                    Routes.instance.push(widget: SignUp(), context: context);
                  },
                  child: Text(
                    "Buat akun",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
