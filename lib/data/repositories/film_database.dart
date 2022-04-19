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
      final listFilmFavoriteOld = await getFilmFavorite(uid: uid);
      final listFilmFavoriteNew = [filmData];
      if (listFilmFavoriteOld.isNotEmpty) {
        listFilmFavoriteNew.addAll(listFilmFavoriteOld);
      }

      await firestoreInstance
          ?.collection(AppStrings.collectionFilmFavorite)
          .doc(uid)
          .set(
        {
          AppStrings.fieldFilmFavorite:
              listFilmFavoriteNew.map((e) => e.toJson()).toList(),
        },
        SetOptions(merge: true),
      ).then(
        (value) {
          return true;
        },
      );
    } catch (_) {
      return false;
    }
    return true;
  }
  Future<bool> addListFilmFavorite(
      {required List<FilmData> listFilmFavorite, required String uid}) async {
    try {
      await firestoreInstance
          ?.collection(AppStrings.collectionFilmFavorite)
          .doc(uid)
          .set(
        {
          AppStrings.fieldFilmFavorite:
              listFilmFavorite.map((e) => e.toJson()).toList(),
        },
        SetOptions(merge: true),
      ).then(
        (value) {
          return true;
        },
      );
    } catch (_) {
      return false;
    }
    return true;
  }

  Future<List<FilmData>> getFilmFavorite({required String uid}) async {
    try {
      final result = await firestoreInstance
          ?.collection(AppStrings.collectionFilmFavorite)
          .doc(uid)
          .get();
      final listFilmFavorite = List<FilmData>.from(
        result?.data()![AppStrings.fieldFilmFavorite].map(
              (x) => FilmData.fromJson(x),
            ),
      );
      return listFilmFavorite;
    } catch (_) {
      return [];
    }
  }
}
