import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  //const IconWidget({super.key});
    final Color color;
    final IconData icon;

    const IconWidget({
      Key? key,
      required this.color,
      required this.icon,

    }):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        shape:BoxShape.circle,
        color: color,
      ),
      child: Icon(icon,color: Colors.white,),
    );
  }
}