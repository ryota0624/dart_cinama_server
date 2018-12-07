import 'package:server/dao/Dao.dart';

import 'package:gcloud/db.dart' as db;

class CinemaScheduleDao extends Dao<TohoCinemaSchedule> {
  CinemaScheduleDao._internal() {
  }

  static final CinemaScheduleDao _singleton = CinemaScheduleDao._internal();

  factory CinemaScheduleDao() {
    return _singleton;
  }

  String _digitalInt(int n) {
    if (n < 10) {
      return "0$n";
    }
    return "$n";
  }

  Future<List<TohoCinemaSchedule>> findByDate(DateTime date) async {
    var namespace = "${date.year}-${_digitalInt(date.month)}-${_digitalInt(date.day)}";
    return findByNamespace(namespace);
  }
}

@db.Kind()
class TohoCinemaSchedule extends db.Model {
  @db.StringProperty()
  String movieName;

  @db.IntProperty()
  num showTime;

  @db.StringProperty()
  String startTime;

  @db.StringProperty()
  String endTime;

}