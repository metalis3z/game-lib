-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Modules = require(script.Parent.Parent.Modules);
local AvatarPreviewController = require(Modules.Controllers.AvatarPreviewController);
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
local ThemeController = require(Modules.Controllers.ThemeController);
local CatalogUtilities = require(Modules.Shared.CatalogUtilities);
local DraggablePanel = require(Modules.Utilities.DraggablePanel);
local LocalPlayer = Players.LocalPlayer;
local RemoveItems = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("RemoveItems");
local container = RemoveItems:WaitForChild("container");
local wrapper = container:WaitForChild("wrapper");
local scroll = wrapper:WaitForChild("categoriesSection"):WaitForChild("scroll");
local viewport = wrapper:WaitForChild("preview"):WaitForChild("viewport");
local closeButton = wrapper:WaitForChild("closeButton");
local removeButton = wrapper:WaitForChild("removeButton");
local title = wrapper:WaitForChild("title");
local u1 = DraggablePanel.new(title, container, {
    ScreenGui = RemoveItems
});
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local Events = script.Parent.Parent:WaitForChild("Events");

local function font(p2) -- Line: 60
    return Font.new("rbxassetid://16658221428", p2 or Enum.FontWeight.Medium, Enum.FontStyle.Normal);
end;

local u3 = {
    CardBackground = Color3.fromRGB(43, 45, 51),
    SurfaceBackground = Color3.fromRGB(33, 34, 39),
    ButtonBackground = Color3.fromRGB(29, 29, 31),
    HoverBackground = Color3.fromRGB(61, 63, 69),
    SubtleStroke = Color3.fromRGB(70, 68, 77),
    TextHeading = Color3.fromRGB(247, 247, 248),
    TextSecondary = Color3.fromRGB(237, 238, 238),
    TextMuted = Color3.fromRGB(213, 215, 221),
    IconMuted = Color3.fromRGB(214, 213, 222),
    TextPrimary = Color3.fromRGB(255, 255, 255)
};
local u4 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u5 = TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u6 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u7 = TweenService:Create(container, u4, {
    GroupTransparency = 0
});
local u8 = TweenService:Create(container, u4, {
    GroupTransparency = 1
});
local u9 = {
    {
        key = "all",
        label = "All",
        layoutOrder = 10
    },
    {
        key = "accessories",
        label = "Accessories",
        layoutOrder = 100,
        subs = { {
                key = "hat",
                label = "Hat",
                assetTypes = { "HatAccessory" }
            }, {
                key = "face",
                label = "Face",
                assetTypes = { "FaceAccessory" }
            }, {
                key = "neck",
                label = "Neck",
                assetTypes = { "NeckAccessory" }
            }, {
                key = "shoulders",
                label = "Shoulders",
                assetTypes = { "ShoulderAccessory" }
            }, {
                key = "waist",
                label = "Waist",
                assetTypes = { "WaistAccessory" }
            }, {
                key = "back",
                label = "Back",
                assetTypes = { "BackAccessory" }
            }, {
                key = "front",
                label = "Front",
                assetTypes = { "FrontAccessory" }
            } }
    },
    {
        key = "hair",
        label = "Hair",
        layoutOrder = 200,
        subs = { {
                key = "hair",
                label = "Hair",
                assetTypes = { "HairAccessory" }
            }, {
                key = "eyebrows",
                label = "Eyebrows",
                assetTypes = { "EyebrowAccessory" }
            }, {
                key = "eyelashes",
                label = "Eyelashes",
                assetTypes = { "EyelashAccessory" }
            } }
    },
    {
        key = "classicClothing",
        label = "Classic Clothing",
        layoutOrder = 300,
        subs = { {
                key = "shirt",
                label = "Shirt",
                assetTypes = { "Shirt" }
            }, {
                key = "pants",
                label = "Pants",
                assetTypes = { "Pants" }
            }, {
                key = "tshirt",
                label = "T-Shirt",
                assetTypes = { "GraphicTShirt" }
            } }
    },
    {
        key = "layeredClothing",
        label = "Layered Clothing",
        layoutOrder = 400,
        subs = { {
                key = "jacket",
                label = "Jacket",
                assetTypes = { "JacketAccessory" }
            }, {
                key = "sweater",
                label = "Sweater",
                assetTypes = { "SweaterAccessory" }
            }, {
                key = "shirt",
                label = "Shirt",
                assetTypes = { "ShirtAccessory" }
            }, {
                key = "tshirt",
                label = "T-Shirt",
                assetTypes = { "TShirtAccessory" }
            }, {
                key = "dressSkirt",
                label = "Dress/Skirt",
                assetTypes = { "DressSkirtAccessory" }
            }, {
                key = "shorts",
                label = "Shorts",
                assetTypes = { "ShortsAccessory" }
            }, {
                key = "pants",
                label = "Pants",
                assetTypes = { "PantsAccessory" }
            }, {
                key = "shoes",
                label = "Shoes",
                assetTypes = { "LeftShoeAccessory", "RightShoeAccessory" }
            } }
    },
    {
        key = "bodyParts",
        label = "Body Parts",
        layoutOrder = 500,
        subs = { {
                key = "head",
                label = "Head",
                assetTypes = { "Head" }
            }, {
                key = "torso",
                label = "Torso",
                assetTypes = { "Torso" }
            }, {
                key = "leftArm",
                label = "Left Arm",
                assetTypes = { "LeftArm" }
            }, {
                key = "rightArm",
                label = "Right Arm",
                assetTypes = { "RightArm" }
            }, {
                key = "leftLeg",
                label = "Left Leg",
                assetTypes = { "LeftLeg" }
            }, {
                key = "rightLeg",
                label = "Right Leg",
                assetTypes = { "RightLeg" }
            }, {
                key = "headShape",
                label = "Head Shape",
                assetTypes = { "HeadShape" }
            } }
    },
    {
        key = "animations",
        label = "Animations",
        layoutOrder = 600,
        subs = { {
                key = "idle",
                label = "Idle",
                assetTypes = { "IdleAnimation" }
            }, {
                key = "walk",
                label = "Walk",
                assetTypes = { "WalkAnimation" }
            }, {
                key = "run",
                label = "Run",
                assetTypes = { "RunAnimation" }
            }, {
                key = "jump",
                label = "Jump",
                assetTypes = { "JumpAnimation" }
            }, {
                key = "fall",
                label = "Fall",
                assetTypes = { "FallAnimation" }
            }, {
                key = "climb",
                label = "Climb",
                assetTypes = { "ClimbAnimation" }
            }, {
                key = "swim",
                label = "Swim",
                assetTypes = { "SwimAnimation" }
            }, {
                key = "mood",
                label = "Mood",
                assetTypes = { "MoodAnimation" }
            } }
    },
    {
        key = "makeup",
        label = "Makeup",
        layoutOrder = 700,
        subs = { {
                key = "face",
                label = "Face",
                assetTypes = { "FaceMakeup" }
            }, {
                key = "eye",
                label = "Eye",
                assetTypes = { "EyeMakeup" }
            }, {
                key = "lip",
                label = "Lip",
                assetTypes = { "LipMakeup" }
            } }
    },
    {
        key = "gear",
        label = "Gear",
        layoutOrder = 900,
        assetTypes = { "Gear" }
    }
};
local u10 = {
    HatAccessory = "Hat",
    HairAccessory = "Hair",
    FaceAccessory = "Face",
    NeckAccessory = "Neck",
    ShoulderAccessory = "Shoulder",
    WaistAccessory = "Waist",
    BackAccessory = "Back",
    FrontAccessory = "Front"
};
local u11 = {
    JacketAccessory = "Jacket",
    SweaterAccessory = "Sweater",
    ShirtAccessory = "Shirt",
    TShirtAccessory = "TShirt",
    DressSkirtAccessory = "DressSkirt",
    ShortsAccessory = "Shorts",
    PantsAccessory = "Pants",
    LeftShoeAccessory = "LeftShoe",
    RightShoeAccessory = "RightShoe",
    EyebrowAccessory = "Eyebrow",
    EyelashAccessory = "Eyelash"
};
local u12 = {
    Face = "Face",
    Head = "Head",
    Torso = "Torso",
    LeftArm = "LeftArm",
    RightArm = "RightArm",
    LeftLeg = "LeftLeg",
    RightLeg = "RightLeg",
    Shirt = "Shirt",
    Pants = "Pants",
    GraphicTShirt = "GraphicTShirt",
    IdleAnimation = "IdleAnimation",
    WalkAnimation = "WalkAnimation",
    RunAnimation = "RunAnimation",
    JumpAnimation = "JumpAnimation",
    FallAnimation = "FallAnimation",
    ClimbAnimation = "ClimbAnimation",
    SwimAnimation = "SwimAnimation",
    MoodAnimation = "MoodAnimation"
};
local u13 = {
    FaceMakeup = "Face",
    EyeMakeup = "Eye",
    LipMakeup = "Lip"
};
local u14 = {
    IsOpen = false
};
local u15 = {};
local u16 = {};
local u17 = {};
local u18 = {};
local u19 = {};
local u20 = {};
local u21 = nil;
local u22 = nil;
local u23 = nil;
local u24 = 0;
local u25 = nil;

local function clearConnections() -- Line: 241
    -- upvalues: u19 (copy)
    for _, v in u19 do
        if v then
            pcall(v.Disconnect, v);
        end;
    end;

    table.clear(u19);
end;

local function clearThreads() -- Line: 248
    -- upvalues: u20 (copy)
    for _, v in u20 do
        pcall(task.cancel, v);
    end;

    table.clear(u20);
end;

local function clearRows() -- Line: 255
    -- upvalues: scroll (copy), u16 (copy), u17 (copy)
    for _, child in scroll:GetChildren() do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;

    table.clear(u16);
    table.clear(u17);
end;

local function findCategory(p26) -- Line: 263
    -- upvalues: u9 (copy)
    for _, v in u9 do
        if v.key == p26 then
            return v;
        end;
    end;

    return nil;
end;

local function hasAnyEquippedOfAssetTypes(p27) -- Line: 271
    -- upvalues: u18 (ref)
    if typeof(p27) ~= "table" then
        return false;
    end;

    for _, v in p27 do
        local v28 = u18[v];

        if v28 and #v28 > 0 then
            return true;
        end;
    end;

    return false;
end;

local function categoryHasEquipped(p29) -- Line: 281
    -- upvalues: u18 (ref), hasAnyEquippedOfAssetTypes (ref)
    if p29.key == "all" then
        for _, v in u18 do
            if #v > 0 then
                return true;
            end;
        end;

        return false;
    end;

    if not p29.subs then
        return hasAnyEquippedOfAssetTypes(p29.assetTypes);
    end;

    for _, v in p29.subs do
        if hasAnyEquippedOfAssetTypes(v.assetTypes) then
            return true;
        end;
    end;

    return false;
end;

local function initState() -- Line: 300
    -- upvalues: u15 (ref), u9 (copy)
    u15 = {};

    for _, v in u9 do
        local v30 = {
            checked = false,
            expanded = false,
            subs = {}
        };

        if v.subs then
            for _, v2 in v.subs do
                v30.subs[v2.key] = false;
            end;
        end;

        u15[v.key] = v30;
    end;
end;

local u31 = { "Face", "Head", "Torso", "LeftArm", "RightArm", "LeftLeg", "RightLeg", "Shirt", "Pants", "GraphicTShirt", "IdleAnimation", "WalkAnimation", "RunAnimation", "JumpAnimation", "FallAnimation", "ClimbAnimation", "SwimAnimation", "MoodAnimation" };

local function buildEquippedBuckets(u32, p33) -- Line: 334
    -- upvalues: u31 (copy), CatalogUtilities (copy), Players (copy)
    local u34 = {};

    if u32 == nil then
        return u34;
    end;

    local success, result = pcall(u32.GetAccessories, u32, true);

    if success and typeof(result) == "table" then
        for _, v in result do
            local AccessoryType = v.AccessoryType;
            local v35 = AccessoryType and AccessoryType.Name or nil;

            if typeof(v35) == "string" and (v35 ~= "Unknown" and (v.AssetId and v.AssetId ~= 0)) then
                local v36 = v35 .. "Accessory";
                u34[v36] = u34[v36] or {};
                table.insert(u34[v36], v.AssetId);
            end;
        end;
    end;

    for _, v in u31 do
        local success2, result2 = pcall(function() -- Line: 356
            -- upvalues: u32 (copy), v (copy)
            return u32[v];
        end);

        if success2 and (typeof(result2) == "number" and result2 ~= 0) then
            u34[v] = u34[v] or {};
            table.insert(u34[v], result2);
        end;
    end;

    for _, child in u32:GetChildren() do
        if child:IsA("BodyPartDescription") and child.BodyPart == Enum.BodyPart.Head then
            local HeadShape = child.HeadShape;

            if typeof(HeadShape) == "string" and (HeadShape ~= "" and (CatalogUtilities.HeadShapeKeyToAssetId and CatalogUtilities.HeadShapeKeyToAssetId[HeadShape])) then
                u34.HeadShape = u34.HeadShape or {};
                table.insert(u34.HeadShape, CatalogUtilities.HeadShapeKeyToAssetId[HeadShape]);
            else
                local v37 = child.AssetId ~= 0 and child.AssetId or u32.Head;

                if v37 and (v37 ~= 0 and (CatalogUtilities.HeadShapeAssetIdToKey and CatalogUtilities.HeadShapeAssetIdToKey[v37])) then
                    u34.HeadShape = u34.HeadShape or {};
                    table.insert(u34.HeadShape, v37);
                end;
            end;
        elseif child:IsA("MakeupDescription") then
            local v38;

            if child.MakeupType then
                v38 = child.MakeupType.Name or nil;
            else
                v38 = nil;
            end;

            local v39 = v38 and CatalogUtilities.MakeupTypeToAssetTypeName and CatalogUtilities.MakeupTypeToAssetTypeName[v38];

            if v39 and (child.AssetId and child.AssetId ~= 0) then
                u34[v39] = u34[v39] or {};
                table.insert(u34[v39], child.AssetId);
            end;
        end;
    end;

    if p33 then
        p33 = p33.Parent;
    end;

    if p33 and p33:IsA("Model") then
        local function collectFrom(p40) -- Line: 395
            -- upvalues: u34 (copy)
            for _, child in p40:GetChildren() do
                if child:IsA("Tool") then
                    local v41 = child:GetAttribute("assetId");

                    if typeof(v41) == "number" and v41 ~= 0 then
                        u34.Gear = u34.Gear or {};
                        table.insert(u34.Gear, v41);
                    end;
                end;
            end;
        end;

        collectFrom(p33);
        local v42 = Players:GetPlayerFromCharacter(p33);

        if v42 and v42:FindFirstChild("Backpack") then
            collectFrom(v42.Backpack);
        end;
    end;

    return u34;
end;

local function applyRemovalsToDescription(p43, p44) -- Line: 419
    -- upvalues: u12 (copy), u10 (copy), u11 (copy), u13 (copy)
    local u45 = p43:Clone();
    local v46 = false;

    for i in p44 do
        local u47 = u12[i];

        if u47 then
            pcall(function() -- Line: 427
                -- upvalues: u45 (copy), u47 (copy)
                u45[u47] = 0;
            end);
        end;

        if i == "HeadShape" then
            v46 = true;
        end;
    end;

    local v48 = false;

    for i in p44 do
        if u10[i] or u11[i] then
            v48 = true;
            break;
        end;
    end;

    if v48 then
        local success, result = pcall(u45.GetAccessories, u45, true);

        if success and typeof(result) == "table" then
            local v49 = {};

            for _, v in result do
                local v50;

                if v.AccessoryType then
                    v50 = v.AccessoryType.Name or nil;
                else
                    v50 = nil;
                end;

                local v51 = false;

                for i in p44 do
                    if (u10[i] or u11[i]) == v50 then
                        v51 = true;
                        break;
                    end;
                end;

                if not v51 then
                    table.insert(v49, v);
                end;
            end;

            pcall(u45.SetAccessories, u45, v49, true);
        end;
    end;

    local v52 = {};

    for i in p44 do
        local v53 = u13[i];

        if v53 then
            v52[v53] = true;
        end;
    end;

    for _, child in u45:GetChildren() do
        if child:IsA("MakeupDescription") then
            local v54;

            if child.MakeupType then
                v54 = child.MakeupType.Name or nil;
            else
                v54 = nil;
            end;

            if v54 and v52[v54] then
                child:Destroy();
            end;
        elseif v46 and (child:IsA("BodyPartDescription") and child.BodyPart == Enum.BodyPart.Head) then
            pcall(function() -- Line: 478
                -- upvalues: child (copy)
                child.HeadShape = "";
            end);
        end;
    end;

    return u45;
end;

local function buildRemovalSet() -- Line: 486
    -- upvalues: u9 (copy), u15 (ref)
    local v55 = {};

    for _, v in u9 do
        if v.key ~= "all" then
            local v56 = u15[v.key];

            if v.subs then
                for _, v2 in v.subs do
                    if v56.subs[v2.key] then
                        for _, v3 in v2.assetTypes do
                            v55[v3] = true;
                        end;
                    end;
                end;
            elseif v56.checked then
                for _, v2 in v.assetTypes do
                    v55[v2] = true;
                end;
            end;
        end;
    end;

    return v55;
end;

local function setCheckboxVisual(p57, p58, p59) -- Line: 509
    -- upvalues: TweenService (copy), u5 (copy)
    local checkbox = p57:FindFirstChild("checkbox");

    if not checkbox then
        return;
    end;

    local checked = checkbox:FindFirstChild("checked");

    if not checked then
        return;
    end;

    local v60 = p58 and 0 or 1;

    if p59 then
        checked.ImageTransparency = v60;

        return;
    end;

    TweenService:Create(checked, u5, {
        ImageTransparency = v60
    }):Play();
end;

local function setChevronVisual(p61, p62, p63) -- Line: 522
    -- upvalues: TweenService (copy), u6 (copy)
    local chevron = p61:FindFirstChild("chevron");

    if not chevron then
        return;
    end;

    local v64 = p62 and 180 or 0;

    if p63 then
        chevron.Rotation = v64;

        return;
    end;

    TweenService:Create(chevron, u6, {
        Rotation = v64
    }):Play();
end;

local function wireRowHover(u65, u66, u67, u68, u69, u70) -- Line: 537
    -- upvalues: u19 (copy), TweenService (copy), u4 (copy), ThemeController (copy)
    table.insert(u19, u65.MouseEnter:Connect(function() -- Line: 538
        -- upvalues: TweenService (ref), u65 (copy), u4 (ref), ThemeController (ref), u68 (copy), u66 (copy), u70 (copy)
        TweenService:Create(u65, u4, {
            BackgroundColor3 = ThemeController.GetColor(u68)
        }):Play();
        TweenService:Create(u66, u4, {
            Transparency = u70
        }):Play();
    end));
    table.insert(u19, u65.MouseLeave:Connect(function() -- Line: 542
        -- upvalues: TweenService (ref), u65 (copy), u4 (ref), ThemeController (ref), u67 (copy), u66 (copy), u69 (copy)
        TweenService:Create(u65, u4, {
            BackgroundColor3 = ThemeController.GetColor(u67)
        }):Play();
        TweenService:Create(u66, u4, {
            Transparency = u69
        }):Play();
    end));
end;

local function setRowDimmed(p71, p72) -- Line: 548
    -- upvalues: u3 (copy)
    local label = p71:FindFirstChild("label");

    if label then
        label.TextTransparency = p72 and 0.55 or 0;
    end;

    local checkbox = p71:FindFirstChild("checkbox");

    if checkbox then
        local unchecked = checkbox:FindFirstChild("unchecked");
        local checked = checkbox:FindFirstChild("checked");

        if unchecked then
            unchecked.ImageColor3 = p72 and u3.TextMuted or u3.TextPrimary;
        end;

        if checked then
            checked.ImageColor3 = p72 and u3.TextMuted or u3.TextPrimary;
        end;
    end;
end;

local function schedulePreviewUpdate() -- Line: 565
    -- upvalues: u21 (ref), u22 (ref), u24 (ref), u25 (ref), buildRemovalSet (copy), applyRemovalsToDescription (copy)
    if not (u21 and u22) then
        return;
    end;

    u24 = u24 + 1;
    local u73 = u24;

    if u25 then
        pcall(task.cancel, u25);
        u25 = nil;
    end;

    u25 = task.spawn(function() -- Line: 573
        -- upvalues: u73 (copy), u24 (ref), u21 (ref), u22 (ref), buildRemovalSet (ref), applyRemovalsToDescription (ref)
        task.wait();

        if u73 ~= u24 then
            return;
        end;

        if not (u21 and u22) then
            return;
        end;

        local u74 = applyRemovalsToDescription(u22, (buildRemovalSet()));
        pcall(function() -- Line: 581
            -- upvalues: u21 (ref), u74 (copy)
            u21:Update(u74, {
                Quick = true,
                BypassIsApplied = true
            });
        end);
    end);
end;

local function recomputeAll() -- Line: 590
    -- upvalues: u9 (copy), u15 (ref)
    local v75 = true;

    for _, v in u9 do
        if v.key ~= "all" then
            local v76 = u15[v.key];

            if not v76.checked then
                v75 = false;
            end;

            if v.subs then
                for _, v2 in v.subs do
                    if not v76.subs[v2.key] then
                        v75 = false;
                        break;
                    end;
                end;

                if not v75 then
                    break;
                end;
            end;
        end;
    end;

    u15.all.checked = v75;
end;

local function refreshAllVisuals() -- Line: 608
    -- upvalues: u9 (copy), u16 (copy), setCheckboxVisual (copy), u15 (ref), TweenService (copy), u6 (copy), u17 (copy)
    for _, v in u9 do
        local v77 = u16[v.key];

        if v77 then
            setCheckboxVisual(v77, u15[v.key].checked);

            if v.subs then
                local expanded = u15[v.key].expanded;
                local chevron = v77:FindFirstChild("chevron");

                if chevron then
                    TweenService:Create(chevron, u6, {
                        Rotation = expanded and 180 or 0
                    }):Play();
                end;
            end;
        end;

        if v.subs then
            for _, v2 in v.subs do
                local v78 = u17[v.key .. ":" .. v2.key];

                if v78 then
                    setCheckboxVisual(v78, u15[v.key].subs[v2.key]);
                    v78.Visible = u15[v.key].expanded;
                end;
            end;
        end;
    end;
end;

local function onAllClick() -- Line: 632
    -- upvalues: u15 (ref), u9 (copy), refreshAllVisuals (copy), schedulePreviewUpdate (copy)
    local v79 = not u15.all.checked;
    u15.all.checked = v79;

    for _, v in u9 do
        if v.key ~= "all" then
            u15[v.key].checked = v79;

            if v.subs then
                for _, v2 in v.subs do
                    u15[v.key].subs[v2.key] = v79;
                end;
            end;
        end;
    end;

    refreshAllVisuals();
    schedulePreviewUpdate();
end;

local function onCategoryClick(p80) -- Line: 648
    -- upvalues: onAllClick (copy), u9 (copy), u15 (ref), recomputeAll (copy), refreshAllVisuals (copy), schedulePreviewUpdate (copy)
    if p80 == "all" then
        return onAllClick();
    end;

    for _, v in u9 do
        if v.key == p80 then
            break;
        end;
    end;

    if not v then
        return;
    end;

    local v81 = u15[p80];
    local v82 = not v81.checked;
    v81.checked = v82;

    if v.subs then
        for _, v in v.subs do
            v81.subs[v.key] = v82;
        end;
    end;

    recomputeAll();
    refreshAllVisuals();
    schedulePreviewUpdate();
end;

local function onSubClick(p83, p84) -- Line: 665
    -- upvalues: u15 (ref), recomputeAll (copy), refreshAllVisuals (copy), schedulePreviewUpdate (copy)
    local v85 = u15[p83];

    if not (v85 and v85.subs) then
        return;
    end;

    local v86 = not v85.subs[p84];
    v85.subs[p84] = v86;

    if v86 then
        v85.checked = true;
    end;

    recomputeAll();
    refreshAllVisuals();
    schedulePreviewUpdate();
end;

local function onChevronClick(p87) -- Line: 682
    -- upvalues: u15 (ref), refreshAllVisuals (copy)
    local v88 = u15[p87];

    if not v88 then
        return;
    end;

    v88.expanded = not v88.expanded;
    refreshAllVisuals();
end;

local function onApply() -- Line: 692
    -- upvalues: u9 (copy), u15 (ref), u18 (ref), Events (copy), Remotes (copy), u14 (copy)
    local u89 = {};
    local u90 = 0;
    local u91 = 0;

    for _, v in u9 do
        if v.key ~= "all" then
            local v92 = u15[v.key];
            local v93 = false;

            if v.subs then
                for _, v2 in v.subs do
                    if v92.subs[v2.key] then
                        for _, v3 in v2.assetTypes do
                            local v94 = u18[v3];

                            if v94 and #v94 > 0 then
                                local v95 = {
                                    AssetTypeName = v3,
                                    AssetIds = table.clone(v94)
                                };
                                table.insert(u89, v95);
                                u90 = u90 + #v94;
                                v93 = true;
                            end;
                        end;
                    end;
                end;
            elseif v92.checked then
                for _, v2 in v.assetTypes do
                    local v96 = u18[v2];

                    if v96 and #v96 > 0 then
                        local v97 = {
                            AssetTypeName = v2,
                            AssetIds = table.clone(v96)
                        };
                        table.insert(u89, v97);
                        u90 = u90 + #v96;
                        v93 = true;
                    end;
                end;
            end;

            if v93 then
                u91 = u91 + 1;
            end;
        end;
    end;

    if #u89 == 0 then
        Events.Notify:Fire("⚠️ Nothing to remove. Pick a category first.");

        return;
    end;

    task.spawn(function() -- Line: 741
        -- upvalues: Remotes (ref), u89 (copy), Events (ref), u90 (ref), u91 (ref)
        local success, result = pcall(Remotes.RemoveItemsBulk.InvokeServer, Remotes.RemoveItemsBulk, u89);

        if success then
            local v98 = typeof(result) == "number" and result and result or u90;

            if v98 > 0 then
                Events.Notify:Fire("✅ Removed <b>" .. tostring(v98) .. "</b> " .. (v98 == 1 and "item" or "items") .. " from <b>" .. tostring(u91) .. "</b> " .. (u91 == 1 and "category" or "categories") .. ".");
            end;

            return;
        end;

        warn("[RemoveItems] RemoveItemsBulk failed:", result);
        Events.Notify:Fire("❌ Couldn\'t remove items. Try again.");
    end);
    u14.Close();
end;

local categoryRow = script:WaitForChild("categoryRow");
local subCategoryRow = script:WaitForChild("subCategoryRow");

local function makeCategoryRow(u99) -- Line: 780
    -- upvalues: categoryRow (copy), u15 (ref), u19 (copy), refreshAllVisuals (copy), onCategoryClick (copy), wireRowHover (copy), u3 (copy), scroll (copy), u16 (copy)
    local v100 = categoryRow:Clone();
    v100.Name = u99.key;
    v100.LayoutOrder = u99.layoutOrder;
    local label = v100:FindFirstChild("label");

    if label then
        label.Text = u99.label;
    end;

    local chevron = v100:FindFirstChild("chevron");
    local chevronButton = v100:FindFirstChild("chevronButton");

    if u99.subs then
        if chevron then
            chevron.Rotation = u15[u99.key].expanded and 180 or 0;
        end;

        if chevronButton then
            table.insert(u19, chevronButton.Activated:Connect(function() -- Line: 796
                -- upvalues: u99 (copy), u15 (ref), refreshAllVisuals (ref)
                local v101 = u15[u99.key];

                if not v101 then
                    return;
                end;

                v101.expanded = not v101.expanded;
                refreshAllVisuals();
            end));
        end;
    else
        if chevron then
            chevron:Destroy();
        end;

        if chevronButton then
            chevronButton:Destroy();
        end;

        if label then
            label.Size = UDim2.fromScale(0.7, label.Size.Y.Scale);
        end;
    end;

    local checked = u15[u99.key].checked;
    local checkbox = v100:FindFirstChild("checkbox");
    local v102 = checkbox and checkbox:FindFirstChild("checked");

    if v102 then
        v102.ImageTransparency = checked and 0 or 1;
    end;

    local button = v100:FindFirstChild("button");

    if button then
        table.insert(u19, button.Activated:Connect(function() -- Line: 814
            -- upvalues: onCategoryClick (ref), u99 (copy)
            onCategoryClick(u99.key);
        end));
    end;

    local v103 = v100:FindFirstChildWhichIsA("UIStroke");

    if v103 then
        wireRowHover(v100, v103, u3.CardBackground, u3.HoverBackground, 0.4, 0.1);
    end;

    v100.Parent = scroll;
    u16[u99.key] = v100;

    return v100;
end;

local function makeSubRow(u104, u105, p106) -- Line: 829
    -- upvalues: subCategoryRow (copy), u15 (ref), u19 (copy), recomputeAll (copy), refreshAllVisuals (copy), schedulePreviewUpdate (copy), wireRowHover (copy), u3 (copy), scroll (copy), u17 (copy)
    local v107 = subCategoryRow:Clone();
    v107.Name = "sub_" .. u105.key;
    v107.LayoutOrder = p106;
    v107.Visible = u15[u104].expanded;
    local label = v107:FindFirstChild("label");

    if label then
        label.Text = u105.label;
    end;

    local v108 = u15[u104].subs[u105.key];
    local checkbox = v107:FindFirstChild("checkbox");
    local v109 = checkbox and checkbox:FindFirstChild("checked");

    if v109 then
        v109.ImageTransparency = v108 and 0 or 1;
    end;

    local button = v107:FindFirstChild("button");

    if button then
        table.insert(u19, button.Activated:Connect(function() -- Line: 842
            -- upvalues: u104 (copy), u105 (copy), u15 (ref), recomputeAll (ref), refreshAllVisuals (ref), schedulePreviewUpdate (ref)
            local key = u105.key;
            local v110 = u15[u104];

            if v110 then
                if not v110.subs then
                    return;
                end;

                local v111 = not v110.subs[key];
                v110.subs[key] = v111;

                if v111 then
                    v110.checked = true;
                end;

                recomputeAll();
                refreshAllVisuals();
                schedulePreviewUpdate();
            end;
        end));
    end;

    local v112 = v107:FindFirstChildWhichIsA("UIStroke");

    if v112 then
        wireRowHover(v107, v112, u3.SurfaceBackground, u3.HoverBackground, 0.65, 0.3);
    end;

    v107.Parent = scroll;
    u17[u104 .. ":" .. u105.key] = v107;

    return v107;
end;

local function buildRows() -- Line: 857
    -- upvalues: clearRows (copy), u9 (copy), makeCategoryRow (copy), makeSubRow (copy), u16 (copy), setRowDimmed (copy), categoryHasEquipped (copy)
    clearRows();

    for _, v in u9 do
        makeCategoryRow(v);

        if v.subs then
            for i, v2 in v.subs do
                makeSubRow(v.key, v2, v.layoutOrder + i);
            end;
        end;

        local v113 = u16[v.key];

        if v113 then
            setRowDimmed(v113, not categoryHasEquipped(v));
        end;
    end;
end;

local function refreshFromAvatar() -- Line: 876
    -- upvalues: LocalPlayer (copy), HumanoidDescriptionController (copy), u22 (ref), u23 (ref), u18 (ref), buildEquippedBuckets (copy), u9 (copy), u16 (copy), setRowDimmed (copy), categoryHasEquipped (copy), schedulePreviewUpdate (copy)
    local Character = LocalPlayer.Character;
    local v114;

    if Character then
        v114 = Character:FindFirstChildWhichIsA("Humanoid");
    else
        v114 = nil;
    end;

    local HumanoidDescription = HumanoidDescriptionController.HumanoidDescription;
    local v115;

    if HumanoidDescription or not v114 then
        v115 = HumanoidDescription;
    else
        local v116;
        v116, v115 = pcall(v114.GetAppliedDescription, v114);

        if not v116 then
            v115 = HumanoidDescription;
        end;
    end;

    if not v115 then
        return;
    end;

    u22 = v115;

    if v114 then
        u23 = v114.RigType;
    end;

    u18 = buildEquippedBuckets(v115, v114);

    for _, v in u9 do
        local v117 = u16[v.key];

        if v117 then
            setRowDimmed(v117, not categoryHasEquipped(v));
        end;
    end;

    schedulePreviewUpdate();
end;

function u14.Open(p118) -- Line: 909
    -- upvalues: u14 (copy), Events (copy), initState (copy), LocalPlayer (copy), u22 (ref), HumanoidDescriptionController (copy), u23 (ref), u18 (ref), buildEquippedBuckets (copy), buildRows (copy), refreshAllVisuals (copy), u1 (copy), RemoveItems (copy), container (copy), u7 (copy), u20 (copy), u21 (ref), AvatarPreviewController (copy), viewport (copy), schedulePreviewUpdate (copy), u19 (copy), refreshFromAvatar (copy), closeButton (copy), removeButton (copy), onApply (copy)
    if u14.IsOpen then
        if p118 then
            u14.Close();
        end;

        return;
    end;

    u14.IsOpen = true;
    Events.InterfaceAction:Fire("Add", script.Name, u14.Close);
    Events.SetButtonsVisible:Fire("All", { "resetAvatar", "saveOutfit", "currentlyWearing", "adjustAccessories" });
    initState();
    local Character = LocalPlayer.Character;
    local v119;

    if Character then
        v119 = Character:FindFirstChildWhichIsA("Humanoid");
    else
        v119 = nil;
    end;

    u22 = HumanoidDescriptionController.HumanoidDescription;

    if not u22 and v119 then
        local success, result = pcall(v119.GetAppliedDescription, v119);

        if success then
            u22 = result;
        end;
    end;

    if v119 then
        u23 = v119.RigType;
    end;

    u18 = buildEquippedBuckets(u22, v119);
    buildRows();
    refreshAllVisuals();
    u1:Reset();
    RemoveItems.Enabled = true;
    container.GroupTransparency = 1;
    u7:Play();
    table.insert(u20, task.spawn(function() -- Line: 948
        -- upvalues: u14 (ref), u21 (ref), AvatarPreviewController (ref), viewport (ref), u22 (ref), u23 (ref), schedulePreviewUpdate (ref)
        if not u14.IsOpen or u21 then
            return;
        end;

        local success, result = pcall(AvatarPreviewController.new, viewport, u22, {
            AllowCameraAdjustment = true,
            AllowAnimations = true,
            RigType = u23
        });

        if not success then
            warn("[RemoveItems] AvatarPreviewController.new failed:", result);

            return;
        end;

        u21 = result;
        schedulePreviewUpdate();
    end));
    table.insert(u19, HumanoidDescriptionController.OnHumanoidDescriptionUpdated:Connect(function() -- Line: 965
        -- upvalues: refreshFromAvatar (ref)
        refreshFromAvatar();
    end));
    table.insert(u19, closeButton.Activated:Connect(u14.Close));
    table.insert(u19, removeButton.Activated:Connect(onApply));
end;

function u14.Close(p120) -- Line: 973
    -- upvalues: u14 (copy), Events (copy), u21 (ref), u25 (ref), clearThreads (copy), clearConnections (copy), u8 (copy), RemoveItems (copy), clearRows (copy), u22 (ref), u23 (ref), u18 (ref)
    if not u14.IsOpen then
        return;
    end;

    u14.IsOpen = false;
    Events.InterfaceAction:Fire("Remove", script.Name);
    Events.SetButtonsVisible:Fire("All");

    if u21 then
        pcall(u21.Destroy, u21);
        u21 = nil;
    end;

    if u25 then
        pcall(task.cancel, u25);
        u25 = nil;
    end;

    clearThreads();
    clearConnections();
    u8:Play();
    u8.Completed:Once(function() -- Line: 999
        -- upvalues: u14 (ref), RemoveItems (ref), clearRows (ref), u22 (ref), u23 (ref), u18 (ref)
        if u14.IsOpen ~= true then
            RemoveItems.Enabled = false;
            clearRows();
            u22 = nil;
            u23 = nil;
            table.clear(u18);
        end;
    end);
end;

return u14;