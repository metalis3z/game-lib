-- Generated from ui/ReplicatedStorage/Templates/ItemTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextButton", nil, "ItemTemplate", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(38, 255, 0), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 5, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[2] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0, 5), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4), PaddingTop = UDim.new(0, 5) })
		I[3] = new("UIStroke", I[1], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3.5 })
		I[4] = new("UIListLayout", I[1], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[5] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint")
		I[6] = new("StringValue", I[1], "AssetType")
		I[7] = new("StringValue", I[1], "AssetName")
		I[8] = new("UIScale", I[1], "UIScale")
		I[9] = new("TextLabel", I[1], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.fromScale(0.8, 0.25), Text = "100", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[10] = new("Color3Value", I[1], "AssetColor")
		I[11] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
		I[12] = new("ImageLabel", I[1], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://11456669149"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.5, 0.5) })
			I[13] = new("UICorner", I[12], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
		I[14] = new("ViewportFrame", I[1], "ClothingViewport", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.7, 0.7) })
			I[15] = new("Model", I[14], "Rig")
				I[16] = new("Part", I[15], "Head", { Anchored = true, CFrame = CFrame.new(-29.8299561, 3.7498426, -91.182312), CanCollide = false, Color = Color3.fromRGB(223, 223, 222), EnableFluidForces = false, PivotOffset = CFrame.new(0, -4.5, 0), Size = Vector3.new(2, 1, 1), TopSurface = Enum.SurfaceType.Smooth })
					I[17] = new("SpecialMesh", I[16], "Mesh", { Scale = Vector3.new(1.25, 1.25, 1.25) })
					I[18] = new("Decal", I[16], "face", { TextureContent = Content.fromUri("rbxasset://textures/face.png") })
					I[19] = new("Attachment", I[16], "HairAttachment", { CFrame = CFrame.new(0, 0.6, 0) })
					I[20] = new("Attachment", I[16], "HatAttachment", { CFrame = CFrame.new(0, 0.6, 0) })
					I[21] = new("Attachment", I[16], "FaceFrontAttachment", { CFrame = CFrame.new(0, 0, -0.6) })
					I[22] = new("Attachment", I[16], "FaceCenterAttachment")
				I[23] = new("Part", I[15], "Torso", { Anchored = true, CFrame = CFrame.new(-29.8299561, 2.2498426, -91.182312), CanCollide = false, Color = Color3.fromRGB(223, 223, 222), EnableFluidForces = false, LeftSurface = Enum.SurfaceType.Weld, RightSurface = Enum.SurfaceType.Weld, Size = Vector3.new(2, 2, 1) })
					I[24] = new("Decal", I[23], "roblox")
					I[25] = new("Attachment", I[23], "NeckAttachment", { CFrame = CFrame.new(0, 1, 0) })
					I[26] = new("Attachment", I[23], "BodyFrontAttachment", { CFrame = CFrame.new(0, 0, -0.5) })
					I[27] = new("Attachment", I[23], "BodyBackAttachment", { CFrame = CFrame.new(0, 0, 0.5) })
					I[28] = new("Attachment", I[23], "LeftCollarAttachment", { CFrame = CFrame.new(-1, 1, 0) })
					I[29] = new("Attachment", I[23], "RightCollarAttachment", { CFrame = CFrame.new(1, 1, 0) })
					I[30] = new("Attachment", I[23], "WaistFrontAttachment", { CFrame = CFrame.new(0, -1, -0.5) })
					I[31] = new("Attachment", I[23], "WaistCenterAttachment", { CFrame = CFrame.new(0, -1, 0) })
					I[32] = new("Attachment", I[23], "WaistBackAttachment", { CFrame = CFrame.new(0, -1, 0.5) })
					I[33] = new("Motor6D", I[23], "Right Shoulder", { C0 = CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), MaxVelocity = 0.1 })
					I[34] = new("Motor6D", I[23], "Left Shoulder", { C0 = CFrame.new(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), MaxVelocity = 0.1 })
					I[35] = new("Motor6D", I[23], "Right Hip", { C0 = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), MaxVelocity = 0.1 })
					I[36] = new("Motor6D", I[23], "Left Hip", { C0 = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), MaxVelocity = 0.1 })
					I[37] = new("Motor6D", I[23], "Neck", { C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
				I[38] = new("Part", I[15], "Left Arm", { Anchored = true, CFrame = CFrame.new(-31.3299561, 2.2498426, -91.182312), CanCollide = false, Color = Color3.fromRGB(223, 223, 222), EnableFluidForces = false, Size = Vector3.new(1, 2, 1) })
					I[39] = new("Attachment", I[38], "LeftShoulderAttachment", { CFrame = CFrame.new(0, 1, 0) })
					I[40] = new("Attachment", I[38], "LeftGripAttachment", { CFrame = CFrame.new(0, -1, 0) })
				I[41] = new("Part", I[15], "Right Arm", { Anchored = true, CFrame = CFrame.new(-28.3299561, 2.2498426, -91.182312), CanCollide = false, Color = Color3.fromRGB(223, 223, 222), EnableFluidForces = false, Size = Vector3.new(1, 2, 1) })
					I[42] = new("Attachment", I[41], "RightShoulderAttachment", { CFrame = CFrame.new(0, 1, 0) })
					I[43] = new("Attachment", I[41], "RightGripAttachment", { CFrame = CFrame.new(0, -1, 0) })
				I[44] = new("Part", I[15], "Left Leg", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-30.3286057, 0.2989506, -91.1813736), CanCollide = false, Color = Color3.fromRGB(223, 223, 222), EnableFluidForces = false, Size = Vector3.new(1, 2, 1) })
					I[45] = new("Attachment", I[44], "LeftFootAttachment", { CFrame = CFrame.new(0, -1, 0) })
				I[46] = new("Part", I[15], "Right Leg", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-29.3286076, 0.2989506, -91.1813736), CanCollide = false, Color = Color3.fromRGB(223, 223, 222), EnableFluidForces = false, Size = Vector3.new(1, 2, 1) })
					I[47] = new("Attachment", I[46], "RightFootAttachment", { CFrame = CFrame.new(0, -1, 0) })
				I[48] = new("Humanoid", I[15], "Humanoid")
				I[49] = new("Part", I[15], "HumanoidRootPart", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-31.8300877, -0.7496853, -91.1813736), CanCollide = false, Color = Color3.fromRGB(223, 223, 222), EnableFluidForces = false, Size = Vector3.new(2, 2, 1), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
					I[50] = new("Attachment", I[49], "RootAttachment")
					I[51] = new("Motor6D", I[49], "RootJoint", { C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
				I[52] = new("Shirt", I[15], "Shirt")
				I[53] = new("Pants", I[15], "Pants")
	I[15].PrimaryPart = I[16]
	I[33].Part0 = I[23]
	I[33].Part1 = I[41]
	I[34].Part0 = I[23]
	I[34].Part1 = I[38]
	I[35].Part0 = I[23]
	I[35].Part1 = I[46]
	I[36].Part0 = I[23]
	I[36].Part1 = I[44]
	I[37].Part0 = I[23]
	I[37].Part1 = I[16]
	I[51].Part0 = I[49]
	I[51].Part1 = I[23]
	return I[1]
end

return build
