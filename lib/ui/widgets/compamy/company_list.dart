import 'package:flutter/cupertino.dart';
import 'package:tasks/core/models/company.dart';
import 'package:tasks/ui/widgets/compamy/companylist_item.dart';

class CompanyList extends StatelessWidget {
  final List<Company> companies;
  CompanyList({this.companies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: companies.length,
      itemBuilder: (context, index) => CompanyListItem(
        company: companies[index],
        onTap: () {
          Navigator.pushNamed(
            context,
            'task_by_company',
            arguments: companies[index].name,
          );
        },
      ),
    );
  }
}
