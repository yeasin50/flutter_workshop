import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key, this.onTap, this.padding = const EdgeInsetsDirectional.all(12)});

  final EdgeInsetsGeometry padding;
  final Function(String value)? onTap;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Row(
        spacing: 24,
        children: [
          Expanded(
            child: CupertinoSearchTextField(
              controller: controller,
              suffixMode: OverlayVisibilityMode.never,
            ),
          ),
          ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, value, child) {
              return TextButton(
                onPressed: value.text.trim().isEmpty
                    ? null //
                    : () => widget.onTap?.call(controller.text),
                child: Text('search'),
              );
            },
          ),
        ],
      ),
    );
  }
}
