

if not game then
    script = require("test/relative-string");
end;
local v0 = require(script.Parent.root);
local v1 = require(script.Parent.apply);
return function(v2, v3)
    return v0(function()
        local v4 = v2();
        if v3 then
            v1(v3, {
                v4
            });
        end;
    end);
end;