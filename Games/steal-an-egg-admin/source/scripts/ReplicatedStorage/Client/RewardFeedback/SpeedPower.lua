-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Item = require(ReplicatedStorage.Client.Notifications.Item)
local Rain = require(ReplicatedStorage.Client.UI.VFX.Rain)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {
    Duration = 1,
    Particles = {
        {
            Texture = "rbxassetid://99458650446228",
            SizeScalar = 3
        }
    },
    SprinkleSounds = {
        Volume = 1.3,
        RateScale = 2,
        DragOverride = -0.5,
        Assets = { "rbxassetid://92795549021030" },
        Pitch = { 0.9, 1.1 }
    }
}
local v2 = t.strict(t.number)
local v3 = {}

function v3.Announce(v4) -- line 25 | captures: Item, Rain, v1, v2
    v2(v4)
    local v5 = v4 > 0
    assert(v5, "a speed power announcement needs something above zero to announce")
    Rain.Fall(v1)
    Item.Bottom({
        Item = {
            Kind = "SpeedPower",
            Amount = math.round(v4)
        }
    })
end

return v3
