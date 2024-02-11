// ignore_for_file: no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:to_do_list/source/view/home_page.dart';
import 'package:to_do_list/widgets/button.dart';
import 'package:to_do_list/widgets/consts/colors.dart';
import 'package:to_do_list/widgets/textWidget.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                _screenWidth * 0.1,
                _screenHeight * 0.1,
                _screenWidth * 0.1,
                _screenHeight * 0.1,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Image(
                        image: AssetImage("assets/images/play.png"),
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 10),
                      TextWidgetUI.buildTextWidget(
                          title: "How it", isBold: false, fontSize: 16),
                      TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0)),
                        onPressed: () {},
                        child: TextWidgetUI.buildTextWidget(
                            title: "works",
                            isBold: false,
                            color: ColorsUI.Glaucous,
                            fontSize: 16,
                            isUnderlined: true),
                      ),
                    ],
                  ),
                  const Image(
                    image: AssetImage("assets/images/tasking.jpg"),
                    width: 390,
                    height: 390,
                  ),
                  Center(
                    child: TextWidgetUI.buildTextWidget(
                        title: "    Manage Your\nEveryday Task List",
                        isBold: true,
                        fontSize: 26),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: TextWidgetUI.buildTextWidget(
                        title:
                            "Simplify your day with our sleek ToDo app. Quickly create, update, or delete tasks for a hassle-free task management experience",
                        isBold: false,
                        color: Colors.black54,
                        fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ButtonUI.buildButtonWidget(
                        title: "Get Started",
                        fct: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
