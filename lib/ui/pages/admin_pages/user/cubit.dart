import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_lines/ui/pages/admin_pages/user/states.dart';
import 'package:sqflite/sqflite.dart';


class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context)=> BlocProvider.of(context);

//////////////////////////////////////////


  List<Map> users = [];

 late Database database;
  void createDatabase() {
    users = [];
    openDatabase(
      'users.db',
      version: 1,
      onCreate: (database, version) {
        print("database created");
        database.execute(
            'CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, pass TEXT, deleteUser INTEGER, cancelUser INTEGER )')
            .then((value) {
          print("table created");
        }).catchError((error) {
          print(' error is ${error.toString()}');
        });
      },
      onOpen: (database) {

        getDataFormDb(database).then((value) {
          users = value;
          print(users.toString());
          emit(AppGetDataBaseState());
        });
        print("database opened");
      },
    ).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }

 insertToDatabase({
    required String name,
    required String pass,
  }) async {
    users = [];
     await database.transaction((txn) {
     return txn.rawInsert(
          'INSERT INTO users (name,pass,deleteUser,cancelUser) VALUES ("$name","$pass",0 ,0)')
          .then((value) {
        emit(AppInsertDataBaseState());
        print("$value inserted successfully");

        getDataFormDb(database).then((value) {
          users = value;
          print(users.toString());
          emit(AppGetDataBaseState());
        });
      }).catchError((error) {
        print("error ${error.toString()}");
      });

    });
  }


  Future<List<Map>> getDataFormDb(database) async{
   return await database.rawQuery('SELECT * FROM users');
  }

  void updateCancel({
 required int  cancel,
 required int id,
})async{
    await database.rawUpdate(
      'UPDATE users SET  cancelUser = ? WHERE id = ? ',
     [ '${cancel == 0? 1 : 0}', '$id'],
    ).then((value) {
      getDataFormDb(database).then((value) {
        users = value;
        print(users.toString());
        emit(AppGetDataBaseState());
      });
    });
  }

  void updateDelete({
   required int delete,
   required int id,
  })async{
    await database.rawUpdate(
      'UPDATE users SET deleteUser = ? WHERE id = ? ',
      ['${delete == 0? 1 : 0} ', '$id'],
    ).then((value) {
      getDataFormDb(database).then((value) {
        users = value;
        print(users.toString());
        emit(AppGetDataBaseState());
      });
    });
  }

  void deleteData(int id){
    database.rawDelete('DELETE FROM users WHERE id = ?',['$id']).then((value) {
      getDataFormDb(database).then((value) {
        users = value;
        print(users.toString());
        emit(AppGetDataBaseState());
      });
      emit(AppDeleteDataBaseState());
    });
  }

  void deleteALl(){
    database.delete('users').then((value) {
      getDataFormDb(database).then((value) {
      users = value;
      emit(AppGetDataBaseState());
      });
    });
    emit(AppDeleteAllStateState());
  }
}