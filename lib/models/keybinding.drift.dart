// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:tiefprompt/models/keybinding.drift.dart' as i1;
import 'package:tiefprompt/models/keybinding.dart' as i2;
import 'package:drift/internal/modular.dart' as i3;

typedef $$KeybindingMappingModelTableCreateCompanionBuilder =
    i1.KeybindingMappingModelCompanion Function({
      i0.Value<int> id,
      required int mapId,
      required int keyId,
      required bool ctrl,
      required bool shift,
      required bool alt,
      required bool meta,
      required String actionName,
    });
typedef $$KeybindingMappingModelTableUpdateCompanionBuilder =
    i1.KeybindingMappingModelCompanion Function({
      i0.Value<int> id,
      i0.Value<int> mapId,
      i0.Value<int> keyId,
      i0.Value<bool> ctrl,
      i0.Value<bool> shift,
      i0.Value<bool> alt,
      i0.Value<bool> meta,
      i0.Value<String> actionName,
    });

final class $$KeybindingMappingModelTableReferences
    extends
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.$KeybindingMappingModelTable,
          i1.KeybindingMappingModelData
        > {
  $$KeybindingMappingModelTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static i1.$KeybindingMapModelTable _mapIdTable(i0.GeneratedDatabase db) =>
      i3.ReadDatabaseContainer(db)
          .resultSet<i1.$KeybindingMapModelTable>('keybinding_map_model')
          .createAlias(
            'keybinding_mapping_model__map_id__keybinding_map_model__id',
          );

  i1.$$KeybindingMapModelTableProcessedTableManager get mapId {
    final $_column = $_itemColumn<int>('map_id')!;

    final manager = i1
        .$$KeybindingMapModelTableTableManager(
          $_db,
          i3.ReadDatabaseContainer(
            $_db,
          ).resultSet<i1.$KeybindingMapModelTable>('keybinding_map_model'),
        )
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mapIdTable($_db));
    if (item == null) return manager;
    return i0.ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$KeybindingMappingModelTableFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$KeybindingMappingModelTable> {
  $$KeybindingMappingModelTableFilterComposer({
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

  i0.ColumnFilters<int> get keyId => $composableBuilder(
    column: $table.keyId,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<bool> get ctrl => $composableBuilder(
    column: $table.ctrl,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<bool> get shift => $composableBuilder(
    column: $table.shift,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<bool> get alt => $composableBuilder(
    column: $table.alt,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<bool> get meta => $composableBuilder(
    column: $table.meta,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get actionName => $composableBuilder(
    column: $table.actionName,
    builder: (column) => i0.ColumnFilters(column),
  );

  i1.$$KeybindingMapModelTableFilterComposer get mapId {
    final i1.$$KeybindingMapModelTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.mapId,
          referencedTable: i3.ReadDatabaseContainer(
            $db,
          ).resultSet<i1.$KeybindingMapModelTable>('keybinding_map_model'),
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => i1.$$KeybindingMapModelTableFilterComposer(
                $db: $db,
                $table: i3.ReadDatabaseContainer($db)
                    .resultSet<i1.$KeybindingMapModelTable>(
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

class $$KeybindingMappingModelTableOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$KeybindingMappingModelTable> {
  $$KeybindingMappingModelTableOrderingComposer({
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

  i0.ColumnOrderings<int> get keyId => $composableBuilder(
    column: $table.keyId,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<bool> get ctrl => $composableBuilder(
    column: $table.ctrl,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<bool> get shift => $composableBuilder(
    column: $table.shift,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<bool> get alt => $composableBuilder(
    column: $table.alt,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<bool> get meta => $composableBuilder(
    column: $table.meta,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get actionName => $composableBuilder(
    column: $table.actionName,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i1.$$KeybindingMapModelTableOrderingComposer get mapId {
    final i1.$$KeybindingMapModelTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.mapId,
          referencedTable: i3.ReadDatabaseContainer(
            $db,
          ).resultSet<i1.$KeybindingMapModelTable>('keybinding_map_model'),
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => i1.$$KeybindingMapModelTableOrderingComposer(
                $db: $db,
                $table: i3.ReadDatabaseContainer($db)
                    .resultSet<i1.$KeybindingMapModelTable>(
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

class $$KeybindingMappingModelTableAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$KeybindingMappingModelTable> {
  $$KeybindingMappingModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<int> get keyId =>
      $composableBuilder(column: $table.keyId, builder: (column) => column);

  i0.GeneratedColumn<bool> get ctrl =>
      $composableBuilder(column: $table.ctrl, builder: (column) => column);

  i0.GeneratedColumn<bool> get shift =>
      $composableBuilder(column: $table.shift, builder: (column) => column);

  i0.GeneratedColumn<bool> get alt =>
      $composableBuilder(column: $table.alt, builder: (column) => column);

  i0.GeneratedColumn<bool> get meta =>
      $composableBuilder(column: $table.meta, builder: (column) => column);

  i0.GeneratedColumn<String> get actionName => $composableBuilder(
    column: $table.actionName,
    builder: (column) => column,
  );

  i1.$$KeybindingMapModelTableAnnotationComposer get mapId {
    final i1.$$KeybindingMapModelTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.mapId,
          referencedTable: i3.ReadDatabaseContainer(
            $db,
          ).resultSet<i1.$KeybindingMapModelTable>('keybinding_map_model'),
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => i1.$$KeybindingMapModelTableAnnotationComposer(
                $db: $db,
                $table: i3.ReadDatabaseContainer($db)
                    .resultSet<i1.$KeybindingMapModelTable>(
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

class $$KeybindingMappingModelTableTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.$KeybindingMappingModelTable,
          i1.KeybindingMappingModelData,
          i1.$$KeybindingMappingModelTableFilterComposer,
          i1.$$KeybindingMappingModelTableOrderingComposer,
          i1.$$KeybindingMappingModelTableAnnotationComposer,
          $$KeybindingMappingModelTableCreateCompanionBuilder,
          $$KeybindingMappingModelTableUpdateCompanionBuilder,
          (
            i1.KeybindingMappingModelData,
            i1.$$KeybindingMappingModelTableReferences,
          ),
          i1.KeybindingMappingModelData,
          i0.PrefetchHooks Function({bool mapId})
        > {
  $$KeybindingMappingModelTableTableManager(
    i0.GeneratedDatabase db,
    i1.$KeybindingMappingModelTable table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$$KeybindingMappingModelTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              i1.$$KeybindingMappingModelTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              i1.$$KeybindingMappingModelTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                i0.Value<int> mapId = const i0.Value.absent(),
                i0.Value<int> keyId = const i0.Value.absent(),
                i0.Value<bool> ctrl = const i0.Value.absent(),
                i0.Value<bool> shift = const i0.Value.absent(),
                i0.Value<bool> alt = const i0.Value.absent(),
                i0.Value<bool> meta = const i0.Value.absent(),
                i0.Value<String> actionName = const i0.Value.absent(),
              }) => i1.KeybindingMappingModelCompanion(
                id: id,
                mapId: mapId,
                keyId: keyId,
                ctrl: ctrl,
                shift: shift,
                alt: alt,
                meta: meta,
                actionName: actionName,
              ),
          createCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                required int mapId,
                required int keyId,
                required bool ctrl,
                required bool shift,
                required bool alt,
                required bool meta,
                required String actionName,
              }) => i1.KeybindingMappingModelCompanion.insert(
                id: id,
                mapId: mapId,
                keyId: keyId,
                ctrl: ctrl,
                shift: shift,
                alt: alt,
                meta: meta,
                actionName: actionName,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  i1.$$KeybindingMappingModelTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mapId = false}) {
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
                    if (mapId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.mapId,
                                referencedTable: i1
                                    .$$KeybindingMappingModelTableReferences
                                    ._mapIdTable(db),
                                referencedColumn: i1
                                    .$$KeybindingMappingModelTableReferences
                                    ._mapIdTable(db)
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

typedef $$KeybindingMappingModelTableProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.$KeybindingMappingModelTable,
      i1.KeybindingMappingModelData,
      i1.$$KeybindingMappingModelTableFilterComposer,
      i1.$$KeybindingMappingModelTableOrderingComposer,
      i1.$$KeybindingMappingModelTableAnnotationComposer,
      $$KeybindingMappingModelTableCreateCompanionBuilder,
      $$KeybindingMappingModelTableUpdateCompanionBuilder,
      (
        i1.KeybindingMappingModelData,
        i1.$$KeybindingMappingModelTableReferences,
      ),
      i1.KeybindingMappingModelData,
      i0.PrefetchHooks Function({bool mapId})
    >;
typedef $$KeybindingMapModelTableCreateCompanionBuilder =
    i1.KeybindingMapModelCompanion Function({i0.Value<int> id});
typedef $$KeybindingMapModelTableUpdateCompanionBuilder =
    i1.KeybindingMapModelCompanion Function({i0.Value<int> id});

final class $$KeybindingMapModelTableReferences
    extends
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.$KeybindingMapModelTable,
          i1.KeybindingMapModelData
        > {
  $$KeybindingMapModelTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static i0.MultiTypedResultKey<
    i1.$KeybindingMappingModelTable,
    List<i1.KeybindingMappingModelData>
  >
  _keybindingMappingModelRefsTable(i0.GeneratedDatabase db) =>
      i0.MultiTypedResultKey.fromTable(
        i3.ReadDatabaseContainer(db).resultSet<i1.$KeybindingMappingModelTable>(
          'keybinding_mapping_model',
        ),
        aliasName: 'keybinding_map_model__id__keybinding_mapping_model__map_id',
      );

  i1.$$KeybindingMappingModelTableProcessedTableManager
  get keybindingMappingModelRefs {
    final manager = i1
        .$$KeybindingMappingModelTableTableManager(
          $_db,
          i3.ReadDatabaseContainer(
            $_db,
          ).resultSet<i1.$KeybindingMappingModelTable>(
            'keybinding_mapping_model',
          ),
        )
        .filter((f) => f.mapId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _keybindingMappingModelRefsTable($_db),
    );
    return i0.ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$KeybindingMapModelTableFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$KeybindingMapModelTable> {
  $$KeybindingMapModelTableFilterComposer({
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

  i0.Expression<bool> keybindingMappingModelRefs(
    i0.Expression<bool> Function(
      i1.$$KeybindingMappingModelTableFilterComposer f,
    )
    f,
  ) {
    final i1.$$KeybindingMappingModelTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: i3.ReadDatabaseContainer($db)
              .resultSet<i1.$KeybindingMappingModelTable>(
                'keybinding_mapping_model',
              ),
          getReferencedColumn: (t) => t.mapId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => i1.$$KeybindingMappingModelTableFilterComposer(
                $db: $db,
                $table: i3.ReadDatabaseContainer($db)
                    .resultSet<i1.$KeybindingMappingModelTable>(
                      'keybinding_mapping_model',
                    ),
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$KeybindingMapModelTableOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$KeybindingMapModelTable> {
  $$KeybindingMapModelTableOrderingComposer({
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
}

class $$KeybindingMapModelTableAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$KeybindingMapModelTable> {
  $$KeybindingMapModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.Expression<T> keybindingMappingModelRefs<T extends Object>(
    i0.Expression<T> Function(
      i1.$$KeybindingMappingModelTableAnnotationComposer a,
    )
    f,
  ) {
    final i1.$$KeybindingMappingModelTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: i3.ReadDatabaseContainer($db)
              .resultSet<i1.$KeybindingMappingModelTable>(
                'keybinding_mapping_model',
              ),
          getReferencedColumn: (t) => t.mapId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => i1.$$KeybindingMappingModelTableAnnotationComposer(
                $db: $db,
                $table: i3.ReadDatabaseContainer($db)
                    .resultSet<i1.$KeybindingMappingModelTable>(
                      'keybinding_mapping_model',
                    ),
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$KeybindingMapModelTableTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.$KeybindingMapModelTable,
          i1.KeybindingMapModelData,
          i1.$$KeybindingMapModelTableFilterComposer,
          i1.$$KeybindingMapModelTableOrderingComposer,
          i1.$$KeybindingMapModelTableAnnotationComposer,
          $$KeybindingMapModelTableCreateCompanionBuilder,
          $$KeybindingMapModelTableUpdateCompanionBuilder,
          (i1.KeybindingMapModelData, i1.$$KeybindingMapModelTableReferences),
          i1.KeybindingMapModelData,
          i0.PrefetchHooks Function({bool keybindingMappingModelRefs})
        > {
  $$KeybindingMapModelTableTableManager(
    i0.GeneratedDatabase db,
    i1.$KeybindingMapModelTable table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => i1
              .$$KeybindingMapModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$$KeybindingMapModelTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              i1.$$KeybindingMapModelTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({i0.Value<int> id = const i0.Value.absent()}) =>
                  i1.KeybindingMapModelCompanion(id: id),
          createCompanionCallback:
              ({i0.Value<int> id = const i0.Value.absent()}) =>
                  i1.KeybindingMapModelCompanion.insert(id: id),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  i1.$$KeybindingMapModelTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({keybindingMappingModelRefs = false}) {
            return i0.PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (keybindingMappingModelRefs)
                  i3.ReadDatabaseContainer(
                    db,
                  ).resultSet<i1.$KeybindingMappingModelTable>(
                    'keybinding_mapping_model',
                  ),
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (keybindingMappingModelRefs)
                    await i0.$_getPrefetchedData<
                      i1.KeybindingMapModelData,
                      i1.$KeybindingMapModelTable,
                      i1.KeybindingMappingModelData
                    >(
                      currentTable: table,
                      referencedTable: i1.$$KeybindingMapModelTableReferences
                          ._keybindingMappingModelRefsTable(db),
                      managerFromTypedResult: (p0) => i1
                          .$$KeybindingMapModelTableReferences(db, table, p0)
                          .keybindingMappingModelRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.mapId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$KeybindingMapModelTableProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.$KeybindingMapModelTable,
      i1.KeybindingMapModelData,
      i1.$$KeybindingMapModelTableFilterComposer,
      i1.$$KeybindingMapModelTableOrderingComposer,
      i1.$$KeybindingMapModelTableAnnotationComposer,
      $$KeybindingMapModelTableCreateCompanionBuilder,
      $$KeybindingMapModelTableUpdateCompanionBuilder,
      (i1.KeybindingMapModelData, i1.$$KeybindingMapModelTableReferences),
      i1.KeybindingMapModelData,
      i0.PrefetchHooks Function({bool keybindingMappingModelRefs})
    >;

class $KeybindingMappingModelTable extends i2.KeybindingMappingModel
    with
        i0.TableInfo<
          $KeybindingMappingModelTable,
          i1.KeybindingMappingModelData
        > {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KeybindingMappingModelTable(this.attachedDatabase, [this._alias]);
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
  static const i0.VerificationMeta _mapIdMeta = const i0.VerificationMeta(
    'mapId',
  );
  @override
  late final i0.GeneratedColumn<int> mapId = i0.GeneratedColumn<int>(
    'map_id',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
      'REFERENCES keybinding_map_model (id) ON DELETE CASCADE',
    ),
  );
  static const i0.VerificationMeta _keyIdMeta = const i0.VerificationMeta(
    'keyId',
  );
  @override
  late final i0.GeneratedColumn<int> keyId = i0.GeneratedColumn<int>(
    'key_id',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const i0.VerificationMeta _ctrlMeta = const i0.VerificationMeta(
    'ctrl',
  );
  @override
  late final i0.GeneratedColumn<bool> ctrl = i0.GeneratedColumn<bool>(
    'ctrl',
    aliasedName,
    false,
    type: i0.DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
      'CHECK ("ctrl" IN (0, 1))',
    ),
  );
  static const i0.VerificationMeta _shiftMeta = const i0.VerificationMeta(
    'shift',
  );
  @override
  late final i0.GeneratedColumn<bool> shift = i0.GeneratedColumn<bool>(
    'shift',
    aliasedName,
    false,
    type: i0.DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
      'CHECK ("shift" IN (0, 1))',
    ),
  );
  static const i0.VerificationMeta _altMeta = const i0.VerificationMeta('alt');
  @override
  late final i0.GeneratedColumn<bool> alt = i0.GeneratedColumn<bool>(
    'alt',
    aliasedName,
    false,
    type: i0.DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
      'CHECK ("alt" IN (0, 1))',
    ),
  );
  static const i0.VerificationMeta _metaMeta = const i0.VerificationMeta(
    'meta',
  );
  @override
  late final i0.GeneratedColumn<bool> meta = i0.GeneratedColumn<bool>(
    'meta',
    aliasedName,
    false,
    type: i0.DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
      'CHECK ("meta" IN (0, 1))',
    ),
  );
  static const i0.VerificationMeta _actionNameMeta = const i0.VerificationMeta(
    'actionName',
  );
  @override
  late final i0.GeneratedColumn<String> actionName = i0.GeneratedColumn<String>(
    'action_name',
    aliasedName,
    false,
    check: () => actionName.isIn(i2.KeybindingAction.values.map((e) => e.name)),
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<i0.GeneratedColumn> get $columns => [
    id,
    mapId,
    keyId,
    ctrl,
    shift,
    alt,
    meta,
    actionName,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'keybinding_mapping_model';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.KeybindingMappingModelData> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('map_id')) {
      context.handle(
        _mapIdMeta,
        mapId.isAcceptableOrUnknown(data['map_id']!, _mapIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mapIdMeta);
    }
    if (data.containsKey('key_id')) {
      context.handle(
        _keyIdMeta,
        keyId.isAcceptableOrUnknown(data['key_id']!, _keyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_keyIdMeta);
    }
    if (data.containsKey('ctrl')) {
      context.handle(
        _ctrlMeta,
        ctrl.isAcceptableOrUnknown(data['ctrl']!, _ctrlMeta),
      );
    } else if (isInserting) {
      context.missing(_ctrlMeta);
    }
    if (data.containsKey('shift')) {
      context.handle(
        _shiftMeta,
        shift.isAcceptableOrUnknown(data['shift']!, _shiftMeta),
      );
    } else if (isInserting) {
      context.missing(_shiftMeta);
    }
    if (data.containsKey('alt')) {
      context.handle(
        _altMeta,
        alt.isAcceptableOrUnknown(data['alt']!, _altMeta),
      );
    } else if (isInserting) {
      context.missing(_altMeta);
    }
    if (data.containsKey('meta')) {
      context.handle(
        _metaMeta,
        meta.isAcceptableOrUnknown(data['meta']!, _metaMeta),
      );
    } else if (isInserting) {
      context.missing(_metaMeta);
    }
    if (data.containsKey('action_name')) {
      context.handle(
        _actionNameMeta,
        actionName.isAcceptableOrUnknown(data['action_name']!, _actionNameMeta),
      );
    } else if (isInserting) {
      context.missing(_actionNameMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.KeybindingMappingModelData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.KeybindingMappingModelData(
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mapId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}map_id'],
      )!,
      keyId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}key_id'],
      )!,
      ctrl: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.bool,
        data['${effectivePrefix}ctrl'],
      )!,
      shift: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.bool,
        data['${effectivePrefix}shift'],
      )!,
      alt: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.bool,
        data['${effectivePrefix}alt'],
      )!,
      meta: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.bool,
        data['${effectivePrefix}meta'],
      )!,
      actionName: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}action_name'],
      )!,
    );
  }

  @override
  $KeybindingMappingModelTable createAlias(String alias) {
    return $KeybindingMappingModelTable(attachedDatabase, alias);
  }
}

class KeybindingMappingModelData extends i0.DataClass
    implements i0.Insertable<i1.KeybindingMappingModelData> {
  final int id;
  final int mapId;
  final int keyId;
  final bool ctrl;
  final bool shift;
  final bool alt;
  final bool meta;
  final String actionName;
  const KeybindingMappingModelData({
    required this.id,
    required this.mapId,
    required this.keyId,
    required this.ctrl,
    required this.shift,
    required this.alt,
    required this.meta,
    required this.actionName,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    map['map_id'] = i0.Variable<int>(mapId);
    map['key_id'] = i0.Variable<int>(keyId);
    map['ctrl'] = i0.Variable<bool>(ctrl);
    map['shift'] = i0.Variable<bool>(shift);
    map['alt'] = i0.Variable<bool>(alt);
    map['meta'] = i0.Variable<bool>(meta);
    map['action_name'] = i0.Variable<String>(actionName);
    return map;
  }

  i1.KeybindingMappingModelCompanion toCompanion(bool nullToAbsent) {
    return i1.KeybindingMappingModelCompanion(
      id: i0.Value(id),
      mapId: i0.Value(mapId),
      keyId: i0.Value(keyId),
      ctrl: i0.Value(ctrl),
      shift: i0.Value(shift),
      alt: i0.Value(alt),
      meta: i0.Value(meta),
      actionName: i0.Value(actionName),
    );
  }

  factory KeybindingMappingModelData.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return KeybindingMappingModelData(
      id: serializer.fromJson<int>(json['id']),
      mapId: serializer.fromJson<int>(json['mapId']),
      keyId: serializer.fromJson<int>(json['keyId']),
      ctrl: serializer.fromJson<bool>(json['ctrl']),
      shift: serializer.fromJson<bool>(json['shift']),
      alt: serializer.fromJson<bool>(json['alt']),
      meta: serializer.fromJson<bool>(json['meta']),
      actionName: serializer.fromJson<String>(json['actionName']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mapId': serializer.toJson<int>(mapId),
      'keyId': serializer.toJson<int>(keyId),
      'ctrl': serializer.toJson<bool>(ctrl),
      'shift': serializer.toJson<bool>(shift),
      'alt': serializer.toJson<bool>(alt),
      'meta': serializer.toJson<bool>(meta),
      'actionName': serializer.toJson<String>(actionName),
    };
  }

  i1.KeybindingMappingModelData copyWith({
    int? id,
    int? mapId,
    int? keyId,
    bool? ctrl,
    bool? shift,
    bool? alt,
    bool? meta,
    String? actionName,
  }) => i1.KeybindingMappingModelData(
    id: id ?? this.id,
    mapId: mapId ?? this.mapId,
    keyId: keyId ?? this.keyId,
    ctrl: ctrl ?? this.ctrl,
    shift: shift ?? this.shift,
    alt: alt ?? this.alt,
    meta: meta ?? this.meta,
    actionName: actionName ?? this.actionName,
  );
  KeybindingMappingModelData copyWithCompanion(
    i1.KeybindingMappingModelCompanion data,
  ) {
    return KeybindingMappingModelData(
      id: data.id.present ? data.id.value : this.id,
      mapId: data.mapId.present ? data.mapId.value : this.mapId,
      keyId: data.keyId.present ? data.keyId.value : this.keyId,
      ctrl: data.ctrl.present ? data.ctrl.value : this.ctrl,
      shift: data.shift.present ? data.shift.value : this.shift,
      alt: data.alt.present ? data.alt.value : this.alt,
      meta: data.meta.present ? data.meta.value : this.meta,
      actionName: data.actionName.present
          ? data.actionName.value
          : this.actionName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KeybindingMappingModelData(')
          ..write('id: $id, ')
          ..write('mapId: $mapId, ')
          ..write('keyId: $keyId, ')
          ..write('ctrl: $ctrl, ')
          ..write('shift: $shift, ')
          ..write('alt: $alt, ')
          ..write('meta: $meta, ')
          ..write('actionName: $actionName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, mapId, keyId, ctrl, shift, alt, meta, actionName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.KeybindingMappingModelData &&
          other.id == this.id &&
          other.mapId == this.mapId &&
          other.keyId == this.keyId &&
          other.ctrl == this.ctrl &&
          other.shift == this.shift &&
          other.alt == this.alt &&
          other.meta == this.meta &&
          other.actionName == this.actionName);
}

class KeybindingMappingModelCompanion
    extends i0.UpdateCompanion<i1.KeybindingMappingModelData> {
  final i0.Value<int> id;
  final i0.Value<int> mapId;
  final i0.Value<int> keyId;
  final i0.Value<bool> ctrl;
  final i0.Value<bool> shift;
  final i0.Value<bool> alt;
  final i0.Value<bool> meta;
  final i0.Value<String> actionName;
  const KeybindingMappingModelCompanion({
    this.id = const i0.Value.absent(),
    this.mapId = const i0.Value.absent(),
    this.keyId = const i0.Value.absent(),
    this.ctrl = const i0.Value.absent(),
    this.shift = const i0.Value.absent(),
    this.alt = const i0.Value.absent(),
    this.meta = const i0.Value.absent(),
    this.actionName = const i0.Value.absent(),
  });
  KeybindingMappingModelCompanion.insert({
    this.id = const i0.Value.absent(),
    required int mapId,
    required int keyId,
    required bool ctrl,
    required bool shift,
    required bool alt,
    required bool meta,
    required String actionName,
  }) : mapId = i0.Value(mapId),
       keyId = i0.Value(keyId),
       ctrl = i0.Value(ctrl),
       shift = i0.Value(shift),
       alt = i0.Value(alt),
       meta = i0.Value(meta),
       actionName = i0.Value(actionName);
  static i0.Insertable<i1.KeybindingMappingModelData> custom({
    i0.Expression<int>? id,
    i0.Expression<int>? mapId,
    i0.Expression<int>? keyId,
    i0.Expression<bool>? ctrl,
    i0.Expression<bool>? shift,
    i0.Expression<bool>? alt,
    i0.Expression<bool>? meta,
    i0.Expression<String>? actionName,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (mapId != null) 'map_id': mapId,
      if (keyId != null) 'key_id': keyId,
      if (ctrl != null) 'ctrl': ctrl,
      if (shift != null) 'shift': shift,
      if (alt != null) 'alt': alt,
      if (meta != null) 'meta': meta,
      if (actionName != null) 'action_name': actionName,
    });
  }

  i1.KeybindingMappingModelCompanion copyWith({
    i0.Value<int>? id,
    i0.Value<int>? mapId,
    i0.Value<int>? keyId,
    i0.Value<bool>? ctrl,
    i0.Value<bool>? shift,
    i0.Value<bool>? alt,
    i0.Value<bool>? meta,
    i0.Value<String>? actionName,
  }) {
    return i1.KeybindingMappingModelCompanion(
      id: id ?? this.id,
      mapId: mapId ?? this.mapId,
      keyId: keyId ?? this.keyId,
      ctrl: ctrl ?? this.ctrl,
      shift: shift ?? this.shift,
      alt: alt ?? this.alt,
      meta: meta ?? this.meta,
      actionName: actionName ?? this.actionName,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (mapId.present) {
      map['map_id'] = i0.Variable<int>(mapId.value);
    }
    if (keyId.present) {
      map['key_id'] = i0.Variable<int>(keyId.value);
    }
    if (ctrl.present) {
      map['ctrl'] = i0.Variable<bool>(ctrl.value);
    }
    if (shift.present) {
      map['shift'] = i0.Variable<bool>(shift.value);
    }
    if (alt.present) {
      map['alt'] = i0.Variable<bool>(alt.value);
    }
    if (meta.present) {
      map['meta'] = i0.Variable<bool>(meta.value);
    }
    if (actionName.present) {
      map['action_name'] = i0.Variable<String>(actionName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KeybindingMappingModelCompanion(')
          ..write('id: $id, ')
          ..write('mapId: $mapId, ')
          ..write('keyId: $keyId, ')
          ..write('ctrl: $ctrl, ')
          ..write('shift: $shift, ')
          ..write('alt: $alt, ')
          ..write('meta: $meta, ')
          ..write('actionName: $actionName')
          ..write(')'))
        .toString();
  }
}

class $KeybindingMapModelTable extends i2.KeybindingMapModel
    with i0.TableInfo<$KeybindingMapModelTable, i1.KeybindingMapModelData> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KeybindingMapModelTable(this.attachedDatabase, [this._alias]);
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
  @override
  List<i0.GeneratedColumn> get $columns => [id];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'keybinding_map_model';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.KeybindingMapModelData> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.KeybindingMapModelData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.KeybindingMapModelData(
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
    );
  }

  @override
  $KeybindingMapModelTable createAlias(String alias) {
    return $KeybindingMapModelTable(attachedDatabase, alias);
  }
}

class KeybindingMapModelData extends i0.DataClass
    implements i0.Insertable<i1.KeybindingMapModelData> {
  final int id;
  const KeybindingMapModelData({required this.id});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    return map;
  }

  i1.KeybindingMapModelCompanion toCompanion(bool nullToAbsent) {
    return i1.KeybindingMapModelCompanion(id: i0.Value(id));
  }

  factory KeybindingMapModelData.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return KeybindingMapModelData(id: serializer.fromJson<int>(json['id']));
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'id': serializer.toJson<int>(id)};
  }

  i1.KeybindingMapModelData copyWith({int? id}) =>
      i1.KeybindingMapModelData(id: id ?? this.id);
  KeybindingMapModelData copyWithCompanion(
    i1.KeybindingMapModelCompanion data,
  ) {
    return KeybindingMapModelData(
      id: data.id.present ? data.id.value : this.id,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KeybindingMapModelData(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => id.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.KeybindingMapModelData && other.id == this.id);
}

class KeybindingMapModelCompanion
    extends i0.UpdateCompanion<i1.KeybindingMapModelData> {
  final i0.Value<int> id;
  const KeybindingMapModelCompanion({this.id = const i0.Value.absent()});
  KeybindingMapModelCompanion.insert({this.id = const i0.Value.absent()});
  static i0.Insertable<i1.KeybindingMapModelData> custom({
    i0.Expression<int>? id,
  }) {
    return i0.RawValuesInsertable({if (id != null) 'id': id});
  }

  i1.KeybindingMapModelCompanion copyWith({i0.Value<int>? id}) {
    return i1.KeybindingMapModelCompanion(id: id ?? this.id);
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KeybindingMapModelCompanion(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }
}
