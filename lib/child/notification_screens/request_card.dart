// import 'package:flutter/material.dart';

// class RequestCard extends StatelessWidget {
//   const RequestCard({
//     Key? key,
//     required this.name,
//     required this.imgurl,
//     required this.pressAcept,
//     required this.pressReject,
//   }) : super(key: key);

//   final String name;
//   final String imgurl;
//   final VoidCallback pressAcept;
//   final VoidCallback pressReject;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Padding(
//         padding: EdgeInsets.all(14),
//         child: Row(
//           children: [
//             Stack(
//               children: [
//                 CircleAvatar(
//                   radius: 24,
//                   backgroundImage: NetworkImage(imgurl),
//                 ),          
//               ],
//             ),
//             Expanded(
//               child: Padding(        
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       name,
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                     ),
//                     SizedBox(height: 8),
//                     Opacity(
//                       opacity: 0.64,
//                       child: Text(
//                         chatMessages.content!,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Opacity(
//               opacity: 0.64,
//               child: Text(chatMessages.created_at!.day.toString() +
//                   "/" +
//                   chatMessages.created_at!.month.toString()),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
