// /Users/odemi/Documents/Cihan/Flutter/prens/lib/widgets/add_denetim_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:prens/widgets/person_list.dart';
import 'package:prens/global_variables.dart' as globals;

class AddDenetimDialog extends StatefulWidget {
  const AddDenetimDialog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddDenetimDialogState createState() => _AddDenetimDialogState();
}

class _AddDenetimDialogState extends State<AddDenetimDialog> {
  final Color _backgroundColor = const Color(0xFFFFF8E1);
  final Color _textColor = const Color(0xFFE31C24);

  int _step = 1;

  int? _startDay;
  int? _startMonth;
  int? _startYear;
  int? _endDay;
  int? _endMonth;
  int? _endYear;

  final Map<String, String> _departmentAssignments = assignPeopleToDepartment();

  FixedExtentScrollController? _startDayController;
  FixedExtentScrollController? _startMonthController;
  FixedExtentScrollController? _startYearController;
  FixedExtentScrollController? _endDayController;
  FixedExtentScrollController? _endMonthController;
  FixedExtentScrollController? _endYearController;

  //List<String> people = ['Cihan Erdensdfsdfs.', 'Melisa E.']; // KALDIRILDI
 //List<String> people = ['Cihan Erdensdfsdfs.', 'Melisa E.']; // KALDIRILDI
  List<String> departments = ['ÜretimA', 'ÜretimB','ÜretimC','ÜretimD','ÜretimE','ÜretimF','ÜretimG','ÜretimA', 'ÜretimB','ÜretimC','ÜretimD','ÜretimE','ÜretimF','ÜretimG'];

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _startDay = now.day;
    _startMonth = now.month;
    _startYear = now.year;
    _endDay = _startDay;
    _endMonth = _startMonth;
    _endYear = _startYear;

    _startDayController = FixedExtentScrollController(initialItem: now.day - 1);
    _startMonthController = FixedExtentScrollController(initialItem: now.month - 1);
    _startYearController = FixedExtentScrollController(initialItem: years.indexOf(now.year));
    _endDayController = FixedExtentScrollController(initialItem: _startDay! - 1);
    _endMonthController = FixedExtentScrollController(initialItem: _startMonth! - 1);
    _endYearController = FixedExtentScrollController(initialItem: years.indexOf(_startYear!));


  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }


  @override
  void dispose() {
    _startDayController?.dispose();
    _startMonthController?.dispose();
    _startYearController?.dispose();
    _endDayController?.dispose();
    _endMonthController?.dispose();
    _endYearController?.dispose();
    super.dispose();
  }

  List<int> days = List.generate(31, (index) => index + 1);
  List<int> months = List.generate(12, (index) => index + 1);
  List<int> years = List.generate(51, (index) => DateTime.now().year - 25 + index); // 25 years in past and future

  Widget _buildCupertinoPicker(List<int> data, int? selectedValue, ValueChanged<int> onChanged, FixedExtentScrollController controller) {
    return Expanded(
      child: SizedBox(
        height: 100,
        child: CupertinoPicker(
          scrollController: controller,
          itemExtent: 32.0,
          onSelectedItemChanged: onChanged,
          children: data.map((item) => Center(child: Text(item.toString(), style: TextStyle(fontSize: 20, color: _textColor)))).toList(),
        ),
      ),
    );
  }

  Future<void> _showPersonSelector(String department) async {
    final selectedPerson = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return PersonSelectionList(
          onSelect: (person) {
            // Selection logic for the dialog
            Navigator.pop(context, person); // Pop the bottom sheet with the selected person
          },
          enableDeletion: false, // Disable deletion
          enableAdding: false, // Disable adding
        );
      },
    );

    if (selectedPerson != null) {
      setState(() {
        _departmentAssignments[department] = selectedPerson;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: _backgroundColor,
      content: Material(
        color: Colors.transparent,
        child: Builder(
          builder: (context) {
            switch (_step) {
              case 1:
                return Container(
                  height: 300,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: _backgroundColor,
                    border: Border.all(color: _textColor, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Başlangıç Tarihi', style: TextStyle(color: _textColor)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildCupertinoPicker(
                            days,
                            _startDay,
                            (index) => setState(() => _startDay = days[index]),
                            _startDayController!,
                          ),
                          _buildCupertinoPicker(
                            months,
                            _startMonth,
                            (index) => setState(() => _startMonth = months[index]),
                            _startMonthController!,
                          ),
                          _buildCupertinoPicker(
                            years,
                            _startYear,
                            (index) => setState(() => _startYear = years[index]),
                            _startYearController!,
                          ),
                        ],
                      ),
                      Text('Bitiş Tarihi', style: TextStyle(color: _textColor)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildCupertinoPicker(
                            days,
                            _endDay,
                            (index) => setState(() => _endDay = days[index]),
                            _endDayController!,
                          ),
                          _buildCupertinoPicker(
                            months,
                            _endMonth,
                            (index) => setState(() => _endMonth = months[index]),
                            _endMonthController!,
                          ),
                          _buildCupertinoPicker(
                            years,
                            _endYear,
                            (index) => setState(() => _endYear = years[index]),
                            _endYearController!,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
            case 2:
              return Container(
                height: 300,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: _backgroundColor,
                  border: Border.all(color: _textColor, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(8),
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: globals.departmentList.map((department) {

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: _textColor, // red
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(department, style: TextStyle(color: _backgroundColor)), // cream
                        GestureDetector(
                          onTap: () => _showPersonSelector(department),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: _backgroundColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text((_departmentAssignments[department] ?.split(' ').first ?? ''), style: TextStyle(color: _textColor)),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
                ),
              );
            default:
              return SizedBox.shrink();
          }
        },
      ),
      ),
      actions: [
        if (_step == 1)
          TextButton(
            child: Text('İptal', style: TextStyle(color: _textColor)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        if (_step == 2)
          TextButton(
            child: Text('Geri', style: TextStyle(color: _textColor)),
            onPressed: () {
              setState(() {
                _step = 1;
              });
            },
          ),
        if (_step == 1)
          TextButton(
            child: Text('Devam', style: TextStyle(color: _textColor)),
            onPressed: () {
              setState(() {
                _step = 2;
              });
            },
          ),
        if (_step == 2)
          TextButton(
            child: Text('Kaydet', style: TextStyle(color: _textColor)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
      ],
    );
  }
}

Map<String, String> assignPeopleToDepartment() {
  final Map<String, String> assignments = {};

  for (var department in globals.departmentList) {
    assignments[department] = globals.peopleList.first;
  }

  return assignments;
}