class Coupon {
  final String name;
  final String code;
  final String newPrice;
  final String oldPrice;
  final String dueDate;

  const Coupon(
      {required this.name,
      required this.code,
      required this.newPrice,
      required this.oldPrice,
      required this.dueDate});
}
