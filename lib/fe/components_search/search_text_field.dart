import 'dart:async';

import 'package:flutter/material.dart';
import '../../be/api/api.dart';

class SearchTextField extends StatefulWidget {
  final ValueNotifier<bool> showResultsNotifier; // Add this notifier

  SearchTextField({required this.showResultsNotifier});

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _controller = TextEditingController();
  final GetApi api = GetApi(); // Instantiate GetApi
  List<Map<String, String>> _suggestions = [];
  Timer? _debounce; // For debouncing

  // Helper function to remove diacritical marks from Vietnamese characters
  String removeDiacritics(String text) {
    const vietnameseDiacriticsMap = {
      // Vietnamese diacritic mappings (as in your code)
      'á': 'a', 'à': 'a', 'ả': 'a', 'ã': 'a', 'ạ': 'a',
      'ă': 'a', 'ắ': 'a', 'ằ': 'a', 'ẳ': 'a', 'ẵ': 'a', 'ặ': 'a',
      'â': 'a', 'ấ': 'a', 'ầ': 'a', 'ẩ': 'a', 'ẫ': 'a', 'ậ': 'a',
      'é': 'e', 'è': 'e', 'ẻ': 'e', 'ẽ': 'e', 'ẹ': 'e',
      'ê': 'e', 'ế': 'e', 'ề': 'e', 'ể': 'e', 'ễ': 'e', 'ệ': 'e',
      'í': 'i', 'ì': 'i', 'ỉ': 'i', 'ĩ': 'i', 'ị': 'i',
      'ó': 'o', 'ò': 'o', 'ỏ': 'o', 'õ': 'o', 'ọ': 'o',
      'ô': 'o', 'ố': 'o', 'ồ': 'o', 'ổ': 'o', 'ỗ': 'o', 'ộ': 'o',
      'ơ': 'o', 'ớ': 'o', 'ờ': 'o', 'ở': 'o', 'ỡ': 'o', 'ợ': 'o',
      'ú': 'u', 'ù': 'u', 'ủ': 'u', 'ũ': 'u', 'ụ': 'u',
      'ư': 'u', 'ứ': 'u', 'ừ': 'u', 'ử': 'u', 'ữ': 'u', 'ự': 'u',
      'ý': 'y', 'ỳ': 'y', 'ỷ': 'y', 'ỹ': 'y', 'ỵ': 'y',
      'đ': 'd',
      'Á': 'A', 'À': 'A', 'Ả': 'A', 'Ã': 'A', 'Ạ': 'A',
      'Ă': 'A', 'Ắ': 'A', 'Ằ': 'A', 'Ẳ': 'A', 'Ẵ': 'A', 'Ặ': 'A',
      'Â': 'A', 'Ấ': 'A', 'Ầ': 'A', 'Ẩ': 'A', 'Ẫ': 'A', 'Ậ': 'A',
      'É': 'E', 'È': 'E', 'Ẻ': 'E', 'Ẽ': 'E', 'Ẹ': 'E',
      'Ê': 'E', 'Ế': 'E', 'Ề': 'E', 'Ể': 'E', 'Ễ': 'E', 'Ệ': 'E',
      'Í': 'I', 'Ì': 'I', 'Ỉ': 'I', 'Ĩ': 'I', 'Ị': 'I',
      'Ó': 'O', 'Ò': 'O', 'Ỏ': 'O', 'Õ': 'O', 'Ọ': 'O',
      'Ô': 'O', 'Ố': 'O', 'Ồ': 'O', 'Ổ': 'O', 'Ỗ': 'O', 'Ộ': 'O',
      'Ơ': 'O', 'Ớ': 'O', 'Ờ': 'O', 'Ở': 'O', 'Ỡ': 'O', 'Ợ': 'O',
      'Ú': 'U', 'Ù': 'U', 'Ủ': 'U', 'Ũ': 'U', 'Ụ': 'U',
      'Ư': 'U', 'Ứ': 'U', 'Ừ': 'U', 'Ử': 'U', 'Ữ': 'U', 'Ự': 'U',
      'Ý': 'Y', 'Ỳ': 'Y', 'Ỷ': 'Y', 'Ỹ': 'Y', 'Ỵ': 'Y',
      'Đ': 'D'
    };

    return text.split('').map((char) {
      return vietnameseDiacriticsMap[char] ?? char;
    }).join('');
  }

  // Fetch location suggestions based on input text
  Future<void> _fetchSuggestions(String query) async {
    try {
      List<Map<String, String>> suggestions = await api.searchLocation(query);
      setState(() {
        _suggestions = suggestions;
      });
      widget.showResultsNotifier.value = _suggestions.isNotEmpty;
    } catch (e) {
      print('Error fetching suggestions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey,
            hintText: 'Tìm kiếm thành phố',
            hintStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.search, color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (value) {
            if (_debounce?.isActive ?? false) {
              _debounce?.cancel();
            }

            if (value.isNotEmpty) { // Only call API if input has 1 or more characters
              _debounce = Timer(const Duration(milliseconds: 1000), () {
                _fetchSuggestions(removeDiacritics(value));
              });
            } else {
              setState(() {
                _suggestions = [];
              });
              widget.showResultsNotifier.value = false;
            }
          },
        ),
        SizedBox(height: 10),
        ..._suggestions.map((suggestion) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 13.0), // Space from left edge
              child: Row(
                children: [
                  // Circle icon container
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[800], // Dark gray background
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.white70, // Light gray icon color
                    ),
                  ),
                  SizedBox(width: 15), // Reduced space between icon and text
                  // ListTile for suggestion text
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero, // Remove inner padding of ListTile
                      title: Text(
                        suggestion['name'] ?? '',
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        '${suggestion['region']?.isNotEmpty == true ? '${suggestion['region']}, ' : ''}${suggestion['country'] ?? ''}',
                        style: TextStyle(color: Colors.grey),
                      ),
                      onTap: () {
                        _controller.text = suggestion['name'] ?? '';
                        setState(() {
                          _suggestions = [];
                        });
                        widget.showResultsNotifier.value = false;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DashedDivider(),
            ),
          ],
        )).toList(),
      ],
    );
  }



  @override
  void dispose() {
    _debounce?.cancel(); // Cancel timer when widget is disposed
    super.dispose();
  }
}

// Custom dashed line widget
class DashedDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        const dashWidth = 4.0;
        const dashSpace = 2.0;
        final dashCount = (constraints.constrainWidth() / (dashWidth + dashSpace)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return Container(
              width: dashWidth,
              height: 1,
              color: Colors.grey,
            );
          }),
        );
      },
    );
  }
}
