local typedefs = require "kong.db.schema.typedefs"

--[[ return {
  name = "token-to-header-extractor",
  fields = {
    { consumer = typedefs.no_consumer },
    { config = {
      type = "record",
      fields = {
        { token_name = { 
          type = "string", 
          required = true
        }},
        { token_name = { 
          type = "string", 
          required = true
        }},
        { header_name = { 
          type = "string", 
          required = true
        }}
      }
    }}
  }
} ]]

return {
  name = "token-to-header-extractor",
  fields = {
    { consumer = typedefs.no_consumer },
    { config = {
      type = "record",
      fields = {
        { max_msg_size = {
          type = "number",
          required = false,
          default = 4194304
        }},
        { capability_upstream = {
           type = "map",
           keys = { type = "string" },
           values = { type = "string" },
           required = false,
           default = {
             ["string1:substring1"] = "127.0.0.1:8082",
             ["string2:substring2"] = "127.0.0.1:8083"
           }
        }}
      }
    }}
  }
}