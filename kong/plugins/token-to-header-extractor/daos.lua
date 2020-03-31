local typedefs = require "kong.db.schema.typedefs"

return {
    token_to_header_extractor = {
        name = "token_to_header_extractor",
        primary_key = { "id" },
        generate_admin_api = true,
        fields = {
            { id = typedefs.uuid },
            { created_at = typedefs.auto_timestamp_s },
            { token_name = { type = "string", required = true, unique = false, auto = true }, },
            { token_value_name = { type = "string", required = true, unique = false, auto = true }, },
            { header_name = { type = "string", required = true, unique = false, auto = true }, },
        },
    },
}