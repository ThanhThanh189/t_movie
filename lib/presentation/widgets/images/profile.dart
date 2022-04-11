import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_icons.dart';
import 'package:movie_ticket/common/app_images.dart';

class Profile extends StatelessWidget {
  final String? image;
  final double sizeAvatar;
  final bool isEdit;
  final VoidCallback? onTap;
  const Profile(
      {Key? key,
      this.image,
      required this.sizeAvatar,
      required this.isEdit,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: isEdit ? const EdgeInsets.only(bottom: 15.0) : null,
          child: GestureDetector(
            onTap: onTap,
            child: CircleAvatar(
              radius: sizeAvatar / 2 + 1,
              backgroundColor: AppColors.whiteBackground,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000.0),
                child: image == null
                    ? Image.asset(
                        AppImages.imgPhotoProfile,
                        width: sizeAvatar,
                        height: sizeAvatar,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          if (stackTrace != null) {
                            return const Center(
                              child: Icon(Icons.error),
                            );
                          }
                          return const Center(child: Icon(Icons.error));
                        },
                      )
                    : Image.file(
                        File(image!),
                        width: sizeAvatar,
                        height: sizeAvatar,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          if (stackTrace != null) {
                            return const Center(
                              child: Icon(Icons.error),
                            );
                          }
                          return const Center(
                            child: Icon(Icons.error),
                          );
                        },
                      ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: isEdit,
          child: Positioned(
              bottom: 0.0,
              right: 31.0,
              child: GestureDetector(
                onTap: onTap,
                child: Image.asset(
                  image != null ? AppIcons.iconCancel : AppIcons.iconAdd,
                  width: 28.0,
                  height: 28.0,
                ),
              )),
        )
      ],
    );
  }
}
