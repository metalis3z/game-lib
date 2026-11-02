-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw
print(game:GetService("RunService"):IsServer())

function multiplyColor3(color3 : Color3, multiplier : number)
	if (color3.R + color3.G)/2 > color3.B then
		return Color3.new(color3.R * multiplier, color3.G * multiplier, color3.B * multiplier)
	else
		return color3
	end
end

function calculateTextScaledMultiplier(partsize : Vector3, text : string, textSize : number, textFont : Enum.Font)
	local part = Instance.new("Part", workspace)
	part.Size = partsize
	local surface = Instance.new("SurfaceGui", part)
	surface.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
	surface.PixelsPerStud = 50
	local textlabel = Instance.new("TextLabel", surface)
	textlabel.Size = UDim2.new(1, 0, 1, 0)
	textlabel.Font = textFont
	textlabel.TextSize = 40
	textlabel.TextXAlignment = Enum.TextXAlignment.Left
	textlabel.Text = string.gsub(text, " ", "i")
	local oldY = textlabel.TextBounds.Y
	textlabel.TextScaled = true
	local newY = textlabel.TextBounds.Y
	part:Destroy()
	return newY/oldY > 1.2 and 1.2 or newY/oldY
end

function yourselfify(id, rig, name)
	local descriptionrig = rig:Clone()
	descriptionrig.Parent = game.ReplicatedStorage descriptionrig.Name = "DescriptionHolder"
	descriptionrig.Humanoid:ApplyDescription(game.Players:GetHumanoidDescriptionFromUserId(id))
	local displayname = name or game:GetService("UserService"):GetUserInfosByUserIdsAsync({id})[1].DisplayName
	local multiplier = calculateTextScaledMultiplier(Vector3.new(4.485, 2.243, 2), "team " .. displayname .. "\njoin today!", 40, Enum.Font.SourceSans)
	local colours : BodyColors = descriptionrig:WaitForChild("Body Colors")
	colours:Clone().Parent = rig
	rig.coolkiddrblx.Headc.Color = colours.HeadColor3
	rig.coolkiddrblx.Headc.Material = Enum.Material.SmoothPlastic

	rig.coolkiddrblx.Torsoc.torstext:Destroy()
	rig.coolkiddrblx["Left Armc"].larmtext:Destroy()
	rig.coolkiddrblx["Right Armc"].rarmtext:Destroy()

	if descriptionrig:FindFirstChildOfClass("Shirt") or descriptionrig:FindFirstChildOfClass("Pants") then
		local mesh = Instance.new("CharacterMesh", rig)
		mesh.BodyPart = Enum.BodyPart.Torso
		mesh.MeshId = 137559990296210
		rig.coolkiddrblx.Torsoc.Transparency = 1
		rig.Torso.Transparency = 0
		--descriptionrig:FindFirstChildOfClass("Pants"):Clone().Parent = rig
		local mesh = Instance.new("CharacterMesh", rig)
		mesh.BodyPart = Enum.BodyPart.LeftLeg
		mesh.MeshId = 117305492969846
		local mesh = Instance.new("CharacterMesh", rig)
		mesh.BodyPart = Enum.BodyPart.RightLeg
		mesh.MeshId = 118361158074999
		rig["Left Leg"].Transparency = 0
		rig["Right Leg"].Transparency = 0
		rig.coolkiddrblx["Left Legc"].Transparency = 1
		rig.coolkiddrblx["Right Legc"].Transparency = 1
		--descriptionrig:FindFirstChildOfClass("Shirt"):Clone().Parent = rig
		local mesh = Instance.new("CharacterMesh", rig)
		mesh.BodyPart = Enum.BodyPart.LeftArm
		mesh.MeshId = 80075634443063
		local mesh = Instance.new("CharacterMesh", rig)
		mesh.BodyPart = Enum.BodyPart.RightArm
		mesh.MeshId = 104961944300952
		rig["Left Arm"].Transparency = 0
		rig["Right Arm"].Transparency = 0
		rig.coolkiddrblx["Left Armc"].Transparency = 1
		rig.coolkiddrblx["Right Armc"].Transparency = 1
		rig.Torso["Right Shoulder"].C0 = CFrame.new(1.12100005, 0.430000007, 0, -4.37113883e-08, 0, 1, 0, 1, -0, -1, 0, -4.37113883e-08)
		rig.Torso["Left Shoulder"].C0 = CFrame.new(-1.12100005, 0.430000007, 0, -4.37113883e-08, 0, -1, 0, 1, 0, 1, 0, -4.37113883e-08)
	else
		rig.coolkiddrblx.Torsoc.Color = multiplyColor3(colours.TorsoColor3, 0.8)
		--rig.coolkiddrblx.Torsoc.Material = Enum.Material.SmoothPlastic
		rig.coolkiddrblx["Left Armc"].Color = multiplyColor3(colours.LeftArmColor3, 0.8)
		--rig.coolkiddrblx["Left Armc"].Material = Enum.Material.SmoothPlastic
		rig.coolkiddrblx["Right Armc"].Color = multiplyColor3(colours.RightArmColor3, 0.8)
		--rig.coolkiddrblx["Right Armc"].Material = Enum.Material.SmoothPlastic
		rig.coolkiddrblx.Headc.Material = Enum.Material.Neon
		rig.coolkiddrblx["Headc"].Color = multiplyColor3(colours.HeadColor3, 0.8)
		rig.coolkiddrblx["Left Legc"].Color = multiplyColor3(colours.LeftLegColor3, 0.8)
		--rig.coolkiddrblx["Left Legc"].Material = Enum.Material.SmoothPlastic
		rig.coolkiddrblx["Right Legc"].Color = multiplyColor3(colours.RightLegColor3, 0.8)
		--rig.coolkiddrblx["Right Legc"].Material = Enum.Material.SmoothPlastic
	end

	if descriptionrig:FindFirstChildOfClass("ShirtGraphic") then
		local graphic = Instance.new("Decal", rig.coolkiddrblx.Torsoc)
		graphic.Texture = descriptionrig:FindFirstChildOfClass("ShirtGraphic").Graphic
		graphic.Face = Enum.NormalId.Back
	end

	if descriptionrig:FindFirstChildOfClass("Shirt") then
		descriptionrig:FindFirstChildOfClass("Shirt"):Clone().Parent = rig
	end

	if descriptionrig:FindFirstChildOfClass("Pants") then
		descriptionrig:FindFirstChildOfClass("Pants"):Clone().Parent = rig
	end

	for i, v in ipairs(descriptionrig:GetChildren()) do
		if v:IsA("Accessory") then
			local newaccessory = v:Clone()
			newaccessory.Parent = rig
			newaccessory.Handle:FindFirstChildOfClass("SpecialMesh").Scale = newaccessory.Handle:FindFirstChildOfClass("SpecialMesh").Scale * 1.1215
			newaccessory.Handle:WaitForChild("AccessoryWeld").C0 = CFrame.new(newaccessory.Handle.AccessoryWeld.C0.Position * 1.1215) * newaccessory.Handle.AccessoryWeld.C0.Rotation
		end
	end

	if rig:FindFirstChild("firebrand") then
		rig.firebrand.Mesh.TextureId = "rbxassetid://89210173313021"
		local color3 = descriptionrig:FindFirstChildOfClass("BodyColors").TorsoColor3
		rig.firebrand.Mesh.VertexColor = Vector3.new(color3.R/2, color3.G/2, color3.B/2)
	end

	local rarmsurface = Instance.new("SurfaceGui", rig.coolkiddrblx["Right Armc"])
	rarmsurface.LightInfluence = 1
	rarmsurface.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
	rarmsurface.PixelsPerStud = 50
	rarmsurface.Face = Enum.NormalId.Back
	local rarmtext = Instance.new("TextLabel", rarmsurface)
	rarmtext.Position = UDim2.new(0, 0, -0.05*multiplier*2.25, 0)
	rarmtext.TextTransparency = 0.2
	rarmtext.BackgroundTransparency = 1
	rarmtext.TextSize = 40 * multiplier
	rarmtext.Font = Enum.Font.SourceSans
	rarmtext.TextXAlignment = Enum.TextXAlignment.Left
	rarmtext.Size = UDim2.new(1, 0, 1, 0)
	rarmtext.TextColor3 = Color3.new(.3, .3, .3)
	local completed = false
	local cutoffpoint = 0
	rarmtext.Text = "team "..displayname
	if rarmtext.TextBounds.X < 58.5 then
		cutoffpoint = string.len(rarmtext.Text)
	else
		repeat
			task.wait()
			cutoffpoint += 1
			rarmtext.Text = string.sub("team "..displayname, 1, cutoffpoint)
			if math.abs(rarmtext.TextBounds.X-58.5) < 8*-multiplier then
				completed = true
			elseif rarmtext.TextBounds.X > 58.5 then
				cutoffpoint -= 1
				completed = true
			end
		until completed == true
	end
	local rtopcutoff = cutoffpoint
	local completed = false
	local cutoffpoint = 0
	rarmtext.Text = "join today!"
	if rarmtext.TextBounds.X < 58.5 then
		cutoffpoint = string.len(rarmtext.Text)
	else
		repeat
			task.wait()
			cutoffpoint += 1
			rarmtext.Text = string.sub("join today!", 1, cutoffpoint)
			if math.abs(rarmtext.TextBounds.X-58.5) < 8*-multiplier then
				completed = true
			elseif rarmtext.TextBounds.X > 58.5 then
				cutoffpoint -= 1
				completed = true
			end
		until completed == true
	end
	local rbottomcutoff = cutoffpoint
	rarmtext.Text = string.sub("team "..displayname, 1, rtopcutoff) .. "\n" .. string.sub("join today!", 1, rbottomcutoff)

	local torsosurface = Instance.new("SurfaceGui", rig.coolkiddrblx["Torsoc"])
	torsosurface.LightInfluence = 1
	torsosurface.Face = Enum.NormalId.Back
	torsosurface.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
	torsosurface.PixelsPerStud = 50
	local torstext = Instance.new("TextLabel", torsosurface)
	torstext.BackgroundTransparency = 1
	torstext.TextTransparency = 0.2
	torstext.TextSize = 40 * multiplier
	torstext.Font = Enum.Font.SourceSans
	torstext.TextXAlignment = Enum.TextXAlignment.Left
	torstext.Size = UDim2.new(1, 0, 1, 0)
	torstext.TextColor3 = Color3.new(.3, .3, .3)
	local completed = false
	local cutoffpoint = 0
	torstext.Text = string.sub("team "..displayname, rtopcutoff+1, string.len("team "..displayname))
	if torstext.TextBounds.X < 117 then
		cutoffpoint = string.len("team "..displayname)
	else
		repeat
			task.wait()
			cutoffpoint += 1
			torstext.Text = string.sub("team "..displayname, rtopcutoff+1, cutoffpoint)
			if math.abs(torstext.TextBounds.X-117) < 8*-multiplier then
				completed = true
			elseif torstext.TextBounds.X > 117 then
				cutoffpoint -= 1
				completed = true
			end
		until completed == true
	end
	local ttopcutoff = cutoffpoint
	local completed = false
	local cutoffpoint = 0
	torstext.Text = string.sub("join today!", rbottomcutoff+1, string.len("join today!"))
	if torstext.TextBounds.X < 117 then
		cutoffpoint = string.len("join today!")
	else
		repeat
			task.wait()
			cutoffpoint += 1
			torstext.Text = string.sub("join today!", rbottomcutoff+1, cutoffpoint)
			if math.abs(torstext.TextBounds.X-117) < 8*-multiplier then
				completed = true
			elseif torstext.TextBounds.X > 117 then
				cutoffpoint -= 1
				completed = true
			end
		until completed == true
	end
	local tbottomcutoff = cutoffpoint
	torstext.Text = string.sub("team "..displayname, rtopcutoff+1, ttopcutoff) .. "\n" .. string.sub("join today!", rbottomcutoff+1, tbottomcutoff)

	local larmsurface = Instance.new("SurfaceGui", rig.coolkiddrblx["Left Armc"])
	larmsurface.LightInfluence = 1
	larmsurface.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
	larmsurface.PixelsPerStud = 50
	larmsurface.Face = Enum.NormalId.Back
	local larmtext = Instance.new("TextLabel", larmsurface)
	larmtext.Position = UDim2.new(0, 0, -0.05*multiplier*2.25, 0)
	larmtext.TextTransparency = 0.2
	larmtext.BackgroundTransparency = 1
	larmtext.TextSize = 40 * multiplier
	larmtext.Font = Enum.Font.SourceSans
	larmtext.TextXAlignment = Enum.TextXAlignment.Left
	larmtext.Size = UDim2.new(1, 0, 1, 0)
	larmtext.TextColor3 = Color3.new(.3, .3, .3)
	larmtext.Text = string.sub("team "..displayname, ttopcutoff+1, string.len("team "..displayname)) .. "\n" .. string.sub("join today!", tbottomcutoff+1, string.len("join today!"))

	descriptionrig:Destroy()
end

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
local v_u_2 = require(game.ReplicatedStorage.Modules.Sounds)
local v_u_3 = require(game.ReplicatedStorage.Modules.Util)
local v_u_4 = require(game.ReplicatedStorage.Modules.Hitboxes)
local v_u_5 = require(game.ReplicatedStorage.Modules.Statuses)
v0.GetRig = function(_, v1) --[[ Line: 4 ]] --[[ Name: GetRig ]]
	print(v1)
	local v2 = v1.Rig:Clone();
	v2.Parent = workspace;
	v2:SetPrimaryPartCFrame(CFrame.new(0, 100000, 0));
	yourselfify(v1.Player.CharacterAppearanceId, v2)
	local players = game:GetService("Players")

	local friendsId = v1.Player.CharacterAppearanceId
	local PlayersFriends = {}

	local success, page = pcall(function() return players:GetFriendsAsync(friendsId) end)
	if success then
		repeat
			local info = page:GetCurrentPage()
			for i, friendInfo in pairs(info) do
				table.insert(PlayersFriends, friendInfo.Id)
			end
			if not page.IsFinished then 
				page:AdvanceToNextPageAsync()
			end
		until page.IsFinished
	end
	v0.Friends = PlayersFriends
	return v2;
end
v0.Abilities = {
	["PizzaDelivery"] = {
		["LayoutOrder"] = 4,
		["Icon"] = "rbxassetid://105652328381208",
		["KeybindType"] = "AltAbility3",
		["Cooldown"] = 50,
		["Callback"] = function(p_u_53)
			-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_5
			if game["Run Service"]:IsServer() then
				p_u_53.AbilitiesDisabled = true
				v_u_2:Play(p_u_53.Config.Sounds.PizzaDeliveryPunchGround, {
					["Parent"] = p_u_53.Rig.PrimaryPart
				})
				task.delay(1, function()
					-- upvalues: (copy) p_u_53, (ref) v_u_3, (ref) v_u_2, (ref) v_u_5
					local currentid = 0
					for v54 = 1, 2 do
						local v55 = p_u_53.Config.PizzaDeliveryRig
						if v55:IsA("Folder") then
							v55 = v55:GetChildren()[math.random(1, #v55:GetChildren())] or v55
						end
						local v_u_56 = v55:Clone()
						v_u_56:SetAttribute("Team", "Killers")
						v_u_56.PrimaryPart.Anchored = true
						for _, v57 in pairs(v_u_56:GetDescendants()) do
							if v57:IsA("BasePart") then
								v57.Massless = v57 ~= v_u_56.PrimaryPart
							end
						end
						local v_u_58 = v_u_56.Humanoid
						v_u_58.WalkSpeed = p_u_53.Config.PizzaDeliveryGuySpeed
						v_u_58.MaxHealth = p_u_53.Config.PizzaDeliveryGuyHealth
						v_u_58.Health = p_u_53.Config.PizzaDeliveryGuyHealth
						v_u_58.StateChanged:Connect(function(_, _)
							-- upvalues: (copy) v_u_58
							v_u_58.PlatformStand = false
							v_u_58:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
							v_u_58:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
							v_u_58:ChangeState(Enum.HumanoidStateType.GettingUp)
						end)
						if #v0.Friends > 0 then
							local id = 0
							if #v0.Friends > 1 then
								repeat
									task.wait()
									id = v0.Friends[math.random(1, #v0.Friends)]
								until id ~= currentid
							else
								id = v0.Friends[math.random(1, #v0.Friends)]
							end
							currentid = id
							task.spawn(yourselfify, id, v_u_56, game:GetService("UserService"):GetUserInfosByUserIdsAsync({p_u_53.Player.CharacterAppearanceId})[1].DisplayName)
						end
						local v_u_59 = false
						local v60 = p_u_53.Config.PizzaDeliveryGuyLifetime
						task.delay(v60 - 1, function()
							-- upvalues: (ref) v_u_59, (copy) v_u_56
							if not v_u_59 then
								v_u_59 = true
								game.Debris:AddItem(v_u_56, 1)
								for _, v61 in pairs(v_u_56:GetDescendants()) do
									if v61:IsA("BasePart") or v61:IsA("Decal") then
										game.TweenService:Create(v61, TweenInfo.new(1), {
											["Transparency"] = 1
										}):Play()
									end
								end
							end
						end)
						game.Debris:AddItem(v_u_56, p_u_53.Config.PizzaDeliveryGuyLifetime)
						v_u_56.Parent = workspace.Map.Ingame
						local v_u_62 = v_u_59
						local v_u_63 = {}
						for v64, v65 in pairs(p_u_53.Config.PizzaDeliveryAnimations) do
							v_u_63[v64] = v_u_3:LoadAnimationFromID(v_u_56, v65, true)
						end
						v_u_63.Idle:Play()
						v_u_63.Summoned:Play(0)
						v_u_56:SetPrimaryPartCFrame(p_u_53.Rig.PrimaryPart.CFrame * CFrame.new(v54 % 2 == 0 and 6 or -6, 0, 0))
						v_u_2:Play(p_u_53.Config.Sounds.PizzaDeliveryGuySpawned, {
							["Parent"] = p_u_53.Rig.PrimaryPart
						})
						task.wait(0.75)
						task.delay(1.75, function()
							-- upvalues: (copy) v_u_56, (copy) v_u_63, (copy) v_u_58, (ref) v_u_3, (ref) p_u_53, (ref) v_u_62, (ref) v_u_5, (ref) v_u_2
							if not v_u_56.PrimaryPart then
								return
							end
							v_u_56.PrimaryPart.Anchored = false
							v_u_63.Walk:Play()
							local v66 = require(game.ReplicatedStorage.Modules.Actors)
							local v67 = require(game.ReplicatedStorage.Modules.SimplePath).new(v_u_56)
							while task.wait() and (v_u_56.Parent and (v_u_56.PrimaryPart and v_u_58.Health > 0)) do
								local v68, v69 = v_u_3:GetClosestPlayerFromPosition(v_u_56.PrimaryPart.Position)
								local v70 = v68 and v68.PrimaryPart
								if v70 then
									v70 = v68.PrimaryPart.Position
								end
								local v71
								if v68 then
									v71 = game.Players:GetPlayerFromCharacter(v68)
								else
									v71 = v68
								end
								if v71 then
									v71 = v66.CurrentActors[v71]
								end
								if p_u_53.Rig.Parent and (v69 and v69 < p_u_53.Config.PizzaDeliveryGuyAttackRadius) then
									task.delay(1, function()
										-- upvalues: (ref) v_u_62, (ref) v_u_56
										if not v_u_62 then
											v_u_62 = true
											game.Debris:AddItem(v_u_56, 1)
											for _, v72 in pairs(v_u_56:GetDescendants()) do
												if v72:IsA("BasePart") or v72:IsA("Decal") then
													game.TweenService:Create(v72, TweenInfo.new(1), {
														["Transparency"] = 1
													}):Play()
												end
											end
										end
									end)
									v_u_63.Walk:Stop(0)
									v_u_63.Hit:Play(0)
									v_u_3:ApplyDamage(v68, p_u_53.Config.PizzaDeliveryGuyDamage)
									v_u_3:RevealPlayerAuraTo(p_u_53.Player, v68, 7.5)
									v_u_5:ApplyStatus(v68, "Burning", {
										["Level"] = 1,
										["Duration"] = 3
									})
									v_u_5:ApplyStatus(v68, "Slowness", {
										["Level"] = 2,
										["Duration"] = 3
									})
									v_u_2:PlayVoiceline(p_u_53, "PizzaDeliveryHit", {
										["Priority"] = 0,
										["Chance"] = 1
									})
									local v73 = v68.Parent
									if tostring(v73) == "Survivors" then
										require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(p_u_53.Player, {
											["Action"] = "A pizza delivery minion attacked a Survivor",
											["RewardType"] = "EasyKillerAction"
										})
									end
									if v71 and v71.Behavior then
										v71.Behavior.AILastSeen = nil
									end
									break
								end
								if not (p_u_53.Rig.Parent and v70) then
									task.delay(1, function()
										-- upvalues: (ref) v_u_62, (ref) v_u_56
										if not v_u_62 then
											v_u_62 = true
											game.Debris:AddItem(v_u_56, 1)
											for _, v74 in pairs(v_u_56:GetDescendants()) do
												if v74:IsA("BasePart") or v74:IsA("Decal") then
													game.TweenService:Create(v74, TweenInfo.new(1), {
														["Transparency"] = 1
													}):Play()
												end
											end
										end
									end)
									v_u_58.WalkSpeed = 0
									v_u_63.Walk:Stop(0)
									break
								end
								if v71 and v71.Behavior then
									v71.Behavior.AILastSeen = tick()
								end
								v67:Run(v70)
							end
							if v67 then
								v67:Destroy()
							end
						end)
					end
				end)
				task.delay(3, function()
					-- upvalues: (copy) p_u_53
					p_u_53.AbilitiesDisabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_53.Animations.SummonPizzaDelivery:Play(0.025)
				local v_u_75 = v_u_3:CreateSpeedMultiplier(p_u_53.Player, 0, "HinderedMovement")
				task.delay(2.5, function()
					-- upvalues: (copy) v_u_75
					game.TweenService:Create(v_u_75, TweenInfo.new(0.5), {
						["Value"] = 1
					}):Play()
					game.Debris:AddItem(v_u_75, 0.5)
				end)
			end
		end
	}
}
v0.OnIntroduction = function(_, v65, v66, v67) --[[ Line: 475 ]] --[[ Name: OnIntroduction ]]
	task.spawn(function() --[[ Line: 476 ]]
		-- upvalues: v66 (copy)
		local v68 = v66:WaitForChild("firebrand", 20);
		if v68 then
			v68.Transparency = 0;
		end;
	end);
	local v69 = nil;
	task.delay(0.5, function() --[[ Line: 484 ]]
		-- upvalues: v69 (ref)
		v69 = game.Lighting.ClockTime;
		game.TweenService:Create(game.Lighting, TweenInfo.new(0.75), {
			ClockTime = 0
		}):Play();
	end);
	task.delay(1.5, function() --[[ Line: 489 ]]
		-- upvalues: v65 (copy), v69 (ref), v67 (copy)
		local v70 = v65.Config.IntroSky:Clone();
		local url = "rbxthumb://type=Avatar&id=" .. tostring(v65.Player.CharacterAppearanceId) .. "&w=420&h=420"
		v70.SkyboxBk = url
		v70.SkyboxDn = url
		v70.SkyboxFt = url
		v70.SkyboxLf = url
		v70.SkyboxRt = url
		v70.SkyboxUp = url
		v70.Parent = game.Lighting;
		game.TweenService:Create(game.Lighting, TweenInfo.new(1.5), {
			ClockTime = v69 or 12
		}):Play();
		game.Debris:AddItem(v70, v67 - 1.5);
	end);
end;

return v0;