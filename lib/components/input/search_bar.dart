import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySearchBar extends StatefulWidget {
  final Function()? aksi;
  final RxString teks;
  final BoxBorder? border;
  final Color? backgroundColor;
  final double? iconSize;
  final double? fontSize;
  final Color? fontColor;
  final Color? iconColor;

  const MySearchBar({
    super.key,
    required this.aksi,
    required this.teks,
    this.backgroundColor,
    this.border,
    this.fontSize,
    this.fontColor,
    this.iconColor,
    this.iconSize,
  });

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          // field cari peralatan
          child: InkWell(
            onTap: widget.aksi,
            child: Container(
              height: 50,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(15),
                  border: widget.border),
              child: Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.search_rounded,
                    color: widget.iconColor,
                    size: widget.iconSize,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Obx(
                      () => Text(
                        widget.teks.value,
                        style: AppColors.fontStyle(
                            fontSize: widget.fontSize,
                            fontWeight: FontWeight.w400,
                            color: widget.fontColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
