-- Construit ReplicatedStorage.AnimalKit.Models à partir de Workspace.AnimalModels (les originaux ne sont pas modifiés).
-- Chaque copie : un nom propre et unique, le mesh en PrimaryPart, le pivot au sol sous le centre (avant = -Z),
-- pas de collision, les dossiers d'export inutiles retirés, et des attributs (Move, Height, Length, Width, OriginalName).
local RENAME = {
	["tuna"] = "Tuna", ["trumpet"] = "Trumpetfish", ["stingray"] = "Stingray", ["sailfish"] = "Sailfish", ["pufferfish"] = "Pufferfish",
	["hawkfish"] = "Hawkfish", ["cowfish"] = "Cowfish", ["barracuda"] = "Barracuda", ["archerfish"] = "Archerfish", ["wobbegong"] = "Wobbegong",
	["YI_QI"] = "YiQi", ["WINGED_IMP"] = "WingedImp", ["THUNDERBIRD"] = "Thunderbird", ["T-Rex"] = "TRex", ["STYMPHALIANBIRD"] = "StymphalianBird",
	["STEGOSAURUS"] = "Stegosaurus", ["SPHINX"] = "Sphinx", ["SIMURGH"] = "Simurgh", ["Regal"] = "RegalTang", ["ROC"] = "Roc",
	["QUETZALCOATLUS"] = "Quetzalcoatlus", ["QILIN"] = "Qilin", ["PTERODACTYL"] = "GiantPterodactyl", ["PTERANODON"] = "Pteranodon",
	["PLESIOSAUR"] = "Plesiosaur", ["Moorish idol"] = "MoorishIdol", ["MINOTAUR"] = "Minotaur", ["MICRORAPTOR"] = "Microraptor",
	["MEGALODON"] = "Megalodon", ["LEVIATHAN"] = "Leviathan", ["KRAKEN"] = "Kraken", ["GuiennaPig"] = "GuineaPig", ["GARUDA"] = "Garuda",
	["GARGOYLE_BAT"] = "GargoyleBat", ["FIREPHOENIX"] = "FirePhoenix", ["DIMETRODON"] = "Dimetrodon", ["COCKATRICE"] = "Cockatrice",
	["CALADRIUS"] = "Caladrius", ["ARGENTAVIS"] = "Argentavis", ["ARCHAEOPTERYX"] = "Archaeopteryx",
}
return function(Animator)
	local RS = game:GetService("ReplicatedStorage")
	local kit = RS:FindFirstChild("AnimalKit")
	local old = kit:FindFirstChild("Models")
	if old then old:Destroy() end
	local folder = Instance.new("Folder")
	folder.Name = "Models"
	local sources = {}
	for _, m in workspace.AnimalModels:GetDescendants() do
		if m:IsA("Model") and m:FindFirstChildWhichIsA("MeshPart") then table.insert(sources, m) end
	end
	-- les plus grands d'abord : quand deux modèles portent le même nom, le plus petit devient "...Baby"
	table.sort(sources, function(a, b) return a:FindFirstChildWhichIsA("MeshPart").Size.Magnitude > b:FindFirstChildWhichIsA("MeshPart").Size.Magnitude end)
	local report = {}
	for i, src in sources do
		local name = RENAME[src.Name] or src.Name
		if folder:FindFirstChild(name) then name ..= "Baby" end
		local m = src:Clone()
		m.Name = name
		for _, c in m:GetChildren() do
			if c.Name == "InitialPoses" or c.Name == "AnimSaves" or c:IsA("AnimationController") then c:Destroy() end
		end
		local mesh = m:FindFirstChildWhichIsA("MeshPart")
		mesh.Name = "Body"
		m.PrimaryPart = mesh
		mesh.PivotOffset = CFrame.new(0, -mesh.Size.Y / 2, 0)
		for _, p in m:GetDescendants() do
			if p:IsA("BasePart") then
				p.Anchored, p.CanCollide, p.CanTouch, p.CanQuery, p.Massless = true, false, false, false, true
			elseif p:IsA("Bone") then
				p.Transform = CFrame.new()
			end
		end
		m:SetAttribute("OriginalName", src.Name)
		m:SetAttribute("Move", Animator.Kinds[name] or "Walk")
		m:SetAttribute("Height", math.round(mesh.Size.Y * 100) / 100)
		m:SetAttribute("Width", math.round(mesh.Size.X * 100) / 100)
		m:SetAttribute("Length", math.round(mesh.Size.Z * 100) / 100)
		m:PivotTo(CFrame.new())
		m.Parent = folder
		table.insert(report, name)
		if i % 20 == 0 then task.wait() end
	end
	folder.Parent = kit
	table.sort(report)
	return report
end
