-- Generated from ui/StarterGui/Awakening Outfit.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Awakening Outfit", { Enabled = false })
		I[2] = new("TextButton", I[1], "TextButton", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderSizePixel = 0, ClipsDescendants = true, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.new(0.8, 0, 0, 25), Text = "Griddy", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 4 })
			I[3] = new("UITextSizeConstraint", I[2], "UITextSizeConstraint", { MaxTextSize = 18 })
			I[4] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 8.3999996 })
		I[5] = new("ImageButton", I[1], "MovesetTemplate", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(70, 70, 70), ImageContent = Content.fromUri("rbxassetid://17140853847"), Size = UDim2.fromScale(0.9, 0.9), ZIndex = 2 })
			I[6] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint")
		I[7] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.4765886), Size = UDim2.fromScale(0.2213053, 0.0985037) })
			I[8] = new("TextButton", I[7], "Apply", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4967395, -0.8267398), Size = UDim2.fromScale(1.2807274, 0.4430379), Text = "APPLY", TextColor3 = Color3.fromRGB(184, 255, 103), TextScaled = true, TextSize = 35, TextWrapped = true, ZIndex = 3 })
				I[9] = new("UITextSizeConstraint", I[8], "UITextSizeConstraint", { MaxTextSize = 35 })
				I[10] = new("ImageLabel", I[8], "Glow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(106, 207, 118), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=7274452334"), ImageTransparency = 0.8, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(2, 6) })
			I[11] = new("UIAspectRatioConstraint", I[7], "UIAspectRatioConstraint", { AspectRatio = 3.7341771 })
			I[12] = new("ScrollingFrame", I[7], "ScrollingFrame", { Active = true, AnchorPoint = Vector2.new(0.5, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromOffset(0, 12), Position = UDim2.fromScale(0.8056622, -0.2475327), ScrollBarThickness = 5, Size = UDim2.fromScale(0.6628818, 2.2690415), ZIndex = 3 })
				I[13] = new("UIListLayout", I[12], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.015, 0), SortOrder = Enum.SortOrder.LayoutOrder })
				I[14] = new("UIAspectRatioConstraint", I[12], "UIAspectRatioConstraint", { AspectRatio = 1.0909091 })
			I[15] = new("ViewportFrame", I[7], "ViewportFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LightColor = Color3.fromRGB(255, 255, 255), LightDirection = Vector3.new(-1, -15, 2), Position = UDim2.fromScale(-0.1473071, -0.5500707), Size = UDim2.fromScale(0.6206843, 2.5844879), ZIndex = 3 })
				I[16] = new("WorldModel", I[15], "WorldModel")
					I[17] = new("Model", I[16], "Preview", nil, { ["Finisherd"] = true, ["KillRegged"] = true, ["NPC"] = true })
						I[18] = new("BodyColors", I[17], "Body Colors", { HeadColor3 = Color3.fromRGB(245, 205, 48), LeftArmColor3 = Color3.fromRGB(245, 205, 48), LeftLegColor3 = Color3.fromRGB(164, 189, 71), RightArmColor3 = Color3.fromRGB(245, 205, 48), RightLegColor3 = Color3.fromRGB(164, 189, 71), TorsoColor3 = Color3.fromRGB(13, 105, 172) })
						I[19] = new("Part", I[17], "HumanoidRootPart", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(150.124115, 440.7747192, 11.4481153, 0.9238815, 0, 0.3826786, 0, 1, 0, -0.3826786, 0, 0.9238815), CanCollide = false, CollisionGroup = "playercol", CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5, 1, 1), EnableFluidForces = false, Size = Vector3.new(2, 2, 1), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
							I[20] = new("ParticleEmitter", I[19], "Silhouette", { Brightness = 5, Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }), Enabled = false, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid8x8, FlipbookMode = Enum.ParticleFlipbookMode.OneShot, Lifetime = NumberRange.new(0.5, 0.5), Orientation = Enum.ParticleOrientation.FacingCameraWorldUp, Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.0869565, 3.2108746), NumberSequenceKeypoint.new(0.1956522, 4.5573702), NumberSequenceKeypoint.new(1, 5.7485013) }), Speed = NumberRange.new(19.415432, 19.415432), Squash = NumberSequence.new({ NumberSequenceKeypoint.new(0, -2.4750001), NumberSequenceKeypoint.new(0.0401837, -0.375), NumberSequenceKeypoint.new(0.1056257, 0.1499999), NumberSequenceKeypoint.new(0.3570608, 0.3374999), NumberSequenceKeypoint.new(0.5522388, 0.4125001), NumberSequenceKeypoint.new(0.8300803, 0.5625), NumberSequenceKeypoint.new(1, 1.5) }), TextureContent = Content.fromUri("rbxassetid://13471193819"), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.1820449, 0.4875), NumberSequenceKeypoint.new(0.380829, 0.6038647), NumberSequenceKeypoint.new(0.607513, 0.8743961), NumberSequenceKeypoint.new(1, 1) }), ZOffset = 2.5324478 }, { ["EmitCount"] = 1 })
							I[21] = new("ParticleEmitter", I[19], "Explode", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(47, 47, 47)), ColorSequenceKeypoint.new(0.4725457, Color3.fromRGB(27, 9, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 38, 38)) }), Drag = 5, EmissionDirection = Enum.NormalId.Front, Enabled = false, Lifetime = NumberRange.new(0.2, 0.6), LightEmission = -0.2, Orientation = Enum.ParticleOrientation.VelocityPerpendicular, Rate = 300, RotSpeed = NumberRange.new(-15, 15), Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.2606597, 5.9375), NumberSequenceKeypoint.new(1, 5.4375) }), Speed = NumberRange.new(0.01, 0.01), SpreadAngle = Vector2.new(-360, 360), Squash = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.0819674, 0.622951), NumberSequenceKeypoint.new(1, 1) }), TextureContent = Content.fromUri("rbxassetid://5407030718"), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4764638, 0), NumberSequenceKeypoint.new(1, 1) }) })
							I[22] = new("Attachment", I[19], "Teleport", { CFrame = CFrame.new(0, 0.0000305, -2.5999832, -1, 0, 0, 0, 1, 0, 0, 0, -1) })
							I[23] = new("Attachment", I[19], "ExtraEffects", { CFrame = CFrame.new(0, 0.2219807, 0) })
							I[24] = new("Motor6D", I[19], "RootJoint", { C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
							I[25] = new("Trail", I[19], "AirTrail", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 200, 200)), ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200)) }), Enabled = false, FaceCamera = true, Lifetime = 1, LightInfluence = 1, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.25), NumberSequenceKeypoint.new(1, 1) }), WidthScale = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) }) })
							I[26] = new("Attachment", I[19], "Back", { CFrame = CFrame.new(0, 0, 1.0045319) })
							I[27] = new("Attachment", I[19], "Forward")
							I[28] = new("Attachment", I[19], "Lightweight", { CFrame = CFrame.new(0, -3.0189304, 0) })
								I[29] = new("Sound", I[28], "Wind", { Looped = true, PlaybackSpeed = 2, RollOffMaxDistance = 100, RollOffMode = Enum.RollOffMode.InverseTapered })
								I[30] = new("ParticleEmitter", I[28], "Air", { Acceleration = Vector3.new(0, 40, 0), Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 170, 170)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 170, 170)) }), EmissionDirection = Enum.NormalId.Bottom, Enabled = false, Lifetime = NumberRange.new(0.3, 0.5), LightEmission = 0.6, LightInfluence = 1, LockedToPart = true, Orientation = Enum.ParticleOrientation.VelocityPerpendicular, Rate = 25, RotSpeed = NumberRange.new(-495, -495), Rotation = NumberRange.new(-360, 360), Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.142638, 1.6909617), NumberSequenceKeypoint.new(0.4539733, 3.5625, 1), NumberSequenceKeypoint.new(0.7741935, 0.4374999, 0.4374999), NumberSequenceKeypoint.new(1, 0) }), Speed = NumberRange.new(0.05, 0.05), SpreadAngle = Vector2.new(-5, 5), TextureContent = Content.fromUri("rbxassetid://5726444189"), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1136625, 0.26875, 0.11875), NumberSequenceKeypoint.new(0.5625718, 0.625, 0.0938988), NumberSequenceKeypoint.new(1, 1) }) })
							I[31] = new("Attachment", I[19], "RootAttachment")
								I[32] = new("ParticleEmitter", I[31], "Spawn", { Brightness = 15, Drag = 10, Enabled = false, Lifetime = NumberRange.new(0.6, 0.7), LightInfluence = 1, Rate = 15, Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 3.6874998, 0.7499999), NumberSequenceKeypoint.new(1, 5.0625, 0.9375) }), Speed = NumberRange.new(50, 60), SpreadAngle = Vector2.new(-360, 360), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=688705835"), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }), ZOffset = 2 })
								I[33] = new("ParticleEmitter", I[31], "Air", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 170, 170)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 170, 170)) }), EmissionDirection = Enum.NormalId.Front, Enabled = false, Lifetime = NumberRange.new(0.35, 0.35), LightEmission = 0.6, LightInfluence = 1, LockedToPart = true, Rate = 45, RotSpeed = NumberRange.new(-500, -500), Rotation = NumberRange.new(-15555, 1555), Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.142638, 1.6909617), NumberSequenceKeypoint.new(0.398773, 3.1486881), NumberSequenceKeypoint.new(1, 3.6756754) }), Speed = NumberRange.new(2, 2), TextureContent = Content.fromUri("rbxassetid://5726444189"), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1136625, 0.26875), NumberSequenceKeypoint.new(0.5625718, 0.625, 0.0126488), NumberSequenceKeypoint.new(1, 1) }) })
								I[34] = new("ParticleEmitter", I[31], "Line", { EmissionDirection = Enum.NormalId.Bottom, Enabled = false, Lifetime = NumberRange.new(0.6, 1), LockedToPart = true, Orientation = Enum.ParticleOrientation.FacingCameraWorldUp, Rate = 25, Rotation = NumberRange.new(-180, 180), Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1.5979385), NumberSequenceKeypoint.new(0.1003984, 1.5979385), NumberSequenceKeypoint.new(0.165737, 1.958763), NumberSequenceKeypoint.new(0.238247, 2.7835054), NumberSequenceKeypoint.new(0.32749, 4.5360827), NumberSequenceKeypoint.new(0.4103586, 6.2886596), NumberSequenceKeypoint.new(0.4788845, 7.9381442), NumberSequenceKeypoint.new(0.5897845, 10), NumberSequenceKeypoint.new(1, 10) }), Speed = NumberRange.new(1, 1), TextureContent = Content.fromUri("rbxassetid://6812028248"), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0.5), NumberSequenceKeypoint.new(0.2705507, 0.8350515), NumberSequenceKeypoint.new(0.3391304, 1), NumberSequenceKeypoint.new(0.5043478, 1), NumberSequenceKeypoint.new(0.6041501, 1), NumberSequenceKeypoint.new(1, 1) }), ZOffset = -1 })
								I[35] = new("ParticleEmitter", I[31], "BitsTwo", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }), Enabled = false, Lifetime = NumberRange.new(0.6, 1), LightEmission = 1, LockedToPart = true, Rate = 1, Rotation = NumberRange.new(-180, 180), Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 10), NumberSequenceKeypoint.new(0.0530973, 4.8969073), NumberSequenceKeypoint.new(0.111, 1.6658276), NumberSequenceKeypoint.new(0.1665, 1.2068388), NumberSequenceKeypoint.new(0.222, 0.8551046), NumberSequenceKeypoint.new(0.2775, 0.5906232), NumberSequenceKeypoint.new(0.333, 0.3960504), NumberSequenceKeypoint.new(0.3885, 0.2565096), NumberSequenceKeypoint.new(0.444, 0.1594025), NumberSequenceKeypoint.new(0.4995, 0.0942197), NumberSequenceKeypoint.new(0.555, 0.0523506), NumberSequenceKeypoint.new(0.6105, 0.0268942), NumberSequenceKeypoint.new(0.666, 0.0124696), NumberSequenceKeypoint.new(0.7215, 0.0050263), NumberSequenceKeypoint.new(0.777, 0.0016544), NumberSequenceKeypoint.new(0.8325, 0.0003955), NumberSequenceKeypoint.new(0.888, 0.0000529), NumberSequenceKeypoint.new(0.9435, 0.0000017), NumberSequenceKeypoint.new(0.999, 0), NumberSequenceKeypoint.new(1, 0) }), Speed = NumberRange.new(0, 0), TextureContent = Content.fromUri("rbxassetid://1084969783"), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0.5), NumberSequenceKeypoint.new(1, 0.5) }), ZOffset = 1.5 })
								I[36] = new("ParticleEmitter", I[31], "Bits", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }), Enabled = false, Lifetime = NumberRange.new(0.6, 1), LockedToPart = true, Rate = 1, Rotation = NumberRange.new(-180, 180), Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 10), NumberSequenceKeypoint.new(0.0530973, 4.8969073), NumberSequenceKeypoint.new(0.111, 1.6658276), NumberSequenceKeypoint.new(0.1665, 1.2068388), NumberSequenceKeypoint.new(0.222, 0.8551046), NumberSequenceKeypoint.new(0.2775, 0.5906232), NumberSequenceKeypoint.new(0.333, 0.3960504), NumberSequenceKeypoint.new(0.3885, 0.2565096), NumberSequenceKeypoint.new(0.444, 0.1594025), NumberSequenceKeypoint.new(0.4995, 0.0942197), NumberSequenceKeypoint.new(0.555, 0.0523506), NumberSequenceKeypoint.new(0.6105, 0.0268942), NumberSequenceKeypoint.new(0.666, 0.0124696), NumberSequenceKeypoint.new(0.7215, 0.0050263), NumberSequenceKeypoint.new(0.777, 0.0016544), NumberSequenceKeypoint.new(0.8325, 0.0003955), NumberSequenceKeypoint.new(0.888, 0.0000529), NumberSequenceKeypoint.new(0.9435, 0.0000017), NumberSequenceKeypoint.new(0.999, 0), NumberSequenceKeypoint.new(1, 0) }), Speed = NumberRange.new(0, 0), TextureContent = Content.fromUri("rbxassetid://1084969783"), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0.5), NumberSequenceKeypoint.new(1, 0.5) }), ZOffset = 1.5 })
								I[37] = new("ParticleEmitter", I[31], "Locked", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }), Enabled = false, Lifetime = NumberRange.new(2, 2), LockedToPart = true, Rate = 5, Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 10) }), Speed = NumberRange.new(0, 0), TextureContent = Content.fromUri("rbxassetid://678262230"), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.3620274, 1), NumberSequenceKeypoint.new(0.4770716, 1), NumberSequenceKeypoint.new(0.5945294, 1), NumberSequenceKeypoint.new(1, 1) }), ZOffset = -1 })
								I[38] = new("ParticleEmitter", I[31], "Vanish", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }), Enabled = false, Lifetime = NumberRange.new(1, 1), LightEmission = 0.9, Rate = 0, RotSpeed = NumberRange.new(-180, 180), Rotation = NumberRange.new(-30, 30), Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1.9999999), NumberSequenceKeypoint.new(1, 0) }), Speed = NumberRange.new(15, 15), SpreadAngle = Vector2.new(360, 360), TextureContent = Content.fromUri("rbxassetid://288279969"), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.0675845, 0.2592592, 0.1111111), NumberSequenceKeypoint.new(0.4355444, 0.2469136, 0.1296296), NumberSequenceKeypoint.new(0.5856, 1), NumberSequenceKeypoint.new(0.893617, 1), NumberSequenceKeypoint.new(1, 1) }) })
						I[39] = new("Humanoid", I[17], "Humanoid", { BreakJointsOnDeath = false, DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None })
							I[40] = new("Animator", I[39], "Animator")
							I[41] = new("HumanoidDescription", I[39], "HumanoidDescription", { BodyTypeScale = 0, DepthScale = 0.85, Face = 3016640981, HeadScale = 0.95, HeightScale = 0.9, Pants = 1251548572, ProportionScale = 0, Shirt = 1251544706, WidthScale = 0.7 })
								I[42] = new("AccessoryDescription", I[41], "AccessoryDescription", { AccessoryType = Enum.AccessoryType.Hair, AssetId = 21354886 })
								I[43] = new("BodyPartDescription", I[41], "BodyPartDescription", { Color = Color3.fromRGB(204, 142, 105) })
								I[44] = new("BodyPartDescription", I[41], "BodyPartDescription", { BodyPart = Enum.BodyPart.LeftArm, Color = Color3.fromRGB(204, 142, 105) })
								I[45] = new("BodyPartDescription", I[41], "BodyPartDescription", { BodyPart = Enum.BodyPart.LeftLeg, Color = Color3.fromRGB(204, 142, 105) })
								I[46] = new("BodyPartDescription", I[41], "BodyPartDescription", { BodyPart = Enum.BodyPart.RightArm, Color = Color3.fromRGB(204, 142, 105) })
								I[47] = new("BodyPartDescription", I[41], "BodyPartDescription", { BodyPart = Enum.BodyPart.RightLeg, Color = Color3.fromRGB(204, 142, 105) })
								I[48] = new("BodyPartDescription", I[41], "BodyPartDescription", { BodyPart = Enum.BodyPart.Torso, Color = Color3.fromRGB(204, 142, 105) })
						I[49] = new("Part", I[17], "Right Leg", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(150.5860596, 438.7747192, 11.2567759, 0.9238815, 0, 0.3826786, 0, 1, 0, -0.3826786, 0, 0.9238815), CanCollide = false, CollisionGroup = "playercol", Color = Color3.fromRGB(164, 189, 71), EnableFluidForces = false, Size = Vector3.new(1, 2, 1) })
							I[50] = new("BallSocketConstraint", I[49], "BallSocketConstraint", { LimitsEnabled = true, Radius = 5, TwistLimitsEnabled = true })
							I[51] = new("Attachment", I[49], "Attachment0", { CFrame = CFrame.new(0, 0.5000001, 0, 0, -1, 0, 1, 0, 0, 0, 0, 1) })
							I[52] = new("Attachment", I[49], "RightFootAttachment", { CFrame = CFrame.new(0, -1, 0) })
						I[53] = new("Part", I[17], "Left Leg", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(149.6621704, 438.7747192, 11.6394548, 0.9238815, 0, 0.3826786, 0, 1, 0, -0.3826786, 0, 0.9238815), CanCollide = false, CollisionGroup = "playercol", Color = Color3.fromRGB(164, 189, 71), EnableFluidForces = false, Size = Vector3.new(1, 2, 1) })
							I[54] = new("BallSocketConstraint", I[53], "BallSocketConstraint", { LimitsEnabled = true, Radius = 5, TwistLimitsEnabled = true })
							I[55] = new("Attachment", I[53], "Attachment0", { CFrame = CFrame.new(0, 0.5000001, 0, 0, -1, 0, 1, 0, 0, 0, 0, 1) })
							I[56] = new("Attachment", I[53], "LeftFootAttachment", { CFrame = CFrame.new(0, -1, 0) })
						I[57] = new("Part", I[17], "Right Arm", { CFrame = CFrame.new(151.5099335, 440.7747192, 10.8740978, 0.9238815, 0, 0.3826786, 0, 1, 0, -0.3826786, 0, 0.9238815), CanCollide = false, CollisionGroup = "playercol", Color = Color3.fromRGB(245, 205, 48), EnableFluidForces = false, Size = Vector3.new(1, 2, 1) })
							I[58] = new("BallSocketConstraint", I[57], "BallSocketConstraint", { LimitsEnabled = true, Radius = 5, TwistLimitsEnabled = true })
							I[59] = new("Attachment", I[57], "Attachment0", { CFrame = CFrame.new(0, 0.5, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1) })
							I[60] = new("Attachment", I[57], "RightGripAttachment", { CFrame = CFrame.new(0, -1, 0) })
							I[61] = new("Attachment", I[57], "RightShoulderAttachment", { CFrame = CFrame.new(0, 1, 0) })
						I[62] = new("Part", I[17], "Left Arm", { CFrame = CFrame.new(148.7382965, 440.7747192, 12.0221329, 0.9238815, 0, 0.3826786, 0, 1, 0, -0.3826786, 0, 0.9238815), CanCollide = false, CollisionGroup = "playercol", Color = Color3.fromRGB(245, 205, 48), EnableFluidForces = false, Size = Vector3.new(1, 2, 1) })
							I[63] = new("Weld", I[62], "Rune", { C0 = CFrame.new(-0.0450439, -0.4764891, -0.4956055, 0.0034154, 0, -0.9999942, 0, 1, 0, 0.9999942, 0, 0.0034154) })
							I[64] = new("BallSocketConstraint", I[62], "BallSocketConstraint", { LimitsEnabled = true, Radius = 5, TwistLimitsEnabled = true })
							I[65] = new("Attachment", I[62], "Attachment0", { CFrame = CFrame.new(0, 0.5, 0) })
							I[66] = new("Attachment", I[62], "LeftGripAttachment", { CFrame = CFrame.new(0, -1, 0) })
							I[67] = new("Attachment", I[62], "LeftShoulderAttachment", { CFrame = CFrame.new(0, 1, 0) })
						I[68] = new("Part", I[17], "Torso", { CFrame = CFrame.new(150.124115, 440.7747192, 11.4481153, 0.9238815, 0, 0.3826786, 0, 1, 0, -0.3826786, 0, 0.9238815), CollisionGroup = "playercol", Color = Color3.fromRGB(13, 105, 172), EnableFluidForces = false, LeftSurface = Enum.SurfaceType.Weld, Massless = true, RightSurface = Enum.SurfaceType.Weld, Size = Vector3.new(2, 2, 1) })
							I[69] = new("Attachment", I[68], "RootAttachment")
								I[70] = new("ParticleEmitter", I[69], "Line", { EmissionDirection = Enum.NormalId.Bottom, Enabled = false, Lifetime = NumberRange.new(0.6, 1), LockedToPart = true, Orientation = Enum.ParticleOrientation.FacingCameraWorldUp, Rate = 25, Rotation = NumberRange.new(-180, 180), Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1.5979385), NumberSequenceKeypoint.new(0.1003984, 1.5979385), NumberSequenceKeypoint.new(0.165737, 1.958763), NumberSequenceKeypoint.new(0.238247, 2.7835054), NumberSequenceKeypoint.new(0.32749, 4.5360827), NumberSequenceKeypoint.new(0.4103586, 6.2886596), NumberSequenceKeypoint.new(0.4788845, 7.9381442), NumberSequenceKeypoint.new(0.5897845, 10), NumberSequenceKeypoint.new(1, 10) }), Speed = NumberRange.new(1, 1), TextureContent = Content.fromUri("rbxassetid://6812028248"), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0.5), NumberSequenceKeypoint.new(0.2705507, 0.8350515), NumberSequenceKeypoint.new(0.3391304, 1), NumberSequenceKeypoint.new(0.5043478, 1), NumberSequenceKeypoint.new(0.6041501, 1), NumberSequenceKeypoint.new(1, 1) }), ZOffset = -1 })
							I[71] = new("BallSocketConstraint", I[68], "BallSocketConstraint", { LimitsEnabled = true, Radius = 5, TwistLimitsEnabled = true })
							I[72] = new("Attachment", I[68], "LeftLAttach", { CFrame = CFrame.new(-0.5, -1.5, 0, 0, -1, 0, 1, 0, 0, 0, 0, 1) })
							I[73] = new("Attachment", I[68], "LeftRAttach", { CFrame = CFrame.new(0.5, -1.5, 0, 0, -1, 0, 1, 0, 0, 0, 0, 1) })
							I[74] = new("Attachment", I[68], "RightAttach", { CFrame = CFrame.new(1.5, 0.5, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1) })
							I[75] = new("Attachment", I[68], "LeftAttach", { CFrame = CFrame.new(-1.5, 0.5, 0) })
							I[76] = new("Attachment", I[68], "Attachment0", { CFrame = CFrame.new(0, 1.5, 0, 0, -1, 0, 1, 0, 0, 0, 0, 1) })
							I[77] = new("Motor6D", I[68], "Neck", { C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
							I[78] = new("Motor6D", I[68], "Left Hip", { C0 = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), MaxVelocity = 0.1 })
							I[79] = new("Motor6D", I[68], "Right Hip", { C0 = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), MaxVelocity = 0.1 })
							I[80] = new("Motor6D", I[68], "Left Shoulder", { C0 = CFrame.new(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), MaxVelocity = 0.1 })
							I[81] = new("Motor6D", I[68], "Right Shoulder", { C0 = CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), MaxVelocity = 0.1 })
							I[82] = new("Attachment", I[68], "WaistBackAttachment", { CFrame = CFrame.new(0, -1, 0.5) })
							I[83] = new("Attachment", I[68], "WaistCenterAttachment", { CFrame = CFrame.new(0, -1, 0) })
							I[84] = new("Attachment", I[68], "WaistFrontAttachment", { CFrame = CFrame.new(0, -1, -0.5) })
							I[85] = new("Attachment", I[68], "RightCollarAttachment", { CFrame = CFrame.new(1, 1, 0) })
							I[86] = new("Attachment", I[68], "LeftCollarAttachment", { CFrame = CFrame.new(-1, 1, 0) })
							I[87] = new("Attachment", I[68], "BodyBackAttachment", { CFrame = CFrame.new(0, 0, 0.5) })
							I[88] = new("Attachment", I[68], "BodyFrontAttachment", { CFrame = CFrame.new(0, 0, -0.5) })
							I[89] = new("Attachment", I[68], "NeckAttachment", { CFrame = CFrame.new(0, 1, 0) })
							I[90] = new("Decal", I[68], "roblox")
						I[91] = new("Part", I[17], "Head", { CFrame = CFrame.new(150.124115, 442.2747192, 11.4481153, 0.9238815, 0, 0.3826786, 0, 1, 0, -0.3826786, 0, 0.9238815), CollisionGroup = "playercol", Color = Color3.fromRGB(245, 205, 48), EnableFluidForces = false, Material = Enum.Material.SmoothPlastic, Size = Vector3.new(2, 1, 1), TopSurface = Enum.SurfaceType.Smooth })
							I[92] = new("SpecialMesh", I[91], "Mesh", { Scale = Vector3.new(1.25, 1.25, 1.25) })
								I[93] = new("Vector3Value", I[92], "OriginalSize", { Value = Vector3.new(1.25, 1.25, 1.25) })
							I[94] = new("Attachment", I[91], "FaceCenterAttachment")
							I[95] = new("Attachment", I[91], "FaceFrontAttachment", { CFrame = CFrame.new(0, 0, -0.6) })
							I[96] = new("Attachment", I[91], "HatAttachment", { CFrame = CFrame.new(0, 0.6, 0) })
							I[97] = new("Attachment", I[91], "HairAttachment", { CFrame = CFrame.new(0, 0.6, 0) })
			I[98] = new("ScrollingFrame", I[7], "Characters", { Active = true, AnchorPoint = Vector2.new(0.5, 0), AutomaticCanvasSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromOffset(341, 0), Position = UDim2.fromScale(0.4960002, 2.0263739), ScrollBarThickness = 1, Size = UDim2.fromScale(1.2822058, 0.5765318), ZIndex = 3 })
				I[99] = new("UIAspectRatioConstraint", I[98], "UIAspectRatioConstraint", { AspectRatio = 8.3048029 })
				I[100] = new("UIListLayout", I[98], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.015, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[101] = new("ImageLabel", I[1], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=7274452334"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.4996249, 0.5), Size = UDim2.fromScale(1.8754689, 0.9351621) })
			I[102] = new("UIAspectRatioConstraint", I[101], "UIAspectRatioConstraint", { AspectRatio = 3.3333333 })
	I[16].PrimaryPart = I[19]
	I[17].PrimaryPart = I[19]
	I[24].Part0 = I[19]
	I[24].Part1 = I[68]
	I[25].Attachment0 = I[26]
	I[25].Attachment1 = I[27]
	I[50].Attachment0 = I[51]
	I[50].Attachment1 = I[73]
	I[54].Attachment0 = I[55]
	I[54].Attachment1 = I[72]
	I[58].Attachment0 = I[59]
	I[58].Attachment1 = I[74]
	I[63].Part0 = I[62]
	I[64].Attachment0 = I[65]
	I[64].Attachment1 = I[75]
	I[71].Attachment0 = I[76]
	I[77].Part0 = I[68]
	I[77].Part1 = I[91]
	I[78].Part0 = I[68]
	I[78].Part1 = I[53]
	I[79].Part0 = I[68]
	I[79].Part1 = I[49]
	I[80].Part0 = I[68]
	I[80].Part1 = I[62]
	I[81].Part0 = I[68]
	I[81].Part1 = I[57]
	return I[1]
end

return build
