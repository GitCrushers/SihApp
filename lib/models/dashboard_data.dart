class DashboardData {
  final String deviceId;
  final double solarCurrent;
  final double solarVoltage;
  final double solarPower;
  final int batterySoc;
  final double batteryVoltage;
  final double loadPower;
  final String firmwareVersion;
  final String location;
  final String createdAt;

  DashboardData({
    required this.deviceId,
    required this.solarCurrent,
    required this.solarVoltage,
    required this.solarPower,
    required this.batterySoc,
    required this.batteryVoltage,
    required this.loadPower,
    required this.firmwareVersion,
    required this.location,
    required this.createdAt,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      deviceId: json['device_id'] ?? '',
      solarCurrent: (json['solar_current_a'] ?? 0).toDouble(),
      solarVoltage: (json['solar_voltage_v'] ?? 0).toDouble(),
      solarPower: (json['solar_power_w'] ?? 0).toDouble(),
      batterySoc: (json['battery_soc_percent'] ?? 0).toInt(),
      batteryVoltage: (json['battery_voltage_v'] ?? 0).toDouble(),
      loadPower: (json['load_power_w'] ?? 0).toDouble(),
      firmwareVersion: json['firmware_version'] ?? '',
      location: json['location'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}
