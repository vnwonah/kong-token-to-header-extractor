local BasePlugin = require "kong.plugins.base_plugin"
local jwt_decoder = require "kong.plugins.jwt.jwt_parser"
local req_set_header = ngx.req.set_header
local ngx_re_gmatch = ngx.re.gmatch

local kong = kong

local TokenToHeaderExtractorHandler = BasePlugin:extend()

TokenToHeaderExtractorHandler.VERSION  = "0.1.0"
-- TokenToHeaderExtractorHandler.PRIORITY = 2

function TokenToHeaderExtractorHandler:new()
    TokenToHeaderExtractorHandler.super.new(self, "token-to-header-extractor")
end

function TokenToHeaderExtractorHandler:access(conf)
    -- Eventually, execute the parent implementation
    -- (will log that your plugin is entering this context)
    TokenToHeaderExtractorHandler.super.access(self)
  
    -- Implement any custom logic here
    local log_errors = conf.log_errors
    kong.log("Executing token to header extractor continue on error is: " .. log_errors)

    for entity, err in kong.db.token_to_header_extractor:each(100) do
        if err then
            kong.log.err("Error when iterating over token to header extractor credentials: " .. err)
            return nil
        end
        kong.log("token_name: " .. entity.token_name)
    end

end

return TokenToHeaderExtractorHandler