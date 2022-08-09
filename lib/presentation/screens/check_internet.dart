// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../logic/bloc/Internetbloc/internet_bloc.dart';

// class CheckInternet extends StatelessWidget {
//   const CheckInternet({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<InternetBloc, InternetState>(
//       listener: (context, state) {
//         if (state is InternetConnectedState) {
//           // Navigator.of(context).popUntil((route) => route.isFirst);
//           Navigator.of(context).pushReplacementNamed('/homescreen');
          
//         } 
//       },
//       child: BlocBuilder<InternetBloc, InternetState>(
//         builder: (context, state) {
//           return const Scaffold(
//             body:  Center(child: CircularProgressIndicator()),
//           );
//         },
//       ),
//     );
//   }
// }
