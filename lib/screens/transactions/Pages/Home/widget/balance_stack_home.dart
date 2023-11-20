import 'package:flutter/material.dart';

class balanceStackWidget extends StatelessWidget {
  const balanceStackWidget({
    super.key,
    required this.totalBalance,
    required this.totalIncome,
    required this.totalExpense,
  });

  final double? totalBalance;
  final double? totalIncome;
  final double? totalExpense;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.025,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Balance',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
        //SizedBox(
        // height: 7,
        //),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '   Rs:${totalBalance ?? 0}',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 13,
                        backgroundColor: Colors.teal[400],
                        child: const Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                          size: 19,
                        ),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      const Text(
                        'Income',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '  Rs:${totalIncome ?? 0}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 13,
                        backgroundColor: Colors.teal[400],
                        child: const Icon(
                          Icons.arrow_upward,
                          color: Colors.white,
                          size: 19,
                        ),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      const Text(
                        'Expense',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '   Rs:${totalExpense ?? 0}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        )
      ],
    );
  }
}
