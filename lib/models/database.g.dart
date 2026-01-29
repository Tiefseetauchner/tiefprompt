// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ScriptModelTable extends ScriptModel
    with TableInfo<$ScriptModelTable, ScriptModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScriptModelTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scriptTextMeta = const VerificationMeta(
    'scriptText',
  );
  @override
  late final GeneratedColumn<String> scriptText = GeneratedColumn<String>(
    'script_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, scriptText, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'script_model';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScriptModelData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('script_text')) {
      context.handle(
        _scriptTextMeta,
        scriptText.isAcceptableOrUnknown(data['script_text']!, _scriptTextMeta),
      );
    } else if (isInserting) {
      context.missing(_scriptTextMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScriptModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScriptModelData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      scriptText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}script_text'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ScriptModelTable createAlias(String alias) {
    return $ScriptModelTable(attachedDatabase, alias);
  }
}

class ScriptModelData extends DataClass implements Insertable<ScriptModelData> {
  final int id;
  final String title;
  final String scriptText;
  final DateTime createdAt;
  const ScriptModelData({
    required this.id,
    required this.title,
    required this.scriptText,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['script_text'] = Variable<String>(scriptText);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ScriptModelCompanion toCompanion(bool nullToAbsent) {
    return ScriptModelCompanion(
      id: Value(id),
      title: Value(title),
      scriptText: Value(scriptText),
      createdAt: Value(createdAt),
    );
  }

  factory ScriptModelData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScriptModelData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      scriptText: serializer.fromJson<String>(json['scriptText']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'scriptText': serializer.toJson<String>(scriptText),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ScriptModelData copyWith({
    int? id,
    String? title,
    String? scriptText,
    DateTime? createdAt,
  }) => ScriptModelData(
    id: id ?? this.id,
    title: title ?? this.title,
    scriptText: scriptText ?? this.scriptText,
    createdAt: createdAt ?? this.createdAt,
  );
  ScriptModelData copyWithCompanion(ScriptModelCompanion data) {
    return ScriptModelData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      scriptText: data.scriptText.present
          ? data.scriptText.value
          : this.scriptText,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScriptModelData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('scriptText: $scriptText, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, scriptText, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScriptModelData &&
          other.id == this.id &&
          other.title == this.title &&
          other.scriptText == this.scriptText &&
          other.createdAt == this.createdAt);
}

class ScriptModelCompanion extends UpdateCompanion<ScriptModelData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> scriptText;
  final Value<DateTime> createdAt;
  const ScriptModelCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.scriptText = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ScriptModelCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String scriptText,
    required DateTime createdAt,
  }) : title = Value(title),
       scriptText = Value(scriptText),
       createdAt = Value(createdAt);
  static Insertable<ScriptModelData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? scriptText,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (scriptText != null) 'script_text': scriptText,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ScriptModelCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? scriptText,
    Value<DateTime>? createdAt,
  }) {
    return ScriptModelCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      scriptText: scriptText ?? this.scriptText,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (scriptText.present) {
      map['script_text'] = Variable<String>(scriptText.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScriptModelCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('scriptText: $scriptText, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $KeybindingMapModelTable extends KeybindingMapModel
    with TableInfo<$KeybindingMapModelTable, KeybindingMapModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KeybindingMapModelTable(this.attachedDatabase, [this._alias]);
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
  @override
  List<GeneratedColumn> get $columns => [id];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'keybinding_map_model';
  @override
  VerificationContext validateIntegrity(
    Insertable<KeybindingMapModelData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KeybindingMapModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KeybindingMapModelData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
    );
  }

  @override
  $KeybindingMapModelTable createAlias(String alias) {
    return $KeybindingMapModelTable(attachedDatabase, alias);
  }
}

class KeybindingMapModelData extends DataClass
    implements Insertable<KeybindingMapModelData> {
  final int id;
  const KeybindingMapModelData({required this.id});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    return map;
  }

  KeybindingMapModelCompanion toCompanion(bool nullToAbsent) {
    return KeybindingMapModelCompanion(id: Value(id));
  }

  factory KeybindingMapModelData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KeybindingMapModelData(id: serializer.fromJson<int>(json['id']));
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'id': serializer.toJson<int>(id)};
  }

  KeybindingMapModelData copyWith({int? id}) =>
      KeybindingMapModelData(id: id ?? this.id);
  KeybindingMapModelData copyWithCompanion(KeybindingMapModelCompanion data) {
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
      (other is KeybindingMapModelData && other.id == this.id);
}

class KeybindingMapModelCompanion
    extends UpdateCompanion<KeybindingMapModelData> {
  final Value<int> id;
  const KeybindingMapModelCompanion({this.id = const Value.absent()});
  KeybindingMapModelCompanion.insert({this.id = const Value.absent()});
  static Insertable<KeybindingMapModelData> custom({Expression<int>? id}) {
    return RawValuesInsertable({if (id != null) 'id': id});
  }

  KeybindingMapModelCompanion copyWith({Value<int>? id}) {
    return KeybindingMapModelCompanion(id: id ?? this.id);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
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

class $SettingsPresetModelTable extends SettingsPresetModel
    with TableInfo<$SettingsPresetModelTable, SettingsPresetModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsPresetModelTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scrollSpeedMeta = const VerificationMeta(
    'scrollSpeed',
  );
  @override
  late final GeneratedColumn<double> scrollSpeed = GeneratedColumn<double>(
    'scroll_speed',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mirroredXMeta = const VerificationMeta(
    'mirroredX',
  );
  @override
  late final GeneratedColumn<bool> mirroredX = GeneratedColumn<bool>(
    'mirrored_x',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("mirrored_x" IN (0, 1))',
    ),
  );
  static const VerificationMeta _mirroredYMeta = const VerificationMeta(
    'mirroredY',
  );
  @override
  late final GeneratedColumn<bool> mirroredY = GeneratedColumn<bool>(
    'mirrored_y',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("mirrored_y" IN (0, 1))',
    ),
  );
  static const VerificationMeta _fontSizeMeta = const VerificationMeta(
    'fontSize',
  );
  @override
  late final GeneratedColumn<double> fontSize = GeneratedColumn<double>(
    'font_size',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sideMarginMeta = const VerificationMeta(
    'sideMargin',
  );
  @override
  late final GeneratedColumn<double> sideMargin = GeneratedColumn<double>(
    'side_margin',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fontFamilyMeta = const VerificationMeta(
    'fontFamily',
  );
  @override
  late final GeneratedColumn<String> fontFamily = GeneratedColumn<String>(
    'font_family',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _alignmentMeta = const VerificationMeta(
    'alignment',
  );
  @override
  late final GeneratedColumn<String> alignment = GeneratedColumn<String>(
    'alignment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayReadingIndicatorBoxesMeta =
      const VerificationMeta('displayReadingIndicatorBoxes');
  @override
  late final GeneratedColumn<bool> displayReadingIndicatorBoxes =
      GeneratedColumn<bool>(
        'display_reading_indicator_boxes',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("display_reading_indicator_boxes" IN (0, 1))',
        ),
      );
  static const VerificationMeta _readingIndicatorBoxesHeightMeta =
      const VerificationMeta('readingIndicatorBoxesHeight');
  @override
  late final GeneratedColumn<double> readingIndicatorBoxesHeight =
      GeneratedColumn<double>(
        'reading_indicator_boxes_height',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _displayVerticalMarginBoxesMeta =
      const VerificationMeta('displayVerticalMarginBoxes');
  @override
  late final GeneratedColumn<bool> displayVerticalMarginBoxes =
      GeneratedColumn<bool>(
        'display_vertical_margin_boxes',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("display_vertical_margin_boxes" IN (0, 1))',
        ),
      );
  static const VerificationMeta _verticalMarginBoxesHeightMeta =
      const VerificationMeta('verticalMarginBoxesHeight');
  @override
  late final GeneratedColumn<double> verticalMarginBoxesHeight =
      GeneratedColumn<double>(
        'vertical_margin_boxes_height',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _verticalMarginBoxesFadeEnabledMeta =
      const VerificationMeta('verticalMarginBoxesFadeEnabled');
  @override
  late final GeneratedColumn<bool> verticalMarginBoxesFadeEnabled =
      GeneratedColumn<bool>(
        'vertical_margin_boxes_fade_enabled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("vertical_margin_boxes_fade_enabled" IN (0, 1))',
        ),
      );
  static const VerificationMeta _verticalMarginBoxesFadeLengthMeta =
      const VerificationMeta('verticalMarginBoxesFadeLength');
  @override
  late final GeneratedColumn<double> verticalMarginBoxesFadeLength =
      GeneratedColumn<double>(
        'vertical_margin_boxes_fade_length',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _countdownDurationMeta = const VerificationMeta(
    'countdownDuration',
  );
  @override
  late final GeneratedColumn<double> countdownDuration =
      GeneratedColumn<double>(
        'countdown_duration',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _appPrimaryColorMeta = const VerificationMeta(
    'appPrimaryColor',
  );
  @override
  late final GeneratedColumn<int> appPrimaryColor = GeneratedColumn<int>(
    'app_primary_color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prompterBackgroundColorMeta =
      const VerificationMeta('prompterBackgroundColor');
  @override
  late final GeneratedColumn<int> prompterBackgroundColor =
      GeneratedColumn<int>(
        'prompter_background_color',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _prompterTextColorMeta = const VerificationMeta(
    'prompterTextColor',
  );
  @override
  late final GeneratedColumn<int> prompterTextColor = GeneratedColumn<int>(
    'prompter_text_color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _markdownEnabledMeta = const VerificationMeta(
    'markdownEnabled',
  );
  @override
  late final GeneratedColumn<bool> markdownEnabled = GeneratedColumn<bool>(
    'markdown_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("markdown_enabled" IN (0, 1))',
    ),
  );
  static const VerificationMeta _keybindingsMeta = const VerificationMeta(
    'keybindings',
  );
  @override
  late final GeneratedColumn<int> keybindings = GeneratedColumn<int>(
    'keybindings',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES keybinding_map_model (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
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
  VerificationContext validateIntegrity(
    Insertable<SettingsPresetModelData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SettingsPresetModelData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsPresetModelData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      scrollSpeed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}scroll_speed'],
      )!,
      mirroredX: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}mirrored_x'],
      )!,
      mirroredY: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}mirrored_y'],
      )!,
      fontSize: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}font_size'],
      )!,
      sideMargin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}side_margin'],
      )!,
      fontFamily: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}font_family'],
      )!,
      alignment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alignment'],
      )!,
      displayReadingIndicatorBoxes: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}display_reading_indicator_boxes'],
      )!,
      readingIndicatorBoxesHeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}reading_indicator_boxes_height'],
      )!,
      displayVerticalMarginBoxes: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}display_vertical_margin_boxes'],
      )!,
      verticalMarginBoxesHeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vertical_margin_boxes_height'],
      )!,
      verticalMarginBoxesFadeEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}vertical_margin_boxes_fade_enabled'],
      )!,
      verticalMarginBoxesFadeLength: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vertical_margin_boxes_fade_length'],
      )!,
      countdownDuration: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}countdown_duration'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      appPrimaryColor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}app_primary_color'],
      )!,
      prompterBackgroundColor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prompter_background_color'],
      )!,
      prompterTextColor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prompter_text_color'],
      )!,
      markdownEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}markdown_enabled'],
      )!,
      keybindings: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}keybindings'],
      )!,
    );
  }

  @override
  $SettingsPresetModelTable createAlias(String alias) {
    return $SettingsPresetModelTable(attachedDatabase, alias);
  }
}

class SettingsPresetModelData extends DataClass
    implements Insertable<SettingsPresetModelData> {
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
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['scroll_speed'] = Variable<double>(scrollSpeed);
    map['mirrored_x'] = Variable<bool>(mirroredX);
    map['mirrored_y'] = Variable<bool>(mirroredY);
    map['font_size'] = Variable<double>(fontSize);
    map['side_margin'] = Variable<double>(sideMargin);
    map['font_family'] = Variable<String>(fontFamily);
    map['alignment'] = Variable<String>(alignment);
    map['display_reading_indicator_boxes'] = Variable<bool>(
      displayReadingIndicatorBoxes,
    );
    map['reading_indicator_boxes_height'] = Variable<double>(
      readingIndicatorBoxesHeight,
    );
    map['display_vertical_margin_boxes'] = Variable<bool>(
      displayVerticalMarginBoxes,
    );
    map['vertical_margin_boxes_height'] = Variable<double>(
      verticalMarginBoxesHeight,
    );
    map['vertical_margin_boxes_fade_enabled'] = Variable<bool>(
      verticalMarginBoxesFadeEnabled,
    );
    map['vertical_margin_boxes_fade_length'] = Variable<double>(
      verticalMarginBoxesFadeLength,
    );
    map['countdown_duration'] = Variable<double>(countdownDuration);
    map['theme_mode'] = Variable<String>(themeMode);
    map['app_primary_color'] = Variable<int>(appPrimaryColor);
    map['prompter_background_color'] = Variable<int>(prompterBackgroundColor);
    map['prompter_text_color'] = Variable<int>(prompterTextColor);
    map['markdown_enabled'] = Variable<bool>(markdownEnabled);
    map['keybindings'] = Variable<int>(keybindings);
    return map;
  }

  SettingsPresetModelCompanion toCompanion(bool nullToAbsent) {
    return SettingsPresetModelCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
      scrollSpeed: Value(scrollSpeed),
      mirroredX: Value(mirroredX),
      mirroredY: Value(mirroredY),
      fontSize: Value(fontSize),
      sideMargin: Value(sideMargin),
      fontFamily: Value(fontFamily),
      alignment: Value(alignment),
      displayReadingIndicatorBoxes: Value(displayReadingIndicatorBoxes),
      readingIndicatorBoxesHeight: Value(readingIndicatorBoxesHeight),
      displayVerticalMarginBoxes: Value(displayVerticalMarginBoxes),
      verticalMarginBoxesHeight: Value(verticalMarginBoxesHeight),
      verticalMarginBoxesFadeEnabled: Value(verticalMarginBoxesFadeEnabled),
      verticalMarginBoxesFadeLength: Value(verticalMarginBoxesFadeLength),
      countdownDuration: Value(countdownDuration),
      themeMode: Value(themeMode),
      appPrimaryColor: Value(appPrimaryColor),
      prompterBackgroundColor: Value(prompterBackgroundColor),
      prompterTextColor: Value(prompterTextColor),
      markdownEnabled: Value(markdownEnabled),
      keybindings: Value(keybindings),
    );
  }

  factory SettingsPresetModelData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
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
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
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

  SettingsPresetModelData copyWith({
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
  }) => SettingsPresetModelData(
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
  SettingsPresetModelData copyWithCompanion(SettingsPresetModelCompanion data) {
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
      (other is SettingsPresetModelData &&
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
    extends UpdateCompanion<SettingsPresetModelData> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<double> scrollSpeed;
  final Value<bool> mirroredX;
  final Value<bool> mirroredY;
  final Value<double> fontSize;
  final Value<double> sideMargin;
  final Value<String> fontFamily;
  final Value<String> alignment;
  final Value<bool> displayReadingIndicatorBoxes;
  final Value<double> readingIndicatorBoxesHeight;
  final Value<bool> displayVerticalMarginBoxes;
  final Value<double> verticalMarginBoxesHeight;
  final Value<bool> verticalMarginBoxesFadeEnabled;
  final Value<double> verticalMarginBoxesFadeLength;
  final Value<double> countdownDuration;
  final Value<String> themeMode;
  final Value<int> appPrimaryColor;
  final Value<int> prompterBackgroundColor;
  final Value<int> prompterTextColor;
  final Value<bool> markdownEnabled;
  final Value<int> keybindings;
  const SettingsPresetModelCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.scrollSpeed = const Value.absent(),
    this.mirroredX = const Value.absent(),
    this.mirroredY = const Value.absent(),
    this.fontSize = const Value.absent(),
    this.sideMargin = const Value.absent(),
    this.fontFamily = const Value.absent(),
    this.alignment = const Value.absent(),
    this.displayReadingIndicatorBoxes = const Value.absent(),
    this.readingIndicatorBoxesHeight = const Value.absent(),
    this.displayVerticalMarginBoxes = const Value.absent(),
    this.verticalMarginBoxesHeight = const Value.absent(),
    this.verticalMarginBoxesFadeEnabled = const Value.absent(),
    this.verticalMarginBoxesFadeLength = const Value.absent(),
    this.countdownDuration = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.appPrimaryColor = const Value.absent(),
    this.prompterBackgroundColor = const Value.absent(),
    this.prompterTextColor = const Value.absent(),
    this.markdownEnabled = const Value.absent(),
    this.keybindings = const Value.absent(),
  });
  SettingsPresetModelCompanion.insert({
    this.id = const Value.absent(),
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
  }) : name = Value(name),
       createdAt = Value(createdAt),
       scrollSpeed = Value(scrollSpeed),
       mirroredX = Value(mirroredX),
       mirroredY = Value(mirroredY),
       fontSize = Value(fontSize),
       sideMargin = Value(sideMargin),
       fontFamily = Value(fontFamily),
       alignment = Value(alignment),
       displayReadingIndicatorBoxes = Value(displayReadingIndicatorBoxes),
       readingIndicatorBoxesHeight = Value(readingIndicatorBoxesHeight),
       displayVerticalMarginBoxes = Value(displayVerticalMarginBoxes),
       verticalMarginBoxesHeight = Value(verticalMarginBoxesHeight),
       verticalMarginBoxesFadeEnabled = Value(verticalMarginBoxesFadeEnabled),
       verticalMarginBoxesFadeLength = Value(verticalMarginBoxesFadeLength),
       countdownDuration = Value(countdownDuration),
       themeMode = Value(themeMode),
       appPrimaryColor = Value(appPrimaryColor),
       prompterBackgroundColor = Value(prompterBackgroundColor),
       prompterTextColor = Value(prompterTextColor),
       markdownEnabled = Value(markdownEnabled),
       keybindings = Value(keybindings);
  static Insertable<SettingsPresetModelData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<double>? scrollSpeed,
    Expression<bool>? mirroredX,
    Expression<bool>? mirroredY,
    Expression<double>? fontSize,
    Expression<double>? sideMargin,
    Expression<String>? fontFamily,
    Expression<String>? alignment,
    Expression<bool>? displayReadingIndicatorBoxes,
    Expression<double>? readingIndicatorBoxesHeight,
    Expression<bool>? displayVerticalMarginBoxes,
    Expression<double>? verticalMarginBoxesHeight,
    Expression<bool>? verticalMarginBoxesFadeEnabled,
    Expression<double>? verticalMarginBoxesFadeLength,
    Expression<double>? countdownDuration,
    Expression<String>? themeMode,
    Expression<int>? appPrimaryColor,
    Expression<int>? prompterBackgroundColor,
    Expression<int>? prompterTextColor,
    Expression<bool>? markdownEnabled,
    Expression<int>? keybindings,
  }) {
    return RawValuesInsertable({
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

  SettingsPresetModelCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<double>? scrollSpeed,
    Value<bool>? mirroredX,
    Value<bool>? mirroredY,
    Value<double>? fontSize,
    Value<double>? sideMargin,
    Value<String>? fontFamily,
    Value<String>? alignment,
    Value<bool>? displayReadingIndicatorBoxes,
    Value<double>? readingIndicatorBoxesHeight,
    Value<bool>? displayVerticalMarginBoxes,
    Value<double>? verticalMarginBoxesHeight,
    Value<bool>? verticalMarginBoxesFadeEnabled,
    Value<double>? verticalMarginBoxesFadeLength,
    Value<double>? countdownDuration,
    Value<String>? themeMode,
    Value<int>? appPrimaryColor,
    Value<int>? prompterBackgroundColor,
    Value<int>? prompterTextColor,
    Value<bool>? markdownEnabled,
    Value<int>? keybindings,
  }) {
    return SettingsPresetModelCompanion(
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
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (scrollSpeed.present) {
      map['scroll_speed'] = Variable<double>(scrollSpeed.value);
    }
    if (mirroredX.present) {
      map['mirrored_x'] = Variable<bool>(mirroredX.value);
    }
    if (mirroredY.present) {
      map['mirrored_y'] = Variable<bool>(mirroredY.value);
    }
    if (fontSize.present) {
      map['font_size'] = Variable<double>(fontSize.value);
    }
    if (sideMargin.present) {
      map['side_margin'] = Variable<double>(sideMargin.value);
    }
    if (fontFamily.present) {
      map['font_family'] = Variable<String>(fontFamily.value);
    }
    if (alignment.present) {
      map['alignment'] = Variable<String>(alignment.value);
    }
    if (displayReadingIndicatorBoxes.present) {
      map['display_reading_indicator_boxes'] = Variable<bool>(
        displayReadingIndicatorBoxes.value,
      );
    }
    if (readingIndicatorBoxesHeight.present) {
      map['reading_indicator_boxes_height'] = Variable<double>(
        readingIndicatorBoxesHeight.value,
      );
    }
    if (displayVerticalMarginBoxes.present) {
      map['display_vertical_margin_boxes'] = Variable<bool>(
        displayVerticalMarginBoxes.value,
      );
    }
    if (verticalMarginBoxesHeight.present) {
      map['vertical_margin_boxes_height'] = Variable<double>(
        verticalMarginBoxesHeight.value,
      );
    }
    if (verticalMarginBoxesFadeEnabled.present) {
      map['vertical_margin_boxes_fade_enabled'] = Variable<bool>(
        verticalMarginBoxesFadeEnabled.value,
      );
    }
    if (verticalMarginBoxesFadeLength.present) {
      map['vertical_margin_boxes_fade_length'] = Variable<double>(
        verticalMarginBoxesFadeLength.value,
      );
    }
    if (countdownDuration.present) {
      map['countdown_duration'] = Variable<double>(countdownDuration.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (appPrimaryColor.present) {
      map['app_primary_color'] = Variable<int>(appPrimaryColor.value);
    }
    if (prompterBackgroundColor.present) {
      map['prompter_background_color'] = Variable<int>(
        prompterBackgroundColor.value,
      );
    }
    if (prompterTextColor.present) {
      map['prompter_text_color'] = Variable<int>(prompterTextColor.value);
    }
    if (markdownEnabled.present) {
      map['markdown_enabled'] = Variable<bool>(markdownEnabled.value);
    }
    if (keybindings.present) {
      map['keybindings'] = Variable<int>(keybindings.value);
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

class $KeybindingMappingModelTable extends KeybindingMappingModel
    with TableInfo<$KeybindingMappingModelTable, KeybindingMappingModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KeybindingMappingModelTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _mapIdMeta = const VerificationMeta('mapId');
  @override
  late final GeneratedColumn<int> mapId = GeneratedColumn<int>(
    'map_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES keybinding_map_model (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _keyIdMeta = const VerificationMeta('keyId');
  @override
  late final GeneratedColumn<int> keyId = GeneratedColumn<int>(
    'key_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ctrlMeta = const VerificationMeta('ctrl');
  @override
  late final GeneratedColumn<bool> ctrl = GeneratedColumn<bool>(
    'ctrl',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("ctrl" IN (0, 1))',
    ),
  );
  static const VerificationMeta _shiftMeta = const VerificationMeta('shift');
  @override
  late final GeneratedColumn<bool> shift = GeneratedColumn<bool>(
    'shift',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("shift" IN (0, 1))',
    ),
  );
  static const VerificationMeta _altMeta = const VerificationMeta('alt');
  @override
  late final GeneratedColumn<bool> alt = GeneratedColumn<bool>(
    'alt',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("alt" IN (0, 1))',
    ),
  );
  static const VerificationMeta _metaMeta = const VerificationMeta('meta');
  @override
  late final GeneratedColumn<bool> meta = GeneratedColumn<bool>(
    'meta',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("meta" IN (0, 1))',
    ),
  );
  static const VerificationMeta _actionNameMeta = const VerificationMeta(
    'actionName',
  );
  @override
  late final GeneratedColumn<String> actionName = GeneratedColumn<String>(
    'action_name',
    aliasedName,
    false,
    check: () => actionName.isIn(KeybindingAction.values.map((e) => e.name)),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
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
  VerificationContext validateIntegrity(
    Insertable<KeybindingMappingModelData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KeybindingMappingModelData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KeybindingMappingModelData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mapId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}map_id'],
      )!,
      keyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}key_id'],
      )!,
      ctrl: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}ctrl'],
      )!,
      shift: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}shift'],
      )!,
      alt: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}alt'],
      )!,
      meta: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}meta'],
      )!,
      actionName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action_name'],
      )!,
    );
  }

  @override
  $KeybindingMappingModelTable createAlias(String alias) {
    return $KeybindingMappingModelTable(attachedDatabase, alias);
  }
}

class KeybindingMappingModelData extends DataClass
    implements Insertable<KeybindingMappingModelData> {
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
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['map_id'] = Variable<int>(mapId);
    map['key_id'] = Variable<int>(keyId);
    map['ctrl'] = Variable<bool>(ctrl);
    map['shift'] = Variable<bool>(shift);
    map['alt'] = Variable<bool>(alt);
    map['meta'] = Variable<bool>(meta);
    map['action_name'] = Variable<String>(actionName);
    return map;
  }

  KeybindingMappingModelCompanion toCompanion(bool nullToAbsent) {
    return KeybindingMappingModelCompanion(
      id: Value(id),
      mapId: Value(mapId),
      keyId: Value(keyId),
      ctrl: Value(ctrl),
      shift: Value(shift),
      alt: Value(alt),
      meta: Value(meta),
      actionName: Value(actionName),
    );
  }

  factory KeybindingMappingModelData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
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
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
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

  KeybindingMappingModelData copyWith({
    int? id,
    int? mapId,
    int? keyId,
    bool? ctrl,
    bool? shift,
    bool? alt,
    bool? meta,
    String? actionName,
  }) => KeybindingMappingModelData(
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
    KeybindingMappingModelCompanion data,
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
      (other is KeybindingMappingModelData &&
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
    extends UpdateCompanion<KeybindingMappingModelData> {
  final Value<int> id;
  final Value<int> mapId;
  final Value<int> keyId;
  final Value<bool> ctrl;
  final Value<bool> shift;
  final Value<bool> alt;
  final Value<bool> meta;
  final Value<String> actionName;
  const KeybindingMappingModelCompanion({
    this.id = const Value.absent(),
    this.mapId = const Value.absent(),
    this.keyId = const Value.absent(),
    this.ctrl = const Value.absent(),
    this.shift = const Value.absent(),
    this.alt = const Value.absent(),
    this.meta = const Value.absent(),
    this.actionName = const Value.absent(),
  });
  KeybindingMappingModelCompanion.insert({
    this.id = const Value.absent(),
    required int mapId,
    required int keyId,
    required bool ctrl,
    required bool shift,
    required bool alt,
    required bool meta,
    required String actionName,
  }) : mapId = Value(mapId),
       keyId = Value(keyId),
       ctrl = Value(ctrl),
       shift = Value(shift),
       alt = Value(alt),
       meta = Value(meta),
       actionName = Value(actionName);
  static Insertable<KeybindingMappingModelData> custom({
    Expression<int>? id,
    Expression<int>? mapId,
    Expression<int>? keyId,
    Expression<bool>? ctrl,
    Expression<bool>? shift,
    Expression<bool>? alt,
    Expression<bool>? meta,
    Expression<String>? actionName,
  }) {
    return RawValuesInsertable({
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

  KeybindingMappingModelCompanion copyWith({
    Value<int>? id,
    Value<int>? mapId,
    Value<int>? keyId,
    Value<bool>? ctrl,
    Value<bool>? shift,
    Value<bool>? alt,
    Value<bool>? meta,
    Value<String>? actionName,
  }) {
    return KeybindingMappingModelCompanion(
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
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mapId.present) {
      map['map_id'] = Variable<int>(mapId.value);
    }
    if (keyId.present) {
      map['key_id'] = Variable<int>(keyId.value);
    }
    if (ctrl.present) {
      map['ctrl'] = Variable<bool>(ctrl.value);
    }
    if (shift.present) {
      map['shift'] = Variable<bool>(shift.value);
    }
    if (alt.present) {
      map['alt'] = Variable<bool>(alt.value);
    }
    if (meta.present) {
      map['meta'] = Variable<bool>(meta.value);
    }
    if (actionName.present) {
      map['action_name'] = Variable<String>(actionName.value);
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ScriptModelTable scriptModel = $ScriptModelTable(this);
  late final $KeybindingMapModelTable keybindingMapModel =
      $KeybindingMapModelTable(this);
  late final $SettingsPresetModelTable settingsPresetModel =
      $SettingsPresetModelTable(this);
  late final $KeybindingMappingModelTable keybindingMappingModel =
      $KeybindingMappingModelTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    scriptModel,
    keybindingMapModel,
    settingsPresetModel,
    keybindingMappingModel,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'keybinding_map_model',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('settings_preset_model', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'keybinding_map_model',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('keybinding_mapping_model', kind: UpdateKind.delete),
      ],
    ),
  ]);
}

typedef $$ScriptModelTableCreateCompanionBuilder =
    ScriptModelCompanion Function({
      Value<int> id,
      required String title,
      required String scriptText,
      required DateTime createdAt,
    });
typedef $$ScriptModelTableUpdateCompanionBuilder =
    ScriptModelCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> scriptText,
      Value<DateTime> createdAt,
    });

class $$ScriptModelTableFilterComposer
    extends Composer<_$AppDatabase, $ScriptModelTable> {
  $$ScriptModelTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scriptText => $composableBuilder(
    column: $table.scriptText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ScriptModelTableOrderingComposer
    extends Composer<_$AppDatabase, $ScriptModelTable> {
  $$ScriptModelTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scriptText => $composableBuilder(
    column: $table.scriptText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ScriptModelTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScriptModelTable> {
  $$ScriptModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get scriptText => $composableBuilder(
    column: $table.scriptText,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ScriptModelTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScriptModelTable,
          ScriptModelData,
          $$ScriptModelTableFilterComposer,
          $$ScriptModelTableOrderingComposer,
          $$ScriptModelTableAnnotationComposer,
          $$ScriptModelTableCreateCompanionBuilder,
          $$ScriptModelTableUpdateCompanionBuilder,
          (
            ScriptModelData,
            BaseReferences<_$AppDatabase, $ScriptModelTable, ScriptModelData>,
          ),
          ScriptModelData,
          PrefetchHooks Function()
        > {
  $$ScriptModelTableTableManager(_$AppDatabase db, $ScriptModelTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScriptModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScriptModelTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScriptModelTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> scriptText = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ScriptModelCompanion(
                id: id,
                title: title,
                scriptText: scriptText,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String scriptText,
                required DateTime createdAt,
              }) => ScriptModelCompanion.insert(
                id: id,
                title: title,
                scriptText: scriptText,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ScriptModelTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScriptModelTable,
      ScriptModelData,
      $$ScriptModelTableFilterComposer,
      $$ScriptModelTableOrderingComposer,
      $$ScriptModelTableAnnotationComposer,
      $$ScriptModelTableCreateCompanionBuilder,
      $$ScriptModelTableUpdateCompanionBuilder,
      (
        ScriptModelData,
        BaseReferences<_$AppDatabase, $ScriptModelTable, ScriptModelData>,
      ),
      ScriptModelData,
      PrefetchHooks Function()
    >;
typedef $$KeybindingMapModelTableCreateCompanionBuilder =
    KeybindingMapModelCompanion Function({Value<int> id});
typedef $$KeybindingMapModelTableUpdateCompanionBuilder =
    KeybindingMapModelCompanion Function({Value<int> id});

final class $$KeybindingMapModelTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $KeybindingMapModelTable,
          KeybindingMapModelData
        > {
  $$KeybindingMapModelTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $SettingsPresetModelTable,
    List<SettingsPresetModelData>
  >
  _settingsPresetModelRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.settingsPresetModel,
        aliasName: $_aliasNameGenerator(
          db.keybindingMapModel.id,
          db.settingsPresetModel.keybindings,
        ),
      );

  $$SettingsPresetModelTableProcessedTableManager get settingsPresetModelRefs {
    final manager = $$SettingsPresetModelTableTableManager(
      $_db,
      $_db.settingsPresetModel,
    ).filter((f) => f.keybindings.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _settingsPresetModelRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $KeybindingMappingModelTable,
    List<KeybindingMappingModelData>
  >
  _keybindingMappingModelRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.keybindingMappingModel,
        aliasName: $_aliasNameGenerator(
          db.keybindingMapModel.id,
          db.keybindingMappingModel.mapId,
        ),
      );

  $$KeybindingMappingModelTableProcessedTableManager
  get keybindingMappingModelRefs {
    final manager = $$KeybindingMappingModelTableTableManager(
      $_db,
      $_db.keybindingMappingModel,
    ).filter((f) => f.mapId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _keybindingMappingModelRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$KeybindingMapModelTableFilterComposer
    extends Composer<_$AppDatabase, $KeybindingMapModelTable> {
  $$KeybindingMapModelTableFilterComposer({
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

  Expression<bool> settingsPresetModelRefs(
    Expression<bool> Function($$SettingsPresetModelTableFilterComposer f) f,
  ) {
    final $$SettingsPresetModelTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.settingsPresetModel,
      getReferencedColumn: (t) => t.keybindings,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SettingsPresetModelTableFilterComposer(
            $db: $db,
            $table: $db.settingsPresetModel,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> keybindingMappingModelRefs(
    Expression<bool> Function($$KeybindingMappingModelTableFilterComposer f) f,
  ) {
    final $$KeybindingMappingModelTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.keybindingMappingModel,
          getReferencedColumn: (t) => t.mapId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$KeybindingMappingModelTableFilterComposer(
                $db: $db,
                $table: $db.keybindingMappingModel,
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
    extends Composer<_$AppDatabase, $KeybindingMapModelTable> {
  $$KeybindingMapModelTableOrderingComposer({
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
}

class $$KeybindingMapModelTableAnnotationComposer
    extends Composer<_$AppDatabase, $KeybindingMapModelTable> {
  $$KeybindingMapModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  Expression<T> settingsPresetModelRefs<T extends Object>(
    Expression<T> Function($$SettingsPresetModelTableAnnotationComposer a) f,
  ) {
    final $$SettingsPresetModelTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.settingsPresetModel,
          getReferencedColumn: (t) => t.keybindings,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SettingsPresetModelTableAnnotationComposer(
                $db: $db,
                $table: $db.settingsPresetModel,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> keybindingMappingModelRefs<T extends Object>(
    Expression<T> Function($$KeybindingMappingModelTableAnnotationComposer a) f,
  ) {
    final $$KeybindingMappingModelTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.keybindingMappingModel,
          getReferencedColumn: (t) => t.mapId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$KeybindingMappingModelTableAnnotationComposer(
                $db: $db,
                $table: $db.keybindingMappingModel,
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
        RootTableManager<
          _$AppDatabase,
          $KeybindingMapModelTable,
          KeybindingMapModelData,
          $$KeybindingMapModelTableFilterComposer,
          $$KeybindingMapModelTableOrderingComposer,
          $$KeybindingMapModelTableAnnotationComposer,
          $$KeybindingMapModelTableCreateCompanionBuilder,
          $$KeybindingMapModelTableUpdateCompanionBuilder,
          (KeybindingMapModelData, $$KeybindingMapModelTableReferences),
          KeybindingMapModelData,
          PrefetchHooks Function({
            bool settingsPresetModelRefs,
            bool keybindingMappingModelRefs,
          })
        > {
  $$KeybindingMapModelTableTableManager(
    _$AppDatabase db,
    $KeybindingMapModelTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KeybindingMapModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KeybindingMapModelTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KeybindingMapModelTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback: ({Value<int> id = const Value.absent()}) =>
              KeybindingMapModelCompanion(id: id),
          createCompanionCallback: ({Value<int> id = const Value.absent()}) =>
              KeybindingMapModelCompanion.insert(id: id),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$KeybindingMapModelTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                settingsPresetModelRefs = false,
                keybindingMappingModelRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (settingsPresetModelRefs) db.settingsPresetModel,
                    if (keybindingMappingModelRefs) db.keybindingMappingModel,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (settingsPresetModelRefs)
                        await $_getPrefetchedData<
                          KeybindingMapModelData,
                          $KeybindingMapModelTable,
                          SettingsPresetModelData
                        >(
                          currentTable: table,
                          referencedTable: $$KeybindingMapModelTableReferences
                              ._settingsPresetModelRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$KeybindingMapModelTableReferences(
                                db,
                                table,
                                p0,
                              ).settingsPresetModelRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.keybindings == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (keybindingMappingModelRefs)
                        await $_getPrefetchedData<
                          KeybindingMapModelData,
                          $KeybindingMapModelTable,
                          KeybindingMappingModelData
                        >(
                          currentTable: table,
                          referencedTable: $$KeybindingMapModelTableReferences
                              ._keybindingMappingModelRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$KeybindingMapModelTableReferences(
                                db,
                                table,
                                p0,
                              ).keybindingMappingModelRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mapId == item.id,
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

typedef $$KeybindingMapModelTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KeybindingMapModelTable,
      KeybindingMapModelData,
      $$KeybindingMapModelTableFilterComposer,
      $$KeybindingMapModelTableOrderingComposer,
      $$KeybindingMapModelTableAnnotationComposer,
      $$KeybindingMapModelTableCreateCompanionBuilder,
      $$KeybindingMapModelTableUpdateCompanionBuilder,
      (KeybindingMapModelData, $$KeybindingMapModelTableReferences),
      KeybindingMapModelData,
      PrefetchHooks Function({
        bool settingsPresetModelRefs,
        bool keybindingMappingModelRefs,
      })
    >;
typedef $$SettingsPresetModelTableCreateCompanionBuilder =
    SettingsPresetModelCompanion Function({
      Value<int> id,
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
    SettingsPresetModelCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<double> scrollSpeed,
      Value<bool> mirroredX,
      Value<bool> mirroredY,
      Value<double> fontSize,
      Value<double> sideMargin,
      Value<String> fontFamily,
      Value<String> alignment,
      Value<bool> displayReadingIndicatorBoxes,
      Value<double> readingIndicatorBoxesHeight,
      Value<bool> displayVerticalMarginBoxes,
      Value<double> verticalMarginBoxesHeight,
      Value<bool> verticalMarginBoxesFadeEnabled,
      Value<double> verticalMarginBoxesFadeLength,
      Value<double> countdownDuration,
      Value<String> themeMode,
      Value<int> appPrimaryColor,
      Value<int> prompterBackgroundColor,
      Value<int> prompterTextColor,
      Value<bool> markdownEnabled,
      Value<int> keybindings,
    });

final class $$SettingsPresetModelTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SettingsPresetModelTable,
          SettingsPresetModelData
        > {
  $$SettingsPresetModelTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $KeybindingMapModelTable _keybindingsTable(_$AppDatabase db) =>
      db.keybindingMapModel.createAlias(
        $_aliasNameGenerator(
          db.settingsPresetModel.keybindings,
          db.keybindingMapModel.id,
        ),
      );

  $$KeybindingMapModelTableProcessedTableManager get keybindings {
    final $_column = $_itemColumn<int>('keybindings')!;

    final manager = $$KeybindingMapModelTableTableManager(
      $_db,
      $_db.keybindingMapModel,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_keybindingsTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SettingsPresetModelTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsPresetModelTable> {
  $$SettingsPresetModelTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get scrollSpeed => $composableBuilder(
    column: $table.scrollSpeed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get mirroredX => $composableBuilder(
    column: $table.mirroredX,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get mirroredY => $composableBuilder(
    column: $table.mirroredY,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fontSize => $composableBuilder(
    column: $table.fontSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sideMargin => $composableBuilder(
    column: $table.sideMargin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fontFamily => $composableBuilder(
    column: $table.fontFamily,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alignment => $composableBuilder(
    column: $table.alignment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get displayReadingIndicatorBoxes => $composableBuilder(
    column: $table.displayReadingIndicatorBoxes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get readingIndicatorBoxesHeight => $composableBuilder(
    column: $table.readingIndicatorBoxesHeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get displayVerticalMarginBoxes => $composableBuilder(
    column: $table.displayVerticalMarginBoxes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get verticalMarginBoxesHeight => $composableBuilder(
    column: $table.verticalMarginBoxesHeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get verticalMarginBoxesFadeEnabled => $composableBuilder(
    column: $table.verticalMarginBoxesFadeEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get verticalMarginBoxesFadeLength => $composableBuilder(
    column: $table.verticalMarginBoxesFadeLength,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get countdownDuration => $composableBuilder(
    column: $table.countdownDuration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get appPrimaryColor => $composableBuilder(
    column: $table.appPrimaryColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get prompterBackgroundColor => $composableBuilder(
    column: $table.prompterBackgroundColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get prompterTextColor => $composableBuilder(
    column: $table.prompterTextColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get markdownEnabled => $composableBuilder(
    column: $table.markdownEnabled,
    builder: (column) => ColumnFilters(column),
  );

  $$KeybindingMapModelTableFilterComposer get keybindings {
    final $$KeybindingMapModelTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.keybindings,
      referencedTable: $db.keybindingMapModel,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KeybindingMapModelTableFilterComposer(
            $db: $db,
            $table: $db.keybindingMapModel,
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
    extends Composer<_$AppDatabase, $SettingsPresetModelTable> {
  $$SettingsPresetModelTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get scrollSpeed => $composableBuilder(
    column: $table.scrollSpeed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get mirroredX => $composableBuilder(
    column: $table.mirroredX,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get mirroredY => $composableBuilder(
    column: $table.mirroredY,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fontSize => $composableBuilder(
    column: $table.fontSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sideMargin => $composableBuilder(
    column: $table.sideMargin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fontFamily => $composableBuilder(
    column: $table.fontFamily,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alignment => $composableBuilder(
    column: $table.alignment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get displayReadingIndicatorBoxes => $composableBuilder(
    column: $table.displayReadingIndicatorBoxes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get readingIndicatorBoxesHeight => $composableBuilder(
    column: $table.readingIndicatorBoxesHeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get displayVerticalMarginBoxes => $composableBuilder(
    column: $table.displayVerticalMarginBoxes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get verticalMarginBoxesHeight => $composableBuilder(
    column: $table.verticalMarginBoxesHeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get verticalMarginBoxesFadeEnabled =>
      $composableBuilder(
        column: $table.verticalMarginBoxesFadeEnabled,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<double> get verticalMarginBoxesFadeLength =>
      $composableBuilder(
        column: $table.verticalMarginBoxesFadeLength,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<double> get countdownDuration => $composableBuilder(
    column: $table.countdownDuration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get appPrimaryColor => $composableBuilder(
    column: $table.appPrimaryColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get prompterBackgroundColor => $composableBuilder(
    column: $table.prompterBackgroundColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get prompterTextColor => $composableBuilder(
    column: $table.prompterTextColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get markdownEnabled => $composableBuilder(
    column: $table.markdownEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  $$KeybindingMapModelTableOrderingComposer get keybindings {
    final $$KeybindingMapModelTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.keybindings,
      referencedTable: $db.keybindingMapModel,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KeybindingMapModelTableOrderingComposer(
            $db: $db,
            $table: $db.keybindingMapModel,
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
    extends Composer<_$AppDatabase, $SettingsPresetModelTable> {
  $$SettingsPresetModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<double> get scrollSpeed => $composableBuilder(
    column: $table.scrollSpeed,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get mirroredX =>
      $composableBuilder(column: $table.mirroredX, builder: (column) => column);

  GeneratedColumn<bool> get mirroredY =>
      $composableBuilder(column: $table.mirroredY, builder: (column) => column);

  GeneratedColumn<double> get fontSize =>
      $composableBuilder(column: $table.fontSize, builder: (column) => column);

  GeneratedColumn<double> get sideMargin => $composableBuilder(
    column: $table.sideMargin,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fontFamily => $composableBuilder(
    column: $table.fontFamily,
    builder: (column) => column,
  );

  GeneratedColumn<String> get alignment =>
      $composableBuilder(column: $table.alignment, builder: (column) => column);

  GeneratedColumn<bool> get displayReadingIndicatorBoxes => $composableBuilder(
    column: $table.displayReadingIndicatorBoxes,
    builder: (column) => column,
  );

  GeneratedColumn<double> get readingIndicatorBoxesHeight => $composableBuilder(
    column: $table.readingIndicatorBoxesHeight,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get displayVerticalMarginBoxes => $composableBuilder(
    column: $table.displayVerticalMarginBoxes,
    builder: (column) => column,
  );

  GeneratedColumn<double> get verticalMarginBoxesHeight => $composableBuilder(
    column: $table.verticalMarginBoxesHeight,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get verticalMarginBoxesFadeEnabled =>
      $composableBuilder(
        column: $table.verticalMarginBoxesFadeEnabled,
        builder: (column) => column,
      );

  GeneratedColumn<double> get verticalMarginBoxesFadeLength =>
      $composableBuilder(
        column: $table.verticalMarginBoxesFadeLength,
        builder: (column) => column,
      );

  GeneratedColumn<double> get countdownDuration => $composableBuilder(
    column: $table.countdownDuration,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<int> get appPrimaryColor => $composableBuilder(
    column: $table.appPrimaryColor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get prompterBackgroundColor => $composableBuilder(
    column: $table.prompterBackgroundColor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get prompterTextColor => $composableBuilder(
    column: $table.prompterTextColor,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get markdownEnabled => $composableBuilder(
    column: $table.markdownEnabled,
    builder: (column) => column,
  );

  $$KeybindingMapModelTableAnnotationComposer get keybindings {
    final $$KeybindingMapModelTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.keybindings,
          referencedTable: $db.keybindingMapModel,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$KeybindingMapModelTableAnnotationComposer(
                $db: $db,
                $table: $db.keybindingMapModel,
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
        RootTableManager<
          _$AppDatabase,
          $SettingsPresetModelTable,
          SettingsPresetModelData,
          $$SettingsPresetModelTableFilterComposer,
          $$SettingsPresetModelTableOrderingComposer,
          $$SettingsPresetModelTableAnnotationComposer,
          $$SettingsPresetModelTableCreateCompanionBuilder,
          $$SettingsPresetModelTableUpdateCompanionBuilder,
          (SettingsPresetModelData, $$SettingsPresetModelTableReferences),
          SettingsPresetModelData,
          PrefetchHooks Function({bool keybindings})
        > {
  $$SettingsPresetModelTableTableManager(
    _$AppDatabase db,
    $SettingsPresetModelTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsPresetModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsPresetModelTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SettingsPresetModelTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<double> scrollSpeed = const Value.absent(),
                Value<bool> mirroredX = const Value.absent(),
                Value<bool> mirroredY = const Value.absent(),
                Value<double> fontSize = const Value.absent(),
                Value<double> sideMargin = const Value.absent(),
                Value<String> fontFamily = const Value.absent(),
                Value<String> alignment = const Value.absent(),
                Value<bool> displayReadingIndicatorBoxes = const Value.absent(),
                Value<double> readingIndicatorBoxesHeight =
                    const Value.absent(),
                Value<bool> displayVerticalMarginBoxes = const Value.absent(),
                Value<double> verticalMarginBoxesHeight = const Value.absent(),
                Value<bool> verticalMarginBoxesFadeEnabled =
                    const Value.absent(),
                Value<double> verticalMarginBoxesFadeLength =
                    const Value.absent(),
                Value<double> countdownDuration = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<int> appPrimaryColor = const Value.absent(),
                Value<int> prompterBackgroundColor = const Value.absent(),
                Value<int> prompterTextColor = const Value.absent(),
                Value<bool> markdownEnabled = const Value.absent(),
                Value<int> keybindings = const Value.absent(),
              }) => SettingsPresetModelCompanion(
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
                Value<int> id = const Value.absent(),
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
              }) => SettingsPresetModelCompanion.insert(
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
                  $$SettingsPresetModelTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({keybindings = false}) {
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
                    if (keybindings) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.keybindings,
                                referencedTable:
                                    $$SettingsPresetModelTableReferences
                                        ._keybindingsTable(db),
                                referencedColumn:
                                    $$SettingsPresetModelTableReferences
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
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsPresetModelTable,
      SettingsPresetModelData,
      $$SettingsPresetModelTableFilterComposer,
      $$SettingsPresetModelTableOrderingComposer,
      $$SettingsPresetModelTableAnnotationComposer,
      $$SettingsPresetModelTableCreateCompanionBuilder,
      $$SettingsPresetModelTableUpdateCompanionBuilder,
      (SettingsPresetModelData, $$SettingsPresetModelTableReferences),
      SettingsPresetModelData,
      PrefetchHooks Function({bool keybindings})
    >;
typedef $$KeybindingMappingModelTableCreateCompanionBuilder =
    KeybindingMappingModelCompanion Function({
      Value<int> id,
      required int mapId,
      required int keyId,
      required bool ctrl,
      required bool shift,
      required bool alt,
      required bool meta,
      required String actionName,
    });
typedef $$KeybindingMappingModelTableUpdateCompanionBuilder =
    KeybindingMappingModelCompanion Function({
      Value<int> id,
      Value<int> mapId,
      Value<int> keyId,
      Value<bool> ctrl,
      Value<bool> shift,
      Value<bool> alt,
      Value<bool> meta,
      Value<String> actionName,
    });

final class $$KeybindingMappingModelTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $KeybindingMappingModelTable,
          KeybindingMappingModelData
        > {
  $$KeybindingMappingModelTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $KeybindingMapModelTable _mapIdTable(_$AppDatabase db) =>
      db.keybindingMapModel.createAlias(
        $_aliasNameGenerator(
          db.keybindingMappingModel.mapId,
          db.keybindingMapModel.id,
        ),
      );

  $$KeybindingMapModelTableProcessedTableManager get mapId {
    final $_column = $_itemColumn<int>('map_id')!;

    final manager = $$KeybindingMapModelTableTableManager(
      $_db,
      $_db.keybindingMapModel,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mapIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$KeybindingMappingModelTableFilterComposer
    extends Composer<_$AppDatabase, $KeybindingMappingModelTable> {
  $$KeybindingMappingModelTableFilterComposer({
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

  ColumnFilters<int> get keyId => $composableBuilder(
    column: $table.keyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get ctrl => $composableBuilder(
    column: $table.ctrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get shift => $composableBuilder(
    column: $table.shift,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get alt => $composableBuilder(
    column: $table.alt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get meta => $composableBuilder(
    column: $table.meta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actionName => $composableBuilder(
    column: $table.actionName,
    builder: (column) => ColumnFilters(column),
  );

  $$KeybindingMapModelTableFilterComposer get mapId {
    final $$KeybindingMapModelTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mapId,
      referencedTable: $db.keybindingMapModel,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KeybindingMapModelTableFilterComposer(
            $db: $db,
            $table: $db.keybindingMapModel,
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
    extends Composer<_$AppDatabase, $KeybindingMappingModelTable> {
  $$KeybindingMappingModelTableOrderingComposer({
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

  ColumnOrderings<int> get keyId => $composableBuilder(
    column: $table.keyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get ctrl => $composableBuilder(
    column: $table.ctrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get shift => $composableBuilder(
    column: $table.shift,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get alt => $composableBuilder(
    column: $table.alt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get meta => $composableBuilder(
    column: $table.meta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actionName => $composableBuilder(
    column: $table.actionName,
    builder: (column) => ColumnOrderings(column),
  );

  $$KeybindingMapModelTableOrderingComposer get mapId {
    final $$KeybindingMapModelTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mapId,
      referencedTable: $db.keybindingMapModel,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KeybindingMapModelTableOrderingComposer(
            $db: $db,
            $table: $db.keybindingMapModel,
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
    extends Composer<_$AppDatabase, $KeybindingMappingModelTable> {
  $$KeybindingMappingModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get keyId =>
      $composableBuilder(column: $table.keyId, builder: (column) => column);

  GeneratedColumn<bool> get ctrl =>
      $composableBuilder(column: $table.ctrl, builder: (column) => column);

  GeneratedColumn<bool> get shift =>
      $composableBuilder(column: $table.shift, builder: (column) => column);

  GeneratedColumn<bool> get alt =>
      $composableBuilder(column: $table.alt, builder: (column) => column);

  GeneratedColumn<bool> get meta =>
      $composableBuilder(column: $table.meta, builder: (column) => column);

  GeneratedColumn<String> get actionName => $composableBuilder(
    column: $table.actionName,
    builder: (column) => column,
  );

  $$KeybindingMapModelTableAnnotationComposer get mapId {
    final $$KeybindingMapModelTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.mapId,
          referencedTable: $db.keybindingMapModel,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$KeybindingMapModelTableAnnotationComposer(
                $db: $db,
                $table: $db.keybindingMapModel,
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
        RootTableManager<
          _$AppDatabase,
          $KeybindingMappingModelTable,
          KeybindingMappingModelData,
          $$KeybindingMappingModelTableFilterComposer,
          $$KeybindingMappingModelTableOrderingComposer,
          $$KeybindingMappingModelTableAnnotationComposer,
          $$KeybindingMappingModelTableCreateCompanionBuilder,
          $$KeybindingMappingModelTableUpdateCompanionBuilder,
          (KeybindingMappingModelData, $$KeybindingMappingModelTableReferences),
          KeybindingMappingModelData,
          PrefetchHooks Function({bool mapId})
        > {
  $$KeybindingMappingModelTableTableManager(
    _$AppDatabase db,
    $KeybindingMappingModelTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KeybindingMappingModelTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$KeybindingMappingModelTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$KeybindingMappingModelTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mapId = const Value.absent(),
                Value<int> keyId = const Value.absent(),
                Value<bool> ctrl = const Value.absent(),
                Value<bool> shift = const Value.absent(),
                Value<bool> alt = const Value.absent(),
                Value<bool> meta = const Value.absent(),
                Value<String> actionName = const Value.absent(),
              }) => KeybindingMappingModelCompanion(
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
                Value<int> id = const Value.absent(),
                required int mapId,
                required int keyId,
                required bool ctrl,
                required bool shift,
                required bool alt,
                required bool meta,
                required String actionName,
              }) => KeybindingMappingModelCompanion.insert(
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
                  $$KeybindingMappingModelTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mapId = false}) {
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
                    if (mapId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.mapId,
                                referencedTable:
                                    $$KeybindingMappingModelTableReferences
                                        ._mapIdTable(db),
                                referencedColumn:
                                    $$KeybindingMappingModelTableReferences
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
    ProcessedTableManager<
      _$AppDatabase,
      $KeybindingMappingModelTable,
      KeybindingMappingModelData,
      $$KeybindingMappingModelTableFilterComposer,
      $$KeybindingMappingModelTableOrderingComposer,
      $$KeybindingMappingModelTableAnnotationComposer,
      $$KeybindingMappingModelTableCreateCompanionBuilder,
      $$KeybindingMappingModelTableUpdateCompanionBuilder,
      (KeybindingMappingModelData, $$KeybindingMappingModelTableReferences),
      KeybindingMappingModelData,
      PrefetchHooks Function({bool mapId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ScriptModelTableTableManager get scriptModel =>
      $$ScriptModelTableTableManager(_db, _db.scriptModel);
  $$KeybindingMapModelTableTableManager get keybindingMapModel =>
      $$KeybindingMapModelTableTableManager(_db, _db.keybindingMapModel);
  $$SettingsPresetModelTableTableManager get settingsPresetModel =>
      $$SettingsPresetModelTableTableManager(_db, _db.settingsPresetModel);
  $$KeybindingMappingModelTableTableManager get keybindingMappingModel =>
      $$KeybindingMappingModelTableTableManager(
        _db,
        _db.keybindingMappingModel,
      );
}
