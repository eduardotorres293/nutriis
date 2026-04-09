import 'package:flutter/material.dart';
import '../database/database.dart';
import 'listdetail.dart';

class Lists extends StatefulWidget {
  const Lists({super.key});

  @override
  State<Lists> createState() => _ListsState();
}

class _ListsState extends State<Lists> {
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
                      // Reiniciar busquedas con el texto disponible
                      // es un bucle
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
          //Boton de crear lista
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                    final nombre = await mostrarDialogoCrearLista();
                    if (nombre != null && nombre.isNotEmpty) {
                      await db.crearLista(nombre);
                      setState((){
                        listasFuture = db.obtenerListas();
                      });
                    }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 189, 89),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  minimumSize: const Size(180, 60),
                ),
                child: Text('Crear nueva lista', style: const TextStyle(
                  fontSize: 18, color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Listas y eso
          Expanded(
            child: FutureBuilder<List<Lista>>(
            future: listasFuture,
            builder:(context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } 
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No hay listas aún"));
              }

              final listas = snapshot.data!;

              return ListView.separated(
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemCount: listas.length,
                itemBuilder: (context, index) {
                  final lista = listas[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetalleLista(listaId: lista.id, nombreLista: lista.nombre),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 120,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            lista.nombre,
                            style: const TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },),
          ),
        ],
      )
    );
  }
}
