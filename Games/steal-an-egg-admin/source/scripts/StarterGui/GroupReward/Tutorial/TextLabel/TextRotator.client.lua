-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local v1 = { "Like the Game for FREE PETS!", "Play for 30 Minutes for ADMIN!" }
local GroupRewardTextRotationEpoch = LocalPlayer:GetAttribute("GroupRewardTextRotationEpoch")

if typeof(GroupRewardTextRotationEpoch) ~= "number" then
    GroupRewardTextRotationEpoch = Workspace:GetServerTimeNow()
    LocalPlayer:SetAttribute("GroupRewardTextRotationEpoch", GroupRewardTextRotationEpoch)
end
local v2
while true do
    local v3
    if script.Parent then
        local v4 = Workspace:GetServerTimeNow() - GroupRewardTextRotationEpoch
        local v5 = math.max(0, v4) / 60
        v3 = math.floor(v5) % #v1 + 1
        if v3 == v2 then
            v3 = v2
        else
            script.Parent.Text = v1[v3]
        end
    else
        break
    end
    task.wait(0.25)
    v2 = v3
end
