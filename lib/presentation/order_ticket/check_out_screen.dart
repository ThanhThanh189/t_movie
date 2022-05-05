import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket/blocs/checkout/checkout_bloc.dart';
import 'package:movie_ticket/blocs/checkout/checkout_event.dart';
import 'package:movie_ticket/blocs/checkout/checkout_state.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_text_style.dart';
import 'package:movie_ticket/common/date_contants.dart';
import 'package:movie_ticket/common/global.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/models/film_data.dart';
import 'package:movie_ticket/data/models/ticket.dart';
import 'package:movie_ticket/presentation/new_user/splash_screen.dart';
import 'package:movie_ticket/presentation/order_ticket/information_screen.dart';
import 'package:movie_ticket/presentation/order_ticket/success_checkout.dart';
import 'package:movie_ticket/presentation/widgets/base_appbar/base_appbar_view.dart';
import 'package:movie_ticket/presentation/widgets/base_button/base_button.dart';
import 'package:movie_ticket/presentation/widgets/contants/contants.dart';
import 'package:movie_ticket/presentation/widgets/dialog/dialog_confirm.dart';
import 'package:movie_ticket/presentation/widgets/snack_bar/custom_snack_bar.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({
    required this.filmData,
    required this.chooseTime,
    required this.chooseDate,
    required this.cinemaName,
    required this.listSeatSelected,
    Key? key,
  }) : super(key: key);
  final FilmData filmData;
  final CinemaTime chooseTime;
  final DateTime chooseDate;
  final CinemaName cinemaName;
  final List<String> listSeatSelected;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CheckoutBloc>(
      create: (context) => CheckoutBloc()..add(StartedCheckoutEvent()),
      child: BlocConsumer<CheckoutBloc, CheckoutState>(
        listener: (context, state) {
          if (state.viewState == ViewState.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar(
                message: state.message.toString(),
                milliseconds: 1000,
                isSuccess: true,
              ),
            );
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SuccessCheckout(),
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
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.dartBackground1,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    BaseAppBarView(title: 'Checkout \nMovie', onBackTap: () {}),
                    const SizedBox(height: 40),
                    _buildTicketInfo(context),
                    const SizedBox(height: 58),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: BaseButton(
                        text: 'Checkout',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => DialogConfirm(
                              title: 'Do you want to checkout?',
                              onTap: (value) {
                                if (value) {
                                  BlocProvider.of<CheckoutBloc>(context).add(
                                    SelectCheckoutEvent(
                                      ticket: Ticket(
                                          id: DateTime.now().microsecondsSinceEpoch.toString(),
                                          cinemaName: cinemaName.title,
                                          dateTime: chooseDate,
                                          cinemaTime: chooseTime.title,
                                          listSeat: listSeatSelected,
                                          total:
                                              listSeatSelected.length * 50000,
                                          filmData: filmData),
                                    ),
                                  );
                                }
                              },
                            ),
                          );
                        },
                        isVisible: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

extension CheckOutScreenBasicComponents on CheckOutScreen {
  Widget _buildTicketInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Column(
        children: [
          _buildInforFilm(context),
          const SizedBox(height: 32),
          _buildInforPrice(context),
          const SizedBox(height: 26),
          _buildLabelTicketInfo(
            context,
            title: 'Your Wallet',
            value: 'IDR 200.000',
            isYourWallet: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInforFilm(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => InformationScreen(filmData: filmData)));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            height: 150,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.dartBackground2,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: _buildLoadImage(
                  url: filmData.posterPath.isNotEmpty
                      ? Global.imageURL + filmData.posterPath
                      : Global.urlError),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  filmData.originalTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:
                      AppTextStyle.medium16.copyWith(color: AppColors.mainText),
                ),
                const SizedBox(width: 12),
                Row(
                  children: [
                    RatingBar.builder(
                        initialRating: filmData.voteAverage / 2.0,
                        minRating: 1,
                        itemCount: 5,
                        itemSize: 15,
                        tapOnlyMode: true,
                        allowHalfRating: true,
                        itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                        onRatingUpdate: (rating) {}),
                    Text(
                      '(${filmData.voteAverage / 2.0})',
                    )
                  ],
                ),
                const SizedBox(width: 12),
                Text(
                  DateFormat('dd-MM-yyyy').format(filmData.releaseDate),
                  style: AppTextStyle.regular12
                      .copyWith(color: AppColors.mainText),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInforPrice(BuildContext context) {
    return Column(
      children: [
        const Divider(
          height: 1,
          color: Colors.grey,
        ),
        const SizedBox(height: 32),
        _buildLabelTicketInfo(
          context,
          title: 'ID Order',
          value: filmData.id.toString(),
          isYourWallet: false,
        ),
        const SizedBox(height: 18),
        _buildLabelTicketInfo(
          context,
          title: 'Cinema',
          value: cinemaName.title,
          isYourWallet: false,
        ),
        const SizedBox(height: 18),
        _buildLabelTicketInfo(
          context,
          title: 'Date & Time',
          value: chooseDate.dateToDateTicket() + ', ' + chooseTime.title,
          isYourWallet: false,
        ),
        const SizedBox(height: 18),
        _buildLabelTicketInfo(
          context,
          title: 'Seat Number',
          value: listSeatSelected.title,
          isYourWallet: false,
        ),
        const SizedBox(height: 18),
        _buildLabelTicketInfo(
          context,
          title: 'Price',
          value: 'Rp 50.000 x ${listSeatSelected.length}',
          isYourWallet: false,
        ),
        const SizedBox(height: 18),
        _buildLabelTicketInfo(
          context,
          title: 'Total',
          value: 'Rp ${50000 * listSeatSelected.length}',
          isYourWallet: false,
        ),
        const SizedBox(height: 32),
        const Divider(
          height: 1,
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildLabelTicketInfo(
    BuildContext context, {
    required String title,
    required String value,
    required bool isYourWallet,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyle.regular16.copyWith(color: AppColors.mainText),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: isYourWallet
                ? AppTextStyle.semiBold16.copyWith(color: AppColors.mainColor)
                : AppTextStyle.regular16.copyWith(color: AppColors.mainText),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadImage({required String url}) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        if (stackTrace != null) return const Center(child: Icon(Icons.error));
        return const Center(child: Icon(Icons.error));
      },
    );
  }
}
