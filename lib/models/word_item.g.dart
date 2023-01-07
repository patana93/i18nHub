// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_item.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

String $WordNotifierHash() => r'd8cc0bb88894ee93f4f6898fdca657d92afc1eb8';

/// See also [WordNotifier].
final wordNotifierProvider =
    AutoDisposeNotifierProvider<WordNotifier, List<WordModel>>(
  WordNotifier.new,
  name: r'wordNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : $WordNotifierHash,
);
typedef WordNotifierRef = AutoDisposeNotifierProviderRef<List<WordModel>>;

abstract class _$WordNotifier extends AutoDisposeNotifier<List<WordModel>> {
  @override
  List<WordModel> build();
}

String $WordItemFilteredNotifierHash() =>
    r'ff2ffca2a32ea3dbc0f528354d4aedd89ae52f75';

/// See also [WordItemFilteredNotifier].
final wordItemFilteredNotifierProvider =
    AutoDisposeNotifierProvider<WordItemFilteredNotifier, List<WordModel>>(
  WordItemFilteredNotifier.new,
  name: r'wordItemFilteredNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $WordItemFilteredNotifierHash,
);
typedef WordItemFilteredNotifierRef
    = AutoDisposeNotifierProviderRef<List<WordModel>>;

abstract class _$WordItemFilteredNotifier
    extends AutoDisposeNotifier<List<WordModel>> {
  @override
  List<WordModel> build();
}

String $WordItemSelectedNotifierHash() =>
    r'7d78a5496382cccc42e6d8716d3870875a530f26';

/// See also [WordItemSelectedNotifier].
final wordItemSelectedNotifierProvider =
    AutoDisposeNotifierProvider<WordItemSelectedNotifier, WordModel?>(
  WordItemSelectedNotifier.new,
  name: r'wordItemSelectedNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $WordItemSelectedNotifierHash,
);
typedef WordItemSelectedNotifierRef
    = AutoDisposeNotifierProviderRef<WordModel?>;

abstract class _$WordItemSelectedNotifier
    extends AutoDisposeNotifier<WordModel?> {
  @override
  WordModel? build();
}
