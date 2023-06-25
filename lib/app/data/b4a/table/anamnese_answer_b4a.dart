import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../core/models/anamnese_answer_model.dart';
import '../../utils/pagination.dart';
import '../entity/anamnese_answer_entity.dart';
import '../utils/b4a_exception.dart';
import '../utils/parse_error_translate.dart';

class AnamneseAnswerB4a {
  Future<List<AnamneseAnswerModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) async {
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    }
    if (cols.containsKey('${AnamneseAnswerEntity.className}.cols')) {
      query.keysToReturn(cols['${AnamneseAnswerEntity.className}.cols']!);
    }
    if (cols.containsKey('${AnamneseAnswerEntity.className}.pointers')) {
      query.includeObject(cols['${AnamneseAnswerEntity.className}.pointers']!);
    }
    ParseResponse? parseResponse;
    try {
      parseResponse = await query.query();
      List<AnamneseAnswerModel> listTemp = <AnamneseAnswerModel>[];
      if (parseResponse.success && parseResponse.results != null) {
        for (var element in parseResponse.results!) {
          listTemp.add(AnamneseAnswerEntity().toModel(element));
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
        where: 'AnamneseAnswerRepositoryB4a.list',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }

  Future<AnamneseAnswerModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(AnamneseAnswerEntity.className));
    query.whereEqualTo(AnamneseAnswerEntity.id, id);

    if (cols.containsKey('${AnamneseAnswerEntity.className}.cols')) {
      query.keysToReturn(cols['${AnamneseAnswerEntity.className}.cols']!);
    }
    if (cols.containsKey('${AnamneseAnswerEntity.className}.pointers')) {
      query.includeObject(cols['${AnamneseAnswerEntity.className}.pointers']!);
    }

    query.first();
    try {
      var response = await query.query();

      if (response.success && response.results != null) {
        return AnamneseAnswerEntity()
            .toModel(response.results!.first, cols: cols);
      }
      return null;
    } catch (e, st) {
      log('$e');
      log('$st');
      rethrow;
    }
  }

  // Future<AnamneseAnswerModel?> readByName(
  //   String name, {
  //   Map<String, List<String>> cols = const {},
  // }) async {
  //   QueryBuilder<ParseObject> query =
  //       QueryBuilder<ParseObject>(ParseObject(AnamneseAnswerEntity.className));
  //   query.whereEqualTo(AnamneseAnswerEntity.name, name);

  //   if (cols.containsKey('${AnamneseAnswerEntity.className}.cols')) {
  //     query.keysToReturn(cols['${AnamneseAnswerEntity.className}.cols']!);
  //   }
  //   if (cols.containsKey('${AnamneseAnswerEntity.className}.pointers')) {
  //     query.includeObject(cols['${AnamneseAnswerEntity.className}.pointers']!);
  //   }

  //   query.first();
  //   try {
  //     var response = await query.query();

  //     if (response.success && response.results != null) {
  //       return AnamneseAnswerEntity()
  //           .toModel(response.results!.first, cols: cols);
  //     }
  //     return null;
  //   } catch (e, st) {
  //     log('$e');
  //     log('$st');
  //     rethrow;
  //   }
  // }

  Future<String> save(AnamneseAnswerModel model) async {
    final parseObject = await AnamneseAnswerEntity().toParse(model);
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
        where: 'AnamneseAnswerRepositoryB4a.update',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }

  Future<bool> delete(String modelId) async {
    final parseObject = ParseObject(AnamneseAnswerEntity.className);
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
        where: 'AnamneseAnswerRepositoryB4a.delete',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }
}
