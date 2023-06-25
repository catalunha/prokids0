import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../data/b4a/table/anamnese_b4a.dart';
import '../../data/utils/pagination.dart';
import '../models/anamnese_model.dart';

class AnamneseRepository {
  final AnamneseB4a apiB4a = AnamneseB4a();

  AnamneseRepository();
  Future<List<AnamneseModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) =>
      apiB4a.list(query, pagination: pagination, cols: cols);
  Future<AnamneseModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) =>
      apiB4a.readById(id, cols: cols);
  Future<AnamneseModel?> readByName(
    String name, {
    Map<String, List<String>> cols = const {},
  }) =>
      apiB4a.readByName(name, cols: cols);
  Future<String> save(AnamneseModel model) => apiB4a.save(model);
  Future<bool> delete(String modelId) => apiB4a.delete(modelId);
}
