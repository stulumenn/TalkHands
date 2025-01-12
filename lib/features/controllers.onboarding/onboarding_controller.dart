import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:talkhands/features/screens/login/login.dart';
import 'package:get_storage/get_storage.dart';

/// OnBoardingController manages the functionality for the onboarding process.
/// It controls the page navigation, including skipping and going to the next or previous page.
/// It also stores whether the user has completed the onboarding and navigates to the login screen.
class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  /// Updates the current page index when the page indicator is clicked.
  /// - [index]: The index of the page that the user wants to navigate to.
  void updatePageIndicator(index) => currentPageIndex.value = index;

  /// Handles the action when a dot in the page indicator is clicked.
  /// - [index]: The index of the page to navigate to when a dot is clicked.
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  /// Navigates to the next page in the onboarding process.
  /// - If the user is on the last page, it marks the onboarding as completed and navigates to the login screen.
  void nextPage() {
    if (currentPageIndex.value == 2) {
      final storage = GetStorage();
      storage.write('IsFirstTime', false);

      Get.offAll(const LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  /// Skips directly to the last page of the onboarding process.
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }

  /// Navigates to the previous page in the onboarding process.
  void previousPage() {
    if (currentPageIndex.value > 0) {
      int page = currentPageIndex.value - 1;
      pageController.jumpToPage(page);
    }
  }
}
