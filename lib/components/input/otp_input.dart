import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpInput extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final FocusNode? previousFocusNode;
  const OtpInput(
      {super.key,
      required this.controller,
      required this.focusNode,
      this.nextFocusNode,
      this.previousFocusNode});

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: TextField(
          keyboardType: TextInputType.number,
          controller: widget.controller,
          textAlign: TextAlign.center,
          maxLength: 1,
          focusNode: widget.focusNode,
          style: AppColors.fontStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
          decoration:
              const InputDecoration(counterText: '', border: InputBorder.none),
          onChanged: (value) {
            if (value.length == 1) {
              widget.focusNode.unfocus();
              if (widget.nextFocusNode != null) {
                FocusScope.of(context).requestFocus(widget.nextFocusNode);
              }
            } else if (value.isEmpty && widget.previousFocusNode != null) {
              widget.previousFocusNode!.requestFocus();
            }
          },
        ),
      ),
    );
  }
}
