import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/article_detail_controller.dart';
import '../widgets/article_detail_header_widget.dart';
import '../widgets/article_detail_title_widget.dart';
import '../widgets/article_detail_content_widget.dart';
import '../../../common/themes/colors.dart';
import '../../../common/widgets/loading_widget.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArticleDetailController>(
      init: ArticleDetailController(),
      builder: (ctrl) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
              ),
            ),
          ),
          body: Obx(() {
            if (ctrl.isLoading.value || ctrl.article.value == null) {
              return const LoadingWidget(message: 'Memuat artikel...');
            }

            final article = ctrl.article.value!;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with Image and Back Button
                  ArticleDetailHeaderWidget(
                    imageUrl: article.imageUrl,
                    onBackTap: () => Get.back(),
                  ),

                  const SizedBox(height: 16),

                  // Title and Date
                  ArticleDetailTitleWidget(
                    title: article.title,
                    date: article.date,
                  ),

                  const SizedBox(height: 16),

                  // Content
                  ArticleDetailContentWidget(
                    content: article.content,
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
