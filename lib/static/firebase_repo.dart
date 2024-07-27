import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hero_chum/models/marker.dart';

class FirebaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<MarkerModel>> fetchAllMarkers(
      {String docName = "markers"}) async {
    print("Fetching record");
    final markersListDoc =
        await _firestore.collection("markers").doc(docName).get();
    print("Fetched record");
    if (markersListDoc.exists) {
      print("Fetched record that exists");
      final List<dynamic> markersDataList = markersListDoc.data()!["markers"];
      print(markersDataList[0]);
      print(MarkerModel.fromJson(markersDataList[0]));
      return markersDataList
          .map((markerData) => MarkerModel.fromJson(markerData))
          .toList();
    }
    return [];
  }
}
