local module = {}

-- Created and Fixed by BUILDG Studios

local RunSrevice = game:GetService('RunService')

function module:GuidePart_RoomEnd(room)
	local partguide = Instance.new("Part")
	partguide.Transparency = 1
	partguide.CanCollide = false
	partguide.Anchored = true
	--partguide.Name = "Guide"..room.Name

	partguide.Size = Vector3.new(4, 6, 4)

	local effect = game.ServerScriptService.Server.Assets.Effects
	local effect1 = effect.Guide.HelpParticle:Clone()
	local effect2 = effect.Guide.HelpLight:Clone()

	effect1.Parent = partguide
	effect2.Parent = partguide
	effect1.Enabled = true
	effect2.Enabled = true
	
	effect2.Range = 12
	
	partguide.Parent = room
	partguide:PivotTo(room:FindFirstChild("RoomEnd").CFrame)
end

function module:GuidePart_KeyObtain(room, times)
	local partguide = Instance.new("Part")
	partguide.Transparency = 1
	partguide.CanCollide = false
	partguide.Anchored = true
	--partguide.Name = "Guide"..room.Name
	task.delay(times, function()
		partguide.Size = Vector3.new(4, 6, 4)

		local effect = game.ServerScriptService.Server.Assets.Effects
		local effect1 = effect.Guide.HelpParticle:Clone()
		local effect2 = effect.Guide.HelpLight:Clone()

		effect1.Parent = partguide
		effect2.Parent = partguide
		effect1.Enabled = true
		effect2.Enabled = true

		effect2.Range = 12

		partguide.Parent = room
		if room then
			if room:FindFirstChild("Assets") then
				if room.Assets:FindFirstChild("KeyObtain") then
					partguide:PivotTo(room.Assets:FindFirstChild("KeyObtain").Hitbox.CFrame)
				end
			end
		end
	end)
end

function module:GoldModule(v)
	local clicked = false

	v.Triggered:Connect(function(player)
		if clicked == false then
			clicked = true
			
			if not v.Parent:FindFirstChild("Hitbox") then
				return
			end
			game.ReplicatedStorage.ClientBricks.GoldAnimation:FireClient(player, "Basic", v.Parent.Hitbox, v.Parent:GetAttribute("GoldValue"))
			--game.ReplicatedStorage.EntityInfo.GetGold:FireClient(player, v.Parent.Hitbox.Position, v.Parent:GetAttribute("GoldValue"))
			v.Parent.Hitbox:Destroy()
			v.Enabled = false
			v.Parent:Destroy()
		end
	end)
end

function module:spawneyes(part, level, times)
	local UsedVariant1 = false
	local UsedVariant2 = false
	local UsedVariant3 = false
	local UsedVariant4 = false
	local UsedVariant5 = false
	local UsedVariant6 = false
	local UsedVariant7 = false
	
	local eye = game.ReplicatedStorage.Misc.Eyes

	local function rotateMod(mod,center,rotation)
		local parts ={}
		local function scan(parent)
			for _,obj in pairs(parent:GetChildren()) do
				if (obj:IsA("BasePart")) then
					table.insert(parts,obj)
				end
				scan(obj)
			end
		end
		scan(mod)
		for _,part in pairs(parts) do
			part.CFrame = (center*rotation*(center:inverse()*part.CFrame))
		end
	end
	
	for i = 1, times do
		wait(0.1)
		local random = eye:GetChildren()[math.random(1, #eye:GetChildren())]
		local step

		if level == 1 then
			step = math.random(1, 6)
		elseif level == 2 then
			step = math.random(1, 10)
		elseif level == 3 then
			step = math.random(1, 14)
		elseif level == 4 then
			step = math.random(1, 18)
		end
		local random2 = math.random(1, 7)

		local step2 = math.random(5, 45)

		local stepX = math.random(1, 25)
		local stepZ = math.random(1, 3)
		local cloned = random:Clone()
		cloned.Part.Splat:Play()
		cloned.Parent = part
		if random2 == 1 then
			if UsedVariant1 == false then
				UsedVariant1 = true
				cloned:PivotTo(part.CFrame * CFrame.new(step, -stepZ, 0))
				rotateMod(cloned,cloned:GetModelCFrame(),CFrame.Angles(0,0,math.rad(step2)))
			else
				return
			end
		elseif random2 == 2 then
			if UsedVariant2 == false then
				UsedVariant2 = true
				cloned:PivotTo(part.CFrame * CFrame.new(-step, stepZ, 0))
				rotateMod(cloned,cloned:GetModelCFrame(),CFrame.Angles(0,0,math.rad(-step2)))
			else
				return
			end
		elseif random2 == 3 then
			if UsedVariant3 == false then
				UsedVariant3 = true
				cloned:PivotTo(part.CFrame * CFrame.new(step, stepZ, 0))
				rotateMod(cloned,cloned:GetModelCFrame(),CFrame.Angles(0,0,math.rad(step2)))
			else
				return
			end
		elseif random2 == 4 then
			if UsedVariant4 == false then
				UsedVariant4 = true
				cloned:PivotTo(part.CFrame * CFrame.new(step, -stepZ, 0))
				rotateMod(cloned,cloned:GetModelCFrame(),CFrame.Angles(0,0,math.rad(-step2)))
			else
				return
			end
		elseif random2 == 5 then
			if UsedVariant5 == false then
				UsedVariant5 = true
				cloned:PivotTo(part.CFrame * CFrame.new(-step, stepZ, 0))
				rotateMod(cloned,cloned:GetModelCFrame(),CFrame.Angles(0,0,math.rad(step2)))
			else
				return
			end
		elseif random2 == 6 then
			if UsedVariant6 == false then
				UsedVariant6 = true
				cloned:PivotTo(part.CFrame * CFrame.new(step, stepZ, 0))
				rotateMod(cloned,cloned:GetModelCFrame(),CFrame.Angles(0,0,math.rad(-step2)))
			else
				return
			end
		elseif random2 == 7 then
			if UsedVariant7 == false then
				UsedVariant7 = true
				cloned:PivotTo(part.CFrame * CFrame.new(-step, -stepZ, 0))
				rotateMod(cloned,cloned:GetModelCFrame(),CFrame.Angles(0,0,math.rad(step2)))
			else
				return
			end
		end
	end
end

function module:SoundSet(pos, parent, hint)
	local part = Instance.new("Part")
	part.Size = Vector3.new(4, 4, 4)
	part.Transparency = 1
	part.Anchored = true
	part.CanCollide = false
	
	if hint == true then
		local pld = script.PlaySound:Clone()
		pld.Parent = part
		pld:Play()
	end
	
	part:PivotTo(pos.CFrame)
	part.Parent = parent
end

function module:ElevatorTeleport(v)
	v.Touched:Connect(function(hit)
		local plr = game.Players:GetPlayerFromCharacter(hit.Parent)
		game.ReplicatedStorage.ClientBricks.Entities.VoidActive:FireClient(plr, v.CFrame * CFrame.new(0, 3, -15))
		v.CanTouch = false
		wait(3)
		v.CanTouch = true
	end)
end

function module:VoidTeleport(v)
	game.ReplicatedStorage.ClientBricks.Entities.VoidActive:FireClient(game.Players.LocalPlayer, v.CFrame * CFrame.new(0, 3, -15))
end

function module:DarkAttributeOLD(room)
	
	if room:FindFirstChild("RoomStart") then
		room:FindFirstChild("RoomStart").CanTouch = true
		room:FindFirstChild("RoomStart").Touched:Connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") then
				print("Character collision: true")
				game.Players:GetPlayerFromCharacter(hit.Parent).Character:SetAttribute("InDark", true)
			else
				return warn("Non character collision")
			end
		end)
	end
	
	if room:FindFirstChild("RoomEnd") then
		room:FindFirstChild("RoomEnd").CanTouch = true
		room:FindFirstChild("RoomEnd").Touched:Connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") then
				print("Character collision: false")
				game.Players:GetPlayerFromCharacter(hit.Parent).Character:SetAttribute("InDark", false)
			else
				return warn("Non character collision")
			end
		end)
	end
end

function module:BasicAttribute(room)
	
	if room:FindFirstChild("CollideRoom") then
		local collide = room:FindFirstChild("CollideRoom")

		game:GetService("RunService").Heartbeat:Connect(function()
			for i, v in pairs(workspace:GetPartsInPart(collide)) do
				if v.Name == "HumanoidRootPart" then
					local Parent = v.Parent
					local PlayerRef = game.Players:GetPlayerFromCharacter(Parent)
					if PlayerRef then
						PlayerRef.Character:SetAttribute("InDark", false)
					end
				end
			end
		end)
	end
	
end

function module:DarkAttribute(room)
	
	if room:FindFirstChild("CollideRoom") then
		local collide = room:FindFirstChild("CollideRoom")

		game:GetService("RunService").Heartbeat:Connect(function()
			for i, v in pairs(workspace:GetPartsInPart(collide)) do
				if v.Name == "HumanoidRootPart" then
					local Parent = v.Parent
					local PlayerRef = game.Players:GetPlayerFromCharacter(Parent)
					if PlayerRef then
						PlayerRef.Character:SetAttribute("InDark", true)
					end
				end
			end
		end)
	end
	
end

return module