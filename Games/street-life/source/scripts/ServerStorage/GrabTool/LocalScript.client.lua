wait(1)
local Player = game.Players.LocalPlayer
local Chr = Player.Character or Player.CharacterAdded:Wait()
local Mouse = Player:GetMouse()
local Tool = script.Parent
local Mode
local Torso
local Using = false
local PTorso
local RemoteEvent = script.Parent:WaitForChild("RemoteEvent")

if Chr:FindFirstChild'UpperTorso' then
	PTorso = Chr.UpperTorso
else 
	PTorso = Chr.Torso
end

local hold = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(script.Animation)

local holded
Tool.Activated:Connect(function()
	if not Using then
		if Mouse.Target then
			if Mouse.Target.Parent:FindFirstChild("Humanoid") then
				if not holded then
					if (Chr:FindFirstChild("HumanoidRootPart").Position - (Mouse.Target.Parent:FindFirstChild("HumanoidRootPart")).Position).Magnitude >= 15 then return end

					local bypass = false
					for _,v in pairs(Mouse.Target.Parent:FindFirstChild("Humanoid"):GetPlayingAnimationTracks()) do
						if v.Name == "CuffedAnim" then 
							bypass = true
						end
					end
					
					if bypass == false then
						holded = Mouse.Target.Parent:FindFirstChild("Humanoid"):LoadAnimation(script.a)
						holded:Play()
						hold:Play()
					end
					RemoteEvent:FireServer('Cuff', Mouse.Target, Tool)
				else
					Using = false
					holded:Stop()
					hold:Stop()
					holded = nil
					RemoteEvent:FireServer('UnCuff')
				end
			else
				Using = false
				if holded then
					holded:Stop()
					hold:Stop()
					holded = nil
					RemoteEvent:FireServer('UnCuff')
				end
			end
		else
			Using = false
			if holded then
				holded:Stop()
				hold:Stop()
				holded = nil
				RemoteEvent:FireServer('UnCuff')
			end
		end
	else 
		Using = false
		if holded then
			holded:Stop()
			hold:Stop()
			holded = nil
		end
		RemoteEvent:FireServer('UnCuff')
	end
end)

RemoteEvent.OnClientEvent:Connect(function(one)
	if one == 'Use' then
		Using = true
	elseif one == 'STOP' then
		Using = false
		if holded then
			holded:Stop()
			hold:Stop()
			holded = nil
			RemoteEvent:FireServer('UnCuff')
		end
		for _,v in pairs(Mouse.Target.Parent:FindFirstChild("Humanoid"):GetPlayingAnimationTracks()) do
			if v.Name == "CuffedAnim" then 
				v:Destroy()
			end
		end
	end
end)