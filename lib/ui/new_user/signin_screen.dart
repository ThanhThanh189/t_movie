import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/authentication/authentication_bloc.dart';
import 'package:movie_ticket/blocs/authentication/authentication_event.dart';
import 'package:movie_ticket/blocs/login/login_bloc.dart';
import 'package:movie_ticket/blocs/login/login_event.dart';
import 'package:movie_ticket/blocs/login/login_state.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_icons.dart';
import 'package:movie_ticket/common/app_strings.dart';
import 'package:movie_ticket/common/app_text_styles.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/repositories/user_repository.dart';
import 'package:movie_ticket/ui/new_user/signup_screen.dart';
import 'package:movie_ticket/ui/widgets/base_button/base_button.dart';
import 'package:movie_ticket/ui/widgets/input_text_field/input_text_field.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({
    Key? key,
    required this.userRepository,
  }) : super(key: key);
  final UserRepository userRepository;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            )),
        const SizedBox(
          height: 32,
        ),
        Container(
          margin: const EdgeInsets.only(right: 150),
          child: Text(
            AppStrings.signinWelcomBack,
            style: AppTextStyles.medium24,
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
          _buildButtonLogin(context),
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
        BlocProvider.of<LoginBloc>(context)
            .add(SetPasswordLoginEvent(password: value));
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
          style: AppTextStyles.regular14.copyWith(color: AppColors.mainText),
        )
      ],
    );
  }

  Widget _buildButtonLogin(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: BaseButton(
          text: AppStrings.signinLogin,
          onPressed: () {
            BlocProvider.of<LoginBloc>(context).add(
                LoginWithEmailAndPasswordEvent(
                    email: _emailController.text,
                    password: _passwordController.text));
          }),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SignUpScreen(userRepository: userRepository),
          ),
        );
      },
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
          text: AppStrings.signinCreateNewAccount,
          style: AppTextStyles.medium14.copyWith(color: AppColors.mainText),
        ),
        TextSpan(
          text: AppStrings.signinSignUp,
          style: AppTextStyles.medium14.copyWith(color: AppColors.mainColor),
        ),
      ])),
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
              borderRadius: BorderRadius.circular(1000)),
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
              borderRadius: BorderRadius.circular(1000)),
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
