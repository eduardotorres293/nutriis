import 'package:flutter/material.dart';
import 'recipedetail.dart';
import '../database/database.dart';
import 'dart:math';
import 'settings.dart';

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
  List<Receta> resultadosBusqueda = [];
  String query = "";
  bool mostrandoBusqueda = false;

  // Se declara la variable para la base de datos
  late AppDatabase db;
  // Y se crea una lista para guardar las 
  // recetas obtenidas de la base de datos
  late Future<List<Receta>> recetasFuture;
  List<Receta> recetasRandom = [];
  List<ListaSugerida> listasSugeridas = [];

  Future<void> buscar(String texto) async {
    query = texto;

    if (texto.isEmpty) {
      setState(() {
        mostrandoBusqueda = false;
        resultadosBusqueda = [];
      });
      return;
    }

    final todas = await db.obtenerRecetas();
    List<Receta> resultados = [];

    for (var receta in todas) {
      // Buscar en nombre
      if (receta.nombre.toLowerCase().contains(texto.toLowerCase())) {
        resultados.add(receta);
        continue;
      }

      // Buscar en ingredientes
      final ingredientes = await db.obtenerIngredientes(receta.id);

      final coincideIngrediente = ingredientes.any((ing) =>
        ing.nombre.toLowerCase().contains(texto.toLowerCase())
      );

      if (coincideIngrediente) {
        resultados.add(receta);
      }
    }

    setState(() {
      resultadosBusqueda = resultados;
      mostrandoBusqueda = true;
    });
  }

  Future<void> _refrescar() async {
    await cargarTodo();
    setState(() {});
  }

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
      {"nombre": "Almuerzos completos", "categoria": "Almuerzo"},
      {"nombre": "Opciones vegetarianas", "categoria": "Vegetariano"},
      {"nombre": "Altas en proteína", "categoria": "Proteico"},
      {"nombre": "Bajas en calorías", "categoria": "Bajas calorias"},
      {"nombre": "Comida rápida", "categoria": "Rápido"},
      {"nombre": "Comida saludable", "categoria": "Saludable"},
      {"nombre": "Platillos con carne", "categoria": "Carnivoro"},
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
            recetas: filtradas.take(8).toList(),
          ),
        );
      }
    }

    nuevasListas.shuffle();
    nuevasListas = nuevasListas.take(3).toList();

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
    return ValueListenableBuilder<double>(
      valueListenable: FontSizeController.scale,
      builder: (context, scale, child) {
        return GestureDetector(
          onTap: () {
              FocusScope.of(context).unfocus();

              setState(() {
                mostrandoBusqueda = false;
              });
          },
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                // Creación de la columna principal 
                // que contiene el buscador y las recetas
                // EL column es para organizar elementos verticalmente
                child: Column(
                  children: [
                  // Dentro de la columna, se organizan los 
                  // elementos con un row para el buscador, separando asi 
                  // el buscador de las recetas y los botones de forma horizontal
                    Row(
                      children: [
                        Expanded(
                          // Caja de texto para el buscador
                          child: TextField(
                            onChanged: (value) {
                              buscar(value);
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
                      ],
                    ),
                    

                    // Caja vacia para separar el buscador de las recetas
                    const SizedBox(height: 20),
                    
                    // Recetas destacadas y eso
                    Expanded(
                      // Se usa un SingleChildScrollView para permitir 
                      // el scroll vertical desde cualquier parte de la pantalla
                      child: RefreshIndicator(
                        onRefresh: _refrescar,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          // Se centra el contenido y se limita el ancho para 
                          // que no se vea tan estirado en pantallas grandes
                          child: Column(
                            // Se usa un FutureBuilder para mostrar las recetas una vez
                            // que se hayan cargado desde la base de datos
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'RECETAS DESTACADAS',
                                style: TextStyle(
                                  fontSize: 20 * scale,
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
                                      // Creación de un contenedor para cada receta
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        image: DecorationImage(
                                          image: AssetImage(imagen),
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                      // Nombre de la receta centrado dentro del contenedor
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
                                          style: TextStyle(fontSize: 20 * scale, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 30),

                              Text(
                                'QUIZÁ PODRÍA INTERESARTE...',
                                style: TextStyle(fontSize: 20 * scale, fontWeight: FontWeight.bold),
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
                                          style: TextStyle(
                                            fontSize: 16 * scale,
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
                                                    style: TextStyle(fontSize: 20 * scale, color: Colors.white),
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (mostrandoBusqueda)
                Positioned(
                  top: 70,
                  left: 12,
                  right: 12,
                  child: Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 250),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: resultadosBusqueda.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: Text("Sin resultados")),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: resultadosBusqueda.length,
                        itemBuilder: (context, index) {
                          final receta = resultadosBusqueda[index];

                          final imagen = (receta.imagenes != null && receta.imagenes!.isNotEmpty)
                              ? receta.imagenes!.split(',').first
                              : 'assets/images/default.jpg';

                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image(
                                image: imagen.startsWith('http')
                                    ? NetworkImage(imagen)
                                    : AssetImage(imagen) as ImageProvider,
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(receta.nombre),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Recipedetail(id: receta.id),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}