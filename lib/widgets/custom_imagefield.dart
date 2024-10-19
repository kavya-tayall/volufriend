import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // for using File class

class ImageField extends StatelessWidget {
  final List<XFile>? selectedImages;
  final Function(List<XFile>) onSave;

  const ImageField({
    Key? key,
    required this.selectedImages,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            final ImagePicker _picker = ImagePicker();
            final List<XFile>? pickedImages = await _picker.pickMultiImage();
            if (pickedImages != null && pickedImages.isNotEmpty) {
              if (selectedImages!.length + pickedImages.length <= 2) {
                onSave([...selectedImages!, ...pickedImages]);
              } else {
                onSave(selectedImages!
                    .sublist(0, 2 - selectedImages!.length)
                    .followedBy(pickedImages.take(2 - selectedImages!.length))
                    .toList());
              }
            }
          },
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: selectedImages == null || selectedImages!.isEmpty
                ? Center(
                    child: Icon(
                      Icons.upload,
                      size: 50,
                      color: Colors.grey,
                    ),
                  )
                : null,
          ),
        ),
        SizedBox(height: 10),
        selectedImages != null && selectedImages!.isNotEmpty
            ? Row(
                children: selectedImages!
                    .map((image) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            File(image.path),
                            width: 75,
                            height: 75,
                            fit: BoxFit.cover,
                          ),
                        ))
                    .toList(),
              )
            : Container(),
        if (selectedImages!.length == 2) Text("Only 2 images allowed"),
      ],
    );
  }
}
