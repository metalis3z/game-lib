-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Modules = require(script.Parent.Parent.Parent.Modules);
local SoundController = require(Modules.Controllers.SoundController);
local ThemeController = require(script.Parent.Parent.ThemeController);
local LocalPlayer = game:GetService("Players").LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local u1 = 0;
local u2 = nil;

local function pokeDoF() -- Line: 48
    -- upvalues: Lighting (copy), u1 (ref), u2 (ref), RunService (copy)
    if not Lighting:FindFirstChild("DepthOfField") then
        return;
    end;

    u1 = os.clock() + 0.4;

    if u2 then
        return;
    end;

    local u3 = false;
    u2 = RunService.RenderStepped:Connect(function() -- Line: 53
        -- upvalues: Lighting (ref), u1 (ref), u2 (ref), u3 (ref)
        local DepthOfField = Lighting:FindFirstChild("DepthOfField");

        if not DepthOfField or u1 < os.clock() then
            if u2 then
                u2:Disconnect();
                u2 = nil;
            end;

            return;
        end;

        u3 = not u3;
        DepthOfField.FocusDistance = DepthOfField.FocusDistance + (u3 and 0.001 or -0.001);
    end);
end;

local function applyCameraOffset(u4) -- Line: 67
    -- upvalues: LocalPlayer (copy)
    return function(p5, p6) -- Line: 68
        -- upvalues: LocalPlayer (ref), u4 (copy)
        local Character = LocalPlayer.Character;

        if not Character then
            return;
        end;

        local v7 = Character:FindFirstChildWhichIsA("Humanoid");

        if not v7 then
            return;
        end;

        local v8 = u4 ~= "X" and (p6.GetSetting({ "Camera", "OffsetX" }) or 0) or p5;
        local v9 = u4 ~= "Y" and (p6.GetSetting({ "Camera", "OffsetY" }) or 0) or p5;
        local v10 = u4 ~= "Z" and (p6.GetSetting({ "Camera", "OffsetZ" }) or 0) or p5;
        v7.CameraOffset = Vector3.new(v8, v9, v10);
    end;
end;

local function applyAvatarPreviewSide(p11) -- Line: 80
    -- upvalues: PlayerGui (copy)
    local v12 = PlayerGui:FindFirstChild("Catalog") and PlayerGui.Catalog:FindFirstChild("container");

    if not v12 then
        return;
    end;

    local avatarSection = v12:FindFirstChild("avatarSection");
    local catalogSection = v12:FindFirstChild("catalogSection");

    if avatarSection then
        local v13;

        if p11 then
            v13 = Vector2.new(1, 0);
        else
            v13 = Vector2.new(0, 0);
        end;

        avatarSection.AnchorPoint = v13;
        local v14;

        if p11 then
            v14 = UDim2.new(1, 0, 0, 0);
        else
            v14 = UDim2.new(0, 0, 0, 0);
        end;

        avatarSection.Position = v14;
    end;

    if catalogSection then
        local v15;

        if p11 then
            v15 = Vector2.new(0, 0);
        else
            v15 = Vector2.new(1, 0);
        end;

        catalogSection.AnchorPoint = v15;
        local v16;

        if p11 then
            v16 = UDim2.new(0, 0, 0, 0);
        else
            v16 = UDim2.new(1, 0, 0, 0);
        end;

        catalogSection.Position = v16;
    end;

    local v17 = PlayerGui:FindFirstChild("SavedOutfits") and PlayerGui.SavedOutfits:FindFirstChild("container");
    local v18 = PlayerGui:FindFirstChild("CommunityOutfits") and PlayerGui.CommunityOutfits:FindFirstChild("container");
    local v19 = p11 and 0.357384324 or 0.642615676;

    if v17 then
        v17.Position = UDim2.new(v19, 0, 0.5, 0);
    end;

    if v18 then
        v18.Position = UDim2.new(v19, 0, 0.5, 0);
    end;
end;

local v51 = {
    Profile = {
        {
            type = "customChat",
            key = "customChatColor",
            layoutOrder = 1
        },
        {
            type = "input",
            key = "chatTagText",
            label = "Chat Tag",
            layoutOrder = 2,
            requiresGroup = true,
            default = "",
            placeholder = "Tag Text",
            inputType = "string",
            path = { "Profile", "ChatTagText" },
            inputSize = UDim2.new(0.35, 0, 0.9, 0),

            onSaveNotify = function(p20) -- Line: 128, Name: onSaveNotify
                return p20 == "" and "✅ Successfully removed your title." or "✅ Successfully changed title to [" .. p20 .. "]";
            end
        },
        {
            type = "input",
            key = "roleplayName",
            label = "Roleplay Name",
            layoutOrder = 3,
            default = "",
            placeholder = "Display Name",
            inputType = "string",
            path = { "Profile", "RoleplayName" },
            inputSize = UDim2.new(0.35, 0, 0.9, 0),

            onSaveNotify = function(p21) -- Line: 146, Name: onSaveNotify
                return p21 == "" and "✅ Roleplay name cleared." or "✅ Roleplay name set to [" .. p21 .. "]";
            end
        },
        {
            type = "divider",
            layoutOrder = 6
        },
        {
            type = "slider",
            key = "speed",
            label = "Speed",
            layoutOrder = 10,
            default = 16,
            min = 0,
            max = 100,
            increment = 1,
            path = { "Profile", "Speed" },

            onChange = function(p22) -- Line: 168, Name: onChange
                -- upvalues: LocalPlayer (copy)
                local Character = LocalPlayer.Character;
                local v23 = Character and Character:FindFirstChildWhichIsA("Humanoid");

                if v23 then
                    v23.WalkSpeed = p22;
                end;
            end
        },
        {
            type = "slider",
            key = "jumpPower",
            label = "Jump Power",
            layoutOrder = 20,
            default = 50,
            min = 0,
            max = 100,
            increment = 1,
            path = { "Profile", "JumpPower" },

            onChange = function(p24) -- Line: 188, Name: onChange
                -- upvalues: LocalPlayer (copy)
                local Character = LocalPlayer.Character;
                local v25 = Character and Character:FindFirstChildWhichIsA("Humanoid");

                if v25 then
                    v25.UseJumpPower = true;
                    v25.JumpPower = p24;
                end;
            end
        },
        {
            type = "slider",
            key = "gravity",
            label = "Gravity",
            layoutOrder = 30,
            default = 196.2,
            min = 0,
            max = 400,
            increment = 1,
            path = { "Profile", "Gravity" },

            onChange = function(p26) -- Line: 209, Name: onChange
                workspace.Gravity = p26;
            end
        },
        {
            type = "divider",
            layoutOrder = 35
        },
        {
            type = "dropdown",
            key = "whoCanViewOutfit",
            label = "Who can view my outfit",
            layoutOrder = 60,
            default = "Everyone",
            path = { "Profile", "Privacy", "WhoCanViewOutfit" },
            choices = { {
                    key = "Everyone",
                    text = "Everyone"
                }, {
                    key = "Friends",
                    text = "Friends"
                }, {
                    key = "NoOne",
                    text = "No one"
                } }
        },
        {
            type = "dropdown",
            key = "whoCanTryOnOutfit",
            label = "Who can try on my outfit",
            layoutOrder = 70,
            default = "Everyone",
            path = { "Profile", "Privacy", "WhoCanTryOnOutfit" },
            choices = { {
                    key = "Everyone",
                    text = "Everyone"
                }, {
                    key = "Friends",
                    text = "Friends"
                }, {
                    key = "NoOne",
                    text = "No one"
                } }
        },
        {
            type = "toggle",
            key = "anonymizeAnnouncements",
            label = "Anonymous in Announcements",
            layoutOrder = 80,
            default = false,
            path = { "Profile", "AnonymizeAnnouncements" }
        }
    },
    Interface = {
        {
            type = "toggle",
            key = "reduceFrontPageVibrancy",
            label = "Reduce Front Page Vibrancy",
            layoutOrder = 8,
            default = false,
            path = { "Interface", "ReduceFrontPageVibrancy" },
            visibleWhen = { "showCatalogFrontPage", true }
        },
        {
            type = "toggle",
            key = "avatarPreviewOnRight",
            label = "Move Avatar Section to Right",
            layoutOrder = 1,
            default = false,
            path = { "Interface", "AvatarPreviewOnRight" },

            onChange = function(p27) -- Line: 270, Name: onChange
                -- upvalues: applyAvatarPreviewSide (copy)
                applyAvatarPreviewSide(p27);
            end
        },
        {
            type = "input",
            key = "avatarSectionBackground",
            label = "Avatar Section Background",
            layoutOrder = 2,
            default = "",
            placeholder = "Image ID",
            inputType = "string",
            path = { "Interface", "AvatarSectionBackground" },
            inputSize = UDim2.new(0.35, 0, 0.9, 0),

            validate = function(p28) -- Line: 284, Name: validate
                if p28 == "" then
                    return true;
                end;

                local u29 = tonumber(p28);

                if not u29 then
                    return false, "❌ Invalid ID. Enter a numeric asset ID.";
                end;

                local u30 = nil;

                if pcall(function() -- Line: 289
                    -- upvalues: u30 (ref), u29 (copy)
                    u30 = game:GetService("MarketplaceService"):GetProductInfo(u29, Enum.InfoType.Asset);
                end) and (u30 and (u30.AssetTypeId == 1 or (u30.AssetTypeId == 13 or u30.AssetTypeId == Enum.AssetType.AvatarBackground.Value))) then
                    return true;
                end;

                return false, "❌ Couldn\'t find an image with this ID. Try double checking.";
            end,

            displayTransform = function(p31) -- Line: 300, Name: displayTransform
                if p31 == "" then
                    return nil;
                end;

                return require(script.Parent.Parent.ProfileBackgroundController).GetBackgroundName(p31);
            end,

            onChange = function(p32) -- Line: 305, Name: onChange
                require(script.Parent.Parent.ProfileBackgroundController).ApplyToPreview(p32);
            end,

            onSaveNotify = function(p33) -- Line: 309, Name: onSaveNotify
                return p33 == "" and "✅ Background reset to default." or "✅ Background updated!";
            end
        },
        {
            type = "dropdown",
            key = "theme",
            label = "Theme",
            layoutOrder = 3,
            default = "Dark",
            path = { "Interface", "Theme" },
            choices = { {
                    key = "Dark",
                    text = "Dark"
                }, {
                    key = "Light",
                    text = "Light"
                } },

            onChange = function(p34) -- Line: 328, Name: onChange
                -- upvalues: ThemeController (copy)
                ThemeController.SetTheme(p34);
            end
        },
        {
            type = "dropdown",
            key = "frontPageScrollStyle",
            label = "Front Page Scroll Style",
            layoutOrder = 9,
            default = "Step",
            path = { "Interface", "FrontPageScrollStyle" },
            choices = { {
                    key = "Continuous",
                    text = "Continuous"
                }, {
                    key = "Step",
                    text = "Step"
                } },
            visibleWhen = { "showCatalogFrontPage", true }
        },
        {
            type = "toggle",
            key = "largerCatalogItems",
            label = "Larger Catalog Items",
            layoutOrder = 4,
            default = false,
            path = { "Interface", "LargerCatalogItems" }
        },
        {
            type = "toggle",
            key = "showAdjustBodyButton",
            label = "Show Adjust Body Quick Button",
            layoutOrder = 5,
            default = true,
            path = { "Interface", "ShowAdjustBodyButton" },

            onChange = function(p35) -- Line: 360, Name: onChange
                -- upvalues: PlayerGui (copy)
                local Catalog = PlayerGui:FindFirstChild("Catalog");
                local v36 = Catalog and Catalog.container.catalogSection.bottomBar.left:FindFirstChild("bodyAdjustContainer");

                if v36 then
                    v36.Visible = p35;
                end;
            end
        },
        {
            type = "toggle",
            key = "showCatalogFrontPage",
            label = "Show Catalog Front Page",
            layoutOrder = 7,
            default = true,
            path = { "Interface", "ShowCatalogFrontPage" },

            onChange = function(p37) -- Line: 375, Name: onChange
                -- upvalues: PlayerGui (copy)
                local Catalog = PlayerGui:FindFirstChild("Catalog");

                if not Catalog then
                    return;
                end;

                local returnButton = Catalog.container.catalogSection.topBar:FindFirstChild("returnButton");

                if not returnButton then
                    return;
                end;

                if p37 == true then
                    local frontPage = Catalog.container.catalogSection:FindFirstChild("frontPage");

                    if frontPage and not frontPage.Visible then
                        returnButton.Size = UDim2.new(0.0694428533, 0, 1, 0);
                        returnButton.Visible = true;
                    end;
                else
                    returnButton.Visible = false;
                    returnButton.Size = UDim2.new(0, 0, 0, 0);
                end;
            end
        },
        {
            type = "divider",
            layoutOrder = 5
        },
        {
            type = "divider",
            layoutOrder = 10
        },
        {
            type = "toggle",
            key = "previewItemOnHover",
            label = "Preview Item on Hover",
            layoutOrder = 11,
            default = true,
            path = { "Interface", "PreviewItemOnHover" }
        },
        {
            type = "input",
            key = "itemPreviewDelay",
            label = "Item Preview Delay (seconds)",
            layoutOrder = 12,
            default = 0,
            min = 0,
            max = 10,
            path = { "Interface", "ItemPreviewDelay" },
            visibleWhen = { "previewItemOnHover", true }
        },
        {
            type = "toggle",
            key = "hideSameTypeOnPreview",
            label = "Hide Same Item Type on Preview",
            layoutOrder = 13,
            default = true,
            path = { "Interface", "HideSameTypeOnPreview" },
            visibleWhen = { "previewItemOnHover", true }
        },
        {
            type = "divider",
            layoutOrder = 14
        },
        {
            type = "dropdown",
            key = "categorySelectionMode",
            label = "Category Selection Mode",
            layoutOrder = 15,
            default = "HorizontalScroll",
            path = { "Catalog", "CategorySelectionMode" },
            choices = { {
                    key = "Dropdowns",
                    text = "Dropdowns"
                }, {
                    key = "HorizontalScroll",
                    text = "Scroll"
                } }
        }
    },
    Audio = {
        {
            type = "slider",
            key = "uiVolume",
            label = "UI Volume",
            layoutOrder = 10,
            default = 50,
            min = 0,
            max = 100,
            increment = 1,
            showPercent = true,
            path = { "Audio", "UIVolume" },

            onChange = function(p38) -- Line: 461, Name: onChange
                local UI = game:GetService("SoundService"):FindFirstChild("UI");

                if UI then
                    UI.Volume = p38 / 100;
                end;
            end
        },
        {
            type = "slider",
            key = "musicVolume",
            label = "Music Volume",
            layoutOrder = 20,
            default = 35,
            min = 0,
            max = 100,
            increment = 1,
            showPercent = true,
            path = { "Audio", "MusicVolume" },

            onChange = function(p39) -- Line: 479, Name: onChange
                local Music = game:GetService("SoundService"):FindFirstChild("Music");

                if Music then
                    Music.Volume = p39 / 100;
                end;
            end
        },
        {
            type = "slider",
            key = "sfxVolume",
            label = "SFX Volume",
            layoutOrder = 30,
            default = 50,
            min = 0,
            max = 100,
            increment = 1,
            showPercent = true,
            path = { "Audio", "SFXVolume" },

            onChange = function(p40) -- Line: 497, Name: onChange
                local SFX = game:GetService("SoundService"):FindFirstChild("SFX");

                if SFX then
                    SFX.Volume = p40 / 100;
                end;
            end
        },
        {
            type = "divider",
            layoutOrder = 35
        },
        {
            type = "toggle",
            key = "enableButtonHoverSounds",
            label = "Enable Button Hover Sounds",
            layoutOrder = 40,
            default = true,
            path = { "Audio", "EnableButtonHoverSounds" },

            onChange = function(p41) -- Line: 515, Name: onChange
                -- upvalues: SoundController (copy)
                SoundController.ButtonHoverSoundsEnabled = p41;
            end
        },
        {
            type = "toggle",
            key = "enableButtonClickSounds",
            label = "Enable Button Click Sounds",
            layoutOrder = 50,
            default = true,
            path = { "Audio", "EnableButtonClickSounds" },

            onChange = function(p42) -- Line: 526, Name: onChange
                -- upvalues: SoundController (copy)
                SoundController.ButtonClickSoundsEnabled = p42;
            end
        }
    },
    World = {
        {
            type = "toggle",
            key = "shadows",
            label = "Shadows",
            layoutOrder = 11,
            default = true,
            path = { "World", "Shadows" },

            onChange = function(p43) -- Line: 539, Name: onChange
                game:GetService("Lighting").GlobalShadows = p43;
            end
        },
        {
            type = "slider",
            key = "clockTime",
            label = "Clock Time",
            layoutOrder = 10,
            default = 14.5,
            min = 0,
            max = 24,
            increment = 0.5,
            path = { "World", "ClockTime" },

            getInitialValue = function(p44) -- Line: 549, Name: getInitialValue
                if typeof(p44) == "number" and p44 >= 0 then
                    return p44;
                end;

                return game:GetService("Lighting").ClockTime;
            end,

            onChange = function(p45) -- Line: 560, Name: onChange
                game:GetService("Lighting").ClockTime = p45;
            end
        },
        {
            type = "divider",
            layoutOrder = 9
        },
        {
            type = "grid",
            key = "map",
            label = "Map",
            layoutOrder = 1,
            default = "baseplate",
            path = { "World", "Map" },

            getItems = function() -- Line: 575, Name: getItems
                return require(script.Parent.Parent.MapController).GetMaps();
            end,

            onSelect = function(p46, p47, p48) -- Line: 579, Name: onSelect
                require(script.Parent.Parent.MapController).LoadMap(p46);
                local ClockTime = game:GetService("Lighting").ClockTime;
                local v49 = p48.Current and p48.Current.Container;
                local v50 = v49 and v49:FindFirstChild("clockTime");

                if v50 then
                    v50:SetAttribute("ExternalValue", ClockTime);
                end;
            end
        }
    }
};
local v65 = {
    {
        type = "toggle",
        key = "cameraFollowHead",
        label = "Camera Follow Head (For Dances)",
        layoutOrder = 1,
        default = false,
        path = { "Camera", "FollowHead" },

        onChange = function(p52, p53) -- Line: 604, Name: onChange
            p53.SetFollowHead(p52 == true);
        end
    },
    {
        type = "divider",
        layoutOrder = 5
    },
    {
        type = "slider",
        key = "fieldOfView",
        label = "Field of View",
        layoutOrder = 10,
        default = 70,
        min = 30,
        max = 120,
        increment = 1,
        path = { "Camera", "FieldOfView" },

        onChange = function(p54) -- Line: 622, Name: onChange
            workspace.CurrentCamera.FieldOfView = p54;
        end
    },
    {
        type = "divider",
        layoutOrder = 15
    },
    {
        type = "slider",
        key = "saturation",
        label = "Saturation",
        layoutOrder = 20,
        default = 0,
        min = -100,
        max = 100,
        increment = 1,
        path = { "Camera", "Saturation" },

        onChange = function(p55) -- Line: 640, Name: onChange
            local ColorCorrection = game:GetService("Lighting"):FindFirstChild("ColorCorrection");

            if ColorCorrection then
                ColorCorrection.Saturation = p55 / 100;
            end;
        end
    },
    {
        type = "slider",
        key = "contrast",
        label = "Contrast",
        layoutOrder = 30,
        default = 0,
        min = -100,
        max = 100,
        increment = 1,
        path = { "Camera", "Contrast" },

        onChange = function(p56) -- Line: 657, Name: onChange
            local ColorCorrection = game:GetService("Lighting"):FindFirstChild("ColorCorrection");

            if ColorCorrection then
                ColorCorrection.Contrast = p56 / 100;
            end;
        end
    },
    {
        type = "slider",
        key = "brightness",
        label = "Brightness",
        layoutOrder = 40,
        default = 0,
        min = -100,
        max = 100,
        increment = 1,
        path = { "Camera", "Brightness" },

        onChange = function(p57) -- Line: 674, Name: onChange
            local ColorCorrection = game:GetService("Lighting"):FindFirstChild("ColorCorrection");

            if ColorCorrection then
                ColorCorrection.Brightness = p57 / 100;
            end;
        end
    },
    {
        type = "divider",
        layoutOrder = 45
    },
    {
        type = "slider",
        key = "bloom",
        label = "Bloom",
        layoutOrder = 50,
        default = 100,
        min = 0,
        max = 100,
        increment = 1,
        showPercent = true,
        path = { "Camera", "Bloom" },

        onChange = function(p58) -- Line: 696, Name: onChange
            local Bloom = game:GetService("Lighting"):FindFirstChild("Bloom");

            if Bloom then
                Bloom.Intensity = p58 / 100;
            end;
        end
    },
    {
        type = "slider",
        key = "blur",
        label = "Blur",
        layoutOrder = 60,
        default = 0,
        min = 0,
        max = 100,
        increment = 1,
        showPercent = true,
        path = { "Camera", "Blur" },

        onChange = function(p59) -- Line: 714, Name: onChange
            local Lighting2 = game:GetService("Lighting");
            local Blur = Lighting2:FindFirstChild("Blur");

            if not Blur then
                Blur = Instance.new("BlurEffect");
                Blur.Name = "Blur";
                Blur.Parent = Lighting2;
            end;

            Blur.Size = p59 / 100 * 24;
        end
    },
    {
        type = "divider",
        layoutOrder = 65
    },
    {
        type = "toggle",
        key = "depthOfField",
        label = "Depth of Field",
        layoutOrder = 70,
        default = false,
        path = { "Camera", "DepthOfField", "Enabled" },

        onChange = function(p60) -- Line: 736, Name: onChange
            -- upvalues: pokeDoF (copy)
            local DepthOfField = game:GetService("Lighting"):FindFirstChild("DepthOfField");

            if DepthOfField then
                DepthOfField.Enabled = p60 == true;
            end;

            pokeDoF();
        end
    },
    {
        type = "slider",
        key = "dofFarIntensity",
        label = "Far Intensity",
        layoutOrder = 80,
        default = 75,
        min = 0,
        max = 100,
        increment = 1,
        showPercent = true,
        path = { "Camera", "DepthOfField", "FarIntensity" },
        visibleWhen = { "depthOfField", true },

        onChange = function(p61) -- Line: 754, Name: onChange
            -- upvalues: pokeDoF (copy)
            local DepthOfField = game:GetService("Lighting"):FindFirstChild("DepthOfField");

            if DepthOfField then
                DepthOfField.FarIntensity = p61 / 100;
            end;

            pokeDoF();
        end
    },
    {
        type = "slider",
        key = "dofNearIntensity",
        label = "Near Intensity",
        layoutOrder = 90,
        default = 75,
        min = 0,
        max = 100,
        increment = 1,
        showPercent = true,
        path = { "Camera", "DepthOfField", "NearIntensity" },
        visibleWhen = { "depthOfField", true },

        onChange = function(p62) -- Line: 772, Name: onChange
            -- upvalues: pokeDoF (copy)
            local DepthOfField = game:GetService("Lighting"):FindFirstChild("DepthOfField");

            if DepthOfField then
                DepthOfField.NearIntensity = p62 / 100;
            end;

            pokeDoF();
        end
    },
    {
        type = "slider",
        key = "dofFocusDistance",
        label = "Focus Distance",
        layoutOrder = 100,
        default = 16,
        min = 0,
        max = 50,
        increment = 0.5,
        path = { "Camera", "DepthOfField", "FocusDistance" },
        visibleWhen = { "depthOfField", true },

        onChange = function(p63) -- Line: 789, Name: onChange
            -- upvalues: pokeDoF (copy)
            local DepthOfField = game:GetService("Lighting"):FindFirstChild("DepthOfField");

            if DepthOfField then
                DepthOfField.FocusDistance = p63;
            end;

            pokeDoF();
        end
    },
    {
        type = "slider",
        key = "dofInFocusRadius",
        label = "In Focus Radius",
        layoutOrder = 110,
        default = 30,
        min = 0,
        max = 50,
        increment = 1,
        path = { "Camera", "DepthOfField", "InFocusRadius" },
        visibleWhen = { "depthOfField", true },

        onChange = function(p64) -- Line: 806, Name: onChange
            -- upvalues: pokeDoF (copy)
            local DepthOfField = game:GetService("Lighting"):FindFirstChild("DepthOfField");

            if DepthOfField then
                DepthOfField.InFocusRadius = p64;
            end;

            pokeDoF();
        end
    }
};
local v66 = {
    type = "slider",
    key = "cameraOffsetX",
    label = "X Offset",
    layoutOrder = 120,
    default = 0,
    min = -10,
    max = 10,
    increment = 0.1,
    path = { "Camera", "OffsetX" }
};
local u67 = "X";

function v66.onChange(p68, p69) -- Line: 68
    -- upvalues: LocalPlayer (copy), u67 (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    local v70 = Character:FindFirstChildWhichIsA("Humanoid");

    if not v70 then
        return;
    end;

    local v71 = u67 ~= "X" and (p69.GetSetting({ "Camera", "OffsetX" }) or 0) or p68;
    local v72 = u67 ~= "Y" and (p69.GetSetting({ "Camera", "OffsetY" }) or 0) or p68;
    local v73 = u67 ~= "Z" and (p69.GetSetting({ "Camera", "OffsetZ" }) or 0) or p68;
    v70.CameraOffset = Vector3.new(v71, v72, v73);
end;

local v74 = {
    type = "slider",
    key = "cameraOffsetY",
    label = "Y Offset",
    layoutOrder = 130,
    default = 0,
    min = -10,
    max = 10,
    increment = 0.1,
    path = { "Camera", "OffsetY" }
};
local u75 = "Y";

function v74.onChange(p76, p77) -- Line: 68
    -- upvalues: LocalPlayer (copy), u75 (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    local v78 = Character:FindFirstChildWhichIsA("Humanoid");

    if not v78 then
        return;
    end;

    local v79 = u75 ~= "X" and (p77.GetSetting({ "Camera", "OffsetX" }) or 0) or p76;
    local v80 = u75 ~= "Y" and (p77.GetSetting({ "Camera", "OffsetY" }) or 0) or p76;
    local v81 = u75 ~= "Z" and (p77.GetSetting({ "Camera", "OffsetZ" }) or 0) or p76;
    v78.CameraOffset = Vector3.new(v79, v80, v81);
end;

local v82 = {
    type = "slider",
    key = "cameraOffsetZ",
    label = "Z Offset",
    layoutOrder = 140,
    default = 0,
    min = -10,
    max = 10,
    increment = 0.1,
    path = { "Camera", "OffsetZ" }
};
local u83 = "Z";

function v82.onChange(p84, p85) -- Line: 68
    -- upvalues: LocalPlayer (copy), u83 (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    local v86 = Character:FindFirstChildWhichIsA("Humanoid");

    if not v86 then
        return;
    end;

    local v87 = u83 ~= "X" and (p85.GetSetting({ "Camera", "OffsetX" }) or 0) or p84;
    local v88 = u83 ~= "Y" and (p85.GetSetting({ "Camera", "OffsetY" }) or 0) or p84;
    local v89 = u83 ~= "Z" and (p85.GetSetting({ "Camera", "OffsetZ" }) or 0) or p84;
    v86.CameraOffset = Vector3.new(v87, v88, v89);
end;

v65[17], v65[18], v65[19], v65[20] = {
    type = "divider",
    layoutOrder = 115
}, v66, v74, v82;
v51.Camera = v65;
v51.Miscellaneous = {
    {
        type = "dropdown",
        key = "defaultSaveAsGameOutfit",
        label = "Save Outfits to Game",
        layoutOrder = 0,
        default = "Ask",
        path = { "Miscellaneous", "DefaultSaveAsGameOutfit" },
        choices = { {
                key = "Ask",
                text = "Ask"
            }, {
                key = "Always",
                text = "Always"
            }, {
                key = "Never",
                text = "Never"
            } }
    },
    {
        type = "toggle",
        key = "wearLatestOutfitOnReset",
        label = "Always Wear Latest Outfit on Reset",
        layoutOrder = 1,
        default = false,
        path = { "Miscellaneous", "WearLatestOutfitOnReset" }
    },
    {
        type = "toggle",
        key = "previewCurrentlyWearing",
        label = "Preview Items in Currently Wearing",
        layoutOrder = 2,
        default = false,
        path = { "Interface", "PreviewCurrentlyWearing" }
    },
    {
        type = "divider",
        layoutOrder = 3
    },
    {
        type = "toggle",
        key = "enableLikeVFX",
        label = "Enable Like VFX",
        layoutOrder = 4,
        default = true,
        path = { "Miscellaneous", "EnableLikeVFX" }
    },
    {
        type = "toggle",
        key = "enableOutfitUpdateVFX",
        label = "Enable Outfit Update VFX",
        layoutOrder = 5,
        default = true,
        path = { "Miscellaneous", "EnableOutfitUpdateVFX" }
    },
    {
        type = "toggle",
        key = "gearScriptsInPrivateServer",
        label = "Gear Scripts in Private Server",
        layoutOrder = 6,
        default = true,
        path = { "Miscellaneous", "GearScriptsInPrivateServer" }
    },
    {
        type = "divider",
        layoutOrder = 7
    },
    {
        type = "toggle",
        key = "hideOtherPlayers",
        label = "Hide Other Players",
        layoutOrder = 8,
        default = false,
        path = { "Miscellaneous", "HideOtherPlayers" },

        onChange = function(p90) -- Line: 922, Name: onChange
            local Players = game:GetService("Players");
            local LocalPlayer2 = Players.LocalPlayer;
            local HiddenPlayers = game:GetService("ReplicatedStorage"):FindFirstChild("HiddenPlayers");

            if not HiddenPlayers then
                HiddenPlayers = Instance.new("Folder");
                HiddenPlayers.Name = "HiddenPlayers";
                HiddenPlayers.Parent = game:GetService("ReplicatedStorage");
            end;

            for _, v in Players:GetPlayers() do
                if v ~= LocalPlayer2 then
                    if p90 then
                        v:SetAttribute("isHidden", true);

                        if v.Character then
                            v.Character.Parent = HiddenPlayers;
                        end;
                    else
                        v:SetAttribute("isHidden", nil);

                        if v.Character then
                            v.Character.Parent = workspace;
                        end;
                    end;
                end;
            end;
        end
    },
    {
        type = "toggle",
        key = "showActivityAboveHead",
        label = "Show Activity Above Head",
        layoutOrder = 9,
        default = false,
        path = { "Miscellaneous", "ShowActivityAboveHead" },

        onChange = function(p91) -- Line: 955, Name: onChange
            require(script.Parent.Parent.OverheadStatusController).SetEnabled(p91);
        end
    },
    {
        type = "toggle",
        key = "hidePlayerNametags",
        label = "Hide Player Nametags",
        layoutOrder = 10,
        default = false,
        path = { "Miscellaneous", "HidePlayerNametags" },

        onChange = function(p92) -- Line: 966, Name: onChange
            local Players = game:GetService("Players");
            local LocalPlayer2 = Players.LocalPlayer;
            local v93;

            if p92 then
                v93 = Enum.HumanoidDisplayDistanceType.None;
            else
                v93 = Enum.HumanoidDisplayDistanceType.Viewer;
            end;

            for _, v in Players:GetPlayers() do
                if v ~= LocalPlayer2 then
                    local Character = v.Character;

                    if Character then
                        Character = Character:FindFirstChildWhichIsA("Humanoid");
                    end;

                    if Character then
                        Character.DisplayDistanceType = v93;
                    end;
                end;
            end;
        end
    },
    {
        type = "toggle",
        key = "hidePurchaseAnnouncements",
        label = "Hide Purchase Announcements",
        layoutOrder = 11,
        default = false,
        path = { "Miscellaneous", "HidePurchaseAnnouncements" }
    },
    {
        type = "divider",
        layoutOrder = 12
    },
    {
        type = "toggle",
        key = "hideBlocksInTransformMode",
        label = "Hide Blocks in Transform Mode",
        layoutOrder = 13,
        default = true,
        path = { "Miscellaneous", "HideBlocksInTransformMode" },

        onChange = function(p94) -- Line: 1001, Name: onChange
            require(script.Parent.Parent.AvatarAdjustmentController.TransformModeController):SetBlocksHidden(p94);
        end
    }
};

return v51;