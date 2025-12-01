import 'package:flutter/material.dart';
import '../../../common/themes/colors.dart';

class Review {
  final String userName;
  final String userAvatar;
  final double rating;
  final String comment;
  final String date;

  Review({
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.comment,
    required this.date,
  });
}

class MedicineReviewsWidget extends StatelessWidget {
  final VoidCallback onSeeAllReviews;

  const MedicineReviewsWidget({
    super.key,
    required this.onSeeAllReviews,
  });

  // Sample review data
  List<Review> get reviews => [
        Review(
          userName: 'Aisyah Maharani',
          userAvatar: 'https://i.pravatar.cc/150?img=1',
          rating: 5.0,
          comment: 'Membantu jaga daya tahan tubuh!\n\nSejak rutin konsumsi Prove D3-1000, saya merasa lebih fit dan tidak mudah lelah. Tablet mudah ditelan dan cocok untuk dikonsumsi setiap hari!',
          date: 'April 5, 2025',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ulasan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),

          // Review List
          ...reviews.map((review) => _buildReviewItem(review)),

          const SizedBox(height: 12),

          // See All Reviews Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onSeeAllReviews,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.primary, width: 1.5),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Lihat semua ulasan',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(Review review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info Row
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(review.userAvatar),
                backgroundColor: Colors.grey[300],
              ),
              const SizedBox(width: 12),

              // Name and Rating
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Star Rating
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < review.rating ? Icons.star : Icons.star_border,
                          size: 16,
                          color: const Color(0xFFFFC107),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Review Title (Bold first line)
          Text(
            review.comment.split('\n').first,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 6),

          // Review Comment (Rest of text)
          Text(
            review.comment.split('\n').skip(1).join('\n').trim(),
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 8),

          // Date
          Text(
            review.date,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}
