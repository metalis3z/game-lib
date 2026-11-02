-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local AvatarEditorService = game:GetService("AvatarEditorService")
local Parent = script.Parent.Parent.Parent.Parent.Parent
local States = require(script.Parent.Parent.States)
local Future = require(Parent.Parent.Future)
local Signal = require(Parent.Parent.Signal)
local v1 = {}

function v1.Search(v2) -- line 10 | captures: Future, Signal, v1
    local v3 = {
        Pages = nil,
        Results = {},
        Updated = Signal.new()
    }

    function v3.LoadNextPage(v4) -- line 17 | captures: Future
        return Future.Try(function() -- line 18 | captures: v4
            local v5 = v4.Pages ~= nil
            assert(v5, "Pages does not exist.")
            local v6 = not v4.Pages.IsFinished
            assert(v6, "Pages is finished.")
            v4.Pages:AdvanceToNextPageAsync()
            return v4.Pages:GetCurrentPage()
        end):After(function(v7, v8) -- line 24 | captures: v4
            if v7 and v8 then
                v4:_LoadPage(v8)
            end
        end)
    end

    local function _LoadPage(v9, v10) -- line 31
        for v11, v12 in ipairs(v10) do
            local Results = v9.Results
            table.insert(Results, v12)
        end
        v9.Updated:Fire()
    end

    v3._LoadPage = _LoadPage

    local function Destroy(v13) -- line 39
        v13.Results = {}
        v13.Updated:Destroy()
        if v13.Pages ~= nil then
            v13.Pages:Destroy()
        end
    end

    v3.Destroy = Destroy
    v1.Pages(v2):After(function(v14, v15) -- line 48 | captures: v3
        if v14 then
            v3.Pages = v15
            v3:_LoadPage(v15:GetCurrentPage())
        end
    end)
    return v3
end

function v1.Pages(v16) -- line 58 | captures: AvatarEditorService, Future
    return Future.Try(function() -- line 59 | captures: v16, AvatarEditorService
        return AvatarEditorService:GetInventory(v16)
    end)
end

function v1.Start(v17) -- line 64 | captures: AvatarEditorService, States
    AvatarEditorService.PromptAllowInventoryReadAccessCompleted:Connect(function(v18) -- line 65 | captures: States
        if v18 == Enum.AvatarPromptResult.Success then
            States.Inventory.AccessAllowed:set(true)
        else
            States.Inventory.AccessAllowed:set(false)
        end
    end)
end

return v1
