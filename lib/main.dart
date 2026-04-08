import 'package:flutter/material.dart';
import 'pages/lists.dart';
import 'pages/searcher.dart';
import 'pages/settings.dart';
import 'pages/mainmenu.dart';
import 'database/database.dart';

// Aqui se crea la base de datos y se insertan los datos iniciales antes de iniciar la aplicación
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final database = AppDatabase();

  // El que inserta los datos
  await database.cargarSiVacio();
  runApp(const MyApp());
}

// Aquí se define la estructura principal de la aplicación, 
// con un MaterialApp y un Scaffold que contiene un 
// BottomNavigationBar para navegar entre las diferentes páginas
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriIS',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 255, 189, 89),
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      home: const MyHomePage(title: 'NutriIS'),
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Aquí se maneja la navegación entre las 
// diferentes páginas usando un BottomNavigationBar
class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0; // Creacion del indice actual

  // Lista de páginas a mostrar según el indice seleccionado
  final List<Widget> _widgetOptions = [
    Mainmenu(),
    Searcher(),
    Lists(),
    Settings(),
  ];

  // Segun el indice seleccionado, se actualiza la página mostrada
  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Se muestra la página correspondiente al indice seleccionado
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: _widgetOptions,
      ),
      // Creación de la barra de navegación inferior
      bottomNavigationBar: BottomNavigationBar( 

        // Detalles del aspecto
        type: BottomNavigationBarType.shifting,
        currentIndex: currentIndex,
        selectedItemColor: const Color.fromARGB(255, 94, 91, 87),
        unselectedItemColor: Colors.white,

        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[

          // Item para la pagina principal
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Página principal',
            backgroundColor: Color.fromARGB(255, 255, 189, 89),
          ),

          // Item para el buscador
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscador',
            backgroundColor: Color.fromARGB(255, 255, 189, 89),
          ),

          // Item para las listas
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: 'Listas',
            backgroundColor: Color.fromARGB(255, 255, 189, 89),
          ),

          // Item para la configuración (aun falta implementar)
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
            backgroundColor: Color.fromARGB(255, 255, 189, 89),
          ),
        ],
      ),


      // Estp era pq era un diseño anterior, pero lo dejo 
      // comentado por si acaso
      // bottomNavigationBar: NavigationBar(
      //   selectedIndex: currentIndex,
      //   onDestinationSelected: _onItemTapped,
      //   backgroundColor: const Color.fromARGB(255, 255, 189, 89),
      //   destinations: const [
      //     NavigationDestination(
      //       icon: Icon(Icons.home),
      //       label: 'Página principal',
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.search),
      //       label: 'Buscador',
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.view_list),
      //       label: 'Listas',
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.settings),
      //       label: 'Configuración',
      //     ),
      //   ],
      // ),
    );
  }
}
