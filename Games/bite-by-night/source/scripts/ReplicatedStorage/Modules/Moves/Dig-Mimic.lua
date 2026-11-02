-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

return {
    ["Activate"] = function()
        for _, v1 in workspace:GetDescendants() do
            if v1:HasTag("DoorCollision") then
                v1.CollisionGroup = "Uncollidable"
            elseif v1:HasTag("SecurityDoor") and v1:IsA("BasePart") then
                v1.CanCollide = false
            end
        end
    end,
    ["Deactivate"] = function()
        for _, v2 in workspace:GetDescendants() do
            if v2:HasTag("DoorCollision") then
                v2.CollisionGroup = "Default"
            elseif v2:HasTag("SecurityDoor") and v2:IsA("BasePart") then
                v2.CanCollide = true
            end
        end
    end
}
