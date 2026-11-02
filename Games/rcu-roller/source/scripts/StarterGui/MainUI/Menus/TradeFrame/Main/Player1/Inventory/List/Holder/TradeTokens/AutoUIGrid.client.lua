-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:20
-- Luau version 6, Types version 3
-- Time taken: 0.000814 seconds

local CurrentCamera_upvr = game.Workspace.CurrentCamera
local UIGridLayout_upvr = script.Parent.UIGridLayout
local Offset_upvr_2 = UIGridLayout_upvr.CellSize.Y.Offset
local Offset_upvr = UIGridLayout_upvr.CellPadding.Y.Offset
local function Update() -- Line 9
	--[[ Upvalues[4]:
		[1]: CurrentCamera_upvr (readonly)
		[2]: Offset_upvr_2 (readonly)
		[3]: Offset_upvr (readonly)
		[4]: UIGridLayout_upvr (readonly)
	]]
	local var5 = CurrentCamera_upvr.ViewportSize.Y / 1080
	UIGridLayout_upvr.CellSize = UDim2.new(UIGridLayout_upvr.CellSize.X.Scale, 0, 0, var5 * Offset_upvr_2)
	UIGridLayout_upvr.CellPadding = UDim2.new(UIGridLayout_upvr.CellPadding.X.Scale, 0, 0, var5 * Offset_upvr)
end
Update()
script.Parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(Update)
CurrentCamera_upvr:GetPropertyChangedSignal("ViewportSize"):Connect(Update)