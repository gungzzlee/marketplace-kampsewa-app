import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonVersiSatu extends StatefulWidget {
  final String title;
  final Color bgTombol;
  final double ukuranTombol;
  final Color warnaText;
  final bool lebarFull;
  final Function()? aksi;
  const ButtonVersiSatu(
      {super.key,
      this.title = "Test Tombol",
      this.aksi,
      this.bgTombol = Colors.blue,
      this.warnaText = Colors.white,
      this.lebarFull = false,
      this.ukuranTombol = 14.0});

  @override
  State<ButtonVersiSatu> createState() => _ButtonVersiSatuState();
}

class _ButtonVersiSatuState extends State<ButtonVersiSatu> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.aksi,
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: widget.lebarFull ? MediaQuery.of(context).size.width : null,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                widget.bgTombol,
                Color.lerp(widget.bgTombol, Colors.white, 0.18) ??
                    widget.bgTombol,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: widget.bgTombol.withValues(alpha: _isPressed ? 0.2 : 0.4),
                blurRadius: _isPressed ? 6 : 16,
                offset: Offset(0, _isPressed ? 2 : 6),
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.title,
              style: AppColors.fontStyle(fontSize: widget.ukuranTombol + 1,
                color: widget.warnaText,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
