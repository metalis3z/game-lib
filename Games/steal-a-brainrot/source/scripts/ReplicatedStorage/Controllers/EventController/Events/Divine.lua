local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("TweenService");
local _ = game:GetService("RunService");
local l_Lighting_0 = game:GetService("Lighting");
local _ = game:GetService("Players");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v6 = {};
local v7 = require(l_ReplicatedStorage_0.Controllers.EventController.ClientEventUtils);
local v8 = require(l_ReplicatedStorage_0.Controllers.EffectController);
local v9 = require(l_ReplicatedStorage_0.Controllers.AnimalController);
local v10 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v11 = require(l_ReplicatedStorage_0.Controllers.EventController);
local v12 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local v13 = require(l_ReplicatedStorage_0.Packages.Observers);
local v14 = require(l_ReplicatedStorage_0.Datas.ServerData);
local v15 = require(l_ReplicatedStorage_0.Packages.Timer);
local v16 = require(l_ReplicatedStorage_0.Packages.Trove);
local v17 = require(l_ReplicatedStorage_0.Packages.Net);
local _ = require(l_ReplicatedStorage_0.Packages.Spr);
local _ = require(l_ReplicatedStorage_0.Shared.VFX);
local l_Name_0 = script.Name;
local v21 = v17:RemoteEvent("EventService/Divine/Hit");
local v22 = v16.new();
v6.OnStart = function(_)
	assert((v11:GetActiveEventData(l_Name_0)));
	local l_Atmosphere_0 = l_Lighting_0:FindFirstChild("Atmosphere");
	if l_Atmosphere_0 then
		l_Atmosphere_0.Parent = script;
		v22:Add(function()
			l_Atmosphere_0.Parent = l_Lighting_0;
		end);
	end;
	v22:Clone(script.AtmosphereDivine).Parent = l_Lighting_0;
	v8:Activate("Blink");
	v22:Add(function()
		v8:Activate("Blink");
	end);
	v8:Run("DivineEvent", "GrassRecolor");
	v22:Add(function()
		v8:Stop("DivineEvent", "GrassRecolor");
	end);
	v8:Run("DivineEvent", "WallRecolor");
	v22:Add(function()
		v8:Stop("DivineEvent", "WallRecolor");
	end);
	v8:Run("DivineEvent", "WallBottomRecolor");
	v22:Add(function()
		v8:Stop("DivineEvent", "WallBottomRecolor");
	end);
	v22:Add(v21.OnClientEvent:Connect(function(v25)
		v7.playBurst(script.Burst, v25, {
			l_ReplicatedStorage_0.Sounds.Events.Divine.Hit
		});
	end));
	if v14.IsTsunamiServer() then
		v22:Clone(script.DivineMapTsunami).Parent = workspace;
	else
		local v26 = nil;
		local v27 = if v14.IsBiggerServer() then v22:Clone(script.DivineMapBigger) else v22:Clone(script.DivineMap);
		local v28 = v22:Add(v27.Decor.Stairs);
		local v29 = v22:Add(v27.Gate);
		local v30 = v22:Add(v27.Fill);
		local v31 = nil;
		do
			local l_v26_0, l_v31_0 = v26, v31;
			local function v37()
				local v34 = l_ReplicatedStorage_0:GetAttribute("DivineStairsEnabled") == true;
				if l_v31_0 == v34 then
					return;
				else
					l_v31_0 = v34;
					if l_v26_0 then
						l_v26_0();
						l_v26_0 = nil;
					end;
					if v34 then
						l_v26_0 = v13.observeTag("HideInDivineTiedToStairs", function(v35)
							local l_Parent_0 = v35.Parent;
							v35.Parent = script;
							return function()
								pcall(function()
									v35.Parent = l_Parent_0;
								end);
							end;
						end, {
							workspace, 
							script
						});
						pcall(function()
							v28.Parent = v27.Decor;
						end);
						pcall(function()
							v30.Parent = script;
						end);
						return;
					else
						pcall(function()
							v28.Parent = script;
						end);
						pcall(function()
							v30.Parent = v27;
						end);
						return;
					end;
				end;
			end;
			v22:Add(l_ReplicatedStorage_0:GetAttributeChangedSignal("DivineStairsEnabled"):Connect(v37));
			v22:Add(v27.Decor.ChildAdded:Connect(v37));
			v22:Add(v27.Decor.ChildRemoved:Connect(v37));
			v22:Add(task.spawn(v37));
			v27.Parent = workspace;
			local v38 = v29.AnimationController.Animator:LoadAnimation(v29.Animation);
			v38.Looped = false;
			v22:Add(function()
				v38:Stop(0);
				v38:Destroy();
			end);
			v22:Add(v38:GetMarkerReachedSignal("Freeze"):Connect(function()
				v38:AdjustSpeed(0);
			end));
			v22:Add(v15.Simple(0.25, function()
				local v39 = false;
				for _, v41 in v9:GetAnimals() do
					if v41.Instance:GetAttribute("InDivineRoad") then
						local l_Position_0 = v41.Instance:GetPivot().Position;
						if (v29.Gate.Position - l_Position_0).Magnitude <= 50 then
							v39 = true;
							break;
						end;
					end;
				end;
				if v39 then
					if not v38.IsPlaying then
						v38:Play();
						return;
					end;
				elseif v38.IsPlaying then
					v38:AdjustSpeed(1);
				end;
			end, true));
		end;
	end;
	v22:Add(v13.observeTag("HideInDivine", function(v43)
		local l_Parent_1 = v43.Parent;
		v43.Parent = script;
		return function()
			pcall(function()
				v43.Parent = l_Parent_1;
			end);
		end;
	end, {
		workspace, 
		script
	}));
	v22:Add(v13.observeTag("ShowInDivine", function(v45)
		local l_Parent_2 = v45.Parent;
		local v47 = false;
		local v48 = l_Parent_2.Destroying:Once(function()
			v47 = true;
			v45:Destroy();
		end);
		v45.Parent = script;
		return function()
			v48:Disconnect();
			if not v47 then
				pcall(function()
					v45.Parent = l_Parent_2;
				end);
			end;
		end;
	end, {
		workspace, 
		script
	}));
	v12:Update();
	v10:UpdateOST();
end;
v6.OnStop = function(_)
	v22:Destroy();
end;
v6.OnLoad = function(_)

end;
return v6;