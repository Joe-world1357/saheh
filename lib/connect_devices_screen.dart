import 'package:flutter/material.dart';

class ConnectDevicesScreen extends StatefulWidget {
  const ConnectDevicesScreen({super.key});

  @override
  State<ConnectDevicesScreen> createState() => _ConnectDevicesScreenState();
}

class _ConnectDevicesScreenState extends State<ConnectDevicesScreen> {
  final List<Map<String, dynamic>> _connectedDevices = [];
  final List<Map<String, dynamic>> _availableDevices = [
    {
      'name': 'Apple Watch',
      'type': 'Smartwatch',
      'icon': Icons.watch,
      'color': const Color(0xFF000000),
    },
    {
      'name': 'Fitbit Charge 5',
      'type': 'Fitness Tracker',
      'icon': Icons.fitness_center,
      'color': const Color(0xFF4CAF50),
    },
    {
      'name': 'Samsung Galaxy Watch',
      'type': 'Smartwatch',
      'icon': Icons.watch,
      'color': const Color(0xFF2196F3),
    },
    {
      'name': 'Garmin Forerunner',
      'type': 'Sports Watch',
      'icon': Icons.directions_run,
      'color': const Color(0xFF9C27B0),
    },
  ];

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF20C6B7);

    return Scaffold(
      backgroundColor: const Color(0xFFF5FAFA),
      body: SafeArea(
        child: Column(
          children: [
            // TOP BAR
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFF1A2A2C),
                        size: 20,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      "Device",
                      style: TextStyle(
                        color: Color(0xFF1A2A2C),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // HEADER SECTION
                    Column(
                      children: [
                        const Text(
                          "Device",
                          style: TextStyle(
                            color: Color(0xFF1A2A2C),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Connect your devices to monitor your training easily.",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // SMARTWATCH ILLUSTRATION
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Watch face
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 3,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Small circles (watch buttons)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                // Display number
                                Text(
                                  "0",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // DESCRIPTION
                    Text(
                      "Synchronize your workout anywhere, anytime.",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 40),

                    // CONNECT DEVICE BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _showDeviceSelectionDialog();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: Border.all(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.watch,
                                color: Colors.grey.shade700,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Text(
                              "Connect a device",
                              style: TextStyle(
                                color: Color(0xFF1A2A2C),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.grey.shade600,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // CONNECTED DEVICES SECTION
                    if (_connectedDevices.isNotEmpty) ...[
                      Row(
                        children: [
                          const Text(
                            "Connected Devices",
                            style: TextStyle(
                              color: Color(0xFF1A2A2C),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              // Manage devices
                            },
                            child: const Text(
                              "Manage",
                              style: TextStyle(
                                color: Color(0xFF20C6B7),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ..._connectedDevices.map((device) => Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.grey.shade200,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: (device['color'] as Color).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    device['icon'] as IconData,
                                    color: device['color'] as Color,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        device['name'] as String,
                                        style: const TextStyle(
                                          color: Color(0xFF1A2A2C),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        device['type'] as String,
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4CAF50).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: Color(0xFF4CAF50),
                                        size: 16,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "Connected",
                                        style: TextStyle(
                                          color: Color(0xFF4CAF50),
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(height: 20),
                    ],

                    // AVAILABLE DEVICES SECTION
                    const Row(
                      children: [
                        Text(
                          "Available Devices",
                          style: TextStyle(
                            color: Color(0xFF1A2A2C),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ..._availableDevices.map((device) => Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey.shade200,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: (device['color'] as Color).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  device['icon'] as IconData,
                                  color: device['color'] as Color,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      device['name'] as String,
                                      style: const TextStyle(
                                        color: Color(0xFF1A2A2C),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      device['type'] as String,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _connectDevice(device);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                ),
                                child: const Text(
                                  "Connect",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _connectDevice(Map<String, dynamic> device) {
    setState(() {
      _connectedDevices.add(device);
      _availableDevices.remove(device);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${device['name']} connected successfully'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
    );
  }

  void _showDeviceSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Device Type'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.watch),
              title: const Text('Smartwatch'),
              onTap: () {
                Navigator.pop(context);
                // Handle smartwatch connection
              },
            ),
            ListTile(
              leading: const Icon(Icons.fitness_center),
              title: const Text('Fitness Tracker'),
              onTap: () {
                Navigator.pop(context);
                // Handle fitness tracker connection
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone_android),
              title: const Text('Phone'),
              onTap: () {
                Navigator.pop(context);
                // Handle phone connection
              },
            ),
          ],
        ),
      ),
    );
  }
}

