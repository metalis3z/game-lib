local module = {}

repeat wait(0.1) until game.Workspace.CurrentRooms:FindFirstChild("0")

if game.Workspace.CurrentRooms:FindFirstChild("0"):GetAttribute("OriginalName") == "Hunt_FirstRoom" then

else
	return
end

-- Created and Fixed by BUILDG Studios

local RoomGeneration = require(script.Parent.Hunt_RoomGeneration)
local GameDetails = require(script.Parent.GameDetails)

function module:Load(v, Start)
	local Key = {"HuntKey"}

	local UnlockPrompt = v:FindFirstChild("UnlockPrompt")

	local Animation = Instance.new("Animation")
	Animation.AnimationId = "rbxassetid://16591164691"
	
	local AnimationUnlock = Instance.new("Animation")
	AnimationUnlock.AnimationId = "rbxassetid://16923977247" -- 16923977247
	
	local AnimationKey = Instance.new("Animation")
	AnimationKey.AnimationId = "rbxassetid://16739637781"
	
	local Storage = game.ServerStorage
	local Sound = v.Parent.Parent:FindFirstChild("Assets"):FindFirstChild("KeyObtain", true).Hitbox.Sound

	UnlockPrompt.PromptButtonHoldBegan:Connect(function(unlock)
		if unlock then
			if unlock.Character:FindFirstChild("HuntKey") then
				if unlock.Character:FindFirstChild("HuntKey") then
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
			local loadanimUnlock = unlock.Character:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(AnimationUnlock)
			if unlock.Character:FindFirstChild("HuntKey") then
				loadanimUnlock:Play()
				loadanimUnlock.Looped = false
				wait(0.275)
				v.Parent.Parent.Assets:FindFirstChild("KeyObtain", true):Destroy()
				if v.Parent.Parent.Door.Hidden:FindFirstChild("AssetControl") then
					v.Parent.Parent.Door.Hidden:FindFirstChild("AssetControl").Enabled = true
				elseif v.Parent.Parent.Door.Hidden:FindFirstChild("Generation") then
					v.Parent.Parent.Door.Hidden:FindFirstChild("Generation").Enabled = true
					v.Parent.Parent.Door.Hidden:FindFirstChild("Script").Enabled = true
				end
				v.Parent.Parent.Door.Door.Fall:Play()
				v.Parent.Parent.Door.Hidden:SetAttribute("Locked", false)
				if Start == true then
					task.delay(0.5, function()
						RoomGeneration:HuntOpenAuto(v.Parent.Parent.Door)
						game.Workspace.Game:SetAttribute("GameStart", true)
					end)
				else
					task.delay(0.5, function()
						RoomGeneration:HuntOpenAuto(v.Parent.Parent.Door)
					end)
				end

				v.Anchored = false
				v.Thing.Anchored = false
				v.UnlockPrompt:Destroy()

				for i, v in pairs(game.Players:GetPlayers()) do 
					if v.Character then 
						local key = v.Character:FindFirstChild("HuntKey")
						local keyBack = v.Backpack:FindFirstChild("HuntKey")
						if key then
							key:SetAttribute("Used", true)
							wait(0.2)
							key:Destroy()
							game.ReplicatedStorage.Bricks.ItemDetect:FireClient(v,"HuntKey")
						end
						if keyBack then
							keyBack:SetAttribute("Used", true)
							wait(0.2)
							keyBack:Destroy()
							game.ReplicatedStorage.Bricks.ItemDetect:FireClient(v, "HuntKey")
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
					if Backpack:FindFirstChild("HuntKey") or Player.Character:FindFirstChild("HuntKey") then
						game.ReplicatedStorage.Bricks.KeyFull:FireClient(Player, "HuntKey", "x1")	
						return
					end
					Sound:Play()
					
					Tool:clone().Parent = Player.Character
				end
			end
		end
	end)
end

return module
