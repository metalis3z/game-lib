-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Modules = require(script.Parent.Parent.Parent.Modules);
local ItemButton = require(Modules.Elements.ItemButton);
local FavoriteController = require(Modules.Controllers.FavoriteController);
local CatalogUtilities = require(Modules.Shared.CatalogUtilities);
local v1 = {};
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;

function v1.Setup(p7, p8, p9) -- Line: 19
    -- upvalues: u4 (ref), u5 (ref), u6 (ref)
    u4 = p7;
    u5 = p8;
    u6 = p9;
end;

function v1.UpdateEquipped(u10) -- Line: 25
    -- upvalues: u2 (ref), ItemButton (copy), u4 (ref), CatalogUtilities (copy), u6 (ref)
    if u10 == nil then
        return;
    end;

    if u2 then
        task.cancel(u2);
        u2 = nil;
    end;

    task.spawn(function() -- Line: 33
        -- upvalues: ItemButton (ref), u10 (copy)
        ItemButton.UpdateEquipped(u10);
    end);
    u2 = task.spawn(function() -- Line: 37
        -- upvalues: u4 (ref), u10 (copy), ItemButton (ref), CatalogUtilities (ref), u6 (ref)
        local success, result = pcall(function() -- Line: 38
            -- upvalues: u4 (ref), u10 (ref), ItemButton (ref), CatalogUtilities (ref), u6 (ref)
            for _, child in u4:GetChildren() do
                if not child:IsA("UIGridLayout") and u10[child.Name] == nil then
                    child:Destroy();
                end;
            end;

            for i, v in u10 do
                if i ~= "Description" and not u4:FindFirstChild(i) then
                    local v11 = ItemButton.new({
                        OnlyIcon = true,
                        IsEquipped = true,
                        IsFavoriteAvailable = true,
                        ItemDetails = {
                            AssetId = tonumber(i),
                            ItemType = v.ItemType,
                            AssetType = v.AssetType
                        }
                    });
                    local v12 = CatalogUtilities.GetLayoutOrderFromAssetType(v.AssetType, v.ItemType);
                    v11.LayoutOrder = CatalogUtilities.DefaultRobloxClothingIds[tonumber(i)] and 99999 or v12;
                    v11.Name = i;
                    v11.Parent = u4;
                end;
            end;

            u6.Visible = #u4:GetChildren() == 1;
        end);

        if success == false then
            warn("error during updateEquipped avatar preview items:", (tostring(result)));
        end;
    end);
end;

function v1.UpdateFavorited(u13, u14) -- Line: 80
    -- upvalues: u3 (ref), FavoriteController (copy), u5 (ref), ItemButton (copy), u4 (ref)
    if u3 then
        task.cancel(u3);
    end;

    u3 = task.spawn(function() -- Line: 85
        -- upvalues: u13 (ref), FavoriteController (ref), u14 (copy), u5 (ref), ItemButton (ref), u4 (ref), u3 (ref)
        if u13 == nil then
            local v15, v16 = FavoriteController.GetFavorites();

            if not v15 then
                warn("no favorited");

                return;
            end;

            u13 = v16;
        end;

        local success, result = pcall(function() -- Line: 96
            -- upvalues: u14 (ref), u5 (ref), ItemButton (ref), u13 (ref), u4 (ref)
            if not u14 then
                task.spawn(function() -- Line: 98
                    -- upvalues: u5 (ref), ItemButton (ref), u13 (ref)
                    for _, child in u5:GetChildren() do
                        ItemButton.SetFavorited(child, u13[child.Name] ~= nil);
                    end;
                end);
            end;

            for _, child in u4:GetChildren() do
                ItemButton.SetFavorited(child, u13[child.Name] ~= nil);
            end;
        end);

        if success == false then
            warn("error during updateFavorited:", result);
        end;

        u3 = nil;
    end);
end;

return v1;