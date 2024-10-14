import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final Map<String, dynamic> author;
  final double size;

  const UserAvatar({Key? key, required this.author, this.size = 40}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasAvatar = author.containsKey('avatar') && author['avatar'] != null;
    final avatarUrl = hasAvatar ? author['avatar'] : null;
    final name = author['name'] ?? '';

    return ClipOval(
      child: Container(
        width: size,
        height: size,
        color: Colors.blue, // Default background color
        child: hasAvatar
            ? Image.network(
                avatarUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to text avatar if image fails to load
                  return Center(
                    child: Text(
                      name.isNotEmpty ? name[0].toUpperCase() : '?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size * 0.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : '?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size * 0.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
    );
  }
}