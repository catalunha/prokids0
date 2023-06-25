

// class GetModuleAllowedAccess {
//   static bool consultFor(
//       List<String> officeIdListAutorized, BuildContext context) {
//     UserModel user = context.read<AuthenticationBloc>().state.user!;
//     return user.userProfile!.access!
//         .any((element) => officeIdListAutorized.contains(element));
//     // return true;
//   }
// }
