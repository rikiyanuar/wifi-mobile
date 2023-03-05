import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' show DocumentList, Document;
import 'package:flutter_core/core.dart';
import 'package:wifiapp/module/external/external.dart';

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
  Future<Document> getDocuments(String collectionId, String documentId);
  Future<Document> addDocuments(String collectionId,
      {required Map<String, dynamic> data});
  Future removeDocuments(String collectionId, String documentId);
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
      databaseId: FlavorBaseUrlConfig.instance!.appEnvironment.databaseId,
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
      databaseId: FlavorBaseUrlConfig.instance!.appEnvironment.databaseId,
      documentId: documentId,
      collectionId: collectionId,
      data: data,
    );

    return document;
  }

  @override
  Future<Document> getDocuments(collectionId, documentId) {
    final document = databaseHelper().getDocument(
      databaseId: FlavorBaseUrlConfig.instance!.appEnvironment.databaseId,
      collectionId: collectionId,
      documentId: documentId,
    );

    return document;
  }

  @override
  Future<Document> addDocuments(
    String collectionId, {
    required Map<String, dynamic> data,
  }) {
    final document = databaseHelper().createDocument(
      databaseId: FlavorBaseUrlConfig.instance!.appEnvironment.databaseId,
      collectionId: collectionId,
      documentId: ID.unique(),
      data: data,
    );

    return document;
  }

  @override
  Future removeDocuments(String collectionId, String documentId) {
    final document = databaseHelper().deleteDocument(
      databaseId: FlavorBaseUrlConfig.instance!.appEnvironment.databaseId,
      collectionId: collectionId,
      documentId: documentId,
    );

    return document;
  }

  static _client() => Client()
      .setEndpoint(FlavorBaseUrlConfig.instance!.appEnvironment.host)
      .setProject(FlavorBaseUrlConfig.instance!.appEnvironment.projectId)
      .setSelfSigned(status: true);
}
