import 'package:flutter/material.dart';
import '../database/database.dart';
import 'selectlist.dart';
import 'fullimage.dart';

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

  Future<void> _checkSaved() async {
    final saved = await db.recetaEstaEnAlgunaLista(widget.id);

    setState(() {
      isSaved = saved;
    }
  );
}
  @override
  void initState() {
    super.initState();

    db = AppDatabase();

    recetaFuture = (db.select(db.recetas)..where((t) => t.id.equals(widget.id))).getSingle();

    ingredientesFuture = db.obtenerIngredientes(widget.id);
    instruccionesFuture = db.obtenerInstrucciones(widget.id);
    infoFuture = db.obtenerInfo(widget.id);

    _checkSaved();
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
                    // SECCIÓN DE IMAGENES DE LA RECETA
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

                              return GestureDetector(
                                onTap: () {
                                  final imagenesList = receta.imagenes != null
                                      ? receta.imagenes!.split(',')
                                      : ['assets/images/default.jpg'];

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => FullscreenImage(
                                        images: imagenesList,
                                        initialIndex: index,
                                      ),
                                    ),
                                  );
                                },
                                child: Image(
                                  image: img.startsWith('http')
                                      ? NetworkImage(img)
                                      : AssetImage(img) as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),

                    // FLECHA PARA RETROCEDER A LA PANTALLA ANTERIOR
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

                    // SECCIÓN DE PUNTOS PARA LAS IMAGENES
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
                            children: List.generate(
                              imagenesList.length, (index) {
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
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),

                // SECCIÓN DEL NOMBRE DE RECETA Y LOS BOTONES DE GUARDAR Y FILTRAR
                Row(
                  children: [
                    Expanded(child: 
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          receta.nombre,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    IconButton(
                      onPressed: () {
                        // FALTA AGREGAR PARA PORCIONES
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
                        onPressed: () async {
                          final selectedListaId = await showModalBottomSheet<int>(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) => SeleccionarListaSheet(
                              recetaId: receta.id,
                            ),
                          );

                          if (selectedListaId != null) {
                            final inserted = await db.existeEnLista(selectedListaId, receta.id);

                            if (inserted) {
                              await db.eliminarRecetaDeLista(selectedListaId, receta.id);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Receta eliminada correctamente")),
                              );
                            } else {
                              await db.agregarRecetaALista(selectedListaId, receta.id);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Receta agregada a la lista")),
                              );
                            }
                            final estaEnAlguna = await db.recetaEstaEnAlgunaLista(receta.id);

                            setState(() {
                              isSaved = estaEnAlguna;
                            });
                          }
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

                // DESCRIPCION DE LA RECETA
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
                
                // TIEMPO DE PREPARACION
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Tiempo de preparación aproximado: ${receta.tiempo} min",
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),

                // TODA LA PARTE INFORMATIVA
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
                                      '${ingrediente.cantidad} ${ingrediente.unidad} de ${ingrediente.nombre}')
                                  );
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
                                      '${paso.numero}. ${paso.descripcion}'
                                    ),
                                  );
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
                        title: const Text('Información nutricional'),
                        children: [
                          FutureBuilder<InfoNutrimentalData?>(
                            future: infoFuture,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData || snapshot.data == null) {
                                return const SizedBox();
                              }

                              final info = snapshot.data!;

                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      'Calorías: ${info.calorias} kcal'
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      'Proteínas: ${info.proteinas} g'
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      'Grasas: ${info.grasas} g'
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      'Carbohidratos: ${info.carbohidratos} g'
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
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