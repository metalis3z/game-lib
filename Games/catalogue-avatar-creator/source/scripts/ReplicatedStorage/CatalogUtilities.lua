-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local AvatarEditorService = game:GetService("AvatarEditorService");
local u1 = {};
local BodyAdjustment = require(script.Parent:WaitForChild("SortingSchema")).BodyAdjustment;

if BodyAdjustment and (BodyAdjustment.Subcategories and (BodyAdjustment.Subcategories.HeadShapes and BodyAdjustment.Subcategories.HeadShapes.Shapes)) then
    for _, v in BodyAdjustment.Subcategories.HeadShapes.Shapes do
        u1[v.Key] = v.AssetId;
    end;
end;

local u2 = {};

for i, v in u1 do
    u2[v] = i;
end;

local HumanoidDescription = Instance.new("HumanoidDescription");
local u3 = utf8.char(57344);
local u4 = {
    HeadShapeKeyToAssetId = u1,
    HeadShapeAssetIdToKey = u2,
    LayeredClothingPriorities = {
        Eyelash = 1,
        Eyebrow = 2,
        LeftShoe = 3,
        RightShoe = 3,
        Pants = 4,
        Shorts = 5,
        DressSkirt = 6,
        TShirt = 7,
        Shirt = 8,
        Sweater = 9,
        Jacket = 10
    },
    BodyScaleRules = {
        HeightScale = {
            Min = 0.6,
            Max = 1.3
        },
        WidthScale = {
            Min = 0.6,
            Max = 1.3
        },
        DepthScale = {
            Min = 0.6,
            Max = 1.2
        },
        ProportionScale = {
            Min = 0,
            Max = 1
        },
        BodyTypeScale = {
            Min = 0,
            Max = 1
        },
        HeadScale = {
            Min = 0.8,
            Max = 1.1
        }
    },
    MovementAnimationToNameMap = {
        WalkAnimation = "walk",
        RunAnimation = "run",
        SwimAnimation = "swim",
        IdleAnimation = "idle",
        JumpAnimation = "jump",
        ClimbAnimation = "climb",
        FallAnimation = "fall"
    },
    HumanoidDescriptionProperties = { "AccessoryBlob", "BackAccessory", "BodyTypeScale", "ClimbAnimation", "DepthScale", "Face", "FaceAccessory", "FallAnimation", "FrontAccessory", "GraphicTShirt", "HairAccessory", "HatAccessory", "Head", "HeadColor", "HeadScale", "HeightScale", "IdleAnimation", "JumpAnimation", "LeftArm", "LeftArmColor", "LeftLeg", "LeftLegColor", "MoodAnimation", "NeckAccessory", "Pants", "ProportionScale", "RightArm", "RightArmColor", "RightLeg", "RightLegColor", "RunAnimation", "Shirt", "ShouldersAccessory", "StaticFacialAnimation", "SwimAnimation", "Torso", "TorsoColor", "WaistAccessory", "WalkAnimation", "WidthScale" },
    DefaultRobloxClothingIds = {
        [855760101] = true,
        [855766176] = true,
        [855768342] = true,
        [855773575] = true,
        [855776103] = true,
        [855777286] = true,
        [855778084] = true,
        [855779323] = true,
        [855780360] = true,
        [855781078] = true,
        [855781508] = true,
        [855782253] = true,
        [855782781] = true,
        [855783877] = true,
        [855784936] = true,
        [855785499] = true
    },
    HumanoidDescriptionApplicableProperties = {
        Pants = "Pants",
        Shirt = "Shirt",
        Face = "Face",
        Head = "Head",
        DynamicHead = "Head",
        Torso = "Torso",
        LeftArm = "LeftArm",
        RightArm = "RightArm",
        LeftLeg = "LeftLeg",
        RightLeg = "RightLeg",
        MoodAnimation = "MoodAnimation",
        ClimbAnimation = "ClimbAnimation",
        FallAnimation = "FallAnimation",
        IdleAnimation = "IdleAnimation",
        JumpAnimation = "JumpAnimation",
        RunAnimation = "RunAnimation",
        SwimAnimation = "SwimAnimation",
        WalkAnimation = "WalkAnimation",
        ShoulderAccessory = "ShouldersAccessory",
        BackAccessory = "BackAccessory",
        FrontAccessory = "FrontAccessory",
        Hat = "HatAccessory",
        TShirt = "GraphicTShirt",
        WaistAccessory = "WaistAccessory",
        NeckAccessory = "NeckAccessory",
        FaceAccessory = "FaceAccessory",
        HairAccessory = "HairAccessory"
    },
    MakeupAssetTypeToMakeupType = {
        FaceMakeup = "Face",
        LipMakeup = "Lip",
        EyeMakeup = "Eye"
    },
    MakeupTypeToAssetTypeName = {
        Face = "FaceMakeup",
        Lip = "LipMakeup",
        Eye = "EyeMakeup"
    },
    HumanoidDescriptionAcceptedAssetTypes = {
        Gear = "Gear",
        Pants = "Pants",
        Shirt = "Shirt",
        Face = "Face",
        Head = "Head",
        DynamicHead = "Head",
        Torso = "Torso",
        LeftArm = "LeftArm",
        RightArm = "RightArm",
        LeftLeg = "LeftLeg",
        RightLeg = "RightLeg",
        MoodAnimation = "MoodAnimation",
        ClimbAnimation = "ClimbAnimation",
        FallAnimation = "FallAnimation",
        IdleAnimation = "IdleAnimation",
        JumpAnimation = "JumpAnimation",
        RunAnimation = "RunAnimation",
        SwimAnimation = "SwimAnimation",
        WalkAnimation = "WalkAnimation",
        ShoulderAccessory = "ShouldersAccessory",
        Hat = "HatAccessory",
        HatAccessory = "HatAccessory",
        TShirt = "GraphicTShirt",
        GraphicTShirt = "GraphicTShirt",
        LeftShoeAccessory = "LeftShoeAccessory",
        RightShoeAccessory = "RightShoeAccessory",
        BackAccessory = "BackAccessory",
        WaistAccessory = "WaistAccessory",
        FrontAccessory = "FrontAccessory",
        NeckAccessory = "NeckAccessory",
        FaceAccessory = "FaceAccessory",
        HairAccessory = "HairAccessory",
        PantsAccessory = "PantsAccessory",
        ShortsAccessory = "ShortsAccessory",
        ShirtAccessory = "ShirtAccessory",
        TShirtAccessory = "TShirtAccessory",
        DressSkirtAccessory = "DressSkirtAccessory",
        SweaterAccessory = "SweaterAccessory",
        JacketAccessory = "JacketAccessory",
        EmoteAnimation = "EmoteAnimation",
        Animations = "Animations",
        Shoes = "Shoes",
        BodyParts = "BodyParts",
        EyebrowAccessory = "EyebrowAccessory",
        EyelashAccessory = "EyelashAccessory",
        FaceMakeup = "FaceMakeup",
        EyeMakeup = "EyeMakeup",
        LipMakeup = "LipMakeup",
        HeadShape = "HeadShape"
    },
    BodyParts = {
        Head = true,
        LeftArm = true,
        RightArm = true,
        Torso = true,
        LeftLeg = true,
        RightLeg = true,
        MoodAnimation = true
    },
    AvatarEditorServiceAcceptedItemTypes = {
        Bundle = true,
        Asset = true
    },
    SkinTonePresetColors = {
        Basic = { "#3d2e24", "#4b382e", "#594233", "#5a4c42", "#896e4a", "#aa8a62", "#af9483", "#d3a783", "#e8b995", "#edd5b4", "#f5f6f6", "#b43a34", "#a45a1b", "#db8641", "#fbe27d", "#b3be44", "#51994c", "#287f47", "#05aded", "#00fffe", "#377ab5", "#ff98dc", "#b27efe", "#845197", "#d417b1" },
        Advanced = { "#564236", "#694028", "#7c5c46", "#957977", "#af9483", "#c7ac78", "#d7c59a", "#da867a", "#a34b4b", "#aa5500", "#a05f35", "#cc8e69", "#eab892", "#ffcc99", "#d5733d", "#da8541", "#e29b40", "#ffaf00", "#f5cd30", "#f8d96d", "#fdea8d", "#27462d", "#3a7d15", "#287f47", "#4b974b", "#5b9a4c", "#7c9c6b", "#a4bd47", "#002060", "#2154b9", "#0000ff", "#0d69ac", "#527cae", "#6e99ca", "#b4d2e4", "#008f9c", "#12eed4", "#9ff3e9", "#00ffff", "#04afec", "#80bbdc", "#afddff", "#6b327c", "#8c5b9f", "#a75e9b", "#aa00aa", "#6225d1", "#b480ff", "#b1a7ff", "#c4281c", "#ff0000", "#ff00bf", "#ff66cc", "#ff98dc", "#e8bac8", "#ffc9c9", "#5a4c42", "#bc9b5d", "#c1be42", "#a1c48c", "#7f8e64", "#789082", "#74869d", "#00ff00", "#ccffcc", "#ffff00", "#ffffcc", "#111111", "#1b2a35", "#635f62", "#a3a2a5", "#cdcdcd", "#e5e4df", "#f2f3f3", "#f8f8f8" }
    }
};
task.spawn(function() -- Line: 310
    -- Use bounded retries: an unavailable API must never become a tight CPU loop.
    for attempt = 1, 6 do
        local success, result = pcall(function()
            return AvatarEditorService:GetAvatarRulesAsync();
        end);

        if success and result then
            u4.AvatarRules = result;

            return;
        end;

        task.wait(math.min(0.5 * 2 ^ (attempt - 1), 5));
    end;

    u4.AvatarRules = {
        Scales = {}
    };
    warn("[AvatarMaker] Avatar rules unavailable; using safe local bounds.");
end);

function u4.GetAssetType(p5) -- Line: 318
    if typeof(p5) == "number" then
        return Enum.AssetType:FromValue(p5);
    end;

    if typeof(p5) == "string" then
        local v6 = p5 == "GraphicTShirt" and "TShirt" or p5;
        local v7 = Enum.AssetType:FromName(v6);

        if v7 == nil then
            return Enum.AssetType:FromName(v6 .. "Accessory");
        end;

        return v7;
    end;

    if typeof(p5) ~= "EnumItem" then
        return nil;
    end;

    local v8 = Enum.AssetType:FromName(p5.Name);

    if v8 == nil then
        v8 = Enum.AssetType:FromName(p5.Name .. "Accessory") or Enum.AssetType:FromName(string.gsub(p5.Name, "Accessory", ""));
    end;

    return v8;
end;

function u4.IsLayeredClothing(p9) -- Line: 344
    -- upvalues: u4 (copy)
    local v10 = u4.GetAssetType(p9);

    return u4.LayeredClothingPriorities[v10] ~= nil;
end;

function u4.GetLayoutOrderFromAssetType(p11, p12) -- Line: 349
    -- upvalues: u4 (copy)
    local v13 = u4.GetAssetType(p11);

    if v13 == nil then
        return p12 == "Bundle" and 0 or 999;
    end;

    local Value = v13.Value;
    local Name = v13.Name;

    return (Name == "Head" or (Name == "DynamicHead" or Name == "Face")) and 10 or ((Name == "HairAccessory" or Name == "Hair") and 30 or ((Value >= 41 and Value <= 47 or Name == "Hat") and 40 or (Value <= 12 and (Name == "GraphicTShirt" and 46 or 45) or (Value >= 64 and Value <= 72 and 50 or (Value == 61 and 60 or (Value >= 27 and Value <= 31 and 70 or (Value >= 48 and Value <= 56 and 80 or 999)))))));
end;

function u4.GetDescriptionPropertyType(u14) -- Line: 401
    -- upvalues: HumanoidDescription (copy)
    local success, result = pcall(function() -- Line: 402
        -- upvalues: HumanoidDescription (ref), u14 (copy)
        return typeof(HumanoidDescription[u14]);
    end);

    if success then
        return result;
    end;

    return nil;
end;

function u4.GetAssetTypeName(p15) -- Line: 408
    -- upvalues: u4 (copy)
    if p15 ~= nil then
        if typeof(p15) ~= "EnumItem" then
            p15 = u4.GetAssetType(p15);

            if p15 == nil then
                return warn("couldn\'t get asset type for", p15);
            end;
        end;

        return u4.HumanoidDescriptionAcceptedAssetTypes[p15.Name];
    end;
end;

function u4.GetEquippedAssetIdsFromDescription(p16, p17, p18) -- Line: 421
    -- upvalues: u4 (copy), Players (copy), u1 (copy), u2 (copy)
    if p16 == nil then
        return;
    end;

    local u19 = {};

    local function insertItem(p20, p21, p22) -- Line: 427
        -- upvalues: u19 (ref)
        table.insert(u19, {
            AssetId = p20,
            ItemType = p21,
            AssetType = p22
        });
    end;

    for _, v in p16:GetAccessories(true) do
        local Name = v.AccessoryType.Name;

        if v.IsLayered == true then
            Name = Name .. "Accessory";
        end;

        table.insert(u19, {
            ItemType = "Asset",
            AssetId = v.AssetId,
            AssetType = Name
        });
    end;

    local function insertIfValidNumber(p23, p24, p25) -- Line: 444
        -- upvalues: u19 (ref)
        if p23 and (typeof(p23) == "number" and p23 ~= 0) then
            table.insert(u19, {
                AssetId = p23,
                ItemType = p24,
                AssetType = p25
            });
        end;
    end;

    for _, v in u4.HumanoidDescriptionApplicableProperties do
        local v26 = p16[v];

        if v26 and (typeof(v26) == "number" and v26 ~= 0) then
            table.insert(u19, {
                ItemType = "Asset",
                AssetId = v26,
                AssetType = v
            });
        end;
    end;

    if p17 then
        for i, v in p17:GetAttributes() do
            if string.match(i, "Bundle$") and (v and (typeof(v) == "number" and v ~= 0)) then
                table.insert(u19, {
                    ItemType = "Bundle",
                    AssetId = v,
                    AssetType = i
                });
            end;
        end;

        local Parent = p17.Parent;

        if Parent and Parent:IsA("Model") then
            local v27 = Players:FindFirstChild(Parent.Name);

            for _, child in Parent:GetChildren() do
                if child:IsA("Tool") then
                    local v28 = child:GetAttribute("assetId");

                    if v28 and (typeof(v28) == "number" and v28 ~= 0) then
                        table.insert(u19, {
                            ItemType = "Asset",
                            AssetType = "Gear",
                            AssetId = v28
                        });
                    end;
                end;
            end;

            if v27 and v27.Backpack then
                for _, child in v27.Backpack:GetChildren() do
                    if child:IsA("Tool") then
                        local v29 = child:GetAttribute("assetId");

                        if v29 and (typeof(v29) == "number" and v29 ~= 0) then
                            table.insert(u19, {
                                ItemType = "Asset",
                                AssetType = "Gear",
                                AssetId = v29
                            });
                        end;
                    end;
                end;
            end;
        end;
    end;

    local v30 = nil;
    local v31 = nil;

    for _, child in p16:GetChildren() do
        if child:IsA("BodyPartDescription") and child.BodyPart == Enum.BodyPart.Head then
            if child.HeadShape ~= "" then
                v31 = child.HeadShape;
            end;

            if child.AssetId ~= 0 then
                v30 = child.AssetId;
            end;

            break;
        end;
    end;

    local v32 = v30 or p16.Head;

    if v31 and u1[v31] then
        table.insert(u19, {
            ItemType = "Asset",
            AssetType = "HeadShape",
            AssetId = u1[v31]
        });
    elseif v32 and u2[v32] then
        table.insert(u19, {
            ItemType = "Asset",
            AssetType = "HeadShape",
            AssetId = v32
        });
    end;

    for _, child in p16:GetChildren() do
        if child:IsA("MakeupDescription") then
            local v33 = u4.MakeupTypeToAssetTypeName[child.MakeupType.Name];

            if v33 then
                table.insert(u19, {
                    ItemType = "Asset",
                    AssetId = child.AssetId,
                    AssetType = v33
                });
            end;
        end;
    end;

    if p18 then
        local v34 = {};

        for _, v in u19 do
            v34[tostring(v.AssetId)] = {
                ItemType = v.ItemType,
                AssetType = v.AssetType
            };
        end;

        u19 = v34;
    end;

    return u19;
end;

function u4.CreateHumanoidDescriptionWithoutUnownedItems(u35, p36) -- Line: 529
    -- upvalues: u4 (copy)
    local HumanoidDescription2 = Instance.new("HumanoidDescription");

    for _, v in u4.HumanoidDescriptionProperties do
        if not u4.HumanoidDescriptionApplicableProperties[v] then
            local success, result = pcall(function() -- Line: 539
                -- upvalues: u35 (copy), v (copy)
                return u35[v];
            end);

            if success then
                HumanoidDescription2[v] = result;
            end;
        end;
    end;

    local v37 = {};

    for _, v in u35:GetAccessories(true) do
        if p36.CheckItem({
            ItemType = "Asset",
            Id = v.AssetId
        }) then
            table.insert(v37, {
                AssetId = v.AssetId,
                AccessoryType = v.AccessoryType,
                IsLayered = v.IsLayered,
                Order = v.Order
            });
        end;
    end;

    HumanoidDescription2:SetAccessories(v37, true);

    for _, v in u4.HumanoidDescriptionApplicableProperties do
        local v38 = u35[v];

        if typeof(v38) == "number" and (v38 > 0 and p36.CheckItem({
            ItemType = "Asset",
            Id = v38
        })) then
            HumanoidDescription2[v] = v38;
        end;
    end;

    local v39 = u35:GetEmotes();
    local v40 = u35:GetEquippedEmotes();
    local v41 = {};
    local v42 = {};

    for i, v in v39 do
        local v43 = {};

        for _, v2 in v do
            if p36.CheckItem({
                ItemType = "Asset",
                Id = v2
            }) then
                table.insert(v43, v2);
            end;
        end;

        if #v43 > 0 then
            v41[i] = v43;
        end;
    end;

    for _, v in v40 do
        if v41[v.Name] then
            table.insert(v42, v);
        end;
    end;

    HumanoidDescription2:SetEmotes(v41);
    HumanoidDescription2:SetEquippedEmotes(v42);

    return HumanoidDescription2;
end;

function u4.FormatMemberCount(p44) -- Line: 605
    if p44 >= 1000000 then
        local v45 = math.floor(p44 / 1000000 * 10) / 10;

        return tostring(v45) .. "M+";
    end;

    if p44 >= 10000 then
        local v46 = math.floor(p44 / 1000 * 10) / 10;

        return tostring(v46) .. "K+";
    end;

    local v47 = tostring(p44);
    local v48;

    repeat
        v47, v48 = string.gsub(v47, "^(-?%d+)(%d%d%d)", "%1,%2");
    until v48 == 0;

    return v47;
end;

function u4.FormatNumber(p49) -- Line: 625
    if type(p49) ~= "number" then
        return "";
    end;

    local v50 = math.floor(p49);
    local v51 = tostring(v50);
    local v52;

    repeat
        v51, v52 = v51:gsub("^(-?%d+)(%d%d%d)", "%1,%2");
    until v52 == 0;

    return v51;
end;

function u4.FormatNumberDetailed(p53) -- Line: 632
    if p53 < 100000 then
        local v54 = tostring(p53);

        if #v54 > 3 then
            return v54:sub(1, #v54 - 3) .. "," .. v54:sub(#v54 - 2);
        end;

        return v54;
    end;

    if p53 < 1000000 then
        local v55 = math.floor(p53 / 1000);

        return tostring(v55) .. "K";
    end;

    local v56 = math.floor(p53 / 1000000);

    return tostring(v56) .. "M";
end;

function u4.FormatNumberCompact(p57) -- Line: 643
    if p57 < 10000 then
        local v58 = tostring(p57);

        if #v58 > 3 then
            return v58:sub(1, #v58 - 3) .. "," .. v58:sub(#v58 - 2);
        end;

        return v58;
    end;

    if p57 < 1000000 then
        local v59 = math.floor(p57 / 1000);

        return tostring(v59) .. "K";
    end;

    local v60 = math.floor(p57 / 1000000);

    return tostring(v60) .. "M";
end;

function u4.EscapeRichText(p61) -- Line: 654
    return tostring(p61 or ""):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;");
end;

function u4.PickPriceFromAES(p62) -- Line: 658
    if p62.LimitedType then
        if type(p62.LowestPrice) == "number" then
            return p62.LowestPrice;
        end;

        if type(p62.LowestResalePrice) == "number" then
            return p62.LowestResalePrice;
        end;
    end;

    if type(p62.Price) == "number" then
        return p62.Price;
    end;

    if type(p62.LowestPrice) == "number" then
        return p62.LowestPrice;
    end;

    return p62.LowestResalePrice;
end;

function u4.GetRestrictionInfo(p63) -- Line: 669
    local ItemRestrictions = p63.ItemRestrictions;

    if not ItemRestrictions then
        return nil;
    end;

    for _, v in ItemRestrictions do
        if v == "Limited" then
            return {
                Type = "Limited",
                Icon = "rbxassetid://111312316554275"
            };
        end;

        if v == "LimitedUnique" or v == "Collectible" then
            return {
                Type = "Collectible",
                Icon = "rbxassetid://127222238970476"
            };
        end;
    end;

    return nil;
end;

function u4.GetStockString(p64) -- Line: 683
    -- upvalues: u4 (copy)
    local UnitsAvailableForConsumption = p64.UnitsAvailableForConsumption;
    local TotalQuantity = p64.TotalQuantity;

    if UnitsAvailableForConsumption and (TotalQuantity and UnitsAvailableForConsumption > 1) then
        return `{u4.FormatNumberCompact(UnitsAvailableForConsumption)}/{u4.FormatNumberCompact(TotalQuantity)} left`;
    end;

    return nil;
end;

function u4.GetPrice(p65, p66) -- Line: 693
    -- upvalues: u4 (copy)
    if p65.IsInventoryItem then
        return "Inventory";
    end;

    local PriceStatus = p65.PriceStatus;
    local IsOffSale = p65.IsOffSale;
    local v67 = u4.PickPriceFromAES(p65);

    if p66 == nil then
        if PriceStatus == "Offsale" then
            return "Offsale";
        end;

        if PriceStatus == "Free" then
            return "Free";
        end;

        if IsOffSale then
            return "Offsale";
        end;

        if type(v67) == "number" then
            return v67 == 0 and "Free" or v67;
        end;
    else
        if PriceStatus == "NoResellers" or p65.HasResellers == false and p65.UnitsAvailableForConsumption <= 0 then
            return "NoResellers";
        end;

        if PriceStatus == "Free" then
            return "Free";
        end;

        if type(v67) == "number" then
            return v67;
        end;
    end;

    return "Offsale";
end;

local u68 = { "Name", "CreatorName", "Price" };

function u4.GetItemData(p69) -- Line: 724
    -- upvalues: u3 (copy), u4 (copy), u68 (copy)
    local v70 = p69.IsInventoryItem == true;
    local v71 = p69.AssetId or p69.Id;
    local ItemType = p69.ItemType;
    local AssetType = p69.AssetType;
    local BundleType = p69.BundleType;

    if v70 then
        ItemType = "Asset";
    elseif ItemType == "Gear" then
        AssetType = "Gear";
        ItemType = "Asset";
    end;

    local v72 = tostring(p69.CreatorName or "");
    local v73 = p69.CreatorHasVerifiedBadge == true;
    local v74;

    if v73 and v72 ~= "" then
        v74 = v72 .. u3;
    else
        v74 = v72;
    end;

    local v75 = u4.GetRestrictionInfo(p69);
    local v76;

    if v75 then
        v76 = v75.Type;
    else
        v76 = v75;
    end;

    if v75 then
        v75 = v75.Icon;
    end;

    local v77 = table.clone(p69);
    v77.LimitedType = v76;
    local v78 = u4.GetPrice(v77, v76);
    local v79;

    if v76 then
        v79 = u4.GetStockString(p69);
    else
        v79 = nil;
    end;

    local v80 = `rbxthumb://type={ItemType == "Bundle" and "BundleThumbnail" or "Asset"}&id={v71}&w=420&h=420`;
    local v81 = {
        Id = v71,
        Name = p69.Name or "",
        ItemType = ItemType,
        AssetType = AssetType,
        BundleType = BundleType,
        IsInventory = v70,
        Description = p69.Description or "",
        Thumbnail = v80,
        CreatorName = v72,
        CreatorDisplay = v74,
        CreatorType = p69.CreatorType or nil,
        CreatorId = p69.CreatorTargetId or (p69.CreatorId or nil),
        IsVerifiedCreator = v73,
        Price = v78,
        StockString = v79,
        FavoriteCount = p69.FavoriteCount,
        RestrictionType = v76,
        RestrictionIcon = v75,
        CreatedDate = p69.Created,
        Meta = p69.Meta
    };

    for _, v in u68 do
        if p69[v] == nil then
            v81.IsLackingDetails = true;
        end;
    end;

    return v81;
end;

function u4.NormalizeRobloxOutfitDetails(p82) -- Line: 801
    return {
        Id = p82.id or p82.Id,
        Name = p82.name or p82.Name,
        IsEditable = p82.isEditable or p82.IsEditable,
        OutfitType = p82.outfitType or p82.OutfitType
    };
end;

return u4;