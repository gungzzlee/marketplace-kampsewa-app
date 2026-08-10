import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';

class InputVersiSatu extends StatefulWidget {
  final TextInputType tipeInput;
  final String placeHolder;
  final double ukuranFontPlaceHolder;
  final double ketebalanBorder;
  final Color warnaBgInput;
  final Icon iconInput;
  final bool border;
  final bool passwordTipe;
  final bool showEyes;
  final TextEditingController controller;
  const InputVersiSatu(
      {super.key,
      required this.tipeInput,
      required this.controller,
      this.placeHolder = "Masukkan Tipe",
      this.warnaBgInput = Colors.white,
      this.ketebalanBorder = 1,
      this.border = false,
      this.showEyes = false,
      this.passwordTipe = false,
      this.iconInput = const Icon(Icons.email_outlined),
      this.ukuranFontPlaceHolder = 14});

  @override
  State<InputVersiSatu> createState() => _InputVersiSatuState();
}

class _InputVersiSatuState extends State<InputVersiSatu> {
  bool _obscureText = true;
  bool _isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: widget.warnaBgInput,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _isFocused
              ? const Color(0xFF2F2828)
              : widget.border
                  ? Colors.black
                  : Colors.transparent,
          width:
              _isFocused ? 1.5 : (widget.border ? widget.ketebalanBorder : 0),
        ),
        boxShadow: [
          BoxShadow(
            color: _isFocused
                ? const Color(0x18010935)
                : Colors.black.withValues(alpha: 0.04),
            blurRadius: _isFocused ? 12 : 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        focusNode: _focusNode,
        obscureText: widget.passwordTipe ? _obscureText : false,
        keyboardType: widget.tipeInput,
        controller: widget.controller,
        style: AppColors.fontStyle(
          fontSize: 16.5,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: widget.placeHolder,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          hintStyle: AppColors.fontStyle(
            color: Colors.grey.shade400,
            fontSize: widget.ukuranFontPlaceHolder,
          ),
          suffixIcon: widget.showEyes
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText =
                          !_obscureText; // Ubah status teks tersembunyi
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: _isFocused
                        ? const Color(0xFF2F2828)
                        : Colors.grey.shade400,
                    size: 20,
                  ),
                )
              : null,
          prefixIcon: IconTheme(
            data: IconThemeData(
              color:
                  _isFocused ? const Color(0xFF2F2828) : Colors.grey.shade400,
              size: 22,
            ),
            child: widget.iconInput,
          ),
        ),
      ),
    );
  }
}
