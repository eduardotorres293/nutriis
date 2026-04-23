import 'package:flutter/material.dart';
import '../database/database.dart';
import 'listdetail.dart';
import 'settings.dart';

class Lists extends StatefulWidget {
  const Lists({super.key});

  @override
  State<Lists> createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  late AppDatabase db;
  late List<Lista> todasListas = [];
  List<Lista> listasFiltradas = [];
  String busqueda = '';

  Future<void> cargarListas() async {
    final listas = await db.obtenerListas();
    setState(() {
      todasListas = listas;
      listasFiltradas = listas;
    });
  }

  Future<void> filtrarListas() async {
    List<Lista> resultado = [];

    for (var lista in todasListas) {
      final coincideNombre = lista.nombre
          .toLowerCase()
          .contains(busqueda.toLowerCase());

      if (coincideNombre) {
        resultado.add(lista);
      }
    }

    setState(() {
      listasFiltradas = resultado;
    });
  }

  @override
  void initState() {
    super.initState();

    db = AppDatabase();
    cargarListas();
  }

  Future<String?> mostrarDialogoCrearLista() {
    TextEditingController controller = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Nueva lista"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: "Nombre de la lista",
              hintStyle: TextStyle(fontSize: 16)
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar", style: TextStyle(fontSize: 16))
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, controller.text);
              },
              child: const Text("Crear", style: TextStyle(fontSize: 16)),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: FontSizeController.scale,
      builder: (context, scale, child) {
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
                        filtrarListas();
                      },
                      decoration: InputDecoration(
                        hintText: 'Buscar nombre de lista o ingrediente',
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

              const SizedBox(height: 20),

              //Boton de crear lista
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                        final nombre = await mostrarDialogoCrearLista();
                        if (nombre != null && nombre.isNotEmpty) {
                          await db.crearLista(nombre);
                          await cargarListas();
                        }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 189, 89),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      minimumSize: const Size(180, 60),
                    ),
                    child: Text('Crear nueva lista', style: TextStyle(
                      fontSize: 18 * scale, color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Listas y eso
              Expanded(
                child: RefreshIndicator(
                    onRefresh: cargarListas,
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemCount: listasFiltradas.length,
                      itemBuilder: (context, index) {
                        final lista = listasFiltradas[index];

                        return GestureDetector(
                          onTap: () async{
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetalleLista(listaId: lista.id, nombreLista: lista.nombre),
                              ),
                            );

                            await cargarListas();
                          },
                          onLongPress: () async {
                            final confirmar = await showDialog<bool>(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Eliminar lista"),
                                  content: Text("¿Seguro que quieres eliminar '${lista.nombre}'?", style: TextStyle(fontSize: 16)),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, false),
                                      child: const Text("Cancelar", style: TextStyle(fontSize: 16)),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => Navigator.pop(context, true),
                                      child: const Text("Eliminar", style: TextStyle(fontSize: 16)),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (confirmar == true) {
                              await db.eliminarLista(lista.id);

                              await cargarListas();
                            }
                          },
                          child: SizedBox(
                            height: 330,
                            child: FutureBuilder<List<Receta>>(
                              future: db.obtenerRecetasDeLista(lista.id),
                              builder: (context, snapshotRecetas) {
                                if (!snapshotRecetas.hasData) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.orange[100],
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  );
                                }

                                final recetas = snapshotRecetas.data!.take(4).toList();

                                return Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: GridView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: recetas.length,
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                        ),
                                        itemBuilder: (context, i) {
                                          final receta = recetas[i];

                                          final imagen = (receta.imagenes != null &&
                                                  receta.imagenes!.isNotEmpty)
                                              ? receta.imagenes!.split(',').first
                                              : 'assets/images/default.jpg';

                                          return Image.asset(
                                            imagen,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),

                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.black.withOpacity(0.3),
                                      ),
                                    ),

                                    Center(
                                      child: Text(
                                        lista.nombre,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20 * scale,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        );
                      },
                    )
                  )
              )
            ]
          )
        );
      },
    );
  }
}
