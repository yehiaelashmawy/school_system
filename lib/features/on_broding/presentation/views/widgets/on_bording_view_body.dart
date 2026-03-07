import 'package:flutter/material.dart';
import 'package:school_system/features/on_broding/presentation/views/widgets/on_boarding_header.dart';
import 'package:school_system/features/on_broding/presentation/views/widgets/on_boarding_page_view.dart';
import 'package:school_system/features/on_broding/presentation/views/widgets/on_bording_footer.dart';
import 'package:school_system/features/on_broding/presentation/views/widgets/onberding_page_model.dart';

class OnBordingViewBody extends StatefulWidget {
  const OnBordingViewBody({super.key});

  @override
  State<OnBordingViewBody> createState() => _OnBordingViewBodyState();
}

class _OnBordingViewBodyState extends State<OnBordingViewBody> {
  late PageController pageController;
  int currentIndex = 0;

  final List<OnBoardingPageModel> pages = [
    OnBoardingPageModel(
      title: 'Manage school activities easily',
      description:
          'Organize your classes, schedules, and student activities in one place.',
      image: 'assets/images/onboarding_bage_1.png',
      hasImagePadding: true,
    ),
    OnBoardingPageModel(
      title: 'Track attendance and grades',
      description:
          'Monitor student performance with real-time analytics and detailed progress reports at your fingertips.',
      image: 'assets/images/onboarding_bage_2.png',
      hasImagePadding: true,
    ),
    OnBoardingPageModel(
      title: 'Learn smarter with SmartTutor AI',
      description:
          'Experience the power of personalized learning guided by advanced artificial intelligence designed to adapt to your unique pace.',
      image: 'assets/images/onboarding_bage_3.png',
      headerTitle: 'SmartTutor AI',
      hasImagePadding: false,
    ),
  ];

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            OnBoardingHeader(
              currentIndex: currentIndex,
              pageController: pageController,
              headerTitle: pages[currentIndex].headerTitle,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: OnBoardingPageView(
                pageController: pageController,
                pages: pages,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
            OnBoardingFooter(
              currentIndex: currentIndex,
              pageController: pageController,
              pagesCount: pages.length,
            ),
          ],
        ),
      ),
    );
  }
}
