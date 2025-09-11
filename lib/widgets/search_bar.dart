import 'package:flutter/material.dart';

class SearchBarExample extends StatefulWidget {
  @override
  _SearchBarExampleState createState() => _SearchBarExampleState();
}

class _SearchBarExampleState extends State<SearchBarExample> {
  TextEditingController _searchController = TextEditingController();
  List<String> _data = ['Apple', 'Banana', 'Orange', 'Grape', 'Mango'];
  List<String> _filteredData = [];

  @override
  void initState() {
    super.initState();
    _filteredData = _data; // Initially show all data
  }

  void _filterData(String query) {
    setState(() {
      _filteredData =
          _data
              .where((item) => item.toLowerCase().contains(query.toLowerCase()))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Bar Example')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: _filterData, // Call filter function on text change
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredData.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(_filteredData[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}
