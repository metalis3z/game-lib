-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: DataServiceServer, time of decompilation: Sun May  3 10:10:37 2026 ]]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

if RunService:IsClient() then
	return {}
end

local ParentParent = script.Parent.Parent
local Signal = require(ParentParent.Signal)
local Networker = require(ParentParent.Networker)
local v6 = if not RunService:IsServer() then nil else require(ParentParent.ProfileStore)
local Data = require(script.Parent.Data)
local DataServiceUtils = require(script.Parent.DataServiceUtils)

return {
	_profiles = {},
	_data = {},
	_waitSignals = {},
	_globalCallbacks = {},
	_globalCallbackAdded = Signal.new(),
	_removalFunctions = {},
	options = {},
	init = function(p1, t1: {[any]: any}) --[[ init ]] -- line: 127
		-- upvalues: RunService (copy), v6 (copy), Networker (copy), Players (copy)
		assert(RunService:IsServer(), "DataServiceServer can only be used on the server.")
		assert(not p1.playerStore, "DataServiceServer has already been initialized.")
		p1.options = t1
		p1.playerStore = v6.New(t1.profileStoreIndex or "Default", t1.template)
		p1.networker = Networker.server.new("DataService", p1, { p1.get })

		for _, v12 in Players:GetPlayers() do
			task.spawn(function() -- line: 135
				-- upvalues: p1 (copy), v12 (copy)
				p1:_playerAdded(v12)
			end)
		end

		Players.PlayerAdded:Connect(function(player) -- line: 140
			-- upvalues: p1 (copy)
			p1:_playerAdded(player)
		end)
		Players.PlayerRemoving:Connect(function(player) -- line: 144
			-- upvalues: p1 (copy)
			p1:_playerRemoving(player)
		end)
	end,
	resetData = function(p2, p3) --[[ resetData ]] -- line: 170
		local v16 = p2:_getProfileKey(p3.UserId)

		p2:_playerRemoving(p3)
		p2.playerStore:RemoveAsync(v16)
		p3:Kick("Your data has been reset. Please rejoin.")
	end,
	_playerAdded = function(p4, p5) --[[ _playerAdded ]] -- line: 177
		-- upvalues: Players (copy)
		local v19 = p4.options.overridenUserId or (p4.options.viewedUserId or p5.UserId)
		local v20 = p4:_getProfileKey(v19)

		if p4.options.resetData and not p4.options.viewedUserId then
			p4.playerStore:RemoveAsync(v20)
		end

		local v21 = if not p4.options.useMock then if not p4.options.viewedUserId and not p4.options.dontSave then p4.playerStore:StartSessionAsync(v20, {
			Cancel = function() --[[ Cancel ]] -- line: 151
				-- upvalues: p5 (copy), Players (copy)
				return p5.Parent ~= Players
			end
		}) else p4.playerStore:GetAsync(v20) else p4.playerStore.Mock:StartSessionAsync(v20, {
			Cancel = function() --[[ Cancel ]] -- line: 151
				-- upvalues: p5 (copy), Players (copy)
				return p5.Parent ~= Players
			end
		})

		if not v21 then
			p5:Kick("Profile load fail - Please rejoin")

			return
		end

		v21:AddUserId(v19)
		v21:Reconcile()
		v21.OnSessionEnd:Connect(function() -- line: 197
			-- upvalues: p4 (copy), p5 (copy)
			p4._profiles[p5] = nil
			p5:Kick("Profile session end - Please rejoin")
		end)

		if not p5:IsDescendantOf(Players) then
			p5:Kick("Profile load fail - Please rejoin")

			return
		end

		p4._profiles[p5] = v21
		p4:_initPlayer(p5, v21.Data)

		if not p5:IsDescendantOf(Players) then
			p5:Kick("Profile load fail - Please rejoin")

			return
		end

		v21:MessageHandler(function(t2: {[any]: any}, p6: ((...any) -> ...any)) -- line: 215
			-- upvalues: p4 (copy), p5 (copy)
			local v103 = p4._globalCallbacks[t2.key]

			if v103 then
				if v103(p5, t2.data) ~= false then
					p6()
				end

				return
			end

			local connection = nil

			connection = p4._globalCallbackAdded:Connect(function(s1: string) -- line: 225
				-- upvalues: t2 (copy), p4 (copy), p5 (copy), p6 (copy), connection (ref)
				if s1 ~= t2.key then
					return
				end

				if p4._globalCallbacks[t2.key](p5, t2.data) ~= false then
					p6()
				end

				connection:Disconnect()
			end)
		end)
	end,
	_getProfileKey = function(p7, p8) --[[ _getProfileKey ]] -- line: 237
		return (p7.options.profileStoreDataPrefix or "PLAYER_") .. tostring(p8)
	end,
	sendGlobalMessage = function(p9, s2: string, p10, t3: {[any]: any}) --[[ sendGlobalMessage ]] -- line: 257
		local t4 = {
			key = s2,
			data = t3
		}

		return p9.playerStore:MessageAsync(p9:_getProfileKey(p10), t4)
	end,
	addGlobalCallback = function(p11, s3: string, p12: ((...any) -> ...any)) --[[ addGlobalCallback ]] -- line: 285
		assert(p11._globalCallbacks[s3] == nil, "Global callback already exists for key: " .. s3)
		p11._globalCallbacks[s3] = p12
		p11._globalCallbackAdded:Fire(s3)
	end,
	_playerRemoving = function(p13, p14) --[[ _playerRemoving ]] -- line: 295
		local v34 = p13._profiles[p14]

		if not v34 then
			return
		end

		for _, v36 in p13._removalFunctions do
			local ok, result = pcall(v36, p14, v34.Data)

			if not ok then
				warn(result or "Error in removal function for " .. p14.Name)
			end
		end

		v34:EndSession()
		p13._profiles[p14] = nil

		local v39 = p13._waitSignals[p14]

		if v39 then
			v39:Destroy()
			p13._waitSignals[p14] = nil
		end

		local v40 = p13._data[p14]

		if v40 then
			v40:destroy()
			p13._data[p14] = nil
		end
	end,
	onPlayerInit = function(_, _, _) --[[ onPlayerInit ]] -- line: 347
	end,
	addPlayerRemovingCallback = function(p18, p19: ((...any) -> ...any)) --[[ addPlayerRemovingCallback ]] -- line: 373
		table.insert(p18._removalFunctions, p19)

		return function() -- line: 378
			-- upvalues: p18 (copy), p19 (copy)
			local v105 = table.find(p18._removalFunctions, p19)

			if v105 then
				table.remove(p18._removalFunctions, v105)
			end
		end
	end,
	asyncGetProfile = function(p20, p21) --[[ asyncGetProfile ]] -- line: 394
		local v48 = "PLAYER_" .. tostring(p21)

		return p20.playerStore:GetAsync(v48)
	end,
	_initPlayer = function(p22, p23, p24) --[[ _initPlayer ]] -- line: 399
		-- upvalues: Data (copy), DataServiceUtils (copy)
		p22._data[p23] = Data.new(p24)
		p22:onPlayerInit(p23, p24)
		p22.networker:fire(p23, DataServiceUtils.enums.actions.init, p24)

		local v52 = p22._waitSignals[p23]

		if v52 then
			v52:Fire()
			v52:Destroy()
			p22._waitSignals[p23] = nil
		end
	end,
	hasProfile = function(p25, p26) --[[ hasProfile ]] -- line: 420
		return p25._profiles[p26] ~= nil
	end,
	getProfile = function(p27, p28) --[[ getProfile ]] -- line: 433
		assert(p27._profiles[p28], "Profile does not exist for " .. p28.Name)

		return p27._profiles[p28]
	end,
	waitForData = function(p29, p30) --[[ waitForData ]] -- line: 448
		-- upvalues: Signal (copy)
		local v59 = p29._data[p30]

		if v59 then
			return v59
		end

		local v60 = p29._waitSignals[p30]

		if not v60 then
			v60 = Signal.new()
			p29._waitSignals[p30] = v60
		end

		v60:Wait()

		return p29._data[p30]
	end,
	get = function(p31, p32, p33) --[[ get ]] -- line: 480
		return p31._data[p32]:get(p33)
	end,
	set = function(p34, p35, p36, p37, b1: boolean?) --[[ set ]] -- line: 501
		-- upvalues: DataServiceUtils (copy)
		if not b1 then
			p34.networker:fire(p35, DataServiceUtils.enums.actions.set, p36, p37)
		end

		p34._data[p35]:set(p36, p37)
	end,
	update = function(p38, p39, p40, p41: ((...any) -> ...any), b2: boolean?) --[[ update ]] -- line: 527
		-- upvalues: DataServiceUtils (copy)
		local v74 = p38._data[p39]:update(p40, p41)

		if not b2 then
			p38.networker:fire(p39, DataServiceUtils.enums.actions.set, p40, v74)
		end

		return v74
	end,
	arrayInsert = function(p42, p43, p44, p45, n1: number?, b3: boolean?) --[[ arrayInsert ]] -- line: 564
		-- upvalues: DataServiceUtils (copy)
		if not b3 then
			p42.networker:fire(p43, DataServiceUtils.enums.actions.arrayInsert, p44, p45, n1)
		end

		p42._data[p43]:arrayInsert(p44, p45, n1)
	end,
	arrayRemove = function(p46, p47, p48, n2: number, b4: boolean?) --[[ arrayRemove ]] -- line: 598
		-- upvalues: DataServiceUtils (copy)
		local v86 = p46._data[p47]:arrayRemove(p48, n2)

		if not b4 then
			p46.networker:fire(p47, DataServiceUtils.enums.actions.arrayRemove, p48, n2)
		end

		return v86
	end,
	getChangedSignal = function(p49, p50, p51) --[[ getChangedSignal ]] -- line: 629
		return p49._data[p50]:getChangedSignal(p51)
	end,
	getIndexChangedSignal = function(p52, p53, p54) --[[ getIndexChangedSignal ]] -- line: 648
		return p52._data[p53]:getIndexChangedSignal(p54)
	end,
	getArrayInsertedSignal = function(p55, p56, p57) --[[ getArrayInsertedSignal ]] -- line: 667
		return p55._data[p56]:getArrayInsertedSignal(p57)
	end,
	getArrayRemovedSignal = function(p58, p59, p60) --[[ getArrayRemovedSignal ]] -- line: 686
		return p58._data[p59]:getArrayRemovedSignal(p60)
	end
}
