import 'dart:async';

import 'package:flutter/material.dart';

class PerformanceManager {
  static const int maxVisibleNodes = 100;
  static const double nodeHeight = 80.0;

  // Implementación de virtualización para listas grandes
  static List<T> virtualizeList<T>({
    required List<T> items,
    required ScrollController scrollController,
    required double itemHeight,
    required double viewportHeight,
  }) {
    if (items.length <= maxVisibleNodes) return items;

    final scrollOffset = scrollController.hasClients
        ? scrollController.offset
        : 0.0;

    final firstVisibleIndex = (scrollOffset / itemHeight).floor();
    final lastVisibleIndex = ((scrollOffset + viewportHeight) / itemHeight).ceil();

    final startIndex = (firstVisibleIndex - 10).clamp(0, items.length);
    final endIndex = (lastVisibleIndex + 10).clamp(0, items.length);

    return items.sublist(startIndex, endIndex);
  }

  // Debouncer para búsqueda
  static void debounce({
    required String id,
    required Duration duration,
    required VoidCallback action,
  }) {
    _timers[id]?.cancel();
    _timers[id] = Timer(duration, action);
  }

  static final Map<String, Timer> _timers = {};

  // Cacheo de cálculos costosos
  static final Map<String, dynamic> _cache = {};

  static T cached<T>(String key, T Function() compute) {
    if (_cache.containsKey(key)) {
      return _cache[key] as T;
    }
    final result = compute();
    _cache[key] = result;
    return result;
  }

  static void clearCache() {
    _cache.clear();
  }
}