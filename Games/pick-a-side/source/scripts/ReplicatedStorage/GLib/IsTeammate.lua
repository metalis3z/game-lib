-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:57
-- Luau version 6, Types version 3
-- Time taken: 0.004886 seconds

return function(arg1, arg2) -- Line 8
	if not arg1 or not arg2 then
		return nil
	end
	local var7 = arg1
	if var7 then
		var7 = arg2
		if var7 then
			var7 = arg1:IsA("Player")
			if var7 then
				var7 = arg2:IsA("Player")
				if var7 then
					var7 = true
					if arg1.TeamColor ~= arg2.TeamColor then
						var7 = true
						if arg1.Neutral ~= true then
							if arg2.Neutral ~= true then
								var7 = false
							else
								var7 = true
							end
						end
					end
				end
			end
		end
	end
	return var7
end