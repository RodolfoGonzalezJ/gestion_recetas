import 'dart:io';
import 'package:gestion_recetas/features/auth/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/inventory/controllers/controllers.dart';
import 'package:gestion_recetas/features/inventory/models/models.dart';
import 'package:gestion_recetas/features/inventory/services/inventory_service.dart';
import 'package:gestion_recetas/features/recipes/screen/register/widgets/images_recipe_picker.dart';
import 'package:gestion_recetas/utils/constants/categories.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:gestion_recetas/data/services/cloudinary_service.dart';

class RegisterProductScreen extends StatefulWidget {
  final Product? existingProduct;

  const RegisterProductScreen({super.key, this.existingProduct});

  @override
  State<RegisterProductScreen> createState() => _RegisterProductScreenState();
}

class _RegisterProductScreenState extends State<RegisterProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _gramsController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _notesController = TextEditingController();
  final ProductController _productController = ProductController();
  final InventoryService _inventoryService = InventoryService();
  String? _selectedCategory;
  String? _photoPath;
  DateTime? _selectedExpiryDate;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _productController.initializeFormFields(
      existingProduct: widget.existingProduct,
      nameController: _nameController,
      gramsController: _gramsController,
      quantityController: _quantityController,
      notesController: _notesController,
      setSelectedCategory: (value) => _selectedCategory = value,
      setPhotoPath: (value) => _photoPath = value,
    );
    if (widget.existingProduct != null) {
      _selectedExpiryDate = widget.existingProduct!.expiryDate;
    }
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final cloudinaryService = CloudinaryService();
      final uploadedUrl = await cloudinaryService.uploadImage(
        File(pickedFile.path),
      );
      if (uploadedUrl != null) {
        setState(() {
          _photoPath = uploadedUrl;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al subir la imagen a Cloudinary'),
          ),
        );
      }
    }
  }

  Future<void> _pickExpiryDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedExpiryDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedExpiryDate = pickedDate;
      });
    }
  }

  Future<void> _saveProduct() async {
    final userEmail = AuthController().user.correo ?? '';
    if (_formKey.currentState!.validate() &&
        _selectedCategory != null &&
        _selectedExpiryDate != null) {
      final entry = Entry(
        entryDate: DateTime.now(),
        expiryDate: _selectedExpiryDate!,
        grams:
            _gramsController.text.isNotEmpty
                ? double.tryParse(_gramsController.text.trim())
                : null,
        quantity: int.tryParse(_quantityController.text.trim()) ?? 1,
      );

      final product = Product(
        id: widget.existingProduct?.id ?? const Uuid().v4(),
        name: _nameController.text.trim(),
        category: _selectedCategory!,
        photoUrl: _photoPath,
        notes:
            _notesController.text.isNotEmpty
                ? _notesController.text.trim()
                : null,
        entradas: widget.existingProduct?.entradas ?? [entry],
        entryDate: entry.entryDate,
        expiryDate: entry.expiryDate,
        quantity: entry.quantity,
        createdBy: userEmail, //porque falto esta linea en el primer pushh???
      );

      try {
        await _inventoryService.saveProduct(product);
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar el producto: $e')),
        );
      }
    } else if (_selectedExpiryDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona una fecha de caducidad'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final color = dark ? CColors.light : CColors.secondaryTextColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.existingProduct == null
              ? 'Registrar Producto'
              : 'Editar Producto',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: const BackButton(),
        iconTheme: IconThemeData(
          color: dark ? CColors.light : CColors.primaryTextColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // RecipeImagePicker(
                //   text: 'Imagen del producto *',
                //   text_2: 'Selecciona una imagen para tu producto',
                //   color: color,
                //   onImageUploaded: (url) => _imageUrl = url,
                // ),
                // const SizedBox(width: 8),
                // if (_photoPath != null)
                //   Text(
                //     'Foto seleccionada',
                //     style: const TextStyle(color: Colors.green),
                //   ),
                // const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator:
                      (value) =>
                          value!.isEmpty ? 'El nombre es obligatorio' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  items:
                      ProductCategories.all
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Categoría'),
                  validator:
                      (value) =>
                          value == null ? 'La categoría es obligatoria' : null,
                ),
                const SizedBox(height: 16),
                // RecipeImagePicker(
                //   color: color,
                //   onImageUploaded: (url) => _imageUrl = url,
                // ),
                // const SizedBox(width: 8),
                // if (_photoPath != null)
                //   Text(
                //     'Foto seleccionada',
                //     style: const TextStyle(color: Colors.green),
                //   ),
                // const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _pickPhoto,
                      child: const Text('Seleccionar Foto'),
                    ),
                    const SizedBox(width: 16),
                    if (_photoPath != null)
                      Text(
                        'Foto seleccionada',
                        style: const TextStyle(color: Colors.green),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _gramsController,
                  decoration: const InputDecoration(
                    labelText: 'Gramos (opcional)',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _quantityController,
                  decoration: const InputDecoration(labelText: 'Cantidad'),
                  keyboardType: TextInputType.number,
                  validator:
                      (value) =>
                          value!.isEmpty || int.parse(value) < 1
                              ? 'La cantidad debe ser al menos 1'
                              : null,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _pickExpiryDate,
                      child: const Text('Seleccionar Fecha de Caducidad'),
                    ),
                    const SizedBox(width: 16),
                    if (_selectedExpiryDate != null)
                      Text(
                        'Fecha: ${_selectedExpiryDate!.toLocal()}'.split(
                          ' ',
                        )[0],
                        style: const TextStyle(color: Colors.green),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    labelText: 'Notas (opcional)',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveProduct,
                  child: const Text('Guardar Producto'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
