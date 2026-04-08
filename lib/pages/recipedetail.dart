import 'package:flutter/material.dart';
import '../database/database.dart';

class Recipedetail extends StatefulWidget {
  final int id;
  const Recipedetail({super.key, required this.id});

  @override
  State<Recipedetail> createState() => _RecipedetailState();
}

class _RecipedetailState extends State<Recipedetail> {
  bool isSaved = false;
  int currentImage = 0;
  late AppDatabase db;

  late Future<Receta> recetaFuture;
  late Future<List<Ingrediente>> ingredientesFuture;
  late Future<List<Instruccione>> instruccionesFuture;
  late Future<InfoNutrimentalData?> infoFuture;

  @override
    void initState() {
      super.initState();

      db = AppDatabase();

      recetaFuture = (db.select(db.recetas)
            ..where((t) => t.id.equals(widget.id)))
          .getSingle();

      ingredientesFuture = db.obtenerIngredientes(widget.id);
      instruccionesFuture = db.obtenerInstrucciones(widget.id);
      infoFuture = db.obtenerInfo(widget.id);
    }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Receta>(
        future: recetaFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Receta no encontrada'));
          }

          final receta = snapshot.data!;
        return SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  child: Builder(
                    builder: (context) {
                    final imagenesList = receta.imagenes != null
                        ? receta.imagenes!.split(',')
                        : ['assets/images/default.jpg'];

                    return PageView.builder(
                      itemCount: imagenesList.length,
                      onPageChanged: (index) {
                        setState(() {
                          currentImage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                          final img = imagenesList[index];

                          return Image(
                            image: img.startsWith('http')
                                ? NetworkImage(img)
                                : AssetImage(img) as ImageProvider,
                            fit: BoxFit.cover,
                        );
                      },
                    );
                  }),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back, 
                      color: Color.fromARGB(255, 56, 55, 55),
                      size: 30,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 189, 89),
                      minimumSize: const Size(40, 40),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Builder(
                    builder: (context) {
                      final imagenesList = receta.imagenes != null
                          ? receta.imagenes!.split(',')
                          : ['assets/images/default.jpg'];

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(imagenesList.length, (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: currentImage == index ? 12 : 8,
                            height: currentImage == index ? 12 : 8,
                            decoration: BoxDecoration(
                              color: currentImage == index
                                  ? const Color.fromARGB(255, 255, 255, 255)
                                  : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
                      );
                    }
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
                      receta.nombre,
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
                    child: Text(
                      receta.descripcion,
                      style: const TextStyle(fontSize: 16),
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
                      collapsedBackgroundColor: Color.fromARGB(255, 255, 189, 89),
                      title: const Text('Ingredientes'),
                      children: [
                        FutureBuilder <List<Ingrediente>>(
                          future: ingredientesFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Center(child: Text('No hay ingredientes'));
                            }
                            return Column(
                              children: snapshot.data!.map((ingrediente) {
                                return ListTile(
                                  title: Text(
                                    '${ingrediente.cantidad} ${ingrediente.unidad} de ${ingrediente.nombre}'));
                              }).toList(),
                            );
                          },
                        ),
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
                      collapsedBackgroundColor: Color.fromARGB(255, 255, 189, 89),
                      title: const Text('Instrucciones'),
                      children: [
                          FutureBuilder<List<Instruccione>>(
                            future: instruccionesFuture,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const SizedBox();
                              }
                              return Column(
                                children: snapshot.data!.map((paso) {
                                  return ListTile(
                                    title: Text(
                                        '${paso.numero}. ${paso.descripcion}'),
                                  );
                              }).toList(),
                            );
                          },
                        )
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
                      collapsedBackgroundColor: Color.fromARGB(255, 255, 189, 89),
                      title: const Text('Información nutricional'),
                      children: [
                          FutureBuilder<InfoNutrimentalData?>(
                            future: infoFuture,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData ||
                                  snapshot.data == null) {
                                return const SizedBox();
                              }

                              final info = snapshot.data!;

                              return Column(
                                children: [
                                  ListTile(
                                      title: Text(
                                          'Calorías: ${info.calorias} kcal')),
                                  ListTile(
                                      title: Text(
                                          'Proteínas: ${info.proteinas} g')),
                                  ListTile(
                                      title:
                                          Text('Grasas: ${info.grasas} g')),
                                  ListTile(
                                      title: Text(
                                          'Carbohidratos: ${info.carbohidratos} g')),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}