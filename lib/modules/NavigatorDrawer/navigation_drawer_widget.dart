/*import 'dart:html';*/


import 'package:flutter/material.dart';
import 'package:win_money_game/modules/NavigatorDrawer/drawer_item.dart';
import 'package:win_money_game/modules/NavigatorDrawer/help.dart';
import 'package:win_money_game/modules/NavigatorDrawer/settings.dart';
import 'package:win_money_game/shared/component/component.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.amberAccent,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 80, 24, 0),
          child: Column(
            children:
            [
              headerWidget(context),
              const SizedBox(
                height: 30,),
              const Divider(
                thickness: 1,
                height: 10,
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerItem(
                icon: Icons.settings,
                title: 'Settings',
                onTap: () => onItemPressed(context, index: 0),
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerItem(
                icon: Icons.help_outline,
                title: 'Help',
                onTap: () => onItemPressed(context, index: 1),
              ),
              const SizedBox(
                height: 30,),
              const Divider(
                thickness: 1,
                height: 10,
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerItem(
                icon: Icons.logout_outlined,
                title: 'SignOut',
                titleColor: Colors.deepPurple,
                iconColor: Colors.deepPurple,
                onTap: () => onItemPressed(context, index: 2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index})
  {
    Navigator.pop(context);

    switch(index)
    {
      case 0:
        navigateTo(context, SettingsScreen());
        break;
      case 1:
        navigateTo(context, const HelpScreen());
        break;
      case 2:
        navigateTo(context, (){});
        break;
    }
  }

  Widget headerWidget(context)
  {
    return MaterialButton(

      onPressed: (){navigateTo(context, SettingsScreen());},
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          children:
          [
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 32,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage('https://icon-library.com/images/avatar-icon-images/avatar-icon-images-4.jpg'),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Mostafa Ahmed',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "level: 1",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
