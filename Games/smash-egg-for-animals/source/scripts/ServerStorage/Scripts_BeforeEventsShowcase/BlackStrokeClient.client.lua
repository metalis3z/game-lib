-- BlackStrokeClient : un contour NOIR, fin, partout dans les menus (sauf l'inventaire et les réglages).
--   * cadres, boutons et images avec un fond visible : un contour noir autour (ou le leur, passé en noir)
--   * textes : un contour noir autour des lettres (ou le leur, passé en noir)
--   * épaisseur des nouveaux contours : 1,5 à 3 selon la taille (jamais trop gros) ; un contour coloré ou en dégradé devient noir uni
local Players = game:GetService("Players")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local BLACK = Color3.new(0, 0, 0)
local EXCLUDED = {PetInventoryGui = true, SettingsGui = true, InventoryButtonGui = true, TopBarGui = true, Freecam = true}

local function allowed(o)
	local screen = o:FindFirstAncestorWhichIsA("ScreenGui")
	return screen ~= nil and not EXCLUDED[screen.Name] and not o:GetAttribute("NoBlackStroke")
end
local function thicknessFor(o, isText)
	local size = o.AbsoluteSize
	local short = math.min(size.X, size.Y)
	if isText then return math.clamp(short * 0.08, 1.5, 3) end
	return short < 40 and 1.5 or (short < 120 and 2 or 2.5)
end
local function blacken(stroke, isText)
	if stroke.Transparency >= 0.9 or not stroke.Enabled then return end -- un contour caché exprès reste caché
	for _, g in stroke:GetChildren() do if g:IsA("UIGradient") then g:Destroy() end end
	stroke.Color = BLACK
	if isText then stroke.LineJoinMode = Enum.LineJoinMode.Round end -- (des coins pointus sur des lettres font des pics)
	-- (l'épaisseur d'un contour existant n'est pas touchée : certains scripts la recalculent selon la taille de l'écran)
end
local done = setmetatable({}, {__mode = "k"})
local function apply(o)
	if done[o] or not o.Parent or not allowed(o) then return end
	local isText = o:IsA("TextLabel") or o:IsA("TextButton") or o:IsA("TextBox")
	local hasBack = o.BackgroundTransparency < 0.5 and o.Name ~= "Gleam" and o.Name ~= "Edge3D" and o.Name ~= "Inner3D" and o.Name ~= "StudPattern"
	-- un calque posé SUR un cadre déjà coloré (ombre du bas, reflet, bande de couleur...) n'est pas un cadre à part :
	-- pas de contour (sinon le cadre a l'air coupé en deux)
	local parent = o.Parent
	local overlay = not o:IsA("GuiButton") and not o:IsA("ScrollingFrame") and parent and parent:IsA("GuiObject") and parent.BackgroundTransparency < 0.5
	if overlay then hasBack = false end
	-- les filets clairs à l'intérieur des boutons (Inner3D, Inner...) : retirés, ils faisaient un trait blanc
	if (o.Name == "Inner3D" or o.Name == "Inner") and o.BackgroundTransparency > 0.9 then
		for _, c in o:GetChildren() do if c:IsA("UIStroke") then c.Enabled = false end end
	end
	-- le contour du cadre
	if hasBack and (o:IsA("Frame") or o:IsA("GuiButton") or o:IsA("ImageLabel") or o:IsA("ScrollingFrame")) and o.AbsoluteSize.X > 6 and o.AbsoluteSize.Y > 6 then
		done[o] = true
		local border
		for _, c in o:GetChildren() do
			if c:IsA("UIStroke") and c.ApplyStrokeMode == Enum.ApplyStrokeMode.Border then border = c break end
		end
		if border then
			blacken(border, false)
		else
			local st = Instance.new("UIStroke")
			st.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			st.Color = BLACK
			st.Thickness = thicknessFor(o, false)
			st.Parent = o
		end
	end
	-- zone de saisie : texte blanc, contour noir fin (pas d'énorme contour)
	if o:IsA("TextBox") then
		done[o] = true
		o.TextColor3 = Color3.new(1, 1, 1)
		o.PlaceholderColor3 = Color3.fromRGB(235, 240, 255) -- (le texte d'aide aussi : blanc avec contour noir)
		for _, c in o:GetChildren() do
			if c:IsA("UIStroke") and c.ApplyStrokeMode == Enum.ApplyStrokeMode.Contextual then c:Destroy() end
		end
		local st = Instance.new("UIStroke")
		st.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
		st.LineJoinMode = Enum.LineJoinMode.Round
		st.Color = BLACK
		st.Thickness = 1
		st.Parent = o
		o:GetPropertyChangedSignal("TextColor3"):Connect(function()
			if o.TextColor3 ~= Color3.new(1, 1, 1) then o.TextColor3 = Color3.new(1, 1, 1) end
		end)
		return
	end
	-- le contour du texte
	if isText and o.Text ~= "" and o.TextTransparency < 0.9 then
		done[o] = true
		local textStroke
		for _, c in o:GetChildren() do
			if c:IsA("UIStroke") and c.ApplyStrokeMode == Enum.ApplyStrokeMode.Contextual then textStroke = c break end
		end
		if textStroke then
			blacken(textStroke, true)
		elseif not (o:IsA("GuiButton") and hasBack) then -- (un bouton avec fond a déjà son contour de cadre)
			local st = Instance.new("UIStroke")
			st.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
			st.LineJoinMode = Enum.LineJoinMode.Round
			st.Color = BLACK
			st.Thickness = thicknessFor(o, true)
			st.Parent = o
		end
	end
end
local function check(o)
	if o:IsA("UIStroke") and o.Parent and (o.Parent.Name == "Inner3D" or o.Parent.Name == "Inner") and o.Parent:IsA("GuiObject")
		and o.Parent.BackgroundTransparency > 0.9 and allowed(o) then
		o.Enabled = false -- filet clair intérieur (ajouté plus tard) : retiré aussi
	end
	if o:IsA("GuiObject") then
		task.delay(0.15, apply, o) -- (le temps que le script qui le crée finisse de le régler)
	elseif o:IsA("UIGradient") and o.Parent and o.Parent:IsA("UIStroke") and done[o.Parent.Parent] and allowed(o.Parent) then
		task.defer(function() if o.Parent then o:Destroy() end end) -- un dégradé ajouté plus tard sur un contour : reste noir
	end
end
for _, d in playerGui:GetDescendants() do check(d) end
playerGui.DescendantAdded:Connect(check)
-- les menus construits tard : un passage de rattrapage
task.delay(6, function() for _, d in playerGui:GetDescendants() do if d:IsA("GuiObject") then apply(d) end end end)
