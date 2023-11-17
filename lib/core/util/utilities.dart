
import 'package:bookpal/core/constants/constants.dart';
import 'package:bookpal/core/injection_container.dart';
import 'package:bookpal/domain/entities/physical_book.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Utilities {

  static String capitalize(String s) {
    return s[0].toUpperCase() + s.substring(1);
  }

  static String getIdentifierName(dynamic identifier) {
    if (identifier is String) {
      return 'email';
    }
    return 'id';
  }

  static String getBookIdentifierName(dynamic identifier) {
    if (identifier is String) {
      return 'barcode';
    }
    return 'id';
  }

  static String? toISO8601String(DateTime? dateTime) {
    if (dateTime == null) return null;
    return "${dateTime.toIso8601String()}Z";
  }

  static DateTime fromISO8601String(String dateTime) {
    return DateTime.parse(dateTime);
  }

  static DateTime? fromISO8601StringNullable(String? dateTime) {
    if (dateTime == null) return null;
    return DateTime.parse(dateTime);
  }

  static Future<String> getAuthorization() async {
    return "Bearer ${await getIt.get<SessionManager>().get("jwt")}";
  }

  static String getFolder(String path) {
    return path.split("/")[0];
  }

  static bool validateEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  static Future<String> getLoggedUserJwt() async {
    return await getIt.get<SessionManager>().get("jwt");
  }

  static Future<String> getLoggedUserProfileImage() async {
    return JwtDecoder.decode(await getLoggedUserJwt())['profile_image'];
  }

  static Map<String, dynamic> unifyNames(Map<String, dynamic> decodedJwt) {
    decodedJwt['name'] =
        '${decodedJwt['first_name']} ${decodedJwt['last_name']}';
    decodedJwt.remove('first_name');
    decodedJwt.remove('last_name');
    return decodedJwt;
  }

  static Future<String> getDownloadUrl(String path) async {
    try {
    return await getIt.get<Reference>().child(path).getDownloadURL();
    } catch (e) {
      logger.d("Resource not found in bucket: $path.\nError: ${e.toString()}");
      return await getIt.get<Reference>().child("books/no_cover.jpg").getDownloadURL();
    }
  }

  static Future<String> getProfileImageDownloadUrl() async {
    String path = await getIt
        .get<Reference>()
        .child('$usersAvatarsPath${await getLoggedUserProfileImage()}')
        .getDownloadURL();
    return path;
  }

  static Map<String,dynamic> physicalBookToJson(PhysicalBook physicalBook){
    return {
      'id': physicalBook.id,
      'barcode': physicalBook.barcode,
      'author': physicalBook.author,
      'referenceId': physicalBook.referenceId,
      'collectionId': physicalBook.collectionId,
      'title': physicalBook.title,
      'edition': physicalBook.edition,
      'deweyCode': physicalBook.deweyCode,
      'creationDate': physicalBook.creationDate,
      'rating': physicalBook.rating,
      'ratings': physicalBook.ratings,
      'isbn': physicalBook.isbn,
      'isbn13': physicalBook.isbn13,
      'publisher': physicalBook.publisher,
      'publishDate': physicalBook.publishDate,
      'language': physicalBook.language,
      'bookCover': physicalBook.bookCover,
      'status': physicalBook.status,
      'bibliographicGps': physicalBook.bibliographicGps,
    };
  }
}
