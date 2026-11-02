-- (Hat Giver Script - Loaded.)

local mkps = game:GetService("MarketplaceService")
local idGamePass = 102417947
debounce = true

function onTouched(hit)
	local plr = game.Players:GetPlayerFromCharacter(hit.Parent)
	if plr then
		if mkps:UserOwnsGamePassAsync(plr.UserId, idGamePass) then

	if (hit.Parent:findFirstChild("Humanoid") ~= nil and debounce == true) then
		debounce = false
		h = Instance.new("Hat")
		p = Instance.new("Part")
		h.Name = "Top Hat"
		p.Parent = h
		p.Position = hit.Parent:findFirstChild("Head").Position
		p.Name = "Handle" 
		p.formFactor = 0
		p.Size = Vector3.new(2, 1, 1) 
		p.BottomSurface = 0 
		p.TopSurface = 0 
		p.Locked = true 
		script.Parent.Mesh:clone().Parent = p
		h.Parent = hit.Parent
		h.AttachmentPos = Vector3.new(0, .38, 0)
		wait(5)
		debounce = true
	else
		mkps:PromptGamePassPurchase(plr, idGamePass)
	end
end
end
end
script.Parent.Touched:connect(onTouched)

-- Proof to kewlmaiaII