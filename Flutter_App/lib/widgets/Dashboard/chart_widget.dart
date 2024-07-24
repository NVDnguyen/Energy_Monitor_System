import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/models/devices.dart';
import 'package:iot_app/services/realtime_firebase.dart';

class DeviceDataPoint {
  final Device device;
  final DateTime timestamp;

  DeviceDataPoint({required this.device, required this.timestamp});
}

class Chart {
  static List<DeviceDataPoint> deviceDataPoints = [];

  static Widget buildChartLineSensor({required VoidCallback onPress}) {
    Stream<Device> deviceStream =
        DataFirebase.getStreamDevice("ESP_3470400_1458270");
    return StreamBuilder<Device>(
        stream: deviceStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Text('No device data');
          }

          final data = snapshot.data!;
          data.vol > 0 ? data.vol : 0;
          print(data.toString());
          final DateTime now = DateTime.now();

          // Add new data point
          deviceDataPoints.add(DeviceDataPoint(device: data, timestamp: now));
          return Padding(
            padding: const EdgeInsets.only(
                bottom: 20), // Add 20 spacing at the bottom
            child: GestureDetector(
              onLongPress: onPress,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white, // Default background color
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // _buildBarChart(data),
                    SizedBox(
                      height: 300, // Explicit height for the chart
                      child: _buildLineChart(deviceDataPoints),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static Widget _buildLineChart(List<DeviceDataPoint> deviceDataPoints) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          _createLineChartBarData('energy', Colors.orange),
          _createLineChartBarData('vol', Colors.blue),
          _createLineChartBarData('ampe', Colors.red),
          _createLineChartBarData('wat', Colors.green),
        ],
        maxY: 250,
        titlesData: const FlTitlesData(
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: const FlGridData(show: true),
        borderData: FlBorderData(show: true),
      ),
    );
  }

  static LineChartBarData _createLineChartBarData(
      String property, Color color) {
    return LineChartBarData(
      spots: deviceDataPoints
          .map((e) => FlSpot(
                e.timestamp.millisecondsSinceEpoch.toDouble(),
                _getPropertyValue(e.device, property),
              ))
          .toList(),
      isCurved: true,
      color: color,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    );
  }

  static double _getPropertyValue(Device device, String property) {
    switch (property) {
      case 'energy':
        return device.energy;
      case 'vol':
        return device.vol;
      case 'ampe':
        return device.ampe;
      case 'wat':
        return device.wat;
      default:
        return 0.0;
    }
  }

  static Widget getLegendCard() {
    return Card(
      color: const Color.fromARGB(223, 154, 233, 213),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GridView.count(
          shrinkWrap:
              true, // Important to prevent GridView from expanding infinitely
          crossAxisCount: 4, // Number of columns
          childAspectRatio:
              4, // Adjust the aspect ratio for better control of item spacing
          mainAxisSpacing: 4, // Space between rows

          children: <Widget>[
            _buildLegendItem(Colors.orange, 'energy'),
            _buildLegendItem(Colors.blue, 'vol'),
            _buildLegendItem(Colors.red, 'ampe'),
            _buildLegendItem(Colors.green, 'wat'),
          ],
        ),
      ),
    );
  }

  // Helper method to build a single legend item
  static Widget _buildLegendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.circle, color: color, size: 16),
        const SizedBox(
          width: 8,
          height: 4,
        ),
        Text(text),
      ],
    );
  }
}
