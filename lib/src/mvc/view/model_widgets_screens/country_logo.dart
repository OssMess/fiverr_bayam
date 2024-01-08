import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryLogo extends StatelessWidget {
  const CountryLogo({
    super.key,
    required this.countryCode,
  });

  final String countryCode;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Transform.scale(
        scale: 1.4,
        child: CountryFlag.fromCountryCode(
          countryCode,
          height: 40.sp,
          width: 40.sp,
        ),
      ),
    );
  }
}
