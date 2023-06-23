import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({required this.errorValue, super.key, });

  final String errorValue;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        errorValue,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      actions: [
        TextButton(
          onPressed: ()=> Navigator.pop(context), 
          child: const Text('kembali'),
        )
      ],
    );
  }
}

// class LoadingDialog extends StatelessWidget {
//   const LoadingDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Column(
//         children: [
//           CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation(kPrimaryColor),
//             backgroundColor: Colors.white,
//           ),
//           const SizedBox(height: 16),
//           const Text(
//             'Loading . . .',
//             style: TextStyle(
//               fontWeight: FontWeight.w500,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
