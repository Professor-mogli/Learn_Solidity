class AttendanceRecord {
  final String memberId;
  final String memberName;
  final DateTime date;
  final DateTime checkInTime;

  const AttendanceRecord({
    required this.memberId,
    required this.memberName,
    required this.date,
    required this.checkInTime,
  });
}
