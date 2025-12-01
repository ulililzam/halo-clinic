import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/support_controller.dart';
import '../widgets/support_header_widget.dart';
import '../widgets/menu_card_widget.dart';
import '../widgets/article_preview_card_widget.dart';
import '../../../common/themes/colors.dart';

class SupportListScreen extends StatelessWidget {
  const SupportListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupportController>(
      init: SupportController(),
      builder: (ctrl) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: Column(
            children: [
              // Header with search
              SupportHeaderWidget(
                onSearch: ctrl.onSearch,
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Menu Grid
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.1,
                        children: [
                          MenuCardWidget(
                            icon: Icons.article_outlined,
                            title: 'Artikel',
                            subtitle: 'Kesehatan',
                            onTap: () => ctrl.onMenuTap('Artikel Kesehatan'),
                          ),
                          MenuCardWidget(
                            icon: Icons.calculate_outlined,
                            title: 'Kalkulator',
                            subtitle: 'BMI',
                            onTap: () => ctrl.onMenuTap('Kalkulator BMI'),
                          ),
                          MenuCardWidget(
                            icon: Icons.mood_outlined,
                            title: 'Tes',
                            subtitle: 'Stres',
                            onTap: () => Get.toNamed('/stress-test'),
                          ),
                          MenuCardWidget(
                            icon: Icons.sentiment_dissatisfied_outlined,
                            title: 'Tes',
                            subtitle: 'Depresi',
                            onTap: () => ctrl.onMenuTap('Tes Depresi'),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Terbaru Section
                      const Text(
                        'Terbaru',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Articles Preview List
                      Obx(() {
                        if (ctrl.articles.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        return Column(
                          children: ctrl.articles.map((article) {
                            return ArticlePreviewCardWidget(
                              imageUrl: article.imageUrl,
                              title: article.title,
                              description: article.description,
                              onTap: () => ctrl.onArticlePreviewTap(article),
                            );
                          }).toList(),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
