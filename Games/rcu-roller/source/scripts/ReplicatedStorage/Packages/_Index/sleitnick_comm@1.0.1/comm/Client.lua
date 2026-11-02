-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:15:38
-- Luau version 6, Types version 3
-- Time taken: 0.004049 seconds

local Util_upvr = require(script.Parent.Util)
local module = {}
local Promise_upvr = require(script.Parent.Parent.Promise)
function module.GetFunction(arg1, arg2, arg3, arg4, arg5) -- Line 9
	--[[ Upvalues[2]:
		[1]: Util_upvr (readonly)
		[2]: Promise_upvr (readonly)
	]]
	assert(not Util_upvr.IsServer, "GetFunction must be called from the client")
	local var4 = arg2
	local SOME_upvr = Util_upvr.GetCommSubFolder(arg1, "RF"):Expect("Failed to get Comm RF folder"):WaitForChild(var4, Util_upvr.WaitForChildTimeout)
	local var6
	if SOME_upvr == nil then
		var4 = false
	else
		var4 = true
	end
	var6 = assert
	var6(var4, "Failed to find RemoteFunction: "..arg2)
	var6 = false
	if type(arg4) == "table" then
		if 0 >= #arg4 then
			var6 = false
		else
			var6 = true
		end
	end
	local var7_upvr = false
	if type(arg5) == "table" then
		if 0 >= #arg5 then
			var7_upvr = false
		else
			var7_upvr = true
		end
	end
	local function ProcessOutbound_upvr(arg1_2) -- Line 22, Named "ProcessOutbound"
		--[[ Upvalues[1]:
			[1]: arg5 (readonly)
		]]
		for _, v in ipairs(arg5) do
			local packed = table.pack(v(arg1_2))
			if not packed[1] then
				return table.unpack(packed, 2, packed.n)
			end
			arg1_2.n = #arg1_2
		end
		return table.unpack(arg1_2, 1, arg1_2.n)
	end
	if var6 then
		if arg3 then
			return function(...) -- Line 34
				--[[ Upvalues[5]:
					[1]: Promise_upvr (copied, readonly)
					[2]: var7_upvr (readonly)
					[3]: SOME_upvr (readonly)
					[4]: ProcessOutbound_upvr (readonly)
					[5]: arg4 (readonly)
				]]
				local packed_upvr_2 = table.pack(...)
				return Promise_upvr.new(function(arg1_3, arg2_2) -- Line 36
					--[[ Upvalues[5]:
						[1]: var7_upvr (copied, readonly)
						[2]: SOME_upvr (copied, readonly)
						[3]: ProcessOutbound_upvr (copied, readonly)
						[4]: packed_upvr_2 (readonly)
						[5]: arg4 (copied, readonly)
					]]
					local pcall_result1_2, pcall_result2 = pcall(function() -- Line 37
						--[[ Upvalues[4]:
							[1]: var7_upvr (copied, readonly)
							[2]: SOME_upvr (copied, readonly)
							[3]: ProcessOutbound_upvr (copied, readonly)
							[4]: packed_upvr_2 (copied, readonly)
						]]
						if var7_upvr then
							return table.pack(SOME_upvr:InvokeServer(ProcessOutbound_upvr(packed_upvr_2)))
						end
						return table.pack(SOME_upvr:InvokeServer(table.unpack(packed_upvr_2, 1, packed_upvr_2.n)))
					end)
					if pcall_result1_2 then
						for _, v_2 in ipairs(arg4) do
							local packed_3 = table.pack(v_2(pcall_result2))
							if not packed_3[1] then
								return table.unpack(packed_3, 2, packed_3.n)
							end
							pcall_result2.n = #pcall_result2
						end
						arg1_3(table.unpack(pcall_result2, 1, pcall_result2.n))
					else
						arg2_2(pcall_result2)
					end
				end)
			end
		end
		return function(...) -- Line 59
			--[[ Upvalues[4]:
				[1]: var7_upvr (readonly)
				[2]: SOME_upvr (readonly)
				[3]: ProcessOutbound_upvr (readonly)
				[4]: arg4 (readonly)
			]]
			local var31
			if var7_upvr then
				var31 = table.pack(SOME_upvr:InvokeServer(ProcessOutbound_upvr(table.pack(...))))
			else
				var31 = table.pack(SOME_upvr:InvokeServer(...))
			end
			for _, v_3 in ipairs(arg4) do
				local packed_2 = table.pack(v_3(var31))
				if not packed_2[1] then
					return table.unpack(packed_2, 2, packed_2.n)
				end
				var31.n = #var31
			end
			return table.unpack(var31, 1, var31.n)
		end
	end
	if arg3 then
		return function(...) -- Line 78
			--[[ Upvalues[4]:
				[1]: Promise_upvr (copied, readonly)
				[2]: var7_upvr (readonly)
				[3]: SOME_upvr (readonly)
				[4]: ProcessOutbound_upvr (readonly)
			]]
			local packed_upvr = table.pack(...)
			return Promise_upvr.new(function(arg1_4, arg2_3) -- Line 80
				--[[ Upvalues[4]:
					[1]: var7_upvr (copied, readonly)
					[2]: SOME_upvr (copied, readonly)
					[3]: ProcessOutbound_upvr (copied, readonly)
					[4]: packed_upvr (readonly)
				]]
				local pcall_result1, pcall_result2_2 = pcall(function() -- Line 81
					--[[ Upvalues[4]:
						[1]: var7_upvr (copied, readonly)
						[2]: SOME_upvr (copied, readonly)
						[3]: ProcessOutbound_upvr (copied, readonly)
						[4]: packed_upvr (copied, readonly)
					]]
					if var7_upvr then
						return table.pack(SOME_upvr:InvokeServer(ProcessOutbound_upvr(packed_upvr)))
					end
					return table.pack(SOME_upvr:InvokeServer(table.unpack(packed_upvr, 1, packed_upvr.n)))
				end)
				if pcall_result1 then
					arg1_4(table.unpack(pcall_result2_2, 1, pcall_result2_2.n))
				else
					arg2_3(pcall_result2_2)
				end
			end)
		end
	end
	if var7_upvr then
		return function(...) -- Line 97
			--[[ Upvalues[2]:
				[1]: SOME_upvr (readonly)
				[2]: ProcessOutbound_upvr (readonly)
			]]
			return SOME_upvr:InvokeServer(ProcessOutbound_upvr(table.pack(...)))
		end
	end
	return function(...) -- Line 101
		--[[ Upvalues[1]:
			[1]: SOME_upvr (readonly)
		]]
		return SOME_upvr:InvokeServer(...)
	end
end
local ClientRemoteSignal_upvr = require(script.ClientRemoteSignal)
function module.GetSignal(arg1, arg2, arg3, arg4) -- Line 109
	--[[ Upvalues[2]:
		[1]: Util_upvr (readonly)
		[2]: ClientRemoteSignal_upvr (readonly)
	]]
	assert(not Util_upvr.IsServer, "GetSignal must be called from the client")
	local var45 = arg2
	local SOME_2 = Util_upvr.GetCommSubFolder(arg1, "RE"):Expect("Failed to get Comm RE folder"):WaitForChild(var45, Util_upvr.WaitForChildTimeout)
	if SOME_2 == nil then
		var45 = false
	else
		var45 = true
	end
	assert(var45, "Failed to find RemoteEvent: "..arg2)
	return ClientRemoteSignal_upvr.new(SOME_2, arg3, arg4)
end
local ClientRemoteProperty_upvr = require(script.ClientRemoteProperty)
function module.GetProperty(arg1, arg2, arg3, arg4) -- Line 122
	--[[ Upvalues[2]:
		[1]: Util_upvr (readonly)
		[2]: ClientRemoteProperty_upvr (readonly)
	]]
	assert(not Util_upvr.IsServer, "GetProperty must be called from the client")
	local var48 = arg2
	local SOME = Util_upvr.GetCommSubFolder(arg1, "RP"):Expect("Failed to get Comm RP folder"):WaitForChild(var48, Util_upvr.WaitForChildTimeout)
	if SOME == nil then
		var48 = false
	else
		var48 = true
	end
	assert(var48, "Failed to find RemoteEvent for RemoteProperty: "..arg2)
	return ClientRemoteProperty_upvr.new(SOME, arg3, arg4)
end
return module