import 'package:flutter/material.dart';

class Lists extends StatefulWidget {
  const Lists({super.key});

  @override
  State<Lists> createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  int globalItemCount = 500;
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
          //Boton de añadir
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    globalItemCount++;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 189, 89),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  minimumSize: const Size(240, 60),
                ),
                child: Text('Crear nueva lista', style: const TextStyle(
                  fontSize: 22, color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Listas y eso
          Expanded(
            child: ListView.separated(
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemCount: globalItemCount,
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
                        'Lista ${index + 1}',
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
