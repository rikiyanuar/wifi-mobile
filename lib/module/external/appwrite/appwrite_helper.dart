import 'package:appwrite/appwrite.dart';

import '../constant/appwrite_constant.dart';

class AppWriteHelper {
  static Account accountHelper() {
    final account = Account(_client());

    return account;
  }

  static Databases databaseHelper() {
    final database = Databases(_client());

    return database;
  }

  static Storage storageHelper() {
    final storage = Storage(_client());

    return storage;
  }

  static documentHelper(collectionId, {List<String>? queries}) {
    final document = databaseHelper().listDocuments(
      databaseId: AppWriteConstant.databaseId,
      collectionId: collectionId,
      queries: queries,
    );

    return document;
  }

  static _client() => Client()
      .setEndpoint(AppWriteConstant.host)
      .setProject(AppWriteConstant.projectId)
      .setSelfSigned(status: true);
}
