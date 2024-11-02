import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImageField extends StatefulWidget {
  final Map<String, String>? texts;
  final int? cardinality;
  final bool multipleUpload;
  final BoxDecoration? thumbnailAddMoreDecoration;
  final EdgeInsets? listPadding;
  final Color? pickerIconColor;
  final Color? pickerBackgroundColor;
  final bool scrollingAfterUpload;
  final bool enabledCaption;
  final Future<void> Function(
      List<CustomImageAndCaptionModel>? imageAndCaptionList)? onSave;
  final Future<void> Function(dynamic dataSource, dynamic controller)? onUpload;

  final ButtonStyle? uploadButtonStyle;
  final TextStyle? uploadButtonTextStyle;
  final double imageContainerWidth;
  final double imageContainerHeight;
  final BorderRadius? imageContainerBorderRadius;
  final Color? imageRemoveIconBackgroundColor;
  final TextStyle? captionTextStyle;
  final TextStyle? hintTextStyle;

  const CustomImageField({
    Key? key,
    this.texts,
    this.cardinality = 2,
    this.multipleUpload = true,
    this.thumbnailAddMoreDecoration,
    this.listPadding = const EdgeInsets.all(4.0),
    this.pickerIconColor,
    this.pickerBackgroundColor,
    this.scrollingAfterUpload = true,
    this.enabledCaption = true,
    this.onSave,
    this.onUpload,
    this.uploadButtonStyle,
    this.uploadButtonTextStyle,
    this.imageContainerWidth = 90.0,
    this.imageContainerHeight = 90.0,
    this.imageContainerBorderRadius,
    this.imageRemoveIconBackgroundColor = Colors.red,
    this.captionTextStyle = const TextStyle(color: Colors.white, fontSize: 12),
    this.hintTextStyle = const TextStyle(color: Colors.white70),
  }) : super(key: key);

  @override
  CustomImageFieldState createState() => CustomImageFieldState();
}

class CustomImageFieldState extends State<CustomImageField> {
  List<CustomImageAndCaptionModel> files = [];
  bool isLoading = false;

  Future<void> _pickImages() async {
    if (widget.cardinality != null && files.length >= widget.cardinality!) {
      return;
    }

    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      final allowedFiles =
          pickedFiles.take(widget.cardinality! - files.length).toList();

      for (var file in allowedFiles) {
        final newFile =
            CustomImageAndCaptionModel(file: file.path, caption: "");
        setState(() => files.add(newFile));

        if (widget.onUpload != null) {
          setState(() => isLoading = true);
          await widget.onUpload!(file, null);
          setState(() => isLoading = false);
        }
      }

      // Removed the direct call to onSave here to prevent saving on selection
    }
  }

  // Expose saveImages to the parent widget
  Future<void> saveImages() async {
    if (widget.onSave != null) {
      await widget.onSave!(files);
    }
  }

  String getText(String key) => widget.texts?[key] ?? '';

  @override
  Widget build(BuildContext context) {
    final addMoreDecoration = widget.thumbnailAddMoreDecoration ??
        BoxDecoration(
          color: Colors.grey[200],
          borderRadius:
              widget.imageContainerBorderRadius ?? BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        files.isEmpty
            ? ElevatedButton.icon(
                onPressed: _pickImages,
                icon: const Icon(Icons.upload),
                label: Text(
                  getText('fieldFormText') ?? 'Select or Upload Images',
                  style: widget.uploadButtonTextStyle,
                ),
                style: widget.uploadButtonStyle ??
                    ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
              )
            : Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  ...files.map((image) {
                    return Stack(
                      children: [
                        Container(
                          width: widget.imageContainerWidth,
                          height: widget.imageContainerHeight,
                          decoration: addMoreDecoration,
                          child: Image.file(
                            File(image.file),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() => files.remove(image));
                            },
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor:
                                  widget.imageRemoveIconBackgroundColor,
                              child: const Icon(Icons.close,
                                  size: 16, color: Colors.white),
                            ),
                          ),
                        ),
                        if (widget.enabledCaption)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: Colors.black45,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 2.0),
                              child: TextField(
                                onChanged: (text) => image.caption = text,
                                style: widget.captionTextStyle,
                                decoration: InputDecoration(
                                  hintText: getText('addCaptionText') ??
                                      'Add a caption...',
                                  hintStyle: widget.hintTextStyle,
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  }).toList(),
                  if (widget.cardinality == null ||
                      files.length < widget.cardinality!)
                    GestureDetector(
                      onTap: _pickImages,
                      child: Container(
                        width: widget.imageContainerWidth,
                        height: widget.imageContainerHeight,
                        decoration: addMoreDecoration,
                        child:
                            const Icon(Icons.add, size: 40, color: Colors.grey),
                      ),
                    ),
                ],
              ),
        if (isLoading)
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: LinearProgressIndicator(),
          ),
      ],
    );
  }
}

class CustomImageAndCaptionModel {
  final String file;
  String caption;

  CustomImageAndCaptionModel({required this.file, this.caption = ""});
}
