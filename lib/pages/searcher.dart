import 'package:flutter/material.dart';

class Searcher extends StatefulWidget {
  const Searcher({super.key});

  @override
  State<Searcher> createState() => _SearcherState();
}

class _SearcherState extends State<Searcher> {
  int crossAxisCount = 2;
  List<String> recetas = List.generate(500, (i) => 'Receta ${i + 1}');
  List<String> recetasFiltradas = [];

  String categoriaSeleccionada = 'Todas';
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
    recetasFiltradas = recetas;
  }
  void filtrarRecetas() {
    List<String> resultado = recetas.where((receta) {
      final coincideBusqueda =
          receta.toLowerCase().contains(busqueda.toLowerCase());
      final coincideCategoria = categoriaSeleccionada == 'Todas'
          ? true
          : receta.contains(categoriaSeleccionada);

      return coincideBusqueda && coincideCategoria;
    }).toList();

    if (ordenSeleccionado == 'Tiempo') {
      resultado = resultado.reversed.toList();
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
                      final seleccionado = cat == categoriaSeleccionada;

                      return ChoiceChip(
                        label: Text(cat),
                        selected: seleccionado,
                        selectedColor: Colors.orange,
                        onSelected: (_) {
                          setModalState(() {
                            categoriaSeleccionada = cat;
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
                  )
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
                    seleccionarFiltros();
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

          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Categoría: $categoriaSeleccionada | Orden: $ordenSeleccionado',
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
                    maxCrossAxisExtent: 400,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                ),
              itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        recetasFiltradas[index],
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                } 
            )
            : ListView.separated(
                itemCount: recetasFiltradas.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 300,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          'Receta ${index + 1}',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      )
    );
  }
}