import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../core/models/anamnese_group_model.dart';
import '../../utils/pagination.dart';
import '../utils/b4a_exception.dart';
import '../entity/anamnese_group_entity.dart';
import '../utils/parse_error_translate.dart';

class AnamneseGroupB4a {
  Future<List<AnamneseGroupModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) async {
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    }
    if (cols.containsKey('${AnamneseGroupEntity.className}.cols')) {
      query.keysToReturn(cols['${AnamneseGroupEntity.className}.cols']!);
    }
    if (cols.containsKey('${AnamneseGroupEntity.className}.pointers')) {
      query.includeObject(cols['${AnamneseGroupEntity.className}.pointers']!);
    }
    ParseResponse? parseResponse;
    try {
      parseResponse = await query.query();
      final List<AnamneseGroupModel> listTemp = <AnamneseGroupModel>[];
      if (parseResponse.success && parseResponse.results != null) {
        for (var element in parseResponse.results!) {
          listTemp.add(AnamneseGroupEntity().toModel(element));
        }
        return listTemp;
      } else {
        return [];
      }
    } on Exception {
      final errorTranslated =
          ParseErrorTranslate.translate(parseResponse!.error!);
      throw B4aException(
        errorTranslated,
        where: 'AnamneseGroupRepositoryB4a.list',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }

  Future<AnamneseGroupModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) async {
    final QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(AnamneseGroupEntity.className));
    query.whereEqualTo(AnamneseGroupEntity.id, id);

    if (cols.containsKey('${AnamneseGroupEntity.className}.cols')) {
      query.keysToReturn(cols['${AnamneseGroupEntity.className}.cols']!);
    }
    if (cols.containsKey('${AnamneseGroupEntity.className}.pointers')) {
      query.includeObject(cols['${AnamneseGroupEntity.className}.pointers']!);
    }

    query.first();
    try {
      final response = await query.query();

      if (response.success && response.results != null) {
        return AnamneseGroupEntity()
            .toModel(response.results!.first, cols: cols);
      }
      return null;
    } catch (e, st) {
      log('$e');
      log('$st');
      rethrow;
    }
  }

  Future<String> save(AnamneseGroupModel model) async {
    final parseObject = await AnamneseGroupEntity().toParse(model);
    ParseResponse? parseResponse;
    try {
      parseResponse = await parseObject.save();

      if (parseResponse.success && parseResponse.results != null) {
        final ParseObject parseObjectItem =
            parseResponse.results!.first as ParseObject;
        return parseObjectItem.objectId!;
      } else {
        throw Exception();
      }
    } on Exception {
      final errorTranslated =
          ParseErrorTranslate.translate(parseResponse!.error!);
      throw B4aException(
        errorTranslated,
        where: 'AnamneseGroupRepositoryB4a.update',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }

  Future<String> delete(String modelId) async {
    final parseObject = ParseObject(AnamneseGroupEntity.className);
    parseObject.objectId = modelId;
    ParseResponse? parseResponse;

    try {
      parseResponse = await parseObject.delete();
      if (parseResponse.success && parseResponse.results != null) {
        final ParseObject parseObjectItem =
            parseResponse.results!.first as ParseObject;
        return parseObjectItem.objectId!;
      } else {
        throw Exception();
      }
    } on Exception {
      final errorTranslated =
          ParseErrorTranslate.translate(parseResponse!.error!);
      throw B4aException(
        errorTranslated,
        where: 'AnamneseGroupRepositoryB4a.delete',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }
}
