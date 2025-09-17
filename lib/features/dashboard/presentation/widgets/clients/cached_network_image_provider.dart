import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CachedNetworkImageProvider extends ImageProvider<CachedNetworkImageProvider> {
  final String url;

  const CachedNetworkImageProvider(this.url);

  @override
  Future<CachedNetworkImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<CachedNetworkImageProvider>(this);
  }

  @override
  ImageStreamCompleter loadImage(CachedNetworkImageProvider key, ImageDecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, decode),
      scale: 1.0,
    );
  }

  Future<ui.Codec> _loadAsync(CachedNetworkImageProvider key, ImageDecoderCallback decode) async {
    // Implementación simplificada - usar cached_network_image en producción
    final Uri resolved = Uri.base.resolve(key.url);
    final HttpClientRequest request = await HttpClient().getUrl(resolved);
    final HttpClientResponse response = await request.close();
    final Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    
    // Convertir Uint8List a ImmutableBuffer
    final ui.ImmutableBuffer buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
    return decode(buffer);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is CachedNetworkImageProvider && other.url == url;
  }

  @override
  int get hashCode => url.hashCode;

  @override
  String toString() => '${objectRuntimeType(this, 'CachedNetworkImageProvider')}("$url")';
}
