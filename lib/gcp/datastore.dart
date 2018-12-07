import 'package:googleapis/datastore/v1.dart';
import 'package:server/gcp/auth.dart';

class DataStoreWrapper with GCPApiService, HttpClientProvider {
  Future<DatastoreApi> _dataStoreApi() async {
    var client = await getClient();
    return DatastoreApi(client);
  }

  Future<Map<String, Object>> runQuery(String kind, [String namespaceId]) async {
    var dataStoreApi = await _dataStoreApi();
    var query = RunQueryRequest();
    query.query = Query.fromJson({
      "kind": [{"name": kind}]
    });

    if (namespaceId != null) {
      query.partitionId = PartitionId.fromJson({
        "namespaceId": namespaceId,
        "projectId": projectId
      });
    }
    var result = await dataStoreApi.projects.runQuery(query, projectId);
    return result.toJson();
  }

  getClient() {
    return apply([DatastoreApi.DatastoreScope]);
  }
}
