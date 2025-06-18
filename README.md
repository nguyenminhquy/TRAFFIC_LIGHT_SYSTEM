# Traffic Light System

Hệ thống đèn giao thông được thiết kế để tự động và thủ công điều khiển giao thông tại các ngã tư hoặc các tuyến đường có mật độ giao thông cao. Hệ thống sử dụng FPGA và ngôn ngữ mô tả phần cứng Verilog, giúp mô phỏng và điều khiển đèn giao thông cho hai làn đường, với ba trạng thái đèn (đỏ, vàng, xanh) cho mỗi làn đường, đồng thời hiển thị thời gian đếm ngược bằng LED 7 đoạn.

## Cấu trúc hệ thống

Hệ thống đèn giao thông được chia thành ba chế độ điều khiển chính, mỗi chế độ có một chức năng khác nhau:

1. **Auto Mode (Chế độ tự động)**: 
   - Hệ thống tự động chuyển đổi giữa các trạng thái đèn (đỏ, vàng, xanh) theo chu kỳ thời gian đã được lập trình sẵn.
   - Đèn xanh cho phép phương tiện di chuyển, đèn đỏ yêu cầu dừng lại, và đèn vàng là tín hiệu chuyển tiếp giữa đèn xanh và đỏ.

2. **Manual Mode (Chế độ thủ công)**:
   - Hệ thống điều khiển đèn giao thông thủ công thông qua hai công tắc (SW1 và SW2).
   - SW1: Đèn xanh sáng cho làn A, đèn đỏ sáng cho làn B.
   - SW2: Đèn xanh sáng cho làn B, đèn đỏ sáng cho làn A.

3. **Night Mode (Chế độ ban đêm)**:
   - Hệ thống tự động chuyển sang chế độ nhấp nháy đèn vàng vào ban đêm, giúp tiết kiệm năng lượng và giảm sự chú ý của người tham gia giao thông.

## Các thành phần chính của hệ thống

Hệ thống bao gồm ba module chính:

- **fsm_auto_mode**: Điều khiển tự động hệ thống đèn giao thông theo chu kỳ.
- **fsm_manual_mode**: Cho phép người điều khiển thay đổi trạng thái đèn giao thông thủ công.
- **night_mode**: Điều chỉnh hoạt động của hệ thống đèn giao thông vào ban đêm.

## Cách sử dụng

### 1. **Chế độ tự động (Auto Mode)**:
   - Hệ thống tự động điều khiển đèn giao thông, chuyển đổi giữa các trạng thái đèn (đỏ, vàng, xanh) theo chu kỳ thời gian đã lập trình sẵn.

### 2. **Chế độ thủ công (Manual Mode)**:
   - Sử dụng hai công tắc (SW1 và SW2) để điều khiển trạng thái của các đèn giao thông:
     - SW1: Đèn xanh sáng cho làn A và đèn đỏ sáng cho làn B.
     - SW2: Đèn xanh sáng cho làn B và đèn đỏ sáng cho làn A.

### 3. **Chế độ ban đêm (Night Mode)**:
   - Hệ thống sẽ tự động chuyển sang chế độ nhấp nháy đèn vàng vào ban đêm, giúp tiết kiệm năng lượng.

## Các tính năng

- **Điều khiển tự động**: Hệ thống tự động thay đổi trạng thái đèn giao thông theo một chu kỳ thời gian đã lập trình sẵn.
- **Điều khiển thủ công**: Người điều khiển có thể sử dụng SW1 và SW2 để thay đổi trạng thái đèn giao thông.
- **Hiển thị thời gian đếm ngược**: Mỗi đèn giao thông có LED 7 đoạn để hiển thị thời gian còn lại trước khi chuyển sang trạng thái tiếp theo.
- **Chế độ ban đêm**: Hệ thống sẽ chuyển sang chế độ nhấp nháy đèn vàng vào ban đêm để giảm ùn tắc và tiết kiệm năng lượng.

## Cài đặt và triển khai

### 1. **Cài đặt phần mềm**

- Cài đặt phần mềm mô phỏng FPGA như Xilinx Vivado hoặc Quartus để mô phỏng và triển khai mã Verilog.
- Cài đặt các thư viện hỗ trợ FPGA nếu cần thiết.

### 2. **Triển khai lên FPGA**

- Sau khi mã Verilog được viết và kiểm tra trong phần mềm mô phỏng, triển khai mã lên kit FPGA.
- Kết nối các LED, công tắc (SW1, SW2), và màn hình LED 7 đoạn vào FPGA theo sơ đồ mạch.

### 3. **Kiểm tra hoạt động**

- Sau khi triển khai, kiểm tra các chế độ điều khiển (Auto, Manual, Night) và đảm bảo các đèn giao thông hoạt động đúng với các trạng thái đã định.

## Mã nguồn

- Mã nguồn Verilog cho hệ thống đèn giao thông có thể được tìm thấy trong thư mục `src/`.
- Các testbench để kiểm tra hoạt động của hệ thống được lưu trong thư mục `testbench/`.

## Giới thiệu về Máy trạng thái hữu hạn (FSM)

Hệ thống sử dụng Máy trạng thái hữu hạn (FSM) để điều khiển các trạng thái của đèn giao thông. Các trạng thái bao gồm:
- Đèn xanh sáng cho làn A hoặc B.
- Đèn đỏ sáng cho các làn đường còn lại.
- Đèn vàng sáng cho làn đường đang chuyển đổi.

FSM giúp hệ thống hoạt động theo chu kỳ tự động, đảm bảo an toàn và giảm thiểu ùn tắc giao thông.

## Liên hệ

Nếu có bất kỳ câu hỏi hoặc vấn đề nào trong quá trình sử dụng hệ thống, vui lòng liên hệ với chúng tôi qua email: support@trafficlightsystem.com.

---

Cảm ơn bạn đã sử dụng hệ thống đèn giao thông của chúng tôi!

