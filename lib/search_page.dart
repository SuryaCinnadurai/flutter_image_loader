import 'package:flutter/material.dart';
import 'package:flutter_image_loader/controller.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key, required ImageController controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: GetX<ImageController>(builder: (controller) {
            return LazyLoadScrollView(
              onEndOfPage: controller.loadMoreImages,
              child: ListView.builder(
                itemCount: controller.images.length,
                itemBuilder: (context, index) {
                  if ((controller.images.isNotEmpty &&
                          index != controller.images.length - 1) ||
                      (controller.imageUrls.length ==
                          controller.images.length)) {
                    return _ImageLoader(
                      controller: controller,
                      index: index,
                    );
                  }

                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            );
          }),
        )
      ],
    ));
  }
}

class _ImageLoader extends StatelessWidget {
  const _ImageLoader({Key? key, required this.controller, required this.index})
      : super(key: key);

  final ImageController controller;

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: SizedBox(
          width: 300,
          height: 300,
          child: controller.images[index],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) {
                return Scaffold(
                  body: InteractiveViewer(
                    child: Center(
                      child: GestureDetector(
                        child: SizedBox(
                          width: 300,
                          height: 300,
                          child: Hero(
                            tag: 'imageHero',
                            child: controller.images[index],
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
