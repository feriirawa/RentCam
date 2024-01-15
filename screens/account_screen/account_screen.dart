import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sewa_kamera1/constants/routes.dart';
import 'package:sewa_kamera1/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:sewa_kamera1/provider/app_provider.dart';
import 'package:sewa_kamera1/screens/change_password/change_password.dart';
import 'package:sewa_kamera1/screens/edit_profile/edit_profile.dart';
import 'package:sewa_kamera1/screens/favourite_screen/favourite_screen.dart';
import 'package:sewa_kamera1/widgets/primary_button/primary_button.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Akun",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                appProvider.getUserInformation.image == null
                    ? Icon(Icons.person_outline, size: 150)
                    : CircleAvatar(
                        backgroundImage:
                            NetworkImage(appProvider.getUserInformation.image!),
                        radius: 60,
                      ),
                Text(
                  appProvider.getUserInformation.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  appProvider.getUserInformation.email,
                ),
                SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: 130,
                  height: 40,
                  child: PrimaryButton(
                    title: "Edit profil",
                    onPressed: () {
                      Routes.instance
                          .push(widget: EditProfile(), context: context);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.shopping_bag_outlined),
                    title: Text("Pesanan Saya"),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance.push(widget: FavouriteScreen(), context: context);
                    },
                    leading: Icon(Icons.favorite_outline),
                    title: Text("favorit"),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.info_outline),
                    title: Text("Tentang Kami"),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.support_outlined),
                    title: Text("Dukungan"),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance.push(widget: ChangePassword(), context: context);
                    },
                    leading: Icon(Icons.change_circle_outlined),
                    title: Text("Ubah Kata Sandi"),
                  ),
                  ListTile(
                    onTap: () {
                      FirebaseAuthHelper.instance.signOut();
                      setState(() {});
                    },
                    leading: Icon(Icons.exit_to_app),
                    title: Text("Log Out"),
                  ),
                  SizedBox(height: 12),
                  Text("versi 1.0.0")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
