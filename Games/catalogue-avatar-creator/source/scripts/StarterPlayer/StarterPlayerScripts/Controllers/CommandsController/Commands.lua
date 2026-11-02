-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local HttpService = game:GetService("HttpService");
local LocalPlayer = Players.LocalPlayer;
local Events = script.Parent.Parent.Parent.Events;
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local TryOnItem = Remotes:WaitForChild("TryOnItem");
local SetBodyAdjustment = Remotes:WaitForChild("SetBodyAdjustment");
local UpdateSettings = Remotes:WaitForChild("UpdateSettings");
local Freecam = require(script.Freecam);
local Fly = require(script.Fly);
local u1 = {};
local u2 = {};
local u3 = {};
local u4 = false;
local u5 = false;
local u6 = nil;
local u7 = nil;

local function getAnimator(p8) -- Line: 26
    if p8 then
        p8 = p8:FindFirstChildWhichIsA("Humanoid");
    end;

    if p8 then
        return p8, p8:FindFirstChildWhichIsA("Animator");
    end;

    return nil, nil;
end;

local function ensureCloneAnimator(p9) -- Line: 32
    if p9 then
        p9 = p9:FindFirstChildWhichIsA("Humanoid");
    end;

    local v10;

    if p9 then
        v10 = p9:FindFirstChildWhichIsA("Animator");
    else
        p9 = nil;
        v10 = nil;
    end;

    if not p9 then
        return nil;
    end;

    if not v10 then
        v10 = Instance.new("Animator");
        v10.Parent = p9;
    end;

    return v10;
end;

local function ensurePoseRenderStep() -- Line: 42
    -- upvalues: u4 (ref), RunService (copy), u3 (copy)
    if u4 then
        return;
    end;

    u4 = true;
    RunService:BindToRenderStep("CommandsClonePoseOverride", Enum.RenderPriority.Character.Value + 1, function() -- Line: 45
        -- upvalues: u3 (ref)
        for i, v in u3 do
            if i and i.Parent then
                i.C0 = v;
            else
                u3[i] = nil;
            end;
        end;
    end);
end;

local function mirrorPlayerPoseOnClone(p11) -- Line: 56
    -- upvalues: LocalPlayer (copy), u3 (copy), u4 (ref), RunService (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    local v12 = {};

    for _, descendant in Character:GetDescendants() do
        if descendant:IsA("Motor6D") then
            v12[descendant.Name] = descendant;
        end;
    end;

    for _, descendant in p11:GetDescendants() do
        if descendant:IsA("Motor6D") then
            local v13 = v12[descendant.Name];

            if v13 then
                u3[descendant] = v13.C0;
                descendant.C0 = v13.C0;
            end;

            descendant.CurrentAngle = 0;
            descendant.DesiredAngle = 0;
            descendant.MaxVelocity = 1000;
            descendant.Transform = CFrame.new();
            descendant:GetPropertyChangedSignal("CurrentAngle"):Connect(function() -- Line: 78
                -- upvalues: descendant (copy)
                descendant.CurrentAngle = 0;
            end);
            descendant:GetPropertyChangedSignal("DesiredAngle"):Connect(function() -- Line: 81
                -- upvalues: descendant (copy)
                descendant.DesiredAngle = 0;
            end);
        end;
    end;

    if u4 then
        return;
    end;

    u4 = true;
    RunService:BindToRenderStep("CommandsClonePoseOverride", Enum.RenderPriority.Character.Value + 1, function() -- Line: 45
        -- upvalues: u3 (ref)
        for i, v in u3 do
            if i and i.Parent then
                i.C0 = v;
            else
                u3[i] = nil;
            end;
        end;
    end);
end;

local function playPlayerAnimationsOn(p14, p15, p16) -- Line: 89
    -- upvalues: LocalPlayer (copy), RunService (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChildWhichIsA("Humanoid");
    end;

    local v17;

    if Character then
        v17 = Character:FindFirstChildWhichIsA("Animator");
    else
        v17 = nil;
    end;

    if not v17 then
        return {};
    end;

    local v18 = {};
    local u19 = {};

    for _, v in v17:GetPlayingAnimationTracks() do
        if v.Animation then
            local v20 = p14:LoadAnimation(v.Animation);
            v20.Priority = p15 or v.Priority;
            v20:Play(0, p16 or v.WeightCurrent, v.Speed);
            v20.TimePosition = v.TimePosition;
            table.insert(v18, v20);
            u19[v20] = v.TimePosition;
        end;
    end;

    task.spawn(function() -- Line: 104
        -- upvalues: RunService (ref), u19 (copy)
        RunService.RenderStepped:Wait();

        for i, v in u19 do
            if i.IsPlaying then
                i.TimePosition = v;
            end;
        end;
    end);

    return v18;
end;

local function stopSyncedTracks(p21) -- Line: 113
    -- upvalues: u2 (copy)
    local v22 = u2[p21];

    if not v22 then
        return;
    end;

    for _, v in v22 do
        v:Stop(0);
    end;

    u2[p21] = nil;
end;

local function pruneClones() -- Line: 120
    -- upvalues: u1 (copy), u2 (copy)
    for i = #u1, 1, -1 do
        local v23 = u1[i];

        if not v23.Parent then
            table.remove(u1, i);
            u2[v23] = nil;
        end;
    end;
end;

local function getNearestClone() -- Line: 130
    -- upvalues: LocalPlayer (copy), u1 (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return nil;
    end;

    local Position = Character.Position;
    local v24 = (1 / 0);
    local v25 = nil;

    for _, v in u1 do
        local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart", true);

        if HumanoidRootPart then
            local Magnitude = (HumanoidRootPart.Position - Position).Magnitude;

            if Magnitude < v24 then
                v25 = v;
                v24 = Magnitude;
            end;
        end;
    end;

    return v25;
end;

local function selectClones(p26) -- Line: 149
    -- upvalues: pruneClones (copy), u1 (copy), getNearestClone (copy)
    pruneClones();

    if p26 and p26:lower() == "all" then
        return table.clone(u1);
    end;

    local v27 = getNearestClone();

    return v27 and { v27 } or {};
end;

local function getNearestPlayer() -- Line: 158
    -- upvalues: LocalPlayer (copy), Players (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return nil;
    end;

    local Position = Character.Position;
    local v28 = (1 / 0);
    local v29 = nil;

    for _, v in Players:GetPlayers() do
        if v ~= LocalPlayer then
            local v30 = v.Character and v.Character:FindFirstChild("HumanoidRootPart");

            if v30 then
                local Magnitude = (v30.Position - Position).Magnitude;

                if Magnitude < v28 then
                    v29 = v;
                    v28 = Magnitude;
                end;
            end;
        end;
    end;

    return v29;
end;

local function fuzzyFindPlayer(p31, p32) -- Line: 178
    -- upvalues: Players (copy), LocalPlayer (copy)
    local v33 = p31:lower();
    local v34 = 0;
    local v35 = nil;

    for _, v in Players:GetPlayers() do
        if p32 or v ~= LocalPlayer then
            for _, v2 in { v.Name:lower(), v.DisplayName:lower() } do
                local v36 = 0;

                if v2 == v33 then
                    v36 = (1 / 0);
                else
                    local v37 = v2:find(v33, 1, true);

                    if v37 then
                        v36 = #v33 / #v2 + (v37 == 1 and 0.2 or 0);
                    end;
                end;

                if v34 < v36 then
                    v35 = v;
                    v34 = v36;
                end;
            end;
        end;
    end;

    return v35;
end;

local function selectPlayerTargets(p38) -- Line: 202
    -- upvalues: Players (copy), LocalPlayer (copy), getNearestPlayer (copy), fuzzyFindPlayer (copy)
    local v39 = p38:lower();

    if v39 == "all" or v39 == "others" then
        local v40 = {};

        for _, v in Players:GetPlayers() do
            if v ~= LocalPlayer then
                table.insert(v40, v);
            end;
        end;

        return v40;
    end;

    if v39 == "nearest" then
        local v41 = getNearestPlayer();

        return v41 and { v41 } or {};
    end;

    local v42 = fuzzyFindPlayer(p38);

    return v42 and { v42 } or {};
end;

local function getHiddenFolder() -- Line: 219
    -- upvalues: ReplicatedStorage (copy)
    local HiddenPlayers = ReplicatedStorage:FindFirstChild("HiddenPlayers");

    if not HiddenPlayers then
        HiddenPlayers = Instance.new("Folder");
        HiddenPlayers.Name = "HiddenPlayers";
        HiddenPlayers.Parent = ReplicatedStorage;
    end;

    return HiddenPlayers;
end;

local function setCharacterInvisibility(p43, p44) -- Line: 229
    if not p43 then
        return;
    end;

    for _, child in p43:GetChildren() do
        if child:IsA("BasePart") then
            child.LocalTransparencyModifier = p44 and 1 or 0;
        end;
    end;
end;

local function updateInvisHooks() -- Line: 238
    -- upvalues: u7 (ref), LocalPlayer (copy), u5 (ref)
    if u7 then
        u7:Disconnect();
        u7 = nil;
    end;

    local Character = LocalPlayer.Character;

    if u5 and Character then
        if Character then
            for _, child in Character:GetChildren() do
                if child:IsA("BasePart") then
                    child.LocalTransparencyModifier = 1;
                end;
            end;
        end;

        u7 = Character.ChildAdded:Connect(function(p45) -- Line: 246
            -- upvalues: u5 (ref)
            if u5 and p45:IsA("BasePart") then
                p45.LocalTransparencyModifier = 1;
            end;
        end);
    end;
end;

return {
    {
        layoutOrder = 36,
        name = "/commands",
        description = "Open the commands menu",
        aliases = { "/cmds", "/help" },

        run = function() -- Line: 260, Name: run
            require(script.Parent).Open();
        end
    },
    {
        layoutOrder = 11,
        name = "/profile",
        description = "Open your own profile",

        run = function() -- Line: 268, Name: run
            -- upvalues: LocalPlayer (copy)
            require(script.Parent.Parent.PlayerContextMenuController).Open(LocalPlayer);
        end
    },
    {
        layoutOrder = 12,
        name = "/outfit",
        requiresArgs = true,
        params = "<code>",
        description = "View a community outfit by its code",

        run = function(p46) -- Line: 278, Name: run
            -- upvalues: Remotes (copy), Events (copy)
            local v47 = p46:gsub("[%s#]", ""):upper();

            if v47 == "" then
                return;
            end;

            local v48, v49 = Remotes.CommunityOutfitsAction:InvokeServer("GetOutfitByCode", v47);

            if not (v48 and v49) then
                Events.Notify:Fire("❌ Couldn\'t find an outfit with this code.");

                return;
            end;

            local HumanoidDescriptionController = require(script.Parent.Parent.HumanoidDescriptionController);
            local v50, v51;

            if typeof(v49.HumanoidDescription) == "string" then
                v50, v51 = HumanoidDescriptionController.DeserializeHumanoidDescription(v49.HumanoidDescription);
            else
                v50 = v49.HumanoidDescription;
                v51 = v49.RigType or Enum.HumanoidRigType.R15;
            end;

            Events.Notify:Fire("✅ Found outfit!");
            Events.DisplayContentPage:Fire({
                Type = "CommunityOutfit",
                OutfitDetails = {
                    Name = v49.Name,
                    Id = v49.Id,
                    HumanoidDescription = v50,
                    CreatorId = v49.CreatorId,
                    RigType = v51,
                    Created = v49.Created,
                    Updated = v49.Updated,
                    FavoriteCount = v49.FavoriteCount or 0,
                    CommentCount = v49.CommentCount or 0,
                    ShareCode = v49.ShareCode,
                    ViewCount = v49.ViewCount or 0,
                    WornCount = v49.WornCount or 0,
                    IsFavorited = v49.IsFavorited
                }
            });
        end
    },
    {
        layoutOrder = 25,
        name = "/reset",
        description = "Reset your avatar",

        run = function() -- Line: 319, Name: run
            -- upvalues: Events (copy), Remotes (copy)
            local v52 = Events.GetCurrentResetAvatarDialog:Invoke();

            if v52 and v52.Close then
                v52.Close(false);

                return;
            end;

            if Events.PromptResetAvatar:Invoke() == true then
                local v53, v54 = Remotes.ResetAvatar:InvokeServer();

                if v53 == false then
                    warn("error resetting avatar:", v54);
                end;
            end;
        end
    },
    {
        layoutOrder = 27,
        name = "/item",
        requiresArgs = true,
        params = "<id | url | query>",
        description = "Open an item by id/URL (or search if no match)",

        run = function(p55) -- Line: 340, Name: run
            if p55 == "" then
                return;
            end;

            require(script.Parent.Parent.CatalogController).SearchFor(p55);
        end
    },
    {
        layoutOrder = 28,
        name = "/settings",
        description = "Open the settings panel",

        run = function() -- Line: 349, Name: run
            require(script.Parent.Parent.SettingsController).Open();
        end
    },
    {
        layoutOrder = 29,
        name = "/pose",
        description = "Toggle pose mode",

        run = function() -- Line: 357, Name: run
            -- upvalues: Events (copy)
            Events.DisplayPose:Fire();
        end
    },
    {
        layoutOrder = 30,
        name = "/photobooth",
        description = "Open the photobooth",

        run = function() -- Line: 365, Name: run
            require(script.Parent.Parent.PhotoboothController).Open();
        end
    },
    {
        layoutOrder = 31,
        name = "/theme",
        requiresArgs = true,
        params = "<dark | light>",
        description = "Switch UI theme",

        run = function(p56) -- Line: 375, Name: run
            -- upvalues: Events (copy)
            local v57 = p56:lower();
            local v58;

            if v57 == "dark" then
                v58 = "Dark";
            else
                if v57 ~= "light" then
                    Events.Notify:Fire("❌ Theme must be <b>dark</b> or <b>light</b>.");

                    return;
                end;

                v58 = "Light";
            end;

            require(script.Parent.Parent.ThemeController).SetTheme(v58);
            Events.Notify:Fire("✅ Switched to <b>" .. v58 .. "</b> theme");
        end
    },
    {
        layoutOrder = 32,
        name = "/co",
        description = "Open Community Outfits",

        run = function() -- Line: 392, Name: run
            require(script.Parent.Parent.CommunityOutfitsController).Open();
        end
    },
    {
        layoutOrder = 33,
        name = "/so",
        description = "Open Saved Outfits",

        run = function() -- Line: 400, Name: run
            require(script.Parent.Parent.SavedOutfitsController).Open();
        end
    },
    {
        layoutOrder = 33.5,
        name = "/shop",
        description = "Open the Exclusive Shop",
        aliases = { "/exclusiveshop" },

        run = function() -- Line: 409, Name: run
            if not game:GetService("ReplicatedStorage"):GetAttribute("ExclusiveShopEnabled") then
                return;
            end;

            require(script.Parent.Parent.ExclusiveShopController).Open();
        end
    },
    {
        layoutOrder = 34,
        name = "/ol",
        description = "Open Outfit Loader",

        run = function() -- Line: 421, Name: run
            require(script.Parent.Parent.OutfitLoaderController).Open();
        end
    },
    {
        layoutOrder = 35,
        name = "/save",
        description = "Open the Save Outfit panel",

        run = function() -- Line: 429, Name: run
            -- upvalues: Events (copy)
            Events.DisplaySaveOutfit:Fire(true);
        end
    },
    {
        layoutOrder = 26,
        name = "/current",
        description = "Open the Currently Wearing panel",

        run = function() -- Line: 437, Name: run
            -- upvalues: Events (copy)
            Events.DisplayCurrentlyWearing:Fire(true);
        end
    },
    {
        layoutOrder = 23,
        name = "/hide",
        requiresArgs = true,
        params = "<player | all | nearest>",
        description = "Hide a player",

        run = function(p59) -- Line: 447, Name: run
            -- upvalues: selectPlayerTargets (copy), Events (copy), ReplicatedStorage (copy)
            if p59 == "" then
                return;
            end;

            local v60 = selectPlayerTargets(p59);

            if #v60 == 0 then
                local v61 = p59:lower();

                if v61 == "all" or v61 == "nearest" then
                    Events.Notify:Fire("⚠️ No other players in the server.");

                    return;
                end;

                Events.Notify:Fire("❌ No player matching <b>" .. p59 .. "</b> found.");

                return;
            end;

            local HiddenPlayers = ReplicatedStorage:FindFirstChild("HiddenPlayers");

            if not HiddenPlayers then
                HiddenPlayers = Instance.new("Folder");
                HiddenPlayers.Name = "HiddenPlayers";
                HiddenPlayers.Parent = ReplicatedStorage;
            end;

            for _, v in v60 do
                v:SetAttribute("isHidden", true);

                if v.Character then
                    v.Character.Parent = HiddenPlayers;
                end;
            end;

            Events.Notify:Fire("✅ Hid <b>" .. #v60 .. "</b> player" .. (#v60 == 1 and "" or "s") .. ".");
        end
    },
    {
        layoutOrder = 24,
        name = "/unhide",
        requiresArgs = true,
        params = "<player | all | nearest>",
        description = "Unhide a player",

        run = function(p62) -- Line: 473, Name: run
            -- upvalues: selectPlayerTargets (copy), Events (copy)
            if p62 == "" then
                return;
            end;

            local v63 = selectPlayerTargets(p62);

            if #v63 ~= 0 then
                for _, v in v63 do
                    v:SetAttribute("isHidden", nil);

                    if v.Character then
                        v.Character.Parent = workspace;
                    end;
                end;

                Events.Notify:Fire("✅ Unhid <b>" .. #v63 .. "</b> player" .. (#v63 == 1 and "" or "s") .. ".");

                return;
            end;

            local v64 = p62:lower();

            if v64 == "all" or v64 == "nearest" then
                Events.Notify:Fire("⚠️ No other players in the server.");

                return;
            end;

            Events.Notify:Fire("❌ No player matching <b>" .. p62 .. "</b> found.");
        end
    },
    {
        layoutOrder = 1,
        name = "/headless",
        description = "Equip the Headless Horseman head",

        run = function() -- Line: 496, Name: run
            -- upvalues: TryOnItem (copy), Events (copy)
            if TryOnItem:InvokeServer(15093053680, "Asset", "Head") then
                Events.Notify:Fire("✅ Equipped the Headless Horseman head");
            end;
        end
    },
    {
        layoutOrder = 2,
        name = "/korblox",
        description = "Equip the Korblox Deathspeaker right leg",

        run = function() -- Line: 505, Name: run
            -- upvalues: TryOnItem (copy), Events (copy)
            if TryOnItem:InvokeServer(139607718, "Asset", "RightLeg") then
                Events.Notify:Fire("✅ Equipped the Korblox Deathspeaker right leg");
            end;
        end
    },
    {
        layoutOrder = 3,
        name = "/korblox2",
        description = "Equip the Korblox Deathspeaker left leg",

        run = function() -- Line: 514, Name: run
            -- upvalues: TryOnItem (copy), Events (copy)
            if TryOnItem:InvokeServer(139607673, "Asset", "LeftLeg") then
                Events.Notify:Fire("✅ Equipped the Korblox Deathspeaker left leg");
            end;
        end
    },
    {
        layoutOrder = 4,
        name = "/carpet",
        description = "Equip the Magic Carpet",

        run = function() -- Line: 523, Name: run
            -- upvalues: TryOnItem (copy), Events (copy)
            if TryOnItem:InvokeServer(225921000, "Asset", "Gear") then
                Events.Notify:Fire("✅ Equipped the Magic Carpet");
            end;
        end
    },
    {
        layoutOrder = 5,
        name = "/cloud",
        description = "Equip the Cloud",

        run = function() -- Line: 532, Name: run
            -- upvalues: TryOnItem (copy), Events (copy)
            if TryOnItem:InvokeServer(107458483, "Asset", "Gear") then
                Events.Notify:Fire("✅ Equipped the Cloud");
            end;
        end
    },
    {
        layoutOrder = 6,
        name = "/r6",
        description = "Switch your rig to R6",

        run = function() -- Line: 541, Name: run
            -- upvalues: SetBodyAdjustment (copy), Events (copy)
            if SetBodyAdjustment:InvokeServer({
                Type = "RigType",
                RigType = Enum.HumanoidRigType.R6
            }) then
                Events.Notify:Fire("✅ Switched to R6");
            end;
        end
    },
    {
        layoutOrder = 7,
        name = "/r15",
        description = "Switch your rig to R15",

        run = function() -- Line: 550, Name: run
            -- upvalues: SetBodyAdjustment (copy), Events (copy)
            if SetBodyAdjustment:InvokeServer({
                Type = "RigType",
                RigType = Enum.HumanoidRigType.R15
            }) then
                Events.Notify:Fire("✅ Switched to R15");
            end;
        end
    },
    {
        layoutOrder = 8,
        name = "/speed",
        description = "Set your walk speed (0-100, default 16)",
        requiresArgs = true,
        params = "<number>",

        run = function(p65) -- Line: 561, Name: run
            -- upvalues: UpdateSettings (copy), LocalPlayer (copy), Events (copy)
            local v66 = tonumber(p65);

            if not v66 then
                return;
            end;

            local v67, v68 = UpdateSettings:InvokeServer({
                Profile = {
                    Speed = v66
                }
            });

            if not v67 then
                return;
            end;

            if v68 and v68.Profile then
                v66 = v68.Profile.Speed or v66;
            end;

            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChildWhichIsA("Humanoid");
            end;

            if Character then
                Character.WalkSpeed = v66;
            end;

            Events.Notify:Fire(string.format("✅ Walk speed set to <b>%s</b>", (tostring(v66))));
        end
    },
    {
        layoutOrder = 9,
        name = "/jumppower",
        description = "Set your jump power (0-100, default 50)",
        requiresArgs = true,
        params = "<number>",

        run = function(p69) -- Line: 579, Name: run
            -- upvalues: UpdateSettings (copy), LocalPlayer (copy), Events (copy)
            local v70 = tonumber(p69);

            if not v70 then
                return;
            end;

            local v71, v72 = UpdateSettings:InvokeServer({
                Profile = {
                    JumpPower = v70
                }
            });

            if not v71 then
                return;
            end;

            if v72 and v72.Profile then
                v70 = v72.Profile.JumpPower or v70;
            end;

            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChildWhichIsA("Humanoid");
            end;

            if Character then
                Character.UseJumpPower = true;
                Character.JumpPower = v70;
            end;

            Events.Notify:Fire(string.format("✅ Jump power set to <b>%s</b>", (tostring(v70))));
        end
    },
    {
        layoutOrder = 10,
        name = "/gravity",
        description = "Set world gravity (0-400, default 196.2)",
        requiresArgs = true,
        params = "<number>",

        run = function(p73) -- Line: 600, Name: run
            -- upvalues: UpdateSettings (copy), Events (copy)
            local v74 = tonumber(p73);

            if not v74 then
                return;
            end;

            local v75, v76 = UpdateSettings:InvokeServer({
                Profile = {
                    Gravity = v74
                }
            });

            if not v75 then
                return;
            end;

            if v76 and v76.Profile then
                v74 = v76.Profile.Gravity or v74;
            end;

            workspace.Gravity = v74;
            Events.Notify:Fire(string.format("✅ Gravity set to <b>%s</b>", (tostring(v74))));
        end
    },
    {
        layoutOrder = 13,
        name = "/clone",
        emoji = "👥",
        description = "Clone yourself playing your current animation",

        run = function() -- Line: 615, Name: run
            -- upvalues: LocalPlayer (copy), u1 (copy), mirrorPlayerPoseOnClone (copy), u5 (ref), playPlayerAnimationsOn (copy), Events (copy)
            local Character = LocalPlayer.Character;

            if not Character then
                return;
            end;

            local Archivable = Character.Archivable;
            Character.Archivable = true;
            local v77 = Character:Clone();
            Character.Archivable = Archivable;

            if not v77 then
                return;
            end;

            v77.Parent = workspace;
            table.insert(u1, v77);
            local v78 = v77:FindFirstChildWhichIsA("Humanoid");

            if v78 then
                v78.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
            end;

            local Animate = v77:FindFirstChild("Animate");

            if Animate then
                Animate.Enabled = false;
            end;

            mirrorPlayerPoseOnClone(v77);

            if u5 and v77 then
                for _, child in v77:GetChildren() do
                    if child:IsA("BasePart") then
                        child.LocalTransparencyModifier = 1;
                    end;
                end;
            end;

            if v77 then
                v77 = v77:FindFirstChildWhichIsA("Humanoid");
            end;

            local v79;

            if v77 then
                v79 = v77:FindFirstChildWhichIsA("Animator");
            else
                v77 = nil;
                v79 = nil;
            end;

            if v77 then
                if not v79 then
                    v79 = Instance.new("Animator");
                    v79.Parent = v77;
                end;
            else
                v79 = nil;
            end;

            if v79 then
                playPlayerAnimationsOn(v79);
            end;

            Events.Notify:Fire("✅ Cloned your character");
        end
    },
    {
        layoutOrder = 14,
        name = "/sync",
        emoji = "👥",
        description = "Sync nearest clone to your animation (or all)",
        params = "[all]",

        run = function(p80) -- Line: 648, Name: run
            -- upvalues: selectClones (copy), Events (copy), u2 (copy), playPlayerAnimationsOn (copy)
            local v81 = selectClones(p80);

            if #v81 == 0 then
                Events.Notify:Fire("⚠️ No clones to sync. Use /clone first.");

                return;
            end;

            for _, v in v81 do
                local v82 = u2[v];

                if v82 then
                    for _, v2 in v82 do
                        v2:Stop(0);
                    end;

                    u2[v] = nil;
                end;

                local v83;

                if v then
                    v83 = v:FindFirstChildWhichIsA("Humanoid");
                else
                    v83 = v;
                end;

                local v84;

                if v83 then
                    v84 = v83:FindFirstChildWhichIsA("Animator");
                else
                    v83 = nil;
                    v84 = nil;
                end;

                if v83 then
                    if not v84 then
                        v84 = Instance.new("Animator");
                        v84.Parent = v83;
                    end;
                else
                    v84 = nil;
                end;

                if v84 then
                    u2[v] = playPlayerAnimationsOn(v84, Enum.AnimationPriority.Action4, 1);
                end;
            end;

            local v85 = p80 and p80:lower() == "all" and "all clones" or "nearest clone";
            Events.Notify:Fire("✅ Synced " .. v85 .. " to your animation");
        end
    },
    {
        layoutOrder = 15,
        name = "/unsync",
        emoji = "👥",
        description = "Stop synced animation on nearest clone (or all)",
        params = "[all]",

        run = function(p86) -- Line: 671, Name: run
            -- upvalues: selectClones (copy), Events (copy), u2 (copy)
            local v87 = selectClones(p86);

            if #v87 == 0 then
                Events.Notify:Fire("⚠️ No clones to unsync.");

                return;
            end;

            for _, v in v87 do
                local v88 = u2[v];

                if v88 then
                    for _, v2 in v88 do
                        v2:Stop(0);
                    end;

                    u2[v] = nil;
                end;
            end;

            local v89 = p86 and p86:lower() == "all" and "All clones" or "Nearest clone";
            Events.Notify:Fire("✅ " .. v89 .. " unsynced");
        end
    },
    {
        layoutOrder = 17,
        name = "/fly",
        description = "Toggle flight",

        run = function() -- Line: 688, Name: run
            -- upvalues: Fly (copy), Events (copy)
            if Fly.IsOn then
                Fly.Stop();
                Events.Notify:Fire("✅ Flight off");

                return;
            end;

            Fly.Start();

            if Fly.IsOn then
                Events.Notify:Fire("✅ Flight on");
            end;
        end
    },
    {
        layoutOrder = 18,
        name = "/unfly",
        description = "Disable flight",

        run = function() -- Line: 704, Name: run
            -- upvalues: Fly (copy), Events (copy)
            if not Fly.IsOn then
                Events.Notify:Fire("⚠️ You are not flying.");

                return;
            end;

            Fly.Stop();
            Events.Notify:Fire("✅ Flight off");
        end
    },
    {
        layoutOrder = 16,
        name = "/removeclone",
        emoji = "👥",
        description = "Remove nearest clone (or all)",
        params = "[all]",
        aliases = { "/deleteclone" },

        run = function(p90) -- Line: 720, Name: run
            -- upvalues: selectClones (copy), Events (copy), u2 (copy), pruneClones (copy)
            local v91 = selectClones(p90);

            if #v91 == 0 then
                Events.Notify:Fire("⚠️ No clones to remove.");

                return;
            end;

            for _, v in v91 do
                u2[v] = nil;
                v:Destroy();
            end;

            pruneClones();
            local v92 = p90 and p90:lower() == "all" and "all clones" or "nearest clone";
            Events.Notify:Fire("✅ Removed " .. v92);
        end
    },
    {
        layoutOrder = 37,
        name = "/invisible",
        description = "Make your body invisible (locally)",
        aliases = { "/invis" },

        run = function() -- Line: 740, Name: run
            -- upvalues: u5 (ref), u6 (ref), LocalPlayer (copy), updateInvisHooks (copy)
            u5 = true;

            if not u6 then
                u6 = LocalPlayer.CharacterAdded:Connect(updateInvisHooks);
            end;

            updateInvisHooks();
        end
    },
    {
        layoutOrder = 42,
        name = "/btools",
        emoji = "🔒",
        params = "[player]",
        description = "Give Building Tools (private servers only)",
        aliases = { "/f3x" },

        run = function(p93) -- Line: 755, Name: run
            -- upvalues: LocalPlayer (copy), fuzzyFindPlayer (copy), Events (copy), Remotes (copy)
            local v94 = LocalPlayer;
            local v95 = p93 and (p93:lower() or "") or "";

            if v95 ~= "" and v95 ~= "me" then
                v94 = fuzzyFindPlayer(p93, true);

                if not v94 then
                    Events.Notify:Fire("❌ No player matching <b>" .. p93 .. "</b> found.");

                    return;
                end;
            end;

            local v96, v97 = Remotes.CommandAction:InvokeServer("GiveBuildingTools", v94);

            if not v96 then
                Events.Notify:Fire("❌ " .. tostring(v97 or "Failed."));

                return;
            end;

            if v94 == LocalPlayer then
                Events.Notify:Fire("✅ Building Tools given.");

                return;
            end;

            Events.Notify:Fire("✅ Gave Building Tools to <b>" .. v94.DisplayName .. "</b>.");
        end
    },
    {
        layoutOrder = 42.5,
        name = "/builds",
        emoji = "🔒",
        description = "Open your saved builds (private servers only)",

        run = function() -- Line: 783, Name: run
            require(script.Parent.Parent:WaitForChild("BuildsController")).Open(true);
        end
    },
    {
        layoutOrder = 43,
        name = "/kick",
        emoji = "🔒",
        requiresArgs = true,
        params = "<player | all | others>",
        description = "Kick a player from the server (private servers only)",

        run = function(p98) -- Line: 794, Name: run
            -- upvalues: selectPlayerTargets (copy), LocalPlayer (copy), Events (copy), Remotes (copy)
            if p98 == "" then
                return;
            end;

            local v99 = p98:lower();
            local v100 = selectPlayerTargets(p98);

            if #v100 == 0 then
                if v99 == LocalPlayer.Name:lower() or v99 == LocalPlayer.DisplayName:lower() then
                    return;
                end;

                if v99 == "all" or (v99 == "others" or v99 == "nearest") then
                    Events.Notify:Fire("⚠️ No other players in the server.");

                    return;
                end;

                Events.Notify:Fire("❌ No player matching <b>" .. p98 .. "</b> found.");

                return;
            end;

            local v101, v102 = Remotes.CommandAction:InvokeServer("Kick", v100);

            if not v101 then
                Events.Notify:Fire("❌ " .. tostring(v102 or "Failed."));

                return;
            end;

            local v103 = v102 and v102.Count or #v100;

            if v103 == 1 then
                Events.Notify:Fire("✅ Kicked <b>" .. (v102 and (v102.Names and v102.Names[1]) or v100[1].DisplayName) .. "</b>.");

                return;
            end;

            Events.Notify:Fire(string.format("✅ Kicked <b>%d</b> players.", v103));
        end
    },
    {
        layoutOrder = 44,
        name = "/ban",
        emoji = "🔒",
        requiresArgs = true,
        params = "<player | all | others>",
        description = "Ban a player from this server (private servers only)",

        run = function(p104) -- Line: 830, Name: run
            -- upvalues: selectPlayerTargets (copy), LocalPlayer (copy), Events (copy), Remotes (copy)
            if p104 == "" then
                return;
            end;

            local v105 = p104:lower();
            local v106 = selectPlayerTargets(p104);

            if #v106 ~= 0 then
                local v107, v108 = Remotes.CommandAction:InvokeServer("Ban", v106);

                if not v107 then
                    Events.Notify:Fire("❌ " .. tostring(v108 or "Failed."));

                    return;
                end;

                local v109 = v108 and v108.Count or #v106;

                if v109 == 1 then
                    Events.Notify:Fire("✅ Banned <b>" .. (v108 and (v108.Names and v108.Names[1]) or v106[1].DisplayName) .. "</b> from this server.");

                    return;
                end;

                Events.Notify:Fire(string.format("✅ Banned <b>%d</b> players from this server.", v109));

                return;
            end;

            if v105 == LocalPlayer.Name:lower() or v105 == LocalPlayer.DisplayName:lower() then
                return;
            end;

            if v105 == "all" or (v105 == "others" or v105 == "nearest") then
                Events.Notify:Fire("⚠️ No other players in the server.");

                return;
            end;

            local v110, v111 = Remotes.CommandAction:InvokeServer("Ban", p104);

            if not v110 then
                Events.Notify:Fire("❌ " .. tostring(v111 or "Failed."));

                return;
            end;

            if v111 and v111.Names then
                p104 = v111.Names[1] or p104;
            end;

            Events.Notify:Fire("✅ Banned <b>" .. p104 .. "</b> from this server.");
        end
    },
    {
        layoutOrder = 45,
        name = "/unban",
        emoji = "🔒",
        requiresArgs = true,
        params = "<player | all>",
        description = "Unban a player from this server (private servers only)",

        run = function(p112) -- Line: 872, Name: run
            -- upvalues: Remotes (copy), Events (copy)
            if p112 == "" then
                return;
            end;

            local v113 = p112:match("^%s*(.-)%s*$") or "";

            if v113 == "" then
                return;
            end;

            local v114 = v113:lower() == "all" and "all" or v113;
            local v115, v116 = Remotes.CommandAction:InvokeServer("Unban", v114);

            if not v115 then
                Events.Notify:Fire("❌ " .. tostring(v116 or "Failed."));

                return;
            end;

            local v117 = v116 and (v116.Count or 1) or 1;

            if v117 ~= 1 then
                Events.Notify:Fire(string.format("✅ Unbanned <b>%d</b> players.", v117));

                return;
            end;

            if v116 and v116.Names then
                v113 = v116.Names[1] or v113;
            end;

            Events.Notify:Fire("✅ Unbanned <b>" .. v113 .. "</b>.");
        end
    },
    {
        layoutOrder = 46,
        name = "/serverlock",
        emoji = "🔒",
        description = "Lock the server so new players can\'t join (private servers only)",
        aliases = { "/lock" },

        run = function() -- Line: 897, Name: run
            -- upvalues: Remotes (copy), Events (copy)
            local v118, v119 = Remotes.CommandAction:InvokeServer("LockServer");

            if v118 then
                Events.Notify:Fire("✅ Server locked. New players can\'t join.");

                return;
            end;

            local v120 = tostring(v119 or "Failed.");
            Events.Notify:Fire((v120 == "Server is already locked." and "⚠️ " or "❌ ") .. v120);
        end
    },
    {
        layoutOrder = 47,
        name = "/unserverlock",
        emoji = "🔒",
        description = "Unlock the server so new players can join (private servers only)",
        aliases = { "/unlock" },

        run = function() -- Line: 914, Name: run
            -- upvalues: Remotes (copy), Events (copy)
            local v121, v122 = Remotes.CommandAction:InvokeServer("UnlockServer");

            if v121 then
                Events.Notify:Fire("✅ Server unlocked.");

                return;
            end;

            local v123 = tostring(v122 or "Failed.");
            Events.Notify:Fire((v123 == "Server is not locked." and "⚠️ " or "❌ ") .. v123);
        end
    },
    {
        layoutOrder = 38,
        name = "/visible",
        description = "Make your body visible again",
        aliases = { "/uninvis", "/uninvisible" },

        run = function() -- Line: 930, Name: run
            -- upvalues: u5 (ref), u6 (ref), u7 (ref), LocalPlayer (copy)
            u5 = false;

            if u6 then
                u6:Disconnect();
                u6 = nil;
            end;

            if u7 then
                u7:Disconnect();
                u7 = nil;
            end;

            local Character = LocalPlayer.Character;

            if not Character then
                return;
            end;

            for _, child in Character:GetChildren() do
                if child:IsA("BasePart") then
                    child.LocalTransparencyModifier = 0;
                end;
            end;
        end
    },
    {
        layoutOrder = 19,
        name = "/freecam",
        emoji = "🎥",
        description = "Enter freecam mode",
        aliases = { "/fc" },

        run = function() -- Line: 949, Name: run
            -- upvalues: Freecam (copy)
            if Freecam.IsOn then
                return;
            end;

            Freecam.Start();
        end
    },
    {
        layoutOrder = 20,
        name = "/unfreecam",
        emoji = "🎥",
        description = "Exit freecam mode",
        aliases = { "/unfc" },

        run = function() -- Line: 960, Name: run
            -- upvalues: Freecam (copy), Events (copy)
            if not Freecam.IsOn then
                Events.Notify:Fire("⚠️ Freecam is not on.");

                return;
            end;

            Freecam.Stop();
            Events.Notify:Fire("✅ Freecam off");
        end
    },
    {
        layoutOrder = 21,
        name = "/savecam",
        emoji = "🎥",
        params = "[index]",
        description = "Save the current camera position",

        run = function(p124) -- Line: 975, Name: run
            -- upvalues: Events (copy), Freecam (copy)
            local v125 = p124:match("^%s*(.-)%s*$") or "";
            local v126;

            if v125 == "" then
                v126 = nil;
            else
                v126 = tonumber(v125);

                if not v126 or (v126 < 1 or v126 % 1 ~= 0) then
                    Events.Notify:Fire("❌ Index must be a positive integer.");

                    return;
                end;
            end;

            local v127 = Freecam.SaveCFrame(v126);
            Events.Notify:Fire(string.format("✅ Saved camera to slot <b>%d</b>", v127));
        end
    },
    {
        layoutOrder = 22,
        name = "/loadcam",
        emoji = "🎥",
        requiresArgs = true,
        params = "<index>",
        description = "Load a saved camera position",

        run = function(p128) -- Line: 997, Name: run
            -- upvalues: Events (copy), Freecam (copy)
            local v129 = tonumber(p128);

            if not v129 or (v129 < 1 or v129 % 1 ~= 0) then
                Events.Notify:Fire("❌ Index must be a positive integer.");

                return;
            end;

            if Freecam.LoadCFrame(v129) then
                Events.Notify:Fire(string.format("✅ Loaded camera slot <b>%d</b>", v129));

                return;
            end;

            Events.Notify:Fire(string.format("❌ No camera saved at slot <b>%d</b>.", v129));
        end
    },
    {
        layoutOrder = 40,
        name = "/sit",
        description = "Sit down",

        run = function() -- Line: 1014, Name: run
            -- upvalues: LocalPlayer (copy)
            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChildWhichIsA("Humanoid");
            end;

            if Character then
                Character.Sit = true;
            end;
        end
    },
    {
        layoutOrder = 41,
        name = "/id",
        description = "Show the ID of the currently-open item details page",

        run = function() -- Line: 1024, Name: run
            -- upvalues: Events (copy)
            local Current = require(script.Parent.Parent.ContentPageController).Current;

            if Current and (Current.Type == "ItemDetails" and (Current.Item and Current.Item.Id ~= nil)) then
                require(script.Parent.Parent.DialogController).PromptInputDialog({
                    Description = "Here\'s the item ID:",
                    ReadOnly = true,
                    NoText = "Close",
                    YesText = "Done",
                    Title = Current.Item.Name or "Item",
                    DefaultText = tostring(Current.Item.Id)
                });

                return;
            end;

            Events.Notify:Fire("❌ No item details page is open.");
        end
    },
    {
        layoutOrder = 39,
        name = "/statistics",
        description = "View your stats",
        aliases = { "/stats" },

        run = function() -- Line: 1046, Name: run
            require(script.Parent.Parent.StatisticsController).Open();
        end
    },
    {
        layoutOrder = 48,
        name = "/exportoutfits",
        adminOnly = true,
        description = "Export all your saved outfits as a serialized blob",

        run = function() -- Line: 1055, Name: run
            -- upvalues: Remotes (copy), Events (copy), HttpService (copy)
            if not require(script.Parent).IsAdministrator then
                return;
            end;

            local v130, u131 = Remotes.SavedOutfitAction:InvokeServer({
                Action = "Get"
            });

            if not v130 or (typeof(u131) ~= "table" or typeof(u131.Outfits) ~= "table") then
                Events.Notify:Fire("❌ Couldn\'t load your saved outfits.");

                return;
            end;

            local v132 = 0;

            for _ in u131.Outfits do
                v132 = v132 + 1;
            end;

            if v132 == 0 then
                Events.Notify:Fire("⚠️ You have no saved outfits to export.");

                return;
            end;

            local success, result = pcall(function() -- Line: 1073
                -- upvalues: HttpService (ref), u131 (copy)
                return HttpService:JSONEncode(u131);
            end);

            if success and typeof(result) == "string" then
                require(script.Parent.Parent.DialogController).PromptInputDialog({
                    Title = "Export Outfits",
                    ReadOnly = true,
                    NoText = "Close",
                    YesText = "Done",
                    Description = string.format("Serialized blob for <b>%d</b> outfit%s. Select all and copy:", v132, v132 == 1 and "" or "s"),
                    DefaultText = result
                });

                return;
            end;

            Events.Notify:Fire("❌ Couldn\'t serialize your saved outfits.");
        end
    }
};