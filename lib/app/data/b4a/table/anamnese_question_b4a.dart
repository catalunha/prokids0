import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../core/models/anamnese_question_model.dart';
import '../../utils/pagination.dart';
import '../utils/b4a_exception.dart';
import '../entity/anamnese_question_entity.dart';
import '../utils/parse_error_translate.dart';

class AnamneseQuestionB4a {
  Future<List<AnamneseQuestionModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) async {
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    } else {
      query.setLimit(1000);
    }
    if (cols.containsKey('${AnamneseQuestionEntity.className}.cols')) {
      query.keysToReturn(cols['${AnamneseQuestionEntity.className}.cols']!);
    }
    if (cols.containsKey('${AnamneseQuestionEntity.className}.pointers')) {
      query
          .includeObject(cols['${AnamneseQuestionEntity.className}.pointers']!);
    }
    ParseResponse? parseResponse;
    try {
      parseResponse = await query.query();
      List<AnamneseQuestionModel> listTemp = <AnamneseQuestionModel>[];
      if (parseResponse.success && parseResponse.results != null) {
        for (var element in parseResponse.results!) {
          listTemp.add(AnamneseQuestionEntity().toModel(element));
        }
        return listTemp;
      } else {
        return [];
      }
    } on Exception {
      var errorTranslated =
          ParseErrorTranslate.translate(parseResponse!.error!);
      throw B4aException(
        errorTranslated,
        where: 'AnamneseQuestionRepositoryB4a.list',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }

  Future<AnamneseQuestionModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) async {
    QueryBuilder<ParseObject> query = QueryBuilder<ParseObject>(
        ParseObject(AnamneseQuestionEntity.className));
    query.whereEqualTo(AnamneseQuestionEntity.id, id);

    if (cols.containsKey('${AnamneseQuestionEntity.className}.cols')) {
      query.keysToReturn(cols['${AnamneseQuestionEntity.className}.cols']!);
    }
    if (cols.containsKey('${AnamneseQuestionEntity.className}.pointers')) {
      query
          .includeObject(cols['${AnamneseQuestionEntity.className}.pointers']!);
    }
    query.first();
    try {
      var response = await query.query();

      if (response.success && response.results != null) {
        return AnamneseQuestionEntity()
            .toModel(response.results!.first, cols: cols);
      }
      return null;
    } catch (e, st) {
      log('$e');
      log('$st');
      rethrow;
    }
  }

  Future<String> save(AnamneseQuestionModel model) async {
    final parseObject = await AnamneseQuestionEntity().toParse(model);
    ParseResponse? parseResponse;
    try {
      parseResponse = await parseObject.save();

      if (parseResponse.success && parseResponse.results != null) {
        ParseObject parseObjectItem =
            parseResponse.results!.first as ParseObject;
        return parseObjectItem.objectId!;
      } else {
        throw Exception();
      }
    } on Exception {
      var errorTranslated =
          ParseErrorTranslate.translate(parseResponse!.error!);
      throw B4aException(
        errorTranslated,
        where: 'AnamneseQuestionRepositoryB4a.update',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }

  Future<bool> delete(String modelId) async {
    final parseObject = ParseObject(AnamneseQuestionEntity.className);
    parseObject.objectId = modelId;
    ParseResponse? parseResponse;

    try {
      parseResponse = await parseObject.delete();
      if (parseResponse.success && parseResponse.results != null) {
        return true;
      } else {
        return false;
      }
    } on Exception {
      var errorTranslated =
          ParseErrorTranslate.translate(parseResponse!.error!);
      throw B4aException(
        errorTranslated,
        where: 'AnamneseQuestionRepositoryB4a.delete',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }
}
