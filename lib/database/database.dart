import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class Recetas extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoriaId => integer().references(Categorias, #id)();
  TextColumn get nombre => text()();
  TextColumn get descripcion => text()();
  IntColumn get tiempo => integer()();
  BoolColumn get guardada => boolean().withDefault(const Constant(false))();
  TextColumn get imagen => text().nullable()();
}

class Categorias extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
}

class Ingredientes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get recetaId => integer().references(Recetas, #id)();
  TextColumn get nombre => text()();
  RealColumn get cantidad => real()();
  TextColumn get unidad => text()();
}

class Instrucciones extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get recetaId => integer().references(Recetas, #id)();
  IntColumn get numero => integer()();
  TextColumn get descripcion => text()();
}

class InfoNutrimental extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get recetaId => integer().unique().references(Recetas, #id)();
  RealColumn get calorias => real()();
  RealColumn get proteinas => real()();
  RealColumn get grasas => real()();
  RealColumn get carbohidratos => real()();
}

@DriftDatabase(
  tables: [Recetas, Categorias, Ingredientes, Instrucciones, InfoNutrimental],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Receta>> obtenerRecetas() {
    return select(recetas).get();
  }

  Future<List<Ingrediente>> obtenerIngredientes(int recetaId) {
    return (select(ingredientes)
          ..where((tbl) => tbl.recetaId.equals(recetaId)))
        .get();
  }

  Future<List<Instruccione>> obtenerInstrucciones(int recetaId) {
    return (select(instrucciones)
          ..where((tbl) => tbl.recetaId.equals(recetaId))
          ..orderBy([(t) => OrderingTerm(expression: t.numero)]))
        .get();
  }

  Future<InfoNutrimentalData?> obtenerInfo(int recetaId) {
    return (select(infoNutrimental)
          ..where((tbl) => tbl.recetaId.equals(recetaId)))
        .getSingleOrNull();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'nutriis.sqlite'));
    return NativeDatabase(file);
  });
}

extension JsonSeed on AppDatabase {
  Future<void> cargarDesdeJson() async {
    final jsonString = await rootBundle.loadString('lib/database/recetas.json');
    final List data = json.decode(jsonString);

    for (var recetaJson in data) {

      final categoriaNombre = recetaJson['categoria'];

      final categoriaExistente = await (select(categorias)
            ..where((c) => c.nombre.equals(categoriaNombre)))
          .getSingleOrNull();

      int categoriaId;

      if (categoriaExistente == null) {
        categoriaId = await into(categorias).insert(
          CategoriasCompanion(nombre: Value(categoriaNombre)),
        );
      } else {
        categoriaId = categoriaExistente.id;
      }

      final recetaId = await into(recetas).insert(
        RecetasCompanion(
          nombre: Value(recetaJson['nombre']),
          descripcion: Value(recetaJson['descripcion']),
          tiempo: Value(recetaJson['tiempo']),
          categoriaId: Value(categoriaId),
          imagen: Value(recetaJson['imagen']),
        ),
      );

      for (var ing in recetaJson['ingredientes']) {
        await into(ingredientes).insert(
          IngredientesCompanion(
            recetaId: Value(recetaId),
            nombre: Value(ing['nombre']),
            cantidad: Value((ing['cantidad'] as num).toDouble()),
            unidad: Value(ing['unidad']),
          ),
        );
      }

      for (var paso in recetaJson['instrucciones']) {
        await into(instrucciones).insert(
          InstruccionesCompanion(
            recetaId: Value(recetaId),
            numero: Value(paso['numero']),
            descripcion: Value(paso['descripcion']),
          ),
        );
      }

      final info = recetaJson['info'];

      await into(infoNutrimental).insert(
        InfoNutrimentalCompanion(
          recetaId: Value(recetaId),
          calorias: Value((info['calorias'] as num).toDouble()),
          proteinas: Value((info['proteinas'] as num).toDouble()),
          grasas: Value((info['grasas'] as num).toDouble()),
          carbohidratos: Value((info['carbohidratos'] as num).toDouble()),
        ),
      );
    }
  }

  Future<void> cargarSiVacio() async {
    final data = await select(recetas).get();
    if (data.isEmpty) {
      await cargarDesdeJson();
    }
  }
}

// extension SeedData on AppDatabase {
//   Future<void> insertarDatosIniciales() async {

//     final ensaladaId = await into(categorias).insert(
//       CategoriasCompanion(nombre: const Value("Ensaladas")),
//     );

//     final desayunoId = await into(categorias).insert(
//       CategoriasCompanion(nombre: const Value("Desayunos")),
//     );

//     final receta1Id = await into(recetas).insert(
//       RecetasCompanion(
//         nombre: const Value("Ensalada fresca"),
//         descripcion: const Value("Ligera y saludable"),
//         tiempo: const Value(10),
//         categoriaId: Value(ensaladaId),
//       ),
//     );

//     await batch((batch) {
//       batch.insertAll(ingredientes, [
//         IngredientesCompanion(
//           recetaId: Value(receta1Id),
//           nombre: const Value("Lechuga"),
//           cantidad: const Value(1),
//           unidad: const Value("taza"),
//         ),
//         IngredientesCompanion(
//           recetaId: Value(receta1Id),
//           nombre: const Value("Tomate"),
//           cantidad: const Value(2),
//           unidad: const Value("piezas"),
//         ),
//         IngredientesCompanion(
//           recetaId: Value(receta1Id),
//           nombre: const Value("Pepino"),
//           cantidad: const Value(0.5),
//           unidad: const Value("pieza"),
//         ),
//       ]);
//     });

//     await batch((batch) {
//       batch.insertAll(instrucciones, [
//         InstruccionesCompanion(
//           recetaId: Value(receta1Id),
//           numero: const Value(1),
//           descripcion: const Value("Lavar todos los ingredientes"),
//         ),
//         InstruccionesCompanion(
//           recetaId: Value(receta1Id),
//           numero: const Value(2),
//           descripcion: const Value("Cortar en trozos pequeños"),
//         ),
//         InstruccionesCompanion(
//           recetaId: Value(receta1Id),
//           numero: const Value(3),
//           descripcion: const Value("Mezclar en un bowl"),
//         ),
//       ]);
//     });

//     await into(infoNutrimental).insert(
//       InfoNutrimentalCompanion(
//         recetaId: Value(receta1Id),
//         calorias: const Value(150),
//         proteinas: const Value(5),
//         grasas: const Value(3),
//         carbohidratos: const Value(20),
//       ),
//     );

//     final receta2Id = await into(recetas).insert(
//       RecetasCompanion(
//         nombre: const Value("Huevos revueltos"),
//         descripcion: const Value("Desayuno rápido y nutritivo"),
//         tiempo: const Value(8),
//         categoriaId: Value(desayunoId),
//       ),
//     );

//     await batch((batch) {
//       batch.insertAll(ingredientes, [
//         IngredientesCompanion(
//           recetaId: Value(receta2Id),
//           nombre: const Value("Huevo"),
//           cantidad: const Value(2),
//           unidad: const Value("piezas"),
//         ),
//         IngredientesCompanion(
//           recetaId: Value(receta2Id),
//           nombre: const Value("Aceite"),
//           cantidad: const Value(1),
//           unidad: const Value("cucharada"),
//         ),
//         IngredientesCompanion(
//           recetaId: Value(receta2Id),
//           nombre: const Value("Sal"),
//           cantidad: const Value(1),
//           unidad: const Value("pizca"),
//         ),
//       ]);
//     });

//     await batch((batch) {
//       batch.insertAll(instrucciones, [
//         InstruccionesCompanion(
//           recetaId: Value(receta2Id),
//           numero: const Value(1),
//           descripcion: const Value("Batir los huevos"),
//         ),
//         InstruccionesCompanion(
//           recetaId: Value(receta2Id),
//           numero: const Value(2),
//           descripcion: const Value("Calentar sartén con aceite"),
//         ),
//         InstruccionesCompanion(
//           recetaId: Value(receta2Id),
//           numero: const Value(3),
//           descripcion: const Value("Cocinar y revolver"),
//         ),
//       ]);
//     });

//     await into(infoNutrimental).insert(
//       InfoNutrimentalCompanion(
//         recetaId: Value(receta2Id),
//         calorias: const Value(250),
//         proteinas: const Value(12),
//         grasas: const Value(18),
//         carbohidratos: const Value(2),
//       ),
//     );
//   }

//   Future<void> insertarSiVacio() async {
//     final data = await select(recetas).get();
//     if (data.isEmpty) {
//       await insertarDatosIniciales();
//     }
//   }
// }