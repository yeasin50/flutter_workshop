import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import './login_page.dart';
import '../models/user.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = User.ui; //TODO: replace from login

    final textStyle = TextTheme.of(context);
    return Material(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: [
            AppBar(
              title: const Text("Profile"),
              actionsPadding: EdgeInsetsGeometry.only(right: 24),
              actions: [
                IconButton(
                  onPressed: () {
                    //TODO: Logout call
                    final route = MaterialPageRoute(builder: (context) => LoginPage());
                    Navigator.of(context).pushReplacement(route);
                  },
                  icon: Icon(Icons.logout),
                ),
              ],
            ),
            Center(child: CircleAvatar(radius: 45, backgroundImage: CachedNetworkImageProvider(user.avatar))),
            Text(user.name, style: textStyle.headlineSmall, textAlign: TextAlign.center),
            Text(
              user.email,
              style: textStyle.bodyMedium?.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text("Address"),
              subtitle: Text(user.address),
            ),
            ListTile(leading: const Icon(Icons.badge), title: const Text("User ID"), subtitle: Text(user.id)),
            const Divider(),
            const ThemeSwitcher(),
          ],
        ),
      ),
    );
  }
}

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text("switch to ${isDark ? "light" : "dark"}"),
          trailing: IconButton(
            onPressed: () {
              setState(() {
                isDark = !isDark;
              });
              //TODO: switch theme
            },
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          ),
        ),
      ],
    );
  }
}
