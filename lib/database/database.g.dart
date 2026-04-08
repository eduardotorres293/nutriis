// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CategoriasTable extends Categorias
    with TableInfo<$CategoriasTable, Categoria> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nombre];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categorias';
  @override
  VerificationContext validateIntegrity(
    Insertable<Categoria> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Categoria map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Categoria(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
    );
  }

  @override
  $CategoriasTable createAlias(String alias) {
    return $CategoriasTable(attachedDatabase, alias);
  }
}

class Categoria extends DataClass implements Insertable<Categoria> {
  final int id;
  final String nombre;
  const Categoria({required this.id, required this.nombre});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    return map;
  }

  CategoriasCompanion toCompanion(bool nullToAbsent) {
    return CategoriasCompanion(id: Value(id), nombre: Value(nombre));
  }

  factory Categoria.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Categoria(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
    };
  }

  Categoria copyWith({int? id, String? nombre}) =>
      Categoria(id: id ?? this.id, nombre: nombre ?? this.nombre);
  Categoria copyWithCompanion(CategoriasCompanion data) {
    return Categoria(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Categoria(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Categoria &&
          other.id == this.id &&
          other.nombre == this.nombre);
}

class CategoriasCompanion extends UpdateCompanion<Categoria> {
  final Value<int> id;
  final Value<String> nombre;
  const CategoriasCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
  });
  CategoriasCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
  }) : nombre = Value(nombre);
  static Insertable<Categoria> custom({
    Expression<int>? id,
    Expression<String>? nombre,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
    });
  }

  CategoriasCompanion copyWith({Value<int>? id, Value<String>? nombre}) {
    return CategoriasCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriasCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }
}

class $RecetasTable extends Recetas with TableInfo<$RecetasTable, Receta> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecetasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _categoriaIdMeta = const VerificationMeta(
    'categoriaId',
  );
  @override
  late final GeneratedColumn<int> categoriaId = GeneratedColumn<int>(
    'categoria_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categorias (id)',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tiempoMeta = const VerificationMeta('tiempo');
  @override
  late final GeneratedColumn<int> tiempo = GeneratedColumn<int>(
    'tiempo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _guardadaMeta = const VerificationMeta(
    'guardada',
  );
  @override
  late final GeneratedColumn<bool> guardada = GeneratedColumn<bool>(
    'guardada',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("guardada" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _imagenMeta = const VerificationMeta('imagen');
  @override
  late final GeneratedColumn<String> imagen = GeneratedColumn<String>(
    'imagen',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoriaId,
    nombre,
    descripcion,
    tiempo,
    guardada,
    imagen,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recetas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Receta> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('categoria_id')) {
      context.handle(
        _categoriaIdMeta,
        categoriaId.isAcceptableOrUnknown(
          data['categoria_id']!,
          _categoriaIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_categoriaIdMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('tiempo')) {
      context.handle(
        _tiempoMeta,
        tiempo.isAcceptableOrUnknown(data['tiempo']!, _tiempoMeta),
      );
    } else if (isInserting) {
      context.missing(_tiempoMeta);
    }
    if (data.containsKey('guardada')) {
      context.handle(
        _guardadaMeta,
        guardada.isAcceptableOrUnknown(data['guardada']!, _guardadaMeta),
      );
    }
    if (data.containsKey('imagen')) {
      context.handle(
        _imagenMeta,
        imagen.isAcceptableOrUnknown(data['imagen']!, _imagenMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Receta map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Receta(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      categoriaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}categoria_id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
      tiempo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tiempo'],
      )!,
      guardada: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}guardada'],
      )!,
      imagen: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}imagen'],
      ),
    );
  }

  @override
  $RecetasTable createAlias(String alias) {
    return $RecetasTable(attachedDatabase, alias);
  }
}

class Receta extends DataClass implements Insertable<Receta> {
  final int id;
  final int categoriaId;
  final String nombre;
  final String descripcion;
  final int tiempo;
  final bool guardada;
  final String? imagen;
  const Receta({
    required this.id,
    required this.categoriaId,
    required this.nombre,
    required this.descripcion,
    required this.tiempo,
    required this.guardada,
    this.imagen,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['categoria_id'] = Variable<int>(categoriaId);
    map['nombre'] = Variable<String>(nombre);
    map['descripcion'] = Variable<String>(descripcion);
    map['tiempo'] = Variable<int>(tiempo);
    map['guardada'] = Variable<bool>(guardada);
    if (!nullToAbsent || imagen != null) {
      map['imagen'] = Variable<String>(imagen);
    }
    return map;
  }

  RecetasCompanion toCompanion(bool nullToAbsent) {
    return RecetasCompanion(
      id: Value(id),
      categoriaId: Value(categoriaId),
      nombre: Value(nombre),
      descripcion: Value(descripcion),
      tiempo: Value(tiempo),
      guardada: Value(guardada),
      imagen: imagen == null && nullToAbsent
          ? const Value.absent()
          : Value(imagen),
    );
  }

  factory Receta.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Receta(
      id: serializer.fromJson<int>(json['id']),
      categoriaId: serializer.fromJson<int>(json['categoriaId']),
      nombre: serializer.fromJson<String>(json['nombre']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      tiempo: serializer.fromJson<int>(json['tiempo']),
      guardada: serializer.fromJson<bool>(json['guardada']),
      imagen: serializer.fromJson<String?>(json['imagen']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoriaId': serializer.toJson<int>(categoriaId),
      'nombre': serializer.toJson<String>(nombre),
      'descripcion': serializer.toJson<String>(descripcion),
      'tiempo': serializer.toJson<int>(tiempo),
      'guardada': serializer.toJson<bool>(guardada),
      'imagen': serializer.toJson<String?>(imagen),
    };
  }

  Receta copyWith({
    int? id,
    int? categoriaId,
    String? nombre,
    String? descripcion,
    int? tiempo,
    bool? guardada,
    Value<String?> imagen = const Value.absent(),
  }) => Receta(
    id: id ?? this.id,
    categoriaId: categoriaId ?? this.categoriaId,
    nombre: nombre ?? this.nombre,
    descripcion: descripcion ?? this.descripcion,
    tiempo: tiempo ?? this.tiempo,
    guardada: guardada ?? this.guardada,
    imagen: imagen.present ? imagen.value : this.imagen,
  );
  Receta copyWithCompanion(RecetasCompanion data) {
    return Receta(
      id: data.id.present ? data.id.value : this.id,
      categoriaId: data.categoriaId.present
          ? data.categoriaId.value
          : this.categoriaId,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      tiempo: data.tiempo.present ? data.tiempo.value : this.tiempo,
      guardada: data.guardada.present ? data.guardada.value : this.guardada,
      imagen: data.imagen.present ? data.imagen.value : this.imagen,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Receta(')
          ..write('id: $id, ')
          ..write('categoriaId: $categoriaId, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('tiempo: $tiempo, ')
          ..write('guardada: $guardada, ')
          ..write('imagen: $imagen')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    categoriaId,
    nombre,
    descripcion,
    tiempo,
    guardada,
    imagen,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Receta &&
          other.id == this.id &&
          other.categoriaId == this.categoriaId &&
          other.nombre == this.nombre &&
          other.descripcion == this.descripcion &&
          other.tiempo == this.tiempo &&
          other.guardada == this.guardada &&
          other.imagen == this.imagen);
}

class RecetasCompanion extends UpdateCompanion<Receta> {
  final Value<int> id;
  final Value<int> categoriaId;
  final Value<String> nombre;
  final Value<String> descripcion;
  final Value<int> tiempo;
  final Value<bool> guardada;
  final Value<String?> imagen;
  const RecetasCompanion({
    this.id = const Value.absent(),
    this.categoriaId = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.tiempo = const Value.absent(),
    this.guardada = const Value.absent(),
    this.imagen = const Value.absent(),
  });
  RecetasCompanion.insert({
    this.id = const Value.absent(),
    required int categoriaId,
    required String nombre,
    required String descripcion,
    required int tiempo,
    this.guardada = const Value.absent(),
    this.imagen = const Value.absent(),
  }) : categoriaId = Value(categoriaId),
       nombre = Value(nombre),
       descripcion = Value(descripcion),
       tiempo = Value(tiempo);
  static Insertable<Receta> custom({
    Expression<int>? id,
    Expression<int>? categoriaId,
    Expression<String>? nombre,
    Expression<String>? descripcion,
    Expression<int>? tiempo,
    Expression<bool>? guardada,
    Expression<String>? imagen,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoriaId != null) 'categoria_id': categoriaId,
      if (nombre != null) 'nombre': nombre,
      if (descripcion != null) 'descripcion': descripcion,
      if (tiempo != null) 'tiempo': tiempo,
      if (guardada != null) 'guardada': guardada,
      if (imagen != null) 'imagen': imagen,
    });
  }

  RecetasCompanion copyWith({
    Value<int>? id,
    Value<int>? categoriaId,
    Value<String>? nombre,
    Value<String>? descripcion,
    Value<int>? tiempo,
    Value<bool>? guardada,
    Value<String?>? imagen,
  }) {
    return RecetasCompanion(
      id: id ?? this.id,
      categoriaId: categoriaId ?? this.categoriaId,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      tiempo: tiempo ?? this.tiempo,
      guardada: guardada ?? this.guardada,
      imagen: imagen ?? this.imagen,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoriaId.present) {
      map['categoria_id'] = Variable<int>(categoriaId.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (tiempo.present) {
      map['tiempo'] = Variable<int>(tiempo.value);
    }
    if (guardada.present) {
      map['guardada'] = Variable<bool>(guardada.value);
    }
    if (imagen.present) {
      map['imagen'] = Variable<String>(imagen.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecetasCompanion(')
          ..write('id: $id, ')
          ..write('categoriaId: $categoriaId, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('tiempo: $tiempo, ')
          ..write('guardada: $guardada, ')
          ..write('imagen: $imagen')
          ..write(')'))
        .toString();
  }
}

class $IngredientesTable extends Ingredientes
    with TableInfo<$IngredientesTable, Ingrediente> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IngredientesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _recetaIdMeta = const VerificationMeta(
    'recetaId',
  );
  @override
  late final GeneratedColumn<int> recetaId = GeneratedColumn<int>(
    'receta_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recetas (id)',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cantidadMeta = const VerificationMeta(
    'cantidad',
  );
  @override
  late final GeneratedColumn<double> cantidad = GeneratedColumn<double>(
    'cantidad',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unidadMeta = const VerificationMeta('unidad');
  @override
  late final GeneratedColumn<String> unidad = GeneratedColumn<String>(
    'unidad',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recetaId,
    nombre,
    cantidad,
    unidad,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ingredientes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Ingrediente> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('receta_id')) {
      context.handle(
        _recetaIdMeta,
        recetaId.isAcceptableOrUnknown(data['receta_id']!, _recetaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recetaIdMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(
        _cantidadMeta,
        cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta),
      );
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('unidad')) {
      context.handle(
        _unidadMeta,
        unidad.isAcceptableOrUnknown(data['unidad']!, _unidadMeta),
      );
    } else if (isInserting) {
      context.missing(_unidadMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ingrediente map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ingrediente(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      recetaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}receta_id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      cantidad: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cantidad'],
      )!,
      unidad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unidad'],
      )!,
    );
  }

  @override
  $IngredientesTable createAlias(String alias) {
    return $IngredientesTable(attachedDatabase, alias);
  }
}

class Ingrediente extends DataClass implements Insertable<Ingrediente> {
  final int id;
  final int recetaId;
  final String nombre;
  final double cantidad;
  final String unidad;
  const Ingrediente({
    required this.id,
    required this.recetaId,
    required this.nombre,
    required this.cantidad,
    required this.unidad,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['receta_id'] = Variable<int>(recetaId);
    map['nombre'] = Variable<String>(nombre);
    map['cantidad'] = Variable<double>(cantidad);
    map['unidad'] = Variable<String>(unidad);
    return map;
  }

  IngredientesCompanion toCompanion(bool nullToAbsent) {
    return IngredientesCompanion(
      id: Value(id),
      recetaId: Value(recetaId),
      nombre: Value(nombre),
      cantidad: Value(cantidad),
      unidad: Value(unidad),
    );
  }

  factory Ingrediente.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ingrediente(
      id: serializer.fromJson<int>(json['id']),
      recetaId: serializer.fromJson<int>(json['recetaId']),
      nombre: serializer.fromJson<String>(json['nombre']),
      cantidad: serializer.fromJson<double>(json['cantidad']),
      unidad: serializer.fromJson<String>(json['unidad']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recetaId': serializer.toJson<int>(recetaId),
      'nombre': serializer.toJson<String>(nombre),
      'cantidad': serializer.toJson<double>(cantidad),
      'unidad': serializer.toJson<String>(unidad),
    };
  }

  Ingrediente copyWith({
    int? id,
    int? recetaId,
    String? nombre,
    double? cantidad,
    String? unidad,
  }) => Ingrediente(
    id: id ?? this.id,
    recetaId: recetaId ?? this.recetaId,
    nombre: nombre ?? this.nombre,
    cantidad: cantidad ?? this.cantidad,
    unidad: unidad ?? this.unidad,
  );
  Ingrediente copyWithCompanion(IngredientesCompanion data) {
    return Ingrediente(
      id: data.id.present ? data.id.value : this.id,
      recetaId: data.recetaId.present ? data.recetaId.value : this.recetaId,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      unidad: data.unidad.present ? data.unidad.value : this.unidad,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ingrediente(')
          ..write('id: $id, ')
          ..write('recetaId: $recetaId, ')
          ..write('nombre: $nombre, ')
          ..write('cantidad: $cantidad, ')
          ..write('unidad: $unidad')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, recetaId, nombre, cantidad, unidad);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ingrediente &&
          other.id == this.id &&
          other.recetaId == this.recetaId &&
          other.nombre == this.nombre &&
          other.cantidad == this.cantidad &&
          other.unidad == this.unidad);
}

class IngredientesCompanion extends UpdateCompanion<Ingrediente> {
  final Value<int> id;
  final Value<int> recetaId;
  final Value<String> nombre;
  final Value<double> cantidad;
  final Value<String> unidad;
  const IngredientesCompanion({
    this.id = const Value.absent(),
    this.recetaId = const Value.absent(),
    this.nombre = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.unidad = const Value.absent(),
  });
  IngredientesCompanion.insert({
    this.id = const Value.absent(),
    required int recetaId,
    required String nombre,
    required double cantidad,
    required String unidad,
  }) : recetaId = Value(recetaId),
       nombre = Value(nombre),
       cantidad = Value(cantidad),
       unidad = Value(unidad);
  static Insertable<Ingrediente> custom({
    Expression<int>? id,
    Expression<int>? recetaId,
    Expression<String>? nombre,
    Expression<double>? cantidad,
    Expression<String>? unidad,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recetaId != null) 'receta_id': recetaId,
      if (nombre != null) 'nombre': nombre,
      if (cantidad != null) 'cantidad': cantidad,
      if (unidad != null) 'unidad': unidad,
    });
  }

  IngredientesCompanion copyWith({
    Value<int>? id,
    Value<int>? recetaId,
    Value<String>? nombre,
    Value<double>? cantidad,
    Value<String>? unidad,
  }) {
    return IngredientesCompanion(
      id: id ?? this.id,
      recetaId: recetaId ?? this.recetaId,
      nombre: nombre ?? this.nombre,
      cantidad: cantidad ?? this.cantidad,
      unidad: unidad ?? this.unidad,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recetaId.present) {
      map['receta_id'] = Variable<int>(recetaId.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<double>(cantidad.value);
    }
    if (unidad.present) {
      map['unidad'] = Variable<String>(unidad.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IngredientesCompanion(')
          ..write('id: $id, ')
          ..write('recetaId: $recetaId, ')
          ..write('nombre: $nombre, ')
          ..write('cantidad: $cantidad, ')
          ..write('unidad: $unidad')
          ..write(')'))
        .toString();
  }
}

class $InstruccionesTable extends Instrucciones
    with TableInfo<$InstruccionesTable, Instruccione> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InstruccionesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _recetaIdMeta = const VerificationMeta(
    'recetaId',
  );
  @override
  late final GeneratedColumn<int> recetaId = GeneratedColumn<int>(
    'receta_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recetas (id)',
    ),
  );
  static const VerificationMeta _numeroMeta = const VerificationMeta('numero');
  @override
  late final GeneratedColumn<int> numero = GeneratedColumn<int>(
    'numero',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, recetaId, numero, descripcion];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'instrucciones';
  @override
  VerificationContext validateIntegrity(
    Insertable<Instruccione> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('receta_id')) {
      context.handle(
        _recetaIdMeta,
        recetaId.isAcceptableOrUnknown(data['receta_id']!, _recetaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recetaIdMeta);
    }
    if (data.containsKey('numero')) {
      context.handle(
        _numeroMeta,
        numero.isAcceptableOrUnknown(data['numero']!, _numeroMeta),
      );
    } else if (isInserting) {
      context.missing(_numeroMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Instruccione map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Instruccione(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      recetaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}receta_id'],
      )!,
      numero: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}numero'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
    );
  }

  @override
  $InstruccionesTable createAlias(String alias) {
    return $InstruccionesTable(attachedDatabase, alias);
  }
}

class Instruccione extends DataClass implements Insertable<Instruccione> {
  final int id;
  final int recetaId;
  final int numero;
  final String descripcion;
  const Instruccione({
    required this.id,
    required this.recetaId,
    required this.numero,
    required this.descripcion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['receta_id'] = Variable<int>(recetaId);
    map['numero'] = Variable<int>(numero);
    map['descripcion'] = Variable<String>(descripcion);
    return map;
  }

  InstruccionesCompanion toCompanion(bool nullToAbsent) {
    return InstruccionesCompanion(
      id: Value(id),
      recetaId: Value(recetaId),
      numero: Value(numero),
      descripcion: Value(descripcion),
    );
  }

  factory Instruccione.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Instruccione(
      id: serializer.fromJson<int>(json['id']),
      recetaId: serializer.fromJson<int>(json['recetaId']),
      numero: serializer.fromJson<int>(json['numero']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recetaId': serializer.toJson<int>(recetaId),
      'numero': serializer.toJson<int>(numero),
      'descripcion': serializer.toJson<String>(descripcion),
    };
  }

  Instruccione copyWith({
    int? id,
    int? recetaId,
    int? numero,
    String? descripcion,
  }) => Instruccione(
    id: id ?? this.id,
    recetaId: recetaId ?? this.recetaId,
    numero: numero ?? this.numero,
    descripcion: descripcion ?? this.descripcion,
  );
  Instruccione copyWithCompanion(InstruccionesCompanion data) {
    return Instruccione(
      id: data.id.present ? data.id.value : this.id,
      recetaId: data.recetaId.present ? data.recetaId.value : this.recetaId,
      numero: data.numero.present ? data.numero.value : this.numero,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Instruccione(')
          ..write('id: $id, ')
          ..write('recetaId: $recetaId, ')
          ..write('numero: $numero, ')
          ..write('descripcion: $descripcion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, recetaId, numero, descripcion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Instruccione &&
          other.id == this.id &&
          other.recetaId == this.recetaId &&
          other.numero == this.numero &&
          other.descripcion == this.descripcion);
}

class InstruccionesCompanion extends UpdateCompanion<Instruccione> {
  final Value<int> id;
  final Value<int> recetaId;
  final Value<int> numero;
  final Value<String> descripcion;
  const InstruccionesCompanion({
    this.id = const Value.absent(),
    this.recetaId = const Value.absent(),
    this.numero = const Value.absent(),
    this.descripcion = const Value.absent(),
  });
  InstruccionesCompanion.insert({
    this.id = const Value.absent(),
    required int recetaId,
    required int numero,
    required String descripcion,
  }) : recetaId = Value(recetaId),
       numero = Value(numero),
       descripcion = Value(descripcion);
  static Insertable<Instruccione> custom({
    Expression<int>? id,
    Expression<int>? recetaId,
    Expression<int>? numero,
    Expression<String>? descripcion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recetaId != null) 'receta_id': recetaId,
      if (numero != null) 'numero': numero,
      if (descripcion != null) 'descripcion': descripcion,
    });
  }

  InstruccionesCompanion copyWith({
    Value<int>? id,
    Value<int>? recetaId,
    Value<int>? numero,
    Value<String>? descripcion,
  }) {
    return InstruccionesCompanion(
      id: id ?? this.id,
      recetaId: recetaId ?? this.recetaId,
      numero: numero ?? this.numero,
      descripcion: descripcion ?? this.descripcion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recetaId.present) {
      map['receta_id'] = Variable<int>(recetaId.value);
    }
    if (numero.present) {
      map['numero'] = Variable<int>(numero.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InstruccionesCompanion(')
          ..write('id: $id, ')
          ..write('recetaId: $recetaId, ')
          ..write('numero: $numero, ')
          ..write('descripcion: $descripcion')
          ..write(')'))
        .toString();
  }
}

class $InfoNutrimentalTable extends InfoNutrimental
    with TableInfo<$InfoNutrimentalTable, InfoNutrimentalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InfoNutrimentalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _recetaIdMeta = const VerificationMeta(
    'recetaId',
  );
  @override
  late final GeneratedColumn<int> recetaId = GeneratedColumn<int>(
    'receta_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES recetas (id)',
    ),
  );
  static const VerificationMeta _caloriasMeta = const VerificationMeta(
    'calorias',
  );
  @override
  late final GeneratedColumn<double> calorias = GeneratedColumn<double>(
    'calorias',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinasMeta = const VerificationMeta(
    'proteinas',
  );
  @override
  late final GeneratedColumn<double> proteinas = GeneratedColumn<double>(
    'proteinas',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _grasasMeta = const VerificationMeta('grasas');
  @override
  late final GeneratedColumn<double> grasas = GeneratedColumn<double>(
    'grasas',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbohidratosMeta = const VerificationMeta(
    'carbohidratos',
  );
  @override
  late final GeneratedColumn<double> carbohidratos = GeneratedColumn<double>(
    'carbohidratos',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recetaId,
    calorias,
    proteinas,
    grasas,
    carbohidratos,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'info_nutrimental';
  @override
  VerificationContext validateIntegrity(
    Insertable<InfoNutrimentalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('receta_id')) {
      context.handle(
        _recetaIdMeta,
        recetaId.isAcceptableOrUnknown(data['receta_id']!, _recetaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recetaIdMeta);
    }
    if (data.containsKey('calorias')) {
      context.handle(
        _caloriasMeta,
        calorias.isAcceptableOrUnknown(data['calorias']!, _caloriasMeta),
      );
    } else if (isInserting) {
      context.missing(_caloriasMeta);
    }
    if (data.containsKey('proteinas')) {
      context.handle(
        _proteinasMeta,
        proteinas.isAcceptableOrUnknown(data['proteinas']!, _proteinasMeta),
      );
    } else if (isInserting) {
      context.missing(_proteinasMeta);
    }
    if (data.containsKey('grasas')) {
      context.handle(
        _grasasMeta,
        grasas.isAcceptableOrUnknown(data['grasas']!, _grasasMeta),
      );
    } else if (isInserting) {
      context.missing(_grasasMeta);
    }
    if (data.containsKey('carbohidratos')) {
      context.handle(
        _carbohidratosMeta,
        carbohidratos.isAcceptableOrUnknown(
          data['carbohidratos']!,
          _carbohidratosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_carbohidratosMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InfoNutrimentalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InfoNutrimentalData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      recetaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}receta_id'],
      )!,
      calorias: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calorias'],
      )!,
      proteinas: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}proteinas'],
      )!,
      grasas: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}grasas'],
      )!,
      carbohidratos: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbohidratos'],
      )!,
    );
  }

  @override
  $InfoNutrimentalTable createAlias(String alias) {
    return $InfoNutrimentalTable(attachedDatabase, alias);
  }
}

class InfoNutrimentalData extends DataClass
    implements Insertable<InfoNutrimentalData> {
  final int id;
  final int recetaId;
  final double calorias;
  final double proteinas;
  final double grasas;
  final double carbohidratos;
  const InfoNutrimentalData({
    required this.id,
    required this.recetaId,
    required this.calorias,
    required this.proteinas,
    required this.grasas,
    required this.carbohidratos,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['receta_id'] = Variable<int>(recetaId);
    map['calorias'] = Variable<double>(calorias);
    map['proteinas'] = Variable<double>(proteinas);
    map['grasas'] = Variable<double>(grasas);
    map['carbohidratos'] = Variable<double>(carbohidratos);
    return map;
  }

  InfoNutrimentalCompanion toCompanion(bool nullToAbsent) {
    return InfoNutrimentalCompanion(
      id: Value(id),
      recetaId: Value(recetaId),
      calorias: Value(calorias),
      proteinas: Value(proteinas),
      grasas: Value(grasas),
      carbohidratos: Value(carbohidratos),
    );
  }

  factory InfoNutrimentalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InfoNutrimentalData(
      id: serializer.fromJson<int>(json['id']),
      recetaId: serializer.fromJson<int>(json['recetaId']),
      calorias: serializer.fromJson<double>(json['calorias']),
      proteinas: serializer.fromJson<double>(json['proteinas']),
      grasas: serializer.fromJson<double>(json['grasas']),
      carbohidratos: serializer.fromJson<double>(json['carbohidratos']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recetaId': serializer.toJson<int>(recetaId),
      'calorias': serializer.toJson<double>(calorias),
      'proteinas': serializer.toJson<double>(proteinas),
      'grasas': serializer.toJson<double>(grasas),
      'carbohidratos': serializer.toJson<double>(carbohidratos),
    };
  }

  InfoNutrimentalData copyWith({
    int? id,
    int? recetaId,
    double? calorias,
    double? proteinas,
    double? grasas,
    double? carbohidratos,
  }) => InfoNutrimentalData(
    id: id ?? this.id,
    recetaId: recetaId ?? this.recetaId,
    calorias: calorias ?? this.calorias,
    proteinas: proteinas ?? this.proteinas,
    grasas: grasas ?? this.grasas,
    carbohidratos: carbohidratos ?? this.carbohidratos,
  );
  InfoNutrimentalData copyWithCompanion(InfoNutrimentalCompanion data) {
    return InfoNutrimentalData(
      id: data.id.present ? data.id.value : this.id,
      recetaId: data.recetaId.present ? data.recetaId.value : this.recetaId,
      calorias: data.calorias.present ? data.calorias.value : this.calorias,
      proteinas: data.proteinas.present ? data.proteinas.value : this.proteinas,
      grasas: data.grasas.present ? data.grasas.value : this.grasas,
      carbohidratos: data.carbohidratos.present
          ? data.carbohidratos.value
          : this.carbohidratos,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InfoNutrimentalData(')
          ..write('id: $id, ')
          ..write('recetaId: $recetaId, ')
          ..write('calorias: $calorias, ')
          ..write('proteinas: $proteinas, ')
          ..write('grasas: $grasas, ')
          ..write('carbohidratos: $carbohidratos')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, recetaId, calorias, proteinas, grasas, carbohidratos);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InfoNutrimentalData &&
          other.id == this.id &&
          other.recetaId == this.recetaId &&
          other.calorias == this.calorias &&
          other.proteinas == this.proteinas &&
          other.grasas == this.grasas &&
          other.carbohidratos == this.carbohidratos);
}

class InfoNutrimentalCompanion extends UpdateCompanion<InfoNutrimentalData> {
  final Value<int> id;
  final Value<int> recetaId;
  final Value<double> calorias;
  final Value<double> proteinas;
  final Value<double> grasas;
  final Value<double> carbohidratos;
  const InfoNutrimentalCompanion({
    this.id = const Value.absent(),
    this.recetaId = const Value.absent(),
    this.calorias = const Value.absent(),
    this.proteinas = const Value.absent(),
    this.grasas = const Value.absent(),
    this.carbohidratos = const Value.absent(),
  });
  InfoNutrimentalCompanion.insert({
    this.id = const Value.absent(),
    required int recetaId,
    required double calorias,
    required double proteinas,
    required double grasas,
    required double carbohidratos,
  }) : recetaId = Value(recetaId),
       calorias = Value(calorias),
       proteinas = Value(proteinas),
       grasas = Value(grasas),
       carbohidratos = Value(carbohidratos);
  static Insertable<InfoNutrimentalData> custom({
    Expression<int>? id,
    Expression<int>? recetaId,
    Expression<double>? calorias,
    Expression<double>? proteinas,
    Expression<double>? grasas,
    Expression<double>? carbohidratos,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recetaId != null) 'receta_id': recetaId,
      if (calorias != null) 'calorias': calorias,
      if (proteinas != null) 'proteinas': proteinas,
      if (grasas != null) 'grasas': grasas,
      if (carbohidratos != null) 'carbohidratos': carbohidratos,
    });
  }

  InfoNutrimentalCompanion copyWith({
    Value<int>? id,
    Value<int>? recetaId,
    Value<double>? calorias,
    Value<double>? proteinas,
    Value<double>? grasas,
    Value<double>? carbohidratos,
  }) {
    return InfoNutrimentalCompanion(
      id: id ?? this.id,
      recetaId: recetaId ?? this.recetaId,
      calorias: calorias ?? this.calorias,
      proteinas: proteinas ?? this.proteinas,
      grasas: grasas ?? this.grasas,
      carbohidratos: carbohidratos ?? this.carbohidratos,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recetaId.present) {
      map['receta_id'] = Variable<int>(recetaId.value);
    }
    if (calorias.present) {
      map['calorias'] = Variable<double>(calorias.value);
    }
    if (proteinas.present) {
      map['proteinas'] = Variable<double>(proteinas.value);
    }
    if (grasas.present) {
      map['grasas'] = Variable<double>(grasas.value);
    }
    if (carbohidratos.present) {
      map['carbohidratos'] = Variable<double>(carbohidratos.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InfoNutrimentalCompanion(')
          ..write('id: $id, ')
          ..write('recetaId: $recetaId, ')
          ..write('calorias: $calorias, ')
          ..write('proteinas: $proteinas, ')
          ..write('grasas: $grasas, ')
          ..write('carbohidratos: $carbohidratos')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoriasTable categorias = $CategoriasTable(this);
  late final $RecetasTable recetas = $RecetasTable(this);
  late final $IngredientesTable ingredientes = $IngredientesTable(this);
  late final $InstruccionesTable instrucciones = $InstruccionesTable(this);
  late final $InfoNutrimentalTable infoNutrimental = $InfoNutrimentalTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categorias,
    recetas,
    ingredientes,
    instrucciones,
    infoNutrimental,
  ];
}

typedef $$CategoriasTableCreateCompanionBuilder =
    CategoriasCompanion Function({Value<int> id, required String nombre});
typedef $$CategoriasTableUpdateCompanionBuilder =
    CategoriasCompanion Function({Value<int> id, Value<String> nombre});

final class $$CategoriasTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriasTable, Categoria> {
  $$CategoriasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RecetasTable, List<Receta>> _recetasRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.recetas,
    aliasName: $_aliasNameGenerator(db.categorias.id, db.recetas.categoriaId),
  );

  $$RecetasTableProcessedTableManager get recetasRefs {
    final manager = $$RecetasTableTableManager(
      $_db,
      $_db.recetas,
    ).filter((f) => f.categoriaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_recetasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriasTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriasTable> {
  $$CategoriasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> recetasRefs(
    Expression<bool> Function($$RecetasTableFilterComposer f) f,
  ) {
    final $$RecetasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recetas,
      getReferencedColumn: (t) => t.categoriaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecetasTableFilterComposer(
            $db: $db,
            $table: $db.recetas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriasTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriasTable> {
  $$CategoriasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriasTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriasTable> {
  $$CategoriasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  Expression<T> recetasRefs<T extends Object>(
    Expression<T> Function($$RecetasTableAnnotationComposer a) f,
  ) {
    final $$RecetasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recetas,
      getReferencedColumn: (t) => t.categoriaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecetasTableAnnotationComposer(
            $db: $db,
            $table: $db.recetas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriasTable,
          Categoria,
          $$CategoriasTableFilterComposer,
          $$CategoriasTableOrderingComposer,
          $$CategoriasTableAnnotationComposer,
          $$CategoriasTableCreateCompanionBuilder,
          $$CategoriasTableUpdateCompanionBuilder,
          (Categoria, $$CategoriasTableReferences),
          Categoria,
          PrefetchHooks Function({bool recetasRefs})
        > {
  $$CategoriasTableTableManager(_$AppDatabase db, $CategoriasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
              }) => CategoriasCompanion(id: id, nombre: nombre),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
              }) => CategoriasCompanion.insert(id: id, nombre: nombre),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recetasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (recetasRefs) db.recetas],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (recetasRefs)
                    await $_getPrefetchedData<
                      Categoria,
                      $CategoriasTable,
                      Receta
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriasTableReferences
                          ._recetasRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriasTableReferences(
                            db,
                            table,
                            p0,
                          ).recetasRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.categoriaId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CategoriasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriasTable,
      Categoria,
      $$CategoriasTableFilterComposer,
      $$CategoriasTableOrderingComposer,
      $$CategoriasTableAnnotationComposer,
      $$CategoriasTableCreateCompanionBuilder,
      $$CategoriasTableUpdateCompanionBuilder,
      (Categoria, $$CategoriasTableReferences),
      Categoria,
      PrefetchHooks Function({bool recetasRefs})
    >;
typedef $$RecetasTableCreateCompanionBuilder =
    RecetasCompanion Function({
      Value<int> id,
      required int categoriaId,
      required String nombre,
      required String descripcion,
      required int tiempo,
      Value<bool> guardada,
      Value<String?> imagen,
    });
typedef $$RecetasTableUpdateCompanionBuilder =
    RecetasCompanion Function({
      Value<int> id,
      Value<int> categoriaId,
      Value<String> nombre,
      Value<String> descripcion,
      Value<int> tiempo,
      Value<bool> guardada,
      Value<String?> imagen,
    });

final class $$RecetasTableReferences
    extends BaseReferences<_$AppDatabase, $RecetasTable, Receta> {
  $$RecetasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriasTable _categoriaIdTable(_$AppDatabase db) =>
      db.categorias.createAlias(
        $_aliasNameGenerator(db.recetas.categoriaId, db.categorias.id),
      );

  $$CategoriasTableProcessedTableManager get categoriaId {
    final $_column = $_itemColumn<int>('categoria_id')!;

    final manager = $$CategoriasTableTableManager(
      $_db,
      $_db.categorias,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoriaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$IngredientesTable, List<Ingrediente>>
  _ingredientesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.ingredientes,
    aliasName: $_aliasNameGenerator(db.recetas.id, db.ingredientes.recetaId),
  );

  $$IngredientesTableProcessedTableManager get ingredientesRefs {
    final manager = $$IngredientesTableTableManager(
      $_db,
      $_db.ingredientes,
    ).filter((f) => f.recetaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ingredientesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InstruccionesTable, List<Instruccione>>
  _instruccionesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.instrucciones,
    aliasName: $_aliasNameGenerator(db.recetas.id, db.instrucciones.recetaId),
  );

  $$InstruccionesTableProcessedTableManager get instruccionesRefs {
    final manager = $$InstruccionesTableTableManager(
      $_db,
      $_db.instrucciones,
    ).filter((f) => f.recetaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_instruccionesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InfoNutrimentalTable, List<InfoNutrimentalData>>
  _infoNutrimentalRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.infoNutrimental,
    aliasName: $_aliasNameGenerator(db.recetas.id, db.infoNutrimental.recetaId),
  );

  $$InfoNutrimentalTableProcessedTableManager get infoNutrimentalRefs {
    final manager = $$InfoNutrimentalTableTableManager(
      $_db,
      $_db.infoNutrimental,
    ).filter((f) => f.recetaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _infoNutrimentalRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RecetasTableFilterComposer
    extends Composer<_$AppDatabase, $RecetasTable> {
  $$RecetasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tiempo => $composableBuilder(
    column: $table.tiempo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get guardada => $composableBuilder(
    column: $table.guardada,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagen => $composableBuilder(
    column: $table.imagen,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriasTableFilterComposer get categoriaId {
    final $$CategoriasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoriaId,
      referencedTable: $db.categorias,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriasTableFilterComposer(
            $db: $db,
            $table: $db.categorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> ingredientesRefs(
    Expression<bool> Function($$IngredientesTableFilterComposer f) f,
  ) {
    final $$IngredientesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ingredientes,
      getReferencedColumn: (t) => t.recetaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientesTableFilterComposer(
            $db: $db,
            $table: $db.ingredientes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> instruccionesRefs(
    Expression<bool> Function($$InstruccionesTableFilterComposer f) f,
  ) {
    final $$InstruccionesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.instrucciones,
      getReferencedColumn: (t) => t.recetaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstruccionesTableFilterComposer(
            $db: $db,
            $table: $db.instrucciones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> infoNutrimentalRefs(
    Expression<bool> Function($$InfoNutrimentalTableFilterComposer f) f,
  ) {
    final $$InfoNutrimentalTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.infoNutrimental,
      getReferencedColumn: (t) => t.recetaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InfoNutrimentalTableFilterComposer(
            $db: $db,
            $table: $db.infoNutrimental,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecetasTableOrderingComposer
    extends Composer<_$AppDatabase, $RecetasTable> {
  $$RecetasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tiempo => $composableBuilder(
    column: $table.tiempo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get guardada => $composableBuilder(
    column: $table.guardada,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagen => $composableBuilder(
    column: $table.imagen,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriasTableOrderingComposer get categoriaId {
    final $$CategoriasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoriaId,
      referencedTable: $db.categorias,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriasTableOrderingComposer(
            $db: $db,
            $table: $db.categorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecetasTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecetasTable> {
  $$RecetasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tiempo =>
      $composableBuilder(column: $table.tiempo, builder: (column) => column);

  GeneratedColumn<bool> get guardada =>
      $composableBuilder(column: $table.guardada, builder: (column) => column);

  GeneratedColumn<String> get imagen =>
      $composableBuilder(column: $table.imagen, builder: (column) => column);

  $$CategoriasTableAnnotationComposer get categoriaId {
    final $$CategoriasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoriaId,
      referencedTable: $db.categorias,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriasTableAnnotationComposer(
            $db: $db,
            $table: $db.categorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> ingredientesRefs<T extends Object>(
    Expression<T> Function($$IngredientesTableAnnotationComposer a) f,
  ) {
    final $$IngredientesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ingredientes,
      getReferencedColumn: (t) => t.recetaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientesTableAnnotationComposer(
            $db: $db,
            $table: $db.ingredientes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> instruccionesRefs<T extends Object>(
    Expression<T> Function($$InstruccionesTableAnnotationComposer a) f,
  ) {
    final $$InstruccionesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.instrucciones,
      getReferencedColumn: (t) => t.recetaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstruccionesTableAnnotationComposer(
            $db: $db,
            $table: $db.instrucciones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> infoNutrimentalRefs<T extends Object>(
    Expression<T> Function($$InfoNutrimentalTableAnnotationComposer a) f,
  ) {
    final $$InfoNutrimentalTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.infoNutrimental,
      getReferencedColumn: (t) => t.recetaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InfoNutrimentalTableAnnotationComposer(
            $db: $db,
            $table: $db.infoNutrimental,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecetasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecetasTable,
          Receta,
          $$RecetasTableFilterComposer,
          $$RecetasTableOrderingComposer,
          $$RecetasTableAnnotationComposer,
          $$RecetasTableCreateCompanionBuilder,
          $$RecetasTableUpdateCompanionBuilder,
          (Receta, $$RecetasTableReferences),
          Receta,
          PrefetchHooks Function({
            bool categoriaId,
            bool ingredientesRefs,
            bool instruccionesRefs,
            bool infoNutrimentalRefs,
          })
        > {
  $$RecetasTableTableManager(_$AppDatabase db, $RecetasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecetasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecetasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecetasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> categoriaId = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
                Value<int> tiempo = const Value.absent(),
                Value<bool> guardada = const Value.absent(),
                Value<String?> imagen = const Value.absent(),
              }) => RecetasCompanion(
                id: id,
                categoriaId: categoriaId,
                nombre: nombre,
                descripcion: descripcion,
                tiempo: tiempo,
                guardada: guardada,
                imagen: imagen,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int categoriaId,
                required String nombre,
                required String descripcion,
                required int tiempo,
                Value<bool> guardada = const Value.absent(),
                Value<String?> imagen = const Value.absent(),
              }) => RecetasCompanion.insert(
                id: id,
                categoriaId: categoriaId,
                nombre: nombre,
                descripcion: descripcion,
                tiempo: tiempo,
                guardada: guardada,
                imagen: imagen,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecetasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                categoriaId = false,
                ingredientesRefs = false,
                instruccionesRefs = false,
                infoNutrimentalRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (ingredientesRefs) db.ingredientes,
                    if (instruccionesRefs) db.instrucciones,
                    if (infoNutrimentalRefs) db.infoNutrimental,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (categoriaId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoriaId,
                                    referencedTable: $$RecetasTableReferences
                                        ._categoriaIdTable(db),
                                    referencedColumn: $$RecetasTableReferences
                                        ._categoriaIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (ingredientesRefs)
                        await $_getPrefetchedData<
                          Receta,
                          $RecetasTable,
                          Ingrediente
                        >(
                          currentTable: table,
                          referencedTable: $$RecetasTableReferences
                              ._ingredientesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecetasTableReferences(
                                db,
                                table,
                                p0,
                              ).ingredientesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recetaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (instruccionesRefs)
                        await $_getPrefetchedData<
                          Receta,
                          $RecetasTable,
                          Instruccione
                        >(
                          currentTable: table,
                          referencedTable: $$RecetasTableReferences
                              ._instruccionesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecetasTableReferences(
                                db,
                                table,
                                p0,
                              ).instruccionesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recetaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (infoNutrimentalRefs)
                        await $_getPrefetchedData<
                          Receta,
                          $RecetasTable,
                          InfoNutrimentalData
                        >(
                          currentTable: table,
                          referencedTable: $$RecetasTableReferences
                              ._infoNutrimentalRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecetasTableReferences(
                                db,
                                table,
                                p0,
                              ).infoNutrimentalRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recetaId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RecetasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecetasTable,
      Receta,
      $$RecetasTableFilterComposer,
      $$RecetasTableOrderingComposer,
      $$RecetasTableAnnotationComposer,
      $$RecetasTableCreateCompanionBuilder,
      $$RecetasTableUpdateCompanionBuilder,
      (Receta, $$RecetasTableReferences),
      Receta,
      PrefetchHooks Function({
        bool categoriaId,
        bool ingredientesRefs,
        bool instruccionesRefs,
        bool infoNutrimentalRefs,
      })
    >;
typedef $$IngredientesTableCreateCompanionBuilder =
    IngredientesCompanion Function({
      Value<int> id,
      required int recetaId,
      required String nombre,
      required double cantidad,
      required String unidad,
    });
typedef $$IngredientesTableUpdateCompanionBuilder =
    IngredientesCompanion Function({
      Value<int> id,
      Value<int> recetaId,
      Value<String> nombre,
      Value<double> cantidad,
      Value<String> unidad,
    });

final class $$IngredientesTableReferences
    extends BaseReferences<_$AppDatabase, $IngredientesTable, Ingrediente> {
  $$IngredientesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RecetasTable _recetaIdTable(_$AppDatabase db) =>
      db.recetas.createAlias(
        $_aliasNameGenerator(db.ingredientes.recetaId, db.recetas.id),
      );

  $$RecetasTableProcessedTableManager get recetaId {
    final $_column = $_itemColumn<int>('receta_id')!;

    final manager = $$RecetasTableTableManager(
      $_db,
      $_db.recetas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recetaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$IngredientesTableFilterComposer
    extends Composer<_$AppDatabase, $IngredientesTable> {
  $$IngredientesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unidad => $composableBuilder(
    column: $table.unidad,
    builder: (column) => ColumnFilters(column),
  );

  $$RecetasTableFilterComposer get recetaId {
    final $$RecetasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recetaId,
      referencedTable: $db.recetas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecetasTableFilterComposer(
            $db: $db,
            $table: $db.recetas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IngredientesTableOrderingComposer
    extends Composer<_$AppDatabase, $IngredientesTable> {
  $$IngredientesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unidad => $composableBuilder(
    column: $table.unidad,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecetasTableOrderingComposer get recetaId {
    final $$RecetasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recetaId,
      referencedTable: $db.recetas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecetasTableOrderingComposer(
            $db: $db,
            $table: $db.recetas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IngredientesTableAnnotationComposer
    extends Composer<_$AppDatabase, $IngredientesTable> {
  $$IngredientesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<double> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<String> get unidad =>
      $composableBuilder(column: $table.unidad, builder: (column) => column);

  $$RecetasTableAnnotationComposer get recetaId {
    final $$RecetasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recetaId,
      referencedTable: $db.recetas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecetasTableAnnotationComposer(
            $db: $db,
            $table: $db.recetas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IngredientesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IngredientesTable,
          Ingrediente,
          $$IngredientesTableFilterComposer,
          $$IngredientesTableOrderingComposer,
          $$IngredientesTableAnnotationComposer,
          $$IngredientesTableCreateCompanionBuilder,
          $$IngredientesTableUpdateCompanionBuilder,
          (Ingrediente, $$IngredientesTableReferences),
          Ingrediente,
          PrefetchHooks Function({bool recetaId})
        > {
  $$IngredientesTableTableManager(_$AppDatabase db, $IngredientesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IngredientesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IngredientesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IngredientesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> recetaId = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<double> cantidad = const Value.absent(),
                Value<String> unidad = const Value.absent(),
              }) => IngredientesCompanion(
                id: id,
                recetaId: recetaId,
                nombre: nombre,
                cantidad: cantidad,
                unidad: unidad,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int recetaId,
                required String nombre,
                required double cantidad,
                required String unidad,
              }) => IngredientesCompanion.insert(
                id: id,
                recetaId: recetaId,
                nombre: nombre,
                cantidad: cantidad,
                unidad: unidad,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$IngredientesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recetaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recetaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.recetaId,
                                referencedTable: $$IngredientesTableReferences
                                    ._recetaIdTable(db),
                                referencedColumn: $$IngredientesTableReferences
                                    ._recetaIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$IngredientesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IngredientesTable,
      Ingrediente,
      $$IngredientesTableFilterComposer,
      $$IngredientesTableOrderingComposer,
      $$IngredientesTableAnnotationComposer,
      $$IngredientesTableCreateCompanionBuilder,
      $$IngredientesTableUpdateCompanionBuilder,
      (Ingrediente, $$IngredientesTableReferences),
      Ingrediente,
      PrefetchHooks Function({bool recetaId})
    >;
typedef $$InstruccionesTableCreateCompanionBuilder =
    InstruccionesCompanion Function({
      Value<int> id,
      required int recetaId,
      required int numero,
      required String descripcion,
    });
typedef $$InstruccionesTableUpdateCompanionBuilder =
    InstruccionesCompanion Function({
      Value<int> id,
      Value<int> recetaId,
      Value<int> numero,
      Value<String> descripcion,
    });

final class $$InstruccionesTableReferences
    extends BaseReferences<_$AppDatabase, $InstruccionesTable, Instruccione> {
  $$InstruccionesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RecetasTable _recetaIdTable(_$AppDatabase db) =>
      db.recetas.createAlias(
        $_aliasNameGenerator(db.instrucciones.recetaId, db.recetas.id),
      );

  $$RecetasTableProcessedTableManager get recetaId {
    final $_column = $_itemColumn<int>('receta_id')!;

    final manager = $$RecetasTableTableManager(
      $_db,
      $_db.recetas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recetaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InstruccionesTableFilterComposer
    extends Composer<_$AppDatabase, $InstruccionesTable> {
  $$InstruccionesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numero => $composableBuilder(
    column: $table.numero,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  $$RecetasTableFilterComposer get recetaId {
    final $$RecetasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recetaId,
      referencedTable: $db.recetas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecetasTableFilterComposer(
            $db: $db,
            $table: $db.recetas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InstruccionesTableOrderingComposer
    extends Composer<_$AppDatabase, $InstruccionesTable> {
  $$InstruccionesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numero => $composableBuilder(
    column: $table.numero,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecetasTableOrderingComposer get recetaId {
    final $$RecetasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recetaId,
      referencedTable: $db.recetas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecetasTableOrderingComposer(
            $db: $db,
            $table: $db.recetas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InstruccionesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InstruccionesTable> {
  $$InstruccionesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get numero =>
      $composableBuilder(column: $table.numero, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  $$RecetasTableAnnotationComposer get recetaId {
    final $$RecetasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recetaId,
      referencedTable: $db.recetas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecetasTableAnnotationComposer(
            $db: $db,
            $table: $db.recetas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InstruccionesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InstruccionesTable,
          Instruccione,
          $$InstruccionesTableFilterComposer,
          $$InstruccionesTableOrderingComposer,
          $$InstruccionesTableAnnotationComposer,
          $$InstruccionesTableCreateCompanionBuilder,
          $$InstruccionesTableUpdateCompanionBuilder,
          (Instruccione, $$InstruccionesTableReferences),
          Instruccione,
          PrefetchHooks Function({bool recetaId})
        > {
  $$InstruccionesTableTableManager(_$AppDatabase db, $InstruccionesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InstruccionesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InstruccionesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InstruccionesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> recetaId = const Value.absent(),
                Value<int> numero = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
              }) => InstruccionesCompanion(
                id: id,
                recetaId: recetaId,
                numero: numero,
                descripcion: descripcion,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int recetaId,
                required int numero,
                required String descripcion,
              }) => InstruccionesCompanion.insert(
                id: id,
                recetaId: recetaId,
                numero: numero,
                descripcion: descripcion,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InstruccionesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recetaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recetaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.recetaId,
                                referencedTable: $$InstruccionesTableReferences
                                    ._recetaIdTable(db),
                                referencedColumn: $$InstruccionesTableReferences
                                    ._recetaIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InstruccionesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InstruccionesTable,
      Instruccione,
      $$InstruccionesTableFilterComposer,
      $$InstruccionesTableOrderingComposer,
      $$InstruccionesTableAnnotationComposer,
      $$InstruccionesTableCreateCompanionBuilder,
      $$InstruccionesTableUpdateCompanionBuilder,
      (Instruccione, $$InstruccionesTableReferences),
      Instruccione,
      PrefetchHooks Function({bool recetaId})
    >;
typedef $$InfoNutrimentalTableCreateCompanionBuilder =
    InfoNutrimentalCompanion Function({
      Value<int> id,
      required int recetaId,
      required double calorias,
      required double proteinas,
      required double grasas,
      required double carbohidratos,
    });
typedef $$InfoNutrimentalTableUpdateCompanionBuilder =
    InfoNutrimentalCompanion Function({
      Value<int> id,
      Value<int> recetaId,
      Value<double> calorias,
      Value<double> proteinas,
      Value<double> grasas,
      Value<double> carbohidratos,
    });

final class $$InfoNutrimentalTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $InfoNutrimentalTable,
          InfoNutrimentalData
        > {
  $$InfoNutrimentalTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RecetasTable _recetaIdTable(_$AppDatabase db) =>
      db.recetas.createAlias(
        $_aliasNameGenerator(db.infoNutrimental.recetaId, db.recetas.id),
      );

  $$RecetasTableProcessedTableManager get recetaId {
    final $_column = $_itemColumn<int>('receta_id')!;

    final manager = $$RecetasTableTableManager(
      $_db,
      $_db.recetas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recetaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InfoNutrimentalTableFilterComposer
    extends Composer<_$AppDatabase, $InfoNutrimentalTable> {
  $$InfoNutrimentalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get calorias => $composableBuilder(
    column: $table.calorias,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinas => $composableBuilder(
    column: $table.proteinas,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get grasas => $composableBuilder(
    column: $table.grasas,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbohidratos => $composableBuilder(
    column: $table.carbohidratos,
    builder: (column) => ColumnFilters(column),
  );

  $$RecetasTableFilterComposer get recetaId {
    final $$RecetasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recetaId,
      referencedTable: $db.recetas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecetasTableFilterComposer(
            $db: $db,
            $table: $db.recetas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InfoNutrimentalTableOrderingComposer
    extends Composer<_$AppDatabase, $InfoNutrimentalTable> {
  $$InfoNutrimentalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get calorias => $composableBuilder(
    column: $table.calorias,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinas => $composableBuilder(
    column: $table.proteinas,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get grasas => $composableBuilder(
    column: $table.grasas,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbohidratos => $composableBuilder(
    column: $table.carbohidratos,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecetasTableOrderingComposer get recetaId {
    final $$RecetasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recetaId,
      referencedTable: $db.recetas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecetasTableOrderingComposer(
            $db: $db,
            $table: $db.recetas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InfoNutrimentalTableAnnotationComposer
    extends Composer<_$AppDatabase, $InfoNutrimentalTable> {
  $$InfoNutrimentalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get calorias =>
      $composableBuilder(column: $table.calorias, builder: (column) => column);

  GeneratedColumn<double> get proteinas =>
      $composableBuilder(column: $table.proteinas, builder: (column) => column);

  GeneratedColumn<double> get grasas =>
      $composableBuilder(column: $table.grasas, builder: (column) => column);

  GeneratedColumn<double> get carbohidratos => $composableBuilder(
    column: $table.carbohidratos,
    builder: (column) => column,
  );

  $$RecetasTableAnnotationComposer get recetaId {
    final $$RecetasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recetaId,
      referencedTable: $db.recetas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecetasTableAnnotationComposer(
            $db: $db,
            $table: $db.recetas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InfoNutrimentalTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InfoNutrimentalTable,
          InfoNutrimentalData,
          $$InfoNutrimentalTableFilterComposer,
          $$InfoNutrimentalTableOrderingComposer,
          $$InfoNutrimentalTableAnnotationComposer,
          $$InfoNutrimentalTableCreateCompanionBuilder,
          $$InfoNutrimentalTableUpdateCompanionBuilder,
          (InfoNutrimentalData, $$InfoNutrimentalTableReferences),
          InfoNutrimentalData,
          PrefetchHooks Function({bool recetaId})
        > {
  $$InfoNutrimentalTableTableManager(
    _$AppDatabase db,
    $InfoNutrimentalTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InfoNutrimentalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InfoNutrimentalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InfoNutrimentalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> recetaId = const Value.absent(),
                Value<double> calorias = const Value.absent(),
                Value<double> proteinas = const Value.absent(),
                Value<double> grasas = const Value.absent(),
                Value<double> carbohidratos = const Value.absent(),
              }) => InfoNutrimentalCompanion(
                id: id,
                recetaId: recetaId,
                calorias: calorias,
                proteinas: proteinas,
                grasas: grasas,
                carbohidratos: carbohidratos,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int recetaId,
                required double calorias,
                required double proteinas,
                required double grasas,
                required double carbohidratos,
              }) => InfoNutrimentalCompanion.insert(
                id: id,
                recetaId: recetaId,
                calorias: calorias,
                proteinas: proteinas,
                grasas: grasas,
                carbohidratos: carbohidratos,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InfoNutrimentalTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recetaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recetaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.recetaId,
                                referencedTable:
                                    $$InfoNutrimentalTableReferences
                                        ._recetaIdTable(db),
                                referencedColumn:
                                    $$InfoNutrimentalTableReferences
                                        ._recetaIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InfoNutrimentalTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InfoNutrimentalTable,
      InfoNutrimentalData,
      $$InfoNutrimentalTableFilterComposer,
      $$InfoNutrimentalTableOrderingComposer,
      $$InfoNutrimentalTableAnnotationComposer,
      $$InfoNutrimentalTableCreateCompanionBuilder,
      $$InfoNutrimentalTableUpdateCompanionBuilder,
      (InfoNutrimentalData, $$InfoNutrimentalTableReferences),
      InfoNutrimentalData,
      PrefetchHooks Function({bool recetaId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoriasTableTableManager get categorias =>
      $$CategoriasTableTableManager(_db, _db.categorias);
  $$RecetasTableTableManager get recetas =>
      $$RecetasTableTableManager(_db, _db.recetas);
  $$IngredientesTableTableManager get ingredientes =>
      $$IngredientesTableTableManager(_db, _db.ingredientes);
  $$InstruccionesTableTableManager get instrucciones =>
      $$InstruccionesTableTableManager(_db, _db.instrucciones);
  $$InfoNutrimentalTableTableManager get infoNutrimental =>
      $$InfoNutrimentalTableTableManager(_db, _db.infoNutrimental);
}
