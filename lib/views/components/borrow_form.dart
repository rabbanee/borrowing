part of '../views.dart';

class BorrowForm extends StatefulWidget {
  @override
  BorrowForm({Key key, @required this.borrow}) : super(key: key);
  final String borrow;
  _BorrowFormState createState() => _BorrowFormState();
}

class _BorrowFormState extends State<BorrowForm> {
  String date = new DateFormat('yyyy-MM-dd').format(DateTime.now());
  Users _teacher;
  Users _musyrif;

  void initState() {
    context.read<BorrowBloc>().add(BorrowDateChanged(this.date));
    context
        .read<BorrowBloc>()
        .add(BorrowNecessityChanged('Borrow The ${widget.borrow}'));
    super.initState();
    getListUser('musyrif');
    getListUser('teacher');
  }

  getListUser(role) async {
    final result = await getUsersByRole(role: role);
    if (result == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
    setState(() {
      if (role == 'teacher') {
        _teacher = result;
      } else {
        _musyrif = result;
      }
    });
    print(result.user[0].id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BorrowBloc, BorrowState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('Failed to borrow ${widget.borrow}')),
            );
        } else if (state.status.isSubmissionSuccess) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('Success to borrow ${widget.borrow}')),
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
                      child: TeacherInChargeInput(
                          teacher: _teacher, musyrif: _musyrif),
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
      buildWhen: (previous, current) =>
          previous.reason != current.reason ||
          previous.borrowDate != current.borrowDate,
      builder: (context, state) {
        if (state.borrowDate.value !=
            new DateFormat('yyyy-MM-dd').format(DateTime.now())) {
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
                    'Next',
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
