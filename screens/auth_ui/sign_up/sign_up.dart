import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sewa_kamera1/constants/constants.dart';
import 'package:sewa_kamera1/constants/routes.dart';
import 'package:sewa_kamera1/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:sewa_kamera1/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:sewa_kamera1/widgets/primary_button/primary_button.dart';
import 'package:sewa_kamera1/widgets/top_titles/top_titles.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isShowPassword = true;
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
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
              TopTitles(
                  subtitle: "Selamat Datang Di Rent Cam", title: "Buat Akun"),
              Container(
              margin: EdgeInsets.only(right: 30),
              child: LottieBuilder.asset("assets/lottie/cam.json"),
            ),
              TextFormField(
                controller: name,
                decoration: const InputDecoration(
                  hintText: "Nama",
                  prefixIcon: Icon(
                    Icons.person_outline,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
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
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "No Handpone",
                  prefixIcon: Icon(
                    Icons.phone_outlined,
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
                  title: "Buat akun",
                  onPressed: () async {
                    bool isVaildated = signUpVaildation(
                        email.text, password.text, name.text, phone.text);
                    if (isVaildated) {
                      bool isLogined = await FirebaseAuthHelper.instance.signUp(
                          name.text, email.text, password.text, context);
                      if (isLogined) {
                        Routes.instance.pushAndRemoveUtil(
                            widget: const CustomBottomBar(), context: context);
                      }
                    }
                  }),
              SizedBox(
                height: 10,
              ),
              Center(child: Text("Sudah memilik akun?")),
              SizedBox(
                height: 10,
              ),
              Center(
                child: CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Masuk",
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
