import 'package:firebase_auth/firebase_auth.dart';
import 'package:movinguy/models/user_model.dart';

import '../models/direction_details_info.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentUser;
List dList = []; // online active driverKeys info list

DirectionDetailsInfo? tripDirectionDetailsInfo;

String? chosenDriverId = '';

String cloudMessagingServerToken = 'key=AAAAYXbVvSY:APA91bEQhUMktkVIJkAdTrtHVrVA2NMgg_7qTnWYsj6Z7y8deoAuWiQOdAUWERPgRUG4j4okEdfSJ21waQ66VAX09SZ0lvyxmFvd_HZ3q1S1Wk0l09jtxEQhQBLUlby9Kkt5B0GXqXfD';
String userDropOffAddress = '';