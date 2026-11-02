

if not game then
    script = require("test/relative-string");
end;
local v0 = require(script.Parent.switch);
return function(v1, v2, v3)
    return v0(function()
        return not not v1();
    end)({
        [true] = v2, 
        [false] = v3
    });
end;