import 'package:flutter/material.dart';
import 'package:italky2/app_Localization.dart';
import 'package:italky2/pages/home/side_bar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const SideBar(),
        appBar: AppBar(
          title:Text(AppLocalization.of(context)?.translate('name') ?? 'message'), 
        ),
        body:const Padding(
          padding:  EdgeInsets.all(8),
          child: Column(
            children: [
              // TextField(
              //   enabled: true,
              //   cursorColor: const Color(0x55555510),
              //   decoration: InputDecoration(
              //     hoverColor: const Color.fromARGB(255, 237, 238, 240),
              //     filled: true,
              //     fillColor: const Color(0xDCDCDFFF),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(30.0),
              //       borderSide:
              //           const BorderSide(width: 1.0, color: Color(0xBBBBBBFF)),
              //     ),
              //     hintText: 'search',
              //     prefixIcon: const Icon(Icons.search),
              //   ),
              // ),
              // const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
