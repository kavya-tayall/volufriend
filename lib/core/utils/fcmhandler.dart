import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';

class FCMTokenHandler {
  // Function to initialize the token handler
  void initialize() {
    // Listen to token refresh
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      // When the token is refreshed, handle it
      handleTokenRefresh(newToken);
    }).onError((error) {
      // Handle any errors that occur during the listening process
      print('Token refresh error: $error');
    });
  }

  // Function to handle the token refresh event
  Future<void> handleTokenRefresh(String newToken) async {
    try {
      // Send the new token to your server
      await updateTokenOnServer(newToken);
    } catch (error) {
      print('Error updating token on server: $error');
    }
  }

  // Function to update the token on the server
  Future<void> updateTokenOnServer(String token) async {
    if (token != null) {
      // Call the method in your service to send the token to the backend
      VolufriendCrudService()
          .sendFcmToken(userId: userId, token: token)
          .then((result) {
        // Optionally handle the result
        if (result == 1) {
          print("Token registered successfully.");
        } else {
          print("Failed to register token.");
        }
      }).catchError((error) {
        print("Error registering token: $error");
      });
    }

    // If the token is null, print an error message
    else {
      print("Token is null.");
    }
  }
}
