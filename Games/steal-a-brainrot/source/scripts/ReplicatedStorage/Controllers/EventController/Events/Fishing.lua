local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local _ = game:GetService("TweenService");
local _ = game:GetService("RunService");
local _ = game:GetService("Lighting");
local l_Players_0 = game:GetService("Players");
local _ = game:GetService("Debris");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v8 = {};
local _ = require(l_ReplicatedStorage_0.Controllers.EncryptedAssetsController);
local v10 = require(l_ReplicatedStorage_0.Controllers.InterfaceController);
local _ = require(l_ReplicatedStorage_0.Controllers.AnimalController);
local v12 = require(l_ReplicatedStorage_0.Controllers.EffectController);
local _ = require(l_ReplicatedStorage_0.Controllers.CameraController);
local v14 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v15 = require(l_ReplicatedStorage_0.Controllers.EventController);
local v16 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local _ = require(l_ReplicatedStorage_0.Shared.SharedEventUtils);
local _ = require(l_ReplicatedStorage_0.Packages.CreateTween);
local v19 = require(l_ReplicatedStorage_0.Shared.TweenPivot);
local v20 = require(l_ReplicatedStorage_0.Packages.Observers);
local v21 = require(l_ReplicatedStorage_0.Datas.ServerData);
local v22 = require(l_ReplicatedStorage_0.Datas.Mutations);
local v23 = require(l_ReplicatedStorage_0.Shared.Mutations);
local _ = require(l_ReplicatedStorage_0.Utils.MathUtils);
local _ = require(l_ReplicatedStorage_0.Packages.Signal);
local _ = require(l_ReplicatedStorage_0.Packages.Spring);
local v27 = require(l_ReplicatedStorage_0.Packages.Trove);
local _ = require(l_ReplicatedStorage_0.Packages.Shake);
local _ = require(l_ReplicatedStorage_0.Packages.Net);
local v30 = require(l_ReplicatedStorage_0.Packages.Spr);
local _ = require(l_ReplicatedStorage_0.Shared.VFX);
local _ = l_Players_0.LocalPlayer;
local _ = workspace.CurrentCamera;
local l_Name_0 = script.Name;
local v35 = v27.new();
local function _(v36, v37, v38)
	local v39 = v36:LoadAnimation(v37);
	(v38 or v35):Add(function()
		v39:Stop(0);
		v39:Destroy();
	end);
	return v39;
end;
v8.OnStart = function(_)
	local l_v15_ActiveEventData_0 = v15:GetActiveEventData(l_Name_0);
	assert(l_v15_ActiveEventData_0);
	local function _(v43)
		return (math.max(l_v15_ActiveEventData_0.startedAt + v43 - workspace:GetServerTimeNow(), 0));
	end;
	v35:Add(function()
		v12:Activate("Blink");
		v16:Update();
		v14:UpdateOST();
	end);
	local v45 = if v21.IsTsunamiServer() then v35:Clone(script.FishingMapTsunami) else if v21.IsBiggerServer() then v35:Clone(script.FishingMapBigger) else v35:Clone(script.FishingMap);
	v45.Parent = workspace;
	v12:Activate("Blink");
	v16:Update();
	v14:UpdateOST();
	local l_Pivot_0 = v45.Flood:GetPivot();
	v45.Flood:PivotTo(l_Pivot_0 - Vector3.new(0, 3, 0, 0));
	v35:Add(v19(v45.Flood, TweenInfo.new(l_v15_ActiveEventData_0.startedAt + 3 - workspace:GetServerTimeNow(), Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), l_Pivot_0)):Play();
	v35:Add(v20.observeTag("FishermanPrompt", function(v47)
		local v48 = v47.Triggered:Connect(function()
			v10:Toggle("RodsShop");
		end);
		return function()
			v48:Disconnect();
		end;
	end));
	local function _(v49, v50)
		v50 = math.clamp(v50, 0, 1);
		local v51, v52, v53 = v49:ToHSV();
		v53 = v53 * v50;
		return Color3.fromHSV(v51, v52, v53);
	end;
	local function v67()
		local v55 = v23.get();
		if v55 then
			local v56 = v22[v55];
			v30.target(v45.Flood.TopWater["Water.001"], 1, 4, {
				Color = v56.MainColor
			});
			local l_target_0 = v30.target;
			local v58 = v45.Flood.Water["Water.001"];
			local v59 = 1;
			local v60 = 4;
			local v61 = {};
			local l_MainColor_0 = v56.MainColor;
			local v63 = math.clamp(0.5, 0, 1);
			local v64, v65, v66 = l_MainColor_0:ToHSV();
			v66 = v66 * v63;
			v61.Color = Color3.fromHSV(v64, v65, v66);
			l_target_0(v58, v59, v60, v61);
			return;
		else
			v30.target(v45.Flood.TopWater["Water.001"], 1, 4, {
				Color = Color3.fromRGB(73, 161, 255)
			});
			v30.target(v45.Flood.Water["Water.001"], 1, 4, {
				Color = Color3.fromRGB(0, 103, 172)
			});
			return;
		end;
	end;
	v35:Add(v23.watch(v67));
	v67();
end;
v8.OnStop = function(_)
	v35:Destroy();
end;
v8.OnLoad = function(_)
	task.spawn(pcall, function()
		l_ContentProvider_0:PreloadAsync(script:GetChildren());
	end);
end;
return v8;