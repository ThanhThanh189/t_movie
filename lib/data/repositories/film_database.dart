import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_ticket/common/app_strings.dart';
import 'package:movie_ticket/data/models/film_data.dart';

class FilmDatabase {
  FirebaseFirestore? firestoreInstance;
  FilmDatabase() {
    firestoreInstance = FirebaseFirestore.instance;
  }

  Future<bool> addFilmFavorite(
      {required FilmData filmData, required String uid}) async {
    try {
      await firestoreInstance
          ?.collection(AppStrings.collectionFilmFavorite)
          .doc(uid)
          .set(
            filmData.toJson(),
            SetOptions(merge: true),
          );
    } catch (_) {
      return false;
    }
    return true;
  }

  Future<void> addFilm() async {
    try {
      firestoreInstance = FirebaseFirestore.instance;
      await firestoreInstance
          ?.collection("user2")
          .doc('1NZxBPI665YzPRMesMIgqy9hona2')
          .set(
        {
          "name": "john",
          "age": 50,
          "email": "example@example.com",
          "address": {"street": "street 24", "city": "new york"}
        },
      ).then((value) {
        print('success');
      });
    } catch (_) {}
  }
}
