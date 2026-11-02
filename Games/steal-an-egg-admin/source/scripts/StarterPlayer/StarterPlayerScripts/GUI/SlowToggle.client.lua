-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Hud = require(ReplicatedStorage.Client.Hud)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local v1 = Color3.fromRGB(0, 255, 0)
local LocalPlayer = Players.LocalPlayer
local SlowToggle = Hud.Get("SlowToggle")
local SlowToggleKnob = Hud.Get("SlowToggleKnob")
local SlowToggleHitbox = Hud.Get("SlowToggleHitbox")
local BackgroundColor3 = SlowToggle.BackgroundColor3
local Y = SlowToggleKnob.Position.Y
local v2 = false
local v3 = Constants.BASE_WALK_SPEED
local v4, v5, v6

local function setToggleVisuals(v7) -- line 26 | captures: Tween, v1, SlowToggle, SlowToggleKnob, BackgroundColor3, Y
    local v8 = if v7 then v1 else BackgroundColor3
    SlowToggle.BackgroundColor3 = v8
    local v9 = {}
    local v10 = if v7 then 0.615 else 0.05
    v9.Position = UDim2.new(v10, 0, Y.Scale, Y.Offset)
    Tween(SlowToggleKnob, v9, { 0.15 })
end

local function reconcileSlowToggleState(v11) -- line 43 | captures: v2, setToggleVisuals
    v2 = v11
    setToggleVisuals(v11)
end

local function updateSlowToggleVisibility(v12) -- line 47 | captures: v2, v4, SlowToggle
    local v13 = if v4 == nil then v2 or v12 > 50 else false
    SlowToggle.Visible = v13
    return v13
end

local function resolveVisibleWalkSpeed() -- line 58 | captures: v3, v5
    local v14 = v5
    if not (v14 == nil or v14.Parent == nil) and v14.Health > 0 then
        return v14.WalkSpeed
    end
    return v3
end

local function refreshVisibilityFromCurrentWalkSpeed() -- line 68 | captures: v2, v3, v4, v5, SlowToggle
    local v15 = v5
    local v16 = if v15 == nil or v15.Parent == nil or v15.Health <= 0 then v3 else v15.WalkSpeed
    local v17 = if v4 == nil then v2 or v16 > 50 else false
    SlowToggle.Visible = v17
end

local function applyServerSlowToggleState(v18, v19) -- line 89 | captures: v2, v3, v4, v5, SlowToggle, setToggleVisuals
    v3 = v19
    v2 = v18
    setToggleVisuals(v18)
    local v20 = v5
    local v21 = if v20 == nil or v20.Parent == nil or v20.Health <= 0 then v3 else v20.WalkSpeed
    local v22 = if v4 == nil then v2 or v21 > 50 else false
    SlowToggle.Visible = v22
end

local function setSlowToggleEnabled(v23) -- line 113 | captures: v2, v3, v4, v5, Remotes, SlowToggle, setToggleVisuals
    local v24, v25 = Remotes.Treadmill.AskSlowToggleSet:InvokeServer(v23)
    local v26 = typeof(v24) == "boolean"
    assert(v26, "Expected slow-toggle enabled state from server")
    local v27 = typeof(v25) == "number"
    assert(v27, "Expected slow-toggle restored walk speed from server")
    v3 = v25
    v2 = v24
    setToggleVisuals(v24)
    local v28 = v5
    local v29 = if v28 == nil or v28.Parent == nil or v28.Health <= 0 then v3 else v28.WalkSpeed
    local v30 = if v4 == nil then v2 or v29 > 50 else false
    SlowToggle.Visible = v30
end

local function bindHumanoid(v31) -- line 142 | captures: v2, v3, v4, v5, v6, SlowToggle
    if v6 ~= nil then
        v6:Disconnect()
        v6 = nil
    end
    v5 = v31
    v6 = v31:GetPropertyChangedSignal("WalkSpeed"):Connect(function() -- line 150 | captures: v2, v3, v4, v5, SlowToggle
        local v32 = v5
        local v33 = if v32 == nil or v32.Parent == nil or v32.Health <= 0 then v3 else v32.WalkSpeed
        local v34 = if v4 == nil then v2 or v33 > 50 else false
        SlowToggle.Visible = v34
    end)
    local v35 = v5
    local v36 = if v35 == nil or v35.Parent == nil or v35.Health <= 0 then v3 else v35.WalkSpeed
    local v37 = if v4 == nil then v2 or v36 > 50 else false
    SlowToggle.Visible = v37
end

local function connectCharacter(v38) -- line 190 | captures: v2, v3, v4, v5, Remotes, SlowToggle, setToggleVisuals, bindHumanoid
    local Humanoid = v38:WaitForChild("Humanoid")
    bindHumanoid(Humanoid)
    local v39, v40 = Remotes.Treadmill.AskSlowToggle:InvokeServer()
    local v41 = typeof(v39) == "boolean"
    assert(v41, "Expected slow-toggle enabled state from server")
    local v42 = typeof(v40) == "number"
    assert(v42, "Expected slow-toggle restored walk speed from server")
    v3 = v40
    v2 = v39
    setToggleVisuals(v39)
    local v43 = v5
    local v44 = if v43 == nil or v43.Parent == nil or v43.Health <= 0 then v3 else v43.WalkSpeed
    local v45 = if v4 == nil then v2 or v44 > 50 else false
    SlowToggle.Visible = v45
end

SlowToggleHitbox.Activated:Connect(function() -- line 221 | captures: v2, v3, v4, v5, Remotes, SlowToggle, setToggleVisuals
    local v46, v47 = Remotes.Treadmill.AskSlowToggleSet:InvokeServer(not v2)
    local v48 = typeof(v46) == "boolean"
    assert(v48, "Expected slow-toggle enabled state from server")
    local v49 = typeof(v47) == "number"
    assert(v49, "Expected slow-toggle restored walk speed from server")
    v3 = v47
    v2 = v46
    setToggleVisuals(v46)
    local v50 = v5
    local v51 = if v50 == nil or v50.Parent == nil or v50.Health <= 0 then v3 else v50.WalkSpeed
    local v52 = if v4 == nil then v2 or v51 > 50 else false
    SlowToggle.Visible = v52
end)

if Save.IsLocalDataLoaded() then
    local v53, v54 = Remotes.Treadmill.AskSlowToggle:InvokeServer()
    local v55 = typeof(v53) == "boolean"
    assert(v55, "Expected slow-toggle enabled state from server")
    local v56 = typeof(v54) == "number"
    assert(v56, "Expected slow-toggle restored walk speed from server")
    v3 = v54
    v2 = v53
    setToggleVisuals(v53)
    local v57 = v5
    local v58
    if v57 == nil then
        v58 = v3
    elseif v57.Parent == nil then
    elseif v57.Health > 0 then
        v58 = v57.WalkSpeed
    end
    local v59 = if v4 == nil then v2 or v58 > 50 else false
    SlowToggle.Visible = v59
else
    Save.ProfileReady:Connect(function() -- line 251 | captures: v2, v3, v4, v5, Remotes, SlowToggle, setToggleVisuals
        local v60, v61 = Remotes.Treadmill.AskSlowToggle:InvokeServer()
        local v62 = typeof(v60) == "boolean"
        assert(v62, "Expected slow-toggle enabled state from server")
        local v63 = typeof(v61) == "number"
        assert(v63, "Expected slow-toggle restored walk speed from server")
        v3 = v61
        v2 = v60
        setToggleVisuals(v60)
        local v64 = v5
        local v65 = if v64 == nil or v64.Parent == nil or v64.Health <= 0 then v3 else v64.WalkSpeed
        local v66 = if v4 == nil then v2 or v65 > 50 else false
        SlowToggle.Visible = v66
    end)
end
Remotes.Treadmill.AssignedBeltShifted.OnClientEvent:Connect(function(v67) -- line 305 | captures: v2, v3, v4, v5, SlowToggle
    v4 = v67
    local v68 = v5
    local v69 = if v68 == nil or v68.Parent == nil or v68.Health <= 0 then v3 else v68.WalkSpeed
    local v70 = if v4 == nil then v2 or v69 > 50 else false
    SlowToggle.Visible = v70
end)

if LocalPlayer.Character ~= nil then
    bindHumanoid((LocalPlayer.Character:WaitForChild("Humanoid")))
    local v71, v72 = Remotes.Treadmill.AskSlowToggle:InvokeServer()
    local v73 = typeof(v71) == "boolean"
    assert(v73, "Expected slow-toggle enabled state from server")
    local v74 = typeof(v72) == "number"
    assert(v74, "Expected slow-toggle restored walk speed from server")
    v3 = v72
    v2 = v71
    setToggleVisuals(v71)
    local v75 = v5
    local v76
    if v75 == nil then
        v76 = v3
    elseif v75.Parent == nil then
    elseif v75.Health > 0 then
        v76 = v75.WalkSpeed
    end
    local v77 = if v4 == nil then v2 or v76 > 50 else false
    SlowToggle.Visible = v77
end
LocalPlayer.CharacterAdded:Connect(connectCharacter)
