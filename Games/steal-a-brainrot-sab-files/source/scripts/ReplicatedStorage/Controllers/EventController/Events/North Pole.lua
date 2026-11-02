local l_ProximityPromptService_0 = game:GetService("ProximityPromptService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("ContentProvider");
local l_TweenService_0 = game:GetService("TweenService");
local l_HttpService_0 = game:GetService("HttpService");
local l_RunService_0 = game:GetService("RunService");
local l_Lighting_0 = game:GetService("Lighting");
local l_Players_0 = game:GetService("Players");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v9 = {};
local v10 = require(l_ReplicatedStorage_0.Controllers.EventController.ClientEventUtils);
local v11 = require(l_ReplicatedStorage_0.Controllers.EffectController);
local _ = require(l_ReplicatedStorage_0.Controllers.AnimalController);
local v13 = require(l_ReplicatedStorage_0.Controllers.EventController);
local v14 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local v15 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local _ = require(l_ReplicatedStorage_0.Shared.SharedEventUtils);
local v17 = require(l_ReplicatedStorage_0.Shared.VFX);
local v18 = require(l_ReplicatedStorage_0.Datas.ServerData);
local v19 = require(l_ReplicatedStorage_0.Utils.MathUtils);
local v20 = require(l_ReplicatedStorage_0.Shared.Animals);
local v21 = require(l_ReplicatedStorage_0.Packages.CreateTween);
local v22 = require(l_ReplicatedStorage_0.Packages.Observers);
local v23 = require(l_ReplicatedStorage_0.Packages.FFlags);
local v24 = require(l_ReplicatedStorage_0.Packages.Trove);
local v25 = require(l_ReplicatedStorage_0.Packages.Net);
local v26 = require(l_ReplicatedStorage_0.Packages.Spr);
local l_Name_0 = script.Name;
local v28 = v25:RemoteEvent((("EventService/%*/StartTransition"):format(l_Name_0)));
local v29 = v25:RemoteEvent((("EventService/%*/StopTransition"):format(l_Name_0)));
local v30 = v25:RemoteEvent((("EventService/%*/PointArrow"):format(l_Name_0)));
local v31 = v25:RemoteEvent((("EventService/%*/Delivery"):format(l_Name_0)));
local v32 = v25:RemoteEvent((("EventService/%*/Burst"):format(l_Name_0)));
local v33 = v25:RemoteEvent((("EventService/%*/Grab"):format(l_Name_0)));
local v34 = v25:RemoteEvent((("EventService/%*/CandyCaneAnimation"):format(l_Name_0)));
local v35 = v25:RemoteEvent((("EventService/%*/SpawnBrainrot"):format(l_Name_0)));
local v36 = v25:RemoteEvent((("EventService/%*/DestroyGift"):format(l_Name_0)));
local v37 = v25:RemoteEvent((("EventService/%*/GiftBurst"):format(l_Name_0)));
local v38 = v25:RemoteEvent((("EventService/%*/SpawnGift"):format(l_Name_0)));
local v39 = v25:RemoteEvent((("EventService/%*/OpenGift"):format(l_Name_0)));
local v40 = v24.new();
local v41 = false;
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_CurrentCamera_0 = workspace.CurrentCamera;
local v44 = CFrame.new(0, 1000, 100000);
local v45 = RaycastParams.new();
v45.FilterType = Enum.RaycastFilterType.Include;
v45.FilterDescendantsInstances = {
	workspace.Map
};
local v46 = v24.new();
local function _(v47, v48, v49)
	local v50 = v47:LoadAnimation(v48);
	(v49 or v46):Add(function()
		v50:Stop(0);
		v50:Destroy();
	end);
	return v50;
end;
local function v81(v52)
	if v41 then
		return;
	else
		v41 = true;
		l_ReplicatedStorage_0:SetAttribute("InTrainTravelCutscene", true);
		local v53 = false;
		local v54 = v24.new();
		local l_ColorCorrectionEffect_0 = Instance.new("ColorCorrectionEffect");
		l_ColorCorrectionEffect_0.Parent = l_CurrentCamera_0;
		l_ProximityPromptService_0.Enabled = false;
		v40:Add(function()
			l_ProximityPromptService_0.Enabled = true;
		end);
		local v56 = v54:Clone(script.SnowyAtmosphere);
		local function v62(v57, v58)
			local v59 = l_TweenService_0:Create(l_ColorCorrectionEffect_0, TweenInfo.new(1), {
				TintColor = if v57 == "Out" then Color3.new(0, 0, 0) else Color3.new(1, 1, 1)
			});
			v59:Play();
			if v58 ~= nil then
				local v61 = v59.Completed:Connect(function(v60)
					if v60 ~= Enum.PlaybackState.Cancelled then
						v58(v60);
					end;
				end);
				if not v53 then
					v40:Add(v61);
				end;
			end;
			if not v53 then
				v40:Add(function()
					v59:Cancel();
					v59:Destroy();
				end);
			end;
		end;
		local v63 = false;
		local v64 = false;
		local function v67()
			if v63 or not v64 then
				return;
			else
				v63 = true;
				l_CurrentCamera_0.CameraType = Enum.CameraType.Custom;
				local l_Character_0 = l_Players_0.LocalPlayer.Character;
				local v66 = l_Character_0 and l_Character_0:FindFirstChildOfClass("Humanoid");
				if v66 ~= nil then
					l_CurrentCamera_0.CameraSubject = v66;
				end;
				return;
			end;
		end;
		v40:Add(function()
			v41 = false;
			v53 = true;
			v62("Out", function()
				v54:Clean();
				if not v63 and v64 then
					v63 = true;
					l_CurrentCamera_0.CameraType = Enum.CameraType.Custom;
					local l_Character_1 = l_Players_0.LocalPlayer.Character;
					local v69 = l_Character_1 and l_Character_1:FindFirstChildOfClass("Humanoid");
					if v69 ~= nil then
						l_CurrentCamera_0.CameraSubject = v69;
					end;
				end;
				l_ReplicatedStorage_0:SetAttribute("InTrainTravelCutscene", nil);
				v62("In", function()
					l_ColorCorrectionEffect_0:Destroy();
				end);
			end);
		end);
		local l_Road_0 = script.Road;
		local v71 = v54:Clone(script.BrainrotExpress);
		v71.Parent = l_CurrentCamera_0;
		local v72 = l_Road_0.End.Position.Z - l_Road_0.Start.Position.Z;
		local v73 = v52 * 260;
		for v74 = 1, math.max(math.ceil(v73 / (v72 - 100)), 1) + 2 do
			local v75 = v54:Clone(l_Road_0);
			v75:PivotTo(v44 * CFrame.new(0, 0, -(v72 * (v74 - 1))));
			v75.Parent = l_CurrentCamera_0;
		end;
		v62("Out", function()
			v64 = true;
			v56.Parent = l_Lighting_0;
			l_CurrentCamera_0.CameraType = Enum.CameraType.Scriptable;
			v54:Add(v67);
			local v76 = os.clock();
			local v77 = v76 + v52;
			local _ = v54:Add(l_RunService_0.PreRender:Connect(function()
				local v78 = math.clamp((os.clock() - v76) / (v77 - v76), 0, 1);
				local v79 = v44 * CFrame.new(0, 0, -50) * CFrame.new(0, 0, -((v73 - 50) * v78));
				v71:PivotTo(v79);
				l_CurrentCamera_0.CFrame = v71.Camera.CFrame;
			end));
			v54:Add(task.delay(v52 - 1, function()
				v40:Clean();
			end));
			l_ReplicatedStorage_0.Sounds.Events["North Pole"].TrainLoop:Play();
			v54:Add(function()
				l_ReplicatedStorage_0.Sounds.Events["North Pole"].TrainLoop:Stop();
			end);
			v62("In");
		end);
		return;
	end;
end;
local function v82()
	if not v41 then
		return;
	else
		v40:Clean();
		return;
	end;
end;
local function v88(v83, v84)
	local l_Character_2 = v83.Character;
	if not l_Character_2 then
		return;
	else
		local l_HumanoidRootPart_0 = l_Character_2:FindFirstChild("HumanoidRootPart");
		if not l_HumanoidRootPart_0 then
			return;
		else
			local v87 = script.Reward:Clone();
			v87.CurrencyCandyCane.Text = ("+%*"):format(v84);
			v87.Parent = l_HumanoidRootPart_0;
			l_TweenService_0:Create(v87, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
				StudsOffset = Vector3.new(0, 2.5, 2.200000047683716, 0)
			}):Play();
			l_TweenService_0:Create(v87.ImageLabel.ImageLabel, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
				ImageTransparency = 1
			}):Play();
			l_TweenService_0:Create(v87.CurrencyCandyCane, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
				TextTransparency = 1
			}):Play();
			l_TweenService_0:Create(v87.CurrencyCandyCane.UIStroke, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
				Transparency = 1
			}):Play();
			task.delay(5, function()
				v87:Destroy();
			end);
			return;
		end;
	end;
end;
local function v93()
	local v89 = Random.new();
	for _ = 1, 10 do
		local v91 = script.Image:Clone();
		v91.Position = UDim2.fromScale(v89:NextNumber(-0.25, 1.25), -0.25);
		v91.Rotation = v89:NextNumber(-120, 120);
		local v92 = v89:NextNumber(0.15, 0.2);
		v91.Size = UDim2.fromScale(v92, v92);
		v91.Parent = l_LocalPlayer_0.PlayerGui:FindFirstChild("Effects");
		v21(v91, TweenInfo.new(v89:NextNumber(0.75, 1.3), Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			Position = v91.Position + UDim2.fromScale(0, 1.5), 
			Rotation = v91.Rotation + v89:NextInteger(-3, 3) * 10
		}, true).Completed:Once(function()
			task.wait(1);
			v91:Destroy();
		end);
	end;
end;
v9.OnStart = function(_)
	local l_v13_ActiveEventData_0 = v13:GetActiveEventData(l_Name_0);
	assert(l_v13_ActiveEventData_0);
	local function _(v96)
		return (math.max(l_v13_ActiveEventData_0.startedAt + v96 - workspace:GetServerTimeNow(), 0));
	end;
	v46:Add(v28.OnClientEvent:Connect(v81));
	v46:Add(v29.OnClientEvent:Connect(v82));
	local v98 = v46:Clone(script.EntranceSign);
	v98.Parent = workspace;
	v46:Add(l_ReplicatedStorage_0:GetAttributeChangedSignal("NorthPoleEventInMap"):Connect(function()
		if l_ReplicatedStorage_0:GetAttribute("NorthPoleEventInMap") and v98 then
			v46:Remove(v98);
			v98 = nil;
		end;
	end));
	local v99 = v46:Extend();
	local v100 = nil;
	local v101 = nil;
	v46:Add(v30.OnClientEvent:Connect(function(v102, v103)
		if v102 == nil then
			v99:Clean();
			return;
		else
			v100 = v102;
			v101 = v103;
			v99:Add(function()
				v100 = nil;
				v101 = nil;
			end);
			local v104 = v99:Clone(script.PointingArrow);
			local l_Start_0 = v104.Start;
			local l_End_0 = v104.End;
			v104.Parent = workspace;
			v99:Add(l_RunService_0.PreRender:Connect(function()
				local v107 = if typeof(v102) == "Instance" then v102:GetPivot().Position else if typeof(v102) == "CFrame" then v102.Position else v102;
				local l_Character_3 = l_LocalPlayer_0.Character;
				if l_Character_3 then
					local l_l_Character_3_Pivot_0 = l_Character_3:GetPivot();
					l_Start_0:PivotTo(l_l_Character_3_Pivot_0);
					if v101 and (v107 - l_l_Character_3_Pivot_0.Position).Magnitude <= 10 then
						v99:Clean();
					end;
				end;
				l_End_0:PivotTo(CFrame.new(v107));
			end));
			return;
		end;
	end));
	v46:Add(v22.observeTag("NorthPoleEventGrabItem", function(v110)
		return v22.observeAttribute(v110, "GrabPrompt", function(v111)
			if v111 == false then
				return;
			else
				local l_Name_1 = v110.Name;
				local l_ProximityPrompt_0 = Instance.new("ProximityPrompt");
				l_ProximityPrompt_0.Name = "ProximityPrompt";
				l_ProximityPrompt_0.ActionText = "Grab";
				l_ProximityPrompt_0.HoldDuration = 0.5;
				l_ProximityPrompt_0.RequiresLineOfSight = false;
				l_ProximityPrompt_0.Enabled = true;
				l_ProximityPrompt_0.Parent = v110;
				local v114 = l_ProximityPrompt_0.Triggered:Connect(function()
					v33:FireServer(l_Name_1);
				end);
				return function()
					l_ProximityPrompt_0:Destroy();
					v114:Disconnect();
				end;
			end;
		end);
	end, {
		workspace
	}));
	v46:Add(v22.observeTag("NorthPolePlayerCollision", function(v115)
		v115.CanCollide = true;
		return nil;
	end, {
		workspace
	}));
	v46:Add(v22.observeTag("NorthPoleDoor", function(v116)
		local l_v116_Pivot_0 = v116:GetPivot();
		return v22.observeAttribute(v116, "Open", function(v118)
			if not v118 then
				v26.target(v116, 0.75, 3.5, {
					Pivot = l_v116_Pivot_0
				});
				v15:PlaySound(script.DoorClose, l_v116_Pivot_0.Position, false);
			else
				v26.target(v116, 0.75, 3.5, {
					Pivot = l_v116_Pivot_0 * CFrame.Angles(0, -1.5707963267948966, 0)
				});
				v15:PlaySound(script.DoorOpen, l_v116_Pivot_0.Position, false);
			end;
			return function()
				if v116:IsDescendantOf(workspace) then
					v26.target(v116, 0.75, 3.5, {
						Pivot = l_v116_Pivot_0
					});
					v15:PlaySound(script.DoorClose, l_v116_Pivot_0.Position, false);
				end;
			end;
		end);
	end, {
		workspace
	}));
	local v119 = {};
	local v120 = {};
	v46:Add(v22.observeTag("NorthPoleSantaSleign", function(v121)
		local l_Name_2 = v121.Name;
		local v123 = l_ReplicatedStorage_0.Models.Events["North Pole"].Sleigh:Clone();
		v123.PrimaryPart.Anchored = true;
		if v23:GetInstant("Optimisation.HumanoidBrainrotModels", v18.IsNewPlayersServer()) then
			local l_AnimationController_0 = v123:FindFirstChild("AnimationController");
			if l_AnimationController_0 then
				l_AnimationController_0:Destroy();
			end;
			local v125 = Instance.new("Humanoid", v123);
			local _ = Instance.new("Animator", v125);
			v125.Name = "AnimationController";
			v125.EvaluateStateMachine = false;
			v125.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
			v125.PlatformStand = true;
			v125.Parent = v123;
		end;
		v123.Parent = v121;
		local v127 = v123.AnimationController.Animator:LoadAnimation(l_ReplicatedStorage_0.Models.Events["North Pole"].SleighFly);
		v127.Looped = true;
		v127:Play();
		local function v133()
			local v128 = l_HttpService_0:JSONDecode(v121:GetAttribute("Gifts") or "[]");
			for v129 = 1, 10 do
				local l_FirstChild_0 = v123.Gifts:FindFirstChild((tostring(v129)));
				if l_FirstChild_0 then
					l_FirstChild_0:SetAttribute("GiftTexture", v128[v129] or "");
					l_FirstChild_0:AddTag("NorthPoleEventGiftTexture");
					for _, v132 in l_FirstChild_0:GetChildren() do
						if v132:IsA("BasePart") then
							v132.Transparency = v129 <= #v128 and 0 or 1;
						end;
					end;
				end;
			end;
		end;
		local v134 = v121:GetAttributeChangedSignal("Gifts"):Connect(v133);
		v133();
		table.insert(v119, v121);
		v120[l_Name_2] = v123;
		return function()
			v120[l_Name_2] = nil;
			local v135 = table.find(v119, v121);
			if v135 then
				table.remove(v119, v135);
			end;
			v134:Disconnect();
			v127:Stop(0);
			v127:Destroy();
			v123:Destroy();
		end;
	end));
	v46:Add(l_RunService_0.PreRender:Connect(function(_)
		debug.profilebegin("North Pole:BulkMoveTo");
		local v137 = {};
		local v138 = {};
		for _, v140 in v119 do
			local v141 = v120[v140.Name];
			if v141 then
				table.insert(v137, v141.PrimaryPart);
				table.insert(v138, v140.CFrame);
			end;
		end;
		workspace:BulkMoveTo(v137, v138, Enum.BulkMoveMode.FireCFrameChanged);
		debug.profileend();
	end));
	local v142 = {};
	local v143 = OverlapParams.new();
	v46:Add(v22.observeTag("NorthPoleDeliveryHitboxes", function(v144)
		table.insert(v142, v144);
		v143.FilterDescendantsInstances = v142;
		return function()
			local v145 = table.find(v142, v144);
			if v145 then
				table.remove(v142, v145);
				v143.FilterDescendantsInstances = v142;
			end;
		end;
	end));
	v143.FilterDescendantsInstances = v142;
	v143.FilterType = Enum.RaycastFilterType.Include;
	v143.MaxParts = 1;
	local v146 = 0;
	v46:Add(l_RunService_0.PostSimulation:Connect(function(v147)
		v146 = v146 + v147;
		if v146 < 0.05 then
			return;
		else
			debug.profilebegin("NorthPole:Hitboxes");
			v146 = 0;
			if not l_LocalPlayer_0:GetAttribute("Stealing") then
				return;
			else
				local l_Character_4 = l_LocalPlayer_0.Character;
				if not l_Character_4 then
					debug.profileend();
					return;
				else
					local l_Position_0 = l_Character_4:GetPivot().Position;
					if #workspace:GetPartBoundsInBox(CFrame.new(l_Position_0), Vector3.new(4, 4, 2, 0), v143) <= 0 then
						return;
					else
						v31:FireServer();
						debug.profileend();
						return;
					end;
				end;
			end;
		end;
	end));
	v46:Add(v22.observeTag("NorthPoleSantaSpawner", function(v150)
		local v151 = script.SpawnerUI:Clone();
		v151.Adornee = v150;
		v151.Parent = l_LocalPlayer_0.PlayerGui;
		local v163 = v22.observeAttribute(v150, "Brainrots", function(v152)
			if v152 == nil then
				return nil;
			else
				local v153 = v24.new();
				for _, v155 in l_HttpService_0:JSONDecode(v152) do
					local l_Index_0 = v155.Index;
					local l_Brainrot_0 = v155.Brainrot;
					local l_Price_0 = v155.Price;
					local v159 = v153:Clone(v151.ScrollingFrame.UIListLayout.Template);
					v159.Spacer.Title.Text = l_Brainrot_0;
					local v160 = v20:AttachOnViewport(l_Brainrot_0, v159.Spacer.ViewportFrame, true);
					if v160 then
						v153:Add(v160);
					end;
					v159.Spacer.Buy.Txt.Size = UDim2.fromScale(0.35, 0.8);
					v159.Spacer.Buy.Txt.Text = l_Price_0;
					v159.Parent = v151.ScrollingFrame;
					local function v162()
						local v161 = l_HttpService_0:JSONDecode(v150:GetAttribute("Stocks") or "[]");
						if not l_Index_0 or (v161[l_Index_0] or 0) <= 0 then
							v26.target(v159.Spacer.Buy, 1, 5, {
								BackgroundColor3 = Color3.fromRGB(150, 150, 150)
							});
							v159.Spacer.Amount.Text = "SOLD OUT";
							v159.Spacer.Amount.TextColor3 = Color3.fromRGB(255, 61, 61);
							return;
						else
							v26.target(v159.Spacer.Buy, 1, 5, {
								BackgroundColor3 = Color3.fromRGB(81, 158, 86)
							});
							v159.Spacer.Amount.Text = ("%* LEFT"):format(v161[l_Index_0] or 0);
							v159.Spacer.Amount.TextColor3 = Color3.fromRGB(255, 213, 0);
							return;
						end;
					end;
					v153:Add(v150:GetAttributeChangedSignal("Stocks"):Connect(v162));
					v162();
					v153:Add(v159.Spacer.Buy.Activated:Connect(function()
						v35:FireServer(l_Brainrot_0);
					end));
				end;
				return v153:WrapClean();
			end;
		end);
		return function()
			v163();
			v151:Destroy();
		end;
	end));
	v46:Add(v22.observeTag("Elf", function(v164)
		local v165 = v24.new();
		local l_HumanoidRootPart_1 = v164:WaitForChild("HumanoidRootPart");
		local v167 = v165:Clone(script.Elf);
		local v168 = v165:Add(Instance.new("Weld"));
		v168.Part0 = v167.PrimaryPart;
		v168.Part1 = l_HumanoidRootPart_1;
		v168.Parent = v167.PrimaryPart;
		v167.Parent = v164;
		local l_AnimationController_1 = v167:FindFirstChild("AnimationController");
		if l_AnimationController_1 then
			l_AnimationController_1:Destroy();
		end;
		local v170 = Instance.new("Humanoid", v167);
		local _ = Instance.new("Animator", v170);
		v170.Name = "AnimationController";
		v170.EvaluateStateMachine = false;
		v170.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
		v170.PlatformStand = true;
		v170.Parent = v167;
		local l_Animator_0 = v167.AnimationController.Animator;
		local v173 = l_Animator_0:LoadAnimation(script.Idle);
		local l_v173_0 = v173 ;
		(v165 or v46):Add(function()
			l_v173_0:Stop(0);
			l_v173_0:Destroy();
		end);
		local l_v173_1 = v173;
		l_v173_1.Looped = true;
		l_v173_1.Priority = Enum.AnimationPriority.Idle;
		l_v173_1:Play();
		local v176 = l_Animator_0:LoadAnimation(script.Attack);
		(v165 or v46):Add(function()
			v176:Stop(0);
			v176:Destroy();
		end);
		local l_v176_0 = v176;
		l_v176_0.Looped = false;
		l_v176_0.Priority = Enum.AnimationPriority.Action;
		v165:Add(l_v176_0:GetMarkerReachedSignal("CandyDisappear"):Once(function()
			v167.Candy.Transparency = 1;
		end));
		v165:Add(v164:GetAttributeChangedSignal("AttackAnimation"):Connect(function()
			l_v176_0:Play();
		end));
		local v178 = l_Animator_0:LoadAnimation(script.Walk);
		(v165 or v46):Add(function()
			v178:Stop(0);
			v178:Destroy();
		end);
		v173 = v178;
		v173.Priority = Enum.AnimationPriority.Action2;
		v165:Add(v22.observeAttribute(v164, "IsRunning", function(v179)
			if v179 then
				v173:Play();
				v173:AdjustSpeed(1.5);
			else
				v173:Stop();
			end;
			return nil;
		end));
		return v165:WrapClean();
	end));
	v46:Add(l_ReplicatedStorage_0:GetAttributeChangedSignal("NorthPoleEventActive"):Connect(function()
		v14:Update();
		v15:UpdateOST();
	end));
	v46:Add(function()
		task.spawn(v82);
		v11:Activate("Blink");
		v14:Update();
		v15:UpdateOST();
	end);
end;
v9.OnStop = function(_)
	v46:Destroy();
end;
v9.OnLoad = function(_)
	v37.OnClientEvent:Connect(function(v182)
		if typeof(v182) == "Instance" then
			local v183 = v46:Clone(script.GiftBurst);
			v183.Anchored = false;
			v183:PivotTo(v182:GetPivot());
			v183.Parent = workspace;
			local l_Weld_0 = Instance.new("Weld");
			l_Weld_0.Part0 = v183;
			l_Weld_0.Part1 = v182;
			l_Weld_0.Parent = v183;
			v17.emit(v183);
			task.delay(5, function()
				v183:Destroy();
			end);
			task.spawn(function()
				v15:PlaySound(l_ReplicatedStorage_0.Sounds.Events["North Pole"].PresentOpen, v183:GetPivot().Position);
			end);
			return;
		elseif typeof(v182) == "Vector3" then
			local v185 = v46:Clone(script.GiftBurst);
			v185.Anchored = true;
			v185:PivotTo(CFrame.new(v182));
			v185.Parent = workspace;
			v17.emit(v185);
			task.delay(5, function()
				v185:Destroy();
			end);
			task.spawn(function()
				v15:PlaySound(l_ReplicatedStorage_0.Sounds.Events["North Pole"].PresentOpen, v185:GetPivot().Position);
			end);
			return;
		else
			v10.playBurst(script.GiftBurst, v182, {
				l_ReplicatedStorage_0.Sounds.Events["North Pole"].PresentOpen
			});
			return;
		end;
	end);
	local v186 = {
		"rbxassetid://106128825959360", 
		"rbxassetid://84670396546354", 
		"rbxassetid://131357512835082", 
		"rbxassetid://94526507693712"
	};
	v22.observeTag("NorthPoleEventGiftTexture", function(v187)
		local v188 = v187:GetAttribute("GiftTexture") or "";
		local v189 = 0;
		for v190 = 1, #v188 do
			local v191 = string.byte(v188, v190);
			v189 = (v189 * 31 + v191) % 4294967296;
		end;
		local v192 = v186[v189 % #v186 + 1] or v186[1];
		return v22.observeDescendants(v187, function(v193)
			if not v193:IsA("MeshPart") then
				return nil;
			else
				local l_TextureID_0 = v193.TextureID;
				if l_TextureID_0 == "" then
					return nil;
				else
					v193.TextureID = v192;
					return function()
						v193.TextureID = l_TextureID_0;
					end;
				end;
			end;
		end);
	end);
	local v195 = {};
	v38.OnClientEvent:Connect(function(v196, _, v198, v199, v200, v201)
		local v202 = l_ReplicatedStorage_0.Models.Events["North Pole"].WrappedGift:Clone();
		v202.Name = v196;
		v202:SetAttribute("GiftTexture", v196);
		v202:AddTag("NorthPoleEventGiftTexture");
		v195[v196] = v202;
		local v203 = v202.PrimaryPart or v202:FindFirstChild("Handle");
		if v203 then
			v203.Anchored = true;
			local l_Attachment_0 = Instance.new("Attachment");
			l_Attachment_0.Name = "Attachment0";
			l_Attachment_0.Position = Vector3.new(0, 1, 0, 0);
			l_Attachment_0.Parent = v203;
			local l_Attachment_1 = Instance.new("Attachment");
			l_Attachment_1.Name = "Attachment1";
			l_Attachment_1.Position = Vector3.new(0, -1, 0, 0);
			l_Attachment_1.Parent = v203;
			local l_Trail_0 = Instance.new("Trail");
			l_Trail_0.Name = "Trail";
			l_Trail_0.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 69, 69)), 
				ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 69, 69))
			});
			l_Trail_0.Attachment0 = l_Attachment_0;
			l_Trail_0.Attachment1 = l_Attachment_1;
			l_Trail_0.Lifetime = 0.35;
			l_Trail_0.LightInfluence = 1;
			l_Trail_0.Parent = v202;
		end;
		v202.Parent = workspace;
		local l_ProximityPrompt_1 = Instance.new("ProximityPrompt");
		l_ProximityPrompt_1.Name = "ProximityPrompt";
		l_ProximityPrompt_1.ActionText = "Open";
		l_ProximityPrompt_1.RequiresLineOfSight = false;
		l_ProximityPrompt_1.Enabled = false;
		l_ProximityPrompt_1.HoldDuration = 0.5;
		l_ProximityPrompt_1.Parent = v203;
		local l_v202_Scale_0 = v202:GetScale();
		task.spawn(function()
			v15:PlaySound(l_ReplicatedStorage_0.Sounds.Events["North Pole"].SantaHoHoHo, v198, false);
			local v209 = l_ReplicatedStorage_0.Sounds.Events["North Pole"].PresentDrop:Clone();
			v209.Parent = v202.PrimaryPart;
			v209:Play();
			v209.Ended:Once(function()
				v209:Destroy();
			end);
		end);
		local v210 = workspace:Raycast(v199 + Vector3.new(0, 10, 0, 0), Vector3.new(-0, -30, -0, -0), v45);
		v199 = v210 and v210.Position or v199;
		local v211 = v198 + (v199 - v198) * 0.5;
		local l_v199_0 = v199;
		local _ = math.random(0, 10000);
		local v214 = false;
		local v221 = l_RunService_0.PostSimulation:Connect(function(_)
			local v216 = workspace:GetServerTimeNow() - v200;
			local v217 = v201 == 0 and 1 or math.clamp(v216 / v201, 0, 1);
			local l_l_TweenService_0_Value_0 = l_TweenService_0:GetValue(v217, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
			local v219 = v19.quadBezier(l_l_TweenService_0_Value_0, v198, v211, l_v199_0);
			v202:ScaleTo((math.lerp(l_v202_Scale_0 * 2, l_v202_Scale_0, l_l_TweenService_0_Value_0)));
			v202:PivotTo(CFrame.new(v219) * CFrame.Angles(0, math.lerp(12.566370614359172, 0, l_l_TweenService_0_Value_0), 0));
			if l_l_TweenService_0_Value_0 >= 0.8 and not v214 then
				v214 = true;
				local v220 = script.GiftLanding:Clone();
				v220:PivotTo(CFrame.new(l_v199_0));
				v220.Parent = workspace;
				v17.emit(v220);
				task.delay(5, function()
					v220:Destroy();
				end);
			end;
			if l_l_TweenService_0_Value_0 >= 1 then
				l_ProximityPrompt_1.Enabled = true;
			end;
		end);
		v202.Destroying:Connect(function()
			v221:Disconnect();
		end);
		l_ProximityPrompt_1.Triggered:Connect(function()
			v39:FireServer(v196);
		end);
	end);
	v36.OnClientEvent:Connect(function(v222)
		local v223 = v195[v222];
		if not v223 then
			return;
		else
			v223:Destroy();
			v195[v222] = nil;
			return;
		end;
	end);
	v34.OnClientEvent:Connect(function(v224, v225, v226, v227)
		local v228 = 0;
		local l_Model_0 = Instance.new("Model");
		local v230 = l_ReplicatedStorage_0.Models.Events["North Pole"]["Candy Cane Tiers"][v226]:Clone();
		v230.Parent = l_Model_0;
		if v230:IsA("Model") then
			l_Model_0.PrimaryPart = v230.PrimaryPart;
		else
			l_Model_0.PrimaryPart = v230;
		end;
		l_Model_0.Parent = workspace;
		local l_l_Model_0_Scale_0 = l_Model_0:GetScale();
		local v232 = nil;
		v232 = l_RunService_0.PostSimulation:Connect(function(v233)
			debug.profilebegin("North Pole:UpdateCandyAnimation");
			v228 = v228 + v233;
			local v234 = v225.Character and v225.Character:GetPivot().Position or Vector3.new(0, 0, 0, 0);
			local v235 = v224 + (v234 - v224) * 0.25 + Vector3.new(0, 20, 0, 0);
			local l_l_TweenService_0_Value_1 = l_TweenService_0:GetValue(v228 / 0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
			l_Model_0:PivotTo(CFrame.new(v19.quadBezier(l_l_TweenService_0_Value_1, v224, v235, v234)));
			l_Model_0:ScaleTo((math.lerp(l_l_Model_0_Scale_0, 0.05, l_l_TweenService_0_Value_1)));
			if l_l_TweenService_0_Value_1 >= 1 and v232 then
				v232:Disconnect();
				v232 = nil;
				for _, v238 in l_Model_0:GetDescendants() do
					if v238:IsA("BasePart") then
						v238.Transparency = 1;
					end;
				end;
				task.delay(3, function()
					l_Model_0:Destroy();
				end);
				if v225 == l_LocalPlayer_0 then
					v93();
				end;
				v88(v225, v227);
			end;
			debug.profileend();
		end);
	end);
	v32.OnClientEvent:Connect(function(v239, v240, v241)
		v10.playBurst(script.Burst, v239, {
			l_ReplicatedStorage_0.Sounds.Events["North Pole"].CandyCane
		});
		if v240 and v241 then
			v88(v240, v241);
		end;
	end);
end;
return v9;
