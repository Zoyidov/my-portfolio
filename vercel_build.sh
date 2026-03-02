#!/bin/bash
set -e

# Flutter SDK
git clone https://github.com/flutter/flutter.git -b stable --depth 1
export PATH="$PATH:$(pwd)/flutter/bin"

flutter --version
flutter config --enable-web

flutter pub get
flutter build web --release