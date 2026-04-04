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
                  child: Container(
                    height: 40, 
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Buscar lista o ingredientes',
                        style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 78, 73, 73)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Boton de busqueda
                IconButton(
                  onPressed: () {
                    print("Botón de búsqueda presionado");
                  },
                  icon: const Icon(Icons.search),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.orange[100],
                    minimumSize: const Size(40, 40),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Boton de filtro
                IconButton(
                  onPressed: () {
                    print("Filtro presionado");
                  },
                  icon: const Icon(Icons.filter_alt),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.orange[100],
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
                  backgroundColor: const Color.fromARGB(255, 230, 157, 47),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  minimumSize: const Size(240, 60),
                ),
                child: Text('Añadir lista', style: const TextStyle(
                  fontSize: 18, color: Color.fromARGB(255, 0, 0, 0),
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
