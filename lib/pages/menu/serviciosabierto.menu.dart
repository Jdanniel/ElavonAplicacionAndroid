import 'package:elavonappmovil/bloc/detalleinit_bloc.dart';
import 'package:elavonappmovil/bloc/odts_bloc.dart';
import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/models/odts_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:load/load.dart';
import 'package:table_calendar/table_calendar.dart';

class ServiciosAbiertosPage extends StatefulWidget {
  @override
  _ServiciosAbiertosPageState createState() => _ServiciosAbiertosPageState();
}

class _ServiciosAbiertosPageState extends State<ServiciosAbiertosPage>
    with TickerProviderStateMixin {

  DetalleInitBloc detalleInitBloc;    
  OdtsBloc odt;
  bool _init = false;

  Map<DateTime, List<Odtmodel>> _events = new Map<DateTime, List<Odtmodel>>();
  List<Odtmodel> _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _events = {};
    initEvents();
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    //_animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  @override
  Widget build(BuildContext context) {
    detalleInitBloc = Provider.detalleinitBloc(context);
    odt = Provider.odtsBloc(context);
    detalleInitBloc.changePageReturn(2);
    return Scaffold(
      appBar: AppBar(
        title: Text("Abiertos"),
      ),
      backgroundColor: Colors.blueAccent,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _init ? _buildTableCalendar() : Container(),
          const SizedBox(height: 8.0),
          _init ? Expanded(child: _buildEventList()) : Container(),
        ],
      ),
    );
  }

  void initEvents() async {
    showCustomLoadingWidget(Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        SizedBox(
          height: 1.0,
        ),
        Text("Cargando...")
      ],
    )));

    DateTime _selectedDay = DateTime.now();
    _selectedDay =
        DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    OdtsBloc bloc = new OdtsBloc();
    List<Odtmodel> listodts = await bloc.getAllOdtsOrderbyDate();
    Map<DateTime, List<Odtmodel>> eventos;
    //_events = [];
    for (int i = 0; i < listodts.length; i++) {
      //print(listodts[i].days.toString()+'/'+listodts[i].months.toString()+'/'+listodts[i].years.toString());
      List<Odtmodel> datosbyDate = await odt.selectAllOdtsbyDate2(
          listodts[i].days, listodts[i].months, listodts[i].years, [35,4,5]);
      eventos = {
        DateTime(listodts[i].years, listodts[i].months, listodts[i].days):
            datosbyDate
      };
      _events.addAll(eventos);
      //_events = {DateTime(listodts[i].years, listodts[i].months, listodts[i].days) : datosbyDate};
    }
    _selectedEvents = _events[_selectedDay] ?? [];
    setState(() {
      _init = true;
    });
    hideLoadingDialog();
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      startingDayOfWeek: StartingDayOfWeek.monday,
      locale: 'es_MX',
      calendarStyle: CalendarStyle(
          weekendStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16.0),
          weekdayStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16.0),
          selectedColor: Colors.deepOrangeAccent,
          todayColor: Colors.deepOrange[200],
          markersColor: Colors.brown[700],
          outsideDaysVisible: false),
      headerStyle: HeaderStyle(
        titleTextBuilder: (date, locale) =>
            DateFormat.yMMMM(locale).format(date),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 30.0),
        centerHeaderTitle: true,
        formatButtonShowsNext: false,
        formatButtonVisible: false,
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle:
            TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
        weekdayStyle:
            TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: _makeListTile(event)
              ))
          .toList(),
    );
  }

  _makeListTile(Odtmodel model) {
    IconData icono;

    switch (model.idTipoServicio) {
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
                  right: new BorderSide(width: 1.0, color: Colors.black26))),
          child: Icon(
            icono,
            color: Colors.black,
          ),
        ),
        title: Text(
          "ODT: ${model.odt}",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SelectableText("Negocio: ${model.negocio}"),
            Text("Afiliacion: ${model.noAfiliacion}"),
            Text("Fecha garantía: ${model.fecGarantia}")
          ],
        ),
        onTap: (){Navigator.pushNamed(context, 'detalleOdt', arguments: model); odt.nuevoOdt(model);},
        );
  }
}
