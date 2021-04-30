import 'package:flutter/material.dart';
import 'package:child_information_app/screens/hakkinda.dart';
import 'package:child_information_app/screens/login_page.dart';
import 'package:child_information_app/screens/patient.dart';
import 'package:child_information_app/screens/patient_add.dart';
import 'package:child_information_app/screens/out.dart';
import 'package:child_information_app/screens/school.dart';
import 'package:child_information_app/screens/virus.dart';
import 'package:child_information_app/screens/applicationsubject.dart';
import 'package:child_information_app/screens/immunity.dart';
import 'package:child_information_app/screens/symptom.dart';
import 'package:child_information_app/screens/illness.dart';

void main() => runApp(MyApp());
final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
        "/Home": (context) => HomeScreen(),
      },
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
    );
  }
}

class HomeScreen extends StatefulWidget {
  //state management
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State {
  List<Patient> patients = [
    Patient.WithId(1, "Hasan", "Ayvaz", 40),
    Patient.WithId(2, "Mert", "Kaplan", 38),
    Patient.WithId(3, "Aylin", "Yücedağ", 37),
  ];
  Patient selectedPatient = Patient.WithId(0, "Hiç kimse", "", 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Çocuk Bilgilendirme Sistemi"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {},
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.add_box,
                      color: Colors.white,
                      size: 100.0,
                    ),
                    Text(
                      "",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Anasayfa"),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, "/Home");
                },
              ),
              ExpansionTile(
                leading: Icon(Icons.arrow_drop_down_outlined),
                title: Text('Çocuklar kendisini Korona Virüsten nasıl korur?'),
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.arrow_forward),
                    title: Text('Dışarıda'),
                    trailing: Icon(Icons.arrow_right),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Protection()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_forward),
                    title: Text('Okulda'),
                    trailing: Icon(Icons.arrow_right),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => School()));
                    },
                  ),
                ],
              ),
              ListTile(
                leading: Icon(Icons.arrow_forward),
                title: Text("Korona Virüs yapısı ve özellikleri nedir ?"),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Virus()));
                },
              ),
              ListTile(
                  leading: Icon(Icons.arrow_forward),
                  title: Text(
                    'Korona Virüs hastalığı belirtileri nelerdir ?',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Symptom()));
                  }),
              ListTile(
                  leading: Icon(Icons.arrow_forward),
                  title:
                  Text('Bağışıklık sistemi nedir ve nasıl güçlendirilir ?'),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Immunity()));
                  }),
              ListTile(
                  leading: Icon(Icons.arrow_forward),
                  title:
                  Text('Eğer Korona Virüse yakalanırsak neler yapmalıyız?'),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Illness()));
                  }),
              ListTile(
                  leading: Icon(Icons.arrow_forward),
                  title: Text('Uygulama amacı ve hedefleri'),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Subject()));
                  }),
            ],
          ),
        ),
        body: buildBody());
  }

  Widget buildBody() {
    return Column(
      children: <Widget>[
        Text(
          "Kişiyi silmek için yana kaydırabilirsiniz",
          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: patients.length,
              itemBuilder: (BuildContext context, index) {
                Patient patient = patients[index];

                return Dismissible(
                  key: Key(patient.firstName),
                  onDismissed: (direction) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${patient.firstName} silindi'),
                        action: SnackBarAction(
                          label: "Geri Al",
                          onPressed: () {
                            setState(() {
                              patients.add(patient);
                            });
                          },
                        ),
                      ),
                    );
                    setState(() {
                      patients.removeAt(index);
                    });
                  },
                  child: ListTile(
                    title: Text(patients[index].firstName +
                        " " +
                        patients[index].lastName),
                    subtitle: Text("Ateşi : " +
                        patients[index].grade.toString() +
                        "[" +
                        patients[index].getStatus +
                        "]"),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://thesector.com.au/wp-content/uploads/2019/05/sandy-millar-750251-unsplash-1800x1000.jpg"),
                    ),
                    trailing: buildStatusIcon(patients[index].grade),
                    onTap: () {
                      setState(() {
                        this.selectedPatient = patients[index];
                      });
                      this.selectedPatient = patients[index];
                    },
                  ),
                );
              }),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.black54, onPrimary: Colors.white, elevation: 5),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Hakkinda()));
            },
            child: Text("Hakkında")),
        Text("Seçili Kişi : " + selectedPatient.firstName),
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: ElevatedButton(
                child: Text("Yeni kişi ekle "),
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    onPrimary: Colors.black,
                    elevation: 5),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PatientAdd(patients)),
                  ).then((value) => setState(() {}));
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: ElevatedButton(
                child: Text("Uygulamadan Çıkış"),
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    onPrimary: Colors.black,
                    elevation: 5),
                onPressed: () {
                  _showDialog();
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget buildStatusIcon(double grade) {
    if (grade < 38) {
      return Icon(Icons.done);
    } else if (grade >= 38 && grade < 39) {
      return Icon(Icons.album);
    } else {
      return Icon(Icons.clear);
    }
  }

  _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text("Uygulamadan çıkış yapmak istediğinize emin misiniz ?"),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: MaterialButton(
                  child: Text("Evet"),
                  shape: StadiumBorder(),
                  minWidth: 100,
                  color: Colors.black45,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                            (route) => false);
                  },
                ),
              ),
              MaterialButton(
                child: Text("Hayır"),
                shape: StadiumBorder(),
                minWidth: 100,
                color: Colors.black45,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
