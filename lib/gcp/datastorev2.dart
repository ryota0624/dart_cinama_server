
import 'package:server/gcp/auth.dart';
import 'package:gcloud/datastore.dart';
import 'package:gcloud/src/datastore_impl.dart' as datastore_impl;
import 'package:gcloud/common.dart';

class DataStoreWrapper2 with GCPApiService, HttpClientProvider {
  Future<Datastore> genDataStore() async {
    var client = await getClient();
    return datastore_impl.DatastoreImpl(client, projectId);
  }

  Future<Page<Entity>> runQuery(String kind, [String namespaceId]) async {
      var dataStore = await genDataStore();
      var query = Query(kind: kind);
      var partition = Partition(namespaceId);
      return dataStore.query(query, partition: partition);
  }

  getClient() {
    return apply(datastore_impl.DatastoreImpl.SCOPES);
  }
}