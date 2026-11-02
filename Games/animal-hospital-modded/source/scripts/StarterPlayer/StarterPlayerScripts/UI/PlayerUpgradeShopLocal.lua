require(game.ReplicatedStorage:WaitForChild("Lib"))

local ProximityPromptService = game:GetService("ProximityPromptService")

ProximityPromptService.PromptShown:Connect(function(p1) --[[ Line: 5 ]]
	if not p1:HasTag("ShopItemPP") then
		return
	end

	p1.Parent:WaitForChild("ItemInfo"):WaitForChild("UI").Enabled = true
end)
ProximityPromptService.PromptHidden:Connect(function(p1) --[[ Line: 12 ]]
	if not (p1:HasTag("ShopItemPP") and p1.Parent) then
		return
	end

	local ItemInfo = p1.Parent:WaitForChild("ItemInfo", 1)
	local v1 = if ItemInfo then ItemInfo:FindFirstChild("UI", 1) else ItemInfo

	if not v1 then
		return
	end

	v1.Enabled = false
end)

return {}