-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:48
-- Luau version 6, Types version 3
-- Time taken: 0.001498 seconds

local module_upvr = {}
module_upvr.__index = module_upvr
function module_upvr.new(arg1) -- Line 4
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	local setmetatable_result1 = setmetatable({}, module_upvr)
	setmetatable_result1._icon = script.Icon:Clone()
	setmetatable_result1._icon.Name = "_loadingSpinner"
	setmetatable_result1._icon.Parent = arg1
	setmetatable_result1._fps = 54
	return setmetatable_result1
end
function module_upvr.run(arg1) -- Line 16
	arg1._icon.Image = "http://www.roblox.com/asset/?id=7996219298"
	local const_number = 1024
	local vector2 = Vector2.new(const_number / 1296 * 1296 / 9, const_number / 9)
	arg1._icon.ImageRectSize = vector2
	local const_number_2 = 0
	local tbl_upvr = {}
	local var10_upvr
	for _ = 1, var10_upvr do
		table.insert(tbl_upvr, Vector2.new(const_number_2 * vector2.X, 0 * vector2.Y))
		if 9 <= const_number_2 + 1 then
		end
	end
	local function INLINED() -- Internal function, doesn't exist in bytecode
		var10_upvr = 1 / arg1._fps
		return var10_upvr
	end
	if not arg1._fps or not INLINED() then
		var10_upvr = 0.1
	end
	local var12_upvw = 0
	task.spawn(function() -- Line 67
		--[[ Upvalues[4]:
			[1]: var10_upvr (readonly)
			[2]: arg1 (readonly)
			[3]: var12_upvw (read and write)
			[4]: tbl_upvr (readonly)
		]]
		while task.wait(var10_upvr) and arg1._icon:IsDescendantOf(game) do
			var12_upvw += 1
			arg1._icon.ImageRectOffset = tbl_upvr[var12_upvw]
			if 81 <= var12_upvw then
				var12_upvw = 0
			end
		end
	end)
end
function module_upvr.remove(arg1) -- Line 84
	arg1._icon:Destroy()
end
return module_upvr