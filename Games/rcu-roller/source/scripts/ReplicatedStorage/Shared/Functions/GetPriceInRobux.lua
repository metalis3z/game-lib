-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:17:27
-- Luau version 6, Types version 3
-- Time taken: 0.000817 seconds

local MarketplaceService_upvr = game:GetService("MarketplaceService")
return function(arg1, arg2) -- Line 10
	--[[ Upvalues[1]:
		[1]: MarketplaceService_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var3
	repeat
		local pcall_result1, pcall_result2 = pcall(function() -- Line 15
			--[[ Upvalues[3]:
				[1]: MarketplaceService_upvr (copied, readonly)
				[2]: arg1 (readonly)
				[3]: arg2 (readonly)
			]]
			return MarketplaceService_upvr:GetProductInfo(arg1, arg2)
		end)
		var3 = pcall_result2
	until pcall_result1 and 10 - 1 == 0
	if not var3 or not var3.PriceInRobux then
	end
	return 0
end