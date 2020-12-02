part of '../views.dart';

class TeacherInChargeInput extends StatefulWidget {
  @override
  TeacherInChargeInput(
      {Key key, @required this.musyrif, @required this.teacher})
      : super(key: key);

  final Users teacher;
  final Users musyrif;

  _TeacherInChargeInputState createState() => _TeacherInChargeInputState();
}

class _TeacherInChargeInputState extends State<TeacherInChargeInput> {
  String _currentTeacherInCharge;
  String _currentTeacherInCharge2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BorrowBloc, BorrowState>(
      buildWhen: (previous, current) =>
          previous.teacherInCharge != current.teacherInCharge ||
          previous.borrowDate != current.borrowDate,
      builder: (context, state) {
        if (widget.teacher == null || widget.musyrif == null) {
          return Text('');
        }

        if (state.borrowDate.value !=
            new DateFormat('yyyy-MM-dd').format(DateTime.now())) {
          return DropdownButton(
            key: const Key('BorrowForm_teacherInChargeInput_textField'),
            value: _currentTeacherInCharge,
            hint: Text('Teacher In Charge'),
            onChanged: (teacherInCharge) {
              context
                  .read<BorrowBloc>()
                  .add(BorrowTeacherInChargeChanged(teacherInCharge));
              setState(() => _currentTeacherInCharge = teacherInCharge);
            },
            items: widget.teacher.user.map((item) {
              return DropdownMenuItem(
                child: Text(
                  item.name,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                value: item.name,
              );
            }).toList(),
            style: TextStyle(fontSize: 15),
          );
        } else {
          return DropdownButton(
            key: const Key('BorrowForm_teacherInChargeInput2_textField'),
            value: _currentTeacherInCharge2,
            hint: Text('Teacher In Charge'),
            onChanged: (teacherInCharge) {
              context
                  .read<BorrowBloc>()
                  .add(BorrowTeacherInChargeChanged(teacherInCharge));
              setState(() => _currentTeacherInCharge2 = teacherInCharge);
            },
            items: widget.musyrif.user.map((item) {
              return DropdownMenuItem(
                child: Text(
                  item.name,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                value: item.name,
              );
            }).toList(),
            style: TextStyle(fontSize: 15),
          );
        }
      },
    );
  }
}
