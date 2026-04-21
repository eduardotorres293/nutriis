import 'package:flutter/material.dart';
import '../database/database.dart';
import 'recipedetail.dart';

class Searcher extends StatefulWidget {
  const Searcher({super.key});

  @override
  State<Searcher> createState() => _SearcherState();
}

class _SearcherState extends State<Searcher> {
  int crossAxisCount = 2;

  late List<Receta> todosRecetas = [];
  List<Receta> recetasFiltradas = [];
  // Se declara la variable para la base de datos
  late AppDatabase db;
  // Y se crea una lista para guardar las 
  // recetas obtenidas de la base de datos
  late Future<List<Receta>> recetasFuture;

  List<String> categoriasSeleccionadas = [];
  String ordenSeleccionado = 'Ninguno';
  String busqueda = '';

  List<String> categorias = 
  [
    'Todas', 
    'Desayuno', 
    'Almuerzo', 
    'Cena', 
    'Postre',
    'Vegano',
    'Carnivoro',
    'Vegetariano',
    'Bajas calorias',
  ];

  List<String> ordenes = 
  [
    'Ninguno',
    'Por nombre',
    'Tiempo de preparación',
    'Macronutrientes'
  ];


  @override
  void initState() {
    super.initState();
    db = AppDatabase();
    cargarRecetas();
  }

  Future<void> cargarRecetas() async {
    final recetas = await db.obtenerRecetas();
    setState(() {
      todosRecetas = recetas;
      recetasFiltradas = recetas;
    });
  }

  Future<void> filtrarRecetas() async {
    List<Receta> resultado = [];
    for (var receta in todosRecetas) {

      final coincideNombre = receta.nombre
        .toLowerCase()
        .contains(busqueda.toLowerCase());

      final ingredientes = await db.obtenerIngredientes(receta.id);
      final coincideIngrediente = ingredientes.any((ing) => 
        ing.nombre.toLowerCase().contains(busqueda.toLowerCase()));
      
      final categoriasReceta = await db.obtenerCategoriasDeReceta(receta.id);

      final coincideCategoria = categoriasSeleccionadas.isEmpty ||
          categoriasReceta.any((cat) =>
              categoriasSeleccionadas.contains(cat));

      if ((coincideNombre || coincideIngrediente) && coincideCategoria) {
        resultado.add(receta);
      }
    }

    if (ordenSeleccionado == 'Por nombre') {
      resultado.sort((a, b) => a.nombre.compareTo(b.nombre));
    }

    if (ordenSeleccionado == 'Tiempo de preparación') {
      resultado.sort((a, b) => a.tiempo.compareTo(b.tiempo));
    }

    setState(() {
      recetasFiltradas = resultado;
    });
  }

  void seleccionarFiltros() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(16),
              height: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Categoría",
                      style: TextStyle(fontWeight: FontWeight.bold)),

                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 8,
                    children: categorias.map((cat) {
                      final seleccionado = categoriasSeleccionadas.contains(cat);

                      return ChoiceChip(
                        label: Text(cat),
                        selected: seleccionado,
                        selectedColor: Colors.orange,
                        onSelected: (selected) {
                          setModalState(() {
                            if (selected) {
                              categoriasSeleccionadas.add(cat);
                            } else {
                              categoriasSeleccionadas.remove(cat);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),

                  const Text("Ordenar por",
                      style: TextStyle(fontWeight: FontWeight.bold)),

                  const SizedBox(height: 10),

                  DropdownButton<String>(
                    value: ordenSeleccionado == 'Ninguno'
                        ? null
                        : ordenSeleccionado,
                    hint: const Text("Seleccionar"),
                    isExpanded: true,
                    items: ordenes.map((ord) {
                      return DropdownMenuItem(
                        value: ord,
                        child: Text(ord),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setModalState(() {
                        ordenSeleccionado = value!;
                      });
                    },
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        filtrarRecetas();
                        Navigator.pop(context);
                      },
                      child: const Text("Aplicar filtros"),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
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
                    busqueda = value;
                    filtrarRecetas();
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
                  seleccionarFiltros();
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

              const SizedBox(width: 8),

              // Boton de vista
              IconButton(
                onPressed: () {
                  setState(() {
                    crossAxisCount = crossAxisCount == 2 ? 1 : 2;
                  });
                },
                icon: Icon(crossAxisCount == 2 ? Icons.view_agenda : Icons.view_cozy,),
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

          const SizedBox(height: 30),
          
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Categorías: ${categoriasSeleccionadas.isEmpty ? "Todas" : categoriasSeleccionadas.join(", ")} | Orden: $ordenSeleccionado',
              style: const TextStyle(fontSize: 12),
            ),
          ),

          const SizedBox(height: 10),

          // Recetas y eso
          Expanded(
            child: crossAxisCount == 2
          ? GridView.builder(
              itemCount: recetasFiltradas.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final receta = recetasFiltradas[index];
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
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                );
              }, 
            )
          : ListView.separated(
              itemCount: recetasFiltradas.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final receta = recetasFiltradas[index];
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
                    height: 300,
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
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}