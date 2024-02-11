import 'package:to_do_list/source/model/DBConnectivity.dart';

class getCountoTasks {
  Future<int> getCounted() async {
    Future<int> count = DBFcts().getCount();
    return count;
  }
}
