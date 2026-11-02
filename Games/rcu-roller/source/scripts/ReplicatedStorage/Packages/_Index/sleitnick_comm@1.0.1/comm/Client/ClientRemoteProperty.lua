-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:15:40
-- Luau version 6, Types version 3
-- Time taken: 0.001532 seconds

local module_upvr = {}
module_upvr.__index = module_upvr
local ClientRemoteSignal_upvr = require(script.Parent.ClientRemoteSignal)
local Signal_upvr = require(script.Parent.Parent.Parent.Signal)
local Promise_upvr = require(script.Parent.Parent.Parent.Promise)
function module_upvr.new(arg1, arg2, arg3) -- Line 32
	--[[ Upvalues[4]:
		[1]: module_upvr (readonly)
		[2]: ClientRemoteSignal_upvr (readonly)
		[3]: Signal_upvr (readonly)
		[4]: Promise_upvr (readonly)
	]]
	local setmetatable_result1_upvr = setmetatable({}, module_upvr)
	setmetatable_result1_upvr._rs = ClientRemoteSignal_upvr.new(arg1, arg2, arg3)
	setmetatable_result1_upvr._ready = false
	setmetatable_result1_upvr._value = nil
	setmetatable_result1_upvr.Changed = Signal_upvr.new()
	setmetatable_result1_upvr._rs:Fire()
	local var6_upvw
	setmetatable_result1_upvr._readyPromise = Promise_upvr.new(function(arg1_2) -- Line 45
		--[[ Upvalues[1]:
			[1]: var6_upvw (read and write)
		]]
		var6_upvw = arg1_2
	end)
	setmetatable_result1_upvr._changed = setmetatable_result1_upvr._rs:Connect(function(arg1_3) -- Line 48
		--[[ Upvalues[2]:
			[1]: setmetatable_result1_upvr (readonly)
			[2]: var6_upvw (read and write)
		]]
		local var9
		if arg1_3 == setmetatable_result1_upvr._value then
			var9 = false
		else
			var9 = true
		end
		setmetatable_result1_upvr._value = arg1_3
		if not setmetatable_result1_upvr._ready then
			setmetatable_result1_upvr._ready = true
			var6_upvw(arg1_3)
		end
		if var9 then
			setmetatable_result1_upvr.Changed:Fire(arg1_3)
		end
	end)
	return setmetatable_result1_upvr
end
function module_upvr.Get(arg1) -- Line 71
	return arg1._value
end
function module_upvr.OnReady(arg1) -- Line 94
	return arg1._readyPromise
end
function module_upvr.IsReady(arg1) -- Line 110
	return arg1._ready
end
function module_upvr.Observe(arg1, arg2) -- Line 135
	if arg1._ready then
		task.defer(arg2, arg1._value)
	end
	return arg1.Changed:Connect(arg2)
end
function module_upvr.Destroy(arg1) -- Line 145
	arg1._rs:Destroy()
	if arg1._readyPromise then
		arg1._readyPromise:cancel()
	end
	if arg1._changed then
		arg1._changed:Disconnect()
	end
	arg1.Changed:Destroy()
end
return module_upvr