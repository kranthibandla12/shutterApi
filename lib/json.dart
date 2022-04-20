import 'dart:io';

// import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> fetchJson() async {
  //print("4");
  final response = await http.get(
    Uri.parse('https://api.shutterstock.com/v2/images/search'),
    headers: {
      HttpHeaders.authorizationHeader:
          'Bearer v2/dXUxMVk2TmExUXZ6VUJBQ2xiRWFKS2hRZ2xNU2UyaWwvMzI3OTEzMzc2L2N1c3RvbWVyLzQvWm5KOE9KdzF6eThPMWFPb2RVMFdZYS1CVlBVYkQ4Z1piSnlXUmFUNUhiajlTcTRKNThDLTJlZ2Rka0FHUnJqTDZLX2JmOXMyUzRjLXpSMWcxeXEtNXF2ZElnY01xblhfclJwTkJ3Nmpha3VFSXdscGdXUXBpVDNETVdLdV91Y3c3WV9Ca3RDdURLdkFFWGE0MS1lNTBQWWFZWUtucTV3X3dzbi1wQnZSdElMRzJhY19aQzlQYkN4X0psQkVpNnRxTHIxNnBnQzM1MUl1WGw2bmFvUUZsdy9KWE5oWnlGSTU1bmstY24tUzhrM1Z3',
    },
  );
  if (response.statusCode == 200) {
    print("200");
  }
  //print("5");
  final responseJson = await json.decode(response.body);

  // print(responseJson);
  return responseJson;
}
