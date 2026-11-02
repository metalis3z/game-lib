

local _ = game:GetService("ServerScriptService");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local l_SoundService_0 = game:GetService("SoundService");
local l_HttpService_0 = game:GetService("HttpService");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v9 = {};
local v10 = require(l_ReplicatedStorage_0.Controllers.EncryptedAssetsController);
local v11 = require(l_ReplicatedStorage_0.Controllers.EffectController);
local _ = require(l_ReplicatedStorage_0.Controllers.AnimalController);
local v13 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v14 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local v15 = require(l_ReplicatedStorage_0.Controllers.EventController);
local _ = require(l_ReplicatedStorage_0.Controllers.EventController.ClientEventUtils);
local v17 = require(l_ReplicatedStorage_0.Packages.CreateTween);
local v18 = require(l_ReplicatedStorage_0.Packages.Observers);
local _ = require(l_ReplicatedStorage_0.Utils.MathUtils);
local v20 = require(l_ReplicatedStorage_0.Packages.Timer);
local v21 = require(l_ReplicatedStorage_0.Packages.Trove);
local v22 = require(l_ReplicatedStorage_0.Packages.Net);
local v23 = require(l_ReplicatedStorage_0.Shared.VFX);
local _ = require(l_ReplicatedStorage_0.Shared.Snapshot);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_Name_0 = script.Name;
local l_KarkerMusic_0 = l_SoundService_0.Cutscene.WorkspaceSounds.KarkerMusic;
local v28 = v22:RemoteEvent((("EventService/%*/Spawn"):format(l_Name_0)));
local v29 = v21.new();
local function v46()
    local v30 = v29:Extend();
    local v31 = table.create(4);
    v30:Add(function()
        table.clear(v31);
    end);
    local v32 = 0;
    v30:Add(l_RunService_0.PreRender:Connect(function(v33)
        debug.profilebegin("Karkerkar Kurkur Event");
        v32 = v32 + v33;
        for v34, v35 in v31 do
            if v35.target and v35.targetAttachment then
                v35.beam.First.Enabled = true;
                v35.beam.Second.Enabled = true;
                local v36 = math.clamp(v32 - v34 + 1, 0, 1);
                local l_WorldPosition_0 = v35.beam.WorldPosition;
                v35.targetAttachment.Position = l_WorldPosition_0 + (v35.target:GetPivot().Position - l_WorldPosition_0) * v36;
            end;
        end;
        debug.profileend();
    end));
    v30:Add(v18.observeTag("KarkerkarKurkurPlayerVFX", function(v38)
        local v39 = script.PlayerVFX.Beam:Clone();
        v39.Parent = v38;
        local v40 = script.PlayerVFX.Torso:Clone();
        v40.Parent = v38;
        local l_v38_Attribute_0 = v38:GetAttribute("KarkerkarKurkurIndex");
        v31[l_v38_Attribute_0] = {
            beam = v39, 
            target = nil
        };
        local v45 = v18.observeTag("KarkerkarKurkurPlayerVFX", function(v42)
            if v42 == v38 then
                return nil;
            elseif v42:GetAttribute("KarkerkarKurkurIndex") ~= v38:GetAttribute("KarkerkarKurkurIndex") % 4 + 1 then
                return nil;
            else
                local l_Attachment_0 = Instance.new("Attachment");
                l_Attachment_0.Position = v39.WorldPosition;
                l_Attachment_0.Parent = workspace.Terrain;
                local v44 = v31[v38:GetAttribute("KarkerkarKurkurIndex")];
                v44.target = v42;
                v44.beam.First.Attachment0 = l_Attachment_0;
                v44.beam.Second.Attachment0 = l_Attachment_0;
                v44.targetAttachment = l_Attachment_0;
                return function()
                    l_Attachment_0:Destroy();
                end;
            end;
        end);
        return function()
            v40:Destroy();
            v39:Destroy();
            v45();
            v31[l_v38_Attribute_0] = nil;
        end;
    end));
end;
v9.OnStart = function(_)
    local l_v15_ActiveEventData_0 = v15:GetActiveEventData(l_Name_0);
    assert(l_v15_ActiveEventData_0);
    v29:Add(function()
        v11:Activate("Blink");
        v14:Update();
        v13:UpdateOST();
        v13:UpdateAmbience();
    end);
    v14:Update();
    v13:UpdateOST();
    v13:UpdateAmbience();
    local v49 = v29:Add(Instance.new("Sound"));
    v49.RollOffMode = Enum.RollOffMode.InverseTapered;
    v49.RollOffMinDistance = 35;
    v49.RollOffMaxDistance = 175;
    v49.Looped = true;
    v49.SoundId = "rbxassetid://124977112693561";
    v49.Volume = 0.15;
    v49.SoundGroup = l_KarkerMusic_0;
    local v50 = v29:Clone(l_ReplicatedStorage_0.Sounds.Events["Karkerkar Kurkur"]["Music Box"]);
    local v51 = v29:Add(Instance.new("Sound"));
    v51.SoundId = "rbxassetid://124977112693561";
    v51.Volume = 0;
    v51.SoundGroup = l_KarkerMusic_0;
    v51.Looped = true;
    v51.Parent = l_SoundService_0;
    v29:Add(v49:GetPropertyChangedSignal("TimePosition"):Connect(function()
        v51.TimePosition = v49.TimePosition;
    end));
    l_KarkerMusic_0:SetAttribute("Paused", false);
    l_KarkerMusic_0.Volume = 1;
    v29:Add(task.delay(l_v15_ActiveEventData_0.startedAt + 4 - workspace:GetServerTimeNow(), function()
        local v52 = l_ReplicatedStorage_0:GetAttribute("KarkerkarKurkurEventCFrame") or workspace.Events["Karkerkar Kurkur"].MapCenterGround.Position;
        local v53 = v29:Clone(script.AreaVFX);
        v53:PivotTo(CFrame.new(v52));
        v53.Parent = workspace;
        local v54 = false;
        local function v58()
            local v55 = v54 and not l_LocalPlayer_0:GetAttribute("KarkerkarKurkurEventSeated");
            for _, v57 in l_CollectionService_0:GetTagged("KarkerkarSitPrompt") do
                v57.Enabled = v55 and not v57:GetAttribute("Taken");
            end;
        end;
        local function v63()
            local l_l_ReplicatedStorage_0_Attribute_0 = l_ReplicatedStorage_0:GetAttribute("KarkerkarKurkurEventState");
            if not l_l_ReplicatedStorage_0_Attribute_0 then
                v54 = false;
                return;
            else
                local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
                local v61 = l_HttpService_0:JSONDecode(l_l_ReplicatedStorage_0_Attribute_0);
                if v61.StateChangeTime <= l_workspace_ServerTimeNow_0 then
                    v61.IsPaused = not v61.IsPaused;
                end;
                v54 = v61.IsPaused;
                v58();
                local v62 = (v61.ElapsedSoundTime + (l_workspace_ServerTimeNow_0 - v61.ReplicationTime)) % v49.TimeLength;
                if v61.IsPaused then
                    if not l_KarkerMusic_0:GetAttribute("Paused") then
                        l_KarkerMusic_0:SetAttribute("Paused", true);
                        v23.disable(v53.Area);
                        v17(l_KarkerMusic_0, TweenInfo.new(1), {
                            Volume = 0
                        });
                        if v50 then
                            v50:Play();
                            return;
                        end;
                    end;
                elseif l_KarkerMusic_0:GetAttribute("Paused") then
                    l_KarkerMusic_0:SetAttribute("Paused", false);
                    v23.enable(v53.Area);
                    v49.TimePosition = v62;
                    v51.TimePosition = v62;
                    v17(l_KarkerMusic_0, TweenInfo.new(1), {
                        Volume = 1
                    });
                    if v50 then
                        v50:Stop();
                    end;
                end;
                return;
            end;
        end;
        v29:Add(l_ReplicatedStorage_0:GetAttributeChangedSignal("KarkerkarKurkurEventState"):Connect(v63));
        v29:Add(l_LocalPlayer_0:GetAttributeChangedSignal("KarkerkarKurkurEventSeated"):Connect(v58));
        v29:Add(v20.Simple(0.1, v63, true));
        v29:Add(v18.observeTag("KarkerkarSitPrompt", function(v64)
            v58();
            local v65 = v64:GetAttributeChangedSignal("Taken"):Connect(v58);
            return function()
                v65:Disconnect();
                v58();
            end;
        end, {
            workspace
        }));
        v29:Add(task.spawn(function()
            v10:WaitForAssetId("rbxassetid://124977112693561");
            v49.SoundId = "rbxassetid://124977112693561";
            v51.SoundId = "rbxassetid://124977112693561";
            local v66 = v29:Add(Instance.new("Part"));
            v66.Transparency = 1;
            v66.CFrame = CFrame.new(v52) + Vector3.new(0, 5, 0, 0);
            v66.Anchored = true;
            v66.CanCollide = false;
            v66.CanQuery = false;
            v66.CanTouch = false;
            v66.Parent = workspace;
            v50.Parent = v66;
            v49.Parent = v66;
            local _ = os.clock();
            while not v49.IsLoaded do
                task.wait();
            end;
            task.spawn(v63);
            v49:Play();
            while not v51.IsLoaded do
                task.wait();
            end;
            v51:Play();
        end));
        v29:Add(task.spawn(v58));
        local v68 = {};
        local v69 = {};
        local v70 = {};
        local function _(v71, v72)
            if not table.find(v68, v71) then
                v70[v71] = v72;
                v69[v71] = v71.Position;
                table.insert(v68, v71);
            end;
        end;
        for v74, v75 in {
            v53.Visualizer1, 
            v53.Visualizer2
        } do
            for _, v77 in v75:GetDescendants() do
                if v77:IsA("Beam") then
                    local v78 = v74 == 1 and "Inner" or "Outer";
                    local l_Attachment0_0 = v77.Attachment0;
                    if not table.find(v68, l_Attachment0_0) then
                        v70[l_Attachment0_0] = v78;
                        v69[l_Attachment0_0] = l_Attachment0_0.Position;
                        table.insert(v68, l_Attachment0_0);
                    end;
                    l_Attachment0_0 = v77.Attachment1;
                    if not table.find(v68, l_Attachment0_0) then
                        v70[l_Attachment0_0] = v78;
                        v69[l_Attachment0_0] = l_Attachment0_0.Position;
                        table.insert(v68, l_Attachment0_0);
                    end;
                end;
            end;
        end;
        local v80 = 0;
        v29:Add(l_RunService_0.PreRender:Connect(function(v81)
            debug.profilebegin("Karkerkar Kurkur Musical Chairs Event");
            local l_Spin_0 = v53.Area.Spin;
            l_Spin_0.CFrame = l_Spin_0.CFrame * CFrame.fromOrientation(0, v81 * 0.7853981633974483, 0);
            for _, v84 in (v53.Area.Spin:GetChildren()) do
                local v85 = tonumber(v84.Name) or 0;
                v84.Position = Vector3.new(v84.Position.X, -(math.sin((os.clock() + v85) * 2) * 3 + 4.5), v84.Position.Z);
            end;
            l_Spin_0 = math.clamp(l_KarkerMusic_0.Volume / 1, 0, 1);
            local v86 = math.clamp(v51.PlaybackLoudness / 400, 0, 1) * l_Spin_0;
            v80 = v86 + (v80 - v86) * math.exp(v81 * -10);
            local v87 = math.lerp(-18, -7, l_Spin_0);
            for _, v89 in v68 do
                local v90 = v70[v89] == "Outer" and 4.353 or 3.9;
                local v91 = v69[v89];
                v89.Position = Vector3.new(v91.X, math.lerp(v87, v90, v80), v91.Z);
            end;
            debug.profileend();
        end));
    end));
    v29:Add(task.spawn(function()
        v46();
    end));
end;
v9.OnStop = function(_)
    v29:Destroy();
end;
v9.OnLoad = function(_)
    task.spawn(pcall, function()
        l_ContentProvider_0:PreloadAsync(script:GetChildren());
    end);
    task.spawn(pcall, function()
        l_ContentProvider_0:PreloadAsync(l_ReplicatedStorage_0.Sounds.Events["Karkerkar Kurkur"]:GetChildren());
    end);
    v28.OnClientEvent:Connect(function(v94)
        local v95 = script.SpawnVFX:Clone();
        v95:PivotTo(v94 + Vector3.new(0, 0.05000000074505806, 0, 0));
        v95.Parent = workspace;
        v23.emit(v95);
        task.delay(7, function()
            v95:Destroy();
        end);
        task.delay(2, function()
            v13:PlaySound(l_ReplicatedStorage_0.Sounds.Events["Karkerkar Kurkur"].Spawn, v94.Position, false);
        end);
    end);
end;
return v9;