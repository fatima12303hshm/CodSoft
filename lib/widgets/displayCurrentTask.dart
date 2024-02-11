import 'package:flutter/material.dart';
import 'package:to_do_list/source/controller/getCurrentTask.dart';
import 'package:to_do_list/source/model/Task.dart';
import 'package:to_do_list/widgets/consts/colors.dart';
import 'package:to_do_list/widgets/textWidget.dart';

class DisplayCurrent extends StatefulWidget {
  const DisplayCurrent({super.key});

  @override
  State<DisplayCurrent> createState() => _DisplayCurrentState();
}

class _DisplayCurrentState extends State<DisplayCurrent> {
  late Future<Task?> currentTask;
  @override
  void initState() {
    super.initState();
    currentTask = GetCurrentTask().getOngoingTask();
    print(currentTask);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(16)),
      width: screenWidth * 0.8,
      height: screenHeight * 0.24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FutureBuilder(
            future: currentTask,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error ${snapshot.error}"),
                );
              } else if (!snapshot.hasData ) {
                return const Text("No Ongoing Task");
              } else {
                Task task = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextWidgetUI.buildTextWidget(
                          title: task.title, isBold: true, fontSize: 26),
                      TextWidgetUI.buildTextWidget(
                          title: task.description ?? " ",
                          isBold: false,
                          fontSize: 16),
                      Row(children: [
                        const Image(
                          image: AssetImage("assets/images/clock_2784459.png"),
                          width: 20,
                          height: 20,
                        ),
                        TextWidgetUI.buildTextWidget(
                            title:
                                "${task.startTime.hour}:${task.startTime.minute} till ${task.dueTime!.hour}:${task.dueTime!.minute}",
                            isBold: false,
                            color: ColorsUI.Glaucous,
                            fontSize: 12),
                      ]),
                    ],
                  ),
                );
              }
            },
          ),
          Image(
            image: const AssetImage("assets/images/waiting_763358.png"),
            height: screenHeight * 0.2,
            width: screenWidth * 0.3,
          )
        ],
      ),
    );
  }
}
