// Mocks generated by Mockito 5.4.2 from annotations
// in siakad_sma_al_fusha/test/features/evaluation/data/repositories/evaluation_repositories_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:siakad_sma_al_fusha/features/evaluation/data/datasources/evaluation_local_data_source.dart'
    as _i3;
import 'package:siakad_sma_al_fusha/features/evaluation/data/datasources/evaluation_remote_datasource.dart'
    as _i2;
import 'package:siakad_sma_al_fusha/features/evaluation/data/models/class_model.dart'
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

/// A class which mocks [EvaluationRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockEvaluationRemoteDataSource extends _i1.Mock
    implements _i2.EvaluationRemoteDataSource {}

/// A class which mocks [EvaluationLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockEvaluationLocalDataSource extends _i1.Mock
    implements _i3.EvaluationLocalDataSource {
  @override
  _i4.Future<void>? cachedKelas(_i5.ClassModel? classModel) =>
      (super.noSuchMethod(
        Invocation.method(
          #cachedKelas,
          [classModel],
        ),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>?);
}
