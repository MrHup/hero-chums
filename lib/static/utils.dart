import 'dart:math';

String generateRandomString(int len) {
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

String getSpecificString(int complexity) {
  if (complexity == 1) {
    return "Simple";
  } else if (complexity == 2) {
    return "Average";
  } else if (complexity >= 3) {
    return "Difficult";
  }

  return "Normal";
}
