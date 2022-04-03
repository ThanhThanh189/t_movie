import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/authentication/authentication_bloc.dart';
import 'package:movie_ticket/blocs/authentication/authentication_event.dart';
import 'package:movie_ticket/blocs/authentication/authentication_state.dart';
import 'package:movie_ticket/ui/new_user/signin_screen.dart';
import 'package:movie_ticket/ui/router/router_screen.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc()..add(AuthStartedEvent()),
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthStateSuccess) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => RouterScreen(
                  user: state.user,
                ),
              ),
            );
          }
          if (state is AuthStateFailure) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => SignInScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      //     BlocBuilder<AuthenticationBloc, AuthenticationState>(
      //   builder: (context, authState) {
      //     if (authState is AuthStateSuccess) {
      //       print('AuthStateSuccess');
      //       return RouterScreen(
      //         user: authState.user,
      //       );
      //     }
      //     if (authState is AuthStateFailure) {
      //       return SignInScreen(userRepository: userRepository);
      //     }
      //     return const Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // ),
    );
  }
}
