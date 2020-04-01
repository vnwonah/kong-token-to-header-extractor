local typedefs = require "kong.db.schema.typedefs"

return {
  name = "token-to-header-extractor",
  no_consumer = true,
  fields = {
    token_name = { 
      type = "string", 
      required = true
    },
    token_value_name = { 
      type = "string", 
      required = true
    },
    header_name = { 
      type = "string", 
      required = true
    },
  }
}