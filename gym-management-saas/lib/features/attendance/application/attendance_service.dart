import '../domain/attendance_record.dart';

/// Service contract for attendance use-cases used by both owner and member apps.
abstract class AttendanceService {
  /// Called when gym owner scans a member QR at entry gate.
  ///
  /// Expected backend behavior:
  /// - Validate gym active
  /// - Validate member active and subscription active
  /// - Mark attendance only once per day
  /// - Return existing attendance if already marked today
  Future<AttendanceRecord> markAttendanceFromQr({
    required String gymId,
    required String qrPayload,
    required DateTime scannedAt,
  });

  /// Owner view: date-wise attendance list for own gym.
  Future<List<AttendanceRecord>> getGymAttendanceByDate({
    required String gymId,
    required DateTime date,
  });

  /// Member view: monthly history for logged-in member.
  Future<List<AttendanceRecord>> getMemberAttendanceByMonth({
    required String memberId,
    required int year,
    required int month,
  });
}
