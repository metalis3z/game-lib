-- Generated from map/lighting.rbxm by _tools/rbxm2lua.luau
-- Lighting pack: for _, o in require(this)() do o.Parent = game.Lighting end (Lighting properties are in Environment.lua)

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
	I[1] = new("Tool", nil, "AK47", { CanBeDropped = false, Grip = CFrame.new(0.2, -0.1, 0.4, 0.9701425, 0, 0.2425356, 0, 1, 0, -0.2425356, 0, 0.9701425), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=122079896"), ToolTip = "AK47" })
		I[2] = new("Part", I[1], "Handle", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-14.7498312, 0.5, 14.2994595, 0, 0, -1, 0, 1, 0, 1, 0, 0), Color = Color3.fromRGB(27, 42, 53), Size = Vector3.new(0.2, 1, 4), TopSurface = Enum.SurfaceType.Smooth })
			I[3] = new("Sound", I[2], "FireSound", { Volume = 1 })
			I[4] = new("Sound", I[2], "Reload", { Volume = 1 })
			I[5] = new("Sound", I[2], "EquipSound", { Volume = 1 })
			I[6] = new("PointLight", I[2], "Flash", { Brightness = 1.5, Color = Color3.fromRGB(255, 255, 0), Enabled = false })
			I[7] = new("Sound", I[2], "Tick", { Volume = 1 })
			I[8] = new("SpecialMesh", I[2], "Mesh", { MeshContent = Content.fromUri("http://www.roblox.com/asset/?id=3824749"), MeshType = Enum.MeshType.FileMesh, Scale = Vector3.new(2.5, 1.5, 1.3), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=3824746") })
		I[9] = new("Animation", I[1], "Recoil", { AnimationContent = Content.fromUri("http://www.roblox.com/Asset?ID=94331086") })
		I[10] = new("ScreenGui", I[1], "WeaponHud")
			I[11] = new("Frame", I[10], "Crosshair", { BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(500, 500), Size = UDim2.fromOffset(150, 150) })
				I[12] = new("Frame", I[11], "TopFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, -1, -0.5, -7), Size = UDim2.fromOffset(2, 14) })
				I[13] = new("Frame", I[11], "RightFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0.5, -7, 0, -1), Size = UDim2.fromOffset(14, 2) })
				I[14] = new("Frame", I[11], "LeftFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(-0.5, -7, 0, -1), Size = UDim2.fromOffset(14, 2) })
				I[15] = new("ImageLabel", I[11], "TargetHitImage", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=115400215"), Position = UDim2.fromOffset(-25, -25), Size = UDim2.fromOffset(50, 50), Visible = false })
				I[16] = new("TextLabel", I[11], "ReloadingLabel", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, -20), Text = "Reloading", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false })
				I[17] = new("Frame", I[11], "BottomFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, -1, 0.5, -7), Size = UDim2.fromOffset(2, 14) })
			I[18] = new("Frame", I[10], "Reload", { BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(1, -265, 1, -120), Size = UDim2.fromOffset(200, 100) })
				I[19] = new("TextLabel", I[18], "Reload", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -10, 0.5, 0), Text = "Press R to Reload", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8 })
			I[20] = new("Frame", I[10], "AmmoHud", { BackgroundColor3 = Color3.fromRGB(255, 170, 127), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.05), Size = UDim2.fromScale(1, 1) })
				I[21] = new("TextLabel", I[20], "FowardSlash", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -235, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "/", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[22] = new("TextLabel", I[20], "TotalAmmo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -178, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "999", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[23] = new("TextLabel", I[20], "ClipAmmo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -250, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "10", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[24] = new("Frame", I[20], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -198, 1, -120), Size = UDim2.fromOffset(125, 2) })
				I[25] = new("Frame", I[20], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -273, 1, -188), Rotation = 60, Size = UDim2.fromOffset(30, 2) })
				I[26] = new("Frame", I[20], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -252, 1, -175), Size = UDim2.fromOffset(200, 2) })
				I[27] = new("Frame", I[20], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -120, 1, -127), Rotation = 110, Size = UDim2.fromOffset(100, 2) })
				I[28] = new("Frame", I[20], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -162, 1, -81), Size = UDim2.fromOffset(75, 2) })
	I[29] = new("Tool", nil, "AUG", { CanBeDropped = false, Grip = CFrame.new(0.2, -0.4, 0.2, 0.9701425, 0, 0.2425356, 0, 1, 0, -0.2425356, 0, 0.9701425), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=122079912"), ToolTip = "Steyr AUG" })
		I[30] = new("Part", I[29], "Handle", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(154.577652, 0.5, 122.5299454, 0, 0, -1, 0, 1, 0, 1, 0, 0), Color = Color3.fromRGB(27, 42, 53), Size = Vector3.new(0.2, 1, 3.5999999), TopSurface = Enum.SurfaceType.Smooth })
			I[31] = new("Sound", I[30], "FireSound", { Volume = 1 })
			I[32] = new("Sound", I[30], "Reload", { Volume = 1 })
			I[33] = new("Sound", I[30], "EquipSound", { Volume = 1 })
			I[34] = new("PointLight", I[30], "Flash", { Brightness = 1.5, Color = Color3.fromRGB(255, 255, 0), Enabled = false })
			I[35] = new("Sound", I[30], "Tick", { Volume = 1 })
			I[36] = new("SpecialMesh", I[30], "Mesh", { MeshContent = Content.fromUri("http://www.roblox.com/asset/?id=3824738"), MeshType = Enum.MeshType.FileMesh, Scale = Vector3.new(1.33, 1.33, 1.33), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=3824735") })
		I[37] = new("Animation", I[29], "Recoil", { AnimationContent = Content.fromUri("http://www.roblox.com/Asset?ID=94331086") })
		I[38] = new("ScreenGui", I[29], "WeaponHud")
			I[39] = new("Frame", I[38], "Crosshair", { BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(500, 500), Size = UDim2.fromOffset(150, 150) })
				I[40] = new("Frame", I[39], "TopFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, -1, -0.5, -7), Size = UDim2.fromOffset(2, 14) })
				I[41] = new("Frame", I[39], "RightFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0.5, -7, 0, -1), Size = UDim2.fromOffset(14, 2) })
				I[42] = new("Frame", I[39], "LeftFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(-0.5, -7, 0, -1), Size = UDim2.fromOffset(14, 2) })
				I[43] = new("ImageLabel", I[39], "TargetHitImage", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=115400215"), Position = UDim2.fromOffset(-25, -25), Size = UDim2.fromOffset(50, 50), Visible = false })
				I[44] = new("TextLabel", I[39], "ReloadingLabel", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, -20), Text = "Reloading", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false })
				I[45] = new("Frame", I[39], "BottomFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, -1, 0.5, -7), Size = UDim2.fromOffset(2, 14) })
			I[46] = new("Frame", I[38], "Reload", { BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(1, -265, 1, -120), Size = UDim2.fromOffset(200, 100) })
				I[47] = new("TextLabel", I[46], "Reload", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -10, 0.5, 0), Text = "Press R to Reload", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8 })
			I[48] = new("Frame", I[38], "AmmoHud", { BackgroundColor3 = Color3.fromRGB(255, 170, 127), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.05), Size = UDim2.fromScale(1, 1) })
				I[49] = new("TextLabel", I[48], "FowardSlash", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -235, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "/", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[50] = new("TextLabel", I[48], "TotalAmmo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -178, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "999", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[51] = new("TextLabel", I[48], "ClipAmmo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -250, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "10", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[52] = new("Frame", I[48], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -198, 1, -120), Size = UDim2.fromOffset(125, 2) })
				I[53] = new("Frame", I[48], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -273, 1, -188), Rotation = 60, Size = UDim2.fromOffset(30, 2) })
				I[54] = new("Frame", I[48], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -252, 1, -175), Size = UDim2.fromOffset(200, 2) })
				I[55] = new("Frame", I[48], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -120, 1, -127), Rotation = 110, Size = UDim2.fromOffset(100, 2) })
				I[56] = new("Frame", I[48], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -162, 1, -81), Size = UDim2.fromOffset(75, 2) })
	I[57] = new("Tool", nil, "AdvancedMinigun", { Grip = CFrame.new(0, -0.2, 0.1), TextureContent = Content.fromUri("http://www.roblox.com/asset/?ID=98029614") })
		I[58] = new("Part", I[57], "Handle", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(161.9300079, 0.6, 122.3299561, 0, 0, -1, 0, 1, 0, 1, 0, 0), Color = Color3.fromRGB(27, 42, 53), Size = Vector3.new(1, 1, 4.3400002), TopSurface = Enum.SurfaceType.Smooth })
			I[59] = new("Sound", I[58], "FireSound", { Volume = 0.3 })
			I[60] = new("SpecialMesh", I[58], "Mesh", { MeshContent = Content.fromUri("http://www.roblox.com/asset?id=166887618"), MeshType = Enum.MeshType.FileMesh, TextureContent = Content.fromUri("http://www.roblox.com/asset?id=166887676") })
		I[61] = new("Animation", I[57], "Recoil", { AnimationContent = Content.fromUri("http://www.roblox.com/Asset?ID=89289443") })
		I[62] = new("ScreenGui", I[57], "WeaponHud")
			I[63] = new("Frame", I[62], "Crosshair", { BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(500, 500), Size = UDim2.fromOffset(150, 150) })
				I[64] = new("Frame", I[63], "TopFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, -1, -0.5, -7), Size = UDim2.fromOffset(2, 14) })
				I[65] = new("Frame", I[63], "RightFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0.5, -7, 0, -1), Size = UDim2.fromOffset(14, 2) })
				I[66] = new("Frame", I[63], "LeftFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(-0.5, -7, 0, -1), Size = UDim2.fromOffset(14, 2) })
				I[67] = new("ImageLabel", I[63], "TargetHitImage", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=115400215"), Position = UDim2.fromOffset(-25, -25), Size = UDim2.fromOffset(50, 50), Visible = false })
				I[68] = new("TextLabel", I[63], "ReloadingLabel", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, -20), Text = "Reloading", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false })
				I[69] = new("Frame", I[63], "BottomFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, -1, 0.5, -7), Size = UDim2.fromOffset(2, 14) })
			I[70] = new("Frame", I[62], "Reload", { BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(1, -265, 1, -120), Size = UDim2.fromOffset(200, 100) })
				I[71] = new("TextLabel", I[70], "Reload", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -10, 0.5, 0), Text = "Press R to Reload", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8 })
			I[72] = new("Frame", I[62], "AmmoHud", { BackgroundColor3 = Color3.fromRGB(255, 170, 127), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.05), Size = UDim2.fromScale(1, 1) })
				I[73] = new("TextLabel", I[72], "FowardSlash", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -235, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "/", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[74] = new("TextLabel", I[72], "TotalAmmo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -178, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "999", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[75] = new("TextLabel", I[72], "ClipAmmo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -250, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "10", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[76] = new("Frame", I[72], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -198, 1, -120), Size = UDim2.fromOffset(125, 2) })
				I[77] = new("Frame", I[72], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -273, 1, -188), Rotation = 60, Size = UDim2.fromOffset(30, 2) })
				I[78] = new("Frame", I[72], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -252, 1, -175), Size = UDim2.fromOffset(200, 2) })
				I[79] = new("Frame", I[72], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -120, 1, -127), Rotation = 110, Size = UDim2.fromOffset(100, 2) })
				I[80] = new("Frame", I[72], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -162, 1, -81), Size = UDim2.fromOffset(75, 2) })
	I[81] = new("Tool", nil, "Airstrike", { Grip = CFrame.new(-0.3292372, -0.5762643, 0.1572759, -0.2923717, 0, -0.9563047, 0.0999611, 0.9945219, -0.0305612, 0.951066, -0.1045285, -0.2907701), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=88743128"), ToolTip = "Call in an airstrike on a designated location." })
		I[82] = new("Part", I[81], "Handle", { CFrame = CFrame.new(380.6000061, 100.5, -53.1999969), Reflectance = 0.35, Size = Vector3.new(0.8, 2.3, 0.4) })
			I[83] = new("SpecialMesh", I[82], "Mesh", { MeshContent = Content.fromUri("http://www.roblox.com/asset/?id=88742707"), MeshType = Enum.MeshType.FileMesh, TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=88742969") })
			I[84] = new("Sound", I[82], "Sound", { Volume = 1 })
		I[85] = new("NumberValue", I[81], "LastStrike")
	I[86] = new("Tool", nil, "Bow", { CanBeDropped = false, Grip = CFrame.new(-0.5, -0.25, 0.6, -0.0000001, 1, 0, -0.9805807, -0.0000001, -0.1961161, -0.1961161, 0, 0.9805807), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=126856749"), ToolTip = "Bow" })
		I[87] = new("Part", I[86], "Handle", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(304.8899841, 4.3300061, 151.6799927, 0, -1, 0, 1, 0, 0, 0, 0, 1), Color = Color3.fromRGB(255, 255, 0), Locked = true, Size = Vector3.new(5, 0.3, 2), TopSurface = Enum.SurfaceType.Smooth })
			I[88] = new("Sound", I[87], "FireSound")
			I[89] = new("SpecialMesh", I[87], "Mesh", { MeshContent = Content.fromUri("http://www.roblox.com/asset/?id=111502843"), MeshType = Enum.MeshType.FileMesh, Scale = Vector3.new(0.7, 0.7, 0.7) })
			I[90] = new("Sound", I[87], "EquipSound", { Volume = 1 })
			I[91] = new("Sound", I[87], "Reload", { Volume = 1 })
			I[92] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0000002, 0.9999999, 0, -0.915669, 0.0000002, 0.401933, 0.401933, -0.0000001, 0.9156691), C1 = CFrame.new(0, 0, 0, 0.0000002, 0.9999999, 0, -0.915669, 0.0000002, 0.401933, 0.401933, -0.0000001, 0.9156691) })
			I[93] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0000048, 1.0000002, -0.0000002, -0.9913892, -0.0000048, -0.1309502, -0.1309502, -0.0000004, 0.9913889), C1 = CFrame.new(-0.0699141, -0.0000343, 0.4499092, 0.0001115, 0.9999941, 0.0000071, -0.991384, 0.0001115, -0.1309431, -0.1309431, 0.0000068, 0.9913898) })
			I[94] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, -1), C1 = CFrame.new(0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, -1) })
			I[95] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, -1), C1 = CFrame.new(0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, -1) })
			I[96] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.6926183, -0.0742141, 0.7174758, 0.7194599, 0.0000001, 0.6945337, -0.0515441, 0.9972421, 0.0533943), C1 = CFrame.new(0, 0, 0, -0.6926183, -0.0742141, 0.7174758, 0.7194599, 0.0000001, 0.6945337, -0.0515441, 0.9972421, 0.0533943) })
			I[97] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.6926183, -0.0742141, 0.7174758, 0.7194599, 0.0000001, 0.6945337, -0.0515441, 0.9972421, 0.0533943), C1 = CFrame.new(0, 0, 0, -0.6926183, -0.0742141, 0.7174758, 0.7194599, 0.0000001, 0.6945337, -0.0515441, 0.9972421, 0.0533943) })
			I[98] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0000196, 0.9999973, 0.0000064, -0.749489, 0.0000196, -0.6620127, -0.6620127, 0.0000064, 0.7494917), C1 = CFrame.new(0, 0, 0, 0.0000196, 0.9999973, 0.0000064, -0.749489, 0.0000196, -0.6620127, -0.6620127, 0.0000064, 0.7494917) })
			I[99] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0000196, 0.9999973, 0.0000064, -0.749489, 0.0000196, -0.6620127, -0.6620127, 0.0000064, 0.7494917), C1 = CFrame.new(0, 0, 0, 0.0000196, 0.9999973, 0.0000064, -0.749489, 0.0000196, -0.6620127, -0.6620127, 0.0000064, 0.7494917) })
			I[100] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.8318173, 0.0624515, -0.5515249, -0.5526039, 0.0000056, -0.8334435, -0.052047, 0.9980476, 0.0345157), C1 = CFrame.new(0, 0, 0, 0.8318173, 0.0624515, -0.5515249, -0.5526039, 0.0000056, -0.8334435, -0.052047, 0.9980476, 0.0345157) })
			I[101] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.8318173, 0.0624515, -0.5515249, -0.5526039, 0.0000056, -0.8334435, -0.052047, 0.9980476, 0.0345157), C1 = CFrame.new(0, 0, 0, 0.8318173, 0.0624515, -0.5515249, -0.5526039, 0.0000056, -0.8334435, -0.052047, 0.9980476, 0.0345157) })
			I[102] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0000076, 0.9999988, 0.000003, -0.6758231, 0.0000077, -0.7370622, -0.7370622, 0.0000027, 0.6758243), C1 = CFrame.new(0, 0, 0, 0.0000076, 0.9999988, 0.000003, -0.6758231, 0.0000077, -0.7370622, -0.7370622, 0.0000027, 0.6758243) })
			I[103] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0000076, 0.9999988, 0.000003, -0.6758231, 0.0000077, -0.7370622, -0.7370622, 0.0000027, 0.6758243), C1 = CFrame.new(0, 0, 0, 0.0000076, 0.9999988, 0.000003, -0.6758231, 0.0000077, -0.7370622, -0.7370622, 0.0000027, 0.6758243) })
			I[104] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.7788386, 0.0229184, -0.6268008, -0.6112946, -0.196007, -0.7667254, -0.1404399, 0.9803181, -0.1386442), C1 = CFrame.new(0, 0, 0, 0.7788386, 0.0229184, -0.6268008, -0.6112946, -0.196007, -0.7667254, -0.1404399, 0.9803181, -0.1386442) })
			I[105] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.7788386, 0.0229184, -0.6268008, -0.6112946, -0.196007, -0.7667254, -0.1404399, 0.9803181, -0.1386442), C1 = CFrame.new(0, 0, 0, 0.7788386, 0.0229184, -0.6268008, -0.6112946, -0.196007, -0.7667254, -0.1404399, 0.9803181, -0.1386442) })
			I[106] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0009074, 0.9995619, 0.0004534, -0.0350655, 0.0009074, -0.9989468, -0.9989468, 0.0004534, 0.0355036), C1 = CFrame.new(0, 0, 0, 0.0009074, 0.9995619, 0.0004534, -0.0350655, 0.0009074, -0.9989468, -0.9989468, 0.0004534, 0.0355036) })
			I[107] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0000001, 1, 0.0000001, -0.933534, 0.0000001, -0.3584888, -0.3584888, 0, 0.933534), C1 = CFrame.new(0, 0, 0, 0.0000001, 1, 0.0000001, -0.933534, 0.0000001, -0.3584888, -0.3584888, 0, 0.933534) })
			I[108] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0000001, 1, 0.0000001, -0.933534, 0.0000001, -0.3584888, -0.3584888, 0, 0.933534), C1 = CFrame.new(0, 0, 0, 0.0000001, 1, 0.0000001, -0.933534, 0.0000001, -0.3584888, -0.3584888, 0, 0.933534) })
			I[109] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.8641133, 0.0042586, -0.5032794, -0.4942322, -0.1961145, 0.8469201, -0.0950937, 0.9805718, 0.1715698), C1 = CFrame.new(0, 0, 0, -0.8641133, 0.0042586, -0.5032794, -0.4942322, -0.1961145, 0.8469201, -0.0950937, 0.9805718, 0.1715698) })
			I[110] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.8641133, 0.0042586, -0.5032794, -0.4942322, -0.1961145, 0.8469201, -0.0950937, 0.9805718, 0.1715698), C1 = CFrame.new(0, 0, 0, -0.8641133, 0.0042586, -0.5032794, -0.4942322, -0.1961145, 0.8469201, -0.0950937, 0.9805718, 0.1715698) })
			I[111] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0001224, 0.9999661, -0.0000545, -0.4489237, 0.0001223, 0.8935322, 0.8935322, -0.0000547, 0.4489576), C1 = CFrame.new(0, 0, 0, 0.0001224, 0.9999661, -0.0000545, -0.4489237, 0.0001223, 0.8935322, 0.8935322, -0.0000547, 0.4489576) })
			I[112] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0001224, 0.9999661, -0.0000545, -0.4489237, 0.0001223, 0.8935322, 0.8935322, -0.0000547, 0.4489576), C1 = CFrame.new(0, 0, 0, 0.0001224, 0.9999661, -0.0000545, -0.4489237, 0.0001223, 0.8935322, 0.8935322, -0.0000547, 0.4489576) })
			I[113] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.8601356, -0.0791733, -0.503883, -0.4822563, -0.1955005, 0.8539369, -0.1661184, 0.9775024, 0.1299753), C1 = CFrame.new(0, 0, 0, -0.8601356, -0.0791733, -0.503883, -0.4822563, -0.1955005, 0.8539369, -0.1661184, 0.9775024, 0.1299753) })
			I[114] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.8601356, -0.0791733, -0.503883, -0.4822563, -0.1955005, 0.8539369, -0.1661184, 0.9775024, 0.1299753), C1 = CFrame.new(0, 0, 0, -0.8601356, -0.0791733, -0.503883, -0.4822563, -0.1955005, 0.8539369, -0.1661184, 0.9775024, 0.1299753) })
			I[115] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 1, 0, -0.8332846, 0, -0.5528442, -0.5528442, 0, 0.8332846), C1 = CFrame.new(0, 0, 0, 0, 1, 0, -0.8332846, 0, -0.5528442, -0.5528442, 0, 0.8332846) })
			I[116] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 1, 0, -0.8332846, 0, -0.5528442, -0.5528442, 0, 0.8332846), C1 = CFrame.new(0, 0, 0, 0, 1, 0, -0.8332846, 0, -0.5528442, -0.5528442, 0, 0.8332846) })
			I[117] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.6033202, -0.0784198, -0.7937076, -0.7899745, -0.1959699, -0.5812812, -0.1098261, 0.9776491, -0.1802429), C1 = CFrame.new(0, 0, 0, 0.6033202, -0.0784198, -0.7937076, -0.7899745, -0.1959699, -0.5812812, -0.1098261, 0.9776491, -0.1802429) })
			I[118] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.6033202, -0.0784198, -0.7937076, -0.7899745, -0.1959699, -0.5812812, -0.1098261, 0.9776491, -0.1802429), C1 = CFrame.new(0, 0, 0, 0.6033202, -0.0784198, -0.7937076, -0.7899745, -0.1959699, -0.5812812, -0.1098261, 0.9776491, -0.1802429) })
			I[119] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.000012, 0.9999963, -0.0000055, -0.3892107, 0.000012, 0.9211448, 0.9211448, -0.0000055, 0.3892143), C1 = CFrame.new(0, 0, 0, 0.000012, 0.9999963, -0.0000055, -0.3892107, 0.000012, 0.9211448, 0.9211448, -0.0000055, 0.3892143) })
			I[120] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.000012, 0.9999963, -0.0000055, -0.3892107, 0.000012, 0.9211448, 0.9211448, -0.0000055, 0.3892143), C1 = CFrame.new(0, 0, 0, 0.000012, 0.9999963, -0.0000055, -0.3892107, 0.000012, 0.9211448, 0.9211448, -0.0000055, 0.3892143) })
			I[121] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.7470952, -0.5661537, 0.3483108, 0.3137018, -0.1616807, -0.9356595, 0.5860389, 0.8082929, 0.056811), C1 = CFrame.new(0, 0, 0, 0.7470952, -0.5661537, 0.3483108, 0.3137018, -0.1616807, -0.9356595, 0.5860389, 0.8082929, 0.056811) })
			I[122] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.7470952, -0.5661537, 0.3483108, 0.3137018, -0.1616807, -0.9356595, 0.5860389, 0.8082929, 0.056811), C1 = CFrame.new(0, 0, 0, 0.7470952, -0.5661537, 0.3483108, 0.3137018, -0.1616807, -0.9356595, 0.5860389, 0.8082929, 0.056811) })
			I[123] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 1, 0, -0.8270512, 0, -0.5621268, -0.5621268, 0, 0.8270511), C1 = CFrame.new(0, 0, 0, 0, 1, 0, -0.8270512, 0, -0.5621268, -0.5621268, 0, 0.8270511) })
			I[124] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 1, 0, -0.8270512, 0, -0.5621268, -0.5621268, 0, 0.8270511), C1 = CFrame.new(0, 0, 0, 0, 1, 0, -0.8270512, 0, -0.5621268, -0.5621268, 0, 0.8270511) })
			I[125] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.6122048, 0.080018, -0.7866459, -0.7642065, -0.1955326, -0.6146418, -0.2029853, 0.9774421, -0.058562), C1 = CFrame.new(0, 0, 0, 0.6122048, 0.080018, -0.7866459, -0.7642065, -0.1955326, -0.6146418, -0.2029853, 0.9774421, -0.058562) })
			I[126] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.6122048, 0.080018, -0.7866459, -0.7642065, -0.1955326, -0.6146418, -0.2029853, 0.9774421, -0.058562), C1 = CFrame.new(0, 0, 0, 0.6122048, 0.080018, -0.7866459, -0.7642065, -0.1955326, -0.6146418, -0.2029853, 0.9774421, -0.058562) })
			I[127] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0000045, 1.0000006, -0.0000013, -0.7956855, -0.0000045, -0.605711, -0.605711, -0.0000014, 0.7956849), C1 = CFrame.new(0, 0, 0, -0.0000045, 1.0000006, -0.0000013, -0.7956855, -0.0000045, -0.605711, -0.605711, -0.0000014, 0.7956849) })
			I[128] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0000045, 1.0000006, -0.0000013, -0.7956855, -0.0000045, -0.605711, -0.605711, -0.0000014, 0.7956849), C1 = CFrame.new(0, 0, 0, -0.0000045, 1.0000006, -0.0000013, -0.7956855, -0.0000045, -0.605711, -0.605711, -0.0000014, 0.7956849) })
			I[129] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.6550432, 0.0434861, -0.754339, -0.7347989, -0.1959307, -0.6493703, -0.1760368, 0.9796531, -0.0963895), C1 = CFrame.new(0, 0, 0, 0.6550432, 0.0434861, -0.754339, -0.7347989, -0.1959307, -0.6493703, -0.1760368, 0.9796531, -0.0963895) })
			I[130] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.6550432, 0.0434861, -0.754339, -0.7347989, -0.1959307, -0.6493703, -0.1760368, 0.9796531, -0.0963895), C1 = CFrame.new(0, 0, 0, 0.6550432, 0.0434861, -0.754339, -0.7347989, -0.1959307, -0.6493703, -0.1760368, 0.9796531, -0.0963895) })
			I[131] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0000001, 1, 0.0000001, -0.9962423, -0.0000001, 0.0866095, 0.0866095, 0, 0.9962423), C1 = CFrame.new(0, 0, 0, -0.0000001, 1, 0.0000001, -0.9962423, -0.0000001, 0.0866095, 0.0866095, 0, 0.9962423) })
			I[132] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0000001, 1, 0.0000001, -0.9962423, -0.0000001, 0.0866095, 0.0866095, 0, 0.9962423), C1 = CFrame.new(0, 0, 0, -0.0000001, 1, 0.0000001, -0.9962423, -0.0000001, 0.0866095, 0.0866095, 0, 0.9962423) })
			I[133] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0223098, 0.0157866, -0.9996264, -0.9804056, -0.1960917, 0.018784, -0.195722, 0.9804584, 0.019852), C1 = CFrame.new(0, 0, 0, -0.0223098, 0.0157866, -0.9996264, -0.9804056, -0.1960917, 0.018784, -0.195722, 0.9804584, 0.019852) })
			I[134] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0223098, 0.0157866, -0.9996264, -0.9804056, -0.1960917, 0.018784, -0.195722, 0.9804584, 0.019852), C1 = CFrame.new(0, 0, 0, -0.0223098, 0.0157866, -0.9996264, -0.9804056, -0.1960917, 0.018784, -0.195722, 0.9804584, 0.019852) })
			I[135] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0000001, 1, 0.0000001, -0.9543672, -0.0000001, 0.2986357, 0.2986357, 0, 0.9543672), C1 = CFrame.new(0, 0, 0, -0.0000001, 1, 0.0000001, -0.9543672, -0.0000001, 0.2986357, 0.2986357, 0, 0.9543672) })
			I[136] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0000001, 1, 0.0000001, -0.9543672, -0.0000001, 0.2986357, 0.2986357, 0, 0.9543672), C1 = CFrame.new(0, 0, 0, -0.0000001, 1, 0.0000001, -0.9543672, -0.0000001, 0.2986357, 0.2986357, 0, 0.9543672) })
			I[137] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.2359052, 0.0762648, -0.9687788, -0.9562792, -0.195545, 0.2174676, -0.1728547, 0.9777248, 0.1190605), C1 = CFrame.new(0, 0, 0, -0.2359052, 0.0762648, -0.9687788, -0.9562792, -0.195545, 0.2174676, -0.1728547, 0.9777248, 0.1190605) })
			I[138] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.2359052, 0.0762648, -0.9687788, -0.9562792, -0.195545, 0.2174676, -0.1728547, 0.9777248, 0.1190605), C1 = CFrame.new(0, 0, 0, -0.2359052, 0.0762648, -0.9687788, -0.9562792, -0.195545, 0.2174676, -0.1728547, 0.9777248, 0.1190605) })
			I[139] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0000001, 0.9999999, 0, 0.0695037, 0.0000001, -0.9975817, -0.9975817, 0, -0.0695037), C1 = CFrame.new(0, 0, 0, 0.0000001, 0.9999999, 0, 0.0695037, 0.0000001, -0.9975817, -0.9975817, 0, -0.0695037) })
			I[140] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0000001, 0.9999999, 0, 0.0695037, 0.0000001, -0.9975817, -0.9975817, 0, -0.0695037), C1 = CFrame.new(0, 0, 0, 0.0000001, 0.9999999, 0, 0.0695037, 0.0000001, -0.9975817, -0.9975817, 0, -0.0695037) })
			I[141] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.2307695, 0.0852413, -0.967932, -0.9492521, -0.191108, -0.2416449, -0.2075542, 0.9758103, 0.0384932), C1 = CFrame.new(0, 0, 0, 0.2307695, 0.0852413, -0.967932, -0.9492521, -0.191108, -0.2416449, -0.2075542, 0.9758103, 0.0384932) })
			I[142] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.2307695, 0.0852413, -0.967932, -0.9492521, -0.191108, -0.2416449, -0.2075542, 0.9758103, 0.0384932), C1 = CFrame.new(0, 0, 0, 0.2307695, 0.0852413, -0.967932, -0.9492521, -0.191108, -0.2416449, -0.2075542, 0.9758103, 0.0384932) })
			I[143] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0009074, 0.9995619, 0.0004534, -0.0350655, 0.0009074, -0.9989468, -0.9989468, 0.0004534, 0.0355036), C1 = CFrame.new(0, 0, 0, 0.0009074, 0.9995619, 0.0004534, -0.0350655, 0.0009074, -0.9989468, -0.9989468, 0.0004534, 0.0355036) })
			I[144] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0009074, 0.9995619, 0.0004534, -0.0350655, 0.0009074, -0.9989468, -0.9989468, 0.0004534, 0.0355036), C1 = CFrame.new(0, 0, 0, 0.0009074, 0.9995619, 0.0004534, -0.0350655, 0.0009074, -0.9989468, -0.9989468, 0.0004534, 0.0355036) })
			I[145] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0009074, 0.9995619, 0.0004534, -0.0350655, 0.0009074, -0.9989468, -0.9989468, 0.0004534, 0.0355036), C1 = CFrame.new(0, 0, 0, 0.0009074, 0.9995619, 0.0004534, -0.0350655, 0.0009074, -0.9989468, -0.9989468, 0.0004534, 0.0355036) })
			I[146] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.9956052, -0.0888335, 0.0296474, 0.0117731, -0.1953406, -0.9806648, 0.0929073, 0.9767039, -0.1934363), C1 = CFrame.new(0, 0, 0, 0.9956052, -0.0888335, 0.0296474, 0.0117731, -0.1953406, -0.9806648, 0.0929073, 0.9767039, -0.1934363) })
			I[147] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.9956052, -0.0888335, 0.0296474, 0.0117731, -0.1953406, -0.9806648, 0.0929073, 0.9767039, -0.1934363), C1 = CFrame.new(0, 0, 0, 0.9956052, -0.0888335, 0.0296474, 0.0117731, -0.1953406, -0.9806648, 0.0929073, 0.9767039, -0.1934363) })
			I[148] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0020435, 0.9990715, 0.0010174, -0.0923099, 0.0020435, -0.9947984, -0.9947984, 0.0010174, 0.0932384), C1 = CFrame.new(0, 0, 0, 0.0020435, 0.9990715, 0.0010174, -0.0923099, 0.0020435, -0.9947984, -0.9947984, 0.0010174, 0.0932384) })
			I[149] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0020435, 0.9990715, 0.0010174, -0.0923099, 0.0020435, -0.9947984, -0.9947984, 0.0010174, 0.0932384), C1 = CFrame.new(0, 0, 0, 0.0020435, 0.9990715, 0.0010174, -0.0923099, 0.0020435, -0.9947984, -0.9947984, 0.0010174, 0.0932384) })
			I[150] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.9963818, -0.0805831, -0.0270138, -0.0423735, -0.1954783, -0.9797921, 0.0736741, 0.9773917, -0.1981856), C1 = CFrame.new(0, 0, 0, 0.9963818, -0.0805831, -0.0270138, -0.0423735, -0.1954783, -0.9797921, 0.0736741, 0.9773917, -0.1981856) })
			I[151] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.9963818, -0.0805831, -0.0270138, -0.0423735, -0.1954783, -0.9797921, 0.0736741, 0.9773917, -0.1981856), C1 = CFrame.new(0, 0, 0, 0.9963818, -0.0805831, -0.0270138, -0.0423735, -0.1954783, -0.9797921, 0.0736741, 0.9773917, -0.1981856) })
			I[152] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0000023, 0.9999999, 0.0000001, -0.9992276, 0.0000023, -0.0392911, -0.0392911, 0, 0.9992278), C1 = CFrame.new(0, 0, 0, 0.0000023, 0.9999999, 0.0000001, -0.9992276, 0.0000023, -0.0392911, -0.0392911, 0, 0.9992278) })
			I[153] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0000023, 0.9999999, 0.0000001, -0.9992276, 0.0000023, -0.0392911, -0.0392911, 0, 0.9992278), C1 = CFrame.new(0, 0, 0, 0.0000023, 0.9999999, 0.0000001, -0.9992276, 0.0000023, -0.0392911, -0.0392911, 0, 0.9992278) })
			I[154] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.1032816, 0.067778, -0.9923401, -0.9739363, -0.1956649, -0.1147301, -0.2019424, 0.9783256, 0.045803), C1 = CFrame.new(0, 0, 0, 0.1032816, 0.067778, -0.9923401, -0.9739363, -0.1956649, -0.1147301, -0.2019424, 0.9783256, 0.045803) })
			I[155] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.1032816, 0.067778, -0.9923401, -0.9739363, -0.1956649, -0.1147301, -0.2019424, 0.9783256, 0.045803), C1 = CFrame.new(0, 0, 0, 0.1032816, 0.067778, -0.9923401, -0.9739363, -0.1956649, -0.1147301, -0.2019424, 0.9783256, 0.045803) })
			I[156] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 1, 0, -0.6397412, 0, -0.7685905, -0.7685905, 0, 0.6397412), C1 = CFrame.new(0, 0, 0, 0, 1, 0, -0.6397412, 0, -0.7685905, -0.7685905, 0, 0.6397412) })
			I[157] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 1, 0, -0.6397412, 0, -0.7685905, -0.7685905, 0, 0.6397412), C1 = CFrame.new(0, 0, 0, 0, 1, 0, -0.6397412, 0, -0.7685905, -0.7685905, 0, 0.6397412) })
			I[158] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.9206603, -0.1940391, 0.338724, 0.302864, -0.1924059, -0.9334132, 0.2462895, 0.9619437, -0.1183734), C1 = CFrame.new(0, 0, 0, 0.9206603, -0.1940391, 0.338724, 0.302864, -0.1924059, -0.9334132, 0.2462895, 0.9619437, -0.1183734) })
			I[159] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.9206603, -0.1940391, 0.338724, 0.302864, -0.1924059, -0.9334132, 0.2462895, 0.9619437, -0.1183734), C1 = CFrame.new(0, 0, 0, 0.9206603, -0.1940391, 0.338724, 0.302864, -0.1924059, -0.9334132, 0.2462895, 0.9619437, -0.1183734) })
			I[160] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0000001, 1, 0.0000001, -0.8362394, -0.0000001, 0.5483646, 0.5483646, 0, 0.8362393), C1 = CFrame.new(0, 0, 0, -0.0000001, 1, 0.0000001, -0.8362394, -0.0000001, 0.5483646, 0.5483646, 0, 0.8362393) })
			I[161] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0000001, 1, 0.0000001, -0.8362394, -0.0000001, 0.5483646, 0.5483646, 0, 0.8362393), C1 = CFrame.new(0, 0, 0, -0.0000001, 1, 0.0000001, -0.8362394, -0.0000001, 0.5483646, 0.5483646, 0, 0.8362393) })
			I[162] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.4932675, 0.0238641, -0.8695503, -0.8552164, -0.1960603, 0.4797556, -0.1590354, 0.9803014, 0.1171191), C1 = CFrame.new(0, 0, 0, -0.4932675, 0.0238641, -0.8695503, -0.8552164, -0.1960603, 0.4797556, -0.1590354, 0.9803014, 0.1171191) })
			I[163] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.4932675, 0.0238641, -0.8695503, -0.8552164, -0.1960603, 0.4797556, -0.1590354, 0.9803014, 0.1171191), C1 = CFrame.new(0, 0, 0, -0.4932675, 0.0238641, -0.8695503, -0.8552164, -0.1960603, 0.4797556, -0.1590354, 0.9803014, 0.1171191) })
			I[164] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0000287, 1.0000039, -0.0000092, -0.7565244, -0.0000287, -0.6539714, -0.6539714, -0.0000093, 0.7565205), C1 = CFrame.new(0, 0, 0, -0.0000287, 1.0000039, -0.0000092, -0.7565244, -0.0000287, -0.6539714, -0.6539714, -0.0000093, 0.7565205) })
			I[165] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0000287, 1.0000039, -0.0000092, -0.7565244, -0.0000287, -0.6539714, -0.6539714, -0.0000093, 0.7565205), C1 = CFrame.new(0, 0, 0, -0.0000287, 1.0000039, -0.0000092, -0.7565244, -0.0000287, -0.6539714, -0.6539714, -0.0000093, 0.7565205) })
			I[166] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.698958, -0.0778367, -0.7110239, -0.7099878, -0.1964238, -0.6767235, -0.0867815, 0.9777417, -0.192634), C1 = CFrame.new(0, 0, 0, 0.698958, -0.0778367, -0.7110239, -0.7099878, -0.1964238, -0.6767235, -0.0867815, 0.9777417, -0.192634) })
			I[167] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.698958, -0.0778367, -0.7110239, -0.7099878, -0.1964238, -0.6767235, -0.0867815, 0.9777417, -0.192634), C1 = CFrame.new(0, 0, 0, 0.698958, -0.0778367, -0.7110239, -0.7099878, -0.1964238, -0.6767235, -0.0867815, 0.9777417, -0.192634) })
			I[168] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0000001, 1, 0, -0.9995169, -0.0000001, -0.0310805, -0.0310805, -0.0000001, 0.9995169), C1 = CFrame.new(0, 0, 0, -0.0000001, 1, 0, -0.9995169, -0.0000001, -0.0310805, -0.0310805, -0.0000001, 0.9995169) })
			I[169] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0000001, 1, 0, -0.9995169, -0.0000001, -0.0310805, -0.0310805, -0.0000001, 0.9995169), C1 = CFrame.new(0, 0, 0, -0.0000001, 1, 0, -0.9995169, -0.0000001, -0.0310805, -0.0310805, -0.0000001, 0.9995169) })
			I[170] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0950648, 0.0765826, -0.9925207, -0.9746813, -0.19554, -0.1084437, -0.2023825, 0.9777007, 0.0560549), C1 = CFrame.new(0, 0, 0, 0.0950648, 0.0765826, -0.9925207, -0.9746813, -0.19554, -0.1084437, -0.2023825, 0.9777007, 0.0560549) })
			I[171] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0950648, 0.0765826, -0.9925207, -0.9746813, -0.19554, -0.1084437, -0.2023825, 0.9777007, 0.0560549), C1 = CFrame.new(0, 0, 0, 0.0950648, 0.0765826, -0.9925207, -0.9746813, -0.19554, -0.1084437, -0.2023825, 0.9777007, 0.0560549) })
			I[172] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0000001, 1, 0.0000001, -0.9995169, -0.0000001, -0.0310805, -0.0310805, -0.0000001, 0.9995169), C1 = CFrame.new(0, 0, 0, -0.0000001, 1, 0.0000001, -0.9995169, -0.0000001, -0.0310805, -0.0310805, -0.0000001, 0.9995169) })
			I[173] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0000001, 1, 0.0000001, -0.9995169, -0.0000001, -0.0310805, -0.0310805, -0.0000001, 0.9995169), C1 = CFrame.new(0, 0, 0, -0.0000001, 1, 0.0000001, -0.9995169, -0.0000001, -0.0310805, -0.0310805, -0.0000001, 0.9995169) })
			I[174] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0953412, 0.0082806, -0.9954102, -0.9759586, -0.1961095, -0.0951094, -0.195997, 0.980547, -0.0106157), C1 = CFrame.new(0, 0, 0, 0.0953412, 0.0082806, -0.9954102, -0.9759586, -0.1961095, -0.0951094, -0.195997, 0.980547, -0.0106157) })
			I[175] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0953412, 0.0082806, -0.9954102, -0.9759586, -0.1961095, -0.0951094, -0.195997, 0.980547, -0.0106157), C1 = CFrame.new(0, 0, 0, 0.0953412, 0.0082806, -0.9954102, -0.9759586, -0.1961095, -0.0951094, -0.195997, 0.980547, -0.0106157) })
			I[176] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0000002, 0.9999999, 0, -0.915669, 0.0000002, 0.401933, 0.401933, -0.0000001, 0.9156691), C1 = CFrame.new(0, 0, 0, 0.0000002, 0.9999999, 0, -0.915669, 0.0000002, 0.401933, 0.401933, -0.0000001, 0.9156691) })
			I[177] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.3417614, 0.0487338, -0.9385223, -0.9246619, -0.1958832, 0.3265426, -0.1679271, 0.9794155, 0.1120077), C1 = CFrame.new(0, 0, 0, -0.3417614, 0.0487338, -0.9385223, -0.9246619, -0.1958832, 0.3265426, -0.1679271, 0.9794155, 0.1120077) })
			I[178] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.3417614, 0.0487338, -0.9385223, -0.9246619, -0.1958832, 0.3265426, -0.1679271, 0.9794155, 0.1120077), C1 = CFrame.new(0, 0, 0, -0.3417614, 0.0487338, -0.9385223, -0.9246619, -0.1958832, 0.3265426, -0.1679271, 0.9794155, 0.1120077) })
			I[179] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0000004, 1.0000001, 0, -0.9009324, -0.0000004, -0.4339597, -0.4339597, -0.0000001, 0.9009323), C1 = CFrame.new(0, 0, 0, -0.0000004, 1.0000001, 0, -0.9009324, -0.0000004, -0.4339597, -0.4339597, -0.0000001, 0.9009323) })
			I[180] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0000004, 1.0000001, 0, -0.9009324, -0.0000004, -0.4339597, -0.4339597, -0.0000001, 0.9009323), C1 = CFrame.new(0, 0, 0, -0.0000004, 1.0000001, 0, -0.9009324, -0.0000004, -0.4339597, -0.4339597, -0.0000001, 0.9009323) })
			I[181] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.4905641, 0.028628, -0.8710574, -0.851662, -0.1966797, -0.4863032, -0.1850197, 0.9803058, -0.0722356), C1 = CFrame.new(0, 0, 0, 0.4905641, 0.028628, -0.8710574, -0.851662, -0.1966797, -0.4863032, -0.1850197, 0.9803058, -0.0722356) })
			I[182] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.4905641, 0.028628, -0.8710574, -0.851662, -0.1966797, -0.4863032, -0.1850197, 0.9803058, -0.0722356), C1 = CFrame.new(0, 0, 0, 0.4905641, 0.028628, -0.8710574, -0.851662, -0.1966797, -0.4863032, -0.1850197, 0.9803058, -0.0722356) })
			I[183] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0000035, 1.0000004, -0.0000008, -0.8736066, -0.0000035, -0.4866335, -0.4866335, -0.0000008, 0.8736063), C1 = CFrame.new(0, 0, 0, -0.0000035, 1.0000004, -0.0000008, -0.8736066, -0.0000035, -0.4866335, -0.4866335, -0.0000008, 0.8736063) })
			I[184] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0000035, 1.0000004, -0.0000008, -0.8736066, -0.0000035, -0.4866335, -0.4866335, -0.0000008, 0.8736063), C1 = CFrame.new(0, 0, 0, -0.0000035, 1.0000004, -0.0000008, -0.8736066, -0.0000035, -0.4866335, -0.4866335, -0.0000008, 0.8736063) })
			I[185] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.2389798, -0.0886047, -0.9669738, -0.9561089, -0.195345, -0.2183952, -0.1695425, 0.9767241, -0.1313994), C1 = CFrame.new(0, 0, 0, 0.2389798, -0.0886047, -0.9669738, -0.9561089, -0.195345, -0.2183952, -0.1695425, 0.9767241, -0.1313994) })
			I[186] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.2389798, -0.0886047, -0.9669738, -0.9561089, -0.195345, -0.2183952, -0.1695425, 0.9767241, -0.1313994), C1 = CFrame.new(0, 0, 0, 0.2389798, -0.0886047, -0.9669738, -0.9561089, -0.195345, -0.2183952, -0.1695425, 0.9767241, -0.1313994) })
			I[187] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0000005, 0.9999999, 0, -0.9933642, 0.0000005, 0.1150109, 0.1150109, -0.0000001, 0.9933642), C1 = CFrame.new(0, 0, 0, 0.0000005, 0.9999999, 0, -0.9933642, 0.0000005, 0.1150109, 0.1150109, -0.0000001, 0.9933642) })
			I[188] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0000005, 0.9999999, 0, -0.9933642, 0.0000005, 0.1150109, 0.1150109, -0.0000001, 0.9933642), C1 = CFrame.new(0, 0, 0, 0.0000005, 0.9999999, 0, -0.9933642, 0.0000005, 0.1150109, 0.1150109, -0.0000001, 0.9933642) })
			I[189] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0508379, 0.0098813, -0.9986581, -0.9794111, -0.1961067, 0.0479177, -0.19537, 0.9805328, 0.0196474), C1 = CFrame.new(0, 0, 0, -0.0508379, 0.0098813, -0.9986581, -0.9794111, -0.1961067, 0.0479177, -0.19537, 0.9805328, 0.0196474) })
			I[190] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0508379, 0.0098813, -0.9986581, -0.9794111, -0.1961067, 0.0479177, -0.19537, 0.9805328, 0.0196474), C1 = CFrame.new(0, 0, 0, -0.0508379, 0.0098813, -0.9986581, -0.9794111, -0.1961067, 0.0479177, -0.19537, 0.9805328, 0.0196474) })
			I[191] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0000086, 0.9999995, -0.0000006, -0.9843962, 0.0000086, 0.1759635, 0.1759635, -0.0000008, 0.9843967), C1 = CFrame.new(0, 0, 0, 0.0000086, 0.9999995, -0.0000006, -0.9843962, 0.0000086, 0.1759635, 0.1759635, -0.0000008, 0.9843967) })
			I[192] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0000086, 0.9999995, -0.0000006, -0.9843962, 0.0000086, 0.1759635, 0.1759635, -0.0000008, 0.9843967), C1 = CFrame.new(0, 0, 0, 0.0000086, 0.9999995, -0.0000006, -0.9843962, 0.0000086, 0.1759635, 0.1759635, -0.0000008, 0.9843967) })
			I[193] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.1119899, 0.0673158, -0.9914259, -0.9758651, -0.1956705, 0.0969471, -0.1874675, 0.9783558, 0.0876052), C1 = CFrame.new(0, 0, 0, -0.1119899, 0.0673158, -0.9914259, -0.9758651, -0.1956705, 0.0969471, -0.1874675, 0.9783558, 0.0876052) })
			I[194] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.1119899, 0.0673158, -0.9914259, -0.9758651, -0.1956705, 0.0969471, -0.1874675, 0.9783558, 0.0876052), C1 = CFrame.new(0, 0, 0, -0.1119899, 0.0673158, -0.9914259, -0.9758651, -0.1956705, 0.0969471, -0.1874675, 0.9783558, 0.0876052) })
			I[195] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0000016, 0.9999999, -0.0000001, -0.9843965, 0.0000016, 0.1759642, 0.1759642, -0.0000002, 0.9843966), C1 = CFrame.new(0, 0, 0, 0.0000016, 0.9999999, -0.0000001, -0.9843965, 0.0000016, 0.1759642, 0.1759642, -0.0000002, 0.9843966) })
			I[196] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0000016, 0.9999999, -0.0000001, -0.9843965, 0.0000016, 0.1759642, 0.1759642, -0.0000002, 0.9843966), C1 = CFrame.new(0, 0, 0, 0.0000016, 0.9999999, -0.0000001, -0.9843965, 0.0000016, 0.1759642, 0.1759642, -0.0000002, 0.9843966) })
			I[197] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.112148, 0.0414697, -0.9928258, -0.9752969, -0.1959474, 0.1019833, -0.1903124, 0.9797372, 0.0624204), C1 = CFrame.new(0, 0, 0, -0.112148, 0.0414697, -0.9928258, -0.9752969, -0.1959474, 0.1019833, -0.1903124, 0.9797372, 0.0624204) })
			I[198] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.112148, 0.0414697, -0.9928258, -0.9752969, -0.1959474, 0.1019833, -0.1903124, 0.9797372, 0.0624204), C1 = CFrame.new(0, 0, 0, -0.112148, 0.0414697, -0.9928258, -0.9752969, -0.1959474, 0.1019833, -0.1903124, 0.9797372, 0.0624204) })
			I[199] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0000005, 1, 0.0000001, -0.8023216, 0.0000005, -0.596892, -0.596892, 0.0000001, 0.8023216), C1 = CFrame.new(0, 0, 0, 0.0000005, 1, 0.0000001, -0.8023216, 0.0000005, -0.596892, -0.596892, 0.0000001, 0.8023216) })
			I[200] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0000005, 1, 0.0000001, -0.8023216, 0.0000005, -0.596892, -0.596892, 0.0000001, 0.8023216), C1 = CFrame.new(0, 0, 0, 0.0000005, 1, 0.0000001, -0.8023216, 0.0000005, -0.596892, -0.596892, 0.0000001, 0.8023216) })
			I[201] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.6446736, 0.0903528, -0.7590883, -0.7359482, -0.1952198, -0.6482373, -0.2067825, 0.9765592, -0.0593462), C1 = CFrame.new(0, 0, 0, 0.6446736, 0.0903528, -0.7590883, -0.7359482, -0.1952198, -0.6482373, -0.2067825, 0.9765592, -0.0593462) })
			I[202] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.6446736, 0.0903528, -0.7590883, -0.7359482, -0.1952198, -0.6482373, -0.2067825, 0.9765592, -0.0593462), C1 = CFrame.new(0, 0, 0, 0.6446736, 0.0903528, -0.7590883, -0.7359482, -0.1952198, -0.6482373, -0.2067825, 0.9765592, -0.0593462) })
			I[203] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 1, 0.0000001, -0.8017434, -0.0000001, 0.5976684, 0.5976684, 0, 0.8017434), C1 = CFrame.new(0, 0, 0, 0, 1, 0.0000001, -0.8017434, -0.0000001, 0.5976684, 0.5976684, 0, 0.8017434) })
			I[204] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 1, 0.0000001, -0.8017434, -0.0000001, 0.5976684, 0.5976684, 0, 0.8017434), C1 = CFrame.new(0, 0, 0, 0, 1, 0.0000001, -0.8017434, -0.0000001, 0.5976684, 0.5976684, 0, 0.8017434) })
			I[205] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.5433629, -0.0733305, -0.8362891, -0.8144274, -0.1955881, 0.5463089, -0.2036293, 0.9779407, 0.046553), C1 = CFrame.new(0, 0, 0, -0.5433629, -0.0733305, -0.8362891, -0.8144274, -0.1955881, 0.5463089, -0.2036293, 0.9779407, 0.046553) })
			I[206] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.5433629, -0.0733305, -0.8362891, -0.8144274, -0.1955881, 0.5463089, -0.2036293, 0.9779407, 0.046553), C1 = CFrame.new(0, 0, 0, -0.5433629, -0.0733305, -0.8362891, -0.8144274, -0.1955881, 0.5463089, -0.2036293, 0.9779407, 0.046553) })
			I[207] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0360522, 0.7071068, -0.7061871, -0.9863758, -0.1386751, -0.0884992, -0.160509, 0.6933752, 0.7024726), C1 = CFrame.new(0, 0, 0, -0.0360522, 0.7071068, -0.7061871, -0.9863758, -0.1386751, -0.0884992, -0.160509, 0.6933752, 0.7024726) })
			I[208] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0360522, 0.7071068, -0.7061871, -0.9863758, -0.1386751, -0.0884992, -0.160509, 0.6933752, 0.7024726), C1 = CFrame.new(0, 0, 0, -0.0360522, 0.7071068, -0.7061871, -0.9863758, -0.1386751, -0.0884992, -0.160509, 0.6933752, 0.7024726) })
			I[209] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.207742, 0.0765799, -0.9756076, -0.9561968, -0.1968472, -0.2195333, -0.2082363, 0.9780812, 0.0317963), C1 = CFrame.new(0, 0, 0, 0.207742, 0.0765799, -0.9756076, -0.9561968, -0.1968472, -0.2195333, -0.2082363, 0.9780812, 0.0317963) })
			I[210] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.207742, 0.0765799, -0.9756076, -0.9561968, -0.1968472, -0.2195333, -0.2082363, 0.9780812, 0.0317963), C1 = CFrame.new(0, 0, 0, 0.207742, 0.0765799, -0.9756076, -0.9561968, -0.1968472, -0.2195333, -0.2082363, 0.9780812, 0.0317963) })
			I[211] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0360523, -0.7071068, -0.7061872, -0.972235, -0.1386751, 0.1884902, -0.2312132, 0.6933753, -0.6824745), C1 = CFrame.new(0, 0, 0, -0.0360523, -0.7071068, -0.7061872, -0.972235, -0.1386751, 0.1884902, -0.2312132, 0.6933753, -0.6824745) })
			I[212] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0360523, -0.7071068, -0.7061872, -0.972235, -0.1386751, 0.1884902, -0.2312132, 0.6933753, -0.6824745), C1 = CFrame.new(0, 0, 0, -0.0360523, -0.7071068, -0.7061872, -0.972235, -0.1386751, 0.1884902, -0.2312132, 0.6933753, -0.6824745) })
			I[213] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.2087814, 0.097261, -0.9728577, -0.9546077, -0.1943864, -0.2240209, -0.2112719, 0.9757057, 0.052589), C1 = CFrame.new(0, 0, 0, 0.2087814, 0.097261, -0.9728577, -0.9546077, -0.1943864, -0.2240209, -0.2112719, 0.9757057, 0.052589) })
			I[214] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.2087814, 0.097261, -0.9728577, -0.9546077, -0.1943864, -0.2240209, -0.2112719, 0.9757057, 0.052589), C1 = CFrame.new(0, 0, 0, 0.2087814, 0.097261, -0.9728577, -0.9546077, -0.1943864, -0.2240209, -0.2112719, 0.9757057, 0.052589) })
			I[215] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0.9999999, 0.0000001, -0.9241959, 0.0000001, -0.3819186, -0.3819186, -0.0000001, 0.9241959), C1 = CFrame.new(0, 0, 0, 0, 0.9999999, 0.0000001, -0.9241959, 0.0000001, -0.3819186, -0.3819186, -0.0000001, 0.9241959) })
			I[216] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0.9999999, 0.0000001, -0.9241959, 0.0000001, -0.3819186, -0.3819186, -0.0000001, 0.9241959), C1 = CFrame.new(0, 0, 0, 0, 0.9999999, 0.0000001, -0.9241959, 0.0000001, -0.3819186, -0.3819186, -0.0000001, 0.9241959) })
			I[217] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.439146, -0.090693, -0.893637, -0.8878113, -0.1945205, -0.4162115, -0.1363941, 0.9763277, -0.1657633), C1 = CFrame.new(0, 0, 0, 0.439146, -0.090693, -0.893637, -0.8878113, -0.1945205, -0.4162115, -0.1363941, 0.9763277, -0.1657633) })
			I[218] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.439146, -0.090693, -0.893637, -0.8878113, -0.1945205, -0.4162115, -0.1363941, 0.9763277, -0.1657633), C1 = CFrame.new(0, 0, 0, 0.439146, -0.090693, -0.893637, -0.8878113, -0.1945205, -0.4162115, -0.1363941, 0.9763277, -0.1657633) })
			I[219] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0000023, 0.9999998, 0.0000006, -0.8956413, 0.0000024, -0.4447766, -0.4447766, 0.0000005, 0.8956415), C1 = CFrame.new(0, 0, 0, 0.0000023, 0.9999998, 0.0000006, -0.8956413, 0.0000024, -0.4447766, -0.4447766, 0.0000005, 0.8956415) })
			I[220] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0000023, 0.9999998, 0.0000006, -0.8956413, 0.0000024, -0.4447766, -0.4447766, 0.0000005, 0.8956415), C1 = CFrame.new(0, 0, 0, 0.0000023, 0.9999998, 0.0000006, -0.8956413, 0.0000024, -0.4447766, -0.4447766, 0.0000005, 0.8956415) })
			I[221] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.4997996, -0.0889315, -0.8614113, -0.8568475, -0.1946137, -0.4767722, -0.125501, 0.9765196, -0.1733319), C1 = CFrame.new(0, 0, 0, 0.4997996, -0.0889315, -0.8614113, -0.8568475, -0.1946137, -0.4767722, -0.125501, 0.9765196, -0.1733319) })
			I[222] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.4997996, -0.0889315, -0.8614113, -0.8568475, -0.1946137, -0.4767722, -0.125501, 0.9765196, -0.1733319), C1 = CFrame.new(0, 0, 0, 0.4997996, -0.0889315, -0.8614113, -0.8568475, -0.1946137, -0.4767722, -0.125501, 0.9765196, -0.1733319) })
			I[223] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0000002, 0.9999999, 0.0000001, 0.0037774, 0, 0.9999927, 0.9999927, -0.0000001, -0.0037773), C1 = CFrame.new(0, 0, 0, 0.0000002, 0.9999999, 0.0000001, 0.0037774, 0, 0.9999927, 0.9999927, -0.0000001, -0.0037773) })
			I[224] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, 0.0000002, 0.9999999, 0.0000001, 0.0037774, 0, 0.9999927, 0.9999927, -0.0000001, -0.0037773), C1 = CFrame.new(0, 0, 0, 0.0000002, 0.9999999, 0.0000001, 0.0037774, 0, 0.9999927, 0.9999927, -0.0000001, -0.0037773) })
			I[225] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.9955485, 0.0723286, -0.0604307, -0.0735715, -0.1956024, 0.9779196, 0.0589112, 0.9780124, 0.200053), C1 = CFrame.new(0, 0, 0, -0.9955485, 0.0723286, -0.0604307, -0.0735715, -0.1956024, 0.9779196, 0.0589112, 0.9780124, 0.200053) })
			I[226] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.9955485, 0.0723286, -0.0604307, -0.0735715, -0.1956024, 0.9779196, 0.0589112, 0.9780124, 0.200053), C1 = CFrame.new(0, 0, 0, -0.9955485, 0.0723286, -0.0604307, -0.0735715, -0.1956024, 0.9779196, 0.0589112, 0.9780124, 0.200053) })
			I[227] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0000024, 1.0000001, 0.0000003, -0.9611679, -0.0000024, 0.2759645, 0.2759645, 0.0000003, 0.9611678), C1 = CFrame.new(0, 0, 0, -0.0000024, 1.0000001, 0.0000003, -0.9611679, -0.0000024, 0.2759645, 0.2759645, 0.0000003, 0.9611678) })
			I[228] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0000024, 1.0000001, 0.0000003, -0.9611679, -0.0000024, 0.2759645, 0.2759645, 0.0000003, 0.9611678), C1 = CFrame.new(0, 0, 0, -0.0000024, 1.0000001, 0.0000003, -0.9611679, -0.0000024, 0.2759645, 0.2759645, 0.0000003, 0.9611678) })
			I[229] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.2128114, 0.0820827, -0.9736396, -0.9614022, -0.1954544, 0.1936587, -0.174406, 0.9772718, 0.1205092), C1 = CFrame.new(0, 0, 0, -0.2128114, 0.0820827, -0.9736396, -0.9614022, -0.1954544, 0.1936587, -0.174406, 0.9772718, 0.1205092) })
			I[230] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.2128114, 0.0820827, -0.9736396, -0.9614022, -0.1954544, 0.1936587, -0.174406, 0.9772718, 0.1205092), C1 = CFrame.new(0, 0, 0, -0.2128114, 0.0820827, -0.9736396, -0.9614022, -0.1954544, 0.1936587, -0.174406, 0.9772718, 0.1205092) })
			I[231] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0000048, 1.0000002, -0.0000002, -0.9913892, -0.0000048, -0.1309502, -0.1309502, -0.0000004, 0.9913889), C1 = CFrame.new(0, 0, 0, -0.0000048, 1.0000002, -0.0000002, -0.9913892, -0.0000048, -0.1309502, -0.1309502, -0.0000004, 0.9913889) })
			I[232] = new("Weld", I[87], "Weld", { C0 = CFrame.new(0, 0, 0, -0.0000048, 1.0000002, -0.0000002, -0.9913892, -0.0000048, -0.1309502, -0.1309502, -0.0000004, 0.9913889), C1 = CFrame.new(0, 0, 0, -0.0000048, 1.0000002, -0.0000002, -0.9913892, -0.0000048, -0.1309502, -0.1309502, -0.0000004, 0.9913889) })
		I[233] = new("Part", I[86], "Effect", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(304.8899536, 4.3999166, 151.2300873, 0.0001162, -0.9999944, 0.0000072, 0.9999943, 0.0001162, 0.0000072, -0.0000079, 0.0000064, 0.9999999), CanCollide = false, Color = Color3.fromRGB(248, 248, 248), Locked = true, Size = Vector3.new(0.2, 0.2, 2), TopSurface = Enum.SurfaceType.Smooth })
			I[234] = new("SpecialMesh", I[233], "Mesh", { MeshContent = Content.fromUri("http://www.roblox.com/asset/?id=111513060"), MeshType = Enum.MeshType.FileMesh, Scale = Vector3.new(1, 1, 1.2) })
		I[235] = new("Animation", I[86], "Recoil", { AnimationContent = Content.fromUri("http://www.roblox.com/Asset?ID=94331086") })
		I[236] = new("ScreenGui", I[86], "WeaponHud")
			I[237] = new("Frame", I[236], "Crosshair", { BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(500, 500), Size = UDim2.fromOffset(150, 150) })
				I[238] = new("Frame", I[237], "TopFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, -1, -0.5, -7), Size = UDim2.fromOffset(2, 14) })
				I[239] = new("Frame", I[237], "RightFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0.5, -7, 0, -1), Size = UDim2.fromOffset(14, 2) })
				I[240] = new("Frame", I[237], "LeftFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(-0.5, -7, 0, -1), Size = UDim2.fromOffset(14, 2) })
				I[241] = new("ImageLabel", I[237], "TargetHitImage", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=115400215"), Position = UDim2.fromOffset(-25, -25), Size = UDim2.fromOffset(50, 50), Visible = false })
				I[242] = new("TextLabel", I[237], "ReloadingLabel", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, -20), Text = "Reloading", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false })
				I[243] = new("Frame", I[237], "BottomFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, -1, 0.5, -7), Size = UDim2.fromOffset(2, 14) })
			I[244] = new("Frame", I[236], "Reload", { BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(1, -265, 1, -120), Size = UDim2.fromOffset(200, 100) })
				I[245] = new("TextLabel", I[244], "Reload", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -10, 0.5, 0), Text = "Press R to Reload", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8 })
			I[246] = new("Frame", I[236], "AmmoHud", { BackgroundColor3 = Color3.fromRGB(255, 170, 127), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.05), Size = UDim2.fromScale(1, 1) })
				I[247] = new("TextLabel", I[246], "FowardSlash", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -235, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "/", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[248] = new("TextLabel", I[246], "TotalAmmo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -178, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "999", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[249] = new("TextLabel", I[246], "ClipAmmo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -250, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "10", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[250] = new("Frame", I[246], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -198, 1, -120), Size = UDim2.fromOffset(125, 2) })
				I[251] = new("Frame", I[246], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -273, 1, -188), Rotation = 60, Size = UDim2.fromOffset(30, 2) })
				I[252] = new("Frame", I[246], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -252, 1, -175), Size = UDim2.fromOffset(200, 2) })
				I[253] = new("Frame", I[246], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -120, 1, -127), Rotation = 110, Size = UDim2.fromOffset(100, 2) })
				I[254] = new("Frame", I[246], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -162, 1, -81), Size = UDim2.fromOffset(75, 2) })
	I[255] = new("Tool", nil, "CZ57", { CanBeDropped = false, Grip = CFrame.new(0, -0.2, 0, 0.9496286, 0, 0.3133777, 0, 1, 0, -0.3133777, 0, 0.9496286), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=122079944"), ToolTip = "CZ57" })
		I[256] = new("Part", I[255], "Handle", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-7.6000004, 0.5000061, 0.8000002, 0, 0, -1, 0, 1, 0, 1, 0, 0), Color = Color3.fromRGB(255, 255, 0), Locked = true, Size = Vector3.new(0.2, 1, 1.6), TopSurface = Enum.SurfaceType.Smooth })
			I[257] = new("SpecialMesh", I[256], "Mesh", { MeshContent = Content.fromUri("http://www.roblox.com/asset/?id=2806276"), MeshType = Enum.MeshType.FileMesh, Scale = Vector3.new(1.33, 1.33, 1.33) })
			I[258] = new("Sound", I[256], "FireSound", { Volume = 1 })
			I[259] = new("Sound", I[256], "Reload", { Volume = 1 })
			I[260] = new("Sound", I[256], "EquipSound", { Volume = 1 })
			I[261] = new("PointLight", I[256], "Flash", { Brightness = 1.5, Color = Color3.fromRGB(255, 255, 0), Enabled = false })
			I[262] = new("Sound", I[256], "Tick", { Volume = 1 })
		I[263] = new("ScreenGui", I[255], "WeaponHud")
			I[264] = new("Frame", I[263], "Crosshair", { BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(500, 500), Size = UDim2.fromOffset(150, 150) })
				I[265] = new("Frame", I[264], "TopFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, -1, -0.5, -7), Size = UDim2.fromOffset(2, 14) })
				I[266] = new("Frame", I[264], "RightFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0.5, -7, 0, -1), Size = UDim2.fromOffset(14, 2) })
				I[267] = new("Frame", I[264], "LeftFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(-0.5, -7, 0, -1), Size = UDim2.fromOffset(14, 2) })
				I[268] = new("ImageLabel", I[264], "TargetHitImage", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=115400215"), Position = UDim2.fromOffset(-25, -25), Size = UDim2.fromOffset(50, 50), Visible = false })
				I[269] = new("TextLabel", I[264], "ReloadingLabel", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, -20), Text = "Reloading", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false })
				I[270] = new("Frame", I[264], "BottomFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, -1, 0.5, -7), Size = UDim2.fromOffset(2, 14) })
			I[271] = new("Frame", I[263], "Reload", { BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(1, -265, 1, -120), Size = UDim2.fromOffset(200, 100) })
				I[272] = new("TextLabel", I[271], "Reload", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -10, 0.5, 0), Text = "Press R to Reload", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8 })
			I[273] = new("Frame", I[263], "AmmoHud", { BackgroundColor3 = Color3.fromRGB(255, 170, 127), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.05), Size = UDim2.fromScale(1, 1) })
				I[274] = new("TextLabel", I[273], "FowardSlash", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -235, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "/", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[275] = new("TextLabel", I[273], "TotalAmmo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -178, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "999", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[276] = new("TextLabel", I[273], "ClipAmmo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -250, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "10", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[277] = new("Frame", I[273], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -198, 1, -120), Size = UDim2.fromOffset(125, 2) })
				I[278] = new("Frame", I[273], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -273, 1, -188), Rotation = 60, Size = UDim2.fromOffset(30, 2) })
				I[279] = new("Frame", I[273], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -252, 1, -175), Size = UDim2.fromOffset(200, 2) })
				I[280] = new("Frame", I[273], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -120, 1, -127), Rotation = 110, Size = UDim2.fromOffset(100, 2) })
				I[281] = new("Frame", I[273], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -162, 1, -81), Size = UDim2.fromOffset(75, 2) })
	I[282] = new("Tool", nil, "G-AK47", { CanBeDropped = false, Grip = CFrame.new(0.2, -0.1, 0.4, 0.9701425, 0, 0.2425356, 0, 1, 0, -0.2425356, 0, 0.9701425), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=122079896"), ToolTip = "AK47" })
		I[283] = new("Part", I[282], "Handle", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(326.0502014, 39.2000237, 178.3994598, 0, 0, -1, 0, 1, 0, 1, 0, 0), Color = Color3.fromRGB(255, 255, 0), Size = Vector3.new(0.2, 1, 4), TopSurface = Enum.SurfaceType.Smooth })
			I[284] = new("Sound", I[283], "FireSound", { Volume = 1 })
			I[285] = new("Sound", I[283], "Reload", { Volume = 1 })
			I[286] = new("Sound", I[283], "EquipSound", { Volume = 1 })
			I[287] = new("PointLight", I[283], "Flash", { Brightness = 1.5, Color = Color3.fromRGB(255, 255, 0), Enabled = false })
			I[288] = new("Sound", I[283], "Tick", { Volume = 1 })
			I[289] = new("SpecialMesh", I[283], "Mesh", { MeshContent = Content.fromUri("http://www.roblox.com/asset/?id=3824749"), MeshType = Enum.MeshType.FileMesh, Scale = Vector3.new(2.5, 1.5, 1.3) })
		I[290] = new("Animation", I[282], "Recoil", { AnimationContent = Content.fromUri("http://www.roblox.com/Asset?ID=94331086") })
		I[291] = new("ScreenGui", I[282], "WeaponHud")
			I[292] = new("Frame", I[291], "Crosshair", { BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(500, 500), Size = UDim2.fromOffset(150, 150) })
				I[293] = new("Frame", I[292], "TopFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, -1, -0.5, -7), Size = UDim2.fromOffset(2, 14) })
				I[294] = new("Frame", I[292], "RightFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0.5, -7, 0, -1), Size = UDim2.fromOffset(14, 2) })
				I[295] = new("Frame", I[292], "LeftFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(-0.5, -7, 0, -1), Size = UDim2.fromOffset(14, 2) })
				I[296] = new("ImageLabel", I[292], "TargetHitImage", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=115400215"), Position = UDim2.fromOffset(-25, -25), Size = UDim2.fromOffset(50, 50), Visible = false })
				I[297] = new("TextLabel", I[292], "ReloadingLabel", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, -20), Text = "Reloading", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false })
				I[298] = new("Frame", I[292], "BottomFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, -1, 0.5, -7), Size = UDim2.fromOffset(2, 14) })
			I[299] = new("Frame", I[291], "Reload", { BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(1, -265, 1, -120), Size = UDim2.fromOffset(200, 100) })
				I[300] = new("TextLabel", I[299], "Reload", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -10, 0.5, 0), Text = "Press R to Reload", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8 })
			I[301] = new("Frame", I[291], "AmmoHud", { BackgroundColor3 = Color3.fromRGB(255, 170, 127), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.05), Size = UDim2.fromScale(1, 1) })
				I[302] = new("TextLabel", I[301], "FowardSlash", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -235, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "/", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[303] = new("TextLabel", I[301], "TotalAmmo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -178, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "999", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[304] = new("TextLabel", I[301], "ClipAmmo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -250, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "10", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[305] = new("Frame", I[301], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -198, 1, -120), Size = UDim2.fromOffset(125, 2) })
				I[306] = new("Frame", I[301], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -273, 1, -188), Rotation = 60, Size = UDim2.fromOffset(30, 2) })
				I[307] = new("Frame", I[301], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -252, 1, -175), Size = UDim2.fromOffset(200, 2) })
				I[308] = new("Frame", I[301], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -120, 1, -127), Rotation = 110, Size = UDim2.fromOffset(100, 2) })
				I[309] = new("Frame", I[301], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -162, 1, -81), Size = UDim2.fromOffset(75, 2) })
	I[310] = new("Tool", nil, "GRocket", { Grip = CFrame.new(-1, -0.75, 0.25, 0, 0, 1, 0, 1, 0, -1, 0, 0) })
		I[311] = new("Sound", I[310], "Explosion", { PlayOnRemove = true, Volume = 1 })
		I[312] = new("Sound", I[310], "Swoosh", { PlayOnRemove = true, Volume = 1 })
		I[313] = new("Part", I[310], "Handle", { BackSurface = Enum.SurfaceType.Weld, BottomSurface = Enum.SurfaceType.Weld, CFrame = CFrame.new(-36.8999901, 0.8907542, 119.9000244, 1, -0.0000038, 0, -0.0000038, -1, 0.0000023, 0, -0.0000023, -1), Color = Color3.fromRGB(255, 255, 0), FrontSurface = Enum.SurfaceType.Weld, LeftSurface = Enum.SurfaceType.Weld, Material = Enum.Material.Pebble, Size = Vector3.new(3, 0.8, 1), TopSurface = Enum.SurfaceType.Weld })
			I[314] = new("Sound", I[313], "Fire", { Volume = 1 })
			I[315] = new("SpecialMesh", I[313], "Mesh", { MeshContent = Content.fromUri("http://www.roblox.com/asset/?id=1030777"), MeshType = Enum.MeshType.FileMesh, Scale = Vector3.new(0.75, 0.75, 0.75), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=52020244") })
	I[316] = new("Tool", nil, "HeatRocket", { CanBeDropped = false, Grip = CFrame.new(0.05, -0.6, -0.8), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=103968503"), ToolTip = "LockonLauncher" })
		I[317] = new("Part", I[316], "Handle", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(178.0198212, 68.0272598, -232.3257446, -0.6286784, -0.0006192, 0.7776651, 0, 0.9999996, 0.0007963, -0.7776653, 0.0005006, -0.6286782), Size = Vector3.new(0.84, 1.15, 3.5500002), TopSurface = Enum.SurfaceType.Smooth })
			I[318] = new("SpecialMesh", I[317], "Mesh", { MeshContent = Content.fromUri("http://www.roblox.com/asset/?id=103967465"), MeshType = Enum.MeshType.FileMesh, Scale = Vector3.new(1.1, 1.1, 1.1), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=103967643") })
			I[319] = new("Sound", I[317], "ReloadSound", { Volume = 1 })
			I[320] = new("Sound", I[317], "Equip")
			I[321] = new("Sound", I[317], "holdlock", { Looped = true })
			I[322] = new("Sound", I[317], "lockon")
		I[323] = new("Sound", I[316], "Boom", { Volume = 1 })
		I[324] = new("Sound", I[316], "Swoosh", { Looped = true, Volume = 0.7 })
		I[325] = new("Animation", I[316], "FireAndReload", { AnimationContent = Content.fromUri("http://www.roblox.com/Asset?ID=94771598") })
		I[326] = new("BillboardGui", I[316], "BillboardGui", { AlwaysOnTop = true, MaxDistance = math.huge, Size = UDim2.new(2, 40, 2, 40), StudsOffset = Vector3.new(0, 0, 2) })
			I[327] = new("ImageLabel", I[326], "lockonHeld", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=103834534"), Size = UDim2.fromScale(1, 1), Visible = false })
			I[328] = new("TextLabel", I[326], "Distance", { BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 1, 5), FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8, 0.2), Size = UDim2.fromScale(10, 0.2), Text = "110", TextColor3 = Color3.fromRGB(255, 0, 4), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, Visible = false })
			I[329] = new("ImageLabel", I[326], "lockon", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=103834483"), Size = UDim2.fromScale(1, 1), Visible = false })
	I[330] = new("Tool", nil, "Ithaca", { CanBeDropped = false, Grip = CFrame.new(0.26, -0.6, -0.33, 0.9701453, 0.0000002, 0.2425244, 0.2425123, 0.0099976, -0.9700969, -0.0024249, 0.9999501, 0.009699), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=122079958"), ToolTip = "Ithaca 37" })
		I[331] = new("Part", I[330], "Handle", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(0, 5.6000061, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0), Color = Color3.fromRGB(255, 255, 0), Locked = true, Size = Vector3.new(0.2, 2.8, 1), TopSurface = Enum.SurfaceType.Smooth })
			I[332] = new("SpecialMesh", I[331], "Mesh", { MeshContent = Content.fromUri("http://www.roblox.com/asset/?id=71947462"), MeshType = Enum.MeshType.FileMesh, Scale = Vector3.new(1.2, 1, 1.2) })
			I[333] = new("Sound", I[331], "FireSound", { Volume = 1 })
			I[334] = new("Sound", I[331], "PumpSound", { Volume = 1 })
			I[335] = new("Sound", I[331], "Reload", { Volume = 1 })
			I[336] = new("Sound", I[331], "EquipSound", { Volume = 1 })
			I[337] = new("PointLight", I[331], "Flash", { Brightness = 1.5, Color = Color3.fromRGB(255, 255, 0), Enabled = false })
			I[338] = new("Sound", I[331], "Tick", { Volume = 1 })
		I[339] = new("Animation", I[330], "Recoil", { AnimationContent = Content.fromUri("http://www.roblox.com/Asset?ID=94331086") })
		I[340] = new("ScreenGui", I[330], "WeaponHud")
			I[341] = new("Frame", I[340], "AmmoHud", { BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(1, -265, 1, -60), Size = UDim2.fromOffset(200, 50), Style = Enum.FrameStyle.RobloxSquare })
				I[342] = new("TextLabel", I[341], "ForwardSlash", { BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Text = "/", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0 })
				I[343] = new("TextLabel", I[341], "ClipAmmo", { BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.45, 0.5), Text = "54", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0, TextXAlignment = Enum.TextXAlignment.Right })
				I[344] = new("TextLabel", I[341], "TotalAmmo", { BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.55, 0.5), Text = "180", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0, TextXAlignment = Enum.TextXAlignment.Left })
			I[345] = new("Frame", I[340], "Crosshair", { BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(500, 500), Size = UDim2.fromOffset(150, 150) })
				I[346] = new("Frame", I[345], "TopFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, -1, -0.5, -7), Size = UDim2.fromOffset(2, 14) })
				I[347] = new("Frame", I[345], "RightFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0.5, -7, 0, -1), Size = UDim2.fromOffset(14, 2) })
				I[348] = new("Frame", I[345], "LeftFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(-0.5, -7, 0, -1), Size = UDim2.fromOffset(14, 2) })
				I[349] = new("ImageLabel", I[345], "TargetHitImage", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=115400215"), Position = UDim2.fromOffset(-25, -25), Size = UDim2.fromOffset(50, 50), Visible = false })
				I[350] = new("TextLabel", I[345], "ReloadingLabel", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, -20), Text = "Reloading", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false })
				I[351] = new("Frame", I[345], "BottomFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, -1, 0.5, -7), Size = UDim2.fromOffset(2, 14) })
			I[352] = new("Frame", I[340], "Reload", { BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(1, -265, 1, -120), Size = UDim2.fromOffset(200, 50), Visible = false })
				I[353] = new("TextLabel", I[352], "Reload", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Text = "Press R to Reload", TextColor3 = Color3.fromRGB(255, 0, 0), TextStrokeTransparency = 0 })
	I[354] = new("Tool", nil, "JetPack", { Grip = CFrame.new(1.5, 2.3, 0, 1, 0, 0, 0, 0, -1, 0, 1, 0), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=32070152") })
		I[355] = new("ScreenGui", I[354], "FuelGui")
			I[356] = new("Frame", I[355], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 181, 0), Position = UDim2.fromScale(0.9, 0.2), Size = UDim2.fromOffset(40, 300) })
			I[357] = new("ImageLabel", I[355], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(254, 254, 254), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=30559074"), Position = UDim2.fromScale(0.9, 0.2), Size = UDim2.fromOffset(40, 300) })
		I[358] = new("Animation", I[354], "standstill")
		I[359] = new("NumberValue", I[354], "CurrFuel", { Value = 999854 })
		I[360] = new("Part", I[354], "Handle", { BottomSurface = Enum.SurfaceType.Weld, CFrame = CFrame.new(3.5000033, 0.8909297, -1.4999994, -0.9999999, 0, 0.0000002, -0.0000002, 0.0000015, -0.9999999, 0, -0.9999999, -0.0000014), Size = Vector3.new(5, 3, 1) })
			I[361] = new("SpecialMesh", I[360], "Mesh", { MeshContent = Content.fromUri("http://www.roblox.com/asset/?id=30643517"), MeshType = Enum.MeshType.FileMesh, TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=32051518") })
			I[362] = new("Sound", I[360], "InitialThrust")
			I[363] = new("Sound", I[360], "LowFuelWarning", { Looped = true })
			I[364] = new("Sound", I[360], "EngineFail")
			I[365] = new("Sound", I[360], "Thrusting", { Looped = true })
	I[366] = new("Tool", nil, "M1Grand", { CanBeDropped = false, Grip = CFrame.new(0.25, -0.25, 0.7, 0.9701425, 0, 0.2425356, 0, 1, 0, -0.2425356, 0, 0.9701425), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=122079966"), ToolTip = "M1 Garand" })
		I[367] = new("Part", I[366], "Handle", { CFrame = CFrame.new(-8.6142511, 0.5, 14.5594234, 0, 0, -1, 0, 1, 0, 1, 0, 0), Color = Color3.fromRGB(17, 17, 17), Size = Vector3.new(0.2, 1, 4.8000002) })
			I[368] = new("SpecialMesh", I[367], "Mesh", { MeshContent = Content.fromUri("http://www.roblox.com/asset/?id=94287666"), MeshType = Enum.MeshType.FileMesh, Scale = Vector3.new(1.7, 1.7, 1.5), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=24856725") })
			I[369] = new("Sound", I[367], "FireSound", { Volume = 1 })
			I[370] = new("Sound", I[367], "Reload", { Volume = 1 })
			I[371] = new("Sound", I[367], "EquipSound", { Volume = 1 })
			I[372] = new("PointLight", I[367], "Flash", { Brightness = 1.5, Color = Color3.fromRGB(255, 255, 0), Enabled = false })
			I[373] = new("Sound", I[367], "Tick", { Volume = 1 })
		I[374] = new("Animation", I[366], "Recoil", { AnimationContent = Content.fromUri("http://www.roblox.com/Asset?ID=94331086") })
		I[375] = new("ScreenGui", I[366], "WeaponHud")
			I[376] = new("Frame", I[375], "Crosshair", { BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(500, 500), Size = UDim2.fromOffset(150, 150) })
				I[377] = new("Frame", I[376], "TopFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, -1, -0.5, -7), Size = UDim2.fromOffset(2, 14) })
				I[378] = new("Frame", I[376], "RightFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0.5, -7, 0, -1), Size = UDim2.fromOffset(14, 2) })
				I[379] = new("Frame", I[376], "LeftFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(-0.5, -7, 0, -1), Size = UDim2.fromOffset(14, 2) })
				I[380] = new("ImageLabel", I[376], "TargetHitImage", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=115400215"), Position = UDim2.fromOffset(-25, -25), Size = UDim2.fromOffset(50, 50), Visible = false })
				I[381] = new("TextLabel", I[376], "ReloadingLabel", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, -20), Text = "Reloading", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false })
				I[382] = new("Frame", I[376], "BottomFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, -1, 0.5, -7), Size = UDim2.fromOffset(2, 14) })
			I[383] = new("Frame", I[375], "Reload", { BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(1, -265, 1, -120), Size = UDim2.fromOffset(200, 100) })
				I[384] = new("TextLabel", I[383], "Reload", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -10, 0.5, 0), Text = "Press R to Reload", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8 })
			I[385] = new("Frame", I[375], "AmmoHud", { BackgroundColor3 = Color3.fromRGB(255, 170, 127), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.05), Size = UDim2.fromScale(1, 1) })
				I[386] = new("TextLabel", I[385], "FowardSlash", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -235, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "/", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[387] = new("TextLabel", I[385], "TotalAmmo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -178, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "999", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[388] = new("TextLabel", I[385], "ClipAmmo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -250, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "10", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[389] = new("Frame", I[385], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -198, 1, -120), Size = UDim2.fromOffset(125, 2) })
				I[390] = new("Frame", I[385], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -273, 1, -188), Rotation = 60, Size = UDim2.fromOffset(30, 2) })
				I[391] = new("Frame", I[385], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -252, 1, -175), Size = UDim2.fromOffset(200, 2) })
				I[392] = new("Frame", I[385], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -120, 1, -127), Rotation = 110, Size = UDim2.fromOffset(100, 2) })
				I[393] = new("Frame", I[385], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -162, 1, -81), Size = UDim2.fromOffset(75, 2) })
	I[394] = new("Tool", nil, "Medkit", { Grip = CFrame.new(0.1, 0, 0.5, 0.018926, -0.9806191, -0.1950076, 0.9953234, 0, 0.096599, -0.0947268, -0.1959239, 0.9760332), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=13319305") })
		I[395] = new("Part", I[394], "Handle", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-57.8061295, 18.8989201, 365.9388428, 0.0000001, -0.0003875, 0.9999999, -0.0002385, -0.9999998, -0.0003875, 0.9999998, -0.0002385, -0.0000001), Color = Color3.fromRGB(242, 243, 243), Size = Vector3.new(1, 0.4, 1), TopSurface = Enum.SurfaceType.Smooth })
			I[396] = new("Sound", I[395], "Fire", { Volume = 0.7 })
			I[397] = new("SpecialMesh", I[395], "Mesh", { MeshContent = Content.fromUri("http://www.roblox.com/asset/?id=13319240"), MeshType = Enum.MeshType.FileMesh, Scale = Vector3.new(0.8, 0.8, 0.8), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=13319242") })
	I[398] = new("Tool", nil, "Minigun", { Grip = CFrame.new(0, -0.2, 0.1), TextureContent = Content.fromUri("http://www.roblox.com/asset/?ID=98029614") })
		I[399] = new("Part", I[398], "Handle", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(161.7600098, 0.5, 122.3299561, 0, 0, -1, 0, 1, 0, 1, 0, 0), Color = Color3.fromRGB(27, 42, 53), Size = Vector3.new(1, 1, 4), TopSurface = Enum.SurfaceType.Smooth })
			I[400] = new("SpecialMesh", I[399], "Mesh", { MeshContent = Content.fromUri("http://www.roblox.com/asset/?id=2806162"), MeshType = Enum.MeshType.FileMesh, TextureContent = Content.fromUri("http://www.roblox.com/asset/?id="), VertexColor = Vector3.new(0, 0, 0) })
			I[401] = new("Sound", I[399], "FireSound", { Volume = 0.3 })
		I[402] = new("Animation", I[398], "Recoil", { AnimationContent = Content.fromUri("http://www.roblox.com/Asset?ID=89289443") })
		I[403] = new("ScreenGui", I[398], "WeaponHud")
			I[404] = new("Frame", I[403], "Crosshair", { BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(500, 500), Size = UDim2.fromOffset(150, 150) })
				I[405] = new("Frame", I[404], "TopFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, -1, -0.5, -7), Size = UDim2.fromOffset(2, 14) })
				I[406] = new("Frame", I[404], "RightFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0.5, -7, 0, -1), Size = UDim2.fromOffset(14, 2) })
				I[407] = new("Frame", I[404], "LeftFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(-0.5, -7, 0, -1), Size = UDim2.fromOffset(14, 2) })
				I[408] = new("ImageLabel", I[404], "TargetHitImage", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=115400215"), Position = UDim2.fromOffset(-25, -25), Size = UDim2.fromOffset(50, 50), Visible = false })
				I[409] = new("TextLabel", I[404], "ReloadingLabel", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, -20), Text = "Reloading", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false })
				I[410] = new("Frame", I[404], "BottomFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, -1, 0.5, -7), Size = UDim2.fromOffset(2, 14) })
			I[411] = new("Frame", I[403], "Reload", { BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(1, -265, 1, -120), Size = UDim2.fromOffset(200, 100) })
				I[412] = new("TextLabel", I[411], "Reload", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -10, 0.5, 0), Text = "Press R to Reload", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8 })
			I[413] = new("Frame", I[403], "AmmoHud", { BackgroundColor3 = Color3.fromRGB(255, 170, 127), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.05), Size = UDim2.fromScale(1, 1) })
				I[414] = new("TextLabel", I[413], "FowardSlash", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -235, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "/", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[415] = new("TextLabel", I[413], "TotalAmmo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -178, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "999", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[416] = new("TextLabel", I[413], "ClipAmmo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -250, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "10", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[417] = new("Frame", I[413], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -198, 1, -120), Size = UDim2.fromOffset(125, 2) })
				I[418] = new("Frame", I[413], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -273, 1, -188), Rotation = 60, Size = UDim2.fromOffset(30, 2) })
				I[419] = new("Frame", I[413], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -252, 1, -175), Size = UDim2.fromOffset(200, 2) })
				I[420] = new("Frame", I[413], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -120, 1, -127), Rotation = 110, Size = UDim2.fromOffset(100, 2) })
				I[421] = new("Frame", I[413], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -162, 1, -81), Size = UDim2.fromOffset(75, 2) })
	I[422] = new("Tool", nil, "P90", { CanBeDropped = false, Grip = CFrame.new(-0.2, -0.5, -0.2, -0.2425744, 0, 0.9701328, 0, 1, 0, -0.9701328, 0, -0.2425744), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=122080105"), ToolTip = "P90" })
		I[423] = new("Part", I[422], "Handle", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(148.3138428, 0.5, 122.3572006, -1, 0, 0, 0, 1, 0, 0, 0, -1), Color = Color3.fromRGB(27, 42, 53), Size = Vector3.new(2, 1, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[424] = new("SpecialMesh", I[423], "Mesh", { MeshContent = Content.fromUri("http://www.roblox.com/asset/?id=11651603"), MeshType = Enum.MeshType.FileMesh, Scale = Vector3.new(0.11, 0.11, 0.11) })
			I[425] = new("Sound", I[423], "FireSound", { Volume = 1 })
			I[426] = new("Sound", I[423], "Reload", { Volume = 1 })
			I[427] = new("Sound", I[423], "EquipSound", { Volume = 1 })
			I[428] = new("PointLight", I[423], "Flash", { Brightness = 1.5, Color = Color3.fromRGB(255, 255, 0), Enabled = false })
			I[429] = new("Sound", I[423], "Tick", { Volume = 1 })
		I[430] = new("Animation", I[422], "Recoil", { AnimationContent = Content.fromUri("http://www.roblox.com/Asset?ID=94331086") })
		I[431] = new("ScreenGui", I[422], "WeaponHud")
			I[432] = new("Frame", I[431], "Crosshair", { BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(500, 500), Size = UDim2.fromOffset(150, 150) })
				I[433] = new("Frame", I[432], "TopFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, -1, -0.5, -7), Size = UDim2.fromOffset(2, 14) })
				I[434] = new("Frame", I[432], "RightFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0.5, -7, 0, -1), Size = UDim2.fromOffset(14, 2) })
				I[435] = new("Frame", I[432], "LeftFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(-0.5, -7, 0, -1), Size = UDim2.fromOffset(14, 2) })
				I[436] = new("ImageLabel", I[432], "TargetHitImage", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=115400215"), Position = UDim2.fromOffset(-25, -25), Size = UDim2.fromOffset(50, 50), Visible = false })
				I[437] = new("TextLabel", I[432], "ReloadingLabel", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, -20), Text = "Reloading", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false })
				I[438] = new("Frame", I[432], "BottomFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, -1, 0.5, -7), Size = UDim2.fromOffset(2, 14) })
			I[439] = new("Frame", I[431], "Reload", { BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(1, -265, 1, -120), Size = UDim2.fromOffset(200, 100) })
				I[440] = new("TextLabel", I[439], "Reload", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -10, 0.5, 0), Text = "Press R to Reload", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8 })
			I[441] = new("Frame", I[431], "AmmoHud", { BackgroundColor3 = Color3.fromRGB(255, 170, 127), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.05), Size = UDim2.fromScale(1, 1) })
				I[442] = new("TextLabel", I[441], "FowardSlash", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -235, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "/", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[443] = new("TextLabel", I[441], "TotalAmmo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -178, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "999", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[444] = new("TextLabel", I[441], "ClipAmmo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -250, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "10", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[445] = new("Frame", I[441], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -198, 1, -120), Size = UDim2.fromOffset(125, 2) })
				I[446] = new("Frame", I[441], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -273, 1, -188), Rotation = 60, Size = UDim2.fromOffset(30, 2) })
				I[447] = new("Frame", I[441], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -252, 1, -175), Size = UDim2.fromOffset(200, 2) })
				I[448] = new("Frame", I[441], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -120, 1, -127), Rotation = 110, Size = UDim2.fromOffset(100, 2) })
				I[449] = new("Frame", I[441], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -162, 1, -81), Size = UDim2.fromOffset(75, 2) })
	I[450] = new("Tool", nil, "SpeedCoil", { Grip = CFrame.new(1.5, 2.25, -1.45), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=150569972") })
		I[451] = new("Part", I[450], "Handle", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(287.652771, 54.9932442, 41.5313644), Size = Vector3.new(1.75, 0.75, 2), TopSurface = Enum.SurfaceType.Smooth })
			I[452] = new("SpecialMesh", I[451], "Mesh", { MeshContent = Content.fromUri("http://www.roblox.com/asset?id=150063131"), MeshType = Enum.MeshType.FileMesh, Scale = Vector3.new(1.25, 1.25, 1.5), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=203126288") })
			I[453] = new("Sound", I[451], "CoilSound", { Volume = 1 })
	I[454] = new("Tool", nil, "Uzi", { CanBeDropped = false, Grip = CFrame.new(0, 0.2, -0.2, 0.9496333, 0, 0.3133634, 0.3133477, 0.0099995, -0.9495858, -0.0031335, 0.9999499, 0.0094959), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=122080142"), ToolTip = "Uzi" })
		I[455] = new("Part", I[454], "Handle", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-2.8960114, 0.5, 14.8062687, 0, -1, 0, 0, 0, 1, -1, 0, 0), Color = Color3.fromRGB(27, 42, 53), Size = Vector3.new(0.2, 2, 1), TopSurface = Enum.SurfaceType.Smooth })
			I[456] = new("Sound", I[455], "FireSound", { Volume = 1 })
			I[457] = new("Sound", I[455], "Reload", { Volume = 1 })
			I[458] = new("Sound", I[455], "EquipSound", { Volume = 1 })
			I[459] = new("PointLight", I[455], "Flash", { Brightness = 1.5, Color = Color3.fromRGB(255, 255, 0), Enabled = false })
			I[460] = new("Sound", I[455], "Tick", { Volume = 1 })
			I[461] = new("SpecialMesh", I[455], "Mesh", { MeshContent = Content.fromUri("http://www.roblox.com/asset/?id=72012794"), MeshType = Enum.MeshType.FileMesh, Scale = Vector3.new(0.6, 0.6, 0.6), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=72012761"), VertexColor = Vector3.new(2, 2, 2) })
		I[462] = new("Animation", I[454], "Recoil", { AnimationContent = Content.fromUri("http://www.roblox.com/Asset?ID=94331086") })
		I[463] = new("ScreenGui", I[454], "WeaponHud")
			I[464] = new("Frame", I[463], "Crosshair", { BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(500, 500), Size = UDim2.fromOffset(150, 150) })
				I[465] = new("Frame", I[464], "TopFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, -1, -0.5, -7), Size = UDim2.fromOffset(2, 14) })
				I[466] = new("Frame", I[464], "RightFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0.5, -7, 0, -1), Size = UDim2.fromOffset(14, 2) })
				I[467] = new("Frame", I[464], "LeftFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(-0.5, -7, 0, -1), Size = UDim2.fromOffset(14, 2) })
				I[468] = new("ImageLabel", I[464], "TargetHitImage", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=115400215"), Position = UDim2.fromOffset(-25, -25), Size = UDim2.fromOffset(50, 50), Visible = false })
				I[469] = new("TextLabel", I[464], "ReloadingLabel", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, -20), Text = "Reloading", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false })
				I[470] = new("Frame", I[464], "BottomFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, -1, 0.5, -7), Size = UDim2.fromOffset(2, 14) })
			I[471] = new("Frame", I[463], "Reload", { BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(1, -265, 1, -120), Size = UDim2.fromOffset(200, 100) })
				I[472] = new("TextLabel", I[471], "Reload", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -10, 0.5, 0), Text = "Press R to Reload", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8 })
			I[473] = new("Frame", I[463], "AmmoHud", { BackgroundColor3 = Color3.fromRGB(255, 170, 127), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.05), Size = UDim2.fromScale(1, 1) })
				I[474] = new("TextLabel", I[473], "FowardSlash", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -235, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "/", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[475] = new("TextLabel", I[473], "TotalAmmo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -178, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "999", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[476] = new("TextLabel", I[473], "ClipAmmo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -250, 1, -196), Size = UDim2.fromOffset(100, 75), Text = "10", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[477] = new("Frame", I[473], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -198, 1, -120), Size = UDim2.fromOffset(125, 2) })
				I[478] = new("Frame", I[473], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -273, 1, -188), Rotation = 60, Size = UDim2.fromOffset(30, 2) })
				I[479] = new("Frame", I[473], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -252, 1, -175), Size = UDim2.fromOffset(200, 2) })
				I[480] = new("Frame", I[473], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -120, 1, -127), Rotation = 110, Size = UDim2.fromOffset(100, 2) })
				I[481] = new("Frame", I[473], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.new(1, -162, 1, -81), Size = UDim2.fromOffset(75, 2) })
	I[482] = new("Tool", nil, "VIP Rocket", { CanBeDropped = false, Grip = CFrame.new(0.7, 0, -0.5, 0, 0, -1, -1, 0, 0, 0, 1, 0) })
		I[483] = new("Part", I[482], "Handle", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-261.6180725, 0.6202444, 150.1087646, 1, 0, 0, 0, 0.000063, 1.0000002, 0, -1.0000002, 0.000063), CanCollide = false, Size = Vector3.new(4.9200063, 0.7400005, 0.8399998), TopSurface = Enum.SurfaceType.Smooth })
			I[484] = new("SpecialMesh", I[483], "Mesh", { MeshContent = Content.fromUri("rbxasset://fonts/rocketlauncher.mesh"), MeshType = Enum.MeshType.FileMesh, Scale = Vector3.new(0.75, 0.75, 0.75), TextureContent = Content.fromUri("rbxasset://textures/rocketlaunchertex.png") })
		I[485] = new("Sound", I[482], "Boom", { Volume = 1 })
		I[486] = new("Sound", I[482], "Swoosh", { Looped = true, Volume = 0.7 })
		I[487] = new("Configuration", I[482], "Configurations")
			I[488] = new("NumberValue", I[487], "AttackCooldown", { Value = 3 })
			I[489] = new("IntValue", I[487], "Damage", { Value = 60 })
			I[490] = new("NumberValue", I[487], "ReloadTime", { Value = 1 })
			I[491] = new("IntValue", I[487], "BlastForce", { Value = 1000 })
			I[492] = new("IntValue", I[487], "BlastRadius", { Value = 8 })
			I[493] = new("IntValue", I[487], "RocketSpeed", { Value = 60 })
	I[494] = new("Tool", nil, "Venomshank", { Grip = CFrame.new(0, 0, -2, 0, 0, 1, 1, 0, 0, 0, 1, 0) })
		I[495] = new("Part", I[494], "Handle", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-37.5000305, 4.1999998, 185.6000061, 0.9999998, 0, 0, 0, -0.0000001, 0.9999999, 0, -0.9999999, -0.0000001), Color = Color3.fromRGB(99, 95, 98), Reflectance = 0.7, Size = Vector3.new(1, 0.8, 6), TopSurface = Enum.SurfaceType.Smooth })
			I[496] = new("SpecialMesh", I[495], "Mesh", { MeshContent = Content.fromUri("rbxasset://fonts/sword.mesh"), MeshType = Enum.MeshType.FileMesh, Scale = Vector3.new(1.5, 1.5, 1.5), TextureContent = Content.fromUri("rbxasset://textures/SwordTexture.png"), VertexColor = Vector3.new(0.3, 1, 0.3) })
			I[497] = new("Sound", I[495], "Sound", { Volume = 0.7 })
			I[498] = new("Sound", I[495], "Sound", { Volume = 0.6 })
			I[499] = new("Sound", I[495], "Sound", { Volume = 1 })
			I[500] = new("Sound", I[495], "Sound", { Volume = 0.7 })
			I[501] = new("Sound", I[495], "Sound", { Volume = 0.6 })
			I[502] = new("Sound", I[495], "Sound", { Volume = 1 })
			I[503] = new("Sound", I[495], "Sound", { Volume = 0.7 })
			I[504] = new("Sound", I[495], "Sound", { Volume = 0.6 })
			I[505] = new("Sound", I[495], "Sound", { Volume = 1 })
			I[506] = new("Sound", I[495], "Sound", { Volume = 0.7 })
			I[507] = new("Sound", I[495], "Sound", { Volume = 0.6 })
			I[508] = new("Sound", I[495], "Sound", { Volume = 1 })
			I[509] = new("Sound", I[495], "Sound", { Volume = 0.7 })
			I[510] = new("Sound", I[495], "Sound", { Volume = 0.6 })
			I[511] = new("Sound", I[495], "Sound", { Volume = 1 })
	I[512] = new("Sky", nil, "Sky", { SkyboxBackContent = Content.fromUri("http://www.roblox.com/asset/?version=1&id=1010388"), SkyboxDownContent = Content.fromUri("http://www.roblox.com/asset/?version=1&id=1010389"), SkyboxFrontContent = Content.fromUri("http://www.roblox.com/asset/?version=1&id=1010386"), SkyboxLeftContent = Content.fromUri("http://www.roblox.com/asset/?version=1&id=1010387"), SkyboxRightContent = Content.fromUri("http://www.roblox.com/asset/?version=1&id=1010385"), SkyboxUpContent = Content.fromUri("http://www.roblox.com/asset/?version=1&id=1010390") })
	I[92].Part0 = I[87]
	I[92].Part1 = I[87]
	I[93].Part0 = I[87]
	I[93].Part1 = I[233]
	I[94].Part0 = I[87]
	I[94].Part1 = I[87]
	I[95].Part0 = I[87]
	I[95].Part1 = I[87]
	I[96].Part0 = I[87]
	I[96].Part1 = I[87]
	I[97].Part0 = I[87]
	I[97].Part1 = I[87]
	I[98].Part0 = I[87]
	I[98].Part1 = I[87]
	I[99].Part0 = I[87]
	I[99].Part1 = I[87]
	I[100].Part0 = I[87]
	I[100].Part1 = I[87]
	I[101].Part0 = I[87]
	I[101].Part1 = I[87]
	I[102].Part0 = I[87]
	I[102].Part1 = I[87]
	I[103].Part0 = I[87]
	I[103].Part1 = I[87]
	I[104].Part0 = I[87]
	I[104].Part1 = I[87]
	I[105].Part0 = I[87]
	I[105].Part1 = I[87]
	I[106].Part0 = I[87]
	I[106].Part1 = I[87]
	I[107].Part0 = I[87]
	I[107].Part1 = I[87]
	I[108].Part0 = I[87]
	I[108].Part1 = I[87]
	I[109].Part0 = I[87]
	I[109].Part1 = I[87]
	I[110].Part0 = I[87]
	I[110].Part1 = I[87]
	I[111].Part0 = I[87]
	I[111].Part1 = I[87]
	I[112].Part0 = I[87]
	I[112].Part1 = I[87]
	I[113].Part0 = I[87]
	I[113].Part1 = I[87]
	I[114].Part0 = I[87]
	I[114].Part1 = I[87]
	I[115].Part0 = I[87]
	I[115].Part1 = I[87]
	I[116].Part0 = I[87]
	I[116].Part1 = I[87]
	I[117].Part0 = I[87]
	I[117].Part1 = I[87]
	I[118].Part0 = I[87]
	I[118].Part1 = I[87]
	I[119].Part0 = I[87]
	I[119].Part1 = I[87]
	I[120].Part0 = I[87]
	I[120].Part1 = I[87]
	I[121].Part0 = I[87]
	I[121].Part1 = I[87]
	I[122].Part0 = I[87]
	I[122].Part1 = I[87]
	I[123].Part0 = I[87]
	I[123].Part1 = I[87]
	I[124].Part0 = I[87]
	I[124].Part1 = I[87]
	I[125].Part0 = I[87]
	I[125].Part1 = I[87]
	I[126].Part0 = I[87]
	I[126].Part1 = I[87]
	I[127].Part0 = I[87]
	I[127].Part1 = I[87]
	I[128].Part0 = I[87]
	I[128].Part1 = I[87]
	I[129].Part0 = I[87]
	I[129].Part1 = I[87]
	I[130].Part0 = I[87]
	I[130].Part1 = I[87]
	I[131].Part0 = I[87]
	I[131].Part1 = I[87]
	I[132].Part0 = I[87]
	I[132].Part1 = I[87]
	I[133].Part0 = I[87]
	I[133].Part1 = I[87]
	I[134].Part0 = I[87]
	I[134].Part1 = I[87]
	I[135].Part0 = I[87]
	I[135].Part1 = I[87]
	I[136].Part0 = I[87]
	I[136].Part1 = I[87]
	I[137].Part0 = I[87]
	I[137].Part1 = I[87]
	I[138].Part0 = I[87]
	I[138].Part1 = I[87]
	I[139].Part0 = I[87]
	I[139].Part1 = I[87]
	I[140].Part0 = I[87]
	I[140].Part1 = I[87]
	I[141].Part0 = I[87]
	I[141].Part1 = I[87]
	I[142].Part0 = I[87]
	I[142].Part1 = I[87]
	I[143].Part0 = I[87]
	I[143].Part1 = I[87]
	I[144].Part0 = I[87]
	I[144].Part1 = I[87]
	I[145].Part0 = I[87]
	I[145].Part1 = I[87]
	I[146].Part0 = I[87]
	I[146].Part1 = I[87]
	I[147].Part0 = I[87]
	I[147].Part1 = I[87]
	I[148].Part0 = I[87]
	I[148].Part1 = I[87]
	I[149].Part0 = I[87]
	I[149].Part1 = I[87]
	I[150].Part0 = I[87]
	I[150].Part1 = I[87]
	I[151].Part0 = I[87]
	I[151].Part1 = I[87]
	I[152].Part0 = I[87]
	I[152].Part1 = I[87]
	I[153].Part0 = I[87]
	I[153].Part1 = I[87]
	I[154].Part0 = I[87]
	I[154].Part1 = I[87]
	I[155].Part0 = I[87]
	I[155].Part1 = I[87]
	I[156].Part0 = I[87]
	I[156].Part1 = I[87]
	I[157].Part0 = I[87]
	I[157].Part1 = I[87]
	I[158].Part0 = I[87]
	I[158].Part1 = I[87]
	I[159].Part0 = I[87]
	I[159].Part1 = I[87]
	I[160].Part0 = I[87]
	I[160].Part1 = I[87]
	I[161].Part0 = I[87]
	I[161].Part1 = I[87]
	I[162].Part0 = I[87]
	I[162].Part1 = I[87]
	I[163].Part0 = I[87]
	I[163].Part1 = I[87]
	I[164].Part0 = I[87]
	I[164].Part1 = I[87]
	I[165].Part0 = I[87]
	I[165].Part1 = I[87]
	I[166].Part0 = I[87]
	I[166].Part1 = I[87]
	I[167].Part0 = I[87]
	I[167].Part1 = I[87]
	I[168].Part0 = I[87]
	I[168].Part1 = I[87]
	I[169].Part0 = I[87]
	I[169].Part1 = I[87]
	I[170].Part0 = I[87]
	I[170].Part1 = I[87]
	I[171].Part0 = I[87]
	I[171].Part1 = I[87]
	I[172].Part0 = I[87]
	I[172].Part1 = I[87]
	I[173].Part0 = I[87]
	I[173].Part1 = I[87]
	I[174].Part0 = I[87]
	I[174].Part1 = I[87]
	I[175].Part0 = I[87]
	I[175].Part1 = I[87]
	I[176].Part0 = I[87]
	I[176].Part1 = I[87]
	I[177].Part0 = I[87]
	I[177].Part1 = I[87]
	I[178].Part0 = I[87]
	I[178].Part1 = I[87]
	I[179].Part0 = I[87]
	I[179].Part1 = I[87]
	I[180].Part0 = I[87]
	I[180].Part1 = I[87]
	I[181].Part0 = I[87]
	I[181].Part1 = I[87]
	I[182].Part0 = I[87]
	I[182].Part1 = I[87]
	I[183].Part0 = I[87]
	I[183].Part1 = I[87]
	I[184].Part0 = I[87]
	I[184].Part1 = I[87]
	I[185].Part0 = I[87]
	I[185].Part1 = I[87]
	I[186].Part0 = I[87]
	I[186].Part1 = I[87]
	I[187].Part0 = I[87]
	I[187].Part1 = I[87]
	I[188].Part0 = I[87]
	I[188].Part1 = I[87]
	I[189].Part0 = I[87]
	I[189].Part1 = I[87]
	I[190].Part0 = I[87]
	I[190].Part1 = I[87]
	I[191].Part0 = I[87]
	I[191].Part1 = I[87]
	I[192].Part0 = I[87]
	I[192].Part1 = I[87]
	I[193].Part0 = I[87]
	I[193].Part1 = I[87]
	I[194].Part0 = I[87]
	I[194].Part1 = I[87]
	I[195].Part0 = I[87]
	I[195].Part1 = I[87]
	I[196].Part0 = I[87]
	I[196].Part1 = I[87]
	I[197].Part0 = I[87]
	I[197].Part1 = I[87]
	I[198].Part0 = I[87]
	I[198].Part1 = I[87]
	I[199].Part0 = I[87]
	I[199].Part1 = I[87]
	I[200].Part0 = I[87]
	I[200].Part1 = I[87]
	I[201].Part0 = I[87]
	I[201].Part1 = I[87]
	I[202].Part0 = I[87]
	I[202].Part1 = I[87]
	I[203].Part0 = I[87]
	I[203].Part1 = I[87]
	I[204].Part0 = I[87]
	I[204].Part1 = I[87]
	I[205].Part0 = I[87]
	I[205].Part1 = I[87]
	I[206].Part0 = I[87]
	I[206].Part1 = I[87]
	I[207].Part0 = I[87]
	I[207].Part1 = I[87]
	I[208].Part0 = I[87]
	I[208].Part1 = I[87]
	I[209].Part0 = I[87]
	I[209].Part1 = I[87]
	I[210].Part0 = I[87]
	I[210].Part1 = I[87]
	I[211].Part0 = I[87]
	I[211].Part1 = I[87]
	I[212].Part0 = I[87]
	I[212].Part1 = I[87]
	I[213].Part0 = I[87]
	I[213].Part1 = I[87]
	I[214].Part0 = I[87]
	I[214].Part1 = I[87]
	I[215].Part0 = I[87]
	I[215].Part1 = I[87]
	I[216].Part0 = I[87]
	I[216].Part1 = I[87]
	I[217].Part0 = I[87]
	I[217].Part1 = I[87]
	I[218].Part0 = I[87]
	I[218].Part1 = I[87]
	I[219].Part0 = I[87]
	I[219].Part1 = I[87]
	I[220].Part0 = I[87]
	I[220].Part1 = I[87]
	I[221].Part0 = I[87]
	I[221].Part1 = I[87]
	I[222].Part0 = I[87]
	I[222].Part1 = I[87]
	I[223].Part0 = I[87]
	I[223].Part1 = I[87]
	I[224].Part0 = I[87]
	I[224].Part1 = I[87]
	I[225].Part0 = I[87]
	I[225].Part1 = I[87]
	I[226].Part0 = I[87]
	I[226].Part1 = I[87]
	I[227].Part0 = I[87]
	I[227].Part1 = I[87]
	I[228].Part0 = I[87]
	I[228].Part1 = I[87]
	I[229].Part0 = I[87]
	I[229].Part1 = I[87]
	I[230].Part0 = I[87]
	I[230].Part1 = I[87]
	I[231].Part0 = I[87]
	I[231].Part1 = I[87]
	I[232].Part0 = I[87]
	I[232].Part1 = I[87]
	return { I[1], I[29], I[57], I[81], I[86], I[255], I[282], I[310], I[316], I[330], I[354], I[366], I[394], I[398], I[422], I[450], I[454], I[482], I[494], I[512] }
end

return build
