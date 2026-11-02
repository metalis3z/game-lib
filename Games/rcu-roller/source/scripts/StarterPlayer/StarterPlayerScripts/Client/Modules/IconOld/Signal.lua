-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw


-- Decompiler will be improved VERY SOON!

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)

-- Decompiled on 2025-03-27 06:21:24

-- Luau version 6, Types version 3

-- Time taken: 0.002099 seconds


local HttpService_upvr = game:GetService("HttpService")

local module_upvr = {}

module_upvr.__index = module_upvr

module_upvr.ClassName = "Signal"

module_upvr.totalConnections = 0

function module_upvr.new(arg1) -- Line 12

	--[[ Upvalues[1]:

		[1]: module_upvr (readonly)

	]]

	local setmetatable_result1 = setmetatable({}, module_upvr)

	if arg1 then

		setmetatable_result1.connectionsChanged = module_upvr.new()

	end

	setmetatable_result1.connections = {}

	setmetatable_result1.totalConnections = 0

	setmetatable_result1.waiting = {}

	setmetatable_result1.totalWaiting = 0

	return setmetatable_result1

end

function module_upvr.Fire(arg1, ...) -- Line 30

	for _, v in pairs(arg1.connections) do

		v.Handler(...)

	end

	if 0 < arg1.totalWaiting then

		for i_2, _ in pairs(arg1.waiting) do

			arg1.waiting[i_2] = table.pack(...)

			local _

		end

	end

end

module_upvr.fire = module_upvr.Fire

function module_upvr.Connect(arg1, arg2) -- Line 43

	--[[ Upvalues[1]:

		[1]: HttpService_upvr (readonly)

	]]

	if type(arg2) ~= "function" then

		error(string.format("connect(%s)", typeof(arg2)), 2)

	end

	local any_GenerateGUID_result1_2_upvr = HttpService_upvr:GenerateGUID(false)

	local module_upvr_2 = {

		Connected = true;

		ConnectionId = any_GenerateGUID_result1_2_upvr;

	}

	module_upvr_2.Handler = arg2

	arg1.connections[any_GenerateGUID_result1_2_upvr] = module_upvr_2

	function module_upvr_2.Disconnect(arg1_2) -- Line 56

		--[[ Upvalues[3]:

			[1]: arg1 (readonly)

			[2]: any_GenerateGUID_result1_2_upvr (readonly)

			[3]: module_upvr_2 (readonly)

		]]

		arg1.connections[any_GenerateGUID_result1_2_upvr] = nil

		module_upvr_2.Connected = false

		local var21 = arg1

		var21.totalConnections -= 1

		if arg1.connectionsChanged then

			arg1.connectionsChanged:Fire(-1)

		end

	end

	module_upvr_2.Destroy = module_upvr_2.Disconnect

	module_upvr_2.destroy = module_upvr_2.Disconnect

	module_upvr_2.disconnect = module_upvr_2.Disconnect

	arg1.totalConnections += 1

	if arg1.connectionsChanged then

		arg1.connectionsChanged:Fire(1)

	end

	return module_upvr_2

end

module_upvr.connect = module_upvr.Connect

local Heartbeat_upvr = game:GetService("RunService").Heartbeat

function module_upvr.Wait(arg1) -- Line 76

	--[[ Upvalues[2]:

		[1]: HttpService_upvr (readonly)

		[2]: Heartbeat_upvr (readonly)

	]]

	local any_GenerateGUID_result1 = HttpService_upvr:GenerateGUID(false)

	arg1.waiting[any_GenerateGUID_result1] = true

	arg1.totalWaiting += 1

	repeat

		Heartbeat_upvr:Wait()

	until arg1.waiting[any_GenerateGUID_result1] ~= true

	arg1.totalWaiting -= 1

	arg1.waiting[any_GenerateGUID_result1] = nil

	return unpack(arg1.waiting[any_GenerateGUID_result1])

end

module_upvr.wait = module_upvr.Wait

function module_upvr.Destroy(arg1) -- Line 88

	if arg1.bindableEvent then

		arg1.bindableEvent:Destroy()

		arg1.bindableEvent = nil

	end

	if arg1.connectionsChanged then

		arg1.connectionsChanged:Fire(-arg1.totalConnections)

		arg1.connectionsChanged:Destroy()

		arg1.connectionsChanged = nil

	end

	arg1.totalConnections = 0

	for i_3, _ in pairs(arg1.connections) do

		arg1.connections[i_3] = nil

	end

end

module_upvr.destroy = module_upvr.Destroy

module_upvr.Disconnect = module_upvr.Destroy

module_upvr.disconnect = module_upvr.Destroy

return module_upvr
