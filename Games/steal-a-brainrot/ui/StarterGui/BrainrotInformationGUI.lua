-- Generated from ui/StarterGui/BrainrotInformationGUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "BrainrotInformationGUI", { Enabled = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_5fb7a31383" })
		I[2] = new("Frame", I[1], "PrincipalFrame", { BackgroundColor3 = Color3.fromRGB(29, 29, 29), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.2684391, 0.0865007), Size = UDim2.fromScale(0.4533221, 0.8068646) }, { ["ViralWorkerRef"] = "vw_91c9c92ddd" })
			I[3] = new("UICorner", I[2], "UICorner", nil, { ["ViralWorkerRef"] = "vw_2af32126ed" })
			I[4] = new("UIStroke", I[2], "UIStroke", { Thickness = 2 }, { ["ViralWorkerRef"] = "vw_b106539d91" })
			I[5] = new("ViewportFrame", I[2], "ViewportFrame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0257369, 0.0203997), Size = UDim2.fromScale(0.2690166, 0.2282092) }, { ["ViralWorkerRef"] = "vw_28f7c241ed" })
				I[6] = new("UICorner", I[5], "UICorner", nil, { ["ViralWorkerRef"] = "vw_6832869d46" })
				I[7] = new("UIStroke", I[5], "UIStroke", { Thickness = 2 }, { ["ViralWorkerRef"] = "vw_a4d635daca" })
				I[8] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint", { AspectRatio = 1.0069444 }, { ["ViralWorkerRef"] = "vw_2644997de7" })
			I[9] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 0.8541997 }, { ["ViralWorkerRef"] = "vw_c3b0c0da56" })
			I[10] = new("TextLabel", I[2], "BrainrotLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2940089, 0.0193186), RichText = true, Size = UDim2.fromScale(0.2974883, 0.0743025), Text = "Name", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_bb6bbad9fb" })
				I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 3 }, { ["ViralWorkerRef"] = "vw_d71337d6e4" })
				I[12] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint", { AspectRatio = 3.4200001 }, { ["ViralWorkerRef"] = "vw_a48df3288e" })
				I[13] = new("UITextSizeConstraint", I[10], "UITextSizeConstraint", { MaxTextSize = 50 }, { ["ViralWorkerRef"] = "vw_d027756095" })
			I[14] = new("TextLabel", I[2], "MutationLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2947535, 0.0936211), RichText = true, Size = UDim2.fromScale(0.2644341, 0.060928), Text = "Mutation", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_8cc3930b0e" })
				I[15] = new("UIStroke", I[14], "UIStroke", { Thickness = 3 }, { ["ViralWorkerRef"] = "vw_0fe8439269" })
				I[16] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint", { AspectRatio = 3.7073171 }, { ["ViralWorkerRef"] = "vw_ecbfa9af72" })
				I[17] = new("UITextSizeConstraint", I[14], "UITextSizeConstraint", { MaxTextSize = 41 }, { ["ViralWorkerRef"] = "vw_c588e187a9" })
			I[18] = new("ImageLabel", I[2], "PlayerIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Position = UDim2.fromScale(0.3114059, 0.1634654), Size = UDim2.fromScale(0.0974231, 0.0802467) }, { ["ViralWorkerRef"] = "vw_6d93a5ea7c" })
				I[19] = new("UICorner", I[18], "UICorner", nil, { ["ViralWorkerRef"] = "vw_9ed65fd607" })
				I[20] = new("UIStroke", I[18], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 }, { ["ViralWorkerRef"] = "vw_1ccc6fc32c" })
				I[21] = new("UIAspectRatioConstraint", I[18], "UIAspectRatioConstraint", { AspectRatio = 1.037037 }, { ["ViralWorkerRef"] = "vw_ad781384c3" })
			I[22] = new("TextLabel", I[2], "PlayerNameLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4200117, 0.1723817), RichText = true, Size = UDim2.fromScale(0.3357617, 0.060928), Text = "Player Name", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_08b8b233b6" })
				I[23] = new("UIStroke", I[22], "UIStroke", { Thickness = 3 }, { ["ViralWorkerRef"] = "vw_a0c0e4646d" })
				I[24] = new("UIAspectRatioConstraint", I[22], "UIAspectRatioConstraint", { AspectRatio = 4.7073169 }, { ["ViralWorkerRef"] = "vw_b9c1cbcd6e" })
				I[25] = new("UITextSizeConstraint", I[22], "UITextSizeConstraint", { MaxTextSize = 41 }, { ["ViralWorkerRef"] = "vw_6ad7377dba" })
			I[26] = new("TextLabel", I[2], "BrainrotCashLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6128567, 0.0326931), RichText = true, Size = UDim2.fromScale(0.3357617, 0.1218561), Text = "Price", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_44ddb05d45" })
				I[27] = new("UIStroke", I[26], "UIStroke", { Thickness = 3 }, { ["ViralWorkerRef"] = "vw_09437c1ec6" })
				I[28] = new("UIAspectRatioConstraint", I[26], "UIAspectRatioConstraint", { AspectRatio = 2.3536584 }, { ["ViralWorkerRef"] = "vw_7efcce2a2f" })
				I[29] = new("UITextSizeConstraint", I[26], "UITextSizeConstraint", { MaxTextSize = 82 }, { ["ViralWorkerRef"] = "vw_6ad969d9a6" })
			I[30] = new("TextLabel", I[2], "DateLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.024966, 0.2482964), RichText = true, Size = UDim2.fromScale(0.2626944, 0.0743025), Text = "Date", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_9103764087" })
				I[31] = new("UIStroke", I[30], "UIStroke", { Thickness = 3 }, { ["ViralWorkerRef"] = "vw_fac440a439" })
				I[32] = new("UIAspectRatioConstraint", I[30], "UIAspectRatioConstraint", { AspectRatio = 3.02 }, { ["ViralWorkerRef"] = "vw_64a18dbc8b" })
				I[33] = new("UITextSizeConstraint", I[30], "UITextSizeConstraint", { MaxTextSize = 50 }, { ["ViralWorkerRef"] = "vw_f2efce0aee" })
			I[34] = new("TextLabel", I[2], "TimeLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0499322, 0.3122746), RichText = true, Size = UDim2.fromScale(0.2193454, 0.0548385), Text = "10:23:46", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_0f36108aef" })
				I[35] = new("UIStroke", I[34], "UIStroke", { Thickness = 3 }, { ["ViralWorkerRef"] = "vw_63b740047b" })
				I[36] = new("UIAspectRatioConstraint", I[34], "UIAspectRatioConstraint", { AspectRatio = 3.4166667 }, { ["ViralWorkerRef"] = "vw_24697da1a8" })
				I[37] = new("UITextSizeConstraint", I[34], "UITextSizeConstraint", { MaxTextSize = 36 }, { ["ViralWorkerRef"] = "vw_107cf74d97" })
			I[38] = new("TextLabel", I[2], "TraitsTitleLabel", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0124831, 0.3784764), RichText = true, Size = UDim2.fromScale(0.9750338, 0.0746621), Text = "Traits", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_05440908a8" })
				I[39] = new("UIStroke", I[38], "UIStroke", { Thickness = 3 }, { ["ViralWorkerRef"] = "vw_2f6988f8a0" })
				I[40] = new("UIStroke", I[38], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 }, { ["ViralWorkerRef"] = "vw_ac691dd109" })
				I[41] = new("UICorner", I[38], "UICorner", nil, { ["ViralWorkerRef"] = "vw_7f718cadcc" })
			I[42] = new("TextLabel", I[2], "TraitsLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0254759, 0.4668273), RichText = true, Size = UDim2.fromScale(0.9456531, 0.4097451), Text = "Traits", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_a88add088d" })
				I[43] = new("UIStroke", I[42], "UIStroke", { Thickness = 3 }, { ["ViralWorkerRef"] = "vw_0474aef24c" })
			I[44] = new("ImageButton", I[2], "ExitButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://5198838744"), Position = UDim2.fromScale(0.9255306, 0), Size = UDim2.fromScale(0.0731151, 0.0670248) }, { ["ViralWorkerRef"] = "vw_841eaa7b53" })
				I[45] = new("UICorner", I[44], "UICorner", nil, { ["ViralWorkerRef"] = "vw_cf9154ba55" })
				I[46] = new("UIAspectRatioConstraint", I[44], "UIAspectRatioConstraint", { AspectRatio = 0.9318182 }, { ["ViralWorkerRef"] = "vw_49a8266a6e" })
			I[47] = new("TextButton", I[2], "DeleteButton", { BackgroundColor3 = Color3.fromRGB(255, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0248718, 0.8896465), RichText = true, Size = UDim2.fromScale(0.9508678, 0.0964218), Text = "DELET", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_099309ba23" })
				I[48] = new("UIStroke", I[47], "UIStroke", { Thickness = 3 }, { ["ViralWorkerRef"] = "vw_4870aab6d8" })
				I[49] = new("UIStroke", I[47], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 }, { ["ViralWorkerRef"] = "vw_7492eb1e11" })
				I[50] = new("UICorner", I[47], "UICorner", nil, { ["ViralWorkerRef"] = "vw_7fe5599dc9" })
				I[51] = new("UIAspectRatioConstraint", I[47], "UIAspectRatioConstraint", { AspectRatio = 8.4237289 }, { ["ViralWorkerRef"] = "vw_015260bdc5" })
				I[52] = new("UITextSizeConstraint", I[47], "UITextSizeConstraint", { MaxTextSize = 59 }, { ["ViralWorkerRef"] = "vw_5a80267ff6" })
		I[53] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 1.5203837 }, { ["ViralWorkerRef"] = "vw_f580b73ee0" })
	return I[1]
end

return build
