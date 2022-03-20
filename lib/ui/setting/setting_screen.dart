import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/authentication/authentication_bloc.dart';
import 'package:movie_ticket/blocs/authentication/authentication_event.dart';
import 'package:movie_ticket/common/color_constraints.dart';
import 'package:movie_ticket/common/global.dart';
import 'package:movie_ticket/common/string_constraints.dart';
import 'package:movie_ticket/data/repositories/user_repository.dart';
import 'package:movie_ticket/ui/setting/edit_profile_screen.dart';

class SettingScreen extends StatelessWidget {
  final UserRepository userRepository;
  const SettingScreen({
    Key? key,
    required this.userRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: const CircleAvatar(
                    radius: 60,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(Global.urlAvatar),
                    )),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child:
                    const Text('Arya Wijaya', style: StringConstraints.h2Bold),
              ),
              const Text(
                'Awekadesign@gmail.com',
                style: StringConstraints.h8,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => EditProfileScreen(
                              userRepository: userRepository,
                            )));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(Icons.person_outline, color: Colors.blue),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Edit Profile', style: StringConstraints.h8)
                    ],
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context, builder: (_) => _builDialog(context));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(Icons.wallet_giftcard, color: Colors.blue),
                      SizedBox(
                        width: 10,
                      ),
                      Text('My Wallet', style: StringConstraints.h8)
                    ],
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context, builder: (_) => _builDialog(context));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(Icons.language, color: Colors.blue),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Change Language', style: StringConstraints.h8)
                    ],
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context, builder: (_) => _builDialog(context));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(Icons.help_center, color: Colors.blue),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Help Centre', style: StringConstraints.h8)
                    ],
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context, builder: (_) => _builDialog(context));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(Icons.rate_review, color: Colors.blue),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Rate Flutix App', style: StringConstraints.h8)
                    ],
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey),
              _buildButtonRegister(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _builDialog(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: MediaQuery.of(context).size.height * 0.2,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(15.0),
              child: const Center(
                child: Text(
                  'The skill are improving',
                  style: StringConstraints.h2BoldDark,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
                top: 10,
                right: 0,
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 30,
                    )))
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRegister(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
        decoration: BoxDecoration(
          gradient: ColorConstraints.mainGradient,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextButton(
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedOutEvent());
          },
          child: const Text(
            'Logout',
            style: StringConstraints.h2,
          ),
        ));
  }
}
