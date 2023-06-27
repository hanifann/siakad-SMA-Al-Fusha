// Mocks generated by Mockito 5.4.2 from annotations
// in siakad_sma_al_fusha/test/features/nilai/data/repositories/nilai_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:siakad_sma_al_fusha/features/student/score_student/data/datasources/nilai_local_datasource.dart'
    as _i5;
import 'package:siakad_sma_al_fusha/features/student/score_student/data/datasources/nilai_remote_datasource.dart'
    as _i2;
import 'package:siakad_sma_al_fusha/features/student/score_student/data/models/nilai_model.dart'
    as _i4;

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

/// A class which mocks [NilaiRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockNilaiRemoteDataSource extends _i1.Mock
    implements _i2.NilaiRemoteDataSource {
  @override
  _i3.Future<_i4.NilaiModel>? getNilai(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getNilai,
          [id],
        ),
        returnValueForMissingStub: null,
      ) as _i3.Future<_i4.NilaiModel>?);
}

/// A class which mocks [NilaiLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockNilaiLocalDataSource extends _i1.Mock
    implements _i5.NilaiLocalDataSource {
  @override
  _i3.Future<void>? cachedNilai(_i4.NilaiModel? nilai) => (super.noSuchMethod(
        Invocation.method(
          #cachedNilai,
          [nilai],
        ),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>?);
}
