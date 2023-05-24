import 'package:flutter/material.dart';

class DragableImage extends StatefulWidget {
  const DragableImage({super.key});

  @override
  State<DragableImage> createState() => _DragableImageState();
}

class _DragableImageState extends State<DragableImage> {
  Offset _offset = const Offset(100, 100);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(builder: (context, constaints) {
        return Container(
          color: Colors.white60,
          child: Stack(
            children: [
              Positioned(
                left: _offset.dx,
                top: _offset.dy,
                child: Draggable(
                  feedback: Image.network(
                    "https://tinyurl.com/95ncjeuu",
                    height: 200,
                    color: Colors.orangeAccent,
                    colorBlendMode: BlendMode.colorBurn,
                  ),
                  onDragUpdate: (details) {
                    setState(() {
                      // var height = MediaQuery.of(context).size.height;
                      // double adjustment = height - constaints.maxHeight;
                      // log(details.delta.toString());
                      _offset =
                          Offset(_offset.dx + details.delta.dx, _offset.dy);
                    });
                  },
                  axis: Axis.horizontal,
                  ignoringFeedbackPointer: false,
                  // onDragEnd: (details) {
                  //   setState(() {
                  //     // double adjustment = MediaQuery.of(context).size.height -
                  //     //     constaints.maxHeight;
                  //     // log(details.offset.toString());
                  //     // _offset = Offset(details.offset.dx, details.offset.dy);
                  //   });
                  // },
                  child: Image.network(
                    "https://tinyurl.com/95ncjeuu",
                    height: 200,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
