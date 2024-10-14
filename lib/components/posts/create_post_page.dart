import 'dart:convert';

import 'package:family_posts/components/posts/radius_connection_icons.dart';
import 'package:flutter/material.dart';

class CreatePostPage extends StatefulWidget {
  final Map<String, dynamic>? existingPost;

  CreatePostPage({Key? key, this.existingPost}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  late TextEditingController _contentController;
  int _selectedConnectionValue = 1;
  bool _isEditing = false;

  final List<Map<String, dynamic>> _connections = [
    {'name': 'Myself', 'value': 0},
    {'name': 'First connections', 'value': 1},
    {'name': 'Second connections', 'value': 2},
    {'name': 'Third connections', 'value': 3},
  ];

  @override
  void initState() {
    super.initState();
    _isEditing = widget.existingPost != null;
    _contentController = TextEditingController(
      text: _isEditing ? widget.existingPost!['post_content']['content'] : '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: _buildDropdown(),
        actions: [
          TextButton(
            onPressed: _contentController.text.isNotEmpty
                ? () {
                    // Handle post creation or update
                    if (_isEditing) {
                      // Update existing post
                    } else {
                      debugPrint(_contentController.text);
                      Map<String, dynamic> post = {
                        'post_content': {
                          'type': 'text',
                          'content': _contentController.text,
                        },
                        'dst': {'radius': _selectedConnectionValue},
                        'type': 'post'
                      };
                      // Create new post

                      // 2. Convert the Map to a JSON string
                      String jsonPayload = jsonEncode(post);

                      // 3. Print the JSON string
                      print(jsonPayload);
                    }
                    Navigator.pop(context);
                  }
                : null,
            child: Text(_isEditing ? 'Update' : 'Post'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _contentController,
          decoration: const InputDecoration(
            hintText: 'Write something...',
            border: InputBorder.none,
          ),
          maxLines: null,
          onChanged: (value) {
            setState(() {}); // Rebuild to update button state
          },
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(14),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: _selectedConnectionValue,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.black),
          onChanged: (int? newValue) {
            setState(() {
              _selectedConnectionValue = newValue!;
            });
          },
          selectedItemBuilder: (BuildContext context) {
            return _connections.map<Widget>((Map<String, dynamic> connection) {
              return Row(
                children: [
                  getRadiusConnectionIcon(connection['value']),
                  SizedBox(width: 8),
                  Text(connection['name']),
                ],
              );
            }).toList();
          },
          items: _connections
              .map<DropdownMenuItem<int>>((Map<String, dynamic> connection) {
            return DropdownMenuItem<int>(
              value: connection['value'],
              child: Container(
                constraints: BoxConstraints(
                    minHeight: 48), // Ensure a minimum height for all items
                child: Row(
                  children: [
                    Expanded(
                      flex: 80, // 70% of the width
                      child: Text(connection['name']),
                    ),
                    Expanded(
                      flex: 20, // 30% of the width
                      child: Center(
                        // Center the icon within this space
                        child: getRadiusConnectionIcon(connection['value']),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }
}
