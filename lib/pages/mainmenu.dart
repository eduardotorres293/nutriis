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

  // Se declara la variable para la base de datos
  late AppDatabase db;
  // Y se crea una lista para guardar las 
  // recetas obtenidas de la base de datos
  late Future<List<Receta>> recetasFuture;

  // En el initState se inicializa 
  // la base de datos y se obtiene la lista de recetas
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
      // Creación de la columna principal 
      // que contiene el buscador y las recetas
      // EL column es para organizar elementos verticalmente
      child: Column(
        // Dentro de la columna, se organizan los 
        // elementos con un row para el buscador, separando asi 
        // el buscador de las recetas y los botones de forma horizontal
        children: [
          Row(
            children: [
              Expanded(

                // Caja de texto para el buscador
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

              // Caja vacia para separar el buscador de los 
              // botones de busqueda y filtro
              const SizedBox(width: 8),

              // // Boton de busqueda, antiguamente utilizado para buscar (xd)
              // // pero ahora no hace nada pq no le vi sentido
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
          
          // Caja vacia para separar el buscador de las recetas
          const SizedBox(height: 20),

          // Recetas destacadas y eso
          Expanded(
            // Se usa un SingleChildScrollView para permitir 
            // el scroll vertical desde cualquier parte de la pantalla
            child: SingleChildScrollView(
              // Se centra el contenido y se limita el ancho para 
              // que no se vea tan estirado en pantallas grandes
              child: Center(
                // Se usa un FutureBuilder para mostrar las recetas una vez
                // que se hayan cargado desde la base de datos
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: FutureBuilder<List<Receta>>(
                    future: recetasFuture,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final recetas = snapshot.data!;

                      // Creación de un GridView para mostrar las recetas en una cuadrícula
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
                              decoration: BoxDecoration(
                                color: Colors.orange[100],
                                borderRadius: BorderRadius.circular(16),
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
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}