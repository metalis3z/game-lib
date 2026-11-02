-- Construit le nid d'un modèle d'œuf (EggModels) : un lit de paille plein, le panier tressé (mesh) remonté sur le bas de l'œuf,
-- et une couronne de bottes de paille qui remplit tous les côtés. Tout est ancré, sans collision, groupé dans un Model "Nest".
local ServerStorage = game:GetService("ServerStorage")
local NestBuilder = {}
local STRAWS = 12
function NestBuilder.build(model)
	local root = model:FindFirstChild("Root") or model.PrimaryPart
	local old = model:FindFirstChild("Nest")
	if old then old:Destroy() end
	-- la coque = la plus grosse pièce de l'œuf
	local shell, volume = nil, 0
	for _, p in model:GetChildren() do
		if p:IsA("BasePart") and p ~= root then
			local v = p.Size.X * p.Size.Y * p.Size.Z
			if v > volume then shell, volume = p, v end
		end
	end
	local rcf = root.CFrame
	local center = rcf:PointToObjectSpace(shell.Position)
	local W = math.max(shell.Size.X, shell.Size.Z)
	local bottom = center.Y - shell.Size.Y / 2
	local rng = Random.new(#model.Name * 7919)
	local group = Instance.new("Model")
	group.Name = "Nest"
	local function place(part, localCf)
		part.Anchored, part.CanCollide, part.CanTouch, part.CanQuery, part.CastShadow = true, false, false, true, true
		part.CFrame = rcf * CFrame.new(center.X, 0, center.Z) * localCf
		part.Parent = group
	end
	-- lit de paille : bouche le fond, l'œuf est posé dedans
	local bed = Instance.new("Part")
	bed.Name = "Bed"
	bed.Material = Enum.Material.Fabric
	bed.Color = Color3.fromRGB(196, 146, 66)
	bed.Size = Vector3.new(W * 0.96, W * 0.24, W * 0.96)
	Instance.new("SpecialMesh", bed).MeshType = Enum.MeshType.Sphere -- boule aplatie
	place(bed, CFrame.new(0, bottom - W * 0.02, 0))
	-- panier tressé : remonte sur le bas de l'œuf
	local bowl = ServerStorage.NestMesh2:Clone()
	bowl.Name = "Bowl"
	local ratio = bowl.Size.Z / bowl.Size.X
	bowl.Size = Vector3.new(W * 1.32, W * 0.52, W * 1.32 * ratio)
	place(bowl, CFrame.new(0, bottom + W * 0.14, 0) * CFrame.Angles(0, rng:NextNumber(0, math.pi * 2), 0))
	-- couronne de paille tout autour (deux rangs décalés) : plus aucun trou sur les côtés
	for i = 1, STRAWS do
		local s = ServerStorage.StrawMesh:Clone()
		s.Name = "Straw"
		local k = rng:NextNumber(0.42, 0.55)
		s.Size = Vector3.new(W * k, W * k * 0.2, W * k * 0.95)
		local angle = (i / STRAWS) * math.pi * 2 + rng:NextNumber(-0.15, 0.15)
		local high = i % 2 == 0
		local radius = W * (high and 0.5 or 0.55)
		local y = bottom + W * (high and 0.3 or 0.1) + rng:NextNumber(-0.03, 0.03) * W
		place(s, CFrame.Angles(0, angle, 0) * CFrame.new(radius, y, 0)
			* CFrame.Angles(0, math.pi / 2 + rng:NextNumber(-0.3, 0.3), 0)
			* CFrame.Angles(0, 0, 0) * CFrame.Angles(math.rad(high and 35 or 15) * -1, 0, rng:NextNumber(-0.2, 0.2)))
	end
	group.Parent = model
	return group
end
return NestBuilder
