-- Animation de repos de la sorcière du spawn (Workspace.Sorciere), jouée sur chaque client :
-- elle respire, agite sa baguette en mouvements fluides (traînée violette) et éclate de rire de temps en temps.
-- Pendant l'event Witch Time (attribut "Busy"), c'est le serveur qui l'anime : on remet tout en place et on attend.
local RunService = game:GetService("RunService")
local witch = workspace:WaitForChild("Sorciere")
local ARM = {Epaule = true, HautBras = true, Manche = true, Poignet = true, AvantBras = true, Poing = true, Pouce = true, Baguette = true, BaguetteAnneau = true, BaguetteEtoile = true}
local NECK, SHOULDER = Vector3.new(0, -1.1, 0), Vector3.new(1.75, -1.7, 0)
local LAUGH_EVERY, LAUGH_TIME = 7, 1.9

local parts, rootCF, laughGui
local function capture()
	local root = witch.PrimaryPart
	if not root or not witch:FindFirstChild("BaguetteEtoile", true) then return false end
	rootCF = root.CFrame
	parts = {}
	local balai = witch:FindFirstChild("Balai")
	for _, d in witch:GetDescendants() do
		if d:IsA("BasePart") then
			local r = rootCF:PointToObjectSpace(d.Position)
			local group = "Body"
			if balai and d:IsDescendantOf(balai) then group = "Body"
			elseif ARM[d.Name] and r.X > 0 then group = "Arm"
			elseif r.Y > -0.95 then group = "Head" end
			table.insert(parts, {Part = d, Base = d.CFrame, Group = group})
		end
	end
	laughGui = root:FindFirstChild("WitchLaugh")
	return #parts > 20
end
local function restore()
	if not parts then return end
	for _, p in parts do
		if p.Part.Parent then p.Part.CFrame = p.Base end
	end
	parts = nil
	if laughGui then laughGui.Enabled = false end
end

local function about(pivot, rotation) -- rotation autour d'un point donné dans le repère de la tête
	return rootCF * CFrame.new(pivot) * rotation * CFrame.new(-pivot) * rootCF:Inverse()
end

local waitUntil = 0
witch:GetAttributeChangedSignal("Busy"):Connect(function()
	restore()
	waitUntil = os.clock() + 2.5 -- le serveur finit de la reposer avant qu'on reprenne
end)

RunService.RenderStepped:Connect(function()
	if witch:GetAttribute("Busy") or os.clock() < waitUntil then return end
	if not parts and not capture() then
		waitUntil = os.clock() + 1
		return
	end
	local camera = workspace.CurrentCamera
	if (camera.CFrame.Position - rootCF.Position).Magnitude > 320 then return end
	local t = os.clock()
	local phase = t % LAUGH_EVERY
	local laugh = phase < LAUGH_TIME and math.sin(math.pi * phase / LAUGH_TIME) or 0
	local whole = CFrame.new(0, math.sin(t * 1.6) * 0.07 + laugh * math.abs(math.sin(t * 15)) * 0.09, 0)
	local head = about(NECK, CFrame.Angles(math.rad(9 * laugh + 2 * math.sin(t * 1.3)), math.rad(7 * math.sin(t * 0.7)), math.rad(3 * math.sin(t * 15) * laugh)))
	-- bras droit : la baguette dessine un huit, plus haut et plus vite quand elle rit
	local arm = about(SHOULDER, CFrame.Angles(math.rad(-18 + 20 * math.sin(t * 1.9) - 30 * laugh), math.rad(20 * math.sin(t * 0.95)), math.rad(-14 * math.sin(t * 1.9 + 1.2))))
	for _, p in parts do
		local part = p.Part
		if p.Group == "Head" then part.CFrame = whole * head * p.Base
		elseif p.Group == "Arm" then part.CFrame = whole * arm * p.Base
		else part.CFrame = whole * p.Base end
	end
	if laughGui then
		laughGui.Enabled = laugh > 0.05
		laughGui.StudsOffset = Vector3.new(3.2, 3.2 + laugh * 0.8, 0)
		laughGui.Label.Rotation = math.sin(t * 15) * 6
	end
end)
