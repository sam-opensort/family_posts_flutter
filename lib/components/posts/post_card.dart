import 'package:family_posts/components/author_info_header.dart';
import 'package:family_posts/components/comments/comment_bottom_sheet.dart';
import 'package:family_posts/components/posts/post_types/image_post.dart';
import 'package:flutter/material.dart';

import 'post_types/text_post_content.dart';


class PostCard extends StatelessWidget {
  final Map<String, dynamic> post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthorInfoHeader(authorInfo: {...post['author'], 'epoch': post['epoch']}),
            const SizedBox(height: 10),
            //render the text post content
            if (post['post_content']['type'] == 'text' && post['status'] != 'archived')
              TextPostContent(content: post['post_content']['content']),

            if(post['post_content']['type'] == 'image' && post['status'] != 'archived')
              ImagePost(postContent: post['post_content']),

            const SizedBox(height: 10),
            _buildLikeCommentSection(context),
            if (post['latest_comment'] != null) ...[
              const SizedBox(height: 10),
              Text(
                'Latest comment: ${post['latest_comment']['content']}',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLikeCommentSection(BuildContext context) {
  return Row(
    children: [
      _buildActionButton(
        icon: post['is_liked'] ? Icons.favorite : Icons.favorite_border,
        color: post['is_liked'] ? Colors.red : Colors.grey[600]!,
        count: post['like_count'],
      ),
      const SizedBox(width: 10),
      GestureDetector(
        onTap: () {
          // Open the bottom sheet when comment button is tapped
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true, // For full-screen bottom sheet
            builder: (context) => CommentBottomSheet(),
          );
        },
        child: _buildActionButton(
          icon: Icons.comment_outlined,
          color: Colors.grey[600]!,
          count: post['comment_count'],
        ),
      ),
    ],
  );
}


  Widget _buildActionButton({required IconData icon, required Color color, required int count}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 5),
          Text(
            '$count',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

}