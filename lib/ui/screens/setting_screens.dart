import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_screen_homework/provider/theme_provider.dart';
import 'package:login_screen_homework/utils/colors.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool receiveNotifications = true;
  bool darkMode = false;
  String selectedLanguage = 'English';
  double fontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.chevron_back),
        ),
        elevation: 0,
        title: Text(
          "Settings",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins",
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? AppColors.C_32383E
                      : AppColors.passiveTextColor,
                  borderRadius: BorderRadius.circular(16.r)),
              child: Column(
                children: [
                  ListTile(
                    title: const Text(
                      'Notifications',
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                    trailing: CupertinoSwitch(
                      trackColor: Colors.grey.shade100,
                      value: receiveNotifications,
                      onChanged: (value) {
                        setState(() {
                          receiveNotifications = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'App Theme',
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                    trailing: CupertinoSwitch(
                      trackColor: Colors.grey.shade100,
                      value: Provider.of<ThemeProvider>(context).isDarkMode,
                      onChanged: (value) {
                        setState(() {
                          Provider.of<ThemeProvider>(context, listen: false)
                              .toggleTheme();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.h),
              decoration: BoxDecoration(
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? AppColors.C_32383E
                      : AppColors.passiveTextColor,
                  borderRadius: BorderRadius.circular(16)),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 16.w, right: 16.w, top: 20.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Phantom Game Store",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                child: ListView(
                                    padding: EdgeInsets.only(top: 20.h),
                                    children: const [
                                      Text(
                                        """Introducing our innovative app designed for all gaming enthusiasts: Game Store! Game Store is your ultimate destination for comprehensive information on a vast array of games, catering to diverse interests and preferences. Whether you're a hardcore gamer seeking the latest updates on trending titles or a casual player looking for recommendations, Game Store has you covered.

With a user-friendly interface, Game Store offers quick access to detailed game summaries, including plot overviews, gameplay mechanics, and graphics quality. Stay informed about release dates, expansions, and patches with our timely notifications. Dive deep into the gaming world with expert reviews, walkthroughs, and tips from seasoned players.

But Game Store isn't just about information – it's also a community. Connect with fellow gamers through forums, discussions, and multiplayer matchmaking. Share your experiences, strategies, and achievements to inspire and engage others.

Download Game Store now and unlock a treasure trove of gaming knowledge at your fingertips. Whether you're a novice or a veteran, Game Store is your ultimate companion in the exciting world of gaming.""",
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: const ListTile(
                  title: Text(
                    'What is Game Store',
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                  trailing: Icon(
                    CupertinoIcons.chevron_compact_right,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void resetSettings() {
    setState(() {
      receiveNotifications = true;
      darkMode = false;
      selectedLanguage = 'English';
      fontSize = 16.0;
    });
  }
}
