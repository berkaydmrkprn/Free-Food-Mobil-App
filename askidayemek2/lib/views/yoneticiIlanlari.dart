import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RestoranBelgeleriSayfasi extends StatefulWidget {
  final String targetRestoranAdi;

  RestoranBelgeleriSayfasi({required this.targetRestoranAdi});

  @override
  _RestoranBelgeleriSayfasiState createState() =>
      _RestoranBelgeleriSayfasiState();
}

class _RestoranBelgeleriSayfasiState extends State<RestoranBelgeleriSayfasi> {
  late Stream<QuerySnapshot> belgeStream;

  @override
  void initState() {
    super.initState();
    belgeStream = FirebaseFirestore.instance
        .collection("Ilanlar")
        .where("restoranAdı", isEqualTo: widget.targetRestoranAdi)
        .snapshots();
  }

  void _silmeIslemi(String belgeID) async {
    await FirebaseFirestore.instance
        .collection("Ilanlar")
        .doc(belgeID)
        .delete();
    print("Doküman silindi: $belgeID");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restoran Belgeleri'),
        backgroundColor: Color.fromRGBO(205, 193, 197, 1.0),
      ),
      body: Container(
        color: Color.fromRGBO(205, 193, 197, 1.0),
        child: StreamBuilder(
          stream: belgeStream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Hata: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Text('Ilanınız Bulunmamaktadır.');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var belge = snapshot.data!.docs[index];
                  return ListTile(
                    title: Text('yemekismi: ${belge["yemekismi"]}'),
                    subtitle: Text('porsiyon: ${belge["porsiyon"]}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        _silmeIslemi(belge.id);
                      },
                      child: Text('Sil'),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RestoranBelgeleriSayfasi(targetRestoranAdi: "Pideci"),
  ));
}
