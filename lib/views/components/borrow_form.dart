part of '../views.dart';

class BorrowForm extends StatefulWidget {
  @override
  BorrowForm({Key key, @required this.borrow}) : super(key: key);
  final String borrow;
  _BorrowFormState createState() => _BorrowFormState();
}

class _BorrowFormState extends State<BorrowForm> {
  String date = new DateFormat('yyyy-MM-dd').format(DateTime.now());

  void initState() {
    context.read<BorrowBloc>().add(BorrowDateChanged(this.date));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BorrowBloc, BorrowState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Borrow The ${widget.borrow}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(height: 60),
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[200],
                          ),
                        ),
                      ),
                      child: DateInput(),
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[200],
                          ),
                        ),
                      ),
                      child: _ReasonInput(),
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[200],
                          ),
                        ),
                      ),
                      child: TeacherInChargeInput(),
                    ),
                    SizedBox(height: 30),
                    _BorrowButton(),
                    SizedBox(height: 50),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _ReasonInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BorrowBloc, BorrowState>(
      buildWhen: (previous, current) => previous.reason != current.reason,
      builder: (context, state) {
        print(state.borrowDate.value);
        if (state.borrowDate.value == '') {
          return Text('');
        }
        return TextField(
          key: const Key('BorrowForm_reasonInput_textField'),
          onChanged: (reason) =>
              context.read<BorrowBloc>().add(BorrowReasonChanged(reason)),
          maxLines: 8,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.article_outlined),
            hintText: "Reason",
            hintStyle: TextStyle(color: Colors.grey),
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.grey),
            ),
            errorText: state.reason.invalid ? 'invalid reason' : null,
          ),
          style: TextStyle(fontSize: 15),
        );
      },
    );
  }
}

class _BorrowButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BorrowBloc, BorrowState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 40),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.purple),
                child: RaisedButton(
                  key: const Key('BorrowForm_continue_raisedButton'),
                  color: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.purple),
                  ),
                  child: const Text(
                    'Borrow',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  onPressed: state.status.isValidated
                      ? () {
                          context
                              .read<BorrowBloc>()
                              .add(const BorrowSubmitted());
                        }
                      : null,
                ),
              );
      },
    );
  }
}
