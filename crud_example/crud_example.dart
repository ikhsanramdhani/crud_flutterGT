import 'package:flutter/material.dart';
import 'product_model.dart' as model;
import 'package:http/http.dart' as http;
import 'dart:convert';

class CrudExample extends StatelessWidget {
  const CrudExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CRUD Example",
      home: CrudExampleMain(),
    );
  }
}

final _formKey = GlobalKey<FormState>();

class CrudExampleMain extends StatefulWidget {
  const CrudExampleMain({super.key});

  @override
  State<CrudExampleMain> createState() => _CrudExampleMainState();
}

class _CrudExampleMainState extends State<CrudExampleMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Mart"),
        centerTitle: true,
      ),
      body: const ShowProduct(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String name = "";
              String price = "";
              String qty = "";
              return AlertDialog(
                title: const Text("Insert Product"),
                content: Container(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: "Name Product", hintText: "Apple"),
                          onChanged: (value) {
                            name = value;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: "Price", hintText: "10000"),
                          onChanged: (value) {
                            price = value;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: "Quantity", hintText: "5"),
                          onChanged: (value) {
                            qty = value;
                          },
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              await model.postData(
                                  {"name": name, "price": price, "qty": qty});
                              setState(() {});
                              Navigator.pop(context);
                            },
                            child: const Text("Submit"))
                      ],
                    ),
                  ),
                ),
                elevation: 0,
              );
            },
          );
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ShowProduct extends StatefulWidget {
  const ShowProduct({super.key});

  @override
  State<ShowProduct> createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(0),
        child: FutureBuilder<http.Response>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<dynamic> decode = json.decode(snapshot.data!.body);
              return ListView.builder(
                itemBuilder: (context, index) {
                  int id = decode[index]["id"];
                  String name = decode[index]["name"];
                  String price = decode[index]["price"];
                  String qty = decode[index]["qty"];

                  return ListTile(
                    trailing: Wrap(
                      spacing: 0,
                      children: [
                        IconButton(
                            tooltip: "Edit",
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Update Product"),
                                    content: Container(
                                      padding: const EdgeInsets.only(bottom: 0),
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              decoration: InputDecoration(
                                                  labelText: name,
                                                  hintText: "New Name Product"),
                                              onChanged: (value) {
                                                name = value;
                                              },
                                            ),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                  labelText: "Rp.$price",
                                                  hintText: "New Price"),
                                              onChanged: (value) {
                                                price = value;
                                              },
                                            ),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                  labelText:
                                                      "${qty.toString()} buah",
                                                  hintText: "New quantity"),
                                              onChanged: (value) {
                                                qty = value;
                                              },
                                            ),
                                            ElevatedButton(
                                                onPressed: () async {
                                                  await model.updateData(id, {
                                                    "name": name,
                                                    "price": price,
                                                    "qty": qty
                                                  });
                                                  Navigator.pop(context);
                                                  setState(() {});
                                                },
                                                child: const Text("Update"))
                                          ],
                                        ),
                                      ),
                                    ),
                                    elevation: 0,
                                  );
                                },
                              );
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blueAccent,
                            )),
                        IconButton(
                            tooltip: "Delete",
                            onPressed: () async {
                              await model.deleteData(id);
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ],
                    ),
                    title: Text("$name (${qty.toString()} buah)"),
                    subtitle: Text("Rp.$price"),
                    leading: CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Text(name[0].toUpperCase()),
                    ),
                  );
                },
                itemCount: decode.length,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          future: model.getData(),
        ));
  }
}
