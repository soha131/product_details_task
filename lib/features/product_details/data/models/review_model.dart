class Review {
  final int id;
  final String user;
  final int rating;
  final String comment;
  final String createdAt;

  Review({
    required this.id,
    required this.user,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json["id"] ?? 0,
      user: json["user"] ?? "Unknown",
      rating: json["rating"] ?? 0,
      comment: json["comment"] ?? "",
      createdAt: json["created_at"] ?? "",
    );
  }
}
