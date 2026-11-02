-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local ContentProvider = game:GetService("ContentProvider");
local TweenService = game:GetService("TweenService");
local HttpService = game:GetService("HttpService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local SoundLibrary = require(ReplicatedStorage.Modules.SoundLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local ClientMap = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientDuel.ClientMap);
local StaticViewModel = require(Players.LocalPlayer.PlayerScripts.Modules.StaticModel.StaticViewModel);
local ChickenTrojanExplosionEffect = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("ChickenTrojanExplosionEffect");
local ZombieTowerLadderGui = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("ZombieTowerLadderGui");
local u1 = { "rbxassetid://98587858115094", "rbxassetid://72483809453170", "rbxassetid://129922197154277", "rbxassetid://113975047764762", "rbxassetid://121368500414901" };
local u2 = { "rbxassetid://116380542394210", "rbxassetid://125379277208360", "rbxassetid://96610433230092", "rbxassetid://122643453923681", "rbxassetid://94468135009167", "rbxassetid://133107467882960", "rbxassetid://122210005572726", "rbxassetid://102260065267741" };
local u3 = { { 0, 24 }, { 9.97, 24 }, { 10.53, 17 }, { 10.87, 17 }, { 11.62, 30 }, { 11.83, 30 }, { 12.55, 17 }, { 13.03, 30 }, { 16.52, 30 }, { 17.53, 10 }, { 19.12, 30, true }, { 22.9, 50 }, { 23.4, 20 }, { 24.58, 50 }, { 26.02, 35 } };
local u4 = setmetatable({}, ClientMap);
u4.__index = u4;

function u4.new(...) -- Line: 47
    -- upvalues: ClientMap (copy), u4 (copy), SoundLibrary (copy), u1 (copy), ZombieTowerLadderGui (copy)
    local v5 = ClientMap.new(...);
    local v6 = setmetatable(v5, u4);
    v6._floors_folder = v6.Model:WaitForChild("Floors");
    v6._cutscene_hash = 0;
    v6._cutscene_renderstep_id = nil;
    v6._cutscene_boss_animation = Instance.new("Animation");
    v6._cutscene_camera_animation = Instance.new("Animation");
    v6._cutscene_player_animations = {};
    v6._cutscene_animation_tracks = {};
    v6._cutscene_cleanup = {};
    v6._cutscene_threads = {};
    v6._cutscene_hidden_duelers = {};
    v6._preloaded_sounds = SoundLibrary:PreloadSounds(u1);
    v6._spectating_thread = nil;
    v6._flashing_red_enemies_connection = nil;
    v6._active_enemy_humanoids = {};
    v6._ladder_guide_bbg = ZombieTowerLadderGui:Clone();
    v6:_Init();

    return v6;
end;

function u4.GetScoreboardDisplay(p7) -- Line: 75
    local v8 = p7:_GetCurrentFloor();

    return "Zombie Tower" .. (v8 and "   •   Floor " .. v8 or "");
end;

function u4.ReplicateFromServer(p9, p10, ...) -- Line: 81
    -- upvalues: ClientMap (copy)
    if p10 == "ChickenTrojanEffect" then
        if not p9:IsRendered() then
            return;
        end;

        p9:_ChickenTrojan(...);

        return;
    end;

    if p10 == "GiantChombieCutscene" then
        if not p9:IsRendered() then
            return;
        end;

        p9:_PlayCutscene(...);

        return;
    end;

    if p10 ~= "FinishGiantChombieCutscene" then
        ClientMap.ReplicateFromServer(p9, ...);

        return;
    end;

    if not p9:IsRendered() then
        return;
    end;

    p9:_StopCutscene();
end;

function u4.Destroy(p11) -- Line: 105
    -- upvalues: ClientMap (copy)
    for _, v in pairs(p11._preloaded_sounds) do
        v:Destroy();
    end;

    if p11._spectating_thread then
        task.cancel(p11._spectating_thread);
        p11._spectating_thread = nil;
    end;

    if p11._flashing_red_enemies_connection then
        p11._flashing_red_enemies_connection:Disconnect();
        p11._flashing_red_enemies_connection = nil;
    end;

    p11:_StopCutscene();
    ClientMap.Destroy(p11);
end;

function u4._UpdateSpectating(u12) -- Line: 129
    -- upvalues: RunService (copy)
    if u12._flashing_red_enemies_connection then
        u12._flashing_red_enemies_connection:Disconnect();
        u12._flashing_red_enemies_connection = nil;
    end;

    if u12._destroyed or not u12.ClientDuel:Get("IsSpectating") then
        return;
    end;

    u12._flashing_red_enemies_connection = RunService.RenderStepped:Connect(function() -- Line: 139
        -- upvalues: u12 (copy)
        local v13 = 3.141592653589793 * tick();
        local math_sin_ret = math.sin(v13);
        local math_max_ret = math.max(0, math_sin_ret);

        for i, v in pairs(u12._active_enemy_humanoids) do
            if tick() >= v.StartFlashingRed then
                if not v.Highlight then
                    v.Highlight = Instance.new("Highlight");
                    v.Highlight.FillColor = Color3.fromRGB(255, 0, 0);
                    v.Highlight.OutlineColor = Color3.fromRGB(255, 0, 0);
                    v.Highlight.Adornee = i.Parent;
                    v.Highlight.Name = "FlashingRed";
                    v.Highlight.Parent = i;
                end;

                v.Highlight.OutlineTransparency = math_max_ret * 1 + 0;
                v.Highlight.FillTransparency = math_max_ret * 0.125 + 0.875;
            end;
        end;
    end);
end;

function u4._FloorAdded(u14, p15) -- Line: 162
    local MobGroups = p15:WaitForChild("MobGroups");

    local function humanoid_added(u16) -- Line: 165
        -- upvalues: u14 (copy)
        local u17 = {
            StartFlashingRed = 0,
            Highlight = nil
        };
        u16.HealthChanged:Connect(function() -- Line: 171, Name: reset
            -- upvalues: u17 (copy)
            u17.StartFlashingRed = tick() + 60;

            if u17.Highlight then
                u17.Highlight:Destroy();
                u17.Highlight = nil;
            end;
        end);
        u17.StartFlashingRed = tick() + 60;

        if u17.Highlight then
            u17.Highlight:Destroy();
            u17.Highlight = nil;
        end;

        u14._active_enemy_humanoids[u16] = u17;
        u16.Destroying:Connect(function() -- Line: 185
            -- upvalues: u14 (ref), u16 (copy)
            u14._active_enemy_humanoids[u16] = nil;
        end);
    end;

    local function object_value_added(u18) -- Line: 190
        -- upvalues: humanoid_added (copy)
        local u19 = false;

        local function check() -- Line: 193
            -- upvalues: u19 (ref), u18 (copy), humanoid_added (ref)
            if u19 then
                return;
            end;

            if not u18.Value then
                return;
            end;

            u19 = true;
            task.spawn(humanoid_added, u18.Value);
        end;

        u18:GetPropertyChangedSignal("Value"):Connect(check);

        if not u19 and u18.Value then
            u19 = true;
            task.spawn(humanoid_added, u18.Value);
        end;
    end;

    local function mob_group_added(p20) -- Line: 210
        -- upvalues: object_value_added (copy)
        local EntityHumanoidObjectValues = p20:WaitForChild("EntityHumanoidObjectValues", 3);

        if not EntityHumanoidObjectValues then
            return;
        end;

        EntityHumanoidObjectValues.ChildAdded:Connect(object_value_added);

        for _, child in pairs(EntityHumanoidObjectValues:GetChildren()) do
            task.spawn(object_value_added, child);
        end;
    end;

    MobGroups.ChildAdded:Connect(mob_group_added);

    for _, child in pairs(MobGroups:GetChildren()) do
        task.spawn(mob_group_added, child);
    end;

    if (tonumber(p15.Name) or 0) > 2 then
        task.delay(1, u14.CreateSound, u14, "rbxassetid://1843115730", 2, 1, p15:WaitForChild("Important"):WaitForChild("Entrance"), true, 10, 400, 400);
    end;
end;

function u4._GetCurrentFloor(p21) -- Line: 236
    -- upvalues: Utility (copy)
    for _, child in pairs(p21._floors_folder:GetChildren()) do
        local v22 = child:FindFirstChild("Important") and child.Important:FindFirstChild("Volume");

        if v22 and Utility:IsWithinPart(v22, workspace.CurrentCamera.CFrame.Position) then
            return tonumber(child.Name);
        end;
    end;
end;

function u4._ChickenTrojan(p23, p24, p25, p26) -- Line: 246
    -- upvalues: ChickenTrojanExplosionEffect (copy), BetterDebris (copy), Utility (copy)
    local v27 = tick() + p25;

    while tick() < v27 do
        local v28 = ChickenTrojanExplosionEffect:Clone();
        local CFrame_new_ret = CFrame.new(p24);
        local v29 = math.random() - 0.5;
        local v30 = math.random() - 0.5;
        local v31 = math.random() - 0.5;
        v28.CFrame = CFrame_new_ret + Vector3.new(v29, v30, v31) * 12;
        v28.Parent = workspace;
        BetterDebris:AddItem(v28, 5);
        Utility:ScaleParticleEmitter(v28, 0.5 + 0.75 * math.random());
        Utility:PlayParticles(v28);
        p23:CreateSound("rbxassetid://97884024654711", 0.875 + 0.25 * math.random(), 1 + 0.25 * math.random(), v28, true, 5);
        wait(p26 or 0.2);
    end;
end;

function u4._LoadAnimation(p32, p33, p34, p35) -- Line: 263
    if not p33 then
        return;
    end;

    local success, result = pcall(p33.LoadAnimation, p33, p34);

    if not success then
        warn("Animation " .. p34.AnimationId .. " failed to animate, error:", result);

        return;
    end;

    result:Play(0);
    table.insert(p32._cutscene_animation_tracks, result);
    table.insert(p32._cutscene_threads, task.spawn(p35, result));
end;

function u4._StopCutscene(p36) -- Line: 279
    -- upvalues: RunService (copy)
    p36._cutscene_hash = p36._cutscene_hash + 1;

    for _, v in pairs(p36._cutscene_animation_tracks) do
        v:Stop(0);
        v:Destroy();
    end;

    for _, v in pairs(p36._cutscene_cleanup) do
        v:Destroy();
    end;

    for _, v in pairs(p36._cutscene_threads) do
        pcall(task.cancel, v);
    end;

    for i in pairs(p36._cutscene_hidden_duelers) do
        i:SetReplicate("IsHiddenByCutscene", nil);
    end;

    p36._cutscene_animation_tracks = {};
    p36._cutscene_cleanup = {};
    p36._cutscene_threads = {};

    if p36._cutscene_renderstep_id then
        RunService:UnbindFromRenderStep(p36._cutscene_renderstep_id);
        p36._cutscene_renderstep_id = nil;
    end;
end;

function u4._PlayCutscene(u37, p38, u39, p40) -- Line: 309
    -- upvalues: HttpService (copy), u3 (copy), Utility (copy), TweenService (copy), RunService (copy), u2 (copy), StaticViewModel (copy), CameraController (copy), UserInputService (copy)
    u37:_StopCutscene();
    local AnimationController = u39:WaitForChild("CameraRig"):WaitForChild("AnimationController");
    u37._cutscene_renderstep_id = "GiantChombie" .. HttpService:GenerateGUID(false);
    u37._cutscene_hash = u37._cutscene_hash + 1;
    local _cutscene_hash = u37._cutscene_hash;
    local u41 = u3[1][2];
    u37:_LoadAnimation(p38, u37._cutscene_boss_animation, function(p42) -- Line: 318
        -- upvalues: Utility (ref), u39 (copy), u37 (copy)
        task.delay(23.1, Utility.PlayParticles, Utility, u39:WaitForChild("SlamParticles"));
        wait(1.25);
        u37:CreateSound("rbxassetid://72483809453170", 0.35, 0.675, script, true, 10);
        wait(3.2);
        u37:CreateSound("rbxassetid://72483809453170", 0.6, 0.7, script, true, 10);
        wait(2.15);
        u37:CreateSound("rbxassetid://72483809453170", 0.65, 0.725, script, true, 10);
        wait(1.4);
        u37:CreateSound("rbxassetid://72483809453170", 0.7, 0.75, script, true, 10);
        wait(1.5);
        u37:CreateSound("rbxassetid://72483809453170", 0.75, 0.775, script, true, 10);
        wait(3.45);
        u37:CreateSound("rbxassetid://72483809453170", 1.5, 0.8, script, true, 10);
        wait(2.3);
        u37:CreateSound("rbxassetid://72483809453170", 0.3, 0.75, script, true, 10);
        wait(2);
        u37:CreateSound("rbxassetid://72483809453170", 0.25, 1, script, true, 10);
        wait(3.85);
        u37:CreateSound("rbxassetid://98587858115094", 1, 1, script, true, 10);
        wait(2);
        u37:CreateSound("rbxassetid://72483809453170", 1.25 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true, 10);
        u37:CreateSound("rbxassetid://129922197154277", 1.25 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true, 10);
        u37:CreateSound("rbxassetid://113975047764762", 1.25 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true, 10);
        wait(1.8);
        u37:CreateSound("rbxassetid://121368500414901", 1.5, 0.875, script, true, 10);
    end);
    u37:_LoadAnimation(AnimationController, u37._cutscene_camera_animation, function(p43) -- Line: 379
        -- upvalues: u3 (ref), u41 (ref), TweenService (ref), RunService (ref), u37 (copy), _cutscene_hash (copy)
        local v44 = 0;

        for i, v in pairs(u3) do
            local v45 = u3[math.max(1, i - 1)][2];
            local _, v46, v47 = table.unpack(v);
            local v48 = v[1] - v44;

            if v47 then
                v44 = v44 + wait(v48);
                u41 = v46;
            else
                local v49 = tick();

                while tick() < v49 + v48 do
                    local v50;

                    if v48 == 0 then
                        v50 = v46;
                    else
                        v50 = v45 + (v46 - v45) * TweenService:GetValue((tick() - v49) / v48, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
                    end;

                    u41 = v50;
                    v44 = v44 + RunService.RenderStepped:Wait();

                    if u37._cutscene_hash ~= _cutscene_hash then
                        return;
                    end;
                end;
            end;
        end;
    end);
    local CFrame2 = AnimationController.Parent.HumanoidRootPart.CFrame;
    local v51 = {};

    for _, v in pairs(u37.ClientDuel.Duelers) do
        if v.ClientFighter then
            v.ClientFighter:SetReplicate("IsHiddenByCutscene", true);
            u37._cutscene_hidden_duelers[v.ClientFighter] = true;

            if v.ClientFighter:IsAlive() then
                table.insert(v51, v);

                if #v51 >= #u2 then
                    break;
                end;
            end;
        end;
    end;

    table.sort(v51, function(p52, p53) -- Line: 427
        return p52.Player.UserId < p53.Player.UserId;
    end);
    local u54 = {};

    for i, v in pairs(v51) do
        local CharacterModelForCutscene = v:GetCharacterModelForCutscene();
        CharacterModelForCutscene.Name = "CutscenePlayer" .. i;
        CharacterModelForCutscene:SetPrimaryPartCFrame(CFrame2);
        CharacterModelForCutscene.Parent = AnimationController.Parent.Parent;
        table.insert(u37._cutscene_cleanup, CharacterModelForCutscene);
        local v55 = v.ClientFighter.EquippedItem and v.ClientFighter.EquippedItem:GetViewModelDetails();
        local v56;

        if v55 then
            v56 = StaticViewModel.new(v55.ViewModelName);
        else
            v56 = v55;
        end;

        if v56 and v56:HasGripAttachment() then
            v56:DeleteAnimationContextSubModels();
            v56:SetWrap(v55.Wrap);
            v56:SetCharm(v55.Charm);
            v56:ScaleTo(i == 1 and 1.5 or 1.25);
            v56:InitializeGrip();
            v56:SetParent(CharacterModelForCutscene);
            table.insert(u37._cutscene_cleanup, v56);
            u54[v56] = CharacterModelForCutscene;
        elseif v56 then
            v56:Destroy();
        end;

        local success, result = pcall(function() -- Line: 456
            -- upvalues: CharacterModelForCutscene (copy), u37 (copy), i (copy)
            local v57 = CharacterModelForCutscene.Humanoid:LoadAnimation(u37._cutscene_player_animations[i]);
            v57:Play(0);
            table.insert(u37._cutscene_animation_tracks, v57);
        end);

        if not success then
            warn("Player " .. i .. " failed to animate, error:", result);
            CharacterModelForCutscene.Parent = nil;
        end;
    end;

    local Cam = AnimationController.Parent:FindFirstChild("Cam");
    RunService:BindToRenderStep(u37._cutscene_renderstep_id, CameraController:GetRenderstepPriority() + 1, function(p58) -- Line: 470
        -- upvalues: Cam (copy), u37 (copy), UserInputService (ref), u41 (ref), u54 (copy)
        if not (Cam and u37.ClientDuel:Get("IsSpectating")) then
            return;
        end;

        UserInputService.MouseIconEnabled = true;
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
        workspace.CurrentCamera.FieldOfView = u41;
        workspace.CurrentCamera.CFrame = Cam.CFrame;

        for i, v in pairs(u54) do
            i:GripPivotTo(v);
        end;
    end);
    wait(p40);
    u37:_StopCutscene();
end;

function u4._UpdateLadderGuide(p59) -- Line: 491
end;

function u4._UpdateLightingChange(p60) -- Line: 504
    -- upvalues: Utility (copy)
    local v61 = false;

    for _, child in pairs(p60.Model.BossFight.LightingParts:GetChildren()) do
        v61 = v61 or Utility:IsWithinPart(child, workspace.CurrentCamera.CFrame.Position);
    end;

    local v62 = v61 and "Zombie Tower - FinalFloor" or nil;

    if v62 ~= p60:Get("LightingProfileOverride") then
        p60:SetReplicate("LightingProfileOverride", v62);
    end;
end;

function u4._SetupLightingChange(u63) -- Line: 518
    if u63._spectating_thread then
        task.cancel(u63._spectating_thread);
        u63._spectating_thread = nil;
    end;

    if not u63.ClientDuel:Get("IsSpectating") then
        return;
    end;

    u63._spectating_thread = task.spawn(function() -- Line: 528
        -- upvalues: u63 (copy)
        while true do
            u63:_UpdateLightingChange();
            u63:_UpdateLadderGuide();
            wait(1);
        end;
    end);
end;

function u4._Setup(p64) -- Line: 537
    -- upvalues: u2 (copy), ContentProvider (copy)
    p64._cutscene_boss_animation.AnimationId = "rbxassetid://80790358034810";
    p64._cutscene_camera_animation.AnimationId = "rbxassetid://85660296117721";
    local v65 = { p64._cutscene_boss_animation, p64._cutscene_camera_animation };

    for _, v in pairs(u2) do
        local Animation = Instance.new("Animation");
        Animation.AnimationId = v;
        table.insert(p64._cutscene_player_animations, Animation);
        table.insert(v65, Animation);
    end;

    task.spawn(pcall, ContentProvider.PreloadAsync, ContentProvider, v65);
end;

function u4._Init(u66) -- Line: 553
    u66._floors_folder.ChildAdded:Connect(function(p67) -- Line: 554
        -- upvalues: u66 (copy)
        u66:_FloorAdded(p67);
    end);
    local _connections = u66._connections;
    local DataChangedSignal = u66.ClientDuel:GetDataChangedSignal("IsSpectating");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 558
        -- upvalues: u66 (copy)
        task.spawn(u66._SetupLightingChange, u66);
        u66:_UpdateSpectating();
    end));

    for _, child in pairs(u66._floors_folder:GetChildren()) do
        task.spawn(u66._FloorAdded, u66, child);
    end;

    u66:_Setup();
    u66:_UpdateSpectating();
    task.spawn(u66._SetupLightingChange, u66);
    u66.ClientDuel:SetReplicate("DuelMusic", "ZombieTower");
end;

return u4;