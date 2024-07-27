import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hero_chum/models/marker.dart';

class FirebaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<MarkerModel>> fetchAllMarkers(
      {String docName = "markers"}) async {
    final markersListDoc =
        await _firestore.collection("markers").doc(docName).get();
    if (markersListDoc.exists) {
      final List<dynamic> markersDataList = markersListDoc.data()!["markers"];
      return markersDataList
          .map((markerData) => MarkerModel.fromJson(markerData))
          .toList();
    }
    return [];
  }
}
