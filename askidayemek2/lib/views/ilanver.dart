import 'package:askidayemek2/main.dart';
import 'package:askidayemek2/model/user.dart';
import 'package:askidayemek2/widgets/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:askidayemek2/views/HomePage.dart';

class ilan1 extends StatefulWidget {
  @override
  State<ilan1> createState() => _ilan1State();
}

class _ilan1State extends State<ilan1> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int _selectedPortion = 1;

  void _submitForm() async {
    String title = _titleController.text;
    String description = _descriptionController.text;

    var yemek = YemekModel(
        restoranAdi: restoranGlobal,
        yemekismi: title,
        porsiyon: _selectedPortion,
        konum: description);
    await FirebaseFirestore.instance
        .collection("Ilanlar")
        .doc()
        .set(yemek.toJson());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Yemek Siparişi Verildi!'),
      ),
    );
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Yemek İlanı Ver'),
        backgroundColor: Color.fromRGBO(205, 193, 197, 1.0),
      ),
      body: Container(
        color: Color.fromRGBO(205, 193, 197, 1.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Yemek Adı'),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Restorantın konumu'),
                maxLines: 1,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text('Porsiyon: $_selectedPortion'),
                  SizedBox(width: 16),
                  Expanded(
                    child: Slider(
                      value: _selectedPortion.toDouble(),
                      min: 1,
                      max: 5,
                      divisions: 4,
                      onChanged: (double value) {
                        setState(() {
                          _selectedPortion = value.toInt();
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              button(
                  child: Text('İlanı Ver'),
                  color: Colors.black,
                  onPressed: _submitForm)
            ],
          ),
        ),
      ),
    );
  }
}
