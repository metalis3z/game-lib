-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Assert = require(script.Parent.Parent.Util.Assert)
local Rotate = require(script.Parent.Parent.Rotate)
require(script.Parent.Parent.Util.Types)
local Complementary = Assert.prepTypeOf("Complementary")
return function(v1) -- line 16 | captures: Rotate, Complementary
    Complementary("base", "Color3", v1)
    return { Rotate(v1, 180) }
end
