import 'package:flutter/material.dart';
import '../database/database.dart';

class SeleccionarListaSheet extends StatefulWidget {
  final int recetaId;

  const SeleccionarListaSheet({super.key, required this.recetaId});

  @override
  State<SeleccionarListaSheet> createState() => _SeleccionarListaSheetState();
}

class _SeleccionarListaSheetState extends State<SeleccionarListaSheet> {
  late AppDatabase db;
  late Future<List<Lista>> listasFuture;

  @override
  void initState() {
    super.initState();
    db = AppDatabase();
    listasFuture = db.obtenerListas();
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
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, controller.text);
              },
              child: const Text("Crear"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          const Text(
            "Guardar en lista",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: FutureBuilder<List<Lista>>(
              future: listasFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final listas = snapshot.data!;

                return GridView.builder(
                  itemCount: listas.length + 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.5,
                  ),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return GestureDetector(
                        onTap: () async {
                          final nombre = await mostrarDialogoCrearLista();

                          if (nombre != null && nombre.isNotEmpty) {
                            await db.crearLista(nombre);

                            setState(() {
                              listasFuture = db.obtenerListas();
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange[50],
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color.fromARGB(255, 233, 182, 107),
                              width: 2,
                            ),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, size: 30, color: Color.fromARGB(255, 233, 182, 107)),
                              SizedBox(height: 8),
                              Text(
                                "Nueva lista",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final lista = listas[index - 1];

                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context, lista.id);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            lista.nombre,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}