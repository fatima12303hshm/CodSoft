// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:to_do_list/source/controller/getCount.dart';
import 'package:to_do_list/widgets/AddTask.dart';
import 'package:to_do_list/widgets/button.dart';
import 'package:to_do_list/widgets/consts/colors.dart';
import 'package:to_do_list/widgets/displayAll.dart';
import 'package:to_do_list/widgets/displayCurrentTask.dart';
import 'package:to_do_list/widgets/displayfirst.dart';
import 'package:to_do_list/widgets/textWidget.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/HomePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAddTaskVisible = false;
  late Future<int> ctr;

  @override
  void initState() {
    super.initState();
    _loadCount();
  }

  Future<void> _loadCount() async {
    ctr = getCountoTasks().getCounted();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: _buildContent(screenWidth, screenHeight),
          ),
          if (isAddTaskVisible)
            GestureDetector(
              onTap: () {
                setState(() {
                  isAddTaskVisible = false;
                });
              },
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: AddTask(onSave: () {
                    setState(() {
                      isAddTaskVisible = false;
                    });
                  }),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContent(double screenWidth, double screenHeight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            screenWidth * 0.08,
            screenHeight * 0.05,
            screenWidth * 0.08,
            screenHeight * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              TextWidgetUI.buildTextWidget(
                  title: "Welcome", isBold: true, fontSize: 26),
              FutureBuilder<int>(
                future: ctr,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text(
                      "Error: ${snapshot.error}",
                      style: const TextStyle(color: Colors.red),
                    );
                  } else {
                    final int count = snapshot.data ?? 0;
                    return TextWidgetUI.buildTextWidget(
                      title: "$count tasks are pending",
                      isBold: false,
                      color: ColorsUI.Glaucous,
                      fontSize: 16,
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextWidgetUI.buildTextWidget(
                  title: "Ongoing Task",
                  isBold: false,
                  color: ColorsUI.Glaucous,
                  fontSize: 16),
              const SizedBox(
                height: 20,
              ),
              const DisplayCurrent(),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidgetUI.buildTextWidget(
                      title: "Today's Tasks", isBold: false, fontSize: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, DisplayAll.routeName);
                    },
                    child: TextWidgetUI.buildTextWidget(
                        title: "See All",
                        isBold: false,
                        color: ColorsUI.Glaucous,
                        fontSize: 16),
                  ),
                ],
              ),
              const DisplayListForHome(),
              Center(
                child: ButtonUI.buildButtonWidget(
                  title: "Add Task",
                  fct: () {
                    setState(() {
                      isAddTaskVisible = true;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
