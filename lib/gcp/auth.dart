import 'dart:io';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';


class CredentialProvider {
  ServiceAccountCredentials _credentials;
  String projectId;

  static final CredentialProvider instance = CredentialProvider();

  void init(String path, String projectId) {
    if (this.projectId == null) {
      this.projectId = projectId;
    } else {
      throw StateError("CredentialProvider#init call once");
    }

    if (_credentials == null) {
      var fileJson = File(path).readAsStringSync();
      _credentials = ServiceAccountCredentials.fromJson(fileJson);
    } else {
      throw StateError("CredentialProvider#init call once");
    }
  }

  ServiceAccountCredentials get() {
    if (_credentials == null) {
      throw StateError("must call init before get");
    }

    return _credentials;
  }
}

mixin HttpClientProvider {
  Future<Client> apply(List<String> scope) {
    return clientViaServiceAccount(CredentialProvider.instance.get(), scope);
  }

  String projectId = CredentialProvider.instance.projectId;
}

mixin GCPApiService implements HttpClientProvider {
  List<String> scope;
  Future<Client> getClient() => apply(scope);
}
