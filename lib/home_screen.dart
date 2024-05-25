import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wesal_payment_planner/constants.dart';
import 'package:wesal_payment_planner/enums/installment_enum.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NumberFormat priceFormat = NumberFormat.decimalPattern('en_us');

  final priceController = TextEditingController();
  double totalPrice = 0;
  double downPayment = 0;
  double maintenance = 0;
  double installment = 0;

  InstallmentEnum selectedInstallmentEnum = InstallmentEnum.five;
  List<InstallmentEnum> installmentEnums = [
    InstallmentEnum.five,
    InstallmentEnum.sevenAndHalf,
    InstallmentEnum.ten,
  ];

  void resetValues() {
    setState(() {
      downPayment = 0;
      maintenance = 0;
      installment = 0;
    });
  }

  Text buildTrailingPriceText(double price) {
    return Text(
      priceFormat.format(price),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  void calcResults() {
    maintenance = totalPrice * 7 / 100;

    if (selectedInstallmentEnum == InstallmentEnum.five) {
      // 5%
      downPayment = totalPrice * 5 / 100;
      final restPrice = totalPrice - downPayment;
      installment = restPrice / 8 / 12;
    } else if (selectedInstallmentEnum == InstallmentEnum.sevenAndHalf) {
      // 7.5%
      downPayment = totalPrice * 7.5 / 100;
      final restPrice = totalPrice - downPayment;
      installment = restPrice / 9 / 12;
    } else if (selectedInstallmentEnum == InstallmentEnum.ten) {
      // 10%
      downPayment = totalPrice * 10 / 100;
      final restPrice = totalPrice - downPayment;
      installment = restPrice / 10 / 12;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'حاسبة وصال',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  priceFormat.format(totalPrice),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(
                  hintText: 'أدخل سعر الوحدة هنا',
                  labelText: 'سعر الوحدة',
                  enabledBorder: kEnabledBorder,
                  focusedBorder: kFocusedBorder,
                  disabledBorder: kDisabledBorder,
                  errorBorder: kErrorBorder,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: false,
                ),
                onChanged: (value) {
                  if (value.isNotEmpty &&
                      double.tryParse(value) != null &&
                      double.parse(value) >= 0) {
                    // Price is correct and not empty
                    double numValue = double.parse(value);

                    totalPrice = numValue;

                    calcResults();
                  } else {
                    resetValues();
                  }
                },
              ),
              const Divider(),
              RadioListTile<InstallmentEnum>(
                value: installmentEnums[0],
                groupValue: selectedInstallmentEnum,
                title: const Text('5%'),
                onChanged: (value) {
                  setState(() {
                    selectedInstallmentEnum = value!;
                    calcResults();
                  });
                },
              ),
              RadioListTile<InstallmentEnum>(
                value: installmentEnums[1],
                groupValue: selectedInstallmentEnum,
                title: const Text('7.5%'),
                onChanged: (value) {
                  setState(() {
                    selectedInstallmentEnum = value!;
                    calcResults();
                  });
                },
              ),
              RadioListTile<InstallmentEnum>(
                value: installmentEnums[2],
                groupValue: selectedInstallmentEnum,
                title: const Text('10%'),
                onChanged: (value) {
                  setState(() {
                    selectedInstallmentEnum = value!;
                    calcResults();
                  });
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('المقدم'),
                subtitle: Text(
                  '${selectedInstallmentEnum == InstallmentEnum.five ? '5%' : selectedInstallmentEnum == InstallmentEnum.sevenAndHalf ? '7.5%' : '10%'} من قيمة الوحدة',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                trailing: buildTrailingPriceText(downPayment),
              ),
              const SizedBox(
                height: 16,
              ),
              ListTile(
                title: const Text('إجمالى وديعة الصيانة'),
                subtitle: const Text(
                  '7% من قيمة الوحدة',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                trailing: buildTrailingPriceText(maintenance),
              ),
              ListTile(
                title: const Text('قسط وديعة الصيانة ربع سنويا'),
                subtitle: const Text(
                  '25% من إجمالى وديعة الصيانة',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                trailing: buildTrailingPriceText(maintenance / 4),
              ),
              const SizedBox(
                height: 16,
              ),
              ListTile(
                title: const Text('قيمة القسط ربع سنويا'),
                trailing: buildTrailingPriceText(installment * 3),
              ),
              ListTile(
                title: const Text('قيمة القسط شهريا'),
                trailing: buildTrailingPriceText(installment),
              ),
              const Divider(),
              const Text(
                'التطبيق غير رسمى لكن الحسبة صحيحة و تستعمل للإستدلال فقط',
                style: TextStyle(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                'تم بواسطة م/زياد منسى',
                style: TextStyle(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
