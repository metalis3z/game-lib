-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local AvatarEditorService = game:GetService("AvatarEditorService");
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
local Events = script.Parent.Parent:WaitForChild("Events");
local BindableEvent = Instance.new("BindableEvent");
local u1 = {
    DefaultImage = "rbxassetid://83570005866923",
    Attribute = "AvatarBackgroundId",
    Changed = BindableEvent.Event
};
local u2 = {};
local u3 = nil;

local function getSettingsController() -- Line: 33
    -- upvalues: u3 (ref)
    if not u3 then
        u3 = require(script.Parent.SettingsController);
    end;

    return u3;
end;

function u1.GetItemInfo(p4) -- Line: 40
    -- upvalues: u2 (copy), AvatarEditorService (copy)
    local u5 = tonumber(p4);

    if not u5 then
        return nil;
    end;

    local v6 = u2[u5];

    if v6 ~= nil then
        return v6;
    end;

    local success, result = pcall(function() -- Line: 47
        -- upvalues: AvatarEditorService (ref), u5 (copy)
        return AvatarEditorService:GetItemDetails(u5, Enum.AvatarItemType.Asset);
    end);

    if not success or typeof(result) ~= "table" then
        return nil;
    end;

    local v7 = {
        IsBackground = result.AssetType == "AvatarBackground",
        Name = result.Name
    };
    u2[u5] = v7;

    return v7;
end;

function u1.SeedItemInfo(p8, p9) -- Line: 64
    -- upvalues: u2 (copy)
    local v10 = tonumber(p8);

    if v10 and u2[v10] == nil then
        u2[v10] = {
            IsBackground = true,
            Name = p9
        };
    end;
end;

function u1.IsRobloxBackground(p11) -- Line: 71
    -- upvalues: u1 (copy)
    local v12 = u1.GetItemInfo(p11);
    local v13;

    if v12 == nil then
        v13 = false;
    else
        v13 = v12.IsBackground == true;
    end;

    return v13;
end;

function u1.GetBackgroundName(p14) -- Line: 77
    -- upvalues: u1 (copy)
    local v15 = u1.GetItemInfo(p14);

    if v15 and v15.IsBackground then
        return v15.Name;
    end;

    return nil;
end;

function u1.GetEquippedId() -- Line: 83
    -- upvalues: u3 (ref)
    if not u3 then
        u3 = require(script.Parent.SettingsController);
    end;

    local v16 = u3.GetSetting({ "Interface", "AvatarSectionBackground" });

    if typeof(v16) == "string" and v16 ~= "" then
        return v16;
    end;

    return nil;
end;

function u1.IsEquipped(p17) -- Line: 89
    -- upvalues: u1 (copy)
    local v18 = u1.GetEquippedId();

    if v18 == nil then
        return false;
    end;

    local v19 = tonumber(v18);
    local v20 = tonumber(p17);

    if v19 and v20 then
        return v19 == v20;
    end;

    return v18 == tostring(p17);
end;

function u1.GetBackgroundImage(p21) -- Line: 101
    return `rbxthumb://type=Asset&id={tonumber(p21) or p21}&w=420&h=420`;
end;

function u1.ApplyToImage(p22, p23) -- Line: 109
    -- upvalues: u1 (copy)
    if not p22 then
        return;
    end;

    if p23 == nil or p23 == "" then
        p22.Image = "rbxassetid://83570005866923";
        p22.ScaleType = Enum.ScaleType.Stretch;

        return;
    end;

    p22.Image = u1.GetBackgroundImage(p23);
    p22.ScaleType = Enum.ScaleType.Crop;
end;

function u1.ApplyToPreview(p24) -- Line: 122
    -- upvalues: PlayerGui (copy), u1 (copy), BindableEvent (copy)
    local Catalog = PlayerGui:FindFirstChild("Catalog");

    if Catalog then
        Catalog = Catalog:FindFirstChild("container");
    end;

    if Catalog then
        Catalog = Catalog:FindFirstChild("avatarSection");
    end;

    if Catalog then
        Catalog = Catalog:FindFirstChild("preview");
    end;

    if Catalog then
        Catalog = Catalog:FindFirstChild("background");
    end;

    u1.ApplyToImage(Catalog, p24);

    if p24 == "" then
        p24 = nil;
    end;

    BindableEvent:Fire(p24);
end;

local function saveSetting(p25) -- Line: 132
    -- upvalues: u3 (ref), u1 (copy)
    if not u3 then
        u3 = require(script.Parent.SettingsController);
    end;

    if u3.UpdateSettings({
        Interface = {
            AvatarSectionBackground = p25
        }
    }) == false then
        return false;
    end;

    u1.ApplyToPreview(p25);

    return true;
end;

function u1.Equip(p26) -- Line: 144
    -- upvalues: u1 (copy), Events (copy), saveSetting (copy)
    local v27 = tostring(p26.Id);
    u1.SeedItemInfo(v27, p26.Name);
    local v28 = u1.GetEquippedId();

    if v28 and (v28 ~= v27 and (not u1.IsRobloxBackground(v28) and Events.PromptConfirmationDialog:Invoke({
        Title = "Replace background?",
        Description = "You have a custom background set in Settings. Do you want to replace it with this one?",
        YesText = "Replace",
        NoText = "Cancel"
    }) ~= true)) then
        return false;
    end;

    return saveSetting(v27);
end;

function u1.Unequip() -- Line: 163
    -- upvalues: saveSetting (copy)
    return saveSetting("");
end;

return u1;