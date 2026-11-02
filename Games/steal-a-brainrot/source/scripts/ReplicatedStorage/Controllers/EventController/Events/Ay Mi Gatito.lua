-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local l_RunService_0 = game:GetService("RunService");
local l_Lighting_0 = game:GetService("Lighting");
local l_Players_0 = game:GetService("Players");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v6 = {};
local v7 = require(l_ReplicatedStorage_0.Controllers.EventController.ClientEventUtils);
local v8 = require(l_ReplicatedStorage_0.Controllers.EffectController);
local v9 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v10 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local v11 = require(l_ReplicatedStorage_0.Controllers.EventController);
local v12 = require(l_ReplicatedStorage_0.Packages.Observers);
local v13 = require(l_ReplicatedStorage_0.Datas.ServerData);
local v14 = require(l_ReplicatedStorage_0.Packages.Trove);
local v15 = require(l_ReplicatedStorage_0.Packages.Net);
local l_AyMiGatito_0 = workspace.Sounds.AyMiGatito;
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_Name_0 = script.Name;
local v19 = v14.new();
local v20 = v15:RemoteEvent("EventService/AyMiGatito/Burst");

-- FIX: durée réelle du son (36.441s), on boucle dessus proprement
local SOUND_LOOP_DURATION = 72.771; -- durée musicale d'un cycle complet (2x le son)
local SOUND_LENGTH = 36.441;        -- durée réelle du fichier audio

local function loadAnimation(v21, v22, v23)
	local v24 = v21:LoadAnimation(v22);
	(v23 or v19):Add(function()
		v24:Stop(0);
		v24:Destroy();
	end);
	return v24;
end;

local function calculateSpeedFromMusicPosition(v26)
	if v26 >= 43 and v26 < 48 then
		return 0.4;
	elseif v26 >= 48 and v26 < 50 then
		return (v26 - 48) / 2 * 0.3 + 0.4;
	elseif v26 >= 50 and v26 < 55.5 then
		return 0.7;
	elseif v26 >= 55.5 and v26 < 57 then
		return (v26 - 55.5) / 1.5 * 0.3 + 0.7;
	else
		return 1;
	end;
end;

local function calculateAnimationSpeed(v28, _)
	if v28 < 7 then
		return 0;
	else
		local v30 = v28 - 7;
		if v28 >= 222.313 then
			return (math.max(0, 1 - (v28 - 222.313) / 3));
		else
			local v31 = v30 % SOUND_LOOP_DURATION;
			if v31 >= 43 and v31 < 48 then
				return 0.4;
			elseif v31 >= 48 and v31 < 50 then
				return (v31 - 48) / 2 * 0.3 + 0.4;
			elseif v31 >= 50 and v31 < 55.5 then
				return 0.7;
			elseif v31 >= 55.5 and v31 < 57 then
				return (v31 - 55.5) / 1.5 * 0.3 + 0.7;
			else
				return 1;
			end;
		end;
	end;
end;

local function calculateMusicTimePosition(v33)
	if v33 < 7 then
		return 0, false;
	else
		local v34 = v33 - 7;
		return v34 % SOUND_LOOP_DURATION, v34 < 218.313;
	end;
end;

local function v52()
	local v36 = v19:Extend();
	local v37 = table.create(2);
	v36:Add(function()
		table.clear(v37);
	end);
	local v38 = 0;
	v36:Add(l_RunService_0.PreRender:Connect(function(v39)
		debug.profilebegin("Ay Mi Gatito Event Activation");
		v38 = v38 + v39;
		for v40, v41 in v37 do
			if v41.target and v41.targetAttachment then
				v41.beam.First.Enabled = true;
				v41.beam.Second.Enabled = true;
				local v42 = math.clamp(v38 - v40 + 1, 0, 1);
				local l_WorldPosition_0 = v41.beam.WorldPosition;
				v41.targetAttachment.Position = l_WorldPosition_0 + (v41.target:GetPivot().Position - l_WorldPosition_0) * v42;
			end;
		end;
		debug.profileend();
	end));
	v36:Add(v12.observeTag("AyMiGatitoPlayerVFX", function(v44)
		local v45 = script.PlayerVFX.Beam:Clone();
		v45.Parent = v44;
		local v46 = script.PlayerVFX.Torso:Clone();
		v46.Parent = v44;
		local l_v44_Attribute_0 = v44:GetAttribute("AyMiGatitoIndex");
		v37[l_v44_Attribute_0] = {
			beam = v45,
			target = nil
		};
		local v51 = v12.observeTag("AyMiGatitoPlayerVFX", function(v48)
			if v48 == v44 then
				return nil;
			elseif v48:GetAttribute("AyMiGatitoIndex") ~= v44:GetAttribute("AyMiGatitoIndex") % 2 + 1 then
				return nil;
			else
				local l_Attachment_0 = Instance.new("Attachment");
				l_Attachment_0.Position = v45.WorldPosition;
				l_Attachment_0.Parent = workspace.Terrain;
				local v50 = v37[v44:GetAttribute("AyMiGatitoIndex")];
				v50.target = v48;
				v50.beam.First.Attachment0 = l_Attachment_0;
				v50.beam.Second.Attachment0 = l_Attachment_0;
				v50.targetAttachment = l_Attachment_0;
				return function()
					l_Attachment_0:Destroy();
				end;
			end;
		end);
		return function()
			v46:Destroy();
			v45:Destroy();
			v51();
			v37[l_v44_Attribute_0] = nil;
		end;
	end));
end;

local function v99(v53)
	local v54 = {};
	v19:Add(l_RunService_0.PostSimulation:Connect(function(_)
		if #v54 == 0 then
			return;
		else
			local v56 = workspace:GetServerTimeNow() - v53.startedAt;
			local v64;
			if v56 < 7 then
				v64 = 0;
			else
				local v65 = v56 - 7;
				if v56 >= 222.313 then
					v64 = math.max(0, 1 - (v56 - 222.313) / 3);
				else
					local v66 = v65 % SOUND_LOOP_DURATION;
					v64 = v66 >= 43 and v66 < 48 and 0.4 or if v66 >= 48 and v66 < 50 then (v66 - 48) / 2 * 0.3 + 0.4 else v66 >= 50 and v66 < 55.5 and 0.7 or if v66 >= 55.5 and v66 < 57 then (v66 - 55.5) / 1.5 * 0.3 + 0.7 else 1;
				end;
			end;
			for _, v68 in v54 do
				if v68.dance and v68.dance.IsPlaying then
					v68.dance:AdjustSpeed(v64);
				end;
				if v68.walk and v68.walk.IsPlaying then
					v68.walk:AdjustSpeed(v64);
				end;
				if v68.idle and v68.idle.IsPlaying then
					v68.idle:AdjustSpeed(v64);
				end;
			end;
			return;
		end;
	end));
	v19:Add(function()
		table.clear(v54);
	end);
	v19:Add(v12.observeTag("Gatito", function(v69)
		local v70 = v14.new();
		local l_HumanoidRootPart_0 = v69:WaitForChild("HumanoidRootPart");
		local v72 = v69:GetAttribute("Variant") or "Gatito";
		local v73 = v70:Clone(script.Gatitos:FindFirstChild(v72) or script.Gatitos.Gatito);
		local v74 = v70:Add(Instance.new("Weld"));
		v74.Part0 = v73.PrimaryPart;
		v74.Part1 = l_HumanoidRootPart_0;
		v74.Parent = v73.PrimaryPart;
		v73.Parent = v69;
		local l_AnimationController_0 = v73:FindFirstChild("AnimationController");
		if l_AnimationController_0 then
			l_AnimationController_0:Destroy();
		end;
		local v76 = Instance.new("Humanoid", v73);
		Instance.new("Animator", v76);
		v76.Name = "AnimationController";
		v76.EvaluateStateMachine = false;
		v76.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
		v76.PlatformStand = true;
		v76.Parent = v73;
		local l_Animator_0 = v73.AnimationController.Animator;
		local v78 = nil;
		local v79 = nil;
		local v80 = nil;
		local l_GatitoDance1_0 = script:FindFirstChild("GatitoDance1");
		if l_GatitoDance1_0 then
			local v82 = l_Animator_0:LoadAnimation(l_GatitoDance1_0);
			local l_v82_0 = v82;
			(v70 or v19):Add(function()
				l_v82_0:Stop(0);
				l_v82_0:Destroy();
			end);
			v78 = v82;
			v78.Looped = true;
			v78.Priority = Enum.AnimationPriority.Action;
		end;
		local l_GatitoWalk_0 = script:FindFirstChild("GatitoWalk");
		if l_GatitoWalk_0 then
			local v85 = l_Animator_0:LoadAnimation(l_GatitoWalk_0);
			local l_v85_0 = v85;
			(v70 or v19):Add(function()
				l_v85_0:Stop(0);
				l_v85_0:Destroy();
			end);
			v79 = v85;
			v79.Priority = Enum.AnimationPriority.Action2;
		end;
		local l_GatitoIdle_0 = script:FindFirstChild("GatitoIdle");
		if l_GatitoIdle_0 then
			local v88 = l_Animator_0:LoadAnimation(l_GatitoIdle_0);
			local l_v88_0 = v88;
			(v70 or v19):Add(function()
				l_v88_0:Stop(0);
				l_v88_0:Destroy();
			end);
			v80 = v88;
			v80.Looped = true;
			v80.Priority = Enum.AnimationPriority.Idle;
		end;
		v70:Add(v69:GetAttributeChangedSignal("AttackAnimation"):Connect(function()
			local l_GatitoAttack_0 = script:FindFirstChild("GatitoAttack");
			if l_GatitoAttack_0 then
				local v93 = l_Animator_0:LoadAnimation(l_GatitoAttack_0);
				(v70 or v19):Add(function()
					v93:Stop(0);
					v93:Destroy();
				end);
				v93.Looped = false;
				v93.Priority = Enum.AnimationPriority.Action4;
				v93:Play();
			end;
		end));
		if v79 then
			v70:Add(v12.observeAttribute(v69, "IsRunning", function(v95)
				if v95 then
					v79:Play();
					if v80 and v80.IsPlaying then
						v80:Stop();
					end;
					if v78 and v78.IsPlaying then
						v78:Stop();
					end;
				else
					v79:Stop();
					if v78 and v69:GetAttribute("Dance") and not v78.IsPlaying then
						v78:Play();
					end;
				end;
				return nil;
			end));
		end;
		v70:Add(v12.observeAttribute(v69, "Dance", function(v96)
			if not v96 then
				if v78 then
					v78:Stop();
				end;
				if v80 then
					v80:Play();
				end;
				return nil;
			else
				if v80 and v80.IsPlaying then
					v80:Stop();
				end;
				if v78 then
					v78:Play();
				end;
				return nil;
			end;
		end));
		local v97 = {
			dance = v78,
			walk = v79,
			idle = v80
		};
		table.insert(v54, v97);
		v70:Add(function()
			local v98 = table.find(v54, v97);
			if v98 then
				table.remove(v54, v98);
			end;
		end);
		return v70:WrapClean();
	end));
end;

-- FIX PRINCIPAL : initMusicController corrigé
local function initMusicController(v100)
	v19:Add(task.spawn(function()
		l_AyMiGatito_0.PlaybackSpeed = 0.512;

		local v101 = workspace:GetServerTimeNow() - v100.startedAt;
		local v109 = v101 - 7;

		if v109 >= 0 and v109 < 218.313 then
			-- FIX: on compense la vitesse 0.512 pour le TimePosition de départ
			local safeTimePos = (v109 * 0.512) % SOUND_LENGTH;
			l_AyMiGatito_0.TimePosition = safeTimePos;
			l_AyMiGatito_0:Play();
		end;

		v19:Add(function()
			l_AyMiGatito_0:Stop();
			-- FIX: reset propre du PlaybackSpeed à la fin de l'event
			l_AyMiGatito_0.PlaybackSpeed = 0.512;
		end);

		local v110 = -1;
		v19:Add(l_RunService_0.PostSimulation:Connect(function(_)
			local v112 = workspace:GetServerTimeNow() - v100.startedAt;
			local v113 = v112 - 7;
			if v112 >= 225.313 then
				l_AyMiGatito_0:Stop();
				return;
			elseif v113 < 0 then
				return;
			else
				local PLAYBACK_SPEED = 0.512;
				local v114 = math.floor(v113 / SOUND_LOOP_DURATION);
				local v115 = v113 % SOUND_LOOP_DURATION;

				-- FIX: le son avance à 0.512x donc on compense le TimePosition attendu
				local safeTarget = (v115 * PLAYBACK_SPEED) % SOUND_LENGTH;

				if v114 ~= v110 and v110 >= 0 then
					l_AyMiGatito_0.TimePosition = 0;
				end;
				v110 = v114;

				-- FIX: seuil élargi légèrement pour éviter les corrections trop fréquentes
				if math.abs(l_AyMiGatito_0.TimePosition - safeTarget) > 0.5 then
					l_AyMiGatito_0.TimePosition = safeTarget;
				end;
				return;
			end;
		end));
	end));
end;

local function v141(v117)
	local v118 = {};
	v19:Add(l_RunService_0.PostSimulation:Connect(function(_)
		if #v118 == 0 then
			return;
		else
			local v120 = workspace:GetServerTimeNow() - v117.startedAt;
			local v128;
			if v120 < 7 then
				v128 = 0;
			else
				local v129 = v120 - 7;
				if v120 >= 222.313 then
					v128 = math.max(0, 1 - (v120 - 222.313) / 3);
				else
					local v130 = v129 % SOUND_LOOP_DURATION;
					v128 = v130 >= 43 and v130 < 48 and 0.4 or if v130 >= 48 and v130 < 50 then (v130 - 48) / 2 * 0.3 + 0.4 else v130 >= 50 and v130 < 55.5 and 0.7 or if v130 >= 55.5 and v130 < 57 then (v130 - 55.5) / 1.5 * 0.3 + 0.7 else 1;
				end;
			end;
			for _, v132 in v118 do
				if v132.IsPlaying then
					v132:AdjustSpeed(v128);
				end;
			end;
			return;
		end;
	end));
	v19:Add(function()
		table.clear(v118);
	end);
	v19:Add(v12.observeTag("AyMiGatitoAnimatedInstance", function(v133)
		local v134 = v14.new();
		local l_AnimationController_1 = v133:FindFirstChild("AnimationController");
		if not l_AnimationController_1 then
			return v134:WrapClean();
		else
			local l_Animator_1 = l_AnimationController_1:FindFirstChild("Animator");
			if not l_Animator_1 then
				return v134:WrapClean();
			else
				local l_Animation_0 = v133:FindFirstChild("Animation");
				if not l_Animation_0 then
					return v134:WrapClean();
				else
					local v138 = l_Animator_1:LoadAnimation(l_Animation_0);
					(v134 or v19):Add(function()
						v138:Stop(0);
						v138:Destroy();
					end);
					v138.Looped = true;
					v138.Priority = Enum.AnimationPriority.Action;
					v138:Play();
					table.insert(v118, v138);
					v134:Add(function()
						local v140 = table.find(v118, v138);
						if v140 then
							table.remove(v118, v140);
						end;
					end);
					return v134:WrapClean();
				end;
			end;
		end;
	end, {
		workspace
	}));
end;

local function v173(v142)
	v19:Add(task.delay(v142.startedAt + 7 + 7.308 - workspace:GetServerTimeNow(), function()
		v19:Add(v12.observeCharacters(function(_, v144)
			local v145 = v14.new();
			v145:Add(task.spawn(function()
				local l_Humanoid_0 = v144:WaitForChild("Humanoid");
				if not l_Humanoid_0 then
					return;
				else
					local l_Animator_2 = l_Humanoid_0:WaitForChild("Animator");
					if not l_Animator_2 then
						return;
					else
						local l_PlayerDance1_0 = script:FindFirstChild("PlayerDance1");
						local l_PlayerDance2_0 = script:FindFirstChild("PlayerDance2");
						local v150 = nil;
						local v151 = nil;
						if l_PlayerDance1_0 then
							v150 = l_Animator_2:LoadAnimation(l_PlayerDance1_0);
							v150.Priority = Enum.AnimationPriority.Action;
						end;
						if l_PlayerDance2_0 then
							v151 = l_Animator_2:LoadAnimation(l_PlayerDance2_0);
							v151.Priority = Enum.AnimationPriority.Action;
						end;
						local v152 = 0;
						local v153 = 1;
						v145:Add(l_RunService_0.PostSimulation:Connect(function(v154)
							debug.profilebegin("AyMiGatito:Player:Dance");
							local v155 = workspace:GetServerTimeNow() - v142.startedAt;
							local v156 = v155 - 7;
							v153 = 1;
							if v156 >= 0 then
								local v157 = math.floor(v156 / SOUND_LOOP_DURATION) + 1;
								local v158 = v156 % SOUND_LOOP_DURATION;
								if v157 == 2 and v158 >= 7.308 and v158 < 29.126 then
									v153 = 2;
								end;
							end;
							local v159 = if v153 == 1 then v150 else v151;
							local v160 = if v153 == 1 then v151 else v150;
							local v168;
							if v155 < 7 then
								v168 = 0;
							else
								local v169 = v155 - 7;
								if v155 >= 222.313 then
									v168 = math.max(0, 1 - (v155 - 222.313) / 3);
								else
									local v170 = v169 % SOUND_LOOP_DURATION;
									v168 = v170 >= 43 and v170 < 48 and 0.4 or if v170 >= 48 and v170 < 50 then (v170 - 48) / 2 * 0.3 + 0.4 else v170 >= 50 and v170 < 55.5 and 0.7 or if v170 >= 55.5 and v170 < 57 then (v170 - 55.5) / 1.5 * 0.3 + 0.7 else 1;
								end;
							end;
							local v172 = false;
							if v156 >= 0 then
								v172 = v156 <= 20;
							end;
							if l_Humanoid_0.MoveDirection == Vector3.new(0, 0, 0, 0) and not l_LocalPlayer_0:GetAttribute("Stealing") or v172 then
								if v152 < 3 and not v172 then
									v152 = v152 + v154;
								elseif v159 and not v159.IsPlaying then
									if v160 and v160.IsPlaying then
										v160:Stop();
									end;
									v159:Play();
								end;
								if v159 and v159.IsPlaying then
									v159:AdjustSpeed(v168);
								end;
							else
								v152 = 0;
								if v150 and v150.IsPlaying then
									v150:Stop();
								end;
								if v151 and v151.IsPlaying then
									v151:Stop();
								end;
							end;
							debug.profileend();
						end));
						v145:Add(function()
							if v150 then
								v150:Stop();
								v150:Destroy();
							end;
							if v151 then
								v151:Stop();
								v151:Destroy();
							end;
						end);
						return;
					end;
				end;
			end));
			return v145:WrapClean();
		end));
	end));
end;

v6.OnStart = function(_)
	local l_v11_ActiveEventData_0 = v11:GetActiveEventData(l_Name_0);
	assert(l_v11_ActiveEventData_0);
	l_ReplicatedStorage_0:SetAttribute("AyMiGatitoEvent", true);
	v19:Add(function()
		l_ReplicatedStorage_0:SetAttribute("AyMiGatitoEvent", nil);
		v8:Activate("Blink");
		v10:Update();
		v9:UpdateOST();
		v9:UpdateAmbience();
	end);
	v19:Add(task.delay(l_v11_ActiveEventData_0.startedAt + 7 - workspace:GetServerTimeNow(), function()
		if v13.IsTsunamiServer() then
			v19:Clone(script.MapVFXTsunami).Parent = workspace;
		elseif v13.IsBiggerServer() then
			v19:Clone(script.MapVFXBigger).Parent = workspace;
		else
			v19:Clone(script.MapVFX).Parent = workspace;
		end;
		if v13.IsTsunamiServer() then
			v19:Clone(script.GatitoMapTsunami).Parent = workspace;
		elseif v13.IsBiggerServer() then
			v19:Clone(script.GatitoMapBigger).Parent = workspace;
		else
			v19:Clone(script.GatitoMap).Parent = workspace;
		end;
		v8:Run("AyMiGatitoEvent", "GrassRecolor");
		v19:Add(function()
			v8:Stop("AyMiGatitoEvent", "GrassRecolor");
		end);
		v8:Run("AyMiGatitoEvent", "WallRecolor");
		v19:Add(function()
			v8:Stop("AyMiGatitoEvent", "WallRecolor");
		end);
		v8:Run("AyMiGatitoEvent", "WallBottomRecolor");
		v19:Add(function()
			v8:Stop("AyMiGatitoEvent", "WallBottomRecolor");
		end);
		local l_Atmosphere_0 = l_Lighting_0:FindFirstChild("Atmosphere");
		if l_Atmosphere_0 then
			l_Atmosphere_0.Parent = script;
			v19:Add(function()
				l_Atmosphere_0.Parent = l_Lighting_0;
			end);
		end;
		v19:Clone(script.AtmosphereAyMiGatito).Parent = l_Lighting_0;
		v19:Add(v12.observeTag("HideInAyMiGatito", function(v177)
			local l_Parent_0 = v177.Parent;
			v177.Parent = script;
			return function()
				pcall(function()
					v177.Parent = l_Parent_0;
				end);
			end;
		end, {
			workspace,
			script
		}));
		v10:Update();
		v9:UpdateOST();
		v9:UpdateAmbience();
		v8:Activate("Blink");

		-- FIX: appel de la version corrigée d'initMusicController
		initMusicController(l_v11_ActiveEventData_0);

		v99(l_v11_ActiveEventData_0);
		v141(l_v11_ActiveEventData_0);
		v173(l_v11_ActiveEventData_0);
	end));
	v19:Add(task.spawn(function()
		v52();
	end));
	v19:Add(v20.OnClientEvent:Connect(function(v195)
		v7.playBurst(script.Burst, v195, {
			l_ReplicatedStorage_0.Sounds.Events["Ay Mi Gatito"].Hit
		});
	end));
end;

v6.OnStop = function(_)
	v19:Destroy();
end;

v6.OnLoad = function(_)
	task.spawn(pcall, function()
		l_ContentProvider_0:PreloadAsync(script:GetChildren());
		l_ContentProvider_0:PreloadAsync({
			l_AyMiGatito_0
		});
	end);
end;

return v6;