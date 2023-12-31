// Mocks generated by Mockito 5.4.2 from annotations
// in siakad_sma_al_fusha/test/features/schedule/data/repositories/schedule_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:siakad_sma_al_fusha/features/schedule/data/datasources/schedule_remote_data_source.dart'
    as _i2;
import 'package:siakad_sma_al_fusha/features/schedule/data/models/schedule_model.dart'
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

/// A class which mocks [ScheduleRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockScheduleRemoteDataSource extends _i1.Mock
    implements _i2.ScheduleRemoteDataSource {
  @override
  _i3.Future<_i4.ScheduleModel>? getSchedule(
    String? id,
    String? day,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSchedule,
          [
            id,
            day,
          ],
        ),
        returnValueForMissingStub: null,
      ) as _i3.Future<_i4.ScheduleModel>?);
  @override
  _i3.Future<_i4.ScheduleModel>? getTeachingSchedule(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTeachingSchedule,
          [id],
        ),
        returnValueForMissingStub: null,
      ) as _i3.Future<_i4.ScheduleModel>?);
}
