-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:10
-- Luau version 6, Types version 3
-- Time taken: 0.002213 seconds

local Trove_upvr = require(script.Parent.Parent.Trove)
local Signal_upvr = require(script.Parent.Parent.Signal)
local module_upvr_4 = {}
module_upvr_4.__index = module_upvr_4
function module_upvr_4.new(arg1, arg2) -- Line 96
	--[[ Upvalues[3]:
		[1]: module_upvr_4 (readonly)
		[2]: Trove_upvr (readonly)
		[3]: Signal_upvr (readonly)
	]]
	local module_upvr_2 = {}
	setmetatable(module_upvr_2, module_upvr_4)
	module_upvr_2._trove = Trove_upvr.new()
	module_upvr_2._shown = module_upvr_2._trove:Construct(Signal_upvr)
	module_upvr_2._shownTrove = Trove_upvr.new()
	module_upvr_2._trove:Add(module_upvr_2._shownTrove)
	module_upvr_2.Instance = arg1:FindFirstChild(arg2)
	local function OnInstanceSet_upvr() -- Line 107, Named "OnInstanceSet"
		--[[ Upvalues[1]:
			[1]: module_upvr_2 (readonly)
		]]
		local Instance_upvr = module_upvr_2.Instance
		if typeof(Instance_upvr) == "Instance" then
			module_upvr_2._shown:Fire(Instance_upvr, module_upvr_2._shownTrove)
			module_upvr_2._shownTrove:Connect(Instance_upvr:GetPropertyChangedSignal("Parent"), function() -- Line 111
				--[[ Upvalues[2]:
					[1]: Instance_upvr (readonly)
					[2]: module_upvr_2 (copied, readonly)
				]]
				if not Instance_upvr.Parent then
					module_upvr_2._shownTrove:Clean()
				end
			end)
			module_upvr_2._shownTrove:Add(function() -- Line 116
				--[[ Upvalues[2]:
					[1]: module_upvr_2 (copied, readonly)
					[2]: Instance_upvr (readonly)
				]]
				if module_upvr_2.Instance == Instance_upvr then
					module_upvr_2.Instance = nil
				end
			end)
		end
	end
	module_upvr_2._trove:Connect(arg1.ChildAdded, function(arg1_2) -- Line 124, Named "OnChildAdded"
		--[[ Upvalues[3]:
			[1]: arg2 (readonly)
			[2]: module_upvr_2 (readonly)
			[3]: OnInstanceSet_upvr (readonly)
		]]
		if arg1_2.Name == arg2 and not module_upvr_2.Instance then
			module_upvr_2.Instance = arg1_2
			OnInstanceSet_upvr()
		end
	end)
	if module_upvr_2.Instance then
		OnInstanceSet_upvr()
	end
	return module_upvr_2
end
function module_upvr_4.primary(arg1) -- Line 146
	--[[ Upvalues[3]:
		[1]: module_upvr_4 (readonly)
		[2]: Trove_upvr (readonly)
		[3]: Signal_upvr (readonly)
	]]
	local module_upvr = {}
	setmetatable(module_upvr, module_upvr_4)
	module_upvr._trove = Trove_upvr.new()
	module_upvr._shown = module_upvr._trove:Construct(Signal_upvr)
	module_upvr._shownTrove = Trove_upvr.new()
	module_upvr._trove:Add(module_upvr._shownTrove)
	module_upvr.Instance = arg1.PrimaryPart
	module_upvr._trove:Connect(arg1:GetPropertyChangedSignal("PrimaryPart"), function() -- Line 157, Named "OnPrimaryPartChanged"
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: module_upvr (readonly)
		]]
		local PrimaryPart_4 = arg1.PrimaryPart
		module_upvr._shownTrove:Clean()
		module_upvr.Instance = PrimaryPart_4
		if PrimaryPart_4 then
			module_upvr._shown:Fire(PrimaryPart_4, module_upvr._shownTrove)
		end
	end)
	if module_upvr.Instance then
		local PrimaryPart = arg1.PrimaryPart
		module_upvr._shownTrove:Clean()
		module_upvr.Instance = PrimaryPart
		if PrimaryPart then
			module_upvr._shown:Fire(PrimaryPart, module_upvr._shownTrove)
		end
	end
	return module_upvr
end
function module_upvr_4.Observe(arg1, arg2) -- Line 184
	if arg1.Instance then
		task.spawn(arg2, arg1.Instance, arg1._shownTrove)
	end
	return arg1._shown:Connect(arg2)
end
function module_upvr_4.Destroy(arg1) -- Line 196
	arg1._trove:Destroy()
end
return module_upvr_4