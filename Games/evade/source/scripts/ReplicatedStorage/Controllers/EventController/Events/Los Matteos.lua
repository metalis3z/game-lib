-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("ServerScriptService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local l_Debris_0 = game:GetService("Debris");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v7 = {};
local v8 = require(l_ReplicatedStorage_0.Controllers.EffectController);
local _ = require(l_ReplicatedStorage_0.Controllers.AnimalController);
local v10 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v11 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local v12 = require(l_ReplicatedStorage_0.Controllers.EventController);
local _ = require(l_ReplicatedStorage_0.Controllers.EventController.ClientEventUtils);
local v14 = require(l_ReplicatedStorage_0.Shared.SharedEventUtils);
local v15 = require(l_ReplicatedStorage_0.Packages.EvLightning);
local v16 = require(l_ReplicatedStorage_0.Packages.CreateTween);
local v17 = require(l_ReplicatedStorage_0.Shared.ShakePresets);
local v18 = require(l_ReplicatedStorage_0.Packages.Observers);
local _ = require(l_ReplicatedStorage_0.Utils.MathUtils);
local _ = require(l_ReplicatedStorage_0.Shared.Snapshot);
local _ = require(script.TreeRootAnimator);
local v22 = require(l_ReplicatedStorage_0.Packages.Shake);
local v23 = require(l_ReplicatedStorage_0.Packages.Trove);
local v24 = require(l_ReplicatedStorage_0.Packages.Net);
local v25 = require(l_ReplicatedStorage_0.Shared.VFX);
local l_Name_0 = script.Name;
local l_Children_0 = script.Clouds:GetChildren();
local l_CloudsStart_0 = workspace.Events["Los Matteos"].CloudsStart;
local l_CloudsEnd_0 = workspace.Events["Los Matteos"].CloudsEnd;
local v30 = v24:RemoteEvent("EventService/Los Matteos/CreateLightningBolt");
local v31 = RaycastParams.new();
v31.FilterDescendantsInstances = {
    workspace.Events["Los Matteos"].Areas
};
v31.FilterType = Enum.RaycastFilterType.Include;
local v32 = v23.new();
local l_Part_0 = Instance.new("Part");
l_Part_0.Anchored = true;
l_Part_0.CanCollide = false;
l_Part_0.TopSurface = Enum.SurfaceType.Smooth;
l_Part_0.BottomSurface = Enum.SurfaceType.Smooth;
l_Part_0.Material = Enum.Material.Neon;
l_Part_0.Color = Color3.fromRGB(96, 234, 255);
local v34 = v22.new();
v34.Amplitude = 3;
v34.Frequency = 0.1;
v34.FadeInTime = 0;
v34.FadeOutTime = 0.6;
v34.PositionInfluence = Vector3.new(0.5, 0.5, 0.5, 0);
v34.RotationInfluence = Vector3.new(2.5, 0.5, 0.5, 0);
local function v51() --[[ Line: 64 ]] --[[ Name: initActivationVisual ]]
    -- upvalues: v32 (copy), l_RunService_0 (copy), v18 (copy)
    local v35 = v32:Extend();
    local v36 = table.create(4);
    v35:Add(function() --[[ Line: 76 ]]
        -- upvalues: v36 (copy)
        table.clear(v36);
    end);
    local v37 = 0;
    v35:Add(l_RunService_0.PreRender:Connect(function(v38) --[[ Line: 81 ]]
        -- upvalues: v37 (ref), v36 (copy)
        debug.profilebegin("Los Matteos Event");
        v37 = v37 + v38;
        for v39, v40 in v36 do
            if v40.target and v40.targetAttachment then
                v40.beam.First.Enabled = true;
                v40.beam.Second.Enabled = true;
                local v41 = math.clamp(v37 - v39 + 1, 0, 1);
                local l_WorldPosition_0 = v40.beam.WorldPosition;
                v40.targetAttachment.Position = l_WorldPosition_0 + (v40.target:GetPivot().Position - l_WorldPosition_0) * v41;
            end;
        end;
        debug.profileend();
    end));
    v35:Add(v18.observeTag("LosMatteosPlayerVFX", function(v43) --[[ Line: 103 ]]
        -- upvalues: v36 (copy), v18 (ref)
        local v44 = script.PlayerVFX.Beam:Clone();
        v44.Parent = v43;
        local v45 = script.PlayerVFX.Torso:Clone();
        v45.Parent = v43;
        local l_v43_Attribute_0 = v43:GetAttribute("LosMatteosIndex");
        v36[l_v43_Attribute_0] = {
            beam = v44, 
            target = nil
        };
        local v50 = v18.observeTag("LosMatteosPlayerVFX", function(v47) --[[ Line: 116 ]]
            -- upvalues: v43 (copy), v44 (copy), v36 (ref)
            if v47 == v43 then
                return nil;
            elseif v47:GetAttribute("LosMatteosIndex") ~= v43:GetAttribute("LosMatteosIndex") % 3 + 1 then
                return nil;
            else
                local l_Attachment_0 = Instance.new("Attachment");
                l_Attachment_0.Position = v44.WorldPosition;
                l_Attachment_0.Parent = workspace.Terrain;
                local v49 = v36[v43:GetAttribute("LosMatteosIndex")];
                v49.target = v47;
                v49.beam.First.Attachment0 = l_Attachment_0;
                v49.beam.Second.Attachment0 = l_Attachment_0;
                v49.targetAttachment = l_Attachment_0;
                return function() --[[ Line: 135 ]]
                    -- upvalues: l_Attachment_0 (copy)
                    l_Attachment_0:Destroy();
                end;
            end;
        end);
        return function() --[[ Line: 140 ]]
            -- upvalues: v45 (copy), v44 (copy), v50 (copy), v36 (ref), l_v43_Attribute_0 (copy)
            v45:Destroy();
            v44:Destroy();
            v50();
            v36[l_v43_Attribute_0] = nil;
        end;
    end));
end;
v7.OnStart = function(_) --[[ Line: 150 ]] --[[ Name: OnStart ]]
    -- upvalues: v12 (copy), l_Name_0 (copy), l_ReplicatedStorage_0 (copy), v31 (copy), v32 (copy), v8 (copy), v11 (copy), v10 (copy), v16 (copy), v18 (copy), l_Players_0 (copy), l_CloudsStart_0 (copy), l_CloudsEnd_0 (copy), l_Children_0 (copy), l_RunService_0 (copy), v14 (copy), v30 (copy), v34 (copy), v17 (copy), v25 (copy), l_Debris_0 (copy), v15 (copy), l_Part_0 (copy), v51 (copy)
    local l_v12_ActiveEventData_0 = v12:GetActiveEventData(l_Name_0);
    assert(l_v12_ActiveEventData_0);
    local l_l_ReplicatedStorage_0_Attribute_0 = l_ReplicatedStorage_0:GetAttribute("LosMatteosSpawn");
    if not l_l_ReplicatedStorage_0_Attribute_0 then
        l_l_ReplicatedStorage_0_Attribute_0 = workspace.MapCenter.Position;
        local v55 = workspace:Raycast(l_l_ReplicatedStorage_0_Attribute_0, Vector3.new(-0, -25, -0, -0), v31);
        if v55 then
            l_l_ReplicatedStorage_0_Attribute_0 = Vector3.new(l_l_ReplicatedStorage_0_Attribute_0.X, v55.Position.Y, l_l_ReplicatedStorage_0_Attribute_0.Z);
        end;
    end;
    l_ReplicatedStorage_0:SetAttribute("LosMatteosEvent", true);
    v32:Add(function() --[[ Line: 164 ]]
        -- upvalues: l_ReplicatedStorage_0 (ref), v8 (ref), v11 (ref), v10 (ref)
        l_ReplicatedStorage_0:SetAttribute("LosMatteosEvent", nil);
        v8:Activate("Blink");
        v11:Update();
        v10:UpdateOST();
        v10:UpdateAmbience();
    end);
    local function _(v56) --[[ Line: 173 ]] --[[ Name: calculateTimeLeftFor ]]
        -- upvalues: l_v12_ActiveEventData_0 (copy)
        return l_v12_ActiveEventData_0.startedAt + v56 - workspace:GetServerTimeNow();
    end;
    local function v84(v58, v59, v60) --[[ Line: 177 ]] --[[ Name: growTree ]]
        -- upvalues: v32 (ref), v16 (ref)
        local function v71(v61, v62, v63, v64) --[[ Line: 178 ]] --[[ Name: growPart ]]
            -- upvalues: v32 (ref), v60 (copy), v16 (ref)
            local l_CFrame_0 = v61.CFrame;
            local v66 = Vector3.new(v64 and 0 or v62.X, 0, v64 and 0 or v62.Z);
            local v67 = l_CFrame_0 * CFrame.new(0, -(v62.Y - v66.Y) / 2, 0);
            v61.Size = v66;
            v61.CFrame = v67;
            local l_Transparency_0 = v61.Transparency;
            v61.Transparency = 1;
            v32:Add(task.delay(if v60 then v60(v63) else v63, function() --[[ Line: 189 ]]
                -- upvalues: v61 (copy), l_Transparency_0 (copy), v60 (ref), v63 (copy), v16 (ref), v62 (copy), l_CFrame_0 (copy)
                v61.Transparency = l_Transparency_0;
                local v69 = if v60 then v60(v63 + 1) else 1;
                local v70 = TweenInfo.new(v69, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
                v16(v61, v70, {
                    Size = v62
                });
                v16(v61, v70, {
                    CFrame = l_CFrame_0
                });
            end));
        end;
        local v72 = {};
        local v73 = 1e999;
        local v74 = -1e999;
        for _, v76 in v58:GetDescendants() do
            if v76:IsA("BasePart") and v76.Transparency < 1 then
                table.insert(v72, v76);
                v73 = math.min(v73, v76.Position.Y);
                v74 = math.max(v74, v76.Position.Y);
            end;
        end;
        table.sort(v72, function(v77, v78) --[[ Line: 215 ]]
            return v77.Position.Y < v78.Position.Y;
        end);
        local v79 = v74 - v73;
        for _, v81 in v72 do
            local v82 = v81.Color.R * 255 < 90;
            local v83 = (v81.Position.Y - v73) / v79 * v59;
            if v82 then
                v83 = v83 + 0.2;
            end;
            v71(v81, v81.Size, v83, v82);
        end;
    end;
    v32:Add(task.spawn(function() --[[ Line: 231 ]]
        -- upvalues: v10 (ref), l_ReplicatedStorage_0 (ref), l_l_ReplicatedStorage_0_Attribute_0 (ref)
        v10:PlaySound(l_ReplicatedStorage_0.Sounds.Events["Los Matteos"].Grow, l_l_ReplicatedStorage_0_Attribute_0, false);
    end));
    v32:Add(task.delay(l_v12_ActiveEventData_0.startedAt + 3 - workspace:GetServerTimeNow(), function() --[[ Line: 235 ]]
        -- upvalues: l_ReplicatedStorage_0 (ref), v32 (ref), v11 (ref), v10 (ref), l_l_ReplicatedStorage_0_Attribute_0 (ref), v84 (copy), l_v12_ActiveEventData_0 (copy)
        l_ReplicatedStorage_0:SetAttribute("LosMatteosEventNightTime", true);
        v32:Add(function() --[[ Line: 237 ]]
            -- upvalues: l_ReplicatedStorage_0 (ref)
            l_ReplicatedStorage_0:SetAttribute("LosMatteosEventNightTime", nil);
        end);
        v11:Update();
        v10:UpdateOST();
        v10:UpdateAmbience();
        local v85 = v32:Clone(script.Tree);
        v85:PivotTo(CFrame.new(l_l_ReplicatedStorage_0_Attribute_0));
        if l_ReplicatedStorage_0:GetAttribute("LosMatteosEventIsRainbow") then
            for _, v87 in v85.Leaves:GetDescendants() do
                v87:SetAttribute("RainbowIgnoreTransparency", true);
                v87:AddTag("RainbowModel");
            end;
        end;
        v85.Parent = workspace;
        v84(v85, 5, function(v88) --[[ Line: 257 ]]
            -- upvalues: l_v12_ActiveEventData_0 (ref)
            local v89 = v88 + 3;
            return l_v12_ActiveEventData_0.startedAt + v89 - workspace:GetServerTimeNow();
        end);
    end));
    v32:Add(task.delay(l_v12_ActiveEventData_0.startedAt + 7 - workspace:GetServerTimeNow(), function() --[[ Line: 262 ]]
        -- upvalues: l_ReplicatedStorage_0 (ref)
        l_ReplicatedStorage_0.Sounds.Events["Los Matteos"].Roots:Play();
    end));
    v32:Add(function() --[[ Line: 266 ]]
        -- upvalues: l_ReplicatedStorage_0 (ref)
        l_ReplicatedStorage_0.Sounds.Events["Los Matteos"].Roots:Stop();
    end);
    v32:Add(l_ReplicatedStorage_0:GetAttributeChangedSignal("LosMatteosGrowing"):Connect(function() --[[ Line: 270 ]]
        -- upvalues: l_ReplicatedStorage_0 (ref)
        l_ReplicatedStorage_0.Sounds.Events["Los Matteos"].Roots.Looped = l_ReplicatedStorage_0:GetAttribute("LosMatteosGrowing") ~= false;
    end));
    v32:Add(v18.observeTag("LosMatteos_Tree", function(v90) --[[ Line: 274 ]]
        -- upvalues: v84 (copy)
        v84(v90, 1);
        return nil;
    end));
    v32:Add(v18.observeCharacter(l_Players_0.LocalPlayer, function(_, v92) --[[ Line: 279 ]]
        -- upvalues: v32 (ref), v18 (ref)
        return v32:Add(v18.observeAttribute(v92, "Matteo_CollectedTree", function(v93) --[[ Line: 280 ]]
            -- upvalues: v32 (ref), v18 (ref)
            if not v93 then
                return nil;
            else
                return v32:Add(v18.observeTag("LosMatteos_TreePrompt", function(v94) --[[ Line: 286 ]]
                    v94.Enabled = false;
                    return function() --[[ Line: 290 ]]
                        -- upvalues: v94 (copy)
                        v94.Enabled = true;
                    end;
                end, {
                    workspace
                }));
            end;
        end));
    end));
    local v95 = {};
    local function v117() --[[ Line: 306 ]] --[[ Name: startClouds ]]
        -- upvalues: l_CloudsStart_0 (ref), l_CloudsEnd_0 (ref), v32 (ref), l_Children_0 (ref), v16 (ref), v95 (copy), l_RunService_0 (ref), v14 (ref)
        local function v106(v96, v97) --[[ Line: 310 ]] --[[ Name: spawnCloud ]]
            -- upvalues: l_CloudsStart_0 (ref), l_CloudsEnd_0 (ref), v32 (ref), l_Children_0 (ref), v16 (ref), v95 (ref)
            local l_Position_0 = l_CloudsStart_0.Position;
            local l_Size_0 = l_CloudsStart_0.Size;
            local l_Position_1 = l_CloudsEnd_0.Position;
            local v101 = v32:Clone(l_Children_0[math.random(1, #l_Children_0)]);
            v101.Transparency = 1;
            v101.CFrame = CFrame.new(l_Position_0.X + math.random(-l_Size_0.X * 0.5, l_Size_0.X * 0.5), l_Position_0.Y, l_Position_0.Z + (v96 or 0) * 30 + (v97 or 0));
            local v102 = Vector3.new(v101.Position.X, l_Position_0.Y, l_Position_1.Z);
            if vector.dot(l_Position_1 - l_Position_0, v102 - v101.Position) < 0 then
                return;
            else
                v101.Parent = workspace.Camera;
                local v103 = math.clamp(50 / v101.Size.Magnitude, 5, 15) * (math.random(80, 120) / 100);
                local v104 = {
                    instance = v101, 
                    speed = v103, 
                    startPos = v101.Position, 
                    endPos = v102
                };
                local v105 = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, (v97 or 0) * 0.1 + (math.abs(v96 or 0) + 1) * 0.5);
                v32:Add(v16(v101, v105, {
                    Transparency = 0
                }));
                table.insert(v95, v104);
                return v104;
            end;
        end;
        local v107 = 0;
        for v108 = 1, 50 do
            v106(v107, v108);
            if v108 % 3 == 1 then
                v107 = v107 + 1;
            end;
        end;
        v32:Add(l_RunService_0.PostSimulation:Connect(function(v109) --[[ Line: 360 ]]
            -- upvalues: v95 (ref), v32 (ref), v16 (ref), v106 (copy), v14 (ref)
            debug.profilebegin("Los Matteos:Clouds");
            for v110 = #v95, 1, -1 do
                local v111 = v95[v110];
                local l_instance_0 = v111.instance;
                local l_Position_2 = l_instance_0.Position;
                local v114 = vector.normalize(v111.endPos - l_Position_2);
                local v115 = vector.magnitude(v111.endPos - l_Position_2);
                local v116 = v111.speed * v109;
                if v115 < v116 then
                    l_Position_2 = v111.endPos;
                    table.remove(v95, v110);
                    v32:Add(v16(l_instance_0, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        Transparency = 1
                    })).Completed:Once(function() --[[ Line: 380 ]]
                        -- upvalues: v32 (ref), l_instance_0 (copy)
                        v32:Remove(l_instance_0);
                    end);
                    v106();
                else
                    l_Position_2 = l_Position_2 + v114 * v116;
                end;
                v14.pushPartCFrame(l_instance_0, CFrame.lookAt(l_Position_2, l_Position_2 + v114));
            end;
            debug.profileend();
        end));
    end;
    v32:Add(task.delay(l_v12_ActiveEventData_0.startedAt + 8 - workspace:GetServerTimeNow(), function() --[[ Line: 396 ]]
        -- upvalues: v32 (ref)
        v32:Clone(script.RainWeather).Parent = workspace;
    end));
    v32:Add(v30.OnClientEvent:Connect(function(v118, v119, v120) --[[ Line: 401 ]]
        -- upvalues: v34 (ref), v32 (ref), v17 (ref), v95 (copy), v10 (ref), l_ReplicatedStorage_0 (ref), v16 (ref), v25 (ref), l_Debris_0 (ref), v15 (ref), l_Part_0 (ref)
        local v121 = Random.new(v118);
        local l_Magnitude_0 = (workspace.CurrentCamera.CFrame.Position - v119).Magnitude;
        if l_Magnitude_0 <= 75 then
            local v123 = v34:Clone();
            local v124 = (1 - l_Magnitude_0 / 75 * 0.5) ^ 2;
            v123.Amplitude = v123.Amplitude * v124;
            v123.RotationInfluence = v123.RotationInfluence * v124;
            v32:Add(v17.BindShakeToCamera(v123));
            v123:Start();
        end;
        local v125 = {};
        for _, v127 in v95 do
            if ((v127.instance.Position - v119) * Vector3.new(1, 0, 1, 0)).Magnitude < 100 then
                table.insert(v125, v127.instance);
            end;
        end;
        local v128 = nil;
        if #v125 > 0 then
            local v129 = v125[v121:NextInteger(1, #v125)];
            v128 = v129.Position;
            v10:PlaySound(l_ReplicatedStorage_0.Sounds.Events["Los Matteos"]["Lightning Strike"], v129.Position, false);
            local l_Color_0 = v129.Color;
            v129.Color = Color3.fromRGB(90, 109, 161);
            v16(v129, TweenInfo.new(1, Enum.EasingStyle.Sine), {
                Color = l_Color_0
            });
            for _, v132 in script.CloudParticles:GetChildren() do
                local v133 = v132:Clone();
                v133.Parent = v129;
                v25.emit(v133);
                l_Debris_0:AddItem(v133, 2);
            end;
        else
            v128 = v119 + Vector3.new(0, 70, 0, 0);
        end;
        local v134 = v15.create(v128, v119, {
            bends = 4, 
            thickness = 1, 
            max_depth = 1, 
            fork_bends = 1, 
            fork_chance = 30, 
            decay = 3, 
            material = Enum.Material.Neon
        });
        local l_Model_0 = Instance.new("Model");
        v134.model = l_Model_0;
        l_Model_0.Name = "LightningBolt";
        local l_v134_Lines_0 = v134:GetLines();
        table.sort(l_v134_Lines_0, function(v137, v138) --[[ Line: 467 ]]
            return v137.origin.Y > v138.origin.Y;
        end);
        local l_Y_0 = l_v134_Lines_0[#l_v134_Lines_0].origin.Y;
        local l_Y_1 = l_v134_Lines_0[1].origin.Y;
        local v141 = l_Y_1 - l_Y_0;
        local v142 = v134.random:NextInteger(10, 20) / 100;
        local v143 = table.create(#l_v134_Lines_0);
        for v144, v145 in l_v134_Lines_0 do
            if v145.goal.Y >= v119.Y then
                local v146 = math.max((l_Y_1 - v145.origin.Y) / v141 * v142, 0);
                local v147 = l_Part_0:Clone();
                v147.Size = Vector3.new(v134.thickness - v145.depth * 2 * 0.1, v134.thickness - v145.depth * 2 * 0.1, (v145.origin - v145.goal).Magnitude + 0.5);
                v147.CFrame = CFrame.new((v145.goal + v145.origin) / 2, v145.goal);
                v147.Transparency = 1;
                v147.Parent = l_Model_0;
                v143[v144] = v147;
                v16(v147, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, v146), {
                    Transparency = v145.transparency
                });
            end;
        end;
        task.delay(v142 + 0.05, function() --[[ Line: 498 ]]
            -- upvalues: v120 (copy), v119 (copy), v25 (ref), v10 (ref), l_ReplicatedStorage_0 (ref), v143 (copy), v16 (ref), v134 (copy), l_Model_0 (copy)
            local v148 = if v120 then script.StrikeBrainrot:Clone() else script.Strike:Clone();
            v148.Position = v119;
            v148.Parent = workspace;
            v25.emit(v148);
            if v120 then
                v10:PlaySound(l_ReplicatedStorage_0.Sounds.Events["Los Matteos"].Hit, v119, false);
            else
                v10:PlaySound(l_ReplicatedStorage_0.Sounds.Events["Los Matteos"].HitNothing, v119, false);
            end;
            for _, v150 in v143 do
                task.spawn(function() --[[ Line: 512 ]]
                    -- upvalues: v150 (copy), v16 (ref)
                    v150.Transparency = 0;
                    task.wait(0.1);
                    v150.Transparency = 1;
                    task.wait(0.1);
                    v16(v150, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true), {
                        Transparency = 0.4
                    });
                end);
            end;
            task.delay(v134.options.decay or 1, function() --[[ Line: 523 ]]
                -- upvalues: v148 (copy), l_Model_0 (ref), v134 (ref)
                v148:Destroy();
                l_Model_0:Destroy();
                v134.destroyed = true;
            end);
        end);
        l_Model_0.Parent = workspace.CurrentCamera;
        v134.drew = true;
    end));
    v117();
    v32:Add(task.spawn(function() --[[ Line: 536 ]]
        -- upvalues: v51 (ref)
        v51();
    end));
end;
v7.OnStop = function(_) --[[ Line: 541 ]] --[[ Name: OnStop ]]
    -- upvalues: v32 (copy)
    v32:Destroy();
end;
v7.OnLoad = function(_) --[[ Line: 545 ]] --[[ Name: OnLoad ]]
    -- upvalues: l_ContentProvider_0 (copy)
    task.spawn(pcall, function() --[[ Line: 546 ]]
        -- upvalues: l_ContentProvider_0 (ref)
        l_ContentProvider_0:PreloadAsync(script:GetChildren());
    end);
end;
return v7;