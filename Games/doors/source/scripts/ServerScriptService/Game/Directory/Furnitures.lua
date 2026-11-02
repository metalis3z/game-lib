local module = {}

-- Created and Fixed by BUILDG Studios

local module_Debris = require(script.Parent["GameDetails"])
local module_itempickup = require(script.Parent.ItemPickup)
local module_itemsControls = require(script.Parent.Parent.Controls.Items)

function audioPlay(p1, p2, p3, p4, p5, p6, p7)
	local Sound = Instance.new("Sound")
	Sound.SoundId = p1
	Sound.Parent = p2

	Sound.MinDistance = p5
	Sound.MaxDistance = p6
	Sound.Volume = p4

	Sound.PlaybackSpeed = p7

	Sound.TimePosition = p3

	task.wait()

	Sound:Play()

	Sound.Ended:Connect(function()
		Sound:Destroy()
	end)
end

function module:DresserDebrisLoot(v)
	local function LootDebrisSpawn()
		
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
		
		local spawnpoints = v.SpawnersDebris
		local randompoint = spawnpoints[math.random(1, #spawnpoints:GetChildren())]
		local randomNumber = math.random(-180, 180)
		local randomDebrisSpawn = math.random(1, 25)
		local randomSpawnKey = math.random(1, 6)
		local randomXYZ = math.random(-90, 90)
		
		--if randomSpawnKey < 3 then
		--end
		
		if randomDebrisSpawn < 4 then
			local loot4 = game.ServerScriptService.Server.Assets.Items.Debris.Paper:Clone()
			loot4.Name = "Paper"
			loot4.Parent = v
			loot4.Anchored = true
			if randompoint:FindFirstChild("ValueVault").Value == false then
				randompoint:FindFirstChild("ValueVault").Value = true
				loot4:PivotTo(randompoint.CFrame)
			else
				return
			end
			loot4:PivotTo(randompoint.CFrame)
			loot4.Orientation = Vector3.new(0,randomNumber,0)
		elseif randomDebrisSpawn < 8 then
			local loot4 = game.ServerScriptService.Server.Assets.Items.Debris.Container:Clone()
			loot4.Name = "Container"
			loot4.Parent = v
			loot4.Anchored = true

			if randompoint:FindFirstChild("ValueVault").Value == false then
				randompoint:FindFirstChild("ValueVault").Value = true
				loot4:PivotTo(randompoint.CFrame)
			else
				return
			end
			loot4.Orientation = Vector3.new(0,randomNumber,0)
		elseif randomDebrisSpawn < 12 then
			local loot4 = game.ServerScriptService.Server.Assets.Items.Debris.Letter:Clone()
			loot4.Name = "Letter"
			loot4.Parent = v
			loot4.Anchored = true

			if randompoint:FindFirstChild("ValueVault").Value == false then
				randompoint:FindFirstChild("ValueVault").Value = true
				loot4:PivotTo(randompoint.CFrame)
			else
				return
			end
			loot4.Orientation = Vector3.new(0,randomNumber,0)
		elseif randomDebrisSpawn < 14 then
			local loot4 = game.ServerScriptService.Server.Assets.Items.Debris.Pencil:Clone()
			loot4.Name = "Pencil"
			loot4.Parent = v
			loot4.Anchored = true

			if randompoint:FindFirstChild("ValueVault").Value == false then
				randompoint:FindFirstChild("ValueVault").Value = true
				loot4:PivotTo(randompoint.CFrame)
			else
				return
			end
			loot4.Orientation = Vector3.new(0,randomNumber,0)
		end
	end
	
	local d = math.random(2, 7)

	for i = 1, d do
		LootDebrisSpawn()
	end
end

function module:DresserLoot(v)
	if v.Knobs:FindFirstChildOfClass("ProximityPrompt") then
		v.Knobs:FindFirstChildOfClass("ProximityPrompt"):Destroy()
	end
	if not v:GetAttribute("Opened") then
		v:SetAttribute("Opened", false)
	end

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

	local spawned = false

	local function lootspawn()
		v.Value.Value += 1
		local spawnpoints = v.Spawners
		
		for Room=1, #spawnpoints:GetChildren() do
			local value = script.takenValue:Clone()
			
			value.Parent = spawnpoints[Room]
		end
		
		local randompoint = spawnpoints[math.random(1, #spawnpoints:GetChildren())]
		local randomXYZ = math.random(-90, 90)
		local randomNumber = math.random(-180, 180)
		local randomKeyspawn = math.random(1, 4)
		local chance = math.random(1, 100)
		local addPainting = math.random(1, 26) 
		v:SetAttribute("LootChance", chance)
		
		local d = math.random(1, 3)

		for i = 1, d do
			local randompointDebris = spawnpoints[math.random(1, #spawnpoints:GetChildren())]
			
			local randomNumberDebris = math.random(-180, 180)
			local randomDebrisSpawn = math.random(1, 20)
			
			if randomDebrisSpawn < 4 then
				if randompointDebris.takenValue.Value == false then
					randompointDebris.takenValue.Value = true
					local loot = game.ServerScriptService.Server.Assets.Items.Debris.Letter:Clone()
					loot.Name = "Letter"
					loot.Parent = v.Parent

					loot:PivotTo(randompointDebris.CFrame)
					loot.WeldConstraint.Part1 = v.Main
					loot.Orientation = Vector3.new(0,randomNumberDebris,0)
					loot.Position = loot.Position - Vector3.new(0, 0.1, 0)
				else
					return
				end
			elseif randomDebrisSpawn < 8 then
				if randompointDebris.takenValue.Value == false then
					randompointDebris.takenValue.Value = true
					local loot = game.ServerScriptService.Server.Assets.Items.Debris.Container:Clone()
					loot.Name = "Container"
					loot.Parent = v.Parent

					loot:PivotTo(randompointDebris.CFrame)
					loot.WeldConstraint.Part1 = v.Main
					loot.Orientation = Vector3.new(0,randomNumberDebris,0)
					loot.Position = loot.Position - Vector3.new(0, 0.1, 0)
				else
					return
				end
			elseif randomDebrisSpawn < 12 then
				if randompointDebris.takenValue.Value == false then
					randompointDebris.takenValue.Value = true
					local loot = game.ServerScriptService.Server.Assets.Items.Debris.Pencil:Clone()
					loot.Name = "Pencil"
					loot.Parent = v.Parent

					loot:PivotTo(randompointDebris.CFrame)
					loot.WeldConstraint.Part1 = v.Main
					loot.Orientation = Vector3.new(0,randomNumberDebris,0)
					loot.Position = loot.Position - Vector3.new(0, 0.1, 0)
				else
					return
				end
			elseif randomDebrisSpawn < 18 then
				if randompointDebris.takenValue.Value == false then
					randompointDebris.takenValue.Value = true
					local loot = game.ServerScriptService.Server.Assets.Items.Debris.Paper:Clone()
					loot.Name = "Paper"
					loot.Parent = v.Parent

					loot:PivotTo(randompointDebris.CFrame)
					loot.WeldConstraint.Part1 = v.Main
					loot.Orientation = Vector3.new(0,randomNumberDebris,0)
					loot.Position = loot.Position - Vector3.new(0, 0.1, 0)
				else
					return
				end
			end
		end
		
		if game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1).Assets:FindFirstChild("KeyObtain") then
			if game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1):GetAttribute("KeySpawned") == false then
				if randomKeyspawn < 3 then
					game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1):SetAttribute("KeySpawned", true)
					if game.Workspace.CurrentRooms.CurrentRoom.Value > 1 then
						wait(0.1)
						local loot = game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1).Assets:FindFirstChild("KeyObtain")

						if loot then

							loot.Hitbox.Anchored = false

							loot.Name = "KeyObtain"
							--loot.Parent = v.Parent

							loot:PivotTo(spawnpoints:FindFirstChild("3").CFrame)

							local weld = Instance.new("WeldConstraint", loot)

							loot.WeldConstraint.Part0 = loot.Hitbox
							loot.WeldConstraint.Part1 = v.Main

							rotateMod(loot,loot:GetModelCFrame(),CFrame.Angles(0,math.rad(randomXYZ),0))
						end
					end
				end
			end
		else
			if addPainting < 6 then
				if randompoint.takenValue.Value == false then
					randompoint.takenValue.Value = true
					local loot = game.ServerScriptService.Server.Assets.Loots.Tiny:Clone()
					loot.Name = "GoldPile"
					loot.Parent = v.Parent

					local Value = Instance.new("StringValue")
					Value.Parent = v
					Value.Value = "Gold"
					Value.Name = "LootName"

					local Value1 = Instance.new("ObjectValue")
					Value1.Parent = v
					Value1.Value = loot
					Value1.Name = "GoldObject"

					loot:PivotTo(randompoint.CFrame)
					loot.WeldConstraint.Part1 = v.Main
					rotateMod(loot,loot:GetModelCFrame(),CFrame.Angles(0,math.rad(randomXYZ),0))

					module_Debris:GoldModule(loot.LootPrompt)
				else
					return
				end
			elseif addPainting < 10 then
				if randompoint.takenValue.Value == false then
					randompoint.takenValue.Value = true
					
					local loot1 = game.ServerScriptService.Server.Assets.Loots.Small:Clone()
					loot1.Name = "GoldPile"
					loot1.Parent = v.Parent

					local Value = Instance.new("StringValue")
					Value.Parent = v
					Value.Value = "Gold"
					Value.Name = "LootName"

					local Value1 = Instance.new("ObjectValue")
					Value1.Parent = v
					Value1.Value = loot1
					Value1.Name = "GoldObject"

					loot1:PivotTo(randompoint.CFrame)
					loot1.WeldConstraint.Part1 = v.Main
					rotateMod(loot1,loot1:GetModelCFrame(),CFrame.Angles(0,math.rad(randomXYZ),0))	

					module_Debris:GoldModule(loot1.LootPrompt)
				else
					return
				end
			elseif addPainting == 6 then
				if randompoint.takenValue.Value == false then
					randompoint.takenValue.Value = true
					
					local loot2 = game.ServerScriptService.Server.Assets.Loots.Okay:Clone()
					loot2.Name = "GoldPile"
					loot2.Parent = v.Parent

					local Value = Instance.new("StringValue")
					Value.Parent = v
					Value.Value = "Gold"
					Value.Name = "LootName"

					local Value1 = Instance.new("ObjectValue")
					Value1.Parent = v
					Value1.Value = loot2
					Value1.Name = "GoldObject"

					loot2:PivotTo(randompoint.CFrame)
					loot2.WeldConstraint.Part1 = v.Main
					rotateMod(loot2,loot2:GetModelCFrame(),CFrame.Angles(0,math.rad(randomXYZ),0))

					module_Debris:GoldModule(loot2.LootPrompt)
				else
					return
				end
			elseif addPainting == 8 then
				if randompoint.takenValue.Value == false then
					randompoint.takenValue.Value = true
					
					local loot3 = game.ServerScriptService.Server.Assets.Loots.Good:Clone()
					loot3.Name = "GoldPile"
					loot3.Parent = v.Parent

					local Value = Instance.new("StringValue")
					Value.Parent = v
					Value.Value = "Gold"
					Value.Name = "LootName"

					local Value1 = Instance.new("ObjectValue")
					Value1.Parent = v
					Value1.Value = loot3
					Value1.Name = "GoldObject"

					loot3:PivotTo(randompoint.CFrame)
					loot3.WeldConstraint.Part1 = v.Main
					rotateMod(loot3,loot3:GetModelCFrame(),CFrame.Angles(0,math.rad(randomXYZ),0))

					module_Debris:GoldModule(loot3.LootPrompt)
				else
					return
				end
			elseif addPainting == 10 then
				if randompoint.takenValue.Value == false then
					randompoint.takenValue.Value = true
					
					local loot4 = game.ServerScriptService.Server.Assets.Loots.Best:Clone()
					loot4.Name = "GoldPile"
					loot4.Parent = v.Parent

					local Value = Instance.new("StringValue")
					Value.Parent = v
					Value.Value = "Gold"
					Value.Name = "LootName"

					local Value1 = Instance.new("ObjectValue")
					Value1.Parent = v
					Value1.Value = loot4
					Value1.Name = "GoldObject"

					loot4:PivotTo(randompoint.CFrame)
					loot4.WeldConstraint.Part1 = v.Main
					rotateMod(loot4,loot4:GetModelCFrame(),CFrame.Angles(0,math.rad(randomXYZ),0))

					module_Debris:GoldModule(loot4.LootPrompt)
				else
					return
				end
			elseif addPainting == 18 then
				if randompoint.takenValue.Value == false then
					randompoint.takenValue.Value = true

					local loot4 = game.ServerScriptService.Server.Assets.Items.Handles.LighterHandle:Clone()
					loot4.Name = "LighterHandle"
					loot4.Parent = v.Parent

					local Value = Instance.new("StringValue")
					Value.Parent = v
					Value.Value = "Item"
					Value.Name = "LootName"

					local Value1 = Instance.new("ObjectValue")
					Value1.Parent = v
					Value1.Value = loot4
					Value1.Name = "GoldObject"

					module_itemsControls:LighterSwap(loot4)
					loot4:PivotTo(randompoint.CFrame)
					loot4.WeldConstraint.Part1 = v.Main
					rotateMod(loot4,loot4:GetModelCFrame(),CFrame.Angles(0,math.rad(randomXYZ),0))
				else
					return
				end
			elseif addPainting == 20 then
				if randompoint.takenValue.Value == false then
					randompoint.takenValue.Value = true

					local loot4 = game.ServerScriptService.Server.Assets.Items.Handles.VitaminsHandle:Clone()
					loot4.Name = "Vitamins"
					loot4.Parent = v.Parent

					local Value = Instance.new("StringValue")
					Value.Parent = v
					Value.Value = "Item"
					Value.Name = "LootName"

					local Value1 = Instance.new("ObjectValue")
					Value1.Parent = v
					Value1.Value = loot4
					Value1.Name = "GoldObject"

					module_itempickup:DurabilityAdd(loot4, "Vitamins")
					loot4:PivotTo(randompoint.CFrame)
					loot4.WeldConstraint.Part1 = v.Main
					rotateMod(loot4,loot4:GetModelCFrame(),CFrame.Angles(0,math.rad(randomXYZ),0))
				else
					return
				end
			elseif addPainting == 22 then
				if randompoint.takenValue.Value == false then
					randompoint.takenValue.Value = true

					local loot4 = game.ServerScriptService.Server.Assets.Items.Handles.BandageHandle:Clone()
					loot4.Name = "Bandage"
					loot4.Parent = v.Parent

					local Value = Instance.new("StringValue")
					Value.Parent = v
					Value.Value = "Item"
					Value.Name = "LootName"

					local Value1 = Instance.new("ObjectValue")
					Value1.Parent = v
					Value1.Value = loot4
					Value1.Name = "GoldObject"

					module_itempickup.HealItem(loot4)
					loot4:PivotTo(randompoint.CFrame)
					loot4.WeldConstraint.Part1 = v.Main
					rotateMod(loot4,loot4:GetModelCFrame(),CFrame.Angles(0,math.rad(randomXYZ),0))
				else
					return
				end
			elseif addPainting == 24 or addPainting == 25 or addPainting == 26 then
				if randompoint.takenValue.Value == false then
					randompoint.takenValue.Value = true

					local loot4 = game.ServerScriptService.Server.Assets.Items.Handles.BatteryHandle:Clone()
					loot4.Name = "Battery"
					loot4.Parent = v.Parent

					local Value = Instance.new("StringValue")
					Value.Parent = v
					Value.Value = "Item"
					Value.Name = "LootName"

					local Value1 = Instance.new("ObjectValue")
					Value1.Parent = v
					Value1.Value = loot4
					Value1.Name = "GoldObject"
					
					
					module_itemsControls:BatteryAdd(loot4)
					loot4:PivotTo(randompoint.CFrame)
					loot4.WeldConstraint.Part1 = v.Main
					rotateMod(loot4,loot4:GetModelCFrame(),CFrame.Angles(0,math.rad(randomXYZ),0))
				else
					return
				end
			end
		end
		return
	end

	local newprompt = Instance.new("ProximityPrompt")
	newprompt.Style = Enum.ProximityPromptStyle.Custom
	newprompt.Name = "ActivateEventPrompt"
	newprompt.ActionText = "Loot"
	newprompt.ObjectText = "Drawer"
	newprompt.MaxActivationDistance = 8
	newprompt.Parent = v.Knobs

	lootspawn()

	local review = false

	newprompt.Triggered:Connect(function(player)
		local Spider = math.random(1, 41)
		local SpiderJumpscare = math.random(1, 41)
		
		if v:GetAttribute("Opened") ~= true then
			newprompt.Enabled = false
			v.Constraint.TargetPosition = 5
			v.Constraint.Restitution = 0
			v.Constraint.ServoMaxForce = 75
			v.Main.Open:Play()
			task.delay(1.7, function()
				newprompt.Enabled = true
			end)
			newprompt.ActionText = "Looted"
			v:SetAttribute("Opened", true)
			if review == false then
				review = true
				if Spider == SpiderJumpscare then
					game.ReplicatedStorage.Bricks.SpiderJumpscare:FireClient(player, v, 0.1)
				end
			end
			local Randomizer = math.random(20, 60)
			if v:FindFirstChild("LootName") then
				if v.LootName.Value == "Gold" then
					v.LootName.Value = "None"
					audioPlay("rbxassetid://4612376346", v, 0, 0.55, 1, 15, 1.1)
					if v:FindFirstChild("GoldObject") then
						local goldmodel = v.GoldObject.Value
						goldmodel.Hitbox.Attachment.ParticleEmitter:Emit(Randomizer)
					end
				elseif v.LootName.Value == "Item" then
					v.LootName.Value = "None"
					audioPlay("rbxassetid://6102638180", v, 0, 0.45, 1, 15, 1.05)
				end
			end
		else
			v.Constraint.TargetPosition = 0
			v.Main.Close:Play()
			v:SetAttribute("Opened", false)
		end
	end)

end

return module
