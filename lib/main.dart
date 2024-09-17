import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to Swipe Homes!'),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Find a Rental'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RentalWantsAndNeeds()),
                );
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('List My Property'),
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

class RentalWantsAndNeeds extends StatefulWidget {
  const RentalWantsAndNeeds({super.key});

  @override
  _RentalWantsAndNeedsState createState() => _RentalWantsAndNeedsState();
}

class _RentalWantsAndNeedsState extends State<RentalWantsAndNeeds> {
  RangeValues _priceRange = const RangeValues(0, 10000);
  String _bedrooms = 'ANY';
  String _bathrooms = 'ANY';
  String _houseType = 'House';
  String _spaceType = 'Entire Place';
  String _zipCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rental Wants and Needs')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Price Range', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            RangeSlider(
              values: _priceRange,
              min: 0,
              max: 10000,
              divisions: 50,
              labels: RangeLabels(
                _priceRange.start == 0 ? 'No Min' : '\$${_priceRange.start.round()}',
                _priceRange.end == 10000 ? 'No Max' : '\$${_priceRange.end.round()}',
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _priceRange = values;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text('Bedrooms', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _bedrooms,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  _bedrooms = newValue!;
                });
              },
              items: ['ANY', '1+', '2+', '3+', '4+', '5+']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text('Bathrooms', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _bathrooms,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  _bathrooms = newValue!;
                });
              },
              items: ['ANY', '1+', '2+', '3+', '4+', '5+']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text('House Type', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _houseType,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  _houseType = newValue!;
                });
              },
              items: ['House', 'Apartment/Condo', 'Townhome']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text('Space', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _spaceType,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  _spaceType = newValue!;
                });
              },
              items: ['Entire Place', 'Room']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text('Zip Code', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter zip code',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _zipCode = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TagsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TagsScreen extends StatefulWidget {
  const TagsScreen({super.key});

  @override
  _TagsScreenState createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  Set<String> selectedTags = {};

  final List<String> tags = [
    'Basement',
    'A/C',
    'Pool',
    'Waterfront',
    'Garage',
    'Pets-Friendly',
    'Laundry',
    'Disabled Access',
    'Furnished',
    'Outdoor Space',
    'Elevator',
    'Utilities Included',
    'Hardwood Floors',
    'On-Site Parking',
    'Short Term Lease Available',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Property Tags')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Property Features', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: tags.map((tag) {
                  return FilterChip(
                    label: Text(tag),
                    selected: selectedTags.contains(tag),
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
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Search'),
                onPressed: () {
                  // TODO: Implement search functionality
                  print('Selected tags: $selectedTags');
                  // Navigate to search results or perform search action
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PropertyListingForm extends StatefulWidget {
  const PropertyListingForm({super.key});

  @override
  _PropertyListingFormState createState() => _PropertyListingFormState();
}

class _PropertyListingFormState extends State<PropertyListingForm> {
  final List<XFile> _photos = [];
  final ImagePicker _picker = ImagePicker();
  
  // New controllers and variables
  final _priceController = TextEditingController();
  int _bedrooms = 1;
  int _bathrooms = 1;
  String _homeType = 'House';
  String _spaceType = 'Entire Space';
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();
  final _squareFeetController = TextEditingController();

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
      appBar: AppBar(title: const Text('List Your Property')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Property Photos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _photos.isEmpty
                  ? const Center(child: Text('No photos added yet'))
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
              const SizedBox(height: 16),
              
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  prefixText: '\$',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Bedrooms'),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => setState(() => _bedrooms = (_bedrooms > 1) ? _bedrooms - 1 : 1),
                            ),
                            Text('$_bedrooms'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => setState(() => _bedrooms = (_bedrooms < 15) ? _bedrooms + 1 : 15),
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
                        const Text('Bathrooms'),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => setState(() => _bathrooms = (_bathrooms > 1) ? _bathrooms - 1 : 1),
                            ),
                            Text('$_bathrooms'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => setState(() => _bathrooms = (_bathrooms < 15) ? _bathrooms + 1 : 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              DropdownButtonFormField<String>(
                value: _homeType,
                decoration: const InputDecoration(labelText: 'Home Type'),
                items: ['House', 'Apartment/Condo', 'Townhome']
                    .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) => setState(() => _homeType = value!),
              ),
              const SizedBox(height: 16),
              
              DropdownButtonFormField<String>(
                value: _spaceType,
                decoration: const InputDecoration(labelText: 'Space'),
                items: ['Entire Space', 'Room']
                    .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) => setState(() => _spaceType = value!),
              ),
              const SizedBox(height: 16),
              
              TextField(
                controller: _squareFeetController,
                decoration: const InputDecoration(
                  labelText: 'Square Feet',
                  suffixText: 'sq ft',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              
              const Text('Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextField(
                controller: _streetController,
                decoration: const InputDecoration(labelText: 'Street'),
              ),
              TextField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'City'),
              ),
              TextField(
                controller: _stateController,
                decoration: const InputDecoration(labelText: 'State'),
              ),
              TextField(
                controller: _zipController,
                decoration: const InputDecoration(labelText: 'ZIP Code'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              
              ElevatedButton(
                child: const Text('Next'),
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
        tooltip: 'Add Photo',
        child: Icon(Icons.add_a_photo),
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
    _squareFeetController.dispose();
    super.dispose();
  }
}

class FullScreenPhotoViewer extends StatefulWidget {
  final List<XFile> photos;
  final int initialIndex;

  const FullScreenPhotoViewer({super.key, required this.photos, required this.initialIndex});

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
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Photo ${_currentIndex + 1} of ${widget.photos.length}', style: const TextStyle(color: Colors.white)),
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
  const TagScreen({super.key});

  @override
  _TagScreenState createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  List<String> tags = [
    'Basement', 'A/C', 'Pool', 'Waterfront', 'Garage', 
    'Pets-Friendly', 'Laundry', 'Disabled Access', 'Furnished', 
    'Outdoor Space', 'Elevator', 'Utilities Included', 
    'Hardwood Floors', 'On-Site Parking', 'Short Term Lease Available'
  ];
  List<String> selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Property Features')),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                // TODO: Handle form submission
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
