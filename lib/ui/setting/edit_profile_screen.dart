import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/profile/profile_bloc.dart';
import 'package:movie_ticket/blocs/profile/profile_event.dart';
import 'package:movie_ticket/blocs/profile/profile_state.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/string_constraints.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/repositories/user_repository.dart';

class EditProfileScreen extends StatelessWidget {
  final UserRepository userRepository;
  EditProfileScreen({Key? key, 
    required this.userRepository,
  }) : super(key: key);

  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _passwordOldController = TextEditingController();
  final TextEditingController _passwordNewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc(userRepository: userRepository)
        ..add(StartedProfileEvent()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.viewState == ViewState.isFailure) {
            state.message != '' && state.message != null
                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message.toString()),
                    duration: const Duration(milliseconds: 1000),
                  ))
                : null;
          }
          if (state.viewState == ViewState.isSuccess) {
            state.message != '' && state.message != null
                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message.toString()),
                    duration: const Duration(milliseconds: 1000)))
                : null;
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.dartBackground1,
            appBar: AppBar(
              title: const Text('Edit Profile'),
              backgroundColor: AppColors.dartBackground1,
              centerTitle: true,
            ),
            body: Container(
                margin: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    _buildAvatar(context, state),
                    _buildFormRegister(context, state)
                  ],
                )),
          );
        },
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, ProfileState state) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<ProfileBloc>(context).add(EditPhotoURLProfileEvent());
        },
        child: Center(
          child: Stack(children: [
            CircleAvatar(
                radius: 40,
                child: state.photoURL != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.file(
                          File(state.photoURL!),
                          fit: BoxFit.cover,
                        ))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset("assets/images/auto2.jpg"))),
            const Positioned.fill(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Icon(
                Icons.add_circle_outlined,
                color: Colors.blue,
              ),
            ))
          ]),
        ),
      ),
    );
  }

  Widget _buildFormRegister(BuildContext context, ProfileState state) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Form(
          child: Column(
        children: [
          TextFormField(
            controller: _displayNameController,
            decoration: InputDecoration(
                hintText:
                    '${state.fullName != '' ? state.fullName : 'Full Name'}',
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
              readOnly: true,
              decoration: InputDecoration(
                  hintText:
                      state.email ?? 'Email Address',
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
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextFormField(
              obscureText: !state.isShowPasswordOld,
              controller: _passwordOldController,
              decoration: InputDecoration(
                  labelText: 'Password Old',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      BlocProvider.of<ProfileBloc>(context).add(
                          ShowPasswordOldProfileEvent(
                              isShowPassword: !state.isShowPasswordOld));
                    },
                    child: !state.isShowPasswordOld
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
              onChanged: (value) {},
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextFormField(
              obscureText: !state.isShowPasswordNew,
              controller: _passwordNewController,
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      BlocProvider.of<ProfileBloc>(context).add(
                          ShowPasswordNewProfileEvent(
                              isShowPassword: !state.isShowPasswordNew));
                    },
                    child: !state.isShowPasswordNew
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                  labelText: 'Password New',
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
          ),
          _buildButtonRegister(context, state),
        ],
      )),
    );
  }

  Widget _buildButtonRegister(BuildContext context, ProfileState state) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
        decoration: BoxDecoration(
          gradient: AppColors.mainGradient,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextButton(
          onPressed: () {
            BlocProvider.of<ProfileBloc>(context).add(EditUserProfileEvent(
                photoURL: state.photoURL,
                displayName: _displayNameController.text,
                passwordOld: _passwordOldController.text,
                passwordNew: _passwordNewController.text));
          },
          child: const Text(
            'Update My Profile',
            style: StringConstraints.h2,
          ),
        ));
  }
}
