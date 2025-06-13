import 'package:flutter/material.dart';
import 'package:vpn_app/models/server.dart';
import 'package:vpn_app/services/vpn_service.dart';

class VPNProvider extends ChangeNotifier {
  Server? _selectedServer;
  VPNStatus _status = VPNStatus.disconnected;
  String _errorMessage = '';

  Server? get selectedServer => _selectedServer;
  VPNStatus get status => _status;
  String get errorMessage => _errorMessage;

  void selectServer(Server server) {
    _selectedServer = server;
    notifyListeners();
  }

  Future<void> connect() async {
    if (_selectedServer == null) {
      _errorMessage = 'Please select a server first';
      notifyListeners();
      return;
    }

    try {
      _status = VPNStatus.connecting;
      notifyListeners();

      await VPNService.connect(_selectedServer!);
      _status = VPNStatus.connected;
      _errorMessage = '';
    } catch (e) {
      _status = VPNStatus.disconnected;
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> disconnect() async {
    try {
      _status = VPNStatus.disconnecting;
      notifyListeners();

      await VPNService.disconnect();
      _status = VPNStatus.disconnected;
      _errorMessage = '';
    } catch (e) {
      _status = VPNStatus.connected;
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }
}

enum VPNStatus {
  disconnected,
  connecting,
  connected,
  disconnecting,
}
