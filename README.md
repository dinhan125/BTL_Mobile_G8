# 📱 Travel Buddy - Ứng dụng Quản lý & Lên lịch trình Du lịch Nhóm[cite: 1]

Một ứng dụng mobile được phát triển bằng Flutter giúp các nhóm bạn bè và gia đình cùng nhau lên kế hoạch đi chơi, chia sẻ vị trí và quản lý chi phí chung[cite: 1].

## 📖 Mô tả dự án[cite: 1]
Travel Buddy là dự án nhóm 4 người nhằm giải quyết vấn đề quản lý thông tin và tài chính rời rạc khi đi du lịch chung[cite: 1]. Ứng dụng cung cấp giao diện thân thiện, mượt mà trên cả hai nền tảng Android và iOS nhờ sức mạnh của Flutter[cite: 1].

### ✨ Các tính năng chính:[cite: 1]
* Tính năng 1: Đăng nhập/Đăng ký với Firebase an toàn, cho phép tạo chuyến đi và mời bạn bè tham gia[cite: 1].
* Tính năng 2: Hiển thị danh sách các điểm đến, chuyến bay và lịch trình chi tiết theo từng ngày[cite: 1].
* Tính năng 3: Quản lý chi phí chung và tính toán chia tiền thay thế cho hệ thống giỏ hàng và thanh toán[cite: 1].
* Tính năng 4: Thông báo đẩy (Push Notifications) khi có thay đổi về lịch trình, vị trí SOS hoặc tin nhắn mới[cite: 1].

### 🛠 Công nghệ sử dụng:[cite: 1]
* **Framework:** Flutter[cite: 1]
* **Ngôn ngữ:** Dart[cite: 1]
* **Backend/Database:** Firebase (Authentication, Firestore, Realtime Database, Cloud Storage)[cite: 1]
* **State Management:** Riverpod[cite: 1]
* **Routing:** GoRouter
* **Data Models:** Freezed, JSON Serializable

---

## 🚀 Hướng dẫn cài đặt[cite: 1]

Để chạy ứng dụng này trên máy cá nhân, vui lòng làm theo các bước sau:[cite: 1]

### Yêu cầu hệ thống (Prerequisites)[cite: 1]
1. Đã cài đặt [Flutter SDK](https://docs.flutter.dev/get-started/install) (phiên bản >= 3.10.0)[cite: 1].
2. Đã cài đặt Dart SDK[cite: 1].
3. IDE: [Android Studio](https://developer.android.com/studio) hoặc [Visual Studio Code](https://code.visualstudio.com/) có cài sẵn Flutter & Dart plugins[cite: 1].
4. Máy ảo Android/iOS (Emulator/Simulator) hoặc thiết bị thật đã bật chế độ gỡ lỗi (USB Debugging)[cite: 1].
5. Đã cài đặt Firebase CLI để kết nối backend.

### Các bước chạy dự án[cite: 1]
**Bước 1:** Clone repository này về máy:[cite: 1]
```bash
git clone [https://github.com/](https://github.com/)[tên-tài-khoản-github]/travel-buddy.git
cd travel-buddy
