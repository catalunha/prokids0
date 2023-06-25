import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../data/b4a/table/anamnese_question_b4a.dart';
import '../../data/utils/pagination.dart';
import '../models/anamnese_question_model.dart';

class AnamneseQuestionRepository {
  final AnamneseQuestionB4a apiB4a = AnamneseQuestionB4a();

  AnamneseQuestionRepository();
  Future<List<AnamneseQuestionModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) =>
      apiB4a.list(query, pagination: pagination, cols: cols);
  Future<AnamneseQuestionModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) =>
      apiB4a.readById(id, cols: cols);
  Future<String> save(AnamneseQuestionModel model) => apiB4a.save(model);
  Future<bool> delete(String modelId) => apiB4a.delete(modelId);
}
