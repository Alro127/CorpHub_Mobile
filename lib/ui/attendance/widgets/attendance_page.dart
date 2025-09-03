import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/ui/core/widgets/aurora_background.dart';
import 'package:ticket_helpdesk/ui/core/widgets/head_bar.dart';
import 'package:ticket_helpdesk/ui/core/widgets/side_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  bool _checkin = false;
  bool _checkout = false;

  String _address = "Đang lấy địa chỉ...";
  String _currentTime = "Đang lấy thời gian";

  final String thoiGianVaoCa = "08:30:00";
  final String thoiGianKetCa = "17:30:00";

  final List<Widget> _mileStones = [];

  @override
  void initState() {
    super.initState();
    _listenToLocation();
    _listenToTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeadBar(title: "Attendance"),
      drawer: SideBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 8),
              const Text(
                "Vị trí hiện tại",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  _address,
                  textAlign: TextAlign.center,
                  style: const TextStyle(overflow: TextOverflow.clip),
                ),
              ),
              const SizedBox(height: 16),
              _buildCheckButton(),
              const SizedBox(height: 16),
              Text(
                _currentTime,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Divider(color: Colors.blueAccent),
              const SizedBox(height: 4),
              /*              const Text("Lộ trình"),*/
              ..._mileStones,
              const SizedBox(height: 8),
              /*              const Text("Giờ checkin"),
              const Text("Giờ checkout"),*/
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckButton() {
    double size = 180;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.zero, // để background chiếm hết button
        backgroundColor: Colors.transparent,
        elevation: 4,
      ),
      onPressed: check,
      child: Ink(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: ClipOval(
          child: Stack(
            alignment: Alignment.center,
            children: [
              AuroraBackground(width: size, height: size),
              Text(
                _checkin ? "Checkout" : "Checkin",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMileStone(IconData icon, String time, String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 8),
          Text(
            time,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              message,
              style: TextStyle(fontSize: 18, color: Colors.grey[900]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnector() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 16),
        Container(width: 2, height: 20, color: Colors.blue),
      ],
    );
  }

  Future<void> _listenToLocation() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      setState(() => _address = "Dịch vụ vị trí đang tắt");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _address = "Quyền truy cập vị trí bị từ chối");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => _address = "Quyền vị trí bị từ chối vĩnh viễn");
      return;
    }

    Position? lastPos = await Geolocator.getLastKnownPosition();
    if (lastPos != null) {
      setState(() {
        _address =
            "Lat: ${lastPos.latitude}, Lng: ${lastPos.longitude}\n(Đang cập nhật...)";
      });
    }

    try {
      Position pos = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.low),
      );
      setState(() {
        _address =
            "Lat: ${pos.latitude}, Lng: ${pos.longitude}\nĐang dịch địa chỉ...";
      });

      String addr = await _getAddress(pos);
      setState(() => _address = addr);
    } catch (_) {
      setState(() => _address = "Không thể lấy vị trí nhanh");
    }

    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.medium,
        distanceFilter: 5,
      ),
    ).listen((Position position) async {
      // Hiển thị tọa độ ngay
      setState(() {
        _address =
            "Lat: ${position.latitude}, Lng: ${position.longitude}\nĐang dịch địa chỉ...";
      });

      // Lấy địa chỉ
      try {
        String address = await _getAddress(position);
        setState(() => _address = address);
      } catch (e) {
        setState(() => _address = "Không thể lấy địa chỉ: $e");
      }
    });
  }

  Future<String> _getAddress(Position pos) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      pos.latitude,
      pos.longitude,
    );

    if (placemarks.isEmpty) return "Không tìm thấy địa chỉ";

    Placemark place = placemarks[0];
    return "${place.street}, ${place.subLocality}, ${place.locality}, "
        "${place.administrativeArea}, ${place.country}";
  }

  void _listenToTime() {
    Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _currentTime = DateFormat("HH:mm:ss").format(DateTime.now());
      });
    });
  }

  void check() {
    if (_currentTime == "Đang lấy thời gian") return;

    if (!_checkin && !_checkout) {
      _checkin = true;
      _mileStones.insert(
        0,
        _buildMileStone(Icons.start, _currentTime, "Checkin"),
      );
    } else if (_checkin && !_checkout) {
      _checkout = true;
      _mileStones.insert(0, _buildConnector());
      _mileStones.insert(
        0,
        _buildMileStone(Icons.flag, _currentTime, "Checkout"),
      );
      _mileStones.insert(0, _buildConnector());
      if (_checkin && _checkout) {
        _mileStones.insert(
          0,
          _buildMileStone(Icons.done_all, _currentTime, "Completed"),
        );
      }
    }
  }
}
