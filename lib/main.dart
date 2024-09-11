import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipe Homes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Swipe Homes!'),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Find a Rental'),
              onPressed: () {
                // TODO: Implement rental search functionality
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('List My Property'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PropertyListingForm()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PropertyListingForm extends StatefulWidget {
  @override
  _PropertyListingFormState createState() => _PropertyListingFormState();
}

class _PropertyListingFormState extends State<PropertyListingForm> {
  List<XFile> _photos = [];
  final ImagePicker _picker = ImagePicker();
  
  // New controllers and variables
  final _priceController = TextEditingController();
  int _bedrooms = 1;
  int _bathrooms = 1;
  String _homeType = 'House';
  String _spaceType = 'Whole house';
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();

  Future<void> _addPhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(() {
        _photos.add(photo);
      });
    }
  }

  void _openFullScreenViewer(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenPhotoViewer(
          photos: _photos,
          initialIndex: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Your Property')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Property Photos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _photos.isEmpty
                  ? Center(child: Text('No photos added yet'))
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: _photos.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _openFullScreenViewer(index),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(_photos[index].path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
              SizedBox(height: 16),
              
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                  prefixText: '\$',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bedrooms'),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () => setState(() => _bedrooms = (_bedrooms > 1) ? _bedrooms - 1 : 1),
                            ),
                            Text('$_bedrooms'),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () => setState(() => _bedrooms++),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bathrooms'),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () => setState(() => _bathrooms = (_bathrooms > 1) ? _bathrooms - 1 : 1),
                            ),
                            Text('$_bathrooms'),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () => setState(() => _bathrooms++),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              
              DropdownButtonFormField<String>(
                value: _homeType,
                decoration: InputDecoration(labelText: 'Home Type'),
                items: ['House', 'Apartment/Condo', 'Townhome']
                    .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) => setState(() => _homeType = value!),
              ),
              SizedBox(height: 16),
              
              DropdownButtonFormField<String>(
                value: _spaceType,
                decoration: InputDecoration(labelText: 'Space'),
                items: ['Whole house', 'Single room']
                    .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) => setState(() => _spaceType = value!),
              ),
              SizedBox(height: 16),
              
              Text('Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextField(
                controller: _streetController,
                decoration: InputDecoration(labelText: 'Street'),
              ),
              TextField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'City'),
              ),
              TextField(
                controller: _stateController,
                decoration: InputDecoration(labelText: 'State'),
              ),
              TextField(
                controller: _zipController,
                decoration: InputDecoration(labelText: 'ZIP Code'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              
              ElevatedButton(
                child: Text('Next'),
                onPressed: () {
                  // TODO: Validate form fields
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TagScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPhoto,
        child: Icon(Icons.add_a_photo),
        tooltip: 'Add Photo',
      ),
    );
  }

  @override
  void dispose() {
    _priceController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    super.dispose();
  }
}

class FullScreenPhotoViewer extends StatefulWidget {
  final List<XFile> photos;
  final int initialIndex;

  FullScreenPhotoViewer({required this.photos, required this.initialIndex});

  @override
  _FullScreenPhotoViewerState createState() => _FullScreenPhotoViewerState();
}

class _FullScreenPhotoViewerState extends State<FullScreenPhotoViewer> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Photo ${_currentIndex + 1} of ${widget.photos.length}', style: TextStyle(color: Colors.white)),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.photos.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return InteractiveViewer(
            minScale: 0.5,
            maxScale: 4,
            child: Image.file(
              File(widget.photos[index].path),
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }
}

class TagScreen extends StatefulWidget {
  @override
  _TagScreenState createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  List<String> tags = ['Parking', 'Pet-friendly', 'Furnished', 'Balcony', 'Pool'];
  List<String> selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Property Features')),
      body: Column(
        children: [
          Wrap(
            spacing: 8.0,
            children: tags.map((tag) {
              bool isSelected = selectedTags.contains(tag);
              return FilterChip(
                label: Text(tag),
                selected: isSelected,
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      selectedTags.add(tag);
                    } else {
                      selectedTags.remove(tag);
                    }
                  });
                },
              );
            }).toList(),
          ),
          ElevatedButton(
            child: Text('Submit'),
            onPressed: () {
              // TODO: Handle form submission
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
        ],
      ),
    );
  }
}
