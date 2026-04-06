import 'package:flutter/material.dart';
import 'recipedetail.dart';
import '../database/database.dart';



class Mainmenu extends StatefulWidget {
  const Mainmenu({super.key});

  @override
  State<Mainmenu> createState() => _MainmenuState();
}

class _MainmenuState extends State<Mainmenu> {
  int crossAxisCount = 2;

  late AppDatabase db;
  late Future<List<Receta>> recetasFuture;

  @override
  void initState() {
    super.initState();
    db = AppDatabase();
    recetasFuture = db.obtenerRecetas();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: TextField(
                    onChanged: (value) {
                      print("Buscando: $value");
                    },
                    decoration: InputDecoration(
                      hintText: 'Buscar receta o ingrediente',
                      suffixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[300],
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // // Boton de busqueda
                // IconButton(
                //   onPressed: () {
                //     print("Botón de búsqueda presionado");
                //   },
                //   icon: const Icon(Icons.search),
                //   style: IconButton.styleFrom(
                //     backgroundColor: const Color.fromARGB(255, 255, 189, 89),
                //     minimumSize: const Size(40, 40),
                //     padding: EdgeInsets.zero,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //   ),
                // ),
                // const SizedBox(width: 8),

                // Boton de filtro
                IconButton(
                  onPressed: () {
                    print("Filtro presionado");
                  },
                  icon: const Icon(Icons.filter_alt),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 189, 89),
                    minimumSize: const Size(40, 40),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 20),

          // Recetas destacadas y eso
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: FutureBuilder<List<Receta>>(
                    future: recetasFuture,
                    builder: (context, snapshot) {

                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final recetas = snapshot.data!;

                      return GridView.builder(
                        itemCount: recetas.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1,
                        ),
                    itemBuilder: (context, index) {
                      final receta = recetas[index];

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
                          decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(16),
                          ),
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
              ),
            ),
          )
          )
        ],
      )
    );
  }
}