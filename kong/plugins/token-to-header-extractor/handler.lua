local BasePlugin = require "kong.plugins.base_plugin"
local jwt_decoder = require "kong.plugins.jwt.jwt_parser"
local req_set_header = ngx.req.set_header
local ngx_re_gmatch = ngx.re.gmatch

local kong = kong

local TokenToHeaderExtractorHandler = BasePlugin:extend()

TokenToHeaderExtractorHandler.VERSION  = "0.1.0"
TokenToHeaderExtractorHandler.PRIORITY = 2

function TokenToHeaderExtractorHandler:new()
    TokenToHeaderExtractorHandler.super.new(self, "token-to-header-extractor")
end

function TokenToHeaderExtractorHandler:rewrite(config)
    -- Eventually, execute the parent implementation
    -- (will log that your plugin is entering this context)
    TokenToHeaderExtractorHandler.super.rewrite(self)
  
    -- Implement any custom logic here
    --local continue_on_error = conf.continue_on_error
    kong.log("Executing token to header extractor")

    for entity, err on kong.db.token_to_header_extractor:each(1000) do
        if err then
            kong.log.err("Error when iterating over keyauth credentials: " .. err)
            return nil
        end
        kong.log("token_name: " .. entity.token_name)
    end

end

return TokenToHeaderExtractorHandler