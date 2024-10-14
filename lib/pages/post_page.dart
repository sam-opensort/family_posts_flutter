import 'package:family_posts/components/posts/create_post_page.dart';
import 'package:family_posts/components/posts/post_card.dart';
import 'package:flutter/material.dart';

class PostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostCard(post: posts[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostPage()),
          );
        },
      ),
    );
  }
}

final List<Map<String, dynamic>> posts = [
  {
    "post_id": "754d3b00-3e0b-4949-b256-cc6670ffd27a",
    "type": "post",
    "epoch": 1728026685260,
    "status": "active",
    "author": {
      "kin_id": "7bf0e2f4-6429-4778-a8b5-5fe8592bf170",
      "name": "Sam",
      "avatar": "https://github.com/shadcn.png"
    },
    "post_content": {
      "type": "text",
      "content":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    },
    "tags": [],
    "is_liked": true,
    "like_count": 5,
    "comment_count": 10,
    "latest_comment": {"content": "hi"}
  },
  {
    "post_id": "854d3b00-3e0b-4949-b256-cc6670ffd27w",
    "type": "post",
    "epoch": 1728026685261,
    "status": "active",
    "author": {
      "kin_id": "8bf0e2f4-6429-4778-a8b5-5fe8592bf171",
      "name": "Alice",
      "avatar": "https://github.com/shadcn.png"
    },
    "post_content": {
      "type": "image",
      "description":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      "images": [
        "https://images.pexels.com/photos/45853/grey-crowned-crane-bird-crane-animal-45853.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "https://images.pexels.com/photos/4482677/pexels-photo-4482677.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "https://images.pexels.com/photos/45853/grey-crowned-crane-bird-crane-animal-45853.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      ]
    },
    "tags": [],
    "is_liked": false,
    "like_count": 3,
    "comment_count": 2,
    "latest_comment": {"content": "Nice post!"}
  },
  {
    "post_id": "854d3b00-3e0b-4949-b256-cc6670ffd27b",
    "type": "post",
    "epoch": 1728026685261,
    "status": "active",
    "author": {
      "kin_id": "8bf0e2f4-6429-4778-a8b5-5fe8592bf171",
      "name": "Alice",
      // "avatar": "http://localhost:4500/f/image/02481d1e-8a01-4533-92ff-cf5a6be7db96"
    },
    "post_content": {"type": "text", "content": "Hello, Flutter!"},
    "tags": [],
    "is_liked": false,
    "like_count": 3,
    "comment_count": 2,
    "latest_comment": {"content": "Nice post!"}
  },
];
