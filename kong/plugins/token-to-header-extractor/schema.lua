local typedefs = require "kong.db.schema.typedefs"

return {
  name = "token-to-header-extractor",
  fields = {
    { consumer = typedefs.no_consumer }
  }
} 