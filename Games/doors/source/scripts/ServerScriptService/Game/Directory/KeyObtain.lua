local module = {}

-- Created and Fixed by BUILDG Studios

local RoomGeneration = require(script.Parent.RoomGeneration)
local GameDetails = require(script.Parent["GameDetails"])

function module:Load(v, Start)
	local Key = {"Key"}
	
	local OrinZ = 22.464

	local UnlockPrompt = v:FindFirstChild("UnlockPrompt")
	
	local AnimationLockpick = Instance.new("Animation")
	AnimationLockpick.AnimationId = "rbxassetid://13818314986z"
	local AnimationUnlockLockpick = Instance.new("Animation")
	AnimationUnlockLockpick.AnimationId = "rbxassetid://16923977247"

	local Animation = Instance.new("Animation")
	Animation.AnimationId = "rbxassetid://16591164691"
	local AnimationUnlock = Instance.new("Animation")
	AnimationUnlock.AnimationId = "rbxassetid://16923977247"
	
	local AnimationKey = Instance.new("Animation")
	AnimationKey.AnimationId = "rbxassetid://16739637781"
	
	local Storage = game.ServerStorage
	local Sound = v.Parent.Parent:FindFirstChild("Assets"):FindFirstChild("KeyObtain", true).Hitbox.Sound

	UnlockPrompt.PromptButtonHoldBegan:Connect(function(unlock)
		if unlock then
			if unlock.Character:FindFirstChild("Key") or unlock.Character:FindFirstChild("Lockpick") then
				if unlock.Character:FindFirstChild("Lockpick") then
					local loadanim1 = unlock.Character:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(AnimationLockpick)

					loadanim1:Play()
					UnlockPrompt.PromptButtonHoldEnded:Connect(function()
						loadanim1:Stop()
					end)
				elseif unlock.Character:FindFirstChild("Key") then
					local loadanim2 = unlock.Character:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(Animation)
					local loadanim3 = unlock.Character:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(AnimationKey)

					loadanim3:Play(0, 1, 1)
					loadanim3.Priority = Enum.AnimationPriority.Action4
					loadanim2:Play()
					UnlockPrompt.PromptButtonHoldEnded:Connect(function()
						loadanim3:Stop()
						loadanim2:Stop()
					end)
					task.delay(2, function()
						loadanim3:Stop(0, 1, 1)
					end)
				end
			else
				game.ReplicatedStorage.EntityInfo.FlashSpecify:FireClient(unlock, "NeedKey")
			end
		end
	end)
	
	GameDetails:SoundSet(v.Parent.Parent.Assets:FindFirstChild("KeyObtain", true).Hitbox, v.Parent.Parent.Assets:FindFirstChild("KeyObtain", true), true)

	UnlockPrompt.Triggered:Connect(function(unlock)
		if unlock then
			local loadanimUnlockLockpick = unlock.Character:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(AnimationUnlockLockpick)
			local loadanimUnlock = unlock.Character:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(AnimationUnlock)
			if unlock.Character:FindFirstChild("Key") or unlock.Character:FindFirstChild("Lockpick") then
				if unlock.Character:FindFirstChild("Key") then
					loadanimUnlock:Play()
					loadanimUnlock.Looped = false
				elseif unlock.Character:FindFirstChild("Lockpick") then
					loadanimUnlockLockpick:Play()
					loadanimUnlockLockpick.Looped = false
				end
				if Start == true then
					RoomGeneration:Open(v.Parent.Parent.Door.Hidden)
					RoomGeneration:Generate(v.Parent.Parent.Door.Hidden, true)
				else
					RoomGeneration:Open(v.Parent.Parent.Door.Hidden)
					RoomGeneration:Generate(v.Parent.Parent.Door.Hidden, false)
				end
				v.Parent.Parent.Door.Door.Unlock:Play()
				v.Anchored = false
				v.Thing.Anchored = false
				v.UnlockPrompt:Destroy()
				--wait(0.275)
				v.Parent.Parent.Assets:FindFirstChild("KeyObtain", true):Destroy()
				if v.Parent.Parent.Door.Hidden:FindFirstChild("AssetControl") then
					v.Parent.Parent.Door.Hidden:FindFirstChild("AssetControl").Enabled = true
				elseif v.Parent.Parent.Door.Hidden:FindFirstChild("Generation") then
					v.Parent.Parent.Door.Hidden:FindFirstChild("Generation").Enabled = true
					v.Parent.Parent.Door.Hidden:FindFirstChild("Script").Enabled = true
				end
				v.Parent.Parent.Door.Door.Fall:Play()
				v.Parent.Parent.Door.Door.Unlock:Play()
				v.Parent.Parent.Door.Hidden:SetAttribute("Locked", false)
				
				for i, v in pairs(game.Players:GetPlayers()) do 
					if v.Character then 
						local key = v.Character:FindFirstChild("Key")
						local keyBack = v.Backpack:FindFirstChild("Key")
						if key then
							key:SetAttribute("Used", true)
							wait(0.2)
							key:Destroy()
							game.ReplicatedStorage.Bricks.ItemDetect:FireClient(v,"Key")
						end
						if keyBack then
							keyBack:SetAttribute("Used", true)
							wait(0.2)
							keyBack:Destroy()
							game.ReplicatedStorage.Bricks.ItemDetect:FireClient(v, "Key")
						end
					end
				end
				if unlock.Character:FindFirstChild("Lockpick") then
					unlock.Character:FindFirstChild("Lockpick"):SetAttribute("Durability", unlock.Character:FindFirstChild("Lockpick"):GetAttribute("Durability") - 1)
					for i, v in pairs(game.Players:GetPlayers()) do 
						if v.Character then 
							local key = v.Character:FindFirstChild("Key")
							local keyBack = v.Backpack:FindFirstChild("Key")
							if key then
								key:Destroy()
								game.ReplicatedStorage.Bricks.ItemDetect:FireClient(v, "Key")
							end
							if keyBack then
								keyBack:Destroy()
								game.ReplicatedStorage.Bricks.ItemDetect:FireClient(v, "Key")
							end
						end
					end
				end
				UnlockPrompt.Enabled = false
			end
		end
	end)

	v.Parent.Parent.Assets:FindFirstChild("KeyObtain", true).ModulePrompt.Triggered:connect(function(Player)
		if Player and Player.Character then
			local Backpack = Player:WaitForChild("Backpack")
			for i = 1, #Key do
				local Tool = Storage:FindFirstChild(Key[i])
				if Tool then
					if Backpack:FindFirstChild("Key") or Player.Character:FindFirstChild("Key") then
						game.ReplicatedStorage.Bricks.KeyFull:FireClient(Player, "Key", "x1")	
						return
					end
					Sound:Play()
					
					Tool:clone().Parent = Player.Character
				end
			end
		end
	end)
end

function module:LoadSkeletonDoor(v)
	
	local SpecificItem = "SkeletonKey"
	
	local UnlockPrompt = v:FindFirstChild("UnlockPrompt")

	local AnimationLockpick = Instance.new("Animation")
	AnimationLockpick.AnimationId = "rbxassetid://13818314986"
	local AnimationUnlockLockpick = Instance.new("Animation")
	AnimationUnlockLockpick.AnimationId = "rbxassetid://16923977247"

	local Animation = Instance.new("Animation")
	Animation.AnimationId = "rbxassetid://16591164691"
	local AnimationUnlock = Instance.new("Animation")
	AnimationUnlock.AnimationId = "rbxassetid://16923977247"

	local AnimationKey = Instance.new("Animation")
	AnimationKey.AnimationId = "rbxassetid://16739637781"

	local Storage = game.ServerStorage

	UnlockPrompt.PromptButtonHoldBegan:Connect(function(unlock)
		if unlock then
			if unlock.Character:FindFirstChild(SpecificItem) then
				local loadanim2 = unlock.Character:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(Animation)
				local loadanim3 = unlock.Character:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(AnimationKey)

				loadanim3:Play(0, 1, 1)
				loadanim3.Priority = Enum.AnimationPriority.Action4
				loadanim2:Play()
				UnlockPrompt.PromptButtonHoldEnded:Connect(function()
					loadanim3:Stop()
					loadanim2:Stop()
				end)
				task.delay(2, function()
					loadanim3:Stop(0, 1, 1)
				end)
			else
				game.ReplicatedStorage.EntityInfo.FlashSpecify:FireClient(unlock, "NeedKey")
			end
		end
	end)

	UnlockPrompt.Triggered:Connect(function(unlock)
		if unlock then
			local loadanimUnlockLockpick = unlock.Character:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(AnimationUnlockLockpick)
			local loadanimUnlock = unlock.Character:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(AnimationUnlock)
			if unlock.Character:FindFirstChild(SpecificItem) then
				if unlock.Character:FindFirstChild(SpecificItem) then
					loadanimUnlock:Play()
					loadanimUnlock.Looped = false
				end
				
				
				
				wait(0.275)
				
				UnlockPrompt.Enabled = false
			end
		end
	end)
end

return module
