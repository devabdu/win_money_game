import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  DrawerItem({Key? key, required this.title, required this.icon, required this.onTap, this.titleColor, this.iconColor}) : super(key: key);

  final String title;
  final IconData icon;
  final Function() onTap;
  Color? titleColor;
  Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
        child: SizedBox(
          height: 40,
          child: Row(
            children: [
              Icon(
                icon,
                size: 30,
                color: iconColor?? Colors.deepPurple,
              ),
              const SizedBox(
                width:  20,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: titleColor?? Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
    );
  }
}
