local tool=script.Parent
local handle=tool.Handle

local remotefunction=tool:WaitForChild("function")
local debris=game:GetService("Debris")
local char

tool.Equipped:Connect(function()
	char = script.Parent
end)

function remotefunction.OnServerInvoke(player,command,value)
	if command=="protect" then
		if value[2] then
			local currentvest=value[1]:FindFirstChild("VestArmour")
			if currentvest then
				currentvest:Destroy()
			end
			
			for i,v in pairs(value[1]:GetChildren()) do
				if v.ClassName == "Accessory" then
					--v.Handle.Transparency = 1 -- hides other hats
					wait(0.1)
					script.Parent.Handle.Sound:Play()
					script.Parent.Handle.Part1.Transparency = 1
					script.Parent.Handle.Part2.Transparency = 1
					script.Parent.Handle.Part1.Decal.Transparency = 1
				end
			end
			
			vest = game.ReplicatedStorage.Chains["051"]:Clone()
			value[1].Humanoid:AddAccessory(vest)
			
		end
	elseif command == "unprotect" then
			for i,v in pairs(value[1]:GetChildren()) do
				if v.ClassName == "Accessory" then
							local thing = v.Handle:FindFirstChild("Thingy")
					if thing then
					v.Handle.Transparency = 0
						script.Parent.Handle.Sound:Play() -- hides other hats 
					script.Parent.Handle.Part1.Transparency = 0
					script.Parent.Handle.Part2.Transparency = 0
					script.Parent.Handle.Part1.Decal.Transparency = 0
					end
				end
			end
		vest:Remove()
	end
end