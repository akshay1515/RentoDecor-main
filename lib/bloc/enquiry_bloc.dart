import 'package:eazy_shop/models/cat/cat_list.dart';
import 'package:eazy_shop/models/enquiry/enquiry.dart';
import 'package:eazy_shop/models/subCat/sub_cat.dart';
import 'package:eazy_shop/models/subCat/sub_cat_list.dart';
import 'package:eazy_shop/persistence/enquiry/enquiry_repository.dart';
import 'package:eazy_shop/persistence/repository.dart';
import 'package:rxdart/rxdart.dart';

class EnquiryBloc {
  EnqiryRepository _repository = EnqiryRepository();

  Future createEnquiry(EnquiryModel model) async {
    await _repository.createEnquiry(model);
    return;
  }
}

final enquiryBloc = EnquiryBloc();
