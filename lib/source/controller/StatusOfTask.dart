import 'package:to_do_list/source/model/DBConnectivity.dart';

class StatusListener {
  final int id;

  StatusListener({required this.id});

  void MarkTaskAsComplete(int ID) {
    DBFcts().updateTask(ID, 2);
  }
  void MArkAsActive(int ID) {
    DBFcts().updateTask(ID, 1);
  }
}
