import 'package:flutter/material.dart';

class TextPostContent extends StatefulWidget {
  final String content;

  const TextPostContent({Key? key, required this.content}) : super(key: key);

  @override
  _TextPostContentState createState() => _TextPostContentState();
}

class _TextPostContentState extends State<TextPostContent> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final words = widget.content.split(' ');

    if (words.length <= 20 || _expanded) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.content),
          if (words.length > 20)
            GestureDetector(
              onTap: () {
                setState(() {
                  _expanded = false;
                });
              },
              child: Text(
                'Read less',
                style:
                    TextStyle(color: Colors.blue),
              ),
            ),
        ],
      );
    } else {
      return RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            TextSpan(text: words.take(20).join(' ')),
            TextSpan(text: '... '),
            WidgetSpan(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _expanded = true;
                  });
                },
                child: Text(
                  'Read more',
                  style: TextStyle(
                      color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
