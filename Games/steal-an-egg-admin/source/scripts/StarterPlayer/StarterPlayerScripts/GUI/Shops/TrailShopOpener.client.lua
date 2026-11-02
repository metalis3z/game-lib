-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Tabs = require(ReplicatedStorage.Client.Tabs)
local v1 = {}
local v2 = { __mode = "k" }
local v3 = setmetatable(v1, v2)

local function bindPad(v4) -- line 7 | captures: LocalPlayer, Tabs, v3
    if not (v4.Name == "TrailShop") or not v4:IsA("BasePart") or v3[v4] or not v4.Parent or not (v4.Parent.Name == "Pads") or not v4.Parent.Parent or not (v4.Parent.Parent.Name == "Stands") then
        return
    end
    v3[v4] = true
    local TouchRegion = v4:WaitForChild("TouchRegion")
    local v5 = {}
    local v6 = false
    TouchRegion.Touched:Connect(function(v7) -- line 14 | captures: v6, v5, LocalPlayer, Tabs
        local Character = LocalPlayer.Character
        if not (Character and v7:IsDescendantOf(Character)) then
            return
        end
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        if Humanoid and not (Humanoid.Health <= 0) then
            v5[v7] = true
            if not v6 then
                v6 = true
                Tabs.Show("TrailShop")
            end
        end
    end)
    TouchRegion.TouchEnded:Connect(function(v8) -- line 25 | captures: v6, v5, LocalPlayer
        v5[v8] = nil
        task.delay(0.2, function() -- line 27 | captures: v6, v5, LocalPlayer
            for v9 in v5 do
                if v9.Parent and LocalPlayer.Character then
                    if not v9:IsDescendantOf(LocalPlayer.Character) then
                        v5[v9] = nil
                    end
                else
                    v5[v9] = nil
                end
            end
            if next(v5) == nil then
                v6 = false
            end
        end)
    end)
    LocalPlayer.CharacterAdded:Connect(function() -- line 34 | captures: v6, v5
        table.clear(v5)
        v6 = false
    end)
end

for v10, v11 in workspace:GetDescendants() do
    bindPad(v11)
end
workspace.DescendantAdded:Connect(bindPad)
