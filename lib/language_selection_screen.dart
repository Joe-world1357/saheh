import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguage = 'English';

  final List<Map<String, dynamic>> _languages = [
    {
      'name': 'English',
      'code': 'en',
      'flag': '🇺🇸',
    },
    {
      'name': 'Spanish',
      'code': 'es',
      'flag': '🇪🇸',
    },
    {
      'name': 'French',
      'code': 'fr',
      'flag': '🇫🇷',
    },
    {
      'name': 'German',
      'code': 'de',
      'flag': '🇩🇪',
    },
    {
      'name': 'Italian',
      'code': 'it',
      'flag': '🇮🇹',
    },
    {
      'name': 'Portuguese',
      'code': 'pt',
      'flag': '🇵🇹',
    },
    {
      'name': 'Arabic',
      'code': 'ar',
      'flag': '🇸🇦',
    },
    {
      'name': 'Chinese',
      'code': 'zh',
      'flag': '🇨🇳',
    },
    {
      'name': 'Japanese',
      'code': 'ja',
      'flag': '🇯🇵',
    },
    {
      'name': 'Korean',
      'code': 'ko',
      'flag': '🇰🇷',
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
                      "Language",
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
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _languages.length,
                itemBuilder: (context, index) {
                  final language = _languages[index];
                  final isSelected = _selectedLanguage == language['name'];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedLanguage = language['name'] as String;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Language changed to ${language['name']}'),
                            backgroundColor: primary,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? primary
                                : Colors.grey.shade200,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              language['flag'] as String,
                              style: const TextStyle(fontSize: 32),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                language['name'] as String,
                                style: TextStyle(
                                  color: const Color(0xFF1A2A2C),
                                  fontSize: 16,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check_circle,
                                color: Color(0xFF20C6B7),
                              ),
                          ],
                        ),
                      ),
                    ),
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

