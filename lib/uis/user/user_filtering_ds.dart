import 'package:flutter/material.dart';
import 'package:peat/states/types_states.dart';

class UserFilteringDS extends StatelessWidget with _UserFilteringDSComponents {
  final UserFilter userFilter;
  final Function(UserFilter) onSelectedFilter;

  UserFilteringDS({Key key, this.userFilter, this.onSelectedFilter})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<UserFilter>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      icon: popupIcon(userFilter),
      tooltip: 'Filtrar usuário por',
      onSelected: (value) => onSelectedFilter(value),
      itemBuilder: (context) => <PopupMenuItem<UserFilter>>[
        PopupMenuItem<UserFilter>(
          value: UserFilter.sispat,
          child: Row(
            children: [sispatIcon, Text(UserFilter.sispat.name)],
          ),
        ),
        PopupMenuItem<UserFilter>(
          value: UserFilter.displayName,
          child: Row(
            children: [displayNameIcon, Text(UserFilter.displayName.name)],
          ),
        ),
      ],
    );
  }
}

class _UserFilteringDSComponents {
  final sispatIcon = Icon(Icons.branding_watermark);
  final displayNameIcon = Icon(Icons.near_me);
  final plataformIdOnBoardIcon = Icon(Icons.place);
  final dateTimeOnBoardIcon = Icon(Icons.date_range);
  Icon popupIcon(UserFilter userFilter) {
    var icon = sispatIcon;
    if (userFilter == UserFilter.displayName) {
      icon = displayNameIcon;
    } else if (userFilter == UserFilter.plataformIdOnBoard) {
      icon = plataformIdOnBoardIcon;
    } else if (userFilter == UserFilter.dateTimeOnBoard) {
      icon = dateTimeOnBoardIcon;
    }
    return icon;
  }
}
