// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuestionCollection on Isar {
  IsarCollection<Question> get questions => this.collection();
}

const QuestionSchema = CollectionSchema(
  name: r'Question',
  id: -6819722535046815095,
  properties: {
    r'soruId': PropertySchema(
      id: 0,
      name: r'soruId',
      type: IsarType.long,
    ),
    r'soruMetni': PropertySchema(
      id: 1,
      name: r'soruMetni',
      type: IsarType.string,
    )
  },
  estimateSize: _questionEstimateSize,
  serialize: _questionSerialize,
  deserialize: _questionDeserialize,
  deserializeProp: _questionDeserializeProp,
  idName: r'id',
  indexes: {
    r'soruId': IndexSchema(
      id: 2808370292994747331,
      name: r'soruId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'soruId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _questionGetId,
  getLinks: _questionGetLinks,
  attach: _questionAttach,
  version: '3.1.0+1',
);

int _questionEstimateSize(
  Question object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.soruMetni.length * 3;
  return bytesCount;
}

void _questionSerialize(
  Question object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.soruId);
  writer.writeString(offsets[1], object.soruMetni);
}

Question _questionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Question(
    id: id,
    soruId: reader.readLong(offsets[0]),
    soruMetni: reader.readString(offsets[1]),
  );
  return object;
}

P _questionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _questionGetId(Question object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _questionGetLinks(Question object) {
  return [];
}

void _questionAttach(IsarCollection<dynamic> col, Id id, Question object) {
  object.id = id;
}

extension QuestionQueryWhereSort on QueryBuilder<Question, Question, QWhere> {
  QueryBuilder<Question, Question, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Question, Question, QAfterWhere> anySoruId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'soruId'),
      );
    });
  }
}

extension QuestionQueryWhere on QueryBuilder<Question, Question, QWhereClause> {
  QueryBuilder<Question, Question, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Question, Question, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Question, Question, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Question, Question, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterWhereClause> soruIdEqualTo(
      int soruId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'soruId',
        value: [soruId],
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterWhereClause> soruIdNotEqualTo(
      int soruId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'soruId',
              lower: [],
              upper: [soruId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'soruId',
              lower: [soruId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'soruId',
              lower: [soruId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'soruId',
              lower: [],
              upper: [soruId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Question, Question, QAfterWhereClause> soruIdGreaterThan(
    int soruId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'soruId',
        lower: [soruId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterWhereClause> soruIdLessThan(
    int soruId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'soruId',
        lower: [],
        upper: [soruId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterWhereClause> soruIdBetween(
    int lowerSoruId,
    int upperSoruId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'soruId',
        lower: [lowerSoruId],
        includeLower: includeLower,
        upper: [upperSoruId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QuestionQueryFilter
    on QueryBuilder<Question, Question, QFilterCondition> {
  QueryBuilder<Question, Question, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> soruIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soruId',
        value: value,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> soruIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'soruId',
        value: value,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> soruIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'soruId',
        value: value,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> soruIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'soruId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> soruMetniEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soruMetni',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> soruMetniGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'soruMetni',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> soruMetniLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'soruMetni',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> soruMetniBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'soruMetni',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> soruMetniStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'soruMetni',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> soruMetniEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'soruMetni',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> soruMetniContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'soruMetni',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> soruMetniMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'soruMetni',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> soruMetniIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soruMetni',
        value: '',
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition>
      soruMetniIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'soruMetni',
        value: '',
      ));
    });
  }
}

extension QuestionQueryObject
    on QueryBuilder<Question, Question, QFilterCondition> {}

extension QuestionQueryLinks
    on QueryBuilder<Question, Question, QFilterCondition> {}

extension QuestionQuerySortBy on QueryBuilder<Question, Question, QSortBy> {
  QueryBuilder<Question, Question, QAfterSortBy> sortBySoruId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soruId', Sort.asc);
    });
  }

  QueryBuilder<Question, Question, QAfterSortBy> sortBySoruIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soruId', Sort.desc);
    });
  }

  QueryBuilder<Question, Question, QAfterSortBy> sortBySoruMetni() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soruMetni', Sort.asc);
    });
  }

  QueryBuilder<Question, Question, QAfterSortBy> sortBySoruMetniDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soruMetni', Sort.desc);
    });
  }
}

extension QuestionQuerySortThenBy
    on QueryBuilder<Question, Question, QSortThenBy> {
  QueryBuilder<Question, Question, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Question, Question, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Question, Question, QAfterSortBy> thenBySoruId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soruId', Sort.asc);
    });
  }

  QueryBuilder<Question, Question, QAfterSortBy> thenBySoruIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soruId', Sort.desc);
    });
  }

  QueryBuilder<Question, Question, QAfterSortBy> thenBySoruMetni() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soruMetni', Sort.asc);
    });
  }

  QueryBuilder<Question, Question, QAfterSortBy> thenBySoruMetniDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soruMetni', Sort.desc);
    });
  }
}

extension QuestionQueryWhereDistinct
    on QueryBuilder<Question, Question, QDistinct> {
  QueryBuilder<Question, Question, QDistinct> distinctBySoruId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'soruId');
    });
  }

  QueryBuilder<Question, Question, QDistinct> distinctBySoruMetni(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'soruMetni', caseSensitive: caseSensitive);
    });
  }
}

extension QuestionQueryProperty
    on QueryBuilder<Question, Question, QQueryProperty> {
  QueryBuilder<Question, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Question, int, QQueryOperations> soruIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'soruId');
    });
  }

  QueryBuilder<Question, String, QQueryOperations> soruMetniProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'soruMetni');
    });
  }
}
