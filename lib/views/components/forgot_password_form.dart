part of '../views.dart';

class ForgotPasswordForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Failed to send reset link')),
            );
        }
        if (state.status.isSubmissionSuccess) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text(
                    'Successfully send reset link! please check your email!'),
              ),
            );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.all(60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Forgot Password?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(height: 40),
              Container(
                  child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
                      child: _EmailInput3()),
                  SizedBox(height: 50),
                  _ForgotPasswordButton(),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Back to ",
                          style: TextStyle(color: Colors.grey, fontSize: 13)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => false,
                          );
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.purple, fontSize: 13),
                        ),
                      ),
                    ],
                  )
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }
}

class _EmailInput3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => context
              .read<ForgotPasswordBloc>()
              .add(ForgotPasswordEmailChanged(email)),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.email),
            hintText: "Email",
            hintStyle: TextStyle(color: Colors.grey),
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.grey),
            ),
            errorText: state.email.invalid ? 'invalid email' : null,
          ),
          style: TextStyle(fontSize: 15),
        );
      },
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
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
                  key: const Key('forgotPasswordForm_continue_raisedButton'),
                  color: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.purple),
                  ),
                  child: const Text(
                    'Send Reset Link',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  onPressed: state.status.isValidated
                      ? () {
                          context
                              .read<ForgotPasswordBloc>()
                              .add(const ForgotPasswordSubmitted());
                        }
                      : null,
                ),
              );
      },
    );
  }
}
