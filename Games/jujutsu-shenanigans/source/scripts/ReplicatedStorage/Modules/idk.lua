local v0 = {
	require = require, 
	warn = warn, 
	print = print, 
	pcall = pcall, 
	debug = {
		profilebegin = debug.profilebegin, 
		profileend = debug.profileend
	}, 
	Axes = {
		new = Axes.new
	}, 
	ColorSequence = {
		new = ColorSequence.new
	}, 
	ColorSequenceKeypoint = {
		new = ColorSequenceKeypoint.new
	}, 
	RaycastParams = {
		new = RaycastParams.new
	}, 
	OverlapParams = {
		new = OverlapParams.new
	}, 
	CFrame = {
		new = CFrame.new, 
		Angles = CFrame.Angles, 
		lookAt = CFrame.lookAt, 
		fromMatrix = CFrame.fromMatrix, 
		fromOrientation = CFrame.fromOrientation, 
		fromAxisAngle = CFrame.fromAxisAngle
	}, 
	TweenInfo = {
		new = TweenInfo.new
	}, 
	Vector3 = {
		new = Vector3.new, 
		one = Vector3.one, 
		zero = Vector3.zero
	}, 
	os = {
		clock = os.clock, 
		time = os.time, 
		date = os.date, 
		difftime = os.difftime
	}, 
	string = {
		find = string.find, 
		match = string.match, 
		lower = string.lower, 
		upper = string.upper, 
		sub = string.sub, 
		gsub = string.gsub
	}, 
	Enum = {
		CameraType = {
			Scriptable = Enum.CameraType.Scriptable, 
			Custom = Enum.CameraType.Custom, 
			Attach = Enum.CameraType.Attach, 
			Track = Enum.CameraType.Track
		}, 
		HighlightDepthMode = {
			Occluded = Enum.HighlightDepthMode.Occluded
		}, 
		AnimationPriority = {
			Action4 = Enum.AnimationPriority.Action4
		}, 
		ThumbnailType = {
			HeadShot = Enum.ThumbnailType.HeadShot, 
			AvatarBust = Enum.ThumbnailType.AvatarBust, 
			AvatarThumbnail = Enum.ThumbnailType.AvatarThumbnail
		}, 
		ThumbnailSize = {
			Size420x420 = Enum.ThumbnailSize.Size420x420
		}, 
		PlaybackState = {
			Completed = Enum.PlaybackState.Completed, 
			Cancelled = Enum.PlaybackState.Cancelled, 
			Begin = Enum.PlaybackState.Begin, 
			Paused = Enum.PlaybackState.Paused, 
			Delayed = Enum.PlaybackState.Delayed, 
			Playing = Enum.PlaybackState.Playing
		}, 
		RenderPriority = {
			Camera = Enum.RenderPriority.Camera, 
			Character = Enum.RenderPriority.Character
		}, 
		EasingStyle = {
			Sine = Enum.EasingStyle.Sine, 
			Quad = Enum.EasingStyle.Quad, 
			Linear = Enum.EasingStyle.Linear, 
			Circular = Enum.EasingStyle.Circular, 
			Cubic = Enum.EasingStyle.Cubic, 
			Exponential = Enum.EasingStyle.Exponential, 
			Elastic = Enum.EasingStyle.Elastic, 
			Quint = Enum.EasingStyle.Quint, 
			Back = Enum.EasingStyle.Back, 
			Bounce = Enum.EasingStyle.Bounce, 
			Quart = Enum.EasingStyle.Quart
		}, 
		EasingDirection = {
			In = Enum.EasingDirection.In, 
			Out = Enum.EasingDirection.Out, 
			InOut = Enum.EasingDirection.InOut
		}, 
		RaycastFilterType = {
			Include = Enum.RaycastFilterType.Include, 
			Exclude = Enum.RaycastFilterType.Exclude
		}, 
		KeyCode = {
			F = Enum.KeyCode.F, 
			Q = Enum.KeyCode.Q, 
			G = Enum.KeyCode.G, 
			C = Enum.KeyCode.C, 
			E = Enum.KeyCode.E, 
			Space = Enum.KeyCode.Space
		}, 
		UserInputType = {
			MouseButton1 = Enum.UserInputType.MouseButton1, 
			MouseButton2 = Enum.UserInputType.MouseButton2
		}, 
		Material = {
			Concrete = Enum.Material.Concrete, 
			Plastic = Enum.Material.Plastic, 
			SmoothPlastic = Enum.Material.SmoothPlastic, 
			Rock = Enum.Material.Rock, 
			Plaster = Enum.Material.Plaster, 
			Neon = Enum.Material.Neon, 
			Air = Enum.Material.Air, 
			Ice = Enum.Material.Ice, 
			Mud = Enum.Material.Mud, 
			Foil = Enum.Material.Foil, 
			ForceField = Enum.Material.ForceField, 
			Wood = Enum.Material.Wood, 
			WoodPlanks = Enum.Material.WoodPlanks, 
			Brick = Enum.Material.Brick, 
			Grass = Enum.Material.Grass, 
			Glass = Enum.Material.Glass, 
			Slate = Enum.Material.Slate, 
			Sand = Enum.Material.Sand, 
			Snow = Enum.Material.Snow, 
			Metal = Enum.Material.Metal, 
			Water = Enum.Material.Water, 
			DiamondPlate = Enum.Material.DiamondPlate
		}, 
		RotationType = {
			CameraRelative = Enum.RotationType.CameraRelative, 
			MovementRelative = Enum.RotationType.MovementRelative
		}, 
		HumanoidStateType = {
			GettingUp = Enum.HumanoidStateType.GettingUp, 
			Physics = Enum.HumanoidStateType.Physics, 
			Dead = Enum.HumanoidStateType.Dead, 
			Ragdoll = Enum.HumanoidStateType.Ragdoll, 
			FallingDown = Enum.HumanoidStateType.FallingDown
		}
	}, 
	Instance = {
		new = Instance.new
	}, 
	math = {
		random = math.random, 
		rad = math.rad, 
		pi = 3.141592653589793, 
		floor = math.floor, 
		ceil = math.ceil, 
		sin = math.sin, 
		cos = math.cos, 
		tan = math.tan, 
		log = math.log, 
		asin = math.asin, 
		acos = math.acos, 
		atan = math.atan, 
		atan2 = math.atan2, 
		huge = 1e999, 
		abs = math.abs, 
		deg = math.deg, 
		exp = math.exp, 
		noise = math.noise, 
		log10 = math.log10, 
		round = math.round, 
		randomseem = math.randomseed, 
		ldexp = math.ldexp, 
		min = math.min, 
		max = math.max, 
		pow = math.pow, 
		clamp = math.clamp, 
		sqrt = math.sqrt, 
		cosh = math.cosh, 
		fmod = math.fmod, 
		modf = math.modf, 
		tanh = math.tanh, 
		sign = math.sign, 
		sinh = math.sinh
	}, 
	Random = {
		new = Random.new
	}, 
	Color3 = {
		fromRGB = Color3.fromRGB, 
		new = Color3.new
	}, 
	table = {
		insert = table.insert, 
		sort = table.sort, 
		clear = table.clear, 
		clone = table.clone, 
		create = table.create, 
		remove = table.remove, 
		unpack = table.unpack, 
		find = table.find
	}, 
	pairs = pairs, 
	ipairs = ipairs, 
	tostring = tostring, 
	tonumber = tonumber, 
	coroutine = {
		wrap = coroutine.wrap, 
		yield = coroutine.yield, 
		close = coroutine.close
	}, 
	task = {
		wait = task.wait, 
		spawn = task.spawn, 
		delay = task.delay, 
		cancel = task.cancel, 
		defer = task.defer, 
		desynchronize = task.desynchronize, 
		synchronize = task.synchronize
	}, 
	UDim = {
		new = UDim.new
	}, 
	UDim2 = {
		new = UDim2.new, 
		fromScale = UDim2.fromScale, 
		fromOffset = UDim2.fromOffset
	}, 
	UserSettings = UserSettings(), 
	NumberSequence = {
		new = NumberSequence.new
	}, 
	NumberSequenceKeypoint = {
		new = NumberSequenceKeypoint.new
	}
};
local _ = workspace:GetAttribute("PrivateServerOwnerId");
local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_StarterGui_0 = game:GetService("StarterGui");
local l_TweenService_0 = game:GetService("TweenService");
local _ = game:GetService("MarketplaceService");
local _ = game:GetService("GuiService");
local l_UserInputService_0 = game:GetService("UserInputService");
local _ = game:GetService("UserService");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("ContentProvider");
local l_Lighting_0 = game:GetService("Lighting");
local _ = game:GetService("CollectionService");

local l_RenderStepped_0 = l_RunService_0.RenderStepped;
local _ = l_RunService_0.Heartbeat;
local l_CurrentCamera_0 = workspace.CurrentCamera;
local l_Custom_0 = v0.Enum.CameraType.Custom;
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0:WaitForChild("PlayerGui");
--local l_Bars_0 = l_PlayerGui_0:WaitForChild("Bars");
--local l_Skills_0 = l_PlayerGui_0:WaitForChild("Skills");
--local l_Buttons_0 = l_Skills_0:WaitForChild("Container"):WaitForChild("Buttons");
local v26 = l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait();
local l_HumanoidRootPart_0 = v26:WaitForChild("HumanoidRootPart");
--local l_Network_0 = v26:WaitForChild("Network");
--local l_Communication_0 = l_ReplicatedStorage_0:WaitForChild("Communication");
local l_Torso_0 = v26:WaitForChild("Torso");
local l_Humanoid_0 = v26:WaitForChild("Humanoid");
local l_Head_0 = v26:WaitForChild("Head");
local l_Animator_0 = l_Humanoid_0:WaitForChild("Animator");
--local l_workspace_Attribute_1 = workspace:GetAttribute("PrivateServerOwnerId");
local l_Assets_0 = l_ReplicatedStorage_0:WaitForChild("Assets");
--local l_Remotes_0 = l_ReplicatedStorage_0:WaitForChild("Remotes");
local l_Cutscenes_0 = l_Assets_0:WaitForChild("Cutscenes");
--local l_ClientCommunication_0 = l_ReplicatedStorage_0:WaitForChild("ClientCommunication");
--local l_ClientInvoke_0 = l_ReplicatedStorage_0:WaitForChild("ClientInvoke");
local v40 = {
	Ragdoll = false, 
	EvasiveCooldown = false, 
	NoEvasiveCooldown = false, 
	EvasiveAvailable = false, 
	NoDash = false, 
	Rolling = false, 
	NoDashCooldown = false, 
	NoSprint = false, 
	Awakened = false, 
	NoRotate = false, 
	Freeze = false, 
	Slow = false, 
	NoMovement = false, 
	NoSkillCooldown = false, 
	NoJump = false
};
local v41 = false;
local v42 = false;
local v43 = false;
local v44 = nil;

local l_CurrentCamera_1 = workspace.CurrentCamera;
local l_ClientRenderRequest_0 = l_ReplicatedStorage_0:WaitForChild("ClientRenderRequest");
local l_Map_0 = workspace:WaitForChild("Map");
local l_Borders_0 = l_Map_0:WaitForChild("Borders");
local l_VFX_0 = workspace:WaitForChild("VFX");
local l_FlyingRocksStorage_0 = l_VFX_0:WaitForChild("FlyingRocksStorage");
local l_Trees_0 = l_Map_0:WaitForChild("Destroyables"):WaitForChild("Trees");
local l_Bushes_0 = l_Map_0:WaitForChild("Destroyables"):WaitForChild("Bushes");
local l_Characters_0 = workspace:WaitForChild("Characters");
for _, v64 in v0.pairs(l_Characters_0:GetChildren()) do
	if v64:FindFirstChild("Head") and v64:FindFirstChild("Head"):FindFirstChild("HealthUI") then
		local l_Text_0 = v64.Head.HealthUI.Text;
		local l_Health_0 = v64:FindFirstChildOfClass("Humanoid").Health;
		if l_Health_0 ~= v0.math.huge then
			l_Text_0.Text = v0.tostring(v0.math.floor(l_Health_0)) .. "%";
		else
			l_Text_0.Text = "\226\136\158%";
		end;
		v64:FindFirstChildOfClass("Humanoid").HealthChanged:Connect(function(v67)
			if v67 ~= v0.math.huge then
				l_Text_0.Text = v0.tostring(v0.math.floor(v67)) .. "%";
				return;
			else
				l_Text_0.Text = "\226\136\158%";
				return;
			end;
		end);
	end;
end;
l_Characters_0.ChildAdded:Connect(function(v68)
	v68:WaitForChild("Head");
	v68:WaitForChild("Humanoid");
	if v68:FindFirstChild("Head") and v68:FindFirstChild("Head"):FindFirstChild("HealthUI") then
		local l_Text_1 = v68.Head.HealthUI.Text;
		local l_Health_1 = v68:FindFirstChildOfClass("Humanoid").Health;
		if l_Health_1 ~= v0.math.huge then
			l_Text_1.Text = v0.tostring(v0.math.floor(l_Health_1)) .. "%";
		else
			l_Text_1.Text = "\226\136\158%";
		end;
		v68:FindFirstChildOfClass("Humanoid").HealthChanged:Connect(function(v71)
			if v71 ~= v0.math.huge then
				l_Text_1.Text = v0.tostring(v0.math.floor(v71)) .. "%";
				return;
			else
				l_Text_1.Text = "\226\136\158%";
				return;
			end;
		end);
	end;
end);
local v72 = v0.RaycastParams.new();
v72.FilterType = v0.Enum.RaycastFilterType.Include;
v72.FilterDescendantsInstances = {
	l_Map_0:WaitForChild("Arena"), 
	l_Map_0:WaitForChild("Miscellaneous"), 
	l_Borders_0, 
	l_Map_0:WaitForChild("Destroyables"):WaitForChild("Buildings")
};
local l_Tiles_0 = l_Map_0:WaitForChild("Arena"):WaitForChild("Tiles");
local v74 = v0.RaycastParams.new();
v74.FilterType = v0.Enum.RaycastFilterType.Include;
v74.FilterDescendantsInstances = {
	l_Tiles_0
};

local v83 = v0.require(l_ReplicatedStorage_0:WaitForChild("Modules"):WaitForChild("CameraShaker"));
local v86 = v83.new(v0.Enum.RenderPriority.Camera.Value, function(v84)
	local l_l_CurrentCamera_1_0 = l_CurrentCamera_1;
	l_l_CurrentCamera_1_0.CFrame = l_l_CurrentCamera_1_0.CFrame * v84;
end);
local l_Sounds_0 = l_Assets_0:WaitForChild("Sounds");
local v88 = {
	AutoSkill = true, 
	Blood = true, 
	PhotosensitiveMode = false, 
	HideAccessories = false, 
	HidePackages = false, 
	HideLeaderboards = false, 
	MuteAwakeningMusic = false, 
	CameraShakeMultiplier = 1, 
	VolumeMultiplier = 1, 
	ShiftlockOffset = 1.75, 
	ConsoleSettings = {
		ShowControls = true, 
		Sensitivity = 1
	}, 
	MobileButtons = {
		Dash = {
			ScaleX = 0, 
			OffsetX = 0, 
			ScaleY = 0, 
			OffsetY = 0, 
			SizeMultiplier = 1
		}, 
		M1 = {
			ScaleX = 0, 
			OffsetX = 0, 
			ScaleY = 0, 
			OffsetY = 0, 
			SizeMultiplier = 1
		}, 
		Block = {
			ScaleX = 0, 
			OffsetX = 0, 
			ScaleY = 0, 
			OffsetY = 0, 
			SizeMultiplier = 1
		}, 
		Shiftlock = {
			ScaleX = 0, 
			OffsetX = 0, 
			ScaleY = 0, 
			OffsetY = 0, 
			SizeMultiplier = 1
		}
	}, 
	KillSound = false
};
local v104 = {
	PlaySoundInInstance = function(v89, v90, v91, v92)
		if typeof(v89) ~= "Instance" then
			v0.warn("No Part input provided.");
			return;
		elseif typeof(v90) ~= "string" then
			v0.warn("No SoundName input provided.");
			return;
		elseif not l_Sounds_0:FindFirstChild(v90) then
			v0.warn("SoundName input not found in the Sounds folder.");
			return;
		else
			if typeof(v91) ~= "boolean" then
				v91 = true;
			end;
			if typeof(v92) ~= "boolean" then
				v92 = false;
			end;
			local v93 = l_Sounds_0:FindFirstChild(v90):Clone();
			if v91 == true then
				v93.Ended:Connect(function()
					if v93 ~= nil and v93.Parent ~= nil then
						v93:Destroy();
					end;
				end);
			end;
			v93.Looped = v92;
			v93:SetAttribute("DefaultVolume", v93.Volume);
			v93.Volume = v93.Volume * v88.VolumeMultiplier;
			v93.Parent = v89;
			v93:Play();
			return v93;
		end;
	end, 
	PlaySoundAtCFrame = function(v94, v95, v96, v97)
		if typeof(v94) ~= "CFrame" and typeof(v94) ~= "Vector3" then
			v0.warn("No OriginCFrame input provided.");
			return;
		elseif typeof(v95) ~= "string" then
			v0.warn("No SoundName input provided.");
			return;
		elseif not l_Sounds_0:FindFirstChild(v95) then
			v0.warn("SoundName input not found in the Sounds folder: " .. v95);
			return;
		else
			if typeof(v96) ~= "boolean" then
				v96 = true;
			end;
			if typeof(v97) ~= "boolean" then
				v97 = false;
			end;
			local v98 = v0.Instance.new("Part");
			v98.Name = "SoundPlayerPart";
			v98.Material = v0.Enum.Material.SmoothPlastic;
			v98.Anchored = true;
			v98.Massless = true;
			v98.CanCollide = false;
			v98.CanQuery = false;
			v98.CanTouch = false;
			v98.CastShadow = false;
			v98.EnableFluidForces = false;
			v98.Transparency = 1;
			v98.Size = v0.Vector3.zero;
			if typeof(v94) == "CFrame" then
				v98.CFrame = v94;
			else
				v98.Position = v94;
			end;
			local v99 = l_Sounds_0:FindFirstChild(v95):Clone();
			if v96 == true then
				v99.Ended:Connect(function()
					if v98 ~= nil and v98.Parent ~= nil then
						v98:Destroy();
					end;
				end);
			end;
			v99.Looped = v97;
			v99:SetAttribute("DefaultVolume", v99.Volume);
			v99.Volume = v99.Volume * v88.VolumeMultiplier;
			v99.Parent = v98;
			v98.Parent = l_VFX_0;
			v99:Play();
			return v99, v98;
		end;
	end, 
	PlaySound = function(v100, v101, v102)
		if typeof(v101) ~= "boolean" then
			v101 = true;
		end;
		if typeof(v102) ~= "boolean" then
			v102 = false;
		end;
		local v103 = l_Sounds_0:FindFirstChild(v100):Clone();
		if v101 == true then
			v103.Ended:Connect(function()
				if v103 ~= nil and v103.Parent ~= nil then
					v103:Destroy();
				end;
			end);
		end;
		v103.Looped = v102;
		v103:SetAttribute("DefaultVolume", v103.Volume);
		v103.Volume = v103.Volume * v88.VolumeMultiplier;
		v103.Parent = l_VFX_0;
		v103:Play();
		return v103;
	end
};
local l_Bezier_0 = require(l_ReplicatedStorage_0:WaitForChild("Modules"):WaitForChild("BezierCurve"));
local l_BoatTween_0 = require(l_ReplicatedStorage_0:WaitForChild("Modules"):WaitForChild("BoatTween"));
local v108 = {};
local v109 = v0.Instance.new("Folder");
v109.Name = "Settings";
v109.Parent = l_LocalPlayer_0;

local v112 = nil;
local v113 = nil;
local v114 = nil;
local v115 = nil;
local v116 = nil;

VFXService = {
	CreateBind = function(v203, v204, v205)
		if typeof(v203) ~= "Instance" then
			v0.warn("No BindTo input provided.");
			return;
		elseif not v203:IsA("Model") then
			v0.warn("No BindTo input provided.");
			return;
		elseif typeof(v204) ~= "string" then
			v0.warn("No BindName input provided.");
			return;
		else
			local v206 = v0.Instance.new("Configuration");
			v206.Name = v204;
			v206:SetAttribute("Bind", true);
			v206.Parent = v203;
			local v207 = nil;
			local v208 = nil;
			local v209 = nil;
			local function v210()
				if v207 ~= nil then
					v207:Disconnect();
					v207 = nil;
				end;
				if v208 ~= nil then
					v208:Disconnect();
					v208 = nil;
				end;
				if v209 ~= nil then
					v209:Disconnect();
					v209 = nil;
				end;
				if typeof(v205) == "function" then
					v205();
				end;
			end;
			v207 = v203.HumanoidRootPart.Destroying:Once(v210);
			v208 = v206.Destroying:Once(v210);
			v209 = v203.Destroying:Once(v210);
			return v206;
		end;
	end, 
	DestroyBind = function(v211, v212, v213)
		if typeof(v211) ~= "Instance" then
			v0.warn("No BindTo input provided.");
			return;
		elseif not v211:IsA("Model") then
			v0.warn("No BindTo input provided.");
			return;
		elseif typeof(v212) ~= "string" then
			v0.warn("No BindName input provided.");
			return;
		else
			if typeof(v213) ~= "boolean" then
				v213 = false;
			end;
			if v213 == false then
				for _, v215 in v0.pairs(v211:GetChildren()) do
					if v215:IsA("Configuration") and v215.Name == v212 then
						v215:Destroy();
						break;
					end;
				end;
			end;
			if v213 == true then
				for _, v217 in v0.pairs(v211:GetChildren()) do
					if v217:IsA("Configuration") and v217.Name == v212 then
						v217:Destroy();
					end;
				end;
			end;
			return;
		end;
	end, 
	CheckBind = function(v218, v219)
		if typeof(v218) ~= "Instance" then
			v0.warn("No Target input provided.");
			return;
		elseif not v218:IsA("Model") then
			v0.warn("No Target input provided.");
			return;
		elseif typeof(v219) ~= "string" then
			v0.warn("No BindName input provided.");
			return;
		else
			local v220 = false;
			for _, v222 in v0.pairs(v218:GetChildren()) do
				if v222:IsA("Configuration") and v222.Name == v219 then
					return true;
				end;
			end;
			return v220;
		end;
	end, 
	DestroyAllBinds = function(v223, v224)
		if typeof(v223) ~= "Instance" then
			v0.warn("No Target input provided.");
			return;
		elseif not v223:IsA("Model") then
			v0.warn("No Target input provided.");
			return;
		else
			if typeof(v224) ~= "table" then
				v224 = {};
			end;
			for _, v226 in v0.pairs(v223:GetChildren()) do
				if v226:IsA("Configuration") and not v0.table.find(v224, v226.Name) then
					v226:Destroy();
				end;
			end;
			return;
		end;
	end, 
	MakeDarker = function(v227, v228, v229, v230)
		if typeof(v228) ~= "number" then
			v228 = 10;
		end;
		if typeof(v229) ~= "number" then
			v229 = 10;
		end;
		if typeof(v230) ~= "number" then
			v230 = 10;
		end;
		local v231 = v227.R * 255 - v228;
		if v231 < 0 then
			v231 = 0;
		end;
		if v231 > 255 then
			v231 = 255;
		end;
		local v232 = v227.G * 255 - v229;
		if v232 < 0 then
			v232 = 0;
		end;
		if v232 > 255 then
			v232 = 255;
		end;
		local v233 = v227.B * 255 - v230;
		if v233 < 0 then
			v233 = 0;
		end;
		if v233 > 255 then
			v233 = 255;
		end;
		return v0.Color3.fromRGB(v231, v232, v233);
	end, 
	GetCircularWallRocksProperties = function(v234, v235, v236, v237, v238, v239, v240, v241, v242, v243, v244, v245, v246, v247, v248, v249, v250, v251)
		if typeof(v234) ~= "table" then
			v234 = {};
		end;
		if typeof(v235) ~= "CFrame" then
			v0.warn("No OriginCFrame input provided.");
			return;
		elseif typeof(v236) ~= "number" and typeof(v236) ~= "table" then
			v0.warn("No radius input provided.");
			return;
		elseif typeof(v237) ~= "number" then
			v0.warn("No Amount input provided.");
			return;
		elseif typeof(v238) ~= "number" and typeof(v238) ~= "table" then
			v0.warn("No SizeX input provided.");
			return;
		elseif typeof(v239) ~= "number" and typeof(v239) ~= "table" then
			v0.warn("No SizeY input provided.");
			return;
		elseif typeof(v240) ~= "number" and typeof(v240) ~= "table" then
			v0.warn("No SizeZ input provided.");
			return;
		elseif typeof(v241) ~= "number" and typeof(v241) ~= "table" then
			v0.warn("No AngularOffsetX input provided.");
			return;
		elseif typeof(v242) ~= "number" and typeof(v242) ~= "table" then
			v0.warn("No AngularOffsetY input provided.");
			return;
		elseif typeof(v243) ~= "number" and typeof(v243) ~= "table" then
			v0.warn("No AngularOffsetZ input provided.");
			return;
		elseif typeof(v244) ~= "table" then
			v0.warn("No AnimationStyle input provided.");
			return;
		else
			if typeof(v245) ~= "number" then
				v245 = 5;
			end;
			if typeof(v246) ~= "boolean" then
				v246 = false;
			end;
			if typeof(v247) ~= "table" then
				v247 = {
					IncludeDuplicate = true, 
					ShrinkFactor = 1.25, 
					RadiusOffset = 1
				};
			end;
			if typeof(v248) ~= "number" then
				v248 = 25;
			end;
			if typeof(v249) ~= "number" and typeof(v249) ~= "table" then
				v249 = {
					0, 
					0
				};
			end;
			if typeof(v250) ~= "number" and typeof(v250) ~= "table" then
				v250 = {
					0, 
					0
				};
			end;
			if typeof(v251) ~= "number" and typeof(v251) ~= "table" then
				v251 = {
					0, 
					0
				};
			end;
			local v252 = 0;
			local v253 = 360 / v237;
			local _ = {};
			local l_v235_0 = v235;
			local l_v236_0 = v236;
			local l_v238_0 = v238;
			local l_v239_0 = v239;
			local l_v240_0 = v240;
			local l_v241_0 = v241;
			local l_v242_0 = v242;
			local l_v243_0 = v243;
			local l_v249_0 = v249;
			local l_v250_0 = v250;
			local l_v251_0 = v251;
			local v266 = v0.Random.new();
			local v267 = workspace:Raycast(l_v235_0.Position + l_v235_0.UpVector, -l_v235_0.UpVector * v0.math.abs(v248 + 1), v72);
			if v267 then
				local l_LookVector_1 = v235.LookVector;
				local _ = l_LookVector_1.X;
				local _ = l_LookVector_1.Z;
				l_v235_0 = v0.CFrame.new(v267.Position, v267.Position + v267.Normal);
				for _ = 1, v237 do
					v236 = l_v236_0;
					v238 = l_v238_0;
					v239 = l_v239_0;
					v240 = l_v240_0;
					v241 = l_v241_0;
					v242 = l_v242_0;
					v243 = l_v243_0;
					v249 = l_v249_0;
					v250 = l_v250_0;
					v251 = l_v251_0;
					if typeof(l_v236_0) == "table" then
						v236 = v266:NextNumber(l_v236_0[1], l_v236_0[2]);
					end;
					if typeof(l_v238_0) == "table" then
						v238 = v266:NextNumber(l_v238_0[1], l_v238_0[2]);
					end;
					if typeof(l_v239_0) == "table" then
						v239 = v266:NextNumber(l_v239_0[1], l_v239_0[2]);
					end;
					if typeof(l_v240_0) == "table" then
						v240 = v266:NextNumber(l_v240_0[1], l_v240_0[2]);
					end;
					if typeof(l_v241_0) == "table" then
						v241 = v266:NextNumber(l_v241_0[1], l_v241_0[2]);
					end;
					if typeof(l_v242_0) == "table" then
						v242 = v266:NextNumber(l_v242_0[1], l_v242_0[2]);
					end;
					if typeof(l_v243_0) == "table" then
						v243 = v266:NextNumber(l_v243_0[1], l_v243_0[2]);
					end;
					if typeof(l_v249_0) == "table" then
						v249 = v266:NextNumber(l_v249_0[1], l_v249_0[2]);
					end;
					if typeof(l_v250_0) == "table" then
						v250 = v266:NextNumber(l_v250_0[1], l_v250_0[2]);
					end;
					if typeof(l_v251_0) == "table" then
						v251 = v266:NextNumber(l_v251_0[1], l_v251_0[2]);
					end;
					local v272 = v0.Vector3.new(v238, v239, v240);
					local v273 = v0.Color3.fromRGB();
					local l_Concrete_0 = v0.Enum.Material.Concrete;
					local v275 = nil;
					local v276 = nil;
					local v277 = nil;
					local v278 = {
						v238, 
						v239, 
						v240
					};
					v0.table.sort(v278);
					local v279 = v278[3];
					local v280 = l_v235_0 * v0.CFrame.Angles(0, 0, v0.math.rad(v252)) * v0.CFrame.new(v236, 0, v279);
					local l_Position_2 = v280.Position;
					local v282 = workspace:Raycast(l_Position_2 + l_v235_0.LookVector * v279 * 2, -l_v235_0.LookVector * v279 * 2.5, v72);
					if v282 then
						v273 = VFXService.MakeDarker(v282.Instance.Color, 10, 10, 10);
						l_Concrete_0 = if v282.Instance.Material == v0.Enum.Material.Plastic then v0.Enum.Material.SmoothPlastic else v282.Instance.Material;
						local v283 = v0.math.acos(v282.Normal:Dot(v0.Vector3.new(0, 1, 0)));
						v280 = v280 * v0.CFrame.Angles(0, v283 / 2, v0.math.pi / 2);
						l_Position_2 = v282.Position;
						for _, v285 in v0.pairs(v282.Instance:GetChildren()) do
							if v285:IsA("Texture") then
								v276 = v285.Texture;
								v277 = v285.Transparency;
								break;
							end;
						end;
						if v246 == true then
							v275 = v0.Vector3.new(v0.math.random(-180, 180), v0.math.random(-180, 180), v0.math.random(-180, 180));
						else
							l_Position_2 = l_Position_2 - l_v235_0.LookVector * (v239 / 8);
						end;
						v234[#v234 + 1] = {
							Lifetime = v245, 
							AnimationStyle = v244, 
							Size = v272, 
							Color = v273, 
							Material = l_Concrete_0, 
							Orientation = v275, 
							CFrame = v280 * v0.CFrame.new(v249, v250, v251), 
							Position = l_Position_2, 
							Texture = v276, 
							TextureTransparency = v277
						};
						if v247.IncludeDuplicate == true then
							v234[#v234 + 1] = {
								Lifetime = v245, 
								AnimationStyle = v244, 
								Size = v272 / (v247.ShrinkFactor or 1.15), 
								Color = v273, 
								Material = l_Concrete_0, 
								Orientation = v275, 
								CFrame = v280 * v0.CFrame.new(v249, v250, v251), 
								Position = l_Position_2 + v0.CFrame.new(l_Position_2, l_v235_0.Position).LookVector * (v247.RadiusOffset or 1), 
								Texture = v276, 
								TextureTransparency = v277
							};
						end;
						v252 = v252 + v253;
					end;
				end;
				return;
			else
				return;
			end;
		end;
	end, 
	GetCircularRocksProperties = function(v286, v287, v288, v289, v290, v291, v292, v293, v294, v295, v296, v297, v298, v299, v300, v301, v302, v303, v304)
		if typeof(v286) ~= "table" then
			v286 = {};
		end;
		if typeof(v287) ~= "CFrame" then
			v0.warn("No OriginCFrame input provided.");
			return;
		elseif typeof(v288) ~= "number" and typeof(v288) ~= "table" then
			v0.warn("No radius input provided.");
			return;
		elseif typeof(v289) ~= "number" then
			v0.warn("No Amount input provided.");
			return;
		elseif typeof(v290) ~= "number" and typeof(v290) ~= "table" then
			v0.warn("No SizeX input provided.");
			return;
		elseif typeof(v291) ~= "number" and typeof(v291) ~= "table" then
			v0.warn("No SizeY input provided.");
			return;
		elseif typeof(v292) ~= "number" and typeof(v292) ~= "table" then
			v0.warn("No SizeZ input provided.");
			return;
		elseif typeof(v293) ~= "number" and typeof(v293) ~= "table" then
			v0.warn("No AngularOffsetX input provided.");
			return;
		elseif typeof(v294) ~= "number" and typeof(v294) ~= "table" then
			v0.warn("No AngularOffsetY input provided.");
			return;
		elseif typeof(v295) ~= "number" and typeof(v295) ~= "table" then
			v0.warn("No AngularOffsetZ input provided.");
			return;
		elseif typeof(v296) ~= "table" then
			v0.warn("No AnimationStyle input provided.");
			return;
		else
			if typeof(v297) ~= "number" then
				v297 = 5;
			end;
			if typeof(v298) ~= "boolean" then
				v298 = false;
			end;
			if typeof(v299) ~= "table" then
				v299 = {
					IncludeDuplicate = true, 
					ShrinkFactor = 1.25, 
					RadiusOffset = 1
				};
			end;
			if typeof(v300) ~= "number" then
				v300 = 25;
			end;
			if typeof(v301) ~= "number" and typeof(v301) ~= "table" then
				v301 = {
					0, 
					0
				};
			end;
			if typeof(v302) ~= "number" and typeof(v302) ~= "table" then
				v302 = {
					0, 
					0
				};
			end;
			if typeof(v303) ~= "number" and typeof(v303) ~= "table" then
				v303 = {
					0, 
					0
				};
			end;
			local v305 = 0;
			local v306 = 360 / v289;
			local _ = {};
			local l_v287_0 = v287;
			local l_v288_0 = v288;
			local l_v290_0 = v290;
			local l_v291_0 = v291;
			local l_v292_0 = v292;
			local l_v293_0 = v293;
			local l_v294_0 = v294;
			local l_v295_0 = v295;
			local l_v301_0 = v301;
			local l_v302_0 = v302;
			local l_v303_0 = v303;
			local v319 = v0.Random.new();
			local v320 = workspace:Raycast(l_v287_0.Position + v0.Vector3.new(0, 1, 0), v0.Vector3.new(0, -v0.math.abs(v300 + 1), 0), v72);
			if v320 then
				local l_LookVector_2 = v287.LookVector;
				local l_X_1 = l_LookVector_2.X;
				local l_Z_1 = l_LookVector_2.Z;
				local v324 = 0;
				if l_X_1 == 0 and l_Z_1 == 0 then
					v324 = 0.001;
				end;
				l_v287_0 = v0.CFrame.new(v320.Position, v320.Position + v0.Vector3.new(l_X_1, v324, l_Z_1));
				for _ = 1, v289 do
					v288 = l_v288_0;
					v290 = l_v290_0;
					v291 = l_v291_0;
					v292 = l_v292_0;
					v293 = l_v293_0;
					v294 = l_v294_0;
					v295 = l_v295_0;
					if typeof(l_v288_0) == "table" then
						v288 = v319:NextNumber(l_v288_0[1], l_v288_0[2]);
					end;
					if typeof(l_v290_0) == "table" then
						v290 = v319:NextNumber(l_v290_0[1], l_v290_0[2]);
					end;
					if typeof(l_v291_0) == "table" then
						v291 = v319:NextNumber(l_v291_0[1], l_v291_0[2]);
					end;
					if typeof(l_v292_0) == "table" then
						v292 = v319:NextNumber(l_v292_0[1], l_v292_0[2]);
					end;
					if typeof(l_v293_0) == "table" then
						v293 = v319:NextNumber(l_v293_0[1], l_v293_0[2]);
					end;
					if typeof(l_v294_0) == "table" then
						v294 = v319:NextNumber(l_v294_0[1], l_v294_0[2]);
					end;
					if typeof(l_v295_0) == "table" then
						v295 = v319:NextNumber(l_v295_0[1], l_v295_0[2]);
					end;
					if typeof(l_v301_0) == "table" then
						v301 = v319:NextNumber(l_v301_0[1], l_v301_0[2]);
					end;
					if typeof(l_v302_0) == "table" then
						v302 = v319:NextNumber(l_v302_0[1], l_v302_0[2]);
					end;
					if typeof(l_v303_0) == "table" then
						v303 = v319:NextNumber(l_v303_0[1], l_v303_0[2]);
					end;
					v324 = v0.Vector3.new(v290, v291, v292);
					local v326 = v0.Color3.fromRGB(120, 120, 120);
					local l_Concrete_1 = v0.Enum.Material.Concrete;
					local v328 = nil;
					local v329 = nil;
					local v330 = nil;
					local v331 = {
						v290, 
						v291, 
						v292
					};
					v0.table.sort(v331);
					local v332 = v331[3];
					local v333 = l_v287_0 * v0.CFrame.Angles(0, v0.math.rad(v305), 0) * v0.CFrame.new(0, 0, v288);
					local l_Position_3 = v333.Position;
					local v335 = workspace:Raycast(l_Position_3 + v0.Vector3.new(0, 5, 0), v0.Vector3.new(0, -v332 * 2.5, 0), v72);
					if v335 then
						v326 = VFXService.MakeDarker(v335.Instance.Color, 10, 10, 10);
						l_Concrete_1 = if v335.Instance.Material == v0.Enum.Material.Plastic then v0.Enum.Material.SmoothPlastic else v335.Instance.Material;
						if v335.Normal.Y ~= 1 then
							v333 = v0.CFrame.new(v335.Position, v335.Position + v335.Normal);
						end;
						l_Position_3 = v335.Position;
						for _, v337 in v0.pairs(v335.Instance:GetChildren()) do
							if v337:IsA("Texture") then
								v329 = v337.Texture;
								v330 = v337.Transparency;
								break;
							end;
						end;
						if v298 == true then
							v328 = v0.Vector3.new(v0.math.random(-180, 180), v0.math.random(-180, 180), v0.math.random(-180, 180));
						else
							local v338 = nil;
							v338 = if typeof(v304) == "Vector3" then v304 else v0.Vector3.new(0, v288, 0);
							v333 = v0.CFrame.new(v335.Position, l_v287_0.Position + v338 or v0.Vector3.new(0, v288, 0));
							local v339 = v0.math.sqrt(v0.math.pow(v338.Y, 2) + v0.math.pow(v288, 2));
							local v340 = 2 * (0.5 * v291 / v0.math.cos(v0.math.asin(v338.Y / v339)));
							if not (v301 == 0 and v302 == 0) or v303 ~= 0 then
								local l_Position_4 = l_v287_0.Position;
								local v342 = v0.Vector3.new(l_Position_3.X, l_Position_4.Y, l_Position_3.Z);
								local v343 = v0.CFrame.new(l_Position_4, v342);
								l_Position_3 = l_Position_3 + (v343.LookVector * v303 + v343.RightVector * v301);
								local v344 = workspace:Raycast(l_Position_3 + v0.Vector3.new(0, 5, 0), v0.Vector3.new(0, -v332 * 2.5, 0), v72);
								if v344 then
									v326 = VFXService.MakeDarker(v344.Instance.Color, 10, 10, 10);
									l_Concrete_1 = if v344.Instance.Material == v0.Enum.Material.Plastic then v0.Enum.Material.SmoothPlastic else v344.Instance.Material;
									l_Position_3 = v344.Position;
									for _, v346 in v0.pairs(v344.Instance:GetChildren()) do
										if v346:IsA("Texture") then
											v329 = v346.Texture;
											v330 = v346.Transparency;
											break;
										end;
									end;
								else
									continue;
								end;
							end;
							l_Position_3 = l_Position_3 - v0.Vector3.new(0, v340 / 8 + v302, 0);
						end;
						v286[#v286 + 1] = {
							Lifetime = v297, 
							AnimationStyle = v296, 
							Size = v324, 
							Color = v326, 
							Material = l_Concrete_1, 
							Orientation = v328, 
							CFrame = v333, 
							Position = l_Position_3, 
							Texture = v329, 
							TextureTransparency = v330
						};
						if v299.IncludeDuplicate == true then
							v286[#v286 + 1] = {
								Lifetime = v297, 
								AnimationStyle = v296, 
								Size = v324 / (v299.ShrinkFactor or 1.15), 
								Color = v326, 
								Material = l_Concrete_1, 
								Orientation = v328, 
								CFrame = v333, 
								Position = l_Position_3 + v333.LookVector * (v299.RadiusOffset or v324.Z / 4) + v333.UpVector * (v299.RadiusOffsetY or -v324.Y / 4) + v0.Vector3.new(0, v299.LinearOffsetY or 0, 0), 
								Texture = v329, 
								TextureTransparency = v330
							};
						end;
						v305 = v305 + v306;
					end;
				end;
				return;
			else
				return;
			end;
		end;
	end, 
	ApplyCircularRocksProperties = function(v347)
		if #v347 <= 0 then
			return;
		else
			local v348 = v0.Instance.new("Folder");
			v348.Name = "CircularRocks";
			v348.Parent = l_VFX_0;
			for v349, v350 in v0.pairs(v347) do
				local v351 = {};
				local l_AnimationStyle_0 = v350.AnimationStyle;
				local l_Lifetime_0 = v350.Lifetime;
				local v354 = v0.Instance.new("Part");
				v0.table.insert(v351, v354);
				v354.Name = "Rock" .. v349;
				v354.Anchored = true;
				v354.CollisionGroup = "Circular Rocks";
				v354.EnableFluidForces = false;
				v354.Massless = true;
				v354.CanQuery = false;
				v354.CanTouch = false;
				for v355, v356 in v0.pairs(v350) do
					if v356 ~= nil then
						if v355 ~= "Texture" and v355 ~= "Lifetime" and v355 ~= "AnimationStyle" and v355 ~= "TextureTransparency" then
							v354[v355] = v356;
						elseif v355 == "Texture" then
							for v357 = 1, 6 do
								local v358 = v0.Instance.new("Texture");
								v358.Texture = v356;
								if v357 == 1 then
									v358.Face = "Front";
								elseif v357 == 2 then
									v358.Face = "Left";
								elseif v357 == 3 then
									v358.Face = "Right";
								elseif v357 == 4 then
									v358.Face = "Back";
								elseif v357 == 5 then
									v358.Face = "Top";
								elseif v357 == 6 then
									v358.Face = "Bottom";
								end;
								v358.Transparency = v350.TextureTransparency;
								v358.Parent = v354;
							end;
						end;
					end;
				end;
				if typeof(l_AnimationStyle_0) == "table" then
					local v359 = l_AnimationStyle_0[1] or "Rise";
					local v360 = l_AnimationStyle_0[2] or "Sink";
					local v361 = l_AnimationStyle_0[3] or 0.35;
					local v362 = l_AnimationStyle_0[4] or 1.75;
					if v359 == "Rise" then
						for _, v364 in v0.pairs(v351) do
							local v365 = {
								v364.Size.X, 
								v364.Size.Y, 
								v364.Size.Z
							};
							local v366 = 0;
							for _, v368 in v0.ipairs(v365) do
								if v366 < v368 then
									v366 = v368;
								end;
							end;
							local l_Orientation_0 = v364.Orientation;
							v364.Orientation = v0.Vector3.new(v0.math.random(-180, 180), v0.math.random(-180, 180), v0.math.random(-180, 180));
							v364.Position = v364.Position - v0.Vector3.new(0, v366 + 1, 0);
							v364.Parent = v348;
							l_TweenService_0:Create(v364, v0.TweenInfo.new(v361, v0.Enum.EasingStyle.Cubic, v0.Enum.EasingDirection.Out), {
								Orientation = l_Orientation_0, 
								Position = v364.Position + v0.Vector3.new(0, v366 + 1, 0)
							}):Play();
						end;
					end;
					if v359 == "Grow" then
						for _, v371 in v0.pairs(v351) do
							local l_Size_0 = v371.Size;
							v371.Size = v0.Vector3.zero;
							v371.Parent = v348;
							l_TweenService_0:Create(v371, v0.TweenInfo.new(v361, v0.Enum.EasingStyle.Cubic, v0.Enum.EasingDirection.Out), {
								Size = l_Size_0
							}):Play();
						end;
					end;
					v0.task.delay(l_Lifetime_0 or 5, function()
						if v360 == "Sink" then
							for _, v374 in v0.pairs(v351) do
								local l_X_2 = v374.Orientation.X;
								local l_Y_0 = v374.Orientation.Y;
								local _ = v374.Orientation.Z;
								local _ = l_X_2 + v0.math.random(-20, 20);
								local _ = l_Y_0 + v0.math.random(-20, 20);
								local _ = l_Y_0 + v0.math.random(-20, 20);
								l_TweenService_0:Create(v374, v0.TweenInfo.new(v362, v0.Enum.EasingStyle.Circular, v0.Enum.EasingDirection.In), {
									Position = v374.Position - v0.Vector3.new(0, v374.Size.Y + 10, 0)
								}):Play();
							end;
							v0.task.wait(v362);
							v348:Destroy();
						end;
						if v360 == "Shrink" then
							for _, v382 in v0.pairs(v351) do
								l_TweenService_0:Create(v382, v0.TweenInfo.new(v362, v0.Enum.EasingStyle.Circular, v0.Enum.EasingDirection.Out), {
									Size = v0.Vector3.zero
								}):Play();
							end;
							v0.task.wait(v362);
							v348:Destroy();
						end;
					end);
				end;
			end;
			return;
		end;
	end, 
	GetFlyingRocksProperties = function(v383, v384, v385, v386, v387, v388, v389, v390, v391, v392, v393, v394)
		if typeof(v384) ~= "CFrame" then
			v0.warn("No OriginCFrame input provided.");
			return;
		else
			if typeof(v386) ~= "table" then
				v386 = {
					15, 
					50
				};
			end;
			if typeof(v387) ~= "table" then
				v387 = {
					40, 
					40
				};
			end;
			if typeof(v388) ~= "table" then
				v388 = {
					15, 
					50
				};
			end;
			if typeof(v389) ~= "number" then
				v389 = 1;
			end;
			if typeof(v390) ~= "number" then
				v390 = 1;
			end;
			if typeof(v391) ~= "number" then
				v391 = 1;
			end;
			if typeof(v392) ~= "number" then
				v392 = 2;
			end;
			v394 = typeof(v394) ~= "number" and 20 or v0.math.abs(v394);
			local v395 = v0.Vector3.new(v389, v390, v391);
			local v396 = {
				-1, 
				1
			};
			local v397 = #v396;
			local v398 = v0.Random.new();
			for _ = 1, v385 do
				local v400 = nil;
				local v401 = nil;
				local v402 = nil;
				local v403 = nil;
				local l_v384_0 = v384;
				local v405 = workspace:Raycast(v384.Position, v0.Vector3.new(0, -v394, 0), v72);
				if v405 then
					v400 = VFXService.MakeDarker(v405.Instance.Color, 10, 10, 10);
					v401 = if v405.Instance.Material == v0.Enum.Material.Plastic then v0.Enum.Material.SmoothPlastic else v405.Instance.Material;
					l_v384_0 = v0.CFrame.new(v405.Position) + v0.Vector3.new(0, v390 / 2, 0);
					for _, v407 in v0.pairs(v405.Instance:GetChildren()) do
						if v407:IsA("Texture") then
							v402 = v407.Texture;
							v403 = v407.Transparency;
							break;
						end;
					end;
					local v408 = v398:NextNumber(v386[1], v386[2]) * v396[v398:NextInteger(1, v397)];
					local v409 = v398:NextNumber(v387[1], v387[2]);
					local v410 = v398:NextNumber(v388[1], v388[2]) * v396[v398:NextInteger(1, v397)];
					local v411 = v392 * v396[v398:NextInteger(1, v397)];
					local v412 = v392 * v396[v398:NextInteger(1, v397)];
					local v413 = v392 * v396[v398:NextInteger(1, v397)];
					v383[#v383 + 1] = {
						Lifetime = v393, 
						Color = v400, 
						Material = v401, 
						Texture = v402, 
						TextureTransparency = v403, 
						CFrame = l_v384_0, 
						Size = v395, 
						AssemblyAngularVelocity = v0.Vector3.new(v411, v412, v413), 
						AssemblyLinearVelocity = v0.Vector3.new(v408, v409, v410)
					};
				end;
			end;
			return;
		end;
	end, 
	ApplyFlyingRocksProperties = function(v414)
		local v415 = v0.Instance.new("Folder");
		v415.Name = "FlyingRocks";
		v415.Parent = l_FlyingRocksStorage_0;
		for v416, v417 in v0.pairs(v414) do
			local v418 = {};
			local _ = v417.AnimationStyle;
			local l_Lifetime_1 = v417.Lifetime;
			local v421 = v0.Instance.new("Part");
			v0.table.insert(v418, v421);
			v421.Name = "Rock" .. v416;
			v421.CollisionGroup = "Flying Rocks";
			v421.Massless = true;
			v421.CanQuery = false;
			v421.EnableFluidForces = false;
			v421.CanTouch = false;
			v421.Parent = v415;
			for v422, v423 in v0.pairs(v417) do
				if v423 ~= nil then
					if v422 ~= "Texture" and v422 ~= "Lifetime" and v422 ~= "TextureTransparency" then
						v421[v422] = v423;
					elseif v422 == "Texture" then
						for v424 = 1, 6 do
							local v425 = v0.Instance.new("Texture");
							v425.Texture = v423;
							v425.Face = "Front";
							if v424 == 2 then
								v425.Face = "Left";
							elseif v424 == 3 then
								v425.Face = "Right";
							elseif v424 == 4 then
								v425.Face = "Back";
							elseif v424 == 5 then
								v425.Face = "Top";
							elseif v424 == 6 then
								v425.Face = "Bottom";
							end;
							v425.Transparency = v417.TextureTransparency;
							v425.Parent = v421;
						end;
					end;
				end;
			end;
			v0.task.delay(l_Lifetime_1 or 8, function()
				local v426 = v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out);
				for _, v428 in v0.pairs(v418) do
					for _, v430 in v0.pairs(v428:GetChildren()) do
						if v430:IsA("Texture") then
							l_TweenService_0:Create(v430, v426, {
								Transparency = 1
							}):Play();
						end;
					end;
					local v431 = l_TweenService_0:Create(v428, v426, {
						Size = v428.Size / 2, 
						Transparency = 1
					});
					v431.Completed:Once(function()
						if v428 ~= nil and v428.Parent ~= nil then
							v428:Destroy();
						end;
					end);
					v431:Play();
				end;
				v0.task.wait(0.5);
				v415:Destroy();
			end);
		end;
		return v415;
	end, 
	EmitFromCFrame = function(v432, v433, v434, v435, v436, v437)
		if typeof(v432) ~= "CFrame" then
			v0.warn("No EmitCFrame input provided.");
			return;
		elseif typeof(v433) ~= "table" then
			v0.warn("No ToEmit input provided.");
			return;
		else
			if typeof(v434) ~= "number" then
				v434 = 3;
			end;
			if typeof(v435) ~= "boolean" then
				v435 = true;
			end;
			if typeof(v436) ~= "table" then
				v436 = {};
				for _, v439 in v0.pairs(v433) do
					local l_v439_Attribute_0 = v439:GetAttribute("EmitCount");
					if typeof(l_v439_Attribute_0) == "number" then
						v0.table.insert(v436, l_v439_Attribute_0);
					else
						l_v439_Attribute_0 = v0.tonumber(v439.Name);
						if typeof(l_v439_Attribute_0) == "number" then
							v0.table.insert(v436, l_v439_Attribute_0);
						else
							v0.warn("The EmitCount for a specific particle was not detected.");
							return;
						end;
					end;
				end;
			end;
			local v441 = v0.Instance.new("Part");
			v441.CFrame = v432;
			v441.Size = v0.Vector3.zero;
			v441.Material = v0.Enum.Material.SmoothPlastic;
			v441.Massless = true;
			v441.EnableFluidForces = false;
			v441.CanCollide = false;
			v441.Anchored = true;
			v441.CanQuery = false;
			v441.CanTouch = false;
			v441.CastShadow = false;
			v441.Transparency = 1;
			v441.Parent = l_VFX_0;
			local v442 = {};
			for _, v444 in v0.pairs(v433) do
				local v445 = v444:Clone();
				if typeof(v437) == "Color3" then
					v445.Color = v0.ColorSequence.new(v437);
				end;
				v0.table.insert(v442, v445);
			end;
			if v435 == true then
				local v446 = v0.Instance.new("Attachment");
				v446.Parent = v441;
				for _, v448 in v0.pairs(v442) do
					v448.Parent = v446;
				end;
			else
				for _, v450 in v0.pairs(v442) do
					v450.Parent = v441;
				end;
			end;
			for v451, _ in v0.pairs(v433) do
				local v453 = v436[v451];
				v442[v451]:Emit(v453);
			end;
			v442 = nil;
			v0.task.delay(v434, function()
				if v441 ~= nil and v441.Parent ~= nil then
					v441:Destroy();
				end;
			end);
			return v441;
		end;
	end, 
	EmitFromAttachment = function(v454, v455, v456, _, v458, v459)
		if typeof(v454) ~= "Instance" then
			v0.warn("No AttachmentInstance input provided.");
			return;
		elseif not v454:IsA("Attachment") then
			v0.warn("Provided AttachmentInstance is not an Attachment.");
			return;
		elseif typeof(v455) ~= "table" then
			v0.warn("No ToEmit input provided.");
			return;
		else
			if typeof(v456) ~= "number" then
				v456 = 3;
			end;
			if typeof(v458) ~= "table" then
				v458 = {};
				for _, v461 in v0.pairs(v455) do
					local l_v461_Attribute_0 = v461:GetAttribute("EmitCount");
					if typeof(l_v461_Attribute_0) == "number" then
						v0.table.insert(v458, l_v461_Attribute_0);
					else
						l_v461_Attribute_0 = v0.tonumber(v461.Name);
						if typeof(l_v461_Attribute_0) == "number" then
							v0.table.insert(v458, l_v461_Attribute_0);
						else
							v0.warn("The EmitCount for a specific particle was not detected.");
							return;
						end;
					end;
				end;
			end;
			local v463 = {};
			for _, v465 in v0.pairs(v455) do
				local v466 = v465:Clone();
				if typeof(v459) == "Color3" then
					v466.Color = v0.ColorSequence.new(v459);
				end;
				v0.table.insert(v463, v466);
			end;
			for _, v468 in v0.pairs(v463) do
				v468.Parent = v454;
			end;
			for v469, _ in v0.pairs(v455) do
				local v471 = v458[v469];
				v463[v469]:Emit(v471);
			end;
			v0.task.delay(v456, function()
				for _, v473 in v0.pairs(v463) do
					if v473 ~= nil and v473.Parent ~= nil then
						v473:Destroy();
					end;
				end;
				v463 = nil;
			end);
			return;
		end;
	end, 
	ShakeCamera = function(v474, v475, v476, v477, v478, v479)
		local l_CameraShakeMultiplier_0 = v88.CameraShakeMultiplier;
		if l_CameraShakeMultiplier_0 <= 0 then
			return;
		elseif v42 == true then
			return;
		else
			if typeof(v474) ~= "number" then
				v474 = 0;
			end;
			if typeof(v475) ~= "number" then
				v475 = 0.4;
			end;
			if typeof(v476) ~= "number" then
				v476 = 15;
			end;
			if typeof(v477) ~= "number" then
				v477 = 0.25;
			end;
			if typeof(v478) ~= "number" then
				v478 = 0.5;
			end;
			if typeof(v479) ~= "number" then
				v479 = 0.25;
			end;
			v476 = v476 * l_CameraShakeMultiplier_0;
			local v481 = v0.Vector3.new(v477, v478, v479);
			if v86._running == false then
				v86:Start();
			end;
			v86:ShakeOnce(v476, v476, v474, v475, v481, v0.Vector3.zero);
			return;
		end;
	end, 
	EndCameraShake = function()
		v86:Stop();
		v86 = v83.new(v0.Enum.RenderPriority.Camera.Value, function(v482)
			local l_l_CurrentCamera_1_1 = l_CurrentCamera_1;
			l_l_CurrentCamera_1_1.CFrame = l_l_CurrentCamera_1_1.CFrame * v482;
		end);
	end, 
	EmitParticlesInInstance = function(v484)
		if typeof(v484) ~= "Instance" then
			v0.warn("No ParticlePart input provided.");
			return;
		else
			for _, v486 in v0.pairs(v484:GetDescendants()) do
				if v486:IsA("ParticleEmitter") then
					v486:Emit(v486:GetAttribute("EmitCount") or v0.tonumber(v486.Name));
					local v487 = v0.tonumber(v486:GetAttribute("EmitDuration"));
					if typeof(v487) == "number" and v487 > 0 then
						v486.Enabled = true;
						v0.task.delay(v487, function()
							if v486 ~= nil and v486.Parent ~= nil then
								v486.Enabled = false;
							end;
						end);
					end;
				end;
			end;
			return;
		end;
	end, 
	DestroyParticleContainer = function(v488, v489)
		if typeof(v488) ~= "Instance" then
			v0.warn("No ParticlePart input provided.");
			return;
		else
			if typeof(v489) ~= "number" then
				v489 = 4.5;
			end;
			v0.task.delay(v489, function()
				if v488 ~= nil and v488.Parent ~= nil then
					v488:Destroy();
				end;
			end);
			return;
		end;
	end, 
	FindGroundPosition = function(v490, v491, v492)
		if typeof(v490) ~= "Vector3" then
			v0.warn("No Origin input provided.");
			return;
		else
			if typeof(v491) ~= "number" then
				v491 = 7.5;
			end;
			if typeof(v492) ~= "RaycastParams" then
				v492 = v72;
			end;
			if v491 < 0 then
				v491 = v0.math.abs(v491);
			end;
			return (workspace:Raycast(v490, v0.Vector3.new(0, -v491, 0), v492));
		end;
	end, 
	CheckBloodParticles = function(v493)
		if typeof(v493) ~= "Instance" then
			v0.warn("No ParticleContainer input provided.");
			return;
		else
			if v88.Blood == false then
				for _, v495 in v0.pairs(v493:GetDescendants()) do
					if v495:IsA("ParticleEmitter") and v495.Name == "Blood" then
						v495:Destroy();
					end;
				end;
			end;
			return;
		end;
	end, 
	GetRandomAngle = function(v496, v497)
		if typeof(v496) ~= "number" then
			v496 = 0;
		end;
		if typeof(v497) ~= "number" then
			v497 = v0.math.pi * 2;
		end;
		if v497 <= v496 then
			v0.warn("Provided Minimum input is not less than the Maximum value.");
			return;
		else
			return v0.Random.new():NextNumber(v496, v497);
		end;
	end, 
	InitiateCutscene = function(v498, v499, v500, v501, v502, v503, v504, v505, v506, v507)
		if typeof(v498) ~= "string" then
			v0.warn("No CutsceneName input provided.");
			return;
		else
			if typeof(v499) ~= "number" then
				v499 = 60;
			end;
			if typeof(v501) ~= "Instance" then
				v0.warn("No RelativeTo input provided.");
				return;
			elseif not (v501 ~= nil) or v501.Parent == nil then
				v0.warn("No RelativeTo input provided.");
				return;
			elseif not v501:IsA("BasePart") then
				v0.warn("No RelativeTo input provided.");
				return;
			else
				if typeof(v502) ~= "CFrame" then
					v502 = v0.CFrame.new();
				end;
				if typeof(v503) ~= "table" then
					v503 = {
						Time = 0.8, 
						EasingStyle = v0.Enum.EasingStyle.Exponential, 
						EasingDirection = v0.Enum.EasingDirection.Out
					};
				end;
				if typeof(v504) ~= "table" then
					v504 = {
						Time = 0.6, 
						EasingStyle = v0.Enum.EasingStyle.Exponential, 
						EasingDirection = v0.Enum.EasingDirection.Out
					};
				end;
				if typeof(v503.Time) ~= "number" then
					v503.Time = 1.2;
				end;
				if typeof(v503.EasingStyle) ~= "EnumItem" then
					v503.EasingStyle = v0.Enum.EasingStyle.Exponential;
				end;
				if typeof(v503.EasingDirection) ~= "EnumItem" then
					v503.EasingDirection = v0.Enum.EasingDirection.Out;
				end;
				if typeof(v504.Time) ~= "number" then
					v504.Time = 1;
				end;
				if typeof(v504.EasingStyle) ~= "EnumItem" then
					v504.EasingStyle = v0.Enum.EasingStyle.Sine;
				end;
				if typeof(v504.EasingDirection) ~= "EnumItem" then
					v504.EasingDirection = v0.Enum.EasingDirection.Out;
				end;
				if typeof(v505) ~= "number" then
					v505 = -1;
				end;
				if typeof(v506) ~= "boolean" then
					v506 = true;
				end;
				if typeof(v507) ~= "boolean" then
					v507 = true;
				end;
				local l_l_Cutscenes_0_FirstChild_0 = l_Cutscenes_0:FindFirstChild(v498);
				if not (l_l_Cutscenes_0_FirstChild_0 ~= nil and l_l_Cutscenes_0_FirstChild_0.Parent ~= nil) or typeof(l_l_Cutscenes_0_FirstChild_0) ~= "Instance" then
					v0.warn("Provided CutsceneName was not found in the Cutscenes folder.");
					return;
				else
					local l_FOV_0 = l_l_Cutscenes_0_FirstChild_0:FindFirstChild("FOV");
					if not (l_FOV_0 ~= nil and l_FOV_0.Parent ~= nil) or typeof(l_FOV_0) ~= "Instance" then
						v0.warn("FOV folder was not found in the provided CutsceneName's cutscene folder. If there are meant to be no FOV changes, simply create an empty folder named 'FOV'.");
						return;
					else
						VFXService.DestroyBind(v26, "CutsceneCameraBind", true);
						VFXService.DestroyBind(v26, "CutsceneSmoothOutBind", true);
						local _ = (l_CurrentCamera_1.Focus.Position - l_CurrentCamera_1.CFrame.Position).Magnitude;
						l_CurrentCamera_1.CameraType = v0.Enum.CameraType.Scriptable;
						local l_CFrame_0 = l_CurrentCamera_1.CFrame;
						local l_FieldOfView_0 = l_CurrentCamera_1.FieldOfView;
						local v513 = v0.os.clock();
						local v514 = v0.Instance.new("Model");
						v514.Name = "CameraRig";
						v514.Parent = l_VFX_0;
						local v515 = v0.Instance.new("Part");
						v515.Name = "Camera";
						v515.Transparency = 1;
						v515.CanCollide = false;
						v515.CanTouch = false;
						v515.CastShadow = false;
						v515.CanQuery = false;
						v515.EnableFluidForces = false;
						v515.Anchored = false;
						v515.Size = v0.Vector3.zero;
						v515.Massless = true;
						v515.Material = v0.Enum.Material.SmoothPlastic;
						v515.Parent = v514;
						local v516 = v0.Instance.new("Part");
						v516.Name = "HumanoidRootPart";
						v516.Transparency = 1;
						v516.CanCollide = false;
						v516.CanTouch = false;
						v516.CastShadow = false;
						v516.CanQuery = false;
						v516.EnableFluidForces = false;
						v516.Anchored = false;
						v516.Size = v0.Vector3.zero;
						v516.Massless = true;
						v516.Material = v0.Enum.Material.SmoothPlastic;
						local v517 = v0.Instance.new("WeldConstraint");
						v517.Parent = v516;
						v517.Part0 = v501;
						v516.Parent = v514;
						v516.CFrame = v501.CFrame * v502;
						v517.Part1 = v516;
						local v518 = v0.Instance.new("Motor6D");
						v518.Parent = v516;
						v518.Part0 = v516;
						v518.Part1 = v515;
						local v519 = v0.Instance.new("Humanoid");
						v519.Parent = v514;
						local v520 = v0.Instance.new("Animator");
						v520.Parent = v519;
						local v521 = v514:Clone();
						v521.Name = "CameraRigAnimationPreload";
						v521:PivotTo(v0.CFrame.new(0, -100, 0));
						v521.Parent = l_VFX_0;
						v521.HumanoidRootPart.WeldConstraint:Destroy();
						v521.HumanoidRootPart.Anchored = true;
						local v522 = v0.Instance.new("Animation");
						v522.AnimationId = "rbxassetid://" .. v0.tostring(v500);
						local v523 = v521.Humanoid.Animator:LoadAnimation(v522);
						v522:Destroy();
						v523.Priority = v0.Enum.AnimationPriority.Action4;
						v523.Stopped:Connect(function()
							if v521 ~= nil and v521.Parent ~= nil then
								v521:Destroy();
							end;
						end);
						v523:Play(v505);
						local v524 = v0.Instance.new("Animation");
						v524.AnimationId = "rbxassetid://" .. v0.tostring(v500);
						local v525 = v520:LoadAnimation(v524);
						v524:Destroy();
						v525.Priority = v0.Enum.AnimationPriority.Action4;
						local v526 = nil;
						local v537 = VFXService.CreateBind(v26, "CutsceneCameraBind", function()
							l_RunService_0:UnbindFromRenderStep("CutsceneCamera" .. v513);
							if v514 ~= nil and v514.Parent ~= nil then
								v514:Destroy();
							end;
							if v504.Time > 0 then
								v526 = l_CurrentCamera_1.CFrame;
								local v527 = v0.os.clock();
								l_RunService_0:BindToRenderStep("CutsceneCameraSmoothOut" .. v527, Enum.RenderPriority.Camera.Value + 1, function()
									local l_CFrame_1 = l_CurrentCamera_1.CFrame;
									local v529 = (v0.os.clock() - v527) / v504.Time;
									l_CurrentCamera_1.CFrame = v526:Lerp(l_CFrame_1, l_TweenService_0:GetValue(v529, v504.EasingStyle, v504.EasingDirection));
								end);
								local v530 = nil;
								if l_CurrentCamera_1.FieldOfView ~= 70 then
									v530 = l_TweenService_0:Create(l_CurrentCamera_1, v0.TweenInfo.new(v504.Time, v504.EasingStyle, v504.EasingDirection), {
										FieldOfView = 70
									});
									v530:Play();
								end;
								do
									local l_v530_0 = v530;
									local v532 = VFXService.CreateBind(v26, "CutsceneSmoothOutBind", function()
										l_RunService_0:UnbindFromRenderStep("CutsceneCameraSmoothOut" .. v527);
										if l_v530_0 ~= nil then
											l_v530_0:Cancel();
										end;
									end);
									l_CurrentCamera_1.CameraType = l_Custom_0;
									v0.task.delay(v504.Time, function()
										if v532 ~= nil and v532.Parent ~= nil then
											v532:Destroy();
										end;
									end);
								end;
							else
								v526 = l_CurrentCamera_1.CFrame;
								l_CurrentCamera_1.CameraType = l_Custom_0;
								l_CurrentCamera_1.FieldOfView = 70;
							end;
							if v506 == true then
								v42 = false;
							end;
							if v507 == true then
								v41 = false;
								if v88.MuteAwakeningMusic == true then
									for _, v534 in v0.pairs(l_Characters_0:GetDescendants()) do
										if v534:IsA("Sound") and v534:GetAttribute("AwakeningTheme") == true then
											v534.Volume = 0;
										end;
									end;
									return;
								elseif v41 ~= true then
									for _, v536 in v0.pairs(l_Characters_0:GetDescendants()) do
										if v536:IsA("Sound") and v536:GetAttribute("AwakeningTheme") == true then
											v536.Volume = (v536:GetAttribute("DefaultVolume") or 0.5) * v88.VolumeMultiplier;
										end;
									end;
								end;
							end;
						end);
						if v506 == true then
							v42 = true;
						end;
						if v507 == true then
							v41 = true;
							for _, v539 in v0.pairs(l_Characters_0:GetDescendants()) do
								if v539:GetAttribute("AwakeningTheme") == true and v539:IsA("Sound") then
									v539.Volume = 0;
								end;
							end;
						end;
						v525:Play(v505);
						local v540 = 0;
						if v503.Time > 0 then
							local v541 = v0.Instance.new("Part");
							v541.Name = "Follow";
							v541.Transparency = 1;
							v541.CanCollide = false;
							v541.CanTouch = false;
							v541.CastShadow = false;
							v541.CanQuery = false;
							v541.EnableFluidForces = false;
							v541.Anchored = true;
							v541.Size = v0.Vector3.zero;
							v541.Massless = true;
							v541.Material = v0.Enum.Material.SmoothPlastic;
							v541.Parent = v514;
							v541.CFrame = l_CFrame_0;
							l_RunService_0:BindToRenderStep("CutsceneCamera" .. v513, Enum.RenderPriority.Camera.Value - 1, function(v542)
								v540 = v540 + v542;
								if v501 ~= nil and v501.Parent ~= nil and v501.Parent.Parent ~= nil and v537 ~= nil and v537.Parent ~= nil and v515 ~= nil and v515.Parent ~= nil and v541 ~= nil and v541.Parent ~= nil and l_FOV_0 ~= nil and l_FOV_0.Parent ~= nil then
									local l_CFrame_2 = v515.CFrame;
									local l_l_TweenService_0_Value_0 = l_TweenService_0:GetValue(v540 / v503.Time, v503.EasingStyle, v503.EasingDirection);
									v541.CFrame = l_CFrame_0:Lerp(l_CFrame_2, l_l_TweenService_0_Value_0);
									l_CurrentCamera_1.CFrame = v541.CFrame;
									local v545 = v0.tostring(v0.math.round(v540 * v499) - 1);
									if l_FOV_0:FindFirstChild(v545) then
										local l_Value_0 = l_FOV_0:FindFirstChild(v545).Value;
										local v547 = v0.math.min(l_Value_0, l_FieldOfView_0);
										local v548 = v0.math.max(l_Value_0, l_FieldOfView_0);
										l_CurrentCamera_1.FieldOfView = l_l_TweenService_0_Value_0 * (v547 - v548) + v548;
									end;
									if l_l_TweenService_0_Value_0 >= 1 then
										l_RunService_0:UnbindFromRenderStep("CutsceneCamera" .. v513);
										l_RunService_0:BindToRenderStep("CutsceneCamera" .. v513, Enum.RenderPriority.Camera.Value - 1, function(v549)
											v540 = v540 + v549;
											if v501 ~= nil and v501.Parent ~= nil and v501.Parent.Parent ~= nil and v537 ~= nil and v537.Parent ~= nil and v515 ~= nil and v515.Parent ~= nil and l_FOV_0 ~= nil and l_FOV_0.Parent ~= nil then
												l_CurrentCamera_1.CFrame = v515.CFrame;
												local v550 = v0.tostring(v0.math.round(v540 * v499) - 1);
												if l_FOV_0:FindFirstChild(v550) then
													l_CurrentCamera_1.FieldOfView = l_FOV_0:FindFirstChild(v550).Value;
													return;
												end;
											else
												VFXService.EndCutscene();
											end;
										end);
										return;
									end;
								else
									VFXService.EndCutscene();
								end;
							end);
						else
							l_RunService_0:BindToRenderStep("CutsceneCamera" .. v513, Enum.RenderPriority.Camera.Value - 1, function(v551)
								v540 = v540 + v551;
								if v501 ~= nil and v501.Parent ~= nil and v501.Parent.Parent ~= nil and v537 ~= nil and v537.Parent ~= nil and v515 ~= nil and v515.Parent ~= nil and l_FOV_0 ~= nil and l_FOV_0.Parent ~= nil then
									l_CurrentCamera_1.CFrame = v515.CFrame;
									local v552 = v0.tostring(v0.math.round(v540 * v499) - 1);
									if l_FOV_0:FindFirstChild(v552) then
										l_CurrentCamera_1.FieldOfView = l_FOV_0:FindFirstChild(v552).Value;
										return;
									end;
								else
									VFXService.EndCutscene();
								end;
							end);
						end;
						v525.Stopped:Connect(function()
							if v537 ~= nil and v537.Parent ~= nil then
								v537:Destroy();
							end;
						end);
						return v514, v525;
					end;
				end;
			end;
		end;
	end, 
	EndCutscene = function()
		VFXService.DestroyBind(v26, "CutsceneCameraBind", true);
	end, 
	GetTile = function(v553, v554)
		if typeof(v553) ~= "Vector3" then
			v0.warn("No Origin input provided.");
			return;
		else
			if typeof(v554) ~= "number" then
				v554 = 7;
			end;
			local v555 = workspace:Raycast(v553, v0.Vector3.new(0, -v0.math.abs(v554), 0), v74);
			if v555 and v555.Instance and v555.Instance:GetAttribute("Destroyed") ~= true then
				return v555.Instance;
			else
				return;
			end;
		end;
	end, 
	DestroyTile = function(v556, v557, v558, v559, v560, v561)
		if not (typeof(v556) == "Instance" and v556 ~= nil) or v556.Parent == nil then
			return;
		elseif v556:GetAttribute("Destroyed") == true then
			return;
		else
			if typeof(v557) ~= "table" then
				v557 = {
					20, 
					30
				};
			end;
			if typeof(v558) ~= "table" then
				v558 = {
					60, 
					70
				};
			end;
			if typeof(v561) ~= "boolean" then
				v561 = true;
			end;
			local v562 = v0.Random.new();
			if typeof(v559) ~= "table" then
				v559 = {
					4, 
					5
				};
			end;
			if typeof(v560) ~= "number" then
				v560 = v562:NextNumber(9, 13);
			end;
			v556:SetAttribute("Destroyed", true);
			if v561 == true then
				v104.PlaySoundAtCFrame(v556.CFrame, "DownslamConcrete");
			end;
			local v563 = v0.math.random(1, 2);
			local v564 = v556.Size.X / 2;
			local v565 = v556.Size.Z / 2;
			local v566 = v562:NextNumber(v559[1], v559[2]);
			local v567 = v562:NextNumber(v559[1], v559[2]);
			local v568 = v0.Instance.new("Folder");
			v568.Name = "FlyingRocks";
			local v569 = v556:Clone();
			v569:SetAttribute("Destroyed", nil);
			v569.Anchored = false;
			v569.CastShadow = true;
			v569.Color = VFXService.MakeDarker(v556.Color, 5, 5, 5);
			v569.CollisionGroup = "Only Floor";
			if v563 == 1 then
				v569.Size = v0.Vector3.new(v564, v556.Size.Y + 0.075, v569.Size.Z);
			elseif v563 == 2 then
				v569.Size = v0.Vector3.new(v569.Size.X, 0, v565);
			end;
			local v570 = v569:Clone();
			if v563 == 1 then
				v569.Position = v569.Position - v0.Vector3.new(v564 / 2, 0, 0);
				v570.Position = v570.Position + v0.Vector3.new(v564 / 2, 0, 0);
			elseif v563 == 2 then
				v569.Position = v569.Position - v0.Vector3.new(0, 0, v565 / 2);
				v570.Position = v570.Position + v0.Vector3.new(0, 0, v565 / 2);
			end;
			local v571 = v0.CFrame.new(v556.Position, v569.Position).LookVector * v562:NextNumber(v557[1], v557[2]) + v0.Vector3.new(0, v562:NextNumber(v558[1], v558[2]), 0);
			local v572 = v0.CFrame.new(v556.Position, v570.Position).LookVector * v562:NextNumber(v557[1], v557[2]) + v0.Vector3.new(0, v562:NextNumber(v558[1], v558[2]), 0);
			local v573 = v0.Vector3.new(v0.math.random(2, 3), v0.math.random(2, 3), v0.math.random(2, 3));
			local v574 = v0.Vector3.new(v0.math.random(2, 3), v0.math.random(2, 3), v0.math.random(2, 3));
			v556.Position = v556.Position - v0.Vector3.new(0, 10, 0);
			v569.Parent = v568;
			v570.Parent = v568;
			v568.Parent = l_FlyingRocksStorage_0;
			v569.AssemblyLinearVelocity = v571;
			v570.AssemblyLinearVelocity = v572;
			v569.AssemblyAngularVelocity = v573;
			v570.AssemblyAngularVelocity = v574;
			local v575 = l_TweenService_0:Create(v556, v0.TweenInfo.new(1.5, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
				Transparency = 0
			});
			local v576 = l_TweenService_0:Create(v569, v0.TweenInfo.new(1.5, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
				Transparency = 1
			});
			local v577 = l_TweenService_0:Create(v570, v0.TweenInfo.new(1.5, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
				Transparency = 1
			});
			v576.Completed:Connect(function()
				if v569 ~= nil and v569.Parent ~= nil then
					v569:Destroy();
					v569 = nil;
				end;
				if v568 ~= nil and v568.Parent ~= nil and (not (v570 ~= nil) or v570.Parent == nil) then
					v568:Destroy();
				end;
			end);
			v577.Completed:Connect(function()
				if v570 ~= nil and v570.Parent ~= nil then
					v570:Destroy();
					v570 = nil;
				end;
				if v568 ~= nil and v568.Parent ~= nil and (not (v569 ~= nil) or v569.Parent == nil) then
					v568:Destroy();
				end;
			end);
			v575.Completed:Connect(function()
				if v556 ~= nil and v556.Parent ~= nil then
					v556.CanCollide = true;
					v556:SetAttribute("Destroyed", nil);
				end;
			end);
			v0.task.delay(v566, function()
				if v569 ~= nil and v569.Parent ~= nil then
					v576:Play();
				end;
			end);
			v0.task.delay(v567, function()
				if v570 ~= nil and v570.Parent ~= nil then
					v577:Play();
				end;
			end);
			v0.task.delay(v560, function()
				if v556 ~= nil and v556.Parent ~= nil then
					v556.Name = "TEMPORARY NAME";
					v556.Transparency = 1;
					v556.CanCollide = false;
					local l_v556_0 = v556;
					l_v556_0.Position = l_v556_0.Position + v0.Vector3.new(0, 10, 0);
					v575:Play();
				end;
			end);
			return;
		end;
	end, 
	LoadMeshPartAnimation = function(v579, v580)
		if not (v579 ~= nil and typeof(v579) == "Instance") or v579.Parent == nil then
			v0.warn("No Mesh input provided.");
			return;
		elseif typeof(v580) ~= "table" then
			v0.warn("No AnimationInfo input provided.");
			return;
		else
			local v581 = {};
			if typeof(v580.Size) == "table" then
				local v582 = v580.Size.X or v579.Size.X;
				local v583 = v580.Size.Y or v579.Size.Y;
				local v584 = v580.Size.Z or v579.Size.Z;
				local v585 = v580.Size.Time or 0.5;
				local v586 = v580.Size.EasingStyle or v0.Enum.EasingStyle.Sine;
				local v587 = v580.Size.EasingDirection or v0.Enum.EasingDirection.Out;
				local v588 = v0.TweenInfo.new(v585, v586, v587);
				local v589 = l_TweenService_0:Create(v579, v588, {
					Size = v0.Vector3.new(v582, v583, v584)
				});
				v0.table.insert(v581, v589);
			end;
			if typeof(v580.Transparency) == "table" then
				local v590 = v580.Transparency.Value or 1;
				local v591 = v580.Transparency.Time or 1;
				local v592 = v580.Transparency.EasingStyle or v0.Enum.EasingStyle.Sine;
				local v593 = v580.Transparency.EasingDirection or v0.Enum.EasingDirection.Out;
				local v594 = v0.TweenInfo.new(v591, v592, v593);
				local v595 = l_TweenService_0:Create(v579, v594, {
					Transparency = v590
				});
				v0.table.insert(v581, v595);
			end;
			local l_CFrame_3 = v579.CFrame;
			local v597 = nil;
			local v598 = nil;
			if typeof(v580.LinearDisplacement) == "table" then
				local v599 = v580.LinearDisplacement.X or 0;
				local v600 = v580.LinearDisplacement.Y or 0;
				local v601 = v580.LinearDisplacement.Z or 0;
				local v602 = v580.LinearDisplacement.Time or 1;
				local v603 = v580.LinearDisplacement.EasingStyle or v0.Enum.EasingStyle.Sine;
				local v604 = v580.LinearDisplacement.EasingDirection or v0.Enum.EasingDirection.Out;
				local v605 = v0.TweenInfo.new(v602, v603, v604);
				v598 = l_CFrame_3 + l_CFrame_3.LookVector * v599 + l_CFrame_3.UpVector * v600 + l_CFrame_3.RightVector * v601;
				v597 = l_TweenService_0:Create(v579, v605, {
					CFrame = v598
				});
				v0.table.insert(v581, v597);
			end;
			if typeof(v580.AngularDisplacement) == "table" then
				local v606 = v580.AngularDisplacement.X or 0;
				local v607 = v580.AngularDisplacement.Y or 0;
				local v608 = v580.AngularDisplacement.Z or 0;
				local v609 = v580.AngularDisplacement.Time or 1;
				local v610 = v580.AngularDisplacement.EasingStyle or v0.Enum.EasingStyle.Sine;
				local v611 = v580.AngularDisplacement.EasingDirection or v0.Enum.EasingDirection.Out;
				local v612 = v0.TweenInfo.new(v609, v610, v611);
				local v613 = nil;
				if v598 ~= nil then
					v613 = v598;
					v0.table.remove(v581, v0.table.find(v581, v597));
					v597 = nil;
				else
					v613 = v579.CFrame;
				end;
				local v614 = l_TweenService_0:Create(v579, v612, {
					CFrame = v613 * v0.CFrame.Angles(v606, v607, v608)
				});
				v0.table.insert(v581, v614);
			end;
			return v581;
		end;
	end, 
	ScreenFlash = function(v615, v616, v617, v618, v619, v620)
		if typeof(v615) ~= "Color3" then
			v615 = v0.Color3.new(255, 255, 255);
		end;
		if typeof(v616) ~= "number" then
			v616 = 0;
		end;
		if typeof(v617) ~= "number" then
			v617 = 1;
		end;
		if typeof(v618) ~= "number" then
			v618 = 0.35;
		end;
		if typeof(v619) ~= "EnumItem" then
			v619 = v0.Enum.EasingStyle.Exponential;
		end;
		if typeof(v620) ~= "EnumItem" then
			v620 = v0.Enum.EasingDirection.Out;
		end;
		local v621 = v0.Instance.new("ScreenGui");
		v621.IgnoreGuiInset = true;
		v621.Name = "ScreenFlashEffect";
		local v622 = v0.Instance.new("Frame");
		v622.Size = v0.UDim2.new(1.5, 0, 1.5, 0);
		v622.BackgroundColor3 = v615;
		v622.BackgroundTransparency = v616;
		v622.Name = "Flash";
		v622.Parent = v621;
		local v623 = l_TweenService_0:Create(v622, v0.TweenInfo.new(v618, v619, v620), {
			BackgroundTransparency = v617
		});
		v623.Completed:Once(function()
			if v621 ~= nil and v621.Parent ~= nil then
				v621:Destroy();
			end;
		end);
		v621.Parent = l_PlayerGui_0;
		v623:Play();
	end, 
	EndScreenFlashes = function()
		for _, v625 in v0.pairs(l_PlayerGui_0:GetChildren()) do
			if v625:IsA("ScreenGUI") and v625.Name == "ScreenFlashEffect" then
				v625:Destroy();
			end;
		end;
	end, 
	CinematicFrame = function(v626, v627, v628)
		if typeof(v626) ~= "table" then
			v626 = {
				Visible = true, 
				ScreenPercentage = 0.09, 
				SmoothIn = {
					Time = 0.3, 
					EasingStyle = v0.Enum.EasingStyle.Sine, 
					EasingDirection = v0.Enum.EasingDirection.Out
				}, 
				SmoothOut = {
					Time = 0.3, 
					EasingStyle = v0.Enum.EasingStyle.Sine, 
					EasingDirection = v0.Enum.EasingDirection.Out
				}
			};
		end;
		if typeof(v627) ~= "table" then
			v627 = {
				Visible = true, 
				InitialTransparency = 1, 
				TargetTransparency = 0, 
				SmoothIn = {
					Time = 0.3, 
					EasingStyle = v0.Enum.EasingStyle.Sine, 
					EasingDirection = v0.Enum.EasingDirection.Out
				}, 
				SmoothOut = {
					Time = 0.3, 
					EasingStyle = v0.Enum.EasingStyle.Sine, 
					EasingDirection = v0.Enum.EasingDirection.Out
				}
			};
		end;
		if typeof(v628) ~= "number" then
			v628 = 3;
		end;
		local v629 = v0.Instance.new("ScreenGui");
		v629.IgnoreGuiInset = true;
		v629.ResetOnSpawn = false;
		v629.Name = "CinematicFrameEffect";
		local v630 = {};
		local v631 = {};
		local v632 = {};
		local v633 = 0;
		local v634 = 0;
		if v626.Visible == true then
			local v635 = v0.Instance.new("Frame");
			v635.BorderSizePixel = 0;
			v635.BackgroundColor3 = v0.Color3.fromRGB();
			v635.Size = v0.UDim2.new(3, 0, v626.ScreenPercentage, 0);
			v635.Position = v0.UDim2.new(0, 0, -v626.ScreenPercentage);
			local v636 = v0.Instance.new("Frame");
			v636.BorderSizePixel = 0;
			v636.BackgroundColor3 = v0.Color3.fromRGB();
			v636.Size = v0.UDim2.new(3, 0, v626.ScreenPercentage, 0);
			v636.Position = v0.UDim2.new(0, 0, 1, 0);
			local v637 = v0.UDim2.new();
			local v638 = v0.UDim2.new(0, 0, 1 - v626.ScreenPercentage, 0);
			local l_SmoothIn_0 = v626.SmoothIn;
			if typeof(l_SmoothIn_0) ~= "table" then
				l_SmoothIn_0 = {
					Time = 0.3, 
					EasingStyle = v0.Enum.EasingStyle.Sine, 
					EasingDirection = v0.Enum.EasingDirection.Out
				};
			end;
			local l_Time_0 = l_SmoothIn_0.Time;
			local l_EasingStyle_0 = l_SmoothIn_0.EasingStyle;
			local l_EasingDirection_0 = l_SmoothIn_0.EasingDirection;
			if typeof(l_Time_0) ~= "number" then
				l_Time_0 = 0.3;
			end;
			if typeof(l_EasingStyle_0) ~= "EnumItem" then
				l_EasingStyle_0 = v0.Enum.EasingStyle.Sine;
			end;
			if typeof(l_EasingDirection_0) ~= "EnumItem" then
				l_EasingDirection_0 = v0.Enum.EasingDirection.Out;
			end;
			local l_SmoothIn_1 = v626.SmoothIn;
			if typeof(l_SmoothIn_1) ~= "table" then
				l_SmoothIn_1 = {
					Time = 0.3, 
					EasingStyle = v0.Enum.EasingStyle.Sine, 
					EasingDirection = v0.Enum.EasingDirection.Out
				};
			end;
			local l_Time_1 = l_SmoothIn_1.Time;
			local l_EasingStyle_1 = l_SmoothIn_1.EasingStyle;
			local l_EasingDirection_1 = l_SmoothIn_1.EasingDirection;
			if typeof(l_Time_1) ~= "number" then
				l_Time_1 = 0.3;
			end;
			if typeof(l_EasingStyle_1) ~= "EnumItem" then
				l_EasingStyle_1 = v0.Enum.EasingStyle.Sine;
			end;
			if typeof(l_EasingDirection_1) ~= "EnumItem" then
				l_EasingDirection_1 = v0.Enum.EasingDirection.Out;
			end;
			local v647 = v0.TweenInfo.new(l_Time_0, l_EasingStyle_0, l_EasingDirection_0);
			local v648 = v0.TweenInfo.new(l_Time_1, l_EasingStyle_1, l_EasingDirection_1);
			local v649 = l_TweenService_0:Create(v635, v647, {
				Position = v637
			});
			v0.table.insert(v630, v649);
			local v650 = l_TweenService_0:Create(v636, v647, {
				Position = v638
			});
			v0.table.insert(v630, v650);
			local v651 = l_TweenService_0:Create(v635, v648, {
				Position = v635.Position
			});
			v0.table.insert(v631, v651);
			local v652 = l_TweenService_0:Create(v636, v648, {
				Position = v636.Position
			});
			v0.table.insert(v631, v652);
			v635.Parent = v629;
			v636.Parent = v629;
			v649:Play();
			v650:Play();
			local v653 = nil;
			local l_v635_0 = v635 --[[ copy: 9 -> 29 ]];
			local l_v636_0 = v636 --[[ copy: 10 -> 30 ]];
			v653 = v0.task.delay(v628, function()
				if l_v635_0 ~= nil and l_v635_0.Parent ~= nil and v651 ~= nil then
					v651:Play();
				end;
				if l_v636_0 ~= nil and l_v636_0.Parent ~= nil and v652 ~= nil then
					v652:Play();
				end;
			end);
			v0.table.insert(v632, v653);
			v633 = l_Time_1;
		end;
		if v627.Visible == true then
			local v656 = v0.Instance.new("ImageLabel");
			v656.BackgroundTransparency = 1;
			v656.Image = "rbxassetid://4576475446";
			v656.Size = v0.UDim2.new(1, 0, 1, 0);
			v656.Position = v0.UDim2.new();
			local l_SmoothIn_2 = v627.SmoothIn;
			if typeof(l_SmoothIn_2) ~= "table" then
				l_SmoothIn_2 = {
					Time = 0.3, 
					EasingStyle = v0.Enum.EasingStyle.Sine, 
					EasingDirection = v0.Enum.EasingDirection.Out
				};
			end;
			local l_Time_2 = l_SmoothIn_2.Time;
			local l_EasingStyle_2 = l_SmoothIn_2.EasingStyle;
			local l_EasingDirection_2 = l_SmoothIn_2.EasingDirection;
			if typeof(l_Time_2) ~= "number" then
				l_Time_2 = 0.3;
			end;
			if typeof(l_EasingStyle_2) ~= "EnumItem" then
				l_EasingStyle_2 = v0.Enum.EasingStyle.Sine;
			end;
			if typeof(l_EasingDirection_2) ~= "EnumItem" then
				l_EasingDirection_2 = v0.Enum.EasingDirection.Out;
			end;
			local l_SmoothIn_3 = v627.SmoothIn;
			if typeof(l_SmoothIn_3) ~= "table" then
				l_SmoothIn_3 = {
					Time = 0.3, 
					EasingStyle = v0.Enum.EasingStyle.Sine, 
					EasingDirection = v0.Enum.EasingDirection.Out
				};
			end;
			local l_Time_3 = l_SmoothIn_3.Time;
			local l_EasingStyle_3 = l_SmoothIn_3.EasingStyle;
			local l_EasingDirection_3 = l_SmoothIn_3.EasingDirection;
			if typeof(l_Time_3) ~= "number" then
				l_Time_3 = 0.3;
			end;
			if typeof(l_EasingStyle_3) ~= "EnumItem" then
				l_EasingStyle_3 = v0.Enum.EasingStyle.Sine;
			end;
			if typeof(l_EasingDirection_3) ~= "EnumItem" then
				l_EasingDirection_3 = v0.Enum.EasingDirection.Out;
			end;
			local v665 = v0.TweenInfo.new(l_Time_2, l_EasingStyle_2, l_EasingDirection_2);
			local v666 = v0.TweenInfo.new(l_Time_3, l_EasingStyle_3, l_EasingDirection_3);
			local l_InitialTransparency_0 = v627.InitialTransparency;
			local l_TargetTransparency_0 = v627.TargetTransparency;
			if typeof(l_InitialTransparency_0) ~= "number" then
				l_InitialTransparency_0 = 1;
			end;
			if typeof(l_TargetTransparency_0) ~= "number" then
				l_TargetTransparency_0 = 0;
			end;
			v656.ImageTransparency = l_InitialTransparency_0;
			local v669 = l_TweenService_0:Create(v656, v665, {
				ImageTransparency = l_TargetTransparency_0
			});
			v0.table.insert(v630, v669);
			local v670 = l_TweenService_0:Create(v656, v666, {
				ImageTransparency = 1
			});
			v0.table.insert(v631, v670);
			v656.Parent = v629;
			v669:Play();
			local v671 = nil;
			local l_v656_0 = v656 --[[ copy: 9 -> 28 ]];
			v671 = v0.task.delay(v628, function()
				if l_v656_0 ~= nil and l_v656_0.Parent ~= nil and v670 ~= nil then
					v670:Play();
				end;
			end);
			v0.table.insert(v632, v671);
			v634 = l_Time_3;
		end;
		v0.task.delay(v628 + v0.math.max(v633, v634), function()
			if v629 ~= nil and v629.Parent ~= nil then
				v629:Destroy();
			end;
		end);
		v0.table.insert(v632, nil);
		local v673 = false;
		v629.ChildAdded:Connect(function(v674)
			if v673 == true then
				return;
			else
				if v674.Name == "EndFrame" then
					v673 = true;
					for _, v676 in v0.pairs(v630) do
						if v676 ~= nil then
							v676:Cancel();
						end;
					end;
					for _, v678 in v0.pairs(v632) do
						v0.pcall(function()
							v0.task.cancel(v678);
						end);
					end;
					for _, v680 in v0.pairs(v631) do
						if v680 ~= nil and v680.PlaybackState == v0.Enum.PlaybackState.Begin then
							v680:Play();
						end;
					end;
					v0.task.delay(v0.math.max(v633, v634), function()
						if v629 ~= nil and v629.Parent ~= nil then
							v629:Destroy();
						end;
					end);
				end;
				return;
			end;
		end);
		v629.Parent = l_PlayerGui_0;
		return v629;
	end, 
	EndCinematicFrame = function(v681)
		if v681 ~= nil and typeof(v681) == "Instance" and v681.Parent ~= nil and v681:IsA("ScreenGui") then
			local v682 = v0.Instance.new("Configuration");
			v682.Name = "EndFrame";
			v682.Parent = v681;
			return;
		else
			for _, v684 in v0.pairs(l_PlayerGui_0:GetChildren()) do
				if v684:IsA("ScreenGui") and v684.Name == "CinematicFrameEffect" then
					local v685 = v0.Instance.new("Configuration");
					v685.Name = "EndFrame";
					v685.Parent = v684;
				end;
			end;
			return;
		end;
	end, 
	PreloadImages = function(v686, v687)
		if typeof(v686) ~= "table" then
			v0.warn("No ImageList input provided.");
			return;
		else
			if typeof(v687) ~= "number" then
				v687 = 3;
			end;
			local v688 = v0.Instance.new("ScreenGui");
			v688.IgnoreGuiInset = true;
			v688.ResetOnSpawn = false;
			v688.Name = "ImagePreloader";
			for _, v690 in v0.pairs(v686) do
				if typeof(v690) == "string" then
					local v691 = v0.Instance.new("ImageLabel");
					if not (typeof(v690) ~= "number") or typeof(v0.tonumber(v690)) == "number" then
						v691.Image = "rbxassetid://" .. v690;
					elseif typeof(v690) == "string" then
						v691.Image = v690;
					end;
					v691.Size = v0.UDim2.new(1.0E-5, 0, 1.0E-5, 0);
					v691.Parent = v688;
				end;
			end;
			v0.task.delay(v687, function()
				if v688 ~= nil and v688.Parent ~= nil then
					v688:Destroy();
				end;
			end);
			v688.Parent = l_PlayerGui_0;
			return;
		end;
	end, 
	ImpactFrameSequence = function(v692, v693, v694)
		if typeof(v692) ~= "table" then
			return;
		else
			if typeof(v693) ~= "number" then
				v693 = 0.041666666666666664;
			end;
			if typeof(v694) ~= "boolean" then
				v694 = true;
			end;
			local v695 = v0.Instance.new("ScreenGui");
			v695.Name = "ImpactFrameSequence";
			v695.IgnoreGuiInset = true;
			v695.ResetOnSpawn = false;
			v695.Parent = l_PlayerGui_0;
			local v696 = 0;
			local v697 = 1;
			local v698 = #v692;
			local v699 = "ImpactFrameSequenceRender" .. v0.tostring(v0.os.clock());
			l_RunService_0:BindToRenderStep(v699, Enum.RenderPriority.Camera.Value - 1, function(v700)
				if not (v695 ~= nil) or v695.Parent == nil then
					l_RunService_0:UnbindFromRenderStep(v699);
					return;
				else
					v696 = v696 + v700;
					if not (v697 ~= 1) or v693 <= v696 then
						local v701 = v0.Instance.new("ImageLabel");
						v701.BackgroundTransparency = 1;
						local v702 = v692[v697];
						if not (typeof(v702) ~= "number") or typeof(v0.tonumber(v702)) == "number" then
							v701.Image = "rbxassetid://" .. v702;
						elseif typeof(v702) == "string" then
							v701.Image = v702;
						end;
						v701.Name = v0.tostring(v697);
						v701.Size = v0.UDim2.new(1, 0, 1, 0);
						v701.ZIndex = v697;
						v701.Parent = v695;
						v696 = 0;
						if v697 == v698 then
							v0.task.delay(v693, function()
								if v694 == true and v695 ~= nil and v695.Parent ~= nil then
									v695:Destroy();
								end;
							end);
							l_RunService_0:UnbindFromRenderStep(v699);
							return;
						else
							v697 = v697 + 1;
						end;
					end;
					return;
				end;
			end);
			return v695;
		end;
	end, 
	EndImpactFrameSequences = function()
		for _, v704 in v0.pairs(l_PlayerGui_0:GetChildren()) do
			if v704.Name == "ImpactFrameSequence" then
				v704:Destroy();
			end;
		end;
	end, 
	MeshFlipbookSequence = function(v705, v706, v707)
		if typeof(v705) ~= "table" then
			v0.warn("No Sequence input provided.");
			return;
		else
			if typeof(v706) ~= "number" then
				v706 = 0.016666666666666666;
			end;
			if typeof(v707) ~= "function" then
				v0.warn("No Callback input provided.");
				return;
			else
				local v708 = 1;
				v707(v708);
				local v709 = nil;
				local v710 = false;
				local v711 = 0;
				v709 = l_RenderStepped_0:Connect(function(v712)
					if v710 == true then
						if v709 ~= nil then
							v709:Disconnect();
						end;
						v709 = nil;
						return;
					else
						v711 = v711 + v712;
						if v706 <= v711 then
							v708 = v708 + 1;
							v711 = 0;
							v707(v708);
						end;
						if v708 >= #v705 then
							v710 = true;
							if v709 ~= nil then
								v709:Disconnect();
							end;
							v709 = nil;
							return;
						else
							return;
						end;
					end;
				end);
				return;
			end;
		end;
	end, 
	TweenBeamTransparency = function(v713, v714, v715, v716, v717)
		if not (typeof(v713) == "Instance" and v713 ~= nil and v713.Parent ~= nil) or not v713:IsA("Beam") then
			v0.warn("No Beam input provided.");
			return;
		else
			if typeof(v714) ~= "number" then
				v714 = 0.63;
			end;
			if typeof(v715) ~= "EnumItem" then
				v715 = v0.Enum.EasingStyle.Sine;
			end;
			if typeof(v716) ~= "EnumItem" then
				v716 = v0.Enum.EasingDirection.Out;
			end;
			if typeof(v717) ~= "number" then
				v717 = 1;
			end;
			v717 = v0.NumberSequence.new(v717, 1);
			local v718 = l_BoatTween_0:Create(v713, {
				Time = v714, 
				EasingStyle = v715.Name, 
				EasingDirection = v716.Name, 
				Reverses = false, 
				DelayTime = 0, 
				RepeatCount = 0, 
				StepType = "Heartbeat", 
				Goal = {
					Transparency = v717
				}
			});
			v718:Play();
			return v718;
		end;
	end
};

--local Repliction = {
--		if l_Request_1 == "MistOfHellAxe" then
--			local l_On_0 = v724.On;
--			if not (l_On_0 ~= nil) or l_On_0.Parent == nil then
--				return;
--			else
--				local v727 = l_Assets_0.Parts.Kratos.MistOfHellAxe:Clone();
--				v727:SetAttribute("MistOfHellAxe", true);
--				local v728 = v0.Instance.new("Motor6D");
--				v728.C0 = v0.CFrame.new(0, -0.901300669, -0.0499964803, -1, 0, 0, 0, 1.62920657E-7, -1, 0, -1, -1.62920657E-7);
--				v728.C1 = v0.CFrame.new(0, -0.699999928, -0.100000024, 1, 0, 0, 0, 1, 0, 0, 0, 1);
--				v728.Name = "Axe_high";
--				v728.Part0 = l_On_0["Right Arm"];
--				v728.Parent = l_On_0["Right Arm"];
--				v727.Parent = l_On_0;
--				v728.Part1 = v727.Axe_high;
--				local l_v727_0 = v727 --[[ copy: 3 -> 534 ]];
--				VFXService.CreateBind(l_On_0, "MistOfHellAxeJoint", function()
--					if l_v727_0 ~= nil and l_v727_0.Parent ~= nil then
--						l_v727_0:SetAttribute("IsDestroyed", true);
--						l_v727_0.Axe_high.Transparency = 1;
--						for _, v731 in v0.pairs(l_v727_0:GetDescendants()) do
--							if v731:IsA("ParticleEmitter") or v731:IsA("Trail") then
--								v731.Enabled = false;
--							end;
--						end;
--						v0.task.delay(3, function()
--							if l_v727_0 ~= nil and l_v727_0.Parent ~= nil then
--								l_v727_0:Destroy();
--							end;
--						end);
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndMistOfHellAxe" then
--			local l_On_1 = v724.On;
--			if not (l_On_1 ~= nil) or l_On_1.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_1, "MistOfHellAxeJoint");
--			end;
--		end;
--		if l_Request_1 == "EndMistOfHellAxeAura" then
--			local l_On_2 = v724.On;
--			if not (l_On_2 ~= nil) or l_On_2.Parent == nil then
--				return;
--			else
--				local v734 = nil;
--				for _, v736 in v0.pairs(l_On_2:GetChildren()) do
--					if v736:IsA("Model") and v736:GetAttribute("MistOfHellAxe") == true and v736:GetAttribute("IsDestroyed") ~= true then
--						v734 = v736;
--						break;
--					end;
--				end;
--				if v734 ~= nil and v734.Parent ~= nil then
--					for _, v738 in v0.pairs(v734:GetDescendants()) do
--						if v738:IsA("ParticleEmitter") or v738:IsA("Trail") then
--							v738.Enabled = false;
--						end;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "MistOfHellLines" then
--			local l_On_3 = v724.On;
--			if not (l_On_3 ~= nil) or l_On_3.Parent == nil then
--				return;
--			else
--				local v740 = nil;
--				for _, v742 in v0.pairs(l_On_3:GetChildren()) do
--					if v742:IsA("Model") and v742:GetAttribute("MistOfHellAxe") == true and v742:GetAttribute("IsDestroyed") ~= true then
--						v740 = v742;
--						break;
--					end;
--				end;
--				if v740 ~= nil and v740.Parent ~= nil then
--					for _, v744 in v0.pairs(v740:GetDescendants()) do
--						if v744:IsA("Trail") then
--							v744.Enabled = false;
--						end;
--					end;
--				end;
--				local v745 = l_Assets_0.Particles.Kratos.MistOfHell.Lines:Clone();
--				local v746 = v0.Instance.new("WeldConstraint");
--				v746.Parent = v745;
--				v746.Part0 = l_On_3.HumanoidRootPart;
--				v745.Parent = l_VFX_0;
--				v745.CFrame = l_On_3.HumanoidRootPart.CFrame * v0.CFrame.new(-0.295780957, -1.30590951, -0.132972956, 1, 0, 0, 0, 1, 0, 0, 0, 1);
--				v746.Part1 = v745;
--				local l_v745_0 = v745 --[[ copy: 4 -> 533 ]];
--				VFXService.CreateBind(l_On_3, "MistOfHellLinesEffect", function()
--					if l_v745_0 ~= nil and l_v745_0.Parent ~= nil then
--						for _, v749 in v0.pairs(l_v745_0:GetDescendants()) do
--							if v749:IsA("ParticleEmitter") then
--								v749.Enabled = false;
--							end;
--						end;
--						v0.task.delay(3, function()
--							if l_v745_0 ~= nil and l_v745_0.Parent ~= nil then
--								l_v745_0:Destroy();
--							end;
--						end);
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndMistOfHellLines" then
--			local l_On_4 = v724.On;
--			if not (l_On_4 ~= nil) or l_On_4.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_4, "MistOfHellLinesEffect");
--			end;
--		end;
--		if l_Request_1 == "MistOfHellAxeEmit" then
--			local l_On_5 = v724.On;
--			if not (l_On_5 ~= nil) or l_On_5.Parent == nil then
--				return;
--			else
--				local v752 = nil;
--				for _, v754 in v0.pairs(l_On_5:GetChildren()) do
--					if v754:IsA("Model") and v754:GetAttribute("MistOfHellAxe") == true and v754:GetAttribute("IsDestroyed") ~= true then
--						v752 = v754;
--						break;
--					end;
--				end;
--				if v752 ~= nil and v752.Parent ~= nil then
--					local l_AuraEmit_0 = v752.Axe_high.AuraEmit;
--					VFXService.EmitParticlesInInstance(l_AuraEmit_0);
--					for _, v757 in v0.pairs(v752:GetDescendants()) do
--						if not v757:IsDescendantOf(l_AuraEmit_0) and (v757:IsA("ParticleEmitter") or v757:IsA("Trail")) then
--							v757.Enabled = true;
--						end;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "HakariEmoteAura" then
--			local l_On_6 = v724.On;
--			if not (l_On_6 ~= nil) or l_On_6.Parent == nil then
--				return;
--			else
--				local v759 = l_Assets_0.Parts.Emotes.Hakari.Extra:Clone();
--				local v760 = v0.Instance.new("WeldConstraint");
--				v760.Parent = v759;
--				v760.Part0 = l_On_6.HumanoidRootPart;
--				v759.Parent = l_VFX_0;
--				v759.CFrame = l_On_6.HumanoidRootPart.CFrame + l_On_6.HumanoidRootPart.CFrame.UpVector;
--				v760.Part1 = v759;
--				local v761 = {};
--				local v762 = {};
--				for _, v764 in v0.pairs(l_Assets_0.Parts.Emotes.Hakari.Dummy:GetDescendants()) do
--					if v764:IsA("ParticleEmitter") and v764.Parent:IsA("BasePart") then
--						local l_Name_0 = v764.Parent.Name;
--						if l_On_6:FindFirstChild(l_Name_0) then
--							local v766 = v764:Clone();
--							v0.table.insert(v761, v766);
--							v766.Parent = l_On_6[l_Name_0];
--						end;
--					end;
--					if v764:IsA("Attachment") then
--						local v767 = v764:Clone();
--						v0.table.insert(v762, v767);
--						v767.Parent = l_On_6.HumanoidRootPart;
--						if v767:FindFirstChildOfClass("PointLight") then
--							l_TweenService_0:Create(v767:FindFirstChildOfClass("PointLight"), v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--								Brightness = 1.5
--							}):Play();
--						end;
--					end;
--				end;
--				local l_v759_0 = v759 --[[ copy: 3 -> 530 ]];
--				local l_v760_0 = v760 --[[ copy: 4 -> 531 ]];
--				local l_l_On_6_0 = l_On_6 --[[ copy: 2 -> 532 ]];
--				do
--					local l_v761_0, l_v762_0 = v761, v762;
--					VFXService.CreateBind(l_On_6, "HakariEmoteAuraEffect", function()
--						if l_v759_0 ~= nil and l_v759_0.Parent ~= nil and l_v759_0:IsDescendantOf(l_VFX_0) then
--							if l_v760_0 ~= nil and l_v760_0.Parent ~= nil then
--								l_v760_0:Destroy();
--							end;
--							l_v759_0.Anchored = true;
--							for _, v774 in v0.pairs(l_v759_0:GetDescendants()) do
--								if v774:IsA("ParticleEmitter") then
--									v774.Enabled = false;
--								end;
--							end;
--							v0.task.delay(3, function()
--								if l_v759_0 ~= nil and l_v759_0.Parent ~= nil and l_v759_0:IsDescendantOf(l_VFX_0) then
--									l_v759_0:Destroy();
--								end;
--							end);
--						end;
--						for _, v776 in v0.pairs(l_v761_0) do
--							if v776 ~= nil and v776.Parent ~= nil and l_l_On_6_0 ~= nil and l_l_On_6_0.Parent ~= nil and v776:IsDescendantOf(l_l_On_6_0) then
--								v776.Enabled = false;
--								v0.task.delay(1.5, function()
--									if v776 ~= nil and v776.Parent ~= nil then
--										v776:Destroy();
--									end;
--								end);
--							end;
--						end;
--						for _, v778 in v0.pairs(l_v762_0) do
--							if v778 ~= nil and v778.Parent ~= nil and l_l_On_6_0 ~= nil and l_l_On_6_0.Parent ~= nil and v778:IsDescendantOf(l_l_On_6_0) then
--								for _, v780 in v0.pairs(v778:GetDescendants()) do
--									if v780:IsA("ParticleEmitter") then
--										v780.Enabled = false;
--									elseif v780:IsA("Beam") then
--										VFXService.TweenBeamTransparency(v780, 0.5, v0.Enum.EasingStyle.Quad, v0.Enum.EasingDirection.Out, 1);
--									elseif v780:IsA("PointLight") then
--										l_TweenService_0:Create(v780, v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--											Brightness = 0
--										}):Play();
--									end;
--								end;
--								v0.task.delay(3, function()
--									if v778 ~= nil and v778.Parent ~= nil and l_l_On_6_0 ~= nil and l_l_On_6_0.Parent ~= nil and v778:IsDescendantOf(l_l_On_6_0) then
--										v778:Destroy();
--									end;
--								end);
--							end;
--						end;
--						l_v761_0 = nil;
--						l_v762_0 = nil;
--					end);
--				end;
--			end;
--		end;
--		if l_Request_1 == "EndHakariEmoteAura" then
--			local l_On_7 = v724.On;
--			if not (l_On_7 ~= nil) or l_On_7.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_7, "HakariEmoteAuraEffect");
--			end;
--		end;
--		if l_Request_1 == "VirguleUpThrow2" then
--			local l_On_8 = v724.On;
--			if not (l_On_8 ~= nil) or l_On_8.Parent == nil then
--				return;
--			else
--				local v783 = l_Assets_0.Particles.Jun.VirguleCascadeAir.Throw:Clone();
--				v783.Parent = l_VFX_0;
--				v783.CFrame = l_On_8.HumanoidRootPart.CFrame * v0.CFrame.new(-0.103864312, 26.3858414, -3.27058887, -0.996245623, -0.086509794, 0.0032267347, 0.0117835477, -0.172436953, -0.984950066, 0.0857642367, -0.981214285, 0.172808975) * v0.CFrame.Angles(v0.math.pi / 2 + v0.math.pi / 14, 0, 0);
--				VFXService.EmitParticlesInInstance(v783);
--				VFXService.DestroyParticleContainer(v783, 3);
--			end;
--		end;
--		if l_Request_1 == "VirguleUpThrow1" then
--			local l_On_9 = v724.On;
--			if not (l_On_9 ~= nil) or l_On_9.Parent == nil then
--				return;
--			else
--				local v785 = l_Assets_0.Particles.Jun.VirguleCascadeAir.Throw:Clone();
--				v785.Parent = l_VFX_0;
--				v785.CFrame = (l_On_9.HumanoidRootPart.CFrame - l_On_9.HumanoidRootPart.CFrame.LookVector * 5.467) * v0.CFrame.Angles(-v0.math.pi / 21, 0, 0);
--				VFXService.EmitParticlesInInstance(v785);
--				VFXService.DestroyParticleContainer(v785, 3);
--			end;
--		end;
--		if l_Request_1 == "VirguleUpThrow2" then
--			local l_On_10 = v724.On;
--			if not (l_On_10 ~= nil) or l_On_10.Parent == nil then
--				return;
--			end;
--		end;
--		if l_Request_1 == "VirguleUpKick" then
--			local l_On_11 = v724.On;
--			if not (l_On_11 ~= nil) or l_On_11.Parent == nil then
--				return;
--			else
--				local v788 = l_Assets_0.Particles.Jun.VirguleCascadeAir.Kick:Clone();
--				v788.Parent = l_VFX_0;
--				v788.CFrame = l_On_11.HumanoidRootPart.CFrame * v0.CFrame.new(-0.103864312, 26.3858414, -3.27058887, -0.996245623, -0.086509794, 0.0032267347, 0.0117835477, -0.172436953, -0.984950066, 0.0857642367, -0.981214285, 0.172808975);
--				VFXService.EmitParticlesInInstance(v788);
--				VFXService.DestroyParticleContainer(v788, 3);
--				if not (l_On_11 ~= v26) or (l_On_11.HumanoidRootPart.Position - l_HumanoidRootPart_0.Position).Magnitude <= 15 then
--					VFXService.ShakeCamera(0, 0.4, 22, 0.2, 0.22, 0.2);
--				end;
--			end;
--		end;
--		if l_Request_1 == "VirguleUpKickContact" then
--			local l_On_12 = v724.On;
--			if not (l_On_12 ~= nil) or l_On_12.Parent == nil then
--				return;
--			else
--				local v790 = l_Assets_0.Particles.Jun.VirguleCascadeAir.KickContact:Clone();
--				v790.Parent = l_VFX_0;
--				v790.CFrame = l_On_12.HumanoidRootPart.CFrame * v0.CFrame.new(-0.103864312, 26.3858414, -3.27058887, -0.996245623, -0.086509794, 0.0032267347, 0.0117835477, -0.172436953, -0.984950066, 0.0857642367, -0.981214285, 0.172808975);
--				VFXService.EmitParticlesInInstance(v790);
--				VFXService.DestroyParticleContainer(v790, 3);
--				if not (l_On_12 ~= v26) or (l_On_12.HumanoidRootPart.Position - l_HumanoidRootPart_0.Position).Magnitude <= 15 then
--					VFXService.ShakeCamera(0, 0.4, 22, 0.2, 0.22, 0.2);
--				end;
--			end;
--		end;
--		if l_Request_1 == "VirguleUpTeleport1" then
--			local l_On_13 = v724.On;
--			if not (l_On_13 ~= nil) or l_On_13.Parent == nil then
--				return;
--			else
--				local v792 = l_Assets_0.Particles.Jun.VirguleCascadeAir.Teleport:Clone();
--				v792.Parent = l_VFX_0;
--				v792.Position = (l_On_13.HumanoidRootPart.CFrame * v0.CFrame.new(-0.42494297, 22.4761848, -4.74950218, -0.839360118, 0.121296331, 0.529869556, -0.476863205, -0.632204473, -0.610670924, 0.260913789, -0.765248179, 0.588489115)).Position;
--				VFXService.EmitParticlesInInstance(v792);
--				VFXService.DestroyParticleContainer(v792, 3);
--				if l_On_13 == v26 then
--					VFXService.ShakeCamera(0, 0.4, 22, 0.2, 0.22, 0.2);
--				end;
--			end;
--		end;
--		if l_Request_1 == "VirguleUpTeleport2" then
--			local l_On_14 = v724.On;
--			if not (l_On_14 ~= nil) or l_On_14.Parent == nil then
--				return;
--			else
--				local v794 = l_Assets_0.Particles.Jun.VirguleCascadeAir.Teleport:Clone();
--				v794.Parent = l_VFX_0;
--				v794.Position = l_On_14.HumanoidRootPart.Position;
--				VFXService.EmitParticlesInInstance(v794);
--				VFXService.DestroyParticleContainer(v794, 3);
--				if l_On_14 == v26 then
--					VFXService.ShakeCamera(0, 0.4, 16.5, 0.2, 0.22, 0.2);
--				end;
--			end;
--		end;
--		if l_Request_1 == "VirguleUpVictimSound" then
--			local l_On_15 = v724.On;
--			if not (l_On_15 ~= nil) or l_On_15.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_15.Torso, "VirguleCascadeAirVariantVictim");
--			end;
--		end;
--		if l_Request_1 == "VirguleUpSlashContact" then
--			local l_On_16 = v724.On;
--			if not (l_On_16 ~= nil) or l_On_16.Parent == nil then
--				return;
--			else
--				local v797 = l_On_16.HumanoidRootPart.CFrame + l_On_16.HumanoidRootPart.CFrame.LookVector * 3;
--				local v798 = l_Assets_0.Particles.Jun.VirguleCascadeAir.SlashContact:Clone();
--				v798.Parent = l_VFX_0;
--				v798.CFrame = v797;
--				v104.PlaySoundInInstance(l_On_16.Torso, "VirguleCascadeAirVariantUser");
--				v104.PlaySoundInInstance(l_On_16.Torso, "VirguleCascadeAirVariantUserVoice");
--				VFXService.EmitParticlesInInstance(v798);
--				VFXService.DestroyParticleContainer(v798, 5.5);
--				if not (l_On_16 ~= v26) or (l_On_16.HumanoidRootPart.Position - l_HumanoidRootPart_0.Position).Magnitude <= 30 then
--					VFXService.ShakeCamera(0, 0.4, 22, 0.35, 0.35, 0.35);
--				end;
--			end;
--		end;
--		if l_Request_1 == "VirguleUpSlash" then
--			local l_On_17 = v724.On;
--			if not (l_On_17 ~= nil) or l_On_17.Parent == nil then
--				return;
--			else
--				local v800 = l_On_17.HumanoidRootPart.CFrame + l_On_17.HumanoidRootPart.CFrame.LookVector * 3;
--				local v801 = l_Assets_0.Particles.Jun.VirguleCascadeAir.SlashUp:Clone();
--				v801.Parent = l_VFX_0;
--				v801.CFrame = v800;
--				local v802 = VFXService.FindGroundPosition(v800.Position);
--				if v802 then
--					local v803 = v0.ColorSequence.new(v802.Instance.Color);
--					for _, v805 in v0.pairs(v801:GetDescendants()) do
--						if v805:IsA("ParticleEmitter") and v805.Name == "Smoke" then
--							v805.Color = v803;
--						end;
--					end;
--				end;
--				if v88.Blood == false then
--					for _, v807 in v0.pairs(v801:GetDescendants()) do
--						if v807:IsA("ParticleEmitter") and v807.Name == "Blood" then
--							v807:Destroy();
--						end;
--					end;
--				end;
--				VFXService.EmitParticlesInInstance(v801);
--				VFXService.DestroyParticleContainer(v801, 5.5);
--				if not (l_On_17 ~= v26) or (l_On_17.HumanoidRootPart.Position - l_HumanoidRootPart_0.Position).Magnitude <= 30 then
--					VFXService.ShakeCamera(0, 0.4, 22, 0.35, 0.35, 0.35);
--				end;
--			end;
--		end;
--		if l_Request_1 == "ShadowCloakCosmetic" then
--			local l_On_18 = v724.On;
--			if not (l_On_18 ~= nil) or l_On_18.Parent == nil then
--				return;
--			else
--				local v809 = l_Assets_0.Parts.Cosmetics["Shadow Cloak"]:Clone();
--				v809:SetAttribute("ShadowCloakCosmetic", true);
--				local v810 = {};
--				for _, v812 in v0.pairs(v809.RootPart:GetChildren()) do
--					if v812:IsA("Bone") then
--						v0.table.insert(v810, v812.Name);
--					end;
--				end;
--				for _, v814 in v0.pairs(v810) do
--					local v815 = v809.RootPart:GetAttribute("Roots") or "";
--					v809.RootPart:SetAttribute("Roots", v815 .. v814 .. ",");
--				end;
--				v809.RootPart:AddTag("SmartBone");
--				v810 = nil;
--				local v816 = v0.Instance.new("Motor6D");
--				v816.Part0 = l_On_18.Torso;
--				v816.Parent = v809;
--				v809.Parent = l_On_18;
--				v816.Part1 = v809.RootPart;
--			end;
--		end;
--		if l_Request_1 == "EndShadowCloakCosmetic" then
--			local l_On_19 = v724.On;
--			if not (l_On_19 ~= nil) or l_On_19.Parent == nil then
--				return;
--			else
--				for _, v819 in v0.pairs(l_On_19:GetDescendants()) do
--					if v819:GetAttribute("ShadowCloakCosmetic") == true then
--						v819:Destroy();
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "SoulCloakCosmetic" then
--			local l_On_20 = v724.On;
--			if not (l_On_20 ~= nil) or l_On_20.Parent == nil then
--				return;
--			else
--				local v821 = l_Assets_0.Parts.Cosmetics["Soul Cloak"]:Clone();
--				v821:SetAttribute("SoulCloakCosmetic", true);
--				local v822 = {};
--				for _, v824 in v0.pairs(v821.RootPart:GetChildren()) do
--					if v824:IsA("Bone") then
--						v0.table.insert(v822, v824.Name);
--					end;
--				end;
--				for _, v826 in v0.pairs(v822) do
--					local v827 = v821.RootPart:GetAttribute("Roots") or "";
--					v821.RootPart:SetAttribute("Roots", v827 .. v826 .. ",");
--				end;
--				v821.RootPart:AddTag("SmartBone");
--				v822 = nil;
--				local v828 = v0.Instance.new("Motor6D");
--				v828.Part0 = l_On_20.Torso;
--				v828.Parent = v821;
--				v821.Parent = l_On_20;
--				v828.Part1 = v821.RootPart;
--			end;
--		end;
--		if l_Request_1 == "EndSoulCloakCosmetic" then
--			local l_On_21 = v724.On;
--			if not (l_On_21 ~= nil) or l_On_21.Parent == nil then
--				return;
--			else
--				for _, v831 in v0.pairs(l_On_21:GetDescendants()) do
--					if v831:GetAttribute("SoulCloakCosmetic") == true then
--						v831:Destroy();
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "WheelOfAdaptationCosmetic" then
--			local l_On_22 = v724.On;
--			if not (l_On_22 ~= nil) or l_On_22.Parent == nil then
--				return;
--			else
--				local v833 = l_Assets_0.Parts.Cosmetics["Wheel of Adaptation"]:Clone();
--				v833:SetAttribute("WheelOfAdaptationCosmetic", true);
--				local v834 = v0.Instance.new("Motor6D");
--				v834.C0 = v0.CFrame.new(0, 1.3, 0);
--				v834.Part0 = l_On_22.Head;
--				v834.Parent = v833;
--				v833.Parent = l_On_22;
--				v834.Part1 = v833;
--			end;
--		end;
--		if l_Request_1 == "SpinWheelOfAdaptationCosmetic" then
--			local l_On_23 = v724.On;
--			if not (l_On_23 ~= nil) or l_On_23.Parent == nil then
--				return;
--			else
--				local v836 = v0.TweenInfo.new(1, v0.Enum.EasingStyle.Bounce, v0.Enum.EasingDirection.Out);
--				for _, v838 in v0.pairs(l_On_23:GetDescendants()) do
--					if v838:GetAttribute("WheelOfAdaptationCosmetic") == true then
--						local l_Motor6D_0 = v838:FindFirstChildOfClass("Motor6D");
--						if l_Motor6D_0 ~= nil and l_Motor6D_0.Parent ~= nil then
--							if l_Motor6D_0:GetAttribute("NoSpin") ~= true then
--								l_Motor6D_0:SetAttribute("NoSpin", true);
--								local v840 = l_TweenService_0:Create(l_Motor6D_0, v836, {
--									C0 = l_Motor6D_0.C0 * v0.CFrame.Angles(0, -v0.math.pi / 2, 0)
--								});
--								local l_l_Motor6D_0_0 = l_Motor6D_0 --[[ copy: 9 -> 528 ]];
--								local l_l_On_23_0 = l_On_23 --[[ copy: 2 -> 529 ]];
--								v840.Completed:Once(function()
--									if l_l_Motor6D_0_0 ~= nil and l_l_Motor6D_0_0.Parent ~= nil then
--										l_l_Motor6D_0_0:SetAttribute("NoSpin", nil);
--									end;
--									if l_l_On_23_0 == v26 and l_l_On_23_0 ~= nil and l_l_On_23_0.Parent ~= nil then
--										local v843 = v0.Instance.new("Part");
--										v843.Massless = true;
--										v843.Anchored = false;
--										v843.Size = v0.Vector3.zero;
--										v843.Material = v0.Enum.Material.SmoothPlastic;
--										v843.Transparency = 1;
--										v843.EnableFluidForces = false;
--										v843.CastShadow = false;
--										v843.CanCollide = false;
--										v843.CanTouch = false;
--										v843.CanQuery = false;
--										v843.Parent = v26;
--										local v844 = v0.Instance.new("Weld");
--										v844.Parent = v843;
--										v844.Part0 = l_HumanoidRootPart_0;
--										v844.Part1 = v843;
--										l_RenderStepped_0:Wait();
--										if v843 ~= nil and v843.Parent ~= nil then
--											v843:Destroy();
--										end;
--									end;
--								end);
--								v840:Play();
--								v104.PlaySoundInInstance(v838, "WheelOfAdaptationSpin");
--								break;
--							else
--								local l_l_Motor6D_0_1 = l_Motor6D_0 --[[ copy: 9 -> 524 ]];
--								local l_v836_0 = v836 --[[ copy: 3 -> 525 ]];
--								local l_l_On_23_1 = l_On_23 --[[ copy: 2 -> 526 ]];
--								local l_v838_0 = v838 --[[ copy: 8 -> 527 ]];
--								v0.task.spawn(function()
--									while true do
--										v0.task.wait();
--										if not (l_l_Motor6D_0_1 ~= nil and l_l_Motor6D_0_1.Parent ~= nil and l_l_Motor6D_0_1:GetAttribute("NoSpin") == true) then
--											break;
--										end;
--									end;
--									if l_l_Motor6D_0_1 ~= nil and l_l_Motor6D_0_1.Parent ~= nil and l_l_Motor6D_0_1:GetAttribute("NoSpin") ~= true then
--										l_l_Motor6D_0_1:SetAttribute("NoSpin", true);
--										local v849 = l_TweenService_0:Create(l_l_Motor6D_0_1, l_v836_0, {
--											C0 = l_l_Motor6D_0_1.C0 * v0.CFrame.Angles(0, -v0.math.pi / 2, 0)
--										});
--										v849.Completed:Once(function()
--											if l_l_Motor6D_0_1 ~= nil and l_l_Motor6D_0_1.Parent ~= nil then
--												l_l_Motor6D_0_1:SetAttribute("NoSpin", nil);
--											end;
--											if l_l_On_23_1 == v26 and l_l_On_23_1 ~= nil and l_l_On_23_1.Parent ~= nil then
--												local v850 = v0.Instance.new("Part");
--												v850.Massless = true;
--												v850.Anchored = false;
--												v850.Size = v0.Vector3.zero;
--												v850.Material = v0.Enum.Material.SmoothPlastic;
--												v850.Transparency = 1;
--												v850.EnableFluidForces = false;
--												v850.CastShadow = false;
--												v850.CanCollide = false;
--												v850.CanTouch = false;
--												v850.CanQuery = false;
--												v850.Parent = v26;
--												local v851 = v0.Instance.new("Weld");
--												v851.Parent = v850;
--												v851.Part0 = l_HumanoidRootPart_0;
--												v851.Part1 = v850;
--												l_RenderStepped_0:Wait();
--												if v850 ~= nil and v850.Parent ~= nil then
--													v850:Destroy();
--												end;
--											end;
--										end);
--										v849:Play();
--										v104.PlaySoundInInstance(l_v838_0, "WheelOfAdaptationSpin");
--									end;
--								end);
--								break;
--							end;
--						end;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "EndWheelOfAdaptationCosmetic" then
--			local l_On_24 = v724.On;
--			if not (l_On_24 ~= nil) or l_On_24.Parent == nil then
--				return;
--			else
--				for _, v854 in v0.pairs(l_On_24:GetDescendants()) do
--					if v854:GetAttribute("WheelOfAdaptationCosmetic") == true then
--						v854:Destroy();
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "VirguleTeleportShake" then
--			VFXService.ShakeCamera(0, 0.4, 22, 0.2, 0.22, 0.2);
--		end;
--		if l_Request_1 == "VirguleUpTeleportShake" then
--			VFXService.ShakeCamera(0, 0.4, 16.5, 0.2, 0.22, 0.2);
--		end;
--		if l_Request_1 == "VirguleStartSound" then
--			local l_On_31 = v724.On;
--			if not (l_On_31 ~= nil) or l_On_31.Parent == nil then
--				return;
--			else
--				local v1382 = v104.PlaySoundInInstance(l_On_31.Torso, "VirguleCascadeStart");
--				local v1383 = l_TweenService_0:Create(v1382, v0.TweenInfo.new(0.2, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--					Volume = 0
--				});
--				local l_v1382_0 = v1382 --[[ copy: 3 -> 439 ]];
--				v1383.Completed:Connect(function()
--					if l_v1382_0 ~= nil and l_v1382_0.Parent ~= nil then
--						l_v1382_0:Destroy();
--					end;
--				end);
--				local l_v1383_0 = v1383 --[[ copy: 4 -> 440 ]];
--				local v1386 = VFXService.CreateBind(l_On_31, "VirguleCascadeStartSound", function()
--					if l_v1382_0 ~= nil and l_v1382_0.Parent ~= nil then
--						l_v1382_0:SetAttribute("DefaultVolume", nil);
--						l_v1383_0:Play();
--					end;
--				end);
--				local l_v1386_0 = v1386 --[[ copy: 5 -> 441 ]];
--				v1382.Ended:Connect(function()
--					if l_v1386_0 ~= nil and l_v1386_0.Parent ~= nil then
--						l_v1386_0:Destroy();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndVirguleStartSound" then
--			local l_On_32 = v724.On;
--			if not (l_On_32 ~= nil) or l_On_32.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_32, "VirguleCascadeStartSound");
--			end;
--		end;
--		if l_Request_1 == "VirguleFinal" then
--			local l_On_33 = v724.On;
--			if not (l_On_33 ~= nil) or l_On_33.Parent == nil then
--				return;
--			else
--				local l_CFrame_33 = l_On_33.HumanoidRootPart.CFrame;
--				local v1391 = l_CFrame_33 * v0.CFrame.new(0, -2.92484283, -2.5, 1, 0, 0, 0, 1.00000668, 0, 0, 0, 1.00000668);
--				local v1392 = l_Assets_0.Particles.Jun.VirguleCascade.Final:Clone();
--				v1392.Parent = l_VFX_0;
--				v1392.CFrame = v1391;
--				local v1393 = {};
--				local v1394 = {};
--				local v1395 = l_CFrame_33 + l_CFrame_33.LookVector * 2;
--				VFXService.GetFlyingRocksProperties(v1394, v1395 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), v0.math.random(4, 5), {
--					10, 
--					30
--				}, {
--					80, 
--					60
--				}, {
--					10, 
--					30
--				}, 1, 1, 1, 4);
--				VFXService.GetFlyingRocksProperties(v1394, v1395, v0.math.random(2, 3), {
--					10, 
--					30
--				}, {
--					80, 
--					60
--				}, {
--					10, 
--					30
--				}, 1.5, 1.5, 1.5, 4);
--				VFXService.GetFlyingRocksProperties(v1394, v1395 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), v0.math.random(2, 3), {
--					10, 
--					30
--				}, {
--					80, 
--					60
--				}, {
--					10, 
--					30
--				}, 1.3, 1.3, 1.3, 4);
--				VFXService.GetCircularRocksProperties(v1393, v1395, {
--					17, 
--					20
--				}, 8, {
--					12, 
--					14
--				}, {
--					2.5, 
--					3.5
--				}, {
--					2.5, 
--					3.5
--				}, {
--					-10, 
--					10
--				}, {
--					-7, 
--					7
--				}, {
--					-10, 
--					10
--				}, {
--					"Grow", 
--					"Sink"
--				}, 5, false, {
--					IncludeDuplicate = true
--				}, nil, {
--					0, 
--					0
--				}, {
--					0, 
--					0
--				}, {
--					0, 
--					0
--				});
--				VFXService.GetCircularRocksProperties(v1393, v1395, {
--					13, 
--					15
--				}, v0.math.random(8, 9), {
--					7, 
--					10.5
--				}, {
--					2, 
--					2.25
--				}, {
--					2, 
--					2.25
--				}, {
--					-5, 
--					5
--				}, {
--					-5, 
--					5
--				}, {
--					-5, 
--					5
--				}, {
--					"Grow", 
--					"Sink"
--				}, 5, false, {
--					IncludeDuplicate = true
--				}, nil, {
--					0, 
--					0
--				}, {
--					0, 
--					0
--				}, {
--					0, 
--					0
--				});
--				local v1396 = VFXService.GetTile(v1395.Position + v0.Vector3.new(0, 1.5, 0));
--				VFXService.ApplyFlyingRocksProperties(v1394);
--				VFXService.ApplyCircularRocksProperties(v1393);
--				VFXService.DestroyTile(v1396);
--				v104.PlaySoundAtCFrame(v1395, "VirguleCascadeFinal");
--				if not (l_On_33 ~= v26) or (l_On_33.HumanoidRootPart.Position - l_HumanoidRootPart_0.Position).Magnitude <= 25 then
--					VFXService.ShakeCamera(0, 0.57, 27, 0.47, 0.54, 0.47);
--				end;
--				VFXService.EmitParticlesInInstance(v1392);
--				VFXService.DestroyParticleContainer(v1392, 4.75);
--			end;
--		end;
--		if l_Request_1 == "VirguleUpSlam" then
--			local l_On_34 = v724.On;
--			if not (l_On_34 ~= nil) or l_On_34.Parent == nil then
--				return;
--			else
--				local v1398 = l_On_34.HumanoidRootPart.CFrame + l_On_34.HumanoidRootPart.CFrame.LookVector * 3;
--				local v1399 = l_Assets_0.Particles.Jun.VirguleCascadeAir.Slam:Clone();
--				v1399.Parent = l_VFX_0;
--				v1399.CFrame = v1398 - v0.Vector3.new(0, 2.947, 0);
--				local v1400 = {};
--				local v1401 = {};
--				local v1402 = VFXService.GetTile(v1398.Position);
--				local v1403 = VFXService.FindGroundPosition(v1399.Position);
--				if v1403 then
--					local v1404 = v0.ColorSequence.new(VFXService.MakeDarker(v1403.Instance.Color, -10, -10, -10));
--					for _, v1406 in v0.pairs(v1399:GetDescendants()) do
--						if v1406:IsA("ParticleEmitter") and v1406.Name == "Smoke" then
--							v1406.Color = v1404;
--						end;
--					end;
--				end;
--				VFXService.GetCircularRocksProperties(v1400, v1398 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--					3.7, 
--					5
--				}, 5, {
--					2.5, 
--					3
--				}, {
--					0.7, 
--					1
--				}, {
--					0.7, 
--					1
--				}, {
--					-0.5, 
--					0.5
--				}, {
--					-0.5, 
--					0.5
--				}, {
--					-0.5, 
--					0.5
--				}, {
--					"Grow", 
--					"Sink"
--				}, 5, false, {
--					IncludeDuplicate = false
--				}, nil, {
--					0, 
--					0
--				}, {
--					0.7, 
--					1.1
--				}, {
--					0, 
--					0
--				});
--				VFXService.GetCircularRocksProperties(v1400, v1398, {
--					12, 
--					15
--				}, v0.math.random(5, 6), {
--					5.5, 
--					8.5
--				}, {
--					1.5, 
--					1.75
--				}, {
--					1.5, 
--					1.75
--				}, {
--					-5, 
--					5
--				}, {
--					-5, 
--					5
--				}, {
--					-5, 
--					5
--				}, {
--					"Grow", 
--					"Sink"
--				}, 5, false, {
--					IncludeDuplicate = true
--				}, nil, {
--					0, 
--					0
--				}, {
--					0, 
--					0
--				}, {
--					0, 
--					0
--				});
--				VFXService.GetCircularRocksProperties(v1400, v1398, {
--					6, 
--					9
--				}, v0.math.random(6, 8), {
--					2, 
--					4.5
--				}, {
--					0.65, 
--					1
--				}, {
--					1, 
--					1.5
--				}, {
--					-5, 
--					5
--				}, {
--					-5, 
--					5
--				}, {
--					-5, 
--					5
--				}, {
--					"Grow", 
--					"Sink"
--				}, 5, false, {
--					IncludeDuplicate = false
--				}, nil, {
--					0, 
--					0
--				}, {
--					0.1, 
--					0.2
--				}, {
--					0, 
--					0
--				});
--				VFXService.GetCircularRocksProperties(v1400, v1398 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--					6, 
--					9
--				}, v0.math.random(6, 8), {
--					3, 
--					4
--				}, {
--					1, 
--					1.5
--				}, {
--					1.75, 
--					2.25
--				}, {
--					-5, 
--					5
--				}, {
--					-5, 
--					5
--				}, {
--					-5, 
--					5
--				}, {
--					"Grow", 
--					"Sink"
--				}, 5, false, {
--					IncludeDuplicate = true
--				}, nil, {
--					0, 
--					0
--				}, {
--					0.1, 
--					0.2
--				}, {
--					0, 
--					0
--				});
--				VFXService.GetFlyingRocksProperties(v1401, v1398, v0.math.random(4, 5), {
--					10, 
--					70
--				}, {
--					80, 
--					80
--				}, {
--					10, 
--					70
--				}, 1, 1, 1, 4);
--				VFXService.GetFlyingRocksProperties(v1401, v1398, v0.math.random(2, 3), {
--					10, 
--					70
--				}, {
--					80, 
--					80
--				}, {
--					10, 
--					70
--				}, 1.5, 1.5, 1.5, 4);
--				VFXService.GetFlyingRocksProperties(v1401, v1398, v0.math.random(2, 3), {
--					10, 
--					70
--				}, {
--					80, 
--					80
--				}, {
--					10, 
--					70
--				}, 1.3, 1.3, 1.3, 4);
--				VFXService.GetFlyingRocksProperties(v1401, v1398, v0.math.random(4, 5), {
--					10, 
--					70
--				}, {
--					80, 
--					60
--				}, {
--					10, 
--					70
--				}, 1, 1, 1, 4);
--				VFXService.GetFlyingRocksProperties(v1401, v1398 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), v0.math.random(4, 5), {
--					10, 
--					70
--				}, {
--					80, 
--					60
--				}, {
--					10, 
--					70
--				}, 1, 1, 1, 4);
--				VFXService.GetFlyingRocksProperties(v1401, v1398, v0.math.random(2, 3), {
--					10, 
--					70
--				}, {
--					80, 
--					60
--				}, {
--					10, 
--					70
--				}, 1.5, 1.5, 1.5, 4);
--				VFXService.GetFlyingRocksProperties(v1401, v1398 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), v0.math.random(2, 3), {
--					10, 
--					70
--				}, {
--					80, 
--					60
--				}, {
--					10, 
--					70
--				}, 1.3, 1.3, 1.3, 4);
--				VFXService.GetCircularRocksProperties(v1400, v1398, {
--					17, 
--					20
--				}, 8, {
--					12, 
--					14
--				}, {
--					2.5, 
--					3.5
--				}, {
--					2.5, 
--					3.5
--				}, {
--					-10, 
--					10
--				}, {
--					-7, 
--					7
--				}, {
--					-10, 
--					10
--				}, {
--					"Grow", 
--					"Sink"
--				}, 5, false, {
--					IncludeDuplicate = true
--				}, nil, {
--					0, 
--					0
--				}, {
--					0, 
--					0
--				}, {
--					0, 
--					0
--				});
--				VFXService.GetCircularRocksProperties(v1400, v1398, {
--					13, 
--					15
--				}, v0.math.random(8, 9), {
--					7, 
--					10.5
--				}, {
--					2, 
--					2.25
--				}, {
--					2, 
--					2.25
--				}, {
--					-5, 
--					5
--				}, {
--					-5, 
--					5
--				}, {
--					-5, 
--					5
--				}, {
--					"Grow", 
--					"Sink"
--				}, 5, false, {
--					IncludeDuplicate = true
--				}, nil, {
--					0, 
--					0
--				}, {
--					0, 
--					0
--				}, {
--					0, 
--					0
--				});
--				v104.PlaySoundAtCFrame(v1398, "VirguleCascadeAirVariantCrater");
--				VFXService.ApplyCircularRocksProperties(v1400);
--				VFXService.ApplyFlyingRocksProperties(v1401);
--				VFXService.DestroyTile(v1402);
--				if not (l_On_34 ~= v26) or (l_On_34.HumanoidRootPart.Position - l_HumanoidRootPart_0.Position).Magnitude <= 25 then
--					VFXService.ShakeCamera(0, 0.6, 23, 0.47, 0.54, 0.47);
--				end;
--				VFXService.EmitParticlesInInstance(v1399);
--				VFXService.DestroyParticleContainer(v1399, 6);
--			end;
--		end;
--		if l_Request_1 == "VirguleSlam" then
--			local l_On_35 = v724.On;
--			if not (l_On_35 ~= nil) or l_On_35.Parent == nil then
--				return;
--			else
--				local v1408 = v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Quad, v0.Enum.EasingDirection.Out);
--				local v1409 = v0.TweenInfo.new(1, v0.Enum.EasingStyle.Quad, v0.Enum.EasingDirection.Out);
--				local v1410 = l_Assets_0.Particles.Jun.VirguleCascade.SlamMesh1:Clone();
--				local v1411 = l_Assets_0.Particles.Jun.VirguleCascade.SlamMesh2:Clone();
--				v1410.CFrame = l_On_35.HumanoidRootPart.CFrame * v0.CFrame.new(-0.0360717773, -1.99352455, -1.17919922, 0, 0, 1, 0, 1.00000334, 0, -1.00000334, 0, 0);
--				v1411.CFrame = l_On_35.HumanoidRootPart.CFrame * v0.CFrame.new(0.367614746, -0.150089264, 0.2578125, 1, 0, 0, 0, 1.00000334, 0, 0, 0, 1.00000334);
--				v1410.Transparency = 0.9;
--				v1411.Transparency = 0.65;
--				local v1412 = l_TweenService_0:Create(v1410, v1408, {
--					Transparency = 1, 
--					Size = v1410.Size + v0.Vector3.new(15, 0, 15)
--				});
--				local v1413 = l_TweenService_0:Create(v1411, v1409, {
--					Transparency = 1, 
--					Size = v1411.Size + v0.Vector3.new(5, 15, 5), 
--					Position = v1411.Position + v0.Vector3.new(0, 7.5, 0)
--				});
--				local l_v1410_0 = v1410 --[[ copy: 5 -> 437 ]];
--				v1412.Completed:Connect(function()
--					if l_v1410_0 ~= nil and l_v1410_0.Parent ~= nil then
--						l_v1410_0:Destroy();
--					end;
--				end);
--				local l_v1411_0 = v1411 --[[ copy: 6 -> 438 ]];
--				v1413.Completed:Connect(function()
--					if l_v1411_0 ~= nil and l_v1411_0.Parent ~= nil then
--						l_v1411_0:Destroy();
--					end;
--				end);
--				local l_CFrame_34 = l_On_35.HumanoidRootPart.CFrame;
--				local v1417 = l_CFrame_34 * v0.CFrame.new(0.115539551, -2.83759117, -0.629638672, 1.00000167, 0, 0, 0, 1.00000501, 0, 0, 0, 1.00000334);
--				local v1418 = l_Assets_0.Particles.Jun.VirguleCascade.Slam:Clone();
--				v1418.Parent = l_VFX_0;
--				v1418.CFrame = v1417;
--				local v1419 = l_CFrame_34 + l_CFrame_34.LookVector * 2;
--				local v1420 = {};
--				local v1421 = {};
--				VFXService.GetCircularRocksProperties(v1420, v1419 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--					3.7, 
--					5
--				}, 5, {
--					2.5, 
--					3
--				}, {
--					0.7, 
--					1
--				}, {
--					0.7, 
--					1
--				}, {
--					-0.5, 
--					0.5
--				}, {
--					-0.5, 
--					0.5
--				}, {
--					-0.5, 
--					0.5
--				}, {
--					"Grow", 
--					"Sink"
--				}, 5, false, {
--					IncludeDuplicate = false
--				}, nil, {
--					0, 
--					0
--				}, {
--					0.7, 
--					1.1
--				}, {
--					0, 
--					0
--				});
--				VFXService.GetCircularRocksProperties(v1420, v1419, {
--					12, 
--					15
--				}, v0.math.random(5, 6), {
--					5.5, 
--					8.5
--				}, {
--					1.5, 
--					1.75
--				}, {
--					1.5, 
--					1.75
--				}, {
--					-5, 
--					5
--				}, {
--					-5, 
--					5
--				}, {
--					-5, 
--					5
--				}, {
--					"Grow", 
--					"Sink"
--				}, 5, false, {
--					IncludeDuplicate = true
--				}, nil, {
--					0, 
--					0
--				}, {
--					0, 
--					0
--				}, {
--					0, 
--					0
--				});
--				VFXService.GetCircularRocksProperties(v1420, v1419, {
--					6, 
--					9
--				}, v0.math.random(6, 8), {
--					2, 
--					4.5
--				}, {
--					0.65, 
--					1
--				}, {
--					1, 
--					1.5
--				}, {
--					-5, 
--					5
--				}, {
--					-5, 
--					5
--				}, {
--					-5, 
--					5
--				}, {
--					"Grow", 
--					"Sink"
--				}, 5, false, {
--					IncludeDuplicate = false
--				}, nil, {
--					0, 
--					0
--				}, {
--					0.1, 
--					0.2
--				}, {
--					0, 
--					0
--				});
--				VFXService.GetCircularRocksProperties(v1420, v1419 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--					6, 
--					9
--				}, v0.math.random(6, 8), {
--					3, 
--					4
--				}, {
--					1, 
--					1.5
--				}, {
--					1.75, 
--					2.25
--				}, {
--					-5, 
--					5
--				}, {
--					-5, 
--					5
--				}, {
--					-5, 
--					5
--				}, {
--					"Grow", 
--					"Sink"
--				}, 5, false, {
--					IncludeDuplicate = true
--				}, nil, {
--					0, 
--					0
--				}, {
--					0.1, 
--					0.2
--				}, {
--					0, 
--					0
--				});
--				VFXService.GetFlyingRocksProperties(v1421, v1419, v0.math.random(4, 5), {
--					10, 
--					30
--				}, {
--					80, 
--					80
--				}, {
--					10, 
--					30
--				}, 1, 1, 1, 4);
--				VFXService.GetFlyingRocksProperties(v1421, v1419, v0.math.random(2, 3), {
--					10, 
--					30
--				}, {
--					80, 
--					80
--				}, {
--					10, 
--					30
--				}, 1.5, 1.5, 1.5, 4);
--				VFXService.GetFlyingRocksProperties(v1421, v1419, v0.math.random(2, 3), {
--					10, 
--					30
--				}, {
--					80, 
--					80
--				}, {
--					10, 
--					30
--				}, 1.3, 1.3, 1.3, 4);
--				VFXService.GetFlyingRocksProperties(v1421, v1419, v0.math.random(4, 5), {
--					10, 
--					30
--				}, {
--					80, 
--					60
--				}, {
--					10, 
--					30
--				}, 1, 1, 1, 4);
--				VFXService.ApplyCircularRocksProperties(v1420);
--				VFXService.ApplyFlyingRocksProperties(v1421);
--				local v1422 = VFXService.GetTile(v1419.Position);
--				VFXService.DestroyTile(v1422);
--				v104.PlaySoundAtCFrame(v1419, "VirguleCascadeSlam");
--				if not (l_On_35 ~= v26) or (l_On_35.HumanoidRootPart.Position - l_HumanoidRootPart_0.Position).Magnitude <= 25 then
--					VFXService.ShakeCamera(0, 0.3, 20, 0.32, 0.35, 0.32);
--				end;
--				v1410.Parent = l_VFX_0;
--				v1411.Parent = l_VFX_0;
--				v1412:Play();
--				v1413:Play();
--				VFXService.EmitParticlesInInstance(v1418);
--				VFXService.DestroyParticleContainer(v1418, 4.5);
--			end;
--		end;
--		if l_Request_1 == "VirguleCharge" then
--			local l_On_36 = v724.On;
--			if not (l_On_36 ~= nil) or l_On_36.Parent == nil then
--				return;
--			else
--				local v1424 = l_On_36.HumanoidRootPart.CFrame * v0.CFrame.new(0, 7.2479248E-5, -11.7963867, 1, 0, 0, 0, 1.00000334, 0, 0, 0, 1.00000334);
--				local v1425 = l_Assets_0.Particles.Jun.VirguleCascade.Charge:Clone();
--				local v1426 = v0.Instance.new("WeldConstraint");
--				v1426.Part0 = l_On_36.HumanoidRootPart;
--				v1426.Parent = v1425;
--				v1425.CFrame = v1424;
--				v1425.Parent = l_VFX_0;
--				v1426.Part1 = v1425;
--				local l_v1425_0 = v1425 --[[ copy: 4 -> 435 ]];
--				local l_l_On_36_0 = l_On_36 --[[ copy: 2 -> 436 ]];
--				VFXService.CreateBind(l_On_36, "VirguleCascadeChargeEffect", function()
--					if l_v1425_0 ~= nil and l_v1425_0.Parent ~= nil then
--						VFXService.EmitParticlesInInstance(l_v1425_0);
--						if l_l_On_36_0 ~= nil and l_l_On_36_0.Parent ~= nil and (not (l_l_On_36_0 ~= v26) or (l_l_On_36_0.HumanoidRootPart.Position - l_HumanoidRootPart_0.Position).Magnitude <= 22) then
--							VFXService.ShakeCamera(0, 0.4, 15, 0.14, 0.18, 0.14);
--						end;
--						for _, v1430 in v0.pairs(l_v1425_0:GetDescendants()) do
--							if v1430:IsA("ParticleEmitter") then
--								v1430.Enabled = false;
--							end;
--						end;
--						v0.task.delay(1.25, function()
--							if l_v1425_0 ~= nil and l_v1425_0.Parent ~= nil then
--								l_v1425_0:Destroy();
--							end;
--						end);
--					end;
--				end);
--				v0.task.delay(5, function()
--					if l_v1425_0 ~= nil and l_v1425_0.Parent ~= nil then
--						for _, v1432 in v0.pairs(l_v1425_0:GetDescendants()) do
--							if v1432:IsA("ParticleEmitter") then
--								v1432.Enabled = false;
--							end;
--						end;
--						v0.task.delay(1.25, function()
--							if l_v1425_0 ~= nil and l_v1425_0.Parent ~= nil then
--								l_v1425_0:Destroy();
--							end;
--						end);
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "VirguleThrow" then
--			local l_On_37 = v724.On;
--			if not (l_On_37 ~= nil) or l_On_37.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_37, "VirguleCascadeChargeEffect");
--			end;
--		end;
--		if l_Request_1 == "VirguleKick" then
--			local l_On_38 = v724.On;
--			if not (l_On_38 ~= nil) or l_On_38.Parent == nil then
--				return;
--			else
--				local v1435 = l_On_38.HumanoidRootPart.CFrame * v0.CFrame.new(0, 1.56897163, -9.06591797, 1, 0, 0, 0, 1.00000668, 0, 0, 0, 1.00000668);
--				local v1436 = l_Assets_0.Particles.Jun.VirguleCascade.Kick:Clone();
--				v1436.Parent = l_VFX_0;
--				v1436.CFrame = v1435;
--				if not (l_On_38 ~= v26) or (l_On_38.HumanoidRootPart.Position - l_HumanoidRootPart_0.Position).Magnitude <= 25 then
--					VFXService.ShakeCamera(0, 0.4, 19, 0.2, 0.22, 0.2);
--				end;
--				VFXService.EmitParticlesInInstance(v1436);
--				VFXService.DestroyParticleContainer(v1436, 3.5);
--			end;
--		end;
--		if l_Request_1 == "VirguleStab1" then
--			local l_On_39 = v724.On;
--			if not (l_On_39 ~= nil) or l_On_39.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_39.Torso, "VirguleCascadeHit1");
--			end;
--		end;
--		if l_Request_1 == "VirguleStab2" then
--			local l_On_40 = v724.On;
--			if not (l_On_40 ~= nil) or l_On_40.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_40.Torso, "VirguleCascadeHit2");
--			end;
--		end;
--		if l_Request_1 == "VirguleVictimSound" then
--			local l_On_41 = v724.On;
--			if not (l_On_41 ~= nil) or l_On_41.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_41.Torso, "VirguleCascadeVictim");
--			end;
--		end;
--		if l_Request_1 == "VirguleHeadStab" then
--			local l_On_42 = v724.On;
--			if not (l_On_42 ~= nil) or l_On_42.Parent == nil then
--				return;
--			else
--				local v1441 = l_On_42.HumanoidRootPart.CFrame * v0.CFrame.new(-0.0551147461, 1.17809296, -3.88208008, -0.997749925, -0.0668663457, -0.00490233861, -0.0670462474, 0.995129943, 0.0723508894, 4.06216313E-5, 0.0725167692, -0.997373879);
--				local v1442 = l_Assets_0.Particles.Jun.VirguleCascade.HeadStab:Clone();
--				v1442.Parent = l_VFX_0;
--				v1442.CFrame = v1441;
--				if v88.Blood == false then
--					for _, v1444 in v0.pairs(v1442:GetDescendants()) do
--						if v1444:IsA("ParticleEmitter") and v1444.Name == "Blood" then
--							v1444:Destroy();
--						end;
--					end;
--				end;
--				v104.PlaySoundInInstance(l_On_42.Torso, "VirguleCascadeUser");
--				v104.PlaySoundInInstance(l_On_42.Torso, "VirguleCascadeUserVoice");
--				if not (l_On_42 ~= v26) or (l_On_42.HumanoidRootPart.Position - l_HumanoidRootPart_0.Position).Magnitude <= 25 then
--					VFXService.ShakeCamera(0, 0.43, 17, 0.15, 0.19, 0.15);
--				end;
--				VFXService.EmitParticlesInInstance(v1442);
--				VFXService.DestroyParticleContainer(v1442, 1.5);
--			end;
--		end;
--		if l_Request_1 == "VirguleTeleport" then
--			local l_On_43 = v724.On;
--			if not (l_On_43 ~= nil) or l_On_43.Parent == nil then
--				return;
--			else
--				local v1446 = l_Assets_0.Particles.Jun.VirguleCascade.Teleport:Clone();
--				v1446.Parent = l_VFX_0;
--				v1446.Position = l_On_43.Torso.Position;
--				VFXService.EmitParticlesInInstance(v1446);
--				VFXService.DestroyParticleContainer(v1446, 1);
--			end;
--		end;
--		if l_Request_1 == "VirguleDaggerStar" then
--			local l_On_44 = v724.On;
--			if not (l_On_44 ~= nil) or l_On_44.Parent == nil then
--				return;
--			else
--				for _, v1449 in v0.pairs(l_On_44:GetDescendants()) do
--					if v1449:IsA("Model") and v1449.Name == "Dagger" and v1449:FindFirstChild("HandleR") and v1449:FindFirstChild("HandleR"):FindFirstChild("Star") then
--						VFXService.EmitParticlesInInstance(v1449.HandleR.Star);
--						break;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "VirguleDaggerTrail" then
--			local l_On_45 = v724.On;
--			if not (l_On_45 ~= nil) or l_On_45.Parent == nil then
--				return;
--			else
--				for _, v1452 in v0.pairs(l_On_45:GetDescendants()) do
--					if v1452:IsA("Trail") and v1452.Name == "VirguleCascadeTrail" then
--						v1452.Enabled = true;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "EndVirguleDaggerTrail" then
--			local l_On_46 = v724.On;
--			if not (l_On_46 ~= nil) or l_On_46.Parent == nil then
--				return;
--			else
--				for _, v1455 in v0.pairs(l_On_46:GetDescendants()) do
--					if v1455:IsA("Trail") and v1455.Name == "VirguleCascadeTrail" then
--						v1455.Enabled = false;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "JunAwakeningCutscene" then
--			VFXService.EndCameraShake();
--			local _, _ = VFXService.InitiateCutscene("JunAwakeningAnimation", 60, 105322627737261, l_HumanoidRootPart_0, v0.CFrame.new(0, -3, 0), {
--				Time = 1
--			}, nil, nil, nil, false);
--			local v1458 = l_Assets_0.Particles.Jun.WolfFangFury.SmokeBehind:Clone();
--			local v1459 = v0.Instance.new("WeldConstraint");
--			v1459.Parent = v1458;
--			v1459.Part0 = l_HumanoidRootPart_0;
--			v1458.CFrame = l_HumanoidRootPart_0.CFrame * v0.CFrame.new(0.02734375, 1.483675, 6.4, 1.00000167, 0, 0, 0, 1.00000167, 0, 0, 0, 1);
--			v1458.Parent = l_VFX_0;
--			v1459.Part1 = v1458;
--			local l_v1459_0 = v1459 --[[ copy: 5 -> 433 ]];
--			local l_v1458_0 = v1458 --[[ copy: 4 -> 434 ]];
--			v0.task.delay(1.2, function()
--				if l_v1459_0 ~= nil and l_v1459_0.Parent ~= nil then
--					l_v1459_0:Destroy();
--				end;
--				if l_v1458_0 ~= nil and l_v1458_0.Parent ~= nil then
--					l_v1458_0.Anchored = true;
--					for _, v1463 in v0.pairs(l_v1458_0:GetDescendants()) do
--						if v1463:IsA("ParticleEmitter") then
--							v1463.Enabled = false;
--						end;
--					end;
--					v0.task.delay(5.6, function()
--						if l_v1458_0 ~= nil and l_v1458_0.Parent ~= nil then
--							l_v1458_0:Destroy();
--						end;
--					end);
--				end;
--			end);
--			v0.task.delay(6.9, function()
--				if l_v1458_0 ~= nil and l_v1458_0.Parent ~= nil then
--					l_v1458_0:Destroy();
--				end;
--			end);
--		end;
--		if l_Request_1 == "JunAwakeningCutsceneEyes" then
--			local l_On_47 = v724.On;
--			if not (l_On_47 ~= nil) or l_On_47.Parent == nil then
--				return;
--			else
--				local v1465 = l_Assets_0.Particles.Jun.WolfFangFury.Eyes.Eyes:Clone();
--				v1465.Parent = l_On_47.Head;
--				if l_On_47 == v26 and v88.PhotosensitiveMode == false then
--					VFXService.ScreenFlash();
--				end;
--				VFXService.EmitParticlesInInstance(v1465);
--				local l_v1465_0 = v1465 --[[ copy: 3 -> 432 ]];
--				v0.task.delay(1.5, function()
--					if l_v1465_0 ~= nil and l_v1465_0.Parent ~= nil then
--						for _, v1468 in v0.pairs(l_v1465_0:GetDescendants()) do
--							if v1468:IsA("ParticleEmitter") then
--								v1468.Enabled = false;
--							end;
--						end;
--						v0.task.delay(3, function()
--							if l_v1465_0 ~= nil and l_v1465_0.Parent ~= nil then
--								l_v1465_0:Destroy();
--							end;
--						end);
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "JunAwakeningLastKick" then
--			local v1469 = v724.At + v724.At.LookVector;
--			local v1470 = {};
--			local v1471 = {};
--			local v1472 = VFXService.GetRandomAngle();
--			local v1473 = VFXService.FindGroundPosition(v1469.Position + v0.Vector3.new(0, 3, 0), 15);
--			local v1474 = VFXService.GetTile(v1469.Position + v0.Vector3.new(0, 1, 0));
--			VFXService.GetCircularRocksProperties(v1470, v1469 * v0.CFrame.Angles(0, v1472, 0), {
--				30, 
--				38
--			}, 6, {
--				23, 
--				30
--			}, {
--				5, 
--				7
--			}, {
--				5, 
--				7
--			}, {
--				0, 
--				0
--			}, {
--				0, 
--				0
--			}, {
--				0, 
--				0
--			}, {
--				"Grow", 
--				"Shrink", 
--				nil, 
--				4
--			}, 5, false, {
--				IncludeDuplicate = true
--			}, nil, {
--				-3, 
--				3
--			}, {
--				0.05, 
--				0.075
--			}, {
--				4, 
--				9
--			});
--			VFXService.GetCircularRocksProperties(v1470, v1469 * v0.CFrame.Angles(0, v1472 + v0.math.pi / 4, 0), {
--				30, 
--				38
--			}, 6, {
--				23, 
--				30
--			}, {
--				7, 
--				9
--			}, {
--				7, 
--				9
--			}, {
--				0, 
--				0
--			}, {
--				0, 
--				0
--			}, {
--				0, 
--				0
--			}, {
--				"Grow", 
--				"Shrink", 
--				nil, 
--				4
--			}, 5, false, {
--				IncludeDuplicate = false
--			}, nil, {
--				-3, 
--				3
--			}, {
--				0.05, 
--				0.075
--			}, {
--				-7.5, 
--				6.5
--			});
--			VFXService.GetCircularRocksProperties(v1470, v1469 * v0.CFrame.Angles(0, v1472, 0), {
--				20, 
--				32
--			}, 6, {
--				13, 
--				17
--			}, {
--				3, 
--				5
--			}, {
--				3, 
--				5
--			}, {
--				0, 
--				0
--			}, {
--				0, 
--				0
--			}, {
--				0, 
--				0
--			}, {
--				"Grow", 
--				"Shrink", 
--				nil, 
--				4
--			}, 5, false, {
--				IncludeDuplicate = true
--			}, nil, {
--				-3, 
--				3
--			}, {
--				0.05, 
--				0.075
--			}, {
--				2, 
--				5
--			});
--			VFXService.GetCircularRocksProperties(v1470, v1469 * v0.CFrame.Angles(0, v1472, 0), {
--				20, 
--				32
--			}, 6, {
--				13, 
--				17
--			}, {
--				3, 
--				5
--			}, {
--				3, 
--				5
--			}, {
--				0, 
--				0
--			}, {
--				0, 
--				0
--			}, {
--				0, 
--				0
--			}, {
--				"Grow", 
--				"Shrink", 
--				nil, 
--				4
--			}, 5, false, {
--				IncludeDuplicate = true
--			}, nil, {
--				-3, 
--				3
--			}, {
--				0.05, 
--				0.075
--			}, {
--				-5, 
--				5
--			});
--			VFXService.GetCircularRocksProperties(v1470, v1469 * v0.CFrame.Angles(0, v1472, 0), {
--				15, 
--				21
--			}, 5, {
--				9, 
--				11.5
--			}, {
--				2, 
--				2.25
--			}, {
--				2, 
--				2.25
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				"Grow", 
--				"Shrink", 
--				nil, 
--				4
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetCircularRocksProperties(v1470, v1469 * v0.CFrame.Angles(0, v1472 + v0.math.pi / 4, 0), {
--				15, 
--				21
--			}, 5, {
--				11, 
--				13.5
--			}, {
--				2, 
--				3
--			}, {
--				2, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				"Grow", 
--				"Shrink", 
--				nil, 
--				4
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetFlyingRocksProperties(v1471, v1469, v0.math.random(5, 6), {
--				10, 
--				130
--			}, {
--				115, 
--				115
--			}, {
--				10, 
--				130
--			}, 3, 3, 3, 3, 1);
--			VFXService.GetFlyingRocksProperties(v1471, v1469, v0.math.random(3, 4), {
--				10, 
--				130
--			}, {
--				115, 
--				115
--			}, {
--				10, 
--				130
--			}, 4, 4, 4, 3, 1);
--			VFXService.GetFlyingRocksProperties(v1471, v1469, v0.math.random(4, 5), {
--				10, 
--				130
--			}, {
--				115, 
--				115
--			}, {
--				10, 
--				130
--			}, 2, 2, 2, 3, 1);
--			VFXService.GetFlyingRocksProperties(v1471, v1469, v0.math.random(4, 6), {
--				10, 
--				130
--			}, {
--				115, 
--				115
--			}, {
--				10, 
--				130
--			}, 4, 4, 4, 3, 1);
--			if v1473 then
--				local v1475 = l_Assets_0.Particles.Jun.WolfFangFury.FinalKick:Clone();
--				local v1476 = v0.CFrame.new(v1473.Position, v1473.Position + v1469.LookVector);
--				v1475.CFrame = v1476 + v0.Vector3.new(0, 0.5, 0);
--				local v1477 = l_Assets_0.Parts.Jun.WolfFangFury.MeshCombination:Clone();
--				v1477:PivotTo(v1476 * v0.CFrame.Angles(v0.math.pi, 0, 0) + v0.Vector3.new(0, 11, 0));
--				local l_3_0 = v1477["3"];
--				local l_Wind1_0 = v1477.Wind1;
--				local l_BeanWind_1 = v1477.BeanWind;
--				local l_GroundShockwave1_0 = v1477.GroundShockwave1;
--				local l_Wind2_0 = v1477.Wind2;
--				local v1483 = v0.TweenInfo.new(1, v0.Enum.EasingStyle.Cubic, v0.Enum.EasingDirection.Out);
--				local v1484 = v0.TweenInfo.new(1, v0.Enum.EasingStyle.Quad, v0.Enum.EasingDirection.Out);
--				local v1485 = l_TweenService_0:Create(l_3_0, v0.TweenInfo.new(0.7, v0.Enum.EasingStyle.Cubic, v0.Enum.EasingDirection.Out), {
--					Size = l_3_0.Size + v0.Vector3.new(70, 0, 70), 
--					Transparency = 1, 
--					CFrame = l_3_0.CFrame * v0.CFrame.Angles(0, v0.math.pi, 0)
--				});
--				local v1486 = l_TweenService_0:Create(l_Wind1_0, v0.TweenInfo.new(0.55, v0.Enum.EasingStyle.Cubic, v0.Enum.EasingDirection.Out), {
--					Size = l_Wind1_0.Size + v0.Vector3.new(50, 1.6, 50), 
--					Transparency = 1, 
--					Position = l_Wind1_0.Position + v0.Vector3.new(0, 25, 0)
--				});
--				local v1487 = l_TweenService_0:Create(l_BeanWind_1, v1483, {
--					Orientation = l_BeanWind_1.Orientation + v0.Vector3.new(0, 360, 0), 
--					Transparency = 1
--				});
--				local v1488 = l_TweenService_0:Create(l_BeanWind_1.Mesh, v1483, {
--					Scale = l_BeanWind_1.Mesh.Scale * 2
--				});
--				local v1489 = l_TweenService_0:Create(l_GroundShockwave1_0, v1484, {
--					Position = l_GroundShockwave1_0.Position - v0.Vector3.new(0, 10, 0)
--				});
--				local v1490 = l_TweenService_0:Create(l_GroundShockwave1_0.Mesh, v1484, {
--					Scale = l_GroundShockwave1_0.Mesh.Scale + v0.Vector3.new(30, -40, 30)
--				});
--				local v1491 = l_TweenService_0:Create(l_GroundShockwave1_0.Decal, v0.TweenInfo.new(1.2, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--					Transparency = 1
--				});
--				local v1492 = l_TweenService_0:Create(l_Wind2_0, v1484, {
--					Position = l_Wind2_0.Position - v0.Vector3.new(0, 15, 0), 
--					Transparency = 1
--				});
--				local v1493 = l_TweenService_0:Create(l_Wind2_0.Mesh, v1484, {
--					Scale = v0.Vector3.new(0.816, 2.577, 2.577)
--				});
--				v1477.Parent = l_VFX_0;
--				v1475.Parent = l_VFX_0;
--				local l_l_BeanWind_1_0 = l_BeanWind_1 --[[ copy: 13 -> 430 ]];
--				v0.task.spawn(function()
--					for v1495 = 1, 11 do
--						if l_l_BeanWind_1_0 ~= nil and l_l_BeanWind_1_0.Parent ~= nil then
--							local l_FirstChild_1 = l_l_BeanWind_1_0.Flip:FindFirstChild(v0.tostring(v1495));
--							if l_FirstChild_1 ~= nil and l_FirstChild_1.Parent ~= nil then
--								l_l_BeanWind_1_0.Mesh.TextureId = l_FirstChild_1.Texture;
--								v0.task.wait(0.1);
--							else
--								break;
--							end;
--						else
--							break;
--						end;
--					end;
--				end);
--				local l_v1477_0 = v1477 --[[ copy: 10 -> 431 ]];
--				v1491.Completed:Once(function()
--					if l_v1477_0 ~= nil and l_v1477_0.Parent ~= nil then
--						l_v1477_0:Destroy();
--					end;
--				end);
--				v104.PlaySoundAtCFrame(v1476, "WolfFangFuryFinalKick");
--				VFXService.EmitParticlesInInstance(v1475);
--				v1485:Play();
--				v1486:Play();
--				v1487:Play();
--				v1488:Play();
--				v1489:Play();
--				v1490:Play();
--				v1491:Play();
--				v1492:Play();
--				v1493:Play();
--				VFXService.DestroyParticleContainer(v1475, 5.5);
--			end;
--			VFXService.ApplyCircularRocksProperties(v1470);
--			VFXService.ApplyFlyingRocksProperties(v1471);
--			VFXService.DestroyTile(v1474);
--			if (v1469.Position - l_HumanoidRootPart_0.Position).Magnitude <= 60 then
--				VFXService.ShakeCamera(0, 0.55, 49, 0.9, 0.9, 0.6);
--			end;
--		end;
--		if l_Request_1 == "JunAwakeningFire" then
--			local l_On_48 = v724.On;
--			if not (l_On_48 ~= nil) or l_On_48.Parent == nil then
--				return;
--			else
--				local l_T_1 = v724.T;
--				local v1500 = v0.CFrame.new(l_On_48.HumanoidRootPart.Position, l_T_1.Position);
--				local v1501 = l_Assets_0.Particles.Jun.WolfFangFury.ShootUser:Clone();
--				v1501.CFrame = v1500;
--				v1501.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v1501);
--				v104.PlaySoundInInstance(l_On_48.HumanoidRootPart, "WolfFangFuryLaunch");
--				VFXService.DestroyParticleContainer(v1501, 3.5);
--			end;
--		end;
--		if l_Request_1 == "JunAwakeningFireClone" then
--			local l_On_49 = v724.On;
--			if not (l_On_49 ~= nil) or l_On_49.Parent == nil then
--				return;
--			else
--				local v1503 = v0.tostring(v724.Tag);
--				local l_T_2 = v724.T;
--				local l_F_2 = v724.F;
--				local l_N_1 = v724.N;
--				local v1507 = nil;
--				for _, v1509 in v0.pairs(l_VFX_0:GetChildren()) do
--					if v1509.Name == "JunAwakeningAnimationClone" .. v1503 then
--						v1507 = v1509;
--						for _, v1511 in v0.pairs(v1507:GetDescendants()) do
--							if v1511:IsA("RigidConstraint") then
--								v1511:Destroy();
--								v1507.HumanoidRootPart.Anchored = true;
--							end;
--						end;
--						break;
--					end;
--				end;
--				do
--					local l_v1507_0 = v1507;
--					if l_v1507_0 ~= nil and l_v1507_0.Parent ~= nil then
--						local v1513 = nil;
--						for _, v1515 in v0.pairs(l_On_49.HumanoidRootPart:GetChildren()) do
--							if v1515.Name == "JunAwakeningAnimationAttachment" .. v1503 then
--								v1513 = v1515;
--								break;
--							end;
--						end;
--						local v1516 = v0.Vector3.new(0, 1, 0);
--						if v1513 ~= nil and v1513.Parent ~= nil then
--							v1513:Destroy();
--							local v1517 = v0.CFrame.new(l_v1507_0.HumanoidRootPart.Position, l_F_2.Position);
--							l_v1507_0.HumanoidRootPart.CFrame = v1517 * v0.CFrame.Angles(-v0.math.pi / 2, 0, 0);
--							local v1518 = l_TweenService_0:Create(l_v1507_0.HumanoidRootPart, v0.TweenInfo.new(l_T_2, v0.Enum.EasingStyle.Linear), {
--								CFrame = l_F_2
--							});
--							local l_l_N_1_0 = l_N_1 --[[ copy: 6 -> 426 ]];
--							local l_v1516_0 = v1516 --[[ copy: 9 -> 427 ]];
--							local l_l_F_2_0 = l_F_2 --[[ copy: 5 -> 428 ]];
--							local l_l_On_49_0 = l_On_49 --[[ copy: 2 -> 429 ]];
--							v1518.Completed:Once(function()
--								local v1523 = l_Assets_0.Particles.Jun.WolfFangFury.CloneHit:Clone();
--								v1523.Parent = l_VFX_0;
--								if typeof(l_l_N_1_0) == "Vector3" then
--									local v1524 = {};
--									local v1525 = "WolfFangFuryCloneCrater" .. v0.tostring(v0.math.random(1, 4));
--									if l_l_N_1_0 == l_v1516_0 then
--										v1523.CFrame = l_l_F_2_0;
--										local v1526 = {};
--										local v1527 = v0.CFrame.new(l_l_F_2_0.Position, l_l_F_2_0.Position + l_v1516_0) + l_v1516_0;
--										VFXService.GetCircularRocksProperties(v1524, v1527 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--											12, 
--											16
--										}, 5, {
--											6, 
--											10
--										}, {
--											2.5, 
--											3.5
--										}, {
--											2.5, 
--											3.5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											"Grow", 
--											"Sink"
--										}, 2.5, false, {
--											IncludeDuplicate = true
--										});
--										VFXService.GetCircularRocksProperties(v1524, v1527 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--											12, 
--											16
--										}, 4, {
--											6, 
--											8
--										}, {
--											1.25, 
--											3.5
--										}, {
--											1.25, 
--											3.5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											"Grow", 
--											"Sink"
--										}, 2.5, false, {
--											IncludeDuplicate = true
--										});
--										VFXService.GetCircularRocksProperties(v1524, v1527 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--											7, 
--											12
--										}, 3, {
--											4, 
--											5
--										}, {
--											1.25, 
--											1.75
--										}, {
--											1.25, 
--											1.75
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											"Grow", 
--											"Sink"
--										}, 2.5, false, {
--											IncludeDuplicate = true
--										});
--										VFXService.GetCircularRocksProperties(v1524, v1527 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--											7, 
--											12
--										}, 3, {
--											4, 
--											5
--										}, {
--											1.25, 
--											1.75
--										}, {
--											1.25, 
--											1.75
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											"Grow", 
--											"Sink"
--										}, 2.5, false, {
--											IncludeDuplicate = true
--										});
--										VFXService.GetCircularRocksProperties(v1524, v1527, {
--											4, 
--											9
--										}, v0.math.random(4, 5), {
--											2, 
--											4.5
--										}, {
--											0.65, 
--											1
--										}, {
--											1, 
--											1.5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											"Grow", 
--											"Sink"
--										}, 5, false, {
--											IncludeDuplicate = true
--										});
--										VFXService.GetCircularRocksProperties(v1524, v1527 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--											4, 
--											9
--										}, v0.math.random(4, 5), {
--											3, 
--											4
--										}, {
--											1, 
--											1.5
--										}, {
--											1.75, 
--											2.25
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											"Grow", 
--											"Sink"
--										}, 2.5, false, {
--											IncludeDuplicate = true
--										});
--										VFXService.GetFlyingRocksProperties(v1526, v1527, 1, {
--											10, 
--											90
--										}, {
--											70, 
--											70
--										}, {
--											10, 
--											90
--										}, 1.5, 1.5, 1.5, nil, 2);
--										VFXService.GetFlyingRocksProperties(v1526, v1527, 1, {
--											10, 
--											90
--										}, {
--											70, 
--											70
--										}, {
--											10, 
--											90
--										}, 1.7, 1.7, 1.7, nil, 2);
--										VFXService.GetFlyingRocksProperties(v1526, v1527, 1, {
--											10, 
--											90
--										}, {
--											70, 
--											70
--										}, {
--											10, 
--											90
--										}, 1.2, 1.2, 1.2, nil, 2);
--										VFXService.GetFlyingRocksProperties(v1526, v1527, 1, {
--											10, 
--											90
--										}, {
--											70, 
--											70
--										}, {
--											10, 
--											90
--										}, 0.8, 0.8, 0.8, nil, 2);
--										VFXService.GetFlyingRocksProperties(v1526, v1527, 1, {
--											10, 
--											90
--										}, {
--											70, 
--											70
--										}, {
--											10, 
--											90
--										}, 1.6, 1.6, 1.6, nil, 2);
--										VFXService.ApplyFlyingRocksProperties(v1526);
--										local v1528 = VFXService.GetTile(v1527.Position + v0.Vector3.new(0, 2, 0));
--										VFXService.DestroyTile(v1528);
--									else
--										local v1529 = v0.CFrame.new(l_l_F_2_0.Position, l_l_F_2_0.Position + l_l_N_1_0);
--										v1523.CFrame = v1529;
--										local v1530 = v1529 * v0.CFrame.Angles(-v0.math.pi / 2, 0, 0);
--										VFXService.GetCircularWallRocksProperties(v1524, v1530 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--											12, 
--											16
--										}, 7, {
--											6, 
--											10
--										}, {
--											2.5, 
--											3.5
--										}, {
--											2.5, 
--											3.5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											"Grow", 
--											"Sink"
--										}, 2.5, false, {
--											IncludeDuplicate = true
--										});
--										VFXService.GetCircularWallRocksProperties(v1524, v1530 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--											12, 
--											16
--										}, 7, {
--											6, 
--											8
--										}, {
--											1.25, 
--											3.5
--										}, {
--											1.25, 
--											3.5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											"Grow", 
--											"Sink"
--										}, 2.5, false, {
--											IncludeDuplicate = true
--										});
--										VFXService.GetCircularWallRocksProperties(v1524, v1530 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--											7, 
--											12
--										}, 5, {
--											4, 
--											5
--										}, {
--											1.25, 
--											1.75
--										}, {
--											1.25, 
--											1.75
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											"Grow", 
--											"Sink"
--										}, 2.5, false, {
--											IncludeDuplicate = true
--										});
--										VFXService.GetCircularWallRocksProperties(v1524, v1530 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--											7, 
--											12
--										}, 5, {
--											4, 
--											5
--										}, {
--											1.25, 
--											1.75
--										}, {
--											1.25, 
--											1.75
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											"Grow", 
--											"Sink"
--										}, 2.5, false, {
--											IncludeDuplicate = true
--										});
--										VFXService.GetCircularWallRocksProperties(v1524, v1530, {
--											4, 
--											9
--										}, v0.math.random(6, 8), {
--											2, 
--											4.5
--										}, {
--											0.65, 
--											1
--										}, {
--											1, 
--											1.5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											"Grow", 
--											"Sink"
--										}, 5, false, {
--											IncludeDuplicate = true
--										});
--										VFXService.GetCircularWallRocksProperties(v1524, v1530 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--											4, 
--											9
--										}, v0.math.random(6, 8), {
--											3, 
--											4
--										}, {
--											1, 
--											1.5
--										}, {
--											1.75, 
--											2.25
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											"Grow", 
--											"Sink"
--										}, 2.5, false, {
--											IncludeDuplicate = true
--										});
--									end;
--									v104.PlaySoundAtCFrame(l_l_F_2_0, v1525);
--									VFXService.ApplyCircularRocksProperties(v1524);
--								else
--									v1523.CFrame = l_l_F_2_0;
--								end;
--								VFXService.EmitParticlesInInstance(v1523);
--								if l_v1507_0 ~= nil and l_v1507_0.Parent ~= nil then
--									l_v1507_0:Destroy();
--								end;
--								VFXService.DestroyParticleContainer(v1523, 5);
--								if not (l_l_On_49_0 ~= v26) or (l_HumanoidRootPart_0.Position - l_l_F_2_0.Position).Magnitude <= 30 then
--									VFXService.ShakeCamera(0, 0.5, 15, 0.3, 0.3, 0.3);
--								end;
--							end);
--							v1518:Play();
--							local v1531 = l_Assets_0.Particles.Jun.WolfFangFury.ShootClone:Clone();
--							v1531.CFrame = v1517;
--							v1531.Parent = l_VFX_0;
--							VFXService.EmitParticlesInInstance(v1531);
--							VFXService.DestroyParticleContainer(v1531, 2);
--						else
--							l_v1507_0:Destroy();
--						end;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "JunAwakeningMoveFirst4" then
--			local l_On_50 = v724.On;
--			if not (l_On_50 ~= nil) or l_On_50.Parent == nil then
--				return;
--			else
--				local l_Tags_0 = v724.Tags;
--				local v1534 = v0.TweenInfo.new(1, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out);
--				for v1535 = 1, 4 do
--					local v1536 = v0.tostring(l_Tags_0[v1535]);
--					for _, v1538 in v0.pairs(l_On_50.HumanoidRootPart:GetChildren()) do
--						if v1538.Name == "JunAwakeningAnimationAttachment" .. v1536 then
--							l_TweenService_0:Create(v1538, v1534, {
--								CFrame = v1538:FindFirstChildOfClass("CFrameValue").Value
--							}):Play();
--						end;
--					end;
--				end;
--				local l_CFrame_35 = l_On_50.HumanoidRootPart.CFrame;
--				local v1540 = VFXService.FindGroundPosition(l_CFrame_35.Position, 30);
--				local v1541 = VFXService.GetTile(l_CFrame_35.Position);
--				if v1540 then
--					local v1542 = l_Assets_0.Particles.Jun.WolfFangFury.Jump:Clone();
--					local v1543 = v1540.Position + v0.Vector3.new(0, 0.048, 0);
--					v1542.CFrame = v0.CFrame.new(v1543, v1543 + l_CFrame_35.LookVector);
--					v1542.Parent = l_VFX_0;
--					VFXService.EmitParticlesInInstance(v1542);
--					VFXService.DestroyTile(v1541);
--					VFXService.DestroyParticleContainer(v1542, 5.3);
--					if not (l_On_50 ~= v26) or (l_HumanoidRootPart_0.Position - l_On_50.HumanoidRootPart.Position).Magnitude <= 25 then
--						VFXService.ShakeCamera(0, 0.3, 20, 0.2, 0.2, 0.2);
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "JunAwakeningWhiteBeam" then
--			local l_On_51 = v724.On;
--			if not (l_On_51 ~= nil) or l_On_51.Parent == nil then
--				return;
--			else
--				local l_CFrame_36 = l_On_51.HumanoidRootPart.CFrame;
--				local v1546 = VFXService.FindGroundPosition(l_CFrame_36.Position, 30);
--				local v1547 = VFXService.GetTile(l_CFrame_36.Position);
--				if v1546 then
--					local v1548 = l_Assets_0.Particles.Jun.WolfFangFury.WhiteBeam:Clone();
--					local v1549 = v1546.Position + v0.Vector3.new(0, 0.048, 0);
--					local v1550 = v0.CFrame.new(v1549, v1549 + l_CFrame_36.LookVector);
--					v1548.CFrame = v1550;
--					v1548.Parent = l_VFX_0;
--					VFXService.EmitParticlesInInstance(v1548);
--					VFXService.DestroyTile(v1547);
--					VFXService.DestroyParticleContainer(v1548, 14);
--					if not (v26 ~= l_On_51) or (l_HumanoidRootPart_0.Position - l_On_51.HumanoidRootPart.Position).Magnitude <= 30 then
--						VFXService.ShakeCamera(0, 0.4, 22, 0.3, 0.3, 0.3);
--					end;
--					v104.PlaySoundAtCFrame(v1550, "WolfFangFurySmoke");
--				end;
--				v104.PlaySoundInInstance(l_On_51.HumanoidRootPart, "WolfFangFury");
--			end;
--		end;
--		if l_Request_1 == "JunAwakeningCloneSound" then
--			local l_On_52 = v724.On;
--			if not (l_On_52 ~= nil) or l_On_52.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_52.HumanoidRootPart, "WolfFangFuryCloneSpawn");
--				v104.PlaySoundInInstance(l_On_52.HumanoidRootPart, "WolfFangFuryCloneSpawn2");
--			end;
--		end;
--		if l_Request_1 == "JunAwakeningFireSound" then
--			local l_On_53 = v724.On;
--			if not (l_On_53 ~= nil) or l_On_53.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_53.HumanoidRootPart, "WolfFangFuryFiring");
--			end;
--		end;
--		if l_Request_1 == "JunAwakeningRevealClone" then
--			local v1553 = v0.tostring(v724.Tag);
--			local l_S_0 = v724.S;
--			local v1555 = nil;
--			for _, v1557 in v0.pairs(l_VFX_0:GetChildren()) do
--				if v1557.Name == "JunAwakeningAnimationClone" .. v1553 then
--					v1555 = v1557;
--					break;
--				end;
--			end;
--			if v1555 ~= nil and v1555.Parent ~= nil then
--				if typeof(l_S_0) == "number" then
--					local v1558 = v0.Instance.new("Animation");
--					if l_S_0 == 1 then
--						v1558.AnimationId = "rbxassetid://86535304086134";
--						v104.PlaySoundInInstance(v1555.HumanoidRootPart, "WolfFangFuryBatch1Spawn1");
--					elseif l_S_0 == 2 then
--						v1558.AnimationId = "rbxassetid://101090680514052";
--						v104.PlaySoundInInstance(v1555.HumanoidRootPart, "WolfFangFuryBatch1Spawn2");
--					elseif l_S_0 == 3 then
--						v1558.AnimationId = "rbxassetid://122893023492039";
--						v104.PlaySoundInInstance(v1555.HumanoidRootPart, "WolfFangFuryBatch1Spawn3");
--					elseif l_S_0 == 4 then
--						v1558.AnimationId = "rbxassetid://123063464395880";
--						v104.PlaySoundInInstance(v1555.HumanoidRootPart, "WolfFangFuryBatch1Spawn4");
--					end;
--					local v1559 = v1555.Humanoid.Animator:LoadAnimation(v1558);
--					v1558:Destroy();
--					v1559.Priority = v0.Enum.AnimationPriority.Action4;
--					local v1560 = v0.Instance.new("Animation");
--					v1560.AnimationId = "rbxassetid://93554681406219";
--					local v1561 = v1555.Humanoid.Animator:LoadAnimation(v1560);
--					v1561.Priority = v0.Enum.AnimationPriority.Action4;
--					local l_v1561_0 = v1561 --[[ copy: 8 -> 425 ]];
--					v1559.Stopped:Connect(function()
--						if l_v1561_0 ~= nil then
--							l_v1561_0:Play();
--						end;
--					end);
--					v1559:Play(0);
--				else
--					local v1563 = v0.Instance.new("Animation");
--					v1563.AnimationId = "rbxassetid://93554681406219";
--					local v1564 = v1555.Humanoid.Animator:LoadAnimation(v1563);
--					v1564.Priority = v0.Enum.AnimationPriority.Action4;
--					v1564:Play(0);
--				end;
--				local v1565 = l_Assets_0.Particles.Jun.WolfFangFury.CloneSpawn:Clone();
--				v1565.CFrame = v1555.HumanoidRootPart.CFrame;
--				v1565.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v1565);
--				for _, v1567 in v0.pairs(v1555:GetDescendants()) do
--					if v1567:IsA("Decal") then
--						v1567.Transparency = v1567:GetAttribute("OldTransparency") or 0;
--					end;
--					if v1567:IsA("BasePart") then
--						v1567.Transparency = v1567:GetAttribute("OldTransparency") or 0;
--					end;
--				end;
--				VFXService.DestroyParticleContainer(v1565, 1);
--			end;
--		end;
--		if l_Request_1 == "JunAwakeningClones" then
--			local l_On_54 = v724.On;
--			if not (l_On_54 ~= nil) or l_On_54.Parent == nil then
--				return;
--			else
--				local l_Tags_1 = v724.Tags;
--				local l_Offsets_0 = v724.Offsets;
--				local l_CFrame_37 = l_On_54.HumanoidRootPart.CFrame;
--				local l_RightVector_1 = l_CFrame_37.RightVector;
--				local l_LookVector_3 = l_CFrame_37.LookVector;
--				local v1574 = l_CFrame_37 + l_RightVector_1 * 4.5 + l_LookVector_3 * 4.5;
--				local v1575 = l_CFrame_37 + l_RightVector_1 * -4.5 + l_LookVector_3 * 4.5;
--				local v1576 = l_CFrame_37 + l_RightVector_1 * 4.5 + l_LookVector_3 * -4.5;
--				local v1577 = l_CFrame_37 + l_RightVector_1 * -4.5 + l_LookVector_3 * -4.5;
--				local v1578 = l_CFrame_37 * l_Offsets_0[1];
--				local v1579 = l_CFrame_37 * l_Offsets_0[2];
--				local v1580 = l_CFrame_37 * l_Offsets_0[3];
--				local v1581 = l_CFrame_37 * l_Offsets_0[4];
--				local v1582 = l_CFrame_37 * l_Offsets_0[5];
--				local v1583 = l_CFrame_37 * l_Offsets_0[6];
--				local v1584 = l_CFrame_37 * l_Offsets_0[7];
--				local v1585 = l_CFrame_37 * l_Offsets_0[8];
--				local v1586 = l_CFrame_37 * l_Offsets_0[9];
--				local v1587 = l_CFrame_37 * l_Offsets_0[10];
--				local v1588 = l_CFrame_37 * l_Offsets_0[11];
--				local v1589 = l_CFrame_37 * l_Offsets_0[12];
--				local v1590 = l_CFrame_37 * l_Offsets_0[13];
--				local v1591 = {};
--				for v1592 = 1, #l_Offsets_0 do
--					local v1593 = v0.Instance.new("Attachment");
--					v1593.Name = "JunAwakeningAnimationAttachment" .. v0.tostring(l_Tags_1[v1592]);
--					v1593.Parent = l_On_54.HumanoidRootPart;
--					if v1592 == 1 then
--						v1593.WorldCFrame = v1574;
--						local v1594 = v0.Instance.new("CFrameValue");
--						v1594.Value = l_CFrame_37:ToObjectSpace(v1578);
--						v1594.Parent = v1593;
--					elseif v1592 == 2 then
--						v1593.WorldCFrame = v1575;
--						local v1595 = v0.Instance.new("CFrameValue");
--						v1595.Value = l_CFrame_37:ToObjectSpace(v1579);
--						v1595.Parent = v1593;
--					elseif v1592 == 3 then
--						v1593.WorldCFrame = v1576;
--						local v1596 = v0.Instance.new("CFrameValue");
--						v1596.Value = l_CFrame_37:ToObjectSpace(v1580);
--						v1596.Parent = v1593;
--					elseif v1592 == 4 then
--						v1593.WorldCFrame = v1577;
--						local v1597 = v0.Instance.new("CFrameValue");
--						v1597.Value = l_CFrame_37:ToObjectSpace(v1581);
--						v1597.Parent = v1593;
--					elseif v1592 == 5 then
--						v1593.WorldCFrame = v1582;
--					elseif v1592 == 6 then
--						v1593.WorldCFrame = v1583;
--					elseif v1592 == 7 then
--						v1593.WorldCFrame = v1584;
--					elseif v1592 == 8 then
--						v1593.WorldCFrame = v1585;
--					elseif v1592 == 9 then
--						v1593.WorldCFrame = v1586;
--					elseif v1592 == 10 then
--						v1593.WorldCFrame = v1587;
--					elseif v1592 == 11 then
--						v1593.WorldCFrame = v1588;
--					elseif v1592 == 12 then
--						v1593.WorldCFrame = v1589;
--					elseif v1592 == 13 then
--						v1593.WorldCFrame = v1590;
--					end;
--					v0.table.insert(v1591, v1593);
--				end;
--				local function v1625(v1598, v1599)
--					local v1600 = {};
--					local l_face_0 = v1598.Head:FindFirstChild("face");
--					local l_Mesh_0 = v1598["Right Arm"]:FindFirstChild("Mesh");
--					local l_Mesh_1 = v1598["Left Arm"]:FindFirstChild("Mesh");
--					local l_Mesh_2 = v1598["Right Leg"]:FindFirstChild("Mesh");
--					local l_Mesh_3 = v1598["Left Leg"]:FindFirstChild("Mesh");
--					local l_Mesh_4 = v1598.Torso:FindFirstChild("Mesh");
--					local l_Mesh_5 = v1598.Head:FindFirstChild("Mesh");
--					local l_Color_0 = v1598["Right Arm"].Color;
--					local l_Color_1 = v1598["Left Arm"].Color;
--					local l_Color_2 = v1598["Right Leg"].Color;
--					local l_Color_3 = v1598["Left Leg"].Color;
--					local l_Color_4 = v1598.Head.Color;
--					local l_Color_5 = v1598.Torso.Color;
--					local v1614 = v1599.Torso.Transparency == 1;
--					for _, v1616 in v0.pairs(v1598:GetChildren()) do
--						if not (not v1616:IsA("Accessory") and not v1616:IsA("Shirt") and not v1616:IsA("Pants")) or v1616:IsA("CharacterMesh") then
--							local v1617 = v1616:Clone();
--							if v1614 == true and v1617:IsA("Accessory") then
--								v1617.Handle.Transparency = 1;
--							end;
--							v0.table.insert(v1600, v1617);
--						end;
--					end;
--					for _, v1619 in v0.pairs(v1599:GetChildren()) do
--						if not (not v1619:IsA("Accessory") and not v1619:IsA("Shirt") and not v1619:IsA("Pants")) or v1619:IsA("CharacterMesh") then
--							v1619:Destroy();
--						end;
--						if v1619:IsA("BasePart") and v1619.Name ~= "Head" and v1619.Name ~= "Torso" and v1619.Name ~= "Right Arm" and v1619.Name ~= "Left Arm" and v1619.Name ~= "Right Leg" and v1619.Name ~= "Left Leg" and v1619.Name ~= "HumanoidRootPart" then
--							v1619:Destroy();
--						end;
--						if v1619:IsA("Model") then
--							v1619:Destroy();
--						end;
--					end;
--					if v1599.Head:FindFirstChild("face") then
--						v1599.Head.face:Destroy();
--					end;
--					if v1599.Head:FindFirstChild("Mesh") then
--						v1599.Head.Mesh:Destroy();
--					end;
--					if v1599.Torso:FindFirstChild("Mesh") then
--						v1599.Torso.Mesh:Destroy();
--					end;
--					if v1599["Right Arm"]:FindFirstChild("Mesh") then
--						v1599["Right Arm"].Mesh:Destroy();
--					end;
--					if v1599["Left Arm"]:FindFirstChild("Mesh") then
--						v1599["Left Arm"].Mesh:Destroy();
--					end;
--					if v1599["Right Leg"]:FindFirstChild("Mesh") then
--						v1599["Right Leg"].Mesh:Destroy();
--					end;
--					if v1599["Left Leg"]:FindFirstChild("Mesh") then
--						v1599["Left Leg"].Mesh:Destroy();
--					end;
--					v1599["Right Arm"].Color = l_Color_0;
--					v1599["Left Arm"].Color = l_Color_1;
--					v1599["Right Leg"].Color = l_Color_2;
--					v1599["Left Leg"].Color = l_Color_3;
--					v1599.Head.Color = l_Color_4;
--					v1599.Torso.Color = l_Color_5;
--					for _, v1621 in v0.pairs(v1600) do
--						local v1622 = v1621:Clone();
--						if v1622:IsA("Accessory") and v1622:FindFirstChild("Handle") and v1622:FindFirstChild("Handle"):FindFirstChild("AccessoryWeld") then
--							local l_Name_3 = v1622.Handle.AccessoryWeld.Part1.Name;
--							v1622.Handle.AccessoryWeld.Part0 = v1622.Handle;
--							if v1599:FindFirstChild(l_Name_3) then
--								v1622.Handle.AccessoryWeld.Part1 = v1599:FindFirstChild(l_Name_3);
--							end;
--						end;
--						v1622.Parent = v1599;
--					end;
--					if l_face_0 ~= nil and l_face_0.Parent ~= nil then
--						local v1624 = l_face_0:Clone();
--						if v1614 == true then
--							v1624.Transparency = 1;
--						end;
--						v1624.Parent = v1599.Head;
--					end;
--					if l_Mesh_5 ~= nil and l_Mesh_5.Parent ~= nil then
--						l_Mesh_5:Clone().Parent = v1599.Head;
--					end;
--					if l_Mesh_4 ~= nil and l_Mesh_4.Parent ~= nil then
--						l_Mesh_4:Clone().Parent = v1599.Torso;
--					end;
--					if l_Mesh_0 ~= nil and l_Mesh_0.Parent ~= nil then
--						l_Mesh_0:Clone().Parent = v1599["Right Arm"];
--					end;
--					if l_Mesh_1 ~= nil and l_Mesh_1.Parent ~= nil then
--						l_Mesh_1:Clone().Parent = v1599["Left Arm"];
--					end;
--					if l_Mesh_2 ~= nil and l_Mesh_2.Parent ~= nil then
--						l_Mesh_2:Clone().Parent = v1599["Right Leg"];
--					end;
--					if l_Mesh_3 ~= nil and l_Mesh_3.Parent ~= nil then
--						l_Mesh_3:Clone().Parent = v1599["Left Leg"];
--					end;
--				end;
--				for v1626 = 1, #l_Offsets_0 do
--					local v1627 = l_Assets_0.CharacterStorage.Jun.CloneTemplate:Clone();
--					v1627.Name = "JunAwakeningAnimationClone" .. v0.tostring(l_Tags_1[v1626]);
--					v1625(l_On_54, v1627);
--					local v1628 = nil;
--					v1628 = l_On_54.ChildAdded:Connect(function(v1629)
--						local l_Name_4 = v1629.Name;
--						if v1629.ClassName == "Configuration" and l_Name_4 == "NewHumanoidDescriptionApplied" and l_On_54 ~= nil and l_On_54.Parent ~= nil and v1627 ~= nil and v1627.Parent ~= nil then
--							v1625(l_On_54, v1627);
--						end;
--					end);
--					do
--						local l_v1628_0 = v1628;
--						v0.task.delay(7.5, function()
--							if l_v1628_0 ~= nil then
--								l_v1628_0:Disconnect();
--								l_v1628_0 = nil;
--							end;
--						end);
--						for _, v1633 in v0.pairs(v1627:GetDescendants()) do
--							if v1633:IsA("BasePart") then
--								v1633:SetAttribute("OldTransparency", v1633.Transparency);
--								v1633.Transparency = 1;
--								v1633.CollisionGroup = "Non-Collidable Characters";
--								v1633.CanCollide = false;
--							end;
--							if v1633:IsA("Decal") then
--								v1633:SetAttribute("OldTransparency", v1633.Transparency);
--								v1633.Transparency = 1;
--							end;
--						end;
--						local v1634 = v0.Instance.new("RigidConstraint");
--						v1634.Parent = v1627;
--						v1634.Attachment0 = v1627.HumanoidRootPart.RootAttachment;
--						v1627.Parent = l_VFX_0;
--						v1634.Attachment1 = v1591[v1626];
--					end;
--				end;
--				v1591 = nil;
--			end;
--		end;
--		if l_Request_1 == "JunAwakeningBP" then
--			local v1635 = v0.Instance.new("BodyPosition");
--			v1635.D = 12;
--			v1635.P = 70;
--			v1635.MaxForce = v0.Vector3.new(100000, 100000, 100000);
--			v1635.Position = v724.R;
--			v1635.Parent = l_HumanoidRootPart_0;
--			local l_v1635_0 = v1635 --[[ copy: 2 -> 424 ]];
--			VFXService.CreateBind(v26, "JunAwakeningBodyPosition", function()
--				if l_v1635_0 ~= nil and l_v1635_0.Parent ~= nil then
--					l_v1635_0:Destroy();
--				end;
--			end);
--		end;
--		if l_Request_1 == "JunAwakeningFaceCameraDirection" then
--			local v1637 = nil;
--			local v1638 = nil;
--			do
--				local l_v1637_0, l_v1638_0 = v1637, v1638;
--				l_v1637_0 = v0.task.spawn(function()
--					local l_R_0 = v724.R;
--					local v1642 = v0.CFrame.new(l_R_0);
--					local l_v26_2 = v26;
--					local l_l_v26_2_Pivot_0 = l_v26_2:GetPivot();
--					local v1645 = v0.os.clock();
--					while true do
--						if l_v26_2 ~= nil and l_v26_2.Parent ~= nil then
--							local l_LookVector_4 = l_CurrentCamera_1.CFrame.LookVector;
--							local v1647 = nil;
--							v1647 = if l_LookVector_4 ~= v0.Vector3.zero then v0.CFrame.new(l_R_0, l_R_0 + l_LookVector_4) else v1642;
--							local v1648 = v0.os.clock() - v1645;
--							if v1648 < 0.57 then
--								l_v26_2:PivotTo(l_l_v26_2_Pivot_0:Lerp(v1647, (l_TweenService_0:GetValue(v1648 / 0.57, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out))));
--								v0.task.wait();
--							else
--								l_v1638_0 = v0.task.spawn(function()
--									while l_v26_2 ~= nil and l_v26_2.Parent ~= nil do
--										local l_LookVector_5 = l_CurrentCamera_1.CFrame.LookVector;
--										if l_LookVector_5 ~= v0.Vector3.zero then
--											l_v26_2:PivotTo(v0.CFrame.new(l_R_0, l_R_0 + l_LookVector_5));
--										else
--											l_v26_2:PivotTo(v1642);
--										end;
--										v0.task.wait();
--									end;
--								end);
--								return;
--							end;
--						else
--							return;
--						end;
--					end;
--				end);
--				VFXService.CreateBind(v26, "JunAwakeningFaceCameraDirection", function()
--					v0.pcall(function()
--						v0.task.cancel(l_v1637_0);
--					end);
--					v0.pcall(function()
--						v0.task.cancel(l_v1638_0);
--					end);
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndJunAwakeningFaceCameraDirection" then
--			VFXService.DestroyBind(v26, "JunAwakeningFaceCameraDirection");
--			VFXService.DestroyBind(v26, "JunAwakeningBodyPosition");
--		end;
--		if l_Request_1 == "VirguleCascadeVictimFly" then
--			local l_On_55 = v724.On;
--			if not (l_On_55 ~= nil) or l_On_55.Parent == nil then
--				return;
--			else
--				local l_S_1 = v724.S;
--				local l_E_0 = v724.E;
--				local l_T_3 = v724.T;
--				local v1658 = v0.Instance.new("CFrameValue");
--				v1658.Value = l_S_1;
--				local v1659 = nil;
--				local l_l_On_55_0 = l_On_55 --[[ copy: 2 -> 421 ]];
--				local l_v1658_0 = v1658 --[[ copy: 6 -> 422 ]];
--				v1659 = v0.task.spawn(function()
--					while l_l_On_55_0 ~= nil and l_l_On_55_0.Parent ~= nil do
--						l_l_On_55_0:PivotTo(l_v1658_0.Value);
--						v0.task.wait();
--					end;
--				end);
--				do
--					local l_v1659_0 = v1659;
--					local _ = VFXService.CreateBind(l_On_55, "VirguleCascadeVictimFly", function()
--						v0.pcall(function()
--							v0.task.cancel(l_v1659_0);
--						end);
--					end);
--					l_TweenService_0:Create(v1658, v0.TweenInfo.new(l_T_3, v0.Enum.EasingStyle.Linear), {
--						Value = l_E_0
--					}):Play();
--				end;
--			end;
--		end;
--		if l_Request_1 == "VirguleCascadeDagger" then
--			local v1664 = v0.CFrame.Angles(v0.math.pi / 2, 0, 0);
--			local v1665 = v724.S * v1664;
--			local v1666 = v724.E * v1664;
--			local l_T_4 = v724.T;
--			local v1668 = l_Assets_0.Parts.Jun.KunaiProjectile:Clone();
--			v1668.Name = "VirguleCascadeDagger" .. v0.tostring(v724.Tag);
--			v1668.CFrame = v1665;
--			local v1669 = l_TweenService_0:Create(v1668, v0.TweenInfo.new(l_T_4, v0.Enum.EasingStyle.Linear), {
--				CFrame = v1666
--			});
--			local l_v1668_0 = v1668 --[[ copy: 6 -> 420 ]];
--			v1669.Completed:Connect(function()
--				if l_v1668_0 ~= nil and l_v1668_0.Parent ~= nil then
--					l_v1668_0:Destroy();
--				end;
--			end);
--			v1668.Parent = l_VFX_0;
--			v1669:Play();
--		end;
--		if l_Request_1 == "EndVirguleCascadeDagger" then
--			local v1671 = nil;
--			local v1672 = v0.tostring(v724.Tag);
--			for _, v1674 in v0.pairs(l_VFX_0:GetChildren()) do
--				if v1674.Name == "VirguleCascadeDagger" .. v1672 then
--					v1671 = v1674;
--					break;
--				end;
--			end;
--			if v1671 ~= nil and v1671.Parent ~= nil then
--				v1671:Destroy();
--			end;
--		end;
--		if l_Request_1 == "VirguleCascadeKunai" then
--			local v1675 = v0.CFrame.Angles(v0.math.pi / 2, 0, 0);
--			local v1676 = v724.S * v1675;
--			local v1677 = v724.E * v1675;
--			local l_T_5 = v724.T;
--			local v1679 = l_Assets_0.Parts.Jun.KunaiProjectile:Clone();
--			v1679.Name = "VirguleCascadeKunai" .. v0.tostring(v724.Tag);
--			v1679.CFrame = v1676;
--			local v1680 = l_TweenService_0:Create(v1679, v0.TweenInfo.new(l_T_5, v0.Enum.EasingStyle.Linear), {
--				CFrame = v1677
--			});
--			v1679.Parent = l_VFX_0;
--			v1680:Play();
--		end;
--		if l_Request_1 == "EndVirguleCascadeKunai" then
--			local v1681 = nil;
--			local v1682 = v0.tostring(v724.Tag);
--			for _, v1684 in v0.pairs(l_VFX_0:GetChildren()) do
--				if v1684.Name == "VirguleCascadeKunai" .. v1682 then
--					v1681 = v1684;
--					break;
--				end;
--			end;
--			if v1681 ~= nil and v1681.Parent ~= nil then
--				v1681:Destroy();
--			end;
--		end;
--		if l_Request_1 == "EndGlimpseOfPowerVariantCamera" then
--			VFXService.EndImpactFrameSequences();
--			VFXService.ScreenFlash();
--			l_CurrentCamera_1.CFrame = (l_HumanoidRootPart_0.CFrame - l_HumanoidRootPart_0.CFrame.LookVector * 3 + v0.Vector3.new(0, 8, 0)) * v0.CFrame.Angles(-v0.math.pi / 8, 0, 0);
--			VFXService.EndCutscene();
--			VFXService.ShakeCamera(0, 0.8, 29, 0.725, 0.75, 0.725);
--		end;
--		if l_Request_1 == "GlimpseOfPowerVariantCameraU" then
--			VFXService.EndCameraShake();
--			local _, v1686 = VFXService.InitiateCutscene("GlimpseOfPowerVariant", 60, 109092860448129, l_HumanoidRootPart_0, nil, {
--				Time = 0.3
--			});
--			VFXService.PreloadImages({
--				"rbxassetid://113394966894473", 
--				"rbxassetid://86285216829285", 
--				"rbxassetid://103616032548728", 
--				"rbxassetid://121112678140004", 
--				"rbxassetid://131065967186839", 
--				"rbxassetid://102860434347335", 
--				"rbxassetid://110160263406907", 
--				"rbxassetid://107611510062145", 
--				"rbxassetid://18711801569", 
--				"rbxassetid://113936969708446", 
--				"rbxassetid://107438987216882", 
--				"rbxassetid://131971243187943", 
--				"rbxassetid://126791259145895", 
--				"rbxassetid://103625185927288", 
--				"rbxassetid://72642107125123", 
--				"rbxassetid://101709789324128", 
--				"rbxassetid://134424522598525", 
--				"rbxassetid://108283111280306", 
--				"rbxassetid://129618235518499", 
--				"rbxassetid://108631799376338", 
--				"rbxassetid://130712490005682", 
--				"rbxassetid://115887383841105", 
--				"rbxassetid://107322989120493", 
--				"rbxassetid://106902928070568"
--			});
--			local v1687 = {
--				113394966894473, 
--				86285216829285, 
--				103616032548728, 
--				121112678140004, 
--				131065967186839, 
--				102860434347335, 
--				110160263406907, 
--				107611510062145, 
--				113936969708446, 
--				107438987216882, 
--				131971243187943, 
--				89362777761305, 
--				126791259145895, 
--				103625185927288, 
--				72642107125123, 
--				101709789324128, 
--				134424522598525, 
--				108283111280306, 
--				129618235518499, 
--				108631799376338, 
--				130712490005682, 
--				115887383841105, 
--				107322989120493, 
--				106902928070568
--			};
--			local v1688 = {
--				110160263406907, 
--				107611510062145, 
--				113936969708446, 
--				107438987216882, 
--				131971243187943, 
--				89362777761305, 
--				126791259145895, 
--				103625185927288, 
--				72642107125123, 
--				101709789324128, 
--				134424522598525, 
--				108283111280306, 
--				129618235518499, 
--				108631799376338, 
--				130712490005682, 
--				115887383841105, 
--				107322989120493, 
--				106902928070568
--			};
--			local l_v1687_0 = v1687 --[[ copy: 4 -> 418 ]];
--			local l_v1688_0 = v1688 --[[ copy: 5 -> 419 ]];
--			v1686:GetMarkerReachedSignal("Frames"):Connect(function()
--				VFXService.ImpactFrameSequence(l_v1687_0);
--				if v88.PhotosensitiveMode == false then
--					local v1691 = VFXService.ImpactFrameSequence(l_v1687_0, nil, false);
--					v0.task.delay(4, function()
--						if v1691 ~= nil and v1691.Parent ~= nil then
--							v1691:Destroy();
--						end;
--					end);
--					return;
--				else
--					local v1692 = VFXService.ImpactFrameSequence(l_v1688_0, nil, false);
--					v0.task.delay(4, function()
--						if v1692 ~= nil and v1692.Parent ~= nil then
--							v1692:Destroy();
--						end;
--					end);
--					return;
--				end;
--			end);
--			v104.PlaySound("GlimpseOfPowerVariantFinisherXray");
--		end;
--		if l_Request_1 == "GlimpseOfPowerVariantCamera" then
--			local l_On_56 = v724.On;
--			if not (l_On_56 ~= nil) or l_On_56.Parent == nil then
--				return;
--			else
--				VFXService.EndCameraShake();
--				local _, v1695 = VFXService.InitiateCutscene("GlimpseOfPowerVariant", 60, 109092860448129, l_On_56, nil, {
--					Time = 0.3
--				});
--				VFXService.PreloadImages({
--					"rbxassetid://113394966894473", 
--					"rbxassetid://86285216829285", 
--					"rbxassetid://103616032548728", 
--					"rbxassetid://121112678140004", 
--					"rbxassetid://131065967186839", 
--					"rbxassetid://102860434347335", 
--					"rbxassetid://110160263406907", 
--					"rbxassetid://107611510062145", 
--					"rbxassetid://18711801569", 
--					"rbxassetid://113936969708446", 
--					"rbxassetid://107438987216882", 
--					"rbxassetid://131971243187943", 
--					"rbxassetid://126791259145895", 
--					"rbxassetid://103625185927288", 
--					"rbxassetid://72642107125123", 
--					"rbxassetid://101709789324128", 
--					"rbxassetid://134424522598525", 
--					"rbxassetid://108283111280306", 
--					"rbxassetid://129618235518499", 
--					"rbxassetid://108631799376338", 
--					"rbxassetid://130712490005682", 
--					"rbxassetid://115887383841105", 
--					"rbxassetid://107322989120493", 
--					"rbxassetid://106902928070568"
--				});
--				local v1696 = {
--					113394966894473, 
--					86285216829285, 
--					103616032548728, 
--					121112678140004, 
--					131065967186839, 
--					102860434347335, 
--					110160263406907, 
--					107611510062145, 
--					113936969708446, 
--					107438987216882, 
--					131971243187943, 
--					89362777761305, 
--					126791259145895, 
--					103625185927288, 
--					72642107125123, 
--					101709789324128, 
--					134424522598525, 
--					108283111280306, 
--					129618235518499, 
--					108631799376338, 
--					130712490005682, 
--					115887383841105, 
--					107322989120493, 
--					106902928070568
--				};
--				local v1697 = {
--					110160263406907, 
--					107611510062145, 
--					113936969708446, 
--					107438987216882, 
--					131971243187943, 
--					89362777761305, 
--					126791259145895, 
--					103625185927288, 
--					72642107125123, 
--					101709789324128, 
--					134424522598525, 
--					108283111280306, 
--					129618235518499, 
--					108631799376338, 
--					130712490005682, 
--					115887383841105, 
--					107322989120493, 
--					106902928070568
--				};
--				local l_v1696_0 = v1696 --[[ copy: 5 -> 416 ]];
--				local l_v1697_0 = v1697 --[[ copy: 6 -> 417 ]];
--				v1695:GetMarkerReachedSignal("Frames"):Connect(function()
--					VFXService.ImpactFrameSequence(l_v1696_0);
--					if v88.PhotosensitiveMode == false then
--						local v1700 = VFXService.ImpactFrameSequence(l_v1696_0, nil, false);
--						v0.task.delay(4, function()
--							if v1700 ~= nil and v1700.Parent ~= nil then
--								v1700:Destroy();
--							end;
--						end);
--						return;
--					else
--						local v1701 = VFXService.ImpactFrameSequence(l_v1697_0, nil, false);
--						v0.task.delay(4, function()
--							if v1701 ~= nil and v1701.Parent ~= nil then
--								v1701:Destroy();
--							end;
--						end);
--						return;
--					end;
--				end);
--				v104.PlaySound("GlimpseOfPowerVariantFinisherXray");
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerVariantUppercut" then
--			local l_On_57 = v724.On;
--			if not (l_On_57 ~= nil) or l_On_57.Parent == nil then
--				return;
--			else
--				local v1703 = l_Assets_0.Particles.Jun.GlimpseOfPowerVariant.Uppercut:Clone();
--				v1703.CFrame = l_On_57.HumanoidRootPart.CFrame * v0.CFrame.new(-0.122283936, -2.86486626, -1.26635742, 1, 0, 0, 0, 1, 0, 0, 0, 1);
--				v1703.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v1703);
--				if (v1703.Position - l_HumanoidRootPart_0.Position).Magnitude <= 20 then
--					VFXService.ShakeCamera(0, 0.5, 28, 0.44, 0.44, 0.44);
--				end;
--				if v724.F == true then
--					v104.PlaySoundAtCFrame(l_On_57.HumanoidRootPart.CFrame, "GlimpseOfPowerVariantFinisherLastHit");
--				end;
--				VFXService.DestroyParticleContainer(v1703, 3);
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerVariantUppercutContact" then
--			local l_On_58 = v724.On;
--			if not (l_On_58 ~= nil) or l_On_58.Parent == nil then
--				return;
--			else
--				local v1705 = l_Assets_0.Particles.Jun.GlimpseOfPowerVariant.UppercutContact:Clone();
--				v1705.CFrame = l_On_58.HumanoidRootPart.CFrame * v0.CFrame.new(-0.122283936, -2.86486626, -1.26635742, 1, 0, 0, 0, 1, 0, 0, 0, 1);
--				v1705.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v1705);
--				if v724.F == true then
--					v104.PlaySoundAtCFrame(l_On_58.HumanoidRootPart.CFrame, "GlimpseOfPowerVariantFinisherUppercutContact");
--				end;
--				if (v1705.Position - l_HumanoidRootPart_0.Position).Magnitude <= 20 then
--					VFXService.ShakeCamera(0, 0.4, 24.6, 0.42, 0.42, 0.42);
--				end;
--				VFXService.DestroyParticleContainer(v1705, 3);
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerVariantContact" then
--			local l_On_59 = v724.On;
--			if not (l_On_59 ~= nil) or l_On_59.Parent == nil then
--				return;
--			else
--				local v1707 = l_Assets_0.Particles.Jun.GlimpseOfPowerVariant.Contact:Clone();
--				v1707.CFrame = l_On_59.HumanoidRootPart.CFrame;
--				v1707.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v1707);
--				if (v1707.Position - l_HumanoidRootPart_0.Position).Magnitude <= 20 then
--					VFXService.ShakeCamera(0, 0.2, 12.5, 0.3, 0.3, 0.3);
--				end;
--				VFXService.DestroyParticleContainer(v1707, 3);
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerVariantHit6" then
--			local l_On_60 = v724.On;
--			if not (l_On_60 ~= nil) or l_On_60.Parent == nil then
--				return;
--			else
--				local v1709 = l_Assets_0.Particles.Jun.GlimpseOfPowerVariant.Kick:Clone();
--				v1709.CFrame = l_On_60.HumanoidRootPart.CFrame;
--				v1709.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v1709);
--				if (v1709.Position - l_HumanoidRootPart_0.Position).Magnitude <= 20 then
--					VFXService.ShakeCamera(0, 0.3, 15, 0.3, 0.3, 0.3);
--				end;
--				VFXService.DestroyParticleContainer(v1709, 3);
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerVariantHit5" then
--			local l_On_61 = v724.On;
--			if not (l_On_61 ~= nil) or l_On_61.Parent == nil then
--				return;
--			else
--				local v1711 = v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Cubic, v0.Enum.EasingDirection.Out);
--				local v1712 = v0.TweenInfo.new(0.7, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out);
--				local v1713 = v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out);
--				local v1714 = l_Assets_0.Particles.Jun.GlimpseOfPowerVariant.DownKickMesh:Clone();
--				v1714.CFrame = l_On_61.HumanoidRootPart.CFrame * v0.CFrame.new(-0.0244445801, 0.17137146, -0.0148925781, 1, 0, 0, 0, 1, 0, 0, 0, 1);
--				v1714.Mesh.Scale = v0.Vector3.new(0.005, 0.053, 0.005);
--				v1714.Transparency = 0.9;
--				v1714.Decal.Transparency = 0;
--				local v1715 = l_TweenService_0:Create(v1714.Mesh, v1711, {
--					Scale = v0.Vector3.new(0.031, 0.013, 0.031)
--				});
--				local v1716 = l_TweenService_0:Create(v1714.Decal, v1712, {
--					Transparency = 1
--				});
--				local v1717 = l_TweenService_0:Create(v1714, v1713, {
--					Transparency = 1, 
--					Position = v1714.Position - v0.Vector3.new(0, 2, 0)
--				});
--				local l_v1714_0 = v1714 --[[ copy: 6 -> 415 ]];
--				v1716.Completed:Connect(function()
--					if l_v1714_0 ~= nil and l_v1714_0.Parent ~= nil then
--						l_v1714_0:Destroy();
--					end;
--				end);
--				v1714.Parent = l_VFX_0;
--				local v1719 = l_Assets_0.Particles.Jun.GlimpseOfPowerVariant.Kick:Clone();
--				v1719.CFrame = l_On_61.HumanoidRootPart.CFrame;
--				v1719.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v1719);
--				v1715:Play();
--				v1716:Play();
--				v1717:Play();
--				if (v1719.Position - l_HumanoidRootPart_0.Position).Magnitude <= 20 then
--					VFXService.ShakeCamera(0, 0.2, 15, 0.3, 0.3, 0.3);
--				end;
--				VFXService.DestroyParticleContainer(v1719, 3);
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerVariantHit4" then
--			local l_On_62 = v724.On;
--			v0.task.wait(0.025);
--			if not (l_On_62 ~= nil) or l_On_62.Parent == nil then
--				return;
--			else
--				local v1721 = l_Assets_0.Particles.Jun.GlimpseOfPowerVariant.Kick:Clone();
--				v1721.CFrame = l_On_62.HumanoidRootPart.CFrame;
--				v1721.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v1721);
--				if (v1721.Position - l_HumanoidRootPart_0.Position).Magnitude <= 20 then
--					VFXService.ShakeCamera(0, 0.2, 15, 0.3, 0.3, 0.3);
--				end;
--				VFXService.DestroyParticleContainer(v1721, 3);
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerVariantHit3" then
--			local l_On_63 = v724.On;
--			if not (l_On_63 ~= nil) or l_On_63.Parent == nil then
--				return;
--			else
--				local v1723 = v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Cubic, v0.Enum.EasingDirection.Out);
--				local v1724 = v0.TweenInfo.new(0.7, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.In);
--				local v1725 = v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.In);
--				local v1726 = l_Assets_0.Particles.Jun.GlimpseOfPowerVariant.DownKickMesh:Clone();
--				v1726.CFrame = l_On_63.HumanoidRootPart.CFrame * v0.CFrame.new(-0.0244445801, 0.17137146, -0.0148925781, 1, 0, 0, 0, 1, 0, 0, 0, 1);
--				v1726.Mesh.Scale = v0.Vector3.new(0.005, 0.053, 0.005);
--				v1726.Transparency = 0.9;
--				v1726.Decal.Transparency = 0;
--				local v1727 = l_TweenService_0:Create(v1726.Mesh, v1723, {
--					Scale = v0.Vector3.new(0.031, 0.013, 0.031)
--				});
--				local v1728 = l_TweenService_0:Create(v1726.Decal, v1724, {
--					Transparency = 1
--				});
--				local v1729 = l_TweenService_0:Create(v1726, v1725, {
--					Transparency = 1, 
--					Position = v1726.Position - v0.Vector3.new(0, 2, 0)
--				});
--				local l_v1726_0 = v1726 --[[ copy: 6 -> 414 ]];
--				v1728.Completed:Connect(function()
--					if l_v1726_0 ~= nil and l_v1726_0.Parent ~= nil then
--						l_v1726_0:Destroy();
--					end;
--				end);
--				v1726.Parent = l_VFX_0;
--				local v1731 = l_Assets_0.Particles.Jun.GlimpseOfPowerVariant.Kick:Clone();
--				v1731.CFrame = l_On_63.HumanoidRootPart.CFrame;
--				v1731.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v1731);
--				v1727:Play();
--				v1728:Play();
--				v1729:Play();
--				if (v1731.Position - l_HumanoidRootPart_0.Position).Magnitude <= 20 then
--					VFXService.ShakeCamera(0, 0.2, 15, 0.3, 0.3, 0.3);
--				end;
--				VFXService.DestroyParticleContainer(v1731, 3);
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerVariantHit2" then
--			local l_On_64 = v724.On;
--			if not (l_On_64 ~= nil) or l_On_64.Parent == nil then
--				return;
--			else
--				local v1733 = v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Cubic, v0.Enum.EasingDirection.Out);
--				local v1734 = v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Linear);
--				local v1735 = l_Assets_0.Particles.Jun.GlimpseOfPowerVariant.GroundMesh:Clone();
--				v1735.CFrame = l_On_64.HumanoidRootPart.CFrame * v0.CFrame.new(-0.0244445801, -3.19159698, -0.0148925781, 1, 0, 0, 0, 1, 0, 0, 0, 1);
--				v1735.Mesh.Scale = v0.Vector3.new(0.006, 0.007, 0.006);
--				v1735.Transparency = 0;
--				local v1736 = l_TweenService_0:Create(v1735.Mesh, v1733, {
--					Scale = v0.Vector3.new(0.046, 0.037, 0.046)
--				});
--				local v1737 = l_TweenService_0:Create(v1735, v1734, {
--					Transparency = 1, 
--					Orientation = v0.Vector3.new(0, -200, 0)
--				});
--				local l_v1735_0 = v1735 --[[ copy: 5 -> 413 ]];
--				v1737.Completed:Connect(function()
--					if l_v1735_0 ~= nil and l_v1735_0.Parent ~= nil then
--						l_v1735_0:Destroy();
--					end;
--				end);
--				v1735.Parent = l_VFX_0;
--				local v1739 = l_Assets_0.Particles.Jun.GlimpseOfPowerVariant.KickRotated:Clone();
--				v1739.CFrame = l_On_64.HumanoidRootPart.CFrame;
--				v1739.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v1739);
--				v1736:Play();
--				v1737:Play();
--				if (v1739.Position - l_HumanoidRootPart_0.Position).Magnitude <= 20 then
--					VFXService.ShakeCamera(0, 0.2, 15, 0.3, 0.3, 0.3);
--				end;
--				VFXService.DestroyParticleContainer(v1739, 3);
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerVariantHit1" then
--			local l_On_65 = v724.On;
--			if not (l_On_65 ~= nil) or l_On_65.Parent == nil then
--				return;
--			else
--				local v1741 = v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Cubic, v0.Enum.EasingDirection.Out);
--				local v1742 = v0.TweenInfo.new(0.7, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out);
--				local v1743 = v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out);
--				local v1744 = l_Assets_0.Particles.Jun.GlimpseOfPowerVariant.DownKickMesh:Clone();
--				v1744.CFrame = l_On_65.HumanoidRootPart.CFrame * v0.CFrame.new(-0.0244445801, 0.17137146, -0.0148925781, 1, 0, 0, 0, 1, 0, 0, 0, 1);
--				v1744.Mesh.Scale = v0.Vector3.new(0.005, 0.053, 0.005);
--				v1744.Transparency = 0.9;
--				v1744.Decal.Transparency = 0;
--				local v1745 = l_TweenService_0:Create(v1744.Mesh, v1741, {
--					Scale = v0.Vector3.new(0.031, 0.013, 0.031)
--				});
--				local v1746 = l_TweenService_0:Create(v1744.Decal, v1742, {
--					Transparency = 1
--				});
--				local v1747 = l_TweenService_0:Create(v1744, v1743, {
--					Transparency = 1, 
--					Position = v1744.Position - v0.Vector3.new(0, 2, 0)
--				});
--				local l_v1744_0 = v1744 --[[ copy: 6 -> 412 ]];
--				v1746.Completed:Connect(function()
--					if l_v1744_0 ~= nil and l_v1744_0.Parent ~= nil then
--						l_v1744_0:Destroy();
--					end;
--				end);
--				v1744.Parent = l_VFX_0;
--				local v1749 = l_Assets_0.Particles.Jun.GlimpseOfPowerVariant.Kick:Clone();
--				v1749.CFrame = l_On_65.HumanoidRootPart.CFrame;
--				v1749.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v1749);
--				v1745:Play();
--				v1746:Play();
--				v1747:Play();
--				if (v1749.Position - l_HumanoidRootPart_0.Position).Magnitude <= 20 then
--					VFXService.ShakeCamera(0, 0.2, 15, 0.3, 0.3, 0.3);
--				end;
--				VFXService.DestroyParticleContainer(v1749, 3);
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerVariantUserSound" then
--			local l_On_66 = v724.On;
--			if not (l_On_66 ~= nil) or l_On_66.Parent == nil then
--				return;
--			elseif v724.F ~= true then
--				v104.PlaySoundInInstance(l_On_66.HumanoidRootPart, "GlimpseOfPowerVariantUser");
--				v104.PlaySoundInInstance(l_On_66.HumanoidRootPart, "GlimpseOfPowerVariantUser2");
--			else
--				v104.PlaySoundInInstance(l_On_66.HumanoidRootPart, "GlimpseOfPowerVariantUserFinisher");
--				v104.PlaySoundInInstance(l_On_66.HumanoidRootPart, "GlimpseOfPowerVariantUser2");
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerVariantFirstKick" then
--			local l_On_67 = v724.On;
--			if not (l_On_67 ~= nil) or l_On_67.Parent == nil then
--				return;
--			else
--				local v1752 = l_Assets_0.Particles.Jun.GlimpseOfPowerVariant.FirstKick:Clone();
--				v1752.CFrame = l_On_67.HumanoidRootPart.CFrame;
--				v1752.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v1752);
--				if v724.F ~= true then
--					v104.PlaySoundInInstance(l_On_67.HumanoidRootPart, "GlimpseOfPowerVariantVictim");
--				else
--					v104.PlaySoundInInstance(l_On_67.HumanoidRootPart, "GlimpseOfPowerVariantVictimFinisher");
--				end;
--				if (v1752.Position - l_HumanoidRootPart_0.Position).Magnitude <= 20 then
--					VFXService.ShakeCamera(0, 0.4, 22, 0.3, 0.3, 0.3);
--				end;
--				VFXService.DestroyParticleContainer(v1752, 3);
--			end;
--		end;
--		if l_Request_1 == "KratosWallUserSound" then
--			local l_On_68 = v724.On;
--			if not (l_On_68 ~= nil) or l_On_68.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_68.HumanoidRootPart, "KratosWallUser");
--			end;
--		end;
--		if l_Request_1 == "KratosWallVictimSound" then
--			local l_On_69 = v724.On;
--			if not (l_On_69 ~= nil) or l_On_69.Parent == nil then
--				return;
--			elseif v724.Wood == true then
--				v104.PlaySoundInInstance(l_On_69.HumanoidRootPart, "KratosWallVictim");
--			else
--				v104.PlaySoundInInstance(l_On_69.HumanoidRootPart, "KratosWallVictim");
--			end;
--		end;
--		if l_Request_1 == "RampageFuryHit" then
--			local l_On_70 = v724.On;
--			if not (l_On_70 ~= nil) or l_On_70.Parent == nil then
--				return;
--			else
--				local v1756 = v0.tostring(v0.math.random(1, 4));
--				v104.PlaySoundInInstance(l_On_70.Torso, "RampageFuryHit" .. v1756);
--			end;
--		end;
--		if l_Request_1 == "RampageFurySound" then
--			local l_On_71 = v724.On;
--			if not (l_On_71 ~= nil) or l_On_71.Parent == nil then
--				return;
--			else
--				local v1758 = v104.PlaySoundInInstance(l_On_71.HumanoidRootPart, "RampageFury");
--				local v1759 = l_TweenService_0:Create(v1758, v0.TweenInfo.new(0.2, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--					Volume = 0
--				});
--				local l_v1758_0 = v1758 --[[ copy: 3 -> 409 ]];
--				v1759.Completed:Connect(function()
--					if l_v1758_0 ~= nil and l_v1758_0.Parent ~= nil then
--						l_v1758_0:Destroy();
--					end;
--				end);
--				local l_v1759_0 = v1759 --[[ copy: 4 -> 410 ]];
--				local v1762 = VFXService.CreateBind(l_On_71, "RampageFurySound", function()
--					if l_v1758_0 ~= nil and l_v1758_0.Parent ~= nil then
--						l_v1758_0:SetAttribute("DefaultVolume", nil);
--						l_v1759_0:Play();
--					end;
--				end);
--				local l_v1762_0 = v1762 --[[ copy: 5 -> 411 ]];
--				v1758.Ended:Connect(function()
--					if l_v1762_0 ~= nil and l_v1762_0.Parent ~= nil then
--						l_v1762_0:Destroy();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndRampageFurySound" then
--			local l_On_72 = v724.On;
--			if not (l_On_72 ~= nil) or l_On_72.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_72, "RampageFurySound");
--			end;
--		end;
--		if l_Request_1 == "RampageFuryCameraShake2" then
--			local l_On_73 = v724.On;
--			if not (l_On_73 ~= nil) or l_On_73.Parent == nil then
--				return;
--			elseif l_On_73 == v26 then
--				VFXService.ShakeCamera(0, 0.4, 26, 0.3, 0.3, 0.3);
--			elseif (l_On_73.HumanoidRootPart.Position - l_HumanoidRootPart_0.Position).Magnitude <= 61 then
--				VFXService.ShakeCamera(0, 0.4, 26, 0.3, 0.3, 0.3);
--			end;
--		end;
--		if l_Request_1 == "RampageFuryCameraShake" then
--			local l_On_74 = v724.On;
--			if not (l_On_74 ~= nil) or l_On_74.Parent == nil then
--				return;
--			elseif l_On_74 == v26 then
--				VFXService.ShakeCamera(0, 0.5, 6.7, 0.3, 0.3, 0.3);
--			elseif (l_On_74.HumanoidRootPart.Position - l_HumanoidRootPart_0.Position).Magnitude <= 61 then
--				VFXService.ShakeCamera(0, 0.5, 6.7, 0.3, 0.3, 0.3);
--			end;
--		end;
--		if l_Request_1 == "RampageFuryEnable" then
--			local l_On_75 = v724.On;
--			if not (l_On_75 ~= nil) or l_On_75.Parent == nil then
--				return;
--			else
--				local v1768 = v0.tostring(v724.Tag);
--				local v1769 = nil;
--				for _, v1771 in v0.pairs(l_On_75:GetChildren()) do
--					if v1771:IsA("Model") and v1771.Name == "BladesOfChaosRight" .. v1768 then
--						v1769 = v1771;
--						break;
--					end;
--				end;
--				local v1772 = nil;
--				for _, v1774 in v0.pairs(l_On_75:GetChildren()) do
--					if v1774:IsA("Model") and v1774.Name == "BladesOfChaosLeft" .. v1768 then
--						v1772 = v1774;
--						break;
--					end;
--				end;
--				local v1775 = v0.TweenInfo.new(0.3, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out);
--				if v1769 ~= nil and v1769.Parent ~= nil then
--					VFXService.EmitParticlesInInstance(v1769["Right-Blade"].b);
--					for _, v1777 in v0.pairs(v1769:GetDescendants()) do
--						if v1777.Name == "Beam2" and v1777:IsA("Beam") then
--							v1777.Enabled = true;
--						end;
--						if v1777:IsA("Trail") then
--							v1777.Enabled = true;
--						end;
--						if v1777:IsA("PointLight") then
--							if v1777.Parent.Name == "Right-Blade" then
--								v1777.Enabled = true;
--							else
--								l_TweenService_0:Create(v1777, v1775, {
--									Brightness = 1
--								}):Play();
--							end;
--						end;
--						if v1777:IsA("ParticleEmitter") and v1777.Parent.Name == "Right-Blade" then
--							v1777.Enabled = true;
--						end;
--					end;
--				end;
--				if v1772 ~= nil and v1772.Parent ~= nil then
--					VFXService.EmitParticlesInInstance(v1772["Left-Blade"].b);
--					for _, v1779 in v0.pairs(v1772:GetDescendants()) do
--						if v1779.Name == "Beam2" and v1779:IsA("Beam") then
--							v1779.Enabled = true;
--						end;
--						if v1779:IsA("Trail") then
--							v1779.Enabled = true;
--						end;
--						if v1779:IsA("PointLight") then
--							if v1779.Parent.Name == "Left-Blade" then
--								v1779.Enabled = true;
--							else
--								l_TweenService_0:Create(v1779, v1775, {
--									Brightness = 1
--								}):Play();
--							end;
--						end;
--						if v1779:IsA("ParticleEmitter") and v1779.Parent.Name == "Left-Blade" then
--							v1779.Enabled = true;
--						end;
--					end;
--				end;
--				local v1780 = v0.CFrame.new(0, -2.9, 0);
--				local v1781 = l_Assets_0.Particles.Kratos.RampageFury.Enable:Clone();
--				v1781.CFrame = l_On_75.HumanoidRootPart.CFrame * v1780;
--				v1781.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v1781);
--				VFXService.DestroyParticleContainer(v1781, 3);
--			end;
--		end;
--		if l_Request_1 == "RampageFuryFirstSmoke" then
--			local l_On_76 = v724.On;
--			if not (l_On_76 ~= nil) or l_On_76.Parent == nil then
--				return;
--			else
--				local v1783 = v0.CFrame.new(0.0523681641, -2.50000048, -0.370727539, 0.9755795, -0.196364224, 0.0984165221, 0.195372596, 0.980531037, 0.0197092015, -0.100370638, 0, 0.994950116);
--				local v1784 = l_Assets_0.Particles.Kratos.RampageFury.FirstSmoke:Clone();
--				v1784.CFrame = l_On_76.HumanoidRootPart.CFrame * v1783;
--				v1784.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v1784);
--				VFXService.DestroyParticleContainer(v1784, 3);
--			end;
--		end;
--		if l_Request_1 == "RampageFurySecondWind" then
--			local l_On_77 = v724.On;
--			if not (l_On_77 ~= nil) or l_On_77.Parent == nil then
--				return;
--			else
--				local v1786 = v0.CFrame.new(0.0523796082, -2.49998856, -0.370727539, 0.564088225, 0.788767755, -0.244233564, -0.824263334, 0.555429041, -0.109947473, 0.0489313602, 0.263332844, 0.963463485);
--				local v1787 = l_Assets_0.Particles.Kratos.RampageFury.SecondWind:Clone();
--				v1787.CFrame = l_On_77.HumanoidRootPart.CFrame * v1786;
--				v1787.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v1787);
--				VFXService.DestroyParticleContainer(v1787, 3);
--			end;
--		end;
--		if l_Request_1 == "RampageFurySecondSmoke" then
--			local l_On_78 = v724.On;
--			if not (l_On_78 ~= nil) or l_On_78.Parent == nil then
--				return;
--			else
--				local v1789 = v0.CFrame.new(0, -2.9, 0);
--				local v1790 = l_Assets_0.Particles.Kratos.RampageFury.SecondSmoke:Clone();
--				v1790.CFrame = l_On_78.HumanoidRootPart.CFrame * v1789;
--				v1790.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v1790);
--				VFXService.DestroyParticleContainer(v1790, 3);
--			end;
--		end;
--		if l_Request_1 == "RampageFuryThirdWind" then
--			local l_On_79 = v724.On;
--			if not (l_On_79 ~= nil) or l_On_79.Parent == nil then
--				return;
--			else
--				local v1792 = v0.CFrame.new(0.0523872375, -2.49998856, -0.370727539, -0.169861808, 0.969833672, 0.174841419, -0.976668954, -0.18933025, 0.101349562, 0.131394997, -0.15354678, 0.979366481);
--				local v1793 = l_Assets_0.Particles.Kratos.RampageFury.ThirdWind:Clone();
--				v1793.CFrame = l_On_79.HumanoidRootPart.CFrame * v1792;
--				v1793.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v1793);
--				VFXService.DestroyParticleContainer(v1793, 3);
--			end;
--		end;
--		if l_Request_1 == "RampageFuryLastSmoke" then
--			local l_On_80 = v724.On;
--			if not (l_On_80 ~= nil) or l_On_80.Parent == nil then
--				return;
--			else
--				local v1795 = v0.CFrame.new(0, -2.9, 0);
--				local v1796 = l_Assets_0.Particles.Kratos.RampageFury.LastSmoke:Clone();
--				v1796.CFrame = l_On_80.HumanoidRootPart.CFrame * v1795;
--				v1796.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v1796);
--				VFXService.DestroyParticleContainer(v1796, 3);
--			end;
--		end;
--		if l_Request_1 == "RampageFuryEnableS11" then
--			local l_On_81 = v724.On;
--			if not (l_On_81 ~= nil) or l_On_81.Parent == nil then
--				return;
--			else
--				local v1798 = v0.CFrame.new(0, -2.9, 0);
--				local v1799 = l_Assets_0.Particles.Kratos.RampageFury.S11:Clone();
--				local v1800 = v0.Instance.new("WeldConstraint");
--				v1800.Parent = v1799;
--				v1800.Part0 = l_On_81.HumanoidRootPart;
--				v1799.Parent = l_VFX_0;
--				v1799.CFrame = l_On_81.HumanoidRootPart.CFrame * v1798;
--				v1800.Part1 = v1799;
--				local l_v1800_0 = v1800 --[[ copy: 5 -> 407 ]];
--				local l_v1799_0 = v1799 --[[ copy: 4 -> 408 ]];
--				VFXService.CreateBind(l_On_81, "RampageFuryS11Effect", function()
--					if l_v1800_0 ~= nil and l_v1800_0.Parent ~= nil then
--						l_v1800_0:Destroy();
--					end;
--					if l_v1799_0 ~= nil and l_v1799_0.Parent ~= nil then
--						l_v1799_0.Anchored = true;
--						for _, v1804 in v0.pairs(l_v1799_0:GetDescendants()) do
--							if v1804:isA("ParticleEmitter") then
--								v1804.Enabled = false;
--							end;
--						end;
--						v0.task.delay(3, function()
--							if l_v1799_0 ~= nil and l_v1799_0.Parent ~= nil then
--								l_v1799_0:Destroy();
--							end;
--						end);
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "RampageFuryDisableS11" then
--			local l_On_82 = v724.On;
--			if not (l_On_82 ~= nil) or l_On_82.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_82, "RampageFuryS11Effect");
--			end;
--		end;
--		if l_Request_1 == "RampageFuryEnableWP" then
--			local l_On_83 = v724.On;
--			if not (l_On_83 ~= nil) or l_On_83.Parent == nil then
--				return;
--			else
--				local v1807 = l_Assets_0.Particles.Kratos.RampageFury.WP:Clone();
--				local v1808 = v0.Instance.new("WeldConstraint");
--				v1808.Parent = v1807;
--				v1808.Part0 = l_On_83.HumanoidRootPart;
--				v1807.Parent = l_VFX_0;
--				v1807.CFrame = l_On_83.HumanoidRootPart.CFrame;
--				v1808.Part1 = v1807;
--				local l_v1808_0 = v1808 --[[ copy: 4 -> 405 ]];
--				local l_v1807_0 = v1807 --[[ copy: 3 -> 406 ]];
--				VFXService.CreateBind(l_On_83, "RampageFuryWPEffect", function()
--					if l_v1808_0 ~= nil and l_v1808_0.Parent ~= nil then
--						l_v1808_0:Destroy();
--					end;
--					if l_v1807_0 ~= nil and l_v1807_0.Parent ~= nil then
--						l_v1807_0.Anchored = true;
--						for _, v1812 in v0.pairs(l_v1807_0:GetDescendants()) do
--							if v1812:isA("ParticleEmitter") then
--								v1812.Enabled = false;
--							end;
--						end;
--						v0.task.delay(3, function()
--							if l_v1807_0 ~= nil and l_v1807_0.Parent ~= nil then
--								l_v1807_0:Destroy();
--							end;
--						end);
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "RampageFuryDisableWP" then
--			local l_On_84 = v724.On;
--			if not (l_On_84 ~= nil) or l_On_84.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_84, "RampageFuryWPEffect");
--			end;
--		end;
--		if l_Request_1 == "RampageFuryFade" then
--			local l_On_85 = v724.On;
--			if not (l_On_85 ~= nil) or l_On_85.Parent == nil then
--				return;
--			else
--				local v1815 = v0.tostring(v724.Tag);
--				local v1816 = nil;
--				for _, v1818 in v0.pairs(l_On_85:GetChildren()) do
--					if v1818:IsA("Model") and v1818.Name == "BladesOfChaosRight" .. v1815 then
--						v1816 = v1818;
--						break;
--					end;
--				end;
--				local v1819 = nil;
--				for _, v1821 in v0.pairs(l_On_85:GetChildren()) do
--					if v1821:IsA("Model") and v1821.Name == "BladesOfChaosLeft" .. v1815 then
--						v1819 = v1821;
--						break;
--					end;
--				end;
--				local v1822 = v0.TweenInfo.new(0.3, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out);
--				if v1816 ~= nil and v1816.Parent ~= nil then
--					for _, v1824 in v0.pairs(v1816:GetDescendants()) do
--						if v1824:IsA("PointLight") then
--							l_TweenService_0:Create(v1824, v1822, {
--								Brightness = 0
--							}):Play();
--						end;
--					end;
--				end;
--				if v1819 ~= nil and v1819.Parent ~= nil then
--					for _, v1826 in v0.pairs(v1819:GetDescendants()) do
--						if v1826:IsA("PointLight") then
--							l_TweenService_0:Create(v1826, v1822, {
--								Brightness = 0
--							}):Play();
--						end;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "RampageFuryDisable" then
--			local l_On_86 = v724.On;
--			if not (l_On_86 ~= nil) or l_On_86.Parent == nil then
--				return;
--			else
--				local v1828 = v0.tostring(v724.Tag);
--				local v1829 = nil;
--				for _, v1831 in v0.pairs(l_On_86:GetChildren()) do
--					if v1831:IsA("Model") and v1831.Name == "BladesOfChaosRight" .. v1828 then
--						v1829 = v1831;
--						break;
--					end;
--				end;
--				local v1832 = nil;
--				for _, v1834 in v0.pairs(l_On_86:GetChildren()) do
--					if v1834:IsA("Model") and v1834.Name == "BladesOfChaosLeft" .. v1828 then
--						v1832 = v1834;
--						break;
--					end;
--				end;
--				if v1829 ~= nil and v1829.Parent ~= nil then
--					for _, v1836 in v0.pairs(v1829:GetDescendants()) do
--						if not (not v1836:IsA("ParticleEmitter") and not v1836:IsA("Trail")) or v1836:IsA("Beam") then
--							v1836.Enabled = false;
--						end;
--					end;
--				end;
--				if v1832 ~= nil and v1832.Parent ~= nil then
--					for _, v1838 in v0.pairs(v1832:GetDescendants()) do
--						if not (not v1838:IsA("ParticleEmitter") and not v1838:IsA("Trail")) or v1838:IsA("Beam") then
--							v1838.Enabled = false;
--						end;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "RampageFuryGroundScratch1" then
--			local l_On_87 = v724.On;
--			if not (l_On_87 ~= nil) or l_On_87.Parent == nil then
--				return;
--			else
--				local v1840 = v0.CFrame.new(-10.7792053, -2.53428888, -10.5270996, -0.760385692, 0, 0.649472058, 0, 0.99999994, 0, -0.649472058, 0, -0.760385692);
--				local v1841 = l_Assets_0.Particles.Kratos.RampageFury.GroundScratches.Scratch1:Clone();
--				v1841.CFrame = l_On_87.HumanoidRootPart.CFrame * v1840;
--				local v1842 = VFXService.FindGroundPosition(v1841.Position + v0.Vector3.new(0, 1, 0), 2);
--				if v1842 then
--					local v1843 = v1842.Position + v0.Vector3.new(0, 0.4, 0);
--					v1841.Position = v1843;
--					v1841.Parent = l_VFX_0;
--					local v1844 = v0.tostring(v0.math.random(1, 5));
--					v104.PlaySoundAtCFrame(v0.CFrame.new(v1843), "RampageFuryFloorHit" .. v1844);
--					VFXService.EmitParticlesInInstance(v1841);
--					VFXService.DestroyParticleContainer(v1841, 2);
--				else
--					v1841:Destroy();
--				end;
--			end;
--		end;
--		if l_Request_1 == "RampageFuryGroundScratch2" then
--			local l_On_88 = v724.On;
--			if not (l_On_88 ~= nil) or l_On_88.Parent == nil then
--				return;
--			else
--				local v1846 = v0.CFrame.new(2.54732513, -2.53428888, -13.1057281, 0.981506407, 0, -0.191429585, 0, 1, 0, 0.191429585, 0, 0.981506407);
--				local v1847 = l_Assets_0.Particles.Kratos.RampageFury.GroundScratches.Scratch2:Clone();
--				v1847.CFrame = l_On_88.HumanoidRootPart.CFrame * v1846;
--				local v1848 = VFXService.FindGroundPosition(v1847.Position + v0.Vector3.new(0, 1, 0), 2);
--				if v1848 then
--					local v1849 = v1848.Position + v0.Vector3.new(0, 0.4, 0);
--					v1847.Position = v1849;
--					v1847.Parent = l_VFX_0;
--					local v1850 = v0.tostring(v0.math.random(1, 5));
--					v104.PlaySoundAtCFrame(v0.CFrame.new(v1849), "RampageFuryFloorHit" .. v1850);
--					VFXService.EmitParticlesInInstance(v1847);
--					VFXService.DestroyParticleContainer(v1847, 2);
--				else
--					v1847:Destroy();
--				end;
--			end;
--		end;
--		if l_Request_1 == "RampageFuryGroundScratch3" then
--			local l_On_89 = v724.On;
--			if not (l_On_89 ~= nil) or l_On_89.Parent == nil then
--				return;
--			else
--				local v1852 = v0.CFrame.new(-11.9234772, -2.53428888, -5.09893799, -0.996150851, 0, 0.0876561329, 0, 1, 0, -0.0876561329, 0, -0.996150851);
--				local v1853 = l_Assets_0.Particles.Kratos.RampageFury.GroundScratches.Scratch3:Clone();
--				v1853.CFrame = l_On_89.HumanoidRootPart.CFrame * v1852;
--				local v1854 = VFXService.FindGroundPosition(v1853.Position + v0.Vector3.new(0, 1, 0), 2);
--				if v1854 then
--					local v1855 = v1854.Position + v0.Vector3.new(0, 0.4, 0);
--					v1853.Position = v1855;
--					v1853.Parent = l_VFX_0;
--					local v1856 = v0.tostring(v0.math.random(1, 5));
--					v104.PlaySoundAtCFrame(v0.CFrame.new(v1855), "RampageFuryFloorHit" .. v1856);
--					VFXService.EmitParticlesInInstance(v1853);
--					VFXService.DestroyParticleContainer(v1853, 2);
--				else
--					v1853:Destroy();
--				end;
--			end;
--		end;
--		if l_Request_1 == "RampageFuryGroundScratch4" then
--			local l_On_90 = v724.On;
--			if not (l_On_90 ~= nil) or l_On_90.Parent == nil then
--				return;
--			else
--				local v1858 = v0.CFrame.new(1.92780304, -2.53428888, -17.675827, 0.728058338, 0, 0.685515165, 0, 1, 0, -0.685515165, 0, 0.728058338);
--				local v1859 = l_Assets_0.Particles.Kratos.RampageFury.GroundScratches.Scratch4:Clone();
--				v1859.CFrame = l_On_90.HumanoidRootPart.CFrame * v1858;
--				local v1860 = VFXService.FindGroundPosition(v1859.Position + v0.Vector3.new(0, 1, 0), 2);
--				if v1860 then
--					local v1861 = v1860.Position + v0.Vector3.new(0, 0.4, 0);
--					v1859.Position = v1861;
--					v1859.Parent = l_VFX_0;
--					local v1862 = v0.tostring(v0.math.random(1, 5));
--					v104.PlaySoundAtCFrame(v0.CFrame.new(v1861), "RampageFuryFloorHit" .. v1862);
--					VFXService.EmitParticlesInInstance(v1859);
--					VFXService.DestroyParticleContainer(v1859, 2);
--				else
--					v1859:Destroy();
--				end;
--			end;
--		end;
--		if l_Request_1 == "RampageFuryGroundScratch5" then
--			local l_On_91 = v724.On;
--			if not (l_On_91 ~= nil) or l_On_91.Parent == nil then
--				return;
--			else
--				local v1864 = v0.CFrame.new(2.55492783, -2.53428888, -13.3347321, 0.995112658, 0, -0.0987458006, 0, 1, 0, 0.0987458006, 0, 0.995112658);
--				local v1865 = l_Assets_0.Particles.Kratos.RampageFury.GroundScratches.Scratch5:Clone();
--				v1865.CFrame = l_On_91.HumanoidRootPart.CFrame * v1864;
--				local v1866 = VFXService.FindGroundPosition(v1865.Position + v0.Vector3.new(0, 1, 0), 2);
--				if v1866 then
--					local v1867 = v1866.Position + v0.Vector3.new(0, 0.4, 0);
--					v1865.Position = v1867;
--					v1865.Parent = l_VFX_0;
--					local v1868 = v0.tostring(v0.math.random(1, 5));
--					v104.PlaySoundAtCFrame(v0.CFrame.new(v1867), "RampageFuryFloorHit" .. v1868);
--					VFXService.EmitParticlesInInstance(v1865);
--					VFXService.DestroyParticleContainer(v1865, 2);
--				else
--					v1865:Destroy();
--				end;
--			end;
--		end;
--		if l_Request_1 == "RampageFuryGroundScratch6" then
--			local l_On_92 = v724.On;
--			if not (l_On_92 ~= nil) or l_On_92.Parent == nil then
--				return;
--			else
--				local v1870 = v0.CFrame.new(-1.26082993, -2.53428888, -21.4891815, 0.991629303, 0, 0.129118294, 0, 1, 0, -0.129118308, 0, 0.991629362);
--				local v1871 = l_Assets_0.Particles.Kratos.RampageFury.GroundScratches.Scratch6:Clone();
--				v1871.CFrame = l_On_92.HumanoidRootPart.CFrame * v1870;
--				local v1872 = VFXService.FindGroundPosition(v1871.Position + v0.Vector3.new(0, 1, 0), 2);
--				if v1872 then
--					local v1873 = v1872.Position + v0.Vector3.new(0, 0.4, 0);
--					v1871.Position = v1873;
--					v1871.Parent = l_VFX_0;
--					local v1874 = v0.tostring(v0.math.random(1, 5));
--					v104.PlaySoundAtCFrame(v0.CFrame.new(v1873), "RampageFuryFloorHit" .. v1874);
--					VFXService.EmitParticlesInInstance(v1871);
--					VFXService.DestroyParticleContainer(v1871, 2);
--				else
--					v1871:Destroy();
--				end;
--			end;
--		end;
--		if l_Request_1 == "RampageFuryGroundScratch7" then
--			local l_On_93 = v724.On;
--			if not (l_On_93 ~= nil) or l_On_93.Parent == nil then
--				return;
--			else
--				local v1876 = v0.CFrame.new(4.60274124, -2.63428879, -1.12382507, -0.985600829, 0, -0.169088766, 0, 1, 0, 0.169088751, 0, -0.985600829);
--				local v1877 = l_Assets_0.Particles.Kratos.RampageFury.GroundScratches.Scratch7:Clone();
--				v1877.CFrame = l_On_93.HumanoidRootPart.CFrame * v1876;
--				local v1878 = VFXService.FindGroundPosition(v1877.Position + v0.Vector3.new(0, 1, 0), 2);
--				if v1878 then
--					local v1879 = v1878.Position + v0.Vector3.new(0, 0.4, 0);
--					v1877.Position = v1879;
--					v1877.Parent = l_VFX_0;
--					local v1880 = v0.tostring(v0.math.random(1, 5));
--					v104.PlaySoundAtCFrame(v0.CFrame.new(v1879), "RampageFuryFloorHit" .. v1880);
--					VFXService.EmitParticlesInInstance(v1877);
--					VFXService.DestroyParticleContainer(v1877, 2);
--				else
--					v1877:Destroy();
--				end;
--			end;
--		end;
--		if l_Request_1 == "RampageFuryGroundScratch8" then
--			local l_On_94 = v724.On;
--			if not (l_On_94 ~= nil) or l_On_94.Parent == nil then
--				return;
--			else
--				local v1882 = v0.CFrame.new(1.50524902, -2.63428879, -19.8754883, 0.99999994, 0, 0, 0, 1, 0, 0, 0, 0.99999994);
--				local v1883 = l_Assets_0.Particles.Kratos.RampageFury.GroundScratches.Scratch8:Clone();
--				v1883.CFrame = l_On_94.HumanoidRootPart.CFrame * v1882;
--				local v1884 = VFXService.FindGroundPosition(v1883.Position + v0.Vector3.new(0, 1, 0), 2);
--				if v1884 then
--					local v1885 = v1884.Position + v0.Vector3.new(0, 0.4, 0);
--					v1883.Position = v1885;
--					v1883.Parent = l_VFX_0;
--					local v1886 = v0.tostring(v0.math.random(1, 5));
--					v104.PlaySoundAtCFrame(v0.CFrame.new(v1885), "RampageFuryFloorHit" .. v1886);
--					VFXService.EmitParticlesInInstance(v1883);
--					VFXService.DestroyParticleContainer(v1883, 2);
--				else
--					v1883:Destroy();
--				end;
--			end;
--		end;
--		if l_Request_1 == "RampageFuryGroundScratch9" then
--			local l_On_95 = v724.On;
--			if not (l_On_95 ~= nil) or l_On_95.Parent == nil then
--				return;
--			else
--				local v1888 = v0.CFrame.new(-2.89157486, -2.53428888, -14.5311737, 0.995587468, 0, 0.0938380659, 0, 1, 0, -0.0938380659, 0, 0.995587468);
--				local v1889 = l_Assets_0.Particles.Kratos.RampageFury.GroundScratches.Scratch9:Clone();
--				v1889.CFrame = l_On_95.HumanoidRootPart.CFrame * v1888;
--				local v1890 = VFXService.FindGroundPosition(v1889.Position + v0.Vector3.new(0, 1, 0), 2);
--				if v1890 then
--					local v1891 = v1890.Position + v0.Vector3.new(0, 0.4, 0);
--					v1889.Position = v1891;
--					v1889.Parent = l_VFX_0;
--					local v1892 = v0.tostring(v0.math.random(1, 5));
--					v104.PlaySoundAtCFrame(v0.CFrame.new(v1891), "RampageFuryFloorHit" .. v1892);
--					VFXService.EmitParticlesInInstance(v1889);
--					VFXService.DestroyParticleContainer(v1889, 2);
--				else
--					v1889:Destroy();
--				end;
--			end;
--		end;
--		if l_Request_1 == "RampageFuryGroundScratch10" then
--			local l_On_96 = v724.On;
--			if not (l_On_96 ~= nil) or l_On_96.Parent == nil then
--				return;
--			else
--				local v1894 = v0.CFrame.new(0.257766724, -2.53428888, -14.1246948, -0.950439692, 0, -0.310909122, 0, 1, 0, 0.310909152, 0, -0.950439692);
--				local v1895 = l_Assets_0.Particles.Kratos.RampageFury.GroundScratches.Scratch10:Clone();
--				v1895.CFrame = l_On_96.HumanoidRootPart.CFrame * v1894;
--				local v1896 = VFXService.FindGroundPosition(v1895.Position + v0.Vector3.new(0, 1, 0), 2);
--				if v1896 then
--					local v1897 = v1896.Position + v0.Vector3.new(0, 0.4, 0);
--					v1895.Position = v1897;
--					v1895.Parent = l_VFX_0;
--					local v1898 = v0.tostring(v0.math.random(1, 5));
--					v104.PlaySoundAtCFrame(v0.CFrame.new(v1897), "RampageFuryFloorHit" .. v1898);
--					VFXService.EmitParticlesInInstance(v1895);
--					VFXService.DestroyParticleContainer(v1895, 2);
--				else
--					v1895:Destroy();
--				end;
--			end;
--		end;
--		if l_Request_1 == "KratosWallCamera" then
--			local l_Relative_0 = v724.Relative;
--			if not (l_Relative_0 ~= nil) or l_Relative_0.Parent == nil then
--				return;
--			else
--				local _, _ = VFXService.InitiateCutscene("KratosWallCombo", 60, 95585547497537, l_Relative_0, v0.CFrame.new(0, -2.5, 0));
--			end;
--		end;
--		if l_Request_1 == "EndKratosWallCamera" then
--			VFXService.ScreenFlash();
--			l_CurrentCamera_1.CFrame = (l_HumanoidRootPart_0.CFrame - l_HumanoidRootPart_0.CFrame.LookVector * 3 + v0.Vector3.new(0, 8, 0)) * v0.CFrame.Angles(-v0.math.pi / 8, 0, 0);
--			VFXService.EndCutscene();
--			VFXService.ShakeCamera(0, 0.435, 26, 0.3, 0.3, 0.3);
--		end;
--		if l_Request_1 == "EndKratosBladesOfChaos" then
--			local l_On_97 = v724.On;
--			if not (l_On_97 ~= nil) or l_On_97.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_97, "KratosBladesOfChaosJoints" .. v0.tostring(v724.Tag));
--			end;
--		end;
--		if l_Request_1 == "KratosBladesOfChaos" then
--			local l_On_98 = v724.On;
--			if not (l_On_98 ~= nil) or l_On_98.Parent == nil then
--				return;
--			else
--				local v1904 = v0.CFrame.new(0, -1, 0);
--				local v1905 = v0.Instance.new("Motor6D");
--				v1905.Name = "Right-Chain.001";
--				v1905.C0 = v1904;
--				v1905.Part0 = l_On_98["Right Arm"];
--				local v1906 = v0.Instance.new("Motor6D");
--				v1906.Name = "Left-Chain.001";
--				v1906.C0 = v1904;
--				v1906.Part0 = l_On_98["Left Arm"];
--				local v1907 = l_Assets_0.Parts.Kratos.BladesOfChaosRight:Clone();
--				local v1908 = l_Assets_0.Parts.Kratos.BladesOfChaosLeft:Clone();
--				local v1909 = v0.tostring(v724.Tag);
--				v1907.Name = v1907.Name .. v1909;
--				v1908.Name = v1908.Name .. v1909;
--				v1905.Parent = l_On_98["Right Arm"];
--				v1905.Part1 = v1907["Right-Chain.001"];
--				v1907.Parent = l_On_98;
--				v1906.Parent = l_On_98["Left Arm"];
--				v1906.Part1 = v1908["Left-Chain.001"];
--				v1908.Parent = l_On_98;
--				local l_v1907_0 = v1907 --[[ copy: 6 -> 401 ]];
--				local l_v1908_0 = v1908 --[[ copy: 7 -> 402 ]];
--				local l_v1905_0 = v1905 --[[ copy: 4 -> 403 ]];
--				local l_v1906_0 = v1906 --[[ copy: 5 -> 404 ]];
--				VFXService.CreateBind(l_On_98, "KratosBladesOfChaosJoints" .. v1909, function()
--					local v1914 = v0.TweenInfo.new(0.35, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out);
--					local v1915 = v0.TweenInfo.new(0.09, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out);
--					if l_v1907_0 ~= nil and l_v1907_0.Parent ~= nil then
--						for _, v1917 in v0.pairs(l_v1907_0:GetDescendants()) do
--							if v1917:IsA("BasePart") then
--								l_TweenService_0:Create(v1917, v1915, {
--									Transparency = 1
--								}):Play();
--							end;
--							if v1917:IsA("PointLight") then
--								l_TweenService_0:Create(v1917, v1914, {
--									Brightness = 0
--								}):Play();
--							end;
--							if not (not v1917:IsA("ParticleEmitter") and not v1917:IsA("Trail")) or v1917:IsA("Beam") then
--								v1917.Enabled = false;
--							end;
--						end;
--					end;
--					if l_v1908_0 ~= nil and l_v1908_0.Parent ~= nil then
--						for _, v1919 in v0.pairs(l_v1908_0:GetDescendants()) do
--							if v1919:IsA("BasePart") then
--								v1919.Transparency = 1;
--							end;
--							if v1919:IsA("PointLight") then
--								l_TweenService_0:Create(v1919, v1914, {
--									Brightness = 0
--								}):Play();
--							end;
--							if not (not v1919:IsA("ParticleEmitter") and not v1919:IsA("Trail")) or v1919:IsA("Beam") then
--								v1919.Enabled = false;
--							end;
--						end;
--					end;
--					v0.task.delay(3, function()
--						if l_v1907_0 ~= nil and l_v1907_0.Parent ~= nil then
--							l_v1907_0:Destroy();
--						end;
--						if l_v1908_0 ~= nil and l_v1908_0.Parent ~= nil then
--							l_v1908_0:Destroy();
--						end;
--						if l_v1905_0 ~= nil and l_v1905_0.Parent ~= nil then
--							l_v1905_0:Destroy();
--						end;
--						if l_v1906_0 ~= nil and l_v1906_0.Parent ~= nil then
--							l_v1906_0:Destroy();
--						end;
--					end);
--				end);
--			end;
--		end;
--		if l_Request_1 == "FangDanceStartVoiceSound" then
--			local l_On_99 = v724.On;
--			if not (l_On_99 ~= nil) or l_On_99.Parent == nil then
--				return;
--			else
--				local v1931 = nil;
--				v1931 = if v724.C == true then v104.PlaySoundInInstance(l_On_99.Torso, "FangDanceStartVoiceClose") else v104.PlaySoundInInstance(l_On_99.Torso, "FangDanceStartVoice");
--				local v1932 = l_TweenService_0:Create(v1931, v0.TweenInfo.new(0.2, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--					Volume = 0
--				});
--				do
--					local l_v1931_0 = v1931;
--					v1932.Completed:Connect(function()
--						if l_v1931_0 ~= nil and l_v1931_0.Parent ~= nil then
--							l_v1931_0:Destroy();
--						end;
--					end);
--					local l_v1932_0 = v1932 --[[ copy: 4 -> 399 ]];
--					local v1935 = VFXService.CreateBind(l_On_99, "FangDanceStartVoiceSound", function()
--						if l_v1931_0 ~= nil and l_v1931_0.Parent ~= nil then
--							l_v1931_0:SetAttribute("DefaultVolume", nil);
--							l_v1932_0:Play();
--						end;
--					end);
--					local l_v1935_0 = v1935 --[[ copy: 5 -> 400 ]];
--					l_v1931_0.Ended:Connect(function()
--						if l_v1935_0 ~= nil and l_v1935_0.Parent ~= nil then
--							l_v1935_0:Destroy();
--						end;
--					end);
--				end;
--			end;
--		end;
--		if l_Request_1 == "EndFangDanceStartVoiceSound" then
--			local l_On_100 = v724.On;
--			if not (l_On_100 ~= nil) or l_On_100.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_100, "FangDanceStartVoiceSound");
--			end;
--		end;
--		if l_Request_1 == "FangDanceStartSound" then
--			local l_On_101 = v724.On;
--			if not (l_On_101 ~= nil) or l_On_101.Parent == nil then
--				return;
--			else
--				local v1939 = nil;
--				v1939 = if v724.C == true then v104.PlaySoundInInstance(l_On_101.Torso, "FangDanceStartClose") else v104.PlaySoundInInstance(l_On_101.Torso, "FangDanceStart");
--				local v1940 = l_TweenService_0:Create(v1939, v0.TweenInfo.new(0.2, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--					Volume = 0
--				});
--				do
--					local l_v1939_0 = v1939;
--					v1940.Completed:Connect(function()
--						if l_v1939_0 ~= nil and l_v1939_0.Parent ~= nil then
--							l_v1939_0:Destroy();
--						end;
--					end);
--					local l_v1940_0 = v1940 --[[ copy: 4 -> 397 ]];
--					local v1943 = VFXService.CreateBind(l_On_101, "FangDanceStartSound", function()
--						if l_v1939_0 ~= nil and l_v1939_0.Parent ~= nil then
--							l_v1939_0:SetAttribute("DefaultVolume", nil);
--							l_v1940_0:Play();
--						end;
--					end);
--					local l_v1943_0 = v1943 --[[ copy: 5 -> 398 ]];
--					l_v1939_0.Ended:Connect(function()
--						if l_v1943_0 ~= nil and l_v1943_0.Parent ~= nil then
--							l_v1943_0:Destroy();
--						end;
--					end);
--				end;
--			end;
--		end;
--		if l_Request_1 == "EndFangDanceStartSound" then
--			local l_On_102 = v724.On;
--			if not (l_On_102 ~= nil) or l_On_102.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_102, "FangDanceStartSound");
--			end;
--		end;
--		if l_Request_1 == "FangDanceUserSound" then
--			local l_On_103 = v724.On;
--			if not (l_On_103 ~= nil) or l_On_103.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_103.Torso, "FangDanceUser");
--				v104.PlaySoundInInstance(l_On_103.Torso, "FangDanceVoice");
--			end;
--		end;
--		if l_Request_1 == "FangDanceVictimSound" then
--			local l_On_104 = v724.On;
--			if not (l_On_104 ~= nil) or l_On_104.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_104.Torso, "FangDanceVictim");
--			end;
--		end;
--		if l_Request_1 == "JunTrueKungFu" then
--			local l_On_105 = v724.On;
--			if not (l_On_105 ~= nil) or l_On_105.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_105.HumanoidRootPart, "JunVoicelineTrueKungFu");
--			end;
--		end;
--		if l_Request_1 == "FangDanceElbow2" then
--			local l_On_106 = v724.On;
--			if not (l_On_106 ~= nil) or l_On_106.Parent == nil then
--				return;
--			else
--				local l_Position_6 = l_On_106.Torso.Position;
--				local v1951 = VFXService.FindGroundPosition(l_Position_6);
--				local v1952 = l_Assets_0.Particles.Jun.FangDance.Container.Elbow2:Clone();
--				v1952.Parent = l_On_106.HumanoidRootPart;
--				v1952.WorldPosition = v0.Vector3.new(l_On_106.Torso.Position.X, v1952.WorldPosition.Y, l_On_106.Torso.Position.Z);
--				if v1951 then
--					local v1953 = v0.ColorSequence.new(v1951.Instance.Color);
--					for _, v1955 in v0.pairs(v1952:GetDescendants()) do
--						if v1955:IsA("ParticleEmitter") and v1955.Name == "Smoke" then
--							v1955.Color = v1953;
--						end;
--					end;
--				end;
--				if (v1952.WorldPosition - l_HumanoidRootPart_0.Position).Magnitude <= 22 then
--					VFXService.ShakeCamera(0, 0.5, 14, 0.2, 0.25, 0.2);
--				end;
--				VFXService.EmitParticlesInInstance(v1952);
--				VFXService.DestroyParticleContainer(v1952, 4);
--			end;
--		end;
--		if l_Request_1 == "FangDanceSpin" then
--			local l_On_107 = v724.On;
--			if not (l_On_107 ~= nil) or l_On_107.Parent == nil then
--				return;
--			else
--				local v1957 = l_Assets_0.Particles.Jun.FangDance.Container.Spin1:Clone();
--				v1957.Parent = l_On_107.Torso;
--				local l_v1957_0 = v1957 --[[ copy: 3 -> 396 ]];
--				v0.task.delay(0.3, function()
--					if l_v1957_0 ~= nil and l_v1957_0.Parent ~= nil then
--						for _, v1960 in v0.pairs(l_v1957_0:GetDescendants()) do
--							if v1960:IsA("ParticleEmitter") then
--								v1960.LockedToPart = false;
--								v0.task.delay(0.5, function()
--									if v1960 ~= nil and v1960.Parent ~= nil then
--										v1960.LockedToPart = true;
--									end;
--								end);
--							end;
--						end;
--					end;
--				end);
--				VFXService.EmitParticlesInInstance(v1957);
--				VFXService.DestroyParticleContainer(v1957, 4);
--			end;
--		end;
--		if l_Request_1 == "FangDanceSpin2" then
--			local l_On_108 = v724.On;
--			if not (l_On_108 ~= nil) or l_On_108.Parent == nil then
--				return;
--			else
--				local v1962 = l_Assets_0.Particles.Jun.FangDance.Container.Spin2:Clone();
--				v1962.Parent = l_On_108.Torso;
--				v1962.WorldPosition = v0.Vector3.new(l_On_108.Torso.Position.X, v1962.WorldPosition.Y, l_On_108.Torso.Position.Z);
--				local v1963 = VFXService.FindGroundPosition(l_On_108.Torso.Position);
--				if v1963 then
--					local v1964 = v0.ColorSequence.new(v1963.Instance.Color);
--					for _, v1966 in v0.pairs(v1962:GetDescendants()) do
--						if v1966:IsA("ParticleEmitter") and v1966.Name == "Smoke" then
--							v1966.Color = v1964;
--						end;
--					end;
--				end;
--				VFXService.EmitParticlesInInstance(v1962);
--				VFXService.DestroyParticleContainer(v1962, 4);
--			end;
--		end;
--		if l_Request_1 == "FangDanceFinalKick" then
--			local l_On_109 = v724.On;
--			if not (l_On_109 ~= nil) or l_On_109.Parent == nil then
--				return;
--			else
--				local l_Position_7 = l_On_109.Torso.Position;
--				local v1969 = VFXService.FindGroundPosition(l_Position_7);
--				local v1970 = l_Assets_0.Particles.Jun.FangDance.Release:Clone();
--				v1970.CFrame = l_On_109.HumanoidRootPart.CFrame;
--				v1970.Parent = l_VFX_0;
--				if v1969 then
--					local v1971 = v0.ColorSequence.new(v1969.Instance.Color);
--					for _, v1973 in v0.pairs(v1970:GetDescendants()) do
--						if v1973:IsA("ParticleEmitter") and v1973.Name == "Smoke" then
--							v1973.Color = v1971;
--						end;
--					end;
--				end;
--				if (v1970.Position - l_HumanoidRootPart_0.Position).Magnitude <= 22 then
--					VFXService.ShakeCamera(0, 0.5, 30, 0.3, 0.4, 0.3);
--				end;
--				VFXService.EmitParticlesInInstance(v1970);
--				VFXService.DestroyParticleContainer(v1970, 4);
--			end;
--		end;
--		if l_Request_1 == "FangDanceAfterImage" then
--			local l_On_110 = v724.On;
--			if not (l_On_110 ~= nil) or l_On_110.Parent == nil then
--				return;
--			else
--				local l_Position_8 = l_On_110.Torso.Position;
--				local v1976 = VFXService.FindGroundPosition(l_Position_8);
--				local v1977 = l_Assets_0.Particles.Jun.FangDance.Container.KickStart:Clone();
--				v1977.Parent = l_On_110.HumanoidRootPart;
--				v1977.WorldPosition = v0.Vector3.new(l_On_110.Torso.Position.X, v1977.WorldPosition.Y, l_On_110.Torso.Position.Z);
--				if v1976 then
--					local v1978 = v0.ColorSequence.new(v1976.Instance.Color);
--					for _, v1980 in v0.pairs(v1977:GetDescendants()) do
--						if v1980:IsA("ParticleEmitter") and v1980.Name == "Smoke" then
--							v1980.Color = v1978;
--						end;
--					end;
--				end;
--				if (v1977.WorldPosition - l_HumanoidRootPart_0.Position).Magnitude <= 22 then
--					VFXService.ShakeCamera(0, 0.3, 14, 0.2, 0.25, 0.2);
--				end;
--				VFXService.EmitParticlesInInstance(v1977);
--				VFXService.DestroyParticleContainer(v1977, 4);
--			end;
--		end;
--		if l_Request_1 == "FangDanceElbow" then
--			local l_On_111 = v724.On;
--			if not (l_On_111 ~= nil) or l_On_111.Parent == nil then
--				return;
--			else
--				local l_Position_9 = l_On_111.Torso.Position;
--				local v1983 = VFXService.FindGroundPosition(l_Position_9);
--				local v1984 = l_Assets_0.Particles.Jun.FangDance.Container.Elbow:Clone();
--				v1984.Parent = l_On_111.HumanoidRootPart;
--				v1984.WorldPosition = v0.Vector3.new(l_On_111.Torso.Position.X, v1984.WorldPosition.Y, l_On_111.Torso.Position.Z);
--				if v1983 then
--					local v1985 = v0.ColorSequence.new(v1983.Instance.Color);
--					for _, v1987 in v0.pairs(v1984:GetDescendants()) do
--						if v1987:IsA("ParticleEmitter") and v1987.Name == "Smoke" then
--							v1987.Color = v1985;
--						end;
--					end;
--				end;
--				if (v1984.WorldPosition - l_HumanoidRootPart_0.Position).Magnitude <= 22 then
--					VFXService.ShakeCamera(0, 0.5, 13, 0.2, 0.25, 0.2);
--				end;
--				VFXService.EmitParticlesInInstance(v1984);
--				VFXService.DestroyParticleContainer(v1984, 4);
--			end;
--		end;
--		if l_Request_1 == "FangDanceKnee" then
--			local l_On_112 = v724.On;
--			if not (l_On_112 ~= nil) or l_On_112.Parent == nil then
--				return;
--			else
--				local l_Position_10 = l_On_112.Torso.Position;
--				local v1990 = VFXService.FindGroundPosition(l_Position_10);
--				local v1991 = l_Assets_0.Particles.Jun.FangDance.Container.KneeHit:Clone();
--				v1991.Parent = l_On_112.HumanoidRootPart;
--				if v1990 then
--					local v1992 = v0.ColorSequence.new(v1990.Instance.Color);
--					for _, v1994 in v0.pairs(v1991:GetDescendants()) do
--						if v1994:IsA("ParticleEmitter") and v1994.Name == "Smoke" then
--							v1994.Color = v1992;
--						end;
--					end;
--				end;
--				if (v1991.WorldPosition - l_HumanoidRootPart_0.Position).Magnitude <= 35 then
--					VFXService.ShakeCamera(0, 0.5, 24, 0.2, 0.25, 0.2);
--				end;
--				VFXService.EmitParticlesInInstance(v1991);
--				VFXService.DestroyParticleContainer(v1991, 4);
--			end;
--		end;
--		if l_Request_1 == "FangDanceLandGrab" then
--			local l_On_113 = v724.On;
--			if not (l_On_113 ~= nil) or l_On_113.Parent == nil then
--				return;
--			else
--				local l_Position_11 = l_On_113.Torso.Position;
--				local v1997 = VFXService.FindGroundPosition(l_Position_11);
--				local v1998 = l_Assets_0.Particles.Jun.FangDance.Container.Land:Clone();
--				v1998.Parent = l_On_113.HumanoidRootPart;
--				if v1997 then
--					local v1999 = v0.ColorSequence.new(v1997.Instance.Color);
--					for _, v2001 in v0.pairs(v1998:GetDescendants()) do
--						if v2001:IsA("ParticleEmitter") and v2001.Name == "Smoke" then
--							v2001.Color = v1999;
--						end;
--					end;
--					v1998.WorldPosition = v1997.Position;
--				end;
--				VFXService.EmitParticlesInInstance(v1998);
--				VFXService.DestroyParticleContainer(v1998, 4);
--			end;
--		end;
--		if l_Request_1 == "FangDanceLand" then
--			local l_On_114 = v724.On;
--			if not (l_On_114 ~= nil) or l_On_114.Parent == nil then
--				return;
--			else
--				local l_Position_12 = l_On_114.HumanoidRootPart.Position;
--				local v2004 = VFXService.FindGroundPosition(l_Position_12);
--				local v2005 = l_Assets_0.Particles.Jun.FangDance.Container.Land:Clone();
--				v2005.Position = v0.Vector3.zero;
--				v2005.Parent = l_On_114.HumanoidRootPart;
--				if v2004 then
--					local v2006 = v0.ColorSequence.new(v2004.Instance.Color);
--					for _, v2008 in v0.pairs(v2005:GetDescendants()) do
--						if v2008:IsA("ParticleEmitter") and v2008.Name == "Smoke" then
--							v2008.Color = v2006;
--						end;
--					end;
--					v2005.WorldPosition = v2004.Position;
--				end;
--				VFXService.EmitParticlesInInstance(v2005);
--				VFXService.DestroyParticleContainer(v2005, 4);
--			end;
--		end;
--		if l_Request_1 == "BringItEmoteMotion" then
--			local v2009 = v0.Instance.new("BodyVelocity");
--			v2009.MaxForce = v0.Vector3.new(90000, 0, 90000);
--			v2009.Parent = l_HumanoidRootPart_0;
--			local l_v2009_0 = v2009 --[[ copy: 2 -> 394 ]];
--			local v2011 = VFXService.CreateBind(v26, "BringItEmoteMotion", function()
--				if l_v2009_0 ~= nil and l_v2009_0.Parent ~= nil then
--					l_v2009_0:Destroy();
--				end;
--			end);
--			local l_v2011_0 = v2011 --[[ copy: 3 -> 395 ]];
--			v0.task.spawn(function()
--				while l_v2009_0 ~= nil and l_v2009_0.Parent ~= nil do
--					l_v2009_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * 5;
--					v0.task.wait();
--				end;
--				if l_v2011_0 ~= nil and l_v2011_0.Parent ~= nil then
--					l_v2011_0:Destroy();
--					return;
--				else
--					return;
--				end;
--			end);
--			v0.task.delay(0.65, function()
--				if l_v2011_0 ~= nil and l_v2011_0.Parent ~= nil then
--					l_v2011_0:Destroy();
--				end;
--			end);
--		end;
--		if l_Request_1 == "EndBringItEmoteMotion" then
--			VFXService.DestroyBind(v26, "BringItEmoteMotion", true);
--		end;
--		if l_Request_1 == "FangDanceForward" then
--			local v2013 = v0.Instance.new("BodyVelocity");
--			v2013.MaxForce = v0.Vector3.new(450000, 0, 450000);
--			local v2014 = v0.Instance.new("NumberValue");
--			v2014.Value = 70;
--			v2014.Parent = v2013;
--			local l_v2014_0 = v2014 --[[ copy: 3 -> 391 ]];
--			local l_v2013_0 = v2013 --[[ copy: 2 -> 392 ]];
--			v2014:GetPropertyChangedSignal("Value"):Connect(function()
--				if l_v2014_0.Value <= 4.8 and l_v2013_0 ~= nil and l_v2013_0.Parent ~= nil then
--					l_v2013_0:Destroy();
--				end;
--			end);
--			local v2017 = l_TweenService_0:Create(v2014, v0.TweenInfo.new(1.5, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--				Value = 0
--			});
--			v2013.Parent = l_HumanoidRootPart_0;
--			v2017:Play();
--			local v2018 = VFXService.CreateBind(v26, "FangDanceMotion2", function()
--				if l_v2013_0 ~= nil and l_v2013_0.Parent ~= nil then
--					l_v2013_0:Destroy();
--				end;
--			end);
--			local l_v2018_0 = v2018 --[[ copy: 5 -> 393 ]];
--			v0.task.spawn(function()
--				while l_v2013_0 ~= nil and l_v2013_0.Parent ~= nil do
--					l_v2013_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * l_v2014_0.Value;
--					v0.task.wait();
--				end;
--				if l_v2018_0 ~= nil and l_v2018_0.Parent ~= nil then
--					l_v2018_0:Destroy();
--					return;
--				else
--					return;
--				end;
--			end);
--		end;
--		if l_Request_1 == "FangDanceRun" then
--			local v2020 = v0.Instance.new("BodyVelocity");
--			v2020.MaxForce = v0.Vector3.new(450000, 0, 450000);
--			local v2021 = v0.Instance.new("NumberValue");
--			v2021.Value = 10;
--			v2021.Parent = v2020;
--			local v2022 = l_TweenService_0:Create(v2021, v0.TweenInfo.new(0.05, v0.Enum.EasingStyle.Linear, v0.Enum.EasingDirection.Out), {
--				Value = 145
--			});
--			local v2023 = l_TweenService_0:Create(v2021, v0.TweenInfo.new(0.65, v0.Enum.EasingStyle.Linear, v0.Enum.EasingDirection.Out), {
--				Value = 11
--			});
--			local l_v2023_0 = v2023 --[[ copy: 5 -> 387 ]];
--			v2022.Completed:Connect(function()
--				v0.task.delay(0.1, function()
--					if l_v2023_0 ~= nil then
--						l_v2023_0:Play();
--					end;
--				end);
--			end);
--			local l_v2020_0 = v2020 --[[ copy: 2 -> 388 ]];
--			v2023.Completed:Connect(function()
--				if l_v2020_0 ~= nil and l_v2020_0.Parent ~= nil then
--					l_v2020_0:Destroy();
--				end;
--			end);
--			v2020.Parent = l_HumanoidRootPart_0;
--			v2022:Play();
--			local v2026 = VFXService.CreateBind(v26, "FangDanceMotion", function()
--				if l_v2020_0 ~= nil and l_v2020_0.Parent ~= nil then
--					l_v2020_0:Destroy();
--				end;
--			end);
--			local l_v2021_0 = v2021 --[[ copy: 3 -> 389 ]];
--			local l_v2026_0 = v2026 --[[ copy: 6 -> 390 ]];
--			v0.task.spawn(function()
--				while l_v2020_0 ~= nil and l_v2020_0.Parent ~= nil do
--					l_v2020_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * l_v2021_0.Value;
--					v0.task.wait();
--				end;
--				if l_v2026_0 ~= nil and l_v2026_0.Parent ~= nil then
--					l_v2026_0:Destroy();
--					return;
--				else
--					return;
--				end;
--			end);
--		end;
--		if l_Request_1 == "EndFangDanceRun" then
--			VFXService.DestroyBind(v26, "FangDanceMotion");
--			VFXService.DestroyBind(v26, "FangDanceMotion2");
--		end;
--		if l_Request_1 == "DraconicHonorDragonSpawn" then
--			local l_On_115 = v724.On;
--			if not (l_On_115 ~= nil) or l_On_115.Parent == nil then
--				return;
--			else
--				local v2030 = v0.tostring(v724.Tag);
--				local v2031 = l_Assets_0.Parts.MartialArtist.DraconicHonor.DragonHead:Clone();
--				v2031.Name = "DraconicHonorDragonHead" .. v2030;
--				local v2032 = v0.Instance.new("WeldConstraint");
--				v2032.Parent = v2031;
--				v2032.Part0 = l_On_115.HumanoidRootPart;
--				local l_AnimationController_0 = v2031.AnimationController;
--				local v2034 = v0.Instance.new("Animation");
--				v2034.AnimationId = "rbxassetid://125557061954075";
--				v2034.Name = "Spawn";
--				v2031:PivotTo(l_On_115.HumanoidRootPart.CFrame * v0.CFrame.Angles(0, v0.math.pi, 0) - l_On_115.HumanoidRootPart.CFrame.LookVector * 2.357);
--				v2031.Parent = l_VFX_0;
--				local v2035 = l_AnimationController_0:LoadAnimation(v2034);
--				local l_v2031_0 = v2031 --[[ copy: 4 -> 386 ]];
--				v0.task.delay(0.1, function()
--					if l_v2031_0 ~= nil and l_v2031_0.Parent ~= nil then
--						VFXService.EmitParticlesInInstance(l_v2031_0.RootPart.Root.Roar);
--						if (l_v2031_0.RootPart.Position - l_HumanoidRootPart_0.Position).Magnitude <= 15 then
--							VFXService.ShakeCamera(0.02, 1, 12, 0.12, 0.12, 0.12);
--						end;
--					end;
--				end);
--				v2034:Destroy();
--				v2035.Priority = v0.Enum.AnimationPriority.Action4;
--				v2032.Part1 = v2031.RootPart;
--				v2035:Play(0);
--			end;
--		end;
--		if l_Request_1 == "DraconicHonorDragonRun" then
--			local v2037 = v0.tostring(v724.Tag);
--			local v2038 = nil;
--			for _, v2040 in v0.pairs(l_VFX_0:GetChildren()) do
--				if v2040:IsA("Model") and v2040.Name == "DraconicHonorDragonHead" .. v2037 then
--					v2038 = v2040;
--					break;
--				end;
--			end;
--			if not (v2038 ~= nil) or v2038.Parent == nil then
--				return;
--			else
--				local l_AnimationController_1 = v2038.AnimationController;
--				local v2042 = v0.Instance.new("Animation");
--				v2042.AnimationId = "rbxassetid://74333209630082";
--				v2042.Name = "Run";
--				local v2043 = l_AnimationController_1:LoadAnimation(v2042);
--				v2042:Destroy();
--				v2043.Priority = v0.Enum.AnimationPriority.Action4;
--				v2043.Looped = true;
--				v2043:Play();
--			end;
--		end;
--		if l_Request_1 == "DraconicHonorDragonUser" then
--			local v2044 = v0.tostring(v724.Tag);
--			local v2045 = nil;
--			for _, v2047 in v0.pairs(l_VFX_0:GetChildren()) do
--				if v2047:IsA("Model") and v2047.Name == "DraconicHonorDragonHead" .. v2044 then
--					v2045 = v2047;
--					break;
--				end;
--			end;
--			if not (v2045 ~= nil) or v2045.Parent == nil then
--				return;
--			else
--				for _, v2049 in v0.pairs(v2045:GetDescendants()) do
--					if v2049:IsA("ParticleEmitter") and v2049.Name ~= "Roar" then
--						v2049.Enabled = true;
--					end;
--				end;
--				local l_AnimationController_2 = v2045.AnimationController;
--				local v2051 = v0.Instance.new("Animation");
--				v2051.AnimationId = "rbxassetid://103479590496954";
--				v2051.Name = "User";
--				local v2052 = l_AnimationController_2:LoadAnimation(v2051);
--				v2051:Destroy();
--				v2052.Priority = v0.Enum.AnimationPriority.Action4;
--				do
--					local l_v2045_0 = v2045;
--					v2052:GetMarkerReachedSignal("FadeAway"):Connect(function()
--						if l_v2045_0 ~= nil and l_v2045_0.Parent ~= nil then
--							if l_v2045_0:FindFirstChildOfClass("WeldConstraint") then
--								l_v2045_0:FindFirstChildOfClass("WeldConstraint"):Destroy();
--							end;
--							l_v2045_0.RootPart.Anchored = true;
--							for _, v2055 in v0.pairs(l_v2045_0:GetDescendants()) do
--								if not (not v2055:IsA("ParticleEmitter") and not v2055:IsA("Beam")) or v2055:IsA("Trail") then
--									v2055.Enabled = false;
--								end;
--								if v2055:IsA("BasePart") then
--									l_TweenService_0:Create(v2055, v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--										Transparency = 1
--									}):Play();
--								end;
--							end;
--							v0.task.delay(2.5, function()
--								if l_v2045_0 ~= nil and l_v2045_0.Parent ~= nil then
--									l_v2045_0:Destroy();
--								end;
--							end);
--						end;
--					end);
--					v2052:Play();
--					for _, v2057 in v0.pairs(l_AnimationController_2:GetPlayingAnimationTracks()) do
--						if v2057.Animation.Name == "Attack" then
--							v2057:Stop();
--						end;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "DraconicHonorDragonAttack" then
--			local v2058 = v0.tostring(v724.Tag);
--			local v2059 = nil;
--			for _, v2061 in v0.pairs(l_VFX_0:GetChildren()) do
--				if v2061:IsA("Model") and v2061.Name == "DraconicHonorDragonHead" .. v2058 then
--					v2059 = v2061;
--					break;
--				end;
--			end;
--			if not (v2059 ~= nil) or v2059.Parent == nil then
--				return;
--			else
--				local l_AnimationController_3 = v2059.AnimationController;
--				for _, v2064 in v0.pairs(l_AnimationController_3:GetPlayingAnimationTracks()) do
--					if v2064.Animation.Name == "Run" then
--						v2064:Stop();
--					end;
--				end;
--				for _, v2066 in v0.pairs(v2059:GetDescendants()) do
--					if v2066:IsA("ParticleEmitter") and v2066.Name ~= "Roar" then
--						v2066.Enabled = false;
--					end;
--				end;
--				local v2067 = v0.Instance.new("Animation");
--				v2067.AnimationId = "rbxassetid://98956875606842";
--				v2067.Name = "Attack";
--				local v2068 = l_AnimationController_3:LoadAnimation(v2067);
--				v2067:Destroy();
--				v2068.Priority = v0.Enum.AnimationPriority.Action4;
--				do
--					local l_v2059_0 = v2059;
--					v2068:GetMarkerReachedSignal("FadeAway"):Connect(function()
--						if l_v2059_0 ~= nil and l_v2059_0.Parent ~= nil then
--							if l_v2059_0:FindFirstChildOfClass("WeldConstraint") then
--								l_v2059_0:FindFirstChildOfClass("WeldConstraint"):Destroy();
--							end;
--							l_v2059_0.RootPart.Anchored = true;
--							for _, v2071 in v0.pairs(l_v2059_0:GetDescendants()) do
--								if not (not v2071:IsA("ParticleEmitter") and not v2071:IsA("Beam")) or v2071:IsA("Trail") then
--									v2071.Enabled = false;
--								end;
--								if v2071:IsA("BasePart") then
--									l_TweenService_0:Create(v2071, v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--										Transparency = 1
--									}):Play();
--								end;
--							end;
--							v0.task.delay(2.5, function()
--								if l_v2059_0 ~= nil and l_v2059_0.Parent ~= nil then
--									l_v2059_0:Destroy();
--								end;
--							end);
--						end;
--					end);
--					v2068:Play();
--				end;
--			end;
--		end;
--		if l_Request_1 == "WolfFangFlashFollowUpSound" then
--			local l_On_116 = v724.On;
--			if not (l_On_116 ~= nil) or l_On_116.Parent == nil then
--				return;
--			else
--				local v2073 = v104.PlaySoundInInstance(l_On_116.HumanoidRootPart, "WolfFangFlashFollowUp");
--				local v2074 = l_TweenService_0:Create(v2073, v0.TweenInfo.new(0.2, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--					Volume = 0
--				});
--				local l_v2073_0 = v2073 --[[ copy: 3 -> 383 ]];
--				v2074.Completed:Connect(function()
--					if l_v2073_0 ~= nil and l_v2073_0.Parent ~= nil then
--						l_v2073_0:Destroy();
--					end;
--				end);
--				local l_v2074_0 = v2074 --[[ copy: 4 -> 384 ]];
--				local v2077 = VFXService.CreateBind(l_On_116, "WolfFangFlashFollowUpSound", function()
--					if l_v2073_0 ~= nil and l_v2073_0.Parent ~= nil then
--						l_v2073_0:SetAttribute("DefaultVolume", nil);
--						l_v2074_0:Play();
--					end;
--				end);
--				local l_v2077_0 = v2077 --[[ copy: 5 -> 385 ]];
--				v2073.Ended:Connect(function()
--					if l_v2077_0 ~= nil and l_v2077_0.Parent ~= nil then
--						l_v2077_0:Destroy();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndWolfFangFlashFollowUpSound" then
--			local l_On_117 = v724.On;
--			if not (l_On_117 ~= nil) or l_On_117.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_117, "WolfFangFlashFollowUpSound");
--			end;
--		end;
--		if l_Request_1 == "WolfFangFlashBackflipSound" then
--			local l_On_118 = v724.On;
--			if not (l_On_118 ~= nil) or l_On_118.Parent == nil then
--				return;
--			else
--				local v2081 = v104.PlaySoundInInstance(l_On_118.HumanoidRootPart, "WolfFangFlashBackflip");
--				local v2082 = l_TweenService_0:Create(v2081, v0.TweenInfo.new(0.2, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--					Volume = 0
--				});
--				local l_v2081_0 = v2081 --[[ copy: 3 -> 380 ]];
--				v2082.Completed:Connect(function()
--					if l_v2081_0 ~= nil and l_v2081_0.Parent ~= nil then
--						l_v2081_0:Destroy();
--					end;
--				end);
--				local l_v2082_0 = v2082 --[[ copy: 4 -> 381 ]];
--				local v2085 = VFXService.CreateBind(l_On_118, "WolfFangFlashBackflipSound", function()
--					if l_v2081_0 ~= nil and l_v2081_0.Parent ~= nil then
--						l_v2081_0:SetAttribute("DefaultVolume", nil);
--						l_v2082_0:Play();
--					end;
--				end);
--				local l_v2085_0 = v2085 --[[ copy: 5 -> 382 ]];
--				v2081.Ended:Connect(function()
--					if l_v2085_0 ~= nil and l_v2085_0.Parent ~= nil then
--						l_v2085_0:Destroy();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndWolfFangFlashBackflipSound" then
--			local l_On_119 = v724.On;
--			if not (l_On_119 ~= nil) or l_On_119.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_119, "WolfFangFlashBackflipSound");
--			end;
--		end;
--		if l_Request_1 == "WolfFangFlashAura" then
--			local l_On_120 = v724.On;
--			if not (l_On_120 ~= nil) or l_On_120.Parent == nil then
--				return;
--			else
--				local v2089 = l_Assets_0.Particles.Jun.WolfFangFlash.HandAura.Attachment:Clone();
--				v2089.Parent = l_On_120["Right Arm"];
--				local l_v2089_0 = v2089 --[[ copy: 3 -> 379 ]];
--				VFXService.CreateBind(l_On_120, "WolfFangFlashHandAura", function()
--					if l_v2089_0 ~= nil and l_v2089_0.Parent ~= nil then
--						for _, v2092 in v0.pairs(l_v2089_0:GetDescendants()) do
--							if v2092:IsA("ParticleEmitter") then
--								v2092.Enabled = false;
--							end;
--						end;
--						v0.task.delay(2, function()
--							if l_v2089_0 ~= nil and l_v2089_0.Parent ~= nil then
--								l_v2089_0:Destroy();
--							end;
--						end);
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndWolfFangFlashAura" then
--			local l_On_121 = v724.On;
--			if not (l_On_121 ~= nil) or l_On_121.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_121, "WolfFangFlashHandAura");
--			end;
--		end;
--		if l_Request_1 == "WolfFangFlashKickUp" then
--			local l_On_122 = v724.On;
--			if not (l_On_122 ~= nil) or l_On_122.Parent == nil then
--				return;
--			else
--				local v2095 = l_Assets_0.Particles.Jun.WolfFangFlash.KickedUp:Clone();
--				v2095.CFrame = l_On_122.HumanoidRootPart.CFrame;
--				v2095.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v2095);
--				v104.PlaySoundInInstance(l_On_122.HumanoidRootPart, "WolfFangFlashBackflipHit");
--				VFXService.DestroyParticleContainer(v2095, 3.5);
--			end;
--		end;
--		if l_Request_1 == "WolfFangFlashPunch" then
--			local l_On_123 = v724.On;
--			if not (l_On_123 ~= nil) or l_On_123.Parent == nil then
--				return;
--			else
--				local v2097 = l_Assets_0.Particles.Jun.WolfFangFlash.Punch:Clone();
--				v2097.CFrame = l_On_123.HumanoidRootPart.CFrame;
--				v2097.Parent = l_VFX_0;
--				if (l_On_123.HumanoidRootPart.Position - l_HumanoidRootPart_0.Position).Magnitude <= 15 then
--					VFXService.ShakeCamera(0, 0.4, 25, 0.33, 0.33, 0.33);
--				end;
--				local v2098 = VFXService.FindGroundPosition(v2097.Position);
--				if v2098 then
--					local v2099 = v0.ColorSequence.new(v2098.Instance.Color);
--					for _, v2101 in v0.pairs(v2097:GetDescendants()) do
--						if v2101:IsA("ParticleEmitter") and v2101.Name == "Smoke" then
--							v2101.Color = v2099;
--						end;
--					end;
--				end;
--				VFXService.EmitParticlesInInstance(v2097);
--				v104.PlaySoundInInstance(l_On_123.HumanoidRootPart, "WolfFangFlashPunch");
--				VFXService.DestroyParticleContainer(v2097, 3.5);
--			end;
--		end;
--		if l_Request_1 == "WolfFangFlashVoiceline" then
--			local l_On_124 = v724.On;
--			if not (l_On_124 ~= nil) or l_On_124.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_124.HumanoidRootPart, "WolfFangFlashVoiceline");
--			end;
--		end;
--		if l_Request_1 == "WolfFangFlashGrabInitiate" then
--			local l_On_125 = v724.On;
--			if not (l_On_125 ~= nil) or l_On_125.Parent == nil then
--				return;
--			else
--				local v2104 = l_Assets_0.Particles.Jun.WolfFangFlash.GrabInitiate:Clone();
--				v2104.CFrame = l_On_125.HumanoidRootPart.CFrame;
--				v2104.Parent = l_VFX_0;
--				if (l_On_125.HumanoidRootPart.Position - l_HumanoidRootPart_0.Position).Magnitude <= 20 then
--					VFXService.ShakeCamera(0, 0.3, 18, 0.3, 0.3, 0.3);
--				end;
--				local v2105 = VFXService.FindGroundPosition(v2104.Position);
--				if v2105 then
--					local v2106 = v0.ColorSequence.new(v2105.Instance.Color);
--					for _, v2108 in v0.pairs(v2104:GetDescendants()) do
--						if v2108:IsA("ParticleEmitter") and v2108.Name == "Smoke" then
--							v2108.Color = v2106;
--						end;
--					end;
--				end;
--				VFXService.EmitParticlesInInstance(v2104);
--				v104.PlaySoundInInstance(l_On_125.HumanoidRootPart, "WolfFangFlashGrabInitiate");
--				VFXService.DestroyParticleContainer(v2104, 3.5);
--			end;
--		end;
--		if l_Request_1 == "WolfFangFlashTeleport" then
--			local l_Old_0 = v724.Old;
--			local l_New_0 = v724.New;
--			local v2111 = l_Assets_0.Particles.Jun.WolfFangFlash.Teleport:Clone();
--			v2111.CFrame = v0.CFrame.new(l_Old_0, l_New_0);
--			v2111.Parent = l_VFX_0;
--			local v2112 = VFXService.FindGroundPosition(v2111.Position);
--			if v2112 then
--				local v2113 = v0.ColorSequence.new(v2112.Instance.Color);
--				for _, v2115 in v0.pairs(v2111:GetDescendants()) do
--					if v2115:IsA("ParticleEmitter") and v2115.Name == "Smoke" then
--						v2115.Color = v2113;
--					end;
--				end;
--			end;
--			VFXService.EmitParticlesInInstance(v2111);
--			VFXService.DestroyParticleContainer(v2111, 3);
--		end;
--		if l_Request_1 == "WolfFangFlashBackflip" then
--			local l_On_126 = v724.On;
--			if not (l_On_126 ~= nil) or l_On_126.Parent == nil then
--				return;
--			else
--				local v2117 = l_Assets_0.Particles.Jun.WolfFangFlash.Backflip:Clone();
--				v2117.CFrame = l_On_126.HumanoidRootPart.CFrame;
--				v2117.Parent = l_VFX_0;
--				local v2118 = VFXService.FindGroundPosition(v2117.Position);
--				if v2118 then
--					local v2119 = v0.ColorSequence.new(v2118.Instance.Color);
--					for _, v2121 in v0.pairs(v2117:GetDescendants()) do
--						if v2121:IsA("ParticleEmitter") and v2121.Name == "Smoke" then
--							v2121.Color = v2119;
--						end;
--					end;
--				end;
--				VFXService.EmitParticlesInInstance(v2117);
--				VFXService.DestroyParticleContainer(v2117, 3.5);
--			end;
--		end;
--		if l_Request_1 == "DraconicHonorSpeedlines" then
--			local l_On_127 = v724.On;
--			if not (l_On_127 ~= nil) or l_On_127.Parent == nil then
--				return;
--			else
--				local v2123 = {};
--				for _, v2125 in v0.pairs(l_Assets_0.Particles.MartialArtist.DraconicHonor.Speedlines:GetChildren()) do
--					if v2125:IsA("ParticleEmitter") then
--						local v2126 = v2125:Clone();
--						v0.table.insert(v2123, v2126);
--						v2126.Parent = l_On_127.Torso;
--					end;
--				end;
--				local l_v2123_0 = v2123 --[[ copy: 3 -> 378 ]];
--				VFXService.CreateBind(l_On_127, "DraconicHonorSpeedlines", function()
--					for _, v2129 in v0.pairs(l_v2123_0) do
--						if v2129 ~= nil and v2129.Parent ~= nil then
--							v2129.Enabled = false;
--							v0.task.delay(2, function()
--								if v2129 ~= nil and v2129.Parent ~= nil then
--									v2129:Destroy();
--								end;
--							end);
--						end;
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndDraconicHonorSpeedlines" then
--			local l_On_128 = v724.On;
--			if not (l_On_128 ~= nil) or l_On_128.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_128, "DraconicHonorSpeedlines");
--			end;
--		end;
--		if l_Request_1 == "DraconicHonorSlam" then
--			local l_At_1 = v724.At;
--			local v2132 = l_At_1.Position + v0.Vector3.new(0, 3, 0);
--			local v2133 = VFXService.FindGroundPosition(v2132, 25);
--			if v2133 then
--				local v2134 = l_Assets_0.Particles.MartialArtist.DraconicHonor.Slam:Clone();
--				v2134.Position = v2133.Position + v0.Vector3.new(0, 4, 0);
--				local v2135 = v0.ColorSequence.new(v2133.Instance.Color);
--				for _, v2137 in v0.pairs(v2134:GetDescendants()) do
--					if v2137:IsA("ParticleEmitter") and v2137.Name == "Smoke" then
--						v2137.Color = v2135;
--					end;
--				end;
--				v2134.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v2134);
--				VFXService.DestroyParticleContainer(v2134, 5.5);
--			end;
--			local v2138 = {};
--			local v2139 = {};
--			local _ = VFXService.GetRandomAngle();
--			local _ = VFXService.FindGroundPosition(v2132, 15);
--			local v2142 = VFXService.GetTile(v2132);
--			local v2143 = VFXService.GetRandomAngle();
--			v104.PlaySoundAtCFrame(l_At_1, "DraconicHonorSlam");
--			VFXService.GetCircularRocksProperties(v2138, l_At_1, {
--				40, 
--				110
--			}, 6, {
--				39, 
--				53
--			}, {
--				18, 
--				29
--			}, {
--				18, 
--				29
--			}, {
--				-1, 
--				1
--			}, {
--				-1, 
--				1
--			}, {
--				-1, 
--				1
--			}, {
--				"Rise", 
--				"Sink"
--			}, 8, false, nil, nil, {
--				-5, 
--				5
--			}, {
--				4, 
--				6.5
--			}, {
--				-5, 
--				5
--			});
--			VFXService.GetCircularRocksProperties(v2138, l_At_1 * v0.CFrame.Angles(0, v2143, 0), {
--				40, 
--				110
--			}, 5, {
--				39, 
--				53
--			}, {
--				19, 
--				27
--			}, {
--				19, 
--				27
--			}, {
--				-1, 
--				1
--			}, {
--				-1, 
--				1
--			}, {
--				-1, 
--				1
--			}, {
--				"Rise", 
--				"Sink"
--			}, 8, false, nil, nil, {
--				-5, 
--				5
--			}, {
--				4, 
--				6.5
--			}, {
--				-5, 
--				5
--			});
--			VFXService.GetCircularRocksProperties(v2138, l_At_1 * v0.CFrame.Angles(0, v2143 + v0.math.pi, 0), {
--				45, 
--				110
--			}, 5, {
--				36, 
--				49
--			}, {
--				14, 
--				28
--			}, {
--				14, 
--				28
--			}, {
--				-1, 
--				1
--			}, {
--				-1, 
--				1
--			}, {
--				-1, 
--				1
--			}, {
--				"Rise", 
--				"Sink"
--			}, 8, false, nil, nil, {
--				-5, 
--				5
--			}, {
--				2, 
--				3
--			}, {
--				-5, 
--				5
--			});
--			VFXService.GetCircularRocksProperties(v2138, l_At_1, {
--				80, 
--				110
--			}, 5, {
--				32, 
--				42
--			}, {
--				14, 
--				34
--			}, {
--				14, 
--				34
--			}, {
--				-1, 
--				1
--			}, {
--				-1, 
--				1
--			}, {
--				-1, 
--				1
--			}, {
--				"Rise", 
--				"Sink"
--			}, 8, false, {
--				IncludeDuplicate = true
--			}, nil, {
--				-5, 
--				5
--			}, {
--				2, 
--				3
--			}, {
--				-5, 
--				5
--			});
--			VFXService.GetCircularRocksProperties(v2138, l_At_1 * v0.CFrame.Angles(0, v2143 + v0.math.pi * 3, 0), {
--				45, 
--				95
--			}, 5, {
--				23, 
--				39
--			}, {
--				14, 
--				20
--			}, {
--				14, 
--				20
--			}, {
--				-1, 
--				1
--			}, {
--				-1, 
--				1
--			}, {
--				-1, 
--				1
--			}, {
--				"Rise", 
--				"Sink"
--			}, 8, false, nil, nil, {
--				-9, 
--				9
--			}, {
--				3.75, 
--				5
--			}, {
--				-8, 
--				8
--			});
--			VFXService.GetCircularRocksProperties(v2138, l_At_1 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--				45, 
--				95
--			}, 5, {
--				23, 
--				39
--			}, {
--				14, 
--				20
--			}, {
--				14, 
--				20
--			}, {
--				-1, 
--				1
--			}, {
--				-1, 
--				1
--			}, {
--				-1, 
--				1
--			}, {
--				"Rise", 
--				"Sink"
--			}, 8, false, {
--				IncludeDuplicate = true
--			}, nil, {
--				-9, 
--				9
--			}, {
--				3.75, 
--				5
--			}, {
--				-8, 
--				8
--			});
--			VFXService.GetFlyingRocksProperties(v2139, l_At_1, v0.math.random(9, 11), {
--				20, 
--				190
--			}, {
--				170, 
--				170
--			}, {
--				20, 
--				190
--			}, 7, 7, 7, 3);
--			VFXService.GetFlyingRocksProperties(v2139, l_At_1, v0.math.random(9, 11), {
--				20, 
--				190
--			}, {
--				170, 
--				170
--			}, {
--				20, 
--				190
--			}, 5, 5, 5, 3);
--			VFXService.GetFlyingRocksProperties(v2139, l_At_1, v0.math.random(9, 11), {
--				20, 
--				190
--			}, {
--				170, 
--				170
--			}, {
--				20, 
--				190
--			}, 5.5, 5.5, 5.5, 3);
--			VFXService.GetFlyingRocksProperties(v2139, l_At_1, v0.math.random(9, 11), {
--				20, 
--				190
--			}, {
--				170, 
--				170
--			}, {
--				20, 
--				190
--			}, 4, 4, 4, 3);
--			VFXService.GetFlyingRocksProperties(v2139, l_At_1, v0.math.random(9, 11), {
--				20, 
--				190
--			}, {
--				170, 
--				170
--			}, {
--				20, 
--				190
--			}, 6, 6, 6, 3);
--			VFXService.ApplyCircularRocksProperties(v2138);
--			VFXService.ApplyFlyingRocksProperties(v2139);
--			VFXService.DestroyTile(v2142);
--		end;
--		if l_Request_1 == "DraconicHonorGrabInitiateImpact" then
--			local l_On_129 = v724.On;
--			if not (l_On_129 ~= nil) or l_On_129.Parent == nil then
--				return;
--			else
--				local v2145 = l_Assets_0.Particles.MartialArtist.DraconicHonor.GrabInitiate.Attachment:Clone();
--				v2145.Parent = l_On_129.Torso;
--				VFXService.EmitParticlesInInstance(v2145);
--				VFXService.DestroyParticleContainer(v2145, 4);
--			end;
--		end;
--		if l_Request_1 == "DraconicHonorImpact1" then
--			local l_On_130 = v724.On;
--			if not (l_On_130 ~= nil) or l_On_130.Parent == nil then
--				return;
--			else
--				local v2147 = l_Assets_0.Particles.MartialArtist.DraconicHonor.Impact1.Attachment:Clone();
--				v2147.Parent = l_On_130.Torso;
--				VFXService.EmitParticlesInInstance(v2147);
--				VFXService.DestroyParticleContainer(v2147, 4);
--			end;
--		end;
--		if l_Request_1 == "DraconicHonorImpact2" then
--			local l_On_131 = v724.On;
--			if not (l_On_131 ~= nil) or l_On_131.Parent == nil then
--				return;
--			else
--				local v2149 = l_Assets_0.Particles.MartialArtist.DraconicHonor.Impact2.Attachment:Clone();
--				v2149.Parent = l_On_131.Torso;
--				VFXService.EmitParticlesInInstance(v2149);
--				VFXService.DestroyParticleContainer(v2149, 4);
--			end;
--		end;
--		if l_Request_1 == "DraconicHonorPushEffects" then
--			local l_On_132 = v724.On;
--			if not (l_On_132 ~= nil) or l_On_132.Parent == nil then
--				return;
--			else
--				local v2151 = l_On_132.Torso.Position + v0.Vector3.new(0, 2, 0);
--				local v2152 = VFXService.FindGroundPosition(v2151);
--				local v2153 = VFXService.GetTile(v2151, 15);
--				if v2152 then
--					local v2154 = l_Assets_0.Particles.MartialArtist.DraconicHonor.HitGround:Clone();
--					v2154.Position = v2152.Position + v0.Vector3.new(0, 0.01, 0);
--					local v2155 = v0.ColorSequence.new(v2152.Instance.Color);
--					for _, v2157 in v0.pairs(v2154:GetDescendants()) do
--						if v2157:IsA("ParticleEmitter") and v2157.Name == "Smoke" then
--							v2157.Color = v2155;
--						end;
--					end;
--					local v2158 = {};
--					VFXService.GetFlyingRocksProperties(v2158, v0.CFrame.new(v2151), 7, {
--						5, 
--						60
--					}, {
--						50, 
--						80
--					}, {
--						5, 
--						60
--					}, 2, 2, 2);
--					VFXService.GetFlyingRocksProperties(v2158, v0.CFrame.new(v2151), 3, {
--						5, 
--						60
--					}, {
--						50, 
--						80
--					}, {
--						5, 
--						60
--					}, 3, 3, 3);
--					v2154.Parent = l_VFX_0;
--					VFXService.EmitParticlesInInstance(v2154);
--					VFXService.DestroyParticleContainer(v2154, 4);
--					VFXService.ApplyFlyingRocksProperties(v2158);
--					if v2153 ~= nil and v2153.Parent ~= nil then
--						VFXService.DestroyTile(v2153);
--					end;
--				end;
--				local v2159 = l_Assets_0.Particles.MartialArtist.DraconicHonor.Drag.Push.Attachment:Clone();
--				v2159.Parent = l_On_132.Torso;
--				local l_v2159_0 = v2159 --[[ copy: 6 -> 377 ]];
--				VFXService.CreateBind(l_On_132, "DraconicHonorPushEffects", function()
--					if l_v2159_0 ~= nil and l_v2159_0.Parent ~= nil then
--						for _, v2162 in v0.pairs(l_v2159_0:GetDescendants()) do
--							if v2162:IsA("ParticleEmitter") then
--								v2162.Enabled = false;
--							end;
--						end;
--						v0.task.delay(0.5, function()
--							if l_v2159_0 ~= nil and l_v2159_0.Parent ~= nil then
--								l_v2159_0:Destroy();
--							end;
--						end);
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "DraconicHonorDragEffects" then
--			local l_On_133 = v724.On;
--			if not (l_On_133 ~= nil) or l_On_133.Parent == nil then
--				return;
--			else
--				if l_On_133 == v26 then
--					VFXService.EndCutscene();
--					VFXService.ShakeCamera(0.4, 9, 27, 0.12, 0.12, 0.05);
--				end;
--				local v2164 = l_Assets_0.Particles.MartialArtist.DraconicHonor.Drag.Ground.Attachment:Clone();
--				v2164.Parent = l_On_133.Torso;
--				local _ = v0.Vector3.new(0, -5, 0);
--				local v2166 = nil;
--				local l_l_On_133_0 = l_On_133 --[[ copy: 2 -> 375 ]];
--				local l_v2164_0 = v2164 --[[ copy: 3 -> 376 ]];
--				v2166 = v0.task.spawn(function()
--					local l_Children_2 = l_Assets_0.Particles.MartialArtist.DraconicHonor.Drag.Smoke:GetChildren();
--					while l_l_On_133_0 ~= nil and l_l_On_133_0.Parent ~= nil do
--						local v2170 = VFXService.FindGroundPosition(l_l_On_133_0.Torso.Position);
--						if v2170 then
--							VFXService.EmitFromAttachment(l_v2164_0, l_Children_2, nil, nil, nil, VFXService.MakeDarker(v2170.Instance.Color, -50, -50, -50));
--							local v2171 = {};
--							local v2172 = {};
--							local v2173 = v2170.Position + v0.Vector3.new(0, 1, 0);
--							local v2174 = v0.CFrame.new(v2173, v2173 - l_l_On_133_0.HumanoidRootPart.CFrame.LookVector);
--							VFXService.GetCircularRocksProperties(v2171, v2174 * v0.CFrame.Angles(0, v0.math.pi / 2, 0), {
--								6, 
--								8
--							}, 2, {
--								1.6, 
--								4.5
--							}, {
--								1.6, 
--								4.5
--							}, {
--								1.4, 
--								4.5
--							}, {
--								-0.1, 
--								0.1
--							}, {
--								-0.1, 
--								0.1
--							}, {
--								-0.1, 
--								0.1
--							}, {
--								"Grow", 
--								"Sink"
--							}, 3.5, true, {
--								IncludeDuplicate = false
--							}, 10, {
--								-2, 
--								2
--							}, {
--								-0.5, 
--								0.5
--							}, {
--								-2, 
--								2
--							});
--							VFXService.GetFlyingRocksProperties(v2172, v2174, 1, {
--								5, 
--								50
--							}, {
--								40, 
--								66
--							}, {
--								5, 
--								50
--							}, 2.35, 2.35, 2.35, nil, 1);
--							VFXService.ApplyCircularRocksProperties(v2171);
--							VFXService.ApplyFlyingRocksProperties(v2172);
--						end;
--						v0.task.wait(0.02);
--					end;
--				end);
--				do
--					local l_v2166_0 = v2166;
--					VFXService.CreateBind(l_On_133, "DraconicHonorDragEffects", function()
--						v0.pcall(function()
--							v0.task.cancel(l_v2166_0);
--						end);
--						if l_v2164_0 ~= nil and l_v2164_0.Parent ~= nil then
--							for _, v2177 in v0.pairs(l_v2164_0:GetDescendants()) do
--								if v2177:IsA("ParticleEmitter") then
--									v2177.Enabled = false;
--								end;
--							end;
--							v0.task.delay(2, function()
--								if l_v2164_0 ~= nil and l_v2164_0.Parent ~= nil then
--									l_v2164_0:Destroy();
--								end;
--							end);
--						end;
--					end);
--				end;
--			end;
--		end;
--		if l_Request_1 == "EndDraconicHonorDragEffects" then
--			local l_On_134 = v724.On;
--			if not (l_On_134 ~= nil) or l_On_134.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_134, "DraconicHonorDragEffects");
--				VFXService.DestroyBind(l_On_134, "DraconicHonorPushEffects");
--			end;
--		end;
--		if l_Request_1 == "DraconicHonorFirstJump" then
--			local l_On_135 = v724.On;
--			if not (l_On_135 ~= nil) or l_On_135.Parent == nil then
--				return;
--			else
--				local v2180 = l_Assets_0.Particles.MartialArtist.DraconicHonor.FirstJump.Effect1:Clone();
--				v2180.CFrame = l_On_135.HumanoidRootPart.CFrame;
--				v2180.Parent = l_VFX_0;
--				local v2181 = l_Assets_0.Particles.MartialArtist.DraconicHonor.FirstJump.Effect2:Clone();
--				v2181.CFrame = l_On_135.HumanoidRootPart.CFrame - l_On_135.HumanoidRootPart.CFrame.LookVector * 1.25;
--				v2181.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v2180);
--				VFXService.EmitParticlesInInstance(v2181);
--				VFXService.DestroyParticleContainer(v2180, 4);
--				VFXService.DestroyParticleContainer(v2181, 4);
--				local v2182 = nil;
--				local v2183 = v0.tostring(v724.Tag);
--				for _, v2185 in v0.pairs(l_VFX_0:GetChildren()) do
--					if v2185:IsA("Model") and v2185.Name == "DraconicHonorDragonHead" .. v2183 then
--						v2182 = v2185;
--						break;
--					end;
--				end;
--				if not (v2182 ~= nil) or v2182.Parent == nil then
--					return;
--				else
--					for _, v2187 in v0.pairs(v2182:GetDescendants()) do
--						if (not (not v2187:IsA("ParticleEmitter") and not v2187:IsA("Beam")) or v2187:IsA("Trail")) and v2187.Name ~= "Roar" then
--							v2187.Enabled = true;
--						end;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "DraconicHonorStartSound" then
--			local l_On_136 = v724.On;
--			if not (l_On_136 ~= nil) or l_On_136.Parent == nil then
--				return;
--			else
--				local v2189 = v104.PlaySoundInInstance(l_On_136.HumanoidRootPart, "DraconicHonorStart");
--				local v2190 = l_TweenService_0:Create(v2189, v0.TweenInfo.new(2, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--					Volume = 0
--				});
--				local l_v2189_0 = v2189 --[[ copy: 3 -> 372 ]];
--				v2190.Completed:Connect(function()
--					if l_v2189_0 ~= nil and l_v2189_0.Parent ~= nil then
--						l_v2189_0:Destroy();
--					end;
--				end);
--				local l_v2190_0 = v2190 --[[ copy: 4 -> 373 ]];
--				local v2193 = VFXService.CreateBind(l_On_136, "DraconicHonorStartSound", function()
--					if l_v2189_0 ~= nil and l_v2189_0.Parent ~= nil then
--						l_v2189_0:SetAttribute("DefaultVolume", nil);
--						l_v2190_0:Play();
--					end;
--				end);
--				local l_v2193_0 = v2193 --[[ copy: 5 -> 374 ]];
--				v2189.Ended:Connect(function()
--					if l_v2193_0 ~= nil and l_v2193_0.Parent ~= nil then
--						l_v2193_0:Destroy();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndDraconicHonorStartSound" then
--			local l_On_137 = v724.On;
--			if not (l_On_137 ~= nil) or l_On_137.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_137, "DraconicHonorStartSound");
--			end;
--		end;
--		if l_Request_1 == "DraconicHonorStartEffects" then
--			local l_On_138 = v724.On;
--			if not (l_On_138 ~= nil) or l_On_138.Parent == nil then
--				return;
--			else
--				local v2197 = VFXService.FindGroundPosition(l_On_138.HumanoidRootPart.Position, 15);
--				if v2197 then
--					local v2198 = l_Assets_0.Particles.MartialArtist.DraconicHonor.Start.Emit:Clone();
--					v2198.CFrame = v0.CFrame.new(v2197.Position, v2197.Position + l_On_138.HumanoidRootPart.CFrame.LookVector);
--					v2198.Parent = l_VFX_0;
--					VFXService.EmitParticlesInInstance(v2198);
--					VFXService.DestroyParticleContainer(v2198, 3);
--				end;
--				local v2199 = l_Assets_0.Particles.MartialArtist.DraconicHonor.Start.Effects:Clone();
--				local v2200 = v0.Instance.new("WeldConstraint");
--				v2200.Part0 = l_On_138.HumanoidRootPart;
--				v2199.CFrame = l_On_138.HumanoidRootPart.CFrame - l_On_138.HumanoidRootPart.CFrame.UpVector * 2.7;
--				v2200.Parent = v2199;
--				v2199.Parent = l_VFX_0;
--				v2200.Part1 = v2199;
--				local l_v2200_0 = v2200 --[[ copy: 5 -> 370 ]];
--				local l_v2199_0 = v2199 --[[ copy: 4 -> 371 ]];
--				VFXService.CreateBind(l_On_138, "DraconicHonorStartEffects", function()
--					if l_v2200_0 ~= nil and l_v2200_0.Parent ~= nil then
--						l_v2200_0:Destroy();
--					end;
--					if l_v2199_0 ~= nil and l_v2199_0.Parent ~= nil then
--						l_v2199_0.Anchored = true;
--						for _, v2204 in v0.pairs(l_v2199_0:GetDescendants()) do
--							if v2204:IsA("ParticleEmitter") or v2204:IsA("Beam") then
--								v2204.Enabled = false;
--							end;
--						end;
--						VFXService.DestroyParticleContainer(l_v2199_0, 3);
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndDraconicHonorStartEffects" then
--			local l_On_139 = v724.On;
--			if not (l_On_139 ~= nil) or l_On_139.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_139, "DraconicHonorStartEffects");
--			end;
--		end;
--		if l_Request_1 == "RemoveHead" then
--			local l_On_140 = v724.On;
--			if not (l_On_140 ~= nil) or l_On_140.Parent == nil then
--				return;
--			else
--				for _, v2208 in v0.pairs(l_On_140:GetChildren()) do
--					if v2208:IsA("Accessory") and (not (v2208.AccessoryType ~= Enum.AccessoryType.Hair and v2208.AccessoryType ~= Enum.AccessoryType.Hat) or v2208.AccessoryType == Enum.AccessoryType.Face) then
--						for _, v2210 in v0.pairs(v2208:GetDescendants()) do
--							if v2210:IsA("BasePart") then
--								v2210.Transparency = 1;
--							end;
--						end;
--					end;
--					if v2208:IsA("BasePart") and v2208.Name == "Head" then
--						v2208.Transparency = 1;
--						if v2208:FindFirstChildOfClass("Decal") then
--							v2208:FindFirstChildOfClass("Decal").Transparency = 1;
--						end;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "WolfFangFlashStop" then
--			for _, v2212 in v0.pairs(l_HumanoidRootPart_0:GetChildren()) do
--				if v2212:IsA("BodyVelocity") and (not (v2212.Name ~= "WolfFangFlashWalkBack" and v2212.Name ~= "WolfFangFlashBack" and v2212.Name ~= "WolfFangFlashForward") or v2212.Name == "WolfFangFlashGrabMovement") then
--					v2212:Destroy();
--				end;
--			end;
--		end;
--		if l_Request_1 == "WolfFangFlashGrabMovement" then
--			for _, v2214 in v0.pairs(l_HumanoidRootPart_0:GetChildren()) do
--				if v2214:IsA("BodyVelocity") and (not (v2214.Name ~= "WolfFangFlashWalkBack" and v2214.Name ~= "WolfFangFlashBack") or v2214.Name == "WolfFangFlashForward") then
--					v2214:Destroy();
--				end;
--			end;
--			local v2215 = v0.Instance.new("BodyVelocity");
--			v2215.MaxForce = v0.Vector3.new(75000, 0, 75000);
--			v2215.Name = "WolfFangFlashGrabMovement";
--			local v2216 = v0.Instance.new("NumberValue");
--			v2216.Value = 203;
--			v2216.Parent = v2215;
--			local l_v2216_0 = v2216 --[[ copy: 3 -> 368 ]];
--			local l_v2215_0 = v2215 --[[ copy: 2 -> 369 ]];
--			v2216:GetPropertyChangedSignal("Value"):Connect(function()
--				if l_v2216_0.Value <= 3 and l_v2215_0 ~= nil and l_v2215_0.Parent ~= nil then
--					l_v2215_0:Destroy();
--				end;
--			end);
--			local v2219 = l_TweenService_0:Create(v2216, v0.TweenInfo.new(0.9, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--				Value = 0
--			});
--			v2219.Completed:Connect(function()
--				if l_v2215_0 ~= nil and l_v2215_0.Parent ~= nil then
--					l_v2215_0:Destroy();
--				end;
--			end);
--			v2215.Parent = l_HumanoidRootPart_0;
--			v2219:Play();
--			v0.task.spawn(function()
--				while l_v2215_0 ~= nil and l_v2215_0.Parent ~= nil do
--					l_v2215_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * l_v2216_0.Value;
--					v0.task.wait();
--				end;
--			end);
--		end;
--		if l_Request_1 == "RagingFangsWalkForward" then
--			for _, v2221 in v0.pairs(l_HumanoidRootPart_0:GetChildren()) do
--				if v2221:IsA("BodyVelocity") and v2221.Name == "RagingFangsForward" then
--					v2221:Destroy();
--				end;
--			end;
--			local v2222 = v0.Instance.new("BodyVelocity");
--			v2222.MaxForce = v0.Vector3.new(85000, 0, 85000);
--			v2222.Name = "RagingFangsForward";
--			local v2223 = v0.Instance.new("NumberValue");
--			v2223.Value = 44;
--			v2223.Parent = v2222;
--			local l_v2223_0 = v2223 --[[ copy: 3 -> 366 ]];
--			local l_v2222_0 = v2222 --[[ copy: 2 -> 367 ]];
--			v2223:GetPropertyChangedSignal("Value"):Connect(function()
--				if l_v2223_0.Value <= 3 and l_v2222_0 ~= nil and l_v2222_0.Parent ~= nil then
--					l_v2222_0:Destroy();
--				end;
--			end);
--			local v2226 = l_TweenService_0:Create(v2223, v0.TweenInfo.new(2, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--				Value = 0
--			});
--			v2226.Completed:Connect(function()
--				if l_v2222_0 ~= nil and l_v2222_0.Parent ~= nil then
--					l_v2222_0:Destroy();
--				end;
--			end);
--			v2222.Parent = l_HumanoidRootPart_0;
--			v2226:Play();
--			v0.task.spawn(function()
--				while l_v2222_0 ~= nil and l_v2222_0.Parent ~= nil do
--					l_v2222_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * l_v2223_0.Value;
--					v0.task.wait();
--				end;
--			end);
--		end;
--		if l_Request_1 == "WolfFangFlashWalkForward" then
--			for _, v2228 in v0.pairs(l_HumanoidRootPart_0:GetChildren()) do
--				if v2228:IsA("BodyVelocity") and (not (v2228.Name ~= "WolfFangFlashWalkBack" and v2228.Name ~= "WolfFangFlashBack") or v2228.Name == "WolfFangFlashForward") then
--					v2228:Destroy();
--				end;
--			end;
--			local v2229 = v0.Instance.new("BodyVelocity");
--			v2229.MaxForce = v0.Vector3.new(85000, 0, 85000);
--			v2229.Name = "WolfFangFlashForward";
--			local v2230 = v0.Instance.new("NumberValue");
--			v2230.Value = 40;
--			v2230.Parent = v2229;
--			local l_v2230_0 = v2230 --[[ copy: 3 -> 364 ]];
--			local l_v2229_0 = v2229 --[[ copy: 2 -> 365 ]];
--			v2230:GetPropertyChangedSignal("Value"):Connect(function()
--				if l_v2230_0.Value <= 3 and l_v2229_0 ~= nil and l_v2229_0.Parent ~= nil then
--					l_v2229_0:Destroy();
--				end;
--			end);
--			local v2233 = l_TweenService_0:Create(v2230, v0.TweenInfo.new(1.6, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--				Value = 0
--			});
--			v2233.Completed:Connect(function()
--				if l_v2229_0 ~= nil and l_v2229_0.Parent ~= nil then
--					l_v2229_0:Destroy();
--				end;
--			end);
--			v2229.Parent = l_HumanoidRootPart_0;
--			v2233:Play();
--			v0.task.spawn(function()
--				while l_v2229_0 ~= nil and l_v2229_0.Parent ~= nil do
--					l_v2229_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * l_v2230_0.Value;
--					v0.task.wait();
--				end;
--			end);
--		end;
--		if l_Request_1 == "WolfFangFlashWalkBack" then
--			for _, v2235 in v0.pairs(l_HumanoidRootPart_0:GetChildren()) do
--				if v2235:IsA("BodyVelocity") and (not (v2235.Name ~= "WolfFangFlashWalkBack" and v2235.Name ~= "WolfFangFlashBack") or v2235.Name == "WolfFangFlashForward") then
--					v2235:Destroy();
--				end;
--			end;
--			local v2236 = v0.Instance.new("BodyVelocity");
--			v2236.MaxForce = v0.Vector3.new(75000, 0, 75000);
--			v2236.Name = "WolfFangFlashWalkBack";
--			local v2237 = v0.Instance.new("NumberValue");
--			v2237.Value = 40;
--			v2237.Parent = v2236;
--			local l_v2237_0 = v2237 --[[ copy: 3 -> 362 ]];
--			local l_v2236_0 = v2236 --[[ copy: 2 -> 363 ]];
--			v2237:GetPropertyChangedSignal("Value"):Connect(function()
--				if l_v2237_0.Value <= 3 and l_v2236_0 ~= nil and l_v2236_0.Parent ~= nil then
--					l_v2236_0:Destroy();
--				end;
--			end);
--			local v2240 = l_TweenService_0:Create(v2237, v0.TweenInfo.new(1.6, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--				Value = 0
--			});
--			v2240.Completed:Connect(function()
--				if l_v2236_0 ~= nil and l_v2236_0.Parent ~= nil then
--					l_v2236_0:Destroy();
--				end;
--			end);
--			v2236.Parent = l_HumanoidRootPart_0;
--			v2240:Play();
--			v0.task.spawn(function()
--				while l_v2236_0 ~= nil and l_v2236_0.Parent ~= nil do
--					l_v2236_0.Velocity = -l_HumanoidRootPart_0.CFrame.LookVector * l_v2237_0.Value;
--					v0.task.wait();
--				end;
--			end);
--		end;
--		if l_Request_1 == "WolfFangFlashBack" then
--			local v2241 = v0.Instance.new("BodyVelocity");
--			v2241.MaxForce = v0.Vector3.new(75000, 0, 75000);
--			v2241.Name = "WolfFangFlashBack";
--			local v2242 = v0.Instance.new("NumberValue");
--			v2242.Value = 132;
--			v2242.Parent = v2241;
--			local l_v2242_0 = v2242 --[[ copy: 3 -> 360 ]];
--			local l_v2241_0 = v2241 --[[ copy: 2 -> 361 ]];
--			v2242:GetPropertyChangedSignal("Value"):Connect(function()
--				if l_v2242_0.Value <= 3 and l_v2241_0 ~= nil and l_v2241_0.Parent ~= nil then
--					l_v2241_0:Destroy();
--				end;
--			end);
--			local v2245 = l_TweenService_0:Create(v2242, v0.TweenInfo.new(0.9, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--				Value = 0
--			});
--			v2245.Completed:Connect(function()
--				if l_v2241_0 ~= nil and l_v2241_0.Parent ~= nil then
--					l_v2241_0:Destroy();
--				end;
--			end);
--			v2241.Parent = l_HumanoidRootPart_0;
--			v2245:Play();
--			v0.task.spawn(function()
--				while l_v2241_0 ~= nil and l_v2241_0.Parent ~= nil do
--					l_v2241_0.Velocity = -l_HumanoidRootPart_0.CFrame.LookVector * l_v2242_0.Value;
--					v0.task.wait();
--				end;
--			end);
--		end;
--		if l_Request_1 == "EndDraconicHonorCamera" then
--			VFXService.ScreenFlash();
--			l_CurrentCamera_1.CFrame = (l_HumanoidRootPart_0.CFrame - l_HumanoidRootPart_0.CFrame.LookVector * 3 + v0.Vector3.new(0, 8, 0)) * v0.CFrame.Angles(-v0.math.pi / 8, 0, 0);
--			VFXService.EndCutscene();
--			l_Humanoid_0.CameraOffset = v0.Vector3.new(0, 35, 0);
--			VFXService.ShakeCamera(0, 0.8, 37, 0.75, 0.75, 0.75);
--		end;
--		if l_Request_1 == "DraconicHonorDrag" then
--			v0.task.delay(0.11, function()
--				VFXService.EndCutscene();
--				VFXService.ShakeCamera(0.4, 9, 27, 0.12, 0.12, 0.05);
--			end);
--			local v2246 = v0.Instance.new("BodyVelocity");
--			v2246.MaxForce = v0.Vector3.new(125000, 0, 125000);
--			v2246.Name = "DraconicHonorDrag";
--			local v2247 = v0.Instance.new("NumberValue");
--			v2247.Value = 5;
--			v2247.Parent = v2246;
--			local v2248 = l_TweenService_0:Create(v2247, v0.TweenInfo.new(0.9, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--				Value = 174
--			});
--			v2246.Parent = l_HumanoidRootPart_0;
--			v2248:Play();
--			local l_v2246_0 = v2246 --[[ copy: 2 -> 358 ]];
--			VFXService.CreateBind(v26, "DraconicHonorDragVelocity", function()
--				if l_v2246_0 ~= nil and l_v2246_0.Parent ~= nil then
--					l_v2246_0:Destroy();
--				end;
--			end);
--			local l_v2247_0 = v2247 --[[ copy: 3 -> 359 ]];
--			v0.task.spawn(function()
--				while l_v2246_0 ~= nil and l_v2246_0.Parent ~= nil do
--					l_v2246_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * l_v2247_0.Value;
--					v0.task.wait();
--				end;
--			end);
--		end;
--		if l_Request_1 == "EndDraconicHonorDrag" then
--			VFXService.EndCameraShake();
--			local _, v2252 = VFXService.InitiateCutscene("DraconicHonor", 60, 129318406560215, l_HumanoidRootPart_0, nil, {
--				Time = 1.3, 
--				EasingStyle = v0.Enum.EasingStyle.Exponential, 
--				EasingDirection = v0.Enum.EasingDirection.Out
--			});
--			VFXService.DestroyBind(v26, "DraconicHonorDragVelocity");
--			local v2253 = {
--				18711783182, 
--				18711785716, 
--				18711787400, 
--				18711790052, 
--				18711792009, 
--				18711793464, 
--				18711795078, 
--				18711799033, 
--				18711801569, 
--				18711803428, 
--				18711805242, 
--				18711807134, 
--				18711810676, 
--				18711812726
--			};
--			VFXService.PreloadImages({
--				"rbxassetid://18711783182", 
--				"rbxassetid://18711785716", 
--				"rbxassetid://18711787400", 
--				"rbxassetid://18711790052", 
--				"rbxassetid://18711792009", 
--				"rbxassetid://18711793464", 
--				"rbxassetid://18711795078", 
--				"rbxassetid://18711799033", 
--				"rbxassetid://18711801569", 
--				"rbxassetid://18711803428", 
--				"rbxassetid://18711805242", 
--				"rbxassetid://18711807134", 
--				"rbxassetid://18711810676", 
--				"rbxassetid://18711812726"
--			}, 10);
--			local l_v2253_0 = v2253 --[[ copy: 4 -> 357 ]];
--			v2252:GetMarkerReachedSignal("Sequence"):Connect(function()
--				VFXService.ImpactFrameSequence(l_v2253_0);
--			end);
--		end;
--		if l_Request_1 == "DraconicHonorCameraPart2" then
--			local l_Relative_1 = v724.Relative;
--			if not (l_Relative_1 ~= nil) or l_Relative_1.Parent == nil then
--				return;
--			else
--				VFXService.EndCameraShake();
--				local _, v2257 = VFXService.InitiateCutscene("DraconicHonor", 60, 129318406560215, l_Relative_1, nil, {
--					Time = 1.3, 
--					EasingStyle = v0.Enum.EasingStyle.Exponential, 
--					EasingDirection = v0.Enum.EasingDirection.Out
--				});
--				local v2258 = {
--					18711783182, 
--					18711785716, 
--					18711787400, 
--					18711790052, 
--					18711792009, 
--					18711793464, 
--					18711795078, 
--					18711799033, 
--					18711801569, 
--					18711803428, 
--					18711805242, 
--					18711807134, 
--					18711810676, 
--					18711812726
--				};
--				VFXService.PreloadImages({
--					"rbxassetid://18711783182", 
--					"rbxassetid://18711785716", 
--					"rbxassetid://18711787400", 
--					"rbxassetid://18711790052", 
--					"rbxassetid://18711792009", 
--					"rbxassetid://18711793464", 
--					"rbxassetid://18711795078", 
--					"rbxassetid://18711799033", 
--					"rbxassetid://18711801569", 
--					"rbxassetid://18711803428", 
--					"rbxassetid://18711805242", 
--					"rbxassetid://18711807134", 
--					"rbxassetid://18711810676", 
--					"rbxassetid://18711812726"
--				}, 10);
--				local l_v2258_0 = v2258 --[[ copy: 5 -> 356 ]];
--				v2257:GetMarkerReachedSignal("Sequence"):Connect(function()
--					VFXService.ImpactFrameSequence(l_v2258_0);
--				end);
--			end;
--		end;
--		if l_Request_1 == "DraconicHonorCamera" then
--			local l_Relative_2 = v724.Relative;
--			if not (l_Relative_2 ~= nil) or l_Relative_2.Parent == nil then
--				return;
--			else
--				local _, v2262 = VFXService.InitiateCutscene("DraconicHonor", 60, 78455352837872, l_Relative_2, nil, {
--					Time = 1.3, 
--					EasingStyle = v0.Enum.EasingStyle.Exponential, 
--					EasingDirection = v0.Enum.EasingDirection.Out
--				}, {
--					Time = 0.23
--				});
--				local v2263 = {
--					18711752102, 
--					18711754358, 
--					18711756629, 
--					18711759426, 
--					18711762379, 
--					18711764890
--				};
--				local v2264 = {
--					18711767617, 
--					18711769696, 
--					18711775912, 
--					18711778161, 
--					18711780125
--				};
--				VFXService.PreloadImages({
--					"rbxassetid://18711752102", 
--					"rbxassetid://18711754358", 
--					"rbxassetid://18711756629", 
--					"rbxassetid://18711759426", 
--					"rbxassetid://18711762379", 
--					"rbxassetid://18711764890", 
--					"rbxassetid://18711767617", 
--					"rbxassetid://18711769696", 
--					"rbxassetid://18711775912", 
--					"rbxassetid://18711778161", 
--					"rbxassetid://18711780125"
--				});
--				local l_v2263_0 = v2263 --[[ copy: 5 -> 354 ]];
--				v2262:GetMarkerReachedSignal("Sequence1"):Connect(function()
--					VFXService.ImpactFrameSequence(l_v2263_0);
--				end);
--				local l_v2264_0 = v2264 --[[ copy: 6 -> 355 ]];
--				v2262:GetMarkerReachedSignal("Sequence2"):Connect(function()
--					VFXService.ImpactFrameSequence(l_v2264_0);
--				end);
--			end;
--		end;
--		if l_Request_1 == "DraconicHonorSlideEffects" then
--			local l_On_141 = v724.On;
--			if not (l_On_141 ~= nil) or l_On_141.Parent == nil then
--				return;
--			else
--				local v2268 = l_Assets_0.Particles.MartialArtist.DraconicHonor.SlideSmoke.Attachment:Clone();
--				v2268.Parent = l_On_141["Right Leg"];
--				local v2269 = v0.Vector3.new(0, -5, 0);
--				local v2270 = nil;
--				local l_l_On_141_0 = l_On_141 --[[ copy: 2 -> 351 ]];
--				local l_v2269_0 = v2269 --[[ copy: 4 -> 352 ]];
--				local l_v2268_0 = v2268 --[[ copy: 3 -> 353 ]];
--				v2270 = v0.task.spawn(function()
--					local l_Children_3 = l_Assets_0.Particles.MartialArtist.DraconicHonor.SlideSmokeParticles:GetChildren();
--					while l_l_On_141_0 ~= nil and l_l_On_141_0.Parent ~= nil and l_l_On_141_0.HumanoidRootPart ~= nil and l_l_On_141_0.HumanoidRootPart.Parent ~= nil do
--						if l_l_On_141_0.HumanoidRootPart.AssemblyLinearVelocity.Magnitude <= 10 then
--							v0.task.wait();
--						else
--							local l_Position_13 = l_l_On_141_0.HumanoidRootPart.Position;
--							local v2276 = workspace:Raycast(l_Position_13, l_v2269_0, v72);
--							if v2276 then
--								VFXService.EmitFromAttachment(l_v2268_0, l_Children_3, nil, nil, nil, VFXService.MakeDarker(v2276.Instance.Color, -50, -50, -50));
--							end;
--							v0.task.wait();
--						end;
--					end;
--					l_Children_3 = nil;
--				end);
--				do
--					local l_v2270_0 = v2270;
--					VFXService.CreateBind(l_On_141, "DraconicHonorSlideSmoke", function()
--						v0.pcall(function()
--							v0.task.cancel(l_v2270_0);
--						end);
--						v0.task.delay(1.5, function()
--							if l_v2268_0 ~= nil and l_v2268_0.Parent ~= nil then
--								l_v2268_0:Destroy();
--							end;
--						end);
--					end);
--				end;
--			end;
--		end;
--		if l_Request_1 == "EndDraconicHonorSlideEffects" then
--			local l_On_142 = v724.On;
--			if not (l_On_142 ~= nil) or l_On_142.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_142, "DraconicHonorSlideSmoke");
--			end;
--		end;
--		if l_Request_1 == "DraconicHonorSlide" then
--			for _, v2280 in v0.pairs(l_HumanoidRootPart_0:GetChildren()) do
--				if v2280:IsA("BodyVelocity") and (not (v2280.Name ~= "DraconicHonorJumpVelocity" and v2280.Name ~= "DraconicHonorRunVelocity" and v2280.Name ~= "DraconicHonorEndRunVelocity") or v2280.Name == "DraconicHonorSlideVelocity") then
--					v2280:Destroy();
--				end;
--			end;
--			local v2281 = v0.Instance.new("BodyVelocity");
--			v2281.MaxForce = v0.Vector3.new(89000, 0, 89000);
--			v2281.Name = "DraconicHonorSlideVelocity";
--			local v2282 = v0.Instance.new("NumberValue");
--			v2282.Value = 300;
--			v2282.Parent = v2281;
--			local l_v2282_0 = v2282 --[[ copy: 3 -> 349 ]];
--			local l_v2281_0 = v2281 --[[ copy: 2 -> 350 ]];
--			v2282:GetPropertyChangedSignal("Value"):Connect(function()
--				if l_v2282_0.Value <= 8 and l_v2281_0 ~= nil and l_v2281_0.Parent ~= nil then
--					l_v2281_0:Destroy();
--				end;
--			end);
--			local v2285 = l_TweenService_0:Create(v2282, v0.TweenInfo.new(1.7, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--				Value = 0
--			});
--			v2285.Completed:Connect(function()
--				if l_v2281_0 ~= nil and l_v2281_0.Parent ~= nil then
--					l_v2281_0:Destroy();
--				end;
--			end);
--			v2281.Parent = l_HumanoidRootPart_0;
--			v2285:Play();
--			v0.task.spawn(function()
--				while l_v2281_0 ~= nil and l_v2281_0.Parent ~= nil do
--					l_v2281_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * l_v2282_0.Value;
--					v0.task.wait();
--				end;
--			end);
--		end;
--		if l_Request_1 == "EndDraconicHonorRun" then
--			for _, v2287 in v0.pairs(l_HumanoidRootPart_0:GetChildren()) do
--				if v2287:IsA("BodyVelocity") and (not (v2287.Name ~= "DraconicHonorJumpVelocity") or v2287.Name == "DraconicHonorRunVelocity") then
--					v2287:Destroy();
--				end;
--			end;
--			local v2288 = v0.Instance.new("BodyVelocity");
--			v2288.MaxForce = v0.Vector3.new(80000, 0, 80000);
--			v2288.Name = "DraconicHonorEndRunVelocity";
--			local v2289 = v0.Instance.new("NumberValue");
--			v2289.Value = 408.83;
--			v2289.Parent = v2288;
--			local l_v2289_0 = v2289 --[[ copy: 3 -> 345 ]];
--			local l_v2288_0 = v2288 --[[ copy: 2 -> 346 ]];
--			v2289:GetPropertyChangedSignal("Value"):Connect(function()
--				if l_v2289_0.Value <= 5 and l_v2288_0 ~= nil and l_v2288_0.Parent ~= nil then
--					l_v2288_0:Destroy();
--				end;
--			end);
--			local v2292 = l_TweenService_0:Create(v2289, v0.TweenInfo.new(1.4, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--				Value = 0
--			});
--			local v2293 = l_TweenService_0:Create(v2289, v0.TweenInfo.new(0.3, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--				Value = 0
--			});
--			v2288.Parent = l_HumanoidRootPart_0;
--			v2292:Play();
--			local l_v2292_0 = v2292 --[[ copy: 4 -> 347 ]];
--			local l_v2293_0 = v2293 --[[ copy: 5 -> 348 ]];
--			v0.task.spawn(function()
--				local v2296 = v0.Vector3.new(11, 2.5, 6);
--				local v2297 = v2296.Z / 2;
--				local v2298 = v0.OverlapParams.new();
--				v2298.FilterDescendantsInstances = {
--					l_Characters_0
--				};
--				v2298.FilterType = v0.Enum.RaycastFilterType.Include;
--				while l_v2288_0 ~= nil and l_v2288_0.Parent ~= nil do
--					local v2299 = v0.Instance.new("Part");
--					v2299.Transparency = 1;
--					v2299.Size = v2296;
--					v2299.CFrame = l_HumanoidRootPart_0.CFrame + l_HumanoidRootPart_0.CFrame.LookVector * v2297;
--					v2299.Massless = true;
--					v2299.EnableFluidForces = false;
--					v2299.CastShadow = false;
--					v2299.CanCollide = false;
--					v2299.Anchored = true;
--					v2299.Parent = l_VFX_0;
--					local v2300 = nil;
--					do
--						local l_v2300_0 = v2300;
--						l_v2300_0 = v2299.Touched:Connect(function()
--							if l_v2300_0 ~= nil then
--								l_v2300_0:Disconnect();
--								l_v2300_0 = nil;
--							end;
--						end);
--						for _, v2303 in v0.pairs(workspace:GetPartsInPart(v2299, v2298)) do
--							if v2303.Name == "HumanoidRootPart" and (v2303:IsDescendantOf(l_Characters_0) or v2303:IsDescendantOf(l_FlyingRocksStorage_0)) and not v2303:IsDescendantOf(v26) then
--								if l_v2292_0 ~= nil then
--									l_v2292_0:Cancel();
--								end;
--								if l_v2293_0 ~= nil then
--									l_v2293_0:Play();
--									break;
--								else
--									break;
--								end;
--							end;
--						end;
--						v2299:Destroy();
--						if l_v2288_0 ~= nil and l_v2288_0.Parent ~= nil then
--							l_v2288_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * l_v2289_0.Value;
--						end;
--					end;
--					v0.task.wait();
--				end;
--			end);
--		end;
--		if l_Request_1 == "DraconicHonorRunEffects" then
--			local l_On_143 = v724.On;
--			if not (l_On_143 ~= nil) or l_On_143.Parent == nil then
--				return;
--			else
--				local v2305 = l_Assets_0.Particles.MartialArtist.DraconicHonor.Run:Clone();
--				local v2306 = v0.Instance.new("WeldConstraint");
--				v2306.Part0 = l_On_143.HumanoidRootPart;
--				v2305.CFrame = l_On_143.HumanoidRootPart.CFrame - l_On_143.HumanoidRootPart.CFrame.LookVector;
--				v2306.Parent = v2305;
--				v2305.Parent = l_VFX_0;
--				v2306.Part1 = v2305;
--				local l_v2306_0 = v2306 --[[ copy: 4 -> 343 ]];
--				local l_v2305_0 = v2305 --[[ copy: 3 -> 344 ]];
--				VFXService.CreateBind(l_On_143, "DraconicHonorRunEffects", function()
--					if l_v2306_0 ~= nil and l_v2306_0.Parent ~= nil then
--						l_v2306_0:Destroy();
--					end;
--					if l_v2305_0 ~= nil and l_v2305_0.Parent ~= nil then
--						l_v2305_0.Anchored = true;
--						for _, v2310 in v0.pairs(l_v2305_0:GetDescendants()) do
--							if v2310:IsA("ParticleEmitter") or v2310:IsA("Beam") then
--								v2310.Enabled = false;
--							end;
--						end;
--						VFXService.DestroyParticleContainer(l_v2305_0, 3);
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "DraconicHonorVictimSound" then
--			local l_On_144 = v724.On;
--			if not (l_On_144 ~= nil) or l_On_144.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_144.Torso, "DraconicHonorVictim");
--			end;
--		end;
--		if l_Request_1 == "DraconicHonorUserSound" then
--			local l_On_145 = v724.On;
--			if not (l_On_145 ~= nil) or l_On_145.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_145.Torso, "DraconicHonorUser");
--			end;
--		end;
--		if l_Request_1 == "DraconicHonorUserBoarhavenSound" then
--			local l_On_146 = v724.On;
--			if not (l_On_146 ~= nil) or l_On_146.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_146.Torso, "DraconicHonorUserBoarhaven");
--			end;
--		end;
--		if l_Request_1 == "DraconicHonorAttackSound" then
--			local l_On_147 = v724.On;
--			if not (l_On_147 ~= nil) or l_On_147.Parent == nil then
--				return;
--			else
--				local v2315 = v104.PlaySoundInInstance(l_On_147.HumanoidRootPart, "DraconicHonorAttack");
--				local v2316 = l_TweenService_0:Create(v2315, v0.TweenInfo.new(0.2, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--					Volume = 0
--				});
--				local l_v2315_0 = v2315 --[[ copy: 3 -> 340 ]];
--				v2316.Completed:Connect(function()
--					if l_v2315_0 ~= nil and l_v2315_0.Parent ~= nil then
--						l_v2315_0:Destroy();
--					end;
--				end);
--				local l_v2316_0 = v2316 --[[ copy: 4 -> 341 ]];
--				local v2319 = VFXService.CreateBind(l_On_147, "DraconicHonorAttackSound", function()
--					if l_v2315_0 ~= nil and l_v2315_0.Parent ~= nil then
--						l_v2315_0:SetAttribute("DefaultVolume", nil);
--						l_v2316_0:Play();
--					end;
--				end);
--				local l_v2319_0 = v2319 --[[ copy: 5 -> 342 ]];
--				v2315.Ended:Connect(function()
--					if l_v2319_0 ~= nil and l_v2319_0.Parent ~= nil then
--						l_v2319_0:Destroy();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndDraconicHonorAttackSound" then
--			local l_On_148 = v724.On;
--			if not (l_On_148 ~= nil) or l_On_148.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_148, "DraconicHonorAttackSound");
--			end;
--		end;
--		if l_Request_1 == "EndDraconicHonorRunEffects" then
--			local l_On_149 = v724.On;
--			if not (l_On_149 ~= nil) or l_On_149.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_149, "DraconicHonorRunEffects");
--				local v2323 = l_Assets_0.Particles.MartialArtist.DraconicHonor.SecondJump:Clone();
--				v2323.CFrame = l_On_149.HumanoidRootPart.CFrame * v0.CFrame.Angles(-v0.math.pi / 2, 0, 0);
--				v2323.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v2323);
--				VFXService.DestroyParticleContainer(v2323, 3);
--			end;
--		end;
--		if l_Request_1 == "DraconicHonorRun" then
--			local v2324 = v0.Instance.new("BodyVelocity");
--			v2324.MaxForce = v0.Vector3.new(135000, 0, 135000);
--			v2324.Name = "DraconicHonorRunVelocity";
--			for _, v2326 in v0.pairs(l_HumanoidRootPart_0:GetChildren()) do
--				if v2326:IsA("BodyVelocity") and v2326.Name == "DraconicHonorJumpVelocity" then
--					v2326:Destroy();
--				end;
--			end;
--			v2324.Parent = l_HumanoidRootPart_0;
--			local l_v2324_0 = v2324 --[[ copy: 2 -> 339 ]];
--			v0.task.spawn(function()
--				while l_v2324_0 ~= nil and l_v2324_0.Parent ~= nil do
--					l_v2324_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * 135;
--					v0.task.wait();
--				end;
--			end);
--		end;
--		if l_Request_1 == "DraconicHonorJump" then
--			local v2328 = v0.Instance.new("BodyVelocity");
--			v2328.MaxForce = v0.Vector3.new(259000, 0, 259000);
--			v2328.Name = "DraconicHonorJumpVelocity";
--			local v2329 = v0.Instance.new("NumberValue");
--			v2329.Value = 600;
--			v2329.Parent = v2328;
--			local v2330 = l_TweenService_0:Create(v2329, v0.TweenInfo.new(1.4, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--				Value = 135
--			});
--			local l_v2328_0 = v2328 --[[ copy: 2 -> 337 ]];
--			v2330.Completed:Connect(function()
--				if l_v2328_0 ~= nil and l_v2328_0.Parent ~= nil then
--					l_v2328_0:Destroy();
--				end;
--			end);
--			v2328.Parent = l_HumanoidRootPart_0;
--			v2330:Play();
--			local l_v2329_0 = v2329 --[[ copy: 3 -> 338 ]];
--			v0.task.spawn(function()
--				while l_v2328_0 ~= nil and l_v2328_0.Parent ~= nil do
--					l_v2328_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * l_v2329_0.Value;
--					v0.task.wait();
--				end;
--			end);
--		end;
--		if l_Request_1 == "GlimpseOfPowerLegAura" then
--			local l_On_150 = v724.On;
--			if not (l_On_150 ~= nil) or l_On_150.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_150.HumanoidRootPart, "GlimpseOfPowerUser");
--				local v2334 = {};
--				for _, v2336 in v0.pairs(l_Assets_0.Particles.Jun.GlimpseOfPower.LegAura:GetChildren()) do
--					local v2337 = v2336:Clone();
--					v0.table.insert(v2334, v2337);
--					v2337.Parent = l_On_150["Right Leg"];
--				end;
--				local l_v2334_0 = v2334 --[[ copy: 3 -> 336 ]];
--				VFXService.CreateBind(l_On_150, "GlimpseOfPowerLegAuraEffect", function()
--					for _, v2340 in v0.pairs(l_v2334_0) do
--						if v2340 ~= nil and v2340.Parent ~= nil then
--							v2340.Enabled = false;
--							v0.task.delay(1.5, function()
--								if v2340 ~= nil and v2340.Parent ~= nil then
--									v2340:Destroy();
--								end;
--							end);
--						end;
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "JunDagger" then
--			local l_On_151 = v724.On;
--			if not (l_On_151 ~= nil) or l_On_151.Parent == nil then
--				return;
--			else
--				local v2342 = v0.Instance.new("Motor6D");
--				v2342.Name = "HandleR";
--				v2342.Part0 = l_On_151["Right Arm"];
--				v2342.C0 = v0.CFrame.new(0, -1, 0);
--				v2342.Parent = l_On_151["Right Arm"];
--				local v2343 = l_Assets_0.Parts.Jun.Dagger:Clone();
--				v2342.Part1 = v2343.HandleR;
--				v2343.Parent = l_On_151;
--				local l_v2343_0 = v2343 --[[ copy: 4 -> 334 ]];
--				local l_v2342_0 = v2342 --[[ copy: 3 -> 335 ]];
--				VFXService.CreateBind(l_On_151, "JunDaggerJoint", function()
--					if l_v2343_0 ~= nil and l_v2343_0.Parent ~= nil then
--						l_v2343_0:Destroy();
--					end;
--					if l_v2342_0 ~= nil and l_v2342_0.Parent ~= nil then
--						l_v2342_0:Destroy();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndJunDagger" then
--			local l_On_152 = v724.On;
--			if not (l_On_152 ~= nil) or l_On_152.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_152, "JunDaggerJoint");
--			end;
--		end;
--		if l_Request_1 == "JunKunai" then
--			local l_On_153 = v724.On;
--			if not (l_On_153 ~= nil) or l_On_153.Parent == nil then
--				return;
--			else
--				local v2348 = v0.Instance.new("Motor6D");
--				v2348.Name = "HandleL";
--				v2348.Part0 = l_On_153["Left Arm"];
--				v2348.C0 = v0.CFrame.new(0, -1, 0);
--				v2348.Parent = l_On_153["Left Arm"];
--				local v2349 = l_Assets_0.Parts.Jun.Kunai:Clone();
--				v2349.Parent = l_On_153;
--				v2348.Part1 = v2349.HandleL;
--				local l_v2349_0 = v2349 --[[ copy: 4 -> 332 ]];
--				local l_v2348_0 = v2348 --[[ copy: 3 -> 333 ]];
--				VFXService.CreateBind(l_On_153, "JunKunaiJoint", function()
--					if l_v2349_0 ~= nil and l_v2349_0.Parent ~= nil then
--						l_v2349_0:Destroy();
--					end;
--					if l_v2348_0 ~= nil and l_v2348_0.Parent ~= nil then
--						l_v2348_0:Destroy();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndJunKunai" then
--			local l_On_154 = v724.On;
--			if not (l_On_154 ~= nil) or l_On_154.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_154, "JunKunaiJoint");
--			end;
--		end;
--		if l_Request_1 == "JunSword" then
--			local l_On_155 = v724.On;
--			if not (l_On_155 ~= nil) or l_On_155.Parent == nil then
--				return;
--			else
--				local v2354 = v0.Instance.new("Motor6D");
--				v2354.Name = "HandleR";
--				v2354.Part0 = l_On_155["Right Arm"];
--				v2354.C0 = v0.CFrame.new(-0.25, -1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
--				v2354.Parent = l_On_155["Right Arm"];
--				local v2355 = v0.Instance.new("Motor6D");
--				v2355.Name = "HandleT";
--				v2355.Part0 = l_On_155.Torso;
--				v2355.C0 = v0.CFrame.new(-1, -0.999999762, -1.1920929E-6, 0.999997139, 0, 0, 0, 0.939693272, -0.342020482, 0, 0.342020482, 0.939693272);
--				v2355.Parent = l_On_155.Torso;
--				local v2356 = l_Assets_0.Parts.Jun.Katana:Clone();
--				v2354.Part1 = v2356.HandleR;
--				v2356.Parent = l_On_155;
--				local v2357 = l_Assets_0.Parts.Jun.Sheathe:Clone();
--				v2355.Part1 = v2357.HandleT;
--				v2357.Parent = l_On_155;
--				local l_v2356_0 = v2356 --[[ copy: 5 -> 328 ]];
--				local l_v2354_0 = v2354 --[[ copy: 3 -> 329 ]];
--				local l_v2357_0 = v2357 --[[ copy: 6 -> 330 ]];
--				local l_v2355_0 = v2355 --[[ copy: 4 -> 331 ]];
--				VFXService.CreateBind(l_On_155, "JunSwordJoints", function()
--					if l_v2356_0 ~= nil and l_v2356_0.Parent ~= nil then
--						l_v2356_0:Destroy();
--					end;
--					if l_v2354_0 ~= nil and l_v2354_0.Parent ~= nil then
--						l_v2354_0:Destroy();
--					end;
--					if l_v2357_0 ~= nil and l_v2357_0.Parent ~= nil then
--						l_v2357_0:Destroy();
--					end;
--					if l_v2355_0 ~= nil and l_v2355_0.Parent ~= nil then
--						l_v2355_0:Destroy();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndJunSword" then
--			local l_On_156 = v724.On;
--			if not (l_On_156 ~= nil) or l_On_156.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_156, "JunSwordJoints");
--			end;
--		end;
--		if l_Request_1 == "EndGlimpseOfPowerLegAura" then
--			local l_On_157 = v724.On;
--			if not (l_On_157 ~= nil) or l_On_157.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_157, "GlimpseOfPowerLegAuraEffect");
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerFinisherHit1" then
--			local l_On_158 = v724.On;
--			if not (l_On_158 ~= nil) or l_On_158.Parent == nil then
--				return;
--			else
--				local v2365 = l_Assets_0.Particles.Jun.GlimpseOfPower.Finisher.Hit1:Clone();
--				v2365.CFrame = l_On_158.HumanoidRootPart.CFrame;
--				local v2366 = VFXService.FindGroundPosition(v2365.Position);
--				if v2366 then
--					local v2367 = v0.ColorSequence.new(v2366.Instance.Color);
--					for _, v2369 in v0.pairs(v2365:GetDescendants()) do
--						if v2369:IsA("ParticleEmitter") and v2369.Name == "Smoke" then
--							v2369.Color = v2367;
--						end;
--					end;
--				end;
--				if v88.Blood == false then
--					for _, v2371 in v0.pairs(v2365:GetDescendants()) do
--						if v2371:IsA("ParticleEmitter") and v2371.Name == "Blood" then
--							v2371:Destroy();
--						end;
--					end;
--				end;
--				v2365.Parent = l_VFX_0;
--				if (v2365.Position - l_HumanoidRootPart_0.Position).Magnitude <= 29 then
--					VFXService.ShakeCamera(0, 0.4, 13.5, 0.25, 0.5, 0.25);
--				end;
--				VFXService.EmitParticlesInInstance(v2365);
--				VFXService.DestroyParticleContainer(v2365, 4);
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerFinisherHit2" then
--			local l_On_159 = v724.On;
--			if not (l_On_159 ~= nil) or l_On_159.Parent == nil then
--				return;
--			else
--				local v2373 = l_Assets_0.Particles.Jun.GlimpseOfPower.Finisher.Hit2:Clone();
--				v2373.CFrame = l_On_159.HumanoidRootPart.CFrame;
--				local v2374 = VFXService.FindGroundPosition(v2373.Position);
--				if v2374 then
--					local v2375 = v0.ColorSequence.new(v2374.Instance.Color);
--					for _, v2377 in v0.pairs(v2373:GetDescendants()) do
--						if v2377:IsA("ParticleEmitter") and v2377.Name == "Smoke" then
--							v2377.Color = v2375;
--						end;
--					end;
--				end;
--				if v88.Blood == false then
--					for _, v2379 in v0.pairs(v2373:GetDescendants()) do
--						if v2379:IsA("ParticleEmitter") and v2379.Name == "Blood" then
--							v2379:Destroy();
--						end;
--					end;
--				end;
--				v2373.Parent = l_VFX_0;
--				if (v2373.Position - l_HumanoidRootPart_0.Position).Magnitude <= 29 then
--					VFXService.ShakeCamera(0, 0.4, 13.5, 0.25, 0.5, 0.25);
--				end;
--				VFXService.EmitParticlesInInstance(v2373);
--				VFXService.DestroyParticleContainer(v2373, 4);
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerFinisherArmsVisible" then
--			local l_On_160 = v724.On;
--			if not (l_On_160 ~= nil) or l_On_160.Parent == nil then
--				return;
--			else
--				if l_On_160:FindFirstChild("Right Arm") then
--					l_On_160["Right Arm"].Transparency = 0;
--				end;
--				if l_On_160:FindFirstChild("Left Arm") then
--					l_On_160["Left Arm"].Transparency = 0;
--				end;
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerFinisherSlash1" then
--			local l_On_161 = v724.On;
--			if not (l_On_161 ~= nil) or l_On_161.Parent == nil then
--				return;
--			else
--				local v2382 = l_Assets_0.Particles.Jun.GlimpseOfPower.Finisher.Slash1:Clone();
--				v2382.CFrame = l_On_161.HumanoidRootPart.CFrame;
--				local v2383 = VFXService.FindGroundPosition(v2382.Position);
--				if v2383 then
--					local v2384 = v0.ColorSequence.new(v2383.Instance.Color);
--					for _, v2386 in v0.pairs(v2382:GetDescendants()) do
--						if v2386:IsA("ParticleEmitter") and v2386.Name == "Smoke" then
--							v2386.Color = v2384;
--						end;
--					end;
--				end;
--				if v88.Blood == false then
--					for _, v2388 in v0.pairs(v2382:GetDescendants()) do
--						if v2388:IsA("ParticleEmitter") and v2388.Name == "Blood" then
--							v2388:Destroy();
--						end;
--					end;
--				end;
--				v2382.Parent = l_VFX_0;
--				if (v2382.Position - l_HumanoidRootPart_0.Position).Magnitude <= 37 then
--					VFXService.ShakeCamera(0, 0.4, 17, 0.25, 0.5, 0.25);
--				end;
--				VFXService.EmitParticlesInInstance(v2382);
--				VFXService.DestroyParticleContainer(v2382, 4);
--				local v2389 = v0.Instance.new("Model");
--				v0.Instance.new("Humanoid").Parent = v2389;
--				v2389.Name = "ArmClone";
--				for _, v2391 in v0.pairs(l_On_161:GetChildren()) do
--					if v2391:IsA("Shirt") then
--						v2391:Clone().Parent = v2389;
--					end;
--				end;
--				local v2392 = l_On_161["Left Arm"]:Clone();
--				v2392.CollisionGroup = "Flying Rocks";
--				local v2393 = l_TweenService_0:Create(v2392, v0.TweenInfo.new(0.3, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--					Transparency = 1, 
--					Size = v2392.Size / 2
--				});
--				local l_v2389_0 = v2389 --[[ copy: 5 -> 326 ]];
--				v2393.Completed:Connect(function()
--					if l_v2389_0 ~= nil and l_v2389_0.Parent ~= nil then
--						l_v2389_0:Destroy();
--					end;
--				end);
--				v2392.Parent = v2389;
--				l_On_161["Left Arm"].Transparency = 1;
--				v2389.Parent = l_VFX_0;
--				v2392.CanCollide = true;
--				v2392:ApplyImpulse(-l_On_161.HumanoidRootPart.CFrame.RightVector * 65 + v0.Vector3.new(0, 110, 0));
--				v2392:ApplyAngularImpulse(v0.Vector3.new(v0.math.random(-10, 10), v0.math.random(-10, 10), v0.math.random(-10, 10)));
--				local l_v2393_0 = v2393 --[[ copy: 8 -> 327 ]];
--				v0.task.delay(4, function()
--					if l_v2393_0 ~= nil then
--						l_v2393_0:Play();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerFinisherSlash2" then
--			local l_On_162 = v724.On;
--			if not (l_On_162 ~= nil) or l_On_162.Parent == nil then
--				return;
--			else
--				local v2397 = l_Assets_0.Particles.Jun.GlimpseOfPower.Finisher.Slash2:Clone();
--				v2397.CFrame = l_On_162.HumanoidRootPart.CFrame;
--				local v2398 = VFXService.FindGroundPosition(v2397.Position);
--				if v2398 then
--					local v2399 = v0.ColorSequence.new(v2398.Instance.Color);
--					for _, v2401 in v0.pairs(v2397:GetDescendants()) do
--						if v2401:IsA("ParticleEmitter") and v2401.Name == "Smoke" then
--							v2401.Color = v2399;
--						end;
--					end;
--				end;
--				if v88.Blood == false then
--					for _, v2403 in v0.pairs(v2397:GetDescendants()) do
--						if v2403:IsA("ParticleEmitter") and v2403.Name == "Blood" then
--							v2403:Destroy();
--						end;
--					end;
--				end;
--				v2397.Parent = l_VFX_0;
--				if (v2397.Position - l_HumanoidRootPart_0.Position).Magnitude <= 37 then
--					VFXService.ShakeCamera(0, 0.4, 17, 0.25, 0.5, 0.25);
--				end;
--				VFXService.EmitParticlesInInstance(v2397);
--				VFXService.DestroyParticleContainer(v2397, 4);
--				local v2404 = v0.Instance.new("Model");
--				v0.Instance.new("Humanoid").Parent = v2404;
--				v2404.Name = "ArmClone";
--				for _, v2406 in v0.pairs(l_On_162:GetChildren()) do
--					if v2406:IsA("Shirt") then
--						v2406:Clone().Parent = v2404;
--					end;
--				end;
--				local v2407 = l_On_162["Right Arm"]:Clone();
--				v2407.CollisionGroup = "Flying Rocks";
--				local v2408 = l_TweenService_0:Create(v2407, v0.TweenInfo.new(0.3, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--					Transparency = 1, 
--					Size = v2407.Size / 2
--				});
--				local l_v2404_0 = v2404 --[[ copy: 5 -> 324 ]];
--				v2408.Completed:Connect(function()
--					if l_v2404_0 ~= nil and l_v2404_0.Parent ~= nil then
--						l_v2404_0:Destroy();
--					end;
--				end);
--				v2407.Parent = v2404;
--				l_On_162["Right Arm"].Transparency = 1;
--				v2404.Parent = l_VFX_0;
--				v2407.CanCollide = true;
--				v2407:ApplyImpulse(l_On_162.HumanoidRootPart.CFrame.RightVector * 65 + v0.Vector3.new(0, 110, 0));
--				v2407:ApplyAngularImpulse(v0.Vector3.new(v0.math.random(-10, 10), v0.math.random(-10, 10), v0.math.random(-10, 10)));
--				local l_v2408_0 = v2408 --[[ copy: 8 -> 325 ]];
--				v0.task.delay(4, function()
--					if l_v2408_0 ~= nil then
--						l_v2408_0:Play();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerFinisherLastSlash" then
--			local l_On_163 = v724.On;
--			if not (l_On_163 ~= nil) or l_On_163.Parent == nil then
--				return;
--			else
--				local v2412 = v0.tostring(v724.Tag);
--				local function v2419(v2413, v2414, v2415, v2416)
--					for _, v2418 in v0.pairs(v2413:GetDescendants()) do
--						if v2418:IsA("ParticleEmitter") then
--							l_TweenService_0:Create(v2418, v0.TweenInfo.new(v2414, v0.Enum.EasingStyle.Quad, v0.Enum.EasingDirection[v2415]), {
--								TimeScale = v2416
--							}):Play();
--						end;
--					end;
--				end;
--				local function v2428(v2420, v2421)
--					for _, v2423 in v0.pairs(v2420:GetDescendants()) do
--						if v2423:IsA("Beam") then
--							v2423.Enabled = true;
--							local l_Brightness_1 = v2423.Brightness;
--							local l_LightEmission_0 = v2423.LightEmission;
--							v2423.Brightness = 0;
--							v2423.LightEmission = 1;
--							local v2426 = {
--								LightEmission = l_LightEmission_0, 
--								Brightness = l_Brightness_1
--							};
--							local v2427 = v0.TweenInfo.new(v2421);
--							l_TweenService_0:Create(v2423, v2427, v2426):Play();
--						end;
--						if v2423:IsA("Trail") then
--							v2423.Enabled = true;
--						end;
--					end;
--				end;
--				local function v2433(v2429)
--					for _, v2431 in v0.pairs(v2429:GetDescendants()) do
--						if v2431:IsA("Attachment") and v2431.Name == "Attachment" and v2431.Parent.Name == "A1" then
--							local l_Position_14 = v2431.Position;
--							v2431.Position = v2431.Position + v0.Vector3.new(0, 0, -v2431.Position.Z);
--							l_TweenService_0:Create(v2431, v0.TweenInfo.new(1.25), {
--								Position = l_Position_14
--							}):Play();
--						end;
--					end;
--				end;
--				local function v2437(v2434)
--					for _, v2436 in v0.pairs(v2434:GetDescendants()) do
--						if v2436:IsA("Beam") then
--							l_TweenService_0:Create(v2436, v0.TweenInfo.new(1, v0.Enum.EasingStyle.Quad, v0.Enum.EasingDirection.In), {
--								TextureSpeed = 15
--							}):Play();
--						end;
--					end;
--				end;
--				local v2438 = l_Assets_0.Particles.Jun.GlimpseOfPower.Finisher.Slash3:Clone();
--				v2438.CFrame = l_On_163.HumanoidRootPart.CFrame;
--				local v2439 = VFXService.FindGroundPosition(v2438.Position);
--				if v2439 then
--					local v2440 = v0.ColorSequence.new(v2439.Instance.Color);
--					for _, v2442 in v0.pairs(v2438:GetDescendants()) do
--						if v2442:IsA("ParticleEmitter") and v2442.Name == "Smoke" then
--							v2442.Color = v2440;
--						end;
--					end;
--				end;
--				if v88.Blood == false then
--					for _, v2444 in v0.pairs(v2438:GetDescendants()) do
--						if v2444:IsA("ParticleEmitter") and v2444.Name == "Blood" then
--							v2444:Destroy();
--						end;
--					end;
--				end;
--				v2438.Parent = l_VFX_0;
--				if (v2438.Position - l_HumanoidRootPart_0.Position).Magnitude <= 37 then
--					VFXService.ShakeCamera(0, 0.4, 26, 0.4, 0.4, 0.4);
--				end;
--				VFXService.EmitParticlesInInstance(v2438);
--				VFXService.DestroyParticleContainer(v2438, 4);
--				local v2445 = l_Assets_0.Particles.Jun.GlimpseOfPower.Finisher.Cone:Clone();
--				v2445.Name = "GlimpseOfPowerFinisherCone" .. v2412;
--				local v2446 = v0.Instance.new("WeldConstraint");
--				v2446.Parent = v2445;
--				v2446.Part0 = l_On_163.HumanoidRootPart;
--				v2445.CFrame = l_On_163.HumanoidRootPart.CFrame * v0.CFrame.Angles(0, v0.math.pi, 0);
--				v2445.Parent = l_VFX_0;
--				v2446.Part1 = v2445;
--				local l_v2445_0 = v2445 --[[ copy: 10 -> 317 ]];
--				v0.task.delay(3, function()
--					if l_v2445_0 ~= nil and l_v2445_0.Parent ~= nil then
--						l_v2445_0:Destroy();
--					end;
--				end);
--				v2419(v2438.Slash3, 0.75, "Out", 0);
--				local l_l_On_163_0 = l_On_163 --[[ copy: 2 -> 318 ]];
--				local l_v2428_0 = v2428 --[[ copy: 5 -> 319 ]];
--				local l_v2437_0 = v2437 --[[ copy: 7 -> 320 ]];
--				local l_v2433_0 = v2433 --[[ copy: 6 -> 321 ]];
--				local l_v2438_0 = v2438 --[[ copy: 8 -> 322 ]];
--				local l_v2419_0 = v2419 --[[ copy: 4 -> 323 ]];
--				v0.task.delay(0.5, function()
--					if l_l_On_163_0 ~= nil and l_l_On_163_0.Parent ~= nil and l_v2445_0 ~= nil and l_v2445_0.Parent ~= nil then
--						v104.PlaySoundAtCFrame(l_v2445_0.CFrame, "GlimpseOfPowerFinisherCone");
--						l_v2428_0(l_v2445_0, 0.5);
--						l_v2437_0(l_v2445_0);
--						l_v2433_0(l_v2445_0);
--						v0.task.delay(0.65, function()
--							if l_v2438_0 ~= nil and l_v2438_0.Parent ~= nil then
--								l_v2419_0(l_v2438_0.Slash3, 0.5, "In", 1);
--							end;
--						end);
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerFinisherSheathe" then
--			local l_On_164 = v724.On;
--			if not (l_On_164 ~= nil) or l_On_164.Parent == nil then
--				return;
--			else
--				local v2455 = v0.tostring(v724.Tag);
--				local _ = function(v2456, v2457, v2458, v2459)
--					for _, v2461 in v0.pairs(v2456:GetDescendants()) do
--						if v2461:IsA("ParticleEmitter") then
--							l_TweenService_0:Create(v2461, v0.TweenInfo.new(v2457, v0.Enum.EasingStyle.Quad, v0.Enum.EasingDirection[v2458]), {
--								TimeScale = v2459
--							}):Play();
--						end;
--					end;
--				end;
--				local function v2471(v2463, v2464)
--					for _, v2466 in v0.pairs(v2463:GetDescendants()) do
--						if v2466:IsA("Beam") then
--							v2466.Enabled = true;
--							local l_Brightness_2 = v2466.Brightness;
--							local l_LightEmission_1 = v2466.LightEmission;
--							v2466.Brightness = 0;
--							v2466.LightEmission = 1;
--							local v2469 = {
--								LightEmission = l_LightEmission_1, 
--								Brightness = l_Brightness_2
--							};
--							local v2470 = v0.TweenInfo.new(v2464);
--							game:GetService("TweenService"):Create(v2466, v2470, v2469):Play();
--						end;
--						if v2466:IsA("Trail") then
--							v2466.Enabled = true;
--						end;
--					end;
--				end;
--				local _ = function(v2472)
--					for _, v2474 in v0.pairs(v2472:GetDescendants()) do
--						if v2474:IsA("Attachment") and v2474.Name == "Attachment" and v2474.Parent.Name == "A1" then
--							local l_Position_15 = v2474.Position;
--							v2474.Position = v2474.Position + v0.Vector3.new(0, 0, -v2474.Position.Z);
--							l_TweenService_0:Create(v2474, v0.TweenInfo.new(1.25), {
--								Position = l_Position_15
--							}):Play();
--						end;
--					end;
--				end;
--				local function v2480(v2477)
--					for _, v2479 in v0.pairs(v2477:GetDescendants()) do
--						if v2479:IsA("Beam") then
--							l_TweenService_0:Create(v2479, v0.TweenInfo.new(1, v0.Enum.EasingStyle.Quad, v0.Enum.EasingDirection.Out), {
--								TextureSpeed = 2
--							}):Play();
--						end;
--					end;
--				end;
--				local v2481 = l_Assets_0.Particles.Jun.GlimpseOfPower.Finisher.Sheathe:Clone();
--				v2481.CFrame = l_On_164.HumanoidRootPart.CFrame;
--				v104.PlaySoundAtCFrame(v2481.CFrame, "GlimpseOfPowerFinisherExplode");
--				local v2482 = VFXService.FindGroundPosition(v2481.Position);
--				if v2482 then
--					local v2483 = v0.ColorSequence.new(v2482.Instance.Color);
--					for _, v2485 in v0.pairs(v2481:GetDescendants()) do
--						if v2485:IsA("ParticleEmitter") and v2485.Name == "Smoke" then
--							v2485.Color = v2483;
--						end;
--					end;
--				end;
--				if v88.Blood == false then
--					for _, v2487 in v0.pairs(v2481:GetDescendants()) do
--						if v2487:IsA("ParticleEmitter") and v2487.Name == "Blood" then
--							v2487:Destroy();
--						end;
--					end;
--				end;
--				v2481.Parent = l_VFX_0;
--				if (v2481.Position - l_HumanoidRootPart_0.Position).Magnitude <= 37 then
--					VFXService.ShakeCamera(0, 1.14, 38, 0.42, 0.42, 0.42);
--				end;
--				VFXService.EmitParticlesInInstance(v2481);
--				VFXService.DestroyParticleContainer(v2481, 7);
--				local v2488 = nil;
--				for _, v2490 in v0.pairs(l_VFX_0:GetChildren()) do
--					if v2490.Name == "GlimpseOfPowerFinisherCone" .. v2455 then
--						v2488 = v2490;
--						break;
--					end;
--				end;
--				if v2488 ~= nil and v2488.Parent ~= nil then
--					for _, v2492 in v0.pairs(v2488:GetDescendants()) do
--						if v2492:IsA("Beam") then
--							VFXService.TweenBeamTransparency(v2492, 0.3);
--						end;
--					end;
--				end;
--				local v2493 = l_Assets_0.Particles.Jun.GlimpseOfPower.Finisher.Wind:Clone();
--				v2493.Anchored = true;
--				v2493.CFrame = l_On_164.HumanoidRootPart.CFrame * v0.CFrame.new(0, 0, 15);
--				v2493.Parent = l_VFX_0;
--				v2471(v2493, 0.1);
--				if v2493 ~= nil and v2493.Parent ~= nil then
--					for _, v2495 in v0.pairs(v2493:GetDescendants()) do
--						if v2495:IsA("Beam") then
--							VFXService.TweenBeamTransparency(v2495, 2.64);
--						end;
--					end;
--					local l_v2493_0 = v2493 --[[ copy: 11 -> 316 ]];
--					v0.task.delay(1.5, function()
--						if l_v2493_0 ~= nil and l_v2493_0.Parent ~= nil then
--							for _, v2498 in v0.pairs(l_v2493_0:GetDescendants()) do
--								if v2498:IsA("ParticleEmitter") then
--									v2498.Enabled = false;
--								end;
--							end;
--						end;
--					end);
--				end;
--				local l_v2493_1 = v2493 --[[ copy: 11 -> 315 ]];
--				v0.task.delay(3, function()
--					if l_v2493_1 ~= nil and l_v2493_1.Parent ~= nil then
--						l_v2493_1:Destroy();
--					end;
--				end);
--				v2480(v2493);
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerFinisherVictimSound" then
--			local l_On_165 = v724.On;
--			if not (l_On_165 ~= nil) or l_On_165.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_165.HumanoidRootPart, "GlimpseOfPowerFinisherVictim");
--			end;
--		end;
--		if l_Request_1 == "JunRestWarrior" then
--			local l_On_166 = v724.On;
--			if not (l_On_166 ~= nil) or l_On_166.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_166.HumanoidRootPart, "JunRestWarrior");
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerFinisherUserSound" then
--			local l_On_167 = v724.On;
--			if not (l_On_167 ~= nil) or l_On_167.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_167.HumanoidRootPart, "GlimpseOfPowerFinisherUser");
--				local l_l_On_167_0 = l_On_167 --[[ copy: 2 -> 314 ]];
--				v0.task.delay(1, function()
--					if l_l_On_167_0 ~= nil and l_l_On_167_0.Parent ~= nil then
--						v104.PlaySoundInInstance(l_l_On_167_0.HumanoidRootPart, "JunRestWarrior");
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerFinisherForward3" then
--			for _, v2505 in v0.pairs(l_HumanoidRootPart_0:GetChildren()) do
--				if v2505:IsA("BodyVelocity") and v2505.Name == "GlimpseOfPowerFinisherForward" then
--					v2505:Destroy();
--				end;
--			end;
--			local v2506 = v0.Instance.new("BodyVelocity");
--			v2506.Name = "GlimpseOfPowerFinisherForward";
--			v2506.MaxForce = v0.Vector3.new(86000, 0, 86000);
--			local v2507 = v0.Instance.new("NumberValue");
--			v2507.Value = 80;
--			v2507.Parent = v2506;
--			local l_v2507_0 = v2507 --[[ copy: 3 -> 312 ]];
--			local l_v2506_0 = v2506 --[[ copy: 2 -> 313 ]];
--			v2507:GetPropertyChangedSignal("Value"):Connect(function()
--				if l_v2507_0.Value <= 5 and l_v2506_0 ~= nil and l_v2506_0.Parent ~= nil then
--					l_v2506_0:Destroy();
--				end;
--			end);
--			local v2510 = l_TweenService_0:Create(v2507, v0.TweenInfo.new(1.15, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--				Value = 0
--			});
--			v2510.Completed:Connect(function()
--				if l_v2506_0 ~= nil and l_v2506_0.Parent ~= nil then
--					l_v2506_0:Destroy();
--				end;
--			end);
--			v2506.Parent = l_HumanoidRootPart_0;
--			v0.task.spawn(function()
--				while l_v2506_0 ~= nil and l_v2506_0.Parent ~= nil do
--					l_v2506_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * l_v2507_0.Value;
--					v0.task.wait();
--				end;
--			end);
--			v2510:Play();
--		end;
--		if l_Request_1 == "GlimpseOfPowerFinisherForward2" then
--			for _, v2512 in v0.pairs(l_HumanoidRootPart_0:GetChildren()) do
--				if v2512:IsA("BodyVelocity") and v2512.Name == "GlimpseOfPowerFinisherForward" then
--					v2512:Destroy();
--				end;
--			end;
--			local v2513 = v0.Instance.new("BodyVelocity");
--			v2513.Name = "GlimpseOfPowerFinisherForward";
--			v2513.MaxForce = v0.Vector3.new(86000, 0, 86000);
--			local v2514 = v0.Instance.new("NumberValue");
--			v2514.Value = 134;
--			v2514.Parent = v2513;
--			local l_v2514_0 = v2514 --[[ copy: 3 -> 310 ]];
--			local l_v2513_0 = v2513 --[[ copy: 2 -> 311 ]];
--			v2514:GetPropertyChangedSignal("Value"):Connect(function()
--				if l_v2514_0.Value <= 5 and l_v2513_0 ~= nil and l_v2513_0.Parent ~= nil then
--					l_v2513_0:Destroy();
--				end;
--			end);
--			local v2517 = l_TweenService_0:Create(v2514, v0.TweenInfo.new(1.15, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--				Value = 0
--			});
--			v2517.Completed:Connect(function()
--				if l_v2513_0 ~= nil and l_v2513_0.Parent ~= nil then
--					l_v2513_0:Destroy();
--				end;
--			end);
--			v2513.Parent = l_HumanoidRootPart_0;
--			v0.task.spawn(function()
--				while l_v2513_0 ~= nil and l_v2513_0.Parent ~= nil do
--					l_v2513_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * l_v2514_0.Value;
--					v0.task.wait();
--				end;
--			end);
--			v2517:Play();
--		end;
--		if l_Request_1 == "GlimpseOfPowerVariantForward2" then
--			for _, v2519 in v0.pairs(l_HumanoidRootPart_0:GetChildren()) do
--				if v2519:IsA("BodyVelocity") and v2519.Name == "GlimpseOfPowerVariantForward" then
--					v2519:Destroy();
--				end;
--			end;
--			local v2520 = v0.Instance.new("BodyVelocity");
--			v2520.Name = "GlimpseOfPowerVariantForward";
--			v2520.MaxForce = v0.Vector3.new(86000, 0, 86000);
--			local v2521 = v0.Instance.new("NumberValue");
--			v2521.Value = 47;
--			v2521.Parent = v2520;
--			local l_v2521_0 = v2521 --[[ copy: 3 -> 308 ]];
--			local l_v2520_0 = v2520 --[[ copy: 2 -> 309 ]];
--			v2521:GetPropertyChangedSignal("Value"):Connect(function()
--				if l_v2521_0.Value <= 5 and l_v2520_0 ~= nil and l_v2520_0.Parent ~= nil then
--					l_v2520_0:Destroy();
--				end;
--			end);
--			local v2524 = l_TweenService_0:Create(v2521, v0.TweenInfo.new(1.15, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--				Value = 0
--			});
--			v2524.Completed:Connect(function()
--				if l_v2520_0 ~= nil and l_v2520_0.Parent ~= nil then
--					l_v2520_0:Destroy();
--				end;
--			end);
--			v2520.Parent = l_HumanoidRootPart_0;
--			v0.task.spawn(function()
--				while l_v2520_0 ~= nil and l_v2520_0.Parent ~= nil do
--					l_v2520_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * l_v2521_0.Value;
--					v0.task.wait();
--				end;
--			end);
--			v2524:Play();
--		end;
--		if l_Request_1 == "GlimpseOfPowerVariantForward" then
--			for _, v2526 in v0.pairs(l_HumanoidRootPart_0:GetChildren()) do
--				if v2526:IsA("BodyVelocity") and v2526.Name == "GlimpseOfPowerVariantForward" then
--					v2526:Destroy();
--				end;
--			end;
--			local v2527 = v0.Instance.new("BodyVelocity");
--			v2527.Name = "GlimpseOfPowerVariantForward";
--			v2527.MaxForce = v0.Vector3.new(86000, 0, 86000);
--			local v2528 = v0.Instance.new("NumberValue");
--			v2528.Value = 24;
--			v2528.Parent = v2527;
--			local l_v2528_0 = v2528 --[[ copy: 3 -> 306 ]];
--			local l_v2527_0 = v2527 --[[ copy: 2 -> 307 ]];
--			v2528:GetPropertyChangedSignal("Value"):Connect(function()
--				if l_v2528_0.Value <= 4 and l_v2527_0 ~= nil and l_v2527_0.Parent ~= nil then
--					l_v2527_0:Destroy();
--				end;
--			end);
--			local v2531 = l_TweenService_0:Create(v2528, v0.TweenInfo.new(1.15, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--				Value = 0
--			});
--			v2531.Completed:Connect(function()
--				if l_v2527_0 ~= nil and l_v2527_0.Parent ~= nil then
--					l_v2527_0:Destroy();
--				end;
--			end);
--			v2527.Parent = l_HumanoidRootPart_0;
--			v0.task.spawn(function()
--				while l_v2527_0 ~= nil and l_v2527_0.Parent ~= nil do
--					l_v2527_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * l_v2528_0.Value;
--					v0.task.wait();
--				end;
--			end);
--			v2531:Play();
--		end;
--		if l_Request_1 == "GlimpseOfPowerFinisherForward" then
--			for _, v2533 in v0.pairs(l_HumanoidRootPart_0:GetChildren()) do
--				if v2533:IsA("BodyVelocity") and v2533.Name == "GlimpseOfPowerFinisherForward" then
--					v2533:Destroy();
--				end;
--			end;
--			local v2534 = v0.Instance.new("BodyVelocity");
--			v2534.Name = "GlimpseOfPowerFinisherForward";
--			v2534.MaxForce = v0.Vector3.new(86000, 0, 86000);
--			local v2535 = v0.Instance.new("NumberValue");
--			v2535.Value = 70;
--			v2535.Parent = v2534;
--			local l_v2535_0 = v2535 --[[ copy: 3 -> 304 ]];
--			local l_v2534_0 = v2534 --[[ copy: 2 -> 305 ]];
--			v2535:GetPropertyChangedSignal("Value"):Connect(function()
--				if l_v2535_0.Value <= 5 and l_v2534_0 ~= nil and l_v2534_0.Parent ~= nil then
--					l_v2534_0:Destroy();
--				end;
--			end);
--			local v2538 = l_TweenService_0:Create(v2535, v0.TweenInfo.new(1.15, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--				Value = 0
--			});
--			v2538.Completed:Connect(function()
--				if l_v2534_0 ~= nil and l_v2534_0.Parent ~= nil then
--					l_v2534_0:Destroy();
--				end;
--			end);
--			v2534.Parent = l_HumanoidRootPart_0;
--			v0.task.spawn(function()
--				while l_v2534_0 ~= nil and l_v2534_0.Parent ~= nil do
--					l_v2534_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * l_v2535_0.Value;
--					v0.task.wait();
--				end;
--			end);
--			v2538:Play();
--		end;
--		if l_Request_1 == "GlimpseOfPowerGrabDash" then
--			local v2539 = v0.Instance.new("BodyVelocity");
--			v2539.MaxForce = v0.Vector3.new(90000, 0, 90000);
--			local v2540 = v0.Instance.new("NumberValue");
--			v2540.Value = 140;
--			v2540.Parent = v2539;
--			local l_v2540_0 = v2540 --[[ copy: 3 -> 302 ]];
--			local l_v2539_0 = v2539 --[[ copy: 2 -> 303 ]];
--			v2540:GetPropertyChangedSignal("Value"):Connect(function()
--				if l_v2540_0.Value <= 5 and l_v2539_0 ~= nil and l_v2539_0.Parent ~= nil then
--					l_v2539_0:Destroy();
--				end;
--			end);
--			local v2543 = l_TweenService_0:Create(v2540, v0.TweenInfo.new(1.15, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--				Value = 0
--			});
--			v2543.Completed:Connect(function()
--				if l_v2539_0 ~= nil and l_v2539_0.Parent ~= nil then
--					l_v2539_0:Destroy();
--				end;
--			end);
--			v2539.Parent = l_HumanoidRootPart_0;
--			v0.task.spawn(function()
--				while l_v2539_0 ~= nil and l_v2539_0.Parent ~= nil do
--					l_v2539_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * l_v2540_0.Value;
--					v0.task.wait();
--				end;
--			end);
--			v2543:Play();
--		end;
--		if l_Request_1 == "GlimpseOfPowerEye" then
--			local l_On_168 = v724.On;
--			if not (l_On_168 ~= nil) or l_On_168.Parent == nil then
--				return;
--			else
--				local v2545 = l_Assets_0.Particles.Jun.GlimpseOfPower.EyeFlash.Star:Clone();
--				local v2546 = v0.Instance.new("Attachment");
--				v2546.Position = v0.Vector3.new(0.1, 0.3, -0.6);
--				v2546.Parent = l_On_168.Head;
--				v2545.Parent = v2546;
--				v2545:Emit(v2545:GetAttribute("EmitCount") or 2);
--				local l_v2546_0 = v2546 --[[ copy: 4 -> 301 ]];
--				v0.task.delay(1, function()
--					if l_v2546_0 ~= nil and l_v2546_0.Parent ~= nil then
--						l_v2546_0:Destroy();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerKick" then
--			local l_On_169 = v724.On;
--			if not (l_On_169 ~= nil) or l_On_169.Parent == nil then
--				return;
--			else
--				local v2549 = l_Assets_0.Particles.Jun.GlimpseOfPower.Kick:Clone();
--				v2549.CFrame = l_On_169.HumanoidRootPart.CFrame * v0.CFrame.Angles(-0.401264265, v0.math.pi, 0);
--				v2549.Parent = l_VFX_0;
--				if (v2549.Position - l_HumanoidRootPart_0.Position).Magnitude <= 13 then
--					VFXService.ShakeCamera(0, 0.4, 31, 0.6, 0.6, 0.6);
--				end;
--				local v2550 = VFXService.FindGroundPosition(v2549.Position);
--				if v2550 then
--					local v2551 = v0.ColorSequence.new(v2550.Instance.Color);
--					for _, v2553 in v0.pairs(v2549:GetDescendants()) do
--						if v2553:IsA("ParticleEmitter") and v2553.Name == "Smoke" then
--							v2553.Color = v2551;
--						end;
--					end;
--				end;
--				VFXService.EmitParticlesInInstance(v2549);
--				VFXService.DestroyParticleContainer(v2549, 3);
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerFinisherGrabInitiate" then
--			local l_On_170 = v724.On;
--			if not (l_On_170 ~= nil) or l_On_170.Parent == nil then
--				return;
--			else
--				local v2555 = l_Assets_0.Particles.Jun.GlimpseOfPower.GrabInitiate:Clone();
--				v2555.CFrame = l_On_170.Head.CFrame;
--				v2555.Parent = l_VFX_0;
--				if (l_On_170.HumanoidRootPart.Position - l_HumanoidRootPart_0.Position).Magnitude <= 20 then
--					VFXService.ShakeCamera(0, 0.4, 13.5, 0.25, 0.5, 0.25);
--				end;
--				VFXService.EmitParticlesInInstance(v2555);
--				VFXService.DestroyParticleContainer(v2555, 3);
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerGrabInitiate" then
--			local l_On_171 = v724.On;
--			if not (l_On_171 ~= nil) or l_On_171.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_171.HumanoidRootPart, "GlimpseOfPowerVictim");
--				local v2557 = l_Assets_0.Particles.Jun.GlimpseOfPower.GrabInitiate:Clone();
--				v2557.CFrame = l_On_171.Head.CFrame;
--				v2557.Parent = l_VFX_0;
--				if (l_On_171.HumanoidRootPart.Position - l_HumanoidRootPart_0.Position).Magnitude <= 20 then
--					VFXService.ShakeCamera(0, 0.4, 15, 0.4, 0.4, 0.4);
--				end;
--				VFXService.EmitParticlesInInstance(v2557);
--				VFXService.DestroyParticleContainer(v2557, 3);
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerGutPunch" then
--			local l_On_172 = v724.On;
--			if not (l_On_172 ~= nil) or l_On_172.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_172.HumanoidRootPart, "GlimpseOfPowerGutPunch");
--				local v2559 = l_Assets_0.Particles.Jun.GlimpseOfPower.GutPunch:Clone();
--				v2559.CFrame = l_On_172.HumanoidRootPart.CFrame;
--				v2559.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v2559);
--				VFXService.DestroyParticleContainer(v2559, 3);
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerRun" then
--			local l_On_173 = v724.On;
--			if not (l_On_173 ~= nil) or l_On_173.Parent == nil then
--				return;
--			else
--				local v2561 = l_Assets_0.Particles.Jun.GlimpseOfPower.Run:Clone();
--				local v2562 = v0.Instance.new("WeldConstraint");
--				v2562.Parent = v2561;
--				v2562.Part0 = l_On_173.HumanoidRootPart;
--				v2561.CFrame = l_On_173.HumanoidRootPart.CFrame;
--				v2562.Part1 = v2561;
--				v2561.Parent = l_VFX_0;
--				local l_v2561_0 = v2561 --[[ copy: 3 -> 299 ]];
--				local l_v2562_0 = v2562 --[[ copy: 4 -> 300 ]];
--				VFXService.CreateBind(l_On_173, "GlimpseOfPowerRunEffects", function()
--					if l_v2561_0 ~= nil and l_v2561_0.Parent ~= nil then
--						for _, v2566 in v0.pairs(l_v2561_0:GetDescendants()) do
--							if v2566:IsA("ParticleEmitter") then
--								v2566.Enabled = false;
--							end;
--						end;
--						if l_v2562_0 ~= nil and l_v2562_0.Parent ~= nil then
--							l_v2562_0:Destroy();
--						end;
--						l_v2561_0.Anchored = true;
--						VFXService.DestroyParticleContainer(l_v2561_0, 2.5);
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndGlimpseOfPowerRun" then
--			local l_On_174 = v724.On;
--			if not (l_On_174 ~= nil) or l_On_174.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_174, "GlimpseOfPowerRunEffects");
--			end;
--		end;
--		if l_Request_1 == "JunVoicelinePathetic" then
--			local l_On_175 = v724.On;
--			if not (l_On_175 ~= nil) or l_On_175.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_175.HumanoidRootPart, "JunVoicelinePathetic");
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerStartupSound" then
--			local l_On_176 = v724.On;
--			if not (l_On_176 ~= nil) or l_On_176.Parent == nil then
--				return;
--			else
--				local v2570 = v104.PlaySoundInInstance(l_On_176.HumanoidRootPart, "GlimpseOfPowerStartup");
--				local v2571 = l_TweenService_0:Create(v2570, v0.TweenInfo.new(0.2, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--					Volume = 0
--				});
--				local l_v2570_0 = v2570 --[[ copy: 3 -> 296 ]];
--				v2571.Completed:Connect(function()
--					if l_v2570_0 ~= nil and l_v2570_0.Parent ~= nil then
--						l_v2570_0:Destroy();
--					end;
--				end);
--				local l_v2571_0 = v2571 --[[ copy: 4 -> 297 ]];
--				local v2574 = VFXService.CreateBind(l_On_176, "GlimpseOfPowerStartupSound", function()
--					if l_v2570_0 ~= nil and l_v2570_0.Parent ~= nil then
--						l_v2570_0:SetAttribute("DefaultVolume", nil);
--						l_v2571_0:Play();
--					end;
--				end);
--				local l_v2574_0 = v2574 --[[ copy: 5 -> 298 ]];
--				v2570.Ended:Connect(function()
--					if l_v2574_0 ~= nil and l_v2574_0.Parent ~= nil then
--						l_v2574_0:Destroy();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndGlimpseOfPowerStartupSound" then
--			local l_On_177 = v724.On;
--			if not (l_On_177 ~= nil) or l_On_177.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_177, "GlimpseOfPowerStartupSound");
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerRunSound" then
--			local l_On_178 = v724.On;
--			if not (l_On_178 ~= nil) or l_On_178.Parent == nil then
--				return;
--			else
--				local v2578 = v104.PlaySoundInInstance(l_On_178.HumanoidRootPart, "GlimpseOfPowerRun");
--				local v2579 = l_TweenService_0:Create(v2578, v0.TweenInfo.new(0.2, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--					Volume = 0
--				});
--				local l_v2578_0 = v2578 --[[ copy: 3 -> 293 ]];
--				v2579.Completed:Connect(function()
--					if l_v2578_0 ~= nil and l_v2578_0.Parent ~= nil then
--						l_v2578_0:Destroy();
--					end;
--				end);
--				local l_v2579_0 = v2579 --[[ copy: 4 -> 294 ]];
--				local v2582 = VFXService.CreateBind(l_On_178, "GlimpseOfPowerRunSound", function()
--					if l_v2578_0 ~= nil and l_v2578_0.Parent ~= nil then
--						l_v2578_0:SetAttribute("DefaultVolume", nil);
--						l_v2579_0:Play();
--					end;
--				end);
--				local l_v2582_0 = v2582 --[[ copy: 5 -> 295 ]];
--				v2578.Ended:Connect(function()
--					if l_v2582_0 ~= nil and l_v2582_0.Parent ~= nil then
--						l_v2582_0:Destroy();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndGlimpseOfPowerRunSound" then
--			local l_On_179 = v724.On;
--			if not (l_On_179 ~= nil) or l_On_179.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_179, "GlimpseOfPowerRunSound");
--			end;
--		end;
--		if l_Request_1 == "GlimpseOfPowerMotion" then
--			local v2585 = v0.Instance.new("BodyVelocity");
--			v2585.MaxForce = v0.Vector3.new(450000, 0, 450000);
--			local v2586 = v0.Instance.new("NumberValue");
--			v2586.Value = 10;
--			v2586.Parent = v2585;
--			local v2587 = l_TweenService_0:Create(v2586, v0.TweenInfo.new(0.03, v0.Enum.EasingStyle.Linear, v0.Enum.EasingDirection.Out), {
--				Value = 95
--			});
--			local v2588 = l_TweenService_0:Create(v2586, v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Linear, v0.Enum.EasingDirection.Out), {
--				Value = 6
--			});
--			local l_v2588_0 = v2588 --[[ copy: 5 -> 289 ]];
--			v2587.Completed:Connect(function()
--				v0.task.delay(0.1, function()
--					if l_v2588_0 ~= nil then
--						l_v2588_0:Play();
--					end;
--				end);
--			end);
--			local l_v2585_0 = v2585 --[[ copy: 2 -> 290 ]];
--			v2588.Completed:Connect(function()
--				if l_v2585_0 ~= nil and l_v2585_0.Parent ~= nil then
--					l_v2585_0:Destroy();
--				end;
--			end);
--			v2585.Parent = l_HumanoidRootPart_0;
--			v2587:Play();
--			local v2591 = VFXService.CreateBind(v26, "GlimpseOfPowerMotion", function()
--				if l_v2585_0 ~= nil and l_v2585_0.Parent ~= nil then
--					l_v2585_0:Destroy();
--				end;
--			end);
--			local l_v2586_0 = v2586 --[[ copy: 3 -> 291 ]];
--			local l_v2591_0 = v2591 --[[ copy: 6 -> 292 ]];
--			v0.task.spawn(function()
--				while l_v2585_0 ~= nil and l_v2585_0.Parent ~= nil do
--					l_v2585_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * l_v2586_0.Value;
--					v0.task.wait();
--				end;
--				if l_v2591_0 ~= nil and l_v2591_0.Parent ~= nil then
--					l_v2591_0:Destroy();
--					return;
--				else
--					return;
--				end;
--			end);
--		end;
--		if l_Request_1 == "EndGlimpseOfPowerMotion" then
--			VFXService.DestroyBind(v26, "GlimpseOfPowerMotion");
--		end;
--		if l_Request_1 == "AwakeningReachedEffect" then
--			local l_CharacterName_0 = v724.CharacterName;
--			local v2605 = v0.Instance.new("Highlight");
--			v2605.DepthMode = v0.Enum.HighlightDepthMode.Occluded;
--			v2605.FillColor = v0.Color3.fromRGB(255, 255, 255);
--			local v2606 = l_TweenService_0:Create(v2605, v0.TweenInfo.new(0.9, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--				FillTransparency = 1, 
--				OutlineTransparency = 1
--			});
--			local l_v2605_0 = v2605 --[[ copy: 3 -> 287 ]];
--			v2606.Completed:Connect(function()
--				if l_v2605_0 ~= nil and l_v2605_0.Parent ~= nil then
--					l_v2605_0:Destroy();
--				end;
--			end);
--			v2605.Parent = v26;
--			v2606:Play();
--			if l_CharacterName_0 == "Martial Legend" then
--				v104.PlaySound("Dragon'sFuryAwakeningReached");
--			end;
--		end;
--		if l_Request_1 == "SpawnGodMode" then
--			local l_On_180 = v724.On;
--			if not (l_On_180 ~= nil) or l_On_180.Parent == nil then
--				return;
--			else
--				local v2609 = v0.Instance.new("Highlight");
--				v2609.DepthMode = v0.Enum.HighlightDepthMode.Occluded;
--				v2609.FillColor = v0.Color3.fromRGB(255, 255, 255);
--				local v2610 = l_TweenService_0:Create(v2609, v0.TweenInfo.new(5, v0.Enum.EasingStyle.Linear, v0.Enum.EasingDirection.Out), {
--					FillTransparency = 1, 
--					OutlineTransparency = 1
--				});
--				local l_v2609_0 = v2609 --[[ copy: 3 -> 286 ]];
--				v2610.Completed:Connect(function()
--					if l_v2609_0 ~= nil and l_v2609_0.Parent ~= nil then
--						l_v2609_0:Destroy();
--					end;
--				end);
--				v2609.Parent = l_On_180;
--				v2610:Play();
--			end;
--		end;
--		if l_Request_1 == "Voxels" then
--			local l_Style_0 = v724.Style;
--			local l_Info_0 = v724.Info;
--			local v2614 = v0.Random.new();
--			if l_Style_0 == "Fling" then
--				local v2615 = nil;
--				local v2616 = nil;
--				local v2617 = nil;
--				local l_Sound_2 = v724.Sound;
--				for _, v2620 in v0.pairs(l_Info_0) do
--					local v2621 = v0.Instance.new("Part");
--					v2621.Name = "Voxel";
--					v2621.CollisionGroup = "Flying Rocks";
--					v2621.Massless = true;
--					v2621.CanQuery = false;
--					v2621.EnableFluidForces = false;
--					v2621.CanTouch = false;
--					v2621.CFrame = v2620[1];
--					v2621.Size = v2620[2];
--					v2621.Color = v2620[3];
--					v2621.Material = v2620[4];
--					if l_Sound_2 ~= false then
--						if typeof(v2615) ~= "CFrame" and v2621.Material == v0.Enum.Material.Glass then
--							v2615 = v2620[1];
--						end;
--						if typeof(v2616) ~= "CFrame" and (not (v2621.Material ~= v0.Enum.Material.Slate) or v2621.Material == v0.Enum.Material.DiamondPlate) then
--							v2616 = v2620[1];
--						end;
--						if typeof(v2617) ~= "CFrame" and (not (v2621.Material ~= v0.Enum.Material.Wood) or v2621.Material == v0.Enum.Material.WoodPlanks) then
--							v2617 = v2620[1];
--						end;
--					end;
--					v2621.Transparency = v2620[5] or 1;
--					v2621.AssemblyLinearVelocity = v2620[6];
--					v2621.AssemblyAngularVelocity = v2620[7] or v0.Vector3.new(v0.math.random(-2, 2), v0.math.random(-2, 2), v0.math.random(-2, 2));
--					v2621.Parent = l_FlyingRocksStorage_0;
--					v0.task.delay(v2620.Lifetime or v2614:NextNumber(4.5, 7.5), function()
--						if v2621 ~= nil and v2621.Parent ~= nil then
--							local v2622 = l_TweenService_0:Create(v2621, v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--								Size = v2621.Size / 2, 
--								Transparency = 1
--							});
--							v2622.Completed:Connect(function()
--								v2621:Destroy();
--							end);
--							v2622:Play();
--						end;
--					end);
--				end;
--				if l_Sound_2 ~= false then
--					if typeof(v2616) == "CFrame" then
--						local v2623 = v0.tostring(v0.math.random(1, 3));
--						v104.PlaySoundAtCFrame(v2616, "BuildingDestructionRockImpact" .. v2623);
--					end;
--					if typeof(v2615) == "CFrame" then
--						v104.PlaySoundAtCFrame(v2615, "BuildingDestructionGlassImpact");
--					end;
--					if typeof(v2617) == "CFrame" then
--						local v2624 = v0.tostring(v0.math.random(1, 6));
--						v104.PlaySoundAtCFrame(v2617, "BuildingDestructionWoodImpact" .. v2624);
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "UniformCircularMotion" then
--			local l_On_181 = v724.On;
--			if not (l_On_181 ~= nil) or l_On_181.Parent == nil then
--				return;
--			else
--				local v2626 = v724.RPS or 1;
--				local l_Radius_0 = v724.Radius;
--				local l_Start_0 = v724.Start;
--				local l_Direction_0 = v724.Direction;
--				local v2630 = v724.SmoothTime or 1;
--				local v2631 = v724.EasingStyle or v0.Enum.EasingStyle.Exponential;
--				local v2632 = v724.EasingDirection or v0.Enum.EasingDirection.Out;
--				local v2633 = v0.Instance.new("NumberValue");
--				v2633.Name = "AngularDisplacement";
--				local v2634 = nil;
--				local v2635 = v0.Instance.new("CFrameValue");
--				v2635.Name = "UniformCircularMotion";
--				v2635.Parent = l_On_181.HumanoidRootPart;
--				v2633.Parent = v2635;
--				do
--					local l_v2634_0 = v2634;
--					if v2630 > 0 then
--						local l_CFrame_38 = l_On_181.HumanoidRootPart.CFrame;
--						v2635.Value = l_CFrame_38;
--						local v2638 = true;
--						local l_l_On_181_0 = l_On_181 --[[ copy: 2 -> 277 ]];
--						local l_v2635_0 = v2635 --[[ copy: 12 -> 278 ]];
--						local l_v2633_0 = v2633 --[[ copy: 10 -> 279 ]];
--						local l_l_Start_0_0 = l_Start_0 --[[ copy: 5 -> 280 ]];
--						local l_l_Radius_0_0 = l_Radius_0 --[[ copy: 4 -> 281 ]];
--						local l_v2630_0 = v2630 --[[ copy: 7 -> 282 ]];
--						local l_v2631_0 = v2631 --[[ copy: 8 -> 283 ]];
--						local l_v2632_0 = v2632 --[[ copy: 9 -> 284 ]];
--						local l_l_CFrame_38_0 = l_CFrame_38 --[[ copy: 13 -> 285 ]];
--						do
--							local l_v2638_0 = v2638;
--							l_v2634_0 = v0.task.spawn(function()
--								local v2649 = v0.os.clock();
--								while l_l_On_181_0 ~= nil and l_l_On_181_0.Parent ~= nil and l_v2635_0 ~= nil and l_v2635_0.Parent ~= nil and l_v2633_0 ~= nil and l_v2633_0.Parent ~= nil do
--									local v2650 = l_l_Start_0_0 * v0.CFrame.Angles(0, l_v2633_0.Value, 0);
--									local v2651 = v2650 + v2650.LookVector * l_l_Radius_0_0;
--									local l_l_TweenService_0_Value_1 = l_TweenService_0:GetValue((v0.os.clock() - v2649) / l_v2630_0, l_v2631_0, l_v2632_0);
--									l_v2635_0.Value = l_l_CFrame_38_0:Lerp(v2651, l_l_TweenService_0_Value_1);
--									l_l_On_181_0:PivotTo(l_v2635_0.Value);
--									if l_l_TweenService_0_Value_1 >= 1 then
--										l_v2638_0 = true;
--										break;
--									else
--										v0.task.wait();
--									end;
--								end;
--								if l_v2638_0 == true then
--									l_v2634_0 = v0.task.spawn(function()
--										while l_l_On_181_0 ~= nil and l_l_On_181_0.Parent ~= nil and l_v2635_0 ~= nil and l_v2635_0.Parent ~= nil and l_v2633_0 ~= nil and l_v2633_0.Parent ~= nil do
--											local v2653 = l_l_Start_0_0 * v0.CFrame.Angles(0, l_v2633_0.Value, 0);
--											l_v2635_0.Value = v2653 + v2653.LookVector * l_l_Radius_0_0;
--											l_l_On_181_0:PivotTo(l_v2635_0.Value);
--											v0.task.wait();
--										end;
--									end);
--								end;
--							end);
--						end;
--					else
--						v2635.Value = l_Start_0 + l_Start_0.LookVector * l_Radius_0;
--						local l_l_On_181_1 = l_On_181 --[[ copy: 2 -> 268 ]];
--						local l_v2635_1 = v2635 --[[ copy: 12 -> 269 ]];
--						local l_v2633_1 = v2633 --[[ copy: 10 -> 270 ]];
--						local l_l_Start_0_1 = l_Start_0 --[[ copy: 5 -> 271 ]];
--						local l_l_Radius_0_1 = l_Radius_0 --[[ copy: 4 -> 272 ]];
--						l_v2634_0 = v0.task.spawn(function()
--							while l_l_On_181_1 ~= nil and l_l_On_181_1.Parent ~= nil and l_v2635_1 ~= nil and l_v2635_1.Parent ~= nil and l_v2633_1 ~= nil and l_v2633_1.Parent ~= nil do
--								local v2659 = l_l_Start_0_1 * v0.CFrame.Angles(0, l_v2633_1.Value, 0);
--								l_v2635_1.Value = v2659 + v2659.LookVector * l_l_Radius_0_1;
--								l_l_On_181_1:PivotTo(l_v2635_1.Value);
--								v0.task.wait();
--							end;
--						end);
--					end;
--					local l_v2633_2 = v2633 --[[ copy: 10 -> 273 ]];
--					local l_v2626_0 = v2626 --[[ copy: 3 -> 274 ]];
--					local function v2662()
--						if not (l_v2633_2 ~= nil) or l_v2633_2.Parent == nil then
--							return;
--						else
--							local v2663 = l_TweenService_0:Create(l_v2633_2, v0.TweenInfo.new(1 / l_v2626_0, v0.Enum.EasingStyle.Linear), {
--								Value = l_v2633_2.Value + v0.math.pi * 2
--							});
--							v2663.Completed:Connect(v2662);
--							v2663:Play();
--							return;
--						end;
--					end;
--					local function v2664()
--						if not (l_v2633_2 ~= nil) or l_v2633_2.Parent == nil then
--							return;
--						else
--							local v2665 = l_TweenService_0:Create(l_v2633_2, v0.TweenInfo.new(1 / l_v2626_0, v0.Enum.EasingStyle.Linear), {
--								Value = l_v2633_2.Value - v0.math.pi * 2
--							});
--							v2665.Completed:Connect(v2664);
--							v2665:Play();
--							return;
--						end;
--					end;
--					if l_Direction_0 == "Negative" then
--						v2664();
--					else
--						v2662();
--					end;
--					local l_v2635_2 = v2635 --[[ copy: 12 -> 275 ]];
--					local l_v2633_3 = v2633 --[[ copy: 10 -> 276 ]];
--					VFXService.CreateBind(l_On_181, "UniformCircularMotionEffect", function()
--						v0.pcall(function()
--							v0.task.cancel(l_v2634_0);
--						end);
--						if l_v2635_2 ~= nil and l_v2635_2.Parent ~= nil then
--							l_v2635_2:Destroy();
--						end;
--						if l_v2633_3 ~= nil and l_v2633_3.Parent ~= nil then
--							l_v2633_3:Destroy();
--						end;
--					end);
--				end;
--			end;
--		end;
--		if l_Request_1 == "EndUniformCircularMotion" then
--			local l_On_182 = v724.On;
--			if not (l_On_182 ~= nil) or l_On_182.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_182, "UniformCircularMotionEffect");
--			end;
--		end;
--		if l_Request_1 == "DroppingFangHitSound" then
--			local l_On_184 = v724.On;
--			if not (l_On_184 ~= nil) or l_On_184.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_184.HumanoidRootPart, "DroppingFangHit");
--			end;
--		end;
--		if l_Request_1 == "DroppingFangSound" then
--			local l_On_185 = v724.On;
--			if not (l_On_185 ~= nil) or l_On_185.Parent == nil then
--				return;
--			else
--				local v2737 = v104.PlaySoundInInstance(l_On_185.HumanoidRootPart, "DroppingFangUser");
--				local v2738 = l_TweenService_0:Create(v2737, v0.TweenInfo.new(0.2, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--					Volume = 0
--				});
--				local l_v2737_0 = v2737 --[[ copy: 3 -> 254 ]];
--				v2738.Completed:Connect(function()
--					if l_v2737_0 ~= nil and l_v2737_0.Parent ~= nil then
--						l_v2737_0:Destroy();
--					end;
--				end);
--				local l_v2738_0 = v2738 --[[ copy: 4 -> 255 ]];
--				local v2741 = VFXService.CreateBind(l_On_185, "DroppingFangSoundEffect", function()
--					if l_v2737_0 ~= nil and l_v2737_0.Parent ~= nil then
--						l_v2737_0:SetAttribute("DefaultVolume", nil);
--						l_v2738_0:Play();
--					end;
--				end);
--				local l_v2741_0 = v2741 --[[ copy: 5 -> 256 ]];
--				v2737.Ended:Connect(function()
--					if l_v2741_0 ~= nil and l_v2741_0.Parent ~= nil then
--						l_v2741_0:Destroy();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndDroppingFangSound" then
--			local l_On_186 = v724.On;
--			if not (l_On_186 ~= nil) or l_On_186.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_186, "DroppingFangSoundEffect");
--			end;
--		end;
--		if l_Request_1 == "Dragon'sFurySound" then
--			local l_On_187 = v724.On;
--			if not (l_On_187 ~= nil) or l_On_187.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_187.HumanoidRootPart, "Dragon'sFury");
--			end;
--		end;
--		if l_Request_1 == "Dragon'sFuryEyeFlashWhite" then
--			local l_On_188 = v724.On;
--			if not (l_On_188 ~= nil) or l_On_188.Parent == nil then
--				return;
--			else
--				local v2746 = v0.Instance.new("Attachment");
--				v2746.Position = v0.Vector3.new(0.13, 0.27, -0.65);
--				local v2747 = l_Assets_0.Particles.MartialArtist["Dragon'sFury"].FlareWhite:Clone();
--				v2747.Parent = v2746;
--				local v2748 = v0.Instance.new("Attachment");
--				v2748.Position = v0.Vector3.new(-0.1, 0.27, -0.65);
--				local v2749 = l_Assets_0.Particles.MartialArtist["Dragon'sFury"].FlareWhite:Clone();
--				v2749.Parent = v2748;
--				v2746.Parent = l_On_188.Head;
--				v2748.Parent = l_On_188.Head;
--				local l_v2747_Attribute_0 = v2747:GetAttribute("EmitCount");
--				v2747:Emit(l_v2747_Attribute_0);
--				v2749:Emit(l_v2747_Attribute_0);
--				local l_v2746_0 = v2746 --[[ copy: 3 -> 252 ]];
--				local l_v2748_0 = v2748 --[[ copy: 5 -> 253 ]];
--				v0.task.delay(1.2, function()
--					if l_v2746_0 ~= nil and l_v2746_0.Parent ~= nil then
--						l_v2746_0:Destroy();
--					end;
--					if l_v2748_0 ~= nil and l_v2748_0.Parent ~= nil then
--						l_v2748_0:Destroy();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "Dragon'sFuryEyeFlashBlack" then
--			local l_On_189 = v724.On;
--			if not (l_On_189 ~= nil) or l_On_189.Parent == nil then
--				return;
--			else
--				local v2754 = v0.Instance.new("Attachment");
--				v2754.Position = v0.Vector3.new(0.13, 0.27, -0.65);
--				local v2755 = l_Assets_0.Particles.MartialArtist["Dragon'sFury"].FlareBlack:Clone();
--				v2755.Parent = v2754;
--				local v2756 = v0.Instance.new("Attachment");
--				v2756.Position = v0.Vector3.new(-0.1, 0.27, -0.65);
--				local v2757 = l_Assets_0.Particles.MartialArtist["Dragon'sFury"].FlareBlack:Clone();
--				v2757.Parent = v2756;
--				v2754.Parent = l_On_189.Head;
--				v2756.Parent = l_On_189.Head;
--				local l_v2755_Attribute_0 = v2755:GetAttribute("EmitCount");
--				v2755:Emit(l_v2755_Attribute_0);
--				v2757:Emit(l_v2755_Attribute_0);
--				local l_v2754_0 = v2754 --[[ copy: 3 -> 250 ]];
--				local l_v2756_0 = v2756 --[[ copy: 5 -> 251 ]];
--				v0.task.delay(1.2, function()
--					if l_v2754_0 ~= nil and l_v2754_0.Parent ~= nil then
--						l_v2754_0:Destroy();
--					end;
--					if l_v2756_0 ~= nil and l_v2756_0.Parent ~= nil then
--						l_v2756_0:Destroy();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "Dragon'sFuryBreath" then
--			local l_On_190 = v724.On;
--			if not (l_On_190 ~= nil) or l_On_190.Parent == nil then
--				return;
--			else
--				local v2762 = v0.Instance.new("Attachment");
--				v2762.Position = v0.Vector3.new(0, -0.29, -0.508);
--				local v2763 = l_Assets_0.Particles.MartialArtist["Dragon'sFury"].Breath:Clone();
--				v2763.Parent = v2762;
--				v2762.Parent = l_On_190.Head;
--				v2763:Emit(v2763:GetAttribute("EmitCount"));
--				local l_v2762_0 = v2762 --[[ copy: 3 -> 249 ]];
--				v0.task.delay(0.5, function()
--					if l_v2762_0 ~= nil and l_v2762_0.Parent ~= nil then
--						l_v2762_0:Destroy();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "Dragon'sFuryCameraShake" then
--			VFXService.ShakeCamera(0.05, 3.45, 33, 0.42, 0.55, 0.42);
--		end;
--		if l_Request_1 == "Dragon'sFuryTornado" then
--			local l_On_191 = v724.On;
--			if not (l_On_191 ~= nil) or l_On_191.Parent == nil then
--				return;
--			else
--				local v2766 = nil;
--				local v2767 = 0;
--				local v2768 = 1;
--				local v2769 = {
--					v0.TweenInfo.new(0.115, v0.Enum.EasingStyle.Linear), 
--					v0.TweenInfo.new(0.335, v0.Enum.EasingStyle.Linear), 
--					v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), 
--					v0.TweenInfo.new(0.565, v0.Enum.EasingStyle.Quad, v0.Enum.EasingDirection.Out), 
--					v0.TweenInfo.new(0.15, v0.Enum.EasingStyle.Linear), 
--					v0.TweenInfo.new(0.275, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), 
--					v0.TweenInfo.new(0.385, v0.Enum.EasingStyle.Quad, v0.Enum.EasingDirection.Out), 
--					v0.TweenInfo.new(0.215, v0.Enum.EasingStyle.Linear), 
--					v0.TweenInfo.new(0.085, v0.Enum.EasingStyle.Linear), 
--					v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Quad, v0.Enum.EasingDirection.Out), 
--					v0.TweenInfo.new(0.285, v0.Enum.EasingStyle.Quad, v0.Enum.EasingDirection.Out), 
--					v0.TweenInfo.new(0.3, v0.Enum.EasingStyle.Linear), 
--					v0.TweenInfo.new(0.385, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), 
--					v0.TweenInfo.new(0.465, v0.Enum.EasingStyle.Quad, v0.Enum.EasingDirection.Out)
--				};
--				local v2770 = {
--					v0.CFrame.Angles(-v0.math.pi / 2, 0, 0), 
--					v0.CFrame.Angles(0, 0, 280)
--				};
--				local l_Tornado_0 = l_Assets_0.Parts.MartialArtist["Dragon'sFury"].Tornado;
--				local v2772 = l_Assets_0.Particles.MartialArtist["Dragon'sFury"].Tornado:Clone();
--				v2772.CFrame = l_On_191.HumanoidRootPart.CFrame - v0.Vector3.new(0, 2, 0);
--				v2772.Parent = l_VFX_0;
--				local v2773 = v0.Random.new();
--				local l_l_On_191_0 = l_On_191 --[[ copy: 2 -> 243 ]];
--				local l_v2772_0 = v2772 --[[ copy: 9 -> 244 ]];
--				local l_v2773_0 = v2773 --[[ copy: 10 -> 245 ]];
--				local l_l_Tornado_0_0 = l_Tornado_0 --[[ copy: 8 -> 246 ]];
--				local l_v2770_0 = v2770 --[[ copy: 7 -> 247 ]];
--				local l_v2769_0 = v2769 --[[ copy: 6 -> 248 ]];
--				do
--					local l_v2766_0, l_v2767_0, l_v2768_0 = v2766, v2767, v2768;
--					l_v2766_0 = l_RenderStepped_0:Connect(function(v2783)
--						if l_l_On_191_0 ~= nil and l_l_On_191_0.Parent ~= nil then
--							l_v2767_0 = l_v2767_0 + v2783;
--							l_v2772_0.CFrame = l_l_On_191_0.HumanoidRootPart.CFrame - v0.Vector3.new(0, 2, 0);
--							if l_v2767_0 >= 0.2 then
--								l_v2767_0 = 0;
--								local v2784 = l_v2773_0:NextNumber(1, 1.4);
--								l_v2768_0 = l_v2768_0 == 1 and 2 or 1;
--								local v2785 = l_l_Tornado_0_0.Tornado3:Clone();
--								v2785.CFrame = l_l_On_191_0.HumanoidRootPart.CFrame * l_v2770_0[1] + v0.Vector3.new(0, 1, 0);
--								local l_Mesh_6 = v2785.Mesh;
--								local v2787 = l_TweenService_0:Create(v2785.Decal, l_v2769_0[1], {
--									Transparency = l_v2768_0 > 1 and 0.75 or 0.9
--								});
--								local v2788 = l_TweenService_0:Create(l_Mesh_6, l_v2769_0[3], {
--									Scale = v0.Vector3.new(45, 45, 35) * v2784
--								});
--								local v2789 = l_TweenService_0:Create(v2785.Decal, l_v2769_0[2], {
--									Transparency = 1
--								});
--								local v2790 = l_TweenService_0:Create(v2785, l_v2769_0[4], {
--									Orientation = v2785.Orientation + v0.Vector3.new(0, 350, 0)
--								});
--								v2789.Completed:Connect(function()
--									if v2785 ~= nil and v2785.Parent ~= nil then
--										v2785:Destroy();
--									end;
--								end);
--								local v2791 = l_l_Tornado_0_0.Tornado4:Clone();
--								v2791.CFrame = l_l_On_191_0.HumanoidRootPart.CFrame * l_v2770_0[1];
--								local l_Mesh_7 = v2791.Mesh;
--								local v2793 = l_TweenService_0:Create(v2791.Decal, l_v2769_0[5], {
--									Transparency = l_v2768_0 == 2 and 0.6 or 0.75
--								});
--								local v2794 = l_TweenService_0:Create(l_Mesh_7, l_v2769_0[6], {
--									Scale = v0.Vector3.new(50, 50, 45) * v2784
--								});
--								local v2795 = l_TweenService_0:Create(v2791, l_v2769_0[7], {
--									Orientation = v2791.Orientation + v0.Vector3.new(0, -160, 0)
--								});
--								local v2796 = l_TweenService_0:Create(v2791.Decal, l_v2769_0[8], {
--									Transparency = 1
--								});
--								v2796.Completed:Connect(function()
--									if v2791 ~= nil and v2791.Parent ~= nil then
--										v2791:Destroy();
--									end;
--								end);
--								local v2797 = nil;
--								local v2798 = nil;
--								local v2799 = nil;
--								local v2800 = nil;
--								local v2801 = nil;
--								local v2802 = nil;
--								if l_v2768_0 == 1 then
--									v2797 = l_l_Tornado_0_0.Tornado4:Clone();
--									v2797.CFrame = l_l_On_191_0.HumanoidRootPart.CFrame * l_v2770_0[1];
--									local l_Mesh_8 = v2797.Mesh;
--									v2797.Decal.Color3 = v0.Color3.fromRGB(255, 255, 255);
--									l_Mesh_8.Scale = v0.Vector3.new(30, 30, 25);
--									v2798 = l_TweenService_0:Create(v2797.Decal, l_v2769_0[9], {
--										Transparency = 0.25
--									});
--									v2799 = l_TweenService_0:Create(l_Mesh_8, l_v2769_0[3], {
--										Scale = v0.Vector3.new(65, 65, 25) * v2784
--									});
--									v2800 = l_TweenService_0:Create(v2797, l_v2769_0[10], {
--										Position = v2797.Position + v0.Vector3.new(0, l_v2773_0:NextNumber(15, 25) * (v0.math.random(1, 2) == 1 and 1 or -1), 0)
--									});
--									v2801 = l_TweenService_0:Create(v2797, l_v2769_0[11], {
--										Orientation = v2797.Orientation + v0.Vector3.new(0, 360, 0)
--									});
--									v2802 = l_TweenService_0:Create(v2797.Decal, l_v2769_0[12], {
--										Transparency = 1
--									});
--									v2802.Completed:Connect(function()
--										if v2797 ~= nil and v2797.Parent ~= nil then
--											v2797:Destroy();
--										end;
--									end);
--								end;
--								local v2804 = l_l_Tornado_0_0.Tornado1:Clone();
--								v2804.CFrame = l_l_On_191_0.HumanoidRootPart.CFrame * l_v2770_0[1];
--								local _ = v2804.Mesh;
--								local v2806 = l_TweenService_0:Create(v2804.Decal, l_v2769_0[9], {
--									Transparency = 0.675
--								});
--								local v2807 = l_TweenService_0:Create(v2804.Mesh, l_v2769_0[13], {
--									Scale = v0.Vector3.new(60, 60, 30) * v2784
--								});
--								local v2808 = l_TweenService_0:Create(v2804, l_v2769_0[14], {
--									CFrame = v2804.CFrame * v0.CFrame.new(0, 0, 30) * l_v2770_0[2]
--								});
--								local v2809 = l_TweenService_0:Create(v2804.Decal, l_v2769_0[12], {
--									Transparency = 1
--								});
--								v2809.Completed:Connect(function()
--									if v2804 ~= nil and v2804.Parent ~= nil then
--										v2804:Destroy();
--									end;
--								end);
--								v2785.Parent = l_VFX_0;
--								v0.task.delay(0.2, function()
--									if v2789 ~= nil then
--										v2789:Play();
--									end;
--								end);
--								v2787:Play();
--								v2788:Play();
--								v2790:Play();
--								v2791.Parent = l_VFX_0;
--								v0.task.delay(0.125, function()
--									if v2796 ~= nil then
--										v2796:Play();
--									end;
--								end);
--								v2793:Play();
--								v2794:Play();
--								v2795:Play();
--								if l_v2768_0 == 1 then
--									v2797.Parent = l_VFX_0;
--									v0.task.delay(0.115, function()
--										if v2802 ~= nil then
--											v2802:Play();
--										end;
--									end);
--									v2798:Play();
--									v2799:Play();
--									v2800:Play();
--									v2801:Play();
--								end;
--								v2804.Parent = l_VFX_0;
--								v0.task.delay(0.125, function()
--									if v2809 ~= nil then
--										v2809:Play();
--									end;
--								end);
--								v2806:Play();
--								v2807:Play();
--								v2808:Play();
--								return;
--							end;
--						else
--							if l_v2766_0 ~= nil then
--								l_v2766_0:Disconnect();
--								l_v2766_0 = nil;
--							end;
--							if l_v2772_0 ~= nil and l_v2772_0.Parent ~= nil then
--								for _, v2811 in v0.pairs(l_v2772_0:GetDescendants()) do
--									if v2811:IsA("ParticleEmitter") then
--										v2811.Enabled = false;
--									end;
--								end;
--								v0.task.delay(2.5, function()
--									if l_v2772_0 ~= nil and l_v2772_0.Parent ~= nil then
--										l_v2772_0:Destroy();
--									end;
--								end);
--							end;
--						end;
--					end);
--					VFXService.CreateBind(l_On_191, "Dragon'sFuryTornadoEffect", function()
--						if l_v2766_0 ~= nil then
--							l_v2766_0:Disconnect();
--							l_v2766_0 = nil;
--						end;
--						if l_v2772_0 ~= nil and l_v2772_0.Parent ~= nil then
--							for _, v2813 in v0.pairs(l_v2772_0:GetDescendants()) do
--								if v2813:IsA("ParticleEmitter") then
--									v2813.Enabled = false;
--								end;
--							end;
--							v0.task.delay(2.5, function()
--								if l_v2772_0 ~= nil and l_v2772_0.Parent ~= nil then
--									l_v2772_0:Destroy();
--								end;
--							end);
--						end;
--					end);
--				end;
--			end;
--		end;
--		if l_Request_1 == "EndDragon'sFuryTornado" then
--			local l_On_192 = v724.On;
--			if not (l_On_192 ~= nil) or l_On_192.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_192, "Dragon'sFuryTornadoEffect");
--			end;
--		end;
--		if l_Request_1 == "Dragon'sFurySpawn" then
--			local l_On_193 = v724.On;
--			if not (l_On_193 ~= nil) or l_On_193.Parent == nil then
--				return;
--			else
--				local v2816 = v0.tostring(v724.Tag);
--				local l_At_2 = v724.At;
--				local v2818 = v0.Instance.new("Folder");
--				v2818.Name = "Dragon'sFuryYinYang" .. v2816;
--				v2818.Parent = l_VFX_0;
--				local v2819 = l_Assets_0.Parts.MartialArtist["Dragon'sFury"].White:Clone();
--				local v2820 = l_Assets_0.Parts.MartialArtist["Dragon'sFury"].Black:Clone();
--				local v2821 = v0.Instance.new("NumberValue");
--				v2821.Value = 30;
--				v2821.Parent = v2818;
--				local v2822 = v0.Instance.new("NumberValue");
--				v2822.Value = 45;
--				v2822.Parent = v2818;
--				local v2823 = v0.Instance.new("NumberValue");
--				v2823.Value = 0;
--				v2823.Parent = v2818;
--				local v2824 = l_At_2 + l_At_2.RightVector * v2821.Value + l_At_2.UpVector * v2822.Value;
--				local v2825 = l_At_2 + l_At_2.RightVector * -v2821.Value + l_At_2.UpVector * v2822.Value;
--				v2819.CFrame = v2824;
--				v2820.CFrame = v2825;
--				v2819.Parent = v2818;
--				v2820.Parent = v2818;
--				for _, v2827 in v0.pairs(v2820:GetDescendants()) do
--					if v2827:IsA("ParticleEmitter") then
--						v2827.Enabled = true;
--					end;
--				end;
--				for _, v2829 in v0.pairs(v2819:GetDescendants()) do
--					if v2829:IsA("ParticleEmitter") then
--						v2829.Enabled = true;
--					end;
--				end;
--				local v2830 = v0.CFrame.new(l_At_2.Position, v0.Vector3.new(v2824.Position.X, l_At_2.Position.Y, v2824.Position.Z));
--				local _ = v0.CFrame.new(l_At_2.Position, v0.Vector3.new(v2825.Position.X, l_At_2.Position.Y, v2825.Position.Z));
--				local v2832 = nil;
--				local l_v2818_0 = v2818 --[[ copy: 5 -> 228 ]];
--				local l_v2821_0 = v2821 --[[ copy: 8 -> 229 ]];
--				local l_v2822_0 = v2822 --[[ copy: 9 -> 230 ]];
--				local l_v2823_0 = v2823 --[[ copy: 10 -> 231 ]];
--				local l_v2819_0 = v2819 --[[ copy: 6 -> 232 ]];
--				local l_l_At_2_0 = l_At_2 --[[ copy: 4 -> 233 ]];
--				local l_v2830_0 = v2830 --[[ copy: 13 -> 234 ]];
--				local l_v2820_0 = v2820 --[[ copy: 7 -> 235 ]];
--				do
--					local l_v2832_0 = v2832;
--					l_v2832_0 = l_RunService_0.RenderStepped:Connect(function()
--						if l_v2818_0 ~= nil and l_v2818_0.Parent ~= nil and l_v2821_0 ~= nil and l_v2821_0.Parent ~= nil and l_v2822_0 ~= nil and l_v2822_0.Parent ~= nil and l_v2823_0 ~= nil and l_v2823_0.Parent ~= nil then
--							if l_v2819_0 ~= nil and l_v2819_0.Parent ~= nil then
--								local l_Value_1 = l_v2823_0.Value;
--								local v2843 = l_Value_1 + v0.math.pi;
--								local v2844 = v0.math.sin(l_Value_1);
--								local v2845 = v0.math.cos(l_Value_1);
--								local v2846 = v0.math.sin(v2843);
--								local v2847 = v0.math.cos(v2843);
--								l_v2819_0.CFrame = l_l_At_2_0 + l_v2830_0.LookVector * (l_v2821_0.Value * v2845) + l_v2830_0.RightVector * (v2844 * l_v2821_0.Value) + v0.Vector3.new(0, l_v2822_0.Value, 0);
--								l_v2820_0.CFrame = l_l_At_2_0 + l_v2830_0.LookVector * (l_v2821_0.Value * v2847) + l_v2830_0.RightVector * (v2846 * l_v2821_0.Value) + v0.Vector3.new(0, l_v2822_0.Value, 0);
--								return;
--							end;
--						elseif l_v2832_0 ~= nil then
--							l_v2832_0:Disconnect();
--							l_v2832_0 = nil;
--						end;
--					end);
--					local l_Position_16 = l_At_2.Position;
--					local v2849 = l_TweenService_0:Create(v2819, v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Back, v0.Enum.EasingDirection.In), {
--						Position = l_Position_16
--					});
--					local v2850 = l_TweenService_0:Create(v2820, v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Back, v0.Enum.EasingDirection.In), {
--						Position = l_Position_16
--					});
--					local l_l_On_193_0 = l_On_193 --[[ copy: 2 -> 236 ]];
--					local l_l_Position_16_0 = l_Position_16 --[[ copy: 16 -> 237 ]];
--					v2849.Completed:Connect(function()
--						if not (l_v2818_0 ~= nil) or l_v2818_0.Parent == nil then
--							return;
--						else
--							l_v2818_0:Destroy();
--							if not (l_l_On_193_0 ~= nil) or l_l_On_193_0.Parent == nil then
--								return;
--							else
--								local v2853 = l_Assets_0.Particles.MartialArtist["Dragon'sFury"].Explosion:Clone();
--								v2853.Position = l_l_Position_16_0;
--								v2853.Parent = l_VFX_0;
--								VFXService.EmitParticlesInInstance(v2853);
--								VFXService.DestroyParticleContainer(v2853, 2);
--								if (l_l_Position_16_0 - l_HumanoidRootPart_0.Position).Magnitude <= 200 then
--									VFXService.ShakeCamera(0.03, 0.4, 40, 0.5, 0.5, 0.5);
--								end;
--								v0.task.desynchronize();
--								local v2854 = {};
--								local v2855 = {};
--								local v2856 = VFXService.GetRandomAngle();
--								VFXService.GetCircularRocksProperties(v2854, l_l_At_2_0, {
--									40, 
--									110
--								}, 6, {
--									39, 
--									53
--								}, {
--									18, 
--									29
--								}, {
--									18, 
--									29
--								}, {
--									-1, 
--									1
--								}, {
--									-1, 
--									1
--								}, {
--									-1, 
--									1
--								}, {
--									"Rise", 
--									"Sink"
--								}, 8, false, nil, nil, {
--									-5, 
--									5
--								}, {
--									4, 
--									6.5
--								}, {
--									-5, 
--									5
--								});
--								VFXService.GetCircularRocksProperties(v2854, l_l_At_2_0 * v0.CFrame.Angles(0, v2856, 0), {
--									40, 
--									110
--								}, 5, {
--									39, 
--									53
--								}, {
--									19, 
--									27
--								}, {
--									19, 
--									27
--								}, {
--									-1, 
--									1
--								}, {
--									-1, 
--									1
--								}, {
--									-1, 
--									1
--								}, {
--									"Rise", 
--									"Sink"
--								}, 8, false, nil, nil, {
--									-5, 
--									5
--								}, {
--									4, 
--									6.5
--								}, {
--									-5, 
--									5
--								});
--								VFXService.GetCircularRocksProperties(v2854, l_l_At_2_0 * v0.CFrame.Angles(0, v2856 + v0.math.pi, 0), {
--									45, 
--									110
--								}, 5, {
--									36, 
--									49
--								}, {
--									14, 
--									28
--								}, {
--									14, 
--									28
--								}, {
--									-1, 
--									1
--								}, {
--									-1, 
--									1
--								}, {
--									-1, 
--									1
--								}, {
--									"Rise", 
--									"Sink"
--								}, 8, false, nil, nil, {
--									-5, 
--									5
--								}, {
--									2, 
--									3
--								}, {
--									-5, 
--									5
--								});
--								VFXService.GetCircularRocksProperties(v2854, l_l_At_2_0, {
--									80, 
--									110
--								}, 5, {
--									32, 
--									42
--								}, {
--									14, 
--									34
--								}, {
--									14, 
--									34
--								}, {
--									-1, 
--									1
--								}, {
--									-1, 
--									1
--								}, {
--									-1, 
--									1
--								}, {
--									"Rise", 
--									"Sink"
--								}, 8, false, {
--									IncludeDuplicate = true
--								}, nil, {
--									-5, 
--									5
--								}, {
--									2, 
--									3
--								}, {
--									-5, 
--									5
--								});
--								VFXService.GetCircularRocksProperties(v2854, l_l_At_2_0 * v0.CFrame.Angles(0, v2856 + v0.math.pi * 3, 0), {
--									45, 
--									95
--								}, 5, {
--									23, 
--									39
--								}, {
--									14, 
--									20
--								}, {
--									14, 
--									20
--								}, {
--									-1, 
--									1
--								}, {
--									-1, 
--									1
--								}, {
--									-1, 
--									1
--								}, {
--									"Rise", 
--									"Sink"
--								}, 8, false, nil, nil, {
--									-9, 
--									9
--								}, {
--									3.75, 
--									5
--								}, {
--									-8, 
--									8
--								});
--								VFXService.GetCircularRocksProperties(v2854, l_l_At_2_0 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--									45, 
--									95
--								}, 5, {
--									23, 
--									39
--								}, {
--									14, 
--									20
--								}, {
--									14, 
--									20
--								}, {
--									-1, 
--									1
--								}, {
--									-1, 
--									1
--								}, {
--									-1, 
--									1
--								}, {
--									"Rise", 
--									"Sink"
--								}, 8, false, {
--									IncludeDuplicate = true
--								}, nil, {
--									-9, 
--									9
--								}, {
--									3.75, 
--									5
--								}, {
--									-8, 
--									8
--								});
--								VFXService.GetFlyingRocksProperties(v2855, l_l_At_2_0, v0.math.random(9, 11), {
--									20, 
--									190
--								}, {
--									170, 
--									170
--								}, {
--									20, 
--									190
--								}, 7, 7, 7, 3);
--								VFXService.GetFlyingRocksProperties(v2855, l_l_At_2_0, v0.math.random(9, 11), {
--									20, 
--									190
--								}, {
--									170, 
--									170
--								}, {
--									20, 
--									190
--								}, 5, 5, 5, 3);
--								VFXService.GetFlyingRocksProperties(v2855, l_l_At_2_0, v0.math.random(9, 11), {
--									20, 
--									190
--								}, {
--									170, 
--									170
--								}, {
--									20, 
--									190
--								}, 5.5, 5.5, 5.5, 3);
--								VFXService.GetFlyingRocksProperties(v2855, l_l_At_2_0, v0.math.random(9, 11), {
--									20, 
--									190
--								}, {
--									170, 
--									170
--								}, {
--									20, 
--									190
--								}, 4, 4, 4, 3);
--								VFXService.GetFlyingRocksProperties(v2855, l_l_At_2_0, v0.math.random(9, 11), {
--									20, 
--									190
--								}, {
--									170, 
--									170
--								}, {
--									20, 
--									190
--								}, 6, 6, 6, 3);
--								v0.task.synchronize();
--								VFXService.ApplyCircularRocksProperties(v2854);
--								VFXService.ApplyFlyingRocksProperties(v2855);
--								local v2857 = l_Assets_0.Parts.MartialArtist["Dragon'sFury"].YinYang:Clone();
--								v2857.Size = v0.Vector3.zero;
--								v2857.CFrame = l_l_At_2_0 * v0.CFrame.Angles(v0.math.pi, v0.math.pi / 2, v0.math.pi / 2) + v0.Vector3.new(0, 1, 0);
--								v2857.Parent = l_VFX_0;
--								local _ = v2857.CFrame;
--								local v2859 = l_TweenService_0:Create(v2857, v0.TweenInfo.new(0.6, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--									Size = v0.Vector3.new(0.001, 100, 100)
--								});
--								local v2860 = l_TweenService_0:Create(v2857, v0.TweenInfo.new(4, v0.Enum.EasingStyle.Linear, v0.Enum.EasingDirection.Out), {
--									Orientation = v2857.Orientation + v0.Vector3.new(0, -6000, 0)
--								});
--								local v2861 = l_TweenService_0:Create(v2857, v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--									Size = v0.Vector3.zero
--								});
--								v2861.Completed:Connect(function()
--									v0.task.delay(0.9, function()
--										if v2857 ~= nil and v2857.Parent ~= nil then
--											v2857:Destroy();
--										end;
--									end);
--								end);
--								v2859:Play();
--								v2860:Play();
--								v0.task.delay(3.5, function()
--									if v2861 ~= nil then
--										v2861:Play();
--										for _, v2863 in v0.pairs(v2857:GetDescendants()) do
--											if v2863:IsA("ParticleEmitter") then
--												v2863.Enabled = false;
--											end;
--										end;
--									end;
--									if v2857 ~= nil and v2857.Parent ~= nil then
--										l_TweenService_0:Create(v2857.Face1, v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--											Transparency = 1
--										}):Play();
--										l_TweenService_0:Create(v2857.Face2, v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--											Transparency = 1
--										}):Play();
--									end;
--								end);
--								return;
--							end;
--						end;
--					end);
--					local v2864 = l_TweenService_0:Create(v2823, v0.TweenInfo.new(3.5, v0.Enum.EasingStyle.Cubic, v0.Enum.EasingDirection.InOut), {
--						Value = v0.math.pi * 12
--					});
--					local v2865 = l_TweenService_0:Create(v2822, v0.TweenInfo.new(3.5, v0.Enum.EasingStyle.Cubic, v0.Enum.EasingDirection.InOut), {
--						Value = 8
--					});
--					local v2866 = l_TweenService_0:Create(v2821, v0.TweenInfo.new(3.5, v0.Enum.EasingStyle.Cubic, v0.Enum.EasingDirection.InOut), {
--						Value = 40
--					});
--					local l_v2864_0 = v2864 --[[ copy: 19 -> 238 ]];
--					local l_v2865_0 = v2865 --[[ copy: 20 -> 239 ]];
--					local l_v2866_0 = v2866 --[[ copy: 21 -> 240 ]];
--					v0.task.delay(0.5, function()
--						if not (l_v2818_0 ~= nil) or l_v2818_0.Parent == nil then
--							return;
--						else
--							if l_v2864_0 ~= nil then
--								l_v2864_0:Play();
--							end;
--							if l_v2865_0 ~= nil then
--								l_v2865_0:Play();
--							end;
--							if l_v2866_0 ~= nil then
--								l_v2866_0:Play();
--							end;
--							return;
--						end;
--					end);
--					local l_v2849_0 = v2849 --[[ copy: 17 -> 241 ]];
--					local l_v2850_0 = v2850 --[[ copy: 18 -> 242 ]];
--					v0.task.delay(4, function()
--						if not (l_v2818_0 ~= nil) or l_v2818_0.Parent == nil then
--							return;
--						else
--							if l_v2832_0 ~= nil then
--								l_v2832_0:Disconnect();
--								l_v2832_0 = nil;
--							end;
--							if l_v2823_0 ~= nil and l_v2823_0.Parent ~= nil then
--								l_v2823_0:Destroy();
--							end;
--							if l_v2822_0 ~= nil and l_v2822_0.Parent ~= nil then
--								l_v2822_0:Destroy();
--							end;
--							if l_v2821_0 ~= nil and l_v2821_0.Parent ~= nil then
--								l_v2821_0:Destroy();
--							end;
--							v0.task.delay(0.2, function()
--								if l_v2849_0 ~= nil then
--									l_v2849_0:Play();
--								end;
--								if l_v2850_0 ~= nil then
--									l_v2850_0:Play();
--								end;
--							end);
--							return;
--						end;
--					end);
--				end;
--			end;
--		end;
--		if l_Request_1 == "DroppingFangKick" then
--			local l_On_194 = v724.On;
--			if not (l_On_194 ~= nil) or l_On_194.Parent == nil then
--				return;
--			else
--				local v2873 = VFXService.FindGroundPosition(l_On_194.HumanoidRootPart.Position + v0.Vector3.new(0, 3, 0), 15);
--				local v2874 = l_On_194.HumanoidRootPart.CFrame * v0.CFrame.Angles(v0.math.pi / 6, 0, v0.math.pi / 6);
--				local v2875 = l_Assets_0.Particles.MartialArtist.DroppingFang.Kick:Clone();
--				v2875.CFrame = v2874 + v2874.LookVector + v0.Vector3.new(0, v2875.Size.Y / 2 - 2, 0);
--				v2875.Parent = l_VFX_0;
--				if v2873 then
--					for _, v2877 in v0.pairs(v2875:GetDescendants()) do
--						if v2877:IsA("ParticleEmitter") and v2877.Name == "Smoke" then
--							v2877.Color = v0.ColorSequence.new(VFXService.MakeDarker(v2873.Instance.Color, 5, 5, 5));
--						end;
--					end;
--				end;
--				VFXService.EmitParticlesInInstance(v2875);
--				VFXService.DestroyParticleContainer(v2875, 4);
--			end;
--		end;
--		if l_Request_1 == "DroppingFangLand" then
--			local l_On_195 = v724.On;
--			if not (l_On_195 ~= nil) or l_On_195.Parent == nil then
--				return;
--			else
--				local v2879 = VFXService.FindGroundPosition(l_On_195.HumanoidRootPart.Position + v0.Vector3.new(0, 3, 0), 15);
--				if v2879 then
--					local v2880 = l_Assets_0.Particles.MartialArtist.DroppingFang.Land:Clone();
--					v2880.Position = v2879.Position;
--					v2880.Parent = l_VFX_0;
--					for _, v2882 in v0.pairs(v2880:GetDescendants()) do
--						if v2882:IsA("ParticleEmitter") and v2882.Name == "Smoke" then
--							v2882.Color = v0.ColorSequence.new(VFXService.MakeDarker(v2879.Instance.Color, 5, 5, 5));
--						end;
--					end;
--					VFXService.EmitParticlesInInstance(v2880);
--					VFXService.DestroyParticleContainer(v2880, 4);
--				end;
--			end;
--		end;
--		if l_Request_1 == "LigerBombStart" then
--			local l_On_196 = v724.On;
--			if not (l_On_196 ~= nil) or l_On_196.Parent == nil then
--				return;
--			else
--				local v2884 = v104.PlaySoundInInstance(l_On_196.HumanoidRootPart, "LigerBombStart");
--				local v2885 = l_TweenService_0:Create(v2884, v0.TweenInfo.new(0.2, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--					Volume = 0
--				});
--				local l_v2884_0 = v2884 --[[ copy: 3 -> 225 ]];
--				v2885.Completed:Connect(function()
--					if l_v2884_0 ~= nil and l_v2884_0.Parent ~= nil then
--						l_v2884_0:Destroy();
--					end;
--				end);
--				local l_v2885_0 = v2885 --[[ copy: 4 -> 226 ]];
--				local v2888 = VFXService.CreateBind(l_On_196, "LigerBombStartSoundBind", function()
--					if l_v2884_0 ~= nil and l_v2884_0.Parent ~= nil then
--						l_v2884_0:SetAttribute("DefaultVolume", nil);
--						l_v2885_0:Play();
--					end;
--				end);
--				local l_v2888_0 = v2888 --[[ copy: 5 -> 227 ]];
--				v2884.Ended:Connect(function()
--					if l_v2888_0 ~= nil and l_v2888_0.Parent ~= nil then
--						l_v2888_0:Destroy();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndLigerBombStart" then
--			local l_On_197 = v724.On;
--			if not (l_On_197 ~= nil) or l_On_197.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_197, "LigerBombStartSoundBind");
--			end;
--		end;
--		if l_Request_1 == "LigerBombImpact" then
--			local v2891 = v724.At + v0.Vector3.new(0, 2, 0);
--			local v2892 = {};
--			local v2893 = {};
--			local v2894 = VFXService.GetRandomAngle();
--			local v2895 = l_Assets_0.Particles.MartialArtist.LigerBomb.Impact:Clone();
--			v2895.CFrame = v724.At * v0.CFrame.Angles(v0.math.pi / 2, 0, 0) + v0.Vector3.new(0, 0.01, 0);
--			v2895.Parent = l_VFX_0;
--			local v2896 = VFXService.FindGroundPosition(v2895.Position, 15);
--			if v2896 then
--				local v2897 = v0.ColorSequence.new(v2896.Instance.Color);
--				for _, v2899 in v0.pairs(v2895:GetDescendants()) do
--					if v2899:IsA("ParticleEmitter") and v2899.Name == "Smoke" then
--						v2899.Color = v2897;
--					end;
--				end;
--			end;
--			local _ = l_Assets_0.Parts.MartialArtist.LigerBomb.ShockwaveSmall:Clone();
--			local v2901 = VFXService.GetTile(v2891.Position);
--			VFXService.GetCircularRocksProperties(v2892, v2891 * v0.CFrame.Angles(0, v2894 + v0.math.pi / 2, 0), {
--				25, 
--				39
--			}, 7, {
--				8, 
--				15
--			}, {
--				4, 
--				5.5
--			}, {
--				4, 
--				5.5
--			}, {
--				-1, 
--				1
--			}, {
--				-1, 
--				1
--			}, {
--				-1, 
--				1
--			}, {
--				"Grow", 
--				"Sink"
--			}, 5, false, {
--				IncludeDuplicate = false
--			}, nil, {
--				-2, 
--				2
--			}, nil, {
--				-4, 
--				4
--			});
--			VFXService.GetCircularRocksProperties(v2892, v2891 * v0.CFrame.Angles(0, v2894, 0), {
--				38, 
--				49
--			}, 6, {
--				16, 
--				21
--			}, {
--				5, 
--				6.5
--			}, {
--				5, 
--				6.5
--			}, {
--				-1, 
--				1
--			}, {
--				-1, 
--				1
--			}, {
--				-1, 
--				1
--			}, {
--				"Grow", 
--				"Sink"
--			}, 5, false, {
--				IncludeDuplicate = false
--			}, nil, {
--				-2, 
--				2
--			}, nil, {
--				-4, 
--				4
--			});
--			VFXService.GetCircularRocksProperties(v2892, v2891 * v0.CFrame.Angles(0, v2894 + v0.math.pi / 4, 0), {
--				35, 
--				46
--			}, 6, {
--				13, 
--				18
--			}, {
--				5, 
--				6.5
--			}, {
--				5, 
--				6.5
--			}, {
--				-1, 
--				1
--			}, {
--				-1, 
--				1
--			}, {
--				-1, 
--				1
--			}, {
--				"Grow", 
--				"Sink"
--			}, 5, false, {
--				IncludeDuplicate = false
--			}, nil, {
--				-2, 
--				2
--			}, nil, {
--				-4, 
--				4
--			});
--			VFXService.GetCircularRocksProperties(v2892, v2891 * v0.CFrame.Angles(0, v2894 + v0.math.pi / 8, 0), {
--				46, 
--				50
--			}, 6, {
--				17, 
--				23
--			}, {
--				6.5, 
--				7.75
--			}, {
--				6.5, 
--				7.75
--			}, {
--				-1, 
--				1
--			}, {
--				-1, 
--				1
--			}, {
--				-1, 
--				1
--			}, {
--				"Grow", 
--				"Sink"
--			}, 5, false, {
--				IncludeDuplicate = false
--			}, nil, {
--				-2, 
--				2
--			}, nil, {
--				-4, 
--				4
--			});
--			VFXService.GetCircularRocksProperties(v2892, v2891 * v0.CFrame.Angles(0, v2894, 0), {
--				15, 
--				21
--			}, 5, {
--				9, 
--				11.5
--			}, {
--				2, 
--				2.25
--			}, {
--				2, 
--				2.25
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				"Grow", 
--				"Shrink", 
--				nil, 
--				4
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetCircularRocksProperties(v2892, v2891 * v0.CFrame.Angles(0, v2894 + v0.math.pi / 4, 0), {
--				15, 
--				21
--			}, 5, {
--				11, 
--				13.5
--			}, {
--				2, 
--				3
--			}, {
--				2, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				"Grow", 
--				"Shrink", 
--				nil, 
--				4
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetCircularRocksProperties(v2892, v2891 * v0.CFrame.Angles(0, v2894, 0), {
--				55, 
--				68
--			}, 6, {
--				32, 
--				38
--			}, {
--				11, 
--				12.5
--			}, {
--				11, 
--				12.5
--			}, {
--				0, 
--				0
--			}, {
--				0, 
--				0
--			}, {
--				0, 
--				0
--			}, {
--				"Grow", 
--				"Shrink", 
--				nil, 
--				4
--			}, 5, false, {
--				IncludeDuplicate = true
--			}, nil, {
--				-3, 
--				3
--			}, {
--				0.05, 
--				0.075
--			}, {
--				-1, 
--				1
--			});
--			VFXService.GetCircularRocksProperties(v2892, v2891 * v0.CFrame.Angles(0, v2894 + v0.math.pi / 2, 0), {
--				55, 
--				68
--			}, 6, {
--				35, 
--				42
--			}, {
--				12.5, 
--				14
--			}, {
--				12.5, 
--				14
--			}, {
--				0, 
--				0
--			}, {
--				0, 
--				0
--			}, {
--				0, 
--				0
--			}, {
--				"Grow", 
--				"Shrink", 
--				nil, 
--				4
--			}, 5, false, {
--				IncludeDuplicate = false
--			}, nil, {
--				-3, 
--				3
--			}, {
--				0.05, 
--				0.075
--			}, {
--				-1, 
--				1
--			});
--			VFXService.GetFlyingRocksProperties(v2893, v2891, v0.math.random(7, 8), {
--				5, 
--				120
--			}, {
--				145, 
--				145
--			}, {
--				5, 
--				120
--			}, 3.6, 3.6, 3.6, 3);
--			VFXService.GetFlyingRocksProperties(v2893, v2891, v0.math.random(7, 8), {
--				5, 
--				120
--			}, {
--				145, 
--				145
--			}, {
--				5, 
--				120
--			}, 5.5, 5.5, 5.5, 3);
--			VFXService.GetFlyingRocksProperties(v2893, v2891, v0.math.random(7, 8), {
--				5, 
--				120
--			}, {
--				145, 
--				145
--			}, {
--				5, 
--				120
--			}, 5, 5, 5, 3);
--			VFXService.GetFlyingRocksProperties(v2893, v2891, v0.math.random(7, 8), {
--				5, 
--				120
--			}, {
--				145, 
--				145
--			}, {
--				5, 
--				120
--			}, 4, 4, 4, 3);
--			VFXService.ApplyCircularRocksProperties(v2892);
--			VFXService.ApplyFlyingRocksProperties(v2893);
--			v104.PlaySoundAtCFrame(v2891, "LigerBombSlam");
--			VFXService.EmitParticlesInInstance(v2895);
--			VFXService.DestroyParticleContainer(v2895, 3);
--			if (v2891.Position - l_HumanoidRootPart_0.Position).Magnitude <= 60 then
--				VFXService.ShakeCamera(0.05, 0.7, 38, 0.6, 0.6, 0.6);
--			end;
--			VFXService.DestroyTile(v2901);
--		end;
--		if l_Request_1 == "LigerBombDropVictim" then
--			local l_On_198 = v724.On;
--			if not (l_On_198 ~= nil) or l_On_198.Parent == nil then
--				return;
--			else
--				local l_To_0 = v724.To;
--				if not (l_To_0 ~= nil) or l_To_0.Parent == nil then
--					return;
--				else
--					local v2904 = v0.tostring(v724.Tag);
--					local v2905 = nil;
--					v104.PlaySoundInInstance(l_On_198.HumanoidRootPart, "LigerBombGrab");
--					for _, v2907 in v0.pairs(l_To_0:GetChildren()) do
--						if v2907:IsA("Configuration") and v2907.Name == "LigerBombDropReplication" .. v2904 and v2907:FindFirstChildOfClass("CFrameValue") then
--							v2905 = v2907:FindFirstChildOfClass("CFrameValue");
--							break;
--						end;
--					end;
--					do
--						local l_v2905_0 = v2905;
--						if l_v2905_0 ~= nil and l_v2905_0.Parent ~= nil then
--							local v2909 = nil;
--							local l_l_On_198_0 = l_On_198 --[[ copy: 2 -> 224 ]];
--							v2909 = v0.task.spawn(function()
--								while l_l_On_198_0 ~= nil and l_l_On_198_0.Parent ~= nil and l_v2905_0 ~= nil and l_v2905_0.Parent ~= nil do
--									local l_Value_2 = l_v2905_0.Value;
--									l_l_On_198_0:PivotTo((l_Value_2 + l_Value_2.LookVector * 2.454) * v0.CFrame.Angles(0, v0.math.pi, 0));
--									v0.task.wait();
--								end;
--								v0.pcall(function()
--									l_v2905_0:Destroy();
--								end);
--							end);
--						end;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "LigerBombDrop" then
--			local l_On_199 = v724.On;
--			if not (l_On_199 ~= nil) or l_On_199.Parent == nil then
--				return;
--			else
--				local v2913 = v0.tostring(v724.Tag);
--				local l_Final_0 = v724.Final;
--				local l_LookVector_6 = l_Final_0.LookVector;
--				local l_CFrame_40 = l_On_199.HumanoidRootPart.CFrame;
--				local v2917 = v0.Instance.new("CFrameValue");
--				v2917.Value = v0.CFrame.new(l_CFrame_40.Position, l_CFrame_40.Position + l_LookVector_6);
--				local v2918 = l_Bezier_0.new(l_CFrame_40.Position);
--				v2918:AddBezierPoint(l_Final_0.Position);
--				local v2919 = VFXService.CreateBind(l_On_199, "LigerBombDropReplication" .. v2913);
--				v2917.Parent = v2919;
--				local v2920 = l_Assets_0.Particles.MartialArtist.LigerBomb.Fall:Clone();
--				local l_v2918_CFrameTween_0 = v2918:CreateCFrameTween(v2917, {
--					"Value"
--				}, v0.TweenInfo.new(0.635, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.In), nil, l_LookVector_6);
--				local v2922 = nil;
--				local l_l_On_199_0 = l_On_199 --[[ copy: 2 -> 220 ]];
--				local l_v2917_0 = v2917 --[[ copy: 7 -> 221 ]];
--				local l_v2920_0 = v2920 --[[ copy: 10 -> 222 ]];
--				v2922 = v0.task.spawn(function()
--					while l_l_On_199_0 ~= nil and l_l_On_199_0.Parent ~= nil do
--						l_l_On_199_0:PivotTo(l_v2917_0.Value);
--						l_v2920_0.CFrame = l_v2917_0.Value * v0.CFrame.Angles(v0.math.pi / 2, 0, 0);
--						v0.task.wait();
--					end;
--					v0.pcall(function()
--						l_v2917_0:Destroy();
--					end);
--				end);
--				v2920.Parent = l_VFX_0;
--				local l_v2919_0 = v2919 --[[ copy: 9 -> 223 ]];
--				do
--					local l_v2922_0 = v2922;
--					l_v2918_CFrameTween_0.Completed:Connect(function()
--						v0.pcall(function()
--							v0.task.cancel(l_v2922_0);
--						end);
--						v0.pcall(function()
--							l_v2919_0:Destroy();
--						end);
--						if l_v2920_0 ~= nil and l_v2920_0.Parent ~= nil then
--							for _, v2929 in v0.pairs(l_v2920_0:GetDescendants()) do
--								if v2929:IsA("ParticleEmitter") then
--									v2929.Enabled = false;
--								end;
--							end;
--							VFXService.DestroyParticleContainer(l_v2920_0, 2);
--						end;
--					end);
--					l_v2918_CFrameTween_0:Play();
--				end;
--			end;
--		end;
--		if l_Request_1 == "LigerBombUserJump" then
--			local l_On_200 = v724.On;
--			if not (l_On_200 ~= nil) or l_On_200.Parent == nil then
--				return;
--			else
--				local v2931 = v0.Instance.new("CFrameValue");
--				local l_Final_1 = v724.Final;
--				local l_LookVector_7 = l_Final_1.LookVector;
--				local l_CFrame_41 = l_On_200.HumanoidRootPart.CFrame;
--				v2931.Value = v0.CFrame.new(l_CFrame_41.Position, l_CFrame_41.Position + l_LookVector_7);
--				local v2935 = l_Bezier_0.new(l_CFrame_41.Position);
--				v2935:AddBezierPoint(l_Final_1.Position);
--				local l_v2935_CFrameTween_0 = v2935:CreateCFrameTween(v2931, {
--					"Value"
--				}, v0.TweenInfo.new(0.7, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), nil, l_LookVector_7);
--				local v2937 = nil;
--				local l_l_On_200_0 = l_On_200 --[[ copy: 2 -> 218 ]];
--				local l_v2931_0 = v2931 --[[ copy: 3 -> 219 ]];
--				v2937 = v0.task.spawn(function()
--					while l_l_On_200_0 ~= nil and l_l_On_200_0.Parent ~= nil do
--						l_l_On_200_0:PivotTo(l_v2931_0.Value);
--						v0.task.wait();
--					end;
--					v0.pcall(function()
--						l_v2931_0:Destroy();
--					end);
--				end);
--				do
--					local l_v2937_0 = v2937;
--					l_v2935_CFrameTween_0.Completed:Connect(function()
--						v0.pcall(function()
--							v0.task.cancel(l_v2937_0);
--						end);
--						v0.pcall(function()
--							l_v2931_0:Destroy();
--						end);
--					end);
--					l_v2935_CFrameTween_0:Play();
--					v104.PlaySoundInInstance(l_On_200.HumanoidRootPart, "LigerBombJump");
--					if (l_CFrame_41.Position - l_HumanoidRootPart_0.Position).Magnitude <= 20 then
--						VFXService.ShakeCamera(0.02, 0.25, 17, 0.4, 0.4, 0.4);
--					end;
--					local v2941 = {};
--					local v2942 = {};
--					local v2943 = l_Assets_0.Particles.MartialArtist.LigerBomb.Jump:Clone();
--					v2943.CFrame = l_CFrame_41 * v0.CFrame.Angles(v0.math.pi / 2, 0, 0) - v0.Vector3.new(0, 2.5, 0);
--					v2943.Parent = l_VFX_0;
--					local v2944 = VFXService.FindGroundPosition(v2943.Position, 15);
--					if v2944 then
--						local v2945 = v0.ColorSequence.new(v2944.Instance.Color);
--						for _, v2947 in v0.pairs(v2943:GetDescendants()) do
--							if v2947:IsA("ParticleEmitter") and v2947.Name == "Smoke" then
--								v2947.Color = v2945;
--							end;
--						end;
--					end;
--					local v2948 = VFXService.GetRandomAngle();
--					local v2949 = VFXService.GetTile(l_CFrame_41.Position);
--					VFXService.GetCircularRocksProperties(v2941, l_CFrame_41 * v0.CFrame.Angles(0, v2948, 0), {
--						18, 
--						27
--					}, 5, {
--						8, 
--						11
--					}, {
--						4, 
--						5
--					}, {
--						4, 
--						5
--					}, {
--						-1, 
--						1
--					}, {
--						-1, 
--						1
--					}, {
--						-1, 
--						1
--					}, {
--						"Grow", 
--						"Sink"
--					}, 5, false, {
--						IncludeDuplicate = false
--					}, nil, {
--						-2, 
--						2
--					}, nil, {
--						-3, 
--						3
--					});
--					VFXService.GetCircularRocksProperties(v2941, l_CFrame_41 * v0.CFrame.Angles(0, v2948 + v0.math.pi / 4, 0), {
--						18, 
--						27
--					}, 5, {
--						7, 
--						15
--					}, {
--						4.75, 
--						6
--					}, {
--						4.75, 
--						6
--					}, {
--						-1, 
--						1
--					}, {
--						-1, 
--						1
--					}, {
--						-1, 
--						1
--					}, {
--						"Grow", 
--						"Sink"
--					}, 5, false, {
--						IncludeDuplicate = false
--					}, nil, {
--						-2, 
--						2
--					}, nil, {
--						-4, 
--						4
--					});
--					VFXService.GetCircularRocksProperties(v2941, l_CFrame_41 * v0.CFrame.Angles(0, v2948, 0), {
--						18, 
--						27
--					}, 4, {
--						8, 
--						11
--					}, {
--						4, 
--						5
--					}, {
--						4, 
--						5
--					}, {
--						-1, 
--						1
--					}, {
--						-1, 
--						1
--					}, {
--						-1, 
--						1
--					}, {
--						"Grow", 
--						"Sink"
--					}, 5, false, {
--						IncludeDuplicate = false
--					}, nil, {
--						-2, 
--						2
--					}, nil, {
--						-4, 
--						4
--					});
--					VFXService.GetCircularRocksProperties(v2941, l_CFrame_41 * v0.CFrame.Angles(0, v2948 + v0.math.pi / 2, 0), {
--						18, 
--						27
--					}, 5, {
--						7, 
--						15
--					}, {
--						4.75, 
--						6
--					}, {
--						4.75, 
--						6
--					}, {
--						-1, 
--						1
--					}, {
--						-1, 
--						1
--					}, {
--						-1, 
--						1
--					}, {
--						"Grow", 
--						"Sink"
--					}, 5, false, {
--						IncludeDuplicate = true
--					}, nil, {
--						-2, 
--						2
--					}, nil, {
--						-4, 
--						4
--					});
--					VFXService.GetFlyingRocksProperties(v2942, l_CFrame_41, 4, {
--						8, 
--						49
--					}, {
--						92, 
--						92
--					}, {
--						8, 
--						49
--					}, 2.5, 2.5, 2.5, 5);
--					VFXService.GetFlyingRocksProperties(v2942, l_CFrame_41, 3, {
--						8, 
--						49
--					}, {
--						92, 
--						92
--					}, {
--						8, 
--						49
--					}, 1.3, 1.3, 1.1, 5);
--					VFXService.GetFlyingRocksProperties(v2942, l_CFrame_41, 5, {
--						8, 
--						49
--					}, {
--						92, 
--						92
--					}, {
--						8, 
--						49
--					}, 1, 1, 1, 5);
--					VFXService.ApplyCircularRocksProperties(v2941);
--					VFXService.ApplyFlyingRocksProperties(v2942);
--					VFXService.DestroyTile(v2949);
--					v104.PlaySoundInInstance(l_On_200.HumanoidRootPart, "LigerBombJumpCrater");
--					VFXService.EmitParticlesInInstance(v2943);
--					VFXService.DestroyParticleContainer(v2943, 3.5);
--				end;
--			end;
--		end;
--		if l_Request_1 == "LigerBombOffsetVictim" then
--			local l_On_201 = v724.On;
--			if not (l_On_201 ~= nil) or l_On_201.Parent == nil then
--				return;
--			else
--				local v2951 = v724.New or v0.Vector3.zero;
--				local v2952 = v0.tostring(v724.Tag);
--				local l_CFrame_42 = l_On_201.HumanoidRootPart.CFrame;
--				local v2954 = l_Assets_0.Particles.MartialArtist.LigerBomb.Kick:Clone();
--				v2954.CFrame = l_CFrame_42 * v0.CFrame.Angles(v0.math.pi / 2, 0, 0);
--				local v2955 = VFXService.FindGroundPosition(l_CFrame_42.Position, 15);
--				if v2955 then
--					local v2956 = v0.ColorSequence.new(v2955.Instance.Color);
--					for _, v2958 in v0.pairs(v2954:GetDescendants()) do
--						if v2958:IsA("ParticleEmitter") and v2958.Name == "Smoke" then
--							v2958.Color = v2956;
--						end;
--					end;
--				end;
--				v2954.Parent = l_VFX_0;
--				v104.PlaySoundAtCFrame(l_CFrame_42, "LigerBombKick");
--				VFXService.EmitParticlesInInstance(v2954);
--				VFXService.DestroyParticleContainer(v2954, 2);
--				for _, v2960 in v0.pairs(l_On_201:GetChildren()) do
--					if v2960:IsA("Configuration") and v2960.Name == "LigerBombCarryReplicationInstant" .. v2952 and v2960:FindFirstChildOfClass("Vector3Value") then
--						l_TweenService_0:Create(v2960:FindFirstChildOfClass("Vector3Value"), v0.TweenInfo.new(1.1, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--							Value = v2951
--						}):Play();
--					end;
--				end;
--				if (l_On_201.HumanoidRootPart.Position - l_HumanoidRootPart_0.Position).Magnitude <= 15 then
--					VFXService.ShakeCamera(0.02, 0.3, 23, 0.36, 0.36, 0.36);
--				end;
--			end;
--		end;
--		if l_Request_1 == "LigerBombBack" then
--			local v2961 = v0.Instance.new("BodyVelocity");
--			v2961.MaxForce = v0.Vector3.new(50000, 50000, 50000);
--			v2961.Parent = l_HumanoidRootPart_0;
--			local l_v2961_0 = v2961 --[[ copy: 2 -> 217 ]];
--			v0.task.spawn(function()
--				while l_v2961_0 ~= nil and l_v2961_0.Parent ~= nil do
--					if v0.UserSettings.GameSettings.RotationType ~= v0.Enum.RotationType.CameraRelative and not v40.NoRotate then
--						local l_Position_17 = l_HumanoidRootPart_0.Position;
--						local l_LookVector_8 = l_CurrentCamera_1.CFrame.LookVector;
--						l_HumanoidRootPart_0.CFrame = v0.CFrame.new(l_Position_17, l_Position_17 + v0.Vector3.new(l_LookVector_8.X, 0, l_LookVector_8.Z));
--					end;
--					l_v2961_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * -30 + v0.Vector3.new(0, 20, 0);
--					v0.task.wait();
--				end;
--			end);
--			v0.task.delay(0.3, function()
--				if l_v2961_0 ~= nil and l_v2961_0.Parent ~= nil then
--					l_v2961_0:Destroy();
--				end;
--			end);
--		end;
--		if l_Request_1 == "LigerBombGrabInstant" then
--			local l_On_202 = v724.On;
--			if not (l_On_202 ~= nil) or l_On_202.Parent == nil then
--				return;
--			else
--				local l_To_1 = v724.To;
--				if not (l_To_1 ~= nil) or l_To_1.Parent == nil then
--					return;
--				else
--					local v2967 = v0.tostring(v724.Tag);
--					local v2968 = v0.CFrame.new(0, 0, -2.454) * v0.CFrame.Angles(0, v0.math.pi, 0);
--					local v2969 = v724.Smooth or 0.2;
--					local v2970 = v724.EasingStyle or v0.Enum.EasingStyle.Sine;
--					local v2971 = v724.EasingDirection or v0.Enum.EasingDirection.Out;
--					local v2972 = nil;
--					local v2973 = v0.os.clock();
--					local v2974 = 0;
--					local v2975 = false;
--					if v2969 <= 0 then
--						v2975 = true;
--					end;
--					local l_HumanoidRootPart_1 = l_To_1.HumanoidRootPart;
--					local l_l_On_202_Pivot_0 = l_On_202:GetPivot();
--					v104.PlaySoundInInstance(l_On_202.HumanoidRootPart, "LigerBombHitImpact");
--					local l_l_On_202_0 = l_On_202 --[[ copy: 2 -> 207 ]];
--					do
--						local l_v2972_0, l_v2974_0, l_v2975_0 = v2972, v2974, v2975;
--						local v2982 = VFXService.CreateBind(l_On_202, "LigerBombCarryReplicationInstant" .. v2967, function()
--							v0.pcall(function()
--								v0.task.cancel(l_v2972_0);
--							end);
--							if l_l_On_202_0 ~= nil and l_l_On_202_0.Parent ~= nil and v26 ~= l_l_On_202_0 then
--								l_l_On_202_0.HumanoidRootPart.Anchored = false;
--							end;
--						end);
--						local v2983 = v0.Instance.new("Vector3Value");
--						v2983.Value = v0.Vector3.zero;
--						v2983.Parent = v2982;
--						local l_l_HumanoidRootPart_1_0 = l_HumanoidRootPart_1 --[[ copy: 13 -> 208 ]];
--						local l_v2982_0 = v2982 --[[ copy: 15 -> 209 ]];
--						local l_v2968_0 = v2968 --[[ copy: 5 -> 210 ]];
--						local l_v2983_0 = v2983 --[[ copy: 16 -> 211 ]];
--						local l_v2973_0 = v2973 --[[ copy: 10 -> 212 ]];
--						local l_v2969_0 = v2969 --[[ copy: 6 -> 213 ]];
--						local l_l_l_On_202_Pivot_0_0 = l_l_On_202_Pivot_0 --[[ copy: 14 -> 214 ]];
--						local l_v2970_0 = v2970 --[[ copy: 7 -> 215 ]];
--						local l_v2971_0 = v2971 --[[ copy: 8 -> 216 ]];
--						l_v2972_0 = v0.task.spawn(function()
--							local v2993 = false;
--							while true do
--								if l_l_On_202_0 ~= nil and l_l_On_202_0.Parent ~= nil and l_l_HumanoidRootPart_1_0 ~= nil and l_l_HumanoidRootPart_1_0.Parent ~= nil and l_v2982_0 ~= nil and l_v2982_0.Parent ~= nil then
--									if l_v2975_0 == true then
--										l_l_On_202_0:PivotTo(l_l_HumanoidRootPart_1_0.CFrame * l_v2968_0 + l_v2983_0.Value);
--										v2993 = true;
--									else
--										l_v2974_0 = (v0.os.clock() - l_v2973_0) / l_v2969_0;
--										if l_v2974_0 > 1 then
--											l_v2975_0 = true;
--											l_v2974_0 = 1;
--										end;
--										local v2994 = l_l_HumanoidRootPart_1_0.CFrame * l_v2968_0;
--										l_l_On_202_0:PivotTo(l_l_l_On_202_Pivot_0_0:Lerp(v2994 + l_v2983_0.Value, l_TweenService_0:GetValue(l_v2974_0, l_v2970_0, l_v2971_0)));
--										v2993 = true;
--									end;
--								end;
--								if not v2993 then
--									if not v2993 then
--										if l_v2982_0 ~= nil and l_v2982_0.Parent ~= nil then
--											break;
--										end;
--									end;
--								end;
--								v2993 = false;
--								v0.task.wait();
--							end;
--							l_v2982_0:Destroy();
--						end);
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "EndLigerBombGrabInstant" then
--			local l_On_203 = v724.On;
--			if not (l_On_203 ~= nil) or l_On_203.Parent == nil then
--				return;
--			else
--				local v2996 = v0.tostring(v724.Tag);
--				VFXService.DestroyBind(l_On_203, "LigerBombCarryReplicationInstant" .. v2996);
--			end;
--		end;
--		if l_Request_1 == "LigerBombGrab" then
--			local l_On_204 = v724.On;
--			if not (l_On_204 ~= nil) or l_On_204.Parent == nil then
--				return;
--			else
--				local l_To_2 = v724.To;
--				if not (l_To_2 ~= nil) or l_To_2.Parent == nil then
--					return;
--				else
--					local v2999 = v0.tostring(v724.Tag);
--					l_On_204.HumanoidRootPart.Anchored = true;
--					local v3000 = v724.Offset or v0.CFrame.new(0, 0, -2.454) * v0.CFrame.Angles(0, v0.math.pi, 0);
--					local v3001 = v724.Smooth or 0;
--					local v3002 = v724.Style or v0.Enum.EasingStyle.Exponential;
--					local v3003 = v724.Direction or v0.Enum.EasingDirection.Out;
--					local v3004 = nil;
--					local v3005 = nil;
--					local v3006 = v0.os.clock();
--					local l_HumanoidRootPart_2 = l_To_2.HumanoidRootPart;
--					local l_l_On_204_Pivot_0 = l_On_204:GetPivot();
--					local l_l_On_204_0 = l_On_204 --[[ copy: 2 -> 193 ]];
--					do
--						local l_v3004_0, l_v3005_0 = v3004, v3005;
--						local v3012 = VFXService.CreateBind(l_On_204, "LigerBombCarryReplication" .. v2999, function()
--							v0.pcall(function()
--								v0.task.cancel(l_v3004_0);
--							end);
--							v0.pcall(function()
--								v0.task.cancel(l_v3005_0);
--							end);
--							if l_l_On_204_0 ~= nil and l_l_On_204_0.Parent ~= nil and v26 ~= l_l_On_204_0 then
--								l_l_On_204_0.HumanoidRootPart.Anchored = false;
--							end;
--						end);
--						if v3001 > 0 then
--							local l_l_On_204_1 = l_On_204 --[[ copy: 2 -> 198 ]];
--							local l_l_HumanoidRootPart_2_0 = l_HumanoidRootPart_2 --[[ copy: 12 -> 199 ]];
--							local l_v3006_0 = v3006 --[[ copy: 11 -> 200 ]];
--							local l_v3001_0 = v3001 --[[ copy: 6 -> 201 ]];
--							local l_v3000_0 = v3000 --[[ copy: 5 -> 202 ]];
--							local l_v3012_0 = v3012 --[[ copy: 14 -> 203 ]];
--							local l_l_l_On_204_Pivot_0_0 = l_l_On_204_Pivot_0 --[[ copy: 13 -> 204 ]];
--							local l_v3002_0 = v3002 --[[ copy: 7 -> 205 ]];
--							local l_v3003_0 = v3003 --[[ copy: 8 -> 206 ]];
--							l_v3004_0 = v0.task.spawn(function()
--								while true do
--									if l_l_On_204_1 ~= nil and l_l_On_204_1.Parent ~= nil and l_l_HumanoidRootPart_2_0 ~= nil and l_l_HumanoidRootPart_2_0.Parent ~= nil then
--										local v3022 = (v0.os.clock() - l_v3006_0) / l_v3001_0;
--										if v3022 >= 1 then
--											l_v3005_0 = v0.task.spawn(function()
--												local v3023 = false;
--												while true do
--													if l_l_On_204_1 ~= nil and l_l_On_204_1.Parent ~= nil and l_l_HumanoidRootPart_2_0 ~= nil and l_l_HumanoidRootPart_2_0.Parent ~= nil then
--														l_l_On_204_1:PivotTo(l_l_HumanoidRootPart_2_0.CFrame * l_v3000_0);
--														v3023 = true;
--													end;
--													if not v3023 then
--														if l_v3012_0 ~= nil and l_v3012_0.Parent ~= nil then
--															break;
--														end;
--													end;
--													v3023 = false;
--													v0.task.wait();
--												end;
--												l_v3012_0:Destroy();
--											end);
--											return;
--										else
--											local v3024 = l_l_HumanoidRootPart_2_0.CFrame * l_v3000_0;
--											l_l_On_204_1:PivotTo(l_l_l_On_204_Pivot_0_0:Lerp(v3024, l_TweenService_0:GetValue(v3022, l_v3002_0, l_v3003_0)));
--										end;
--									elseif l_v3012_0 ~= nil and l_v3012_0.Parent ~= nil then
--										l_v3012_0:Destroy();
--										return;
--									end;
--									v0.task.wait();
--								end;
--							end);
--						else
--							local l_l_On_204_2 = l_On_204 --[[ copy: 2 -> 194 ]];
--							local l_l_HumanoidRootPart_2_1 = l_HumanoidRootPart_2 --[[ copy: 12 -> 195 ]];
--							local l_v3000_1 = v3000 --[[ copy: 5 -> 196 ]];
--							local l_v3012_1 = v3012 --[[ copy: 14 -> 197 ]];
--							l_v3005_0 = v0.task.spawn(function()
--								local v3029 = false;
--								while true do
--									if l_l_On_204_2 ~= nil and l_l_On_204_2.Parent ~= nil and l_l_HumanoidRootPart_2_1 ~= nil and l_l_HumanoidRootPart_2_1.Parent ~= nil then
--										l_l_On_204_2:PivotTo(l_l_HumanoidRootPart_2_1.CFrame * l_v3000_1);
--										v3029 = true;
--									end;
--									if not v3029 then
--										if l_v3012_1 ~= nil and l_v3012_1.Parent ~= nil then
--											break;
--										end;
--									end;
--									v3029 = false;
--									v0.task.wait();
--								end;
--								l_v3012_1:Destroy();
--							end);
--						end;
--						local v3030 = l_Assets_0.Particles.MartialArtist.LigerBomb.HitImpact:Clone();
--						v3030.CFrame = l_HumanoidRootPart_2.CFrame * v3000 * v0.CFrame.Angles(-v0.math.pi / 3.5, v0.math.pi, 0);
--						v3030.Parent = l_VFX_0;
--						local v3031 = VFXService.FindGroundPosition(v3030.Position, 15);
--						if v3031 then
--							local v3032 = v0.ColorSequence.new(v3031.Instance.Color);
--							for _, v3034 in v0.pairs(v3030:GetDescendants()) do
--								if v3034:IsA("ParticleEmitter") and v3034.Name == "Smoke" then
--									v3034.Color = v3032;
--								end;
--							end;
--						end;
--						if (v3030.Position - l_HumanoidRootPart_0.Position).Magnitude <= 20 then
--							VFXService.ShakeCamera(0.05, 0.275, 29, 0.335, 0.335, 0.335);
--						end;
--						v104.PlaySoundInInstance(l_On_204.HumanoidRootPart, "LigerBombHitImpact");
--						v104.PlaySoundInInstance(l_HumanoidRootPart_2, "LigerBombHitImpactLanded");
--						VFXService.EmitParticlesInInstance(v3030);
--						VFXService.DestroyParticleContainer(v3030, 3.5);
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "EndLigerBombGrab" then
--			local l_On_205 = v724.On;
--			if not (l_On_205 ~= nil) or l_On_205.Parent == nil then
--				return;
--			else
--				local v3036 = v0.tostring(v724.Tag);
--				VFXService.DestroyBind(l_On_205, "LigerBombCarryReplication" .. v3036);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzStartupSound" then
--			local l_On_206 = v724.On;
--			if not (l_On_206 ~= nil) or l_On_206.Parent == nil then
--				return;
--			else
--				local v3038 = v104.PlaySoundInInstance(l_On_206.HumanoidRootPart, "DragonBlitzStartup");
--				local v3039 = l_TweenService_0:Create(v3038, v0.TweenInfo.new(0.2, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--					Volume = 0
--				});
--				local l_v3038_0 = v3038 --[[ copy: 3 -> 190 ]];
--				local l_v3039_0 = v3039 --[[ copy: 4 -> 191 ]];
--				local v3042 = VFXService.CreateBind(l_On_206, "DragonBlitzStartupSound", function()
--					if l_v3038_0 ~= nil and l_v3038_0.Parent ~= nil then
--						l_v3039_0:Play();
--					end;
--				end);
--				v3039.Completed:Connect(function()
--					if l_v3038_0 ~= nil and l_v3038_0.Parent ~= nil then
--						l_v3038_0:Destroy();
--					end;
--				end);
--				local l_v3042_0 = v3042 --[[ copy: 5 -> 192 ]];
--				v3038.Ended:Connect(function()
--					if l_v3042_0 ~= nil and l_v3042_0.Parent ~= nil then
--						l_v3042_0:Destroy();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndDragonBlitzStartupSound" then
--			local l_On_207 = v724.On;
--			if not (l_On_207 ~= nil) or l_On_207.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_207, "DragonBlitzStartupSound");
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzUserSound" then
--			local l_On_208 = v724.On;
--			if not (l_On_208 ~= nil) or l_On_208.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_208.HumanoidRootPart, "DragonBlitzUser");
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzVictimSound" then
--			local l_On_209 = v724.On;
--			if not (l_On_209 ~= nil) or l_On_209.Parent == nil then
--				return;
--			else
--				local v3047 = v104.PlaySoundInInstance(l_On_209.HumanoidRootPart, "DragonBlitzVictim");
--				local v3048 = l_TweenService_0:Create(v3047, v0.TweenInfo.new(0.2, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--					Volume = 0
--				});
--				local l_v3047_0 = v3047 --[[ copy: 3 -> 187 ]];
--				v3048.Completed:Connect(function()
--					if l_v3047_0 ~= nil and l_v3047_0.Parent ~= nil then
--						l_v3047_0:Destroy();
--					end;
--				end);
--				local l_v3048_0 = v3048 --[[ copy: 4 -> 188 ]];
--				local v3051 = VFXService.CreateBind(l_On_209, "DragonBlitzVictimSound", function()
--					if l_v3047_0 ~= nil and l_v3047_0.Parent ~= nil then
--						l_v3047_0:SetAttribute("DefaultVolume", nil);
--						l_v3048_0:Play();
--					end;
--				end);
--				local l_v3051_0 = v3051 --[[ copy: 5 -> 189 ]];
--				v3047.Ended:Connect(function()
--					if l_v3051_0 ~= nil and l_v3051_0.Parent ~= nil then
--						l_v3051_0:Destroy();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndDragonBlitzVictimSound" then
--			local l_On_210 = v724.On;
--			if not (l_On_210 ~= nil) or l_On_210.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_210, "DragonBlitzVictimSound");
--			end;
--		end;
--		if l_Request_1 == "RagingFangsHit" then
--			local l_On_211 = v724.On;
--			if not (l_On_211 ~= nil) or l_On_211.Parent == nil then
--				return;
--			else
--				local v3055 = v0.CFrame.new(l_On_211.HumanoidRootPart.Position) * v0.CFrame.Angles(0, v0.math.rad(v0.math.random(0, 360)), 0);
--				local v3056 = workspace:Raycast(v3055.Position + v0.Vector3.new(0, 1.5, 0), v0.Vector3.new(0, -5, 0), v72);
--				if v3056 then
--					local v3057 = {};
--					local v3058 = {};
--					VFXService.GetCircularRocksProperties(v3057, v3055, {
--						5, 
--						6.5
--					}, 8, {
--						2, 
--						2.5
--					}, {
--						2, 
--						2.5
--					}, {
--						1.5, 
--						2.5
--					}, {
--						-3.5, 
--						3.5
--					}, {
--						-3.5, 
--						3.5
--					}, {
--						-3.5, 
--						3.5
--					}, {
--						"Rise", 
--						"Sink"
--					}, 5, false, {
--						IncludeDuplicate = true
--					}, 15);
--					VFXService.GetFlyingRocksProperties(v3058, v3055, 3, {
--						5, 
--						27
--					}, {
--						62, 
--						62
--					}, {
--						5, 
--						27
--					}, 0.8, 0.8, 0.8, 5);
--					VFXService.GetFlyingRocksProperties(v3058, v3055, 3, {
--						5, 
--						27
--					}, {
--						62, 
--						62
--					}, {
--						5, 
--						27
--					}, 1.1, 1.1, 1.1, 5);
--					VFXService.GetFlyingRocksProperties(v3058, v3055, 3, {
--						5, 
--						27
--					}, {
--						62, 
--						62
--					}, {
--						5, 
--						27
--					}, 0.55, 0.55, 0.55, 5);
--					VFXService.ApplyCircularRocksProperties(v3057);
--					VFXService.ApplyFlyingRocksProperties(v3058);
--					v104.PlaySoundAtCFrame(v3056.Position, "DownslamConcrete");
--					VFXService.EmitFromCFrame(v0.CFrame.new(v3056.Position), l_Assets_0.Particles.ImpactSmokeSmall:GetChildren(), nil, nil, {
--						13
--					}, v3056.Instance.Color);
--					local v3059 = l_Assets_0.Parts.Ring:Clone();
--					v3059.Size = v0.Vector3.new(0.01, 3.5, 0.01);
--					v3059.CFrame = v0.CFrame.new(v3056.Position);
--					local v3060 = l_TweenService_0:Create(v3059, v0.TweenInfo.new(0.35, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--						Size = v0.Vector3.new(16, 0, 16), 
--						Position = v3059.Position + v0.Vector3.new(0, 2, 0), 
--						Transparency = 1
--					});
--					local l_v3059_0 = v3059 --[[ copy: 7 -> 186 ]];
--					v3060.Completed:Connect(function()
--						if l_v3059_0 ~= nil and l_v3059_0.Parent ~= nil then
--							l_v3059_0:Destroy();
--						end;
--					end);
--					v3059.Parent = l_VFX_0;
--					v3060:Play();
--				else
--					local v3062 = l_Assets_0.Parts.Ring:Clone();
--					v3062.Size = v0.Vector3.new(0.01, 3.5, 0.01);
--					v3062.CFrame = v0.CFrame.new(l_On_211.HumanoidRootPart.Position);
--					local v3063 = l_TweenService_0:Create(v3062, v0.TweenInfo.new(0.35, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--						Size = v0.Vector3.new(16, 0, 16), 
--						Position = v3062.Position + v0.Vector3.new(0, 2, 0), 
--						Transparency = 1
--					});
--					local l_v3062_0 = v3062 --[[ copy: 5 -> 185 ]];
--					v3063.Completed:Connect(function()
--						if l_v3062_0 ~= nil and l_v3062_0.Parent ~= nil then
--							l_v3062_0:Destroy();
--						end;
--					end);
--					v3062.Parent = l_VFX_0;
--					v3063:Play();
--				end;
--			end;
--		end;
--		if l_Request_1 == "DroppingFangDownslam" then
--			local l_On_212 = v724.On;
--			if not (l_On_212 ~= nil) or l_On_212.Parent == nil then
--				return;
--			else
--				local v3066 = v0.CFrame.new(l_On_212.HumanoidRootPart.Position) * v0.CFrame.Angles(0, v0.math.rad(v0.math.random(0, 360)), 0);
--				local v3067 = workspace:Raycast(v3066.Position + v0.Vector3.new(0, 1.5, 0), v0.Vector3.new(0, -5, 0), v72);
--				v104.PlaySoundInInstance(l_On_212.HumanoidRootPart, "M1DownslamHit");
--				if v3067 then
--					local v3068 = {};
--					local v3069 = {};
--					VFXService.GetCircularRocksProperties(v3068, v3066, {
--						5, 
--						6.5
--					}, 8, {
--						2, 
--						2.5
--					}, {
--						2, 
--						2.5
--					}, {
--						1.5, 
--						2.5
--					}, {
--						-3.5, 
--						3.5
--					}, {
--						-3.5, 
--						3.5
--					}, {
--						-3.5, 
--						3.5
--					}, {
--						"Rise", 
--						"Sink"
--					}, 5, false, {
--						IncludeDuplicate = true
--					}, 15);
--					VFXService.GetFlyingRocksProperties(v3069, v3066, 3, {
--						5, 
--						27
--					}, {
--						62, 
--						62
--					}, {
--						5, 
--						27
--					}, 0.8, 0.8, 0.8, 5);
--					VFXService.GetFlyingRocksProperties(v3069, v3066, 3, {
--						5, 
--						27
--					}, {
--						62, 
--						62
--					}, {
--						5, 
--						27
--					}, 1.1, 1.1, 1.1, 5);
--					VFXService.GetFlyingRocksProperties(v3069, v3066, 3, {
--						5, 
--						27
--					}, {
--						62, 
--						62
--					}, {
--						5, 
--						27
--					}, 0.55, 0.55, 0.55, 5);
--					VFXService.ApplyCircularRocksProperties(v3068);
--					VFXService.ApplyFlyingRocksProperties(v3069);
--					v104.PlaySoundAtCFrame(v3067.Position, "DownslamConcrete");
--					VFXService.EmitFromCFrame(v0.CFrame.new(v3067.Position), l_Assets_0.Particles.ImpactSmokeSmall:GetChildren(), nil, nil, {
--						13
--					}, v3067.Instance.Color);
--					local v3070 = l_Assets_0.Parts.Ring:Clone();
--					v3070.Size = v0.Vector3.new(0.01, 3.5, 0.01);
--					v3070.CFrame = v0.CFrame.new(v3067.Position);
--					local v3071 = l_TweenService_0:Create(v3070, v0.TweenInfo.new(0.35, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--						Size = v0.Vector3.new(16, 0, 16), 
--						Position = v3070.Position + v0.Vector3.new(0, 2, 0), 
--						Transparency = 1
--					});
--					local l_v3070_0 = v3070 --[[ copy: 7 -> 184 ]];
--					v3071.Completed:Connect(function()
--						if l_v3070_0 ~= nil and l_v3070_0.Parent ~= nil then
--							l_v3070_0:Destroy();
--						end;
--					end);
--					v3070.Parent = l_VFX_0;
--					v3071:Play();
--				else
--					local v3073 = l_Assets_0.Parts.Ring:Clone();
--					v3073.Size = v0.Vector3.new(0.01, 3.5, 0.01);
--					v3073.CFrame = v0.CFrame.new(l_On_212.HumanoidRootPart.Position);
--					local v3074 = l_TweenService_0:Create(v3073, v0.TweenInfo.new(0.35, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--						Size = v0.Vector3.new(16, 0, 16), 
--						Position = v3073.Position + v0.Vector3.new(0, 2, 0), 
--						Transparency = 1
--					});
--					local l_v3073_0 = v3073 --[[ copy: 5 -> 183 ]];
--					v3074.Completed:Connect(function()
--						if l_v3073_0 ~= nil and l_v3073_0.Parent ~= nil then
--							l_v3073_0:Destroy();
--						end;
--					end);
--					v3073.Parent = l_VFX_0;
--					v3074:Play();
--				end;
--			end;
--		end;
--		if l_Request_1 == "AerialAxeKickSlam" then
--			local v3076 = v724.At + v724.At.LookVector;
--			local v3077 = {};
--			local v3078 = {};
--			local v3079 = VFXService.GetRandomAngle();
--			local v3080 = VFXService.FindGroundPosition(v3076.Position + v0.Vector3.new(0, 3, 0), 15);
--			local v3081 = VFXService.GetTile(v3076.Position + v0.Vector3.new(0, 1, 0));
--			VFXService.GetCircularRocksProperties(v3077, v3076 * v0.CFrame.Angles(0, v3079, 0), {
--				30, 
--				38
--			}, 6, {
--				23, 
--				30
--			}, {
--				5, 
--				7
--			}, {
--				5, 
--				7
--			}, {
--				0, 
--				0
--			}, {
--				0, 
--				0
--			}, {
--				0, 
--				0
--			}, {
--				"Grow", 
--				"Shrink", 
--				nil, 
--				4
--			}, 5, false, {
--				IncludeDuplicate = true
--			}, nil, {
--				-3, 
--				3
--			}, {
--				0.05, 
--				0.075
--			}, {
--				4, 
--				9
--			});
--			VFXService.GetCircularRocksProperties(v3077, v3076 * v0.CFrame.Angles(0, v3079 + v0.math.pi / 4, 0), {
--				30, 
--				38
--			}, 6, {
--				23, 
--				30
--			}, {
--				7, 
--				9
--			}, {
--				7, 
--				9
--			}, {
--				0, 
--				0
--			}, {
--				0, 
--				0
--			}, {
--				0, 
--				0
--			}, {
--				"Grow", 
--				"Shrink", 
--				nil, 
--				4
--			}, 5, false, {
--				IncludeDuplicate = false
--			}, nil, {
--				-3, 
--				3
--			}, {
--				0.05, 
--				0.075
--			}, {
--				-7.5, 
--				6.5
--			});
--			VFXService.GetCircularRocksProperties(v3077, v3076 * v0.CFrame.Angles(0, v3079, 0), {
--				20, 
--				32
--			}, 6, {
--				13, 
--				17
--			}, {
--				3, 
--				5
--			}, {
--				3, 
--				5
--			}, {
--				0, 
--				0
--			}, {
--				0, 
--				0
--			}, {
--				0, 
--				0
--			}, {
--				"Grow", 
--				"Shrink", 
--				nil, 
--				4
--			}, 5, false, {
--				IncludeDuplicate = true
--			}, nil, {
--				-3, 
--				3
--			}, {
--				0.05, 
--				0.075
--			}, {
--				2, 
--				5
--			});
--			VFXService.GetCircularRocksProperties(v3077, v3076 * v0.CFrame.Angles(0, v3079, 0), {
--				20, 
--				32
--			}, 6, {
--				13, 
--				17
--			}, {
--				3, 
--				5
--			}, {
--				3, 
--				5
--			}, {
--				0, 
--				0
--			}, {
--				0, 
--				0
--			}, {
--				0, 
--				0
--			}, {
--				"Grow", 
--				"Shrink", 
--				nil, 
--				4
--			}, 5, false, {
--				IncludeDuplicate = true
--			}, nil, {
--				-3, 
--				3
--			}, {
--				0.05, 
--				0.075
--			}, {
--				-5, 
--				5
--			});
--			VFXService.GetCircularRocksProperties(v3077, v3076 * v0.CFrame.Angles(0, v3079, 0), {
--				15, 
--				21
--			}, 5, {
--				9, 
--				11.5
--			}, {
--				2, 
--				2.25
--			}, {
--				2, 
--				2.25
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				"Grow", 
--				"Shrink", 
--				nil, 
--				4
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetCircularRocksProperties(v3077, v3076 * v0.CFrame.Angles(0, v3079 + v0.math.pi / 4, 0), {
--				15, 
--				21
--			}, 5, {
--				11, 
--				13.5
--			}, {
--				2, 
--				3
--			}, {
--				2, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				"Grow", 
--				"Shrink", 
--				nil, 
--				4
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetFlyingRocksProperties(v3078, v3076, v0.math.random(5, 6), {
--				5, 
--				120
--			}, {
--				115, 
--				115
--			}, {
--				5, 
--				120
--			}, 3, 3, 3, 3);
--			VFXService.GetFlyingRocksProperties(v3078, v3076, v0.math.random(3, 4), {
--				5, 
--				120
--			}, {
--				115, 
--				115
--			}, {
--				5, 
--				120
--			}, 4, 4, 4, 3);
--			VFXService.GetFlyingRocksProperties(v3078, v3076, v0.math.random(4, 5), {
--				5, 
--				120
--			}, {
--				115, 
--				115
--			}, {
--				5, 
--				120
--			}, 2, 2, 2, 3);
--			VFXService.GetFlyingRocksProperties(v3078, v3076, v0.math.random(4, 6), {
--				5, 
--				120
--			}, {
--				115, 
--				115
--			}, {
--				5, 
--				120
--			}, 4, 4, 4, 3);
--			VFXService.ApplyCircularRocksProperties(v3077);
--			VFXService.ApplyFlyingRocksProperties(v3078);
--			VFXService.DestroyTile(v3081);
--			v104.PlaySoundAtCFrame(v3076, "DroppingFangImpact");
--			if v3080 then
--				local v3082 = l_Assets_0.Particles.MartialArtist.DroppingFang.Slam:Clone();
--				v3082.Position = v3080.Position + v0.Vector3.new(0, v3082.Size.Y / 2, 0);
--				v3082.Parent = l_VFX_0;
--				for _, v3084 in v0.pairs(v3082:GetDescendants()) do
--					if v3084:IsA("ParticleEmitter") and v3084.Name == "Smoke" then
--						v3084.Color = v0.ColorSequence.new(VFXService.MakeDarker(v3080.Instance.Color, 5, 5, 5));
--					end;
--				end;
--				VFXService.EmitParticlesInInstance(v3082);
--				VFXService.DestroyParticleContainer(v3082, 4);
--			end;
--			if (v3076.Position - l_HumanoidRootPart_0.Position).Magnitude <= 60 then
--				VFXService.ShakeCamera(0, 0.55, 49, 0.9, 0.9, 0.56);
--			end;
--		end;
--		if l_Request_1 == "AerialAxeKickJump" then
--			local l_On_213 = v724.On;
--			if not (l_On_213 ~= nil) or l_On_213.Parent == nil then
--				return;
--			else
--				local l_FinalCFrame_0 = v724.FinalCFrame;
--				local v3087 = v0.Instance.new("CFrameValue");
--				local l_LookVector_9 = l_FinalCFrame_0.LookVector;
--				local l_CFrame_43 = l_On_213.HumanoidRootPart.CFrame;
--				local l_Magnitude_2 = (l_CFrame_43.Position - l_HumanoidRootPart_0.Position).Magnitude;
--				v3087.Value = v0.CFrame.new(l_CFrame_43.Position, l_CFrame_43.Position + l_LookVector_9);
--				local v3091 = l_Bezier_0.new(l_CFrame_43.Position);
--				local l_Magnitude_3 = (l_CFrame_43.Position - l_FinalCFrame_0.Position).Magnitude;
--				v3091:AddBezierPoint(l_CFrame_43.Position + l_LookVector_9 * (l_Magnitude_3 / 1.75) + v0.Vector3.new(0, 100, 0));
--				v3091:AddBezierPoint(l_FinalCFrame_0.Position);
--				local l_v3091_CFrameTween_0 = v3091:CreateCFrameTween(v3087, {
--					"Value"
--				}, v0.TweenInfo.new(1.1, v0.Enum.EasingStyle.Linear, v0.Enum.EasingDirection.In), nil, l_LookVector_9);
--				local v3094 = nil;
--				local l_l_On_213_0 = l_On_213 --[[ copy: 2 -> 181 ]];
--				local l_v3087_0 = v3087 --[[ copy: 4 -> 182 ]];
--				v3094 = v0.task.spawn(function()
--					while l_l_On_213_0 ~= nil and l_l_On_213_0.Parent ~= nil do
--						l_l_On_213_0:PivotTo(l_v3087_0.Value);
--						v0.task.wait();
--					end;
--					v0.pcall(function()
--						l_v3087_0:Destroy();
--					end);
--				end);
--				do
--					local l_v3094_0 = v3094;
--					l_v3091_CFrameTween_0.Completed:Connect(function()
--						v0.pcall(function()
--							v0.task.cancel(l_v3094_0);
--						end);
--						v0.pcall(function()
--							l_v3087_0:Destroy();
--						end);
--					end);
--					l_v3091_CFrameTween_0:Play();
--					local v3098 = VFXService.FindGroundPosition(l_CFrame_43.Position + v0.Vector3.new(0, 3, 0), 15);
--					if v3098 then
--						local v3099 = l_Assets_0.Particles.MartialArtist.DroppingFang.JumpGround:Clone();
--						v3099.Position = v3098.Position;
--						v3099.Parent = l_VFX_0;
--						for _, v3101 in v0.pairs(v3099:GetDescendants()) do
--							if v3101:IsA("ParticleEmitter") and v3101.Name == "Smoke" then
--								v3101.Color = v0.ColorSequence.new(VFXService.MakeDarker(v3098.Instance.Color, 5, 5, 5));
--							end;
--						end;
--						VFXService.EmitParticlesInInstance(v3099);
--						VFXService.DestroyParticleContainer(v3099, 4);
--					end;
--					local v3102 = l_Assets_0.Particles.MartialArtist.DroppingFang.Jump:Clone();
--					v3102.CFrame = v0.CFrame.new(l_CFrame_43.Position + v0.Vector3.new(0, 2, 0), v3091:GetPoint(2)) * v0.CFrame.Angles(-v0.math.pi / 2, 0, 0);
--					v3102.Parent = l_VFX_0;
--					VFXService.EmitParticlesInInstance(v3102);
--					VFXService.DestroyParticleContainer(v3102, 4);
--					local v3103 = {};
--					local v3104 = {};
--					local v3105 = VFXService.GetRandomAngle();
--					local v3106 = VFXService.GetTile(l_CFrame_43.Position + v0.Vector3.new(0, 3, 0));
--					VFXService.GetCircularRocksProperties(v3103, l_CFrame_43 * v0.CFrame.Angles(0, v3105, 0), {
--						13, 
--						19
--					}, v0.math.random(4, 5), {
--						8, 
--						11
--					}, {
--						4, 
--						5
--					}, {
--						4, 
--						5
--					}, {
--						-1, 
--						1
--					}, {
--						-1, 
--						1
--					}, {
--						-1, 
--						1
--					}, {
--						"Grow", 
--						"Sink"
--					}, 5, false, {
--						IncludeDuplicate = false
--					}, nil, {
--						-1, 
--						1
--					}, {
--						0, 
--						0
--					}, {
--						0, 
--						0
--					});
--					VFXService.GetCircularRocksProperties(v3103, l_CFrame_43 * v0.CFrame.Angles(0, v3105 + v0.math.pi / 2, 0), {
--						15, 
--						19
--					}, v0.math.random(4, 5), {
--						5, 
--						8
--					}, {
--						2, 
--						5
--					}, {
--						2, 
--						5
--					}, {
--						-1, 
--						1
--					}, {
--						-1, 
--						1
--					}, {
--						-1, 
--						1
--					}, {
--						"Grow", 
--						"Sink"
--					}, 5, false, {
--						IncludeDuplicate = false
--					}, nil, {
--						-0.5, 
--						0.5
--					}, {
--						0, 
--						0
--					}, {
--						0, 
--						0
--					});
--					VFXService.GetCircularRocksProperties(v3103, l_CFrame_43 * v0.CFrame.Angles(0, v3105 + v0.math.pi / 8, 0), {
--						13, 
--						24
--					}, 7, {
--						5, 
--						8
--					}, {
--						3.5, 
--						6
--					}, {
--						3.5, 
--						6
--					}, {
--						-1, 
--						1
--					}, {
--						-1, 
--						1
--					}, {
--						-1, 
--						1
--					}, {
--						"Grow", 
--						"Sink"
--					}, 5, false, {
--						IncludeDuplicate = true
--					}, nil, {
--						-1, 
--						1
--					}, {
--						0, 
--						0
--					}, {
--						0, 
--						0
--					});
--					VFXService.GetFlyingRocksProperties(v3104, l_CFrame_43, 4, {
--						8, 
--						49
--					}, {
--						92, 
--						92
--					}, {
--						8, 
--						49
--					}, 2.5, 2.5, 2.5, 5);
--					VFXService.GetFlyingRocksProperties(v3104, l_CFrame_43, 3, {
--						8, 
--						49
--					}, {
--						92, 
--						92
--					}, {
--						8, 
--						49
--					}, 1.3, 1.3, 1.1, 5);
--					VFXService.GetFlyingRocksProperties(v3104, l_CFrame_43, 5, {
--						8, 
--						49
--					}, {
--						92, 
--						92
--					}, {
--						8, 
--						49
--					}, 1, 1, 1, 5);
--					VFXService.ApplyCircularRocksProperties(v3103);
--					VFXService.ApplyFlyingRocksProperties(v3104);
--					VFXService.DestroyTile(v3106);
--					v104.PlaySoundAtCFrame(l_CFrame_43, "DroppingFangJump");
--					if l_Magnitude_2 <= 15 then
--						VFXService.ShakeCamera(0, 0.5, 26, 0.3, 0.3, 0.3);
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzTeleportCrater" then
--			local l_At_3 = v724.At;
--			local v3108 = {};
--			local v3109 = {};
--			local v3110 = VFXService.FindGroundPosition(l_At_3.Position, 15);
--			local v3111 = VFXService.GetTile(l_At_3.Position);
--			VFXService.GetCircularRocksProperties(v3108, l_At_3, {
--				4, 
--				6
--			}, 4, {
--				3.5, 
--				4.5
--			}, {
--				1.25, 
--				1.5
--			}, {
--				1.25, 
--				1.5
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				"Grow", 
--				"Sink"
--			}, 4, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetFlyingRocksProperties(v3109, l_At_3, v0.math.random(4, 5), {
--				10, 
--				20
--			}, {
--				40, 
--				60
--			}, {
--				10, 
--				20
--			}, 1, 1, 1);
--			VFXService.GetFlyingRocksProperties(v3109, l_At_3, v0.math.random(2, 3), {
--				10, 
--				20
--			}, {
--				40, 
--				60
--			}, {
--				10, 
--				20
--			}, 1.5, 1.5, 1.5);
--			VFXService.ApplyCircularRocksProperties(v3108);
--			VFXService.ApplyFlyingRocksProperties(v3109);
--			local v3112 = nil;
--			if v3110 then
--				v3112 = v3110.Instance.Color;
--				v104.PlaySoundAtCFrame(v3110.Position, "DragonBlitzTeleportCrater");
--			end;
--			VFXService.DestroyTile(v3111);
--			VFXService.EmitFromCFrame(l_At_3, l_Assets_0.Particles.ImpactSmokeSmall:GetChildren(), 5, true, {
--				20
--			}, v3112);
--			v104.PlaySoundAtCFrame(l_At_3, "DragonBlitzTeleport");
--		end;
--		if l_Request_1 == "DragonBlitzTeleport" then
--			local l_On_214 = v724.On;
--			if not (l_On_214 ~= nil) or l_On_214.Parent == nil then
--				return;
--			else
--				local v3114 = l_Assets_0.Particles.MartialArtist.DragonBlitz.Teleport:Clone();
--				v3114.CFrame = l_On_214.HumanoidRootPart.CFrame + l_On_214.HumanoidRootPart.CFrame.LookVector * 1.5;
--				local v3115 = VFXService.FindGroundPosition(v3114.Position, 8);
--				if v3115 then
--					local v3116 = v0.ColorSequence.new(VFXService.MakeDarker(v3115.Instance.Color, -15, -15, -15));
--					for _, v3118 in v0.pairs(v3114:GetDescendants()) do
--						if v3118:IsA("ParticleEmitter") and v3118.Name == "Smoke" then
--							v3118.Color = v3116;
--						end;
--					end;
--				end;
--				v3114.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3114);
--				VFXService.DestroyParticleContainer(v3114, 1.75);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzElbowHit" then
--			local l_On_215 = v724.On;
--			if not (l_On_215 ~= nil) or l_On_215.Parent == nil then
--				return;
--			else
--				local v3120 = l_Assets_0.Particles.MartialArtist.DragonBlitz.Hit:Clone();
--				v3120.Position = l_On_215.HumanoidRootPart.Position;
--				v3120.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3120);
--				VFXService.DestroyParticleContainer(v3120, 1.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit1" then
--			local l_On_216 = v724.On;
--			if not (l_On_216 ~= nil) or l_On_216.Parent == nil then
--				return;
--			else
--				local v3122 = l_Assets_0.Particles.MartialArtist.DragonBlitz.Hit:Clone();
--				v3122.CFrame = l_On_216.HumanoidRootPart.CFrame * v0.CFrame.new(2.59300041, 0.213000059, -2.68099976, 1, 0, 0, 0, 1, 0, 0, 0, 1);
--				v3122.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3122);
--				VFXService.DestroyParticleContainer(v3122, 1.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit2" then
--			local l_On_217 = v724.On;
--			if not (l_On_217 ~= nil) or l_On_217.Parent == nil then
--				return;
--			else
--				local v3124 = l_Assets_0.Particles.MartialArtist.DragonBlitz.Hit:Clone();
--				v3124.CFrame = l_On_217.HumanoidRootPart.CFrame * v0.CFrame.new(0.670000076, 0.0799999237, -4.0739994, 1, 0, 0, 0, 1, 0, 0, 0, 1);
--				v3124.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3124);
--				VFXService.DestroyParticleContainer(v3124, 1.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit3" then
--			local l_On_218 = v724.On;
--			if not (l_On_218 ~= nil) or l_On_218.Parent == nil then
--				return;
--			else
--				local v3126 = l_Assets_0.Particles.MartialArtist.DragonBlitz.Uppercut:Clone();
--				v3126.CFrame = l_On_218.HumanoidRootPart.CFrame * v0.CFrame.new(-0.874000549, 0.0799999237, -3.40299988, 1, 0, 0, 0, 1, 0, 0, 0, 1);
--				v3126.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3126);
--				VFXService.DestroyParticleContainer(v3126, 1.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit4" then
--			local l_On_219 = v724.On;
--			if not (l_On_219 ~= nil) or l_On_219.Parent == nil then
--				return;
--			else
--				local v3128 = l_Assets_0.Particles.MartialArtist.DragonBlitz.Hit:Clone();
--				v3128.CFrame = l_On_219.HumanoidRootPart.CFrame * v0.CFrame.new(-0.697999954, 1.83500004, -3.40800095, 1, 0, 0, 0, 1, 0, 0, 0, 1);
--				v3128.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3128);
--				VFXService.DestroyParticleContainer(v3128, 1.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit5" then
--			local l_On_220 = v724.On;
--			if not (l_On_220 ~= nil) or l_On_220.Parent == nil then
--				return;
--			else
--				local v3130 = l_Assets_0.Particles.MartialArtist.DragonBlitz.Hit:Clone();
--				v3130.CFrame = l_On_220.HumanoidRootPart.CFrame * v0.CFrame.new(1.52899933, 1.0250001, -2.20700073, 1, 0, 0, 0, 1, 0, 0, 0, 1);
--				v3130.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3130);
--				VFXService.DestroyParticleContainer(v3130, 1.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit6" then
--			local l_On_221 = v724.On;
--			if not (l_On_221 ~= nil) or l_On_221.Parent == nil then
--				return;
--			else
--				local v3132 = l_Assets_0.Particles.MartialArtist.DragonBlitz.Hit:Clone();
--				v3132.CFrame = l_On_221.HumanoidRootPart.CFrame * v0.CFrame.new(-1.63299942, 1.0250001, -4.41399956, 1, 0, 0, 0, 1, 0, 0, 0, 1);
--				v3132.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3132);
--				VFXService.DestroyParticleContainer(v3132, 1.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit7" then
--			local l_On_222 = v724.On;
--			if not (l_On_222 ~= nil) or l_On_222.Parent == nil then
--				return;
--			else
--				local v3134 = l_Assets_0.Particles.MartialArtist.DragonBlitz.Hit:Clone();
--				v3134.CFrame = l_On_222.HumanoidRootPart.CFrame * v0.CFrame.new(1.08099937, 0.115999937, -3.32299995, 1, 0, 0, 0, 1, 0, 0, 0, 1);
--				v3134.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3134);
--				VFXService.DestroyParticleContainer(v3134, 1.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit8" then
--			local l_On_223 = v724.On;
--			if not (l_On_223 ~= nil) or l_On_223.Parent == nil then
--				return;
--			else
--				local v3136 = l_Assets_0.Particles.MartialArtist.DragonBlitz.Hit:Clone();
--				v3136.CFrame = l_On_223.HumanoidRootPart.CFrame * v0.CFrame.new(0.75, 0.819000006, -3.69300079, 1, 0, 0, 0, 1, 0, 0, 0, 1);
--				v3136.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3136);
--				VFXService.DestroyParticleContainer(v3136, 1.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit9" then
--			local l_On_224 = v724.On;
--			if not (l_On_224 ~= nil) or l_On_224.Parent == nil then
--				return;
--			else
--				local v3138 = l_Assets_0.Particles.MartialArtist.DragonBlitz.Hit:Clone();
--				v3138.CFrame = l_On_224.HumanoidRootPart.CFrame * v0.CFrame.new(1.38199997, 0.819000006, -3.69300079, 1, 0, 0, 0, 1, 0, 0, 0, 1);
--				v3138.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3138);
--				VFXService.DestroyParticleContainer(v3138, 1.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit10" then
--			local l_On_225 = v724.On;
--			if not (l_On_225 ~= nil) or l_On_225.Parent == nil then
--				return;
--			else
--				local v3140 = l_Assets_0.Particles.MartialArtist.DragonBlitz.Hit:Clone();
--				v3140.CFrame = l_On_225.HumanoidRootPart.CFrame * v0.CFrame.new(0.0659999847, 0.187000036, -3.36800003, 0.819152057, 0, -0.57357645, 0, 1, 0, 0.57357645, 0, 0.819152057);
--				v3140.Parent = l_VFX_0;
--				local v3141 = l_Assets_0.Particles.MartialArtist.DragonBlitz.DashHit:Clone();
--				v3141.CFrame = l_On_225.HumanoidRootPart.CFrame * v0.CFrame.new();
--				v3141.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3140);
--				VFXService.EmitParticlesInInstance(v3141);
--				VFXService.DestroyParticleContainer(v3140, 1.5);
--				VFXService.DestroyParticleContainer(v3141, 3.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit11" then
--			local l_On_226 = v724.On;
--			if not (l_On_226 ~= nil) or l_On_226.Parent == nil then
--				return;
--			else
--				local v3143 = l_Assets_0.Particles.MartialArtist.DragonBlitz.DashHit:Clone();
--				v3143.CFrame = l_On_226.HumanoidRootPart.CFrame * v0.CFrame.new(1.18899918, 0.187000036, -2.58200073, -0.727772713, -6.36239079E-8, 0.685818374, -1.47378927E-7, 1, -6.36239079E-8, -0.685818374, -1.47378927E-7, -0.727772713);
--				v3143.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3143);
--				VFXService.DestroyParticleContainer(v3143, 3.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit12" then
--			local l_On_227 = v724.On;
--			if not (l_On_227 ~= nil) or l_On_227.Parent == nil then
--				return;
--			else
--				local v3145 = l_Assets_0.Particles.MartialArtist.DragonBlitz.DashHit:Clone();
--				v3145.CFrame = l_On_227.HumanoidRootPart.CFrame * v0.CFrame.new(-1.37199974, 0.187000036, -4.99499989, 0.869080842, 0, -0.494670123, 0, 1, 0, 0.494670123, 0, 0.869080842);
--				v3145.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3145);
--				VFXService.DestroyParticleContainer(v3145, 3.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit13" then
--			local l_On_228 = v724.On;
--			if not (l_On_228 ~= nil) or l_On_228.Parent == nil then
--				return;
--			else
--				local v3147 = l_Assets_0.Particles.MartialArtist.DragonBlitz.DashHit:Clone();
--				v3147.CFrame = l_On_228.HumanoidRootPart.CFrame * v0.CFrame.new(-1.37199974, 0.187000036, -4.99499989, 0.348571986, 0, -0.937282026, 0, 1, 0, 0.937282026, 0, 0.348571986);
--				v3147.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3147);
--				VFXService.DestroyParticleContainer(v3147, 3.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit14" then
--			local l_On_229 = v724.On;
--			if not (l_On_229 ~= nil) or l_On_229.Parent == nil then
--				return;
--			else
--				local v3149 = l_Assets_0.Particles.MartialArtist.DragonBlitz.DashHit:Clone();
--				v3149.CFrame = l_On_229.HumanoidRootPart.CFrame * v0.CFrame.new(-0.395000458, 0.187000036, -2.36899948, 0.845796466, 0.0184553452, 0.533186376, 5.02541661E-6, 0.999401152, -0.0346005522, -0.533505678, 0.0292677041, 0.845289946);
--				v3149.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3149);
--				VFXService.DestroyParticleContainer(v3149, 3.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit15" then
--			local l_On_230 = v724.On;
--			if not (l_On_230 ~= nil) or l_On_230.Parent == nil then
--				return;
--			else
--				local v3151 = l_Assets_0.Particles.MartialArtist.DragonBlitz.DashHit:Clone();
--				v3151.CFrame = l_On_230.HumanoidRootPart.CFrame * v0.CFrame.new(2.55699921, 0.187000036, -4.23200035, -0.979302883, 0.0184615795, 0.201556608, 0.0239733569, 0.99940151, 0.0249391422, -0.200975567, 0.0292549636, -0.979159355);
--				v3151.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3151);
--				VFXService.DestroyParticleContainer(v3151, 3.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit16" then
--			local l_On_231 = v724.On;
--			if not (l_On_231 ~= nil) or l_On_231.Parent == nil then
--				return;
--			else
--				local v3153 = l_Assets_0.Particles.MartialArtist.DragonBlitz.DashHit:Clone();
--				v3153.CFrame = l_On_231.HumanoidRootPart.CFrame * v0.CFrame.new(-1.09399986, 0.27699995, -4.98099995, 0.617638648, 0.0184605606, -0.786245286, -0.0344152115, 0.999401212, -0.00356969703, 0.785708606, 0.0292635802, 0.617904186);
--				v3153.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3153);
--				VFXService.DestroyParticleContainer(v3153, 3.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit17" then
--			local l_On_232 = v724.On;
--			if not (l_On_232 ~= nil) or l_On_232.Parent == nil then
--				return;
--			else
--				local v3155 = l_Assets_0.Particles.MartialArtist.DragonBlitz.DashHit:Clone();
--				v3155.CFrame = l_On_232.HumanoidRootPart.CFrame * v0.CFrame.new(0.871999741, 0.167000055, -2.47999954, -0.691846669, 0.0184550267, 0.721808553, 0.0338927768, 0.999401391, 0.00693345023, -0.721248507, 0.0292609781, -0.692058027);
--				v3155.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3155);
--				VFXService.DestroyParticleContainer(v3155, 3.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit18" then
--			local l_On_233 = v724.On;
--			if not (l_On_233 ~= nil) or l_On_233.Parent == nil then
--				return;
--			else
--				local v3157 = l_Assets_0.Particles.MartialArtist.DragonBlitz.DashHit:Clone();
--				v3157.CFrame = l_On_233.HumanoidRootPart.CFrame * v0.CFrame.new(-0.621999741, 0.24000001, -4.03700066, 0.994020939, 0.0184613932, -0.107617624, -0.0214972124, 0.999401093, -0.0271177031, 0.107052535, 0.0292690434, 0.993822455);
--				v3157.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3157);
--				VFXService.DestroyParticleContainer(v3157, 3.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit19" then
--			local l_On_234 = v724.On;
--			if not (l_On_234 ~= nil) or l_On_234.Parent == nil then
--				return;
--			else
--				local v3159 = l_Assets_0.Particles.MartialArtist.DragonBlitz.DashHit:Clone();
--				v3159.CFrame = l_On_234.HumanoidRootPart.CFrame * v0.CFrame.new(3.02799988, 0.102999926, -1.65399933, -0.750829935, 0.0184547547, 0.66023767, 0.0331746973, 0.999401569, 0.00979169551, -0.659661829, 0.0292550847, -0.750992894);
--				v3159.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3159);
--				VFXService.DestroyParticleContainer(v3159, 3.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit20" then
--			local l_On_235 = v724.On;
--			if not (l_On_235 ~= nil) or l_On_235.Parent == nil then
--				return;
--			else
--				local v3161 = l_Assets_0.Particles.MartialArtist.DragonBlitz.DashHit:Clone();
--				v3161.CFrame = l_On_235.HumanoidRootPart.CFrame * v0.CFrame.new(-0.608999252, 0.263999939, -4.84899998, -0.22707513, 0.0184575059, -0.973702312, -0.0243048593, 0.999401569, 0.024612749, 0.973573864, 0.0292546451, -0.226490632);
--				v3161.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3161);
--				VFXService.DestroyParticleContainer(v3161, 3.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit21" then
--			local l_On_236 = v724.On;
--			if not (l_On_236 ~= nil) or l_On_236.Parent == nil then
--				return;
--			else
--				local v3163 = l_Assets_0.Particles.MartialArtist.DragonBlitz.DashHit:Clone();
--				v3163.CFrame = l_On_236.HumanoidRootPart.CFrame * v0.CFrame.new(-1.34499931, 0.184999943, -1.6970005, 0.824689984, 0.0184556209, 0.565283775, 0.0013318155, 0.999401331, -0.0345718488, -0.565583408, 0.0292639136, 0.824171722);
--				v3163.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3163);
--				VFXService.DestroyParticleContainer(v3163, 3.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit22" then
--			local l_On_237 = v724.On;
--			if not (l_On_237 ~= nil) or l_On_237.Parent == nil then
--				return;
--			else
--				local v3165 = l_Assets_0.Particles.MartialArtist.DragonBlitz.DashHit:Clone();
--				v3165.CFrame = l_On_237.HumanoidRootPart.CFrame * v0.CFrame.new(3.25499916, 0.193000078, -4.85099983, -0.998232007, 0.0184524972, 0.0565011092, 0.0200687535, 0.999401569, 0.0281731728, -0.0559474304, 0.0292572696, -0.998004973);
--				v3165.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3165);
--				VFXService.DestroyParticleContainer(v3165, 3.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit23" then
--			local l_On_238 = v724.On;
--			if not (l_On_238 ~= nil) or l_On_238.Parent == nil then
--				return;
--			else
--				local v3167 = l_Assets_0.Particles.MartialArtist.DragonBlitz.Hit:Clone();
--				v3167.Position = l_On_238.Torso.Position;
--				v3167.Parent = l_VFX_0;
--				local v3168 = l_Assets_0.Particles.MartialArtist.DragonBlitz.DashHit:Clone();
--				v3168.CFrame = l_On_238.HumanoidRootPart.CFrame * v0.CFrame.new(-1.06200027, 0.279000044, -5.09300041, 0.441652775, 0.0184566844, -0.8969962, -0.0344005823, 0.99940151, 0.00362602016, 0.896526337, 0.0292557515, 0.442023396);
--				v3168.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3168);
--				VFXService.DestroyParticleContainer(v3168, 3.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit24" then
--			local l_On_239 = v724.On;
--			if not (l_On_239 ~= nil) or l_On_239.Parent == nil then
--				return;
--			else
--				local v3170 = l_Assets_0.Particles.MartialArtist.DragonBlitz.DashHit:Clone();
--				v3170.CFrame = l_On_239.HumanoidRootPart.CFrame * v0.CFrame.new(0.659999847, 0.160000086, -2.12000084, -0.590148211, 0.0184532963, 0.807084024, 0.0345057994, 0.999401689, 0.0023805215, -0.806557178, 0.029253941, -0.590431869);
--				v3170.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3170);
--				VFXService.DestroyParticleContainer(v3170, 3.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit25" then
--			local l_On_240 = v724.On;
--			if not (l_On_240 ~= nil) or l_On_240.Parent == nil then
--				return;
--			else
--				local v3172 = l_Assets_0.Particles.MartialArtist.DragonBlitz.DashHit:Clone();
--				v3172.CFrame = l_On_240.HumanoidRootPart.CFrame * v0.CFrame.new(-2.08699989, 0.269999981, -4.13800049, 0.998696089, 0.0184610393, -0.0475945957, -0.0198256411, 0.999401093, -0.028360514, 0.04704253, 0.0292671286, 0.998464048);
--				v3172.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3172);
--				VFXService.DestroyParticleContainer(v3172, 3.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit26" then
--			local l_On_241 = v724.On;
--			if not (l_On_241 ~= nil) or l_On_241.Parent == nil then
--				return;
--			else
--				local v3174 = l_Assets_0.Particles.MartialArtist.DragonBlitz.DashHit:Clone();
--				v3174.CFrame = l_On_241.HumanoidRootPart.CFrame * v0.CFrame.new(2.37100029, 0.144999981, -2.68600082, -0.702121675, 0.0184592437, 0.711817682, 0.0337936282, 0.999401331, 0.00741628977, -0.711254656, 0.0292620398, -0.702325106);
--				v3174.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3174);
--				VFXService.DestroyParticleContainer(v3174, 3.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit27" then
--			local l_On_242 = v724.On;
--			if not (l_On_242 ~= nil) or l_On_242.Parent == nil then
--				return;
--			else
--				local v3176 = l_Assets_0.Particles.MartialArtist.DragonBlitz.DashHit:Clone();
--				v3176.CFrame = l_On_242.HumanoidRootPart.CFrame * v0.CFrame.new(-0.670000076, 0.292000055, -5.7670002, -0.538219154, 0.0184564721, -0.842602789, -0.0147308931, 0.99940145, 0.0313004851, 0.842676103, 0.0292588156, -0.537625134);
--				v3176.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3176);
--				VFXService.DestroyParticleContainer(v3176, 3.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit28" then
--			local l_On_243 = v724.On;
--			if not (l_On_243 ~= nil) or l_On_243.Parent == nil then
--				return;
--			else
--				local v3178 = l_Assets_0.Particles.MartialArtist.DragonBlitz.DashHit:Clone();
--				v3178.CFrame = l_On_243.HumanoidRootPart.CFrame * v0.CFrame.new(-1.77000046, 0.220999956, -2.65500069, 0.863330245, 0.0184610579, 0.504301608, -0.00117156841, 0.999401271, -0.0345796123, -0.504638076, 0.0292628035, 0.86283499);
--				v3178.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3178);
--				VFXService.DestroyParticleContainer(v3178, 3.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit29" then
--			local l_On_244 = v724.On;
--			if not (l_On_244 ~= nil) or l_On_244.Parent == nil then
--				return;
--			else
--				local v3180 = l_Assets_0.Particles.MartialArtist.DragonBlitz.DashHit:Clone();
--				v3180.CFrame = l_On_244.HumanoidRootPart.CFrame * v0.CFrame.new(2.47800064, 0.214999914, -5.13799953, -0.975179315, 0.0184519906, -0.220646366, 0.0115318429, 0.999401569, 0.0326102488, 0.221116066, 0.0292563792, -0.974808574);
--				v3180.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3180);
--				VFXService.DestroyParticleContainer(v3180, 3.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit30" then
--			local l_On_245 = v724.On;
--			if not (l_On_245 ~= nil) or l_On_245.Parent == nil then
--				return;
--			else
--				local v3182 = l_Assets_0.Particles.MartialArtist.DragonBlitz.DashHit:Clone();
--				v3182.CFrame = l_On_245.HumanoidRootPart.CFrame * v0.CFrame.new(-2.37800026, 0.27699995, -4.18899918, 0.928444862, 0.0184592661, -0.371011287, -0.02799109, 0.999401569, -0.0203227345, 0.370414108, 0.0292535499, 0.928405941);
--				v3182.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3182);
--				VFXService.DestroyParticleContainer(v3182, 3.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzHit31" then
--			local l_On_246 = v724.On;
--			if not (l_On_246 ~= nil) or l_On_246.Parent == nil then
--				return;
--			else
--				local v3184 = l_Assets_0.Particles.MartialArtist.DragonBlitz.DashHit:Clone();
--				v3184.CFrame = l_On_246.HumanoidRootPart.CFrame * v0.CFrame.new(-2.37800026, 0.27699995, -4.18899918, 0.686116099, 0.0184579026, -0.727257848, -0.0339456834, 0.99940145, -0.00666039623, 0.72669965, 0.0292570703, 0.686332047);
--				v3184.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3184);
--				VFXService.DestroyParticleContainer(v3184, 3.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzTrail" then
--			local l_On_247 = v724.On;
--			if not (l_On_247 ~= nil) or l_On_247.Parent == nil then
--				return;
--			else
--				local v3186 = l_Assets_0.Particles.MartialArtist.DragonBlitz.LegTrail.BodyTrail:Clone();
--				v3186.Parent = l_On_247["Right Leg"];
--				local v3187 = l_Assets_0.Particles.MartialArtist.DragonBlitz.LegTrail.BodyTrail:Clone();
--				v3187.Parent = l_On_247["Left Leg"];
--				local l_v3186_0 = v3186 --[[ copy: 3 -> 179 ]];
--				local l_v3187_0 = v3187 --[[ copy: 4 -> 180 ]];
--				VFXService.CreateBind(l_On_247, "DragonBlitzLegTrailEffect", function()
--					if l_v3186_0 ~= nil and l_v3186_0.Parent ~= nil then
--						for _, v3191 in v0.pairs(l_v3186_0:GetDescendants()) do
--							if v3191:IsA("Trail") then
--								v3191.Enabled = false;
--							end;
--						end;
--						v0.task.delay(1, function()
--							if l_v3186_0 ~= nil and l_v3186_0.Parent ~= nil then
--								l_v3186_0:Destroy();
--							end;
--						end);
--					end;
--					if l_v3187_0 ~= nil and l_v3187_0.Parent ~= nil then
--						for _, v3193 in v0.pairs(l_v3187_0:GetDescendants()) do
--							if v3193:IsA("Trail") then
--								v3193.Enabled = false;
--							end;
--						end;
--						v0.task.delay(1, function()
--							if l_v3187_0 ~= nil and l_v3187_0.Parent ~= nil then
--								l_v3187_0:Destroy();
--							end;
--						end);
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndDragonBlitzTrail" then
--			local l_On_248 = v724.On;
--			if not (l_On_248 ~= nil) or l_On_248.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_248, "DragonBlitzLegTrailEffect");
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzUppercut" then
--			local l_On_249 = v724.On;
--			if not (l_On_249 ~= nil) or l_On_249.Parent == nil then
--				return;
--			else
--				local v3196 = l_Assets_0.Particles.MartialArtist.DragonBlitz.MainUppercut:Clone();
--				v3196.CFrame = l_On_249.HumanoidRootPart.CFrame * v0.CFrame.new(0.0580005646, 2.32999992, -4.9989996, 1, 0, 0, 0, 1, 0, 0, 0, 1);
--				v3196.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3196);
--				VFXService.DestroyParticleContainer(v3196, 3.5);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzContact" then
--			local l_On_250 = v724.On;
--			if not (l_On_250 ~= nil) or l_On_250.Parent == nil then
--				return;
--			else
--				local l_CFrame_44 = l_On_250.HumanoidRootPart.CFrame;
--				local v3199 = {};
--				VFXService.GetCircularRocksProperties(v3199, (l_CFrame_44 + l_CFrame_44.LookVector * 6) * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--					7, 
--					12.5
--				}, 8, {
--					4, 
--					5
--				}, {
--					1.25, 
--					1.55
--				}, {
--					1.25, 
--					1.55
--				}, {
--					-3, 
--					3
--				}, {
--					-3, 
--					3
--				}, {
--					-3, 
--					3
--				}, {
--					"Grow", 
--					"Sink"
--				}, 5.5, false, {
--					IncludeDuplicate = true
--				});
--				VFXService.GetCircularRocksProperties(v3199, (l_CFrame_44 + l_CFrame_44.LookVector * 6) * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--					7, 
--					12.5
--				}, 8, {
--					3, 
--					4
--				}, {
--					1.15, 
--					1.3
--				}, {
--					1.15, 
--					1.3
--				}, {
--					-3, 
--					3
--				}, {
--					-3, 
--					3
--				}, {
--					-3, 
--					3
--				}, {
--					"Grow", 
--					"Sink"
--				}, 5.5, false, {
--					IncludeDuplicate = true
--				});
--				local v3200 = l_Assets_0.Particles.MartialArtist.DragonBlitz.Contact:Clone();
--				v3200.CFrame = l_CFrame_44 * v0.CFrame.new(-0.0767326355, 0.82085371, -6.89037132, 1, 0, 0, 0, 0.984808028, -0.173648238, 0, 0.173648238, 0.984808028);
--				v3200.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3200);
--				VFXService.DestroyParticleContainer(v3200, 1.5);
--				VFXService.ApplyCircularRocksProperties(v3199);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzFinalKick" then
--			local l_On_251 = v724.On;
--			if not (l_On_251 ~= nil) or l_On_251.Parent == nil then
--				return;
--			else
--				local l_CFrame_45 = l_On_251.HumanoidRootPart.CFrame;
--				local v3203 = {};
--				VFXService.GetCircularRocksProperties(v3203, (l_CFrame_45 + l_CFrame_45.LookVector * 6) * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--					11, 
--					23
--				}, v0.math.random(4, 5), {
--					11, 
--					16
--				}, {
--					2, 
--					3
--				}, {
--					2, 
--					3
--				}, {
--					-5, 
--					5
--				}, {
--					-3, 
--					3
--				}, {
--					-5, 
--					5
--				}, {
--					"Grow", 
--					"Sink"
--				}, 5, false, {
--					IncludeDuplicate = true
--				});
--				VFXService.GetCircularRocksProperties(v3203, (l_CFrame_45 + l_CFrame_45.LookVector * 6) * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--					16, 
--					24
--				}, 11, {
--					6, 
--					8
--				}, {
--					2, 
--					3
--				}, {
--					2, 
--					3
--				}, {
--					-3, 
--					3
--				}, {
--					-3, 
--					3
--				}, {
--					-3, 
--					3
--				}, {
--					"Grow", 
--					"Sink"
--				}, 5, false, {
--					IncludeDuplicate = true
--				});
--				local v3204 = l_Assets_0.Particles.MartialArtist.DragonBlitz.FinalKick:Clone();
--				v3204.CFrame = l_CFrame_45 * v0.CFrame.new(-0.0767326355, 0.82085371, -6.89037132, 1, 0, 0, 0, 0.984808028, -0.173648238, 0, 0.173648238, 0.984808028);
--				v3204.Parent = l_VFX_0;
--				local l_CFrame_46 = l_HumanoidRootPart_0.CFrame;
--				VFXService.EmitParticlesInInstance(v3204);
--				VFXService.DestroyParticleContainer(v3204, 1.5);
--				VFXService.ApplyCircularRocksProperties(v3203);
--				v104.PlaySoundAtCFrame(l_CFrame_46, "DragonBlitzFinalKick");
--			end;
--		end;
--		if l_Request_1 == "EndDragonBlitzCameraVictim" then
--			VFXService.EndCutscene();
--			VFXService.ShakeCamera(0.07, 0.6, 27, 0.6, 0.6, 0.6);
--		end;
--		if l_Request_1 == "EndDragonBlitzCamera" then
--			v0.task.wait(0.37);
--			VFXService.EndCutscene();
--			VFXService.ShakeCamera(0.07, 0.6, 27, 0.6, 0.6, 0.6);
--		end;
--		if l_Request_1 == "DragonBlitzHitEnvironment" then
--			local l_On_252 = v724.On;
--			if not (l_On_252 ~= nil) or l_On_252.Parent == nil then
--				return;
--			else
--				local l_S_2 = v724.S;
--				local v3208 = v0.RaycastParams.new();
--				v3208.FilterDescendantsInstances = {
--					l_Map_0
--				};
--				v3208.FilterType = v0.Enum.RaycastFilterType.Include;
--				local v3209 = nil;
--				local l_l_On_252_0 = l_On_252 --[[ copy: 2 -> 176 ]];
--				local l_v3208_0 = v3208 --[[ copy: 4 -> 177 ]];
--				local l_l_S_2_0 = l_S_2 --[[ copy: 3 -> 178 ]];
--				do
--					local l_v3209_0 = v3209;
--					l_v3209_0 = v0.task.spawn(function()
--						local v3214 = 0;
--						while true do
--							if v3214 < 0.4 then
--								v3214 = v3214 + v0.task.wait();
--								continue;
--							end;
--							if l_l_On_252_0 ~= nil and l_l_On_252_0.Parent ~= nil and l_l_On_252_0.HumanoidRootPart.Ragdoll_RootJoint.Enabled == true then
--								local l_AssemblyLinearVelocity_0 = l_l_On_252_0.HumanoidRootPart.AssemblyLinearVelocity;
--								local v3216 = v0.Vector3.new(v0.math.clamp(l_AssemblyLinearVelocity_0.X, -5.3, 5.3), v0.math.clamp(l_AssemblyLinearVelocity_0.Y, -5.3, 5.3), v0.math.clamp(l_AssemblyLinearVelocity_0.Z, -5.3, 5.3));
--								local l_Position_18 = l_l_On_252_0.HumanoidRootPart.Position;
--								local v3218 = workspace:Raycast(l_Position_18, v3216, l_v3208_0);
--								if v3218 then
--									local l_Position_19 = v3218.Position;
--									local v3220 = VFXService.GetTile(l_Position_19 + v0.Vector3.new(0, 0.5, 0));
--									VFXService.DestroyTile(v3220);
--									if not (l_l_S_2_0 ~= true) or l_l_On_252_0 ~= nil and l_l_On_252_0.Parent ~= nil and v26 == l_l_On_252_0 then
--										VFXService.ShakeCamera(0.05, 0.6, 25, 0.4, 0.4, 0.4);
--										v104.PlaySound("OneInchPunchBodyImpact");
--									else
--										v104.PlaySoundAtCFrame(v0.CFrame.new(l_Position_19), "OneInchPunchBodyImpact");
--									end;
--									VFXService.EmitFromCFrame(v0.CFrame.new(l_Position_19), l_Assets_0.Particles.ImpactSmokeBig:GetChildren(), 3, nil, {
--										30
--									}, v3218.Instance.Color);
--									local v3221 = {};
--									if v3218.Instance:IsDescendantOf(l_Borders_0) then
--										local v3222 = v0.CFrame.new(v3218.Position, v3218.Position + v3218.Normal) * v0.CFrame.Angles(-v0.math.pi / 2, 0, 0);
--										VFXService.GetCircularWallRocksProperties(v3221, v3222, {
--											4, 
--											9
--										}, v0.math.random(6, 8), {
--											2, 
--											4.5
--										}, {
--											0.65, 
--											1
--										}, {
--											1, 
--											1.5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											"Grow", 
--											"Shrink"
--										}, 5, false, {
--											IncludeDuplicate = true
--										});
--										VFXService.GetCircularWallRocksProperties(v3221, v3222 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--											4, 
--											9
--										}, v0.math.random(6, 8), {
--											3, 
--											4
--										}, {
--											1, 
--											1.5
--										}, {
--											1.75, 
--											2.25
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											"Grow", 
--											"Shrink"
--										}, 5, false, {
--											IncludeDuplicate = true
--										});
--										VFXService.GetCircularWallRocksProperties(v3221, v3222 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--											2.5, 
--											5
--										}, 5, {
--											2.5, 
--											3
--										}, {
--											0.7, 
--											1
--										}, {
--											0.7, 
--											1
--										}, {
--											-2, 
--											2
--										}, {
--											-2, 
--											2
--										}, {
--											-2, 
--											2
--										}, {
--											"Grow", 
--											"Shrink"
--										}, 5, false, {
--											IncludeDuplicate = true, 
--											RadiusOffset = 0.15
--										});
--										VFXService.GetCircularWallRocksProperties(v3221, v3222, {
--											10, 
--											15
--										}, v0.math.random(8, 9), {
--											7, 
--											10.5
--										}, {
--											2, 
--											2.25
--										}, {
--											2, 
--											2.25
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											"Grow", 
--											"Shrink"
--										}, 5, false, {
--											IncludeDuplicate = true
--										});
--									else
--										local v3223 = v0.CFrame.new(l_Position_19);
--										VFXService.GetCircularRocksProperties(v3221, v3223, {
--											4, 
--											9
--										}, v0.math.random(6, 8), {
--											2, 
--											4.5
--										}, {
--											0.65, 
--											1
--										}, {
--											1, 
--											1.5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											"Grow", 
--											"Sink"
--										}, 5, false, {
--											IncludeDuplicate = true
--										});
--										VFXService.GetCircularRocksProperties(v3221, v3223 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--											4, 
--											9
--										}, v0.math.random(6, 8), {
--											3, 
--											4
--										}, {
--											1, 
--											1.5
--										}, {
--											1.75, 
--											2.25
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											"Grow", 
--											"Sink"
--										}, 5, false, {
--											IncludeDuplicate = true
--										});
--										VFXService.GetCircularRocksProperties(v3221, v3223 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--											2.5, 
--											5
--										}, 5, {
--											2.5, 
--											3
--										}, {
--											0.7, 
--											1
--										}, {
--											0.7, 
--											1
--										}, {
--											-2, 
--											2
--										}, {
--											-2, 
--											2
--										}, {
--											-2, 
--											2
--										}, {
--											"Grow", 
--											"Sink"
--										}, 5, false, {
--											IncludeDuplicate = true, 
--											RadiusOffset = 0.15
--										});
--										VFXService.GetCircularRocksProperties(v3221, v3223, {
--											10, 
--											15
--										}, v0.math.random(5, 6), {
--											5, 
--											8.5
--										}, {
--											1.5, 
--											1.75
--										}, {
--											1.5, 
--											1.75
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											"Grow", 
--											"Sink"
--										}, 5, false, {
--											IncludeDuplicate = true, 
--											RadiusOffset = 2
--										});
--										VFXService.GetCircularRocksProperties(v3221, v3223, {
--											10, 
--											15
--										}, v0.math.random(8, 9), {
--											7, 
--											10.5
--										}, {
--											2, 
--											2.25
--										}, {
--											2, 
--											2.25
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											-5, 
--											5
--										}, {
--											"Grow", 
--											"Sink"
--										}, 5, false, {
--											IncludeDuplicate = true
--										});
--									end;
--									VFXService.ApplyCircularRocksProperties(v3221);
--									break;
--								else
--									v0.task.wait();
--								end;
--							else
--								break;
--							end;
--						end;
--						l_v3209_0 = nil;
--					end);
--					v0.task.delay(6, function()
--						v0.pcall(function()
--							v0.task.cancel(l_v3209_0);
--						end);
--						l_v3209_0 = nil;
--					end);
--				end;
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzOpaque" then
--			local l_On_253 = v724.On;
--			if not (l_On_253 ~= nil) or l_On_253.Parent == nil then
--				return;
--			else
--				local l_Tag_0 = v724.Tag;
--				local v3226 = l_TweenService_0:Create(l_On_253.Torso, v0.TweenInfo.new(0.3, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--					Transparency = 0.7
--				});
--				v3226:Play();
--				local v3227 = l_Assets_0.Parts.MartialArtist.DragonBlitz.Ribcage:Clone();
--				v3227.Name = "RibcageAnimationPreload";
--				v3227.Ribcage.Anchored = true;
--				v3227.Ribcage.CastShadow = false;
--				v3227.Ribcage.Transparency = 0;
--				v3227.Parent = l_VFX_0;
--				local v3228 = v0.Instance.new("Animation");
--				v3228.AnimationId = "rbxassetid://135128214128381";
--				local v3229 = v3227.AnimationController:LoadAnimation(v3228);
--				v3228:Destroy();
--				local l_v3227_0 = v3227 --[[ copy: 5 -> 171 ]];
--				v3229.Stopped:Connect(function()
--					if l_v3227_0 ~= nil and l_v3227_0.Parent ~= nil then
--						l_v3227_0:Destroy();
--					end;
--				end);
--				v3229:Play();
--				v3229:AdjustSpeed(1.06);
--				local v3231 = l_Assets_0.Parts.MartialArtist.DragonBlitz.Ribcage:Clone();
--				v3231.Name = "DragonBlitzRibcage" .. l_Tag_0;
--				local v3232 = v0.Instance.new("Weld");
--				v3232.Parent = v3231;
--				v3232.Part0 = l_On_253.Torso;
--				v3232.Part1 = v3231.Ribcage;
--				v3232.C0 = v3232.C0 * v0.CFrame.Angles(0, -v0.math.pi / 2, 0);
--				v3231.Ribcage.Transparency = 1;
--				v3231.Parent = l_VFX_0;
--				local v3233 = l_TweenService_0:Create(v3231.Ribcage, v0.TweenInfo.new(0.3, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--					Transparency = 0.5
--				});
--				v3233:Play();
--				local l_v3226_0 = v3226 --[[ copy: 4 -> 172 ]];
--				local l_v3233_0 = v3233 --[[ copy: 10 -> 173 ]];
--				local l_l_On_253_0 = l_On_253 --[[ copy: 2 -> 174 ]];
--				local l_v3231_0 = v3231 --[[ copy: 8 -> 175 ]];
--				VFXService.CreateBind(l_On_253, "DragonBlitzOpaqueTorsoEffect", function()
--					if l_v3226_0 ~= nil then
--						l_v3226_0:Cancel();
--					end;
--					if l_v3233_0 ~= nil then
--						l_v3233_0:Cancel();
--					end;
--					if l_l_On_253_0 ~= nil and l_l_On_253_0.Parent ~= nil and l_l_On_253_0.Torso ~= nil and l_l_On_253_0.Torso.Parent ~= nil then
--						l_TweenService_0:Create(l_l_On_253_0.Torso, v0.TweenInfo.new(0.25, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--							Transparency = 0
--						}):Play();
--					end;
--					if l_v3231_0 ~= nil and l_v3231_0.Parent ~= nil and l_v3231_0.Ribcage ~= nil and l_v3231_0.Ribcage.Parent ~= nil then
--						local v3238 = l_TweenService_0:Create(l_v3231_0.Ribcage, v0.TweenInfo.new(0.25, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--							Transparency = 1
--						});
--						v3238.Completed:Connect(function()
--							if l_v3231_0 ~= nil and l_v3231_0.Parent ~= nil then
--								l_v3231_0:Destroy();
--							end;
--						end);
--						v3238:Play();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndDragonBlitzOpaque" then
--			local l_On_254 = v724.On;
--			if not (l_On_254 ~= nil) or l_On_254.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_254, "DragonBlitzOpaqueTorsoEffect", true);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzRib" then
--			local l_Tag_1 = v724.Tag;
--			local v3241 = nil;
--			for _, v3243 in v0.pairs(l_VFX_0:GetChildren()) do
--				if v3243:IsA("Model") and v3243.Name == "DragonBlitzRibcage" .. l_Tag_1 then
--					v3241 = v3243;
--					break;
--				end;
--			end;
--			if v3241 ~= nil and v3241.Parent ~= nil and v3241:FindFirstChild("AnimationController") then
--				local v3244 = v0.Instance.new("Animation");
--				v3244.AnimationId = "rbxassetid://135128214128381";
--				local v3245 = v3241.AnimationController:LoadAnimation(v3244);
--				v3244:Destroy();
--				v3245:Play();
--				v3245:AdjustSpeed(1.06);
--			end;
--		end;
--		if l_Request_1 == "DragonBlitzCamera" then
--			local l_Relative_3 = v724.Relative;
--			if not (l_Relative_3 ~= nil) or l_Relative_3.Parent == nil then
--				return;
--			else
--				local v3247, v3248 = VFXService.InitiateCutscene("DragonBlitz", 60, 140038323158495, l_Relative_3, nil, {
--					Time = 0.5, 
--					EasingStyle = v0.Enum.EasingStyle.Exponential, 
--					EasingDirection = v0.Enum.EasingDirection.Out
--				});
--				local v3249 = {
--					17449293131, 
--					17449294539, 
--					17449295629, 
--					17449297204
--				};
--				VFXService.PreloadImages({
--					"rbxassetid://17449293131", 
--					"rbxassetid://17449294539", 
--					"rbxassetid://17449295629", 
--					"rbxassetid://17449297204"
--				}, 15);
--				v3248:GetMarkerReachedSignal("Sound"):Connect(function()
--					v104.PlaySound("DragonBlitzXray");
--				end);
--				local l_v3249_0 = v3249 --[[ copy: 5 -> 169 ]];
--				v3248:GetMarkerReachedSignal("ImpactFrames"):Connect(function()
--					VFXService.ImpactFrameSequence(l_v3249_0);
--				end);
--				local l_v3247_0 = v3247 --[[ copy: 3 -> 170 ]];
--				v0.task.delay(8, function()
--					if l_v3247_0 ~= nil and l_v3247_0.Parent ~= nil then
--						VFXService.CinematicFrame({
--							Visible = false, 
--							ScreenPercentage = 0.1, 
--							SmoothIn = {
--								Time = 1, 
--								EasingStyle = v0.Enum.EasingStyle.Exponential, 
--								EasingDirection = v0.Enum.EasingDirection.Out
--							}, 
--							SmoothOut = {
--								Time = 0.8, 
--								EasingStyle = v0.Enum.EasingStyle.Exponential, 
--								EasingDirection = v0.Enum.EasingDirection.Out
--							}
--						}, {
--							Visible = true, 
--							InitialTransparency = 1, 
--							TargetTransparency = 0
--						}, 1.4);
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "SetCharacterPopper" then
--			local l_On_255 = v724.On;
--			if not (l_On_255 ~= nil) or l_On_255.Parent == nil then
--				return;
--			else
--				l_On_255.Parent = l_FlyingRocksStorage_0;
--			end;
--		end;
--		if l_Request_1 == "NoCharacterPopper" then
--			local l_On_256 = v724.On;
--			if not (l_On_256 ~= nil) or l_On_256.Parent == nil then
--				return;
--			else
--				l_On_256.Parent = l_Characters_0;
--			end;
--		end;
--		if l_Request_1 == "JunWallComboSlam1" then
--			local l_On_257 = v724.On;
--			if not (l_On_257 ~= nil) or l_On_257.Parent == nil then
--				return;
--			else
--				local v3255 = v0.ColorSequence.new(v724.C);
--				local v3256 = l_Assets_0.Particles.Jun.WallCombo.Container.Slam1:Clone();
--				v3256.Parent = l_On_257.HumanoidRootPart;
--				for _, v3258 in v0.pairs(v3256:GetDescendants()) do
--					if v3258:IsA("ParticleEmitter") and v3258.Name == "Smoke" then
--						v3258.Color = v3255;
--					end;
--				end;
--				if (l_On_257.HumanoidRootPart.Position - l_HumanoidRootPart_0.Position).Magnitude <= 14 then
--					VFXService.ShakeCamera(0, 0.4, 17, 0.25, 0.35, 0.25);
--				end;
--				VFXService.EmitParticlesInInstance(v3256);
--				VFXService.DestroyParticleContainer(v3256, 4);
--			end;
--		end;
--		if l_Request_1 == "JunWallComboSlam2" then
--			local l_On_258 = v724.On;
--			if not (l_On_258 ~= nil) or l_On_258.Parent == nil then
--				return;
--			else
--				local v3260 = v0.ColorSequence.new(v724.C);
--				local v3261 = l_Assets_0.Particles.Jun.WallCombo.Container.Slam2:Clone();
--				v3261.Parent = l_On_258.HumanoidRootPart;
--				for _, v3263 in v0.pairs(v3261:GetDescendants()) do
--					if v3263:IsA("ParticleEmitter") and v3263.Name == "Smoke" then
--						v3263.Color = v3260;
--					end;
--				end;
--				if (l_On_258.HumanoidRootPart.Position - l_HumanoidRootPart_0.Position).Magnitude <= 14 then
--					VFXService.ShakeCamera(0, 0.4, 17, 0.25, 0.35, 0.25);
--				end;
--				VFXService.EmitParticlesInInstance(v3261);
--				VFXService.DestroyParticleContainer(v3261, 4);
--			end;
--		end;
--		if l_Request_1 == "JunWallComboSlash" then
--			local l_On_259 = v724.On;
--			if not (l_On_259 ~= nil) or l_On_259.Parent == nil then
--				return;
--			else
--				local v3265 = v0.ColorSequence.new(v724.C);
--				local v3266 = l_Assets_0.Particles.Jun.WallCombo.Container.Slash:Clone();
--				v3266.Parent = l_On_259.HumanoidRootPart;
--				for _, v3268 in v0.pairs(v3266:GetDescendants()) do
--					if v3268:IsA("ParticleEmitter") and v3268.Name == "Smoke" then
--						v3268.Color = v3265;
--					end;
--				end;
--				if v88.Blood == false then
--					for _, v3270 in v0.pairs(v3266:GetDescendants()) do
--						if v3270:IsA("ParticleEmitter") and v3270.Name == "Blood" then
--							v3270:Destroy();
--						end;
--					end;
--				end;
--				if (l_On_259.HumanoidRootPart.Position - l_HumanoidRootPart_0.Position).Magnitude <= 14 then
--					VFXService.ShakeCamera(0, 0.4, 31, 0.28, 0.53, 0.28);
--				end;
--				VFXService.EmitParticlesInInstance(v3266);
--				VFXService.DestroyParticleContainer(v3266, 4);
--			end;
--		end;
--		if l_Request_1 == "MartialArtistWallComboFinalHit" then
--			local l_On_260 = v724.On;
--			if not (l_On_260 ~= nil) or l_On_260.Parent == nil then
--				return;
--			else
--				local v3272 = l_On_260.HumanoidRootPart.CFrame - l_On_260.HumanoidRootPart.CFrame.LookVector;
--				local l_Children_4 = l_Assets_0.Particles.MartialArtist.WallCombo.FinalHit:GetChildren();
--				VFXService.EmitFromCFrame(v3272, l_Children_4, 2);
--				if (v3272.Position - l_HumanoidRootPart_0.Position).Magnitude <= 10 then
--					VFXService.ShakeCamera(0, 0.4, 25, 0.25, 0.5, 0.25);
--				end;
--			end;
--		end;
--		if l_Request_1 == "MartialArtistWallComboHit" then
--			local l_On_261 = v724.On;
--			if not (l_On_261 ~= nil) or l_On_261.Parent == nil then
--				return;
--			else
--				local l_CFrame_47 = l_On_261.HumanoidRootPart.CFrame;
--				local l_Children_5 = l_Assets_0.Particles.MartialArtist.WallCombo.Hit:GetChildren();
--				VFXService.EmitFromCFrame(l_CFrame_47, l_Children_5, 2);
--				if (l_CFrame_47.Position - l_HumanoidRootPart_0.Position).Magnitude <= 10 then
--					VFXService.ShakeCamera(0, 0.175, 15, 0.2, 0.5, 0.2);
--				end;
--			end;
--		end;
--		if l_Request_1 == "MartialArtistWallComboSound" then
--			local l_On_262 = v724.On;
--			if not (l_On_262 ~= nil) or l_On_262.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_262.HumanoidRootPart, "MartialArtistWallCombo");
--			end;
--		end;
--		if l_Request_1 == "JunWallComboUserSound" then
--			local l_On_263 = v724.On;
--			if not (l_On_263 ~= nil) or l_On_263.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_263.HumanoidRootPart, "JunWallComboUser");
--				v104.PlaySoundInInstance(l_On_263.HumanoidRootPart, "JunWallComboUserVoice");
--			end;
--		end;
--		if l_Request_1 == "JunWallComboVictimSound" then
--			local l_On_264 = v724.On;
--			if not (l_On_264 ~= nil) or l_On_264.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_264.HumanoidRootPart, "JunWallComboVictim");
--			end;
--		end;
--		if l_Request_1 == "RollEffects" then
--			local l_On_265 = v724.On;
--			if not (l_On_265 ~= nil) or l_On_265.Parent == nil then
--				return;
--			else
--				local v3281 = nil;
--				local v3282 = v0.Vector3.new(0, -5, 0);
--				local v3283 = nil;
--				if v724.SoundName == nil then
--					v3283 = v104.PlaySoundInInstance(l_On_265.HumanoidRootPart, "GroundRoll");
--				elseif typeof(v724.SoundName) == "string" then
--					v3283 = v104.PlaySoundInInstance(l_On_265.HumanoidRootPart, v724.SoundName);
--				end;
--				local v3284 = l_TweenService_0:Create(v3283, v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Quad, v0.Enum.EasingDirection.Out), {
--					Volume = 0
--				});
--				do
--					local l_v3281_0, l_v3283_0 = v3281, v3283;
--					v3284.Completed:Connect(function()
--						if l_v3283_0 ~= nil and l_v3283_0.Parent ~= nil then
--							l_v3283_0:Destroy();
--						end;
--					end);
--					local l_l_On_265_0 = l_On_265 --[[ copy: 2 -> 166 ]];
--					local l_v3282_0 = v3282 --[[ copy: 4 -> 167 ]];
--					l_v3281_0 = v0.task.spawn(function()
--						local l_Children_6 = l_Assets_0.Particles.Smoke:GetChildren();
--						while l_l_On_265_0 ~= nil and l_l_On_265_0.Parent ~= nil and l_l_On_265_0.HumanoidRootPart ~= nil and l_l_On_265_0.HumanoidRootPart.Parent ~= nil do
--							if l_l_On_265_0.HumanoidRootPart.AssemblyLinearVelocity.Magnitude <= 15 then
--								v0.task.wait();
--							else
--								local l_Position_20 = l_l_On_265_0.HumanoidRootPart.Position;
--								local v3291 = workspace:Raycast(l_Position_20, l_v3282_0, v72);
--								if v3291 then
--									local v3292 = v0.CFrame.new(v3291.Position);
--									local v3293 = v3292 + v0.Vector3.new(0, 0.5, 0);
--									local l_RightVector_2 = l_l_On_265_0.HumanoidRootPart.CFrame.RightVector;
--									v3293 = v0.CFrame.new(v3293.Position, v3293.Position + v0.Vector3.new(l_RightVector_2.X, 0, l_RightVector_2.Z));
--									VFXService.EmitFromCFrame(v3292 - v0.Vector3.new(0, 0.75, 0), l_Children_6, nil, nil, nil, VFXService.MakeDarker(v3291.Instance.Color, -50, -50, -50));
--								end;
--								v0.task.wait(0.0275);
--							end;
--						end;
--						l_Children_6 = nil;
--					end);
--					local l_v3284_0 = v3284 --[[ copy: 6 -> 168 ]];
--					VFXService.CreateBind(l_On_265, "RollEffectsBind", function()
--						v0.pcall(function()
--							v0.task.cancel(l_v3281_0);
--						end);
--						if l_v3283_0 ~= nil and l_v3283_0.Parent ~= nil then
--							l_v3283_0:SetAttribute("DefaultVolume", nil);
--							l_v3284_0:Play();
--						end;
--					end);
--					v0.task.delay(0.8, function()
--						VFXService.DestroyBind(l_l_On_265_0, "RollEffectsBind");
--					end);
--				end;
--			end;
--		end;
--		if l_Request_1 == "EndRollEffects" then
--			local l_On_266 = v724.On;
--			if not (l_On_266 ~= nil) or l_On_266.Parent == nil then
--				return;
--			else
--				VFXService.DestroyAllBinds(l_On_266, "RollEffectsBind");
--			end;
--		end;
--		if l_Request_1 == "OneInchPunchSound" then
--			v104.PlaySound("OneInchPunchInitialHit");
--			v104.PlaySound("OneInchPunchEntirety");
--			local l_On_267 = v724.On;
--			if not (l_On_267 ~= nil) or l_On_267.Parent == nil then
--				return;
--			else
--				local v3298 = l_On_267.HumanoidRootPart.CFrame * v0.CFrame.Angles(0, v0.math.pi, 0);
--				local v3299 = l_Assets_0.Particles.MartialArtist.OneInchPunch.Swing:Clone();
--				v3299.CFrame = v3298;
--				v3299.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3299);
--				VFXService.DestroyParticleContainer(v3299, 3);
--			end;
--		end;
--		if l_Request_1 == "OneInchPunchContactSound" then
--			v104.PlaySound("OneInchPunchContact");
--			local l_On_268 = v724.On;
--			if not (l_On_268 ~= nil) or l_On_268.Parent == nil then
--				return;
--			else
--				local v3301 = l_Assets_0.Particles.MartialArtist.OneInchPunch.Contact:Clone();
--				v3301.CFrame = l_On_268.HumanoidRootPart.CFrame * v0.CFrame.Angles(0, v0.math.pi, 0);
--				v3301.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3301);
--				VFXService.DestroyParticleContainer(v3301, 5);
--			end;
--		end;
--		if l_Request_1 == "OneInchPunchEntiretySound" then
--			local l_On_269 = v724.On;
--			if not (l_On_269 ~= nil) or l_On_269.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_269.HumanoidRootPart, "OneInchPunchEntirety");
--			end;
--		end;
--		if l_Request_1 == "OneInchPunchStart" then
--			local l_On_270 = v724.On;
--			if not (l_On_270 ~= nil) or l_On_270.Parent == nil then
--				return;
--			else
--				local v3304 = l_Assets_0.Particles.MartialArtist.OneInchPunch.StartUp:Clone();
--				local v3305 = VFXService.FindGroundPosition(l_On_270.HumanoidRootPart.Position, 30);
--				if v3305 then
--					v3304.Position = v3305.Position + v0.Vector3.new(0, 1, 0);
--				else
--					v3304.Position = l_On_270.HumanoidRootPart.Position;
--				end;
--				v3304.Parent = l_VFX_0;
--				v104.PlaySoundInInstance(v3304, "OneInchPunchStartup");
--				VFXService.EmitParticlesInInstance(v3304);
--				VFXService.DestroyParticleContainer(v3304, 2);
--			end;
--		end;
--		if l_Request_1 == "OneInchPunchDashEffects" then
--			local l_On_271 = v724.On;
--			if not (l_On_271 ~= nil) or l_On_271.Parent == nil then
--				return;
--			else
--				local v3307 = l_Assets_0.Particles.MartialArtist.OneInchPunch.Dash:Clone();
--				v3307.CFrame = l_On_271.HumanoidRootPart.CFrame * v0.CFrame.Angles(0, v0.math.pi, 0);
--				v3307.Parent = l_VFX_0;
--				v104.PlaySoundInInstance(v3307, "OneInchPunchDash");
--				VFXService.EmitParticlesInInstance(v3307);
--				VFXService.DestroyParticleContainer(v3307, 2);
--			end;
--		end;
--		if l_Request_1 == "OneInchPunchHitEnvironment" then
--			local l_On_272 = v724.On;
--			if not (l_On_272 ~= nil) or l_On_272.Parent == nil then
--				return;
--			else
--				local l_S_3 = v724.S;
--				local v3310 = v0.RaycastParams.new();
--				v3310.FilterDescendantsInstances = {
--					l_Map_0
--				};
--				v3310.FilterType = v0.Enum.RaycastFilterType.Include;
--				local v3311 = nil;
--				local l_l_On_272_0 = l_On_272 --[[ copy: 2 -> 163 ]];
--				local l_v3310_0 = v3310 --[[ copy: 4 -> 164 ]];
--				local l_l_S_3_0 = l_S_3 --[[ copy: 3 -> 165 ]];
--				do
--					local l_v3311_0 = v3311;
--					l_v3311_0 = v0.task.spawn(function()
--						local v3316 = v0.Vector3.new(0, -2.75, 0);
--						local v3317 = 0;
--						while l_l_On_272_0 ~= nil and l_l_On_272_0.Parent ~= nil do
--							local l_AssemblyLinearVelocity_1 = l_l_On_272_0.HumanoidRootPart.AssemblyLinearVelocity;
--							local v3319 = v0.Vector3.new(v0.math.clamp(l_AssemblyLinearVelocity_1.X, -4, 4), v0.math.clamp(l_AssemblyLinearVelocity_1.Y, -2, 2), v0.math.clamp(l_AssemblyLinearVelocity_1.Z, -4, 4));
--							local l_Position_21 = l_l_On_272_0.HumanoidRootPart.Position;
--							local v3321 = workspace:Raycast(l_Position_21, v3319, l_v3310_0);
--							local v3322 = nil;
--							if v3317 >= 0.4 then
--								v3322 = workspace:Raycast(l_Position_21, v3316, l_v3310_0);
--							end;
--							if v3321 then
--								local l_Position_22 = v3321.Position;
--								if not (l_l_S_3_0 ~= true) or l_l_On_272_0 ~= nil and l_l_On_272_0.Parent ~= nil and v26 == l_l_On_272_0 then
--									VFXService.ShakeCamera(0.05, 0.6, 25, 0.4, 0.4, 0.4);
--									v104.PlaySound("OneInchPunchBodyImpact");
--								else
--									v104.PlaySoundAtCFrame(v0.CFrame.new(l_Position_22), "OneInchPunchBodyImpact");
--								end;
--								VFXService.EmitFromCFrame(v0.CFrame.new(l_Position_22), l_Assets_0.Particles.ImpactSmokeBig:GetChildren(), 3, nil, {
--									30
--								}, v3321.Instance.Color);
--								VFXService.EmitFromCFrame(v0.CFrame.new(l_Position_22), l_Assets_0.Particles.Flash:GetChildren(), 1);
--								local v3324 = {};
--								if v3321.Instance:IsDescendantOf(l_Borders_0) then
--									local v3325 = v0.CFrame.new(v3321.Position, v3321.Position + v3321.Normal) * v0.CFrame.Angles(-v0.math.pi / 2, 0, 0);
--									VFXService.GetCircularWallRocksProperties(v3324, v3325, {
--										4, 
--										9
--									}, v0.math.random(6, 8), {
--										2, 
--										4.5
--									}, {
--										0.65, 
--										1
--									}, {
--										1, 
--										1.5
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										"Grow", 
--										"Shrink"
--									}, 5, false, {
--										IncludeDuplicate = true
--									});
--									VFXService.GetCircularWallRocksProperties(v3324, v3325 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--										4, 
--										9
--									}, v0.math.random(6, 8), {
--										3, 
--										4
--									}, {
--										1, 
--										1.5
--									}, {
--										1.75, 
--										2.25
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										"Grow", 
--										"Shrink"
--									}, 5, false, {
--										IncludeDuplicate = true
--									});
--									VFXService.GetCircularWallRocksProperties(v3324, v3325 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--										2.5, 
--										5
--									}, 5, {
--										2.5, 
--										3
--									}, {
--										0.7, 
--										1
--									}, {
--										0.7, 
--										1
--									}, {
--										-2, 
--										2
--									}, {
--										-2, 
--										2
--									}, {
--										-2, 
--										2
--									}, {
--										"Grow", 
--										"Shrink"
--									}, 5, false, {
--										IncludeDuplicate = true, 
--										RadiusOffset = 0.15
--									});
--									VFXService.GetCircularWallRocksProperties(v3324, v3325, {
--										10, 
--										15
--									}, v0.math.random(8, 9), {
--										7, 
--										10.5
--									}, {
--										2, 
--										2.25
--									}, {
--										2, 
--										2.25
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										"Grow", 
--										"Shrink"
--									}, 5, false, {
--										IncludeDuplicate = true
--									});
--								else
--									local v3326 = v0.CFrame.new(l_Position_22);
--									VFXService.GetCircularRocksProperties(v3324, v3326, {
--										4, 
--										9
--									}, v0.math.random(6, 8), {
--										2, 
--										4.5
--									}, {
--										0.65, 
--										1
--									}, {
--										1, 
--										1.5
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										"Grow", 
--										"Sink"
--									}, 5, false, {
--										IncludeDuplicate = true
--									});
--									VFXService.GetCircularRocksProperties(v3324, v3326 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--										4, 
--										9
--									}, v0.math.random(6, 8), {
--										3, 
--										4
--									}, {
--										1, 
--										1.5
--									}, {
--										1.75, 
--										2.25
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										"Grow", 
--										"Sink"
--									}, 5, false, {
--										IncludeDuplicate = true
--									});
--									VFXService.GetCircularRocksProperties(v3324, v3326 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--										2.5, 
--										5
--									}, 5, {
--										2.5, 
--										3
--									}, {
--										0.7, 
--										1
--									}, {
--										0.7, 
--										1
--									}, {
--										-2, 
--										2
--									}, {
--										-2, 
--										2
--									}, {
--										-2, 
--										2
--									}, {
--										"Grow", 
--										"Sink"
--									}, 5, false, {
--										IncludeDuplicate = true, 
--										RadiusOffset = 0.15
--									});
--									VFXService.GetCircularRocksProperties(v3324, v3326, {
--										10, 
--										15
--									}, v0.math.random(5, 6), {
--										5, 
--										8.5
--									}, {
--										1.5, 
--										1.75
--									}, {
--										1.5, 
--										1.75
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										"Grow", 
--										"Sink"
--									}, 5, false, {
--										IncludeDuplicate = true, 
--										RadiusOffset = 2
--									});
--									VFXService.GetCircularRocksProperties(v3324, v3326, {
--										10, 
--										15
--									}, v0.math.random(8, 9), {
--										7, 
--										10.5
--									}, {
--										2, 
--										2.25
--									}, {
--										2, 
--										2.25
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										"Grow", 
--										"Sink"
--									}, 5, false, {
--										IncludeDuplicate = true
--									});
--								end;
--								VFXService.ApplyCircularRocksProperties(v3324);
--								break;
--							elseif v3322 then
--								local l_Position_23 = v3322.Position;
--								if not (l_l_S_3_0 ~= true) or l_l_On_272_0 ~= nil and l_l_On_272_0.Parent ~= nil and v26 == l_l_On_272_0 then
--									VFXService.ShakeCamera(0.05, 0.6, 25, 0.4, 0.4, 0.4);
--									v104.PlaySound("OneInchPunchBodyImpact");
--								else
--									v104.PlaySoundAtCFrame(v0.CFrame.new(l_Position_23), "OneInchPunchBodyImpact");
--								end;
--								VFXService.EmitFromCFrame(v0.CFrame.new(l_Position_23), l_Assets_0.Particles.ImpactSmokeBig:GetChildren(), 3, nil, {
--									30
--								}, v3322.Instance.Color);
--								VFXService.EmitFromCFrame(v0.CFrame.new(l_Position_23), l_Assets_0.Particles.Flash:GetChildren(), 1);
--								local v3328 = {};
--								if v3322.Instance:IsDescendantOf(l_Borders_0) then
--									local v3329 = v0.CFrame.new(v3322.Position, v3322.Position + v3322.Normal) * v0.CFrame.Angles(-v0.math.pi / 2, 0, 0);
--									VFXService.GetCircularWallRocksProperties(v3328, v3329, {
--										4, 
--										9
--									}, v0.math.random(6, 8), {
--										2, 
--										4.5
--									}, {
--										0.65, 
--										1
--									}, {
--										1, 
--										1.5
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										"Grow", 
--										"Shrink"
--									}, 5, false, {
--										IncludeDuplicate = true
--									});
--									VFXService.GetCircularWallRocksProperties(v3328, v3329 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--										4, 
--										9
--									}, v0.math.random(6, 8), {
--										3, 
--										4
--									}, {
--										1, 
--										1.5
--									}, {
--										1.75, 
--										2.25
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										"Grow", 
--										"Shrink"
--									}, 5, false, {
--										IncludeDuplicate = true
--									});
--									VFXService.GetCircularWallRocksProperties(v3328, v3329 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--										2.5, 
--										5
--									}, 5, {
--										2.5, 
--										3
--									}, {
--										0.7, 
--										1
--									}, {
--										0.7, 
--										1
--									}, {
--										-2, 
--										2
--									}, {
--										-2, 
--										2
--									}, {
--										-2, 
--										2
--									}, {
--										"Grow", 
--										"Shrink"
--									}, 5, false, {
--										IncludeDuplicate = true, 
--										RadiusOffset = 0.15
--									});
--									VFXService.GetCircularWallRocksProperties(v3328, v3329, {
--										10, 
--										15
--									}, v0.math.random(8, 9), {
--										7, 
--										10.5
--									}, {
--										2, 
--										2.25
--									}, {
--										2, 
--										2.25
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										"Grow", 
--										"Shrink"
--									}, 5, false, {
--										IncludeDuplicate = true
--									});
--								else
--									local v3330 = v0.CFrame.new(l_Position_23);
--									VFXService.GetCircularRocksProperties(v3328, v3330, {
--										4, 
--										9
--									}, v0.math.random(6, 8), {
--										2, 
--										4.5
--									}, {
--										0.65, 
--										1
--									}, {
--										1, 
--										1.5
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										"Grow", 
--										"Sink"
--									}, 5, false, {
--										IncludeDuplicate = true
--									});
--									VFXService.GetCircularRocksProperties(v3328, v3330 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--										4, 
--										9
--									}, v0.math.random(6, 8), {
--										3, 
--										4
--									}, {
--										1, 
--										1.5
--									}, {
--										1.75, 
--										2.25
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										"Grow", 
--										"Sink"
--									}, 5, false, {
--										IncludeDuplicate = true
--									});
--									VFXService.GetCircularRocksProperties(v3328, v3330 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--										2.5, 
--										5
--									}, 5, {
--										2.5, 
--										3
--									}, {
--										0.7, 
--										1
--									}, {
--										0.7, 
--										1
--									}, {
--										-2, 
--										2
--									}, {
--										-2, 
--										2
--									}, {
--										-2, 
--										2
--									}, {
--										"Grow", 
--										"Sink"
--									}, 5, false, {
--										IncludeDuplicate = true, 
--										RadiusOffset = 0.15
--									});
--									VFXService.GetCircularRocksProperties(v3328, v3330, {
--										10, 
--										15
--									}, v0.math.random(5, 6), {
--										5, 
--										8.5
--									}, {
--										1.5, 
--										1.75
--									}, {
--										1.5, 
--										1.75
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										"Grow", 
--										"Sink"
--									}, 5, false, {
--										IncludeDuplicate = true, 
--										RadiusOffset = 2
--									});
--									VFXService.GetCircularRocksProperties(v3328, v3330, {
--										10, 
--										15
--									}, v0.math.random(8, 9), {
--										7, 
--										10.5
--									}, {
--										2, 
--										2.25
--									}, {
--										2, 
--										2.25
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										-5, 
--										5
--									}, {
--										"Grow", 
--										"Sink"
--									}, 5, false, {
--										IncludeDuplicate = true
--									});
--								end;
--								VFXService.ApplyCircularRocksProperties(v3328);
--								break;
--							else
--								v3317 = v3317 + v0.task.wait();
--							end;
--						end;
--						l_v3311_0 = nil;
--					end);
--					v0.task.delay(3, function()
--						v0.pcall(function()
--							v0.task.cancel(l_v3311_0);
--						end);
--						l_v3311_0 = nil;
--					end);
--				end;
--			end;
--		end;
--		if l_Request_1 == "OneInchPunchSwing" then
--			local l_On_273 = v724.On;
--			if not (l_On_273 ~= nil) or l_On_273.Parent == nil then
--				return;
--			else
--				local v3332 = l_Assets_0.Particles.MartialArtist.OneInchPunch.Swing:Clone();
--				v3332.CFrame = l_On_273.HumanoidRootPart.CFrame + l_On_273.HumanoidRootPart.CFrame.LookVector * 3;
--				v3332.Parent = l_VFX_0;
--				v104.PlaySoundInInstance(v3332, "OneInchPunchMiss");
--				VFXService.EmitParticlesInInstance(v3332);
--				VFXService.DestroyParticleContainer(v3332, 3);
--			end;
--		end;
--		if l_Request_1 == "OneInchPunchInitial" then
--			local l_On_274 = v724.On;
--			if not (l_On_274 ~= nil) or l_On_274.Parent == nil then
--				return;
--			else
--				local v3334 = l_On_274.HumanoidRootPart.CFrame * v0.CFrame.Angles(0, v0.math.pi, 0);
--				local v3335 = l_Assets_0.Particles.MartialArtist.OneInchPunch.Swing:Clone();
--				v3335.CFrame = v3334;
--				v3335.Parent = l_VFX_0;
--				v104.PlaySoundInInstance(v3335, "OneInchPunchInitialHit");
--				VFXService.EmitParticlesInInstance(v3335);
--				VFXService.DestroyParticleContainer(v3335, 3);
--			end;
--		end;
--		if l_Request_1 == "OneInchPunchContact" then
--			local l_On_275 = v724.On;
--			if not (l_On_275 ~= nil) or l_On_275.Parent == nil then
--				return;
--			else
--				local v3337 = l_Assets_0.Particles.MartialArtist.OneInchPunch.Contact:Clone();
--				v3337.CFrame = l_On_275.HumanoidRootPart.CFrame * v0.CFrame.Angles(0, v0.math.pi, 0);
--				v3337.Parent = l_VFX_0;
--				v104.PlaySoundInInstance(l_On_275.HumanoidRootPart, "OneInchPunchContact");
--				VFXService.EmitParticlesInInstance(v3337);
--				VFXService.DestroyParticleContainer(v3337, 5);
--			end;
--		end;
--		if l_Request_1 == "OneInchPunchHit" then
--			local l_On_276 = v724.On;
--			if not (l_On_276 ~= nil) or l_On_276.Parent == nil then
--				return;
--			else
--				local v3339 = l_On_276.HumanoidRootPart.CFrame * v0.CFrame.Angles(0, v0.math.pi, 0);
--				local v3340 = l_Assets_0.Particles.MartialArtist.OneInchPunch.FinalHit:Clone();
--				v3340.CFrame = v3339;
--				v3340.Parent = l_VFX_0;
--				v104.PlaySoundAtCFrame(v3339, "OneInchPunchFinalHit");
--				local v3341 = v0.CFrame.new(0.620346069, 5.276999, -30.1471863, 1, 0, 0, 0, -4.37113883E-8, 1, 0, -1, -4.37113883E-8);
--				local v3342 = l_Assets_0.Particles.MartialArtist.OneInchPunch.Meshes:Clone();
--				v3342:PivotTo(v3340.CFrame * v3341);
--				v3342.Parent = l_VFX_0;
--				local v3343 = {};
--				for _, v3345 in v0.pairs(v3342:GetChildren()) do
--					local v3346 = {};
--					if v3345.Name == "Mesh1" then
--						v3346.Size = {
--							X = 92, 
--							Z = 92, 
--							Time = 0.9
--						};
--						v3346.Transparency = {
--							Value = 1, 
--							Time = 1.5
--						};
--						v3346.LinearDisplacement = {
--							Y = 45, 
--							Time = 1.25
--						};
--						v3346.AngularDisplacement = {
--							Y = v0.math.pi * 6, 
--							Time = 2
--						};
--					end;
--					if v3345.Name == "Mesh2" then
--						v3346.Size = {
--							X = 140, 
--							Z = 140, 
--							Time = 1
--						};
--						v3346.Transparency = {
--							Value = 1, 
--							Time = 2
--						};
--						v3346.LinearDisplacement = {
--							Y = 70, 
--							Time = 2.5
--						};
--						v3346.AngularDisplacement = {
--							Y = -400, 
--							Time = 3.5
--						};
--					end;
--					if v3345.Name == "Mesh3" then
--						v3346.Size = {
--							X = 110, 
--							Z = 110, 
--							Time = 1
--						};
--						v3346.Transparency = {
--							Value = 1, 
--							Time = 2
--						};
--						v3346.LinearDisplacement = {
--							Y = 90, 
--							Time = 2.5
--						};
--						v3346.AngularDisplacement = {
--							Y = 400, 
--							Time = 3.5
--						};
--					end;
--					if v3345.Name == "Mesh4" then
--						v3346.Transparency = {
--							Value = 1, 
--							Time = 3
--						};
--						v3346.LinearDisplacement = {
--							Y = 90, 
--							Time = 4
--						};
--						v3346.AngularDisplacement = {
--							Y = 400, 
--							Time = 3
--						};
--					end;
--					if v3345.Name == "Mesh5" then
--						v3346.Size = {
--							X = 150, 
--							Z = 150, 
--							Time = 1.5
--						};
--						v3346.Transparency = {
--							Value = 1, 
--							Time = 1.5
--						};
--						v3346.LinearDisplacement = {
--							Y = -45, 
--							Time = 3
--						};
--						v3346.AngularDisplacement = {
--							Y = -190, 
--							Time = 3
--						};
--					end;
--					if v3345.Name == "Mesh6" then
--						v3346.Size = {
--							X = 110, 
--							Z = 110, 
--							Time = 1.5
--						};
--						v3346.Transparency = {
--							Value = 1, 
--							Time = 2.5
--						};
--						v3346.LinearDisplacement = {
--							Y = 45, 
--							Time = 1.5
--						};
--						v3346.AngularDisplacement = {
--							Y = 90, 
--							Time = 3
--						};
--					end;
--					local v3347 = VFXService.LoadMeshPartAnimation(v3345, v3346);
--					for _, v3349 in v0.pairs(v3347) do
--						v0.table.insert(v3343, v3349);
--					end;
--				end;
--				for _, v3351 in v0.pairs(v3343) do
--					v3351:Play();
--				end;
--				VFXService.EmitParticlesInInstance(v3340);
--				VFXService.DestroyParticleContainer(v3340, 5);
--				local l_v3342_0 = v3342 --[[ copy: 6 -> 162 ]];
--				v0.task.delay(5, function()
--					if l_v3342_0 ~= nil and l_v3342_0.Parent ~= nil then
--						l_v3342_0:Destroy();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndOneInchPunchCameraLeft" then
--			VFXService.EndCutscene();
--			VFXService.DestroyBind(v26, "OneInchPunchFrameReplication");
--		end;
--		if l_Request_1 == "EndOneInchPunchFrame" then
--			VFXService.DestroyBind(v26, "OneInchPunchFrameReplication");
--		end;
--		if l_Request_1 == "OneInchPunchDash" then
--			local v3353 = v0.Instance.new("BodyVelocity");
--			v3353.MaxForce = v0.Vector3.new(35000, 0, 35000);
--			v3353.Parent = l_HumanoidRootPart_0;
--			local v3354 = v0.Instance.new("NumberValue");
--			v3354.Value = 240;
--			local v3355 = nil;
--			local v3356 = nil;
--			local l_v3353_0 = v3353 --[[ copy: 2 -> 159 ]];
--			local l_v3354_0 = v3354 --[[ copy: 3 -> 160 ]];
--			do
--				local l_v3355_0, l_v3356_0 = v3355, v3356;
--				local v3361 = VFXService.CreateBind(v26, "OneInchPunchDashBind", function()
--					v0.pcall(function()
--						l_v3353_0:Destroy();
--					end);
--					v0.pcall(function()
--						l_v3354_0:Destroy();
--					end);
--					if l_v3355_0 ~= nil then
--						l_v3355_0:Disconnect();
--						l_v3355_0 = nil;
--					end;
--					if l_v3356_0 ~= nil then
--						l_v3356_0:Disconnect();
--						l_v3356_0 = nil;
--					end;
--				end);
--				local v3362 = l_TweenService_0:Create(v3354, v0.TweenInfo.new(2.5, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--					Value = 0
--				});
--				v3362.Completed:Connect(function()
--					v0.pcall(function()
--						l_v3353_0:Destroy();
--						l_v3354_0:Destroy();
--					end);
--					if l_v3355_0 ~= nil then
--						l_v3355_0:Disconnect();
--						l_v3355_0 = nil;
--					end;
--					if l_v3356_0 ~= nil then
--						l_v3356_0:Disconnect();
--						l_v3356_0 = nil;
--					end;
--				end);
--				l_v3356_0 = v26.ChildAdded:Connect(function(v3363)
--					if v3363:IsA("Configuration") and v3363:GetAttribute("Bind") == true and v3363.Name == "ClientAttackDetectionHitDetected" and l_v3353_0 ~= nil and l_v3353_0.Parent ~= nil then
--						l_v3353_0:Destroy();
--					end;
--				end);
--				l_v3355_0 = l_RenderStepped_0:Connect(function()
--					if l_v3353_0 ~= nil and l_v3353_0.Parent ~= nil then
--						l_v3353_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * l_v3354_0.Value;
--						return;
--					else
--						if l_v3355_0 ~= nil then
--							l_v3355_0:Disconnect();
--							l_v3355_0 = nil;
--						end;
--						return;
--					end;
--				end);
--				local l_v3361_0 = v3361 --[[ copy: 6 -> 161 ]];
--				v3353:GetPropertyChangedSignal("Velocity"):Connect(function()
--					if l_v3353_0.Velocity.Magnitude <= 50 and l_v3361_0 ~= nil and l_v3361_0.Parent ~= nil then
--						l_v3361_0:Destroy();
--					end;
--				end);
--				v3362:Play();
--			end;
--		end;
--		if l_Request_1 == "EndOneInchPunchDash" then
--			VFXService.DestroyBind(v26, "OneInchPunchDashBind");
--		end;
--		if l_Request_1 == "OneInchPunchCamera" then
--			local l_On_277 = v724.On;
--			if not (l_On_277 ~= nil) or l_On_277.Parent == nil then
--				return;
--			else
--				local _, v3367 = VFXService.InitiateCutscene("OneInchPunch", 60, 140335129215659, l_On_277, v0.CFrame.new(0, -3, 0), {
--					Time = 0.55, 
--					EasingStyle = v0.Enum.EasingStyle.Exponential, 
--					EasingDirection = v0.Enum.EasingDirection.Out
--				}, {
--					Time = 0
--				}, -1);
--				local l_l_On_277_0 = l_On_277 --[[ copy: 2 -> 158 ]];
--				v3367:GetMarkerReachedSignal("RedFrame"):Connect(function()
--					local v3369 = l_Assets_0.Parts.InvertedSphere:Clone();
--					local v3370 = v0.Instance.new("Texture");
--					v3370.Face = "Back";
--					v3370.StudsPerTileV = 0.175;
--					v3370.StudsPerTileU = 0.175;
--					v3370.Transparency = 0.95;
--					v3370.Texture = "rbxassetid://10052054503";
--					v3370.Parent = v3369;
--					local v3371 = v0.Instance.new("Texture");
--					v3371.Face = "Back";
--					v3371.StudsPerTileV = 10;
--					v3371.StudsPerTileU = 10;
--					v3371.Transparency = 0.95;
--					v3371.Texture = "rbxassetid://10024514185";
--					v3371.Parent = v3369;
--					v3369.Size = v0.Vector3.new(60, 60, 0);
--					v3369.Anchored = true;
--					v3369.CanCollide = false;
--					v3369.CanTouch = false;
--					v3369.CanQuery = false;
--					v3369.Massless = true;
--					v3369.CastShadow = false;
--					v3369.EnableFluidForces = false;
--					local v3372 = nil;
--					v3372 = l_RenderStepped_0:Connect(function()
--						if v3369 ~= nil and v3369.Parent ~= nil then
--							v3369.CFrame = l_CurrentCamera_1.CFrame + v0.Vector3.new(l_CurrentCamera_1.CFrame.LookVector.X, 0, l_CurrentCamera_1.CFrame.LookVector.Z) * 0.3;
--							return;
--						else
--							if v3372 ~= nil then
--								v3372:Disconnect();
--								v3372 = nil;
--							end;
--							return;
--						end;
--					end);
--					v3369.Parent = l_VFX_0;
--					local v3373 = nil;
--					if l_l_On_277_0 ~= nil and l_l_On_277_0.Parent ~= nil then
--						v3373 = l_l_On_277_0.Parent;
--					end;
--					local l_V_2 = v724.V;
--					local v3375 = {};
--					if v3373 ~= nil and v3373.Parent ~= nil then
--						local v3376 = v0.Instance.new("Highlight");
--						v3376.OutlineTransparency = 1;
--						v3376.FillTransparency = 0;
--						v3376.FillColor = v0.Color3.fromRGB();
--						v0.table.insert(v3375, v3376);
--						v3376.Parent = v3373;
--					end;
--					if l_V_2 ~= nil and l_V_2.Parent ~= nil then
--						local v3377 = v0.Instance.new("Highlight");
--						v3377.OutlineTransparency = 1;
--						v3377.FillTransparency = 0;
--						v3377.FillColor = v0.Color3.fromRGB();
--						v0.table.insert(v3375, v3377);
--						v3377.Parent = l_V_2;
--					end;
--					local v3378 = nil;
--					local function v3381(v3379, v3380)
--						if typeof(v3379) ~= "number" then
--							v3379 = 1;
--						end;
--						if typeof(v3380) ~= "number" then
--							v3380 = 0.285;
--						end;
--						if v3369 ~= nil and v3369.Parent ~= nil then
--							if v3378 ~= nil then
--								v3378:Cancel();
--								v3378 = nil;
--							end;
--							v3369.Color = v0.Color3.fromRGB(130 * v3379, 0, 0);
--							v3378 = l_TweenService_0:Create(v3369, v0.TweenInfo.new(v3380, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--								Color = v0.Color3.fromRGB(80, 0, 0)
--							});
--							v3378:Play();
--						end;
--					end;
--					local function v3415()
--						if not (v3373 ~= nil) or v3373.Parent == nil then
--							return;
--						else
--							local v3382 = v0.Instance.new("Part");
--							v3382.EnableFluidForces = false;
--							v3382.Massless = true;
--							v3382.CanCollide = false;
--							v3382.CanQuery = false;
--							v3382.CanTouch = false;
--							v3382.CastShadow = false;
--							v3382.Anchored = true;
--							v3382.Size = v0.Vector3.zero;
--							v3382.Material = v0.Enum.Material.SmoothPlastic;
--							v3382.Parent = l_VFX_0;
--							local v3383 = nil;
--							v3383 = l_RenderStepped_0:Connect(function()
--								if v3382 ~= nil and v3382.Parent ~= nil and v3373 ~= nil and v3373.Parent ~= nil then
--									v3382.CFrame = v0.CFrame.new(v3373.HumanoidRootPart.Position, v3373.HumanoidRootPart.Position + l_CurrentCamera_1.CFrame.LookVector) * v0.CFrame.Angles(0, v0.math.pi / 2, 0);
--									return;
--								else
--									if v3383 ~= nil then
--										v3383:Disconnect();
--										v3383 = nil;
--									end;
--									if v3382 ~= nil and v3382.Parent ~= nil then
--										v3382.Anchored = false;
--									end;
--									return;
--								end;
--							end);
--							local l_GUI_0 = l_Assets_0.Particles.MartialArtist.OneInchPunch.GUI;
--							local v3385 = l_GUI_0.One:Clone();
--							local v3386 = l_GUI_0.Inch:Clone();
--							local v3387 = l_GUI_0.Killer:Clone();
--							local v3388 = l_GUI_0.Punch:Clone();
--							local v3389 = l_GUI_0.OneKanji:Clone();
--							local v3390 = l_GUI_0.InchKanji:Clone();
--							local v3391 = l_GUI_0.KillerKanji:Clone();
--							local v3392 = l_GUI_0.PunchKanji:Clone();
--							local v3393 = v0.Instance.new("Weld");
--							v3393.Part0 = v3382;
--							v3393.Parent = v3385;
--							v3393.Part1 = v3385;
--							local v3394 = v0.Instance.new("Weld");
--							v3394.Part0 = v3382;
--							v3394.Parent = v3386;
--							v3394.Part1 = v3386;
--							local v3395 = v0.Instance.new("Weld");
--							v3395.Part0 = v3382;
--							v3395.Parent = v3387;
--							v3395.Part1 = v3387;
--							local v3396 = v0.Instance.new("Weld");
--							v3396.Part0 = v3382;
--							v3396.Parent = v3388;
--							v3396.Part1 = v3388;
--							local v3397 = v0.Instance.new("Weld");
--							v3397.Part0 = v3382;
--							v3397.Parent = v3389;
--							v3397.Part1 = v3389;
--							local v3398 = v0.Instance.new("Weld");
--							v3398.Part0 = v3382;
--							v3398.Parent = v3390;
--							v3398.Part1 = v3390;
--							local v3399 = v0.Instance.new("Weld");
--							v3399.Part0 = v3382;
--							v3399.Parent = v3391;
--							v3399.Part1 = v3391;
--							local v3400 = v0.Instance.new("Weld");
--							v3400.Part0 = v3382;
--							v3400.Parent = v3392;
--							v3400.Part1 = v3392;
--							v3393.C1 = v3393.C1 * v0.CFrame.new(0, -3, 1.6355);
--							v3394.C1 = v3394.C1 * v0.CFrame.new(0, -1, 1.6355);
--							v3395.C1 = v3395.C1 * v0.CFrame.new(0, 1, 1.6355);
--							v3396.C1 = v3396.C1 * v0.CFrame.new(0, 3, 1.6355);
--							v3397.C1 = v3397.C1 * v0.CFrame.new(0, -3, 1.6355);
--							v3398.C1 = v3398.C1 * v0.CFrame.new(0, -1, 1.6355);
--							v3399.C1 = v3399.C1 * v0.CFrame.new(0, 1, 1.6355);
--							v3400.C1 = v3400.C1 * v0.CFrame.new(0, 3, 1.6355);
--							local v3401 = v0.TweenInfo.new(0.3, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out);
--							local v3402 = l_TweenService_0:Create(v3393, v0.TweenInfo.new(0.3, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--								C1 = v3393.C1 * v0.CFrame.new(0, 0, -5.6355)
--							});
--							local v3403 = l_TweenService_0:Create(v3394, v0.TweenInfo.new(0.35, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--								C1 = v3394.C1 * v0.CFrame.new(0, 0, -5.6355)
--							});
--							local v3404 = l_TweenService_0:Create(v3395, v0.TweenInfo.new(0.4, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--								C1 = v3395.C1 * v0.CFrame.new(0, 0, -5.6355)
--							});
--							local v3405 = l_TweenService_0:Create(v3396, v0.TweenInfo.new(0.45, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--								C1 = v3396.C1 * v0.CFrame.new(0, 0, -5.6355)
--							});
--							local v3406 = l_TweenService_0:Create(v3397, v3401, {
--								C1 = v3397.C1 * v0.CFrame.new(0, 0, 5.6355)
--							});
--							local v3407 = l_TweenService_0:Create(v3398, v3401, {
--								C1 = v3398.C1 * v0.CFrame.new(0, 0, 5.6355)
--							});
--							local v3408 = l_TweenService_0:Create(v3399, v3401, {
--								C1 = v3399.C1 * v0.CFrame.new(0, 0, 5.6355)
--							});
--							local v3409 = l_TweenService_0:Create(v3400, v3401, {
--								C1 = v3400.C1 * v0.CFrame.new(0, 0, 5.6355)
--							});
--							local v3410 = v0.Random.new();
--							local v3411 = l_TweenService_0:Create(v3389.Billboard.Image, v3401, {
--								Rotation = v3410:NextNumber(-8, 8)
--							});
--							local v3412 = l_TweenService_0:Create(v3390.Billboard.Image, v3401, {
--								Rotation = v3410:NextNumber(-8, 8)
--							});
--							local v3413 = l_TweenService_0:Create(v3391.Billboard.Image, v3401, {
--								Rotation = v3410:NextNumber(-8, 8)
--							});
--							local v3414 = l_TweenService_0:Create(v3392.Billboard.Image, v3401, {
--								Rotation = v3410:NextNumber(-8, 8)
--							});
--							v0.task.delay(0.8, function()
--								v3381(1.325, 0.32);
--								v3385.Parent = l_VFX_0;
--								v3386.Parent = l_VFX_0;
--								v3387.Parent = l_VFX_0;
--								v3388.Parent = l_VFX_0;
--								if v3402 ~= nil then
--									v3402:Play();
--								end;
--								if v3403 ~= nil then
--									v3403:Play();
--								end;
--								if v3404 ~= nil then
--									v3404:Play();
--								end;
--								if v3405 ~= nil then
--									v3405:Play();
--								end;
--							end);
--							v0.task.delay(0.6, function()
--								v3381(1.15);
--								v3392.Parent = l_VFX_0;
--								if v3409 ~= nil then
--									v3409:Play();
--								end;
--								if v3414 ~= nil then
--									v3414:Play();
--								end;
--							end);
--							v0.task.delay(0.4, function()
--								v3381(1.1);
--								v3391.Parent = l_VFX_0;
--								if v3408 ~= nil then
--									v3408:Play();
--								end;
--								if v3413 ~= nil then
--									v3413:Play();
--								end;
--							end);
--							v0.task.delay(0.2, function()
--								v3381(1.05);
--								v3390.Parent = l_VFX_0;
--								if v3407 ~= nil then
--									v3407:Play();
--								end;
--								if v3412 ~= nil then
--									v3412:Play();
--								end;
--							end);
--							v3381();
--							v104.PlaySound("OneInchPunchTextSpawn");
--							v3389.Parent = l_VFX_0;
--							v3406:Play();
--							v3411:Play();
--							VFXService.CreateBind(v3373, "OneInchPunchKanjiAndWords", function()
--								v0.pcall(function()
--									v3382:Destroy();
--								end);
--								v0.pcall(function()
--									v3385:Destroy();
--								end);
--								v0.pcall(function()
--									v3386:Destroy();
--								end);
--								v0.pcall(function()
--									v3387:Destroy();
--								end);
--								v0.pcall(function()
--									v3388:Destroy();
--								end);
--								v0.pcall(function()
--									v3389:Destroy();
--								end);
--								v0.pcall(function()
--									v3390:Destroy();
--								end);
--								v0.pcall(function()
--									v3391:Destroy();
--								end);
--								v0.pcall(function()
--									v3392:Destroy();
--								end);
--							end);
--							return;
--						end;
--					end;
--					local v3418 = VFXService.CreateBind(v26, "OneInchPunchFrameReplication", function()
--						if v3369 ~= nil and v3369.Parent ~= nil then
--							v3369:Destroy();
--						end;
--						if v3372 ~= nil then
--							v3372:Disconnect();
--							v3372 = nil;
--						end;
--						for _, v3417 in v0.pairs(v3375) do
--							if v3417 ~= nil and v3417.Parent ~= nil then
--								v3417:Destroy();
--							end;
--						end;
--						if v3373 ~= nil and v3373.Parent ~= nil then
--							VFXService.DestroyBind(v3373, "OneInchPunchKanjiAndWords", true);
--						end;
--					end);
--					v0.task.delay(0.05, function()
--						if v3418 ~= nil and v3418.Parent ~= nil then
--							v3415();
--						end;
--					end);
--				end);
--				v3367:GetMarkerReachedSignal("EndFrame"):Connect(function()
--					VFXService.DestroyBind(v26, "OneInchPunchFrameReplication");
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndOneInchPunchCameraVictim" then
--			VFXService.EndCutscene();
--			VFXService.ScreenFlash();
--			l_Humanoid_0.CameraOffset = v0.Vector3.zero;
--		end;
--		if l_Request_1 == "EndOneInchPunchCamera" then
--			VFXService.ScreenFlash();
--			l_CurrentCamera_1.CFrame = (l_HumanoidRootPart_0.CFrame - l_HumanoidRootPart_0.CFrame.LookVector * 3 + v0.Vector3.new(0, 8, 0)) * v0.CFrame.Angles(-v0.math.pi / 8, 0, 0);
--			VFXService.EndCutscene();
--			l_Humanoid_0.CameraOffset = v0.Vector3.new(0, 35, 0);
--			VFXService.ShakeCamera(0, 0.8, 29, 0.725, 0.75, 0.725);
--		end;
--		if l_Request_1 == "EndPantherComboSwingSounds" then
--			local l_On_278 = v724.On;
--			if not (l_On_278 ~= nil) or l_On_278.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_278, "PantherComboSwingSounds", true);
--			end;
--		end;
--		if l_Request_1 == "PantherComboSwingSounds" then
--			local l_On_279 = v724.On;
--			if not (l_On_279 ~= nil) or l_On_279.Parent == nil then
--				return;
--			else
--				local v3421 = v104.PlaySoundInInstance(l_On_279.HumanoidRootPart, "PantherComboSwings");
--				local v3422 = l_TweenService_0:Create(v3421, v0.TweenInfo.new(0.15, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--					Volume = 0
--				});
--				local l_v3421_0 = v3421 --[[ copy: 3 -> 155 ]];
--				v3422.Completed:Connect(function()
--					if l_v3421_0 ~= nil and l_v3421_0.Parent ~= nil then
--						l_v3421_0:Destroy();
--					end;
--				end);
--				local l_v3422_0 = v3422 --[[ copy: 4 -> 156 ]];
--				local v3425 = VFXService.CreateBind(l_On_279, "PantherComboSwingSounds", function()
--					if l_v3421_0 ~= nil and l_v3421_0.Parent ~= nil then
--						l_v3421_0:SetAttribute("DefaultVolume", nil);
--						l_v3422_0:Play();
--					end;
--				end);
--				local l_v3425_0 = v3425 --[[ copy: 5 -> 157 ]];
--				v3421.Ended:Connect(function()
--					if l_v3425_0 ~= nil and l_v3425_0.Parent ~= nil then
--						l_v3425_0:Destroy();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "LargeBlock" then
--			local l_On_280 = v724.On;
--			if not (l_On_280 ~= nil) or l_On_280.Parent == nil then
--				return;
--			else
--				local v3428 = v0.math.random(1, 3);
--				v104.PlaySoundInInstance(l_On_280.HumanoidRootPart, "BlockLarge" .. v0.tostring(v3428));
--				VFXService.EmitFromAttachment(l_On_280.HumanoidRootPart.RootAttachment, l_Assets_0.Particles.Block:GetChildren(), 0.5);
--			end;
--		end;
--		if l_Request_1 == "SmallBlock" then
--			local l_On_281 = v724.On;
--			if not (l_On_281 ~= nil) or l_On_281.Parent == nil then
--				return;
--			else
--				local v3430 = v0.math.random(1, 3);
--				v104.PlaySoundInInstance(l_On_281.HumanoidRootPart, "BlockSmall" .. v0.tostring(v3430));
--				VFXService.EmitFromAttachment(l_On_281.HumanoidRootPart.RootAttachment, l_Assets_0.Particles.Block:GetChildren(), 0.5);
--			end;
--		end;
--		if l_Request_1 == "FixSpeedBug" then
--			local v3431 = v0.Instance.new("Part");
--			v3431.Massless = true;
--			v3431.Anchored = false;
--			v3431.Size = v0.Vector3.zero;
--			v3431.Material = v0.Enum.Material.SmoothPlastic;
--			v3431.Transparency = 1;
--			v3431.EnableFluidForces = false;
--			v3431.CastShadow = false;
--			v3431.CanCollide = false;
--			v3431.CanTouch = false;
--			v3431.CanQuery = false;
--			v3431.Parent = v26;
--			local v3432 = v0.Instance.new("Weld");
--			v3432.Parent = v3431;
--			v3432.Part0 = l_HumanoidRootPart_0;
--			v3432.Part1 = v3431;
--			l_RenderStepped_0:Wait();
--			if v3431 ~= nil and v3431.Parent ~= nil then
--				v3431:Destroy();
--			end;
--		end;
--		if l_Request_1 == "SetCharacterInvisible" then
--			local l_On_282 = v724.On;
--			if not (l_On_282 ~= nil) or l_On_282.Parent == nil then
--				return;
--			else
--				for _, v3435 in v0.pairs(l_On_282:GetDescendants()) do
--					if v3435:IsA("BasePart") or v3435:IsA("Decal") then
--						v3435.Transparency = 1;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "SetCharacterVisible" then
--			local l_On_283 = v724.On;
--			if not (l_On_283 ~= nil) or l_On_283.Parent == nil then
--				return;
--			else
--				for _, v3438 in v0.pairs(l_On_283:GetDescendants()) do
--					if (v3438:IsA("BasePart") or v3438:IsA("Decal")) and v3438.Name ~= "HumanoidRootPart" then
--						v3438.Transparency = 0;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "PantherComboAfterImages" then
--			local l_On_284 = v724.On;
--			if not (l_On_284 ~= nil) or l_On_284.Parent == nil then
--				return;
--			else
--				local v3440 = nil;
--				local l_l_On_284_0 = l_On_284 --[[ copy: 2 -> 154 ]];
--				v3440 = v0.task.spawn(function()
--					local v3442 = v0.TweenInfo.new(0.125, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out, 0, false, 0);
--					while l_l_On_284_0 ~= nil and l_l_On_284_0.Parent ~= nil do
--						local v3443 = l_l_On_284_0:Clone();
--						v3443.Head.face.Transparency = 1;
--						if v3443.Head:FindFirstChild("HealthUI") then
--							v3443.Head.HealthUI:Destroy();
--						end;
--						if v3443.Head:FindFirstChild("TitleUI") then
--							v3443.Head.TitleUI:Destroy();
--						end;
--						if v3443.HumanoidRootPart:FindFirstChild("ConsoleLockOnUI") then
--							v3443.HumanoidRootPart.ConsoleLockOnUI:Destroy();
--						end;
--						for _, v3445 in v0.pairs(v3443:GetDescendants()) do
--							if not (not v3445:IsA("ParticleEmitter") and not v3445:IsA("Beam")) or v3445:IsA("Trail") then
--								v3445:Destroy();
--							end;
--							if v3445:IsA("BasePart") or v3445:IsA("Decal") then
--								if v3445.Transparency < 1 then
--									v3445.Transparency = 0.8;
--									local v3446 = l_TweenService_0:Create(v3445, v3442, {
--										Transparency = 1
--									});
--									v0.task.delay(0.1, function()
--										if v3445 ~= nil and v3445.Parent ~= nil then
--											v3446:Play();
--										end;
--									end);
--								end;
--								if v3445:IsA("BasePart") then
--									v3445.Anchored = true;
--									v3445.CanCollide = false;
--									v3445.CanTouch = false;
--									v3445.CanQuery = false;
--									v3445.CollisionGroup = "No Character Collision";
--								end;
--							end;
--							if v3445:IsA("BallSocketConstraint") then
--								v3445:Destroy();
--							end;
--							if v3445:IsA("Motor6D") then
--								v3445.Enabled = true;
--							end;
--						end;
--						v3443.Parent = l_VFX_0;
--						v0.task.delay(0.225, function()
--							if v3443 ~= nil and v3443.Parent ~= nil then
--								v3443:Destroy();
--							end;
--						end);
--						v0.task.wait(0.01);
--					end;
--				end);
--				do
--					local l_v3440_0 = v3440;
--					VFXService.CreateBind(l_On_284, "PantherComboAfterImageEffects", function()
--						v0.pcall(function()
--							v0.task.cancel(l_v3440_0);
--						end);
--						l_v3440_0 = nil;
--					end);
--				end;
--			end;
--		end;
--		if l_Request_1 == "EndPantherComboAfterImages" then
--			local l_On_285 = v724.On;
--			if not (l_On_285 ~= nil) or l_On_285.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_285, "PantherComboAfterImageEffects");
--			end;
--		end;
--		if l_Request_1 == "PantherComboFinisherMovementSounds" then
--			local l_On_286 = v724.On;
--			if not (l_On_286 ~= nil) or l_On_286.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_286.HumanoidRootPart, "PantherComboFinisherMovement");
--			end;
--		end;
--		if l_Request_1 == "PantherComboFinisherHit1" then
--			local l_On_287 = v724.On;
--			if not (l_On_287 ~= nil) or l_On_287.Parent == nil then
--				return;
--			else
--				local v3451 = l_Assets_0.Particles.MartialArtist.PantherCombo.Finisher.Punch1:Clone();
--				v3451.Position = l_On_287.Torso.Position;
--				if (v3451.Position - l_HumanoidRootPart_0.Position).Magnitude <= 10 then
--					VFXService.ShakeCamera(0, 0.2, 24);
--				end;
--				v3451.Parent = l_VFX_0;
--				v104.PlaySoundAtCFrame(v3451.Position, "PantherComboFinisherHit1");
--				VFXService.EmitParticlesInInstance(v3451);
--				VFXService.DestroyParticleContainer(v3451, 2);
--			end;
--		end;
--		if l_Request_1 == "PantherComboFinisherHit2" then
--			local l_On_288 = v724.On;
--			if not (l_On_288 ~= nil) or l_On_288.Parent == nil then
--				return;
--			else
--				local v3453 = l_Assets_0.Particles.MartialArtist.PantherCombo.Finisher.Punch2:Clone();
--				v3453.Position = l_On_288.Torso.Position;
--				if (v3453.Position - l_HumanoidRootPart_0.Position).Magnitude <= 10 then
--					VFXService.ShakeCamera(0, 0.2, 24);
--				end;
--				v3453.Parent = l_VFX_0;
--				v104.PlaySoundAtCFrame(v3453.Position, "PantherComboFinisherHit2");
--				VFXService.EmitParticlesInInstance(v3453);
--				VFXService.DestroyParticleContainer(v3453, 2);
--			end;
--		end;
--		if l_Request_1 == "PantherComboFinisherCrater1" then
--			local v3454 = v724.At + v0.Vector3.new(0, 1.5, 0);
--			local v3455 = {};
--			local v3456 = {};
--			local v3457 = VFXService.FindGroundPosition(v3454.Position);
--			VFXService.GetCircularRocksProperties(v3455, v3454 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--				7, 
--				12.5
--			}, 8, {
--				4, 
--				4.5
--			}, {
--				1, 
--				1.25
--			}, {
--				1, 
--				1.25
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				"Grow", 
--				"Sink"
--			}, 5.5, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetCircularRocksProperties(v3455, v3454 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--				7, 
--				12.5
--			}, 8, {
--				2.75, 
--				3.5
--			}, {
--				0.75, 
--				1
--			}, {
--				0.75, 
--				1
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				"Grow", 
--				"Sink"
--			}, 5.5, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetFlyingRocksProperties(v3456, v3454, 3, {
--				5, 
--				27
--			}, {
--				62, 
--				62
--			}, {
--				5, 
--				27
--			}, 0.8, 0.8, 0.8, 5);
--			VFXService.GetFlyingRocksProperties(v3456, v3454, 3, {
--				5, 
--				27
--			}, {
--				62, 
--				62
--			}, {
--				5, 
--				27
--			}, 1.1, 1.1, 1.1, 5);
--			VFXService.GetFlyingRocksProperties(v3456, v3454, 3, {
--				5, 
--				27
--			}, {
--				62, 
--				62
--			}, {
--				5, 
--				27
--			}, 0.55, 0.55, 0.55, 5);
--			local v3458 = VFXService.GetTile(v3454.Position);
--			if v3457 then
--				local v3459 = l_Assets_0.Particles.MartialArtist.PantherCombo.Finisher.Slam1:Clone();
--				v3459.Position = v3457.Position + v0.Vector3.new(0, 0.1, 0);
--				local v3460 = v0.ColorSequence.new(v3457.Instance.Color);
--				for _, v3462 in v0.pairs(v3459:GetDescendants()) do
--					if v3462:IsA("ParticleEmitter") and v3462.Name == "Smoke" then
--						v3462.Color = v3460;
--					end;
--				end;
--				v3459.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3459);
--				VFXService.DestroyParticleContainer(v3459, 5);
--			end;
--			v104.PlaySoundAtCFrame(v3454, "PantherComboFinisherCrater1");
--			VFXService.ApplyCircularRocksProperties(v3455);
--			VFXService.ApplyFlyingRocksProperties(v3456);
--			VFXService.DestroyTile(v3458);
--			if (v3454.Position - l_HumanoidRootPart_0.Position).Magnitude <= 50 then
--				VFXService.ShakeCamera(0.05, 0.3, 28, 0.3, 0.525, 0.3);
--			end;
--		end;
--		if l_Request_1 == "PantherComboFinisherCrater2" then
--			local v3463 = v724.At + v0.Vector3.new(0, 1.5, 0);
--			local v3464 = {};
--			local v3465 = {};
--			local v3466 = VFXService.FindGroundPosition(v3463.Position);
--			VFXService.GetCircularRocksProperties(v3464, v3463 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--				14, 
--				24
--			}, 10, {
--				6, 
--				8
--			}, {
--				2, 
--				3
--			}, {
--				2, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				"Grow", 
--				"Sink"
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetCircularRocksProperties(v3464, v3463 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--				14, 
--				24
--			}, 11, {
--				4.5, 
--				5.5
--			}, {
--				1.45, 
--				1.8
--			}, {
--				1.45, 
--				1.8
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				"Grow", 
--				"Sink"
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetCircularRocksProperties(v3464, v3463 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--				14, 
--				24
--			}, 10, {
--				4, 
--				4.25
--			}, {
--				1.25, 
--				1.5
--			}, {
--				1.25, 
--				1.5
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				"Grow", 
--				"Sink"
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetCircularRocksProperties(v3464, v3463 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--				10, 
--				21
--			}, 8, {
--				4.5, 
--				5
--			}, {
--				1.5, 
--				1.75
--			}, {
--				1.5, 
--				1.75
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				"Grow", 
--				"Sink"
--			}, 6, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetCircularRocksProperties(v3464, v3463 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--				10, 
--				21
--			}, 8, {
--				4.5, 
--				5
--			}, {
--				1.5, 
--				1.75
--			}, {
--				1.5, 
--				1.75
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				"Grow", 
--				"Sink"
--			}, 6, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetCircularRocksProperties(v3464, v3463 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--				10, 
--				21
--			}, 7, {
--				4.5, 
--				5
--			}, {
--				1.5, 
--				1.75
--			}, {
--				1.5, 
--				1.75
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				"Grow", 
--				"Sink"
--			}, 6, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetCircularRocksProperties(v3464, v3463 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--				10, 
--				21
--			}, 7, {
--				4.5, 
--				5
--			}, {
--				1.5, 
--				1.75
--			}, {
--				1.5, 
--				1.75
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				-3, 
--				3
--			}, {
--				"Grow", 
--				"Sink"
--			}, 6, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetFlyingRocksProperties(v3465, v3463, 5, {
--				15, 
--				65
--			}, {
--				60, 
--				75
--			}, {
--				15, 
--				65
--			}, 2, 2, 2);
--			VFXService.GetFlyingRocksProperties(v3465, v3463, 6, {
--				15, 
--				65
--			}, {
--				60, 
--				75
--			}, {
--				15, 
--				65
--			}, 1, 1, 1);
--			VFXService.GetFlyingRocksProperties(v3465, v3463, 7, {
--				15, 
--				65
--			}, {
--				60, 
--				75
--			}, {
--				15, 
--				65
--			}, 1.25, 1.25, 1.25);
--			local v3467 = VFXService.GetTile(v3463.Position);
--			if v3466 then
--				local v3468 = l_Assets_0.Particles.MartialArtist.PantherCombo.Finisher.Slam2:Clone();
--				v3468.Position = v3466.Position + v0.Vector3.new(0, 0.1, 0);
--				local v3469 = v0.ColorSequence.new(v3466.Instance.Color);
--				for _, v3471 in v0.pairs(v3468:GetDescendants()) do
--					if v3471:IsA("ParticleEmitter") and v3471.Name == "Smoke" then
--						v3471.Color = v3469;
--					end;
--				end;
--				v3468.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3468);
--				VFXService.DestroyParticleContainer(v3468, 5);
--			end;
--			v104.PlaySoundAtCFrame(v3463, "PantherComboFinisherCrater2");
--			VFXService.ApplyCircularRocksProperties(v3464);
--			VFXService.ApplyFlyingRocksProperties(v3465);
--			VFXService.DestroyTile(v3467);
--			if (v3463.Position - l_HumanoidRootPart_0.Position).Magnitude <= 50 then
--				VFXService.ShakeCamera(0.05, 0.45, 31, 0.756, 0.756, 0.756);
--			end;
--		end;
--		if l_Request_1 == "PantherComboHit1" then
--			local l_On_289 = v724.On;
--			if not (l_On_289 ~= nil) or l_On_289.Parent == nil then
--				return;
--			else
--				local v3473 = l_Assets_0.Particles.MartialArtist.PantherCombo.Hit:Clone();
--				v3473.CFrame = (l_On_289.HumanoidRootPart.CFrame + l_On_289.HumanoidRootPart.CFrame.LookVector * 4) * v0.CFrame.Angles(0, v0.math.pi, 0);
--				v3473.Parent = l_VFX_0;
--				local v3474 = l_Assets_0.Particles.MartialArtist.PantherCombo.Back:Clone();
--				v3474.CFrame = (l_On_289.HumanoidRootPart.CFrame + l_On_289.HumanoidRootPart.CFrame.LookVector * 5 - v0.Vector3.new(0, 2, 0)) * v0.CFrame.Angles(0, v0.math.pi, 0);
--				v3474.Parent = l_VFX_0;
--				local v3475 = v0.Vector3.new(0, -7, 0);
--				local v3476 = workspace:Raycast(v3473.Position, v3475, v72);
--				local v3477 = workspace:Raycast(v3474.Position, v3475, v72);
--				if v3476 then
--					for _, v3479 in v0.pairs(v3473:GetDescendants()) do
--						if v3479:IsA("ParticleEmitter") and v3479.Name == "Smoke" then
--							v3479.Color = v0.ColorSequence.new(VFXService.MakeDarker(v3476.Instance.Color, 42.5, 42.5, 42.5));
--						end;
--					end;
--				end;
--				if v3477 then
--					for _, v3481 in v0.pairs(v3474:GetDescendants()) do
--						if v3481:IsA("ParticleEmitter") and v3481.Name == "Smoke" then
--							v3481.Color = v0.ColorSequence.new(VFXService.MakeDarker(v3477.Instance.Color, 42.5, 42.5, 42.5));
--						end;
--					end;
--				end;
--				VFXService.EmitParticlesInInstance(v3473);
--				VFXService.EmitParticlesInInstance(v3474);
--				VFXService.DestroyParticleContainer(v3473, 2.5);
--				VFXService.DestroyParticleContainer(v3474, 2.5);
--				v104.PlaySoundInInstance(l_On_289.HumanoidRootPart, "PantherComboHit1");
--			end;
--		end;
--		if l_Request_1 == "PantherComboHit2" then
--			local l_On_290 = v724.On;
--			if not (l_On_290 ~= nil) or l_On_290.Parent == nil then
--				return;
--			else
--				local v3483 = l_Assets_0.Particles.MartialArtist.PantherCombo.Hit:Clone();
--				v3483.CFrame = (l_On_290.HumanoidRootPart.CFrame + l_On_290.HumanoidRootPart.CFrame.LookVector * 4) * v0.CFrame.Angles(0, v0.math.pi, 0);
--				v3483.Parent = l_VFX_0;
--				local v3484 = l_Assets_0.Particles.MartialArtist.PantherCombo.Back:Clone();
--				v3484.CFrame = (l_On_290.HumanoidRootPart.CFrame + l_On_290.HumanoidRootPart.CFrame.LookVector * 5 - v0.Vector3.new(0, 2, 0)) * v0.CFrame.Angles(0, v0.math.pi, 0);
--				v3484.Parent = l_VFX_0;
--				local v3485 = v0.Vector3.new(0, -7, 0);
--				local v3486 = workspace:Raycast(v3483.Position, v3485, v72);
--				local v3487 = workspace:Raycast(v3484.Position, v3485, v72);
--				if v3486 then
--					for _, v3489 in v0.pairs(v3483:GetDescendants()) do
--						if v3489:IsA("ParticleEmitter") and v3489.Name == "Smoke" then
--							v3489.Color = v0.ColorSequence.new(VFXService.MakeDarker(v3486.Instance.Color, 42.5, 42.5, 42.5));
--						end;
--					end;
--				end;
--				if v3487 then
--					for _, v3491 in v0.pairs(v3484:GetDescendants()) do
--						if v3491:IsA("ParticleEmitter") and v3491.Name == "Smoke" then
--							v3491.Color = v0.ColorSequence.new(VFXService.MakeDarker(v3487.Instance.Color, 42.5, 42.5, 42.5));
--						end;
--					end;
--				end;
--				VFXService.EmitParticlesInInstance(v3483);
--				VFXService.EmitParticlesInInstance(v3484);
--				VFXService.DestroyParticleContainer(v3483, 2.5);
--				VFXService.DestroyParticleContainer(v3484, 2.5);
--				v104.PlaySoundInInstance(l_On_290.HumanoidRootPart, "PantherComboHit2");
--			end;
--		end;
--		if l_Request_1 == "PantherComboHit3" then
--			local l_On_291 = v724.On;
--			if not (l_On_291 ~= nil) or l_On_291.Parent == nil then
--				return;
--			else
--				local v3493 = l_Assets_0.Particles.MartialArtist.PantherCombo.Hit:Clone();
--				v3493.CFrame = (l_On_291.HumanoidRootPart.CFrame + l_On_291.HumanoidRootPart.CFrame.LookVector * 4) * v0.CFrame.Angles(0, v0.math.pi, 0);
--				v3493.Parent = l_VFX_0;
--				local v3494 = l_Assets_0.Particles.MartialArtist.PantherCombo.Back:Clone();
--				v3494.CFrame = (l_On_291.HumanoidRootPart.CFrame + l_On_291.HumanoidRootPart.CFrame.LookVector * 5 - v0.Vector3.new(0, 2, 0)) * v0.CFrame.Angles(0, v0.math.pi, 0);
--				v3494.Parent = l_VFX_0;
--				local v3495 = v0.Vector3.new(0, -7, 0);
--				local v3496 = workspace:Raycast(v3493.Position, v3495, v72);
--				local v3497 = workspace:Raycast(v3494.Position, v3495, v72);
--				if v3496 then
--					for _, v3499 in v0.pairs(v3493:GetDescendants()) do
--						if v3499:IsA("ParticleEmitter") and v3499.Name == "Smoke" then
--							v3499.Color = v0.ColorSequence.new(VFXService.MakeDarker(v3496.Instance.Color, 42.5, 42.5, 42.5));
--						end;
--					end;
--				end;
--				if v3497 then
--					for _, v3501 in v0.pairs(v3494:GetDescendants()) do
--						if v3501:IsA("ParticleEmitter") and v3501.Name == "Smoke" then
--							v3501.Color = v0.ColorSequence.new(VFXService.MakeDarker(v3497.Instance.Color, 42.5, 42.5, 42.5));
--						end;
--					end;
--				end;
--				VFXService.EmitParticlesInInstance(v3493);
--				VFXService.EmitParticlesInInstance(v3494);
--				VFXService.DestroyParticleContainer(v3493, 2.5);
--				VFXService.DestroyParticleContainer(v3494, 2.5);
--				v104.PlaySoundInInstance(l_On_291.HumanoidRootPart, "PantherComboHit3");
--			end;
--		end;
--		if l_Request_1 == "PantherComboHit4" then
--			local l_On_292 = v724.On;
--			if not (l_On_292 ~= nil) or l_On_292.Parent == nil then
--				return;
--			else
--				local v3503 = l_Assets_0.Particles.MartialArtist.PantherCombo.Hit:Clone();
--				v3503.CFrame = (l_On_292.HumanoidRootPart.CFrame + l_On_292.HumanoidRootPart.CFrame.LookVector * 4) * v0.CFrame.Angles(0, v0.math.pi, 0);
--				v3503.Parent = l_VFX_0;
--				local v3504 = l_Assets_0.Particles.MartialArtist.PantherCombo.Back:Clone();
--				v3504.CFrame = (l_On_292.HumanoidRootPart.CFrame + l_On_292.HumanoidRootPart.CFrame.LookVector * 5 - v0.Vector3.new(0, 2, 0)) * v0.CFrame.Angles(0, v0.math.pi, 0);
--				v3504.Parent = l_VFX_0;
--				local v3505 = v0.Vector3.new(0, -7, 0);
--				local v3506 = workspace:Raycast(v3503.Position, v3505, v72);
--				local v3507 = workspace:Raycast(v3504.Position, v3505, v72);
--				if v3506 then
--					for _, v3509 in v0.pairs(v3503:GetDescendants()) do
--						if v3509:IsA("ParticleEmitter") and v3509.Name == "Smoke" then
--							v3509.Color = v0.ColorSequence.new(VFXService.MakeDarker(v3506.Instance.Color, 42.5, 42.5, 42.5));
--						end;
--					end;
--				end;
--				if v3507 then
--					for _, v3511 in v0.pairs(v3504:GetDescendants()) do
--						if v3511:IsA("ParticleEmitter") and v3511.Name == "Smoke" then
--							v3511.Color = v0.ColorSequence.new(VFXService.MakeDarker(v3507.Instance.Color, 42.5, 42.5, 42.5));
--						end;
--					end;
--				end;
--				VFXService.EmitParticlesInInstance(v3503);
--				VFXService.EmitParticlesInInstance(v3504);
--				VFXService.DestroyParticleContainer(v3503, 2.5);
--				VFXService.DestroyParticleContainer(v3504, 2.5);
--				v104.PlaySoundInInstance(l_On_292.HumanoidRootPart, "PantherComboHit4");
--			end;
--		end;
--		if l_Request_1 == "PantherComboHit5" then
--			local l_On_293 = v724.On;
--			if not (l_On_293 ~= nil) or l_On_293.Parent == nil then
--				return;
--			else
--				local v3513 = l_Assets_0.Particles.MartialArtist.PantherCombo.Hit:Clone();
--				v3513.CFrame = (l_On_293.HumanoidRootPart.CFrame + l_On_293.HumanoidRootPart.CFrame.LookVector * 4) * v0.CFrame.Angles(0, v0.math.pi, 0);
--				v3513.Parent = l_VFX_0;
--				local v3514 = l_Assets_0.Particles.MartialArtist.PantherCombo.Back:Clone();
--				v3514.CFrame = (l_On_293.HumanoidRootPart.CFrame + l_On_293.HumanoidRootPart.CFrame.LookVector * 5 - v0.Vector3.new(0, 2, 0)) * v0.CFrame.Angles(0, v0.math.pi, 0);
--				v3514.Parent = l_VFX_0;
--				local v3515 = v0.Vector3.new(0, -7, 0);
--				local v3516 = workspace:Raycast(v3513.Position, v3515, v72);
--				local v3517 = workspace:Raycast(v3514.Position, v3515, v72);
--				if v3516 then
--					for _, v3519 in v0.pairs(v3513:GetDescendants()) do
--						if v3519:IsA("ParticleEmitter") and v3519.Name == "Smoke" then
--							v3519.Color = v0.ColorSequence.new(VFXService.MakeDarker(v3516.Instance.Color, 42.5, 42.5, 42.5));
--						end;
--					end;
--				end;
--				if v3517 then
--					for _, v3521 in v0.pairs(v3514:GetDescendants()) do
--						if v3521:IsA("ParticleEmitter") and v3521.Name == "Smoke" then
--							v3521.Color = v0.ColorSequence.new(VFXService.MakeDarker(v3517.Instance.Color, 42.5, 42.5, 42.5));
--						end;
--					end;
--				end;
--				VFXService.EmitParticlesInInstance(v3513);
--				VFXService.EmitParticlesInInstance(v3514);
--				VFXService.DestroyParticleContainer(v3513, 2.5);
--				VFXService.DestroyParticleContainer(v3514, 2.5);
--				v104.PlaySoundInInstance(l_On_293.HumanoidRootPart, "PantherComboHit5");
--			end;
--		end;
--		if l_Request_1 == "PantherComboHit6" then
--			local l_On_294 = v724.On;
--			if not (l_On_294 ~= nil) or l_On_294.Parent == nil then
--				return;
--			else
--				local v3523 = l_Assets_0.Particles.MartialArtist.PantherCombo.Hit:Clone();
--				v3523.CFrame = (l_On_294.HumanoidRootPart.CFrame + l_On_294.HumanoidRootPart.CFrame.LookVector * 4) * v0.CFrame.Angles(0, v0.math.pi, 0);
--				v3523.Parent = l_VFX_0;
--				local v3524 = l_Assets_0.Particles.MartialArtist.PantherCombo.Back:Clone();
--				v3524.CFrame = (l_On_294.HumanoidRootPart.CFrame + l_On_294.HumanoidRootPart.CFrame.LookVector * 5 - v0.Vector3.new(0, 2, 0)) * v0.CFrame.Angles(0, v0.math.pi, 0);
--				v3524.Parent = l_VFX_0;
--				local v3525 = v0.Vector3.new(0, -7, 0);
--				local v3526 = workspace:Raycast(v3523.Position, v3525, v72);
--				local v3527 = workspace:Raycast(v3524.Position, v3525, v72);
--				if v3526 then
--					for _, v3529 in v0.pairs(v3523:GetDescendants()) do
--						if v3529:IsA("ParticleEmitter") and v3529.Name == "Smoke" then
--							v3529.Color = v0.ColorSequence.new(VFXService.MakeDarker(v3526.Instance.Color, 42.5, 42.5, 42.5));
--						end;
--					end;
--				end;
--				if v3527 then
--					for _, v3531 in v0.pairs(v3524:GetDescendants()) do
--						if v3531:IsA("ParticleEmitter") and v3531.Name == "Smoke" then
--							v3531.Color = v0.ColorSequence.new(VFXService.MakeDarker(v3527.Instance.Color, 42.5, 42.5, 42.5));
--						end;
--					end;
--				end;
--				VFXService.EmitParticlesInInstance(v3523);
--				VFXService.EmitParticlesInInstance(v3524);
--				VFXService.DestroyParticleContainer(v3523, 2.5);
--				VFXService.DestroyParticleContainer(v3524, 2.5);
--				v104.PlaySoundInInstance(l_On_294.HumanoidRootPart, "PantherComboHit6");
--			end;
--		end;
--		if l_Request_1 == "PantherComboHit7" then
--			local l_On_295 = v724.On;
--			if not (l_On_295 ~= nil) or l_On_295.Parent == nil then
--				return;
--			else
--				local v3533 = l_Assets_0.Particles.MartialArtist.PantherCombo.Hit:Clone();
--				v3533.CFrame = (l_On_295.HumanoidRootPart.CFrame + l_On_295.HumanoidRootPart.CFrame.LookVector * 4) * v0.CFrame.Angles(0, v0.math.pi, 0);
--				v3533.Parent = l_VFX_0;
--				local v3534 = l_Assets_0.Particles.MartialArtist.PantherCombo.Back:Clone();
--				v3534.CFrame = (l_On_295.HumanoidRootPart.CFrame + l_On_295.HumanoidRootPart.CFrame.LookVector * 5 - v0.Vector3.new(0, 2, 0)) * v0.CFrame.Angles(0, v0.math.pi, 0);
--				v3534.Parent = l_VFX_0;
--				local v3535 = v0.Vector3.new(0, -7, 0);
--				local v3536 = workspace:Raycast(v3533.Position, v3535, v72);
--				local v3537 = workspace:Raycast(v3534.Position, v3535, v72);
--				if v3536 then
--					for _, v3539 in v0.pairs(v3533:GetDescendants()) do
--						if v3539:IsA("ParticleEmitter") and v3539.Name == "Smoke" then
--							v3539.Color = v0.ColorSequence.new(VFXService.MakeDarker(v3536.Instance.Color, 42.5, 42.5, 42.5));
--						end;
--					end;
--				end;
--				if v3537 then
--					for _, v3541 in v0.pairs(v3534:GetDescendants()) do
--						if v3541:IsA("ParticleEmitter") and v3541.Name == "Smoke" then
--							v3541.Color = v0.ColorSequence.new(VFXService.MakeDarker(v3537.Instance.Color, 42.5, 42.5, 42.5));
--						end;
--					end;
--				end;
--				VFXService.EmitParticlesInInstance(v3533);
--				VFXService.EmitParticlesInInstance(v3534);
--				VFXService.DestroyParticleContainer(v3533, 2.5);
--				VFXService.DestroyParticleContainer(v3534, 2.5);
--				v104.PlaySoundInInstance(l_On_295.HumanoidRootPart, "PantherComboHit7");
--			end;
--		end;
--		if l_Request_1 == "PantherComboHit8" then
--			local l_On_296 = v724.On;
--			if not (l_On_296 ~= nil) or l_On_296.Parent == nil then
--				return;
--			else
--				local v3543 = l_Assets_0.Particles.MartialArtist.PantherCombo.Hit:Clone();
--				v3543.CFrame = (l_On_296.HumanoidRootPart.CFrame + l_On_296.HumanoidRootPart.CFrame.LookVector * 4) * v0.CFrame.Angles(0, v0.math.pi, 0);
--				v3543.Parent = l_VFX_0;
--				local v3544 = l_Assets_0.Particles.MartialArtist.PantherCombo.Back:Clone();
--				v3544.CFrame = (l_On_296.HumanoidRootPart.CFrame + l_On_296.HumanoidRootPart.CFrame.LookVector * 5 - v0.Vector3.new(0, 2, 0)) * v0.CFrame.Angles(0, v0.math.pi, 0);
--				v3544.Parent = l_VFX_0;
--				local v3545 = v0.Vector3.new(0, -7, 0);
--				local v3546 = workspace:Raycast(v3543.Position, v3545, v72);
--				local v3547 = workspace:Raycast(v3544.Position, v3545, v72);
--				if v3546 then
--					for _, v3549 in v0.pairs(v3543:GetDescendants()) do
--						if v3549:IsA("ParticleEmitter") and v3549.Name == "Smoke" then
--							v3549.Color = v0.ColorSequence.new(VFXService.MakeDarker(v3546.Instance.Color, 42.5, 42.5, 42.5));
--						end;
--					end;
--				end;
--				if v3547 then
--					for _, v3551 in v0.pairs(v3544:GetDescendants()) do
--						if v3551:IsA("ParticleEmitter") and v3551.Name == "Smoke" then
--							v3551.Color = v0.ColorSequence.new(VFXService.MakeDarker(v3547.Instance.Color, 42.5, 42.5, 42.5));
--						end;
--					end;
--				end;
--				VFXService.EmitParticlesInInstance(v3543);
--				VFXService.EmitParticlesInInstance(v3544);
--				VFXService.DestroyParticleContainer(v3543, 2.5);
--				VFXService.DestroyParticleContainer(v3544, 2.5);
--				v104.PlaySoundInInstance(l_On_296.HumanoidRootPart, "PantherComboHit8");
--			end;
--		end;
--		if l_Request_1 == "PantherComboHit9" then
--			local l_On_297 = v724.On;
--			if not (l_On_297 ~= nil) or l_On_297.Parent == nil then
--				return;
--			else
--				local v3553 = l_Assets_0.Particles.MartialArtist.PantherCombo.Hit:Clone();
--				v3553.CFrame = (l_On_297.HumanoidRootPart.CFrame + l_On_297.HumanoidRootPart.CFrame.LookVector * 4) * v0.CFrame.Angles(0, v0.math.pi, 0);
--				v3553.Parent = l_VFX_0;
--				local v3554 = l_Assets_0.Particles.MartialArtist.PantherCombo.Back:Clone();
--				v3554.CFrame = (l_On_297.HumanoidRootPart.CFrame + l_On_297.HumanoidRootPart.CFrame.LookVector * 5 - v0.Vector3.new(0, 2, 0)) * v0.CFrame.Angles(0, v0.math.pi, 0);
--				v3554.Parent = l_VFX_0;
--				local v3555 = v0.Vector3.new(0, -7, 0);
--				local v3556 = workspace:Raycast(v3553.Position, v3555, v72);
--				local v3557 = workspace:Raycast(v3554.Position, v3555, v72);
--				if v3556 then
--					for _, v3559 in v0.pairs(v3553:GetDescendants()) do
--						if v3559:IsA("ParticleEmitter") and v3559.Name == "Smoke" then
--							v3559.Color = v0.ColorSequence.new(VFXService.MakeDarker(v3556.Instance.Color, 42.5, 42.5, 42.5));
--						end;
--					end;
--				end;
--				if v3557 then
--					for _, v3561 in v0.pairs(v3554:GetDescendants()) do
--						if v3561:IsA("ParticleEmitter") and v3561.Name == "Smoke" then
--							v3561.Color = v0.ColorSequence.new(VFXService.MakeDarker(v3557.Instance.Color, 42.5, 42.5, 42.5));
--						end;
--					end;
--				end;
--				VFXService.EmitParticlesInInstance(v3553);
--				VFXService.EmitParticlesInInstance(v3554);
--				VFXService.DestroyParticleContainer(v3553, 2.5);
--				VFXService.DestroyParticleContainer(v3554, 2.5);
--				v104.PlaySoundInInstance(l_On_297.HumanoidRootPart, "PantherComboHit9");
--			end;
--		end;
--		if l_Request_1 == "PantherComboHit10" then
--			local l_On_298 = v724.On;
--			if not (l_On_298 ~= nil) or l_On_298.Parent == nil then
--				return;
--			else
--				local v3563 = l_Assets_0.Particles.MartialArtist.PantherCombo.Hit:Clone();
--				v3563.CFrame = (l_On_298.HumanoidRootPart.CFrame + l_On_298.HumanoidRootPart.CFrame.LookVector * 4) * v0.CFrame.Angles(0, v0.math.pi, 0);
--				v3563.Parent = l_VFX_0;
--				local v3564 = l_Assets_0.Particles.MartialArtist.PantherCombo.Back:Clone();
--				v3564.CFrame = (l_On_298.HumanoidRootPart.CFrame + l_On_298.HumanoidRootPart.CFrame.LookVector * 5 - v0.Vector3.new(0, 2, 0)) * v0.CFrame.Angles(0, v0.math.pi, 0);
--				v3564.Parent = l_VFX_0;
--				local v3565 = v0.Vector3.new(0, -7, 0);
--				local v3566 = workspace:Raycast(v3563.Position, v3565, v72);
--				local v3567 = workspace:Raycast(v3564.Position, v3565, v72);
--				if v3566 then
--					for _, v3569 in v0.pairs(v3563:GetDescendants()) do
--						if v3569:IsA("ParticleEmitter") and v3569.Name == "Smoke" then
--							v3569.Color = v0.ColorSequence.new(VFXService.MakeDarker(v3566.Instance.Color, 42.5, 42.5, 42.5));
--						end;
--					end;
--				end;
--				if v3567 then
--					for _, v3571 in v0.pairs(v3564:GetDescendants()) do
--						if v3571:IsA("ParticleEmitter") and v3571.Name == "Smoke" then
--							v3571.Color = v0.ColorSequence.new(VFXService.MakeDarker(v3567.Instance.Color, 42.5, 42.5, 42.5));
--						end;
--					end;
--				end;
--				VFXService.EmitParticlesInInstance(v3563);
--				VFXService.EmitParticlesInInstance(v3564);
--				VFXService.DestroyParticleContainer(v3563, 2.5);
--				VFXService.DestroyParticleContainer(v3564, 2.5);
--				v104.PlaySoundInInstance(l_On_298.HumanoidRootPart, "PantherComboHit10");
--			end;
--		end;
--		if l_Request_1 == "PantherComboMiss1" then
--			local l_On_299 = v724.On;
--			if not (l_On_299 ~= nil) or l_On_299.Parent == nil then
--				return;
--			else
--				local l_Children_7 = l_Assets_0.Particles.MartialArtist.PantherCombo.Miss:GetChildren();
--				local v3574 = l_On_299.HumanoidRootPart.CFrame + l_On_299.HumanoidRootPart.CFrame.LookVector * 6;
--				VFXService.EmitFromCFrame(v3574, l_Children_7);
--			end;
--		end;
--		if l_Request_1 == "PantherComboMiss2" then
--			local l_On_300 = v724.On;
--			if not (l_On_300 ~= nil) or l_On_300.Parent == nil then
--				return;
--			else
--				local l_Children_8 = l_Assets_0.Particles.MartialArtist.PantherCombo.Miss:GetChildren();
--				local v3577 = (l_On_300.HumanoidRootPart.CFrame + l_On_300.HumanoidRootPart.CFrame.LookVector * 5 + v0.Vector3.new(0, 1.3, 0)) * v0.CFrame.Angles(v0.math.pi / 2, 0, 0);
--				VFXService.EmitFromCFrame(v3577, l_Children_8);
--			end;
--		end;
--		if l_Request_1 == "PantherComboUppercut" then
--			local l_On_301 = v724.On;
--			if not (l_On_301 ~= nil) or l_On_301.Parent == nil then
--				return;
--			else
--				local v3579 = l_Assets_0.Particles.MartialArtist.PantherCombo.Uppercut:Clone();
--				v3579.Parent = l_VFX_0;
--				local v3580 = VFXService.FindGroundPosition(l_On_301.HumanoidRootPart.Position, 15);
--				if v3580 then
--					v3579.Position = v3580.Position + v0.Vector3.new(0, 0.1, 0);
--					for _, v3582 in v0.pairs(v3579:GetDescendants()) do
--						if v3582:IsA("ParticleEmitter") and v3582.Name == "Smoke" then
--							v3582.Color = v0.ColorSequence.new(VFXService.MakeDarker(v3580.Instance.Color, 42.5, 42.5, 42.5));
--						end;
--					end;
--				else
--					v3579.Position = l_On_301.HumanoidRootPart.Position;
--				end;
--				VFXService.EmitParticlesInInstance(v3579);
--				VFXService.DestroyParticleContainer(v3579, 3);
--				v104.PlaySoundInInstance(l_On_301.HumanoidRootPart, "PantherComboHit11");
--			end;
--		end;
--		if l_Request_1 == "JunAwakeningWalk" then
--			for _, v3584 in v0.pairs(l_HumanoidRootPart_0:GetChildren()) do
--				if v3584:IsA("BodyVelocity") then
--					v3584:Destroy();
--				end;
--			end;
--			local v3585 = v0.Instance.new("BodyVelocity");
--			v3585.Name = "JunAwakeningWalk";
--			v3585.Parent = l_HumanoidRootPart_0;
--			v3585.MaxForce = v0.Vector3.new(70000, 0, 70000);
--			local v3586 = v0.Instance.new("NumberValue");
--			v3586.Name = "Magnitude";
--			v3586.Parent = v3585;
--			v3586.Value = 5;
--			local l_v3585_0 = v3585 --[[ copy: 2 -> 152 ]];
--			local l_v3586_0 = v3586 --[[ copy: 3 -> 153 ]];
--			v0.task.spawn(function()
--				while l_v3585_0 ~= nil and l_v3585_0.Parent ~= nil do
--					l_v3585_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * l_v3586_0.Value;
--					v0.task.wait();
--				end;
--			end);
--		end;
--		if l_Request_1 == "EndJunAwakeningWalk" then
--			for _, v3590 in v0.pairs(l_HumanoidRootPart_0:GetChildren()) do
--				if v3590:IsA("BodyVelocity") then
--					if v3590.Name == "JunAwakeningWalk" then
--						local l_Magnitude_4 = v3590:FindFirstChild("Magnitude");
--						if l_Magnitude_4 ~= nil and l_Magnitude_4.Parent ~= nil then
--							local v3592 = l_TweenService_0:Create(l_Magnitude_4, v0.TweenInfo.new(2.4, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
--								Value = 0
--							});
--							v3592.Completed:Once(function()
--								if v3590 ~= nil and v3590.Parent ~= nil then
--									v3590:Destroy();
--								end;
--							end);
--							v3592:Play();
--						else
--							v3590:Destroy();
--						end;
--					else
--						v3590:Destroy();
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "VirguleDash2" then
--			for _, v3594 in v0.pairs(l_HumanoidRootPart_0:GetChildren()) do
--				if v3594:IsA("BodyVelocity") then
--					v3594:Destroy();
--				end;
--			end;
--			local v3595 = v0.Instance.new("BodyVelocity");
--			v3595.Name = "VirguleDash";
--			v3595.Parent = l_HumanoidRootPart_0;
--			v3595.MaxForce = v0.Vector3.new(70000, 0, 70000);
--			local l_v3595_0 = v3595 --[[ copy: 2 -> 150 ]];
--			v0.task.spawn(function()
--				while l_v3595_0 ~= nil and l_v3595_0.Parent ~= nil do
--					l_v3595_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * 16;
--					v0.task.wait();
--				end;
--			end);
--			local v3597 = VFXService.CreateBind(v26, "PantherComboDash", function()
--				if l_v3595_0 ~= nil and l_v3595_0.Parent ~= nil then
--					l_v3595_0:Destroy();
--				end;
--			end);
--			local l_v3597_0 = v3597 --[[ copy: 3 -> 151 ]];
--			v0.task.delay(0.1, function()
--				if l_v3597_0 ~= nil and l_v3597_0.Parent ~= nil then
--					l_v3597_0:Destroy();
--				end;
--			end);
--		end;
--		if l_Request_1 == "VirguleDash" then
--			for _, v3600 in v0.pairs(l_HumanoidRootPart_0:GetChildren()) do
--				if v3600:IsA("BodyVelocity") then
--					v3600:Destroy();
--				end;
--			end;
--			local v3601 = v0.Instance.new("BodyVelocity");
--			v3601.Name = "VirguleDash";
--			v3601.Parent = l_HumanoidRootPart_0;
--			v3601.MaxForce = v0.Vector3.new(70000, 0, 70000);
--			local l_v3601_0 = v3601 --[[ copy: 2 -> 148 ]];
--			v0.task.spawn(function()
--				while l_v3601_0 ~= nil and l_v3601_0.Parent ~= nil do
--					l_v3601_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * 10;
--					v0.task.wait();
--				end;
--			end);
--			local v3603 = VFXService.CreateBind(v26, "PantherComboDash", function()
--				if l_v3601_0 ~= nil and l_v3601_0.Parent ~= nil then
--					l_v3601_0:Destroy();
--				end;
--			end);
--			local l_v3603_0 = v3603 --[[ copy: 3 -> 149 ]];
--			v0.task.delay(0.1, function()
--				if l_v3603_0 ~= nil and l_v3603_0.Parent ~= nil then
--					l_v3603_0:Destroy();
--				end;
--			end);
--		end;
--		if l_Request_1 == "PantherComboDash" then
--			for _, v3606 in v0.pairs(l_HumanoidRootPart_0:GetChildren()) do
--				if v3606:IsA("BodyVelocity") then
--					v3606:Destroy();
--				end;
--			end;
--			local v3607 = v0.Instance.new("BodyVelocity");
--			v3607.Name = "PantherComboDash";
--			v3607.Parent = l_HumanoidRootPart_0;
--			v3607.MaxForce = v0.Vector3.new(70000, 0, 70000);
--			local l_v3607_0 = v3607 --[[ copy: 2 -> 146 ]];
--			v0.task.spawn(function()
--				while l_v3607_0 ~= nil and l_v3607_0.Parent ~= nil do
--					l_v3607_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * 15;
--					v0.task.wait();
--				end;
--			end);
--			local v3609 = VFXService.CreateBind(v26, "PantherComboDash", function()
--				if l_v3607_0 ~= nil and l_v3607_0.Parent ~= nil then
--					l_v3607_0:Destroy();
--				end;
--			end);
--			local l_v3609_0 = v3609 --[[ copy: 3 -> 147 ]];
--			v0.task.delay(0.1, function()
--				if l_v3609_0 ~= nil and l_v3609_0.Parent ~= nil then
--					l_v3609_0:Destroy();
--				end;
--			end);
--		end;
--		if l_Request_1 == "DragonRushPunch" then
--			local v3611 = v724.At * v0.CFrame.Angles(0, v0.math.pi, 0);
--			local v3612 = l_Assets_0.Particles.MartialArtist.DragonRush.Default.Punch:Clone();
--			v3612.CFrame = v3611;
--			local v3613 = l_Assets_0.Parts.MartialArtist.DragonRush.Default.Punch:Clone();
--			local v3614 = v3611 * v0.CFrame.Angles(-v0.math.pi / 4, 0, 0);
--			v3613.CFrame = v3614 + v3614.UpVector * 20;
--			local v3615 = v0.TweenInfo.new(0.4, v0.Enum.EasingStyle.Circular, v0.Enum.EasingDirection.Out);
--			local v3616 = l_TweenService_0:Create(v3613.Black, v3615, {
--				Transparency = 1
--			});
--			local v3617 = l_TweenService_0:Create(v3613.White, v3615, {
--				Transparency = 1
--			});
--			local v3618 = l_TweenService_0:Create(v3613.Mesh, v3615, {
--				Scale = v0.Vector3.new(0, 70, 0)
--			});
--			local l_v3613_0 = v3613 --[[ copy: 4 -> 145 ]];
--			v3616.Completed:Connect(function()
--				if l_v3613_0 ~= nil and l_v3613_0.Parent ~= nil then
--					l_v3613_0:Destroy();
--				end;
--			end);
--			v3613.Parent = l_VFX_0;
--			v3612.Parent = l_VFX_0;
--			VFXService.EmitParticlesInInstance(v3612);
--			VFXService.DestroyParticleContainer(v3612);
--			v3616:Play();
--			v3617:Play();
--			v3618:Play();
--			if (v3611.Position - l_HumanoidRootPart_0.Position).Magnitude <= 20 then
--				VFXService.ShakeCamera(0.1, 0.1, 23, 0.4, 0.4, 0.4);
--			end;
--		end;
--		if l_Request_1 == "DragonRushSwing" then
--			local l_On_302 = v724.On;
--			if not (l_On_302 ~= nil) or l_On_302.Parent == nil then
--				return;
--			else
--				local v3621 = v0.Vector3.new(l_On_302.HumanoidRootPart.CFrame.LookVector.X, 0, l_On_302.HumanoidRootPart.CFrame.LookVector.Z);
--				local v3622 = v0.CFrame.new(l_On_302.HumanoidRootPart.Position, l_On_302.HumanoidRootPart.Position + v3621);
--				local v3623 = l_Assets_0.Particles.MartialArtist.DragonRush.Default.Swing:Clone();
--				v3623.CFrame = v3622;
--				local v3624 = VFXService.FindGroundPosition(v3623.Position, 5);
--				if v3624 then
--					local v3625 = VFXService.MakeDarker(v3624.Instance.Color, 45, 45, 45);
--					for _, v3627 in v0.pairs(v3623:GetDescendants()) do
--						if v3627:IsA("ParticleEmitter") and (not (v3627.Name ~= "Smoke") or v3627.Name == "Dust") then
--							v3627.Color = v0.ColorSequence.new(v3625);
--						end;
--					end;
--				end;
--				local v3628 = l_Assets_0.Parts.MartialArtist.DragonRush.Default.Swing:Clone();
--				v3628.CFrame = v3622 * v0.CFrame.Angles(0, v0.math.pi / 2, v0.math.pi / 2) + v0.Vector3.new(0, 5.5, 0);
--				local v3629 = v0.TweenInfo.new(0.4, v0.Enum.EasingStyle.Circular, v0.Enum.EasingDirection.Out);
--				local v3630 = l_TweenService_0:Create(v3628.Decal, v3629, {
--					Transparency = 1
--				});
--				local v3631 = l_TweenService_0:Create(v3628.Mesh, v3629, {
--					Scale = v0.Vector3.new(0.3, 0.65, 0.65)
--				});
--				local v3632 = l_TweenService_0:Create(v3628, v3629, {
--					Position = v3628.Position - v0.Vector3.new(0, 4, 0)
--				});
--				local l_v3628_0 = v3628 --[[ copy: 7 -> 144 ]];
--				v3630.Completed:Connect(function()
--					if l_v3628_0 ~= nil and l_v3628_0.Parent ~= nil then
--						l_v3628_0:Destroy();
--					end;
--				end);
--				v3623.Parent = l_VFX_0;
--				v3628.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3623);
--				v3630:Play();
--				v3631:Play();
--				v3632:Play();
--				VFXService.DestroyParticleContainer(v3623);
--			end;
--		end;
--		if l_Request_1 == "DragonRushFinisherCrater1" then
--			local v3634 = v724.At * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0);
--			local l_Magnitude_5 = (v3634.Position - l_HumanoidRootPart_0.Position).Magnitude;
--			local v3636 = {};
--			local v3637 = {};
--			local v3638 = VFXService.FindGroundPosition(v3634.Position, 10);
--			VFXService.GetCircularRocksProperties(v3636, v3634, {
--				4, 
--				9
--			}, v0.math.random(6, 8), {
--				2, 
--				4.5
--			}, {
--				0.65, 
--				1
--			}, {
--				1, 
--				1.5
--			}, {
--				-5, 
--				5
--			}, {
--				-5, 
--				5
--			}, {
--				-5, 
--				5
--			}, {
--				"Grow", 
--				"Sink"
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetCircularRocksProperties(v3636, v3634 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--				4, 
--				9
--			}, v0.math.random(6, 8), {
--				3, 
--				4
--			}, {
--				1, 
--				1.5
--			}, {
--				1.75, 
--				2.25
--			}, {
--				-5, 
--				5
--			}, {
--				-5, 
--				5
--			}, {
--				-5, 
--				5
--			}, {
--				"Grow", 
--				"Sink"
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetFlyingRocksProperties(v3637, v3634, v0.math.random(4, 5), {
--				10, 
--				30
--			}, {
--				80, 
--				80
--			}, {
--				10, 
--				30
--			}, 1, 1, 1, 4);
--			VFXService.GetFlyingRocksProperties(v3637, v3634, v0.math.random(2, 3), {
--				10, 
--				30
--			}, {
--				80, 
--				80
--			}, {
--				10, 
--				30
--			}, 1.5, 1.5, 1.5, 4);
--			VFXService.GetFlyingRocksProperties(v3637, v3634, v0.math.random(2, 3), {
--				10, 
--				30
--			}, {
--				80, 
--				80
--			}, {
--				10, 
--				30
--			}, 1.3, 1.3, 1.3, 4);
--			local v3639 = VFXService.GetTile(v3634.Position + v0.Vector3.new(0, 1.5, 0));
--			VFXService.ApplyCircularRocksProperties(v3636);
--			VFXService.ApplyFlyingRocksProperties(v3637);
--			if v3638 then
--				local v3640 = l_Assets_0.Particles.MartialArtist.DragonRush.Finisher.FinisherCrater1:Clone();
--				v3640.Position = v3638.Position + v0.Vector3.new(0, 0.1, 0);
--				local v3641 = VFXService.MakeDarker(v3638.Instance.Color, 45, 45, 45);
--				for _, v3643 in v0.pairs(v3640:GetDescendants()) do
--					if v3643:IsA("ParticleEmitter") and (not (v3643.Name ~= "Smoke") or v3643.Name == "Dust") then
--						v3643.Color = v0.ColorSequence.new(v3641);
--					end;
--				end;
--				v3640.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3640);
--				VFXService.DestroyParticleContainer(v3640);
--				VFXService.DestroyTile(v3639);
--			end;
--			v104.PlaySoundAtCFrame(v3634, "DragonRushFinisherCrater1");
--			if l_Magnitude_5 <= 50 then
--				VFXService.ShakeCamera(0.1, 0.3, 26, 0.4, 0.52, 0.4);
--			end;
--		end;
--		if l_Request_1 == "DragonRushFinisherCrater2" then
--			local v3644 = v724.At * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0);
--			local l_Magnitude_6 = (v3644.Position - l_HumanoidRootPart_0.Position).Magnitude;
--			local v3646 = {};
--			local v3647 = {};
--			local v3648 = VFXService.FindGroundPosition(v3644.Position, 10);
--			VFXService.GetFlyingRocksProperties(v3647, v3644, v0.math.random(4, 5), {
--				10, 
--				30
--			}, {
--				80, 
--				60
--			}, {
--				10, 
--				30
--			}, 1, 1, 1, 4);
--			VFXService.GetFlyingRocksProperties(v3647, v3644, v0.math.random(2, 3), {
--				10, 
--				30
--			}, {
--				80, 
--				60
--			}, {
--				10, 
--				30
--			}, 1.5, 1.5, 1.5, 4);
--			VFXService.GetFlyingRocksProperties(v3647, v3644, v0.math.random(2, 3), {
--				10, 
--				30
--			}, {
--				80, 
--				60
--			}, {
--				10, 
--				30
--			}, 1.3, 1.3, 1.3, 4);
--			VFXService.GetCircularRocksProperties(v3646, v3644 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--				2.5, 
--				5
--			}, 5, {
--				2.5, 
--				3
--			}, {
--				0.7, 
--				1
--			}, {
--				0.7, 
--				1
--			}, {
--				-2, 
--				2
--			}, {
--				-2, 
--				2
--			}, {
--				-2, 
--				2
--			}, {
--				"Grow", 
--				"Sink"
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetCircularRocksProperties(v3646, v3644, {
--				10, 
--				15
--			}, v0.math.random(5, 6), {
--				5, 
--				8.5
--			}, {
--				1.5, 
--				1.75
--			}, {
--				1.5, 
--				1.75
--			}, {
--				-5, 
--				5
--			}, {
--				-5, 
--				5
--			}, {
--				-5, 
--				5
--			}, {
--				"Grow", 
--				"Sink"
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			local v3649 = VFXService.GetTile(v3644.Position + v0.Vector3.new(0, 1.5, 0));
--			VFXService.ApplyFlyingRocksProperties(v3647);
--			VFXService.ApplyCircularRocksProperties(v3646);
--			if v3648 then
--				local v3650 = l_Assets_0.Particles.MartialArtist.DragonRush.Finisher.FinisherCrater2:Clone();
--				v3650.Position = v3648.Position + v0.Vector3.new(0, 0.1, 0);
--				local v3651 = VFXService.MakeDarker(v3648.Instance.Color, 45, 45, 45);
--				for _, v3653 in v0.pairs(v3650:GetDescendants()) do
--					if v3653:IsA("ParticleEmitter") and (not (v3653.Name ~= "Smoke") or v3653.Name == "Dust") then
--						v3653.Color = v0.ColorSequence.new(v3651);
--					end;
--				end;
--				v3650.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3650);
--				VFXService.DestroyParticleContainer(v3650);
--				VFXService.DestroyTile(v3649);
--			end;
--			v104.PlaySoundAtCFrame(v3644, "DragonRushFinisherCrater2");
--			if l_Magnitude_6 <= 50 then
--				VFXService.ShakeCamera(0, 0.3, 20, 0.43, 0.55, 0.43);
--			end;
--		end;
--		if l_Request_1 == "DragonRushFinisherCrater3" then
--			local v3654 = v724.At * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0);
--			local l_Magnitude_7 = (v3654.Position - l_HumanoidRootPart_0.Position).Magnitude;
--			local v3656 = {};
--			local v3657 = {};
--			local v3658 = VFXService.FindGroundPosition(v3654.Position, 10);
--			VFXService.GetFlyingRocksProperties(v3657, v3654, v0.math.random(4, 5), {
--				10, 
--				30
--			}, {
--				80, 
--				60
--			}, {
--				10, 
--				30
--			}, 1, 1, 1, 4);
--			VFXService.GetFlyingRocksProperties(v3657, v3654, v0.math.random(2, 3), {
--				10, 
--				30
--			}, {
--				80, 
--				60
--			}, {
--				10, 
--				30
--			}, 1.5, 1.5, 1.5, 4);
--			VFXService.GetFlyingRocksProperties(v3657, v3654, v0.math.random(2, 3), {
--				10, 
--				30
--			}, {
--				80, 
--				60
--			}, {
--				10, 
--				30
--			}, 1.3, 1.3, 1.3, 4);
--			VFXService.GetCircularRocksProperties(v3656, v3654, {
--				10, 
--				15
--			}, v0.math.random(8, 9), {
--				7, 
--				10.5
--			}, {
--				2, 
--				2.25
--			}, {
--				2, 
--				2.25
--			}, {
--				-5, 
--				5
--			}, {
--				-5, 
--				5
--			}, {
--				-5, 
--				5
--			}, {
--				"Grow", 
--				"Sink"
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			local v3659 = VFXService.GetTile(v3654.Position + v0.Vector3.new(0, 1.5, 0));
--			VFXService.ApplyFlyingRocksProperties(v3657);
--			VFXService.ApplyCircularRocksProperties(v3656);
--			if v3658 then
--				local v3660 = l_Assets_0.Particles.MartialArtist.DragonRush.Finisher.FinisherCrater3:Clone();
--				v3660.Position = v3658.Position + v0.Vector3.new(0, 0.1, 0);
--				local v3661 = VFXService.MakeDarker(v3658.Instance.Color, 45, 45, 45);
--				for _, v3663 in v0.pairs(v3660:GetDescendants()) do
--					if v3663:IsA("ParticleEmitter") and (not (v3663.Name ~= "Smoke") or v3663.Name == "Dust") then
--						v3663.Color = v0.ColorSequence.new(v3661);
--					end;
--				end;
--				v3660.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3660);
--				VFXService.DestroyParticleContainer(v3660);
--				VFXService.DestroyTile(v3659);
--			end;
--			v104.PlaySoundAtCFrame(v3654, "DragonRushFinisherCrater3");
--			if l_Magnitude_7 <= 50 then
--				VFXService.ShakeCamera(0, 0.3, 20, 0.225, 0.4, 0.225);
--			end;
--		end;
--		if l_Request_1 == "DragonRushFinisherCrater4" then
--			local v3664 = v724.At * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0);
--			local l_Magnitude_8 = (v3664.Position - l_HumanoidRootPart_0.Position).Magnitude;
--			local v3666 = {};
--			local v3667 = {};
--			local v3668 = VFXService.FindGroundPosition(v3664.Position, 10);
--			VFXService.GetFlyingRocksProperties(v3667, v3664, v0.math.random(6, 7), {
--				20, 
--				40
--			}, {
--				90, 
--				60
--			}, {
--				20, 
--				40
--			}, 1, 1, 1, 4);
--			VFXService.GetFlyingRocksProperties(v3667, v3664, v0.math.random(4, 5), {
--				20, 
--				40
--			}, {
--				90, 
--				60
--			}, {
--				20, 
--				40
--			}, 1.5, 1.5, 1.5, 4);
--			VFXService.GetFlyingRocksProperties(v3667, v3664, v0.math.random(3, 4), {
--				20, 
--				40
--			}, {
--				90, 
--				60
--			}, {
--				20, 
--				40
--			}, 1.3, 1.3, 1.3, 4);
--			VFXService.GetCircularRocksProperties(v3666, v3664, {
--				17, 
--				20
--			}, 8, {
--				12, 
--				14
--			}, {
--				2.5, 
--				3.5
--			}, {
--				2.5, 
--				3.5
--			}, {
--				-10, 
--				10
--			}, {
--				-7, 
--				7
--			}, {
--				-10, 
--				10
--			}, {
--				"Grow", 
--				"Sink"
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			local v3669 = VFXService.GetTile(v3664.Position + v0.Vector3.new(0, 1.5, 0));
--			VFXService.ApplyFlyingRocksProperties(v3667);
--			VFXService.ApplyCircularRocksProperties(v3666);
--			if v3668 then
--				local v3670 = l_Assets_0.Particles.MartialArtist.DragonRush.Finisher.FinisherCrater4:Clone();
--				v3670.Position = v3668.Position + v0.Vector3.new(0, 0.1, 0);
--				local v3671 = VFXService.MakeDarker(v3668.Instance.Color, 45, 45, 45);
--				for _, v3673 in v0.pairs(v3670:GetDescendants()) do
--					if v3673:IsA("ParticleEmitter") and (not (v3673.Name ~= "Smoke") or v3673.Name == "Dust") then
--						v3673.Color = v0.ColorSequence.new(v3671);
--					end;
--				end;
--				v3670.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3670);
--				VFXService.DestroyParticleContainer(v3670);
--				VFXService.DestroyTile(v3669);
--			end;
--			v104.PlaySoundAtCFrame(v3664, "DragonRushFinisherCrater4");
--			if l_Magnitude_8 <= 50 then
--				VFXService.ShakeCamera(0.1, 0.4, 25, 0.5, 0.5, 0.5);
--			end;
--		end;
--		if l_Request_1 == "DragonRushDash" then
--			local l_On_303 = v724.On;
--			if not (l_On_303 ~= nil) or l_On_303.Parent == nil then
--				return;
--			else
--				local l_Children_9 = l_Assets_0.Particles.MartialArtist.DragonRush.Dash.Floor:GetChildren();
--				local l_Children_10 = l_Assets_0.Particles.MartialArtist.DragonRush.Dash.RootPart:GetChildren();
--				local v3677 = VFXService.FindGroundPosition(l_On_303.HumanoidRootPart.Position, 8);
--				local v3678 = VFXService.GetTile(l_On_303.HumanoidRootPart.Position + v0.Vector3.new(0, 1, 0));
--				v104.PlaySoundAtCFrame(l_On_303.HumanoidRootPart.Position, "DragonRushDash");
--				if v3677 then
--					local v3679 = v0.Vector3.new(l_On_303.HumanoidRootPart.CFrame.LookVector.X, 0, l_On_303.HumanoidRootPart.CFrame.LookVector.Z);
--					VFXService.EmitFromCFrame(v0.CFrame.new(v3677.Position, v3677.Position + v3679) * v0.CFrame.Angles(0, v0.math.pi, 0), l_Children_9, nil, nil, nil, VFXService.MakeDarker(v3677.Instance.Color, 25, 25, 25));
--					VFXService.DestroyTile(v3678);
--				end;
--				VFXService.EmitFromCFrame(l_On_303.HumanoidRootPart.CFrame, l_Children_10);
--			end;
--		end;
--		if l_Request_1 == "DragonRushDashSwingSound" then
--			local l_On_304 = v724.On;
--			if not (l_On_304 ~= nil) or l_On_304.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_304.HumanoidRootPart, "DragonRushDashSwing");
--			end;
--		end;
--		if l_Request_1 == "DragonRushWindupSound" then
--			local l_On_305 = v724.On;
--			if not (l_On_305 ~= nil) or l_On_305.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_305.HumanoidRootPart, "DragonRushWindup");
--			end;
--		end;
--		if l_Request_1 == "DragonRushAttackerDefaultSound" then
--			local l_On_306 = v724.On;
--			if not (l_On_306 ~= nil) or l_On_306.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_306.HumanoidRootPart, "DragonRushDefaultAttacker");
--			end;
--		end;
--		if l_Request_1 == "DragonRushVictimDefaultSound" then
--			local l_On_307 = v724.On;
--			if not (l_On_307 ~= nil) or l_On_307.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_307.HumanoidRootPart, "DragonRushDefaultVictim");
--			end;
--		end;
--		if l_Request_1 == "DragonRushAttackerFinisherSound" then
--			local l_On_308 = v724.On;
--			if not (l_On_308 ~= nil) or l_On_308.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_308.HumanoidRootPart, "DragonRushFinisherAttacker");
--			end;
--		end;
--		if l_Request_1 == "DragonRushMovement" then
--			for _, v3686 in v0.pairs(l_HumanoidRootPart_0:GetChildren()) do
--				if v3686:IsA("BodyVelocity") then
--					v3686:Destroy();
--				end;
--			end;
--			local v3687 = v0.Instance.new("BodyVelocity");
--			v3687.Name = "DragonRushMovement";
--			v3687.Parent = l_HumanoidRootPart_0;
--			v3687.MaxForce = v0.Vector3.new(50000, 0, 50000);
--			local v3688 = v0.Instance.new("NumberValue");
--			v3688.Value = 135;
--			local l_v3687_0 = v3687 --[[ copy: 2 -> 142 ]];
--			local l_v3688_0 = v3688 --[[ copy: 3 -> 143 ]];
--			v0.task.spawn(function()
--				while l_v3687_0 ~= nil and l_v3687_0.Parent ~= nil do
--					l_v3687_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * (l_v3688_0.Value or 0);
--					v0.task.wait();
--				end;
--			end);
--			l_TweenService_0:Create(v3688, v0.TweenInfo.new(0.75, v0.Enum.EasingStyle.Linear, v0.Enum.EasingDirection.Out), {
--				Value = 0
--			}):Play();
--			VFXService.CreateBind(v26, "DragonRushMovement", function()
--				if l_v3687_0 ~= nil and l_v3687_0.Parent ~= nil then
--					l_v3687_0:Destroy();
--					l_v3688_0:Destroy();
--				end;
--			end);
--		end;
--		if l_Request_1 == "EndDragonRushMovement" then
--			VFXService.DestroyBind(v26, "DragonRushMovement", true);
--		end;
--		if l_Request_1 == "TigerPalmSlash" then
--			local l_On_309 = v724.On;
--			if not (l_On_309 ~= nil) or l_On_309.Parent == nil then
--				return;
--			else
--				local v3692 = l_Assets_0.Parts.MartialArtist.TigerPalmFinisher.Slash:Clone();
--				v3692.CFrame = (l_On_309.HumanoidRootPart.CFrame + l_On_309.HumanoidRootPart.CFrame.LookVector * 6) * v0.CFrame.Angles(0, 0, -v0.math.pi / 2) * v0.CFrame.Angles(0, v0.math.pi / 1.45, 0);
--				local v3693 = v0.TweenInfo.new(0.45, v0.Enum.EasingStyle.Cubic, v0.Enum.EasingDirection.Out);
--				local v3694 = {
--					Transparency = 1
--				};
--				local v3695 = l_TweenService_0:Create(v3692.Colored, v3693, v3694);
--				local v3696 = l_TweenService_0:Create(v3692.Black, v3693, v3694);
--				local v3697 = l_TweenService_0:Create(v3692, v3693, {
--					CFrame = (v3692.CFrame - l_On_309.HumanoidRootPart.CFrame.LookVector * 0.325) * v0.CFrame.Angles(0, -v0.math.pi / 1.3, 0)
--				});
--				local l_v3692_0 = v3692 --[[ copy: 3 -> 141 ]];
--				v3695.Completed:Connect(function()
--					if l_v3692_0 ~= nil and l_v3692_0.Parent ~= nil then
--						l_v3692_0:Destroy();
--					end;
--				end);
--				v3692.Parent = l_VFX_0;
--				v3695:Play();
--				v3696:Play();
--				v3697:Play();
--			end;
--		end;
--		if l_Request_1 == "TigerPalmSuplex" then
--			local l_At_4 = v724.At;
--			local v3700 = {};
--			local v3701 = {};
--			local v3702 = VFXService.FindGroundPosition(l_At_4.Position, 10);
--			VFXService.GetCircularRocksProperties(v3700, l_At_4 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--				12, 
--				16
--			}, 7, {
--				8, 
--				12
--			}, {
--				2.5, 
--				3.5
--			}, {
--				2.5, 
--				3.5
--			}, {
--				-5, 
--				5
--			}, {
--				-5, 
--				5
--			}, {
--				-5, 
--				5
--			}, {
--				"Grow", 
--				"Sink"
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetCircularRocksProperties(v3700, l_At_4 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--				12, 
--				16
--			}, 7, {
--				7, 
--				9
--			}, {
--				1.25, 
--				3.5
--			}, {
--				1.25, 
--				3.5
--			}, {
--				-5, 
--				5
--			}, {
--				-5, 
--				5
--			}, {
--				-5, 
--				5
--			}, {
--				"Grow", 
--				"Sink"
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetCircularRocksProperties(v3700, l_At_4 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--				7, 
--				12
--			}, 5, {
--				4, 
--				5
--			}, {
--				1.25, 
--				1.75
--			}, {
--				1.25, 
--				1.75
--			}, {
--				-5, 
--				5
--			}, {
--				-5, 
--				5
--			}, {
--				-5, 
--				5
--			}, {
--				"Grow", 
--				"Sink"
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetCircularRocksProperties(v3700, l_At_4 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--				7, 
--				12
--			}, 5, {
--				4, 
--				5
--			}, {
--				1.25, 
--				1.75
--			}, {
--				1.25, 
--				1.75
--			}, {
--				-5, 
--				5
--			}, {
--				-5, 
--				5
--			}, {
--				-5, 
--				5
--			}, {
--				"Grow", 
--				"Sink"
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetCircularRocksProperties(v3700, l_At_4, {
--				4, 
--				9
--			}, v0.math.random(6, 8), {
--				2, 
--				4.5
--			}, {
--				0.65, 
--				1
--			}, {
--				1, 
--				1.5
--			}, {
--				-5, 
--				5
--			}, {
--				-5, 
--				5
--			}, {
--				-5, 
--				5
--			}, {
--				"Grow", 
--				"Sink"
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetCircularRocksProperties(v3700, l_At_4 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--				4, 
--				9
--			}, v0.math.random(6, 8), {
--				3, 
--				4
--			}, {
--				1, 
--				1.5
--			}, {
--				1.75, 
--				2.25
--			}, {
--				-5, 
--				5
--			}, {
--				-5, 
--				5
--			}, {
--				-5, 
--				5
--			}, {
--				"Grow", 
--				"Sink"
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetFlyingRocksProperties(v3701, l_At_4, 3, {
--				10, 
--				40
--			}, {
--				70, 
--				70
--			}, {
--				10, 
--				40
--			}, 1.5, 1.5, 1.5);
--			VFXService.GetFlyingRocksProperties(v3701, l_At_4, 4, {
--				10, 
--				40
--			}, {
--				70, 
--				70
--			}, {
--				10, 
--				40
--			}, 1.7, 1.7, 1.7);
--			VFXService.GetFlyingRocksProperties(v3701, l_At_4, 3, {
--				10, 
--				40
--			}, {
--				70, 
--				70
--			}, {
--				10, 
--				40
--			}, 1.2, 1.2, 1.2);
--			VFXService.GetFlyingRocksProperties(v3701, l_At_4, 5, {
--				10, 
--				40
--			}, {
--				70, 
--				70
--			}, {
--				10, 
--				40
--			}, 0.8, 0.8, 0.8);
--			VFXService.GetFlyingRocksProperties(v3701, l_At_4, 3, {
--				10, 
--				40
--			}, {
--				70, 
--				70
--			}, {
--				10, 
--				40
--			}, 1.6, 1.6, 1.6);
--			local v3703 = VFXService.GetTile(l_At_4.Position + v0.Vector3.new(0, 1, 0));
--			VFXService.ApplyCircularRocksProperties(v3700);
--			VFXService.ApplyFlyingRocksProperties(v3701);
--			if v3702 then
--				local l_Color_6 = v3702.Instance.Color;
--				local v3705 = v0.CFrame.new(v3702.Position);
--				local v3706 = l_Assets_0.Particles.MartialArtist.TigerPalm.Finisher.SuplexImpact:Clone();
--				v3706.Position = v3702.Position + v0.Vector3.new(0, 0.25, 0);
--				for _, v3708 in v0.pairs(v3706:GetDescendants()) do
--					if v3708:IsA("ParticleEmitter") and v3708.Name == "Smoke" then
--						v3708.Color = v0.ColorSequence.new(l_Color_6);
--					end;
--				end;
--				local v3709 = l_Assets_0.Parts.MartialArtist.TigerPalmFinisher.Shockwave:Clone();
--				v3709.CFrame = v3705 + v0.Vector3.new(0, 0.3, 0);
--				local v3710 = l_TweenService_0:Create(v3709.Mesh, v0.TweenInfo.new(0.115, v0.Enum.EasingStyle.Linear), {
--					Scale = v0.Vector3.new(0, 50, 0)
--				});
--				local l_v3709_0 = v3709 --[[ copy: 10 -> 139 ]];
--				v3710.Completed:Connect(function()
--					if l_v3709_0 ~= nil and l_v3709_0.Parent ~= nil then
--						l_v3709_0:Destroy();
--					end;
--				end);
--				local v3712 = l_TweenService_0:Create(v3709, v0.TweenInfo.new(0.115, v0.Enum.EasingStyle.Linear), {
--					Position = v3709.Position + v0.Vector3.new(0, 17.5, 0)
--				});
--				local v3713 = l_Assets_0.Parts.MartialArtist.TigerPalmFinisher.Wind:Clone();
--				v3713.CFrame = v3705;
--				local v3714 = l_TweenService_0:Create(v3713.Mesh, v0.TweenInfo.new(2.15, v0.Enum.EasingStyle.Cubic, v0.Enum.EasingDirection.Out), {
--					Scale = v0.Vector3.new(23, 52, 23)
--				});
--				local l_v3713_0 = v3713 --[[ copy: 13 -> 140 ]];
--				v3714.Completed:Connect(function()
--					if l_v3713_0 ~= nil and l_v3713_0.Parent ~= nil then
--						l_v3713_0:Destroy();
--					end;
--				end);
--				local v3716 = l_TweenService_0:Create(v3713.Decal, v0.TweenInfo.new(2.15, v0.Enum.EasingStyle.Cubic, v0.Enum.EasingDirection.Out), {
--					Transparency = 1
--				});
--				local v3717 = l_TweenService_0:Create(v3713, v0.TweenInfo.new(2.15, v0.Enum.EasingStyle.Cubic, v0.Enum.EasingDirection.Out), {
--					CFrame = v3713.CFrame * v0.CFrame.Angles(0, v0.math.pi, 0) + v0.Vector3.new(0, 9, 0)
--				});
--				v3706.Parent = l_VFX_0;
--				v3709.Parent = l_VFX_0;
--				v3713.Parent = l_VFX_0;
--				v3710:Play();
--				v3712:Play();
--				v3714:Play();
--				v3716:Play();
--				v3717:Play();
--				VFXService.EmitParticlesInInstance(v3706);
--				VFXService.DestroyParticleContainer(v3706);
--				v104.PlaySoundAtCFrame(v3705, "TigerPalmFinisherCrater");
--				v104.PlaySoundAtCFrame(v3705, "TigerPalmFinisherCrater2");
--				VFXService.DestroyTile(v3703);
--			end;
--			if (l_HumanoidRootPart_0.Position - l_At_4.Position).Magnitude <= 50 then
--				VFXService.ShakeCamera(0.05, 0.45, 28.5, 0.756, 0.756, 0.756);
--			end;
--		end;
--		if l_Request_1 == "PreloadAnimations" then
--			local l_List_0 = v724.List;
--			local l_PreloadAnimationsClient_0 = workspace:WaitForChild("PreloadAnimationsClient");
--			local l_Animator_1 = l_PreloadAnimationsClient_0:WaitForChild("Humanoid"):WaitForChild("Animator");
--			for _, v3722 in v0.pairs(l_List_0) do
--				local v3723 = v0.Instance.new("Animation");
--				v3723.AnimationId = "rbxassetid://" .. v0.tostring(v3722);
--				local v3724 = l_Animator_1:LoadAnimation(v3723);
--				v3723:Destroy();
--				v3724 = nil;
--			end;
--			local l_l_PreloadAnimationsClient_0_0 = l_PreloadAnimationsClient_0 --[[ copy: 3 -> 138 ]];
--			v0.task.delay(5, function()
--				if l_l_PreloadAnimationsClient_0_0 ~= nil and l_l_PreloadAnimationsClient_0_0.Parent ~= nil then
--					l_l_PreloadAnimationsClient_0_0:Destroy();
--				end;
--			end);
--		end;
--		if l_Request_1 == "TigerPalmMiss" then
--			local l_On_310 = v724.On;
--			if not (l_On_310 ~= nil) or l_On_310.Parent == nil then
--				return;
--			else
--				local l_CFrame_48 = l_On_310.HumanoidRootPart.CFrame;
--				local v3728 = l_CFrame_48 + l_CFrame_48.LookVector * 7;
--				local v3729 = l_Assets_0.Particles.MartialArtist.TigerPalm.Miss:Clone();
--				local v3730 = VFXService.FindGroundPosition(v3728.Position, 10);
--				if v3730 then
--					v3728 = v0.CFrame.new(v3730.Position, v3730.Position + l_CFrame_48.LookVector) + v0.Vector3.new(0, v3729.Size.Y / 2, 0);
--				end;
--				v3729.CFrame = v3728;
--				v3729.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3729);
--				VFXService.DestroyParticleContainer(v3729, 3.5);
--			end;
--		end;
--		if l_Request_1 == "VirguleUpStartSound" then
--			local l_On_311 = v724.On;
--			if not (l_On_311 ~= nil) or l_On_311.Parent == nil then
--				return;
--			else
--				local v3732 = v104.PlaySoundInInstance(l_On_311.HumanoidRootPart, "VirguleCascadeAirVariantCast");
--				local v3733 = l_TweenService_0:Create(v3732, v0.TweenInfo.new(0.2, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--					Volume = 0
--				});
--				local l_v3732_0 = v3732 --[[ copy: 3 -> 135 ]];
--				v3733.Completed:Connect(function()
--					if l_v3732_0 ~= nil and l_v3732_0.Parent ~= nil then
--						l_v3732_0:Destroy();
--					end;
--				end);
--				local l_v3733_0 = v3733 --[[ copy: 4 -> 136 ]];
--				local v3736 = VFXService.CreateBind(l_On_311, "VirguleCascadeAirVariantCastSoundBind", function()
--					if l_v3732_0 ~= nil and l_v3732_0.Parent ~= nil then
--						l_v3732_0:SetAttribute("DefaultVolume", nil);
--						l_v3733_0:Play();
--					end;
--				end);
--				local l_v3736_0 = v3736 --[[ copy: 5 -> 137 ]];
--				v3732.Ended:Connect(function()
--					if l_v3736_0 ~= nil and l_v3736_0.Parent ~= nil then
--						l_v3736_0:Destroy();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndVirguleUpStartSound" then
--			local l_On_312 = v724.On;
--			if not (l_On_312 ~= nil) or l_On_312.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_312, "VirguleCascadeAirVariantCastSoundBind");
--			end;
--		end;
--		if l_Request_1 == "TigerPalmMissSound" then
--			local l_On_313 = v724.On;
--			if not (l_On_313 ~= nil) or l_On_313.Parent == nil then
--				return;
--			else
--				local v3740 = v104.PlaySoundInInstance(l_On_313.HumanoidRootPart, "TigerPalmMiss");
--				local v3741 = l_TweenService_0:Create(v3740, v0.TweenInfo.new(0.2, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--					Volume = 0
--				});
--				local l_v3740_0 = v3740 --[[ copy: 3 -> 132 ]];
--				v3741.Completed:Connect(function()
--					if l_v3740_0 ~= nil and l_v3740_0.Parent ~= nil then
--						l_v3740_0:Destroy();
--					end;
--				end);
--				local l_v3741_0 = v3741 --[[ copy: 4 -> 133 ]];
--				local v3744 = VFXService.CreateBind(l_On_313, "TigerPalmMissSoundBind", function()
--					if l_v3740_0 ~= nil and l_v3740_0.Parent ~= nil then
--						l_v3740_0:SetAttribute("DefaultVolume", nil);
--						l_v3741_0:Play();
--					end;
--				end);
--				local l_v3744_0 = v3744 --[[ copy: 5 -> 134 ]];
--				v3740.Ended:Connect(function()
--					if l_v3744_0 ~= nil and l_v3744_0.Parent ~= nil then
--						l_v3744_0:Destroy();
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "EndTigerPalmMissSound" then
--			local l_On_314 = v724.On;
--			if not (l_On_314 ~= nil) or l_On_314.Parent == nil then
--				return;
--			else
--				VFXService.DestroyBind(l_On_314, "TigerPalmMissSoundBind");
--			end;
--		end;
--		if l_Request_1 == "TigerPalmAirSound" then
--			local l_On_315 = v724.On;
--			if not (l_On_315 ~= nil) or l_On_315.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_315.Torso, "TigerPalmFinisherAir");
--			end;
--		end;
--		if l_Request_1 == "TigerPalmHug" then
--			local l_On_316 = v724.On;
--			if not (l_On_316 ~= nil) or l_On_316.Parent == nil then
--				return;
--			else
--				local l_Children_11 = l_Assets_0.Particles.MartialArtist.TigerPalm.Finisher.Hug:GetChildren();
--				VFXService.EmitFromCFrame(l_On_316.Torso.CFrame, l_Children_11);
--				v104.PlaySoundInInstance(l_On_316.Torso, "TigerPalmFinisherHug");
--			end;
--		end;
--		if l_Request_1 == "TigerPalmFinisherHit" then
--			local l_On_317 = v724.On;
--			if not (l_On_317 ~= nil) or l_On_317.Parent == nil then
--				return;
--			else
--				local v3751 = l_On_317.HumanoidRootPart.CFrame + l_On_317.HumanoidRootPart.CFrame.LookVector * 3;
--				local v3752 = VFXService.FindGroundPosition(v3751.Position, 7.5);
--				if v3752 then
--					local l_Color_7 = v3752.Instance.Color;
--					local v3754 = v3751 + v3751.LookVector * 2;
--					local v3755 = VFXService.FindGroundPosition(v3754.Position, 7.5);
--					if v3755 then
--						local v3756 = l_Assets_0.Particles.MartialArtist.TigerPalm.Finisher.Impact:Clone();
--						v3756.CFrame = v0.CFrame.new(v3755.Position, v3755.Position + v3754.LookVector) + v0.Vector3.new(0, v3756.Size.Y / 2, 0);
--						for _, v3758 in v0.pairs(v3756:GetDescendants()) do
--							if v3758:IsA("ParticleEmitter") and v3758.Name == "Smoke" then
--								v3758.Color = v0.ColorSequence.new(l_Color_7);
--							end;
--						end;
--						v3756.Parent = l_VFX_0;
--						VFXService.EmitParticlesInInstance(v3756);
--						v104.PlaySoundAtCFrame(v3754, "TigerPalmFinisherHit");
--						VFXService.DestroyParticleContainer(v3756);
--					end;
--				end;
--				if (v3751.Position - l_HumanoidRootPart_0.Position).Magnitude <= 40 then
--					VFXService.ShakeCamera(0, 0.33, 29, 0.725, 0.75, 0.725);
--				end;
--			end;
--		end;
--		if l_Request_1 == "TigerPalmAfterImages" then
--			local l_On_318 = v724.On;
--			local l_By_0 = v724.By;
--			if not (l_On_318 ~= nil) or l_On_318.Parent == nil then
--				return;
--			else
--				local v3761 = v0.Instance.new("Animation");
--				v3761.AnimationId = "rbxassetid://102687366823314";
--				local v3762 = v0.TweenInfo.new(1.5, v0.Enum.EasingStyle.Cubic, v0.Enum.EasingDirection.Out, 0, false, 0);
--				local v3763 = v0.TweenInfo.new(2, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out, 0, false, 0);
--				local v3764 = l_By_0:GetPivot() * v0.CFrame.Angles(0, v0.math.pi, 0);
--				for v3765 = 1, 4 do
--					local v3766 = l_On_318:Clone();
--					local l_Animator_2 = v3766.Humanoid.Animator;
--					if v3766.Head:FindFirstChild("face") then
--						v3766.Head.face.Transparency = 1;
--					end;
--					if v3766.Head:FindFirstChild("HealthUI") then
--						v3766.Head.HealthUI:Destroy();
--					end;
--					if v3766.Head:FindFirstChild("TitleUI") then
--						v3766.Head.TitleUI:Destroy();
--					end;
--					if v3766.HumanoidRootPart:FindFirstChild("ConsoleLockOnUI") then
--						v3766.HumanoidRootPart.ConsoleLockOnUI:Destroy();
--					end;
--					for _, v3769 in v0.pairs(v3766:GetDescendants()) do
--						if v3769:IsA("BasePart") or v3769:IsA("Decal") then
--							if v3769.Transparency < 1 then
--								v3769.Transparency = 0.2 * v3765;
--								l_TweenService_0:Create(v3769, v3762, {
--									Transparency = 1
--								}):Play();
--							end;
--							if v3769:IsA("BasePart") then
--								v3769.CanCollide = false;
--								v3769.CanTouch = false;
--								v3769.CanQuery = false;
--							end;
--						end;
--						if v3769:IsA("BallSocketConstraint") then
--							v3769:Destroy();
--						end;
--						if v3769:IsA("Motor6D") then
--							v3769.Enabled = true;
--						end;
--					end;
--					v3766:PivotTo(v3764);
--					local v3770 = l_TweenService_0:Create(v3766.HumanoidRootPart, v3763, {
--						CFrame = v3764 - v3764.LookVector * (v3765 * 16)
--					});
--					v3770.Completed:Connect(function()
--						if v3766 ~= nil and v3766.Parent ~= nil then
--							v3766:Destroy();
--						end;
--					end);
--					v3766.Parent = l_VFX_0;
--					local v3771 = l_Animator_2:LoadAnimation(v3761);
--					v3771:GetMarkerReachedSignal("StartLoop"):Connect(function()
--						v3771:AdjustSpeed(0);
--					end);
--					v3771.Priority = v0.Enum.AnimationPriority.Action4;
--					v3771:Play();
--					v3770:Play();
--				end;
--				v3761:Destroy();
--			end;
--		end;
--		if l_Request_1 == "TigerPalmHit" then
--			local l_On_319 = v724.On;
--			if not (l_On_319 ~= nil) or l_On_319.Parent == nil then
--				return;
--			else
--				local v3773 = l_Assets_0.Parts.Ring:Clone();
--				v3773.Size = v0.Vector3.new(5, 3, 5);
--				local l_CFrame_49 = l_On_319.HumanoidRootPart.CFrame;
--				v3773.CFrame = l_CFrame_49 * v0.CFrame.Angles(0, v0.math.pi / 2, v0.math.pi / 2);
--				local v3775 = l_TweenService_0:Create(v3773, v0.TweenInfo.new(0.35, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--					Size = v0.Vector3.new(16, 0, 16), 
--					Transparency = 1
--				});
--				local l_v3773_0 = v3773 --[[ copy: 3 -> 131 ]];
--				v3775.Completed:Connect(function()
--					if l_v3773_0 ~= nil and l_v3773_0.Parent ~= nil then
--						l_v3773_0:Destroy();
--					end;
--				end);
--				local v3777 = (l_CFrame_49 - l_CFrame_49.LookVector * 5) * v0.CFrame.Angles(0, v0.math.pi, 0);
--				local v3778 = l_Assets_0.Particles.MartialArtist.TigerPalm.ParticlePart:Clone();
--				local v3779 = VFXService.FindGroundPosition(v3777.Position, 10);
--				if v3779 then
--					v3777 = v0.CFrame.new(v3779.Position, v3779.Position + v3777.LookVector) + v0.Vector3.new(0, v3778.Size.Y / 2, 0);
--				end;
--				v3778.CFrame = v3777;
--				v3778.Parent = l_VFX_0;
--				local v3780 = l_Assets_0.Particles.MartialArtist.TigerPalm.SmokeParticles:Clone();
--				if not v3779 then
--					v3780:PivotTo(v3777 - l_CFrame_49.LookVector * 20);
--				else
--					v3780:PivotTo(v3777 - l_CFrame_49.LookVector * 20 - v0.Vector3.new(0, v3778.Size.Y / 4, 0));
--				end;
--				v3780.Parent = l_VFX_0;
--				VFXService.EmitParticlesInInstance(v3778);
--				VFXService.EmitParticlesInInstance(v3780);
--				VFXService.DestroyParticleContainer(v3778, 3.5);
--				VFXService.DestroyParticleContainer(v3780, 3.5);
--				v3773.Parent = l_VFX_0;
--				v3775:Play();
--				v104.PlaySoundInInstance(l_On_319.HumanoidRootPart, "TigerPalmHit");
--			end;
--		end;
--		if l_Request_1 == "TripleKickCounterInitiateSound" then
--			local l_On_320 = v724.On;
--			if not (l_On_320 ~= nil) or l_On_320.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_320.HumanoidRootPart, "TripleKickCounterInitiate");
--			end;
--		end;
--		if l_Request_1 == "TripleKickCounterFinisherSound" then
--			local l_On_321 = v724.On;
--			if not (l_On_321 ~= nil) or l_On_321.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_321.HumanoidRootPart, "TripleKickCounterFinisher");
--			end;
--		end;
--		if l_Request_1 == "TripleKickCounterSound" then
--			local l_On_322 = v724.On;
--			if not (l_On_322 ~= nil) or l_On_322.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_322.HumanoidRootPart, "TripleKickCounter");
--			end;
--		end;
--		if l_Request_1 == "TripleKickCounterKick1" then
--			local l_On_323 = v724.On;
--			local l_Color_8 = v724.Color;
--			if not (l_On_323 ~= nil) or l_On_323.Parent == nil then
--				return;
--			else
--				local v3786 = l_Assets_0.Particles.MartialArtist.TripleKickCounter.KickHit.ParticlePart.Attachment:Clone();
--				v3786.Parent = l_On_323.Torso;
--				if typeof(l_Color_8) == "Color3" then
--					for _, v3788 in v0.pairs(v3786:GetDescendants()) do
--						if v3788:IsA("ParticleEmitter") and v3788.Name == "White" then
--							v3788.Color = v0.ColorSequence.new(l_Color_8);
--						end;
--					end;
--				end;
--				VFXService.CheckBloodParticles(v3786);
--				VFXService.EmitParticlesInInstance(v3786);
--				VFXService.DestroyParticleContainer(v3786, 3);
--			end;
--		end;
--		if l_Request_1 == "TripleKickCounterKick2" then
--			local l_On_324 = v724.On;
--			local l_Color_9 = v724.Color;
--			if not (l_On_324 ~= nil) or l_On_324.Parent == nil then
--				return;
--			else
--				local v3791 = l_Assets_0.Particles.MartialArtist.TripleKickCounter.KickHit.ParticlePart.Attachment:Clone();
--				v3791.Parent = l_On_324.Torso;
--				if typeof(l_Color_9) == "Color3" then
--					for _, v3793 in v0.pairs(v3791:GetDescendants()) do
--						if v3793:IsA("ParticleEmitter") and v3793.Name == "White" then
--							v3793.Color = v0.ColorSequence.new(l_Color_9);
--						end;
--					end;
--				end;
--				VFXService.CheckBloodParticles(v3791);
--				VFXService.EmitParticlesInInstance(v3791);
--				VFXService.DestroyParticleContainer(v3791, 3);
--			end;
--		end;
--		if l_Request_1 == "TripleKickCounterKick3" then
--			local v3794 = v724.At * v0.CFrame.Angles(0, -v0.math.pi / 2, 0);
--			local l_Color_10 = v724.Color;
--			local v3796 = l_Assets_0.Particles.MartialArtist.TripleKickCounter.FinalKickHit.ParticlePart:Clone();
--			v3796.CFrame = v3794;
--			v3796.Parent = l_VFX_0;
--			if typeof(l_Color_10) == "Color3" then
--				for _, v3798 in v0.pairs(v3796:GetDescendants()) do
--					if v3798:IsA("ParticleEmitter") and v3798.Name == "White" then
--						v3798.Color = v0.ColorSequence.new(l_Color_10);
--					end;
--				end;
--			end;
--			VFXService.CheckBloodParticles(v3796);
--			VFXService.EmitParticlesInInstance(v3796);
--			VFXService.DestroyParticleContainer(v3796, 3.5);
--		end;
--		if l_Request_1 == "TripleKickCounterCrater" then
--			local v3799 = v724.At + v0.Vector3.new(0, 3.5, 0);
--			local l_Color_11 = v724.Color;
--			local v3801 = {};
--			local v3802 = {};
--			local l_Magnitude_9 = (v3799.Position - l_HumanoidRootPart_0.Position).Magnitude;
--			local v3804 = workspace:Raycast(v3799.Position, v0.Vector3.new(0, -10, 0), v72);
--			VFXService.GetCircularRocksProperties(v3801, v3799 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--				15, 
--				18
--			}, v0.math.random(5, 7), {
--				6.5, 
--				7.5
--			}, {
--				2, 
--				3.5
--			}, {
--				2, 
--				3.5
--			}, {
--				-7, 
--				7
--			}, {
--				-7, 
--				7
--			}, {
--				-7, 
--				7
--			}, {
--				"Grow", 
--				"Sink", 
--				0.3
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetCircularRocksProperties(v3801, v3799 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--				11, 
--				14
--			}, v0.math.random(5, 7), {
--				5, 
--				6
--			}, {
--				1.5, 
--				2.25
--			}, {
--				1.5, 
--				2.25
--			}, {
--				-7, 
--				7
--			}, {
--				-7, 
--				7
--			}, {
--				-7, 
--				7
--			}, {
--				"Grow", 
--				"Sink", 
--				0.3
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetCircularRocksProperties(v3801, v3799 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--				12, 
--				14.5
--			}, v0.math.random(5, 7), {
--				5, 
--				6
--			}, {
--				1, 
--				2.5
--			}, {
--				1, 
--				2.5
--			}, {
--				-7, 
--				7
--			}, {
--				-7, 
--				7
--			}, {
--				-7, 
--				7
--			}, {
--				"Grow", 
--				"Sink", 
--				0.3
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetCircularRocksProperties(v3801, v3799 * v0.CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
--				12, 
--				14.5
--			}, v0.math.random(5, 7), {
--				5, 
--				6
--			}, {
--				1, 
--				2.5
--			}, {
--				1, 
--				2.5
--			}, {
--				-7, 
--				7
--			}, {
--				-7, 
--				7
--			}, {
--				-7, 
--				7
--			}, {
--				"Grow", 
--				"Sink", 
--				0.3
--			}, 5, false, {
--				IncludeDuplicate = true
--			});
--			VFXService.GetFlyingRocksProperties(v3802, v3799, v0.math.random(6, 8), {
--				15, 
--				45
--			}, {
--				80, 
--				80
--			}, {
--				15, 
--				45
--			}, 0.8, 0.8, 0.8);
--			VFXService.GetFlyingRocksProperties(v3802, v3799, v0.math.random(4, 5), {
--				15, 
--				45
--			}, {
--				80, 
--				80
--			}, {
--				15, 
--				45
--			}, 1.2, 1.2, 1.2);
--			VFXService.GetFlyingRocksProperties(v3802, v3799, v0.math.random(4, 5), {
--				15, 
--				45
--			}, {
--				80, 
--				80
--			}, {
--				15, 
--				45
--			}, 2, 2, 2);
--			local v3805 = VFXService.GetTile(v3799.Position);
--			VFXService.ApplyCircularRocksProperties(v3801);
--			VFXService.ApplyFlyingRocksProperties(v3802);
--			local v3806 = nil;
--			if v3804 then
--				v3806 = v3804.Instance.Color;
--			end;
--			VFXService.EmitFromCFrame(v3799, l_Assets_0.Particles.ImpactSmokeBig:GetChildren(), nil, nil, {
--				40
--			}, v3806);
--			if v3804 then
--				local v3807 = v0.CFrame.new(v3804.Position);
--				local v3808 = l_Assets_0.Particles.MartialArtist.TripleKickCounter.Stomp2.ParticlePart:Clone();
--				v3808.CFrame = v3807 + v0.Vector3.new(0, 2.35, 0);
--				v3808.Parent = l_VFX_0;
--				local v3809 = l_Assets_0.Particles.MartialArtist.TripleKickCounter.Stomp2Crack.ParticlePart:Clone();
--				v3809.CFrame = v3807 + v0.Vector3.new(0, 0.25, 0);
--				v3809.Parent = l_VFX_0;
--				if typeof(l_Color_11) == "Color3" then
--					for _, v3811 in v0.pairs(v3808:GetDescendants()) do
--						if v3811:IsA("ParticleEmitter") and v3811.Name == "White" then
--							v3811.Color = v0.ColorSequence.new(l_Color_11);
--						end;
--					end;
--					for _, v3813 in v0.pairs(v3809:GetDescendants()) do
--						if v3813:IsA("ParticleEmitter") and v3813.Name == "White" then
--							v3813.Color = v0.ColorSequence.new(l_Color_11);
--						end;
--					end;
--				end;
--				VFXService.EmitParticlesInInstance(v3809);
--				VFXService.EmitParticlesInInstance(v3808);
--				VFXService.DestroyParticleContainer(v3809, 5);
--				VFXService.DestroyParticleContainer(v3808, 2.5);
--				VFXService.DestroyTile(v3805);
--			end;
--			if l_Magnitude_9 <= 50 then
--				VFXService.ShakeCamera(0.2, 0.45, 21.5, 0.4, 0.6, 0.4);
--			end;
--		end;
--		if l_Request_1 == "TripleKickCounterHitGround" then
--			local l_On_325 = v724.On;
--			local l_Color_12 = v724.Color;
--			if not (l_On_325 ~= nil) or l_On_325.Parent == nil then
--				return;
--			else
--				local v3816 = l_On_325.Head.Position + v0.Vector3.new(0, 3, 0);
--				local l_Magnitude_10 = (v3816 - l_HumanoidRootPart_0.Position).Magnitude;
--				local v3818 = v0.CFrame.new(v3816);
--				local v3819 = {};
--				local v3820 = {};
--				local v3821 = workspace:Raycast(v3816, v0.Vector3.new(0, -10, 0), v72);
--				VFXService.GetCircularRocksProperties(v3819, v3818 * v0.CFrame.Angles(0, v0.math.random(0, v0.math.pi * 2), 0), {
--					6, 
--					8
--				}, v0.math.random(4, 6), {
--					3, 
--					4
--				}, {
--					1, 
--					1.6
--				}, {
--					1, 
--					1.6
--				}, {
--					-7, 
--					7
--				}, {
--					-7, 
--					7
--				}, {
--					-7, 
--					7
--				}, {
--					"Grow", 
--					"Sink"
--				}, 5, false, {
--					IncludeDuplicate = true
--				});
--				VFXService.GetCircularRocksProperties(v3819, v3818 * v0.CFrame.Angles(0, v0.math.random(0, v0.math.pi * 2), 0), {
--					7, 
--					10
--				}, v0.math.random(3, 4), {
--					5, 
--					6
--				}, {
--					1.5, 
--					2
--				}, {
--					1.5, 
--					2
--				}, {
--					-7, 
--					7
--				}, {
--					-7, 
--					7
--				}, {
--					-7, 
--					7
--				}, {
--					"Grow", 
--					"Sink"
--				}, 5, false, {
--					IncludeDuplicate = true
--				});
--				VFXService.GetFlyingRocksProperties(v3820, v3818, v0.math.random(4, 5), {
--					10, 
--					35
--				}, {
--					70, 
--					70
--				}, {
--					10, 
--					35
--				}, 0.7, 0.7, 0.7);
--				VFXService.GetFlyingRocksProperties(v3820, v3818, v0.math.random(2, 3), {
--					10, 
--					35
--				}, {
--					70, 
--					70
--				}, {
--					10, 
--					35
--				}, 1.1, 1.1, 1.1);
--				local v3822 = VFXService.GetTile(v3816 + v0.Vector3.new(0, 1.5, 0));
--				VFXService.ApplyCircularRocksProperties(v3819);
--				VFXService.ApplyFlyingRocksProperties(v3820);
--				if v3821 then
--					local v3823 = v0.CFrame.new(v3821.Position);
--					local v3824 = l_Assets_0.Particles.MartialArtist.TripleKickCounter.Stomp1.ParticlePart:Clone();
--					v3824.CFrame = v3823 + v0.Vector3.new(0, 0.15, 0);
--					v3824.Parent = l_VFX_0;
--					if typeof(l_Color_12) == "Color3" then
--						for _, v3826 in v0.pairs(v3824:GetDescendants()) do
--							if v3826:IsA("ParticleEmitter") and v3826.Name == "White" then
--								v3826.Color = v0.ColorSequence.new(l_Color_12);
--							end;
--						end;
--					end;
--					VFXService.EmitFromCFrame(v3823, l_Assets_0.Particles.ImpactSmokeSmall:GetChildren(), nil, nil, nil, v3821.Instance.Color);
--					VFXService.EmitParticlesInInstance(v3824);
--					VFXService.DestroyParticleContainer(v3824, 5);
--					VFXService.DestroyTile(v3822);
--				end;
--				if l_Magnitude_10 <= 50 then
--					VFXService.ShakeCamera(nil, 0.4, 19, 0.3, 0.525, 0.3);
--				end;
--			end;
--		end;
--		if l_Request_1 == "JunM1Swing1" then
--			local l_On_326 = v724.On;
--			if not (l_On_326 ~= nil) or l_On_326.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_326.HumanoidRootPart, "JunSwing1");
--			end;
--		end;
--		if l_Request_1 == "JunM1Swing2" then
--			local l_On_327 = v724.On;
--			if not (l_On_327 ~= nil) or l_On_327.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_327.HumanoidRootPart, "JunSwing2");
--			end;
--		end;
--		if l_Request_1 == "JunM1Swing3" then
--			local l_On_328 = v724.On;
--			if not (l_On_328 ~= nil) or l_On_328.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_328.HumanoidRootPart, "JunSwing3");
--			end;
--		end;
--		if l_Request_1 == "JunM1Swing4" then
--			local l_On_329 = v724.On;
--			if not (l_On_329 ~= nil) or l_On_329.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_329.HumanoidRootPart, "JunSwing4");
--			end;
--		end;
--		if l_Request_1 == "JunM1Swing5" then
--			local l_On_330 = v724.On;
--			if not (l_On_330 ~= nil) or l_On_330.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_330.HumanoidRootPart, "M1UppercutSwing");
--			end;
--		end;
--		if l_Request_1 == "JunM1Swing6" then
--			local l_On_331 = v724.On;
--			if not (l_On_331 ~= nil) or l_On_331.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_331.HumanoidRootPart, "M1DownslamSwing");
--			end;
--		end;
--		if l_Request_1 == "JunM1Hit1" then
--			local l_On_332 = v724.On;
--			if not (l_On_332 ~= nil) or l_On_332.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_332.HumanoidRootPart, "JunHit1");
--			end;
--		end;
--		if l_Request_1 == "JunM1Hit2" then
--			local l_On_333 = v724.On;
--			if not (l_On_333 ~= nil) or l_On_333.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_333.HumanoidRootPart, "JunHit2");
--			end;
--		end;
--		if l_Request_1 == "JunM1Hit3" then
--			local l_On_334 = v724.On;
--			if not (l_On_334 ~= nil) or l_On_334.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_334.HumanoidRootPart, "JunHit3");
--			end;
--		end;
--		if l_Request_1 == "JunM1Hit4" then
--			local l_On_335 = v724.On;
--			if not (l_On_335 ~= nil) or l_On_335.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_335.HumanoidRootPart, "JunHit4");
--			end;
--		end;
--		if l_Request_1 == "MartialArtistM1Hit4" then
--			local l_On_336 = v724.On;
--			if not (l_On_336 ~= nil) or l_On_336.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_336.HumanoidRootPart, "MartialArtistHit4");
--			end;
--		end;
--		if l_Request_1 == "MartialArtistM1Hit3" then
--			local l_On_337 = v724.On;
--			if not (l_On_337 ~= nil) or l_On_337.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_337.HumanoidRootPart, "MartialArtistHit3");
--			end;
--		end;
--		if l_Request_1 == "MartialArtistM1Hit2" then
--			local l_On_338 = v724.On;
--			if not (l_On_338 ~= nil) or l_On_338.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_338.HumanoidRootPart, "MartialArtistHit2");
--			end;
--		end;
--		if l_Request_1 == "MartialArtistM1Hit1" then
--			local l_On_339 = v724.On;
--			if not (l_On_339 ~= nil) or l_On_339.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_339.HumanoidRootPart, "MartialArtistHit1");
--			end;
--		end;
--		if l_Request_1 == "MartialArtistM1Swing6" then
--			local l_On_340 = v724.On;
--			if not (l_On_340 ~= nil) or l_On_340.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_340.HumanoidRootPart, "M1DownslamSwing");
--			end;
--		end;
--		if l_Request_1 == "MartialArtistM1Swing5" then
--			local l_On_341 = v724.On;
--			if not (l_On_341 ~= nil) or l_On_341.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_341.HumanoidRootPart, "M1UppercutSwing");
--			end;
--		end;
--		if l_Request_1 == "MartialArtistM1Swing4" then
--			local l_On_342 = v724.On;
--			if not (l_On_342 ~= nil) or l_On_342.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_342.HumanoidRootPart, "MartialArtistSwing4");
--			end;
--		end;
--		if l_Request_1 == "MartialArtistM1Swing3" then
--			local l_On_343 = v724.On;
--			if not (l_On_343 ~= nil) or l_On_343.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_343.HumanoidRootPart, "MartialArtistSwing3");
--			end;
--		end;
--		if l_Request_1 == "MartialArtistM1Swing2" then
--			local l_On_344 = v724.On;
--			if not (l_On_344 ~= nil) or l_On_344.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_344.HumanoidRootPart, "MartialArtistSwing2");
--			end;
--		end;
--		if l_Request_1 == "MartialArtistM1Swing1" then
--			local l_On_345 = v724.On;
--			if not (l_On_345 ~= nil) or l_On_345.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_345.HumanoidRootPart, "MartialArtistSwing1");
--			end;
--		end;
--		if l_Request_1 == "MartialArtistFrontDashSwing" then
--			local l_On_346 = v724.On;
--			if not (l_On_346 ~= nil) or l_On_346.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_346.HumanoidRootPart, "MartialArtistFrontDashSwing");
--			end;
--		end;
--		if l_Request_1 == "MartialArtistM1Uppercut" then
--			local l_On_351 = v724.On;
--			if not (l_On_351 ~= nil) or l_On_351.Parent == nil then
--				return;
--			else
--				v104.PlaySoundAtCFrame(l_On_351.HumanoidRootPart.Position, "M1UppercutHit");
--				local v4086 = l_Assets_0.Parts.Ring:Clone();
--				local v4087 = v0.CFrame.new(l_On_351.HumanoidRootPart.Position);
--				v4086.Size = v0.Vector3.new(0.01, 3, 0.01);
--				v4086.CFrame = v4087;
--				local v4088 = l_TweenService_0:Create(v4086, v0.TweenInfo.new(0.35, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--					Size = v0.Vector3.new(8.25, 0, 8.25), 
--					Position = v4087.Position + v0.Vector3.new(0, 3.25, 0), 
--					Transparency = 1
--				});
--				local l_v4086_0 = v4086 --[[ copy: 3 -> 81 ]];
--				v4088.Completed:Connect(function()
--					if l_v4086_0 ~= nil and l_v4086_0.Parent ~= nil then
--						l_v4086_0:Destroy();
--					end;
--				end);
--				v4086.Parent = l_VFX_0;
--				v4088:Play();
--			end;
--		end;
--		if l_Request_1 == "M1Downslam" then
--			local l_On_352 = v724.On;
--			if not (l_On_352 ~= nil) or l_On_352.Parent == nil then
--				return;
--			else
--				local v4091 = v0.CFrame.new(l_On_352.HumanoidRootPart.Position) * v0.CFrame.Angles(0, v0.math.rad(v0.math.random(0, 360)), 0);
--				local v4092 = workspace:Raycast(v4091.Position + v0.Vector3.new(0, 1.5, 0), v0.Vector3.new(0, -5, 0), v72);
--				local v4093 = VFXService.GetTile(v4091.Position + v0.Vector3.new(0, 1.5, 0));
--				v104.PlaySoundInInstance(l_On_352.HumanoidRootPart, "M1DownslamHit");
--				if v4092 then
--					local v4094 = {};
--					local v4095 = {};
--					VFXService.GetCircularRocksProperties(v4094, v4091, {
--						5, 
--						6.5
--					}, 8, {
--						2, 
--						2.5
--					}, {
--						2, 
--						2.5
--					}, {
--						1.5, 
--						2.5
--					}, {
--						-3.5, 
--						3.5
--					}, {
--						-3.5, 
--						3.5
--					}, {
--						-3.5, 
--						3.5
--					}, {
--						"Rise", 
--						"Sink"
--					}, 5, false, {
--						IncludeDuplicate = true
--					}, 15);
--					VFXService.GetFlyingRocksProperties(v4095, v4091, 3, {
--						5, 
--						27
--					}, {
--						62, 
--						62
--					}, {
--						5, 
--						27
--					}, 0.8, 0.8, 0.8, 5);
--					VFXService.GetFlyingRocksProperties(v4095, v4091, 3, {
--						5, 
--						27
--					}, {
--						62, 
--						62
--					}, {
--						5, 
--						27
--					}, 1.1, 1.1, 1.1, 5);
--					VFXService.GetFlyingRocksProperties(v4095, v4091, 3, {
--						5, 
--						27
--					}, {
--						62, 
--						62
--					}, {
--						5, 
--						27
--					}, 0.55, 0.55, 0.55, 5);
--					VFXService.ApplyCircularRocksProperties(v4094);
--					VFXService.ApplyFlyingRocksProperties(v4095);
--					v104.PlaySoundAtCFrame(v4092.Position, "DownslamConcrete");
--					VFXService.EmitFromCFrame(v0.CFrame.new(v4092.Position), l_Assets_0.Particles.ImpactSmokeSmall:GetChildren(), nil, nil, {
--						13
--					}, v4092.Instance.Color);
--					VFXService.DestroyTile(v4093, nil, nil, nil, nil, false);
--					local v4096 = l_Assets_0.Parts.Ring:Clone();
--					v4096.Size = v0.Vector3.new(0.01, 3.5, 0.01);
--					v4096.CFrame = v0.CFrame.new(v4092.Position);
--					local v4097 = l_TweenService_0:Create(v4096, v0.TweenInfo.new(0.35, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--						Size = v0.Vector3.new(16, 0, 16), 
--						Position = v4096.Position + v0.Vector3.new(0, 2, 0), 
--						Transparency = 1
--					});
--					local l_v4096_0 = v4096 --[[ copy: 8 -> 80 ]];
--					v4097.Completed:Connect(function()
--						if l_v4096_0 ~= nil and l_v4096_0.Parent ~= nil then
--							l_v4096_0:Destroy();
--						end;
--					end);
--					v4096.Parent = l_VFX_0;
--					v4097:Play();
--				else
--					local v4099 = l_Assets_0.Parts.Ring:Clone();
--					v4099.Size = v0.Vector3.new(0.01, 3.5, 0.01);
--					v4099.CFrame = v0.CFrame.new(l_On_352.HumanoidRootPart.Position);
--					local v4100 = l_TweenService_0:Create(v4099, v0.TweenInfo.new(0.35, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
--						Size = v0.Vector3.new(16, 0, 16), 
--						Position = v4099.Position + v0.Vector3.new(0, 2, 0), 
--						Transparency = 1
--					});
--					local l_v4099_0 = v4099 --[[ copy: 6 -> 79 ]];
--					v4100.Completed:Connect(function()
--						if l_v4099_0 ~= nil and l_v4099_0.Parent ~= nil then
--							l_v4099_0:Destroy();
--						end;
--					end);
--					v4099.Parent = l_VFX_0;
--					v4100:Play();
--				end;
--			end;
--		end;
--		if l_Request_1 == "JunFrontDashHit" then
--			local l_On_354 = v724.On;
--			if not (l_On_354 ~= nil) or l_On_354.Parent == nil then
--				return;
--			else
--				local l_By_1 = v724.By;
--				if not (l_By_1 ~= nil) or l_By_1.Parent == nil then
--					return;
--				else
--					v104.PlaySoundInInstance(l_On_354.HumanoidRootPart, "MartialArtistFrontDashHit");
--					local v4105 = l_Assets_0.Particles.Jun.FrontDashHit:Clone();
--					local l_LookVector_11 = v0.CFrame.new(l_By_1.HumanoidRootPart.Position, v0.Vector3.new(l_On_354.HumanoidRootPart.Position.X, l_By_1.HumanoidRootPart.Position.Y, l_On_354.HumanoidRootPart.Position.Z)).LookVector;
--					v4105.CFrame = v0.CFrame.new(l_On_354.HumanoidRootPart.Position, l_On_354.HumanoidRootPart.Position - l_LookVector_11);
--					v4105.Parent = l_VFX_0;
--					VFXService.EmitParticlesInInstance(v4105);
--					VFXService.DestroyParticleContainer(v4105, 3);
--				end;
--			end;
--		end;
--		if l_Request_1 == "MartialArtistFrontDashHit" then
--			local l_On_355 = v724.On;
--			local v4108 = v724.Color or v0.Color3.fromRGB(255, 255, 255);
--			if not (l_On_355 ~= nil) or l_On_355.Parent == nil then
--				return;
--			else
--				v104.PlaySoundInInstance(l_On_355.HumanoidRootPart, "MartialArtistFrontDashHit");
--				local l_RootAttachment_0 = l_On_355.HumanoidRootPart.RootAttachment;
--				local l_Children_15 = l_Assets_0.Particles.MartialArtist.FrontDashHit:GetChildren();
--				local v4111 = {};
--				for _, v4113 in v0.pairs(l_Children_15) do
--					local v4114 = v4113:Clone();
--					if v4114.Name == "White" then
--						v4114.Color = v0.ColorSequence.new(v4108);
--					end;
--					v0.table.insert(v4111, v4114);
--					v4114.Parent = l_RootAttachment_0;
--					v4114:Emit(v4114:GetAttribute("EmitCount"));
--				end;
--				local l_v4111_0 = v4111 --[[ copy: 6 -> 78 ]];
--				v0.task.delay(2, function()
--					for _, v4117 in v0.pairs(l_v4111_0) do
--						if v4117 ~= nil and v4117.Parent ~= nil then
--							v4117:Destroy();
--						end;
--					end;
--				end);
--			end;
--		end;
--		if l_Request_1 == "MartialArtistEnableAwakeningAura" then
--			local l_On_368 = v724.On;
--			if not (l_On_368 ~= nil) or l_On_368.Parent == nil then
--				return;
--			else
--				for _, v4254 in v0.pairs(l_On_368:GetDescendants()) do
--					if (v4254:IsA("ParticleEmitter") or v4254:IsA("Beam")) and v4254.Name == "AwakeningAura" and v4254:GetAttribute("Tag") == "Martial Artist" then
--						v4254.Enabled = true;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "MartialArtistDisableAwakeningAura" then
--			local l_On_369 = v724.On;
--			if not (l_On_369 ~= nil) or l_On_369.Parent == nil then
--				return;
--			else
--				for _, v4257 in v0.pairs(l_On_369:GetDescendants()) do
--					if (v4257:IsA("ParticleEmitter") or v4257:IsA("Beam")) and v4257.Name == "AwakeningAura" and v4257:GetAttribute("Tag") == "Martial Artist" then
--						v4257.Enabled = false;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "MartialArtistEnableRightAura" then
--			local l_On_370 = v724.On;
--			if not (l_On_370 ~= nil) or l_On_370.Parent == nil then
--				return;
--			else
--				local l_RightArmTechnique_0 = l_On_370.Storage.RightArmTechnique;
--				for _, v4261 in v0.pairs(l_RightArmTechnique_0:GetDescendants()) do
--					if v4261:IsA("Trail") or v4261:IsA("ParticleEmitter") then
--						v4261.Enabled = true;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "MartialArtistEnableLeftAura" then
--			local l_On_371 = v724.On;
--			if not (l_On_371 ~= nil) or l_On_371.Parent == nil then
--				return;
--			else
--				local l_LeftArmTechnique_0 = l_On_371.Storage.LeftArmTechnique;
--				for _, v4265 in v0.pairs(l_LeftArmTechnique_0:GetDescendants()) do
--					if v4265:IsA("Trail") or v4265:IsA("ParticleEmitter") then
--						v4265.Enabled = true;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "MartialArtistEnableAuras" then
--			local l_On_372 = v724.On;
--			if not (l_On_372 ~= nil) or l_On_372.Parent == nil then
--				return;
--			else
--				local l_Storage_0 = l_On_372.Storage;
--				local l_RightArmTechnique_1 = l_Storage_0.RightArmTechnique;
--				local l_LeftArmTechnique_1 = l_Storage_0.LeftArmTechnique;
--				for _, v4271 in v0.pairs(l_RightArmTechnique_1:GetDescendants()) do
--					if v4271:IsA("Trail") or v4271:IsA("ParticleEmitter") then
--						v4271.Enabled = true;
--					end;
--				end;
--				for _, v4273 in v0.pairs(l_LeftArmTechnique_1:GetDescendants()) do
--					if v4273:IsA("Trail") or v4273:IsA("ParticleEmitter") then
--						v4273.Enabled = true;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "MartialArtistDisableRightAura" then
--			local l_On_373 = v724.On;
--			if not (l_On_373 ~= nil) or l_On_373.Parent == nil then
--				return;
--			else
--				local l_RightArmTechnique_2 = l_On_373.Storage.RightArmTechnique;
--				for _, v4277 in v0.pairs(l_RightArmTechnique_2:GetDescendants()) do
--					if v4277:IsA("Trail") or v4277:IsA("ParticleEmitter") then
--						v4277.Enabled = false;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "MartialArtistDisableLeftAura" then
--			local l_On_374 = v724.On;
--			if not (l_On_374 ~= nil) or l_On_374.Parent == nil then
--				return;
--			else
--				local l_LeftArmTechnique_2 = l_On_374.Storage.LeftArmTechnique;
--				for _, v4281 in v0.pairs(l_LeftArmTechnique_2:GetDescendants()) do
--					if v4281:IsA("Trail") or v4281:IsA("ParticleEmitter") then
--						v4281.Enabled = false;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "MartialArtistDisableAuras" then
--			local l_On_375 = v724.On;
--			if not (l_On_375 ~= nil) or l_On_375.Parent == nil then
--				return;
--			else
--				local l_Storage_1 = l_On_375.Storage;
--				local l_RightArmTechnique_3 = l_Storage_1.RightArmTechnique;
--				local l_LeftArmTechnique_3 = l_Storage_1.LeftArmTechnique;
--				for _, v4287 in v0.pairs(l_RightArmTechnique_3:GetDescendants()) do
--					if v4287:IsA("Trail") or v4287:IsA("ParticleEmitter") then
--						v4287.Enabled = false;
--					end;
--				end;
--				for _, v4289 in v0.pairs(l_LeftArmTechnique_3:GetDescendants()) do
--					if v4289:IsA("Trail") or v4289:IsA("ParticleEmitter") then
--						v4289.Enabled = false;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "MartialArtistSetRightAuraColor" then
--			local l_On_376 = v724.On;
--			if not (l_On_376 ~= nil) or l_On_376.Parent == nil then
--				return;
--			else
--				local v4291 = v0.ColorSequence.new(v724.Color);
--				local l_RightArmTechnique_4 = l_On_376.Storage.RightArmTechnique;
--				for _, v4294 in v0.pairs(l_RightArmTechnique_4:GetDescendants()) do
--					if v4294:IsA("Trail") or v4294:IsA("ParticleEmitter") and v4294.Name == "White" then
--						v4294.Color = v4291;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "MartialArtistSetLeftAuraColor" then
--			local l_On_377 = v724.On;
--			if not (l_On_377 ~= nil) or l_On_377.Parent == nil then
--				return;
--			else
--				local v4296 = v0.ColorSequence.new(v724.Color);
--				local l_LeftArmTechnique_4 = l_On_377.Storage.LeftArmTechnique;
--				for _, v4299 in v0.pairs(l_LeftArmTechnique_4:GetDescendants()) do
--					if v4299:IsA("Trail") or v4299:IsA("ParticleEmitter") and v4299.Name == "White" then
--						v4299.Color = v4296;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "MartialArtistSetAuraColors" then
--			local l_On_378 = v724.On;
--			if not (l_On_378 ~= nil) or l_On_378.Parent == nil then
--				return;
--			else
--				local v4301 = v0.ColorSequence.new(v724.Right);
--				local v4302 = v0.ColorSequence.new(v724.Left);
--				local l_Storage_2 = l_On_378.Storage;
--				local l_RightArmTechnique_5 = l_Storage_2.RightArmTechnique;
--				local l_LeftArmTechnique_5 = l_Storage_2.LeftArmTechnique;
--				for _, v4307 in v0.pairs(l_RightArmTechnique_5:GetDescendants()) do
--					if v4307:IsA("Trail") or v4307:IsA("ParticleEmitter") and v4307.Name == "White" then
--						v4307.Color = v4301;
--					end;
--				end;
--				for _, v4309 in v0.pairs(l_LeftArmTechnique_5:GetDescendants()) do
--					if v4309:IsA("Trail") or v4309:IsA("ParticleEmitter") and v4309.Name == "White" then
--						v4309.Color = v4302;
--					end;
--				end;
--			end;
--		end;
--		if l_Request_1 == "TripleKickCounterKick1Velocity" then
--			local v4310 = v0.Instance.new("BodyVelocity");
--			v4310.Name = "TripleKickCounterVelocity";
--			v4310.Parent = l_HumanoidRootPart_0;
--			v4310.MaxForce = v0.Vector3.new(70000, 0, 70000);
--			local l_v4310_0 = v4310 --[[ copy: 2 -> 44 ]];
--			v0.task.spawn(function()
--				while l_v4310_0 ~= nil and l_v4310_0.Parent ~= nil do
--					l_v4310_0.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * 25;
--					v0.task.wait();
--				end;
--			end);
--			v0.task.delay(0.125, function()
--				if l_v4310_0 ~= nil and l_v4310_0.Parent ~= nil then
--					l_v4310_0:Destroy();
--				end;
--			end);
--		end;
--		if l_Request_1 == "TripleKickCounterKick2Velocity" then
--			local v4312 = v0.Instance.new("BodyVelocity");
--			v4312.Name = "TripleKickCounterVelocity";
--			v4312.Parent = l_HumanoidRootPart_0;
--			v4312.MaxForce = v0.Vector3.new(70000, 0, 70000);
--			v0.task.spawn(function()
--				while v4312 ~= nil and v4312.Parent ~= nil do
--					v4312.Velocity = l_HumanoidRootPart_0.CFrame.LookVector * 25;
--					v0.task.wait();
--				end;
--			end);
--			v0.task.delay(0.125, function()
--				if v4312 ~= nil and v4312.Parent ~= nil then
--					v4312:Destroy();
--				end;
--			end);
--		end;
--		return;
--	end;
--end}
local Rep = {
	RagingFangsOut = function(v724)
		local l_U_0 = v724.U;
		local l_V_0 = v724.V;
		if l_U_0 ~= nil and l_U_0.Parent ~= nil then
			for _, v858 in v0.pairs(l_U_0.Humanoid.Animator:GetPlayingAnimationTracks()) do
				v858:Stop();
			end;
			local v859 = v0.Instance.new("Animation");
			v859.AnimationId = "rbxassetid://98208917212335";
			v859.Name = "RagingFangsUserAnimation";
			local v860 = l_U_0.Humanoid.Animator:LoadAnimation(v859);
			v859:Destroy();
			v860.Priority = v0.Enum.AnimationPriority.Action4;
			local l_l_U_0_0 = l_U_0 --[[ copy: 2 -> 499 ]];
			local l_l_V_0_0 = l_V_0 --[[ copy: 3 -> 500 ]];
			v860:GetMarkerReachedSignal("VictimSlam"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local v863 = l_Assets_0.Particles.Jun.RagingFangs.GroundSlam.Slam1:Clone();
					v863.Parent = l_l_U_0_0.HumanoidRootPart;
					VFXService.EmitParticlesInInstance(v863);
					VFXService.DestroyParticleContainer(v863, 6.5);
				end;
			end);
			v860:GetMarkerReachedSignal("KneeContact"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local v864 = l_Assets_0.Particles.Jun.RagingFangs.KneeContact.Knee:Clone();
					v864.Parent = l_l_U_0_0.HumanoidRootPart;
					VFXService.EmitParticlesInInstance(v864);
					VFXService.DestroyParticleContainer(v864, 6.5);
				end;
			end);
			v860:GetMarkerReachedSignal("EndKneeContact"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local v865 = l_Assets_0.Particles.Jun.RagingFangs.Knee.Knockback1:Clone();
					v865.Parent = l_l_U_0_0.HumanoidRootPart;
					VFXService.EmitParticlesInInstance(v865);
					VFXService.DestroyParticleContainer(v865, 6.5);
				end;
			end);
			v860:GetMarkerReachedSignal("NoMoreGames"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil then
					local v866 = l_Assets_0.Particles.Jun.RagingFangs.HandAura.Attachment:Clone();
					v866.Parent = l_l_U_0_0["Right Arm"];
					local v867 = l_Assets_0.Particles.Jun.RagingFangs.EyeFlash.Attachment1:Clone();
					local v868 = l_Assets_0.Particles.Jun.RagingFangs.EyeFlash.Attachment2:Clone();
					local v869 = l_Assets_0.Particles.Jun.RagingFangs.Glare.Glare:Clone();
					v867.Parent = l_l_U_0_0.Head;
					v868.Parent = l_l_U_0_0.Head;
					v869.Parent = l_l_U_0_0["Right Arm"];
					VFXService.EmitParticlesInInstance(v869);
					VFXService.EmitParticlesInInstance(v867);
					VFXService.EmitParticlesInInstance(v868);
					VFXService.DestroyParticleContainer(v869, 5);
					VFXService.CreateBind(l_l_U_0_0, "NoMoreGamesEffects", function()
						for _, v871 in v0.pairs(v866:GetDescendants()) do
							if v871:IsA("ParticleEmitter") then
								v871.Enabled = false;
							end;
						end;
						for _, v873 in v0.pairs(v867:GetDescendants()) do
							if v873:IsA("ParticleEmitter") then
								v873.Enabled = false;
							end;
						end;
						for _, v875 in v0.pairs(v868:GetDescendants()) do
							if v875:IsA("ParticleEmitter") then
								v875.Enabled = false;
							end;
						end;
						v0.task.delay(2.75, function()
							if v866 ~= nil and v866.Parent ~= nil then
								v866:Destroy();
							end;
							if v867 ~= nil and v867.Parent ~= nil then
								v867:Destroy();
							end;
							if v868 ~= nil and v868.Parent ~= nil then
								v868:Destroy();
							end;
						end);
					end);
				end;
			end);
			v860:GetMarkerReachedSignal("Stance"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil then
					VFXService.DestroyBind(l_l_U_0_0, "NoMoreGamesEffects");
					local v876 = l_Assets_0.Particles.Jun.RagingFangs.Stance.Stance:Clone();
					v876.Parent = l_l_U_0_0.HumanoidRootPart;
					VFXService.EmitParticlesInInstance(v876);
					VFXService.DestroyParticleContainer(v876, 6.5);
				end;
			end);
			v860:GetMarkerReachedSignal("VictimGround"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local v877 = l_Assets_0.Particles.Jun.RagingFangs.VictimFall.Fall:Clone();
					v877.Parent = l_l_U_0_0.HumanoidRootPart;
					VFXService.EmitParticlesInInstance(v877);
					VFXService.DestroyParticleContainer(v877, 6.5);
				end;
			end);
			v860:GetMarkerReachedSignal("EnableTrail"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil then
					local v878 = l_Assets_0.Particles.Jun.RagingFangs.ClawHandTrail:Clone();
					local v879 = v0.Instance.new("WeldConstraint");
					v879.Parent = v878;
					v879.Part0 = l_l_U_0_0["Right Arm"];
					v878.Parent = l_VFX_0;
					v878.CFrame = l_l_U_0_0["Right Arm"].CFrame;
					v879.Part1 = v878;
					v0.task.delay(0.3, function()
						if v878 ~= nil and v878.Parent ~= nil then
							for _, v881 in v0.pairs(v878:GetDescendants()) do
								if v881:IsA("Trail") then
									v881.Enabled = false;
								end;
							end;
							v0.task.delay(1, function()
								if v878 ~= nil and v878.Parent ~= nil then
									v878:Destroy();
								end;
							end);
						end;
					end);
				end;
			end);
			v860:GetMarkerReachedSignal("HitVictim"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local v882 = l_Assets_0.Particles.Jun.RagingFangs.VictimSlap.Hit1:Clone();
					v882.Parent = l_l_V_0_0.Torso;
					local v883 = l_Assets_0.Particles.Jun.RagingFangs.VictimSlap.Dust:Clone();
					v883.Parent = l_l_U_0_0.HumanoidRootPart;
					VFXService.EmitParticlesInInstance(v882);
					VFXService.EmitParticlesInInstance(v883);
					VFXService.DestroyParticleContainer(v882, 6.5);
					VFXService.DestroyParticleContainer(v883, 6.5);
				end;
			end);
			local v884 = v0.CFrame.new(-0.344421387, 0.853624344, 21.2884521, 0.552937388, -0.376031637, 0.743546009, -0.279130816, -0.92440927, -0.259923816, 0.785080314, -0.063824974, -0.616102397);
			local l_v884_0 = v884 --[[ copy: 6 -> 501 ]];
			v860:GetMarkerReachedSignal("FightSequence1"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local v886 = l_Assets_0.Particles.Jun.RagingFangs.FightSequenceContact:Clone();
					v886.Parent = l_VFX_0;
					v886.CFrame = l_l_U_0_0.HumanoidRootPart.CFrame * l_v884_0;
					VFXService.EmitParticlesInInstance(v886);
					VFXService.DestroyParticleContainer(v886, 2.5);
				end;
			end);
			local v887 = v0.CFrame.new(0, -2.97658348, 21.5480957, 1, 0, 0, 0, 1.00000334, 0, 0, 0, 1.00000334);
			local l_v887_0 = v887 --[[ copy: 7 -> 502 ]];
			v860:GetMarkerReachedSignal("FightSequence2"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local v889 = l_Assets_0.Particles.Jun.RagingFangs.FightSequenceDust:Clone();
					v889.Parent = l_VFX_0;
					v889.CFrame = l_l_U_0_0.HumanoidRootPart.CFrame * l_v887_0;
					VFXService.EmitParticlesInInstance(v889);
					VFXService.DestroyParticleContainer(v889, 2.5);
				end;
			end);
			local v890 = v0.CFrame.new(-0.0774536133, 0.850868225, 22.2446289, -0.362442702, -0.914320707, 0.180700839, 0.509118557, -0.356632113, -0.78333807, 0.780665994, -0.191916972, 0.594756424);
			local l_v890_0 = v890 --[[ copy: 8 -> 503 ]];
			v860:GetMarkerReachedSignal("FightSequence3"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local v892 = l_Assets_0.Particles.Jun.RagingFangs.FightSequenceContact:Clone();
					v892.Parent = l_VFX_0;
					v892.CFrame = l_l_U_0_0.HumanoidRootPart.CFrame * l_v890_0;
					VFXService.EmitParticlesInInstance(v892);
					VFXService.DestroyParticleContainer(v892, 2.5);
				end;
			end);
			local v893 = v0.CFrame.new(-0.566589355, 0.822473526, 24.8161621, -0.225469917, 0.146799147, -0.963127017, 0.969744027, -0.061190173, -0.236345619, -0.0936290696, -0.987275243, -0.12856105);
			local l_v893_0 = v893 --[[ copy: 9 -> 504 ]];
			v860:GetMarkerReachedSignal("FightSequence4"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local v895 = l_Assets_0.Particles.Jun.RagingFangs.FightSequenceContact:Clone();
					v895.Parent = l_VFX_0;
					v895.CFrame = l_l_U_0_0.HumanoidRootPart.CFrame * l_v893_0;
					VFXService.EmitParticlesInInstance(v895);
					VFXService.DestroyParticleContainer(v895, 2.5);
				end;
			end);
			local v896 = v0.CFrame.new(-1.14984131, 0.896659851, 23.4199219, -0.86388272, -0.43744579, 0.249695539, 0.287046313, -0.834917724, -0.469599545, 0.413899481, -0.33400476, 0.846838236);
			local l_v896_0 = v896 --[[ copy: 10 -> 505 ]];
			v860:GetMarkerReachedSignal("FightSequence5"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local v898 = l_Assets_0.Particles.Jun.RagingFangs.FightSequenceContact:Clone();
					v898.Parent = l_VFX_0;
					v898.CFrame = l_l_U_0_0.HumanoidRootPart.CFrame * l_v896_0;
					VFXService.EmitParticlesInInstance(v898);
					VFXService.DestroyParticleContainer(v898, 2.5);
				end;
			end);
			local v899 = v0.CFrame.new(-0.366210938, -0.377147675, 20.6118164, 1, 0, 0, 0, 1.00000167, 0, 0, 0, 1.00000167);
			local l_v899_0 = v899 --[[ copy: 11 -> 506 ]];
			v860:GetMarkerReachedSignal("Dodge"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local v901 = l_Assets_0.Particles.Jun.RagingFangs.Dodge:Clone();
					v901.Parent = l_VFX_0;
					v901.CFrame = l_l_U_0_0.HumanoidRootPart.CFrame * l_v899_0;
					VFXService.EmitParticlesInInstance(v901);
					VFXService.DestroyParticleContainer(v901, 2.9);
				end;
			end);
			local v902 = v0.CFrame.new(-0.0969238281, -0.320793152, 32.3046875, 0.970686972, 0.150183365, -0.187647879, -0.043274641, 0.877187312, 0.478197813, 0.236419678, -0.456059992, 0.857973456);
			local v903 = v0.CFrame.new(0, -2.95629311, 31.5982666, -1, 0, 0, 0, 1.00000167, 0, 0, 0, -1.00000167);
			local l_v902_0 = v902 --[[ copy: 12 -> 507 ]];
			local l_v903_0 = v903 --[[ copy: 13 -> 508 ]];
			v860:GetMarkerReachedSignal("BodyHit1"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local l_CFrame_4 = l_l_U_0_0.HumanoidRootPart.CFrame;
					local v907 = l_Assets_0.Particles.Jun.RagingFangs.BodyHit:Clone();
					v907.Parent = l_VFX_0;
					v907.CFrame = l_CFrame_4 * l_v902_0;
					local v908 = l_Assets_0.Particles.Jun.RagingFangs.BodyHitDust:Clone();
					v908.Parent = l_VFX_0;
					v908.CFrame = l_CFrame_4 * l_v903_0;
					VFXService.EmitParticlesInInstance(v907);
					VFXService.EmitParticlesInInstance(v908);
					VFXService.DestroyParticleContainer(v907, 3.5);
					VFXService.DestroyParticleContainer(v908, 5.5);
				end;
			end);
			local v909 = v0.CFrame.new(-0.227539062, -0.267347336, 33.1010742, 0.999589145, -0.0281409733, -0.00544476416, 0.0286621377, 0.982757509, 0.182673857, 2.1026269E-4, -0.182754859, 0.983160317);
			local v910 = v0.CFrame.new(0, -2.95629311, 32.7980957, -1, 0, 0, 0, 1.00000167, 0, 0, 0, -1.00000167);
			local l_v909_0 = v909 --[[ copy: 14 -> 509 ]];
			local l_v910_0 = v910 --[[ copy: 15 -> 510 ]];
			v860:GetMarkerReachedSignal("BodyHit2"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local l_CFrame_5 = l_l_U_0_0.HumanoidRootPart.CFrame;
					local v914 = l_Assets_0.Particles.Jun.RagingFangs.BodyHit:Clone();
					v914.Parent = l_VFX_0;
					v914.CFrame = l_CFrame_5 * l_v909_0;
					local v915 = l_Assets_0.Particles.Jun.RagingFangs.BodyHitDust:Clone();
					v915.Parent = l_VFX_0;
					v915.CFrame = l_CFrame_5 * l_v910_0;
					VFXService.EmitParticlesInInstance(v914);
					VFXService.EmitParticlesInInstance(v915);
					VFXService.DestroyParticleContainer(v914, 3.5);
					VFXService.DestroyParticleContainer(v915, 5.5);
				end;
			end);
			local v916 = v0.CFrame.new(-0.141784668, -0.27664566, 35.25354, 0.981861234, -0.0626335889, -0.178956911, 0.132401869, 0.902106643, 0.410702616, 0.135714442, -0.426947176, 0.894036412);
			local v917 = v0.CFrame.new(0, -2.95629311, 35.4981689, -1, 0, 0, 0, 1.00000167, 0, 0, 0, -1.00000167);
			local l_v916_0 = v916 --[[ copy: 16 -> 511 ]];
			local l_v917_0 = v917 --[[ copy: 17 -> 512 ]];
			v860:GetMarkerReachedSignal("BodyHit3"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local l_CFrame_6 = l_l_U_0_0.HumanoidRootPart.CFrame;
					local v921 = l_Assets_0.Particles.Jun.RagingFangs.BodyHit:Clone();
					v921.Parent = l_VFX_0;
					v921.CFrame = l_CFrame_6 * l_v916_0;
					local v922 = l_Assets_0.Particles.Jun.RagingFangs.BodyHitDust:Clone();
					v922.Parent = l_VFX_0;
					v922.CFrame = l_CFrame_6 * l_v917_0;
					VFXService.EmitParticlesInInstance(v921);
					VFXService.EmitParticlesInInstance(v922);
					VFXService.DestroyParticleContainer(v921, 3.5);
					VFXService.DestroyParticleContainer(v922, 5.5);
				end;
			end);
			local v923 = v0.CFrame.new(0.801999986, 0.398000002, 37.0820007, 0.878388762, -0.466510236, -0.103929415, -0.454769373, -0.882687151, 0.118525296, -0.147030413, -0.0568473786, -0.987497091);
			local l_v923_0 = v923 --[[ copy: 18 -> 513 ]];
			v860:GetMarkerReachedSignal("Claw1"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local l_CFrame_7 = l_l_U_0_0.HumanoidRootPart.CFrame;
					local v926 = l_Assets_0.Particles.Jun.RagingFangs.OutsideClaw:Clone();
					v926.Parent = l_VFX_0;
					v926:PivotTo(l_CFrame_7 * l_v923_0);
					VFXService.EmitParticlesInInstance(v926);
					VFXService.DestroyParticleContainer(v926, 5.5);
				end;
			end);
			local v927 = v0.CFrame.new(-0.209000006, -0.257999897, 40.2709999, 0.187399089, 0.0798919648, -0.979029655, -0.130624577, -0.985808194, -0.105448388, -0.973559856, 0.147646219, -0.17430374);
			local l_v927_0 = v927 --[[ copy: 19 -> 514 ]];
			v860:GetMarkerReachedSignal("Claw2"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local l_CFrame_8 = l_l_U_0_0.HumanoidRootPart.CFrame;
					local v930 = l_Assets_0.Particles.Jun.RagingFangs.OutsideClaw:Clone();
					v930.Parent = l_VFX_0;
					v930:PivotTo(l_CFrame_8 * l_v927_0);
					VFXService.EmitParticlesInInstance(v930);
					VFXService.DestroyParticleContainer(v930, 5.5);
				end;
			end);
			local v931 = v0.CFrame.new(-0.866999984, 0.487999916, 42.1300011, 0.736305416, 0.647945881, 0.194988146, 0.64978236, -0.757471621, 0.0634001717, 0.188777819, 0.080017969, -0.978754461);
			local l_v931_0 = v931 --[[ copy: 20 -> 515 ]];
			v860:GetMarkerReachedSignal("Claw3"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local l_CFrame_9 = l_l_U_0_0.HumanoidRootPart.CFrame;
					local v934 = l_Assets_0.Particles.Jun.RagingFangs.OutsideClaw:Clone();
					v934.Parent = l_VFX_0;
					v934:PivotTo(l_CFrame_9 * l_v931_0);
					VFXService.EmitParticlesInInstance(v934);
					VFXService.DestroyParticleContainer(v934, 5.5);
				end;
			end);
			local v935 = v0.CFrame.new(0.68599999, 0.0769999027, 43.5340004, -0.775736153, 0.126828566, 0.618181109, 0.102140583, -0.941444814, 0.321323812, 0.622736335, 0.312403888, 0.71735853);
			local l_v935_0 = v935 --[[ copy: 21 -> 516 ]];
			v860:GetMarkerReachedSignal("Claw4"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local l_CFrame_10 = l_l_U_0_0.HumanoidRootPart.CFrame;
					local v938 = l_Assets_0.Particles.Jun.RagingFangs.OutsideClaw:Clone();
					v938.Parent = l_VFX_0;
					v938:PivotTo(l_CFrame_10 * l_v935_0);
					VFXService.EmitParticlesInInstance(v938);
					VFXService.DestroyParticleContainer(v938, 5.5);
				end;
			end);
			local v939 = v0.CFrame.new(0.061999999, 0.0769999027, 45.8689995, -0.296013981, -0.913489103, 0.279129922, 0.945055544, -0.32253325, -0.0533119813, 0.138728574, 0.24801217, 0.958772421);
			local l_v939_0 = v939 --[[ copy: 22 -> 517 ]];
			v860:GetMarkerReachedSignal("Claw5"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local l_CFrame_11 = l_l_U_0_0.HumanoidRootPart.CFrame;
					local v942 = l_Assets_0.Particles.Jun.RagingFangs.OutsideClaw:Clone();
					v942.Parent = l_VFX_0;
					v942:PivotTo(l_CFrame_11 * l_v939_0);
					VFXService.EmitParticlesInInstance(v942);
					VFXService.DestroyParticleContainer(v942, 5.5);
				end;
			end);
			local v943 = v0.CFrame.new(-0.680000007, -0.904999971, 49.9339981, 0.0587979741, -0.968488395, 0.242018819, 0.988582075, 0.0227966812, -0.148948595, 0.138737723, 0.248013332, 0.958770812);
			local l_v943_0 = v943 --[[ copy: 23 -> 518 ]];
			v860:GetMarkerReachedSignal("Claw6"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local l_CFrame_12 = l_l_U_0_0.HumanoidRootPart.CFrame;
					local v946 = l_Assets_0.Particles.Jun.RagingFangs.OutsideClaw:Clone();
					v946.Parent = l_VFX_0;
					v946:PivotTo(l_CFrame_12 * l_v943_0);
					VFXService.EmitParticlesInInstance(v946);
					VFXService.DestroyParticleContainer(v946, 5.5);
				end;
			end);
			local v947 = v0.CFrame.new(0.234999999, 0.763000011, 52.6500015, -0.939047217, 0.076963447, -0.335062265, -0.137161404, -0.977563441, 0.159864008, -0.3152408, 0.196077436, 0.928535044);
			local l_v947_0 = v947 --[[ copy: 24 -> 519 ]];
			v860:GetMarkerReachedSignal("Claw7"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local l_CFrame_13 = l_l_U_0_0.HumanoidRootPart.CFrame;
					local v950 = l_Assets_0.Particles.Jun.RagingFangs.OutsideClaw:Clone();
					v950.Parent = l_VFX_0;
					v950:PivotTo(l_CFrame_13 * l_v947_0);
					VFXService.EmitParticlesInInstance(v950);
					VFXService.DestroyParticleContainer(v950, 5.5);
				end;
			end);
			local v951 = v0.CFrame.new(-0.241999999, 0.977999926, 54.9020004, -0.18825832, -0.968209326, 0.164710805, 0.974853456, -0.204581156, -0.088355422, 0.119243182, 0.143935263, 0.982377052);
			local l_v951_0 = v951 --[[ copy: 25 -> 520 ]];
			v860:GetMarkerReachedSignal("Claw8"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local l_CFrame_14 = l_l_U_0_0.HumanoidRootPart.CFrame;
					local v954 = l_Assets_0.Particles.Jun.RagingFangs.OutsideClaw:Clone();
					v954.Parent = l_VFX_0;
					v954:PivotTo(l_CFrame_14 * l_v951_0);
					VFXService.EmitParticlesInInstance(v954);
					VFXService.DestroyParticleContainer(v954, 5.5);
				end;
			end);
			local v955 = v0.CFrame.new(0.537999988, 1.68300009, 58.8959999, -0.188252673, -0.968211174, 0.164706796, 0.882900238, -0.240292564, -0.403417945, 0.430170864, 0.069475241, 0.900070846);
			local l_v955_0 = v955 --[[ copy: 26 -> 521 ]];
			v860:GetMarkerReachedSignal("Claw9"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local l_CFrame_15 = l_l_U_0_0.HumanoidRootPart.CFrame;
					local v958 = l_Assets_0.Particles.Jun.RagingFangs.OutsideClaw:Clone();
					v958.Parent = l_VFX_0;
					v958:PivotTo(l_CFrame_15 * l_v955_0);
					VFXService.EmitParticlesInInstance(v958);
					VFXService.DestroyParticleContainer(v958, 5.5);
				end;
			end);
			local v959 = v0.CFrame.new(-0.060546875, -0.0766391754, 63.0276123, -1, 0, -0, -0, 1.00000167, -0, -0, 0, -1.00000167);
			local l_v959_0 = v959 --[[ copy: 27 -> 522 ]];
			v860:GetMarkerReachedSignal("Claw10"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local l_CFrame_16 = l_l_U_0_0.HumanoidRootPart.CFrame;
					local v962 = l_Assets_0.Particles.Jun.RagingFangs.Release:Clone();
					v962.Parent = l_VFX_0;
					v962.CFrame = l_CFrame_16 * l_v959_0;
					VFXService.EmitParticlesInInstance(v962);
					VFXService.DestroyParticleContainer(v962, 5.5);
				end;
			end);
			local v963 = v0.CFrame.new(-0.060546875, -0.0766391754, 63.9276123, -1, 0, -0, -0, 1.00000167, -0, -0, 0, -1.00000167);
			local l_v963_0 = v963 --[[ copy: 28 -> 523 ]];
			v860:GetMarkerReachedSignal("Release"):Once(function()
				if l_l_U_0_0 ~= nil and l_l_U_0_0.Parent ~= nil and l_l_V_0_0 ~= nil and l_l_V_0_0.Parent ~= nil then
					local v965 = l_Assets_0.Particles.Jun.RagingFangs.Release:Clone();
					v965.Parent = l_VFX_0;
					v965.CFrame = l_l_U_0_0.HumanoidRootPart.CFrame * l_v963_0;
					VFXService.EmitParticlesInInstance(v965);
					VFXService.DestroyParticleContainer(v965, 5.5);
				end;
			end);
			v860:Play();
			v104.PlaySoundInInstance(l_U_0.Torso, "RagingFangsUserOutside");
		end;
		if l_V_0 ~= nil and l_V_0.Parent ~= nil then
			for _, v967 in v0.pairs(l_V_0.Humanoid.Animator:GetPlayingAnimationTracks()) do
				v967:Stop();
			end;
			local v968 = v0.Instance.new("Animation");
			v968.AnimationId = "rbxassetid://94454770211563";
			v968.Name = "RagingFangsVictimAnimation";
			local v969 = l_V_0.Humanoid.Animator:LoadAnimation(v968);
			v968:Destroy();
			v969.Priority = v0.Enum.AnimationPriority.Action4;
			v969:Play();
			v104.PlaySoundInInstance(l_U_0.Torso, "RagingFangsVictimOutside");
		end;
	end;
	RagingFangsOutStop = function(v724)
		local l_U_1 = v724.U;
		if l_U_1 ~= nil and l_U_1.Parent ~= nil then
			for _, v972 in v0.pairs(l_U_1.Humanoid.Animator:GetPlayingAnimationTracks()) do
				local l_Name_1 = v972.Animation.Name;
				if not (l_Name_1 ~= "RagingFangsUserAnimation") or l_Name_1 == "RagingFangsVictimAnimation" then
					v972:Stop(0);
				end;
			end;
		end;
		local l_V_1 = v724.V;
		if l_V_1 ~= nil and l_V_1.Parent ~= nil then
			for _, v976 in v0.pairs(l_V_1.Humanoid.Animator:GetPlayingAnimationTracks()) do
				local l_Name_2 = v976.Animation.Name;
				if not (l_Name_2 ~= "RagingFangsUserAnimation") or l_Name_2 == "RagingFangsVictimAnimation" then
					v976:Stop(0);
				end;
			end;
		end;
	end;

	RagingFangsCamera = function(v724)
		local l_On_26 = v724.On;
		if not (l_On_26 ~= nil) or l_On_26.Parent == nil then
			return;
		else
			local l_T_0 = v724.T;
			local v986, v987 = VFXService.InitiateCutscene("RagingFangs", 60, 118966102846547, l_On_26.HumanoidRootPart, v0.CFrame.new(-0.0150756836, -2.9598279, -0.117063522, 1, 0, 0, 0, 1, 0, 0, 0, 1), {
				Time = 0.45
			});
			v104.PlaySound("RagingFangsInsideCutscene");
			local _ = {};
			local v989 = v0.OverlapParams.new();
			v989.FilterType = v0.Enum.RaycastFilterType.Exclude;
			local l_v986_0 = v986 --[[ copy: 4 -> 467 ]];
			local l_v989_0 = v989 --[[ copy: 7 -> 468 ]];
			local function _()
				return (workspace:GetPartBoundsInRadius(l_v986_0.Camera.Position, 30, l_v989_0));
			end;
			local v993 = v0.tostring(v0.os.clock());
			local l_v993_0 = v993 --[[ copy: 9 -> 469 ]];
			local l_l_On_26_0 = l_On_26 --[[ copy: 2 -> 470 ]];
			local l_l_T_0_0 = l_T_0 --[[ copy: 3 -> 471 ]];
			local function v1022(v997, v998, v999)
				if typeof(v997) ~= "string" then
					return;
				else
					if typeof(v998) ~= "number" then
						v998 = 0.08333333333333333;
					end;
					local v1000 = {};
					local v1001 = {};
					local v1002 = 0;
					local v1003 = v997 .. l_v993_0;
					local v1004 = false;
					local v1005 = v0.TweenInfo.new(0);
					l_RunService_0:BindToRenderStep(v1003, v0.Enum.RenderPriority.Camera.Value, function(v1006)
						v1002 = v1002 + v1006;
						if l_v986_0 ~= nil and l_v986_0.Parent ~= nil and v1002 < v998 then
							local l_workspace_PartBoundsInRadius_0 = workspace:GetPartBoundsInRadius(l_v986_0.Camera.Position, 30, l_v989_0);
							for _, v1009 in v0.pairs(l_workspace_PartBoundsInRadius_0) do
								local l_Transparency_0 = v1009.Transparency;
								if l_Transparency_0 ~= 1 and v1009:GetAttribute("RFOldT") == nil then
									if not v1009:IsDescendantOf(l_l_On_26_0) and not v1009:IsDescendantOf(l_l_T_0_0) then
										if not (not v1009:IsDescendantOf(l_Tiles_0) and not v1009:IsDescendantOf(l_Trees_0)) or v1009:IsDescendantOf(l_Bushes_0) then
											v1009:SetAttribute("RFOldT", 0);
											l_TweenService_0:Create(v1009, v1005, {
												Transparency = l_Transparency_0
											}):Play();
											v1009.Transparency = 1;
										elseif l_Transparency_0 == 0 then
											v1009:SetAttribute("RFOldT", 0);
											v1009.Transparency = 1;
										else
											v1009:SetAttribute("RFOldT", 1);
											l_TweenService_0:Create(v1009, v1005, {
												Transparency = l_Transparency_0
											}):Play();
											v1009.Transparency = 1;
										end;
										l_TweenService_0:Create(v1009, v1005, {
											Transparency = 1
										}):Play();
										v0.table.insert(v1000, v1009);
									end;
									if v1009.Name == "Head" and v1009:IsDescendantOf(l_Characters_0) and v1009.Parent:FindFirstChild("Humanoid") then
										for _, v1012 in v0.pairs(v1009.Parent:GetDescendants()) do
											if v1012:IsA("BasePart") then
												if not v1009:IsDescendantOf(l_l_On_26_0) and not v1009:IsDescendantOf(l_l_T_0_0) then
													local l_Transparency_1 = v1012.Transparency;
													if l_Transparency_1 ~= 1 and v1012:GetAttribute("RFOldT") == nil then
														v1012:SetAttribute("RFOldT", l_Transparency_1);
														v1012.Transparency = 1;
														v0.table.insert(v1000, v1012);
													end;
												end;
											elseif (v1012:IsA("BillboardGui") or v1012:IsA("SurfaceGui")) and v1012.Enabled ~= false then
												v1012.Enabled = false;
												v0.table.insert(v1001, v1012);
											end;
										end;
									end;
								end;
								for _, v1015 in v0.pairs(v1009:GetDescendants()) do
									if v1015:IsA("Decal") and not v1015:IsDescendantOf(l_l_On_26_0) and not v1015:IsDescendantOf(l_l_T_0_0) then
										local l_Transparency_2 = v1015.Transparency;
										if l_Transparency_2 ~= 1 and v1015:GetAttribute("RFOldT") == nil then
											v1015:SetAttribute("RFOldT", l_Transparency_2);
											v1015.Transparency = 1;
											v0.table.insert(v1000, v1015);
										end;
									elseif (v1015:IsA("BillboardGui") or v1015:IsA("SurfaceGui")) and v1015.Enabled ~= false then
										v1015.Enabled = false;
										v0.table.insert(v1001, v1015);
									end;
								end;
							end;
							return;
						else
							for _, v1018 in v0.pairs(v1000) do
								if v1018 ~= nil and v1018.Parent ~= nil then
									local l_v1018_Attribute_0 = v1018:GetAttribute("RFOldT");
									if typeof(l_v1018_Attribute_0) == "number" then
										v1018.Transparency = l_v1018_Attribute_0;
										v1018:SetAttribute("RFOldT", nil);
									end;
								end;
							end;
							for _, v1021 in v0.pairs(v1001) do
								if v1021 ~= nil and v1021.Parent ~= nil then
									v1021.Enabled = true;
								end;
							end;
							v0.table.clear(v1000);
							v1000 = nil;
							l_RunService_0:UnbindFromRenderStep(v1003);
							if v1004 == false and typeof(v999) == "function" then
								v1004 = true;
								v999();
							end;
							return;
						end;
					end);
					return;
				end;
			end;
			local v1023 = v0.Color3.fromRGB();
			local v1024 = v0.Color3.fromRGB(255, 255, 255);
			local _ = v0.Color3.fromRGB(255, 7, 7);
			local _ = v0.Color3.fromRGB(18, 255, 28);
			local _ = v0.Color3.fromRGB(177, 34, 255);
			local _ = v0.Color3.fromRGB(255, 90, 24);
			local v1029 = v0.TweenInfo.new(0.23, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out);
			local l_v1024_0 = v1024 --[[ copy: 12 -> 472 ]];
			local l_v1029_0 = v1029 --[[ copy: 17 -> 473 ]];
			v987:GetMarkerReachedSignal("NoMoreGames"):Once(function()
				if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil then
					local v1032 = v0.Instance.new("ColorCorrectionEffect");
					v1032.Brightness = 0.3;
					v1032.Contrast = 0.2;
					v1032.Saturation = 0.7;
					v1032.TintColor = l_v1024_0;
					local v1033 = l_TweenService_0:Create(v1032, l_v1029_0, {
						Brightness = 0, 
						Contrast = 0, 
						Saturation = 0
					});
					v1033.Completed:Once(function()
						if v1032 ~= nil and v1032.Parent ~= nil then
							v1032:Destroy();
						end;
					end);
					local v1034 = l_Assets_0.Particles.Jun.RagingFangs.HandAura.Attachment:Clone();
					v1034.Parent = l_l_On_26_0["Right Arm"];
					local v1035 = l_Assets_0.Particles.Jun.RagingFangs.EyeFlash.Attachment1:Clone();
					local v1036 = l_Assets_0.Particles.Jun.RagingFangs.EyeFlash.Attachment2:Clone();
					local v1037 = l_Assets_0.Particles.Jun.RagingFangs.Glare.Glare:Clone();
					v1035.Parent = l_l_On_26_0.Head;
					v1036.Parent = l_l_On_26_0.Head;
					v1037.Parent = l_l_On_26_0["Right Arm"];
					v1032.Parent = l_Lighting_0;
					VFXService.EmitParticlesInInstance(v1037);
					VFXService.EmitParticlesInInstance(v1035);
					VFXService.EmitParticlesInInstance(v1036);
					v1033:Play();
					VFXService.DestroyParticleContainer(v1037, 5);
					VFXService.CreateBind(l_l_On_26_0, "NoMoreGamesEffects", function()
						for _, v1039 in v0.pairs(v1034:GetDescendants()) do
							if v1039:IsA("ParticleEmitter") then
								v1039.Enabled = false;
							end;
						end;
						for _, v1041 in v0.pairs(v1035:GetDescendants()) do
							if v1041:IsA("ParticleEmitter") then
								v1041.Enabled = false;
							end;
						end;
						for _, v1043 in v0.pairs(v1036:GetDescendants()) do
							if v1043:IsA("ParticleEmitter") then
								v1043.Enabled = false;
							end;
						end;
						v0.task.delay(2.75, function()
							if v1034 ~= nil and v1034.Parent ~= nil then
								v1034:Destroy();
							end;
							if v1035 ~= nil and v1035.Parent ~= nil then
								v1035:Destroy();
							end;
							if v1036 ~= nil and v1036.Parent ~= nil then
								v1036:Destroy();
							end;
						end);
					end);
				end;
			end);
			v987:GetMarkerReachedSignal("Stance"):Once(function()
				if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil then
					VFXService.DestroyBind(l_l_On_26_0, "NoMoreGamesEffects");
					local v1044 = l_Assets_0.Particles.Jun.RagingFangs.Stance.Stance:Clone();
					v1044.Parent = l_l_On_26_0.HumanoidRootPart;
					VFXService.EmitParticlesInInstance(v1044);
					VFXService.DestroyParticleContainer(v1044, 6.5);
				end;
			end);
			local v1045 = v0.CFrame.new(-0.360778809, 0.669301987, 20.8292236, 0.661586702, -0.339725614, 0.668498158, -0.315802962, -0.934805691, -0.16252321, 0.680128932, -0.103590466, -0.725741088);
			local l_v1045_0 = v1045 --[[ copy: 18 -> 474 ]];
			v987:GetMarkerReachedSignal("FightSequence1"):Once(function()
				if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil and l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
					local v1047 = l_Assets_0.Particles.Jun.RagingFangs.FightSequenceContact:Clone();
					v1047.Parent = l_VFX_0;
					v1047.CFrame = l_l_On_26_0.HumanoidRootPart.CFrame * l_v1045_0;
					VFXService.EmitParticlesInInstance(v1047);
					VFXService.DestroyParticleContainer(v1047, 2.5);
				end;
			end);
			local v1048 = v0.CFrame.new(0, -2.97658348, 21.5480957, 1, 0, 0, 0, 1.00000334, 0, 0, 0, 1.00000334);
			local l_v1048_0 = v1048 --[[ copy: 19 -> 475 ]];
			v987:GetMarkerReachedSignal("FightSequence2"):Once(function()
				if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil and l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
					local v1050 = l_Assets_0.Particles.Jun.RagingFangs.FightSequenceContact:Clone();
					v1050.Parent = l_VFX_0;
					v1050.CFrame = l_l_On_26_0.HumanoidRootPart.CFrame * l_v1048_0;
					VFXService.EmitParticlesInInstance(v1050);
					VFXService.DestroyParticleContainer(v1050, 2.5);
				end;
			end);
			local v1051 = v0.CFrame.new(-0.0288085938, 0.855768204, 21.0855713, -0.330559224, -0.903576374, 0.272544652, 0.456822723, -0.405881256, -0.79156822, 0.825863063, -0.137155548, 0.546941936);
			local l_v1051_0 = v1051 --[[ copy: 20 -> 476 ]];
			v987:GetMarkerReachedSignal("FightSequence3"):Once(function()
				if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil and l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
					local v1053 = l_Assets_0.Particles.Jun.RagingFangs.FightSequenceContact:Clone();
					v1053.Parent = l_VFX_0;
					v1053.CFrame = l_l_On_26_0.HumanoidRootPart.CFrame * l_v1051_0;
					VFXService.EmitParticlesInInstance(v1053);
					VFXService.DestroyParticleContainer(v1053, 2.5);
				end;
			end);
			local v1054 = v0.CFrame.new(-0.554199219, 0.644006729, 22.7807617, -0.235727489, 0.260855317, -0.936155558, 0.97068882, 0.0166855063, -0.23977378, -0.0469261445, -0.965236962, -0.257142544);
			local l_v1054_0 = v1054 --[[ copy: 21 -> 477 ]];
			v987:GetMarkerReachedSignal("FightSequence4"):Once(function()
				if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil and l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
					local v1056 = l_Assets_0.Particles.Jun.RagingFangs.FightSequenceContact:Clone();
					v1056.Parent = l_VFX_0;
					v1056.CFrame = l_l_On_26_0.HumanoidRootPart.CFrame * l_v1054_0;
					VFXService.EmitParticlesInInstance(v1056);
					VFXService.DestroyParticleContainer(v1056, 2.5);
				end;
			end);
			local v1057 = v0.CFrame.new(-1.2121582, 0.521738052, 21.0405273, -0.889101446, -0.455005914, 0.0496848226, 0.290918946, -0.645573854, -0.706121206, 0.353364527, -0.613359034, 0.706350505);
			local l_v1057_0 = v1057 --[[ copy: 22 -> 478 ]];
			v987:GetMarkerReachedSignal("FightSequence5"):Once(function()
				if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil and l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
					local v1059 = l_Assets_0.Particles.Jun.RagingFangs.FightSequenceContact:Clone();
					v1059.Parent = l_VFX_0;
					v1059.CFrame = l_l_On_26_0.HumanoidRootPart.CFrame * l_v1057_0;
					VFXService.EmitParticlesInInstance(v1059);
					VFXService.DestroyParticleContainer(v1059, 2.5);
				end;
			end);
			local v1060 = v0.CFrame.new(-0.366210938, -0.377147675, 20.6118164, 1, 0, 0, 0, 1.00000167, 0, 0, 0, 1.00000167);
			local l_v1060_0 = v1060 --[[ copy: 23 -> 479 ]];
			v987:GetMarkerReachedSignal("Dodge"):Once(function()
				if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil and l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
					local v1062 = l_Assets_0.Particles.Jun.RagingFangs.Dodge:Clone();
					v1062.Parent = l_VFX_0;
					v1062.CFrame = l_l_On_26_0.HumanoidRootPart.CFrame * l_v1060_0;
					VFXService.EmitParticlesInInstance(v1062);
					VFXService.DestroyParticleContainer(v1062, 2.9);
				end;
			end);
			local v1063 = v0.CFrame.new(-0.0969238281, -0.320796967, 27.460083, 0.970686972, 0.150183365, -0.187647879, -0.043274641, 0.877187312, 0.478197813, 0.236419678, -0.456059992, 0.857973456);
			local v1064 = v0.CFrame.new(0, -2.95629311, 27.4869385, -1, 0, 0, 0, 1.00000167, 0, 0, 0, -1.00000167);
			local l_v1063_0 = v1063 --[[ copy: 24 -> 480 ]];
			local l_v1064_0 = v1064 --[[ copy: 25 -> 481 ]];
			v987:GetMarkerReachedSignal("BodyHit1"):Once(function()
				if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil and l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
					local l_CFrame_17 = l_l_On_26_0.HumanoidRootPart.CFrame;
					local v1068 = l_Assets_0.Particles.Jun.RagingFangs.BodyHit:Clone();
					v1068.Parent = l_VFX_0;
					v1068.CFrame = l_CFrame_17 * l_v1063_0;
					local v1069 = l_Assets_0.Particles.Jun.RagingFangs.BodyHitDust:Clone();
					v1069.Parent = l_VFX_0;
					v1069.CFrame = l_CFrame_17 * l_v1064_0;
					VFXService.EmitParticlesInInstance(v1068);
					VFXService.EmitParticlesInInstance(v1069);
					VFXService.DestroyParticleContainer(v1068, 3.5);
					VFXService.DestroyParticleContainer(v1069, 5.5);
				end;
			end);
			local v1070 = v0.CFrame.new(-0.227539062, -0.267347336, 27.8597412, 0.999589145, -0.0281409733, -0.00544476416, 0.0286621377, 0.982757509, 0.182673857, 2.1026269E-4, -0.182754859, 0.983160317);
			local v1071 = v0.CFrame.new(0, -2.95629311, 27.7869385, -1, 0, 0, 0, 1.00000167, 0, 0, 0, -1.00000167);
			local l_v1070_0 = v1070 --[[ copy: 26 -> 482 ]];
			local l_v1071_0 = v1071 --[[ copy: 27 -> 483 ]];
			v987:GetMarkerReachedSignal("BodyHit2"):Once(function()
				if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil and l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
					local l_CFrame_18 = l_l_On_26_0.HumanoidRootPart.CFrame;
					local v1075 = l_Assets_0.Particles.Jun.RagingFangs.BodyHit:Clone();
					v1075.Parent = l_VFX_0;
					v1075.CFrame = l_CFrame_18 * l_v1070_0;
					local v1076 = l_Assets_0.Particles.Jun.RagingFangs.BodyHitDust:Clone();
					v1076.Parent = l_VFX_0;
					v1076.CFrame = l_CFrame_18 * l_v1071_0;
					VFXService.EmitParticlesInInstance(v1075);
					VFXService.EmitParticlesInInstance(v1076);
					VFXService.DestroyParticleContainer(v1075, 3.5);
					VFXService.DestroyParticleContainer(v1076, 5.5);
				end;
			end);
			local v1077 = v0.CFrame.new(-0.141784668, -0.27664566, 29.2755127, 0.981861234, -0.0626335889, -0.178956911, 0.132401869, 0.902106643, 0.410702616, 0.135714442, -0.426947176, 0.894036412);
			local v1078 = v0.CFrame.new(0, -2.95629311, 28.4869385, -1, 0, 0, 0, 1.00000167, 0, 0, 0, -1.00000167);
			local l_v1077_0 = v1077 --[[ copy: 28 -> 484 ]];
			local l_v1078_0 = v1078 --[[ copy: 29 -> 485 ]];
			v987:GetMarkerReachedSignal("BodyHit3"):Once(function()
				if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil and l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
					local l_CFrame_19 = l_l_On_26_0.HumanoidRootPart.CFrame;
					local v1082 = l_Assets_0.Particles.Jun.RagingFangs.BodyHit:Clone();
					v1082.Parent = l_VFX_0;
					v1082.CFrame = l_CFrame_19 * l_v1077_0;
					local v1083 = l_Assets_0.Particles.Jun.RagingFangs.BodyHitDust:Clone();
					v1083.Parent = l_VFX_0;
					v1083.CFrame = l_CFrame_19 * l_v1078_0;
					VFXService.EmitParticlesInInstance(v1082);
					VFXService.EmitParticlesInInstance(v1083);
					VFXService.DestroyParticleContainer(v1082, 3.5);
					VFXService.DestroyParticleContainer(v1083, 5.5);
				end;
			end);
			local v1084 = {
				v0.CFrame.new(0.71049118, -0.819227457, 28.009634, -1, 0, 0, 0, 1, 0, 0, 0, -1), 
				v0.CFrame.new(0.0880661011, -0.042126894, 32.0998764, 0.231713966, 0.972783983, 0, 0, 0, 1, 0.972783983, -0.231713966, 0), 
				v0.CFrame.new(0.777580261, 0.27737546, 27.037487, 0.0466357097, 0, 0.998911977, 0, 1, 0, -0.998911977, 0, 0.0466357097), 
				v0.CFrame.new(-0.106033325, -0.785628557, 30.8452282, 0, 1, 0, 0, 0, 1, 1, 0, 0), 
				v0.CFrame.new(-3.91207504, -2.30182791, 29.5179348, -1, 0, -8.74227766E-8, 0, 1, 0, 8.74227766E-8, 0, -1), 
				v0.CFrame.new(0.574459076, 0.684072018, 33.115921, 0.231713966, 0.972783983, 0, 0, 0, 1, 0.972783983, -0.231713966, 0), 
				v0.CFrame.new(0.777580261, -0.318288565, 28.0834866, 0.0466357097, 0, 0.998911977, 0, 1, 0, -0.998911977, 0, 0.0466357097), 
				v0.CFrame.new(0.0880661011, 1.84627271, 30.4341278, 0, 1, 0, 0, 0, -1, -1, 0, 0), 
				v0.CFrame.new(-3.91207504, -2.30182791, 31.3254356, -1, 0, 0, 0, 1, 0, 0, 0, -1), 
				v0.CFrame.new(1.06085205, 0.779309511, 32.7960625, 0.231713966, 0.972783983, 0, 0, 0, 1, 0.972783983, -0.231713966, 0), 
				v0.CFrame.new(0.777580261, -0.727227926, 29.1030865, 0.0466357097, 0, 0.998911977, 0, 1, 0, -0.998911977, 0, 0.0466357097), 
				v0.CFrame.new(-2.24403381, 2.23440194, 31.9885387, 0, 1, 0, -0.586089611, 0, 0.810246229, 0.810246229, 0, 0.586089611), 
				v0.CFrame.new(-3.91207504, -2.30182791, 34.1896362, -1, 0, 0, 0, 1, 0, 0, 0, -1), 
				v0.CFrame.new(1.54692459, 0.759572268, 35.5098343, 0.231713966, 0.972783983, 0, 0, 0, 1, 0.972783983, -0.231713966, 0), 
				v0.CFrame.new(0.721382141, -0.535927773, 32.0230865, 0.0466357097, 0, 0.998911977, 0, 1, 0, -0.998911977, 0, 0.0466357097), 
				v0.CFrame.new(-2.04561996, -0.00390076637, 34.5606804, 0, 1, 0, 0.0431137085, 0, 0.999070168, 0.999070168, 0, -0.0431137085), 
				v0.CFrame.new(-3.91207504, -2.30182791, 35.3154335, -1, 0, 0, 0, 1, 0, 0, 0, -1), 
				v0.CFrame.new(1.54724503, 1.40524268, 38.9238052, 0.231713966, 0.972783983, 0, 0, 0, 1, 0.972783983, -0.231713966, 0), 
				v0.CFrame.new(0.721382141, -1.56603026, 36.4297867, -0.208854645, 0.400972664, 0.891964674, -0.488084346, 0.747622788, -0.450371027, -0.847439349, -0.529416025, 0.0395639911), 
				v0.CFrame.new(-1.84720612, 0.379056692, 36.9565582, 0, 1, 0, 0.427484035, 0, 0.904022813, 0.904022813, 0, -0.427484035), 
				v0.CFrame.new(-3.91207504, -2.30182791, 37.7417336, -1, 0, 0, 0, 1, 0, 0, 0, -1), 
				v0.CFrame.new(1.54692459, 1.40517211, 39.7390366, 0.231713966, 0.972783983, 0, 0, 0, 1, 0.972783983, -0.231713966, 0), 
				v0.CFrame.new(0.921867371, 1.39408422, 37.4130783, 0.0365658887, 0.998001516, -0.0515369773, 0.577498615, -0.0631911755, -0.813942432, -0.815572381, 0, -0.578655064), 
				v0.CFrame.new(-1.08403397, 2.16676688, 40.6197586, 0, 1, 0, -0.588871956, 0, 0.808226347, 0.808226347, 0, 0.588871956), 
				v0.CFrame.new(0.710926056, -0.818827868, 41.5255737, -1, 0, 0, 0, 1, 0, 0, 0, -1), 
				v0.CFrame.new(3.66992569, 0.885247946, 42.9402618, 0.231713966, 0.972783983, 0, 0, 0, 1, 0.972783983, -0.231713966, 0), 
				v0.CFrame.new(0.777580261, 0.308982849, 41.8755608, 0.0466357097, 0, 0.998911977, 0, 1, 0, -0.998911977, 0, 0.0466357097), 
				v0.CFrame.new(-0.696075439, -0.398999691, 41.5106544, 0, 1, 0, -0.290402174, 0, 0.956904709, 0.956904709, 0, 0.290402174), 
				v0.CFrame.new(-3.91207504, -2.30182791, 43.6224365, -1, 0, 0, 0, 1, 0, 0, 0, -1), 
				v0.CFrame.new(1.54692459, 1.40517211, 44.7205353, 0.231713966, 0.972783983, 0, 0, 0, 1, 0.972783983, -0.231713966, 0), 
				v0.CFrame.new(1.42086792, 2.15895963, 40.0685806, 0.875162661, -0.482495815, 0.0358928107, 0.457657397, 0.88570075307393, 0.262130976, -0.156971991, -0.212980628, 0.964364588), 
				v0.CFrame.new(-0.88993454, -1.13969016, 43.6196899, 0, 1, 0, -0.532152474, 0, 0.846648872, 0.846648872, 0, 0.532152474), 
				v0.CFrame.new(-3.91207504, -2.30182791, 50.0821342, -1, 0, 0, 0, 1, 0, 0, 0, -1), 
				v0.CFrame.new(1.54692459, 1.40517211, 48.6041336, 0.231713966, 0.972783983, 0, 0, 0, 1, 0.972783983, -0.231713966, 0), 
				v0.CFrame.new(0.777580261, 0.0510718822, 47.0561867, 0.0466357097, 0, 0.998911977, 0, 1, 0, -0.998911977, 0, 0.0466357097), 
				v0.CFrame.new(-0.695835114, -0.0266363621, 50.59729, 0, 1, 0, -0.776178539, 0, -0.630513251, -0.630513251, 0, 0.776178539), 
				v0.CFrame.new(-3.92607498, -0.375827789, 49.6901398, -1, 0, 0, 0, 1, 0, 0, 0, -1), 
				v0.CFrame.new(0.940616608, -0.0218617916, 51.6155777, 0.231713966, 0.972783983, 0, 0, 0, 1, 0.972783983, -0.231713966, 0), 
				v0.CFrame.new(0.921867371, -0.730280638, 51.7416077, 1, 0, 0, 0, 0.986816168, -0.161844969, 0, 0.161844969, 0.986816168), 
				v0.CFrame.new(0.921867371, -0.582880735, 51.7658005, 1, 0, 0, 0, 0.986817896, -0.161845312, 0, 0.161845312, 0.986817896), 
				v0.CFrame.new(-0.695835114, -0.901750326, 45.6719093, 0, 1, 0, 0.0891725421, 0, 0.996016264, 0.996016264, 0, -0.0891725421)
			};
			VFXService.PreloadImages({
				"rbxassetid://86333625784074", 
				"rbxassetid://139182739282261", 
				"rbxassetid://106432490014258", 
				"rbxassetid://109248750293465", 
				"rbxassetid://133485015811474", 
				"rbxassetid://88102631190971", 
				"rbxassetid://72858750673416", 
				"rbxassetid://83406734986939", 
				"rbxassetid://137544061462505", 
				"rbxassetid://137899323302857", 
				"rbxassetid://73493976449131", 
				"rbxassetid://79439851235155", 
				"rbxassetid://78539334088416", 
				"rbxassetid://133501899498273", 
				"rbxassetid://74552856922659", 
				"rbxassetid://111060314305224", 
				"rbxassetid://100335623274441", 
				"rbxassetid://135135211068497", 
				"rbxassetid://118760425063674", 
				"rbxassetid://103685271702361", 
				"rbxassetid://110140421632982", 
				"rbxassetid://114265511384783", 
				"rbxassetid://117638327379125", 
				"rbxassetid://89914097991465", 
				"rbxassetid://100347012466900", 
				"rbxassetid://88543895609719", 
				"rbxassetid://111417915391707", 
				"rbxassetid://84449126452913", 
				"rbxassetid://95421611548040", 
				"rbxassetid://99375269144136", 
				"rbxassetid://82202007344603", 
				"rbxassetid://71312793387751", 
				"rbxassetid://118219089263509", 
				"rbxassetid://89448209667340"
			}, 20);
			local v1085 = {
				86333625784074, 
				139182739282261, 
				106432490014258, 
				109248750293465, 
				133485015811474, 
				88102631190971, 
				72858750673416, 
				83406734986939, 
				137544061462505, 
				137899323302857, 
				73493976449131, 
				79439851235155, 
				78539334088416, 
				133501899498273, 
				74552856922659, 
				111060314305224, 
				100335623274441, 
				135135211068497, 
				118760425063674, 
				103685271702361, 
				110140421632982, 
				114265511384783, 
				117638327379125, 
				89914097991465, 
				100347012466900
			};
			local v1086 = {
				88102631190971, 
				72858750673416, 
				83406734986939, 
				137544061462505, 
				137899323302857, 
				73493976449131, 
				79439851235155, 
				78539334088416, 
				133501899498273, 
				74552856922659, 
				111060314305224, 
				100335623274441, 
				135135211068497, 
				118760425063674, 
				103685271702361, 
				110140421632982, 
				114265511384783, 
				117638327379125, 
				89914097991465, 
				100347012466900
			};
			local v1087 = {
				88543895609719, 
				111417915391707, 
				84449126452913, 
				95421611548040, 
				99375269144136, 
				82202007344603, 
				71312793387751, 
				118219089263509, 
				89448209667340
			};
			local v1088 = {
				84449126452913, 
				82202007344603, 
				71312793387751, 
				118219089263509, 
				89448209667340
			};
			local l_v1086_0 = v1086 --[[ copy: 32 -> 486 ]];
			local l_v1085_0 = v1085 --[[ copy: 31 -> 487 ]];
			v987:GetMarkerReachedSignal("Sequence"):Once(function()
				local v1091 = nil;
				v1091 = if v88.PhotosensitiveMode == true then VFXService.ImpactFrameSequence(l_v1086_0, nil, false) else VFXService.ImpactFrameSequence(l_v1085_0, nil, false);
				v0.task.delay(1.3, function()
					if v1091 ~= nil and v1091.Parent ~= nil then
						v1091:Destroy();
						VFXService.ScreenFlash();
					end;
				end);
			end);
			v987:GetMarkerReachedSignal("EndSequence1"):Once(function()
				VFXService.EndImpactFrameSequences();
				VFXService.ScreenFlash();
				if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil and l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
					local v1092 = l_Assets_0.Particles.Jun.RagingFangs.Knee.Knockback1:Clone();
					v1092.Parent = l_l_On_26_0.HumanoidRootPart;
					VFXService.EmitParticlesInInstance(v1092);
					VFXService.DestroyParticleContainer(v1092, 6.5);
				end;
			end);
			local l_v1088_0 = v1088 --[[ copy: 34 -> 488 ]];
			local l_v1087_0 = v1087 --[[ copy: 33 -> 489 ]];
			v987:GetMarkerReachedSignal("Sequence2"):Once(function()
				local v1095 = nil;
				v1095 = if v88.PhotosensitiveMode == true then VFXService.ImpactFrameSequence(l_v1088_0, nil, false) else VFXService.ImpactFrameSequence(l_v1087_0, nil, false);
				v0.task.delay(1.3, function()
					if v1095 ~= nil and v1095.Parent ~= nil then
						v1095:Destroy();
						VFXService.ScreenFlash();
					end;
				end);
			end);
			v987:GetMarkerReachedSignal("KneeContact"):Once(function()
				if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil and l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
					local v1096 = l_Assets_0.Particles.Jun.RagingFangs.KneeContact.Knee:Clone();
					v1096.Parent = l_l_On_26_0.HumanoidRootPart;
					VFXService.EmitParticlesInInstance(v1096);
					VFXService.DestroyParticleContainer(v1096, 6.5);
				end;
			end);
			local v1097 = v0.CFrame.new(0.00775146484, -0.160217285, 65.0280762, -1, 0, -0, -0, 1.00000167, -0, -0, 0, -1.00000167);
			local l_v1097_0 = v1097 --[[ copy: 35 -> 490 ]];
			v987:GetMarkerReachedSignal("EndSequence2"):Once(function()
				VFXService.EndImpactFrameSequences();
				VFXService.ScreenFlash();
				if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil and l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
					local v1099 = l_Assets_0.Particles.Jun.RagingFangs.Release:Clone();
					v1099.Parent = l_VFX_0;
					v1099.CFrame = l_l_On_26_0.HumanoidRootPart.CFrame * l_v1097_0;
					VFXService.EmitParticlesInInstance(v1099);
					VFXService.DestroyParticleContainer(v1099, 5.5);
				end;
			end);
			v987:GetMarkerReachedSignal("VictimSlam"):Once(function()
				if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil and l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
					local v1100 = l_Assets_0.Particles.Jun.RagingFangs.GroundSlam.Slam1:Clone();
					v1100.Parent = l_l_On_26_0.HumanoidRootPart;
					VFXService.EmitParticlesInInstance(v1100);
					VFXService.DestroyParticleContainer(v1100, 6.5);
				end;
			end);
			v987:GetMarkerReachedSignal("VictimGround"):Once(function()
				if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil and l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
					local v1101 = l_Assets_0.Particles.Jun.RagingFangs.VictimFall.Fall:Clone();
					v1101.Parent = l_l_On_26_0.HumanoidRootPart;
					VFXService.EmitParticlesInInstance(v1101);
					VFXService.DestroyParticleContainer(v1101, 6.5);
				end;
			end);
			v987:GetMarkerReachedSignal("EnableTrail"):Once(function()
				if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil then
					local v1102 = l_Assets_0.Particles.Jun.RagingFangs.ClawHandTrail:Clone();
					local v1103 = v0.Instance.new("WeldConstraint");
					v1103.Parent = v1102;
					v1103.Part0 = l_l_On_26_0["Right Arm"];
					v1102.Parent = l_VFX_0;
					v1102.CFrame = l_l_On_26_0["Right Arm"].CFrame;
					v1103.Part1 = v1102;
					v0.task.delay(0.3, function()
						if v1102 ~= nil and v1102.Parent ~= nil then
							for _, v1105 in v0.pairs(v1102:GetDescendants()) do
								if v1105:IsA("Trail") then
									v1105.Enabled = false;
								end;
							end;
							v0.task.delay(1, function()
								if v1102 ~= nil and v1102.Parent ~= nil then
									v1102:Destroy();
								end;
							end);
						end;
					end);
				end;
			end);
			v987:GetMarkerReachedSignal("HitVictim"):Once(function()
				if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil and l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
					local v1106 = l_Assets_0.Particles.Jun.RagingFangs.VictimSlap.Hit1:Clone();
					v1106.Parent = l_l_T_0_0.Torso;
					local v1107 = l_Assets_0.Particles.Jun.RagingFangs.VictimSlap.Dust:Clone();
					v1107.Parent = l_l_On_26_0.HumanoidRootPart;
					VFXService.EmitParticlesInInstance(v1106);
					VFXService.EmitParticlesInInstance(v1107);
					VFXService.DestroyParticleContainer(v1106, 6.5);
					VFXService.DestroyParticleContainer(v1107, 6.5);
					VFXService.ScreenFlash();
				end;
			end);
			local v1108 = v0.CFrame.new(0.283874512, -0.0667278767, 56.5217438, 0, 0, 1, -1, 0, 0, 0, -1, 0);
			local l_v1108_0 = v1108 --[[ copy: 36 -> 491 ]];
			v987:GetMarkerReachedSignal("SecondReplay"):Once(function()
				if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil then
					local v1110 = l_Assets_0.Particles.Jun.RagingFangs.Replay2:Clone();
					v1110.Parent = l_VFX_0;
					v1110.CFrame = l_l_On_26_0.HumanoidRootPart.CFrame * l_v1108_0;
					VFXService.EmitParticlesInInstance(v1110);
					VFXService.DestroyParticleContainer(v1110, 2);
				end;
			end);
			local v1111 = v0.CFrame.new(-0.060546875, -0.0891113281, 52.9338379, -1, 0, -0, -0, 1.00000167, -0, -0, 0, -1.00000167);
			local l_v1111_0 = v1111 --[[ copy: 37 -> 492 ]];
			v987:GetMarkerReachedSignal("Release"):Once(function()
				if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil and l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
					local v1113 = l_Assets_0.Particles.Jun.RagingFangs.Release:Clone();
					v1113.Parent = l_VFX_0;
					v1113.CFrame = l_l_On_26_0.HumanoidRootPart.CFrame * l_v1111_0;
					VFXService.EmitParticlesInInstance(v1113);
					VFXService.DestroyParticleContainer(v1113, 5.5);
				end;
			end);
			local v1114 = v0.CFrame.new(-0.104309082, -0.167158127, 57.6486816, -1, 0, -0, -0, 1.00000167, -0, -0, 0, -1.00000167);
			local l_v1114_0 = v1114 --[[ copy: 38 -> 493 ]];
			v987:GetMarkerReachedSignal("Release2"):Once(function()
				if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil and l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
					local v1116 = l_Assets_0.Particles.Jun.RagingFangs.Release:Clone();
					v1116.Parent = l_VFX_0;
					v1116.CFrame = l_l_On_26_0.HumanoidRootPart.CFrame * l_v1114_0;
					VFXService.EmitParticlesInInstance(v1116);
					VFXService.DestroyParticleContainer(v1116, 5.5);
				end;
			end);
			local v1117 = v0.CFrame.new(0.16192627, -0.207170963, 63.15, 1, 0, 0, 0, 1, 0, 0, 0, 1);
			local l_v1117_0 = v1117 --[[ copy: 39 -> 494 ]];
			v987:GetMarkerReachedSignal("ThirdReplay"):Once(function()
				if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil then
					local v1119 = l_Assets_0.Particles.Jun.RagingFangs.Replay3:Clone();
					v1119.Parent = l_VFX_0;
					v1119.CFrame = l_l_On_26_0.HumanoidRootPart.CFrame * l_v1117_0;
					VFXService.EmitParticlesInInstance(v1119);
					VFXService.DestroyParticleContainer(v1119, 2);
				end;
			end);
			local l_v1023_0 = v1023 --[[ copy: 11 -> 495 ]];
			local l_v1084_0 = v1084 --[[ copy: 30 -> 496 ]];
			local l_v1022_0 = v1022 --[[ copy: 10 -> 497 ]];
			v987:GetMarkerReachedSignal("Claw1"):Once(function()
				if v88.PhotosensitiveMode == true then
					return;
				else
					if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil then
						local v1123 = {};
						local v1124 = l_Assets_0.Parts.Jun.RagingFangs.RedBackground:Clone();
						local v1125 = l_Assets_0.Particles.Jun.RagingFangs.Emit1:Clone();
						local v1126 = l_Assets_0.Particles.Jun.RagingFangs.Claw1:Clone();
						local v1127 = l_Assets_0.Parts.Jun.RagingFangs.ClawDecal1:Clone();
						v0.table.insert(v1123, v1124);
						v0.table.insert(v1123, v1126);
						v0.table.insert(v1123, v1127);
						v0.table.insert(v1123, v1125);
						local v1128 = v0.Instance.new("Highlight");
						v1128.OutlineTransparency = 1;
						v1128.FillTransparency = 0;
						v1128.FillColor = l_v1023_0;
						v0.table.insert(v1123, v1128);
						local v1129 = nil;
						if l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
							v1129 = v0.Instance.new("Highlight");
							v1129.OutlineTransparency = 1;
							v1129.FillTransparency = 0;
							v1129.FillColor = l_v1023_0;
							v0.table.insert(v1123, v1129);
						end;
						local l_CFrame_20 = l_l_On_26_0.HumanoidRootPart.CFrame;
						v1124.CFrame = l_CFrame_20 * l_v1084_0[1];
						v1125.CFrame = l_CFrame_20 * l_v1084_0[2];
						v1126.CFrame = l_CFrame_20 * l_v1084_0[3];
						v1127.CFrame = l_CFrame_20 * l_v1084_0[4];
						if v88.Blood == false then
							for _, v1132 in v0.pairs(v1125:GetDescendants()) do
								if v1132:IsA("ParticleEmitter") and v1132.Name == "Blood" then
									v1132:Destroy();
								end;
							end;
						end;
						l_v1022_0("RagingFangsClaw1", nil, function()
							for _, v1134 in v0.pairs(v1123) do
								if v1134 ~= nil and v1134.Parent ~= nil then
									v1134:Destroy();
								end;
							end;
						end);
						v1124.Parent = l_VFX_0;
						v1126.Parent = l_VFX_0;
						v1125.Parent = l_VFX_0;
						v1127.Parent = l_VFX_0;
						VFXService.EmitParticlesInInstance(v1125);
						VFXService.DestroyParticleContainer(v1125, 1.5);
						v1128.Parent = l_l_On_26_0;
						if v1129 ~= nil then
							v1129.Parent = l_l_T_0_0;
						end;
					end;
					return;
				end;
			end);
			v987:GetMarkerReachedSignal("Claw2"):Once(function()
				if v88.PhotosensitiveMode == true then
					return;
				else
					if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil then
						local v1135 = {};
						local v1136 = l_Assets_0.Parts.Jun.RagingFangs.RedBackground:Clone();
						local v1137 = l_Assets_0.Particles.Jun.RagingFangs.Emit2:Clone();
						local v1138 = l_Assets_0.Particles.Jun.RagingFangs.Claw2:Clone();
						local v1139 = l_Assets_0.Parts.Jun.RagingFangs.ClawDecal2:Clone();
						v0.table.insert(v1135, v1136);
						v0.table.insert(v1135, v1138);
						v0.table.insert(v1135, v1139);
						v0.table.insert(v1135, v1137);
						local v1140 = v0.Instance.new("Highlight");
						v1140.OutlineTransparency = 1;
						v1140.FillTransparency = 0;
						v1140.FillColor = l_v1023_0;
						v0.table.insert(v1135, v1140);
						local v1141 = nil;
						if l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
							v1141 = v0.Instance.new("Highlight");
							v1141.OutlineTransparency = 1;
							v1141.FillTransparency = 0;
							v1141.FillColor = l_v1023_0;
							v0.table.insert(v1135, v1141);
						end;
						local l_CFrame_21 = l_l_On_26_0.HumanoidRootPart.CFrame;
						v1136.CFrame = l_CFrame_21 * l_v1084_0[5];
						v1137.CFrame = l_CFrame_21 * l_v1084_0[6];
						v1138.CFrame = l_CFrame_21 * l_v1084_0[7];
						v1139.CFrame = l_CFrame_21 * l_v1084_0[8];
						if v88.Blood == false then
							for _, v1144 in v0.pairs(v1137:GetDescendants()) do
								if v1144:IsA("ParticleEmitter") and v1144.Name == "Blood" then
									v1144:Destroy();
								end;
							end;
						end;
						l_v1022_0("RagingFangsClaw2", nil, function()
							for _, v1146 in v0.pairs(v1135) do
								if v1146 ~= nil and v1146.Parent ~= nil then
									v1146:Destroy();
								end;
							end;
						end);
						v1136.Parent = l_VFX_0;
						v1138.Parent = l_VFX_0;
						v1137.Parent = l_VFX_0;
						v1139.Parent = l_VFX_0;
						VFXService.EmitParticlesInInstance(v1137);
						VFXService.DestroyParticleContainer(v1137, 1.5);
						v1140.Parent = l_l_On_26_0;
						if v1141 ~= nil then
							v1141.Parent = l_l_T_0_0;
						end;
					end;
					return;
				end;
			end);
			v987:GetMarkerReachedSignal("Claw3"):Once(function()
				if v88.PhotosensitiveMode == true then
					return;
				else
					if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil then
						local v1147 = {};
						local v1148 = l_Assets_0.Parts.Jun.RagingFangs.RedBackground:Clone();
						local v1149 = l_Assets_0.Particles.Jun.RagingFangs.Emit3:Clone();
						local v1150 = l_Assets_0.Particles.Jun.RagingFangs.Claw3:Clone();
						local v1151 = l_Assets_0.Parts.Jun.RagingFangs.ClawDecal3:Clone();
						v0.table.insert(v1147, v1148);
						v0.table.insert(v1147, v1150);
						v0.table.insert(v1147, v1151);
						v0.table.insert(v1147, v1149);
						local v1152 = v0.Instance.new("Highlight");
						v1152.OutlineTransparency = 1;
						v1152.FillTransparency = 0;
						v1152.FillColor = l_v1023_0;
						v0.table.insert(v1147, v1152);
						local v1153 = nil;
						if l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
							v1153 = v0.Instance.new("Highlight");
							v1153.OutlineTransparency = 1;
							v1153.FillTransparency = 0;
							v1153.FillColor = l_v1023_0;
							v0.table.insert(v1147, v1153);
						end;
						local l_CFrame_22 = l_l_On_26_0.HumanoidRootPart.CFrame;
						v1148.CFrame = l_CFrame_22 * l_v1084_0[9];
						v1149.CFrame = l_CFrame_22 * l_v1084_0[10];
						v1150.CFrame = l_CFrame_22 * l_v1084_0[11];
						v1151.CFrame = l_CFrame_22 * l_v1084_0[12];
						if v88.Blood == false then
							for _, v1156 in v0.pairs(v1149:GetDescendants()) do
								if v1156:IsA("ParticleEmitter") and v1156.Name == "Blood" then
									v1156:Destroy();
								end;
							end;
						end;
						l_v1022_0("RagingFangsClaw3", nil, function()
							for _, v1158 in v0.pairs(v1147) do
								if v1158 ~= nil and v1158.Parent ~= nil then
									v1158:Destroy();
								end;
							end;
						end);
						v1148.Parent = l_VFX_0;
						v1150.Parent = l_VFX_0;
						v1149.Parent = l_VFX_0;
						v1151.Parent = l_VFX_0;
						VFXService.EmitParticlesInInstance(v1149);
						VFXService.DestroyParticleContainer(v1149, 1.5);
						v1152.Parent = l_l_On_26_0;
						if v1153 ~= nil then
							v1153.Parent = l_l_T_0_0;
						end;
					end;
					return;
				end;
			end);
			v987:GetMarkerReachedSignal("Claw4"):Once(function()
				if v88.PhotosensitiveMode == true then
					return;
				else
					if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil then
						local v1159 = {};
						local v1160 = l_Assets_0.Parts.Jun.RagingFangs.RedBackground:Clone();
						local v1161 = l_Assets_0.Particles.Jun.RagingFangs.Emit4:Clone();
						local v1162 = l_Assets_0.Particles.Jun.RagingFangs.Claw4:Clone();
						local v1163 = l_Assets_0.Parts.Jun.RagingFangs.ClawDecal4:Clone();
						v0.table.insert(v1159, v1160);
						v0.table.insert(v1159, v1162);
						v0.table.insert(v1159, v1163);
						v0.table.insert(v1159, v1161);
						local v1164 = v0.Instance.new("Highlight");
						v1164.OutlineTransparency = 1;
						v1164.FillTransparency = 0;
						v1164.FillColor = l_v1023_0;
						v0.table.insert(v1159, v1164);
						local v1165 = nil;
						if l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
							v1165 = v0.Instance.new("Highlight");
							v1165.OutlineTransparency = 1;
							v1165.FillTransparency = 0;
							v1165.FillColor = l_v1023_0;
							v0.table.insert(v1159, v1165);
						end;
						local l_CFrame_23 = l_l_On_26_0.HumanoidRootPart.CFrame;
						v1160.CFrame = l_CFrame_23 * l_v1084_0[13];
						v1161.CFrame = l_CFrame_23 * l_v1084_0[14];
						v1162.CFrame = l_CFrame_23 * l_v1084_0[15];
						v1163.CFrame = l_CFrame_23 * l_v1084_0[16];
						if v88.Blood == false then
							for _, v1168 in v0.pairs(v1161:GetDescendants()) do
								if v1168:IsA("ParticleEmitter") and v1168.Name == "Blood" then
									v1168:Destroy();
								end;
							end;
						end;
						l_v1022_0("RagingFangsClaw4", nil, function()
							for _, v1170 in v0.pairs(v1159) do
								if v1170 ~= nil and v1170.Parent ~= nil then
									v1170:Destroy();
								end;
							end;
						end);
						v1160.Parent = l_VFX_0;
						v1162.Parent = l_VFX_0;
						v1161.Parent = l_VFX_0;
						v1163.Parent = l_VFX_0;
						VFXService.EmitParticlesInInstance(v1161);
						VFXService.DestroyParticleContainer(v1161, 1.5);
						v1164.Parent = l_l_On_26_0;
						if v1165 ~= nil then
							v1165.Parent = l_l_T_0_0;
						end;
					end;
					return;
				end;
			end);
			v987:GetMarkerReachedSignal("Claw5"):Once(function()
				if v88.PhotosensitiveMode == true then
					return;
				else
					if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil then
						local v1171 = {};
						local v1172 = l_Assets_0.Parts.Jun.RagingFangs.RedBackground:Clone();
						local v1173 = l_Assets_0.Particles.Jun.RagingFangs.Emit5:Clone();
						local v1174 = l_Assets_0.Particles.Jun.RagingFangs.Claw5:Clone();
						local v1175 = l_Assets_0.Parts.Jun.RagingFangs.ClawDecal5:Clone();
						v0.table.insert(v1171, v1172);
						v0.table.insert(v1171, v1174);
						v0.table.insert(v1171, v1175);
						v0.table.insert(v1171, v1173);
						local v1176 = v0.Instance.new("Highlight");
						v1176.OutlineTransparency = 1;
						v1176.FillTransparency = 0;
						v1176.FillColor = l_v1023_0;
						v0.table.insert(v1171, v1176);
						local v1177 = nil;
						if l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
							v1177 = v0.Instance.new("Highlight");
							v1177.OutlineTransparency = 1;
							v1177.FillTransparency = 0;
							v1177.FillColor = l_v1023_0;
							v0.table.insert(v1171, v1177);
						end;
						local l_CFrame_24 = l_l_On_26_0.HumanoidRootPart.CFrame;
						v1172.CFrame = l_CFrame_24 * l_v1084_0[17];
						v1173.CFrame = l_CFrame_24 * l_v1084_0[18];
						v1174.CFrame = l_CFrame_24 * l_v1084_0[19];
						v1175.CFrame = l_CFrame_24 * l_v1084_0[20];
						if v88.Blood == false then
							for _, v1180 in v0.pairs(v1173:GetDescendants()) do
								if v1180:IsA("ParticleEmitter") and v1180.Name == "Blood" then
									v1180:Destroy();
								end;
							end;
						end;
						l_v1022_0("RagingFangsClaw5", nil, function()
							for _, v1182 in v0.pairs(v1171) do
								if v1182 ~= nil and v1182.Parent ~= nil then
									v1182:Destroy();
								end;
							end;
						end);
						v1172.Parent = l_VFX_0;
						v1174.Parent = l_VFX_0;
						v1173.Parent = l_VFX_0;
						v1175.Parent = l_VFX_0;
						VFXService.EmitParticlesInInstance(v1173);
						VFXService.DestroyParticleContainer(v1173, 1.5);
						v1176.Parent = l_l_On_26_0;
						if v1177 ~= nil then
							v1177.Parent = l_l_T_0_0;
						end;
					end;
					return;
				end;
			end);
			v987:GetMarkerReachedSignal("Claw6"):Once(function()
				if v88.PhotosensitiveMode == true then
					return;
				else
					if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil then
						local v1183 = {};
						local v1184 = l_Assets_0.Parts.Jun.RagingFangs.RedBackground:Clone();
						local v1185 = l_Assets_0.Particles.Jun.RagingFangs.Emit6:Clone();
						local v1186 = l_Assets_0.Particles.Jun.RagingFangs.Claw6:Clone();
						local v1187 = l_Assets_0.Parts.Jun.RagingFangs.ClawDecal6:Clone();
						v0.table.insert(v1183, v1184);
						v0.table.insert(v1183, v1186);
						v0.table.insert(v1183, v1187);
						v0.table.insert(v1183, v1185);
						local v1188 = v0.Instance.new("Highlight");
						v1188.OutlineTransparency = 1;
						v1188.FillTransparency = 0;
						v1188.FillColor = l_v1023_0;
						v0.table.insert(v1183, v1188);
						local v1189 = nil;
						if l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
							v1189 = v0.Instance.new("Highlight");
							v1189.OutlineTransparency = 1;
							v1189.FillTransparency = 0;
							v1189.FillColor = l_v1023_0;
							v0.table.insert(v1183, v1189);
						end;
						local l_CFrame_25 = l_l_On_26_0.HumanoidRootPart.CFrame;
						v1184.CFrame = l_CFrame_25 * l_v1084_0[21];
						v1185.CFrame = l_CFrame_25 * l_v1084_0[22];
						v1186.CFrame = l_CFrame_25 * l_v1084_0[23];
						v1187.CFrame = l_CFrame_25 * l_v1084_0[24];
						if v88.Blood == false then
							for _, v1192 in v0.pairs(v1185:GetDescendants()) do
								if v1192:IsA("ParticleEmitter") and v1192.Name == "Blood" then
									v1192:Destroy();
								end;
							end;
						end;
						l_v1022_0("RagingFangsClaw6", nil, function()
							for _, v1194 in v0.pairs(v1183) do
								if v1194 ~= nil and v1194.Parent ~= nil then
									v1194:Destroy();
								end;
							end;
						end);
						v1184.Parent = l_VFX_0;
						v1186.Parent = l_VFX_0;
						v1185.Parent = l_VFX_0;
						v1187.Parent = l_VFX_0;
						VFXService.EmitParticlesInInstance(v1185);
						VFXService.DestroyParticleContainer(v1185, 1.5);
						v1188.Parent = l_l_On_26_0;
						if v1189 ~= nil then
							v1189.Parent = l_l_T_0_0;
						end;
					end;
					return;
				end;
			end);
			v987:GetMarkerReachedSignal("Claw7"):Once(function()
				if v88.PhotosensitiveMode == true then
					return;
				else
					if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil then
						local v1195 = {};
						local v1196 = l_Assets_0.Parts.Jun.RagingFangs.RedBackground:Clone();
						local v1197 = l_Assets_0.Particles.Jun.RagingFangs.Emit7:Clone();
						local v1198 = l_Assets_0.Particles.Jun.RagingFangs.Claw7:Clone();
						local v1199 = l_Assets_0.Parts.Jun.RagingFangs.ClawDecal7:Clone();
						v0.table.insert(v1195, v1196);
						v0.table.insert(v1195, v1198);
						v0.table.insert(v1195, v1199);
						v0.table.insert(v1195, v1197);
						local v1200 = v0.Instance.new("Highlight");
						v1200.OutlineTransparency = 1;
						v1200.FillTransparency = 0;
						v1200.FillColor = l_v1023_0;
						v0.table.insert(v1195, v1200);
						local v1201 = nil;
						if l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
							v1201 = v0.Instance.new("Highlight");
							v1201.OutlineTransparency = 1;
							v1201.FillTransparency = 0;
							v1201.FillColor = l_v1023_0;
							v0.table.insert(v1195, v1201);
						end;
						local l_CFrame_26 = l_l_On_26_0.HumanoidRootPart.CFrame;
						v1196.CFrame = l_CFrame_26 * l_v1084_0[25];
						v1197.CFrame = l_CFrame_26 * l_v1084_0[26];
						v1198.CFrame = l_CFrame_26 * l_v1084_0[27];
						v1199.CFrame = l_CFrame_26 * l_v1084_0[28];
						if v88.Blood == false then
							for _, v1204 in v0.pairs(v1197:GetDescendants()) do
								if v1204:IsA("ParticleEmitter") and v1204.Name == "Blood" then
									v1204:Destroy();
								end;
							end;
						end;
						l_v1022_0("RagingFangsClaw7", nil, function()
							for _, v1206 in v0.pairs(v1195) do
								if v1206 ~= nil and v1206.Parent ~= nil then
									v1206:Destroy();
								end;
							end;
						end);
						v1196.Parent = l_VFX_0;
						v1198.Parent = l_VFX_0;
						v1197.Parent = l_VFX_0;
						v1199.Parent = l_VFX_0;
						VFXService.EmitParticlesInInstance(v1197);
						VFXService.DestroyParticleContainer(v1197, 1.5);
						v1200.Parent = l_l_On_26_0;
						if v1201 ~= nil then
							v1201.Parent = l_l_T_0_0;
						end;
					end;
					return;
				end;
			end);
			v987:GetMarkerReachedSignal("Claw8"):Once(function()
				if v88.PhotosensitiveMode == true then
					return;
				else
					if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil then
						local v1207 = {};
						local v1208 = l_Assets_0.Parts.Jun.RagingFangs.RedBackground:Clone();
						local v1209 = l_Assets_0.Particles.Jun.RagingFangs.Emit8:Clone();
						local v1210 = l_Assets_0.Particles.Jun.RagingFangs.Claw8:Clone();
						local v1211 = l_Assets_0.Parts.Jun.RagingFangs.ClawDecal8:Clone();
						v0.table.insert(v1207, v1208);
						v0.table.insert(v1207, v1210);
						v0.table.insert(v1207, v1211);
						v0.table.insert(v1207, v1209);
						local v1212 = v0.Instance.new("Highlight");
						v1212.OutlineTransparency = 1;
						v1212.FillTransparency = 0;
						v1212.FillColor = l_v1023_0;
						v0.table.insert(v1207, v1212);
						local v1213 = nil;
						if l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
							v1213 = v0.Instance.new("Highlight");
							v1213.OutlineTransparency = 1;
							v1213.FillTransparency = 0;
							v1213.FillColor = l_v1023_0;
							v0.table.insert(v1207, v1213);
						end;
						local l_CFrame_27 = l_l_On_26_0.HumanoidRootPart.CFrame;
						v1208.CFrame = l_CFrame_27 * l_v1084_0[29];
						v1209.CFrame = l_CFrame_27 * l_v1084_0[30];
						v1210.CFrame = l_CFrame_27 * l_v1084_0[31];
						v1211.CFrame = l_CFrame_27 * l_v1084_0[32];
						if v88.Blood == false then
							for _, v1216 in v0.pairs(v1209:GetDescendants()) do
								if v1216:IsA("ParticleEmitter") and v1216.Name == "Blood" then
									v1216:Destroy();
								end;
							end;
						end;
						l_v1022_0("RagingFangsClaw8", nil, function()
							for _, v1218 in v0.pairs(v1207) do
								if v1218 ~= nil and v1218.Parent ~= nil then
									v1218:Destroy();
								end;
							end;
						end);
						v1208.Parent = l_VFX_0;
						v1210.Parent = l_VFX_0;
						v1209.Parent = l_VFX_0;
						v1211.Parent = l_VFX_0;
						VFXService.EmitParticlesInInstance(v1209);
						VFXService.DestroyParticleContainer(v1209, 1.5);
						v1212.Parent = l_l_On_26_0;
						if v1213 ~= nil then
							v1213.Parent = l_l_T_0_0;
						end;
					end;
					return;
				end;
			end);
			v987:GetMarkerReachedSignal("Claw9"):Once(function()
				if v88.PhotosensitiveMode == true then
					return;
				else
					if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil then
						local v1219 = {};
						local v1220 = l_Assets_0.Parts.Jun.RagingFangs.RedBackground:Clone();
						local v1221 = l_Assets_0.Particles.Jun.RagingFangs.Emit9:Clone();
						local v1222 = l_Assets_0.Particles.Jun.RagingFangs.Claw9:Clone();
						local v1223 = l_Assets_0.Parts.Jun.RagingFangs.ClawDecal9:Clone();
						v0.table.insert(v1219, v1220);
						v0.table.insert(v1219, v1222);
						v0.table.insert(v1219, v1223);
						v0.table.insert(v1219, v1221);
						local v1224 = v0.Instance.new("Highlight");
						v1224.OutlineTransparency = 1;
						v1224.FillTransparency = 0;
						v1224.FillColor = l_v1023_0;
						v0.table.insert(v1219, v1224);
						local v1225 = nil;
						if l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
							v1225 = v0.Instance.new("Highlight");
							v1225.OutlineTransparency = 1;
							v1225.FillTransparency = 0;
							v1225.FillColor = l_v1023_0;
							v0.table.insert(v1219, v1225);
						end;
						local l_CFrame_28 = l_l_On_26_0.HumanoidRootPart.CFrame;
						v1220.CFrame = l_CFrame_28 * l_v1084_0[33];
						v1221.CFrame = l_CFrame_28 * l_v1084_0[34];
						v1222.CFrame = l_CFrame_28 * l_v1084_0[35];
						v1223.CFrame = l_CFrame_28 * l_v1084_0[36];
						if v88.Blood == false then
							for _, v1228 in v0.pairs(v1221:GetDescendants()) do
								if v1228:IsA("ParticleEmitter") and v1228.Name == "Blood" then
									v1228:Destroy();
								end;
							end;
						end;
						l_v1022_0("RagingFangsClaw9", nil, function()
							for _, v1230 in v0.pairs(v1219) do
								if v1230 ~= nil and v1230.Parent ~= nil then
									v1230:Destroy();
								end;
							end;
						end);
						v1220.Parent = l_VFX_0;
						v1222.Parent = l_VFX_0;
						v1221.Parent = l_VFX_0;
						v1223.Parent = l_VFX_0;
						VFXService.EmitParticlesInInstance(v1221);
						VFXService.DestroyParticleContainer(v1221, 1.5);
						v1224.Parent = l_l_On_26_0;
						if v1225 ~= nil then
							v1225.Parent = l_l_T_0_0;
						end;
					end;
					return;
				end;
			end);
			local v1231 = v0.TweenInfo.new(0.3333333333333333, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out);
			local l_v1231_0 = v1231 --[[ copy: 40 -> 498 ]];
			v987:GetMarkerReachedSignal("Claw10"):Once(function()
				if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil then
					local v1233 = {};
					local v1234 = l_Assets_0.Parts.Jun.RagingFangs.RedBackground:Clone();
					local v1235 = l_Assets_0.Particles.Jun.RagingFangs.Emit10:Clone();
					local v1236 = l_Assets_0.Particles.Jun.RagingFangs.Claw10:Clone();
					local v1237 = l_Assets_0.Particles.Jun.RagingFangs.Claw10Extra:Clone();
					local v1238 = l_Assets_0.Parts.Jun.RagingFangs.ClawDecal10:Clone();
					local v1239 = v0.Instance.new("BlurEffect");
					local v1240 = v0.Instance.new("ColorCorrectionEffect");
					v0.table.insert(v1233, v1234);
					v0.table.insert(v1233, v1236);
					v0.table.insert(v1233, v1237);
					v0.table.insert(v1233, v1238);
					v0.table.insert(v1233, v1235);
					v0.table.insert(v1233, v1239);
					v0.table.insert(v1233, v1240);
					local v1241 = v0.Instance.new("Highlight");
					v1241.OutlineTransparency = 1;
					v1241.FillTransparency = 0;
					v1241.FillColor = l_v1023_0;
					v0.table.insert(v1233, v1241);
					local v1242 = nil;
					if l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
						v1242 = v0.Instance.new("Highlight");
						v1242.OutlineTransparency = 1;
						v1242.FillTransparency = 0;
						v1242.FillColor = l_v1023_0;
						v0.table.insert(v1233, v1242);
					end;
					local l_CFrame_29 = l_l_On_26_0.HumanoidRootPart.CFrame;
					v1234.CFrame = l_CFrame_29 * l_v1084_0[37];
					v1235.CFrame = l_CFrame_29 * l_v1084_0[38];
					v1236.CFrame = l_CFrame_29 * l_v1084_0[39];
					v1237.CFrame = l_CFrame_29 * l_v1084_0[40];
					v1238.CFrame = l_CFrame_29 * l_v1084_0[41];
					v1239.Size = 2.4;
					v1240.TintColor = l_v1024_0;
					v1240.Brightness = 0.24;
					v1240.Contrast = 0.12;
					v1240.Saturation = 0.08;
					if v88.Blood == false then
						for _, v1245 in v0.pairs(v1235:GetDescendants()) do
							if v1245:IsA("ParticleEmitter") and v1245.Name == "Blood" then
								v1245:Destroy();
							end;
						end;
					end;
					local v1246 = {};
					local l_PhotosensitiveMode_0 = v88.PhotosensitiveMode;
					if l_PhotosensitiveMode_0 == false then
						l_v1022_0("RagingFangsClaw11", 0.41666666666666663, function()
							for _, v1249 in v0.pairs(v1246) do
								if v1249 ~= nil and v1249.Parent ~= nil then
									v1249:Destroy();
								end;
							end;
							v0.task.delay(3, function()
								for _, v1251 in v0.pairs(v1246) do
									if v1251 ~= nil and v1251.Parent ~= nil then
										v1251:Destroy();
									end;
								end;
							end);
						end);
					end;
					do
						local l_v1242_0 = v1242;
						l_v1022_0("RagingFangsClaw10", 0.3333333333333333, function()
							if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil and l_PhotosensitiveMode_0 == false then
								local v1253 = l_Assets_0.Parts.Jun.RagingFangs.BlackBackground:Clone();
								local v1254 = l_Assets_0.Particles.Jun.RagingFangs.Emit11:Clone();
								local v1255 = l_Assets_0.Parts.Jun.RagingFangs.ClawDecal11:Clone();
								v0.table.insert(v1246, v1253);
								v0.table.insert(v1246, v1254);
								v0.table.insert(v1246, v1255);
								local l_CFrame_30 = l_l_On_26_0.HumanoidRootPart.CFrame;
								v1253.CFrame = l_CFrame_30 * l_v1084_0[37];
								v1254.CFrame = l_CFrame_30 * l_v1084_0[38];
								v1255.CFrame = l_CFrame_30 * l_v1084_0[41];
								local v1257 = v0.Instance.new("Highlight");
								v1257.FillTransparency = 0;
								v1257.OutlineTransparency = 1;
								v1257.FillColor = l_v1024_0;
								v0.table.insert(v1246, v1257);
								local v1258 = nil;
								if l_l_T_0_0 ~= nil and l_l_T_0_0.Parent ~= nil then
									v1258 = v0.Instance.new("Highlight");
									v1258.FillTransparency = 0;
									v1258.OutlineTransparency = 1;
									v1258.FillColor = l_v1024_0;
									v0.table.insert(v1246, v1258);
								end;
								v1253.Parent = l_VFX_0;
								if v1234 ~= nil and v1234.Parent ~= nil then
									v1234:Destroy();
								end;
								v1255.Parent = l_VFX_0;
								if v1238 ~= nil and v1238.Parent ~= nil then
									v1238:Destroy();
								end;
								v1254.Parent = l_VFX_0;
								VFXService.EmitParticlesInInstance(v1254);
								if v1258 ~= nil then
									v1258.Parent = l_l_T_0_0;
									v1257.Parent = l_l_On_26_0;
								end;
								v1257.Parent = l_l_On_26_0;
								if v1241 ~= nil and v1241.Parent ~= nil then
									v1241:Destroy();
								end;
								if l_v1242_0 ~= nil and l_v1242_0.Parent ~= nil then
									l_v1242_0:Destroy();
								end;
								for _, v1260 in v0.pairs(v1233) do
									if v1260 ~= nil and v1260.Parent ~= nil then
										v1260:Destroy();
									end;
								end;
								return;
							else
								for _, v1262 in v0.pairs(v1233) do
									if v1262 ~= nil and v1262.Parent ~= nil then
										v1262:Destroy();
									end;
								end;
								return;
							end;
						end);
						v1234.Parent = l_VFX_0;
						v1236.Parent = l_VFX_0;
						v1237.Parent = l_VFX_0;
						v1235.Parent = l_VFX_0;
						v1238.Parent = l_VFX_0;
						v1239.Parent = l_Lighting_0;
						v1240.Parent = l_Lighting_0;
						VFXService.EmitParticlesInInstance(v1235);
						VFXService.DestroyParticleContainer(v1235, 1.5);
						for _, v1264 in v0.pairs(v1236:GetDescendants()) do
							if v1264:IsA("Beam") then
								l_TweenService_0:Create(v1264, l_v1231_0, {
									Width1 = 0
								}):Play();
							end;
						end;
						for _, v1266 in v0.pairs(v1237:GetDescendants()) do
							if v1266:IsA("Beam") then
								l_TweenService_0:Create(v1266, l_v1231_0, {
									Width1 = 0
								}):Play();
							end;
						end;
						l_TweenService_0:Create(v1239, l_v1231_0, {
							Size = 0
						}):Play();
						l_TweenService_0:Create(v1240, l_v1231_0, {
							Brightness = 0, 
							Contrast = 0, 
							Saturation = 0
						}):Play();
						v1241.Parent = l_l_On_26_0;
						if l_v1242_0 ~= nil then
							l_v1242_0.Parent = l_l_T_0_0;
						end;
					end;
				end;
			end);
			local v1267 = v0.CFrame.new(0.060962677, 1.18269944, 54.59729, 1, 0, 0, 0, 1, 0, 0, 0, 1);
			local v1268 = v0.CFrame.new(0.026260376, 4.11506844, 54.3320885, -1, 0, 0, 0, 1, 0, 0, 0, -1);
			local v1269 = v0.TweenInfo.new(0.4, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out, 0, true);
			v987:GetMarkerReachedSignal("Text"):Once(function()
				if l_l_On_26_0 ~= nil and l_l_On_26_0.Parent ~= nil then
					local v1270 = l_Assets_0.Parts.Jun.RagingFangs.BlackBackground2:Clone();
					local v1271 = l_Assets_0.Particles.Jun.RagingFangs.Text:Clone();
					local l_CFrame_31 = l_l_On_26_0.HumanoidRootPart.CFrame;
					local v1273 = l_TweenService_0:Create(v1270, v1269, {
						Transparency = 0.3
					});
					v1270.CFrame = l_CFrame_31 * v1268;
					v1271.CFrame = l_CFrame_31 * v1267;
					v1273.Completed:Once(function()
						if v1270 ~= nil and v1270.Parent ~= nil then
							v1270:Destroy();
						end;
					end);
					v1270.Parent = l_VFX_0;
					v1271.Parent = l_VFX_0;
					v1273:Play();
					VFXService.EmitParticlesInInstance(v1271);
					VFXService.DestroyParticleContainer(v1271, 2);
				end;
			end);
		end;
	end;
	EndRagingFangsCamera = function(v724)
		l_Humanoid_0.CameraOffset = v0.Vector3.zero;
		VFXService.EndImpactFrameSequences();
		VFXService.ScreenFlash();
		local l_CameraMinZoomDistance_0 = l_LocalPlayer_0.CameraMinZoomDistance;
		local l_CameraMaxZoomDistance_0 = l_LocalPlayer_0.CameraMaxZoomDistance;
		l_LocalPlayer_0.CameraMinZoomDistance = 78;
		l_LocalPlayer_0.CameraMaxZoomDistance = 78;
		l_CurrentCamera_1.CFrame = l_HumanoidRootPart_0.CFrame * v0.CFrame.Angles(-v0.math.pi / 8, 0, 0);
		VFXService.EndCutscene();
		VFXService.ShakeCamera(0, 0.8, 29, 0.725, 0.75, 0.725);
		l_LocalPlayer_0.CameraMinZoomDistance = l_CameraMinZoomDistance_0;
		l_LocalPlayer_0.CameraMaxZoomDistance = l_CameraMaxZoomDistance_0;
	end;
	RagingFangsTeleport = function(v724)
		local l_O_0 = v724.O;
		local l_N_0 = v724.N;
		local v1278 = l_Assets_0.Particles.Jun.RagingFangs.ForwardTeleport:Clone();
		v1278.CFrame = v0.CFrame.new(l_O_0, l_N_0);
		v1278.Parent = l_VFX_0;
		VFXService.EmitParticlesInInstance(v1278);
		VFXService.DestroyParticleContainer(v1278, 5.3);
	end;
	RagingFangsLand = function(v724)
		local l_At_0 = v724.At;
		local v1280 = l_Assets_0.Particles.Jun.RagingFangs.LandTeleport:Clone();
		v1280.Position = l_At_0;
		v1280.Parent = l_VFX_0;
		VFXService.EmitParticlesInInstance(v1280);
		VFXService.DestroyParticleContainer(v1280, 4);
	end;
	RagingFangsGroundClaw = function(v724)
		local l_F_0 = v724.F;
		local v1294 = v724.At * v0.CFrame.Angles(v0.math.pi / 2, 0, v0.math.pi / 2) + v0.Vector3.new(0, 0.01, 0);
		local v1295 = l_Assets_0.Particles.Jun.RagingFangs.GroundClaw:Clone();
		v1295:PivotTo(v1294);
		v1295.Parent = l_VFX_0;
		local v1296 = {};
		for _, v1298 in v0.pairs(v1295:GetDescendants()) do
			if v1298:IsA("Attachment") and v1298.Name == "FlyingRocksNode" then
				local v1299 = v1298.WorldCFrame + v0.Vector3.new(0, 2, 0);
				local v1300 = v0.math.random(1, 3);
				if v1300 == 1 then
					VFXService.GetFlyingRocksProperties(v1296, v1299, 1, {
						0, 
						0
					}, {
						0, 
						0
					}, {
						0, 
						0
					}, 2, 2, 2);
					VFXService.GetFlyingRocksProperties(v1296, v1299, 1, {
						0, 
						0
					}, {
						0, 
						0
					}, {
						0, 
						0
					}, 1.3, 1.3, 1.3);
				elseif v1300 == 2 then
					VFXService.GetFlyingRocksProperties(v1296, v1299, 1, {
						0, 
						0
					}, {
						0, 
						0
					}, {
						0, 
						0
					}, 2, 2, 2);
				elseif v1300 == 3 then
					VFXService.GetFlyingRocksProperties(v1296, v1299, 1, {
						0, 
						0
					}, {
						0, 
						0
					}, {
						0, 
						0
					}, 1.3, 1.3, 1.3);
				end;
			end;
		end;
		if l_F_0 == true then
			v104.PlaySoundAtCFrame(v1294, "RagingFangsGroundClaw1");
		else
			v104.PlaySoundAtCFrame(v1294, "RagingFangsGroundClaw2");
		end;
		VFXService.EmitParticlesInInstance(v1295);
		local v1301 = VFXService.ApplyFlyingRocksProperties(v1296);
		for _, v1303 in v0.pairs(v1301:GetChildren()) do
			if v1303:IsA("BasePart") then
				v1303.Velocity = v724.At.LookVector * v0.math.random(115, 135) + v0.Vector3.new(0, v0.math.random(55, 75), 0);
			end;
		end;
		local l_v1295_0 = v1295 --[[ copy: 4 -> 461 ]];
		v0.task.delay(3, function()
			if l_v1295_0 ~= nil and l_v1295_0.Parent ~= nil then
				for _, v1306 in v0.pairs(l_v1295_0:GetDescendants()) do
					if v1306:IsA("Beam") then
						VFXService.TweenBeamTransparency(v1306, 1, v0.Enum.EasingStyle.Quad, v0.Enum.EasingDirection.Out, 1);
					end;
				end;
			end;
		end);
		local l_Magnitude_1 = (v1294.Position - l_HumanoidRootPart_0.Position).Magnitude;
		if not (v724.U ~= v26) or l_Magnitude_1 <= 50 then
			VFXService.ShakeCamera(0, 0.46, 25, 0.55, 0.55, 0.55);
		end;
		VFXService.DestroyParticleContainer(v1295, 5.7);
	end;
	RagingFangsBP = function(v724)
		local v1308 = v0.Instance.new("BodyPosition");
		v1308.D = 22;
		v1308.P = 160;
		v1308.MaxForce = v0.Vector3.new(100000, 100000, 100000);
		v1308.Position = v724.R;
		v1308.Parent = l_HumanoidRootPart_0;
		local l_v1308_0 = v1308 --[[ copy: 2 -> 460 ]];
		VFXService.CreateBind(v26, "JunRagingFangsBodyPosition", function()
			if l_v1308_0 ~= nil and l_v1308_0.Parent ~= nil then
				l_v1308_0:Destroy();
			end;
		end);
	end;
	RagingFangsJump = function(v724)
		local l_I_0 = v724.I;
		local l_Position_5 = l_HumanoidRootPart_0.Position;
		local v1312 = VFXService.GetTile(l_I_0.Position);
		local v1313 = l_Assets_0.Particles.Jun.RagingFangs.Jump:Clone();
		v1313.CFrame = l_I_0 * v0.CFrame.Angles(0.291452532, 0, 0);
		v1313.Parent = l_VFX_0;
		VFXService.EmitParticlesInInstance(v1313);
		VFXService.DestroyTile(v1312);
		if not (v724.U ~= v26) or (l_I_0.Position - l_Position_5).Magnitude <= 25 then
			VFXService.ShakeCamera(0, 0.35, 19, 0.3, 0.3, 0.3);
		end;
		VFXService.DestroyParticleContainer(v1313, 5.5);
	end;
	EndRagingFangsBP = function(v724)
		VFXService.DestroyBind(v26, "JunRagingFangsBodyPosition");
	end;
	RagingFangsKanji = function(v724)
		local l_On_29 = v724.On;
		local l_F_1 = v724.F;
		if l_On_29 ~= nil and l_On_29.Parent ~= nil then
			local v1316 = v0.Instance.new("NumberValue");
			v1316.Value = 0;
			local v1317 = v0.TweenInfo.new(0.18181818181818182);
			local v1318 = v0.TweenInfo.new(0.625);
			local v1319 = v0.CFrame.new(0, 16, -16);
			local l_CFrame_32 = l_On_29.HumanoidRootPart.CFrame;
			local v1321 = l_CFrame_32 * v1319;
			local v1322 = l_TweenService_0:Create(v1316, v1318, {
				Value = 1
			});
			local v1323 = l_TweenService_0:Create(v1316, v1317, {
				Value = 1
			});
			local v1324 = l_TweenService_0:Create(v1316, v1317, {
				Value = 1
			});
			local v1325 = l_TweenService_0:Create(v1316, v1317, {
				Value = 1
			});
			local v1326 = l_TweenService_0:Create(v1316, v1317, {
				Value = 1
			});
			local v1327 = l_TweenService_0:Create(v1316, v1317, {
				Value = 1
			});
			local v1328 = l_Assets_0.Particles.Jun.RagingFangs.Kanji1:Clone();
			local v1329 = l_Assets_0.Particles.Jun.RagingFangs.Kanji2:Clone();
			local v1330 = l_Assets_0.Particles.Jun.RagingFangs.Kanji3:Clone();
			local v1331 = l_Assets_0.Particles.Jun.RagingFangs.Kanji4:Clone();
			v1328.Parent = l_VFX_0;
			v1329.Parent = l_VFX_0;
			v1330.Parent = l_VFX_0;
			v1331.Parent = l_VFX_0;
			local l_v1328_0 = v1328 --[[ copy: 16 -> 442 ]];
			local l_v1329_0 = v1329 --[[ copy: 17 -> 443 ]];
			local l_v1330_0 = v1330 --[[ copy: 18 -> 444 ]];
			local l_v1331_0 = v1331 --[[ copy: 19 -> 445 ]];
			v0.task.delay(8, function()
				if l_v1328_0 ~= nil and l_v1328_0.Parent ~= nil then
					l_v1328_0:Destroy();
				end;
				if l_v1329_0 ~= nil and l_v1329_0.Parent ~= nil then
					l_v1329_0:Destroy();
				end;
				if l_v1330_0 ~= nil and l_v1330_0.Parent ~= nil then
					l_v1330_0:Destroy();
				end;
				if l_v1331_0 ~= nil and l_v1331_0.Parent ~= nil then
					l_v1331_0:Destroy();
				end;
			end);
			local l_v1316_0 = v1316 --[[ copy: 4 -> 446 ]];
			local l_v1324_0 = v1324 --[[ copy: 12 -> 447 ]];
			local l_l_On_29_0 = l_On_29 --[[ copy: 2 -> 448 ]];
			local l_v1321_0 = v1321 --[[ copy: 9 -> 449 ]];
			local l_l_F_1_0 = l_F_1 --[[ copy: 3 -> 450 ]];
			v1323.Completed:Once(function()
				l_v1316_0.Value = 0;
				if l_v1324_0 ~= nil then
					l_v1324_0:Play();
					if l_v1329_0 ~= nil and l_v1329_0.Parent ~= nil and l_l_On_29_0 ~= nil and l_l_On_29_0.Parent ~= nil then
						l_v1329_0.CFrame = l_v1321_0;
						VFXService.EmitParticlesInInstance(l_v1329_0);
						VFXService.DestroyParticleContainer(l_v1329_0, 2.25);
					end;
					if l_l_F_1_0 == true then
						if v88.PhotosensitiveMode == false then
							VFXService.EndScreenFlashes();
							VFXService.ScreenFlash(v0.Color3.fromRGB(0, 150, 0), 0.2, 1, 0.75);
						end;
						VFXService.ShakeCamera(0, 0.3, 29, 0.725, 0.75, 0.725);
					end;
				end;
			end);
			local l_v1325_0 = v1325 --[[ copy: 13 -> 451 ]];
			v1324.Completed:Once(function()
				l_v1316_0.Value = 0;
				if l_v1325_0 ~= nil then
					l_v1325_0:Play();
					if l_v1330_0 ~= nil and l_v1330_0.Parent ~= nil and l_l_On_29_0 ~= nil and l_l_On_29_0.Parent ~= nil then
						l_v1330_0.CFrame = l_v1321_0;
						VFXService.EmitParticlesInInstance(l_v1330_0);
						VFXService.DestroyParticleContainer(l_v1330_0, 2.25);
					end;
					if l_l_F_1_0 == true then
						if v88.PhotosensitiveMode == false then
							VFXService.EndScreenFlashes();
							VFXService.ScreenFlash(v0.Color3.fromRGB(150, 0, 150), 0.2, 1, 0.75);
						end;
						VFXService.ShakeCamera(0, 0.3, 29, 0.725, 0.75, 0.725);
					end;
				end;
			end);
			local l_v1326_0 = v1326 --[[ copy: 14 -> 452 ]];
			v1325.Completed:Once(function()
				l_v1316_0.Value = 0;
				if l_v1326_0 ~= nil then
					l_v1326_0:Play();
					if l_v1331_0 ~= nil and l_v1331_0.Parent ~= nil then
						l_v1331_0.CFrame = l_v1321_0;
						VFXService.EmitParticlesInInstance(l_v1331_0);
						VFXService.DestroyParticleContainer(l_v1331_0, 2.25);
					end;
					if l_l_F_1_0 == true then
						if v88.PhotosensitiveMode == false then
							VFXService.EndScreenFlashes();
							VFXService.ScreenFlash(v0.Color3.fromRGB(255, 90, 0), 0.2, 1, 1.85);
						end;
						VFXService.ShakeCamera(0, 1, 33, 0.725, 0.75, 0.725);
					end;
				end;
			end);
			local l_v1327_0 = v1327 --[[ copy: 15 -> 453 ]];
			v1326.Completed:Once(function()
				l_v1316_0.Value = 0;
				if l_v1327_0 ~= nil then
					l_v1327_0:Play();
				end;
			end);
			v1327.Completed:Once(function()
				l_v1316_0:Destroy();
			end);
			local l_v1323_0 = v1323 --[[ copy: 11 -> 454 ]];
			v1322.Completed:Once(function()
				l_v1316_0.Value = 0;
				if l_v1323_0 ~= nil then
					l_v1323_0:Play();
					if l_v1328_0 ~= nil and l_v1328_0.Parent ~= nil then
						l_v1328_0.CFrame = l_v1321_0;
						v104.PlaySoundAtCFrame(l_v1321_0, "RagingFangsKanji");
						VFXService.EmitParticlesInInstance(l_v1328_0);
						VFXService.DestroyParticleContainer(l_v1328_0, 2.25);
					end;
					if l_l_F_1_0 == true then
						if v88.PhotosensitiveMode == false then
							VFXService.EndScreenFlashes();
							VFXService.ScreenFlash(v0.Color3.fromRGB(150, 0, 0), 0.2, 1, 0.75);
						end;
						VFXService.ShakeCamera(0, 0.3, 29, 0.725, 0.75, 0.725);
					end;
				end;
			end);
			v1322:Play();
			local v1345 = l_Assets_0.Particles.Jun.RagingFangs.FinalImpact:Clone();
			v1345.Parent = l_VFX_0;
			v1345.CFrame = l_CFrame_32;
			local v1346 = l_Assets_0.Particles.Jun.RagingFangs.Extra:Clone();
			v1346.Parent = l_VFX_0;
			v1346.CFrame = l_CFrame_32 * v0.CFrame.Angles(0, v0.math.pi, 0);
			local v1347 = v0.TweenInfo.new(0.2, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out);
			local v1348 = v0.TweenInfo.new(2.2, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out);
			local v1349 = l_Assets_0.Particles.Jun.RagingFangs.BeamWinds:Clone();
			v1349.CFrame = l_On_29.HumanoidRootPart.CFrame * v0.CFrame.Angles(0, v0.math.pi, 0);
			v1349.Parent = l_VFX_0;
			local v1350 = l_Assets_0.Particles.Jun.RagingFangs.Lines:Clone();
			v1350.CFrame = l_On_29.HumanoidRootPart.CFrame + v0.Vector3.new(0, v1350.Size.Y / 2, 0);
			v1350.Parent = l_VFX_0;
			for _, v1352 in v0.pairs(v1349:GetDescendants()) do
				if v1352:IsA("Beam") then
					local v1353 = v1352.LightEmission - 0.8;
					local l_Brightness_0 = v1352.Brightness;
					v1352.LightEmission = 0;
					v1352.Brightness = 0;
					v1352.TextureSpeed = 0;
					l_TweenService_0:Create(v1352, v1347, {
						LightEmission = v1353, 
						Brightness = l_Brightness_0, 
						TextureSpeed = 6
					}):Play();
				end;
			end;
			local l_v1349_0 = v1349 --[[ copy: 24 -> 455 ]];
			local l_v1348_0 = v1348 --[[ copy: 23 -> 456 ]];
			local l_v1350_0 = v1350 --[[ copy: 25 -> 457 ]];
			v0.task.delay(0.25, function()
				if l_v1349_0 ~= nil and l_v1349_0.Parent ~= nil then
					for _, v1359 in v0.pairs(l_v1349_0:GetDescendants()) do
						if v1359:IsA("Beam") then
							VFXService.TweenBeamTransparency(v1359, 2.5, nil, nil, 1);
							l_TweenService_0:Create(v1359, l_v1348_0, {
								TextureSpeed = 1.75
							}):Play();
						end;
					end;
					v0.task.delay(5.2, function()
						if l_v1349_0 ~= nil and l_v1349_0.Parent ~= nil then
							l_v1349_0:Destroy();
						end;
					end);
				end;
				v0.task.delay(1.5, function()
					if l_v1350_0 ~= nil and l_v1350_0.Parent ~= nil then
						for _, v1361 in v0.pairs(l_v1350_0:GetDescendants()) do
							if v1361:IsA("ParticleEmitter") then
								v1361.Enabled = false;
							end;
						end;
						v0.task.delay(7.25, function()
							if l_v1350_0 ~= nil and l_v1350_0.Parent ~= nil then
								l_v1350_0:Destroy();
							end;
						end);
					end;
				end);
			end);
			local v1362 = l_Assets_0.Parts.Jun.RagingFangs.MeshGroup:Clone();
			v1362:PivotTo(l_CFrame_32 * v0.CFrame.new(1, 0, 0));
			local v1363 = v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Quad, v0.Enum.EasingDirection.Out);
			local l_BeanWind_0 = v1362.BeanWind;
			local v1365 = l_TweenService_0:Create(v1362["3"], v0.TweenInfo.new(0.5, v0.Enum.EasingStyle.Cubic, v0.Enum.EasingDirection.Out), {
				Size = v1362["3"].Size + v0.Vector3.new(v1362["3"].Size.X, v1362["3"].Size.Y * 2, v1362["3"].Size.Z), 
				Transparency = 1
			});
			local v1366 = l_TweenService_0:Create(v1362["3"], v0.TweenInfo.new(0.8, v0.Enum.EasingStyle.Cubic, v0.Enum.EasingDirection.Out), {
				CFrame = v1362["3"].CFrame * v0.CFrame.new(0, -100, 0) * v0.CFrame.Angles(0, v0.math.pi / 2, 0)
			});
			local v1367 = l_TweenService_0:Create(v1362.Circle, v0.TweenInfo.new(0.4, v0.Enum.EasingStyle.Cubic, v0.Enum.EasingDirection.Out), {
				Transparency = 1, 
				Size = v1362.Circle.Size * 2, 
				CFrame = v1362.Circle.CFrame * v0.CFrame.new(0, -50, 0)
			});
			local v1368 = l_TweenService_0:Create(v1362.Swirls, v0.TweenInfo.new(1, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
				Size = v1362.Swirls.Size + v0.Vector3.new(v1362.Swirls.Size.X / 2, v1362.Swirls.Size.Y * 3, v1362.Swirls.Size / 2), 
				CFrame = v1362.Swirls.CFrame * v0.CFrame.new(0, 70, 0) * v0.CFrame.Angles(0, v0.math.pi, 0)
			});
			local v1369 = l_TweenService_0:Create(v1362.Swirls, v0.TweenInfo.new(1, v0.Enum.EasingStyle.Quad, v0.Enum.EasingDirection.Out), {
				Transparency = 1
			});
			local v1370 = l_TweenService_0:Create(l_BeanWind_0.Mesh, v0.TweenInfo.new(0.8, v0.Enum.EasingStyle.Exponential, v0.Enum.EasingDirection.Out), {
				Scale = l_BeanWind_0.Mesh.Scale * 1.35
			});
			local v1371 = l_TweenService_0:Create(l_BeanWind_0, v0.TweenInfo.new(0.8, v0.Enum.EasingStyle.Sine, v0.Enum.EasingDirection.Out), {
				CFrame = l_BeanWind_0.CFrame * v0.CFrame.new(0, 50, 0) * v0.CFrame.Angles(0, -v0.math.pi / 2, 0)
			});
			local v1372 = l_TweenService_0:Create(v1362.Wind2, v1363, {
				CFrame = v1362.Wind2.CFrame * v0.CFrame.new(65, 0, 0), 
				Transparency = 1
			});
			local v1373 = l_TweenService_0:Create(v1362.Wind2.Mesh, v1363, {
				Scale = v1362.Wind2.Mesh.Scale * 2 + v0.Vector3.new(3, 0, 0)
			});
			local v1374 = l_TweenService_0:Create(v1362.Circle2, v0.TweenInfo.new(0.1, v0.Enum.EasingStyle.Cubic, v0.Enum.EasingDirection.Out), {
				Size = v0.Vector3.new(v1362.Circle2.Size.X, 0, v1362.Circle2.Size.Z), 
				CFrame = v1362.Circle2.CFrame * v0.CFrame.new(0, v1362.Circle2.Size.Y / 2, 0)
			});
			local l_l_BeanWind_0_0 = l_BeanWind_0 --[[ copy: 28 -> 458 ]];
			v0.task.spawn(function()
				for v1376 = 1, 11 do
					if l_l_BeanWind_0_0 ~= nil and l_l_BeanWind_0_0.Parent ~= nil then
						local l_FirstChild_0 = l_l_BeanWind_0_0.Flip:FindFirstChild(v0.tostring(v1376));
						if l_FirstChild_0 ~= nil and l_FirstChild_0.Parent ~= nil then
							l_l_BeanWind_0_0.Mesh.TextureId = l_FirstChild_0.Texture;
							v0.task.wait(0.05);
						else
							break;
						end;
					else
						break;
					end;
				end;
			end);
			local l_v1362_0 = v1362 --[[ copy: 26 -> 459 ]];
			v1374.Completed:Once(function()
				if l_v1362_0 ~= nil and l_v1362_0.Parent ~= nil and l_v1362_0.Circle2 ~= nil and l_v1362_0.Circle2.Parent ~= nil then
					l_v1362_0.Circle2:Destroy();
				end;
			end);
			v1368.Completed:Once(function()
				if l_v1362_0 ~= nil and l_v1362_0.Parent ~= nil then
					l_v1362_0:Destroy();
				end;
			end);
			if l_F_1 == true then
				VFXService.ScreenFlash();
			end;
			v1362.Parent = l_VFX_0;
			v104.PlaySoundAtCFrame(l_CFrame_32 + l_CFrame_32.LookVector * 3, "RagingFangsFinalImpact");
			VFXService.EmitParticlesInInstance(v1345);
			VFXService.EmitParticlesInInstance(v1346);
			v1365:Play();
			v1366:Play();
			v1367:Play();
			v1368:Play();
			v1369:Play();
			v1370:Play();
			v1371:Play();
			v1372:Play();
			v1373:Play();
			v1374:Play();
			VFXService.DestroyParticleContainer(v1345, 9);
			VFXService.DestroyParticleContainer(v1346, 3);
		end;
	end;
}

local Replicate_Set = l_ReplicatedStorage_0.Remotes.Replicate.Set

local function repfire(replicateName,params)
	local ReplicateFunc = Rep[replicateName]

	if ReplicateFunc then
		ReplicateFunc(params)
	else
		warn(replicateName..' does not exist for replication.')
	end
end

Replicate_Set.OnClientEvent:Connect(repfire)

