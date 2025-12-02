import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_fcm_notifications/flutter_fcm_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationController extends GetxController {
  late NotificationManager notificationManager;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  
  final RxInt unreadCount = 0.obs;
  final RxBool isLoading = true.obs;
  final RxList<NotificationItem> notifications = <NotificationItem>[].obs;
  final RxString fcmToken = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    initializeNotifications();
  }
  
  Future<void> initializeNotifications() async {
    try {
      isLoading.value = true;
      
      // Initialize local notifications
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      await _initializeLocalNotifications();
      
      // Initialize NotificationManager from plugin
      notificationManager = NotificationManager();
      await notificationManager.initialize();
      
      // Listen to NotificationManager changes for real-time updates
      notificationManager.addListener(_onNotificationManagerUpdate);
      
      // Setup FCM
      await _setupFCM();
      
      // Load initial data
      await refreshNotifications();
      
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to initialize notifications: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  
  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: DarwinInitializationSettings(),
    );
    
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap
        print('Notification tapped: ${response.payload}');
      },
    );
    
    // Create Android notification channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );
    
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
  
  void _onNotificationManagerUpdate() {
    // Real-time update when NotificationManager changes
    refreshNotifications();
  }
  
  Future<void> _setupFCM() async {
    final messaging = FirebaseMessaging.instance;
    
    // Request permission
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      
      // Get FCM token
      final token = await messaging.getToken();
      if (token != null) {
        fcmToken.value = token;
        print('FCM Token: $token');
        // TODO: Send token to your backend server
      }
      
      // Handle foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Received foreground message: ${message.messageId}');
        _handleMessage(message);
      });
      
      // Handle background message taps
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('Message clicked: ${message.messageId}');
        _handleMessage(message);
      });
      
      // Check for initial message (app opened from terminated state)
      final initialMessage = await messaging.getInitialMessage();
      if (initialMessage != null) {
        _handleMessage(initialMessage);
      }
      
      // Listen for token refresh
      messaging.onTokenRefresh.listen((newToken) {
        fcmToken.value = newToken;
        print('FCM Token refreshed: $newToken');
        // TODO: Send new token to your backend
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }
  
  void _handleMessage(RemoteMessage message) {
    // Add notification to manager
    notificationManager.addNotification(message);
    
    // Show Android system notification
    _showLocalNotification(message);
    
    // Refresh local list (will be called automatically via listener)
    // refreshNotifications();
  }
  
  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
    );
    
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );
    
    await flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? 'New Notification',
      message.notification?.body ?? '',
      notificationDetails,
      payload: message.data.toString(),
    );
  }
  
  Future<void> refreshNotifications() async {
    notifications.value = notificationManager.notifications;
    unreadCount.value = notificationManager.unreadCount;
  }
  
  Future<void> markAsRead(String messageId) async {
    await notificationManager.markAsRead(messageId);
    await refreshNotifications();
  }
  
  Future<void> markAllAsRead() async {
    await notificationManager.markAllAsRead();
    await refreshNotifications();
  }
  
  Future<void> clearAll() async {
    await notificationManager.clearAll();
    await refreshNotifications();
  }
  
  Future<void> removeNotification(String messageId) async {
    await notificationManager.removeNotification(messageId);
    await refreshNotifications();
  }
  
  bool isRead(String messageId) {
    return notificationManager.readStatus[messageId] ?? false;
  }
  
  @override
  void onClose() {
    // Remove listener
    notificationManager.removeListener(_onNotificationManagerUpdate);
    super.onClose();
  }
}
