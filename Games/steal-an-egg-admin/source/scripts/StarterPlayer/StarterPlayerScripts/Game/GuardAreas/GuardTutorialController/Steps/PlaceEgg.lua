-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Client.GuardTutorialPresentation)
require(script.Parent.Types.Interface)
local StepUtils = require(script.Parent.Parent.StepUtils)
local v1 = Color3.fromRGB(255, 255, 255)
local v2 = {
    StepId = "PlaceEgg",
    IsSatisfied = function(v3) -- IsSatisfied | line 13
        return v3:HasPlacedEgg()
    end
}

function v2.Bind(v4, v5) -- line 17 | captures: StepUtils, v2
    return StepUtils.BindOnAdapterChanged(v4, v2.IsSatisfied, v5)
end

function v2.Present(v6, v7) -- line 20 | captures: v1, v2
    local v8 = v7.Changed:Connect(function() -- line 22 | captures: v6, v7, v1, v2
        if v2.IsSatisfied(v7) then
            v6:DropEverything()
        else
            v6:AnnounceTyped("Place your Egg!", v1)
            local v9 = v7:GetEggPlacementBillboardCFrame()
            if v9 ~= nil then
                v6:PinWorldClickHint(v9)
            end
        end
    end)
    if v2.IsSatisfied(v7) then
        v6:DropEverything()
    else
        v6:AnnounceTyped("Place your Egg!", v1)
        local v10 = v7:GetEggPlacementBillboardCFrame()
        if v10 ~= nil then
            v6:PinWorldClickHint(v10)
        end
    end
    return function() -- line 42 | captures: v6, v8
        v8:Disconnect()
        v6:DropEverything()
    end
end

return v2
