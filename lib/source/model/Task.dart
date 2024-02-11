// ignore_for_file: file_names, non_constant_identifier_names

class Task {
  final int? id;
  final String title;
  final String? description;
  final DateTime day;
  final DateTime startTime;
  final DateTime? dueTime;
  final int priority; //0: low, 1:medium, 2:high
  final int status; //0: does not started yet, 1: active, 2:done

  Task(
      {this.id,
      required this.title,
      required this.description,
      required this.day,
      required this.startTime,
      required this.dueTime,
      required this.priority,
      required this.status});

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      day: DateTime.parse(map['day']),
      startTime: DateTime.parse(map['startTime']),
      dueTime: map['dueTime'] != null ? DateTime.parse(map['dueTime']) : null,
      priority: map['priority'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    print("ST ${startTime.toIso8601String()}");
    print("DT ${dueTime?.toIso8601String()}");
    return {
      'title': title,
      'description': description,
      'day': day.toIso8601String(),
      'startTime': startTime.toIso8601String(),
      'dueTime': dueTime?.toIso8601String(),
      'priority': priority,
      'status': status,
    };
  }
}
