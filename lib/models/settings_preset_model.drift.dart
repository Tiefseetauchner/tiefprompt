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
      required double scrollSpeed,
      required bool mirroredX,
      required bool mirroredY,
      required double fontSize,
      required double sideMargin,
      required String fontFamily,
      required String alignment,
      required bool displayReadingIndicatorBoxes,
      required double readingIndicatorBoxesHeight,
      required bool displayVerticalMarginBoxes,
      required double verticalMarginBoxesHeight,
      required bool verticalMarginBoxesFadeEnabled,
      required double verticalMarginBoxesFadeLength,
      required double countdownDuration,
      required String themeMode,
      required int appPrimaryColor,
      required int prompterBackgroundColor,
      required int prompterTextColor,
      required bool markdownEnabled,
      required int keybindings,
    });
typedef $$SettingsPresetModelTableUpdateCompanionBuilder =
    i1.SettingsPresetModelCompanion Function({
      i0.Value<int> id,
      i0.Value<String> name,
      i0.Value<DateTime> createdAt,
      i0.Value<double> scrollSpeed,
      i0.Value<bool> mirroredX,
      i0.Value<bool> mirroredY,
      i0.Value<double> fontSize,
      i0.Value<double> sideMargin,
      i0.Value<String> fontFamily,
      i0.Value<String> alignment,
      i0.Value<bool> displayReadingIndicatorBoxes,
      i0.Value<double> readingIndicatorBoxesHeight,
      i0.Value<bool> displayVerticalMarginBoxes,
      i0.Value<double> verticalMarginBoxesHeight,
      i0.Value<bool> verticalMarginBoxesFadeEnabled,
      i0.Value<double> verticalMarginBoxesFadeLength,
      i0.Value<double> countdownDuration,
      i0.Value<String> themeMode,
      i0.Value<int> appPrimaryColor,
      i0.Value<int> prompterBackgroundColor,
      i0.Value<int> prompterTextColor,
      i0.Value<bool> markdownEnabled,
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

  i0.ColumnFilters<double> get scrollSpeed => $composableBuilder(
    column: $table.scrollSpeed,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<bool> get mirroredX => $composableBuilder(
    column: $table.mirroredX,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<bool> get mirroredY => $composableBuilder(
    column: $table.mirroredY,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<double> get fontSize => $composableBuilder(
    column: $table.fontSize,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<double> get sideMargin => $composableBuilder(
    column: $table.sideMargin,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get fontFamily => $composableBuilder(
    column: $table.fontFamily,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get alignment => $composableBuilder(
    column: $table.alignment,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<bool> get displayReadingIndicatorBoxes => $composableBuilder(
    column: $table.displayReadingIndicatorBoxes,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<double> get readingIndicatorBoxesHeight =>
      $composableBuilder(
        column: $table.readingIndicatorBoxesHeight,
        builder: (column) => i0.ColumnFilters(column),
      );

  i0.ColumnFilters<bool> get displayVerticalMarginBoxes => $composableBuilder(
    column: $table.displayVerticalMarginBoxes,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<double> get verticalMarginBoxesHeight => $composableBuilder(
    column: $table.verticalMarginBoxesHeight,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<bool> get verticalMarginBoxesFadeEnabled =>
      $composableBuilder(
        column: $table.verticalMarginBoxesFadeEnabled,
        builder: (column) => i0.ColumnFilters(column),
      );

  i0.ColumnFilters<double> get verticalMarginBoxesFadeLength =>
      $composableBuilder(
        column: $table.verticalMarginBoxesFadeLength,
        builder: (column) => i0.ColumnFilters(column),
      );

  i0.ColumnFilters<double> get countdownDuration => $composableBuilder(
    column: $table.countdownDuration,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get appPrimaryColor => $composableBuilder(
    column: $table.appPrimaryColor,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get prompterBackgroundColor => $composableBuilder(
    column: $table.prompterBackgroundColor,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get prompterTextColor => $composableBuilder(
    column: $table.prompterTextColor,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<bool> get markdownEnabled => $composableBuilder(
    column: $table.markdownEnabled,
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

  i0.ColumnOrderings<double> get scrollSpeed => $composableBuilder(
    column: $table.scrollSpeed,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<bool> get mirroredX => $composableBuilder(
    column: $table.mirroredX,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<bool> get mirroredY => $composableBuilder(
    column: $table.mirroredY,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<double> get fontSize => $composableBuilder(
    column: $table.fontSize,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<double> get sideMargin => $composableBuilder(
    column: $table.sideMargin,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get fontFamily => $composableBuilder(
    column: $table.fontFamily,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get alignment => $composableBuilder(
    column: $table.alignment,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<bool> get displayReadingIndicatorBoxes =>
      $composableBuilder(
        column: $table.displayReadingIndicatorBoxes,
        builder: (column) => i0.ColumnOrderings(column),
      );

  i0.ColumnOrderings<double> get readingIndicatorBoxesHeight =>
      $composableBuilder(
        column: $table.readingIndicatorBoxesHeight,
        builder: (column) => i0.ColumnOrderings(column),
      );

  i0.ColumnOrderings<bool> get displayVerticalMarginBoxes => $composableBuilder(
    column: $table.displayVerticalMarginBoxes,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<double> get verticalMarginBoxesHeight =>
      $composableBuilder(
        column: $table.verticalMarginBoxesHeight,
        builder: (column) => i0.ColumnOrderings(column),
      );

  i0.ColumnOrderings<bool> get verticalMarginBoxesFadeEnabled =>
      $composableBuilder(
        column: $table.verticalMarginBoxesFadeEnabled,
        builder: (column) => i0.ColumnOrderings(column),
      );

  i0.ColumnOrderings<double> get verticalMarginBoxesFadeLength =>
      $composableBuilder(
        column: $table.verticalMarginBoxesFadeLength,
        builder: (column) => i0.ColumnOrderings(column),
      );

  i0.ColumnOrderings<double> get countdownDuration => $composableBuilder(
    column: $table.countdownDuration,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get appPrimaryColor => $composableBuilder(
    column: $table.appPrimaryColor,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get prompterBackgroundColor => $composableBuilder(
    column: $table.prompterBackgroundColor,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get prompterTextColor => $composableBuilder(
    column: $table.prompterTextColor,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<bool> get markdownEnabled => $composableBuilder(
    column: $table.markdownEnabled,
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

  i0.GeneratedColumn<double> get scrollSpeed => $composableBuilder(
    column: $table.scrollSpeed,
    builder: (column) => column,
  );

  i0.GeneratedColumn<bool> get mirroredX =>
      $composableBuilder(column: $table.mirroredX, builder: (column) => column);

  i0.GeneratedColumn<bool> get mirroredY =>
      $composableBuilder(column: $table.mirroredY, builder: (column) => column);

  i0.GeneratedColumn<double> get fontSize =>
      $composableBuilder(column: $table.fontSize, builder: (column) => column);

  i0.GeneratedColumn<double> get sideMargin => $composableBuilder(
    column: $table.sideMargin,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get fontFamily => $composableBuilder(
    column: $table.fontFamily,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get alignment =>
      $composableBuilder(column: $table.alignment, builder: (column) => column);

  i0.GeneratedColumn<bool> get displayReadingIndicatorBoxes =>
      $composableBuilder(
        column: $table.displayReadingIndicatorBoxes,
        builder: (column) => column,
      );

  i0.GeneratedColumn<double> get readingIndicatorBoxesHeight =>
      $composableBuilder(
        column: $table.readingIndicatorBoxesHeight,
        builder: (column) => column,
      );

  i0.GeneratedColumn<bool> get displayVerticalMarginBoxes => $composableBuilder(
    column: $table.displayVerticalMarginBoxes,
    builder: (column) => column,
  );

  i0.GeneratedColumn<double> get verticalMarginBoxesHeight =>
      $composableBuilder(
        column: $table.verticalMarginBoxesHeight,
        builder: (column) => column,
      );

  i0.GeneratedColumn<bool> get verticalMarginBoxesFadeEnabled =>
      $composableBuilder(
        column: $table.verticalMarginBoxesFadeEnabled,
        builder: (column) => column,
      );

  i0.GeneratedColumn<double> get verticalMarginBoxesFadeLength =>
      $composableBuilder(
        column: $table.verticalMarginBoxesFadeLength,
        builder: (column) => column,
      );

  i0.GeneratedColumn<double> get countdownDuration => $composableBuilder(
    column: $table.countdownDuration,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  i0.GeneratedColumn<int> get appPrimaryColor => $composableBuilder(
    column: $table.appPrimaryColor,
    builder: (column) => column,
  );

  i0.GeneratedColumn<int> get prompterBackgroundColor => $composableBuilder(
    column: $table.prompterBackgroundColor,
    builder: (column) => column,
  );

  i0.GeneratedColumn<int> get prompterTextColor => $composableBuilder(
    column: $table.prompterTextColor,
    builder: (column) => column,
  );

  i0.GeneratedColumn<bool> get markdownEnabled => $composableBuilder(
    column: $table.markdownEnabled,
    builder: (column) => column,
  );

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
                i0.Value<double> scrollSpeed = const i0.Value.absent(),
                i0.Value<bool> mirroredX = const i0.Value.absent(),
                i0.Value<bool> mirroredY = const i0.Value.absent(),
                i0.Value<double> fontSize = const i0.Value.absent(),
                i0.Value<double> sideMargin = const i0.Value.absent(),
                i0.Value<String> fontFamily = const i0.Value.absent(),
                i0.Value<String> alignment = const i0.Value.absent(),
                i0.Value<bool> displayReadingIndicatorBoxes =
                    const i0.Value.absent(),
                i0.Value<double> readingIndicatorBoxesHeight =
                    const i0.Value.absent(),
                i0.Value<bool> displayVerticalMarginBoxes =
                    const i0.Value.absent(),
                i0.Value<double> verticalMarginBoxesHeight =
                    const i0.Value.absent(),
                i0.Value<bool> verticalMarginBoxesFadeEnabled =
                    const i0.Value.absent(),
                i0.Value<double> verticalMarginBoxesFadeLength =
                    const i0.Value.absent(),
                i0.Value<double> countdownDuration = const i0.Value.absent(),
                i0.Value<String> themeMode = const i0.Value.absent(),
                i0.Value<int> appPrimaryColor = const i0.Value.absent(),
                i0.Value<int> prompterBackgroundColor = const i0.Value.absent(),
                i0.Value<int> prompterTextColor = const i0.Value.absent(),
                i0.Value<bool> markdownEnabled = const i0.Value.absent(),
                i0.Value<int> keybindings = const i0.Value.absent(),
              }) => i1.SettingsPresetModelCompanion(
                id: id,
                name: name,
                createdAt: createdAt,
                scrollSpeed: scrollSpeed,
                mirroredX: mirroredX,
                mirroredY: mirroredY,
                fontSize: fontSize,
                sideMargin: sideMargin,
                fontFamily: fontFamily,
                alignment: alignment,
                displayReadingIndicatorBoxes: displayReadingIndicatorBoxes,
                readingIndicatorBoxesHeight: readingIndicatorBoxesHeight,
                displayVerticalMarginBoxes: displayVerticalMarginBoxes,
                verticalMarginBoxesHeight: verticalMarginBoxesHeight,
                verticalMarginBoxesFadeEnabled: verticalMarginBoxesFadeEnabled,
                verticalMarginBoxesFadeLength: verticalMarginBoxesFadeLength,
                countdownDuration: countdownDuration,
                themeMode: themeMode,
                appPrimaryColor: appPrimaryColor,
                prompterBackgroundColor: prompterBackgroundColor,
                prompterTextColor: prompterTextColor,
                markdownEnabled: markdownEnabled,
                keybindings: keybindings,
              ),
          createCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                required String name,
                required DateTime createdAt,
                required double scrollSpeed,
                required bool mirroredX,
                required bool mirroredY,
                required double fontSize,
                required double sideMargin,
                required String fontFamily,
                required String alignment,
                required bool displayReadingIndicatorBoxes,
                required double readingIndicatorBoxesHeight,
                required bool displayVerticalMarginBoxes,
                required double verticalMarginBoxesHeight,
                required bool verticalMarginBoxesFadeEnabled,
                required double verticalMarginBoxesFadeLength,
                required double countdownDuration,
                required String themeMode,
                required int appPrimaryColor,
                required int prompterBackgroundColor,
                required int prompterTextColor,
                required bool markdownEnabled,
                required int keybindings,
              }) => i1.SettingsPresetModelCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
                scrollSpeed: scrollSpeed,
                mirroredX: mirroredX,
                mirroredY: mirroredY,
                fontSize: fontSize,
                sideMargin: sideMargin,
                fontFamily: fontFamily,
                alignment: alignment,
                displayReadingIndicatorBoxes: displayReadingIndicatorBoxes,
                readingIndicatorBoxesHeight: readingIndicatorBoxesHeight,
                displayVerticalMarginBoxes: displayVerticalMarginBoxes,
                verticalMarginBoxesHeight: verticalMarginBoxesHeight,
                verticalMarginBoxesFadeEnabled: verticalMarginBoxesFadeEnabled,
                verticalMarginBoxesFadeLength: verticalMarginBoxesFadeLength,
                countdownDuration: countdownDuration,
                themeMode: themeMode,
                appPrimaryColor: appPrimaryColor,
                prompterBackgroundColor: prompterBackgroundColor,
                prompterTextColor: prompterTextColor,
                markdownEnabled: markdownEnabled,
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
  static const i0.VerificationMeta _scrollSpeedMeta = const i0.VerificationMeta(
    'scrollSpeed',
  );
  @override
  late final i0.GeneratedColumn<double> scrollSpeed =
      i0.GeneratedColumn<double>(
        'scroll_speed',
        aliasedName,
        false,
        type: i0.DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const i0.VerificationMeta _mirroredXMeta = const i0.VerificationMeta(
    'mirroredX',
  );
  @override
  late final i0.GeneratedColumn<bool> mirroredX = i0.GeneratedColumn<bool>(
    'mirrored_x',
    aliasedName,
    false,
    type: i0.DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
      'CHECK ("mirrored_x" IN (0, 1))',
    ),
  );
  static const i0.VerificationMeta _mirroredYMeta = const i0.VerificationMeta(
    'mirroredY',
  );
  @override
  late final i0.GeneratedColumn<bool> mirroredY = i0.GeneratedColumn<bool>(
    'mirrored_y',
    aliasedName,
    false,
    type: i0.DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
      'CHECK ("mirrored_y" IN (0, 1))',
    ),
  );
  static const i0.VerificationMeta _fontSizeMeta = const i0.VerificationMeta(
    'fontSize',
  );
  @override
  late final i0.GeneratedColumn<double> fontSize = i0.GeneratedColumn<double>(
    'font_size',
    aliasedName,
    false,
    type: i0.DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const i0.VerificationMeta _sideMarginMeta = const i0.VerificationMeta(
    'sideMargin',
  );
  @override
  late final i0.GeneratedColumn<double> sideMargin = i0.GeneratedColumn<double>(
    'side_margin',
    aliasedName,
    false,
    type: i0.DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const i0.VerificationMeta _fontFamilyMeta = const i0.VerificationMeta(
    'fontFamily',
  );
  @override
  late final i0.GeneratedColumn<String> fontFamily = i0.GeneratedColumn<String>(
    'font_family',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const i0.VerificationMeta _alignmentMeta = const i0.VerificationMeta(
    'alignment',
  );
  @override
  late final i0.GeneratedColumn<String> alignment = i0.GeneratedColumn<String>(
    'alignment',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const i0.VerificationMeta _displayReadingIndicatorBoxesMeta =
      const i0.VerificationMeta('displayReadingIndicatorBoxes');
  @override
  late final i0.GeneratedColumn<bool> displayReadingIndicatorBoxes =
      i0.GeneratedColumn<bool>(
        'display_reading_indicator_boxes',
        aliasedName,
        false,
        type: i0.DriftSqlType.bool,
        requiredDuringInsert: true,
        defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
          'CHECK ("display_reading_indicator_boxes" IN (0, 1))',
        ),
      );
  static const i0.VerificationMeta _readingIndicatorBoxesHeightMeta =
      const i0.VerificationMeta('readingIndicatorBoxesHeight');
  @override
  late final i0.GeneratedColumn<double> readingIndicatorBoxesHeight =
      i0.GeneratedColumn<double>(
        'reading_indicator_boxes_height',
        aliasedName,
        false,
        type: i0.DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const i0.VerificationMeta _displayVerticalMarginBoxesMeta =
      const i0.VerificationMeta('displayVerticalMarginBoxes');
  @override
  late final i0.GeneratedColumn<bool> displayVerticalMarginBoxes =
      i0.GeneratedColumn<bool>(
        'display_vertical_margin_boxes',
        aliasedName,
        false,
        type: i0.DriftSqlType.bool,
        requiredDuringInsert: true,
        defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
          'CHECK ("display_vertical_margin_boxes" IN (0, 1))',
        ),
      );
  static const i0.VerificationMeta _verticalMarginBoxesHeightMeta =
      const i0.VerificationMeta('verticalMarginBoxesHeight');
  @override
  late final i0.GeneratedColumn<double> verticalMarginBoxesHeight =
      i0.GeneratedColumn<double>(
        'vertical_margin_boxes_height',
        aliasedName,
        false,
        type: i0.DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const i0.VerificationMeta _verticalMarginBoxesFadeEnabledMeta =
      const i0.VerificationMeta('verticalMarginBoxesFadeEnabled');
  @override
  late final i0.GeneratedColumn<bool> verticalMarginBoxesFadeEnabled =
      i0.GeneratedColumn<bool>(
        'vertical_margin_boxes_fade_enabled',
        aliasedName,
        false,
        type: i0.DriftSqlType.bool,
        requiredDuringInsert: true,
        defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
          'CHECK ("vertical_margin_boxes_fade_enabled" IN (0, 1))',
        ),
      );
  static const i0.VerificationMeta _verticalMarginBoxesFadeLengthMeta =
      const i0.VerificationMeta('verticalMarginBoxesFadeLength');
  @override
  late final i0.GeneratedColumn<double> verticalMarginBoxesFadeLength =
      i0.GeneratedColumn<double>(
        'vertical_margin_boxes_fade_length',
        aliasedName,
        false,
        type: i0.DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const i0.VerificationMeta _countdownDurationMeta =
      const i0.VerificationMeta('countdownDuration');
  @override
  late final i0.GeneratedColumn<double> countdownDuration =
      i0.GeneratedColumn<double>(
        'countdown_duration',
        aliasedName,
        false,
        type: i0.DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const i0.VerificationMeta _themeModeMeta = const i0.VerificationMeta(
    'themeMode',
  );
  @override
  late final i0.GeneratedColumn<String> themeMode = i0.GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const i0.VerificationMeta _appPrimaryColorMeta =
      const i0.VerificationMeta('appPrimaryColor');
  @override
  late final i0.GeneratedColumn<int> appPrimaryColor = i0.GeneratedColumn<int>(
    'app_primary_color',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const i0.VerificationMeta _prompterBackgroundColorMeta =
      const i0.VerificationMeta('prompterBackgroundColor');
  @override
  late final i0.GeneratedColumn<int> prompterBackgroundColor =
      i0.GeneratedColumn<int>(
        'prompter_background_color',
        aliasedName,
        false,
        type: i0.DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const i0.VerificationMeta _prompterTextColorMeta =
      const i0.VerificationMeta('prompterTextColor');
  @override
  late final i0.GeneratedColumn<int> prompterTextColor =
      i0.GeneratedColumn<int>(
        'prompter_text_color',
        aliasedName,
        false,
        type: i0.DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const i0.VerificationMeta _markdownEnabledMeta =
      const i0.VerificationMeta('markdownEnabled');
  @override
  late final i0.GeneratedColumn<bool> markdownEnabled =
      i0.GeneratedColumn<bool>(
        'markdown_enabled',
        aliasedName,
        false,
        type: i0.DriftSqlType.bool,
        requiredDuringInsert: true,
        defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
          'CHECK ("markdown_enabled" IN (0, 1))',
        ),
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
    scrollSpeed,
    mirroredX,
    mirroredY,
    fontSize,
    sideMargin,
    fontFamily,
    alignment,
    displayReadingIndicatorBoxes,
    readingIndicatorBoxesHeight,
    displayVerticalMarginBoxes,
    verticalMarginBoxesHeight,
    verticalMarginBoxesFadeEnabled,
    verticalMarginBoxesFadeLength,
    countdownDuration,
    themeMode,
    appPrimaryColor,
    prompterBackgroundColor,
    prompterTextColor,
    markdownEnabled,
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
    if (data.containsKey('scroll_speed')) {
      context.handle(
        _scrollSpeedMeta,
        scrollSpeed.isAcceptableOrUnknown(
          data['scroll_speed']!,
          _scrollSpeedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scrollSpeedMeta);
    }
    if (data.containsKey('mirrored_x')) {
      context.handle(
        _mirroredXMeta,
        mirroredX.isAcceptableOrUnknown(data['mirrored_x']!, _mirroredXMeta),
      );
    } else if (isInserting) {
      context.missing(_mirroredXMeta);
    }
    if (data.containsKey('mirrored_y')) {
      context.handle(
        _mirroredYMeta,
        mirroredY.isAcceptableOrUnknown(data['mirrored_y']!, _mirroredYMeta),
      );
    } else if (isInserting) {
      context.missing(_mirroredYMeta);
    }
    if (data.containsKey('font_size')) {
      context.handle(
        _fontSizeMeta,
        fontSize.isAcceptableOrUnknown(data['font_size']!, _fontSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_fontSizeMeta);
    }
    if (data.containsKey('side_margin')) {
      context.handle(
        _sideMarginMeta,
        sideMargin.isAcceptableOrUnknown(data['side_margin']!, _sideMarginMeta),
      );
    } else if (isInserting) {
      context.missing(_sideMarginMeta);
    }
    if (data.containsKey('font_family')) {
      context.handle(
        _fontFamilyMeta,
        fontFamily.isAcceptableOrUnknown(data['font_family']!, _fontFamilyMeta),
      );
    } else if (isInserting) {
      context.missing(_fontFamilyMeta);
    }
    if (data.containsKey('alignment')) {
      context.handle(
        _alignmentMeta,
        alignment.isAcceptableOrUnknown(data['alignment']!, _alignmentMeta),
      );
    } else if (isInserting) {
      context.missing(_alignmentMeta);
    }
    if (data.containsKey('display_reading_indicator_boxes')) {
      context.handle(
        _displayReadingIndicatorBoxesMeta,
        displayReadingIndicatorBoxes.isAcceptableOrUnknown(
          data['display_reading_indicator_boxes']!,
          _displayReadingIndicatorBoxesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayReadingIndicatorBoxesMeta);
    }
    if (data.containsKey('reading_indicator_boxes_height')) {
      context.handle(
        _readingIndicatorBoxesHeightMeta,
        readingIndicatorBoxesHeight.isAcceptableOrUnknown(
          data['reading_indicator_boxes_height']!,
          _readingIndicatorBoxesHeightMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_readingIndicatorBoxesHeightMeta);
    }
    if (data.containsKey('display_vertical_margin_boxes')) {
      context.handle(
        _displayVerticalMarginBoxesMeta,
        displayVerticalMarginBoxes.isAcceptableOrUnknown(
          data['display_vertical_margin_boxes']!,
          _displayVerticalMarginBoxesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayVerticalMarginBoxesMeta);
    }
    if (data.containsKey('vertical_margin_boxes_height')) {
      context.handle(
        _verticalMarginBoxesHeightMeta,
        verticalMarginBoxesHeight.isAcceptableOrUnknown(
          data['vertical_margin_boxes_height']!,
          _verticalMarginBoxesHeightMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_verticalMarginBoxesHeightMeta);
    }
    if (data.containsKey('vertical_margin_boxes_fade_enabled')) {
      context.handle(
        _verticalMarginBoxesFadeEnabledMeta,
        verticalMarginBoxesFadeEnabled.isAcceptableOrUnknown(
          data['vertical_margin_boxes_fade_enabled']!,
          _verticalMarginBoxesFadeEnabledMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_verticalMarginBoxesFadeEnabledMeta);
    }
    if (data.containsKey('vertical_margin_boxes_fade_length')) {
      context.handle(
        _verticalMarginBoxesFadeLengthMeta,
        verticalMarginBoxesFadeLength.isAcceptableOrUnknown(
          data['vertical_margin_boxes_fade_length']!,
          _verticalMarginBoxesFadeLengthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_verticalMarginBoxesFadeLengthMeta);
    }
    if (data.containsKey('countdown_duration')) {
      context.handle(
        _countdownDurationMeta,
        countdownDuration.isAcceptableOrUnknown(
          data['countdown_duration']!,
          _countdownDurationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_countdownDurationMeta);
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    } else if (isInserting) {
      context.missing(_themeModeMeta);
    }
    if (data.containsKey('app_primary_color')) {
      context.handle(
        _appPrimaryColorMeta,
        appPrimaryColor.isAcceptableOrUnknown(
          data['app_primary_color']!,
          _appPrimaryColorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_appPrimaryColorMeta);
    }
    if (data.containsKey('prompter_background_color')) {
      context.handle(
        _prompterBackgroundColorMeta,
        prompterBackgroundColor.isAcceptableOrUnknown(
          data['prompter_background_color']!,
          _prompterBackgroundColorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_prompterBackgroundColorMeta);
    }
    if (data.containsKey('prompter_text_color')) {
      context.handle(
        _prompterTextColorMeta,
        prompterTextColor.isAcceptableOrUnknown(
          data['prompter_text_color']!,
          _prompterTextColorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_prompterTextColorMeta);
    }
    if (data.containsKey('markdown_enabled')) {
      context.handle(
        _markdownEnabledMeta,
        markdownEnabled.isAcceptableOrUnknown(
          data['markdown_enabled']!,
          _markdownEnabledMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_markdownEnabledMeta);
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
      scrollSpeed: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.double,
        data['${effectivePrefix}scroll_speed'],
      )!,
      mirroredX: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.bool,
        data['${effectivePrefix}mirrored_x'],
      )!,
      mirroredY: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.bool,
        data['${effectivePrefix}mirrored_y'],
      )!,
      fontSize: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.double,
        data['${effectivePrefix}font_size'],
      )!,
      sideMargin: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.double,
        data['${effectivePrefix}side_margin'],
      )!,
      fontFamily: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}font_family'],
      )!,
      alignment: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}alignment'],
      )!,
      displayReadingIndicatorBoxes: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.bool,
        data['${effectivePrefix}display_reading_indicator_boxes'],
      )!,
      readingIndicatorBoxesHeight: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.double,
        data['${effectivePrefix}reading_indicator_boxes_height'],
      )!,
      displayVerticalMarginBoxes: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.bool,
        data['${effectivePrefix}display_vertical_margin_boxes'],
      )!,
      verticalMarginBoxesHeight: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.double,
        data['${effectivePrefix}vertical_margin_boxes_height'],
      )!,
      verticalMarginBoxesFadeEnabled: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.bool,
        data['${effectivePrefix}vertical_margin_boxes_fade_enabled'],
      )!,
      verticalMarginBoxesFadeLength: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.double,
        data['${effectivePrefix}vertical_margin_boxes_fade_length'],
      )!,
      countdownDuration: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.double,
        data['${effectivePrefix}countdown_duration'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      appPrimaryColor: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}app_primary_color'],
      )!,
      prompterBackgroundColor: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}prompter_background_color'],
      )!,
      prompterTextColor: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}prompter_text_color'],
      )!,
      markdownEnabled: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.bool,
        data['${effectivePrefix}markdown_enabled'],
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
  final double scrollSpeed;
  final bool mirroredX;
  final bool mirroredY;
  final double fontSize;
  final double sideMargin;
  final String fontFamily;
  final String alignment;
  final bool displayReadingIndicatorBoxes;
  final double readingIndicatorBoxesHeight;
  final bool displayVerticalMarginBoxes;
  final double verticalMarginBoxesHeight;
  final bool verticalMarginBoxesFadeEnabled;
  final double verticalMarginBoxesFadeLength;
  final double countdownDuration;
  final String themeMode;
  final int appPrimaryColor;
  final int prompterBackgroundColor;
  final int prompterTextColor;
  final bool markdownEnabled;
  final int keybindings;
  const SettingsPresetModelData({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.scrollSpeed,
    required this.mirroredX,
    required this.mirroredY,
    required this.fontSize,
    required this.sideMargin,
    required this.fontFamily,
    required this.alignment,
    required this.displayReadingIndicatorBoxes,
    required this.readingIndicatorBoxesHeight,
    required this.displayVerticalMarginBoxes,
    required this.verticalMarginBoxesHeight,
    required this.verticalMarginBoxesFadeEnabled,
    required this.verticalMarginBoxesFadeLength,
    required this.countdownDuration,
    required this.themeMode,
    required this.appPrimaryColor,
    required this.prompterBackgroundColor,
    required this.prompterTextColor,
    required this.markdownEnabled,
    required this.keybindings,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    map['name'] = i0.Variable<String>(name);
    map['created_at'] = i0.Variable<DateTime>(createdAt);
    map['scroll_speed'] = i0.Variable<double>(scrollSpeed);
    map['mirrored_x'] = i0.Variable<bool>(mirroredX);
    map['mirrored_y'] = i0.Variable<bool>(mirroredY);
    map['font_size'] = i0.Variable<double>(fontSize);
    map['side_margin'] = i0.Variable<double>(sideMargin);
    map['font_family'] = i0.Variable<String>(fontFamily);
    map['alignment'] = i0.Variable<String>(alignment);
    map['display_reading_indicator_boxes'] = i0.Variable<bool>(
      displayReadingIndicatorBoxes,
    );
    map['reading_indicator_boxes_height'] = i0.Variable<double>(
      readingIndicatorBoxesHeight,
    );
    map['display_vertical_margin_boxes'] = i0.Variable<bool>(
      displayVerticalMarginBoxes,
    );
    map['vertical_margin_boxes_height'] = i0.Variable<double>(
      verticalMarginBoxesHeight,
    );
    map['vertical_margin_boxes_fade_enabled'] = i0.Variable<bool>(
      verticalMarginBoxesFadeEnabled,
    );
    map['vertical_margin_boxes_fade_length'] = i0.Variable<double>(
      verticalMarginBoxesFadeLength,
    );
    map['countdown_duration'] = i0.Variable<double>(countdownDuration);
    map['theme_mode'] = i0.Variable<String>(themeMode);
    map['app_primary_color'] = i0.Variable<int>(appPrimaryColor);
    map['prompter_background_color'] = i0.Variable<int>(
      prompterBackgroundColor,
    );
    map['prompter_text_color'] = i0.Variable<int>(prompterTextColor);
    map['markdown_enabled'] = i0.Variable<bool>(markdownEnabled);
    map['keybindings'] = i0.Variable<int>(keybindings);
    return map;
  }

  i1.SettingsPresetModelCompanion toCompanion(bool nullToAbsent) {
    return i1.SettingsPresetModelCompanion(
      id: i0.Value(id),
      name: i0.Value(name),
      createdAt: i0.Value(createdAt),
      scrollSpeed: i0.Value(scrollSpeed),
      mirroredX: i0.Value(mirroredX),
      mirroredY: i0.Value(mirroredY),
      fontSize: i0.Value(fontSize),
      sideMargin: i0.Value(sideMargin),
      fontFamily: i0.Value(fontFamily),
      alignment: i0.Value(alignment),
      displayReadingIndicatorBoxes: i0.Value(displayReadingIndicatorBoxes),
      readingIndicatorBoxesHeight: i0.Value(readingIndicatorBoxesHeight),
      displayVerticalMarginBoxes: i0.Value(displayVerticalMarginBoxes),
      verticalMarginBoxesHeight: i0.Value(verticalMarginBoxesHeight),
      verticalMarginBoxesFadeEnabled: i0.Value(verticalMarginBoxesFadeEnabled),
      verticalMarginBoxesFadeLength: i0.Value(verticalMarginBoxesFadeLength),
      countdownDuration: i0.Value(countdownDuration),
      themeMode: i0.Value(themeMode),
      appPrimaryColor: i0.Value(appPrimaryColor),
      prompterBackgroundColor: i0.Value(prompterBackgroundColor),
      prompterTextColor: i0.Value(prompterTextColor),
      markdownEnabled: i0.Value(markdownEnabled),
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
      scrollSpeed: serializer.fromJson<double>(json['scrollSpeed']),
      mirroredX: serializer.fromJson<bool>(json['mirroredX']),
      mirroredY: serializer.fromJson<bool>(json['mirroredY']),
      fontSize: serializer.fromJson<double>(json['fontSize']),
      sideMargin: serializer.fromJson<double>(json['sideMargin']),
      fontFamily: serializer.fromJson<String>(json['fontFamily']),
      alignment: serializer.fromJson<String>(json['alignment']),
      displayReadingIndicatorBoxes: serializer.fromJson<bool>(
        json['displayReadingIndicatorBoxes'],
      ),
      readingIndicatorBoxesHeight: serializer.fromJson<double>(
        json['readingIndicatorBoxesHeight'],
      ),
      displayVerticalMarginBoxes: serializer.fromJson<bool>(
        json['displayVerticalMarginBoxes'],
      ),
      verticalMarginBoxesHeight: serializer.fromJson<double>(
        json['verticalMarginBoxesHeight'],
      ),
      verticalMarginBoxesFadeEnabled: serializer.fromJson<bool>(
        json['verticalMarginBoxesFadeEnabled'],
      ),
      verticalMarginBoxesFadeLength: serializer.fromJson<double>(
        json['verticalMarginBoxesFadeLength'],
      ),
      countdownDuration: serializer.fromJson<double>(json['countdownDuration']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      appPrimaryColor: serializer.fromJson<int>(json['appPrimaryColor']),
      prompterBackgroundColor: serializer.fromJson<int>(
        json['prompterBackgroundColor'],
      ),
      prompterTextColor: serializer.fromJson<int>(json['prompterTextColor']),
      markdownEnabled: serializer.fromJson<bool>(json['markdownEnabled']),
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
      'scrollSpeed': serializer.toJson<double>(scrollSpeed),
      'mirroredX': serializer.toJson<bool>(mirroredX),
      'mirroredY': serializer.toJson<bool>(mirroredY),
      'fontSize': serializer.toJson<double>(fontSize),
      'sideMargin': serializer.toJson<double>(sideMargin),
      'fontFamily': serializer.toJson<String>(fontFamily),
      'alignment': serializer.toJson<String>(alignment),
      'displayReadingIndicatorBoxes': serializer.toJson<bool>(
        displayReadingIndicatorBoxes,
      ),
      'readingIndicatorBoxesHeight': serializer.toJson<double>(
        readingIndicatorBoxesHeight,
      ),
      'displayVerticalMarginBoxes': serializer.toJson<bool>(
        displayVerticalMarginBoxes,
      ),
      'verticalMarginBoxesHeight': serializer.toJson<double>(
        verticalMarginBoxesHeight,
      ),
      'verticalMarginBoxesFadeEnabled': serializer.toJson<bool>(
        verticalMarginBoxesFadeEnabled,
      ),
      'verticalMarginBoxesFadeLength': serializer.toJson<double>(
        verticalMarginBoxesFadeLength,
      ),
      'countdownDuration': serializer.toJson<double>(countdownDuration),
      'themeMode': serializer.toJson<String>(themeMode),
      'appPrimaryColor': serializer.toJson<int>(appPrimaryColor),
      'prompterBackgroundColor': serializer.toJson<int>(
        prompterBackgroundColor,
      ),
      'prompterTextColor': serializer.toJson<int>(prompterTextColor),
      'markdownEnabled': serializer.toJson<bool>(markdownEnabled),
      'keybindings': serializer.toJson<int>(keybindings),
    };
  }

  i1.SettingsPresetModelData copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    double? scrollSpeed,
    bool? mirroredX,
    bool? mirroredY,
    double? fontSize,
    double? sideMargin,
    String? fontFamily,
    String? alignment,
    bool? displayReadingIndicatorBoxes,
    double? readingIndicatorBoxesHeight,
    bool? displayVerticalMarginBoxes,
    double? verticalMarginBoxesHeight,
    bool? verticalMarginBoxesFadeEnabled,
    double? verticalMarginBoxesFadeLength,
    double? countdownDuration,
    String? themeMode,
    int? appPrimaryColor,
    int? prompterBackgroundColor,
    int? prompterTextColor,
    bool? markdownEnabled,
    int? keybindings,
  }) => i1.SettingsPresetModelData(
    id: id ?? this.id,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    scrollSpeed: scrollSpeed ?? this.scrollSpeed,
    mirroredX: mirroredX ?? this.mirroredX,
    mirroredY: mirroredY ?? this.mirroredY,
    fontSize: fontSize ?? this.fontSize,
    sideMargin: sideMargin ?? this.sideMargin,
    fontFamily: fontFamily ?? this.fontFamily,
    alignment: alignment ?? this.alignment,
    displayReadingIndicatorBoxes:
        displayReadingIndicatorBoxes ?? this.displayReadingIndicatorBoxes,
    readingIndicatorBoxesHeight:
        readingIndicatorBoxesHeight ?? this.readingIndicatorBoxesHeight,
    displayVerticalMarginBoxes:
        displayVerticalMarginBoxes ?? this.displayVerticalMarginBoxes,
    verticalMarginBoxesHeight:
        verticalMarginBoxesHeight ?? this.verticalMarginBoxesHeight,
    verticalMarginBoxesFadeEnabled:
        verticalMarginBoxesFadeEnabled ?? this.verticalMarginBoxesFadeEnabled,
    verticalMarginBoxesFadeLength:
        verticalMarginBoxesFadeLength ?? this.verticalMarginBoxesFadeLength,
    countdownDuration: countdownDuration ?? this.countdownDuration,
    themeMode: themeMode ?? this.themeMode,
    appPrimaryColor: appPrimaryColor ?? this.appPrimaryColor,
    prompterBackgroundColor:
        prompterBackgroundColor ?? this.prompterBackgroundColor,
    prompterTextColor: prompterTextColor ?? this.prompterTextColor,
    markdownEnabled: markdownEnabled ?? this.markdownEnabled,
    keybindings: keybindings ?? this.keybindings,
  );
  SettingsPresetModelData copyWithCompanion(
    i1.SettingsPresetModelCompanion data,
  ) {
    return SettingsPresetModelData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      scrollSpeed: data.scrollSpeed.present
          ? data.scrollSpeed.value
          : this.scrollSpeed,
      mirroredX: data.mirroredX.present ? data.mirroredX.value : this.mirroredX,
      mirroredY: data.mirroredY.present ? data.mirroredY.value : this.mirroredY,
      fontSize: data.fontSize.present ? data.fontSize.value : this.fontSize,
      sideMargin: data.sideMargin.present
          ? data.sideMargin.value
          : this.sideMargin,
      fontFamily: data.fontFamily.present
          ? data.fontFamily.value
          : this.fontFamily,
      alignment: data.alignment.present ? data.alignment.value : this.alignment,
      displayReadingIndicatorBoxes: data.displayReadingIndicatorBoxes.present
          ? data.displayReadingIndicatorBoxes.value
          : this.displayReadingIndicatorBoxes,
      readingIndicatorBoxesHeight: data.readingIndicatorBoxesHeight.present
          ? data.readingIndicatorBoxesHeight.value
          : this.readingIndicatorBoxesHeight,
      displayVerticalMarginBoxes: data.displayVerticalMarginBoxes.present
          ? data.displayVerticalMarginBoxes.value
          : this.displayVerticalMarginBoxes,
      verticalMarginBoxesHeight: data.verticalMarginBoxesHeight.present
          ? data.verticalMarginBoxesHeight.value
          : this.verticalMarginBoxesHeight,
      verticalMarginBoxesFadeEnabled:
          data.verticalMarginBoxesFadeEnabled.present
          ? data.verticalMarginBoxesFadeEnabled.value
          : this.verticalMarginBoxesFadeEnabled,
      verticalMarginBoxesFadeLength: data.verticalMarginBoxesFadeLength.present
          ? data.verticalMarginBoxesFadeLength.value
          : this.verticalMarginBoxesFadeLength,
      countdownDuration: data.countdownDuration.present
          ? data.countdownDuration.value
          : this.countdownDuration,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      appPrimaryColor: data.appPrimaryColor.present
          ? data.appPrimaryColor.value
          : this.appPrimaryColor,
      prompterBackgroundColor: data.prompterBackgroundColor.present
          ? data.prompterBackgroundColor.value
          : this.prompterBackgroundColor,
      prompterTextColor: data.prompterTextColor.present
          ? data.prompterTextColor.value
          : this.prompterTextColor,
      markdownEnabled: data.markdownEnabled.present
          ? data.markdownEnabled.value
          : this.markdownEnabled,
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
          ..write('scrollSpeed: $scrollSpeed, ')
          ..write('mirroredX: $mirroredX, ')
          ..write('mirroredY: $mirroredY, ')
          ..write('fontSize: $fontSize, ')
          ..write('sideMargin: $sideMargin, ')
          ..write('fontFamily: $fontFamily, ')
          ..write('alignment: $alignment, ')
          ..write(
            'displayReadingIndicatorBoxes: $displayReadingIndicatorBoxes, ',
          )
          ..write('readingIndicatorBoxesHeight: $readingIndicatorBoxesHeight, ')
          ..write('displayVerticalMarginBoxes: $displayVerticalMarginBoxes, ')
          ..write('verticalMarginBoxesHeight: $verticalMarginBoxesHeight, ')
          ..write(
            'verticalMarginBoxesFadeEnabled: $verticalMarginBoxesFadeEnabled, ',
          )
          ..write(
            'verticalMarginBoxesFadeLength: $verticalMarginBoxesFadeLength, ',
          )
          ..write('countdownDuration: $countdownDuration, ')
          ..write('themeMode: $themeMode, ')
          ..write('appPrimaryColor: $appPrimaryColor, ')
          ..write('prompterBackgroundColor: $prompterBackgroundColor, ')
          ..write('prompterTextColor: $prompterTextColor, ')
          ..write('markdownEnabled: $markdownEnabled, ')
          ..write('keybindings: $keybindings')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    name,
    createdAt,
    scrollSpeed,
    mirroredX,
    mirroredY,
    fontSize,
    sideMargin,
    fontFamily,
    alignment,
    displayReadingIndicatorBoxes,
    readingIndicatorBoxesHeight,
    displayVerticalMarginBoxes,
    verticalMarginBoxesHeight,
    verticalMarginBoxesFadeEnabled,
    verticalMarginBoxesFadeLength,
    countdownDuration,
    themeMode,
    appPrimaryColor,
    prompterBackgroundColor,
    prompterTextColor,
    markdownEnabled,
    keybindings,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.SettingsPresetModelData &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.scrollSpeed == this.scrollSpeed &&
          other.mirroredX == this.mirroredX &&
          other.mirroredY == this.mirroredY &&
          other.fontSize == this.fontSize &&
          other.sideMargin == this.sideMargin &&
          other.fontFamily == this.fontFamily &&
          other.alignment == this.alignment &&
          other.displayReadingIndicatorBoxes ==
              this.displayReadingIndicatorBoxes &&
          other.readingIndicatorBoxesHeight ==
              this.readingIndicatorBoxesHeight &&
          other.displayVerticalMarginBoxes == this.displayVerticalMarginBoxes &&
          other.verticalMarginBoxesHeight == this.verticalMarginBoxesHeight &&
          other.verticalMarginBoxesFadeEnabled ==
              this.verticalMarginBoxesFadeEnabled &&
          other.verticalMarginBoxesFadeLength ==
              this.verticalMarginBoxesFadeLength &&
          other.countdownDuration == this.countdownDuration &&
          other.themeMode == this.themeMode &&
          other.appPrimaryColor == this.appPrimaryColor &&
          other.prompterBackgroundColor == this.prompterBackgroundColor &&
          other.prompterTextColor == this.prompterTextColor &&
          other.markdownEnabled == this.markdownEnabled &&
          other.keybindings == this.keybindings);
}

class SettingsPresetModelCompanion
    extends i0.UpdateCompanion<i1.SettingsPresetModelData> {
  final i0.Value<int> id;
  final i0.Value<String> name;
  final i0.Value<DateTime> createdAt;
  final i0.Value<double> scrollSpeed;
  final i0.Value<bool> mirroredX;
  final i0.Value<bool> mirroredY;
  final i0.Value<double> fontSize;
  final i0.Value<double> sideMargin;
  final i0.Value<String> fontFamily;
  final i0.Value<String> alignment;
  final i0.Value<bool> displayReadingIndicatorBoxes;
  final i0.Value<double> readingIndicatorBoxesHeight;
  final i0.Value<bool> displayVerticalMarginBoxes;
  final i0.Value<double> verticalMarginBoxesHeight;
  final i0.Value<bool> verticalMarginBoxesFadeEnabled;
  final i0.Value<double> verticalMarginBoxesFadeLength;
  final i0.Value<double> countdownDuration;
  final i0.Value<String> themeMode;
  final i0.Value<int> appPrimaryColor;
  final i0.Value<int> prompterBackgroundColor;
  final i0.Value<int> prompterTextColor;
  final i0.Value<bool> markdownEnabled;
  final i0.Value<int> keybindings;
  const SettingsPresetModelCompanion({
    this.id = const i0.Value.absent(),
    this.name = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
    this.scrollSpeed = const i0.Value.absent(),
    this.mirroredX = const i0.Value.absent(),
    this.mirroredY = const i0.Value.absent(),
    this.fontSize = const i0.Value.absent(),
    this.sideMargin = const i0.Value.absent(),
    this.fontFamily = const i0.Value.absent(),
    this.alignment = const i0.Value.absent(),
    this.displayReadingIndicatorBoxes = const i0.Value.absent(),
    this.readingIndicatorBoxesHeight = const i0.Value.absent(),
    this.displayVerticalMarginBoxes = const i0.Value.absent(),
    this.verticalMarginBoxesHeight = const i0.Value.absent(),
    this.verticalMarginBoxesFadeEnabled = const i0.Value.absent(),
    this.verticalMarginBoxesFadeLength = const i0.Value.absent(),
    this.countdownDuration = const i0.Value.absent(),
    this.themeMode = const i0.Value.absent(),
    this.appPrimaryColor = const i0.Value.absent(),
    this.prompterBackgroundColor = const i0.Value.absent(),
    this.prompterTextColor = const i0.Value.absent(),
    this.markdownEnabled = const i0.Value.absent(),
    this.keybindings = const i0.Value.absent(),
  });
  SettingsPresetModelCompanion.insert({
    this.id = const i0.Value.absent(),
    required String name,
    required DateTime createdAt,
    required double scrollSpeed,
    required bool mirroredX,
    required bool mirroredY,
    required double fontSize,
    required double sideMargin,
    required String fontFamily,
    required String alignment,
    required bool displayReadingIndicatorBoxes,
    required double readingIndicatorBoxesHeight,
    required bool displayVerticalMarginBoxes,
    required double verticalMarginBoxesHeight,
    required bool verticalMarginBoxesFadeEnabled,
    required double verticalMarginBoxesFadeLength,
    required double countdownDuration,
    required String themeMode,
    required int appPrimaryColor,
    required int prompterBackgroundColor,
    required int prompterTextColor,
    required bool markdownEnabled,
    required int keybindings,
  }) : name = i0.Value(name),
       createdAt = i0.Value(createdAt),
       scrollSpeed = i0.Value(scrollSpeed),
       mirroredX = i0.Value(mirroredX),
       mirroredY = i0.Value(mirroredY),
       fontSize = i0.Value(fontSize),
       sideMargin = i0.Value(sideMargin),
       fontFamily = i0.Value(fontFamily),
       alignment = i0.Value(alignment),
       displayReadingIndicatorBoxes = i0.Value(displayReadingIndicatorBoxes),
       readingIndicatorBoxesHeight = i0.Value(readingIndicatorBoxesHeight),
       displayVerticalMarginBoxes = i0.Value(displayVerticalMarginBoxes),
       verticalMarginBoxesHeight = i0.Value(verticalMarginBoxesHeight),
       verticalMarginBoxesFadeEnabled = i0.Value(
         verticalMarginBoxesFadeEnabled,
       ),
       verticalMarginBoxesFadeLength = i0.Value(verticalMarginBoxesFadeLength),
       countdownDuration = i0.Value(countdownDuration),
       themeMode = i0.Value(themeMode),
       appPrimaryColor = i0.Value(appPrimaryColor),
       prompterBackgroundColor = i0.Value(prompterBackgroundColor),
       prompterTextColor = i0.Value(prompterTextColor),
       markdownEnabled = i0.Value(markdownEnabled),
       keybindings = i0.Value(keybindings);
  static i0.Insertable<i1.SettingsPresetModelData> custom({
    i0.Expression<int>? id,
    i0.Expression<String>? name,
    i0.Expression<DateTime>? createdAt,
    i0.Expression<double>? scrollSpeed,
    i0.Expression<bool>? mirroredX,
    i0.Expression<bool>? mirroredY,
    i0.Expression<double>? fontSize,
    i0.Expression<double>? sideMargin,
    i0.Expression<String>? fontFamily,
    i0.Expression<String>? alignment,
    i0.Expression<bool>? displayReadingIndicatorBoxes,
    i0.Expression<double>? readingIndicatorBoxesHeight,
    i0.Expression<bool>? displayVerticalMarginBoxes,
    i0.Expression<double>? verticalMarginBoxesHeight,
    i0.Expression<bool>? verticalMarginBoxesFadeEnabled,
    i0.Expression<double>? verticalMarginBoxesFadeLength,
    i0.Expression<double>? countdownDuration,
    i0.Expression<String>? themeMode,
    i0.Expression<int>? appPrimaryColor,
    i0.Expression<int>? prompterBackgroundColor,
    i0.Expression<int>? prompterTextColor,
    i0.Expression<bool>? markdownEnabled,
    i0.Expression<int>? keybindings,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (scrollSpeed != null) 'scroll_speed': scrollSpeed,
      if (mirroredX != null) 'mirrored_x': mirroredX,
      if (mirroredY != null) 'mirrored_y': mirroredY,
      if (fontSize != null) 'font_size': fontSize,
      if (sideMargin != null) 'side_margin': sideMargin,
      if (fontFamily != null) 'font_family': fontFamily,
      if (alignment != null) 'alignment': alignment,
      if (displayReadingIndicatorBoxes != null)
        'display_reading_indicator_boxes': displayReadingIndicatorBoxes,
      if (readingIndicatorBoxesHeight != null)
        'reading_indicator_boxes_height': readingIndicatorBoxesHeight,
      if (displayVerticalMarginBoxes != null)
        'display_vertical_margin_boxes': displayVerticalMarginBoxes,
      if (verticalMarginBoxesHeight != null)
        'vertical_margin_boxes_height': verticalMarginBoxesHeight,
      if (verticalMarginBoxesFadeEnabled != null)
        'vertical_margin_boxes_fade_enabled': verticalMarginBoxesFadeEnabled,
      if (verticalMarginBoxesFadeLength != null)
        'vertical_margin_boxes_fade_length': verticalMarginBoxesFadeLength,
      if (countdownDuration != null) 'countdown_duration': countdownDuration,
      if (themeMode != null) 'theme_mode': themeMode,
      if (appPrimaryColor != null) 'app_primary_color': appPrimaryColor,
      if (prompterBackgroundColor != null)
        'prompter_background_color': prompterBackgroundColor,
      if (prompterTextColor != null) 'prompter_text_color': prompterTextColor,
      if (markdownEnabled != null) 'markdown_enabled': markdownEnabled,
      if (keybindings != null) 'keybindings': keybindings,
    });
  }

  i1.SettingsPresetModelCompanion copyWith({
    i0.Value<int>? id,
    i0.Value<String>? name,
    i0.Value<DateTime>? createdAt,
    i0.Value<double>? scrollSpeed,
    i0.Value<bool>? mirroredX,
    i0.Value<bool>? mirroredY,
    i0.Value<double>? fontSize,
    i0.Value<double>? sideMargin,
    i0.Value<String>? fontFamily,
    i0.Value<String>? alignment,
    i0.Value<bool>? displayReadingIndicatorBoxes,
    i0.Value<double>? readingIndicatorBoxesHeight,
    i0.Value<bool>? displayVerticalMarginBoxes,
    i0.Value<double>? verticalMarginBoxesHeight,
    i0.Value<bool>? verticalMarginBoxesFadeEnabled,
    i0.Value<double>? verticalMarginBoxesFadeLength,
    i0.Value<double>? countdownDuration,
    i0.Value<String>? themeMode,
    i0.Value<int>? appPrimaryColor,
    i0.Value<int>? prompterBackgroundColor,
    i0.Value<int>? prompterTextColor,
    i0.Value<bool>? markdownEnabled,
    i0.Value<int>? keybindings,
  }) {
    return i1.SettingsPresetModelCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      scrollSpeed: scrollSpeed ?? this.scrollSpeed,
      mirroredX: mirroredX ?? this.mirroredX,
      mirroredY: mirroredY ?? this.mirroredY,
      fontSize: fontSize ?? this.fontSize,
      sideMargin: sideMargin ?? this.sideMargin,
      fontFamily: fontFamily ?? this.fontFamily,
      alignment: alignment ?? this.alignment,
      displayReadingIndicatorBoxes:
          displayReadingIndicatorBoxes ?? this.displayReadingIndicatorBoxes,
      readingIndicatorBoxesHeight:
          readingIndicatorBoxesHeight ?? this.readingIndicatorBoxesHeight,
      displayVerticalMarginBoxes:
          displayVerticalMarginBoxes ?? this.displayVerticalMarginBoxes,
      verticalMarginBoxesHeight:
          verticalMarginBoxesHeight ?? this.verticalMarginBoxesHeight,
      verticalMarginBoxesFadeEnabled:
          verticalMarginBoxesFadeEnabled ?? this.verticalMarginBoxesFadeEnabled,
      verticalMarginBoxesFadeLength:
          verticalMarginBoxesFadeLength ?? this.verticalMarginBoxesFadeLength,
      countdownDuration: countdownDuration ?? this.countdownDuration,
      themeMode: themeMode ?? this.themeMode,
      appPrimaryColor: appPrimaryColor ?? this.appPrimaryColor,
      prompterBackgroundColor:
          prompterBackgroundColor ?? this.prompterBackgroundColor,
      prompterTextColor: prompterTextColor ?? this.prompterTextColor,
      markdownEnabled: markdownEnabled ?? this.markdownEnabled,
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
    if (scrollSpeed.present) {
      map['scroll_speed'] = i0.Variable<double>(scrollSpeed.value);
    }
    if (mirroredX.present) {
      map['mirrored_x'] = i0.Variable<bool>(mirroredX.value);
    }
    if (mirroredY.present) {
      map['mirrored_y'] = i0.Variable<bool>(mirroredY.value);
    }
    if (fontSize.present) {
      map['font_size'] = i0.Variable<double>(fontSize.value);
    }
    if (sideMargin.present) {
      map['side_margin'] = i0.Variable<double>(sideMargin.value);
    }
    if (fontFamily.present) {
      map['font_family'] = i0.Variable<String>(fontFamily.value);
    }
    if (alignment.present) {
      map['alignment'] = i0.Variable<String>(alignment.value);
    }
    if (displayReadingIndicatorBoxes.present) {
      map['display_reading_indicator_boxes'] = i0.Variable<bool>(
        displayReadingIndicatorBoxes.value,
      );
    }
    if (readingIndicatorBoxesHeight.present) {
      map['reading_indicator_boxes_height'] = i0.Variable<double>(
        readingIndicatorBoxesHeight.value,
      );
    }
    if (displayVerticalMarginBoxes.present) {
      map['display_vertical_margin_boxes'] = i0.Variable<bool>(
        displayVerticalMarginBoxes.value,
      );
    }
    if (verticalMarginBoxesHeight.present) {
      map['vertical_margin_boxes_height'] = i0.Variable<double>(
        verticalMarginBoxesHeight.value,
      );
    }
    if (verticalMarginBoxesFadeEnabled.present) {
      map['vertical_margin_boxes_fade_enabled'] = i0.Variable<bool>(
        verticalMarginBoxesFadeEnabled.value,
      );
    }
    if (verticalMarginBoxesFadeLength.present) {
      map['vertical_margin_boxes_fade_length'] = i0.Variable<double>(
        verticalMarginBoxesFadeLength.value,
      );
    }
    if (countdownDuration.present) {
      map['countdown_duration'] = i0.Variable<double>(countdownDuration.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = i0.Variable<String>(themeMode.value);
    }
    if (appPrimaryColor.present) {
      map['app_primary_color'] = i0.Variable<int>(appPrimaryColor.value);
    }
    if (prompterBackgroundColor.present) {
      map['prompter_background_color'] = i0.Variable<int>(
        prompterBackgroundColor.value,
      );
    }
    if (prompterTextColor.present) {
      map['prompter_text_color'] = i0.Variable<int>(prompterTextColor.value);
    }
    if (markdownEnabled.present) {
      map['markdown_enabled'] = i0.Variable<bool>(markdownEnabled.value);
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
          ..write('scrollSpeed: $scrollSpeed, ')
          ..write('mirroredX: $mirroredX, ')
          ..write('mirroredY: $mirroredY, ')
          ..write('fontSize: $fontSize, ')
          ..write('sideMargin: $sideMargin, ')
          ..write('fontFamily: $fontFamily, ')
          ..write('alignment: $alignment, ')
          ..write(
            'displayReadingIndicatorBoxes: $displayReadingIndicatorBoxes, ',
          )
          ..write('readingIndicatorBoxesHeight: $readingIndicatorBoxesHeight, ')
          ..write('displayVerticalMarginBoxes: $displayVerticalMarginBoxes, ')
          ..write('verticalMarginBoxesHeight: $verticalMarginBoxesHeight, ')
          ..write(
            'verticalMarginBoxesFadeEnabled: $verticalMarginBoxesFadeEnabled, ',
          )
          ..write(
            'verticalMarginBoxesFadeLength: $verticalMarginBoxesFadeLength, ',
          )
          ..write('countdownDuration: $countdownDuration, ')
          ..write('themeMode: $themeMode, ')
          ..write('appPrimaryColor: $appPrimaryColor, ')
          ..write('prompterBackgroundColor: $prompterBackgroundColor, ')
          ..write('prompterTextColor: $prompterTextColor, ')
          ..write('markdownEnabled: $markdownEnabled, ')
          ..write('keybindings: $keybindings')
          ..write(')'))
        .toString();
  }
}
