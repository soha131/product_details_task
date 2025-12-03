import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../data/models/review_model.dart';

class ReviewsTab extends StatelessWidget {
  final List<Review> reviews;

  const ReviewsTab({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.rate_review_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            const Text(
              "No reviews yet",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Be the first to review this product!",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 100), // extra bottom for floating button/bar
      itemCount: reviews.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final review = reviews[index];

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // User Avatar
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.orange.shade100,
                    child: Text(
                      review.user.isNotEmpty ? review.user[0].toUpperCase() : "U",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Name + Date
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review.user,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatDate(review.createdAt),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Stars
                  RatingBarIndicator(
                    rating: review.rating.toDouble(),
                    itemSize: 18,
                    unratedColor: Colors.grey[300],
                    itemBuilder: (_, __) => const Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFF9F00),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Review comment
              Text(
                review.comment,
                style: const TextStyle(
                  fontSize: 14.5,
                  height: 1.55,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 30) {
        return "${date.day}/${date.month}/${date.year}";
      } else if (difference.inDays >= 7) {
        return "${difference.inDays ~/ 7} week${difference.inDays ~/ 7 > 1 ? 's' : ''} ago";
      } else if (difference.inDays >= 1) {
        return "${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago";
      } else if (difference.inHours >= 1) {
        return "${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago";
      } else {
        return "Just now";
      }
    } catch (e) {
      return dateString.split('T').first;
    }
  }
}