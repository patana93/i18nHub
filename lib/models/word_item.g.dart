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

String $WordItemNotifierHash() => r'1d4e1c6e196ba04ab34808725a3398a94d093357';

/// See also [WordItemNotifier].
final wordItemNotifierProvider =
    AutoDisposeNotifierProvider<WordItemNotifier, List<WordItem>>(
  WordItemNotifier.new,
  name: r'wordItemNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $WordItemNotifierHash,
);
typedef WordItemNotifierRef = AutoDisposeNotifierProviderRef<List<WordItem>>;

abstract class _$WordItemNotifier extends AutoDisposeNotifier<List<WordItem>> {
  @override
  List<WordItem> build();
}

String $WordItemFilteredNotifierHash() =>
    r'82f2b9aaecf67dd2438c2ca2aa4f2e824e8c8149';

/// See also [WordItemFilteredNotifier].
final wordItemFilteredNotifierProvider =
    AutoDisposeNotifierProvider<WordItemFilteredNotifier, List<WordItem>>(
  WordItemFilteredNotifier.new,
  name: r'wordItemFilteredNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $WordItemFilteredNotifierHash,
);
typedef WordItemFilteredNotifierRef
    = AutoDisposeNotifierProviderRef<List<WordItem>>;

abstract class _$WordItemFilteredNotifier
    extends AutoDisposeNotifier<List<WordItem>> {
  @override
  List<WordItem> build();
}

String $WordItemSelectedNotifierHash() =>
    r'bb0b1805a9eb16fe4568f6653165c78962b75019';

/// See also [WordItemSelectedNotifier].
final wordItemSelectedNotifierProvider =
    AutoDisposeNotifierProvider<WordItemSelectedNotifier, WordItem?>(
  WordItemSelectedNotifier.new,
  name: r'wordItemSelectedNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $WordItemSelectedNotifierHash,
);
typedef WordItemSelectedNotifierRef = AutoDisposeNotifierProviderRef<WordItem?>;

abstract class _$WordItemSelectedNotifier
    extends AutoDisposeNotifier<WordItem?> {
  @override
  WordItem? build();
}
