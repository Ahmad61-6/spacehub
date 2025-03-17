import 'package:flutter/material.dart';

import '../../utility/app_colors.dart';

class OtherLoginOption extends StatelessWidget {
  final String imagePath;
  const OtherLoginOption({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      width: 92,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.otherLoginOptBackgroundColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(imagePath),
    );
  }
}
