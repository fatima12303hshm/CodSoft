import 'package:flutter/material.dart';
import 'package:to_do_list/source/controller/getTop3Tasks.dart';
import 'package:to_do_list/source/model/Task.dart';
import 'package:to_do_list/widgets/taskTileWidget.dart';

class DisplayListForHome extends StatefulWidget {
  const DisplayListForHome({super.key});

  @override
  State<DisplayListForHome> createState() => _DisplayListForHomeState();
}

class _DisplayListForHomeState extends State<DisplayListForHome> {
  late Future<List<Task>> alltasks;
  @override
  void initState() {
    super.initState();
    alltasks = getTopTasks().getMainTasks();
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
        height: screenHeight * 0.3,
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
        ));
  }
}
