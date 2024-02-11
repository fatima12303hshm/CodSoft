// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:to_do_list/source/model/DBConnectivity.dart';
import 'package:to_do_list/source/model/Task.dart';
import 'package:to_do_list/source/view/home_page.dart';
import 'package:to_do_list/widgets/consts/colors.dart';
import 'package:to_do_list/widgets/consts/priority.dart';
import 'package:to_do_list/widgets/textWidget.dart';

class TaskTile extends StatefulWidget {
  final Task task;

  const TaskTile({super.key, required this.task});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  late bool isChecked;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isChecked = false;
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;

    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: BoxDecoration(
                color: ColorsUI.Glaucous,
                borderRadius: BorderRadius.circular(20)),
            height: _screenHeight * 0.09,
            width: _screenWidth * 0.55,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidgetUI.buildTextWidget(
                          title: widget.task.title,
                          isBold: true,
                          fontSize: 16,
                          color: const Color.fromARGB(255, 255, 255, 255)),
                      TextWidgetUI.buildTextWidget(
                          title: widget.task.description ?? "",
                          isBold: false,
                          fontSize: 12,
                          color: const Color.fromARGB(255, 255, 255, 255)),
                      TextWidgetUI.buildTextWidget(
                          title: Priority[widget.task.priority] ?? "",
                          isBold: false,
                          fontSize: 12,
                          color: const Color.fromARGB(255, 255, 255, 255)),
                    ],
                  ),
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = !isChecked;
                        _alertDialog(context);
                      });
                    },
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          TextWidgetUI.buildTextWidget(
            title:
                "${widget.task.startTime.hour} : ${widget.task.startTime.minute}",
            isBold: true,
            fontSize: 18,
          ),
        ],
      ),
    );
  }

  Future<void> _navigateToNewScreen(BuildContext context) async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  void _alertDialog(BuildContext context) {
    showDialog(
        builder: (context) {
          return AlertDialog(
            title: const Text("Task Completed?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () {
                    DBFcts().updateTask(widget.task.id!, 2);
                    _navigateToNewScreen(context);
                  },
                  child: const Text(
                    "Ok",
                    style: TextStyle(color: Colors.blue),
                  )),
            ],
          );
        },
        context: context);
  }
}
