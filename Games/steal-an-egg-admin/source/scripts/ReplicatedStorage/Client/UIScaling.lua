-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ViewportSize = require(ReplicatedStorage.Client.ViewportSize)
local v1 = {
    Chat = true,
    TouchGui = true
}
local v2 = {
    LeftControls = true,
    RightButtons = true
}
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local v3 = {}
local v4 = {}
local v5 = 1

local function computeScale() -- line 15 | captures: ViewportSize
    return 1 - (1 - ViewportSize.ReadScale()) * 0.5
end

local function isIgnored(v6) -- line 18 | captures: v1, PlayerGui
    local v7 = v6
    while true do
        if v7.Parent == nil then
            break
        end
        if v7.Parent == PlayerGui then
            break
        end
        v7 = v7.Parent
    end
    if v7.Parent == PlayerGui then
        return v1[v7.Name] == true
    end
    return false
end

local function apply(v8) -- line 29 | captures: v5, v1, PlayerGui, v3, v4
    local v9 = v8
    while true do
        if v9.Parent == nil then
            break
        end
        if v9.Parent == PlayerGui then
            break
        end
        v9 = v9.Parent
    end
    if not (v9.Parent == PlayerGui and v1[v9.Name] == true) then
        if v8:IsA("UIStroke") then
            if v8.StrokeSizingMode ~= Enum.StrokeSizingMode.ScaledSize then
                local v10 = v3[v8]
                if v10 == nil then
                    v10 = v8.Thickness
                    v3[v8] = v10
                    v8.Destroying:Once(function() -- line 49 | captures: v8, v3
                        v3[v8] = nil
                    end)
                end
                v8.Thickness = v10 * v5
            end
        elseif v8:IsA("ImageLabel") then
            if v8.ScaleType == Enum.ScaleType.Slice then
                local v11 = v4[v8]
                if v11 == nil then
                    v11 = v8.SliceScale
                    v4[v8] = v11
                    v8.Destroying:Once(function() -- line 62 | captures: v8, v4
                        v4[v8] = nil
                    end)
                end
                v8.SliceScale = v11 * v5
            end
        elseif v8:IsA("ImageButton") then
        end
    end
end

PlayerGui.DescendantAdded:Connect(function(v12) -- line 71 | captures: apply
    task.defer(function() -- line 72 | captures: v12, apply
        if v12.Parent ~= nil then
            apply(v12)
        end
    end)
end)
ViewportSize.Changed:Connect(function() -- line 78 | captures: v5, ViewportSize, PlayerGui, apply
    v5 = 1 - (1 - ViewportSize.ReadScale()) * 0.5
    for v13, v14 in PlayerGui:GetDescendants() do
        apply(v14)
    end
end)
v5 = 1 - (1 - ViewportSize.ReadScale()) * 0.5
for v15, v16 in PlayerGui:GetDescendants() do
    apply(v16)
end
task.spawn(function() -- line 88 | captures: ReplicatedStorage, ViewportSize, v2
    local Hud = require(ReplicatedStorage.Client.Hud)
    local v17 = {}
    for v18, v19 in { "Game", "Treadmill" } do
        for v20, v21 in Hud.Frame(v19):GetChildren() do
            if v2[v21.Name] == true and v21:IsA("Frame") then
                local UIScale = Instance.new("UIScale")
                UIScale.Name = "DynamicScale"
                UIScale.Parent = v21
                table.insert(v17, UIScale)
            end
        end
    end
    ViewportSize.Changed:Connect(function() -- line 105 | captures: v17, ViewportSize
        local v22 = ViewportSize.ReadScale()
        for v23, v24 in v17 do
            v24.Scale = (v22 + 0.1) / (v22 * 1.1)
        end
    end)
    local v25 = ViewportSize.ReadScale()
    for v26, v27 in v17 do
        v27.Scale = (v25 + 0.1) / (v25 * 1.1)
    end
end)
return table.freeze({
    ReadScale = function() -- ReadScale | line 123 | captures: v5
        return v5
    end
})
