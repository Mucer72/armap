import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/area_model.dart';
import '../models/destination_model.dart';
import '../models/spot_model.dart';
import '../models/object_model.dart';

class DataService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getDataByArea(String userId) async {
    try {
      DocumentSnapshot userDoc = await _db.collection('users').doc(userId).get();
      if (!userDoc.exists) throw Exception('User không tồn tại');
      UserModel user = UserModel.fromJson(userDoc.data() as Map<String, dynamic>);

      String areaId = user.area.toString();

      DocumentSnapshot areaDoc = await _db.collection('area').doc(areaId).get();
      AreaModel area = AreaModel.fromJson(areaDoc.data() as Map<String, dynamic>);

      QuerySnapshot destinationSnap = await _db.collection('destination').where('area', isEqualTo: area.id).get();
      List<DestinationModel> destinations = destinationSnap.docs.map((doc) => DestinationModel.fromJson(doc.data() as Map<String, dynamic>)).toList();

      List<SpotModel> spots = [];
      for (var destination in destinations) {
        QuerySnapshot spotSnap = await _db.collection('spot').where('destination_id', isEqualTo: destination.id).get();
        spots.addAll(spotSnap.docs.map((doc) => SpotModel.fromJson(doc.data() as Map<String, dynamic>)));
      }

      QuerySnapshot objectSnap = await _db.collection('object').where('area', isEqualTo: area.id).get();
      List<ObjectModel> objects = objectSnap.docs.map((doc) => ObjectModel.fromJson(doc.data() as Map<String, dynamic>)).toList();

      return {'user': user, 'area': area, 'destinations': destinations, 'spots': spots, 'objects': objects};
    } catch (e) {
      print('Lỗi khi lấy dữ liệu: $e');
      return {};
    }
  }
}
