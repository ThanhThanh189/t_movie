import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/register/register_bloc.dart';
import 'package:movie_ticket/blocs/register/register_event.dart';
import 'package:movie_ticket/blocs/register/register_state.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_strings.dart';
import 'package:movie_ticket/common/app_text_style.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/presentation/router/router_screen.dart';
import 'package:movie_ticket/presentation/widgets/base_button/base_button.dart';
import 'package:movie_ticket/presentation/widgets/images/profile.dart';
import 'package:movie_ticket/presentation/widgets/input_text_field/input_text_field.dart';
import 'package:movie_ticket/presentation/widgets/snack_bar/custom_snack_bar.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({
    Key? key,
  }) : super(key: key);
  final _fullName = TextEditingController();
  final _emailAddress = TextEditingController();
  final _passWord = TextEditingController();
  final _confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.viewState == ViewState.isLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar(
                message: state.message.toString(),
                milliseconds: 1000,
              ),
            );
          }
          if (state.viewState == ViewState.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar(
                message: state.message.toString(),
                milliseconds: 1000,
                isSuccess: false,
              ),
            );
          }
          if (state.viewState == ViewState.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar(
                message: state.message.toString(),
                milliseconds: 1000,
                isSuccess: true,
              ),
            );
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => RouterScreen(
                  user: state.user!,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.dartBackground1,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        _buildBackButton(context),
                        _buildTitle(context),
                        const SizedBox(
                          height: 40,
                        ),
                        _buildAvatar(context, state: state),
                        const SizedBox(
                          height: 37,
                        ),
                        _buildFormRegister(context, state)
                      ],
                    )),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
        )
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 88.0),
        child: Text(
          AppStrings.signupCreateNew,
          style: AppTextStyle.semiBold24,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, {required RegisterState state}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Profile(
          sizeAvatar: 92.0,
          image: state.imageAvatar,
          isEdit: true,
          onTap: () {
            BlocProvider.of<RegisterBloc>(context).add(
              GetAvatarRegisterEvent(
                  isExists: state.imageAvatar != null ? true : false),
            );
          },
        )
      ],
    );
  }

  Widget _buildFormRegister(BuildContext context, RegisterState state) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Form(
        child: Column(
          children: [
            _buildFullNameForm(context, state: state),
            const SizedBox(
              height: 42,
            ),
            //Email
            _buildEmailAddressForm(context, state: state),
            const SizedBox(
              height: 42,
            ),
            //Password
            _buildPasswordForm(context, state: state),
            const SizedBox(
              height: 42,
            ),
            //Confirm password
            _buildConfirmPasswordForm(context, state: state),
            const SizedBox(
              height: 44,
            ),
            _buildButtonRegister(context, state),
            const SizedBox(
              height: 67,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFullNameForm(
    BuildContext context, {
    required RegisterState state,
  }) {
    return InputTextField(
        controller: _fullName,
        errorText: state.isValidateFullName ? null : AppStrings.signupError,
        onChange: (value) {
          BlocProvider.of<RegisterBloc>(context).add(
            SetFullNameRegisterEvent(fullName: value),
          );
        },
        isPassword: false,
        labelText: AppStrings.signupFullName);
  }

  Widget _buildEmailAddressForm(
    BuildContext context, {
    required RegisterState state,
  }) {
    return InputTextField(
        controller: _emailAddress,
        errorText: state.isValidateEmail ? null : AppStrings.signupError,
        onChange: (value) {
          BlocProvider.of<RegisterBloc>(context).add(
            SetEmailRegisterEvent(email: value),
          );
        },
        isPassword: false,
        labelText: AppStrings.signupEmailAddress);
  }

  Widget _buildPasswordForm(
    BuildContext context, {
    required RegisterState state,
  }) {
    return InputTextField(
      controller: _passWord,
      obscureText: !state.showPassword,
      onTapEyes: () {
        BlocProvider.of<RegisterBloc>(context).add(
          ShowPasswordRegisterEvent(showPassword: !state.showPassword),
        );
      },
      visibility: state.showPassword,
      errorText: state.isValidatePassword ? null : AppStrings.signupError,
      onChange: (value) {
        BlocProvider.of<RegisterBloc>(context).add(
          SetPasswordRegisterEvent(password: value),
        );
      },
      isPassword: true,
      labelText: AppStrings.signupPassword,
    );
  }

  Widget _buildConfirmPasswordForm(
    BuildContext context, {
    required RegisterState state,
  }) {
    return InputTextField(
      controller: _confirmPassword,
      obscureText: !state.showConfirmPassword,
      onTapEyes: () {
        BlocProvider.of<RegisterBloc>(context).add(
          ShowConfirmPasswordRegisterEvent(
              showConfirmPassword: !state.showConfirmPassword),
        );
      },
      visibility: state.showConfirmPassword,
      errorText:
          state.isValidateConfirmPassword ? null : AppStrings.signupError,
      onChange: (value) {
        BlocProvider.of<RegisterBloc>(context).add(
          SetConfirmPasswordRegisterEvent(password: value),
        );
      },
      isPassword: true,
      labelText: AppStrings.signupConfirmPassword,
    );
  }

  Widget _buildButtonRegister(BuildContext context, RegisterState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 60),
      child: BaseButton(
          text: AppStrings.signupSignUp,
          onPressed: () {
            BlocProvider.of<RegisterBloc>(context).add(
              RegisterWithEmailPasswordRegisterEvent(
                  email: _emailAddress.text,
                  password: _passWord.text,
                  confirmPassword: _confirmPassword.text,
                  displayName: _fullName.text),
            );
          },
          isVisible: _fullName.text.isNotEmpty &&
              _emailAddress.text.isNotEmpty &&
              _passWord.text.isNotEmpty &&
              _confirmPassword.text.isNotEmpty &&
              state.viewState != ViewState.isLoading),
    );
  }
}
