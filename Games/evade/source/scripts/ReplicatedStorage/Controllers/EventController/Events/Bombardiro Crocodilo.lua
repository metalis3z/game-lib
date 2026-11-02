-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("Players");
local _ = game:GetService("Debris");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v6 = {};
local _ = require(l_ReplicatedStorage_0.Controllers.AnimalController);
local v8 = require(l_ReplicatedStorage_0.Controllers.EffectController);
local v9 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v10 = require(l_ReplicatedStorage_0.Controllers.EventController);
local v11 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local _ = require(l_ReplicatedStorage_0.Shared.ShakePresets);
local v13 = require(l_ReplicatedStorage_0.Packages.Observers);
local _ = require(l_ReplicatedStorage_0.Shared.TweenPivot);
local v15 = require(l_ReplicatedStorage_0.Utils.MathUtils);
local v16 = require(l_ReplicatedStorage_0.Packages.Trove);
local _ = require(l_ReplicatedStorage_0.Packages.Shake);
local v18 = require(l_ReplicatedStorage_0.Packages.Net);
local v19 = require(l_ReplicatedStorage_0.Shared.VFX);
local v20 = script["Svinina Bombardino"];
local v21 = script["Bombardiro Crocodilo"];
local v22 = v18:RemoteEvent("EventService/Bombardiro Crocodilo/SpawnBomb");
local v23 = v18:RemoteEvent("EventService/Bombardiro Crocodilo/Explode");
local l_Name_0 = script.Name;
local v25 = v16.new();
local _ = workspace.CurrentCamera;
local v27 = {};
v6.OnStart = function(_) --[[ Line: 39 ]] --[[ Name: OnStart ]]
    -- upvalues: v10 (copy), l_Name_0 (copy), l_ReplicatedStorage_0 (copy), v25 (copy), v19 (copy), v9 (copy), v8 (copy), v11 (copy), l_RunService_0 (copy), v13 (copy), v21 (copy), v27 (copy)
    local l_v10_ActiveEventData_0 = v10:GetActiveEventData(l_Name_0);
    assert(l_v10_ActiveEventData_0);
    local _ = workspace:GetServerTimeNow();
    l_ReplicatedStorage_0:SetAttribute("BombardiroCrocodiloEvent", true);
    v25:Add(function() --[[ Line: 46 ]]
        -- upvalues: l_ReplicatedStorage_0 (ref)
        l_ReplicatedStorage_0:SetAttribute("BombardiroCrocodiloEvent", nil);
    end);
    v25:Add(task.delay(l_v10_ActiveEventData_0.startedAt + 8 - workspace:GetServerTimeNow(), function() --[[ Line: 50 ]]
        -- upvalues: v25 (ref), v19 (ref), l_ReplicatedStorage_0 (ref), v9 (ref), v8 (ref)
        local v31 = v25:Clone(script.Planesbg);
        v19.enable(v31);
        v31.Parent = workspace;
        l_ReplicatedStorage_0:SetAttribute("BombardiroCrocodiloEventSoundTrack", true);
        v9:UpdateOST();
        v25:Add(function() --[[ Line: 57 ]]
            -- upvalues: l_ReplicatedStorage_0 (ref), v9 (ref), v8 (ref)
            l_ReplicatedStorage_0:SetAttribute("BombardiroCrocodiloEventSoundTrack", nil);
            v9:UpdateOST();
            v8:Activate("Blink");
        end);
    end));
    v9:UpdateOST();
    v11:Update();
    local v32 = v25:Extend();
    local v33 = table.create(3);
    v32:Add(function() --[[ Line: 79 ]]
        -- upvalues: v33 (copy)
        table.clear(v33);
    end);
    local v34 = 0;
    v32:Add(l_RunService_0.PreRender:Connect(function(v35) --[[ Line: 84 ]]
        -- upvalues: v34 (ref), v33 (copy)
        debug.profilebegin("Bombardiro Event");
        v34 = v34 + v35;
        for v36, v37 in v33 do
            if v37.target and v37.targetAttachment then
                v37.beam.First.Enabled = true;
                v37.beam.Second.Enabled = true;
                local v38 = math.clamp(v34 - v36 + 1, 0, 1);
                local l_WorldPosition_0 = v37.beam.WorldPosition;
                v37.targetAttachment.Position = l_WorldPosition_0 + (v37.target:GetPivot().Position - l_WorldPosition_0) * v38;
            end;
        end;
        debug.profileend();
    end));
    v32:Add(v13.observeTag("BombardiroCrocodiloPlayerVFX", function(v40) --[[ Line: 106 ]]
        -- upvalues: v33 (copy), v13 (ref)
        local v41 = script.PlayerVFX.Beam:Clone();
        v41.Parent = v40;
        local v42 = script.PlayerVFX.Torso:Clone();
        v42.Parent = v40;
        local l_v40_Attribute_0 = v40:GetAttribute("BombardiroIndex");
        v33[l_v40_Attribute_0] = {
            beam = v41, 
            target = nil
        };
        local v47 = v13.observeTag("BombardiroCrocodiloPlayerVFX", function(v44) --[[ Line: 119 ]]
            -- upvalues: v40 (copy), v41 (copy), v33 (ref)
            if v44 == v40 then
                return nil;
            elseif v44:GetAttribute("BombardiroIndex") ~= v40:GetAttribute("BombardiroIndex") % 3 + 1 then
                return nil;
            else
                local l_Attachment_0 = Instance.new("Attachment");
                l_Attachment_0.Position = v41.WorldPosition;
                l_Attachment_0.Parent = workspace.Terrain;
                local v46 = v33[v40:GetAttribute("BombardiroIndex")];
                v46.target = v44;
                v46.beam.First.Attachment0 = l_Attachment_0;
                v46.beam.Second.Attachment0 = l_Attachment_0;
                v46.targetAttachment = l_Attachment_0;
                return function() --[[ Line: 138 ]]
                    -- upvalues: l_Attachment_0 (copy)
                    l_Attachment_0:Destroy();
                end;
            end;
        end);
        return function() --[[ Line: 143 ]]
            -- upvalues: v42 (copy), v41 (copy), v47 (copy), v33 (ref), l_v40_Attribute_0 (copy)
            v42:Destroy();
            v41:Destroy();
            v47();
            v33[l_v40_Attribute_0] = nil;
        end;
    end));
    local v48 = {};
    v25:Add(v13.observeTag("BombardiroPlane", function(v49) --[[ Line: 153 ]]
        -- upvalues: v21 (ref), v27 (ref), v48 (copy)
        local v50 = v21:Clone();
        v50.PrimaryPart.Anchored = true;
        for _, v52 in v50["Svinina Bombardino"]:GetChildren() do
            if v52.Name ~= "RootPart" then
                v52.Transparency = 1;
            end;
        end;
        v50.Parent = v49;
        local v55 = task.delay(5, function() --[[ Line: 167 ]]
            -- upvalues: v50 (copy)
            for _, v54 in v50["Svinina Bombardino"]:GetChildren() do
                if v54.Name ~= "RootPart" then
                    v54.Transparency = 0;
                end;
            end;
        end);
        v27[v49.Name] = v50;
        table.insert(v48, v49);
        return function() --[[ Line: 180 ]]
            -- upvalues: v48 (ref), v49 (copy), v50 (copy), v27 (ref), v55 (copy)
            local v56 = table.find(v48, v49);
            if v56 then
                table.remove(v48, v56);
            end;
            v50:Destroy();
            v27[v49.Name] = nil;
            if coroutine.status(v55) == "suspended" then
                pcall(task.cancel, v55);
            end;
        end;
    end));
    v25:Add(l_RunService_0.PreRender:Connect(function(_) --[[ Line: 195 ]]
        -- upvalues: v48 (copy), v27 (ref)
        debug.profilebegin("Bombardiro Crocodilo:BulkMoveTo");
        local v58 = {};
        local v59 = {};
        for _, v61 in v48 do
            local v62 = v27[v61.Name];
            if v62 then
                table.insert(v58, v62.PrimaryPart);
                table.insert(v59, v61.CFrame);
            end;
        end;
        workspace:BulkMoveTo(v58, v59, Enum.BulkMoveMode.FireCFrameChanged);
        debug.profileend();
    end));
end;
v6.OnStop = function(_) --[[ Line: 212 ]] --[[ Name: OnStop ]]
    -- upvalues: v25 (copy)
    v25:Destroy();
end;
v6.OnLoad = function(_) --[[ Line: 216 ]] --[[ Name: OnLoad ]]
    -- upvalues: v19 (copy), v22 (copy), v27 (copy), v20 (copy), l_ReplicatedStorage_0 (copy), v15 (copy), l_RunService_0 (copy), v23 (copy)
    local function v68(v65, v66) --[[ Line: 217 ]] --[[ Name: playExplosion ]]
        -- upvalues: v19 (ref)
        local v67 = script[v66 or "Explosion"]:Clone();
        v67.CFrame = v65;
        v67.Parent = workspace;
        v19.emit(v67);
        task.delay(5, function() --[[ Line: 224 ]]
            -- upvalues: v67 (copy)
            v67:Destroy();
        end);
    end;
    v22.OnClientEvent:Connect(function(v69, v70, v71) --[[ Line: 229 ]]
        -- upvalues: v27 (ref), v20 (ref), l_ReplicatedStorage_0 (ref), v15 (ref), l_RunService_0 (ref)
        local v72 = v27[v69];
        if v72 and v72:FindFirstChild("Svinina Bombardino") then
            for _, v74 in v72["Svinina Bombardino"]:GetChildren() do
                if v74.Name ~= "RootPart" then
                    v74.Transparency = 1;
                    task.delay(1, function() --[[ Line: 238 ]]
                        -- upvalues: v74 (copy)
                        v74.Transparency = 0;
                    end);
                end;
            end;
        end;
        local v75 = v20:Clone();
        v75.PrimaryPart.Anchored = true;
        v75:PivotTo(CFrame.new(v70));
        local v76 = l_ReplicatedStorage_0.Sounds.Events["Bombardiro Crocodilo"].DroppingBomb:Clone();
        v76.Parent = v75;
        v75.Parent = workspace;
        v76:Play();
        local v77 = 0;
        local v78 = v15.calculateTimeToGround(v70.y, v71.y);
        local v79 = nil;
        v79 = l_RunService_0.PostSimulation:Connect(function(v80) --[[ Line: 259 ]]
            -- upvalues: v77 (ref), v78 (copy), v75 (copy), v70 (copy), v15 (ref), v79 (ref)
            debug.profilebegin("Bombardiro Crocodilo:Bomb");
            v77 = v77 + v80;
            local v81 = v77 / v78;
            v75:PivotTo(CFrame.new(v70 - vector.create(0, v15.simulateGravity(v77), 0)) * CFrame.Angles(-v77 * 3.141592653589793 * 2, 0, 0));
            debug.profileend();
            if v81 >= 1 then
                v79:Disconnect();
                for _, v83 in v75:GetDescendants() do
                    if v83:IsA("BasePart") then
                        v83.Transparency = 1;
                    elseif v83:IsA("ParticleEmitter") then
                        v83:Destroy();
                    end;
                end;
                task.wait(3);
                v75:Destroy();
            end;
        end);
    end);
    v23.OnClientEvent:Connect(function(v84, v85) --[[ Line: 283 ]]
        -- upvalues: v68 (copy)
        v68(if typeof(v84) == "CFrame" then v84 else CFrame.new(v84), v85);
    end);
end;
return v6;