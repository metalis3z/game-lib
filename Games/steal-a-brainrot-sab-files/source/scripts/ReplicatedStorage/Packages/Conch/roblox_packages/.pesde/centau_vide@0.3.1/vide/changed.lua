

if not game then
    script = require("test/relative-string");
end;
local v0 = require(script.Parent.action)();
local v1 = require(script.Parent.cleanup);
return function(v2, v3)
    return v0(function(v4)
        local v5 = v4:GetPropertyChangedSignal(v2):Connect(function()
            v3(v4[v2]);
        end);
        v1(function()
            v5:Disconnect();
        end);
        v3(v4[v2]);
    end);
end;