-- Effet "gleam" des tags : un dégradé glace (bleu) -> flamme (rouge) traversé en boucle par un éclat blanc.
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")

local ICE_DEEP, ICE, FLAME, FLAME_DEEP = Color3.fromRGB(40, 110, 255), Color3.fromRGB(120, 225, 255), Color3.fromRGB(255, 150, 40), Color3.fromRGB(255, 40, 30)
local WHITE = Color3.new(1, 1, 1)
local PERIOD = 2.4   -- secondes entre deux éclats
local WIDTH = 0.12   -- demi-largeur de l'éclat

local function base(x) -- couleur du dégradé glace -> flamme à la position x (0..1)
	if x < 0.35 then return ICE_DEEP:Lerp(ICE, x / 0.35) end
	if x < 0.65 then return ICE:Lerp(FLAME, (x - 0.35) / 0.3) end
	return FLAME:Lerp(FLAME_DEEP, (x - 0.65) / 0.35)
end

RunService.RenderStepped:Connect(function()
	local gradients = CollectionService:GetTagged("TagGleam")
	if #gradients == 0 then return end
	-- l'éclat traverse de gauche à droite, puis une courte pause
	local center = (os.clock() % PERIOD) / (PERIOD * 0.6) * (1 + WIDTH * 2) - WIDTH
	local points = {ColorSequenceKeypoint.new(0, base(0))}
	local a, b = center - WIDTH, center + WIDTH
	for _, x in {a, center, b} do
		if x > 0.001 and x < 0.999 then
			table.insert(points, ColorSequenceKeypoint.new(x, x == center and WHITE or base(x)))
		end
	end
	table.insert(points, ColorSequenceKeypoint.new(1, base(1)))
	-- quelques repères fixes pour garder le dégradé glace -> flamme entre les points
	for _, x in {0.35, 0.65} do
		if math.abs(x - center) > WIDTH + 0.01 then table.insert(points, ColorSequenceKeypoint.new(x, base(x))) end
	end
	table.sort(points, function(p, q) return p.Time < q.Time end)
	local sequence = ColorSequence.new(points)
	local tilt = 12 + math.sin(os.clock() * 1.5) * 4
	for _, gradient in gradients do
		gradient.Color = sequence
		gradient.Rotation = tilt
	end
end)
