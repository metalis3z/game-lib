-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = {
    TreadmillIntro = "TreadmillIntro",
    ExpandPen = "ExpandPen",
    PlacePet = "PlacePet",
    HatchEgg = "HatchEgg",
    PlaceEgg = "PlaceEgg",
    EquipEgg = "EquipEgg",
    HeadToPen = "HeadToPen",
    StealEgg = "StealEgg"
}
local v2 = {
    Inactive = "Inactive",
    ForwardRun = "ForwardRun"
}
local v3 = {
    v1.StealEgg,
    v1.HeadToPen,
    v1.EquipEgg,
    v1.PlaceEgg,
    v1.HatchEgg,
    v1.PlacePet,
    v1.ExpandPen,
    v1.TreadmillIntro
}
local v4 = {
    v2.Inactive,
    v2.ForwardRun
}

local function anyOf(v5) -- line 30 | captures: t
    local v6 = table.create(#v5)
    for v7, v8 in v5 do
        v6[v7] = t.literal(v8)
    end
    return t.union(table.unpack(v6))
end

local v9 = anyOf(v3)
local v10 = anyOf(v4)
local v11 = t.interface({
    Completed = t.boolean,
    CurrentStepId = t.optional(v9)
})
local v12 = t.interface({
    Enabled = t.boolean,
    PausedForAdminAbuse = t.boolean,
    Revision = t.number
})
local v13 = { Completed = false }
local v14 = {
    StepIds = v1,
    RunGuidanceStates = v2,
    DEFAULT_PROGRESS = v13,
    SchemaValidation = {
        StepId = v9,
        RunGuidanceState = v10,
        Progress = v11,
        ProgressUpdatePayload = v11,
        RuntimeState = v12
    },
    CopyProgress = function(v15) -- CopyProgress | line 56
        return {
            Completed = v15.Completed == true,
            CurrentStepId = v15.CurrentStepId
        }
    end
}

function v14.SanitizeProgress(v16) -- line 64 | captures: v11, v13, v14
    local v17, v18
    if v16 == nil then
        v18 = true
    elseif v11(v16) then
        v17 = v14.CopyProgress(v16)
        if v17.Completed then
            v17.CurrentStepId = nil
        end
        v18 = false
    else
        v18 = true
    end
    if not v18 then
        return v17
    end
    return v14.CopyProgress(v13)
end

function v14.AcceptsStepId(v19) -- line 74 | captures: v9
    return v9(v19)
end

function v14.AcceptsGuidanceState(v20) -- line 77 | captures: v10
    return v10(v20)
end

return v14
