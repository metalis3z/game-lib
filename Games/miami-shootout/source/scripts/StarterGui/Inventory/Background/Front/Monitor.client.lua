local player = game.Players.LocalPlayer
local data = player:WaitForChild("InvData")
local remote = game:GetService("ReplicatedStorage"):WaitForChild("Inventory")

remote.OnClientEvent:Connect(function(val,safe)
	if val == "OpenInv" then
		print("opening inv")
		script.Parent.Parent.Visible = true
		script.Parent.Parent.Parent.SafeModel.Value = safe
	end	
end)

local blacklistedItems = {"M4A1","LocalFootsteps","Fist","Phone"}

script.Parent.Close.MouseButton1Click:Connect(function()
	script.Parent.Parent.Visible = false
end)

function updateInv(where)
	local f
	local frame

	if where == "Inv" then
		f = data
		frame = script.Parent.InvFrame
	else
		f = player.Backpack
		frame = script.Parent.BackpackFrame
	end
	
	for i, v in pairs(frame:GetChildren())do
		v:Destroy()
	end
	
	local xP = 0
	local yP = 0
	
	for i, v in pairs(f:GetChildren())do
		if not table.find(blacklistedItems,v.Name) then
			local x = script:WaitForChild("Item"):Clone()
			x.Name = "Item"..i
			x.Text = v.Name
			x.Parent = frame
			x.Position = x.Position + UDim2.new(xP * 0.3, 0, yP * 0.15, 0)
			x.MouseButton1Click:Connect(function()
				remote:FireServer("Change", v.Name, where, script.Parent.Parent.Parent.SafeModel.Value)
			end)
			if xP < 2 then
				xP = xP + 1
			elseif xP >= 2 then
				xP = 0
				yP = yP + 1
			end
		end	
	end
	
end

wait(1)

updateInv("Inv")
updateInv("Backpack")

data.ChildAdded:Connect(function()
	updateInv("Inv")
end)

data.ChildRemoved:Connect(function()
	updateInv("Inv")
end)

player.Backpack.ChildAdded:Connect(function()
	updateInv("Backpack")
end)

player.Backpack.ChildRemoved:Connect(function()
	updateInv("Backpack")
end)