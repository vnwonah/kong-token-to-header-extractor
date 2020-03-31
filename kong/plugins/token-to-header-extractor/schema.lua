local typedefs = require "kong.db.schema.typedefs"

return {
  name = "token-to-header-extractor",
  fields = {
    {
      consumer = typedefs.no_consumer
    },
    {
      config = {
        type = "record",
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
        },
      },
    },
  },
}