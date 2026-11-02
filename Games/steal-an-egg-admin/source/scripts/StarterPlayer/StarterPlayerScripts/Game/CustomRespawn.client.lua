-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local LocalPlayer = Players.LocalPlayer

local function requestCharacterReset(v1) -- line 11 | captures: Remotes
    Remotes.RigSync.AskRigWipe:FireServer(v1)
end

LocalPlayer.CharacterAdded:Connect(function(v2) -- line 14 | captures: Remotes
    v2:WaitForChild("Humanoid").Died:Connect(function() -- line 15 | captures: v2, Remotes
        Remotes.RigSync.AskRigWipe:FireServer(v2)
    end)
end)

if not LocalPlayer.Character then
    return
end
local Character = LocalPlayer.Character
Character:WaitForChild("Humanoid").Died:Connect(function() -- line 21 | captures: Remotes, Character
    Remotes.RigSync.AskRigWipe:FireServer(Character)
end)
