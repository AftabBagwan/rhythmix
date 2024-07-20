import 'package:cloud_firestore/cloud_firestore.dart';

fetchTopAlbums() async {
  List topAlbums = [];
  await FirebaseFirestore.instance
      .collection('app_data')
      .doc("music_collection")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    topAlbums = data["top_albums"];
  });
  return topAlbums;
}

fetchArtists() async {
  Map<String, dynamic> topArtists = {};
  await FirebaseFirestore.instance
      .collection('app_data')
      .doc("music_collection")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    topArtists = data["artists"];
  });
  return topArtists;
}