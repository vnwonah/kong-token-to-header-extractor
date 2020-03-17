return {
  postgres = {
    up = [[
      CREATE TABLE IF NOT EXISTS "token_to_header_extractor_table" (
        "id"                UUID                         PRIMARY KEY,
        "created_at"        TIMESTAMP WITH TIME ZONE     DEFAULT (CURRENT_TIMESTAMP(0) AT TIME ZONE 'UTC')
        "token_value_name"  TEXT                         
        "header_name"       TEXT                         
      );
      DO $$
      BEGIN
        CREATE INDEX IF NOT EXISTS "token_to_header_extractor_table_token_value_name"
                                ON "token_to_header_extractor_table" ("token_value_name");
      EXCEPTION WHEN UNDEFINED_COLUMN THEN
        -- Do nothing, accept existing state
      END$$;
    ]],
  },

  cassandra = {
    up = [[
      CREATE TABLE IF NOT EXISTS token_to_header_extractor_table (
        id                  uuid PRIMARY KEY,
        created_at          timestamp,
        token_value_name    text                         
        header_name         text  
      );
      
      CREATE INDEX IF NOT EXISTS ON token_to_header_extractor_table (token_value_name);
    ]],
  }
}