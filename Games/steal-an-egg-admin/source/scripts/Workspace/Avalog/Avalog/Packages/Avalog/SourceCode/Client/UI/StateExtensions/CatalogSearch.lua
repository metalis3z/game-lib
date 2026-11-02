-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local AvatarEditorService = game:GetService("AvatarEditorService")
local Parent = script.Parent.Parent.Parent.Parent.Parent
local Future = require(Parent.Parent.Future)
local Signal = require(Parent.Parent.Signal)
local CatalogItems = require(script.Parent.CatalogItems)
local v1 = {}

function v1.Search(v2) -- line 25 | captures: Future, Signal, CatalogItems, v1
    local v3 = {
        Pages = nil,
        Results = {},
        Updated = Signal.new()
    }

    function v3.LoadNextPage(v4) -- line 32 | captures: Future
        return Future.Try(function() -- line 33 | captures: v4
            local v5 = v4.Pages ~= nil
            assert(v5, "Pages does not exist.")
            v4.Pages:AdvanceToNextPageAsync()
            return v4.Pages:GetCurrentPage()
        end):After(function(v6, v7) -- line 39 | captures: v4
            if v6 and v7 then
                v4:_LoadPage(v7)
            end
        end)
    end

    function v3._LoadPage(v8, v9) -- line 46 | captures: CatalogItems
        for v10, v11 in ipairs(v9) do
            local v12 = ({
                    Asset = CatalogItems.KnownAssets,
                    Bundle = CatalogItems.KnownBundles
                })[v11.ItemType]
            if v12 then
                local v13 = {
                    Id = v11.Id,
                    Name = v11.Name,
                    Price = v11.Price,
                    Offsale = v11.IsOffSale,
                    Type = Enum.AvatarItemType[v11.ItemType]
                }
                v13.AssetType = v11.AssetType and Enum.AvatarAssetType[v11.AssetType] or nil
                v12[v11.Id] = v13
            end
            local Results = v8.Results
            table.insert(Results, v11)
        end
        v8.Updated:Fire()
    end

    local function Destroy(v14) -- line 73
        v14.Results = {}
        v14.Updated:Destroy()
        if v14.Pages ~= nil then
            v14.Pages:Destroy()
        end
    end

    v3.Destroy = Destroy
    v1.Pages(v2):After(function(v15, v16) -- line 82 | captures: v3
        if v15 then
            v3.Pages = v16
            v3:_LoadPage(v16:GetCurrentPage())
        end
    end)
    return v3
end

function v1.Pages(v17) -- line 92 | captures: AvatarEditorService, Future, v1
    local v18 = v1.Params(v17)
    return Future.Try(function() -- line 95 | captures: v18, AvatarEditorService
        return AvatarEditorService:SearchCatalog(v18)
    end)
end

local function Params(v19) -- line 100
    local v20 = CatalogSearchParams.new()
    for v21, v22 in pairs(v19) do
        v20[v21] = v22
    end
    return v20
end

v1.Params = Params

local function Stop(v23) -- line 110
end

v1.Stop = Stop
return v1
