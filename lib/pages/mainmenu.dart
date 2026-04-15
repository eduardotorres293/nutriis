import 'package:flutter/material.dart';
import 'recipedetail.dart';
import '../database/database.dart';
import 'dart:math';

class ListaSugerida {
  final String nombre;
  final List<Receta> recetas;

  ListaSugerida({required this.nombre, required this.recetas});
}

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
  List<Receta> recetasRandom = [];
  List<ListaSugerida> listasSugeridas = [];

  Future<List<Receta>> cargarTodo() async {
    final recetas = await db.obtenerRecetas();

    recetas.shuffle(Random());

    recetasRandom = recetas.take(4).toList();

    List<ListaSugerida> nuevasListas = [];

    final configuraciones = [
      {"nombre": "Desayunos rápidos", "categoria": "Desayuno"},
      {"nombre": "Cena ligera", "categoria": "Cena"},
      {"nombre": "Opciones veganas", "categoria": "Vegano"},
      {"nombre": "Algo dulce", "categoria": "Postre"},
    ];

    for (var config in configuraciones) {
      List<Receta> filtradas = [];

      for (var receta in recetas) {
        final cats = await db.obtenerCategoriasDeReceta(receta.id);

        if (cats.contains(config["categoria"])) {
          filtradas.add(receta);
        }
      }

      filtradas.shuffle();

      if (filtradas.isNotEmpty) {
        nuevasListas.add(
          ListaSugerida(
            nombre: config["nombre"] as String,
            recetas: filtradas.take(4).toList(),
          ),
        );
      }
    }

    nuevasListas.shuffle();
    nuevasListas = nuevasListas.take(2).toList();

    setState(() {
      listasSugeridas = nuevasListas;
    });

    return recetas;
  }
  // En el initState se inicializa 
  // la base de datos y se obtiene la lista de recetas
  @override
  void initState() {
    super.initState();
    db = AppDatabase();
    recetasFuture = cargarTodo();
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
              child: Column(
                // Se usa un FutureBuilder para mostrar las recetas una vez
                // que se hayan cargado desde la base de datos
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'RECETAS DESTACADAS',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  GridView.builder(
                    itemCount: recetasRandom.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      final receta = recetasRandom[index];

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
                          padding: const EdgeInsets.all(4),
                          // Creación de un contenedor para cada receta
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
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'QUIZÁ PODRÍA INTERESARTE...',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Column(
                    children: listasSugeridas.map((lista) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // NOMBRE DE LA LISTA
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              lista.nombre,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          // RECETAS DE LA LISTA
                          SizedBox(
                            height: 140,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: lista.recetas.length,
                              separatorBuilder: (_, __) => const SizedBox(width: 10),
                              itemBuilder: (context, index) {
                                final receta = lista.recetas[index];

                                final imagen = (receta.imagenes != null && receta.imagenes!.isNotEmpty)
                                  ? receta.imagenes!.split(',').first
                                  : 'assets/images/default.jpg';

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => Recipedetail(id: receta.id),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      image: DecorationImage(
                                        image: AssetImage(imagen),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.black.withOpacity(0.3),
                                      ),
                                      child: Text(
                                        receta.nombre,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 10),
                        ],
                      );
                    }).toList(),
                  )
                ],
              )
            ),
          ),
        ],
      )
    );
  }
}