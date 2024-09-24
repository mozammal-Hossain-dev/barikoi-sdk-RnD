import 'package:barikoi_sdk/app/app.dart';
import 'package:barikoi_sdk/bootstrap.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load();

  await bootstrap(() => const App());
}
