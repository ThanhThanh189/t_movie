import 'package:flutter/material.dart';
import 'package:movie_ticket/common/app_strings.dart';
import 'package:movie_ticket/common/app_text_style.dart';

class DialogConfirm extends StatelessWidget {
  const DialogConfirm({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final Function(bool val) onTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: MediaQuery.of(context).size.height * 0.2,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Text(
                  title,
                  style: AppTextStyle.semiBold18.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red),
                    child: TextButton(
                      onPressed: () {
                        onTap(false);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppStrings.dialogCancel,
                        style: AppTextStyle.semiBold16
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue),
                    child: TextButton(
                      onPressed: () {
                        onTap(true);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppStrings.dialogOK,
                        style: AppTextStyle.semiBold16
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
