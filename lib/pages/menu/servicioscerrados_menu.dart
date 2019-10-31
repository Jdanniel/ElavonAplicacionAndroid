import 'package:elavonappmovil/bloc/odts_bloc.dart';
import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/models/odts_model.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ServiciosCerradosPage extends StatefulWidget {
  @override
  _ServiciosCerradosPageState createState() => _ServiciosCerradosPageState();
}

class _ServiciosCerradosPageState extends State<ServiciosCerradosPage>
    with TickerProviderStateMixin {

  OdtsBloc odt;
  bool _init = false;

  Map<DateTime, List<Odtmodel>> _events = new Map<DateTime, List<Odtmodel>>();
  List<Odtmodel> _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState(){
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
    _animationController.dispose();
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

    odt = Provider.odtsBloc(context);  
    return Scaffold(
      appBar: AppBar(
        title: Text("Pruebas"),
      ),
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

  void initEvents() async{
      DateTime _selectedDay = DateTime.now();
      _selectedDay = DateTime(_selectedDay.year,_selectedDay.month,_selectedDay.day);
      OdtsBloc bloc = new OdtsBloc();
      List<Odtmodel> listodts = await bloc.getAllOdtsOrderbyDate();
      Map<DateTime, List<Odtmodel>> eventos;
      //_events = [];
      for(int i = 0; i < listodts.length; i++){
        //print(listodts[i].days.toString()+'/'+listodts[i].months.toString()+'/'+listodts[i].years.toString());
        List<Odtmodel> datosbyDate = await odt.selectAllOdtsbyDate2(listodts[i].days, listodts[i].months, listodts[i].years,6);
        eventos = {
          DateTime(listodts[i].years, listodts[i].months, listodts[i].days) : datosbyDate
        };
        _events.addAll(eventos);
        //_events = {DateTime(listodts[i].years, listodts[i].months, listodts[i].days) : datosbyDate};
      }
      _selectedEvents = _events[_selectedDay] ?? [];
      setState(() {
        _init = true;
      });
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
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
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.odt),
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }
}
