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

class $SettingsModelTable extends SettingsModel
    with TableInfo<$SettingsModelTable, SettingsModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsModelTable(this.attachedDatabase, [this._alias]);
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
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings_model';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingsModelData> instance, {
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SettingsModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsModelData(
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
    );
  }

  @override
  $SettingsModelTable createAlias(String alias) {
    return $SettingsModelTable(attachedDatabase, alias);
  }
}

class SettingsModelData extends DataClass
    implements Insertable<SettingsModelData> {
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
  const SettingsModelData({
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
    return map;
  }

  SettingsModelCompanion toCompanion(bool nullToAbsent) {
    return SettingsModelCompanion(
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
    );
  }

  factory SettingsModelData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsModelData(
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
    };
  }

  SettingsModelData copyWith({
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
  }) => SettingsModelData(
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
  );
  SettingsModelData copyWithCompanion(SettingsModelCompanion data) {
    return SettingsModelData(
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
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsModelData(')
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
          ..write('markdownEnabled: $markdownEnabled')
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
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsModelData &&
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
          other.markdownEnabled == this.markdownEnabled);
}

class SettingsModelCompanion extends UpdateCompanion<SettingsModelData> {
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
  const SettingsModelCompanion({
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
  });
  SettingsModelCompanion.insert({
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
       markdownEnabled = Value(markdownEnabled);
  static Insertable<SettingsModelData> custom({
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
    });
  }

  SettingsModelCompanion copyWith({
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
  }) {
    return SettingsModelCompanion(
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsModelCompanion(')
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
          ..write('markdownEnabled: $markdownEnabled')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ScriptModelTable scriptModel = $ScriptModelTable(this);
  late final $SettingsModelTable settingsModel = $SettingsModelTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    scriptModel,
    settingsModel,
  ];
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
typedef $$SettingsModelTableCreateCompanionBuilder =
    SettingsModelCompanion Function({
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
    });
typedef $$SettingsModelTableUpdateCompanionBuilder =
    SettingsModelCompanion Function({
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
    });

class $$SettingsModelTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsModelTable> {
  $$SettingsModelTableFilterComposer({
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
}

class $$SettingsModelTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsModelTable> {
  $$SettingsModelTableOrderingComposer({
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
}

class $$SettingsModelTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsModelTable> {
  $$SettingsModelTableAnnotationComposer({
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
}

class $$SettingsModelTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsModelTable,
          SettingsModelData,
          $$SettingsModelTableFilterComposer,
          $$SettingsModelTableOrderingComposer,
          $$SettingsModelTableAnnotationComposer,
          $$SettingsModelTableCreateCompanionBuilder,
          $$SettingsModelTableUpdateCompanionBuilder,
          (
            SettingsModelData,
            BaseReferences<
              _$AppDatabase,
              $SettingsModelTable,
              SettingsModelData
            >,
          ),
          SettingsModelData,
          PrefetchHooks Function()
        > {
  $$SettingsModelTableTableManager(_$AppDatabase db, $SettingsModelTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsModelTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsModelTableAnnotationComposer($db: db, $table: table),
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
              }) => SettingsModelCompanion(
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
              }) => SettingsModelCompanion.insert(
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
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsModelTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsModelTable,
      SettingsModelData,
      $$SettingsModelTableFilterComposer,
      $$SettingsModelTableOrderingComposer,
      $$SettingsModelTableAnnotationComposer,
      $$SettingsModelTableCreateCompanionBuilder,
      $$SettingsModelTableUpdateCompanionBuilder,
      (
        SettingsModelData,
        BaseReferences<_$AppDatabase, $SettingsModelTable, SettingsModelData>,
      ),
      SettingsModelData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ScriptModelTableTableManager get scriptModel =>
      $$ScriptModelTableTableManager(_db, _db.scriptModel);
  $$SettingsModelTableTableManager get settingsModel =>
      $$SettingsModelTableTableManager(_db, _db.settingsModel);
}
