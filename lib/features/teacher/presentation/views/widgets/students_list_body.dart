import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/features/teacher/data/models/teacher_class_model.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/student_list_item.dart';

class StudentsListBody extends StatelessWidget {
  final List<TeacherStudentModel> students;

  const StudentsListBody({super.key, this.students = const []});

  @override
  Widget build(BuildContext context) {
    final hasStudents = students.isNotEmpty;

    return Container(
      color: AppColors.backgroundColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ENROLLED STUDENTS (${students.length})',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey,
                    letterSpacing: 1.2,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.filter_list, size: 18, color: AppColors.primaryColor),
                  label: Text(
                    'Filter',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: hasStudents
                ? ListView.separated(
                    itemCount: students.length,
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                      color: Color(0xffE2E8F0),
                    ),
                    itemBuilder: (context, index) {
                      final student = students[index];
                      return StudentListItem(
                        name: student.fullName.isNotEmpty
                            ? student.fullName
                            : 'Unknown',
                        id: student.oid,
                        isOnline: false,
                        avatarColor: const Color(0xFFFDE68A),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'No students found for this class.',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
