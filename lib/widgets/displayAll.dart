import 'package:flutter/material.dart';
import 'package:to_do_list/source/controller/getAllTasks.dart';
import 'package:to_do_list/source/model/Task.dart';
import 'package:to_do_list/widgets/consts/colors.dart';
import 'package:to_do_list/widgets/taskTileWidget.dart';

class DisplayAll extends StatefulWidget {
  static const routeName = "SeeAll";
  const DisplayAll({super.key});

  @override
  State<DisplayAll> createState() => _DisplayAllState();
}

class _DisplayAllState extends State<DisplayAll> {
  late Future<List<Task>> alltasks;
  @override
  void initState() {
    super.initState();
    alltasks = getAllTasks().getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 50,
          ),
          Text(
            "Tasks For Today: ",
            style: TextStyle(
                color: ColorsUI.Glaucous,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: FutureBuilder<List<Task>>(
              future: alltasks,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No Tasks Found"),
                  );
                } else {
                  List<Task> tasks = snapshot.data!;
                  return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        Task task = tasks[index];

                        return TaskTile(
                          task: task,
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
