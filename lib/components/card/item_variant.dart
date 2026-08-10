import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';

class ItemVariant extends StatefulWidget {
  final String item;
  final bool selected;
  final Function()? aksi;
  const ItemVariant(
      {super.key,
      required this.item,
      required this.aksi,
      this.selected = false});

  @override
  State<ItemVariant> createState() => _ItemVariantState();
}

class _ItemVariantState extends State<ItemVariant> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.aksi,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: widget.selected ? const Color(0xFF2F2828) : Colors.black,
                width: 1.2),
            borderRadius: BorderRadius.circular(5),
            color: widget.selected ? const Color(0xFF2F2828) : Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Text(
              widget.item,
              style: AppColors.fontStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: widget.selected ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
