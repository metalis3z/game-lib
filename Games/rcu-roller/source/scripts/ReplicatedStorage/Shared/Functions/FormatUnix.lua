-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:17:21
-- Luau version 6, Types version 3
-- Time taken: 0.001587 seconds

return function(arg1, arg2) -- Line 9
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var2 = arg2
	if not var2 then
		var2 = {}
	end
	local var4_upvw = "US"
	local _, pcall_result2 = pcall(function() -- Line 18
		--[[ Upvalues[1]:
			[1]: var4_upvw (read and write)
		]]
		var4_upvw = game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(game:GetService("Players").LocalPlayer)
	end)
	local var8 = {"US", "GB", "CA", "AU", "NZ", "PH", "IN", "PK", "EG", "CO", "MX", "HN", "GT", "SV", "JM", "TT", "BZ", "MY", "MM", "NG", "LY", "SA", "AE"}
	if 31556926 >= os.time() - arg1.UnixTimestamp then
		var8 = false
	else
		var8 = true
	end
	if var2.shortMonth then
	end
	if var8 then
		return `{arg1:FormatLocalTime("ll", "en-us")}`
	end
	if table.find(var8, var4_upvw) then
	else
	end
	return `{arg1:FormatLocalTime(`{"MMM"} D, {"HH:mm"}`, "en-us")}`
end