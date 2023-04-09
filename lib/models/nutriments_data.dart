class NutrimentsData {
  NutrimentsData({
    required this.type,
    required this.quantity,
  });

  final String? type;
  final String? quantity;

  @override
  String toString() {
    return '$type $quantity';
  }
}
