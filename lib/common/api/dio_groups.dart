import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart';
import 'package:listenall/common/services/index.dart';
import 'package:pointycastle/export.dart';
import 'package:hex/hex.dart';

import 'package:dio/dio.dart';

class NeteaseOptions {
  String? crypto;
  Map<String, dynamic> cookie;
  String? userAgent;
  Map<String, dynamic>? headers;

  NeteaseOptions({
    this.crypto,
    this.cookie = const {},
    this.userAgent,
    this.headers,
  });

  factory NeteaseOptions.fromJson(Map<String, dynamic> json) {
    return NeteaseOptions(
      crypto: json['crypto'],
      cookie: json['cookie'] ?? {},
      userAgent: json['userAgent'],
      headers: json['headers'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'crypto': crypto,
      'cookie': cookie,
      'userAgent': userAgent,
    };
  }
}

class DioGroups {
  // 私有构造函数
  DioGroups._internal() {
    netease = getNeteaseDio();
    qq = getQQDio();
  }

  // 单例实例
  static final DioGroups _instance = DioGroups._internal();

  // 工厂构造函数
  factory DioGroups() {
    return _instance;
  }

  // Dio实例
  final Dio bilibili = Dio(BaseOptions(headers: {
    'user-agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3',
    'referer': 'https://www.bilibili.com/',
    'cookie': 'SESSDATA=xxx'
  }));

  late Dio qq;
  Dio getQQDio() {
    qq = Dio(BaseOptions(responseType: ResponseType.plain, headers: {
      'user-agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3',
      'referer': 'https://y.qq.com/',
    }));
    qq.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.responseType = ResponseType.bytes;

          return handler.next(options);
        },
        onResponse: (response, handler) {
          response.data = jsonDecode(utf8.decode(response.data));
          return handler.next(response);
        },
      ),
    );
    return qq;
  }

  late Dio netease;
  Dio getNeteaseDio() {
    const base62 =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    const iv = '0102030405060708';
    const presetKey = '0CoJUm6Qyw8W8jud';
    const linuxapiKey = 'rFgB&h#%2?^eDg:Q';
    const publicKeyPem = '''-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDgtQn2JZ34ZC28NWYpAUd98iZ37BUrX/aKzmFbt7clFSs6sXqHauqKWqdtLkF2KexO40H1YTX8z2lSgBBOAxLsvaklV8k4cBFK9snQXE9/DDaFt6Rr7iVZMldczhC0JNgTz+SHXT6CBHuX3e9SdB1Ua44oncaTWz7OBGLbCiK45wIDAQAB
-----END PUBLIC KEY-----''';
    const eapiKey = 'e82ckenh8dichen8';
    final anonymousToken = DatabaseService.to.box.get('anonymous_token');
    String generateRandomString(int length) {
      const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
      Random random = Random();
      return List.generate(
          length, (index) => chars[random.nextInt(chars.length)]).join();
    }

    String chooseUserAgent(String? type) {
      const userAgentMap = {
        "mobile":
            'Mozilla/5.0 (iPhone; CPU iPhone OS 17_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4.1 Mobile/15E148 Safari/604.1',
        "pc":
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36 Edg/124.0.0.0',
      };
      return userAgentMap[type] ??
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36 Edg/124.0.0.0';
    }

    String aesEncrypt(String text, String mode, String key, String iv,
        [String format = 'base64']) {
      final keyBytes = utf8.encode(key);
      // ignore: unused_local_variable
      final ivBytes = utf8.encode(iv);
      final textBytes = utf8.encode(text);

      final cipher = PaddedBlockCipher('AES/${mode.toUpperCase()}/PKCS7')
        ..init(
            true,
            PaddedBlockCipherParameters<CipherParameters, CipherParameters>(
                KeyParameter(Uint8List.fromList(keyBytes)), null));

      final encryptedBytes = cipher.process(Uint8List.fromList(textBytes));
      if (format == 'base64') {
        return base64.encode(encryptedBytes);
      }

      return HEX.encode(encryptedBytes).toUpperCase();
    }

    String aesDecrypt(String ciphertext, String key, String iv,
        [String format = 'base64']) {
      final keyBytes = utf8.encode(key);
      final ivBytes = utf8.encode(iv);
      Uint8List encryptedBytes;

      if (format == 'base64') {
        encryptedBytes = base64.decode(ciphertext);
      } else {
        encryptedBytes = Uint8List.fromList(HEX.decode(ciphertext));
      }

      final cipher = PaddedBlockCipher('AES/ECB/PKCS7')
        ..init(
            false,
            ParametersWithIV(KeyParameter(Uint8List.fromList(keyBytes)),
                Uint8List.fromList(ivBytes)));

      final decryptedBytes = cipher.process(encryptedBytes);
      return utf8.decode(decryptedBytes);
    }

    String rsaEncrypt(String str, String key) {
      final parser = RSAKeyParser();
      final publicKey = parser.parse(key) as RSAPublicKey;

      final encryptor = RSAEngine()
        ..init(true, PublicKeyParameter<RSAPublicKey>(publicKey));

      final encryptedBytes =
          encryptor.process(Uint8List.fromList(utf8.encode(str)));
      return const HexEncoder().convert(encryptedBytes);
    }

    Map<String, String> weapi(Map<String, dynamic> object) {
      final text = json.encode(object);
      final random = Random();
      final secretKey =
          List.generate(16, (_) => base62[random.nextInt(62)]).join();

      return {
        'params': aesEncrypt(
            aesEncrypt(text, 'cbc', presetKey, iv), 'cbc', secretKey, iv),
        'encSecKey':
            rsaEncrypt(secretKey.split('').reversed.join(), publicKeyPem),
      };
    }

    Map<String, String> linuxapi(Map<String, dynamic> object) {
      final text = json.encode(object);
      return {
        'eparams': aesEncrypt(text, 'ecb', linuxapiKey, '', 'hex'),
      };
    }

    Map<String, String> eapi(String url, dynamic object) {
      final text = object is Map<String, dynamic>
          ? json.encode(object)
          : object.toString();
      final message = 'nobody${url}use${text}md5forencrypt';
      final digest = md5.convert(utf8.encode(message)).toString();
      final data = '$url-36cd479b6b5-$text-36cd479b6b5-$digest';

      return {
        'params': aesEncrypt(data, 'ecb', eapiKey, '', 'hex'),
      };
    }

    // ignore: unused_element
    Map<String, dynamic> eapiResDecrypt(String encryptedParams) {
      final decryptedData = aesDecrypt(encryptedParams, eapiKey, '', 'hex');
      return json.decode(decryptedData);
    }

    // ignore: unused_element
    Map<String, dynamic>? eapiReqDecrypt(String encryptedParams) {
      final decryptedData = aesDecrypt(encryptedParams, eapiKey, '', 'hex');
      final match = RegExp(r'(.*?)-36cd479b6b5-(.*?)-36cd479b6b5-(.*)')
          .firstMatch(decryptedData);

      if (match != null) {
        final url = match.group(1);
        final data = json.decode(match.group(2)!);
        return {'url': url, 'data': data};
      }

      return null;
    }

    // ignore: unused_element
    String decrypt(String cipherText) {
      final encryptedBytes = const HexDecoder().convert(cipherText);
      final cipher = PaddedBlockCipher('AES/ECB/PKCS7')
        ..init(false, KeyParameter(Uint8List.fromList(utf8.encode(eapiKey))));

      final decryptedBytes = cipher.process(Uint8List.fromList(encryptedBytes));
      return utf8.decode(decryptedBytes);
    }

    Dio netease = Dio(BaseOptions(headers: {}));
    netease.interceptors.add(InterceptorsWrapper(onRequest: (_, handler) async {
      final options = NeteaseOptions.fromJson(_.data['options']);
      var cookie = options.cookie;
      Map<String, dynamic> data = {};
      data.addAll(_.data['data']);
      final headers = {
        'User-Agent': options.userAgent ?? chooseUserAgent(null),
        'os': cookie['os'] ?? 'ios',
        'appver': cookie['appver'] ?? (cookie['os'] != 'pc' ? '9.0.65' : ''),
        ...options.headers ?? {},
      };
      if (_.method == "POST") {
        headers["Content-Type"] = "application/x-www-form-urlencoded";
      }
      if (options.cookie.isNotEmpty) {
        options.cookie = {
          ...options.cookie,
          '_remember_me': true,
          '_ntes_nuid': generateRandomString(16),
          'os': options.cookie["os"] ?? 'ios',
          'appver': options.cookie["appver"] ??
              (options.cookie["os"] != 'pc' ? '9.0.65' : ''),
        };
        if (!_.path.contains('login')) {
          options.cookie["NMTID"] = generateRandomString(16);
        }
        if (options.cookie["MUSIC_U"] == null) {
          if (options.cookie["MUSIC_A"] == null) {
            options.cookie["MUSIC_A"] = anonymousToken;
          }
        }
        headers['Cookie'] =
            options.cookie.entries.map((e) => '${e.key}=${e.value}').join('; ');
      } else {
        final cookie = {
          '_remember_me': true,
          'NMTID': 'xxx',
          'os': 'ios',
          'appver': '9.0.65'
        };
        headers['Cookie'] =
            cookie.entries.map((e) => '${e.key}=${e.value}').join('; ');
      }
      String url = '';
      if (options.crypto == 'weapi') {
        headers['Referer'] = 'https://music.163.com';
        headers['User-Agent'] = options.userAgent ?? chooseUserAgent('pc');
        final csrfToken = (headers['Cookie'] ?? '').contains('_csrf=')
            ? headers['Cookie'].split('_csrf=')[1].split(';')[0]
            : '';
        data['csrf_token'] = csrfToken;
        data = weapi(data);
        url = 'https://music.163.co/weapi/${_.path.substring(5)}';
      } else if (options.crypto == 'linuxapi') {
        headers["User-Agent"] =
            'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36';
        data = linuxapi({
          'method': _.method,
          'url': "https://interface.music.163.com${_.path}",
          'params': data,
        });
        url = 'https://music.163.com/api/linux/forward';
      } else if (['eapi', 'api', ''].contains(options.crypto)) {
        final cookie = options.cookie;
        final csrfToken = cookie['__csrf'] ?? '';
        final header = {
          "NMTID": cookie['NMTID'] ?? 'xxx',
          'osver': cookie['osver'] ?? '17.4.1',
          //'deviceId': cookie['deviceId'] ?? global.deviceId,
          'appver': cookie['appver'] ?? '9.0.65',
          'versioncode': cookie['versioncode'] ?? '140',
          'mobilename': cookie['mobilename'] ?? '',
          'buildver': cookie['buildver'] ??
              DateTime.now().millisecondsSinceEpoch.toString().substring(0, 10),
          'resolution': cookie['resolution'] ?? '1920x1080',
          '__csrf': csrfToken,
          'os': cookie['os'] ?? 'ios',
          'channel': cookie['channel'] ?? '',
          'requestId':
              '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(1000).toString().padLeft(4, '0')}',
        };
        if (cookie['MUSIC_U'] != null && cookie['MUSIC_U'] != "") {
          header['MUSIC_U'] = cookie['MUSIC_U'];
        }
        if (cookie['MUSIC_A'] != null && cookie['MUSIC_A'] != "") {
          header['MUSIC_A'] = cookie['MUSIC_A'];
        }
        headers['Cookie'] = header.entries
            .map((e) =>
                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
            .join('; ');
        if (options.crypto == 'eapi') {
          data['header'] = header;
          data = eapi(_.path, data);
          url = 'https://interface3.music.163.com/eapi${_.path}';
        } else if (options.crypto == "api") {
          url = 'https://music.163.com${_.path}';
        } else {
          url = 'https://music.163.com${_.path}';
        }
      } else {
        debugPrint('[ERR] Unknown Crypto: ${options.crypto}');
        return;
      }
      _.headers = headers;
      _.data = null;
      _.queryParameters = data;
      _.path = url;

      return handler.next(_);
    }));
    return netease;
  }
}
