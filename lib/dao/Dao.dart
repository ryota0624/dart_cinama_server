import 'package:server/gcp/datastorev3.dart';

import 'package:gcloud/db.dart' as db;

abstract class Dao<DtoType extends db.Model> extends DataStoreWrapper3 {

  Future<List<DtoType>> findByNamespace(String namespace) async {
    var datastore = await genDataStore();
    var partition = db.Partition(namespace);
    var result = await db.Query<DtoType>(db.DatastoreDB(datastore), partition: partition).run().toList();
    return List.from(result);
  }
}