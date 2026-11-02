-- Mutation LIKE : les projecteurs accrochés à l'animal ou à l'œuf (attachments taggés "LikeSpot", créés par TraitDeco)
-- balaient lentement autour de lui, comme sur une scène.
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
RunService.Heartbeat:Connect(function()
	local t = os.clock()
	for _, lamp in CollectionService:GetTagged("LikeSpot") do
		local home = lamp:GetAttribute("Home")
		if home and lamp:IsDescendantOf(workspace) then
			local phase = lamp:GetAttribute("Phase") or 0
			local r = Vector3.new(home.X, 0, home.Z).Magnitude
			lamp.Position = home + Vector3.new(math.sin(t * 1.3 + phase), 0, math.cos(t * 0.9 + phase)) * r * 0.55
		end
	end
end)
