import 'package:flutter/material.dart';
import 'package:football_universe/controllers/app_controller.dart';
import 'package:football_universe/res/constants.dart';
import 'package:football_universe/widgets/custom_app_bar.dart';
import 'package:football_universe/widgets/custom_drawer.dart';
import 'package:football_universe/widgets/filter_popup_menu.dart';
import 'package:get/get.dart';

class HomeTemplate extends StatefulWidget {
  final String appBartitle;
  final Widget child;
  final Function()? onFilterChange;
  const HomeTemplate({required this.appBartitle, required this.child, this.onFilterChange, Key? key})
      : super(key: key);

  @override
  State<HomeTemplate> createState() => _HomeTemplateState();
}

class _HomeTemplateState extends State<HomeTemplate> {
  late final AppController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.find<AppController>();
    if(controller.showPopupMenu.value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
    controller.showPopupMenu.value = false;
    });
    } 
      
  }
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawerEnableOpenDragGesture: false,
        drawer: ClipRRect(
            borderRadius:
                const BorderRadius.only(bottomRight: Radius.circular(30)),
            child: CustomDrawer(
              scaffoldKey: scaffoldKey,
            )),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              Column(
                children: [
                  CustomAppBar(
                    title: widget.appBartitle,
                    onLeadingTap: () => scaffoldKey.currentState!.openDrawer(),
                    onTrailingTap: widget.appBartitle == ConstantStrings.favorites
                        ? null
                        : controller.togglePopupMenu,
                  ),
                  Expanded(child: widget.child),
                ],
              ),
              Obx(() => 
              controller.showPopupMenu.value ?  Positioned(
                    top: 56,
                    right: 0,
                    child: FilterPopupMenu(onApplyFilters: widget.onFilterChange!,)): const SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
