local UnlockPrompt = script.Parent.Parent.Parent.Parent.ElectricalDoor.Door.Lock.UnlockPrompt
local anim = script.UnlockPrompt
local dada = script.Parent.Parent.Parent.Parent.ElectricalDoor.Door
local hiden = script.Parent.Parent.Parent.Parent.ElectricalDoor.Hidden
local animUnlock = script.UseFinish
local ToolName = {"ElectricalKey"}
local Storage = game.ServerStorage
local Sonido = script.Parent.Parent.Hitbox.Sound

UnlockPrompt.PromptButtonHoldBegan:Connect(function(unlock)
	if unlock then
		if unlock.Character:FindFirstChild("ElectricalKey") then
			local loadanim = unlock.Character:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(anim)

			loadanim:Play()
			UnlockPrompt.PromptButtonHoldEnded:Connect(function()
				loadanim:Stop()
			end)
		end
	end
end)

UnlockPrompt.Triggered:Connect(function(unlock)
	if unlock then
		local loadanimUnlock = unlock.Character:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(animUnlock)
		if unlock.Character:FindFirstChild("ElectricalKey") then
			loadanimUnlock:Play()
			loadanimUnlock.Looped = false
			wait(0.03)
			for i, v in pairs(game.Players:GetPlayers()) do 
				if v.Character then 
					local key = v.Character:FindFirstChild("ElectricalKey")
					local keyBack = v.Backpack:FindFirstChild("ElectricalKey")
					if key then
						key:Destroy()
						game.ReplicatedStorage.Bricks.ItemDetect:FireClient(v,"ElectricalKey")
					end
					if keyBack then
						keyBack:Destroy()
						game.ReplicatedStorage.Bricks.ItemDetect:FireClient(v, "ElectricalKey")
					end
				end
			end
			script.Parent.Parent.Parent.Parent.Assets.KeyObtain:Destroy()
			hiden.AssetControl.Enabled = true
			dada.Hit:Play()
			dada.Unlock:Play()
			--script.Parent.Parent.Parent.Lock.Anchored = false
			--script.Parent.Parent.Parent.Lock.Thing.Anchored = false
			--script.Parent.Parent.Parent.Lock.UnlockPrompt:Destroy()
			UnlockPrompt.Enabled = false
		else
			game.ReplicatedStorage.Bricks:WaitForChild("KeyRequire"):FireClient(unlock, "Cannot")	
		end
	end
end)

script.Parent.Parent.Parent.Parent.Assets.KeyObtain.ModulePrompt.Triggered:connect(function(Player)
	if Player and Player.Character  then
		local Backpack = Player:WaitForChild("Backpack")
		for i = 1, #ToolName do
			local Tool = Storage:FindFirstChild(ToolName[i])
			if Tool then
				if Backpack:FindFirstChild("ElectricalKey") or Player.Character:FindFirstChild("ElectricalKey") then
					game.ReplicatedStorage.Bricks.KeyFull:FireClient(Player, "ElectricKey", "1/1")	
					return
				end
				Sonido:Play()
				Tool:clone().Parent = Player.Character
			end
		end
	end
end)