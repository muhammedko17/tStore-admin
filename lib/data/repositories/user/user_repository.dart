import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cwt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:t_utils/t_utils.dart';

import '../../../features/personalization/models/user_model.dart';
import '../../../features/product_management/models/order_model.dart';
import '../../abstract/base_repository.dart';

/// Repository class for user-related operations.
class UserRepository extends TBaseRepositoryController<UserModel> {
  static UserRepository get instance => Get.find();

  @override
  Future<String> addItem(UserModel item) async {
    await db.collection("Users").doc(item.id).set(item.toJson());
    return item.id;
  }

  @override
  Future<List<UserModel>> fetchAllItems() async {
    final snapshot = await db.collection("Users").orderBy('createdAt', descending: true).get();
    final result = snapshot.docs.map((e) => UserModel.fromDocSnapshot(e)).toList();
    return result;
  }

  @override
  Future<UserModel> fetchSingleItem(String id) async {
    final snapshot = await db.collection("Users").doc(id).get();
    final result = UserModel.fromDocSnapshot(snapshot);
    return result;
  }

  @override
  UserModel fromQueryDocSnapshot(QueryDocumentSnapshot<Object?> doc) {
    return UserModel.fromQuerySnapshot(doc);
  }

  @override
  Query getPaginatedQuery(limit) => db.collection('Users').where('role', isEqualTo: AppRole.user.name).orderBy('createdAt', descending: true).limit(limit);

  @override
  Future<void> updateItem(UserModel item) async {
    await db.collection("Users").doc(item.id).update(item.toJson());
  }

  @override
  Future<void> updateSingleField(String id, Map<String, dynamic> json) async {
    await db.collection("Users").doc(id).update(json);
  }

  @override
  Future<void> deleteItem(UserModel item) async {
    await db.collection("Users").doc(item.id).delete();
  }

  /// Function to fetch user details based on user ID.
  Future<List<OrderModel>> fetchUserOrders(String userId) async {
    try {
      final documentSnapshot =
          await db.collection("Orders").where('userId', isEqualTo: userId).orderBy('createdAt', descending: true).get();
      return documentSnapshot.docs.map((doc) => OrderModel.fromQuerySnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      // If index is required to be created
      if (e.code == 'failed-precondition') {
        TDialogs.defaultDialog(
          context: Get.context!,
          title: 'Create new Index',
          content: SelectableText(e.message ?? 'The query requires an index. Create that index and try again.'),
        );
        throw 'The query requires an index. Create that index and try again.';
      }

      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function to fetch user details based on user ID.
  Future<void> registerAdmin(UserModel user) async {
    try {
      await db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> updateUserPoints(String userId, int pointsToAdd) async {
    try {
      final userRef = db.collection('Users').doc(userId);

      await db.runTransaction((transaction) async {
        final snapshot = await transaction.get(userRef);
        final currentPoints = snapshot.data()?['points'] ?? 0;
        final newPoints = currentPoints + pointsToAdd;

        transaction.update(userRef, {'points': newPoints});
      });
    } on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
