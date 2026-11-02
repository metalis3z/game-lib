local _ = game:GetService("ServerScriptService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("Players");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v6 = {};
local v7 = require(l_ReplicatedStorage_0.Controllers.EffectController);
local _ = require(l_ReplicatedStorage_0.Controllers.AnimalController);
local v9 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v10 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local v11 = require(l_ReplicatedStorage_0.Controllers.EventController);
local v12 = require(l_ReplicatedStorage_0.Controllers.EventController.ClientEventUtils);
local _ = require(l_ReplicatedStorage_0.Packages.CreateTween);
local v14 = require(l_ReplicatedStorage_0.Packages.Observers);
local _ = require(l_ReplicatedStorage_0.Shared.TweenPivot);
local v16 = require(l_ReplicatedStorage_0.Datas.ServerData);
local _ = require(l_ReplicatedStorage_0.Utils.MathUtils);
local v18 = require(l_ReplicatedStorage_0.Packages.Timer);
local v19 = require(l_ReplicatedStorage_0.Packages.Trove);
local v20 = require(l_ReplicatedStorage_0.Packages.Net);
local v21 = require(l_ReplicatedStorage_0.Packages.Spr);
local v22 = require(l_ReplicatedStorage_0.Shared.VFX);
local _ = require(l_ReplicatedStorage_0.Shared.Snapshot);
local l_Name_0 = script.Name;
local v25 = v20:RemoteEvent("EventService/Chicleteira Bicicleteira/SpawnChicleteira");
local v26 = v20:RemoteEvent("EventService/Chicleteira Bicicleteira/Burst");
local v27 = v19.new();
local function v50()
    local v28 = v27:Extend();
    local v29 = table.create(2);
    v28:Add(function()
        table.clear(v29);
    end);
    local v30 = 0;
    v28:Add(l_RunService_0.PreRender:Connect(function(v31)
        debug.profilebegin("Chicleteira Event");
        v30 = v30 + v31;
        for v32, v33 in v29 do
            if v33.target and v33.targetAttachment then
                v33.beam.First.Enabled = true;
                v33.beam.Second.Enabled = true;
                local v34 = math.clamp(v30 - v32 + 1, 0, 1);
                local l_WorldPosition_0 = v33.beam.WorldPosition;
                v33.targetAttachment.Position = l_WorldPosition_0 + (v33.target:GetPivot().Position - l_WorldPosition_0) * v34;
            end;
        end;
        debug.profileend();
    end));
    v28:Add(v14.observeTag("ChicleteiraPlayerVFX", function(v36)
        local v37 = script.PlayerVFX.Beam:Clone();
        v37.Parent = v36;
        local v38 = script.PlayerVFX[("Torso%*"):format(v36:GetAttribute("ChicleteiraIndex") % 2 + 1)]:Clone();
        v38.Parent = v36;
        local v39 = {};
        local v40 = script.PlayerVFX[("vfxTorso%*"):format(v36:GetAttribute("ChicleteiraIndex") % 2 + 1)]:Clone();
        for _, v42 in v40:GetChildren() do
            v42.Parent = v36;
            table.insert(v39, v42);
        end;
        v40:Destroy();
        local l_v36_Attribute_0 = v36:GetAttribute("ChicleteiraIndex");
        v29[l_v36_Attribute_0] = {
            beam = v37, 
            target = nil
        };
        local v47 = v14.observeTag("ChicleteiraPlayerVFX", function(v44)
            if v44 == v36 then
                return nil;
            elseif v44:GetAttribute("ChicleteiraIndex") ~= v36:GetAttribute("ChicleteiraIndex") % 2 + 1 then
                return nil;
            else
                local l_Attachment_0 = Instance.new("Attachment");
                l_Attachment_0.Position = v37.WorldPosition;
                l_Attachment_0.Parent = workspace.Terrain;
                local v46 = v29[v36:GetAttribute("ChicleteiraIndex")];
                v46.target = v44;
                v46.beam.First.Attachment0 = l_Attachment_0;
                v46.beam.Second.Attachment0 = l_Attachment_0;
                v46.targetAttachment = l_Attachment_0;
                return function()
                    l_Attachment_0:Destroy();
                end;
            end;
        end);
        return function()
            v38:Destroy();
            v37:Destroy();
            for _, v49 in v39 do
                v49:Destroy();
            end;
            v47();
            v29[l_v36_Attribute_0] = nil;
        end;
    end));
end;
v6.OnStart = function(_)
    local l_v11_ActiveEventData_0 = v11:GetActiveEventData(l_Name_0);
    assert(l_v11_ActiveEventData_0);
    l_ReplicatedStorage_0:SetAttribute("ChicleteiraBicicleteiraEvent", true);
    v27:Add(function()
        l_ReplicatedStorage_0:SetAttribute("ChicleteiraBicicleteiraEvent", nil);
        v7:Activate("Blink");
        v10:Update();
        v9:UpdateOST();
        v9:UpdateAmbience();
    end);
    v27:Add(task.delay(l_v11_ActiveEventData_0.startedAt + 2 - workspace:GetServerTimeNow(), function()
        if v16.IsBiggerServer() then
            v27:Clone(script.MapBigger).Parent = workspace;
        else
            v27:Clone(script.Map).Parent = workspace;
        end;
        v27:Add(v14.observeTag("HideInChicleteiraBicicleteira", function(v53)
            local l_Parent_0 = v53.Parent;
            v53.Parent = script;
            return function()
                pcall(function()
                    v53.Parent = l_Parent_0;
                end);
            end;
        end, {
            workspace, 
            script
        }));
        v7:Run("ChicleteiraBicicleteiraEvent", "GrassRecolor");
        v27:Add(function()
            v7:Stop("ChicleteiraBicicleteiraEvent", "GrassRecolor");
        end);
        v7:Run("ChicleteiraBicicleteiraEvent", "WallRecolor");
        v27:Add(function()
            v7:Stop("ChicleteiraBicicleteiraEvent", "WallRecolor");
        end);
        v10:Update();
        v9:UpdateOST();
        v9:UpdateAmbience();
        v7:Activate("Blink");
    end));
    v27:Add(v14.observeTag("Event_ChicleteiraBicicleteira", function(v55)
        local v56 = v55:GetPivot() * CFrame.fromOrientation(0, 3.141592653589793, 0);
        local v57 = v19.new();
        local v58 = v57:Clone(script["Standing Chicleteira Bicicleteira"]);
        v58:PivotTo(v56 - Vector3.new(0, v58:GetExtentsSize().Y, 0));
        v58.Parent = v55;
        local v59 = v58.AnimationController.Animator:LoadAnimation(script.Idle);
        v57:Add(v59, "Stop");
        v57:Add(v59);
        v59.Looped = true;
        v59.Priority = Enum.AnimationPriority.Idle;
        v59:Play();
        local v60 = v58.AnimationController.Animator:LoadAnimation(script.Painting);
        v57:Add(v60, "Stop");
        v57:Add(v60);
        v60.Looped = false;
        v60.Priority = Enum.AnimationPriority.Action4;
        v57:Add(v59:GetMarkerReachedSignal("Shake"):Connect(function(...)
            if v60.IsPlaying then
                return;
            else
                task.spawn(function()
                    v9:PlaySound(l_ReplicatedStorage_0.Sounds.Events["Chicleteira Bicicleteira"].Shake, v56.Position);
                end);
                return;
            end;
        end));
        v57:Add(v55:GetAttributeChangedSignal("ForceSpray"):Connect(function()
            if not v55:GetAttribute("ForceSpray") then
                return;
            else
                task.spawn(function()
                    v9:PlaySound(l_ReplicatedStorage_0.Sounds.Events["Chicleteira Bicicleteira"].Spray, v56.Position);
                end);
                v60:Stop(0);
                v60:Play();
                task.wait(0.3);
                v22.enable(v58.Handle.vfx);
                task.wait(1);
                v22.disable(v58.Handle.vfx);
                return;
            end;
        end));
        v57:Add(task.spawn(function()
            v9:PlaySound(l_ReplicatedStorage_0.Sounds.Events["Chicleteira Bicicleteira"].Ground, v56.Position);
        end));
        v57:Add(v18.Simple(0.1, function()
            local l_v55_Attribute_0 = v55:GetAttribute("ForceSpray");
            local v62 = l_v55_Attribute_0 and v12.getAnimalPosition(l_v55_Attribute_0);
            if v62 then
                v62 = Vector3.new(v62.X, v56.Y, v62.Z);
                v21.target(v58, 1, 2, {
                    Pivot = CFrame.lookAt(v56.Position, v62) * CFrame.fromOrientation(0, 3.141592653589793, 0)
                });
                return;
            else
                v21.target(v58, 1, 2, {
                    Pivot = v56
                });
                return;
            end;
        end, true));
        return v57:WrapClean();
    end, {
        workspace
    }));
    v27:Add(task.spawn(function()
        v50();
    end));
end;
v6.OnStop = function(_)
    v27:Destroy();
end;
v6.OnLoad = function(_)
    task.spawn(pcall, function()
        l_ContentProvider_0:PreloadAsync(script:GetChildren());
    end);
    v26.OnClientEvent:Connect(function(v65)
        v12.playBurst(script.Burst, v65, {
            l_ReplicatedStorage_0.Sounds.Events["Chicleteira Bicicleteira"].Hit
        });
    end);
    v25.OnClientEvent:Connect(function(v66, v67, v68, v69)
        local v70 = script["Chicleteira Bicicleteira"]:Clone();
        v70:PivotTo(v69 or v66);
        v70.Parent = workspace;
        local v71 = v70.AnimationController.Animator:LoadAnimation(script.Walk);
        v71.Looped = true;
        v71:Play();
        v71:AdjustSpeed(2);
        local v72 = v27:Clone(l_ReplicatedStorage_0.Sounds.Events["Chicleteira Bicicleteira"].Bike);
        v72.Parent = v70.PrimaryPart;
        v72:Play();
        local v73 = math.abs(v67.Z - v66.Z) / v68;
        local v74 = 0;
        local v75 = nil;
        v75 = l_RunService_0.PostSimulation:Connect(function(v76)
            v74 = v74 + v76;
            local v77 = math.clamp(v74 / v73, 0, 1);
            if v77 >= 1 and v75 then
                v75:Disconnect();
                v75 = nil;
                v70:Destroy();
            end;
            if v69 ~= nil then
                local v78 = v66:Lerp(v67, v77);
                local v79 = v69:Lerp(v67, v77);
                local v80 = math.clamp(v77 / 0.05, 0, 1);
                local v81 = 5 + (v79.Y - v78.Y);
                local v82 = math.lerp(v79.Y, v78.Y, v80) + math.sin(3.141592653589793 * v80) * v81;
                v70:PivotTo(CFrame.new(v78.X, v82, v79.Z) * v78.Rotation);
                return;
            else
                v70:PivotTo(v66:Lerp(v67, v77), v77);
                return;
            end;
        end);
    end);
end;
return v6;
