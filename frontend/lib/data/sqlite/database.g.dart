// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class Identities extends Table with TableInfo<Identities, Identity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Identities(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [id, username];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'identities';
  @override
  VerificationContext validateIntegrity(
    Insertable<Identity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Identity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Identity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
    );
  }

  @override
  Identities createAlias(String alias) {
    return Identities(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Identity extends DataClass implements Insertable<Identity> {
  final int id;
  final String username;
  const Identity({required this.id, required this.username});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    return map;
  }

  IdentitiesCompanion toCompanion(bool nullToAbsent) {
    return IdentitiesCompanion(id: Value(id), username: Value(username));
  }

  factory Identity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Identity(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
    };
  }

  Identity copyWith({int? id, String? username}) =>
      Identity(id: id ?? this.id, username: username ?? this.username);
  Identity copyWithCompanion(IdentitiesCompanion data) {
    return Identity(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Identity(')
          ..write('id: $id, ')
          ..write('username: $username')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Identity &&
          other.id == this.id &&
          other.username == this.username);
}

class IdentitiesCompanion extends UpdateCompanion<Identity> {
  final Value<int> id;
  final Value<String> username;
  const IdentitiesCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
  });
  IdentitiesCompanion.insert({
    this.id = const Value.absent(),
    required String username,
  }) : username = Value(username);
  static Insertable<Identity> custom({
    Expression<int>? id,
    Expression<String>? username,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
    });
  }

  IdentitiesCompanion copyWith({Value<int>? id, Value<String>? username}) {
    return IdentitiesCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IdentitiesCompanion(')
          ..write('id: $id, ')
          ..write('username: $username')
          ..write(')'))
        .toString();
  }
}

class Credentials extends Table with TableInfo<Credentials, Credential> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Credentials(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY AUTOINCREMENT',
  );
  late final GeneratedColumnWithTypeConverter<CredentialType, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      ).withConverter<CredentialType>(Credentials.$convertertype);
  static const VerificationMeta _secretMeta = const VerificationMeta('secret');
  late final GeneratedColumn<String> secret = GeneratedColumn<String>(
    'secret',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _passphraseMeta = const VerificationMeta(
    'passphrase',
  );
  late final GeneratedColumn<String> passphrase = GeneratedColumn<String>(
    'passphrase',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    secret,
    passphrase,
    priority,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'credentials';
  @override
  VerificationContext validateIntegrity(
    Insertable<Credential> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('secret')) {
      context.handle(
        _secretMeta,
        secret.isAcceptableOrUnknown(data['secret']!, _secretMeta),
      );
    }
    if (data.containsKey('passphrase')) {
      context.handle(
        _passphraseMeta,
        passphrase.isAcceptableOrUnknown(data['passphrase']!, _passphraseMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Credential map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Credential(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: Credentials.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
      secret: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}secret'],
      ),
      passphrase: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}passphrase'],
      ),
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
    );
  }

  @override
  Credentials createAlias(String alias) {
    return Credentials(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CredentialType, int, int> $convertertype =
      const EnumIndexConverter<CredentialType>(CredentialType.values);
  @override
  bool get dontWriteConstraints => true;
}

class Credential extends DataClass implements Insertable<Credential> {
  final int id;
  final CredentialType type;
  final String? secret;
  final String? passphrase;
  final int priority;
  const Credential({
    required this.id,
    required this.type,
    this.secret,
    this.passphrase,
    required this.priority,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['type'] = Variable<int>(Credentials.$convertertype.toSql(type));
    }
    if (!nullToAbsent || secret != null) {
      map['secret'] = Variable<String>(secret);
    }
    if (!nullToAbsent || passphrase != null) {
      map['passphrase'] = Variable<String>(passphrase);
    }
    map['priority'] = Variable<int>(priority);
    return map;
  }

  CredentialsCompanion toCompanion(bool nullToAbsent) {
    return CredentialsCompanion(
      id: Value(id),
      type: Value(type),
      secret: secret == null && nullToAbsent
          ? const Value.absent()
          : Value(secret),
      passphrase: passphrase == null && nullToAbsent
          ? const Value.absent()
          : Value(passphrase),
      priority: Value(priority),
    );
  }

  factory Credential.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Credential(
      id: serializer.fromJson<int>(json['id']),
      type: Credentials.$convertertype.fromJson(
        serializer.fromJson<int>(json['type']),
      ),
      secret: serializer.fromJson<String?>(json['secret']),
      passphrase: serializer.fromJson<String?>(json['passphrase']),
      priority: serializer.fromJson<int>(json['priority']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<int>(Credentials.$convertertype.toJson(type)),
      'secret': serializer.toJson<String?>(secret),
      'passphrase': serializer.toJson<String?>(passphrase),
      'priority': serializer.toJson<int>(priority),
    };
  }

  Credential copyWith({
    int? id,
    CredentialType? type,
    Value<String?> secret = const Value.absent(),
    Value<String?> passphrase = const Value.absent(),
    int? priority,
  }) => Credential(
    id: id ?? this.id,
    type: type ?? this.type,
    secret: secret.present ? secret.value : this.secret,
    passphrase: passphrase.present ? passphrase.value : this.passphrase,
    priority: priority ?? this.priority,
  );
  Credential copyWithCompanion(CredentialsCompanion data) {
    return Credential(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      secret: data.secret.present ? data.secret.value : this.secret,
      passphrase: data.passphrase.present
          ? data.passphrase.value
          : this.passphrase,
      priority: data.priority.present ? data.priority.value : this.priority,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Credential(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('secret: $secret, ')
          ..write('passphrase: $passphrase, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, secret, passphrase, priority);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Credential &&
          other.id == this.id &&
          other.type == this.type &&
          other.secret == this.secret &&
          other.passphrase == this.passphrase &&
          other.priority == this.priority);
}

class CredentialsCompanion extends UpdateCompanion<Credential> {
  final Value<int> id;
  final Value<CredentialType> type;
  final Value<String?> secret;
  final Value<String?> passphrase;
  final Value<int> priority;
  const CredentialsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.secret = const Value.absent(),
    this.passphrase = const Value.absent(),
    this.priority = const Value.absent(),
  });
  CredentialsCompanion.insert({
    this.id = const Value.absent(),
    required CredentialType type,
    this.secret = const Value.absent(),
    this.passphrase = const Value.absent(),
    this.priority = const Value.absent(),
  }) : type = Value(type);
  static Insertable<Credential> custom({
    Expression<int>? id,
    Expression<int>? type,
    Expression<String>? secret,
    Expression<String>? passphrase,
    Expression<int>? priority,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (secret != null) 'secret': secret,
      if (passphrase != null) 'passphrase': passphrase,
      if (priority != null) 'priority': priority,
    });
  }

  CredentialsCompanion copyWith({
    Value<int>? id,
    Value<CredentialType>? type,
    Value<String?>? secret,
    Value<String?>? passphrase,
    Value<int>? priority,
  }) {
    return CredentialsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      secret: secret ?? this.secret,
      passphrase: passphrase ?? this.passphrase,
      priority: priority ?? this.priority,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(Credentials.$convertertype.toSql(type.value));
    }
    if (secret.present) {
      map['secret'] = Variable<String>(secret.value);
    }
    if (passphrase.present) {
      map['passphrase'] = Variable<String>(passphrase.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CredentialsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('secret: $secret, ')
          ..write('passphrase: $passphrase, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }
}

class IdentityCredentials extends Table
    with TableInfo<IdentityCredentials, IdentityCredential> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  IdentityCredentials(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _identityIdMeta = const VerificationMeta(
    'identityId',
  );
  late final GeneratedColumn<int> identityId = GeneratedColumn<int>(
    'identity_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _credentialIdMeta = const VerificationMeta(
    'credentialId',
  );
  late final GeneratedColumn<int> credentialId = GeneratedColumn<int>(
    'credential_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [identityId, credentialId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'identity_credentials';
  @override
  VerificationContext validateIntegrity(
    Insertable<IdentityCredential> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('identity_id')) {
      context.handle(
        _identityIdMeta,
        identityId.isAcceptableOrUnknown(data['identity_id']!, _identityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_identityIdMeta);
    }
    if (data.containsKey('credential_id')) {
      context.handle(
        _credentialIdMeta,
        credentialId.isAcceptableOrUnknown(
          data['credential_id']!,
          _credentialIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_credentialIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {identityId, credentialId};
  @override
  IdentityCredential map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IdentityCredential(
      identityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}identity_id'],
      )!,
      credentialId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}credential_id'],
      )!,
    );
  }

  @override
  IdentityCredentials createAlias(String alias) {
    return IdentityCredentials(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(identity_id, credential_id)',
    'FOREIGN KEY(identity_id)REFERENCES identities(id)ON DELETE CASCADE',
    'FOREIGN KEY(credential_id)REFERENCES credentials(id)ON DELETE CASCADE',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class IdentityCredential extends DataClass
    implements Insertable<IdentityCredential> {
  final int identityId;
  final int credentialId;
  const IdentityCredential({
    required this.identityId,
    required this.credentialId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['identity_id'] = Variable<int>(identityId);
    map['credential_id'] = Variable<int>(credentialId);
    return map;
  }

  IdentityCredentialsCompanion toCompanion(bool nullToAbsent) {
    return IdentityCredentialsCompanion(
      identityId: Value(identityId),
      credentialId: Value(credentialId),
    );
  }

  factory IdentityCredential.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IdentityCredential(
      identityId: serializer.fromJson<int>(json['identity_id']),
      credentialId: serializer.fromJson<int>(json['credential_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'identity_id': serializer.toJson<int>(identityId),
      'credential_id': serializer.toJson<int>(credentialId),
    };
  }

  IdentityCredential copyWith({int? identityId, int? credentialId}) =>
      IdentityCredential(
        identityId: identityId ?? this.identityId,
        credentialId: credentialId ?? this.credentialId,
      );
  IdentityCredential copyWithCompanion(IdentityCredentialsCompanion data) {
    return IdentityCredential(
      identityId: data.identityId.present
          ? data.identityId.value
          : this.identityId,
      credentialId: data.credentialId.present
          ? data.credentialId.value
          : this.credentialId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IdentityCredential(')
          ..write('identityId: $identityId, ')
          ..write('credentialId: $credentialId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(identityId, credentialId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IdentityCredential &&
          other.identityId == this.identityId &&
          other.credentialId == this.credentialId);
}

class IdentityCredentialsCompanion extends UpdateCompanion<IdentityCredential> {
  final Value<int> identityId;
  final Value<int> credentialId;
  final Value<int> rowid;
  const IdentityCredentialsCompanion({
    this.identityId = const Value.absent(),
    this.credentialId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IdentityCredentialsCompanion.insert({
    required int identityId,
    required int credentialId,
    this.rowid = const Value.absent(),
  }) : identityId = Value(identityId),
       credentialId = Value(credentialId);
  static Insertable<IdentityCredential> custom({
    Expression<int>? identityId,
    Expression<int>? credentialId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (identityId != null) 'identity_id': identityId,
      if (credentialId != null) 'credential_id': credentialId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IdentityCredentialsCompanion copyWith({
    Value<int>? identityId,
    Value<int>? credentialId,
    Value<int>? rowid,
  }) {
    return IdentityCredentialsCompanion(
      identityId: identityId ?? this.identityId,
      credentialId: credentialId ?? this.credentialId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (identityId.present) {
      map['identity_id'] = Variable<int>(identityId.value);
    }
    if (credentialId.present) {
      map['credential_id'] = Variable<int>(credentialId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IdentityCredentialsCompanion(')
          ..write('identityId: $identityId, ')
          ..write('credentialId: $credentialId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Connections extends Table with TableInfo<Connections, Connection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Connections(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _portMeta = const VerificationMeta('port');
  late final GeneratedColumn<int> port = GeneratedColumn<int>(
    'port',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 22',
    defaultValue: const CustomExpression('22'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, address, port];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'connections';
  @override
  VerificationContext validateIntegrity(
    Insertable<Connection> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('port')) {
      context.handle(
        _portMeta,
        port.isAcceptableOrUnknown(data['port']!, _portMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Connection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Connection(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      port: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}port'],
      )!,
    );
  }

  @override
  Connections createAlias(String alias) {
    return Connections(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Connection extends DataClass implements Insertable<Connection> {
  final int id;
  final String address;
  final int port;
  const Connection({
    required this.id,
    required this.address,
    required this.port,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['address'] = Variable<String>(address);
    map['port'] = Variable<int>(port);
    return map;
  }

  ConnectionsCompanion toCompanion(bool nullToAbsent) {
    return ConnectionsCompanion(
      id: Value(id),
      address: Value(address),
      port: Value(port),
    );
  }

  factory Connection.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Connection(
      id: serializer.fromJson<int>(json['id']),
      address: serializer.fromJson<String>(json['address']),
      port: serializer.fromJson<int>(json['port']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'address': serializer.toJson<String>(address),
      'port': serializer.toJson<int>(port),
    };
  }

  Connection copyWith({int? id, String? address, int? port}) => Connection(
    id: id ?? this.id,
    address: address ?? this.address,
    port: port ?? this.port,
  );
  Connection copyWithCompanion(ConnectionsCompanion data) {
    return Connection(
      id: data.id.present ? data.id.value : this.id,
      address: data.address.present ? data.address.value : this.address,
      port: data.port.present ? data.port.value : this.port,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Connection(')
          ..write('id: $id, ')
          ..write('address: $address, ')
          ..write('port: $port')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, address, port);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Connection &&
          other.id == this.id &&
          other.address == this.address &&
          other.port == this.port);
}

class ConnectionsCompanion extends UpdateCompanion<Connection> {
  final Value<int> id;
  final Value<String> address;
  final Value<int> port;
  const ConnectionsCompanion({
    this.id = const Value.absent(),
    this.address = const Value.absent(),
    this.port = const Value.absent(),
  });
  ConnectionsCompanion.insert({
    this.id = const Value.absent(),
    required String address,
    this.port = const Value.absent(),
  }) : address = Value(address);
  static Insertable<Connection> custom({
    Expression<int>? id,
    Expression<String>? address,
    Expression<int>? port,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (address != null) 'address': address,
      if (port != null) 'port': port,
    });
  }

  ConnectionsCompanion copyWith({
    Value<int>? id,
    Value<String>? address,
    Value<int>? port,
  }) {
    return ConnectionsCompanion(
      id: id ?? this.id,
      address: address ?? this.address,
      port: port ?? this.port,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (port.present) {
      map['port'] = Variable<int>(port.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConnectionsCompanion(')
          ..write('id: $id, ')
          ..write('address: $address, ')
          ..write('port: $port')
          ..write(')'))
        .toString();
  }
}

abstract class _$CliqDatabase extends GeneratedDatabase {
  _$CliqDatabase(QueryExecutor e) : super(e);
  $CliqDatabaseManager get managers => $CliqDatabaseManager(this);
  late final Identities identities = Identities(this);
  late final Credentials credentials = Credentials(this);
  late final IdentityCredentials identityCredentials = IdentityCredentials(
    this,
  );
  late final Connections connections = Connections(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    identities,
    credentials,
    identityCredentials,
    connections,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'identities',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('identity_credentials', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'credentials',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('identity_credentials', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $IdentitiesCreateCompanionBuilder =
    IdentitiesCompanion Function({Value<int> id, required String username});
typedef $IdentitiesUpdateCompanionBuilder =
    IdentitiesCompanion Function({Value<int> id, Value<String> username});

class $IdentitiesFilterComposer extends Composer<_$CliqDatabase, Identities> {
  $IdentitiesFilterComposer({
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

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );
}

class $IdentitiesOrderingComposer extends Composer<_$CliqDatabase, Identities> {
  $IdentitiesOrderingComposer({
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

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );
}

class $IdentitiesAnnotationComposer
    extends Composer<_$CliqDatabase, Identities> {
  $IdentitiesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);
}

class $IdentitiesTableManager
    extends
        RootTableManager<
          _$CliqDatabase,
          Identities,
          Identity,
          $IdentitiesFilterComposer,
          $IdentitiesOrderingComposer,
          $IdentitiesAnnotationComposer,
          $IdentitiesCreateCompanionBuilder,
          $IdentitiesUpdateCompanionBuilder,
          (Identity, BaseReferences<_$CliqDatabase, Identities, Identity>),
          Identity,
          PrefetchHooks Function()
        > {
  $IdentitiesTableManager(_$CliqDatabase db, Identities table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $IdentitiesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $IdentitiesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $IdentitiesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> username = const Value.absent(),
              }) => IdentitiesCompanion(id: id, username: username),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String username,
              }) => IdentitiesCompanion.insert(id: id, username: username),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $IdentitiesProcessedTableManager =
    ProcessedTableManager<
      _$CliqDatabase,
      Identities,
      Identity,
      $IdentitiesFilterComposer,
      $IdentitiesOrderingComposer,
      $IdentitiesAnnotationComposer,
      $IdentitiesCreateCompanionBuilder,
      $IdentitiesUpdateCompanionBuilder,
      (Identity, BaseReferences<_$CliqDatabase, Identities, Identity>),
      Identity,
      PrefetchHooks Function()
    >;
typedef $CredentialsCreateCompanionBuilder =
    CredentialsCompanion Function({
      Value<int> id,
      required CredentialType type,
      Value<String?> secret,
      Value<String?> passphrase,
      Value<int> priority,
    });
typedef $CredentialsUpdateCompanionBuilder =
    CredentialsCompanion Function({
      Value<int> id,
      Value<CredentialType> type,
      Value<String?> secret,
      Value<String?> passphrase,
      Value<int> priority,
    });

class $CredentialsFilterComposer extends Composer<_$CliqDatabase, Credentials> {
  $CredentialsFilterComposer({
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

  ColumnWithTypeConverterFilters<CredentialType, CredentialType, int>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get secret => $composableBuilder(
    column: $table.secret,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passphrase => $composableBuilder(
    column: $table.passphrase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );
}

class $CredentialsOrderingComposer
    extends Composer<_$CliqDatabase, Credentials> {
  $CredentialsOrderingComposer({
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

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get secret => $composableBuilder(
    column: $table.secret,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passphrase => $composableBuilder(
    column: $table.passphrase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );
}

class $CredentialsAnnotationComposer
    extends Composer<_$CliqDatabase, Credentials> {
  $CredentialsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CredentialType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get secret =>
      $composableBuilder(column: $table.secret, builder: (column) => column);

  GeneratedColumn<String> get passphrase => $composableBuilder(
    column: $table.passphrase,
    builder: (column) => column,
  );

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);
}

class $CredentialsTableManager
    extends
        RootTableManager<
          _$CliqDatabase,
          Credentials,
          Credential,
          $CredentialsFilterComposer,
          $CredentialsOrderingComposer,
          $CredentialsAnnotationComposer,
          $CredentialsCreateCompanionBuilder,
          $CredentialsUpdateCompanionBuilder,
          (Credential, BaseReferences<_$CliqDatabase, Credentials, Credential>),
          Credential,
          PrefetchHooks Function()
        > {
  $CredentialsTableManager(_$CliqDatabase db, Credentials table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $CredentialsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $CredentialsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $CredentialsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<CredentialType> type = const Value.absent(),
                Value<String?> secret = const Value.absent(),
                Value<String?> passphrase = const Value.absent(),
                Value<int> priority = const Value.absent(),
              }) => CredentialsCompanion(
                id: id,
                type: type,
                secret: secret,
                passphrase: passphrase,
                priority: priority,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required CredentialType type,
                Value<String?> secret = const Value.absent(),
                Value<String?> passphrase = const Value.absent(),
                Value<int> priority = const Value.absent(),
              }) => CredentialsCompanion.insert(
                id: id,
                type: type,
                secret: secret,
                passphrase: passphrase,
                priority: priority,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $CredentialsProcessedTableManager =
    ProcessedTableManager<
      _$CliqDatabase,
      Credentials,
      Credential,
      $CredentialsFilterComposer,
      $CredentialsOrderingComposer,
      $CredentialsAnnotationComposer,
      $CredentialsCreateCompanionBuilder,
      $CredentialsUpdateCompanionBuilder,
      (Credential, BaseReferences<_$CliqDatabase, Credentials, Credential>),
      Credential,
      PrefetchHooks Function()
    >;
typedef $IdentityCredentialsCreateCompanionBuilder =
    IdentityCredentialsCompanion Function({
      required int identityId,
      required int credentialId,
      Value<int> rowid,
    });
typedef $IdentityCredentialsUpdateCompanionBuilder =
    IdentityCredentialsCompanion Function({
      Value<int> identityId,
      Value<int> credentialId,
      Value<int> rowid,
    });

class $IdentityCredentialsFilterComposer
    extends Composer<_$CliqDatabase, IdentityCredentials> {
  $IdentityCredentialsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get identityId => $composableBuilder(
    column: $table.identityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get credentialId => $composableBuilder(
    column: $table.credentialId,
    builder: (column) => ColumnFilters(column),
  );
}

class $IdentityCredentialsOrderingComposer
    extends Composer<_$CliqDatabase, IdentityCredentials> {
  $IdentityCredentialsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get identityId => $composableBuilder(
    column: $table.identityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get credentialId => $composableBuilder(
    column: $table.credentialId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $IdentityCredentialsAnnotationComposer
    extends Composer<_$CliqDatabase, IdentityCredentials> {
  $IdentityCredentialsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get identityId => $composableBuilder(
    column: $table.identityId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get credentialId => $composableBuilder(
    column: $table.credentialId,
    builder: (column) => column,
  );
}

class $IdentityCredentialsTableManager
    extends
        RootTableManager<
          _$CliqDatabase,
          IdentityCredentials,
          IdentityCredential,
          $IdentityCredentialsFilterComposer,
          $IdentityCredentialsOrderingComposer,
          $IdentityCredentialsAnnotationComposer,
          $IdentityCredentialsCreateCompanionBuilder,
          $IdentityCredentialsUpdateCompanionBuilder,
          (
            IdentityCredential,
            BaseReferences<
              _$CliqDatabase,
              IdentityCredentials,
              IdentityCredential
            >,
          ),
          IdentityCredential,
          PrefetchHooks Function()
        > {
  $IdentityCredentialsTableManager(_$CliqDatabase db, IdentityCredentials table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $IdentityCredentialsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $IdentityCredentialsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $IdentityCredentialsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> identityId = const Value.absent(),
                Value<int> credentialId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IdentityCredentialsCompanion(
                identityId: identityId,
                credentialId: credentialId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int identityId,
                required int credentialId,
                Value<int> rowid = const Value.absent(),
              }) => IdentityCredentialsCompanion.insert(
                identityId: identityId,
                credentialId: credentialId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $IdentityCredentialsProcessedTableManager =
    ProcessedTableManager<
      _$CliqDatabase,
      IdentityCredentials,
      IdentityCredential,
      $IdentityCredentialsFilterComposer,
      $IdentityCredentialsOrderingComposer,
      $IdentityCredentialsAnnotationComposer,
      $IdentityCredentialsCreateCompanionBuilder,
      $IdentityCredentialsUpdateCompanionBuilder,
      (
        IdentityCredential,
        BaseReferences<_$CliqDatabase, IdentityCredentials, IdentityCredential>,
      ),
      IdentityCredential,
      PrefetchHooks Function()
    >;
typedef $ConnectionsCreateCompanionBuilder =
    ConnectionsCompanion Function({
      Value<int> id,
      required String address,
      Value<int> port,
    });
typedef $ConnectionsUpdateCompanionBuilder =
    ConnectionsCompanion Function({
      Value<int> id,
      Value<String> address,
      Value<int> port,
    });

class $ConnectionsFilterComposer extends Composer<_$CliqDatabase, Connections> {
  $ConnectionsFilterComposer({
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

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get port => $composableBuilder(
    column: $table.port,
    builder: (column) => ColumnFilters(column),
  );
}

class $ConnectionsOrderingComposer
    extends Composer<_$CliqDatabase, Connections> {
  $ConnectionsOrderingComposer({
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

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get port => $composableBuilder(
    column: $table.port,
    builder: (column) => ColumnOrderings(column),
  );
}

class $ConnectionsAnnotationComposer
    extends Composer<_$CliqDatabase, Connections> {
  $ConnectionsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<int> get port =>
      $composableBuilder(column: $table.port, builder: (column) => column);
}

class $ConnectionsTableManager
    extends
        RootTableManager<
          _$CliqDatabase,
          Connections,
          Connection,
          $ConnectionsFilterComposer,
          $ConnectionsOrderingComposer,
          $ConnectionsAnnotationComposer,
          $ConnectionsCreateCompanionBuilder,
          $ConnectionsUpdateCompanionBuilder,
          (Connection, BaseReferences<_$CliqDatabase, Connections, Connection>),
          Connection,
          PrefetchHooks Function()
        > {
  $ConnectionsTableManager(_$CliqDatabase db, Connections table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ConnectionsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ConnectionsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $ConnectionsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<int> port = const Value.absent(),
              }) => ConnectionsCompanion(id: id, address: address, port: port),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String address,
                Value<int> port = const Value.absent(),
              }) => ConnectionsCompanion.insert(
                id: id,
                address: address,
                port: port,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $ConnectionsProcessedTableManager =
    ProcessedTableManager<
      _$CliqDatabase,
      Connections,
      Connection,
      $ConnectionsFilterComposer,
      $ConnectionsOrderingComposer,
      $ConnectionsAnnotationComposer,
      $ConnectionsCreateCompanionBuilder,
      $ConnectionsUpdateCompanionBuilder,
      (Connection, BaseReferences<_$CliqDatabase, Connections, Connection>),
      Connection,
      PrefetchHooks Function()
    >;

class $CliqDatabaseManager {
  final _$CliqDatabase _db;
  $CliqDatabaseManager(this._db);
  $IdentitiesTableManager get identities =>
      $IdentitiesTableManager(_db, _db.identities);
  $CredentialsTableManager get credentials =>
      $CredentialsTableManager(_db, _db.credentials);
  $IdentityCredentialsTableManager get identityCredentials =>
      $IdentityCredentialsTableManager(_db, _db.identityCredentials);
  $ConnectionsTableManager get connections =>
      $ConnectionsTableManager(_db, _db.connections);
}
