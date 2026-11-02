-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
local Player = require(ReplicatedStorage.Shared.Player)
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local v1 = Color3.fromRGB(255, 255, 255)
local PLACED_TRAP = Constants.TAGS_MAP.Traps.PLACED_TRAP
local LocalPlayer = Players.LocalPlayer
local __OBJECTS = Workspace.__OBJECTS
local Folder = __OBJECTS:IsA("Folder")
assert(Folder, "Workspace.__OBJECTS must be a Folder")
local Areas = __OBJECTS.Areas
local Folder_2 = Areas:IsA("Folder")
assert(Folder_2, "Workspace.__OBJECTS.Areas must be a Folder")
local SeparationLine = Areas.SeparationLine
local BasePart = SeparationLine:IsA("BasePart")
assert(BasePart, "Workspace.__OBJECTS.Areas.SeparationLine must be a BasePart")
local v2 = {}
local Position
local v3 = false

local function getOrCreateState(v4) -- line 29 | captures: v2
    local v5 = v2[v4]
    if v5 then
        return v5
    end
    local v6 = { FadeOutVersion = 0 }
    v2[v4] = v6
    return v6
end

local function cancelTween(v7) -- line 38
    local Tween = v7.Tween
    if Tween then
        v7.Tween = nil
        Tween:Cancel()
    end
end

local function isOwnedTrap(v8) -- line 45 | captures: LocalPlayer
    return v8:GetAttribute("Owner") == LocalPlayer.Name
end

local function showTrapHighlight(v9) -- line 50 | captures: Tween, v1, LocalPlayer, v2
    if v9:GetAttribute("Owner") ~= LocalPlayer.Name then
        return
    end
    local v10 = v2[v9]
    if not v10 then
        v10 = { FadeOutVersion = 0 }
        v2[v9] = v10
    end
    v10.FadeOutVersion += 1
    local Tween_2 = v10.Tween
    if Tween_2 then
        v10.Tween = nil
        Tween_2:Cancel()
    end
    local TrapGameplayHighlight = v9:FindFirstChild("TrapGameplayHighlight")
    if TrapGameplayHighlight then
        if not TrapGameplayHighlight:IsA("Highlight") then
            TrapGameplayHighlight = Instance.new("Highlight")
            TrapGameplayHighlight.Name = "TrapGameplayHighlight"
            TrapGameplayHighlight.Parent = v9
        end
    else
        TrapGameplayHighlight = Instance.new("Highlight")
        TrapGameplayHighlight.Name = "TrapGameplayHighlight"
        TrapGameplayHighlight.Parent = v9
    end
    TrapGameplayHighlight.Adornee = v9
    TrapGameplayHighlight.DepthMode = Enum.HighlightDepthMode.Occluded
    TrapGameplayHighlight.FillColor = v1
    TrapGameplayHighlight.FillTransparency = 1
    TrapGameplayHighlight.OutlineColor = v1
    TrapGameplayHighlight.OutlineTransparency = 1
    v10.Highlight = TrapGameplayHighlight
    v10.Tween = Tween(TrapGameplayHighlight, { OutlineTransparency = 0.3 }, {
        0.18,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    })
end

local function hideTrapHighlight(v11) -- line 92 | captures: Tween, v2
    local v12 = v2[v11]
    if v12 then
        local Highlight = v12.Highlight
        if Highlight then
            v12.FadeOutVersion += 1
            local FadeOutVersion = v12.FadeOutVersion
            local Tween_2 = v12.Tween
            if Tween_2 then
                v12.Tween = nil
                Tween_2:Cancel()
            end
            local v13 = Tween(Highlight, { OutlineTransparency = 1 }, {
                0.18,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            })
            v12.Tween = v13
            v13.Completed:Once(function(v14) -- line 110 | captures: v12, Highlight, FadeOutVersion
                if v14 == Enum.PlaybackState.Completed and v12.FadeOutVersion == FadeOutVersion then
                    if Highlight.Parent then
                        Highlight:Destroy()
                    end
                else
                    return
                end
                v12.Highlight = nil
                v12.Tween = nil
            end)
        end
    end
end

local function setTrapHighlightsVisible(v15) -- line 121 | captures: v2, showTrapHighlight, hideTrapHighlight
    for v16 in pairs(v2) do
        if v15 then
            showTrapHighlight(v16)
        else
            hideTrapHighlight(v16)
        end
    end
end

local function cleanupTrap(v17) -- line 130 | captures: v2
    local v18 = v2[v17]
    if not v18 then
        return
    end
    local Tween = v18.Tween
    if Tween then
        v18.Tween = nil
        Tween:Cancel()
    end
    local Highlight = v18.Highlight
    if Highlight and Highlight.Parent then
        Highlight:Destroy()
    end
    v2[v17] = nil
end

local function trackTrap(v19) -- line 146 | captures: v3, LocalPlayer, v2, showTrapHighlight
    if not (v19:IsA("BasePart") and v19:GetAttribute("Owner") == LocalPlayer.Name) then
        return
    end
    if not v2[v19] then
        v2[v19] = { FadeOutVersion = 0 }
    end
    if v3 then
        showTrapHighlight(v19)
    end
    v19.Destroying:Once(function() -- line 161 | captures: v19, v2
        local v20 = v2[v19]
        if not v20 then
            return
        end
        local Tween = v20.Tween
        if Tween then
            v20.Tween = nil
            Tween:Cancel()
        end
        local Highlight = v20.Highlight
        if Highlight and Highlight.Parent then
            Highlight:Destroy()
        end
        v2[v19] = nil
    end)
end

for v21, v22 in ipairs(CollectionService:GetTagged(PLACED_TRAP)) do
    trackTrap(v22)
end
CollectionService:GetInstanceAddedSignal(PLACED_TRAP):Connect(trackTrap)
CollectionService:GetInstanceRemovedSignal(PLACED_TRAP):Connect(function(v23) -- line 185 | captures: v3, v2, hideTrapHighlight
    if v23:IsA("BasePart") then
        if v3 then
            hideTrapHighlight(v23)
        else
            local v24 = v2[v23]
            if v24 then
                local Tween = v24.Tween
                if Tween then
                    v24.Tween = nil
                    Tween:Cancel()
                end
                local Highlight = v24.Highlight
                if Highlight and Highlight.Parent then
                    Highlight:Destroy()
                end
                v2[v23] = nil
            end
        end
    end
end)
require(ReplicatedStorage.Shared.Utils.FrameStepper).OnRender(function() -- line 208 | captures: Position, v3, GuardAreaGeometry, Player, LocalPlayer, SeparationLine, v2, showTrapHighlight, hideTrapHighlight
    local v25 = Player.Optional.HumanoidRootPart(LocalPlayer)
    if v25 ~= nil and v25:IsA("BasePart") then
        local Position_2 = v25.Position
        local Position_3 = Position
        Position = Position_2
        if Position_3 == nil then
            v3 = GuardAreaGeometry.IsPastLine(SeparationLine, Position_2)
            if v3 then
                for v26 in pairs(v2) do
                    showTrapHighlight(v26)
                end
            end
        elseif GuardAreaGeometry.CrossedLineInward(SeparationLine, Position_3, Position_2) then
            v3 = true
            for v27 in pairs(v2) do
                showTrapHighlight(v27)
            end
        elseif GuardAreaGeometry.CrossedLineOutward(SeparationLine, Position_3, Position_2) then
            v3 = false
            for v28 in pairs(v2) do
                hideTrapHighlight(v28)
            end
        end
    end
    return false
end)
