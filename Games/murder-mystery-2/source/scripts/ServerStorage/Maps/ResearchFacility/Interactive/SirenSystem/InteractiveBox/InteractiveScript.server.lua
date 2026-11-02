local Spinning = false
local Debounce = false
local function TriggerAllSirens(bool)
	for Name,Part in pairs(script.Parent.Parent:GetDescendants()) do
		if Part:IsA("SpotLight") then
			Part.Enabled = bool
		end
		if Part.Name == "Bulb" then
			Part.Color = (bool == true and Color3.fromRGB(255, 53, 53)) or Color3.fromRGB(205, 205, 205)
		end
	end
	if bool == true then
		Spinning = true
		spawn(function()
			for Name,Part in pairs(script.Parent.Parent:GetDescendants()) do
				if Part.Name == "Part1" or Part.Name == "Part2" then
				spawn(function()
						while Spinning do
							game:GetService("RunService").Heartbeat:Wait()
							Part.CFrame = Part.CFrame * CFrame.Angles(0.1,0,0)
						end
						end)
					end
			end

		end)
	else
		Spinning = false
	end
end

script.Parent.Interact.OnServerEvent:Connect(function()
	if not Debounce then
		Debounce = true
	script.Parent.Parent.Parent.DoorLockdown1.InteractiveBox.KnifeHit:Fire()
	script.Parent.Parent.Parent.DoorLockdown2.InteractiveBox.KnifeHit:Fire()
	TriggerAllSirens(true)
	wait(20)
		TriggerAllSirens(false)
		wait(15)
	    Debounce = false
	end
end)