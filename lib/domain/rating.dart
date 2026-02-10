import 'package:flutter/material.dart';

enum RatingType { stars, thumbs, numeric }

class RatingConfig {
  static const stars = RatingConfig(
    type: RatingType.stars,
    min: 1,
    max: 5,
    ratingIcon: Icons.star_rounded,
  );

  static const thumbs = RatingConfig(
    type: RatingType.thumbs,
    ratingIcon: Icons.thumb_up_rounded,
  );

  static const numeric = RatingConfig(
    type: RatingType.numeric,
    min: 1,
    max: 10,
  );

  final RatingType type;

  final int? min;
  final int? max;

  final IconData? ratingIcon;

  const RatingConfig({required this.type, this.min, this.max, this.ratingIcon});

  Map<String, dynamic> toMap() => {
    'ratingType': type.name,
    'min': min,
    'max': max,
    'iconCode': ratingIcon?.codePoint,
    'iconFont': ratingIcon?.fontFamily,
    'iconPackage': ratingIcon?.fontPackage,
  };

  factory RatingConfig.fromMap(Map<String, dynamic> map) {
    return RatingConfig(
      type: RatingType.values.byName(map['ratingType']),
      min: map['min'],
      max: map['max'],
      ratingIcon: map['iconCode'] != null
          ? IconData(
              map['iconCode'],
              fontFamily: map['iconFont'],
              fontPackage: map['iconPackage'],
            )
          : null,
    );
  }
}
