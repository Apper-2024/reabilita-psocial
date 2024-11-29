import 'package:flutter/material.dart';
import 'package:reabilita_social/utils/colors.dart';

class MenuTab extends StatelessWidget {
  final List<Tab> tabs;
  final TabController controller;

  const MenuTab({
    super.key,
    required this.tabs,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xffEDEDED),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TabBar(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        tabs: tabs,
        labelColor: preto1,
        indicatorColor: branco,
        unselectedLabelColor: cinza1,
        isScrollable: false,
        dividerHeight: 0,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: branco,
        ),
        padding: const EdgeInsets.all(6),
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle:  const TextStyle(
              fontFamily: 'Poppins',

            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: preto1,
          ),
        
      ),
    );
  }
}
