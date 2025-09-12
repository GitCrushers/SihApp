import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<FlSpot> solarSpots = [];
  List<FlSpot> loadSpots = [];
  List<String> timeLabels = [];

  String solarPower = '0';
  String solarCurrent = '0';
  String loadPower = '0';
  String batterySOC = '0';
  String batteryVoltage = '0';
  String deviceId = '';
  String firmwareVersion = '';
  String location = '';

  Timer? timer;

  @override
  void initState() {
    super.initState();
    fetchData();
    // auto refresh every 5 seconds
    timer = Timer.periodic(const Duration(seconds: 5), (t) => fetchData());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      final url = Uri.parse('https://sihwebsite-a2hp.onrender.com/api/v2/data');
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final body = json.decode(res.body);
        final List data = body['data'];

        // take last 5 samples
        final lastFive = data.take(5).toList().reversed.toList();

        List<FlSpot> solarTemp = [];
        List<FlSpot> loadTemp = [];
        List<String> timesTemp = [];

        for (int i = 0; i < lastFive.length; i++) {
          final item = lastFive[i];
          solarTemp.add(FlSpot(i.toDouble(), item['solar_power_w'] * 1.0));
          loadTemp.add(FlSpot(i.toDouble(), item['load_power_w'] * 1.0));
          DateTime time = DateTime.parse(item['createdAt']);
          String label =
              '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
          timesTemp.add(label);
        }

        final last = lastFive.last;
        setState(() {
          solarSpots = solarTemp;
          loadSpots = loadTemp;
          timeLabels = timesTemp;
          solarPower = last['solar_power_w'].toString();
          solarCurrent = last['solar_current_a'].toString();
          loadPower = last['load_power_w'].toString();
          batterySOC = last['battery_soc_percent'].toString();
          batteryVoltage = last['battery_voltage_v'].toString();
          deviceId = last['device_id'];
          firmwareVersion = last['firmware_version'];
          location = last['location'];
        });
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Cards Row 1
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _infoCard(
                      color: Colors.orange,
                      title: '☀️ Solar',
                      lines: [
                        'Power: $solarPower W',
                        'Current: $solarCurrent A',
                      ],
                    ),
                    _infoCard(
                      color: Colors.blue,
                      title: '⚡ Load',
                      lines: ['Power: $loadPower W'],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Cards Row 2
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _infoCard(
                      color: Colors.green,
                      title: '📗 Battery',
                      lines: [
                        'SOC: $batterySOC%',
                        'Voltage: $batteryVoltage V',
                      ],
                    ),
                    _infoCard(
                      color: Colors.grey[800]!,
                      title: '💻 Device',
                      lines: [deviceId, location],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Legend Row
                Row(
                  children: [
                    Container(width: 15, height: 3, color: Colors.orange),
                    const SizedBox(width: 5),
                    const Text(
                      'Solar (W)',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 20),
                    Container(width: 15, height: 3, color: Colors.blue),
                    const SizedBox(width: 5),
                    const Text(
                      'Load (W)',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Big Chart
                SizedBox(
                  height: 300,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: true),
                      titlesData: FlTitlesData(
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 32,
                            getTitlesWidget: (value, meta) {
                              int idx = value.toInt();
                              if (idx >= 0 && idx < timeLabels.length) {
                                return Text(
                                  timeLabels[idx],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                );
                              }
                              return const Text('');
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 50,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                '${value.toInt()} W',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: const Border(
                          bottom: BorderSide(width: 1, color: Colors.white24),
                          left: BorderSide(width: 1, color: Colors.white24),
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          color: Colors.orange,
                          barWidth: 3,
                          dotData: FlDotData(show: false),
                          spots: solarSpots,
                        ),
                        LineChartBarData(
                          isCurved: true,
                          color: Colors.blue,
                          barWidth: 3,
                          dotData: FlDotData(show: false),
                          spots: loadSpots,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Buttons row lower
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/surveillance');
                      },
                      child: _smallCard(
                        title: 'Surveillance',
                        subtitle: 'Tap to open',
                      ),
                    ),
                    _smallCard(
                      title: 'Weather',
                      subtitle: 'Forecast & Energy Prediction',
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoCard({
    required Color color,
    required String title,
    required List<String> lines,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...lines.map(
            (l) => Text(
              l,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallCard({required String title, required String subtitle}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(subtitle, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
