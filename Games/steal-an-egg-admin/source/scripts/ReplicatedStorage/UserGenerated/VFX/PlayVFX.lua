-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Emit = require(ReplicatedStorage.UserGenerated.VFX.Emit)
return function(v1, v2, v3) -- line 9 | captures: Debris, Emit
    local Attachment = Instance.new("Attachment")
    Attachment.CFrame = v1.CFrame:ToObjectSpace(v2)
    for v4, v5 in ipairs(v3:GetDescendants()) do
        if v5:IsA("ParticleEmitter") then
            v5.Parent = Attachment
        end
    end
    if v3:IsA("ParticleEmitter") then
        v3.Parent = Attachment
    else
        v3:Destroy()
    end
    Attachment.Parent = v1
    Debris:AddItem(Attachment, Emit(Attachment))
end
