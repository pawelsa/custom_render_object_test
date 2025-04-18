import 'package:custom_render_object/custom_text_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _CustomTextWidgetExpandable(),
          ),
        ),
      ),
    );
  }
}

class _CustomTextWidgetExpandable extends StatefulWidget {
  const _CustomTextWidgetExpandable({super.key});

  @override
  State<_CustomTextWidgetExpandable> createState() =>
      __CustomTextWidgetExpandableState();
}

class __CustomTextWidgetExpandableState
    extends State<_CustomTextWidgetExpandable> {
  bool expand = false;
  @override
  Widget build(BuildContext context) {
    return CustomTextWidget(
      text:
          // 'Hello World!lfajskf;lkasjhf;lhglashg;ahg;ahg;shg;hs;gfhs;gohslghslghsgh;oshgpiJF;jf;sjg;sjg;ish;shghslj;fh`sljhflhglkjshglkjshgljkshgljhgljshgjlks`',
      // 'Hello World!',
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent gravida tellus sed volutpat molestie. Mauris tempus velit ante, vel interdum odio vulputate eget.",
      // shouldExpand: expand,
      // trailingWidget: ElevatedButton(
        // onPressed: () => setState(() => expand = !expand),
        // child: Text("Expand"),
      // ),
    );
  }
}
