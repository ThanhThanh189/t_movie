import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_ticket/common/app_strings.dart';
import 'package:movie_ticket/data/models/account.dart';
import 'package:movie_ticket/data/models/film_data.dart';
import 'package:movie_ticket/data/models/ticket.dart';

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

  Future<bool> deleteFilmFavorite(
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

  //Ticket
  Future<bool> addMyTicket({
    required Ticket ticket,
    required String uid,
  }) async {
    try {
      final listMyTicketOld = await getMyTicket(uid: uid);
      final listMyTicketNew = [ticket];
      if (listMyTicketOld.isNotEmpty) {
        listMyTicketNew.addAll(listMyTicketOld);
      }
      await firestoreInstance
          ?.collection(AppStrings.collectionTicket)
          .doc(uid)
          .set(
        {
          AppStrings.fieldTicket:
              listMyTicketNew.map((e) => e.toJson()).toList(),
        },
        SetOptions(merge: true),
      ).then(
        (value) {
          return true;
        },
      );
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<List<Ticket>> getMyTicket({required String uid}) async {
    try {
      final result = await firestoreInstance
          ?.collection(AppStrings.collectionTicket)
          .doc(uid)
          .get();
      List<Ticket> listMyTicket = List<Ticket>.from(
        result?.data()![AppStrings.fieldTicket].map(
              (x) => Ticket.fromJson(x),
            ),
      );
      return listMyTicket;
    } catch (e) {
      return [];
    }
  }

  Future<bool> deleteMyTicket(
      {required String uid, required List<Ticket> listTicket}) async {
    try {
      await firestoreInstance
          ?.collection(AppStrings.collectionTicket)
          .doc(uid)
          .set(
        {
          AppStrings.fieldTicket: listTicket.map((e) => e.toJson()).toList(),
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

  Future<List<Ticket>> getAllTicket() async {
    try {
      final querySnapshow = await firestoreInstance
          ?.collection(AppStrings.collectionTicket)
          .get();
      final allData = querySnapshow?.docs
          .map(
            (data) => List<Ticket>.from(
              data[AppStrings.fieldTicket].map(
                (x) => Ticket.fromJson(x),
              ),
            ),
          )
          .toList();
      List<Ticket> listTicketBooked = [];
      if (allData != null) {
        for (var item in allData) {
          listTicketBooked.addAll(item);
        }
      }
      return listTicketBooked;
    } catch (_) {
      return [];
    }
  }

  //Account
  Future<bool> addAndUpdateAccount({
    required String uid,
    required Account account,
  }) async {
    try {
      await firestoreInstance
          ?.collection(AppStrings.collectionAccount)
          .doc(uid)
          .set(
        {
          AppStrings.fieldAccount: account.toJson(),
        },
        SetOptions(merge: true),
      ).then(
        (value) {
          return true;
        },
      );
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<Account?> getAccount({
    required String uid,
  }) async {
    try {
      final result = await firestoreInstance
          ?.collection(AppStrings.collectionAccount)
          .doc(uid)
          .get();
      final account =
          Account.fromJson(result?.data()![AppStrings.fieldAccount]);
      return account;
    } catch (_) {
      return null;
    }
  }
}
