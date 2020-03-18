return {
    no_consumer = true, -- this plugin will only be applied to Services or Routes,
    fields = {
      -- Describe your plugin's configuration's schema here.
      token_name = { type = "string", required = true},
      token_value_name = { type = "string", required = true},
      header_name = { type = "string", required = true}
    },
}