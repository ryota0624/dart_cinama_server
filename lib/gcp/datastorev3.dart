import 'package:server/gcp/auth.dart';
import 'package:gcloud/datastore.dart';
import 'package:gcloud/src/datastore_impl.dart' as datastore_impl;

class DataStoreWrapper3 with GCPApiService, HttpClientProvider {
  Future<Datastore> genDataStore() async {
    var client = await getClient();
    return datastore_impl.DatastoreImpl(client, projectId);
  }

  getClient() {
    return apply(datastore_impl.DatastoreImpl.SCOPES);
  }
}