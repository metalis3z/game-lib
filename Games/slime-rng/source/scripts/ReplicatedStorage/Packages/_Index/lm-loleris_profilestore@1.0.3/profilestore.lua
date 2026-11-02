-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: profilestore, time of decompilation: Sun May  3 10:10:50 2026 ]]
local n1 = 300
local n2 = 10
local n3 = 5
local n4 = 40
local n5 = 630
local n6 = 120
local n7 = 5
local n8 = 120
local n9 = 120
local n10 = 1000
local u11 = nil

local function AcquireRunnerThreadAndCallEventHandler(p1, ...) -- line: 199
	-- upvalues: u11 (ref)
	local v54 = u11

	u11 = nil
	p1(...)
	u11 = v54
end
local function RunEventHandlerInFreeThread(...) -- line: 207
	-- upvalues: AcquireRunnerThreadAndCallEventHandler (copy)
	AcquireRunnerThreadAndCallEventHandler(...)

	while true do
		AcquireRunnerThreadAndCallEventHandler(coroutine.yield())
	end
end

local t1 = {}

t1.__index = t1

local t2 = {}

t2.__index = t2

function t1.Disconnect(p2) -- line: 220
	if p2.is_connected == false then
		return
	end

	local signal = p2.signal

	p2.is_connected = false
	signal.listener_count = signal.listener_count - 1

	if p2 == signal.head then
		signal.head = p2.next

		return
	end

	local head = signal.head

	while head ~= nil and p2 ~= head.next do
		head = head.next
	end

	if head ~= nil then
		head.next = p2.next
	end
end
function t2.New() -- line: 244
	-- upvalues: t2 (copy)
	local t3 = {
		head = nil,
		listener_count = 0
	}

	setmetatable(t3, t2)

	return t3
end
function t2.Connect(t4: {[any]: any}, p3: ((...any) -> ...any)) -- line: 256
	-- upvalues: t1 (copy)
	if type(p3) ~= "function" then
		error(`[{ script.Name }]: "listener" must be a function; Received { typeof(p3) }`)
	end

	local t5 = {
		is_connected = true,
		listener = p3,
		signal = t4,
		next = t4.head
	}

	setmetatable(t5, t1)
	t4.head = t5
	t4.listener_count = t4.listener_count + 1

	return t5
end
function t2.GetListenerCount(p4) -- line: 277
	return p4.listener_count
end
function t2.Fire(p5, ...) -- line: 281
	-- upvalues: u11 (ref), RunEventHandlerInFreeThread (copy)
	local head = p5.head

	while head ~= nil do
		if head.is_connected == true then
			if not u11 then
				u11 = coroutine.create(RunEventHandlerInFreeThread)
			end

			task.spawn(u11, head.listener, ...)
		end

		head = head.next
	end
end
function t2.Wait(p6) -- line: 294
	local thread = coroutine.running()
	local connection = nil

	connection = p6:Connect(function(...) -- line: 297
		-- upvalues: connection (ref), thread (copy)
		connection:Disconnect()
		task.spawn(thread, ...)
	end)

	return coroutine.yield()
end

local u16 = table.freeze({
	New = t2.New
})
local t6 = {}
local t7 = {}
local t8 = {}
local DataStoreService = game:GetService("DataStoreService")
local MessagingService = game:GetService("MessagingService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local PlaceId = game.PlaceId
local JobId = game.JobId
local n11 = 1
local elapsed = os.clock()
local n12 = 0
local n13 = 0
local n14 = 0
local n15 = 0
local v32 = RunService:IsStudio()
local s1 = "NotReady"
local t9 = {}
local t10 = {}
local u36 = false
local v37 = u16.New()
local v38 = u16.New()
local t11 = {}

local function WaitInUpdateQueue(p7) -- line: 353
	-- upvalues: t11 (copy)
	local v69 = false

	if t11[p7] == nil then
		v69 = true
		t11[p7] = {}
	end

	local v70 = t11[p7]

	if v69 == false then
		table.insert(v70, coroutine.running())
		coroutine.yield()
	end

	return function() -- line: 369
		-- upvalues: v70 (copy), t11 (copy), p7 (copy)
		local v300 = table.remove(v70, 1)

		if v300 ~= nil then
			coroutine.resume(v300)

			return
		end

		t11[p7] = nil
	end
end
local function DeepCopyTable(p8) -- line: 396
	-- upvalues: DeepCopyTable (copy)
	local t12 = {}

	for k, v in pairs(p8) do
		if type(v) == "table" then
			t12[k] = DeepCopyTable(v)
		else
			t12[k] = v
		end
	end

	return t12
end
local function ReconcileTable(p9, p10) -- line: 408
	-- upvalues: DeepCopyTable (copy), ReconcileTable (copy)
	for k, v in pairs(p10) do
		if type(k) == "string" then
			if p9[k] == nil then
				if type(v) == "table" then
					p9[k] = DeepCopyTable(v)
				else
					p9[k] = v
				end
			elseif type(p9[k]) == "table" and type(v) == "table" then
				ReconcileTable(p9[k], v)
			end
		end
	end
end
local function NewMockDataStoreKeyInfo(p11) -- line: 435
	-- upvalues: DeepCopyTable (copy)
	local str = tostring(p11.VersionId or 0)
	local v90 = p11.MetaData or {}
	local v91 = p11.UserIds or {}

	return {
		CreatedTime = p11.CreatedTime,
		UpdatedTime = p11.UpdatedTime,
		Version = string.rep("0", 16) .. "." .. string.rep("0", 10 - string.len(str)) .. str .. "." .. string.rep("0", 16) .. "." .. "01",
		GetMetadata = function() --[[ GetMetadata ]] -- line: 448
			-- upvalues: DeepCopyTable (copy), v90 (copy)
			return (DeepCopyTable(v90))
		end,
		GetUserIds = function() --[[ GetUserIds ]] -- line: 452
			-- upvalues: DeepCopyTable (copy), v91 (copy)
			return (DeepCopyTable(v91))
		end
	}
end
local function MockUpdateAsync(p12, p13, p14, p15, p16) -- line: 459
	-- upvalues: NewMockDataStoreKeyInfo (copy), DeepCopyTable (copy)
	local v97 = p12[p13]

	if v97 == nil then
		v97 = {}
		p12[p13] = v97
	end

	local v98 = math.floor(os.time() * 1000)
	local v99 = v97[p14]
	local v100 = false

	if v99 == nil then
		v100 = true

		if p16 ~= true then
			v99 = {
				Data = nil,
				VersionId = 0,
				CreatedTime = v98,
				UpdatedTime = v98,
				UserIds = {},
				MetaData = {}
			}
			v97[p14] = v99
		end
	end

	local v101 = v100 == false and NewMockDataStoreKeyInfo(v99) or nil
	local v102, v103, v104 = p15(v99 and v99.Data, v101)

	if v102 == nil then
		return nil
	end

	if v99 ~= nil and p16 ~= true then
		v99.Data = DeepCopyTable(v102)
		v99.UserIds = DeepCopyTable(v103 or {})
		v99.MetaData = DeepCopyTable(v104 or {})
		v99.VersionId = v99.VersionId + 1
		v99.UpdatedTime = v98
	end

	return DeepCopyTable(v102), v99 ~= nil and NewMockDataStoreKeyInfo(v99) or nil
end
local function UpdateAsync(p17, p18, p19, p20, p21, p22) -- line: 507
	-- upvalues: WaitInUpdateQueue (copy), s1 (ref), MockUpdateAsync (copy), t10 (copy), t9 (copy), v38 (copy), t8 (copy), v37 (copy)
	local u111 = nil
	local u112 = nil
	local v113 = WaitInUpdateQueue
	local p17Name = p17.Name
	local s2 = "L_"

	if p20 == true then
		s2 = "U_"
	elseif s1 ~= "Access" then
		s2 = "M_"
	end

	local v116 = v113(s2 .. p17Name .. "\000" .. p18)
	local ok, result = pcall(function() -- line: 520
		-- upvalues: p19 (copy), p20 (copy), u111 (ref), u112 (ref), MockUpdateAsync (copy), t10 (copy), p17 (copy), p18 (copy), p21 (copy), s1 (ref), t9 (copy), p22 (copy)
		local function v301(p23) -- line: 521
			-- upvalues: p19 (copy)
			local v363 = false
			local v364 = false
			local t13 = {
				0,
				{}
			}

			if p23 == nil then
				v363 = true
			elseif type(p23) ~= "table" then
				v363 = true
				v364 = true
			elseif type(p23.Data) == "table" and type(p23.MetaData) == "table" and type(p23.GlobalUpdates) == "table" then
				p23.WasOverwritten = false
				t13 = p23.GlobalUpdates

				if p19.ExistingProfileHandle ~= nil then
					p19.ExistingProfileHandle(p23)
				end
			elseif p23.Data == nil and p23.MetaData == nil and type(p23.GlobalUpdates) == "table" then
				p23.WasOverwritten = false
				t13 = p23.GlobalUpdates or t13
				v363 = true
			else
				v363 = true
				v364 = true
			end

			if v363 == true then
				p23 = {
					GlobalUpdates = t13
				}

				if p19.MissingProfileHandle ~= nil then
					p19.MissingProfileHandle(p23)
				end
			end

			if p19.EditProfile ~= nil then
				p19.EditProfile(p23)
			end

			if v364 == true then
				p23.WasOverwritten = true
			end

			return p23, p23.UserIds, p23.RobloxMetaData
		end

		if p20 == true then
			local v302, v303 = MockUpdateAsync(t10, p17.Name, p18, v301, p21)

			u111 = v302
			u112 = v303
			task.wait()

			return
		end

		if s1 ~= "Access" then
			local v304, v305 = MockUpdateAsync(t9, p17.Name, p18, v301, p21)

			u111 = v304
			u112 = v305
			task.wait()

			return
		end

		if p21 == true then
			if p22 ~= nil then
				local ok, result = pcall(function() -- line: 607
					-- upvalues: u111 (ref), u112 (ref), p17 (copy), p18 (copy), p22 (copy)
					local v366, v367 = p17.data_store:GetVersionAsync(p18, p22)

					u111 = v366
					u112 = v367
				end)

				if ok == false and type(result) == "string" and string.find(result, "not valid") ~= nil then
					warn(`[{ script.Name }]: Passed version argument is not valid; Traceback:\n` .. debug.traceback())
				end
			else
				local v308, v309 = p17.data_store:GetAsync(p18)

				u111 = v308
				u112 = v309
			end

			u111 = v301(u111)

			return
		end

		local v310, v311 = p17.data_store:UpdateAsync(p18, v301)

		u111 = v310
		u112 = v311
	end)

	v116()

	if ok == true and type(u111) == "table" then
		if u111.WasOverwritten == true and p21 ~= true then
			local p17Name2 = p17.Name

			warn(`[{ script.Name }]: Invalid profile was overwritten (STORE:{ p17Name2 }; KEY:{ p18 })`)
			v38:Fire(p17Name2, p18)
		end

		return u111, u112
	end

	local v120 = result or "Undefined error"
	local p17Name3 = p17.Name

	warn(`[{ script.Name }]: DataStore API error (STORE:{ p17Name3 }; KEY:{ p18 }) - { tostring(v120) }`)
	table.insert(t8, os.clock())
	v37:Fire(tostring(v120), p17Name3, p18)

	return nil
end
local function SaveProfileAsync(p24, p25, p26, p27) -- line: 709
	-- upvalues: t6 (copy), t7 (copy), n11 (ref), n14 (ref), UpdateAsync (copy), PlaceId (copy), JobId (copy), SaveProfileAsync (copy), DeepCopyTable (copy)
	if type(p24.Data) ~= "table" then
		error(`[{ script.Name }]: Developer code likely set "Profile.Data" to a non-table value! (STORE:{ p24.ProfileStore.Name }; KEY:{ p24.Key })`)
	end

	p24.OnSave:Fire()

	if p25 == true then
		p24.OnLastSave:Fire(p27 or "Manual")
	end

	if p25 == true and p26 ~= true then
		if p24.roblox_message_subscription ~= nil then
			p24.roblox_message_subscription:Disconnect()
		end

		t6[p24.session_token] = nil

		local v132 = table.find(t7, p24)

		if v132 ~= nil then
			table.remove(t7, v132)

			if v132 < n11 then
				n11 -= 1
			end

			if t7[n11] == nil then
				n11 = 1
			end
		end

		p24.OnSessionEnd:Fire()
	end

	n14 += 1

	local v133 = true
	local n16 = 1

	while v133 == true do
		if p25 ~= true then
			v133 = false
		end

		local v135, v136 = UpdateAsync(p24.ProfileStore, p24.Key, {
			ExistingProfileHandle = nil,
			MissingProfileHandle = nil,
			EditProfile = function(p28) --[[ EditProfile ]] -- line: 747
				-- upvalues: p26 (copy), PlaceId (copy), JobId (copy), p24 (copy), p25 (copy)
				local v313 = false

				if p26 ~= true then
					local ActiveSession = p28.MetaData.ActiveSession
					local SessionLoadCount = p28.MetaData.SessionLoadCount

					if type(ActiveSession) == "table" then
						v313 = ActiveSession[1] == PlaceId and ActiveSession[2] == JobId and SessionLoadCount == p24.load_index
					end
				else
					v313 = true
				end

				if v313 == true then
					local locked_global_updates = p24.locked_global_updates
					local v317 = p28.GlobalUpdates[2]

					if next(locked_global_updates) ~= nil then
						local n17 = 1

						while n17 <= #v317 do
							if locked_global_updates[v317[n17][1]] == true then
								table.remove(v317, n17)
							else
								n17 += 1
							end
						end
					end

					p28.Data = p24.Data
					p28.RobloxMetaData = p24.RobloxMetaData
					p28.UserIds = p24.UserIds

					if p26 ~= true then
						p28.MetaData.LastUpdate = os.time()

						if p25 == true then
							p28.MetaData.ActiveSession = nil

							return
						end
					else
						p28.MetaData.ActiveSession = nil
						p28.MetaData.ForceLoadSession = nil
					end
				end
			end
		}, p24.is_mock)

		if v135 ~= nil and v136 ~= nil then
			if p26 == true then
				break
			end

			v133 = false

			local ActiveSession = v135.MetaData.ActiveSession
			local SessionLoadCount = v135.MetaData.SessionLoadCount
			local v139 = type(ActiveSession) == "table" and (ActiveSession[1] == PlaceId and ActiveSession[2] == JobId and SessionLoadCount == p24.load_index)
			local ForceLoadSession = v135.MetaData.ForceLoadSession
			local v141 = type(ForceLoadSession) == "table" and not (ForceLoadSession[1] == PlaceId and ForceLoadSession[2] == JobId)
			local v142 = p24:IsActive()

			if v141 == true and v139 == true then
				if v142 == true then
					SaveProfileAsync(p24, true, false, "External")
				end

				break
			end

			local locked_global_updates = p24.locked_global_updates
			local received_global_updates = p24.received_global_updates
			local v145 = v135.GlobalUpdates[2]
			local t14 = {}
			local t15 = {}

			for _, v in ipairs(v145) do
				if locked_global_updates[v[1]] == true then
					t15[v[1]] = true
				elseif received_global_updates[v[1]] ~= true then
					received_global_updates[v[1]] = true
					table.insert(t14, v)
				end
			end

			for k in pairs(locked_global_updates) do
				if t15[k] ~= true then
					locked_global_updates[k] = nil
				end
			end

			p24.KeyInfo = v136
			p24.LastSavedData = v135.Data
			p24.global_updates = v135.GlobalUpdates and v135.GlobalUpdates[2] or {}

			if v139 == true then
				if v142 == true and p25 ~= true then
					for _, v in ipairs(t14) do
						local v153 = v[1]
						local v154 = v[#v]

						for _, v2 in ipairs(p24.message_handlers) do
							local u157 = false
							local v158 = DeepCopyTable(v154)

							task.spawn(v2, v158, function() -- line: 893
								-- upvalues: u157 (ref), locked_global_updates (copy), v153 (copy)
								u157 = true
								locked_global_updates[v153] = true
							end)

							if u157 == true then
								break
							end
						end
					end
				end
			else
				if p24.roblox_message_subscription ~= nil then
					p24.roblox_message_subscription:Disconnect()
				end

				if v142 == true then
					t6[p24.session_token] = nil

					local v159 = table.find(t7, p24)

					if v159 ~= nil then
						table.remove(t7, v159)

						if v159 < n11 then
							n11 -= 1
						end

						if t7[n11] == nil then
							n11 = 1
						end
					end

					p24.OnSessionEnd:Fire()
				end
			end

			p24.OnAfterSave:Fire(p24.LastSavedData)

			continue
		end

		if v133 == true then
			task.wait(n16)
			n16 = math.min(p27 ~= "Shutdown" and 20 or 8, n16 * 2)
		end
	end

	n14 -= 1
end

local t16 = {}

t16.__index = t16

function t16.New(p29, p30, p31, p32, p33, p34) -- line: 1033
	-- upvalues: DeepCopyTable (copy), u16 (ref), t16 (copy)
	local v166 = p29.Data or {}
	local v167 = p29.MetaData and p29.MetaData.ActiveSession or nil
	local v168 = p29.GlobalUpdates and p29.GlobalUpdates[2] or {}
	local t17 = {}

	for _, v in ipairs(v168) do
		t17[v[1]] = true
	end

	local t18 = {
		Data = v166,
		LastSavedData = DeepCopyTable(v166),
		FirstSessionTime = p29.MetaData and p29.MetaData.ProfileCreateTime or 0,
		SessionLoadCount = p29.MetaData and p29.MetaData.SessionLoadCount or 0,
		Session = v167 and {
			PlaceId = v167[1],
			JobId = v167[2]
		},
		RobloxMetaData = p29.RobloxMetaData or {},
		UserIds = p29.UserIds or {},
		KeyInfo = p30,
		OnAfterSave = u16.New(),
		OnSave = u16.New(),
		OnLastSave = u16.New(),
		OnSessionEnd = u16.New(),
		ProfileStore = p31,
		Key = p32,
		load_timestamp = os.clock(),
		is_mock = p33,
		session_token = p34 or "",
		load_index = p29.MetaData and p29.MetaData.SessionLoadCount or 0,
		locked_global_updates = {},
		received_global_updates = t17,
		message_handlers = {},
		global_updates = v168
	}

	setmetatable(t18, t16)

	return t18
end
function t16.IsActive(p35) -- line: 1082
	-- upvalues: t6 (copy)
	return p35 == t6[p35.session_token]
end
function t16.Reconcile(p36) -- line: 1086
	-- upvalues: ReconcileTable (copy)
	ReconcileTable(p36.Data, p36.ProfileStore.template)
end
function t16.EndSession(p37) -- line: 1090
	-- upvalues: SaveProfileAsync (copy)
	if p37:IsActive() == true then
		task.spawn(SaveProfileAsync, p37, true, nil, "Manual")
	end
end
function t16.AddUserId(p38, p39) -- line: 1096
	-- upvalues: s1 (ref)
	if type(p39) ~= "number" or p39 % 1 ~= 0 then
		warn(`[{ script.Name }]: Invalid UserId argument for :AddUserId() ({ tostring(p39) }); Traceback:\n` .. debug.traceback())

		return
	end

	if p39 < 0 and p38.is_mock ~= true and s1 == "Access" then
		return
	end

	if table.find(p38.UserIds, p39) == nil then
		table.insert(p38.UserIds, p39)
	end
end
function t16.RemoveUserId(p40, p41) -- line: 1113
	if type(p41) ~= "number" or p41 % 1 ~= 0 then
		warn(`[{ script.Name }]: Invalid UserId argument for :RemoveUserId() ({ tostring(p41) }); Traceback:\n` .. debug.traceback())

		return
	end

	local v180 = table.find(p40.UserIds, p41)

	if v180 ~= nil then
		table.remove(p40.UserIds, v180)
	end
end
function t16.SetAsync(p42) -- line: 1128
	-- upvalues: SaveProfileAsync (copy)
	if p42.view_mode ~= true then
		error(`[{ script.Name }]: :SetAsync() can only be used in view mode`)
	end

	SaveProfileAsync(p42, nil, true)
end
function t16.MessageHandler(p43, p44) -- line: 1138
	-- upvalues: DeepCopyTable (copy)
	if type(p44) ~= "function" then
		error(`[{ script.Name }]: fn argument is not a function`)
	end

	if p43.view_mode ~= true and p43:IsActive() ~= true then
		return
	end

	local locked_global_updates = p43.locked_global_updates

	table.insert(p43.message_handlers, p44)

	for _, v in ipairs(p43.global_updates) do
		local v187 = v[1]
		local v188 = v[#v]

		if locked_global_updates[v187] ~= true then
			local v189 = DeepCopyTable(v188)

			task.spawn(p44, v189, function() -- line: 1158
				-- upvalues: locked_global_updates (copy), v187 (copy)
				locked_global_updates[v187] = true
			end)
		end
	end
end
function t16.Save(p45) -- line: 1172
	-- upvalues: t6 (copy), t7 (copy), n11 (ref), elapsed (ref), SaveProfileAsync (copy)
	if p45.view_mode == true then
		error(`[{ script.Name }]: Can't save profile in view mode; Should you be calling :SetAsync() instead?`)
	end

	if p45:IsActive() == false then
		warn(`[{ script.Name }]: Attempted saving an inactive profile (STORE:{ p45.ProfileStore.Name }; KEY:{ p45.Key });` .. " Traceback:\n" .. debug.traceback())

		return
	end

	t6[p45.session_token] = nil

	local v191 = table.find(t7, p45)

	if v191 ~= nil then
		table.remove(t7, v191)

		if v191 < n11 then
			n11 -= 1
		end

		if t7[n11] == nil then
			n11 = 1
		end
	end

	t6[p45.session_token] = p45
	table.insert(t7, n11, p45)

	if #t7 > 1 then
		n11 += 1
	elseif #t7 == 1 then
		elapsed = os.clock()
	end

	task.spawn(SaveProfileAsync, p45)
end

local t19 = {
	IsClosing = false,
	IsCriticalState = false,
	DataStoreState = "NotReady",
	OnError = v37,
	OnOverwrite = v38,
	OnCriticalToggle = u16.New()
}

t19.__index = t19

function t19.SetConstant(p46, p47) -- line: 1205
	-- upvalues: n1 (ref), n2 (ref), n3 (ref), n4 (ref), n5 (ref), n6 (ref), n7 (ref), n8 (ref), n9 (ref), n10 (ref)
	if type(p47) ~= "number" then
		error(`[{ script.Name }]: Invalid value type`)
	end

	if p46 == "AUTO_SAVE_PERIOD" then
		n1 = p47

		return
	end

	if p46 == "LOAD_REPEAT_PERIOD" then
		n2 = p47

		return
	end

	if p46 == "FIRST_LOAD_REPEAT" then
		n3 = p47

		return
	end

	if p46 == "SESSION_STEAL" then
		n4 = p47

		return
	end

	if p46 == "ASSUME_DEAD" then
		n5 = p47

		return
	end

	if p46 == "START_SESSION_TIMEOUT" then
		n6 = p47

		return
	end

	if p46 == "CRITICAL_STATE_ERROR_COUNT" then
		n7 = p47

		return
	end

	if p46 == "CRITICAL_STATE_ERROR_EXPIRE" then
		n8 = p47

		return
	end

	if p46 == "CRITICAL_STATE_EXPIRE" then
		n9 = p47

		return
	end

	if p46 == "MAX_MESSAGE_QUEUE" then
		n10 = p47

		return
	end

	error(`[{ script.Name }]: Invalid constant name was provided`)
end
function t19.Test() -- line: 1237
	-- upvalues: t6 (copy), t7 (copy), n13 (ref), n14 (ref), t9 (copy), t10 (copy), t11 (copy)
	return {
		ActiveSessionCheck = t6,
		AutoSaveList = t7,
		ActiveProfileLoadJobs = n13,
		ActiveProfileSaveJobs = n14,
		MockStore = t9,
		UserMockStore = t10,
		UpdateQueue = t11
	}
end
function t19.New(p48, p49) -- line: 1249
	-- upvalues: u36 (ref), t19 (copy), s1 (ref), DataStoreService (copy)
	local v196 = p49 or {}

	if type(p48) ~= "string" then
		error(`[{ script.Name }]: Invalid or missing "store_name"`)
	elseif string.len(p48) == 0 then
		error(`[{ script.Name }]: store_name cannot be an empty string`)
	elseif string.len(p48) > 50 then
		error(`[{ script.Name }]: store_name is too long`)
	end

	if type(v196) ~= "table" then
		error(`[{ script.Name }]: Invalid template argument`)
	end

	local t20 = nil

	t20 = {
		data_store = nil,
		is_ready = true,
		Mock = {
			Name = p48,
			StartSessionAsync = function(_, p51) --[[ StartSessionAsync ]] -- line: 1272
				-- upvalues: u36 (ref), t20 (ref)
				u36 = true

				return t20:StartSessionAsync(p51)
			end,
			MessageAsync = function(_, p53, p54) --[[ MessageAsync ]] -- line: 1276
				-- upvalues: u36 (ref), t20 (ref)
				u36 = true

				return t20:MessageAsync(p53, p54)
			end,
			GetAsync = function(_, p56, p57) --[[ GetAsync ]] -- line: 1280
				-- upvalues: u36 (ref), t20 (ref)
				u36 = true

				return t20:GetAsync(p56, p57)
			end,
			VersionQuery = function(_, p59, p60, p61, p62) --[[ VersionQuery ]] -- line: 1284
				-- upvalues: u36 (ref), t20 (ref)
				u36 = true

				return t20:VersionQuery(p59, p60, p61, p62)
			end,
			RemoveAsync = function(_, p64) --[[ RemoveAsync ]] -- line: 1288
				-- upvalues: u36 (ref), t20 (ref)
				u36 = true

				return t20:RemoveAsync(p64)
			end
		},
		Name = p48,
		template = v196,
		load_jobs = {},
		mock_load_jobs = {}
	}

	local v198 = t19

	setmetatable(t20, v198)

	local DataStoreOptions = Instance.new("DataStoreOptions")

	DataStoreOptions:SetExperimentalFeatures({
		v2 = true
	})

	if s1 == "NotReady" then
		t20.is_ready = false
		task.spawn(function() -- line: 1314
			-- upvalues: s1 (ref), t20 (ref), DataStoreService (copy), p48 (copy), DataStoreOptions (copy)
			repeat
				task.wait()
			until s1 ~= "NotReady"

			if s1 == "Access" then
				t20.data_store = DataStoreService:GetDataStore(p48, nil, DataStoreOptions)
			end

			t20.is_ready = true
		end)
	elseif s1 == "Access" then
		t20.data_store = DataStoreService:GetDataStore(p48, nil, DataStoreOptions)
	end

	return t20
end

local function RobloxMessageSubscription(p65, p66) -- line: 1336
	-- upvalues: MessagingService (copy), SaveProfileAsync (copy)
	local n18 = 0
	local v203 = MessagingService:SubscribeAsync("PS_" .. p66, function(p67) -- line: 1340
		-- upvalues: p65 (copy), n18 (ref), SaveProfileAsync (copy)
		if type(p67.Data) == "table" and p67.Data.LoadCount == p65.SessionLoadCount and os.clock() - n18 > 6 then
			n18 = os.clock()

			if p65:IsActive() == true then
				if p67.Data.EndSession == true then
					SaveProfileAsync(p65, true, false, "External")

					return
				end

				p65:Save()
			end
		end
	end)

	if p65:IsActive() == true then
		p65.roblox_message_subscription = v203
	else
		v203:Disconnect()
	end
end

function t19.StartSessionAsync(p68, p69, p70) -- line: 1364
	-- upvalues: u36 (ref), t19 (copy), s1 (ref), t6 (copy), n13 (ref), n12 (ref), HttpService (copy), UpdateAsync (copy), PlaceId (copy), JobId (copy), n5 (ref), DeepCopyTable (copy), t16 (copy), t7 (copy), n11 (ref), elapsed (ref), RobloxMessageSubscription (copy), SaveProfileAsync (copy), n4 (ref), n2 (ref), MessagingService (copy), n3 (ref), n6 (ref)
	local v207 = u36

	u36 = false

	local g233 = nil
	local g235 = nil

	if type(p69) ~= "string" then
		error(`[{ script.Name }]: profile_key must be a string`)
	elseif string.len(p69) == 0 then
		error(`[{ script.Name }]: Invalid profile_key`)
	elseif string.len(p69) > 50 then
		error(`[{ script.Name }]: profile_key is too long`)
	end

	if p70 ~= nil and type(p70) ~= "table" then
		error(`[{ script.Name }]: Invalid params`)
	end

	local u208 = p70 or {}

	if t19.IsClosing == true then
		return nil
	end

	while p68.is_ready == false do
		task.wait()
	end

	local p68Name = p68.Name
	local s3 = "L_"

	if v207 == true then
		s3 = "U_"
	elseif s1 ~= "Access" then
		s3 = "M_"
	end

	local v211 = s3 .. p68Name .. "\000" .. p69

	if t6[v211] ~= nil then
		error(`[{ script.Name }]: Profile (STORE:{ p68.Name }; KEY:{ p69 }) is already loaded in this session`)
	end

	n13 += 1

	local u212 = false
	local v213 = u208.Steal == true
	local n19 = 0
	local u215 = true
	local u216 = false
	local elapsed2 = os.clock()
	local n20 = 1

	while t19.IsClosing == false do
		local v219

		if u212 == false then
			if u208.Cancel ~= nil then
				u212 = u208.Cancel() == true
			end

			v219 = u212
		else
			v219 = true
		end

		if v219 ~= false then
			break
		end

		n12 += 1

		local v220 = n12
		local v221 = v207 == true and p68.mock_load_jobs or p68.load_jobs
		local v222 = v221[p69]
		local guid = HttpService:GenerateGUID(false)
		local v224, v225

		if v222 ~= nil then
			v222[1] = v220

			while v222[2] == nil do
				task.wait()
			end

			if v220 ~= v222[1] then
				n13 -= 1

				return nil
			end

			v224, v225 = table.unpack(v222[2])
			v221[p69] = nil
		else
			local t21 = {
				v220,
				nil
			}

			v221[p69] = t21
			t21[2] = table.pack(UpdateAsync(p68, p69, {
				ExistingProfileHandle = function(p71) --[[ ExistingProfileHandle ]] -- line: 1456
					-- upvalues: t19 (copy), u212 (ref), u208 (ref), PlaceId (copy), JobId (copy), guid (copy), n5 (ref), u216 (ref), v213 (copy), u215 (ref)
					if t19.IsClosing ~= true then
						local v336

						if u212 == false then
							if u208.Cancel ~= nil then
								u212 = u208.Cancel() == true
							end

							v336 = u212
						else
							v336 = true
						end

						if v336 ~= true then
							local ActiveSession = p71.MetaData.ActiveSession
							local ForceLoadSession = p71.MetaData.ForceLoadSession

							if ActiveSession == nil then
								p71.MetaData.ActiveSession = {
									PlaceId,
									JobId,
									guid
								}
								p71.MetaData.ForceLoadSession = nil

								return
							end

							if type(ActiveSession) == "table" then
								if (ActiveSession[1] == PlaceId and ActiveSession[2] == JobId) == false then
									local LastUpdate = p71.MetaData.LastUpdate

									if LastUpdate ~= nil and os.time() - LastUpdate > n5 then
										p71.MetaData.ActiveSession = {
											PlaceId,
											JobId,
											guid
										}
										p71.MetaData.ForceLoadSession = nil

										return
									end

									if u216 == true or v213 == true then
										if (ForceLoadSession == nil or not (ForceLoadSession[1] == PlaceId and ForceLoadSession[2] == JobId)) == false or v213 == true then
											p71.MetaData.ActiveSession = {
												PlaceId,
												JobId,
												guid
											}
											p71.MetaData.ForceLoadSession = nil

											return
										end
									elseif u215 == true then
										p71.MetaData.ForceLoadSession = {
											PlaceId,
											JobId
										}

										return
									end
								else
									p71.MetaData.ForceLoadSession = nil
								end
							end

							return
						end
					end
				end,
				MissingProfileHandle = function(p72) --[[ MissingProfileHandle ]] -- line: 1493
					-- upvalues: t19 (copy), u212 (ref), u208 (ref), DeepCopyTable (copy), p68 (copy), PlaceId (copy), JobId (copy), guid (copy)
					local v341 = true

					if t19.IsClosing ~= true then
						local v342

						if u212 == false then
							if u208.Cancel ~= nil then
								u212 = u208.Cancel() == true
							end

							v342 = u212
						else
							v342 = true
						end

						v341 = v342 == true
					end

					p72.Data = DeepCopyTable(p68.template)
					p72.MetaData = {
						SessionLoadCount = 0,
						ForceLoadSession = nil,
						ProfileCreateTime = os.time(),
						ActiveSession = if v341 ~= false then nil else {
							PlaceId,
							JobId,
							guid
						},
						MetaTags = {}
					}
				end,
				EditProfile = function(p73) --[[ EditProfile ]] -- line: 1507
					-- upvalues: t19 (copy), u212 (ref), u208 (ref), PlaceId (copy), JobId (copy)
					if t19.IsClosing ~= true then
						local v344

						if u212 == false then
							if u208.Cancel ~= nil then
								u212 = u208.Cancel() == true
							end

							v344 = u212
						else
							v344 = true
						end

						if v344 ~= true then
							local ActiveSession = p73.MetaData.ActiveSession

							if ActiveSession ~= nil and (ActiveSession[1] == PlaceId and ActiveSession[2] == JobId) == true then
								p73.MetaData.SessionLoadCount = p73.MetaData.SessionLoadCount + 1
								p73.MetaData.LastUpdate = os.time()
							end

							return
						end
					end
				end
			}, v207))

			if v220 ~= t21[1] then
				n13 -= 1

				return nil
			end

			v224, v225 = table.unpack(t21[2])
			v221[p69] = nil
		end

		if v224 ~= nil and v225 ~= nil then
			local ActiveSession = v224.MetaData.ActiveSession

			if type(ActiveSession) ~= "table" then
				n13 -= 1

				return nil
			end

			if (ActiveSession[1] == PlaceId and ActiveSession[2] == JobId) ~= true then
				if t19.IsClosing ~= true then
					local v228

					if u212 == false then
						if u208.Cancel ~= nil then
							u212 = u208.Cancel() == true
						end

						v228 = u212
					else
						v228 = true
					end

					if v228 ~= true then
						local ForceLoadSession = v224.MetaData.ForceLoadSession

						if (ForceLoadSession == nil or not (ForceLoadSession[1] == PlaceId and ForceLoadSession[2] == JobId)) == false then
							if u215 == false then
								n19 += 1

								if n19 >= math.ceil(n4 / n2) then
									u216 = true
								end
							end

							if type(ActiveSession[3]) == "string" then
								local v230 = v224.MetaData.SessionLoadCount or 0

								task.spawn(MessagingService.PublishAsync, MessagingService, "PS_" .. ActiveSession[3], {
									EndSession = true,
									LoadCount = v230
								})
							end

							local v231 = os.clock() + if u215 ~= true then n2 else n3

							repeat
								task.wait()
							until v231 <= os.clock() or t19.IsClosing == true

							u215 = false

							continue
						end

						n13 -= 1

						return nil
					end
				end

				n13 -= 1

				return nil
			end

			local v232 = t16.New(v224, v225, p68, p69, v207, v211)

			t6[v232.session_token] = v232
			table.insert(t7, n11, v232)

			if #t7 > 1 then
				n11 += 1
			elseif #t7 == 1 then
				elapsed = os.clock()
			end

			if v207 ~= true and s1 == "Access" then
				task.spawn(RobloxMessageSubscription, v232, guid)
			end

			repeat
				if not g233 and t19.IsClosing ~= true then
					local v234

					if u212 == false then
						if u208.Cancel ~= nil then
							u212 = u208.Cancel() == true
						end

						v234 = u212
					else
						v234 = true
					end

					if v234 == true then
						g233 = true
					end
				else
					g233 = false
					SaveProfileAsync(v232, true)
					v232 = nil
				end
			until not g233

			n13 -= 1

			return v232
		end

		repeat
			if g235 or ((u208.Cancel == nil and os.clock() - elapsed2 >= n6) == true or t19.IsClosing == true) then
				g235 = false
				n13 -= 1

				return nil
			end

			local v236

			if u212 == false then
				if u208.Cancel ~= nil then
					u212 = u208.Cancel() == true
				end

				v236 = u212
			else
				v236 = true
			end

			if v236 == true then
				g235 = true
			end
		until not g235

		task.wait(n20)
		n20 = math.min(20, n20 * 2)
	end

	n13 -= 1

	return nil
end
function t19.MessageAsync(p74, p75, p76) -- line: 1633
	-- upvalues: u36 (ref), t19 (copy), UpdateAsync (copy), n10 (ref), s1 (ref), t6 (copy), MessagingService (copy)
	local v240 = u36

	u36 = false

	if type(p75) ~= "string" then
		error(`[{ script.Name }]: profile_key must be a string`)
	elseif string.len(p75) == 0 then
		error(`[{ script.Name }]: Invalid profile_key`)
	elseif string.len(p75) > 50 then
		error(`[{ script.Name }]: profile_key is too long`)
	end

	if type(p76) ~= "table" then
		error(`[{ script.Name }]: message must be a table`)
	end

	if t19.IsClosing == true then
		return false
	end

	while p74.is_ready == false do
		task.wait()
	end

	local n21 = 1

	while t19.IsClosing == false do
		local v242 = UpdateAsync(p74, p75, {
			ExistingProfileHandle = nil,
			MissingProfileHandle = nil,
			EditProfile = function(p77) --[[ EditProfile ]] -- line: 1667
				-- upvalues: p76 (copy), n10 (ref)
				local GlobalUpdates = p77.GlobalUpdates
				local v348 = GlobalUpdates[2]

				GlobalUpdates[1] = GlobalUpdates[1] + 1
				table.insert(v348, {
					GlobalUpdates[1],
					p76
				})

				while #v348 > n10 do
					table.remove(v348, 1)
				end
			end
		}, v240)

		if v242 ~= nil then
			local p74Name = p74.Name
			local s4 = "L_"

			if v240 == true then
				s4 = "U_"
			elseif s1 ~= "Access" then
				s4 = "M_"
			end

			local v245 = t6[s4 .. p74Name .. "\000" .. p75]

			if v245 ~= nil then
				v245:Save()
			else
				local v246 = v242.MetaData or {}
				local ActiveSession = v246.ActiveSession
				local v248 = v246.SessionLoadCount or 0

				if type(ActiveSession) == "table" and type(ActiveSession[3]) == "string" then
					task.spawn(MessagingService.PublishAsync, MessagingService, "PS_" .. ActiveSession[3], {
						LoadCount = v248
					})
				end
			end

			return true
		end

		task.wait(n21)
		n21 = math.min(20, n21 * 2)
	end

	return false
end
function t19.GetAsync(p78, p79, p80) -- line: 1731
	-- upvalues: u36 (ref), t19 (copy), s1 (ref), UpdateAsync (copy), DeepCopyTable (copy), t16 (copy)
	local v252 = u36

	u36 = false

	if type(p79) ~= "string" then
		error(`[{ script.Name }]: profile_key must be a string`)
	elseif string.len(p79) == 0 then
		error(`[{ script.Name }]: Invalid profile_key`)
	elseif string.len(p79) > 50 then
		error(`[{ script.Name }]: profile_key is too long`)
	end

	if t19.IsClosing == true then
		return nil
	end

	while p78.is_ready == false do
		task.wait()
	end

	if p80 ~= nil and (v252 or s1 ~= "Access") then
		return nil
	end

	local n22 = 1

	while t19.IsClosing == false do
		local v254, v255 = UpdateAsync(p78, p79, {
			ExistingProfileHandle = nil,
			EditProfile = nil,
			MissingProfileHandle = function(p81) --[[ MissingProfileHandle ]] -- line: 1764
				-- upvalues: DeepCopyTable (copy), p78 (copy)
				p81.Data = DeepCopyTable(p78.template)
				p81.MetaData = {
					SessionLoadCount = 0,
					ActiveSession = nil,
					ForceLoadSession = nil,
					ProfileCreateTime = os.time(),
					MetaTags = {}
				}
			end
		}, v252, true, p80)

		if v254 ~= nil then
			if v255 == nil then
				return nil
			end

			local v256 = t16.New(v254, v255, p78, p79, v252)

			v256.view_mode = true

			return v256
		end

		task.wait(n22)
		n22 = math.min(20, n22 * 2)
	end

	return nil
end
function t19.RemoveAsync(p82, p83) -- line: 1809
	-- upvalues: u36 (ref), t19 (copy), WaitInUpdateQueue (copy), s1 (ref), t10 (copy), t9 (copy)
	local v259 = u36

	u36 = false

	if type(p83) ~= "string" or string.len(p83) == 0 then
		error(`[{ script.Name }]: Invalid profile_key`)
	end

	if t19.IsClosing == true then
		return false
	end

	while p82.is_ready == false do
		task.wait()
	end

	local v260 = WaitInUpdateQueue
	local p82Name = p82.Name
	local s5 = "L_"

	if v259 == true then
		s5 = "U_"
	elseif s1 ~= "Access" then
		s5 = "M_"
	end

	local v263 = v260(s5 .. p82Name .. "\000" .. p83)
	local v265

	if v259 == true then
		local v264 = t10[p82.Name]

		if v264 ~= nil then
			v264[p83] = nil

			if next(v264) == nil then
				t10[p82.Name] = nil
			end
		end

		v265 = true
		task.wait()
	elseif s1 ~= "Access" then
		local v266 = t9[p82.Name]

		if v266 ~= nil then
			v266[p83] = nil

			if next(v266) == nil then
				t9[p82.Name] = nil
			end
		end

		v265 = true
		task.wait()
	else
		v265 = pcall(function() -- line: 1857
			-- upvalues: p82 (copy), p83 (copy)
			p82.data_store:RemoveAsync(p83)
		end)
	end

	v263()

	return v265
end

local t22 = {}

t22.__index = t22

function t22.New(p84, p85, p86, p87, p88, p89) -- line: 1872
	-- upvalues: t22 (copy)
	local t23 = {
		query_pages = nil,
		query_index = 0,
		query_failure = false,
		is_query_yielded = false,
		profile_store = p84,
		profile_key = p85,
		sort_direction = p86,
		min_date = p87,
		max_date = p88,
		query_queue = {},
		is_mock = p89
	}

	setmetatable(t23, t22)

	return t23
end
function MoveVersionQueryQueue(p90) -- line: 1896
	while #p90.query_queue > 0 do
		local v275 = table.remove(p90.query_queue, 1)

		task.spawn(v275)

		if p90.is_query_yielded == true then
			return
		end
	end
end

local u51 = false
local u52 = false

function t22.NextAsync(p91) -- line: 1913
	-- upvalues: u51 (ref), t19 (copy), s1 (ref), v32 (copy), u52 (ref)
	local v277 = u51 == true

	u51 = false

	local profile_store = p91.profile_store

	while profile_store.is_ready == false do
		task.wait()
	end

	if t19.IsClosing == true then
		return nil
	end

	if p91.is_mock == true or s1 ~= "Access" then
		if v32 == true and u52 == false then
			u52 = true
			warn(`[{ script.Name }]: :VersionQuery() is not supported in mock mode!`)
		end

		return nil
	end

	local u279 = nil
	local u280 = false

	local function query_job() -- line: 1935
		-- upvalues: p91 (copy), u280 (ref), u51 (ref), u279 (ref)
		if p91.query_failure == true then
			u280 = true

			return
		end

		if p91.query_pages == nil then
			p91.is_query_yielded = true
			task.spawn(function() -- line: 1948
				-- upvalues: u51 (ref), u279 (ref), p91 (copy), u280 (ref)
				u51 = true
				u279 = p91:NextAsync()
				u280 = true
			end)

			local ok, result = pcall(function() -- line: 1954
				-- upvalues: p91 (copy)
				p91.query_pages = p91.profile_store.data_store:ListVersionsAsync(p91.profile_key, p91.sort_direction, p91.min_date, p91.max_date)
				p91.query_index = 0
			end)

			if ok == false or p91.query_pages == nil then
				warn(`[{ script.Name }]: Version query fail - { tostring(result) }`)
				p91.query_failure = true
			end

			p91.is_query_yielded = false
			MoveVersionQueryQueue(p91)

			return
		end

		local v352 = p91.query_pages:GetCurrentPage()[p91.query_index + 1]

		if p91.query_pages.IsFinished == true and v352 == nil then
			u280 = true

			return
		end

		if v352 == nil then
			p91.is_query_yielded = true
			task.spawn(function() -- line: 1992
				-- upvalues: u51 (ref), u279 (ref), p91 (copy), u280 (ref)
				u51 = true
				u279 = p91:NextAsync()
				u280 = true
			end)

			local ok, _ = pcall(function() -- line: 1998
				-- upvalues: p91 (copy)
				p91.query_pages:AdvanceToNextPageAsync()
				p91.query_index = 0
			end)

			if ok == false or #p91.query_pages:GetCurrentPage() == 0 then
				p91.query_failure = true
			end

			p91.is_query_yielded = false
			MoveVersionQueryQueue(p91)

			return
		end

		local v355 = p91

		v355.query_index = v355.query_index + 1
		u279 = p91.profile_store:GetAsync(p91.profile_key, v352.Version)
		u280 = true
	end

	if p91.is_query_yielded == false then
		query_job()
	elseif v277 == true then
		table.insert(p91.query_queue, 1, query_job)
	else
		table.insert(p91.query_queue, query_job)
	end

	while u280 == false do
		task.wait()
	end

	return u279
end
function t19.VersionQuery(p92, p93, p94, p95, p96) -- line: 2040
	-- upvalues: u36 (ref), t22 (copy)
	local v287 = u36

	u36 = false

	if type(p93) ~= "string" or string.len(p93) == 0 then
		error(`[{ script.Name }]: Invalid profile_key`)
	end

	if p94 ~= nil and (typeof(p94) ~= "EnumItem" or p94.EnumType ~= Enum.SortDirection) then
		error(`[{ script.Name }]: Invalid sort_direction ({ tostring(p94) })`)
	end

	if p95 ~= nil and typeof(p95) ~= "DateTime" and typeof(p95) ~= "number" then
		error(`[{ script.Name }]: Invalid min_date ({ tostring(p95) })`)
	end

	if p96 ~= nil and typeof(p96) ~= "DateTime" and typeof(p96) ~= "number" then
		error(`[{ script.Name }]: Invalid max_date ({ tostring(p96) })`)
	end

	local v288 = typeof(p95) == "DateTime" and p95.UnixTimestampMillis or p95
	local v289 = typeof(p96) == "DateTime" and p96.UnixTimestampMillis or p96

	return t22.New(p92, p93, p94, v288, v289, v287)
end

if v32 == true then
	task.spawn(function() -- line: 2074
		-- upvalues: DataStoreService (copy), s1 (ref), t19 (copy)
		local ok, result = pcall(function() -- line: 2078
			-- upvalues: DataStoreService (copy)
			DataStoreService:GetDataStore("____PS"):SetAsync("____PS", os.time())
		end)
		local v292 = ok == false and string.find(result, "ConnectFail", 1, true) ~= nil

		if v292 == true then
			warn(`[{ script.Name }]: No internet access - check your network connection`)
		end

		local v293

		if ok == false and (string.find(result, "403", 1, true) ~= nil or string.find(result, "must publish", 1, true) ~= nil or v292 == true) then
			v293 = v292 ~= true and "NoAccess" or "NoInternet"
			print(`[{ script.Name }]: Roblox API services unavailable - data will not be saved`)
		else
			v293 = "Access"
			print(`[{ script.Name }]: Roblox API services available - data will be saved`)
		end

		s1 = v293
		t19.DataStoreState = v293
	end)
else
	s1 = "Access"
	t19.DataStoreState = "Access"
end

RunService.Heartbeat:Connect(function() -- line: 2115
	-- upvalues: t7 (copy), n1 (ref), elapsed (ref), n11 (ref), SaveProfileAsync (copy), t19 (copy), t8 (copy), n7 (ref), n15 (ref), n9 (ref), n8 (ref)
	local v294 = #t7

	if v294 > 0 then
		local v295 = n1 / v294
		local elapsed3 = os.clock()

		while v295 < elapsed3 - elapsed do
			elapsed += v295

			local v297 = t7[n11]

			if elapsed3 - v297.load_timestamp < n1 / 2 then
				v297 = nil

				for _ = 1, v294 - 1 do
					n11 += 1

					if v294 < n11 then
						n11 = 1
					end

					v297 = t7[n11]

					if elapsed3 - v297.load_timestamp >= n1 / 2 then
						break
					end

					v297 = nil
				end
			end

			n11 += 1

			if v294 < n11 then
				n11 = 1
			end

			if v297 ~= nil then
				task.spawn(SaveProfileAsync, v297)
			end
		end
	end

	if t19.IsCriticalState == false then
		if #t8 >= n7 then
			t19.IsCriticalState = true
			t19.OnCriticalToggle:Fire(true)
			n15 = os.clock()
			warn(`[{ script.Name }]: Entered critical state`)
		end
	elseif #t8 >= n7 then
		n15 = os.clock()
	elseif os.clock() - n15 > n9 then
		t19.IsCriticalState = false
		t19.OnCriticalToggle:Fire(false)
		warn(`[{ script.Name }]: Critical state ended`)
	end

	while true do
		local v299 = t8[1]

		if v299 == nil then
			break
		end

		if not (os.clock() - v299 > n8) then
			return
		end

		table.remove(t8, 1)
	end
end)
task.spawn(function() -- line: 2191
	-- upvalues: s1 (ref), t19 (copy), t7 (copy), SaveProfileAsync (copy), n13 (ref), n14 (ref)
	while s1 == "NotReady" do
		task.wait()
	end

	if s1 ~= "Access" then
		game:BindToClose(function() -- line: 2199
			-- upvalues: t19 (copy)
			t19.IsClosing = true
			task.wait()
		end)

		return
	end

	game:BindToClose(function() -- line: 2208
		-- upvalues: t19 (copy), t7 (copy), SaveProfileAsync (copy), n13 (ref), n14 (ref)
		t19.IsClosing = true

		local n23 = 0
		local t24 = {}

		for i, v in ipairs(t7) do
			t24[i] = v
		end

		for _, v in ipairs(t24) do
			if v:IsActive() == true then
				n23 += 1
				task.spawn(function() -- line: 2225
					-- upvalues: SaveProfileAsync (copy), v (copy), n23 (ref)
					SaveProfileAsync(v, true, nil, "Shutdown")
					n23 -= 1
				end)
			end
		end

		while n23 > 0 or n13 > 0 or n14 > 0 do
			task.wait()
		end
	end)
end)

return t19
