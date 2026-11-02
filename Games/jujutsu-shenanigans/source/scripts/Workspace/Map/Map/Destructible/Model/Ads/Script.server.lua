local LocalPlayer_upvr = game.Players.LocalPlayer

local function handlePrompt(arg1)
	arg1.Triggered:Connect(function()
		if LocalPlayer_upvr.PlayerGui:FindFirstChild("BillboardEditUI") then
		else
			local clone = script.BillboardEditUI:Clone()
			clone.Promptobj.Value = arg1.Parent.Parent
			clone.Parent = LocalPlayer_upvr.PlayerGui
		end
	end)
	arg1.PromptHidden:Connect(function() -- Line 13
		local BillboardEditUI = LocalPlayer_upvr.PlayerGui:FindFirstChild("BillboardEditUI")
		if BillboardEditUI then
			BillboardEditUI:Destroy()
		end
	end)
end
for _, v in script.Parent:GetDescendants() do
	if v.Name == "Screen" then
		v.Parent.SurfaceGui.Adornee = v
	elseif v:IsA("ProximityPrompt") then
		handlePrompt(v)
	end
end
script.Parent.DescendantAdded:Connect(function(arg1)
	if arg1.Name == "Screen" then
		arg1.Parent.SurfaceGui.Adornee = arg1
	else
		if not arg1:IsA("ProximityPrompt") then return end
		handlePrompt(arg1)
	end
end)