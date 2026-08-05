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
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.lebarFull ? MediaQuery.of(context).size.width : null,
      child: ElevatedButton(
          onPressed: widget.aksi,
          style: ButtonStyle(
              elevation: const WidgetStatePropertyAll(10),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              ),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
              backgroundColor: WidgetStatePropertyAll(widget.bgTombol)),
          child: Text(
            widget.title,
            style: GoogleFonts.poppins(
                fontSize: widget.ukuranTombol,
                color: widget.warnaText,
                fontWeight: FontWeight.w500),
          )),
    );
  }
}
