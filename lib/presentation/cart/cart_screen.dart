import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/cart/cart_bloc.dart';
import 'package:movie_ticket/blocs/cart/cart_event.dart';
import 'package:movie_ticket/blocs/cart/cart_state.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_text_styles.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/presentation/cart/check_out_screen.dart';
import 'package:movie_ticket/presentation/order_ticket/information_screen.dart';
import 'package:movie_ticket/presentation/widgets/card/card_view.dart';

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
            state.message != '' && state.message != null
                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message.toString()),
                    duration: const Duration(milliseconds: 1000)))
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
              backgroundColor: AppColors.dartBackground1,
              actions: [
                Visibility(
                  visible: state.listFilmData.isNotEmpty,
                  child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<CartBloc>(context).add(
                            SelectAllCartEvent(
                                isSelected: !state.isSelectedAll));
                      },
                      child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: state.isSelectedAll
                              ? const Icon(Icons.select_all, color: Colors.blue)
                              : const Icon(Icons.select_all))),
                )
              ],
              title: const Text('Cart Screen'),
            ),
            body: _buildListCart(context, state),
            floatingActionButton: state.listFilmDataSelected.isNotEmpty
                ? FloatingActionButton(
                    backgroundColor: Colors.blue,
                    onPressed: () async {
                      var result =
                          await Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => CheckOutScreen(
                                    listFilmData: state.listFilmDataSelected,
                                  )));

                      if (result['payment']) {
                        BlocProvider.of<CartBloc>(context).add(PaymentCartEvent(
                            listFilmData: state.listFilmDataSelected));
                      } else {}
                    },
                    child: const Icon(
                      Icons.card_membership,
                      size: 30,
                      color: Colors.white,
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }

  Widget _buildListCart(BuildContext context, CartState state) {
    return ListView.builder(
        itemCount: state.listFilmData.length,
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
            onDismissed: (value) {},
            key: Key(state.listFilmData[index].id.toString()),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => InformationScreen(
                        filmData: state.listFilmData[index])));
              },
              child: Row(
                children: [
                  Checkbox(
                      checkColor: Colors.white,
                      hoverColor: Colors.blue,
                      activeColor: Colors.blue,
                      value: state.listFilmDataSelected
                          .contains(state.listFilmData[index]),
                      onChanged: (value) {
                        BlocProvider.of<CartBloc>(context).add(
                            SelectCartEvent(
                                filmData: state.listFilmData[index],
                                isSelected: value ?? false));
                      }),
                  Expanded(
                      child: CardView(filmData: state.listFilmData[index]))
                ],
              ),
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
                                  id: state.listFilmData[index].id));
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
