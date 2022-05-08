import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/my_wallet/my_wallet_bloc.dart';
import 'package:movie_ticket/blocs/my_wallet/my_wallet_event.dart';
import 'package:movie_ticket/blocs/my_wallet/my_wallet_state.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_strings.dart';
import 'package:movie_ticket/common/app_text_style.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/presentation/widgets/base_button/base_button.dart';
import 'package:movie_ticket/presentation/widgets/base_button/option_top_up.dart';
import 'package:movie_ticket/presentation/widgets/card/wallet_card.dart';
import 'package:movie_ticket/presentation/widgets/contants/contants.dart';
import 'package:movie_ticket/presentation/widgets/dialog/dialog_confirm.dart';
import 'package:movie_ticket/presentation/widgets/input_text_field/input_text_field.dart';
import 'package:movie_ticket/presentation/widgets/snack_bar/custom_snack_bar.dart';

class MyWalletScreen extends StatelessWidget {
  MyWalletScreen({Key? key}) : super(key: key);
  final TextEditingController _ammountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyWalletBloc>(
      create: (context) => MyWalletBloc()..add(StartedMyWalletEvent()),
      child: BlocConsumer<MyWalletBloc, MyWalletState>(
        listener: (context, state) {
          if (state.viewState == ViewState.isLoading && state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar(
                message: state.message.toString(),
                milliseconds: 1000,
              ),
            );
          }
          if (state.viewState == ViewState.isFailure && state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar(
                message: state.message.toString(),
                milliseconds: 1000,
                isSuccess: false,
              ),
            );
          }
          if (state.viewState == ViewState.isSuccess && state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar(
                message: state.message.toString(),
                milliseconds: 1000,
                isSuccess: true,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.dartBackground1,
            appBar: AppBar(
              title: Text(
                AppStrings.myWallet,
                style: AppTextStyle.semiBold24,
              ),
              backgroundColor: AppColors.dartBackground1,
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      WalletCard(
                          userName: state.account?.displayName ?? '',
                          iDCard: state.account?.id ?? '',
                          money: state.account?.wallet ?? 0,
                          isDark: false),
                      const SizedBox(
                        height: 28,
                      ),
                      Text(
                        AppStrings.topUp,
                        style: AppTextStyle.medium18,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      InputTextField(
                        controller: _ammountController,
                        textInputType: TextInputType.number,
                        readOnly: state.topUpOption != null,
                        maxLength: 10,
                        onChange: (value) {
                          if (value.isEmpty) {
                            FocusScope.of(context).unfocus();
                          }
                          BlocProvider.of<MyWalletBloc>(context).add(
                            InputMoneyMyWalletEvent(
                                moneyKeyboard: int.parse(value)),
                          );
                        },
                        hintText: AppStrings.ammount,
                        hintStyle: AppTextStyle.regular14.copyWith(
                          color: AppColors.mainText.withOpacity(0.7),
                        ),
                        isPassword: false,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:
                                MediaQuery.of(context).size.width * 0.5,
                            childAspectRatio: 154 / 60,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10.0),
                        itemCount: TopUpOption.values.length,
                        itemBuilder: (context, index) {
                          return OptionTopUp(
                            number: TopUpOption.values[index].topUpToString,
                            isActive: state.topUpOption != null
                                ? TopUpOption.values[index] == state.topUpOption
                                : false,
                            onTap: () {
                              _ammountController.clear();
                              BlocProvider.of<MyWalletBloc>(context).add(
                                SelectOptionMyWalletEvent(
                                    topUpOption: TopUpOption.values[index]),
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      BaseButton(
                        text: AppStrings.topUpNow,
                        isVisible: _ammountController.text.isNotEmpty ||
                            state.topUpOption != null,
                        onPressed: () {
                          if (_ammountController.text.isNotEmpty) {
                            showDialog(
                              context: context,
                              builder: (_) => DialogConfirm(
                                title: int.parse(_ammountController.text) < 1000
                                    ? 'Amount must be greater than 1000'
                                    : 'Do you want to top up: \nIDR ${_ammountController.text}?',
                                isNotification:
                                    int.parse(_ammountController.text) < 1000,
                                onTap: (value) {
                                  if (value &&
                                      int.parse(_ammountController.text) >=
                                          1000) {
                                    FocusScope.of(context).unfocus();
                                    BlocProvider.of<MyWalletBloc>(context).add(
                                      TopUpMyWalletEvent(
                                        money: state.topUpOption?.topUpToInt ??
                                            int.parse(_ammountController.text),
                                      ),
                                    );
                                    BlocProvider.of<MyWalletBloc>(context)
                                        .add(StartedMyWalletEvent());
                                    _ammountController.clear();
                                  } else {}
                                },
                              ),
                            );
                          }
                          if (state.topUpOption?.topUpToInt != null) {
                            showDialog(
                              context: context,
                              builder: (_) => DialogConfirm(
                                title:
                                    'Do you want to top up: \nIDR ${state.topUpOption?.topUpToInt}?',
                                isNotification: false,
                                onTap: (value) {
                                  if (value) {
                                    FocusScope.of(context).unfocus();
                                    BlocProvider.of<MyWalletBloc>(context).add(
                                      TopUpMyWalletEvent(
                                        money:
                                            state.topUpOption?.topUpToInt ?? 0,
                                      ),
                                    );
                                    BlocProvider.of<MyWalletBloc>(context)
                                        .add(StartedMyWalletEvent());
                                    _ammountController.clear();
                                  }
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
