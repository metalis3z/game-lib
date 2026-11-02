

local v0 = require("../../roblox_packages/vide");
local l_create_0 = v0.create;
local l_read_0 = v0.read;
return function(v3)
    return l_create_0("Frame")({
        Name = "gap", 
        Size = function()
            return UDim2.fromOffset(l_read_0(v3.width) or 0, l_read_0(v3.height) or 0);
        end, 
        BackgroundTransparency = 1; 
        unpack(v3)
    });
end;