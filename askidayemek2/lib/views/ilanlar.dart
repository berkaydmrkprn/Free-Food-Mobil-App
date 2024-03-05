import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Ilanlar extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Ilanlar> {
  final CollectionReference ilanlar =
      FirebaseFirestore.instance.collection('Ilanlar');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(162, 181, 205, 1.0),
        title: Text('Yemek İlanları'),
      ),
      backgroundColor: Color.fromRGBO(162, 181, 205, 1.0),
      body: StreamBuilder(
        stream: ilanlar.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Hata: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length * 2 - 1,
              itemBuilder: (context, index) {
                if (index.isOdd) {
                  return Divider();
                }

                var ilan = snapshot.data!.docs[index ~/ 2];
                int porsiyonSayisi = ilan['porsiyon'];

                return ListTile(
                  title: Text(ilan['yemekismi']),
                  subtitle: Text('Porsiyon: $porsiyonSayisi\n${ilan['konum']}'),
                  isThreeLine: true,
                  trailing: ElevatedButton(
                    onPressed: porsiyonSayisi > 0
                        ? () {
                            ilanlar
                                .doc(ilan.id)
                                .update({'porsiyon': FieldValue.increment(-1)});

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Belirtilen Konuma Giderek Yemeğinizi Alabilirsiniz!'),
                              ),
                            );
                          }
                        : null,
                    child: Text('1 porsiyon yemek al'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
