-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = { Attachment = true }
local v2 = {
    BallSocketConstraint = true,
    HingeConstraint = true
}
local v3 = {
    Root = true,
    Neck = true
}
local v4 = {}

local function purgeTagged(v5, v7, v8, v9) -- line 10
    local v10
    if v5 then
        v10 = v5:GetChildren()
    else
        v10 = {}
    end
    for v11, v12 in v10 do
        local v13 = v8[v12.ClassName] and v12:GetAttribute(v7)
        if v13 then
            if v6 then
                if v13 == v6 then
                end
            else
                v12:Destroy()
            end
        end
    end
end

local function unrig(v14) -- line 33 | captures: v1, v2, purgeTagged
    purgeTagged(v14.Parent, "RagdollConstraint", v2, v14.Name)
    purgeTagged(v14.Part0, "RagdollAttachment", v1, v14.Name)
    purgeTagged(v14.Part1, "RagdollAttachment", v1, v14.Name)
end

local function anchorPoint(v15, v16, v17, v18) -- line 38
    local Attachment = Instance.new("Attachment")
    Attachment.Name = ("RagdollAttachment_%*_%*"):format(v16, v17)
    Attachment:SetAttribute("RagdollAttachment", v16)
    Attachment.Parent = v15
    Attachment.CFrame = v18
    return Attachment
end

local function rig(v19) -- line 46 | captures: v1, v2, v3, purgeTagged
    local Part0 = v19.Part0
    local Part1 = v19.Part1
    if not Part0 or not Part1 then
        return nil
    end
    purgeTagged(v19.Parent, "RagdollConstraint", v2, v19.Name)
    purgeTagged(v19.Part0, "RagdollAttachment", v1, v19.Name)
    purgeTagged(v19.Part1, "RagdollAttachment", v1, v19.Name)
    local Name = v19.Name
    local BallSocketConstraint = Instance.new("BallSocketConstraint")
    local Attachment = Instance.new("Attachment")
    Attachment.Name = ("RagdollAttachment_%*_A"):format(Name)
    Attachment:SetAttribute("RagdollAttachment", Name)
    Attachment.Parent = Part0
    Attachment.CFrame = v19.C0
    local Attachment_2 = Instance.new("Attachment")
    Attachment_2.Name = ("RagdollAttachment_%*_B"):format(Name)
    Attachment_2:SetAttribute("RagdollAttachment", Name)
    Attachment_2.Parent = Part1
    Attachment_2.CFrame = v19.C1
    BallSocketConstraint.Name = ("RagdollConstraint_%*"):format(Name)
    BallSocketConstraint:SetAttribute("RagdollConstraint", Name)
    BallSocketConstraint.Parent = v19.Parent
    BallSocketConstraint.Attachment0 = Attachment
    BallSocketConstraint.Attachment1 = Attachment_2
    BallSocketConstraint.LimitsEnabled = true
    BallSocketConstraint.TwistLimitsEnabled = true
    if v3[Name] then
        BallSocketConstraint:Destroy()
        local HingeConstraint = Instance.new("HingeConstraint")
        HingeConstraint.Name = ("RagdollConstraint_%*"):format(Name)
        HingeConstraint:SetAttribute("RagdollConstraint", Name)
        HingeConstraint.Parent = v19.Parent
        HingeConstraint.Attachment0 = Attachment
        HingeConstraint.Attachment1 = Attachment_2
        HingeConstraint.LimitsEnabled = true
        return HingeConstraint
    end
    return BallSocketConstraint
end

local function eachMotor(v20, v21) -- line 89
    for v22, v23 in v20:GetDescendants() do
        if v23:IsA("Motor6D") then
            v21(v23)
        end
    end
end

function v4.Bind(v24) -- line 96 | captures: rig, eachMotor
    eachMotor(v24, function(v25) -- line 97 | captures: rig
        rig(v25)
        v25.Enabled = false
    end)
end

function v4.Release(v26) -- line 102 | captures: v1, v2, purgeTagged, eachMotor
    eachMotor(v26, function(v27) -- line 103 | captures: v1, v2, purgeTagged
        if not v27.Parent then
            return
        end
        purgeTagged(v27.Parent, "RagdollConstraint", v2, v27.Name)
        purgeTagged(v27.Part0, "RagdollAttachment", v1, v27.Name)
        purgeTagged(v27.Part1, "RagdollAttachment", v1, v27.Name)
        v27.Enabled = true
    end)
end

return v4
