import 'package:brown_brown/ui/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DecoInput extends StatefulWidget {
  const DecoInput({
    Key? key,
    required this.controller,
    this.maxWith = double.infinity,
    this.enableTapSelect = true,
    this.style,
    this.onChanged,
    this.keyboardType,
    this.autoFocus = false,
    this.maxLength,
    this.hintText,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  final double maxWith;
  final TextEditingController controller;
  final TextStyle? style;
  final bool enableTapSelect;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final bool autoFocus;
  final int? maxLength;
  final TextAlign textAlign;
  final String? hintText;

  @override
  _DecoInputState createState() => _DecoInputState();
}

class _DecoInputState extends State<DecoInput> {
  FocusNode? focusNode;

  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();
    focusNode!.addListener(() => setState(() {}));
    if (widget.autoFocus!) focusNode!.requestFocus();
  }

  @override
  void dispose() {
    focusNode!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: widget.maxWith),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: Corners.smBorder,
          color: focusNode!.hasFocus ? Colors.white : Colors.grey[200],
        ),
        child: TextField(
          textAlign: widget.textAlign,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: widget.hintText,
            focusedBorder: OutlineInputBorder(
              borderRadius: Corners.smBorder,
              borderSide: BorderSide(color: Colors.blueAccent[100]!, width: 3),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: Corners.smBorder,
              borderSide: BorderSide(color: Colors.transparent, width: 0),
            ),
            contentPadding: EdgeInsets.all(Insets.sm),
            isDense: true,
            counterText: "",
            // suffixIcon: Icon(CupertinoIcons.clear),
          ),
          style: widget.style,
          onTap: () {
            if (widget.enableTapSelect && !focusNode!.hasFocus) {
              widget.controller.selection = _allSelection;
            }
          },
          onChanged: widget.onChanged,
          maxLength: widget.maxLength,
        ),
      ),
    );
  }

  TextSelection get _allSelection => TextSelection(baseOffset: 0, extentOffset: widget.controller!.text.length);
}
