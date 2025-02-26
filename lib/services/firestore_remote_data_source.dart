import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<Map<String, dynamic>> fetchMusicCollectionData() async {
  DocumentSnapshot? documentSnapshot;
  try {
    documentSnapshot = await FirebaseFirestore.instance
        .collection('app_data')
        .doc('music_collection')
        .get();
    debugPrint("Successfully fetched the data from firestore");
  } catch (e) {
    debugPrint("Error getting the data from firestore: $e");
  }

  return documentSnapshot?.data() as Map<String, dynamic>;
}
