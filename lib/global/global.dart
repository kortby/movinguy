import 'package:firebase_auth/firebase_auth.dart';
import 'package:movinguy/models/user_model.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentUser;
List dList = []; // online active driverKeys info list

