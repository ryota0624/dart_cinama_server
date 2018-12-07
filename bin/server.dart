import 'dart:io';
import 'dart:convert';

import 'package:args/args.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:server/gcp/auth.dart';
import 'package:server/dao/CinemaScheduleDao.dart';

main(List<String> args) async {
  CredentialProvider.instance.init("credential.json", "handson-1061");

  var parser = ArgParser()..addOption('port', abbr: 'p', defaultsTo: '8080');

  var result = parser.parse(args);

  var port = int.tryParse(result['port']);

  if (port == null) {
    stdout.writeln(
        'Could not parse port value "${result['port']}" into a number.');
    // 64: command line usage error
    exitCode = 64;
    return;
  }

  var handler = const shelf.Pipeline()
      .addMiddleware(shelf.logRequests())
      .addHandler(_echoRequest);

  var server = await io.serve(handler, 'localhost', port);
  print('Serving at http://${server.address.host}:${server.port}');
}
Future<shelf.Response> _echoRequest(shelf.Request request) async {
  var result = await CinemaScheduleDao().findByDate(DateTime(2018, 2, 8));
  return shelf.Response.ok(JsonEncoder().convert(result.map((m) => m.movieName).toList()), headers: {"content-type": "application/json"});
}
//Future<shelf.Response> _echoRequest(shelf.Request request) async {
//  var result = await DataStoreWrapper().runQuery("TohoCinemaSchedule", "2018-11-30");
//  return shelf.Response.ok(JsonEncoder().convert(result), headers: {"content-type": "application/json"});
//}