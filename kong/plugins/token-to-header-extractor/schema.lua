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
          {
            log_errors = {
              type = "boolean",
              default = false,
            },
          },
        },
      },
    },
  },
}