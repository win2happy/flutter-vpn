import 'dart:async';
import 'dart:io';
import 'package:vpn_app/models/server.dart';
import 'package:flutter/services.dart';

class VPNService {
  static const MethodChannel _channel = MethodChannel('vpn_service');

  static Future<void> connect(Server server) async {
    try {
      // 根据协议类型调用不同的连接方法
      switch (server.protocol) {
        case 'vless':
          await _connectVless(server);
          break;
        case 'vmess':
          await _connectVmess(server);
          break;
        case 'ss':
          await _connectShadowsocks(server);
          break;
        default:
          throw Exception('Unsupported protocol: ${server.protocol}');
      }
    } on PlatformException catch (e) {
      throw Exception('Failed to connect: ${e.message}');
    }
  }

  static Future<void> _connectVless(Server server) async {
    // 调用原生平台的VLESS连接实现
    return _channel.invokeMethod('connectVless', {
      'server': server.address,
      'port': server.port,
      'uuid': server.uuid,
      'encryption': server.encryption,
      'tls': server.tls,
      'path': server.path,
    });
  }

  static Future<void> _connectVmess(Server server) async {
    // 调用原生平台的VMESS连接实现
    return _channel.invokeMethod('connectVmess', {
      'server': server.address,
      'port': server.port,
      'uuid': server.uuid,
      'alterId': server.alterId,
      'security': server.security,
      'tls': server.tls,
      'network': server.network,
      'path': server.path,
    });
  }

  static Future<void> _connectShadowsocks(Server server) async {
    // 调用原生平台的Shadowsocks连接实现
    return _channel.invokeMethod('connectShadowsocks', {
      'server': server.address,
      'port': server.port,
      'password': server.password,
      'method': server.method,
      'plugin': server.plugin,
      'pluginOpts': server.pluginOpts,
    });
  }

  static Future<void> disconnect() async {
    try {
      await _channel.invokeMethod('disconnect');
    } on PlatformException catch (e) {
      throw Exception('Failed to disconnect: ${e.message}');
    }
  }

  static Stream<VPNStatus> get statusStream {
    return const EventChannel('vpn_status').receiveBroadcastStream().map(
          (dynamic status) => _parseStatus(status),
        );
  }

  static VPNStatus _parseStatus(dynamic status) {
    switch (status) {
      case 'connecting':
        return VPNStatus.connecting;
      case 'connected':
        return VPNStatus.connected;
      case 'disconnecting':
        return VPNStatus.disconnecting;
      case 'disconnected':
      default:
        return VPNStatus.disconnected;
    }
  }
}

enum VPNStatus {
  disconnected,
  connecting,
  connected,
  disconnecting,
}
