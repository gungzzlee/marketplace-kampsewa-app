import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class ButtonSwipeRight extends StatefulWidget {
  final String title;
  final Function()? fungsi;
  final Color titleColor;
  final Color roundedBgColor;
  final Color bgColor;
  final Color iconColor;
  const ButtonSwipeRight(
      {super.key,
      this.title = "Test Tombol",
      required this.fungsi,
      this.bgColor = Colors.transparent,
      this.iconColor = Colors.black,
      this.titleColor = Colors.white,
      this.roundedBgColor = Colors.white});

  @override
  State<ButtonSwipeRight> createState() => _ButtonSwipeRightState();
}

class _ButtonSwipeRightState extends State<ButtonSwipeRight> {
  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return SwipeableButtonView(
      buttonText: widget.title,
      buttontextstyle: AppColors.fontStyle(color: widget.titleColor, fontSize: 17, fontWeight: FontWeight.w600),
      buttonWidget: Icon(
        Icons.arrow_forward_ios_rounded,
        color: widget.iconColor,
        size: 20,
      ),
      buttonColor: widget.roundedBgColor,
      activeColor: widget.bgColor,
      onWaitingProcess: () {
        Future.delayed(const Duration(seconds: 1),
            () => setState(() => isFinished = true));
      },
      isFinished: isFinished,
      onFinish: () async {
        //ini buat parameter fungsi keseluruhan swipe button
        if (widget.fungsi != null) {
          await widget.fungsi!();
        }
        
        // - - - Reset isFinished variable  - - -
        if (mounted) {
          setState(() => isFinished = false);
        }
      },
    );
  }
}
