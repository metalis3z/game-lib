-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local Modules = require(script.Parent.Parent.Modules);
local Definitions = require(script.Definitions);
local Helpers = require(script.Helpers);
local ThemeController = require(script.Parent.ThemeController);
local DraggablePanel = require(Modules.Utilities.DraggablePanel);
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local Settings = PlayerGui:WaitForChild("Settings");
local container = Settings:WaitForChild("container");
local wrapper = container:WaitForChild("wrapper");
local header = wrapper:WaitForChild("header");
local current = wrapper:WaitForChild("current");
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local Events = script.Parent.Parent:WaitForChild("Events");
local u1 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
header.Active = true;
local u2 = DraggablePanel.new(header, container, {
    ScreenGui = Settings
});
local u3 = {
    Settings = nil,
    IsOpen = false,
    Current = {},
    LocalValues = {}
};
local settingsLoadedEvent = Instance.new("BindableEvent");
local settingsLoading = false;

function u3.SettingsUpdated(p4) -- Line: 36
    -- upvalues: u3 (copy)
    if typeof(p4) == "table" then
        u3.Settings = p4;
        settingsLoadedEvent:Fire();
    end;
end;

function u3.UpdateSettings(p5) -- Line: 40
    -- upvalues: Remotes (copy), u3 (copy)
    local v6, v7 = Remotes.UpdateSettings:InvokeServer(p5);

    if v6 == false then
        warn("error updating settings:", v7, p5);

        return v6, v7;
    end;

    if v6 == true and typeof(v7) == "table" then
        u3.Settings = v7;
    end;

    return v6, v7;
end;

function u3.GetSettings() -- Line: 52
    -- Share one request between all controllers that initialize together.
    if u3.Settings ~= nil then
        return u3.Settings;
    end;

    if settingsLoading then
        settingsLoadedEvent.Event:Wait();

        return u3.Settings or {};
    end;

    settingsLoading = true;
    local loadedSettings = nil;

    for attempt = 1, 4 do
        local success, result = pcall(function()
            return Remotes.GetSettings:InvokeServer();
        end);

        if success and typeof(result) == "table" then
            loadedSettings = result;
            break;
        end;

        task.wait(math.min(0.25 * 2 ^ (attempt - 1), 2));
    end;

    u3.Settings = loadedSettings or {};
    settingsLoading = false;
    settingsLoadedEvent:Fire();

    return u3.Settings;
end;

function u3.GetSetting(p9) -- Line: 64
    -- upvalues: u3 (copy)
    local v10 = u3.GetSettings();

    for _, v in p9 do
        if typeof(v10) ~= "table" or v10[v] == nil then
            return nil;
        end;

        v10 = v10[v];
    end;

    return v10;
end;

local function capitalizeFirst(p11) -- Line: 77
    return string.upper((string.sub(p11, 1, 1))) .. string.sub(p11, 2);
end;

local function cleanupCurrent() -- Line: 81
    -- upvalues: u3 (copy)
    if u3.Current.Connections then
        for _, v in u3.Current.Connections do
            v:Disconnect();
        end;
    end;

    if u3.Current.Objects then
        for _, v in u3.Current.Objects do
            if v.Cleanup == nil then
                if v.Destroy ~= nil then
                    v:Destroy();
                end;
            else
                v:Cleanup();
            end;
        end;
    end;
end;

local function setupCategoryButtons(p12, p13) -- Line: 99
    -- upvalues: u3 (copy), TweenService (copy), u1 (copy)
    for _, child in p12:GetChildren() do
        if child:IsA("TextButton") then
            table.insert(p13.connections, child.Activated:Connect(function() -- Line: 103
                -- upvalues: u3 (ref), child (copy)
                u3.SetCategory(child.Name);
            end));
            table.insert(p13.connections, child.MouseEnter:Connect(function() -- Line: 106
                -- upvalues: TweenService (ref), child (copy), u1 (ref)
                TweenService:Create(child.back.UIStroke, u1, {
                    Transparency = 0.1
                }):Play();
                TweenService:Create(child.back.UIGradient, u1, {
                    Offset = Vector2.new(0, 0.2)
                }):Play();
            end));
            table.insert(p13.connections, child.MouseLeave:Connect(function() -- Line: 110
                -- upvalues: TweenService (ref), child (copy), u1 (ref)
                TweenService:Create(child.back.UIStroke, u1, {
                    Transparency = 0.62
                }):Play();
                TweenService:Create(child.back.UIGradient, u1, {
                    Offset = Vector2.new(0, 0)
                }):Play();
            end));
            table.insert(p13.connections, child.MouseButton1Down:Connect(function() -- Line: 114
                -- upvalues: TweenService (ref), child (copy), u1 (ref)
                TweenService:Create(child.back.UIGradient, u1, {
                    Offset = Vector2.new(0, 0.35)
                }):Play();
            end));
            table.insert(p13.connections, child.MouseButton1Up:Connect(function() -- Line: 117
                -- upvalues: TweenService (ref), child (copy), u1 (ref)
                TweenService:Create(child.back.UIGradient, u1, {
                    Offset = Vector2.new(0, 0.2)
                }):Play();
            end));
        end;
    end;
end;

function u3.SetCategory(p14) -- Line: 125
    -- upvalues: current (copy), cleanupCurrent (copy), u3 (copy), Events (copy), header (copy), setupCategoryButtons (copy), Definitions (copy), Helpers (copy)
    local v15 = string.upper((string.sub(p14, 1, 1))) .. string.sub(p14, 2);

    for _, child in current:GetChildren() do
        if child:IsA("Frame") or child:IsA("ScrollingFrame") then
            child:Destroy();
        end;
    end;

    cleanupCurrent();
    u3.Current = {
        Name = v15,
        Connections = {},
        Objects = {}
    };
    local v16 = {
        connections = u3.Current.Connections,
        objects = u3.Current.Objects,
        controller = u3,
        events = Events
    };

    if v15 == "Categories" then
        header.returnButton.Visible = false;
    else
        header.returnButton.Visible = true;
        table.insert(v16.connections, header.returnButton.Activated:Connect(function() -- Line: 153
            -- upvalues: u3 (ref)
            u3.SetCategory("Categories");
        end));
    end;

    table.insert(v16.connections, header.closeButton.Activated:Connect(function() -- Line: 160
        -- upvalues: u3 (ref)
        u3.Close();
    end));
    local v17 = nil;

    if v15 == "Categories" then
        v17 = script:FindFirstChild("Categories"):Clone();
        setupCategoryButtons(v17, v16);
    else
        local v18 = Definitions[v15];

        if v18 and #v18 > 0 then
            v17 = Helpers.Build(v15, v18, v16);
        end;
    end;

    if not v17 then
        warn("no settings definitions for", v15);

        return;
    end;

    v17.Parent = current;
    u3.Current.Container = v17;
end;

function u3.Open() -- Line: 186
    -- upvalues: u3 (copy), u2 (copy), container (copy), Settings (copy), Events (copy), TweenService (copy), u1 (copy)
    if u3.IsOpen == true then
        return;
    end;

    if u3.IsClosing == true then
        return;
    end;

    u2:Reset();
    container.GroupTransparency = 1;
    container.Position = UDim2.new(0.5, 0, 0.51, 0);
    Settings.Enabled = true;
    Events.InterfaceAction:Fire("Add", script.Name, u3.Close);
    Events.SetButtonsVisible:Fire("All", { "resetAvatar", "saveOutfit", "adjustAccessories", "currentlyWearing" });
    TweenService:Create(container, u1, {
        GroupTransparency = 0,
        Position = UDim2.fromScale(0.5, 0.5)
    }):Play();
    u3.SetCategory("Categories");
    u3.IsOpen = true;
end;

function u3.Close(p19) -- Line: 209
    -- upvalues: u3 (copy), Events (copy), TweenService (copy), container (copy), u1 (copy), Settings (copy)
    if u3.IsOpen == false then
        return;
    end;

    if u3.IsClosing == true then
        return;
    end;

    u3.IsClosing = true;
    Events.InterfaceAction:Fire("Remove", script.Name);

    if p19 ~= true then
        Events.SetButtonsVisible:Fire("All");
    end;

    local v20 = TweenService:Create(container, u1, {
        GroupTransparency = 1
    });
    v20:Play();
    u3.IsOpen = false;
    v20.Completed:Once(function() -- Line: 222
        -- upvalues: u3 (ref), Settings (ref)
        if u3.IsOpen ~= true then
            Settings.Enabled = false;
            u3.IsClosing = false;
        end;
    end);
end;

local u21 = nil;

local function applyFollowHeadToCharacter(u22, p23) -- Line: 234
    -- upvalues: u21 (ref), LocalPlayer (copy), u3 (copy)
    if u21 then
        u21:Disconnect();
        u21 = nil;
    end;

    if not u22 then
        return;
    end;

    local CurrentCamera = workspace.CurrentCamera;
    local v24 = u22:FindFirstChildWhichIsA("Humanoid");

    if not (CurrentCamera and v24) then
        return;
    end;

    if not p23 then
        CurrentCamera.CameraSubject = v24;

        return;
    end;

    u21 = u22.ChildAdded:Connect(function(p25) -- Line: 251
        -- upvalues: LocalPlayer (ref), u22 (copy), u3 (ref)
        if p25.Name ~= "Head" or not p25:IsA("BasePart") then
            return;
        end;

        if LocalPlayer.Character ~= u22 then
            return;
        end;

        if u3.GetSetting({ "Camera", "FollowHead" }) ~= true then
            return;
        end;

        workspace.CurrentCamera.CameraSubject = p25;
    end);
    local Head = u22:FindFirstChild("Head");

    if Head and Head:IsA("BasePart") then
        CurrentCamera.CameraSubject = Head;
    end;
end;

function u3.SetFollowHead(p26) -- Line: 264
    -- upvalues: applyFollowHeadToCharacter (copy), LocalPlayer (copy)
    applyFollowHeadToCharacter(LocalPlayer.Character, p26 == true);
end;

function u3.ApplyVisualSettings() -- Line: 273
    -- upvalues: u3 (copy)
    local Lighting = game:GetService("Lighting");
    local v27 = u3.GetSetting({ "World", "Shadows" });

    if typeof(v27) == "boolean" then
        Lighting.GlobalShadows = v27;
    end;

    local v28 = u3.GetSetting({ "World", "ClockTime" });

    if typeof(v28) == "number" and v28 >= 0 then
        Lighting.ClockTime = v28;
    end;

    local CurrentCamera = workspace.CurrentCamera;
    local v29 = u3.GetSetting({ "Camera", "FieldOfView" });

    if typeof(v29) == "number" and CurrentCamera then
        CurrentCamera.FieldOfView = v29;
    end;

    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");

    if ColorCorrection then
        local v30 = u3.GetSetting({ "Camera", "Saturation" });
        local v31 = u3.GetSetting({ "Camera", "Contrast" });
        local v32 = u3.GetSetting({ "Camera", "Brightness" });

        if typeof(v30) == "number" then
            ColorCorrection.Saturation = v30 / 100;
        end;

        if typeof(v31) == "number" then
            ColorCorrection.Contrast = v31 / 100;
        end;

        if typeof(v32) == "number" then
            ColorCorrection.Brightness = v32 / 100;
        end;
    end;

    local Bloom = Lighting:FindFirstChild("Bloom");

    if Bloom then
        local v33 = u3.GetSetting({ "Camera", "Bloom" });

        if typeof(v33) == "number" then
            Bloom.Intensity = v33 / 100;
        end;
    end;

    local v34 = u3.GetSetting({ "Camera", "Blur" });

    if typeof(v34) == "number" then
        local Blur = Lighting:FindFirstChild("Blur");

        if not Blur and v34 > 0 then
            Blur = Instance.new("BlurEffect");
            Blur.Name = "Blur";
            Blur.Parent = Lighting;
        end;

        if Blur then
            Blur.Size = v34 / 100 * 24;
        end;
    end;
end;

local function applyCharacterSettings(p35) -- Line: 331
    -- upvalues: u3 (copy), applyFollowHeadToCharacter (copy)
    local Humanoid = p35:WaitForChild("Humanoid", 5);

    if not Humanoid then
        return;
    end;

    local v36 = u3.GetSettings();

    if not v36 then
        return;
    end;

    local Profile = v36.Profile;

    if not Profile then
        return;
    end;

    if Profile.Speed ~= nil then
        Humanoid.WalkSpeed = Profile.Speed;
    end;

    if Profile.JumpPower ~= nil then
        Humanoid.UseJumpPower = true;
        Humanoid.JumpPower = Profile.JumpPower;
    end;

    if Profile.Gravity ~= nil then
        workspace.Gravity = Profile.Gravity;
    end;

    local Camera = v36.Camera;

    if Camera then
        local v37 = Camera.OffsetX or 0;
        local v38 = Camera.OffsetY or 0;
        local v39 = Camera.OffsetZ or 0;

        if v37 ~= 0 or (v38 ~= 0 or v39 ~= 0) then
            Humanoid.CameraOffset = Vector3.new(v37, v38, v39);
        end;

        applyFollowHeadToCharacter(p35, Camera.FollowHead == true);
    end;

    u3.ApplyVisualSettings();
end;

Settings.Enabled = false;
Remotes.SettingsUpdated.OnClientEvent:Connect(u3.SettingsUpdated);
Events.GetSetting.OnInvoke = u3.GetSetting;
Events.GetSetting:SetAttribute("bound", true);
task.spawn(function() -- Line: 378, Name: applyDepthOfField
    -- upvalues: u3 (copy)
    local v40 = u3.GetSettings();
    local v41 = v40 and v40.Camera and v40.Camera.DepthOfField;

    if not v41 then
        return;
    end;

    local DepthOfField = game:GetService("Lighting"):FindFirstChild("DepthOfField");

    if not DepthOfField then
        return;
    end;

    DepthOfField.Enabled = v41.Enabled == true;

    if v41.FarIntensity ~= nil then
        DepthOfField.FarIntensity = v41.FarIntensity / 100;
    end;

    if v41.NearIntensity ~= nil then
        DepthOfField.NearIntensity = v41.NearIntensity / 100;
    end;

    if v41.FocusDistance ~= nil then
        DepthOfField.FocusDistance = v41.FocusDistance;
    end;

    if v41.InFocusRadius ~= nil then
        DepthOfField.InFocusRadius = v41.InFocusRadius;
    end;
end);

local function isHideOtherPlayersEnabled() -- Line: 398
    -- upvalues: u3 (copy)
    local Settings2 = u3.Settings;

    if Settings2 and Settings2.Miscellaneous then
        return Settings2.Miscellaneous.HideOtherPlayers == true;
    end;

    return false;
end;

local function getHiddenFolder() -- Line: 406
    -- upvalues: ReplicatedStorage (copy)
    local HiddenPlayers = ReplicatedStorage:FindFirstChild("HiddenPlayers");

    if not HiddenPlayers then
        HiddenPlayers = Instance.new("Folder");
        HiddenPlayers.Name = "HiddenPlayers";
        HiddenPlayers.Parent = ReplicatedStorage;
    end;

    return HiddenPlayers;
end;

local function isHidePlayerNametagsEnabled() -- Line: 416
    -- upvalues: u3 (copy)
    local Settings2 = u3.Settings;

    if Settings2 and Settings2.Miscellaneous then
        return Settings2.Miscellaneous.HidePlayerNametags == true;
    end;

    return false;
end;

local function applyNametagToCharacter(p42) -- Line: 424
    -- upvalues: u3 (copy)
    local v43 = p42:FindFirstChildWhichIsA("Humanoid") or p42:WaitForChild("Humanoid", 5);

    if not v43 then
        return;
    end;

    local Settings2 = u3.Settings;
    local v44;

    if Settings2 and Settings2.Miscellaneous then
        v44 = Settings2.Miscellaneous.HidePlayerNametags == true;
    else
        v44 = false;
    end;

    local v45;

    if v44 then
        v45 = Enum.HumanoidDisplayDistanceType.None;
    else
        v45 = Enum.HumanoidDisplayDistanceType.Viewer;
    end;

    v43.DisplayDistanceType = v45;
end;

local function onOtherCharacterAdded(p46, p47) -- Line: 433
    -- upvalues: LocalPlayer (copy), u3 (copy), ReplicatedStorage (copy)
    if p46 == LocalPlayer then
        return;
    end;

    local v48 = p47:FindFirstChildWhichIsA("Humanoid") or p47:WaitForChild("Humanoid", 5);

    if v48 then
        local Settings2 = u3.Settings;
        local v49;

        if Settings2 and Settings2.Miscellaneous then
            v49 = Settings2.Miscellaneous.HidePlayerNametags == true;
        else
            v49 = false;
        end;

        local v50;

        if v49 then
            v50 = Enum.HumanoidDisplayDistanceType.None;
        else
            v50 = Enum.HumanoidDisplayDistanceType.Viewer;
        end;

        v48.DisplayDistanceType = v50;
    end;

    local Settings2 = u3.Settings;
    local v51;

    if Settings2 and Settings2.Miscellaneous then
        v51 = Settings2.Miscellaneous.HideOtherPlayers == true;
    else
        v51 = false;
    end;

    if not v51 then
        return;
    end;

    p46:SetAttribute("isHidden", true);
    local HiddenPlayers = ReplicatedStorage:FindFirstChild("HiddenPlayers");

    if not HiddenPlayers then
        HiddenPlayers = Instance.new("Folder");
        HiddenPlayers.Name = "HiddenPlayers";
        HiddenPlayers.Parent = ReplicatedStorage;
    end;

    p47.Parent = HiddenPlayers;
end;

local function onOtherPlayerAdded(u52) -- Line: 441
    -- upvalues: LocalPlayer (copy), u3 (copy), ReplicatedStorage (copy)
    if u52 == LocalPlayer then
        return;
    end;

    u52.CharacterAdded:Connect(function(p53) -- Line: 443
        -- upvalues: u52 (copy), LocalPlayer (ref), u3 (ref), ReplicatedStorage (ref)
        local v54 = u52;

        if v54 == LocalPlayer then
            return;
        end;

        local v55 = p53:FindFirstChildWhichIsA("Humanoid") or p53:WaitForChild("Humanoid", 5);

        if v55 then
            local Settings2 = u3.Settings;
            local v56;

            if Settings2 and Settings2.Miscellaneous then
                v56 = Settings2.Miscellaneous.HidePlayerNametags == true;
            else
                v56 = false;
            end;

            local v57;

            if v56 then
                v57 = Enum.HumanoidDisplayDistanceType.None;
            else
                v57 = Enum.HumanoidDisplayDistanceType.Viewer;
            end;

            v55.DisplayDistanceType = v57;
        end;

        local Settings2 = u3.Settings;
        local v58;

        if Settings2 and Settings2.Miscellaneous then
            v58 = Settings2.Miscellaneous.HideOtherPlayers == true;
        else
            v58 = false;
        end;

        if not v58 then
            return;
        end;

        v54:SetAttribute("isHidden", true);
        local HiddenPlayers = ReplicatedStorage:FindFirstChild("HiddenPlayers");

        if not HiddenPlayers then
            HiddenPlayers = Instance.new("Folder");
            HiddenPlayers.Name = "HiddenPlayers";
            HiddenPlayers.Parent = ReplicatedStorage;
        end;

        p53.Parent = HiddenPlayers;
    end);

    if u52.Character then
        local Character = u52.Character;
        local v59 = Character:FindFirstChildWhichIsA("Humanoid") or Character:WaitForChild("Humanoid", 5);

        if v59 then
            local Settings2 = u3.Settings;
            local v60;

            if Settings2 and Settings2.Miscellaneous then
                v60 = Settings2.Miscellaneous.HidePlayerNametags == true;
            else
                v60 = false;
            end;

            local v61;

            if v60 then
                v61 = Enum.HumanoidDisplayDistanceType.None;
            else
                v61 = Enum.HumanoidDisplayDistanceType.Viewer;
            end;

            v59.DisplayDistanceType = v61;
        end;

        local Settings2 = u3.Settings;
        local v62;

        if Settings2 and Settings2.Miscellaneous then
            v62 = Settings2.Miscellaneous.HideOtherPlayers == true;
        else
            v62 = false;
        end;

        if v62 then
            u52:SetAttribute("isHidden", true);
            local Character2 = u52.Character;
            local HiddenPlayers = ReplicatedStorage:FindFirstChild("HiddenPlayers");

            if not HiddenPlayers then
                HiddenPlayers = Instance.new("Folder");
                HiddenPlayers.Name = "HiddenPlayers";
                HiddenPlayers.Parent = ReplicatedStorage;
            end;

            Character2.Parent = HiddenPlayers;
        end;
    end;
end;

Players.PlayerAdded:Connect(onOtherPlayerAdded);
LocalPlayer.CharacterAdded:Connect(applyCharacterSettings);
task.spawn(function() -- Line: 462
    -- upvalues: u3 (copy), Players (copy), LocalPlayer (copy), onOtherPlayerAdded (copy), applyCharacterSettings (copy)
    u3.Settings = u3.GetSettings();

    for _, v in Players:GetPlayers() do
        if v ~= LocalPlayer then
            onOtherPlayerAdded(v);
        end;
    end;

    if LocalPlayer.Character then
        applyCharacterSettings(LocalPlayer.Character);
    end;
end);
task.spawn(function() -- Line: 478
    -- upvalues: u3 (copy), ThemeController (copy), PlayerGui (copy), Definitions (copy)
    local v63 = u3.GetSettings();

    if not (v63 and v63.Interface) then
        return;
    end;

    local Theme = v63.Interface.Theme;

    if Theme and Theme ~= "Dark" then
        ThemeController.SetTheme(Theme);
    end;

    local AvatarSectionBackground = v63.Interface.AvatarSectionBackground;

    if AvatarSectionBackground and AvatarSectionBackground ~= "" then
        local Catalog = PlayerGui:WaitForChild("Catalog", 10);

        if not Catalog then
            return;
        end;

        local v64 = Catalog:WaitForChild("container", 5) and (Catalog.container:WaitForChild("avatarSection", 5) and Catalog.container.avatarSection:WaitForChild("preview", 5)) and Catalog.container.avatarSection.preview:FindFirstChild("background");

        if v64 then
            require(script.Parent.ProfileBackgroundController).ApplyToPreview(AvatarSectionBackground);
        end;
    end;

    if v63.Interface.AvatarPreviewOnRight == true then
        PlayerGui:WaitForChild("Catalog", 10);
        PlayerGui:WaitForChild("SavedOutfits", 10);
        PlayerGui:WaitForChild("CommunityOutfits", 10);

        for _, v in Definitions.Interface do
            if v.key == "avatarPreviewOnRight" and v.onChange then
                v.onChange(true, u3);

                return;
            end;
        end;
    end;
end);

return u3;