local endpoints = require "kong.api.endpoints"

local token_to_header_extractor_schema = kong.db.token_to_header_extractor.schema

return {
  ["/token-to-header-extractor"] = {
    schema = token_to_header_extractor_schema,
    methods = {
      GET = endpoints.get_collection_endpoint(token_to_header_extractor_schema),
      POST = endpoints.post_collection_endpoint(token_to_header_extractor_schema),
      PATCH  = endpoints.patch_entity_endpoint(token_to_header_extractor_schema),
      DELETE = endpoints.delete_entity_endpoint(token_to_header_extractor_schema),
    },
  },
}