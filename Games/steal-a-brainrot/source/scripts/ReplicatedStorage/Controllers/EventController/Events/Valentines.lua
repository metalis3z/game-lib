local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local _ = game:GetService("TweenService");
local _ = game:GetService("RunService");
local l_Lighting_0 = game:GetService("Lighting");
local _ = game:GetService("Players");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v7 = {};
local v8 = require(l_ReplicatedStorage_0.Controllers.EventController.ClientEventUtils);
local _ = require(l_ReplicatedStorage_0.Controllers.TsunamiEventController);
local _ = require(l_ReplicatedStorage_0.Controllers.AnimalController);
local v11 = require(l_ReplicatedStorage_0.Controllers.EffectController);
local v12 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v13 = require(l_ReplicatedStorage_0.Controllers.EventController);
local v14 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local _ = require(l_ReplicatedStorage_0.Shared.ShakePresets);
local v16 = require(l_ReplicatedStorage_0.Packages.Observers);
local v18 = require(l_ReplicatedStorage_0.Packages.Trove);
local v19 = require(l_ReplicatedStorage_0.Packages.Net);
local _ = require(l_ReplicatedStorage_0.Shared.VFX);
local l_Name_0 = script.Name;
local v22 = v19:RemoteEvent("EventService/Valentines/Hit");
local v23 = v18.new();
v7.OnStart = function(_)
	assert((v13:GetActiveEventData(l_Name_0)));
	l_ReplicatedStorage_0:SetAttribute("ValentinesEvent", true);
	v23:Add(function()
		l_ReplicatedStorage_0:SetAttribute("ValentinesEvent", nil);
	end);
	(v23:Clone(script.Map)).Parent = workspace;
	v11:Activate("Blink");
	v23:Add(function()
		v11:Activate("Blink");
	end);
	local l_Atmosphere_0 = l_Lighting_0:FindFirstChild("Atmosphere");
	if l_Atmosphere_0 then
		l_Atmosphere_0.Parent = script;
		v23:Add(function()
			l_Atmosphere_0.Parent = l_Lighting_0;
		end);
	end;
	v23:Clone(script.AtmosphereValentines).Parent = l_Lighting_0;
	local l_Cartoon_0 = l_Lighting_0:FindFirstChild("Cartoon");
	if l_Cartoon_0 then
		l_Cartoon_0.Parent = script;
		v23:Add(function()
			l_Cartoon_0.Parent = l_Lighting_0;
		end);
	end;
	v23:Clone(script.SkyValentines).Parent = l_Lighting_0;
	v23:Add(v16.observeTag("HideInValentines", function(v27)
		local l_Parent_0 = v27.Parent;
		v27.Parent = script;
		return function()
			pcall(function()
				v27.Parent = l_Parent_0;
			end);
		end;
	end, {
		workspace, 
		script
	}));
	v14:Update();
	v12:UpdateOST();
	v12:UpdateAmbience();
	v11:Run("ValentinesEvent", "GrassRecolor");
	v23:Add(function()
		v11:Stop("ValentinesEvent", "GrassRecolor");
	end);
	v11:Run("ValentinesEvent", "WallRecolor");
	v23:Add(function()
		v11:Stop("ValentinesEvent", "WallRecolor");
	end);
	v11:Run("ValentinesEvent", "WallBottomRecolor");
	v23:Add(function()
		v11:Stop("ValentinesEvent", "WallBottomRecolor");
	end);
end;
v7.OnStop = function(_)
	v23:Destroy();
end;
v7.OnLoad = function(_)
	task.spawn(pcall, function()
		l_ContentProvider_0:PreloadAsync(script:GetChildren());
	end);
	task.spawn(pcall, function()
		l_ContentProvider_0:PreloadAsync({
			l_ReplicatedStorage_0.Sounds.Events.Valentines
		});
	end);
	v22.OnClientEvent:Connect(function(v31)
		v8.playBurst(script.Burst, v31, {
			l_ReplicatedStorage_0.Sounds.Events.Valentines.Hit
		});
	end);
end;
return v7;