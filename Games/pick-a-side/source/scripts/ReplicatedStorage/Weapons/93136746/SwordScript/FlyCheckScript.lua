-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:38
-- Luau version 6, Types version 3
-- Time taken: 0.003430 seconds

PartNames = {"Wing", "Carpet", "Cloak", "Cape", "Glide"} -- Setting global
ClassNames = {"BodyPosition", "BodyVelocity", "BodyThrust"} -- Setting global
function CheckTableForString(arg1, arg2) -- Line 6
	for _, v in pairs(arg1) do
		if string.lower(arg2) == string.lower(v) then
			return true
		end
	end
	return false
end
function SearchTableForString(arg1, arg2) -- Line 15
	for _, v_2 in pairs(arg1) do
		if string.find(string.lower(arg2), string.lower(v_2)) then
			return true
		end
	end
	return false
end
function GetAllObjects(arg1) -- Line 24
	local module_upvr = {}
	local function GetObjects_upvr(arg1_2) -- Line 26, Named "GetObjects"
		--[[ Upvalues[2]:
			[1]: module_upvr (readonly)
			[2]: GetObjects_upvr (readonly)
		]]
		for _, v_3 in pairs(arg1_2:GetChildren()) do
			table.insert(module_upvr, v_3)
			GetObjects_upvr(v_3)
		end
	end
	GetObjects_upvr(arg1)
	return module_upvr
end
function CheckIfFlying(arg1) -- Line 36
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	local pairs_result1_3, pairs_result2, pairs_result3 = pairs({arg1:FindFirstChild("Torso"), arg1:FindFirstChild("HumanoidRootPart")})
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [44] 32. Error Block 41 start (CF ANALYSIS FAILED)
	if false then
		-- KONSTANTWARNING: GOTO [47] #34
	end
	-- KONSTANTERROR: [44] 32. Error Block 41 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [24] 18. Error Block 2 start (CF ANALYSIS FAILED)
	-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [45.9]
	-- KONSTANTERROR: [24] 18. Error Block 2 end (CF ANALYSIS FAILED)
end
return CheckIfFlying