import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' show DocumentList, Document;

import '../../external/constant/appwrite_constant.dart';

abstract class AppWriteHelper {
  Account accountHelper();
  Databases databaseHelper();
  Storage storageHelper();
  Future<DocumentList> listDocuments(
    collectionId, {
    List<String>? queries,
  });
  Future<Document> updateDocument({
    required String collectionId,
    required String documentId,
    dynamic data,
  });
}

class AppWriteHelperImpl extends AppWriteHelper {
  @override
  Account accountHelper() {
    final account = Account(_client());

    return account;
  }

  @override
  Databases databaseHelper() {
    final database = Databases(_client());

    return database;
  }

  @override
  Storage storageHelper() {
    final storage = Storage(_client());

    return storage;
  }

  @override
  Future<DocumentList> listDocuments(collectionId, {List<String>? queries}) {
    final document = databaseHelper().listDocuments(
      databaseId: AppWriteConstant.databaseId,
      collectionId: collectionId,
      queries: queries,
    );

    return document;
  }

  @override
  Future<Document> updateDocument({
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
