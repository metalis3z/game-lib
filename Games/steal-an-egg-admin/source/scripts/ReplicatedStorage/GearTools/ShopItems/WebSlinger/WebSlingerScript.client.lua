-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ToolGameplayGuard = require(ReplicatedStorage.Client.ToolGameplayGuard)
local LocalPlayer = Players.LocalPlayer
local Parent = script.Parent
local WebSlingerRemote = Parent.WebSlingerRemote
local v1 = LocalPlayer:GetMouse()

local function buildRaycastParams() -- line 14 | captures: LocalPlayer
    local v2 = RaycastParams.new()
    v2.FilterType = Enum.RaycastFilterType.Exclude
    v2.IgnoreWater = true
    local v3 = {}
    local Character = LocalPlayer.Character
    if Character then
        table.insert(v3, Character)
    end
    v2.FilterDescendantsInstances = v3
    return v2
end

local function resolveHitTarget(v4) -- line 26 | captures: Players, LocalPlayer
    if v4 then
        local v5 = v4
        while v5 do
            if v5:IsA("Model") then
                break
            end
            if v5:FindFirstChildWhichIsA("Humanoid") then
                break
            end
            v5 = v5.Parent
        end
        if v5 then
            local v6 = Players:GetPlayerFromCharacter(v5)
            if v6 then
                if v6 == LocalPlayer then
                    return nil, nil
                end
                return v6, "PlayerType"
            end
        end
    end
    return nil, nil
end

Parent.Activated:Connect(function() -- line 49 | captures: Workspace, ToolGameplayGuard, LocalPlayer, Parent, WebSlingerRemote, v1, resolveHitTarget
    if ToolGameplayGuard.AllowsLocalUse(Parent) then
        local Character = LocalPlayer.Character
        if Character and Character.PrimaryPart and Workspace.CurrentCamera then
            local Handle = Parent.Handle
            local v7 = v1.Hit.Position - Handle.Position
            if v7.Magnitude ~= 0 then
                local Unit = v7.Unit
                local v8 = RaycastParams.new()
                v8.FilterType = Enum.RaycastFilterType.Exclude
                v8.IgnoreWater = true
                local v9 = {}
                local Character = LocalPlayer.Character
                if Character then
                    table.insert(v9, Character)
                end
                v8.FilterDescendantsInstances = v9
                local v10 = Workspace:Raycast(Handle.Position, Unit * 12, v8)
                local v11 = v10 and v10.Instance or nil
                local v12, v13 = resolveHitTarget(v11)
                local v14
                if v10 then
                    local Distance = v10.Distance
                    v14 = math.min(Distance, 20)
                else
                    v14 = 20
                end
                WebSlingerRemote:FireServer({
                    type = "fire",
                    target = v12,
                    targetType = v13,
                    aimDirection = Unit,
                    hitDistance = v14
                })
            end
        end
    end
end)
Parent.Unequipped:Connect(function() -- line 92 | captures: WebSlingerRemote
    WebSlingerRemote:FireServer({ type = "disconnect" })
end)
