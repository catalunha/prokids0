import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../data/b4a/table/anamnese_group_b4a.dart';
import '../../data/utils/pagination.dart';
import '../models/anamnese_group_model.dart';

class AnamneseGroupRepository {
  final AnamneseGroupB4a apiB4a = AnamneseGroupB4a();

  AnamneseGroupRepository();
  Future<List<AnamneseGroupModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) =>
      apiB4a.list(query, pagination: pagination, cols: cols);
  Future<AnamneseGroupModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) =>
      apiB4a.readById(id, cols: cols);
  Future<String> save(AnamneseGroupModel model) => apiB4a.save(model);
  Future<String> delete(String modelId) => apiB4a.delete(modelId);
}
