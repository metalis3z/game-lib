-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local AvatarEditorService = game:GetService("AvatarEditorService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local CollectionService = game:GetService("CollectionService");
local Modules = require(script.Parent.Parent.Parent.Modules);
local ThemeController = require(Modules.Controllers.ThemeController);
local AvatarPreviewController = require(Modules.Controllers.AvatarPreviewController);
local LoadingController = require(Modules.Controllers.LoadingController);
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
local CatalogUtilities = require(Modules.Shared.CatalogUtilities);
local ItemButton = require(Modules.Elements.ItemButton);
local DialogController = require(Modules.Controllers.DialogController);
local Events = script.Parent.Parent.Parent:WaitForChild("Events");
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local GetBundleDetailsBatch = Remotes:WaitForChild("GetBundleDetailsBatch");
local _ = Players.LocalPlayer;
local CardBackground = ThemeController.BasePalette.CardBackground;
local SubtleStroke = ThemeController.BasePalette.SubtleStroke;
local ToggleBlue = ThemeController.BasePalette.ToggleBlue;
local TextHeading = ThemeController.BasePalette.TextHeading;
local _ = ThemeController.BasePalette.TextMuted;
local TextPrimary = ThemeController.BasePalette.TextPrimary;
local u1 = Color3.fromRGB(228, 228, 230);
local SurfaceBackground = ThemeController.BasePalette.SurfaceBackground;
local u2 = {};
local u3 = {};

for _, v in {} do
    u2[v] = true;
end;

local u4 = { "Head", "Torso", "LeftArm", "RightArm", "LeftLeg", "RightLeg" };
local u5 = {
    {
        Name = "Blocky Feminine",
        Head = 121501944270147,
        Torso = 4637265517,
        LeftArm = 0,
        RightArm = 0,
        LeftLeg = 0,
        RightLeg = 0,
        Rig = "R15",
        Scale = {
            HeightScale = 0.9,
            WidthScale = 0.7,
            DepthScale = 0.85,
            ProportionScale = 0,
            BodyTypeScale = 0,
            HeadScale = 1
        }
    },
    {
        Name = "Blocky",
        Head = 121501944270147,
        Torso = 0,
        LeftArm = 0,
        RightArm = 0,
        LeftLeg = 0,
        RightLeg = 0,
        Rig = "R15",
        Scale = {
            HeightScale = 1.05,
            WidthScale = 0.7,
            DepthScale = 0.85,
            ProportionScale = 0,
            BodyTypeScale = 0,
            HeadScale = 1
        }
    },
    {
        Name = "Woman Blocky Legs",
        Head = 121501944270147,
        Torso = 86499666,
        LeftArm = 86499716,
        RightArm = 86499698,
        LeftLeg = 0,
        RightLeg = 0,
        Rig = "R15",
        Scale = {
            HeightScale = 0.9,
            WidthScale = 0.7,
            DepthScale = 0.85,
            ProportionScale = 0,
            BodyTypeScale = 0,
            HeadScale = 1
        }
    },
    {
        Name = "Woman Blocky Legs 2",
        Head = 121501944270147,
        Torso = 129926733352688,
        LeftArm = 105495687771483,
        RightArm = 129676540898028,
        LeftLeg = 0,
        RightLeg = 0,
        Rig = "R15",
        Scale = {
            HeightScale = 0.9,
            WidthScale = 0.7,
            DepthScale = 0.85,
            ProportionScale = 0,
            BodyTypeScale = 0,
            HeadScale = 1
        }
    },
    {
        Name = "Muscular",
        Head = 121501944270147,
        Torso = 301824116,
        LeftArm = 4416785861,
        RightArm = 4416788553,
        LeftLeg = 75725078495853,
        RightLeg = 107877592888823,
        Rig = "R15",
        Scale = {
            HeightScale = 1.3,
            WidthScale = 1,
            DepthScale = 0.85,
            ProportionScale = 0,
            BodyTypeScale = 0,
            HeadScale = 1
        }
    },
    {
        Name = "Feminine",
        Head = 121501944270147,
        Torso = 72919567447323,
        LeftArm = 79802314658560,
        RightArm = 116709088390166,
        LeftLeg = 70380761114055,
        RightLeg = 70582373853805,
        Rig = "R15",
        Scale = {
            HeightScale = 0.9,
            WidthScale = 0.7,
            DepthScale = 0.85,
            ProportionScale = 0,
            BodyTypeScale = 0,
            HeadScale = 1
        }
    },
    {
        Name = "Feminine 2",
        Head = 121501944270147,
        Torso = 129543160215232,
        LeftArm = 73001997018020,
        RightArm = 133466157082146,
        LeftLeg = 121515016872144,
        RightLeg = 96815508293389,
        Rig = "R15",
        Scale = {
            HeightScale = 1.3,
            WidthScale = 1.05,
            DepthScale = 0.85,
            ProportionScale = 0,
            BodyTypeScale = 0,
            HeadScale = 1
        }
    },
    {
        Name = "Feminine 3",
        Head = 121501944270147,
        Torso = 114607383398503,
        LeftArm = 132179793557248,
        RightArm = 116063189738050,
        LeftLeg = 101521138059051,
        RightLeg = 127968751428204,
        Rig = "R15",
        Scale = {
            HeightScale = 1.3,
            WidthScale = 0.85,
            DepthScale = 0.85,
            ProportionScale = 0,
            BodyTypeScale = 0,
            HeadScale = 1
        }
    },
    {
        Name = "Plushy",
        Head = 121501944270147,
        Torso = 80898764350971,
        LeftArm = 78737073847916,
        RightArm = 91173820172552,
        LeftLeg = 108722282515773,
        RightLeg = 81522900719668,
        Rig = "R15",
        Scale = {
            HeightScale = 0.9,
            WidthScale = 0.7,
            DepthScale = 0.85,
            ProportionScale = 0,
            BodyTypeScale = 0,
            HeadScale = 1
        }
    },
    {
        Name = "Goober",
        Head = 121501944270147,
        Torso = 131332113668219,
        LeftArm = 79548345366568,
        RightArm = 106410726383900,
        LeftLeg = 112443443823823,
        RightLeg = 127522625177060,
        Rig = "R15",
        Scale = {
            HeightScale = 0.9,
            WidthScale = 0.7,
            DepthScale = 0.85,
            ProportionScale = 0,
            BodyTypeScale = 0,
            HeadScale = 1
        }
    },
    {
        Name = "Wii Mii",
        Head = 121501944270147,
        Torso = 132614416853621,
        LeftArm = 118405831535176,
        RightArm = 81723815972342,
        LeftLeg = 125281729451742,
        RightLeg = 88245139321829,
        Rig = "R15",
        Scale = {
            HeightScale = 0.9,
            WidthScale = 0.7,
            DepthScale = 0.85,
            ProportionScale = 0,
            BodyTypeScale = 0,
            HeadScale = 1
        }
    }
};
local v6 = {};

local function ensureTemplate() -- Line: 96
    -- upvalues: CardBackground (copy), TextHeading (copy), CollectionService (copy)
    local bodyTile = script:FindFirstChild("bodyTile");

    if bodyTile then
        return bodyTile;
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "bodyTile";
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.ClipsDescendants = false;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "preview";
    Frame2.AnchorPoint = Vector2.new(0.5, 0);
    Frame2.Position = UDim2.fromScale(0.5, 0);
    Frame2.Size = UDim2.fromScale(1, 0.88);
    Frame2.BackgroundColor3 = CardBackground;
    Frame2.BorderSizePixel = 0;
    Frame2.ClipsDescendants = true;
    Frame2.Parent = Frame;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0.05, 0);
    UICorner.Parent = Frame2;
    local ViewportFrame = Instance.new("ViewportFrame");
    ViewportFrame.Name = "viewport";
    ViewportFrame.AnchorPoint = Vector2.new(0.5, 0.5);
    ViewportFrame.Position = UDim2.fromScale(0.5, 0.5);
    ViewportFrame.Size = UDim2.fromScale(1, 1);
    ViewportFrame.BackgroundTransparency = 1;
    ViewportFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    ViewportFrame.Ambient = Color3.fromRGB(202, 202, 202);
    ViewportFrame.LightColor = Color3.fromRGB(221, 221, 221);
    ViewportFrame.LightDirection = Vector3.new(0.5, -1, 0.5);
    ViewportFrame.ImageColor3 = Color3.fromRGB(255, 255, 255);
    ViewportFrame.ImageTransparency = 1;
    ViewportFrame.BorderSizePixel = 0;
    ViewportFrame.ClipsDescendants = false;
    ViewportFrame.Parent = Frame2;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "name";
    TextLabel.AnchorPoint = Vector2.new(0, 1);
    TextLabel.Position = UDim2.fromScale(0.01, 1);
    TextLabel.Size = UDim2.new(0.95, 0, 0.1, 0);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold);
    TextLabel.Text = "";
    TextLabel.TextColor3 = TextHeading;
    TextLabel.TextScaled = true;
    TextLabel.TextWrapped = true;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.TextYAlignment = Enum.TextYAlignment.Center;
    TextLabel.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel.LineHeight = 1;
    TextLabel.BorderSizePixel = 0;
    TextLabel.Parent = Frame;
    local TextButton = Instance.new("TextButton");
    TextButton.Name = "click";
    TextButton.Size = UDim2.fromScale(1, 1);
    TextButton.BackgroundTransparency = 1;
    TextButton.Text = "";
    TextButton.AutoButtonColor = false;
    TextButton.Style = Enum.ButtonStyle.Custom;
    TextButton.ZIndex = 10;
    TextButton.Parent = Frame;
    CollectionService:AddTag(TextButton, "UIEffectSoundOnly");
    Frame.Parent = script;

    return Frame;
end;

local u7 = { "HeightScale", "WidthScale", "DepthScale", "ProportionScale", "BodyTypeScale", "HeadScale" };

local function buildBodyDescription(p8, p9, p10, p11) -- Line: 171
    -- upvalues: u7 (copy), u1 (copy)
    local HumanoidDescription = Instance.new("HumanoidDescription");

    for i, v in p8 do
        pcall(function() -- Line: 174
            -- upvalues: HumanoidDescription (copy), i (copy), v (copy)
            HumanoidDescription[i] = v;
        end);
    end;

    if typeof(p11) == "table" then
        for _, v in u7 do
            local u12 = p11[v];

            if typeof(u12) == "number" then
                pcall(function() -- Line: 180
                    -- upvalues: HumanoidDescription (copy), v (copy), u12 (copy)
                    HumanoidDescription[v] = u12;
                end);
            end;
        end;
    end;

    if p9 then
        pcall(function() -- Line: 184
            -- upvalues: HumanoidDescription (copy)
            HumanoidDescription.RightLeg = 139607718;
        end);
    end;

    if p10 then
        pcall(function() -- Line: 185
            -- upvalues: HumanoidDescription (copy)
            HumanoidDescription.Head = 15093053680;
        end);
    end;

    HumanoidDescription.Shirt = 855760101;
    HumanoidDescription.Pants = 855780360;
    HumanoidDescription.HeadColor = u1;
    HumanoidDescription.TorsoColor = u1;
    HumanoidDescription.LeftArmColor = u1;
    HumanoidDescription.RightArmColor = u1;
    HumanoidDescription.LeftLegColor = u1;
    HumanoidDescription.RightLegColor = u1;

    return HumanoidDescription;
end;

local function setTileSelected(p13, p14) -- Line: 199
    -- upvalues: ToggleBlue (copy)
    local preview = p13:FindFirstChild("preview");

    if not preview then
        return;
    end;

    local v15 = preview:FindFirstChildWhichIsA("UIStroke");

    if not p14 then
        if v15 then
            v15:Destroy();
        end;

        return;
    end;

    if not v15 then
        v15 = Instance.new("UIStroke");
        v15.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        v15.BorderStrokePosition = Enum.BorderStrokePosition.Outer;
        v15.LineJoinMode = Enum.LineJoinMode.Round;
        v15.StrokeSizingMode = Enum.StrokeSizingMode.FixedSize;
        v15.Parent = preview;
    end;

    v15.Color = ToggleBlue;
    v15.Thickness = 2.5;
    v15.Transparency = 0;
end;

function v6.Open(u16, u17, u18, u19, u20, u21) -- Line: 220
    -- upvalues: ensureTemplate (copy), CollectionService (copy), HumanoidDescriptionController (copy), u4 (copy), buildBodyDescription (copy), setTileSelected (copy), AvatarPreviewController (copy), TweenService (copy), CatalogUtilities (copy), GetBundleDetailsBatch (copy), u2 (copy), LoadingController (copy), AvatarEditorService (copy), Remotes (copy), Events (copy), TextPrimary (copy), CardBackground (copy), DialogController (copy), ItemButton (copy), TextHeading (copy), u5 (copy), u3 (copy), SurfaceBackground (copy), SubtleStroke (copy), ToggleBlue (copy)
    local u22 = ensureTemplate();
    local u23 = {};
    local u24 = {};
    local u25 = {};
    local u26 = {};
    local u27 = true;
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Name = "scroll";
    ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0.5);
    ScrollingFrame.Position = UDim2.fromScale(0.5, 0.5);
    ScrollingFrame.Size = UDim2.fromScale(1, 1);
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.ClipsDescendants = true;
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame.CanvasSize = UDim2.new();
    ScrollingFrame.ScrollBarThickness = 3;
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255);
    ScrollingFrame.ScrollBarImageTransparency = 0;
    ScrollingFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right;
    ScrollingFrame.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable;
    ScrollingFrame.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png";
    ScrollingFrame.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png";
    ScrollingFrame.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png";
    ScrollingFrame.Parent = u16;
    CollectionService:AddTag(ScrollingFrame, "ScrollingFrameAutomaticSizeFix");
    local UIGridLayout = Instance.new("UIGridLayout");
    UIGridLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIGridLayout.StartCorner = Enum.StartCorner.TopLeft;
    UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
    UIGridLayout.VerticalAlignment = Enum.VerticalAlignment.Top;
    UIGridLayout.FillDirectionMaxCells = 4;
    UIGridLayout.CellSize = UDim2.new(0.25, -8, 1, 0);
    UIGridLayout.CellPadding = UDim2.new(0, 8, 0, 12);
    UIGridLayout.Parent = ScrollingFrame;
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint.AspectRatio = 0.78;
    UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Width;
    UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize;
    UIAspectRatioConstraint.Parent = UIGridLayout;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingTop = UDim.new(0, 4);
    UIPadding.PaddingBottom = UDim.new(0.14, 0);
    UIPadding.PaddingLeft = UDim.new(0, 4);
    UIPadding.PaddingRight = UDim.new(0, 4);
    UIPadding.Parent = ScrollingFrame;
    local u28 = nil;
    local v29 = HumanoidDescriptionController.GetHumanoid();
    local u30 = v29 and v29.RigType or Enum.HumanoidRigType.R15;
    local v31 = HumanoidDescriptionController.GetCurrentDescription();
    local u32 = {};

    if v31 then
        for _, v in u4 do
            u32[v] = v31[v];
        end;
    end;

    local u33 = { "HeightScale", "WidthScale", "DepthScale", "ProportionScale", "BodyTypeScale", "HeadScale" };
    local u34 = {
        HeightScale = 1,
        WidthScale = 1,
        DepthScale = 1,
        ProportionScale = 0,
        BodyTypeScale = 0,
        HeadScale = 1
    };
    local v35 = {};

    if v31 then
        for _, v in u33 do
            local v36 = v31[v];

            if typeof(v36) == "number" then
                v35[v] = v36;
            end;
        end;
    end;

    u20.scaleById = u20.scaleById or {};
    u20.scaleById.currentBody = v35;

    if u18.Scale == nil then
        u18.Scale = table.clone(v35);
    end;

    local v37 = u30 == Enum.HumanoidRigType.R6 and "R6" or "R15";
    u20.rigById = u20.rigById or {};
    u20.rigById.currentBody = v37;

    if u18.RigType == nil then
        u18.RigType = v37;
    end;

    local u38;

    if u18.BodyBundleId and (u20.bodyPartsById and u20.bodyPartsById[u18.BodyBundleId]) then
        u38 = u20.bodyPartsById[u18.BodyBundleId];
    else
        u38 = u32;
    end;

    local u39 = u18.KorbloxLeg == true;
    local u40 = u18.HeadlessHead == true;
    u18.BodyHeadId = u38.Head or u32.Head;

    local function resolvePart(p41) -- Line: 334
        -- upvalues: u39 (ref), u40 (ref), u38 (ref), u32 (copy)
        if u39 and p41 == "RightLeg" then
            return 139607718;
        end;

        if u40 and p41 == "Head" then
            return 15093053680;
        end;

        local v42 = u38[p41];

        if v42 ~= nil then
            return v42;
        end;

        if p41 == "Head" and u38 ~= u32 then
            return 0;
        end;

        local v43 = u32[p41];

        return p41 == "Head" and v43 == 15093053680 and 0 or (p41 == "RightLeg" and v43 == 139607718 and 0 or v43);
    end;

    local function applyBodyToDraft(p44) -- Line: 354
        -- upvalues: u17 (copy), u18 (copy), u38 (ref), u32 (copy), u4 (ref), u40 (ref), u39 (ref), u21 (copy)
        if not u17 then
            return;
        end;

        u18.BodyHeadId = u38.Head or u32.Head;

        for _, v in u4 do
            local u45;

            if v == "Head" and (u18.HeadId ~= nil and not u40) then
                u45 = u18.HeadAssetId;

                if not u45 then
                    if u39 and v == "RightLeg" then
                        u45 = 139607718;
                    elseif u40 and v == "Head" then
                        u45 = 15093053680;
                    else
                        u45 = u38[v];

                        if u45 == nil then
                            if v == "Head" and u38 ~= u32 then
                                u45 = 0;
                            else
                                local v46 = u32[v];
                                u45 = v == "Head" and v46 == 15093053680 and 0 or (v == "RightLeg" and v46 == 139607718 and 0 or v46);
                            end;
                        end;
                    end;
                end;
            elseif u39 and v == "RightLeg" then
                u45 = 139607718;
            elseif u40 and v == "Head" then
                u45 = 15093053680;
            else
                u45 = u38[v];

                if u45 == nil then
                    if v == "Head" and u38 ~= u32 then
                        u45 = 0;
                    else
                        local v47 = u32[v];
                        u45 = v == "Head" and v47 == 15093053680 and 0 or (v == "RightLeg" and v47 == 139607718 and 0 or v47);
                    end;
                end;
            end;

            if u45 ~= nil then
                pcall(function() -- Line: 368
                    -- upvalues: u17 (ref), v (copy), u45 (ref)
                    u17[v] = u45;
                end);
            end;
        end;

        u21(p44);
    end;

    local u48 = nil;

    local function applyEntryDesc(u49) -- Line: 382
        -- upvalues: buildBodyDescription (ref), u39 (ref), u40 (ref)
        u49.dirty = false;
        pcall(function() -- Line: 384
            -- upvalues: u49 (copy), buildBodyDescription (ref), u39 (ref), u40 (ref)
            u49.preview:Update(buildBodyDescription(u49.bodyParts, u39, u40), {
                BypassIsApplied = true,
                Quick = true
            });
        end);
    end;

    local function applyEntryThreaded(u50) -- Line: 391
        -- upvalues: u24 (copy), u27 (ref), buildBodyDescription (ref), u39 (ref), u40 (ref)
        table.insert(u24, task.spawn(function() -- Line: 392
            -- upvalues: u27 (ref), u50 (copy), buildBodyDescription (ref), u39 (ref), u40 (ref)
            if u27 then
                local u51 = u50;
                u51.dirty = false;
                pcall(function() -- Line: 384
                    -- upvalues: u51 (copy), buildBodyDescription (ref), u39 (ref), u40 (ref)
                    u51.preview:Update(buildBodyDescription(u51.bodyParts, u39, u40), {
                        BypassIsApplied = true,
                        Quick = true
                    });
                end);
            end;
        end));
    end;

    local function refreshTilePreviews() -- Line: 399
        -- upvalues: u26 (copy), u48 (ref), u24 (copy), u27 (ref), buildBodyDescription (ref), u39 (ref), u40 (ref)
        for _, v in u26 do
            if v.tile and (v.tile.Parent and u48(v.tile)) then
                table.insert(u24, task.spawn(function() -- Line: 392
                    -- upvalues: u27 (ref), v (copy), buildBodyDescription (ref), u39 (ref), u40 (ref)
                    if u27 then
                        local u52 = v;
                        u52.dirty = false;
                        pcall(function() -- Line: 384
                            -- upvalues: u52 (copy), buildBodyDescription (ref), u39 (ref), u40 (ref)
                            u52.preview:Update(buildBodyDescription(u52.bodyParts, u39, u40), {
                                BypassIsApplied = true,
                                Quick = true
                            });
                        end);
                    end;
                end));
            else
                v.dirty = true;
            end;
        end;
    end;

    local function selectTile(p53, p54, p55) -- Line: 409
        -- upvalues: u28 (ref), setTileSelected (ref), u20 (copy), u18 (copy), u38 (ref), u17 (copy), u33 (copy), u34 (copy), u19 (copy), applyBodyToDraft (copy)
        if u28 == p53 then
            return;
        end;

        if u28 then
            local preview = u28:FindFirstChild("preview");
            local v56 = preview and preview:FindFirstChildWhichIsA("UIStroke");

            if v56 then
                v56:Destroy();
            end;
        end;

        setTileSelected(p53, true);
        u28 = p53;
        u20.selectedId = p55;
        u18.BodyBundleId = typeof(p55) == "number" and p55 and p55 or nil;
        local v57;

        if typeof(p55) == "string" and (p55 ~= "currentBody" and p54) then
            v57 = p54;
        else
            v57 = nil;
        end;

        u18.BodyParts = v57;

        if p54 then
            u38 = p54;
        end;

        local v58 = u20.scaleById and u20.scaleById[p55];
        u18.Scale = v58 and table.clone(v58) or {};

        if u17 then
            for _, v in u33 do
                local u59 = u18.Scale[v];

                if typeof(u59) ~= "number" then
                    u59 = u34[v];
                end;

                pcall(function() -- Line: 429
                    -- upvalues: u17 (ref), v (copy), u59 (ref)
                    u17[v] = u59;
                end);
            end;
        end;

        local v60 = u20.rigById and u20.rigById[p55] or "R15";
        local v61 = u18.RigType ~= v60;
        u18.RigType = v60;

        if u19 and u19.Options then
            u19.Options.RigType = v60 == "R6" and Enum.HumanoidRigType.R6 or Enum.HumanoidRigType.R15;
        end;

        applyBodyToDraft(v61 and {
            Reset = true
        } or nil);
    end;

    local u62 = u22:Clone();
    u62.Name = "currentBody";
    u62.LayoutOrder = 1;
    u62.name.Text = "Current Body";
    u62.Parent = ScrollingFrame;
    local v63 = buildBodyDescription(u32, u39, u40, v35);
    local u64 = AvatarPreviewController.new(u62.preview.viewport, v63, {
        AllowAnimations = false,
        IsOutfitPreview = true,
        IsMarqueePreview = true,
        Distance = 2,
        Context = "CreateAvatarCurrentBody",
        RigType = u30
    });
    table.insert(u25, u64);
    table.insert(u26, {
        preview = u64,
        bodyParts = u32,
        tile = u62
    });
    table.insert(u24, task.spawn(function() -- Line: 467
        -- upvalues: u64 (copy), u27 (ref), u62 (copy), TweenService (ref), u23 (copy)
        u64:GetRig();

        if not (u27 and u62.Parent) then
            return;
        end;

        TweenService:Create(u62.preview.viewport, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ImageTransparency = 0
        }):Play();
        table.insert(u23, u62.click.MouseEnter:Connect(function() -- Line: 473
            -- upvalues: u64 (ref)
            pcall(function() -- Line: 474
                -- upvalues: u64 (ref)
                u64:StartRotation(-0.75);
            end);
        end));
        table.insert(u23, u62.click.MouseLeave:Connect(function() -- Line: 476
            -- upvalues: u64 (ref)
            pcall(function() -- Line: 477
                -- upvalues: u64 (ref)
                u64:ResetRotation();
            end);
        end));
    end));
    table.insert(u23, u62.click.Activated:Connect(function() -- Line: 481
        -- upvalues: selectTile (copy), u62 (copy), u32 (copy)
        selectTile(u62, u32, "currentBody");
    end));
    local pages = u20.pages;
    local u65 = {};
    local u66 = 1000;
    u20.bodyPartsById = u20.bodyPartsById or {};
    local u67 = {};

    local function buildTilePreview(u68, u69, u70) -- Line: 501
        -- upvalues: u24 (copy), u27 (ref), u20 (copy), buildBodyDescription (ref), u39 (ref), u40 (ref), AvatarPreviewController (ref), u25 (copy), u26 (copy), TweenService (ref), u23 (copy)
        table.insert(u24, task.spawn(function() -- Line: 502
            -- upvalues: u27 (ref), u68 (copy), u20 (ref), u69 (copy), buildBodyDescription (ref), u70 (copy), u39 (ref), u40 (ref), AvatarPreviewController (ref), u25 (ref), u26 (ref), TweenService (ref), u23 (ref)
            if not (u27 and u68.Parent) then
                return;
            end;

            local v71 = buildBodyDescription(u70, u39, u40, u20.scaleById and u20.scaleById[u69.Id]);
            local u72 = AvatarPreviewController.new(u68.preview.viewport, v71, {
                AllowAnimations = false,
                IsOutfitPreview = true,
                IsMarqueePreview = true,
                Distance = 2,
                RigType = Enum.HumanoidRigType.R15,
                Context = "CreateAvatarBody:" .. tostring(u69.Id)
            });
            table.insert(u25, u72);
            table.insert(u26, {
                preview = u72,
                bodyParts = u70,
                tile = u68
            });
            u72:GetRig();

            if not (u27 and u68.Parent) then
                return;
            end;

            TweenService:Create(u68.preview.viewport, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                ImageTransparency = 0
            }):Play();
            table.insert(u23, u68.click.MouseEnter:Connect(function() -- Line: 521
                -- upvalues: u72 (copy)
                pcall(function() -- Line: 522
                    -- upvalues: u72 (ref)
                    u72:StartRotation(-0.75);
                end);
            end));
            table.insert(u23, u68.click.MouseLeave:Connect(function() -- Line: 524
                -- upvalues: u72 (copy)
                pcall(function() -- Line: 525
                    -- upvalues: u72 (ref)
                    u72:ResetRotation();
                end);
            end));
        end));
    end;

    local function mapBodyParts(p73) -- Line: 531
        -- upvalues: CatalogUtilities (ref)
        local v74 = {};

        for _, v in p73 do
            if CatalogUtilities.BodyParts[v.AssetTypeName] then
                v74[v.AssetTypeName] = v.AssetId;
            end;
        end;

        return v74;
    end;

    u48 = function(p75) -- Line: 542, Name: isTileNearViewport
        -- upvalues: ScrollingFrame (copy)
        if not p75.Parent then
            return false;
        end;

        local Y = ScrollingFrame.AbsoluteWindowSize.Y;

        if Y <= 0 then
            return false;
        end;

        local v76 = p75.AbsolutePosition.Y - ScrollingFrame.AbsolutePosition.Y;
        local v77;

        if v76 + p75.AbsoluteSize.Y >= -Y then
            v77 = v76 <= Y + Y;
        else
            v77 = false;
        end;

        return v77;
    end;

    local function loadVisibleTiles() -- Line: 553
        -- upvalues: u27 (ref), u26 (copy), u48 (ref), u24 (copy), buildBodyDescription (ref), u39 (ref), u40 (ref), u67 (copy), u20 (copy), AvatarPreviewController (ref), u25 (copy), TweenService (ref), u23 (copy), GetBundleDetailsBatch (ref), mapBodyParts (copy)
        if not u27 then
            return;
        end;

        for _, v in u26 do
            if v.dirty and (v.tile and (v.tile.Parent and u48(v.tile))) then
                table.insert(u24, task.spawn(function() -- Line: 392
                    -- upvalues: u27 (ref), v (copy), buildBodyDescription (ref), u39 (ref), u40 (ref)
                    if u27 then
                        local u78 = v;
                        u78.dirty = false;
                        pcall(function() -- Line: 384
                            -- upvalues: u78 (copy), buildBodyDescription (ref), u39 (ref), u40 (ref)
                            u78.preview:Update(buildBodyDescription(u78.bodyParts, u39, u40), {
                                BypassIsApplied = true,
                                Quick = true
                            });
                        end);
                    end;
                end));
            end;
        end;

        local u79 = {};

        for _, v in u67 do
            if not v.loaded and (v.tile.Parent and u48(v.tile)) then
                v.loaded = true;
                local u80 = u20.bodyPartsById[v.item.Id];

                if u80 then
                    local tile = v.tile;
                    local item = v.item;
                    table.insert(u24, task.spawn(function() -- Line: 502
                        -- upvalues: u27 (ref), tile (copy), u20 (ref), item (copy), buildBodyDescription (ref), u80 (copy), u39 (ref), u40 (ref), AvatarPreviewController (ref), u25 (ref), u26 (ref), TweenService (ref), u23 (ref)
                        if not (u27 and tile.Parent) then
                            return;
                        end;

                        local v81 = buildBodyDescription(u80, u39, u40, u20.scaleById and u20.scaleById[item.Id]);
                        local u82 = AvatarPreviewController.new(tile.preview.viewport, v81, {
                            AllowAnimations = false,
                            IsOutfitPreview = true,
                            IsMarqueePreview = true,
                            Distance = 2,
                            RigType = Enum.HumanoidRigType.R15,
                            Context = "CreateAvatarBody:" .. tostring(item.Id)
                        });
                        table.insert(u25, u82);
                        table.insert(u26, {
                            preview = u82,
                            bodyParts = u80,
                            tile = tile
                        });
                        u82:GetRig();

                        if not (u27 and tile.Parent) then
                            return;
                        end;

                        TweenService:Create(tile.preview.viewport, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            ImageTransparency = 0
                        }):Play();
                        table.insert(u23, tile.click.MouseEnter:Connect(function() -- Line: 521
                            -- upvalues: u82 (copy)
                            pcall(function() -- Line: 522
                                -- upvalues: u82 (ref)
                                u82:StartRotation(-0.75);
                            end);
                        end));
                        table.insert(u23, tile.click.MouseLeave:Connect(function() -- Line: 524
                            -- upvalues: u82 (copy)
                            pcall(function() -- Line: 525
                                -- upvalues: u82 (ref)
                                u82:ResetRotation();
                            end);
                        end));
                    end));
                else
                    table.insert(u79, v);
                end;
            end;
        end;

        if #u79 == 0 then
            return;
        end;

        local u83 = {};

        for _, v in u79 do
            table.insert(u83, v.item.Id);
        end;

        table.insert(u24, task.spawn(function() -- Line: 577
            -- upvalues: GetBundleDetailsBatch (ref), u83 (copy), u27 (ref), u79 (copy), mapBodyParts (ref), u20 (ref), u24 (ref), buildBodyDescription (ref), u39 (ref), u40 (ref), AvatarPreviewController (ref), u25 (ref), u26 (ref), TweenService (ref), u23 (ref)
            local v84, v85, v86 = pcall(function() -- Line: 578
                -- upvalues: GetBundleDetailsBatch (ref), u83 (ref)
                return GetBundleDetailsBatch:InvokeServer(u83);
            end);

            if not u27 then
                return;
            end;

            if not v84 or (not v85 or typeof(v86) ~= "table") then
                warn("[BodyStage] batch bundle fetch failed:", v84, v85, (typeof(v86)));

                for _, v in u79 do
                    v.loaded = false;
                end;

                return;
            end;

            local v87 = {};

            for _, v in v86 do
                v87[v.Id] = v;
            end;

            for _, v in u79 do
                local v88 = v87[v.item.Id];

                if v88 and (v88.Items and v.tile.Parent) then
                    local u89 = mapBodyParts(v88.Items);
                    u20.bodyPartsById[v.item.Id] = u89;

                    if v.tile.name.Text == "" and v88.Name then
                        v.tile.name.Text = v88.Name;
                    end;

                    local tile = v.tile;
                    local item = v.item;
                    table.insert(u24, task.spawn(function() -- Line: 502
                        -- upvalues: u27 (ref), tile (copy), u20 (ref), item (copy), buildBodyDescription (ref), u89 (copy), u39 (ref), u40 (ref), AvatarPreviewController (ref), u25 (ref), u26 (ref), TweenService (ref), u23 (ref)
                        if not (u27 and tile.Parent) then
                            return;
                        end;

                        local v90 = buildBodyDescription(u89, u39, u40, u20.scaleById and u20.scaleById[item.Id]);
                        local u91 = AvatarPreviewController.new(tile.preview.viewport, v90, {
                            AllowAnimations = false,
                            IsOutfitPreview = true,
                            IsMarqueePreview = true,
                            Distance = 2,
                            RigType = Enum.HumanoidRigType.R15,
                            Context = "CreateAvatarBody:" .. tostring(item.Id)
                        });
                        table.insert(u25, u91);
                        table.insert(u26, {
                            preview = u91,
                            bodyParts = u89,
                            tile = tile
                        });
                        u91:GetRig();

                        if not (u27 and tile.Parent) then
                            return;
                        end;

                        TweenService:Create(tile.preview.viewport, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            ImageTransparency = 0
                        }):Play();
                        table.insert(u23, tile.click.MouseEnter:Connect(function() -- Line: 521
                            -- upvalues: u91 (copy)
                            pcall(function() -- Line: 522
                                -- upvalues: u91 (ref)
                                u91:StartRotation(-0.75);
                            end);
                        end));
                        table.insert(u23, tile.click.MouseLeave:Connect(function() -- Line: 524
                            -- upvalues: u91 (copy)
                            pcall(function() -- Line: 525
                                -- upvalues: u91 (ref)
                                u91:ResetRotation();
                            end);
                        end));
                    end));
                end;
            end;
        end));
    end;

    local u92 = false;

    local function scheduleLoadVisible() -- Line: 604
        -- upvalues: u92 (ref), u27 (ref), loadVisibleTiles (copy)
        if u92 or not u27 then
            return;
        end;

        u92 = true;
        task.delay(0.1, function() -- Line: 607
            -- upvalues: u92 (ref), u27 (ref), loadVisibleTiles (ref)
            u92 = false;

            if u27 then
                loadVisibleTiles();
            end;
        end);
    end;

    local function loadVisibleSoon() -- Line: 614
        -- upvalues: u24 (copy), u27 (ref), ScrollingFrame (copy), loadVisibleTiles (copy)
        table.insert(u24, task.spawn(function() -- Line: 615
            -- upvalues: u27 (ref), ScrollingFrame (ref), loadVisibleTiles (ref)
            for _ = 1, 6 do
                task.wait();

                if not u27 then
                    return;
                end;

                if ScrollingFrame.AbsoluteWindowSize.Y > 0 then
                    break;
                end;
            end;

            if u27 then
                loadVisibleTiles();
            end;
        end));
    end;

    local function renderItem(u93, p94) -- Line: 625
        -- upvalues: u27 (ref), u2 (ref), u65 (copy), u66 (ref), u22 (copy), ScrollingFrame (copy), u20 (copy), setTileSelected (ref), u28 (ref), u23 (copy), selectTile (copy), u67 (copy)
        if not u27 then
            return;
        end;

        if u2[u93.Id] then
            return;
        end;

        if not u65[u93.Id] then
            u65[u93.Id] = true;

            if not p94 then
                u66 = u66 + 1;
                p94 = u66;
            end;

            local u95 = u22:Clone();
            u95.Name = tostring(u93.Id);
            u95.LayoutOrder = p94;
            u95.name.Text = u93.Name or "";
            u95.Parent = ScrollingFrame;

            if u20.selectedId == u93.Id then
                setTileSelected(u95, true);
                u28 = u95;
            end;

            table.insert(u23, u95.click.Activated:Connect(function() -- Line: 648
                -- upvalues: u95 (copy), selectTile (ref), u20 (ref), u93 (copy)
                if u95:GetAttribute("suppressActivate") then
                    u95:SetAttribute("suppressActivate", false);

                    return;
                end;

                selectTile(u95, u20.bodyPartsById[u93.Id], u93.Id);
            end));
            table.insert(u67, {
                loaded = false,
                tile = u95,
                item = u93
            });

            return u95;
        end;
    end;

    local function renderItems(p96) -- Line: 658
        -- upvalues: renderItem (copy)
        for _, v in p96 do
            renderItem(v);
        end;
    end;

    local function startNewSearch() -- Line: 664
        -- upvalues: LoadingController (ref), u16 (copy), u24 (copy), AvatarEditorService (ref), u27 (ref), pages (ref), u20 (copy), renderItem (copy), ScrollingFrame (copy), loadVisibleTiles (copy)
        LoadingController.DisplayLoading(u16, "overlay");
        table.insert(u24, task.spawn(function() -- Line: 666
            -- upvalues: AvatarEditorService (ref), u27 (ref), LoadingController (ref), u16 (ref), pages (ref), u20 (ref), renderItem (ref), u24 (ref), ScrollingFrame (ref), loadVisibleTiles (ref)
            local u97 = CatalogSearchParams.new();
            u97.BundleTypes = { Enum.BundleType.BodyParts };
            u97.Limit = 60;
            u97.SortType = Enum.CatalogSortType.MostFavorited;
            u97.IncludeOffSale = false;
            u97.SalesTypeFilter = Enum.SalesTypeFilter.All;
            local success, result = pcall(function() -- Line: 674
                -- upvalues: AvatarEditorService (ref), u97 (copy)
                return AvatarEditorService:SearchCatalog(u97);
            end);

            if not u27 then
                LoadingController.RemoveLoading();

                return;
            end;

            if not success or typeof(result) ~= "Instance" then
                LoadingController.RemoveLoading();
                LoadingController.DisplayGraphic(u16, "createAvatar", "noResults");

                return;
            end;

            pages = result;
            u20.pages = pages;
            local success2, result2 = pcall(function() -- Line: 688
                -- upvalues: pages (ref)
                return pages:GetCurrentPage();
            end);
            LoadingController.RemoveLoading();

            if not u27 then
                return;
            end;

            if not success2 or typeof(result2) ~= "table" then
                LoadingController.DisplayGraphic(u16, "createAvatar", "noResults");

                return;
            end;

            u20.items = u20.items or {};

            for _, v in result2 do
                table.insert(u20.items, v);
            end;

            for _, v in result2 do
                renderItem(v);
            end;

            table.insert(u24, task.spawn(function() -- Line: 615
                -- upvalues: u27 (ref), ScrollingFrame (ref), loadVisibleTiles (ref)
                for _ = 1, 6 do
                    task.wait();

                    if not u27 then
                        return;
                    end;

                    if ScrollingFrame.AbsoluteWindowSize.Y > 0 then
                        break;
                    end;
                end;

                if u27 then
                    loadVisibleTiles();
                end;
            end));
            u20.reachedEnd = pages.IsFinished == true;
        end));
    end;

    local u98 = false;

    local function loadMore() -- Line: 707
        -- upvalues: u98 (ref), u27 (ref), pages (ref), LoadingController (ref), ScrollingFrame (copy), u24 (copy), u20 (copy), renderItem (copy), loadVisibleTiles (copy)
        if u98 or not u27 then
            return;
        end;

        if not pages or pages.IsFinished then
            return;
        end;

        u98 = true;
        LoadingController.DisplayLoading(ScrollingFrame, "foot");
        table.insert(u24, task.spawn(function() -- Line: 712
            -- upvalues: pages (ref), LoadingController (ref), u27 (ref), u20 (ref), renderItem (ref), u24 (ref), ScrollingFrame (ref), loadVisibleTiles (ref), u98 (ref)
            local success = pcall(function() -- Line: 713
                -- upvalues: pages (ref)
                pages:AdvanceToNextPageAsync();
            end);
            local success2, result = pcall(function() -- Line: 714
                -- upvalues: pages (ref)
                return pages:GetCurrentPage();
            end);
            LoadingController.RemoveLoading();

            if not u27 then
                return;
            end;

            if success and (success2 and typeof(result) == "table") then
                for _, v in result do
                    table.insert(u20.items, v);
                end;

                for _, v in result do
                    renderItem(v);
                end;

                table.insert(u24, task.spawn(function() -- Line: 615
                    -- upvalues: u27 (ref), ScrollingFrame (ref), loadVisibleTiles (ref)
                    for _ = 1, 6 do
                        task.wait();

                        if not u27 then
                            return;
                        end;

                        if ScrollingFrame.AbsoluteWindowSize.Y > 0 then
                            break;
                        end;
                    end;

                    if u27 then
                        loadVisibleTiles();
                    end;
                end));
            end;

            u20.reachedEnd = pages.IsFinished == true;
            u98 = false;
        end));
    end;

    local v99 = ScrollingFrame:GetPropertyChangedSignal("CanvasPosition");
    table.insert(u23, v99:Connect(function() -- Line: 729
        -- upvalues: u92 (ref), u27 (ref), loadVisibleTiles (copy), ScrollingFrame (copy), loadMore (copy)
        if not u92 and u27 then
            u92 = true;
            task.delay(0.1, function() -- Line: 607
                -- upvalues: u92 (ref), u27 (ref), loadVisibleTiles (ref)
                u92 = false;

                if u27 then
                    loadVisibleTiles();
                end;
            end);
        end;

        local Y = ScrollingFrame.AbsoluteCanvasSize.Y;
        local Y2 = ScrollingFrame.AbsoluteWindowSize.Y;

        if Y <= Y2 then
            return;
        end;

        if ScrollingFrame.CanvasPosition.Y >= Y - Y2 - 80 then
            loadMore();
        end;
    end));
    local BodyPresetAction = Remotes:WaitForChild("BodyPresetAction");
    local u100 = {};
    local u101 = 1;

    local function notify(p102) -- Line: 747
        -- upvalues: Events (ref)
        Events.Notify:Fire(p102);
    end;

    local function removePresetTile(p103) -- Line: 752
        -- upvalues: u100 (copy), u65 (copy), u20 (copy), u28 (ref), u67 (copy), u26 (copy), u25 (copy)
        local v104 = u100[p103];

        if not v104 then
            return;
        end;

        local v105 = "preset_" .. p103;
        u100[p103] = nil;
        u65[v105] = nil;
        u20.bodyPartsById[v105] = nil;

        if u28 == v104 then
            u28 = nil;
        end;

        for i = #u67, 1, -1 do
            if u67[i].tile == v104 then
                table.remove(u67, i);
            end;
        end;

        for i = #u26, 1, -1 do
            if u26[i].tile == v104 then
                local preview = u26[i].preview;

                if preview then
                    pcall(preview.Destroy, preview);

                    for i2 = #u25, 1, -1 do
                        if u25[i2] == preview then
                            table.remove(u25, i2);
                        end;
                    end;
                end;

                table.remove(u26, i);
            end;
        end;

        v104:Destroy();
    end;

    local function wireLongPress(u106, u107) -- Line: 780
        -- upvalues: u23 (copy), u27 (ref), u24 (copy)
        local u108 = nil;

        local function cancel() -- Line: 782
            -- upvalues: u108 (ref)
            if u108 then
                pcall(task.cancel, u108);
                u108 = nil;
            end;
        end;

        table.insert(u23, u106.click.MouseButton1Down:Connect(function() -- Line: 785
            -- upvalues: u108 (ref), u27 (ref), u106 (copy), u107 (copy), u24 (ref)
            if u108 then
                pcall(task.cancel, u108);
                u108 = nil;
            end;

            u108 = task.delay(0.4, function() -- Line: 787
                -- upvalues: u108 (ref), u27 (ref), u106 (ref), u107 (ref)
                u108 = nil;

                if not (u27 and u106.Parent) then
                    return;
                end;

                u106:SetAttribute("suppressActivate", true);
                u107();
            end);
            table.insert(u24, u108);
        end));
        table.insert(u23, u106.click.MouseButton1Up:Connect(cancel));
        table.insert(u23, u106.click.MouseLeave:Connect(cancel));
    end;

    local function presetAction(u109, u110, u111) -- Line: 802
        -- upvalues: u24 (copy), BodyPresetAction (copy), u27 (ref), u20 (copy), Events (ref)
        table.insert(u24, task.spawn(function() -- Line: 803
            -- upvalues: BodyPresetAction (ref), u109 (copy), u27 (ref), u20 (ref), u110 (copy), Events (ref), u111 (copy)
            local v112, v113 = BodyPresetAction:InvokeServer(u109);

            if not u27 then
                return;
            end;

            if v112 and typeof(v113) == "table" then
                u20.bodyPresets = v113;

                if u110 then
                    u110(v113);
                end;
            else
                if v113 == "full" then
                    Events.Notify:Fire("⚠️ You can only save up to 30 presets.");

                    return;
                end;

                if v113 == "cooldown" then
                    Events.Notify:Fire("⚠️ Slow down a moment, then try again.");

                    return;
                end;

                if v113 == "noCharacter" then
                    Events.Notify:Fire("⚠️ Your avatar isn\'t ready yet. Try again in a moment.");

                    return;
                end;

                if not u111 then
                    Events.Notify:Fire("❌ Something went wrong. Try again.");
                end;
            end;
        end));
    end;

    local function renderPreset(u114, p115) -- Line: 821
        -- upvalues: u20 (copy), u101 (ref), renderItem (copy), u100 (copy), TextPrimary (ref), CardBackground (ref), removePresetTile (copy), renderPreset (ref), u24 (copy), u27 (ref), ScrollingFrame (copy), loadVisibleTiles (copy), Events (ref), BodyPresetAction (copy), DialogController (ref), wireLongPress (copy), ItemButton (ref)
        local Id = u114.Id;

        if not Id then
            return;
        end;

        local v116 = "preset_" .. Id;
        u20.bodyPartsById[v116] = u114.Parts;
        u20.scaleById = u20.scaleById or {};
        u20.scaleById[v116] = u114.Scale;
        u20.rigById = u20.rigById or {};
        u20.rigById[v116] = u114.Rig == "R6" and "R6" or "R15";
        local u117 = {
            Id = v116,
            Name = u114.Name
        };

        if not p115 then
            u101 = u101 + 1;
            p115 = u101;
        end;

        local u118 = renderItem(u117, p115);

        if not u118 then
            return;
        end;

        u100[Id] = u118;
        local preview = u118:FindFirstChild("preview");

        if preview then
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Name = "presetBadge";
            TextLabel.AnchorPoint = Vector2.new(0, 0);
            TextLabel.Position = UDim2.new(0, 4, 0, 4);
            TextLabel.Size = UDim2.fromScale(0.62, 0.13);
            TextLabel.BackgroundColor3 = TextPrimary;
            TextLabel.BackgroundTransparency = 0;
            TextLabel.BorderSizePixel = 0;
            TextLabel.ZIndex = 3;
            TextLabel.Text = "Saved Preset";
            TextLabel.TextColor3 = CardBackground;
            TextLabel.TextScaled = true;
            TextLabel.TextWrapped = true;
            TextLabel.FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold);
            TextLabel.TextXAlignment = Enum.TextXAlignment.Center;
            TextLabel.TextYAlignment = Enum.TextYAlignment.Center;
            TextLabel.Parent = preview;
            local UICorner = Instance.new("UICorner");
            UICorner.CornerRadius = UDim.new(0.3, 0);
            UICorner.Parent = TextLabel;
            local UIPadding2 = Instance.new("UIPadding");
            UIPadding2.PaddingLeft = UDim.new(0.04, 0);
            UIPadding2.PaddingRight = UDim.new(0.04, 0);
            UIPadding2.PaddingTop = UDim.new(0.04, 0);
            UIPadding2.PaddingBottom = UDim.new(0.04, 0);
            UIPadding2.Parent = TextLabel;
        end;

        local function onUpdate() -- Line: 865
            -- upvalues: Id (copy), u100 (ref), removePresetTile (ref), renderPreset (ref), u24 (ref), u27 (ref), ScrollingFrame (ref), loadVisibleTiles (ref), Events (ref), BodyPresetAction (ref), u20 (ref)
            local u119 = {
                Action = "Update",
                Id = Id
            };

            local function u123(p120) -- Line: 866
                -- upvalues: Id (ref), u100 (ref), removePresetTile (ref), renderPreset (ref), u24 (ref), u27 (ref), ScrollingFrame (ref), loadVisibleTiles (ref), Events (ref)
                local v121 = p120[Id];

                if not v121 then
                    return;
                end;

                v121.Id = Id;
                local v122 = u100[Id] and u100[Id].LayoutOrder;
                removePresetTile(Id);
                renderPreset(v121, v122);
                table.insert(u24, task.spawn(function() -- Line: 615
                    -- upvalues: u27 (ref), ScrollingFrame (ref), loadVisibleTiles (ref)
                    for _ = 1, 6 do
                        task.wait();

                        if not u27 then
                            return;
                        end;

                        if ScrollingFrame.AbsoluteWindowSize.Y > 0 then
                            break;
                        end;
                    end;

                    if u27 then
                        loadVisibleTiles();
                    end;
                end));
                Events.Notify:Fire("✅ Updated <b>" .. (v121.Name or "preset") .. "</b>.");
            end;

            local u124 = nil;
            table.insert(u24, task.spawn(function() -- Line: 803
                -- upvalues: BodyPresetAction (ref), u119 (copy), u27 (ref), u20 (ref), u123 (copy), Events (ref), u124 (copy)
                local v125, v126 = BodyPresetAction:InvokeServer(u119);

                if not u27 then
                    return;
                end;

                if v125 and typeof(v126) == "table" then
                    u20.bodyPresets = v126;

                    if u123 then
                        u123(v126);
                    end;
                else
                    if v126 == "full" then
                        Events.Notify:Fire("⚠️ You can only save up to 30 presets.");

                        return;
                    end;

                    if v126 == "cooldown" then
                        Events.Notify:Fire("⚠️ Slow down a moment, then try again.");

                        return;
                    end;

                    if v126 == "noCharacter" then
                        Events.Notify:Fire("⚠️ Your avatar isn\'t ready yet. Try again in a moment.");

                        return;
                    end;

                    if not u124 then
                        Events.Notify:Fire("❌ Something went wrong. Try again.");
                    end;
                end;
            end));
        end;

        local function onRename() -- Line: 877
            -- upvalues: DialogController (ref), u114 (copy), Id (copy), u100 (ref), Events (ref), u24 (ref), BodyPresetAction (ref), u27 (ref), u20 (ref)
            local v127 = DialogController.PromptInputDialog({
                Title = "Rename Preset",
                Description = "Choose a new name for this preset.",
                PlaceholderText = "Body Preset",
                YesText = "Rename",
                NoText = "Cancel",
                DefaultText = u114.Name
            });

            if typeof(v127) ~= "string" then
                return;
            end;

            local u128 = v127 == "" and "Body Preset" or v127;
            local u129 = {
                Action = "Rename",
                Id = Id,
                Name = u128
            };

            local function u133(p130) -- Line: 881
                -- upvalues: Id (ref), u100 (ref), u114 (ref), u128 (ref), Events (ref)
                local v131 = p130[Id];
                local v132 = u100[Id];

                if v131 and v132 then
                    v132.name.Text = v131.Name or "";
                    u114.Name = v131.Name;
                    Events.Notify:Fire("✅ Renamed to <b>" .. (v131.Name or u128) .. "</b>.");
                end;
            end;

            local u134 = nil;
            table.insert(u24, task.spawn(function() -- Line: 803
                -- upvalues: BodyPresetAction (ref), u129 (copy), u27 (ref), u20 (ref), u133 (copy), Events (ref), u134 (copy)
                local v135, v136 = BodyPresetAction:InvokeServer(u129);

                if not u27 then
                    return;
                end;

                if v135 and typeof(v136) == "table" then
                    u20.bodyPresets = v136;

                    if u133 then
                        u133(v136);
                    end;
                else
                    if v136 == "full" then
                        Events.Notify:Fire("⚠️ You can only save up to 30 presets.");

                        return;
                    end;

                    if v136 == "cooldown" then
                        Events.Notify:Fire("⚠️ Slow down a moment, then try again.");

                        return;
                    end;

                    if v136 == "noCharacter" then
                        Events.Notify:Fire("⚠️ Your avatar isn\'t ready yet. Try again in a moment.");

                        return;
                    end;

                    if not u134 then
                        Events.Notify:Fire("❌ Something went wrong. Try again.");
                    end;
                end;
            end));
        end;

        local function onDelete() -- Line: 891
            -- upvalues: DialogController (ref), u114 (copy), Id (copy), removePresetTile (ref), Events (ref), u24 (ref), BodyPresetAction (ref), u27 (ref), u20 (ref)
            if DialogController.PromptDialog({
                Title = "Delete Preset?",
                YesText = "Delete",
                NoText = "Cancel",
                Description = "This permanently removes <b>" .. (u114.Name or "this preset") .. "</b>."
            }) ~= true then
                return;
            end;

            local u137 = {
                Action = "Delete",
                Id = Id
            };

            local function u138() -- Line: 894
                -- upvalues: removePresetTile (ref), Id (ref), u114 (ref), Events (ref)
                removePresetTile(Id);
                Events.Notify:Fire("✅ Deleted <b>" .. (u114.Name or "preset") .. "</b>.");
            end;

            local u139 = nil;
            table.insert(u24, task.spawn(function() -- Line: 803
                -- upvalues: BodyPresetAction (ref), u137 (copy), u27 (ref), u20 (ref), u138 (copy), Events (ref), u139 (copy)
                local v140, v141 = BodyPresetAction:InvokeServer(u137);

                if not u27 then
                    return;
                end;

                if v140 and typeof(v141) == "table" then
                    u20.bodyPresets = v141;

                    if u138 then
                        u138(v141);
                    end;
                else
                    if v141 == "full" then
                        Events.Notify:Fire("⚠️ You can only save up to 30 presets.");

                        return;
                    end;

                    if v141 == "cooldown" then
                        Events.Notify:Fire("⚠️ Slow down a moment, then try again.");

                        return;
                    end;

                    if v141 == "noCharacter" then
                        Events.Notify:Fire("⚠️ Your avatar isn\'t ready yet. Try again in a moment.");

                        return;
                    end;

                    if not u139 then
                        Events.Notify:Fire("❌ Something went wrong. Try again.");
                    end;
                end;
            end));
        end;

        wireLongPress(u118, function() -- Line: 900
            -- upvalues: ItemButton (ref), u118 (copy), u117 (copy), u114 (copy), onUpdate (copy), onRename (copy), onDelete (copy)
            ItemButton.ShowContextButtons(u118, u117, {
                ItemButtonType = "BodyPreset",
                PoseDetails = u114,
                OnUpdate = onUpdate,
                OnRename = onRename,
                OnDelete = onDelete
            });
        end);
    end;

    local v142 = u22:Clone();
    v142.Name = "savePreset";
    v142.LayoutOrder = 0;
    v142.name.Text = "Save Preset";
    v142.preview.viewport.ImageTransparency = 1;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "plus";
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
    ImageLabel.Size = UDim2.fromScale(0.42, 0.42);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = "rbxassetid://135828800170259";
    ImageLabel.ScaleType = Enum.ScaleType.Fit;
    ImageLabel.ImageColor3 = TextHeading;
    ImageLabel.ZIndex = 4;
    ImageLabel.Parent = v142.preview;
    v142.Parent = ScrollingFrame;
    table.insert(u23, v142.click.Activated:Connect(function() -- Line: 930
        -- upvalues: buildBodyDescription (ref), u32 (copy), u39 (ref), u40 (ref), DialogController (ref), u30 (copy), u100 (copy), renderPreset (ref), u24 (copy), u27 (ref), ScrollingFrame (copy), loadVisibleTiles (copy), Events (ref), BodyPresetAction (copy), u20 (copy)
        local v143 = buildBodyDescription(u32, u39, u40);

        if DialogController.PromptConfirmAvatar({
            Title = "Save this body?",
            YesText = "Save",
            NoText = "Cancel",
            HumanoidDescription = v143,
            RigType = u30
        }) ~= true then
            return;
        end;

        local v144 = DialogController.PromptInputDialog({
            Title = "Name Preset",
            Description = "Give this body preset a name.",
            PlaceholderText = "Body Preset",
            YesText = "Save",
            NoText = "Cancel"
        });

        if typeof(v144) ~= "string" then
            return;
        end;

        local u145 = v144 == "" and "Body Preset" or v144;
        local u146 = {
            Action = "Add",
            Name = u145
        };

        local function u148(p147) -- Line: 946
            -- upvalues: u100 (ref), renderPreset (ref), u24 (ref), u27 (ref), ScrollingFrame (ref), loadVisibleTiles (ref), u145 (ref), Events (ref)
            for i, v in p147 do
                if not u100[i] then
                    v.Id = v.Id or i;
                    renderPreset(v);
                end;
            end;

            table.insert(u24, task.spawn(function() -- Line: 615
                -- upvalues: u27 (ref), ScrollingFrame (ref), loadVisibleTiles (ref)
                for _ = 1, 6 do
                    task.wait();

                    if not u27 then
                        return;
                    end;

                    if ScrollingFrame.AbsoluteWindowSize.Y > 0 then
                        break;
                    end;
                end;

                if u27 then
                    loadVisibleTiles();
                end;
            end));
            Events.Notify:Fire("✅ Saved preset <b>" .. u145 .. "</b>.");
        end;

        local u149 = nil;
        table.insert(u24, task.spawn(function() -- Line: 803
            -- upvalues: BodyPresetAction (ref), u146 (copy), u27 (ref), u20 (ref), u148 (copy), Events (ref), u149 (copy)
            local v150, v151 = BodyPresetAction:InvokeServer(u146);

            if not u27 then
                return;
            end;

            if v150 and typeof(v151) == "table" then
                u20.bodyPresets = v151;

                if u148 then
                    u148(v151);
                end;
            else
                if v151 == "full" then
                    Events.Notify:Fire("⚠️ You can only save up to 30 presets.");

                    return;
                end;

                if v151 == "cooldown" then
                    Events.Notify:Fire("⚠️ Slow down a moment, then try again.");

                    return;
                end;

                if v151 == "noCharacter" then
                    Events.Notify:Fire("⚠️ Your avatar isn\'t ready yet. Try again in a moment.");

                    return;
                end;

                if not u149 then
                    Events.Notify:Fire("❌ Something went wrong. Try again.");
                end;
            end;
        end));
    end));

    if u20.bodyPresets then
        for i, v in u20.bodyPresets do
            v.Id = v.Id or i;
            renderPreset(v);
        end;
    end;

    local u152 = {
        Action = "Get"
    };

    local function u156(p153) -- Line: 966
        -- upvalues: u100 (copy), renderPreset (ref), removePresetTile (copy), u24 (copy), u27 (ref), ScrollingFrame (copy), loadVisibleTiles (copy)
        local v154 = {};

        for i, v in p153 do
            v.Id = v.Id or i;
            v154[i] = true;

            if not u100[i] then
                renderPreset(v);
            end;
        end;

        local v155 = {};

        for i in u100 do
            if not v154[i] then
                table.insert(v155, i);
            end;
        end;

        for _, v in v155 do
            removePresetTile(v);
        end;

        table.insert(u24, task.spawn(function() -- Line: 615
            -- upvalues: u27 (ref), ScrollingFrame (ref), loadVisibleTiles (ref)
            for _ = 1, 6 do
                task.wait();

                if not u27 then
                    return;
                end;

                if ScrollingFrame.AbsoluteWindowSize.Y > 0 then
                    break;
                end;
            end;

            if u27 then
                loadVisibleTiles();
            end;
        end));
    end;

    local u157 = true;
    table.insert(u24, task.spawn(function() -- Line: 803
        -- upvalues: BodyPresetAction (copy), u152 (copy), u27 (ref), u20 (copy), u156 (copy), Events (ref), u157 (copy)
        local v158, v159 = BodyPresetAction:InvokeServer(u152);

        if not u27 then
            return;
        end;

        if v158 and typeof(v159) == "table" then
            u20.bodyPresets = v159;

            if u156 then
                u156(v159);
            end;
        else
            if v159 == "full" then
                Events.Notify:Fire("⚠️ You can only save up to 30 presets.");

                return;
            end;

            if v159 == "cooldown" then
                Events.Notify:Fire("⚠️ Slow down a moment, then try again.");

                return;
            end;

            if v159 == "noCharacter" then
                Events.Notify:Fire("⚠️ Your avatar isn\'t ready yet. Try again in a moment.");

                return;
            end;

            if not u157 then
                Events.Notify:Fire("❌ Something went wrong. Try again.");
            end;
        end;
    end));

    for i, v in u5 do
        local v160 = "custom" .. i;
        local v161 = {};

        for _, v2 in u4 do
            if v[v2] ~= nil then
                v161[v2] = v[v2];
            end;
        end;

        u20.bodyPartsById[v160] = v161;
        u20.scaleById = u20.scaleById or {};
        u20.scaleById[v160] = v.Scale;
        u20.rigById = u20.rigById or {};
        u20.rigById[v160] = v.Rig or "R15";
        renderItem({
            Id = v160,
            Name = v.Name or "Custom"
        });
    end;

    if #u3 > 0 then
        local v162 = {};

        for _, v in u3 do
            local v163;

            if type(v) == "table" then
                v163 = v.Id or v;
            else
                v163 = v;
            end;

            if type(v163) == "number" then
                local v164 = {
                    Id = v163,
                    Name = type(v) == "table" and (v.Name or "") or ""
                };
                table.insert(v162, v164);
            end;
        end;

        for _, v in v162 do
            renderItem(v);
        end;
    end;

    if u20.items and #u20.items > 0 then
        for _, v in u20.items do
            renderItem(v);
        end;

        if u20.scrollY then
            task.defer(function() -- Line: 1012
                -- upvalues: u27 (ref), ScrollingFrame (copy), u20 (copy)
                if u27 and ScrollingFrame.Parent then
                    ScrollingFrame.CanvasPosition = Vector2.new(0, u20.scrollY);
                end;
            end);
        end;

        table.insert(u24, task.spawn(function() -- Line: 615
            -- upvalues: u27 (ref), ScrollingFrame (copy), loadVisibleTiles (copy)
            for _ = 1, 6 do
                task.wait();

                if not u27 then
                    return;
                end;

                if ScrollingFrame.AbsoluteWindowSize.Y > 0 then
                    break;
                end;
            end;

            if u27 then
                loadVisibleTiles();
            end;
        end));
    else
        LoadingController.DisplayLoading(u16, "overlay");
        table.insert(u24, task.spawn(function() -- Line: 666
            -- upvalues: AvatarEditorService (ref), u27 (ref), LoadingController (ref), u16 (copy), pages (ref), u20 (copy), renderItem (copy), u24 (copy), ScrollingFrame (copy), loadVisibleTiles (copy)
            local u165 = CatalogSearchParams.new();
            u165.BundleTypes = { Enum.BundleType.BodyParts };
            u165.Limit = 60;
            u165.SortType = Enum.CatalogSortType.MostFavorited;
            u165.IncludeOffSale = false;
            u165.SalesTypeFilter = Enum.SalesTypeFilter.All;
            local success, result = pcall(function() -- Line: 674
                -- upvalues: AvatarEditorService (ref), u165 (copy)
                return AvatarEditorService:SearchCatalog(u165);
            end);

            if not u27 then
                LoadingController.RemoveLoading();

                return;
            end;

            if not success or typeof(result) ~= "Instance" then
                LoadingController.RemoveLoading();
                LoadingController.DisplayGraphic(u16, "createAvatar", "noResults");

                return;
            end;

            pages = result;
            u20.pages = pages;
            local success2, result2 = pcall(function() -- Line: 688
                -- upvalues: pages (ref)
                return pages:GetCurrentPage();
            end);
            LoadingController.RemoveLoading();

            if not u27 then
                return;
            end;

            if not success2 or typeof(result2) ~= "table" then
                LoadingController.DisplayGraphic(u16, "createAvatar", "noResults");

                return;
            end;

            u20.items = u20.items or {};

            for _, v in result2 do
                table.insert(u20.items, v);
            end;

            for _, v in result2 do
                renderItem(v);
            end;

            table.insert(u24, task.spawn(function() -- Line: 615
                -- upvalues: u27 (ref), ScrollingFrame (ref), loadVisibleTiles (ref)
                for _ = 1, 6 do
                    task.wait();

                    if not u27 then
                        return;
                    end;

                    if ScrollingFrame.AbsoluteWindowSize.Y > 0 then
                        break;
                    end;
                end;

                if u27 then
                    loadVisibleTiles();
                end;
            end));
            u20.reachedEnd = pages.IsFinished == true;
        end));
    end;

    local u166 = TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
    local Frame = Instance.new("Frame");
    Frame.Name = "bodyOptions";
    Frame.AnchorPoint = Vector2.new(0.5, 1);
    Frame.Position = UDim2.fromScale(0.5, 0.982);
    Frame.Size = UDim2.fromScale(1, 0.11);
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.ZIndex = 10;
    Frame.Parent = u16;
    local UIPadding2 = Instance.new("UIPadding");
    UIPadding2.PaddingLeft = UDim.new(0.012, 0);
    UIPadding2.Parent = Frame;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
    UIListLayout.Padding = UDim.new(0.012, 0);
    UIListLayout.Parent = Frame;

    local function makeToggle(p167, p168, p169, p170, u171, u172) -- Line: 1042
        -- upvalues: SurfaceBackground (ref), Frame (copy), SubtleStroke (ref), CollectionService (ref), ToggleBlue (ref), TextHeading (ref), u23 (copy), TweenService (ref), u166 (copy), applyBodyToDraft (copy), refreshTilePreviews (copy)
        local TextButton = Instance.new("TextButton");
        TextButton.Name = p167;
        TextButton.LayoutOrder = p169;
        TextButton.ZIndex = 10;
        TextButton.Size = UDim2.fromScale(p170, 1);
        TextButton.BackgroundColor3 = SurfaceBackground;
        TextButton.AutoButtonColor = false;
        TextButton.Style = Enum.ButtonStyle.Custom;
        TextButton.Text = "";
        TextButton.BorderSizePixel = 0;
        TextButton.Parent = Frame;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(1, 0);
        UICorner.Parent = TextButton;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        UIStroke.BorderStrokePosition = Enum.BorderStrokePosition.Outer;
        UIStroke.LineJoinMode = Enum.LineJoinMode.Round;
        UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.FixedSize;
        UIStroke.Color = SubtleStroke;
        UIStroke.Thickness = 1.5;
        UIStroke.Parent = TextButton;
        CollectionService:AddTag(TextButton, "UIEffectSoundOnly");
        local Frame2 = Instance.new("Frame");
        Frame2.Name = "checkbox";
        Frame2.ZIndex = 10;
        Frame2.BackgroundTransparency = 1;
        Frame2.AnchorPoint = Vector2.new(0, 0.5);
        Frame2.Position = UDim2.fromScale(0.065, 0.5);
        Frame2.Size = UDim2.fromScale(0.4, 0.5);
        local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint");
        UIAspectRatioConstraint2.AspectRatio = 1;
        UIAspectRatioConstraint2.DominantAxis = Enum.DominantAxis.Height;
        UIAspectRatioConstraint2.AspectType = Enum.AspectType.FitWithinMaxSize;
        UIAspectRatioConstraint2.Parent = Frame2;
        Frame2.Parent = TextButton;
        local ImageLabel2 = Instance.new("ImageLabel");
        ImageLabel2.AnchorPoint = Vector2.new(0.5, 0.5);
        ImageLabel2.Position = UDim2.fromScale(0.5, 0.5);
        ImageLabel2.Size = UDim2.fromScale(1, 1);
        ImageLabel2.BackgroundTransparency = 1;
        ImageLabel2.Image = "rbxassetid://108840008135273";
        ImageLabel2.ImageColor3 = Color3.fromRGB(255, 255, 255);
        ImageLabel2.ScaleType = Enum.ScaleType.Fit;
        ImageLabel2.ZIndex = 10;
        ImageLabel2.Parent = Frame2;
        local ImageLabel3 = Instance.new("ImageLabel");
        ImageLabel3.Name = "checked";
        ImageLabel3.AnchorPoint = Vector2.new(0.5, 0.5);
        ImageLabel3.Position = UDim2.fromScale(0.5, 0.5);
        ImageLabel3.Size = UDim2.fromScale(1, 1);
        ImageLabel3.BackgroundTransparency = 1;
        ImageLabel3.Image = "rbxassetid://71418101941296";
        ImageLabel3.ImageColor3 = ToggleBlue;
        ImageLabel3.ImageTransparency = u171() and 0 or 1;
        ImageLabel3.ScaleType = Enum.ScaleType.Fit;
        ImageLabel3.ZIndex = 10;
        ImageLabel3.Parent = Frame2;
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = "label";
        TextLabel.ZIndex = 10;
        TextLabel.AnchorPoint = Vector2.new(0, 0.5);
        TextLabel.Position = UDim2.fromScale(0.25, 0.5);
        TextLabel.Size = UDim2.fromScale(0.7, 0.5);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.Text = p168;
        TextLabel.FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold);
        TextLabel.TextColor3 = TextHeading;
        TextLabel.TextScaled = true;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.TextYAlignment = Enum.TextYAlignment.Center;
        TextLabel.BorderSizePixel = 0;
        TextLabel.Parent = TextButton;
        table.insert(u23, TextButton.Activated:Connect(function() -- Line: 1066
            -- upvalues: u171 (copy), u172 (copy), TweenService (ref), ImageLabel3 (copy), u166 (ref), applyBodyToDraft (ref), refreshTilePreviews (ref)
            local v173 = not u171();
            u172(v173);
            TweenService:Create(ImageLabel3, u166, {
                ImageTransparency = v173 and 0 or 1
            }):Play();
            applyBodyToDraft();
            refreshTilePreviews();
        end));
    end;

    makeToggle("korblox", "Korblox Leg", 1, 0.24, function() -- Line: 1076
        -- upvalues: u39 (ref)
        return u39;
    end, function(p174) -- Line: 1077
        -- upvalues: u39 (ref), u18 (copy)
        u39 = p174;
        u18.KorbloxLeg = p174 or nil;
    end);
    makeToggle("headless", "Headless Head", 2, 0.29, function() -- Line: 1079
        -- upvalues: u40 (ref)
        return u40;
    end, function(p175) -- Line: 1080
        -- upvalues: u40 (ref), u18 (copy)
        u40 = p175;
        u18.HeadlessHead = p175 or nil;
    end);

    return function() -- Line: 1083
        -- upvalues: u27 (ref), u20 (copy), ScrollingFrame (copy), LoadingController (ref), u23 (copy), u24 (copy), u25 (copy), u26 (copy)
        u27 = false;
        u20.scrollY = ScrollingFrame.CanvasPosition.Y;
        LoadingController.RemoveLoading();

        for _, v in u23 do
            pcall(v.Disconnect, v);
        end;

        for _, v in u24 do
            pcall(task.cancel, v);
        end;

        for _, v in u25 do
            pcall(v.Destroy, v);
        end;

        table.clear(u26);
    end;
end;

function v6.CanContinue(p176) -- Line: 1094
    return true;
end;

return v6;