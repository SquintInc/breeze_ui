clean:
    dart run build_runner clean

get:
    flutter pub get

format:
    dart format $(find lib -name "*.dart" -not \( -name "*.*freezed.dart" -o -name "*.*g.dart" -o -name "*generated.dart" \) )

lint: format
    dart analyze --fatal-infos --fatal-warnings
