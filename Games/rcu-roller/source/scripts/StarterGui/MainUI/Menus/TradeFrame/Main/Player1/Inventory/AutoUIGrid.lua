-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:17
-- Luau version 6, Types version 3
-- Time taken: 0.000756 seconds

return function(arg1) -- Line 1
	local class_UIGridLayout_upvr = arg1:FindFirstChildOfClass("UIGridLayout")
	assert(class_UIGridLayout_upvr, "UIGridLayout not found in the container.")
	local function updateLayout_upvr() -- Line 5, Named "updateLayout"
		--[[ Upvalues[1]:
			[1]: class_UIGridLayout_upvr (readonly)
		]]
		local ViewportSize = workspace.CurrentCamera.ViewportSize
		local minimum = math.min(ViewportSize.X / 1920, ViewportSize.Y / 1080)
		local var5 = Vector2.new(94, 94) * minimum
		local var6 = Vector2.new(21, 24) * minimum
		local vector2_2 = Vector2.new(50, 50)
		local vector2 = Vector2.new(150, 150)
		local vector2_3 = Vector2.new(math.clamp(var5.X, vector2_2.X, vector2.X), math.clamp(var5.Y, vector2_2.Y, vector2.Y))
		class_UIGridLayout_upvr.CellSize = UDim2.new(0, vector2_3.X, 0, vector2_3.Y)
		class_UIGridLayout_upvr.CellPadding = UDim2.new(0, var6.X, 0, var6.Y)
	end
	return function() -- Line 27
		--[[ Upvalues[1]:
			[1]: updateLayout_upvr (readonly)
		]]
		updateLayout_upvr()
	end
end