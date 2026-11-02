-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:10
-- Luau version 6, Types version 3
-- Time taken: 0.001768 seconds

local module_upvr = {}
local Players_upvr = game:GetService("Players")
function module_upvr.copyTable(arg1) -- Line 9
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	local var7
	if type(arg1) ~= "table" then
		var7 = false
	else
		var7 = true
	end
	assert(var7, "First argument must be a table")
	var7 = #arg1
	var7 = pairs(arg1)
	for i, v in pairs(arg1) do
		if type(v) == "table" then
			table.create(var7)[i] = module_upvr.copyTable(v)
		else
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			table.create(var7)[i] = v
		end
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	return table.create(var7)
end
function module_upvr.formatStateName(arg1) -- Line 23
	return string.upper(string.sub(arg1, 1, 1))..string.lower(string.sub(arg1, 2))
end
local LocalPlayer_upvr = Players_upvr.LocalPlayer
function module_upvr.localPlayerRespawned(arg1) -- Line 27
	--[[ Upvalues[2]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: Players_upvr (readonly)
	]]
	task.spawn(function() -- Line 31
		--[[ Upvalues[3]:
			[1]: LocalPlayer_upvr (copied, readonly)
			[2]: Players_upvr (copied, readonly)
			[3]: arg1 (readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local var17
		if not var17 then
			var17 = LocalPlayer_upvr.CharacterAdded:Wait()
		end
		for var19 = 1, 5 do
			local class_Humanoid = var17:FindFirstChildOfClass("Humanoid")
			if class_Humanoid then break end
			task.wait(1)
		end
		if class_Humanoid then
			function var19() -- Line 42
				--[[ Upvalues[2]:
					[1]: Players_upvr (copied, readonly)
					[2]: arg1 (copied, readonly)
				]]
				task.delay(Players_upvr.RespawnTime - 0.1, function() -- Line 43
					--[[ Upvalues[1]:
						[1]: arg1 (copied, readonly)
					]]
					arg1()
				end)
			end
			class_Humanoid.Died:Once(var19)
		end
	end)
end
return module_upvr