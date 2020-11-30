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
      _controllerDate..text = DateFormat.yMMMd().format(picked);
      selectedDate = picked;
      context
          .read<BorrowBloc>()
          .add(const BorrowDateChanged(_dateFormat.format(selectedDate)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BorrowBloc, BorrowState>(
      buildWhen: (previous, current) =>
          previous.borrowDate != current.borrowDate,
      builder: (context, state) {
        return TextField(
          key: const Key('BorrowForm_reasonInput_textField'),
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
            errorText: state.reason.invalid ? 'invalid reason' : null,
          ),
          style: TextStyle(fontSize: 15),
          onTap: () => _selectDate(context),
          readOnly: true,
        );
      },
    );
  }
}
