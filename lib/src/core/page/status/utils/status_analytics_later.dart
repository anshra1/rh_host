// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:rh_host/src/core/page/import.dart';

// class StatusAnalytics {
//   static void logStatusScreenView(StatusScreenModel config) {
//     FirebaseAnalytics.instance.logEvent(
//       name: 'status_screen_view',
//       parameters: {
//         'type': config.type.toString(),
//         'title': config.title,
//         'has_custom_content': config.customContent != null,
//         'auto_navigate': config.autoNavigateAfter != null,
//       },
//     );
//   }

//   static void logStatusAction(String actionType, StatusScreenModel config) {
//     FirebaseAnalytics.instance.logEvent(
//       name: 'status_action',
//       parameters: {
//         'action_type': actionType,
//         'status_type': config.type.toString(),
//         'screen_title': config.title,
//       },
//     );
//   }
// }