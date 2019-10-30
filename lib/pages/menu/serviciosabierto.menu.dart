import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/models/odts_model.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ServiciosAbiertosPage extends StatefulWidget {
  @override
  _ServiciosAbiertosPageState createState() => _ServiciosAbiertosPageState();
}

class _ServiciosAbiertosPageState extends State<ServiciosAbiertosPage> {


  CalendarController _calendarController;
  OdtsBloc odtbloc;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();  
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    odtbloc = Provider.odtsBloc(context);  

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 20.0),
          child: Column(
            mainAxisSize:  MainAxisSize.max,
            children: <Widget>[
              _botonRegresar(context),
              SizedBox(height: 5.0,),
              _buildCalendar(),
              SizedBox(height: 10.0,),
              _buildOdts(),
            ],
          ),
        ),
      ),
    );
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: day_ '+ day.day.toString());
    setState(() {
      odtbloc.selectAllOdtsbyDate(day.day, day.month, day.year);
      _buildOdts();
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  Widget _botonRegresar(BuildContext _context){
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      alignment: Alignment.topLeft,
      child: Row(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              _regresar(_context);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: Icon(
              Icons.arrow_back,
              size: 30.0,
            ),
          ), 
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text("Servicios Abiertos", style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),),
            ),
          ) 
        ],
      )
    );
  }


  void _regresar(BuildContext _context) {
    Navigator.pop(_context);
  }

  Widget _buildCalendar(){
    return TableCalendar(
      calendarController: _calendarController,
      formatAnimation: FormatAnimation.slide,
      locale: 'es_MX',
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        weekendStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16.0),
        weekdayStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16.0),
        selectedColor: Colors.deepOrangeAccent,
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        
        outsideDaysVisible: false
      ),
      headerStyle: HeaderStyle(
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 30.0),
        centerHeaderTitle: true,
        formatButtonShowsNext: false,
        formatButtonVisible: false,
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
        weekdayStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged:  _onVisibleDaysChanged,
    );
  }
  Widget _buildOdts(){
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0))
        ),
        elevation: 8.0,
        child: Container(
          margin: EdgeInsets.all(15.0),
          width: double.infinity,
          height: double.infinity,
          child: _crearListado()
        ),
      )
    );
  }
  Widget _crearListado(){
    return StreamBuilder(
      stream: odtbloc.allodtsbyDateStream,
      builder: (BuildContext context, AsyncSnapshot<List<Odtmodel>> snapshot){
        if(snapshot.hasData && snapshot.data.length > 0){
          final odts = snapshot.data;
          return Container(
            child: ListView.builder(
              itemCount: odts.length,
              itemBuilder: (context,index){
                return _crearItem(context, odts[index]);
              },
            ),
          );
        }else{
          return Container(
            child: Center(
              child: Text("No hay ODTS asignadas para este día"),
            ),
          );
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, Odtmodel odts) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        child: InkWell(
          onTap: () =>
              Navigator.pushNamed(context, 'detalleOdt', arguments: odts),
          child: Card(
            elevation: 8.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  _makeListTile(odts)
                ],
              ),
            )
          ),
        )
    );
  }

  _makeListTile(Odtmodel model){

    IconData icono;

    switch(model.idTipoServicio){
      case 1: 
        icono = Icons.arrow_upward;
        break;
      case 2:
        icono = Icons.casino;
        break;
      case 3:
        icono = Icons.camera_roll;
        break;
    }

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        height: 50.0,
        padding: EdgeInsets.only(right: 12.0),
        decoration: BoxDecoration(
          border: Border(
            right: new BorderSide(width: 1.0, color: Colors.black26)
          )
        ),
        child: Icon(icono, color: Colors.black,),
      ),
      title: Text("ODT: ${model.odt}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SelectableText("Negocio: ${model.negocio}"),
          Text("Afiliacion: ${model.noAfiliacion}"),
          Text("Fecha garantía: ${model.fecGarantia}")
        ],
      )
    );
  }

}