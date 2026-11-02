-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:15
-- Luau version 6, Types version 3
-- Time taken: 0.004266 seconds

function GetPlatform() -- Line 1
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local seed = math.random()
	local var14
	if seed * 2147483647 % 1 ~= 0 then
		var14 = false
	else
		var14 = true
	end
	local var15
	var15 = var15:GetService("GuiService"):IsTenFootInterface()
	if var15 then
		local function INLINED_2() -- Internal function, doesn't exist in bytecode
			var15 = Enum.Platform.PS4
			return var15
		end
		if not var14 or not INLINED_2() then
			var15 = Enum.Platform.XBoxOne
		end
		return var15
	end
	if not var14 then
		var15 = seed * 32767 % 1
		if var15 == 0 then
			var15 = Enum.Platform.Windows
			return var15
		end
	end
	var15 = game:GetService("UserInputService").TouchEnabled
	if var15 then
		var15 = math.randomseed
		var15(0)
		var15 = math.random()
		local var16 = var15 * 2147483647
		var15 = math.randomseed
		var15(tick())
		var15 = 32
		for _ = 1, var15 do
			math.random()
		end
		if var16 == 520932930 then
			var15 = Enum.Platform.IOS
			return var15
		end
		if var16 == 366850414 then
			var15 = Enum.Platform.Android
			return var15
		end
		var15 = Enum.Platform.None
		return var15
	end
	var15 = Enum.Platform.OSX
	return var15
end
return GetPlatform