import 'dart:async';

class SearchHistoryNotifier {
  // StreamController dùng để quản lý stream cập nhật lịch sử tìm kiếm
  static final _historyUpdatedController = StreamController<void>.broadcast();

  // Stream cung cấp sự kiện khi lịch sử tìm kiếm thay đổi
  static Stream<void> get historyUpdatedStream => _historyUpdatedController.stream;

  // Hàm này sẽ được gọi khi muốn phát sự kiện cập nhật lịch sử
  static void notifyHistoryUpdated() {
    _historyUpdatedController.add(null);
  }

  // Hàm dispose để đóng StreamController khi không còn cần thiết
  static void dispose() {
    _historyUpdatedController.close();
  }
}
