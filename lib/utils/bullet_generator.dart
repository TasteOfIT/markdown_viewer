import 'package:list_counter/list_counter.dart';

final _bulletStylesUnordered = [
  PredefinedCounterStyle.disc,
  PredefinedCounterStyle.circle,
  PredefinedCounterStyle.square,
];
final _bulletStylesOrdered = [
  PredefinedCounterStyle.decimal,
  PredefinedCounterStyle.lowerLatin,
  PredefinedCounterStyle.lowerRoman,
];

String getBulletOrdered(int value, int depth) {
  return _bulletStylesOrdered[depth].generateMarkerContent(value);
}

String getBulletUnordered(int depth) {
  return _bulletStylesUnordered[depth].generateMarkerContent(0);
}
