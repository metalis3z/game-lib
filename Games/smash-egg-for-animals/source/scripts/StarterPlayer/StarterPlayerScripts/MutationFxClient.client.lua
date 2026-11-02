-- Mutation LIKE : les projecteurs accrochés à l'animal ou à l'œuf (attachments taggés "LikeSpot", créés par TraitDeco)
-- balaient lentement autour de lui, comme sur une scène. (optimisé : liste en cache, seulement près de la caméra)
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local NEAR = 150
local lamps = {}
for _, l in CollectionService:GetTagged("LikeSpot") do lamps[l] = true end
CollectionService:GetInstanceAddedSignal("LikeSpot"):Connect(function(l) lamps[l] = true end)
CollectionService:GetInstanceRemovedSignal("LikeSpot"):Connect(function(l) lamps[l] = nil end)
RunService.Heartbeat:Connect(function()
	local t = os.clock()
	local camPos = workspace.CurrentCamera.CFrame.Position
	for lamp in lamps do
		local home = lamp:GetAttribute("Home")
		local root = lamp.Parent
		if home and root and root:IsA("BasePart") and (root.Position - camPos).Magnitude < NEAR then
			local phase = lamp:GetAttribute("Phase") or 0
			local r = Vector3.new(home.X, 0, home.Z).Magnitude
			lamp.Position = home + Vector3.new(math.sin(t * 1.3 + phase), 0, math.cos(t * 0.9 + phase)) * r * 0.55
		end
	end
end)
