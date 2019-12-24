
import 'package:elavonappmovil/provider/db_provider.dart';

class HomeBloc{

  Future deleteDatabase() async {
    await DBProvider.db.deletedb();
    await DBProvider.db.closeDb();
  }

}