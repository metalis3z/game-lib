--[[
	INPUT: Player killer, Humanoid humanoid, Number time=1
--]]
local Debris = game:GetService'Debris'

return function(player, humanoid, t)
	if humanoid == nil then return end
	if player == nil then return end
	if humanoid:IsA'Player' then player,humanoid = humanoid,player end
	
	if humanoid:FindFirstChild'creator' then
		humanoid.creator:Destroy()
	end
	
	local tag = Instance.new'ObjectValue'
	tag.Name = 'creator'
	tag.Value = player
	tag.Parent = humanoid
	
	Debris:AddItem(tag, t or 1)
end