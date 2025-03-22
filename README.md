# Offline CAPTCHA

A Flutter package for generating offline number-based CAPTCHAs with scribble effects. This package provides a customizable, secure, and visually appealing CAPTCHA solution that works across all Flutter platforms (iOS, Android, Web).

![image](https://github.com/user-attachments/assets/e17dfe58-b835-473b-93d5-51df8ab0a3d2)
![Screenshot_1742666586](https://github.com/user-attachments/assets/0673b96b-b2ac-4025-aa5e-25226e34fe81)


## Features

- ✨ Offline generation - no server required
- 🎨 Customizable appearance (colors, fonts, sizes)
- 🔒 Secure number-based verification
- 🌈 Dynamic scribble effects
- 📱 Cross-platform support
- ⚡ Optimized performance
- 🎯 Easy to integrate

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  offline_captcha: ^0.0.1
```

## Usage

Basic usage:

```dart
import 'package:offline_captcha/offline_captcha.dart';

// Create a controller
final controller = CaptchaController(length: 6);

// Add the widget
CaptchaWidget(
  controller: controller,
  theme: CaptchaTheme(
    scribbleIntensity: 2.0,
    scribbleColors: [
      Colors.blue.withOpacity(0.6),
      Colors.red.withOpacity(0.6),
      Colors.purple.withOpacity(0.6),
    ],
    numberColor: Colors.black54,
    fontSize: 28,
  ),
)

// Validate input
final isValid = controller.validate(userInput);

// Generate new CAPTCHA
controller.regenerate();
```

## Customization

The `CaptchaTheme` class provides extensive customization options:

```dart
CaptchaTheme(
  numberColor: Colors.black87,
  backgroundColor: Colors.white,
  scribbleColors: [Colors.grey, Colors.blue, Colors.red],
  fontSize: 32.0,
  scribbleIntensity: 1.0,
  fontFamily: 'Roboto',
  instructionText: 'Type the numbers you see',
  borderRadius: BorderRadius.circular(8.0),
  boxShadow: BoxShadow(
    blurRadius: 4,
    color: Colors.black26,
  ),
)
```

## Example

Check the [example](example) folder for a complete implementation.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

```
MIT License

Copyright (c) 2025 Helio

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
