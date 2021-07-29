import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

class AppImage extends StatefulWidget {
  const AppImage({Key? key, required this.url, this.width, this.height, this.fit = BoxFit.cover, this.radius, this.animationDuration}) : super(key: key);
  final String url;
  final double? width;
  final double? height;
  final double? radius;
  final int? animationDuration;
  final BoxFit fit;

  @override
  _AppImageState createState() => _AppImageState();
}

class _AppImageState extends State<AppImage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: widget.animationDuration ?? 500), lowerBound: 0.0, upperBound: 1.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 0)),
      child: widget.url.isNotEmpty
          ? ExtendedImage.network(
              widget.url,
              fit: widget.fit,
              width: widget.width,
              height: widget.height,
              retries: 2,
              timeLimit: Duration(seconds: 10),
              timeRetry: Duration(seconds: 1),
              border: Border.all(color: Colors.black12, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 0)),
              cache: true,
              loadStateChanged: (ExtendedImageState state) {
                switch (state.extendedImageLoadState) {
                  case LoadState.loading:
                    _controller.reset();
                    return Center(
                      child: SizedBox(
                        child: CircularProgressIndicator(
                          color: Colors.black12,
                          strokeWidth: 2,
                        ),
                        height: 40.0,
                        width: 40.0,
                      ),
                    );
                  case LoadState.completed:
                    _controller.forward();
                    return FadeTransition(
                      opacity: _controller,
                      child: ExtendedRawImage(
                        fit: widget.fit,
                        image: state.extendedImageInfo?.image,
                        width: widget.width,
                        height: widget.height,
                      ),
                    );
                  case LoadState.failed:
                    _controller.reset();
                    state.imageProvider.evict();
                    return GestureDetector(
                      child: Container(
                        color: Colors.black12,
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.black12,
                        ),
                      ),
                      onTap: () {
                        state.reLoadImage();
                      },
                    );
                }
              },
            )
          : Container(
              width: widget.width,
              height: widget.height,
              color: Colors.black12,
            ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
