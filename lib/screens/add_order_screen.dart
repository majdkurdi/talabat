// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/cart_controller.dart';
// import '../controllers/orders_controller.dart';
// import '../modals/location.dart';
// import '../modals/cart_item.dart';

// enum LocationStatus { NO_LOCATION, GIVEN_LOCATION, WAITING_FOR_LOCATION }

// class AddOrderScreen extends StatefulWidget {
//   @override
//   _AddOrderScreenState createState() => _AddOrderScreenState();
// }

// class _AddOrderScreenState extends State<AddOrderScreen> {
//   final cartController = Get.find<CartController>();
//   final ordersController = Get.find<OrdersController>();

//   final formKey = GlobalKey<FormState>();
//   Location? location;
//   LocationStatus locationStatus = LocationStatus.NO_LOCATION;
//   String? email;
//   String? phoneNumber;
//   bool loading = false;

//   @override
//   void dispose() {
//     cartController.dispose();
//     ordersController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final items = cartController.items;
//     final total = cartController.total;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Make Your Order'),
//       ),
//       body: Form(
//         key: formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   'Please Enter Your Information',
//                   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               MyTextField(
//                   'Enter Your Email', Icons.email, TextInputType.emailAddress,
//                   (String? val) {
//                 email = val;
//               }, (String? val) {
//                 if (val == null || !val.contains('@') || !val.contains('.'))
//                   return 'Please Provide a valid email!';
//                 else
//                   return null;
//               }),
//               MyTextField('Enter Your Phone Number', Icons.send_to_mobile,
//                   TextInputType.number, (String? val) {
//                 phoneNumber = val;
//               }, (String? val) {
//                 if (val == null || int.tryParse(val) == null || val.length < 8)
//                   return 'Please Provide a valid Phone Number';
//                 else
//                   return null;
//               }),
//               SizedBox(height: 15),
//               ListTile(
//                 leading: Icon(Icons.location_city),
//                 title: Text('Provide your Location'),
//                 trailing: ElevatedButton(
//                   child: helper[locationStatus],
//                   onPressed: () async {
//                     setState(() {
//                       locationStatus = LocationStatus.WAITING_FOR_LOCATION;
//                     });
//                     location = await LocationService().getLocation();
//                     setState(() {
//                       locationStatus = location == null
//                           ? LocationStatus.NO_LOCATION
//                           : LocationStatus.GIVEN_LOCATION;
//                     });
//                     if (location == null) {
//                       Get.snackbar('Error',
//                           'Failed to get your Location, Check your GPS settings',
//                           snackPosition: SnackPosition.BOTTOM);
//                     }
//                   },
//                   style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(Colors.black)),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ElevatedButton(
//                   style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(Colors.black)),
//                   onPressed: () async {
//                     FocusScope.of(context).unfocus();
//                     if (formKey.currentState!.validate() && location != null) {
//                       formKey.currentState!.save();
//                       setState(() {
//                         loading = true;
//                       });
//                       final response = await ordersController.addOrder(
//                           DateTime.now(),
//                           total,
//                           items,
//                           location!,
//                           email!,
//                           int.parse(phoneNumber!));
//                       if (response == 'done') {
//                         setState(() {
//                           loading = false;
//                           cartController.items.value = <CartItem>[];
//                         });
//                         Get.offAllNamed(HomeScreen.routeName);
//                         Get.snackbar('Done', 'Order added Successfully!',
//                             snackPosition: SnackPosition.BOTTOM);
//                       } else {
//                         Get.snackbar('Error!',
//                             'Something went wrong, Check your internet Connection!',
//                             snackPosition: SnackPosition.BOTTOM);
//                       }
//                     } else {
//                       Get.snackbar('Warning!', 'Check your Information!',
//                           snackPosition: SnackPosition.BOTTOM);
//                     }
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         loading
//                             ? CircularProgressIndicator(
//                                 valueColor:
//                                     AlwaysStoppedAnimation<Color>(Colors.white))
//                             : Icon(Icons.shopping_bag),
//                         SizedBox(width: 10),
//                         Text('Order Now!')
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
