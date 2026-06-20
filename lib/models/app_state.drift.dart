// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:tiefprompt/models/app_state.drift.dart' as i1;
import 'package:tiefprompt/models/app_state.dart' as i2;

typedef $$AppStateModelTableCreateCompanionBuilder =
    i1.AppStateModelCompanion Function({
      required bool helpRequestShown,
      i0.Value<String?> lastSeenVersion,
      i0.Value<int> rowid,
    });
typedef $$AppStateModelTableUpdateCompanionBuilder =
    i1.AppStateModelCompanion Function({
      i0.Value<bool> helpRequestShown,
      i0.Value<String?> lastSeenVersion,
      i0.Value<int> rowid,
    });

class $$AppStateModelTableFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$AppStateModelTable> {
  $$AppStateModelTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<bool> get helpRequestShown => $composableBuilder(
    column: $table.helpRequestShown,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get lastSeenVersion => $composableBuilder(
    column: $table.lastSeenVersion,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $$AppStateModelTableOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$AppStateModelTable> {
  $$AppStateModelTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<bool> get helpRequestShown => $composableBuilder(
    column: $table.helpRequestShown,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get lastSeenVersion => $composableBuilder(
    column: $table.lastSeenVersion,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $$AppStateModelTableAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$AppStateModelTable> {
  $$AppStateModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<bool> get helpRequestShown => $composableBuilder(
    column: $table.helpRequestShown,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get lastSeenVersion => $composableBuilder(
    column: $table.lastSeenVersion,
    builder: (column) => column,
  );
}

class $$AppStateModelTableTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.$AppStateModelTable,
          i1.AppStateModelData,
          i1.$$AppStateModelTableFilterComposer,
          i1.$$AppStateModelTableOrderingComposer,
          i1.$$AppStateModelTableAnnotationComposer,
          $$AppStateModelTableCreateCompanionBuilder,
          $$AppStateModelTableUpdateCompanionBuilder,
          (
            i1.AppStateModelData,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.$AppStateModelTable,
              i1.AppStateModelData
            >,
          ),
          i1.AppStateModelData,
          i0.PrefetchHooks Function()
        > {
  $$AppStateModelTableTableManager(
    i0.GeneratedDatabase db,
    i1.$AppStateModelTable table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$$AppStateModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$$AppStateModelTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$$AppStateModelTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<bool> helpRequestShown = const i0.Value.absent(),
                i0.Value<String?> lastSeenVersion = const i0.Value.absent(),
                i0.Value<int> rowid = const i0.Value.absent(),
              }) => i1.AppStateModelCompanion(
                helpRequestShown: helpRequestShown,
                lastSeenVersion: lastSeenVersion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required bool helpRequestShown,
                i0.Value<String?> lastSeenVersion = const i0.Value.absent(),
                i0.Value<int> rowid = const i0.Value.absent(),
              }) => i1.AppStateModelCompanion.insert(
                helpRequestShown: helpRequestShown,
                lastSeenVersion: lastSeenVersion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppStateModelTableProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.$AppStateModelTable,
      i1.AppStateModelData,
      i1.$$AppStateModelTableFilterComposer,
      i1.$$AppStateModelTableOrderingComposer,
      i1.$$AppStateModelTableAnnotationComposer,
      $$AppStateModelTableCreateCompanionBuilder,
      $$AppStateModelTableUpdateCompanionBuilder,
      (
        i1.AppStateModelData,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.$AppStateModelTable,
          i1.AppStateModelData
        >,
      ),
      i1.AppStateModelData,
      i0.PrefetchHooks Function()
    >;

class $AppStateModelTable extends i2.AppStateModel
    with i0.TableInfo<$AppStateModelTable, i1.AppStateModelData> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppStateModelTable(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _helpRequestShownMeta =
      const i0.VerificationMeta('helpRequestShown');
  @override
  late final i0.GeneratedColumn<bool> helpRequestShown =
      i0.GeneratedColumn<bool>(
        'help_request_shown',
        aliasedName,
        false,
        type: i0.DriftSqlType.bool,
        requiredDuringInsert: true,
        defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
          'CHECK ("help_request_shown" IN (0, 1))',
        ),
      );
  static const i0.VerificationMeta _lastSeenVersionMeta =
      const i0.VerificationMeta('lastSeenVersion');
  @override
  late final i0.GeneratedColumn<String> lastSeenVersion =
      i0.GeneratedColumn<String>(
        'last_seen_version',
        aliasedName,
        true,
        type: i0.DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<i0.GeneratedColumn> get $columns => [helpRequestShown, lastSeenVersion];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_state_model';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.AppStateModelData> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('help_request_shown')) {
      context.handle(
        _helpRequestShownMeta,
        helpRequestShown.isAcceptableOrUnknown(
          data['help_request_shown']!,
          _helpRequestShownMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_helpRequestShownMeta);
    }
    if (data.containsKey('last_seen_version')) {
      context.handle(
        _lastSeenVersionMeta,
        lastSeenVersion.isAcceptableOrUnknown(
          data['last_seen_version']!,
          _lastSeenVersionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => const {};
  @override
  i1.AppStateModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.AppStateModelData(
      helpRequestShown: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.bool,
        data['${effectivePrefix}help_request_shown'],
      )!,
      lastSeenVersion: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}last_seen_version'],
      ),
    );
  }

  @override
  $AppStateModelTable createAlias(String alias) {
    return $AppStateModelTable(attachedDatabase, alias);
  }
}

class AppStateModelData extends i0.DataClass
    implements i0.Insertable<i1.AppStateModelData> {
  final bool helpRequestShown;
  final String? lastSeenVersion;
  const AppStateModelData({
    required this.helpRequestShown,
    this.lastSeenVersion,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['help_request_shown'] = i0.Variable<bool>(helpRequestShown);
    if (!nullToAbsent || lastSeenVersion != null) {
      map['last_seen_version'] = i0.Variable<String>(lastSeenVersion);
    }
    return map;
  }

  i1.AppStateModelCompanion toCompanion(bool nullToAbsent) {
    return i1.AppStateModelCompanion(
      helpRequestShown: i0.Value(helpRequestShown),
      lastSeenVersion: lastSeenVersion == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(lastSeenVersion),
    );
  }

  factory AppStateModelData.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return AppStateModelData(
      helpRequestShown: serializer.fromJson<bool>(json['helpRequestShown']),
      lastSeenVersion: serializer.fromJson<String?>(json['lastSeenVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'helpRequestShown': serializer.toJson<bool>(helpRequestShown),
      'lastSeenVersion': serializer.toJson<String?>(lastSeenVersion),
    };
  }

  i1.AppStateModelData copyWith({
    bool? helpRequestShown,
    i0.Value<String?> lastSeenVersion = const i0.Value.absent(),
  }) => i1.AppStateModelData(
    helpRequestShown: helpRequestShown ?? this.helpRequestShown,
    lastSeenVersion: lastSeenVersion.present
        ? lastSeenVersion.value
        : this.lastSeenVersion,
  );
  AppStateModelData copyWithCompanion(i1.AppStateModelCompanion data) {
    return AppStateModelData(
      helpRequestShown: data.helpRequestShown.present
          ? data.helpRequestShown.value
          : this.helpRequestShown,
      lastSeenVersion: data.lastSeenVersion.present
          ? data.lastSeenVersion.value
          : this.lastSeenVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppStateModelData(')
          ..write('helpRequestShown: $helpRequestShown, ')
          ..write('lastSeenVersion: $lastSeenVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(helpRequestShown, lastSeenVersion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.AppStateModelData &&
          other.helpRequestShown == this.helpRequestShown &&
          other.lastSeenVersion == this.lastSeenVersion);
}

class AppStateModelCompanion extends i0.UpdateCompanion<i1.AppStateModelData> {
  final i0.Value<bool> helpRequestShown;
  final i0.Value<String?> lastSeenVersion;
  final i0.Value<int> rowid;
  const AppStateModelCompanion({
    this.helpRequestShown = const i0.Value.absent(),
    this.lastSeenVersion = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  AppStateModelCompanion.insert({
    required bool helpRequestShown,
    this.lastSeenVersion = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  }) : helpRequestShown = i0.Value(helpRequestShown);
  static i0.Insertable<i1.AppStateModelData> custom({
    i0.Expression<bool>? helpRequestShown,
    i0.Expression<String>? lastSeenVersion,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (helpRequestShown != null) 'help_request_shown': helpRequestShown,
      if (lastSeenVersion != null) 'last_seen_version': lastSeenVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i1.AppStateModelCompanion copyWith({
    i0.Value<bool>? helpRequestShown,
    i0.Value<String?>? lastSeenVersion,
    i0.Value<int>? rowid,
  }) {
    return i1.AppStateModelCompanion(
      helpRequestShown: helpRequestShown ?? this.helpRequestShown,
      lastSeenVersion: lastSeenVersion ?? this.lastSeenVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (helpRequestShown.present) {
      map['help_request_shown'] = i0.Variable<bool>(helpRequestShown.value);
    }
    if (lastSeenVersion.present) {
      map['last_seen_version'] = i0.Variable<String>(lastSeenVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = i0.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppStateModelCompanion(')
          ..write('helpRequestShown: $helpRequestShown, ')
          ..write('lastSeenVersion: $lastSeenVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}
