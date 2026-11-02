-- Tapis de course des autres joueurs : on ne voit le tapis d'une base (avec son panneau et son enseigne d'amélioration)
-- que quand son propriétaire est dessus (attribut OnTreadmill, posé par SpeedServer). Le sien reste toujours visible.
-- Une base sans propriétaire n'a pas de tapis visible. Caché = invisible et traversable, seulement chez ce joueur.
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PIECES = {"Treadmill", "TreadmillBoard", "UpgradeSign"}

local saved = setmetatable({}, {__mode = "k"}) -- [objet] = ses valeurs d'origine
local hiddenBases = {}                         -- [base] = true quand son tapis est caché

local function setHidden(obj, hidden)
	if obj:IsA("BasePart") then
		if hidden then
			saved[obj] = saved[obj] or {Transparency = obj.Transparency, CanCollide = obj.CanCollide}
			obj.Transparency, obj.CanCollide = 1, false
		elseif saved[obj] then
			obj.Transparency, obj.CanCollide = saved[obj].Transparency, saved[obj].CanCollide
			saved[obj] = nil
		end
	elseif obj:IsA("Decal") or obj:IsA("Texture") then
		if hidden then
			saved[obj] = saved[obj] or {Transparency = obj.Transparency}
			obj.Transparency = 1
		elseif saved[obj] then
			obj.Transparency = saved[obj].Transparency
			saved[obj] = nil
		end
	elseif obj:IsA("SurfaceGui") or obj:IsA("BillboardGui") or obj:IsA("ParticleEmitter") or obj:IsA("Light") or obj:IsA("Beam") or obj:IsA("Trail") then
		if hidden then
			if saved[obj] == nil then saved[obj] = {Enabled = obj.Enabled} end
			obj.Enabled = false
		elseif saved[obj] then
			obj.Enabled = saved[obj].Enabled
			saved[obj] = nil
		end
	end
end

local function apply(base, hidden)
	for _, name in PIECES do
		local piece = base:FindFirstChild(name)
		if piece then
			if piece:IsA("BasePart") then setHidden(piece, hidden) end
			for _, d in piece:GetDescendants() do setHidden(d, hidden) end
		end
	end
end

local function ownerOf(base)
	local number = tonumber(string.match(base.Name, "%d+"))
	for _, p in Players:GetPlayers() do
		if p:GetAttribute("BaseNumber") == number then return p end
	end
	return nil
end

local function update()
	local bases = workspace:FindFirstChild("all base")
	if not bases then return end
	for _, base in bases:GetChildren() do
		local owner = ownerOf(base)
		local hidden = owner ~= player and not (owner and owner:GetAttribute("OnTreadmill"))
		if hidden or hiddenBases[base] then -- (re)applique : le serveur peut reconstruire le tapis quand il monte de niveau
			apply(base, hidden)
		end
		hiddenBases[base] = hidden or nil
	end
end

local function watchPlayer(p)
	p:GetAttributeChangedSignal("OnTreadmill"):Connect(update)
	p:GetAttributeChangedSignal("BaseNumber"):Connect(update)
end
Players.PlayerAdded:Connect(function(p) watchPlayer(p) update() end)
Players.PlayerRemoving:Connect(function() task.defer(update) end)
for _, p in Players:GetPlayers() do watchPlayer(p) end
update()
while true do -- filet de sécurité : pièces arrivées plus tard (streaming, tapis reconstruit)
	task.wait(2)
	update()
end
