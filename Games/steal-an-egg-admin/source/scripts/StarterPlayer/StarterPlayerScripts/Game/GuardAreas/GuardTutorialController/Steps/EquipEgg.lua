-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Client.GuardTutorialPresentation)
require(script.Parent.Types.Interface)
local StepUtils = require(script.Parent.Parent.StepUtils)
local v1 = {
    StepId = "EquipEgg",
    IsSatisfied = function(v2) -- IsSatisfied | line 12
        return v2:HasEquippedEgg()
    end
}

function v1.Bind(v3, v4) -- line 16 | captures: StepUtils, v1
    return StepUtils.BindOnAdapterChanged(v3, v1.IsSatisfied, v4)
end

function v1.Present(v5, v6) -- line 19 | captures: v1
    local v7 = v6.Changed:Connect(function() -- line 21 | captures: v5, v6, v1
        if v1.IsSatisfied(v6) then
            v5:DropEverything()
        else
            local v8 = v6:GetEggHotbarTarget()
            if v8 == nil then
                v5:DropRing()
            else
                v5:RingButton(v8)
            end
        end
    end)
    if not v1.IsSatisfied(v6) then
        v6:ForceBestEggIntoHotbar()
    end
    if v1.IsSatisfied(v6) then
        v5:DropEverything()
    else
        local v9 = v6:GetEggHotbarTarget()
        if v9 == nil then
            v5:DropRing()
        else
            v5:RingButton(v9)
        end
    end
    return function() -- line 46 | captures: v5, v7
        v7:Disconnect()
        v5:DropEverything()
    end
end

return v1
