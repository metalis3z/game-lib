local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EntityInfoEvents = ReplicatedStorage:WaitForChild("EntityInfo")
local BrickEvents = ReplicatedStorage:WaitForChild("Bricks")
local GameData = ReplicatedStorage:WaitForChild("GameData")
local GameStats = ReplicatedStorage:WaitForChild("GameStats")

-- Created and Fixed by BUILDG Studios

local module_Debris = require(game.ServerScriptService.Game.Directory.GameDetails)
local module_itempickup = require(game.ServerScriptService.Game.Directory.ItemPickup)
local module_itemsControls = require(game.ServerScriptService.Game.Controls.Items)

local LHDresser = script.LootHolders.LootHolder_Dresser
local LHBigDresser = script.LootHolders.LootHolder_BigDresser

local DrawersM = {}

function audioPlay(p1, p2, p3, p4, p5, p6, p7)
	local Sound = Instance.new("Sound")
	Sound.SoundId = p1
	Sound.Parent = p2

	Sound.MinDistance = p5
	Sound.MaxDistance = p6
	Sound.Volume = p4

	Sound.PlaybackSpeed = p7

	Sound.TimePosition = p3

	Sound:Play()

	Sound.Ended:Connect(function()
		Sound:Destroy()
	end)
end

function DrawersM.RandomizePosRot(SpawnPile, mesh)
	local x = SpawnPile.Position.X + math.random() * (SpawnPile.Size.X / 2.2 - (-SpawnPile.Size.X / 2.2)) + -SpawnPile.Size.X / 2.2
	local z = SpawnPile.Position.Z + math.random() * (SpawnPile.Size.Z / 2.2 - (-SpawnPile.Size.Z / 2.2)) + -SpawnPile.Size.Z / 2.2

	mesh.Position = Vector3.new(x, mesh.Position.Y, z)

	local yr = math.random() * (360 - 1) + 1

	mesh.Orientation = Vector3.new(0, -yr, 0)
	return CFrame.new(x, z, yr) + SpawnPile.Position
end


function DrawersM.OpenClose(DrawerContainer, Player)
	local Knobs = DrawerContainer:FindFirstChild("Knobs")
	local Prompt = Knobs:FindFirstChild("ActivateEventPrompt")
	local Main = DrawerContainer:FindFirstChild("Main")

	local OpenS = Main:FindFirstChild("Open")
	local CloseS = Main:FindFirstChild("Close")

	local Constraint = DrawerContainer:FindFirstChild("Constraint")
	
	local Opened = Constraint.TargetPosition ~= 0
	local Closed = Constraint.TargetPosition == 0
	
	if DrawerContainer:GetAttribute("SetupDone") == false then
		DrawersM.Setup(DrawerContainer, Player)
		DrawerContainer:SetAttribute("SetupDone", true)
	end
	
	if Closed then
		Main.CanQuery = false
		Constraint.TargetPosition = 1.4
		Constraint.ServoMaxForce = 175
		Constraint.Restitution = 0
		OpenS:Play()
	elseif Opened then
		Constraint.TargetPosition = 0
		CloseS:Play()
	end
	
	Prompt.Enabled = false

end

function DrawersM.SetDebris(v)
	local coin = false
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
		
		local ChanceGold = math.random(1, 2050)

		if ChanceGold > 65 and ChanceGold < 125 then
			if coin == false then
				coin = true
				local Item = game.ServerScriptService.Server.Assets.Loots.Tiny:Clone()

				if randompoint:FindFirstChild("ValueVault").Value == false then
					randompoint:FindFirstChild("ValueVault").Value = true
					Item:PivotTo(randompoint.CFrame * CFrame.new(0, 0.25, 0))
				else
					return
				end

				Item.PrimaryPart.Anchored = true
				Item.Parent = v
				module_Debris:GoldModule(Item.LootPrompt)
				Item.Hitbox.Attachment.ParticleEmitter:Emit(5)
			end
		elseif ChanceGold > 155 and ChanceGold < 195 then
			if coin == false then
				coin = true
				local Item = game.ServerScriptService.Server.Assets.Loots.Small:Clone()

				if randompoint:FindFirstChild("ValueVault").Value == false then
					randompoint:FindFirstChild("ValueVault").Value = true
					Item:PivotTo(randompoint.CFrame * CFrame.new(0, 0.25, 0))
				else
					return
				end

				Item.PrimaryPart.Anchored = true
				Item.Parent = v
				module_Debris:GoldModule(Item.LootPrompt)
				Item.Hitbox.Attachment.ParticleEmitter:Emit(15)
			end
		elseif ChanceGold > 215 and ChanceGold < 235 then
			if coin == false then
				coin = true
				local Item = game.ServerScriptService.Server.Assets.Loots.Okay:Clone()

				if randompoint:FindFirstChild("ValueVault").Value == false then
					randompoint:FindFirstChild("ValueVault").Value = true
					Item:PivotTo(randompoint.CFrame * CFrame.new(0, 0.25, 0))
				else
					return
				end

				Item.PrimaryPart.Anchored = true
				Item.Parent = v
				module_Debris:GoldModule(Item.LootPrompt)
				Item.Hitbox.Attachment.ParticleEmitter:Emit(20)
			end
		end

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

function DrawersM.Setup(DrawerContainer, Player)
	
	if DrawerContainer:GetAttribute("Key") == true then
		return
	end
	
	local Knobs = DrawerContainer:FindFirstChild("Knobs")
	local Prompt = Knobs:FindFirstChild("ActivateEventPrompt")
	local Main = DrawerContainer:FindFirstChild("Main")

	local Constraint = DrawerContainer:FindFirstChild("Constraint")
	
	local Holder = nil
	if DrawerContainer:FindFirstChild("Holder") and (DrawerContainer:FindFirstChild("End") or Main:FindFirstChild("End")) then
		Holder = DrawerContainer:FindFirstChild("Holder")
	else
		warn("Couldn't find a End/Holder Part. Renaming the DrawerContainer to PROBLEMATIC_DC")
		DrawerContainer.Name = "PROBLEMATIC_DC"
	end
	
	
	local DecorTable = {}
	local DecorType = "Any" -- Any, 2Letters, 2Pencils, 3Pencils, 2Papers, 2Containers, All
	
	local DecorRandom = math.random(1,700)
	
	if DecorRandom < 100 then
		DecorType = "Any"
	elseif DecorRandom >= 100 and DecorRandom < 200 then
		DecorType = "2Letters"
	elseif DecorRandom >= 200 and DecorRandom < 300 then
		DecorType = "2Pencils"
	elseif DecorRandom >= 300 and DecorRandom < 400 then
		DecorType = "3Pencils"
	elseif DecorRandom >= 400 and DecorRandom < 500 then
		DecorType = "2Papers"
	elseif DecorRandom >= 500 and DecorRandom < 600 then
		DecorType = "2Containers"
	elseif DecorRandom >= 600 and DecorRandom <= 700 then
		DecorType = "None"	
	end	
	--print(DecorRandom, DecorType)
		
	if Holder ~= nil then
		local LootHolder
		local SpawnPile
		local Weld = Instance.new("Weld")
				
		LootHolder = LHDresser:Clone()
		SpawnPile = LootHolder.SpawnPile
		
		LootHolder.Parent = DrawerContainer
		Weld.Parent = LootHolder
		Weld.Part0 = LootHolder
		Weld.Part1 = Main
		LootHolder.Position = Vector3.new(Holder.Position.X,Holder.Position.Y,Holder.Position.Z)
		
		for _, mesh in pairs(SpawnPile:GetChildren()) do
			if mesh.Name == "Container" or mesh.Name == "Letter" or mesh.Name == "Pencil" or mesh.Name == "Paper" then
				if DecorType == "Any" then
					local todeleteortonotdelete_thatisthequestion = math.random(1,6)
					if todeleteortonotdelete_thatisthequestion <= 3 then
						mesh:Destroy()
					else
						DrawersM.RandomizePosRot(SpawnPile, mesh)
					end
				elseif DecorType == "2Letters" then
					if mesh.Name == "Letter" then
						local mesh2 = mesh:Clone()
						mesh2.Parent = SpawnPile
						mesh2.ManualWeld.Part0 = mesh2
						DrawersM.RandomizePosRot(SpawnPile, mesh2)
						DrawersM.RandomizePosRot(SpawnPile, mesh)
					else
						mesh:Destroy()
					end
				elseif DecorType == "2Pencils" then
					if mesh.Name == "Pencil" then
						local mesh2 = mesh:Clone()
						mesh2.Parent = SpawnPile
						mesh2.ManualWeld.Part0 = mesh2
						DrawersM.RandomizePosRot(SpawnPile, mesh2)
						DrawersM.RandomizePosRot(SpawnPile, mesh)
					else
						mesh:Destroy()
					end
				elseif DecorType == "3Pencils" then
					if mesh.Name == "Pencil" then
						local mesh2 = mesh:Clone()
						local mesh3 = mesh:Clone()
						mesh2.Parent = SpawnPile
						mesh2.ManualWeld.Part0 = mesh2
						mesh3.Parent = SpawnPile
						mesh3.ManualWeld.Part0 = mesh3
						DrawersM.RandomizePosRot(SpawnPile, mesh2)
						DrawersM.RandomizePosRot(SpawnPile, mesh3)
						DrawersM.RandomizePosRot(SpawnPile, mesh)
					else
						mesh:Destroy()
					end
				elseif DecorType == "2Papers" then
					if mesh.Name == "Paper" then
						local mesh2 = mesh:Clone()
						mesh2.Parent = SpawnPile
						mesh2.ManualWeld.Part0 = mesh2
						DrawersM.RandomizePosRot(SpawnPile, mesh2)
						DrawersM.RandomizePosRot(SpawnPile, mesh)
					else
						mesh:Destroy()
					end
				elseif DecorType == "2Containers" then	
					if mesh.Name == "Container" then
						local mesh2 = mesh:Clone()
						mesh2.Parent = SpawnPile
						mesh2.ManualWeld.Part0 = mesh2
						DrawersM.RandomizePosRot(SpawnPile, mesh2)
						DrawersM.RandomizePosRot(SpawnPile, mesh)
					else
						mesh:Destroy()
					end
				elseif DecorType == "None" then		
					mesh:Destroy()
				end	
			end
			if mesh.Name == "ItemSpawn" then
				
				local LootType = "BasicDrawer"
				
				if Player then
					if Player.Character.Humanoid.Health < 95 then
						LootType = "HealDrawer"
					else
						if Player.Backpack:FindFirstChild("Flashlight") then
							if Player.Backpack:FindFirstChild("Flashlight"):GetAttribute("Durability") < 90 then
								LootType = "ChargeDrawer"
							end
						end

						if Player.Character:FindFirstChild("Flashlight") then
							if Player.Character:FindFirstChild("Flashlight"):GetAttribute("Durability") < 90 then
								LootType = "ChargeDrawer"
							end
						end
					end
				end
				
				local x = SpawnPile.Position.X + math.random()*(SpawnPile.Size.X/4-(-SpawnPile.Size.X/4)) + -SpawnPile.Size.X/4
				local z = SpawnPile.Position.Z + math.random()*(SpawnPile.Size.Z/4-(-SpawnPile.Size.Z/4)) + -SpawnPile.Size.Z/4

				mesh.Position = Vector3.new(x, mesh.Position.Y, z)

				local yr = math.random()*(360-1) + 1

				mesh.Orientation = Vector3.new(0, yr, 0)
				
				local Rand = math.random(1)
				local ChanceItem = math.random(1, 100)
				local ChanceGold = math.random(1, 1050)
				
				if LootType == "BasicDrawer" then
					if ChanceGold > 75 and ChanceGold < 125 then
						local Item = game.ServerScriptService.Server.Assets.Loots.Tiny:Clone()
						local Weld1 = Instance.new("Weld")

						Weld1.Parent = LootHolder
						Weld1.Part0 = mesh
						Weld1.Part1 = Item.PrimaryPart

						Item.PrimaryPart.Anchored = false
						Item.Parent = DrawerContainer
						audioPlay("rbxassetid://4612376346", DrawerContainer, 0, 0.55, 1, 15, 1.1)
						module_Debris:GoldModule(Item.LootPrompt)
						Item.Hitbox.Attachment.ParticleEmitter:Emit(5)
					elseif ChanceGold > 155 and ChanceGold < 225 then
						local Item = game.ServerScriptService.Server.Assets.Loots.Small:Clone()
						local Weld1 = Instance.new("Weld")

						Weld1.Parent = LootHolder
						Weld1.Part0 = mesh
						Weld1.Part1 = Item.PrimaryPart

						Item.PrimaryPart.Anchored = false
						Item.Parent = DrawerContainer
						audioPlay("rbxassetid://4612376346", DrawerContainer, 0, 0.55, 1, 15, 1.1)
						module_Debris:GoldModule(Item.LootPrompt)
						Item.Hitbox.Attachment.ParticleEmitter:Emit(15)
					elseif ChanceGold > 235 and ChanceGold < 255 then
						local Item = game.ServerScriptService.Server.Assets.Loots.Okay:Clone()
						local Weld1 = Instance.new("Weld")

						Weld1.Parent = LootHolder
						Weld1.Part0 = mesh
						Weld1.Part1 = Item.PrimaryPart

						Item.PrimaryPart.Anchored = false
						Item.Parent = DrawerContainer
						audioPlay("rbxassetid://4612376346", DrawerContainer, 0, 0.55, 1, 15, 1.1)
						module_Debris:GoldModule(Item.LootPrompt)
						Item.Hitbox.Attachment.ParticleEmitter:Emit(20)
					elseif ChanceGold > 265 and ChanceGold < 295 then
						local Item = game.ServerScriptService.Server.Assets.Loots.Good:Clone()
						local Weld1 = Instance.new("Weld")

						Weld1.Parent = LootHolder
						Weld1.Part0 = mesh
						Weld1.Part1 = Item.PrimaryPart

						Item.PrimaryPart.Anchored = false
						Item.Parent = DrawerContainer
						audioPlay("rbxassetid://4612376346", DrawerContainer, 0, 0.55, 1, 15, 1.1)
						module_Debris:GoldModule(Item.LootPrompt)
						Item.Hitbox.Attachment.ParticleEmitter:Emit(25)
					elseif ChanceGold > 295 and ChanceGold < 310 then
						local Item = game.ServerScriptService.Server.Assets.Loots.Best:Clone()
						local Weld1 = Instance.new("Weld")

						Weld1.Parent = LootHolder
						Weld1.Part0 = mesh
						Weld1.Part1 = Item.PrimaryPart

						Item.PrimaryPart.Anchored = false
						Item.Parent = DrawerContainer
						audioPlay("rbxassetid://4612376346", DrawerContainer, 0, 0.55, 1, 15, 1.1)
						module_Debris:GoldModule(Item.LootPrompt)
						Item.Hitbox.Attachment.ParticleEmitter:Emit(30)
					else
						if ChanceItem > 15 and ChanceItem < 20 then
							local Item = game.ServerScriptService.Server.Assets.Items.Handles.LighterHandle:Clone()
							local Weld1 = Instance.new("Weld")

							Weld1.Parent = LootHolder
							Weld1.Part0 = mesh
							Weld1.Part1 = Item.PrimaryPart

							Item.PrimaryPart.Anchored = false
							Item.Parent = DrawerContainer
							audioPlay("rbxassetid://6102638180", DrawerContainer, 0, 0.45, 1, 15, 1.05)
							module_itemsControls:LighterSwap(Item)
						elseif ChanceItem > 30 and ChanceItem < 35 then
							local Item = game.ServerScriptService.Server.Assets.Items.Handles.VitaminsHandle:Clone()
							local Weld1 = Instance.new("Weld")

							Weld1.Parent = LootHolder
							Weld1.Part0 = mesh
							Weld1.Part1 = Item.PrimaryPart

							Item.PrimaryPart.Anchored = false
							Item.Parent = DrawerContainer
							audioPlay("rbxassetid://6102638180", DrawerContainer, 0, 0.45, 1, 15, 1.05)
							module_itemsControls:VitaminsAdd(Item)
						end
					end
				elseif LootType == "HealDrawer" then
					if ChanceGold > 25 and ChanceGold < 125 then
						local Item = game.ServerScriptService.Server.Assets.Loots.Tiny:Clone()
						local Weld1 = Instance.new("Weld")

						Weld1.Parent = LootHolder
						Weld1.Part0 = mesh
						Weld1.Part1 = Item.PrimaryPart

						Item.PrimaryPart.Anchored = false
						Item.Parent = DrawerContainer
						audioPlay("rbxassetid://4612376346", DrawerContainer, 0, 0.55, 1, 15, 1.1)
						module_Debris:GoldModule(Item.LootPrompt)
						Item.Hitbox.Attachment.ParticleEmitter:Emit(5)
					elseif ChanceGold > 125 and ChanceGold < 195 then
						local Item = game.ServerScriptService.Server.Assets.Loots.Small:Clone()
						local Weld1 = Instance.new("Weld")

						Weld1.Parent = LootHolder
						Weld1.Part0 = mesh
						Weld1.Part1 = Item.PrimaryPart

						Item.PrimaryPart.Anchored = false
						Item.Parent = DrawerContainer
						audioPlay("rbxassetid://4612376346", DrawerContainer, 0, 0.55, 1, 15, 1.1)
						module_Debris:GoldModule(Item.LootPrompt)
						Item.Hitbox.Attachment.ParticleEmitter:Emit(15)
					elseif ChanceGold > 195 and ChanceGold < 255 then
						local Item = game.ServerScriptService.Server.Assets.Loots.Okay:Clone()
						local Weld1 = Instance.new("Weld")

						Weld1.Parent = LootHolder
						Weld1.Part0 = mesh
						Weld1.Part1 = Item.PrimaryPart

						Item.PrimaryPart.Anchored = false
						Item.Parent = DrawerContainer
						audioPlay("rbxassetid://4612376346", DrawerContainer, 0, 0.55, 1, 15, 1.1)
						module_Debris:GoldModule(Item.LootPrompt)
						Item.Hitbox.Attachment.ParticleEmitter:Emit(20)
					elseif ChanceGold > 255 and ChanceGold < 295 then
						local Item = game.ServerScriptService.Server.Assets.Loots.Good:Clone()
						local Weld1 = Instance.new("Weld")

						Weld1.Parent = LootHolder
						Weld1.Part0 = mesh
						Weld1.Part1 = Item.PrimaryPart

						Item.PrimaryPart.Anchored = false
						Item.Parent = DrawerContainer
						audioPlay("rbxassetid://4612376346", DrawerContainer, 0, 0.55, 1, 15, 1.1)
						module_Debris:GoldModule(Item.LootPrompt)
						Item.Hitbox.Attachment.ParticleEmitter:Emit(25)
					elseif ChanceGold > 295 and ChanceGold < 310 then
						local Item = game.ServerScriptService.Server.Assets.Loots.Best:Clone()
						local Weld1 = Instance.new("Weld")

						Weld1.Parent = LootHolder
						Weld1.Part0 = mesh
						Weld1.Part1 = Item.PrimaryPart

						Item.PrimaryPart.Anchored = false
						Item.Parent = DrawerContainer
						audioPlay("rbxassetid://4612376346", DrawerContainer, 0, 0.55, 1, 15, 1.1)
						module_Debris:GoldModule(Item.LootPrompt)
						Item.Hitbox.Attachment.ParticleEmitter:Emit(30)
					else
						if ChanceItem > 15 and ChanceItem < 20 then
							local Item = game.ServerScriptService.Server.Assets.Items.Handles.BandageHandle:Clone()
							local Weld1 = Instance.new("Weld")

							Weld1.Parent = LootHolder
							Weld1.Part0 = mesh
							Weld1.Part1 = Item.PrimaryPart

							Item.PrimaryPart.Anchored = false
							Item.Parent = DrawerContainer
							audioPlay("rbxassetid://6102638180", DrawerContainer, 0, 0.45, 1, 15, 1.05)
							module_itempickup.HealItem(Item)
						end
					end
				elseif LootType == "ChargeDrawer" then
					if ChanceGold > 25 and ChanceGold < 125 then
						local Item = game.ServerScriptService.Server.Assets.Loots.Tiny:Clone()
						local Weld1 = Instance.new("Weld")

						Weld1.Parent = LootHolder
						Weld1.Part0 = mesh
						Weld1.Part1 = Item.PrimaryPart

						Item.PrimaryPart.Anchored = false
						Item.Parent = DrawerContainer
						audioPlay("rbxassetid://4612376346", DrawerContainer, 0, 0.55, 1, 15, 1.1)
						module_Debris:GoldModule(Item.LootPrompt)
						Item.Hitbox.Attachment.ParticleEmitter:Emit(5)
					elseif ChanceGold > 125 and ChanceGold < 195 then
						local Item = game.ServerScriptService.Server.Assets.Loots.Small:Clone()
						local Weld1 = Instance.new("Weld")

						Weld1.Parent = LootHolder
						Weld1.Part0 = mesh
						Weld1.Part1 = Item.PrimaryPart

						Item.PrimaryPart.Anchored = false
						Item.Parent = DrawerContainer
						audioPlay("rbxassetid://4612376346", DrawerContainer, 0, 0.55, 1, 15, 1.1)
						module_Debris:GoldModule(Item.LootPrompt)
						Item.Hitbox.Attachment.ParticleEmitter:Emit(15)
					elseif ChanceGold > 195 and ChanceGold < 255 then
						local Item = game.ServerScriptService.Server.Assets.Loots.Okay:Clone()
						local Weld1 = Instance.new("Weld")

						Weld1.Parent = LootHolder
						Weld1.Part0 = mesh
						Weld1.Part1 = Item.PrimaryPart

						Item.PrimaryPart.Anchored = false
						Item.Parent = DrawerContainer
						audioPlay("rbxassetid://4612376346", DrawerContainer, 0, 0.55, 1, 15, 1.1)
						module_Debris:GoldModule(Item.LootPrompt)
						Item.Hitbox.Attachment.ParticleEmitter:Emit(20)
					elseif ChanceGold > 255 and ChanceGold < 295 then
						local Item = game.ServerScriptService.Server.Assets.Loots.Good:Clone()
						local Weld1 = Instance.new("Weld")

						Weld1.Parent = LootHolder
						Weld1.Part0 = mesh
						Weld1.Part1 = Item.PrimaryPart

						Item.PrimaryPart.Anchored = false
						Item.Parent = DrawerContainer
						audioPlay("rbxassetid://4612376346", DrawerContainer, 0, 0.55, 1, 15, 1.1)
						module_Debris:GoldModule(Item.LootPrompt)
						Item.Hitbox.Attachment.ParticleEmitter:Emit(25)
					elseif ChanceGold > 295 and ChanceGold < 310 then
						local Item = game.ServerScriptService.Server.Assets.Loots.Best:Clone()
						local Weld1 = Instance.new("Weld")

						Weld1.Parent = LootHolder
						Weld1.Part0 = mesh
						Weld1.Part1 = Item.PrimaryPart

						Item.PrimaryPart.Anchored = false
						Item.Parent = DrawerContainer
						audioPlay("rbxassetid://4612376346", DrawerContainer, 0, 0.55, 1, 15, 1.1)
						module_Debris:GoldModule(Item.LootPrompt)
						Item.Hitbox.Attachment.ParticleEmitter:Emit(30)
					else
						if ChanceItem > 15 and ChanceItem < 20 then
							local Item = game.ServerScriptService.Server.Assets.Items.Handles.BatteryHandle:Clone()
							local Weld1 = Instance.new("Weld")

							Weld1.Parent = LootHolder
							Weld1.Part0 = mesh
							Weld1.Part1 = Item.PrimaryPart

							Item.PrimaryPart.Anchored = false
							Item.Parent = DrawerContainer
							audioPlay("rbxassetid://6102638180", DrawerContainer, 0, 0.45, 1, 15, 1.05)
							module_itemsControls:BatteryAdd(Item)
						end
					end
				end
			end
		end
		

	end	
end

function DrawersM.Hook(DrawerContainer)
	local Knobs = DrawerContainer:FindFirstChild("Knobs")
	local LootHolder = DrawerContainer:FindFirstChild("LootHolder")
	local Prompt = Knobs:FindFirstChild("ActivateEventPrompt")
	
	local MaxMag = Prompt.MaxActivationDistance + 2.5
	
	DrawerContainer:SetAttribute("SetupDone", false)
	
	local room = game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1)
	local loot = room.Assets:FindFirstChild("KeyObtain")
	
	if math.random(1, 8) == math.random(1, 8) then
		if room:GetAttribute("KeySpawned") == false then
			if loot then
				room:SetAttribute("KeySpawned", true)
				DrawerContainer:SetAttribute("Key", true)
				local spawnpoints = DrawerContainer.Spawners

				loot.Hitbox.Anchored = false
				loot.Name = "KeyObtain"
				loot:PivotTo(spawnpoints:FindFirstChild("3").CFrame)

				local weld = Instance.new("WeldConstraint", loot)
				loot.WeldConstraint.Part0 = loot.Hitbox
				loot.WeldConstraint.Part1 = DrawerContainer.Main
			end
		end
	end
	
	local review = false
	local Spider = math.random(1, 41)
	local SpiderJumpscare = math.random(1, 41)
	
	Prompt.Triggered:Connect(function(Player)
		if review == false then
			review = true
			if Spider == SpiderJumpscare then
				game.ReplicatedStorage.EntityInfo.SpiderJumpscare:FireClient(Player, DrawerContainer, 0.3)
			end
		end
		DrawersM.OpenClose(DrawerContainer, Player)
		--Prompt.Enabled = false
		Prompt.ActionText = "Hand"
		
		task.delay(1.1, function()
			Prompt.Enabled = true
		end)
	end)
end

function DrawersM.Scan(Asset)
	local Asset = Asset
	for i, DrawerContainer in pairs(Asset:GetChildren()) do
		if DrawerContainer.Name == "DrawerContainer" then
			DrawersM.Hook(DrawerContainer)
		end
	end
end

return DrawersM