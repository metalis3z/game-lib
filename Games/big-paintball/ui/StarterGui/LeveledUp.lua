-- Generated from ui/StarterGui/LeveledUp.rbxm by _tools/rbxm2lua.luau
-- UI builder: local gui = require(this)(); gui.Parent = game.Players.LocalPlayer.PlayerGui (or StarterGui)

local function new(class, parent, name, props, attrs, tags)
	local o = Instance.new(class)
	o.Name = name
	if props then
		for k, v in props do
			o[k] = v
		end
	end
	if attrs then
		for k, v in attrs do
			o:SetAttribute(k, v)
		end
	end
	if tags then
		for _, t in tags do
			o:AddTag(t)
		end
	end
	if parent then
		o.Parent = parent
	end
	return o
end

local function build()
	local I = {}
	I[1] = new("ScreenGui", nil, "LeveledUp", { Enabled = false, ResetOnSpawn = false })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0.5, 4), Size = UDim2.new(0.1, 75, 0.2, 75) })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint")
			I[4] = new("ViewportFrame", I[2], "Main", { Ambient = Color3.fromRGB(255, 255, 255), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(0.8, 0.8), ZIndex = 2 })
				I[5] = new("Part", I[4], "Star", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(0, 0, -25), CanCollide = false, CastShadow = false, Color = Color3.fromRGB(32, 151, 241), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(2.165, 2.165, 0.506), TopSurface = Enum.SurfaceType.Smooth })
					I[6] = new("SpecialMesh", I[5], "Mesh", { MeshContent = Content.fromUri("rbxassetid://3130562443"), MeshType = Enum.MeshType.FileMesh, Scale = Vector3.new(3.5, 3.5, 3.5) })
					I[7] = new("Attachment", I[5], "Attachment")
						I[8] = new("ParticleEmitter", I[7], "ParticleEmitter", { Lifetime = NumberRange.new(2, 4), LightEmission = 1, LightInfluence = 0.5, LockedToPart = true, Rate = 1, RotSpeed = NumberRange.new(-30, 30), Rotation = NumberRange.new(0, 360), Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 2, 1.125), NumberSequenceKeypoint.new(1, 2.25, 1.125) }), Speed = NumberRange.new(0, 0), TextureContent = Content.fromUri("rbxassetid://3048452041"), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.216992, 0.75625, 0.05), NumberSequenceKeypoint.new(0.425947, 0.46875, 0.1375), NumberSequenceKeypoint.new(0.598163, 0.56875, 0.125), NumberSequenceKeypoint.new(0.783008, 0.7125, 0.06875), NumberSequenceKeypoint.new(0.893226, 0.875), NumberSequenceKeypoint.new(1, 1) }) })
			I[9] = new("ViewportFrame", I[2], "Reflectance", { Ambient = Color3.fromRGB(255, 255, 255), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(0.8, 0.8), ZIndex = 3 })
				I[10] = new("UIGradient", I[9], "UIGradient", { Offset = Vector2.new(-1, 0), Rotation = 45, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.399541, 0.75), NumberSequenceKeypoint.new(0.518944, 0.5375), NumberSequenceKeypoint.new(0.6969, 0.75), NumberSequenceKeypoint.new(1, 1) }) })
				I[11] = new("Part", I[9], "Star", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(0, 0, -25), CanCollide = false, CastShadow = false, Color = Color3.fromRGB(241, 241, 241), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(2.165, 2.165, 0.506), TopSurface = Enum.SurfaceType.Smooth })
					I[12] = new("SpecialMesh", I[11], "Mesh", { MeshContent = Content.fromUri("rbxassetid://3130562443"), MeshType = Enum.MeshType.FileMesh, Scale = Vector3.new(3.5, 3.5, 3.5) })
					I[13] = new("Attachment", I[11], "Attachment")
						I[14] = new("ParticleEmitter", I[13], "ParticleEmitter", { Lifetime = NumberRange.new(2, 4), LightEmission = 1, LightInfluence = 0.5, LockedToPart = true, Rate = 1, RotSpeed = NumberRange.new(-30, 30), Rotation = NumberRange.new(0, 360), Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 2, 1.125), NumberSequenceKeypoint.new(1, 2.25, 1.125) }), Speed = NumberRange.new(0, 0), TextureContent = Content.fromUri("rbxassetid://3048452041"), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.216992, 0.75625, 0.05), NumberSequenceKeypoint.new(0.425947, 0.46875, 0.1375), NumberSequenceKeypoint.new(0.598163, 0.56875, 0.125), NumberSequenceKeypoint.new(0.783008, 0.7125, 0.06875), NumberSequenceKeypoint.new(0.893226, 0.875), NumberSequenceKeypoint.new(1, 1) }) })
			I[15] = new("ViewportFrame", I[2], "Shadow", { Ambient = Color3.fromRGB(0, 0, 0), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), LightColor = Color3.fromRGB(0, 0, 0), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(0.8, 0.8) })
				I[16] = new("Part", I[15], "Star", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(0, 0, -23), CanCollide = false, CastShadow = false, Color = Color3.fromRGB(241, 241, 241), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(2.165, 2.165, 0.506), TopSurface = Enum.SurfaceType.Smooth })
					I[17] = new("SpecialMesh", I[16], "Mesh", { MeshContent = Content.fromUri("rbxassetid://3130562443"), MeshType = Enum.MeshType.FileMesh, Scale = Vector3.new(3.5, 3.5, 3.5) })
					I[18] = new("Attachment", I[16], "Attachment")
						I[19] = new("ParticleEmitter", I[18], "ParticleEmitter", { Lifetime = NumberRange.new(2, 4), LightEmission = 1, LightInfluence = 0.5, LockedToPart = true, Rate = 1, RotSpeed = NumberRange.new(-30, 30), Rotation = NumberRange.new(0, 360), Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 2, 1.125), NumberSequenceKeypoint.new(1, 2.25, 1.125) }), Speed = NumberRange.new(0, 0), TextureContent = Content.fromUri("rbxassetid://3048452041"), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.216992, 0.75625, 0.05), NumberSequenceKeypoint.new(0.425947, 0.46875, 0.1375), NumberSequenceKeypoint.new(0.598163, 0.56875, 0.125), NumberSequenceKeypoint.new(0.783008, 0.7125, 0.06875), NumberSequenceKeypoint.new(0.893226, 0.875), NumberSequenceKeypoint.new(1, 1) }) })
			I[20] = new("TextLabel", I[2], "BottomText", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.515, 1.025), Size = UDim2.fromScale(0.9, 0.1), Text = "LEVELED UP!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 20, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
				I[21] = new("TextLabel", I[20], "shadow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(2, 2), Size = UDim2.fromScale(1, 1), Text = "LEVELED UP!", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 20, TextStrokeTransparency = 0, TextWrapped = true })
				I[22] = new("UIScale", I[20], "UIScale")
			I[23] = new("TextLabel", I[2], "Rank", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.475), Size = UDim2.fromScale(0.9, 0.2), Text = "24", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 20, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
				I[24] = new("TextLabel", I[23], "shadow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(2, 2), Size = UDim2.fromScale(1, 1), Text = "24", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 20, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 2 })
				I[25] = new("UIScale", I[23], "UIScale")
	return I[1]
end

return build
