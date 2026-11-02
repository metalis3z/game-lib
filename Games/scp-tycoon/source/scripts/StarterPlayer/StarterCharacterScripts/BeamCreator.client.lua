repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

local hum = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

if not hum:FindFirstChild("Beam") then
	if game.Players.LocalPlayer.Data.TycoonOwned.Value == 0 then

		local EmptyTycoon = nil
		for i,v in pairs(game.Workspace.Tycoons:GetChildren()) do
			if v.Data.Owner.Value == "" then
				EmptyTycoon = v
				break
			end
		end
		
		if EmptyTycoon ~= nil then
			local Beam = Instance.new("Beam")
			Beam.Parent = hum
			local Attach = Instance.new("Attachment")
			Attach.Parent = hum
			Beam.Attachment0 = Attach
			Beam.Attachment1 = EmptyTycoon.Door.WalkToAttachment
			Beam.Color = ColorSequence.new(Color3.fromRGB(19, 214, 16))
			Beam.Width0 = 2
			
			EmptyTycoon.Data.Owner:GetPropertyChangedSignal("Value"):Connect(function()
				if EmptyTycoon.Data.Owner.Value ~= game.Players.LocalPlayer.Name then
					EmptyTycoon = nil
					for i,v in pairs(game.Workspace.Tycoons:GetChildren()) do
						if v.Data.Owner.Value == "" then
							EmptyTycoon = v
							break
						end
					end
					
					if EmptyTycoon then
						Beam.Attachment0 = Attach
						Beam.Attachment1 = EmptyTycoon.Door.WalkToAttachment
					end
				else
					Beam:Destroy()
					Attach:Destroy()
				end
			end)
		else
			warn("There was an error find an empty tycoon. | Player: ".. game.Players.LocalPlayer.Name)
		end
		
		
	end
	
end

game.Players.LocalPlayer.Data.TycoonOwned:GetPropertyChangedSignal("Value"):Connect(function()
	if game.Players.LocalPlayer.Data.TycoonOwned ~= 1 then
		if hum:FindFirstChild("Beam") then
			hum:FindFirstChild("Beam"):Destroy()
			hum:FindFirstChild("Attachment"):Destroy()
		end
	end
end)