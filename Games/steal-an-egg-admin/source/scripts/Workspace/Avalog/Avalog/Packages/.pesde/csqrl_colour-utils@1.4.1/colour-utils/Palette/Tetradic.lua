-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Assert = require(script.Parent.Parent.Util.Assert)
local Rotate = require(script.Parent.Parent.Rotate)
require(script.Parent.Parent.Util.Types)
local Tetradic = Assert.prepTypeOf("Tetradic")
return function(v1) -- line 16 | captures: Rotate, Tetradic
    Tetradic("base", "Color3", v1)
    return {
        Rotate(v1, -180),
        Rotate(v1, -120),
        Rotate(v1, -300)
    }
end
