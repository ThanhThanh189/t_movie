import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/register/register_bloc.dart';
import 'package:movie_ticket/blocs/register/register_event.dart';
import 'package:movie_ticket/blocs/register/register_state.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/global.dart';
import 'package:movie_ticket/common/app_text_styles.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/repositories/user_repository.dart';

class SignUpScreen extends StatelessWidget {
  final UserRepository userRepository;
  SignUpScreen({
    Key? key,
    required this.userRepository,
  }) : super(key: key);
  final _fullName = TextEditingController();
  final _emailAddress = TextEditingController();
  final _passWord = TextEditingController();
  final _confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(userRepository: userRepository),
      child: BlocConsumer<RegisterBloc, RegisterState>(
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
              duration: const Duration(milliseconds: 1000),
            ));
          }
          if (state.viewState == ViewState.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message.toString()),
              duration: const Duration(milliseconds: 1000),
            ));
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.dartBackground1,
            appBar: AppBar(
              title: const Text('Create New Your Account'),
              backgroundColor: AppColors.dartBackground1,
              centerTitle: true,
            ),
            body: Container(
                margin: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    // _buildTitle(context),
                    _buildAvatar(context, state),
                    _buildFormRegister(context, state)
                  ],
                )),
          );
        },
      ),
    );
  }

  // Widget _buildTitle(BuildContext context) {
  //   return Center(
  //     child: Container(
  //       margin: EdgeInsets.symmetric(horizontal: 88.0),
  //       child: Text(
  //         'Create New Your Account',
  //         style: StringConstraints.h1,
  //         textAlign: TextAlign.center,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildAvatar(BuildContext context, RegisterState state) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      child: const CircleAvatar(
          radius: 40,
          child: CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(Global.urlAvatar),
          )
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(100),
          //   child: Image.asset(
          //     'assets/images/auto.jpg',
          //     fit: BoxFit.cover,
          //   ),
          // ),
          ),
    );
  }

  Widget _buildFormRegister(BuildContext context, RegisterState state) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Form(
          child: Column(
        children: [
          TextFormField(
            controller: _fullName,
            decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
            validator: (validator) {
              if (validator == null || validator.isEmpty) {
                return 'Please';
              }
              return null;
            },
            onChanged: (value) {},
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextFormField(
              controller: _emailAddress,
              decoration: InputDecoration(
                  errorText:
                      state.isValidateEmail ? null : 'Please enter the value',
                  labelText: 'Email Address',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              validator: (validator) {
                if (validator == null || validator.isEmpty) {
                  return 'Please';
                }
                return null;
              },
              onChanged: (value) {
                BlocProvider.of<RegisterBloc>(context)
                    .add(SetEmailRegisterEvent(email: value));
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextFormField(
              obscureText: !state.showPassword,
              controller: _passWord,
              decoration: InputDecoration(
                  errorText: state.isValidatePassword
                      ? null
                      : 'Please enter the value',
                  labelText: 'Password',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      BlocProvider.of<RegisterBloc>(context).add(
                          ShowPasswordRegisterEvent(
                              showPassword: !state.showPassword));
                    },
                    child: !state.showPassword
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              validator: (validator) {
                if (validator == null || validator.isEmpty) {
                  return 'Please';
                }
                return null;
              },
              onChanged: (value) {
                BlocProvider.of<RegisterBloc>(context)
                    .add(SetPasswordRegisterEvent(password: value));
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextFormField(
              obscureText: !state.showConfirmPassword,
              controller: _confirmPassword,
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      BlocProvider.of<RegisterBloc>(context).add(
                          ShowConfirmPasswordRegisterEvent(
                              showConfirmPassword: !state.showConfirmPassword));
                    },
                    child: !state.showConfirmPassword
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                  errorText: state.isValidateConfirmPassword
                      ? null
                      : 'Please enter the value',
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              validator: (validator) {
                if (validator == null || validator.isEmpty) {
                  return 'Please';
                }
                return null;
              },
              onChanged: (value) {
                BlocProvider.of<RegisterBloc>(context)
                    .add(SetConfirmPasswordRegisterEvent(password: value));
              },
            ),
          ),
          _buildButtonRegister(context, state),
        ],
      )),
    );
  }

  Widget _buildButtonRegister(BuildContext context, RegisterState state) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
        decoration: BoxDecoration(
          gradient: AppColors.mainGradient,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextButton(
          onPressed: () {
            BlocProvider.of<RegisterBloc>(context).add(
                RegisterWithEmailPasswordRegisterEvent(
                    email: _emailAddress.text,
                    password: _passWord.text,
                    confirmPassword: _confirmPassword.text));
          },
          child: const Text(
            'Sign Up',
            style: AppTextStyles.h2,
          ),
        ));
  }
}
