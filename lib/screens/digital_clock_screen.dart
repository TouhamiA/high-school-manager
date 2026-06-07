import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'dart:async';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

class DigitalClockScreen extends StatefulWidget {
  const DigitalClockScreen({Key? key}) : super(key: key);

  @override
  State<DigitalClockScreen> createState() => _DigitalClockScreenState();
}

class _DigitalClockScreenState extends State<DigitalClockScreen> {
  late Timer _timer;
  late DateTime _currentTime;
  List<String> selectedTimeZones = ['UTC', 'US/Eastern', 'Europe/London', 'Asia/Tokyo'];
  bool is24HourFormat = true;

  final List<Map<String, String>> availableTimeZones = [
    {'name': 'UTC', 'label': 'UTC/GMT', 'region': 'Global'},
    {'name': 'US/Eastern', 'label': 'Eastern Time', 'region': 'North America'},
    {'name': 'US/Central', 'label': 'Central Time', 'region': 'North America'},
    {'name': 'US/Mountain', 'label': 'Mountain Time', 'region': 'North America'},
    {'name': 'US/Pacific', 'label': 'Pacific Time', 'region': 'North America'},
    {'name': 'Europe/London', 'label': 'London', 'region': 'Europe'},
    {'name': 'Europe/Paris', 'label': 'Paris', 'region': 'Europe'},
    {'name': 'Europe/Berlin', 'label': 'Berlin', 'region': 'Europe'},
    {'name': 'Europe/Moscow', 'label': 'Moscow', 'region': 'Europe'},
    {'name': 'Asia/Dubai', 'label': 'Dubai', 'region': 'Middle East'},
    {'name': 'Asia/Kolkata', 'label': 'India', 'region': 'Asia'},
    {'name': 'Asia/Bangkok', 'label': 'Bangkok', 'region': 'Asia'},
    {'name': 'Asia/Shanghai', 'label': 'Shanghai', 'region': 'Asia'},
    {'name': 'Asia/Tokyo', 'label': 'Tokyo', 'region': 'Asia'},
    {'name': 'Asia/Singapore', 'label': 'Singapore', 'region': 'Asia'},
    {'name': 'Australia/Sydney', 'label': 'Sydney', 'region': 'Oceania'},
    {'name': 'Australia/Melbourne', 'label': 'Melbourne', 'region': 'Oceania'},
    {'name': 'Pacific/Auckland', 'label': 'Auckland', 'region': 'Oceania'},
    {'name': 'Africa/Cairo', 'label': 'Cairo', 'region': 'Africa'},
    {'name': 'Africa/Johannesburg', 'label': 'Johannesburg', 'region': 'Africa'},
    {'name': 'America/Toronto', 'label': 'Toronto', 'region': 'North America'},
    {'name': 'America/Mexico_City', 'label': 'Mexico City', 'region': 'North America'},
    {'name': 'America/Sao_Paulo', 'label': 'São Paulo', 'region': 'South America'},
    {'name': 'America/Buenos_Aires', 'label': 'Buenos Aires', 'region': 'South America'},
  ];

  @override
  void initState() {
    super.initState();
    tzdata.initializeTimeZones();
    _currentTime = DateTime.now();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(DateTime time, bool use24Hour) {
    if (use24Hour) {
      return DateFormat('HH:mm:ss').format(time);
    } else {
      return DateFormat('hh:mm:ss a').format(time);
    }
  }

  String _formatDate(DateTime time) {
    return DateFormat('EEEE, MMMM dd, yyyy').format(time);
  }

  DateTime _getTimeInZone(String timeZoneName) {
    try {
      final location = tz.getLocation(timeZoneName);
      return tz.TZDateTime.now(location);
    } catch (e) {
      return DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Clock - Multi Timezone'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _showTimeZoneSelector,
          ),
          IconButton(
            icon: Icon(is24HourFormat ? Icons.access_time : Icons.schedule),
            onPressed: () {
              setState(() {
                is24HourFormat = !is24HourFormat;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Main Clock Display (Local Time)
              _buildMainClockCard(isDark),
              const SizedBox(height: 24),

              // Time Zone Clocks
              Text(
                'Selected Time Zones',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),

              if (selectedTimeZones.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No time zones selected',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: _showTimeZoneSelector,
                          icon: const Icon(Icons.add),
                          label: const Text('Add Time Zone'),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: selectedTimeZones.length,
                  itemBuilder: (context, index) {
                    final tzName = selectedTimeZones[index];
                    final tzData = availableTimeZones.firstWhere(
                      (tz) => tz['name'] == tzName,
                      orElse: () => {'name': tzName, 'label': tzName, 'region': ''},
                    );
                    return _buildTimeZoneCard(
                      tzName,
                      tzData['label'] ?? tzName,
                      tzData['region'] ?? '',
                      isDark,
                      index,
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainClockCard(bool isDark) {
    return Card(
      elevation: 8,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [Colors.grey[900]!, Colors.grey[800]!]
                : [Colors.blue[50]!, Colors.blue[100]!],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Text(
                'Local Time',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isDark ? Colors.grey[400] : Colors.grey[700],
                      letterSpacing: 1.5,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                _formatTime(_currentTime, is24HourFormat),
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                _formatDate(_currentTime),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark ? Colors.grey[400] : Colors.grey[700],
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeZoneCard(
    String tzName,
    String label,
    String region,
    bool isDark,
    int index,
  ) {
    final timeInZone = _getTimeInZone(tzName);
    final offset = timeInZone.timeZoneOffset;
    final offsetString =
        'UTC${offset.isNegative ? '' : '+'}${(offset.inHours).toString().padLeft(2, '0')}:${((offset.inMinutes % 60).abs()).toString().padLeft(2, '0')}';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      region,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      selectedTimeZones.removeAt(index);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            Divider(height: 1),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatTime(timeInZone, is24HourFormat),
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      offsetString,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                            fontFamily: 'monospace',
                          ),
                    ),
                  ],
                ),
                Icon(
                  Icons.schedule,
                  size: 32,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showTimeZoneSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Select Time Zones',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: availableTimeZones.length,
                itemBuilder: (context, index) {
                  final tz = availableTimeZones[index];
                  final isSelected = selectedTimeZones.contains(tz['name']);

                  return CheckboxListTile(
                    title: Text(tz['label'] ?? ''),
                    subtitle: Text(tz['region'] ?? ''),
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          if (!selectedTimeZones.contains(tz['name'])) {
                            selectedTimeZones.add(tz['name']!);
                          }
                        } else {
                          selectedTimeZones.remove(tz['name']);
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
