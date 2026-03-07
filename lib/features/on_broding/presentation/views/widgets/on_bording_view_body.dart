import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/on_broding/presentation/views/widgets/custom_dot_indicator.dart';
import 'package:school_system/features/on_broding/presentation/views/widgets/on_boarding_button.dart';
import 'package:school_system/features/on_broding/presentation/views/widgets/onboarding_page_item.dart';
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
      title: 'Manage school\nactivities easily',
      description:
          'Organize your classes, schedules, and\nstudent activities in one place.',
      image: 'assets/images/onboarding_bage_1.png',
    ),
    OnBoardingPageModel(
      title: 'Track attendance and\ngrades',
      description:
          'Monitor student performance with real-\ntime analytics and detailed progress\nreports at your fingertips.',
      image: 'assets/images/onboarding_bage_2.png',
    ),
    OnBoardingPageModel(
      title: 'Learn smarter with\nSmartTutor AI',
      description:
          'Experience the power of personalized\nlearning guided by advanced artificial\nintelligence designed to adapt to your unique\npace.',
      image: 'assets/images/onboarding_bage_3.png',
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 16),
            CustomSkipbutton(
              currentIndex: currentIndex,
              pageController: pageController,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnBoardingPageItem(pageModel: pages[index]);
                },
              ),
            ),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => CustomDotIndicator(isActive: index == currentIndex),
              ),
            ),
            const SizedBox(height: 75),
            OnBoardingButton(
              onPressed: () {
                if (currentIndex < 2) {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  // Navigate to Login/Home
                }
              },
              text: currentIndex == 2 ? 'Get started' : 'Next',
              showArrow: currentIndex != 2,
            ),
            const SizedBox(height: 56),
          ],
        ),
      ),
    );
  }
}

class CustomSkipbutton extends StatelessWidget {
  const CustomSkipbutton({
    super.key,
    required this.currentIndex,
    required this.pageController,
  });

  final int currentIndex;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Visibility(
        visible: currentIndex != 2,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: TextButton(
          onPressed: () {
            pageController.jumpToPage(2);
          },
          child: Text(
            'Skip',
            style: AppTextStyle.bold16.copyWith(color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
}
