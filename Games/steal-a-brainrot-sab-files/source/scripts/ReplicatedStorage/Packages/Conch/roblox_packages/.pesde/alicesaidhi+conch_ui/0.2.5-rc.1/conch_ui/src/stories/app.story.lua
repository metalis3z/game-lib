

local v0 = require("../../roblox_packages/conch");
local v1 = require("../../roblox_packages/vide");
local v2 = require("../app");
local v3 = require("../state");
return function(v4)
    v3.opened(true);
    v0.register_default_commands();
    v0._.create_local_user();
    return v1.mount(function()
        return v2();
    end, v4);
end;