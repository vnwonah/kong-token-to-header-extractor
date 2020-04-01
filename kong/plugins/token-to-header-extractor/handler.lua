local BasePlugin = require "kong.plugins.base_plugin"
local jwt_decoder = require "kong.plugins.jwt.jwt_parser"
local req_set_header = ngx.req.set_header
local ngx_re_gmatch = ngx.re.gmatch

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
    local continue_on_error = conf.continue_on_error
end

return TokenToHeaderExtractorHandler