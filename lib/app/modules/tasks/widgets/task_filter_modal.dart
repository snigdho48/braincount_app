import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';

class TaskFilterModal extends StatefulWidget {
  final Function(Map<String, dynamic>) onApply;
  final Map<String, dynamic>? initialFilters;

  const TaskFilterModal({
    super.key,
    required this.onApply,
    this.initialFilters,
  });

  @override
  State<TaskFilterModal> createState() => _TaskFilterModalState();
}

class _TaskFilterModalState extends State<TaskFilterModal> {
  // Applied filters
  final List<String> appliedFilters = [];
  
  // Task Name filters
  final List<String> taskNames = ['Task name 1', 'Task name 2', 'Task name 3'];
  final Set<String> selectedTaskNames = {};
  bool taskNameExpanded = false;

  // Location filters
  final List<String> locations = ['Mohammadpur, Dhaka', 'Mymensingh', 'Mirpur'];
  final Set<String> selectedLocations = {};
  bool locationExpanded = false;

  // Date filters
  DateTime? startDate;
  DateTime? endDate;
  bool dateExpanded = false;
  DateTime selectedMonth = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.initialFilters != null) {
      // Load initial filters
      final initial = widget.initialFilters!;
      if (initial['taskNames'] != null) {
        selectedTaskNames.addAll((initial['taskNames'] as List).cast<String>());
        // Add to applied filters for display
        appliedFilters.addAll((initial['taskNames'] as List).cast<String>());
      }
      if (initial['locations'] != null) {
        selectedLocations.addAll((initial['locations'] as List).cast<String>());
        // Add to applied filters for display
        appliedFilters.addAll((initial['locations'] as List).cast<String>());
      }
      if (initial['startDate'] != null) {
        startDate = initial['startDate'];
      }
      if (initial['endDate'] != null) {
        endDate = initial['endDate'];
        // Add date range to applied filters
        final dateLabel = '${startDate!.day}-${endDate!.day} ${_getMonthName(startDate!.month)} ${startDate!.year.toString().substring(2)}';
        appliedFilters.add(dateLabel);
      }
      if (initial['appliedFilters'] != null) {
        appliedFilters.addAll((initial['appliedFilters'] as List).cast<String>());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.85,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Responsive.radiusLg + Responsive.sp(8)),
          topRight: Radius.circular(Responsive.radiusLg + Responsive.sp(8)),
        ),
      ),
      child: Column(
        children: [
          // Header
          _buildHeader(),
          
          // Applied Filters Chips
          if (appliedFilters.isNotEmpty) _buildAppliedFilters(),
          
          // Filter Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: Responsive.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Responsive.mdVertical),
                  
                  // Task Name Filter
                  _buildFilterSection(
                    title: 'Task Name',
                    isExpanded: taskNameExpanded,
                    onToggle: () => setState(() => taskNameExpanded = !taskNameExpanded),
                    child: taskNameExpanded ? _buildCheckboxList(taskNames, selectedTaskNames, 'task') : null,
                  ),
                  
                  SizedBox(height: Responsive.mdVertical),
                  
                  // Location Filter
                  _buildFilterSection(
                    title: 'Location',
                    isExpanded: locationExpanded,
                    onToggle: () => setState(() => locationExpanded = !locationExpanded),
                    child: locationExpanded ? _buildCheckboxList(locations, selectedLocations, 'location') : null,
                  ),
                  
                  SizedBox(height: Responsive.mdVertical),
                  
                  // Date Filter
                  _buildFilterSection(
                    title: 'Date',
                    isExpanded: dateExpanded,
                    onToggle: () => setState(() => dateExpanded = !dateExpanded),
                    child: dateExpanded ? _buildCalendar() : null,
                  ),
                  
                  SizedBox(height: Responsive.xlVertical),
                ],
              ),
            ),
          ),
          
          // Action Buttons
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.md,
        vertical: Responsive.mdVertical,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.dividerColor.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: Responsive.sp(48),
              height: Responsive.sp(48),
              alignment: Alignment.center,
              child: Icon(
                Icons.close,
                color: AppColors.primaryText,
                size: Responsive.iconSize,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Filters',
              style: TextStyle(
                fontSize: Responsive.fontSize(18),
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: Responsive.sp(48)),
        ],
      ),
    );
  }

  Widget _buildAppliedFilters() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.md,
        vertical: Responsive.smVertical + Responsive.sp(4),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: Responsive.sp(12),
          children: appliedFilters.map((filter) {
            return Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.sp(12),
                  vertical: Responsive.sp(6),
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D), // Match Figma design
                  borderRadius: BorderRadius.circular(Responsive.sp(15)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      filter,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.white,
                        fontSize: Responsive.fontSize(14),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: Responsive.sp(10)),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          appliedFilters.remove(filter);
                          // Also remove from selected items
                          selectedTaskNames.remove(filter);
                          selectedLocations.remove(filter);
                          // If it's a date filter, clear dates
                          if (filter.contains('-') && (filter.contains('Jan') || filter.contains('Feb') || filter.contains('Mar') || filter.contains('Apr') || filter.contains('May') || filter.contains('Jun') || filter.contains('Jul') || filter.contains('Aug') || filter.contains('Sep') || filter.contains('Oct') || filter.contains('Nov') || filter.contains('Dec'))) {
                            startDate = null;
                            endDate = null;
                          }
                        });
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                        size: Responsive.sp(12),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildFilterSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onToggle,
    Widget? child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: Responsive.fontSize(16),
            fontWeight: FontWeight.w500,
            color: AppColors.primaryText,
          ),
        ),
        SizedBox(height: Responsive.smVertical),
        GestureDetector(
          onTap: onToggle,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.sp(20),
              vertical: Responsive.sp(9),
            ),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(Responsive.radiusSm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isExpanded ? title : 'Select',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(12),
                    color: AppColors.primaryText,
                  ),
                ),
                Transform.rotate(
                  angle: isExpanded ? -1.5708 : 1.5708, // 90 or -90 degrees
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.primaryText,
                    size: Responsive.sp(10),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (child != null) ...[
          SizedBox(height: Responsive.smVertical),
          child,
        ],
      ],
    );
  }

  Widget _buildCheckboxList(List<String> items, Set<String> selectedItems, String type) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Responsive.md),
      child: Column(
        children: items.map((item) {
          final isSelected = selectedItems.contains(item);
          return GestureDetector(
            onTap: () {
              setState(() {
                if (isSelected) {
                  selectedItems.remove(item);
                  appliedFilters.remove(item);  // Remove from applied filters
                } else {
                  selectedItems.add(item);
                  if (!appliedFilters.contains(item)) {
                    appliedFilters.add(item);  // Add to applied filters
                  }
                }
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: Responsive.smVertical + Responsive.sp(4)),
              child: Row(
                children: [
                  Container(
                    width: Responsive.sp(20),
                    height: Responsive.sp(20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.border,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(Responsive.sp(4)),
                      color: isSelected ? AppColors.info : Colors.transparent,
                    ),
                    child: isSelected
                        ? Icon(
                            Icons.check,
                            color: Colors.white,
                            size: Responsive.sp(14),
                          )
                        : null,
                  ),
                  SizedBox(width: Responsive.sp(12)),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: Responsive.fontSize(16),
                        color: AppColors.primaryText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.md),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(Responsive.radiusMd),
      ),
      child: Column(
        children: [
          // Month navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedMonth = DateTime(selectedMonth.year, selectedMonth.month - 1);
                  });
                },
                icon: Icon(
                  Icons.chevron_left,
                  color: AppColors.primaryText,
                  size: Responsive.sp(18),
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              Expanded(
                child: Text(
                  '${_getMonthName(selectedMonth.month)} ${selectedMonth.year}',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(16),
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedMonth = DateTime(selectedMonth.year, selectedMonth.month + 1);
                  });
                },
                icon: Icon(
                  Icons.chevron_right,
                  color: AppColors.primaryText,
                  size: Responsive.sp(18),
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          SizedBox(height: Responsive.sp(8)),
          
          // Calendar grid
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final daysInMonth = DateTime(selectedMonth.year, selectedMonth.month + 1, 0).day;
    final firstDayOfMonth = DateTime(selectedMonth.year, selectedMonth.month, 1);
    final weekdayOfFirst = firstDayOfMonth.weekday % 7; // 0 = Sunday
    final cellSize = (Get.width - (Responsive.md * 4)) / 7; // Calculate cell size based on available width
    
    return Column(
      children: [
        // Weekday headers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((day) {
            return SizedBox(
              width: cellSize,
              height: Responsive.sp(32),
              child: Center(
                child: Text(
                  day,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(13),
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        
        // Calendar days
        ...List.generate((daysInMonth + weekdayOfFirst) ~/ 7 + 1, (weekIndex) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (dayIndex) {
              final dayNumber = weekIndex * 7 + dayIndex - weekdayOfFirst + 1;
              
              if (dayNumber < 1 || dayNumber > daysInMonth) {
                return SizedBox(
                  width: cellSize,
                  height: cellSize,
                );
              }
              
              final date = DateTime(selectedMonth.year, selectedMonth.month, dayNumber);
              final isSelected = (startDate != null && endDate != null &&
                  date.isAfter(startDate!.subtract(const Duration(days: 1))) &&
                  date.isBefore(endDate!.add(const Duration(days: 1))));
              final isStartOrEnd = (startDate != null && _isSameDay(date, startDate!)) ||
                  (endDate != null && _isSameDay(date, endDate!));
              
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (startDate == null || (startDate != null && endDate != null)) {
                      startDate = date;
                      endDate = null;
                      // Remove old date filter from applied filters
                      appliedFilters.removeWhere((filter) => filter.contains('Jan') || filter.contains('Feb') || filter.contains('Mar') || filter.contains('Apr') || filter.contains('May') || filter.contains('Jun') || filter.contains('Jul') || filter.contains('Aug') || filter.contains('Sep') || filter.contains('Oct') || filter.contains('Nov') || filter.contains('Dec'));
                    } else if (date.isAfter(startDate!)) {
                      endDate = date;
                      // Add date range to applied filters
                      final dateLabel = '${startDate!.day}-${endDate!.day} ${_getMonthName(startDate!.month)} ${startDate!.year.toString().substring(2)}';
                      appliedFilters.removeWhere((filter) => filter.contains('Jan') || filter.contains('Feb') || filter.contains('Mar') || filter.contains('Apr') || filter.contains('May') || filter.contains('Jun') || filter.contains('Jul') || filter.contains('Aug') || filter.contains('Sep') || filter.contains('Oct') || filter.contains('Nov') || filter.contains('Dec'));
                      appliedFilters.add(dateLabel);
                    } else {
                      endDate = startDate;
                      startDate = date;
                      // Add date range to applied filters
                      final dateLabel = '${startDate!.day}-${endDate!.day} ${_getMonthName(startDate!.month)} ${startDate!.year.toString().substring(2)}';
                      appliedFilters.removeWhere((filter) => filter.contains('Jan') || filter.contains('Feb') || filter.contains('Mar') || filter.contains('Apr') || filter.contains('May') || filter.contains('Jun') || filter.contains('Jul') || filter.contains('Aug') || filter.contains('Sep') || filter.contains('Oct') || filter.contains('Nov') || filter.contains('Dec'));
                      appliedFilters.add(dateLabel);
                    }
                  });
                },
                child: Container(
                  width: cellSize,
                  height: cellSize,
                  decoration: BoxDecoration(
                    color: isSelected || isStartOrEnd ? AppColors.cardBackground.withOpacity(0.5) : Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(isStartOrEnd && (startDate != null && _isSameDay(date, startDate!)) ? cellSize / 2 : 0),
                      bottomLeft: Radius.circular(isStartOrEnd && (startDate != null && _isSameDay(date, startDate!)) ? cellSize / 2 : 0),
                      topRight: Radius.circular(isStartOrEnd && (endDate != null && _isSameDay(date, endDate!)) ? cellSize / 2 : 0),
                      bottomRight: Radius.circular(isStartOrEnd && (endDate != null && _isSameDay(date, endDate!)) ? cellSize / 2 : 0),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: cellSize * 0.9,
                      height: cellSize * 0.9,
                      decoration: BoxDecoration(
                        color: isStartOrEnd ? AppColors.info : Colors.transparent,
                        borderRadius: BorderRadius.circular(cellSize / 2),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$dayNumber',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(13),
                          fontWeight: FontWeight.w500,
                          color: isStartOrEnd ? Colors.white : AppColors.primaryText,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(Responsive.md),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.dividerColor.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: _applyFilters,
              child: Container(
                height: Responsive.sp(40),
                decoration: BoxDecoration(
                  color: AppColors.info,
                  borderRadius: BorderRadius.circular(Responsive.radiusSm),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Apply',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(14),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: Responsive.sp(12)),
          Expanded(
            child: GestureDetector(
              onTap: _resetFilters,
              child: Container(
                height: Responsive.sp(40),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  border: Border.all(color: AppColors.border, width: 1),
                  borderRadius: BorderRadius.circular(Responsive.radiusSm),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(14),
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _applyFilters() {
    final filters = {
      'taskNames': selectedTaskNames.toList(),
      'locations': selectedLocations.toList(),
      'startDate': startDate,
      'endDate': endDate,
      'appliedFilters': appliedFilters,
    };
    widget.onApply(filters);
    Get.back();
  }

  void _resetFilters() {
    setState(() {
      selectedTaskNames.clear();
      selectedLocations.clear();
      startDate = null;
      endDate = null;
      appliedFilters.clear();
      taskNameExpanded = false;
      locationExpanded = false;
      dateExpanded = false;
    });
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }
}

