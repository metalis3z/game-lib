-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local AssetOverrides = require(ReplicatedStorage.Shared.Utils.AssetOverrides)
ReplicatedStorage:WaitForChild("Shared"):WaitForChild("AssetOverridesData", 10)

if AssetOverrides.IsEmpty() then
    return
end
local LocalPlayer = Players.LocalPlayer
AssetOverrides.Watch(ReplicatedStorage)
AssetOverrides.Watch(SoundService)
AssetOverrides.Watch(Workspace)
AssetOverrides.ApplyToDirectories()

local function watchPlayerGui() -- line 37 | captures: AssetOverrides, LocalPlayer
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if PlayerGui then
        AssetOverrides.Watch(PlayerGui)
    end
end

local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")

if PlayerGui then
    AssetOverrides.Watch(PlayerGui)
end
LocalPlayer.ChildAdded:Connect(function(v1) -- line 45 | captures: AssetOverrides
    if v1:IsA("PlayerGui") then
        AssetOverrides.Watch(v1)
    end
end)
