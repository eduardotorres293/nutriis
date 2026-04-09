import 'package:flutter/material.dart';
import '../database/database.dart';
import 'recipedetail.dart';

class DetalleLista extends StatefulWidget {
  final int listaId;
  final String nombreLista;

  const DetalleLista({super.key, required this.listaId, required this.nombreLista});

  @override
  State<DetalleLista> createState() => _DetalleListaState();
}

class _DetalleListaState extends State<DetalleLista> {
  late AppDatabase db;
  late Future<List<Receta>> recetasFuture;

  @override
  void initState() {
    super.initState();
    db = AppDatabase();
    recetasFuture = db.obtenerRecetasDeLista(widget.listaId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.nombreLista)),
      body: FutureBuilder<List<Receta>>(
        future: recetasFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final recetas = snapshot.data!;

          if (recetas.isEmpty) {
            return const Center(child: Text("No hay recetas en esta lista"));
          }

          return ListView.separated(
                itemCount: recetas.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final receta = recetas[index];
                  final imagen = (receta.imagenes != null && receta.imagenes!.isNotEmpty)
                    ? receta.imagenes!.split(',').first
                    : 'assets/images/default.jpg';

                  // Cada receta se muestra dentro de un GestureDetector para
                  // permitir hacer clic e ir a la página de detalles
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Recipedetail(
                            id: receta.id,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      // Creación de un contenedor para cada receta
                      height:300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(imagen),
                          fit: BoxFit.cover,
                        ),
                      ),

                      // Nombre de la receta centrado dentro del contenedor
                      child: Center(
                        child: Text(
                          receta.nombre,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  );
                },
              );
        },
      ),
    );
  }
}