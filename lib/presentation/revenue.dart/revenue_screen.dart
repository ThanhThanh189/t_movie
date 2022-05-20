import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/revenue/revenue_bloc.dart';
import 'package:movie_ticket/blocs/revenue/revenue_event.dart';
import 'package:movie_ticket/blocs/revenue/revenue_state.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_text_style.dart';
import 'package:movie_ticket/common/date_contants.dart';
import 'package:movie_ticket/presentation/my_ticket/ticket_details.dart';
import 'package:movie_ticket/presentation/new_user/signin_screen.dart';
import 'package:movie_ticket/presentation/widgets/card/ticket_card_view.dart';
import 'package:movie_ticket/presentation/widgets/contants/contants.dart';
import 'package:movie_ticket/presentation/widgets/input_text_field/date_text_field.dart';

class RevenueScreen extends StatelessWidget {
  const RevenueScreen({Key? key}) : super(key: key);

  List<DropdownMenuItem<String>> get _menuItemsCinemaTime {
    List<DropdownMenuItem<String>> menuItemsCinemaTime = CinemaTimeBox.values
        .map((e) => DropdownMenuItem(
              child: Text(e.title),
              value: e.title,
            ))
        .toList();
    return menuItemsCinemaTime;
  }

  List<DropdownMenuItem<String>> get _menuItemsCinemaName {
    List<DropdownMenuItem<String>> menuItemsCinemaName = CinemaNameBox.values
        .map((e) => DropdownMenuItem(
              child: Text(e.title),
              value: e.title,
            ))
        .toList();
    return menuItemsCinemaName;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RevenueBloc>(
      create: (context) => RevenueBloc()..add(StartedRevenueEvent()),
      child: BlocConsumer<RevenueBloc, RevenueState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.dartBackground1,
            appBar: AppBar(
              title: const Text(
                'Revenue',
                style: AppTextStyle.semiBold24,
              ),
              backgroundColor: AppColors.dartBackground1,
              centerTitle: true,
              automaticallyImplyLeading: true,
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) {
                          return SignInScreen();
                        },
                      ),
                    );
                  },
                  child: const Icon(Icons.logout),
                ),
                const SizedBox(
                  width: 15,
                )
              ],
            ),
            body: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                _buildTotalMoney(context, state: state),
                const SizedBox(
                  height: 10,
                ),
                _buildLabel(context, state: state),
                const SizedBox(
                  height: 10,
                ),
                _buildStartAndEndDate(context, state: state),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cinema time',
                              style: AppTextStyle.regular12
                                  .copyWith(color: AppColors.mainText),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.mainText, width: 0.5),
                                  borderRadius: BorderRadius.circular(4)),
                              child: DropdownButton(
                                value: state.valueCinemaTime.title,
                                items: _menuItemsCinemaTime,
                                isExpanded: true,
                                isDense: true,
                                style: AppTextStyle.regular14.copyWith(
                                  color: AppColors.mainText,
                                ),
                                underline: Container(),
                                onChanged: (value) {
                                  final result = CinemaTimeBox.values
                                      .firstWhere(
                                          (element) => element.title == value);
                                  BlocProvider.of<RevenueBloc>(context).add(
                                      SetCinemaTimeRevenueEvent(
                                          cinemaTimeBox: result));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cinema name',
                              style: AppTextStyle.regular12
                                  .copyWith(color: AppColors.mainText),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.mainText, width: 0.5),
                                  borderRadius: BorderRadius.circular(4)),
                              child: DropdownButton(
                                value: state.valueCinemaName.title,
                                items: _menuItemsCinemaName,
                                isExpanded: true,
                                isDense: true,
                                style: AppTextStyle.regular14.copyWith(
                                  color: AppColors.mainText,
                                ),
                                underline: Container(),
                                onChanged: (value) {
                                  final result = CinemaNameBox.values
                                      .firstWhere(
                                          (element) => element.title == value);
                                  BlocProvider.of<RevenueBloc>(context).add(
                                      SetCinemaNameRevenueEvent(
                                          cinemaNameBox: result));
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(
                  height: 1,
                  color: AppColors.greyBackground2,
                ),
                _buildListTicket(context, state: state),
              ],
            ),
          );
        },
      ),
    );
  }
}

extension RevenueScreenComponents on RevenueScreen {
  Widget _buildTotalMoney(
    BuildContext context, {
    required RevenueState state,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'đ${state.total}',
          style: AppTextStyle.semiBold34.copyWith(color: AppColors.mainColor),
        ),
      ],
    );
  }

  Widget _buildLabel(
    BuildContext context, {
    required RevenueState state,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Amount has been paid (${state.startDay.dateToString2()} - ${state.endDay.dateToString2()})',
              style: AppTextStyle.regular12.copyWith(color: AppColors.mainText),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total number of tickets: ${state.listTicketNew.length}',
              style: AppTextStyle.regular12.copyWith(color: AppColors.mainText),
              overflow: TextOverflow.ellipsis,
            )
          ],
        )
      ],
    );
  }

  Widget _buildStartAndEndDate(
    BuildContext context, {
    required RevenueState state,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: DateTextField(
              text: state.startDay.dateToString(),
              initialDate: state.startDay,
              onChange: (value) {
                BlocProvider.of<RevenueBloc>(context)
                    .add(SetStartDayRevenueEvent(startDay: value));
              },
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: DateTextField(
              text: state.endDay.dateToString(),
              initialDate: state.endDay,
              onChange: (value) {
                BlocProvider.of<RevenueBloc>(context)
                    .add(SetEndDayRevenueEvent(endDay: value));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTicket(
    BuildContext context, {
    required RevenueState state,
  }) {
    return Expanded(
      child: state.listTicketNew.isNotEmpty
          ? SingleChildScrollView(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.listTicketNew.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TicketDetails(
                            ticket: state.listTicketNew[index],
                          ),
                        ),
                      );
                    },
                    child: TicketCardView(
                        filmData: state.listTicketNew[index].filmData,
                        time: state.listTicketNew[index].cinemaTime,
                        date: state.listTicketNew[index].dateTime,
                        cinemaName: state.listTicketNew[index].cinemaName,
                        listSeat: state.listTicketNew[index].listSeat),
                  );
                },
              ),
            )
          : const Center(
              child: Text(
                'No transaction history',
                style: AppTextStyle.medium14,
              ),
            ),
    );
  }
}
