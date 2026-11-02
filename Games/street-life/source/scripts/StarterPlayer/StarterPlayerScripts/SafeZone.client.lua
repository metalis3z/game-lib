if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

local Zone = require(game:FindService('ReplicatedStorage'):WaitForChild("Zone"))
game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)

local CheckAnims = function()
	task.spawn(function()
		for _,v in next, Character:FindFirstChild('Humanoid'):GetPlayingAnimationTracks() do
			if v.Name == 'IdleAnim' then
				v:Stop()
				v:Destroy()
			end
		end
	end)
end

for _,v in next, workspace:WaitForChild('Zones'):GetChildren() do
	if v.Name ~= 'Extra' then
		local CreateZone = Zone.new(v)
		local Inside = false
		CreateZone.localPlayerEntered:Connect(function(Player)
			pcall(function()
				if not Player.Character then return end
				if not Player.Character:FindFirstChild('Humanoid') then return end 
				if Player.Character:FindFirstChild('Humanoid').Health == 0 then return end
				if v.Name == 'Gym' then
					Player.PlayerGui:FindFirstChild('GymStats').Enabled = true 
				end
				if Player.Character:FindFirstChildOfClass('Tool') then Player.Character:FindFirstChildOfClass('Tool').Parent = Player.Backpack end
				if Player.Character.Humanoid.Health >= 90 then
					game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
					script:FindFirstChild('Highlight'):Clone().Parent = Player.Character
					script:FindFirstChild('Shield'):Clone().Parent = Player.Character.HumanoidRootPart
				elseif v.Name == 'GunStore' or v.Name == 'Dealer' then
					game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
				end
				Inside = true
				CheckAnims()
				while wait(.1) and Inside do
					if game:FindService('StarterGui'):GetCoreGuiEnabled(Enum.CoreGuiType.Backpack) == true then
						game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
						CheckAnims()
					end
				end
				task.wait(.1)
				CheckAnims()
			end)
		end)
		CreateZone.localPlayerExited:Connect(function(Player)
			pcall(function()
				if not Player.Character then return end
				if not Player.Character:FindFirstChild('Humanoid') then return end 
				if Player.Character:FindFirstChild('Humanoid').Health == 0 then return end
				if v.Name == 'Gym' then
					Player.PlayerGui:FindFirstChild('GymStats').Enabled = false
				end
				game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
				if Player.Character:FindFirstChild('Highlight') then Player.Character:FindFirstChild('Highlight'):Destroy() end
				if Player.Character.HumanoidRootPart:FindFirstChild('Shield') then  Player.Character.HumanoidRootPart:FindFirstChild('Shield'):Destroy() end
				CheckAnims()
				Inside = false
				task.wait(.25)
				if not Character:FindFirstChildOfClass('Tool') or (Character:FindFirstChildOfClass('Tool') and not Character:FindFirstChildOfClass('Tool'):FindFirstChild('Settings')) then
					CheckAnims()
				end
				task.wait(.25)
				if not Character:FindFirstChildOfClass('Tool') or (Character:FindFirstChildOfClass('Tool') and not Character:FindFirstChildOfClass('Tool'):FindFirstChild('Settings')) then
					CheckAnims()
				end
			end)
		end)
	end
end