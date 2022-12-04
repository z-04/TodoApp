// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Flutter App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.

    //login screen
    final usernameField = find.byValueKey('username');
    final passwordField = find.byValueKey('password');
    final signInButton = find.byValueKey('signIn');
    final createAccountButton = find.byValueKey('createAccount');

    //home screen
    final signOutButton = find.byValueKey('signOut');

    FlutterDriver driver;

    Future<bool> isPresent(SerializableFinder byValueKey,
        {Duration timeout = const Duration(seconds: 1)}) async {
      try {
        await driver.waitFor(byValueKey, timeout: timeout);
        return true;
      } catch (exception) {
        return false;
      }
    }

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('create account', () async {
      if (await isPresent(signOutButton)) {
        await driver.tap(signOutButton);
      }

      await driver.tap(usernameField);
      await driver.enterText("example@gmail.com");

      await driver.tap(passwordField);
      await driver.enterText("123ABC");

      await driver.tap(createAccountButton);
      await driver.waitFor(find.text("Your Todos"));
    });

    test('login', () async {
      if (await isPresent(signOutButton)) {
        await driver.tap(signOutButton);
      }

      await driver.tap(usernameField);
      await driver.enterText("example@gmail.com");

      await driver.tap(passwordField);
      await driver.enterText("123ABC");

      await driver.tap(signInButton);
      await driver.waitFor(find.text("Your Todos"));
    });
  });
}
