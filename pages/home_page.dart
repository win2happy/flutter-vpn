import 'package:flutter/material.dart';
import 'package:vpn_app/providers/vpn_provider.dart';
import 'package:vpn_app/widgets/server_list.dart';
import 'package:vpn_app/widgets/vpn_control.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VPN App'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // 打开设置页面
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ServerList(),
          ),
          VPNControl(),
        ],
      ),
    );
  }
}
