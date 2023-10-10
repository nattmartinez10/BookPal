

import 'package:bookpal/data/enums/notification_status.dart';
import 'package:bookpal/domain/entities/notification.dart';

class NotificationModel extends Notification {
  NotificationModel({
    required String id,
    required String userId,
    required String title,
    required String message,
    required DateTime nextScheduleDate,
    NotificationStatus status = NotificationStatus.unread,
  }) : super(
    id: id,
    userId: userId,
    title: title,
    message: message,
    nextScheduleDate: nextScheduleDate,
    status: status,
  );

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json['id'] ?? "",
    userId: json['userId'] ?? "",
    title: json['title'] ?? "",
    message: json['message'] ?? "",
    nextScheduleDate: DateTime.parse(json['nextScheduleDate'] ?? ""),
    status: NotificationStatus.values[json['status'] ?? NotificationStatus.unread.index]
  );
}