import 'package:flutter/material.dart';
import 'package:football_universe/controllers/matches_controller.dart';
import 'package:football_universe/res/color_manager.dart';
import 'package:football_universe/res/constants.dart';
import 'package:football_universe/res/font_manager.dart';
import 'package:football_universe/res/size_manager.dart';
import 'package:football_universe/widgets/sub_template.dart';
import 'package:football_universe/widgets/template.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  late final MatchesController controller;
  final DateRangePickerController dateRangePickerController =
      DateRangePickerController();
  final List<String> months = [
    "January",
    "Feburary",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  List<DateTime> selectedDates = [];
  late int month;
  late int year;
  bool isChanging = false;
  nextMonth() {
    isChanging = true;
    dateRangePickerController.forward!();
    month++;
    if (month > 12) {
      month = 1;
      year++;
    }
    setState(() {});

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isChanging = false;
      });
    });
  }

  previousMonth() {
    isChanging = true;
    dateRangePickerController.backward!();
    month--;
    if (month < 1) {
      month = 12;
      year--;
    }
    setState(() {});
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        isChanging = false;
      });
    });
  }

  onSelectionChange(DateRangePickerSelectionChangedArgs args) {
    // final List<DateTime> currentSelectedDateList = args.value;
    if (selectedDates.length == 4 && args.value.length >= 4) {
      // setState(() {
      // });
      dateRangePickerController.selectedDates = selectedDates;
      return;
    } else {
      // setState(() {
      // });
      
      selectedDates = args.value;
    }
    selectedDates.sort();
    // if(args.value)
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.find<MatchesController>();
    selectedDates.addAll(controller.selectedDates);
    month = selectedDates[0].month;
    year = selectedDates[0].year;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(selectedDates.length < 4)return;
    Future.delayed(Duration.zero,()=> controller.selectedDates.value = selectedDates);
  }
  @override
  Widget build(BuildContext context) {
    return SubTemplate(
      appBartitle: ConstantStrings.calender,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // TextButton("openMonth cell", onPressed: openMonthCell,),
          SizedBox(
            height: SizeManager.getResponsiveWidth(SizeManager.big),
          ),
          Container(
            width: SizeManager.getResponsiveWidth(210),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: ColorManager.appBarBackground,
                    stops: const [0.0, 1.0]),
                borderRadius: BorderRadius.circular(
                    SizeManager.getResponsiveWidth(SizeManager.biggest))),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: !isChanging ? previousMonth : null,
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: SizeManager.getResponsiveWidth(SizeManager.biggest),
                    ),
                  ),
                  Text(
                    "${months[month - 1]} $year",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontSize:
                            SizeManager.getResponsiveWidth(SizeManager.big),
                        color: ColorManager.lightAccent,
                        fontFamily: FontFamily.modernaSans),
                  ),
                  GestureDetector(
                    onTap: !isChanging ? nextMonth : null,
                    child: Icon(Icons.arrow_forward_ios_rounded,
                        size: SizeManager.getResponsiveWidth(
                            SizeManager.biggest)),
                  )
                ]),
          ),
          SizedBox(
            height: SizeManager.getResponsiveWidth(SizeManager.biggest),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal:SizeManager.getResponsiveWidth(SizeManager.small)),
            child: SfDateRangePicker(
              viewSpacing: 30,
              onSelectionChanged: onSelectionChange,
              todayHighlightColor: ColorManager.disabled,
              headerHeight: 0,
              monthViewSettings: DateRangePickerMonthViewSettings(
                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                  textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontSize: SizeManager.getResponsiveWidth(SizeManager.big),
                      color: ColorManager.disabled),
                ),
              ),
              monthCellStyle: DateRangePickerMonthCellStyle(
                  textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontSize: SizeManager.getResponsiveWidth(SizeManager.big))),
              // showNavigationArrow: true,
              selectionMode: DateRangePickerSelectionMode.multiple,
              
              controller: dateRangePickerController,
              initialSelectedDates: selectedDates,
              navigationMode: DateRangePickerNavigationMode.none,
              enableMultiView: false,
              selectionColor: ColorManager.activeTab,
              selectionTextStyle: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(
                      fontSize: SizeManager.getResponsiveWidth(SizeManager.big),
                      color: ColorManager.lightAccent),
            ),
          ),
        ],
      ),
    );
  }
}
