-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {
    stockName = "TutorialBeam",
    anchorPin = "TutorialBeamTargetAttachment",
    followerPin = "TutorialBeamPlayerAttachment",
    rootPart = "HumanoidRootPart",
    rootPartTimeout = 5,
    drifterProperties = {
        Anchored = true,
        CanCollide = false,
        Name = "TutorialBeamContainer",
        Size = Vector3.new(1, 1, 1),
        Transparency = 1
    },
    beamProperties = {
        Enabled = false,
        FaceCamera = true
    }
}
local v2 = {}
local LocalPlayer = Players.LocalPlayer
local TutorialBeam = ReplicatedStorage.Assets.Extra.TutorialBeam

local function dress(v3, v4) -- line 28
    for v5, v6 in v4 do
        v3[v5] = v6
    end
    return v3
end

local function demandAnchor(v7, v8) -- line 37
    local v9
    if typeof(v7) == "Vector3" then
        v9 = true
    elseif typeof(v7) == "Instance" then
        v9 = v7:IsA("BasePart")
    else
        v9 = false
    end
    local v10 = ("%* needs a BasePart or a Vector3"):format(v8)
    assert(v9, v10)
end

local function pinTo(v11, v12) -- line 41 | captures: v1
    local Attachment = Instance.new("Attachment")
    Attachment.Name = v1.anchorPin
    if typeof(v11) == "Vector3" then
        local Part = Instance.new("Part")
        for v13, v14 in v1.drifterProperties do
            Part[v13] = v14
        end
        Part.Position = v11
        Part.Parent = workspace
        v12:Add(Part)
        Attachment.Parent = Part
        return Attachment, Part
    end
    Attachment.Parent = v11
    return Attachment, nil
end

local function rideCharacter(v15) -- line 62 | captures: v1
    local Character = v15.owner.Character
    local v16
    if Character then
        v16 = Character:WaitForChild(v1.rootPart, v1.rootPartTimeout)
    end
    local pins, v17
    if v16 == nil then
        v17 = true
    elseif v16:IsA("BasePart") then
        pins = v15.pins
        if pins.follower then
            v15.scope:Remove(pins.follower)
        end
        v17 = false
    else
        v17 = true
    end
    if not v17 then
        local Attachment = Instance.new("Attachment")
        Attachment.Name = v1.followerPin
        Attachment.Parent = v16
        pins.follower = v15.scope:Add(Attachment)
        v15.beam.Attachment0 = Attachment
        v15.beam.Enabled = true
    else
        v15.beam.Enabled = false
    end
end

function v2.Retarget(v18, v19) -- line 85 | captures: t, pinTo
    t.strict(t.table)(v18)
    local v20
    if typeof(v19) == "Vector3" then
        v20 = true
    elseif typeof(v19) == "Instance" then
        v20 = v19:IsA("BasePart")
    else
        v20 = false
    end
    assert(v20, "beam retarget needs a BasePart or a Vector3")
    local pins = v18.pins
    if typeof(v19) == "Vector3" then
        if pins.drifter == nil then
            if v19 ~= pins.anchor.Parent then
                v18.scope:Remove(pins.anchor)
                if pins.drifter ~= nil then
                    v18.scope:Remove(pins.drifter)
                end
                local v21, v22 = pinTo(v19, v18.scope)
                pins.anchor = v21
                pins.drifter = v22
                v18.scope:Add(pins.anchor)
                v18.beam.Attachment1 = pins.anchor
            end
        else
            pins.drifter.Position = v19
        end
    elseif v19 ~= pins.anchor.Parent then
        v18.scope:Remove(pins.anchor)
        if pins.drifter ~= nil then
            v18.scope:Remove(pins.drifter)
        end
        local v23, v24 = pinTo(v19, v18.scope)
        pins.anchor = v23
        pins.drifter = v24
        v18.scope:Add(pins.anchor)
        v18.beam.Attachment1 = pins.anchor
    end
end

function v2.Destroy(v25) -- line 124 | captures: t
    t.strict(t.table)(v25)
    v25.scope:Destroy()
end

function v2.Attach(v26, v27) -- line 129 | captures: Trove, v1, LocalPlayer, TutorialBeam, pinTo, rideCharacter
    local v28
    if typeof(v26) == "Vector3" then
        v28 = true
    elseif typeof(v26) == "Instance" then
        v28 = v26:IsA("BasePart")
    else
        v28 = false
    end
    assert(v28, "beam anchor needs a BasePart or a Vector3")
    local v29 = Trove.new()
    local v30, v31 = pinTo(v26, v29)
    v29:Add(v30)
    local v32
    if v27 then
        if v27.Template then
            v32 = v27.Template
        end
    else
        v32 = TutorialBeam
    end
    local v33 = v32:Clone()
    for v34, v35 in v1.beamProperties do
        v33[v34] = v35
    end
    if v27 and v27.BeamName then
        v33.Name = v27.BeamName
    else
        v33.Name = v1.stockName
    end
    v33.Attachment1 = v30
    v33.Parent = workspace
    v29:Add(v33)
    local v36 = {
        scope = v29,
        beam = v33,
        owner = LocalPlayer,
        pins = {
            anchor = v30,
            drifter = v31
        }
    }
    rideCharacter(v36)

    local function remountOn(v37) -- line 167 | captures: v36, v1, rideCharacter
        if v37:WaitForChild(v1.rootPart, v1.rootPartTimeout) then
            rideCharacter(v36)
        end
    end

    v29:Connect(LocalPlayer.CharacterAdded, function(v38) -- line 172 | captures: remountOn
        task.spawn(remountOn, v38)
    end)
    return v36
end

return v2
