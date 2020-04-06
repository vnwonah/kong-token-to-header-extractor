# What is Kong Token to Header Extractor plugin

**kong-token-to-header-extractor** is a plugin for [Kong](https://github.com/Mashape/kong) that extracts values from jwt tokens in the header of incoming requests and forwards them as headers to the upstream server.

## How does it works

The plugin is configurable, it allows you specify what tokens to look for (eg. id_token), what values to extract from these tokens (eg. sub) and what header names to forward the values as (eg X-User-Id).

The user first has to register a token name, a key to look for in the token, and a header name to forward the value as (can register more than one token name and key) and what values to extract from said token. The plugin then checks if an incoming requests contains a tokens with the registered name and parses it using [`kong.plugins.jwt.jwt_parser`](https://github.com/Kong/kong/blob/master/kong/plugins/jwt/jwt_parser.lua) plugin.

Next it checks if the parsed token contains the spcified key, if it doesn't nothing is done to the request. If it finds the key, it retrieves the value and weadd it to the request header using `ngx.req.set_header` from [`openresty/lua-nginx-module`](https://github.com/openresty/lua-nginx-module).

## Dependencies

**kong-token-to-header-extractor** depends on the following package:

- [`kong.plugins.jwt.jwt_parser`](https://github.com/Kong/kong/blob/master/kong/plugins/jwt/jwt_parser.lua)

## Installation

If you're using `luarocks` execute the following:

    luarocks install kong-plugin-token-to-header-extractor

You also need to set the `KONG_PLUGINS` environment variable

    export KONG_PLUGINS=bundled,token-to-header-extractor

Note that this plugin uses custom entities so if you're adding it to an existing kong instance you will have to rerun you postgres or cassandra migrations.

## Usage

### Parameters

| Parameter | Default  | Required | description |
| --- | --- | --- | --- |
| `name` || true | plugin name, has to be `kong-token-to-header-extractor` |
| `log_error` || false | if specified token is not found on request or key is not found in parsed token an error is logged when set to true |

### Enabling

```
POST /plugins HTTP/1.1
Host: localhost:8001
Content-Type: application/x-www-form-urlencoded
Cache-Control: no-cache

name=token-to-header-extractor&config.log_errors=true
```

A successful response:
```
HTTP/1.1 201 Created
Date: Mon, 06 Apr 2020 19:37:38 GMT
Content-Type: application/json; charset=utf-8
Transfer-Encoding: chunked
Connection: keep-alive
Access-Control-Allow-Origin: *
Server: kong/0.11.0

{
    "created_at": 1586153328,
    "config": {
        "log_errors": true
    },
    "id": "66a2d158-86f7-458f-be32-599f061d952d",
    "service": null,
    "enabled": true,
    "protocols": [
        "grpc",
        "grpcs",
        "http",
        "https"
    ],
    "name": "token-to-header-extractor",
    "consumer": null,
    "route": null,
    "tags": null
}
```

### Configuring Token, Key and Header Name values

To configure the plugin, we make a post request with three properties:

-   The token_name to search for in the request headers
-   The key name to look for in the token
-   The header name to forward it as

```
POST /token_to_header_extractor HTTP/1.1
Host: localhost:8001
Content-Type: application/json
Cache-Control: no-cache
 
{
    "token_name": "id_token",
    "token_value_name": "sub",
    "header_name": "X-User-Id"
}
```

A successful response:
```
HTTP/1.1 201 Created
Date: Mon, 06 Apr 2020 19:37:38 GMT
Content-Type: application/json; charset=utf-8
Transfer-Encoding: chunked
Connection: keep-alive
Access-Control-Allow-Origin: *
Server: kong/0.11.0

{
    "created_at": 1586154281,
    "id": "27fff3ed-95e5-4db6-8dae-51cea5ccce8f",
    "token_value_name": "sub",
    "header_name": "X-User-Id",
    "token_name": "id_token"
}
```

Multiple post request can be made to configure different headers




