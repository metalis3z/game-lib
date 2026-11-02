-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Types)
local Visuals = require(script.Parent.Visuals)
local v1 = {}
local v2 = {
    Id = "Silver",
    Label = "Silver",
    EarningsScalar = 1.2,
    RollWeight = 6,
    IconAssetId = 108639493197858,
    Tint = Color3.fromRGB(192, 192, 192)
}

function v2.Apply(v3, v4, v5) -- line 16 | captures: Visuals
    Visuals.ApplySilver(v4, v5)
end

function v2.Clear(v6, v7, v8) -- line 19 | captures: Visuals
    Visuals.ClearSilver(v7, v8)
end

v1.Silver = v2

local v9 = {
    Id = "Golden",
    Label = "Golden",
    EarningsScalar = 2.5,
    RollWeight = 4,
    IconAssetId = 134818382291054,
    Tint = Color3.fromRGB(251, 255, 0)
}

function v9.Apply(v10, v11, v12) -- line 30 | captures: Visuals
    Visuals.ApplyGolden(v11, v12)
end

function v9.Clear(v13, v14, v15) -- line 33 | captures: Visuals
    Visuals.ClearGolden(v14, v15)
end

v1.Golden = v9

local v16 = {
    Id = "Rainbow",
    Label = "Rainbow",
    EarningsScalar = 3.5,
    RollWeight = 1,
    IconAssetId = 85288683002868,
    Tint = Color3.fromRGB(255, 0, 255)
}

function v16.Apply(v17, v18, v19) -- line 44 | captures: Visuals
    Visuals.ApplyRainbow(v18, v19)
end

function v16.Clear(v20, v21, v22) -- line 47 | captures: Visuals
    Visuals.ClearRainbow(v21, v22)
end

v1.Rainbow = v16

local v23 = {
    Id = "Monstrous",
    Label = "Parasite",
    EarningsScalar = 3,
    RollWeight = 0,
    EggModelName = "Monstrous Egg",
    EggDisplayName = "Parasite Egg",
    EggIcon = "rbxassetid://121553987798547",
    Tint = Color3.fromRGB(65, 21, 138)
}

function v23.Apply(v24, v25, v26) -- line 60 | captures: Visuals
    Visuals.ApplyBloom(v25, v26, "Monstrous", "Cleanup_Monstrous", v24.Tint, 0.5)
end

function v23.Clear(v27, v28, v29) -- line 63 | captures: Visuals
    Visuals.ClearBloom(v28, v29, "Cleanup_Monstrous")
end

v1.Monstrous = v23

local v30 = {
    Id = "Sakura",
    Label = "Bloom",
    EarningsScalar = 1.25,
    RollWeight = 0,
    IconAssetId = 71612969542341,
    Tint = Color3.fromRGB(255, 196, 222)
}

function v30.Apply(v31, v32, v33) -- line 74 | captures: Visuals
    Visuals.ApplyBloom(v32, v33, "Sakura", "Cleanup_Sakura", v31.Tint)
end

function v30.Clear(v34, v35, v36) -- line 77 | captures: Visuals
    Visuals.ClearBloom(v35, v36, "Cleanup_Sakura")
end

v1.Sakura = v30

local v37 = {
    Id = "GreatBloom",
    Label = "Spirit Bloom",
    EarningsScalar = 2.5,
    RollWeight = 0,
    IconAssetId = 70859376044018,
    Tint = Color3.fromRGB(60, 255, 140)
}

function v37.Apply(v38, v39, v40) -- line 88 | captures: Visuals
    Visuals.ApplyBloom(v39, v40, "GreatBloom", "Cleanup_GreatBloom", v38.Tint)
end

function v37.Clear(v41, v42, v43) -- line 91 | captures: Visuals
    Visuals.ClearBloom(v42, v43, "Cleanup_GreatBloom")
end

v1.GreatBloom = v37
for v44, v45 in v1 do
    table.freeze(v45)
end
return table.freeze(v1)
