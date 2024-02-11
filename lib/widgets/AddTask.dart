// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:to_do_list/source/controller/AddNewTaskController.dart';
import 'package:to_do_list/source/controller/getAllTasks.dart';
import 'package:to_do_list/source/view/home_page.dart';
import 'package:to_do_list/widgets/button.dart';
import 'package:to_do_list/widgets/consts/priority.dart';

class AddTask extends StatefulWidget {
  final VoidCallback onSave;

  const AddTask({Key? key, required this.onSave}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String? _selectedPriority = Priority[0];
  late DateTime _selectedStartTime;
  late DateTime _selectedEndTime;
  late DateTime _selectedDay;
  late bool starttimeChanged = false;
  late bool endtimeChanged = false;
  late bool dateChanged = false;
  late int _priority = 0;
  late Size _size;

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedStartTime),
    );

    if (picked != null) {
      setState(() {
        starttimeChanged = true;
        _selectedStartTime = DateTime(
          _selectedStartTime.year,
          _selectedStartTime.month,
          _selectedStartTime.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedEndTime),
    );

    if (picked != null) {
      setState(() {
        endtimeChanged = true;
        _selectedEndTime = DateTime(
          _selectedEndTime.year,
          _selectedEndTime.month,
          _selectedEndTime.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  Future<void> _selectDay(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDay,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025));

    if (picked != null) {
      setState(() {
        dateChanged = true;
        _selectedDay = DateTime(picked.year, picked.month, picked.day);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedStartTime = DateTime.now();
    _selectedEndTime = DateTime.now();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Center(
        child: Container(
          color: Colors.white,
          width: _size.width * 0.86,
          height: _size.height * 0.58,
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildInputField(
                controller: _titleController,
                placeholder: 'Title',
              ),
              const SizedBox(height: 16),
              _buildInputField(
                controller: _descController,
                placeholder: 'Description (optional)',
              ),
              const SizedBox(height: 16),
              _buildDateInputField(
                onTap: () {
                  _selectDay(context);
                },
                selectedday: _selectedDay,
                placeholder: 'Day',
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildStartTimeInputField(),
                  const SizedBox(width: 16),
                  _buildEndTimeInputField(),
                ],
              ),
              const SizedBox(height: 16),
              _buildPriorityWidget(),
              const SizedBox(height: 16),
              ButtonUI.buildButtonWidget(
                  title: "Save",
                  fct: () {
                    _saveTask();
                    _clearControllers();
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String placeholder,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: placeholder,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
      ),
      keyboardType: TextInputType.text,
    );
  }

  Widget _buildEndTimeInputField() {
    return SizedBox(
      width: _size.width * 0.25,
      child: GestureDetector(
        onTap: () {
          _selectEndTime(context);
        },
        child: AbsorbPointer(
          child: TextField(
            decoration: const InputDecoration(
              hintText: "End Time",
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            ),
            controller: TextEditingController(
                text: endtimeChanged
                    ? '${_selectedEndTime.hour} : ${_selectedEndTime.minute}'
                    : ""),
            keyboardType: TextInputType.datetime,
          ),
        ),
      ),
    );
  }

  Widget _buildStartTimeInputField() {
    return SizedBox(
      width: _size.width * 0.25,
      child: GestureDetector(
        onTap: () {
          _selectStartTime(context);
        },
        child: AbsorbPointer(
          child: TextField(
            decoration: const InputDecoration(
              hintText: "Start Time",
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            ),
            controller: TextEditingController(
                text: starttimeChanged
                    ? '${_selectedStartTime.hour} : ${_selectedStartTime.minute}'
                    : ""),
            keyboardType: TextInputType.datetime,
          ),
        ),
      ),
    );
  }

  Widget _buildDateInputField({
    required DateTime selectedday,
    required String placeholder,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: _size.width * 0.25,
      child: GestureDetector(
        onTap: onTap,
        child: AbsorbPointer(
          child: TextField(
            decoration: InputDecoration(
              hintText: placeholder,
              border: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            ),
            controller: TextEditingController(
                text: dateChanged
                    ? '${selectedday.day} - ${selectedday.month} - ${selectedday.year}'
                    : ''),
            keyboardType: TextInputType.datetime,
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Priority",
          style:
              TextStyle(color: Colors.black54.withOpacity(0.6), fontSize: 16),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildRadioTile("Low", Priority[0]!, 0),
            _buildRadioTile("Medium", Priority[1]!, 1),
            _buildRadioTile("High", Priority[2]!, 2),
          ],
        ),
      ],
    );
  }

  Widget _buildRadioTile(String title, String value, int priority) {
    return SizedBox(
      width: 107,
      child: Row(
        children: [
          Radio<String>(
            value: value,
            groupValue: _selectedPriority,
            onChanged: (String? selectedValue) {
              setState(() {
                _priority = priority;
                _selectedPriority = selectedValue;
              });
            },
          ),
          Text(title),
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

  void _saveTask() {
    int stat;
    if (DateTime.now().isBefore(_selectedStartTime) &&
        DateTime.now().isAfter(_selectedEndTime)) {
      stat = 1;
    } else {
      stat = 0;
    }
    AddNewTask(
            title: _titleController.text,
            desc: _descController.text,
            day: _selectedDay,
            startTime: _selectedStartTime,
            dueTime: _selectedStartTime,
            priority: _priority,
            status: stat)
        .createTask();
    getAllTasks().getTasks();
  }

  void _clearControllers() {
    setState(() {
      _titleController.clear();
      _descController.clear();
      _selectedPriority = Priority[0];
      _priority = 0;
      starttimeChanged = false;
      endtimeChanged = false;
      dateChanged = false;
      _navigateToNewScreen(context);
    });
  }
}
