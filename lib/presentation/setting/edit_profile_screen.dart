import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/profile/profile_bloc.dart';
import 'package:movie_ticket/blocs/profile/profile_event.dart';
import 'package:movie_ticket/blocs/profile/profile_state.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_strings.dart';
import 'package:movie_ticket/common/app_text_style.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/presentation/widgets/base_button/base_button.dart';
import 'package:movie_ticket/presentation/widgets/dialog/dialog_confirm.dart';
import 'package:movie_ticket/presentation/widgets/images/profile.dart';
import 'package:movie_ticket/presentation/widgets/input_text_field/input_text_field.dart';
import 'package:movie_ticket/presentation/widgets/snack_bar/custom_snack_bar.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({
    Key? key,
  }) : super(key: key);

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc()..add(StartedProfileEvent()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
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
            Navigator.of(context).pop(true);
          }
        },
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.of(context).pop(true);
              return false;
            },
            child: Scaffold(
              backgroundColor: AppColors.dartBackground1,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          _buildBackButton(context),
                          _buildTitle(context),
                          const SizedBox(height: 40),
                          _buildAvatar(context, state),
                          const SizedBox(height: 24),
                          _buildFormRegister(context, state)
                        ],
                      )),
                ),
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
            Navigator.of(context).pop(true);
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
        margin: const EdgeInsets.symmetric(horizontal: 104.0),
        child: Text(
          AppStrings.editProfileTitle,
          style: AppTextStyle.semiBold24,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, ProfileState state) {
    return Profile(
      image: state.photoURLNew ?? state.photoURLOld,
      sizeAvatar: 92,
      isEdit: true,
      onTap: () {
        BlocProvider.of<ProfileBloc>(context).add(
          EditPhotoURLProfileEvent(),
        );
      },
    );
  }

  Widget _buildFormRegister(BuildContext context, ProfileState state) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFormInput(
              context,
              labelText: AppStrings.editProfileFullName,
              controller: _fullNameController,
              hintText: state.fullName,
              onChange: (value) {
                BlocProvider.of<ProfileBloc>(context).add(
                  SetFullNameProfileEvent(fullName: value),
                );
              },
            ),
            //Email address
            const SizedBox(height: 24),
            _buildFormInput(
              context,
              labelText: AppStrings.editProfileEmailAddress,
              controller: _emailAddressController,
              readOnly: true,
              hintText: state.email,
              onChange: (value) {},
            ),
            // //Password old
            // const SizedBox(height: 24),
            // _buildFormInput(
            //   context,
            //   labelText: AppStrings.editProfilePassword,
            //   obscureText: true,
            //   controller: _passwordController,
            //   onChange: (value) {
            //     BlocProvider.of<ProfileBloc>(context).add(
            //       SetPasswordProfileEvent(password: value),
            //     );
            //   },
            // ),

            // //Confirm password
            // const SizedBox(height: 24),
            // _buildFormInput(
            //   context,
            //   labelText: AppStrings.editProfileConfirmPassword,
            //   obscureText: true,
            //   controller: _confirmPasswordController,
            //   onChange: (value) {
            //     BlocProvider.of<ProfileBloc>(context).add(
            //       SetConfirmPasswordProfileEvent(confirmPassword: value),
            //     );
            //   },
            // ),

            //Button Register
            const SizedBox(height: 24),
            _buildButtonRegister(context, state),
          ],
        ),
      ),
    );
  }

  Widget _buildFormInput(
    BuildContext context, {
    required String labelText,
    String? hintText,
    String? errorText,
    bool? readOnly,
    bool? obscureText,
    required dynamic Function(String) onChange,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: AppTextStyle.medium12.copyWith(
            color: AppColors.mainText,
          ),
        ),
        const SizedBox(height: 8),
        InputTextField(
          controller: controller,
          onChange: onChange,
          errorText: errorText,
          obscureText: obscureText,
          isPassword: false,
          readOnly: readOnly,
          hintText: hintText,
        ),
      ],
    );
  }

  Widget _buildButtonRegister(BuildContext context, ProfileState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: BaseButton(
        text: AppStrings.editProfileButton,
        isVisible:
            ((state.isValidatePassword && state.isValidateConfirmPassword) ||
                        state.isValidateFullName ||
                        state.photoURLNew != null) &&
                    state.viewState != ViewState.isLoading
                ? true
                : false,
        onPressed: ((state.isValidatePassword &&
                        state.isValidateConfirmPassword) ||
                    state.isValidateFullName ||
                    state.photoURLNew != null) &&
                state.viewState != ViewState.isLoading
            ? () {
                showDialog(
                  context: context,
                  builder: (_) => DialogConfirm(
                    title: AppStrings.editProfileDialog,
                    onTap: (value) {
                      if (value == true) {
                        BlocProvider.of<ProfileBloc>(context).add(
                          EditUserProfileEvent(
                              photoURL: state.photoURLNew,
                              displayName: _fullNameController.text,
                              newPassword: _passwordController.text,
                              confirmPassword: _confirmPasswordController.text),
                        );
                      }
                    },
                  ),
                );
              }
            : null,
      ),
    );
  }
}
