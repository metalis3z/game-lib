

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("Players");
local _ = game:GetService("Debris");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v6 = {};
local _ = l_ReplicatedStorage_0.Models.Events["La Vacca"];
local v8 = require(l_ReplicatedStorage_0.Controllers.AnimalController);
local v9 = require(l_ReplicatedStorage_0.Controllers.EffectController);
local v10 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v11 = require(l_ReplicatedStorage_0.Controllers.EventController);
local v12 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local v13 = require(l_ReplicatedStorage_0.Shared.ShakePresets);
local v14 = require(l_ReplicatedStorage_0.Packages.Observers);
local _ = require(l_ReplicatedStorage_0.Shared.TweenPivot);
local v16 = require(l_ReplicatedStorage_0.Packages.Trove);
local _ = require(l_ReplicatedStorage_0.Packages.Shake);
local v18 = require(l_ReplicatedStorage_0.Packages.Net):RemoteEvent("EventService/LaVacca/Comet");
local l_Name_0 = script.Name;
local v20 = v16.new();
local l_CurrentCamera_0 = workspace.CurrentCamera;
v6.OnStart = function(_)
    local l_v11_ActiveEventData_0 = v11:GetActiveEventData(l_Name_0);
    assert(l_v11_ActiveEventData_0);
    local _ = workspace:GetServerTimeNow();
	local v25 = l_v11_ActiveEventData_0.startedAt + 11 - workspace:GetServerTimeNow();
	
	if v25 > 0 then
		local v26 = v20:Extend();
		local v27 = v26:Add(Instance.new("Model"));
		local v28 = v26:Add(Instance.new("Part"));
		v28.Name = "Center";
		v28.Transparency = 1;
		v28.Anchored = true;
		v28.CanCollide = false;
		v28.CanQuery = false;
		v28.CanTouch = false;
		v28.Size = Vector3.new(1, 1, 1);
		v28.Position = l_ReplicatedStorage_0:GetAttribute("LaVaccaCenter") or workspace.MapCenter.Position;
		v28.Parent = v27;
		v27.PrimaryPart = v28;
		v27.Parent = workspace;
		v10:PlaySound(game.ReplicatedStorage.Sounds.Events["La Vacca Saturno Saturnita"].EventActivation, v28.Position)
		local v29 = table.create(3);

		local function createTriangleFallback(index)
			local angle = math.rad((index - 1) * 120)
			local radius = 15
			local offset = Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)

			local v38 = script.PlayerVFX.Beam:Clone();
			v38.Parent = v28; 

			local l_Attachment_0 = Instance.new("Attachment");
			l_Attachment_0.Position = v28.Position + offset;
			l_Attachment_0.Parent = workspace.Terrain;

			v38.First.Attachment0 = l_Attachment_0;
			v38.Second.Attachment0 = l_Attachment_0;

			v29[index] = {
				beam = v38,
				target = nil,
				targetAttachment = l_Attachment_0,
				isFallback = true
			};
		end

		for i = 1, 3 do
			createTriangleFallback(i)
		end

		v26:Add(function() 
			for _, data in v29 do
				if data.beam then data.beam:Destroy() end
				if data.targetAttachment then data.targetAttachment:Destroy() end
			end
			table.clear(v29);
		end);

		local l_v30_0 = 0;
		v26:Add(l_RunService_0.PreRender:Connect(function(v32)
			debug.profilebegin("La Vacca Event");
			l_v30_0 = l_v30_0 + v32;

			local l_workspace_ServerTimeNow_1 = workspace:GetServerTimeNow();

			local v48 = math.clamp(1 - (l_v11_ActiveEventData_0.startedAt + 11 - l_workspace_ServerTimeNow_1) / 8, 0, 1);
			local currentVerticalOffset = v48 * v48 * 150; 

			local rotationSpeed = 6;
			local rotationAngle = l_workspace_ServerTimeNow_1 * rotationSpeed;

			for v33, v34 in v29 do
				if v34.beam then
					v34.beam.First.Enabled = true;
					v34.beam.Second.Enabled = true;

					if v34.isFallback and v34.targetAttachment then
						local angle = math.rad((v33 - 1) * 120) + rotationAngle;
						local radius = 15;

						local horizontalOffset = Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius);

						v34.targetAttachment.Position = v28.Position + horizontalOffset + Vector3.new(0, currentVerticalOffset, 0);

					elseif v34.target and v34.targetAttachment then
						local v35 = math.clamp(l_v30_0 - v33 + 1, 0, 1);
						local l_WorldPosition_0 = v34.beam.WorldPosition;
						v34.targetAttachment.Position = l_WorldPosition_0 + (v34.target:GetPivot().Position - l_WorldPosition_0) * v35;
					end
				end
			end;
			debug.profileend();
		end));

		v26:Add(v14.observeTag("LaVaccaModel", function(v37)
			local index = v37:GetAttribute("LaVaccaIndex")

			if v29[index] and v29[index].isFallback then
				v29[index].beam:Destroy()
				v29[index].targetAttachment:Destroy()
				v29[index] = nil
			end

			v37.Parent = v27;
			local v38 = script.PlayerVFX.Beam:Clone();
			v38.Parent = v37.PrimaryPart;

			v29[index] = {
				beam = v38, 
				target = nil
			};

			local v42 = v14.observeTag("LaVaccaModel", function(v39)
				if v39 == v37 then return nil; end
				if v39:GetAttribute("LaVaccaIndex") ~= v37:GetAttribute("LaVaccaIndex") % 3 + 1 then
					return nil;
				else
					local l_Attachment_0 = Instance.new("Attachment");
					l_Attachment_0.Position = v38.WorldPosition;
					l_Attachment_0.Parent = workspace.Terrain;

					local v41 = v29[v37:GetAttribute("LaVaccaIndex")];
					v41.target = v39.PrimaryPart;
					v41.beam.First.Attachment0 = l_Attachment_0;
					v41.beam.Second.Attachment0 = l_Attachment_0;
					v41.targetAttachment = l_Attachment_0;

					return function() l_Attachment_0:Destroy(); end;
				end;
			end);

			return function()
				v29[v37:GetAttribute("LaVaccaIndex")] = nil;
				v38:Destroy();
				v42();
			end;
		end));

		local l_CFrame_0 = v28.CFrame;
		local v44 = v26:Clone(script.SummonVFX);
		v44:PivotTo(l_CFrame_0);
		v44.Parent = workspace;

		local v45 = v26:Clone(script.SummonVFXBeam);
		v45:PivotTo(l_CFrame_0);
		v45.Parent = workspace;

		v26:Add(l_RunService_0.PostSimulation:Connect(function(_)
			debug.profilebegin("La Vacca Event Animation");
			local l_workspace_ServerTimeNow_1 = workspace:GetServerTimeNow();
			if l_workspace_ServerTimeNow_1 < l_v11_ActiveEventData_0.startedAt + 3 then
				return;
			else
				local v48 = math.clamp(1 - (l_v11_ActiveEventData_0.startedAt + 11 - l_workspace_ServerTimeNow_1) / 8, 0, 1);
				local v49 = v48 * v48 * 3.141592653589793 * 2 * 8;
				local v50 = v48 * v48 * 150;
				v27:PivotTo(l_CFrame_0 * CFrame.Angles(0, v49, 0) * CFrame.new(0, v50, 0));
				v45.Beams.Position = Vector3.new(0, v50, 0);
				if v48 >= 1 then v26:Clean(); end;
				debug.profileend();
			end;
		end));

		v26:Add(v14.observeTag("LaVaccaPlayerVFX", function(v51)
			local v52 = script.PlayerVFX.Torso:Clone();
			v52.Parent = v51;
			return function() v52:Destroy(); end;
		end, { workspace }));
	end
    v20:Add(task.delay(v25, function()
        v9:Run(l_Name_0, "Space");
        v9:Activate("Blink");
        v20:Add(function()
            v9:Activate("Blink");
        end);
        l_ReplicatedStorage_0:SetAttribute("LaVaccaEvent", true);
        v10:UpdateOST();
        v12:Update();
        v20:Add(function()
            l_ReplicatedStorage_0:SetAttribute("LaVaccaEvent", nil);
            v9:Stop(l_Name_0, "Space");
        end);
    end));
    v20:Add(v18.OnClientEvent:Connect(function(v53, v54)
        local v55 = v8:GetAnimals()[v54];
        if not v55 then
            return;
        else
            local _ = function()
                local _ = nil;
                local l_AnimalModel_0 = v55.AnimalModel;
                return (if l_AnimalModel_0.PrimaryPart then l_AnimalModel_0.PrimaryPart.CFrame else l_AnimalModel_0:GetPivot()).Position + Vector3.new(0, v55.AnimalModel:GetExtentsSize().Y * 0.5, 0);
            end;
            local v59 = CFrame.new(v53);
            task.spawn(function()
                local l_v10_0 = v10;
                local l_CommetActivation_0 = l_ReplicatedStorage_0.Sounds.Events["La Vacca Saturno Saturnita"].CommetActivation;
                local _ = nil;
                local l_AnimalModel_1 = v55.AnimalModel;
                l_v10_0:PlaySound(l_CommetActivation_0, (if l_AnimalModel_1.PrimaryPart then l_AnimalModel_1.PrimaryPart.CFrame else l_AnimalModel_1:GetPivot()).Position + Vector3.new(0, v55.AnimalModel:GetExtentsSize().Y * 0.5, 0));
            end);
            local v64 = script.Comet:Clone();
            v64:PivotTo(v59);
            v64.Parent = workspace;
            local v65 = 0;
            local v66 = nil;
            v66 = l_RunService_0.PreRender:Connect(function(v67)
                if not v66 or not v66.Connected then
                    return;
                else
                    debug.profilebegin("La Vacca Commet Hit");
                    v65 = v65 + v67;
                    local l_new_0 = CFrame.new;
                    local _ = nil;
                    local l_AnimalModel_2 = v55.AnimalModel;
                    l_new_0 = l_new_0((if l_AnimalModel_2.PrimaryPart then l_AnimalModel_2.PrimaryPart.CFrame else l_AnimalModel_2:GetPivot()).Position + Vector3.new(0, v55.AnimalModel:GetExtentsSize().Y * 0.5, 0));
                    local v71 = math.clamp(v65 / 1, 0, 1);
                    v64:PivotTo(v59:Lerp(l_new_0, v71));
                    if v71 >= 1 then
                        v66:Disconnect();
                        task.spawn(function()
                            local l_v10_1 = v10;
                            local l_CommetHit_0 = l_ReplicatedStorage_0.Sounds.Events["La Vacca Saturno Saturnita"].CommetHit;
                            local _ = nil;
                            local l_AnimalModel_3 = v55.AnimalModel;
                            l_v10_1:PlaySound(l_CommetHit_0, (if l_AnimalModel_3.PrimaryPart then l_AnimalModel_3.PrimaryPart.CFrame else l_AnimalModel_3:GetPivot()).Position + Vector3.new(0, v55.AnimalModel:GetExtentsSize().Y * 0.5, 0));
                        end);
                        if (l_CurrentCamera_0.CFrame.Position - l_new_0.Position).Magnitude <= 70 then
                            l_AnimalModel_2 = v13.Bump:Clone();
                            v20:Add(l_AnimalModel_2);
                            l_AnimalModel_2.Sustain = true;
                            v20:Add(v13.BindShakeToCamera(l_AnimalModel_2, l_CurrentCamera_0));
                            l_AnimalModel_2:Start();
                            local l_l_AnimalModel_2_0 = l_AnimalModel_2 ;
                            v20:Add(task.delay(0.3, function()
                                l_l_AnimalModel_2_0:StopSustain();
                            end));
                        end;
                        l_AnimalModel_2 = script.CometBurst:Clone();
                        l_AnimalModel_2:PivotTo(l_new_0);
                        l_AnimalModel_2.Anchored = false;
                        local l_WeldConstraint_0 = Instance.new("WeldConstraint");
                        l_WeldConstraint_0.Part0 = l_AnimalModel_2;
                        l_WeldConstraint_0.Part1 = v55.AnimalModel.PrimaryPart;
                        l_WeldConstraint_0.Parent = l_AnimalModel_2;
                        l_AnimalModel_2.Parent = workspace;
                        for _, v79 in v64:GetDescendants() do
                            if v79:IsA("BasePart") then
                                v79.Transparency = 1;
                            elseif v79:IsA("ParticleEmitter") then
                                v79.Enabled = false;
                                v79:Clear();
                            end;
                        end;
                        for _, v81 in l_AnimalModel_2:GetDescendants() do
                            if v81:IsA("ParticleEmitter") then
                                task.delay(v81:GetAttribute("EmitDelay") or 0, function()
                                    v81:Emit(v81:GetAttribute("EmitCount"));
                                end);
                            end;
                        end;
                        task.delay(2, function()
                            v64:Destroy();
                            l_AnimalModel_2:Destroy();
                        end);
                    end;
                    debug.profileend();
                    return;
                end;
            end);
            return;
        end;
    end));
end;
v6.OnStop = function(_)
    v20:Destroy();
end;
v6.OnLoad = function(_)

end;
return v6;