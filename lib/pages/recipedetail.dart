import 'package:flutter/material.dart';

class Recipedetail extends StatefulWidget {
  final String nombre;
  const Recipedetail({super.key, required this.nombre});

  @override
  State<Recipedetail> createState() => _RecipedetailState();
}

class _RecipedetailState extends State<Recipedetail> {
  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://via.placeholder.com/400x300'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Icon(
                      Icons.restaurant, 
                      size: 100, 
                      color: Colors.white),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 56, 55, 55)),
                    style: IconButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 189, 89),
                      minimumSize: const Size(40, 40),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(64),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(child: 
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      widget.nombre,
                      style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                IconButton(
                  onPressed: () {
                    
                  }, 
                  icon: const Icon(Icons.filter_alt, color: Color.fromARGB(255, 56, 55, 55),),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 189, 89),
                    minimumSize: const Size(40, 40),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                SizedBox(
                  width: 40,
                  height: 40,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isSaved = !isSaved;
                      });
                    },
                    icon: Icon(
                      isSaved ? Icons.bookmark : Icons.bookmark_border,
                      color: isSaved ? Colors.orange : Color.fromARGB(255, 56, 55, 55),
                      size: 40,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Text(
                      'Descripción breve de la receta, ingredientes principales, tiempo de preparación, etc.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.grey[200],
                      collapsedBackgroundColor: Colors.grey[200],
                      title: const Text('Ingredientes'),
                      children: const [
                        ListTile(title: Text('• 1 taza de arroz')),
                        ListTile(title: Text('• 2 huevos')),
                        ListTile(title: Text('• Verduras')),
                      ],
                  ),

                  const SizedBox(height: 10),

                  ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.grey[200],
                      collapsedBackgroundColor: Colors.grey[200],
                      title: const Text('Ingredientes'),
                      children: const [
                        ListTile(title: Text('1. Hervir arroz')),
                        ListTile(title: Text('2. Cocinar huevos')),
                        ListTile(title: Text('3. Mezclar')),
                      ],
                  ),

                  const SizedBox(height: 10),

                  ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.grey[200],
                      collapsedBackgroundColor: Colors.grey[200],
                      title: const Text('Información nutricional'),
                      children: const [
                        ListTile(title: Text('Calorias: 350 kcal')),
                        ListTile(title: Text('Proteinas: 12g')),
                        ListTile(title: Text('Carbohidratos: 60g')),
                      ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}