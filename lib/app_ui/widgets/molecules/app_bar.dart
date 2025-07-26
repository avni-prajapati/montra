// import 'package:flutter/material.dart';
// import 'package:montra_clone/app_ui/widgets/atoms/spacing.dart';
// import 'package:montra_clone/app_ui/widgets/atoms/text.dart';
//
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBar({
//     super.key,
//     this.title,
//     this.titleColor,
//     this.actions,
//     this.backgroundColor,
//     this.leading,
//     this.bottom,
//     this.automaticallyImplyLeading = false,
//     this.scrolledUnderElevation = 0,
//   });
//
//   final String? title;
//   final List<Widget>? actions;
//   final Color? backgroundColor;
//   final Color? titleColor;
//   final Widget? leading;
//   final bool automaticallyImplyLeading;
//   final double scrolledUnderElevation;
//   final PreferredSizeWidget? bottom;
//
//   @override
//   Widget build(BuildContext context) => AppBar(
//         automaticallyImplyLeading: automaticallyImplyLeading,
//         bottom: bottom,
//         title: Row(
//           children: [
//             HSpace.medium20(),
//             if (leading != null) leading!,
//             if (title != null) ...[
//               HSpace.xsmall8(),
//               AppText.base(text: title, color: titleColor),
//             ],
//           ],
//         ),
//         actions: actions,
//         titleSpacing: 0,
//         scrolledUnderElevation: scrolledUnderElevation,
//         backgroundColor: backgroundColor ?? context.colorScheme.white,
//       );
//
//   /// Height is set to 64 constant because we've to match values same as the Figma
//   @override
//   Size get preferredSize => const Size.fromHeight(64);
// }
