-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:14
-- Luau version 6, Types version 3
-- Time taken: 0.002425 seconds

local CurrentCamera_upvr = game.Workspace.CurrentCamera
local Parent_upvr = script.Parent
local Clips_upvr = Parent_upvr:WaitForChild("Clips")
local Container_upvr = Clips_upvr:WaitForChild("Container")
local Holder_upvr = Clips_upvr:WaitForChild("Holder")
local function _() -- Line 13, Named "GetAdditionalSize"
	--[[ Upvalues[2]:
		[1]: CurrentCamera_upvr (readonly)
		[2]: Holder_upvr (readonly)
	]]
	return math.max((Holder_upvr.AbsoluteSize.Y) * (1080 / CurrentCamera_upvr.ViewportSize.Y) - 110, 0)
end
local function UpdateCategorySize() -- Line 21
	--[[ Upvalues[5]:
		[1]: CurrentCamera_upvr (readonly)
		[2]: Holder_upvr (readonly)
		[3]: Clips_upvr (readonly)
		[4]: Parent_upvr (readonly)
		[5]: Container_upvr (readonly)
	]]
	local maximum_2 = math.max((Holder_upvr.AbsoluteSize.Y) * (1080 / CurrentCamera_upvr.ViewportSize.Y) - 110, 0)
	Clips_upvr.Size = UDim2.fromOffset(Clips_upvr.Size.X.Offset, 238 + maximum_2)
	Parent_upvr.Size = UDim2.fromOffset(Parent_upvr.Size.X.Offset, 238 + maximum_2)
	Container_upvr.Size = UDim2.fromOffset(Container_upvr.Size.X.Offset, 148 + maximum_2 + 2)
end
UpdateCategorySize()
Holder_upvr:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateCategorySize)
CurrentCamera_upvr:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateCategorySize)
local TweenService_upvr = game:GetService("TweenService")
Parent_upvr:WaitForChild("Click").MouseButton1Click:Connect(function() -- Line 37
	--[[ Upvalues[5]:
		[1]: Parent_upvr (readonly)
		[2]: CurrentCamera_upvr (readonly)
		[3]: Holder_upvr (readonly)
		[4]: Container_upvr (readonly)
		[5]: TweenService_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local Shown = Parent_upvr:GetAttribute("Shown")
	local maximum = math.max((Holder_upvr.AbsoluteSize.Y) * (1080 / CurrentCamera_upvr.ViewportSize.Y) - 110, 0)
	local var11
	local function INLINED() -- Internal function, doesn't exist in bytecode
		var11 = UDim2.fromOffset(Parent_upvr.Size.X.Offset, 81)
		return var11
	end
	if not Shown or not INLINED() then
		var11 = UDim2.fromOffset(Parent_upvr.Size.X.Offset, 238 + maximum)
	end
	if not Shown or not UDim2.fromOffset(Container_upvr.Position.X.Offset, -159 - maximum) then
	end
	if not Shown or not UDim2.fromOffset(Holder_upvr.Position.X.Offset, -143 - maximum) then
	end
	if Shown then
	else
	end
	TweenService_upvr:Create(Parent_upvr, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = var11;
	}):Play()
	TweenService_upvr:Create(Container_upvr, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Position = UDim2.fromOffset(Container_upvr.Position.X.Offset, 4);
	}):Play()
	TweenService_upvr:Create(Holder_upvr, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Position = UDim2.fromOffset(Holder_upvr.Position.X.Offset, 24);
	}):Play()
	TweenService_upvr:Create(Parent_upvr.Infos.ArrowBox.Image, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Rotation = 0;
	}):Play()
	Parent_upvr:SetAttribute("Shown", not Shown)
end)