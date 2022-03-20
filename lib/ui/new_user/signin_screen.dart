import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/authentication/authentication_bloc.dart';
import 'package:movie_ticket/blocs/authentication/authentication_event.dart';
import 'package:movie_ticket/blocs/login/login_bloc.dart';
import 'package:movie_ticket/blocs/login/login_event.dart';
import 'package:movie_ticket/blocs/login/login_state.dart';
import 'package:movie_ticket/common/color_constraints.dart';
import 'package:movie_ticket/common/icon_constraints.dart';
import 'package:movie_ticket/common/string_constraints.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/repositories/user_repository.dart';
import 'package:movie_ticket/ui/new_user/signup_screen.dart';

class SignInScreen extends StatelessWidget {
  final UserRepository userRepository;
  const SignInScreen({
    Key? key,
    required this.userRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => LoginBloc(userRepository: userRepository),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.viewState == ViewState.isLoading) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('is loading'),
              duration: Duration(milliseconds: 1000),
            ));
          }
          if (state.viewState == ViewState.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message.toString()),
                duration: const Duration(milliseconds: 1000)));
          }
          if (state.viewState == ViewState.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('login success'),
                duration: Duration(milliseconds: 1000)));
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedInEvent());
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    // welcome back
                    _buildWelcome(context),
                    // form login
                    _buildForm(context, state, _formKey, _emailController,
                        _passwordController)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWelcome(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.all(23.6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.blue),
              child: Image.asset(
                IconContraints.iconFilm,
                color: Colors.white,
                width: 40.69,
                height: 40.69,
              )),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(right: 150),
            child: const Text(
              'Welcome Back, Movie Lover!',
              style: StringConstraints.h1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(
      BuildContext context,
      LoginState state,
      GlobalKey<FormState> _formKey,
      TextEditingController _emailController,
      TextEditingController _passwordController) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildFormEmail(context, state, _emailController),
            _buildFormPassword(context, state, _passwordController),
            _buildForgotPassword(context),
            _buildButtonLogin(context, _emailController, _passwordController),
            _buildSignUp(context),
            _buildLoginWithGoogleAndFacebook(context)
          ],
        ),
      ),
    );
  }

  Widget _buildFormEmail(BuildContext context, LoginState state,
      TextEditingController _emailController) {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
          labelText: 'Email Address',
          errorText: state.isValidateEmail ? null : 'email is not empty',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      validator: null,
      onChanged: (value) {
        BlocProvider.of<LoginBloc>(context)
            .add(SetEmailLoginEvent(email: value));
      },
    );
  }

  Widget _buildFormPassword(BuildContext context, LoginState state,
      TextEditingController _passwordController) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: _passwordController,
        obscureText: state.showPassword ? false : true,
        decoration: InputDecoration(
            errorText:
                state.isValidatePassword ? null : 'password is not empty',
            suffixIcon: GestureDetector(
              onTap: () {
                BlocProvider.of<LoginBloc>(context)
                    .add(ShowPasswordEvent(showPassword: !state.showPassword));
              },
              child: state.showPassword
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
            ),
            labelText: 'Password',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        validator: null,
        onChanged: (value) {
          BlocProvider.of<LoginBloc>(context)
              .add(SetPasswordLoginEvent(password: value));
        },
      ),
    );
  }

  Widget _buildForgotPassword(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Text(
            'Forgot Password?',
            textAlign: TextAlign.end,
            style: StringConstraints.h2,
          )
        ],
      ),
    );
  }

  Widget _buildButtonLogin(
      BuildContext context,
      TextEditingController _emailController,
      TextEditingController _passwordController) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorConstraints.greyBackground1),
        child: FlatButton(
          color: ColorConstraints.greyBackground1,
          onPressed: () {
            BlocProvider.of<LoginBloc>(context).add(
                LoginWithEmailAndPasswordEvent(
                    email: _emailController.text,
                    password: _passwordController.text));
          },
          child: const Text(
            'Login',
            style: StringConstraints.h1,
          ),
        ));
  }

  Widget _buildSignUp(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => SignUpScreen(userRepository: userRepository)));
        },
        child: RichText(
            text: const TextSpan(children: [
          TextSpan(text: 'Create new account?', style: StringConstraints.h3),
          TextSpan(text: ' Sign Up', style: StringConstraints.h4),
        ])),
      ),
    );
  }

  Widget _buildLoginWithGoogleAndFacebook(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: ColorConstraints.greyBackground1,
                borderRadius: BorderRadius.circular(1000)),
            child: ClipOval(
              child: Image.asset(
                IconContraints.iconGoogle,
                height: 50,
                width: 50,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
                color: ColorConstraints.greyBackground1,
                borderRadius: BorderRadius.circular(1000)),
            child: ClipOval(
              child: Image.asset(
                IconContraints.iconFacebook,
                height: 64,
                width: 64,
              ),
            ),
          )
        ],
      ),
    );
  }
}
