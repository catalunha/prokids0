import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../data/b4a/table/anamnese_people_b4a.dart';
import '../../data/utils/pagination.dart';
import '../models/anamnese_people_model.dart';

class AnamnesePeopleRepository {
  final AnamnesePeopleB4a apiB4a = AnamnesePeopleB4a();

  AnamnesePeopleRepository();
  Future<List<AnamnesePeopleModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) =>
      apiB4a.list(query, pagination: pagination, cols: cols);
  Future<AnamnesePeopleModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) =>
      apiB4a.readById(id, cols: cols);

  Future<String> save(AnamnesePeopleModel model) => apiB4a.save(model);
  Future<bool> delete(String modelId) => apiB4a.delete(modelId);
}
