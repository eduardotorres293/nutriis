import 'package:flutter/material.dart';

class Searcher extends StatefulWidget {
  const Searcher({super.key});

  @override
  State<Searcher> createState() => _SearcherState();
}

class _SearcherState extends State<Searcher> {
  int crossAxisCount = 2;
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
                        'Buscar receta o ingrediente',
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
                const SizedBox(width: 8),
                // Boton de orden
                IconButton(
                  onPressed: () {
                    setState(() {
                    crossAxisCount = crossAxisCount == 2 ? 1 : 2;
                  });
                  },
                  icon: Icon(crossAxisCount == 2 ? Icons.view_agenda : Icons.view_cozy,),
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

          // Recetas y eso
          Expanded(
            
            child: crossAxisCount == 2
            ? GridView.builder(
                itemCount: globalItemCount,
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
                        'Receta ${index + 1}',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                } 
            )
            : ListView.separated(
                itemCount: globalItemCount,
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