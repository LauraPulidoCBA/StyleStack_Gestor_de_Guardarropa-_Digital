import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/clothing.dart';
import '../providers/wardrobe_provider.dart';

class AddClothingScreen extends StatefulWidget {
  const AddClothingScreen({super.key});

  @override
  State<AddClothingScreen> createState() => _AddClothingScreenState();
}

class _AddClothingScreenState extends State<AddClothingScreen> {
  final _nameController = TextEditingController();
  File? _image;
  String _selectedCategory = 'Camisetas';
  
  // Lista de categorías simple
  final List<String> _categories = ['Camisetas', 'Pantalones', 'Chaquetas', 'Zapatos', 'Otros'];

  // Función para elegir imagen (Cámara o Galería)
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _saveClothing() {
    if (_nameController.text.isEmpty || _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Completa los campos")),
      );
      return;
    }

    // --- TRUCO PARA EL ID SIN UUID ---
    // Usamos los milisegundos de la hora actual como ID único.
    final String simpleId = DateTime.now().millisecondsSinceEpoch.toString();

    final newItem = Clothing(
      id: simpleId, 
      name: _nameController.text,
      category: _selectedCategory,
      image: _image!.path,
    );

    context.read<WardrobeProvider>().addClothing(newItem);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nueva Prenda")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Vista previa de la imagen
            GestureDetector(
              onTap: () {
                // Menú simple para elegir origen
                showModalBottomSheet(
                  context: context,
                  builder: (_) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.photo_library),
                        title: const Text("Galería"),
                        onTap: () { _pickImage(ImageSource.gallery); Navigator.pop(context); },
                      ),
                      ListTile(
                        leading: const Icon(Icons.camera_alt),
                        title: const Text("Cámara"),
                        onTap: () { _pickImage(ImageSource.camera); Navigator.pop(context); },
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: _image == null 
                  ? const Icon(Icons.add_a_photo, size: 50) 
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(_image!, fit: BoxFit.cover),
                    ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Nombre
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Nombre",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Categoría (Dropdown simple)
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: _categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
              onChanged: (val) => setState(() => _selectedCategory = val!),
            ),
            const SizedBox(height: 30),

            // Botón Guardar
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                onPressed: _saveClothing,
                child: const Text("GUARDAR", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}