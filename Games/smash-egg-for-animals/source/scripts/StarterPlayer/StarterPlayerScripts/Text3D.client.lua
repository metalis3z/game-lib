-- Effet 3D sur les textes à contour : le texte d'origine devient l'ombre noire, et une copie ("Face3D") est dessinée
-- juste au-dessus, décalée vers le haut. Résultat : un contour plus épais en bas, comme un texte en relief.
-- Les scripts continuent de modifier le texte d'origine (Text, TextColor3...) : tout est recopié sur la face.
local Players = game:GetService("Players")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local BLACK = Color3.new(0, 0, 0)
local SYNCED = {"Text", "FontFace", "TextSize", "TextScaled", "TextWrapped", "RichText", "TextXAlignment", "TextYAlignment", "TextTransparency", "TextTruncate", "LineHeight", "MaxVisibleGraphemes"}
local done = setmetatable({}, {__mode = "k"})

local function textStroke(label)
	for _, c in label:GetChildren() do
		if c:IsA("UIStroke") and c.ApplyStrokeMode == Enum.ApplyStrokeMode.Contextual and c.Thickness >= 1.5 and c.Enabled then return c end
	end
end

local function setup(label)
	if done[label] or label.Name == "Face3D" or label:GetAttribute("No3D") then return end
	if not (label:IsA("TextLabel") or label:IsA("TextButton")) then return end
	local stroke = textStroke(label)
	if not stroke then return end
	if label:FindFirstChildWhichIsA("UIListLayout") or label:FindFirstChildWhichIsA("UIGridLayout") then return end
	done[label] = true

	local face = label:FindFirstChild("Face3D")
	if not face then -- (un clone d'un texte déjà traité garde sa face : on la réutilise)
		face = Instance.new("TextLabel")
		face.Name = "Face3D"
		face.BackgroundTransparency = 1
		face.Active = false
		face.TextColor3 = label.TextColor3
		for _, c in label:GetChildren() do
			if c:IsA("UIGradient") then
				if label.BackgroundTransparency >= 1 then -- dégradé de texte : il passe sur la face
					c:Clone().Parent = face
					c.Enabled = false
				end
			elseif c:IsA("UITextSizeConstraint") or c:IsA("UIPadding") then
				c:Clone().Parent = face
			end
		end
		local faceStroke = stroke:Clone()
		faceStroke.Color = BLACK
		faceStroke.Parent = face
		face.Parent = label
	end
	face.ZIndex = label.ZIndex
	stroke.Color = BLACK
	label.TextColor3 = BLACK

	local function layout()
		local padding = label:FindFirstChildWhichIsA("UIPadding")
		local l, r, t, b = 0, 0, 0, 0
		if padding then
			local size = label.AbsoluteSize
			l = padding.PaddingLeft.Offset + padding.PaddingLeft.Scale * size.X
			r = padding.PaddingRight.Offset + padding.PaddingRight.Scale * size.X
			t = padding.PaddingTop.Offset + padding.PaddingTop.Scale * size.Y
			b = padding.PaddingBottom.Offset + padding.PaddingBottom.Scale * size.Y
		end
		local textHeight = math.min(label.TextBounds.Y, label.AbsoluteSize.Y)
		local lines = math.max(1, math.floor(label.TextBounds.Y / math.max(label.TextSize, 1) + 0.3))
		if label.TextScaled then lines = 1 end
		local depth = math.clamp(math.floor(textHeight / lines * 0.09 + 0.5), 2, 6)
		face.Size = UDim2.new(1, l + r, 1, t + b)
		face.Position = UDim2.fromOffset(-l, -t - depth)
	end
	for _, property in SYNCED do
		face[property] = label[property]
		label:GetPropertyChangedSignal(property):Connect(function() face[property] = label[property] end)
	end
	label:GetPropertyChangedSignal("TextColor3"):Connect(function()
		if label.TextColor3 ~= BLACK then
			face.TextColor3 = label.TextColor3
			label.TextColor3 = BLACK
		end
	end)
	label:GetPropertyChangedSignal("ZIndex"):Connect(function() face.ZIndex = label.ZIndex end)
	label:GetPropertyChangedSignal("AbsoluteSize"):Connect(layout)
	label:GetPropertyChangedSignal("TextBounds"):Connect(layout)
	layout()
end

local function check(instance)
	if instance:IsA("UIStroke") then
		if instance.Parent then task.defer(setup, instance.Parent) end
	elseif instance:IsA("TextLabel") or instance:IsA("TextButton") then
		task.defer(setup, instance)
	end
end
for _, d in playerGui:GetDescendants() do check(d) end
playerGui.DescendantAdded:Connect(check)

-- textes du monde (panneaux, étiquettes des œufs et des gardiens) : le serveur les marque du tag "Text3D"
local CollectionService = game:GetService("CollectionService")
local function tagged(label)
	task.delay(0.1, setup, label)
	task.delay(1.5, setup, label) -- nouvel essai si le contour n'était pas encore arrivé
end
CollectionService:GetInstanceAddedSignal("Text3D"):Connect(tagged)
for _, label in CollectionService:GetTagged("Text3D") do tagged(label) end
