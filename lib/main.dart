import 'package:flutter/material.dart';
import 'pages/lists.dart';
import 'pages/searcher.dart';
import 'pages/settings.dart';
import 'pages/mainmenu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriIS',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 255, 189, 89),
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

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Mainmenu(),
    Searcher(),
    Lists(),
    Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: currentIndex,
        selectedItemColor: const Color.fromARGB(255, 94, 91, 87),
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Página principal',
            backgroundColor: Color.fromARGB(255, 255, 189, 89),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscador',
            backgroundColor: Color.fromARGB(255, 255, 189, 89),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: 'Listas',
            backgroundColor: Color.fromARGB(255, 255, 189, 89),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
            backgroundColor: Color.fromARGB(255, 255, 189, 89),
          ),
        ],
      ),
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
