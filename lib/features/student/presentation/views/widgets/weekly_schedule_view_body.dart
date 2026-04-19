import 'package:flutter/material.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/core/helper/shared_prefs_helper.dart';
import 'package:school_system/features/student/data/models/weekly_schedule_models.dart';
import 'package:school_system/features/student/presentation/views/widgets/weekly_schedule_header.dart';
import 'package:school_system/features/student/presentation/views/widgets/weekly_days_selector.dart';
import 'package:school_system/features/student/presentation/views/widgets/daily_curriculum_section.dart';

class WeeklyScheduleViewBody extends StatefulWidget {
  const WeeklyScheduleViewBody({super.key});

  @override
  State<WeeklyScheduleViewBody> createState() => _WeeklyScheduleViewBodyState();
}

class _WeeklyScheduleViewBodyState extends State<WeeklyScheduleViewBody> {
  int _selectedDayIndex = 0;
  late DateTime _currentStartDate;
  late int _currentWeekNumber;
  final ApiService _apiService = ApiService();
  Map<String, List<dynamic>> _weeklySchedule = {};
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _currentStartDate = _mondayOfWeek(DateTime.now());
    _currentWeekNumber = _weekNumber(DateTime.now());
    final todayIndex = DateTime.now().weekday - 1;
    _selectedDayIndex = todayIndex.clamp(0, 4);
    _loadWeeklySchedule();
  }

  void _changeWeek(int days) {
    setState(() {
      _currentStartDate = _currentStartDate.add(Duration(days: days));
      _currentWeekNumber = _weekNumber(_currentStartDate);
      _selectedDayIndex = 0; // Reset selection to first day (Monday)
    });
  }

  Future<void> _loadWeeklySchedule() async {
    final teacherId = (SharedPrefsHelper.teacherOid?.trim().isNotEmpty ?? false)
        ? SharedPrefsHelper.teacherOid!.trim()
        : (SharedPrefsHelper.userId ?? '').trim();

    if (teacherId.isEmpty) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Teacher id is missing. Please login again.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await _apiService.get('/api/Timetable/teacher/$teacherId');
      final data = response['data'] as Map<String, dynamic>? ?? {};
      final scheduleMap = data['weeklySchedule'] as Map<dynamic, dynamic>? ?? {};

      setState(() {
        _weeklySchedule = {
          for (final entry in scheduleMap.entries)
            if (entry.key != null)
              entry.key.toString(): (entry.value is List)
                  ? (entry.value as List).where((e) => e != null).toList()
                  : <dynamic>[],
        };
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  DateTime _mondayOfWeek(DateTime date) {
    return DateTime(date.year, date.month, date.day).subtract(
      Duration(days: date.weekday - DateTime.monday),
    );
  }

  int _weekNumber(DateTime date) {
    final firstDay = DateTime(date.year, 1, 1);
    final dayOfYear = date.difference(firstDay).inDays + 1;
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  String _getFullMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  String _getDayNameShort(int weekday) {
    const days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    return days[weekday - 1];
  }

  String _getHeaderDateRange() {
    final endDate = _currentStartDate.add(const Duration(days: 4)); // Friday
    return '${_getMonthName(_currentStartDate.month)} ${_currentStartDate.day} - ${_getMonthName(endDate.month)} ${endDate.day},\n${endDate.year}';
  }

  String _getSelectedDateString() {
    final selectedDate = _currentStartDate.add(
      Duration(days: _selectedDayIndex),
    );
    return '${_getFullMonthName(selectedDate.month)} ${selectedDate.day.toString().padLeft(2, '0')}'
        .toUpperCase();
  }

  List<ScheduleDay> _generateDays() {
    final List<ScheduleDay> days = [];
    for (int i = 0; i < 5; i++) {
      final date = _currentStartDate.add(Duration(days: i));
      final dayKey = _dayKeyFromDate(date);
      final count = _weeklySchedule[dayKey]?.length ?? 0;
      days.add(
        ScheduleDay(
          dayName: _getDayNameShort(date.weekday),
          dayNumber: date.day.toString(),
          classCount: count,
        ),
      );
    }
    return days;
  }

  String _dayKeyFromDate(DateTime date) {
    switch (date.weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return 'Monday';
    }
  }

  List<CurriculumItem> _curriculumForSelectedDay() {
    final selectedDate = _currentStartDate.add(Duration(days: _selectedDayIndex));
    final selectedKey = _dayKeyFromDate(selectedDate);
    final selectedClasses = _weeklySchedule[selectedKey] ?? [];

    return selectedClasses.whereType<Map>().map((raw) {
      final item = raw.cast<String, dynamic>();
      final startTime = (item['startTime'] ?? '').toString();
      final endTime = (item['endTime'] ?? '').toString();
      final room = (item['room'] ?? '').toString();
      final teacher = (item['teacherName'] ?? '').toString();
      final className = (item['className'] ?? '').toString();

      return CurriculumItem(
        startTime: startTime,
        endTime: endTime,
        title: (item['subjectName'] ?? '').toString(),
        subtitle: '$room • $className • $teacher',
        type: 'REQUIRED',
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            _errorMessage!,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final generatedDays = _generateDays();
    final curriculumItems = _curriculumForSelectedDay();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WeeklyScheduleHeader(
            dateRangeText: _getHeaderDateRange(),
            weekText: 'Spring Semester • Week $_currentWeekNumber',
            onPreviousWeek: () => _changeWeek(-7),
            onNextWeek: () => _changeWeek(7),
          ),
          const SizedBox(height: 24),
          WeeklyDaysSelector(
            days: generatedDays,
            selectedIndex: _selectedDayIndex,
            onDaySelected: (index) {
              setState(() {
                _selectedDayIndex = index;
              });
            },
          ),
          const SizedBox(height: 32),
          DailyCurriculumSection(
            dateString: _getSelectedDateString(),
            items: curriculumItems,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
