// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:tiefprompt/models/settings_preset_model.drift.dart' as i1;
import 'package:tiefprompt/models/settings_preset_model.dart' as i2;
import 'package:tiefprompt/models/keybinding.drift.dart' as i3;
import 'package:drift/internal/modular.dart' as i4;

typedef $$SettingsPresetModelTableCreateCompanionBuilder =
    i1.SettingsPresetModelCompanion Function({
      i0.Value<int> id,
      required String name,
      required DateTime createdAt,
      required String data,
      required int keybindings,
    });
typedef $$SettingsPresetModelTableUpdateCompanionBuilder =
    i1.SettingsPresetModelCompanion Function({
      i0.Value<int> id,
      i0.Value<String> name,
      i0.Value<DateTime> createdAt,
      i0.Value<String> data,
      i0.Value<int> keybindings,
    });

final class $$SettingsPresetModelTableReferences
    extends
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.$SettingsPresetModelTable,
          i1.SettingsPresetModelData
        > {
  $$SettingsPresetModelTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static i3.$KeybindingMapModelTable _keybindingsTable(
    i0.GeneratedDatabase db,
  ) => i4.ReadDatabaseContainer(db)
      .resultSet<i3.$KeybindingMapModelTable>('keybinding_map_model')
      .createAlias(
        'settings_preset_model__keybindings__keybinding_map_model__id',
      );

  i3.$$KeybindingMapModelTableProcessedTableManager get keybindings {
    final $_column = $_itemColumn<int>('keybindings')!;

    final manager = i3
        .$$KeybindingMapModelTableTableManager(
          $_db,
          i4.ReadDatabaseContainer(
            $_db,
          ).resultSet<i3.$KeybindingMapModelTable>('keybinding_map_model'),
        )
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_keybindingsTable($_db));
    if (item == null) return manager;
    return i0.ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SettingsPresetModelTableFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$SettingsPresetModelTable> {
  $$SettingsPresetModelTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => i0.ColumnFilters(column),
  );

  i3.$$KeybindingMapModelTableFilterComposer get keybindings {
    final i3.$$KeybindingMapModelTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.keybindings,
          referencedTable: i4.ReadDatabaseContainer(
            $db,
          ).resultSet<i3.$KeybindingMapModelTable>('keybinding_map_model'),
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => i3.$$KeybindingMapModelTableFilterComposer(
                $db: $db,
                $table: i4.ReadDatabaseContainer($db)
                    .resultSet<i3.$KeybindingMapModelTable>(
                      'keybinding_map_model',
                    ),
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$SettingsPresetModelTableOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$SettingsPresetModelTable> {
  $$SettingsPresetModelTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i3.$$KeybindingMapModelTableOrderingComposer get keybindings {
    final i3.$$KeybindingMapModelTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.keybindings,
          referencedTable: i4.ReadDatabaseContainer(
            $db,
          ).resultSet<i3.$KeybindingMapModelTable>('keybinding_map_model'),
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => i3.$$KeybindingMapModelTableOrderingComposer(
                $db: $db,
                $table: i4.ReadDatabaseContainer($db)
                    .resultSet<i3.$KeybindingMapModelTable>(
                      'keybinding_map_model',
                    ),
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$SettingsPresetModelTableAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$SettingsPresetModelTable> {
  $$SettingsPresetModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  i0.GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  i0.GeneratedColumn<String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  i3.$$KeybindingMapModelTableAnnotationComposer get keybindings {
    final i3.$$KeybindingMapModelTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.keybindings,
          referencedTable: i4.ReadDatabaseContainer(
            $db,
          ).resultSet<i3.$KeybindingMapModelTable>('keybinding_map_model'),
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => i3.$$KeybindingMapModelTableAnnotationComposer(
                $db: $db,
                $table: i4.ReadDatabaseContainer($db)
                    .resultSet<i3.$KeybindingMapModelTable>(
                      'keybinding_map_model',
                    ),
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$SettingsPresetModelTableTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.$SettingsPresetModelTable,
          i1.SettingsPresetModelData,
          i1.$$SettingsPresetModelTableFilterComposer,
          i1.$$SettingsPresetModelTableOrderingComposer,
          i1.$$SettingsPresetModelTableAnnotationComposer,
          $$SettingsPresetModelTableCreateCompanionBuilder,
          $$SettingsPresetModelTableUpdateCompanionBuilder,
          (i1.SettingsPresetModelData, i1.$$SettingsPresetModelTableReferences),
          i1.SettingsPresetModelData,
          i0.PrefetchHooks Function({bool keybindings})
        > {
  $$SettingsPresetModelTableTableManager(
    i0.GeneratedDatabase db,
    i1.$SettingsPresetModelTable table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => i1
              .$$SettingsPresetModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$$SettingsPresetModelTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              i1.$$SettingsPresetModelTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                i0.Value<String> name = const i0.Value.absent(),
                i0.Value<DateTime> createdAt = const i0.Value.absent(),
                i0.Value<String> data = const i0.Value.absent(),
                i0.Value<int> keybindings = const i0.Value.absent(),
              }) => i1.SettingsPresetModelCompanion(
                id: id,
                name: name,
                createdAt: createdAt,
                data: data,
                keybindings: keybindings,
              ),
          createCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                required String name,
                required DateTime createdAt,
                required String data,
                required int keybindings,
              }) => i1.SettingsPresetModelCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
                data: data,
                keybindings: keybindings,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  i1.$$SettingsPresetModelTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({keybindings = false}) {
            return i0.PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends i0.TableManagerState<
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
                    if (keybindings) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.keybindings,
                                referencedTable: i1
                                    .$$SettingsPresetModelTableReferences
                                    ._keybindingsTable(db),
                                referencedColumn: i1
                                    .$$SettingsPresetModelTableReferences
                                    ._keybindingsTable(db)
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

typedef $$SettingsPresetModelTableProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.$SettingsPresetModelTable,
      i1.SettingsPresetModelData,
      i1.$$SettingsPresetModelTableFilterComposer,
      i1.$$SettingsPresetModelTableOrderingComposer,
      i1.$$SettingsPresetModelTableAnnotationComposer,
      $$SettingsPresetModelTableCreateCompanionBuilder,
      $$SettingsPresetModelTableUpdateCompanionBuilder,
      (i1.SettingsPresetModelData, i1.$$SettingsPresetModelTableReferences),
      i1.SettingsPresetModelData,
      i0.PrefetchHooks Function({bool keybindings})
    >;

class $SettingsPresetModelTable extends i2.SettingsPresetModel
    with i0.TableInfo<$SettingsPresetModelTable, i1.SettingsPresetModelData> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsPresetModelTable(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  @override
  late final i0.GeneratedColumn<int> id = i0.GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const i0.VerificationMeta _nameMeta = const i0.VerificationMeta(
    'name',
  );
  @override
  late final i0.GeneratedColumn<String> name = i0.GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const i0.VerificationMeta _createdAtMeta = const i0.VerificationMeta(
    'createdAt',
  );
  @override
  late final i0.GeneratedColumn<DateTime> createdAt =
      i0.GeneratedColumn<DateTime>(
        'created_at',
        aliasedName,
        false,
        type: i0.DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const i0.VerificationMeta _dataMeta = const i0.VerificationMeta(
    'data',
  );
  @override
  late final i0.GeneratedColumn<String> data = i0.GeneratedColumn<String>(
    'data',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const i0.VerificationMeta _keybindingsMeta = const i0.VerificationMeta(
    'keybindings',
  );
  @override
  late final i0.GeneratedColumn<int> keybindings = i0.GeneratedColumn<int>(
    'keybindings',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
      'REFERENCES keybinding_map_model (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<i0.GeneratedColumn> get $columns => [
    id,
    name,
    createdAt,
    data,
    keybindings,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings_preset_model';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.SettingsPresetModelData> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
        _dataMeta,
        this.data.isAcceptableOrUnknown(data['data']!, _dataMeta),
      );
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('keybindings')) {
      context.handle(
        _keybindingsMeta,
        keybindings.isAcceptableOrUnknown(
          data['keybindings']!,
          _keybindingsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_keybindingsMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.SettingsPresetModelData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.SettingsPresetModelData(
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      data: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}data'],
      )!,
      keybindings: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}keybindings'],
      )!,
    );
  }

  @override
  $SettingsPresetModelTable createAlias(String alias) {
    return $SettingsPresetModelTable(attachedDatabase, alias);
  }
}

class SettingsPresetModelData extends i0.DataClass
    implements i0.Insertable<i1.SettingsPresetModelData> {
  final int id;
  final String name;
  final DateTime createdAt;
  final String data;
  final int keybindings;
  const SettingsPresetModelData({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.data,
    required this.keybindings,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    map['name'] = i0.Variable<String>(name);
    map['created_at'] = i0.Variable<DateTime>(createdAt);
    map['data'] = i0.Variable<String>(data);
    map['keybindings'] = i0.Variable<int>(keybindings);
    return map;
  }

  i1.SettingsPresetModelCompanion toCompanion(bool nullToAbsent) {
    return i1.SettingsPresetModelCompanion(
      id: i0.Value(id),
      name: i0.Value(name),
      createdAt: i0.Value(createdAt),
      data: i0.Value(data),
      keybindings: i0.Value(keybindings),
    );
  }

  factory SettingsPresetModelData.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return SettingsPresetModelData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      data: serializer.fromJson<String>(json['data']),
      keybindings: serializer.fromJson<int>(json['keybindings']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'data': serializer.toJson<String>(data),
      'keybindings': serializer.toJson<int>(keybindings),
    };
  }

  i1.SettingsPresetModelData copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    String? data,
    int? keybindings,
  }) => i1.SettingsPresetModelData(
    id: id ?? this.id,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    data: data ?? this.data,
    keybindings: keybindings ?? this.keybindings,
  );
  SettingsPresetModelData copyWithCompanion(
    i1.SettingsPresetModelCompanion data,
  ) {
    return SettingsPresetModelData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      data: data.data.present ? data.data.value : this.data,
      keybindings: data.keybindings.present
          ? data.keybindings.value
          : this.keybindings,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsPresetModelData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('data: $data, ')
          ..write('keybindings: $keybindings')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt, data, keybindings);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.SettingsPresetModelData &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.data == this.data &&
          other.keybindings == this.keybindings);
}

class SettingsPresetModelCompanion
    extends i0.UpdateCompanion<i1.SettingsPresetModelData> {
  final i0.Value<int> id;
  final i0.Value<String> name;
  final i0.Value<DateTime> createdAt;
  final i0.Value<String> data;
  final i0.Value<int> keybindings;
  const SettingsPresetModelCompanion({
    this.id = const i0.Value.absent(),
    this.name = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
    this.data = const i0.Value.absent(),
    this.keybindings = const i0.Value.absent(),
  });
  SettingsPresetModelCompanion.insert({
    this.id = const i0.Value.absent(),
    required String name,
    required DateTime createdAt,
    required String data,
    required int keybindings,
  }) : name = i0.Value(name),
       createdAt = i0.Value(createdAt),
       data = i0.Value(data),
       keybindings = i0.Value(keybindings);
  static i0.Insertable<i1.SettingsPresetModelData> custom({
    i0.Expression<int>? id,
    i0.Expression<String>? name,
    i0.Expression<DateTime>? createdAt,
    i0.Expression<String>? data,
    i0.Expression<int>? keybindings,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (data != null) 'data': data,
      if (keybindings != null) 'keybindings': keybindings,
    });
  }

  i1.SettingsPresetModelCompanion copyWith({
    i0.Value<int>? id,
    i0.Value<String>? name,
    i0.Value<DateTime>? createdAt,
    i0.Value<String>? data,
    i0.Value<int>? keybindings,
  }) {
    return i1.SettingsPresetModelCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      data: data ?? this.data,
      keybindings: keybindings ?? this.keybindings,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = i0.Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = i0.Variable<DateTime>(createdAt.value);
    }
    if (data.present) {
      map['data'] = i0.Variable<String>(data.value);
    }
    if (keybindings.present) {
      map['keybindings'] = i0.Variable<int>(keybindings.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsPresetModelCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('data: $data, ')
          ..write('keybindings: $keybindings')
          ..write(')'))
        .toString();
  }
}
