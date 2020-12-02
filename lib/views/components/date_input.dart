part of '../views.dart';

class DateInput extends StatefulWidget {
  @override
  _DateInputState createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  DateFormat _dateFormat = new DateFormat('yyyy-MM-dd');
  DateTime selectedDate = DateTime.now();
  TextEditingController _controllerDate = TextEditingController();

  @override
  void initState() {
    _controllerDate..text = DateFormat.yMMMMd().format(selectedDate);
    super.initState();
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      final String borrowDate = _dateFormat.format(picked);
      _controllerDate..text = DateFormat.yMMMd().format(picked);
      selectedDate = picked;
      final state = BlocProvider.of<BorrowBloc>(context).state;
      // print('ini state cuy: ${state.borrowDate}');
      resetReasonOrTeacher(state.borrowDate.value, borrowDate);
      context.read<BorrowBloc>().add(BorrowDateChanged(borrowDate));
    }
  }

  void resetReasonOrTeacher(before, after) {
    if ((before == _dateFormat.format(DateTime.now()) &&
            after != _dateFormat.format(DateTime.now())) ||
        (before != _dateFormat.format(DateTime.now()) &&
            after == _dateFormat.format(DateTime.now()))) {
      print('masuk');
      context.read<BorrowBloc>().add(BorrowTeacherInChargeChanged(''));
      context.read<BorrowBloc>().add(BorrowReasonChanged(''));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BorrowBloc, BorrowState>(
      buildWhen: (previous, current) =>
          previous.borrowDate != current.borrowDate,
      builder: (context, state) {
        return TextField(
          key: const Key('BorrowForm_borrowDateInput_textField'),
          controller: _controllerDate,
          decoration: InputDecoration(
            labelText: "Date",
            prefixIcon: Icon(Icons.date_range),
            suffixIcon: Icon(Icons.arrow_drop_down),
            hintStyle: TextStyle(color: Colors.grey),
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.grey),
            ),
            errorText: state.borrowDate.invalid ? 'invalid borrow date' : null,
          ),
          style: TextStyle(fontSize: 15),
          onTap: () => _selectDate(context),
          readOnly: true,
        );
      },
    );
  }
}
