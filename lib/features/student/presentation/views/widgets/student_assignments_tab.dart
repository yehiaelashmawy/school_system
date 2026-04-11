import 'package:flutter/material.dart';
import 'package:school_system/features/student/presentation/views/widgets/student_assignment_item_card.dart';
import 'package:school_system/features/student/presentation/views/student_assignment_details_view.dart';

class StudentAssignmentsTab extends StatelessWidget {
  const StudentAssignmentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StudentAssignmentItemCard(
          status: AssignmentStatus.graded,
          title: 'Differential Equations: First Order Basics',
          submittedDate: 'Submitted Sep 12, 2023',
          grade: '95',
          totalGrade: '100',
          feedback: 'Excellent clarity on methods.',
          onViewDetails: () {
            Navigator.pushNamed(
              context,
              StudentAssignmentDetailsView.routeName,
              arguments: StudentAssignmentDetailsArgs(
                subjectName: 'MATHEMATICS',
                title: 'Differential Equations: First Order Basics',
                dueTime: '11:59 PM',
                points: '100',
                dateDay: '12',
                dateMonth: 'SEP',
                description:
                    'This assignment focuses on the application of first-order differential equations. Please ensure you show all steps.',
                teacherName: 'Prof. Sarah Jenkins',
                teacherInstructions:
                    'Remember to check the supplementary PDF for the vector field visualization.',
              ),
            );
          },
          onSecondaryAction: () {},
        ),
        StudentAssignmentItemCard(
          status: AssignmentStatus.notSubmitted,
          title: 'Linear Transformations & Vector Spaces',
          submittedDate: 'Due in 2 days (Oct 24)',
          isDueSoon: true,
          description:
              'Analyze the properties of linear transformations in R3 and provide three real...',
          onViewDetails: () {
            Navigator.pushNamed(
              context,
              StudentAssignmentDetailsView.routeName,
              arguments: StudentAssignmentDetailsArgs(
                subjectName: 'MATHEMATICS',
                title: 'Advanced Calculus: Partial Derivatives',
                dueTime: '11:59 PM',
                points: '100',
                dateDay: '24',
                dateMonth: 'OCT',
                description:
                    'This assignment focuses on the application of partial derivatives in multi-variable functions. Please ensure you show all steps for solving the optimization problems. We are looking for clear logical progression and correct use of the Chain Rule for partials.',
                teacherName: 'Prof. Sarah Jenkins',
                teacherInstructions:
                    'Remember to check the supplementary PDF for the gradient vector visualization. It will help with problem 4.',
              ),
            );
          },
          onSecondaryAction: () {},
          onSubmitWork: () {
            Navigator.pushNamed(
              context,
              StudentAssignmentDetailsView.routeName,
              arguments: StudentAssignmentDetailsArgs(
                subjectName: 'MATHEMATICS',
                title: 'Advanced Calculus: Partial Derivatives',
                dueTime: '11:59 PM',
                points: '100',
                dateDay: '24',
                dateMonth: 'OCT',
                description:
                    'This assignment focuses on the application of partial derivatives in multi-variable functions. Please ensure you show all steps for solving the optimization problems. We are looking for clear logical progression and correct use of the Chain Rule for partials.',
                teacherName: 'Prof. Sarah Jenkins',
                teacherInstructions:
                    'Remember to check the supplementary PDF for the gradient vector visualization. It will help with problem 4.',
              ),
            );
          },
        ),
        StudentAssignmentItemCard(
          status: AssignmentStatus.pendingReview,
          title: 'Midterm Review: Integration Techniques',
          submittedDate: 'Submitted Oct 18, 2023',
          filename: 'integration_review_final.pdf',
          onViewDetails: () {
            Navigator.pushNamed(
              context,
              StudentAssignmentDetailsView.routeName,
              arguments: StudentAssignmentDetailsArgs(
                subjectName: 'MATHEMATICS',
                title: 'Midterm Review: Integration Techniques',
                dueTime: '11:59 PM',
                points: '100',
                dateDay: '18',
                dateMonth: 'OCT',
                description:
                    'Review assignment for integration techniques including integration by parts, partial fractions, and trigonometric substitution.',
                teacherName: 'Prof. Sarah Jenkins',
                teacherInstructions:
                    'Make sure your constants of integration are included on all final answers.',
              ),
            );
          },
          onSecondaryAction: () {},
        ),
      ],
    );
  }
}
