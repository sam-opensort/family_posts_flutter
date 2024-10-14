import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'user_avatar.dart';

class AuthorInfoHeader extends StatelessWidget {
  final Map<String, dynamic> authorInfo;
  const AuthorInfoHeader({Key? key, required this.authorInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserAvatar(
            author: authorInfo), //size is optional in this params
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                authorInfo['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                _getTimeAgo(authorInfo['epoch']),
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getTimeAgo(int epoch) {
    final date = DateTime.fromMillisecondsSinceEpoch(epoch);
    return timeago.format(date, allowFromNow: true);
  }
}
