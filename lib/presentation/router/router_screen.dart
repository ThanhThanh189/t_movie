import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/router/router_bloc.dart';
import 'package:movie_ticket/blocs/router/router_event.dart';
import 'package:movie_ticket/blocs/router/router_state.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/presentation/cart/cart_screen.dart';
import 'package:movie_ticket/presentation/favorite/favorite_screen.dart';
import 'package:movie_ticket/presentation/order_ticket/home_screen.dart';
import 'package:movie_ticket/presentation/setting/setting_screen.dart';

class RouterScreen extends StatelessWidget {
  final User user;

  const RouterScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  List<Widget> _widgetOptions() => <Widget>[
        const HomeScreen(),
        const FavoriteScreen(),
        const CartScreen(),
        SettingScreen(
          user: user,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = _widgetOptions();

    return BlocProvider<RouterBloc>(
      create: (context) => RouterBloc(),
      child: BlocBuilder<RouterBloc, RouterState>(
        builder: (context, state) {
          return Scaffold(
            body: widgetOptions[state.index],
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                    backgroundColor: AppColors.dartBackground1),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'My Favorite',
                    backgroundColor: AppColors.dartBackground1),
                BottomNavigationBarItem(
                    icon: Icon(Icons.wallet_giftcard),
                    label: 'My Wallet',
                    backgroundColor: AppColors.dartBackground1),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'My Profile',
                    backgroundColor: AppColors.dartBackground1),
              ],
              currentIndex: state.index,
              selectedItemColor: Colors.blue,
              unselectedItemColor: AppColors.greyBackground2,
              onTap: (index) {
                BlocProvider.of<RouterBloc>(context)
                    .add(SelectItemRouterEvent(index: index));
              },
            ),
          );
        },
      ),
    );
  }
}
