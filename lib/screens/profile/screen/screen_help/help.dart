import 'package:flutter/material.dart';

class helpCenter extends StatefulWidget {
  const helpCenter({super.key});

  @override
  State<helpCenter> createState() => _helpCenterState();
}

class _helpCenterState extends State<helpCenter> {
  String searchQuery = '';
  List<String> headingList = [
    'Add Category',
    'Add Transaction',
    'Select Date Range',
    'Edit Transactions',
    'Delete Transactions',
    'Select month',
    'View PieChart',
    'All Transactions'
  ];
  List<String> quriesList = [
    'How to add category?',
    'How to add transaction?',
    'View all categories',
    'How to filter using daterange?',
    'How to edit transactions?',
    'How to delete transactions?',
    'How to select month filter?',
    'How to view PieChart?',
    'How to view all transactions?'
  ];
  List<String> imgList = [
    'addcat',
    'add_trans',
    'category',
    'daterange',
    'edittrans',
    'edittrans',
    'month',
    'pie',
    'seall'
  ];
  List<String> detailsList = [
    'To add a category, We can tap on the plus button in the category page, Then a Popup will display like above, Then you can add category.',
    'To add transactions , You can tap on the plus button in the every page other than category page , Then there will display a form like above to add transactions',
    'To view Category list , you can choose income or expense, there will display a list. In the list you can delete categories which you have addded.',
    'To filter list of transaction with daterange, first tap on the button daterange in transaction list, Then choose one start date and an end date,  then tap on save button , There will show the list between the selected daterange',
    'To edit any selected transaction , Slide the selected transaction card into right, then there will show edit and delete icon shown above, if you want to edit, tap on edit , there will display a form , then edit the form and save the item.',
    'To delete any selected transaction , Slide the selected transaction card into right, then there will show edit and delete icon shown above, you can choose delete and there will display a popup to confirm deletion .',
    'To filter list of transaction with selected month, first tap on the button select month in transaction list, Then choose one month,  then tap on save button , There will show the list between the selected month',
    'To view piechart , you can choose income or expense or any other filters like daterange or month, there will display a piechart accroding to selected filter. there will show top spending or top earning list',
    'To view all list of transaction , you can choose income or expense or any other filters like daterange or month, there will display a list accroding to selected filter.',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Center(
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              'Help Center',
              //style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
        ),
        actions: [],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Hi, how can we help you?',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.002,
              ),
              Image.asset('assets/images/bann.png'),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Choose any question you have..',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemBuilder: (ctx, index) {
                    final data = quriesList[
                        index]; // Check if the searchQuery is empty or if it matches the current item

                    return GestureDetector(
                      onTap: () {
                        showHelpAddPopup(
                          context,
                          headingList[index],
                          detailsList[index],
                          imgList[index],
                        );
                      },
                      child: Text(
                        data,
                        style:
                            const TextStyle(color: Colors.green, fontSize: 17),
                      ),
                    );
                  },
                  itemCount: quriesList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // TODO: implement build
  }

  Future<void> showHelpAddPopup(
    BuildContext context,
    String headingText,
    String detailstext,
    String screenshotPath,
  ) async {
    showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: Center(
            child: Text(
              headingText,
              style: TextStyle(color: Colors.teal),
            ),
          ),
          children: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: Image(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.4,
                    image: AssetImage(
                        'assets/images/scrnshot_$screenshotPath.png'))),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(detailstext),
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text(
                      'Got it',
                      style: TextStyle(color: Colors.blue),
                    ))),
          ],
        );
      },
    );
  }
}
