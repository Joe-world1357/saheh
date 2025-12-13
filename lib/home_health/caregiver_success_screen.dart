import 'package:flutter/material.dart';

class CaregiverSuccessScreen
    extends
        StatelessWidget {
  const CaregiverSuccessScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(
        0.5,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          padding: const EdgeInsets.all(
            32,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(
                    0xFF20C6B7,
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Color(
                    0xFF1A2A2C,
                  ),
                  size: 50,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                "Requested Successfully",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(
                    0xFF1A2A2C,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "Your request has been successful, you can wait for the Caregiver to contact you through your email",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                  height: 1.5,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate back to Home or Dashboard based on "Back to Home" text
                    // Similar logic to previous screens, assuming pop for now or until root
                    Navigator.of(
                      context,
                    ).popUntil(
                      (
                        route,
                      ) => route.isFirst,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFF20C6B7,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Back to Home",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
