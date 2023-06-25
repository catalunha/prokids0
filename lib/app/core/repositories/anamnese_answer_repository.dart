import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../data/b4a/table/anamnese_answer_b4a.dart';
import '../../data/utils/pagination.dart';
import '../models/anamnese_answer_model.dart';

class AnamneseAnswerRepository {
  final AnamneseAnswerB4a apiB4a = AnamneseAnswerB4a();

  AnamneseAnswerRepository();
  Future<List<AnamneseAnswerModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) =>
      apiB4a.list(query, pagination: pagination, cols: cols);
  Future<AnamneseAnswerModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) =>
      apiB4a.readById(id, cols: cols);
  // Future<AnamneseAnswerModel?> readByName(
  //   String name, {
  //   Map<String, List<String>> cols = const {},
  // }) =>
  //     apiB4a.readByName(name, cols: cols);
  Future<String> save(AnamneseAnswerModel model) => apiB4a.save(model);
  Future<bool> delete(String modelId) => apiB4a.delete(modelId);
}
