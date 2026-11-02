-- Effets de mutation (étincelles, comètes, chauves-souris, anneaux, panneaux Hacker...) créés PAR CE JOUEUR, seulement pour les
-- œufs et animaux proches de sa caméra : le serveur ne pose qu'un attribut (FxMutation, tag "MutationFxModel", TraitDeco).
-- Un modèle qui s'éloigne perd ses effets ; il les retrouve quand on revient. Au plus MAX_ACTIVE modèles en même temps (les plus proches).
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TraitDeco = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("TraitDeco"))

local NEAR, FAR = 110, 140 -- crée en dessous de NEAR, enlève au-delà de FAR (pas de clignotement à la limite)
local MAX_ACTIVE = 14
local camera = workspace.CurrentCamera
local models = {}  -- [modèle] = true
local active = {}  -- [modèle] = {objets créés}

for _, m in CollectionService:GetTagged("MutationFxModel") do models[m] = true end
CollectionService:GetInstanceAddedSignal("MutationFxModel"):Connect(function(m) models[m] = true end)

local function clear(model)
	for _, o in active[model] or {} do if o.Parent then o:Destroy() end end
	active[model] = nil
end
CollectionService:GetInstanceRemovedSignal("MutationFxModel"):Connect(function(m) models[m] = nil clear(m) end)

local function build(model)
	local root = model.PrimaryPart
	local mutation = model:GetAttribute("FxMutation")
	if not root or not mutation then return end
	local before = {}
	for _, c in root:GetChildren() do before[c] = true end
	pcall(TraitDeco.MutationFx, model, mutation)
	local made = {}
	for _, c in root:GetChildren() do if not before[c] then table.insert(made, c) end end
	active[model] = made
end

while true do
	task.wait(0.4)
	local camPos = camera.CFrame.Position
	local candidates = {}
	for model in models do
		local root = model.Parent and model.PrimaryPart
		if not root then
			if not model.Parent then models[model] = nil end
			clear(model)
		else
			local d = (root.Position - camPos).Magnitude
			if active[model] and d > FAR then clear(model)
			elseif d < NEAR then table.insert(candidates, {model, d}) end
		end
	end
	table.sort(candidates, function(a, b) return a[2] < b[2] end)
	local keep = {}
	for i, c in candidates do
		if i > MAX_ACTIVE then break end
		keep[c[1]] = true
		if not active[c[1]] then build(c[1]) end
	end
	-- trop de modèles actifs : on enlève les plus loin
	local count = 0
	for model in active do count += 1 end
	if count > MAX_ACTIVE then
		for model in active do if not keep[model] then clear(model) count -= 1 if count <= MAX_ACTIVE then break end end end
	end
end
