import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_images.dart';
import 'package:movie_ticket/common/app_text_style.dart';
import 'package:movie_ticket/common/date_contants.dart';
import 'package:movie_ticket/common/global.dart';
import 'package:movie_ticket/data/models/ticket.dart';
import 'package:movie_ticket/presentation/widgets/base_appbar/base_appbar_view.dart';
import 'package:movie_ticket/presentation/widgets/contants/contants.dart';

class TicketDetails extends StatelessWidget {
  const TicketDetails({
    Key? key,
    required this.ticket,
  }) : super(key: key);
  final Ticket ticket;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dartBackground1,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              BaseAppBarView(
                  title: 'Ticket Details',
                  onBackTap: () {
                    Navigator.of(context).pop();
                  }),
              const SizedBox(height: 40),
              _buildTicketInfo(context),
              const SizedBox(height: 58),
            ],
          ),
        ),
      ),
    );
  }
}

extension TicketDetailsScreenBasicComponents on TicketDetails {
  Widget _buildTicketInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Column(
        children: [
          _buildInforFilm(context),
          const SizedBox(height: 32),
          _buildInforPrice(context),
          const SizedBox(height: 26),
          _buildBarcode(),
          const SizedBox(height: 8),
          _buildID(id: ticket.filmData.id),
        ],
      ),
    );
  }

  Widget _buildInforFilm(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                  url: ticket.filmData.posterPath.isNotEmpty
                      ? Global.imageURL + ticket.filmData.posterPath
                      : Global.urlError),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket.filmData.originalTitle,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style:
                      AppTextStyle.medium16.copyWith(color: AppColors.mainText),
                ),
                const SizedBox(width: 12),
                Row(
                  children: [
                    RatingBar.builder(
                        initialRating: ticket.filmData.voteAverage / 2.0,
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
                      '(${ticket.filmData.voteAverage / 2.0})',
                    )
                  ],
                ),
                const SizedBox(width: 12),
                Text(
                  DateFormat('dd-MM-yyyy').format(ticket.filmData.releaseDate),
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
        _buildLabelTicketInfo(
          context,
          title: 'Cinema',
          value: ticket.cinemaName,
          isYourWallet: false,
        ),
        const SizedBox(height: 18),
        _buildLabelTicketInfo(
          context,
          title: 'Date & Time',
          value: ticket.dateTime.dateToDateTicket() + ', ' + ticket.cinemaTime,
          isYourWallet: false,
        ),
        const SizedBox(height: 18),
        _buildLabelTicketInfo(
          context,
          title: 'Seat Number',
          value: ticket.listSeat.seatToString(),
          isYourWallet: false,
        ),
        const SizedBox(height: 18),
        _buildLabelTicketInfo(
          context,
          title: 'Total',
          value: 'Rp ${ticket.total}',
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

  Widget _buildBarcode() {
    return Image.asset(
      AppImages.barcode,
      height: 200,
      width: 200,
    );
  }

  Widget _buildID({required int id}) {
    return Column(
      children: [
        Text(
          'ID Order',
          style: AppTextStyle.regular14.copyWith(
            color: Colors.white.withOpacity(0.7),
          ),
        ),
        Text(
          id.toString(),
          style: AppTextStyle.regular20,
        )
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
