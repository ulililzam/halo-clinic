import 'package:flutter/material.dart';
import '../../../common/themes/colors.dart';

class ArticleDetailContentWidget extends StatelessWidget {
  final String content;

  const ArticleDetailContentWidget({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Text(
        content,
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.textSecondary,
          height: 1.8,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
