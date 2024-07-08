import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dynamicSchemeVariantProvider = StateProvider<DynamicSchemeVariant>((ref) {
  return DynamicSchemeVariant.tonalSpot;
});
