class Server {
  final String id;
  final String name;
  final String country;
  final String flag;
  final String protocol;
  final String address;
  final int port;
  
  // VLESS specific
  final String? uuid;
  final String? encryption;
  final bool? tls;
  final String? path;
  
  // VMESS specific
  final int? alterId;
  final String? security;
  final String? network;
  
  // Shadowsocks specific
  final String? password;
  final String? method;
  final String? plugin;
  final String? pluginOpts;

  Server({
    required this.id,
    required this.name,
    required this.country,
    required this.flag,
    required this.protocol,
    required this.address,
    required this.port,
    this.uuid,
    this.encryption,
    this.tls,
    this.path,
    this.alterId,
    this.security,
    this.network,
    this.password,
    this.method,
    this.plugin,
    this.pluginOpts,
  });

  factory Server.fromJson(Map<String, dynamic> json) {
    return Server(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      flag: json['flag'],
      protocol: json['protocol'],
      address: json['address'],
      port: json['port'],
      uuid: json['uuid'],
      encryption: json['encryption'],
      tls: json['tls'],
      path: json['path'],
      alterId: json['alterId'],
      security: json['security'],
      network: json['network'],
      password: json['password'],
      method: json['method'],
      plugin: json['plugin'],
      pluginOpts: json['pluginOpts'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'flag': flag,
      'protocol': protocol,
      'address': address,
      'port': port,
      'uuid': uuid,
      'encryption': encryption,
      'tls': tls,
      'path': path,
      'alterId': alterId,
      'security': security,
      'network': network,
      'password': password,
      'method': method,
      'plugin': plugin,
      'pluginOpts': pluginOpts,
    };
  }
}
