
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local l_RunService_0 = game:GetService("RunService");
local l_Lighting_0 = game:GetService("Lighting");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v5 = {};
local v6 = require(l_ReplicatedStorage_0.Controllers.EventController.ClientEventUtils);
local v7 = require(l_ReplicatedStorage_0.Controllers.EffectController);
local v8 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v9 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local v10 = require(l_ReplicatedStorage_0.Controllers.EventController);
local v11 = require(l_ReplicatedStorage_0.Shared.SharedEventUtils);
local v12 = require(l_ReplicatedStorage_0.Packages.Observers);
local v13 = require(l_ReplicatedStorage_0.Datas.ServerData);
local v14 = require(l_ReplicatedStorage_0.Packages.Trove);
local v15 = require(l_ReplicatedStorage_0.Packages.Net);
local _ = require(l_ReplicatedStorage_0.Shared.VFX);
local l_Name_0 = script.Name;
local v18 = {
	Red = Color3.fromRGB(255, 50, 50), 
	Green = Color3.fromRGB(50, 200, 50), 
	Blue = Color3.fromRGB(50, 100, 255), 
	Orange = Color3.fromRGB(255, 150, 30), 
	Purple = Color3.fromRGB(160, 50, 220), 
	Yellow = Color3.fromRGB(255, 230, 50), 
	Rainbow = Color3.fromRGB(255, 255, 255)
};
local v19 = v15:RemoteEvent((("EventService/%*/Burst"):format(l_Name_0)));
local v20 = v14.new();
v5.OnStart = function(_)
	assert((v10:GetActiveEventData(l_Name_0)));
	v9:Update();
	v8:UpdateOST();
	v7:Activate("Blink");
	local v22 = if v13.IsBiggerServer() then v20:Clone(script.BiggerEidMap) else if v13.IsTsunamiServer() then v20:Clone(script.TsunamiEidMap) else v20:Clone(script.EidMap);
	v22.Parent = workspace;
	v7:Run("EidEvent", "GrassRecolor");
	v20:Add(function()
		v7:Stop("EidEvent", "GrassRecolor");
	end);
	local l_Cartoon_0 = l_Lighting_0:FindFirstChild("Cartoon");
	if l_Cartoon_0 then
		l_Cartoon_0.Parent = script;
		v20:Add(function()
			l_Cartoon_0.Parent = l_Lighting_0;
		end);
	end;
	v20:Clone(script.SkyEid).Parent = l_Lighting_0;
	local v24 = Random.new();
	for _, v26 in v22.Lanterns:GetChildren() do
		local l_BasePart_0 = v26:FindFirstChildWhichIsA("BasePart");
		if l_BasePart_0 then
			l_BasePart_0.Anchored = false;
			for _, v29 in v26:QueryDescendants("BasePart") do
				if v29 ~= l_BasePart_0 then
					v29.Anchored = false;
					local v30 = v20:Add(Instance.new("WeldConstraint"));
					v30.Part0 = v29;
					v30.Part1 = l_BasePart_0;
					v30.Parent = v29;
				end;
			end;
			local v31 = v20:Add(Instance.new("Motor6D"));
			v31.Part0 = workspace.Terrain;
			v31.Part1 = l_BasePart_0;
			v31.C0 = l_BasePart_0.CFrame;
			v31.Parent = l_BasePart_0;
			local v32 = v24:NextInteger(0, 1000000);
			local v33 = v24:NextNumber(4, 7);
			local v34 = v24:NextNumber(0.5, 0.65);
			local v35 = v24:NextNumber(0.25, 0.4);
			v20:Add(l_RunService_0.PostSimulation:Connect(function()
				local v36 = v32 + os.clock();
				debug.profilebegin("Eid Lantern Update");
				v31.Transform = CFrame.new(0, math.sin(v36 * v34) * v33, 0) * CFrame.Angles(0, v36 * v35 % 6.283185307179586, 0);
				debug.profileend();
			end));
		end;
	end;
	local v37 = {};
	v20:Add(v12.observeTag("EidBalloon", function(v38)
		local v39 = v14.new();
		local v40 = v38:GetAttribute("BalloonColor") or "Red";
		if not v18[v40] then
			local _ = v18.Red;
		end;
		local v42 = v39:Clone(script.Balloons[v40]);
		v42.Parent = v38;
		local v43 = v11.loadAnimation(v39, v42.AnimationController.Animator, script.Idle);
		v43.Looped = true;
		v43:Play(0, 1, (Random.new():NextNumber(0.3, 0.75)));
		local l_RootPart_0 = v42.RootPart;
		v37[v38.Name] = v42;
		local v45 = os.clock();
		local v46 = Random.new():NextNumber(0, 1) * 3.141592653589793 * 2;
		v39:Add(l_RunService_0.PreRender:Connect(function()
			debug.profilebegin("EidBalloon:visual");
			local v47 = math.sin(os.clock() - v45 + v46) * 0.6;
			local v48 = v38.CFrame * CFrame.new(0, v47, 0);
			v11.pushPartCFrame(l_RootPart_0, v48);
			debug.profileend();
		end));
		return function()
			v37[v38.Name] = nil;
			v39:Destroy();
		end;
	end, {
		workspace
	}));
	v20:Add(function()
		v7:Activate("Blink");
		v9:Update();
		v8:UpdateOST();
	end);
end;
v5.OnStop = function(_)
	v20:Destroy();
end;
v5.OnLoad = function(_)
	task.spawn(pcall, function()
		l_ContentProvider_0:PreloadAsync(script:GetChildren());
	end);
	v19.OnClientEvent:Connect(function(v51, _)
		v20:Add(v6.playBurst(script.Burst, v51, {
			l_ReplicatedStorage_0.Sounds.Events.Eid.Hit
		}));
	end);
end;
return v5;