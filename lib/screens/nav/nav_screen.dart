import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram/models/enums/bottom_nav_items.dart';
import 'package:flutter_instagram/repositories/auth/auth_repository.dart';
import 'package:flutter_instagram/screens/login/cubit/login_cubit.dart';
import 'package:flutter_instagram/screens/nav/cubit/bottom_nav_bar_cubit.dart';
import 'package:flutter_instagram/screens/nav/widgets/bottom_nav_bar.dart';
import 'package:flutter_instagram/widgets/tab_navigator.dart';

class NavScreen extends StatelessWidget {
  static const routeName = "/nav";

  final Map<BottomNavItem, GlobalKey<NavigatorState>> navigatorKeys = {
    BottomNavItem.feed: GlobalKey<NavigatorState>(),
    BottomNavItem.search: GlobalKey<NavigatorState>(),
    BottomNavItem.create: GlobalKey<NavigatorState>(),
    BottomNavItem.notifications: GlobalKey<NavigatorState>(),
    BottomNavItem.profile: GlobalKey<NavigatorState>(),
  };

  final Map<BottomNavItem, IconData> items = const {
    BottomNavItem.feed: Icons.home,
    BottomNavItem.search: Icons.search,
    BottomNavItem.create: Icons.add,
    BottomNavItem.notifications: Icons.favorite_border,
    BottomNavItem.profile: Icons.account_circle,
  };

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomNavBarCubit>(
      create: (_) => BottomNavBarCubit(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            // TODO: implement listener}
          },
          child: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
            builder: (context, state) {
              return Scaffold(
                body: Stack(
                  children: items
                      .map(
                        (item, _) => MapEntry(
                          item,
                          _buildOffStageNavigator(
                              item, item == state.selectedItem),
                        ),
                      )
                      .values
                      .toList(),
                ),
                bottomNavigationBar: BottomNavBar(
                  items: items,
                  selectedItem: state.selectedItem,
                  onTap: (index) {
                    print(index);
                    final selectedItem = BottomNavItem.values[index];
                    context
                        .read<BottomNavBarCubit>()
                        .updateSelectedItem(selectedItem);
                    _selectedBottomNavItem(context, selectedItem,
                        selectedItem == state.selectedItem);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _selectedBottomNavItem(
      BuildContext context, BottomNavItem selectedItem, bool isSameItem) {
    if (isSameItem) {
      navigatorKeys[selectedItem]
          .currentState
          .popUntil((route) => route.isFirst);
    }
  }

  Widget _buildOffStageNavigator(BottomNavItem currentItem, bool isSelected) {
    return Offstage(
      offstage: !isSelected,
      child: TabNavigator(
        navigatorKey: navigatorKeys[currentItem],
        item: currentItem
      ),
    );
  }
}
