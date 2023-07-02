import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../core/models/anamnese_people_model.dart';
import '../../utils/pagination.dart';
import '../utils/b4a_exception.dart';
import '../entity/anamnese_people_entity.dart';
import '../utils/parse_error_translate.dart';

class AnamnesePeopleB4a {
  Future<List<AnamnesePeopleModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) async {
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    }
    if (cols.containsKey('${AnamnesePeopleEntity.className}.cols')) {
      query.keysToReturn(cols['${AnamnesePeopleEntity.className}.cols']!);
    }
    if (cols.containsKey('${AnamnesePeopleEntity.className}.pointers')) {
      query.includeObject(cols['${AnamnesePeopleEntity.className}.pointers']!);
    }
    ParseResponse? parseResponse;
    try {
      parseResponse = await query.query();
      final List<AnamnesePeopleModel> listTemp = <AnamnesePeopleModel>[];
      if (parseResponse.success && parseResponse.results != null) {
        for (var element in parseResponse.results!) {
          listTemp.add(AnamnesePeopleEntity().toModel(element));
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
        where: 'AnamneseRepositoryB4a.list',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }

  Future<AnamnesePeopleModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) async {
    final QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(AnamnesePeopleEntity.className));
    query.whereEqualTo(AnamnesePeopleEntity.id, id);

    if (cols.containsKey('${AnamnesePeopleEntity.className}.cols')) {
      query.keysToReturn(cols['${AnamnesePeopleEntity.className}.cols']!);
    }
    if (cols.containsKey('${AnamnesePeopleEntity.className}.pointers')) {
      query.includeObject(cols['${AnamnesePeopleEntity.className}.pointers']!);
    }

    query.first();
    try {
      final response = await query.query();

      if (response.success && response.results != null) {
        return AnamnesePeopleEntity()
            .toModel(response.results!.first, cols: cols);
      }
      return null;
    } catch (e, st) {
      log('$e');
      log('$st');
      rethrow;
    }
  }

  // Future<AnamnesePeopleModel?> readByName(
  //   String name, {
  //   Map<String, List<String>> cols = const {},
  // }) async {
  //   QueryBuilder<ParseObject> query = QueryBuilder<ParseObject>(
  //       ParseObject(AnamnesePeopleEntity.className));
  //   query.whereEqualTo(AnamnesePeopleEntity.name, name);

  //   if (cols.containsKey('${AnamnesePeopleEntity.className}.cols')) {
  //     query.keysToReturn(cols['${AnamnesePeopleEntity.className}.cols']!);
  //   }
  //   if (cols.containsKey('${AnamnesePeopleEntity.className}.pointers')) {
  //     query.includeObject(
  //         cols['${AnamnesePeopleEntity.className}.pointers']!);
  //   }

  //   query.first();
  //   try {
  //     var response = await query.query();

  //     if (response.success && response.results != null) {
  //       return AnamnesePeopleEntity()
  //           .toModel(response.results!.first, cols: cols);
  //     }
  //     return null;
  //   } catch (e, st) {
  //     log('$e');
  //     log('$st');
  //     rethrow;
  //   }
  // }

  Future<String> save(AnamnesePeopleModel model) async {
    final parseObject = await AnamnesePeopleEntity().toParse(model);
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
        where: 'AnamneseRepositoryB4a.update',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }

  Future<bool> delete(String modelId) async {
    final parseObject = ParseObject(AnamnesePeopleEntity.className);
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
      final errorTranslated =
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
