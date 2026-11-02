-- Generated from ui/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Domain/GojoDomain_Template.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "GojoDomain_Template", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Size = UDim2.fromScale(1, 0.4) })
		I[2] = new("ImageLabel", I[1], "BlurryBackground", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=80547425846415"), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(5, 2.5), ZIndex = -1 })
		I[3] = new("ViewportFrame", I[1], "ViewportFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 0 })
			I[4] = new("WorldModel", I[3], "WorldModel")
				I[5] = new("Part", I[4], "Torso", { CFrame = CFrame.new(29.5, 3, -1, 0, 0, 1, 0, 1, 0, -1, 0, 0), Color = Color3.fromRGB(99, 95, 98), EnableFluidForces = false, LeftSurface = Enum.SurfaceType.Weld, RightSurface = Enum.SurfaceType.Weld, Size = Vector3.new(2, 2, 1) })
					I[6] = new("Weld", I[5], "Weld", { C0 = CFrame.new(1, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.5, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0) })
					I[7] = new("Weld", I[5], "Weld", { C0 = CFrame.new(-1, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0.5, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
					I[8] = new("Snap", I[5], "Snap", { C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0) })
					I[9] = new("Weld", I[5], "Weld", { C0 = CFrame.new(1, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.5, -0.3686733, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0) })
					I[10] = new("Weld", I[5], "Weld", { C0 = CFrame.new(1, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.5, 0.2240715, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0) })
					I[11] = new("Weld", I[5], "Weld", { C0 = CFrame.new(-1, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0.5, -0.3686733, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
					I[12] = new("Weld", I[5], "Weld", { C0 = CFrame.new(-1, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0.5, 0.2240715, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
					I[13] = new("Weld", I[5], "Weld", { C0 = CFrame.new(-1, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0.5, 0.8500457, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
					I[14] = new("Weld", I[5], "Weld", { C0 = CFrame.new(1, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.5, -0.3686733, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0) })
					I[15] = new("Weld", I[5], "Weld", { C0 = CFrame.new(-1, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0.5, -0.3686733, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
					I[16] = new("Weld", I[5], "Weld", { C0 = CFrame.new(-1, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0.5, 0.2240715, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
					I[17] = new("Weld", I[5], "Weld", { C0 = CFrame.new(1, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.5, -0.3000011, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0) })
					I[18] = new("Weld", I[5], "Weld", { C0 = CFrame.new(1, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.5, 0.1499996, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0) })
					I[19] = new("Weld", I[5], "Weld", { C0 = CFrame.new(1, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.5, 0.8500004, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0) })
					I[20] = new("Weld", I[5], "Weld", { C0 = CFrame.new(-1, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0.5, -0.3000011, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
					I[21] = new("Weld", I[5], "Weld", { C0 = CFrame.new(-1, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0.5, 0.1499996, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
					I[22] = new("Weld", I[5], "Weld", { C0 = CFrame.new(-1, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0.5, 0.8500004, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
					I[23] = new("Weld", I[5], "Weld", { C0 = CFrame.new(-1, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0.5, 0.8500004, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
					I[24] = new("Weld", I[5], "Weld", { C0 = CFrame.new(-1, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0.5, -0.3000011, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
					I[25] = new("Weld", I[5], "Weld", { C0 = CFrame.new(1, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.5, -0.3000011, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0) })
					I[26] = new("Motor6D", I[5], "Neck", { C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
					I[27] = new("Motor6D", I[5], "Left Hip", { C0 = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), MaxVelocity = 0.1 })
					I[28] = new("Motor6D", I[5], "Right Hip", { C0 = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), MaxVelocity = 0.1 })
					I[29] = new("Motor6D", I[5], "Left Shoulder", { C0 = CFrame.new(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), MaxVelocity = 0.1 })
					I[30] = new("Motor6D", I[5], "Right Shoulder", { C0 = CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), MaxVelocity = 0.1 })
					I[31] = new("Attachment", I[5], "WaistBackAttachment", { CFrame = CFrame.new(0, -1, 0.5) })
					I[32] = new("Attachment", I[5], "WaistCenterAttachment", { CFrame = CFrame.new(0, -1, 0) })
					I[33] = new("Attachment", I[5], "WaistFrontAttachment", { CFrame = CFrame.new(0, -1, -0.5) })
					I[34] = new("Attachment", I[5], "RightCollarAttachment", { CFrame = CFrame.new(1, 1, 0) })
					I[35] = new("Attachment", I[5], "LeftCollarAttachment", { CFrame = CFrame.new(-1, 1, 0) })
					I[36] = new("Attachment", I[5], "BodyBackAttachment", { CFrame = CFrame.new(0, 0, 0.5) })
					I[37] = new("Attachment", I[5], "BodyFrontAttachment", { CFrame = CFrame.new(0, 0, -0.5) })
					I[38] = new("Attachment", I[5], "NeckAttachment", { CFrame = CFrame.new(0, 1, 0) })
				I[39] = new("Part", I[4], "Right Leg", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(29.5, 1, -1.5, 0, 0, 1, 0, 1, 0, -1, 0, 0), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1) })
					I[40] = new("Snap", I[39], "Snap", { C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0.5, -1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0) })
					I[41] = new("Snap", I[39], "Snap", { C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0.5, -1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0) })
					I[42] = new("Attachment", I[39], "RightFootAttachment", { CFrame = CFrame.new(0, -1, 0) })
				I[43] = new("Part", I[4], "Right Arm", { CFrame = CFrame.new(29.5, 3, -2.5, 0, 0, 1, 0, 1, 0, -1, 0, 0), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1) })
					I[44] = new("Part", I[43], "FingersR", { CFrame = CFrame.new(29.5, 3, -2.5, 0, 0, 1, 0, 1, 0, -1, 0, 0), CanCollide = false, EnableFluidForces = false, Locked = true, Massless = true, Size = Vector3.new(1, 2, 1), Transparency = 1 })
						I[45] = new("Part", I[44], "Pinky", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(29.8301773, 1.6741965, -2.8789158, 1, 0, 0, 0, 1, 0, 0, 0, 1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.81, 0.2), TopSurface = Enum.SurfaceType.Smooth })
						I[46] = new("Part", I[44], "Ring", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(29.6016769, 1.6741965, -2.8789158, 1, 0, 0, 0, 1, 0, 0, 0, 1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.81, 0.2), TopSurface = Enum.SurfaceType.Smooth })
						I[47] = new("Part", I[44], "Index", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(29.151886, 1.6741965, -2.8789158, 1, 0, 0, 0, 1, 0, 0, 0, 1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.81, 0.2), TopSurface = Enum.SurfaceType.Smooth })
						I[48] = new("Part", I[44], "Thumb", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(29.1205673, 1.8045374, -2.1276875, 1, 0, 0, 0, 1, 0, 0, 0, 1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.5493469, 0.2), TopSurface = Enum.SurfaceType.Smooth })
						I[49] = new("Part", I[44], "Middle", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(29.3678207, 1.6741965, -2.8789158, 1, 0, 0, 0, 1, 0, 0, 0, 1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.81, 0.2), TopSurface = Enum.SurfaceType.Smooth })
						I[50] = new("Motor6D", I[44], "Middle", { C0 = CFrame.new(0.3789158, -0.9258034, -0.1321793, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.4000001, 0) })
						I[51] = new("Motor6D", I[44], "Index", { C0 = CFrame.new(0.3789158, -0.9258034, -0.348114, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.4000001, 0) })
						I[52] = new("Motor6D", I[44], "Ring", { C0 = CFrame.new(0.3789158, -0.9258034, 0.1016769, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.4000001, 0) })
						I[53] = new("Motor6D", I[44], "Pinky", { C0 = CFrame.new(0.3789158, -0.9258034, 0.3301773, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.4000001, 0) })
						I[54] = new("Motor6D", I[44], "Thumb", { C0 = CFrame.new(-0.3723125, -0.9954627, -0.3794327, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.1999999, 0) })
						I[55] = new("Motor6D", I[44], "Fingers")
					I[56] = new("Weld", I[43], "Weld", { C0 = CFrame.new(-0.5, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(1, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
					I[57] = new("Attachment", I[43], "RightGripAttachment", { CFrame = CFrame.new(0, -1, 0) })
					I[58] = new("Attachment", I[43], "RightShoulderAttachment", { CFrame = CFrame.new(0, 1, 0) })
				I[59] = new("Part", I[4], "Left Leg", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(29.5, 1, -0.5, 0, 0, 1, 0, 1, 0, -1, 0, 0), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1) })
					I[60] = new("Snap", I[59], "Snap", { C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(-0.5, -1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0) })
					I[61] = new("Snap", I[59], "Snap", { C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(-0.5, -1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0) })
					I[62] = new("Attachment", I[59], "LeftFootAttachment", { CFrame = CFrame.new(0, -1, 0) })
				I[63] = new("Part", I[4], "Left Arm", { CFrame = CFrame.new(29.5, 3, 0.5, 0, 0, 1, 0, 1, 0, -1, 0, 0), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1) })
					I[64] = new("Part", I[63], "FingersL", { CFrame = CFrame.new(29.5, 3, 0.5, 0, 0, 1, 0, 1, 0, -1, 0, 0), CanCollide = false, EnableFluidForces = false, Locked = true, Massless = true, Size = Vector3.new(1, 2, 1), Transparency = 1 })
						I[65] = new("Part", I[64], "Pinky", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(29.8301773, 1.6741965, 0.8754196, 1, 0, 0, 0, 1, 0, 0, 0, 1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.81, 0.2), TopSurface = Enum.SurfaceType.Smooth })
						I[66] = new("Part", I[64], "Ring", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(29.6016769, 1.6741965, 0.8754196, 1, 0, 0, 0, 1, 0, 0, 0, 1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.81, 0.2), TopSurface = Enum.SurfaceType.Smooth })
						I[67] = new("Part", I[64], "Index", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(29.151886, 1.6741965, 0.8754196, 1, 0, 0, 0, 1, 0, 0, 0, 1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.81, 0.2), TopSurface = Enum.SurfaceType.Smooth })
						I[68] = new("Part", I[64], "Thumb", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(29.1205673, 1.8045374, 0.1249953, 1, 0, 0, 0, 1, 0, 0, 0, 1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.5493469, 0.2), TopSurface = Enum.SurfaceType.Smooth })
						I[69] = new("Part", I[64], "Middle", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(29.3678207, 1.6741965, 0.8754196, 1, 0, 0, 0, 1, 0, 0, 0, 1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.81, 0.2), TopSurface = Enum.SurfaceType.Smooth })
						I[70] = new("Motor6D", I[64], "Index", { C0 = CFrame.new(-0.3754196, -0.9258034, -0.348114, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.4000001, 0) })
						I[71] = new("Motor6D", I[64], "Middle", { C0 = CFrame.new(-0.3754196, -0.9258034, -0.1321793, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.4000001, 0) })
						I[72] = new("Motor6D", I[64], "Pinky", { C0 = CFrame.new(-0.3754196, -0.9258034, 0.3301773, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.4000001, 0) })
						I[73] = new("Motor6D", I[64], "Ring", { C0 = CFrame.new(-0.3754196, -0.9258037, 0.1016769, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.3999999, 0) })
						I[74] = new("Motor6D", I[64], "Thumb", { C0 = CFrame.new(0.3750048, -0.9954627, -0.3794327, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.1999999, 0) })
						I[75] = new("Motor6D", I[64], "Fingers")
					I[76] = new("Weld", I[63], "Weld", { C0 = CFrame.new(0.5, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-1, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0) })
					I[77] = new("Attachment", I[63], "LeftGripAttachment", { CFrame = CFrame.new(0, -1, 0) })
					I[78] = new("Attachment", I[63], "LeftShoulderAttachment", { CFrame = CFrame.new(0, 1, 0) })
				I[79] = new("Part", I[4], "HumanoidRootPart", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(29.5, 3, -1, 0, 0, 1, 0, 1, 0, -1, 0, 0), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(2, 2, 1), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
					I[80] = new("Motor6D", I[79], "RootJoint", { C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
					I[81] = new("Attachment", I[79], "RootAttachment")
				I[82] = new("Part", I[4], "Head", { CFrame = CFrame.new(29.5, 4.5, -1, 0, 0, 1, 0, 1, 0, -1, 0, 0), EnableFluidForces = false, Size = Vector3.new(2, 1, 1), TopSurface = Enum.SurfaceType.Smooth })
					I[83] = new("Decal", I[82], "face", { TextureContent = Content.fromUri("rbxasset://textures/face.png") })
					I[84] = new("Attachment", I[82], "FaceCenterAttachment")
					I[85] = new("Attachment", I[82], "FaceFrontAttachment", { CFrame = CFrame.new(0, 0, -0.6) })
					I[86] = new("Attachment", I[82], "HatAttachment", { CFrame = CFrame.new(0, 0.6, 0) })
					I[87] = new("Attachment", I[82], "HairAttachment", { CFrame = CFrame.new(0, 0.6, 0) })
					I[88] = new("SpecialMesh", I[82], "Mesh", { Scale = Vector3.new(1.25, 1.25, 1.25) })
				I[89] = new("Humanoid", I[4], "Humanoid", { DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None, HealthDisplayDistance = 0, HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff, NameDisplayDistance = 0 })
					I[90] = new("Animator", I[89], "Animator")
				I[91] = new("Part", I[4], "Background", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(33, 5, 0), CanCollide = false, CanQuery = false, CanTouch = false, Size = Vector3.new(0.001, 20.5510006, 29.3339996), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
					I[92] = new("Decal", I[91], "Decal", { Face = Enum.NormalId.Left, TextureContent = Content.fromUri("rbxassetid://14591918380") })
		I[93] = new("Frame", I[1], "BorderTop", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.03) })
			I[94] = new("TextLabel", I[93], "DOMAIN", { AnchorPoint = Vector2.new(0.8, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Rotation = 10, Size = UDim2.new(0.5, 0, 0, 100), Text = "DOMAIN", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[95] = new("UIStroke", I[94], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5 })
			I[96] = new("ImageLabel", I[93], "LINE2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=93968050354762"), Position = UDim2.fromScale(1.35, 0.5), Rotation = -90, Size = UDim2.fromScale(5, 160), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
			I[97] = new("ImageLabel", I[93], "LINE", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=93968050354762"), Position = UDim2.fromScale(0.45, 0.5), Rotation = -90, Size = UDim2.fromScale(5, 160), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
			I[98] = new("ImageLabel", I[93], "BACKGROUND2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=73084134899292"), Position = UDim2.fromScale(1.35, 0.5), Rotation = -90, Size = UDim2.fromScale(10, 160), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false, ZIndex = 0 })
			I[99] = new("ImageLabel", I[93], "BACKGROUND", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=73084134899292"), Position = UDim2.fromScale(0.45, 0.5), Rotation = -90, Size = UDim2.fromScale(10, 160), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false, ZIndex = 0 })
			I[100] = new("UIStroke", I[93], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5 })
		I[101] = new("Frame", I[1], "BorderBottom", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.03) })
			I[102] = new("TextLabel", I[101], "EXPANSION", { AnchorPoint = Vector2.new(0.2, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Rotation = 10, Size = UDim2.new(0.5, 0, 0, 100), Text = "EXPANSION", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[103] = new("UIStroke", I[102], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5 })
			I[104] = new("ImageLabel", I[101], "LINE2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=93968050354762"), Position = UDim2.fromScale(1.35, 0.5), Rotation = -90, Size = UDim2.fromScale(5, 160), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
			I[105] = new("ImageLabel", I[101], "LINE", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=93968050354762"), Position = UDim2.fromScale(0.45, 0.5), Rotation = -90, Size = UDim2.fromScale(5, 160), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
			I[106] = new("ImageLabel", I[101], "BACKGROUND2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=73084134899292"), Position = UDim2.fromScale(1.35, 0.5), Rotation = -90, Size = UDim2.fromScale(10, 160), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false, ZIndex = 0 })
			I[107] = new("ImageLabel", I[101], "BACKGROUND", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=73084134899292"), Position = UDim2.fromScale(0.45, 0.5), Rotation = -90, Size = UDim2.fromScale(10, 160), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false, ZIndex = 0 })
			I[108] = new("UIStroke", I[101], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5 })
	I[6].Part0 = I[5]
	I[7].Part0 = I[5]
	I[8].Part0 = I[5]
	I[9].Part0 = I[5]
	I[10].Part0 = I[5]
	I[11].Part0 = I[5]
	I[12].Part0 = I[5]
	I[13].Part0 = I[5]
	I[14].Part0 = I[5]
	I[15].Part0 = I[5]
	I[16].Part0 = I[5]
	I[17].Part0 = I[5]
	I[18].Part0 = I[5]
	I[19].Part0 = I[5]
	I[20].Part0 = I[5]
	I[21].Part0 = I[5]
	I[22].Part0 = I[5]
	I[23].Part0 = I[5]
	I[24].Part0 = I[5]
	I[25].Part0 = I[5]
	I[26].Part0 = I[5]
	I[26].Part1 = I[82]
	I[27].Part0 = I[5]
	I[27].Part1 = I[59]
	I[28].Part0 = I[5]
	I[28].Part1 = I[39]
	I[29].Part0 = I[5]
	I[29].Part1 = I[63]
	I[30].Part0 = I[5]
	I[30].Part1 = I[43]
	I[40].Part0 = I[39]
	I[41].Part0 = I[39]
	I[50].Part0 = I[44]
	I[50].Part1 = I[49]
	I[51].Part0 = I[44]
	I[51].Part1 = I[47]
	I[52].Part0 = I[44]
	I[52].Part1 = I[46]
	I[53].Part0 = I[44]
	I[53].Part1 = I[45]
	I[54].Part0 = I[44]
	I[54].Part1 = I[48]
	I[55].Part0 = I[43]
	I[55].Part1 = I[44]
	I[56].Part0 = I[43]
	I[60].Part0 = I[59]
	I[61].Part0 = I[59]
	I[70].Part0 = I[64]
	I[70].Part1 = I[67]
	I[71].Part0 = I[64]
	I[71].Part1 = I[69]
	I[72].Part0 = I[64]
	I[72].Part1 = I[65]
	I[73].Part0 = I[64]
	I[73].Part1 = I[66]
	I[74].Part0 = I[64]
	I[74].Part1 = I[68]
	I[75].Part0 = I[63]
	I[75].Part1 = I[64]
	I[76].Part0 = I[63]
	I[80].Part0 = I[79]
	I[80].Part1 = I[5]
	return I[1]
end

return build
