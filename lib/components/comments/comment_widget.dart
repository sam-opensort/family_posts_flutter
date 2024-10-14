import 'package:family_posts/components/author_info_header.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final Map<String, dynamic> comment;
  final bool isExpanded;
  final Function(String) onReply;
  final Function(String) viewReplies;
  final VoidCallback onLike;

  const CommentWidget({
    Key? key,
    required this.comment,
    required this.onReply,
    required this.viewReplies,
    required this.onLike,
    this.isExpanded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthorInfoHeader(authorInfo: {
          ...comment['author'],
          'epoch': comment['epoch'],
        }),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 25.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(comment['content']),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            const SizedBox(width: 25),
            GestureDetector(
              onTap: onLike,
              child: Icon(
                size: 20,
                comment['is_liked'] ? Icons.favorite : Icons.favorite_border,
                color: comment['is_liked'] ? Colors.red : Colors.grey[600],
              ),
            ),
            const SizedBox(width: 5),
            Text(
              "${comment['like_count']}",
              style: TextStyle(color: Colors.grey[800]),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () => onReply(comment['author']['name']),
              child: const Text(
                "Reply",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        if (comment['reply_count'] > 0)
          Container(
            margin: const EdgeInsets.only(left: 25.0, bottom: 10),
            child: GestureDetector(
              onTap: () => viewReplies(comment['comment_id']),
              child: Text(
                isExpanded
                    ? "Hide replies"
                    : "View all ${comment['reply_count']} replies",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          )
      ],
    );
  }
}
