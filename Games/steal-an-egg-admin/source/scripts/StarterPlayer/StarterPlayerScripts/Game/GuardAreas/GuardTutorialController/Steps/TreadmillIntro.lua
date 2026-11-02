-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Client.GuardTutorialPresentation)
require(script.Parent.Types.Interface)
local v1 = Color3.fromRGB(255, 255, 255)
local v2 = {
    StepId = "TreadmillIntro",
    IsSatisfied = function(v3) -- IsSatisfied | line 12
        return v3:HasFinishedTreadmillIntro()
    end,
    Bind = function(v4, v5) -- Bind | line 15
        local v6 = false
        task.delay(7, function() -- line 17 | captures: v6, v4, v5
            if not v6 then
                v4:MarkTreadmillIntroFinished()
                v5()
            end
        end)
        return function() -- line 24 | captures: v6
            v6 = true
        end
    end
}

function v2.Present(v7, v8) -- line 28 | captures: v1
    v7:AnnounceTyped("Use your treadmill to become faster!", v1)
    return function() -- line 30 | captures: v7
        v7:DropEverything()
    end
end

return v2
