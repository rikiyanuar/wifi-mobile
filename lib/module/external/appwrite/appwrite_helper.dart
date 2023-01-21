import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' show DocumentList, Document;

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

  static Future<DocumentList> listDocuments(collectionId,
      {List<String>? queries}) {
    final document = databaseHelper().listDocuments(
      databaseId: AppWriteConstant.databaseId,
      collectionId: collectionId,
      queries: queries,
    );

    return document;
  }

  static Future<Document> updateDocument({
    required String collectionId,
    required String documentId,
    dynamic data,
  }) async {
    final document = databaseHelper().updateDocument(
      databaseId: AppWriteConstant.databaseId,
      documentId: documentId,
      collectionId: collectionId,
      data: data,
    );

    return document;
  }

  static _client() => Client()
      .setEndpoint(AppWriteConstant.host)
      .setProject(AppWriteConstant.projectId)
      .setSelfSigned(status: true);
}
