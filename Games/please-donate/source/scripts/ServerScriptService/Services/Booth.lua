--[[
    Anyways i never used this idk why
]]

local data = {}

local _Booths = game.ServerStorage.BoothModels

function data:GetBooth(slot)
	for i,v in pairs(workspace.BoothModels:GetChildren()) do
		if v:IsA("Model") then
			if v:GetAttribute("BoothID") == slot then
				return v
			end
		end
	end
end

function data:GetInteraction(slot)
	for i,v in pairs(workspace.BoothInteractions:GetChildren()) do
		if v:IsA("Part") then
			if v:GetAttribute("BoothSlot") == slot then
				return v
			end
		end
	end
end

function data:ResetBooth(player, slot, booth, interaction)
	local CurrentBooth = booth
	local NewBooth = _Booths:FindFirstChild("BasicBooth"):Clone()
	local boothui = script.BoothUI:Clone()

	boothui.Parent = NewBooth
	boothui.Details.Adornee = NewBooth:FindFirstChild("Base")
	boothui.Items.Adornee = NewBooth:FindFirstChild("ItemsPart")
	boothui.Sign.Adornee = NewBooth:FindFirstChild("SignPart")
	boothui.Details.Raised.Visible = false

	boothui.Details.Owner.Text = "unclaimed"
	boothui.Details.Raised.Text = "100R$"
	boothui.Sign.TextLabel.Text = "your text here"

	NewBooth.Parent = workspace:FindFirstChild("BoothModels")
	NewBooth:SetAttribute("BoothID", slot)
	NewBooth:SetPrimaryPartCFrame(CurrentBooth.PrimaryPart.CFrame)
	CurrentBooth:Destroy()
	player:SetAttribute("Claimed", false)
	player:SetAttribute("OwnedBooth", "None")
	interaction.Claim.Enabled = true
	print("[GAME]: Resetted booth for @" .. player.Name)
end

return data
