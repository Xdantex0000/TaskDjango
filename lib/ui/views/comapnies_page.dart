import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/core/enums/viewstate.dart';
import 'package:tasks/core/models/user.dart';
import 'package:tasks/core/viewmodels/compamy_viewmodel.dart';
import 'package:tasks/ui/shared/text_styles.dart';
import 'package:tasks/ui/shared/ui_helpers.dart';
import 'package:tasks/ui/widgets/app_drawer.dart';
import 'package:tasks/ui/widgets/compamy/company_list.dart';

import 'base_view.dart';

class CompanyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<CompanyViewModel>(
      onModelReady: (model) => model.fetchCompanies(),
      builder: (context, model, child) => Scaffold(
        drawer: AppDrawer(),
        body: model.state == ViewState.Busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  UIHelper.verticalSpaceLarge(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Welcome ${Provider.of<User>(context).username}',
                      style: headerStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Here are all companies',
                    ),
                  ),
                  UIHelper.verticalSpaceSmall(),
                  Expanded(
                    child: CompanyList(
                      companies: model.companies,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
