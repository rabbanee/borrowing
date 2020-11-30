part of '../views.dart';

class TeacherInChargeInput extends StatefulWidget {
  @override
  _TeacherInChargeInputState createState() => _TeacherInChargeInputState();
}

class _TeacherInChargeInputState extends State<TeacherInChargeInput> {
  String _roleItem;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BorrowBloc, BorrowState>(
      buildWhen: (previous, current) =>
          previous.teacherInCharge != current.teacherInCharge,
      builder: (context, state) {
        return DropdownButton(
          key: const Key('BorrowForm_teacherInChargeInput_textField'),
          value: _roleItem,
          hint: Text('Teacher In Charge'),
          onChanged: (teacherInCharge) {
            context
                .read<BorrowBloc>()
                .add(BorrowTeacherInChargeChanged(teacherInCharge));

            setState(() {
              _roleItem = teacherInCharge;
            });
          },
          items: ['Test', 'musyrif', 'student'].map((item) {
            return DropdownMenuItem(
              child: Text(
                item,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              value: item,
            );
          }).toList(),
          style: TextStyle(fontSize: 15),
        );
      },
    );
  }
}
