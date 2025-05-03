import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/auth/models/models.dart';
import 'package:gestion_recetas/features/profile/screen/widgets/edit/document_details_section.dart';
import 'package:gestion_recetas/features/profile/screen/widgets/edit/profile_avatar_section.dart';
import 'package:gestion_recetas/features/profile/screen/widgets/edit/profile_form_section.dart';
import 'package:gestion_recetas/features/profile/screen/widgets/edit/save_changes_button.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;

  const EditProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _idController;
  DateTime? _birthDate;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.nombre);
    _lastNameController = TextEditingController(text: widget.user.apellido);
    _emailController = TextEditingController(text: widget.user.correo);
    _phoneController = TextEditingController(text: widget.user.celular);
    _idController = TextEditingController(text: widget.user.cedula);
    _birthDate = widget.user.fechaNacimiento;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _idController.dispose();
    super.dispose();
  }

  Future<void> _pickBirthDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(now.year - 18),
      firstDate: DateTime(1900),
      lastDate: now,
      builder:
          (ctx, child) => Theme(
            data: Theme.of(ctx).copyWith(
              colorScheme: ColorScheme.light(primary: CColors.primaryColor),
            ),
            child: child!,
          ),
    );
    if (picked != null) setState(() => _birthDate = picked);
  }

  void _saveChanges() {
    // TODO: validar y enviar los cambios usando tu AuthService
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: CColors.primaryTextColor),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileAvatarSection(
              onTap: () {
                /* TODO: pick image */
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Mi Perfil',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ProfileFormSection(
              firstNameController: _firstNameController,
              lastNameController: _lastNameController,
              emailController: _emailController,
              phoneController: _phoneController,
              idController: _idController,
              birthDate: _birthDate,
              onBirthDateTap: _pickBirthDate,
            ),
            const SizedBox(height: 24),
            const SizedBox(height: 12),
            const SizedBox(height: 32),
            SaveChangesButton(onPressed: _saveChanges),
          ],
        ),
      ),
    );
  }
}
