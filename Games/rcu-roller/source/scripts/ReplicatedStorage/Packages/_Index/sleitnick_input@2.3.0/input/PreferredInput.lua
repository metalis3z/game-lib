-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:15:59
-- Luau version 6, Types version 3
-- Time taken: 0.001297 seconds

local UserInputService = game:GetService("UserInputService")
local tbl_upvr = {}
local tbl = {
	Current = "MouseKeyboard";
}
local var4_upvw
function tbl.Observe(arg1) -- Line 83
	--[[ Upvalues[2]:
		[1]: tbl_upvr (readonly)
		[2]: var4_upvw (read and write)
	]]
	if table.find(tbl_upvr, arg1) then
		error("function already subscribed", 2)
	end
	table.insert(tbl_upvr, arg1)
	task.spawn(arg1, var4_upvw.Current)
	return function() -- Line 91
		--[[ Upvalues[2]:
			[1]: tbl_upvr (copied, readonly)
			[2]: arg1 (readonly)
		]]
		local table_find_result1 = table.find(tbl_upvr, arg1)
		if table_find_result1 then
			local len = #tbl_upvr
			tbl_upvr[table_find_result1] = tbl_upvr[len]
			tbl_upvr[len] = nil
		end
	end
end
var4_upvw = tbl
local var8_upvw = var4_upvw
local function SetPreferred_upvr(arg1) -- Line 101, Named "SetPreferred"
	--[[ Upvalues[2]:
		[1]: var8_upvw (read and write)
		[2]: tbl_upvr (readonly)
	]]
	if arg1 == var8_upvw.Current then
	else
		var8_upvw.Current = arg1
		for _, v in tbl_upvr do
			task.spawn(v, arg1)
		end
	end
end
local Touch_upvr = Enum.UserInputType.Touch
local Keyboard_upvr = Enum.UserInputType.Keyboard
local function DeterminePreferred(arg1) -- Line 112
	--[[ Upvalues[3]:
		[1]: Touch_upvr (readonly)
		[2]: SetPreferred_upvr (readonly)
		[3]: Keyboard_upvr (readonly)
	]]
	if arg1 == Touch_upvr then
		SetPreferred_upvr("Touch")
	else
		if arg1 == Keyboard_upvr or string.sub(arg1.Name, 1, 5) == "Mouse" then
			SetPreferred_upvr("MouseKeyboard")
			return
		end
		if string.sub(arg1.Name, 1, 7) == "Gamepad" then
			SetPreferred_upvr("Gamepad")
		end
	end
end
DeterminePreferred(UserInputService:GetLastInputType())
UserInputService.LastInputTypeChanged:Connect(DeterminePreferred)
return var8_upvw