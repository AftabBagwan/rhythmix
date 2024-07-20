import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> fetchMusicCollectionData() async {
  DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
      .collection('app_data')
      .doc('music_collection')
      .get();

  return documentSnapshot.data() as Map<String, dynamic>;
}
