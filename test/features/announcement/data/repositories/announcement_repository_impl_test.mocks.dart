// Mocks generated by Mockito 5.4.2 from annotations
// in siakad_sma_al_fusha/test/features/announcement/data/repositories/announcement_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:siakad_sma_al_fusha/features/announcement/data/datasources/announcement_local_datasource.dart'
    as _i3;
import 'package:siakad_sma_al_fusha/features/announcement/data/datasources/announcement_remote_datasource.dart'
    as _i2;
import 'package:siakad_sma_al_fusha/features/announcement/data/models/announcement_model.dart'
    as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [AnnouncementRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockAnnouncementRemoteDataSource extends _i1.Mock
    implements _i2.AnnouncementRemoteDataSource {}

/// A class which mocks [AnnouncementLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockAnnouncementLocalDataSource extends _i1.Mock
    implements _i3.AnnouncementLocalDataSource {
  @override
  _i4.Future<void>? cachedAnnouncement(_i5.AnnouncementModel? announcement) =>
      (super.noSuchMethod(
        Invocation.method(
          #cachedAnnouncement,
          [announcement],
        ),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>?);
}
