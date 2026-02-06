import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    super.key,
    required this.rateTipo,
    required this.rateValue,
    this.rateIcon,
  });

  final String rateTipo;
  final IconData? rateIcon;
  final double rateValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: switch (rateTipo) {
        'thumbs' => [
          Icon(
            rateValue > 0 ? Icons.thumb_up_rounded : Icons.thumb_down_rounded,
            color: rateValue > 0 ? Colors.green : Colors.red,
          ),
        ],
        'stars' => List.generate(
          5,
          (index) => Icon(rateIcon ?? Icons.star_rounded, color: index < rateValue ? Colors.amber : Colors.grey),
        ),
        'number' => [
          Text(
            '$rateValue/10',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
        _ => [],
      },
    );
  }
}
