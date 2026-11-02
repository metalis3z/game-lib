-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local MarketplaceService = game:GetService("MarketplaceService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Modules = require(script.Parent.Parent.Modules);
local LocalPlayer = Players.LocalPlayer;
local Cache = require(Modules.Services.Cache);
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local u1 = {
    _onPurchaseFinished = Instance.new("BindableEvent")
};
u1.OnPurchaseFinished = u1._onPurchaseFinished.Event;
Remotes.PurchaseFinished.OnClientEvent:Connect(function(p2, p3, p4) -- Line: 18
    -- upvalues: Cache (copy), u1 (copy)
    if p4 then
        local v5 = p3 .. "_" .. tostring(p2);
        Cache.Set("OwnershipCache", v5, true, 900);
    end;

    u1._onPurchaseFinished:Fire(p2, p3, p4);
end);

function u1.CheckItem(p6) -- Line: 26
    -- upvalues: Cache (copy), MarketplaceService (copy), LocalPlayer (copy)
    local u7 = tonumber(p6.Id);

    if not u7 then
        return true;
    end;

    local u8;

    if p6.Type then
        u8 = p6.Type == Enum.MarketplaceProductType.AvatarBundle;
    else
        u8 = p6.ItemType == "Bundle";
    end;

    local v9 = (u8 and "Bundle" or "Asset") .. "_" .. tostring(u7);

    return Cache.GetOrFetch("OwnershipCache", v9, 900, function() -- Line: 33
        -- upvalues: u8 (copy), MarketplaceService (ref), LocalPlayer (ref), u7 (copy)
        local v10 = 0.5;

        for _ = 1, 3 do
            local success, result = pcall(function() -- Line: 38
                -- upvalues: u8 (ref), MarketplaceService (ref), LocalPlayer (ref), u7 (ref)
                if u8 then
                    return MarketplaceService:PlayerOwnsBundleAsync(LocalPlayer, u7);
                end;

                return MarketplaceService:PlayerOwnsAssetAsync(LocalPlayer, u7);
            end);

            if success then
                return result;
            end;

            local v11 = tostring(result);

            if v11:match("429") or v11:match("Too Many Requests") then
                task.wait(v10);
                v10 = v10 * 2;
            else
                if not (v11:match("500") or v11:match("503")) then
                    break;
                end;

                task.wait(1);
            end;
        end;

        return true;
    end);
end;

function u1.CheckBatch(p12, p13) -- Line: 65
    -- upvalues: u1 (copy)
    for _, v in p12 do
        p13(v, (u1.CheckItem(v)));
    end;
end;

return u1;