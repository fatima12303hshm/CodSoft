import 'package:flutter/material.dart';
import 'package:to_do_list/widgets/consts/colors.dart';

class ButtonUI {
  static ElevatedButton buildButtonWidget(
      {required String title, required Function fct}) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              return ColorsUI.Glaucous;
            },
          ),
        ),
        onPressed: () {
          fct();
        },
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ));
  }
}
