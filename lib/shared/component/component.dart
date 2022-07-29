import 'package:flutter/material.dart';


bool select3x3 = false;
bool select4x4 = false;
bool select5x5 = false;

final List <String> images = [

  'assets/images/50_coins.png',
  'assets/images/100_coins.png',
  'assets/images/500_coins.png',
  'assets/images/1k_coins.png',
  'assets/images/2.5k_coins.png',
  'assets/images/5k_coins.png',
  'assets/images/10k_coins.png',
  'assets/images/25k_coins.png',
  'assets/images/50k_coins.png',
  'assets/images/100k_coins.png',
];

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateBack(context, widget) =>
    Navigator.pop(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (route)
  {
    return false;
  },
);

Widget defaultButton({
  double height = 45.0,
  double? width,
  double? fontSize,
  Color? backgroundColorBox,
  Color? textColor,
  double radius = 25.0,
  bool isUpperCase = true,
  required Function function,
  required String text,
}) => Container(
  height: height,
  width: width,
  child: MaterialButton(
    onPressed: (){
      function();
    },
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        fontSize: fontSize?? 25.0,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    ),
  ),
  decoration: BoxDecoration(
    color: backgroundColorBox,
    borderRadius: BorderRadiusDirectional.circular(radius),
    // color: background,
    border: Border.all(
      color: Colors.yellow,
      width: 1.5,
    ),
  ),
);


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChanged,
  GestureTapCallback? onTap,
  bool isBool = false,
  bool isClickable = false,
  required FormFieldValidator<String> validate,
  String? label,
  IconData? prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  InputBorder? border,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isBool,
  onFieldSubmitted: onSubmit,
  onChanged: onChanged,
  validator: validate,
  onTap: onTap,
  decoration:  InputDecoration(
    labelText: label,
    prefixIcon: Icon(prefix),
    suffixIcon: IconButton(
      icon: Icon(suffix),
      onPressed: ()
      {
        suffixPressed!();
      },
    ),
    border: border,
  ),
);