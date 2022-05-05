import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/cart/cart_bloc.dart';
import 'package:movie_ticket/blocs/cart/cart_event.dart';
import 'package:movie_ticket/blocs/cart/cart_state.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_text_style.dart';
import 'package:movie_ticket/common/app_text_styles.dart';
import 'package:movie_ticket/common/date_contants.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/presentation/order_ticket/information_screen.dart';
import 'package:movie_ticket/presentation/widgets/card/ticket_card_view.dart';
import 'package:movie_ticket/presentation/widgets/snack_bar/custom_snack_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartBloc>(
      create: (context) => CartBloc()..add(StartedCartEvent()),
      child: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state.viewState == ViewState.isFailure) {
            if (state.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(
                  message: state.message.toString(),
                  isSuccess: false,
                  milliseconds: 1000,
                ),
              );
            }
          }
          if (state.viewState == ViewState.isSuccess) {
            if (state.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(
                  message: state.message.toString(),
                  isSuccess: true,
                  milliseconds: 1000,
                ),
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'My Ticket',
                style: AppTextStyle.semiBold24,
              ),
              backgroundColor: AppColors.dartBackground1,
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            backgroundColor: AppColors.dartBackground1,
            body: state.viewState == ViewState.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state.listMyTicket.isNotEmpty
                    ? _buildListCart(context, state)
                    : const Center(
                        child: Text(
                          'Don\'t has data',
                          style: AppTextStyle.medium14,
                        ),
                      ),
          );
        },
      ),
    );
  }

  Widget _buildListCart(BuildContext context, CartState state) {
    return ListView.builder(
        itemCount: state.listMyTicket.length,
        itemBuilder: (context, index) {
          return Dismissible(
            background: Container(
              color: Colors.red,
            ),
            confirmDismiss: (directory) async {
              var result = await showDialog(
                  context: context,
                  builder: (_) => _builDialog(context, state, index));
              return result['confirm'];
            },
            key: Key(state.listMyTicket[index].id.toString()),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => InformationScreen(
                        filmData: state.listMyTicket[index].filmData)));
              },
              child: TicketCardView(
                  filmData: state.listMyTicket[index].filmData,
                  time: state.listMyTicket[index].cinemaTime,
                  date: state.listMyTicket[index].dateTime.dateToDateTicket(),
                  cinemaName: state.listMyTicket[index].cinemaName),
            ),
          );
        });
  }

  Widget _builDialog(BuildContext context, CartState state, int index) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: const Center(
                  child: Text(
                    'Are you sure you want to delete?',
                    style: AppTextStyles.h2BoldDark,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(width: 1, color: Colors.black))),
                    child: TextButton(
                        onPressed: () {
                          BlocProvider.of<CartBloc>(context).add(
                              DeleteCartEvent(
                                  id: state.listMyTicket[index].id));
                          Navigator.of(context).pop({'confirm': true});
                        },
                        child: const Text(
                          'OK',
                          style: AppTextStyles.h2BoldRed,
                          textAlign: TextAlign.center,
                        )),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(width: 1, color: Colors.black))),
                    child: TextButton(
                        onPressed: () =>
                            Navigator.of(context).pop({'confirm': false}),
                        child: const Text(
                          'Cancel',
                          style: AppTextStyles.h2BoldDark,
                          textAlign: TextAlign.center,
                        )),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
