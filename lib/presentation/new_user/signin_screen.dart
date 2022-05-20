import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/login/login_bloc.dart';
import 'package:movie_ticket/blocs/login/login_event.dart';
import 'package:movie_ticket/blocs/login/login_state.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_icons.dart';
import 'package:movie_ticket/common/app_strings.dart';
import 'package:movie_ticket/common/app_text_style.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/presentation/new_user/signup_screen.dart';
import 'package:movie_ticket/presentation/revenue.dart/revenue_screen.dart';
import 'package:movie_ticket/presentation/router/router_screen.dart';
import 'package:movie_ticket/presentation/widgets/base_button/base_button.dart';
import 'package:movie_ticket/presentation/widgets/input_text_field/input_text_field.dart';
import 'package:movie_ticket/presentation/widgets/snack_bar/custom_snack_bar.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({
    Key? key,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocConsumer<LoginBloc, LoginState>(
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
                isSuccess: false,
                milliseconds: 1000,
              ),
            );
          }
          if (state.viewState == ViewState.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar(
                message: state.message.toString(),
                isSuccess: true,
                milliseconds: 1000,
              ),
            );
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  if (state.isAdmin == true) {
                    return const RevenueScreen();
                  }
                  return RouterScreen(user: state.user!);
                },
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.dartBackground1,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    const SizedBox(height: 72),
                    // welcome back
                    _buildWelcome(context),
                    const SizedBox(height: 41),
                    // form login
                    _buildForm(context, state)
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(23.6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.mainColor),
          child: Image.asset(
            AppIcons.iconFilm,
            color: Colors.white,
            width: 40.69,
            height: 40.69,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Container(
          margin: const EdgeInsets.only(right: 150),
          child: Text(
            AppStrings.signinWelcomBack,
            style: AppTextStyle.medium24,
          ),
        ),
      ],
    );
  }

  Widget _buildForm(
    BuildContext context,
    LoginState state,
  ) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildFormEmail(context, state),
          const SizedBox(
            height: 44,
          ),
          _buildFormPassword(context, state),
          const SizedBox(
            height: 12,
          ),
          _buildForgotPassword(context),
          const SizedBox(
            height: 28,
          ),
          _buildButtonLogin(
            context,
            state,
          ),
          const SizedBox(
            height: 21,
          ),
          _buildSignUp(context),
          const SizedBox(
            height: 28,
          ),
          _buildLoginWithGoogleAndFacebook(context)
        ],
      ),
    );
  }

  Widget _buildFormEmail(
    BuildContext context,
    LoginState state,
  ) {
    return InputTextField(
      controller: _emailController,
      labelText: AppStrings.signinEmailAddress,
      errorText: state.isValidateEmail ? null : AppStrings.signinEmailNotEmpty,
      isPassword: false,
      onChange: (value) {
        BlocProvider.of<LoginBloc>(context).add(
          SetEmailLoginEvent(email: value),
        );
      },
    );
  }

  Widget _buildFormPassword(
    BuildContext context,
    LoginState state,
  ) {
    return InputTextField(
      controller: _passwordController,
      obscureText: state.showPassword ? false : true,
      errorText:
          state.isValidatePassword ? null : AppStrings.signinPasswordNotEmpty,
      isPassword: true,
      labelText: AppStrings.signinPassword,
      onTapEyes: () {
        BlocProvider.of<LoginBloc>(context).add(
          ShowPasswordEvent(showPassword: !state.showPassword),
        );
      },
      visibility: state.showPassword,
      onChange: (value) {
        BlocProvider.of<LoginBloc>(context).add(
          SetPasswordLoginEvent(password: value),
        );
      },
    );
  }

  Widget _buildForgotPassword(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          AppStrings.signinForgotPassword,
          textAlign: TextAlign.end,
          style: AppTextStyle.regular14.copyWith(color: AppColors.mainText),
        )
      ],
    );
  }

  Widget _buildButtonLogin(BuildContext context, LoginState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: BaseButton(
        text: AppStrings.signinLogin,
        isVisible: _emailController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty &&
            state.viewState != ViewState.isLoading,
        onPressed: state.viewState == ViewState.isLoading
            ? null
            : () {
                BlocProvider.of<LoginBloc>(context).add(
                  LoginWithEmailAndPasswordEvent(
                      email: _emailController.text,
                      password: _passwordController.text),
                );
              },
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SignUpScreen(),
          ),
        );
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: AppStrings.signinCreateNewAccount,
              style: AppTextStyle.medium14.copyWith(color: AppColors.mainText),
            ),
            TextSpan(
              text: AppStrings.signinSignUp,
              style: AppTextStyle.medium14.copyWith(color: AppColors.mainColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginWithGoogleAndFacebook(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.dartBackground2,
            borderRadius: BorderRadius.circular(1000),
          ),
          child: ClipOval(
            child: Image.asset(
              AppIcons.iconGoogle,
              height: 36,
              width: 36,
            ),
          ),
        ),
        const SizedBox(
          width: 32,
        ),
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: AppColors.dartBackground2,
            borderRadius: BorderRadius.circular(1000),
          ),
          child: ClipOval(
            child: Image.asset(
              AppIcons.iconFacebook,
              height: 50,
              width: 50,
            ),
          ),
        )
      ],
    );
  }
}
