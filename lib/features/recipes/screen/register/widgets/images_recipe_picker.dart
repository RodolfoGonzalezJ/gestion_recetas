import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'package:image_picker/image_picker.dart';

class RecipeImagePicker extends StatefulWidget {
  final Color color;

  const RecipeImagePicker({super.key, required this.color});

  @override
  State<RecipeImagePicker> createState() => _RecipeImagePickerState();
}

class _RecipeImagePickerState extends State<RecipeImagePicker> {
  XFile? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Imagen de la receta *',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: widget.color),
        ),
        const SizedBox(height: 8),
        Text(
          'Selecciona una imagen para tu receta',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: widget.color.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: 160,
            decoration: BoxDecoration(
              color: CColors.primaryColor,
              borderRadius: BorderRadius.circular(12),
              image:
                  _selectedImage != null
                      ? DecorationImage(
                        image: FileImage(File(_selectedImage!.path)),
                        fit: BoxFit.cover,
                      )
                      : null,
            ),
            child:
                _selectedImage == null
                    ? const Center(
                      child: Icon(Icons.add, color: Colors.white, size: 40),
                    )
                    : null,
          ),
        ),
      ],
    );
  }
}
