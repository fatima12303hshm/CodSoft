import 'package:to_do_list/source/model/DBConnectivity.dart';

class DeleteATask {
  final int id;

  DeleteATask({required this.id});

  void DeleteTaskById(int ID) {
    DBFcts().deleteTask(ID);
  }
}
