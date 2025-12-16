import 'package:flutter/material.dart';
import 'drug_details.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  bool _isScanning = false;
  String? _scannedCode;

  // Simulated product database based on barcode
  final Map<String, Map<String, dynamic>> _barcodeDatabase = {
    '1234567890123': {
      'name': 'Panadol',
      'size': '20pcs',
      'price': 15.99,
    },
    '2345678901234': {
      'name': 'Bodrex Herbal',
      'size': '100ml',
      'price': 7.99,
    },
    '3456789012345': {
      'name': 'OBH Combi',
      'size': '75ml',
      'price': 9.99,
    },
  };

  void _startScanning() {
    setState(() {
      _isScanning = true;
      _scannedCode = null;
    });

    // Simulate scanning after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        // Simulate finding a barcode
        final testBarcode = '1234567890123';
        setState(() {
          _isScanning = false;
          _scannedCode = testBarcode;
        });
      }
    });
  }

  void _handleScannedCode(String barcode) {
    if (_barcodeDatabase.containsKey(barcode)) {
      final product = _barcodeDatabase[barcode]!;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DrugDetails(
            imageUrl: "",
            name: product['name'] as String,
            size: product['size'] as String,
            price: product['price'] as double,
          ),
        ),
      );
    } else {
      // Show error for unknown barcode
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Product Not Found'),
          content: Text(
            'The scanned barcode "$barcode" is not in our database.\n\nPlease try scanning again or search for the product manually.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _scannedCode = null;
                });
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF20C6B7);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // TOP BAR
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              color: Colors.black,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "Scan Barcode",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // SCANNER AREA
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Scanner overlay
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: CustomPaint(
                      painter: ScannerOverlayPainter(),
                      child: Container(),
                    ),
                  ),

                  // Scanning animation
                  if (_isScanning)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: primary,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              // Animated scanning line
                              TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0.0, end: 1.0),
                                duration: const Duration(seconds: 2),
                                builder: (context, value, child) {
                                  return Positioned(
                                    top: value * 200 - 2,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 4,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            primary.withOpacity(0.0),
                                            primary,
                                            primary.withOpacity(0.0),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "Scanning...",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Position the barcode within the frame",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                  // Scanned result
                  if (_scannedCode != null && !_isScanning)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 48,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "Barcode Scanned!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Code: $_scannedCode",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () {
                            _handleScannedCode(_scannedCode!);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                          ),
                          child: const Text(
                            "View Product",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _scannedCode = null;
                            });
                          },
                          child: const Text(
                            "Scan Again",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),

                  // Initial state
                  if (_scannedCode == null && !_isScanning)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Icons.qr_code_scanner,
                            size: 80,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "Ready to Scan",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Position the barcode within the frame",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                ],
              ),
            ),

            // BOTTOM CONTROLS
            Container(
              padding: const EdgeInsets.all(24),
              color: Colors.black,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isScanning ? null : _startScanning,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        _isScanning ? "Scanning..." : "Start Scanning",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      // Manual entry option
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Enter Barcode Manually'),
                          content: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Enter barcode number',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            onSubmitted: (value) {
                              Navigator.pop(context);
                              if (value.isNotEmpty) {
                                _handleScannedCode(value);
                              }
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Handle manual entry
                                Navigator.pop(context);
                              },
                              child: const Text('Search'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text(
                      "Enter Barcode Manually",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final frameSize = 200.0;

    // Draw frame
    final frameRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(centerX, centerY),
        width: frameSize,
        height: frameSize,
      ),
      const Radius.circular(16),
    );

    canvas.drawRRect(frameRect, paint);

    // Draw corner indicators
    final cornerLength = 20.0;
    final cornerWidth = 3.0;
    final cornerPaint = Paint()
      ..color = const Color(0xFF20C6B7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = cornerWidth;

    // Top-left
    canvas.drawLine(
      Offset(centerX - frameSize / 2, centerY - frameSize / 2),
      Offset(centerX - frameSize / 2 + cornerLength, centerY - frameSize / 2),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(centerX - frameSize / 2, centerY - frameSize / 2),
      Offset(centerX - frameSize / 2, centerY - frameSize / 2 + cornerLength),
      cornerPaint,
    );

    // Top-right
    canvas.drawLine(
      Offset(centerX + frameSize / 2, centerY - frameSize / 2),
      Offset(centerX + frameSize / 2 - cornerLength, centerY - frameSize / 2),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(centerX + frameSize / 2, centerY - frameSize / 2),
      Offset(centerX + frameSize / 2, centerY - frameSize / 2 + cornerLength),
      cornerPaint,
    );

    // Bottom-left
    canvas.drawLine(
      Offset(centerX - frameSize / 2, centerY + frameSize / 2),
      Offset(centerX - frameSize / 2 + cornerLength, centerY + frameSize / 2),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(centerX - frameSize / 2, centerY + frameSize / 2),
      Offset(centerX - frameSize / 2, centerY + frameSize / 2 - cornerLength),
      cornerPaint,
    );

    // Bottom-right
    canvas.drawLine(
      Offset(centerX + frameSize / 2, centerY + frameSize / 2),
      Offset(centerX + frameSize / 2 - cornerLength, centerY + frameSize / 2),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(centerX + frameSize / 2, centerY + frameSize / 2),
      Offset(centerX + frameSize / 2, centerY + frameSize / 2 - cornerLength),
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


