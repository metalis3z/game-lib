local module = {}

local v2 = require(script.Parent.Parent.Parent);
local l__TweenService__1 = game:GetService("TweenService");

function module:StartSpawn(p1)
	
	local v2 = game.ReplicatedStorage.Rift:Clone()
	local v3 = workspace:FindFirstChild("RiftSpawn", true)

	local Player = game.Players:FindFirstChild(p1.Name)
	if not Player then
		return warn("Local player not found, unable to spawn rift")
	end
	
	local AdminPanel_Module = require(game.ReplicatedStorage.ClientModules.Module_AdminPanel)
	
	if game.MarketplaceService:PlayerOwnsAsset(Player, AdminPanel_Module.gamepass_id) and Player.PlayerStats.AdminPanel.Value == true then
		return
	end

	local playerStats = Player:FindFirstChild("PlayerStats")
	if not playerStats then
		return warn("Player stats not found, unable to spawn rift")
	end

	local riftStore = playerStats:FindFirstChild("RiftStore")
	local riftItem = playerStats:FindFirstChild("RiftItem")
	local riftItemDurability = playerStats:FindFirstChild("RiftItemDurability")

	if not riftStore or not riftItem then
		return warn("Rift store or rift item not found, unable to spawn rift")
	end

	local v4 = riftStore.Value
	local v5 = riftItem.Value
	local v5_5 = riftItemDurability.Value

	local v6 = workspace.CurrentRooms:FindFirstChild("0")

	if not v3 then
		return warn("Can't find a rift spawn, rift didn't spawn")
	end

	if v4 == false then
		return warn("Player didn't have stored item in rift, rift didn't spawn")
	end

	if v5 == "NoItem" then
		return warn("Player has rift but without item inside, rift didn't spawn")
	end

	if not v6 then
		return warn("In folder CurrentRooms client and server can't find a first room, rift didn't spawn")
	end

	v2.Parent = workspace.CurrentRooms:FindFirstChild("0")
	v2:PivotTo(v3:FindFirstChild("Center").CFrame)

	for v7, v8 in pairs(v2.Center.ParticlesOut:GetChildren()) do
		if v8:IsA("ParticleEmitter") then
			v8:Emit(v8:GetAttribute("EmitAmount"));
		end;
	end;
	
	v2:SetAttribute("Item", v5)
	v2.Center.ItemHolder.Item.Texture = game.ReplicatedStorage.ClientBricks.ServerStorage:FindFirstChild(v5).TextureId
	
	module:TakeItem(v3, v5, v5_5)
end

function module:TakeItem(p1, p2, p3)
	local RiftPrompt = p1:FindFirstChild("RiftPrompt")
	
	RiftPrompt.Enabled = true
	
	RiftPrompt.Triggered:Connect(function(plr)
		local Rift = game.Workspace:FindFirstChild("Rift", true)
		
		for v7, v8 in pairs(Rift.Center.ParticlesOut:GetChildren()) do
			if v8:IsA("ParticleEmitter") then
				v8:Emit(v8:GetAttribute("EmitAmount"));
			end;
		end;
		
		print(p2)
		
		if plr.Backpack:FindFirstChild(p2) or plr.Character:FindFirstChild(p2) then
			game.ReplicatedStorage.EntityInfo.FlashSpecify:FireServer("Cannot")
			return
		end
		
		game.ReplicatedStorage.EntityInfo.RiftClearItemData:FireServer(p2, game.ReplicatedStorage.EntityInfo.GetLimbs:InvokeServer())
		game.ReplicatedStorage.EntityInfo.GiveItem:FireServer(p2, p3, game.ReplicatedStorage.EntityInfo.GetLimbs:InvokeServer())
		
		wait(0.3)
		
		for v7, v8 in pairs(Rift.Center.ParticlesIn:GetChildren()) do
			if v8:IsA("ParticleEmitter") then
                v8.Enabled = false
			end;
		end;
		
		for v10, v11 in pairs(Rift:GetDescendants()) do
			if v11:IsA("Sound") and v11.Looped then
				l__TweenService__1:Create(v11, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Volume = 0, 
					Pitch = 0.01
				}):Play();
			elseif v11:IsA("BasePart") then
				l__TweenService__1:Create(v11, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Transparency = 1
				}):Play();
			elseif v11:IsA("Light") then
				l__TweenService__1:Create(v11, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Brightness = 0
				}):Play();
			end;
		end;
        
		Rift.Center.ItemHolder:Destroy()
		local RiftSpawn = game.Workspace:FindFirstChild("RiftSpawn", true)
		
		RiftSpawn:Destroy()
		wait(2)
		Rift:Destroy()
	end)
end

function module:SpawnRift(p1)
	local v2 = game.ReplicatedStorage.Rift:Clone()

	local Player = game.Players:FindFirstChild(p1.Name)
	if not Player then
		return warn("Local player not found, unable to spawn rift")
	end
	
	local AdminPanel_Module = require(game.ReplicatedStorage.ClientModules.Module_AdminPanel)
	
	if AdminPanel_Module:haveAccess(Player) and Player.PlayerStats.AdminPanel.Value == true then
		return
	end

	local playerStats = Player:FindFirstChild("PlayerStats")
	local riftStore = playerStats:FindFirstChild("RiftStore")
	local riftItem = playerStats:FindFirstChild("RiftItem")
	
	if riftItem.Value == "NoItem" then
		v2.Center.ItemHolder.Item.Texture = "rbxassetid://0"
	else
		v2.Center.ItemHolder.Item.Texture = game.ReplicatedStorage.ClientBricks.ServerStorage:FindFirstChild(riftItem.Value).TextureId
	end

	v2.Parent = workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1)
	v2:PivotTo(game.Workspace.CurrentRooms:FindFirstChild("RiftSpawn", true).Center.CFrame)

	for v7, v8 in pairs(v2.Center.ParticlesOut:GetChildren()) do
		if v8:IsA("ParticleEmitter") then
			v8:Emit(v8:GetAttribute("EmitAmount"));
		end;
	end;

	module:ModuleItem(v2, game.Workspace.CurrentRooms:FindFirstChild("RiftSpawn", true))
end

function module:ModuleItem(p1, p2)
	local RiftPrompt = p2:FindFirstChild("RiftPrompt")
	
	RiftPrompt.Enabled = true

	RiftPrompt.Triggered:Connect(function(plr)
		
		local playerStats = plr:FindFirstChild("PlayerStats")
		local riftStore = playerStats:FindFirstChild("RiftStore")
		local riftItem = playerStats:FindFirstChild("RiftItem")
		local riftItemDurability = playerStats:FindFirstChild("RiftItemDurability")

		if riftStore.Value == false and plr.Character:FindFirstChildOfClass("Tool") then
			local tool = plr.Character:FindFirstChildOfClass("Tool")
			
			if game.ReplicatedStorage.ClientBricks.ServerStorage:FindFirstChild(tool.Name) then
				
				v2.tool = false
				v2.fakeTool = false
				game.ReplicatedStorage.EntityInfo.SetItemUsed:FireServer(tool)
				wait()
				game.ReplicatedStorage.EntityInfo.r4:FireServer(tool.Name, tool:GetAttribute("Durability"), tool, game.ReplicatedStorage.EntityInfo.GetLimbs:InvokeServer())
				
				for v7, v8 in pairs(p1.Center.ParticlesOut:GetChildren()) do
					if v8:IsA("ParticleEmitter") then
						v8:Emit(v8:GetAttribute("EmitAmount"));
					end;
				end;
				
				p1.Center.ItemHolder.Item.Texture = game.ReplicatedStorage.ClientBricks.ServerStorage:FindFirstChild(tool.Name).TextureId
				
			else
				return
			end
		else
			if riftItem.Value == "NoItem" then
				
			else

				game.ReplicatedStorage.EntityInfo.GiveItem:FireServer(riftItem.Value, riftItemDurability.Value, game.ReplicatedStorage.EntityInfo.GetLimbs:InvokeServer())
				p1.Center.ItemHolder.Item.Texture = "rbxassetid://0"
				
				task.wait()
				
				game.ReplicatedStorage.ClientBricks.RiftClearItemData:FireServer(plr, game.ReplicatedStorage.EntityInfo.GetLimbs:InvokeServer())
				
				for v7, v8 in pairs(p1.Center.ParticlesOut:GetChildren()) do
					if v8:IsA("ParticleEmitter") then
						v8:Emit(v8:GetAttribute("EmitAmount"));
					end;
				end;
				
			end
		end
	end)
end

return module