-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = require(script:FindFirstAncestor("HallucinationClass"));
local v1 = {};
v1.__index = v1;
v1.ApplyAt = 1;
v1.ForceApply = true;
setmetatable(v1, v0);
v1.new = function(...) --[[ Line: 13 ]] --[[ Name: new ]]
    -- upvalues: v0 (copy), v1 (copy)
    return (setmetatable(v0.new(...), v1));
end;
v1.Init = function(_) --[[ Line: 19 ]] --[[ Name: Init ]]

end;
v1.Destroy = function(v3) --[[ Line: 23 ]] --[[ Name: Destroy ]]
    v3:Screamer();
    v3:Clean();
end;
return v1;