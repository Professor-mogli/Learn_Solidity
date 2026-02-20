import '../../features/attendance/domain/attendance_record.dart';

class MockDataService {
  MockDataService._();

  static final MockDataService instance = MockDataService._();

  final List<AttendanceRecord> _records = [
    AttendanceRecord(
      memberId: 'm-101',
      memberName: 'Aman Gupta',
      date: DateTime(2026, 2, 2),
      checkInTime: DateTime(2026, 2, 2, 6, 58),
    ),
    AttendanceRecord(
      memberId: 'm-101',
      memberName: 'Aman Gupta',
      date: DateTime(2026, 2, 4),
      checkInTime: DateTime(2026, 2, 4, 7, 02),
    ),
    AttendanceRecord(
      memberId: 'm-102',
      memberName: 'Neha Sharma',
      date: DateTime(2026, 2, 4),
      checkInTime: DateTime(2026, 2, 4, 7, 21),
    ),
  ];

  List<AttendanceRecord> gymAttendance(DateTime month) {
    return _records
        .where((r) => r.date.year == month.year && r.date.month == month.month)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  List<AttendanceRecord> memberAttendance(String memberId, DateTime month) {
    return gymAttendance(month).where((r) => r.memberId == memberId).toList();
  }

  int monthlyAttendanceCount(String memberId, DateTime month) {
    return memberAttendance(memberId, month).length;
  }

  DateTime? lastVisit(String memberId) {
    final list = _records.where((r) => r.memberId == memberId).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    return list.isEmpty ? null : list.first.date;
  }
}
