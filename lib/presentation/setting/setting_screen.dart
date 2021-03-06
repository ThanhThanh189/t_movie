import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/setting/setting_bloc.dart';
import 'package:movie_ticket/blocs/setting/setting_event.dart';
import 'package:movie_ticket/blocs/setting/setting_state.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_text_styles.dart';
import 'package:movie_ticket/presentation/my_wallet/my_wallet_screen.dart';
import 'package:movie_ticket/presentation/new_user/signin_screen.dart';
import 'package:movie_ticket/presentation/setting/edit_profile_screen.dart';
import 'package:movie_ticket/presentation/widgets/dialog/dialog_improving.dart';
import 'package:movie_ticket/presentation/widgets/images/profile.dart';

class SettingScreen extends StatelessWidget {
  final User user;
  const SettingScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingBloc>(
      create: (context) => SettingBloc()..add(StartedSettingEvent()),
      child: BlocConsumer<SettingBloc, SettingState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.dartBackground1,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Profile(
                      sizeAvatar: 132,
                      isEdit: false,
                      image: state.account?.photo,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Text(state.account?.displayName ?? '',
                          style: AppTextStyles.h2Bold),
                    ),
                    Text(
                      user.email!,
                      style: AppTextStyles.h8,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: GestureDetector(
                        onTap: () async {
                          final result = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => EditProfileScreen()));
                          if (result == true) {
                            BlocProvider.of<SettingBloc>(context)
                                .add(StartedSettingEvent());
                          }
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(Icons.person_outline, color: Colors.blue),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Edit Profile', style: AppTextStyles.h8)
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
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => MyWalletScreen(),
                            ),
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(Icons.wallet_giftcard, color: Colors.blue),
                            SizedBox(
                              width: 10,
                            ),
                            Text('My Wallet', style: AppTextStyles.h8)
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
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => const DialogImproving(),
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(Icons.help_center, color: Colors.blue),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Help Centre', style: AppTextStyles.h8)
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
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => const DialogImproving(),
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(Icons.rate_review, color: Colors.blue),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Rate Flutix App', style: AppTextStyles.h8)
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
        },
      ),
    );
  }

  Widget _buildButtonRegister(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
        decoration: BoxDecoration(
          gradient: AppColors.mainGradient,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextButton(
          onPressed: () {
            BlocProvider.of<SettingBloc>(context).add(
              LoggedoutSettingEvent(),
            );
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => SignInScreen(),
              ),
            );
          },
          child: const Text(
            'Logout',
            style: AppTextStyles.h2,
          ),
        ));
  }
}
