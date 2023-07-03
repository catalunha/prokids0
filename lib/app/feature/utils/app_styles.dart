class AppStyles {
  static AppStyles? _instance;
  AppStyles._();
  static AppStyles get instance {
    _instance ??= AppStyles._();
    return _instance!;
  }

  // ButtonStyle get elevatedButton => ElevatedButton.styleFrom(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       backgroundColor: AppColors.instance.colorPrimary,
  //       textStyle: AppTextStyle.instance.aleo20Bold.copyWith(
  //         color: AppColors.instance.colorBlack,
  //       ),
  //       foregroundColor: AppColors.instance.colorBlack,
  //     );
}

// extension AppStyleExtension on BuildContext {
//   AppStyles get appStyles => AppStyles.instance;
// }
