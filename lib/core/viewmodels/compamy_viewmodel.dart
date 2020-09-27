import 'package:tasks/core/enums/viewstate.dart';
import 'package:tasks/core/models/company.dart';
import 'package:tasks/core/services/api.dart';
import 'package:tasks/core/viewmodels/base_model.dart';
import 'package:tasks/locator.dart';

class CompanyViewModel extends BaseModel {
  Api _api = locator<Api>();

  List<Company> companies;
  Future fetchCompanies() async {
    setState(ViewState.Busy);
    companies = await _api.getAllCompanies();
    setState(ViewState.Idle);
  }
}
