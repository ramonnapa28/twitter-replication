import 'dart:convert';

class Post {
  final String author;
  final String time;
  final String title;
  final String content;
  final List<Comment> comments;
  int likes; // Changed from final to a mutable field

  Post({
    required this.author,
    required this.time,
    required this.title,
    required this.content,
    required this.comments,
    this.likes = 0, // Set default value to 0 if not provided
  });

  // Method to increment likes
  void incrementLikes() {
    likes++;
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      author: json['author'] ?? '',
      time: json['time'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      comments: (json['comments'] as List<dynamic>?)
              ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      likes: json['likes'] ?? 0, // Initialize with the value from JSON or 0
    );
  }
}

class Comment {
  final String commenter;
  final String comment;

  Comment({
    required this.commenter,
    required this.comment,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commenter: json['commenter'] ?? '',
      comment: json['comment'] ?? '',
    );
  }
}
