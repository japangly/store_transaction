import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Database {
  Stream<QuerySnapshot> getStreamCollection({
    @required String collection,
    @required String orderBy,
    @required bool isDescending,
  }) {
    return Firestore.instance
        .collection(collection)
        .orderBy(
          orderBy,
          descending: isDescending,
        )
        .snapshots();
  }

  Future<DocumentSnapshot> getCurrentUserInfo({@required String userId}) async {
    try {
      QuerySnapshot querySnapshot = await Firestore.instance
          .collection('employees')
          .where('uid', isEqualTo: userId)
          .limit(1)
          .getDocuments();
      print(querySnapshot.documents.first);
      return querySnapshot.documents.first;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<List<DocumentSnapshot>> getAllCollection({
    @required String collection,
    @required String sortBy,
    @required bool order,
  }) async {
    try {
      QuerySnapshot snapshot = await Firestore.instance
          .collection(collection)
          .orderBy(sortBy, descending: order)
          .getDocuments();
      return snapshot.documents;
    } catch (error) {
      return null;
    }
  }

  Future createCollection(
      {@required String collection,
      @required Map<String, dynamic> data}) async {
    try {
      await Firestore.instance.collection(collection).add(data);
      return true;
    } catch (error) {
      return error.toString();
    }
  }

  Future updateCollection({
    @required String collection,
    @required String documentId,
    @required Map<String, dynamic> data,
  }) async {
    try {
      await Firestore.instance
          .collection(collection)
          .document(documentId)
          .updateData(data);
    } catch (error) {
      print(error.toString());
    }
  }

  Future deleteCollection({
    @required String collection,
    @required String documentId,
  }) async {
    try {
      await Firestore.instance
          .collection(collection)
          .document(documentId)
          .delete();
    } catch (error) {
      print(error);
    }
  }

  Future<DocumentSnapshot> getCollectionByDocumentId({
    @required String collection,
    @required String documentId,
  }) async {
    try {
      DocumentSnapshot documentSnapshot = await Firestore.instance
          .collection(collection)
          .document(documentId)
          .get();
      return documentSnapshot;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<DocumentSnapshot> getCollectionByField({
    @required String collection,
    @required String field,
    @required String value,
  }) async {
    try {
      QuerySnapshot snapshot = await Firestore.instance
          .collection(collection)
          .where(field, isEqualTo: value)
          .limit(1)
          .getDocuments();
      return snapshot.documents.first;
    } catch (e) {
      return null;
    }
  }

  Future<List<DocumentSnapshot>> getHistoryProduction(
      {@required String collection,
      @required String field,
      @required Timestamp dateTime,
      @required Timestamp endDate}) async {
    try {
      QuerySnapshot snapshot = await Firestore.instance
          .collection(collection)
          .where(field, isGreaterThan: dateTime)
          .where(field, isLessThan: endDate)
          .getDocuments();
      return snapshot.documents;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
