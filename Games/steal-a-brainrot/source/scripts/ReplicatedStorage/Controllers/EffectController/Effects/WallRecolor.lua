local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("TweenService");
local _ = require(script:FindFirstAncestor("Effects").Parent.Types);
local v3 = {};
local v4 = require(l_ReplicatedStorage_0.Packages.CreateTween);
local v5 = require(l_ReplicatedStorage_0.Packages.Observers);
local v6 = require(l_ReplicatedStorage_0.Packages.Signal);
local _ = script.Name;
local v8 = {
	Context = "Default", 
	Color = Color3.fromRGB(106, 57, 9)
};
local l_v8_0 = v8;
local v10 = v6.new();
local function v12()
	local l_v8_1 = v8;
	if l_ReplicatedStorage_0:GetAttribute("2026Event") then
		l_v8_1 = {
			Context = "2026", 
			Color = Color3.fromRGB(65, 78, 108), 
			TweenTime = 0
		};
	elseif l_ReplicatedStorage_0:GetAttribute("ConcertEvent") then
		l_v8_1 = {
			Context = "Concert", 
			Color = Color3.fromRGB(46, 71, 89)
		};
	elseif l_ReplicatedStorage_0:GetAttribute("RapConcertEvent") then
		l_v8_1 = {
			Context = "RapConcert", 
			Color = Color3.fromRGB(46, 71, 89)
		};
	elseif l_ReplicatedStorage_0:GetAttribute("AyMiGatitoEvent") then
		l_v8_1 = {
			Context = "AyMiGatitoEvent", 
			Color = Color3.fromRGB(105, 120, 180)
		};
	elseif l_ReplicatedStorage_0:GetAttribute("MexicoEvent") then
		l_v8_1 = {
			Context = "MexicoEvent", 
			Color = Color3.fromRGB(180, 91, 68)
		};
	elseif l_ReplicatedStorage_0:GetAttribute("FranceEvent") then
		l_v8_1 = {
			Context = "FranceEvent", 
			Color = Color3.fromRGB(113, 61, 31)
		};
	elseif l_ReplicatedStorage_0:GetAttribute("DulDulDulEvent") then
		l_v8_1 = {
			Context = "DulDulDulEvent", 
			Color = Color3.fromRGB(84, 81, 83)
		};
	elseif l_ReplicatedStorage_0:GetAttribute("ChicleteiraBicicleteiraEvent") then
		l_v8_1 = {
			Context = "ChicleteiraBicicleteiraEvent", 
			Color = Color3.fromRGB(116, 85, 85)
		};
	elseif l_ReplicatedStorage_0:GetAttribute("MeowlEvent") then
		l_v8_1 = {
			Context = "MeowlEvent", 
			Color = Color3.fromRGB(125, 93, 58)
		};
	elseif l_ReplicatedStorage_0:GetAttribute("ValentinesEvent") then
		l_v8_1 = {
			Context = "ValentinesEvent", 
			Color = Color3.fromRGB(227, 100, 187)
		};
	elseif l_ReplicatedStorage_0:GetAttribute("TrickOrTreatEvent") then
		l_v8_1 = {
			Context = "TrickOrTreatEvent", 
			Color = Color3.fromRGB(148, 71, 33)
		};
	elseif l_ReplicatedStorage_0:GetAttribute("GraveyardEvent") then
		l_v8_1 = {
			Context = "GraveyardEvent", 
			Color = Color3.fromRGB(92, 94, 180)
		};
	elseif l_ReplicatedStorage_0:GetAttribute("GingerbreadTownEvent") then
		l_v8_1 = {
			Context = "GingerbreadTownEvent", 
			Color = Color3.fromRGB(99, 42, 16), 
			TweenTime = 0
		};
	elseif l_ReplicatedStorage_0:GetAttribute("WinterHourEvent") then
		l_v8_1 = {
			Context = "WinterHourEvent", 
			Color = Color3.fromRGB(108, 120, 136), 
			TweenTime = 0
		};
	elseif l_ReplicatedStorage_0:GetAttribute("WitchingHourEvent") then
		l_v8_1 = {
			Context = "WitchingHourEvent", 
			Color = Color3.fromRGB(68, 42, 77), 
			TweenTime = 0
		};
	elseif l_ReplicatedStorage_0:GetAttribute("YinYangEvent") then
		l_v8_1 = {
			Context = "YinYangEvent", 
			Color = Color3.fromRGB(0, 0, 0), 
			TweenTime = 0
		};
	elseif l_ReplicatedStorage_0:GetAttribute("RadioactiveEvent") then
		l_v8_1 = {
			Context = "RadioactiveEvent", 
			Color = Color3.fromRGB(128, 136, 117), 
			TweenTime = 0
		};
	elseif l_ReplicatedStorage_0:GetAttribute("CursedEvent") then
		l_v8_1 = {
			Context = "CursedEvent", 
			Color = Color3.fromRGB(143, 0, 0), 
			TweenTime = 0
		};
	elseif l_ReplicatedStorage_0:GetAttribute("DivineEvent") then
		l_v8_1 = {
			Context = "DivineEvent", 
			Color = Color3.fromRGB(157, 129, 108), 
			TweenTime = 0
		};
	elseif l_ReplicatedStorage_0:GetAttribute("GalaxyEvent") then
		l_v8_1 = {
			Context = "GalaxyEvent", 
			Color = Color3.fromRGB(20, 57, 67)
		};
	end;
	if l_v8_0.Context == l_v8_1.Context then
		return;
	else
		l_v8_0 = l_v8_1;
		v10:Fire();
		return;
	end;
end;
v3.OnStart = function(_)
	v12();
end;
v3.OnUpdate = function(_)
	v12();
end;
v3.OnLoad = function(_)
	v5.observeTag("Wall", function(v16)
		local v17 = nil;
		local function v18()
			if v17 then
				v17:Cancel();
			end;
			v17 = v4(v16, TweenInfo.new(2), {
				Color = if type(l_v8_0.Color) == "table" then l_v8_0.Color[v16:GetAttribute("Side") or "Left"] or l_v8_0.Color.Left or select(2, next(l_v8_0)) else l_v8_0.Color
			});
		end;
		local v19 = v10:Connect(v18);
		task.spawn(v18);
		return function()
			v19:Disconnect();
			v17:Cancel();
		end;
	end, {
		workspace
	});
end;
return v3;