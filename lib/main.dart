import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:russian_hackers/global.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => HomePage(),
      '/InfoPage': (context) => InfoPage(),
      '/CurrentCountySelection': (context) => CurrentCountySelection(),
      '/Settings': (context) => Settings(),
      '/HomeCountySelection': (context) => Algo(),
      '/ReportPage': (context) => ReportPage(),
      '/HospitalLinks': (context) => HospitalLinks(),
      '/AlgoScore': (context) => AlgoScore(),
      '/AlgoScoreForm': (context) => AlgoScoreForm(),
      '/AlgoScoreResults': (context) => AlgoScoreResults(),
    },
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Covid Assist'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: <Widget>[
          Center(
              //child: Image.asset('assets/images/Covid_Assist_round.png')
            child: Container(
              height: 300.0,
              width: 300.0,
              margin: EdgeInsets.all(50.0),
                child: Image.asset('assets/images/Covid_Assist_round.png',
                                    scale: 0.6,)
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 100,
                  child: RaisedButton.icon(
                    color: Colors.blue,
                    icon: Icon(
                        Icons.info
                    ),
                    label: Text('Information'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/InfoPage');
                      },
                    ),
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonTheme(
                  minWidth: 135,
                  child: RaisedButton.icon(
                    icon: Icon(
                        Icons.add
                    ),
                    label: Text('Check'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/CurrentCountySelection');
                      },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonTheme(
                  minWidth: 135,
                  child: RaisedButton.icon(
                    icon: Icon(
                        Icons.settings
                    ),
                    label: Text('More Services'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/Settings');
                      },
                  ),
                ),
              ],
          )),
        ]
      )
    );
  }
}

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Basic Information"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text('Coronavirus disease (COVID-19) is an infectious disease caused by a newly discovered coronavirus. Most people infected with the virus will experience mild respiratory illness and recover without requiring special treatment.  Older people, and those with underlying medical problems like cardiovascular disease, diabetes, chronic respiratory disease, and cancer are more likely to develop serious illness.The best way to prevent and slow down transmission is to wear a mask. Protect yourself and others from infection by washing your hands or using an alcohol based rub frequently and not touching your face.The COVID-19 virus spreads primarily through droplets of saliva or discharge from the nose when an infected person coughs or sneezes, so it’s important that you also practice respiratory etiquette (so wearing a mask is very important).At this time, there are no specific vaccines or treatments for COVID-19. However, there are many ongoing clinical trials evaluating potential treatments.', textAlign: TextAlign.center, style: new TextStyle(fontSize: 20),),
      ),
    );
  }
}

class CurrentCountySelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Home(),
           // Text('Please Enter Your Details Below'),
          //  Text('In Which County Do You Think You Got Infected?'),
    );
  }
}

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("More Services"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                child: Text('Risk Calculator'),
                onPressed: () {
                  Navigator.pushNamed(context, '/HomeCountySelection');
                },
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                child: Text('Hospital Finder'),
                onPressed: () {
                  Navigator.pushNamed(context, '/HospitalLinks');
                },
              ),
            ],
          )),
    );
  }
}

class Algo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlgoScore(),
    );
  }
}

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report"),
        backgroundColor: Colors.teal,
      ),
      body: CountyDataApp(),
    );
  }
}

class HospitalLinks extends StatelessWidget {
  @override
  TextEditingController input = new TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find Hospitals"),
        backgroundColor: Colors.teal,
      ),
      body: Form(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 35.0),
            ),
            TextFormField(
              controller: input,
              decoration: InputDecoration(
                  hintText: 'Please Enter The Desired City'
              ),
            ),

            //notification widget
            //toast
            //alert dialog
            //snack bar

            Container(
              alignment: Alignment.centerRight,
              child: MaterialButton(onPressed: () => MapsLauncher.launchQuery('Hospitals in ' + input.text),
                color: Colors.orange,
                textColor: Colors.white,
                child: Text('Submit'),
              ),

            ),

          ],
        ),
      ),
    );
  }
}

class AlgoScore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Risk Calculator"),
        backgroundColor: Colors.teal,
      ),
      body: AgeRangeApp()
    );
  }
}


class AgeRangeApp extends StatefulWidget {
  @override
  _AgeRange createState() => _AgeRange();
}

class _AgeRange extends State<AgeRangeApp> {
  List<ListItem> _dropdownItems = [
    ListItem(1, "18-30"),
    ListItem(2, "31-43"),
    ListItem(3, "44-56"),
    ListItem(4, "57-69"),
    ListItem(5, "70+"),
  ];

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Text('Please Select Your Age Range', style: TextStyle(fontSize: 25), textAlign: TextAlign.center),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                decoration: BoxDecoration(
                    color: Colors.black12,
                    border: Border.all()),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      value: _selectedItem,
                      items: _dropdownMenuItems,
                      onChanged: (value) {
                        setState(() {
                          _selectedItem = value;
                        });
                      }),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            RaisedButton.icon(
              icon: Icon(
                  Icons.navigate_next
              ),
              label: Text('Record'),
              onPressed: () {
                Global.age = _selectedItem.name;
                Navigator.pushNamed(context, '/AlgoScoreForm');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AlgoScoreForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Diagnostic Questions"),
          backgroundColor: Colors.teal,
        ),
        body: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> titles = ['Came in contact with virus?',
                          'Feeling ill?',
                          'Did you visit a healthcare facility?',
                          'Were you in a area with no social distancing?',
                          'Were you wearing a mask?',
                          'Did you visit a nursing home?',
                          'Aches?',
                          'Congestion?',
                          'Cough?',
                          'Diarrhea?',
                          'Fatigue?',
                          'Fever?',
                          'Loss of taste and smell?',
                          'Nausea?',
                          'Shortness of breath?',
                          'Sore throat?'];

  List<bool> inputs = new List<bool>();
  @override
  void initState() {
    setState(() {
      for(int i=0;i<16;i++){
        inputs.add(false);
      }
    });
  }

  void ItemChange(bool val,int index){
    setState(() {
      inputs[index] = val;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new ListView.builder(
          itemCount: inputs.length,
          itemBuilder: (BuildContext context, int index){
            return new Card(
              child: new Container(
                padding: new EdgeInsets.all(10.0),
                child: new Column(
                  children: <Widget>[
                    new CheckboxListTile(
                        value: inputs[index],
                        title: new Text(titles[index]),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged:(bool val){ItemChange(val, index);}
                    )
                  ],
                ),
              ),
            );

          }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigate_next),
        onPressed: () {
          makePostRequest();
          Navigator.pushNamed(context, '/AlgoScoreResults');
        },
      ),
    );
  }

  makePostRequest() async {

    List<bool> data = inputs.sublist(6);
    List<String> dataTitle = titles.sublist(6);

    for(int i = data.length - 1; i >= 0; i--){
      if(!data[i]) {
        data.removeAt(i);
        dataTitle.removeAt(i);
      }
    }

    print(Global.age);
    for(String s in dataTitle){
      print(s);
    }

    final uri = 'https://688dcff9b99e.ngrok.io/details/report';
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
                                  'ageRange': Global.age,
                                  'cameInContact': inputs[0],
                                  'feelingIll': inputs[1],
                                  'healthcareFacility': inputs[2],
                                  'noDistancing': inputs[3],
                                  'noMask': inputs[4],
                                  'nursingHome': inputs[5],
                                  'symptoms': dataTitle
    };



    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
  }
}

class AlgoData {
  final int score;
  final String level;

  AlgoData({this.score, this.level});

  factory AlgoData.fromJson(Map<String, dynamic> json) {
    return AlgoData(
      score: json['score'],
      level: json['riskScore'],
    );
  }
}

class AlgoOutputApp extends StatefulWidget {
  AlgoOutputApp({Key key}) : super(key: key);

  @override
  _AlgoOutputAppState createState() => _AlgoOutputAppState();
}

class _AlgoOutputAppState extends State<AlgoOutputApp> {
  Future<CountyData> futureCountyData;

  @override
  void initState() {
    super.initState();
    futureCountyData = fetchCountyData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder<CountyData>(
            future: futureCountyData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text('County Name: ' + snapshot.data.countyName + ', ' + 'Infected: ' + snapshot.data.infected.toString());
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class AlgoScoreResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Results"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          children: [
            Text('Your Score Is: 60'),
            Text('Your Risk Score Is: Medium'),
          ],
        ),
      ),
    );
  }
}




class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ListItem> _dropdownItems = [
    ListItem(1, "Alameda"),
    ListItem(2, "Alpine"),
    ListItem(3, "Amador"),
    ListItem(4, "Butte"),
    ListItem(5, "Calaveras"),
    ListItem(6, "Colusa"),
    ListItem(7, "Contra Costa"),
    ListItem(8, "Del Norte"),
    ListItem(9, "El Dorado"),
    ListItem(10, "Fresno"),
    ListItem(11, "Glenn"),
    ListItem(12, "Humboldt"),
    ListItem(13, "Imperial"),
    ListItem(14, "Inyo"),
    ListItem(15, "Kern"),
    ListItem(16, "Kings"),
    ListItem(17, "Lake"),
    ListItem(18, "Lassen"),
    ListItem(19, "Los Angeles"),
    ListItem(20, "Madera"),
    ListItem(21, "Marin"),
    ListItem(22, "Mariposa"),
    ListItem(23, "Mendocino"),
    ListItem(24, "Merced"),
    ListItem(25, "Modoc"),
    ListItem(26, "Mono"),
    ListItem(27, "Monterey"),
    ListItem(28, "Napa"),
    ListItem(29, "Nevada"),
    ListItem(30, "Orange"),
    ListItem(31, "Placer"),
    ListItem(32, "Plumas"),
    ListItem(33, "Riverside"),
    ListItem(34, "Sacramento"),
    ListItem(35, "San Benito"),
    ListItem(36, "San Bernardino"),
    ListItem(37, "San Diego"),
    ListItem(38, "San Francisco"),
    ListItem(39, "San Joaquin"),
    ListItem(40, "San Luis Obispo"),
    ListItem(41, "San Mateo"),
    ListItem(42, "Santa Barbara"),
    ListItem(43, "Santa Clara"),
    ListItem(44, "Santa Cruz"),
    ListItem(45, "Shasta"),
    ListItem(46, "Sierra"),
    ListItem(47, "Siskiyou"),
    ListItem(48, "Solano"),
    ListItem(49, "Sonoma"),
    ListItem(50, "Stanislaus"),
    ListItem(51, "Sutter"),
    ListItem(52, "Tehama"),
    ListItem(53, "Trinity"),
    ListItem(54, "Tulare"),
    ListItem(55, "Tuolumne"),
    ListItem(56, "Ventura"),
    ListItem(57, "Yolo"),
    ListItem(58, "Yuba"),
  ];

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose The County"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text('Please Enter Your Details Below', style: TextStyle(fontSize: 40), textAlign: TextAlign.center),
            SizedBox(
              height: 30,
            ),
            Text('In Which County Do You Think You Got Infected?', style: TextStyle(fontSize: 25), textAlign: TextAlign.center),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                decoration: BoxDecoration(
                    color: Colors.black12,
                    border: Border.all()),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      value: _selectedItem,
                      items: _dropdownMenuItems,
                      onChanged: (value) {
                        setState(() {
                          _selectedItem = value;
                        });
                      }),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            RaisedButton.icon(
              icon: Icon(
                  Icons.navigate_next
              ),
              label: Text('Record'),
              onPressed: () {
                Global.county = _selectedItem.name;
                Navigator.pushNamed(context, '/ReportPage');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}








Future<CountyData> fetchCountyData() async {

  String county = Global.county;
  //print('c' + county);
  county = county.replaceAll(' ', '%20');

  final response =
  await http.get('https://688dcff9b99e.ngrok.io/details/county-details/' + county + '%20County');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return CountyData.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load CountyData');
  }
}

class CountyData {
  final String countyName;
  final int pop;
  final int infected;
  final int deaths;
  final int recovered;
  final double infectionRate;
  final double survivalRate;

  CountyData({this.countyName, this.pop, this.infected, this.deaths, this.recovered, this.infectionRate, this.survivalRate});

  factory CountyData.fromJson(Map<String, dynamic> json) {
    return CountyData(
      countyName: json['countyName'],
      pop: json['population'],
      infected: json['infected'],
      deaths: json['deaths'],
      recovered: json['recovered'],
      infectionRate: json['infectionRate'],
      survivalRate: json['survivalRate'],
    );
  }
}

class CountyDataApp extends StatefulWidget {
  CountyDataApp({Key key}) : super(key: key);

  @override
  _CountyDataAppState createState() => _CountyDataAppState();
}

class _CountyDataAppState extends State<CountyDataApp> {
  Future<CountyData> futureCountyData;

  @override
  void initState() {
    super.initState();
    futureCountyData = fetchCountyData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder<CountyData>(
            future: futureCountyData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text('County Name: ' + snapshot.data.countyName + ', ' + 'Infected: ' + snapshot.data.infected.toString());
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}








