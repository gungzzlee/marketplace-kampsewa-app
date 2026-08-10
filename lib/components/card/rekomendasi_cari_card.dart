import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:project_camp_sewa/constants/api_endpoint.dart';

class RekomendasiCariCard extends StatefulWidget {
  final String image;
  final String namaProduk;
  final String rating;
  final Function() aksi;
  const RekomendasiCariCard(
      {super.key,
      required this.image,
      required this.namaProduk,
      required this.rating,
      required this.aksi});

  @override
  State<RekomendasiCariCard> createState() => _RekomendasiCariCardState();
}

class _RekomendasiCariCardState extends State<RekomendasiCariCard> {
  String formatRating(String numberString) {
    final number = double.parse(numberString);
    return number.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: widget.aksi,
        child: Container(
          width: 180,
          height: 235,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: const Color(0xFF646363).withValues(alpha: 0.3),
                    offset: const Offset(3.0, 3.0),
                    blurRadius: 5.0)
              ]),
          child: Column(
            children: [
              Container(
                width: 175,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(ApiEndpoints.baseUrl +
                            ApiEndpoints.authendpoints.getImageProduk +
                            widget.image))),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 160,
                          height: 37,
                          child: Text(
                            widget.namaProduk,
                            style: AppColors.fontStyle(
                                fontSize: 11, fontWeight: FontWeight.w600),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rate_rounded,
                              size: 15,
                              color: Color(0xFFED6723),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              formatRating(widget.rating),
                              style: AppColors.fontStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFED6723),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
