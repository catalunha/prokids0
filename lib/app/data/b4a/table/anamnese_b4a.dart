import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../core/models/anamnese_model.dart';
import '../../utils/pagination.dart';
import '../utils/b4a_exception.dart';
import '../entity/anamnese_entity.dart';
import '../utils/parse_error_translate.dart';

class AnamneseB4a {
  Future<List<AnamneseModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) async {
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    }
    if (cols.containsKey('${AnamneseEntity.className}.cols')) {
      query.keysToReturn(cols['${AnamneseEntity.className}.cols']!);
    }
    if (cols.containsKey('${AnamneseEntity.className}.pointers')) {
      query.includeObject(cols['${AnamneseEntity.className}.pointers']!);
    }
    ParseResponse? parseResponse;
    try {
      parseResponse = await query.query();
      List<AnamneseModel> listTemp = <AnamneseModel>[];
      if (parseResponse.success && parseResponse.results != null) {
        for (var element in parseResponse.results!) {
          listTemp.add(AnamneseEntity().toModel(element));
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
        where: 'AnamneseRepositoryB4a.list',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }

  Future<AnamneseModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(AnamneseEntity.className));
    query.whereEqualTo(AnamneseEntity.id, id);

    if (cols.containsKey('${AnamneseEntity.className}.cols')) {
      query.keysToReturn(cols['${AnamneseEntity.className}.cols']!);
    }
    if (cols.containsKey('${AnamneseEntity.className}.pointers')) {
      query.includeObject(cols['${AnamneseEntity.className}.pointers']!);
    }

    query.first();
    try {
      var response = await query.query();

      if (response.success && response.results != null) {
        return AnamneseEntity().toModel(response.results!.first, cols: cols);
      }
      return null;
    } catch (e, st) {
      log('$e');
      log('$st');
      rethrow;
    }
  }

  Future<AnamneseModel?> readByName(
    String name, {
    Map<String, List<String>> cols = const {},
  }) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(AnamneseEntity.className));
    query.whereEqualTo(AnamneseEntity.name, name);

    if (cols.containsKey('${AnamneseEntity.className}.cols')) {
      query.keysToReturn(cols['${AnamneseEntity.className}.cols']!);
    }
    if (cols.containsKey('${AnamneseEntity.className}.pointers')) {
      query.includeObject(cols['${AnamneseEntity.className}.pointers']!);
    }

    query.first();
    try {
      var response = await query.query();

      if (response.success && response.results != null) {
        return AnamneseEntity().toModel(response.results!.first, cols: cols);
      }
      return null;
    } catch (e, st) {
      log('$e');
      log('$st');
      rethrow;
    }
  }

  Future<String> save(AnamneseModel model) async {
    final parseObject = await AnamneseEntity().toParse(model);
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
        where: 'AnamneseRepositoryB4a.update',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }

  Future<bool> delete(String modelId) async {
    final parseObject = ParseObject(AnamneseEntity.className);
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
        where: 'AnamneseRepositoryB4a.delete',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }
}
