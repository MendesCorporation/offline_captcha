import 'package:flutter/material.dart';
import 'package:offline_captcha/offline_captcha.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Offline CAPTCHA Example')),
        body: const CaptchaDemo(),
      ),
    );
  }
}

class CaptchaDemo extends StatefulWidget {
  const CaptchaDemo({Key? key}) : super(key: key);

  @override
  State<CaptchaDemo> createState() => _CaptchaDemoState();
}

class _CaptchaDemoState extends State<CaptchaDemo> {
  final controller = CaptchaController(length: 6); 

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CaptchaWidget(
            controller: controller,
            theme: CaptchaTheme(
              scribbleIntensity: 2.0, 
              scribbleColors: [
                Colors.blue.withOpacity(0.6),
                Colors.red.withOpacity(0.6),
                Colors.purple.withOpacity(0.6),
                Colors.teal.withOpacity(0.6),
                Colors.orange.withOpacity(0.6),
              ],
              numberColor: Colors.black54,
              fontSize: 28, 
              boxShadow: const BoxShadow(
                blurRadius: 4,
                color: Colors.black26,
              ),
            ),
          ),
          const SizedBox(height: 20),
          CaptchaInput(
            onValidate: (input) {
              final isValid = controller.validate(input);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isValid ? 'CAPTCHA correct!' : 'CAPTCHA incorrect!'
                  ),
                ),
              );
              return isValid;
            },
            onRegenerateRequest: () {
              controller.regenerate();
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class CaptchaInput extends StatefulWidget {
  final Function(String) onValidate;
  final VoidCallback onRegenerateRequest;

  const CaptchaInput({
    Key? key,
    required this.onValidate,
    required this.onRegenerateRequest,
  }) : super(key: key);

  @override
  State<CaptchaInput> createState() => _CaptchaInputState();
}

class _CaptchaInputState extends State<CaptchaInput> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 200,
          child: TextField(
            controller: textController,
            decoration: const InputDecoration(
              labelText: 'Enter CAPTCHA',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            widget.onValidate(textController.text);
          },
          child: const Text('Validate'),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () {
            textController.clear();
            widget.onRegenerateRequest();
          },
          child: const Text('Regenerate CAPTCHA'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
