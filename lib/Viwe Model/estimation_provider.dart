import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:xmark/Data/products.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Estimation extends ChangeNotifier {
  int qty = 1;
  int price = 0;
  int dividerQty = 0;
  int checkQty = 0;
  int archQty = 0;
  int loowerQty = 0;

  var productDiscountAmount = 0;
  var productTotalAmount = 0;

  var grossAmount = 0.0;
  var discount = 0.0;
  var grandTotalAmount = 0.0;

  List<dynamic> additionalList = [];
  List<dynamic> selectedProducts = [];

// Increment Quantity
  void incrementQty(String type, [int? price]) {
    switch (type) {
      case 'product':
        qty++;
        price = qty * price!;
        break;
      case 'divider':
        dividerQty++;
        addToAdditionalList(qty: dividerQty, price: qty * kdividerPrice, label: "Divider");
        break;
      case 'check':
        checkQty++;
        addToAdditionalList(qty: checkQty, price: qty * kcheckPrice, label: "Check");
        break;
      case 'arch':
        archQty++;
        addToAdditionalList(qty: archQty, price: qty * karchPrice, label: "Arch");
        break;
      case 'loower':
        loowerQty++;
        addToAdditionalList(qty: loowerQty, price: qty * kloowerPrice, label: "Loower");
        break;
      default:
        throw Exception('Invalid type');
    }
    notifyListeners();
  }

// Decrement Quantity
  void decrementQty(String type) {
    switch (type) {
      case 'product':
        if (qty > 1) qty--;
        break;
      case 'divider':
        if (dividerQty > 0) dividerQty--;
        removeOrUpdateAdditionalList(qty: dividerQty, price: dividerQty * kdividerPrice, label: "Divider");
        break;
      case 'check':
        if (checkQty > 0) checkQty--;
        removeOrUpdateAdditionalList(qty: checkQty, price: checkQty * kcheckPrice, label: "Check");
        break;
      case 'arch':
        if (archQty > 0) archQty--;
        removeOrUpdateAdditionalList(qty: archQty, price: archQty * karchPrice, label: "Arch");
        break;
      case 'loower':
        if (loowerQty > 0) loowerQty--;
        removeOrUpdateAdditionalList(qty: loowerQty, price: loowerQty * kloowerPrice, label: "loower");
        break;
      default:
        throw Exception('Invalid type');
    }
    notifyListeners();
  }

  void setDiscountProducts(value) {
    if (value == "") {
      productDiscountAmount = 0;
    } else {
      productDiscountAmount = int.tryParse(value)!;
    }
    notifyListeners();
  }

// Calculating Product Total Amount
  void calculatingProductTotalAmount() {
    productTotalAmount = (qty * price) - productDiscountAmount;
  }

  void setCalculatePrice(kprice) {
    price = kprice + (dividerQty * kdividerPrice) + (checkQty * kcheckPrice) + (archQty * karchPrice) + (loowerQty * kloowerPrice);
  }

// Clear all variable Quantity Values
  void assignQty({
    required int pqty,
    required int pdiscountRate,
    required int pdividerqty,
    required int pcheckqty,
    required int parchqty,
    required int ploowerqty,
  }) {
    qty = pqty;
    dividerQty = pdividerqty;
    checkQty = pcheckqty;
    archQty = parchqty;
    loowerQty = ploowerqty;
    productDiscountAmount = pdiscountRate;
    additionalList.clear();
  }

  void addToAdditionalList({
    required int qty,
    required int price,
    required String label,
  }) {
    final existingItemIndex = additionalList.indexWhere((item) => item['label'] == label);
    if (existingItemIndex != -1) {
      additionalList[existingItemIndex]["qty"] = qty;
      additionalList[existingItemIndex]["price"] = qty * price;
    } else {
      additionalList.add({
        'label': label,
        'price': price,
        'qty': qty,
      });
    }
    // print(additionalList);
  }

  void removeOrUpdateAdditionalList({
    required int qty,
    required int price,
    required String label,
  }) {
    // Find the index of the item
    final existingItemIndex = additionalList.indexWhere((item) => item['label'] == label);

    if (existingItemIndex != -1) {
      if (qty > 0) {
        // Update the item if qty > 0
        additionalList[existingItemIndex]["qty"] = qty;
        additionalList[existingItemIndex]["price"] = qty * price;
      } else {
        // Remove the item if qty is 0
        additionalList.removeAt(existingItemIndex);
      }
    }
    // print(additionalList); // Debugging log to check the updated list
  }

// Product will be Add to Selected Product List
  void addToSelectedProducts({
    required String name, // Name of the product
    required int qty, // Quantity of the product selected
    required String narration, // Additional product information or description
    required int price, // Price of the product
    required int grossAmount,
    required int discount,
    required int totalPrice,
  }) {
    // Create a copy of the additional list to avoid reference issues
    final additionalCopy = List<Map<String, dynamic>>.from(additionalList);

    final mapData = {
      'name': name,
      'quantity': qty,
      'narration': narration,
      'price': price,
      'grossAmount': grossAmount,
      'discount': discount,
      'totalPrice': productTotalAmount,
      'additional': additionalCopy,
    };

    selectedProducts.add(mapData);
    saveSelectedProducts(selectedProducts);
    // print("selectedProducts $selectedProducts");
  }

// The Selected Product List will be Cleared
  void clearSelectedProductList() {
    selectedProducts.clear();
    notifyListeners();
  }

  void deleteProduct(index) async {
    if (selectedProducts.isNotEmpty) {
      selectedProducts.removeAt(index);
      // saving removed product list with shared prefs
      final prefs = await SharedPreferences.getInstance();
      final String jsonString = jsonEncode(selectedProducts);
      await prefs.setString('selected_products', jsonString);
      notifyListeners();
    } else {
      //otherwise pass a toast messege
    }
  }

  void calculatingGrossAmount() {
    grossAmount = 0.0;
    var amount = 0;
    for (var i = 0; i < selectedProducts.length; i++) {
      amount = selectedProducts[i]['totalPrice'];
      grossAmount = grossAmount + amount;
    }
    // print("grossAmount $grossAmount");
  }

  void setDiscountOfListOfProducts(value) {
    if (value == "") {
      discount = 0.0;
    } else {
      discount = double.parse(value);
      notifyListeners();
    }
  }

  void calculatingGrandTotalAmount() {
    grandTotalAmount = 0.0;
    var amount = 0;
    for (var i = 0; i < selectedProducts.length; i++) {
      amount = selectedProducts[i]['totalPrice'];
      grandTotalAmount = grandTotalAmount + amount - discount;
    }
    // print("grandTotalAmount $grandTotalAmount");
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////// Manual Provider ///////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
  int narrationPrice = 0;

  void calculateNarrationPrice({required String kwidth, required String klength}) {
    int width = int.parse(kwidth);
    int length = int.parse(klength);
    narrationPrice = ((width * length) / 929 * 415).toInt();
  }

  void setNarrationPrice(value) {
    if (value == "") {
      narrationPrice = 0;
      return;
    }
    narrationPrice = int.parse(value);
    notifyListeners();
  }

  void manualAssignZeroToAll() {
    qty = 0;
    narrationPrice = 0;
    price = 0;
    productTotalAmount = 0;
  }

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  Future<void> saveSelectedProducts(List<dynamic> selectedProducts) async {
    final prefs = await SharedPreferences.getInstance();
    // Convert the dynamic list to JSON
    final String jsonString = jsonEncode(selectedProducts);
    // Save the JSON string in SharedPreferences
    await prefs.setString('selected_products', jsonString);
  }

  Future<void> getSelectedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    // Get the JSON string
    String? productsJson = prefs.getString('selected_products');
    if (productsJson != null) {
      // Decode the JSON string into a list
      selectedProducts = jsonDecode(productsJson);
    }
    // print("Selected Products: $selectedProducts");
    notifyListeners();
  }

  Future<void> clearAllProductsList(context) async {
    final prefs = await SharedPreferences.getInstance();
    selectedProducts.clear();
    prefs.clear();
  }
}
