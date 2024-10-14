import 'package:family_posts/components/comments/comment_input_widget.dart';
import 'package:family_posts/components/comments/comment_widget.dart';
import 'package:flutter/material.dart';

class CommentBottomSheet extends StatefulWidget {
  const CommentBottomSheet({Key? key}) : super(key: key);

  @override
  _CommentBottomSheetState createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  String? replyingTo;
  String? commentId;
  final TextEditingController _commentController = TextEditingController();
  Map<String, bool> expandedReplies = {};

  void toggleReplies(String commentId) {
    setState(() {
      expandedReplies[commentId] = !(expandedReplies[commentId] ?? false);
    });
  }

  Widget buildCommentTree(Map<String, dynamic> comment, int depth) {
    bool isExpanded = expandedReplies[comment['comment_id']] ?? false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommentWidget(
          comment: comment,
          onReply: (String authorName) {
            setState(() {
              replyingTo = authorName;
              commentId = comment['comment_id'];
            });
          },
          viewReplies: (String commentId) => toggleReplies(commentId),
          onLike: () {
            // Handle like action
          },
          isExpanded: isExpanded,
        ),
        if (isExpanded)
          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (comment['replies'] as List<dynamic>? ?? [])
                  .map((reply) => Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: buildCommentTree(reply, depth + 1),
                      ))
                  .toList(),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      minChildSize: 0.8,
      maxChildSize: 0.95,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Comments',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16.0),
                  controller: scrollController,
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    return buildCommentTree(comments[index], 0);
                  },
                ),
              ),
              CommentInputWidget(
                replyingTo: replyingTo,
                commentId: commentId,
                onSendComment: (String text, String? replyCommentId) {
                  print('Send comment: $text, Replying to: $replyCommentId');
                  setState(() {
                    replyingTo = null;
                    commentId = null;
                  });
                },
                onCancelReply: () {
                  setState(() {
                    replyingTo = null;
                    commentId = null;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// Sample comment data
final List<Map<String, dynamic>> comments = [
  {
    'comment_id': "1",
    'content': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nunc vel tincidunt lacinia, nisl nisl aliquam nisl, eget aliquam nisl nisl sit amet nunc.',
    'epoch': 1728283061243,
    'author': {
      'avatar': 'https://github.com/shadcn.png',
      'name': 'User 1',
    },
    "like_count": 5,
    "is_liked": true,
    "reply_count": 5,
    "is_edited": true,
    "replies": [
      {
        'comment_id': "1-1",
        'content': 'This is reply 1',
        'epoch': 1728283061243,
        'author': {
          'avatar': 'https://github.com/shadcn.png',
          'name': 'User 1',
        },
        "like_count": 0,
        "is_liked": false,
        "reply_count": 3,
        "is_edited": false,
        "replies": [
          {
            'comment_id': "1-1-1",
            'content': 'This is reply 1',
            'epoch': 1728283061243,
            'author': {
              'avatar': 'https://github.com/shadcn.png',
              'name': 'User 1',
            },
            "like_count": 0,
            "is_liked": false,
            "reply_count": 0,
            "is_edited": false,
          },
          {
            'comment_id': "1-1-2",
            'content': 'This is reply 2',
            'epoch': 1728283061243,
            'author': {
              'avatar': 'https://github.com/shadcn.png',
              'name': 'User 1',
            },
            "like_count": 0,
            "is_liked": false,
            "reply_count": 0,
            "is_edited": false,
          }
        ]
      },
      {
        'comment_id': "1-2",
        'content': 'This is reply 2',
        'epoch': 1728283061243,
        'author': {
          'avatar': 'https://github.com/shadcn.png',
          'name': 'User 1',
        },
        "like_count": 0,
        "is_liked": false,
        "reply_count": 0,
        "is_edited": false,
      },
    ],
  },
  {
    'comment_id': "2",
    'content': 'This is comment 2',
    'epoch': 1728283061243,
    'author': {
      'avatar': 'https://github.com/shfadcn.png',
      'name': 'User 2',
    },
    "like_count": 0,
    "is_liked": false,
    "reply_count": 0,
    "is_edited": false,
    "replies": []
  },
  {
    'comment_id': "3",
    'content': 'This is comment 2',
    'epoch': 1728283061243,
    'author': {
      'avatar': 'https://github.com/shfadcn.png',
      'name': 'User 2',
    },
    "like_count": 0,
    "is_liked": false,
    "reply_count": 4,
    "is_edited": false,
    "replies": [
      {
        'comment_id': "3-1",
        'content': 'This is reply 1',
        'epoch': 1728283061243,
        'author': {
          'avatar': 'https://github.com/shfadcn.png',
          'name': 'User 2',
        },
        "like_count": 0,
        "is_liked": false,
        "reply_count": 0,
        "is_edited": false,
      },
      {
        'comment_id': "3-2",
        'content': 'This is reply 2',
        'epoch': 1728283061243,
        'author': {
          'avatar': 'https://github.com/shfadcn.png',
          'name': 'User 2',
        },
        "like_count": 0,
        "is_liked": false,
        "reply_count": 0,
        "is_edited": false,
      },
    ]
  },
  {
    'comment_id': "4",
    'content': 'This is comment 2',
    'epoch': 1728283061243,
    'author': {
      'avatar': 'https://github.com/shfadcn.png',
      'name': 'User 2',
    },
    "like_count": 0,
    "is_liked": false,
    "reply_count": 6,
    "is_edited": false,
    "replies": [
      {
        'comment_id': "4-1",
        'content': 'This is reply 1',
        'epoch': 1728283061243,
        'author': {
          'avatar': 'https://github.com/shfadcn.png',
          'name': 'User 2',
        },
        "like_count": 0,
        "is_liked": false,
        "reply_count": 0,
        "is_edited": false,
      },
      {
        'comment_id': "4-2",
        'content': 'This is reply 2',
        'epoch': 1728283061243,
        'author': {
          'avatar': 'https://github.com/shfadcn.png',
          'name': 'User 2',
        },
        "like_count": 0,
        "is_liked": false,
        "reply_count": 0,
        "is_edited": false, 
      },
    ]
  },
  {
    'comment_id':"5",
    'content': 'This is comment 2',
    'epoch': 1728283061243,
    'author': {
      'avatar': 'https://github.com/shfadcn.png',
      'name': 'User 2',
    },
    "like_count": 0,
    "is_liked": false,
    "reply_count": 0,
    "is_edited": false,
  },
];
