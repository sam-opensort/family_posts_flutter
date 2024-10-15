import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'text_post_content.dart'; // Ensure this import is correct

class ImagePost extends StatefulWidget {
  final Map<String, dynamic> postContent;
  final double height;

  const ImagePost({
    Key? key,
    required this.postContent,
    this.height = 200,
  }) : super(key: key);

  @override
  _ImagePostState createState() => _ImagePostState();
}

class _ImagePostState extends State<ImagePost> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> imageUrls =
        List<String>.from(widget.postContent['images'] ?? []);
    String? description = widget.postContent['content'] as String?;

    if (imageUrls.isEmpty) {
      return SizedBox(height: widget.height);
    }

    return Column(
            crossAxisAlignment:
          CrossAxisAlignment.start, // Align children to the start
      children: [
        if (description != null && description.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextPostContent(content: description),
          ),
        SizedBox(
          height: widget.height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: imageUrls.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Image.network(
                      imageUrls[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(child: Text('Failed to load image'));
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    );
                  },
                ),
                if (imageUrls.length > 1) ...[
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${_currentIndex + 1}/${imageUrls.length}',
                        style: TextStyle(color: Colors.white,fontSize: 10),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black
                              .withOpacity(0.5), // Transparent black
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: imageUrls.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => _pageController.animateToPage(
                                entry.key,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              ),
                              child: Container(
                                width: 5,
                                height: 5,
                                margin: EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentIndex == entry.key
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.5),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
