-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:15:43
-- Luau version 6, Types version 3
-- Time taken: 0.002747 seconds

local Players_upvr = game:GetService("Players")
local None_upvr = require(script.Parent.Parent.Util).None
local module_upvr = {}
module_upvr.__index = module_upvr
local RemoteSignal_upvr = require(script.Parent.RemoteSignal)
function module_upvr.new(arg1, arg2, arg3, arg4, arg5) -- Line 53
	--[[ Upvalues[4]:
		[1]: module_upvr (readonly)
		[2]: RemoteSignal_upvr (readonly)
		[3]: Players_upvr (readonly)
		[4]: None_upvr (readonly)
	]]
	local setmetatable_result1_upvr = setmetatable({}, module_upvr)
	setmetatable_result1_upvr._rs = RemoteSignal_upvr.new(arg1, arg2, false, arg4, arg5)
	setmetatable_result1_upvr._value = arg3
	setmetatable_result1_upvr._perPlayer = {}
	setmetatable_result1_upvr._playerRemoving = Players_upvr.PlayerRemoving:Connect(function(arg1_2) -- Line 64
		--[[ Upvalues[1]:
			[1]: setmetatable_result1_upvr (readonly)
		]]
		setmetatable_result1_upvr._perPlayer[arg1_2] = nil
	end)
	setmetatable_result1_upvr._rs:Connect(function(arg1_3) -- Line 67
		--[[ Upvalues[2]:
			[1]: setmetatable_result1_upvr (readonly)
			[2]: None_upvr (copied, readonly)
		]]
		local _perPlayer = setmetatable_result1_upvr._perPlayer
		local var9 = _perPlayer[arg1_3]
		if var9 == nil then
			_perPlayer = setmetatable_result1_upvr._value
		elseif var9 == None_upvr then
			_perPlayer = nil
		else
			_perPlayer = var9
		end
		setmetatable_result1_upvr._rs:Fire(arg1_3, _perPlayer)
	end)
	return setmetatable_result1_upvr
end
function module_upvr.Set(arg1, arg2) -- Line 91
	arg1._value = arg2
	table.clear(arg1._perPlayer)
	arg1._rs:FireAll(arg2)
end
function module_upvr.SetTop(arg1, arg2) -- Line 118
	--[[ Upvalues[1]:
		[1]: Players_upvr (readonly)
	]]
	arg1._value = arg2
	for _, v in ipairs(Players_upvr:GetPlayers()) do
		if arg1._perPlayer[v] == nil then
			arg1._rs:Fire(v, arg2)
		end
	end
end
function module_upvr.SetFilter(arg1, arg2, arg3) -- Line 141
	--[[ Upvalues[1]:
		[1]: Players_upvr (readonly)
	]]
	for _, v_2 in ipairs(Players_upvr:GetPlayers()) do
		if arg2(v_2, arg3) then
			arg1:SetFor(v_2, arg3)
		end
	end
end
function module_upvr.SetFor(arg1, arg2, arg3) -- Line 163
	--[[ Upvalues[1]:
		[1]: None_upvr (readonly)
	]]
	local var20
	if arg2.Parent then
		if arg3 == nil then
			var20 = None_upvr
		else
			var20 = arg3
		end
		arg1._perPlayer[arg2] = var20
	end
	arg1._rs:Fire(arg2, arg3)
end
function module_upvr.SetForList(arg1, arg2, arg3) -- Line 179
	for _, v_3 in ipairs(arg2) do
		arg1:SetFor(v_3, arg3)
	end
end
function module_upvr.ClearFor(arg1, arg2) -- Line 206
	if arg1._perPlayer[arg2] == nil then
	else
		arg1._perPlayer[arg2] = nil
		arg1._rs:Fire(arg2, arg1._value)
	end
end
function module_upvr.ClearForList(arg1, arg2) -- Line 219
	for _, v_4 in ipairs(arg2) do
		arg1:ClearFor(v_4)
	end
end
function module_upvr.ClearFilter(arg1, arg2) -- Line 229
	--[[ Upvalues[1]:
		[1]: Players_upvr (readonly)
	]]
	for _, v_5 in ipairs(Players_upvr:GetPlayers()) do
		if arg2(v_5) then
			arg1:ClearFor(v_5)
		end
	end
end
function module_upvr.Get(arg1) -- Line 247
	return arg1._value
end
function module_upvr.GetFor(arg1, arg2) -- Line 281
	--[[ Upvalues[1]:
		[1]: None_upvr (readonly)
	]]
	local var36 = arg1._perPlayer[arg2]
	if var36 == nil then
		return arg1._value
	end
	if var36 == None_upvr then
		return nil
	end
	return var36
end
function module_upvr.Destroy(arg1) -- Line 290
	arg1._rs:Destroy()
	arg1._playerRemoving:Disconnect()
end
return module_upvr