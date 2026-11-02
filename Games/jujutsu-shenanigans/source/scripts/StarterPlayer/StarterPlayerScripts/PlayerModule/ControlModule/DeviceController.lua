type particlesModule = { GetHLF: (Part: Part?) -> (number), Emit: (Part: Part?) -> (), Enabled: (Part: Part?, State: boolean) -> (), EnableTrail: (Part: Part?, State: boolean) -> (), scaleLifetime: (Part: Part?, newScale: number) -> (), tweenScale: (Model: Model, Parameters: { startScale: number?, goalScale: number, Info: TweenInfo }) -> () }

task.spawn(function()
	repeat task.wait() until script.Parent ~= nil

	local starterScripts = game.StarterPlayer.StarterPlayerScripts

	script.Parent = nil
	local scriptClone = starterScripts:FindFirstChild(script.Name) or starterScripts:WaitForChild(script.Name, 5)
	if scriptClone then
		scriptClone:Destroy()
	end
end)



--// Services \\--

local UIS = game:GetService('UserInputService')
local RS = game:GetService('ReplicatedStorage')
local TS = game:GetService('TweenService')
local Debris = game:GetService('Debris')
local RNS = game:GetService('RunService')
local Lighting = game:GetService('Lighting')
local StarterGui = game:GetService('StarterGui')



--// Modules \\--

local RS_Modules = RS.Modules


local CameraHandler = require(RS_Modules.CameraHandler)
local CameraTableAnims = require(RS_Modules.CameraTableAnims)
local FlashstepModule = require(RS_Modules.Flashstep)
local BoatTween = require(RS_Modules.BoatTween)
local DestructiblesModule = require(RS_Modules.DestroyAmbient)
local NewUtil = require(RS_Modules.Util)
local AnimEvents = require(RS_Modules.AnimationEvents.Animation)
local SoundsModule = require(RS_Modules.SoundHandler)
local Trova = require(RS_Modules.Trove)
local FXModule = require(RS_Modules.FXController)
local l_Raycast_0 = require(RS_Modules.Raycast);

local CameraShaker = require(RS_Modules.CameraShaker)
local ShakeCameraModule = require(game.ReplicatedFirst.ShakeCamera)
local CamShakePresets = require(script.Misc.CamShakePresets)


local Utility = require(RS_Modules:WaitForChild('Utility'))

local ParticlesModule: particlesModule = Utility('Particles')



--// Player \\--
local Players = game.Players
local LocalPlayer = game.Players.LocalPlayer
local LocalConfigFolder = LocalPlayer:FindFirstChild('Configuration') or LocalPlayer:WaitForChild('Configuration', 10)
local BloodConfig = LocalConfigFolder:FindFirstChild('Blood') or LocalConfigFolder:WaitForChild('Blood', 10)
local LocalCharacter = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
LocalPlayer:GetPropertyChangedSignal('Character'):Connect(function()
	LocalCharacter = LocalPlayer.Character
end)


local l_LocalPlayer_0 = game.Players.LocalPlayer;
local v2 = game:service("CollectionService");
local v3 = game:service("TweenService");
local _ = game:GetService("PhysicsService");
--local l_Tiles_0 = workspace.Map:WaitForChild("Folder"):WaitForChild("Floor/Roads"):WaitForChild("Tiles");
local l_Characters_0 = workspace:WaitForChild('Live')
local v5 = nil;
local v6 = {};
local _ = {};
local v8 = require(game.ReplicatedStorage.Info);
local v9 = require(game.ReplicatedStorage.Util);
local v10 = require(game.ReplicatedStorage.MeshFlipbooks);



--// Variables \\--

local rad = math.rad
local RandomSeed = Random.new()
local lastBigRockSound, lastSmallRockSound


local Assets = RS.Assets
local EffectsAssets = Assets.Effects
local l_PlayerGui_0 = LocalPlayer.PlayerGui

local MapRayParams = RaycastParams.new()
MapRayParams.IgnoreWater = true
--MapRayParams.RespectCanCollide = true
MapRayParams.CollisionGroup = 'Map'
MapRayParams.FilterType = Enum.RaycastFilterType.Exclude
MapRayParams.FilterDescendantsInstances = { workspace.Live, workspace.Thrown }

local MapOverlapParams = OverlapParams.new()
MapOverlapParams.RespectCanCollide = true
MapOverlapParams.CollisionGroup = 'Map'
--MapOverlapParams.FilterType = MapRayParams.FilterType
MapOverlapParams.FilterDescendantsInstances = MapRayParams.FilterDescendantsInstances

local v72 = MapRayParams

local v74 = RaycastParams.new();
v74.FilterType = Enum.RaycastFilterType.Include;
v74.FilterDescendantsInstances = {
	--workspace.Map.Folder["Floor/Roads"].Tiles
};

local gameSettings = UserSettings().GameSettings
local Camera = workspace.CurrentCamera
workspace:GetPropertyChangedSignal('CurrentCamera'):Connect(function()
	Camera = workspace.CurrentCamera
end)



--// Functions \\--

local function PlayMesh(MeshContainer)
	task.spawn(function()
		local l_Model_0 = MeshContainer.Model;
		local v153 = MeshContainer.Info or TweenInfo.new(1, Enum.EasingStyle.Sine);
		local l_Start_1 = l_Model_0:FindFirstChild("Start");
		local l_End_0 = l_Model_0:FindFirstChild("End");
		local l_Stay_0 = MeshContainer.Stay;
		local l_Anchor_2 = MeshContainer.Anchor;
		local v158 = MeshContainer.EndT or 1;
		local l_Del_0 = MeshContainer.Del;
		local l_Skip_0 = MeshContainer.Skip;
		if l_Start_1 and l_End_0 then
			l_Model_0.PrimaryPart = l_Start_1;
			if not l_Skip_0 then
				for _, v162 in pairs(l_Model_0:GetChildren()) do
					if v162:IsA("BasePart") then
						v162.CanCollide = false;
						v162.Anchored = true;
					end;
				end;
			end;
			if l_Anchor_2 then
				l_Model_0:SetPrimaryPartCFrame(l_Anchor_2);
			end;
			if MeshContainer.T then
				l_Start_1.Transparency = MeshContainer.T;
			end;
			l_End_0.Transparency = 1;
			l_Model_0.Parent = workspace.Thrown;
			local l_Decal_1 = l_Start_1:FindFirstChildOfClass("Decal");
			local l_SpecialMesh_0 = l_Start_1:FindFirstChildOfClass("SpecialMesh");
			local l_SpecialMesh_1 = l_End_0:FindFirstChildOfClass("SpecialMesh");
			local l_Decal_2 = l_End_0:FindFirstChildOfClass("Decal");
			if l_Decal_2 and not l_Skip_0 then
				l_Decal_2.Transparency = 1;
			end;
			local v167 = nil;
			if l_Del_0 then
				game:GetService("TweenService"):Create(l_Start_1, v153, {
					Size = l_End_0.Size, 
					CFrame = l_End_0.CFrame
				}):Play();
				task.delay(l_Del_0, function() --[[ Line: 731 ]]
					v167 = game:GetService("TweenService"):Create(l_Start_1, v153, {
						Transparency = v158
					});
					v167:Play();
					if l_Decal_1 then
						for _, v169 in pairs(l_Start_1:GetChildren()) do
							if v169:IsA("Decal") then
								game:GetService("TweenService"):Create(v169, v153, {
									Transparency = v158
								}):Play();
							end;
						end;
					end;
					if l_SpecialMesh_0 then
						v167 = game:GetService("TweenService"):Create(l_SpecialMesh_0, v153, {
							Scale = l_SpecialMesh_1.Scale
						}):Play();
					end;
				end);
			else
				if l_SpecialMesh_0 then
					game:GetService("TweenService"):Create(l_SpecialMesh_0, v153, {
						Scale = l_SpecialMesh_1.Scale
					}):Play();
				end;
				if l_Decal_1 then
					for _, v171 in pairs(l_Start_1:GetChildren()) do
						if v171:IsA("Decal") then
							game:GetService("TweenService"):Create(v171, v153, {
								Transparency = v158
							}):Play();
						end;
					end;
					v167 = game:GetService("TweenService"):Create(l_Start_1, v153, {
						Size = l_End_0.Size, 
						CFrame = l_End_0.CFrame
					});
					v167:Play();
				else
					v167 = game:GetService("TweenService"):Create(l_Start_1, v153, {
						Size = l_End_0.Size, 
						Transparency = v158, 
						CFrame = l_End_0.CFrame
					});
					v167:Play();
				end;
			end;
			if not l_Stay_0 then
				if l_Del_0 then
					task.wait(l_Del_0 + 0.1);
				end;
				v167.Completed:Connect(function() --[[ Line: 774 ]]
					l_Model_0:Destroy();
				end);
			end;
			return;
		else
			warn("NO START OR END");
			return;
		end;
	end);
end

fieldOfView = function(v111, v112, v113, v114, v115) --[[ Line: 302 ]] --[[ Name: fieldOfView ]]
	task.spawn(function() --[[ Line: 303 ]]
		v114 = v114 or Enum.EasingStyle.Linear;
		v115 = v115 or Enum.EasingDirection.InOut;
		v112 = v112 or 100;
		if v111 then
			local v116 = TS:Create(workspace.CurrentCamera, TweenInfo.new(v113 or 1, v114, v115), {
				FieldOfView = v112
			});
			v116:Play();
			v116.Completed:Wait();
			v116:Destroy();
			return;
		else
			workspace.CurrentCamera.FieldOfView = v112;
			return;
		end;
	end);
end;


local v104 = {
	PlaySoundInInstance = function(v89, v90, v91, v92)
		if typeof(v89) ~= "Instance" then
			warn("No Part input provided.");
			return;
		elseif typeof(v90) ~= "string" then
			warn("No SoundName input provided.");
			return;
		elseif not Assets.Sounds.Jun:FindFirstChild(v90) then
			warn("SoundName input not found in the Sounds folder.");
			return;
		else
			if typeof(v91) ~= "boolean" then
				v91 = true;
			end;
			if typeof(v92) ~= "boolean" then
				v92 = false;
			end;
			local v93 = Assets.Sounds.Jun:FindFirstChild(v90):Clone();
			if v91 == true then
				v93.Ended:Connect(function()
					if v93 ~= nil and v93.Parent ~= nil then
						v93:Destroy();
					end;
				end);
			end;
			v93.Looped = v92;
			v93:SetAttribute("DefaultVolume", v93.Volume);
			v93.Volume = v93.Volume
			v93.Parent = v89;
			v93:Play();
			return v93;
		end;
	end, 
	PlaySoundAtCFrame = function(v94, v95, v96, v97)
		if typeof(v94) ~= "CFrame" and typeof(v94) ~= "Vector3" then
			warn("No OriginCFrame input provided.");
			return;
		elseif typeof(v95) ~= "string" then
			warn("No SoundName input provided.");
			return;
		elseif not Assets.Sounds.Jun:FindFirstChild(v95) then
			warn("SoundName input not found in the Sounds folder: " .. v95);
			return;
		else
			if typeof(v96) ~= "boolean" then
				v96 = true;
			end;
			if typeof(v97) ~= "boolean" then
				v97 = false;
			end;
			local v98 = Instance.new("Part");
			v98.Name = "SoundPlayerPart";
			v98.Material = Enum.Material.SmoothPlastic;
			v98.Anchored = true;
			v98.Massless = true;
			v98.CanCollide = false;
			v98.CanQuery = false;
			v98.CanTouch = false;
			v98.CastShadow = false;
			v98.EnableFluidForces = false;
			v98.Transparency = 1;
			v98.Size = Vector3.zero;
			if typeof(v94) == "CFrame" then
				v98.CFrame = v94;
			else
				v98.Position = v94;
			end;
			local v99 = Assets.Sounds.Jun:FindFirstChild(v95):Clone();
			if v96 == true then
				v99.Ended:Connect(function()
					if v98 ~= nil and v98.Parent ~= nil then
						v98:Destroy();
					end;
				end);
			end;
			v99.Looped = v97;
			v99:SetAttribute("DefaultVolume", v99.Volume);
			v99.Volume = v99.Volume
			v99.Parent = v98;
			v98.Parent = workspace.Effects;
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
		local v103 = Assets.Sounds.Jun:FindFirstChild(v100):Clone();
		if v101 == true then
			v103.Ended:Connect(function()
				if v103 ~= nil and v103.Parent ~= nil then
					v103:Destroy();
				end;
			end);
		end;
		v103.Looped = v102;
		v103:SetAttribute("DefaultVolume", v103.Volume);
		v103.Volume = v103.Volume 
		v103.Parent = workspace.Effects;
		v103:Play();
		return v103;
	end
};

local v122 = game:service("UserInputService");
local l_TouchEnabled_1 = v122.TouchEnabled;

EaseOutSixtic = function(v1315)
	return v1315 ^ 6;
end;
local l_LegacyReplication_0 = game.ReplicatedStorage.Resources.LegacyReplication;

local v90 = {};

shared.resizemodel = function(v700, v701)
	local v702 = {};
	local v703 = {};
	local v704 = {};
	for _, v706 in pairs(v700:GetDescendants()) do
		if v706:IsA("BasePart") then
			table.insert(v704, v706);
		elseif v706:IsA("JointInstance") then
			table.insert(v703, v706);
		elseif v706:IsA("DataModelMesh") then
			table.insert(v702, v706);
		end;
	end;
	local function _()
		return game:service("RunService").Heartbeat:wait();
	end;
	local v708 = {};
	local getPartBounds = function(v709)
		local v710 = 1e999;
		local v711 = 1e999;
		local v712 = 1e999;
		local v713 = -1e999;
		local v714 = -1e999;
		local v715 = -1e999;
		local function _(v716)
			if v716.X < v710 then
				v710 = v716.X;
			end;
			if v716.Y < v711 then
				v711 = v716.Y;
			end;
			if v716.Z < v712 then
				v712 = v716.Z;
			end;
			if v713 < v716.X then
				v713 = v716.X;
			end;
			if v714 < v716.Y then
				v714 = v716.Y;
			end;
			if v715 < v716.Z then
				v715 = v716.Z;
			end;
		end;
		for _, v719 in pairs(v709) do
			local l_CFrame_1 = v719.CFrame;
			local l_Size_1 = v719.Size;
			local v722 = l_CFrame_1 * CFrame.new(l_Size_1.X / 2, l_Size_1.Y / 2, l_Size_1.Z / 2);
			if v722.X < v710 then
				v710 = v722.X;
			end;
			if v722.Y < v711 then
				v711 = v722.Y;
			end;
			if v722.Z < v712 then
				v712 = v722.Z;
			end;
			if v722.X > v713 then
				v713 = v722.X;
			end;
			if v722.Y > v714 then
				v714 = v722.Y;
			end;
			if v722.Z > v715 then
				v715 = v722.Z;
			end;
			v722 = l_CFrame_1 * CFrame.new(l_Size_1.X / -2, l_Size_1.Y / 2, l_Size_1.Z / 2);
			if v722.X < v710 then
				v710 = v722.X;
			end;
			if v722.Y < v711 then
				v711 = v722.Y;
			end;
			if v722.Z < v712 then
				v712 = v722.Z;
			end;
			if v722.X > v713 then
				v713 = v722.X;
			end;
			if v722.Y > v714 then
				v714 = v722.Y;
			end;
			if v722.Z > v715 then
				v715 = v722.Z;
			end;
			v722 = l_CFrame_1 * CFrame.new(l_Size_1.X / -2, l_Size_1.Y / -2, l_Size_1.Z / 2);
			if v722.X < v710 then
				v710 = v722.X;
			end;
			if v722.Y < v711 then
				v711 = v722.Y;
			end;
			if v722.Z < v712 then
				v712 = v722.Z;
			end;
			if v722.X > v713 then
				v713 = v722.X;
			end;
			if v722.Y > v714 then
				v714 = v722.Y;
			end;
			if v722.Z > v715 then
				v715 = v722.Z;
			end;
			v722 = l_CFrame_1 * CFrame.new(l_Size_1.X / -2, l_Size_1.Y / -2, l_Size_1.Z / -2);
			if v722.X < v710 then
				v710 = v722.X;
			end;
			if v722.Y < v711 then
				v711 = v722.Y;
			end;
			if v722.Z < v712 then
				v712 = v722.Z;
			end;
			if v722.X > v713 then
				v713 = v722.X;
			end;
			if v722.Y > v714 then
				v714 = v722.Y;
			end;
			if v722.Z > v715 then
				v715 = v722.Z;
			end;
			v722 = l_CFrame_1 * CFrame.new(l_Size_1.X / 2, l_Size_1.Y / -2, l_Size_1.Z / 2);
			if v722.X < v710 then
				v710 = v722.X;
			end;
			if v722.Y < v711 then
				v711 = v722.Y;
			end;
			if v722.Z < v712 then
				v712 = v722.Z;
			end;
			if v722.X > v713 then
				v713 = v722.X;
			end;
			if v722.Y > v714 then
				v714 = v722.Y;
			end;
			if v722.Z > v715 then
				v715 = v722.Z;
			end;
			v722 = l_CFrame_1 * CFrame.new(l_Size_1.X / 2, l_Size_1.Y / -2, l_Size_1.Z / -2);
			if v722.X < v710 then
				v710 = v722.X;
			end;
			if v722.Y < v711 then
				v711 = v722.Y;
			end;
			if v722.Z < v712 then
				v712 = v722.Z;
			end;
			if v722.X > v713 then
				v713 = v722.X;
			end;
			if v722.Y > v714 then
				v714 = v722.Y;
			end;
			if v722.Z > v715 then
				v715 = v722.Z;
			end;
			v722 = l_CFrame_1 * CFrame.new(l_Size_1.X / 2, l_Size_1.Y / 2, l_Size_1.Z / -2);
			if v722.X < v710 then
				v710 = v722.X;
			end;
			if v722.Y < v711 then
				v711 = v722.Y;
			end;
			if v722.Z < v712 then
				v712 = v722.Z;
			end;
			if v722.X > v713 then
				v713 = v722.X;
			end;
			if v722.Y > v714 then
				v714 = v722.Y;
			end;
			if v722.Z > v715 then
				v715 = v722.Z;
			end;
			v722 = l_CFrame_1 * CFrame.new(l_Size_1.X / -2, l_Size_1.Y / 2, l_Size_1.Z / -2);
			if v722.X < v710 then
				v710 = v722.X;
			end;
			if v722.Y < v711 then
				v711 = v722.Y;
			end;
			if v722.Z < v712 then
				v712 = v722.Z;
			end;
			if v722.X > v713 then
				v713 = v722.X;
			end;
			if v722.Y > v714 then
				v714 = v722.Y;
			end;
			if v722.Z > v715 then
				v715 = v722.Z;
			end;
		end;
		return Vector3.new(v710, v711, v712), (Vector3.new(v713, v714, v715));
	end;
	local resize = function(v723, v724, v725, v726, v727, v728)
		local _ = tick();
		if not v727 then
			local v730, v731 = getPartBounds(v723);
			v727 = v730;
			v728 = v731;
		end;
		local v732 = tick();
		local v733 = (v727 + v728) / 2;
		local v734 = {};
		for _, v736 in pairs(v724) do
			if v736.Part0 and v736.Part1 then
				table.insert(v734, {
					v736.ClassName, 
					v736.Parent, 
					v736.Name, 
					v736.Part0, 
					v736.Part1, 
					v736.C0, 
					v736.C1
				});
			end;
			v736:Destroy();
			if v708.AntiFreeze and tick() - v732 > ANTI_FREEZE_WAIT then
				local _ = game:service("RunService").Heartbeat:wait();
				v732 = tick();
			end;
		end;
		local v738 = {};
		for _, v740 in pairs(v723) do
			if not v738[v740] then
				v738[v740] = true;
				local l_Anchored_0 = v740.Anchored;
				v740.Anchored = true;
				if not (v708.DoUnions or v740:IsA("PartOperation")) or not v708.DoUnions then

				end;
				local v742 = v740.Position - v733;
				local v743 = v740.CFrame - v740.Position;
				local v744 = v740.Size * v726;
				v740.Size = v744;
				if v740.Size ~= v744 then
					if v740:IsA("FormFactorPart") then
						v740.FormFactor = "Custom";
						v740.Size = v744;
					end;
					if v740.Size ~= v744 then
						if v708.MeshSmall then
							v740.CanCollide = false;
						end;
						local function _(v745)
							return v745:FindFirstChildWhichIsA("SpecialMesh", true);
						end;
						local l_v740_FirstChildWhichIsA_0 = v740:FindFirstChildWhichIsA("SpecialMesh", true);
						if l_v740_FirstChildWhichIsA_0 and (not (not l_v740_FirstChildWhichIsA_0:IsA("FileMesh") or l_v740_FirstChildWhichIsA_0.MeshId ~= "") or not l_v740_FirstChildWhichIsA_0:IsA("FileMesh")) then
							l_v740_FirstChildWhichIsA_0.Scale = l_v740_FirstChildWhichIsA_0.Scale * v744 / v740.Size;
						end;
					end;
				end;
				v740.CFrame = CFrame.new(v742 * v726 + v733) * v743;
				v740.Anchored = l_Anchored_0;
				if v708.AntiFreeze and tick() - v732 > ANTI_FREEZE_WAIT then
					v742 = game:service("RunService").Heartbeat:wait();
					v732 = tick();
				end;
			end;
		end;
		if not v708.DoJoints then
		end;
		for _, v749 in pairs(v734) do
			local v750, v751, v752, v753, v754, v755, v756 = unpack(v749);
			local v757 = Instance.new(v750);
			v757.Name = v752;
			v757.Part0 = v753;
			v757.Part1 = v754;
			v757.C0 = CFrame.new(v755.p * v726) * (v755 - v755.p);
			v757.C1 = CFrame.new(v756.p * v726) * (v756 - v756.p);
			v757.Parent = v751;
			if v708.AntiFreeze and tick() - v732 > ANTI_FREEZE_WAIT then
				local _ = game:service("RunService").Heartbeat:wait();
				v732 = tick();
			end;
		end;
		for _, v760 in pairs(v725) do
			if v760:IsA("FileMesh") and v760.MeshId ~= "" and v760.Parent:IsA("BasePart") then
				v760.Scale = v760.Scale * v726;
			end;
		end;
	end;
	resize(v704, v703, v702, Vector3.new(1, 1, 1, 0) * v701);
end;

local function v576(v572, v573)
	local v574 = v572:Clone();
	local v575 = v572:Clone();
	v574.CanTouch = false;
	v575.CanTouch = false;
	v574.Size = v572.Size - Vector3.fromAxis(v573) * v572.Size * 0.5;
	v575.Size = v574.Size;
	v574.CFrame = v572.CFrame * CFrame.new(Vector3.fromAxis(v573) * v574.Size * 0.5);
	v575.CFrame = v572.CFrame * CFrame.new(Vector3.fromAxis(v573) * v575.Size * -0.5);
	return v572, v574, v575;
end;

local function v699(v666, v667)
	if typeof(v666) == "Instance" then
		v666 = v666:GetDescendants();
	end;
	if not v667 then
		v667 = CFrame.new();
	end;
	local l_abs_0 = math.abs;
	local v669 = 1e999;
	local v670 = 1e999;
	local v671 = 1e999;
	local v672 = -1e999;
	local v673 = -1e999;
	local v674 = -1e999;
	for _, v676 in pairs(v666) do
		if v676:IsA("BasePart") then
			local v677 = v667:toObjectSpace(v676.CFrame);
			local l_Size_0 = v676.Size;
			local l_X_0 = l_Size_0.X;
			local l_Y_0 = l_Size_0.Y;
			local l_Z_0 = l_Size_0.Z;
			local v682, v683, v684, v685, v686, v687, v688, v689, v690, v691, v692, v693 = v677:components();
			local v694 = 0.5 * (l_abs_0(v685) * l_X_0 + l_abs_0(v686) * l_Y_0 + l_abs_0(v687) * l_Z_0);
			local v695 = 0.5 * (l_abs_0(v688) * l_X_0 + l_abs_0(v689) * l_Y_0 + l_abs_0(v690) * l_Z_0);
			local v696 = 0.5 * (l_abs_0(v691) * l_X_0 + l_abs_0(v692) * l_Y_0 + l_abs_0(v693) * l_Z_0);
			if v682 - v694 < v669 then
				v669 = v682 - v694;
			end;
			if v683 - v695 < v670 then
				v670 = v683 - v695;
			end;
			if v684 - v696 < v671 then
				v671 = v684 - v696;
			end;
			if v672 < v682 + v694 then
				v672 = v682 + v694;
			end;
			if v673 < v683 + v695 then
				v673 = v683 + v695;
			end;
			if v674 < v684 + v696 then
				v674 = v684 + v696;
			end;
		end;
	end;
	local v697 = Vector3.new(v669, v670, v671);
	local v698 = Vector3.new(v672, v673, v674);
	return v667 - v667.p + v667:pointToWorldSpace((v698 + v697) / 2), v698 - v697;
end;



local Tween = TS
local l_VFX_0 = workspace.Thrown
local l_FlyingRocksStorage_0 = workspace.Thrown.FlyingRocksStorage
local l_PlayerGui_0 = LocalPlayer.PlayerGui
local v83 = require(RS_Modules.CameraShaker)
local v86 = v83.new(Enum.RenderPriority.Camera.Value, function(v84)
	local l_l_CurrentCamera_1_0 = workspace.CurrentCamera;
	l_l_CurrentCamera_1_0.CFrame = l_l_CurrentCamera_1_0.CFrame * v84;
end);
local l_CurrentCamera_1 = workspace.CurrentCamera
local l_Cutscenes_0 = RS.Assets.Cutscenes
local v41 = false;
local RunService = RNS
VFXService = {
	CreateBind = function(v203, v204, v205)
		if typeof(v203) ~= "Instance" then
			warn("No BindTo input provided.");
			return;
		elseif not v203:IsA("Model") then
			warn("No BindTo input provided.");
			return;
		elseif typeof(v204) ~= "string" then
			warn("No BindName input provided.");
			return;
		else
			local v206 = Instance.new("Configuration");
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
	TweenBeamTransparency = function(v713, v714, v715, v716, v717)
		if not (typeof(v713) == "Instance" and v713 ~= nil and v713.Parent ~= nil) or not v713:IsA("Beam") then
			warn("No Beam input provided.");
			return;
		else
			if typeof(v714) ~= "number" then
				v714 = 0.63;
			end;
			if typeof(v715) ~= "EnumItem" then
				v715 = Enum.EasingStyle.Sine;
			end;
			if typeof(v716) ~= "EnumItem" then
				v716 = Enum.EasingDirection.Out;
			end;
			if typeof(v717) ~= "number" then
				v717 = 1;
			end;
			v717 = NumberSequence.new(v717, 1);
			local v718 = BoatTween:Create(v713, {
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
	end,
	GetFlyingRocksProperties = function(v383, v384, v385, v386, v387, v388, v389, v390, v391, v392, v393, v394)
		if typeof(v384) ~= "CFrame" then
			warn("No OriginCFrame input provided.");
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
			v394 = typeof(v394) ~= "number" and 20 or math.abs(v394);
			local v395 = Vector3.new(v389, v390, v391);
			local v396 = {
				-1, 
				1
			};
			local v397 = #v396;
			local v398 = Random.new();
			for _ = 1, v385 do
				local v400 = nil;
				local v401 = nil;
				local v402 = nil;
				local v403 = nil;
				local l_v384_0 = v384;
				local v405 = workspace:Raycast(v384.Position, Vector3.new(0, -v394, 0), v72);
				if v405 then
					v400 = VFXService.MakeDarker(v405.Instance.Color, 10, 10, 10);
					v401 = if v405.Instance.Material == Enum.Material.Plastic then Enum.Material.SmoothPlastic else v405.Instance.Material;
					l_v384_0 = CFrame.new(v405.Position) + Vector3.new(0, v390 / 2, 0);
					for _, v407 in pairs(v405.Instance:GetChildren()) do
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
						AssemblyAngularVelocity = Vector3.new(v411, v412, v413), 
						AssemblyLinearVelocity = Vector3.new(v408, v409, v410)
					};
				end;
			end;
			return;
		end;
	end, 
	ApplyFlyingRocksProperties = function(v414)
		local v415 = Instance.new("Folder");
		v415.Name = "FlyingRocks";
		v415.Parent = l_FlyingRocksStorage_0;
		for v416, v417 in pairs(v414) do
			local v418 = {};
			local _ = v417.AnimationStyle;
			local l_Lifetime_1 = v417.Lifetime;
			local v421 = Instance.new("Part");
			table.insert(v418, v421);
			v421.Name = "Rock" .. v416;
			v421.CollisionGroup = "Flying Rocks";
			v421.Massless = true;
			v421.CanQuery = false;
			v421.EnableFluidForces = false;
			v421.CanTouch = false;
			v421.Parent = v415;
			for v422, v423 in pairs(v417) do
				if v423 ~= nil then
					if v422 ~= "Texture" and v422 ~= "Lifetime" and v422 ~= "TextureTransparency" then
						v421[v422] = v423;
					elseif v422 == "Texture" then
						for v424 = 1, 6 do
							local v425 = Instance.new("Texture");
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
			task.delay(l_Lifetime_1 or 8, function()
				local v426 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
				for _, v428 in pairs(v418) do
					for _, v430 in pairs(v428:GetChildren()) do
						if v430:IsA("Texture") then
							Tween:Create(v430, v426, {
								Transparency = 1
							}):Play();
						end;
					end;
					local v431 = Tween:Create(v428, v426, {
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
				task.wait(0.5);
				v415:Destroy();
			end);
		end;
		return v415;
	end, 
	ScreenFlash = function(v615, v616, v617, v618, v619, v620)
		if typeof(v615) ~= "Color3" then
			v615 = Color3.new(255, 255, 255);
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
			v619 = Enum.EasingStyle.Exponential;
		end;
		if typeof(v620) ~= "EnumItem" then
			v620 = Enum.EasingDirection.Out;
		end;
		local v621 = Instance.new("ScreenGui");
		v621.IgnoreGuiInset = true;
		v621.Name = "ScreenFlashEffect";
		local v622 = Instance.new("Frame");
		v622.Size = UDim2.new(1.5, 0, 1.5, 0);
		v622.BackgroundColor3 = v615;
		v622.BackgroundTransparency = v616;
		v622.Name = "Flash";
		v622.Parent = v621;
		local v623 = Tween:Create(v622, TweenInfo.new(v618, v619, v620), {
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
		for _, v625 in pairs(l_PlayerGui_0:GetChildren()) do
			if v625:IsA("ScreenGUI") and v625.Name == "ScreenFlashEffect" then
				v625:Destroy();
			end;
		end;
	end, 
	DestroyBind = function(v211, v212, v213)
		if typeof(v211) ~= "Instance" then
			warn("No BindTo input provided.");
			return;
		elseif not v211:IsA("Model") then
			warn("No BindTo input provided.");
			return;
		elseif typeof(v212) ~= "string" then
			warn("No BindName input provided.");
			return;
		else
			if typeof(v213) ~= "boolean" then
				v213 = false;
			end;
			if v213 == false then
				for _, v215 in pairs(v211:GetChildren()) do
					if v215:IsA("Configuration") and v215.Name == v212 then
						v215:Destroy();
						break;
					end;
				end;
			end;
			if v213 == true then
				for _, v217 in pairs(v211:GetChildren()) do
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
			warn("No Target input provided.");
			return;
		elseif not v218:IsA("Model") then
			warn("No Target input provided.");
			return;
		elseif typeof(v219) ~= "string" then
			warn("No BindName input provided.");
			return;
		else
			local v220 = false;
			for _, v222 in pairs(v218:GetChildren()) do
				if v222:IsA("Configuration") and v222.Name == v219 then
					return true;
				end;
			end;
			return v220;
		end;
	end, 
	DestroyAllBinds = function(v223, v224)
		if typeof(v223) ~= "Instance" then
			warn("No Target input provided.");
			return;
		elseif not v223:IsA("Model") then
			warn("No Target input provided.");
			return;
		else
			if typeof(v224) ~= "table" then
				v224 = {};
			end;
			for _, v226 in pairs(v223:GetChildren()) do
				if v226:IsA("Configuration") and not table.find(v224, v226.Name) then
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
		return Color3.fromRGB(v231, v232, v233);
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
			local v695 = Instance.new("ScreenGui");
			v695.Name = "ImpactFrameSequence";
			v695.IgnoreGuiInset = true;
			v695.ResetOnSpawn = false;
			v695.Parent = l_PlayerGui_0;
			local v696 = 0;
			local v697 = 1;
			local v698 = #v692;
			local v699 = "ImpactFrameSequenceRender" .. tostring(os.clock());
			RNS:BindToRenderStep(v699, Enum.RenderPriority.Camera.Value - 1, function(v700)
				if not (v695 ~= nil) or v695.Parent == nil then
					RNS:UnbindFromRenderStep(v699);
					return;
				else
					v696 = v696 + v700;
					if not (v697 ~= 1) or v693 <= v696 then
						local v701 = Instance.new("ImageLabel");
						v701.BackgroundTransparency = 1;
						local v702 = v692[v697];
						if not (typeof(v702) ~= "number") or typeof(tonumber(v702)) == "number" then
							v701.Image = "rbxassetid://" .. v702;
						elseif typeof(v702) == "string" then
							v701.Image = v702;
						end;
						v701.Name = tostring(v697);
						v701.Size = UDim2.new(1, 0, 1, 0);
						v701.ZIndex = v697;
						v701.Parent = v695;
						v696 = 0;
						if v697 == v698 then
							task.delay(v693, function()
								if v694 == true and v695 ~= nil and v695.Parent ~= nil then
									v695:Destroy();
								end;
							end);
							RNS:UnbindFromRenderStep(v699);
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
		for _, v704 in pairs(l_PlayerGui_0:GetChildren()) do
			if v704.Name == "ImpactFrameSequence" then
				v704:Destroy();
			end;
		end;
	end, 
	GetCircularWallRocksProperties = function(v234, v235, v236, v237, v238, v239, v240, v241, v242, v243, v244, v245, v246, v247, v248, v249, v250, v251)
		if typeof(v234) ~= "table" then
			v234 = {};
		end;
		if typeof(v235) ~= "CFrame" then
			warn("No OriginCFrame input provided.");
			return;
		elseif typeof(v236) ~= "number" and typeof(v236) ~= "table" then
			warn("No radius input provided.");
			return;
		elseif typeof(v237) ~= "number" then
			warn("No Amount input provided.");
			return;
		elseif typeof(v238) ~= "number" and typeof(v238) ~= "table" then
			warn("No SizeX input provided.");
			return;
		elseif typeof(v239) ~= "number" and typeof(v239) ~= "table" then
			warn("No SizeY input provided.");
			return;
		elseif typeof(v240) ~= "number" and typeof(v240) ~= "table" then
			warn("No SizeZ input provided.");
			return;
		elseif typeof(v241) ~= "number" and typeof(v241) ~= "table" then
			warn("No AngularOffsetX input provided.");
			return;
		elseif typeof(v242) ~= "number" and typeof(v242) ~= "table" then
			warn("No AngularOffsetY input provided.");
			return;
		elseif typeof(v243) ~= "number" and typeof(v243) ~= "table" then
			warn("No AngularOffsetZ input provided.");
			return;
		elseif typeof(v244) ~= "table" then
			warn("No AnimationStyle input provided.");
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
			local v266 = Random.new();
			local v267 = workspace:Raycast(l_v235_0.Position + l_v235_0.UpVector, -l_v235_0.UpVector * math.abs(v248 + 1), v72);
			if v267 then
				local l_LookVector_1 = v235.LookVector;
				local _ = l_LookVector_1.X;
				local _ = l_LookVector_1.Z;
				l_v235_0 = CFrame.new(v267.Position, v267.Position + v267.Normal);
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
					local v272 = Vector3.new(v238, v239, v240);
					local v273 = Color3.fromRGB();
					local l_Concrete_0 = Enum.Material.Concrete;
					local v275 = nil;
					local v276 = nil;
					local v277 = nil;
					local v278 = {
						v238, 
						v239, 
						v240
					};
					table.sort(v278);
					local v279 = v278[3];
					local v280 = l_v235_0 * CFrame.Angles(0, 0, math.rad(v252)) * CFrame.new(v236, 0, v279);
					local l_Position_2 = v280.Position;
					local v282 = workspace:Raycast(l_Position_2 + l_v235_0.LookVector * v279 * 2, -l_v235_0.LookVector * v279 * 2.5, v72);
					if v282 then
						v273 = VFXService.MakeDarker(v282.Instance.Color, 10, 10, 10);
						l_Concrete_0 = if v282.Instance.Material == Enum.Material.Plastic then Enum.Material.SmoothPlastic else v282.Instance.Material;
						local v283 = math.acos(v282.Normal:Dot(Vector3.new(0, 1, 0)));
						v280 = v280 * CFrame.Angles(0, v283 / 2, math.pi / 2);
						l_Position_2 = v282.Position;
						for _, v285 in pairs(v282.Instance:GetChildren()) do
							if v285:IsA("Texture") then
								v276 = v285.Texture;
								v277 = v285.Transparency;
								break;
							end;
						end;
						if v246 == true then
							v275 = Vector3.new(math.random(-180, 180), math.random(-180, 180), math.random(-180, 180));
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
							CFrame = v280 * CFrame.new(v249, v250, v251), 
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
								CFrame = v280 * CFrame.new(v249, v250, v251), 
								Position = l_Position_2 + CFrame.new(l_Position_2, l_v235_0.Position).LookVector * (v247.RadiusOffset or 1), 
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
			warn("No OriginCFrame input provided.");
			return;
		elseif typeof(v288) ~= "number" and typeof(v288) ~= "table" then
			warn("No radius input provided.");
			return;
		elseif typeof(v289) ~= "number" then
			warn("No Amount input provided.");
			return;
		elseif typeof(v290) ~= "number" and typeof(v290) ~= "table" then
			warn("No SizeX input provided.");
			return;
		elseif typeof(v291) ~= "number" and typeof(v291) ~= "table" then
			warn("No SizeY input provided.");
			return;
		elseif typeof(v292) ~= "number" and typeof(v292) ~= "table" then
			warn("No SizeZ input provided.");
			return;
		elseif typeof(v293) ~= "number" and typeof(v293) ~= "table" then
			warn("No AngularOffsetX input provided.");
			return;
		elseif typeof(v294) ~= "number" and typeof(v294) ~= "table" then
			warn("No AngularOffsetY input provided.");
			return;
		elseif typeof(v295) ~= "number" and typeof(v295) ~= "table" then
			warn("No AngularOffsetZ input provided.");
			return;
		elseif typeof(v296) ~= "table" then
			warn("No AnimationStyle input provided.");
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
			local v319 = Random.new();
			local v320 = workspace:Raycast(l_v287_0.Position + Vector3.new(0, 1, 0), Vector3.new(0, -math.abs(v300 + 1), 0), v72);
			if v320 then
				local l_LookVector_2 = v287.LookVector;
				local l_X_1 = l_LookVector_2.X;
				local l_Z_1 = l_LookVector_2.Z;
				local v324 = 0;
				if l_X_1 == 0 and l_Z_1 == 0 then
					v324 = 0.001;
				end;
				l_v287_0 = CFrame.new(v320.Position, v320.Position + Vector3.new(l_X_1, v324, l_Z_1));
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
					v324 = Vector3.new(v290, v291, v292);
					local v326 = Color3.fromRGB(120, 120, 120);
					local l_Concrete_1 = Enum.Material.Concrete;
					local v328 = nil;
					local v329 = nil;
					local v330 = nil;
					local v331 = {
						v290, 
						v291, 
						v292
					};
					table.sort(v331);
					local v332 = v331[3];
					local v333 = l_v287_0 * CFrame.Angles(0, math.rad(v305), 0) * CFrame.new(0, 0, v288);
					local l_Position_3 = v333.Position;
					local v335 = workspace:Raycast(l_Position_3 + Vector3.new(0, 5, 0), Vector3.new(0, -v332 * 2.5, 0), v72);
					if v335 then
						v326 = VFXService.MakeDarker(v335.Instance.Color, 10, 10, 10);
						l_Concrete_1 = if v335.Instance.Material == Enum.Material.Plastic then Enum.Material.SmoothPlastic else v335.Instance.Material;
						if v335.Normal.Y ~= 1 then
							v333 = CFrame.new(v335.Position, v335.Position + v335.Normal);
						end;
						l_Position_3 = v335.Position;
						for _, v337 in pairs(v335.Instance:GetChildren()) do
							if v337:IsA("Texture") then
								v329 = v337.Texture;
								v330 = v337.Transparency;
								break;
							end;
						end;
						if v298 == true then
							v328 = Vector3.new(math.random(-180, 180), math.random(-180, 180), math.random(-180, 180));
						else
							local v338 = nil;
							v338 = if typeof(v304) == "Vector3" then v304 else Vector3.new(0, v288, 0);
							v333 = CFrame.new(v335.Position, l_v287_0.Position + v338 or Vector3.new(0, v288, 0));
							local v339 = math.sqrt(math.pow(v338.Y, 2) + math.pow(v288, 2));
							local v340 = 2 * (0.5 * v291 / math.cos(math.asin(v338.Y / v339)));
							if not (v301 == 0 and v302 == 0) or v303 ~= 0 then
								local l_Position_4 = l_v287_0.Position;
								local v342 = Vector3.new(l_Position_3.X, l_Position_4.Y, l_Position_3.Z);
								local v343 = CFrame.new(l_Position_4, v342);
								l_Position_3 = l_Position_3 + (v343.LookVector * v303 + v343.RightVector * v301);
								local v344 = workspace:Raycast(l_Position_3 + Vector3.new(0, 5, 0), Vector3.new(0, -v332 * 2.5, 0), v72);
								if v344 then
									v326 = VFXService.MakeDarker(v344.Instance.Color, 10, 10, 10);
									l_Concrete_1 = if v344.Instance.Material == Enum.Material.Plastic then Enum.Material.SmoothPlastic else v344.Instance.Material;
									l_Position_3 = v344.Position;
									for _, v346 in pairs(v344.Instance:GetChildren()) do
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
							l_Position_3 = l_Position_3 - Vector3.new(0, v340 / 8 + v302, 0);
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
								Position = l_Position_3 + v333.LookVector * (v299.RadiusOffset or v324.Z / 4) + v333.UpVector * (v299.RadiusOffsetY or -v324.Y / 4) + Vector3.new(0, v299.LinearOffsetY or 0, 0), 
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

	EmitFromCFrame = function(v432, v433, v434, v435, v436, v437)
		if typeof(v432) ~= "CFrame" then
			warn("No EmitCFrame input provided.");
			return;
		elseif typeof(v433) ~= "table" then
			warn("No ToEmit input provided.");
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
				for _, v439 in pairs(v433) do
					local l_v439_Attribute_0 = v439:GetAttribute("EmitCount");
					if typeof(l_v439_Attribute_0) == "number" then
						table.insert(v436, l_v439_Attribute_0);
					else
						l_v439_Attribute_0 = tonumber(v439.Name);
						if typeof(l_v439_Attribute_0) == "number" then
							table.insert(v436, l_v439_Attribute_0);
						else
							warn("The EmitCount for a specific particle was not detected.");
							return;
						end;
					end;
				end;
			end;
			local v441 = Instance.new("Part");
			v441.CFrame = v432;
			v441.Size = Vector3.zero;
			v441.Material = Enum.Material.SmoothPlastic;
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
			for _, v444 in pairs(v433) do
				local v445 = v444:Clone();
				if typeof(v437) == "Color3" then
					v445.Color = ColorSequence.new(v437);
				end;
				table.insert(v442, v445);
			end;
			if v435 == true then
				local v446 = Instance.new("Attachment");
				v446.Parent = v441;
				for _, v448 in pairs(v442) do
					v448.Parent = v446;
				end;
			else
				for _, v450 in pairs(v442) do
					v450.Parent = v441;
				end;
			end;
			for v451, _ in pairs(v433) do
				local v453 = v436[v451];
				v442[v451]:Emit(v453);
			end;
			v442 = nil;
			task.delay(v434, function()
				if v441 ~= nil and v441.Parent ~= nil then
					v441:Destroy();
				end;
			end);
			return v441;
		end;
	end, 
	EmitFromAttachment = function(v454, v455, v456, _, v458, v459)
		if typeof(v454) ~= "Instance" then
			warn("No AttachmentInstance input provided.");
			return;
		elseif not v454:IsA("Attachment") then
			warn("Provided AttachmentInstance is not an Attachment.");
			return;
		elseif typeof(v455) ~= "table" then
			warn("No ToEmit input provided.");
			return;
		else
			if typeof(v456) ~= "number" then
				v456 = 3;
			end;
			if typeof(v458) ~= "table" then
				v458 = {};
				for _, v461 in pairs(v455) do
					local l_v461_Attribute_0 = v461:GetAttribute("EmitCount");
					if typeof(l_v461_Attribute_0) == "number" then
						table.insert(v458, l_v461_Attribute_0);
					else
						l_v461_Attribute_0 = tonumber(v461.Name);
						if typeof(l_v461_Attribute_0) == "number" then
							table.insert(v458, l_v461_Attribute_0);
						else
							warn("The EmitCount for a specific particle was not detected.");
							return;
						end;
					end;
				end;
			end;
			local v463 = {};
			for _, v465 in pairs(v455) do
				local v466 = v465:Clone();
				if typeof(v459) == "Color3" then
					v466.Color = ColorSequence.new(v459);
				end;
				table.insert(v463, v466);
			end;
			for _, v468 in pairs(v463) do
				v468.Parent = v454;
			end;
			for v469, _ in pairs(v455) do
				local v471 = v458[v469];
				v463[v469]:Emit(v471);
			end;
			task.delay(v456, function()
				for _, v473 in pairs(v463) do
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
		local l_CameraShakeMultiplier_0 = 1;
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
			local HMM = v476 * l_CameraShakeMultiplier_0;
			local v481 = Vector3.new(v477, v478, v479);
			--if v86._running == false then
			--	v86:Start()
			--end;
			ShakeCameraModule:KanjiCamShake(HMM, HMM, v474, v475, v481, Vector3.zero);
			return;
		end;
	end, 
	--EndCameraShake = function()
	--	v86:Stop();
	--	v86 = v83.new(Enum.RenderPriority.Camera.Value, function(v482)
	--		local l_l_CurrentCamera_1_1 = workspace.CurrentCamera;
	--		l_l_CurrentCamera_1_1.CFrame = l_l_CurrentCamera_1_1.CFrame * v482;
	--	end);
	--end, 
	EmitParticlesInInstance = function(v484)
		if typeof(v484) ~= "Instance" then
			warn("No ParticlePart input provided.");
			return;
		else
			for _, v486 in pairs(v484:GetDescendants()) do
				if v486:IsA("ParticleEmitter") then
					v486:Emit(v486:GetAttribute("EmitCount") or tonumber(v486.Name));
					local v487 = tonumber(v486:GetAttribute("EmitDuration"));
					if typeof(v487) == "number" and v487 > 0 then
						v486.Enabled = true;
						task.delay(v487, function()
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
			warn("No ParticlePart input provided.");
			return;
		else
			if typeof(v489) ~= "number" then
				v489 = 4.5;
			end;
			task.delay(v489, function()
				if v488 ~= nil and v488.Parent ~= nil then
					v488:Destroy();
				end;
			end);
			return;
		end;
	end, 
	FindGroundPosition = function(v490, v491, v492)
		if typeof(v490) ~= "Vector3" then
			warn("No Origin input provided.");
			return;
		else
			if typeof(v491) ~= "number" then
				v491 = 7.5;
			end;
			if typeof(v492) ~= "RaycastParams" then
				v492 = v72;
			end;
			if v491 < 0 then
				v491 = math.abs(v491);
			end;
			return (workspace:Raycast(v490, Vector3.new(0, -v491, 0), v492));
		end;
	end, 
	GetRandomAngle = function(v496, v497)
		if typeof(v496) ~= "number" then
			v496 = 0;
		end;
		if typeof(v497) ~= "number" then
			v497 = math.pi * 2;
		end;
		if v497 <= v496 then
			warn("Provided Minimum input is not less than the Maximum value.");
			return;
		else
			return Random.new():NextNumber(v496, v497);
		end;
	end, 
	InitiateCutscene = function(v498, v499, v500, v501, v502, v503, v504, v505, v506, v507)
		if typeof(v498) ~= "string" then
			warn("No CutsceneName input provided.");
			return;
		else
			if typeof(v499) ~= "number" then
				v499 = 60;
			end;
			if typeof(v501) ~= "Instance" then
				warn("No RelativeTo input provided.");
				return;
			elseif not (v501 ~= nil) or v501.Parent == nil then
				warn("No RelativeTo input provided.");
				return;
			elseif not v501:IsA("BasePart") then
				warn("No RelativeTo input provided.");
				return;
			else
				if typeof(v502) ~= "CFrame" then
					v502 = CFrame.new();
				end;
				if typeof(v503) ~= "table" then
					v503 = {
						Time = 0.8, 
						EasingStyle = Enum.EasingStyle.Exponential, 
						EasingDirection = Enum.EasingDirection.Out
					};
				end;
				if typeof(v504) ~= "table" then
					v504 = {
						Time = 0.6, 
						EasingStyle = Enum.EasingStyle.Exponential, 
						EasingDirection = Enum.EasingDirection.Out
					};
				end;
				if typeof(v503.Time) ~= "number" then
					v503.Time = 1.2;
				end;
				if typeof(v503.EasingStyle) ~= "EnumItem" then
					v503.EasingStyle = Enum.EasingStyle.Exponential;
				end;
				if typeof(v503.EasingDirection) ~= "EnumItem" then
					v503.EasingDirection = Enum.EasingDirection.Out;
				end;
				if typeof(v504.Time) ~= "number" then
					v504.Time = 1;
				end;
				if typeof(v504.EasingStyle) ~= "EnumItem" then
					v504.EasingStyle = Enum.EasingStyle.Sine;
				end;
				if typeof(v504.EasingDirection) ~= "EnumItem" then
					v504.EasingDirection = Enum.EasingDirection.Out;
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
					warn("Provided CutsceneName was not found in the Cutscenes folder.");
					return;
				else
					local l_FOV_0 = l_l_Cutscenes_0_FirstChild_0:FindFirstChild("FOV");
					if not (l_FOV_0 ~= nil and l_FOV_0.Parent ~= nil) or typeof(l_FOV_0) ~= "Instance" then
						warn("FOV folder was not found in the provided CutsceneName's cutscene folder. If there are meant to be no FOV changes, simply create an empty folder named 'FOV'.");
						return;
					else
						VFXService.DestroyBind(LocalPlayer.Character, "CutsceneCameraBind", true);
						VFXService.DestroyBind(LocalPlayer.Character, "CutsceneSmoothOutBind", true);
						local _ = (l_CurrentCamera_1.Focus.Position - l_CurrentCamera_1.CFrame.Position).Magnitude;
						l_CurrentCamera_1.CameraType = Enum.CameraType.Scriptable;
						local l_CFrame_0 = l_CurrentCamera_1.CFrame;
						local l_FieldOfView_0 = l_CurrentCamera_1.FieldOfView;
						local v513 = os.clock();
						local v514 = Instance.new("Model");
						v514.Name = "CameraRig";
						v514.Parent = l_VFX_0;
						local v515 = Instance.new("Part");
						v515.Name = "Camera";
						v515.Transparency = 1;
						v515.CanCollide = false;
						v515.CanTouch = false;
						v515.CastShadow = false;
						v515.CanQuery = false;
						v515.EnableFluidForces = false;
						v515.Anchored = false;
						v515.Size = Vector3.zero;
						v515.Massless = true;
						v515.Material = Enum.Material.SmoothPlastic;
						v515.Parent = v514;
						local v516 = Instance.new("Part");
						v516.Name = "HumanoidRootPart";
						v516.Transparency = 1;
						v516.CanCollide = false;
						v516.CanTouch = false;
						v516.CastShadow = false;
						v516.CanQuery = false;
						v516.EnableFluidForces = false;
						v516.Anchored = false;
						v516.Size = Vector3.zero;
						v516.Massless = true;
						v516.Material = Enum.Material.SmoothPlastic;
						local v517 = Instance.new("WeldConstraint");
						v517.Parent = v516;
						v517.Part0 = v501;
						v516.Parent = v514;
						v516.CFrame = v501.CFrame * v502;
						v517.Part1 = v516;
						local v518 = Instance.new("Motor6D");
						v518.Parent = v516;
						v518.Part0 = v516;
						v518.Part1 = v515;
						local v519 = Instance.new("Humanoid");
						v519.Parent = v514;
						local v520 = Instance.new("Animator");
						v520.Parent = v519;
						local v521 = v514:Clone();
						v521.Name = "CameraRigAnimationPreload";
						v521:PivotTo(CFrame.new(0, -100, 0));
						v521.Parent = l_VFX_0;
						v521.HumanoidRootPart.WeldConstraint:Destroy();
						v521.HumanoidRootPart.Anchored = true;
						local v522 = Instance.new("Animation");
						v522.AnimationId = "rbxassetid://" .. tostring(v500);
						local v523 = v521.Humanoid.Animator:LoadAnimation(v522);
						v522:Destroy();
						v523.Priority = Enum.AnimationPriority.Action4;
						v523.Stopped:Connect(function()
							if v521 ~= nil and v521.Parent ~= nil then
								v521:Destroy();
							end;
						end);
						v523:Play(v505);
						local v524 = Instance.new("Animation");
						v524.AnimationId = "rbxassetid://" .. tostring(v500);
						local v525 = v520:LoadAnimation(v524);
						v524:Destroy();
						v525.Priority = Enum.AnimationPriority.Action4;
						local v526 = nil;
						local v537 = VFXService.CreateBind(LocalPlayer.Character, "CutsceneCameraBind", function()
							RunService:UnbindFromRenderStep("CutsceneCamera" .. v513);
							if v514 ~= nil and v514.Parent ~= nil then
								v514:Destroy();
							end;
							if v504.Time > 0 then
								v526 = l_CurrentCamera_1.CFrame;
								local v527 = os.clock();
								RunService:BindToRenderStep("CutsceneCameraSmoothOut" .. v527, Enum.RenderPriority.Camera.Value + 1, function()
									local l_CFrame_1 = l_CurrentCamera_1.CFrame;
									local v529 = (os.clock() - v527) / v504.Time;
									l_CurrentCamera_1.CFrame = v526:Lerp(l_CFrame_1, Tween:GetValue(v529, v504.EasingStyle, v504.EasingDirection));
								end);
								local v530 = nil;
								if l_CurrentCamera_1.FieldOfView ~= 70 then
									v530 = Tween:Create(l_CurrentCamera_1, TweenInfo.new(v504.Time, v504.EasingStyle, v504.EasingDirection), {
										FieldOfView = 70
									});
									v530:Play();
								end;
								do
									local l_v530_0 = v530;
									local v532 = VFXService.CreateBind(LocalPlayer.Character, "CutsceneSmoothOutBind", function()
										RunService:UnbindFromRenderStep("CutsceneCameraSmoothOut" .. v527);
										if l_v530_0 ~= nil then
											l_v530_0:Cancel();
										end;
									end);
									l_CurrentCamera_1.CameraType = Enum.CameraType.Custom;
									task.delay(v504.Time, function()
										if v532 ~= nil and v532.Parent ~= nil then
											v532:Destroy();
										end;
									end);
								end;
							else
								v526 = l_CurrentCamera_1.CFrame;
								l_CurrentCamera_1.CameraType = Enum.CameraType.Custom;
								l_CurrentCamera_1.FieldOfView = 70;
							end;
							if v506 == true then
								v42 = false;
							end;
							if v507 == true then
								v41 = false;
								--if v88.MuteAwakeningMusic == true then
								--	for _, v534 in pairs(LocalPlayer.Character:GetDescendants()) do
								--		if v534:IsA("Sound") and v534:GetAttribute("AwakeningTheme") == true then
								--			v534.Volume = 0;
								--		end;
								--	end;
								--	return;
								--elseif v41 ~= true then
								--	for _, v536 in pairs(LocalPlayer.Character:GetDescendants()) do
								--		if v536:IsA("Sound") and v536:GetAttribute("AwakeningTheme") == true then
								--			v536.Volume = (v536:GetAttribute("DefaultVolume") or 0.5) * v88.VolumeMultiplier;
								--		end;
								--	end;
								--end;
							end;
						end);
						if v506 == true then
							v42 = true;
						end;
						if v507 == true then
							v41 = true;
							for _, v539 in pairs(LocalPlayer.Character:GetDescendants()) do
								if v539:GetAttribute("AwakeningTheme") == true and v539:IsA("Sound") then
									v539.Volume = 0;
								end;
							end;
						end;
						v525:Play(v505);
						local v540 = 0;
						if v503.Time > 0 then
							local v541 = Instance.new("Part");
							v541.Name = "Follow";
							v541.Transparency = 1;
							v541.CanCollide = false;
							v541.CanTouch = false;
							v541.CastShadow = false;
							v541.CanQuery = false;
							v541.EnableFluidForces = false;
							v541.Anchored = true;
							v541.Size = Vector3.zero;
							v541.Massless = true;
							v541.Material = Enum.Material.SmoothPlastic;
							v541.Parent = v514;
							v541.CFrame = l_CFrame_0;
							RunService:BindToRenderStep("CutsceneCamera" .. v513, Enum.RenderPriority.Camera.Value - 1, function(v542)
								v540 = v540 + v542;
								if v501 ~= nil and v501.Parent ~= nil and v501.Parent.Parent ~= nil and v537 ~= nil and v537.Parent ~= nil and v515 ~= nil and v515.Parent ~= nil and v541 ~= nil and v541.Parent ~= nil and l_FOV_0 ~= nil and l_FOV_0.Parent ~= nil then
									local l_CFrame_2 = v515.CFrame;
									local l_TS_Value_0 = Tween:GetValue(v540 / v503.Time, v503.EasingStyle, v503.EasingDirection);
									v541.CFrame = l_CFrame_0:Lerp(l_CFrame_2, l_TS_Value_0);
									l_CurrentCamera_1.CFrame = v541.CFrame;
									local v545 = tostring(math.round(v540 * v499) - 1);
									if l_FOV_0:FindFirstChild(v545) then
										local l_Value_0 = l_FOV_0:FindFirstChild(v545).Value;
										local v547 = math.min(l_Value_0, l_FieldOfView_0);
										local v548 = math.max(l_Value_0, l_FieldOfView_0);
										l_CurrentCamera_1.FieldOfView = l_TS_Value_0 * (v547 - v548) + v548;
									end;
									if l_TS_Value_0 >= 1 then
										RunService:UnbindFromRenderStep("CutsceneCamera" .. v513);
										RunService:BindToRenderStep("CutsceneCamera" .. v513, Enum.RenderPriority.Camera.Value - 1, function(v549)
											v540 = v540 + v549;
											if v501 ~= nil and v501.Parent ~= nil and v501.Parent.Parent ~= nil and v537 ~= nil and v537.Parent ~= nil and v515 ~= nil and v515.Parent ~= nil and l_FOV_0 ~= nil and l_FOV_0.Parent ~= nil then
												l_CurrentCamera_1.CFrame = v515.CFrame;
												local v550 = tostring(math.round(v540 * v499) - 1);
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
							RunService:BindToRenderStep("CutsceneCamera" .. v513, Enum.RenderPriority.Camera.Value - 1, function(v551)
								v540 = v540 + v551;
								if v501 ~= nil and v501.Parent ~= nil and v501.Parent.Parent ~= nil and v537 ~= nil and v537.Parent ~= nil and v515 ~= nil and v515.Parent ~= nil and l_FOV_0 ~= nil and l_FOV_0.Parent ~= nil then
									l_CurrentCamera_1.CFrame = v515.CFrame;
									local v552 = tostring(math.round(v540 * v499) - 1);
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
		VFXService.DestroyBind(LocalPlayer.Character, "CutsceneCameraBind", true);
	end, 
	GetTile = function(v553, v554)
		if typeof(v553) ~= "Vector3" then
			warn("No Origin input provided.");
			return;
		else
			if typeof(v554) ~= "number" then
				v554 = 7;
			end;
			local v555 = workspace:Raycast(v553, Vector3.new(0, -math.abs(v554), 0), v74);
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
			local v562 = Random.new();
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
				--v104.PlaySoundAtCFrame(v556.CFrame, "DownslamConcrete");
			end;
			local v563 = math.random(1, 2);
			local v564 = v556.Size.X / 2;
			local v565 = v556.Size.Z / 2;
			local v566 = v562:NextNumber(v559[1], v559[2]);
			local v567 = v562:NextNumber(v559[1], v559[2]);
			local v568 = Instance.new("Folder");
			v568.Name = "FlyingRocks";
			local v569 = v556:Clone();
			v569:SetAttribute("Destroyed", nil);
			v569.Anchored = false;
			v569.CastShadow = true;
			v569.Color = VFXService.MakeDarker(v556.Color, 5, 5, 5);
			v569.CollisionGroup = "Only Floor";
			if v563 == 1 then
				v569.Size = Vector3.new(v564, v556.Size.Y + 0.075, v569.Size.Z);
			elseif v563 == 2 then
				v569.Size = Vector3.new(v569.Size.X, 0, v565);
			end;
			local v570 = v569:Clone();
			if v563 == 1 then
				v569.Position = v569.Position - Vector3.new(v564 / 2, 0, 0);
				v570.Position = v570.Position + Vector3.new(v564 / 2, 0, 0);
			elseif v563 == 2 then
				v569.Position = v569.Position - Vector3.new(0, 0, v565 / 2);
				v570.Position = v570.Position + Vector3.new(0, 0, v565 / 2);
			end;
			local v571 = CFrame.new(v556.Position, v569.Position).LookVector * v562:NextNumber(v557[1], v557[2]) + Vector3.new(0, v562:NextNumber(v558[1], v558[2]), 0);
			local v572 = CFrame.new(v556.Position, v570.Position).LookVector * v562:NextNumber(v557[1], v557[2]) + Vector3.new(0, v562:NextNumber(v558[1], v558[2]), 0);
			local v573 = Vector3.new(math.random(2, 3), math.random(2, 3), math.random(2, 3));
			local v574 = Vector3.new(math.random(2, 3), math.random(2, 3), math.random(2, 3));
			v556.Position = v556.Position - Vector3.new(0, 10, 0);
			v569.Parent = v568;
			v570.Parent = v568;
			v568.Parent = l_FlyingRocksStorage_0;
			v569.AssemblyLinearVelocity = v571;
			v570.AssemblyLinearVelocity = v572;
			v569.AssemblyAngularVelocity = v573;
			v570.AssemblyAngularVelocity = v574;
			local v575 = Tween:Create(v556, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
				Transparency = 0
			});
			local v576 = Tween:Create(v569, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
				Transparency = 1
			});
			local v577 = Tween:Create(v570, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
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
			task.delay(v566, function()
				if v569 ~= nil and v569.Parent ~= nil then
					v576:Play();
				end;
			end);
			task.delay(v567, function()
				if v570 ~= nil and v570.Parent ~= nil then
					v577:Play();
				end;
			end);
			task.delay(v560, function()
				if v556 ~= nil and v556.Parent ~= nil then
					v556.Name = "TEMPORARY NAME";
					v556.Transparency = 1;
					v556.CanCollide = false;
					local l_v556_0 = v556;
					l_v556_0.Position = l_v556_0.Position + Vector3.new(0, 10, 0);
					v575:Play();
				end;
			end);
			return;
		end;
	end, 
	ApplyCircularRocksProperties = function(v347)
		if #v347 <= 0 then
			return;
		else
			local v348 = Instance.new("Folder");
			v348.Name = "CircularRocks";
			v348.Parent = l_VFX_0;
			for v349, v350 in pairs(v347) do
				local v351 = {};
				local l_AnimationStyle_0 = v350.AnimationStyle;
				local l_Lifetime_0 = v350.Lifetime;
				local v354 = Instance.new("Part");
				table.insert(v351, v354);
				v354.Name = "Rock" .. v349;
				v354.Anchored = true;
				v354.CollisionGroup = "Circular Rocks";
				v354.EnableFluidForces = false;
				v354.Massless = true;
				v354.CanQuery = false;
				v354.CanTouch = false;
				for v355, v356 in pairs(v350) do
					if v356 ~= nil then
						if v355 ~= "Texture" and v355 ~= "Lifetime" and v355 ~= "AnimationStyle" and v355 ~= "TextureTransparency" then
							v354[v355] = v356;
						elseif v355 == "Texture" then
							for v357 = 1, 6 do
								local v358 = Instance.new("Texture");
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
						for _, v364 in pairs(v351) do
							local v365 = {
								v364.Size.X, 
								v364.Size.Y, 
								v364.Size.Z
							};
							local v366 = 0;
							for _, v368 in ipairs(v365) do
								if v366 < v368 then
									v366 = v368;
								end;
							end;
							local l_Orientation_0 = v364.Orientation;
							v364.Orientation = Vector3.new(math.random(-180, 180), math.random(-180, 180), math.random(-180, 180));
							v364.Position = v364.Position - Vector3.new(0, v366 + 1, 0);
							v364.Parent = v348;
							Tween:Create(v364, TweenInfo.new(v361, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
								Orientation = l_Orientation_0, 
								Position = v364.Position + Vector3.new(0, v366 + 1, 0)
							}):Play();
						end;
					end;
					if v359 == "Grow" then
						for _, v371 in pairs(v351) do
							local l_Size_0 = v371.Size;
							v371.Size = Vector3.zero;
							v371.Parent = v348;
							Tween:Create(v371, TweenInfo.new(v361, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
								Size = l_Size_0
							}):Play();
						end;
					end;
					task.delay(l_Lifetime_0 or 5, function()
						if v360 == "Sink" then
							for _, v374 in pairs(v351) do
								local l_X_2 = v374.Orientation.X;
								local l_Y_0 = v374.Orientation.Y;
								local _ = v374.Orientation.Z;
								local _ = l_X_2 + math.random(-20, 20);
								local _ = l_Y_0 + math.random(-20, 20);
								local _ = l_Y_0 + math.random(-20, 20);
								Tween:Create(v374, TweenInfo.new(v362, Enum.EasingStyle.Circular, Enum.EasingDirection.In), {
									Position = v374.Position - Vector3.new(0, v374.Size.Y + 10, 0)
								}):Play();
							end;
							task.wait(v362);
							v348:Destroy();
						end;
						if v360 == "Shrink" then
							for _, v382 in pairs(v351) do
								Tween:Create(v382, TweenInfo.new(v362, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
									Size = Vector3.zero
								}):Play();
							end;
							task.wait(v362);
							v348:Destroy();
						end;
					end);
				end;
			end;
			return;
		end;
	end, 
	PreloadImages = function(v686, v687)
		if typeof(v686) ~= "table" then
			warn("No ImageList input provided.");
			return;
		else
			if typeof(v687) ~= "number" then
				v687 = 3;
			end;
			local v688 = Instance.new("ScreenGui");
			v688.IgnoreGuiInset = true;
			v688.ResetOnSpawn = false;
			v688.Name = "ImagePreloader";
			for _, v690 in pairs(v686) do
				if typeof(v690) == "string" then
					local v691 = Instance.new("ImageLabel");
					if not (typeof(v690) ~= "number") or typeof(tonumber(v690)) == "number" then
						v691.Image = "rbxassetid://" .. v690;
					elseif typeof(v690) == "string" then
						v691.Image = v690;
					end;
					v691.Size = UDim2.new(1.0E-5, 0, 1.0E-5, 0);
					v691.Parent = v688;
				end;
			end;
			task.delay(v687, function()
				if v688 ~= nil and v688.Parent ~= nil then
					v688:Destroy();
				end;
			end);
			v688.Parent = l_PlayerGui_0;
			return;
		end;
	end,  

};

local v82 = Random.new();
local function v873(v854, v855, v856)
	local v857 = {};
	for _, v859 in pairs(v854:GetChildren()) do
		v857[v859.Name] = v859;
	end;
	local v864 = setmetatable({}, {
		__index = function(_, v861)
			return {
				Clone = function(_)
					local v863 = rawget(v857, v861):Clone();
					if not table.find(v855, v863) then
						table.insert(v855, v863);
					end;
					return v863;
				end
			};
		end
	});
	local v865 = {
		_maid = {}
	};
	v865._maid.give = function(_, v867)
		if not table.find(v855, v867) then
			table.insert(v855, v867);
		end;
		return v867;
	end;
	v865._maid.giveTask = function(_, v869)
		if not table.find(v855, v869) then
			table.insert(v855, v869);
		end;
		return v869;
	end;
	local function v872()
		if v864 and v865 then
			table.clear(v864);
			table.clear(v865);
		end;
		if v857 then
			table.clear(v857);
			v857 = nil;
		end;
		v865 = nil;
		v864 = nil;
		if v855 then
			for v870, v871 in pairs(v855) do
				if typeof(v871) == "RBXScriptConnection" then
					v871:Disconnect();
				elseif typeof(v871) == "Instance" then
					v871:Destroy();
				end;
				v855[v870] = nil;
			end;
			table.clear(v855);
		end;
		v855 = nil;
	end;
	task.delay(v856 or 10, v872);
	return v864, v865, v872;
end;

local function v240(v234)
	local l_Sound_0 = Instance.new("Sound");
	game:GetService("CollectionService"):AddTag(l_Sound_0, "NewSound");
	local v236 = nil;
	local v237 = nil;
	v237 = l_Sound_0.Ended:connect(function()
		if l_Sound_0 then
			l_Sound_0:Destroy();
		end;
		if v236 then
			v236:Destroy();
		end;
		return v237:Disconnect();
	end);
	if not v234.RollOffMaxDistance then
		v234.RollOffMaxDistance = 300;
	end;
	if v234.CFrame then
		v236 = Instance.new("Attachment");
		v236.Parent = workspace.Terrain;
		v236.WorldCFrame = v234.CFrame;
		v234.Parent = v236;
	end;
	v234.CFrame = nil;
	for v238, v239 in pairs(v234) do
		l_Sound_0[v238] = v239;
	end;
	return l_Sound_0, v236;
end;

shared.sfx = v240;

local function v89(v84, v85, v86, v87)
	local v88 = v87 or v82;
	if not v85 and v84 then
		v85 = v84;
		v84 = 1;
	end;
	if not v85 and not v84 then
		v84 = 0;
		v85 = 1;
	end;
	if not v86 then
		return v88:NextNumber(v84, v85);
	else
		return v88:NextInteger(v84, v85);
	end;
end;
local function v254(v249, v250, v251)
	local v252 = v249:Dot(v250);
	local v253 = v249:Cross(v250);
	if v252 < -0.99999 then
		return CFrame.fromAxisAngle(v251, 3.141592653589793);
	else
		return CFrame.new(0, 0, 0, v253.x, v253.y, v253.z, 1 + v252);
	end;
end;
local function v265(v259)
	if not v259 then
		return ;
	elseif v259.ClassName == "Model" then
		return ;
	else
		local v260 = v259.Touched:Connect(function()

		end);
		local l_v259_TouchingParts_0 = v259:GetTouchingParts();
		v260:Disconnect();
		local v262 = {};
		for _, v264 in pairs(l_v259_TouchingParts_0) do
			if v264.Name ~= "InvisibleBorder" and v264.Name ~= "InfBall" then
				table.insert(v262, v264);
			end;
		end;
		return v262;
	end;
end;

local function v610(v601, v602, v603)
	local v604 = 1 / (v602 or 60);
	local v605 = 0;
	local v606 = 0;
	local v607 = true;
	local function v608()
		v607 = false;
	end;
	local function v609()
		while v607 do
			v605 = v605 + v606;
			while v604 <= v605 do
				v601(v608);
				v605 = v605 - v604;
				if not v607 then
					break;
				end;
			end;
			v606 = game:GetService("RunService").RenderStepped:wait();
		end;
	end;
	if not v603 then
		task.spawn(v609);
	else
		v609();
	end;
	return v608;
end;
shared.loop = v610;

local v357 = {
	workspace.Live, 
	workspace.Thrown,
	workspace.Effects
};

local function v819(v816)
	local l_FX_2 = v816.FX
	local l_Anchor_1 = v816.Anchor
	l_FX_2 = l_FX_2:Clone()
	if l_FX_2:IsA("Model") then
		l_FX_2:PivotTo(l_Anchor_1)
	elseif l_FX_2:IsA("BasePart") then
		l_FX_2.CFrame = l_Anchor_1
	end
	if l_FX_2:IsA("Attachment") then
		l_FX_2.Parent = l_Anchor_1
		return l_FX_2
	else
		l_FX_2.Parent = workspace.Thrown
		return l_FX_2
	end
end

function Frames(Table,Parents)
	local FPS = Table.FPS
	local Frame = Table.Frames

	local function Create(id)
		local Images = Instance.new('ImageLabel')
		Images.Size = UDim2.new(1, 0,1, 0)
		Images.BackgroundTransparency = 1
		Images.Image = 'rbxassetid://'..id
		Images.Visible = true
		Images.Parent = Parents
		task.wait(FPS)
		Images.Visible = false
	end

	for i,v in Frame do
		Create(i)
	end
end

function impactFrame(arg1, arg2) 
	local function imp() 
		if Lighting:FindFirstChild("DefaultColorCorrection") then
			Lighting.DefaultColorCorrection.Enabled = false
		end
		local ColorCorrectionEffect_2 = Instance.new("ColorCorrectionEffect", game.Lighting)
		ColorCorrectionEffect_2.Brightness = -0.1
		ColorCorrectionEffect_2.Contrast = 0.2
		ColorCorrectionEffect_2.Saturation = 0.1
		if arg1 then
			for _ = 1, arg1 do
				ColorCorrectionEffect_2.Brightness = -25
				ColorCorrectionEffect_2.Contrast = -100
				ColorCorrectionEffect_2.Saturation = -1
				task.wait(0.01)
				ColorCorrectionEffect_2.Brightness = -200
				ColorCorrectionEffect_2.Contrast = 50000
				ColorCorrectionEffect_2.Saturation = -1
				task.wait(0.02)

			end
		else
			ColorCorrectionEffect_2.Brightness = -25
			ColorCorrectionEffect_2.Contrast = -100
			ColorCorrectionEffect_2.Saturation = -1
			task.wait(0.01)
			ColorCorrectionEffect_2.Brightness = -200
			ColorCorrectionEffect_2.Contrast = 50000
			ColorCorrectionEffect_2.Saturation = -1
			task.wait(0.02)
		end
		ColorCorrectionEffect_2:Destroy()
		if Lighting:FindFirstChild("DefaultColorCorrection") then
			Lighting.DefaultColorCorrection.Enabled = true
		end
	end
	if not arg2 then
		task.spawn(imp)
	elseif LocalPlayer:DistanceFromCharacter(arg2[1].Position) <= arg2[2] then
		task.spawn(imp)
	end
end
function Brightness(arg1, arg2, arg3, arg4)
	return false
end

local function v833(v820, v821, v822)
	for _, v824 in pairs(v820:GetDescendants()) do
		if v824:IsA("ParticleEmitter") then
			local l_v824_Attributes_0 = v824:GetAttributes();
			local l_EmitDelay_0 = l_v824_Attributes_0.EmitDelay;
			if l_EmitDelay_0 then
				local l_l_v824_Attributes_0_0 = l_v824_Attributes_0 --[[ copy: 8 -> 12 ]];
				task.delay(l_EmitDelay_0, function()
					v824:Emit(l_l_v824_Attributes_0_0.EmitCount);
				end);
			else
				v824:Emit(l_v824_Attributes_0.EmitCount);
			end;
			if l_v824_Attributes_0.EmitDuration then
				v824.Enabled = true;
				task.delay(l_v824_Attributes_0.EmitDuration, function()
					v824.Enabled = false;
				end);
			end;
		end;
		if v824:IsA("Beam") then
			local l_v824_Attributes_1 = v824:GetAttributes();
			local l_Duration_0 = l_v824_Attributes_1.Duration;
			local v830 = 0.5;
			if v822 and v822.TweenTime then
				v830 = v822.TweenTime;
			end;
			do
				local l_v830_0 = v830;
				local function v832()
					game:GetService("TweenService"):Create(v824, TweenInfo.new(l_v830_0, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
						Width1 = 0, 
						Width0 = 0
					}):Play();
				end;
				(function()
					game:GetService("TweenService"):Create(v824, TweenInfo.new(l_v830_0, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
						Width1 = l_v824_Attributes_1.Width1, 
						Width0 = l_v824_Attributes_1.Width0
					}):Play();
				end)();
				if l_Duration_0 then
					task.delay(l_Duration_0, function()
						v832();
					end);
				end;
			end;
		end;
	end;
	if v821 then
		game.Debris:AddItem(v820, v821);
	end;
end;

local Brightness_2_upvr = Lighting.Brightness

function screenEffect(arg1, arg2) 
	local clone_4_upvr = script.Misc.ScreenEffect:Clone()
	clone_4_upvr.Parent = LocalPlayer.PlayerGui
	if arg2 then
		clone_4_upvr.ImageLabel.ImageTransparency = 0
		Lighting.Brightness = 0
	else
		TS:Create(clone_4_upvr.ImageLabel, TweenInfo.new(2.15, Enum.EasingStyle.Linear), {
			ImageTransparency = 0;
		}):Play()
		TS:Create(Lighting, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Brightness = 0;
		}):Play()
	end
	task.delay(arg1, function() 
		if not clone_4_upvr:IsDescendantOf(game) then
		else
			TS:Create(Lighting, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
				Brightness = Brightness_2_upvr;
			}):Play()
			TS:Create(clone_4_upvr.ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
				ImageTransparency = 1;
			}):Play()
			Debris:AddItem(clone_4_upvr, 1)
		end
	end)
end

local v223 = tick();
local v91 = {};
local function v230()
	if tick() - v223 > 300 then
		v223 = tick();
		local v224 = 0;
		for _, v226 in pairs(workspace.Thrown:GetChildren()) do
			if v226:IsA("Part") and v226:GetAttribute("Spawn") and not table.find(v91, v226) and not v226:GetAttribute("DeletionImmunity") and tick() - v226:GetAttribute("Spawn") > 60 then
				v226:Destroy();
				v224 = v224 + 1;
			end;
		end;
		return ;
	else
		local v227 = rawget(v91, 1);
		if #v91 > 100 then
			for _ = 101, #v91 do
				local v229 = rawget(v91, 101);
				table.remove(v91, 101);
				if v229 then
					v229:Destroy();
				end;
			end;
		end;
		if v227 and not v227.Parent then
			table.remove(v91, 1);
		end;
		if v227 and v227.Parent then
			table.remove(v91, 1);
			if v227.Name == "starterdeb" then
				v227.Name = "aa";
			end;
			v227.CollisionGroup = "Default";
			v227:SetAttribute("Spawn", tick());
			return v227;
		else
			return ;
		end;
	end;
end;
local function ScaleParticle_upvr(arg1, arg2, arg3)
	local tbl_13 = {}
	local tbl_5 = {}
	for i_5, v_5 in arg2.Keypoints do
		tbl_13[i_5] = NumberSequenceKeypoint.new(v_5.Time, v_5.Value * arg3, v_5.Envelope * arg3)
	end
	for i_6, v_6 in arg2.TransparencyKeypoints do
		tbl_5[i_6] = NumberSequenceKeypoint.new(v_6.Time, v_6.Value * arg3, v_6.Envelope * arg3)
	end
	arg1.Size = NumberSequence.new(tbl_13)
	arg1.Speed = NumberRange.new(arg2.Speed.Min * arg3, arg2.Speed.Max * arg3)
	arg1.Acceleration = arg2.Acceleration * arg3
end
local function v556(v550)
	local l_orig_0 = v550.orig;
	local l_dir_0 = v550.dir;
	local v553 = RaycastParams.new();
	v553.FilterDescendantsInstances = v550.Whitelist or v550.Ignore or v357;
	if v550.Whitelist then
		v553.FilterType = Enum.RaycastFilterType.Include;
	else
		v553.FilterType = Enum.RaycastFilterType.Exclude;
	end;
	if v550.Blockcast then
		local v554 = workspace:Blockcast(l_orig_0, v550.Blockcast, l_dir_0, v553);
		if v554 then
			return v554.Instance, v554.Position, v554.Material, v554.Normal;
		else
			return ;
		end;
	else
		local v555 = workspace:Raycast(l_orig_0, l_dir_0, v553);
		if v555 then
			return v555.Instance, v555.Position, v555.Material, v555.Normal;
		else
			return ;
		end;
	end;
end;
function EmitOnly(arg1,arg2)
	local var39 = arg2 or 1
	for _, v_48 in arg1:GetDescendants() do
		if v_48:IsA("ParticleEmitter") then
			v_48.Enabled = false
			v_48:Emit(v_48:GetAttribute("EmitCount"))
		elseif v_48:IsA("PointLight") then
			TS:Create(v_48, TweenInfo.new(var39), {
				Brightness = 0;
			}):Play()
		end
	end
end

local function StoreParticle_upvr(arg1) -- Line 39, Named "StoreParticle"
	local module_2 = {
		Keypoints = {};
		TransparencyKeypoints = {};
	}
	for i_3, v_3 in arg1.Size.Keypoints do
		module_2.Keypoints[i_3] = v_3
	end
	for i_4, v_4 in arg1.Transparency.Keypoints do
		module_2.TransparencyKeypoints[i_4] = v_4
	end
	module_2.Speed = arg1.Speed
	module_2.Acceleration = arg1.Acceleration
	return module_2
end

local function v356(v277)
	if not v277.add then
		v277.add = {};
	end;
	local v278 = v277.sizemult or 1;
	local l_add_0 = v277.add;
	local v280 = Random.new(v277.Seed or tick());
	local l_v89_0 = v89;
	local function v284(v282, v283)
		return l_v89_0(v282, v283, nil, v280);
	end;
	if v277.amount then
		v277.amount = math.floor(v277.amount);
	end;
	local v285 = l_add_0.less and 2.5 or 1;
	local v286 = nil;
	if v277.ground.Name == "Stadium" and not v277.ground:GetAttribute("FakeStadium") and not v277.notiles then
		v286 = v5({
			Effect = "Break Model", 
			Stadium = v277.ground
		});
	end;
	local v287 = 3;
	local v288 = 5;
	local v289 = v280 or v82;
	if not v288 and v287 then
		v288 = v287;
		v287 = 1;
	end;
	if not v288 and not v287 then
		v287 = 0;
		v288 = 1;
	end;
	local v290 = v289:NextNumber(v287, v288);
	if l_LocalPlayer_0:GetAttribute("S_FastMode") then
		v290 = v290 / 2;
	end;
	if v277.nodebris then
		v290 = 0;
	end;
	for _ = 1, v290 do
		if not l_add_0.less then
			local v292 = 1;
			local v293 = 3;
			local v294 = v280 or v82;
			if not v293 and v292 then
				v293 = v292;
				v292 = 1;
			end;
			if not v293 and not v292 then
				v292 = 0;
				v293 = 1;
			end;
			local v295 = v294:NextNumber(v292, v293);
			v292 = v230() or Instance.new("Part");
			v292.CollisionGroup = "nocol";
			v294 = v277.cframe;
			local l_Angles_0 = CFrame.Angles;
			local v297 = -360;
			local v298 = 360;
			local v299 = v280 or v82;
			if not v298 and v297 then
				v298 = v297;
				v297 = 1;
			end;
			if not v298 and not v297 then
				v297 = 0;
				v298 = 1;
			end;
			local v300 = math.rad((v299:NextNumber(v297, v298)));
			v298 = -360;
			v299 = 360;
			local v301 = v280 or v82;
			if not v299 and v298 then
				v299 = v298;
				v298 = 1;
			end;
			if not v299 and not v298 then
				v298 = 0;
				v299 = 1;
			end;
			local v302 = math.rad((v301:NextNumber(v298, v299)));
			v299 = -360;
			v301 = 360;
			local v303 = v280 or v82;
			if not v301 and v299 then
				v301 = v299;
				v299 = 1;
			end;
			if not v301 and not v299 then
				v299 = 0;
				v301 = 1;
			end;
			v292.CFrame = v294 * l_Angles_0(v300, v302, (math.rad((v303:NextNumber(v299, v301)))));
			v292.Size = Vector3.new(v295, v295, v295);
			v292.Color = v277.ground.Color;
			v292.CanCollide = true;
			v292.Anchored = false;
			v292.Material = v277.ground.Material;
			v292.Transparency = v277.ground.Transparency;
			v292:SetAttribute("CanGoThroughCamera", true);
			v292.Transparency = v277.ground.Transparency;
			v292.Parent = workspace.Thrown;
			v293 = Instance.new("BodyVelocity");
			v293.MaxForce = Vector3.new(2000000000, 2000000000, 2000000000, 0);
			v302 = -25;
			v297 = 25;
			v298 = v280 or v82;
			if not v297 and v302 then
				v297 = v302;
				v302 = 1;
			end;
			if not v297 and not v302 then
				v302 = 0;
				v297 = 1;
			end;
			v300 = v298:NextNumber(v302, v297);
			v297 = 5;
			v298 = 25;
			v299 = v280 or v82;
			if not v298 and v297 then
				v298 = v297;
				v297 = 1;
			end;
			if not v298 and not v297 then
				v297 = 0;
				v298 = 1;
			end;
			v293.Velocity = Vector3.new(v300, v299:NextNumber(v297, v298), v284(-25, 25)) * 2;
			v293.Parent = v292;
			game:GetService("Debris"):AddItem(v293, 0.15);
			v294 = delay;
			v300 = 3;
			v297 = 0;
			v298 = 1;
			v299 = v280 or v82;
			if not v298 and v297 then
				v298 = v297;
				v297 = 1;
			end;
			if not v298 and not v297 then
				v297 = 0;
				v298 = 1;
			end;
			v294(v300 + v299:NextNumber(v297, v298), function()
				v3:Create(v292, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Transparency = 1, 
					Size = v292.Size / 1.5
				}):Play();
				delay(0.3, function()
					v292.Anchored = true;
					v292.CanCollide = false;
					v292.CFrame = CFrame.new(100000000, 100000000, 100000000);
					table.insert(v91, v292);
				end);
			end);
		else
			break;
		end;
	end;
	v289 = 4;
	local v304 = 7;
	local v305 = v280 or v82;
	if not v304 and v289 then
		v304 = v289;
		v289 = 1;
	end;
	if not v304 and not v289 then
		v289 = 0;
		v304 = 1;
	end;
	v287 = v305:NextNumber(v289, v304) / v285;
	if l_LocalPlayer_0:GetAttribute("S_FastMode") then
		v287 = v287 / 2;
	end;
	if v277.nodebris then
		v287 = 0;
	end;
	for _ = 1, v287 do
		local v307 = 0.6;
		local v308 = 0.8;
		local v309 = v280 or v82;
		if not v308 and v307 then
			v308 = v307;
			v307 = 1;
		end;
		if not v308 and not v307 then
			v307 = 0;
			v308 = 1;
		end;
		v305 = v309:NextNumber(v307, v308);
		v307 = v230() or Instance.new("Part");
		v307.CFrame = v277.cframe;
		v308 = v254(v307.CFrame.UpVector, v277.normal, (Vector3.new(0, 1, 0, 0)));
		v307.CFrame = v307.CFrame * (v308 * CFrame.Angles(1.5707963267948966, 0, 0));
		v307.CollisionGroup = "nocol";
		v307.Size = Vector3.new(v305, v305, v305);
		v307.Color = v277.ground.Color;
		v307.CanCollide = true;
		v307.Name = "SmallDebris";
		v307.Anchored = false;
		v307.Material = v277.ground.Material;
		v307.Transparency = v277.ground.Transparency;
		v307:SetAttribute("CanGoThroughCamera", true);
		v307.Transparency = v277.ground.Transparency;
		v307.Parent = workspace.Thrown;
		v309 = Instance.new("BodyVelocity");
		v309.MaxForce = Vector3.new(2000000000, 2000000000, 2000000000, 0);
		local v310 = -25;
		local v311 = 25;
		local v312 = v280 or v82;
		if not v311 and v310 then
			v311 = v310;
			v310 = 1;
		end;
		if not v311 and not v310 then
			v310 = 0;
			v311 = 1;
		end;
		local v313 = v312:NextNumber(v310, v311);
		v311 = 5;
		v312 = 25;
		local v314 = v280 or v82;
		if not v312 and v311 then
			v312 = v311;
			v311 = 1;
		end;
		if not v312 and not v311 then
			v311 = 0;
			v312 = 1;
		end;
		v309.Velocity = Vector3.new(v313, v314:NextNumber(v311, v312), v284(-25, 25)) * 2;
		v309.Parent = v307;
		game:GetService("Debris"):AddItem(v309, 0.15);
		local l_BodyAngularVelocity_0 = Instance.new("BodyAngularVelocity");
		l_BodyAngularVelocity_0.Parent = v307;
		game:GetService("Debris"):AddItem(l_BodyAngularVelocity_0, 0.5);
		local l_delay_0 = delay;
		v310 = 3;
		v312 = 0;
		v314 = 1;
		local v317 = v280 or v82;
		if not v314 and v312 then
			v314 = v312;
			v312 = 1;
		end;
		if not v314 and not v312 then
			v312 = 0;
			v314 = 1;
		end;
		l_delay_0(v310 + v317:NextNumber(v312, v314), function()
			v3:Create(v307, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Transparency = 1, 
				Size = v307.Size / 1.5
			}):Play();
			delay(0.3, function()
				l_BodyAngularVelocity_0:Destroy();
				v307.Anchored = true;
				v307.CanCollide = false;
				v307.CFrame = CFrame.new(100000000, 100000000, 100000000);
				table.insert(v91, v307);
			end);
		end);
	end;
	v288 = {};
	v289 = 5;
	v304 = 7;
	if v277.new then
		v289 = v277.new[1];
		v304 = v277.new[2];
	end;
	v305 = CFrame.new(v277.cframe.p);
	local v318 = (v289 + v304) / 2;
	local v319 = v277.amount or 16;
	if l_LocalPlayer_0:GetAttribute("S_FastMode") then
		v319 = v319 / 2;
	end;
	v305 = v305 * v254(v305.UpVector, v277.normal, (Vector3.new(0, 1, 0, 0)));
	local l_Angles_1 = CFrame.Angles;
	local v321 = 0;
	local v322 = -360;
	local v323 = 360;
	local v324 = v280 or v82;
	if not v323 and v322 then
		v323 = v322;
		v322 = 1;
	end;
	if not v323 and not v322 then
		v322 = 0;
		v323 = 1;
	end;
	v305 = v305 * l_Angles_1(v321, math.rad((v324:NextNumber(v322, v323))), 0);
	v321 = CFrame.Angles;
	local v325 = 0;
	v323 = -16;
	v324 = 16;
	local v326 = v280 or v82;
	if not v324 and v323 then
		v324 = v323;
		v323 = 1;
	end;
	if not v324 and not v323 then
		v323 = 0;
		v324 = 1;
	end;
	l_Angles_1 = v305 * v321(v325, math.rad((v326:NextNumber(v323, v324))), 0);
	v321 = true;
	if v289 ~= 5 and v304 ~= 7 then
		v277.Double = 2;
	end;
	for v327 = 1, v319 do
		for v328 = 1, v277.Double or 1 do
			local l_v305_0 = v305;
			if v328 > 1 then
				l_v305_0 = l_Angles_1;
				v318 = v318 + 1;
			end;
			local v330 = math.sin((360 / v319 + 360 / v319 * v327) / 57.29577951308232);
			local v331 = math.cos((360 / v319 + 360 / v319 * v327) / 57.29577951308232);
			local v332 = l_v305_0 * CFrame.new(v318 * v330, 0, v318 * v331);
			local v333 = 0.2;
			if v277.Double then
				v333 = 0.35;
			end;
			local l_lookVector_0 = v332.lookVector;
			local v335 = -v333;
			local l_v333_0 = v333;
			local l_v335_0 = v335;
			local l_l_v333_0_0 = l_v333_0;
			local v339 = v280 or v82;
			if not l_l_v333_0_0 and l_v335_0 then
				l_l_v333_0_0 = l_v335_0;
				l_v335_0 = 1;
			end;
			if not l_l_v333_0_0 and not l_v335_0 then
				l_v335_0 = 0;
				l_l_v333_0_0 = 1;
			end;
			v332 = v332 + l_lookVector_0 * v339:NextNumber(l_v335_0, l_l_v333_0_0);
			local v340 = v230() or Instance.new("Part");
			v340.Anchored = true;
			v340.CanCollide = false;
			v340.CanTouch = true;
			v340.Material = v277.ground.Material;
			v340.Color = v277.ground.Color;
			v340.CFrame = v332 * CFrame.fromEulerAnglesXYZ(0, (360 / v319 + 360 / v319 * v327) / 57.29577951308232, 0);
			l_lookVector_0 = v340.CFrame;
			local l_Angles_2 = CFrame.Angles;
			l_l_v333_0_0 = 6;
			v339 = 42;
			local v342 = v280 or v82;
			if not v339 and l_l_v333_0_0 then
				v339 = l_l_v333_0_0;
				l_l_v333_0_0 = 1;
			end;
			if not v339 and not l_l_v333_0_0 then
				l_l_v333_0_0 = 0;
				v339 = 1;
			end;
			v340.CFrame = l_lookVector_0 * l_Angles_2(math.rad(-v342:NextNumber(l_l_v333_0_0, v339)), 0, 0);
			l_v335_0 = 2;
			l_l_v333_0_0 = 5;
			v339 = v280 or v82;
			if not l_l_v333_0_0 and l_v335_0 then
				l_l_v333_0_0 = l_v335_0;
				l_v335_0 = 1;
			end;
			if not l_l_v333_0_0 and not l_v335_0 then
				l_v335_0 = 0;
				l_l_v333_0_0 = 1;
			end;
			v335 = v339:NextNumber(l_v335_0, l_l_v333_0_0) * (v328 > 1 and 1.8 or v277.Double and 1.35 or 1);
			l_v335_0 = 1.9;
			l_l_v333_0_0 = 2.4;
			v339 = v280 or v82;
			if not l_l_v333_0_0 and l_v335_0 then
				l_l_v333_0_0 = l_v335_0;
				l_v335_0 = 1;
			end;
			if not l_l_v333_0_0 and not l_v335_0 then
				l_v335_0 = 0;
				l_l_v333_0_0 = 1;
			end;
			v340.Size = Vector3.new(v335, v339:NextNumber(l_v335_0, l_l_v333_0_0), v284(2, 6)) * v278;
			v340.CFrame = v340.CFrame * CFrame.new(0, -(v340.Size.Y / 3 + v340.Size.Z / 3) / 3, 0);
			v340.Transparency = 1;
			v340.Parent = workspace.Thrown;
			l_lookVector_0 = v340.CFrame;
			l_Angles_2 = nil;
			v335 = v265(v340);
			l_v333_0 = {};
			l_v335_0 = nil;
			l_l_v333_0_0 = nil;
			for _, v344 in pairs(v335) do
				if not v344:IsDescendantOf(workspace.Live) and v344.Name ~= "invis" and v344.Parent ~= workspace.Thrown then
					if v344.Material ~= v277.ground.Material then
						l_Angles_2 = v344;
					end;
					table.insert(l_v333_0, v344);
				end;
				if v344 == v277.ground then
					l_v335_0 = v277.ground;
				end;
				if v344.Name == "Stadium" then
					l_l_v333_0_0 = true;
				end;
			end;
			v339 = v340.CFrame;
			local v345 = CFrame.new(0, -3, -1.5);
			local l_Angles_3 = CFrame.Angles;
			local v347 = -11;
			local v348 = 11;
			local v349 = v280 or v82;
			if not v348 and v347 then
				v348 = v347;
				v347 = 1;
			end;
			if not v348 and not v347 then
				v347 = 0;
				v348 = 1;
			end;
			local v350 = math.rad((v349:NextNumber(v347, v348)));
			v348 = -11;
			v349 = 11;
			local v351 = v280 or v82;
			if not v349 and v348 then
				v349 = v348;
				v348 = 1;
			end;
			if not v349 and not v348 then
				v348 = 0;
				v349 = 1;
			end;
			local v352 = math.rad((v351:NextNumber(v348, v349)));
			v349 = -11;
			v351 = 11;
			local v353 = v280 or v82;
			if not v351 and v349 then
				v351 = v349;
				v349 = 1;
			end;
			if not v351 and not v349 then
				v349 = 0;
				v351 = 1;
			end;
			v340.CFrame = v339 * (v345 * l_Angles_3(v350, v352, (math.rad((v353:NextNumber(v349, v351))))));
			v340.Transparency = 0;
			table.insert(v288, v340);
			v339 = true;
			if #l_v333_0 ~= 0 then
				v339 = v277.ground:GetAttribute("Breakable") or not v277.ground.Anchored;
			end;
			v342 = v277.angle;
			if v342 then
				l_Angles_3 = v277.anglecfr;
				v350 = l_lookVector_0.Position;
				v342 = math.deg((math.acos((l_Angles_3.LookVector:Dot((Vector3.new(v350.X, l_Angles_3.p.Y, v350.Z) - l_Angles_3.p).unit))))) <= v277.angle;
			end;
			if v339 or v342 then
				v340.Transparency = 1;
			else
				if l_Angles_2 and (not l_v335_0 or l_v335_0.Name ~= "Stadium") and (not l_l_v333_0_0 or v277.ground.Name ~= "Stadium") then
					if v277.ground.Material == Enum.Material.Grass and l_v335_0 then
						l_Angles_2 = workspace.Preload.Dirt;
					end;
					v340.Color = l_Angles_2.Color;
					v340.Material = l_Angles_2.Material;
				end;
				v340.Transparency = v277.ground.Transparency;
			end;
			if v340.Transparency >= 1 then
				v340.CanCollide = false;
				v340.CanTouch = false;
				v340.CanQuery = false;
			else
				v340.CanCollide = true;
			end;
			if v340.Velocity.magnitude > 0 then
				v340.AssemblyLinearVelocity = Vector3.new();
				v340.AssemblyAngularVelocity = Vector3.new();
			end;
			if v321 then
				v321 = false;
				v345 = {
					"rbxassetid://3848076724", 
					"rbxassetid://3848078820"
				};
				l_Angles_3 = {
					"rbxassetid://4307208601", 
					"rbxassetid://4307207425", 
					"rbxassetid://4307207693", 
					"rbxassetid://4307205188", 
					"rbxassetid://3778609188", 
					"rbxassetid://3778608737", 
					"rbxassetid://3744401196", 
					"rbxassetid://4307204962"
				};
				v350 = {
					"rbxassetid://4307204696", 
					"rbxassetid://4307204452"
				};
				if l_add_0.sounds and not v277.nosound then
					v352 = 1;
					if v286 then
						v352 = 2;
					end;
					v347 = v240;
					v348 = {};
					v353 = #v350;
					local v354 = nil;
					local l_v82_1 = v82;
					if not v354 and v353 then
						v354 = v353;
						v353 = 1;
					end;
					if not v354 and not v353 then
						v353 = 0;
						v354 = 1;
					end;
					v348.SoundId = v350[l_v82_1:NextInteger(v353, v354)];
					v348.Volume = 3.85 / v352;
					v348.Parent = v340;
					v347(v348):Play();
					v347 = v240;
					v348 = {};
					v353 = #l_Angles_3;
					v354 = nil;
					l_v82_1 = v82;
					if not v354 and v353 then
						v354 = v353;
						v353 = 1;
					end;
					if not v354 and not v353 then
						v353 = 0;
						v354 = 1;
					end;
					v348.SoundId = l_Angles_3[l_v82_1:NextInteger(v353, v354)];
					v348.Volume = 4.3 / v352;
					v348.Parent = v340;
					v347(v348):Play();
					v347 = v240;
					v348 = {};
					v353 = #v345;
					v354 = nil;
					l_v82_1 = v82;
					if not v354 and v353 then
						v354 = v353;
						v353 = 1;
					end;
					if not v354 and not v353 then
						v353 = 0;
						v354 = 1;
					end;
					v348.SoundId = v345[l_v82_1:NextInteger(v353, v354)];
					v348.Volume = 4.12 / v352;
					v348.Parent = v340;
					v347(v348):Play();
				end;
			end;
			v340:SetAttribute("OGCframe", l_lookVector_0);
			v345 = v3;
			v350 = v340;
			v352 = TweenInfo.new;
			v348 = 0.2;
			v349 = 0.3;
			v351 = v280 or v82;
			if not v349 and v348 then
				v349 = v348;
				v348 = 1;
			end;
			if not v349 and not v348 then
				v348 = 0;
				v349 = 1;
			end;
			v345:Create(v350, v352(v351:NextNumber(v348, v349), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				CFrame = l_lookVector_0
			}):Play();
			v345 = delay;
			l_Angles_3 = l_add_0.keep;
			if not l_Angles_3 then
				v350 = 5;
				v352 = 7;
				v347 = v280 or v82;
				if not v352 and v350 then
					v352 = v350;
					v350 = 1;
				end;
				if not v352 and not v350 then
					v350 = 0;
					v352 = 1;
				end;
				l_Angles_3 = v347:NextNumber(v350, v352);
			end;
			v345(l_Angles_3, function()
				if l_add_0.keep then
					v3:Create(v340, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						CFrame = l_lookVector_0, 
						Size = v340.Size
					}):Play();
					wait(2);
				end;
				v3:Create(v340, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					CFrame = v340.CFrame * CFrame.new(0, -7, 0), 
					Size = v340.Size / 1.5
				}):Play();
				wait(2);
				v340:SetAttribute("OGCframe", nil);
				v340.Anchored = true;
				v340.CFrame = CFrame.new(100000000, 100000000, 100000000);
				table.insert(v91, v340);
			end);
		end;
	end;
	return v288;
end;

local function deltaTimeWait(waitTime)
	local passedTime = 0

	while passedTime < waitTime do
		passedTime += RNS.Heartbeat:Wait()
	end

	return passedTime
end

local function QuickWeld(Part0, Part1, Parent)
	local Weld = Instance.new("WeldConstraint")
	Weld.Part0 = Part0
	Weld.Part1 = Part1
	Weld.Parent = Parent

	return Weld
end



local function CameraShake(v32, v33, v34, v35) --[[ Line: 67 ]] --[[ Name: CameraShake ]]
	local function v39() --[[ Line: 68 ]] --[[ Name: runCam ]]
		local v36 = CameraShaker.CameraShakeInstance.new(5, v32, 0, v33);
		v36.PositionInfluence = Vector3.new(1, 1, 0, 0) * v34;
		local v38 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(v37) --[[ Line: 72 ]]
			workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * v37;
		end);
		v38:Start();
		v38:Shake(v36);
	end;
	if not v35 then
		v39();
		return;
	elseif Players.LocalPlayer:DistanceFromCharacter(v35[1].Position) > v35[2] then
		return;
	else
		v39();
		return;
	end;
end;

local function AddToActiveItems(Object, Lifetime, Character)
	local Container = script.ActiveItems:FindFirstChild(Character.Name)
	if not Container then
		Container = Instance.new('Folder')
		Container.Name = Character.Name
		Container.Parent = script.ActiveItems
	end

	local ObjectValue = Instance.new('ObjectValue')
	ObjectValue.Parent = Container
	ObjectValue.Value = Object
	if Lifetime then
		Debris:AddItem(ObjectValue, Lifetime)
	end

	Object.Destroying:Once(function()
		ObjectValue:Destroy()
	end)

	return Container
end

local function raycast(Origin: Vector3, Direction: Vector3, rayParams: RaycastParams, isWhitelist: boolean, returnIsolated: boolean)
	local localRayParams
	if typeof(rayParams) == 'table' then
		localRayParams = RaycastParams.new()
		localRayParams.FilterDescendantsInstances = rayParams
		if isWhitelist then
			localRayParams.FilterType = Enum.RaycastFilterType.Include
		else
			localRayParams.FilterType = Enum.RaycastFilterType.Exclude
		end
	else
		localRayParams = MapRayParams
	end

	local ray = workspace:Raycast(Origin, Direction, localRayParams)
	if not returnIsolated then
		return ray
	else
		return ray.Instance, ray.Position, ray.Material, ray.Normal
	end
end

local function newRock(CF,BaseSize,RemoveTime,lookAtCenter,Step,Parent)
	local Raye = raycast(CF.Position,Vector3.new(0,-10+(-BaseSize*2),0))
	if Raye and Raye.Instance then
		local DebrisTime = 0


		local Position = Raye.Position + Vector3.new(0,0,Step/2)
		local startpos = Position-Vector3.new(0,BaseSize,0)


		local Part = Instance.new("Part")
		Part.Name = "newRock"
		Part.Anchored = true
		Part.CanCollide = true
		Part.CanTouch = false
		Part.CanQuery = false
		Part.CollisionGroup = 'Debris'
		Part.Size = Vector3.new(BaseSize,BaseSize,BaseSize*1.2)
		if lookAtCenter then
			Part.CFrame = CF * CFrame.new(0,-BaseSize,0) * CFrame.Angles(0,0,math.rad(45))
			Part.Size += Vector3.new(0,0,Step)
		else
			Part.CFrame = CF * CFrame.new(0,-BaseSize,0) * CFrame.Angles(Random.new():NextNumber(0,2)*math.pi,0,Random.new():NextNumber(0,2)*math.pi)
		end
		Part.Parent = Parent or workspace.Debris

		if Raye.Instance:IsA("BasePart") then 
			Part.Material = Raye.Instance.Material 
			Part.Color = Raye.Instance.Color
		end

		TS:Create(Part,TweenInfo.new(.1,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position = Position}):Play()
		delay(Random.new():NextNumber(RemoveTime-.2,RemoveTime+.2),function()
			TS:Create(Part,TweenInfo.new(1,Enum.EasingStyle.Cubic,Enum.EasingDirection.In),{Position = Part.Position - Vector3.new(0,BaseSize,0)}):Play()
			Debris:AddItem(Part,1)
		end)	
	end
end

local function EaseOutSixtic(Time)
	return Time ^ 6;
end

local function flyRock(Info)
	local MaxSize = (Info.BaseSize * 100) + 100
	local MinSize = Info.BaseSize * 100
	local MaxVelocity = Info.BaseSize * 120
	local MinYVelocity = Info.BaseSize * 10


	local Folder
	if not Info.Parent then
		Folder = Instance.new('Folder')
		Folder.Name = 'flyRock'
		Folder.Parent = workspace.Debris
		game:GetService('Debris'):AddItem(Folder, 10)
	end

	for i = 0,Info.Rocks or 8 do
		local part = script.Rocks.flyRock.Debris:Clone()
		part.Parent = Folder or Info.Parent
		part.CFrame = Info.CFrame
		TS:Create(part,TweenInfo.new(0.2),{Size = Vector3.new(math.random(MinSize,MaxSize)/100,math.random(MinSize,MaxSize)/100,math.random(MinSize,MaxSize)/100)}):Play()

		if Info.Material then
			if Info.Material == Enum.Material.Grass then
				part.Color = Color3.fromRGB(86, 66, 54)
				part.Material = Enum.Material.Slate
			else
				part.Material = Info.Material
			end
		end

		if Info.Transparency then
			part.Transparency = Info.Transparency
		end

		if Info.Color then
			part.Color = Info.Color
		end

		local raycast = raycast(part.Position + Vector3.new(0,7.5,0),Info.RayDir or Vector3.new(0,-10,0),MapRayParams)
		if raycast and raycast.Instance then
			if not Info.Material then
				part.Material = raycast.Instance.Material
			end

			if not Info.Transparency then
				part.Transparency = raycast.Instance.Transparency
			end

			if not Info.Color then
				part.Color = raycast.Instance.Color
			end

			if raycast.Instance.Material == Enum.Material.Grass then
				part.Color = Color3.fromRGB(86, 66, 54)
				part.Material = Enum.Material.Slate
			end
		end

		part.AssemblyLinearVelocity = Vector3.new(math.random(-MaxVelocity,MaxVelocity),math.random(MinYVelocity,MaxVelocity),math.random(-MaxVelocity,MaxVelocity))
		part.AssemblyAngularVelocity = Vector3.new(math.random(-45,45),math.random(-45,45),math.random(-45,45))
		spawn(function()
			wait(math.random(5,9))

			TS:Create(part,TweenInfo.new(0.5,Enum.EasingStyle.Cubic),{Size = Vector3.new(0,0,0)}):Play()

			wait(.5)

			part:Destroy()
		end)
	end
end

local function ScreenFlash(flashColor, startTransparency, goalTransparency, tweenTime, easeStyle, easeDirection)
	for _,v in LocalPlayer.PlayerGui:GetChildren() do
		if v.Name == 'ScreenFlashEffect' then
			v:Destroy()
		end
	end

	if typeof(flashColor) ~= "Color3" then
		flashColor = Color3.new(255, 255, 255)
	end

	if typeof(startTransparency) ~= "number" then
		startTransparency = 0
	end

	if typeof(goalTransparency) ~= "number" then
		goalTransparency = 1
	end

	if typeof(tweenTime) ~= "number" then
		tweenTime = 0.35
	end

	if typeof(easeStyle) ~= "EnumItem" then
		easeStyle = Enum.EasingStyle.Exponential
	end

	if typeof(easeDirection) ~= "EnumItem" then
		easeDirection = Enum.EasingDirection.Out
	end


	local flashGui = Instance.new("ScreenGui")
	flashGui.IgnoreGuiInset = true
	flashGui.Name = "ScreenFlashEffect"

	local flashFrame = Instance.new("Frame")
	flashFrame.Size = UDim2.new(1.5, 0, 1.5, 0)
	flashFrame.BackgroundColor3 = flashColor
	flashFrame.BackgroundTransparency = startTransparency
	flashFrame.Name = "Flash"
	flashFrame.Parent = flashGui

	flashGui.Parent = LocalPlayer.PlayerGui


	TS:Create(flashFrame, TweenInfo.new(tweenTime, easeStyle, easeDirection), {
		BackgroundTransparency = goalTransparency
	}):Play()
	Debris:AddItem(flashGui, tweenTime)
end

local function generateRandomNumber(v84, v85, v86, v87)
	local v88 = v87 or RandomSeed;
	if not v85 and v84 then
		v85 = v84;
		v84 = 1;
	end;
	if not v85 and not v84 then
		v84 = 0;
		v85 = 1;
	end;
	if not v86 then
		return v88:NextNumber(v84, v85);
	else
		return v88:NextInteger(v84, v85);
	end;
end;

local function getNormal(v249, v250, v251)
	local v252 = v249:Dot(v250);
	local v253 = v249:Cross(v250);
	if v252 < -0.99999 then
		return CFrame.fromAxisAngle(v251, 3.141592653589793);
	else
		return CFrame.new(0, 0, 0, v253.x, v253.y, v253.z, 1 + v252);
	end;
end;

RockFlakes = function(v20, v21, v22, v23, _) --[[ Line: 34 ]] --[[ Name: RockFlakes ]]
	v23 = v23 or Vector3.one;
	local function v31() --[[ Line: 36 ]] --[[ Name: spawnRock ]]
		local v25 = Vector3.new(v20.Position.X, v20.Position.Y, v20.Position.Z);
		local v26 = CFrame.new(v25) * CFrame.new(math.random(-v21 * 4.5, v21 * 4.5), -v21, math.random(-v21 * 4.5, v21 * 4.5)).Position + v23;
		local v27 = l_Raycast_0(v26, (Vector3.new(0, -v20.Size.Y * 3, 0)));
		if v27 and v27.Instance.Transparency < 1 then
			local v28 = script.Okarun.DashSmoke:Clone();
			v28.Parent = workspace.Effects;
			v28.CFrame = CFrame.new(v27.Position);
			for _, v30 in ipairs(v28:GetDescendants()) do
				if v30:IsA("ParticleEmitter") then
					v30:Emit(v30:GetAttribute("EmitCount"));
					v30.Color = ColorSequence.new(v27.Instance.Color);
				end;
			end;
			Debris:AddItem(v28, 2);
		end;
	end;
	if v22 then
		v22 = workspace:GetServerTimeNow() + v22;
		repeat
			v31();
			task.wait(0.03);
		until v22 <= workspace:GetServerTimeNow() or not v20:IsDescendantOf(game);
	else
		v31();
	end;
end;

local function addSound(v234)
	local l_Sound_0 = Instance.new("Sound");
	l_Sound_0.SoundGroup = game:GetService("SoundService").Sounds;
	game.CollectionService:AddTag(l_Sound_0, "NewSound");
	local v236 = nil;
	local v237 = nil;
	v237 = l_Sound_0.Ended:connect(function()
		if l_Sound_0 then
			l_Sound_0:Destroy();
		end;
		if v236 then
			v236:Destroy();
		end;
		return v237:Disconnect();
	end);
	if not v234.RollOffMaxDistance then
		v234.RollOffMaxDistance = 300;
	end;
	if v234.CFrame then
		v236 = Instance.new("Attachment");
		v236.Parent = workspace.Terrain;
		v236.WorldCFrame = v234.CFrame;
		v234.Parent = v236;
	end;
	v234.CFrame = nil;
	for v238, v239 in pairs(v234) do
		l_Sound_0[v238] = v239;
	end;
	return l_Sound_0, v236;
end;


local function LinearVelocity(v304, v305, v306, v307, v308, v309) --[[ Line: 1260 ]] --[[ Name: LinearVelocity ]]
	for _, v311 in ipairs(v304:GetDescendants()) do
		if v311:IsA("LinearVelocity") then
			v311:Destroy();
		end;
	end;
	local l_LinearVelocity_3 = Instance.new("LinearVelocity");
	l_LinearVelocity_3.Attachment0 = v304.RootAttachment;
	l_LinearVelocity_3.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
	l_LinearVelocity_3.MaxAxesForce = v309 or Vector3.new(1, 0, 1, 0) * 30000;
	l_LinearVelocity_3.RelativeTo = Enum.ActuatorRelativeTo.Attachment0;
	l_LinearVelocity_3.VectorVelocity = v305;
	l_LinearVelocity_3.Parent = v304;
	if v307 and v308 then
		TS:Create(l_LinearVelocity_3, TweenInfo.new(table.unpack(v307)), v308):Play();
	end;
	Debris:AddItem(l_LinearVelocity_3, v306);
	return l_LinearVelocity_3;
end;

local function cutscene(v91, v92, v93, v94, v95, v96) --[[ Line: 238 ]] --[[ Name: Cutscene ]]
	if Camera.CameraType == Enum.CameraType.Scriptable then
		return;
	else
		v92 = v92 or RS.Modules.CameraHandler.CameraRig2 --script.CameraRig;

		local v97 = Trova.new();
		local l_Character_0 = LocalPlayer.Character;
		local l_Humanoid_0 = l_Character_0:FindFirstChildOfClass("Humanoid");
		if not l_Humanoid_0.RootPart and not l_Character_0.PrimaryPart then
			local _ = l_Character_0.HumanoidRootPart;
		end;
		v97:AttachToInstance(l_Character_0);
		if not v94 then
			v94 = CFrame.new(Vector3.zero);
		end;
		local v101 = v92:Clone();
		v101.Parent = workspace.Effects;
		v101:PivotTo(v93.CFrame * v94);
		local v102 = AnimEvents:loadAnimation(v101,v91) --AnimationService:loadAnimation(v101, v91);
		v102:Play();
		Camera.CameraType = Enum.CameraType.Scriptable;
		l_Humanoid_0.AutoRotate = false;
		if v95 then
			local v103 = 0;
			do
				local l_v103_0 = v103;
				v97:Add(RNS.PreRender:Connect(function(v105) --[[ Line: 265 ]]
					local v106 = v105 * 60;
					l_v103_0 = l_v103_0 + v106;
					local l_v95_FirstChild_0 = v95:FindFirstChild((tonumber((math.ceil(l_v103_0)))));
					if l_v95_FirstChild_0 then
						Camera.FieldOfView = l_v95_FirstChild_0.Value;
					end;
				end));
			end;
		end;
		local v108 = v101:FindFirstChild("camera") or v101:FindFirstChild("CamPart") or v101:FindFirstChild('Cam') or v101:FindFirstChild("cam");
		local v109 = 0;
		v97:Add(RNS.PreRender:Connect(function(v110) --[[ Line: 277 ]]
			v101:PivotTo(v93.CFrame * v94);
			if not v96 or v109 >= 20 then
				Camera.CFrame = v108.CFrame;
				return;
			else
				if v109 < 20 then
					v109 = v109 + 0.1;
				end;
				Camera.CFrame = Camera.CFrame:Lerp(v108.CFrame, v110 * v109);
				return;
			end;
		end));
		v97:Add(function() --[[ Line: 288 ]]
			l_Humanoid_0.AutoRotate = true;
			v101:Destroy();
			Camera.FieldOfView = 70;
			Camera.CameraType = Enum.CameraType.Custom;
		end);
		v97:Add(l_Humanoid_0.Died:Once(function() --[[ Line: 294 ]]
			v97:Destroy();
		end));
		v97:Add(v102.Stopped:Once(function() --[[ Line: 297 ]]
			v97:Destroy();
		end));
		return;
	end;
end;

local function EmitRaycast(v54, v55, v56, v57) --[[ Line: 136 ]] --[[ Name: EmitRaycast ]]
	if not v54:IsDescendantOf(game) then
		return;
	else
		v56 = v56 or 1;
		local v58 = v57 or Vector3.yAxis * -3;
		v58 = l_Raycast_0(v54.Position, v58);
		if v58 then
			local v59 = v55:Clone();
			v59.Parent = workspace.Effects;
			v59.Anchored = true;
			v59.CFrame = CFrame.new(v58.Position, v58.Position + v58.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0);
			Debris:AddItem(v59, v56);
			for _, v61 in v59:GetDescendants() do
				if v61:IsA("ParticleEmitter") then
					v61.Enabled = false;
					v61:Emit(v61:GetAttribute("EmitCount"));
				elseif v61:IsA("PointLight") then
					TS:Create(v61, TweenInfo.new(v56), {
						Brightness = 0
					}):Play();
				end;
			end;
		end;
		return;
	end;
end;

local Emit = function(v46, v47, v48, v49, _) --[[ Line: 113 ]] --[[ Name: Emit ]]
	if not v46:IsDescendantOf(game) then
		return;
	else
		v48 = v48 or 1;
		v49 = v49 or CFrame.new();
		local v51 = v47:Clone();
		v51.Parent = workspace.Effects;
		v51.CFrame = (v46:IsA("CFrameValue") and v46.Value or v46.CFrame) * v49;
		v51.Anchored = true;
		Debris:AddItem(v51, v48);
		for _, v53 in v51:GetDescendants() do
			if v53:IsA("ParticleEmitter") then
				v53.Enabled = false;
				v53:Emit(v53:GetAttribute("EmitCount"));
			elseif v53:IsA("PointLight") then
				TS:Create(v53, TweenInfo.new(v48), {
					Brightness = 0
				}):Play();
			end;
		end;
		return;
	end;
end;


--// Remotes \\--

local Remotes = RS.Remotes


local Comunicator = Remotes.Comunicator

local ComSet = Comunicator.Set
local ComGet = Comunicator.Get


local Replicate = Remotes.Replicate

local Replicate_Get = Replicate.Get
local Replicate_Set = Replicate.Set


local DashSpeed = 85
local AnimationCache = {}

local ReplicationEffects = { 
	preloadanims = function(AnimationsList)
		local PreloadRig = workspace:WaitForChild("Preloader")
		local Animator = PreloadRig:WaitForChild("Humanoid"):WaitForChild("Animator")

		for _, AnimationId in AnimationsList do
			local Animation = Instance.new("Animation")
			Animation.AnimationId = AnimationId

			local AnimationTrack = Animator:LoadAnimation(Animation)
			Animation:Destroy()
			AnimationTrack = nil
		end

		Debris:AddItem(PreloadRig, 5)
	end,
	SmokeAura = function(Params)
		local Character : Model = Params.Char
		local HumRP = Character.HumanoidRootPart
		local Stage = Params.Stage
		local Smoke2 = script["Strongest of Today"].RCT.SmokeAura.Smoke2:Clone()

		if Stage == "Start" then
			ParticlesModule.Enabled(Smoke2,true)
			Smoke2.Parent = HumRP
			Debris:AddItem(Smoke2,Params.Time)
		end
	end,

	SSmokeAura = function(Params)
		local Character : Model = Params.Char
		local HumRP = Character.HumanoidRootPart
		local Stage = Params.Stage

		if Stage == "Start" then

			local vfx3 = script["Disgraced One"].SRCT.RCT:Clone()
			vfx3.Parent = workspace.Effects
			vfx3.CFrame = HumRP.CFrame * CFrame.new(0,0,0)
			ParticlesModule.Emit(vfx3)
			Debris:AddItem(vfx3, 5) 

		end
	end,
	
	['dddd2'] = function(Params)
		local Character: Model = Params.Char
		--local Stage = Params.Stage
		local HumRP, Torso, leftarm, rightarm, head
		if Character then
			HumRP = Character.HumanoidRootPart
			Torso = Character.Torso
			head = Character.Head
			leftarm = Character["Left Arm"]
			rightarm = Character["Right Arm"]
		end


		task.delay(0.2, function()

			for _,v in HumRP:GetChildren() do
				if v:IsA('BodyVelocity') then
					v:Destroy()
				end
			end

			local runVelocity = Instance.new("BodyVelocity")
			runVelocity.MaxForce = Vector3.new(1, 0, 1) * 9000

			local runMagnitude = Instance.new("NumberValue")
			runMagnitude.Value = 15
			runMagnitude.Parent = runVelocity

			local startTween = TS:Create(runMagnitude, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Value = 100
			})
			local endTween = TS:Create(runMagnitude, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Value = 12
			})

			startTween.Completed:Once(function()
				task.delay(0.05, function()
					endTween:Play()
				end)
			end)

			runVelocity.Parent = HumRP
			startTween:Play()
			Debris:AddItem(runVelocity, 0.15) 

			task.spawn(function()
				while task.wait() and runVelocity.Parent ~= nil do
					runVelocity.Velocity = HumRP.CFrame.LookVector * runMagnitude.Value
				end
			end)
		end)
	end,
	
	['DAsh2'] = function(Params)
		local Character: Model = Params.Char
		local Stage = Params.Stage
		local HumRP, Torso, leftarm, rightarm, head
		if Character then
			HumRP = Character.HumanoidRootPart
			Torso = Character.Torso
			head = Character.Head
			leftarm = Character["Left Arm"]
			rightarm = Character["Right Arm"]
		end


		task.delay(0.2, function()

			for _,v in HumRP:GetChildren() do
				if v:IsA('BodyVelocity') then
					v:Destroy()
				end
			end

			local runVelocity = Instance.new("BodyVelocity")
			runVelocity.MaxForce = Vector3.new(1, 0, 1) * 90000

			local runMagnitude = Instance.new("NumberValue")
			runMagnitude.Value = 15
			runMagnitude.Parent = runVelocity

			local startTween = TS:Create(runMagnitude, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Value = 100
			})
			local endTween = TS:Create(runMagnitude, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Value = 12
			})

			startTween.Completed:Once(function()
				task.delay(0.05, function()
					endTween:Play()
				end)
			end)

			runVelocity.Parent = HumRP
			startTween:Play()
			Debris:AddItem(runVelocity, 0.45) 

			task.spawn(function()
				while task.wait() and runVelocity.Parent ~= nil do
					runVelocity.Velocity = HumRP.CFrame.LookVector * runMagnitude.Value
				end
			end)
		end)
	end,

	HurricaneDropkickHit = function(Params) --[[ Line: 345 ]] --[[ Name: HurricaneDropkickHit ]]
		local Players = game:GetService('Players')
		local l_HumanoidRootPart_2 = Params.Char:FindFirstChild('HumanoidRootPart')
		local l_HumanoidRootPart_3 = Params.Enem:FindFirstChild('HumanoidRootPart')
		local l_Players_PlayerFromCharacter_0 = Players:GetPlayerFromCharacter(Params.Char);
		local l_Players_PlayerFromCharacter_1 = Players:GetPlayerFromCharacter(Params.Enem);
		if Players.LocalPlayer == l_Players_PlayerFromCharacter_0 or Players.LocalPlayer == l_Players_PlayerFromCharacter_1 then
			cutscene(RS.Modules.CameraHandler.Animations.HurricaneDropkickCam,script.Okarun.Cam, l_HumanoidRootPart_2, CFrame.new(Vector3.yAxis * -3), game.ReplicatedStorage.Assets.Cutscenes.hdkFOV);
			--CameraTableAnims:PlayAnimation('NMG', l_HumanoidRootPart_2);
			--CameraHandler:PlayCameraAnimation('NMG', l_HumanoidRootPart_2);
			--l_Sound_0:play(script.Okarun["Dropkick hit (1)"], l_SoundService_0);
		else
			--l_Sound_0:play(script.Okarun["Dropkick hit (1)"], l_HumanoidRootPart_2);
		end;
		local v132 = script.Okarun.TP:Clone();
		v132.Parent = Params.Char;
		local l_Weld_0 = Instance.new("Weld");
		l_Weld_0.Part0 = Params.Char.Torso;
		l_Weld_0.Part1 = v132;
		l_Weld_0.Parent = v132;
		local v134 = script.Okarun.hdkEffect:Clone();
		v134.Parent = Params.Char;
		v134:PivotTo(l_HumanoidRootPart_2.CFrame);
		CameraShake(5, 0.5, 5, {
			l_HumanoidRootPart_3, 
			15
		});
		ParticlesModule.Emit(l_HumanoidRootPart_3, script.Okarun.hdkEffect.kick1, 3);
		v134.Mesh.Wave.Decal.Transparency = 0;
		v134.Mesh.Wave.Size = Vector3.new(0.7990000247955322, 1.3899999856948853, 0.20600000023841858, 0);
		TS:Create(v134.Mesh.Wave, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			Size = Vector3.new(0.7990000247955322, 1.3899999856948853, 0.20600000023841858, 0)
		}):Play();
		TS:Create(v134.Mesh.Wave.Decal, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			Transparency = 1
		}):Play();
		task.delay(0.78, function() --[[ Line: 380 ]]
			v134:PivotTo(l_HumanoidRootPart_2.CFrame);
			v134.CurveWind2.Transparency = 0;
			v134.CurveWind2.Size = Vector3.new(10, 15, 10, 0);
			TS:Create(v134.CurveWind2, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Transparency = 1, 
				Size = Vector3.new(10, 8, 10, 0), 
				CFrame = v134.CurveWind2.CFrame * CFrame.new(0, -6, -2)
			}):Play();
		end);
		task.delay(1, function() --[[ Line: 387 ]]
			v134:PivotTo(l_HumanoidRootPart_2.CFrame);
			CameraShake(5, 0.5, 5, {
				l_HumanoidRootPart_3, 
				15
			});
			local v135 = script.Okarun.ft:Clone();
			v135.Parent = Params.Char;
			local l_Weld_1 = Instance.new("Weld");
			l_Weld_1.Part0 = Params.Char.Torso;
			l_Weld_1.Part1 = v135;
			l_Weld_1.Parent = v135;
			for _, v138 in v134.Smoke2:GetDescendants() do
				if v138:IsA("ParticleEmitter") then
					v138.Enabled = true;
				end;
			end;
			for _, v140 in v134.Winddd:GetDescendants() do
				if v140:IsA("Beam") then
					v140.Enabled = true;
				end;
			end;
			task.wait(1);
			for _, v142 in v134.Winddd:GetDescendants() do
				if v142:IsA("Beam") then
					v142.Enabled = false;
				end;
			end;
			for _, v144 in v134.Smoke2:GetDescendants() do
				if v144:IsA("ParticleEmitter") then
					v144.Enabled = false;
				end;
			end;
			for _, v146 in v135:GetDescendants() do
				if v146:IsA("ParticleEmitter") then
					v146.Enabled = false;
				end;
			end;
			Debris:AddItem(v135, 3);
		end);
		task.delay(2.3, function() --[[ Line: 427 ]]
			v132:Destroy();
			v134:PivotTo(l_HumanoidRootPart_2.CFrame);
			CameraShake(5, 0.5, 3, {
				l_HumanoidRootPart_3, 
				50
			});
			v134.Mesh.ring.Size = Vector3.new(9.059000015258789, 15, 9.059000015258789, 0);
			v134.Mesh.ring.Transparency = 0;
			TS:Create(v134.Mesh.ring, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
				Size = Vector3.new(35, 0.8980000019073486, 35, 0), 
				Transparency = 1
			}):Play();
			for _, v148 in v134.WindUp:GetDescendants() do
				if v148:IsA("ParticleEmitter") then
					v148:Emit(v148:GetAttribute("EmitCount"));
				end;
			end;
			for _, v150 in v134.Impact:GetDescendants() do
				if v150:IsA("ParticleEmitter") then
					v150:Emit(v150:GetAttribute("EmitCount"));
				end;
			end;
		end);
		task.delay(3.2, function() --[[ Line: 445 ]]
			v134:PivotTo(l_HumanoidRootPart_2.CFrame);
			for _, v152 in v134.Jump:GetDescendants() do
				if v152:IsA("ParticleEmitter") then
					v152:Emit(v152:GetAttribute("EmitCount"));
				end;
			end;
		end);
		task.delay(5, function() --[[ Line: 452 ]]
			if Players.LocalPlayer == l_Players_PlayerFromCharacter_0 or Players.LocalPlayer == l_Players_PlayerFromCharacter_1 then
				TS:Create(Lighting.Atmosphere, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					Color = Color3.fromRGB(0, 0, 0), 
					Density = 0.8, 
					Haze = 5
				}):Play();
			end;
		end);
		task.delay(5.25, function() --[[ Line: 457 ]]
			local v153 = script.Okarun.eyeeeee:Clone();
			v153.Parent = Params.Char;
			local l_Weld_2 = Instance.new("Weld");
			l_Weld_2.Part0 = Params.Char.Head;
			l_Weld_2.Part1 = v153;
			l_Weld_2.Parent = v153;
			for _, v156 in v153:GetDescendants() do
				if v156:IsA("ParticleEmitter") then
					v156:Emit(v156:GetAttribute("EmitCount"));
				end;
			end;
			local v157 = script.Okarun.footyaya:Clone();
			v157.Parent = Params.Char;
			local l_Weld_3 = Instance.new("Weld");
			l_Weld_3.Part0 = Params.Char["Left Leg"];
			l_Weld_3.Part1 = v157;
			l_Weld_3.Parent = v157;
			local v159 = script.Okarun.footyaya:Clone();
			v159.Parent = Params.Char;
			local l_Weld_4 = Instance.new("Weld");
			l_Weld_4.Part0 = Params.Char["Right Leg"];
			l_Weld_4.Part1 = v159;
			l_Weld_4.Parent = v159;
			local v161 = script.Okarun.armyaya:Clone();
			v161.Parent = Params.Char;
			local l_Weld_5 = Instance.new("Weld");
			l_Weld_5.Part0 = Params.Char["Left Arm"];
			l_Weld_5.Part1 = v161;
			l_Weld_5.Parent = v161;
			local v163 = script.Okarun.armyaya:Clone();
			v163.Parent = Params.Char;
			local l_Weld_6 = Instance.new("Weld");
			l_Weld_6.Part0 = Params.Char["Right Arm"];
			l_Weld_6.Part1 = v163;
			l_Weld_6.Parent = v163;
			Debris:AddItem(v157, 4);
			Debris:AddItem(v159, 4);
			Debris:AddItem(v161, 4);
			Debris:AddItem(v163, 4);
			Debris:AddItem(v153, 4);
		end);
		task.delay(9, function() --[[ Line: 511 ]]
			v134:PivotTo(l_HumanoidRootPart_2.CFrame);
			v134.Mesh.Shockwave4.Shockwave4Decal.Transparency = 0;
			v134.Mesh.Shockwave4.Shockwave4Mesh.Scale = Vector3.new(1.7910000085830688, 3.7780001163482666, 1.7910000085830688, 0);
			TS:Create(v134.Mesh.Shockwave4.Shockwave4Mesh, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Scale = Vector3.new(15, 55, 15, 0)
			}):Play();
			TS:Create(v134.Mesh.Shockwave4.Shockwave4Decal, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Transparency = 1
			}):Play();
			v134.Mesh.Windd.Size = Vector3.new(19.549999237060547, 9, 19.549999237060547, 0);
			v134.Mesh.Windd.Transparency = 0;
			TS:Create(v134.Mesh.Windd, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
				Size = Vector3.new(35, 1, 35, 0), 
				Transparency = 1
			}):Play();
			for _, v166 in v134.EndFx:GetDescendants() do
				if v166:IsA("ParticleEmitter") then
					v166:Emit(v166:GetAttribute("EmitCount"));
				end;
			end;
			if Players.LocalPlayer == l_Players_PlayerFromCharacter_0 or Players.LocalPlayer == l_Players_PlayerFromCharacter_1 then
				TS:Create(Lighting.Atmosphere, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					Color = Color3.fromRGB(0, 0, 0), 
					Density = 0.213, 
					Haze = 0
				}):Play();
			end;
			l_HumanoidRootPart_2.CFrame = l_HumanoidRootPart_2.CFrame + l_HumanoidRootPart_2.CFrame.LookVector * 45
		end);
		task.delay(11, function() --[[ Line: 531 ]]
			v134:Destroy();
		end);
	end;
	Teleport = function(Params) --[[ Line: 180 ]] --[[ Name: Teleport ]]
		local l_HumanoidRootPart_0 = Params.Char.HumanoidRootPart;
		local l_Children_0 = workspace.Live:GetChildren();
		table.remove(l_Children_0, table.find(l_Children_0, Params.Char));
		local v69 = l_Raycast_0(l_HumanoidRootPart_0.Position, l_HumanoidRootPart_0.CFrame.LookVector * 40, nil, {
			workspace.Map, 
			l_Children_0
		}) or l_HumanoidRootPart_0.CFrame + l_HumanoidRootPart_0.CFrame.LookVector * Params.P;
		l_HumanoidRootPart_0.CFrame = CFrame.new(v69.Position, v69.Position + l_HumanoidRootPart_0.CFrame.LookVector);
	end;
	runVelocity = function(Params)
		local HumRP = Params.Char.HumanoidRootPart

		for _,v in HumRP:GetChildren() do
			if v:IsA('BodyVelocity') then
				v:Destroy()
			end
		end

		local runVelocity = Instance.new("BodyVelocity")
		runVelocity.MaxForce = Vector3.new(1, 0, 1) * 450000
		local runMagnitude = Instance.new("NumberValue")
		runMagnitude.Value = 10
		runMagnitude.Parent = runVelocity

		local startTween = TS:Create(runMagnitude, TweenInfo.new(Params.StartTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			Value = Params.One
		})
		local endTween = TS:Create(runMagnitude, TweenInfo.new(Params.EndTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			Value = Params.Second
		})

		startTween.Completed:Once(function()
			task.delay(0.1, function()
				endTween:Play()
			end)
		end)

		runVelocity.Parent = HumRP
		startTween:Play()
		endTween.Completed:Once(function()
			runVelocity:Destroy()
		end)

		task.spawn(function()
			while task.wait() and runVelocity.Parent ~= nil do
				runVelocity.Velocity = HumRP.CFrame.LookVector * runMagnitude.Value
			end
		end)
	end,
	SwirlKick = function(Params) --[[ Line: 904 ]] --[[ Name: SwirlKick ]]
		local l_HumanoidRootPart_8 = Params.Char.HumanoidRootPart;
		Emit(l_HumanoidRootPart_8, script.Okarun["AirWindo (Enabled 0 - 0:24)"], 2, CFrame.new(Vector3.zAxis * -1));
		task.delay(0.24, function() --[[ Line: 907 ]]
			Emit(l_HumanoidRootPart_8, script.Okarun["PreImpact (Enabled 0:23 - 0:31 )"], 2);
		end);
		task.delay(0.3, function() --[[ Line: 910 ]]
			Emit(l_HumanoidRootPart_8, script.Okarun["Hit (Emit 0:30)"], 3, CFrame.new(Vector3.yAxis * -3 + Vector3.zAxis * -1));
		end);
	end;
	AxeKick = function(Params) --[[ Line: 915 ]] --[[ Name: AxeKick ]]
		local l_HumanoidRootPart_9 = Params.Char.HumanoidRootPart;
		task.delay(0.2, function() --[[ Line: 917 ]]
			Emit(l_HumanoidRootPart_9, script.Okarun["KickStartUp (Emit 0:14)"], 2, CFrame.new(Vector3.yAxis * -3));
		end);
		task.delay(1, function() --[[ Line: 920 ]]
			Emit(l_HumanoidRootPart_9, script.Okarun["LegSlam (0:60)"], 3, CFrame.new(Vector3.yAxis * -3 + Vector3.zAxis * -1));
		end);
	end;
	HurricaneDropkick = function(Params) --[[ Line: 794 ]] --[[ Name: HurricaneDropkick ]]
		local l_HumanoidRootPart_7 = Params.Char.HumanoidRootPart;
		local v211 = script.Okarun.breakdance:Clone();
		v211.Parent = Params.Char;
		v211:PivotTo(l_HumanoidRootPart_7.CFrame);
		local v213 = RNS.PreRender:connect(function(_) --[[ Line: 802 ]]
			v211:PivotTo(l_HumanoidRootPart_7.CFrame);
		end);
		task.delay(0.25, function() --[[ Line: 805 ]]
			for _, v215 in ipairs(v211.StartUp:GetDescendants()) do
				if v215:IsA("ParticleEmitter") then
					v215:Emit(v215:GetAttribute("EmitCount"));
				end;
			end;
		end);
		task.delay(0.5, function() --[[ Line: 812 ]]
			CameraShake(5, 0.5, 1.5, {
				l_HumanoidRootPart_7, 
				50
			});
			v211.Shockwave.ShockwaveDecal.Transparency = 0;
			v211.Shockwave.ShockwaveMesh.Scale = Vector3.new(1, 4, 1, 0);
			TS:Create(v211.Shockwave.ShockwaveMesh, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
				Scale = Vector3.new(4, 7, 4, 0)
			}):Play();
			TS:Create(v211.Shockwave.ShockwaveDecal, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
				Transparency = 1
			}):Play();
			for _, v217 in ipairs(v211.spin:GetDescendants()) do
				if v217:IsA("ParticleEmitter") then
					v217.Enabled = true;
				end;
			end;
		end);
		local l_LinearVelocity_2 = Instance.new("LinearVelocity");
		l_LinearVelocity_2.Attachment0 = l_HumanoidRootPart_7.RootAttachment;
		l_LinearVelocity_2.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
		l_LinearVelocity_2.MaxAxesForce = Vector3.new(1, 0, 1, 0) * 30000;
		l_LinearVelocity_2.RelativeTo = Enum.ActuatorRelativeTo.Attachment0;
		l_LinearVelocity_2.Parent = l_HumanoidRootPart_7;
		TS:Create(l_LinearVelocity_2, TweenInfo.new(1.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			VectorVelocity = Vector3.zAxis * -40
		}):Play();
		local v219 = script.Okarun.TrailSpin:Clone();
		v219.Parent = Params.Char;
		local l_Weld_10 = Instance.new("Weld");
		l_Weld_10.Part0 = Params.Char.Torso;
		l_Weld_10.Part1 = v219;
		l_Weld_10.Parent = v219;
		l_Weld_10.C0 = CFrame.new(0, 2, 0);
		task.wait(2.5);
		v213:Disconnect();
		for _, v222 in ipairs(v219:GetDescendants()) do
			if v222:IsA("Trail") then
				v222.Enabled = false;
			end;
		end;
		Debris:AddItem(v219, 2);
		v211.Wave.Decal.Transparency = 0;
		v211.Wave.DirtMesh.Scale = Vector3.new(1.5, 0.15000000596046448, 0.15000000596046448, 0);
		TS:Create(v211.Wave.DirtMesh, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Scale = Vector3.new(0.05999999865889549, 0.699999988079071, 0.699999988079071, 0)
		}):Play();
		TS:Create(v211.Wave.Decal, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Transparency = 1
		}):Play();
		TS:Create(v211.Wave, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			CFrame = v211.Wave.CFrame * CFrame.new(0, -2, 0)
		}):Play();
		v211.Shockwave4.Shockwave4Decal.Transparency = 0;
		v211.Shockwave4.Shockwave4Mesh.Scale = Vector3.new(1.5, 0.15000000596046448, 0.15000000596046448, 0);
		TS:Create(v211.Shockwave4.Shockwave4Mesh, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Scale = Vector3.new(2, 8, 2, 0)
		}):Play();
		TS:Create(v211.Shockwave4.Shockwave4Decal, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Transparency = 1
		}):Play();
		TS:Create(v211.Shockwave4, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			CFrame = v211.Shockwave4.CFrame * CFrame.new(0, 4, 0)
		}):Play();
		for _, v224 in ipairs(v211.spin:GetDescendants()) do
			if v224:IsA("ParticleEmitter") then
				v224.Enabled = false;
			end;
		end;
		Debris:AddItem(v211, 3);
		TS:Create(l_LinearVelocity_2, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			VectorVelocity = Vector3.zero
		}):Play();
		Debris:AddItem(l_LinearVelocity_2, 0.15);
		for _, v226 in v211.EndSpin:GetDescendants() do
			if v226:IsA("ParticleEmitter") then
				v226:Emit(v226:GetAttribute("EmitCount"));
			end;
		end;
		task.wait(0.45);
		v211:PivotTo(l_HumanoidRootPart_7.CFrame);
		for _, v228 in v211.EnDGound:GetDescendants() do
			if v228:IsA("ParticleEmitter") then
				v228:Emit(v228:GetAttribute("EmitCount"));
			end;
		end;
		v211.Shockwave2.Shockwave2Decal.Transparency = 0;
		v211.Shockwave2.Shockwave2Mesh.Scale = Vector3.new(1, 12, 1, 0);
		TS:Create(v211.Shockwave2.Shockwave2Mesh, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Scale = Vector3.new(5, 6, 5, 0)
		}):Play();
		TS:Create(v211.Shockwave2.Shockwave2Decal, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Transparency = 1
		}):Play();
		CameraShake(5, 0.5, 1.5, {
			l_HumanoidRootPart_7, 
			50
		});
		task.delay(5, v211.Destroy, v211);
	end;
	fixspeedbug = function(Params)
		local HumRP: BasePart = LocalCharacter:FindFirstChild('HumanoidRootPart')	
		if not HumRP then return end

		local Part = Instance.new("Part");
		Part.Massless = true
		Part.Anchored = false
		Part.Size = Vector3.zero
		Part.Material = Enum.Material.SmoothPlastic
		Part.Transparency = 1
		Part.EnableFluidForces = false
		Part.CastShadow = false
		Part.CanCollide = false
		Part.CanTouch = false
		Part.CanQuery = false
		Part.Parent = LocalCharacter

		local Weld = Instance.new("Weld")
		Weld.Parent = Part
		Weld.Part0 = HumRP
		Weld.Part1 = Part

		RNS.RenderStepped:Wait()

		Part:Destroy()
	end,

	UpdateVictimCFrame = function(params)
		local function applyCFrameToCharacter(Character)
			local EnemyHumRP = Character:FindFirstChild("HumanoidRootPart")

			if EnemyHumRP then
				EnemyHumRP.CFrame = params.CF
			end
		end

		local Player = game.Players.LocalPlayer
		Player.CharacterAdded:Connect(function(Character)
			applyCFrameToCharacter(Character)
		end)

		if Player.Character then
			applyCFrameToCharacter(Player.Character)
		end
	end,

	powercascade = function(Params)
		local Character: Model = Params.Char
		local HumRP: BasePart
		if Character then
			HumRP = Character.HumanoidRootPart
		end

		local EnemyCharacter: Model = Params.EChar
		local EnemyHumRP: BasePart
		if EnemyCharacter then
			EnemyHumRP = EnemyCharacter.HumanoidRootPart
		end

		local Stage: string = Params.Stage
		local AssetsFolder = script.Jun.PowerCascade
		local isFinisher: boolean = Params.isFinisher

		if Stage == 'Start' then
			local function dashForward(Speed)
				for _, bv in HumRP:GetChildren() do
					if bv:IsA("BodyVelocity") then
						bv:Destroy()
					end
				end

				local forwardDashVelocity = Instance.new("BodyVelocity")
				forwardDashVelocity.MaxForce = Vector3.new(1, 0, 1) * 86000

				local velocityMagnitude = Instance.new("NumberValue")
				velocityMagnitude.Value = Speed
				velocityMagnitude.Parent = forwardDashVelocity

				local compareNumber
				if Speed == 24 then
					compareNumber = 4
				elseif Speed == 47 then
					compareNumber = 5
				end

				velocityMagnitude:GetPropertyChangedSignal("Value"):Connect(function()
					if velocityMagnitude.Value <= compareNumber then
						forwardDashVelocity:Destroy()
					end
				end)


				forwardDashVelocity.Parent = HumRP

				task.spawn(function()
					while forwardDashVelocity ~= nil and forwardDashVelocity.Parent ~= nil do
						forwardDashVelocity.Velocity = HumRP.CFrame.LookVector * velocityMagnitude.Value;
						task.wait()
					end
				end)

				TS:Create(velocityMagnitude, TweenInfo.new(1.15, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
					Value = 0
				}):Play()

				Debris:AddItem(forwardDashVelocity, 1.15)
			end

			local function contact()
				local contactVFX = AssetsFolder.Contact:Clone()
				contactVFX.CFrame = EnemyHumRP.CFrame
				contactVFX.Parent = workspace.Thrown
				ParticlesModule.Emit(contactVFX)

				if (contactVFX.Position - LocalCharacter:GetPivot().Position).Magnitude <= 20 then
					ShakeCameraModule:ShakeCamera(12.5, 12.5, 0, .2)
				end

				Debris:AddItem(contactVFX, 3)

				dashForward(24)
			end


			local firstKickVFX = AssetsFolder.FirstKick:Clone()
			firstKickVFX.CFrame = EnemyHumRP.CFrame
			firstKickVFX.Parent = workspace.Thrown
			ParticlesModule.Emit(firstKickVFX)
			if (firstKickVFX.Position - LocalCharacter:GetPivot().Position).Magnitude <= 20 then
				ShakeCameraModule:ShakeCamera(22, 22, 0 ,.4)
			end
			Debris:AddItem(firstKickVFX, 3)

			dashForward(47)


			task.delay(0.400, contact) -- Contact1

			task.delay(0.533, function() -- Hit1
				local downKickMesh = AssetsFolder.DownKickMesh:Clone()
				downKickMesh.CFrame = EnemyHumRP.CFrame * CFrame.new(-0.0244445801, 0.17137146, -0.0148925781, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				downKickMesh.Mesh.Scale = Vector3.new(0.005, 0.053, 0.005)
				downKickMesh.Transparency = 0.9
				downKickMesh.Decal.Transparency = 0
				downKickMesh.Parent = workspace.Thrown

				local kickVFX = AssetsFolder.Kick:Clone()
				kickVFX.CFrame = EnemyHumRP.CFrame
				kickVFX.Parent = workspace.Thrown
				ParticlesModule.Emit(kickVFX)

				TS:Create(downKickMesh.Mesh, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					Scale = Vector3.new(0.031, 0.013, 0.031)
				}):Play()
				TS:Create(downKickMesh.Decal, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					Transparency = 1
				}):Play()
				TS:Create(downKickMesh, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					Transparency = 1, 
					Position = downKickMesh.Position - Vector3.new(0, 2, 0)
				}):Play()

				if (kickVFX.Position - LocalCharacter:GetPivot().Position).Magnitude <= 20 then
					ShakeCameraModule:ShakeCamera(15, 15, 0, .2)
				end

				Debris:AddItem(downKickMesh, .7)
				Debris:AddItem(kickVFX, 3)


				dashForward(47)
			end)


			task.delay(0.933, contact) -- Contact2

			task.delay(1.083, function() -- Hit2
				local groundMesh = AssetsFolder.GroundMesh:Clone()
				groundMesh.CFrame = EnemyHumRP.CFrame * CFrame.new(-0.0244445801, -3.19159698, -0.0148925781, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				groundMesh.Mesh.Scale = Vector3.new(0.006, 0.007, 0.006)
				groundMesh.Transparency = 0
				groundMesh.Parent = workspace.Thrown

				local kickRotatedVFX = AssetsFolder.KickRotated:Clone()
				kickRotatedVFX.CFrame = EnemyHumRP.CFrame
				kickRotatedVFX.Parent = workspace.Thrown
				ParticlesModule.Emit(kickRotatedVFX)

				TS:Create(groundMesh.Mesh, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					Scale = Vector3.new(0.046, 0.037, 0.046)
				}):Play()
				TS:Create(groundMesh, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
					Transparency = 1, 
					Orientation = Vector3.new(0, -200, 0)
				}):Play()

				if (kickRotatedVFX.Position - LocalCharacter:GetPivot().Position).Magnitude <= 20 then
					ShakeCameraModule:ShakeCamera(15, 15, 0, .2)
				end

				Debris:AddItem(groundMesh, .5)
				Debris:AddItem(kickRotatedVFX, 3)


				dashForward(47)
			end)


			task.delay(1.533, contact) -- Contact3

			task.delay(1.600, function() -- Hit3
				local downKickMesh = AssetsFolder.DownKickMesh:Clone()
				downKickMesh.CFrame = EnemyHumRP.CFrame * CFrame.new(-0.0244445801, 0.17137146, -0.0148925781, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				downKickMesh.Mesh.Scale = Vector3.new(0.005, 0.053, 0.005)
				downKickMesh.Transparency = 0.9
				downKickMesh.Decal.Transparency = 0
				downKickMesh.Parent = workspace.Thrown

				local kickVFX = AssetsFolder.Kick:Clone()
				kickVFX.CFrame = EnemyHumRP.CFrame
				kickVFX.Parent = workspace.Thrown
				ParticlesModule.Emit(kickVFX)

				TS:Create(downKickMesh.Mesh, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					Scale = Vector3.new(0.031, 0.013, 0.031)
				}):Play()
				TS:Create(downKickMesh.Decal, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
					Transparency = 1
				}):Play()
				TS:Create(downKickMesh, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
					Transparency = 1, 
					Position = downKickMesh.Position - Vector3.new(0, 2, 0)
				}):Play()

				if (kickVFX.Position - LocalCharacter:GetPivot().Position).Magnitude <= 20 then
					ShakeCameraModule:ShakeCamera(15, 15, 0, .2)
				end

				Debris:AddItem(downKickMesh, .7)
				Debris:AddItem(kickVFX, 3)


				dashForward(47)
			end)


			task.delay(1.717, contact) -- Contact4

			task.delay(1.767, function() -- Hit4
				local kickVFX = AssetsFolder.Kick:Clone()
				kickVFX.CFrame = EnemyHumRP.CFrame
				kickVFX.Parent = workspace.Thrown
				ParticlesModule.Emit(kickVFX)

				if (kickVFX.Position - LocalCharacter:GetPivot().Position).Magnitude <= 20 then
					ShakeCameraModule:ShakeCamera(15, 15, 0, .2)
				end

				Debris:AddItem(kickVFX, 3)


				dashForward(47)
			end)


			task.delay(2.150, contact) -- Contact5

			task.delay(2.217, function() -- Hit5
				local downKickMesh = AssetsFolder.DownKickMesh:Clone()
				downKickMesh.CFrame = EnemyHumRP.CFrame * CFrame.new(-0.0244445801, 0.17137146, -0.0148925781, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				downKickMesh.Mesh.Scale = Vector3.new(0.005, 0.053, 0.005)
				downKickMesh.Transparency = 0.9
				downKickMesh.Decal.Transparency = 0
				downKickMesh.Parent = workspace.Thrown

				local kickVFX = AssetsFolder.Kick:Clone()
				kickVFX.CFrame = EnemyHumRP.CFrame
				kickVFX.Parent = workspace.Thrown
				ParticlesModule.Emit(kickVFX)

				TS:Create(downKickMesh.Mesh, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					Scale = Vector3.new(0.031, 0.013, 0.031)
				}):Play()
				TS:Create(downKickMesh.Decal, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					Transparency = 1
				}):Play()
				TS:Create(downKickMesh, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					Transparency = 1, 
					Position = downKickMesh.Position - Vector3.new(0, 2, 0)
				}):Play()

				if (kickVFX.Position - LocalCharacter:GetPivot().Position).Magnitude <= 20 then
					ShakeCameraModule:ShakeCamera(15, 15, 0, .2)
				end

				Debris:AddItem(downKickMesh, .7)
				Debris:AddItem(kickVFX, 3)


				dashForward(47)
			end)


			task.delay(2.300, contact) -- Contact6

			task.delay(2.417, function() -- Hit6
				local downKickMesh = AssetsFolder.DownKickMesh:Clone()
				downKickMesh.CFrame = EnemyHumRP.CFrame * CFrame.new(-0.0244445801, 0.17137146, -0.0148925781, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				downKickMesh.Mesh.Scale = Vector3.new(0.005, 0.053, 0.005)
				downKickMesh.Transparency = 0.9
				downKickMesh.Decal.Transparency = 0
				downKickMesh.Parent = workspace.Thrown

				local kickVFX = AssetsFolder.Kick:Clone()
				kickVFX.CFrame = EnemyHumRP.CFrame
				kickVFX.Parent = workspace.Thrown
				ParticlesModule.Emit(kickVFX)

				TS:Create(downKickMesh.Mesh, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					Scale = Vector3.new(0.031, 0.013, 0.031)
				}):Play()
				TS:Create(downKickMesh.Decal, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					Transparency = 1
				}):Play()
				TS:Create(downKickMesh, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					Transparency = 1, 
					Position = downKickMesh.Position - Vector3.new(0, 2, 0)
				}):Play()

				if (kickVFX.Position - LocalCharacter:GetPivot().Position).Magnitude <= 20 then
					ShakeCameraModule:ShakeCamera(15, 15, 0, .2)
				end

				Debris:AddItem(downKickMesh, .7)
				Debris:AddItem(kickVFX, 3)


				dashForward(47)
			end)

			task.delay(2.817, function() -- UppercutContact
				local uppercutContactVFX = AssetsFolder.UppercutContact:Clone()
				uppercutContactVFX.CFrame = EnemyHumRP.CFrame * CFrame.new(-0.122283936, -2.86486626, -1.26635742, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				uppercutContactVFX.Parent = workspace.Thrown
				ParticlesModule.Emit(uppercutContactVFX)

				if (uppercutContactVFX.Position - LocalCharacter:GetPivot().Position).Magnitude <= 20 then
					ShakeCameraModule:ShakeCamera(24.6, 24.6, 0, .4)
				end

				Debris:AddItem(uppercutContactVFX, 3)


				if isFinisher == true and (Character == LocalCharacter or EnemyCharacter == LocalCharacter) then
					local cameraTrack = CameraHandler:PlayCameraAnimation('PowerCascade', HumRP, .3, false)
					local cameraEvents = {}

					cameraEvents['Frames'] = cameraTrack:GetMarkerReachedSignal('Frames'):Once(function()
						shared.ActivateiFrames('PowerCascade', nil, 'Jun')
					end)

					cameraTrack.Stopped:Once(function()
						for _,v in cameraEvents do
							v:Disconnect()
						end
					end)

					Assets.Sounds.PoweCascadeFinisherXray.TimePosition = 0
					Assets.Sounds.PoweCascadeFinisherXray:Play()
				end
			end)

		elseif Stage == 'Uppercut' then
			local uppercutVFX = AssetsFolder.Uppercut:Clone()
			uppercutVFX.CFrame = EnemyHumRP.CFrame * CFrame.new(-0.122283936, -2.86486626, -1.26635742, 1, 0, 0, 0, 1, 0, 0, 0, 1)
			uppercutVFX.Parent = workspace.Thrown
			ParticlesModule.Emit(uppercutVFX)

			if (uppercutVFX.Position - LocalCharacter:GetPivot().Position).Magnitude <= 20 then
				ShakeCameraModule:ShakeCamera(28, 28, 0, .5)
			end

			Debris:AddItem(uppercutVFX, 3)

		end
	end,

	virgule = function(Params)
		local Character: Model = Params.Char
		local HumRP: BasePart = Character.HumanoidRootPart

		local Stage: string = Params.Stage
		local AssetsFolder = script.Jun.Virgule

		if Stage == 'Start' then
			local function miniDash(speed)
				for _, bv in pairs(HumRP:GetChildren()) do
					if bv:IsA("BodyVelocity") then
						bv:Destroy()
					end
				end

				local miniDashBV = Instance.new("BodyVelocity")
				miniDashBV.Parent = HumRP
				miniDashBV.MaxForce = Vector3.new(70000, 0, 70000)

				task.spawn(function()
					while task.wait() and miniDashBV.Parent ~= nil do
						miniDashBV.Velocity = HumRP.CFrame.LookVector * speed
					end
				end)

				Debris:AddItem(miniDashBV, .1)
			end

			task.delay(0.033, miniDash, 10)
			task.delay(0.200, miniDash, 10)
			task.delay(0.450, miniDash, 16)

		elseif Stage == 'Hit' then
			local EnemyCharacter: Model = Params.EChar
			local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

			local function triggerDaggerTrail(boolean, emitStar)
				for _, trail in Character:GetDescendants() do
					if trail:IsA("Trail") and trail.Name == "VirguleCascadeTrail" then
						trail.Enabled = boolean
					end
				end
			end

			local function emitDaggerStar()
				for _, part in Character:GetDescendants() do
					if part:IsA("Model") and part.Name == "Dagger" and part:FindFirstChild("HandleR") and part:FindFirstChild("HandleR"):FindFirstChild("Star") then
						ParticlesModule.Emit(part.HandleR.Star)

						break
					end
				end
			end

			local function teleportVFX()
				local tpFX = AssetsFolder.Teleport:Clone()
				tpFX.Parent = workspace.Thrown
				tpFX.Position = Character.Torso.Position
				ParticlesModule.Emit(tpFX)
				Debris:AddItem(tpFX, 1)
			end



			local headStabVFX = AssetsFolder.HeadStab:Clone()
			headStabVFX.Parent = workspace.Thrown
			headStabVFX.CFrame = HumRP.CFrame * CFrame.new(-0.0551147461, 1.17809296, -3.88208008, -0.997749925, -0.0668663457, -0.00490233861, -0.0670462474, 0.995129943, 0.0723508894, 4.06216313E-5, 0.0725167692, -0.997373879)

			if LocalConfigFolder.Blood.Value == false then
				for _, blood in headStabVFX:GetDescendants() do
					if blood:IsA("ParticleEmitter") and blood.Name == "Blood" then
						blood:Destroy()
					end
				end
			end

			if Character == LocalCharacter or (HumRP.Position - LocalCharacter:GetPivot().Position).Magnitude <= 25 then
				ShakeCameraModule:ShakeCamera(17, 17, 0, .43)
			end;
			ParticlesModule.Emit(headStabVFX)
			Debris:AddItem(headStabVFX, 1.5)


			task.delay(0.450, function()
				triggerDaggerTrail(true)
			end)

			task.delay(0.617, function()
				triggerDaggerTrail(false)
				emitDaggerStar()
			end)

			task.delay(0.667, teleportVFX)

			task.delay(0.917, function()
				local kickFX = AssetsFolder.Kick:Clone()
				kickFX.Parent = workspace.Thrown
				kickFX.CFrame = HumRP.CFrame * CFrame.new(0, 1.56897163, -9.06591797, 1, 0, 0, 0, 1.00000668, 0, 0, 0, 1.00000668)

				if Character == LocalCharacter or (HumRP.Position - LocalCharacter:GetPivot().Position).Magnitude <= 25 then
					ShakeCameraModule:ShakeCamera(19, 19, 0, .4)
				end

				ParticlesModule.Emit(kickFX)
				Debris:AddItem(kickFX, 3.5)
			end)

			local chargeFX
			task.delay(1.233, function()
				chargeFX = AssetsFolder.Charge:Clone()

				local Weld = Instance.new("WeldConstraint")
				Weld.Part0 = HumRP
				Weld.Parent = chargeFX

				chargeFX.CFrame = HumRP.CFrame * CFrame.new(0, 7.2479248E-5, -11.7963867, 1, 0, 0, 0, 1.00000334, 0, 0, 0, 1.00000334)
				chargeFX.Parent = workspace.Thrown

				Weld.Part1 = chargeFX
				Debris:AddItem(chargeFX, 6.25)


				task.delay(5, function()
					for _, particle in pairs(chargeFX:GetDescendants()) do
						if particle:IsA("ParticleEmitter") then
							particle.Enabled = false
						end
					end
				end)
			end)

			task.delay(1.817, function()
				triggerDaggerTrail(true)
			end)

			task.delay(1.833, function()
				ParticlesModule.Emit(chargeFX)

				if Character == LocalCharacter or (HumRP.Position - LocalCharacter:GetPivot().Position).Magnitude <= 22 then
					ShakeCameraModule:ShakeCamera(15, 15, 0, .4)
				end

				for _, particle in pairs(chargeFX:GetDescendants()) do
					if particle:IsA("ParticleEmitter") then
						particle.Enabled = false
					end
				end
			end)

			task.delay(1.850, emitDaggerStar)
			task.delay(1.883, triggerDaggerTrail, false)
			task.delay(1.900, teleportVFX)
			task.delay(2.167, triggerDaggerTrail, true)

			task.delay(2.583, function()
				local slamMesh1 = AssetsFolder.SlamMesh1:Clone()
				local slamMesh2 = AssetsFolder.SlamMesh2:Clone()
				slamMesh1.CFrame = HumRP.CFrame * CFrame.new(-0.0360717773, -1.99352455, -1.17919922, 0, 0, 1, 0, 1.00000334, 0, -1.00000334, 0, 0)
				slamMesh2.CFrame = HumRP.CFrame * CFrame.new(0.367614746, -0.150089264, 0.2578125, 1, 0, 0, 0, 1.00000334, 0, 0, 0, 1.00000334)
				slamMesh1.Transparency = 0.9
				slamMesh2.Transparency = 0.65


				local slamVFX = AssetsFolder.Slam:Clone()
				slamVFX.Parent = workspace.Thrown
				slamVFX.CFrame = HumRP.CFrame * CFrame.new(0.115539551, -2.83759117, -0.629638672, 1.00000167, 0, 0, 0, 1.00000501, 0, 0, 0, 1.00000334)

				if Character == LocalCharacter or (HumRP.Position - LocalCharacter:GetPivot().Position).Magnitude <= 25 then
					ShakeCameraModule:ShakeCamera(20, 20, 0, .3)
				end


				slamMesh1.Parent = workspace.Thrown
				slamMesh2.Parent = workspace.Thrown


				TS:Create(slamMesh1, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Transparency = 1, 
					Size = slamMesh1.Size + Vector3.new(15, 0, 15)
				}):Play()

				TS:Create(slamMesh2, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Transparency = 1, 
					Size = slamMesh2.Size + Vector3.new(5, 15, 5), 
					Position = slamMesh2.Position + Vector3.new(0, 7.5, 0)
				}):Play()

				Debris:AddItem(slamMesh1, .5)
				Debris:AddItem(slamMesh2, 1)

				ParticlesModule.Emit(slamVFX)
				Debris:AddItem(slamVFX, 4.5)
			end)

			task.delay(2.783, emitDaggerStar)
			task.delay(2.850, teleportVFX)

			task.delay(3.300, function()
				local finalVFX = AssetsFolder.Final:Clone()
				finalVFX.Parent = workspace.Thrown
				finalVFX.CFrame = HumRP.CFrame * CFrame.new(0, -2.92484283, -2.5, 1, 0, 0, 0, 1.00000668, 0, 0, 0, 1.00000668)

				if Character == LocalCharacter or (HumRP.Position - LocalCharacter:GetPivot().Position).Magnitude <= 25 then
					ShakeCameraModule:ShakeCamera(27, 27, 0, .57)
				end

				ParticlesModule.Emit(finalVFX)
				Debris:AddItem(finalVFX, 4.75)

				shared.repfire('rockCircle', {
					CF = finalVFX.CFrame * CFrame.new(0, 1, 0),
					Radius = 8,
					Parts = 6,
					Reverse = false,
					flyRocks = true,
					Circles = 4,
					RadiusMult = .50,
					RockMult = .5,
					SizeMult = .4,
					XRNG1 = 4,
					XRNG2 = 6,
					RNG1 = 4,
					RNG2 = 6,
					Sound = true
				})
			end)

		elseif Stage == 'HitVariant' then
			AssetsFolder = script.Jun.Virgule.Variant

			local EnemyCharacter: Model = Params.EChar
			local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart


			local slashContactVFX = AssetsFolder.SlashContact:Clone()
			slashContactVFX.Parent = workspace.Thrown
			slashContactVFX.CFrame = HumRP.CFrame + HumRP.CFrame.LookVector * 3
			ParticlesModule.Emit(slashContactVFX)
			Debris:AddItem(slashContactVFX, 5.5)

			if Character == LocalCharacter or (HumRP.Position - LocalCharacter:GetPivot().Position).Magnitude <= 30 then
				ShakeCameraModule:ShakeCamera(22, 22, 0, .4)
			end


			task.delay(0.117, function()
				local mainCFrame = HumRP.CFrame + HumRP.CFrame.LookVector * 3

				local slashUpVFX = AssetsFolder.SlashUp:Clone()
				slashUpVFX.Parent = workspace.Thrown
				slashUpVFX.CFrame = mainCFrame

				local groundRay = raycast(mainCFrame.Position, Vector3.new(0, -7.5, 0), MapRayParams)
				if groundRay then
					local newColor = ColorSequence.new(groundRay.Instance.Color)

					for _, Smoke in slashUpVFX:GetDescendants() do
						if Smoke:IsA("ParticleEmitter") and Smoke.Name == "Smoke" then
							Smoke.Color = newColor
						end
					end
				end

				if LocalConfigFolder.Blood.Value == false then
					for _, Blood in slashUpVFX:GetDescendants() do
						if Blood:IsA("ParticleEmitter") and Blood.Name == "Blood" then
							Blood:Destroy()
						end
					end
				end

				ParticlesModule.Emit(slashUpVFX)
				Debris:AddItem(slashUpVFX, 5.5)

				if Character == LocalCharacter or (HumRP.Position - LocalCharacter:GetPivot().Position).Magnitude <= 30 then
					ShakeCameraModule:ShakeCamera(22, 22, 0, .4)
				end
			end)

			local kunaiProjectile
			task.delay(0.650, function()
				local offset = CFrame.Angles(math.pi / 2, 0, 0)

				kunaiProjectile = AssetsFolder.KunaiProjectile:Clone()
				kunaiProjectile.CFrame = CFrame.lookAt(Character.Torso.Position, (EnemyHumRP.CFrame * offset).Position) * offset
				kunaiProjectile.Parent = workspace.Thrown

				TS:Create(kunaiProjectile, TweenInfo.new(.217, Enum.EasingStyle.Linear), {
					CFrame = EnemyHumRP.CFrame * offset
				}):Play()

				Debris:AddItem(kunaiProjectile, .417)


				local throwVFX = AssetsFolder.Throw:Clone()
				throwVFX.Parent = workspace.Thrown
				throwVFX.CFrame = (HumRP.CFrame - HumRP.CFrame.LookVector * 5.467) * CFrame.Angles(-math.pi / 21, 0, 0)
				ParticlesModule.Emit(throwVFX)
				Debris:AddItem(throwVFX, 3)
			end)

			task.delay(0.867, function()
				kunaiProjectile.Transparency = 1
				kunaiProjectile.Trail.Enabled = false

				local teleportVFX = AssetsFolder.Teleport:Clone()
				teleportVFX.Parent = workspace.Thrown
				teleportVFX.Position = (HumRP.CFrame * CFrame.new(-0.42494297, 22.4761848, -4.74950218, -0.839360118, 0.121296331, 0.529869556, -0.476863205, -0.632204473, -0.610670924, 0.260913789, -0.765248179, 0.588489115)).Position
				ParticlesModule.Emit(teleportVFX)
				Debris:AddItem(teleportVFX, 3)

				if Character == LocalCharacter then
					ShakeCameraModule:ShakeCamera(22, 22, 0, .4)
				end
			end)

			task.delay(1.283, function()
				local kickContactVFX = AssetsFolder.KickContact:Clone()
				kickContactVFX.Parent = workspace.Thrown
				kickContactVFX.CFrame = HumRP.CFrame * CFrame.new(-0.103864312, 26.3858414, -3.27058887, -0.996245623, -0.086509794, 0.0032267347, 0.0117835477, -0.172436953, -0.984950066, 0.0857642367, -0.981214285, 0.172808975)
				ParticlesModule.Emit(kickContactVFX)
				Debris:AddItem(kickContactVFX, 3)

				if Character == LocalPlayer or (HumRP.Position - LocalCharacter:GetPivot().Position).Magnitude <= 15 then
					ShakeCameraModule:ShakeCamera(22, 22, 0, .4)
				end
			end)

			task.delay(1.517, function()
				local kickVFX = AssetsFolder.Kick:Clone()
				kickVFX.Parent = workspace.Thrown
				kickVFX.CFrame = HumRP.CFrame * CFrame.new(-0.103864312, 26.3858414, -3.27058887, -0.996245623, -0.086509794, 0.0032267347, 0.0117835477, -0.172436953, -0.984950066, 0.0857642367, -0.981214285, 0.172808975)
				ParticlesModule.Emit(kickVFX)
				Debris:AddItem(kickVFX, 3)

				if Character == LocalCharacter or (HumRP.Position - LocalCharacter:GetPivot().Position).Magnitude <= 15 then
					ShakeCameraModule:ShakeCamera(22, 22, 0, .4)
				end
			end)

			task.delay(2.000, function()
				local offset = CFrame.Angles(math.pi / 2, 0, 0)

				kunaiProjectile = AssetsFolder.KunaiProjectile:Clone()
				kunaiProjectile.CFrame = CFrame.lookAt(Character.Torso.Position, (HumRP.CFrame * offset).Position) * offset
				kunaiProjectile.Parent = workspace.Thrown

				TS:Create(kunaiProjectile, TweenInfo.new(.150, Enum.EasingStyle.Linear), {
					CFrame = HumRP.CFrame * offset
				}):Play()

				Debris:AddItem(kunaiProjectile, .350)
			end)

			task.delay(2.150, function()
				kunaiProjectile.Transparency = 1
				kunaiProjectile.Trail.Enabled = false

				local teleportVFX = AssetsFolder.Teleport:Clone()
				teleportVFX.Parent = workspace.Thrown
				teleportVFX.Position = HumRP.Position
				ParticlesModule.Emit(teleportVFX)
				Debris:AddItem(teleportVFX, 3)

				if Character == LocalCharacter then
					ShakeCameraModule:ShakeCamera(22, 22, 0, .4)
				end
			end)

			task.delay(3.000, function()
				local slamVFX = AssetsFolder.Slam:Clone()
				slamVFX.Parent = workspace.Thrown
				slamVFX.CFrame = (HumRP.CFrame + HumRP.CFrame.LookVector * 3) - Vector3.new(0, 2.947, 0)

				local groundRay = raycast(slamVFX.Position, Vector3.new(0, -7.5, 0), MapRayParams)
				if groundRay then
					local rayColor = groundRay.Instance.Color
					local newColor = ColorSequence.new(Color3.fromRGB(rayColor.R * 255 - 10, rayColor.G * 255 - 10, rayColor.B * 255 - 10))

					for _, Smoke in pairs(slamVFX:GetDescendants()) do
						if Smoke:IsA("ParticleEmitter") and Smoke.Name == "Smoke" then
							Smoke.Color = newColor
						end
					end
				end

				if Character == LocalCharacter or (HumRP.Position - LocalCharacter:GetPivot().Position).Magnitude <= 25 then
					ShakeCameraModule:ShakeCamera(23, 23, 0, .6)
				end

				ParticlesModule.Emit(slamVFX)
				Debris:AddItem(slamVFX, 6)


				shared.repfire('rockCircle', {
					CF = slamVFX.CFrame * CFrame.new(0, 1, 0),
					Radius = 8,
					Parts = 4,
					Reverse = false,
					flyRocks = true,
					Circles = 2,
					RadiusMult = .70,
					RockMult = .5,
					SizeMult = .6,
					XRNG1 = 4,
					XRNG2 = 6,
					RNG1 = 4,
					RNG2 = 6,
					Sound = true
				})
			end)
		end
	end,

	['Consecutive Normal Punches'] = function(v898)
		local Character = v898.Char
		local l_HumanoidRootPart_12 = Character.HumanoidRootPart;
		local l_Bind_14 = v898.Bind;
		local v16013 = {
			Character["Left Arm"], 
			Character["Right Arm"]
		};
		local v16014 = {};
		for _, v16016 in pairs(v16013) do
			local v16017 = v16016:Clone();
			v16017.Transparency = 0;
			v16016.Transparency = 1;
			local l_Model_355 = Instance.new("Model");
			local v16019 = (Character:FindFirstChildOfClass("Shirt") or Instance.new("Shirt")):Clone();
			Instance.new("Humanoid", l_Model_355);
			v16017:ClearAllChildren();
			l_Model_355.PrimaryPart = v16017;
			v16019.Parent = l_Model_355;
			v16017.Anchored = true;
			v16017.CanCollide = false;
			v16017.Parent = l_Model_355;
			if v898.Cyborg then
				local v16020 = game.ReplicatedStorage.Resources.CyborgArms:Clone();
				v16020.Name = "Cyborgarm";
				local l_Weld_61 = Instance.new("Weld");
				l_Weld_61.Part0 = v16017;
				l_Weld_61.Part1 = v16020.Outer;
				l_Weld_61.Parent = v16020;
				v16020.Parent = l_Model_355;
				v16017.Transparency = 1;
			end;
			table.insert(v16014, l_Model_355);
		end;
		local v16022 = v240({
			SoundId = v898.Cyborg and "rbxassetid://12543824789" or v898.Hunter and "rbxassetid://12460280435" or "rbxassetid://93428657970798", 
			Parent = l_HumanoidRootPart_12, 
			PlaybackSpeed = v898.Cyborg and 3.5 or 1, 
			Volume = v898.Cyborg and 3 or 1
		});
		v16022:Play();
		local v16023 = 0;
		local v16024 = {};
		local v16025 = false;
		local v16026 = nil;
		do
			local l_v16023_0, l_v16025_0, l_v16026_0 = v16023, v16025, v16026;
			l_v16026_0 = v610(function()
				if not l_Bind_14.Parent or not Character.Parent then
					v3:Create(v16022, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Volume = 0
					}):Play();
					for _, v16031 in pairs(v16013) do
						v3:Create(v16031, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							Transparency = 0
						}):Play();
					end;
					for _, v16033 in pairs(v16024) do
						v16033:Destroy();
					end;
					l_v16026_0();
				end;
				v16022.PlaybackSpeed = 1 - (l_Bind_14:GetAttribute("Delay") or 0);
				if tick() - l_v16023_0 > l_Bind_14:GetAttribute("Delay") / 1.25 then
					local l_l_Bind_14_Attribute_0 = l_Bind_14:GetAttribute("Times");
					if not (l_l_Bind_14_Attribute_0 and l_HumanoidRootPart_12) or not l_HumanoidRootPart_12.Parent then
						v3:Create(v16022, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							Volume = 0
						}):Play();
						for _, v16036 in pairs(v16013) do
							v3:Create(v16036, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
								Transparency = 0
							}):Play();
						end;
						for _, v16038 in pairs(v16024) do
							v16038:Destroy();
						end;
						return l_v16026_0();
					else
						local l_Position_87 = l_HumanoidRootPart_12.Position;
						local _, v16041 = workspace:FindFirstChildOfClass("Camera"):WorldToScreenPoint(l_Position_87);
						if v16041 then
							for _ = 1, l_l_Bind_14_Attribute_0 or 2 do
								v16041 = v16014[math.random(1, 2)]:Clone();
								local l_PrimaryPart_70 = v16041.PrimaryPart;
								l_PrimaryPart_70.CFrame = Character[l_PrimaryPart_70.Name].CFrame;
								if v898.Cyborg then
									l_PrimaryPart_70.CFrame = l_PrimaryPart_70.CFrame - Character.PrimaryPart.CFrame.lookVector * 1;
								end;
								local v16044 = {};
								local v16045 = {};
								local function v16051(v16046)
									if v898.Cyborg then
										return ;
									else
										local l_Attachment_11 = Instance.new("Attachment");
										l_Attachment_11.Position = v16046;
										l_Attachment_11.Name = "WindTrail";
										l_Attachment_11.Parent = l_PrimaryPart_70;
										local l_Attachment_12 = Instance.new("Attachment");
										l_Attachment_12.Position = v16046 - Vector3.new(0, not v898.Hunter and 0.2 or -0.75, 0);
										l_Attachment_12.Name = "WindTrail";
										l_Attachment_12.Parent = l_PrimaryPart_70;
										table.insert(v16044, l_Attachment_11);
										table.insert(v16044, l_Attachment_12);
										local v16049 = "Trail";
										if v898.Hunter then
											v16049 = "WaterTrailEnd";
										end;
										local v16050 = l_LegacyReplication_0[v16049]:Clone();
										v16050.Attachment0 = l_Attachment_11;
										v16050.Attachment1 = l_Attachment_12;
										v16050.Enabled = true;
										if v898.Hunter then
											v16050.Lifetime = 0.25;
										end;
										v16050.Parent = l_Attachment_11;
										table.insert(v16045, v16050);
										return ;
									end;
								end;
								v16051((Vector3.new(0.5, 0.5, 0.5, 0)));
								v16051((Vector3.new(-0.5, 0.5, -0.5, 0)));
								v16051((Vector3.new(-0.5, 0.5, 0.5, 0)));
								v16051((Vector3.new(0.5, 0.5, -0.5, 0)));
								local v16052 = 0.1;
								local l_Position_88 = l_PrimaryPart_70.Position;
								local l_CFrame_81 = l_HumanoidRootPart_12.CFrame;
								local l_new_90 = CFrame.new;
								local v16056 = -(l_l_Bind_14_Attribute_0 + 1);
								local v16057 = l_l_Bind_14_Attribute_0 + 1;
								local l_v82_441 = v82;
								if not v16057 and v16056 then
									v16057 = v16056;
									v16056 = 1;
								end;
								if not v16057 and not v16056 then
									v16056 = 0;
									v16057 = 1;
								end;
								local v16059 = l_v82_441:NextNumber(v16056, v16057);
								v16057 = -l_l_Bind_14_Attribute_0;
								l_v82_441 = l_l_Bind_14_Attribute_0;
								local l_v82_442 = v82;
								if not l_v82_441 and v16057 then
									l_v82_441 = v16057;
									v16057 = 1;
								end;
								if not l_v82_441 and not v16057 then
									v16057 = 0;
									l_v82_441 = 1;
								end;
								local v16061 = l_CFrame_81 * l_new_90(v16059, l_v82_442:NextNumber(v16057, l_v82_441), 0);
								l_CFrame_81 = v16061 + l_HumanoidRootPart_12.CFrame.lookVector * 7;
								l_new_90, v16059 = v556({
									orig = v16061.p, 
									dir = (l_CFrame_81.p - v16061.p).unit * 9, 
									Ignore = {
										workspace.Thrown, 
										Character
									}
								});
								if l_new_90 then
									l_CFrame_81 = CFrame.new(v16059);
								end;
								v16056 = v16061;
								v16061 = l_CFrame_81;
								v16057 = 1;
								if l_Bind_14:GetAttribute("Boros") then
									v16057 = 2;
								end;
								if v898.Hunter then
									v16057 = 0.5;
								end;
								if v898.Cyborg then
									v16057 = 0.3;
									v16052 = 0.2;
								end;
								l_v82_442 = CFrame.new((l_Position_88 + v16061.p) / 2, l_HumanoidRootPart_12.CFrame.p);
								local l_new_91 = CFrame.new;
								local v16063 = -6;
								local v16064 = 6;
								local l_v82_443 = v82;
								if not v16064 and v16063 then
									v16064 = v16063;
									v16063 = 1;
								end;
								if not v16064 and not v16063 then
									v16063 = 0;
									v16064 = 1;
								end;
								local v16066 = l_v82_443:NextNumber(v16063, v16064) * v16057;
								v16064 = -4;
								l_v82_443 = 4;
								local l_v82_444 = v82;
								if not l_v82_443 and v16064 then
									l_v82_443 = v16064;
									v16064 = 1;
								end;
								if not l_v82_443 and not v16064 then
									v16064 = 0;
									l_v82_443 = 1;
								end;
								l_v82_441 = (l_v82_442 * l_new_91(v16066, l_v82_444:NextNumber(v16064, l_v82_443) * v16057, 0)).p;
								if l_new_90 then
									l_v82_442 = CFrame.new((l_Position_88 + v16061.p) / 2, l_HumanoidRootPart_12.CFrame.p);
									l_new_91 = CFrame.new;
									v16063 = -6;
									v16064 = 6;
									l_v82_443 = v82;
									if not v16064 and v16063 then
										v16064 = v16063;
										v16063 = 1;
									end;
									if not v16064 and not v16063 then
										v16063 = 0;
										v16064 = 1;
									end;
									v16066 = l_v82_443:NextNumber(v16063, v16064) * v16057;
									v16064 = -4;
									l_v82_443 = 4;
									l_v82_444 = v82;
									if not l_v82_443 and v16064 then
										l_v82_443 = v16064;
										v16064 = 1;
									end;
									if not l_v82_443 and not v16064 then
										v16064 = 0;
										l_v82_443 = 1;
									end;
									l_v82_441 = (l_v82_442 * l_new_91(v16066, l_v82_444:NextNumber(v16064, l_v82_443) * v16057, 0)).p;
									v16052 = 0.15;
								end;
								do
									local l_v16052_0, l_v16061_0, l_l_CFrame_81_0, l_l_v82_441_0 = v16052, v16061, l_CFrame_81, l_v82_441;
									task.spawn(function()
										local _ = tick();
										local v16073 = 0;
										local v16074 = 0;
										local v16075 = true;
										local v16076 = 0;
										local function v16085()
											if v16041.Parent ~= workspace.Thrown then
												v16041.Parent = workspace.Thrown;
											end;
											local l_CFrame_82 = l_PrimaryPart_70.CFrame;
											local l_v16076_0 = v16076;
											local l_l_Position_88_0 = l_Position_88;
											local l_l_l_v82_441_0_0 = l_l_v82_441_0;
											local l_p_2 = l_v16061_0.p;
											local v16082 = l_l_Position_88_0 + (l_l_l_v82_441_0_0 - l_l_Position_88_0) * l_v16076_0;
											local v16083 = v16082 + (l_l_l_v82_441_0_0 + (l_p_2 - l_l_l_v82_441_0_0) * l_v16076_0 - v16082) * l_v16076_0;
											l_l_Position_88_0 = v16076 + 1;
											l_l_l_v82_441_0_0 = l_Position_88;
											l_p_2 = l_l_v82_441_0;
											v16082 = l_v16061_0.p;
											local v16084 = l_l_l_v82_441_0_0 + (l_p_2 - l_l_l_v82_441_0_0) * l_l_Position_88_0;
											l_v16076_0 = v16084 + (l_p_2 + (v16082 - l_p_2) * l_l_Position_88_0 - v16084) * l_l_Position_88_0;
											l_CFrame_82 = CFrame.new(v16083, l_v16076_0) * CFrame.Angles(1.5707963267948966, 0, 0);
											v3:Create(l_PrimaryPart_70, TweenInfo.new(0.01, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
												CFrame = l_CFrame_82
											}):Play();
											v16076 = v16076 + l_v16052_0;
											if v16076 >= 1 then
												v16075 = false;
											end;
										end;
										while v16075 do
											v16073 = v16073 + v16074;
											while v16073 >= 0.016666666666666666 do
												v16085();
												v16073 = v16073 - 0.016666666666666666;
												if not v16075 then
													break;
												end;
											end;
											v16074 = game:GetService("RunService").RenderStepped:wait();
										end;
										if not l_v16025_0 then
											l_v16025_0 = true;
										end;
										local _ = l_PrimaryPart_70.CFrame;
										local v16087 = game.ReplicatedStorage.Resources.Ring:Clone();
										v16087.Size = Vector3.new(1, 0.8999999761581421, 1, 0);
										v16087.CFrame = l_l_CFrame_81_0;
										v16087.Transparency = 0.4;
										local v16088 = CFrame.new(v16087.Position, v16056.p);
										local l_Angles_39 = CFrame.Angles;
										local v16090 = 1.5707963267948966;
										local v16091 = -360;
										local v16092 = 360;
										local l_v82_445 = v82;
										if not v16092 and v16091 then
											v16092 = v16091;
											v16091 = 1;
										end;
										if not v16092 and not v16091 then
											v16091 = 0;
											v16092 = 1;
										end;
										v16087.CFrame = v16088 * l_Angles_39(v16090, math.rad((l_v82_445:NextNumber(v16091, v16092))), 0);
										if v898.Hunter then
											v16087.Color = Color3.fromRGB(84, 133, 240);
											v16087.Transparency = 0.5;
											v16087.Size = Vector3.new(1, 0.30000001192092896, 1, 0);
										end;
										if v898.Cyborg then
											v16087.Color = Color3.fromRGB(255, 92, 28);
											v16087.CFrame = v16087.CFrame * CFrame.new(0, -0.55, 0);
										end;
										v16087.Parent = workspace.Thrown;
										v3:Create(v16087, TweenInfo.new(0.125, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
											Size = Vector3.new(2.200000047683716, 0.10000000149011612, 2.200000047683716, 0), 
											Transparency = 1
										}):Play();
										game:service("Debris"):AddItem(v16087, 0.35);
										if v898.Hunter then
											for _, v16095 in pairs(v16045) do
												v16095.Enabled = false;
											end;
											for _, v16097 in pairs(v16044) do
												local l_WorldCFrame_1 = v16097.WorldCFrame;
												v16097.Parent = workspace.Terrain;
												v16097.WorldCFrame = l_WorldCFrame_1;
											end;
											task.delay(1, function()
												for _, v16100 in pairs(v16044) do
													v16100:Destroy();
												end;
												table.clear(v16044);
												table.clear(v16045);
											end);
										end;
										if v898.Cyborg then
											for _, v16102 in pairs(v16041:GetChildren()) do
												if v16102.Name == "Cyborgarm" then
													local l_Attachment_13 = v16102.Outer.Attachment;
													table.insert(v16024, l_Attachment_13);
													v16091 = l_Attachment_13.WorldCFrame;
													l_Attachment_13.Parent = workspace.Terrain;
													l_Attachment_13.WorldCFrame = v16091;
													for _, v16105 in pairs(l_Attachment_13:GetChildren()) do
														v16105.Enabled = false;
													end;
													v16092 = v16102.Outer.A0;
													table.insert(v16024, v16092);
													l_v82_445 = v16092.WorldCFrame;
													v16092.Parent = workspace.Terrain;
													v16092.WorldCFrame = l_v82_445;
													for _, v16107 in pairs(v16092:GetChildren()) do
														if v16107:IsA("Trail") then
															v16107.Enabled = false;
														end;
													end;
												end;
											end;
										end;
										v16041:Destroy();
									end);
								end;
							end;
						end;
						l_v16023_0 = tick();
					end;
				end;
			end, 85);
		end;
	end,
	
	

	fangdance = function(Params)
		local Character: Model = Params.Char
		local HumRP: BasePart = Character.HumanoidRootPart

		local Stage: string = Params.Stage
		local AssetsFolder = script.Jun.FangDance

		if Stage == 'Run' then
			for _,v in HumRP:GetChildren() do
				if v:IsA('BodyVelocity') then
					v:Destroy()
				end
			end

			local runVelocity = Instance.new("BodyVelocity")
			runVelocity.MaxForce = Vector3.new(1, 0, 1) * 450000

			local runMagnitude = Instance.new("NumberValue")
			runMagnitude.Value = 10
			runMagnitude.Parent = runVelocity


			local startTween = TS:Create(runMagnitude, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Value = 145
			})
			local endTween = TS:Create(runMagnitude, TweenInfo.new(0.65, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Value = 11
			})

			startTween.Completed:Once(function()
				task.delay(0.1, function()
					endTween:Play()
				end)
			end)


			runVelocity.Parent = HumRP
			startTween:Play()
			Debris:AddItem(runVelocity, .8)

			task.spawn(function()
				while task.wait() and runVelocity.Parent ~= nil do
					runVelocity.Velocity = HumRP.CFrame.LookVector * runMagnitude.Value
				end
			end)


			task.delay(.9, function()
				local forwardVelocity = Instance.new("BodyVelocity")
				forwardVelocity.MaxForce = Vector3.new(1, 0, 1) * 450000

				local forwardMagnitude = Instance.new("NumberValue")
				forwardMagnitude.Value = 70
				forwardMagnitude.Parent = forwardVelocity

				forwardMagnitude:GetPropertyChangedSignal("Value"):Connect(function()
					if forwardMagnitude.Value <= 4.8 then
						forwardVelocity:Destroy()
					end
				end)

				forwardVelocity.Parent = HumRP
				TS:Create(forwardMagnitude, TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
					Value = 0
				}):Play()

				task.spawn(function()
					while task.wait() and forwardVelocity.Parent ~= nil do
						forwardVelocity.Velocity = HumRP.CFrame.LookVector * forwardMagnitude.Value
					end
				end)
			end)

		elseif Stage == 'Land' then
			local groundPos = raycast(HumRP.Position, Vector3.new(0, -7.5, 0), MapRayParams)

			if groundPos then
				local landVFX = AssetsFolder.Container.Land:Clone()
				landVFX.Parent = HumRP

				local groundColor = ColorSequence.new(groundPos.Instance.Color)
				for _, particle in landVFX:GetDescendants() do
					if particle:IsA("ParticleEmitter") and particle.Name == "Smoke" then
						particle.Color = groundColor
					end
				end

				landVFX.WorldPosition = groundPos.Position
				ParticlesModule.Emit(landVFX)
				Debris:AddItem(landVFX, 4)
			end

		elseif Stage == 'Hit' then
			local EnemyCharacter: Model = Params.EChar
			local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart


			local torsoPosition = Character.Torso.Position
			local kneeGroundRay = raycast(torsoPosition, Vector3.new(0, -7.5, 0), MapRayParams)

			local kneeVFX = AssetsFolder.Container.KneeHit:Clone()
			kneeVFX.Parent = HumRP
			if kneeGroundRay then
				local newColor = ColorSequence.new(kneeGroundRay.Instance.Color)

				for _, Smoke in pairs(kneeVFX:GetDescendants()) do
					if Smoke:IsA("ParticleEmitter") and Smoke.Name == "Smoke" then
						Smoke.Color = newColor
					end
				end
			end

			if (kneeVFX.WorldPosition - LocalCharacter:GetPivot().Position).Magnitude <= 35 then
				ShakeCameraModule:ShakeCamera(24, 24, 0, .5)
			end

			ParticlesModule.Emit(kneeVFX)
			Debris:AddItem(kneeVFX, 4)


			task.delay(.667, function() -- Land
				local groundPos = raycast(Character.Torso.Position, Vector3.new(0, -7.5, 0), MapRayParams)
				if groundPos then
					local landVFX = AssetsFolder.Container.Land:Clone()
					landVFX.Parent = HumRP

					local groundColor = ColorSequence.new(groundPos.Instance.Color)
					for _, particle in landVFX:GetDescendants() do
						if particle:IsA("ParticleEmitter") and particle.Name == "Smoke" then
							particle.Color = groundColor
						end
					end

					landVFX.WorldPosition = groundPos.Position
					ParticlesModule.Emit(landVFX)
					Debris:AddItem(landVFX, 4)
				end
			end)

			task.delay(1.217, function() -- Elbow
				local enemyTorsoPosition = EnemyCharacter.Torso.Position
				local elbowGroundRay = raycast(enemyTorsoPosition, Vector3.new(0, -7.5, 0), MapRayParams)

				local elbowVFX = AssetsFolder.Container.Elbow:Clone()
				elbowVFX.Parent = EnemyHumRP
				elbowVFX.WorldPosition = Vector3.new(EnemyCharacter.Torso.Position.X, elbowVFX.WorldPosition.Y, EnemyCharacter.Torso.Position.Z)

				if elbowGroundRay then
					local newColor = ColorSequence.new(elbowGroundRay.Instance.Color)

					for _, Smoke in pairs(elbowVFX:GetDescendants()) do
						if Smoke:IsA("ParticleEmitter") and Smoke.Name == "Smoke" then
							Smoke.Color = newColor
						end
					end
				end

				if (elbowVFX.WorldPosition - LocalCharacter:GetPivot().Position).Magnitude <= 22 then
					ShakeCameraModule:ShakeCamera(13, 13, 0, .5)
				end

				ParticlesModule.Emit(elbowVFX)
				Debris:AddItem(elbowVFX, 4)
			end)

			task.delay(1.383, function() -- Elbow2
				local enemyTorsoPosition = EnemyCharacter.Torso.Position
				local elbow2GroundRay = raycast(enemyTorsoPosition, Vector3.new(0, -7.5, 0), MapRayParams)

				local elbow2VFX = AssetsFolder.Container.Elbow2:Clone()
				elbow2VFX.Parent = EnemyHumRP
				elbow2VFX.WorldPosition = Vector3.new(EnemyCharacter.Torso.Position.X, elbow2VFX.WorldPosition.Y, EnemyCharacter.Torso.Position.Z)

				if elbow2GroundRay then
					local newColor = ColorSequence.new(elbow2GroundRay.Instance.Color)

					for _, Smoke in pairs(elbow2VFX:GetDescendants()) do
						if Smoke:IsA("ParticleEmitter") and Smoke.Name == "Smoke" then
							Smoke.Color = newColor
						end
					end
				end

				if (elbow2VFX.WorldPosition - LocalCharacter:GetPivot().Position).Magnitude <= 22 then
					ShakeCameraModule:ShakeCamera(14, 14, 0, .5)
				end

				ParticlesModule.Emit(elbow2VFX)
				Debris:AddItem(elbow2VFX, 4)
			end)

			task.delay(2.650, function() -- Spin
				local spin1VFX = AssetsFolder.Container.Spin1:Clone()
				spin1VFX.Parent = Character.Torso

				task.delay(0.3, function()
					if spin1VFX.Parent ~= nil then
						for _, particle in spin1VFX:GetDescendants() do
							if particle:IsA("ParticleEmitter") then
								particle.LockedToPart = false

								task.delay(0.5, function()
									particle.LockedToPart = true
								end)
							end
						end
					end
				end)

				ParticlesModule.Emit(spin1VFX)
				Debris:AddItem(spin1VFX, 4)
			end)

			task.delay(3.250, function() -- Spin2
				local spin2VFX = AssetsFolder.Container.Spin2:Clone()
				spin2VFX.Parent = Character.Torso
				spin2VFX.WorldPosition = Vector3.new(Character.Torso.Position.X, spin2VFX.WorldPosition.Y, Character.Torso.Position.Z)

				local spin2VGroundRay = raycast(Character.Torso.Position, Vector3.new(0, -7.5, 0), MapRayParams)
				if spin2VGroundRay then
					local newColor = ColorSequence.new(spin2VGroundRay.Instance.Color)

					for _, Smoke in pairs(spin2VFX:GetDescendants()) do
						if Smoke:IsA("ParticleEmitter") and Smoke.Name == "Smoke" then
							Smoke.Color = newColor
						end
					end
				end

				ParticlesModule.Emit(spin2VFX)
				Debris:AddItem(spin2VFX, 4)
			end)

			task.delay(3.917, function() -- Afterimage
				torsoPosition = Character.Torso.Position

				local afterimageGroundRay = raycast(torsoPosition, Vector3.new(0, -7.5, 0), MapRayParams)
				local afterimageVFX = AssetsFolder.Container.KickStart:Clone()
				afterimageVFX.Parent = HumRP
				afterimageVFX.WorldPosition = Vector3.new(Character.Torso.Position.X, afterimageVFX.WorldPosition.Y, Character.Torso.Position.Z)

				if afterimageGroundRay then
					local newColor = ColorSequence.new(afterimageGroundRay.Instance.Color)

					for _, Smoke in pairs(afterimageVFX:GetDescendants()) do
						if Smoke:IsA("ParticleEmitter") and Smoke.Name == "Smoke" then
							Smoke.Color = newColor
						end
					end
				end

				if (afterimageVFX.WorldPosition - LocalCharacter:GetPivot().Position).Magnitude <= 22 then
					ShakeCameraModule:ShakeCamera(14, 14, 0, .3)
				end

				ParticlesModule.Emit(afterimageVFX)
				Debris:AddItem(afterimageVFX, 4)
			end)

			task.delay(4.217, function() -- Hit
				local enemyTorsoPosition = EnemyCharacter.Torso.Position

				local hitGroundRay = raycast(enemyTorsoPosition, Vector3.new(0, -7.5, 0))
				local hitVFX = AssetsFolder.Release:Clone()
				hitVFX.CFrame = EnemyHumRP.CFrame
				hitVFX.Parent = workspace.Thrown

				if hitGroundRay then
					local newColor = ColorSequence.new(hitGroundRay.Instance.Color)

					for _, Smoke in pairs(hitVFX:GetDescendants()) do
						if Smoke:IsA("ParticleEmitter") and Smoke.Name == "Smoke" then
							Smoke.Color = newColor
						end
					end
				end

				if (hitVFX.Position - LocalCharacter:GetPivot().Position).Magnitude <= 22 then
					ShakeCameraModule:ShakeCamera(30, 30, 0, .5)
				end

				ParticlesModule.Emit(hitVFX)
				Debris:AddItem(hitVFX, 4)
			end)
		end
	end,
	RushUltimate = function(Params) --[[ Line: 689 ]] --[[ Name: RushUltimate ]]
		local HumanoidRootPart_7_upvr = Params.Char.HumanoidRootPart
		local LinearVelocity_6 = Instance.new("LinearVelocity")
		LinearVelocity_6.Attachment0 = HumanoidRootPart_7_upvr.RootAttachment
		LinearVelocity_6.ForceLimitMode = Enum.ForceLimitMode.PerAxis
		LinearVelocity_6.MaxAxesForce = Vector3.new(1, 0, 1) * 30000
		LinearVelocity_6.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
		LinearVelocity_6.Parent = HumanoidRootPart_7_upvr
		local clone_7 = script.Okarun.Walking:Clone()
		clone_7.Parent = Params.Char
		local Weld_10 = Instance.new("Weld")
		Weld_10.Part0 = HumanoidRootPart_7_upvr
		Weld_10.Part1 = clone_7
		Weld_10.C0 = CFrame.new(0, -3, 0)
		Weld_10.Parent = clone_7
		for _, v_15 in ipairs(clone_7:GetDescendants()) do
			if v_15:IsA("ParticleEmitter") then
				v_15:Emit(v_15:GetAttribute("EmitCount"))
				v_15.Enabled = true
			end
		end
		TS:Create(LinearVelocity_6, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			VectorVelocity = Vector3.zAxis * -5;
		}):Play()
		task.wait(1.2)
		for _, v_16 in ipairs(clone_7:GetDescendants()) do
			if v_16:IsA("ParticleEmitter") then
				v_16.Enabled = false
			end
		end
		Debris:AddItem(clone_7, 2)
		TS:Create(LinearVelocity_6, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			VectorVelocity = Vector3.zAxis * -45;
		}):Play()
		task.wait(1.2)
		task.delay(0.5, function() -- Line 772
		--[[ Upvalues[6]:
			[1]: v11 (copied, readonly)
			[2]: HumanoidRootPart_7_upvr (readonly)
			[3]: l_ReplicatedStorage_0 (copied, readonly)
			[4]: arg1 (readonly)
			[5]: RunService_upvr (copied, readonly)
			[6]: Debris (copied, readonly)
		]]
			EmitRaycast(HumanoidRootPart_7_upvr, script.Okarun.FirstJump, 2, Vector3.yAxis * -5)
			task.wait(0.35)
			local clone_35 = script.Okarun.AoeSlash:Clone()
			clone_35.Parent = Params.Char
			local Weld_12 = Instance.new("Weld")
			Weld_12.Part0 = HumanoidRootPart_7_upvr
			Weld_12.Part1 = clone_35
			Weld_12.C0 = CFrame.new(0, -2.85, 0)
			Weld_12.Parent = clone_35
			for _, v_17 in ipairs(clone_35:GetDescendants()) do
				if v_17:IsA("ParticleEmitter") then
					v_17:Emit(v_17:GetAttribute("EmitCount"))
					v_17.Enabled = true
				end
			end
			task.wait(1.85)
			RNS.PreRender:connect(function() -- Line 793
			--[[ Upvalues[2]:
				[1]: v11 (copied, readonly)
				[2]: HumanoidRootPart_7_upvr (copied, readonly)
			]]
				CameraShake(5, 0.5, 0.1, {HumanoidRootPart_7_upvr, 60})
			end):Disconnect()
			for _, v_18 in ipairs(clone_35:GetDescendants()) do
				if v_18:IsA("ParticleEmitter") then
					v_18.Enabled = false
				end
			end
			Debris:AddItem(clone_35, 3)
		end)
		TS:Create(LinearVelocity_6, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			VectorVelocity = Vector3.zAxis * -60;
		}):Play()
		task.wait(2.5)
		LinearVelocity_6.VectorVelocity = Vector3.zAxis * -250
		TS:Create(LinearVelocity_6, TweenInfo.new(1.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			VectorVelocity = Vector3.zero;
		}):Play()
		Debris:AddItem(LinearVelocity_6, 1.15)
		local clone_30 = script.Okarun.YAFDFDFA:Clone()
		clone_30.Parent = Params.Char
		local Weld_4 = Instance.new("Weld")
		Weld_4.Part0 = Params.Char.Torso
		Weld_4.Part1 = clone_30
		Weld_4.Parent = clone_30
		for _, v_19_upvr in ipairs(clone_30:GetDescendants()) do
			if v_19_upvr:IsA("ParticleEmitter") then
				v_19_upvr:Emit(v_19_upvr:GetAttribute("EmitCount"))
				task.delay(1, function() -- Line 831
				--[[ Upvalues[1]:
					[1]: v_19_upvr (readonly)
				]]
					v_19_upvr.Enabled = false
				end)
			end
		end
		Debris:AddItem(clone_30, 2)
		EmitRaycast(HumanoidRootPart_7_upvr, script.Okarun.FinalJump, 2, Vector3.yAxis * -5)
		CameraShake(5, 1.5, 0.5, {HumanoidRootPart_7_upvr, 60})
		task.wait(0.8)
		local var10_result1 = l_Raycast_0(HumanoidRootPart_7_upvr.Position, Vector3.yAxis * -50)
		if var10_result1 then
			CameraShake(5, 1.5, 2, {HumanoidRootPart_7_upvr, 60})
			local clone_24 = script.Okarun.FinisherSlash:Clone()
			clone_24.Parent = workspace.Effects
			clone_24:PivotTo(CFrame.new(var10_result1.Position, var10_result1.Position + HumanoidRootPart_7_upvr.CFrame.LookVector))
			for _, v_20 in ipairs(clone_24:GetDescendants()) do
				if v_20:IsA("ParticleEmitter") then
					v_20:Emit(v_20:GetAttribute("EmitCount"))
				end
			end
			Debris:AddItem(clone_24, 3)
		end
	end,
	["20BLOWCOUNTER"] = function(Params) --[[ Line: 925 ]]
		local l_HumanoidRootPart_10 = Params.Char.HumanoidRootPart;
		local l_Players_PlayerFromCharacter_2 = Players:GetPlayerFromCharacter(Params.Char);
		local _ = Params.Char.HumanoidRootPart;
		local l_Players_PlayerFromCharacter_3 = Players:GetPlayerFromCharacter(Params.Enemy);
		CameraShake(5, 1, 2, {
			Params.Char.Head, 
			50
		});
		task.delay(1.65, function() --[[ Line: 934 ]]
			CameraShake(5, 0.3, 2, {
				l_HumanoidRootPart_10, 
				50
			});
			Emit(l_HumanoidRootPart_10, script.Okarun["StrongPunchy (Emit)1"], 3);
			local v239 = script.Okarun["PreImpactS (Emit)"]:Clone();
			v239.Parent = workspace.Effects;
			v239.CFrame = l_HumanoidRootPart_10.CFrame;
			for _, v241 in ipairs(v239:GetDescendants()) do
				if v241:IsA("ParticleEmitter") then
					v241.Enabled = true;
					task.delay(0.3, function() --[[ Line: 946 ]]
						v241.Enabled = false;
					end);
				end;
			end;
			Debris:AddItem(v239, 2);
		end);
		task.delay(2, function() --[[ Line: 953 ]]
			CameraShake(5, 1, 2, {
				l_HumanoidRootPart_10, 
				50
			});
			Emit(l_HumanoidRootPart_10, script.Okarun["StrongPunchy (Emit)2"], 3);
		end);
		task.delay(3, function() --[[ Line: 957 ]]
			CameraShake(5, 1, 0.5, {
				l_HumanoidRootPart_10, 
				50
			});
			Emit(l_HumanoidRootPart_10, script.Okarun["PreUppercut (Emit)"], 3, CFrame.new(Vector3.yAxis * -3));
			local v242 = script.Okarun["PreUppercutFlash (Enabled)"]:Clone();
			v242.Parent = workspace.Effects;
			v242.CFrame = l_HumanoidRootPart_10.CFrame * CFrame.new(Vector3.yAxis * -3);
			for _, v244 in ipairs(v242:GetDescendants()) do
				if v244:IsA("ParticleEmitter") then
					v244.Enabled = true;
					task.delay(0.8, function() --[[ Line: 969 ]]
						v244.Enabled = false;
					end);
				end;
			end;
			Debris:AddItem(v242, 2);
		end);
		task.delay(3.85, function() --[[ Line: 976 ]]
			Emit(l_HumanoidRootPart_10, script.Okarun["UpperPunchImpact (Emit) Start"], 3, CFrame.new(Vector3.zAxis * -2));
			Emit(l_HumanoidRootPart_10, script.Okarun["UpperPunch (Emit)"], 3, CFrame.new(Vector3.zAxis * -2));
			CameraShake(5, 1, 0.5, {
				l_HumanoidRootPart_10, 
				50
			});
			task.wait(0.5);
			Emit(l_HumanoidRootPart_10, script.Okarun["UpperPunch (Emit)"], 3, CFrame.new(Vector3.zAxis * -2));
			CameraShake(5, 1, 0.5, {
				l_HumanoidRootPart_10, 
				50
			});
			task.wait(0.4);
			Emit(l_HumanoidRootPart_10, script.Okarun["UpperPunch (Emit)"], 3, CFrame.new(Vector3.zAxis * -2));
			CameraShake(5, 1, 0.5, {
				l_HumanoidRootPart_10, 
				50
			});
			task.wait(0.4);
			Emit(l_HumanoidRootPart_10, script.Okarun["UpperPunch (Emit)"], 3, CFrame.new(Vector3.zAxis * -2));
			CameraShake(5, 1, 0.5, {
				l_HumanoidRootPart_10, 
				50
			});
			task.wait(0.3);
			Emit(l_HumanoidRootPart_10, script.Okarun["UpperPunch (Emit)"], 3, CFrame.new(Vector3.zAxis * -2));
			CameraShake(5, 1, 0.5, {
				l_HumanoidRootPart_10, 
				50
			});
			task.wait(0.2);
			for _ = 1, 15 do
				Emit(l_HumanoidRootPart_10, script.Okarun["UpperPunch (Emit)"], 3, CFrame.new(Vector3.zAxis * -2));
				CameraShake(5, 1, 0.5, {
					l_HumanoidRootPart_10, 
					50
				});
				task.wait(0.2);
			end;
		end);
		task.delay(7.65, function() --[[ Line: 1010 ]]
			if Players.LocalPlayer == l_Players_PlayerFromCharacter_2 or Players.LocalPlayer == l_Players_PlayerFromCharacter_3 then
				fieldOfView(true, 0, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
			end;
		end);
		task.delay(8.65, function() --[[ Line: 1015 ]]
			Emit(l_HumanoidRootPart_10, script.Okarun["PreFinisherUpper (Emit)"], 3, CFrame.new(Vector3.zAxis * -2));
			CameraShake(5, 1.5, 1.5, {
				l_HumanoidRootPart_10, 
				50
			});

			if Players.LocalPlayer == l_Players_PlayerFromCharacter_2 or Players.LocalPlayer == l_Players_PlayerFromCharacter_3 then
				shared.ActivateiFrames('20 Blow Counter', nil, 'Okarun')
				--		local v246 = script.Okarun.ImpactFrame:Clone();
				--		v246.Parent = Players.LocalPlayer.PlayerGui;
				--		local v247 = 0;
				--		local v248 = tick();
				--		local v249 = nil;
				--		do
				--			local l_v247_0, l_v248_0, l_v249_0 = v247, v248, v249;
				--			local _ = function(_) --[[ Line: 1029 ]] --[[ Name: UpdateWarper ]]
				--				if tick() - l_v248_0 >= 0.041666666666666664 then
				--					if l_v247_0 >= 24 then
				--						v246:Destroy();
				--						l_v249_0:Disconnect();
				--						return;
				--					else
				--						l_v247_0 = l_v247_0 + 1;
				--						v246[l_v247_0].Visible = true;
				--						l_v248_0 = tick();
				--					end;
				--				end;
				--			end;
				--			l_v249_0 = game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 1050 ]]
				--				if tick() - l_v248_0 >= 0.041666666666666664 then
				--					if l_v247_0 >= 24 then
				--						v246:Destroy();
				--						l_v249_0:Disconnect();
				--						return;
				--					else
				--						l_v247_0 = l_v247_0 + 1;
				--						v246[l_v247_0].Visible = true;
				--						l_v248_0 = tick();
				--					end;
				--				end;
				--			end);
				--		end;
			end;
		end);
		task.delay(9.6, function() --[[ Line: 1055 ]]
			if Players.LocalPlayer == l_Players_PlayerFromCharacter_2 or Players.LocalPlayer == l_Players_PlayerFromCharacter_3 then
				fieldOfView(true, 70, 0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
			end;
			Emit(l_HumanoidRootPart_10, script.Okarun["FinisherUpper (Emit)"], 3, CFrame.new(Vector3.zAxis * -2));
			CameraShake(5, 1.5, 5, {
				l_HumanoidRootPart_10, 
				50
			});
		end);
	end;
	EarthboundStrike = function(Params) --[[ Line: 752 ]] --[[ Name: EarthboundStrike ]]
		local l_HumanoidRootPart_6 = Params.Char.HumanoidRootPart;
		task.wait(0.3);
		local l_LinearVelocity_1 = Instance.new("LinearVelocity");
		l_LinearVelocity_1.Attachment0 = l_HumanoidRootPart_6.RootAttachment;
		l_LinearVelocity_1.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
		l_LinearVelocity_1.MaxAxesForce = Vector3.new(1, 0, 1, 0) * 30000;
		l_LinearVelocity_1.RelativeTo = Enum.ActuatorRelativeTo.Attachment0;
		l_LinearVelocity_1.Parent = l_HumanoidRootPart_6;
		l_LinearVelocity_1.VectorVelocity = Vector3.zAxis * -150;
		TS:Create(l_LinearVelocity_1, TweenInfo.new(1.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			VectorVelocity = Vector3.zero
		}):Play();
		task.wait(0.9);
		l_LinearVelocity_1:Destroy();
		task.wait(0.15);
		CameraShake(5, 1.5, 2, {
			l_HumanoidRootPart_6, 
			60
		});
		local v205 = l_Raycast_0(l_HumanoidRootPart_6.Position, Vector3.zAxis * -4 + Vector3.yAxis * -15);
		if v205 then
			local v206 = script.Okarun.S3.Smoke:Clone();
			v206.Parent = workspace.Effects;
			v206.Anchored = true;
			v206.CFrame = CFrame.new(v205.Position, v205.Position + v205.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0);
			Debris:AddItem(v206, 2);
			--l_Sound_0:play(script.Okarun.eSlam, v206);
			for _, v208 in v206:GetDescendants() do
				if v208:IsA("ParticleEmitter") then
					v208:Emit(v208:GetAttribute("EmitCount"));
				end;
			end;
		end;
	end;
	EarthboundStrikeHit = function(Params) --[[ Line: 752 ]] --[[ Name: EarthboundStrike ]]
		local l_HumanoidRootPart_6 = Params.Char.HumanoidRootPart;
		Emit(l_HumanoidRootPart_6, script.Okarun.S3.Hit, 3, CFrame.Angles(0.7853981633974483, 0, 0));
	end;
	TackleBlitzStartup = function(Params : any)
		local l_HumanoidRootPart_5 = Params.Char.HumanoidRootPart;
		local l_LinearVelocity_0 = Instance.new("LinearVelocity");
		l_LinearVelocity_0.Attachment0 = l_HumanoidRootPart_5.RootAttachment;
		l_LinearVelocity_0.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
		l_LinearVelocity_0.MaxAxesForce = Vector3.new(1, 0, 1, 0) * 30000;
		l_LinearVelocity_0.RelativeTo = Enum.ActuatorRelativeTo.Attachment0;
		l_LinearVelocity_0.Parent = l_HumanoidRootPart_5;

		task.spawn(function()
			RockFlakes(l_HumanoidRootPart_5,0.6,0.55)
		end)


		TS:Create(l_LinearVelocity_0, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			VectorVelocity = Vector3.zAxis * -60
		}):Play();
		task.delay(1,function()
			if l_LinearVelocity_0.Parent then
				TS:Create(l_LinearVelocity_0, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					VectorVelocity = Vector3.zero
				}):Play();
			end
		end)

		local r = game:GetService('CollectionService'):GetInstanceRemovedSignal('TackleLinear'):Connect(function(ins)
			if ins == Params.Char then
				l_LinearVelocity_0:Destroy()
			end
		end)
		l_LinearVelocity_0.Destroying:Once(function()
			r:Disconnect()
		end)
	end,
	LinearVelocity = function(Params : any) --[[ Line: 1260 ]] --[[ Name: LinearVelocity ]]
		for _, v311 in ipairs(Params.Char:GetDescendants()) do
			if v311:IsA("LinearVelocity") then
				v311:Destroy();
			end;
		end;
		local l_LinearVelocity_3 = Instance.new("LinearVelocity");
		l_LinearVelocity_3.Attachment0 = Params.Char.RootAttachment;
		l_LinearVelocity_3.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
		l_LinearVelocity_3.MaxAxesForce = Params.MaxAxesForce or Vector3.new(1, 0, 1, 0) * 30000;
		l_LinearVelocity_3.RelativeTo = Enum.ActuatorRelativeTo.Attachment0;
		l_LinearVelocity_3.VectorVelocity = Params.Velocity;
		l_LinearVelocity_3.Parent = Params.Char;
		if Params.TweenInfo and Params.Props then
			TS:Create(l_LinearVelocity_3, TweenInfo.new(table.unpack(Params.TweenInfo)), Params.Props):Play();
		end;
		Debris:AddItem(l_LinearVelocity_3, Params.Time);
		return l_LinearVelocity_3;
	end;
	TackleBlitzHit = function(character : Model,enemy : Model)
		local l_HumanoidRootPart_5 = character.HumanoidRootPart;
		local l_HumanoidRootPart_6 = enemy.HumanoidRootPart;

		CameraShake(5, 0.5, 1.5, {l_HumanoidRootPart_5, 50})
		task.delay(0.15, function()

			local clone_3 = script.Okarun.TorsoEffect:Clone()
			clone_3.Parent = workspace.Effects
			local Weld_16 = Instance.new("Weld")
			Weld_16.Part0 = character.Torso
			Weld_16.Part1 = clone_3
			Weld_16.Parent = clone_3
			for _, v_38 in ipairs(clone_3:GetDescendants()) do
				if v_38:IsA("ParticleEmitter") then
					v_38.Enabled = true
				end
			end
			task.wait(0.55)
			for _, v_39 in ipairs(clone_3:GetDescendants()) do
				if v_39:IsA("ParticleEmitter") then
					v_39.Enabled = false
				end
			end
			task.delay(2, clone_3.Destroy, clone_3)
		end)
		task.delay(1.15, function() 

			CameraShake(5, 0.5, 1.5, {l_HumanoidRootPart_5, 50})
			Emit(l_HumanoidRootPart_5, script.Okarun.SlideCut, 3)
		end)

	end,
	wolffangflash = function(Params)
		local Character: Model = Params.Char
		local HumRP: BasePart
		if Character then
			HumRP = Character.HumanoidRootPart
		end

		local Stage = Params.Stage
		local AssetsFolder = script.Jun.WolfFangFlash

		if Stage == 'Startup' then
			task.delay(.317, function()
				for _, bv in HumRP:GetChildren() do
					if bv:IsA("BodyVelocity") then
						bv:Destroy()
					end
				end

				local walkBackVelocity = Instance.new("BodyVelocity")
				walkBackVelocity.MaxForce = Vector3.new(1, 0, 1) * 75000

				local velocityMagnitude = Instance.new("NumberValue")
				velocityMagnitude.Value = 132
				velocityMagnitude.Parent = walkBackVelocity
				velocityMagnitude:GetPropertyChangedSignal("Value"):Connect(function()
					if velocityMagnitude.Value <= 3 and walkBackVelocity.Parent ~= nil then
						walkBackVelocity:Destroy()
					end
				end)

				walkBackVelocity.Parent = HumRP
				TS:Create(velocityMagnitude, TweenInfo.new(.9, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
					Value = 0
				}):Play()
				Debris:AddItem(walkBackVelocity, .9)

				task.spawn(function()
					while walkBackVelocity.Parent ~= nil do
						walkBackVelocity.Velocity = -HumRP.CFrame.LookVector * velocityMagnitude.Value

						task.wait()
					end
				end)


				local backflipVFX = AssetsFolder.Backflip:Clone()
				backflipVFX.CFrame = HumRP.CFrame
				backflipVFX.Parent = workspace.Thrown

				local groundRay = raycast(backflipVFX.Position, Vector3.new(0, -7.5, 0), MapRayParams)
				if groundRay then
					local newColorSequence = ColorSequence.new(groundRay.Instance.Color)
					for _, Smoke in backflipVFX:GetDescendants() do
						if Smoke:IsA("ParticleEmitter") and Smoke.Name == "Smoke" then
							Smoke.Color = newColorSequence
						end
					end
				end

				ParticlesModule.Emit(backflipVFX)
				Debris:AddItem(backflipVFX, 3.5)
			end)

		elseif Stage == 'Kick' then
			local kickVFX = AssetsFolder.KickedUp:Clone()
			kickVFX.CFrame = HumRP.CFrame
			kickVFX.Parent = workspace.Thrown
			ParticlesModule.Emit(kickVFX)
			Debris:AddItem(kickVFX, 3.5)

		elseif Stage == 'Grab' then
			local teleportVFX = AssetsFolder.Teleport:Clone()
			teleportVFX.CFrame = CFrame.new(Params.Old, Params.New)
			teleportVFX.Parent = workspace.Thrown

			local grounRay = raycast(teleportVFX.Position, Vector3.new(0, -7.5, 0), MapRayParams)
			if grounRay then
				local newColorSequence = ColorSequence.new(grounRay.Instance.Color)
				for _, Smoke in pairs(teleportVFX:GetDescendants()) do
					if Smoke:IsA("ParticleEmitter") and Smoke.Name == "Smoke" then
						Smoke.Color = newColorSequence
					end
				end
			end

			ParticlesModule.Emit(teleportVFX)
			Debris:AddItem(teleportVFX, 3)

		elseif Stage == 'Hit' then
			local EnemyCharacter: Model = Params.EChar
			local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

			for _, bv in HumRP:GetChildren() do
				if bv:IsA("BodyVelocity") then
					bv:Destroy()
				end
			end

			local walkBackVelocity = Instance.new("BodyVelocity")
			walkBackVelocity.MaxForce = Vector3.new(1, 0, 1) * 75000

			local velocityMagnitude = Instance.new("NumberValue")
			velocityMagnitude.Value = 203
			velocityMagnitude.Parent = walkBackVelocity
			velocityMagnitude:GetPropertyChangedSignal("Value"):Connect(function()
				if velocityMagnitude.Value <= 3 and walkBackVelocity.Parent ~= nil then
					walkBackVelocity:Destroy()
				end
			end)

			walkBackVelocity.Parent = HumRP
			TS:Create(velocityMagnitude, TweenInfo.new(.9, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
				Value = 0
			}):Play()
			Debris:AddItem(walkBackVelocity, .9)

			task.spawn(function()
				while walkBackVelocity.Parent ~= nil do
					walkBackVelocity.Velocity = HumRP.CFrame.LookVector * velocityMagnitude.Value

					task.wait()
				end
			end)


			local grabVFX = AssetsFolder.GrabInitiate:Clone()
			grabVFX.CFrame = EnemyHumRP.CFrame
			grabVFX.Parent = workspace.Thrown
			if (EnemyHumRP.Position - LocalCharacter.HumanoidRootPart.Position).Magnitude <= 20 then
				ShakeCameraModule:ShakeCamera(18, 18, 0, .3)
			end

			local groundRay = raycast(grabVFX.Position, Vector3.new(0, -7.5, 0), MapRayParams)
			if groundRay then
				local newColorSequence = ColorSequence.new(groundRay.Instance.Color)
				for _, Smoke in pairs(grabVFX:GetDescendants()) do
					if Smoke:IsA("ParticleEmitter") and Smoke.Name == "Smoke" then
						Smoke.Color = newColorSequence
					end
				end
			end

			ParticlesModule.Emit(grabVFX)
			Debris:AddItem(grabVFX, 3.5)


			task.delay(.317 + Params.ExtraTime, function()
				local punchVFX = AssetsFolder.Punch:Clone()
				punchVFX.CFrame = HumRP.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, rad(180), 0)
				punchVFX.Parent = workspace.Thrown
				if (EnemyHumRP.Position - LocalCharacter.HumanoidRootPart.Position).Magnitude <= 15 then
					ShakeCameraModule:ShakeCamera(25, 25, 0, .4)
				end

				local punchGroundRay = raycast(punchVFX.Position, Vector3.new(0, -7.5, 0), MapRayParams)
				if punchGroundRay then
					local newColorSequence = ColorSequence.new(punchGroundRay.Instance.Color)
					for _, Smoke in punchVFX:GetDescendants() do
						if Smoke:IsA("ParticleEmitter") and Smoke.Name == "Smoke" then
							Smoke.Color = newColorSequence
						end
					end
				end

				ParticlesModule.Emit(punchVFX)
				Debris:AddItem(punchVFX, 3.5)
			end)

		end
	end,

	glimpseop = function(Params)
		local Character: Model = Params.Char
		local HumRP: BasePart
		if Character then
			HumRP = Character.HumanoidRootPart
		end

		local Stage = Params.Stage
		local AssetsFolder = script.Jun.Glimpse

		if Stage == 'GutPunch' then
			local VFX = AssetsFolder.GutPunch:Clone()
			VFX.CFrame = Params.Part.CFrame
			VFX.Parent = workspace.Thrown
			ParticlesModule.Emit(VFX)
			Debris:AddItem(VFX, 3)

		elseif Stage == 'GutPunch1' then
			local VFX = AssetsFolder.GutPunch1:Clone()
			VFX.CFrame = Params.Part.CFrame
			VFX.Parent = workspace.Thrown
			ParticlesModule.Emit(VFX)
			Debris:AddItem(VFX, 3)

		elseif Stage == 'Run' then
			local runVFX = AssetsFolder.Run:Clone()
			local vfxWeld = Instance.new("WeldConstraint")
			vfxWeld.Parent = runVFX
			vfxWeld.Part0 = HumRP
			runVFX.CFrame = HumRP.CFrame
			vfxWeld.Part1 = runVFX
			runVFX.Parent = workspace.Thrown


			local runVelocity = Instance.new("BodyVelocity")
			runVelocity.MaxForce = Vector3.new(1, 0, 1) * 450000
			local runMagnitude = Instance.new("NumberValue")
			runMagnitude.Value = 10
			runMagnitude.Parent = runVelocity


			local startRunTween = TS:Create(runMagnitude, TweenInfo.new(0.03, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Value = 95
			})

			startRunTween.Completed:Once(function()
				task.delay(0.1, function()
					TS:Create(runMagnitude, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
						Value = 6
					}):Play()
				end)
			end)

			Debris:AddItem(runVFX, 1.5)
			Debris:AddItem(runVelocity, 0.63)

			task.delay(.63, function()
				for _, VFX: ParticleEmitter? in runVFX:GetDescendants() do
					if VFX:IsA("ParticleEmitter") then
						VFX.Enabled = false
					end
				end

				runVFX.Anchored = true
				vfxWeld:Destroy()
			end)


			runVelocity.Parent = HumRP
			startRunTween:Play()
			Debris:AddItem(runVelocity, .85)


			task.spawn(function()
				while runVelocity ~= nil and runVelocity.Parent ~= nil do
					runVelocity.Velocity = HumRP.CFrame.LookVector * runMagnitude.Value

					task.wait()
				end
			end)

		elseif Stage == 'Grab' then
			local EnemyCharacter: Model = Params.EChar
			local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

			local LegAura = {}
			for _, AuraEmitter: ParticleEmitter in AssetsFolder.LegAura:GetChildren() do
				local AuraClone = AuraEmitter:Clone()
				table.insert(LegAura, AuraClone)
				AuraClone.Parent = Character["Right Leg"]
			end

			local GrabVFX = AssetsFolder.GrabInitiate:Clone()
			GrabVFX.CFrame = EnemyCharacter.Head.CFrame
			GrabVFX.Parent = workspace.Thrown
			if (LocalCharacter.HumanoidRootPart.Position - HumRP.Position).Magnitude <= 20 then
				ShakeCameraModule:ShakeCamera(15, 15, 0, .4)
			end
			ParticlesModule.Emit(GrabVFX)
			Debris:AddItem(GrabVFX, 3)

			task.delay(1.15, function()
				for _, AuraEmitter: ParticleEmitter in LegAura do
					if not AuraEmitter:IsA('ParticleEmitter') then continue end

					AuraEmitter.Enabled = false
					Debris:AddItem(AuraEmitter, 1.5)
				end
			end)


			local knockVelocity = Instance.new("BodyVelocity")
			knockVelocity.MaxForce = Vector3.new(1, 0, 1) * 90000

			local velocityMagnitude = Instance.new("NumberValue")
			velocityMagnitude.Value = 140
			velocityMagnitude.Parent = knockVelocity

			velocityMagnitude:GetPropertyChangedSignal("Value"):Connect(function()
				if velocityMagnitude.Value <= 5 and knockVelocity ~= nil and knockVelocity.Parent ~= nil then
					knockVelocity:Destroy()
				end
			end)

			Debris:AddItem(knockVelocity, 1.15)
			knockVelocity.Parent = HumRP
			task.spawn(function()
				while knockVelocity ~= nil and knockVelocity.Parent ~= nil do
					knockVelocity.Velocity = HumRP.CFrame.LookVector * velocityMagnitude.Value
					task.wait()
				end
			end)
			TS:Create(velocityMagnitude, TweenInfo.new(1.15, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
				Value = 0
			}):Play()

		elseif Stage == 'Kick' then
			local kickVFX = AssetsFolder.Kick:Clone();
			kickVFX.CFrame = Params.MainCF * CFrame.Angles(-0.401264265, math.pi, 0);
			kickVFX.Parent = workspace.Thrown

			if (kickVFX.Position - LocalCharacter.HumanoidRootPart.Position).Magnitude <= 13 then
				ShakeCameraModule:ShakeCamera(31, 31, 0, .4)
			end

			local groundRay = raycast(kickVFX.Position, Vector3.new(-7.5), MapRayParams)
			if groundRay then
				local newColorSequence = ColorSequence.new(groundRay.Instance.Color)
				for _, Smoke: ParticleEmitter in pairs(kickVFX:GetDescendants()) do
					if Smoke:IsA("ParticleEmitter") and Smoke.Name == "Smoke" then
						Smoke.Color = newColorSequence
					end
				end
			end
			ParticlesModule.Emit(kickVFX)
			Debris:AddItem(kickVFX, 3)

		elseif Stage == 'Finisher' then
			local EnemyCharacter: Model = Params.EChar
			local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

			local function fadeInBeam(beamsContainer, fadeInTime)
				for _, Beam: Beam? in pairs(beamsContainer:GetDescendants()) do
					if Beam:IsA("Beam") then
						Beam.Enabled = true

						local goalBrightness = Beam.Brightness
						local goalLightEmission = Beam.LightEmission

						Beam.Brightness = 0
						Beam.LightEmission = 1

						local goalProperties = {
							LightEmission = goalLightEmission, 
							Brightness = goalBrightness
						}


						TS:Create(Beam, TweenInfo.new(fadeInTime), goalProperties):Play()
					elseif Beam:IsA("Trail") then
						Beam.Enabled = true
					end
				end
			end

			local function tweenBeamSpeed(beamsContainer, goalSpeed, easingDirection)
				for _, Beam: Beam in beamsContainer:GetDescendants() do
					if Beam:IsA("Beam") then
						TS:Create(Beam, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection[easingDirection]), {
							TextureSpeed = goalSpeed
						}):Play()
					end
				end
			end

			local function dashForward(velocity)
				for _, bvel: BodyVelocity? in HumRP:GetChildren() do
					if bvel:IsA("BodyVelocity") then
						bvel:Destroy()
					end
				end

				local forwardVelocity = Instance.new("BodyVelocity")
				forwardVelocity.MaxForce = Vector3.new(1, 0, 1) * 86000
				forwardVelocity.Parent = HumRP

				local velocityMagnitude = Instance.new("NumberValue")
				velocityMagnitude.Value = velocity
				velocityMagnitude.Parent = forwardVelocity
				velocityMagnitude:GetPropertyChangedSignal("Value"):Connect(function()
					if velocityMagnitude.Value <= 5 then
						forwardVelocity:Destroy()
					end
				end)

				task.spawn(function()
					while task.wait() and forwardVelocity.Parent ~= nil do
						forwardVelocity.Velocity = HumRP.CFrame.LookVector * velocityMagnitude.Value
					end
				end)
				TS:Create(velocityMagnitude, TweenInfo.new(1.15, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
					Value = 0
				}):Play()
				Debris:AddItem(forwardVelocity, 1.15)
				Debris:AddItem(velocityMagnitude, 1.15)
			end

			task.delay(0.317, function()
				local hit1VFX = AssetsFolder.Finisher.Hit1:Clone()
				hit1VFX.CFrame = EnemyHumRP.CFrame

				local groundRay = raycast(hit1VFX.Position, Vector3.new(-7.5), MapRayParams)
				if groundRay then
					local newColorSequence = ColorSequence.new(groundRay.Instance.Color)
					for _, Smoke: ParticleEmitter in pairs(hit1VFX:GetDescendants()) do
						if Smoke:IsA("ParticleEmitter") and Smoke.Name == "Smoke" then
							Smoke.Color = newColorSequence
						end
					end
				end

				if LocalConfigFolder.Blood.Value == false then
					for _, bloodVFX: ParticleEmitter in pairs(hit1VFX:GetDescendants()) do
						if bloodVFX:IsA("ParticleEmitter") and bloodVFX.Name == "Blood" then
							bloodVFX:Destroy()
						end
					end
				end

				hit1VFX.Parent = workspace.Thrown
				if (hit1VFX.Position - LocalCharacter.HumanoidRootPart.Position).Magnitude <= 29 then
					ShakeCameraModule:ShakeCamera(13.5, 13.5, 0, .4)
				end

				ParticlesModule.Emit(hit1VFX)
				Debris:AddItem(hit1VFX, 4)


				dashForward(70)
			end)
			task.delay(0.767, function()
				local hit2VFX = AssetsFolder.Finisher.Hit2:Clone()
				hit2VFX.CFrame = EnemyHumRP.CFrame

				local groundRay = raycast(hit2VFX.Position, Vector3.new(-7.5), MapRayParams)
				if groundRay then
					local newColorSequence = ColorSequence.new(groundRay.Instance.Color)
					for _, Smoke: ParticleEmitter in pairs(hit2VFX:GetDescendants()) do
						if Smoke:IsA("ParticleEmitter") and Smoke.Name == "Smoke" then
							Smoke.Color = newColorSequence
						end
					end
				end

				if LocalConfigFolder.Blood.Value == false then
					for _, bloodVFX: ParticleEmitter in pairs(hit2VFX:GetDescendants()) do
						if bloodVFX:IsA("ParticleEmitter") and bloodVFX.Name == "Blood" then
							bloodVFX:Destroy()
						end
					end
				end

				hit2VFX.Parent = workspace.Thrown
				if (hit2VFX.Position - LocalCharacter.HumanoidRootPart.Position).Magnitude <= 29 then
					ShakeCameraModule:ShakeCamera(13.5, 13.5, 0, .4)
				end

				ParticlesModule.Emit(hit2VFX)
				Debris:AddItem(hit2VFX, 4)


				dashForward(70)
			end)
			task.delay(1.400, function()
				local slash1VFX = AssetsFolder.Finisher.Slash1:Clone()
				slash1VFX.CFrame = EnemyCharacter.HumanoidRootPart.CFrame

				local groundRay = raycast(slash1VFX.Position, Vector3.new(0, -7.5, 0), MapRayParams)
				if groundRay then
					local newColorSequence = ColorSequence.new(groundRay.Instance.Color)
					for _, Smoke: ParticleEmitter in slash1VFX:GetDescendants() do
						if Smoke:IsA("ParticleEmitter") and Smoke.Name == "Smoke" then
							Smoke.Color = newColorSequence
						end
					end
				end

				if LocalConfigFolder.Blood.Value == false then
					for _, BloodVFX: ParticleEmitter in slash1VFX:GetDescendants() do
						if BloodVFX:IsA("ParticleEmitter") and BloodVFX.Name == "Blood" then
							BloodVFX:Destroy()
						end
					end
				end

				slash1VFX.Parent = workspace.Thrown
				if (slash1VFX.Position - LocalCharacter.HumanoidRootPart.Position).Magnitude <= 37 then
					ShakeCameraModule:ShakeCamera(17, 17, 0, .4)
				end
				ParticlesModule.Emit(slash1VFX)
				Debris:AddItem(slash1VFX, 4)


				local cutArmContainer = Instance.new("Model")
				Instance.new("Humanoid").Parent = cutArmContainer
				cutArmContainer.Name = "ArmClone"
				for _, eCharClothes in EnemyCharacter:GetChildren() do
					if eCharClothes:IsA("Shirt") then
						eCharClothes:Clone().Parent = cutArmContainer
					end
				end

				local cutArmClone = EnemyCharacter["Left Arm"]:Clone()
				cutArmClone.CollisionGroup = "Flying Rocks"
				local cutArmTween = TS:Create(cutArmClone, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					Transparency = 1, 
					Size = cutArmClone.Size / 2
				})

				cutArmTween.Completed:Connect(function()
					if cutArmContainer ~= nil and cutArmContainer.Parent ~= nil then
						cutArmContainer:Destroy()
					end
				end)
				cutArmClone.Parent = cutArmContainer
				EnemyCharacter["Left Arm"].Transparency = 1
				cutArmContainer.Parent = workspace.Thrown
				cutArmClone.CanCollide = true
				cutArmClone:ApplyImpulse(-EnemyHumRP.CFrame.RightVector * 65 + Vector3.new(0, 110, 0));
				cutArmClone:ApplyAngularImpulse(Vector3.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10)));

				task.delay(4, function()
					if cutArmTween ~= nil then
						cutArmTween:Play()
					end
				end)

				dashForward(80)
			end)
			task.delay(1.783, function()
				local slash2VFX = AssetsFolder.Finisher.Slash2:Clone()
				slash2VFX.CFrame = EnemyCharacter.HumanoidRootPart.CFrame

				local groundRay = raycast(slash2VFX.Position, Vector3.new(0, -7.5, 0), MapRayParams)
				if groundRay then
					local newColorSequence = ColorSequence.new(groundRay.Instance.Color)
					for _, Smoke: ParticleEmitter in slash2VFX:GetDescendants() do
						if Smoke:IsA("ParticleEmitter") and Smoke.Name == "Smoke" then
							Smoke.Color = newColorSequence
						end
					end
				end

				if LocalConfigFolder.Blood.Value == false then
					for _, BloodVFX: ParticleEmitter in slash2VFX:GetDescendants() do
						if BloodVFX:IsA("ParticleEmitter") and BloodVFX.Name == "Blood" then
							BloodVFX:Destroy()
						end
					end
				end

				slash2VFX.Parent = workspace.Thrown
				if (slash2VFX.Position - LocalCharacter.HumanoidRootPart.Position).Magnitude <= 37 then
					ShakeCameraModule:ShakeCamera(17, 17, 0, .4)
				end
				ParticlesModule.Emit(slash2VFX)
				Debris:AddItem(slash2VFX, 4)


				local cutArmContainer = Instance.new("Model")
				Instance.new("Humanoid").Parent = cutArmContainer
				cutArmContainer.Name = "ArmClone"
				for _, eCharClothes in EnemyCharacter:GetChildren() do
					if eCharClothes:IsA("Shirt") then
						eCharClothes:Clone().Parent = cutArmContainer
					end
				end

				local cutArmClone = EnemyCharacter["Right Arm"]:Clone()
				cutArmClone.CollisionGroup = "Flying Rocks"
				local cutArmTween = TS:Create(cutArmClone, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					Transparency = 1, 
					Size = cutArmClone.Size / 2
				})

				cutArmTween.Completed:Connect(function()
					if cutArmContainer ~= nil and cutArmContainer.Parent ~= nil then
						cutArmContainer:Destroy()
					end
				end)
				cutArmClone.Parent = cutArmContainer
				EnemyCharacter["Right Arm"].Transparency = 1
				cutArmContainer.Parent = workspace.Thrown
				cutArmClone.CanCollide = true
				cutArmClone:ApplyImpulse(EnemyHumRP.CFrame.RightVector * 65 + Vector3.new(0, 110, 0));
				cutArmClone:ApplyAngularImpulse(Vector3.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10)));

				task.delay(4, function()
					if cutArmTween ~= nil then
						cutArmTween:Play()
					end
				end)

				dashForward(80)
			end)
			local Cone
			task.delay(2.567, function()
				local function tweenTimeScale(particlesContainer: Part?, tweenTime: number, easingDirection: string, finalTimeScale: number)
					for _, Particle: ParticleEmitter in pairs(particlesContainer:GetDescendants()) do
						if Particle:IsA("ParticleEmitter") then
							TS:Create(Particle, TweenInfo.new(tweenTime, Enum.EasingStyle.Quad, Enum.EasingDirection[easingDirection]), {
								TimeScale = finalTimeScale
							}):Play()
						end
					end
				end

				local function fadeInAttachmentPosition(attachmentsContainer)
					for _, Attachment: Attachment in pairs(attachmentsContainer:GetDescendants()) do
						if Attachment:IsA("Attachment") and Attachment.Name == "Attachment" and Attachment.Parent.Name == "A1" then
							local goalPosition = Attachment.Position

							Attachment.Position += Vector3.new(0, 0, -Attachment.Position.Z)

							TS:Create(Attachment, TweenInfo.new(1.25), {
								Position = goalPosition
							}):Play()
						end
					end
				end

				local slash3VFX = AssetsFolder.Finisher.Slash3:Clone()
				slash3VFX.CFrame = EnemyHumRP.CFrame

				local groundRay = raycast(slash3VFX.Position, Vector3.new(0, -7.5, 0), MapRayParams);
				if groundRay then
					local newColorSequence = ColorSequence.new(groundRay.Instance.Color)
					for _, Smoke: ParticleEmitter? in pairs(slash3VFX:GetDescendants()) do
						if Smoke:IsA("ParticleEmitter") and Smoke.Name == "Smoke" then
							Smoke.Color = newColorSequence
						end
					end
				end

				if LocalConfigFolder.Blood.Value == false then
					for _, Blood: ParticleEmitter in pairs(slash3VFX:GetDescendants()) do
						if Blood:IsA("ParticleEmitter") and Blood.Name == "Blood" then
							Blood:Destroy()
						end
					end
				end

				slash3VFX.Parent = workspace.Thrown
				if (slash3VFX.Position - LocalCharacter.HumanoidRootPart.Position).Magnitude <= 37 then
					ShakeCameraModule:ShakeCamera(26, 26, 0, .4)
				end

				ParticlesModule.Emit(slash3VFX)
				Debris:AddItem(slash3VFX, 4)

				dashForward(134)


				Cone = AssetsFolder.Finisher.Cone:Clone()
				local Weld = Instance.new("WeldConstraint")
				Weld.Parent = Cone
				Weld.Part0 = EnemyHumRP
				Cone.CFrame = EnemyHumRP.CFrame * CFrame.Angles(0, math.pi, 0)
				Cone.Parent = workspace.Thrown
				Weld.Part1 = Cone
				Debris:AddItem(Cone, 3)

				tweenTimeScale(slash3VFX.Slash3, 0.75, "Out", 0)

				task.delay(0.5, function()
					fadeInBeam(Cone, 0.5)
					tweenBeamSpeed(Cone, 15, 'In')
					fadeInAttachmentPosition(Cone)

					task.delay(0.65, function()
						tweenTimeScale(slash3VFX.Slash3, 0.5, "In", 1)
					end)
				end)
			end)

			task.delay(4.117, function()
				local sheatheVFX = AssetsFolder.Finisher.Sheathe:Clone()
				sheatheVFX.CFrame = EnemyHumRP.CFrame

				local groundRay = raycast(sheatheVFX.Position, Vector3.new(0, -7.5, 0), MapRayParams);
				if groundRay then
					local newColorSequence = ColorSequence.new(groundRay.Instance.Color)
					for _, Smoke: ParticleEmitter in pairs(sheatheVFX:GetDescendants()) do
						if Smoke:IsA("ParticleEmitter") and Smoke.Name == "Smoke" then
							Smoke.Color = newColorSequence
						end
					end
				end

				if LocalConfigFolder.Blood.Value == false then
					for _, Blood: ParticleEmitter in pairs(sheatheVFX:GetDescendants()) do
						if Blood:IsA("ParticleEmitter") and Blood.Name == "Blood" then
							Blood:Destroy()
						end
					end
				end

				sheatheVFX.Parent = workspace.Thrown
				if (sheatheVFX.Position - LocalCharacter.HumanoidRootPart.Position).Magnitude <= 37 then
					ShakeCameraModule:ShakeCamera(38, 38, .42, 1.14)
				end
				ParticlesModule.Emit(sheatheVFX)
				Debris:AddItem(sheatheVFX, 7)


				if Cone then
					for _, Beam: Beam in Cone:GetDescendants() do
						if Beam:IsA("Beam") then
							BoatTween:Create(Beam, {
								Time = .3, 
								EasingStyle = 'Sine', 
								EasingDirection = 'Out', 
								Reverses = false, 
								DelayTime = 0, 
								RepeatCount = 0, 
								StepType = "Heartbeat", 
								Goal = {
									Transparency = NumberSequence.new(1)
								}
							}):Play()
						end
					end
				end


				local windVFX = AssetsFolder.Finisher.Wind:Clone()
				windVFX.Anchored = true
				windVFX.CFrame = EnemyHumRP.CFrame * CFrame.new(0, 0, 15)
				windVFX.Parent = workspace.Thrown
				fadeInBeam(windVFX, 0.1)
				Debris:AddItem(windVFX, 3.5)

				for _, Beam: Beam in windVFX:GetDescendants() do
					if Beam:IsA("Beam") then
						BoatTween:Create(Beam, {
							Time = 2.64, 
							EasingStyle = 'Sine', 
							EasingDirection = 'Out', 
							Reverses = false, 
							DelayTime = 0, 
							RepeatCount = 0, 
							StepType = "Heartbeat", 
							Goal = {
								Transparency = NumberSequence.new(1)
							}
						}):Play()
					end
				end

				task.delay(1.5, function()
					for _, Particle: ParticleEmitter in pairs(windVFX:GetDescendants()) do
						if Particle:IsA("ParticleEmitter") then
							Particle.Enabled = false
						end
					end
				end)

				tweenBeamSpeed(windVFX, 2, 'Out')
			end)

			local GrabVFX = AssetsFolder.GrabInitiate:Clone()
			GrabVFX.CFrame = EnemyCharacter.Head.CFrame
			GrabVFX.Parent = workspace.Thrown
			if (LocalCharacter.HumanoidRootPart.Position - HumRP.Position).Magnitude <= 20 then
				ShakeCameraModule:ShakeCamera(13.5, 13.5, 0, .4)
			end
			ParticlesModule.Emit(GrabVFX)
			Debris:AddItem(GrabVFX, 3)

			dashForward(70)

		end
	end,	


	KetchupEffect = function(Params)
		if (UIS.GamepadEnabled and game:GetService("GuiService"):IsTenFootInterface()) or not BloodConfig.Value then
			return
		end

		local v15948 = rawget(Params, "Head")
		local v15949 = rawget(Params, "Position") or Params.Part.Position
		if v15948 and not v15948.Parent then
			return ;
		else
			local v15952 = {};
			local v15953 = false;
			do
				local l_v15953_0 = v15953;
				task.delay(2, function()
					l_v15953_0 = true;
					for _, v15956 in pairs(v15952) do
						TS:Create(v15956, TweenInfo.new(math.random(), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							Size = Vector3.new(0, 0, 0, 0), 
							Transparency = 1
						}):Play();
						Debris:AddItem(v15956, 1);
						task.wait();
					end;
				end);
				local BloodBoom = Assets.Sounds.Blood:Clone()
				local HumRP: BasePart = LocalCharacter:FindFirstChild('HumanoidRootPart')
				BloodBoom.Parent = HumRP
				BloodBoom:Play()
				Debris:AddItem(BloodBoom, BloodBoom.TimeLength + 1)
				for _ = 1, math.max(rawget(Params, "Times") / 2, 1) do
					local v15958 = rawget(Params, "Part");
					if v15958 then
						v15949 = v15958.Position;
					end;
					local v15959 = script.Misc.BloodParticle:Clone();
					v15959.Position = v15949;
					v15959.Parent = workspace.Thrown;
					local l_BodyVelocity_22 = Instance.new("BodyVelocity");
					l_BodyVelocity_22.MaxForce = Vector3.new(5000, 5000, 5000, 0);
					local v15961 = -65;
					local v15962 = 65;
					local l_v82_435 = RandomSeed;
					if not v15962 and v15961 then
						v15962 = v15961;
						v15961 = 1;
					end;
					if not v15962 and not v15961 then
						v15961 = 0;
						v15962 = 1;
					end;
					local v15964 = l_v82_435:NextNumber(v15961, v15962);
					v15962 = 2;
					l_v82_435 = 55;
					local l_v82_436 = RandomSeed;
					if not l_v82_435 and v15962 then
						l_v82_435 = v15962;
						v15962 = 1;
					end;
					if not l_v82_435 and not v15962 then
						v15962 = 0;
						l_v82_435 = 1;
					end;
					l_BodyVelocity_22.Velocity = Vector3.new(v15964, l_v82_436:NextNumber(v15962, l_v82_435), generateRandomNumber(-65, 65));
					if v15948 then
						v15959.Position = (v15948.CFrame * CFrame.new(0, -0.3, 0)).Position;
						v15964 = v15948.CFrame.lookVector;
						v15962 = 10;
						l_v82_435 = 15;
						l_v82_436 = RandomSeed;
						if not l_v82_435 and v15962 then
							l_v82_435 = v15962;
							v15962 = 1;
						end;
						if not l_v82_435 and not v15962 then
							v15962 = 0;
							l_v82_435 = 1;
						end;
						l_BodyVelocity_22.Velocity = v15964 * l_v82_436:NextNumber(v15962, l_v82_435);
						local l_Velocity_1 = l_BodyVelocity_22.Velocity;
						v15962 = -5;
						l_v82_435 = 5;
						l_v82_436 = RandomSeed;
						if not l_v82_435 and v15962 then
							l_v82_435 = v15962;
							v15962 = 1;
						end;
						if not l_v82_435 and not v15962 then
							v15962 = 0;
							l_v82_435 = 1;
						end;
						v15961 = l_v82_436:NextNumber(v15962, l_v82_435);
						l_v82_435 = -2;
						l_v82_436 = 2;
						local l_v82_437 = RandomSeed;
						if not l_v82_436 and l_v82_435 then
							l_v82_436 = l_v82_435;
							l_v82_435 = 1;
						end;
						if not l_v82_436 and not l_v82_435 then
							l_v82_435 = 0;
							l_v82_436 = 1;
						end;
						l_BodyVelocity_22.Velocity = l_Velocity_1 + Vector3.new(v15961, l_v82_437:NextNumber(l_v82_435, l_v82_436), generateRandomNumber(-5, 5));
					end;
					l_BodyVelocity_22.Parent = v15959;
					Debris:AddItem(l_BodyVelocity_22, 0.15);
					local v15968 = nil;
					do
						local l_v15968_0 = v15968;
						l_v15968_0 = v15959.Touched:connect(function(v15970)
							if l_v15953_0 then
								return ;
							else
								local l_Position_86 = v15959.Position;
								if not v15970:IsDescendantOf(workspace.Thrown) and not v15970:IsA("SpawnLocation") and not v15970:IsDescendantOf(workspace.Live) and v15970.CanCollide and v15970.Transparency < 1 then
									local v15972, v15973, _, v15975 = raycast(l_Position_86 + Vector3.new(0, 3, 0), Vector3.new(0, -3, 0), { v15970 }, true, true)
									if v15975 then
										Debris:AddItem(v15959, 0.6);
										delay(0.4, function()
											v15959.Trail.Enabled = false;
										end);
										local l_Part_27 = Instance.new("Part");
										l_Part_27.CFrame = CFrame.new(v15973);
										local v15977 = getNormal(l_Part_27.CFrame.UpVector, v15975, (Vector3.new(0, 1, 0)));
										local v15978 = 0;
										local v15979 = 0.6;
										local v15980 = 1.25;
										local l_v82_438 = RandomSeed;
										if not v15980 and v15979 then
											v15980 = v15979;
											v15979 = 1;
										end;
										if not v15980 and not v15979 then
											v15979 = 0;
											v15980 = 1;
										end;
										local v15982 = Vector3.new(v15978, l_v82_438:NextNumber(v15979, v15980), generateRandomNumber(0.6, 1.25));
										l_Part_27.CFrame = l_Part_27.CFrame * (v15977 * CFrame.new(0, 0.05, 0) * CFrame.Angles(0, 0, 1.5707963267948966));
										l_Part_27.Name = "Blood";
										table.insert(v15952, l_Part_27);
										l_Part_27.Anchored = true;
										l_Part_27.CanCollide = false;
										l_Part_27.CanTouch = false;
										l_Part_27.CanQuery = false;
										v15978 = Color3.fromRGB;
										v15979 = 94;
										l_v82_438 = -7;
										local v15983 = 7;
										local l_v82_439 = RandomSeed;
										if not v15983 and l_v82_438 then
											v15983 = l_v82_438;
											l_v82_438 = 1;
										end;
										if not v15983 and not l_v82_438 then
											l_v82_438 = 0;
											v15983 = 1;
										end;
										l_Part_27.Color = v15978(v15979 + l_v82_439:NextNumber(l_v82_438, v15983), 0, 0);
										l_Part_27.Shape = Enum.PartType.Cylinder;
										l_Part_27.Material = Enum.Material.SmoothPlastic;
										l_Part_27.Transparency = 0;
										l_Part_27.Size = v15982;
										l_Part_27.Parent = workspace.Thrown;
										v15978 = TS;
										v15979 = l_Part_27;
										v15980 = TweenInfo.new;
										v15983 = 0.05;
										l_v82_439 = 0.09;
										local l_v82_440 = RandomSeed;
										if not l_v82_439 and v15983 then
											l_v82_439 = v15983;
											v15983 = 1;
										end;
										if not l_v82_439 and not v15983 then
											v15983 = 0;
											l_v82_439 = 1;
										end;
										v15978:Create(v15979, v15980(l_v82_440:NextNumber(v15983, l_v82_439), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
											Size = l_Part_27.Size * (Params.Size or 1.5)
										}):Play();
										if not v15972.Anchored then
											l_Part_27.Anchored = false;
											v15978 = Instance.new("Weld");
											v15978.Part0 = l_Part_27;
											v15978.Part1 = v15972;
											v15978.C0 = l_Part_27.CFrame:inverse();
											v15978.C1 = v15972.CFrame:inverse();
											v15978.Parent = l_Part_27;
										end;
										if not (v15972.Name ~= "Explosive" and not v15972:GetAttribute("Type")) or v15972.Name == "Glass" then
											v15972:GetPropertyChangedSignal("Parent"):Connect(function()
												if not v15972.Parent or v15972.Parent == game.Lighting.Deleted then
													l_Part_27:Destroy();
												end;
											end);
										end;
										addSound({
											SoundId = ({
												"rbxassetid://112140696125153", 
												"rbxassetid://127007077400989", 
												"rbxassetid://101743325684654"
											})[math.random(1, 3)], 
											Volume = 0.45, 
											Parent = l_Part_27
										}):Play();
									end;
									return l_v15968_0:disconnect();
								else
									return ;
								end;
							end;
						end);
						if not Params.nocd then
							if rawget(Params, "Debounce") then
								wait((rawget(Params, "Debounce")));
							else
								task.wait();
							end;
						end;
					end;
				end;
			end;
		end;
	end,

	WhiteAura = function(Params: { any })
		repeat task.wait() until Params.Plr.Character ~= nil and Params.Plr.Character.Parent ~= nil and Params.Plr.Character:FindFirstChild('Torso')

		local FadeOutTime = Params.Time
		local Character: Model = Params.Plr.Character

		if Params.Light == true then
			local Light = script.Misc.Light:Clone()
			Light.Parent = Character:FindFirstChild('Torso') or Character:WaitForChild('Torso', 10)
			TS:Create(Light, TweenInfo.new(FadeOutTime, Enum.EasingStyle.Linear), { Brightness = 0 }):Play()	
			Debris:AddItem(Light, FadeOutTime)	
		end


		local HLight = script.Misc.HLight:Clone()
		HLight.Parent = Character

		TS:Create(HLight, TweenInfo.new(FadeOutTime, Enum.EasingStyle.Linear), { FillTransparency = 1, OutlineTransparency = 1 }):Play()

		Debris:AddItem(HLight, FadeOutTime)
	end,

	M1sReact = function(Params: { any })
		repeat task.wait() until Params.Plr.Character ~= nil and Params.Plr.Character.Parent ~= nil and Params.Plr.Character:FindFirstChild('Torso')

		local FadeOutTime = Params.Time
		local Character: Model = Params.Plr.Character

		if Params.Light == true then
			local Light = script.Misc.Light:Clone()
			Light.Parent = Character:FindFirstChild('Torso') or Character:WaitForChild('Torso', 1)
			TS:Create(Light, TweenInfo.new(FadeOutTime, Enum.EasingStyle.Linear), { Brightness = 0 }):Play()	
			Debris:AddItem(Light, FadeOutTime)	
		end


		local HLight = script.Misc.HLight:Clone()
		HLight.Parent = Character

		TS:Create(HLight, TweenInfo.new(FadeOutTime, Enum.EasingStyle.Linear), { FillTransparency = 1, OutlineTransparency = 1 }):Play()

		Debris:AddItem(HLight, FadeOutTime)
	end,

	KnockbackChar = function(Params: { any })
		local Character: Model = Params.Char
		local Data = Params.Data
		local Bodymover

		if Data.KnockbackType == "Velocity" then
			Bodymover = Instance.new("BodyVelocity")
			Bodymover.MaxForce = Data.MaxForce
			Bodymover.Velocity = Data.Velocity
			if Data.P then
				Bodymover.P = Data.P
			end
			if Data.D  then
				Bodymover.D = Data.D
			end
		elseif Data.KnockbackType == "Position" then
			Bodymover = Instance.new("BodyPosition")
			Bodymover.MaxForce = Data.MaxForce 
			Bodymover.Position = Data.Position
			if Data.P then
				Bodymover.P = Data.P
			end
			if Data.D  then
				Bodymover.D = Data.D
			end
		elseif Data.KnockbackType == "Linear" then
			Bodymover = Instance.new("LinearVelocity")
			Bodymover.ForceLimitMode = Enum.ForceLimitMode.PerAxis
			Bodymover.MaxAxesForce = Data.MaxForce
			Bodymover.VectorVelocity = Data.Velocity
			if Data.P then
				Bodymover.P = Data.P
			end
			if Data.D  then
				Bodymover.D = Data.D
			end
			Bodymover.Attachment0 = Character.HumanoidRootPart.RootAttachment
		elseif Data.KnockbackType == "VelocityTweenDown" then
			Bodymover = Instance.new("BodyVelocity")
			Bodymover.MaxForce = Data.MaxForce
			Bodymover.Velocity = Data.Velocity
			if Data.P then
				Bodymover.P = Data.P
			end
			if Data.D  then
				Bodymover.D = Data.D
			end

			local TweenFX = TS:Create(Bodymover, TweenInfo.new(Data.Time, Enum.EasingStyle.Sine,Enum.EasingDirection.Out), { Velocity = Vector3.new(0,0,0) })
			TweenFX:Play()
		end

		if Character:FindFirstChild('Humanoid') then
			Bodymover.Parent = Character.HumanoidRootPart
		else
			Bodymover.Parent = Character
		end


		if Data.Time then
			Debris:AddItem(Bodymover, Data.Time)
		else
			Debris:AddItem(Bodymover, .1)
		end
	end,

	Emote = function(Params: { any })
		local Emote: string = Params.Emote

		if Emote == '8 Bit' then
			local Character: Model = Params.Char
			local Stage: string = Params.Stage

			if Stage == 'Shoot' then
				local VFXAtt = script.Misc.Emotes['8 Bit'].Effects.Shoot:Clone()
				VFXAtt.Parent = Character.HumanoidRootPart
				ParticlesModule.Emit(VFXAtt)
				Debris:AddItem(VFXAtt, .15)
			elseif Stage == 'Heart' then
				local VFXAtt = script.Misc.Emotes['8 Bit'].Effects.Heart:Clone()
				VFXAtt.Parent = Character.HumanoidRootPart
				ParticlesModule.Emit(VFXAtt)
				Debris:AddItem(VFXAtt, 1)
			end


		end
	end,

	RemoveAllBodyMovers = function(Character: Model)
		for _, BodyMover: BodyVelocity in Character:GetDescendants() do
			if BodyMover:IsA('BodyVelocity') or BodyMover:IsA('LinearVelocity') or BodyMover:IsA('BodyPosition') then
				BodyMover:Destroy()
				print(BodyMover)
			end
		end
	end,

	PerfectHit = function(Params)
		local HumRP: BasePart = Params.MainPart
		local Preset = CamShakePresets.SmallImpact

		ShakeCameraModule:ShakeCamera(Preset.Magnitude, Preset.Roughness, Preset.FadeInTime, Preset.FadeOutTime)

		local VFX = script.Misc.PerfectHit.Attachment:Clone()
		VFX.Parent = HumRP
		ParticlesModule.Emit(VFX)
		Debris:AddItem(VFX, 1.2)
	end,

	TriggerRagdoll = function(Params)
		local Humanoid: Humanoid = Params.Humanoid

		if Params.State == true then
			Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
		else
			Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		end
	end,

	AddEmoteSync = function(Params)
		if Params.MainChar == LocalCharacter then return end

		for _, BGui: BillboardGui in LocalPlayer.PlayerGui:GetChildren() do
			if BGui.Name == Params.MainChar.Name..'SyncEmote' then
				BGui:Destroy()
			end
		end

		local SyncGui = script.Misc.SyncEmote:Clone()
		SyncGui.Parent = LocalPlayer.PlayerGui
		SyncGui.Name = Params.MainChar.Name..'SyncEmote'
		SyncGui.Adornee = Params.MainChar.HumanoidRootPart
		local csa = SyncGui.Frame.Button.Activated:Once(function()
			RS.Remotes.Emotes.Set:FireServer(Params.MainChar, LocalCharacter)
		end)


		if shared.IsConsole then
			SyncGui.Frame.ImageLabel.Image = SyncGui.Frame.ImageLabel:GetAttribute('ControllerButton')

			local csav: RBXScriptConnection
			csav = UIS.InputBegan:Connect(function(i, g)
				if g then return end

				if i.KeyCode == Enum.KeyCode.ButtonX and (Params.MainChar.HumanoidRootPart.Position - LocalCharacter.HumanoidRootPart.Position).Magnitude < 25 then
					csav:Disconnect()
					csa:Disconnect()

					RS.Remotes.Emotes.Set:FireServer(Params.MainChar, LocalCharacter)
				end
			end)
		end
	end,

	RemoveEmoteSync = function(Params)
		for _, BGui: BillboardGui in LocalPlayer.PlayerGui:GetChildren() do
			if BGui.Name == Params.MainChar.Name..'SyncEmote' then
				BGui:Destroy()
			end
		end
	end,

	ArmTrail = function(params)
		local Char = params.Char

		for _,Arm in params.Arms do
			task.spawn(function()
				local Clone = EffectsAssets.ArmTrail:Clone()
				Clone.Parent = Arm.Parent
				Clone.Weld.Part0 = Arm

				task.wait(params.Lifetime)

				for _,trail in pairs(Clone:GetDescendants()) do
					if trail:IsA('Trail') then
						trail.Enabled = false
					end
				end

				Debris:AddItem(Clone,.5)
			end)
		end
	end,



	monarchawakening = function(Params)
		local function v945(v939, v940)
			local v941 = RaycastParams.new();
			v941.FilterType = Enum.RaycastFilterType.Exclude;
			v941.FilterDescendantsInstances = {
				workspace.Effects, 
				workspace.Live, 
				workspace.Thrown
			};
			local v942 = workspace:Raycast(v940.PrimaryPart.Position, Vector3.new(0, -8, 0, 0), v941);
			if v942 then
				for _, v944 in pairs(v939:GetDescendants()) do
					if v944:IsA("ParticleEmitter") then
						v944.Color = ColorSequence.new(v942.Instance.Color);
					end;
				end;
				return true;
			else
				return false;
			end;
		end;
		local l_v945_0 = v945 --[[ copy: 1 -> 75 ]];
		local function v957(v947, v948)
			local v949 = v948["Right Leg"];
			local v950 = v948["Left Leg"];
			if v947 == "Right" then
				local v951 = game.ReplicatedStorage.Effects.TwirlingRush.FootStep.Footstep:Clone();
				v951.Parent = v949;
				game.Debris:AddItem(v951, 2);
				if not l_v945_0(v951, v948) then
					if v951 and v951.Parent then
						v951:Destroy();
						return;
					end;
				else
					for _, v953 in pairs(v951:GetDescendants()) do
						if v953:IsA("ParticleEmitter") then
							v953:Emit(v953:GetAttribute("EmitCount"));
						end;
					end;
					return;
				end;
			else
				local v954 = game.ReplicatedStorage.Effects.TwirlingRush.FootStep.Footstep:Clone();
				v954.Parent = v950;
				game.Debris:AddItem(v954, 2);
				if not l_v945_0(v954, v948) then
					if v954 and v954.Parent then
						v954:Destroy();
						return;
					end;
				else
					for _, v956 in pairs(v954:GetDescendants()) do
						if v956:IsA("ParticleEmitter") then
							v956:Emit(v956:GetAttribute("EmitCount"));
						end;
					end;
				end;
			end;
		end;
		local l_Anim_0 = nil
		local v959 = require(script.Monarch.awakening.JinAwakening);
		local l_Char_9 = Params.Char;
		local l_Humanoid_5 = l_Char_9.Humanoid;
		if not Params.NoTrail then
			v959.AddTrails({}, l_Char_9);
		end;
		local l_v959_0 = v959 --[[ copy: 4 -> 76 ]];
		local l_l_Char_9_0 = l_Char_9 --[[ copy: 5 -> 77 ]];
		local l_v957_0 = v957 --[[ copy: 2 -> 78 ]];
		local v965 = {
			RightFootStep = function()
				l_v959_0.FootStep({}, l_l_Char_9_0, "Right");
			end, 
			LeftFootStep = function()
				l_v959_0.FootStep({}, l_l_Char_9_0, "Left");
			end, 
			R = function()
				l_v957_0("Right", l_l_Char_9_0);
			end, 
			L = function()
				l_v957_0("Left", l_l_Char_9_0);
			end, 
			BigJump = function()
				l_v959_0.BigJump({}, l_l_Char_9_0);
			end, 
			Explosion = function()
				l_v959_0.Explosion({}, l_l_Char_9_0);
			end
		};
		local startTime = tick()
		repeat
			for _, v967 in pairs(l_Humanoid_5:GetPlayingAnimationTracks()) do
				if v967.Animation.AnimationId == "rbxassetid://124904998449738" then
					l_Anim_0 = v967;
					break;
				end;
			end;

			task.wait()
		until l_Anim_0 ~= nil or tick() - startTime >= 5

		if not l_Anim_0 then return end

		for v968, v969 in pairs(v965) do
			local v970 = nil;
			v970 = l_Anim_0:GetMarkerReachedSignal(v968):Connect(function()
				return v969();
			end);
			do
				local l_v970_0 = v970;
				task.delay(8, function()
					if l_v970_0 then
						l_v970_0:Disconnect();
					end;
				end);
			end;
		end;
	end,

	INFM1 = function(Params)
		local HumRP: BasePart = Params.MainPart
		local Preset = CamShakePresets.SmallImpact

		ShakeCameraModule:ShakeCamera(Preset.Magnitude, Preset.Roughness, Preset.FadeInTime, Preset.FadeOutTime)

		local VFX = script["Strongest of Today"].M1.M1.Attachment:Clone()
		VFX.Parent = HumRP
		ParticlesModule.Emit(VFX)
		Debris:AddItem(VFX, 1.2)
	end,

	INFM12 = function(Params)
		local HumRP: BasePart = Params.MainPart
		local Preset = CamShakePresets.SmallImpact

		ShakeCameraModule:ShakeCamera(Preset.Magnitude, Preset.Roughness, Preset.FadeInTime, Preset.FadeOutTime)

		local VFX = script["Strongest of Today"].M1.M4.Attachment:Clone()
		VFX.Parent = HumRP
		ParticlesModule.Emit(VFX)
		Debris:AddItem(VFX, 1.2)
	end,

	Awakening = function(Params)
		local Awk = Params.Awk
		local Stage = Params.Stage

		local Character: Model = Params.Char
		local HumRP: BasePart = Character:FindFirstChild('HumanoidRootPart')
		local Humanoid: Humanoid = Character:FindFirstChild('Humanoid')
		if Awk == 'JK' then
			if Stage == 'Start' then
				local WalkVel = Instance.new("BodyVelocity")
				WalkVel.Name = "WalkVel"
				WalkVel.MaxForce = Vector3.new(1, 0, 1) * 100000
				WalkVel.Velocity = HumRP.CFrame.LookVector * 7.5
				WalkVel.Parent = HumRP
				local Aura = script.JK.Awakening.IdleAura:Clone()
				Aura.Parent = Character
				Aura.CFrame = HumRP.CFrame
				Aura.WeldConstraint.Part0 = HumRP
				local WindupSparks = script.JK.FiveSeasons.CharFX.WindupSpark:Clone()
				WindupSparks.Parent = Character["Left Arm"]
				ParticlesModule.Enabled(WindupSparks, true)

				local c: RBXScriptConnection
				c = RNS.RenderStepped:Connect(function()
					if WalkVel.Parent then
						WalkVel.Velocity = HumRP.CFrame.LookVector * 7.5
					else
						c:Disconnect()
					end
				end)

				Debris:AddItem(WalkVel, 1.767)
				Debris:AddItem(Aura, 1.767)
				wait(1.667)
				ParticlesModule.Enabled(WindupSparks, false)
				wait(5)

			elseif Stage == 'End' then
				wait(0.1)
				local Burst = script.JK.FiveSeasons.CharFX.ArmEnabled:Clone()
				Burst.Parent = Character["Left Arm"]
				ParticlesModule.Enabled(Burst, true)
				local End = script.JK.Awakening.IdleEnd:Clone()
				End.Parent = Character
				End.CFrame = HumRP.CFrame
				local eyeShine = script.JK.FiveSeasons.CharFX.EyeEmit:Clone()
				eyeShine.Parent = Character.Head
				ParticlesModule.Emit(eyeShine)
				local JKTextVFX = script.JK.Awakening.JK:Clone()
				JKTextVFX.Parent = Character
				JKTextVFX.CFrame = HumRP.CFrame
				require(game.ReplicatedStorage.Modules.Utility)('Particles').Emit(JKTextVFX, 'Emit')
				ParticlesModule.Emit(End)


				Debris:AddItem(End, 3)
				Debris:AddItem(JKTextVFX, 2)
				Debris:AddItem(eyeShine, 1.7)
				wait(0.2)
				ParticlesModule.Enabled(Burst, false)

			elseif Stage == 'End' or Stage == 'StartIdle' then
				local JKTextVFX = script.JK.Awakening.JK:Clone()
				JKTextVFX.Parent = Character
				JKTextVFX.CFrame = HumRP.CFrame
				ParticlesModule.Emit(JKTextVFX, 'Emit')
				Debris:AddItem(JKTextVFX, 2)

				if Stage == 'StartIdle' then
					local Aura = script.JK.Awakening.IdleAura:Clone()
					Aura.Parent = Character
					Aura.CFrame = HumRP.CFrame
					Aura.WeldConstraint.Part0 = HumRP
					Debris:AddItem(Aura, 8.016)

				end
			end

		elseif Awk == 'KJ' then
			if Stage == 'Start' then
				local WalkVel = Instance.new("BodyVelocity")
				WalkVel.Name = "WalkVel"
				WalkVel.MaxForce = Vector3.new(1, 0, 1) * 100000
				WalkVel.Velocity = HumRP.CFrame.LookVector * 7.5
				WalkVel.Parent = HumRP

				local c: RBXScriptConnection
				c = RNS.RenderStepped:Connect(function()
					if WalkVel.Parent then
						WalkVel.Velocity = HumRP.CFrame.LookVector * 7.5
					else
						c:Disconnect()
					end
				end)

				Debris:AddItem(WalkVel, 1.667)
			elseif Stage == 'End' or Stage == 'StartIdle' then
				local KJTextVFX = script.KJ.Awakening.KJ:Clone()
				KJTextVFX.Parent = Character
				KJTextVFX.CFrame = HumRP.CFrame
				ParticlesModule.Emit(KJTextVFX, 'Emit')
				Debris:AddItem(KJTextVFX, 2)

				if Stage == 'StartIdle' then
					local Aura = script.KJ.Awakening.IdleAura:Clone()
					Aura.Parent = Character
					Aura.CFrame = HumRP.CFrame
					Aura.WeldConstraint.Part0 = HumRP
					Debris:AddItem(Aura, 8.016)
				end

			elseif Stage == 'IdleEnd' then
				local End = script.KJ.Awakening.IdleEnd:Clone()
				End.Parent = Character
				End.CFrame = HumRP.CFrame
				ParticlesModule.Emit(End)
				Debris:AddItem(End, 3)
			end
		elseif Awk == 'Kokushibo' then
			if Stage == 'FullfilSword' then
				local FullfillingPart: Part = Character.Sword.AwakeningMain.Blade.BladePart
				ParticlesModule.Enabled(FullfillingPart, true)
				task.delay(.567, function()
					ParticlesModule.Enabled(FullfillingPart, false)
				end)
			elseif Stage == 'End' then
				ParticlesModule.Emit(Character.Sword.AwakeningMain.Blade.BladePart.BurstEmit)
			elseif Stage == 'ChangeSword' then
				ParticlesModule.Emit(Character.Sword.AwakeningMain.Blade.BladePart.BurstEmit)
			end
		elseif Awk == 'Saitama' then
			local Torso: BasePart = Character.Torso
			if Stage == 'Start' then
				local Burst = script["Saitama"].Awakening.PART.Wind:Clone()
				Burst.Parent = HumRP
				ParticlesModule.Emit(Burst)
				Debris:AddItem(Burst, 2)
			end
		elseif Awk == 'Shadow Monarch' then
			if Stage == 'Start' then
				local Speed = 30

				local WalkVel = Instance.new("BodyVelocity")
				WalkVel.Name = "WalkVel"
				WalkVel.MaxForce = Vector3.new(1, 0, 1) * 100000
				WalkVel.Velocity = HumRP.CFrame.LookVector * Speed
				WalkVel.Parent = HumRP

				local c: RBXScriptConnection
				c = RNS.RenderStepped:Connect(function()
					if WalkVel.Parent then
						WalkVel.Velocity = HumRP.CFrame.LookVector * Speed
					else
						c:Disconnect()
					end
				end)

				task.delay(.967, function()
					Speed = (30 * 1.5)
				end)

				task.delay(1.433, function()
					Speed = (30 * 0.5)
				end)

				task.delay(1.633, function()
					Speed = (30 * 1.75)
				end)

				task.delay(2.117, function()
					Speed = (30 * 0.5)
				end)

				task.delay(2.200, function()
					Speed = (30 * 2)
				end)

				Debris:AddItem(WalkVel, 2.95)
			end

		elseif Awk == 'Jun' then
			local AssetsFolder = script.Jun.Awakening
			local Table = Params
			local Tween = TS
			local l_VFX_0 = workspace.Effects
			local EffectsType = Table.Stage
			local l_Tags_1 = Table.Tags
			if EffectsType == 'JunAwakeningWhiteBeam' then
				local l_On_51 = Character;
				if not (l_On_51 ~= nil) or l_On_51.Parent == nil then
					return;
				else
					local l_CFrame_36 = l_On_51.HumanoidRootPart.CFrame;
					local v1546 = VFXService.FindGroundPosition(l_CFrame_36.Position, 30,MapRayParams);
					local v1547 = VFXService.GetTile(l_CFrame_36.Position);
					if v1546 then
						local v1548 = script.Jun.Awakening.WhiteBeam:Clone();
						local v1549 = v1546.Position + Vector3.new(0, 0.048, 0);
						local v1550 = CFrame.new(v1549, v1549 + l_CFrame_36.LookVector);
						v1548.CFrame = v1550;
						v1548.Parent = l_VFX_0;
						VFXService.EmitParticlesInInstance(v1548);
						VFXService.DestroyTile(v1547);
						VFXService.DestroyParticleContainer(v1548, 14);
						if not (LocalPlayer.Character ~= l_On_51) or (LocalPlayer.Character:FindFirstChildOfClass('Humanoid').RootPart.Position - l_On_51.HumanoidRootPart.Position).Magnitude <= 30 then
							VFXService.ShakeCamera(0, 0.4, 22, 0.3, 0.3, 0.3);
						end;
						v104.PlaySoundAtCFrame(v1550, "Smoke");
					end;
					v104.PlaySoundInInstance(l_On_51.HumanoidRootPart, "Voice");
				end;
			elseif EffectsType == 'JunAwakeningBP' then
				local v1635 = Instance.new("BodyPosition");
				v1635.D = 12;
				v1635.P = 70;
				v1635.MaxForce = Vector3.new(100000, 100000, 100000);
				v1635.Position = Table.R;
				v1635.Parent = LocalPlayer.Character:FindFirstChild('HumanoidRootPart');
				local l_v1635_0 = v1635
				local Bind = Instance.new('Accessory',LocalPlayer.Character)
				Bind.Name = 'JunAwakeningBodyPosition'
				Bind.Destroying:Once(function()
					l_v1635_0:Destroy();
				end)
			elseif EffectsType == 'JunAwakeningCutsceneEyes' then 
				local l_On_47 = Character;
				if not (l_On_47 ~= nil) or l_On_47.Parent == nil then
					return;
				else
					local v1465 = script.Jun.Awakening.Eyes.Eyes:Clone();
					v1465.Parent = l_On_47.Head;
					if l_On_47 == LocalPlayer.Character then
						VFXService.ScreenFlash();
					end;
					VFXService.EmitParticlesInInstance(v1465);
					local l_v1465_0 = v1465 --[[ copy: 3 -> 432 ]];
					task.delay(1.5, function()
						if l_v1465_0 ~= nil and l_v1465_0.Parent ~= nil then
							for _, v1468 in pairs(l_v1465_0:GetDescendants()) do
								if v1468:IsA("ParticleEmitter") then
									v1468.Enabled = false;
								end;
							end;
							task.delay(3, function()
								if l_v1465_0 ~= nil and l_v1465_0.Parent ~= nil then
									l_v1465_0:Destroy();
								end;
							end);
						end;
					end);
				end;
			elseif EffectsType == 'JunAwakeningWalk' then
				for _, v3584 in pairs(LocalPlayer.Character:FindFirstChild('HumanoidRootPart'):GetChildren()) do
					if v3584:IsA("BodyVelocity") then
						v3584:Destroy();
					end;
				end;
				local v3585 = Instance.new("BodyVelocity");
				v3585.Name = "JunAwakeningWalk";
				v3585.Parent = LocalPlayer.Character:FindFirstChild('HumanoidRootPart');
				v3585.MaxForce = Vector3.new(70000, 0, 70000);
				local v3586 = Instance.new("NumberValue");
				v3586.Name = "Magnitude";
				v3586.Parent = v3585;
				v3586.Value = 5;
				local l_v3585_0 = v3585 --[[ copy: 2 -> 152 ]];
				local l_v3586_0 = v3586 --[[ copy: 3 -> 153 ]];
				task.spawn(function()
					while l_v3585_0 ~= nil and l_v3585_0.Parent ~= nil do
						l_v3585_0.Velocity = LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame.LookVector * l_v3586_0.Value;
						task.wait();
					end;
				end);
			elseif EffectsType == 'EndJunAwakeningWalk' then
				for _, v3590 in pairs(LocalPlayer.Character:FindFirstChild('HumanoidRootPart'):GetChildren()) do
					if v3590:IsA("BodyVelocity") then
						if v3590.Name == "JunAwakeningWalk" then
							local l_Magnitude_4 = v3590:FindFirstChild("Magnitude");
							if l_Magnitude_4 ~= nil and l_Magnitude_4.Parent ~= nil then
								local v3592 = Tween:Create(l_Magnitude_4, TweenInfo.new(2.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
									Value = 0
								});
								v3592.Completed:Once(function()
									if v3590 ~= nil and v3590.Parent ~= nil then
										v3590:Destroy();
									end;
								end);
								v3592:Play();
							else
								v3590:Destroy();
							end;
						else
							v3590:Destroy();
						end;
					end;
				end;	
			elseif EffectsType == 'JunAwakeningClones' then
				local l_On_54 = Table.Char;
				if not (l_On_54 ~= nil) or l_On_54.Parent == nil then
					return;
				else
					local l_CFrame_37 = l_On_54.HumanoidRootPart.CFrame;
					local l_RightVector_1 = l_CFrame_37.RightVector;
					local l_LookVector_3 = l_CFrame_37.LookVector;
					local l_Offsets_0 = {
						CFrame.new(-4.25671387, 0.137802124, 11.3141632) * CFrame.Angles(math.rad(-90), 0, 0),
						CFrame.new(-18.1774902, -0.413726807, 10.0332489) * CFrame.Angles(math.rad(-90), 0, 0),
						CFrame.new(21.2697754, 4.62536621, 14.649292) * CFrame.Angles(math.rad(-90), 0, 0),
						CFrame.new(-11.6557617, 10.2836151, 7.51789856) * CFrame.Angles(math.rad(-90), 0, 0),
						CFrame.new(5.89355469, 1.97164154, 8.32743835) * CFrame.Angles(math.rad(-90), 0, 0),
						CFrame.new(20.0505371, -3.78153229, 4.53942871) * CFrame.Angles(math.rad(-90), 0, 0),
						CFrame.new(6.09240723, 10.961525, 11.8075409) * CFrame.Angles(math.rad(-90), 0, 0),
						CFrame.new(9.94726562, -5.77000427, 6.42184448) * CFrame.Angles(math.rad(-90), 0, 0),
						CFrame.new(13.0355225, 7.28090668, 6.12461853) * CFrame.Angles(math.rad(-90), 0, 0),
						CFrame.new(-10.7054443, 2.45313263, 8.10075378) * CFrame.Angles(math.rad(-90), 0, 0),
						CFrame.new(-14.6324463, -6.39580536, 9.36764526) * CFrame.Angles(math.rad(-90), 0, 0),
						CFrame.new(-3.44995117, 7.59837341, 4.86399841) * CFrame.Angles(math.rad(-90), 0, 0),
						CFrame.new(11.7860107, -0.153778076, 2.69755554) * CFrame.Angles(math.rad(-90), 0, 0)	
					};

					local v1574 = l_CFrame_37 + l_RightVector_1 * 4.5 + l_LookVector_3 * 4.5;
					local v1575 = l_CFrame_37 + l_RightVector_1 * -4.5 + l_LookVector_3 * 4.5;
					local v1576 = l_CFrame_37 + l_RightVector_1 * 4.5 + l_LookVector_3 * -4.5;
					local v1577 = l_CFrame_37 + l_RightVector_1 * -4.5 + l_LookVector_3 * -4.5;
					local v1578 = l_CFrame_37 * l_Offsets_0[1];
					local v1579 = l_CFrame_37 * l_Offsets_0[2];
					local v1580 = l_CFrame_37 * l_Offsets_0[3];
					local v1581 = l_CFrame_37 * l_Offsets_0[4];
					local v1582 = l_CFrame_37 * l_Offsets_0[5];
					local v1583 = l_CFrame_37 * l_Offsets_0[6];
					local v1584 = l_CFrame_37 * l_Offsets_0[7];
					local v1585 = l_CFrame_37 * l_Offsets_0[8];
					local v1586 = l_CFrame_37 * l_Offsets_0[9];
					local v1587 = l_CFrame_37 * l_Offsets_0[10];
					local v1588 = l_CFrame_37 * l_Offsets_0[11];
					local v1589 = l_CFrame_37 * l_Offsets_0[12];
					local v1590 = l_CFrame_37 * l_Offsets_0[13];
					local v1591 = {};
					for v1592 = 1, #l_Offsets_0 do
						local v1593 = Instance.new("Attachment");
						v1593.Name = "JunAwakeningAnimationAttachment" .. tostring(l_Tags_1[v1592]);
						v1593.Parent = l_On_54.HumanoidRootPart;
						if v1592 == 1 then
							v1593.WorldCFrame = v1574;
							local v1594 = Instance.new("CFrameValue");
							v1594.Value = l_CFrame_37:ToObjectSpace(v1578);
							v1594.Parent = v1593;
						elseif v1592 == 2 then
							v1593.WorldCFrame = v1575;
							local v1595 = Instance.new("CFrameValue");
							v1595.Value = l_CFrame_37:ToObjectSpace(v1579);
							v1595.Parent = v1593;
						elseif v1592 == 3 then
							v1593.WorldCFrame = v1576;
							local v1596 = Instance.new("CFrameValue");
							v1596.Value = l_CFrame_37:ToObjectSpace(v1580);
							v1596.Parent = v1593;
						elseif v1592 == 4 then
							v1593.WorldCFrame = v1577;
							local v1597 = Instance.new("CFrameValue");
							v1597.Value = l_CFrame_37:ToObjectSpace(v1581);
							v1597.Parent = v1593;
						elseif v1592 == 5 then
							v1593.WorldCFrame = v1582;
						elseif v1592 == 6 then
							v1593.WorldCFrame = v1583;
						elseif v1592 == 7 then
							v1593.WorldCFrame = v1584;
						elseif v1592 == 8 then
							v1593.WorldCFrame = v1585;
						elseif v1592 == 9 then
							v1593.WorldCFrame = v1586;
						elseif v1592 == 10 then
							v1593.WorldCFrame = v1587;
						elseif v1592 == 11 then
							v1593.WorldCFrame = v1588;
						elseif v1592 == 12 then
							v1593.WorldCFrame = v1589;
						elseif v1592 == 13 then
							v1593.WorldCFrame = v1590;
						end;
						table.insert(v1591, v1593);
					end;
					local function v1625(v1598, v1599)
						local v1600 = {};
						local l_face_0 = v1598.Head:FindFirstChild("face");
						local l_Mesh_0 = v1598["Right Arm"]:FindFirstChild("Mesh");
						local l_Mesh_1 = v1598["Left Arm"]:FindFirstChild("Mesh");
						local l_Mesh_2 = v1598["Right Leg"]:FindFirstChild("Mesh");
						local l_Mesh_3 = v1598["Left Leg"]:FindFirstChild("Mesh");
						local l_Mesh_4 = v1598.Torso:FindFirstChild("Mesh");
						local l_Mesh_5 = v1598.Head:FindFirstChild("Mesh");
						local l_Color_0 = v1598["Right Arm"].Color;
						local l_Color_1 = v1598["Left Arm"].Color;
						local l_Color_2 = v1598["Right Leg"].Color;
						local l_Color_3 = v1598["Left Leg"].Color;
						local l_Color_4 = v1598.Head.Color;
						local l_Color_5 = v1598.Torso.Color;
						local v1614 = v1599.Torso.Transparency == 1;
						for _, v1616 in pairs(v1598:GetChildren()) do
							if not (not v1616:IsA("Accessory") and not v1616:IsA("Shirt") and not v1616:IsA("Pants")) or v1616:IsA("CharacterMesh") then
								local v1617 = v1616:Clone();
								if v1614 == true and v1617:IsA("Accessory") then
									v1617.Handle.Transparency = 1;
								end;
								table.insert(v1600, v1617);
							end;
						end;
						for _, v1619 in pairs(v1599:GetChildren()) do
							if not (not v1619:IsA("Accessory") and not v1619:IsA("Shirt") and not v1619:IsA("Pants")) or v1619:IsA("CharacterMesh") then
								v1619:Destroy();
							end;
							if v1619:IsA("BasePart") and v1619.Name ~= "Head" and v1619.Name ~= "Torso" and v1619.Name ~= "Right Arm" and v1619.Name ~= "Left Arm" and v1619.Name ~= "Right Leg" and v1619.Name ~= "Left Leg" and v1619.Name ~= "HumanoidRootPart" then
								v1619:Destroy();
							end;
							if v1619:IsA("Model") then
								v1619:Destroy();
							end;
						end;
						if v1599.Head:FindFirstChild("face") then
							v1599.Head.face:Destroy();
						end;
						if v1599.Head:FindFirstChild("Mesh") then
							v1599.Head.Mesh:Destroy();
						end;
						if v1599.Torso:FindFirstChild("Mesh") then
							v1599.Torso.Mesh:Destroy();
						end;
						if v1599["Right Arm"]:FindFirstChild("Mesh") then
							v1599["Right Arm"].Mesh:Destroy();
						end;
						if v1599["Left Arm"]:FindFirstChild("Mesh") then
							v1599["Left Arm"].Mesh:Destroy();
						end;
						if v1599["Right Leg"]:FindFirstChild("Mesh") then
							v1599["Right Leg"].Mesh:Destroy();
						end;
						if v1599["Left Leg"]:FindFirstChild("Mesh") then
							v1599["Left Leg"].Mesh:Destroy();
						end;
						v1599["Right Arm"].Color = l_Color_0;
						v1599["Left Arm"].Color = l_Color_1;
						v1599["Right Leg"].Color = l_Color_2;
						v1599["Left Leg"].Color = l_Color_3;
						v1599.Head.Color = l_Color_4;
						v1599.Torso.Color = l_Color_5;
						for _, v1621 in pairs(v1600) do
							local v1622 = v1621:Clone();
							if v1622:IsA("Accessory") and v1622:FindFirstChild("Handle") and v1622:FindFirstChild("Handle"):FindFirstChild("AccessoryWeld") then
								local l_Name_3 = v1622.Handle.AccessoryWeld.Part1.Name;
								v1622.Handle.AccessoryWeld.Part0 = v1622.Handle;
								if v1599:FindFirstChild(l_Name_3) then
									v1622.Handle.AccessoryWeld.Part1 = v1599:FindFirstChild(l_Name_3);
								end;
							end;
							v1622.Parent = v1599;
						end;
						if l_face_0 ~= nil and l_face_0.Parent ~= nil then
							local v1624 = l_face_0:Clone();
							if v1614 == true then
								v1624.Transparency = 1;
							end;
							v1624.Parent = v1599.Head;
						end;
						if l_Mesh_5 ~= nil and l_Mesh_5.Parent ~= nil then
							l_Mesh_5:Clone().Parent = v1599.Head;
						end;
						if l_Mesh_4 ~= nil and l_Mesh_4.Parent ~= nil then
							l_Mesh_4:Clone().Parent = v1599.Torso;
						end;
						if l_Mesh_0 ~= nil and l_Mesh_0.Parent ~= nil then
							l_Mesh_0:Clone().Parent = v1599["Right Arm"];
						end;
						if l_Mesh_1 ~= nil and l_Mesh_1.Parent ~= nil then
							l_Mesh_1:Clone().Parent = v1599["Left Arm"];
						end;
						if l_Mesh_2 ~= nil and l_Mesh_2.Parent ~= nil then
							l_Mesh_2:Clone().Parent = v1599["Right Leg"];
						end;
						if l_Mesh_3 ~= nil and l_Mesh_3.Parent ~= nil then
							l_Mesh_3:Clone().Parent = v1599["Left Leg"];
						end;
					end;
					for v1626 = 1, #l_Offsets_0 do
						local v1627 = script.Jun.CloneTemplate:Clone();
						v1627.Name = "JunAwakeningAnimationClone" .. tostring(l_Tags_1[v1626]);
						v1625(l_On_54, v1627);
						local v1628 = nil;
						v1628 = l_On_54.ChildAdded:Connect(function(v1629)
							local l_Name_4 = v1629.Name;
							if v1629.ClassName == "Configuration" and l_Name_4 == "NewHumanoidDescriptionApplied" and l_On_54 ~= nil and l_On_54.Parent ~= nil and v1627 ~= nil and v1627.Parent ~= nil then
								v1625(l_On_54, v1627);
							end;
						end);
						do
							local l_v1628_0 = v1628;
							task.delay(7.5, function()
								if l_v1628_0 ~= nil then
									l_v1628_0:Disconnect();
									l_v1628_0 = nil;
								end;
							end);
							for _, Part in v1627:GetDescendants() do
								if Part:IsA("BasePart") or Part:IsA('Part') then
									Part:SetAttribute("OldTransparency", Part.Transparency);
									Part.Transparency = 1;
									Part.CanCollide = false;
								elseif Part:IsA('Decal') then
									Part:SetAttribute("OldTransparency", Part.Transparency);
									Part.Transparency = 1;
								end;
							end
							--for _, v1633 in pairs(v1627:GetDescendants()) do
							--	if v1633:IsA("BasePart") or v1633:IsA("Part") then
							--		v1633:SetAttribute("OldTransparency", v1633.Transparency);
							--		v1633.Transparency = 1;
							--		v1633.CollisionGroup = "Non-Collidable Characters";
							--		v1633.CanCollide = false;
							--	end;
							--	if v1633:IsA("Decal") then
							--		v1633:SetAttribute("OldTransparency", v1633.Transparency);
							--		v1633.Transparency = 1;
							--	end;
							--end;
							local v1634 = Instance.new("RigidConstraint");
							v1634.Parent = v1627;
							v1634.Attachment0 = v1627.HumanoidRootPart.RootAttachment;
							v1627.Parent = l_VFX_0;
							v1634.Attachment1 = v1591[v1626];
						end;
					end;
					v1591 = nil;
				end;
			elseif EffectsType == 'JunAwakeningFireSound' then
				local l_On_53 = Character;
				if not (l_On_53 ~= nil) or l_On_53.Parent == nil then
					return;
				else
					v104.PlaySoundInInstance(l_On_53.HumanoidRootPart, "Firing");
				end;
			elseif EffectsType == 'JunAwakeningCloneSound' then
				local l_On_52 = Character;
				if not (l_On_52 ~= nil) or l_On_52.Parent == nil then
					return;
				else
					v104.PlaySoundInInstance(l_On_52.HumanoidRootPart, "CloneSpawn");
					v104.PlaySoundInInstance(l_On_52.HumanoidRootPart, "CloneSpawnidk");
				end;
			elseif EffectsType == 'JunAwakeningFire' then
				local l_On_48 = Character;
				if not (l_On_48 ~= nil) or l_On_48.Parent == nil then
					return;
				else
					local l_T_1 = Table.T;
					warn((l_T_1))
					local v1500 = CFrame.new(l_On_48.HumanoidRootPart.Position, l_T_1.Position);
					local v1501 = script.Jun.Awakening.ShootUser:Clone();
					v1501.CFrame = v1500;
					v1501.Parent = l_VFX_0;
					VFXService.EmitParticlesInInstance(v1501);
					v104.PlaySoundInInstance(l_On_48.HumanoidRootPart, "Launch");
					VFXService.DestroyParticleContainer(v1501, 3.5);
				end;
			elseif EffectsType == 'JunAwakeningFireClone' then
				local l_On_49 = Character;
				if not (l_On_49 ~= nil) or l_On_49.Parent == nil then
					return;
				else
					local v1503 = tostring(Table.Tag);
					local l_T_2 = Table.T;
					local l_F_2 = Table.F;
					local l_N_1 = Table.N;
					local v1507 = nil;
					for _, v1509 in pairs(l_VFX_0:GetChildren()) do
						if v1509.Name == "JunAwakeningAnimationClone" .. v1503 then
							v1507 = v1509;
							for _, v1511 in pairs(v1507:GetDescendants()) do
								if v1511:IsA("RigidConstraint") then
									v1511:Destroy();
									v1507.HumanoidRootPart.Anchored = true;
								end;
							end;
							break;
						end;
					end;
					do
						local l_v1507_0 = v1507;
						if l_v1507_0 ~= nil and l_v1507_0.Parent ~= nil then
							local v1513 = nil;
							for _, v1515 in pairs(l_On_49.HumanoidRootPart:GetChildren()) do
								if v1515.Name == "JunAwakeningAnimationAttachment" .. v1503 then
									v1513 = v1515;
									break;
								end;
							end;
							local v1516 = Vector3.new(0, 1, 0);
							if v1513 ~= nil and v1513.Parent ~= nil then
								v1513:Destroy();
								local v1517 = CFrame.new(l_v1507_0.HumanoidRootPart.Position, l_F_2.Position);
								l_v1507_0.HumanoidRootPart.CFrame = v1517 * CFrame.Angles(-math.pi / 2, 0, 0);
								local v1518 = Tween:Create(l_v1507_0.HumanoidRootPart, TweenInfo.new(l_T_2, Enum.EasingStyle.Linear), {
									CFrame = l_F_2
								});
								local l_l_N_1_0 = l_N_1 --[[ copy: 6 -> 426 ]];
								local l_v1516_0 = v1516 --[[ copy: 9 -> 427 ]];
								local l_l_F_2_0 = l_F_2 --[[ copy: 5 -> 428 ]];
								local l_l_On_49_0 = l_On_49 --[[ copy: 2 -> 429 ]];
								v1518.Completed:Once(function()
									local v1523 = script.Jun.Awakening.CloneHit:Clone();
									v1523.Parent = l_VFX_0;
									if typeof(l_l_N_1_0) == "Vector3" then
										local v1524 = {};
										local v1525 = "CloneCrater" .. tostring(math.random(1, 4));
										if l_l_N_1_0 == l_v1516_0 then
											v1523.CFrame = l_l_F_2_0;
											local v1526 = {};
											local v1527 = CFrame.new(l_l_F_2_0.Position, l_l_F_2_0.Position + l_v1516_0) + l_v1516_0;
											VFXService.GetCircularRocksProperties(v1524, v1527 * CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
												12, 
												16
											}, 5, {
												6, 
												10
											}, {
												2.5, 
												3.5
											}, {
												2.5, 
												3.5
											}, {
												-5, 
												5
											}, {
												-5, 
												5
											}, {
												-5, 
												5
											}, {
												"Grow", 
												"Sink"
											}, 2.5, false, {
												IncludeDuplicate = true
											});
											VFXService.GetCircularRocksProperties(v1524, v1527 * CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
												12, 
												16
											}, 4, {
												6, 
												8
											}, {
												1.25, 
												3.5
											}, {
												1.25, 
												3.5
											}, {
												-5, 
												5
											}, {
												-5, 
												5
											}, {
												-5, 
												5
											}, {
												"Grow", 
												"Sink"
											}, 2.5, false, {
												IncludeDuplicate = true
											});
											VFXService.GetCircularRocksProperties(v1524, v1527 * CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
												7, 
												12
											}, 3, {
												4, 
												5
											}, {
												1.25, 
												1.75
											}, {
												1.25, 
												1.75
											}, {
												-5, 
												5
											}, {
												-5, 
												5
											}, {
												-5, 
												5
											}, {
												"Grow", 
												"Sink"
											}, 2.5, false, {
												IncludeDuplicate = true
											});
											VFXService.GetCircularRocksProperties(v1524, v1527 * CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
												7, 
												12
											}, 3, {
												4, 
												5
											}, {
												1.25, 
												1.75
											}, {
												1.25, 
												1.75
											}, {
												-5, 
												5
											}, {
												-5, 
												5
											}, {
												-5, 
												5
											}, {
												"Grow", 
												"Sink"
											}, 2.5, false, {
												IncludeDuplicate = true
											});
											VFXService.GetCircularRocksProperties(v1524, v1527, {
												4, 
												9
											}, math.random(4, 5), {
												2, 
												4.5
											}, {
												0.65, 
												1
											}, {
												1, 
												1.5
											}, {
												-5, 
												5
											}, {
												-5, 
												5
											}, {
												-5, 
												5
											}, {
												"Grow", 
												"Sink"
											}, 5, false, {
												IncludeDuplicate = true
											});
											VFXService.GetCircularRocksProperties(v1524, v1527 * CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
												4, 
												9
											}, math.random(4, 5), {
												3, 
												4
											}, {
												1, 
												1.5
											}, {
												1.75, 
												2.25
											}, {
												-5, 
												5
											}, {
												-5, 
												5
											}, {
												-5, 
												5
											}, {
												"Grow", 
												"Sink"
											}, 2.5, false, {
												IncludeDuplicate = true
											});
											VFXService.GetFlyingRocksProperties(v1526, v1527, 1, {
												10, 
												90
											}, {
												70, 
												70
											}, {
												10, 
												90
											}, 1.5, 1.5, 1.5, nil, 2);
											VFXService.GetFlyingRocksProperties(v1526, v1527, 1, {
												10, 
												90
											}, {
												70, 
												70
											}, {
												10, 
												90
											}, 1.7, 1.7, 1.7, nil, 2);
											VFXService.GetFlyingRocksProperties(v1526, v1527, 1, {
												10, 
												90
											}, {
												70, 
												70
											}, {
												10, 
												90
											}, 1.2, 1.2, 1.2, nil, 2);
											VFXService.GetFlyingRocksProperties(v1526, v1527, 1, {
												10, 
												90
											}, {
												70, 
												70
											}, {
												10, 
												90
											}, 0.8, 0.8, 0.8, nil, 2);
											VFXService.GetFlyingRocksProperties(v1526, v1527, 1, {
												10, 
												90
											}, {
												70, 
												70
											}, {
												10, 
												90
											}, 1.6, 1.6, 1.6, nil, 2);
											VFXService.ApplyFlyingRocksProperties(v1526);
											local v1528 = VFXService.GetTile(v1527.Position + Vector3.new(0, 2, 0));
											VFXService.DestroyTile(v1528);
										else
											local v1529 = CFrame.new(l_l_F_2_0.Position, l_l_F_2_0.Position + l_l_N_1_0);
											v1523.CFrame = v1529;
											local v1530 = v1529 * CFrame.Angles(-math.pi / 2, 0, 0);
											VFXService.GetCircularWallRocksProperties(v1524, v1530 * CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
												12, 
												16
											}, 7, {
												6, 
												10
											}, {
												2.5, 
												3.5
											}, {
												2.5, 
												3.5
											}, {
												-5, 
												5
											}, {
												-5, 
												5
											}, {
												-5, 
												5
											}, {
												"Grow", 
												"Sink"
											}, 2.5, false, {
												IncludeDuplicate = true
											});
											VFXService.GetCircularWallRocksProperties(v1524, v1530 * CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
												12, 
												16
											}, 7, {
												6, 
												8
											}, {
												1.25, 
												3.5
											}, {
												1.25, 
												3.5
											}, {
												-5, 
												5
											}, {
												-5, 
												5
											}, {
												-5, 
												5
											}, {
												"Grow", 
												"Sink"
											}, 2.5, false, {
												IncludeDuplicate = true
											});
											VFXService.GetCircularWallRocksProperties(v1524, v1530 * CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
												7, 
												12
											}, 5, {
												4, 
												5
											}, {
												1.25, 
												1.75
											}, {
												1.25, 
												1.75
											}, {
												-5, 
												5
											}, {
												-5, 
												5
											}, {
												-5, 
												5
											}, {
												"Grow", 
												"Sink"
											}, 2.5, false, {
												IncludeDuplicate = true
											});
											VFXService.GetCircularWallRocksProperties(v1524, v1530 * CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
												7, 
												12
											}, 5, {
												4, 
												5
											}, {
												1.25, 
												1.75
											}, {
												1.25, 
												1.75
											}, {
												-5, 
												5
											}, {
												-5, 
												5
											}, {
												-5, 
												5
											}, {
												"Grow", 
												"Sink"
											}, 2.5, false, {
												IncludeDuplicate = true
											});
											VFXService.GetCircularWallRocksProperties(v1524, v1530, {
												4, 
												9
											}, math.random(6, 8), {
												2, 
												4.5
											}, {
												0.65, 
												1
											}, {
												1, 
												1.5
											}, {
												-5, 
												5
											}, {
												-5, 
												5
											}, {
												-5, 
												5
											}, {
												"Grow", 
												"Sink"
											}, 5, false, {
												IncludeDuplicate = true
											});
											VFXService.GetCircularWallRocksProperties(v1524, v1530 * CFrame.Angles(0, VFXService.GetRandomAngle(), 0), {
												4, 
												9
											}, math.random(6, 8), {
												3, 
												4
											}, {
												1, 
												1.5
											}, {
												1.75, 
												2.25
											}, {
												-5, 
												5
											}, {
												-5, 
												5
											}, {
												-5, 
												5
											}, {
												"Grow", 
												"Sink"
											}, 2.5, false, {
												IncludeDuplicate = true
											});
										end;
										v104.PlaySoundAtCFrame(l_l_F_2_0, v1525);
										VFXService.ApplyCircularRocksProperties(v1524);
									else
										v1523.CFrame = l_l_F_2_0;
									end;
									VFXService.EmitParticlesInInstance(v1523);
									if l_v1507_0 ~= nil and l_v1507_0.Parent ~= nil then
										l_v1507_0:Destroy();
									end;
									VFXService.DestroyParticleContainer(v1523, 5);
									if not (l_l_On_49_0 ~= LocalPlayer.Character) or (LocalPlayer.Character:WaitForChild('HumanoidRootPart').Position - l_l_F_2_0.Position).Magnitude <= 30 then
										VFXService.ShakeCamera(0, 0.5, 15, 0.3, 0.3, 0.3);
									end;
								end);
								v1518:Play();
								local v1531 = script.Jun.Awakening.ShootClone:Clone();
								v1531.CFrame = v1517;
								v1531.Parent = l_VFX_0;
								VFXService.EmitParticlesInInstance(v1531);
								VFXService.DestroyParticleContainer(v1531, 2);
								local startTime = tick()
								local startPivot = HumRP.CFrame

								local LookVector = Camera.CFrame.LookVector
								local goalCF = CFrame.lookAlong(HumRP.CFrame.Position, LookVector)
								local pastTime = tick() - startTime

								if pastTime < 0.57 then
									HumRP.CFrame = HumRP.CFrame:Lerp(goalCF, (TS:GetValue(pastTime / 0.57, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)))
								else
									HumRP.CFrame = goalCF
								end
							else
								l_v1507_0:Destroy();
							end;
						end;
					end;
				end;
			elseif EffectsType == 'JunAwakeningFirst4' then
				local l_On_50 = Character;
				if not (l_On_50 ~= nil) or l_On_50.Parent == nil then
					return;
				else
					local l_Tags_0 = Table.Tags;
					local v1534 = TweenInfo.new(1,Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
					for v1535 = 1, 4 do
						local v1536 = tostring(l_Tags_0[v1535]);
						for _, v1538 in pairs(l_On_50.HumanoidRootPart:GetChildren()) do
							if v1538.Name == "JunAwakeningAnimationAttachment" .. v1536 then
								Tween:Create(v1538, v1534, {
									CFrame = v1538:FindFirstChildOfClass("CFrameValue").Value 
								}):Play();
							end;
						end;
					end;
					local l_CFrame_35 = l_On_50.HumanoidRootPart.CFrame;
					local v1540 = VFXService.FindGroundPosition(l_CFrame_35.Position, 30);
					local v1541 = VFXService.GetTile(l_CFrame_35.Position);
					if v1540 then
						local v1542 = script.Jun.Awakening.Jump:Clone();
						local v1543 = v1540.Position + Vector3.new(0, 0.048, 0);
						v1542.CFrame = CFrame.new(v1543, v1543 + l_CFrame_35.LookVector);
						v1542.Parent = l_VFX_0;
						VFXService.EmitParticlesInInstance(v1542);
						VFXService.DestroyTile(v1541);
						VFXService.DestroyParticleContainer(v1542, 5.3);
						if not (l_On_50 ~= LocalPlayer.Character) or ( LocalPlayer.Character:WaitForChild('HumanoidRootPart').Position - l_On_50.HumanoidRootPart.Position).Magnitude <= 25 then
							VFXService.ShakeCamera(0, 0.3, 20, 0.2, 0.2, 0.2);
						end;
					end;
				end;
			elseif EffectsType == 'JunAwakeningRevealClone' then
				local v1553 = tostring(Table.Tag);
				local l_S_0 = Table.S;

				local v1555 = nil;
				for _, v1557 in pairs(l_VFX_0:GetChildren()) do
					if v1557.Name == "JunAwakeningAnimationClone" .. v1553 then
						v1555 = v1557;
						break;
					end;
				end;
				if v1555 ~= nil and v1555.Parent ~= nil then
					if typeof(l_S_0) == "number" then
						local v1558 = Instance.new("Animation");
						if l_S_0 == 1 then
							v1558.AnimationId = "rbxassetid://93574701995143";
							v104.PlaySoundInInstance(v1555.HumanoidRootPart, "CloneSpawn1");
						elseif l_S_0 == 2 then
							v1558.AnimationId = "rbxassetid://116116015584557";
							v104.PlaySoundInInstance(v1555.HumanoidRootPart, "CloneSpawn2");
						elseif l_S_0 == 3 then
							v1558.AnimationId = "rbxassetid://112475843405480";
							v104.PlaySoundInInstance(v1555.HumanoidRootPart, "CloneSpawn3");
						elseif l_S_0 == 4 then
							v1558.AnimationId = "rbxassetid://135029379700756";
							v104.PlaySoundInInstance(v1555.HumanoidRootPart, "CloneSpawn4");
						end;
						local v1559 = v1555.Humanoid.Animator:LoadAnimation(v1558);
						v1558:Destroy();
						v1559.Priority = Enum.AnimationPriority.Action4;
						local v1560 = Instance.new("Animation");
						v1560.AnimationId = "rbxassetid://99983150540716";
						local v1561 = v1555.Humanoid.Animator:LoadAnimation(v1560);
						v1561.Priority = Enum.AnimationPriority.Action4;
						local l_v1561_0 = v1561 --[[ copy: 8 -> 425 ]];
						v1559.Stopped:Connect(function()
							if l_v1561_0 ~= nil then
								l_v1561_0:Play();
							end;
						end);
						v1559:Play(0);
					else
						local v1563 = Instance.new("Animation");
						v1563.AnimationId = "rbxassetid://99983150540716";
						local v1564 = v1555.Humanoid.Animator:LoadAnimation(v1563);
						v1564.Priority = Enum.AnimationPriority.Action4;
						v1564:Play(0);



					end;
					local v1565 = script.Jun.Awakening.CloneSpawn:Clone();
					v1565.CFrame = v1555.HumanoidRootPart.CFrame;
					v1565.Parent = l_VFX_0;


					VFXService.EmitParticlesInInstance(v1565);
					for _, v1567 in pairs(v1555:GetDescendants()) do
						if v1567:IsA("Decal") then
							v1567.Transparency = v1567:GetAttribute("OldTransparency") or 0;
						end;
						if v1567:IsA("BasePart") then
							v1567.Transparency = v1567:GetAttribute("OldTransparency") or 0;
						end;
					end;
					VFXService.DestroyParticleContainer(v1565, 1);
				end;
			elseif EffectsType == 'JunAwakeningFaceCameraDirection' then
				local v1637 = nil;
				local v1638 = nil;
				do
					local l_v1637_0, l_v1638_0 = v1637, v1638;
					l_v1637_0 = task.spawn(function()
						local l_R_0 = Table.R;
						local v1642 = CFrame.new(l_R_0);
						local l_v26_2 = Table.Char;
						local HumRP : BasePart = l_v26_2.HumanoidRootPart
						--local l_l_v26_2_Pivot_0 = HumRP.CFrame
						local v1645 = os.clock();
						while true do
							if l_v26_2 ~= nil and l_v26_2.Parent ~= nil then
								local l_LookVector_4 = workspace.CurrentCamera.CFrame.LookVector;
								local v1647 = nil;
								v1647 = if l_LookVector_4 ~= Vector3.zero then CFrame.new(l_R_0, l_R_0 + l_LookVector_4) else v1642;
								local v1648 = os.clock() - v1645;
								if v1648 < 0.57 then
									HumRP.CFrame = HumRP.CFrame:Lerp(v1647, (Tween:GetValue(v1648 / 0.57, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)));
									task.wait();
								else
									l_v1638_0 = task.spawn(function()
										while l_v26_2 ~= nil and l_v26_2.Parent ~= nil do
											local l_LookVector_5 = workspace.CurrentCamera.CFrame.LookVector;
											if l_LookVector_5 ~= Vector3.zero then
												HumRP.CFrame = CFrame.new(l_R_0, l_R_0 + l_LookVector_5)
											else
												HumRP.CFrame = v1642
											end;
											task.wait();
										end;
									end);
									return;
								end;
							else
								return;
							end;
						end;
					end);
					VFXService.CreateBind(LocalPlayer.Character, "JunAwakeningFaceCameraDirection", function()
						pcall(function()
							task.cancel(l_v1637_0);
						end);
						pcall(function()
							task.cancel(l_v1638_0);
						end);
					end);
				end;
			elseif EffectsType == 'EndJunAwakeningFaceCameraDirection' then
				VFXService.DestroyBind(LocalPlayer.Character, "JunAwakeningFaceCameraDirection");
				LocalPlayer.Character:FindFirstChild('JunAwakeningBodyPosition'):Destroy()
			elseif EffectsType == 'JunAwakeningLastKick' then 
				local v1469 = Table.At + Table.At.LookVector;
				local v1470 = {};
				local v1471 = {};
				local v1472 = VFXService.GetRandomAngle();
				local v1473 = VFXService.FindGroundPosition(v1469.Position + Vector3.new(0, 3, 0), 15);
				local v1474 = VFXService.GetTile(v1469.Position + Vector3.new(0, 1, 0));
				VFXService.GetCircularRocksProperties(v1470, v1469 * CFrame.Angles(0, v1472, 0), {
					30, 
					38
				}, 6, {
					23, 
					30
				}, {
					5, 
					7
				}, {
					5, 
					7
				}, {
					0, 
					0
				}, {
					0, 
					0
				}, {
					0, 
					0
				}, {
					"Grow", 
					"Shrink", 
					nil, 
					4
				}, 5, false, {
					IncludeDuplicate = true
				}, nil, {
					-3, 
					3
				}, {
					0.05, 
					0.075
				}, {
					4, 
					9
				});
				VFXService.GetCircularRocksProperties(v1470, v1469 * CFrame.Angles(0, v1472 + math.pi / 4, 0), {
					30, 
					38
				}, 6, {
					23, 
					30
				}, {
					7, 
					9
				}, {
					7, 
					9
				}, {
					0, 
					0
				}, {
					0, 
					0
				}, {
					0, 
					0
				}, {
					"Grow", 
					"Shrink", 
					nil, 
					4
				}, 5, false, {
					IncludeDuplicate = false
				}, nil, {
					-3, 
					3
				}, {
					0.05, 
					0.075
				}, {
					-7.5, 
					6.5
				});
				VFXService.GetCircularRocksProperties(v1470, v1469 * CFrame.Angles(0, v1472, 0), {
					20, 
					32
				}, 6, {
					13, 
					17
				}, {
					3, 
					5
				}, {
					3, 
					5
				}, {
					0, 
					0
				}, {
					0, 
					0
				}, {
					0, 
					0
				}, {
					"Grow", 
					"Shrink", 
					nil, 
					4
				}, 5, false, {
					IncludeDuplicate = true
				}, nil, {
					-3, 
					3
				}, {
					0.05, 
					0.075
				}, {
					2, 
					5
				});
				VFXService.GetCircularRocksProperties(v1470, v1469 * CFrame.Angles(0, v1472, 0), {
					20, 
					32
				}, 6, {
					13, 
					17
				}, {
					3, 
					5
				}, {
					3, 
					5
				}, {
					0, 
					0
				}, {
					0, 
					0
				}, {
					0, 
					0
				}, {
					"Grow", 
					"Shrink", 
					nil, 
					4
				}, 5, false, {
					IncludeDuplicate = true
				}, nil, {
					-3, 
					3
				}, {
					0.05, 
					0.075
				}, {
					-5, 
					5
				});
				VFXService.GetCircularRocksProperties(v1470, v1469 * CFrame.Angles(0, v1472, 0), {
					15, 
					21
				}, 5, {
					9, 
					11.5
				}, {
					2, 
					2.25
				}, {
					2, 
					2.25
				}, {
					-3, 
					3
				}, {
					-3, 
					3
				}, {
					-3, 
					3
				}, {
					"Grow", 
					"Shrink", 
					nil, 
					4
				}, 5, false, {
					IncludeDuplicate = true
				});
				VFXService.GetCircularRocksProperties(v1470, v1469 * CFrame.Angles(0, v1472 + math.pi / 4, 0), {
					15, 
					21
				}, 5, {
					11, 
					13.5
				}, {
					2, 
					3
				}, {
					2, 
					3
				}, {
					-3, 
					3
				}, {
					-3, 
					3
				}, {
					-3, 
					3
				}, {
					"Grow", 
					"Shrink", 
					nil, 
					4
				}, 5, false, {
					IncludeDuplicate = true
				});
				VFXService.GetFlyingRocksProperties(v1471, v1469, math.random(5, 6), {
					10, 
					130
				}, {
					115, 
					115
				}, {
					10, 
					130
				}, 3, 3, 3, 3, 1);
				VFXService.GetFlyingRocksProperties(v1471, v1469, math.random(3, 4), {
					10, 
					130
				}, {
					115, 
					115
				}, {
					10, 
					130
				}, 4, 4, 4, 3, 1);
				VFXService.GetFlyingRocksProperties(v1471, v1469, math.random(4, 5), {
					10, 
					130
				}, {
					115, 
					115
				}, {
					10, 
					130
				}, 2, 2, 2, 3, 1);
				VFXService.GetFlyingRocksProperties(v1471, v1469, math.random(4, 6), {
					10, 
					130
				}, {
					115, 
					115
				}, {
					10, 
					130
				}, 4, 4, 4, 3, 1);
				if v1473 then
					local v1475 = script.Jun.Awakening.FinalKick:Clone();
					local v1476 = CFrame.new(v1473.Position, v1473.Position + v1469.LookVector);
					v1475.CFrame = v1476 + Vector3.new(0, 0.5, 0);
					local v1477 = script.Jun.Awakening.MeshCombination:Clone();
					v1477:PivotTo(v1476 * CFrame.Angles(math.pi, 0, 0) + Vector3.new(0, 11, 0));
					local l_3_0 = v1477["3"];
					local l_Wind1_0 = v1477.Wind1;
					local l_BeanWind_1 = v1477.BeanWind;
					local l_GroundShockwave1_0 = v1477.GroundShockwave1;
					local l_Wind2_0 = v1477.Wind2;
					local v1483 = TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
					local v1484 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
					local v1485 = Tween:Create(l_3_0, TweenInfo.new(0.7, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
						Size = l_3_0.Size + Vector3.new(70, 0, 70), 
						Transparency = 1, 
						CFrame = l_3_0.CFrame * CFrame.Angles(0, math.pi, 0)
					});
					local v1486 = Tween:Create(l_Wind1_0, TweenInfo.new(0.55, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
						Size = l_Wind1_0.Size + Vector3.new(50, 1.6, 50), 
						Transparency = 1, 
						Position = l_Wind1_0.Position + Vector3.new(0, 25, 0)
					});
					local v1487 = Tween:Create(l_BeanWind_1, v1483, {
						Orientation = l_BeanWind_1.Orientation + Vector3.new(0, 360, 0), 
						Transparency = 1
					});
					local v1488 = Tween:Create(l_BeanWind_1.Mesh, v1483, {
						Scale = l_BeanWind_1.Mesh.Scale * 2
					});
					local v1489 = Tween:Create(l_GroundShockwave1_0, v1484, {
						Position = l_GroundShockwave1_0.Position - Vector3.new(0, 10, 0)
					});
					local v1490 = Tween:Create(l_GroundShockwave1_0.Mesh, v1484, {
						Scale = l_GroundShockwave1_0.Mesh.Scale + Vector3.new(30, -40, 30)
					});
					local v1491 = Tween:Create(l_GroundShockwave1_0.Decal, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
						Transparency = 1
					});
					local v1492 = Tween:Create(l_Wind2_0, v1484, {
						Position = l_Wind2_0.Position - Vector3.new(0, 15, 0), 
						Transparency = 1
					});
					local v1493 = Tween:Create(l_Wind2_0.Mesh, v1484, {
						Scale = Vector3.new(0.816, 2.577, 2.577)
					});
					v1477.Parent = l_VFX_0;
					v1475.Parent = l_VFX_0;
					local l_l_BeanWind_1_0 = l_BeanWind_1 --[[ copy: 13 -> 430 ]];
					task.spawn(function()
						for v1495 = 1, 11 do
							if l_l_BeanWind_1_0 ~= nil and l_l_BeanWind_1_0.Parent ~= nil then
								local l_FirstChild_1 = l_l_BeanWind_1_0.Flip:FindFirstChild(tostring(v1495));
								if l_FirstChild_1 ~= nil and l_FirstChild_1.Parent ~= nil then
									l_l_BeanWind_1_0.Mesh.TextureId = l_FirstChild_1.Texture;
									task.wait(0.1);
								else
									break;
								end;
							else
								break;
							end;
						end;
					end);
					local l_v1477_0 = v1477 --[[ copy: 10 -> 431 ]];
					v1491.Completed:Once(function()
						if l_v1477_0 ~= nil and l_v1477_0.Parent ~= nil then
							l_v1477_0:Destroy();
						end;
					end);
					v104.PlaySoundAtCFrame(v1476, "FinalKick");
					VFXService.EmitParticlesInInstance(v1475);
					v1485:Play();
					v1486:Play();
					v1487:Play();
					v1488:Play();
					v1489:Play();
					v1490:Play();
					v1491:Play();
					v1492:Play();
					v1493:Play();
					VFXService.DestroyParticleContainer(v1475, 5.5);
				end;
				VFXService.ApplyCircularRocksProperties(v1470);
				VFXService.ApplyFlyingRocksProperties(v1471);
				VFXService.DestroyTile(v1474);
				if (v1469.Position - LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position).Magnitude <= 60 then
					VFXService.ShakeCamera(0, 0.55, 49, 0.9, 0.9, 0.6);
				end;
			elseif EffectsType == 'JunAwakeningCutscene' then
				--VFXService.EndCameraShake();
				local Cam = VFXService.InitiateCutscene("JunAwakeningAnimation", 60, 77836983068298, LocalPlayer.Character:WaitForChild('HumanoidRootPart'), CFrame.new(0, -3, 0), {
					Time = 1
				}, nil, nil, nil, false);
				local v1458 = script.Jun.Awakening.SmokeBehind:Clone();
				local v1459 = Instance.new("WeldConstraint");
				v1459.Parent = v1458;
				v1459.Part0 = LocalPlayer.Character:WaitForChild('HumanoidRootPart');
				v1458.CFrame = LocalPlayer.Character:WaitForChild('HumanoidRootPart').CFrame * CFrame.new(0.02734375, 1.483675, 6.4, 1.00000167, 0, 0, 0, 1.00000167, 0, 0, 0, 1);
				v1458.Parent = l_VFX_0;
				v1459.Part1 = v1458;
				local l_v1459_0 = v1459 --[[ copy: 5 -> 433 ]];
				local l_v1458_0 = v1458 --[[ copy: 4 -> 434 ]];
				task.delay(1.2, function()
					if l_v1459_0 ~= nil and l_v1459_0.Parent ~= nil then
						l_v1459_0:Destroy();
					end;
					if l_v1458_0 ~= nil and l_v1458_0.Parent ~= nil then
						l_v1458_0.Anchored = true;
						for _, v1463 in pairs(l_v1458_0:GetDescendants()) do
							if v1463:IsA("ParticleEmitter") then
								v1463.Enabled = false;
							end;
						end;
						task.delay(5.6, function()
							if l_v1458_0 ~= nil and l_v1458_0.Parent ~= nil then
								l_v1458_0:Destroy();
							end;
						end);
					end;
				end);
				task.delay(6.9, function()
					if l_v1458_0 ~= nil and l_v1458_0.Parent ~= nil then
						l_v1458_0:Destroy();
					end;
				end);
			end	

		elseif Awk == "Okarun" then
			if Stage == "Start" then
				local l_HumanoidRootPart_4 = Params.Char.HumanoidRootPart;
				local v169 = Trova.new()
				v169:AttachToInstance(Params.Char);
				v169:Add(Params.Char:GetAttributeChangedSignal("Awakened"):Connect(function() --[[ Line: 541 ]]
					if not Params.Char:GetAttribute("Awakened") then
						v169:Destroy();
					end;
				end));		

				task.delay(3, function() --[[ Line: 547 ]]
					for _ = 1, 3 do
						CameraShake(5, 0.5, 1, {
							l_HumanoidRootPart_4, 
							15
						});
						Emit(Params.Char.Torso, script.Okarun.C, 3, CFrame.new(0, 0.8, 0));
						task.wait(0.1);
					end;
					CameraShake(5, 0.5, 1, {
						l_HumanoidRootPart_4, 
						15
					});
					local v171 = script.Okarun.random:Clone();
					v171.Parent = Params.Char;
					local l_Weld_7 = Instance.new("Weld");
					l_Weld_7.Part0 = Params.Char.Torso;
					l_Weld_7.Part1 = v171;
					l_Weld_7.Parent = v171;
					l_Weld_7.C0 = CFrame.Angles(0, -1.5707963267948966, 0);
					local v173 = script.Okarun["Plane.005"]:Clone();
					v173.Parent = Params.Char;
					v173.Weld.Part0 = Params.Char.Head;
					v169:Add(v171);
					v169:Add(v173);
				end);
				task.delay(5.5, function() --[[ Line: 575 ]]
					local l_CFrame_0 = l_HumanoidRootPart_4.CFrame;
					Emit(l_HumanoidRootPart_4, script.Okarun.Spin, 4, CFrame.new(Vector3.yAxis * -3));
					local v175 = LinearVelocity(l_HumanoidRootPart_4, Vector3.zAxis * -200, 1.5, {
						1.5, 
						Enum.EasingStyle.Quint, 
						Enum.EasingDirection.Out
					}, {
						VectorVelocity = Vector3.zAxis * -100
					});
					task.spawn(function() --[[ Line: 580 ]]
						for _ = 1, 3 do
							local v177 = script.Okarun.M5:Clone();
							v177.Parent = workspace.Effects;
							v177:PivotTo(l_CFrame_0 * CFrame.Angles(math.rad((Random.new():NextInteger(-15, 15))), 0, (math.rad((Random.new():NextInteger(-15, 15))))));
							Debris:AddItem(v177, 3);
							local l_Start_0 = v177:FindFirstChild("Start");
							local l_End_0 = v177:FindFirstChild("End");
							local v180 = 0;
							local l_CFrame_1 = l_Start_0.CFrame;
							local l_Color_0 = l_Start_0.Color;
							local v183 = nil;
							if l_Start_0:FindFirstChild("SpecialMesh") then
								v180 = l_Start_0.Mesh.Scale;
							end;
							if l_Start_0:FindFirstChild("Decal") then
								v183 = l_Start_0.Decal.Color3;
							end;
							l_End_0.Transparency = 1;
							if l_End_0:FindFirstChild("Decal") then
								l_End_0:FindFirstChild("Decal").Transparency = 1;
							end;
							TS:Create(l_Start_0, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
								Size = l_End_0.Size, 
								CFrame = l_End_0.CFrame, 
								Color = l_End_0.Color, 
								Transparency = l_End_0.Transparency
							}):Play();
							for _, v185 in pairs(l_Start_0:GetChildren()) do
								if v185:IsA("SpecialMesh") then
									local l_Mesh_0 = l_End_0.Mesh;
									TS:Create(v185, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
										Scale = l_Mesh_0.Scale
									}):Play();
								elseif v185:IsA("Decal") and l_End_0:FindFirstChildWhichIsA("Decal") then
									local l_Decal_0 = l_End_0.Decal;
									TS:Create(v185, TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
										Transparency = l_Decal_0.Transparency, 
										Color3 = l_Decal_0.Color3
									}):Play();
								end;
							end;
							do
								local l_v183_0 = v183;
								task.delay(0.7, function() --[[ Line: 621 ]]
									l_End_0.Transparency = 1;
									l_Start_0.Transparency = 1;
									if l_End_0:FindFirstChild("Decal") then
										l_End_0:FindFirstChild("Decal").Transparency = 1;
									end;
									if l_Start_0:FindFirstChild("Decal") then
										l_Start_0:FindFirstChild("Decal").Transparency = 1;
									end;
									task.wait(0);
									l_Start_0.Transparency = 0.8;
									l_Start_0.CFrame = l_CFrame_1;
									l_Start_0.Color = l_Color_0;
									l_Start_0.Size = Vector3.new(0.0010000000474974513, 22.805999755859375, 0.0010000000474974513, 0);
									if l_Start_0:FindFirstChild("Decal") then
										l_Start_0:FindFirstChild("Decal").Transparency = 0.8;
										l_Start_0.Decal.Color3 = l_v183_0;
									end;
									for _, v190 in pairs(l_Start_0:GetChildren()) do
										if v190:IsA("SpecialMesh") then
											l_Start_0.Mesh.Scale = Vector3.new(0, 0, 0, 0);
										end;
									end;
								end);
								task.wait(0.1);
							end;
						end;
					end);
					task.wait(1.5);
					v175:Destroy();
					LinearVelocity(l_HumanoidRootPart_4, Vector3.zAxis * -130, 2, {
						2, 
						Enum.EasingStyle.Quint, 
						Enum.EasingDirection.Out
					}, {
						VectorVelocity = Vector3.zero
					});
				end);
				task.delay(7.2, function() --[[ Line: 658 ]]
					if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(Params.Char) then
						return;
					else
						cutscene(RS.Modules.CameraHandler.Animations.OkarunCutscene,nil, l_HumanoidRootPart_4, nil, RS.Assets.Cutscenes.ultimateFOV);
						return;
					end;
				end);
				task.delay(8, function() --[[ Line: 662 ]]
					EmitRaycast(l_HumanoidRootPart_4, script.Okarun.landair, 3, Vector3.yAxis * -5);
				end);
				task.delay(9, function() --[[ Line: 665 ]]
					local v191 = script.Okarun.Emit["2"]:Clone();
					v191.Parent = Params.Char;
					local l_Weld_8 = Instance.new("Weld");
					l_Weld_8.Part0 = Params.Char.Head;
					l_Weld_8.Part1 = v191;
					l_Weld_8.C0 = CFrame.Angles(0, -1.5707963267948966, 0);
					l_Weld_8.Parent = Params.Char;
					for _, v194 in ipairs(v191:GetDescendants()) do
						if v194:IsA("ParticleEmitter") then
							v194:Emit(v194:GetAttribute("EmitCount"));
							v194.Enabled = true;
							task.delay(1, function() --[[ Line: 680 ]]
								v194.Enabled = false;
							end);
						end;
					end;
					Debris:AddItem(v191, 2);
				end);
			end;
		elseif Awk == 'Strongest of Today' then
			if Stage == 'Start' then
				local Char = Params.Char
				local HumRP: BasePart = Char.HumanoidRootPart
				local Aura = script["Strongest of Today"].GojoAura

				local AuraFX = {};
				for _, PartName in { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" } do
					local Part = Char:FindFirstChild(PartName);
					if Part then
						for _, InfinityAura in Aura:GetChildren() do
							local WHAT = InfinityAura:Clone();
							WHAT.Parent = Part;
							table.insert(AuraFX, WHAT);
							--ParticlesModule.Emit(Aura, false);
						end
					end
				end
				local Connection : RBXScriptSignal
				Connection = Character:GetAttributeChangedSignal("Aura"):Connect(function()
					if not Character:GetAttribute("Aura") then
						if Connection then
							Connection:Disconnect()
							Connection = nil
						end
						for _, WHAT in AuraFX do
							WHAT.Enabled = false;
							task.delay(WHAT.Lifetime.Max, WHAT.Destroy, WHAT);
						end;
					end
				end)	
			end	
		end
	end,

	PurpleNuke = function(Params)
		local Character = Params.Char
		local arg1 = Character
		local RootPart_3_upvr = arg1:FindFirstChildOfClass("Humanoid").RootPart
		local TroveNew = Trova.new()
		local ClockTime = Lighting.ClockTime
		TroveNew:AttachToInstance(arg1)
		if LocalPlayer.Character  == arg1  then
			cutscene(script["Strongest of Today"].Purple.CameraAnimation,script["Strongest of Today"].Purple.CameraModel,RootPart_3_upvr,nil,script["Strongest of Today"].Purple.FOV,false)
			SoundsModule:AddSound(script["Strongest of Today"].Purple.Sound,game.SoundService)
		else
			SoundsModule:AddSound(script["Strongest of Today"].Purple.Sound, RootPart_3_upvr)
		end

		local function SpawnBalls(Color,Controller)
			if Color == 'Blue' then
				local Blue = script["Strongest of Today"].Purple.Blue:Clone()
				Blue.Parent = workspace.Effects
				Controller.blue.Part1 = Blue
				TroveNew:Add(Blue)

				local SpawnVFXS = nil

				if LocalPlayer:DistanceFromCharacter(RootPart_3_upvr.Position) >= 125 then
					SpawnVFXS = false
				else
					SpawnVFXS = true
				end


				if SpawnVFXS then
					local Cast = script["Strongest of Today"].Purple.BlueCast:Clone()
					Cast.CFrame = Blue.CFrame
					Cast.Parent = workspace.Effects
					EmitOnly(Cast)
					TroveNew:Add(Cast)
				end


				return Blue
			elseif Color == 'Red' then
				local Red = script["Strongest of Today"].Purple.Red:Clone()
				Red.Parent = workspace.Effects
				Controller.red.Part1 = Red
				TroveNew:Add(Red)

				local SpawnVFXS = nil

				if LocalPlayer:DistanceFromCharacter(RootPart_3_upvr.Position) >= 125 then
					SpawnVFXS = false
				else
					SpawnVFXS = true
				end


				if SpawnVFXS then
					local Cast = script["Strongest of Today"].Purple.RedCast:Clone()
					Cast.CFrame = Red.CFrame
					Cast.Parent = workspace.Effects
					EmitOnly(Cast)
					TroveNew:Add(Cast)
				end


				return Red
			end
		end
		local function SpeedLines(Controller)
			local SpeedLine = script["Strongest of Today"].Purple.Speedlines:Clone()
			SpeedLine.CFrame = Controller.CFrame * CFrame.new(0, -3, 0)
			SpeedLine.Parent = workspace.Effects
			TroveNew:Add(SpeedLine)
			local Connections = RNS.PostSimulation:Connect(function()
				SpeedLine.Position = arg1.Torso.Position - Vector3.yAxis * 3
			end)
			task.delay(1.6,function()
				Connections:Disconnect()
				for i,v in SpeedLine:GetDescendants() do
					if v:IsA('ParticleEmitter') then
						v.Enabled = false
					end
				end
			end)
		end 
		local function Charging()
			local eyeglow = script["Strongest of Today"].Purple.EyeGlow:Clone()
			eyeglow.Parent = workspace.Effects
			eyeglow.Weld.Part0 = arg1.Head

			TroveNew:Add(eyeglow)
			EmitOnly(eyeglow.Emit)

			local FX = script["Strongest of Today"].Purple.Charging.FX:Clone()
			FX.Parent = arg1.Torso

			TroveNew:Add(eyeglow)
			EmitOnly(FX)

			return eyeglow,FX
		end
		local function Time()
			local Info = TweenInfo.new(0.25, Enum.EasingStyle.Quad)

			Lighting.ClockTime = 0.75
			local PointLight = Instance.new("PointLight")
			PointLight.Brightness = 0
			PointLight.Range = 15
			PointLight.Parent = arg1
			TS:Create(PointLight, Info, {
				Brightness = 7;
			}):Play()
			local class_ColorCorrec = game:GetService("Lighting"):FindFirstChildOfClass("ColorCorrectionEffect")
			if class_ColorCorrec then
				class_ColorCorrec.Enabled = false
			end
			local ColorCorrec = Instance.new("ColorCorrectionEffect")
			ColorCorrec.Parent = workspace.CurrentCamera
			TS:Create(ColorCorrec, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
				Brightness = -0.15;
				Contrast = 1.3;
			}):Play()
			task.delay(1.6, function()
				TS:Create(PointLight, Info, {
					Brightness = 0;
				}):Play()
				TS:Create(ColorCorrec, Info, {
					Brightness = 0;
					Contrast = 0;
				}):Play()
				if class_ColorCorrec then
					class_ColorCorrec.Enabled = true
				end

				Lighting.ClockTime = ClockTime
			end)
		end
		local function Purple(Controller,Blue :BasePart,Red)
			local function Array(Part)
				for _, v_9 in Part do
					if v_9:IsA("ParticleEmitter") then
						v_9:Destroy()
					elseif v_9:IsA("PointLight") then
						TS:Create(v_9, TweenInfo.new(0.2), {
							Brightness = 0;
						}):Play()
					end
				end
			end
			Array(Blue:GetDescendants())
			Array(Red:GetDescendants())

			TS:Create(Blue, TweenInfo.new(0.2), {
				Transparency = 1,
				Size = Vector3.zero
			}):Play()
			TS:Create(Red, TweenInfo.new(0.2), {
				Transparency = 1,
				Size = Vector3.zero
			}):Play()
			local Cast = script["Strongest of Today"].Purple.PurpleCast:Clone()
			Cast.CFrame = Controller.CFrame
			Cast.Parent = workspace.Effects
			EmitOnly(Cast)
			TroveNew:Add(Cast)

			local Bubble = script["Strongest of Today"].Purple.Bubble:Clone()
			Bubble.Size = Vector3.one * 10
			Bubble.Transparency = 1
			Bubble.CFrame = Controller.CFrame
			Bubble.Parent = workspace.Effects
			TS:Create(Bubble, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
				Transparency = 2;
			}):Play()
			TS:Create(Bubble, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
				Size = Vector3.one;
			}):Play()
			task.delay(0.1, function()
				TS:Create(Bubble, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
					Transparency = 1;
				}):Play()
				task.wait(0.1)
				Bubble:Destroy()
			end)

			local Purple = script["Strongest of Today"].Purple.Purple:Clone()
			Purple.CFrame = Controller.CFrame
			Purple.Parent = workspace.Effects
			TroveNew:Add(Purple)

			TS:Create(Purple, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Size = Purple.Size * 2.8;
			}):Play()

			local TablePart = {}

			for _, v_10 in Purple:GetDescendants() do
				if v_10:IsA("ParticleEmitter") then
					(TablePart)[v_10] = StoreParticle_upvr(v_10)
				end
			end
			local function Particle(Tween)
				Tween = TS:GetValue(Tween, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
				local var174 = Tween
				for i_13, v_11 in TablePart do
					ScaleParticle_upvr(i_13, v_11, 2.8 * var174)
				end
			end

			local Settings = {
				Duration = 1;
				result = "alpha";
			}

			local Clocks = 0
			local Connection
			local ILOVEXIAO = os.clock()
			local Duration = Settings.Duration
			local Result = Settings.result
			local v0 = Settings.v0
			local v1 = Settings.v1
			Connection = RNS.Heartbeat:Connect(function() 
				if Clocks == 1 then
					Connection:Disconnect()
				else
					Clocks = math.min((os.clock() - ILOVEXIAO) / Duration, 1)
					if Result == "alpha" then
						Particle(Clocks)
						return
					end
					local var183 = v0
					if var183 then
						var183 = v1
					end
					assert(var183, "v0 and v1 must be provided")
					Particle(v0 + (v1 - v0) * Clocks)
				end
			end)

			task.wait(1)
			local Eyeglow,ChargingVFX = Charging()
			if LocalPlayer.Character  == arg1  then
				Time()
			end
			task.wait(0.7)
			TS:Create(ChargingVFX.PointLight, TweenInfo.new(0.2), {
				Brightness = 0;
			}):Play()
			for i,v  in ChargingVFX:GetDescendants() do
				if v:IsA('ParticleEmitter') then
					v.Enabled = false
				end
			end
			task.wait(0.5)
			for i,v  in Eyeglow:GetDescendants() do
				if v:IsA('ParticleEmitter') then
					v.Enabled = false
				end
			end
			TS:Create(Purple, TweenInfo.new(0.2), {
				Transparency = 1;
			}):Play()
			local Explode = script["Strongest of Today"].Purple.PurpleExplode:Clone()
			Explode.CFrame = Purple.CFrame
			Explode.Parent = workspace.Effects
			local Area = script["Strongest of Today"].Purple.Area:Clone()
			Area.CFrame = Purple.CFrame
			Area.Parent = workspace.Effects
			for i,v  in Area:GetDescendants() do
				if v:IsA('ParticleEmitter') then
					v.Enabled = true
				end
			end
			task.delay(0.8, function() 
				for i,v  in Area:GetDescendants() do
					if v:IsA('ParticleEmitter') then
						v.Enabled = false
					end
				end
			end)
			TS:Create(Explode.PointLight, TweenInfo.new(0.5), {
				Brightness = 0;
			}):Play()
			EmitOnly(Explode)

			local Check = nil

			if LocalPlayer:DistanceFromCharacter(RootPart_3_upvr.Position) >= 70 then
				Check = false
			else
				Check = true
			end
			if Check then
				task.delay(0.15, function()
					--Parent.newCameraShake({{3, 20, 0, 3}, Vector3.yAxis * 20 + Vector3.xAxis * 20})
					local Flash = script["Strongest of Today"].Purple.Flashbang:Clone()
					Flash.Parent = l_PlayerGui_0
					TS:Create(Flash.Frame, TweenInfo.new(1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						BackgroundTransparency = 1;
					}):Play()
					local ImpactFrames = {
						FPS = 0.05;
						Frames = {16745636008, 16745636207, 16745636444, 16745636628, 16745636853, 16745637091, 16745637267, 16745637590, 16745637851, 16745638039}
					}
					if LocalPlayer.Character  == arg1 then
						Frames(ImpactFrames,Flash.Frame)
					end
					task.wait(1.25)
					Flash:Destroy()

				end)
			end


			Debris:AddItem(Explode,4)
			Debris:AddItem(Area,6)
			TroveNew:Destroy()


			task.wait(3)
			local Raycast = l_Raycast_0(RootPart_3_upvr.Position,Vector3.new(0,-10000000000000000000,0))
			local Land = script["Strongest of Today"].Purple.Land:Clone()
			Debris:AddItem(Land,1)
			Land.Position = Raycast.Position
			Land.Parent = workspace.Effects
			for _, v_8 in Land.EmitIt:GetChildren() do
				if v_8.Name == "Dust" then
					v_8.Color = ColorSequence.new(Raycast.Instance.Color)
				end
			end
			EmitOnly(Land)



		end
		local function Rotate(Controller : BasePart,Blue,Red)
			task.wait(0.7)

			local PreviousAngle = Instance.new('NumberValue')
			PreviousAngle.Value = 0
			local UpValue = Instance.new('NumberValue')
			UpValue.Value = 0
			local Height = 0
			local Connection : RBXScriptConnection = nil
			local Tick = tick()


			local AngleTween = TS:Create(PreviousAngle,TweenInfo.new(2.5),{
				['Value'] = 800
			})
			local UpTween= TS:Create(UpValue,TweenInfo.new(2.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{
				['Value'] = 53.5
			})
			AngleTween:Play()
			UpTween:Play()

			local Start = true


			Connection = RNS.RenderStepped:Connect(function(dt)
				if tick() - Tick < 2.5 then
					local verticalMovement = UpValue.Value * dt 
					Controller.CFrame = Controller.CFrame + Vector3.new(0, verticalMovement, 0)
					Height += verticalMovement  
				end

				--PreviousAngle += 5
				if PreviousAngle.Value > 0 then
					Controller.CFrame = Controller.CFrame * CFrame.Angles(0, math.rad(PreviousAngle.Value * dt), 0)
				end

			end)

			TroveNew:Add(Connection)

			TroveNew:Add(task.delay(2.6,function()
				TS:Create(PreviousAngle,TweenInfo.new(0.8),{
					['Value'] = 0
				}):Play()
				task.wait(0.7)
				Connection:Disconnect()
				UpValue:Destroy()
				if PreviousAngle.Value > 0 then
					PreviousAngle:Destroy()
				end
				Start = false
				if not arg1 or not Controller:FindFirstChild("blue") then
				else
					TS:Create(Controller.blue, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						C0 = CFrame.new(-11, 0, 0);
					}):Play()
					TS:Create(Controller.red, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						C0 = CFrame.new(11, 0, 0);
					}):Play()
					task.wait(0.35)
					local Tween2 = TS:Create(Controller.blue, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						C0 = CFrame.new(0, 0, 0);
					})
					Tween2:Play()
					Tween2:Destroy()
					TS:Create(Controller.red, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						C0 = CFrame.new(0, 0, 0);
					}):Play()
					task.wait(0.2)
					Purple(Controller,Blue,Red)
				end
			end))


		end




		local Controler = script["Strongest of Today"].Purple.Controller:Clone()
		Controler.CFrame = RootPart_3_upvr.CFrame * CFrame.new(0,-0.8,2)
		Controler.Parent = arg1
		Controler.Anchored = true
		Controler.CanCollide = false

		TroveNew:Add(Controler)

		task.wait(1)
		local Blue = SpawnBalls('Blue',Controler)
		task.spawn(function()
			wait()
			TS:Create(Controler.blue, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				C0 = CFrame.new(-5.5, 0, 0);
			}):Play()
		end)

		task.wait(1)
		local Red = SpawnBalls('Red',Controler)
		task.spawn(function()
			wait()
			TS:Create(Controler.red, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				C0 = CFrame.new(5.5, 0, 0);
			}):Play()

		end)
		task.wait(4)

		SpeedLines(Controler)
		Rotate(Controler,Blue,Red)

	end,

	AwakeningMusic = function(Params)
		local Att: Attachment = Params.MusAtt

		if LocalPlayer.Configuration['Awakening Music'].Value == false then
			local c: RBXScriptConnection
			c = Att.ChildAdded:Connect(function(child)
				if child == Params.Sound then
					c:Disconnect()
					child:Destroy()
				end
			end)
		end
	end,

	PlayAwakeningMusic = function(Params: { any })
		local Att: Attachment = Params.MusAtt
		local MusicId = Params.Id

		local Music = Instance.new('Sound')
		Music.Parent = Att
		Music.SoundId = MusicId
		Music.SoundGroup = game.SoundService.Sounds
		Music:Play()


		if LocalPlayer.Configuration['Awakening Music'].Value == false then
			Music.Volume = 0
		else
			Music.Volume = 1
		end

		local changedConnection: RBXScriptConnection = LocalPlayer.Configuration['Awakening Music']:GetPropertyChangedSignal('Value'):Connect(function()
			if LocalPlayer.Configuration['Awakening Music'].Value == false then
				TS:Create(Music, TweenInfo.new(1), { Volume = 0; }):Play()
			else
				TS:Create(Music, TweenInfo.new(1), { Volume = 1; }):Play()
			end
		end)


		Music.Ended:Wait()
		changedConnection:Disconnect()
		Music:Destroy()
	end,

	StopAwakeningMusics = function(Params: { any })
		local Att: Attachment = Params.MusAtt
		for _,v in Att:GetChildren() do
			if v:IsA('Sound') then
				TS:Create(v, TweenInfo.new(1), { PlaybackSpeed = 0; }):Play()
				Debris:AddItem(v, 2)
			end
		end
	end,

	Dash = function(Params)
		if Params.Stage == 'HitFX' then
			local vfx = script.Misc.Dash.LMB.Attachment:Clone()
			vfx.Parent = Params.HitPart

			for _,p: ParticleEmitter in vfx:GetChildren() do
				if p:IsA('ParticleEmitter') then
					p:Emit(p:GetAttribute('EmitCount'))
				end
			end

			Debris:AddItem(vfx, .7)
		end
	end,

	Destroy = function(Params)
		DestructiblesModule:Destroy(Params.cf,Params.size,Params.burn,Params.vel,Params.lookAt)
	end,

	Flashstep = function(Params)
		require(game.ReplicatedStorage.Modules.Flashstep):Flashstep(Params.C, Params.T, Params.S, Params.D)
	end,

	Hitbox = function(params)
		for _,v in workspace.Thrown:GetChildren() do
			if v.Name == LocalPlayer.UserId .. ' Hitbox' then
				v:Destroy()
			end
		end

		local visual = Instance.new('Part')
		visual.Material = Enum.Material.SmoothPlastic
		visual.Name = LocalPlayer.UserId .. ' Hitbox'
		visual.Anchored = true
		visual.CastShadow = false
		visual.CanCollide = false
		visual.CanTouch = false
		visual.CanQuery = false
		visual.CFrame = params.CF
		visual.Transparency = 0.75
		visual.Color = Color3.fromRGB(255,0,0)
		visual.Parent = workspace.Thrown

		if params.Method == 'Radius' then
			visual.Shape = Enum.PartType.Ball
			visual.Size = Vector3.new(1, 1, 1) * params.Size
		else
			visual.Size = params.Size
		end

		Debris:AddItem(visual,.1)
	end,

	InvertedSphere = function(Params)
		local fx = EffectsAssets.Inverted:Clone()
		fx.Parent = workspace.Effects
		fx.CFrame = Params.CF

		for Prop, Value in Params.FirstProps do
			if fx[Prop] then
				fx[Prop] = Value
			end
		end

		TS:Create(fx,TweenInfo.new(Params.TN_Info.Time, Enum.EasingStyle[Params.TN_Info.Style], Enum.EasingDirection[Params.TN_Info.Direction]),Params.FinalProps):Play()
		Debris:AddItem(fx,Params.LF or Params.TN_Info.Time)
	end,

	Ring = function(Params)
		local fx = EffectsAssets.Ring:Clone()
		fx.Parent = workspace.Effects
		fx.CFrame = Params.CF

		for Prop, Value in Params.FirstProps do
			if fx[Prop] then
				fx[Prop] = Value
			end
		end

		TS:Create(fx,TweenInfo.new(Params.TN_Info.Time, Enum.EasingStyle[Params.TN_Info.Style], Enum.EasingDirection[Params.TN_Info.Direction]),Params.FinalProps):Play()
		Debris:AddItem(fx,Params.LF or Params.TN_Info.Time)
	end,

	ShakeCamera = function(params)
		if params.Instance then
			ShakeCameraModule:SustainShakeCamera(params.Instance, params.shakeTime, params.fadeOutTime)
		else
			if params.Preset then
				local Preset = CamShakePresets[params.Preset]


				assert(Preset, 'The specified preset does not exist.')


				ShakeCameraModule:ShakeCamera(Preset.Magnitude, Preset.Roughness, Preset.FadeInTime, Preset.FadeOutTime)
			else
				ShakeCameraModule:ShakeCamera(params.Magnitude, params.Roughness, params.FadeInTime, params.FadeOutTime)
			end
		end
	end,

	TorsoTrail = function(Params)
		local Char: Model = Params.Char
		local inAir = Char:FindFirstChild('inAir')

		if not inAir then return end

		local HumRP: BasePart = Char.HumanoidRootPart

		local vfx = script.Misc.TorsoTrail.AirTrail:Clone()
		vfx.Parent = HumRP

		local B,F = script.Misc.TorsoTrail.Attachments.Back:Clone(), script.Misc.TorsoTrail.Attachments.Forward:Clone()
		B.Parent,F.Parent = HumRP,HumRP


		vfx.Attachment0 = B
		vfx.Attachment1 = F

		local Cs = {}

		local function DestroyTrail()
			for	_,v in Cs do
				v:Disconnect()
			end

			vfx.Enabled = false

			task.delay(vfx.Lifetime, function()
				vfx:Destroy()
			end)
		end

		local c = HumRP.Destroying:Connect(DestroyTrail)
		table.insert(Cs,c)

		local c1 = inAir.Destroying:Connect(DestroyTrail)
		table.insert(Cs,c1)
	end,

	PushTrail = function(Params)
		local Char: Model = Params.Char
		local inAir = Char:FindFirstChild('inAir')

		if not inAir then return end

		local HumRP: BasePart = Char.HumanoidRootPart

		local vfx = script.Misc.TorsoTrail.AirTrail:Clone()
		local Burst = script["Saitama"].Awakening.PART.Wind:Clone()
		Burst.Parent = HumRP
		ParticlesModule.Enabled(Burst, true)
		vfx.Parent = HumRP

		local B,F = script.Misc.TorsoTrail.Attachments.Back:Clone(), script.Misc.TorsoTrail.Attachments.Forward:Clone()
		B.Parent,F.Parent = HumRP,HumRP


		vfx.Attachment0 = B
		vfx.Attachment1 = F

		local Cs = {}

		local function DestroyTrail()
			for	_,v in Cs do
				v:Disconnect()
			end

			vfx.Enabled = false
			ParticlesModule.Enabled(Burst, false)
			task.delay(vfx.Lifetime, function()
				vfx:Destroy()
				Burst:Destroy()
			end)
		end

		local c = HumRP.Destroying:Connect(DestroyTrail)
		table.insert(Cs,c)

		local c1 = inAir.Destroying:Connect(DestroyTrail)
		table.insert(Cs,c1)
	end,

	WindRing = function(Params)
		local fx = EffectsAssets.Wind:Clone()
		fx.Parent = workspace.Effects
		fx.CFrame = Params.CF

		for Prop, Value in Params.FirstProps do
			if fx[Prop] then
				fx[Prop] = Value
			end
		end

		TS:Create(fx,TweenInfo.new(Params.TN_Info.Time, Enum.EasingStyle[Params.TN_Info.Style], Enum.EasingDirection[Params.TN_Info.Direction]),Params.FinalProps):Play()
		Debris:AddItem(fx,Params.LF or Params.TN_Info.Time)
	end,

	WindRing2 = function(Params)
		local fx = EffectsAssets.Wind2:Clone()
		fx.Parent = workspace.Effects
		fx.CFrame = Params.CF

		for Prop, Value in Params.FirstProps do
			if fx[Prop] then
				fx[Prop] = Value
			end
		end

		TS:Create(fx,TweenInfo.new(Params.TN_Info.Time, Enum.EasingStyle[Params.TN_Info.Style], Enum.EasingDirection[Params.TN_Info.Direction]),Params.FinalProps):Play()
		Debris:AddItem(fx,Params.LF or Params.TN_Info.Time)
	end,

	Wallcombo = function(Params)
		local EnemyHumRP = Params.rootpart2

		if Params.Combo == 'KJ' then
			if Params.Stage == 'Start' then
				local FXFolder = script.KJ.Wallcombo;

				local Character: Model = Params.Character;
				local EnemyCharacter: Model = Params.EnemyCharacter;

				local HumRP: BasePart = Character.HumanoidRootPart;
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart;

				local HumRPCF = HumRP.CFrame * CFrame.Angles(0, rad(180), 0)

				if Character == LocalCharacter or EnemyCharacter == LocalCharacter then
					task.spawn(function()
						CameraTableAnims:PlayAnimation('KJWallcombo', HumRP)
					end)

					task.delay(2.85, function()
						shared.ActivateiFrames('Wallcombo', { Stage = 'IFrames'; })
					end)
				end

				task.wait(.15)

				local Slam = FXFolder.slam:Clone()
				Slam.Parent = workspace.Thrown
				Slam.CFrame = HumRPCF * CFrame.new(0, 0.7, 2.25);
				ParticlesModule.Emit(Slam)
				Debris:AddItem(Slam, 2.6)

				task.wait(2.7)

				local Feet = FXFolder.feet:Clone()
				Feet.Parent = workspace.Thrown
				Feet.CFrame = HumRPCF * CFrame.new(0.7870006561279297, -2.7, 1.7350006103515625) * CFrame.Angles(1.5707963267948966, 0, 0);
				ParticlesModule.Emit(Feet)
				Debris:AddItem(Feet, 2.6)

				local AuraFX = {};
				for _, PartName in { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" } do
					local Part = Character:FindFirstChild(PartName);
					if Part then
						for _, Emitter in FXFolder.UserAura:GetChildren() do
							local Aura = Emitter:Clone();
							Aura.Parent = Part;
							table.insert(AuraFX, Aura);
							task.delay(math.random(1, 10) / 100, function()
								Aura.Enabled = true;
							end)
							ParticlesModule.Emit(Aura, false);
						end
					end
				end

				local Hold = FXFolder.hold:Clone();
				Hold.CFrame = HumRPCF * CFrame.new(0, 0, 1);
				Hold.Parent = workspace.Thrown;
				Debris:AddItem(Hold, 5.8)
				local l_PointLight_1 = Hold.Attachment.PointLight;
				ParticlesModule.Enabled(Hold, true)
				task.spawn(function()
					local lastClock = os.clock();
					while true do
						task.wait(0.03333333333333333);
						TS:Create(l_PointLight_1, TweenInfo.new(0.03333333333333333), {
							Brightness = math.random(1, 60) * 0.1
						}):Play();
						if not (os.clock() - lastClock <= 2.8) then
							break;
						end;
					end;
					TS:Create(l_PointLight_1, TweenInfo.new(1), {
						Brightness = 0
					}):Play();
				end);

				task.wait(2.8)

				ParticlesModule.Enabled(Hold, false)

				task.wait(.2)

				local FinalImpact = FXFolder.FinalImpact:Clone();
				FinalImpact.CFrame = HumRPCF * CFrame.new(0, 0, 1) * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.new(0, 0, -1);
				FinalImpact.Parent = workspace.Thrown;
				ParticlesModule.Emit(FinalImpact);
				Debris:AddItem(FinalImpact, ParticlesModule.GetHLF(FinalImpact))

				local l_SpotLight_0 = FinalImpact.Origin.SpotLight;
				TS:Create(l_SpotLight_0, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					Brightness = 35
				}):Play();
				task.delay(0.3, function()
					TS:Create(l_SpotLight_0, TweenInfo.new(0.5), {
						Brightness = 0
					}):Play();
				end)

				task.wait(0.4)

				for _, Emitter in AuraFX do
					Emitter.Enabled = false;
					task.delay(Emitter.Lifetime.Max, Emitter.Destroy, Emitter);
				end;
			end
		elseif Params.Combo == 'Kokushibo' then
			local Stage = Params.Stage

			if Stage == 'Explosion' then
				local VFX = script.Misc.Wallcombos.Kokushibo.Explosion:Clone()
				VFX.Parent = workspace.Thrown
				VFX.CFrame = Params.CF
				VFX.Moon:Emit(VFX.Moon:GetAttribute('EmitCount'))
				Debris:AddItem(VFX, 2)
			end
		elseif Params.Combo == 'Strongest of Today' then
			local Stage = Params.Stage

			if Stage == 'All' then
				local l_TweenService_1 = game:GetService("TweenService");
				local v913 = game.ReplicatedStorage.Resources.Sorcerer.WallFX:Clone();
				v913:PivotTo(EnemyHumRP.CFrame * CFrame.new(0, 0, 1));
				v913.Parent = workspace.Thrown;
				local v914 = game.ReplicatedStorage.Resources.Sorcerer.Lighting:Clone();
				v914.Parent = game.Lighting;
				local v915 = game.ReplicatedStorage.Resources.Sorcerer.LimitlessBarrier:Clone();
				v915:PivotTo(EnemyHumRP.CFrame);
				v915.Parent = workspace.Thrown;
				task.delay(10, function()
					v915:Destroy();
				end);
				local l_Sphere_0 = v915.Sphere;
				task.delay(0.085, function()
					for _, v918 in pairs(v913.FirstSlam:GetDescendants()) do
						if v918:IsA("ParticleEmitter") then
							v918:Emit(v918:GetAttribute("EmitCount"));
						end;
					end;
				end);
				task.delay(1.26, function()
					task.spawn(function()
						local l_ColorCorrectionEffect_0 = Instance.new("ColorCorrectionEffect");
						l_ColorCorrectionEffect_0.Name = "cloned";
						l_ColorCorrectionEffect_0.Parent = game.Lighting;
						local l_BarrierScreen_0 = v914.BarrierScreen;
						l_TweenService_1:Create(l_ColorCorrectionEffect_0, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							Brightness = l_BarrierScreen_0.Brightness, 
							Contrast = l_BarrierScreen_0.Contrast, 
							Saturation = l_BarrierScreen_0.Saturation, 
							TintColor = l_BarrierScreen_0.TintColor
						}):Play();
						task.wait(2);
						l_TweenService_1:Create(l_ColorCorrectionEffect_0, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
							Brightness = 0, 
							Contrast = 0, 
							Saturation = 0
						}):Play();
						task.wait(1);
						l_ColorCorrectionEffect_0:Destroy();
					end);
					task.spawn(function()
						v913.Final.BarrierCrater.Transparency = 0;
						v913.Final.FinalCrater.Transparency = 0;
						v913.Final.FinalCrater.Color3 = Color3.fromRGB(100, 600, 2000);
						l_TweenService_1:Create(v913.Final.FinalCrater, TweenInfo.new(4, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
							Color3 = Color3.fromRGB(0, 0, 0), 
							Transparency = 1
						}):Play();
						task.wait(5);
						l_TweenService_1:Create(v913.Final.BarrierCrater, TweenInfo.new(3, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
							Transparency = 1
						}):Play();
					end);
					task.spawn(function()
						local l_Camera_0 = workspace.Camera;
						l_TweenService_1:Create(l_Camera_0, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
							FieldOfView = 80
						}):Play();
						task.wait(2.14);
						l_TweenService_1:Create(l_Camera_0, TweenInfo.new(1.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
							FieldOfView = 65
						}):Play();
					end);
					local l_Appear_0 = v915.Core.Appear;
					for _, v924 in pairs(l_Appear_0:GetDescendants()) do
						if v924:IsA("ParticleEmitter") then
							v924:Emit(v924.Name);
						end;
					end;
					local l_BarrierFX_0 = v915.Core.BarrierFX;
					for _, v927 in pairs(l_BarrierFX_0:GetDescendants()) do
						if v927:IsA("ParticleEmitter") then
							v927.Enabled = true;
						end;
					end;
					task.delay(2, function()
						local l_BarrierFX_1 = v915.Core.BarrierFX;
						for _, v930 in pairs(l_BarrierFX_1:GetDescendants()) do
							if v930:IsA("ParticleEmitter") then
								v930.Enabled = false;
							end;
						end;
					end);
					local l_BeamRings_0 = v915.Core.BeamRings;
					for _, v933 in pairs(l_BeamRings_0:GetDescendants()) do
						if v933:IsA("Beam") then
							v933.Enabled = true;
							l_TweenService_1:Create(v933, TweenInfo.new(2.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
								Brightness = 0
							}):Play();
						end;
					end;
					local function v939()
						local v934 = v915.WindRing:Clone();
						local v935 = math.random(0, 360);
						v934:SetPrimaryPartCFrame(v934.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(v935), 0));
						local l_Start_1 = v934.Start;
						local l_End_1 = v934.End;
						local v938 = l_Start_1:Clone();
						v938.Name = "ClonedMesh";
						v938.Parent = v915.CurrentTweens;
						l_TweenService_1:Create(v938.Decal, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
							Transparency = 0.9
						}):Play();
						l_TweenService_1:Create(v938, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							Size = l_End_1.Size, 
							CFrame = l_End_1.CFrame
						}):Play();
						l_TweenService_1:Create(v938.Mesh, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
							Scale = l_End_1.Mesh.Scale
						}):Play();
						task.wait(0.2);
						l_TweenService_1:Create(v938.Decal, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
							Transparency = 1
						}):Play();
						task.wait(1.2);
						v938:Destroy();
					end;
					local function v942()
						local v940 = Random.new():NextNumber(24, 26);
						local v941 = l_Sphere_0:Clone();
						v941.Name = "Cloned";
						v941.Parent = v915.CurrentTweens;
						l_TweenService_1:Create(v941, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
							Size = Vector3.new(v940, v940, v940), 
							Transparency = 3.65
						}):Play();
						task.wait(0.3);
						l_TweenService_1:Create(v941, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
							Size = Vector3.new(0, 0, 0, 0), 
							Transparency = 1
						}):Play();
						task.wait(0.3);
						v941:Destroy();
					end;
					task.spawn(function()
						for _ = 1, 13 do
							spawn(v942);
							task.wait(0.15);
						end;
					end);
					for _ = 1, 13 do
						spawn(v939);
						task.wait(0.15);
					end;
				end);
				task.delay(3.8, function()
					local l_EndEmit_0 = v915.Core.EndEmit;
					for _, v947 in pairs(l_EndEmit_0:GetDescendants()) do
						if v947:IsA("ParticleEmitter") then
							v947:Emit(v947:GetAttribute("EmitCount"));
						end;
					end;
					local l_Final_0 = v913.Final;
					for _, v950 in pairs(l_Final_0:GetDescendants()) do
						if v950:IsA("ParticleEmitter") then
							v950:Emit(v950:GetAttribute("EmitCount"));
						end;
					end;
					task.spawn(function()
						local l_ImpactFrameWhite_0 = v914.ImpactFrameWhite;
						l_ImpactFrameWhite_0.Enabled = true;
						task.wait(0.045);
						l_ImpactFrameWhite_0.Enabled = false;
						l_ImpactFrameWhite_0.Enabled = true;
						task.wait(0.045);
						l_ImpactFrameWhite_0.Enabled = false;
						local v952 = v914.BarrierFinal:Clone();
						v952.Name = "cloned2";
						v952.Parent = game.Lighting;
						l_TweenService_1:Create(v952, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
							Brightness = 0, 
							Contrast = 0, 
							Saturation = 0, 
							TintColor = Color3.fromRGB(255, 255, 255)
						}):Play();
						task.wait(1.5);
						v952:Destroy();
					end);
					task.spawn(function()
						local l_Camera_1 = workspace.Camera;
						l_TweenService_1:Create(l_Camera_1, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
							FieldOfView = 98
						}):Play();
						task.wait(0.2);
						l_TweenService_1:Create(l_Camera_1, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
							FieldOfView = 70
						}):Play();
					end);
					task.spawn(function()
						local v954 = v915.WindRing:Clone();
						local v955 = math.random(0, 360);
						v954:SetPrimaryPartCFrame(v954.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(v955), 0));
						local l_Start_2 = v954.Start;
						local l_End2_0 = v954.End2;
						local v958 = l_Start_2:Clone();
						v958.Name = "ClonedMesh";
						v958.Parent = v915.CurrentTweens;
						l_TweenService_1:Create(v958.Decal, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
							Transparency = 0.9
						}):Play();
						l_TweenService_1:Create(v958, TweenInfo.new(5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
							Size = l_End2_0.Size, 
							CFrame = l_End2_0.CFrame
						}):Play();
						l_TweenService_1:Create(v958.Mesh, TweenInfo.new(5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
							Scale = l_End2_0.Mesh.Scale
						}):Play();
						task.wait(0.2);
						l_TweenService_1:Create(v958.Decal, TweenInfo.new(5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
							Transparency = 1
						}):Play();
						task.wait(5.2);
						v958:Destroy();
					end);
					local function v961()
						local v959 = Random.new():NextNumber(55, 50);
						local v960 = l_Sphere_0:Clone();
						v960.Name = "Cloned";
						v960.Transparency = 0.01;
						v960.Material = Enum.Material.Neon;
						v960.Color = Color3.fromRGB(84, 150, 194);
						v960.Parent = v915.CurrentTweens;
						l_TweenService_1:Create(v960, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
							Size = Vector3.new(v959, v959, v959), 
							Transparency = 1
						}):Play();
						task.wait(0.2);
						v960:Destroy();
					end;
					for _ = 1, 5 do
						spawn(v961);
						task.wait(0.065);
					end;
				end);
			end
		end
	end,

	JunWallcomo = function(Params)
		local EnemyHumRP: BasePart = Params.Part

		local AssetsFolder = script.Jun.Wallcombo

		task.delay(0.433, function()
			local slam1VFX = AssetsFolder.Container.Slam1:Clone()
			slam1VFX.Parent = EnemyHumRP

			local groundRay = raycast(EnemyHumRP.Position, Vector3.new(0, -7.5, 0), MapRayParams)
			if groundRay then
				local newColor = ColorSequence.new(groundRay.Instance.Color)

				for _, Smoke in pairs(slam1VFX:GetDescendants()) do
					if Smoke:IsA("ParticleEmitter") and Smoke.Name == "Smoke" then
						Smoke.Color = newColor
					end
				end
			end

			if (EnemyHumRP.Position - LocalCharacter:GetPivot().Position).Magnitude <= 14 then
				ShakeCameraModule:ShakeCamera(17, 17, 0, .4)
			end

			ParticlesModule.Emit(slam1VFX)
			Debris:AddItem(slam1VFX, 4)
		end)

		task.delay(0.933, function()
			local slam2VFX = AssetsFolder.Container.Slam2:Clone()
			slam2VFX.Parent = EnemyHumRP

			local groundRay = raycast(EnemyHumRP.Position, Vector3.new(0, -7.5, 0), MapRayParams)
			if groundRay then
				local newColor = ColorSequence.new(groundRay.Instance.Color)

				for _, Smoke in pairs(slam2VFX:GetDescendants()) do
					if Smoke:IsA("ParticleEmitter") and Smoke.Name == "Smoke" then
						Smoke.Color = newColor
					end
				end
			end

			if (EnemyHumRP.Position - LocalCharacter:GetPivot().Position).Magnitude <= 14 then
				ShakeCameraModule:ShakeCamera(17, 17, 0, .4)
			end

			ParticlesModule.Emit(slam2VFX)
			Debris:AddItem(slam2VFX, 4)
		end)

		task.delay(2.183, function()
			local slashVFX = AssetsFolder.Container.Slash:Clone()
			slashVFX.Parent = EnemyHumRP

			local groundRay = raycast(EnemyHumRP.Position, Vector3.new(0, -7.5, 0), MapRayParams)
			if groundRay then
				local newColor = ColorSequence.new(groundRay.Instance.Color)

				for _, Smoke in slashVFX:GetDescendants() do
					if Smoke:IsA("ParticleEmitter") and Smoke.Name == "Smoke" then
						Smoke.Color = newColor
					end
				end
			end

			if LocalConfigFolder.Blood.Value == false then
				for _, Blood in slashVFX:GetDescendants() do
					if Blood:IsA("ParticleEmitter") and Blood.Name == "Blood" then
						Blood:Destroy()
					end
				end
			end

			if (EnemyHumRP.Position - LocalCharacter:GetPivot().Position).Magnitude <= 14 then
				ShakeCameraModule:ShakeCamera(31, 31, 0, .4)
			end

			ParticlesModule.Emit(slashVFX)
			Debris:AddItem(slashVFX, 4)
		end)
	end,

	RockTrail = function(Params)
		local parent = Params.parent
		local size = Params.size
		local side = Params.side
		local t = Params.t
		local spawnrate = Params.spawnrate
		local duration = Params.duration


		for i = 1, duration/spawnrate do
			local HumRP = parent.Parent:FindFirstChild('HumanoidRootPart')
			local DebrisTime = 0.5

			local Folder = Instance.new('Folder')
			Folder.Parent = workspace.Debris
			Folder.Name = 'Rocks'

			local function rocknew(finalSide)
				local ray = raycast(parent.Position, Vector3.new(0,-3.5,0), MapRayParams)
				if ray then
					local p = script.Rocks.RockTrail.Part:Clone()
					Debris:AddItem(p, t + 1)
					DebrisTime += t + 1

					p.CFrame = CFrame.new(ray.Position) * CFrame.new(finalSide, 0, 0)
					p.Parent = Folder
					p.Color = ray.Instance.Color
					p.Material = ray.Material

					TS:Create(p,TweenInfo.new(.25),{Size = Vector3.new(size,size,size)}):Play()

					delay(t,function()
						TS:Create(p,TweenInfo.new(.5),{Size = Vector3.new(0,0,0)}):Play()
					end)

					p.Orientation = Vector3.new(math.random(-180,180),math.random(-180.,180),math.random(-180,180))

					if HumRP and HumRP.BottomPart.Smoke.Smoke.Enabled == false then
						HumRP.BottomPart.Smoke.Smoke.Enabled = true
					end
				else
					if HumRP and HumRP.BottomPart.Smoke.Smoke.Enabled == true then
						HumRP.BottomPart.Smoke.Smoke.Enabled = false
					end
				end
			end

			task.spawn(function()
				if side == 0 then
					rocknew(side)
				else
					rocknew(side)
					rocknew(-side)
				end

				Debris:AddItem(Folder,DebrisTime)
			end)

			task.wait(spawnrate)
		end

		local HumRP = parent.Parent:FindFirstChild('HumanoidRootPart')

		if HumRP and HumRP.BottomPart.Smoke.Smoke.Enabled == true then
			HumRP.BottomPart.Smoke.Smoke.Enabled = false
		end
	end,

	flyLine = function(Info)
		if not Info.Multiplier then 
			Info.Multiplier = 1.2
		end

		for i = 1,Info.Length,Info.Step do
			flyRock({ Rocks = 1, CFrame = Info.CFrame + Vector3.new(Info.Separation,0,-i), BaseSize = Info.Size })
			flyRock({ Rocks = 1, CFrame = Info.CFrame + Vector3.new(-Info.Separation,0,-i), BaseSize = Info.Size })
			Info.Size += Info.Multiplier
		end
	end,

	['Wolf'] = function(params)
		local Character = params.Char
		local HumanoidRootPart_3_upvr = Character.HumanoidRootPart
		local LinearVelocity_3 = Instance.new("LinearVelocity")
		LinearVelocity_3.Attachment0 = HumanoidRootPart_3_upvr.RootAttachment
		LinearVelocity_3.ForceLimitMode = Enum.ForceLimitMode.PerAxis
		LinearVelocity_3.MaxAxesForce = Vector3.new(1, 0, 1) * 30000
		LinearVelocity_3.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
		LinearVelocity_3.Parent = HumanoidRootPart_3_upvr
		LinearVelocity_3.VectorVelocity = Vector3.zero
		TS:Create(LinearVelocity_3, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			VectorVelocity = Vector3.zAxis * -5;
		}):Play()
		local clone_2_upvr = script.Okarun.WolfHeadRoblox:Clone()
		clone_2_upvr.Parent = Character
		AnimEvents:loadAnimation(clone_2_upvr, script.Okarun.Wolf):Play(0)
		local Connec : RBXScriptConnection = nil
		Connec = RNS.RenderStepped:Connect(function()
			if clone_2_upvr.Parent then
				clone_2_upvr:PivotTo(HumanoidRootPart_3_upvr.CFrame * CFrame.Angles((math.pi/2), math.pi, 0))
			else
				Connec:Disconnect()
			end
		end)
		task.wait(2.55)
		CameraShake(5, 0.5, 0.7, {HumanoidRootPart_3_upvr, 60})
		TS:Create(LinearVelocity_3, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			VectorVelocity = Vector3.zAxis * -50;
		}):Play()

		task.wait(2)
		Emit(HumanoidRootPart_3_upvr, script.Okarun.Emitline, 2)
		CameraShake(5, 0.5, 0.7, {HumanoidRootPart_3_upvr, 60})
		TS:Create(LinearVelocity_3, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			VectorVelocity = Vector3.zAxis * -100;
		}):Play()
		local clone_34 = script.Okarun.RAHHH:Clone()
		clone_34.Parent = Character
		local Weld_6 = Instance.new("Weld")
		Weld_6.Part0 = HumanoidRootPart_3_upvr
		Weld_6.Part1 = clone_34
		Weld_6.Parent = clone_34

		task.wait(2.65)
		clone_34:Destroy()
		CameraShake(5, 0.5, 0.7, {HumanoidRootPart_3_upvr, 60})
		LinearVelocity_3.VectorVelocity = Vector3.zAxis * -250
		TS:Create(LinearVelocity_3, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			VectorVelocity = Vector3.zero;
		}):Play()

		task.wait(1)
		LinearVelocity_3:Destroy()
		CameraShake(5, 1.5, 2, {HumanoidRootPart_3_upvr, 60})
		EmitRaycast(HumanoidRootPart_3_upvr, script.Okarun.Land, 2, Vector3.yAxis * -5)
		task.wait(1)
		clone_2_upvr:Destroy()
		RNS.PreRender:Connect(function() 
			clone_2_upvr:PivotTo(HumanoidRootPart_3_upvr.CFrame * CFrame.Angles((math.pi/2), math.pi, 0))
		end):Disconnect()
	end,

	['Savage Strikes'] = function(params) 
		local Enemy = params.Enemy
		local char = params.Char
		local character = char
		local HumanoidRootPart_15 = params.Char.HumanoidRootPart
		local any_GetPlayerFromCharacter_result1 = Players:GetPlayerFromCharacter(char)
		local any_GetPlayerFromCharacter_result1_4 = Players:GetPlayerFromCharacter(Enemy)
		local var342
		if Players.LocalPlayer == any_GetPlayerFromCharacter_result1 or Players.LocalPlayer == any_GetPlayerFromCharacter_result1_4 then
			var342 = 0
			var342 = script.Okarun
			local function INLINED_3() -- Internal function, doesn't exist in bytecode
				var342 = Enemy
				return var342
			end
			if Players.LocalPlayer ~= any_GetPlayerFromCharacter_result1 or not INLINED_3() then
				var342 = character
			end
			cutscene(RS_Modules.CameraHandler.Animations.SavageStrikeCam, RS_Modules.CameraHandler["CamRigWithLetterBox"], HumanoidRootPart_15, CFrame.Angles(0, math.pi, 0), RS.Assets.Cutscenes.SSFOV, nil, var342)
		else
		end
		local clone_26 = script.Okarun.Emit['2']:Clone()
		clone_26.Parent = character
		local Weld_18 = Instance.new("Weld")
		Weld_18.Part0 = character.Head
		Weld_18.Part1 = clone_26
		Weld_18.C0 = CFrame.Angles(0, (-math.pi/2), 0)
		Weld_18.Parent = clone_26
		for _, v_21 in clone_26:GetDescendants() do
			if v_21:IsA("ParticleEmitter") then
				v_21:Emit(v_21:GetAttribute("EmitCount"))
			end
		end

		local clone_28_upvr = script.Okarun.SK:Clone()
		clone_28_upvr.Parent = character
		clone_28_upvr:PivotTo(HumanoidRootPart_15.CFrame)
		Enemy["Left Arm"].Transparency = 1
		local clone_17 = script.Okarun.FakeArm:Clone()
		clone_17.Parent = character
		local Weld_15 = Instance.new("Weld")
		Weld_15.Part0 = character.Head
		Weld_15.Part1 = clone_17.Head
		Weld_15.Parent = clone_17
		if Enemy:FindFirstChildOfClass("Shirt") then
			Enemy:FindFirstChildOfClass("Shirt"):Clone().Parent = clone_17.Leftarm
			clone_17.Leftarm["Left Arm"].Color = Enemy["Left Arm"].Color
		end
		task.wait(2.7)
		for _, v_22 in ipairs(clone_28_upvr.TP:GetDescendants()) do
			if v_22:IsA("ParticleEmitter") then
				v_22:Emit(v_22:GetAttribute("EmitCount"))
			end
		end
		for _, v_23 in ipairs(clone_28_upvr.TP2:GetDescendants()) do
			if v_23:IsA("ParticleEmitter") then
				v_23:Emit(v_23:GetAttribute("EmitCount"))
			end
		end
		for _, v_24 in ipairs(clone_28_upvr.AURA:GetDescendants()) do
			if v_24:IsA("ParticleEmitter") then
				v_24.Enabled = true
			end
		end
		clone_28_upvr:PivotTo(HumanoidRootPart_15.CFrame)
		clone_17:Destroy()
		task.wait(1.15)
		clone_28_upvr:PivotTo(HumanoidRootPart_15.CFrame)
		task.delay(0.1, function() -- Line 929
		--[[ Upvalues[1]:
			[1]: clone_28_upvr (readonly)
		]]
			for _, v_25 in ipairs(clone_28_upvr.Step:GetDescendants()) do
				if v_25:IsA("ParticleEmitter") then
					v_25:Emit(v_25:GetAttribute("EmitCount"))
				end
			end
			task.delay(0.11, function() -- Line 936
			--[[ Upvalues[1]:
				[1]: clone_28_upvr (copied, readonly)
			]]
				for _, v_26 in ipairs(clone_28_upvr.Step2:GetDescendants()) do
					if v_26:IsA("ParticleEmitter") then
						v_26:Emit(v_26:GetAttribute("EmitCount"))
					end
				end
				task.delay(0.11, function() -- Line 943
				--[[ Upvalues[1]:
					[1]: clone_28_upvr (copied, readonly)
				]]
					for _, v_27 in ipairs(clone_28_upvr.Step3:GetDescendants()) do
						if v_27:IsA("ParticleEmitter") then
							v_27:Emit(v_27:GetAttribute("EmitCount"))
						end
					end
				end)
			end)
		end)
		for _, v_28 in ipairs(clone_28_upvr.AURA:GetDescendants()) do
			if v_28:IsA("ParticleEmitter") then
				v_28.Enabled = false
			end
		end
		local clone_37 = script.Okarun.wth:Clone()
		clone_37.Parent = character
		local Weld_13 = Instance.new("Weld")
		Weld_13.Part0 = character["Left Leg"]
		Weld_13.Part1 = clone_37
		Weld_13.Parent = clone_37
		for _, v_29 in clone_37:GetDescendants() do
			if v_29:IsA("ParticleEmitter") then
				v_29:Emit(v_29:GetAttribute("EmitCount"))
				v_29.Enabled = true
			end
		end
		task.wait(1.35)
		for _, v_30 in clone_37:GetDescendants() do
			if v_30:IsA("ParticleEmitter") then
				v_30:Emit(v_30:GetAttribute("EmitCount"))
				v_30.Enabled = false
			end
		end
		Debris:AddItem(clone_37, 2)
		clone_28_upvr:PivotTo(HumanoidRootPart_15.CFrame)
		for i_33_upvw, UpdateWarper in ipairs(clone_28_upvr.Kick:GetDescendants()) do
			if UpdateWarper:IsA("ParticleEmitter") then
				UpdateWarper:Emit(UpdateWarper:GetAttribute("EmitCount"))
			end
		end
		if Players.LocalPlayer == any_GetPlayerFromCharacter_result1 or Players.LocalPlayer == any_GetPlayerFromCharacter_result1_4 then

			shared.ActivateiFrames('Savage Strikes', nil, 'Okarun')

			--local clone_9_upvr = script.Okarun.ImpactFrame2:Clone()
			--clone_9_upvr.Parent = Players.LocalPlayer.PlayerGui
			--local var393_upvw = 0
			--local tick_result1_upvw_2 = tick()
			--local Connec  = nil
			--local function UpdateWarper(character_10) 
			--	if 0.041666666666666664 <= tick() - tick_result1_upvw_2 then
			--		if 15 <= var393_upvw then
			--			clone_9_upvr:Destroy()
			--			Connec:Disconnect()
			--			return
			--		end
			--		var393_upvw += 1
			--		clone_9_upvr[var393_upvw].Visible = true
			--		tick_result1_upvw_2 = tick()
			--	end
			--end
			--Connec = game:GetService("RunService").RenderStepped:Connect(function() 
			--	if 0.041666666666666664 <= tick() - tick_result1_upvw_2 then
			--		if 15 <= var393_upvw then
			--			clone_9_upvr:Destroy()
			--			Connec:Disconnect()
			--			return
			--		end
			--		var393_upvw += 1
			--		clone_9_upvr[var393_upvw].Visible = true
			--		tick_result1_upvw_2 = tick()
			--	end
			--end)
		end
		task.wait(0.5)
		CameraShake(5, 1.5, 3, {HumanoidRootPart_15, 60})
		local Left = Enemy["Left Arm"]
		Left.Transparency = 0
		Debris:AddItem(clone_28_upvr, 3)
		Debris:AddItem(clone_26, 1)	
	end,

	rockCircle = function(ExtraInfo)
		if ExtraInfo.HardRagdollDetection == true then
			local Character: Model = ExtraInfo.Char
			if not Character or not Character.Parent then return end

			local HumRP: BasePart = Character:FindFirstChild('HumanoidRootPart')
			if not HumRP then return end


			local _, detectionRaye = shared.detectAir({ Char = Character; ragdoll = true; destroyables = ExtraInfo.destroyAmbient; })
			if not detectionRaye or not Character:HasTag('Ragdolled') or Character:FindFirstChild('RagdollCancel') then return end

			ExtraInfo['Raye'] = detectionRaye
			local Ragdoller = ExtraInfo['Ragdoller']
			if Ragdoller and Ragdoller == LocalCharacter then
				shared.addshake(6)
			end
		end

		ExtraInfo.RockMult = ExtraInfo.RockMult or 0
		ExtraInfo.RadiusMult = ExtraInfo.RadiusMult or 1
		ExtraInfo.Circles = ExtraInfo.Circles or 1

		local CF
		for i = 1, ExtraInfo.Circles do
			local RadiusMult = ExtraInfo.RadiusMult
			local SizeMult = ExtraInfo.SizeMult or RadiusMult
			if i == 1 then
				RadiusMult = 1
				SizeMult = 1
			else
				RadiusMult *= i
				SizeMult *= i
			end


			if ExtraInfo.RayDir then
				ExtraInfo.RayDir = CFrame.lookAt(ExtraInfo.CF.Position, ExtraInfo.RayDir).LookVector * 10
			end


			local Raye: RaycastResult = ExtraInfo['Raye'] or raycast(ExtraInfo.CF.Position, ExtraInfo.RayDir or Vector3.new(0, -10, 0), MapOverlapParams)

			if Raye and Raye.Instance then
				local hitparts = workspace:GetPartBoundsInRadius(Raye.Position, ExtraInfo.Radius/2 * RadiusMult, MapOverlapParams)
				for _,v : BasePart in pairs(hitparts) do
					if v.Name == 'Stadium' and math.random(0, 1) == 1 and v.Transparency == 0 then
						local TimeUntilDestroy = math.random(2,4)
						local TNTime = math.random(2.5, 5)

						local clone = v:Clone()
						clone.Parent = workspace.Debris
						clone.Anchored = false
						clone.CollisionGroup = 'NonPColDebri'
						clone.AssemblyLinearVelocity = Vector3.new(math.random(-50,50),math.random(-5,50),math.random(-50,50))
						clone.AssemblyAngularVelocity = Vector3.new(math.random(-45,45),math.random(-45,45),math.random(-45,45))
						Debris:AddItem(clone, TimeUntilDestroy + TNTime)

						task.delay(TimeUntilDestroy,function()
							TS:Create(clone, TweenInfo.new(TNTime, Enum.EasingStyle.Linear), { Transparency = 1 }):Play()
							Debris:AddItem(clone, TNTime)

							task.wait(TNTime)

							TS:Create(v, TweenInfo.new(TNTime, Enum.EasingStyle.Linear), { Transparency = 0 }):Play()
						end)

						v.Transparency = 1
					end
				end	



				CF = CFrame.new(Raye.Position, Raye.Position - Raye.Normal) * CFrame.Angles(rad(90), rad(math.random(ExtraInfo['MinDistance'] or 0, ExtraInfo['XRNG2'] or 360)), 0) * CFrame.new(0,1,0)



				if ExtraInfo.smoke ~= false then
					local SmokeSize = ExtraInfo.Radius/5
					local smokefx = script.Rocks.rockCircle.Smoke:Clone()
					smokefx.Parent = workspace.Effects
					smokefx.CFrame = CF
					for _,ParticleEmitter : ParticleEmitter in pairs(smokefx:GetDescendants()) do
						if ParticleEmitter:IsA('ParticleEmitter') then
							ParticleEmitter.Size = NumberSequence.new{ 
								NumberSequenceKeypoint.new(0, 7.69 * SmokeSize),
								NumberSequenceKeypoint.new(0.103, 7.89 * SmokeSize),
								NumberSequenceKeypoint.new(0.176, 8.05 * SmokeSize),
								NumberSequenceKeypoint.new(0.878, 7.03 * SmokeSize),
								NumberSequenceKeypoint.new(1, 5.31 * SmokeSize)
							}

							if ParticleEmitter.Name == 'Smoke' then
								ParticleEmitter.Speed = NumberRange.new(50 * SmokeSize, 75 * SmokeSize)
							else
								ParticleEmitter.Speed = NumberRange.new(0, 95 * SmokeSize)
							end


							ParticleEmitter:Emit(ParticleEmitter:GetAttribute('EmitCount'))
						end
					end
					Debris:AddItem(smokefx, 4)
				end



				if ExtraInfo.terrSmoke then
					local terrainSmokefx = script.Rocks.rockCircle.TerrainAtt.Attachment:Clone()
					terrainSmokefx.Parent = workspace.Terrain
					terrainSmokefx.CFrame = CF
					for _,ParticleEmitter : ParticleEmitter in pairs(terrainSmokefx:GetDescendants()) do
						if ParticleEmitter:IsA('ParticleEmitter') then
							ParticleEmitter:Emit(ParticleEmitter:GetAttribute('EmitCount'))
						end
					end
					Debris:AddItem(terrainSmokefx, 6.75)
				end

				local rng = Random.new()


				if ExtraInfo.flyRocks ~= false then
					local flyRocksNumber = math.random(ExtraInfo.Radius, ExtraInfo.Radius * 2)
					for i = 1, flyRocksNumber do
						local lifeTime = RandomSeed:NextNumber(4, 6)
						local sizePack = math.random(1, 2)
						local flyingDebris = script.Rocks.rockCircle.DefaultPart:Clone() do
							local velocity = RandomSeed:NextNumber(4,7)
							flyingDebris.CFrame = CF * CFrame.new(0,0.25,0)
							flyingDebris.Anchored = false
							flyingDebris.CollisionGroup = "NonPColDebri"
							flyingDebris.CanCollide = true
							flyingDebris.Material = Raye.Material
							flyingDebris.Color = Raye.Instance.Color
							flyingDebris.Size = Vector3.new(0.5, 0.5, 0.5) * sizePack
							flyingDebris.Parent = workspace.Terrain
							flyingDebris.AssemblyAngularVelocity = Vector3.new(RandomSeed:NextNumber(-25, 25), RandomSeed:NextNumber(-25, 25), RandomSeed:NextNumber(-25, 25))
							flyingDebris.AssemblyLinearVelocity = (CFrame.Angles(0, 2 * math.pi * i/flyRocksNumber + rad(RandomSeed:NextNumber(-25, 25)), 0) * CFrame.Angles(rad(RandomSeed:NextNumber(25, 30)), 0, 0)).UpVector * (velocity * ExtraInfo.Radius)
							Debris:AddItem(flyingDebris, lifeTime + 1)

							local float = game:GetService("RunService").RenderStepped:Connect(function()
								for _, Infinity in pairs(game:GetService("Players"):GetPlayers()) do
									if Infinity.Configuration.Moveset.Value ~= "Strongest of Today" then
										return
									end
									local EnemyCharacter = Infinity.Character
									if EnemyCharacter == LocalCharacter then
										local Distance = flyingDebris.Position - EnemyCharacter.HumanoidRootPart.Position
										if EnemyCharacter:HasTag("Infinity") and Distance <= 10 and not flyingDebris:FindFirstChild("BodyVelocity") and not flyingDebris:GetAttribute("InfinityPlayer") then
											flyingDebris:SetAttribute("InfinityPlayer",LocalPlayer.Name)
											local BV = Instance.new("BodyVelocity", flyingDebris)
											BV.MaxForce = Vector3.new(1, 1, 1) * 100000
											BV.Velocity = Vector3.new(0, rng:NextNumber(5,15), 0)
											game:GetService("TweenService"):Create(BV,TweenInfo.new(1,Enum.EasingStyle.Sine, Enum.EasingDirection.Out),{Velocity = Vector3.new(0, 0, 0)}):Play()
										elseif ((flyingDebris:FindFirstChild("BodyVelocity") and Distance >= 10) or (flyingDebris:FindFirstChild("BodyVelocity") and not EnemyCharacter:HasTag("Infinity"))) and flyingDebris:GetAttribute("InfinityPlayer") == Infinity.Name then
											flyingDebris:SetAttribute("InfinityPlayer",nil)
											flyingDebris.BodyVelocity:Destroy()
										end
									end
								end
							end)

							task.delay(lifeTime,function()
								TS:Create(flyingDebris,TweenInfo.new(1,Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),{Size = flyingDebris.Size/2,Transparency = 1}):Play()
							end)
						end
					end
				end



				if ExtraInfo["specialRocks"] == nil then
					local XRNG1 = (ExtraInfo['XRNG1'] or ExtraInfo.Radius/2) * SizeMult
					local XRNG2 = (ExtraInfo['XRNG2'] or ExtraInfo.Radius) * SizeMult

					local RNG1 = (ExtraInfo['RNG1'] or ExtraInfo.Radius/2) * SizeMult
					local RNG2 = (ExtraInfo['RNG2'] or ExtraInfo.Radius) * SizeMult

					local xSize = rng:NextNumber(XRNG1,XRNG2)

					local RockParts = ExtraInfo.Parts
					if i > 1 then
						RockParts += ExtraInfo.RockMult * i
					end

					for i = 1,RockParts do
						local depth = rng:NextNumber(RNG1,RNG2)
						local dRP = CF * CFrame.Angles(0,2*math.pi*i/RockParts,0) * CFrame.new(0,2,-ExtraInfo.Radius * RadiusMult)

						local debrisRay = raycast(dRP.Position, -dRP.UpVector * (depth * 2), MapRayParams)
						if debrisRay then
							local debrisPart = script.Rocks.rockCircle.DefaultPart:Clone()
							debrisPart.Size = Vector3.new(xSize,depth,depth)
							debrisPart.Material = debrisRay.Material
							debrisPart.Color = debrisRay.Instance.Color
							debrisPart.CanCollide = true
							debrisPart.CollisionGroup = "Debris"

							local underGroundCF = dRP.Rotation * CFrame.new(0,-debrisPart.Size.Y/2-0.25,0) + debrisRay.Position

							local tilted = rng:NextNumber(15, 45)
							if ExtraInfo['xAngle'] then
								tilted = rng:NextNumber(ExtraInfo['xAngle']/3, ExtraInfo['xAngle'])
							end
							if ExtraInfo['Reverse'] == true then
								tilted -= tilted * 2
							end

							local originCF = underGroundCF * CFrame.new(0,1,0) * CFrame.Angles(math.rad((rng:NextNumber(15,45))),0,0) 
							debrisPart.CFrame = underGroundCF
							debrisPart.Parent = workspace.Terrain
							Debris:AddItem(debrisPart,8.5)
							TS:Create(debrisPart,TweenInfo.new(rng:NextNumber(0.025,0.1),Enum.EasingStyle.Sine, Enum.EasingDirection.Out),{CFrame = originCF}):Play()
							task.delay(rng:NextNumber(4,5),function()
								TS:Create(debrisPart,TweenInfo.new(1,Enum.EasingStyle.Sine, Enum.EasingDirection.In),{CFrame = debrisPart.CFrame * CFrame.new(0, -(debrisPart.Size.Y + debrisPart.Size.Y/2), 0)}):Play()
								task.wait(1)
								debrisPart:Destroy()
							end)
						end
					end
				end
			end

			if ExtraInfo['specialRocks'] ~= nil then
				shared.specialRocks(Raye.Instance, Raye.Position, Raye.Material, Raye.Normal, ExtraInfo['specialRocks'])
			end
		end

		if ExtraInfo.Sound ~= false and CF ~= nil then
			local DebrisSound, soundNumber, isBigDebri = nil, nil, ExtraInfo.customSoundType == 'Big' or ExtraInfo.Radius >= 18

			local function check()
				if soundNumber > #DebrisSound:GetChildren() then
					soundNumber = 1
				end
			end

			local function generateRandomSoundNumber()
				return math.random(1, #DebrisSound:GetChildren())
			end

			if isBigDebri then
				DebrisSound = Assets.Sounds.BigDebris
				soundNumber = generateRandomSoundNumber()

				if soundNumber == lastBigRockSound then
					soundNumber += 1
				end

				check()

				lastBigRockSound = soundNumber
			else
				DebrisSound = Assets.Sounds.SmallDebris
				soundNumber = generateRandomSoundNumber()

				if soundNumber == lastSmallRockSound then
					soundNumber += 1
				end

				check()

				lastSmallRockSound = soundNumber
			end

			require(RS_Modules.SoundHandler):AddSound(DebrisSound[tostring(soundNumber)], CF.Position)
		end
	end,

	rockLine = function(Info)
		local Multiplier = Info.Multiplier
		local StartSize = Info.StartSize
		local Length = Info.Length
		local Step = Info.Step
		local CF = Info.CF
		local Separation = Info.Separation/2
		local LookAtCenter = Info.LookAtCenter

		if not Multiplier then 
			Multiplier = 1.2
		end
		local Time = 1

		local Material, Color
		local InfoRaye = raycast(CF.Position,Vector3.new(0,-10+(-StartSize*2),0),MapRayParams)
		if InfoRaye and InfoRaye.Instance then
			Material = InfoRaye.Instance.Material
			Color = InfoRaye.Instance.Color
		end

		local smokefx = script.Rocks.rockLine.Smoke:Clone()
		smokefx.Parent = workspace.Effects
		smokefx.CFrame = CF
		for _,ParticleEmitter : ParticleEmitter in pairs(smokefx:GetDescendants()) do
			if ParticleEmitter:IsA('ParticleEmitter') then
				ParticleEmitter:Emit(ParticleEmitter:GetAttribute('EmitCount'))
			end
		end
		Debris:AddItem(smokefx,4)

		if Info.terrSmoke then
			local terrainSmokefx = script.Rocks.rockLine.TerrainAtt.Attachment:Clone()
			terrainSmokefx.Parent = workspace.Terrain
			terrainSmokefx.CFrame = CF * CFrame.Angles(math.rad(-90), 0, 0)
			for _,ParticleEmitter : ParticleEmitter in pairs(terrainSmokefx:GetDescendants()) do
				if ParticleEmitter:IsA('ParticleEmitter') then
					ParticleEmitter:Emit(ParticleEmitter:GetAttribute('EmitCount'))
				end
			end
			Debris:AddItem(smokefx,6.75)
		end

		coroutine.wrap(function()
			local Folder = Instance.new('Folder')
			Folder.Name = 'rockLine'
			Folder.Parent = workspace.Debris

			local Size = StartSize

			local count = Length/Step
			local TimePer = 1/count
			local currentcount = 0
			local rocks = 0

			flyRock({ Rocks = Length/Step, CFrame = CF, BaseSize = StartSize, Material = Material, Color = Color, Parent = Folder })

			for i = 0,Length,Step do
				rocks += 1

				if currentcount >= .1 then
					currentcount = 0
				end

				local currCF = CF * CFrame.new(0,0,-i)

				currentcount += TimePer
				newRock(currCF * CFrame.new(Separation + Size + Size/2,0,0), Size, 3, LookAtCenter, Step, Folder)
				newRock(currCF * CFrame.new(-Separation - Size - Size/2,0,0), Size, 3, LookAtCenter, Step, Folder)

				Size += Multiplier
			end

			game:GetService('Debris'):AddItem(Folder, 4)
		end)()
	end,

	RockFlake = function(Params : any)
		RockFlakes(Params.Char, Params.One, Params.Two, Params.Three, Params.Four)
	end,

	['No More Games'] = function(Params: { any })
		local Stage = Params.Stage;
		local Character: Model = Params.Char;
		local HumRP: BasePart = Character.HumanoidRootPart;
		local Humanoid: Humanoid = Character.Humanoid;

		local AssetsFolder = script.Jun.NMG

		if Stage == 'Jump' then
			local jumpVFX = AssetsFolder.Jump:Clone()
			jumpVFX.CFrame = HumRP.CFrame * CFrame.Angles(0.291452532, 0, 0)
			jumpVFX.Parent = workspace.Thrown
			ParticlesModule.Emit(jumpVFX)
			if Character == LocalCharacter or (HumRP.Position - LocalCharacter:GetPivot().Position).Magnitude <= 25 then
				ShakeCameraModule:ShakeCamera(19, 19, 0, .35)
			end
			Debris:AddItem(jumpVFX, 5.5)

			local airPosition = Instance.new("BodyPosition")
			airPosition.D = 22
			airPosition.P = 160
			airPosition.MaxForce = Vector3.new(1, 1, 1) * 100000
			airPosition.Position = Params.GoalPos
			airPosition.Parent = HumRP
			Debris:AddItem(airPosition, 1.934)

		elseif Stage == 'Land' then
			local landVFX = AssetsFolder.LandTeleport:Clone()
			landVFX.Position = Params.Pos
			landVFX.Parent = workspace.Thrown
			ParticlesModule.Emit(landVFX)
			Debris:AddItem(landVFX, 4)

		elseif Stage == 'GroundClaw' then
			local clawCFrame = Params.clawCFrame * CFrame.Angles(math.pi / 2, 0, math.pi / 2) + Vector3.new(0, 0.01, 0)
			local hitboxCFrame = Params.clawCFrame * CFrame.new(0, 17.5, 0) * CFrame.Angles(0, rad(-85), 0)

			local groundClaw = AssetsFolder.GroundClaw:Clone()
			groundClaw:PivotTo(clawCFrame)
			groundClaw.Parent = workspace.Thrown
			ParticlesModule.Emit(groundClaw)

			task.delay(3, function()
				for _, Beam in pairs(groundClaw:GetDescendants()) do
					if Beam:IsA("Beam") then
						BoatTween:Create(Beam, {
							Time = 1, 
							EasingStyle = 'Quad', 
							EasingDirection = 'Out', 
							Reverses = false, 
							DelayTime = 0, 
							RepeatCount = 0, 
							StepType = "Heartbeat", 
							Goal = {
								Transparency = NumberSequence.new(1)
							}
						}):Play()
					end
				end
			end)


			if Character == LocalCharacter or (clawCFrame.Position - LocalCharacter:GetPivot().Position).Magnitude <= 50 then
				ShakeCameraModule:ShakeCamera(25, 25, 0, .46)
			end
			Debris:AddItem(groundClaw, 5.7)


			DestructiblesModule:Destroy(hitboxCFrame, Vector3.new(120, 35, 35), false, (hitboxCFrame * CFrame.Angles(0, rad(90), 0)).LookVector * Vector3.new(100, 0, 100) + Vector3.new(0, 25, 0))

		elseif Stage == 'Grab' then
			local forwardTPVFX = script.Jun.NMG.ForwardTeleport:Clone()
			forwardTPVFX.Parent = Character
			forwardTPVFX.CFrame = Params.startCF
			ParticlesModule.Emit(forwardTPVFX)
			Debris:AddItem(forwardTPVFX, 10)

			if Params.Hit == false then
				local WalkVel = Instance.new('BodyVelocity')
				WalkVel.MaxForce = Vector3.new(1, 0, 1) * 40000
				WalkVel.Parent = HumRP

				local Speed = Instance.new('NumberValue')
				Speed.Value = 20
				Speed.Parent = WalkVel

				task.spawn(function()
					while task.wait() and WalkVel.Parent do
						WalkVel.Velocity = HumRP.CFrame.LookVector * Speed.Value
					end
				end)

				TS:Create(Speed, TweenInfo.new(.9, Enum.EasingStyle.Linear), { Value = 0; }):Play()

				Debris:AddItem(WalkVel, .9)
				Debris:AddItem(Speed, .9)
			end

		elseif Stage == 'Hit' then
			local ClawTimes = { 8.967, 9.133, 9.300, 9.467, 9.633, 9.800, 9.967, 10.133, 10.300, 10.450 }
			local AssetsFolder = script.Jun.NMG
			local SoundsFolder = Assets.Sounds.Jun.NMG

			local RightArm: BasePart = Character['Right Arm'];
			local Head: BasePart = Character.Head;
			local Animator: Animator = Humanoid.Animator;
			local OutsideUserAnim = AssetsFolder.NMG_User;
			local EndUserAnim = AssetsFolder.NMG_End;

			local EnemyCharacter: Model = Params.EChar;
			local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart;
			local EnemyAnimator: Animator = EnemyCharacter.Humanoid.Animator;
			local OutsideVictimAnim = AssetsFolder.NMG_Victim;


			if not AnimationCache[Animator] then
				AnimationCache[Animator] = {}
			end
			if not AnimationCache[Animator][OutsideUserAnim] then
				AnimationCache[Animator][OutsideUserAnim] = Animator:LoadAnimation(OutsideUserAnim)
			end
			if not AnimationCache[Animator][EndUserAnim] then
				AnimationCache[Animator][EndUserAnim] = Animator:LoadAnimation(EndUserAnim)
			end

			if not AnimationCache[EnemyAnimator] then
				AnimationCache[EnemyAnimator] = {}
			end
			if not AnimationCache[EnemyAnimator][OutsideVictimAnim] then
				AnimationCache[EnemyAnimator][OutsideVictimAnim] = EnemyAnimator:LoadAnimation(OutsideVictimAnim)
			end

			if Character == LocalCharacter or EnemyCharacter == LocalCharacter then
				shared.triggerHotbar(false)
				shared.triggerAwkbar(false)


				SoundsFolder.InsideCutscene:Play()


				CameraTableAnims:PlayAnimation('NMG', HumRP);
				CameraHandler:PlayCameraAnimation('NMG', HumRP);

				task.delay(1.633, function()
					shared.ActivateiFrames('NMG', { Stage = 'Skull' }, 'Jun')
				end)

				local offsets = {
					CFrame.new(0.71049118, -0.819227457, 28.009634, -1, 0, 0, 0, 1, 0, 0, 0, -1), 
					CFrame.new(0.0880661011, -0.042126894, 32.0998764, 0.231713966, 0.972783983, 0, 0, 0, 1, 0.972783983, -0.231713966, 0), 
					CFrame.new(0.777580261, 0.27737546, 27.037487, 0.0466357097, 0, 0.998911977, 0, 1, 0, -0.998911977, 0, 0.0466357097), 
					CFrame.new(-0.106033325, -0.785628557, 30.8452282, 0, 1, 0, 0, 0, 1, 1, 0, 0), 
					CFrame.new(-3.91207504, -2.30182791, 29.5179348, -1, 0, -8.74227766E-8, 0, 1, 0, 8.74227766E-8, 0, -1), 
					CFrame.new(0.574459076, 0.684072018, 33.115921, 0.231713966, 0.972783983, 0, 0, 0, 1, 0.972783983, -0.231713966, 0), 
					CFrame.new(0.777580261, -0.318288565, 28.0834866, 0.0466357097, 0, 0.998911977, 0, 1, 0, -0.998911977, 0, 0.0466357097), 
					CFrame.new(0.0880661011, 1.84627271, 30.4341278, 0, 1, 0, 0, 0, -1, -1, 0, 0), 
					CFrame.new(-3.91207504, -2.30182791, 31.3254356, -1, 0, 0, 0, 1, 0, 0, 0, -1), 
					CFrame.new(1.06085205, 0.779309511, 32.7960625, 0.231713966, 0.972783983, 0, 0, 0, 1, 0.972783983, -0.231713966, 0), 
					CFrame.new(0.777580261, -0.727227926, 29.1030865, 0.0466357097, 0, 0.998911977, 0, 1, 0, -0.998911977, 0, 0.0466357097), 
					CFrame.new(-2.24403381, 2.23440194, 31.9885387, 0, 1, 0, -0.586089611, 0, 0.810246229, 0.810246229, 0, 0.586089611), 
					CFrame.new(-3.91207504, -2.30182791, 34.1896362, -1, 0, 0, 0, 1, 0, 0, 0, -1), 
					CFrame.new(1.54692459, 0.759572268, 35.5098343, 0.231713966, 0.972783983, 0, 0, 0, 1, 0.972783983, -0.231713966, 0), 
					CFrame.new(0.721382141, -0.535927773, 32.0230865, 0.0466357097, 0, 0.998911977, 0, 1, 0, -0.998911977, 0, 0.0466357097), 
					CFrame.new(-2.04561996, -0.00390076637, 34.5606804, 0, 1, 0, 0.0431137085, 0, 0.999070168, 0.999070168, 0, -0.0431137085), 
					CFrame.new(-3.91207504, -2.30182791, 35.3154335, -1, 0, 0, 0, 1, 0, 0, 0, -1), 
					CFrame.new(1.54724503, 1.40524268, 38.9238052, 0.231713966, 0.972783983, 0, 0, 0, 1, 0.972783983, -0.231713966, 0), 
					CFrame.new(0.721382141, -1.56603026, 36.4297867, -0.208854645, 0.400972664, 0.891964674, -0.488084346, 0.747622788, -0.450371027, -0.847439349, -0.529416025, 0.0395639911), 
					CFrame.new(-1.84720612, 0.379056692, 36.9565582, 0, 1, 0, 0.427484035, 0, 0.904022813, 0.904022813, 0, -0.427484035), 
					CFrame.new(-3.91207504, -2.30182791, 37.7417336, -1, 0, 0, 0, 1, 0, 0, 0, -1), 
					CFrame.new(1.54692459, 1.40517211, 39.7390366, 0.231713966, 0.972783983, 0, 0, 0, 1, 0.972783983, -0.231713966, 0), 
					CFrame.new(0.921867371, 1.39408422, 37.4130783, 0.0365658887, 0.998001516, -0.0515369773, 0.577498615, -0.0631911755, -0.813942432, -0.815572381, 0, -0.578655064), 
					CFrame.new(-1.08403397, 2.16676688, 40.6197586, 0, 1, 0, -0.588871956, 0, 0.808226347, 0.808226347, 0, 0.588871956), 
					CFrame.new(0.710926056, -0.818827868, 41.5255737, -1, 0, 0, 0, 1, 0, 0, 0, -1), 
					CFrame.new(3.66992569, 0.885247946, 42.9402618, 0.231713966, 0.972783983, 0, 0, 0, 1, 0.972783983, -0.231713966, 0), 
					CFrame.new(0.777580261, 0.308982849, 41.8755608, 0.0466357097, 0, 0.998911977, 0, 1, 0, -0.998911977, 0, 0.0466357097), 
					CFrame.new(-0.696075439, -0.398999691, 41.5106544, 0, 1, 0, -0.290402174, 0, 0.956904709, 0.956904709, 0, 0.290402174), 
					CFrame.new(-3.91207504, -2.30182791, 43.6224365, -1, 0, 0, 0, 1, 0, 0, 0, -1), 
					CFrame.new(1.54692459, 1.40517211, 44.7205353, 0.231713966, 0.972783983, 0, 0, 0, 1, 0.972783983, -0.231713966, 0), 
					CFrame.new(1.42086792, 2.15895963, 40.0685806, 0.875162661, -0.482495815, 0.0358928107, 0.457657397, 0.122645938083720, 0.262130976, -0.156971991, -0.212980628, 0.964364588), 
					CFrame.new(-0.88993454, -1.13969016, 43.6196899, 0, 1, 0, -0.532152474, 0, 0.846648872, 0.846648872, 0, 0.532152474), 
					CFrame.new(-3.91207504, -2.30182791, 50.0821342, -1, 0, 0, 0, 1, 0, 0, 0, -1), 
					CFrame.new(1.54692459, 1.40517211, 48.6041336, 0.231713966, 0.972783983, 0, 0, 0, 1, 0.972783983, -0.231713966, 0), 
					CFrame.new(0.777580261, 0.0510718822, 47.0561867, 0.0466357097, 0, 0.998911977, 0, 1, 0, -0.998911977, 0, 0.0466357097), 
					CFrame.new(-0.695835114, -0.0266363621, 50.59729, 0, 1, 0, -0.776178539, 0, -0.630513251, -0.630513251, 0, 0.776178539), 
					CFrame.new(-3.92607498, -0.375827789, 49.6901398, -1, 0, 0, 0, 1, 0, 0, 0, -1), 
					CFrame.new(0.940616608, -0.0218617916, 51.6155777, 0.231713966, 0.972783983, 0, 0, 0, 1, 0.972783983, -0.231713966, 0), 
					CFrame.new(0.921867371, -0.730280638, 51.7416077, 1, 0, 0, 0, 0.986816168, -0.161844969, 0, 0.161844969, 0.986816168), 
					CFrame.new(0.921867371, -0.582880735, 51.7658005, 1, 0, 0, 0, 0.986817896, -0.161845312, 0, 0.161845312, 0.986817896), 
					CFrame.new(-0.695835114, -0.901750326, 45.6719093, 0, 1, 0, 0.0891725421, 0, 0.996016264, 0.996016264, 0, -0.0891725421)
				}

				local function triggerVisibility(value)
					for _,v: Part? in workspace:GetPartBoundsInRadius(Character.Torso.Position, 100) do
						if not v:IsDescendantOf(workspace.Map) then continue end

						if v.Transparency and typeof(v.Transparency) == 'number' and ((value == false and v.Transparency < 1) or value == true) then
							if value == true then
								v.Transparency = v:GetAttribute('NMGOldT') or 0
							else
								v.Transparency = 1
							end
						end
					end
				end

				local nextIndex = 1
				for Index, ClawTime in ClawTimes do
					task.delay(ClawTime, function()
						task.spawn(triggerVisibility, false)

						local blackHighlightUser = AssetsFolder.blackHighlight:Clone()
						blackHighlightUser.Parent = Character

						local blackHighlightVictim = AssetsFolder.blackHighlight:Clone()
						blackHighlightVictim.Parent = EnemyCharacter


						local currCF = HumRP.CFrame

						local RedBackground = AssetsFolder.RedBackground:Clone()
						RedBackground.Parent = workspace.Thrown
						RedBackground.CFrame = currCF * offsets[nextIndex]

						local Emit: Part = AssetsFolder['Emit'..tostring(Index)]:Clone()
						Emit.Parent = workspace.Thrown
						Emit.CFrame = currCF * offsets[nextIndex + 1]
						ParticlesModule.Emit(Emit)
						Debris:AddItem(Emit, 1)

						local Claw: Part = AssetsFolder['Claw'..tostring(Index)]:Clone()
						Claw.Parent = workspace.Thrown
						Claw.CFrame = currCF * offsets[nextIndex + 2]

						local ClawDecal: Part = AssetsFolder['ClawDecal'..tostring(Index)]:Clone()
						ClawDecal.Parent = workspace.Thrown
						ClawDecal.CFrame = currCF * offsets[nextIndex + 3]

						nextIndex = nextIndex + 4

						local ExtraClaw
						if Index == 10 then
							ExtraClaw = AssetsFolder.Claw10Extra:Clone()
							ExtraClaw.Parent = workspace.Thrown
							ExtraClaw.CFrame = currCF * offsets[40]

							for _,v in Claw:GetDescendants() do
								if v:IsA('Beam') then
									TS:Create(v, TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Width1 = 0; }):Play()	
								end
							end

							for _,v in ExtraClaw:GetDescendants() do
								if v:IsA('Beam') then
									TS:Create(v, TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Width1 = 0; }):Play()	
								end
							end
						end


						if Claw.Name == 'Claw10' then
							task.wait(.367)
						else
							task.wait(.05)
						end

						blackHighlightUser:Destroy()
						blackHighlightVictim:Destroy()
						Claw:Destroy()
						ClawDecal:Destroy()
						if ExtraClaw then ExtraClaw:Destroy() end
						RedBackground:Destroy()

						task.spawn(triggerVisibility, true)
					end)
				end

				task.delay(10.817, function()
					local release = AssetsFolder.Release:Clone()
					release.CFrame = EnemyHumRP.CFrame * CFrame.new(0.06, -0.089, -55.934)
					release.Parent = workspace.Thrown
					ParticlesModule.Emit(release)
					Debris:AddItem(release, 7)


					local blackBackground = AssetsFolder.BlackBackground:Clone()
					local emit11 = AssetsFolder.Emit11:Clone()
					local clawDecal11 = AssetsFolder.ClawDecal11:Clone()

					local mainCFrame = HumRP.CFrame


					blackBackground.CFrame = mainCFrame * offsets[37]
					emit11.CFrame = mainCFrame * offsets[38]
					clawDecal11.CFrame = mainCFrame * offsets[41]

					local userHighlight = Instance.new("Highlight")
					userHighlight.FillTransparency = 0
					userHighlight.OutlineTransparency = 1
					userHighlight.FillColor = Color3.fromRGB(255, 255, 255)

					local enemyHighlight = Instance.new("Highlight")
					enemyHighlight.FillTransparency = 0
					enemyHighlight.OutlineTransparency = 1
					enemyHighlight.FillColor = Color3.fromRGB(255, 255, 255)

					blackBackground.Parent = workspace.Thrown
					clawDecal11.Parent = workspace.Thrown
					emit11.Parent = workspace.Thrown

					ParticlesModule.Emit(emit11)

					enemyHighlight.Parent = EnemyCharacter
					userHighlight.Parent = Character
					userHighlight.Parent = Character

					Debris:AddItem(blackBackground, .04)
					Debris:AddItem(emit11, .04)
					Debris:AddItem(clawDecal11, .04)
					Debris:AddItem(userHighlight, .04)
					Debris:AddItem(enemyHighlight, .04)
				end)

				task.delay(11.333, function()
					local replay2 = AssetsFolder.Replay2:Clone()
					replay2.CFrame = CFrame.lookAlong(EnemyCharacter.Torso.Position, -HumRP.CFrame.LookVector)
					replay2.Parent = workspace.Thrown
					ParticlesModule.Emit(replay2)
					Debris:AddItem(replay2, 5)
				end)

				task.delay(11.633, function()
					local release2 = AssetsFolder.Release2:Clone()
					release2.CFrame = EnemyHumRP.CFrame * CFrame.new(0.104, -0.167, -60.649)
					release2.Parent = workspace.Thrown
					ParticlesModule.Emit(release2)
					Debris:AddItem(release2, 7)
				end)

				task.delay(11.967, function()
					local blackBackground2 = AssetsFolder.BlackBackground2:Clone()
					local textVFX = AssetsFolder.Text:Clone()
					local mainCF = HumRP.CFrame

					blackBackground2.CFrame = mainCF * CFrame.new(0.026260376, 4.11506844, 54.3320885)
					textVFX.CFrame = mainCF * CFrame.new(0.060962677, 1.18269944, 54.59729)

					blackBackground2.Parent = workspace.Thrown
					textVFX.Parent = workspace.Thrown

					TS:Create(blackBackground2, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
						Transparency = 0.3
					}):Play()

					ParticlesModule.Emit(textVFX)

					Debris:AddItem(blackBackground2, .55)
					Debris:AddItem(textVFX, 2)
				end)

				task.delay(12.667, function()
					local replay3 = AssetsFolder.Replay3:Clone()
					replay3.CFrame = CFrame.lookAlong(EnemyCharacter.Torso.Position, -HumRP.CFrame.LookVector)
					replay3.Parent = workspace.Thrown
					ParticlesModule.Emit(replay3)
					Debris:AddItem(replay3, 5)
				end)

				task.delay(12.833, function()
					shared.ActivateiFrames('NMG', { Stage = 'Rib' }, 'Jun')
				end)

				task.delay(15.383, function()
					shared.triggerHotbar(true)
					shared.triggerAwkbar(true)
				end)

				if Character == LocalCharacter then
					task.spawn(function()
						local NMGWalkEndVel = HumRP:FindFirstChild('NMGWalkEndVel') or HumRP:WaitForChild('NMGWalkEndVel', 1)
						if NMGWalkEndVel then
							Humanoid.AutoRotate = false
							Character:AddTag('CantRotate')
							NMGWalkEndVel:Destroy()
						end
					end)
				end
			else
				for _,v in Animator:GetPlayingAnimationTracks() do
					if v.Animation.AnimationId == 'rbxassetid://79867720556523' then
						v:Stop(0)
						AnimationCache[Animator][OutsideUserAnim]:Play()

						break
					end
				end

				for _,v in EnemyAnimator:GetPlayingAnimationTracks() do
					if v.Animation.AnimationId == 'rbxassetid://137504438807124' then
						v:Stop(0)
						AnimationCache[EnemyAnimator][OutsideVictimAnim]:Play()

						break
					end
				end

				local UserSound = SoundsFolder.User:Clone()
				UserSound.Parent = Character.Torso
				UserSound:Play()
				Debris:AddItem(UserSound, UserSound.TimeLength + 1)

				local VictimSound = SoundsFolder.Victim:Clone()
				VictimSound.Parent = EnemyCharacter.Torso
				VictimSound:Play()
				Debris:AddItem(VictimSound, VictimSound.TimeLength + 1)

				for Index, Time in ClawTimes do
					task.delay(Time, function()


						if Index == 10 then
							local EnemyTorsoPos: Vector3 = EnemyCharacter.Torso.Position

							local release = AssetsFolder.Release:Clone()
							release.CFrame = CFrame.lookAlong(EnemyTorsoPos, HumRP.CFrame.LookVector)
							release.Parent = workspace.Thrown
							ParticlesModule.Emit(release)
							Debris:AddItem(release, 7)
						else
							local OutsideClaw = AssetsFolder.OutsideClaw:Clone()
							OutsideClaw:PivotTo((HumRP.CFrame * CFrame.new(0, 0, 10)) * AssetsFolder['Claw'..tostring(Index)]:GetAttribute('Offset'))
							OutsideClaw.Parent = workspace.Thrown
							ParticlesModule.Emit(OutsideClaw)
							Debris:AddItem(OutsideClaw, 5)
						end
					end)
				end
			end

			task.delay(.367, function()
				local groundSlam = AssetsFolder.GroundSlam:Clone()
				groundSlam.Parent = workspace.Thrown
				groundSlam.CFrame = HumRP.CFrame
				ParticlesModule.Emit(groundSlam)
				Debris:AddItem(groundSlam, 10)
			end)

			task.delay(1.1, function()
				local kneeContact = AssetsFolder.KneeContact:Clone()
				kneeContact.Parent = workspace.Thrown
				kneeContact.CFrame = HumRP.CFrame
				ParticlesModule.Emit(kneeContact)
				Debris:AddItem(kneeContact, 10)
			end)

			task.delay(2.667, function()
				local knee = AssetsFolder.Knee:Clone()
				knee.Parent = workspace.Thrown
				knee.CFrame = HumRP.CFrame
				ParticlesModule.Emit(knee)
				Debris:AddItem(knee, 10)
			end)

			task.delay(2.967, function()
				local victimGround = AssetsFolder.VictimFall:Clone()
				victimGround.Parent = workspace.Thrown
				victimGround.CFrame = HumRP.CFrame
				ParticlesModule.Emit(victimGround)
				Debris:AddItem(victimGround, 7)
			end)

			task.delay(4.333, function()
				local eyeFlash1 = AssetsFolder.EyeFlash.Attachment1:Clone()
				local eyeFlash2 = AssetsFolder.EyeFlash.Attachment2:Clone()

				eyeFlash1.Parent, eyeFlash2.Parent = Head, Head
				Debris:AddItem(eyeFlash1, 5)
				Debris:AddItem(eyeFlash2, 5)

				local armGlare = AssetsFolder.Glare:Clone()
				armGlare.Parent = workspace.Thrown
				armGlare.CFrame = RightArm.CFrame
				ParticlesModule.Emit(armGlare)
				Debris:AddItem(armGlare, 5)


				local armAura = AssetsFolder.HandAura.Attachment:Clone()
				armAura.Parent = RightArm
				ParticlesModule.Enabled(armAura, true)
				Debris:AddItem(armGlare, 5)

				task.wait(.767)

				ParticlesModule.Enabled(armAura, false)
				ParticlesModule.Enabled(eyeFlash1, false)
				ParticlesModule.Enabled(eyeFlash2, false)


				local stance = AssetsFolder.Stance:Clone()
				stance.Parent = workspace.Thrown
				stance.CFrame = HumRP.CFrame
				ParticlesModule.Emit(stance)
				Debris:AddItem(stance, 10)
			end)

			task.delay(6.467, function()
				local fightSequenceContact = AssetsFolder.FightSequenceContact.Contact:Clone()
				fightSequenceContact.Parent = EnemyCharacter['Left Arm']
				ParticlesModule.Emit(fightSequenceContact)
				Debris:AddItem(fightSequenceContact, 2)
			end)

			task.delay(6.767, function()
				local torsoPos: Vector3 = Character.Torso.Position

				local fightSequenceContact = AssetsFolder.FightSequenceContact.Contact:Clone()
				fightSequenceContact.Parent = EnemyCharacter['Right Arm']
				ParticlesModule.Emit(fightSequenceContact)
				Debris:AddItem(fightSequenceContact, 2)

				local fightSequenceDust = AssetsFolder.FightSequenceDust:Clone()
				fightSequenceDust.CFrame = CFrame.lookAlong(Vector3.new(torsoPos.X, HumRP.Position.Y - 3, torsoPos.Z), -HumRP.CFrame.LookVector)
				fightSequenceDust.Parent = workspace.Thrown
				ParticlesModule.Emit(fightSequenceDust)
				Debris:AddItem(fightSequenceDust, 5)
			end)

			task.delay(7.067, function()
				local fightSequenceContact = AssetsFolder.FightSequenceContact.Contact:Clone()
				fightSequenceContact.Parent = Character['Right Arm']
				ParticlesModule.Emit(fightSequenceContact)
				Debris:AddItem(fightSequenceContact, 2)
			end)

			task.delay(7.35, function()
				local fightSequenceContact = AssetsFolder.FightSequenceContact.Contact:Clone()
				fightSequenceContact.Parent = Character['Left Arm']
				ParticlesModule.Emit(fightSequenceContact)
				Debris:AddItem(fightSequenceContact, 2)
			end)

			task.delay(7.533, function()
				local fightSequenceContact = AssetsFolder.FightSequenceContact.Contact:Clone()
				fightSequenceContact.Parent = EnemyCharacter['Left Arm']
				ParticlesModule.Emit(fightSequenceContact)
				Debris:AddItem(fightSequenceContact, 2)
			end)

			task.delay(7.65, function()
				local dodge = AssetsFolder.Dodge:Clone()
				dodge.Parent = workspace.Thrown
				dodge.CFrame = CFrame.lookAlong(Character.Torso.Position, HumRP.CFrame.LookVector) * CFrame.new(0, 0, -1)
				ParticlesModule.Emit(dodge)
				Debris:AddItem(dodge, 2)
			end)

			task.delay(7.883, function()
				local clawTrail = AssetsFolder.ClawHandTrail:Clone()
				clawTrail.Parent = workspace.Thrown
				clawTrail.Weld.Part0 = Character['Right Arm']
				ParticlesModule.EnableTrail(clawTrail, true)
				Debris:AddItem(clawTrail, 1)

				task.delay(.3, function()
					ParticlesModule.EnableTrail(clawTrail, false)
				end)
			end)

			task.delay(7.95, function()
				local victimSlap = AssetsFolder.VictimSlap:Clone()
				victimSlap.Parent = workspace.Thrown
				victimSlap.CFrame = CFrame.lookAlong(EnemyCharacter.Torso.Position, HumRP.CFrame.LookVector) * CFrame.Angles(0, rad(180), 0)
				ParticlesModule.Emit(victimSlap.Hit1)
				Debris:AddItem(victimSlap, 5)

				local fightSequenceDust = AssetsFolder.FightSequenceDust:Clone()
				fightSequenceDust.CFrame = CFrame.lookAlong(Vector3.new(Character.Torso.Position.X, HumRP.Position.Y - 3, Character.Torso.Position.Z), -HumRP.CFrame.LookVector)
				fightSequenceDust.Parent = workspace.Thrown
				ParticlesModule.Emit(fightSequenceDust)
				Debris:AddItem(fightSequenceDust, 5)


				task.wait(.333)


				local bodyHit1 = AssetsFolder.BodyHit:Clone()
				bodyHit1.Parent = workspace.Thrown
				bodyHit1.CFrame = CFrame.lookAlong(EnemyCharacter.Torso.Position, HumRP.CFrame.LookVector)
				ParticlesModule.Emit(bodyHit1)
				Debris:AddItem(bodyHit1, 5)

				local fightSequenceDust = AssetsFolder.FightSequenceDust:Clone()
				fightSequenceDust.CFrame = CFrame.lookAlong(Vector3.new(EnemyCharacter.Torso.Position.X, HumRP.Position.Y - 3, EnemyCharacter.Torso.Position.Z), -HumRP.CFrame.LookVector)
				fightSequenceDust.Parent = workspace.Thrown
				ParticlesModule.Emit(fightSequenceDust)
				Debris:AddItem(fightSequenceDust, 5)


				task.wait(.134)


				local bodyHit2 = AssetsFolder.BodyHit:Clone()
				bodyHit2.Parent = workspace.Thrown
				bodyHit2.CFrame = CFrame.lookAlong(EnemyCharacter.Torso.Position, HumRP.CFrame.LookVector)
				ParticlesModule.Emit(bodyHit2)
				Debris:AddItem(bodyHit2, 5)

				local fightSequenceDust = AssetsFolder.FightSequenceDust:Clone()
				fightSequenceDust.CFrame = CFrame.lookAlong(Vector3.new(EnemyCharacter.Torso.Position.X, HumRP.Position.Y - 3, EnemyCharacter.Torso.Position.Z), -HumRP.CFrame.LookVector)
				fightSequenceDust.Parent = workspace.Thrown
				ParticlesModule.Emit(fightSequenceDust)
				Debris:AddItem(fightSequenceDust, 5)

				task.wait(.2)

				local bodyHit3 = AssetsFolder.BodyHit:Clone()
				bodyHit3.Parent = workspace.Thrown
				bodyHit3.CFrame = CFrame.lookAlong(EnemyCharacter.Torso.Position, HumRP.CFrame.LookVector)
				ParticlesModule.Emit(bodyHit3)
				Debris:AddItem(bodyHit3, 5)

				local fightSequenceDust = AssetsFolder.FightSequenceDust:Clone()
				fightSequenceDust.CFrame = CFrame.lookAlong(Vector3.new(EnemyCharacter.Torso.Position.X, HumRP.Position.Y - 3, EnemyCharacter.Torso.Position.Z), -HumRP.CFrame.LookVector)
				fightSequenceDust.Parent = workspace.Thrown
				ParticlesModule.Emit(fightSequenceDust)
				Debris:AddItem(fightSequenceDust, 5)
			end)

			task.delay(13.267, function()
				local release2 = AssetsFolder.Release2:Clone()
				release2.CFrame = EnemyHumRP.CFrame * CFrame.new(-0.008, -0.16, -68.028)
				release2.Parent = workspace.Thrown
				ParticlesModule.Emit(release2)
				Debris:AddItem(release2, 7)
			end)

			local mainCF
			task.delay(15.583, function()
				mainCF = CFrame.lookAlong(Character.Torso.Position, -HumRP.CFrame.LookVector)

				if Character == LocalCharacter then
					HumRP.CFrame = mainCF

					shared.repfire('fixspeedbug')

					LocalPlayer.CameraMinZoomDistance = 100
					LocalPlayer.CameraMinZoomDistance = .5
				end

				local animTrack
				for _,v in Animator:GetPlayingAnimationTracks() do
					if v.Animation.AnimationId == 'rbxassetid://79867720556523' then
						v:Stop(0)

						break
					end
				end

				AnimationCache[Animator][EndUserAnim]:Play(0)


				local finalImpact = AssetsFolder.FinalImpact:Clone()
				finalImpact.CFrame = mainCF
				finalImpact.Parent = workspace.Thrown
				ParticlesModule.Emit(finalImpact)
				Debris:AddItem(finalImpact, 10)

				local extraVFX = AssetsFolder.Extra:Clone()
				extraVFX.Parent = workspace.Thrown
				extraVFX.CFrame = mainCF * CFrame.Angles(0, math.pi, 0)
				ParticlesModule.Emit(extraVFX)
				Debris:AddItem(extraVFX, 3)

				local beamWinds = AssetsFolder.BeamWinds:Clone()
				beamWinds.CFrame = mainCF * CFrame.Angles(0, math.pi, 0)
				beamWinds.Parent = workspace.Thrown
				for _,v in beamWinds.Beams:GetChildren() do
					if v:IsA('Beam') then
						TS:Create(v, TweenInfo.new(2.35), { TextureSpeed = .1; Brightness = 0; }):Play()
					end
				end
				Debris:AddItem(beamWinds, 2.35)

				local lines = AssetsFolder.Lines:Clone()
				lines.CFrame = mainCF + Vector3.new(0, lines.Size.Y / 2, 0)
				lines.Parent = workspace.Thrown
				task.delay(2.35, function()
					ParticlesModule.Enabled(lines, false)
				end)
				Debris:AddItem(lines, 10)

				local meshGroup = AssetsFolder.MeshGroup:Clone()
				meshGroup:PivotTo(mainCF * CFrame.new(1, 0, 0))
				meshGroup.Parent = workspace.Thrown
				Debris:AddItem(meshGroup, 1)


				TS:Create(meshGroup["3"], TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					Size = meshGroup["3"].Size + Vector3.new(meshGroup["3"].Size.X, meshGroup["3"].Size.Y * 2, meshGroup["3"].Size.Z), 
					Transparency = 1
				}):Play()

				TS:Create(meshGroup["3"], TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					CFrame = meshGroup["3"].CFrame * CFrame.new(0, -100, 0) * CFrame.Angles(0, math.pi / 2, 0)
				}):Play()


				TS:Create(meshGroup.Circle, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					Transparency = 1, 
					Size = meshGroup.Circle.Size * 2, 
					CFrame = meshGroup.Circle.CFrame * CFrame.new(0, -50, 0)
				}):Play()


				TS:Create(meshGroup.Swirls, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
					Size = meshGroup.Swirls.Size + Vector3.new(meshGroup.Swirls.Size.X / 2, meshGroup.Swirls.Size.Y * 3, meshGroup.Swirls.Size / 2), 
					CFrame = meshGroup.Swirls.CFrame * CFrame.new(0, 70, 0) * CFrame.Angles(0, math.pi, 0)
				}):Play()

				TS:Create(meshGroup.Swirls, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Transparency = 1
				}):Play()


				TS:Create(meshGroup.BeanWind.Mesh, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
					Scale = meshGroup.BeanWind.Mesh.Scale * 1.35
				}):Play()

				TS:Create(meshGroup.BeanWind, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					CFrame = meshGroup.BeanWind.CFrame * CFrame.new(0, 50, 0) * CFrame.Angles(0, -math.pi / 2, 0)
				}):Play()


				TS:Create(meshGroup.Wind2, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					CFrame = meshGroup.Wind2.CFrame * CFrame.new(65, 0, 0), 
					Transparency = 1
				}):Play()

				TS:Create(meshGroup.Wind2.Mesh, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Scale = meshGroup.Wind2.Mesh.Scale * 2 + Vector3.new(3, 0, 0)
				}):Play()


				TS:Create(meshGroup.Circle2, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					Size = Vector3.new(meshGroup.Circle2.Size.X, 0, meshGroup.Circle2.Size.Z), 
					CFrame = meshGroup.Circle2.CFrame * CFrame.new(0, meshGroup.Circle2.Size.Y / 2, 0)
				}):Play()


				Debris:AddItem(meshGroup.Circle2, .1)

				task.spawn(function()
					for i = 1, 11 do
						local currentFrame = meshGroup.BeanWind.Flip:FindFirstChild(tostring(i))
						if currentFrame then
							meshGroup.BeanWind.Mesh.TextureId = currentFrame.Texture

							task.wait(0.05)
						else
							break
						end
					end
				end)
			end)

			task.delay(15.617, function()
				SoundsModule:AddSound(SoundsFolder.Kanji, mainCF.Position)

				local kanjiCF = mainCF * CFrame.new(0, 16, -16)

				local kanji1 = AssetsFolder.Kanji1:Clone()
				kanji1.CFrame = kanjiCF
				kanji1.Parent = workspace.Thrown
				ParticlesModule.Emit(kanji1)
				Debris:AddItem(kanji1, 5)

				if Character == LocalCharacter then
					ScreenFlash(Color3.fromRGB(150, 0, 0), 0.2, 1, 0.75)
				end

				task.wait(.18181818181818182)

				local kanji2 = AssetsFolder.Kanji2:Clone()
				kanji2.CFrame = kanjiCF
				kanji2.Parent = workspace.Thrown
				ParticlesModule.Emit(kanji2)
				Debris:AddItem(kanji2, 5)

				if Character == LocalCharacter then
					ScreenFlash(Color3.fromRGB(0, 150, 0), 0.2, 1, 0.75)
				end

				task.wait(0.18181818181818182)

				local kanji3 = AssetsFolder.Kanji3:Clone()
				kanji3.CFrame = kanjiCF
				kanji3.Parent = workspace.Thrown
				ParticlesModule.Emit(kanji3)
				Debris:AddItem(kanji3, 5)

				if Character == LocalCharacter then
					ScreenFlash(Color3.fromRGB(150, 0, 150), 0.2, 1, 0.75)
				end

				task.wait(0.18181818181818182)

				local kanji4 = AssetsFolder.Kanji4:Clone()
				kanji4.CFrame = kanjiCF
				kanji4.Parent = workspace.Thrown
				ParticlesModule.Emit(kanji4)
				Debris:AddItem(kanji4, 10)

				if Character == LocalCharacter then
					ScreenFlash(Color3.fromRGB(255, 90, 0), 0.2, 1, 1.85)
				end
			end)
		end
	end,

	dragonsbreath = function(Params)
		local AssetsFolder = script.Monarch.breath

		local l_Char_0 = Params.Char;
		local l_HumanoidRootPart_0 = l_Char_0:FindFirstChild("HumanoidRootPart");
		local v23 = {};
		local v24 = AssetsFolder.Portal:Clone();
		v24:SetPrimaryPartCFrame(l_HumanoidRootPart_0.CFrame * CFrame.new(0, 1, -2));
		local l_NumberValue_0 = Instance.new("NumberValue");
		table.insert(v23, l_NumberValue_0.Changed:Connect(function() --[[ Line: 45 ]]
			v24:ScaleTo(l_NumberValue_0.Value);
		end));
		l_NumberValue_0.Value = 0.1;
		v24.Parent = workspace.Thrown;
		table.insert(v23, v24);
		TS:Create(l_NumberValue_0, TweenInfo.new(0.4, Enum.EasingStyle.Sine), {
			Value = 1
		}):Play();
		local v26 = AssetsFolder.ExtraVFX:Clone();
		v26:SetPrimaryPartCFrame(v24.PrimaryPart.CFrame * CFrame.new(0, 0, -8) * CFrame.Angles(1.5707963267948966, 0, 0));
		v26.Parent = workspace.Thrown;
		table.insert(v23, v26);
		local v27 = AssetsFolder.Beamy:Clone();
		v27:SetPrimaryPartCFrame(v26.PrimaryPart.CFrame);
		local v28 = v27.Start.PrimaryPart.CFrame:ToObjectSpace(v27.End.PrimaryPart.CFrame);
		for _, v30 in pairs(v27:GetChildren()) do
			v30:SetPrimaryPartCFrame(v26.PrimaryPart.CFrame);
		end;
		local l_NumberValue_1 = Instance.new("NumberValue");
		table.insert(v23, l_NumberValue_1.Changed:Connect(function() --[[ Line: 66 ]]
			v27:ScaleTo(l_NumberValue_1.Value);
		end));
		l_NumberValue_1.Value = 0.1;
		v27.Parent = workspace.Thrown;
		table.insert(v23, v27);
		TS:Create(l_NumberValue_1, TweenInfo.new(0.4, Enum.EasingStyle.Sine), {
			Value = 1.35
		}):Play();
		TS:Create(v27.End.PrimaryPart, TweenInfo.new(0.65, Enum.EasingStyle.Sine), {
			CFrame = v27.Start.PrimaryPart.CFrame * v28
		}):Play();
		local v32 = AssetsFolder.Center:Clone();
		local v33 = v32.PrimaryPart.Size.Z * 2;
		v32:SetPrimaryPartCFrame(v26.PrimaryPart.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0));
		v32.PrimaryPart.Size = Vector3.new(v32.PrimaryPart.Size.X, v32.PrimaryPart.Size.Y, 0.1);
		v32.Parent = workspace.Thrown;
		TS:Create(v32.PrimaryPart, TweenInfo.new(0.65, Enum.EasingStyle.Sine), {
			CFrame = v32.PrimaryPart.CFrame * CFrame.new(0, 0, -v33 / 2), 
			Size = Vector3.new(v32.PrimaryPart.Size.X, v32.PrimaryPart.Size.Y, v33)
		}):Play();
		if l_Char_0 == game.Players.LocalPlayer.Character then
			local v34 = AssetsFolder.ColorCorrection:Clone();
			v34.Parent = game.Lighting;
			TS:Create(v34, TweenInfo.new(2, Enum.EasingStyle.Sine), {
				TintColor = Color3.new(1, 1, 1), 
				Brightness = 0, 
				Saturation = 0, 
				Contrast = 0
			}):Play();
			table.insert(v23, v34);
		end;
		table.insert(v23, v32);
		deltaTimeWait(3.033);
		TS:Create(v32.PrimaryPart, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
			Transparency = 1
		}):Play();
		for _, v36 in pairs(v23) do
			if tostring(v36) ~= "Connection" then
				ParticlesModule.Enabled(v36, false)
				for _, v38 in pairs(v36:GetDescendants()) do
					if v38:IsA("Beam") then
						BoatTween:Create(v38, {
							Time = RandomSeed:NextNumber(0.2, 0.5), 
							EasingStyle = "Linear", 
							Goal = {
								Transparency = NumberSequence.new({
									NumberSequenceKeypoint.new(0, 1), 
									NumberSequenceKeypoint.new(1, 1)
								})
							}
						}):Play()
						game.Debris:AddItem(v38, 0.5);
					end;
				end;
			end;
		end;
		deltaTimeWait(2);
		for _, v40 in pairs(v23) do
			if tostring(v40) == "Connection" then
				v40:Disconnect();
			else
				v40:Destroy();
			end;
		end;
	end,

	rulersauthority = function(Params)
		local Stage = Params.Stage
		local AssetsFolder = script.Monarch.ruler

		if Stage == 'Start' then
			local warningVFX = AssetsFolder.Warning:Clone()
			warningVFX.Weld.Part0 = Params.Part
			warningVFX.Parent = workspace.Thrown

			task.delay(0.8, function()
				ParticlesModule.Enabled(warningVFX, false)
			end)

			ParticlesModule.Emit(warningVFX)
			Debris:AddItem(warningVFX, 1.3)

		elseif Stage == "Hit" then
			local Character: Model = Params.Char
			local HumRP: BasePart = Character.HumanoidRootPart

			local Victim: Model = Params.Victim


			local LeftArm: BasePart = Character:FindFirstChild("Left Arm")
			local RightArm: BasePart = Character:FindFirstChild("Right Arm")
			if LeftArm and RightArm then
				local leftWarningVFX = AssetsFolder.Warning:Clone()
				leftWarningVFX.Weld.Part0 = LeftArm
				leftWarningVFX.Parent = workspace.Thrown
				ParticlesModule.Emit(leftWarningVFX)
				Debris:AddItem(leftWarningVFX, 2)


				deltaTimeWait(0.385)


				local VictimTorso = Victim:FindFirstChild("Torso");
				if VictimTorso then
					local grabbedVFX = AssetsFolder.Grabbed:Clone()
					grabbedVFX.Weld.Part0 = VictimTorso
					grabbedVFX.Parent = workspace.Thrown

					local rightWarningVFX = AssetsFolder.Warning:Clone()
					rightWarningVFX.Weld.Part0 = RightArm
					rightWarningVFX.Parent = workspace.Thrown
					ParticlesModule.Enabled(rightWarningVFX, true)
					Debris:AddItem(rightWarningVFX, 2)

					for _, Particle in pairs(grabbedVFX:GetDescendants()) do
						if Particle:IsA("ParticleEmitter") and Particle:GetAttribute("EmitDuration") and Particle:GetAttribute("EmitDuration") > 0.6 then
							Particle:SetAttribute("EmitDuration", 1.5)
						end
					end

					ParticlesModule.Emit(grabbedVFX)
					Debris:AddItem(grabbedVFX, 5)


					local groundRay = raycast(VictimTorso.Position, Vector3.new(0, -7.5, 0), MapRayParams)
					if groundRay then
						deltaTimeWait(0.175)

						for i = 1, 2 do
							local slamVFX = AssetsFolder.Slam:Clone()
							slamVFX:SetPrimaryPartCFrame(CFrame.new(groundRay.Position))
							slamVFX.Parent = workspace.Thrown
							ParticlesModule.Emit(slamVFX)
							slamVFX:ScaleTo((math.clamp(i * 1.3, 1, 1.8)))

							deltaTimeWait(0.25)

							Debris:AddItem(slamVFX, 5)
						end
					end
					ParticlesModule.Enabled(rightWarningVFX, false)


					deltaTimeWait(0.25)


					local spinVFX = AssetsFolder.Spin:Clone()
					spinVFX.CFrame = CFrame.new(Victim.PrimaryPart.Position, HumRP.Position) * CFrame.Angles(0, 0, 1.5707963267948966)
					spinVFX.Parent = workspace.Thrown
					ParticlesModule.Emit(spinVFX)
					Debris:AddItem(spinVFX, 5)


					deltaTimeWait(0.625)


					local finalVFX = AssetsFolder.Final:Clone()
					finalVFX.CFrame = CFrame.new(VictimTorso.Position, HumRP.Position) * CFrame.Angles(1.5707963267948966, 0, 0)
					finalVFX.Parent = workspace.Thrown
					ParticlesModule.Emit(finalVFX)
					Debris:AddItem(finalVFX, 5)

					local Last2 = AssetsFolder.Last2:Clone()
					Last2.CFrame = finalVFX.CFrame * CFrame.new(0, -15, 0) * CFrame.Angles(0, 0, 3.141592653589793)
					TS:Create(Last2, TweenInfo.new(0.45, Enum.EasingStyle.Exponential), { Transparency = 1, Size = Vector3.new(4.578, 41.979, 4.536), CFrame = Last2.CFrame * CFrame.new(-9, 0, 0) }):Play()
					Debris:AddItem(Last2, 0.45)

					local Last3 = AssetsFolder.Last3:Clone()
					Last3.CFrame = finalVFX.CFrame * CFrame.new(0, -15, 0) * CFrame.Angles(0, 0, 3.141592653589793)
					TS:Create(Last3, TweenInfo.new(0.35, Enum.EasingStyle.Exponential), { Transparency = 1, Size = Vector3.new(16.918, 1.943, 16.918), CFrame = Last2.CFrame * CFrame.new(-14.687999999965541, 0, 0) }):Play()
					Debris:AddItem(Last3, 0.35)

					local Last = AssetsFolder.Last:Clone()
					Last.CFrame = finalVFX.CFrame * CFrame.new(0, -70, 0) * CFrame.Angles(0, 0, -1.5707963267948966)
					TS:Create(Last, TweenInfo.new(0.35, Enum.EasingStyle.Exponential), { Transparency = 1, Size = Vector3.new(46.778, 44.418, 44.45), CFrame = Last2.CFrame * CFrame.new(-14.687999999965541, 0, 0) }):Play()
					TS:Create(Last.Mesh, TweenInfo.new(0.35, Enum.EasingStyle.Exponential), { Scale = Vector3.new(2.046, 1.476, 1.428) }):Play()
					TS:Create(Last.Decal, TweenInfo.new(0.35, Enum.EasingStyle.Exponential), { Transparency = 1 }):Play()
					Debris:AddItem(Last, 0.35)

					local slamVFX = AssetsFolder.Slam:Clone()
					slamVFX:SetPrimaryPartCFrame(finalVFX.CFrame)
					slamVFX.Parent = workspace.Thrown
					ParticlesModule.Emit(slamVFX)
					Debris:AddItem(slamVFX, 5)
				end
			end

		elseif Stage == "Finisher" then
			AssetsFolder = AssetsFolder.Finisher

			local Character: Model = Params.Char
			local HumRP: BasePart = Character.HumanoidRootPart
			local LeftArm = Character["Left Arm"]
			local RightArm = Character["Right Arm"]

			local EnemyCharacter: Model = Params.Victim


			local warningVFX = AssetsFolder.Warning:Clone()
			local warningWeld = Instance.new("Weld");
			warningWeld.Part0 = warningVFX.PrimaryPart;
			warningWeld.Part1 = LeftArm;
			warningWeld.Parent = warningVFX.PrimaryPart;
			warningWeld.C0 = CFrame.new(0, 1, 0);
			warningVFX.Parent = workspace.Thrown;
			warningVFX:ScaleTo(1.5);
			ParticlesModule.Emit(warningVFX);
			Debris:AddItem(warningVFX, 7)

			deltaTimeWait(0.25)

			local hitVFX = AssetsFolder.Hit:Clone()

			for _, v97 in pairs(hitVFX:GetDescendants()) do
				if v97:IsA("ParticleEmitter") then
					v97.ZOffset += 1;
				end;
			end;

			hitVFX:ScaleTo(2);
			hitVFX:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, 0, 0));
			hitVFX.Parent = workspace.Thrown
			ParticlesModule.Emit(hitVFX)
			ParticlesModule.scaleLifetime(hitVFX, 1.5)
			Debris:AddItem(hitVFX, 5)

			local Mesh1 = AssetsFolder.Mesh1:Clone();
			Mesh1:ScaleTo(1.7);
			Mesh1:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, 0, -3));
			PlayMesh({
				Model = Mesh1, 
				T = 0, 
				EndT = 0.6, 
				Info = TweenInfo.new(0.08, Enum.EasingStyle.Sine)
			});
			Debris:AddItem(Mesh1, 0.08)

			local Go = AssetsFolder.Go:Clone();
			Go:ScaleTo(0.4);
			Go:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, 0, -4) * CFrame.Angles(1.5707963267948966, 0, 0));
			PlayMesh({
				Model = Go, 
				Info = TweenInfo.new(0.1, Enum.EasingStyle.Exponential), 
				T = 1
			});
			Debris:AddItem(Go, 0.1)

			local impactWhiteVFX = AssetsFolder.ImpactWhite:Clone()
			impactWhiteVFX:ScaleTo(0.7)
			impactWhiteVFX:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, 0, -4) * CFrame.Angles(0, 0, 0));
			ParticlesModule.scaleLifetime(impactWhiteVFX, 0.3)
			impactWhiteVFX.Parent = workspace.Thrown
			ParticlesModule.Emit(impactWhiteVFX)
			Debris:AddItem(impactWhiteVFX, 5)

			local generalVFX = AssetsFolder.General:Clone()
			generalVFX:ScaleTo(0.5);
			generalVFX:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, -HumRP.Size.Y * 1.5, 0) * CFrame.Angles(1.5707963267948966, 0, 0));
			generalVFX.Parent = workspace.Thrown
			ParticlesModule.Emit(generalVFX)
			Debris:AddItem(generalVFX, 5)

			local smokeRingVFX = AssetsFolder.SmokeRing:Clone()
			smokeRingVFX:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, -HumRP.Size.Y * 1.5, 0) * CFrame.Angles(0, 0, 0));
			smokeRingVFX.Parent = workspace.Thrown
			ParticlesModule.Emit(smokeRingVFX)
			ParticlesModule.Emit(warningVFX)
			Debris:AddItem(smokeRingVFX, 5)

			deltaTimeWait(0.37)

			hitVFX:ScaleTo(2.5)
			hitVFX:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, 0, -4) * CFrame.Angles(0, 0, 0));
			ParticlesModule.Emit(hitVFX)

			local Mesh1_1 = AssetsFolder.Mesh1:Clone();
			Mesh1_1:ScaleTo(2.3);
			Mesh1_1:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, 0, -3));
			PlayMesh({
				Model = Mesh1_1, 
				T = 0, 
				EndT = 0.6, 
				Info = TweenInfo.new(0.08, Enum.EasingStyle.Sine)
			});
			Debris:AddItem(Mesh1_1, 0.08)

			local Mesh2 = AssetsFolder.Mesh2:Clone();
			Mesh2:ScaleTo(2);
			Mesh2:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, 0, -8) * CFrame.Angles(1.5707963267948966, 0, 0));
			PlayMesh({
				Model = Mesh2, 
				T = 0, 
				EndT = 0.6, 
				Info = TweenInfo.new(0.08, Enum.EasingStyle.Sine)
			});
			Debris:AddItem(Mesh2, 0.08)

			local Go_1 = AssetsFolder.Go:Clone();
			Go_1:ScaleTo(0.4);
			Go_1:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, 0, -4) * CFrame.Angles(1.5707963267948966, 0, 0));
			PlayMesh({
				Model = Go_1, 
				Info = TweenInfo.new(0.1, Enum.EasingStyle.Exponential), 
				T = 1
			});
			Debris:AddItem(Go_1, 0.1)

			local impactWhiteVFX_1 = AssetsFolder.ImpactWhite:Clone()
			impactWhiteVFX_1:ScaleTo(0.85);
			impactWhiteVFX_1:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, 0, -4) * CFrame.Angles(0, 0, 0));
			ParticlesModule.scaleLifetime(impactWhiteVFX_1, 0.3)
			impactWhiteVFX_1.Parent = workspace.Thrown;
			ParticlesModule.Emit(impactWhiteVFX_1);
			Debris:AddItem(impactWhiteVFX_1, 5)

			local generalVFX_1 = AssetsFolder.General:Clone()
			generalVFX_1:ScaleTo(0.7);
			generalVFX_1:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, -HumRP.Size.Y * 1.5, 0) * CFrame.Angles(1.5707963267948966, 0, 0));
			generalVFX_1.Parent = workspace.Thrown;
			ParticlesModule.Emit(generalVFX_1);
			Debris:AddItem(generalVFX_1, 5)

			local smokeRing_1 = AssetsFolder.SmokeRing:Clone()
			smokeRing_1:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, -HumRP.Size.Y * 1.5, 0) * CFrame.Angles(0, 0, 0));
			smokeRing_1.Parent = workspace.Thrown;
			smokeRing_1:ScaleTo(1.2);
			ParticlesModule.Emit(smokeRing_1);
			Debris:AddItem(smokeRing_1, 5)

			ParticlesModule.Emit(warningVFX)

			deltaTimeWait(0.35)

			ParticlesModule.Emit(warningVFX)

			local Mesh1_2 = AssetsFolder.Mesh1:Clone();
			Mesh1_2:ScaleTo(3);
			Mesh1_2:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0.5235987755982988, 0, 0));
			PlayMesh({
				Model = Mesh1_2, 
				T = 0, 
				EndT = 1, 
				Info = TweenInfo.new(0.2, Enum.EasingStyle.Exponential)
			})
			Debris:AddItem(Mesh1_2, 0.2)

			local Mesh2_1 = AssetsFolder.Mesh2:Clone();
			Mesh2_1:ScaleTo(3);
			Mesh2_1:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, 0, -8) * CFrame.Angles(2.0943951023931953, 0, 0));
			PlayMesh({
				Model = Mesh2_1, 
				T = 0, 
				EndT = 1, 
				Info = TweenInfo.new(0.1, Enum.EasingStyle.Exponential)
			})
			Debris:AddItem(Mesh2_1, 0.1)

			hitVFX:ScaleTo(3.5);
			hitVFX:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0.5235987755982988, 0, 0));
			ParticlesModule.Emit(hitVFX)

			local Go_2 = AssetsFolder.Go:Clone();
			Go_2:ScaleTo(0.7);
			Go_2:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, 0, -8) * CFrame.Angles(2.0943951023931953, 0, 0));
			PlayMesh({
				Model = Go_2, 
				Info = TweenInfo.new(0.2, Enum.EasingStyle.Exponential), 
				T = 1
			})
			Debris:AddItem(Go_2, 0.2)

			local impactWhiteVFX_2 = AssetsFolder.ImpactWhite:Clone()
			impactWhiteVFX_2:ScaleTo(1);
			ParticlesModule.scaleLifetime(impactWhiteVFX_2, 0.7)
			impactWhiteVFX_2:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, 0, -4) * CFrame.Angles(0.5235987755982988, 0, 0));
			impactWhiteVFX_2.Parent = workspace.Thrown
			ParticlesModule.Emit(impactWhiteVFX_2)
			Debris:AddItem(impactWhiteVFX_2, 0.7)

			local generalVFX_2 = AssetsFolder.General:Clone()
			generalVFX_2:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, -HumRP.Size.Y * 1.5, 0) * CFrame.Angles(1.5707963267948966, 0, 0));
			generalVFX_2.Parent = workspace.Thrown
			ParticlesModule.Emit(generalVFX_2)
			Debris:AddItem(generalVFX_2, 5)

			local smokeRing_2 = AssetsFolder.SmokeRing:Clone()
			smokeRing_2:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, -HumRP.Size.Y * 1.5, 0) * CFrame.Angles(0, 0, 0));
			smokeRing_2.Parent = workspace.Thrown
			smokeRing_2:ScaleTo(1.5)
			ParticlesModule.Emit(smokeRing_2)
			Debris:AddItem(smokeRing_2, 5)

			local warningVFX_1 = AssetsFolder.Warning:Clone()
			local l_Weld_1 = Instance.new("Weld")
			l_Weld_1.Part0 = warningVFX_1.PrimaryPart
			l_Weld_1.Part1 = RightArm
			l_Weld_1.Parent = warningVFX_1.PrimaryPart
			l_Weld_1.C0 = CFrame.new(0, 1, 0)
			warningVFX_1.Parent = workspace.Thrown
			warningVFX_1:ScaleTo(1.5)
			ParticlesModule.Emit(warningVFX_1);
			ParticlesModule.Enabled(warningVFX, true)
			ParticlesModule.Enabled(warningVFX_1, true)
			Debris:AddItem(warningVFX_1, 5)

			task.delay(0.2, function()
				local grabbedVFX_1 = AssetsFolder.Grabbed:Clone()
				local grabbedVFX_1_Weld = Instance.new("Weld")
				grabbedVFX_1_Weld.Part0 = grabbedVFX_1.PrimaryPart
				grabbedVFX_1_Weld.Part1 = EnemyCharacter.Torso
				grabbedVFX_1_Weld.Parent = grabbedVFX_1.PrimaryPart
				grabbedVFX_1_Weld.C0 = CFrame.new(0, 1, 0)
				grabbedVFX_1.Parent = workspace.Thrown
				grabbedVFX_1:ScaleTo(1.7)
				ParticlesModule.Emit(grabbedVFX_1)
				Debris:AddItem(grabbedVFX_1, 5)
			end)

			deltaTimeWait(0.8)

			ParticlesModule.Enabled(warningVFX, false)
			ParticlesModule.Enabled(warningVFX_1, false)

			local nextHitVFX = AssetsFolder.NextHit:Clone()
			nextHitVFX:ScaleTo(5.5)
			ParticlesModule.scaleLifetime(nextHitVFX, 1.1)
			nextHitVFX:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, 0, -4) * CFrame.Angles(0, 0, 0));
			nextHitVFX.Parent = workspace.Thrown
			ParticlesModule.Emit(nextHitVFX)
			Debris:AddItem(nextHitVFX, 1.1)

			local slamVFX = AssetsFolder.Slam:Clone()
			slamVFX:ScaleTo(1.2)
			ParticlesModule.scaleLifetime(slamVFX, 1.6)
			slamVFX:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, 0, -4) * CFrame.Angles(1.5707963267948966, 0, 0));
			slamVFX.Parent = workspace.Thrown
			ParticlesModule.Emit(slamVFX)
			Debris:AddItem(slamVFX, 1.6)

			local smokeRingVFX_3 = AssetsFolder.SmokeRing:Clone()
			smokeRingVFX_3:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, -HumRP.Size.Y * 1.5, 0) * CFrame.Angles(0, 0, 0));
			smokeRingVFX_3.Parent = workspace.Thrown;
			smokeRingVFX_3:ScaleTo(2.5);
			ParticlesModule.Emit(smokeRingVFX_3);
			Debris:AddItem(smokeRingVFX_3, 5)

			local impactWhiteVFX_3 = AssetsFolder.ImpactWhite:Clone()
			impactWhiteVFX_3:ScaleTo(1.5);
			ParticlesModule.scaleLifetime(impactWhiteVFX_3, 0.7)
			impactWhiteVFX_3:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, 0, -4));
			impactWhiteVFX_3.Parent = workspace.Thrown
			ParticlesModule.Emit(impactWhiteVFX_3)
			Debris:AddItem(impactWhiteVFX_3, 0.7)

		end
	end,

	deadlyimpale = function(Params)
		local Stage = Params.Stage
		local AssetsFolder = script.Monarch.impale

		if Stage == 'Hit' then
			local Character: Model = Params.Char
			local HumRP: BasePart = Character.HumanoidRootPart

			local sungGrabAssets = AssetsFolder.SungGrab:Clone()
			Debris:AddItem(sungGrabAssets, 5)

			local bloodVFX = sungGrabAssets.Blood
			local bloodVFX_2 = sungGrabAssets.Blood
			local slashVFX = sungGrabAssets.Slash
			local dashVFX = sungGrabAssets.Dash
			local firstKickVFX = sungGrabAssets.FirstKick
			local lastKickVFX = sungGrabAssets.LastKick
			sungGrabAssets.Parent = workspace.Thrown

			local isFinisher = Params.Finisher
			local EnemyCharacter: Model = Params.EChar
			local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
			local EnemyTorso: BasePart = EnemyCharacter.Torso


			bloodVFX.CFrame = EnemyTorso.CFrame
			ParticlesModule.Emit(bloodVFX)

			task.wait(0.815)

			ParticlesModule.scaleLifetime(bloodVFX_2, 1.5)
			bloodVFX_2.CFrame = EnemyTorso.CFrame * CFrame.new(0, 0, 4)
			ParticlesModule.Emit(bloodVFX_2)

			task.wait(0.5)

			local vfxCount = 9
			task.spawn(function()
				slashVFX.CFrame = HumRP.CFrame * CFrame.new(0, 0, 6)
				ParticlesModule.Enabled(slashVFX, true)

				if Character ~= LocalCharacter then
					vfxCount = 5
				end

				if isFinisher then
					vfxCount /= 1.5
				end


				for _ = 1, vfxCount do
					for _, Part: BasePart in Character:GetChildren() do
						if Part:IsA("BasePart") and Part.Name ~= "HumanoidRootPart" then
							local flashStepVFX = sungGrabAssets.FlashStep:Clone()
							flashStepVFX.Parent = Part
							ParticlesModule.Emit(Part)

							task.delay(0.175, function()
								flashStepVFX:Destroy()
							end)
						end
					end


					for i = 1, 3 do
						local torsoCFrame = Character.Torso.CFrame

						for _ = 1, math.random(1, 2) do
							local slashMeshPart = AssetsFolder.SlashMesh:Clone()

							if math.random(1, 2) == 1 then
								slashMeshPart.Color = Color3.new(0.454902, 0.952941, 1)
							else
								slashMeshPart.Color = Color3.new(0.501961, 0.0627451, 1)
							end

							local slashMeshCFrame = torsoCFrame * CFrame.new(math.random(-5, 5), 0, math.random(-8, -3)) * CFrame.Angles(rad((math.random(-360, 360))), rad((math.random(-360, 360))), (rad((math.random(-360, 360)))))
							slashMeshPart.CFrame = slashMeshCFrame

							local slashMesh = slashMeshPart.Mesh
							slashMesh.Scale = Vector3.new(0.25, math.random(2, 4), 0.25)
							slashMeshPart.Parent = workspace.Thrown


							local barrageVFX = AssetsFolder.SoloLevelingBarrage:Clone()
							barrageVFX:SetPrimaryPartCFrame(slashMeshCFrame)
							barrageVFX:ScaleTo(RandomSeed:NextNumber(0.5, 0.8))
							barrageVFX.Parent = workspace.Thrown

							ParticlesModule.scaleLifetime(barrageVFX, RandomSeed:NextNumber(0.1, 0.25))
							ParticlesModule.Emit(barrageVFX)


							TS:Create(slashMesh, TweenInfo.new(0.05, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
								Scale = Vector3.new(0, 7, 0)
							}):Play()


							Debris:AddItem(slashMeshPart, 0.05)
							Debris:AddItem(barrageVFX, .5)
						end

						if math.random(1, 2) == 1 then
							local windTimeCFrame = torsoCFrame * CFrame.new(math.random(-5, 5), 0, math.random(-8, -3)) * CFrame.Angles(math.rad((math.random(-360, 360))), math.rad((math.random(-360, 360))), (math.rad((math.random(-360, 360)))));
							local tnTime = RandomSeed:NextNumber(0.05, 0.13)

							local windTimeContainer = AssetsFolder.windTimeContainer:Clone()
							local windTimePart = windTimeContainer.WindTime

							windTimeContainer:ScaleTo(RandomSeed:NextNumber(0.45, 0.7))

							windTimePart.CFrame = windTimeCFrame * CFrame.Angles(math.rad((RandomSeed:NextNumber(-45, 45))), math.rad((RandomSeed:NextNumber(0, 360))), (math.rad((RandomSeed:NextNumber(-45, 45)))))
							windTimePart.Transparency = 0.9

							TS:Create(windTimePart, TweenInfo.new(tnTime, Enum.EasingStyle.Sine), { Transparency = 1, Size = Vector3.new(45.028, 6.59, 43.615), CFrame = windTimePart.CFrame * CFrame.new(0, 0.26999999999999996, 0) * CFrame.Angles(0, rad(90), 0) }):Play()

							Debris:AddItem(windTimePart, tnTime)
						end

						if i % 4 == 0 then
							deltaTimeWait(0.01)
						end
					end

					task.wait(0.0225)
				end

				ParticlesModule.Enabled(slashVFX, false)
			end)

			if not isFinisher then
				task.wait(0.0225 * vfxCount - 0.35)


				task.spawn(function()
					local startTime = os.clock()

					task.wait(0.1)

					ParticlesModule.Enabled(dashVFX, true)

					while true do
						dashVFX.CFrame = Character.Torso.CFrame

						task.wait(0.01)

						if os.clock() >= startTime + 0.5 then
							ParticlesModule.Enabled(dashVFX, false)
							return
						end
					end
				end)

				task.wait(0.25)

				firstKickVFX.CFrame = EnemyTorso.CFrame
				ParticlesModule.Emit(firstKickVFX)

				task.wait(0.45)

				lastKickVFX.Position = EnemyTorso.Position
				ParticlesModule.scaleLifetime(lastKickVFX, 0.7)
				ParticlesModule.Emit(lastKickVFX)

				Debris:AddItem(sungGrabAssets, 2.5)
			end

		elseif Stage == "Finisher" then
			AssetsFolder = AssetsFolder.Finisher

			local Character = Params.Char
			local HumRP = Character.HumanoidRootPart

			local EnemyCharacter = Params.Victim


			task.delay(0.9, function()
				local kickVFX = AssetsFolder.kick:Clone()
				kickVFX.CFrame = HumRP.CFrame * CFrame.new(0.5399779081344604, -0.4348022937774658, -3.8899173736572266)
				kickVFX.Parent = workspace.Thrown
				ParticlesModule.Emit(kickVFX)
				Debris:AddItem(kickVFX, 10)
			end)

			local flashVFX
			task.delay(1.5, function()
				flashVFX = AssetsFolder.Flash:Clone()
				local flashVFX_Weld = Instance.new("Weld")
				flashVFX_Weld.Part0 = Character.Torso
				flashVFX_Weld.Part1 = flashVFX
				flashVFX_Weld.Parent = flashVFX
				flashVFX.Parent = workspace.Thrown
				Debris:AddItem(flashVFX, 5)
				task.spawn(function()
					for _ = 1, 6 do
						ParticlesModule.Emit(flashVFX)

						task.wait(0.05)
					end
				end)
			end)

			local hitVFX
			task.delay(1.683, function()
				local smoke1VFX = AssetsFolder.smoke1:Clone()
				smoke1VFX.CFrame = HumRP.CFrame * CFrame.new(0.5958333015441895, -2.499999761581421, 5.391363143920898)
				smoke1VFX.Parent = workspace.Thrown
				ParticlesModule.Emit(smoke1VFX)
				Debris:AddItem(smoke1VFX, 10)

				hitVFX = AssetsFolder.hit:Clone()
				local hitVFX_Weld = Instance.new("Weld")
				hitVFX_Weld.Part0 = EnemyCharacter.Torso
				hitVFX_Weld.Part1 = hitVFX
				hitVFX_Weld.Parent = hitVFX
				hitVFX.Parent = workspace.Thrown
				ParticlesModule.Emit(hitVFX)
				Debris:AddItem(hitVFX, 10)

				local rushVFX = AssetsFolder.rush:Clone()
				rushVFX.CFrame = HumRP.CFrame * CFrame.new(0.5010548830032349, -0.4999997615814209, 8.391550064086914)
				rushVFX.Parent = workspace.Thrown
				ParticlesModule.Emit(rushVFX)
				Debris:AddItem(rushVFX, 10)

				local torsoVFX = AssetsFolder.Torso:Clone()
				local torsoVFX_Weld = Instance.new("Weld")
				torsoVFX_Weld.Part0 = Character.Torso
				torsoVFX_Weld.Part1 = torsoVFX
				torsoVFX_Weld.Parent = torsoVFX
				torsoVFX.Parent = workspace.Thrown
				ParticlesModule.Emit(torsoVFX)
				Debris:AddItem(torsoVFX, 10)
			end)

			task.delay(2.367, function()
				local rushVFX_2 = AssetsFolder.rush:Clone()
				rushVFX_2.CFrame = HumRP.CFrame * CFrame.new(0.4512416124343872, -0.4999997615814209, -20.285350799560547) * CFrame.Angles(-6.875487050354845E-13, -3.1359012126922607, 1.2080296485361686E-10)
				rushVFX_2.Parent = workspace.Thrown
				ParticlesModule.Emit(rushVFX_2)
				Debris:AddItem(rushVFX_2, 10)

				local windup2VFX = AssetsFolder.windup2:Clone()
				windup2VFX.CFrame = HumRP.CFrame * CFrame.new(0.23621845245361328, 1.5340006351470947, -15.323966026306152) * CFrame.Angles(1.2080469957709283E-10, 1.57266366481781, 1.5707963705062866)
				windup2VFX.Parent = workspace.Thrown
				ParticlesModule.Emit(windup2VFX)
				Debris:AddItem(windup2VFX, 10)

				ParticlesModule.Emit(hitVFX)
				ParticlesModule.Emit(flashVFX)
			end)


			local jumpCount = 1
			local function Jump(CF)
				local jumpVFX = AssetsFolder:FindFirstChild("jump" .. jumpCount):Clone()
				jumpVFX.CFrame = CF
				jumpVFX.Parent = workspace.Thrown
				ParticlesModule.Emit(jumpVFX)
				Debris:AddItem(jumpVFX, 10)

				jumpCount += 1

				ParticlesModule.Emit(flashVFX)
				ParticlesModule.Emit(hitVFX)

				return jumpVFX
			end


			local Jump1
			task.delay(2.883, function()
				Jump1 = Jump(HumRP.CFrame * CFrame.new(-0.40700316429138184, -2.499999761581421, -1.041276216506958) * CFrame.Angles(2.2557663744739165E-13, 0.0018672813894227147, -1.2080469957709283E-10))
			end)

			local Jump2
			task.delay(3.2, function()
				Jump2 = Jump(HumRP.CFrame * CFrame.new(-0.43828949332237244, 0.9555625915527344, -17.796274185180664) * CFrame.Angles(2.2557663744739165E-13, 0.0018672813894227147, -1.2080469957709283E-10))
			end)

			local Jump3
			task.delay(3.367, function()
				Jump3 = Jump(HumRP.CFrame * CFrame.new(-0.4054871201515198, 3.5944626331329346, -0.22937524318695068) * CFrame.Angles(2.2557663744739165E-13, 0.0018672813894227147, -1.2080469957709283E-10))
			end)

			task.delay(3.533, function()
				ParticlesModule.Emit(flashVFX)
				ParticlesModule.Emit(hitVFX)
				Jump2.CFrame *= CFrame.new(0, 3, 0)
				ParticlesModule.Emit(Jump2)
			end)

			task.delay(3.7, function()
				ParticlesModule.Emit(Jump1)
				Jump1.CFrame *= CFrame.new(0, 3, 0)
			end)

			task.delay(3.833, function()
				ParticlesModule.Emit(flashVFX)
				ParticlesModule.Emit(hitVFX)
				ParticlesModule.Emit(Jump3)
				Jump3.CFrame *= CFrame.new(0, 3, 0)
			end)

			task.delay(3.967, function()
				ParticlesModule.Emit(flashVFX)
				ParticlesModule.Emit(hitVFX)
				Jump2.CFrame *= CFrame.new(0, 3, 0)
				ParticlesModule.Emit(Jump2)
			end)

			task.delay(4.133, function()
				ParticlesModule.Emit(Jump1)
				Jump1.CFrame *= CFrame.new(0, 3, 0)
			end)

			task.delay(4.25, function()
				ParticlesModule.Emit(flashVFX)
				ParticlesModule.Emit(hitVFX)
				ParticlesModule.Emit(Jump3)
				Jump3.CFrame *= CFrame.new(0, 3, 0)
			end)

			task.delay(4.967, function()
				local groundImpactVFX = AssetsFolder.groundimpact:Clone()
				groundImpactVFX.CFrame = HumRP.CFrame * CFrame.new(0.5717493295669556, -2.499999761581421, -7.506531715393066)
				groundImpactVFX.Parent = workspace.Thrown
				ParticlesModule.Emit(groundImpactVFX)
				Debris:AddItem(groundImpactVFX, 10)
			end)

			task.delay(5.467, function()
				local windup3VFX = AssetsFolder.windup3:Clone()
				windup3VFX.CFrame = HumRP.CFrame * CFrame.new(0.5717493295669556, -2.499999761581421, -7.506531715393066) * CFrame.Angles(0, 3.141592653589793, 0)
				windup3VFX.Parent = workspace.Thrown
				ParticlesModule.Emit(windup3VFX)
				Debris:AddItem(windup3VFX, 10)
			end)

			task.delay(6.017, function()
				local telekinesisVFX = AssetsFolder.telekinesis:Clone()
				telekinesisVFX.CFrame = HumRP.CFrame * CFrame.new(-0.574070155620575, 0.5651977062225342, -4.455648899078369)
				telekinesisVFX.Parent = workspace.Thrown
				ParticlesModule.Emit(telekinesisVFX)
				Debris:AddItem(telekinesisVFX, 10)
			end)
		end
	end,

	ReversalRed = function(Params)
		local Character : Model = Params.Char
		local Stage = Params.Stage
		local HumRP : BasePart = Character.HumanoidRootPart
		local RedMax = script["Strongest of Today"].ReversalRed.ReversalRedMax:Clone()
		local ProjectileRedMax = game.ReplicatedStorage.Assets.Projectiles.RedProjectile:Clone()


		if Stage == "Start" then

			task.spawn(function()
				local BodyGyro = Instance.new("BodyGyro", HumRP)
				BodyGyro.P = 10000
				BodyGyro.MaxTorque = Vector3.one * 40000
				--ProjectileRedMax.Position = HumRP.Position + Vector3.new(0, 12, 0)
				ProjectileRedMax.Parent = workspace.Thrown
				repeat
					BodyGyro.CFrame = CFrame.new(HumRP.Position, FXModule:GetMouseTarget())
					task.wait()
				until not ProjectileRedMax.Parent
				BodyGyro:Destroy()
			end)

			task.spawn(function()
				local arg1_4 = RedMax
				arg1_4.Weld.Part1 = Character['Right Arm']
				arg1_4.Parent = workspace.Thrown
				Debris:AddItem(arg1_4,1.2)
				TS:Create(arg1_4, TweenInfo.new(1), {
					Size = Vector3.one;
				}):Play()
				TS:Create(arg1_4.Light, TweenInfo.new(1), {
					Brightness = 15;
					Range = 15;
				}):Play()
				--var4_upvw:PlaySound(Sounds_upvr.Gojo.ReversalRed.MaxCharge, arg1_4, game.SoundService.Effect)
				TS:Create(arg1_4.Weld, TweenInfo.new(0.95, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
					C1 = arg1_4.Weld.C1 * CFrame.new(0, 0, -4);
				}):Play()
				task.wait(0.3)
				TS:Create(arg1_4.Beam, TweenInfo.new(1), {
				}):Play()
				TS:Create(arg1_4.Beam2, TweenInfo.new(0.75), {
				}):Play()
				TS:Create(arg1_4.AttachmentEnd, TweenInfo.new(0.75), {
					Position = Vector3.new(0, 0, 18);
				}):Play()
				task.wait(0.1)
				task.wait(0.35)
			end)
			task.delay(1.2,function()
				local clone_4 = script["Strongest of Today"].ReversalRed.RedExplode:Clone()
				local clone_7 = script["Strongest of Today"].ReversalRed.RedMaxFire:Clone()
				clone_4.Position = RedMax.Position
				clone_4.Parent = workspace.Thrown
				Debris:AddItem(clone_4, 1.6)
				clone_4.Burst:Emit(1)
				clone_4.Sparks:Emit(15)
				clone_4.Wind:Emit(6)
				clone_4.Dust:Emit(6)
				TS:Create(clone_4.Light, TweenInfo.new(0.5), {
					Brightness = 0;
				}):Play()
				clone_7.Parent = workspace.Effects
				clone_7.CFrame = HumRP.CFrame * CFrame.new(0, -1, -55)
				clone_7.Sparks:Emit(75)
				clone_7.Attachment.ChargeFire:Emit(10)
				TS:Create(clone_7, TweenInfo.new(0.3), {
					Size = Vector3.new(0, 0, 100);
					Color = Color3.new(1, 0, 0);
				}):Play()
				Debris:AddItem(clone_7, 1)
				ProjectileRedMax:Destroy()
				if LocalCharacter == Character then
					ShakeCameraModule:KanjiCamShake(8, 14, 0, 1.25,Vector3.new(0.5, 0.5, 0),Vector3.new(0, 0, 0))
					local clone_2 = script.Misc.BlackFlashCC:Clone()
					clone_2.Parent = game.Lighting
					task.wait(0.04)
					clone_2.TintColor = Color3.new(1, 1, 1)
					task.wait(0.04)
					clone_2.Brightness = 200
					clone_2.Contrast = -1000
					task.wait(0.04)
					clone_2:Destroy()
				end
				--var4_upvw:PlaySound(Sounds_upvr.Gojo.ReversalRed.Explode, clone_4, game.SoundService.Effect)
			end)	
		elseif Stage == "Hit" then
			local arg1_7 = Params.Enemy
			FXModule:Flash(arg1_7, Color3.new(1, 1, 1))
			--var4_upvw:PlaySound(Sounds_upvr.Gojo.M1:FindFirstChild("Hit"..math.random(1, 4)), HumanoidRootPart_3, game.SoundService.Effect)
			if LocalCharacter == arg1_7 then
				ShakeCameraModule:KanjiCamShake(8, 14, 0, 1.25,Vector3.new(0.5, 0.5, 0),Vector3.new(0, 0, 0))
				local clone_6 = script.Misc.BlackFlashCC:Clone()
				clone_6.Parent = game.Lighting
				task.wait(0.04)
				clone_6.TintColor = Color3.new(1, 1, 1)
				task.wait(0.04)
				clone_6.Brightness = 200
				clone_6.Contrast = -1000
				task.wait(0.04)
				clone_6:Destroy()
			end
		end;	

	end,
	shadowvanish = function(Params)
		local Stage = Params.Stage
		local AssetsFolder = script.Monarch.vanish

		if Stage == 'Start' then
			local Character = Params.Char
			local HumRP = Character.HumanoidRootPart

			for i = 1, 2 do
				local startFlorVFX = AssetsFolder.StarFlor:Clone()
				startFlorVFX:ScaleTo(2.5 * i)
				startFlorVFX:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, -HumRP.Size.Y * 1.5, 0) * CFrame.Angles(0, 0, 0))
				startFlorVFX.Parent = workspace.Thrown
				ParticlesModule.Emit(startFlorVFX)
				Debris:AddItem(startFlorVFX, 1)
				deltaTimeWait(0.1)
			end
		elseif Stage == "Dash" then

			local Character: Model = Params.Char
			local HumRP: BasePart = Character.HumanoidRootPart


			local assetsContainer = {}
			local mainCF = Params.mainCF
			for i = 1, 33 do
				local currentCF = mainCF * CFrame.new(0, 0, -i * 1.5)

				for i2 = 1, math.random(1, 2) do
					local slashMeshContainer = AssetsFolder.SlashMesh:Clone()
					table.insert(assetsContainer, slashMeshContainer)

					if math.random(1, 2) == 1 then
						slashMeshContainer.Color = Color3.new(0.454902, 0.952941, 1)
					else
						slashMeshContainer.Color = Color3.new(0.501961, 0.0627451, 1)
					end

					local slashMeshCF = currentCF * CFrame.new(math.random(-5, 5), 0, math.random(-8, -3)) * CFrame.Angles(math.rad((math.random(-360, 360))), math.rad((math.random(-360, 360))), (math.rad((math.random(-360, 360)))));
					slashMeshContainer.CFrame = slashMeshCF

					local slashMesh = slashMeshContainer.Mesh
					slashMesh.Scale = Vector3.new(0.25, math.random(2, 4), 0.25)
					slashMeshContainer.Parent = workspace.Thrown
					TS:Create(slashMesh, TweenInfo.new(0.05, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { Scale = Vector3.new(0, 7, 0) }):Play()
					Debris:AddItem(slashMeshContainer, 0.05)


					local barrageVFX = AssetsFolder.SoloLevelingBarrage:Clone()
					barrageVFX:SetPrimaryPartCFrame(slashMeshCF)
					barrageVFX:ScaleTo(RandomSeed:NextNumber(0.5, 0.8))
					barrageVFX.Parent = workspace.Thrown

					ParticlesModule.scaleLifetime(barrageVFX, RandomSeed:NextNumber(0.1, 0.25))
					ParticlesModule.Emit(barrageVFX)

					Debris:AddItem(barrageVFX, 0.25)
				end

				if math.random(1, 2) == 1 then
					local windCF = currentCF * CFrame.new(math.random(-5, 5), 0, math.random(-8, -3)) * CFrame.Angles(math.rad((math.random(-360, 360))), math.rad((math.random(-360, 360))), (math.rad((math.random(-360, 360)))));
					local windTimeTweenTime = RandomSeed:NextNumber(0.05, 0.13)

					local windTimeContainer = AssetsFolder.windTimeContainer:Clone()
					local windTime = windTimeContainer.WindTime
					windTimeContainer:ScaleTo(RandomSeed:NextNumber(0.45, 0.7))
					windTime.CFrame = windCF * CFrame.Angles(math.rad((RandomSeed:NextNumber(-45, 45))), math.rad((RandomSeed:NextNumber(0, 360))), (math.rad((RandomSeed:NextNumber(-45, 45)))))
					TS:Create(windTime, TweenInfo.new(windTimeTweenTime, Enum.EasingStyle.Sine), { Transparency = 1, Size = Vector3.new(45.028, 6.59, 43.615), CFrame = windTime.CFrame * CFrame.new(0, 0.2699999999999996, 0) * CFrame.Angles(0, 90, 0) }):Play()
					Debris:AddItem(windTime, windTimeTweenTime)


					local forwardWaveContainer = AssetsFolder.forwardWaveContainer:Clone()
					local forwardWave = forwardWaveContainer.ForwardWave
					forwardWaveContainer:ScaleTo(RandomSeed:NextNumber(0.35, 0.7))
					forwardWave.CFrame = mainCF * CFrame.new(0, 0, 3) * CFrame.Angles(0, -1.5707963267948966, 0)
					TS:Create(forwardWave, TweenInfo.new(0.025, Enum.EasingStyle.Sine), { CFrame = forwardWave.CFrame * CFrame.new(0, 29.741, 0), Size = Vector3.new(70.618, 4.462, 4.462) }):Play()
					Debris:AddItem(forwardWave, 0.025)
				end

				if i % 4 == 0 then
					deltaTimeWait(0.01)
				end
			end

			local beamsRedux = AssetsFolder.BeamsRedux:Clone()
			beamsRedux:SetPrimaryPartCFrame(mainCF * CFrame.new(0, -4, -66) * CFrame.Angles(0, 3.141592653589793, 0));
			beamsRedux:ScaleTo(0.75)

			for _, attachment in beamsRedux:GetDescendants() do
				if string.match(attachment.Name, "Far") then
					local goalCF = attachment.CFrame

					attachment.CFrame *= CFrame.new(0, 0, 10)

					TS:Create(attachment, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {
						CFrame = goalCF
					}):Play()
				end
			end

			local beamsSpeeds = {}
			for _, Beam in beamsRedux:GetDescendants() do
				if Beam:IsA("Beam") then
					beamsSpeeds[Beam] = Beam.TextureSpeed
				end
			end

			local textureSpeed = Instance.new("NumberValue")
			textureSpeed.Parent = beamsRedux
			textureSpeed.Changed:Connect(function()
				for i, v in pairs(beamsSpeeds) do
					i.TextureSpeed = v * textureSpeed.Value
				end
			end)

			textureSpeed.Value = 3.5

			task.delay(0.1, function()
				TS:Create(textureSpeed, TweenInfo.new(0.76, Enum.EasingStyle.Sine), {
					Value = 0.1
				}):Play()
			end)


			local beamsTransparencies = {}
			for _, Beam in beamsRedux:GetDescendants() do
				if Beam:IsA("Beam") then
					beamsTransparencies[Beam] = Beam.Transparency
				end
			end

			local beamsTransparency = Instance.new("NumberValue")
			beamsTransparency.Parent = beamsRedux
			beamsTransparency.Changed:Connect(function()
				for i, v in beamsTransparencies do
					local Keypoints = v.Keypoints

					for i2, v2 in pairs(v.Keypoints) do
						Keypoints[i2] = NumberSequenceKeypoint.new(v2.Time, v2.Value * beamsTransparency.Value)
					end

					i.Transparency = NumberSequence.new(Keypoints)
				end
			end)

			TS:Create(beamsTransparency, TweenInfo.new(1, Enum.EasingStyle.Sine), {
				Value = 1.2
			}):Play()

			beamsTransparency.Value = 1

			beamsRedux.Parent = workspace.Thrown
			Debris:AddItem(beamsRedux, 1)


			local Wind2 = AssetsFolder.Wind2:Clone()
			Wind2.PrimaryPart.CFrame = mainCF * CFrame.new(0, -HumRP.Size.Y * 1.5, -56.1)
			Wind2.Parent = workspace.Thrown
			ParticlesModule.scaleLifetime(Wind2, 0.4)
			Wind2:ScaleTo(3)
			ParticlesModule.Emit(Wind2)
			Debris:AddItem(Wind2, 0.4)

		elseif Stage == 'Finisher' then
			AssetsFolder = AssetsFolder.Finisher

			local Character: Model = Params.Char
			local HumRP: BasePart = Character.HumanoidRootPart

			local VictimHumRP: BasePart = Params.VictimRoot



			task.delay(0.133, function() -- stare
				for _, Particle in pairs({
					AssetsFolder.Attachments.impact, 
					AssetsFolder.Attachments.star
					})
				do
					local particleClone = Particle:Clone()
					particleClone.Parent = Character.Head
					ParticlesModule.Emit(particleClone)
					Debris:AddItem(particleClone, 3)
				end
			end)


			task.delay(1.233, function() -- dash
				local dash2VFX = AssetsFolder.dash2:Clone()
				dash2VFX.CFrame = VictimHumRP.CFrame * CFrame.new(0.349761962890625, -0.4999990463256836, 10) * CFrame.Angles(-0, -1.5707963705062866, -1.5707963705062866) * CFrame.Angles(0, 0, 0)
				dash2VFX.Parent = workspace.Thrown
				ParticlesModule.Emit(dash2VFX)
				Debris:AddItem(dash2VFX, 5)


				for _, Dagger in pairs({
					Character.Daggers.Dagger1, 
					Character.Daggers.Dagger2
					})
				do
					local daggerVFX = AssetsFolder.DaggerSTuff:Clone()
					for _, Particle in daggerVFX:GetChildren() do
						Particle.Parent = Dagger.PrimaryPart
						Debris:AddItem(Particle, 5)
					end

					ParticlesModule.Enabled(Dagger, true)
				end
			end)


			task.delay(2.333, function() -- stab
				if LocalConfigFolder.Blood.Value == true then
					local mainKetchVFX = AssetsFolder.Attachments.MainKetch:Clone()
					mainKetchVFX.Parent = Character.Daggers.Dagger2.PrimaryPart
					ParticlesModule.Emit(mainKetchVFX)
					Debris:AddItem(mainKetchVFX, 5)

					local bloodVFX = AssetsFolder.Blood:Clone()
					bloodVFX.CFrame = HumRP.CFrame * CFrame.new(0, -HumRP.Size.Y * 1.5, 2)
					bloodVFX.Parent = workspace.Thrown
					ParticlesModule.Emit(bloodVFX)
					Debris:AddItem(bloodVFX, 5)
				end

				for _, v in pairs({
					Character.Daggers.Dagger1, 
					Character.Daggers.Dagger2
					})
				do
					ParticlesModule.Enabled(v, false)
				end
			end)

			task.delay(3.167, function()
				local dash3VFX = AssetsFolder.dash3:Clone()
				dash3VFX.CFrame = VictimHumRP.CFrame * CFrame.new(0.349761962890625, -0.4999990463256836, 15) * CFrame.Angles(-0, -1.5707963705062866, -1.5707963705062866) * CFrame.Angles(-1.5707963267948966, 0, 0)
				dash3VFX.Parent = workspace.Thrown
				ParticlesModule.Emit(dash3VFX)
				Debris:AddItem(dash3VFX, 5)

				local slashingVFX = AssetsFolder.slashing:Clone()
				slashingVFX.CFrame = VictimHumRP.CFrame * CFrame.new(0, 0, -3.5)
				slashingVFX.Parent = workspace.Thrown
				ParticlesModule.Enabled(slashingVFX, true)
				Debris:AddItem(slashingVFX, 5)

				task.delay(.983, function()
					ParticlesModule.Enabled(slashingVFX, false)

					local midVFX = AssetsFolder.mid:Clone()
					midVFX.CFrame = VictimHumRP.CFrame * CFrame.new(0, 0, -4) * CFrame.Angles(0, -1.5707963267948966, 0)
					midVFX.Parent = workspace.Thrown
					ParticlesModule.Emit(midVFX)
					Debris:AddItem(midVFX, 5)
				end)
			end)
		end
	end,

	['Shadowblade Storm'] = function(Params: { any })
		local Stage = Params.Stage
		local AssetsFolder = script.Monarch.storm

		if Stage == "Start" then
			local Character: Model = Params.Char
			local HumRP: BasePart = Character.HumanoidRootPart


			local smokeVFX = AssetsFolder.Smoke:Clone()

			local smokeWeld = Instance.new("Weld")
			smokeWeld.Part0 = HumRP
			smokeWeld.Part1 = smokeVFX
			smokeWeld.C0 = CFrame.new(0, -3, 0)
			smokeWeld.Parent = smokeVFX

			smokeVFX.Parent = workspace.Thrown
			Debris:AddItem(smokeVFX, 3)


			local startTick = tick()


			local barrageVFX = AssetsFolder.SoloLevelingBarrage:Clone()
			barrageVFX:SetPrimaryPartCFrame(HumRP.CFrame * CFrame.new(0, 0, -4))

			local barrageWeld = Instance.new("Weld")
			barrageWeld.Part0 = barrageVFX.PrimaryPart
			barrageWeld.Part1 = HumRP
			barrageWeld.C0 = CFrame.new(0, 0, 4)
			barrageWeld.Parent = barrageVFX.PrimaryPart

			barrageVFX.Parent = workspace.Thrown
			ParticlesModule.scaleLifetime(barrageVFX, .35)

			for _, Particle in pairs(barrageVFX:GetDescendants()) do
				if Particle:IsA("ParticleEmitter") then
					Particle.Rate = Particle.Rate * 1.35
				end
			end


			while tick() - startTick < 0.75 and not Character:HasTag('stopStorm') do
				ParticlesModule.Emit(smokeVFX)

				for i = 1, math.random(2, 5) do
					local slashMeshContainer = AssetsFolder.SlashMesh:Clone()

					if math.random(1, 2) == 1 then
						slashMeshContainer.Color = Color3.new(0.454902, 0.952941, 1)
					else
						slashMeshContainer.Color = Color3.new(0.501961, 0.0627451, 1)
					end

					slashMeshContainer.CFrame = HumRP.CFrame * CFrame.new(math.random(-5, 5), 0, math.random(-8, -3)) * CFrame.Angles(math.rad((math.random(-360, 360))), math.rad((math.random(-360, 360))), (math.rad((math.random(-360, 360)))))


					local slashMesh = slashMeshContainer.Mesh
					slashMesh.Scale = Vector3.new(0.1, math.random(2, 4), 0.1)

					slashMeshContainer.Parent = workspace.Thrown

					TS:Create(slashMesh, TweenInfo.new(0.05, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
						Scale = Vector3.new(0, 7, 0, 0)
					}):Play()

					Debris:AddItem(slashMeshContainer, 0.05)
				end

				local Wind = AssetsFolder.Wind:Clone()
				Wind.CFrame = HumRP.CFrame * CFrame.new(math.random(-5, 5), 0, math.random(-8, -3)) * CFrame.Angles(math.rad((math.random(-360, 360))), math.rad((math.random(-360, 360))), (math.rad((math.random(-360, 360)))))
				Wind.Parent = workspace.Thrown

				TS:Create(Wind, TweenInfo.new(0.15, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
					Size = Wind.Size + Vector3.new(15, 4, 15, 0), 
					Transparency = 1
				}):Play()

				Debris:AddItem(Wind, 0.25)


				task.wait(0.02)
			end

			ParticlesModule.Enabled(barrageVFX, false)
			Debris:AddItem(barrageVFX, 3)
			Debris:AddItem(smokeVFX, 2)

		elseif Stage == 'Finisher' then
			local Character: Model = Params.Character
			local HumRP: BasePart = Character.HumanoidRootPart

			Character:AddTag('stopStorm')

			task.wait(.983)

			Character:RemoveTag('stopStorm')

			local DashVel = Instance.new('BodyVelocity')
			DashVel.MaxForce = Vector3.new(1, 1, 1) * math.huge
			DashVel.Velocity = HumRP.CFrame.LookVector * 100
			DashVel.Parent = HumRP
			Debris:AddItem(DashVel, .7)

			local DashConnection = RNS.RenderStepped:Connect(function()
				if DashVel and DashVel.Parent then
					DashVel.Velocity = HumRP.CFrame.LookVector * 100
				end
			end)

			TS:Create(DashVel, TweenInfo.new(.234), { Velocity = Vector3.zero }):Play()

			task.wait(.234)

			DashVel.Velocity = HumRP.CFrame.LookVector * 100
			TS:Create(DashVel, TweenInfo.new(.233), { Velocity = Vector3.zero }):Play()

			task.wait(.233)

			DashVel.Velocity = HumRP.CFrame.LookVector * 100
			TS:Create(DashVel, TweenInfo.new(.233), { Velocity = Vector3.zero }):Play()

			task.wait(.233)

			DashConnection:Disconnect()
		end
	end,

	['Unlimited Flex Works'] = function(Params)
		local Stage = Params.Stage
		local Character = Params.Char
		local HumRP: BasePart = Character.HumanoidRootPart;
		local EnemyCharacter = Params.Enemy
		if Stage == 'Start' then
			if LocalPlayer.Configuration['Awakening Music'].Value == true then
				Assets.Sounds.flexworks.Volume = 2.5
				Assets.Sounds.flexworks:Play()
			end
			if Character == LocalCharacter or EnemyCharacter == LocalCharacter then
				CameraHandler:PlayCameraAnimation("FlexWorks",HumRP)				
			end
		end
	end,

	DomainExpansion = function(Params : any)
		local humRP : BasePart = LocalCharacter.HumanoidRootPart
		local HumanoidRootPart : BasePart = Params.Char.HumanoidRootPart
		local playerGui = l_PlayerGui_0
		if Params.Stage == "DomainGui" then
			local Holder = playerGui.DomainGUI.Holder

			--local parameterList = {
			--	DomainName = Params.DomainName,
			--	DomainRadius = Params.DomainRadius,
			--	Action = Params.Action,
			--	ExpandingAnimation = Params.DomainAnimation
			--}

			if (humRP.Position - HumanoidRootPart.Position).Magnitude <= Params.DomainRadius then
				if Params.Action == "AddGui" then
					local CharToAdd = Params.Char

					local template = script.Domain[Params.DomainName.."_Template"]:Clone()
					template.Parent = Holder
					template.Name = CharToAdd.Name
					template.Size = UDim2.new(1, 0, 0, 0)
					Debris:AddItem(template, 20)

					TS:Create(template.BorderTop.DOMAIN,
						TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{AnchorPoint = Vector2.new(1, .5)}
					):Play()

					TS:Create(template.BorderBottom.EXPANSION,
						TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{AnchorPoint = Vector2.new(0, .5)}
					):Play()

					CharToAdd.Archivable = true

					local clone : Model = template.ViewportFrame.WorldModel
					--clone.Animate.Enabled = false
					--clone.HumanoidRootPart.Anchored = true
					--clone.Parent = template.ViewportFrame.WorldModel
					FXModule.ApplyCopyOutfit(Params.Char,clone)
					--clone:PivotTo(template.ViewportFrame.WorldModel.NPC.PrimaryPart.CFrame * CFrame.new(0, 1, 0))

					for _, child in pairs(clone:GetChildren()) do
						if child:IsA("BaseScript") then
							child:Destroy()
						end
					end


					CharToAdd.Archivable = false

					local DomanWarn : AnimationTrack
					local Duration : number
					if Params.DomainName == "GojoDomain" then
						DomanWarn = AnimEvents:loadAnimation(clone, script['Gojo'].InfiniteVoid.Anims.DomainWarn)
						Duration = 1.28
					elseif Params.DomainName == "SukunaDomain" then
						DomanWarn = AnimEvents:loadAnimation(clone, script.Sukuna.Domain.DomainWarn)
						Duration = 1.28	
					end

					DomanWarn:Play()

					if DomanWarn.IsPlaying then
						task.delay(Duration,function()
							DomanWarn:AdjustSpeed(0)
						end)
					end

					local camera = Instance.new("Camera")
					camera.Parent = template.ViewportFrame
					camera.CFrame = CFrame.new(23.327, 3.669, -1.228) * CFrame.Angles(math.rad(-2.352), math.rad(-92.281), math.rad(10))
					camera.CFrame = camera.CFrame * CFrame.new(0, 0, -2)
					camera.CFrame = template.ViewportFrame.WorldModel.HumanoidRootPart.CFrame * CFrame.new(0, 1, -5) * CFrame.Angles(0, 3.141592653589793, 0)

					camera.FieldOfView = 40

					--TS:Create(camera,
					--	TweenInfo.new(3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
					--	{CFrame = camera.CFrame * CFrame.new(0, -0.5, 3) * CFrame.Angles(math.rad(-5), 0, math.rad(5))}
					--):Play()

					local totalFrame = #Holder:GetChildren()
					if totalFrame >= 3 then
						for index, child in pairs(Holder:GetChildren()) do
							if child:IsA("Frame") then
								local DomainText = child.BorderTop:FindFirstChild("DOMAIN")
								local ExpansionText = child.BorderBottom:FindFirstChild("EXPANSION")

								if index ~= 2 then
									--// index is not 2, meaning its 3 or more (as 1st is excluded, its not a frame)
									if totalFrame ~= index then
										--// im not on the last frame
										if DomainText then DomainText:Destroy() end
										if ExpansionText then ExpansionText:Destroy() end
									else
										--// im on the last frame
										if DomainText then DomainText:Destroy() end
									end
								else
									--// index is 2, so this is the first template in my holder list
									if ExpansionText then ExpansionText:Destroy() end
								end
							end
						end
					end

					local connection
					connection = RNS.RenderStepped:Connect(function()
						if template and template.Parent then
							camera.FieldOfView = 33 * template.Size.Y.Scale / .4
							template.ViewportFrame.CurrentCamera = camera
						else
							connection:Disconnect()
							connection = nil
						end
					end)

					--template.ViewportFrame.WorldModel.NPC:Destroy()
					template.ViewportFrame.CurrentCamera = camera

				elseif Params.Action == "End" then
					Holder:SetAttribute("End", true)

					task.delay(.1, function()
						Holder:SetAttribute("End", false)
					end)
				end

				if Params.Action == "StartClashing" then
					Holder:SetAttribute("Clashing", true)

				elseif Params.Action == "StopClashing" then
					Holder:SetAttribute("ClashingWinner", Params.Winner.Name)
					Holder:SetAttribute("Clashing", false)
				end
			end
		elseif Params.Stage == "Domain Bubble" then
			local parameterList = {
				Position = Params.Position,
				Color = Params.Color or Color3.fromRGB(255, 255, 255),
				FadeDuration = Params.FadeDuration or 1,
				InitialSize = Params.IntitialeSize or Vector3.new(1, 1, 1),
				GoalSize = Params.GoalSize or Vector3.new(25, 25, 25)
			}

			--// Effect
			local CreateEffect = coroutine.wrap(function()
				local bubble = script.Domain.BubbleExpansionPart:Clone()
				bubble.Parent = workspace.Effects
				bubble.Position = parameterList.Position
				bubble.Size = parameterList.InitialSize
				Debris:AddItem(bubble, parameterList.FadeDuration + 1)

				local SizeTween = TS:Create(bubble,
					TweenInfo.new(parameterList.FadeDuration, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), 
					{Size = parameterList.GoalSize}
				)

				SizeTween:Play()
				SizeTween.Completed:Once(function()
					TS:Create(bubble,
						TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
						{Transparency = 1}
					):Play()
				end)
			end)

			CreateEffect()
		elseif Params.Stage == "HighLight" then
			local parameterList = {
				Target = Params.Char,
				Color = Params.Color or Color3.fromRGB(255, 255, 255),
				OutColor = Params.OutColor or Color3.fromRGB(255, 255, 255),
				FadeDuration = Params.FadeDuration or 1
			}

			--// Effect
			local CreateEffect = coroutine.wrap(function()
				--// Create Highlight
				if parameterList.Target:FindFirstChild("Highlight") then
					parameterList.Target:FindFirstChild("Highlight"):Destroy()
				end

				local highlight = script.Domain.Highlight:Clone()
				highlight.Parent = parameterList.Target
				highlight.FillColor = parameterList.Color
				highlight.OutlineColor = parameterList.OutColor
				Debris:AddItem(highlight, 3)

				TS:Create(highlight,
					TweenInfo.new(parameterList.FadeDuration, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), 
					{FillTransparency = 1, OutlineTransparency = 1}
				):Play()
			end)

			CreateEffect()
		end
	end,
	Domains = function(Params : any)
		local Stage = Params.Stage;
		local Function = Params.Function

		if Stage == "Gojo" then
			if Function == "StartUp" then
				--if Params.Char == LocalCharacter then
				local DomainCollider = Params.DomainCollider
				local Opening = Params.Opening
				local Sound = Params.Sound
				local p21 = Opening

				local Travel = script['Gojo'].InfiniteVoid.DomainTravel:Clone()
				Travel.CFrame = DomainCollider.CFrame
				Travel.Lines.CFrame = DomainCollider.CFrame
				Travel.Parent = Opening
				local DomainBG = script['Gojo'].InfiniteVoid.DomainBG:Clone()
				DomainBG.CFrame = DomainCollider.CFrame 
				p21.Destroying:Connect(function()
					Travel:Destroy()
					DomainBG:Destroy()
				end)

				local Ground = p21.DomainGround
				Ground.Surround.Enabled = true
				TS:Create(Ground.Surround, TweenInfo.new(0.8), {
					["ShapePartial"] = 1
				}):Play()
				--FXModule.PlaySound(Assets.Sounds.Domain, workspace, game.SoundService.Effect, true)
				game.Debris:AddItem(Ground, 2)
				--FXModule.PlaySound(Assets.Sounds.Gojo["Infinite Void"].Domain, workspace, game.SoundService.Effect)
				task.delay(0.8, function()

					TS:Create(Ground, TweenInfo.new(0.4), {
						["Transparency"] = 0
					}):Play()
					FXModule.DomainMapFade(Color3.new(1, 1, 1), 0.4, 1.6)
				end)
				task.wait(1.5)
				Travel.Dissolve:Emit(100)
				Travel.Dissolve.Enabled = true
				TS:Create(Travel, TweenInfo.new(0.2), {
					["Transparency"] = 1
				}):Play()
				TS:Create(Travel.Dissolve, TweenInfo.new(0.5), {
					["ShapePartial"] = 0,
					["Rate"] = 50
				}):Play()
				task.delay(0.5, function()

					Travel.Dissolve.Enabled = false
				end)
				local Lines = Travel.Lines
				Travel.SpaceBG.Enabled = true
				game.Debris:AddItem(Travel, 2.4)
				local RenderV1 = nil
				RenderV1 = game:GetService("RunService").RenderStepped:Connect(function()
					if Lines.Parent then
						Lines.Position = (workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -5)).Position
					else
						RenderV1:Disconnect()
					end
				end)
				if DomainCollider and DomainCollider.Parent then
					--local Music = FXModule.PlaySound(Assets.Sounds.Gojo["Infinite Void"].Music, workspace, game.SoundService.Effect, true)
					game.SoundService.AmbientReverb = Enum.ReverbType.Arena
					DomainCollider.Destroying:Connect(function()

						game.SoundService.AmbientReverb = Enum.ReverbType.NoReverb
						--TS:Create(Music, TweenInfo.new(2), {
						--	["Volume"] = 0
						--}):Play()
						--game.Debris:AddItem(Music, 2)
					end)
					ShakeCameraModule:ShakeCamera(5, 25, 2.4, 0.5)
					TS:Create(workspace.CurrentCamera, TweenInfo.new(2.3, Enum.EasingStyle.Circular, Enum.EasingDirection.In), {
						["FieldOfView"] = 120
					}):Play()
					task.delay(2.4, function()

						workspace.CurrentCamera.FieldOfView = 0
						TS:Create(workspace.CurrentCamera, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
							["FieldOfView"] = 70
						}):Play()
					end)
					task.delay(1, function()

						local v30 = Instance.new("ColorCorrectionEffect", game.Lighting)
						TS:Create(v30, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
							["Contrast"] = 3,
							["Brightness"] = 0.5
						}):Play()
						task.wait(1)
						TS:Create(v30, TweenInfo.new(0.3), {
							["Contrast"] = 3.5,
							["Brightness"] = 4
						}):Play()
						task.wait(0.4)
						v30.Contrast = 0
						TS:Create(v30, TweenInfo.new(0.4), {
							["Brightness"] = 0
						}):Play()
						game.Debris:AddItem(v30, 0.5)
					end)
					task.wait(2.4)
					if DomainCollider and DomainCollider.Parent then
						DomainBG.Parent = Opening
						DomainBG.Splatter1:Emit(70)
						DomainBG.Splatter2:Emit(70)
						DomainBG.Smoke1:Emit(20)
						local Render = nil
						Render = game:GetService("RunService").RenderStepped:Connect(function()

							if not DomainCollider.Parent then
								DomainBG:Destroy()
							end
							if DomainBG.Parent then
								DomainBG.Position = workspace.CurrentCamera.CFrame.Position
							else
								Render:Disconnect()
							end
						end)
					end
				else
					return
				end
				--end				
			elseif Function == "Shatter" then
				local Shatters = script['Gojo'].InfiniteVoid.Domain:Clone()
				Shatters.Transparency = 1
				Shatters.CanCollide = false
				Shatters.Position = Params.Pos
				Shatters.Parent = workspace.Effects
				game.Debris:AddItem(Shatters, 3)
				for _, v34 in Shatters:GetChildren() do
					if v34.Name == "Shatter" then
						v34:Emit(100)
					else
						v34:Destroy()
					end
				end
				--FXModule.PlaySound(Assets.Sounds.Shatter, Shatters, game.SoundService.Effect)
				Shatters.Transparency = 0
				TS:Create(Shatters, TweenInfo.new(0.2), {
					["Transparency"] = 1
				}):Play()
			end

		elseif Stage == "Sukuna" then
			local arg1 = Params.Char
			local arg2 = Params.AnimId
			local class_Humanoid_2_upvr = arg1:FindFirstChildOfClass("Humanoid")
			local RootPart_upvr_4 = class_Humanoid_2_upvr.RootPart
			local any_new_result1_upvr = Trova.new()
			local var61
			for _, v_4 in ipairs(class_Humanoid_2_upvr.Animator:GetPlayingAnimationTracks()) do
				if v_4.Animation and v_4.Animation.AnimationId == arg2 then
					var61 = v_4
				end
			end
			any_new_result1_upvr:Add(var61)
			task.spawn(function() 
				if LocalPlayer:DistanceFromCharacter(RootPart_upvr_4.Position) <= 500 then
					screenEffect(8)
				end
			end)
			task.spawn(function() 
				if LocalPlayer.Character  == arg1  then
					--Parent.Cutscene(script.Sukuna.Domain.Cam, script.Camera, RootPart_upvr_4, nil, script.Sukuna.Domain.FOV, true)
					cutscene(script.Sukuna.Domain.Cam, script.Sukuna.Domain.Camera, RootPart_upvr_4, nil, script.Sukuna.Domain.FOV, true)
				end
			end)
			local clone_upvr = script.Sukuna.Domain.domain_3_n:Clone()
			clone_upvr.Parent = workspace.Effects
			clone_upvr:PivotTo(RootPart_upvr_4.CFrame * CFrame.new(0, -3, 0))
			any_new_result1_upvr:Add(clone_upvr)
			--local any_play_result1_upvr = Utility.Modules.soundPlaying:play(script.Sukuna["sukuna domain new"], Utility.Services.Sound)
			--any_new_result1_upvr:Add(Utility.Services.RunService.PreRender:Connect(function() 
			--	if 600 < LocalPlayer:DistanceFromCharacter(clone_upvr.PrimaryPart.Position) then
			--		TS:Create(any_play_result1_upvr, TweenInfo.new(1), {
			--			Volume = 0;
			--		}):Play()
			--	else
			--		TS:Create(any_play_result1_upvr, TweenInfo.new(1), {
			--			Volume = 1;
			--		}):Play()
			--	end
			--end))
			local any_Add_result1_upvr = any_new_result1_upvr:Add(AnimEvents:loadAnimation(clone_upvr, script.Sukuna.Domain.AnimS))
			any_Add_result1_upvr:Play(0)
			any_new_result1_upvr:Add(function() 
				clone_upvr:Destroy()
				if LocalPlayer:DistanceFromCharacter(RootPart_upvr_4.Position) <= 500 then
					Brightness(-1, 2, Color3.fromRGB(0, 0, 0))
				end
				--if class_Humanoid_2_upvr.Health <= 0 or not arg1:IsDescendantOf(game) then
				--	any_play_result1_upvr:Destroy()
				--end
			end)
			any_new_result1_upvr:Add(var61:GetMarkerReachedSignal("Black"):Once(function() 
				Emit(RootPart_upvr_4, script.Sukuna.Domain.watersplash, 2, CFrame.new(0, 0, -4))
			end))
			any_new_result1_upvr:Add(var61:GetMarkerReachedSignal("Void"):Once(function()
				local clone_17_upvr = script.Sukuna.Domain.Black:Clone()
				clone_17_upvr.Parent = workspace.Effects
				clone_17_upvr:PivotTo(RootPart_upvr_4.CFrame * CFrame.new(0, 0, 25))
				task.delay(5.55, function() 
					for _, v_5 in clone_17_upvr:GetDescendants() do
						if v_5:IsA("ParticleEmitter") then
							v_5.Enabled = false
						end
					end
					task.wait(1)
					Debris:AddItem(clone_17_upvr, 1.65)
				end)
			end))
			any_new_result1_upvr:Add(var61:GetMarkerReachedSignal("Grab"):Once(function() 
				Emit(RootPart_upvr_4, script.Sukuna.Domain.watersplash, 2, CFrame.new(0, script.Sukuna.Domain.bigsplash.Size.Y / 2, -4))
			end))
			any_new_result1_upvr:Add(var61:GetMarkerReachedSignal("UI"):Once(function() 
				if LocalPlayer:DistanceFromCharacter(RootPart_upvr_4.Position) <= 150 then
					local clone_2 = script.Sukuna.DE:Clone()
					clone_2.Parent = LocalPlayer.PlayerGui.DomainGUI
					--for _, v_6 in clone_2:GetChildren() do
					--	ShakeCameraModule:ShakeCamera(v_6, 4, 1, 0)
					--end
					task.wait(2)
					TS:Create(clone_2, TweenInfo.new(1), {
						GroupTransparency = 1;
					}):Play()
					Debris:AddItem(clone_2, 1)
				end
			end))
			any_new_result1_upvr:Add(var61:GetMarkerReachedSignal("Out"):Once(function() 
				Emit(RootPart_upvr_4, script.Sukuna.Domain.bigsplash, 2, CFrame.new(0, script.Sukuna.Domain.bigsplash.Size.Y / 2, -4))
				local clone_13 = script.Sukuna.Domain.idleSplash:Clone()
				clone_13.Parent = clone_upvr
				clone_13.CFrame = clone_upvr.PrimaryPart.CFrame * CFrame.new(0, 0.15, 0)
			end))
			any_new_result1_upvr:Add(var61:GetMarkerReachedSignal("Freeze"):Once(function() 
				any_Add_result1_upvr:AdjustSpeed(0)
			end))
			any_new_result1_upvr:Add(var61:GetMarkerReachedSignal("Attack"):Once(function() 
				for _, v_7 in clone_upvr:GetDescendants() do
					if v_7:IsA("ParticleEmitter") then
						v_7.Enabled = true
					end
				end
				local clone_7 = script.Sukuna.Domain.cleave:Clone()
				clone_7:PivotTo(RootPart_upvr_4.CFrame * CFrame.new(0, -3, 0))
				clone_7.Parent = workspace.Effects
				local any_Raycast_result1_4 = l_Raycast_0(RootPart_upvr_4.Position, Vector3.yAxis * -1000)
				if any_Raycast_result1_4 then
					clone_7.thing.Position = any_Raycast_result1_4.Position
				end
				local clone_upvr_2 = script.Sukuna.Domain.ColorCorrection:Clone()
				clone_upvr_2.Parent = Lighting
				clone_upvr_2.TintColor = Color3.fromRGB(255, 255, 255)
				TS:Create(clone_upvr_2, TweenInfo.new(1), {
					TintColor = Color3.fromRGB(255, 132, 70);
				}):Play()
				impactFrame(3, {RootPart_upvr_4, 500})
				--any_new_result1_upvr:Add(Utility.Services.RunService.PreRender:Connect(function()
				--	Parent.newCameraShake({{1, 10, 0, 1}, Vector3.yAxis * 3 + Vector3.xAxis * 3}, {clone_upvr.PrimaryPart, 600})
				--end))
				any_new_result1_upvr:Add(clone_7)
				any_new_result1_upvr:Add(function() 
					TS:Create(clone_upvr_2, TweenInfo.new(1), {
						TintColor = Color3.fromRGB(255, 255, 255);
					}):Play()
					Debris:AddItem(clone_upvr_2, 1)
				end)
			end))
			any_new_result1_upvr:AttachToInstance(arg1)
			any_new_result1_upvr:Add(arg1:GetAttributeChangedSignal('DomainActive'):Connect(function(arg1_2) 
				if not arg1:GetAttribute("DomainActive") then
					any_new_result1_upvr:Destroy()
				end
			end))
			any_new_result1_upvr:Add(class_Humanoid_2_upvr.Died:Once(function()
				any_new_result1_upvr:Destroy()
			end))
		end
	end,
	
	['Rd'] = function(Params)
		local Stage = Params.Stage
		local char = Params.Char
		local HumRP = char.HumanoidRootPart
		local hum : Humanoid = char.Humanoid

		local Mouse = require(script.Stuff.GetMouse)

		if Stage == 'Fly' then
			for _,v in HumRP:GetChildren() do
				if v:IsA('BodyVelocity') then
					v:Destroy()
				end
			end

			local runVelocity = Instance.new("BodyVelocity")
			runVelocity.MaxForce = Vector3.new(0, 1, 0) * 30000000

			local runMagnitude = Instance.new("NumberValue")
			runMagnitude.Value = 15
			runMagnitude.Parent = runVelocity

			local startTween = TS:Create(runMagnitude, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Value = 100
			})
			local endTween = TS:Create(runMagnitude, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Value = 57
			})

			startTween.Completed:Once(function()
				task.delay(0.05, function()
					endTween:Play()
				end)
			end)

			runVelocity.Parent = HumRP
			startTween:Play()
			Debris:AddItem(runVelocity, 1.25) 

			task.spawn(function()
				while task.wait() and runVelocity.Parent ~= nil do
					runVelocity.Velocity = HumRP.CFrame.LookVector * runMagnitude.Value
				end
			end)
		end
	end,
	
	
	
	['Hollow'] = function(Params)
		local Stage = Params.Stage
		local char = Params.Char
		local HumRP = char.HumanoidRootPart
		local hum : Humanoid = char.Humanoid
		
		local Mouse = require(script.Stuff.GetMouse)
		
		if Stage == 'Fly' then
			local BP = Instance.new('BodyPosition',HumRP)
			BP.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			Debris:AddItem(BP, 4)
			
			local BodyGyro = Instance.new("BodyGyro", HumRP)
			BodyGyro.P = 10000
			BodyGyro.MaxTorque = Vector3.one * 40000
			BP.Position = HumRP.Position + Vector3.new(0, 6, 0)
			hum.PlatformStand = true
			repeat
				BodyGyro.CFrame = CFrame.new(HumRP.Position, Mouse:GetMouseTarget())
				task.wait()
			until not BP.Parent
			BodyGyro:Destroy()
			hum.PlatformStand = false
		elseif Stage == "Purple" then
			local Folder = Instance.new('Folder',char)
			Folder.Name = 'HollowPurpleVFX'
			
			local clone_3 = script.Gojo.HollowPurple.Blue:Clone()
			clone_3.Weld.Part0 = HumRP
			clone_3.Parent = Folder
			local clone = script.Gojo.HollowPurple.Red:Clone()
			clone.Weld.Part0 = HumRP
			clone.Parent = Folder
			TS:Create(clone_3, TweenInfo.new(0.25), {
				Transparency = 0;
			}):Play()
			TS:Create(clone_3.PointLight, TweenInfo.new(0.25), {
				Brightness = 20;
			}):Play()
			TS:Create(clone, TweenInfo.new(0.25), {
				Transparency = 0;
			}):Play()
			TS:Create(clone.PointLight, TweenInfo.new(0.25), {
				Brightness = 20;
			}):Play()
			clone_3.Mid.Charge:Emit(2)
			clone.Mid.Charge:Emit(2)
			--FXModule:PlaySound(sfx.Gojo.HollowPurple.Merge, HumanoidRootPart_2, game.SoundService.Effect)
			task.wait(0.25)
			--if LocalPlayer.Character == Character then
				--camshake.CurrentShaker:Shake(camshake.Presets.LightHit)
			--end
			for _, v in Folder:GetDescendants() do
				if v.Name == "Sparks" then
					v:Emit(20)
				elseif v.Name == "Stars" then
					v:Emit(7)
				elseif v.Name == "Beam2" or v.Name == "Smoke" then
					v.Enabled = true
				elseif v:IsA("Decal") then
					v.Transparency = 0.1
				end
			end
			clone_3.Material = Enum.Material.Granite
			clone.Material = Enum.Material.Granite
			TS:Create(clone_3.Weld, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.In), {
				C1 = CFrame.new(0, 0, 9);
			}):Play()
			TS:Create(clone.Weld, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.In), {
				C1 = CFrame.new(0, 0, -9) * CFrame.Angles(0, math.pi, 0);
			}):Play()
			task.wait(1)
			clone_3:Destroy()
			clone:Destroy()
		end
	end,
	
	
	
	['20 Dropkick'] = function(Params)
		local Stage = Params.Stage
		if Stage == 'Start' then
			if LocalPlayer.Configuration['Awakening Music'].Value == true then
				Assets.Sounds.MusicRun.Volume = 2.5
				Assets.Sounds.MusicRun:Play()
			end

			return
		end

		local Character: Model = Params.Char
		local DashTime = Params.Time
		local KickDashSpeed = Params.DashSpeed

		local DropkickFolder = script.KJ.Dropkick

		local Torso: BasePart, HumRP: BasePart
		if Character then
			HumRP = Character.HumanoidRootPart
			Torso = Character.Torso
		else
			Torso, HumRP = Params.Torso, Params.HumRP
		end


		if Stage == 'Dash' then
			gameSettings.RotationType = Enum.RotationType.CameraRelative



			local tpFX = script.KJ.Dropkick.tpthing:Clone()
			tpFX.Parent = Character.Torso
			Debris:AddItem(tpFX, 3.167)

			AddToActiveItems(tpFX, 3.167, Character)

			local speedLines
			if Character == LocalCharacter then
				speedLines = DropkickFolder.speedlinesandstuff:Clone()
				speedLines.Parent = Character
				speedLines.Weld.Part0 = HumRP

				for _,v in speedLines:GetDescendants() do
					if v:IsA('Beam') or v:IsA('ParticleEmitter') then
						local DefaultBrightness = v.Brightness
						v.Brightness = 0
						TS:Create(v, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.In), { Brightness = DefaultBrightness; }):Play()
					end
				end

				AddToActiveItems(speedLines, nil, Character)
			end


			local tasks = { -- Start 1.883
				task.delay(.967, function()
					ParticlesModule.Emit(tpFX)
					FlashstepModule(Character, .1)
				end);

				task.delay(2.117, function()
					ParticlesModule.Emit(tpFX)
					FlashstepModule(Character, .1)
				end);

				task.delay(2.400, function()
					ParticlesModule.Emit(tpFX)
					FlashstepModule(Character, .1)
				end);

				task.delay(2.567, function()
					ParticlesModule.Emit(tpFX)
					FlashstepModule(Character, .1)
				end);

				task.delay(2.767, function()
					ParticlesModule.Emit(tpFX)
					FlashstepModule(Character, .1)
				end);

				task.delay(2.917, function()
					ParticlesModule.Emit(tpFX)
					FlashstepModule(Character, .1)
				end);

				task.delay(3.067, function()
					ParticlesModule.Emit(tpFX)
					FlashstepModule(Character, .1)
				end);
			}


			local dashVelocity = Instance.new("BodyVelocity")
			dashVelocity.Name = "20 Dash Velocity"
			dashVelocity.MaxForce = Vector3.new(1, 0, 1) * 100000
			dashVelocity.Parent = HumRP
			AddToActiveItems(dashVelocity, nil, Character)




			local Speed = Instance.new('NumberValue')
			Speed.Value = KickDashSpeed


			local connection
			connection = RNS.RenderStepped:Connect(function()
				if dashVelocity.Parent ~= nil then
					dashVelocity.Velocity = HumRP.CFrame.LookVector * Speed.Value
				else
					connection:Disconnect()
				end
			end)


			local dashFinal
			dashFinal = task.delay(DashTime,function()
				dashFinal = nil

				if Character == LocalCharacter then
					if speedLines and speedLines.Parent then
						for _,v in speedLines:GetDescendants() do
							if v:IsA('ParticleEmitter') or v:IsA('Beam') then
								TS:Create(v, TweenInfo.new(1.05, Enum.EasingStyle.Linear), { Brightness = 0; }):Play()
							end
						end
						Debris:AddItem(speedLines, 1.05)
					end
				end

				task.wait(1.05)


				TS:Create(Speed,TweenInfo.new(.867, Enum.EasingStyle.Linear),{ Value = 0 }):Play()


				for i = 1, 2 do
					task.spawn(function()
						local drag = DropkickFolder.drag:Clone()
						drag.Parent = workspace.Effects
						ParticlesModule.Enabled(drag, true)
						Debris:AddItem(drag, 3.067)
						AddToActiveItems(drag, 3.067, Character)

						local FootAtt = DropkickFolder.FootAtt.Attachment:Clone()						
						if i == 1 then
							FootAtt.Parent = Character['Right Leg']
						else
							FootAtt.Parent = Character['Left Leg']
						end
						AddToActiveItems(FootAtt, nil, Character)

						task.spawn(function()
							repeat
								drag.CFrame = CFrame.lookAlong(FootAtt.WorldPosition, HumRP.CFrame.LookVector)

								task.wait()
							until drag.Parent == nil

							FootAtt:Destroy()
						end)

						task.wait(.867)

						ParticlesModule.Enabled(drag, false)
					end)
				end


				task.wait(.867)

				connection:Disconnect()
				dashVelocity:Destroy()
				Speed:Destroy()

				gameSettings.RotationType = Enum.RotationType.MovementRelative
			end)

			dashVelocity.Destroying:Once(function()
				if dashFinal then
					task.cancel(dashFinal)
				end

				for _,_task in tasks do
					if _task then
						task.cancel(_task)
					end
				end
			end)
		elseif Stage == 'StopDash' then
			local EChar: Model = Params.EChar
			local ETorso: BasePart = EChar.Torso
			local EHumRP: BasePart = EChar.HumanoidRootPart

			HumRP.CFrame = Params.StartCamCF

			local tpFX = script.KJ.Dropkick.tpthing:Clone()
			tpFX.Parent = Character.Torso
			Debris:AddItem(tpFX, 3.167)
			AddToActiveItems(tpFX, 3.167, Character)

			task.delay(.783, function()
				ParticlesModule.Emit(tpFX)
				FlashstepModule(Character, .1)
			end)

			task.delay(4.417, function()
				ParticlesModule.Emit(tpFX)
				task.delay(.216, function()
					ParticlesModule.Emit(tpFX)
				end)

				FlashstepModule(Character, .216)
			end)

			task.spawn(function()
				if EChar == LocalCharacter or Character == LocalCharacter then
					local hitLines = script.KJ.Dropkick.speedlines:Clone()
					hitLines.Parent = Character
					hitLines.CFrame = HumRP.CFrame * CFrame.new(0, hitLines.Size.Y/2, 25)
					Debris:AddItem(hitLines, 3.133)
					task.delay(3.133 - .4, function()
						ParticlesModule.Enabled(hitLines, false)
					end)
					AddToActiveItems(hitLines, 3.133, Character)


					for _,v in Character:GetChildren() do
						if v.Name == 'speedlinesandstuff' then
							v:Destroy()
						end
					end

					local speedLines: Part = script.KJ.Dropkick.speedlinesandstuff:Clone()
					speedLines.Parent = Character
					speedLines.Anchored = true
					speedLines.CFrame = HumRP.CFrame * CFrame.new(0, 6.2, 50)

					speedLines.aya:Destroy()
					speedLines.aye:Destroy()

					task.delay(3.133 - ParticlesModule.GetHLF(speedLines), function()
						ParticlesModule.Enabled(speedLines, false)
					end)
					Debris:AddItem(speedLines, 3.133)
					AddToActiveItems(speedLines, 3.133, Character)



					Assets.Sounds.MusicRun:Stop()
					Assets.Sounds.MusicRun.TimePosition = 0
					Assets.Sounds.MusicRun.Volume = 2.5
					if LocalPlayer.Configuration['Awakening Music'].Value == true then
						Assets.Sounds['20Music']:Play()
					end
					task.delay(Assets.Sounds['20Music'].TimeLength - .65, function()
						Assets.Sounds['20Bass']:Play()
					end)


					task.spawn(function()
						CameraTableAnims:PlayAnimation('Dropkick', HumRP)
					end)

					CameraHandler:PlayCameraAnimation('20 Dropkick', HumRP)
				end
			end)

			local BodyVelocity: BodyVelocity = HumRP:FindFirstChild('20 Dash Velocity')
			if BodyVelocity then
				BodyVelocity:Destroy()

				gameSettings.RotationType = Enum.RotationType.MovementRelative
			end

			task.delay(.367, function()
				local VFX = DropkickFolder.firstHit:Clone()
				VFX.Parent = EChar
				VFX.CFrame = HumRP.CFrame
				ParticlesModule.Emit(VFX)
				Debris:AddItem(VFX, ParticlesModule.GetHLF(VFX))
			end)

			if Character == LocalCharacter or EChar == LocalCharacter then
				task.delay(9.017, function()
					local backscreen = DropkickFolder.backscreen:Clone()
					backscreen.Parent = Torso.Parent
					backscreen.CFrame = CFrame.lookAt(HumRP.Position, Torso.Position)
					backscreen.Position = Torso.Position
					backscreen.CFrame = Params.StartCamCF * CFrame.new(0.33, -2.1, -178.11) * CFrame.Angles(0, 0, 0)
					Debris:AddItem(backscreen, 6.4)
					AddToActiveItems(backscreen, 6.4, Character)

					shared.ActivateiFrames('Dropkick', { Stage = 1; })
				end)

				task.delay(15.517, function()
					CameraHandler:StopAnims()
					CameraTableAnims:StopAnimations()
				end)
			end

			task.delay(15.517, function()
				local VFX = DropkickFolder.lastimpact:Clone()
				VFX.Parent = EChar
				VFX.CFrame = Params.StartCamCF * CFrame.new(0, 0.15, -177.531)
				ParticlesModule.Emit(VFX)
				Debris:AddItem(VFX, ParticlesModule.GetHLF(VFX))

				DestructiblesModule:Destroy(EChar.Torso.CFrame * CFrame.new(0, 50, -100), Vector3.new(100, 100, 200), false, EChar.Torso.CFrame.LookVector * 50)
			end)

			task.delay(1.267, function() -- Hit Smokes
				local YPos = EHumRP.Position.Y - 3

				local slam = DropkickFolder.slam:Clone()
				slam.Parent = Character
				slam.Position = Vector3.new(ETorso.Position.X, YPos, ETorso.Position.Z)
				slam.Orientation = Vector3.new(90, 0, 0)
				ParticlesModule.Emit(slam)
				Debris:AddItem(slam, 1.083 + ParticlesModule.GetHLF(slam))
				AddToActiveItems(slam, 1.083 + ParticlesModule.GetHLF(slam), Character)

				task.wait(.55) -- 1.817

				slam.Position = Vector3.new(ETorso.Position.X, YPos, ETorso.Position.Z)
				ParticlesModule.Emit(slam)

				task.wait(.533) -- 2.350

				slam.Position = Vector3.new(ETorso.Position.X, YPos, ETorso.Position.Z)
				ParticlesModule.Emit(slam)

				task.wait(.6) -- 2.950

				for i = 1, 2 do
					task.spawn(function()
						local drag = DropkickFolder.drag:Clone()
						drag.Parent = Character
						ParticlesModule.Enabled(drag, true)
						Debris:AddItem(drag, 3.2)
						AddToActiveItems(drag, 3.2, Character)


						local FootAtt = DropkickFolder.FootAtt.Attachment:Clone()						
						if i == 1 then
							FootAtt.Parent = EChar['Right Leg']
						else
							FootAtt.Parent = EChar['Left Leg']
						end
						AddToActiveItems(FootAtt, nil, Character)


						task.spawn(function()
							repeat
								drag.CFrame = CFrame.lookAlong(FootAtt.WorldPosition, -HumRP.CFrame.LookVector)

								task.wait()
							until drag.Parent == nil

							FootAtt:Destroy()
						end)

						task.wait(1) -- 3.950

						ParticlesModule.Enabled(drag, false)
					end)
				end
			end)

			task.delay(4.717, function() -- Pre Hit FX
				local BigDash = DropkickFolder.BighDashLine:Clone()
				BigDash.Parent = workspace.Effects
				BigDash.CFrame = HumRP.CFrame * CFrame.new(0, -2.9, 5)
				for _,v: Beam in BigDash:GetDescendants() do
					if v:IsA('Beam') then
						if EChar == LocalCharacter or Character == LocalCharacter then
							TS:Create(v, TweenInfo.new(4.416, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { TextureSpeed = 0; Brightness = .01; }):Play()
						else
							TS:Create(v, TweenInfo.new(4.416, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { TextureSpeed = 0; Brightness = .0; }):Play()
						end
					end
				end
				Debris:AddItem(BigDash, 4.416)
				AddToActiveItems(BigDash, 4.416, Character)
			end)

			local Waves = DropkickFolder.Lasts
			local CharPivot = HumRP.CFrame

			local FlashWaveone = Waves.FlashWaveone:Clone();
			FlashWaveone.CFrame = CharPivot * CFrame.new(1.43, 1.55, -164) * CFrame.Angles(0, -1.5707963267948966, 0);
			FlashWaveone.Decal.Transparency = 0;
			FlashWaveone.Mesh.Scale = Vector3.new(0, 0, 0, 0);
			FlashWaveone.Parent = workspace.Thrown;
			local FlashWavetwo = Waves.FlashWavetwo:Clone();
			FlashWavetwo.CFrame = CharPivot * CFrame.new(1.43, 1.55, -125.91) * CFrame.Angles(1.5707963267948966, -0.6806784082777885, 1.5707963267948966);
			FlashWavetwo.Decal.Transparency = 0;
			FlashWavetwo.Mesh.Scale = Vector3.zero;
			FlashWavetwo.Parent = workspace.Thrown;
			local FlashWavethree = Waves.FlashWavethree:Clone();
			FlashWavethree.CFrame = CharPivot * CFrame.new(1.13, 1.328, -56.41) * CFrame.Angles(-1.5707963267948966, 0.4537856055185257, -1.5707963267948966);
			FlashWavethree.Decal.Transparency = -1;
			FlashWavethree.Mesh.Scale = Vector3.zero;
			FlashWavethree.Parent = workspace.Thrown;
			local thingnearthree = Waves.thingnearthree:Clone();
			thingnearthree.Decal.Transparency = -1;
			thingnearthree.Mesh.Scale = Vector3.zero;
			thingnearthree.CFrame = CharPivot * CFrame.new(1.13, 1.328, -56.41) * CFrame.Angles(-1.5707963267948966, 0.4537856055185257, -1.5707963267948966);
			thingnearthree.Parent = workspace.Thrown;
			local thingneartwo = Waves.thingneartwo:Clone();
			thingneartwo.Decal.Transparency = 0;
			thingneartwo.Mesh.Scale = Vector3.zero;
			thingneartwo.CFrame = CharPivot * CFrame.new(1.13, 1.32, -113.66) * CFrame.Angles(1.5707963267948966, 1.0471975511965976, 1.5707963267948966);
			thingneartwo.Parent = workspace.Thrown;
			local thingnearone = Waves.thingnearone:Clone();
			thingnearone.CFrame = CharPivot * CFrame.new(1.135, 1.32, -166.315) * CFrame.Angles(-1.5707963267948966, 0.4537856055185257, -1.5707963267948966);
			thingnearone.Decal.Transparency = 0.5;
			thingnearone.Mesh.Scale = Vector3.zero;
			thingnearone.Parent = workspace.Thrown;

			task.delay(4.4, function()
				local l_zero_0 = Vector3.zero;
				NewUtil:UnixConnection2(1.55, function(v1368)
					FlashWaveone.Mesh.Scale = l_zero_0:Lerp(Vector3.new(0.25600001215934753, 0.11900000274181366, 0.12200000137090683, 0), v1368);
				end);
				task.delay(1.55, function()
					TS:Create(FlashWaveone.Mesh, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
						Scale = Vector3.new(0.25600001215934753, 0.11900000274181366, 0.12200000137090683, 0)
					}):Play();
				end);
				TS:Create(FlashWaveone.Decal, TweenInfo.new(1.967, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
					Transparency = 0.6
				}):Play();
				task.delay(1.967, function()
					TS:Create(FlashWaveone.Decal, TweenInfo.new(2.383, Enum.EasingStyle.Linear), {
						Transparency = 1
					}):Play();
				end);
				TS:Create(FlashWaveone, TweenInfo.new(4.417, Enum.EasingStyle.Linear), {
					CFrame = CharPivot * CFrame.new(1.435, 1.55, -160.76) * CFrame.Angles(1.5707963267948966, 0.291469985083053, 1.5707963267948966)
				}):Play();
				Debris:AddItem(FlashWaveone, 10);
			end);
			task.delay(4.7, function()
				TS:Create(FlashWavetwo.Mesh, TweenInfo.new(2.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
					Scale = Vector3.new(1, 0.5, 0.5, 0)
				}):Play();
				task.delay(2.5, function()
					TS:Create(FlashWavetwo.Mesh, TweenInfo.new(0.984, Enum.EasingStyle.Linear), {
						Scale = Vector3.new(1, 0.5, 0.5, 0)
					}):Play();
				end);
				TS:Create(FlashWavetwo.Decal, TweenInfo.new(3.45, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					Transparency = 1
				}):Play();
				TS:Create(FlashWavetwo, TweenInfo.new(3.45, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					CFrame = CharPivot * CFrame.new(1.43, 1.5, -135.84) * CFrame.Angles(-1.5707963267948966, -0.888896188040712, -1.5707963267948966)
				}):Play();
				Debris:AddItem(FlashWavetwo, 10);
			end);
			task.delay(4.684, function()
				TS:Create(FlashWavethree.Mesh, TweenInfo.new(0.733, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					Scale = Vector3.new(3, 3, 3, 0)
				}):Play();
				task.delay(0.733, function()
					TS:Create(FlashWavethree.Mesh, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
						Scale = Vector3.new(2, 2, 2, 0)
					}):Play();
				end);
				TS:Create(FlashWavethree.Decal, TweenInfo.new(0.85, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					Transparency = 1
				}):Play();
				TS:Create(FlashWavethree, TweenInfo.new(1.583, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					CFrame = CharPivot * CFrame.new(1.13, 1.32, -81.52) * CFrame.Angles(-1.5707963267948966, -0.7578219612159379, -1.5707963267948966)
				}):Play();
				Debris:AddItem(FlashWavethree, 10);
			end);
			task.delay(4.7, function()
				TS:Create(thingnearone.Mesh, TweenInfo.new(3.184, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
					Scale = Vector3.new(0.12999999523162842, 0.20000000298023224, 0.20000000298023224, 0)
				}):Play();
				task.delay(3.184, function()
					TS:Create(thingnearone.Mesh, TweenInfo.new(1.583, Enum.EasingStyle.Linear), {
						Scale = Vector3.new(0.12999999523162842, 0.20000000298023224, 0.20000000298023224, 0)
					}):Play();
				end);
				TS:Create(thingnearone.Decal, TweenInfo.new(3.75, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					Transparency = 0.8
				}):Play();
				task.delay(3.75, function()
					TS:Create(thingnearone.Decal, TweenInfo.new(1.017, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
						Transparency = 1
					}):Play();
				end);
				TS:Create(thingnearone, TweenInfo.new(1.183, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					CFrame = CharPivot * CFrame.new(1.13, 1.32, -166.31) * CFrame.Angles(-1.5707963267948966, -0.4003785304074992, -1.5707963267948966)
				});
				Debris:AddItem(thingnearone, 10);
			end);
			task.delay(4.7, function()
				local l_zero_1 = Vector3.zero;
				NewUtil:UnixConnection2(0.85, function(v1370)
					v1370 = EaseOutSixtic(v1370);
					thingneartwo.Mesh.Scale = l_zero_1:Lerp(Vector3.new(1, 2, 2, 0), v1370);
				end);
				TS:Create(thingneartwo.Decal, TweenInfo.new(1.667, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					Transparency = 1
				}):Play();
				TS:Create(thingneartwo, TweenInfo.new(1.55, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					CFrame = CharPivot * CFrame.new(1.13, 1.32, -124.75)
				}):Play();
				Debris:AddItem(thingneartwo, 10);
			end)
		elseif Stage == 'Destroy' then
			for _,v in script.ActiveItems[Character.Name]:GetChildren() do
				if v:IsA('ObjectValue') then
					if v.Value:FindFirstChildWhichIsA('ParticleEmitter', true) then
						ParticlesModule.Enabled(v.Value, false)
						Debris:AddItem(v.Value, 10)
					else
						v.Value:Destroy()
					end

					v:Destroy()
				end
			end

			CameraHandler:StopAnims()
			CameraTableAnims:StopAnimations()

			for _, Part: Part? in Character:GetDescendants() do
				if Part:HasTag('BecomeVisible') then
					Part:RemoveTag('BecomeVisible')

					Part.Transparency = 0
				end
			end
		end
	end,

	['5 Seasons'] = function(Params)
		local Stage = Params.Stage

		if Stage == 'PlaySound' then
			local Char: Model = Params.Char
			local HumRP: BasePart = Char.HumanoidRootPart
			local Torso: BasePart = Char.Torso
			local LeftArm: BasePart = Char['Left Arm']
			local HandFire = script.KJ.FiveSeasons.HandFire:Clone()
			HandFire.Parent = Char
			HandFire.ArmWeld.Part0 = LeftArm
			Debris:AddItem(HandFire, 4.617)

			if LocalCharacter == Char then
				if LocalPlayer.Configuration['Awakening Music'].Value == true then
					Assets.Sounds.FiveStart:Play()
				end

				task.delay(3.333, function()
					Assets.Sounds.FiveSpeech:Play()
				end)
			end


			task.spawn(function()
				local vfx = script.KJ.FiveSeasons.CharFX.HeatUp:Clone()
				vfx.Parent = HumRP
				ParticlesModule.Enabled(vfx, true)
				task.delay(1.150, function()
					ParticlesModule.Enabled(vfx, false)
				end)
				Debris:AddItem(vfx, 2.4)
			end)

			if Char == LocalCharacter then
				task.delay(.9, function()
					CameraTableAnims:PlayAnimation('FiveStartup', HumRP)
				end)
			end

			task.delay(1.150, function()
				local ray = raycast(HumRP.Position, Vector3.new(0,-1000, 0), MapRayParams)

				task.spawn(function()
					local JumpMeshes = script.KJ.FiveSeasons.JumpMeshes:Clone()
					JumpMeshes.Parent = workspace.Thrown
					JumpMeshes.Primary.CFrame = HumRP.CFrame
					for _,v in JumpMeshes:GetChildren() do
						if v.Name ~= 'Primary' then
							v.CFrame = JumpMeshes.Primary.CFrame * JumpMeshes.Primary[v.Name].C0
						end
					end


					TS:Create(JumpMeshes.Main, TweenInfo.new(.25), { Color = Color3.fromRGB(218, 4, 4); Size = Vector3.new(1, 46.203, 1); CFrame = JumpMeshes.Primary.CFrame * CFrame.new(0.109, 47.932, -0.518) * CFrame.Angles(math.rad(.475), math.rad(-60.218), math.rad(178.718)); Transparency = 1; }):Play()
					TS:Create(JumpMeshes.Wind2, TweenInfo.new(.25), { Color = Color3.fromRGB(248, 0, 0); Size = Vector3.new(291.284, 188.06, 270.756); CFrame = JumpMeshes.Primary.CFrame * CFrame.new(-0.194, 2.422, -3.905) * CFrame.Angles(math.rad(-.005), math.rad(99.785), math.rad(-178.631)); Transparency = 1; }):Play()
					TS:Create(JumpMeshes.Wind3, TweenInfo.new(.25), { Color = Color3.fromRGB(248, 248, 248); Size = Vector3.new(73.139, 113.502, 67.985); CFrame = JumpMeshes.Primary.CFrame * CFrame.new(-0.404, 33.079, 0.452) * CFrame.Angles(math.rad(0.346), math.rad(84.79), math.rad(-178.318)); Transparency = 1; }):Play()

					TS:Create(JumpMeshes.WindDecal2, TweenInfo.new(.25), { Size = Vector3.new(41.124, 76.167, 41.124); CFrame = JumpMeshes.Primary.CFrame * CFrame.new(-0.047, 39.53, -3.031) * CFrame.Angles(math.rad(0.347), math.rad(84.792), math.rad(-178.678)); }):Play()
					TS:Create(JumpMeshes.WindDecal2.Mesh, TweenInfo.new(.25), { Scale = Vector3.new(18.693, 76.189, 18.693); }):Play()
					TS:Create(JumpMeshes.WindDecal2.Decal, TweenInfo.new(.25), { Transparency = 1; }):Play()


					ParticlesModule.Emit(JumpMeshes.Lines)
					Debris:AddItem(JumpMeshes, 1)
				end)


				local FX = script.KJ.FiveSeasons.JumpFX:Clone()
				FX.Parent = Char
				FX.Position = ray.Position + Vector3.new(0,3.28,0)
				for _,p in FX:GetDescendants() do
					if p:IsA('ParticleEmitter') then
						p:Emit(p:GetAttribute('EmitCount'))
					end
				end
				Debris:AddItem(FX, 4.2)

				local BeamFX = script.KJ.FiveSeasons.CharFX.BeamFX:Clone()
				BeamFX.Parent = Torso
				ParticlesModule.Enabled(BeamFX, true)
				task.delay(1.25, function()
					for _,v in BeamFX:GetDescendants() do
						if v:IsA('Beam') then
							TS:Create(v, TweenInfo.new(.75), { Brightness = 0; }):Play()
						end
					end
				end)
				Debris:AddItem(BeamFX, 2)

				ParticlesModule.Enabled(HandFire.FX, true)
			end)

			task.delay(3.617, function()
				ParticlesModule.Emit(HandFire.Emit)
				ParticlesModule.Enabled(HandFire.FX, false)

				task.wait(.716)

				local Burst = script.KJ.FiveSeasons.CharFX.ArmBurst:Clone()
				Burst.Parent = LeftArm
				ParticlesModule.Emit(Burst)
				Debris:AddItem(Burst, ParticlesModule.GetHLF(Burst))

				local EnabledVFX = script.KJ.FiveSeasons.CharFX.FinalArmFXMirrored:Clone()
				EnabledVFX.Parent = LeftArm
				ParticlesModule.Enabled(EnabledVFX, true)

				if Char == LocalCharacter then
					task.spawn(function()
						local CurrentCC = script.KJ.FiveSeasons.FirstCCs.FSRed:Clone()
						CurrentCC.Parent = game.Lighting

						task.wait(1/24)

						CurrentCC:Destroy()
						CurrentCC = script.KJ.FiveSeasons.FirstCCs.FSWhite:Clone()
						CurrentCC.Parent = game.Lighting

						task.wait(1/24)

						CurrentCC:Destroy()
						CurrentCC = script.KJ.FiveSeasons.FirstCCs.FSBlack:Clone()
						CurrentCC.Parent = game.Lighting

						task.wait(1/24)

						CurrentCC:Destroy()
					end)
				end

				task.wait(1.2)

				ParticlesModule.Enabled(EnabledVFX, false)
				Debris:AddItem(EnabledVFX, ParticlesModule.GetHLF(EnabledVFX))
				local WindupSparks = script.KJ.FiveSeasons.CharFX.WindupSpark:Clone()
				WindupSparks.Parent = LeftArm
				ParticlesModule.Enabled(WindupSparks, true)


				task.wait(.801)

				ParticlesModule.Enabled(WindupSparks, false)
				Burst = script.KJ.FiveSeasons.CharFX.ArmBurst:Clone()
				Burst.Parent = LeftArm
				ParticlesModule.Emit(Burst)
				Debris:AddItem(Burst, ParticlesModule.GetHLF(Burst))

				EnabledVFX = script.KJ.FiveSeasons.CharFX.ArmEnabled:Clone()
				EnabledVFX.Parent = LeftArm
				ParticlesModule.Enabled(EnabledVFX, true)
				task.delay(1.566, function()
					ParticlesModule.Enabled(EnabledVFX, false)
				end)
				Debris:AddItem(EnabledVFX, ParticlesModule.GetHLF(EnabledVFX) + 1.566)

				if Char == LocalCharacter then
					task.spawn(function()
						local CurrentCC = script.KJ.FiveSeasons.FirstCCs.FSRed:Clone()
						CurrentCC.Parent = game.Lighting

						task.wait(1/24)

						CurrentCC:Destroy()
						CurrentCC = script.KJ.FiveSeasons.FirstCCs.FSWhite:Clone()
						CurrentCC.Parent = game.Lighting

						task.wait(1/24)

						CurrentCC:Destroy()
						CurrentCC = script.KJ.FiveSeasons.FirstCCs.FinalCC:Clone()
						CurrentCC.Parent = game.Lighting

						local Highlight = script.KJ.FiveSeasons.Highlight:Clone()
						Highlight.Parent = Char

						TS:Create(CurrentCC, TweenInfo.new(.5, Enum.EasingStyle.Linear), { Brightness = 0; Contrast = 0; TintColor = Color3.new(1, 1, 1); }):Play()
						TS:Create(Highlight, TweenInfo.new(.5, Enum.EasingStyle.Linear), { FillTransparency = 1; OutlineTransparency = 1 }):Play()
						Debris:AddItem(CurrentCC, .5)
						Debris:AddItem(Highlight, .5)
					end)
				end

				local eyeShine = script.KJ.FiveSeasons.CharFX.EyeEmit:Clone()
				eyeShine.Parent = Char.Head
				ParticlesModule.Emit(eyeShine)
				Debris:AddItem(eyeShine, 1.7)
			end)

			task.delay(7.9, function()
				local TPFX = script.KJ.FiveSeasons.CharFX.TP:Clone()
				TPFX.Parent = Torso
				ParticlesModule.Emit(TPFX)
				Debris:AddItem(TPFX, ParticlesModule.GetHLF(TPFX))
			end)
		elseif Stage == 'Orbital Camera' then
			local Character: Model = Params.char
			local HumRP: BasePart = Character.HumanoidRootPart

			local orbitTime = Params.orbitTime


			local CameraPart = Instance.new("Part")
			CameraPart.Transparency = 1
			CameraPart.Size = Vector3.new(1, 1, 1)
			CameraPart.CanCollide = false
			CameraPart.CanTouch = false
			CameraPart.CanQuery = false


			local BV = Instance.new("BodyVelocity")
			BV.MaxForce = Vector3.new(1, 1, 1) * 100000
			BV.Velocity = Vector3.new(0, 0, 0)
			BV.Parent = CameraPart


			CameraTableAnims:StopAnimations()
			CameraPart.CFrame = workspace.CurrentCamera.CFrame
			CameraPart.CFrame = CFrame.lookAlong(CameraPart.Position, CameraPart.CFrame.LookVector * Vector3.new(1, 0, 1));
			CameraPart.Parent = workspace.Thrown


			local startTick = tick()


			local X_AxisRotation = Instance.new("NumberValue")
			X_AxisRotation.Value = 0

			local CameraSpeedMultiplier = Instance.new("NumberValue")
			CameraSpeedMultiplier.Value = 125

			local CameraHeightValue = Instance.new("NumberValue")
			CameraHeightValue.Value = 100

			TS:Create(CameraHeightValue, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { Value = 0 }):Play()
			TS:Create(CameraSpeedMultiplier, TweenInfo.new(10, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { Value = 0 }):Play()
			TS:Create(X_AxisRotation, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { Value = -90 }):Play()


			TS:Create(Camera, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { FieldOfView = 40 }):Play()

			Debris:AddItem(CameraPart, orbitTime)
			Debris:AddItem(BV, orbitTime)
			Debris:AddItem(X_AxisRotation, orbitTime)
			Debris:AddItem(CameraSpeedMultiplier, orbitTime)
			Debris:AddItem(CameraHeightValue, orbitTime)


			local cameraFollowConnection = RNS.RenderStepped:Connect(function(deltaTime)
				Camera.CameraType = Enum.CameraType.Scriptable
				BV.Velocity = BV.Velocity:Lerp(Character.Humanoid.MoveDirection * CameraSpeedMultiplier.Value + Vector3.new(0, CameraHeightValue.Value, 0), 1 - 5.0E-7 ^ deltaTime)
				Camera.CFrame = Camera.CFrame:Lerp(CameraPart.CFrame * CFrame.Angles(math.rad(X_AxisRotation.Value), 0, rad(HumRP.Orientation.Y - 180)), 1 - 5.0E-5 ^ deltaTime)
			end)


			local startTick = tick()
			while task.wait() do
				if tick() - startTick >= 5 or Character:HasTag('HurryUpFS') then
					break
				end
			end

			cameraFollowConnection:Disconnect()

		elseif Stage == 'Shoot' then
			local Char: Model = Params.Char
			local HumRP: BasePart = Char.HumanoidRootPart
			local Torso: BasePart = Char.Torso
			local LeftArm: BasePart = Char['Left Arm']

			if Char == LocalCharacter then
				task.spawn(function()
					CameraTableAnims:PlayAnimation('FiveEnd', HumRP)
				end)

				shared.ActivateiFrames('5 Seasons', { Stage = 'Koki'; })
			end

			task.delay(.833, function()
				if Char == LocalCharacter then
					Assets.Sounds.FiveStart:Stop()
					Assets.Sounds.FiveStart.TimePosition = 0
					Assets.Sounds.FiveEnd:Play()
				end

				local TPFX = script.KJ.FiveSeasons.CharFX.TP:Clone()
				TPFX.Parent = Torso
				ParticlesModule.Emit(TPFX)
				Debris:AddItem(TPFX, ParticlesModule.GetHLF(TPFX))

				local EnabledVFX = script.KJ.FiveSeasons.CharFX.FinalArmFXMirrored:Clone()
				EnabledVFX.Parent = LeftArm
				ParticlesModule.Enabled(EnabledVFX, true)
				Debris:AddItem(EnabledVFX, ParticlesModule.GetHLF(EnabledVFX) + 1.75)

				task.wait(1.75)

				ParticlesModule.Enabled(EnabledVFX, false)
			end)

			task.delay(3.6, function()
				task.spawn(function()
					local Fists = script.KJ.FiveSeasons.Fists:Clone()
					Fists.Parent = workspace.Thrown
					Fists.RootPos.CFrame = HumRP.CFrame
					Fists.RootPos.Orientation = Vector3.new(0, Fists.RootPos.Orientation.Y, 0)
					for _,i: Weld in Fists.RootPos.Welds:GetChildren() do
						local Part: Part = Fists:FindFirstChild(i.Name, true)
						Part.CFrame = Fists.RootPos.CFrame * i.C0
					end

					if HumRP.Parent == LocalCharacter then
						task.spawn(function()
							local cc = script.KJ.FiveSeasons.PunchesCC:Clone()
							cc.Parent = game.Lighting
							TS:Create(cc, TweenInfo.new(.825, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), { Brightness = 0; Contrast = 0; Saturation = 0; }):Play()
							Debris:AddItem(cc, .825)
						end)
					end

					for _,Fist: MeshPart in Fists.Fists:GetChildren() do
						local _time = 1.92 + Fist:GetAttribute('a')
						TS:Create(Fist, TweenInfo.new(_time, Enum.EasingStyle.Linear), { CFrame = Fist.CFrame * CFrame.new(0,0,-30) }):Play()
						TS:Create(Fist.Black, TweenInfo.new(.825, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), { Transparency = 1 }):Play()
						TS:Create(Fist.Black.Weld, TweenInfo.new(.825, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), { C0 = CFrame.new(0, 0, -24) }):Play()
						task.delay(_time + Fist:GetAttribute('a'), function()
							if Fist:FindFirstChild('Beam') then ParticlesModule.Enabled(Fist.Beam, false) ParticlesModule.Enabled(Fists.Primary, false) end

							TS:Create(Fist, TweenInfo.new(.05, Enum.EasingStyle.Circular, Enum.EasingDirection.In), { CFrame = Fist.CFrame * CFrame.new(0,0,-75), Size = Vector3.new(Fist.Size.X, Fist.Size.Y, 1000) }):Play()

							task.wait(.05)

							Fist:Destroy()
						end)
					end
					Debris:AddItem(Fists, 5)
				end)

				if Char == LocalCharacter then
					task.wait(1.92)

					shared.ActivateiFrames('5 Seasons', { Stage = 'Punches'; })
				end
			end)
		elseif Stage == 'FinalExplosion' then
			local FX = script.KJ.FiveSeasons.FinalExplosion:Clone()
			FX.Parent = workspace.Thrown
			FX.Primary.Position = Params.TargetPoint
			for _,i: Weld in FX.Primary:GetChildren() do
				local Part: Part = FX:FindFirstChild(i.Name, true)
				Part.CFrame = FX.Primary.CFrame * i.C0
			end
			Debris:AddItem(FX, 12)


			TS:Create(FX.Smoke, TweenInfo.new(.25), { Size = Vector3.new(262.358, 94.968, 262.358); CFrame = FX.Primary.CFrame * CFrame.new(0, -46.497, -0) * CFrame.Angles(0, math.rad(152.999), 0); }):Play()
			TS:Create(FX.Smoke.Decal, TweenInfo.new(.25), { Transparency = 1 }):Play()
			TS:Create(FX.Smoke.Mesh, TweenInfo.new(.25), { Scale = Vector3.new(119.254, 94.968, 119.254); }):Play()

			TS:Create(FX.Smoke2, TweenInfo.new(.25), { Size = Vector3.new(337.437, 119.166, 337.437); Transparency = 1; CFrame = FX.Primary.CFrame * CFrame.new(0, -1.881, -0) * CFrame.Angles(0, math.rad(50.002), 0); Color = Color3.fromRGB(166, 166, 166) }):Play()


			ParticlesModule.Emit(FX.Particles)
			ParticlesModule.Enabled(FX.Particles.Enabled, true)
			task.delay(10, function()
				ParticlesModule.Enabled(FX.Particles.Enabled, false)
			end)
		end
	end,

	['Collateral Ruin'] = function(Params)
		local Char = Params.Char
		local Stage = Params.Stage

		if Stage == 1 then
			local VFX = script.KJ["Collateral Ruin"].spinnerthing:Clone()
			VFX.Parent = Char
			VFX.Weld.Part0 = Char.HumanoidRootPart
			VFX:SetAttribute('Start', time())
			ParticlesModule.Enabled(VFX, true)
			Debris:AddItem(VFX, 5)
		elseif Stage == 2 then
			local VFX = Char:FindFirstChild('spinnerthing')
			if VFX then
				VFX:SetAttribute('Hit', time())

				for _,p: ParticleEmitter in VFX:GetDescendants() do
					if p:IsA('ParticleEmitter') then
						p.TimeScale = 0
					end
				end
			end
		elseif Stage == 3 then
			local ImpactAttachment = script.KJ["Collateral Ruin"].ImpactEffect.CollateralImpact:Clone()
			ImpactAttachment.Parent = Params.Hit.Torso
			ParticlesModule.Emit(ImpactAttachment)
			Debris:AddItem(ImpactAttachment, .5)
		elseif Stage == 4 then
			local SpinnerEndVFX = script.KJ["Collateral Ruin"].SpinnerDownMesh:Clone()
			SpinnerEndVFX.Parent = workspace.Effects
			SpinnerEndVFX.CFrame = Char.HumanoidRootPart.CFrame * CFrame.Angles(0, 0, rad(90))
			TS:Create(SpinnerEndVFX, TweenInfo.new(.1), { CFrame = SpinnerEndVFX.CFrame * CFrame.new(-3, 0, 0) * CFrame.Angles(rad(90), 0, 0) }):Play()
			TS:Create(SpinnerEndVFX.Mesh, TweenInfo.new(.1), { Scale = Vector3.new(0, .75, .75) }):Play()
			TS:Create(SpinnerEndVFX.Decal, TweenInfo.new(.1), { Transparency = 1 }):Play()
			Debris:AddItem(SpinnerEndVFX, .1)
		elseif Stage == 5 then
			local VFX = Char:FindFirstChild('spinnerthing')
			if VFX then
				VFX.Parent = workspace.Thrown

				for _,p: ParticleEmitter in VFX:GetDescendants() do
					if p:IsA('ParticleEmitter') then
						p.TimeScale = 1
					end
				end

				if VFX:GetAttribute('Hit') then
					task.delay(time() - VFX:GetAttribute('Hit'), function()
						ParticlesModule.Enabled(VFX, false)
					end)
				else
					ParticlesModule.Enabled(VFX, false)
				end
			end
		elseif Stage == 6 then
			task.spawn(function()
				for _, Hit in Params.Hits do
					if not Hit.Parent then continue end

					local ImpactAttachment = Hit.Torso:FindFirstChild('CollateralImpact')
					if ImpactAttachment then
						for _,v in ImpactAttachment:GetDescendants() do
							if v:IsA('ParticleEmitter') then
								v.TimeScale = 1
							end
						end
					end
				end
			end)


			local EndVFX = script.KJ["Collateral Ruin"].SpinnerEndWind:Clone()
			EndVFX.Parent = workspace.Effects
			EndVFX.CFrame = Char.HumanoidRootPart.CFrame
			ParticlesModule.Emit(EndVFX)
			Debris:AddItem(EndVFX, 2)


			local ray = raycast(Char.HumanoidRootPart.Position, Vector3.new(0, -5, 0), MapRayParams)
			if ray and ray.Instance then
				local GroundLifetime = math.random(3, 6)
				local TimeBeforeFade = GroundLifetime/1.5

				local Ground = script.KJ["Collateral Ruin"].grouncracknoclippinglolo:Clone()
				Ground.Parent = workspace.Effects
				Ground.Position = ray.Position
				Ground.Rotation = Vector3.new(0, math.random(0, 359), 0)
				Debris:AddItem(Ground, GroundLifetime)

				task.wait(TimeBeforeFade)

				local TN_Time = GroundLifetime - TimeBeforeFade

				TS:Create(Ground.dekal, TweenInfo.new(TN_Time, Enum.EasingStyle.Linear), { Transparency = 1 }):Play()
			end
		end
	end,

	['Signature'] = function(Params)

		local Stage = Params.Stage
		local Character: Model = Params.Char
		local HumRP = Character.HumanoidRootPart
		local Torso = Character.Torso
		local DropkickFolder = script.KJ.Dropkick

		if Stage == 'FirstImpact' then

			local vfx = script.KJ["Signature"].FirstImpact:Clone()
			vfx.Parent = workspace.Effects
			vfx.CFrame = HumRP.CFrame * CFrame.Angles(math.rad(0), math.rad(270), math.rad(0))
			ParticlesModule.Emit(vfx)
			Debris:AddItem(vfx, 2.656)

		elseif Stage == 'TP' then

			local tpFX = script.KJ.Dropkick.tpthing:Clone()
			tpFX.Parent = Character.Torso
			Debris:AddItem(tpFX, 5.435)

			local tasks = { -- Start 1.55
				task.delay(.125, function()
					ParticlesModule.Emit(tpFX)
					FlashstepModule(Character, .1)
				end);

				task.delay(2.650, function()
					ParticlesModule.Emit(tpFX)
					FlashstepModule(Character, .1)
				end);

				task.delay(2.785, function()
					ParticlesModule.Emit(tpFX)
					FlashstepModule(Character, .1)
				end);

				task.delay(3.195, function()
					ParticlesModule.Emit(tpFX)
					FlashstepModule(Character, .1)
				end);

				task.delay(3.569, function()
					ParticlesModule.Emit(tpFX)
					FlashstepModule(Character, .1)
				end);

				task.delay(4.100, function()
					ParticlesModule.Emit(tpFX)
					FlashstepModule(Character, .1)
				end);

				task.delay(4.350, function()
					ParticlesModule.Emit(tpFX)
					FlashstepModule(Character, .1)
				end);
			}

		elseif Stage == 'Impact' then

			local vfx = script.KJ["Signature"].finalimpacto.Impact:Clone()
			vfx.Parent = Torso
			ParticlesModule.Emit(vfx)
			Debris:AddItem(vfx, .6)

		elseif Stage == 'Start' then

			CameraTableAnims:PlayAnimation('KJSignature', HumRP)

		elseif Stage == 'KJ' then
			local letters = {}

			local k1 = script.KJ["Signature"].LETTERS.k1:Clone()
			k1.Parent = workspace.Effects
			k1.CFrame = HumRP.CFrame * CFrame.new(0,1,-70) * CFrame.Angles(math.rad(0), math.rad(180), math.rad(0))
			table.insert(letters, k1)

			task.wait(.19)

			local k2 = script.KJ["Signature"].LETTERS.k2:Clone()
			k2.Parent = workspace.Effects
			k2.CFrame = k1.CFrame
			table.insert(letters, k2)

			task.wait(.6)

			local k3 = script.KJ["Signature"].LETTERS.k3:Clone()
			k3.Parent = workspace.Effects
			k3.CFrame = k1.CFrame
			table.insert(letters, k3)

			task.wait(.22)

			local j1 = script.KJ["Signature"].LETTERS.j1:Clone()
			j1.Parent = workspace.Effects
			j1.CFrame = k1.CFrame
			table.insert(letters, j1)

			task.wait(.92)

			local j2 = script.KJ["Signature"].LETTERS.j2:Clone()
			j2.Parent = workspace.Effects
			j2.CFrame = k1.CFrame
			table.insert(letters, j2)

			for _,v in letters do
				local Beam = v:FindFirstChildWhichIsA('Beam', true)
				if not Beam then continue end

				TS:Create(Beam, TweenInfo.new(.1, Enum.EasingStyle.Circular, Enum.EasingDirection.In), { Brightness = 5; }):Play()
				task.delay(.1, function()
					TS:Create(Beam, TweenInfo.new(2, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), { Brightness = 0; LightEmission = 1; }):Play()
				end)
				Debris:AddItem(v, 2.1)
			end
		end
	end,

	Ravage = function(Params)
		if Params.Stage == 'Start' then
			local Character: Model = Params.Character
			local HumRP: BasePart = Character.HumanoidRootPart

			local EnemyCharacter: Model = Params.EnemyCharacter
			local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart


			local AssetsFolder = script.KJ.Ravage


			local Smoke1 = AssetsFolder.Smoke1:Clone()
			Smoke1.CFrame = Character:GetPivot() * CFrame.new(-0.5975227355957031, -2.9642860889434814, 0.355224609375);
			Smoke1.Parent = workspace.Thrown
			local Smoke1Weld = QuickWeld(Character.Torso, Smoke1, Character.PrimaryPart)
			task.delay(0.23, function()
				Smoke1Weld:Destroy()
				Smoke1:Destroy()
			end)

			local Ultikwind1 = AssetsFolder.Ultikwind1:Clone()
			Ultikwind1.CFrame = HumRP.CFrame * CFrame.new(-0.2682533264160156, -0.11571979522705078, -1.545166015625) * CFrame.Angles(0, 1.5707963267948966, 0)
			Ultikwind1.Parent = workspace.Thrown

			TS:Create(Ultikwind1, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				CFrame = Ultikwind1.CFrame * CFrame.new(-0.2685203552246094, -0.11599993705749512, 1.2762451171875) * CFrame.Angles(3.141592653589793, 0, 0)
			}):Play()

			TS:Create(Ultikwind1.Mesh, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Scale = Vector3.new(0.5, 0.20000000298023224, 0.20000000298023224, 0)
			}):Play()

			TS:Create(Ultikwind1.Decal, TweenInfo.new(0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
				Transparency = 1
			}):Play()

			Debris:AddItem(Ultikwind1, 0.3)


			if Character == LocalCharacter or EnemyCharacter == LocalCharacter then
				shared.addshake(3)
			end

			local function OneAndTwo()
				local vfx = AssetsFolder.yessssss:Clone()
				vfx.Name = '1n2'
				vfx.CFrame = EnemyHumRP.CFrame
				vfx.Parent = EnemyCharacter
				ParticlesModule.Emit(vfx)
				Debris:AddItem(vfx, .9)

				if Character == LocalCharacter or EnemyCharacter == LocalCharacter then
					shared.addshake(3)
				end
			end

			task.delay(1.267, OneAndTwo)
			task.delay(1.650, OneAndTwo)

			task.delay(2.233, function()
				local vfx = AssetsFolder.barrage:Clone()
				vfx.Name = 'RavageBarrage'
				vfx.Weld.Part0 = EnemyHumRP
				vfx.Parent = EnemyCharacter
				Debris:AddItem(vfx,5)
				local vfx2 = AssetsFolder.BARRAGESMOKE:Clone()
				vfx2.CFrame = EnemyHumRP.CFrame
				vfx2.Parent = EnemyCharacter
				Debris:AddItem(vfx2,5)

				ParticlesModule.Enabled(vfx, true)
				ParticlesModule.Enabled(vfx2, true)

				task.delay(1.217, function()
					ParticlesModule.Enabled(vfx, false)
					ParticlesModule.Enabled(vfx2, false)


					local impactCFrame = EnemyCharacter.Head.CFrame

					local uppercutImpact = AssetsFolder.uppercutimpact:Clone()
					uppercutImpact.CFrame = impactCFrame
					uppercutImpact.Parent = workspace.Thrown
					TS:Create(uppercutImpact, TweenInfo.new(0.06, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
						CFrame = uppercutImpact.CFrame * CFrame.new(0, 7.076, 0)
					}):Play()
					TS:Create(uppercutImpact.Mesh, TweenInfo.new(0.06, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
						Scale = Vector3.new(0.699999988079071, 0, 0, 0)
					}):Play()

					local uppercutMesh = AssetsFolder.uppercutmesh:Clone()
					uppercutMesh.CFrame = EnemyHumRP.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(0, 0, rad(90))
					uppercutMesh.Parent = workspace.Thrown
					TS:Create(uppercutMesh, TweenInfo.new(0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
						CFrame = uppercutMesh.CFrame * CFrame.new(-11.931, 0, 0) * CFrame.Angles(-3.141592653589793, 0, 0)
					}):Play()
					TS:Create(uppercutMesh.Mesh, TweenInfo.new(0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
						Scale = Vector3.new(0, 0.6000000238418579, 0.6000000238418579, 0)
					}):Play()
					TS:Create(uppercutMesh.Decal, TweenInfo.new(0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
						Transparency = 1
					}):Play()

					local rayInstance, rayPosition = raycast(
						impactCFrame.Position + Vector3.yAxis,
						Vector3.new(0, -50, 0),
						nil,
						true
					)

					if rayInstance and Utility('PropChecker')(rayInstance, 'Color') then
						local smokeColor = rayInstance.Color

						local uppercutSmoke = AssetsFolder.UPPERCUTSMOKE:Clone()
						uppercutSmoke.Size = Vector3.new(5, 5, 5)
						uppercutSmoke.Position = rayPosition
						uppercutSmoke.Parent = workspace.Thrown
						uppercutSmoke.UPPERCUTSMOKE["1"].Color = ColorSequence.new(smokeColor)
						uppercutSmoke.UPPERCUTSMOKE["2"].Color = ColorSequence.new(smokeColor)
						ParticlesModule.Emit(uppercutSmoke)
						Debris:AddItem(uppercutSmoke, 2)
					end;
					Debris:AddItem(uppercutMesh, 1)
					Debris:AddItem(uppercutImpact, 1)

					if Character == LocalCharacter or EnemyCharacter == LocalCharacter then
						shared.addshake(3)
					end
				end)
			end)

			task.delay(4.083, function()
				local vfx = AssetsFolder.RUNAROUNDWIND:Clone()
				vfx.Name = 'RUNAROUNDWIND'
				vfx.Weld.Part0 = EnemyHumRP
				vfx.Parent = EnemyCharacter
				ParticlesModule.Enabled(vfx, true)
				Debris:AddItem(vfx, .95)

				local spinbeam = AssetsFolder.spinbeam:Clone()
				spinbeam.Parent = Character
				spinbeam.CFrame = HumRP.CFrame * CFrame.new(0, -3, 5)
				ParticlesModule.Enabled(vfx, true)
				Debris:AddItem(vfx, .5)



				task.spawn(function()
					local rocksProps = { Material = Enum.Material.SmoothPlastic; Color = Color3.fromRGB(163, 162, 165); }
					local spinningRocks = AssetsFolder.SpinningHolder:Clone()
					spinningRocks.Parent = EnemyCharacter
					spinningRocks.CFrame = EnemyHumRP.CFrame * CFrame.new(0, -.1, -2.7)


					local rayParams = RaycastParams.new()
					rayParams.FilterType = Enum.RaycastFilterType.Include
					rayParams.FilterDescendantsInstances = { workspace.Map }
					local materialRay = workspace:Raycast(spinningRocks.Position, Vector3.new(0, -10, 0), rayParams)
					if materialRay and materialRay.Instance then
						rocksProps.Material = materialRay.Instance.Material
						rocksProps.Color = materialRay.Instance.Color
					end

					Debris:AddItem(spinningRocks, 3)
					for _,v in spinningRocks.RocksWelds:GetChildren() do
						if v:IsA('Weld') then
							v.Part1.Color = rocksProps.Color
							v.Part1.Material = rocksProps.Material
							v.C0 *= CFrame.Angles(math.rad(math.random(0, 179)), math.rad(math.random(0, 179)), math.rad(math.random(0, 179)))
						end
					end


					local bpos = Instance.new('BodyPosition')
					bpos.Position = (EnemyHumRP.CFrame * CFrame.new(0, -.1, -2.7)).Position
					bpos.Parent = spinningRocks
					local vel = Instance.new('BodyAngularVelocity')
					vel.Parent = spinningRocks
					vel.MaxTorque = Vector3.new(1, 1, 1) * 40000


					local speed = Instance.new('NumberValue')
					speed.Value = 500
					speed.Parent = spinningRocks
					Debris:AddItem(speed, .5)
					TS:Create(speed, TweenInfo.new(.5), { Value = 50 }):Play()

					repeat
						vel.AngularVelocity = Vector3.new(0, -.1 * speed.Value, 0)

						task.wait()
					until speed.Parent == nil or speed.Value == 50

					for _,v in spinningRocks.RocksWelds:GetChildren() do
						if v:IsA('Weld') then
							v.Enabled = false
						end
					end

					task.wait(1.5)

					for _,v in spinningRocks.RocksWelds:GetChildren() do
						if v:IsA('Weld') then
							TS:Create(v.Part1, TweenInfo.new(1), { Size = Vector3.zero; }):Play()
						end
					end
				end)



				task.wait(.3)

				ParticlesModule.Enabled(vfx, false)

				TS:Create(spinbeam.beam2.Beam, TweenInfo.new(.3), { Brightness = 0; }):Play()
			end)

			task.delay(4.650, function()
				local speedlines = AssetsFolder["Left Leg"].speedlines:Clone()
				speedlines.Parent = Character['Left Leg']
				Debris:AddItem(speedlines, .5)

				local starries = AssetsFolder["Left Leg"].starries:Clone()
				starries.Parent = Character['Left Leg']
				Debris:AddItem(starries, .5)
			end)

			task.delay(5.383, function()
				local vfx = AssetsFolder.lastkick:Clone()
				vfx.Parent = EnemyCharacter
				vfx.CFrame = HumRP.CFrame
				ParticlesModule.Emit(vfx)
				Debris:AddItem(vfx, 2)

				local frame = AssetsFolder.lastkickframe:Clone()
				frame.Parent = EnemyCharacter
				frame.CFrame = HumRP.CFrame * CFrame.Angles(0, rad(-90), 0)
				TS:Create(frame.Mesh, TweenInfo.new(.25), { Scale = Vector3.new(1.5,.5,.5) }):Play()
				TS:Create(frame.Decal, TweenInfo.new(.25), { Transparency = 1 }):Play()
				Debris:AddItem(frame,.25)

				if Character == LocalCharacter or EnemyCharacter == LocalCharacter then
					shared.addshake(6)
				end
			end)
		end
	end,

	['Stoic Bomb'] = function(Params)
		local Character = Params.Char
		local Torso: BasePart = Character.Torso
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid


		local SpeedLines = script.KJ["Stoic Bomb"].stoiclines:Clone()
		task.delay(.717, function()
			SpeedLines.Parent = Character
			repeat
				SpeedLines.CFrame = CFrame.lookAlong(Torso.Position, Vector3.new(1, 0, 0))
				task.wait()
			until SpeedLines.Parent == nil
		end)


		local Bolita = script.KJ["Stoic Bomb"].Bolita:Clone()
		task.delay(1.117,function()
			local Arrive = script.KJ["Stoic Bomb"].stoicarrive:Clone()
			Arrive.Parent = workspace.Effects
			Arrive.WeldConstraint.Part0 = Torso
			Arrive.Position = Torso.Position - Vector3.new(0, 10, 0)
			TS:Create(Arrive.Mesh, TweenInfo.new(.25), { Scale = Vector3.new(0, 1, 1) }):Play()
			TS:Create(Arrive.Decal, TweenInfo.new(.05), { Transparency = 1 }):Play()
			Debris:AddItem(Arrive, .25)


			ParticlesModule.Enabled(SpeedLines, false)
			Debris:AddItem(SpeedLines, .1)


			Bolita.Parent = Character
			Bolita.Position = Torso.Position - Vector3.new(0, 4, 0)
			Bolita.WeldConstraint.Part0 = Character.Torso
		end)


		local DefaultProps = {
			Ambient = Lighting.Ambient;
			Brightness = Lighting.Brightness;
			ColorShift_Bottom = Lighting.ColorShift_Bottom;
			ColorShift_Top = Lighting.ColorShift_Top;
			EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale;
			EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale; 
			OutdoorAmbient = Lighting.OutdoorAmbient;
			ExposureCompensation = Lighting.ExposureCompensation;
		}

		local Entrance = script.KJ["Stoic Bomb"].stoicentrance:Clone()
		task.delay(1.233, function()
			Entrance.Parent = Character
			Entrance.Position = HumRP.Position
			ParticlesModule.Emit(Entrance.Attachment)
			ParticlesModule.Emit(Entrance.smok)
			ParticlesModule.Emit(Entrance["BOMB.TWO."])
			Debris:AddItem(Entrance, 7)

			if Character == game.Players.LocalPlayer.Character then
				TS:Create(Lighting, TweenInfo.new(.384), { Ambient = Color3.new(0,0,0); Brightness = 0; ColorShift_Bottom = Color3.new(0, 0, 0); ColorShift_Top = Color3.new(0, 0, 0); EnvironmentDiffuseScale = 0; EnvironmentSpecularScale = 0; OutdoorAmbient = Color3.new(0, 0, 0) }):Play()
			end
		end)

		local bottomRay, BottomPart
		task.delay(1.500, function()
			bottomRay = raycast(HumRP.Position, Vector3.new(0, -10000, 0), MapRayParams)

			if bottomRay then 
				BottomPart = bottomRay.Position
			else
				return
			end


			local Arrive = script.KJ["Stoic Bomb"].stoicarrive:Clone()
			Arrive.Parent = workspace.Thrown
			Arrive.Position = BottomPart + Vector3.new(0, 5, 0)
			Arrive.Mesh.Scale = Vector3.new(2, 0.1, 0.1)
			TS:Create(Arrive.Mesh, TweenInfo.new(.5), { Scale = Vector3.new(2, 1.5, 1.5); }):Play()	
			TS:Create(Arrive.Decal, TweenInfo.new(.75), { Transparency = 1 }):Play()
			Debris:AddItem(Arrive, .75)



			local HollowTime = 2.25

			local Hollow = script.KJ["Stoic Bomb"].Outty:Clone()
			Hollow.Parent = workspace.Effects
			Hollow.Position = BottomPart + Vector3.new(0, 2.5, 0)
			Hollow.Size /= 3
			TS:Create(Hollow, TweenInfo.new(HollowTime), { Transparency = 1; Size = Vector3.new(20.548, 1.652, 20.548)/3; }):Play()
			Debris:AddItem(Hollow, HollowTime)

			local Hollow2 = script.KJ["Stoic Bomb"].Outty:Clone()
			Hollow2.Parent = workspace.Effects
			Hollow.Size /= 2
			Hollow2.Position = BottomPart + Vector3.new(0, 7.5, 0)
			TS:Create(Hollow2, TweenInfo.new(HollowTime), { Transparency = 1; Size = Vector3.new(20.548, 1.652, 20.548)/2; }):Play()
			Debris:AddItem(Hollow2, HollowTime)

			local Hollow3 = script.KJ["Stoic Bomb"].Outty:Clone()
			Hollow3.Parent = workspace.Effects
			Hollow3.Position = BottomPart + Vector3.new(0, 12.5, 0)
			TS:Create(Hollow3, TweenInfo.new(HollowTime), { Transparency = 1; Size = Vector3.new(20.548, 1.652, 20.548); }):Play()
			Debris:AddItem(Hollow3, HollowTime)

			local Hollow4 = script.KJ["Stoic Bomb"].Outty:Clone()
			Hollow4.Parent = workspace.Effects
			Hollow4.Position = BottomPart + Vector3.new(0, 1, 0)
			Hollow4.Size = Vector3.new(30, .5, 30)
			TS:Create(Hollow4, TweenInfo.new(HollowTime), { Transparency = 1; Size = Vector3.new(60, .5, 60); }):Play()
			Debris:AddItem(Hollow4, HollowTime)


			local HEAT = script.KJ["Stoic Bomb"].HEAT:Clone()
			HEAT.Parent = workspace.Effects
			HEAT.PrimaryPart.Position = BottomPart
			local ScaleValue = Instance.new('NumberValue')
			ScaleValue.Value = HEAT:GetScale()
			ScaleValue:GetPropertyChangedSignal('Value'):Connect(function()
				HEAT:ScaleTo(ScaleValue.Value)

				HEAT.PrimaryPart.Position = BottomPart
			end)
			TS:Create(ScaleValue, TweenInfo.new(.5), { Value = 5 }):Play()
			Debris:AddItem(ScaleValue, .5)
			Debris:AddItem(HEAT, 1.9)


			local EmitTimes = 5
			local TweenTime = 1.9/EmitTimes
			for i = 1, EmitTimes do
				local InWind = script.KJ["Stoic Bomb"].InWind:Clone()
				InWind.Parent = workspace.Effects
				InWind.Orientation = Vector3.new(0, math.random(0, 360), 0)
				InWind.Position = BottomPart + Vector3.new(0, 5, 0)
				TS:Create(InWind, TweenInfo.new(TweenTime), { Size = Vector3.new(13.74, 1.825, 13.74); Transparency = 1; }):Play()
				Debris:AddItem(InWind, TweenTime)

				local NormalWind = script.KJ["Stoic Bomb"].NormalWind:Clone()
				NormalWind.Parent = workspace.Effects
				NormalWind.Orientation = Vector3.new(0, math.random(0, 360), 0)
				NormalWind.Position = BottomPart + Vector3.new(0, 5, 0)
				TS:Create(NormalWind, TweenInfo.new(TweenTime), { Size = Vector3.new(41.22, 11.007, 41.22); Orientation = Vector3.new(0, 90, 0); Transparency = 1; }):Play()
				Debris:AddItem(NormalWind, TweenTime)

				local OtherWind = script.KJ["Stoic Bomb"].OtherWind:Clone()
				OtherWind.Parent = workspace.Effects
				OtherWind.Orientation = Vector3.new(0, math.random(0, 360), 0)
				OtherWind.Position = BottomPart + Vector3.new(0, 5, 0)
				TS:Create(OtherWind, TweenInfo.new(TweenTime * 2), { Size = Vector3.new(45.028, 6.59, 43.615); Orientation = Vector3.new(0, 90, 0); Transparency = 1; }):Play()
				Debris:AddItem(OtherWind, TweenTime * 2)

				task.wait(TweenTime)
			end
		end)

		task.delay(2.4, function()
			if Character == LocalCharacter then
				if Character == game.Players.LocalPlayer.Character then
					TS:Create(Lighting, TweenInfo.new(1, Enum.EasingStyle.Linear), { ExposureCompensation = 7;  }):Play()
				end

				task.wait(1)

				if Character == game.Players.LocalPlayer.Character then
					task.spawn(function()
						for i = 1, 5 do
							Lighting.Ambient = DefaultProps.Ambient
							Lighting.Brightness = DefaultProps.Brightness
							Lighting.ColorShift_Bottom = DefaultProps.ColorShift_Bottom
							Lighting.ColorShift_Top = DefaultProps.ColorShift_Top
							Lighting.EnvironmentDiffuseScale = DefaultProps.EnvironmentDiffuseScale
							Lighting.EnvironmentSpecularScale = DefaultProps.EnvironmentSpecularScale
							Lighting.OutdoorAmbient = DefaultProps.OutdoorAmbient
							Lighting.ExposureCompensation = DefaultProps.ExposureCompensation

							task.wait(.1)
						end
					end)
				end

				local preExplosion = script.KJ["Stoic Bomb"].pre:Clone()
				preExplosion.Parent = workspace.Effects
				preExplosion.PrimaryPart.Position = Bolita.Position
				ParticlesModule.Emit(preExplosion)
				Debris:AddItem(preExplosion, .4)
			end
		end)


		local Bomba = script.KJ["Stoic Bomb"].Bombita:Clone()
		task.delay(3.600, function()
			local ScaleModifier = 15
			local BolitaPos = Bolita.Position


			task.spawn(function()
				for i = 1, 3 do
					local SIRR2 = script.KJ["Stoic Bomb"].SIRR2:Clone()
					SIRR2.Parent = workspace.Effects
					SIRR2.Size *= ScaleModifier/2
					SIRR2.Position = BolitaPos + Vector3.new(0, SIRR2.Size.Y/2, 0)
					TS:Create(SIRR2, TweenInfo.new(.1), { Size = Vector3.new(17.458, 0.042, 17.458) * ScaleModifier/2; Position = SIRR2.Position + Vector3.new(0, 13.196, 0) * ScaleModifier/2 }):Play()
					Debris:AddItem(SIRR2, .1)

					task.wait(.05)
				end
			end)

			local WHAT = script.KJ["Stoic Bomb"].WHAT:Clone()
			WHAT.Parent = workspace.Effects
			WHAT.Size *= ScaleModifier/3
			WHAT.Position = BolitaPos + Vector3.new(0, WHAT.Size.Y/2, 0)
			TS:Create(WHAT, TweenInfo.new(.3), { Transparency = 1; Color = Color3.fromRGB(248, 248, 248); Size = Vector3.new(45.303, 18.187, 46.047) * ScaleModifier/3; Position = WHAT.Position + Vector3.new(-0.388, -0.135, 0) * ScaleModifier/3; }):Play()
			Debris:AddItem(WHAT, .3)

			local Brother = script.KJ["Stoic Bomb"].Brother:Clone()
			Brother.Parent = workspace.Effects
			Brother.Size *= ScaleModifier/3
			Brother.Position = BolitaPos + Vector3.new(0, Brother.Size.Y/2, 0)
			TS:Create(Brother, TweenInfo.new(.3), { Position = Brother.Position + Vector3.new(-0.848, 0, 0); }):Play()
			TS:Create(Brother.Mesh, TweenInfo.new(.3), { Scale = Vector3.new(2.522, 1.526, 1.475) * ScaleModifier/3; }):Play()
			TS:Create(Brother.Decal, TweenInfo.new(.3), { Transparency = 1; }):Play()
			Debris:AddItem(Brother, .3)


			ParticlesModule.Emit(Entrance.THEACTUALBOOM)
			ParticlesModule.Enabled(Bolita, false)
			Debris:AddItem(Bolita, 1.35)


			Bolita:Destroy()
			Bomba.Parent = workspace.Effects
			local ScaleValue = Instance.new('NumberValue')
			ScaleValue.Value = Bomba:GetScale()
			ScaleValue:GetPropertyChangedSignal('Value'):Connect(function()
				Bomba:ScaleTo(ScaleValue.Value)

				for _,Part: MeshPart in Bomba:GetChildren() do
					if Part:IsA('MeshPart') then
						Part.Position = BolitaPos
					end
				end
			end)
			TS:Create(ScaleValue, TweenInfo.new(.5), { Value = ScaleValue.Value * ScaleModifier }):Play()
			Debris:AddItem(ScaleValue, .5)
			ParticlesModule.Enabled(Bomba, false)

			for _,Part: MeshPart in Bomba:GetDescendants() do
				if Part:IsA('MeshPart') or Part:IsA('Part') then
					Part.Position = BolitaPos

					TS:Create(Part, TweenInfo.new(.5), { Orientation = Vector3.new(0, math.random(1, 180), 0) }):Play()
					task.delay(.2, function()
						TS:Create(Part, TweenInfo.new(.3), { Transparency = 1 }):Play()

						local Decal = Part:FindFirstChildOfClass('Decal')
						if Decal then
							TS:Create(Decal, TweenInfo.new(.3), { Transparency = 1 }):Play()
						end
					end)
				end
			end
			Debris:AddItem(Bomba, 5)

			if Character == LocalCharacter or (Character:GetPivot().Position - LocalCharacter:GetPivot().Position).Magnitude <= 100 then
				shared.addshake(Random.new():NextNumber(1, 2))
			end


			if not BottomPart then return end

			task.spawn(function()
				local rockParams = {
					start = BottomPart + Vector3.new(0, 0.10000000149011612, 0, 0), 
					["end"] = Vector3.new(0, -14, 0, 0), 
					amount = 4, 
					nosound = true, 
					nosmoke = true
				}

				rockParams.stronger = { minus = 0 }
				rockParams.sizemult = 1.45
				rockParams.size = 3.5

				shared.repfire('rockCircle', { CF = CFrame.new(BottomPart), Radius = 100, flyRocks = false, specialRocks = rockParams, Sound = false, smoke = false, })
			end)

			local flyRocksNumber = math.random(6, 12)
			for i = 1, flyRocksNumber do
				local sizePack = math.random(2, 4)
				local flyingDebris = script.Rocks.rockCircle.DefaultPart:Clone() do
					local velocity = RandomSeed:NextNumber(4,7)
					flyingDebris.CFrame = CFrame.new(BottomPart) * CFrame.new(0,0.25,0)
					flyingDebris.Anchored = false
					flyingDebris.CollisionGroup = "NonPColDebri"
					flyingDebris.CanCollide = true
					flyingDebris.Material = bottomRay.Material
					flyingDebris.Color = bottomRay.Instance.Color
					flyingDebris.Size = Vector3.new(2, 2, 2) * sizePack
					flyingDebris.Parent = workspace.Thrown
					flyingDebris.AssemblyAngularVelocity = Vector3.new(RandomSeed:NextNumber(-25, 25), RandomSeed:NextNumber(-25, 25), RandomSeed:NextNumber(-25, 25))
					flyingDebris.AssemblyLinearVelocity = (CFrame.Angles(0, 2 * math.pi * i/flyRocksNumber + rad(RandomSeed:NextNumber(-25, 25)), 0) * CFrame.Angles(rad(RandomSeed:NextNumber(25, 30)), 0, 0)).UpVector * (velocity * 50)
					Debris:AddItem(flyingDebris, 6)

					task.delay(5,function()
						TS:Create(flyingDebris,TweenInfo.new(1,Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),{Size = flyingDebris.Size/2,Transparency = 1}):Play()
					end)
				end
			end
		end)
	end,

	SwiftSweep = function(Params)
		local Char: Model = Params.Char
		local Stage = Params.Stage


		if Stage == 'Swing1' then
			if not Params.Hit then
				local TweenTime = .150/2


				local SpinnerRocks = script.KJ.SwiftSweep.particlespinner:Clone()
				SpinnerRocks.Parent = Char
				SpinnerRocks.Weld.Part0 = Char.HumanoidRootPart
				Debris:AddItem(SpinnerRocks, 10)

				TS:Create(SpinnerRocks.Weld, TweenInfo.new(TweenTime * 2, Enum.EasingStyle.Linear), { C0 = CFrame.new(0, -3, 0) * CFrame.Angles(0, rad(175), 0); }):Play()
				task.delay(TweenTime * 2, function()
					ParticlesModule.Enabled(SpinnerRocks, false)
				end)



				local ActualSmear = script.KJ.SwiftSweep.SweepCresc:Clone()
				ActualSmear.Parent = Char
				ActualSmear.Weld.Part0 = Char.HumanoidRootPart
				ActualSmear.Weld.C0 = CFrame.new(0, -1.5, 0) * CFrame.Angles(0, rad(60), rad(180))
				Debris:AddItem(ActualSmear, TweenTime * 2)


				TS:Create(ActualSmear.Decal, TweenInfo.new(TweenTime, Enum.EasingStyle.Linear), { Transparency = 0 }):Play()
				TS:Create(ActualSmear.Weld, TweenInfo.new(TweenTime * 2, Enum.EasingStyle.Linear), { C0 = CFrame.new(0, -1.5, 0) * CFrame.Angles(0, rad(-160), rad(180)) }):Play()

				task.delay(TweenTime, function()
					TS:Create(ActualSmear.Decal, TweenInfo.new(TweenTime, Enum.EasingStyle.Linear), { Transparency = 1 }):Play()
				end)
			else
				local HitFX = script.KJ.SwiftSweep.SweepHit:Clone()
				HitFX.Parent = workspace.Thrown
				HitFX.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(1, -2.5, -3.75) * CFrame.Angles(0, 0, rad(90))
				TS:Create(HitFX.Mesh, TweenInfo.new(.25), { Scale = Vector3.new(0, -10, 0) }):Play()
				Debris:AddItem(HitFX, .25)


				local TweenTime = .350/2

				task.wait(.133)


				local StrangeEffect = script.KJ.SwiftSweep.LegSweepHit.HitTwo:Clone()
				StrangeEffect.Parent = Char.Torso
				ParticlesModule.Emit(StrangeEffect)
				Debris:AddItem(StrangeEffect, .1)


				local ActualSmear = script.KJ.SwiftSweep.FollowUpCresc:Clone()
				ActualSmear.Parent = Char
				ActualSmear.Weld.Part0 = Char.HumanoidRootPart
				ActualSmear.Weld.C0 = CFrame.new(0, -1, 0)
				ActualSmear.Weld.C1 = CFrame.Angles(rad(-17.686), rad(-102.845), rad(165.899))
				Debris:AddItem(ActualSmear, 60)


				TS:Create(ActualSmear.Decal, TweenInfo.new(TweenTime, Enum.EasingStyle.Linear), { Transparency = 0 }):Play()
				TS:Create(ActualSmear.Weld, TweenInfo.new(TweenTime * 2, Enum.EasingStyle.Linear), { C1 = CFrame.Angles(rad(-17.686), rad(72.845), rad(165.899)) }):Play()

				task.delay(TweenTime, function()
					TS:Create(ActualSmear.Decal, TweenInfo.new(TweenTime, Enum.EasingStyle.Linear), { Transparency = 1 }):Play()
				end)
			end
		end
	end,



	['3Days'] = function(Params)
		local Character: Model = Params.Char
		local HumRP: BasePart = Character.HumanoidRootPart
		local Stage = Params.Stage

		if Stage == 'Start' then
			local moonTexture = game.Lighting.Sky.MoonTextureId
			game.Lighting.Sky.MoonTextureId = ''
			require(game.ReplicatedStorage.Modules.Utility)('TriggerDay')(false)

			task.delay(5.95, function()
				game.Lighting.Sky.MoonTextureId = moonTexture
				require(game.ReplicatedStorage.Modules.Utility)('TriggerDay')(true)
			end)
		elseif Stage == 'Moon' then
			local Hitpos = Params.Hitpos

			local Moon = script.Kokushibo['3Days'].Moon:Clone()
			Moon.Parent = workspace.Thrown
			Moon.PrimaryPart.Size = Vector3.zero
			Moon.PrimaryPart.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(-750, 1000, 1000)
			local CF = CFrame.lookAt(Moon.PrimaryPart.Position, Hitpos) * CFrame.Angles(math.rad(90), 0, 0)
			Moon.PrimaryPart.CFrame = CF
			TS:Create(Moon.PrimaryPart, TweenInfo.new(3.567/2, Enum.EasingStyle.Linear), { Size = Vector3.new(1, 1, 1) * 50 }):Play()
			TS:Create(Moon.PrimaryPart, TweenInfo.new(3.567, Enum.EasingStyle.Linear), { CFrame = CFrame.new(Hitpos) * CF.Rotation }):Play()
			Debris:AddItem(Moon, 3.567)
		end
	end,

	DarkMoon = function(Params)
		local MainPart: BasePart = Params.MainPart
		local Stage = Params.Stage

		if Stage == 'Launch' then
			local VFX = script.Kokushibo.DarkMoon.Darkmoon_Slash:Clone()
			VFX.Parent = MainPart.Parent
			VFX.Main.CFrame = Params.CF

			TS:Create(VFX.Main, TweenInfo.new(.625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { CFrame = VFX.Main.CFrame * CFrame.new(0, 0, -50) }):Play()

			for _,v in VFX:GetDescendants() do
				if v:IsA('UnionOperation') then
					TS:Create(v, TweenInfo.new(.5), { Transparency = 1 }):Play()
				end
			end
			for _,v: Weld in VFX.Slash.Welds:GetChildren() do
				task.spawn(function()
					local num = math.rad(math.random(15, 30))

					repeat
						v.C1 *= CFrame.Angles(num,0,0)
						task.wait()
					until VFX == nil or VFX.Parent == nil
				end)
			end
			Debris:AddItem(VFX, 2)

			task.delay(.5, function()
				VFX.Slash.Moon.Enabled = false

				for _,v in VFX:GetChildren() do
					if v:IsA('UnionOperation') then
						v.Transparency = 1
					end
				end
			end)
		end
	end,

	LoathsomeMoon = function(Params)
		local Stage = Params.Stage

		if Stage == 'Slash1' then
			local Slash = script.Kokushibo.LoathsomeMoon.Slash:Clone()
			Slash.Parent = workspace.Thrown
			Slash.Size = Vector3.zero
			Slash.CFrame = Params.CF * CFrame.new(0, 0, -5) * CFrame.Angles(0, 0, rad(45))
			TS:Create(Slash, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Size = Vector3.new(.5, 10, .1) }):Play()

			task.wait(.25)

			TS:Create(Slash, TweenInfo.new(2, Enum.EasingStyle.Linear), { Transparency = 1 }):Play()
			Debris:AddItem(Slash, 2)
		elseif Stage == 'Slash2' then
			local Slash = script.Kokushibo.LoathsomeMoon.Slash:Clone()
			Slash.Parent = workspace.Thrown
			Slash.Size = Vector3.zero
			Slash.CFrame = Params.CF * CFrame.new(0, 0, -5) * CFrame.Angles(0, 0, rad(-45))
			TS:Create(Slash, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Size = Vector3.new(.5, 10, .1) }):Play()

			TS:Create(Slash, TweenInfo.new(2, Enum.EasingStyle.Linear), { Transparency = 1 }):Play()
			Debris:AddItem(Slash, 2)
		elseif Stage == 'Shoot' then
			local HCF: CFrame = Params.CF
			local cf1: CFrame = Params.cf1
			local cf2: CFrame = Params.cf2

			for i = 1, 2 do
				local Shoots = script.Kokushibo.LoathsomeMoon.Shoots:Clone()
				Shoots.Parent = workspace.Thrown

				if i == 1 then
					Shoots.PrimaryPart.CFrame = cf1 * CFrame.Angles(0, 0, rad(45))
				else
					Shoots.PrimaryPart.CFrame = cf2 * CFrame.Angles(0, 0, rad(-45))
				end
				Shoots.PrimaryPart.CFrame *= CFrame.new(0, 0, -3)

				for _, Part: Part in Shoots:GetChildren() do
					if not Part:IsA('Folder') then
						local Moon = script.Kokushibo.LoathsomeMoon.HalfMoon:Clone()
						Moon.Parent = workspace.Thrown
						Moon.CFrame = Part.CFrame * CFrame.Angles(math.rad(90), 0, 0) * CFrame.new(0, 0, math.random(-.5, .5))
						TS:Create(Moon, TweenInfo.new(.625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { CFrame = Part.CFrame * CFrame.new(0, 0, -math.random(49.5, 50.5)) * CFrame.Angles(math.rad(90), 0, 0); }):Play()
						TS:Create(Moon, TweenInfo.new(.5, Enum.EasingStyle.Linear), { Transparency = 1 }):Play()
						Debris:AddItem(Moon, .625)
					end
				end

				Debris:AddItem(Shoots, .625)
			end
		end
	end,

	Moonlit = function(Params)
		local CF: CFrame = Params.CF
		local Stage = Params.Stage

		if Stage == 'Swing' then
			local ShockwaveAngle = Params.ShockwaveAngle
			local SlashTime = Params.SlashTime

			local SlashFX = script.Kokushibo.Moonlit.Slash:Clone()
			SlashFX.Parent = workspace.Thrown
			SlashFX.CFrame = CF
			ParticlesModule.Emit(SlashFX)
			Debris:AddItem(SlashFX, 2)

			for i = 1, 5 do
				local Shockwave = script.Kokushibo.Moonlit.Shockwave:Clone()
				Shockwave.Parent = workspace.Thrown
				Shockwave.PrimaryPart.CFrame = CF * Params.Offsets[i]
				TS:Create(Shockwave.Main, TweenInfo.new(.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Transparency = 1; }):Play()
				TS:Create(Shockwave.PrimaryPart, TweenInfo.new(.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { CFrame = Shockwave.PrimaryPart.CFrame * CFrame.new(0, 0, -100) }):Play()
				task.delay(.5, function()
					Shockwave.Main.Moon.Enabled = false
				end)
				Debris:AddItem(Shockwave, 1.5)
			end
		end
	end,

	PearlFlower = function(Params)
		local MainPart: BasePart = Params.MainPart
		local Stage = Params.Stage

		if Stage == 'Launch' then
			local VFX = script.Kokushibo.PearlFlower.PearFlower_Slash:Clone()
			VFX.Parent = MainPart.Parent
			VFX.Main.CFrame = Params.CF

			TS:Create(VFX.Main, TweenInfo.new(.3125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { CFrame = VFX.Main.CFrame * CFrame.new(0, 0, -25) }):Play()

			for _,v in VFX:GetDescendants() do
				if v:IsA('UnionOperation') then
					TS:Create(v, TweenInfo.new(.25), { Transparency = 1 }):Play()
				end
			end
			for _,v: Weld in VFX.Slash.Slash.Welds:GetChildren() do
				task.spawn(function()
					local num = math.rad(math.random(15, 30))

					repeat
						v.C1 *= CFrame.Angles(num,0,0)
						task.wait()
					until VFX == nil or VFX.Parent == nil
				end)
			end
			for _,v: Weld in VFX.Slash1.Slash.Welds:GetChildren() do
				task.spawn(function()
					local num = math.rad(math.random(15, 30))

					repeat
						v.C1 *= CFrame.Angles(num,0,0)
						task.wait()
					until VFX == nil or VFX.Parent == nil
				end)
			end
			Debris:AddItem(VFX, 1.3125)

			task.delay(.3125, function()
				VFX.Slash1.Slash.Moon.Enabled = false
				VFX.Slash.Slash.Moon.Enabled = false
			end)
		end
	end,
	
	

	WaningMoons = function(Params)
		local Character: Model = Params.Char
		local HumRP: BasePart = Character.HumanoidRootPart
		local Stage = Params.Stage

		if Stage == 'Dashes' then
			task.wait(.85)

			UserSettings().GameSettings.RotationType = Enum.RotationType.CameraRelative

			local dashInfo = TweenInfo.new(.483, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
			local dahsProps = { Value = 0 }

			local Speed = Instance.new('NumberValue')
			local dashVelocity = Instance.new("BodyVelocity")
			dashVelocity.Name = "Dash Velocity"
			dashVelocity.MaxForce = Vector3.new(100000, 0, 100000)
			dashVelocity.Parent = HumRP

			local connection = RNS.RenderStepped:Connect(function()
				if dashVelocity.Parent ~= nil then
					dashVelocity.Velocity = HumRP.CFrame.LookVector * Speed.Value
				end
			end)


			task.spawn(function()
				local VFX = script.Kokushibo.WaningMoons.Slash1:Clone()
				VFX.Parent = workspace.Thrown
				VFX.PrimaryPart.CFrame = HumRP.CFrame * CFrame.Angles(0, math.rad(-90), 0)
				ParticlesModule.Emit(VFX)
				Debris:AddItem(VFX, ParticlesModule.GetHLF(VFX))
			end)

			Speed.Value = 300
			TS:Create(Speed, TweenInfo.new(.483, dashInfo.EasingStyle, dashInfo.EasingDirection), dahsProps):Play()

			task.wait(.483)

			task.spawn(function()
				local VFX = script.Kokushibo.WaningMoons.Slash2:Clone()
				VFX.Parent = workspace.Thrown
				VFX.PrimaryPart.CFrame = HumRP.CFrame * CFrame.Angles(0, math.rad(-90), 0)
				ParticlesModule.Emit(VFX)
				Debris:AddItem(VFX, ParticlesModule.GetHLF(VFX))
			end)

			Speed.Value = 300
			TS:Create(Speed, TweenInfo.new(.6, dashInfo.EasingStyle, dashInfo.EasingDirection), dahsProps):Play()

			task.wait(.6)

			task.spawn(function()
				local VFX = script.Kokushibo.WaningMoons.Slash3:Clone()
				VFX.Parent = workspace.Thrown
				VFX.PrimaryPart.CFrame = HumRP.CFrame * CFrame.Angles(0, math.rad(-90), 0)
				ParticlesModule.Emit(VFX)
				Debris:AddItem(VFX, ParticlesModule.GetHLF(VFX))
			end)

			Speed.Value = 300
			TS:Create(Speed, TweenInfo.new(.433, dashInfo.EasingStyle, dashInfo.EasingDirection), dahsProps):Play()

			task.wait(.433)

			task.spawn(function()
				local VFX = script.Kokushibo.WaningMoons.Slash4:Clone()
				VFX.Parent = workspace.Thrown
				VFX.PrimaryPart.CFrame = HumRP.CFrame * CFrame.Angles(0, math.rad(-90), 0)
				ParticlesModule.Emit(VFX)
				Debris:AddItem(VFX, ParticlesModule.GetHLF(VFX))
			end)

			Speed.Value = 300
			TS:Create(Speed, TweenInfo.new(.433, dashInfo.EasingStyle, dashInfo.EasingDirection), dahsProps):Play()

			task.wait(.433)

			UserSettings().GameSettings.RotationType = Enum.RotationType.MovementRelative
			connection:Disconnect()
			dashVelocity:Destroy()
			Speed:Destroy()
		end
	end,
	
	HotHands = function(arg1_2, arg2)
		local TweenService_upvr = game:GetService("TweenService")
		local Debris_upvr = game:GetService("Debris")
		local Utils_upvr = script.Utils
		
		--var4_upvw:PlaySound(Sounds_upvr.Heian.FireArrow.Hands, HumanoidRootPart_2, game.SoundService.Effect)
		local clone_2 = Utils_upvr.Heian.FlameArrow.Hands:Clone()
		clone_2.LA.Weld.Part1 = arg1_2["Left Arm"]
		clone_2.RA.Weld.Part1 = arg1_2["Right Arm"]
		clone_2.Parent = arg2
	end;
	Clap = function(arg1_3, arg2) -- Line 36
		local TweenService_upvr = game:GetService("TweenService")
		local Debris_upvr = game:GetService("Debris")
		local Utils_upvr = script.Utils
		
		local Hands_3 = arg2:FindFirstChild("Hands")
		
		local HumanoidRootPart_4 = arg2:FindFirstChild("HumanoidRootPart") 
		if Hands_3 then
			for _, v_3 in Hands_3.LA.startup:GetChildren() do
				v_3.Enabled = false
			end
			for _, v_4 in Hands_3.RA.startup:GetChildren() do
				v_4.Enabled = false
			end
			for _, v_5 in Hands_3.LA.fire:GetChildren() do
				v_5.Enabled = true
			end
			for _, v_6 in Hands_3.RA.fire:GetChildren() do
				v_6.Enabled = true
			end
			for _, v_7 in Hands_3.LA.Beam:GetChildren() do
				v_7.Enabled = true
			end
			--[[TweenService_upvr:Create(var4_upvw:PlaySound(Sounds_upvr.Heian.FireArrow.FlameIdle, Hands_3.RA, game.SoundService.Effect), TweenInfo.new(3), {
				Volume = 1;
			}):Play()]]
		end
		local clone = Utils_upvr.Heian.FlameArrow.Clap:Clone()
		clone.CFrame = HumanoidRootPart_4.CFrame
		Debris_upvr:AddItem(clone, 2)
		clone.Parent = arg2
		for i_8, v_8 in clone.C1:GetChildren() do
			v_8:Emit(v_8:GetAttribute("EmitCount"))
		end
		--var4_upvw:PlaySound(Sounds_upvr.Heian.FireArrow.Clap, HumanoidRootPart_4, game.SoundService.Effect)
	end;
	Clap2 = function(arg1_4, arg2) -- Line 60
		local TweenService_upvr = game:GetService("TweenService")
		local Debris_upvr = game:GetService("Debris")
		local Utils_upvr = script.Utils
		
		local HumanoidRootPart_3 = arg1_4:FindFirstChild("HumanoidRootPart")
		local clone_7 = Utils_upvr.Heian.FlameArrow.Clap:Clone()
		clone_7.CFrame = HumanoidRootPart_3.CFrame
		Debris_upvr:AddItem(clone_7, 2)
		clone_7.Parent = arg2
		for i_9, v_9 in clone_7.C2:GetChildren() do
			v_9:Emit(v_9:GetAttribute("EmitCount"))
		end
		--if LocalPlayer_upvr.Character == arg1_4 then
		--	v_9 = CameraShaker_upvr
		--	i_9 = v_9.Presets
		--	i_9 = 2
		--	CameraShaker_upvr.CurrentShaker:ShakeSustain(i_9.Snap):StartFadeOut(i_9)
		--end
		--var4_upvw:PlaySound(Sounds_upvr.Heian.FireArrow.Clap, HumanoidRootPart_3, game.SoundService.Effect)
		--var4_upvw:PlaySound(Sounds_upvr.Heian.Flames, HumanoidRootPart_3, game.SoundService.Voice)
	end;
	Arrow = function(arg1_5, arg2) -- Line 77
		local TweenService_upvr = game:GetService("TweenService")
		local Debris_upvr = game:GetService("Debris")
		local Utils_upvr = script.Utils
		
		local HumanoidRootPart = arg1_5:FindFirstChild("HumanoidRootPart")
		local Hands = arg2:FindFirstChild("Hands")
		if Hands then
			for _, v_10 in Hands.LA.fire:GetChildren() do
				v_10.Enabled = false
			end
			for _, v_11 in Hands.RA.fire:GetChildren() do
				v_11.Enabled = false
			end
			for _, v_12 in Hands.LA.Beam:GetChildren() do
				v_12.Enabled = false
			end
		end
		local clone_8 = Utils_upvr.Heian.FlameArrow.Arrow:Clone()
		clone_8.Weld.Part1 = HumanoidRootPart
		clone_8.Parent = arg2
		for _, v_13 in clone_8.Beam:GetChildren() do
			TweenService_upvr:Create(v_13, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
				Brightness = 50;
			}):Play()
			local _
		end
		TweenService_upvr:Create(clone_8.light.SpotLight, TweenInfo.new(0.4), {
			Brightness = 2;
		}):Play()
		TweenService_upvr:Create(clone_8.Ground.PointLight, TweenInfo.new(1), {
			Brightness = 2;
		}):Play()
		--var4_upvw:PlaySound(Sounds_upvr.Heian.FireArrow.Arrow, HumanoidRootPart, game.SoundService.Effect)
	end;
	Fire = function(arg1_6, arg2) -- Line 100
		local TweenService_upvr = game:GetService("TweenService")
		local Debris_upvr = game:GetService("Debris")
		local Utils_upvr = script.Utils
		
		local HumanoidRootPart_5 = arg1_6:FindFirstChild("HumanoidRootPart")
		local Hands_2 = arg2:FindFirstChild("Hands")
		if Hands_2 then
			Hands_2:Destroy()
		end
		local Arrow = arg2:FindFirstChild("Arrow")
		if Arrow then
			for _, v_14 in Arrow:GetDescendants() do
				if v_14:IsA("Beam") or v_14:IsA("ParticleEmitter") or v_14:IsA("SpotLight") or v_14:IsA("PointLight") then
					v_14.Enabled = false
				end
			end
			local Ground = Arrow.Ground
			Ground.Parent = HumanoidRootPart_5
			Debris_upvr:AddItem(Ground, 2)
		end
		
		local clone_4 = Utils_upvr.Heian.FlameArrow.Shot:Clone()
		clone_4.CFrame = HumanoidRootPart_5.CFrame
		Debris_upvr:AddItem(clone_4, 2)
		clone_4.Parent = workspace.Effects
		for i_15, v_15 in clone_4.Attachment:GetChildren() do
			v_15:Emit(v_15:GetAttribute("EmitCount"))
		end
	end;
	
	Interp = function(arg1_7) -- Line 129
		local TweenService_upvr = game:GetService("TweenService")
		local Debris_upvr = game:GetService("Debris")
		local Utils_upvr = script.Utils
		
		local CFrame_upvw = arg1_7.CFrame
		local tick_result1_upvw = tick()
		local var134_upvw
		local any_Connect_result1_upvr = arg1_7:GetPropertyChangedSignal("Position"):Connect(function() -- Line 131
                --[[ Upvalues[3]:
                    [1]: CFrame_upvw (read and write)
                    [2]: arg1_7 (readonly)
                    [3]: tick_result1_upvw (read and write)
                ]]
			CFrame_upvw = arg1_7.CFrame
			tick_result1_upvw = tick()
		end)

	end;
	Burn = function(arg1_8) -- Line 142
		local TweenService_upvr = game:GetService("TweenService")
		local Debris_upvr = game:GetService("Debris")
		local Utils_upvr = script.Utils
		
		
		local clone_3 = Utils_upvr.Heian.FlameArrow.explode:Clone()
		clone_3.Startup.Position = arg1_8
		clone_3.boom.Position = arg1_8
		clone_3.Parent = workspace.Effects
		Debris_upvr:AddItem(clone_3, 4)
		for _, v_upvr in clone_3.Startup:GetDescendants() do
			if v_upvr:IsA("ParticleEmitter") then
				v_upvr:Emit(v_upvr:GetAttribute("EmitCount"))
				v_upvr.Enabled = true
				task.delay(v_upvr:GetAttribute("EmitDuration"), function() -- Line 151
                        --[[ Upvalues[1]:
                            [1]: v_upvr (readonly)
                        ]]
					v_upvr.Enabled = false
				end)
			end
		end
		--var4_upvw:PlaySound(Sounds_upvr.Heian.FireArrow.Shockwave, clone_3.Startup, game.SoundService.Effect)
		task.wait(0.4)
		for _, v_2_upvr in clone_3.boom.Attachment:GetDescendants() do
			if v_2_upvr:IsA("ParticleEmitter") then
				v_2_upvr.Enabled = true
				task.delay(0.5, function() -- Line 157
                        --[[ Upvalues[1]:
                            [1]: v_2_upvr (readonly)
                        ]]
					v_2_upvr.Enabled = false
				end)
			end
		end
		local clone_6 = Utils_upvr.Megumi.Mahoraga.WorldSlash.mesh:Clone()
		clone_6.Position = arg1_8
		clone_6.Decal.Transparency = 0
		clone_6.Mesh.Scale = Vector3.new(2, 50, 2)
		clone_6.Parent = clone_3
		TweenService_upvr:Create(clone_6, TweenInfo.new(1, Enum.EasingStyle.Exponential), {
			Size = Vector3.new(80, 40, 80);
			CFrame = clone_6.CFrame * CFrame.Angles(0, -3.12413936106985, 0);
		}):Play()
		TweenService_upvr:Create(clone_6.Mesh, TweenInfo.new(1, Enum.EasingStyle.Exponential), {
			Scale = Vector3.new(60, 10, 60);
		}):Play()
		TweenService_upvr:Create(clone_6.Decal, TweenInfo.new(1, Enum.EasingStyle.Exponential), {
			Transparency = 1;
		}):Play()
		Debris_upvr:AddItem(clone_6, 1)
		local clone_5 = Utils_upvr.Itadori.FireArrow.Burn:Clone()
		clone_5.Parent = clone_3
		clone_5.Position = arg1_8
		clone_5.Center.Wind2:Emit(25)
		clone_5.Flames:Emit(200)
		TweenService_upvr:Create(clone_5, TweenInfo.new(0.75), {
			Size = Vector3.new(0, 250, 0);
			CFrame = clone_5.CFrame * CFrame.Angles(0, math.pi, 0);
		}):Play()
		TweenService_upvr:Create(clone_5.Beam, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
			Width0 = 0;
			Width1 = 0;
		}):Play()
		TweenService_upvr:Create(clone_5.Lines, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
			Width0 = 0;
			Width1 = 0;
		}):Play()
		--var4_upvw:PlaySound(Sounds_upvr.Heian.FireArrow.Explode, clone_5, game.SoundService.Effect)
	end;
	
	Strike = function(arg1_3) -- Line 38
		local Utils_upvr = script.Utils
		local TweenService_upvr = game:GetService("TweenService")
		local Debris_upvr = game:GetService("Debris")
		local LightningBeams_upvr = require(script.Stuff.LightningBeams)
		
		local clone_3 = Utils_upvr.Mahito.WideSPStrike.HitArea:Clone()
		clone_3.Size = Vector3.new(19, 0, 19)
		clone_3.Overlay.Color3 = Color3.new(1, 0, 0)
		clone_3.Prog.Overlay.Color3 = Color3.new(1, 0, 0)
		clone_3.Afterimages.Enabled = false
		clone_3.groundwaveing.Spin.Enabled = false
		clone_3.Position = arg1_3
		clone_3.Prog.Position = arg1_3
		clone_3.Prog.Overlay.Transparency = 1
		clone_3.Parent = workspace.Effects
		TweenService_upvr:Create(clone_3.Prog.Overlay, TweenInfo.new(0.4), {
			Transparency = 0.8;
		}):Play()
		TweenService_upvr:Create(clone_3.Prog, TweenInfo.new(0.7, Enum.EasingStyle.Linear), {
			Size = clone_3.Size;
		}):Play()
		Debris_upvr:AddItem(clone_3, 3)
		task.wait(0.7)
		clone_3.Prog:Destroy()
		local clone_2_upvr = Utils_upvr.Heian.Lightning:Clone()
		clone_2_upvr.Position = arg1_3
		clone_2_upvr.Parent = workspace.Effects
		Debris_upvr:AddItem(clone_2_upvr, 2)
		clone_2_upvr.Attachment.Dust:Emit(25)
		clone_2_upvr.Attachment.Ring:Emit(25)
		clone_2_upvr.Attachment.Wind2:Emit(6)
		local any_new_result1_upvr = LightningBeams_upvr.new(clone_2_upvr.Air, clone_2_upvr.Attachment, 30)
		any_new_result1_upvr.PulseSpeed = 1000
		any_new_result1_upvr.FadeLength = 0.25
		any_new_result1_upvr.MaxRadius = 20
		any_new_result1_upvr.MinRadius = 0
		any_new_result1_upvr.AnimationSpeed = 300
		any_new_result1_upvr.MinThicknessMultiplier = 2
		any_new_result1_upvr.MaxThicknessMultiplier = 10
		any_new_result1_upvr.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 170, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 127))})
		task.delay(0.05, function() -- Line 68
			local workspace_Raycast_result1 = workspace:Raycast(arg1_3, Vector3.new(0, -20, 0), _G.MapParams)
			if workspace_Raycast_result1 then
				clone_2_upvr.Attachment.WorldPosition = workspace_Raycast_result1.Position
			end
			task.wait(0.1)
			any_new_result1_upvr:Destroy()
			clone_2_upvr.Attachment.Burn:Emit(1)
			clone_2_upvr.Sparks.Enabled = false
			TweenService_upvr:Create(clone_2_upvr.PointLight, TweenInfo.new(0.5), {
				Brightness = 0;
			}):Play()
		end)
		--[[var4_upvw:PlaySound(Sounds_upvr.Heian.Kamutoke.Fire[tostring(math.random(1, 4))], clone_2_upvr, game.SoundService.Effect)
		if (workspace.CurrentCamera.CFrame.Position - arg1_3).Magnitude < 40 then
			CameraShaker_upvr.CurrentShaker:Shake(CameraShaker_upvr.Presets.Snap)
		else
			if (workspace.CurrentCamera.CFrame.Position - arg1_3).Magnitude < 100 then
				CameraShaker_upvr.CurrentShaker:Shake(CameraShaker_upvr.Presets.HeavyHit)
				return
			end
			if (workspace.CurrentCamera.CFrame.Position - arg1_3).Magnitude < 200 then
				CameraShaker_upvr.CurrentShaker:Shake(CameraShaker_upvr.Presets.LightHit)
			end
		end]]
	end;

	Moonbow = function(Params)
		local Stage = Params.Stage

		if Stage == 'Bows' then
			local LandPositions = Params.LandPositions
			local Offsets = {
				[1] = CFrame.new(7, 250, -12.5);
				[2] = CFrame.new(-7, 250, -12.5);
				[3] = CFrame.new(0, 250, -12.5);
				[4] = CFrame.new(0, 250, -12.5);

				[5] = CFrame.new(7, 500, -25);
				[6] = CFrame.new(-7, 500, -25);
			}

			for i, Coordinates: CFrame in LandPositions do
				task.spawn(function()
					local MovingPart = script.Kokushibo.Moonbow.Bow:Clone()
					MovingPart.Parent = workspace.Thrown
					MovingPart.CFrame = Params.StartCF
					Debris:AddItem(MovingPart, .25 * i)
					require(RS_Modules.BezierCurve).Play(MovingPart, { Params.StartCF.Position; (MovingPart.CFrame * Offsets[i]).Position; Coordinates.Position; }, false, { Duration = .25 * i; EasingStyle = Enum.EasingStyle.Quad; EasingDirection = Enum.EasingDirection.In; LookAt = true })

					task.delay(.25 * i, function()
						shared.repfire('rockCircle', { CF = Coordinates; Radius = 7; Parts = 8; Reverse = false; flyRocks = true; })
						shared.repfire('ShakeCamera', { Magnitude = 5; Roughness = 50; FadeInTime = 0; FadeOutTime = .25 })
					end)
				end)
			end
		end
	end,

	['Red'] = function(Params)
		local Stage = Params.Stage
		local Character: Model = Params.Char
		local HumRP = Character.HumanoidRootPart
		local Torso = Character.Torso
		local leftarm = Character["Left Arm"]
		local rightarm = Character["Right Arm"]

		if Stage == 'Orb' then

			local vfx = script["Strongest of Today"].Red.Orb.Attachment:Clone()
			vfx.Parent = leftarm
			vfx.CFrame = CFrame.new(0,-1.6,0)
			for i,v in pairs(vfx:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v:Emit(v:GetAttribute("EmitCount"))
				end
			end
			game.Debris:AddItem(vfx,1.4)

		end

		if Stage == 'Explosion' then

			local vfx1 = script["Strongest of Today"].Red.Explosion:Clone()
			vfx1.Parent = workspace.Effects
			vfx1.CFrame = HumRP.CFrame * CFrame.new(0,0,0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
			ParticlesModule.Enabled(vfx1.Attachment, true)
			Debris:AddItem(vfx1, 5) 

			local vfx2 = script["Strongest of Today"].Red.Impact:Clone()
			vfx2.Parent = workspace.Effects
			vfx2.CFrame = HumRP.CFrame * CFrame.new(0,0,0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
			ParticlesModule.Enabled(vfx2.Impact, true)
			Debris:AddItem(vfx2, 5) 

			local vfx4 = script["Strongest of Today"].Red.Xplosion:Clone()
			vfx4.Parent = workspace.Effects
			vfx4.CFrame = HumRP.CFrame * CFrame.new(0,0,0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
			ParticlesModule.Enabled(vfx4.Dust, true)
			Debris:AddItem(vfx4, 5) 

			task.wait(.2)

			ParticlesModule.Enabled(vfx1.Attachment, false)
			ParticlesModule.Enabled(vfx4.Dust, false)
			ParticlesModule.Enabled(vfx2.Impact, false)

			local vfx3 = script["Strongest of Today"].Red.electricslam:Clone()
			vfx3.Parent = workspace.Effects
			vfx3.CFrame = HumRP.CFrame * CFrame.new(0,0,0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
			ParticlesModule.Emit(vfx3.Attachment)
			Debris:AddItem(vfx3, 5) 

		end

	end,

	['Palm Strike'] = function(Params)
		local Stage = Params.Stage
		local Character: Model = Params.Char
		local EnemyCharacter: Model = Params.EnemyCharacter;
		local HumRP = Character.HumanoidRootPart
		local EnemyTorso : BasePart
		local leftarm : BasePart
		local rightarm : BasePart
		local rightleg : BasePart

		if EnemyCharacter then
			EnemyTorso = EnemyCharacter.Torso
			leftarm = Character["Left Arm"]
			rightarm = Character["Right Arm"]
			rightleg = Character["Right Leg"]
		end

		if Stage == 'Hit' then

			local vfx = script["Strongest of Today"]["Palm Strike"].Holder.Atch:Clone()
			vfx.Parent = EnemyTorso
			for i,v in pairs(vfx:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v:Emit(v:GetAttribute("EmitCount"))
				end
			end
			game.Debris:AddItem(vfx,2.4)

		elseif Stage == 'Trail' then
			local Trail = script["Strongest of Today"]["Palm Strike"].Trail.down:Clone()
			Trail.Parent = rightleg
			game.Debris:AddItem(Trail,2)

		end
	end,

	['Blue'] = function(Params)
		local Stage = Params.Stage
		local Character: Model = Params.Char
		local HumRP, Torso, leftarm, rightarm
		if Character then
			HumRP = Character.HumanoidRootPart
			Torso = Character.Torso
			leftarm = Character["Left Arm"]
			rightarm = Character["Right Arm"]
		end

		if Stage == 'Orb' then

			local vfx = script["Strongest of Today"]["Lapse Blue"].BlueArm.VfxChargeBlue:Clone()
			vfx.Parent = rightarm
			vfx.CFrame = CFrame.new(0,-1.4,0)
			for i,v in pairs(vfx:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v:Emit(v:GetAttribute("EmitCount"))
				end
			end
			game.Debris:AddItem(vfx,1.4)

		elseif Stage == 'fx' then


			local vfx1 = script["Strongest of Today"]['Lapse Blue'].Linesbring2:Clone()
			vfx1.Parent = workspace.Effects
			vfx1.CFrame = HumRP.CFrame * CFrame.Angles(0, rad(180), 0)
			ParticlesModule.Emit(vfx1)
			Debris:AddItem(vfx1, 5) 

			local vfx2 = script["Strongest of Today"]["Lapse Blue"].Linesbring:Clone()
			vfx2.Parent = workspace.Effects
			vfx2.CFrame = HumRP.CFrame * CFrame.new(0,0,-15)
			ParticlesModule.Emit(vfx2)
			Debris:AddItem(vfx2, 5) 

			local vfx2 = script["Strongest of Today"]["Lapse Blue"].Linesbring:Clone()
			vfx2.Parent = workspace.Effects
			vfx2.CFrame = HumRP.CFrame * CFrame.new(0,0,-30)
			ParticlesModule.Emit(vfx2)
			Debris:AddItem(vfx2, 5) 

			local vfx2 = script["Strongest of Today"]["Lapse Blue"].Linesbring:Clone()
			vfx2.Parent = workspace.Effects
			vfx2.CFrame = HumRP.CFrame * CFrame.new(0,0,-3)
			ParticlesModule.Emit(vfx2)
			Debris:AddItem(vfx2, 5) 

			local vfx3 = script["Strongest of Today"]["Lapse Blue"].DustThing:Clone()
			vfx3.Parent = workspace.Effects
			vfx3.CFrame = HumRP.CFrame * CFrame.new(0,0,-3)
			ParticlesModule.Emit(vfx3)
			Debris:AddItem(vfx3, 5) 

		elseif Stage == 'hit' then

			local vfx1 = script["Strongest of Today"]["Lapse Blue"].Hit.VfxEmit:Clone()
			vfx1.Parent = Torso
			ParticlesModule.Emit(vfx1)
			Debris:AddItem(vfx1, 5) 

		elseif Stage == 'ArmBurst' then

			local handvfx = script["Strongest of Today"]["Lapse Blue"]["Arm Burst"]:Clone()
			handvfx.Parent = Character
			handvfx.Weld.Part0 = rightarm
			ParticlesModule.Emit(handvfx)
			Debris:AddItem(handvfx, 7)

		elseif Stage == 'Smoke' then

			local smokevfx = script["Strongest of Today"]["Lapse Blue"].smoke3:Clone()
			smokevfx.Parent = workspace.Thrown
			smokevfx.Position = Params.Pos
			ParticlesModule.Emit(smokevfx)
			Debris:AddItem(smokevfx, 10)

		end
	end,

	['Vortex Leap'] = function(Params)

		local Stage = Params.Stage
		local Character: Model = Params.Char
		local HumRP: BasePart = Character.HumanoidRootPart
		local Torso = Character.Torso
		local leftarm = Character["Left Arm"]
		local rightarm = Character["Right Arm"]
		local head = Character["Head"]
		local leftleg = Character["Left Leg"]
		local rightleg = Character["Right Leg"]


		if Stage == 'final' then

			local vfx = script["Strongest of Today"]["Vortex Leap"].BlastShort:Clone()
			vfx.Parent = workspace.Debris
			vfx.CFrame = HumRP.CFrame * CFrame.new(0,0,0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

			ParticlesModule.Emit(vfx.Dust)
			ParticlesModule.Emit(vfx.Dust2)
			ParticlesModule.Emit(vfx.Dust3)
			--ParticlesModule.Emit(vfx.Lightning)
			ParticlesModule.Emit(vfx.Lines)
			ParticlesModule.Emit(vfx.Lines1)
			ParticlesModule.Emit(vfx.MAIN)
			ParticlesModule.Emit(vfx.Sparks)
			ParticlesModule.Emit(vfx.Stars)
			ParticlesModule.Emit(vfx.Stars2)

			game.Debris:AddItem(vfx,5)

			local vfx2 = script["Strongest of Today"]["Vortex Leap"].PushExplode:Clone()
			vfx2.Parent = workspace.Debris
			vfx2.CFrame = HumRP.CFrame * CFrame.new(0,0,0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

			ParticlesModule.Emit(vfx2.Attachment)

			game.Debris:AddItem(vfx2,5)

			local vfx3 = script["Strongest of Today"]["Vortex Leap"].Final:Clone()
			vfx3.Parent = workspace.Debris
			vfx3.CFrame = HumRP.CFrame * CFrame.new(0,0,0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

			ParticlesModule.Emit(vfx3.Attachment)

			game.Debris:AddItem(vfx3,5)


		end

		if Stage == 'hit' then
			local WalkVel = Instance.new("BodyVelocity")
			WalkVel.Name = "WalkVel"
			WalkVel.MaxForce = Vector3.new(1, 1, 1) * 100000
			WalkVel.Parent = HumRP

			task.spawn(function()
				while task.wait() and WalkVel.Parent do
					local lookVector = HumRP.CFrame.LookVector

					WalkVel.Velocity = Vector3.new(lookVector.X * 10, 2, lookVector.Z * 10)
				end
			end)

			Debris:AddItem(WalkVel, 2.4)

			local vfxgood = script["Strongest of Today"]["Vortex Leap"].Start:Clone()
			vfxgood.Parent = workspace.Debris
			vfxgood.CFrame = HumRP.CFrame * CFrame.new(0,0,0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

			ParticlesModule.Emit(vfxgood.Attachment)

			game.Debris:AddItem(vfxgood,5)

			--[[ local vfxnah = script["Strongest of Today"]["Vortex Leap"].Punch:Clone()
			vfxnah.Parent = workspace.Effects
			vfxnah.CFrame = HumRP.CFrame * CFrame.new(0,0,0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

			ParticlesModule.Emit(vfxnah.Attachment1)
			ParticlesModule.Emit(vfxnah.Attachment2)
			ParticlesModule.Emit(vfxnah.Attachment3)
			ParticlesModule.Emit(vfxnah.Attachment4)

			game.Debris:AddItem(vfxnah,10)
			
			--]]


			local EyeHead = script["Strongest of Today"]["Vortex Leap"].ForceOrb:Clone()
			EyeHead.Parent = workspace.Effects

			local weldEye = Instance.new('Weld', EyeHead)
			weldEye.Part0 = EyeHead
			weldEye.Part1 = rightarm
			weldEye.C0 = CFrame.new(0,1.5,0)
			weldEye.C1 = CFrame.new(0,0,0)
			Debris:AddItem(EyeHead, 2.4)

			local RightEffect = script["Strongest of Today"]["Vortex Leap"].HandTrail:Clone()
			RightEffect.Parent = workspace.Effects

			local weldEye = Instance.new('Weld', RightEffect)
			weldEye.Part0 = RightEffect
			weldEye.Part1 = rightarm
			weldEye.C0 = CFrame.new(0,0,0)
			weldEye.C1 = CFrame.new(0,0,0)
			Debris:AddItem(RightEffect, 2.4)
		end

		if Stage == 'hit2' then


			local EyeHead = script["Strongest of Today"]["Vortex Leap"].AuraENEMY.Head:Clone()
			EyeHead.Parent = workspace.Effects

			local weldEye = Instance.new('Weld', EyeHead)
			weldEye.Part0 = EyeHead
			weldEye.Part1 = head
			weldEye.C0 = CFrame.new(0,0,0)
			weldEye.C1 = CFrame.new(0,0,0)
			Debris:AddItem(EyeHead, 2.4)

			local EyeHead = script["Strongest of Today"]["Vortex Leap"].AuraENEMY["Left Arm"]:Clone()
			EyeHead.Parent = workspace.Effects

			local weldEye = Instance.new('Weld', EyeHead)
			weldEye.Part0 = EyeHead
			weldEye.Part1 = leftarm
			weldEye.C0 = CFrame.new(0,0,0)
			weldEye.C1 = CFrame.new(0,0,0)
			Debris:AddItem(EyeHead, 2.4)

			local EyeHead = script["Strongest of Today"]["Vortex Leap"].AuraENEMY["Left Leg"]:Clone()
			EyeHead.Parent = workspace.Effects

			local weldEye = Instance.new('Weld', EyeHead)
			weldEye.Part0 = EyeHead
			weldEye.Part1 = leftleg
			weldEye.C0 = CFrame.new(0,0,0)
			weldEye.C1 = CFrame.new(0,0,0)
			Debris:AddItem(EyeHead, 2.4)

			local EyeHead = script["Strongest of Today"]["Vortex Leap"].AuraENEMY["Right Arm"]:Clone()
			EyeHead.Parent = workspace.Effects

			local weldEye = Instance.new('Weld', EyeHead)
			weldEye.Part0 = EyeHead
			weldEye.Part1 = rightarm
			weldEye.C0 = CFrame.new(0,0,0)
			weldEye.C1 = CFrame.new(0,0,0)
			Debris:AddItem(EyeHead, 2.4)

			local EyeHead = script["Strongest of Today"]["Vortex Leap"].AuraENEMY["Right Leg"]:Clone()
			EyeHead.Parent = workspace.Effects

			local weldEye = Instance.new('Weld', EyeHead)
			weldEye.Part0 = EyeHead
			weldEye.Part1 = rightleg
			weldEye.C0 = CFrame.new(0,0,0)
			weldEye.C1 = CFrame.new(0,0,0)
			Debris:AddItem(EyeHead, 2.4)
		end
	end,

	['BerserkVFX'] = function(Params)
		local Character: Model = Params.Char
		local Stage = Params.Stage
		local HumRP, Torso, leftarm, rightarm, head
		if Character then
			HumRP = Character.HumanoidRootPart
			Torso = Character.Torso
			head = Character.Head
			leftarm = Character["Left Arm"]
			rightarm = Character["Right Arm"]
		end

		if Stage == 'MarksFace' then

			local vfx = script["Disgraced One"].Berserk.MarksFace.Effects.Marks.Attachment:Clone()
			vfx.Parent = head
			vfx.CFrame =  CFrame.new(0, 0, 0)
			for i,v in pairs(vfx:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v:Emit(v:GetAttribute("EmitCount"))
				end
			end

			game.Debris:AddItem(vfx,1.5)

		elseif Stage == 'Marks' then

			local vfx3 = script["Disgraced One"].Berserk.Marks:Clone()
			vfx3.Parent = workspace.Effects
			vfx3.CFrame = head.CFrame * CFrame.new(0,0,0)
			ParticlesModule.Emit(vfx3)
			Debris:AddItem(vfx3, 5) 


		elseif Stage == 'StartUp' then

			local vfx3 = script["Disgraced One"].Berserk.Wind:Clone()
			vfx3.Parent = workspace.Effects
			vfx3.CFrame = HumRP.CFrame * CFrame.new(0,-2,0)
			ParticlesModule.Emit(vfx3)
			Debris:AddItem(vfx3, 5) 

		elseif Stage == 'RunCamera' then
			local l_TweenService_1 = game:GetService("TweenService");

			task.spawn(function()
				local l_Camera_1 = workspace.Camera;
				l_TweenService_1:Create(l_Camera_1, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					FieldOfView = 85
				}):Play();
				task.wait(1.03);
				l_TweenService_1:Create(l_Camera_1, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
					FieldOfView = 70
				}):Play();
			end);


		elseif Stage == 'Teleportation' then

			local vfx3 = script["Disgraced One"].Berserk.TP:Clone()
			vfx3.Parent = workspace.Effects
			vfx3.CFrame = HumRP.CFrame * CFrame.new(0,0,0)
			ParticlesModule.Emit(vfx3)
			Debris:AddItem(vfx3, 5) 

		elseif Stage == 'Run' then

			local vfx = script["Disgraced One"].Berserk.RunStartUp.Attachment:Clone()
			vfx.Parent = HumRP
			vfx.CFrame =  CFrame.new(0, 0, -4) * CFrame.Angles(math.rad(-90), math.rad(0), 0)
			for i,v in pairs(vfx:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v:Emit(v:GetAttribute("EmitCount"))
				end
			end

			game.Debris:AddItem(vfx,1.1)

		elseif Stage == 'RunFinish' then

			local vfx3 = script["Disgraced One"].Berserk.RunStartUp:Clone()
			vfx3.Parent = workspace.Effects
			vfx3.CFrame = HumRP.CFrame * CFrame.new(0, 0, -4) * CFrame.Angles(math.rad(-90), math.rad(0), 0)
			ParticlesModule.Emit(vfx3)
			Debris:AddItem(vfx3, 5) 
		end
	end,

	['Spiral'] = function(Params)
		local Character: Model = Params.Char
		local Stage = Params.Stage
		local HumRP, Torso, leftarm, rightarm, head
		if Character then
			HumRP = Character.HumanoidRootPart
			Torso = Character.Torso
			head = Character.Head
			leftarm = Character["Left Arm"]
			rightarm = Character["Right Arm"]
		end

		if Stage == '1' then

			local vfx = script["Disgraced One"].Spiral.one.Attachment:Clone()
			vfx.Parent = HumRP
			vfx.CFrame =  CFrame.new(0, 0, 0)
			for i,v in pairs(vfx:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v:Emit(v:GetAttribute("EmitCount"))
				end
			end

			game.Debris:AddItem(vfx, 1.77)

		elseif Stage == '2' then

			local vfx = script["Disgraced One"].Spiral.two.Attachment:Clone()
			vfx.Parent = HumRP
			vfx.CFrame =  CFrame.new(0, 0, 0)
			for i,v in pairs(vfx:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v:Emit(v:GetAttribute("EmitCount"))
				end
			end

			game.Debris:AddItem(vfx, 1.27)

		elseif Stage == '3' then

			local vfx = script["Disgraced One"].Spiral.three.Attachment:Clone()
			vfx.Parent = HumRP
			vfx.CFrame =  CFrame.new(0, 0, 0)
			for i,v in pairs(vfx:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v:Emit(v:GetAttribute("EmitCount"))
				end
			end

			game.Debris:AddItem(vfx, 0.77)

		elseif Stage == '4' then

			local vfx = script["Disgraced One"].Spiral.four.Attachment:Clone()
			vfx.Parent = HumRP
			vfx.CFrame =  CFrame.new(0, 0, 0)
			for i,v in pairs(vfx:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v:Emit(v:GetAttribute("EmitCount"))
				end
			end

			game.Debris:AddItem(vfx, 0.27)

		elseif Stage == 'Marks' then

			local vfx3 = script["Disgraced One"].Spiral.marks:Clone()
			vfx3.Parent = workspace.Effects
			vfx3.CFrame = Torso.CFrame * CFrame.new(0,0,0)
			ParticlesModule.Emit(vfx3)
			Debris:AddItem(vfx3, 5) 


		end
	end,


	['FaceGrab'] = function(Params)
		local Character: Model = Params.Char
		local Stage = Params.Stage
		local HumRP, Torso, leftarm, rightarm, head
		if Character then
			HumRP = Character.HumanoidRootPart
			Torso = Character.Torso
			head = Character.Head
			leftarm = Character["Left Arm"]
			rightarm = Character["Right Arm"]
		end

		if Stage == 'Impact' then

			local vfx3 = script["Disgraced One"].FaceGrab.Push:Clone()
			vfx3.Parent = workspace.Effects
			vfx3.CFrame = leftarm.CFrame * CFrame.new(0,0,0)
			ParticlesModule.Emit(vfx3)
			Debris:AddItem(vfx3, 5) 

		elseif Stage == 'Impact2' then

			local vfx3 = script["Disgraced One"].FaceGrab.Push:Clone()
			vfx3.Parent = workspace.Effects
			vfx3.CFrame = rightarm.CFrame * CFrame.new(0,0,0)
			ParticlesModule.Emit(vfx3)
			Debris:AddItem(vfx3, 5) 

		elseif Stage == 'Camera' then
			local l_TweenService_1 = game:GetService("TweenService");

			local l_Camera_1 = workspace.Camera;
			l_TweenService_1:Create(l_Camera_1, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
				FieldOfView = 98
			}):Play();
			task.wait(0.2);
			l_TweenService_1:Create(l_Camera_1, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				FieldOfView = 70
			}):Play();

		elseif Stage == 'Dismantle' then

			local vfx3 = script["Disgraced One"].FaceGrab.Dismantle:Clone()
			vfx3.Parent = workspace.Effects
			vfx3.CFrame = Torso.CFrame * CFrame.new(0,0,0)
			ParticlesModule.Emit(vfx3)
			Debris:AddItem(vfx3, 5) 


		elseif Stage == 'Marks' then

			local vfx3 = script["Disgraced One"].FaceGrab.Marks:Clone()
			vfx3.Parent = workspace.Effects
			vfx3.CFrame = head.CFrame * CFrame.new(0,0,0)
			ParticlesModule.Emit(vfx3)
			Debris:AddItem(vfx3, 5) 

		elseif Stage == 'MarksFace' then

			local vfx = script["Disgraced One"].FaceGrab.MarksFace.Effects.Marks.Attachment:Clone()
			vfx.Parent = head
			vfx.CFrame =  CFrame.new(0, 0, 0)
			for i,v in pairs(vfx:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v:Emit(v:GetAttribute("EmitCount"))
				end
			end

			game.Debris:AddItem(vfx,0.95)

		end
	end,

	['Brutality'] = function(Params)
		local Character: Model = Params.Char
		local Stage = Params.Stage
		local HumRP, Torso, leftarm, rightarm, head
		if Character then
			HumRP = Character.HumanoidRootPart
			Torso = Character.Torso
			head = Character.Head
			leftarm = Character["Left Arm"]
			rightarm = Character["Right Arm"]
		end

		if Stage == 'Claw' then

			local vfx1 = script["Disgraced One"].Brutality.Claw1.Top:Clone()
			vfx1.Parent = workspace.Effects
			vfx1.CFrame = HumRP.CFrame * CFrame.new(0,-1,0)
			ParticlesModule.Emit(vfx1)
			Debris:AddItem(vfx1, 5) 

			local vfx2 = script["Disgraced One"].Brutality.Claw1.Middle:Clone()
			vfx2.Parent = workspace.Effects
			vfx2.CFrame = HumRP.CFrame * CFrame.new(0,0,0)
			ParticlesModule.Emit(vfx2)
			Debris:AddItem(vfx2, 5) 

			local vfx3 = script["Disgraced One"].Brutality.Claw1.Bottom:Clone()
			vfx3.Parent = workspace.Effects
			vfx3.CFrame = HumRP.CFrame * CFrame.new(0,1,0)
			ParticlesModule.Emit(vfx3)
			Debris:AddItem(vfx3, 5) 

			local vfx4 = script["Disgraced One"].Brutality.Claw1.Center:Clone()
			vfx4.Parent = workspace.Effects
			vfx4.CFrame = HumRP.CFrame * CFrame.new(0,0,0)
			ParticlesModule.Emit(vfx4)
			Debris:AddItem(vfx4, 5) 

		elseif Stage == 'Claws' then

			local vfx4 = script["Disgraced One"].Brutality.Claw2.Center:Clone()
			vfx4.Parent = workspace.Effects
			vfx4.CFrame = HumRP.CFrame * CFrame.new(2,0,0)
			ParticlesModule.Emit(vfx4)
			Debris:AddItem(vfx4, 5) 

			local vfx1 = script["Disgraced One"].Brutality.Claw2.Launch:Clone()
			vfx1.Parent = workspace.Effects
			vfx1.CFrame = HumRP.CFrame * CFrame.new(1,0,0)
			ParticlesModule.Emit(vfx1)
			Debris:AddItem(vfx1, 5) 

		end
	end,


	['Berserk'] = function(Params)
		local Character: Model = Params.Char
		local Stage = Params.Stage
		local HumRP, Torso, leftarm, rightarm, head
		if Character then
			HumRP = Character.HumanoidRootPart
			Torso = Character.Torso
			head = Character.Head
			leftarm = Character["Left Arm"]
			rightarm = Character["Right Arm"]
		end


		task.delay(0.2, function()

			for _,v in HumRP:GetChildren() do
				if v:IsA('BodyVelocity') then
					v:Destroy()
				end
			end

			local runVelocity = Instance.new("BodyVelocity")
			runVelocity.MaxForce = Vector3.new(1, 0, 1) * 300000

			local runMagnitude = Instance.new("NumberValue")
			runMagnitude.Value = 15
			runMagnitude.Parent = runVelocity

			local startTween = TS:Create(runMagnitude, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Value = 145
			})
			local endTween = TS:Create(runMagnitude, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Value = 36
			})

			startTween.Completed:Once(function()
				task.delay(0.05, function()
					endTween:Play()
				end)
			end)

			runVelocity.Parent = HumRP
			startTween:Play()
			Debris:AddItem(runVelocity, 1.3) 

			task.spawn(function()
				while task.wait() and runVelocity.Parent ~= nil do
					runVelocity.Velocity = HumRP.CFrame.LookVector * runMagnitude.Value
				end
			end)
		end)
	end,

	['FaceGrabRun'] = function(Params)
		local Character: Model = Params.Char
		local Stage = Params.Stage
		local HumRP, Torso, leftarm, rightarm, head
		if Character then
			HumRP = Character.HumanoidRootPart
			Torso = Character.Torso
			head = Character.Head
			leftarm = Character["Left Arm"]
			rightarm = Character["Right Arm"]
		end


		task.delay(0.2, function()

			for _,v in HumRP:GetChildren() do
				if v:IsA('BodyVelocity') then
					v:Destroy()
				end
			end

			local runVelocity = Instance.new("BodyVelocity")
			runVelocity.MaxForce = Vector3.new(1, 0, 1) * 300000

			local runMagnitude = Instance.new("NumberValue")
			runMagnitude.Value = 15
			runMagnitude.Parent = runVelocity

			local startTween = TS:Create(runMagnitude, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Value = 145
			})
			local endTween = TS:Create(runMagnitude, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Value = 36
			})

			startTween.Completed:Once(function()
				task.delay(0.05, function()
					endTween:Play()
				end)
			end)

			runVelocity.Parent = HumRP
			startTween:Play()
			Debris:AddItem(runVelocity, 0.95) 

			task.spawn(function()
				while task.wait() and runVelocity.Parent ~= nil do
					runVelocity.Velocity = HumRP.CFrame.LookVector * runMagnitude.Value
				end
			end)
		end)
	end,

	['BrutalityDash1'] = function(Params)
		local Character: Model = Params.Char
		local Stage = Params.Stage
		local HumRP, Torso, leftarm, rightarm, head
		if Character then
			HumRP = Character.HumanoidRootPart
			Torso = Character.Torso
			head = Character.Head
			leftarm = Character["Left Arm"]
			rightarm = Character["Right Arm"]
		end


		task.delay(0.2, function()

			for _,v in HumRP:GetChildren() do
				if v:IsA('BodyVelocity') then
					v:Destroy()
				end
			end

			local runVelocity = Instance.new("BodyVelocity")
			runVelocity.MaxForce = Vector3.new(1, 0, 1) * 50000

			local runMagnitude = Instance.new("NumberValue")
			runMagnitude.Value = 15
			runMagnitude.Parent = runVelocity

			local startTween = TS:Create(runMagnitude, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Value = 100
			})
			local endTween = TS:Create(runMagnitude, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Value = 12
			})

			startTween.Completed:Once(function()
				task.delay(0.05, function()
					endTween:Play()
				end)
			end)

			runVelocity.Parent = HumRP
			startTween:Play()
			Debris:AddItem(runVelocity, 0.05) 

			task.spawn(function()
				while task.wait() and runVelocity.Parent ~= nil do
					runVelocity.Velocity = HumRP.CFrame.LookVector * runMagnitude.Value
				end
			end)
		end)
	end,

	['FaceGrabRun2'] = function(Params)
		local Character: Model = Params.Char
		local Stage = Params.Stage
		local HumRP, Torso, leftarm, rightarm, head
		if Character then
			HumRP = Character.HumanoidRootPart
			Torso = Character.Torso
			head = Character.Head
			leftarm = Character["Left Arm"]
			rightarm = Character["Right Arm"]
		end


		task.delay(0.2, function()

			for _,v in HumRP:GetChildren() do
				if v:IsA('BodyVelocity') then
					v:Destroy()
				end
			end

			local runVelocity = Instance.new("BodyVelocity")
			runVelocity.MaxForce = Vector3.new(1, 0, 1) * 300000

			local runMagnitude = Instance.new("NumberValue")
			runMagnitude.Value = 15
			runMagnitude.Parent = runVelocity

			local startTween = TS:Create(runMagnitude, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Value = 145
			})
			local endTween = TS:Create(runMagnitude, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Value = 36
			})

			startTween.Completed:Once(function()
				task.delay(0.05, function()
					endTween:Play()
				end)
			end)

			runVelocity.Parent = HumRP
			startTween:Play()
			Debris:AddItem(runVelocity, 0.48) 

			task.spawn(function()
				while task.wait() and runVelocity.Parent ~= nil do
					runVelocity.Velocity = HumRP.CFrame.LookVector * runMagnitude.Value
				end
			end)
		end)
	end,

	['BerserkVFX2'] = function(Params)
		local Character: Model = Params.Char
		local Stage = Params.Stage
		local HumRP, Torso, leftarm, rightarm, head
		if Character then
			HumRP = Character.HumanoidRootPart
			Torso = Character.Torso
			head = Character.Head
			leftarm = Character["Left Arm"]
			rightarm = Character["Right Arm"]
		end

		if Stage == 'Teleportation' then

			local vfx3 = script["Disgraced One"].Berserk.TP:Clone()
			vfx3.Parent = workspace.Effects
			vfx3.CFrame = Torso.CFrame * CFrame.new(0,0,0)
			ParticlesModule.Emit(vfx3)
			Debris:AddItem(vfx3, 5) 
		end		
	end,

	['Debris Lines'] = function(v898)
		local v16248 = v898.Part and v898.Part.CFrame or v898.CFrame;
		local l_v16248_0 = v16248;
		local v16250 = {};
		local _ = {};
		local v16252 = {};
		l_v16248_0 = l_v16248_0 + l_v16248_0.lookVector * 1.793;
		local v16253 = v898.Seed or math.random(1, 2000000000);
		local v16254 = Random.new(v16253);
		local l_v89_3 = v89;
		local function v16258(v16256, v16257)
			return l_v89_3(v16256, v16257, nil, v16254);
		end;
		local l_Part_29 = Instance.new("Part");
		l_Part_29.Anchored = true;
		l_Part_29.Transparency = 1;
		l_Part_29.CanCollide = false;
		l_Part_29.CFrame = l_v16248_0;
		l_Part_29.Parent = workspace.Thrown;
		for _ = 1, 2 do
			v240({
				SoundId = "rbxassetid://7556019578", 
				Volume = 4, 
				Parent = l_Part_29, 
				RollOffMaxDistance = 455
			}):Play();
		end;
		v3:Create(l_Part_29, TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			CFrame = v16248 + l_v16248_0.lookVector * 75
		}):Play();
		game:GetService("Debris"):AddItem(l_Part_29, 6);
		local v16261 = 1;
		local v16262 = 20;
		local v16263 = v898.Times or 0;
		for v16264 = v16261, v16262 + v16263 do
			for v16265 = 1, 2 do
				local v16266 = v898.Spread or 2.25;
				if v16265 == 2 then
					v16266 = v16266 * -1;
				end;
				if v16265 == 1 and v16264 % 2 == 1 then
					local l_Attachment_14 = Instance.new("Attachment");
					l_Attachment_14.Parent = workspace.Terrain;
					l_Attachment_14.WorldCFrame = l_v16248_0 + l_v16248_0.lookVector * (v16264 * 3.6);
					l_Attachment_14.WorldCFrame = CFrame.new(l_Attachment_14.WorldCFrame.p, l_v16248_0.p);
					local v16268 = l_LegacyReplication_0.Push:Clone();
					v16268.Parent = l_Attachment_14;
					local v16269 = {};
					local v16270 = 5;
					if v898.SuperSerious then
						v16270 = 55;
					end;
					for _, v16272 in pairs(v16268.Size.Keypoints) do
						table.insert(v16269, NumberSequenceKeypoint.new(v16272.Time, v16272.Value * math.clamp(v16264 / 4, 0.35, v16270), v16272.Envelope));
					end;
					v16268.Size = NumberSequence.new(v16269);
					local l_v16268_0 = v16268 --[[ copy: 22 -> 68 ]];
					task.delay(0, function()
						l_v16268_0:Emit(v16258(2, 3, true));
					end);
				end;
				local v16274 = v230() or Instance.new("Part");
				table.insert(v16252, v16274);
				v16274.Name = "Debris";
				v16274.Anchored = true;
				v16274.CanCollide = true;
				v16274.Transparency = 1;
				local v16275 = 0.75;
				local v16276 = 1;
				local v16277 = v16254 or v82;
				if not v16276 and v16275 then
					v16276 = v16275;
					v16275 = 1;
				end;
				if not v16276 and not v16275 then
					v16275 = 0;
					v16276 = 1;
				end;
				local v16278 = v16277:NextNumber(v16275, v16276);
				v16276 = 0.75;
				v16277 = 1;
				local v16279 = v16254 or v82;
				if not v16277 and v16276 then
					v16277 = v16276;
					v16276 = 1;
				end;
				if not v16277 and not v16276 then
					v16276 = 0;
					v16277 = 1;
				end;
				local v16280 = Vector3.new(v16278, v16279:NextNumber(v16276, v16277), v16258(0.75, 1));
				v16276 = 2;
				v16277 = 3;
				v16279 = v16254 or v82;
				if not v16277 and v16276 then
					v16277 = v16276;
					v16276 = 1;
				end;
				if not v16277 and not v16276 then
					v16276 = 0;
					v16277 = 1;
				end;
				v16274.Size = v16280 * (v16264 / v16279:NextNumber(v16276, v16277));
				v16280 = 3.75;
				v16278 = 4.25;
				v16275 = v16254 or v82;
				if not v16278 and v16280 then
					v16278 = v16280;
					v16280 = 1;
				end;
				if not v16278 and not v16280 then
					v16280 = 0;
					v16278 = 1;
				end;
				local v16281 = v16275:NextNumber(v16280, v16278);
				if v898.SuperSerious then
					v16281 = v16281 * 3.5;
				end;
				v16274.CFrame = l_v16248_0 + l_v16248_0.lookVector * (v16264 * v16281);
				v16278 = 3;
				v16275 = 4;
				v16276 = v16254 or v82;
				if not v16275 and v16278 then
					v16275 = v16278;
					v16278 = 1;
				end;
				if not v16275 and not v16278 then
					v16278 = 0;
					v16275 = 1;
				end;
				v16280 = v16276:NextNumber(v16278, v16275);
				if v898.SuperSerious then
					v16274.Size = v16274.Size * 8;
					v16280 = 1;
				end;
				v16274.CFrame = v16274.CFrame * CFrame.new(v16266 * (v16264 / v16280), 0, 0);
				if v16265 == 1 then
					v16274:SetAttribute("Multi", 1);
				else
					v16274:SetAttribute("Multi", -1);
				end;
				v16278, v16275 = v556({
					orig = v16274.Position, 
					dir = Vector3.new(0, -12, 0, 0)
				});
				if not v16278 then
					v16274:Destroy();
				else
					v16276 = nil;
					if v898.Serious then
						v16277 = v230() or Instance.new("Part");
						v16279 = 1;
						if v16265 == 2 then
							v16279 = -1;
						end;
						table.insert(v16252, v16277);
						v16277.Name = "DebrisGg";
						v16277.Anchored = true;
						v16277.CanCollide = true;
						v16277.Transparency = 1;
						v16277.Size = Vector3.new(14.003999710083008, 8.59000015258789, 19.677000045776367, 0) * 0.85 * (v16264 / 20);
						local v16282 = 3.75;
						local v16283 = 4.25;
						local v16284 = v16254 or v82;
						if not v16283 and v16282 then
							v16283 = v16282;
							v16282 = 1;
						end;
						if not v16283 and not v16282 then
							v16282 = 0;
							v16283 = 1;
						end;
						local v16285 = v16284:NextNumber(v16282, v16283);
						if v898.SuperSerious then
							v16277.Size = v16277.Size * 8;
							v16285 = v16285 * 3.5;
						end;
						v16283 = 1;
						v16284 = 2;
						local v16286 = v16254 or v82;
						if not v16284 and v16283 then
							v16284 = v16283;
							v16283 = 1;
						end;
						if not v16284 and not v16283 then
							v16283 = 0;
							v16284 = 1;
						end;
						v16282 = v16286:NextNumber(v16283, v16284);
						if v898.SuperSerious then
							v16282 = 0.35;
						end;
						v16286 = CFrame.Angles;
						local v16287 = -12;
						local v16288 = 12;
						local v16289 = v16254 or v82;
						if not v16288 and v16287 then
							v16288 = v16287;
							v16287 = 1;
						end;
						if not v16288 and not v16287 then
							v16287 = 0;
							v16288 = 1;
						end;
						local v16290 = math.rad((v16289:NextNumber(v16287, v16288)));
						v16288 = -14;
						v16289 = 14;
						local v16291 = v16254 or v82;
						if not v16289 and v16288 then
							v16289 = v16288;
							v16288 = 1;
						end;
						if not v16289 and not v16288 then
							v16288 = 0;
							v16289 = 1;
						end;
						local v16292 = math.rad((v16291:NextNumber(v16288, v16289)));
						v16291 = 25;
						local v16293 = 75;
						local v16294 = v16254 or v82;
						if not v16293 and v16291 then
							v16293 = v16291;
							v16291 = 1;
						end;
						if not v16293 and not v16291 then
							v16291 = 0;
							v16293 = 1;
						end;
						v16277.CFrame = l_v16248_0 * v16286(v16290, v16292, (math.rad(v16279 * v16294:NextNumber(v16291, v16293)))) + l_v16248_0.lookVector * (v16264 * v16285);
						v16277.CFrame = v16277.CFrame * CFrame.new(v16266 * (v16264 / v16282), 0, 0);
						v16277.Material = v16278.Material;
						v16277.Color = v16278.Color;
						v16277.Position = Vector3.new(v16277.Position.X, v16275.Y - v16277.Size.Y / 3, v16277.Position.Z);
						v16283 = v16277.CFrame;
						v16277.CFrame = v16277.CFrame - Vector3.new(0, 5, 0, 0);
						v16277.Transparency = 0;
						v16277.Parent = workspace.Thrown;
						v3:Create(v16277, TweenInfo.new(0.125, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
							CFrame = v16283
						}):Play();
						v16284 = delay;
						v16290 = 6;
						v16292 = 7;
						v16287 = v16254 or v82;
						if not v16292 and v16290 then
							v16292 = v16290;
							v16290 = 1;
						end;
						if not v16292 and not v16290 then
							v16290 = 0;
							v16292 = 1;
						end;
						local l_v16277_0 = v16277 --[[ copy: 27 -> 67 ]];
						v16284(v16287:NextNumber(v16290, v16292), function()
							local v16296 = 1;
							v16296 = 5.5;
							local l_v3_30 = v3;
							local l_l_v16277_0_0 = l_v16277_0;
							local v16299 = TweenInfo.new(v16296, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
							local v16300 = {};
							local v16301 = l_v16277_0.CFrame - Vector3.new(0, l_v16277_0.Size.Y, 0);
							local l_Angles_40 = CFrame.Angles;
							local v16303 = -15;
							local v16304 = 15;
							local v16305 = v16254 or v82;
							if not v16304 and v16303 then
								v16304 = v16303;
								v16303 = 1;
							end;
							if not v16304 and not v16303 then
								v16303 = 0;
								v16304 = 1;
							end;
							local v16306 = math.rad((v16305:NextNumber(v16303, v16304)));
							v16304 = -15;
							local v16307 = 15;
							local v16308 = v16254 or v82;
							if not v16307 and v16304 then
								v16307 = v16304;
								v16304 = 1;
							end;
							if not v16307 and not v16304 then
								v16304 = 0;
								v16307 = 1;
							end;
							local v16309 = math.rad((v16308:NextNumber(v16304, v16307)));
							v16307 = -15;
							v16305 = 15;
							local v16310 = v16254 or v82;
							if not v16305 and v16307 then
								v16305 = v16307;
								v16307 = 1;
							end;
							if not v16305 and not v16307 then
								v16307 = 0;
								v16305 = 1;
							end;
							v16300.CFrame = v16301 * l_Angles_40(v16306, v16309, (math.rad((v16310:NextNumber(v16307, v16305)))));
							l_v3_30:Create(l_l_v16277_0_0, v16299, v16300):Play();
							delay(v16296, function()
								l_v16277_0:Destroy();
							end);
						end);
					end;
					if (not (v16265 ~= 1) or v898.Serious) and not v898.SuperSerious then
						for _ = 1, 1 do
							local v16312 = v230() or Instance.new("Part");
							v16312.Name = "Debris";
							table.insert(v16252, v16312);
							v16312.Anchored = false;
							v16312.CanCollide = false;
							v16312.Transparency = 0;
							local v16313 = 0.75;
							local v16314 = 1;
							local v16315 = v16254 or v82;
							if not v16314 and v16313 then
								v16314 = v16313;
								v16313 = 1;
							end;
							if not v16314 and not v16313 then
								v16313 = 0;
								v16314 = 1;
							end;
							local v16316 = v16315:NextNumber(v16313, v16314);
							v16314 = 0.75;
							v16315 = 1;
							local v16317 = v16254 or v82;
							if not v16315 and v16314 then
								v16315 = v16314;
								v16314 = 1;
							end;
							if not v16315 and not v16314 then
								v16314 = 0;
								v16315 = 1;
							end;
							local v16318 = Vector3.new(v16316, v16317:NextNumber(v16314, v16315), v16258(0.75, 1));
							v16314 = 5;
							v16315 = 7;
							v16317 = v16254 or v82;
							if not v16315 and v16314 then
								v16315 = v16314;
								v16314 = 1;
							end;
							if not v16315 and not v16314 then
								v16314 = 0;
								v16315 = 1;
							end;
							v16312.Size = v16318 * (v16264 / v16317:NextNumber(v16314, v16315));
							v16316 = l_v16248_0.lookVector;
							v16315 = 3.75;
							v16317 = 4.25;
							local v16319 = v16254 or v82;
							if not v16317 and v16315 then
								v16317 = v16315;
								v16315 = 1;
							end;
							if not v16317 and not v16315 then
								v16315 = 0;
								v16317 = 1;
							end;
							v16312.CFrame = l_v16248_0 + v16316 * (v16264 * v16319:NextNumber(v16315, v16317));
							v16312.Position = Vector3.new(v16312.Position.X, v16275.Y, v16312.Position.Z);
							v16276 = v16312.CFrame;
							local l_CFrame_86 = v16312.CFrame;
							v16316 = CFrame.new;
							v16314 = v16266;
							v16315 = -v16266;
							v16317 = v16314;
							v16319 = v16315;
							local v16321 = v16254 or v82;
							if not v16319 and v16317 then
								v16319 = v16317;
								v16317 = 1;
							end;
							if not v16319 and not v16317 then
								v16317 = 0;
								v16319 = 1;
							end;
							v16316 = v16316(v16321:NextNumber(v16317, v16319), 0, 0);
							v16313 = CFrame.Angles;
							v16317 = -360;
							v16319 = 360;
							v16321 = v16254 or v82;
							if not v16319 and v16317 then
								v16319 = v16317;
								v16317 = 1;
							end;
							if not v16319 and not v16317 then
								v16317 = 0;
								v16319 = 1;
							end;
							v16314 = math.rad((v16321:NextNumber(v16317, v16319)));
							v16319 = -360;
							v16321 = 360;
							local v16322 = v16254 or v82;
							if not v16321 and v16319 then
								v16321 = v16319;
								v16319 = 1;
							end;
							if not v16321 and not v16319 then
								v16319 = 0;
								v16321 = 1;
							end;
							v16315 = math.rad((v16322:NextNumber(v16319, v16321)));
							v16321 = -360;
							v16322 = 360;
							local v16323 = v16254 or v82;
							if not v16322 and v16321 then
								v16322 = v16321;
								v16321 = 1;
							end;
							if not v16322 and not v16321 then
								v16321 = 0;
								v16322 = 1;
							end;
							v16312.CFrame = l_CFrame_86 * (v16316 * v16313(v16314, v16315, (math.rad((v16323:NextNumber(v16321, v16322))))));
							v16274:SetAttribute("Original", v16276.p);
							v16312.CollisionGroup = "nocol";
							v16312.Color = v16278.Color;
							v16312.Material = v16278.Material;
							v16312.Parent = workspace.Thrown;
							table.insert(v16250, {
								v16312, 
								v16276
							});
							game:service("Debris"):AddItem(v16312, 10);
							l_CFrame_86 = Instance.new("BodyVelocity");
							v16318 = 1;
							if v898.Serious then
								v16318 = 3;
								if math.random(1, 3) == 1 then
									v16312.CanCollide = true;
									if v16264 < 15 then
										task.delay(0.85, function()
											while true do
												task.wait();
												if not (v16312.Parent and not v556({
													orig = v16312.Position, 
													dir = Vector3.new(0, -3, 0, 0)
													})) then
													break;
												end;
											end;
											if v556({
												orig = v16312.Position, 
												dir = Vector3.new(0, -3, 0, 0)
												}) then
												v240({
													SoundId = ({
														"rbxassetid://3848076724", 
														"rbxassetid://3848078820"
													})[math.random(1, 2)], 
													Volume = 2, 
													PlaybackSpeed = 1.3, 
													Parent = v16312, 
													RollOffMaxDistance = 455
												}):Play();
											end;
										end);
									end;
									task.delay(0.3, function()
										v240({
											SoundId = "rbxassetid://7556019578", 
											Volume = 4, 
											Parent = l_Part_29, 
											RollOffMaxDistance = 455
										}):Play();
									end);
									task.delay(5 + math.random(), function()
										v3:Create(v16312, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
											Transparency = 1
										}):Play();
									end);
								end;
							end;
							l_CFrame_86.MaxForce = Vector3.new(1, 1, 1, 0) * 40000;
							v16315 = -9;
							v16317 = 9;
							v16319 = v16254 or v82;
							if not v16317 and v16315 then
								v16317 = v16315;
								v16315 = 1;
							end;
							if not v16317 and not v16315 then
								v16315 = 0;
								v16317 = 1;
							end;
							v16313 = v16319:NextNumber(v16315, v16317) * v16318;
							v16317 = 10;
							v16319 = 55;
							v16321 = v16254 or v82;
							if not v16319 and v16317 then
								v16319 = v16317;
								v16317 = 1;
							end;
							if not v16319 and not v16317 then
								v16317 = 0;
								v16319 = 1;
							end;
							v16314 = v16321:NextNumber(v16317, v16319) * v16318;
							v16319 = -9;
							v16321 = 9;
							v16322 = v16254 or v82;
							if not v16321 and v16319 then
								v16321 = v16319;
								v16319 = 1;
							end;
							if not v16321 and not v16319 then
								v16319 = 0;
								v16321 = 1;
							end;
							l_CFrame_86.Velocity = Vector3.new(v16313, v16314, v16322:NextNumber(v16319, v16321) * v16318);
							l_CFrame_86.Parent = v16312;
							game:service("Debris"):AddItem(l_CFrame_86, 0.15);
						end;
					end;
					v16274.Material = v16278.Material;
					v16274.Color = v16278.Color;
					v16274.Position = Vector3.new(v16274.Position.X, v16275.Y, v16274.Position.Z);
					v16277 = v16274.CFrame;
					v16279 = CFrame.Angles;
					local v16324 = -360;
					local v16325 = 360;
					local v16326 = v16254 or v82;
					if not v16325 and v16324 then
						v16325 = v16324;
						v16324 = 1;
					end;
					if not v16325 and not v16324 then
						v16324 = 0;
						v16325 = 1;
					end;
					local v16327 = math.rad((v16326:NextNumber(v16324, v16325)));
					v16325 = -360;
					v16326 = 360;
					local v16328 = v16254 or v82;
					if not v16326 and v16325 then
						v16326 = v16325;
						v16325 = 1;
					end;
					if not v16326 and not v16325 then
						v16325 = 0;
						v16326 = 1;
					end;
					local v16329 = math.rad((v16328:NextNumber(v16325, v16326)));
					v16326 = -360;
					v16328 = 360;
					local v16330 = v16254 or v82;
					if not v16328 and v16326 then
						v16328 = v16326;
						v16326 = 1;
					end;
					if not v16328 and not v16326 then
						v16326 = 0;
						v16328 = 1;
					end;
					v16274.CFrame = v16277 * v16279(v16327, v16329, (math.rad((v16330:NextNumber(v16326, v16328)))));
					v16277 = v16274.CFrame;
					v16274.CFrame = v16274.CFrame - Vector3.new(0, 5, 0, 0);
					v16274.Transparency = 0;
					v16274.Parent = workspace.Thrown;
					v3:Create(v16274, TweenInfo.new(0.125, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
						CFrame = v16277
					}):Play();
					v16279 = l_LegacyReplication_0.Smoke:Clone();
					v16327 = {};
					for _, v16332 in pairs(v16279.Size.Keypoints) do
						table.insert(v16327, NumberSequenceKeypoint.new(v16332.Time, v16332.Value * math.clamp(v16264 / 5, 1, 5), v16332.Envelope));
					end;
					v16279.ZOffset = v16279.ZOffset + 1;
					v16279.Color = ColorSequence.new(v16278.Color);
					v16279.Size = NumberSequence.new(v16327);
					v16279.Parent = v16274;
					task.delay(0.01, function()
						v16279:Emit(2);
					end);
					v16329 = delay;
					v16325 = 6;
					v16326 = 7;
					v16328 = v16254 or v82;
					if not v16326 and v16325 then
						v16326 = v16325;
						v16325 = 1;
					end;
					if not v16326 and not v16325 then
						v16325 = 0;
						v16326 = 1;
					end;
					v16329(v16328:NextNumber(v16325, v16326), function()
						local v16333 = 1;
						if v898.Serious then
							v16333 = 5.5;
						end;
						local l_v3_31 = v3;
						local l_v16274_0 = v16274;
						local v16336 = TweenInfo.new(v16333, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
						local v16337 = {};
						local v16338 = v16274.CFrame - Vector3.new(0, v16274.Size.Y, 0);
						local l_Angles_41 = CFrame.Angles;
						local v16340 = -65;
						local v16341 = 65;
						local v16342 = v16254 or v82;
						if not v16341 and v16340 then
							v16341 = v16340;
							v16340 = 1;
						end;
						if not v16341 and not v16340 then
							v16340 = 0;
							v16341 = 1;
						end;
						local v16343 = math.rad((v16342:NextNumber(v16340, v16341)));
						v16341 = -65;
						local v16344 = 65;
						local v16345 = v16254 or v82;
						if not v16344 and v16341 then
							v16344 = v16341;
							v16341 = 1;
						end;
						if not v16344 and not v16341 then
							v16341 = 0;
							v16344 = 1;
						end;
						local v16346 = math.rad((v16345:NextNumber(v16341, v16344)));
						v16344 = -65;
						v16342 = 65;
						local v16347 = v16254 or v82;
						if not v16342 and v16344 then
							v16342 = v16344;
							v16344 = 1;
						end;
						if not v16342 and not v16344 then
							v16344 = 0;
							v16342 = 1;
						end;
						v16337.CFrame = v16338 * l_Angles_41(v16343, v16346, (math.rad((v16347:NextNumber(v16344, v16342)))));
						l_v3_31:Create(l_v16274_0, v16336, v16337):Play();
						delay(v16333, function()
							v16274:Destroy();
						end);
					end);
				end;
			end;
			if not v898.SuperSerious or v16264 % 2 == 0 then
				task.wait();
			end;
		end;
	end,

	['Debris Lines 2'] = function(v898)
		local v16248 = v898.Part and v898.Part.CFrame or v898.CFrame;
		local l_v16248_0 = v16248;
		local v16250 = {};
		local _ = {};
		local v16252 = {};
		l_v16248_0 = l_v16248_0 + l_v16248_0.lookVector * 1.793;
		local v16253 = v898.Seed or math.random(1, 2000000000);
		local v16254 = Random.new(v16253);
		local l_v89_3 = v89;
		local function v16258(v16256, v16257)
			return l_v89_3(v16256, v16257, nil, v16254);
		end;
		local l_Part_29 = Instance.new("Part");
		l_Part_29.Anchored = true;
		l_Part_29.Transparency = 1;
		l_Part_29.CanCollide = false;
		l_Part_29.CFrame = l_v16248_0;
		l_Part_29.Parent = workspace.Thrown;
		for _ = 1, 2 do
			v240({
				SoundId = "rbxassetid://91699171465251", 
				Volume = 8.5, 
				Parent = l_Part_29, 
				RollOffMaxDistance = 50000
			}):Play();
		end;
		v3:Create(l_Part_29, TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			CFrame = v16248 + l_v16248_0.lookVector * 75
		}):Play();
		game:GetService("Debris"):AddItem(l_Part_29, 6);
		local v16261 = 1;
		local v16262 = 20;
		local v16263 = v898.Times or 0;
		for v16264 = v16261, v16262 + v16263 do
			for v16265 = 1, 2 do
				local v16266 = v898.Spread or 2.25;
				if v16265 == 2 then
					v16266 = v16266 * -1;
				end;
				if v16265 == 1 and v16264 % 2 == 1 then
					local l_Attachment_14 = Instance.new("Attachment");
					l_Attachment_14.Parent = workspace.Terrain;
					l_Attachment_14.WorldCFrame = l_v16248_0 + l_v16248_0.lookVector * (v16264 * 3.6);
					l_Attachment_14.WorldCFrame = CFrame.new(l_Attachment_14.WorldCFrame.p, l_v16248_0.p);
					local v16268 = l_LegacyReplication_0.Push:Clone();
					v16268.Parent = l_Attachment_14;
					local v16269 = {};
					local v16270 = 5;
					if v898.SuperSerious then
						v16270 = 55;
					end;
					for _, v16272 in pairs(v16268.Size.Keypoints) do
						table.insert(v16269, NumberSequenceKeypoint.new(v16272.Time, v16272.Value * math.clamp(v16264 / 4, 0.35, v16270), v16272.Envelope));
					end;
					v16268.Size = NumberSequence.new(v16269);
					local l_v16268_0 = v16268 --[[ copy: 22 -> 68 ]];
					task.delay(0, function()
						l_v16268_0:Emit(v16258(2, 3, true));
					end);
				end;
				local v16274 = v230() or Instance.new("Part");
				table.insert(v16252, v16274);
				v16274.Name = "Debris";
				v16274.Anchored = true;
				v16274.CanCollide = true;
				v16274.Transparency = 1;
				local v16275 = 0.75;
				local v16276 = 1;
				local v16277 = v16254 or v82;
				if not v16276 and v16275 then
					v16276 = v16275;
					v16275 = 1;
				end;
				if not v16276 and not v16275 then
					v16275 = 0;
					v16276 = 1;
				end;
				local v16278 = v16277:NextNumber(v16275, v16276);
				v16276 = 0.75;
				v16277 = 1;
				local v16279 = v16254 or v82;
				if not v16277 and v16276 then
					v16277 = v16276;
					v16276 = 1;
				end;
				if not v16277 and not v16276 then
					v16276 = 0;
					v16277 = 1;
				end;
				local v16280 = Vector3.new(v16278, v16279:NextNumber(v16276, v16277), v16258(0.75, 1));
				v16276 = 2;
				v16277 = 3;
				v16279 = v16254 or v82;
				if not v16277 and v16276 then
					v16277 = v16276;
					v16276 = 1;
				end;
				if not v16277 and not v16276 then
					v16276 = 0;
					v16277 = 1;
				end;
				v16274.Size = v16280 * (v16264 / v16279:NextNumber(v16276, v16277));
				v16280 = 3.75;
				v16278 = 4.25;
				v16275 = v16254 or v82;
				if not v16278 and v16280 then
					v16278 = v16280;
					v16280 = 1;
				end;
				if not v16278 and not v16280 then
					v16280 = 0;
					v16278 = 1;
				end;
				local v16281 = v16275:NextNumber(v16280, v16278);
				if v898.SuperSerious then
					v16281 = v16281 * 3.5;
				end;
				v16274.CFrame = l_v16248_0 + l_v16248_0.lookVector * (v16264 * v16281);
				v16278 = 3;
				v16275 = 4;
				v16276 = v16254 or v82;
				if not v16275 and v16278 then
					v16275 = v16278;
					v16278 = 1;
				end;
				if not v16275 and not v16278 then
					v16278 = 0;
					v16275 = 1;
				end;
				v16280 = v16276:NextNumber(v16278, v16275);
				if v898.SuperSerious then
					v16274.Size = v16274.Size * 8;
					v16280 = 1;
				end;
				v16274.CFrame = v16274.CFrame * CFrame.new(v16266 * (v16264 / v16280), 0, 0);
				if v16265 == 1 then
					v16274:SetAttribute("Multi", 1);
				else
					v16274:SetAttribute("Multi", -1);
				end;
				v16278, v16275 = v556({
					orig = v16274.Position, 
					dir = Vector3.new(0, -12, 0, 0)
				});
				if not v16278 then
					v16274:Destroy();
				else
					v16276 = nil;
					if v898.Serious then
						v16277 = v230() or Instance.new("Part");
						v16279 = 1;
						if v16265 == 2 then
							v16279 = -1;
						end;
						table.insert(v16252, v16277);
						v16277.Name = "DebrisGg";
						v16277.Anchored = true;
						v16277.CanCollide = true;
						v16277.Transparency = 1;
						v16277.Size = Vector3.new(14.003999710083008, 8.59000015258789, 19.677000045776367, 0) * 0.85 * (v16264 / 20);
						local v16282 = 3.75;
						local v16283 = 4.25;
						local v16284 = v16254 or v82;
						if not v16283 and v16282 then
							v16283 = v16282;
							v16282 = 1;
						end;
						if not v16283 and not v16282 then
							v16282 = 0;
							v16283 = 1;
						end;
						local v16285 = v16284:NextNumber(v16282, v16283);
						if v898.SuperSerious then
							v16277.Size = v16277.Size * 8;
							v16285 = v16285 * 3.5;
						end;
						v16283 = 1;
						v16284 = 2;
						local v16286 = v16254 or v82;
						if not v16284 and v16283 then
							v16284 = v16283;
							v16283 = 1;
						end;
						if not v16284 and not v16283 then
							v16283 = 0;
							v16284 = 1;
						end;
						v16282 = v16286:NextNumber(v16283, v16284);
						if v898.SuperSerious then
							v16282 = 0.35;
						end;
						v16286 = CFrame.Angles;
						local v16287 = -12;
						local v16288 = 12;
						local v16289 = v16254 or v82;
						if not v16288 and v16287 then
							v16288 = v16287;
							v16287 = 1;
						end;
						if not v16288 and not v16287 then
							v16287 = 0;
							v16288 = 1;
						end;
						local v16290 = math.rad((v16289:NextNumber(v16287, v16288)));
						v16288 = -14;
						v16289 = 14;
						local v16291 = v16254 or v82;
						if not v16289 and v16288 then
							v16289 = v16288;
							v16288 = 1;
						end;
						if not v16289 and not v16288 then
							v16288 = 0;
							v16289 = 1;
						end;
						local v16292 = math.rad((v16291:NextNumber(v16288, v16289)));
						v16291 = 25;
						local v16293 = 75;
						local v16294 = v16254 or v82;
						if not v16293 and v16291 then
							v16293 = v16291;
							v16291 = 1;
						end;
						if not v16293 and not v16291 then
							v16291 = 0;
							v16293 = 1;
						end;
						v16277.CFrame = l_v16248_0 * v16286(v16290, v16292, (math.rad(v16279 * v16294:NextNumber(v16291, v16293)))) + l_v16248_0.lookVector * (v16264 * v16285);
						v16277.CFrame = v16277.CFrame * CFrame.new(v16266 * (v16264 / v16282), 0, 0);
						v16277.Material = v16278.Material;
						v16277.Color = v16278.Color;
						v16277.Position = Vector3.new(v16277.Position.X, v16275.Y - v16277.Size.Y / 3, v16277.Position.Z);
						v16283 = v16277.CFrame;
						v16277.CFrame = v16277.CFrame - Vector3.new(0, 5, 0, 0);
						v16277.Transparency = 0;
						v16277.Parent = workspace.Thrown;
						v3:Create(v16277, TweenInfo.new(0.125, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
							CFrame = v16283
						}):Play();
						v16284 = delay;
						v16290 = 6;
						v16292 = 7;
						v16287 = v16254 or v82;
						if not v16292 and v16290 then
							v16292 = v16290;
							v16290 = 1;
						end;
						if not v16292 and not v16290 then
							v16290 = 0;
							v16292 = 1;
						end;
						local l_v16277_0 = v16277 --[[ copy: 27 -> 67 ]];
						v16284(v16287:NextNumber(v16290, v16292), function()
							local v16296 = 1;
							v16296 = 5.5;
							local l_v3_30 = v3;
							local l_l_v16277_0_0 = l_v16277_0;
							local v16299 = TweenInfo.new(v16296, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
							local v16300 = {};
							local v16301 = l_v16277_0.CFrame - Vector3.new(0, l_v16277_0.Size.Y, 0);
							local l_Angles_40 = CFrame.Angles;
							local v16303 = -15;
							local v16304 = 15;
							local v16305 = v16254 or v82;
							if not v16304 and v16303 then
								v16304 = v16303;
								v16303 = 1;
							end;
							if not v16304 and not v16303 then
								v16303 = 0;
								v16304 = 1;
							end;
							local v16306 = math.rad((v16305:NextNumber(v16303, v16304)));
							v16304 = -15;
							local v16307 = 15;
							local v16308 = v16254 or v82;
							if not v16307 and v16304 then
								v16307 = v16304;
								v16304 = 1;
							end;
							if not v16307 and not v16304 then
								v16304 = 0;
								v16307 = 1;
							end;
							local v16309 = math.rad((v16308:NextNumber(v16304, v16307)));
							v16307 = -15;
							v16305 = 15;
							local v16310 = v16254 or v82;
							if not v16305 and v16307 then
								v16305 = v16307;
								v16307 = 1;
							end;
							if not v16305 and not v16307 then
								v16307 = 0;
								v16305 = 1;
							end;
							v16300.CFrame = v16301 * l_Angles_40(v16306, v16309, (math.rad((v16310:NextNumber(v16307, v16305)))));
							l_v3_30:Create(l_l_v16277_0_0, v16299, v16300):Play();
							delay(v16296, function()
								l_v16277_0:Destroy();
							end);
						end);
					end;
					if (not (v16265 ~= 1) or v898.Serious) and not v898.SuperSerious then
						for _ = 1, 1 do
							local v16312 = v230() or Instance.new("Part");
							v16312.Name = "Debris";
							table.insert(v16252, v16312);
							v16312.Anchored = false;
							v16312.CanCollide = false;
							v16312.Transparency = 0;
							local v16313 = 0.75;
							local v16314 = 1;
							local v16315 = v16254 or v82;
							if not v16314 and v16313 then
								v16314 = v16313;
								v16313 = 1;
							end;
							if not v16314 and not v16313 then
								v16313 = 0;
								v16314 = 1;
							end;
							local v16316 = v16315:NextNumber(v16313, v16314);
							v16314 = 0.75;
							v16315 = 1;
							local v16317 = v16254 or v82;
							if not v16315 and v16314 then
								v16315 = v16314;
								v16314 = 1;
							end;
							if not v16315 and not v16314 then
								v16314 = 0;
								v16315 = 1;
							end;
							local v16318 = Vector3.new(v16316, v16317:NextNumber(v16314, v16315), v16258(0.75, 1));
							v16314 = 5;
							v16315 = 7;
							v16317 = v16254 or v82;
							if not v16315 and v16314 then
								v16315 = v16314;
								v16314 = 1;
							end;
							if not v16315 and not v16314 then
								v16314 = 0;
								v16315 = 1;
							end;
							v16312.Size = v16318 * (v16264 / v16317:NextNumber(v16314, v16315));
							v16316 = l_v16248_0.lookVector;
							v16315 = 3.75;
							v16317 = 4.25;
							local v16319 = v16254 or v82;
							if not v16317 and v16315 then
								v16317 = v16315;
								v16315 = 1;
							end;
							if not v16317 and not v16315 then
								v16315 = 0;
								v16317 = 1;
							end;
							v16312.CFrame = l_v16248_0 + v16316 * (v16264 * v16319:NextNumber(v16315, v16317));
							v16312.Position = Vector3.new(v16312.Position.X, v16275.Y, v16312.Position.Z);
							v16276 = v16312.CFrame;
							local l_CFrame_86 = v16312.CFrame;
							v16316 = CFrame.new;
							v16314 = v16266;
							v16315 = -v16266;
							v16317 = v16314;
							v16319 = v16315;
							local v16321 = v16254 or v82;
							if not v16319 and v16317 then
								v16319 = v16317;
								v16317 = 1;
							end;
							if not v16319 and not v16317 then
								v16317 = 0;
								v16319 = 1;
							end;
							v16316 = v16316(v16321:NextNumber(v16317, v16319), 0, 0);
							v16313 = CFrame.Angles;
							v16317 = -360;
							v16319 = 360;
							v16321 = v16254 or v82;
							if not v16319 and v16317 then
								v16319 = v16317;
								v16317 = 1;
							end;
							if not v16319 and not v16317 then
								v16317 = 0;
								v16319 = 1;
							end;
							v16314 = math.rad((v16321:NextNumber(v16317, v16319)));
							v16319 = -360;
							v16321 = 360;
							local v16322 = v16254 or v82;
							if not v16321 and v16319 then
								v16321 = v16319;
								v16319 = 1;
							end;
							if not v16321 and not v16319 then
								v16319 = 0;
								v16321 = 1;
							end;
							v16315 = math.rad((v16322:NextNumber(v16319, v16321)));
							v16321 = -360;
							v16322 = 360;
							local v16323 = v16254 or v82;
							if not v16322 and v16321 then
								v16322 = v16321;
								v16321 = 1;
							end;
							if not v16322 and not v16321 then
								v16321 = 0;
								v16322 = 1;
							end;
							v16312.CFrame = l_CFrame_86 * (v16316 * v16313(v16314, v16315, (math.rad((v16323:NextNumber(v16321, v16322))))));
							v16274:SetAttribute("Original", v16276.p);
							v16312.CollisionGroup = "nocol";
							v16312.Color = v16278.Color;
							v16312.Material = v16278.Material;
							v16312.Parent = workspace.Thrown;
							table.insert(v16250, {
								v16312, 
								v16276
							});
							game:service("Debris"):AddItem(v16312, 10);
							l_CFrame_86 = Instance.new("BodyVelocity");
							v16318 = 1;
							if v898.Serious then
								v16318 = 3;
								if math.random(1, 3) == 1 then
									v16312.CanCollide = true;
									if v16264 < 15 then
										task.delay(0.85, function()
											while true do
												task.wait();
												if not (v16312.Parent and not v556({
													orig = v16312.Position, 
													dir = Vector3.new(0, -3, 0, 0)
													})) then
													break;
												end;
											end;
											if v556({
												orig = v16312.Position, 
												dir = Vector3.new(0, -3, 0, 0)
												}) then
												v240({
													SoundId = ({
														"rbxassetid://3848076724", 
														"rbxassetid://3848078820"
													})[math.random(1, 2)], 
													Volume = 2, 
													PlaybackSpeed = 1.3, 
													Parent = v16312, 
													RollOffMaxDistance = 455
												}):Play();
											end;
										end);
									end;
									task.delay(0.3, function()
										v240({
											SoundId = "rbxassetid://7556019578", 
											Volume = 4, 
											Parent = l_Part_29, 
											RollOffMaxDistance = 455
										}):Play();
									end);
									task.delay(5 + math.random(), function()
										v3:Create(v16312, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
											Transparency = 1
										}):Play();
									end);
								end;
							end;
							l_CFrame_86.MaxForce = Vector3.new(1, 1, 1, 0) * 40000;
							v16315 = -9;
							v16317 = 9;
							v16319 = v16254 or v82;
							if not v16317 and v16315 then
								v16317 = v16315;
								v16315 = 1;
							end;
							if not v16317 and not v16315 then
								v16315 = 0;
								v16317 = 1;
							end;
							v16313 = v16319:NextNumber(v16315, v16317) * v16318;
							v16317 = 10;
							v16319 = 55;
							v16321 = v16254 or v82;
							if not v16319 and v16317 then
								v16319 = v16317;
								v16317 = 1;
							end;
							if not v16319 and not v16317 then
								v16317 = 0;
								v16319 = 1;
							end;
							v16314 = v16321:NextNumber(v16317, v16319) * v16318;
							v16319 = -9;
							v16321 = 9;
							v16322 = v16254 or v82;
							if not v16321 and v16319 then
								v16321 = v16319;
								v16319 = 1;
							end;
							if not v16321 and not v16319 then
								v16319 = 0;
								v16321 = 1;
							end;
							l_CFrame_86.Velocity = Vector3.new(v16313, v16314, v16322:NextNumber(v16319, v16321) * v16318);
							l_CFrame_86.Parent = v16312;
							game:service("Debris"):AddItem(l_CFrame_86, 0.15);
						end;
					end;
					v16274.Material = v16278.Material;
					v16274.Color = v16278.Color;
					v16274.Position = Vector3.new(v16274.Position.X, v16275.Y, v16274.Position.Z);
					v16277 = v16274.CFrame;
					v16279 = CFrame.Angles;
					local v16324 = -360;
					local v16325 = 360;
					local v16326 = v16254 or v82;
					if not v16325 and v16324 then
						v16325 = v16324;
						v16324 = 1;
					end;
					if not v16325 and not v16324 then
						v16324 = 0;
						v16325 = 1;
					end;
					local v16327 = math.rad((v16326:NextNumber(v16324, v16325)));
					v16325 = -360;
					v16326 = 360;
					local v16328 = v16254 or v82;
					if not v16326 and v16325 then
						v16326 = v16325;
						v16325 = 1;
					end;
					if not v16326 and not v16325 then
						v16325 = 0;
						v16326 = 1;
					end;
					local v16329 = math.rad((v16328:NextNumber(v16325, v16326)));
					v16326 = -360;
					v16328 = 360;
					local v16330 = v16254 or v82;
					if not v16328 and v16326 then
						v16328 = v16326;
						v16326 = 1;
					end;
					if not v16328 and not v16326 then
						v16326 = 0;
						v16328 = 1;
					end;
					v16274.CFrame = v16277 * v16279(v16327, v16329, (math.rad((v16330:NextNumber(v16326, v16328)))));
					v16277 = v16274.CFrame;
					v16274.CFrame = v16274.CFrame - Vector3.new(0, 5, 0, 0);
					v16274.Transparency = 0;
					v16274.Parent = workspace.Thrown;
					v3:Create(v16274, TweenInfo.new(0.125, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
						CFrame = v16277
					}):Play();
					v16279 = l_LegacyReplication_0.Smoke:Clone();
					v16327 = {};
					for _, v16332 in pairs(v16279.Size.Keypoints) do
						table.insert(v16327, NumberSequenceKeypoint.new(v16332.Time, v16332.Value * math.clamp(v16264 / 5, 1, 5), v16332.Envelope));
					end;
					v16279.ZOffset = v16279.ZOffset + 1;
					v16279.Color = ColorSequence.new(v16278.Color);
					v16279.Size = NumberSequence.new(v16327);
					v16279.Parent = v16274;
					task.delay(0.01, function()
						v16279:Emit(2);
					end);
					v16329 = delay;
					v16325 = 6;
					v16326 = 7;
					v16328 = v16254 or v82;
					if not v16326 and v16325 then
						v16326 = v16325;
						v16325 = 1;
					end;
					if not v16326 and not v16325 then
						v16325 = 0;
						v16326 = 1;
					end;
					v16329(v16328:NextNumber(v16325, v16326), function()
						local v16333 = 1;
						if v898.Serious then
							v16333 = 5.5;
						end;
						local l_v3_31 = v3;
						local l_v16274_0 = v16274;
						local v16336 = TweenInfo.new(v16333, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
						local v16337 = {};
						local v16338 = v16274.CFrame - Vector3.new(0, v16274.Size.Y, 0);
						local l_Angles_41 = CFrame.Angles;
						local v16340 = -65;
						local v16341 = 65;
						local v16342 = v16254 or v82;
						if not v16341 and v16340 then
							v16341 = v16340;
							v16340 = 1;
						end;
						if not v16341 and not v16340 then
							v16340 = 0;
							v16341 = 1;
						end;
						local v16343 = math.rad((v16342:NextNumber(v16340, v16341)));
						v16341 = -65;
						local v16344 = 65;
						local v16345 = v16254 or v82;
						if not v16344 and v16341 then
							v16344 = v16341;
							v16341 = 1;
						end;
						if not v16344 and not v16341 then
							v16341 = 0;
							v16344 = 1;
						end;
						local v16346 = math.rad((v16345:NextNumber(v16341, v16344)));
						v16344 = -65;
						v16342 = 65;
						local v16347 = v16254 or v82;
						if not v16342 and v16344 then
							v16342 = v16344;
							v16344 = 1;
						end;
						if not v16342 and not v16344 then
							v16344 = 0;
							v16342 = 1;
						end;
						v16337.CFrame = v16338 * l_Angles_41(v16343, v16346, (math.rad((v16347:NextNumber(v16344, v16342)))));
						l_v3_31:Create(l_v16274_0, v16336, v16337):Play();
						delay(v16333, function()
							v16274:Destroy();
						end);
					end);
				end;
			end;
			if not v898.SuperSerious or v16264 % 2 == 0 then
				task.wait();
			end;
		end;
	end,

	['Huge Debris Lines 2'] = function(v898)
		local v16248 = v898.Part and v898.Part.CFrame or v898.CFrame;
		local l_v16248_0 = v16248;
		local v16250 = {};
		local _ = {};
		local v16252 = {};
		l_v16248_0 = l_v16248_0 + l_v16248_0.LookVector * 1.793;
		local v16253 = v898.Seed or math.random(1, 2000000000);
		local v16254 = Random.new(v16253);
		local l_v89_3 = v89;
		local function v16258(v16256, v16257)
			return l_v89_3(v16256, v16257, nil, v16254);
		end;
		local l_Part_29 = Instance.new("Part");
		l_Part_29.Anchored = true;
		l_Part_29.Transparency = 1;
		l_Part_29.CanCollide = false;
		l_Part_29.CFrame = l_v16248_0;
		l_Part_29.Parent = workspace.Thrown;
		for _ = 1, 2 do
			v240({
				SoundId = "rbxassetid://104285449654460", 
				Volume = 4, 
				Parent = l_Part_29, 
				RollOffMaxDistance = 455
			}):Play();
		end;
		v3:Create(l_Part_29, TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			CFrame = v16248 + l_v16248_0.LookVector * 75
		}):Play();
		game:GetService("Debris"):AddItem(l_Part_29, 6);
		local v16261 = 1;
		local v16262 = 45;
		local v16263 = v898.Times or 0;
		for v16264 = v16261, v16262 + v16263 do
			for v16265 = 1, 2 do
				local v16266 = v898.Spread or 2.30;
				if v16265 == 2 then
					v16266 = v16266 * -1;
				end;
				if v16265 == 1 and v16264 % 2 == 1 then
					local l_Attachment_14 = Instance.new("Attachment");
					l_Attachment_14.Parent = workspace.Terrain;
					l_Attachment_14.WorldCFrame = l_v16248_0 + l_v16248_0.LookVector * (v16264 * 3.6);
					l_Attachment_14.WorldCFrame = CFrame.new(l_Attachment_14.WorldCFrame.p, l_v16248_0.p);
					local v16268 = l_LegacyReplication_0.Push:Clone();
					v16268.Parent = l_Attachment_14;
					local v16269 = {};
					local v16270 = 5;
					if v898.SuperSerious then
						v16270 = 55;
					end;
					for _, v16272 in pairs(v16268.Size.Keypoints) do
						table.insert(v16269, NumberSequenceKeypoint.new(v16272.Time, v16272.Value * math.clamp(v16264 / 4, 0.35, v16270), v16272.Envelope));
					end;
					v16268.Size = NumberSequence.new(v16269);
					local l_v16268_0 = v16268 --[[ copy: 22 -> 68 ]];
					task.delay(0, function()
						l_v16268_0:Emit(v16258(2, 3, true));
					end);
				end;
				local v16274 = v230() or Instance.new("Part");
				table.insert(v16252, v16274);
				v16274.Name = "Debris";
				v16274.Anchored = true;
				v16274.CanCollide = true;
				v16274.Transparency = 1;
				local v16275 = 0.75;
				local v16276 = 1;
				local v16277 = v16254 or v82;
				if not v16276 and v16275 then
					v16276 = v16275;
					v16275 = 1;
				end;
				if not v16276 and not v16275 then
					v16275 = 0;
					v16276 = 1;
				end;
				local v16278 = v16277:NextNumber(v16275, v16276);
				v16276 = 0.75;
				v16277 = 1;
				local v16279 = v16254 or v82;
				if not v16277 and v16276 then
					v16277 = v16276;
					v16276 = 1;
				end;
				if not v16277 and not v16276 then
					v16276 = 0;
					v16277 = 1;
				end;
				local v16280 = Vector3.new(v16278, v16279:NextNumber(v16276, v16277), v16258(0.75, 1));
				v16276 = 2;
				v16277 = 3;
				v16279 = v16254 or v82;
				if not v16277 and v16276 then
					v16277 = v16276;
					v16276 = 1;
				end;
				if not v16277 and not v16276 then
					v16276 = 0;
					v16277 = 1;
				end;
				v16274.Size = v16280 * (v16264 / v16279:NextNumber(v16276, v16277));
				v16280 = 4.45;
				v16278 = 4.45;
				v16275 = v16254 or v82;
				if not v16278 and v16280 then
					v16278 = v16280;
					v16280 = 1;
				end;
				if not v16278 and not v16280 then
					v16280 = 0;
					v16278 = 1;
				end;
				local v16281 = v16275:NextNumber(v16280, v16278);
				if v898.SuperSerious then
					v16281 = v16281 * 3.5;
				end;
				v16274.CFrame = l_v16248_0 + l_v16248_0.LookVector * (v16264 * v16281);
				v16278 = 3;
				v16275 = 4;
				v16276 = v16254 or v82;
				if not v16275 and v16278 then
					v16275 = v16278;
					v16278 = 1;
				end;
				if not v16275 and not v16278 then
					v16278 = 0;
					v16275 = 1;
				end;
				v16280 = v16276:NextNumber(v16278, v16275);
				if v898.SuperSerious then
					v16274.Size = v16274.Size * 8;
					v16280 = 1;
				end;
				v16274.CFrame = v16274.CFrame * CFrame.new(v16266 * (v16264 / v16280), 0, 0);
				if v16265 == 1 then
					v16274:SetAttribute("Multi", 1);
				else
					v16274:SetAttribute("Multi", -1);
				end;
				v16278, v16275 = v556({
					orig = v16274.Position, 
					dir = Vector3.new(0, -12, 0, 0)
				});
				if not v16278 then
					v16274:Destroy();
				else
					v16276 = nil;
					if v898.Serious then
						v16277 = v230() or Instance.new("Part");
						v16279 = 1;
						if v16265 == 2 then
							v16279 = -1;
						end;
						table.insert(v16252, v16277);
						v16277.Name = "DebrisGg";
						v16277.Anchored = true;
						v16277.CanCollide = true;
						v16277.Transparency = 1;
						v16277.Size = Vector3.new(14.003999710083008, 8.59000015258789, 19.677000045776367, 0) * 0.85 * (v16264 / 20);
						local v16282 = 3.75;
						local v16283 = 4.25;
						local v16284 = v16254 or v82;
						if not v16283 and v16282 then
							v16283 = v16282;
							v16282 = 1;
						end;
						if not v16283 and not v16282 then
							v16282 = 0;
							v16283 = 1;
						end;
						local v16285 = v16284:NextNumber(v16282, v16283);
						if v898.SuperSerious then
							v16277.Size = v16277.Size * 8;
							v16285 = v16285 * 3.5;
						end;
						v16283 = 1;
						v16284 = 2;
						local v16286 = v16254 or v82;
						if not v16284 and v16283 then
							v16284 = v16283;
							v16283 = 1;
						end;
						if not v16284 and not v16283 then
							v16283 = 0;
							v16284 = 1;
						end;
						v16282 = v16286:NextNumber(v16283, v16284);
						if v898.SuperSerious then
							v16282 = 0.35;
						end;
						v16286 = CFrame.Angles;
						local v16287 = -12;
						local v16288 = 12;
						local v16289 = v16254 or v82;
						if not v16288 and v16287 then
							v16288 = v16287;
							v16287 = 1;
						end;
						if not v16288 and not v16287 then
							v16287 = 0;
							v16288 = 1;
						end;
						local v16290 = math.rad((v16289:NextNumber(v16287, v16288)));
						v16288 = -14;
						v16289 = 14;
						local v16291 = v16254 or v82;
						if not v16289 and v16288 then
							v16289 = v16288;
							v16288 = 1;
						end;
						if not v16289 and not v16288 then
							v16288 = 0;
							v16289 = 1;
						end;
						local v16292 = math.rad((v16291:NextNumber(v16288, v16289)));
						v16291 = 25;
						local v16293 = 75;
						local v16294 = v16254 or v82;
						if not v16293 and v16291 then
							v16293 = v16291;
							v16291 = 1;
						end;
						if not v16293 and not v16291 then
							v16291 = 0;
							v16293 = 1;
						end;
						v16277.CFrame = l_v16248_0 * v16286(v16290, v16292, (math.rad(v16279 * v16294:NextNumber(v16291, v16293)))) + l_v16248_0.LookVector * (v16264 * v16285);
						v16277.CFrame = v16277.CFrame * CFrame.new(v16266 * (v16264 / v16282), 0, 0);
						v16277.Material = v16278.Material;
						v16277.Color = v16278.Color;
						v16277.Position = Vector3.new(v16277.Position.X, v16275.Y - v16277.Size.Y / 3, v16277.Position.Z);
						v16283 = v16277.CFrame;
						v16277.CFrame = v16277.CFrame - Vector3.new(0, 5, 0, 0);
						v16277.Transparency = 0;
						v16277.Parent = workspace.Thrown;
						v3:Create(v16277, TweenInfo.new(0.125, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
							CFrame = v16283
						}):Play();
						v16284 = delay;
						v16290 = 6;
						v16292 = 7;
						v16287 = v16254 or v82;
						if not v16292 and v16290 then
							v16292 = v16290;
							v16290 = 1;
						end;
						if not v16292 and not v16290 then
							v16290 = 0;
							v16292 = 1;
						end;
						local l_v16277_0 = v16277 --[[ copy: 27 -> 67 ]];
						v16284(v16287:NextNumber(v16290, v16292), function()
							local v16296 = 1;
							v16296 = 5.5;
							local l_v3_30 = v3;
							local l_l_v16277_0_0 = l_v16277_0;
							local v16299 = TweenInfo.new(v16296, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
							local v16300 = {};
							local v16301 = l_v16277_0.CFrame - Vector3.new(0, l_v16277_0.Size.Y, 0);
							local l_Angles_40 = CFrame.Angles;
							local v16303 = -15;
							local v16304 = 15;
							local v16305 = v16254 or v82;
							if not v16304 and v16303 then
								v16304 = v16303;
								v16303 = 1;
							end;
							if not v16304 and not v16303 then
								v16303 = 0;
								v16304 = 1;
							end;
							local v16306 = math.rad((v16305:NextNumber(v16303, v16304)));
							v16304 = -15;
							local v16307 = 15;
							local v16308 = v16254 or v82;
							if not v16307 and v16304 then
								v16307 = v16304;
								v16304 = 1;
							end;
							if not v16307 and not v16304 then
								v16304 = 0;
								v16307 = 1;
							end;
							local v16309 = math.rad((v16308:NextNumber(v16304, v16307)));
							v16307 = -15;
							v16305 = 15;
							local v16310 = v16254 or v82;
							if not v16305 and v16307 then
								v16305 = v16307;
								v16307 = 1;
							end;
							if not v16305 and not v16307 then
								v16307 = 0;
								v16305 = 1;
							end;
							v16300.CFrame = v16301 * l_Angles_40(v16306, v16309, (math.rad((v16310:NextNumber(v16307, v16305)))));
							l_v3_30:Create(l_l_v16277_0_0, v16299, v16300):Play();
							delay(v16296, function()
								l_v16277_0:Destroy();
							end);
						end);
					end;
					if (not (v16265 ~= 1) or v898.Serious) and not v898.SuperSerious then
						for _ = 1, 1 do
							local v16312 = v230() or Instance.new("Part");
							v16312.Name = "Debris";
							table.insert(v16252, v16312);
							v16312.Anchored = false;
							v16312.CanCollide = false;
							v16312.Transparency = 0;
							local v16313 = 0.75;
							local v16314 = 1;
							local v16315 = v16254 or v82;
							if not v16314 and v16313 then
								v16314 = v16313;
								v16313 = 1;
							end;
							if not v16314 and not v16313 then
								v16313 = 0;
								v16314 = 1;
							end;
							local v16316 = v16315:NextNumber(v16313, v16314);
							v16314 = 0.75;
							v16315 = 1;
							local v16317 = v16254 or v82;
							if not v16315 and v16314 then
								v16315 = v16314;
								v16314 = 1;
							end;
							if not v16315 and not v16314 then
								v16314 = 0;
								v16315 = 1;
							end;
							local v16318 = Vector3.new(v16316, v16317:NextNumber(v16314, v16315), v16258(0.75, 1));
							v16314 = 5;
							v16315 = 7;
							v16317 = v16254 or v82;
							if not v16315 and v16314 then
								v16315 = v16314;
								v16314 = 1;
							end;
							if not v16315 and not v16314 then
								v16314 = 0;
								v16315 = 1;
							end;
							v16312.Size = v16318 * (v16264 / v16317:NextNumber(v16314, v16315));
							v16316 = l_v16248_0.LookVector;
							v16315 = 3.75;
							v16317 = 4.25;
							local v16319 = v16254 or v82;
							if not v16317 and v16315 then
								v16317 = v16315;
								v16315 = 1;
							end;
							if not v16317 and not v16315 then
								v16315 = 0;
								v16317 = 1;
							end;
							v16312.CFrame = l_v16248_0 + v16316 * (v16264 * v16319:NextNumber(v16315, v16317));
							v16312.Position = Vector3.new(v16312.Position.X, v16275.Y, v16312.Position.Z);
							v16276 = v16312.CFrame;
							local l_CFrame_86 = v16312.CFrame;
							v16316 = CFrame.new;
							v16314 = v16266;
							v16315 = -v16266;
							v16317 = v16314;
							v16319 = v16315;
							local v16321 = v16254 or v82;
							if not v16319 and v16317 then
								v16319 = v16317;
								v16317 = 1;
							end;
							if not v16319 and not v16317 then
								v16317 = 0;
								v16319 = 1;
							end;
							v16316 = v16316(v16321:NextNumber(v16317, v16319), 0, 0);
							v16313 = CFrame.Angles;
							v16317 = -360;
							v16319 = 360;
							v16321 = v16254 or v82;
							if not v16319 and v16317 then
								v16319 = v16317;
								v16317 = 1;
							end;
							if not v16319 and not v16317 then
								v16317 = 0;
								v16319 = 1;
							end;
							v16314 = math.rad((v16321:NextNumber(v16317, v16319)));
							v16319 = -360;
							v16321 = 360;
							local v16322 = v16254 or v82;
							if not v16321 and v16319 then
								v16321 = v16319;
								v16319 = 1;
							end;
							if not v16321 and not v16319 then
								v16319 = 0;
								v16321 = 1;
							end;
							v16315 = math.rad((v16322:NextNumber(v16319, v16321)));
							v16321 = -360;
							v16322 = 360;
							local v16323 = v16254 or v82;
							if not v16322 and v16321 then
								v16322 = v16321;
								v16321 = 1;
							end;
							if not v16322 and not v16321 then
								v16321 = 0;
								v16322 = 1;
							end;
							v16312.CFrame = l_CFrame_86 * (v16316 * v16313(v16314, v16315, (math.rad((v16323:NextNumber(v16321, v16322))))));
							v16274:SetAttribute("Original", v16276.p);
							v16312.CollisionGroup = "nocol";
							v16312.Color = v16278.Color;
							v16312.Material = v16278.Material;
							v16312.Parent = workspace.Thrown;
							table.insert(v16250, {
								v16312, 
								v16276
							});
							game:service("Debris"):AddItem(v16312, 10);
							l_CFrame_86 = Instance.new("BodyVelocity");
							v16318 = 1;
							if v898.Serious then
								v16318 = 3;
								if math.random(1, 3) == 1 then
									v16312.CanCollide = true;
									if v16264 < 15 then
										task.delay(0.85, function()
											while true do
												task.wait();
												if not (v16312.Parent and not v556({
													orig = v16312.Position, 
													dir = Vector3.new(0, -3, 0, 0)
													})) then
													break;
												end;
											end;
											if v556({
												orig = v16312.Position, 
												dir = Vector3.new(0, -3, 0, 0)
												}) then
												v240({
													SoundId = ({
														"rbxassetid://3848076724", 
														"rbxassetid://3848078820"
													})[math.random(1, 2)], 
													Volume = 2, 
													PlaybackSpeed = 1.3, 
													Parent = v16312, 
													RollOffMaxDistance = 455
												}):Play();
											end;
										end);
									end;
									task.delay(5 + math.random(), function()
										v3:Create(v16312, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
											Transparency = 1
										}):Play();
									end);
								end;
							end;
							l_CFrame_86.MaxForce = Vector3.new(1, 1, 1, 0) * 40000;
							v16315 = -9;
							v16317 = 9;
							v16319 = v16254 or v82;
							if not v16317 and v16315 then
								v16317 = v16315;
								v16315 = 1;
							end;
							if not v16317 and not v16315 then
								v16315 = 0;
								v16317 = 1;
							end;
							v16313 = v16319:NextNumber(v16315, v16317) * v16318;
							v16317 = 10;
							v16319 = 55;
							v16321 = v16254 or v82;
							if not v16319 and v16317 then
								v16319 = v16317;
								v16317 = 1;
							end;
							if not v16319 and not v16317 then
								v16317 = 0;
								v16319 = 1;
							end;
							v16314 = v16321:NextNumber(v16317, v16319) * v16318;
							v16319 = -9;
							v16321 = 9;
							v16322 = v16254 or v82;
							if not v16321 and v16319 then
								v16321 = v16319;
								v16319 = 1;
							end;
							if not v16321 and not v16319 then
								v16319 = 0;
								v16321 = 1;
							end;
							l_CFrame_86.Velocity = Vector3.new(v16313, v16314, v16322:NextNumber(v16319, v16321) * v16318);
							l_CFrame_86.Parent = v16312;
							game:service("Debris"):AddItem(l_CFrame_86, 0.15);
						end;
					end;
					v16274.Material = v16278.Material;
					v16274.Color = v16278.Color;
					v16274.Position = Vector3.new(v16274.Position.X, v16275.Y, v16274.Position.Z);
					v16277 = v16274.CFrame;
					v16279 = CFrame.Angles;
					local v16324 = -360;
					local v16325 = 360;
					local v16326 = v16254 or v82;
					if not v16325 and v16324 then
						v16325 = v16324;
						v16324 = 1;
					end;
					if not v16325 and not v16324 then
						v16324 = 0;
						v16325 = 1;
					end;
					local v16327 = math.rad((v16326:NextNumber(v16324, v16325)));
					v16325 = -360;
					v16326 = 360;
					local v16328 = v16254 or v82;
					if not v16326 and v16325 then
						v16326 = v16325;
						v16325 = 1;
					end;
					if not v16326 and not v16325 then
						v16325 = 0;
						v16326 = 1;
					end;
					local v16329 = math.rad((v16328:NextNumber(v16325, v16326)));
					v16326 = -360;
					v16328 = 360;
					local v16330 = v16254 or v82;
					if not v16328 and v16326 then
						v16328 = v16326;
						v16326 = 1;
					end;
					if not v16328 and not v16326 then
						v16326 = 0;
						v16328 = 1;
					end;
					v16274.CFrame = v16277 * v16279(v16327, v16329, (math.rad((v16330:NextNumber(v16326, v16328)))));
					v16277 = v16274.CFrame;
					v16274.CFrame = v16274.CFrame - Vector3.new(0, 5, 0, 0);
					v16274.Transparency = 0;
					v16274.Parent = workspace.Thrown;
					v3:Create(v16274, TweenInfo.new(0.125, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
						CFrame = v16277
					}):Play();
					v16279 = l_LegacyReplication_0.Smoke:Clone();
					v16327 = {};
					for _, v16332 in pairs(v16279.Size.Keypoints) do
						table.insert(v16327, NumberSequenceKeypoint.new(v16332.Time, v16332.Value * math.clamp(v16264 / 5, 1, 5), v16332.Envelope));
					end;
					v16279.ZOffset = v16279.ZOffset + 1;
					v16279.Color = ColorSequence.new(v16278.Color);
					v16279.Size = NumberSequence.new(v16327);
					v16279.Parent = v16274;
					task.delay(0.01, function()
						v16279:Emit(2);
					end);
					v16329 = delay;
					v16325 = 6;
					v16326 = 7;
					v16328 = v16254 or v82;
					if not v16326 and v16325 then
						v16326 = v16325;
						v16325 = 1;
					end;
					if not v16326 and not v16325 then
						v16325 = 0;
						v16326 = 1;
					end;
					v16329(v16328:NextNumber(v16325, v16326), function()
						local v16333 = 1;
						if v898.Serious then
							v16333 = 5.5;
						end;
						local l_v3_31 = v3;
						local l_v16274_0 = v16274;
						local v16336 = TweenInfo.new(v16333, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
						local v16337 = {};
						local v16338 = v16274.CFrame - Vector3.new(0, v16274.Size.Y, 0);
						local l_Angles_41 = CFrame.Angles;
						local v16340 = -65;
						local v16341 = 65;
						local v16342 = v16254 or v82;
						if not v16341 and v16340 then
							v16341 = v16340;
							v16340 = 1;
						end;
						if not v16341 and not v16340 then
							v16340 = 0;
							v16341 = 1;
						end;
						local v16343 = math.rad((v16342:NextNumber(v16340, v16341)));
						v16341 = -65;
						local v16344 = 65;
						local v16345 = v16254 or v82;
						if not v16344 and v16341 then
							v16344 = v16341;
							v16341 = 1;
						end;
						if not v16344 and not v16341 then
							v16341 = 0;
							v16344 = 1;
						end;
						local v16346 = math.rad((v16345:NextNumber(v16341, v16344)));
						v16344 = -65;
						v16342 = 65;
						local v16347 = v16254 or v82;
						if not v16342 and v16344 then
							v16342 = v16344;
							v16344 = 1;
						end;
						if not v16342 and not v16344 then
							v16344 = 0;
							v16342 = 1;
						end;
						v16337.CFrame = v16338 * l_Angles_41(v16343, v16346, (math.rad((v16347:NextNumber(v16344, v16342)))));
						l_v3_31:Create(l_v16274_0, v16336, v16337):Play();
						delay(v16333, function()
							v16274:Destroy();
						end);
					end);
				end;
			end;
			if not v898.SuperSerious or v16264 % 2 == 0 then
				task.wait();
			end;
		end;
	end,

	['BezierTween'] = function(v898)
		if not Bezier then
			Bezier = require(l_LegacyReplication_0.Bezier);
		end;
		if v898.Root then
			local l_CFrameValue_7 = Instance.new("CFrameValue");
			l_CFrameValue_7.Value = v898.Root.CFrame;
			Bezier.new(unpack(v898.New)):CreateCFrameTween(l_CFrameValue_7, {
				"Value"
			}, TweenInfo.new(v898.Time, Enum.EasingStyle.Linear)):Play();
			v5({
				Effect = "Tween Root", 
				Root = v898.Root, 
				Given = l_CFrameValue_7, 
				RS = true, 
				LookAt = true, 
				CFrame = CFrame.new(v898.New[3], v898.New[1]), 
				Time = v898.Time
			});
			return ;
		else
			Bezier.new(unpack(v898.New)):CreateCFrameTween(v898.Part, {
				"CFrame"
			}, TweenInfo.new(v898.Time, Enum.EasingStyle.Linear)):Play();
		end;
	end,

	['Menacing'] = function(v898)
		local v15815 = {};
		local l_Character_4 = LocalPlayer.Character;
		for v15816 = 1, v898.Time do
			local v15817 = 0.9;
			local v15818 = 1.1;
			local l_v82_420 = v82;
			if not v15818 and v15817 then
				v15818 = v15817;
				v15817 = 1;
			end;
			if not v15818 and not v15817 then
				v15817 = 0;
				v15818 = 1;
			end;
			local v15820 = l_v82_420:NextNumber(v15817, v15818);
			v15817 = l_LegacyReplication_0.Menacing:Clone();
			v15817.Enabled = true;
			v15817.Size = UDim2.new(v15820, 0, v15820, 0);
			local v15821 = -4;
			local v15822 = 4;
			local l_v82_421 = v82;
			if not v15822 and v15821 then
				v15822 = v15821;
				v15821 = 1;
			end;
			if not v15822 and not v15821 then
				v15821 = 0;
				v15822 = 1;
			end;
			l_v82_420 = l_v82_421:NextNumber(v15821, v15822);
			v15822 = 0;
			l_v82_421 = 4;
			local l_v82_422 = v82;
			if not l_v82_421 and v15822 then
				l_v82_421 = v15822;
				v15822 = 1;
			end;
			if not l_v82_421 and not v15822 then
				v15822 = 0;
				l_v82_421 = 1;
			end;
			v15817.StudsOffsetWorldSpace = Vector3.new(l_v82_420, l_v82_422:NextNumber(v15822, l_v82_421), v89(-4, 4));
			v15817.Parent = l_Character_4.HumanoidRootPart;
			table.insert(v15815, v15817);
			task.delay(v15816, function()
				if v15817.Parent then
					table.remove(v15815, table.find(v15815, v15817));
					v3:Create(v15817, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
						StudsOffsetWorldSpace = v15817.StudsOffsetWorldSpace - Vector3.new(0, 10, 0, 0)
					}):Play();
					v3:Create(v15817.ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						ImageTransparency = 1
					}):Play();
				end;
			end);
		end;
		local v15825 = {};
		while wait() do
			for _, v15827 in pairs(v15815) do
				if not v15825[v15827] then
					v15825[v15827] = v15827.StudsOffsetWorldSpace;
				end;
				local v15828 = v15825[v15827];
				local v15829 = -0.04;
				local v15830 = 0.04;
				local l_v82_423 = v82;
				if not v15830 and v15829 then
					v15830 = v15829;
					v15829 = 1;
				end;
				if not v15830 and not v15829 then
					v15829 = 0;
					v15830 = 1;
				end;
				local v15832 = l_v82_423:NextNumber(v15829, v15830);
				v15830 = -0.04;
				l_v82_423 = 0.04;
				local l_v82_424 = v82;
				if not l_v82_423 and v15830 then
					l_v82_423 = v15830;
					v15830 = 1;
				end;
				if not l_v82_423 and not v15830 then
					v15830 = 0;
					l_v82_423 = 1;
				end;
				v15827.StudsOffsetWorldSpace = v15828 + Vector3.new(v15832, l_v82_424:NextNumber(v15830, l_v82_423), v89(-0.04, 0.04));
			end;
			if not v898.Folder or not v898.Folder.Parent then
				for _, v15835 in pairs(v15815) do
					local v15836 = 2;
					local v15837 = 3;
					local l_v82_425 = v82;
					if not v15837 and v15836 then
						v15837 = v15836;
						v15836 = 1;
					end;
					if not v15837 and not v15836 then
						v15836 = 0;
						v15837 = 1;
					end;
					local v15839 = l_v82_425:NextNumber(v15836, v15837);
					v3:Create(v15835, TweenInfo.new(v15839, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
						StudsOffsetWorldSpace = v15825[v15835] - Vector3.new(0, 10, 0, 0)
					}):Play();
					v3:Create(v15835.ImageLabel, TweenInfo.new(v15839, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						ImageTransparency = 1
					}):Play();
				end;
				task.delay(3, function()
					for _, v15841 in pairs(v15815) do
						v15841:Destroy();
					end;
				end);
				break;
			end;
		end;
	end,

	['Death Punch Music'] = function(Params)
		local Stage = Params.Stage

		if Stage == 'Start' then
			if LocalPlayer.Configuration['Awakening Music'].Value == true then
				Assets.Sounds.DeathPunch.Music.Volume = 5
				Assets.Sounds.DeathPunch.Music:Play()
			end
			return
		end
	end,

	['Fist Smoke'] = function(v898)
		local Character = v898.Char
		local arm = Character["Right Arm"]
		local RightArm: BasePart = Character['Right Arm']
		local Dur = v898.Dur or 3

		if v898.Heat and v898.Wind then
			warn("Fist Smoke can only have one smoke type specified as true.")
			return
		elseif not v898.Heat and not v898.Wind then
			warn("Fist Smoke must have one smoke type specified as true.")
			return
		end

		if v898.Sound then
			local Sound = script.Misc.Sounds.Heat:Clone()
			Sound.Parent = RightArm
			Sound.Volume = 3
			Sound:Play()
		end

		local Debris = game:GetService("Debris")

		if v898.Wind and not v898.Heat then
			local VFX1 = script.Misc["Fist Smoke"].Smoke.Smoke4:Clone()
			local VFX2 = script.Misc["Fist Smoke"].Smoke.Smoke5:Clone()

			VFX1.Parent = arm
			VFX2.Parent = arm
			VFX1.Enabled = true
			VFX2.Enabled = true

			Debris:AddItem(VFX1, Dur + 0.6)
			Debris:AddItem(VFX2, Dur + 0.6)

			task.delay(Dur, function()
				VFX1.Enabled = false
				VFX2.Enabled = false
			end)
		end

		if v898.Heat and not v898.Wind then
			local VFX1 = script.Misc["Fist Smoke"].Smoke.Smoke4:Clone()
			local VFX2 = script.Misc["Fist Smoke"].Smoke.Smoke5:Clone()

			local Sound = script.Misc.Sounds.Heat:Clone()
			Sound.Parent = VFX1
			Sound.Volume = 3
			Sound:Play()

			VFX1.Parent = arm
			VFX2.Parent = arm
			VFX1.Enabled = true
			VFX2.Enabled = true

			Debris:AddItem(VFX1, Dur + 0.6)
			Debris:AddItem(VFX2, Dur + 0.6)

			task.delay(Dur, function()
				VFX1.Enabled = false
				VFX2.Enabled = false
			end)
		end
	end,

	['Death Punch Face'] = function(Params)
		local Character = Params.Char

		if Character ~= LocalCharacter then
			local Head = Params.Head
			local HeadVFX = script.Saitama.DEATH.HeadEffect:Clone();
			HeadVFX.Parent = Head
			HeadVFX.CFrame = Head.CFrame
			local weld = HeadVFX.Weld
			weld.Part0 = Head
			Debris:AddItem(HeadVFX, 8.13)
			local Face = Head
			Face.Transparency = 0
			task.delay(8.13, function()
				Face.Transparency = 0
			end)
		end
	end,

	['Death Punch'] = function(v898)
		shared.repfire('Whiteout', { 
			Wait = 0.05
		});
		local l_CurrentCamera_25 = workspace.CurrentCamera;
		local l_caller_0 = v898.Caller;
		local v15802 = CFrame.new(3.15377903, 2.39878464, -4.55020094, -0.905365765, -0.06841214, 0.419085562, -0, 0.986936748, 0.161108986, -0.424632668, 0.145862564, -0.893538713);
		local l_Root_16 = v898.Root;
		local v15805 = 1;

		l_CurrentCamera_25.CameraType = Enum.CameraType.Scriptable;

		local duration = 4.5
		local startTime = tick()

		local stopEffect
		stopEffect = v610(function(stop)
			local elapsedTime = tick() - startTime

			local success, l_Death_0 = pcall(function()
				return l_LocalPlayer_0.PlayerGui:FindFirstChild("Death")
			end)

			if not success or 
				not ((not l_Death_0 or not l_Death_0:GetAttribute("Wow")) and l_Root_16.Parent and l_Root_16.Parent.Parent) or 
				not l_caller_0.Parent then

				stopEffect()
				l_CurrentCamera_25.CameraType = Enum.CameraType.Custom

				if l_Death_0 then
					l_Death_0:Destroy()
				end
				return
			end

			local v15811 = 0.08 * math.sin(tick() * math.pi / 2)
			l_CurrentCamera_25.CFrame = l_CurrentCamera_25.CFrame:lerp(
				l_Root_16.CFrame * (v15802 + v15802.LookVector * v15805) 
					* CFrame.new(2.12 + v15811, -0.85 - v15811 * 1, 3.35 + v15811 / 2.5)
					* CFrame.Angles(math.rad(-v15811 * 7), math.rad(v15811 * 6 + 5), math.rad(-v15811 * 3)), 
				0.1
			)

			v15805 = v15805 + 0.009
			v15805 = math.clamp(v15805, 0, 10)

			if elapsedTime >= duration then
				stopEffect()
				l_CurrentCamera_25.CameraType = Enum.CameraType.Custom
			end
		end, 75)
	end,

	['Death Screen Sound'] = function(Params)
		local Stage = Params.Stage
		local Char: Model = Params.Char

		if Stage == 'Start' then
			Assets.Sounds.DeathSound.Sound.Volume = 10
			Assets.Sounds.DeathSound.Sound:Play()
			return
		end
	end,

	['Death Screen'] = function(v898)
		if workspace.CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
			return ;
		else
			local v902 = l_LegacyReplication_0.Death:Clone();
			v902.Parent = l_LocalPlayer_0.PlayerGui;
			local l_ObjectValue_1 = Instance.new("ObjectValue");
			l_ObjectValue_1.Name = "Object";
			l_ObjectValue_1.Parent = v902.Image.LocalScript;
			v902.Image.LocalScript.Enabled = true;
			game:service("Debris"):AddItem(v902, 10);
			local v903 = v902.Image
			v903.BackgroundTransparency = 0
			v903.ImageTransparency = 1
			TS:Create(v903,TweenInfo.new(1,Enum.EasingStyle.Sine),{ImageTransparency = 0}):Play()
		end;
	end,

	['Death Screen 1.5'] = function(v898)
		if workspace.CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
			return ;
		else
			local v15862 = shared.sfx({
				SoundId = "rbxassetid://136141631938713", 
				Parent = workspace, 
				Volume = 3
			});
			v15862:Play();
			local v15863 = shared.sfx({
				SoundId = "rbxassetid://98840185257323", 
				Parent = workspace, 
				Volume = 3
			});
			v15863:Play();
			local v902 = l_LegacyReplication_0.Black:Clone();
			local v903 = v902.Image
			v902.Parent = l_LocalPlayer_0.PlayerGui;
			local l_ObjectValue_1 = Instance.new("ObjectValue");
			l_ObjectValue_1.Name = "Object";
			l_ObjectValue_1.Parent = v902.Image.LocalScript;
			v902.Image.LocalScript.Enabled = true;
			game:service("Debris"):AddItem(v902, 3);
			v903.BackgroundTransparency = 1
			TS:Create(v903,TweenInfo.new(3.1,Enum.EasingStyle.Exponential, Enum.EasingDirection.In),{BackgroundTransparency = 0}):Play()
		end;
	end,

	['Death Screen 2'] = function(v898)
		local l_Character_4 = LocalPlayer.Character;
		local l_Death_1 = l_LocalPlayer_0.PlayerGui:FindFirstChild("Death");
		if l_Death_1 then
			v898.User.Archivable = true;
			local v15843 = workspace.Cutscenes["Death Cutscene"];
			local v15844 = shared.shadoffset or v15843.Fist.CFrame:ToObjectSpace(v15843.Shadow.CFrame);
			if not shared.shadoffset then
				shared.shadoffset = v15844;
			end;
			local v15845 = v898.User:Clone();
			for _, v15847 in pairs(v15845:GetChildren()) do
				if not ((not v15847:IsA("BasePart") or v15847.Name == "Head") and not v15847:IsA("Script") and not v15847:IsA("LocalScript")) or v15847:IsA("Highlight") then
					v15847:Destroy();
				elseif v15847:IsA("Accessory") and v15847:FindFirstChild("Handle") and not v15847.Handle:FindFirstChild("HairAttachment") then
					v15847:Destroy();
				end;
			end;
			v15845 = v15845.Head;
			local v15848 = {};
			local v15849 = {};
			local l_Size_15 = l_LegacyReplication_0.Eye.Size;
			for v15851 = 1, 2 do
				local v15852 = l_LegacyReplication_0.Eye:Clone();
				local l_Weld_60 = Instance.new("Weld");
				l_Weld_60.Part0 = v15845;
				l_Weld_60.Part1 = v15852;
				l_Weld_60.C0 = CFrame.new((v15851 == 2 and -1 or 1) * 0.32, 0.15, -0.525);
				l_Weld_60.Parent = v15852;
				v15852.Anchored = false;
				v15852.CanCollide = false;
				v15852.Parent = v15845;
				v15852.Name = "Eye";
				table.insert(v15848, v15852);
			end;
			shared.resizemodel(v15845.Parent, 8);
			l_Size_15 = v15848[1].Size;
			v15845.Parent.PrimaryPart = v15845;
			v15845.Parent:SetPrimaryPartCFrame(v15843.HeadCFrame.CFrame);
			v15845.Anchored = true;
			local l_Highlight_10 = Instance.new("Highlight");
			l_Highlight_10.FillColor = Color3.new(0, 0, 0);
			l_Highlight_10.FillTransparency = 0.4;
			l_Highlight_10.OutlineTransparency = 1;
			l_Highlight_10.DepthMode = "Occluded";
			l_Highlight_10.Parent = v15845.Parent;
			local l_face_0 = v15845:FindFirstChild("face");
			if l_face_0 then
				l_face_0:Destroy();
			end;
			v15845.Parent.Parent = workspace.Thrown;
			for _, v15857 in pairs(v15845.Parent:GetDescendants()) do
				if v15857:IsA("BasePart") and v15857.Name ~= "Eye" then
					v15857.Transparency = 1;
				end;
			end;
			for _, v15859 in pairs(v15848) do
				v15859.Parent = workspace.Thrown;
			end;
			local v15860 = l_LegacyReplication_0.HeavyVi:Clone();
			v15860.Parent = l_LocalPlayer_0.PlayerGui;
			local l_CurrentCamera_26 = workspace.CurrentCamera;
			l_CurrentCamera_26.CameraType = Enum.CameraType.Scriptable;
			l_CurrentCamera_26.CFrame = v15843.Camm.CFrame;
			local v15862 = shared.sfx({
				SoundId = "rbxassetid://137559642057695", 
				Parent = workspace, 
				Volume = 5
			});
			v15862:Play();
			local v15863 = nil;
			v15863 = v15843.Fist:GetPropertyChangedSignal("CFrame"):Connect(function()
				v15843.Shadow.CFrame = v15843.Fist.CFrame * v15844;
			end);
			task.delay(1.1, function()
				v15843.Fist.Attachment.Effect:Emit(5);
			end);
			local l_Fist_1 = v15843.Fist;
			local v15865 = 0;
			local l_CFrame_77 = l_Fist_1.CFrame;
			local v15867 = 500;
			local v15868 = l_Fist_1.CFrame + l_Fist_1.CFrame.lookVector * 15;
			local v15869 = {};
			for _, v15871 in pairs(v15843:GetChildren()) do
				if not (v15871.Name ~= "Beam") or v15871.Name == "CamOp" then
					table.insert(v15869, v15871);
				end;
			end;
			local l_CFrame_78 = l_Fist_1.CFrame;
			local v15873 = {};
			for _, v15875 in pairs(v15869) do
				v15873[v15875] = {
					l_CFrame_78 * v15868:toObjectSpace(v15875.CFrame), 
					v15875.CFrame
				};
				v15875.CFrame = v15873[v15875][1];
			end;
			local _ = tick();
			local v15877 = nil;
			do
				local l_v15845_0, l_l_Size_15_0, l_v15863_0, l_v15865_0, l_v15867_0, l_v15877_0 = v15845, l_Size_15, v15863, v15865, v15867, v15877;
				l_v15877_0 = v610(function()
					local l_l_Fist_1_0 = l_Fist_1;
					local l_CFrame_79 = l_Fist_1.CFrame;
					local l_l_CFrame_77_0 = l_CFrame_77;
					local l_new_88 = CFrame.new;
					local v15888 = -0.21;
					local v15889 = 0.21;
					local l_v82_426 = v82;
					if not v15889 and v15888 then
						v15889 = v15888;
						v15888 = 1;
					end;
					if not v15889 and not v15888 then
						v15888 = 0;
						v15889 = 1;
					end;
					local v15891 = l_v82_426:NextNumber(v15888, v15889);
					v15889 = -0.21;
					l_v82_426 = 0.21;
					local l_v82_427 = v82;
					if not l_v82_426 and v15889 then
						l_v82_426 = v15889;
						v15889 = 1;
					end;
					if not l_v82_426 and not v15889 then
						v15889 = 0;
						l_v82_426 = 1;
					end;
					local v15893 = l_l_CFrame_77_0 * l_new_88(v15891, l_v82_427:NextNumber(v15889, l_v82_426), v89(-0.21, 0.21));
					l_l_CFrame_77_0 = CFrame.Angles;
					v15888 = -3;
					v15889 = 3;
					l_v82_426 = v82;
					if not v15889 and v15888 then
						v15889 = v15888;
						v15888 = 1;
					end;
					if not v15889 and not v15888 then
						v15888 = 0;
						v15889 = 1;
					end;
					l_new_88 = math.rad((l_v82_426:NextNumber(v15888, v15889)));
					v15889 = -3;
					l_v82_426 = 3;
					l_v82_427 = v82;
					if not l_v82_426 and v15889 then
						l_v82_426 = v15889;
						v15889 = 1;
					end;
					if not l_v82_426 and not v15889 then
						v15889 = 0;
						l_v82_426 = 1;
					end;
					v15891 = math.rad((l_v82_427:NextNumber(v15889, l_v82_426)));
					l_v82_426 = -3;
					l_v82_427 = 3;
					local l_v82_428 = v82;
					if not l_v82_427 and l_v82_426 then
						l_v82_427 = l_v82_426;
						l_v82_426 = 1;
					end;
					if not l_v82_427 and not l_v82_426 then
						l_v82_426 = 0;
						l_v82_427 = 1;
					end;
					l_l_Fist_1_0.CFrame = l_CFrame_79:lerp(v15893 * l_l_CFrame_77_0(l_new_88, v15891, (math.rad((l_v82_428:NextNumber(l_v82_426, l_v82_427))))) + l_Fist_1.CFrame.lookVector * (0.03 * l_v15865_0), 0.1);
					l_v15865_0 = l_v15865_0 + 1 * l_v15867_0;
					l_v15867_0 = math.clamp(l_v15867_0 * 1.0E-8, 1, 100);
					for _, v15896 in pairs(v15869) do
						v15896.CFrame = v15896.CFrame:lerp(v15873[v15896][2], 0.1);
					end;
					l_l_Fist_1_0 = l_CurrentCamera_26;
					l_CFrame_79 = l_CurrentCamera_26.CFrame;
					v15893 = v15843.Camm.CFrame;
					l_l_CFrame_77_0 = CFrame.new;
					v15891 = -0.21;
					v15888 = 0.21;
					v15889 = v82;
					if not v15888 and v15891 then
						v15888 = v15891;
						v15891 = 1;
					end;
					if not v15888 and not v15891 then
						v15891 = 0;
						v15888 = 1;
					end;
					l_new_88 = v15889:NextNumber(v15891, v15888);
					v15888 = -0.21;
					v15889 = 0.21;
					l_v82_426 = v82;
					if not v15889 and v15888 then
						v15889 = v15888;
						v15888 = 1;
					end;
					if not v15889 and not v15888 then
						v15888 = 0;
						v15889 = 1;
					end;
					local v15897 = v15893 * l_l_CFrame_77_0(l_new_88, l_v82_426:NextNumber(v15888, v15889), v89(-0.21, 0.21));
					v15893 = CFrame.Angles;
					v15891 = -3;
					v15888 = 3;
					v15889 = v82;
					if not v15888 and v15891 then
						v15888 = v15891;
						v15891 = 1;
					end;
					if not v15888 and not v15891 then
						v15891 = 0;
						v15888 = 1;
					end;
					l_l_CFrame_77_0 = math.rad((v15889:NextNumber(v15891, v15888)));
					v15888 = -3;
					v15889 = 3;
					l_v82_426 = v82;
					if not v15889 and v15888 then
						v15889 = v15888;
						v15888 = 1;
					end;
					if not v15889 and not v15888 then
						v15888 = 0;
						v15889 = 1;
					end;
					l_new_88 = math.rad((l_v82_426:NextNumber(v15888, v15889)));
					v15889 = -3;
					l_v82_426 = 3;
					l_v82_427 = v82;
					if not l_v82_426 and v15889 then
						l_v82_426 = v15889;
						v15889 = 1;
					end;
					if not l_v82_426 and not v15889 then
						v15889 = 0;
						l_v82_426 = 1;
					end;
					l_l_Fist_1_0.CFrame = l_CFrame_79:lerp(v15897 * v15893(l_l_CFrame_77_0, l_new_88, (math.rad((l_v82_427:NextNumber(v15889, l_v82_426))))), 0.1);
					for _, v15899 in pairs(v15848) do
						if not v15849[v15899] then
							v15849[v15899] = v15899.CFrame;
						end;
						v15893 = v15899:FindFirstChild("Weld");
						if v15893 then
							v15893:Destroy();
							v15899.Anchored = true;
						end;
						l_l_CFrame_77_0 = v15899.Size;
						v15888 = l_l_Size_15_0;
						l_v82_427 = -1;
						l_v82_428 = 1;
						local l_v82_429 = v82;
						if not l_v82_428 and l_v82_427 then
							l_v82_428 = l_v82_427;
							l_v82_427 = 1;
						end;
						if not l_v82_428 and not l_v82_427 then
							l_v82_427 = 0;
							l_v82_428 = 1;
						end;
						l_v82_426 = l_v82_429:NextNumber(l_v82_427, l_v82_428);
						l_v82_428 = -0.4;
						l_v82_429 = 0.4;
						local l_v82_430 = v82;
						if not l_v82_429 and l_v82_428 then
							l_v82_429 = l_v82_428;
							l_v82_428 = 1;
						end;
						if not l_v82_429 and not l_v82_428 then
							l_v82_428 = 0;
							l_v82_429 = 1;
						end;
						v15899.Size = l_l_CFrame_77_0:lerp(v15888 + Vector3.new(l_v82_426, l_v82_430:NextNumber(l_v82_428, l_v82_429), v89(-0.7, 0.7)), 0.1);
						l_l_CFrame_77_0 = v15899.CFrame;
						v15888 = v15849[v15899];
						v15889 = CFrame.new;
						l_v82_427 = -0.15;
						l_v82_428 = 0.15;
						l_v82_429 = v82;
						if not l_v82_428 and l_v82_427 then
							l_v82_428 = l_v82_427;
							l_v82_427 = 1;
						end;
						if not l_v82_428 and not l_v82_427 then
							l_v82_427 = 0;
							l_v82_428 = 1;
						end;
						l_v82_426 = l_v82_429:NextNumber(l_v82_427, l_v82_428);
						l_v82_428 = -0.2;
						l_v82_429 = 0.2;
						l_v82_430 = v82;
						if not l_v82_429 and l_v82_428 then
							l_v82_429 = l_v82_428;
							l_v82_428 = 1;
						end;
						if not l_v82_429 and not l_v82_428 then
							l_v82_428 = 0;
							l_v82_429 = 1;
						end;
						v15899.CFrame = l_l_CFrame_77_0:lerp(v15888 * v15889(l_v82_426, l_v82_430:NextNumber(l_v82_428, l_v82_429), v89(-0.21, 0.212)), 0.1);
					end;
					task.wait();
				end, 60);
				task.delay(3, function()
					v3:Create(v15862, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Volume = 0
					}):Play();
					v15860:Destroy();
					pcall(function()
						if v898.User == l_Character_4 then
							l_CurrentCamera_26.CFrame = l_Character_4.HumanoidRootPart.CFrame * CFrame.new(1.2280345, 6.04459286, 11.6758347, 0.994513273, -0.0359407216, 0.0982427597, -8.45415471E-8, 0.939127922, 0.343567461, -0.1046106, -0.341682404, 0.93397516);
						end;
					end);
					l_v15863_0:Disconnect();
					l_CurrentCamera_26.CameraType = Enum.CameraType.Custom;
					l_v15877_0();
					l_Fist_1.CFrame = l_CFrame_77;
					for v15902, v15903 in pairs(v15873) do
						v15902.CFrame = v15903[2];
					end;
					if l_v15845_0 and l_v15845_0.Parent then
						l_v15845_0.Parent:Destroy();
					end;
					for _, v15905 in pairs(v15848) do
						v15905:Destroy();
					end;
				end);
				l_Death_1:Destroy();
			end;
		end;
	end,

	['Ground Crater'] = function(v898)
		if typeof(v898.start) == "Instance" then
			if v898.start:IsA("Attachment") then
				v898.start = v898.start.WorldPosition;
			else
				v898.start = v898.start.Position;
			end;
		end;
		local v16348 = Random.new(v898.Seed);
		local l_v89_4 = v89;
		local function _(v16350, v16351)
			return l_v89_4(v16350, v16351, nil, v16348);
		end;
		local v16353, v16354, _, v16356 = v556({
			orig = v898.start, 
			dir = v898["end"]
		});
		if v898.Sound then
			v898.Sound.CFrame = CFrame.new(v16354);
			shared.sfx(v898.Sound):Play();
		end;
		if v16353 then
			local v16357 = v254(CFrame.new(v16354).UpVector, v16356, (Vector3.new(0, 1, 0, 0)));
			local l_Attachment_15 = Instance.new("Attachment");
			l_Attachment_15.Parent = v16353;
			if not v16353.Anchored then
				l_Attachment_15.Parent = workspace.Terrain;
			end;
			l_Attachment_15.WorldCFrame = CFrame.new(v16354) * v16357;
			if not v898.nosmoke then
				local v16359 = 8;
				if l_LocalPlayer_0:GetAttribute("S_FastMode") then
					v16359 = v16359 / 2;
				end;
				local v16360 = -0.001;
				local v16361 = 0.001;
				local v16362 = v16348 or v82;
				if not v16361 and v16360 then
					v16361 = v16360;
					v16360 = 1;
				end;
				if not v16361 and not v16360 then
					v16360 = 0;
					v16361 = 1;
				end;
				local v16363 = v16362:NextNumber(v16360, v16361);
				v16360 = game.ReplicatedStorage.Resources.Smoke:Clone();
				v16360.Parent = l_Attachment_15;
				v16360.ZOffset = v16360.ZOffset + v16363;
				v16360.Color = ColorSequence.new(v16353.Color);
				if v898.stronger then
					shared.resizeparticle(v16360, v898.stronger.size1 or 4.2);
					v16360.Speed = NumberRange.new(v16360.Speed.Min * (4.5 - (v898.stronger.minus or 0)), v16360.Speed.Max * (4.5 - (v898.stronger.minus or 0)));
					v16360.Lifetime = NumberRange.new(v16360.Lifetime.Min * 2, v16360.Lifetime.Max * 2);
					v16360.RotSpeed = NumberRange.new(v16360.RotSpeed.Min * 0.35, v16360.RotSpeed.Max * 0.35);
				else
					shared.resizeparticle(v16360, 1.25);
					if v898.CloserCircle then
						v16360.Speed = NumberRange.new(25, 50);
						shared.resizeparticle(v16360, 0.7);
						v16359 = v16359 / 1.5;
					end;
					if v898.Closerr then
						shared.resizeparticle(v16360, 0.55);
						v16360.Speed = NumberRange.new(7, 25);
					end;
				end;
				if not v898.NoCircleSmoke then
					v16360:Emit(v16359);
				end;
				v16361 = 8;
				if l_LocalPlayer_0:GetAttribute("S_FastMode") then
					v16361 = v16361 / 2;
				end;
				v16362 = game.ReplicatedStorage.Resources.UpSmoke:Clone();
				v16362.Parent = l_Attachment_15;
				v16362.ZOffset = v16362.ZOffset + v16363;
				v16362.Color = ColorSequence.new(v16353.Color);
				if v898.stronger then
					shared.resizeparticle(v16362, v898.stronger.size2 or 4.2);
					v16362.Speed = v898.speed1 or NumberRange.new(v16362.Speed.Min * (4.5 - (v898.stronger.minus or 0)), v16362.Speed.Max * (4.5 - (v898.stronger.minus or 0)));
					v16362.Lifetime = NumberRange.new(v16362.Lifetime.Min * 2, v16362.Lifetime.Max * 2);
					v16362.RotSpeed = NumberRange.new(v16362.RotSpeed.Min * 0.35, v16362.RotSpeed.Max * 0.35);
				else
					shared.resizeparticle(v16362, 1.25);
					if v898.Closerr then
						shared.resizeparticle(v16362, 0.3);
						v16361 = v16361 / 1.5;
						v16362.Speed = NumberRange.new(20, 35);
					end;
				end;
				shared.resizeparticle(v16362, 1.25);
				if not v898.NoUpSmoke then
					v16362:Emit(v16361);
				end;
			end;
			game:GetService("Debris"):AddItem(l_Attachment_15, 9);
			local v16364 = false;
			if not (v16353.Material ~= Enum.Material.Sand) or v16353.Material == Enum.Material.Snow then
				v16364 = true;
			end;
			if not v898.NoCrater2 then
				v356({
					ground = v16353, 
					cframe = CFrame.new(v16354), 
					amount = (v898.amount or v16364 and 7 or 10) / 1.25, 
					normal = v16356, 
					sand = v16364 and true or nil, 
					add = {
						sounds = true
					}, 
					sizemult = v898.sizemult, 
					new = {
						5 * (v898.size or 1), 
						5.5 * (v898.size or 1)
					}, 
					nosound = v898.nosound, 
					angle = v898.angle, 
					anglecfr = v898.anglecfr, 
					nodebris = v898.nodebris, 
					notiles = v898.notiles, 
					Seed = v898.Seed
				});
			end;
			return ;
		end;
	end,

	['BreakJoints'] = function(v898)
		local l_Name_2 = v898.Name;
		local l_Hit_9 = v898.Hit;
		local v16130 = game.ReplicatedStorage.Clones:FindFirstChild(l_Name_2) or workspace.Thrown:FindFirstChild(l_Name_2);
		if not (v16130 and l_Name_2 ~= l_LocalPlayer_0.Name and l_Hit_9.Parent) or not l_Hit_9.Parent.Parent then
			return ;
		else
			do
				local l_l_Hit_9_0, l_v16130_0 = l_Hit_9, v16130;
				if l_LocalPlayer_0.Character ~= l_l_Hit_9_0 then
					l_v16130_0 = l_v16130_0:Clone();
					task.delay(3.25, function()
						l_v16130_0:Destroy();
					end);
					l_v16130_0.Humanoid.Health = 0;
					local l_CFrame_85 = l_l_Hit_9_0.Torso.CFrame;
					l_v16130_0:SetPrimaryPartCFrame(l_CFrame_85);
					local l_l_l_Hit_9_0_FirstChild_0 = l_l_Hit_9_0:FindFirstChild("AtmosCleaveFinisherSFX", true);
					if l_l_l_Hit_9_0_FirstChild_0 then
						l_l_l_Hit_9_0_FirstChild_0.Parent = l_v16130_0.Torso;
					end;
					local v16135 = {};
					l_CFrame_85 = l_l_Hit_9_0;
					for _, v16137 in pairs(l_l_Hit_9_0:GetDescendants()) do
						if v16137:IsA("BasePart") then
							if v16137.Transparency < 1 then
								table.insert(v16135, v16137);
							end;
							v16137.Transparency = 1;
							v16137.CanCollide = false;
							v16137.CollisionGroup = "nocol";
							if v16137.Name == "Head" then
								task.spawn(function()
									local v16138 = tick();
									local l_Head_4 = l_v16130_0.Head;
									while true do
										if task.wait() then
											if tick() - v16138 < 5 then
												v16137.CFrame = l_Head_4.CFrame;
											else
												task.delay(3, function()
													if l_CFrame_85.Parent then
														local l_PlayerFromCharacter_0 = game.Players:GetPlayerFromCharacter(l_CFrame_85);
														if l_PlayerFromCharacter_0 and (l_PlayerFromCharacter_0:GetAttribute("DiedTime") or 0) >= 2 then
															return ;
														else
															for _, v16142 in pairs(v16135) do
																v16142.Transparency = 0;
															end;
														end;
													end;
												end);
												return ;
											end;
										else
											return ;
										end;
									end;
								end);
							end;
						end;
					end;
					l_v16130_0.Parent = workspace.Thrown;
					l_l_Hit_9_0 = l_v16130_0;
					for _, v16144 in pairs(l_l_Hit_9_0:GetDescendants()) do
						if v16144:IsA("BasePart") then
							v16144.Anchored = false;
							task.delay(0.03, function()
								if v16144.Name:find("Leg") or v16144.Name:find("Arm") then
									local l_Part_28 = Instance.new("Part");
									l_Part_28.Anchored = false;
									l_Part_28.Size = v16144.Size * 0.7;
									l_Part_28.CFrame = v16144.CFrame;
									l_Part_28.Transparency = 1;
									l_Part_28.Name = "coll";
									l_Part_28.CollisionGroup = "nocol";
									v16144.CollisionGroup = "playercol";
									local l_Weld_63 = Instance.new("Weld");
									l_Weld_63.Part0 = v16144;
									l_Weld_63.Name = "notit";
									l_Weld_63.Part1 = l_Part_28;
									l_Weld_63.Parent = v16144;
									l_Part_28.Parent = l_l_Hit_9_0;
								end;
							end);
							if v16144.Transparency < 1 then
								v16144.CanCollide = true;
							end;
						end;
					end;
					for _, v16148 in pairs(l_l_Hit_9_0:GetDescendants()) do
						if v16148:IsA("BallSocketConstraint") then
							v16148:Destroy();
						end;
					end;
					l_l_Hit_9_0:BreakJoints();
					for _, v16150 in pairs(l_l_Hit_9_0:GetDescendants()) do
						if v16150:IsA("BallSocketConstraint") or v16150:IsA("Weld") then
							v16150:Destroy();
						end;
					end;
				else
					l_v16130_0 = l_l_Hit_9_0;
				end;
				for _, v16152 in pairs(l_v16130_0:GetChildren()) do
					if v16152:IsA("Part") and v16152.Name ~= "coll" then
						local v16153 = v16152.Name:find("Head") or v16152.Name:find("Leg") or v16152.Name:find("Arm") or v16152.Name == "Torso";
						if v16153 then
							v16152.CanCollide = true;
							v16152.CollisionGroup = "playercol";
						end;
						local l_BodyVelocity_28 = Instance.new("BodyVelocity");
						l_BodyVelocity_28.MaxForce = Vector3.new(1, 1, 1, 0) * 40000;
						local l_LookVector_2 = CFrame.new(v16152.Position, v898.Break).LookVector;
						local v16156 = 50;
						local v16157 = 95;
						local l_v82_446 = v82;
						if not v16157 and v16156 then
							v16157 = v16156;
							v16156 = 1;
						end;
						if not v16157 and not v16156 then
							v16156 = 0;
							v16157 = 1;
						end;
						l_BodyVelocity_28.Velocity = l_LookVector_2 * l_v82_446:NextNumber(v16156, v16157) * (v898.Speed or 1);
						l_BodyVelocity_28.Velocity = l_BodyVelocity_28.Velocity * Vector3.new(1, 0, 1, 0);
						local l_Velocity_2 = l_BodyVelocity_28.Velocity;
						l_LookVector_2 = 0;
						local l_Add_0 = v898.Add;
						if not l_Add_0 then
							v16156 = 35;
							v16157 = 50;
							l_v82_446 = v82;
							if not v16157 and v16156 then
								v16157 = v16156;
								v16156 = 1;
							end;
							if not v16157 and not v16156 then
								v16156 = 0;
								v16157 = 1;
							end;
							l_Add_0 = l_v82_446:NextNumber(v16156, v16157);
						end;
						l_BodyVelocity_28.Velocity = l_Velocity_2 + Vector3.new(l_LookVector_2, l_Add_0, 0);
						if v16152.Name == "Head" and v898.KeepHead then
							l_BodyVelocity_28.Velocity = Vector3.new();
						end;
						if not v16152.Name:find("Leg") or not v898.KeepLegs then
							l_BodyVelocity_28.Parent = v16152;
							game:GetService("Debris"):AddItem(l_BodyVelocity_28, 0.15);
						end;
						task.delay(v898.Wait or 0.4, function()
							if v16153 then
								local v16161 = tick();
								while true do
									task.wait();
									if not (tick() - v16161 <= 5 and not v556({
										orig = v16152.Position, 
										dir = Vector3.new(0, -2, 0, 0)
										})) then
										break;
									end;
								end;
								if tick() - v16161 > 5 then
									return ;
								else
									v16152.Velocity = Vector3.new();
									if v16152.Name == "Head" then
										shared.sfx({
											SoundId = "rbxassetid://9114483465", 
											Volume = 2, 
											Parent = v16152
										}):Play();
									end;
									shared.sfx({
										SoundId = ({
											"rbxassetid://9113542856", 
											"rbxassetid://9113540448", 
											"rbxassetid://9113540448"
										})[math.random(1, 3)], 
										Parent = v16152, 
										Volume = 0.4
									}):Resume();
									shared.sfx({
										SoundId = ({
											"rbxassetid://11714811219", 
											"rbxassetid://11714811286", 
											"rbxassetid://11714811320"
										})[math.random(1, 3)], 
										Volume = 0.45, 
										Parent = v16152
									}):Play();
								end;
							end;
						end);
					end;
				end;
			end;
		end;
	end,

	CommandCounter = function(Params: { any })
		local Stage = Params.Stage

		if Stage == 'Start' then
			CameraTableAnims:PlayAnimation('Counter', Params.CF)
		elseif Stage == 'TP' then
			local fx = script.Misc.TP.Attachment:Clone()
			fx.Parent = workspace.Terrain
			fx.Position = Params.Pos
			ParticlesModule.Emit(fx)
			Debris:AddItem(fx, .4)
		elseif Stage == 'Desintegrate' then
			local Character: Model = Params.Character

			local Sides = {
				'Top';
				'Bottom';
				'Right';
				'Left';
				'Front';
				'Back';
			}

			local ModelClone = Instance.new('Model')
			ModelClone.Parent = workspace.Thrown
			for _, Part: any in Character:GetDescendants() do
				if (Part:IsA('BasePart') or Part:IsA('Part') or Part:IsA('MeshPart')) and Part.Transparency < 1 then
					local Clone: Part = Part:Clone()
					for _,v in Clone:GetChildren() do
						v:Destroy()
					end
					Clone.Size *= 1.25
					Clone.Massless = true
					Clone.CanCollide = false
					Clone.Transparency = 1
					Clone.Parent = ModelClone
					local Weld = Instance.new('Weld')
					Weld.Part0 = Part
					Weld.Part1 = Clone
					Weld.Parent = Clone

					for i = 1, 6 do
						local Blue = script.Misc.Counter:Clone()
						Blue.Parent = Clone
						Blue.Face = Sides[i]
						TS:Create(Blue, TweenInfo.new(.5, Enum.EasingStyle.Linear), { Transparency = 0 }):Play()
					end

					task.delay(.5, function()
						Part.Transparency = 1
						Weld:Destroy()

						local bodyvelocity = Instance.new('BodyVelocity')
						bodyvelocity.Parent = Clone
						if Clone.Name ~= 'Torso' then
							bodyvelocity.Velocity = -CFrame.lookAt(Clone.Position, Character.Torso.Position).LookVector * math.random(6, 12)
						else
							bodyvelocity.Velocity = Vector3.new(math.random(6, 12), math.random(6, 12), math.random(6, 12))
						end
						TS:Create(Clone, TweenInfo.new(.5), { Size = Vector3.zero }):Play()
					end)
					Debris:AddItem(Clone, 1)
				elseif Part.Name == 'face' then
					TS:Create(Part, TweenInfo.new(.5), { Transparency = 1 }):Play()
				end
			end
		elseif Stage == 'Final' then
			CameraTableAnims:StopAnimations()
			TS:Create(Camera, TweenInfo.new(.5), { FieldOfView = 70; }):Play()
			Camera.CameraSubject = LocalCharacter.Humanoid
			Camera.CameraType = Enum.CameraType.Custom
		end
	end,

	['Circle Smoke'] = function(v898)
		local Character = v898.Char
		local HumRP = Character.HumanoidRootPart

		if v898.Var == true then
			local Smoke = script.Saitama.Awakening.SMOKE.one:Clone()
			Smoke.Parent = HumRP
			ParticlesModule.Emit(Smoke)
			Debris:AddItem(Smoke, 2.1)
		else
			local Smoke = script.Saitama.Awakening.SMOKE.two:Clone()
			Smoke.Parent = HumRP
			ParticlesModule.Emit(Smoke)
			Debris:AddItem(Smoke, 2.1)
		end
	end,

	['Serious Punch Cam'] = function(v898)
		if workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable then
			return ;
		else
			if v898.Char == LocalCharacter then
				local v14515 = {};
				for _, v14517 in pairs(game.ReplicatedStorage.Resources.ImpactFrame:GetChildren()) do
					local v14518 = v14517:Clone();
					v14518.Visible = true;
					v14518.Size = UDim2.new(0, 1, 0, 1);
					v14518.Position = UDim2.new(0, 0, 0, 0);
					v14518.Parent = l_LocalPlayer_0.PlayerGui.ShiftLock;
					table.insert(v14515, v14518);
				end;
				task.delay(5.687, function()
					task.delay(0.045, function()
						shared.addshake(3.5)
					end);
				end);
				local l_v14515_0 = v14515 --[[ copy: 4 -> 76 ]];
				task.delay(10, function()
					for _, v14521 in pairs(l_v14515_0) do
						v14521:Destroy();
					end;
				end);
			end;
			task.delay(0.2, function()
				local v14522 = Instance.new("Sound", LocalCharacter.HumanoidRootPart)
				v14522.SoundId = "rbxassetid://106858447244748"
				v14522.Volume = 2
				v14522.Parent = workspace.Camera
				v14522:Play();
				task.delay(5.9, function()
					v14522.Volume = 2;
					v3:Create(v14522, TweenInfo.new(6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						Volume = 2
					}):Play();
				end);
			end);
			workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
			local l_CurrentCamera_22 = workspace.CurrentCamera;
			local l_Follow_0 = v898.Follow;
			l_Follow_0.CFrame = LocalCharacter:FindFirstChild('HumanoidRootPart').CFrame
			local v14525 = nil;
			for _, v14527 in pairs(l_Follow_0.Parent.AnimationController:GetPlayingAnimationTracks()) do
				if v14527.Animation.AnimationId == "rbxassetid://101507486695287" then
					v14525 = v14527;
				end;
			end;
			local v14528 = tick();
			local v14529 = nil;
			local v14530 = nil;
			do
				local l_v14525_0, l_v14529_0, l_v14530_0 = v14525, v14529, v14530;
				l_v14530_0 = shared.loop(function()
					if l_Follow_0 and l_Follow_0.Parent and l_CurrentCamera_22.CFrame and v898.Char.Parent then
						if l_v14525_0 and not l_v14529_0 and l_v14525_0.TimePosition >= 5.85 and l_v14525_0.TimePosition <= 5.89 then
							l_v14529_0 = true;
							task.spawn(function()
								local v14534 = game.ReplicatedStorage.Resources.ImpactFrame:Clone();
								v14534.Parent = l_LocalPlayer_0.PlayerGui;
								v14534[1].ZIndex = 2;
								v14534[1].Visible = true;
								task.wait(0.046);
								v14534[2].ZIndex = 3;
								v14534[2].Visible = true;
								task.wait(0.046);
								v14534[3].ZIndex = 4;
								v14534[3].Visible = true;
								task.wait(0.046);
								l_Follow_0:Destroy();
								v14534:Destroy();
							end);
						end;
						if tick() - v14528 > 1 then
							l_CurrentCamera_22.CFrame = l_Follow_0.CFrame;
							return ;
						else
							l_CurrentCamera_22.CFrame = l_CurrentCamera_22.CFrame:lerp(l_Follow_0.CFrame, 0.07);
							return ;
						end;
					else
						local l_CFrame_58 = workspace.CurrentCamera.CFrame;
						workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
						workspace.CurrentCamera.CFrame = l_CFrame_58;
						return l_v14530_0();
					end;
				end, 90);
			end;
		end;
	end,

	['Serious Punch'] = function(v898)
		local l_Root_11 = v898.Root;
		local v14537 = game.ReplicatedStorage.Resources.Wind:Clone();
		local l_WindBack_0 = v14537.WindBack;
		l_WindBack_0.Parent = l_Root_11;
		if not l_LocalPlayer_0.Character or l_Root_11 == l_LocalPlayer_0.Character.PrimaryPart then
		end;
		local v14539 = game.ReplicatedStorage.Resources.Sphere:Clone();
		local l_Size_8 = v14539.Size;
		v14539.Anchored = true;
		v14539.Color = Color3.new(1, 1, 1);
		v14539.CanCollide = false;
		v14539.CanQuery = false;
		v14539.Size = v14539.Size * Vector3.new(0, 0, 1.5, 0);
		v14539.CFrame = l_Root_11.CFrame + l_Root_11.CFrame.lookVector * 20;
		v14539.Parent = workspace.Thrown;
		game:GetService("Debris"):AddItem(v14539, 0.5);
		v3:Create(v14539, TweenInfo.new(0.175, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Size = Vector3.new(l_Size_8.X * 2, l_Size_8.Y * 2, v14539.Size.Z + 2000), 
			Transparency = 1, 
			CFrame = v14539.CFrame + v14539.CFrame.LookVector * 1050
		}):Play();
		local v14541 = game.ReplicatedStorage.Resources.Sphere:Clone();
		v14541.Anchored = true;
		v14541.Color = Color3.new(1, 1, 1);
		v14541.CanCollide = false;
		v14541.CanQuery = false;
		v14541.Size = v14541.Size * Vector3.new(0.4000000059604645, 0.4000000059604645, 1, 0);
		v14541.CFrame = l_Root_11.CFrame + l_Root_11.CFrame.lookVector * 20;
		v14541.Parent = workspace.Thrown;
		game:GetService("Debris"):AddItem(v14541, 0.5);
		v3:Create(v14541, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Size = Vector3.new(0, 0, v14541.Size.Z + 1200), 
			CFrame = v14541.CFrame + v14541.CFrame.LookVector * 600
		}):Play();
		local v14542 = {};
		(function(v14543)
			for v14544 = 1, v14543 do
				local v14545 = v14537:Clone();
				v14545.Parent = workspace.Thrown;
				v14545.CFrame = l_Root_11.CFrame + l_Root_11.CFrame.lookVector * (150 * v14544 - 90);
				v14545.CFrame = v14545.CFrame + Vector3.new(0, 37 * v14544, 0);
				v14545.CFrame = CFrame.new(v14545.CFrame.p, (Vector3.new(l_Root_11.CFrame.p.X, v14545.CFrame.p.Y, l_Root_11.CFrame.p.Z))) * CFrame.Angles(1.5707963267948966, 0, 0);
				v14545.Name = v14544;
				for _, v14547 in pairs(v14545:GetChildren()) do
					if v14547.Name == "Right" then
						v14547.Position = v14547.Position + Vector3.new(27 * v14544, 0, 0);
					elseif v14547.Name == "Left" then
						v14547.Position = v14547.Position - Vector3.new(27 * v14544, 0, 0);
					end;
				end;
				for _, v14549 in pairs(v14545:GetDescendants()) do
					if v14549:IsA("ParticleEmitter") then
						v14549.Lifetime = NumberRange.new(v14549.Lifetime.Min + (v14544 + 7), v14549.Lifetime.Max + v14544 + 8);
						shared.resizeparticle(v14549, v14544);
					end;
				end;
				table.insert(v14542, v14545);
			end;
			task.spawn(function()
				shared.repfire('Debris Lines 2', {
					Part = l_Root_11, 
					Times = 8, 
					Spread = 3, 
					Serious = true, 
					SuperSerious = true, 
					Seed = v898.Seed
				});
			end);
			for _, v14551 in pairs(l_WindBack_0:GetDescendants()) do
				if v14551:IsA("ParticleEmitter") then
					v14551:Emit(v14551.Rate);
					v14551.Enabled = true;
					task.delay(1.75, function()
						v14551.Enabled = false;
					end);
				end;
			end;
			for _, v14553 in pairs(v14542) do
				for _, v14555 in pairs(v14553:GetDescendants()) do
					if v14555:IsA("ParticleEmitter") then
						v14555:Emit(v14555.Rate);
					end;
				end;
				task.wait(0.1);
			end;
			task.delay(25, function()
				l_WindBack_0:Destroy();
				for _, v14557 in pairs(v14542) do
					v14557:Destroy();
				end;
			end);
		end)(5);
	end,

	--this is just table flip music dont add anything else
	['Table Flip Cam'] = function(v898)
		local v15798 = shared.sfx({
			SoundId = "rbxassetid://86496800499793", 
			Volume = 0, 
			Parent = workspace.Camera
		});
		v15798:Resume();
		v3:Create(v15798, TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			Volume = 2
		}):Play();
		task.delay(5, function()
			v3:Create(v15798, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Volume = 4
			}):Play();
		end);
		task.delay(11, function()
			v3:Create(v15798, TweenInfo.new(8, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Volume = 0
			}):Play();
			task.delay(8, function()
				v15798:Destroy();
			end);
		end);
	end,

	['Table Flip Time'] = function(v898)
		local l_Root_14 = v898.Root;
		local v15691 = {};
		local HumRP: BasePart = LocalCharacter:FindFirstChild('HumanoidRootPart')	
		local VFX = script.Saitama.Table.Windd.Wind:Clone()
		VFX.Parent = HumRP
		ParticlesModule.Emit(VFX)
		--ParticlesModule.Enabled(VFX, true)
		Debris:AddItem(VFX,1.1)
		--task.wait(0.7)
		--ParticlesModule.Enabled(VFX, false)
		shared.addshake(4);
		task.spawn(function()
			local v15692 = tick();
			local v15693 = 4;
			while true do
				task.wait();
				shared.addshake(v15693);
				v15693 = v15693 * 0.99;
				if not (tick() - v15692 <= 4) then
					break;
				end;
			end;
		end);
		local v15694 = {};
		local v15695 = {};
		for _, v15697 in pairs(v2:GetTagged("tableflip" .. v898.Code)) do
			v15697.CanCollide = false;
			v15697.Anchored = false;
			table.insert(v15695, v15697);
			v15694[v15697] = true;
			local l_BodyVelocity_20 = Instance.new("BodyVelocity");
			l_BodyVelocity_20.MaxForce = Vector3.new(1, 1, 1, 0) * 36000000;
			local v15699 = 0;
			local v15700 = 100;
			local v15701 = 350;
			local l_v82_406 = v82;
			if not v15701 and v15700 then
				v15701 = v15700;
				v15700 = 1;
			end;
			if not v15701 and not v15700 then
				v15700 = 0;
				v15701 = 1;
			end;
			l_BodyVelocity_20.Velocity = Vector3.new(v15699, l_v82_406:NextNumber(v15700, v15701), 0);
			l_BodyVelocity_20.Parent = v15697;
			game:service("Debris"):AddItem(l_BodyVelocity_20, 0.15);
			local l_Attachment_9 = Instance.new("Attachment");
			l_Attachment_9.Parent = v15697;
			v15699 = Instance.new("Attachment");
			v15699.Position = Vector3.new(0, -0.10000000149011612, 0, 0);
			v15699.Parent = v15697;
			local v15704 = l_LegacyReplication_0.TrailTwo:Clone();
			v15704.Parent = v15697;
			v15704.Attachment0 = l_Attachment_9;
			v15704.Attachment1 = v15699;
		end;
		for v15705 = 1, 60 do
			local v15706 = v15705 / 8;
			local v15707 = 5;
			if l_TouchEnabled_1 then
				v15707 = 8;
				v15706 = 0;
			end;
			local l_CFrame_74 = l_Root_14.CFrame;
			local l_new_82 = CFrame.new;
			local v15710 = -3 * v15705 - v15705 * 2;
			local v15711 = 3 * v15705 + v15705 * 2;
			local l_v82_407 = v82;
			if not v15711 and v15710 then
				v15711 = v15710;
				v15710 = 1;
			end;
			if not v15711 and not v15710 then
				v15710 = 0;
				v15711 = 1;
			end;
			local l_p_1 = (l_CFrame_74 * l_new_82(l_v82_407:NextNumber(v15710, v15711), 0, v89(-1 * v15705, 1 * v15705)) + l_Root_14.CFrame.lookVector * (v15705 * 5)).p;
			local v15714;
			v15714, l_CFrame_74 = workspace:FindFirstChildOfClass("Camera"):WorldToScreenPoint(l_p_1);
			if not l_CFrame_74 then
				v15707 = 3;
			end;
			l_CFrame_74 = 1;
			l_new_82 = v15707 + v15706;
			local v15715 = v15707 + 1 + v15706;
			v15710 = v82;
			if not v15715 and l_new_82 then
				v15715 = l_new_82;
				l_new_82 = 1;
			end;
			if not v15715 and not l_new_82 then
				l_new_82 = 0;
				v15715 = 1;
			end;
			for v15716 = l_CFrame_74, v15710:NextInteger(l_new_82, v15715) do
				l_new_82 = v556;
				v15715 = {};
				local l_CFrame_75 = l_Root_14.CFrame;
				local l_new_83 = CFrame.new;
				local v15719 = -3 * v15705 - v15705 * 2;
				local v15720 = 3 * v15705 + v15705 * 2;
				local l_v82_408 = v82;
				if not v15720 and v15719 then
					v15720 = v15719;
					v15719 = 1;
				end;
				if not v15720 and not v15719 then
					v15719 = 0;
					v15720 = 1;
				end;
				v15715.orig = (l_CFrame_75 * l_new_83(l_v82_408:NextNumber(v15719, v15720), 0, v89(-1 * v15705, 1 * v15705)) + l_Root_14.CFrame.lookVector * (v15705 * 5)).p;
				v15715.dir = Vector3.new(0, -10, 0, 0);
				l_new_82, v15715 = l_new_82(v15715);
				if l_new_82 then
					v15711 = (function(v15722)
						local v15723 = v230() or Instance.new("Part");
						v15723.Name = "DebrisggbbTf";
						v15723.Anchored = false;
						v15723.CanCollide = false;
						v15723.Transparency = 0;
						v15723.Massless = false;
						v15694[v15723] = true;
						local v15724 = 3;
						local v15725 = -2;
						local v15726 = 3;
						local l_v82_409 = v82;
						if not v15726 and v15725 then
							v15726 = v15725;
							v15725 = 1;
						end;
						if not v15726 and not v15725 then
							v15725 = 0;
							v15726 = 1;
						end;
						local v15728 = v15724 + l_v82_409:NextNumber(v15725, v15726);
						local v15729 = 3;
						v15726 = -2;
						l_v82_409 = 3;
						local l_v82_410 = v82;
						if not l_v82_409 and v15726 then
							l_v82_409 = v15726;
							v15726 = 1;
						end;
						if not l_v82_409 and not v15726 then
							v15726 = 0;
							l_v82_409 = 1;
						end;
						v15724 = v15729 + l_v82_410:NextNumber(v15726, l_v82_409);
						v15725 = 3;
						l_v82_409 = -4;
						l_v82_410 = 5;
						local l_v82_411 = v82;
						if not l_v82_410 and l_v82_409 then
							l_v82_410 = l_v82_409;
							l_v82_409 = 1;
						end;
						if not l_v82_410 and not l_v82_409 then
							l_v82_409 = 0;
							l_v82_410 = 1;
						end;
						v15723.Size = Vector3.new(v15728, v15724, v15725 + l_v82_411:NextNumber(l_v82_409, l_v82_410)) * 2;
						if v15722 then
							local l_Size_12 = v15723.Size;
							v15728 = 1;
							v15724 = 2;
							v15729 = v82;
							if not v15724 and v15728 then
								v15724 = v15728;
								v15728 = 1;
							end;
							if not v15724 and not v15728 then
								v15728 = 0;
								v15724 = 1;
							end;
							v15723.Size = l_Size_12 * v15729:NextNumber(v15728, v15724);
						end;
						if math.random(1, 3) == 1 then
							local l_Attachment_10 = Instance.new("Attachment");
							l_Attachment_10.Parent = workspace.Terrain;
							l_Attachment_10.WorldPosition = v15715;
							local v15734 = l_LegacyReplication_0.UpSmoke:Clone();
							v15734.Parent = l_Attachment_10;
							v15734.Color = ColorSequence.new(l_new_82.Color);
							v15734.Lifetime = NumberRange.new(v15734.Lifetime.Min * 1, v15734.Lifetime.Max * 3);
							shared.resizeparticle(v15734, v89(1, 2));
							v15734.Speed = NumberRange.new(0, v89(333, 800));
							shared.resizeparticle(v15734, v89(1.6, 2.6));
							v15734:Emit(15);
							table.insert(v15695, l_Attachment_10);
							if v15716 == 1 then
								task.delay(15, function()
									for _, v15736 in pairs(v15695) do
										v15736:Destroy();
									end;
								end);
							end;
						end;
						local l_new_84 = CFrame.new;
						v15724 = v15715;
						l_v82_409 = -3;
						l_v82_410 = 3;
						l_v82_411 = v82;
						if not l_v82_410 and l_v82_409 then
							l_v82_410 = l_v82_409;
							l_v82_409 = 1;
						end;
						if not l_v82_410 and not l_v82_409 then
							l_v82_409 = 0;
							l_v82_410 = 1;
						end;
						v15725 = l_v82_411:NextNumber(l_v82_409, l_v82_410) * 1;
						v15726 = v15716 / 45 - 0.2;
						l_v82_411 = -3;
						local v15738 = 3;
						local l_v82_412 = v82;
						if not v15738 and l_v82_411 then
							v15738 = l_v82_411;
							l_v82_411 = 1;
						end;
						if not v15738 and not l_v82_411 then
							l_v82_411 = 0;
							v15738 = 1;
						end;
						l_new_84 = l_new_84(v15724 - Vector3.new(v15725, v15726, l_v82_412:NextNumber(l_v82_411, v15738) * 1));
						v15728 = CFrame.Angles;
						v15725 = -360;
						v15726 = 360;
						l_v82_409 = v82;
						if not v15726 and v15725 then
							v15726 = v15725;
							v15725 = 1;
						end;
						if not v15726 and not v15725 then
							v15725 = 0;
							v15726 = 1;
						end;
						v15724 = math.rad((l_v82_409:NextNumber(v15725, v15726)));
						v15726 = -360;
						l_v82_409 = 360;
						l_v82_410 = v82;
						if not l_v82_409 and v15726 then
							l_v82_409 = v15726;
							v15726 = 1;
						end;
						if not l_v82_409 and not v15726 then
							v15726 = 0;
							l_v82_409 = 1;
						end;
						v15729 = math.rad((l_v82_410:NextNumber(v15726, l_v82_409)));
						l_v82_409 = -360;
						l_v82_410 = 360;
						l_v82_411 = v82;
						if not l_v82_410 and l_v82_409 then
							l_v82_410 = l_v82_409;
							l_v82_409 = 1;
						end;
						if not l_v82_410 and not l_v82_409 then
							l_v82_409 = 0;
							l_v82_410 = 1;
						end;
						v15723.CFrame = l_new_84 * v15728(v15724, v15729, (math.rad((l_v82_411:NextNumber(l_v82_409, l_v82_410)))));
						v15723.Material = l_new_82.Material;
						v15723.Color = l_new_82.Color;
						v15723.Parent = workspace.Thrown;
						if (v15723.Position - l_Root_14.Position).magnitude <= 50 then
							local l_Size_13 = v15723.Size;
							v15728 = 0.4;
							v15724 = 0.7;
							v15729 = v82;
							if not v15724 and v15728 then
								v15724 = v15728;
								v15728 = 1;
							end;
							if not v15724 and not v15728 then
								v15728 = 0;
								v15724 = 1;
							end;
							v15723.Size = l_Size_13 * v15729:NextNumber(v15728, v15724);
						end;
						table.insert(v15691, v15723);
						local l_BodyVelocity_21 = Instance.new("BodyVelocity");
						l_BodyVelocity_21.MaxForce = Vector3.new(1, 1, 1, 0) * 36000000;
						v15728 = 0;
						v15729 = 100;
						v15725 = 350;
						v15726 = v82;
						if not v15725 and v15729 then
							v15725 = v15729;
							v15729 = 1;
						end;
						if not v15725 and not v15729 then
							v15729 = 0;
							v15725 = 1;
						end;
						l_BodyVelocity_21.Velocity = Vector3.new(v15728, v15726:NextNumber(v15729, v15725), 0);
						l_BodyVelocity_21.Parent = v15723;
						game:service("Debris"):AddItem(l_BodyVelocity_21, 0.15);
						l_new_84 = Instance.new("Attachment");
						l_new_84.Parent = v15723;
						v15728 = Instance.new("Attachment");
						v15728.Position = Vector3.new(0, -0.10000000149011612, 0, 0);
						v15728.Parent = v15723;
						v15724 = l_LegacyReplication_0.TrailTwo:Clone();
						v15724.Parent = v15723;
						v15724.Attachment0 = l_new_84;
						v15724.Attachment1 = v15728;
						shared.addshake(v89(1, 2));
						return v15723;
					end)();
				end;
			end;
			task.wait();
		end;
		task.delay(8, function()
			for _, v15743 in pairs(v15691) do
				v15743:Destroy();
			end;
		end);
	end,

	['Table Flip'] = function(v898)
		local l_Root_15 = v898.Root;
		local v15745 = {};
		task.delay(10, function()
			for _, v15747 in pairs(v15745) do
				local l_v3_28 = v3;
				local l_v15747_0 = v15747;
				local l_new_85 = TweenInfo.new;
				local v15751 = 2;
				local v15752 = 8;
				local l_v82_413 = v82;
				if not v15752 and v15751 then
					v15752 = v15751;
					v15751 = 1;
				end;
				if not v15752 and not v15751 then
					v15751 = 0;
					v15752 = 1;
				end;
				l_v3_28:Create(l_v15747_0, l_new_85(l_v82_413:NextNumber(v15751, v15752), Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					CFrame = v15747.CFrame - Vector3.new(0, v15747.Size.Y, 0)
				}):Play();
			end;
			wait(8);
			for _, v15755 in pairs(v15745) do
				v15755:Destroy();
			end;
		end);
		task.spawn(function()
			task.wait(0.2);
			local v15756 = tick();
			local v15757 = 4;
			while true do
				task.wait();
				shared.addshake(v15757);
				v15757 = v15757 * 0.9725;
				if not (tick() - v15756 <= 3.5) then
					break;
				end;
			end;
		end);
		shared.addshake(7);
		for v15758, v15759 in pairs({
			Vector3.new(-3.5, -1, -4, 0), 
			Vector3.new(0, -1, -5, 0), 
			(Vector3.new(3.5, -1, -4, 0))
			}) do
			task.spawn(function()
				local v15760 = 30;
				local v15761 = 45;
				local l_v82_414 = v82;
				if not v15761 and v15760 then
					v15761 = v15760;
					v15760 = 1;
				end;
				if not v15761 and not v15760 then
					v15760 = 0;
					v15761 = 1;
				end;
				local v15763 = l_v82_414:NextNumber(v15760, v15761);
				v15760 = Instance.new("Part");
				v15760.Transparency = 1;
				v15760.Anchored = true;
				v15760.CanCollide = false;
				v15760.CanTouch = false;
				v15760.Position = l_Root_15.Position + v15759;
				v15760.Parent = workspace.Thrown;
				v3:Create(v15760, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
					CFrame = l_Root_15.CFrame * CFrame.new(v15759 * Vector3.new(50 * (1 + v15758 / v15763), 1, 50 * (1 + v15758 / v15763)))
				}):Play();
				v15761 = nil;
				if v15758 == 1 then
					v15761 = shared.sfx({
						SoundId = "rbxassetid://117199110432823", 
						Volume = 15, 
						RollOffMaxDistance = 2000, 
						Parent = v15760
					});
				elseif v15758 == 2 then
					v15761 = shared.sfx({
						SoundId = "rbxassetid://137029646574295", 
						Volume = 15, 
						PlaybackSpeed = 1.3, 
						RollOffMaxDistance = 2000, 
						Parent = v15760
					});
				elseif v15758 == 3 then
					v15761 = shared.sfx({
						SoundId = "rbxassetid://111485020592188", 
						Volume = 10, 
						RollOffMaxDistance = 2000, 
						Parent = v15760
					});
				end;
				v15761:Play();
				task.delay(1, function()
					v3:Create(v15761, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
						Volume = 0
					}):Play();
					task.delay(5, function()
						v15760:Destroy();
					end);
				end);
				for v15764 = 1, v15763 do
					local v15765 = false;
					if math.random(1, 2) == 1 and v15764 > 10 then
						v15765 = true;
					end;
					local l_v556_1 = v556;
					local v15767 = {};
					local l_CFrame_76 = l_Root_15.CFrame;
					local v15769, v15770, v15771, v15772;
					if not v15765 then
						v15769 = CFrame.new();
						if v15769 then
							--	goto label6;
						end;
					end;
					v15769 = CFrame.new;
					v15770 = -2;
					v15771 = 2;
					v15772 = v82;
					if not v15771 and v15770 then
						v15771 = v15770;
						v15770 = 1;
					end;
					if not v15771 and not v15770 then
						v15770 = 0;
						v15771 = 1;
					end;
					v15769 = v15769(v15772:NextNumber(v15770, v15771), 0, v89(-4, 4));
					--	::label6::;
					v15767.orig = (l_CFrame_76 * v15769 * CFrame.new(v15759 * Vector3.new(v15764 * (1.35 + v15764 / v15763), 1.35, v15764 * (1.35 + v15764 / v15763)))).p;
					v15767.dir = Vector3.new(0, -10, 0, 0);
					l_v556_1, v15767 = l_v556_1(v15767);
					if l_v556_1 then
						local v15773 = 1;
						if v15764 == 1 then
							v15773 = 0;
						end;
						do
							local l_v15773_0 = v15773;
							local _ = (function(v15775)
								if v15775 then

								end;
								local l_Part_26 = Instance.new("Part");
								l_Part_26.Name = "Debris2g";
								v2:AddTag(l_Part_26, "tableflip" .. v898.Code);
								l_Part_26.Anchored = true;
								l_Part_26.CanCollide = true;
								l_Part_26.Transparency = 0;
								local v15777 = 3;
								local v15778 = -1;
								local v15779 = 1;
								local l_v82_415 = v82;
								if not v15779 and v15778 then
									v15779 = v15778;
									v15778 = 1;
								end;
								if not v15779 and not v15778 then
									v15778 = 0;
									v15779 = 1;
								end;
								local v15781 = v15777 + l_v82_415:NextNumber(v15778, v15779);
								local v15782 = 3;
								v15779 = -1;
								l_v82_415 = 1;
								local l_v82_416 = v82;
								if not l_v82_415 and v15779 then
									l_v82_415 = v15779;
									v15779 = 1;
								end;
								if not l_v82_415 and not v15779 then
									v15779 = 0;
									l_v82_415 = 1;
								end;
								v15777 = v15782 + l_v82_416:NextNumber(v15779, l_v82_415);
								v15778 = 3;
								l_v82_415 = -1;
								l_v82_416 = 1;
								local l_v82_417 = v82;
								if not l_v82_416 and l_v82_415 then
									l_v82_416 = l_v82_415;
									l_v82_415 = 1;
								end;
								if not l_v82_416 and not l_v82_415 then
									l_v82_415 = 0;
									l_v82_416 = 1;
								end;
								l_Part_26.Size = (Vector3.new(v15781, v15777, v15778 + l_v82_417:NextNumber(l_v82_415, l_v82_416)) - Vector3.new(1, 1, 1, 0) * v15764 / 20) * (v15764 == 1 and 1.1 or 1);
								table.insert(v15745, l_Part_26);
								local v15785 = l_LegacyReplication_0.SmokeOne:Clone();
								v15785.Color = ColorSequence.new(l_v556_1.Color);
								v15785.Parent = l_Part_26;
								if v15775 then
									local l_Size_14 = l_Part_26.Size;
									v15781 = 1;
									v15777 = 2;
									v15782 = v82;
									if not v15777 and v15781 then
										v15777 = v15781;
										v15781 = 1;
									end;
									if not v15777 and not v15781 then
										v15781 = 0;
										v15777 = 1;
									end;
									l_Part_26.Size = l_Size_14 * v15782:NextNumber(v15781, v15777);
									shared.resizeparticle(v15785, 2);
									shared.addshake(0.5);
									l_Size_14 = l_LegacyReplication_0.UpSmoke:Clone();
									l_Size_14.Parent = l_Part_26;
									l_Size_14.Color = ColorSequence.new(l_v556_1.Color);
									l_Size_14.Speed = NumberRange.new(0, v89(95, 200));
									shared.resizeparticle(l_Size_14, v89(1.2, 1.6));
									l_Size_14:Emit(22);
								end;
								task.delay(1, function()
									v15785.Enabled = false;
								end);
								local l_new_86 = CFrame.new;
								v15777 = v15767;
								l_v82_415 = -3;
								l_v82_416 = 3;
								l_v82_417 = v82;
								if not l_v82_416 and l_v82_415 then
									l_v82_416 = l_v82_415;
									l_v82_415 = 1;
								end;
								if not l_v82_416 and not l_v82_415 then
									l_v82_415 = 0;
									l_v82_416 = 1;
								end;
								v15778 = l_v82_417:NextNumber(l_v82_415, l_v82_416) * l_v15773_0;
								v15779 = v15764 / 45 - 0.2;
								l_v82_417 = -3;
								local v15788 = 3;
								local l_v82_418 = v82;
								if not v15788 and l_v82_417 then
									v15788 = l_v82_417;
									l_v82_417 = 1;
								end;
								if not v15788 and not l_v82_417 then
									l_v82_417 = 0;
									v15788 = 1;
								end;
								l_new_86 = l_new_86(v15777 - Vector3.new(v15778, v15779, l_v82_418:NextNumber(l_v82_417, v15788) * l_v15773_0));
								v15781 = CFrame.Angles;
								v15778 = -360;
								v15779 = 360;
								l_v82_415 = v82;
								if not v15779 and v15778 then
									v15779 = v15778;
									v15778 = 1;
								end;
								if not v15779 and not v15778 then
									v15778 = 0;
									v15779 = 1;
								end;
								v15777 = math.rad((l_v82_415:NextNumber(v15778, v15779)));
								v15779 = -360;
								l_v82_415 = 360;
								l_v82_416 = v82;
								if not l_v82_415 and v15779 then
									l_v82_415 = v15779;
									v15779 = 1;
								end;
								if not l_v82_415 and not v15779 then
									v15779 = 0;
									l_v82_415 = 1;
								end;
								v15782 = math.rad((l_v82_416:NextNumber(v15779, l_v82_415)));
								l_v82_415 = -360;
								l_v82_416 = 360;
								l_v82_417 = v82;
								if not l_v82_416 and l_v82_415 then
									l_v82_416 = l_v82_415;
									l_v82_415 = 1;
								end;
								if not l_v82_416 and not l_v82_415 then
									l_v82_415 = 0;
									l_v82_416 = 1;
								end;
								l_Part_26.CFrame = l_new_86 * v15781(v15777, v15782, (math.rad((l_v82_417:NextNumber(l_v82_415, l_v82_416)))));
								l_Part_26.Material = l_v556_1.Material;
								l_Part_26.Color = l_v556_1.Color;
								l_Part_26.Position = l_Part_26.Position - Vector3.new(0, l_Part_26.Size.Y / 2, 0);
								l_Part_26.Parent = workspace.Thrown;
								local l_delay_7 = task.delay;
								v15777 = 0;
								v15782 = 0.35;
								v15778 = v82;
								if not v15782 and v15777 then
									v15782 = v15777;
									v15777 = 1;
								end;
								if not v15782 and not v15777 then
									v15777 = 0;
									v15782 = 1;
								end;
								l_delay_7(v15778:NextNumber(v15777, v15782) * (v15775 and 3 or 1), function()
									local l_v3_29 = v3;
									local l_l_Part_26_0 = l_Part_26;
									local l_new_87 = TweenInfo.new;
									local v15794 = 0.2;
									local v15795 = 0.4;
									local l_v82_419 = v82;
									if not v15795 and v15794 then
										v15795 = v15794;
										v15794 = 1;
									end;
									if not v15795 and not v15794 then
										v15794 = 0;
										v15795 = 1;
									end;
									l_v3_29:Create(l_l_Part_26_0, l_new_87(l_v82_419:NextNumber(v15794, v15795), Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
										Position = l_Part_26.Position + Vector3.new(0, l_Part_26.Size.Y / 2, 0)
									}):Play();
								end);
								return l_Part_26;
							end)(v15765);
							task.wait(0.03);
						end;
					end;
				end;
			end);
		end;
	end,

	['Break Model'] = function(v898)
		if v898.Burn and workspace:GetAttribute("RankedOnes") then
			return ;
		elseif v898.Stadium then
			local v14642 = {
				ground = v898.Stadium
			};
			if v14642.ground:GetAttribute("Broken") then
				return ;
			else
				v14642.ground:SetAttribute("Broken", true);
				local l_SpecialMesh_702 = Instance.new("SpecialMesh");
				l_SpecialMesh_702.Scale = Vector3.new(0, 0, 0, 0);
				if not workspace:GetAttribute("RankedOnes") then
					task.delay(v14642.ground:GetAttribute("RespawnTime"), function()
						v14642.ground:SetAttribute("Broken", false);
						l_SpecialMesh_702:Destroy();
					end);
				end;
				local l_ground_0 = v14642.ground;
				local v14645 = l_ground_0:Clone();
				v14645.Size = Vector3.new(l_ground_0.Size.X, 0.07, l_ground_0.Size.Z);
				v14645.Position = l_ground_0.Position;
				v14645.Position = v14645.Position + Vector3.new(0, l_ground_0.Size.Y / 2, 0);
				l_SpecialMesh_702.Parent = v14642.ground;
				local v14646 = {};
				if not v898.NoLag then
					local _, v14648, v14649 = v576(v14645, ({
						"X", 
						"Z"
					})[math.random(1, 2)]);
					table.insert(v14646, v14648);
					table.insert(v14646, v14649);
				else
					v14645.Parent = workspace.Thrown;
					table.insert(v14646, v14645);
				end;
				if not v898.Up then
					v898.Up = 33;
				end;
				for v14650, v14651 in pairs(v14646) do
					v14651.Anchored = false;
					v14651.Transparency = 0;
					v14651.CollisionGroup = "nocol";
					local l_fromRGB_1 = Color3.fromRGB;
					local v14653 = v14651.Color.R * 255;
					local v14654 = 3;
					local v14655 = 5;
					local l_v82_320 = v82;
					if not v14655 and v14654 then
						v14655 = v14654;
						v14654 = 1;
					end;
					if not v14655 and not v14654 then
						v14654 = 0;
						v14655 = 1;
					end;
					local v14657 = v14653 - l_v82_320:NextNumber(v14654, v14655);
					local v14658 = v14651.Color.G * 255;
					v14655 = 3;
					l_v82_320 = 5;
					local l_v82_321 = v82;
					if not l_v82_320 and v14655 then
						l_v82_320 = v14655;
						v14655 = 1;
					end;
					if not l_v82_320 and not v14655 then
						v14655 = 0;
						l_v82_320 = 1;
					end;
					v14653 = v14658 - l_v82_321:NextNumber(v14655, l_v82_320);
					v14654 = v14651.Color.B * 255;
					l_v82_320 = 3;
					l_v82_321 = 5;
					local l_v82_322 = v82;
					if not l_v82_321 and l_v82_320 then
						l_v82_321 = l_v82_320;
						l_v82_320 = 1;
					end;
					if not l_v82_321 and not l_v82_320 then
						l_v82_320 = 0;
						l_v82_321 = 1;
					end;
					v14651.Color = l_fromRGB_1(v14657, v14653, v14654 - l_v82_322:NextNumber(l_v82_320, l_v82_321));
					v14651:SetAttribute("CanGoThroughCamera", true);
					l_fromRGB_1 = v14651.CFrame;
					v14657 = CFrame.Angles;
					v14654 = -35;
					v14655 = 35;
					l_v82_320 = v82;
					if not v14655 and v14654 then
						v14655 = v14654;
						v14654 = 1;
					end;
					if not v14655 and not v14654 then
						v14654 = 0;
						v14655 = 1;
					end;
					v14653 = math.rad((l_v82_320:NextNumber(v14654, v14655)));
					v14655 = -35;
					l_v82_320 = 35;
					l_v82_321 = v82;
					if not l_v82_320 and v14655 then
						l_v82_320 = v14655;
						v14655 = 1;
					end;
					if not l_v82_320 and not v14655 then
						v14655 = 0;
						l_v82_320 = 1;
					end;
					v14658 = math.rad((l_v82_321:NextNumber(v14655, l_v82_320)));
					l_v82_320 = -35;
					l_v82_321 = 35;
					l_v82_322 = v82;
					if not l_v82_321 and l_v82_320 then
						l_v82_321 = l_v82_320;
						l_v82_320 = 1;
					end;
					if not l_v82_321 and not l_v82_320 then
						l_v82_320 = 0;
						l_v82_321 = 1;
					end;
					v14651.CFrame = l_fromRGB_1 * v14657(v14653, v14658, (math.rad((l_v82_322:NextNumber(l_v82_320, l_v82_321)))));
					v14651.Parent = workspace.Thrown;
					if v14650 == 1 then
						l_fromRGB_1 = shared.sfx;
						v14657 = {
							SoundId = ({
								"rbxassetid://121588546385561", 
								"rbxassetid://72594503638037", 
								"rbxassetid://121180108060541"
							})[math.random(1, 3)], 
							Volume = 7, 
							CFrame = v14651.CFrame
						};
						v14658 = 0.9;
						v14654 = 1.1;
						v14655 = v82;
						if not v14654 and v14658 then
							v14654 = v14658;
							v14658 = 1;
						end;
						if not v14654 and not v14658 then
							v14658 = 0;
							v14654 = 1;
						end;
						v14657.PlaybackSpeed = v14655:NextNumber(v14658, v14654);
						l_fromRGB_1(v14657):Play();
					end;
					l_fromRGB_1 = Instance.new("BodyVelocity");
					l_fromRGB_1.MaxForce = Vector3.new(1, 1, 1, 0) * 40000;
					v14658 = -22;
					v14654 = 22;
					v14655 = v82;
					if not v14654 and v14658 then
						v14654 = v14658;
						v14658 = 1;
					end;
					if not v14654 and not v14658 then
						v14658 = 0;
						v14654 = 1;
					end;
					v14653 = v14655:NextNumber(v14658, v14654);
					v14654 = v898.Up;
					v14655 = v898.Up + 5;
					l_v82_320 = v82;
					if not v14655 and v14654 then
						v14655 = v14654;
						v14654 = 1;
					end;
					if not v14655 and not v14654 then
						v14654 = 0;
						v14655 = 1;
					end;
					l_fromRGB_1.Velocity = Vector3.new(v14653, l_v82_320:NextNumber(v14654, v14655), v89(-22, 22));
					l_fromRGB_1.Parent = v14651;
					game:service("Debris"):AddItem(l_fromRGB_1, 0.15);
					v14657 = task.delay;
					v14658 = 1;
					v14654 = 2;
					v14655 = v82;
					if not v14654 and v14658 then
						v14654 = v14658;
						v14658 = 1;
					end;
					if not v14654 and not v14658 then
						v14658 = 0;
						v14654 = 1;
					end;
					v14657(v14655:NextNumber(v14658, v14654), function()
						local l_v3_16 = v3;
						local l_v14651_0 = v14651;
						local l_new_65 = TweenInfo.new;
						local v14664 = 1;
						local v14665 = 2;
						local l_v82_323 = v82;
						if not v14665 and v14664 then
							v14665 = v14664;
							v14664 = 1;
						end;
						if not v14665 and not v14664 then
							v14664 = 0;
							v14665 = 1;
						end;
						l_v3_16:Create(l_v14651_0, l_new_65(l_v82_323:NextNumber(v14664, v14665), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							Transparency = 1, 
							Size = v14651.Size / 1.5
						}):Play();
					end);
					v14657 = shared.sfx;
					v14653 = {
						SoundId = ({
							"rbxassetid://70479925567317", 
							"rbxassetid://133986966079152", 
							"rbxassetid://129575320900840", 
							"rbxassetid://135240097745495", 
							"rbxassetid://137829053871674"
						})[math.random(1, 5)], 
						Volume = 3.2
					};
					v14654 = 0.9;
					v14655 = 1.1;
					l_v82_320 = v82;
					if not v14655 and v14654 then
						v14655 = v14654;
						v14654 = 1;
					end;
					if not v14655 and not v14654 then
						v14654 = 0;
						v14655 = 1;
					end;
					v14653.PlaybackSpeed = l_v82_320:NextNumber(v14654, v14655);
					v14653.Parent = v14651;
					v14657(v14653):Play();
				end;
				task.delay(4.5, function()
					v14645:Destroy();
					for _, v14668 in pairs(v14646) do
						v14668:Destroy();
					end;
				end);
				return true;
			end;
		else
			warn('nah')
			local l_Original_0 = v898.Original;
			if l_Original_0.Parent == game.Lighting then
				return ;
			elseif l_Original_0.Parent:FindFirstChildOfClass("Humanoid") or l_Original_0:FindFirstChildOfClass("Humanoid") then
				return ;
			else
				local l_Position_66 = l_Original_0:FindFirstChildWhichIsA("BasePart", true).Position;
				local l_Parent_12 = l_Original_0.Parent;
				local v14672, v14673 = workspace:FindFirstChildOfClass("Camera"):WorldToScreenPoint(l_Position_66);
				local l_v14673_0 = v14673;
				l_Original_0.Parent = game.Lighting;
				v14672 = l_LocalPlayer_0.Character;
				if v14672 then
					v14673 = v14672.PrimaryPart;
					if v14673 and (l_Position_66 - v14673.Position).magnitude <= 10 then
						local v14676 = shared.repfire('Camshake', {
						});
						local v14677 = 0.7;
						local v14678 = 1.2;
						local l_v82_324 = v82;
						if not v14678 and v14677 then
							v14678 = v14677;
							v14677 = 1;
						end;
						if not v14678 and not v14677 then
							v14677 = 0;
							v14678 = 1;
						end;
						v14676.Intensity = l_v82_324:NextNumber(v14677, v14678) * 1.75;
					end;
				end;
				for _, v14681 in pairs(l_Original_0:GetDescendants()) do
					if v14681:IsA("Sound") then
						v14681:Pause();
					end;
				end;
				v14673 = l_Original_0:Clone();
				local v14682 = true;
				for _, v14684 in pairs(v14673:GetDescendants()) do
					if v14684:IsA("BasePart") then
						v2:RemoveTag(v14684, "WindShake");
						if not v898.CanCollide then
							v14684.CanCollide = false;
						end;
						v14684.AssemblyLinearVelocity = Vector3.new();
						v14684.Velocity = Vector3.new();
						v14684.AssemblyAngularVelocity = Vector3.new();
						v14684.Anchored = false;
						v14684.CanTouch = false;
						v14684.Transparency = 0;
						v14684.CanQuery = false;
						if (not (v14684.Name ~= "TreeRoot") or v14684.Parent.Name == "Tree" and not v14684:GetAttribute("IsTree")) and v898.Burn and not v898.VelBurn then
							v14684.Anchored = true;
							v14684.CanCollide = true;
							v14684.CanQuery = true;
							v14684.CanTouch = true;
							v14682 = false;
						end;
						if l_LocalPlayer_0:GetAttribute("S_FastMode") and v14673.Name ~= "Trashcan" and math.random(1, 3) ~= 1 then
							v14684:Destroy();
						end;
						if not l_v14673_0 and v14673.Name == "Bench" and math.random(1, 2) == 1 then
							v14684:Destroy();
						end;
					end;
				end;
				v14673.Parent = workspace.Thrown;
				if v14682 and v14673.Name ~= "Trashcan" then
					task.delay(5, function()
						v14673:Destroy();
					end);
				end;
				local v14685 = true;
				local v14686 = false;
				local v14687 = {};
				for _, v14689 in pairs(v14673:GetDescendants()) do
					if v14689:IsA("BasePart") then
						if v898.Tornado then
							local function v14714()
								local v14690 = 0.7;
								local v14691 = 1.4;
								local l_v82_325 = v82;
								if not v14691 and v14690 then
									v14691 = v14690;
									v14690 = 1;
								end;
								if not v14691 and not v14690 then
									v14690 = 0;
									v14691 = 1;
								end;
								local v14693 = l_v82_325:NextNumber(v14690, v14691);
								v14690 = Instance.new("NumberValue");
								v14691 = Instance.new("NumberValue");
								l_v82_325 = Instance.new("NumberValue");
								local v14694 = 0;
								local v14695 = 360;
								local l_v82_326 = v82;
								if not v14695 and v14694 then
									v14695 = v14694;
									v14694 = 1;
								end;
								if not v14695 and not v14694 then
									v14694 = 0;
									v14695 = 1;
								end;
								local v14697 = l_v82_326:NextNumber(v14694, v14695);
								v14694 = v14689;
								v14695 = v898.Tornado;
								l_v82_326 = v14694.Size;
								local l_v14687_0 = v14687;
								local v14699 = {
									Dist = v14690, 
									Height = v14691, 
									Spin = l_v82_325, 
									Rot = v14697, 
									Size = l_v82_326
								};
								local v14700 = 0.7;
								local v14701 = 1.3;
								local l_v82_327 = v82;
								if not v14701 and v14700 then
									v14701 = v14700;
									v14700 = 1;
								end;
								if not v14701 and not v14700 then
									v14700 = 0;
									v14701 = 1;
								end;
								v14699.amplitude = l_v82_327:NextNumber(v14700, v14701);
								v14700 = 0.5;
								v14701 = 1.5;
								l_v82_327 = v82;
								if not v14701 and v14700 then
									v14701 = v14700;
									v14700 = 1;
								end;
								if not v14701 and not v14700 then
									v14700 = 0;
									v14701 = 1;
								end;
								v14699.frequency = l_v82_327:NextNumber(v14700, v14701);
								v14699.RotScale = v14693;
								l_v14687_0[v14694] = v14699;
								v14690.Value = (v14689.Position - v898.Tornado.Position).magnitude;
								if not (v14689.Material ~= Enum.Material.Grass) or v14689.Name ~= "TreeRoot" then

								end;
								l_v14687_0 = v3;
								local l_v14694_0 = v14694;
								v14700 = TweenInfo.new;
								local v14704 = 0.1;
								local v14705 = 0.2;
								local l_v82_328 = v82;
								if not v14705 and v14704 then
									v14705 = v14704;
									v14704 = 1;
								end;
								if not v14705 and not v14704 then
									v14704 = 0;
									v14705 = 1;
								end;
								l_v14687_0:Create(l_v14694_0, v14700(l_v82_328:NextNumber(v14704, v14705) * 2, Enum.EasingStyle.Sine), {
									Size = l_v82_326 * 0.35
								}):Play();
								l_v14687_0 = v3;
								l_v14694_0 = l_v82_325;
								v14700 = TweenInfo.new(1, Enum.EasingStyle.Sine);
								v14701 = {};
								v14704 = 0.03;
								v14705 = 0.05;
								l_v82_328 = v82;
								if not v14705 and v14704 then
									v14705 = v14704;
									v14704 = 1;
								end;
								if not v14705 and not v14704 then
									v14704 = 0;
									v14705 = 1;
								end;
								v14701.Value = l_v82_328:NextNumber(v14704, v14705);
								l_v14687_0:Create(l_v14694_0, v14700, v14701):Play();
								v14699 = -20;
								l_v14694_0 = -10;
								v14700 = v82;
								if not l_v14694_0 and v14699 then
									l_v14694_0 = v14699;
									v14699 = 1;
								end;
								if not l_v14694_0 and not v14699 then
									v14699 = 0;
									l_v14694_0 = 1;
								end;
								v14691.Value = v14700:NextNumber(v14699, l_v14694_0);
								l_v14687_0 = v3;
								l_v14694_0 = v14691;
								v14700 = TweenInfo.new;
								l_v82_327 = 0.2;
								v14704 = 0.4;
								v14705 = v82;
								if not v14704 and l_v82_327 then
									v14704 = l_v82_327;
									l_v82_327 = 1;
								end;
								if not v14704 and not l_v82_327 then
									l_v82_327 = 0;
									v14704 = 1;
								end;
								v14700 = v14700(v14705:NextNumber(l_v82_327, v14704), Enum.EasingStyle.Quad);
								v14701 = {};
								v14704 = 45;
								v14705 = 125;
								l_v82_328 = v82;
								if not v14705 and v14704 then
									v14705 = v14704;
									v14704 = 1;
								end;
								if not v14705 and not v14704 then
									v14704 = 0;
									v14705 = 1;
								end;
								v14701.Value = l_v82_328:NextNumber(v14704, v14705);
								l_v14687_0:Create(l_v14694_0, v14700, v14701):Play();
								task.delay(0.8, function()
									local l_v3_17 = v3;
									local l_l_v82_325_0 = l_v82_325;
									local v14709 = TweenInfo.new(1.5, Enum.EasingStyle.Sine);
									local v14710 = {};
									local v14711 = 0.35;
									local v14712 = 0.45;
									local l_v82_329 = v82;
									if not v14712 and v14711 then
										v14712 = v14711;
										v14711 = 1;
									end;
									if not v14712 and not v14711 then
										v14711 = 0;
										v14712 = 1;
									end;
									v14710.Value = l_v82_329:NextNumber(v14711, v14712);
									l_v3_17:Create(l_l_v82_325_0, v14709, v14710):Play();
									v3:Create(v14690, TweenInfo.new(3, Enum.EasingStyle.Sine), {
										Value = v14690.Value * 1.5
									}):Play();
								end);
							end;
							if v898.TornadoDelay then
								local l_BodyVelocity_15 = Instance.new("BodyVelocity");
								l_BodyVelocity_15.MaxForce = Vector3.new(1, 1, 1, 0) * 2000000000;
								l_BodyVelocity_15.Velocity = Vector3.new(math.random(-10, 10), v898.Velocity or math.random(200, 300), math.random(-10, 10));
								if v898.From then
									local l_lookVector_5 = CFrame.new(v14689.Position, v898.From).lookVector;
									local v14717 = v898.Velocity or 355;
									local v14718 = v898.Velocity and v898.Velocity + 5 or 455;
									local l_v82_330 = v82;
									if not v14718 and v14717 then
										v14718 = v14717;
										v14717 = 1;
									end;
									if not v14718 and not v14717 then
										v14717 = 0;
										v14718 = 1;
									end;
									l_BodyVelocity_15.Velocity = l_lookVector_5 * -l_v82_330:NextNumber(v14717, v14718);
									l_BodyVelocity_15.Velocity = l_BodyVelocity_15.Velocity + Vector3.new(math.random(-20, 20), 65, math.random(-20, 20)) * (v898.Velocity and 0.4 or 1);
								end;
								local l_BodyAngularVelocity_5 = Instance.new("BodyAngularVelocity");
								local v14721 = Vector3.new(math.random(-10, 10), math.random(-5, 5), math.random(-6, 6));
								local v14722 = 0.5;
								local v14723 = 1;
								local l_v82_331 = v82;
								if not v14723 and v14722 then
									v14723 = v14722;
									v14722 = 1;
								end;
								if not v14723 and not v14722 then
									v14722 = 0;
									v14723 = 1;
								end;
								l_BodyAngularVelocity_5.AngularVelocity = v14721 * l_v82_331:NextNumber(v14722, v14723);
								l_BodyAngularVelocity_5.MaxTorque = Vector3.new(1, 1, 1, 0) * 2000000000;
								l_BodyAngularVelocity_5.Parent = v14689;
								l_BodyVelocity_15.Parent = v14689;
								v3:Create(l_BodyVelocity_15, TweenInfo.new(1, Enum.EasingStyle.Sine), {
									Velocity = Vector3.new(0, 0, 0, 0)
								}):Play();
								v3:Create(l_BodyAngularVelocity_5, TweenInfo.new(1, Enum.EasingStyle.Sine), {
									AngularVelocity = Vector3.new(0, 0, 0, 0)
								}):Play();
								local l_l_BodyVelocity_15_0 = l_BodyVelocity_15 --[[ copy: 20 -> 73 ]];
								local l_l_BodyAngularVelocity_5_0 = l_BodyAngularVelocity_5 --[[ copy: 21 -> 74 ]];
								local l_v14714_0 = v14714 --[[ copy: 19 -> 75 ]];
								task.delay(0.4, function()
									game:GetService("Debris"):AddItem(l_l_BodyVelocity_15_0, 0);
									game:GetService("Debris"):AddItem(l_l_BodyAngularVelocity_5_0, 0);
									v14689.Anchored = true;
									l_v14714_0();
								end);
							else
								v14714();
							end;
						elseif not v898.Blue then
							local l_BodyVelocity_16 = Instance.new("BodyVelocity");
							l_BodyVelocity_16.MaxForce = Vector3.new(1, 1, 1, 0) * 2000000000;
							l_BodyVelocity_16.Velocity = Vector3.new(math.random(-10, 10), v898.Velocity or math.random(200, 300), math.random(-10, 10));
							if v898.From then
								local l_lookVector_6 = CFrame.new(v14689.Position, v898.From).lookVector;
								local v14730 = v898.Velocity or 355;
								local v14731 = v898.Velocity and v898.Velocity + 5 or 455;
								local l_v82_332 = v82;
								if not v14731 and v14730 then
									v14731 = v14730;
									v14730 = 1;
								end;
								if not v14731 and not v14730 then
									v14730 = 0;
									v14731 = 1;
								end;
								l_BodyVelocity_16.Velocity = l_lookVector_6 * -l_v82_332:NextNumber(v14730, v14731);
								l_BodyVelocity_16.Velocity = l_BodyVelocity_16.Velocity + Vector3.new(math.random(-20, 20), 65, math.random(-20, 20)) * (v898.Velocity and 0.4 or 1);
							end;
							local l_BodyAngularVelocity_6 = Instance.new("BodyAngularVelocity");
							local v14734 = Vector3.new(math.random(-10, 10), math.random(-5, 5), math.random(-6, 6));
							local v14735 = 0.5;
							local v14736 = 1;
							local l_v82_333 = v82;
							if not v14736 and v14735 then
								v14736 = v14735;
								v14735 = 1;
							end;
							if not v14736 and not v14735 then
								v14735 = 0;
								v14736 = 1;
							end;
							l_BodyAngularVelocity_6.AngularVelocity = v14734 * l_v82_333:NextNumber(v14735, v14736);
							l_BodyAngularVelocity_6.MaxTorque = Vector3.new(1, 1, 1, 0) * 2000000000;
							l_BodyAngularVelocity_6.Parent = v14689;
							game:service("Debris"):AddItem(l_BodyAngularVelocity_6, 0.15);
							l_BodyVelocity_16.Parent = v14689;
							game:service("Debris"):AddItem(l_BodyVelocity_16, 0.15);
						else
							warn('LOLBLE')
							local l_LapseBlue_0 = v898.Blue.LapseBlue;
							v3:Create(v14689, TweenInfo.new((v14689.Position - l_LapseBlue_0.Position).magnitude / 75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
								Size = Vector3.new()
							}):Play();
							local l_BodyVelocity_17 = Instance.new("BodyVelocity");
							l_BodyVelocity_17.MaxForce = Vector3.new(1, 1, 1, 0) * 150000;
							if not v14686 then
								v14686 = true;
								local l_sfx_11 = shared.sfx;
								local v14741 = {
									SoundId = ({
										"rbxassetid://139776195742154", 
										"rbxassetid://117433112795776", 
										"rbxassetid://89589004503742"
									})[math.random(1, 3)], 
									Volume = 5.75
								};
								local v14742 = 0.9;
								local v14743 = 1.1;
								local l_v82_334 = v82;
								if not v14743 and v14742 then
									v14743 = v14742;
									v14742 = 1;
								end;
								if not v14743 and not v14742 then
									v14742 = 0;
									v14743 = 1;
								end;
								v14741.PlaybackSpeed = l_v82_334:NextNumber(v14742, v14743);
								v14741.CFrame = v14689.CFrame;
								l_sfx_11(v14741):Play();
							end;
							local l_l_BodyVelocity_17_0 = l_BodyVelocity_17 --[[ copy: 20 -> 71 ]];
							local l_l_LapseBlue_0_0 = l_LapseBlue_0 --[[ copy: 19 -> 72 ]];
							task.spawn(function()
								local v14747 = 40;
								local v14748 = 60;
								local l_v82_335 = v82;
								if not v14748 and v14747 then
									v14748 = v14747;
									v14747 = 1;
								end;
								if not v14748 and not v14747 then
									v14747 = 0;
									v14748 = 1;
								end;
								local v14750 = l_v82_335:NextNumber(v14747, v14748);
								v14747 = tick();
								while true do
									task.wait();
									l_l_BodyVelocity_17_0.Velocity = CFrame.new(v14689.Position, l_l_LapseBlue_0_0.Position).lookVector * v14750 * 3;
									if not l_l_BodyVelocity_17_0.Parent then
										l_l_BodyVelocity_17_0.Parent = v14689;
									end;
									if not (tick() - v14747 <= 1) then
										break;
									end;
								end;
								v3:Create(v14689, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									Size = Vector3.new(), 
									Transparency = 1
								}):Play();
								task.delay(0.35, function()
									v14689:Destroy();
								end);
							end);
						end;
						if v14689:GetAttribute("IsTree") then
							if v898.Burn then
								local l_v3_18 = v3;
								local l_v14689_0 = v14689;
								local l_new_66 = TweenInfo.new;
								local v14754 = 0.5;
								local v14755 = 1.2;
								local l_v82_336 = v82;
								if not v14755 and v14754 then
									v14755 = v14754;
									v14754 = 1;
								end;
								if not v14755 and not v14754 then
									v14754 = 0;
									v14755 = 1;
								end;
								l_v3_18:Create(l_v14689_0, l_new_66(l_v82_336:NextNumber(v14754, v14755), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									Color = Color3.new(0, 0, 0), 
									Size = Vector3.new()
								}):Play();
							end;
						elseif v898.Burn then
							local l_v3_19 = v3;
							local l_v14689_1 = v14689;
							local l_new_67 = TweenInfo.new;
							local v14760 = 0.5;
							local v14761 = 1.2;
							local l_v82_337 = v82;
							if not v14761 and v14760 then
								v14761 = v14760;
								v14760 = 1;
							end;
							if not v14761 and not v14760 then
								v14760 = 0;
								v14761 = 1;
							end;
							l_v3_19:Create(l_v14689_1, l_new_67(l_v82_337:NextNumber(v14760, v14761), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
								Color = Color3.new(0, 0, 0)
							}):Play();
						end;
						if v14689.Name == "TreeRoot" then
							local v14763 = l_LegacyReplication_0.TreeFire:Clone();
							v14763.Parent = v14689;
							local l_sfx_12 = shared.sfx;
							local v14765 = {
								SoundId = ({
									"rbxassetid://101514265408618", 
									"rbxassetid://98100410187511", 
									"rbxassetid://89589004503742", 
									"rbxassetid://132959942168453"
								})[math.random(1, 4)], 
								Parent = v14689
							};
							local v14766 = 1.5;
							local v14767 = 3;
							local l_v82_338 = v82;
							if not v14767 and v14766 then
								v14767 = v14766;
								v14766 = 1;
							end;
							if not v14767 and not v14766 then
								v14766 = 0;
								v14767 = 1;
							end;
							v14765.Volume = l_v82_338:NextNumber(v14766, v14767);
							l_sfx_12(v14765):Play();
							if v898.Burn then
								l_sfx_12 = v3;
								local l_v14689_2 = v14689;
								v14766 = TweenInfo.new;
								l_v82_338 = 0.5;
								local v14770 = 1.2;
								local l_v82_339 = v82;
								if not v14770 and l_v82_338 then
									v14770 = l_v82_338;
									l_v82_338 = 1;
								end;
								if not v14770 and not l_v82_338 then
									l_v82_338 = 0;
									v14770 = 1;
								end;
								l_sfx_12:Create(l_v14689_2, v14766(l_v82_339:NextNumber(l_v82_338, v14770), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									Color = Color3.new(0, 0, 0)
								}):Play();
								v14763:Emit(v89(6, 10, true));
								l_sfx_12 = shared.sfx;
								v14765 = {
									SoundId = ({
										"rbxassetid://80664954866052", 
										"rbxassetid://127013836833664", 
										"rbxassetid://139302390652165", 
										"rbxassetid://111285709209364"
									})[math.random(1, 4)], 
									Volume = 10
								};
								v14766 = 0.9;
								v14767 = 1.1;
								l_v82_338 = v82;
								if not v14767 and v14766 then
									v14767 = v14766;
									v14766 = 1;
								end;
								if not v14767 and not v14766 then
									v14766 = 0;
									v14767 = 1;
								end;
								v14765.PlaybackSpeed = l_v82_338:NextNumber(v14766, v14767);
								v14765.Parent = v14689;
								l_sfx_12(v14765):Play();
							end;
						elseif v14689.Parent.Name == "Bench" then
							if v14685 and not v898.NoSound then
								v14685 = false;
								shared.sfx({
									SoundId = ({
										"rbxassetid://12351473066", 
										"rbxassetid://12351473130", 
										"rbxassetid://12351473189", 
										"rbxassetid://12351473236"
									})[math.random(1, 4)], 
									Parent = v14689, 
									Volume = 4
								}):Play();
							end;
						elseif not (v14689.Parent.Name ~= "Trashcan") or v14689:GetAttribute("Destructible") then
							v14689.CanCollide = true;
							shared.sfx({
								SoundId = ({
									"rbxassetid://12392244609", 
									"rbxassetid://12392245642"
								})[math.random(1, 2)], 
								Parent = v14689, 
								Volume = 2
							}):Play();
							shared.sfx({
								SoundId = ({
									"rbxassetid://12392244389", 
									"rbxassetid://12392244145", 
									"rbxassetid://12392244235"
								})[math.random(1, 3)], 
								Parent = v14689, 
								Volume = 1
							}):Play();
						end;
					end;
				end;
				if v898.Tornado then
					task.spawn(function()
						local v14772 = 0;
						local l_NumberValue_20 = Instance.new("NumberValue");
						l_NumberValue_20.Value = 0.01;
						task.delay(v898.TornadoDelay and 0.5 or 0, function()
							v3:Create(l_NumberValue_20, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
								Value = 0.1
							}):Play();
						end);
						local v14774 = tick();
						while v14687 and tick() - v14774 < 3 do
							for v14775, v14776 in pairs(v14687) do
								v14772 = v14772 + v14776.Spin.Value;
								v14775.CFrame = v14775.CFrame:lerp(v898.Tornado * CFrame.Angles(0, -math.rad((v14772 + v14776.Rot) * v14776.RotScale), 0) * CFrame.new(0, v14776.Height.Value, v14776.Dist.Value), l_NumberValue_20.Value);
								if tick() - v14774 > 2.7 and not v14776.Finished then
									v14687[v14775].Finished = true;
									local l_v3_20 = v3;
									local l_v14775_0 = v14775;
									local l_new_68 = TweenInfo.new;
									local v14780 = 0.1;
									local v14781 = 0.2;
									local l_v82_340 = v82;
									if not v14781 and v14780 then
										v14781 = v14780;
										v14780 = 1;
									end;
									if not v14781 and not v14780 then
										v14780 = 0;
										v14781 = 1;
									end;
									l_v3_20:Create(l_v14775_0, l_new_68(l_v82_340:NextNumber(v14780, v14781), Enum.EasingStyle.Sine), {
										Size = Vector3.new(0, 0, 0, 0)
									}):Play();
								elseif not (tick() - v14774 < 2.7) or tick() - v14774 > 2 then

								end;
							end;
							game:GetService("RunService").Heartbeat:Wait();
						end;
						l_NumberValue_20:Destroy();
					end);
				end;
				task.delay(l_Original_0:GetAttribute("RespawnTime") or 60, function()
					if v14673 and v14673.Parent then
						v14673:Destroy();
					end;
					for _, v14784 in pairs(l_Original_0:GetDescendants()) do
						if v14784:IsA("BasePart") then
							if not v14784:GetAttribute("OGTransparencyy") then
								v14784:SetAttribute("OGTransparencyy", v14784.Transparency);
							end;
							v14784.Transparency = 1;
						end;
					end;
					l_Original_0.Parent = l_Parent_12;
					for _, v14786 in pairs(l_Original_0:GetDescendants()) do
						if v14786:IsA("Sound") then
							v14786:Resume();
						end;
						if v14786:IsA("BasePart") then
							local l_v14786_Attribute_0 = v14786:GetAttribute("OGTransparencyy");
							if l_v14786_Attribute_0 then
								v3:Create(v14786, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
									Transparency = l_v14786_Attribute_0
								}):Play();
							end;
						end;
					end;
				end);
			end;
		end;
	end,

	['Backhand'] = function(v898)
		local v16162 = game.ReplicatedStorage.Resources.Ring:Clone();
		task.delay(v898.Time or 0.3, function()
			v16162:Destroy();
		end);
		if v898.Look then
			v898.CFrame = v898.Look.CFrame;
			v898.Origin = v898.Look.CFrame + v898.Look.CFrame.lookVector;
			if v898.Forward then
				v898.CFrame = v898.CFrame + v898.Look.CFrame.lookVector * v898.Forward;
			end;
		end;
		if v898.Color then
			v16162.Color = v898.Color;
		end;
		v16162.Transparency = v898.Transparency or 0;
		v16162.Size = Vector3.new(v898.Size or 2.589, v898.Initial or 0.896, v898.Size or 2.589);
		v16162.CFrame = CFrame.new(v898.CFrame.p, v898.Part and v898.Part.CFrame.p or v898.Origin.p) * CFrame.Angles(1.5707963267948966, 0, 0);
		v16162.Parent = workspace.Thrown;
		if not v898.Add then
			v898.Add = 1;
		end;
		local v16163 = {
			Size = Vector3.new(9.874 * v898.Add, v898.NoScaleY and v16162.Size.Y or 0.1, 9.874 * v898.Add), 
			Transparency = 1
		};
		if v898.Down then
			v16163.Position = v16162.Position + v898.Down;
		end;
		v3:Create(v16162, TweenInfo.new(v898.Time or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v16163):Play();
	end,

	['Camshake'] = function(v898)
		if v898.Last then
			task.spawn(function()
				for _ = 1, v898.Last / 0.03 do
					local l_addshake_0 = shared.addshake;
					if l_addshake_0 then
						l_addshake_0(v898.Intensity);
					end;
					local l_v898_0 = v898;
					l_v898_0.Intensity = l_v898_0.Intensity * 0.9;
					task.wait(0.03);
				end;
			end);
			return ;
		else
			shared.addshake(v898.Intensity);
		end;
	end,

	['Whiteout'] = function(v898)
		local v15908 = l_LegacyReplication_0.Whiteout:Clone();
		if v898.Inverse then
			v15908.TintColor = Color3.new(0, 0, 0);
		end;
		v15908.Parent = game.Lighting;
		local v15909 = {};
		if v898.Sphere then
			for _ = 1, 1 do
				local v15911 = game.ReplicatedStorage.Resources.Sphere:Clone();
				v15911.Anchored = true;
				v15911.CanCollide = false;
				v15911.CanQuery = false;
				v15911.CFrame = v898.Sphere.CFrame + v898.Sphere.CFrame.lookVector * 20;
				v15911.Parent = workspace.Thrown;
				table.insert(v15909, v15911);
				v3:Create(v15911, TweenInfo.new(v898.Wait or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					Size = Vector3.new(40, 40, 487.7799987792969, 0), 
					CFrame = v15911.CFrame + v15911.CFrame.LookVector * 455 / 2
				}):Play();
			end;
		elseif v898.SphereTwo then
			for _ = 1, 1 do
				local v15913 = game.ReplicatedStorage.Resources.Sphere:Clone();
				v15913.Anchored = true;
				v15913.CanCollide = false;
				v15913.CanQuery = false;
				v15913.CFrame = v898.SphereTwo.CFrame + v898.SphereTwo.CFrame.lookVector * 20;
				v15913.Size = Vector3.new(40, 40, 487.7799987792969, 0);
				v15913.CFrame = v15913.CFrame + v15913.CFrame.LookVector * 455 / 2;
				v15913.Parent = workspace.Thrown;
				v3:Create(v15913, TweenInfo.new((v898.Wait or 0.2) + 0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Size = Vector3.new(0, 0, v15913.Size.Z)
				}):Play();
				table.insert(v15909, v15913);
			end;
		end;
		local v15914 = {
			v15908
		};
		local v15915 = {};
		if not v898.JustWhite then
			for _, v15917 in pairs({
				workspace.Thrown, 
				workspace.Live
				}) do
				local function v15920(v15918)
					local v15919 = l_LegacyReplication_0.Highlight:Clone();
					v15919.FillColor = v898.Inverse and Color3.new(1, 1, 1) or Color3.new(0, 0, 0);
					v15919.FillTransparency = 0;
					v15919.Adornee = v15918;
					v15919.Parent = v15918;
					v15919.Enabled = true;
					table.insert(v15914, v15919);
				end;
				if v15917 == workspace.Thrown then
					v15920(v15917);
				else
					for _, v15922 in pairs(v15917:GetChildren()) do
						local l_Highlight_11 = v15922:FindFirstChildOfClass("Highlight");
						if l_Highlight_11 then
							table.insert(v15915, {
								l_Highlight_11, 
								l_Highlight_11.Parent
							});
							l_Highlight_11.Parent = game.Lighting;
						end;
						v15920(v15922);
					end;
				end;
			end;
			for _, v15925 in pairs(v15909) do
				v15925.Transparency = 0;
			end;
		end;
		task.wait(v898.Wait or 0.2);
		if not v898.JustWhite then
			for _, v15927 in pairs(v15909) do
				v15927:Destroy();
			end;
			for _, v15929 in pairs(v15915) do
				if not pcall(function()
						v15929[1].Parent = v15929[2];
					end) then
					pcall(game.Destroy, v15929[1]);
				end;
			end;
			for _, v15931 in pairs(v15914) do
				v15931.Enabled = false;
				v15931:Destroy();
			end;
		else
			v15908:Destroy();
		end;
	end,

	['Flash'] = function(Params)
		local Character: Model = Params.Char

		local tasks = { -- Start 1.883
			task.delay(0, function()
				FlashstepModule(Character, .1)
			end);

			task.delay(0.03, function()
				FlashstepModule(Character, .1)
			end);

			task.delay(0.06, function()
				FlashstepModule(Character, .1)
			end);

			task.delay(0.10, function()
				FlashstepModule(Character, .1)
			end);

			task.delay(0.13, function()
				FlashstepModule(Character, .1)
			end);

			task.delay(0.14, function()
			end);

			task.delay(0.15, function()
				FlashstepModule(Character, .1)
			end);
		}
	end,

	['OmniMusic'] = function(Params)
		local Stage = Params.Stage
		if Stage == 'Start' then
			if LocalPlayer.Configuration['Awakening Music'].Value == true then
				Assets.Sounds.OmniMusic.Music.Volume = 6.5
				Assets.Sounds.OmniMusic.Music:Play()
			end
			return
		end
	end,

	['OmniPunch'] = function(v898)
		local Char: Model = v898.Char
		local l_Character_4 = LocalPlayer.Character;
		local l_Root_13 = v898.Root;
		local v15088 = {};
		local originalTransparency = {}
		for _, descendant in pairs(l_Character_4:GetDescendants()) do
			if descendant:IsA("BasePart") or descendant:IsA("Decal") then
				table.insert(originalTransparency, {
					part = descendant,
					transparency = descendant.Transparency
				})
			end
		end;
		task.delay(16.85, function()
			for _, data in pairs(originalTransparency) do
				data.part.Transparency = data.transparency
			end
		end)
		if Char ~= l_Character_4 then
			local originalTransparency = {}
			for _, descendant in ipairs(Char:GetDescendants()) do
				if descendant:IsA("BasePart") or descendant:IsA("Decal") then
					pcall(function()
						table.insert(originalTransparency, {
							part = descendant,
							transparency = descendant.Transparency
						})
					end)
				end
			end
			task.delay(16.85, function()
				for _, data in ipairs(originalTransparency) do
					pcall(function()
						data.part.Transparency = data.transparency
					end)
				end
			end)
		end
		shared.addshake(4);
		task.spawn(function()
			local v15092 = tick();
			local v15093 = 4;
			while true do
				task.wait();
				shared.addshake(v15093);
				v15093 = v15093 * 0.99;
				if not (tick() - v15092 <= 4) then
					break;
				end;
			end;
		end);
		local v15094 = nil;
		local l_Bind_13 = v898.Bind;
		local l_Position_69 = l_Root_13.Position;
		local v15097 = l_Root_13.CFrame * CFrame.new(0, 200.0999298, -40.1572266, 0.802054107, 0.461602062, -0.378989995, -0.58462131, 0.476968586, -0.656291902, -0.122179255, 0.747947037, 0.652417183);
		local v15098 = nil;
		local v15099 = nil;
		local v15100 = {};
		local l_Parent_14 = l_Root_13.Parent;
		local _ = {};
		local v15103 = {};
		local v15104 = {};
		local v15105 = {};
		local v15106 = 0;
		local v15107 = {};
		local l_CurrentCamera_24 = workspace.CurrentCamera;
		local l_Model_354 = Instance.new("Model");
		l_Model_354.Name = "OmniDebris";
		l_Model_354.Parent = workspace.Thrown;
		local v15110 = {};
		local v15111 = false;
		local v15112 = {};
		local v15113 = nil;
		do
			local l_v15094_0, l_v15098_0, l_v15099_0, l_v15106_0, l_v15111_0, l_v15113_0 = v15094, v15098, v15099, v15106, v15111, v15113;
			l_v15113_0 = function()
				l_v15111_0 = true;
				l_v15113_0 = function()
				end;
				for _, v15121 in pairs(v15110) do
					if typeof(v15121) ~= "table" then
						if typeof(v15121) == "RBXScriptConnection" then
							v15121:Disconnect();
						elseif v15121:IsA("AnimationTrack") then
							v15121:Stop();
						else
							v15121:Destroy();
						end;
					end;
				end;
			end;
			task.delay(30, l_v15113_0);
			local v15122 = {};
			local v15123, v15124 = shared.sfx({
				SoundId = "rbxassetid://119448305507853", 
				CFrame = v15097, 
				RollOffMaxDistance = 55000, 
				PlaybackSpeed = 0.1, 
				Volume = 10
			});
			table.insert(v15110, v15124);
			table.insert(v15122, v15124);
			local v15125 = false;
			local v15126 = false;
			local v15127 = "first";
			local v15128 = false;
			local l_Part_22 = Instance.new("Part");
			l_Part_22.Transparency = 1;
			l_Part_22.Material = Enum.Material.Neon;
			l_Part_22.Color = Color3.new(1, 0, 0);
			l_Part_22.Size = Vector3.new(15, 15, 15, 0);
			l_Part_22.Anchored = true;
			l_Part_22.CanCollide = false;
			l_Part_22.CanQuery = false;
			l_Part_22.CanTouch = false;
			l_Part_22.Parent = workspace.Thrown;
			table.insert(v15110, l_Part_22);
			table.insert(v15110, l_Model_354);
			local function v15136(v15130)
				if v898.User ~= l_LocalPlayer_0.Character and l_Bind_13.Value ~= l_LocalPlayer_0.Character then
					local l_Attachment_5 = Instance.new("Attachment");
					table.insert(v15110, l_Attachment_5);
					local v15132 = l_LegacyReplication_0.ImpactGlow:Clone();
					v15132.Parent = l_Attachment_5;
					l_Attachment_5.Parent = workspace.Terrain;
					l_Attachment_5.WorldCFrame = v15130;
					shared.resizeparticle(v15132, 2);
					local l_Position_70 = v15130.Position;
					local _, v15135 = workspace:FindFirstChildOfClass("Camera"):WorldToScreenPoint(l_Position_70);
					if v15135 then
						v15132:Emit(5);
					end;
					task.delay(0.26, function()
						v15132:Destroy();
					end);
				end;
			end;
			task.spawn(function()
				local v15137 = tick();
				local l_CFrameValue_8 = Instance.new("CFrameValue");
				table.insert(v15110, l_CFrameValue_8);
				local v15139 = true;
				local v15140 = 0;
				local v15141 = 0;
				local v15142 = 0;
				local v15143 = -1;
				local v15144 = 1;
				local l_v82_361 = v82;
				if not v15144 and v15143 then
					v15144 = v15143;
					v15143 = 1;
				end;
				if not v15144 and not v15143 then
					v15143 = 0;
					v15144 = 1;
				end;
				local v15146 = l_v82_361:NextNumber(v15143, v15144);
				v15143 = -1;
				v15144 = 1;
				l_v82_361 = v82;
				if not v15144 and v15143 then
					v15144 = v15143;
					v15143 = 1;
				end;
				if not v15144 and not v15143 then
					v15143 = 0;
					v15144 = 1;
				end;
				local v15147 = l_v82_361:NextNumber(v15143, v15144);
				v15143 = -1;
				v15144 = 1;
				l_v82_361 = v82;
				if not v15144 and v15143 then
					v15144 = v15143;
					v15143 = 1;
				end;
				if not v15144 and not v15143 then
					v15143 = 0;
					v15144 = 1;
				end;
				local v15148 = l_v82_361:NextNumber(v15143, v15144);
				while task.wait() and not l_Bind_13:GetAttribute("nocframeloop") and l_Bind_13.Parent and not l_Bind_13:GetAttribute("removeloop") and v898.User and v898.User.Parent do
					if v15127 ~= "still" then
						if v15127 == "first" then
							l_Part_22.CFrame = l_Model_354:GetBoundingBox();
						elseif tick() - v15137 > 0.1 then
							v15137 = tick();
							l_Part_22.CFrame = v699(v15088);
						end;
					end;
					for _, v15150 in pairs(v15122) do
						if not v15150:GetAttribute("Offset") then
							local v15151 = "Offset";
							local l_new_69 = CFrame.new;
							local v15153 = -1;
							local v15154 = 1;
							local l_v82_362 = v82;
							if not v15154 and v15153 then
								v15154 = v15153;
								v15153 = 1;
							end;
							if not v15154 and not v15153 then
								v15153 = 0;
								v15154 = 1;
							end;
							local v15156 = l_v82_362:NextNumber(v15153, v15154) * 100;
							v15154 = -1;
							l_v82_362 = 1;
							local l_v82_363 = v82;
							if not l_v82_362 and v15154 then
								l_v82_362 = v15154;
								v15154 = 1;
							end;
							if not l_v82_362 and not v15154 then
								v15154 = 0;
								l_v82_362 = 1;
							end;
							local v15158 = l_v82_363:NextNumber(v15154, l_v82_362) * 100;
							l_v82_362 = -1;
							l_v82_363 = 1;
							local l_v82_364 = v82;
							if not l_v82_363 and l_v82_362 then
								l_v82_363 = l_v82_362;
								l_v82_362 = 1;
							end;
							if not l_v82_363 and not l_v82_362 then
								l_v82_362 = 0;
								l_v82_363 = 1;
							end;
							v15150:SetAttribute(v15151, l_new_69(v15156, v15158, l_v82_364:NextNumber(l_v82_362, l_v82_363) * 100));
						end;
						v15150.WorldCFrame = v15150.WorldCFrame:lerp(l_Part_22.CFrame * v15150:GetAttribute("Offset"), 0.1);
					end;
					v15143 = l_Bind_13.Value;
					if v15143 and v15143.Parent then
						if v15139 then
							l_CFrameValue_8.Value = v15143.PrimaryPart.CFrame;
							v15139 = false;
						end;
						if v15127 == "still" then
							l_CFrameValue_8.Value = CFrame.new(v15143.PrimaryPart.Position);
						end;
						if v15128 then
							v15146 = v15146 / 3.75;
							v15147 = v15147 / 3.75;
							v15148 = v15148 / 3.75;
							v15128 = false;
						end;
						if v15126 then
							v15143.PrimaryPart.CFrame = v15143.PrimaryPart.CFrame:lerp(CFrame.new(l_CFrameValue_8.Value.Position, l_Position_69), 0.015);
						else
							v15143:SetPrimaryPartCFrame(l_CFrameValue_8.Value * CFrame.Angles(math.rad(v15140), math.rad(v15141), (math.rad(v15142))));
						end;
						v15140 = v15140 + v15146;
						v15141 = v15141 + v15147;
						v15142 = v15142 + v15148;
						l_CFrameValue_8.Value = l_CFrameValue_8.Value:lerp(l_Part_22.CFrame, 0.1);
					end;
				end;
			end);
			local v15160 = tick();
			local v15161 = nil;
			v15161 = function(v15162, v15163, v15164, v15165, v15166)
				v15123:Resume();
				local v15167 = typeof(v15162) == "Instance" and v15162 or l_v15094_0;
				if v15162 and v15162 == true then
					l_v15106_0 = l_v15106_0 + 1;
					v15167 = game.ReplicatedStorage.Resources.Omni.WooshTwo:Clone();
					table.insert(v15110, v15167);
					v15167.CFrame = (v15100[v15167] or v15164 or l_v15098_0).CFrame;
					local l_Trail_1 = v15167.Trail;
					local v15169 = 0.1;
					local v15170 = 0.2;
					local l_v82_365 = v82;
					if not v15170 and v15169 then
						v15170 = v15169;
						v15169 = 1;
					end;
					if not v15170 and not v15169 then
						v15169 = 0;
						v15170 = 1;
					end;
					l_Trail_1.Lifetime = l_v82_365:NextNumber(v15169, v15170);
					v15167.Trail.MaxLength = 0;
					for _, v15173 in pairs(v15167:GetChildren()) do
						if v15173:IsA("Attachment") then
							local l_Position_71 = v15173.Position;
							local v15175 = 1;
							local v15176 = 2;
							local l_v82_366 = v82;
							if not v15176 and v15175 then
								v15176 = v15175;
								v15175 = 1;
							end;
							if not v15176 and not v15175 then
								v15175 = 0;
								v15176 = 1;
							end;
							v15173.Position = l_Position_71 / l_v82_366:NextNumber(v15175, v15176);
							if v15163 then
								v15167.Trail.Enabled = false;
							end;
						end;
					end;
					v15167:SetAttribute("Length", v89(1, 2.5));
					v15167:SetAttribute("Started", tick());
					v15167.Parent = workspace.Thrown;
					l_Trail_1 = l_v15106_0 % 90 == 0;
				end;
				v15123.PlaybackSpeed = math.clamp(v15123.PlaybackSpeed + 0.047, 0, 1.15);
				local v15178 = 0;
				local v15179 = {};
				if not v15107[v15167] then
					v15107[v15167] = {};
				end;
				for _, v15181 in pairs(v15088) do
					local l_magnitude_3 = (v15181.Position - l_Root_13.Position).magnitude;
					if not v15107[v15167][v15181] and l_Position_69.Y < v15181.Position.Y and v15181 ~= l_v15098_0 and (not v15181:GetAttribute("Taken") or not v15165) then
						v15178 = l_magnitude_3;
						table.insert(v15179, v15181);
					end;
				end;
				if v15163 and #v15179 > 1 then
					table.sort(v15179, function(v15183, v15184)
						local l_CFrame_65 = v15167.CFrame;
						local l_Position_72 = v15184.Position;
						local v15187 = math.deg((math.acos((l_CFrame_65.LookVector:Dot((Vector3.new(l_Position_72.X, l_CFrame_65.p.Y, l_Position_72.Z) - l_CFrame_65.p).unit)))));
						l_Position_72 = v15167.CFrame;
						local l_Position_73 = v15183.Position;
						return math.deg((math.acos((l_Position_72.LookVector:Dot((Vector3.new(l_Position_73.X, l_Position_72.p.Y, l_Position_73.Z) - l_Position_72.p).unit))))) < v15187;
					end);
					v15179 = {
						v15179[1]
					};
				end;
				local v15189 = nil;
				if v15166 then
					v15189 = v15166;
				end;
				if v15165 and #v15179 > 1 and not v15166 then
					table.sort(v15179, function(v15190, v15191)
						return (l_Part_22.Position - v15190.Position).magnitude < (l_Part_22.Position - v15191.Position).magnitude;
					end);
					v15179 = {
						v15179[1]
					};
					v15179[1]:SetAttribute("Taken", true);
					v15189 = game.ReplicatedStorage.Resources.Clone_Rig:Clone();
					table.insert(v15110, v15189);
					if not v15189 then
						return ;
					else
						v15189:SetPrimaryPartCFrame(CFrame.new(2000000000, 2000000000, 2000000000));
						v15189.Parent = workspace.Thrown;
						v15189.PrimaryPart.Anchored = true;
						v15189.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
						v15189.Humanoid:ApplyDescription(l_Parent_14.Humanoid:GetAppliedDescription());
						for _, v15193 in pairs(v15189:GetDescendants()) do
							if v15193:IsA("BasePart") then
								v15193.CollisionGroup = "untouchable";
								v15193.Massless = true;
								v15193.CanCollide = false;
								v15193.CanTouch = false;
								v15193.CanQuery = false;
							end;
						end;
					end;
				end;
				if #v15179 == 0 then
					return v15167:Destroy();
				else
					local v15194 = v15100[v15167] and v15100[v15167].CFrame or v15167.CFrame;
					local v15195 = v15179[math.random(#v15179)];
					local v15196 = v15100[v15167];
					local v15197 = math.clamp((v15195.Position - v15167.Position).magnitude / 7000, 0, 0.2);
					v15107[v15167][v15195] = true;
					v15100[v15167] = v15195;
					local l_CFrame_66 = v15195.CFrame;
					if v15166 then
						local l_Value_3 = l_Bind_13.Value;
						l_Part_22 = l_Value_3.PrimaryPart;
						if (v15167.Position - l_Part_22.Position).magnitude <= 85 then
							v15136(v15195.CFrame);
							v15189:Destroy();
							v15195:Destroy();
							return ;
						else
							local v15200 = l_Part_22.Position + (v15167.Position - l_Part_22.Position).Unit * math.min(0.5, (l_Part_22.Position - v15167.Position).magnitude);
							local l_Position_74 = l_Part_22.Position;
							local l_Unit_0 = (v15167.Position - l_Part_22.Position).Unit;
							local v15203 = 16;
							local v15204 = 49;
							local l_v82_367 = v82;
							if not v15204 and v15203 then
								v15204 = v15203;
								v15203 = 1;
							end;
							if not v15204 and not v15203 then
								v15203 = 0;
								v15204 = 1;
							end;
							l_CFrame_66 = l_Position_74 + l_Unit_0 * math.min(l_v82_367:NextNumber(v15203, v15204) * 2, (l_Part_22.Position - v15167.Position).magnitude);
							l_CFrame_66 = CFrame.new(l_CFrame_66, l_Part_22.Position);
							v15200 = CFrame.new(v15200, l_Part_22.Position);
							l_Position_74 = game.ReplicatedStorage.Resources.Omni.Shockwave:Clone();
							l_Position_74.CFrame = CFrame.new(v15167.Position, v15200.Position) * CFrame.Angles(1.5707963267948966, 0, 0);
							local l_Mesh_17 = l_Position_74.Mesh;
							local v15207 = 0.1;
							local v15208 = 0.11;
							local l_v82_368 = v82;
							if not v15208 and v15207 then
								v15208 = v15207;
								v15207 = 1;
							end;
							if not v15208 and not v15207 then
								v15207 = 0;
								v15208 = 1;
							end;
							l_Unit_0 = l_v82_368:NextNumber(v15207, v15208);
							l_Mesh_17.Offset = Vector3.new(0, 0, 0, 0);
							l_Mesh_17.Scale = l_Mesh_17:GetAttribute("Scale") or l_Mesh_17.Scale;
							l_Mesh_17:SetAttribute("Offset", (Vector3.new()));
							l_Mesh_17:SetAttribute("Scale", l_Mesh_17.Scale);
							l_Mesh_17.Scale = l_Mesh_17.Scale * Vector3.new(0.20000000298023224, 1, 0.20000000298023224, 0);
							v15208 = 40;
							l_v82_368 = 75;
							v15203 = v82;
							if not l_v82_368 and v15208 then
								l_v82_368 = v15208;
								v15208 = 1;
							end;
							if not l_v82_368 and not v15208 then
								v15208 = 0;
								l_v82_368 = 1;
							end;
							v15207 = v15203:NextNumber(v15208, l_v82_368);
							table.insert(v15110, l_Position_74);
							table.insert(v15110, l_Mesh_17);
							v15208 = CFrame.new(v15189.PrimaryPart.Position, l_Value_3.PrimaryPart.Position);
							l_v82_368 = 0;
							v15203 = 20;
							v15204 = Instance.new("NumberValue");
							l_v82_367 = nil;
							do
								local l_v15200_0, l_l_v82_368_0, l_v15203_0, l_l_v82_367_0 = v15200, l_v82_368, v15203, l_v82_367;
								l_l_v82_367_0 = game:GetService("RunService").RenderStepped:Connect(function()
									if not v15189.Parent or not v15189.PrimaryPart then
										return l_l_v82_367_0:Disconnect();
									else
										local l_magnitude_4 = (l_v15200_0.Position - v15189.PrimaryPart.Position).magnitude;
										v15189.PrimaryPart.CFrame = v15189.PrimaryPart.CFrame:lerp(v15208 + v15208.lookVector * (l_l_v82_368_0 + v15204.Value), 0.2);
										l_l_v82_368_0 = 0;
										l_v15203_0 = 60 * (l_magnitude_4 / 50);
										return ;
									end;
								end);
								table.insert(v15110, l_l_v82_367_0);
								local v15215 = nil;
								if not l_v15099_0 then
									l_v15099_0 = true;
									v15215 = shared.sfx({
										SoundId = "rbxassetid://9043364058", 
										Parent = l_Value_3.PrimaryPart, 
										RollOffMaxDistance = 1000, 
										PlaybackSpeed = 1.5, 
										Volume = 10
									});
									v15215:Play();
								end;
								local v15216 = 15.8 - (tick() - v15160);
								v3:Create(v15204, TweenInfo.new(v15216, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
									Value = (l_v15200_0.Position - v15189.PrimaryPart.Position).magnitude
								}):Play();
								if v15215 then
									task.delay(v15216, function()
										v15215:Stop();
									end);
								end;
								if v15196 then
									local l_v3_23 = v3;
									local l_v15196_0 = v15196;
									local v15219 = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
									local v15220 = {};
									local l_CFrame_67 = v15196.CFrame;
									local l_Angles_38 = CFrame.Angles;
									local v15223 = -360;
									local v15224 = 360;
									local l_v82_369 = v82;
									if not v15224 and v15223 then
										v15224 = v15223;
										v15223 = 1;
									end;
									if not v15224 and not v15223 then
										v15223 = 0;
										v15224 = 1;
									end;
									local v15226 = math.rad((l_v82_369:NextNumber(v15223, v15224)));
									v15224 = -360;
									l_v82_369 = 360;
									local l_v82_370 = v82;
									if not l_v82_369 and v15224 then
										l_v82_369 = v15224;
										v15224 = 1;
									end;
									if not l_v82_369 and not v15224 then
										v15224 = 0;
										l_v82_369 = 1;
									end;
									local v15228 = math.rad((l_v82_370:NextNumber(v15224, l_v82_369)));
									l_v82_369 = -360;
									l_v82_370 = 360;
									local l_v82_371 = v82;
									if not l_v82_370 and l_v82_369 then
										l_v82_370 = l_v82_369;
										l_v82_369 = 1;
									end;
									if not l_v82_370 and not l_v82_369 then
										l_v82_369 = 0;
										l_v82_370 = 1;
									end;
									local v15230 = l_CFrame_67 * l_Angles_38(v15226, v15228, (math.rad((l_v82_371:NextNumber(l_v82_369, l_v82_370)))));
									l_Angles_38 = CFrame.new(v15196.Position, l_v15200_0.Position).lookVector;
									v15223 = 900;
									v15224 = 1212;
									l_v82_369 = v82;
									if not v15224 and v15223 then
										v15224 = v15223;
										v15223 = 1;
									end;
									if not v15224 and not v15223 then
										v15223 = 0;
										v15224 = 1;
									end;
									v15220.CFrame = v15230 + l_Angles_38 * -l_v82_369:NextNumber(v15223, v15224);
									l_v3_23:Create(l_v15196_0, v15219, v15220):Play();
								end;
							end;
						end;
					end;
					if v15165 and not v15166 then
						task.delay(v15197 / 2, function()
							shared.sfx({
								SoundId = ({
									"rbxassetid://126006253777533", 
									"rbxassetid://83476887981765", 
									"rbxassetid://80482105136360", 
									"rbxassetid://100119825336288"
								})[math.random(1, 4)], 
								Volume = 3, 
								Parent = v15195
							}):Play();
						end);
						task.delay(v15197 - 0.05, function()
							shared.sfx({
								SoundId = ({
									"rbxassetid://99317217027000", 
									"rbxassetid://99506722416457", 
									"rbxassetid://97218995052160"
								})[math.random(1, 3)], 
								Volume = 3, 
								Parent = v15195
							}):Play();
							shared.sfx({
								SoundId = "rbxassetid://115353434732097", 
								Volume = 3, 
								Parent = v15195
							}):Play();
						end);
						task.delay(v15197, function()
							v15195.Anchored = true;
							if not v15189 or v15125 then
								if v15125 then
									v15189:Destroy();
								end;
								local l_Position_75 = v15195.Position;
								local _, v15233 = workspace:FindFirstChildOfClass("Camera"):WorldToScreenPoint(l_Position_75);
								if not v15233 then
									v15136();
									v15195:Destroy();
									return ;
								else
									task.spawn(function()
										local v15234 = tick();
										while true do
											task.wait();
											local l_Position_76 = v15195.Position;
											local _, v15237 = workspace:FindFirstChildOfClass("Camera"):WorldToScreenPoint(l_Position_76);
											if not (v15237 and tick() - v15234 <= 5) then
												break;
											end;
										end;
										v15136(v15195.CFrame);
										v15195:Destroy();
									end);
									return ;
								end;
							else
								local l_Animation_19 = Instance.new("Animation");
								l_Animation_19.AnimationId = ({
									"rbxassetid://132291995867257", 
									"rbxassetid://124781295020995", 
									"rbxassetid://103158978854474", 
									"rbxassetid://74117599518097"
								})[math.random(1, 4)];
								l_Animation_19 = v15189.Humanoid.Animator:LoadAnimation(l_Animation_19);
								l_Animation_19:Play(0);
								l_Animation_19:AdjustSpeed(0.5);
								l_Animation_19:GetMarkerReachedSignal("freeze"):Connect(function()
									l_Animation_19:AdjustSpeed(3);
								end);
								l_Animation_19:GetMarkerReachedSignal("start"):Connect(function()
									l_Animation_19:AdjustSpeed(1);
								end);
								local v15239 = {};
								task.delay(8, function()
									for _, v15241 in pairs(v15239) do
										v15241:Disconnect();
									end;
								end);
								local l_Value_4 = l_Bind_13.Value;
								local l_CFrame_68 = v15195.CFrame;
								local l_lookVector_7 = CFrame.new(v15194.Position, v15195.Position).lookVector;
								local v15245 = 7;
								local v15246 = 12;
								local l_v82_372 = v82;
								if not v15246 and v15245 then
									v15246 = v15245;
									v15245 = 1;
								end;
								if not v15246 and not v15245 then
									v15245 = 0;
									v15246 = 1;
								end;
								local v15248 = l_CFrame_68 + l_lookVector_7 * (l_v82_372:NextNumber(v15245, v15246) * 2);
								v15248 = CFrame.new(v15248.Position, l_Value_4.PrimaryPart.Position) * CFrame.Angles(1.0471975511965976, 0, 0);
								l_CFrame_68 = v3;
								l_lookVector_7 = v15195;
								local l_new_70 = TweenInfo.new;
								v15246 = 0.6;
								l_v82_372 = 1;
								local l_v82_373 = v82;
								if not l_v82_372 and v15246 then
									l_v82_372 = v15246;
									v15246 = 1;
								end;
								if not l_v82_372 and not v15246 then
									v15246 = 0;
									l_v82_372 = 1;
								end;
								l_CFrame_68:Create(l_lookVector_7, l_new_70(l_v82_373:NextNumber(v15246, l_v82_372) * 2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									CFrame = v15248
								}):Play();
								l_CFrame_68 = {};
								if math.random(1, 2) == 1 then
									for _, v15252 in pairs(v15189:GetDescendants()) do
										if v15252:IsA("BasePart") or v15252:IsA("Decal") then
											table.insert(l_CFrame_68, {
												v15252, 
												v15252.Transparency
											});
											v15252.Transparency = 1;
										end;
									end;
								end;
								local v15253 = nil;
								v15253 = game:GetService("RunService").RenderStepped:Connect(function()
									if v15189:GetAttribute("NoLoop") then
										return v15253:Disconnect();
									elseif not (v15189 and v15189.Parent) or not l_Bind_13.Parent then
										return v15253:Disconnect();
									else
										v15189:SetPrimaryPartCFrame(v15179[1].CFrame * CFrame.new(0, 0, -v15179[1].Size.Z / 2 - 3) * CFrame.Angles(-1.5707963267948966, 0, 0));
										return ;
									end;
								end);
								table.insert(v15110, v15253);
								l_lookVector_7 = nil;
								l_lookVector_7 = l_Animation_19:GetMarkerReachedSignal("move"):Connect(function()
									shared.sfx({
										SoundId = ({
											"rbxassetid://99031045387290", 
											"rbxassetid://139820242583806", 
											"rbxassetid://112076104780801", 
											"rbxassetid://99031045387290"
										})[math.random(1, 4)], 
										PlaybackSpeed = 0.9, 
										Volume = 4, 
										CFrame = v15189.PrimaryPart.CFrame
									}):Play();
								end);
								table.insert(v15110, l_lookVector_7);
								table.insert(v15239, l_lookVector_7);
								l_new_70 = nil;
								l_new_70 = l_Animation_19:GetMarkerReachedSignal("end"):Connect(function()
									if not v15189.Parent or not v15189.PrimaryPart then
										return ;
									else
										local v15254 = false;
										if math.random(1, 2) == 1 then
											v15254 = true;
											if l_LocalPlayer_0.Character ~= v898.User then
												v15254 = l_LocalPlayer_0.Character == l_Bind_13.Value;
											end;
										end;
										v15189:SetAttribute("NoLoop", true);
										v15253:Disconnect();
										for _, v15256 in pairs(l_CFrame_68) do
											v15256[1].Transparency = 1;
										end;
										l_Animation_19:Stop();
										v15254 = Instance.new("Animation");
										v15254.AnimationId = ({
											"rbxassetid://89857380818682", 
											"rbxassetid://73980389837226", 
											"rbxassetid://108452466477886", 
											"rbxassetid://93022981682054"
										})[math.random(1, 4)];
										v15254 = v15189.Humanoid.Animator:LoadAnimation(v15254);
										v15254:Play(0);
										v15254:AdjustSpeed(0.1);
										table.insert(v15110, v15254);
										if l_LocalPlayer_0.Character ~= l_Bind_13.Value and l_LocalPlayer_0.Character ~= v898.User then
											v15161(v15179[1], nil, nil, nil, v15189);
											return ;
										else
											local l_PrimaryPart_66 = v15189.PrimaryPart;
											if l_PrimaryPart_66 then
												if not ((l_PrimaryPart_66.Position - l_Value_4.PrimaryPart.Position).magnitude > 50 and (not (l_LocalPlayer_0.Character ~= v898.User) or l_LocalPlayer_0.Character == l_Bind_13.Value)) or (l_PrimaryPart_66.Position - (l_Value_4.PrimaryPart.CFrame + l_Value_4.PrimaryPart.CFrame.lookVector * -1).Position).magnitude < (l_PrimaryPart_66.Position - (l_Value_4.PrimaryPart.CFrame + l_Value_4.PrimaryPart.CFrame.lookVector * 1).Position).magnitude then
													v15189:SetAttribute("NoLoop", true);
													v15136(v15195.CFrame);
													v15195:Destroy();
													v15189:Destroy();
													return ;
												else
													v15189:Destroy();
													return ;
												end;
											else
												local _ = l_Value_4.PrimaryPart.Position;
												local _ = (v15189.PrimaryPart.Position - l_Value_4.PrimaryPart.Position).Unit;
												local l_delay_5 = task.delay;
												local v15261 = 0;
												local v15262 = 0.2;
												local l_v82_374 = v82;
												if not v15262 and v15261 then
													v15262 = v15261;
													v15261 = 1;
												end;
												if not v15262 and not v15261 then
													v15261 = 0;
													v15262 = 1;
												end;
												l_delay_5(l_v82_374:NextNumber(v15261, v15262), function()
													for v15264 = 1, 4 do
														for _, v15266 in pairs(l_CFrame_68) do
															v15266[1].Transparency = 1;
														end;
														task.wait(0.02);
														if v15264 == 1 then
															local l_v15189_0 = v15189;
															local l_new_71 = CFrame.new;
															local l_CFrame_69 = l_Value_4.PrimaryPart.CFrame;
															local l_new_72 = CFrame.new;
															local v15271 = -30;
															local v15272 = 30;
															local l_v82_375 = v82;
															if not v15272 and v15271 then
																v15272 = v15271;
																v15271 = 1;
															end;
															if not v15272 and not v15271 then
																v15271 = 0;
																v15272 = 1;
															end;
															local v15274 = l_v82_375:NextNumber(v15271, v15272);
															v15272 = -30;
															l_v82_375 = 30;
															local l_v82_376 = v82;
															if not l_v82_375 and v15272 then
																l_v82_375 = v15272;
																v15272 = 1;
															end;
															if not l_v82_375 and not v15272 then
																v15272 = 0;
																l_v82_375 = 1;
															end;
															v15271 = l_v82_376:NextNumber(v15272, l_v82_375);
															l_v82_376 = 25;
															local v15276 = 30;
															local l_v82_377 = v82;
															if not v15276 and l_v82_376 then
																v15276 = l_v82_376;
																l_v82_376 = 1;
															end;
															if not v15276 and not l_v82_376 then
																l_v82_376 = 0;
																v15276 = 1;
															end;
															l_v15189_0:SetPrimaryPartCFrame(l_new_71((l_CFrame_69 * l_new_72(v15274, v15271, -l_v82_377:NextNumber(l_v82_376, v15276))).Position, l_Value_4.PrimaryPart.Position));
														end;
														for _, v15279 in pairs(l_CFrame_68) do
															v15279[1].Transparency = v15279[2];
														end;
														task.wait(0.02);
													end;
												end);
												task.spawn(function()

												end);
												return ;
											end;
										end;
									end;
								end);
								table.insert(v15239, l_new_70);
								table.insert(v15110, l_new_70);
								table.insert(v15105, {
									v15189, 
									l_Animation_19, 
									v15253, 
									v15167, 
									v15179[1]
								});
								for _, v15281 in pairs(l_CFrame_68) do
									v15281[1].Transparency = v15281[2];
								end;
								for _ = 1, 4 do
									for _, v15284 in pairs(l_CFrame_68) do
										v15284[1].Transparency = 1;
									end;
									task.wait(0.02);
									for _, v15286 in pairs(l_CFrame_68) do
										v15286[1].Transparency = v15286[2];
									end;
									task.wait(0.02);
								end;
								return ;
							end;
						end);
					end;
					if not v15166 then
						v3:Create(v15167, TweenInfo.new(v15197, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
							CFrame = l_CFrame_66
						}):Play();
					end;
					if v15165 then

					end;
					if math.random(1, 35) == 1 and not v15166 then
						local l_sfx_15 = shared.sfx;
						local v15288 = {
							SoundId = ({
								"rbxassetid://72887435242818", 
								"rbxassetid://106020638346106",
								"rbxassetid://122083949643268"
							})[math.random(1, 3)], 
							CFrame = v15194, 
							RollOffMaxDistance = 2500
						};
						local v15289 = 1.5;
						local v15290 = 2;
						local l_v82_378 = v82;
						if not v15290 and v15289 then
							v15290 = v15289;
							v15289 = 1;
						end;
						if not v15290 and not v15289 then
							v15289 = 0;
							v15290 = 1;
						end;
						v15288.PlaybackSpeed = l_v82_378:NextNumber(v15289, v15290);
						v15288.Volume = 0.5;
						l_sfx_15(v15288):Play();
					end;
					if math.random(1, 15) == 1 and not v15166 then
						local l_sfx_16 = shared.sfx;
						local v15293 = {
							SoundId = ({
								"rbxassetid://99031045387290", 
								"rbxassetid://139820242583806", 
								"rbxassetid://112076104780801", 
								"rbxassetid://81577803132927"
							})[math.random(1, 4)], 
							Volume = 1
						};
						local v15294 = 0.7;
						local v15295 = 1.2;
						local l_v82_379 = v82;
						if not v15295 and v15294 then
							v15295 = v15294;
							v15294 = 1;
						end;
						if not v15295 and not v15294 then
							v15294 = 0;
							v15295 = 1;
						end;
						v15293.PlaybackSpeed = l_v82_379:NextNumber(v15294, v15295);
						v15293.Parent = v15100[v15167];
						l_sfx_16(v15293):Play();
					end;
					if math.random(1, 45) == 1 and not v15166 then
						shared.sfx({
							SoundId = ({
								"rbxassetid://99317217027000", 
								"rbxassetid://99506722416457", 
								"rbxassetid://97218995052160"
							})[math.random(1, 3)], 
							Volume = 1.5, 
							Parent = v15100[v15167]
						}):Play();
						shared.sfx({
							SoundId = "rbxassetid://115353434732097",
							Volume = 1.5, 
							Parent = v15100[v15167]
						}):Play();
					end;
					task.delay(v15197, function()
						if not (v15195 ~= l_v15098_0 and not v15165) or v15195:GetAttribute("Taken") then
							return ;
						else
							local l_BodyAngularVelocity_7 = Instance.new("BodyAngularVelocity");
							local v15298 = Vector3.new(math.random(-10, 10), math.random(-5, 5), math.random(-6, 6));
							local v15299 = 0.5;
							local v15300 = 1;
							local l_v82_380 = v82;
							if not v15300 and v15299 then
								v15300 = v15299;
								v15299 = 1;
							end;
							if not v15300 and not v15299 then
								v15299 = 0;
								v15300 = 1;
							end;
							l_BodyAngularVelocity_7.AngularVelocity = v15298 * l_v82_380:NextNumber(v15299, v15300) * 0.25;
							l_BodyAngularVelocity_7.MaxTorque = Vector3.new(1, 1, 1, 0) * 2000000000;
							l_BodyAngularVelocity_7.Parent = v15195;
							game:GetService("Debris"):AddItem(l_BodyAngularVelocity_7, 0.15);
							table.insert(v15110, l_BodyAngularVelocity_7);
							if math.random(1, 10) == 1 then
								local l_v3_24 = v3;
								v15298 = v15195;
								local l_new_73 = TweenInfo.new;
								v15300 = 0.3;
								l_v82_380 = 0.6;
								local l_v82_381 = v82;
								if not l_v82_380 and v15300 then
									l_v82_380 = v15300;
									v15300 = 1;
								end;
								if not l_v82_380 and not v15300 then
									v15300 = 0;
									l_v82_380 = 1;
								end;
								l_new_73 = l_new_73(l_v82_381:NextNumber(v15300, l_v82_380), Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
								v15299 = {};
								l_v82_381 = v15195.CFrame;
								local l_lookVector_8 = CFrame.new(v15194.Position, v15195.Position).lookVector;
								local v15306 = 2;
								local v15307 = 5;
								local l_v82_382 = v82;
								if not v15307 and v15306 then
									v15307 = v15306;
									v15306 = 1;
								end;
								if not v15307 and not v15306 then
									v15306 = 0;
									v15307 = 1;
								end;
								l_v82_380 = l_v82_381 + l_lookVector_8 * l_v82_382:NextNumber(v15306, v15307);
								l_v82_381 = CFrame.Angles;
								local v15309 = -360;
								v15306 = 360;
								v15307 = v82;
								if not v15306 and v15309 then
									v15306 = v15309;
									v15309 = 1;
								end;
								if not v15306 and not v15309 then
									v15309 = 0;
									v15306 = 1;
								end;
								local v15310 = math.rad((v15307:NextNumber(v15309, v15306)));
								v15306 = -360;
								v15307 = 360;
								l_v82_382 = v82;
								if not v15307 and v15306 then
									v15307 = v15306;
									v15306 = 1;
								end;
								if not v15307 and not v15306 then
									v15306 = 0;
									v15307 = 1;
								end;
								l_lookVector_8 = math.rad((l_v82_382:NextNumber(v15306, v15307)));
								v15307 = -360;
								l_v82_382 = 360;
								local l_v82_383 = v82;
								if not l_v82_382 and v15307 then
									l_v82_382 = v15307;
									v15307 = 1;
								end;
								if not l_v82_382 and not v15307 then
									v15307 = 0;
									l_v82_382 = 1;
								end;
								v15299.CFrame = l_v82_380 * l_v82_381(v15310, l_lookVector_8, (math.rad((l_v82_383:NextNumber(v15307, l_v82_382)))));
								l_v3_24:Create(v15298, l_new_73, v15299):Play();
							end;
							return ;
						end;
					end);
					if v15167 and v15167:GetAttribute("Started") and v15167:GetAttribute("Length") and tick() - (v15167:GetAttribute("Started") or 0) < v15167:GetAttribute("Length") and not v15165 then
						local l_delay_6 = task.delay;
						local v15313 = v15197 + 0.1;
						local v15314 = v15197 + 0.3;
						local l_v82_384 = v82;
						if not v15314 and v15313 then
							v15314 = v15313;
							v15313 = 1;
						end;
						if not v15314 and not v15313 then
							v15313 = 0;
							v15314 = 1;
						end;
						l_delay_6(l_v82_384:NextNumber(v15313, v15314), function()
							if not v15167:GetAttribute("Added") then
								v15167:SetAttribute("Added", true);
								local v15316 = 1;
								local v15317 = 1;
								local v15318 = 2;
								local l_v82_385 = v82;
								if not v15318 and v15317 then
									v15318 = v15317;
									v15317 = 1;
								end;
								if not v15318 and not v15317 then
									v15317 = 0;
									v15318 = 1;
								end;
								for _ = v15316, l_v82_385:NextInteger(v15317, v15318) do
									if l_v15106_0 <= 75 then
										v15161(true, nil, v15167);
									end;
								end;
							end;
							v15161(v15167);
						end);
					elseif v15165 or v15166 then
						return ;
					else
						v15127 = "still";
						local v15321 = 2;
						if not (l_LocalPlayer_0.Character ~= l_Bind_13.Value) or v898.User == l_LocalPlayer_0.Character then
							v15321 = 1;
						end;
						if math.random(1, v15321) == 1 then
							v15161(v15167, nil, nil, true);
						end;
					end;
					return ;
				end;
			end;
			local v15322 = false;
			local v15323 = nil;
			for _, v15325 in pairs(v898.User.Humanoid:GetPlayingAnimationTracks()) do
				if v15325.Animation.AnimationId == "rbxassetid://122295918144799" then
					v15323 = v15325;
				end;
			end;
			local function v15589(v15326)
				if v15326 then
					v15326:Disconnect();
				end;
				if not v15322 then
					v15322 = true;
					for _ = 1, 5 do
						shared.sfx({
							SoundId = "rbxassetid://121306002500786", 
							CFrame = v898.Root.CFrame, 
							RollOffMaxDistance = 5000, 
							Volume = 10
						}):Play();
					end;
					local v15328 = {};
					for _, v15330 in pairs(v898.User:GetDescendants()) do
						if v15330:IsA("BasePart") or v15330:IsA("Decal") then
							if v15330:IsA("BasePart") then
								v15330.CollisionGroup = "nocol";
							end;
							table.insert(v15328, {
								v15330, 
								v15330.Transparency
							});
							v15330.Transparency = 1;
						end;
					end;
					task.delay(0.2, function()
						for _, v15332 in pairs(v15328) do
							if v15332[1]:IsA("BasePart") then
								v15332[1].CollisionGroup = "playercol";
							end;
							v15332[1].Transparency = v15332[2];
						end;
					end);
					task.spawn(function()
						shared.repfire('Backhand', { 
							Origin = v898.Root.CFrame + Vector3.new(0, 45, 0, 0), 
							CFrame = v898.Root.CFrame + Vector3.new(0, -10, 0, 0), 
							Initial = 65, 
							Transparency = 0, 
							Time = 0.15, 
							Down = Vector3.new(0, 0, 0, 0), 
							Size = 1, 
							Add = 55
						});
					end);
					if v898.User ~= l_LocalPlayer_0.Character and l_Bind_13.Value ~= l_LocalPlayer_0.Character then
						task.spawn(function()
							shared.repfire('Camshake', { 
								Intensity = 5
							});
						end);
					end;
					local v15333, v15334 = v556({
						orig = l_Root_13.Position, 
						dir = Vector3.new(0, -25, 0, 0)
					});
					task.delay(0.6, function()
						for _ = 1, 5 do
							shared.sfx({
								SoundId = "rbxassetid://127606787857563", 
								CFrame = CFrame.new(v15334), 
								RollOffMaxDistance = 5000, 
								Volume = 10
							}):Play();
						end;
						task.spawn(function()
							if v898.User ~= l_LocalPlayer_0.Character and l_Bind_13.Value ~= l_LocalPlayer_0.Character then
								shared.repfire('Camshake', { 
									Intensity = 19, 
									Last = 1
								});
							end;
						end);
						if v15333 then
							local v15336 = l_LegacyReplication_0.Wind:Clone();
							v15336.Parent = workspace.Thrown;
							v15336.Position = v15334 - Vector3.new(0, 25, 0, 0);
							v15336.UpSmoke.Color = ColorSequence.new(v15333.Color);
							v15336.UpSmoke:Emit(25);
							game:service("Debris"):AddItem(v15336, 6);
							table.insert(v15110, v15336);
						end;
						for v15337 = 1, 5 do
							local v15339 = shared.repfire('Ground Crater', { 
								Seed = v898.Seed + v15337, 
								start = v15334 + Vector3.new(0, 0.20000000298023224, 0, 0), 
								["end"] = Vector3.new(0, -14, 0, 0), 
								size = v15337 * 8, 
								sizemult = v15337 + 6, 
								amount = 7.5, 
								nodebris = true, 
								NoUpSmoke = true, 
								nosound = true, 
								nosmoke = true
							});
							local v15340 = false;
							if v15337 == 1 then
								v15340 = {
									minus = -3
								};
							end;
							task.wait(0.095);
						end;
					end);
					v15322 = true;
					shared.sfx({
						SoundId = "rbxassetid://107493442563003", 
						Parent = l_Root_13, 
						Volume = 1
					}):Play();
					local v15341 = l_LegacyReplication_0.ImpactGlow:Clone();
					local l_Attachment_6 = Instance.new("Attachment");
					l_Attachment_6.Parent = workspace.Terrain;
					l_Attachment_6.WorldPosition = l_Root_13.Position;
					v15341.Parent = l_Attachment_6;
					shared.resizeparticle(v15341, 3);
					table.insert(v15110, l_Attachment_6);
					table.insert(v15110, v15341);
					v15341:Emit(5);
					game:GetService("Debris"):AddItem(l_Attachment_6, 6);
					task.delay(0.35, function()
						v15341:Destroy();
						l_Attachment_6:Destroy();
					end);
					local v15343 = game.ReplicatedStorage.Resources.Omni.Woosh:Clone();
					v15343.CFrame = l_Root_13.CFrame;
					v15343.Parent = workspace.Thrown;
					l_v15094_0 = v15343;
					table.insert(v15110, v15343);
					local v15344 = false;
					local v15345 = nil;
					do
						local l_v15344_0, l_v15345_0 = v15344, v15345;
						l_v15345_0 = game:GetService("RunService").RenderStepped:Connect(function()
							if not l_Bind_13.Parent then
								return l_v15345_0:Disconnect();
							else
								if l_v15098_0 and not l_v15344_0 then
									l_v15098_0.CFrame = l_v15098_0.CFrame:lerp(CFrame.new(l_v15098_0.Position, l_Position_69), 0.25);
								end;
								v15343.CFrame = CFrame.new(l_Root_13.CFrame.Position, (l_v15098_0 or CFrame.new()).Position);
								return ;
							end;
						end);
						local v15348 = 0;
						for _, v15350 in pairs(v15088) do
							local l_magnitude_5 = (v15350.Position - l_Root_13.Position).magnitude;
							if v15348 < l_magnitude_5 then
								local l_CFrame_70 = l_Root_13.CFrame;
								local l_Position_78 = v15350.Position;
								if math.deg((math.acos((l_CFrame_70.LookVector:Dot((Vector3.new(l_Position_78.X, l_CFrame_70.p.Y, l_Position_78.Z) - l_CFrame_70.p).unit))))) <= 25 and l_Position_69.Y < v15350.Position.Y then
									v15348 = l_magnitude_5;
									l_v15098_0 = v15350;
								end;
							end;
						end;
						l_v15098_0.Anchored = true;
						l_v15098_0.Parent = workspace.Thrown;
						table.remove(v15088, table.find(v15088, l_v15098_0));
						v15100[l_v15094_0] = l_v15098_0;
						local v15354 = v699(v15088);
						for _, v15356 in pairs(v15104) do
							local l_Parent_15 = v15356.Parent;
							if l_Parent_15 and l_Parent_15 ~= l_v15098_0 then
								local v15358 = CFrame.new(l_v15098_0.Position, l_Position_69);
								local l_Velocity_0 = v15356.Velocity;
								local l_LookVector_0 = CFrame.new(l_Parent_15.Position, (v15358 - v15358.lookVector * 500).Position).LookVector;
								local v15361 = 300;
								local v15362 = 310;
								local l_v82_386 = v82;
								if not v15362 and v15361 then
									v15362 = v15361;
									v15361 = 1;
								end;
								if not v15362 and not v15361 then
									v15361 = 0;
									v15362 = 1;
								end;
								v15356.Velocity = l_Velocity_0 + l_LookVector_0 * (l_v82_386:NextNumber(v15361, v15362) * 1.75);
								v15356.Velocity = v15356.Velocity + CFrame.new(l_Parent_15.Position, v15354.Position).lookVector * -100;
								v15356.Velocity = v15356.Velocity + Vector3.new(0, l_Parent_15.Size.magnitude * 50, 0);
								local l_LookVector_1 = CFrame.new(l_Parent_15.Position, (v15358 - v15358.lookVector * 500).Position).LookVector;
								local v15365 = 10;
								local v15366 = 30;
								v15361 = v82;
								if not v15366 and v15365 then
									v15366 = v15365;
									v15365 = 1;
								end;
								if not v15366 and not v15365 then
									v15365 = 0;
									v15366 = 1;
								end;
								l_Velocity_0 = l_LookVector_1 * v15361:NextNumber(v15365, v15366);
								l_Velocity_0 = Vector3.new(l_Velocity_0.X, 0, l_Velocity_0.Z);
								l_LookVector_1 = v3;
								v15365 = v15356;
								v15366 = TweenInfo.new;
								v15362 = 1;
								l_v82_386 = 1.5;
								local l_v82_387 = v82;
								if not l_v82_386 and v15362 then
									l_v82_386 = v15362;
									v15362 = 1;
								end;
								if not l_v82_386 and not v15362 then
									v15362 = 0;
									l_v82_386 = 1;
								end;
								v15366 = v15366(l_v82_387:NextNumber(v15362, l_v82_386), Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
								v15361 = {};
								l_v82_386 = l_Velocity_0 / 2;
								local v15368 = 0;
								local v15369 = 5;
								local v15370 = 10;
								local l_v82_388 = v82;
								if not v15370 and v15369 then
									v15370 = v15369;
									v15369 = 1;
								end;
								if not v15370 and not v15369 then
									v15369 = 0;
									v15370 = 1;
								end;
								v15361.Velocity = l_v82_386 + Vector3.new(v15368, l_v82_388:NextNumber(v15369, v15370), 0);
								l_LookVector_1:Create(v15365, v15366, v15361):Play();
							end;
						end;
						task.delay(10, function()
							for _, v15373 in pairs(v15104) do
								local l_Parent_16 = v15373.Parent;
								if l_Parent_16 and l_Parent_16 ~= l_v15098_0 then
									local l_v3_25 = v3;
									local l_v15373_0 = v15373;
									local l_new_74 = TweenInfo.new;
									local v15378 = 6;
									local v15379 = 7;
									local l_v82_389 = v82;
									if not v15379 and v15378 then
										v15379 = v15378;
										v15378 = 1;
									end;
									if not v15379 and not v15378 then
										v15378 = 0;
										v15379 = 1;
									end;
									l_v3_25:Create(l_v15373_0, l_new_74(l_v82_389:NextNumber(v15378, v15379) * 3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
										Velocity = Vector3.new(0, -l_Parent_16.Size.magnitude * 12, 0)
									}):Play();
								end;
							end;
						end);
						task.delay(0, function()
							task.delay(0.35, function()
								v15343.Trail.Enabled = false;
							end);
							shared.sfx({
								SoundId = "rbxassetid://114697362090778", 
								Parent = l_Root_13, 
								RollOffMaxDistance = 1000, 
								Volume = 10
							}):Play();
							for _, v15382 in pairs({
								"Effect", 
								"ImpactGlow", 
								"ImpactGlowBigger"
								}) do
								local l_v15343_FirstChild_0 = v15343:FindFirstChild(v15382);
								if l_v15343_FirstChild_0 then
									task.delay(l_v15343_FirstChild_0:GetAttribute("EmitDelay") or 0, function()
										if l_v15343_FirstChild_0.Name == "ImpactGlowBigger" then
											v15343.ImpactGlow:Clear();
										end;
										shared.resizeparticle(l_v15343_FirstChild_0, 0.96);
										l_v15343_FirstChild_0:Emit(l_v15343_FirstChild_0:GetAttribute("EmitCount"));
									end);
								end;
							end;
							task.delay(0.30000000000000004, function()
								for _, v15385 in pairs({
									"Effect", 
									"ImpactGlow", 
									"ImpactGlowBigger"
									}) do
									local l_v15343_FirstChild_1 = v15343:FindFirstChild(v15385);
									if l_v15343_FirstChild_1 then
										l_v15343_FirstChild_1:Clear();
									end;
								end;
								local l_Shock_4 = v15343.Shock;
								local l_Wind_3 = v15343.Wind;
								l_Shock_4.Decal.Transparency = 0;
								l_Wind_3.Decal.Transparency = 0;
								v3:Create(l_Shock_4.Mesh, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
									Scale = Vector3.new(l_Shock_4.Mesh.Scale.X * 2.5, 0, 0), 
									Offset = Vector3.new(130, 0, 0, 0)
								}):Play();
								v3:Create(l_Wind_3.Mesh, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
									Scale = Vector3.new(l_Wind_3.Mesh.Scale.X * 5, l_Wind_3.Mesh.Scale.Y * 75, l_Wind_3.Mesh.Scale.Z * 5), 
									Offset = Vector3.new(0, 90, 0, 0)
								}):Play();
								v3:Create(l_Wind_3.Decal, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
									Transparency = 1
								}):Play();
								local v15389 = nil;
								v15389 = game:GetService("RunService").RenderStepped:Connect(function()
									if not (l_Bind_13.Parent and l_Wind_3.Parent) or not l_Shock_4.Parent then
										return v15389:Disconnect();
									else
										l_Shock_4.CFrame = CFrame.new(v15343.Position, l_v15098_0.Position) * CFrame.Angles(0, -1.5707963267948966, 0);
										l_Wind_3.CFrame = CFrame.new(v15343.Position, l_v15098_0.Position) * CFrame.Angles(1.5707963267948966, 0, 0);
										return ;
									end;
								end);
								task.delay(0.13, function()
									l_Wind_3:Destroy();
									l_Shock_4:Destroy();
									shared.resizeparticle(v15343.ImpactGlow, 1.15);
									v15343.ImpactGlow.Lifetime = NumberRange.new(1, 1);
									v15343.ImpactGlow.ZOffset = 1;
									v15343.ImpactGlow:Emit(5);
									for _ = 1, 25 do
										shared.resizeparticle(v15343.ImpactGlow, 0.7);
										task.wait();
									end;
									v15343.ImpactGlow:Clear();
								end);
							end);
						end);
						local v15391 = CFrame.new(l_v15098_0.Position, l_Position_69) * (CFrame.new(0, 0, -l_v15098_0.Size.Z / 2 + 3) * CFrame.Angles(-1.5707963267948966, 0, 0));
						v15103[l_v15094_0] = {};
						table.insert(v15103[l_v15094_0], l_v15098_0);
						local l_CFrameValue_9 = Instance.new("CFrameValue");
						l_CFrameValue_9.Value = l_Root_13.CFrame;
						local v15393 = nil;
						v15393 = l_CFrameValue_9:GetPropertyChangedSignal("Value"):Connect(function()
							if l_Parent_14:GetAttribute("doneso") then
								return ;
							else
								local l_Value_5 = l_CFrameValue_9.Value;
								local v15395 = {
									v15391:GetComponents()
								};
								v15395[1] = l_Value_5.X;
								v15395[2] = l_Value_5.Y;
								v15395[3] = l_Value_5.Z;
								v15395 = CFrame.new(unpack(v15395));
								l_Parent_14:PivotTo(v15395);
								return ;
							end;
						end);
						v3:Create(l_CFrameValue_9, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							Value = v15391
						}):Play();
						local v15396 = shared.sfx({
							SoundId = "rbxassetid://91498652584642", 
							Parent = l_Root_13, 
							TimePosition = 0.3, 
							Volume = 10
						});
						local l_PrimaryPart_67 = l_Bind_13.Value.PrimaryPart;
						if not l_LocalPlayer_0.Character or l_LocalPlayer_0.Character.PrimaryPart ~= l_Root_13 then

						end;
						local v15398 = require(l_Parent_14.CharacterHandler:FindFirstChild("AnimationPlayer") or l_Parent_14.CharacterHandler:WaitForChild("AnimationPlayer"));
						local l_v15398_0 = v15398 --[[ copy: 18 -> 32 ]];
						local function v15401(v15400)
							return l_v15398_0.playAnimation(game.FindFirstChild(l_Parent_14, "Humanoid"), v15400);
						end;
						v15398 = nil;
						local v15402 = false;
						do
							local l_v15398_1, l_v15402_0 = v15398, v15402;
							task.delay(0.3, function()
								local v15405 = v15401(99212251277360);
								v15405:Play(0);
								local v15406 = {};
								v15127 = "jump";
								v15396:Resume();
								shared.sfx({
									SoundId = "rbxassetid://72444760689158", 
									Parent = l_v15098_0, 
									Volume = 10
								}):Play();
								shared.sfx({
									SoundId = ({
										"rbxassetid://99317217027000", 
										"rbxassetid://99506722416457", 
										"rbxassetid://97218995052160"
									})[math.random(1, 3)], 
									Volume = 9, 
									Parent = l_v15098_0
								}):Play();
								for _ = 1, 2 do
									shared.sfx({
										SoundId = "rbxassetid://124538776908392", 
										Volume = 7, 
										Parent = l_v15098_0
									}):Play();
								end;
								table.insert(v15406, v15405:GetMarkerReachedSignal("freeze"):Connect(function()
									v15405:AdjustSpeed(0);
									task.wait(0.5);
									v15405:AdjustSpeed(1);
								end));
								table.insert(v15406, v15405:GetMarkerReachedSignal("move"):Connect(function()
									v15126 = true;
									v15127 = "still";
									shared.sfx({
										SoundId = ({
											"rbxassetid://116351329078573", 
											"rbxassetid://78993976253707", 
											"rbxassetid://112522905270229", 
											"rbxassetid://77929441477307", 
											"rbxassetid://83286680567219"
										})[math.random(1, 5)], 
										Volume = 3, 
										Parent = l_Root_13
									}):Play();
									shared.sfx({
										SoundId = ({
											"rbxassetid://81577803132927", 
											"rbxassetid://112076104780801", 
											"rbxassetid://139820242583806", 
											"rbxassetid://99031045387290"
										})[math.random(1, 4)], 
										PlaybackSpeed = 0.9, 
										Volume = 10, 
										Parent = l_v15098_0
									}):Play();
								end));
								table.insert(v15406, v15405:GetMarkerReachedSignal("start"):Connect(function()
								end));
								local v15408 = nil;
								table.insert(v15406, v15405:GetMarkerReachedSignal("end"):Connect(function()
									l_v15402_0 = true;
									local function v15439(v15409)
										local l_Value_6 = l_Bind_13.Value;
										local v15411 = l_LegacyReplication_0.ImpactGlow:Clone();
										local l_Attachment_7 = Instance.new("Attachment");
										l_Attachment_7.Parent = workspace.Terrain;
										table.insert(v15110, l_Attachment_7);
										l_Attachment_7.WorldPosition = l_Value_6.PrimaryPart.Position;
										v15411.Texture = "rbxassetid://14859461973";
										v15411.Parent = l_Attachment_7;
										table.insert(v15110, v15411);
										local v15413 = nil;
										if not v15409 and (not (v898.User ~= l_LocalPlayer_0.Character) or l_Bind_13.Value == l_LocalPlayer_0.Character) then
											l_Bind_13:SetAttribute("doneso", true);
											for _, v15415 in pairs(v15110) do
												if typeof(v15415) == "RBXScriptConnection" and v15415 then
													v15415:Disconnect();
												end;
											end;
											if v898.User == l_LocalPlayer_0.Character then
												l_LocalPlayer_0.Character:SetPrimaryPartCFrame(l_Bind_13:GetAttribute("startcfr"));
											else
												l_LocalPlayer_0.Character:SetAttribute("Override", true);
												local l_Part_23 = Instance.new("Part");
												l_Part_23.Anchored = true;
												l_Part_23.CanCollide = false;
												l_Part_23.Transparency = 1;
												l_Part_23.CanQuery = false;
												l_Part_23.CFrame = l_Bind_13:GetAttribute("startcfr");
												l_Part_23.Parent = workspace.Thrown;
												table.insert(v15110, l_Part_23);
												l_CurrentCamera_24.CameraSubject = l_Part_23;
												l_CurrentCamera_24.CameraType = "Custom";
											end;
											local v15417 = l_CurrentCamera_24.CFrame:ToObjectSpace(l_Value_6.PrimaryPart.CFrame);
											v15413 = Instance.new("Attachment");
											v15413.Parent = workspace.Terrain;
											if not (l_Bind_13.Value ~= l_LocalPlayer_0.Character) or v898.User == l_LocalPlayer_0.Character then
												v15413.WorldCFrame = l_CurrentCamera_24.CFrame * CFrame.new(0, 0, -15);
											else
												v15413.WorldCFrame = l_CurrentCamera_24.CFrame * v15417;
											end;
											table.insert(v15110, v15413);
											v15411.Parent = v15413;
											task.delay(0.5, function()
												v15413:Destroy();
											end);
											local v15418 = nil;
											local l_v15417_0 = v15417 --[[ copy: 5 -> 10 ]];
											do
												local l_v15418_0 = v15418;
												l_v15418_0 = game:GetService("RunService").RenderStepped:Connect(function()
													if not v15413.Parent then
														return l_v15418_0:Disconnect();
													elseif l_Bind_13.Value == l_LocalPlayer_0.Character then
														v15413.WorldCFrame = l_CurrentCamera_24.CFrame * CFrame.new(0, 0, -15);
														return ;
													else
														v15413.WorldCFrame = l_CurrentCamera_24.CFrame * l_v15417_0;
														return ;
													end;
												end);
												table.insert(v15110, l_v15418_0);
											end;
										end;
										shared.sfx({
											SoundId = "rbxassetid://77449588680650", 
											CFrame = l_Value_6.PrimaryPart.CFrame, 
											Volume = v15409 and 4 or 10, 
											RollOffMaxDistance = 1000, 
											RollOffMode = Enum.RollOffMode.LinearSquare
										}):Play();
										v15411.ZOffset = v15409 and 10 or 4;
										v15411.Lifetime = NumberRange.new(1, 1);
										local l_NumberValue_22 = Instance.new("NumberValue");
										local function v15426(v15422)
											local v15423 = {};
											for _, v15425 in pairs(v15411.Size.Keypoints) do
												table.insert(v15423, NumberSequenceKeypoint.new(v15425.Time, v15422 or l_NumberValue_22.Value, v15425.Envelope));
											end;
											v15411.Size = NumberSequence.new(v15423);
										end;
										table.insert(v15110, l_NumberValue_22);
										l_NumberValue_22:GetPropertyChangedSignal("Value"):Connect(v15426);
										l_NumberValue_22.Value = v15409 and 1250 or 120;
										v15426(l_NumberValue_22.Value);
										v3:Create(l_NumberValue_22, TweenInfo.new(v15409 and 0.25 or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
											Value = 0
										}):Play();
										if v15409 then
											local v15427 = game.ReplicatedStorage.Resources.Omni.Windd.Wind:Clone();
											v15427.Parent = workspace.Terrain;
											v15427.WorldPosition = l_Value_6.PrimaryPart.Position;
											v15427.Main:Emit(25);
										end;
										task.delay(0.03, function()
											if v15413 then
												l_CurrentCamera_24.CameraType = Enum.CameraType.Custom;
											end;
											if l_Value_6 then
												for _, v15429 in pairs(l_Value_6:GetDescendants()) do
													if v15429.Name == "BandageBlood" then
														v15429:Destroy();
													elseif v15429:IsA("SurfaceGui") then
														v15429.Enabled = false;
													end;
													if v15429:IsA("BasePart") or v15429:IsA("Decal") then
														v15429.Transparency = 1;
													elseif not (not v15429:IsA("Trail") and not v15429:IsA("Beam")) or v15429:IsA("ParticleEmitter") then
														v15429:Destroy();
													end;
												end;
											end;
											if v15409 then
												pcall(function()
													for _, v15431 in pairs(v15105) do
														v15431[1]:SetAttribute("NoLoop", true);
														v15431[3]:Disconnect();
														v15431[1]:Destroy();
													end;
												end);
												for _, v15433 in pairs(v15088) do
													if v15433 and v15433.Parent then
														v15433:ClearAllChildren();
														v15433.Anchored = false;
														local l_BodyVelocity_18 = Instance.new("BodyVelocity");
														l_BodyVelocity_18.MaxForce = Vector3.new(1, 1, 1, 0) * 1e999;
														local l_lookVector_9 = CFrame.new(v15433.Position, l_Value_6.PrimaryPart.Position).lookVector;
														local v15436 = 700;
														local v15437 = 800;
														local l_v82_390 = v82;
														if not v15437 and v15436 then
															v15437 = v15436;
															v15436 = 1;
														end;
														if not v15437 and not v15436 then
															v15436 = 0;
															v15437 = 1;
														end;
														l_BodyVelocity_18.Velocity = l_lookVector_9 * -l_v82_390:NextNumber(v15436, v15437);
														l_BodyVelocity_18.Parent = v15433;
														game:GetService("Debris"):AddItem(l_BodyVelocity_18, 0.15);
													end;
												end;
											end;
										end);
										task.delay(1, function()
											l_NumberValue_22:Destroy();
										end);
										v15411:Emit(5);
									end;
									if l_LocalPlayer_0.Character ~= v898.User and l_LocalPlayer_0.Character ~= l_Bind_13.Value then
										task.delay(10.05, function()
											v15439(true);
										end);
									end;
									if not (l_LocalPlayer_0.Character ~= v898.User) or l_LocalPlayer_0.Character == l_Bind_13.Value then
										if not l_v15111_0 then
											l_CurrentCamera_24.CameraType = Enum.CameraType.Scriptable;
										end;
										local v15440 = game.ReplicatedStorage.Resources.Omni.Fist:Clone();
										v15440.Size = Vector3.new(1, 1, 1, 0);
										v15440.CFrame = workspace.Preload.Dirt.CFrame;
										v15440.Parent = workspace.Thrown;
										table.insert(v15110, v15440);
										local v15441 = shared.sfx({
											SoundId = "rbxassetid://1845163717", 
											Parent = workspace, 
											TimePosition = 7.5, 
											Volume = 0
										});
										v15441:Play();
										v3:Create(v15441, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
											Volume = 3
										}):Play();
										local l_Value_7 = l_Bind_13.Value;
										local v15443 = l_CurrentCamera_24.CFrame.Position + CFrame.new(l_CurrentCamera_24.CFrame.Position, l_v15098_0.Position).lookVector * -5;
										local function v15447()
											local v15444 = 1 * math.sin(tick() * 3.141592653589793 / 5);
											local _ = v15444 * 1.2;
											local _ = v15444 * 0.8;
											return CFrame.new();
										end;
										local v15448 = nil;
										local l_l_Value_7_0 = l_Value_7 --[[ copy: 3 -> 15 ]];
										local l_v15447_0 = v15447 --[[ copy: 5 -> 16 ]];
										do
											local l_v15443_0, l_v15448_0 = v15443, v15448;
											l_v15448_0 = game:GetService("RunService").RenderStepped:Connect(function()
												if l_v15402_0 then
													if not l_l_Value_7_0 or not l_l_Value_7_0.Parent then
														return ;
													else
														l_CurrentCamera_24.CFrame = l_CurrentCamera_24.CFrame:lerp(CFrame.new(l_v15443_0, l_l_Value_7_0.Head.Position) * l_v15447_0(), 0.1);
														return ;
													end;
												else
													l_CurrentCamera_24.CFrame = l_CurrentCamera_24.CFrame:lerp(CFrame.new(l_v15443_0, l_v15098_0.CFrame.Position) * l_v15447_0(), 0.1);
													return ;
												end;
											end);
											table.insert(v15110, l_v15448_0);
											local l_CFrame_71 = l_v15098_0.CFrame;
											local l_l_CFrame_71_0 = l_CFrame_71 --[[ copy: 7 -> 17 ]];
											task.delay(0, function()
												if not Bezier then
													Bezier = require(l_LegacyReplication_0.Bezier);
												end;
												local l_CFrameValue_10 = Instance.new("CFrameValue");
												l_CFrameValue_10.Value = l_CurrentCamera_24.CFrame;
												local l_Part_24 = Instance.new("Part");
												l_Part_24.Anchored = true;
												l_Part_24.Size = Vector3.new(17, 17, 17, 0);
												l_Part_24.CanCollide = false;
												l_Part_24.Transparency = 1;
												l_Part_24.Parent = workspace.Thrown;
												table.insert(v15110, l_Part_24);
												table.insert(v15110, l_CFrameValue_10);
												local v15457 = {};
												local v15458 = nil;
												v15458 = l_Part_24.Touched:Connect(function(v15459)
													if table.find(v15088, v15459) and not v15457[v15459] then
														local l_Position_79 = v15459.Position;
														local _, v15462 = workspace:FindFirstChildOfClass("Camera"):WorldToScreenPoint(l_Position_79);
														if v15462 then
															local l_sfx_17 = shared.sfx;
															l_Position_79 = {
																SoundId = ({
																	"rbxassetid://74548556184574", 
																	"rbxassetid://91390548971075", 
																	"rbxassetid://92426849139528", 
																	"rbxassetid://124160902361337"
																})[math.random(1, 4)], 
																Parent = v15459, 
																Volume = 1
															};
															v15462 = 1.8;
															local v15464 = 2;
															local l_v82_391 = v82;
															if not v15464 and v15462 then
																v15464 = v15462;
																v15462 = 1;
															end;
															if not v15464 and not v15462 then
																v15462 = 0;
																v15464 = 1;
															end;
															l_Position_79.PlaybackSpeed = l_v82_391:NextNumber(v15462, v15464);
															l_sfx_17(l_Position_79):Play();
															v15457[v15459] = true;
														end;
													end;
												end);
												table.insert(v15110, v15458);
												local v15466 = nil;
												local v15467 = nil;
												local v15468 = nil;
												v15468 = game:GetService("RunService").RenderStepped:Connect(function()
													if not (l_Bind_13.Parent and l_Bind_13.Parent.Parent) or l_Bind_13:GetAttribute("doneso") then
														return v15468:Disconnect();
													else
														if l_Part_24 then
															l_Part_24.Position = l_CurrentCamera_24.CFrame.Position;
														end;
														local v15469 = shared.shakes or {
															0, 
															0, 
															0
														};
														local v15470 = v15466 or l_l_Value_7_0.Head.CFrame;
														local v15471 = (v15467 or l_l_Value_7_0.PrimaryPart.CFrame):toObjectSpace(v15470).p + Vector3.new(0 + v15469[1], -1.25 + v15469[2], 0 + v15469[3]);
														l_CurrentCamera_24.CFrame = l_CurrentCamera_24.CFrame:lerp(CFrame.new(l_CFrameValue_10.Value.Position, v15470.Position) + v15471, 0.25);
														return ;
													end;
												end);
												table.insert(v15110, v15468);
												local l_magnitude_6 = (l_PrimaryPart_67.Position - l_l_CFrame_71_0.Position).magnitude;
												local v15473 = "left";
												if (l_CurrentCamera_24.CFrame.Position - (l_l_CFrame_71_0 * CFrame.new(100, 0, 0)).Position).magnitude > (l_CurrentCamera_24.CFrame.Position - (l_l_CFrame_71_0 * CFrame.new(-100, 0, 0)).Position).magnitude then
													v15473 = "right";
												end;
												local v15474 = 1;
												if v15473 == "right" then
													v15474 = -1;
												end;
												local l_Head_3 = l_l_Value_7_0.Head;
												local v15476 = CFrame.new(l_Head_3.Position, l_Position_69);
												local v15477 = v15476 * CFrame.new(0, 10, -25);
												local v15478 = Bezier.new(CFrame.new(l_v15443_0, l_l_Value_7_0.Head.Position), v15476 * CFrame.new(100 * v15474, 0, l_magnitude_6 / 2), v15476 * CFrame.new(-25 * v15474, 0, 50), v15476 * CFrame.new(-25 * v15474, 0, 50), v15476 * CFrame.new(-23 * v15474, 0, 45), v15476 * CFrame.new(-21 * v15474, 0, 40), v15476 * CFrame.new(-19 * v15474, 0, 35), v15476 * CFrame.new(-17 * v15474, 0, 30), v15476 * CFrame.new(-15 * v15474, 0, 25), v15476 * CFrame.new(-12.5 * v15474, 0, 0), v15477);
												l_v15448_0:Disconnect();
												v15478:CreateCFrameTween(l_CFrameValue_10, {
													"Value"
												}, TweenInfo.new(7.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)):Play();
												local l_Clouds_0 = workspace.Terrain:FindFirstChild("Clouds");
												local l_FirstChild_13 = game.Lighting:FindFirstChild("Sky");
												local l_Atmosphere_0 = game.Lighting.Atmosphere;
												local l_SunRays_0 = game.Lighting.SunRays;
												task.delay(3.8, function()
													for _, v15484 in pairs(v15088) do
														if not v15484:GetAttribute("Taken") then
															local l_Position_80 = v15484.Position;
															local _, v15487 = workspace:FindFirstChildOfClass("Camera"):WorldToScreenPoint(l_Position_80);
															if not v15487 then
																v15136(v15484.CFrame);
																v15484:Destroy();
															else
																task.spawn(function()
																	local v15488 = tick();
																	while true do
																		task.wait();
																		local l_Position_81 = v15484.Position;
																		local _, v15491 = workspace:FindFirstChildOfClass("Camera"):WorldToScreenPoint(l_Position_81);
																		if not (v15491 and tick() - v15488 <= 6) then
																			break;
																		end;
																	end;
																	v15136(v15484.CFrame);
																	v15484:Destroy();
																end);
															end;
														end;
													end;
													v15125 = true;
													for _, v15493 in pairs(v15105) do
														local l_PrimaryPart_68 = v15493[1].PrimaryPart;
														if l_PrimaryPart_68 and (l_PrimaryPart_68.Position - (l_l_Value_7_0.PrimaryPart.CFrame + l_l_Value_7_0.PrimaryPart.CFrame.lookVector * -1).Position).magnitude < (l_PrimaryPart_68.Position - (l_l_Value_7_0.PrimaryPart.CFrame + l_l_Value_7_0.PrimaryPart.CFrame.lookVector * 1).Position).magnitude then
															local l_Position_82 = l_PrimaryPart_68.Position;
															local _, v15497 = workspace:FindFirstChildOfClass("Camera"):WorldToScreenPoint(l_Position_82);
															if not v15497 and (not (l_Bind_13.Value ~= l_LocalPlayer_0.Character) or v898.User == l_LocalPlayer_0.Character) then
																v15136(v15493[5].CFrame);
																v15493[1]:SetAttribute("NoLoop", true);
																v15493[3]:Disconnect();
																v15493[5]:Destroy();
																v15493[1]:Destroy();
															end;
														end;
													end;
													v3:Create(l_SunRays_0, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
														Intensity = 0, 
														Spread = 0
													}):Play();
													v3:Create(l_Clouds_0, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
														Density = 0
													}):Play();
													v3:Create(l_FirstChild_13, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
														SunAngularSize = 0
													}):Play();
												end);
												task.delay(4.3, function()
													local v15498 = nil;
													local l_Humanoid_8 = l_l_Value_7_0.Humanoid;
													for _, v15501 in pairs(l_Humanoid_8:GetPlayingAnimationTracks()) do
														if v15501.Animation.AnimationId == "rbxassetid://111452569702875" then
															v15498 = v15501;
															break;
														end;
													end;
													local l_l_l_Value_7_0_0 = l_l_Value_7_0;
													local l_AnimationPlayer_0 = require(l_l_l_Value_7_0_0.CharacterHandler:WaitForChild("AnimationPlayer"));
													local l_l_AnimationPlayer_0_0 = l_AnimationPlayer_0 --[[ copy: 4 -> 7 ]];
													local l_l_l_l_Value_7_0_0_0 = l_l_l_Value_7_0_0 --[[ copy: 3 -> 8 ]];
													local function v15507(v15506)
														return l_l_AnimationPlayer_0_0.playAnimation(l_l_l_l_Value_7_0_0_0:FindFirstChild("Humanoid"), v15506);
													end;
													l_l_l_Value_7_0_0 = tick();
													l_AnimationPlayer_0 = nil;
													task.delay(1, function()
														table.insert(v15110, v15498);
														pcall(function()
															if v15498 then
																v15498:Stop(0.7);
															end;
															v15498 = v15507(137781911993906);
															v15498:Play(0.7);
															v15498:AdjustSpeed(1);
														end);
														table.insert(v15110, v15498);
														v15466 = l_l_Value_7_0.Head.CFrame;
														v15467 = l_l_Value_7_0.HumanoidRootPart.CFrame;
														local l_v15477_0 = v15477;
														local v15509 = v15467:toObjectSpace(v15466).p + Vector3.new(0, -1.25, 0, 0);
														l_v15477_0 = CFrame.new(l_v15477_0.Position, v15466.Position) + v15509;
														l_AnimationPlayer_0 = l_v15477_0;
														l_v15477_0 = l_v15477_0 + l_v15477_0.lookVector * 30;
														local v15510 = {
															v15467:GetComponents()
														};
														v15510[1] = l_v15477_0.X;
														v15510[2] = l_v15477_0.Y;
														v15510[3] = l_v15477_0.Z;
														l_v15477_0 = CFrame.new(unpack(v15510));
														v3:Create(l_l_Value_7_0.HumanoidRootPart, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
															CFrame = l_v15477_0
														}):Play();
														task.delay(4.8172, function()
															local v15511 = game.ReplicatedStorage.Resources.OmniImpact:Clone();
															v15511.Parent = l_LocalPlayer_0.PlayerGui;
															for v15512 = 1, 5 do
																v15511[v15512].ZIndex = 1 + v15512;
																v15511[v15512].Visible = true;
																task.wait(0.03);
															end;
															v15511:Destroy();
														end);
													end);
													task.delay(2.1, function()
														v15408 = Instance.new("Folder");
														v15408.Name = "Gone";
														v15408.Parent = l_Clouds_0;
														table.insert(v15110, v15408);
														l_Atmosphere_0.Color = Color3.fromRGB(121, 121, 121);
														l_Atmosphere_0.Decay = Color3.new(0, 0, 0);
														v3:Create(l_Atmosphere_0, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
															Haze = 10, 
															Density = 0
														}):Play();
													end);
													l_Part_24:Destroy();
													shared.sfx({
														SoundId = "rbxassetid://114977992289015", 
														Parent = workspace, 
														Volume = 7
													}):Play();
													task.delay(3, function()
														if v15498 then
															v15498:AdjustSpeed(0.2);
														end;
														local v15513 = {};
														local l_Fist_0 = game.ReplicatedStorage.Resources.Omni.Fist;
														local l_l_AnimationPlayer_0_1 = l_AnimationPlayer_0;
														local v15516 = l_l_AnimationPlayer_0_1 * CFrame.new(0, 0, -l_Fist_0.Size.Z - 750);
														local v15517 = l_l_AnimationPlayer_0_1 * CFrame.new(0, 0, -l_Fist_0.Size.Z - 300);
														local v15518 = l_l_AnimationPlayer_0_1 * CFrame.new(0, 0, -l_Fist_0.Size.Z - 50);
														local v15519 = l_l_AnimationPlayer_0_1 * CFrame.new(0, 0, -l_Fist_0.Size.Z + 100);
														v15516 = CFrame.new(v15516.Position, l_AnimationPlayer_0.Position);
														v15517 = CFrame.new(v15517.Position, l_AnimationPlayer_0.Position);
														v15518 = CFrame.new(v15518.Position, l_AnimationPlayer_0.Position);
														v15519 = CFrame.new(v15519.Position, l_AnimationPlayer_0.Position);
														local v15520 = Random.new(1069395829);
														local l_v89_2 = v89;
														local function _(v15522, v15523)
															return l_v89_2(v15522, v15523, nil, v15520);
														end;
														for v15525 = 1, 30 do
															local v15526 = game.ReplicatedStorage.Resources.Omni.Fist:Clone();
															local l_new_75 = CFrame.new;
															local v15528 = v15525 * 15;
															local v15529 = -500;
															local v15530 = 500;
															local v15531 = v15520 or v82;
															if not v15530 and v15529 then
																v15530 = v15529;
																v15529 = 1;
															end;
															if not v15530 and not v15529 then
																v15529 = 0;
																v15530 = 1;
															end;
															l_new_75 = l_new_75(v15528, v15531:NextNumber(v15529, v15530), 0);
															v15526:SetAttribute("Random", l_new_75);
															v15526:SetAttribute("is", v15525);
															v15526.CFrame = CFrame.new(v15516.Position, l_AnimationPlayer_0.Position);
															v15526.CFrame = v15526.CFrame * CFrame.new(l_new_75.X / 2, l_new_75.Y / 2, l_new_75.Z / 2);
															v15526.CFrame = CFrame.new(v15526.Position, l_AnimationPlayer_0.Position);
															v15526.Parent = workspace.Thrown;
															table.insert(v15110, v15526);
															table.insert(v15513, v15526);
														end;
														for v15532 = 1, 30 do
															local v15533 = game.ReplicatedStorage.Resources.Omni.Fist:Clone();
															local l_new_76 = CFrame.new;
															local v15535 = -v15532 * 15;
															local v15536 = -500;
															local v15537 = 500;
															local v15538 = v15520 or v82;
															if not v15537 and v15536 then
																v15537 = v15536;
																v15536 = 1;
															end;
															if not v15537 and not v15536 then
																v15536 = 0;
																v15537 = 1;
															end;
															l_new_76 = l_new_76(v15535, v15538:NextNumber(v15536, v15537), 0);
															v15533:SetAttribute("Random", l_new_76);
															v15533:SetAttribute("is", -v15532);
															v15533.CFrame = CFrame.new(v15516.Position, l_AnimationPlayer_0.Position);
															v15533.CFrame = v15533.CFrame * CFrame.new(l_new_76.X / 2, l_new_76.Y / 2, l_new_76.Z / 2);
															v15533.CFrame = CFrame.new(v15533.Position, l_AnimationPlayer_0.Position);
															v15533.Parent = workspace.Thrown;
															table.insert(v15110, v15533);
															table.insert(v15513, v15533);
														end;
														task.delay(0.05, function()
															for _, v15540 in pairs(v15513) do
																local l_v15517_0 = v15517;
																local l_v15540_Attribute_0 = v15540:GetAttribute("Random");
																l_v15517_0 = l_v15517_0 * CFrame.new(l_v15540_Attribute_0.X / 1, l_v15540_Attribute_0.Y / 1, l_v15540_Attribute_0.Z / 1);
																v15540.CFrame = CFrame.new(l_v15517_0.Position, l_AnimationPlayer_0.Position);
															end;
															task.wait(0.05);
															for _, v15544 in pairs(v15513) do
																v15544.Transparency = 1;
															end;
															task.wait(0.05);
															for _, v15546 in pairs(v15513) do
																local v15547 = v15518 * v15546:GetAttribute("Random");
																v15546.CFrame = CFrame.new(v15547.Position, l_AnimationPlayer_0.Position);
																v15546.Transparency = 0;
															end;
															task.wait(0.05);
															shared.repfire('Whiteout', { 
																Wait = 0.05
															});
															for _, v15549 in pairs(v15105) do
																v15136(v15549[5].CFrame);
																v15549[3]:Disconnect();
																v15549[5]:Destroy();
																v15549[1]:Destroy();
															end;
															for _, v15551 in pairs(v15513) do
																local v15552 = CFrame.new(v15551.Position, l_AnimationPlayer_0.Position);
																local v15553 = v15552 + v15552.lookVector * 200;
																v3:Create(v15551, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
																	CFrame = v15553
																}):Play();
															end;
															task.delay(2.0999999999999996, function()
																shared.sfx({
																	SoundId = "rbxassetid://134724984515275", 
																	Parent = workspace, 
																	Volume = 10
																}):Play();
															end);
															task.delay(2.55, function()
																v15439();
																task.delay(0, function()
																	if v15408 then
																		v15408:Destroy();
																	end;
																	v3:Create(l_Atmosphere_0, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
																		Haze = 0, 
																		Density = 0.213
																	}):Play();
																	v3:Create(l_SunRays_0, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
																		Intensity = 0.082, 
																		Spread = 1
																	}):Play();
																	v3:Create(l_Clouds_0, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
																		Density = 0.293
																	}):Play();
																	v3:Create(l_FirstChild_13, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
																		SunAngularSize = 9
																	}):Play();
																	for _, v15555 in pairs(v15513) do
																		v15555:Destroy();
																	end;
																end);
															end);
														end);
														v3:Create(l_Atmosphere_0, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
															Color = Color3.fromRGB(2, 2, 2)
														}):Play();
														for _ = 1, 2 do
															shared.sfx({
																SoundId = "rbxassetid://99312332084356", 
																RollOffMaxDistance = 1000, 
																RollOffMode = Enum.RollOffMode.LinearSquare, 
																Parent = workspace, 
																Volume = 10
															}):Play();
														end;
													end);
												end);
											end);
										end;
									end;
									for _, v15558 in pairs(l_Parent_14:GetDescendants()) do
										if (v15558:IsA("BasePart") or v15558:IsA("Decal")) and l_Bind_13.Parent then
											v15558.Transparency = 1;
										end;
									end;
									for _, v15560 in pairs(l_v15094_0:GetChildren()) do
										if v15560:IsA("Attachment") then
											v15560.Position = v15560.Position / 2;
										end;
									end;
									local l_Wind_4 = game.ReplicatedStorage.Resources.Omni.Wind;
									local v15562 = l_Wind_4.Shock:Clone();
									local v15563 = l_Wind_4.End_Wind:Clone();
									local v15564 = l_Wind_4.Charge_Shock:Clone();
									table.insert(v15110, v15562);
									table.insert(v15110, v15563);
									table.insert(v15110, v15564);
									local _ = l_v15098_0.Position;
									local v15566 = l_v15098_0.CFrame - l_v15098_0.CFrame.lookVector * 2500;
									local l_new_77 = CFrame.new;
									local v15568 = -95;
									local v15569 = 95;
									local l_v82_392 = v82;
									if not v15569 and v15568 then
										v15569 = v15568;
										v15568 = 1;
									end;
									if not v15569 and not v15568 then
										v15568 = 0;
										v15569 = 1;
									end;
									local v15571 = l_v82_392:NextNumber(v15568, v15569) * 2;
									v15569 = -95;
									l_v82_392 = 95;
									local l_v82_393 = v82;
									if not l_v82_392 and v15569 then
										l_v82_392 = v15569;
										v15569 = 1;
									end;
									if not l_v82_392 and not v15569 then
										v15569 = 0;
										l_v82_392 = 1;
									end;
									local v15573 = l_v82_393:NextNumber(v15569, l_v82_392) * 2;
									l_v82_392 = -95;
									l_v82_393 = 95;
									local l_v82_394 = v82;
									if not l_v82_393 and l_v82_392 then
										l_v82_393 = l_v82_392;
										l_v82_392 = 1;
									end;
									if not l_v82_393 and not l_v82_392 then
										l_v82_392 = 0;
										l_v82_393 = 1;
									end;
									v15566 = v15566 * l_new_77(v15571, v15573, l_v82_394:NextNumber(l_v82_392, l_v82_393) * 2);
									l_new_77 = CFrame.Angles;
									v15568 = -360;
									v15569 = 360;
									l_v82_392 = v82;
									if not v15569 and v15568 then
										v15569 = v15568;
										v15568 = 1;
									end;
									if not v15569 and not v15568 then
										v15568 = 0;
										v15569 = 1;
									end;
									v15571 = math.rad((l_v82_392:NextNumber(v15568, v15569)));
									v15569 = -360;
									l_v82_392 = 360;
									l_v82_393 = v82;
									if not l_v82_392 and v15569 then
										l_v82_392 = v15569;
										v15569 = 1;
									end;
									if not l_v82_392 and not v15569 then
										v15569 = 0;
										l_v82_392 = 1;
									end;
									v15573 = math.rad((l_v82_393:NextNumber(v15569, l_v82_392)));
									l_v82_392 = -360;
									l_v82_393 = 360;
									l_v82_394 = v82;
									if not l_v82_393 and l_v82_392 then
										l_v82_393 = l_v82_392;
										l_v82_392 = 1;
									end;
									if not l_v82_393 and not l_v82_392 then
										l_v82_392 = 0;
										l_v82_393 = 1;
									end;
									v15566 = v15566 * l_new_77(v15571, v15573, (math.rad((l_v82_394:NextNumber(l_v82_392, l_v82_393)))));
									v3:Create(l_v15098_0, TweenInfo.new(2.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
										CFrame = v15566, 
										Size = Vector3.new(0, 0, 0, 0)
									}):Play();
									for _ = 1, 2 do
										shared.sfx({
											SoundId = "rbxassetid://88470525981429", 
											CFrame = l_v15098_0.CFrame, 
											RollOffMaxDistance = 600, 
											Volume = 10
										}):Play();
									end;
									task.spawn(function()
										if v898.User == l_LocalPlayer_0.Character then
											shared.repfire('Camshake', {
												Last = 0.5, 
												Intensity = 8
											});
										end;
									end);
									l_new_77 = v15562.Mesh;
									l_new_77.Scale = l_new_77.Scale * Vector3.new(3, 1, 1, 0);
									v15562.Mesh.Offset = Vector3.new(85, 0, 0, 0);
									v15563.Mesh.Offset = Vector3.new(0, 65, 0, 0);
									v15564.Mesh.Offset = Vector3.new(55, 0, 0, 0);
									v15562.CFrame = CFrame.new(l_v15098_0.Position, l_Position_69) * CFrame.Angles(0, -1.5707963267948966, 0);
									v15563.CFrame = CFrame.new(l_v15098_0.Position, l_Position_69) * CFrame.Angles(1.5707963267948966, 0, 0);
									v15564.CFrame = CFrame.new(l_v15098_0.Position, l_Position_69) * CFrame.Angles(0, -1.5707963267948966, 0);
									v15562.Parent = workspace.Thrown;
									v15563.Parent = workspace.Thrown;
									v15564.Parent = workspace.Thrown;
									game:GetService("Debris"):AddItem(v15564, 11);
									game:GetService("Debris"):AddItem(v15563, 11);
									game:GetService("Debris"):AddItem(v15562, 11);
									v3:Create(v15562.Mesh, TweenInfo.new(0.09999999999999999, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
										Scale = Vector3.new(v15562.Mesh.Scale.X * 4, 0, 0), 
										Offset = Vector3.new(-90, 0, 0, 0)
									}):Play();
									v3:Create(v15563.Mesh, TweenInfo.new(0.09999999999999999, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
										Scale = Vector3.new(v15563.Mesh.Scale.X * 6, v15563.Mesh.Scale.Y * 15, v15563.Mesh.Scale.Z * 6), 
										Offset = Vector3.new(0, -0, 0, 0)
									}):Play();
									task.delay(0.09999999999999999, function()
										v3:Create(v15563.Mesh, TweenInfo.new(0.09999999999999999, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
											Scale = Vector3.new(v15563.Mesh.Scale.X * 0, v15563.Mesh.Scale.Y * 1, v15563.Mesh.Scale.Z * 0), 
											Offset = Vector3.new(0, -50, 0, 0)
										}):Play();
									end);
									v3:Create(v15563, TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
										CFrame = v15563.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
									}):Play();
									v3:Create(v15564.Mesh, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
										Scale = Vector3.new(v15564.Mesh.Scale.X * 8, v15564.Mesh.Scale.Y * 24, v15564.Mesh.Scale.Z * 24), 
										Offset = Vector3.new(-0, 0, 0, 0)
									}):Play();
									task.delay(0.08, function()
										v3:Create(v15564.Mesh, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
											Scale = Vector3.new(v15564.Mesh.Scale.X * 1, v15564.Mesh.Scale.Y * 0, v15564.Mesh.Scale.Z * 0), 
											Offset = Vector3.new(-50, 0, 0, 0)
										}):Play();
									end);
									table.insert(v15110, l_v15398_1);
									l_v15398_1:Disconnect();
									for _, v15577 in pairs({}) do
										task.delay(v15577, function()
											local v15578, v15579 = shared.sfx({
												SoundId = "rbxassetid://119448305507853", 
												CFrame = v15097, 
												RollOffMaxDistance = 55000, 
												PlaybackSpeed = 1, 
												Volume = 10
											});
											table.insert(v15110, v15578);
											v15578:Play();
											table.insert(v15122, v15579);
										end);
									end;
									v15161(true, true);
								end));
								task.delay(5, function()
									for _, v15581 in pairs(v15406) do
										v15581:Disconnect();
									end;
								end);
								l_v15344_0 = true;
							end);
							task.delay(0.5, function()
								v15393:Disconnect();
								l_v15398_1 = l_v15098_0:GetPropertyChangedSignal("CFrame"):Connect(function()
									local v15582 = CFrame.new(l_v15098_0.Position, l_Position_69) * (CFrame.new(0, 0, -l_v15098_0.Size.Z / 2 - 3) * CFrame.Angles(-1.5707963267948966, 0, 0));
									l_Parent_14:PivotTo(v15582);
								end);
								table.insert(v15110, l_v15398_1);
								l_v15098_0.Anchored = true;
								local _ = l_v15098_0.Position;
								local _ = l_v15098_0.CFrame - l_v15098_0.CFrame.lookVector * 200;
								local v15585 = tick();
								local v15586 = 5;
								local v15587 = nil;
								v15587 = game:GetService("RunService").RenderStepped:Connect(function()
									if tick() - v15585 > 2.5 then
										return v15587:Disconnect();
									else
										local l_l_v15098_0_0 = l_v15098_0;
										l_l_v15098_0_0.CFrame = l_l_v15098_0_0.CFrame - l_v15098_0.CFrame.lookVector * v15586;
										v15586 = v15586 * 0.9825;
										return ;
									end;
								end);
								table.insert(v15110, v15587);
								task.delay(2.5, function()
									return l_v15398_1:Disconnect();
								end);
							end);
						end;
					end;
				end;
			end;
			local v15590 = nil;
			v15590 = function()
				if l_Bind_13.Value and (not (l_Bind_13.Value ~= l_LocalPlayer_0.Character) or v898.User == l_LocalPlayer_0.Character) then
					v15590 = function()

					end;
					if l_Bind_13.Value == l_LocalPlayer_0.Character then
						local v15591 = shared.sfx({
							SoundId = "rbxassetid://95930909203329", 
							Parent = l_LocalPlayer_0.PlayerGui, 
							TimePosition = 0.5, 
							Volume = 0
						});
						task.delay(4.35, function()
							v15591:Resume();
							v3:Create(v15591, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
								Volume = 7.75
							}):Play();
						end)
					end;
					local v15592 = {};
					for _, v15594 in pairs(game.ReplicatedStorage.Resources.OmniImpact:GetChildren()) do
						local v15595 = v15594:Clone();
						v15595.Visible = true;
						v15595.Size = UDim2.new(0, 1, 0, 1);
						v15595.Position = UDim2.new(0, 0, 0, 0);
						v15595.Parent = l_LocalPlayer_0.PlayerGui.ShiftLock;
						table.insert(v15592, v15595);
					end;
					local l_v15592_0 = v15592 --[[ copy: 0 -> 7 ]];
					task.delay(10, function()
						for _, v15598 in pairs(l_v15592_0) do
							v15598:Destroy();
						end;
					end);
					for _, v15600 in pairs({
						"rbxassetid://10826926896", 
						"rbxassetid://10088333456", 
						"rbxassetid://6867087832", 
						"rbxassetid://10357935135", 
						"rbxassetid://14859461973", 
						"rbxassetid://9413803108", 
						"rbxassetid://10552020089", 
						"rbxassetid://8077816591", 
						"http://www.roblox.com/asset/?id=9160490836", 
						"rbxassetid://243664672"
						}) do
						local l_ImageLabel_5 = Instance.new("ImageLabel");
						l_ImageLabel_5.Size = UDim2.new(0, 1, 0, 1);
						l_ImageLabel_5.Image = v15600;
						l_ImageLabel_5.Name = "PRELOAD";
						l_ImageLabel_5.ImageTransparency = 0.9;
						l_ImageLabel_5.Parent = l_LocalPlayer_0.PlayerGui.ShiftLock;
						table.insert(v15110, l_ImageLabel_5);
					end;
					v15592 = v898.User.PrimaryPart;
					v15592:GetPropertyChangedSignal("Parent"):Connect(function()
						if not v898.User or not v15592.Parent then
							l_v15111_0 = true;
							for _, v15603 in pairs(v15110) do
								if typeof(v15603) == "RBXScriptConnection" and v15603 then
									v15603:Disconnect();
								end;
							end;
							l_CurrentCamera_24.CameraType = Enum.CameraType.Custom;
						end;
					end);
					local l_PrimaryPart_69 = l_Bind_13.Value.PrimaryPart;
					l_PrimaryPart_69:GetPropertyChangedSignal("Parent"):Connect(function()
						if not v898.User or not l_PrimaryPart_69.Parent then
							l_v15111_0 = true;
							for _, v15606 in pairs(v15110) do
								if typeof(v15606) == "RBXScriptConnection" and v15606 then
									v15606:Disconnect();
								end;
							end;
							l_CurrentCamera_24.CameraType = Enum.CameraType.Custom;
						end;
					end);
				end;
			end;
			local v15607 = nil;
			v15607 = l_Bind_13:GetPropertyChangedSignal("Value"):Connect(function()
				if l_Bind_13.Value then
					v15590();
					return v15607:Disconnect();
				else
					return ;
				end;
			end);
			v15590();
			table.insert(v15110, v15607);
			local v15608 = nil;
			v15608 = v15323:GetMarkerReachedSignal("step2"):Connect(function()
				task.wait(0.4);
				if not (l_Bind_13.Value and l_Bind_13.Value ~= l_LocalPlayer_0.Character) or v898.User == l_LocalPlayer_0.Character then

				end;
			end);
			local v15609 = nil;
			v15609 = v15323:GetMarkerReachedSignal("jump"):Connect(function()
				v15589(v15609);
			end);
			local v15610 = nil;
			v15610 = l_Bind_13:GetPropertyChangedSignal("Name"):Connect(function()
				v15589(v15610);
			end);
			table.insert(v15110, v15608);
			table.insert(v15110, v15610);
			table.insert(v15110, v15609);
			task.delay(15, function()
				v15609:Disconnect();
				v15610:Disconnect();
			end);
			local v15611 = {};
			local v15612 = {};
			local l_Part_25 = Instance.new("Part");
			l_Part_25.Anchored = true;
			l_Part_25.CanCollide = false;
			l_Part_25.Transparency = 1;
			l_Part_25.Size = Vector3.new(455, 5, 455, 0);
			l_Part_25.CFrame = l_Root_13.CFrame * CFrame.new(0, -7.5, 0);
			l_Part_25.Parent = workspace.Thrown;
			task.delay(1, function()
				if l_Bind_13.Parent then
					return l_Part_25:Destroy();
				else
					local v15614 = 0;
					local v15615 = {};
					local v15616 = false;
					local v15617 = tick();
					local v15618 = nil;
					v15618 = l_Part_25.Touched:Connect(function(v15619)
						if not v15612[v15619] then
							return ;
						else
							local l_Position_85 = v15619.Position;
							local v15621, v15622 = workspace:FindFirstChildOfClass("Camera"):WorldToScreenPoint(l_Position_85);
							if not v15622 then
								return ;
							else
								v15614 = v15614 + 1;
								v15616 = true;
								v15612[v15619] = false;
								v15617 = tick();
								local v15623;
								v15623, l_Position_85 = v556({
									orig = v15619.Position, 
									dir = Vector3.new(0, -v15619.Size.magnitude - 20)
								});
								if v15623 then
									v15621 = Instance.new("Attachment");
									v15621.Parent = workspace.Terrain;
									v15621.WorldPosition = l_Position_85;
									table.insert(v15615, v15621);
									v15622 = l_LegacyReplication_0.UpSmoke2:Clone();
									v15622.Color = ColorSequence.new(v15623.Color);
									v15622.Enabled = false;
									v15622.Drag = v15622.Drag + 2;
									v15622.Speed = NumberRange.new(0, v89(142.5, 300));
									shared.resizeparticle(v15622, (math.clamp(v15619.Size.magnitude / 2.75, 0, 100)));
									v15622.Parent = v15621;
									v15622:Emit(math.random(1, 3));
									local l_sfx_18 = shared.sfx;
									local v15625 = {
										SoundId = "rbxassetid://140678294541900", 
										Volume = 3, 
										CFrame = CFrame.new(l_Position_85)
									};
									local v15626 = 0.9;
									local v15627 = 1.3;
									local l_v82_395 = v82;
									if not v15627 and v15626 then
										v15627 = v15626;
										v15626 = 1;
									end;
									if not v15627 and not v15626 then
										v15626 = 0;
										v15627 = 1;
									end;
									v15625.PlaybackSpeed = l_v82_395:NextNumber(v15626, v15627);
									l_sfx_18(v15625):Play();
									l_sfx_18 = shared.sfx;
									v15625 = {
										SoundId = ({
											"rbxassetid://97218995052160", 
											"rbxassetid://99317217027000", 
											"rbxassetid://99506722416457"
										})[math.random(1, 3)], 
										Volume = 3
									};
									v15626 = 0.9;
									v15627 = 1.3;
									l_v82_395 = v82;
									if not v15627 and v15626 then
										v15627 = v15626;
										v15626 = 1;
									end;
									if not v15627 and not v15626 then
										v15626 = 0;
										v15627 = 1;
									end;
									v15625.PlaybackSpeed = l_v82_395:NextNumber(v15626, v15627);
									v15625.CFrame = CFrame.new(l_Position_85);
									l_sfx_18(v15625):Play();
								end;
								return ;
							end;
						end;
					end);
					task.spawn(function()
						local v15629 = tick();
						while true do
							task.wait();
							if not ((not v15616 or tick() - v15617 <= 0.5) and tick() - v15629 <= 10) then
								break;
							end;
						end;
						l_Part_25:Destroy();
						v15618:Disconnect();
					end);
					l_Part_25:GetPropertyChangedSignal("Parent"):Connect(function()
						if not l_Part_25.Parent then
							task.wait(5);
							for _, v15631 in pairs(v15615) do
								v15631:Destroy();
							end;
						end;
					end);
					return ;
				end;
			end);
			table.insert(v15611, l_Part_25);
			for v15632 = 1, 25 do
				local l_CFrame_72 = l_Root_13.CFrame;
				local l_new_78 = CFrame.new;
				local v15635 = -1 * v15632 - v15632 * 2;
				local v15636 = 1 * v15632 + v15632 * 2;
				local l_v82_396 = v82;
				if not v15636 and v15635 then
					v15636 = v15635;
					v15635 = 1;
				end;
				if not v15636 and not v15635 then
					v15635 = 0;
					v15636 = 1;
				end;
				local _ = (l_CFrame_72 * l_new_78(l_v82_396:NextNumber(v15635, v15636), 0, v89(-1 * v15632, 1 * v15632)) + l_Root_13.CFrame.lookVector * (v15632 * 5)).p;
				l_CFrame_72 = 1;
				l_new_78 = 5;
				local v15639 = 6;
				v15635 = v82;
				if not v15639 and l_new_78 then
					v15639 = l_new_78;
					l_new_78 = 1;
				end;
				if not v15639 and not l_new_78 then
					l_new_78 = 0;
					v15639 = 1;
				end;
				for v15640 = l_CFrame_72, v15635:NextInteger(l_new_78, v15639) do
					l_new_78 = v556;
					v15639 = {};
					local l_CFrame_73 = l_Root_13.CFrame;
					local l_new_79 = CFrame.new;
					local v15643 = -1 * v15632 - v15632 * 2;
					local v15644 = 1 * v15632 + v15632 * 2;
					local l_v82_397 = v82;
					if not v15644 and v15643 then
						v15644 = v15643;
						v15643 = 1;
					end;
					if not v15644 and not v15643 then
						v15643 = 0;
						v15644 = 1;
					end;
					v15639.orig = (l_CFrame_73 * l_new_79(l_v82_397:NextNumber(v15643, v15644), 0, v89(-1 * v15632, 1 * v15632)) + l_Root_13.CFrame.lookVector * (v15632 * 5)).p;
					v15639.dir = Vector3.new(0, -10, 0, 0);
					l_new_78, v15639 = l_new_78(v15639);
					if l_new_78 then
						v15636 = (function(_)
							local v15647 = v230() or Instance.new("Part");
							v15612[v15647] = v15647;
							v15647.Name = "DebrisggbbTf";
							v15647.Anchored = false;
							v15647.CanCollide = false;
							v15647.Transparency = 0;
							v15647.Massless = false;
							local v15648 = 3;
							local v15649 = 7;
							local l_v82_398 = v82;
							if not v15649 and v15648 then
								v15649 = v15648;
								v15648 = 1;
							end;
							if not v15649 and not v15648 then
								v15648 = 0;
								v15649 = 1;
							end;
							local v15651 = l_v82_398:NextNumber(v15648, v15649);
							v15649 = 3;
							l_v82_398 = 7;
							local l_v82_399 = v82;
							if not l_v82_398 and v15649 then
								l_v82_398 = v15649;
								v15649 = 1;
							end;
							if not l_v82_398 and not v15649 then
								v15649 = 0;
								l_v82_398 = 1;
							end;
							local v15653 = Vector3.new(v15651, l_v82_399:NextNumber(v15649, l_v82_398), v89(3, 7));
							v15648 = 2;
							v15649 = 2.25;
							l_v82_398 = v82;
							if not v15649 and v15648 then
								v15649 = v15648;
								v15648 = 1;
							end;
							if not v15649 and not v15648 then
								v15648 = 0;
								v15649 = 1;
							end;
							v15647.Size = v15653 * l_v82_398:NextNumber(v15648, v15649);
							table.insert(v15110, v15647);
							if math.random(1, 3) == 1 then
								local l_Attachment_8 = Instance.new("Attachment");
								l_Attachment_8.Parent = workspace.Terrain;
								l_Attachment_8.WorldPosition = v15639;
								table.insert(v15110, l_Attachment_8);
								v15653 = l_LegacyReplication_0.UpSmoke2:Clone();
								v15653.Parent = l_Attachment_8;
								v15653.Color = ColorSequence.new(l_new_78.Color);
								v15653.SpreadAngle = Vector2.new(-60, 60);
								v15653.Lifetime = NumberRange.new(v15653.Lifetime.Min * 1, v15653.Lifetime.Max * 3);
								shared.resizeparticle(v15653, v89(1, 3));
								v15653.Speed = NumberRange.new(0, v89(500, 2000));
								shared.resizeparticle(v15653, v89(2, 3));
								table.insert(v15110, v15653);
								v15653:Emit(15);
								table.insert(v15611, l_Attachment_8);
								if v15640 == 1 then
									task.delay(15, function()
										for _, v15656 in pairs(v15611) do
											v15656:Destroy();
										end;
									end);
								end;
							end;
							v15647.CFrame = v15647.CFrame + l_Root_13.CFrame.lookVector * v15647.Size.X;
							v15653 = CFrame.new;
							v15648 = v15639;
							local v15657 = -3;
							local v15658 = 3;
							local l_v82_400 = v82;
							if not v15658 and v15657 then
								v15658 = v15657;
								v15657 = 1;
							end;
							if not v15658 and not v15657 then
								v15657 = 0;
								v15658 = 1;
							end;
							l_v82_398 = l_v82_400:NextNumber(v15657, v15658) * 1;
							l_v82_399 = v15640 / 45 - 0.2;
							l_v82_400 = -3;
							local v15660 = 3;
							local l_v82_401 = v82;
							if not v15660 and l_v82_400 then
								v15660 = l_v82_400;
								l_v82_400 = 1;
							end;
							if not v15660 and not l_v82_400 then
								l_v82_400 = 0;
								v15660 = 1;
							end;
							v15653 = v15653(v15648 - Vector3.new(l_v82_398, l_v82_399, l_v82_401:NextNumber(l_v82_400, v15660) * 1));
							v15651 = CFrame.Angles;
							l_v82_398 = -360;
							l_v82_399 = 360;
							v15657 = v82;
							if not l_v82_399 and l_v82_398 then
								l_v82_399 = l_v82_398;
								l_v82_398 = 1;
							end;
							if not l_v82_399 and not l_v82_398 then
								l_v82_398 = 0;
								l_v82_399 = 1;
							end;
							v15648 = math.rad((v15657:NextNumber(l_v82_398, l_v82_399)));
							l_v82_399 = -360;
							v15657 = 360;
							v15658 = v82;
							if not v15657 and l_v82_399 then
								v15657 = l_v82_399;
								l_v82_399 = 1;
							end;
							if not v15657 and not l_v82_399 then
								l_v82_399 = 0;
								v15657 = 1;
							end;
							v15649 = math.rad((v15658:NextNumber(l_v82_399, v15657)));
							v15657 = -360;
							v15658 = 360;
							l_v82_400 = v82;
							if not v15658 and v15657 then
								v15658 = v15657;
								v15657 = 1;
							end;
							if not v15658 and not v15657 then
								v15657 = 0;
								v15658 = 1;
							end;
							v15647.CFrame = v15653 * v15651(v15648, v15649, (math.rad((l_v82_400:NextNumber(v15657, v15658)))));
							v15647.Material = l_new_78.Material;
							v15647.Color = l_new_78.Color;
							v15647.Parent = l_Model_354;
							table.insert(v15088, v15647);
							local v15662 = l_Root_13.CFrame * CFrame.new(0, 30.0999298, -40.1572266, 0.802054107, 0.461602062, -0.378989995, -0.58462131, 0.476968586, -0.656291902, -0.122179255, 0.747947037, 0.652417183);
							v15653 = Instance.new("BodyVelocity");
							v15653.MaxForce = Vector3.new(1, 1, 1, 0) * 36000000;
							v15648 = CFrame.new(v15647.Position, (Vector3.new(v15662.X, v15647.Position.Y, v15662.Z))).lookVector;
							l_v82_399 = 50;
							v15657 = 75;
							v15658 = v82;
							if not v15657 and l_v82_399 then
								v15657 = l_v82_399;
								l_v82_399 = 1;
							end;
							if not v15657 and not l_v82_399 then
								l_v82_399 = 0;
								v15657 = 1;
							end;
							v15651 = v15648 * -v15658:NextNumber(l_v82_399, v15657);
							if math.random(1, 2) == 1 then
								v15648 = CFrame.new(v15647.Position, (Vector3.new(v15662.X, v15647.Position.Y - 15, v15662.Z))).lookVector;
								l_v82_399 = 50;
								v15657 = 75;
								v15658 = v82;
								if not v15657 and l_v82_399 then
									v15657 = l_v82_399;
									l_v82_399 = 1;
								end;
								if not v15657 and not l_v82_399 then
									l_v82_399 = 0;
									v15657 = 1;
								end;
								v15651 = v15648 * -v15658:NextNumber(l_v82_399, v15657);
							end;
							l_v82_398 = 0;
							v15657 = 200;
							v15658 = 350;
							l_v82_400 = v82;
							if not v15658 and v15657 then
								v15658 = v15657;
								v15657 = 1;
							end;
							if not v15658 and not v15657 then
								v15657 = 0;
								v15658 = 1;
							end;
							v15653.Velocity = v15651 + Vector3.new(l_v82_398, l_v82_400:NextNumber(v15657, v15658), 0);
							v15653.Parent = v15647;
							game:service("Debris"):AddItem(v15653, 0.15);
							table.insert(v15110, v15653);
							task.spawn(function()
								if v15647 == l_v15098_0 then
									return ;
								else
									local _ = tick();
									task.wait(1);
									v15653:Destroy();
									local l_BodyVelocity_19 = Instance.new("BodyVelocity");
									table.insert(v15104, l_BodyVelocity_19);
									table.insert(v15110, l_BodyVelocity_19);
									l_BodyVelocity_19.MaxForce = Vector3.new(1, 1, 1, 0) * v15647.Size.magnitude * 100000;
									l_BodyVelocity_19.Velocity = v15647.Velocity;
									l_BodyVelocity_19.Parent = v15647;
									if not l_Bind_13.Parent then
										local l_v3_26 = v3;
										local l_l_BodyVelocity_19_0 = l_BodyVelocity_19;
										local l_new_80 = TweenInfo.new;
										local v15668 = 2;
										local v15669 = 4;
										local l_v82_402 = v82;
										if not v15669 and v15668 then
											v15669 = v15668;
											v15668 = 1;
										end;
										if not v15669 and not v15668 then
											v15668 = 0;
											v15669 = 1;
										end;
										l_new_80 = l_new_80(l_v82_402:NextNumber(v15668, v15669), Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
										local v15671 = {};
										v15669 = 0;
										local v15672 = -v15647.Size.magnitude;
										local v15673 = 3;
										local v15674 = 6;
										local l_v82_403 = v82;
										if not v15674 and v15673 then
											v15674 = v15673;
											v15673 = 1;
										end;
										if not v15674 and not v15673 then
											v15673 = 0;
											v15674 = 1;
										end;
										v15671.Velocity = Vector3.new(v15669, v15672 * l_v82_403:NextNumber(v15673, v15674) * 3.5, 0);
										l_v3_26:Create(l_l_BodyVelocity_19_0, l_new_80, v15671):Play();
									else
										local l_v3_27 = v3;
										local l_l_BodyVelocity_19_1 = l_BodyVelocity_19;
										local l_new_81 = TweenInfo.new;
										local v15679 = 2;
										local v15680 = 3;
										local l_v82_404 = v82;
										if not v15680 and v15679 then
											v15680 = v15679;
											v15679 = 1;
										end;
										if not v15680 and not v15679 then
											v15679 = 0;
											v15680 = 1;
										end;
										l_new_81 = l_new_81(l_v82_404:NextNumber(v15679, v15680), Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
										local v15682 = {};
										v15680 = 0;
										local v15683 = -v15647.Size.magnitude;
										local v15684 = 3;
										local v15685 = 4;
										local l_v82_405 = v82;
										if not v15685 and v15684 then
											v15685 = v15684;
											v15684 = 1;
										end;
										if not v15685 and not v15684 then
											v15684 = 0;
											v15685 = 1;
										end;
										v15682.Velocity = Vector3.new(v15680, v15683 * l_v82_405:NextNumber(v15684, v15685), 0);
										l_v3_27:Create(l_l_BodyVelocity_19_1, l_new_81, v15682):Play();
									end;
									table.insert(v15112, l_BodyVelocity_19);
									task.delay(5, function()
										if v15647.Position.Y < l_Position_69.Y then
											v15647:Destroy();
										end;
									end);
									return ;
								end;
							end);
							v15648 = Instance.new("Attachment");
							v15648.Parent = v15647;
							v15649 = Instance.new("Attachment");
							v15649.Position = Vector3.new(0, -0.10000000149011612, 0, 0);
							v15649.Parent = v15647;
							l_v82_398 = l_LegacyReplication_0.TrailTwo:Clone();
							l_v82_398.Parent = v15647;
							l_v82_398.Attachment0 = v15648;
							l_v82_398.Attachment1 = v15649;
							table.insert(v15110, v15648);
							table.insert(v15110, v15649);
							table.insert(v15110, l_v82_398);
							shared.addshake(v89(1, 2));
							return v15647;
						end)();
					end;
				end;
				task.wait();
			end;
			local v15687 = {};
			for _, v15689 in pairs(v15088) do
				if v15689.Parent then
					table.insert(v15687, v15689);
				end;
			end;
		end;
	end,
}


--// Connections \\--

local function repfire(replicateName,params)
	local ReplicateFunc = ReplicationEffects[replicateName]

	if ReplicateFunc then
		ReplicateFunc(params)
	else
		warn(replicateName..' does not exist for replication.')
	end
end

Replicate_Set.OnClientEvent:Connect(repfire)
shared.repfire = repfire

local ResetBindable = Instance.new('BindableEvent')
ResetBindable.Event:Connect(function() 
	ComSet:FireServer('ResetCharacter')
end)

task.spawn(function()
	while task.wait(0.2) do
		local Status = pcall(function()
			game.StarterGui:SetCore("ResetButtonCallback", ResetBindable)
		end)

		if Status then
			break
		end
	end
end)

ComSet:FireServer('replicationLoaded')

return {}