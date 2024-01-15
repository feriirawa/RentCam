import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sewa_kamera1/constants/constants.dart';
import 'package:sewa_kamera1/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:sewa_kamera1/widgets/primary_button/primary_button.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isShowPassword = true;
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Ubah Kata Sandi",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          TextFormField(
            controller: newpassword,
            obscureText: isShowPassword,
            decoration: InputDecoration(
              hintText: "Kata Sandi Baru",
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
            height: 25,
          ),
          TextFormField(
            controller: confirmpassword,
            obscureText: isShowPassword,
            decoration: InputDecoration(
              hintText: "Konfirmasi Kata Sandi",
              prefixIcon: Icon(
                Icons.lock_outlined,
              ),
              
            ),
          ),
          SizedBox(
            height: 36,
          ),
          PrimaryButton(
            title: "Perbarui",
            onPressed: () async {
              if (newpassword.text.isEmpty) {
                showMessage("kata sandi baru kosong");
              } else if (newpassword.text.isEmpty) {
                showMessage("konfirmasi kata sandi kosong");
              } else if (confirmpassword.text == newpassword.text) {
                FirebaseAuthHelper.instance
                    .changePassword(newpassword.text, context);
              } else {
                showMessage("konfirmasi kata sandi tidak cocok");
              }
            },
          ),
        ],
      ),
    );
  }
}
