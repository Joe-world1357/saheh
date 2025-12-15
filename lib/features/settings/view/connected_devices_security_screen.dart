import 'package:flutter/material.dart';

class ConnectedDevicesSecurityScreen extends StatefulWidget {
  const ConnectedDevicesSecurityScreen({super.key});

  @override
  State<ConnectedDevicesSecurityScreen> createState() => _ConnectedDevicesSecurityScreenState();
}

class _ConnectedDevicesSecurityScreenState extends State<ConnectedDevicesSecurityScreen> {
  final List<Map<String, dynamic>> _devices = [
    {
      'name': 'iPhone 14 Pro',
      'type': 'Mobile Device',
      'location': 'New York, USA',
      'lastActive': '2 hours ago',
      'isCurrent': true,
      'icon': Icons.phone_iphone,
      'color': const Color(0xFF2196F3),
    },
    {
      'name': 'iPad Air',
      'type': 'Tablet',
      'location': 'New York, USA',
      'lastActive': '1 day ago',
      'isCurrent': false,
      'icon': Icons.tablet,
      'color': const Color(0xFF9C27B0),
    },
    {
      'name': 'MacBook Pro',
      'type': 'Computer',
      'location': 'New York, USA',
      'lastActive': '3 days ago',
      'isCurrent': false,
      'icon': Icons.laptop,
      'color': const Color(0xFF607D8B),
    },
    {
      'name': 'Samsung Galaxy S23',
      'type': 'Mobile Device',
      'location': 'Los Angeles, USA',
      'lastActive': '1 week ago',
      'isCurrent': false,
      'icon': Icons.phone_android,
      'color': const Color(0xFF4CAF50),
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
                      "Connected Devices",
                      style: TextStyle(
                        color: Color(0xFF1A2A2C),
                        fontSize: 20,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // INFO CARD
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF2196F3).withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFF2196F3),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.security,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "Manage devices that have access to your account. Sign out from devices you no longer use.",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // DEVICES LIST
                    const Text(
                      "Active Devices",
                      style: TextStyle(
                        color: Color(0xFF1A2A2C),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    ..._devices.map((device) => Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: device['isCurrent'] as bool
                                  ? primary
                                  : Colors.grey.shade200,
                              width: device['isCurrent'] as bool ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
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
                                        Row(
                                          children: [
                                            Text(
                                              device['name'] as String,
                                              style: const TextStyle(
                                                color: Color(0xFF1A2A2C),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            if (device['isCurrent'] as bool) ...[
                                              const SizedBox(width: 8),
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: primary.withOpacity(0.1),
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: const Text(
                                                  "Current",
                                                  style: TextStyle(
                                                    color: Color(0xFF20C6B7),
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ],
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
                                  if (!(device['isCurrent'] as bool))
                                    IconButton(
                                      icon: const Icon(
                                        Icons.more_vert,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        _showDeviceOptions(context, device);
                                      },
                                    ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    device['location'] as String,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.access_time,
                                    size: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    device['lastActive'] as String,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),

                    const SizedBox(height: 24),

                    // SIGN OUT ALL BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          _showSignOutAllDialog(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          "Sign Out All Other Devices",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

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

  void _showDeviceOptions(BuildContext context, Map<String, dynamic> device) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Device Details'),
              onTap: () {
                Navigator.pop(context);
                // Show device details
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Sign Out', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _signOutDevice(device);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _signOutDevice(Map<String, dynamic> device) {
    setState(() {
      _devices.remove(device);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Signed out from ${device['name']}'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
    );
  }

  void _showSignOutAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out All Devices?'),
        content: const Text(
          'This will sign you out from all devices except this one. You\'ll need to sign in again on those devices.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _devices.removeWhere((device) => !(device['isCurrent'] as bool));
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Signed out from all other devices'),
                  backgroundColor: Color(0xFF4CAF50),
                ),
              );
            },
            child: const Text(
              'Sign Out All',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

