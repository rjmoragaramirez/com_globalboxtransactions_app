import 'Bank.dart';

class Beneficiary{
  final String id;
  final String name;
  final String numberAccount;
  final String email;
  final String phone;
  Bank bank;
  final String image;

    Beneficiary({
    required this.id,
    required this.name,
    required this.numberAccount,
    required this.email,
    required this.phone,
    required this.bank,
    required this.image,
  });
}