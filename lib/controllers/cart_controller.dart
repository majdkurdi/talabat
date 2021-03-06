import 'package:get/get.dart';
import '../modals/cart_item.dart';
import '../modals/meal.dart';

class CartController extends GetxController {
  final cart = <CartItem>[].obs;

  double get total {
    double tot = 0.0;
    cart.forEach((element) {
      tot += element.price * element.quantity;
    });
    return tot;
  }

  void addToCart(Meal meal, int quantity) {
    final ids = cart.map((element) => element.id).toList();
    if (!ids.contains(meal.id)) {
      cart.add(CartItem(
          id: meal.id,
          title: meal.title!,
          price: meal.price!,
          quantity: quantity));
    } else {
      cart.firstWhere((e) => e.id == meal.id).quantity += quantity;
    }
  }

  void removeFromCart(CartItem item, int quan) {
    final selectedItem = cart.firstWhere((e) => e.id == item.id);
    if (selectedItem.quantity <= quan) {
      cart.removeWhere((element) => element.id == item.id);
    } else {
      selectedItem.quantity -= quan;
    }
  }
}
