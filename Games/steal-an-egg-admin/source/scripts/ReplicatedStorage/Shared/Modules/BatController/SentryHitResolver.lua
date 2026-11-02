-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local t = require(ReplicatedStorage.Packages.t)
local Sentries = Workspace.__OBJECTS.Sentries
local Folder = Sentries:IsA("Folder")
assert(Folder, "Workspace.__OBJECTS.Sentries must be a Folder")
return function(v1, v2) -- line 12 | captures: t, Sentries
    t.strict(t.Vector3)(v1)
    t.strict(t.number)(v2)
    for v3, v4 in ipairs(Sentries:GetChildren()) do
        if v4:IsA("Model") and (v4:GetPivot().Position - v1).Magnitude <= v2 then
            v4:Destroy()
        end
    end
end
