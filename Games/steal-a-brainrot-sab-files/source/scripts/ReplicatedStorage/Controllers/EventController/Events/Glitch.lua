

local l_RunService_0 = game:GetService("RunService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("ContentProvider");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v4 = {};
local v5 = require(l_ReplicatedStorage_0.Controllers.AnimalController);
local v6 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v7 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local _ = require(l_ReplicatedStorage_0.Packages.Synchronizer);
local _ = require(l_ReplicatedStorage_0.Packages.FFlags);
local v10 = require(l_ReplicatedStorage_0.Packages.Trove);
local v11 = require(l_ReplicatedStorage_0.Packages.Net);
local v12 = require(l_ReplicatedStorage_0.Shared.VFX);
local v13 = v11:RemoteEvent("EventService/Glitch/HoleEffect");
local _ = script.Name;
local v15 = CFrame.new(-410.752, -9.782, 59.406);
local v16 = v10.new();
v4.OnStart = function(_)
    local _ = Random.new();
    l_ReplicatedStorage_0:SetAttribute("GlitchEvent", true);
    v16:Add(function()
        l_ReplicatedStorage_0:SetAttribute("GlitchEvent", nil);
    end);
    v7:Update();
    v6:UpdateOST();
end;
v4.OnStop = function(_)
    v16:Destroy();
end;
v4.OnLoad = function(_)
    v13.OnClientEvent:Connect(function(v21, v22)
        local v23 = v5:GetAnimals()[v21];
        if not v23 then
            return;
        else
            local v24 = script.Hole:Clone();
            v24:PivotTo(CFrame.new(v15.X, v15.Y + v24.Size.Y * 0.5, v23.Instance:GetPivot().Z + v24.Size.Z * 0.5));
            v24.Parent = workspace;
            task.spawn(function()
                v6:PlaySound("Sounds.Events.Glitch.Hole", v24:GetPivot().Position);
            end);
            local l_Instance_0 = v23.Instance;
            local l_l_Instance_0_Pivot_0 = l_Instance_0:GetPivot();
            local function _(v27)
                return v27 * v27 * 98.1;
            end;
            local v29 = nil;
            v29 = l_RunService_0.PostSimulation:Connect(function(_)
                debug.profilebegin("Glitch:Hole");
                local v31 = workspace:GetServerTimeNow() - v22;
                local v32;
                if v31 < 0.15 then
                    v32 = 0;
                elseif v31 < 1 then
                    local v33 = math.clamp((v31 - 0.15) / 0.85, 0, 1);
                    v32 = -(v33 * v33 * 98.1);
                else
                    local v34 = 15.696000000000002;
                    local v35 = math.clamp((v31 - 1) / 0.5, 0, 1) * 0.4;
                    v32 = v34 - v35 * v35 * 98.1;
                end;
                if v31 >= 1.5 then
                    v29:Disconnect();
                    v24:Destroy();
                elseif v31 >= 1 then
                    v12.disable(v24);
                end;
                l_Instance_0:PivotTo(l_l_Instance_0_Pivot_0 + Vector3.new(0, v32, 0));
                debug.profileend();
            end);
            return;
        end;
    end);
end;
return v4;