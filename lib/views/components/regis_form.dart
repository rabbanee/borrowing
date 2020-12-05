part of '../views.dart';

class RegisterForm extends StatefulWidget {
  @override
  _Register createState() => _Register();
}

class _Register extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
        if (state.status.isSubmissionSuccess) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  content: Text(
                      'Registration Success! please check your email for verification.')),
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
                  "Register",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
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
                              bottom: BorderSide(color: Colors.grey[200]))),
                      child: _NameInput(),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
                      child: _EmailInput2(),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
                      child: _PasswordInput2(),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
                      child: _CPasswordInput(),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
                      child: _RoleInput(),
                    ),
                    SizedBox(
                      child: _ParentEmailInput(),
                    ),
                    SizedBox(height: 30),
                    _RegisterButton(),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("have any account ? ",
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
                            style: TextStyle(
                                color: Colors.purple,
                                fontSize: 13,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoleInput extends StatefulWidget {
  @override
  _RoleForm createState() => _RoleForm();
}

class _RoleForm extends State<_RoleInput> {
  String _roleItem;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.role != current.role,
      builder: (context, state) {
        return DropdownButton(
          key: const Key('RegisterForm_roleInput_textField'),
          value: _roleItem,
          onChanged: (role) {
            context.read<RegisterBloc>().add(RegisterRoleChanged(role));
            setState(() {
              _roleItem = role;
            });
          },
          hint: Text('Select Role'),
          items: ['teacher', 'musyrif', 'student'].map((item) {
            return DropdownMenuItem(
              child: Text(item),
              value: item,
            );
          }).toList(),
          // style: TextStyle(fontSize: 15),
        );
      },
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          key: const Key('RegisterForm_nameInput_textField'),
          onChanged: (name) =>
              context.read<RegisterBloc>().add(RegisterNameChanged(name)),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person),
            hintText: "Name",
            hintStyle: TextStyle(color: Colors.grey),
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.grey),
            ),
            errorText: state.name.invalid ? 'invalid name' : null,
          ),
          style: TextStyle(fontSize: 15),
        );
      },
    );
  }
}

class _EmailInput2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('RegisterForm_emailInput_textField'),
          onChanged: (email) =>
              context.read<RegisterBloc>().add(RegisterEmailChanged(email)),
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

class _PasswordInput2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('RegisterForm_passwordInput_textField'),
          onChanged: (password) => context
              .read<RegisterBloc>()
              .add(RegisterPasswordChanged(password)),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.grey),
            fillColor: Colors.white,
            errorText: state.password.invalid ? 'invalid password' : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          style: TextStyle(fontSize: 15),
          obscureText: true,
        );
      },
    );
  }
}

class _CPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.cPassword != current.cPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('RegisterForm_cPasswordInput_textField'),
          onChanged: (cPassword) => context
              .read<RegisterBloc>()
              .add(RegisterCPasswordChanged(cPassword)),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock_clock),
            hintText: "Confirm Password",
            hintStyle: TextStyle(color: Colors.grey),
            fillColor: Colors.white,
            errorText: state.cPassword.invalid
                ? 'invalid password'
                : (state.cPassword.value != state.password.value)
                    ? 'password not match'
                    : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          style: TextStyle(fontSize: 15),
          obscureText: true,
        );
      },
    );
  }
}

class _ParentEmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) =>
          previous.parentEmail != current.parentEmail ||
          previous.role != current.role,
      builder: (context, state) {
        return state.role == 'student'
            ? Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey[200]))),
                child: TextField(
                  key: const Key('RegisterForm_parentEmailInput_textField'),
                  onChanged: (parentEmail) => context
                      .read<RegisterBloc>()
                      .add(RegisterParentEmailChanged(parentEmail)),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mark_email_unread),
                    hintText: "Parent Email",
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorText: state.parentEmail.invalid ? 'invalid email' : null,
                  ),
                  style: TextStyle(fontSize: 15),
                ),
              )
            : SizedBox();
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
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
                  key: const Key('RegisterForm_continue_raisedButton'),
                  color: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.purple),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  onPressed: state.status.isValidated
                      ? () {
                          context
                              .read<RegisterBloc>()
                              .add(const RegisterSubmitted());
                        }
                      : null,
                ),
              );
      },
    );
  }
}
