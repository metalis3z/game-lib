
local MS                 = game:GetService("MessagingService")
local HttpService        = game:GetService("HttpService")
local Players            = game:GetService("Players")
local MemoryStoreService = game:GetService("MemoryStoreService")

local MessagingService = {}

local BCAST_CHANNELS      = 4
local BCAST_PREFIX        = "Bc_"
local SERVER_TOPIC_PREFIX = "MS_Srv_"

local LEGACY_COMPAT       = true
local LEGACY_MAIN_TOPIC   = "GlobalNetworkBus"

local MAX_MESSAGE_BYTES   = 950
local BASE_BACKOFF        = 1.0
local MAX_BACKOFF         = 20
local MAX_QUEUE_SIZE      = 10000
local SUBSCRIBE_RETRIES   = 5
local SHUTDOWN_BUDGET     = 25

local SEND_BASE           = 600
local SEND_PER_PLAYER     = 240

local RATE_SAFETY         = 0.80
local SEND_BURST          = 6
local BROADCAST_BURST     = 3
local JITTER              = 0.15
local THROTTLE_WARN_GAP   = 12
local BCAST_WARN_AFTER    = 3
local POLL_STEP           = 0.2

local BCAST_FLOOR_RATE    = 0.07
local BCAST_CEIL_RATE     = 1.50
local RAMP_SECONDS        = 15

local ALLOW_BATCHING      = true

local POISON_DROP_AFTER   = 40

local REGISTRY_ENABLED    = true
local REGISTRY_MAP_NAME   = "MS_ServerRegistry_v1"
local REGISTER_INTERVAL   = 20
local REGISTER_TTL        = 75
local VALIDATE_CACHE_TTL  = 10

local localSubs           = {}
local realSubscriptions   = {}
local channelRefs         = {}
local inboxReady          = false
local legacyReady         = false
local initLock            = false
local shuttingDown        = false

local function newQueue()
	return { items = {}, head = 1, tail = 0 }
end

local function makeStream(name, isBroadcast)
	return {
		name             = name,
		isBroadcast      = isBroadcast,
		queue            = newQueue(),
		running          = false,
		throttleUntil    = 0,
		throttleFailures = 0,
		networkFailures  = 0,
		lastThrottleWarn = 0,
		lastThrottleAt   = -1e9,
	}
end

local direct = makeStream("targeted",  false)
local bcast  = makeStream("broadcast", true)
bcast.lastThrottleAt = os.clock()

local bcastSent      = {}
local bcastThrottled = {}

local function topBroadcastTopics(n)
	local rows = {}
	for topic, sent in pairs(bcastSent) do
		rows[#rows + 1] = { topic = topic, sent = sent, thr = bcastThrottled[topic] or 0 }
	end
	for topic, thr in pairs(bcastThrottled) do
		if not bcastSent[topic] then
			rows[#rows + 1] = { topic = topic, sent = 0, thr = thr }
		end
	end
	if #rows == 0 then return "(no broadcasts recorded yet)" end
	table.sort(rows, function(a, b) return a.sent > b.sent end)
	local parts = {}
	for i = 1, math.min(n, #rows) do
		local r = rows[i]
		parts[#parts + 1] = string.format("%s [sent=%d, throttled=%d]", r.topic, r.sent, r.thr)
	end
	return "Busiest broadcast topics — " .. table.concat(parts, ", ")
end

local function sendPerSecond()
	local players = #Players:GetPlayers()
	return (SEND_BASE + SEND_PER_PLAYER * players) * RATE_SAFETY / 60
end

local function currentBroadcastRate()
	local t = math.clamp((os.clock() - bcast.lastThrottleAt) / RAMP_SECONDS, 0, 1)
	return BCAST_FLOOR_RATE + (BCAST_CEIL_RATE - BCAST_FLOOR_RATE) * t
end

local function maxSubscriptions()
	return 20 + 8 * #Players:GetPlayers()
end

local function realSubscriptionCount()
	local n = 0
	for _ in pairs(realSubscriptions) do n += 1 end
	return n
end

local function encodedSize(value)
	local ok, json = pcall(HttpService.JSONEncode, HttpService, value)
	if ok then return #json end
	return math.huge
end

local function qSize(q) return q.tail - q.head + 1 end

local function qPush(q, entry)
	q.tail = q.tail + 1
	q.items[q.tail] = entry
end

local function qAdvance(q, n)
	local items = q.items
	for i = q.head, q.head + n - 1 do items[i] = nil end
	q.head = q.head + n
	if q.head > 64 and q.head > (q.tail - q.head) then
		local shift = q.head - 1
		for i = q.head, q.tail do
			items[i - shift] = items[i]
			items[i] = nil
		end
		q.head = 1
		q.tail = q.tail - shift
	end
end

local function qDropOldest(q)
	if q.head > q.tail then return end
	q.items[q.head] = nil
	q.head = q.head + 1
end

local function jittered(seconds)
	return seconds * (1 + (math.random() - 0.5) * 2 * JITTER)
end

local function channelFor(topic)
	local h = 0
	for i = 1, #topic do
		h = (h * 31 + string.byte(topic, i)) % 1048573
	end
	return BCAST_PREFIX .. (h % BCAST_CHANNELS)
end

local DEDUP_ENABLED       = true
local SEEN_TTL            = 90
local SEEN_MAX            = 4000

local seenIds             = {}
local seenCount           = 0

local ID_SALT             = string.sub((HttpService:GenerateGUID(false):gsub("-", "")), 1, 12)
local idCounter           = 0
local function newMessageId()
	idCounter += 1
	return ID_SALT .. ":" .. idCounter
end

local function markSeen(id)
	if not DEDUP_ENABLED or type(id) ~= "string" then return true end
	local now = os.clock()
	local exp = seenIds[id]
	if exp and exp > now then return false end
	if not exp then
		seenCount += 1
		if seenCount > SEEN_MAX then
			for k, e in pairs(seenIds) do
				if e <= now then seenIds[k] = nil; seenCount -= 1 end
			end
		end
	end
	seenIds[id] = now + SEEN_TTL
	return true
end

local sendBucket  = { tokens = SEND_BURST,      cap = SEND_BURST,      last = os.clock(), rate = sendPerSecond }
local bcastBucket = { tokens = BROADCAST_BURST, cap = BROADCAST_BURST, last = os.clock(), rate = currentBroadcastRate }

local function refill(bucket)
	local now = os.clock()
	bucket.tokens = math.min(bucket.cap, bucket.tokens + (now - bucket.last) * bucket.rate())
	bucket.last   = now
end

local function acquire(isBroadcast)
	if shuttingDown then return end
	while true do
		refill(sendBucket)
		if isBroadcast then refill(bcastBucket) end

		local okSend  = sendBucket.tokens >= 1
		local okBcast = (not isBroadcast) or bcastBucket.tokens >= 1

		if okSend and okBcast then
			sendBucket.tokens -= 1
			if isBroadcast then bcastBucket.tokens -= 1 end
			return
		end

		local waitSec = 0.03
		if not okSend then
			waitSec = math.max(waitSec, (1 - sendBucket.tokens) / math.max(sendBucket.rate(), 1e-3))
		end
		if isBroadcast and not okBcast then
			waitSec = math.max(waitSec, (1 - bcastBucket.tokens) / math.max(bcastBucket.rate(), 1e-3))
		end
		task.wait(math.min(waitSec, POLL_STEP))
	end
end

local function dispatch(topic, payload)
	local subs = localSubs[topic]
	if not subs then return end
	local n        = #subs
	local snapshot = table.create(n)
	table.move(subs, 1, n, 1, snapshot)
	for i = 1, n do task.spawn(snapshot[i], payload) end
end

local function dispatchItem(item)
	if type(item) ~= "table" then return end
	if type(item.Topic) ~= "string" then return end
	if not markSeen(item.Id) then return end
	dispatch(item.Topic, item.Payload)
end

local function onMessage(message)
	local data = message.Data
	if type(data) ~= "table" then return end
	if data.Batch then
		local batch = data.Batch
		if type(batch) ~= "table" then return end
		for i = 1, #batch do dispatchItem(batch[i]) end
	else
		dispatchItem(data)
	end
end

local function isThrottled(stream)
	return os.clock() < stream.throttleUntil
end

local function onPublishSuccess(stream)
	stream.networkFailures  = 0
	stream.throttleFailures = 0
end

local liveServerEstimate

local function onPublishThrottled(stream, hintSeconds, topic, realTopic, err)
	stream.throttleFailures += 1
	if err   then stream.lastErr      = tostring(err) end
	if topic then stream.lastErrTopic = topic end

	if stream.isBroadcast then
		bcast.lastThrottleAt = os.clock()
		bcastBucket.tokens   = 0
	else
		sendBucket.tokens = 0
		local backoff = math.min(MAX_BACKOFF, BASE_BACKOFF * (2 ^ math.min(stream.throttleFailures - 1, 5)))
		local delay   = hintSeconds and math.min(hintSeconds, MAX_BACKOFF) or backoff
		stream.throttleUntil = os.clock() + jittered(delay)
	end

	local now = os.clock()
	if stream.throttleFailures >= BCAST_WARN_AFTER and now - stream.lastThrottleWarn >= THROTTLE_WARN_GAP then
		stream.lastThrottleWarn = now
		warn(string.format(
			"[MessagingService] %s throttled (%d in a row) — stuck on topic '%s' (real channel '%s'); queue=%d; servers≳%d (LOWER BOUND — not the true count); last error: %s%s",
			stream.name, stream.throttleFailures,
			tostring(topic or stream.lastErrTopic or "?"),
			tostring(realTopic or "?"),
			qSize(stream.queue),
			(liveServerEstimate and liveServerEstimate()) or 1,
			tostring(stream.lastErr or err or "n/a"),
			stream.isBroadcast and ("  " .. topBroadcastTopics(3)) or ""
			))
	end
end

local function isSizeError(err)
	local s = string.lower(tostring(err))
	return string.find(s, "size", 1, true) ~= nil
		and ((string.find(s, "exceed", 1, true)
		or    string.find(s, "limit",  1, true)
		or    string.find(s, "large",  1, true)
		or    string.find(s, "1024",   1, true)) ~= nil)
end

local function isThrottleError(err)
	local s = string.lower(tostring(err))
	return (string.find(s, "exceed",   1, true)
		or  string.find(s, "too many", 1, true)
		or  string.find(s, "limit",    1, true)
		or  string.find(s, "throttl",  1, true)
		or  string.find(s, "retry",    1, true)) ~= nil
end

local function parseRetryAfter(err)
	local s = tostring(err)
	local n = string.match(s, "retry%s+after%s+(%d+%.?%d*)")
		or  string.match(s, "retry%s+in%s+(%d+%.?%d*)")
	return n and tonumber(n) or nil
end

local registryMap         = nil
local validateCache       = {}
local localKnown          = {}
local registryStarted     = false

local function getRegistry()
	if not REGISTRY_ENABLED then return nil end
	if registryMap == nil then
		local ok, map = pcall(function() return MemoryStoreService:GetHashMap(REGISTRY_MAP_NAME) end)
		registryMap = ok and map or false
	end
	return registryMap or nil
end

local function registerSelf()
	if game.JobId == "" then return end
	local map = getRegistry()
	if not map then return end
	pcall(function() map:SetAsync(game.JobId, os.time(), REGISTER_TTL) end)
end

local function pruneCaches()
	local now = os.clock()
	for id, exp in pairs(seenIds) do if exp < now then seenIds[id] = nil; seenCount -= 1 end end
	for jid, e   in pairs(validateCache) do if e.exp  < now then validateCache[jid] = nil end end
	for jid, exp in pairs(localKnown)     do if exp    < now then localKnown[jid]     = nil end end
end

local function startRegistry()
	if registryStarted then return end
	registryStarted = true
	task.spawn(function()
		registerSelf()
		while not shuttingDown do
			task.wait(REGISTER_INTERVAL)
			registerSelf()
			pruneCaches()
		end
	end)
end

local function isKnownJobId(jobid)
	if jobid == game.JobId then return true end
	if game.JobId == "" then return true end

	local now = os.clock()
	local lk  = localKnown[jobid];     if lk and lk > now      then return true end
	local c   = validateCache[jobid];  if c  and c.exp > now   then return c.alive end

	local map = getRegistry()
	if not map then
		return true
	end

	local ok, val = pcall(function() return map:GetAsync(jobid) end)
	if not ok then return true end
	local alive = (val ~= nil)
	validateCache[jobid] = { alive = alive, exp = now + VALIDATE_CACHE_TTL }
	if alive then localKnown[jobid] = now + VALIDATE_CACHE_TTL end
	return alive
end

function liveServerEstimate()
	local n, now = 1, os.clock()
	for _, exp in pairs(localKnown) do if exp > now then n += 1 end end
	return n
end

local function subscribeReal(msTopic)
	if realSubscriptions[msTopic] then return true end
	if realSubscriptionCount() >= maxSubscriptions() then
		warn(string.format(
			"[MessagingService] subscription cap (%d) reached; cannot subscribe '%s'. "
				.. "This server listens to too many distinct topics.",
			maxSubscriptions(), msTopic))
		return false
	end
	for attempt = 1, SUBSCRIBE_RETRIES do
		local ok, conn = pcall(function() return MS:SubscribeAsync(msTopic, onMessage) end)
		if ok then
			realSubscriptions[msTopic] = conn
			return true
		end
		warn(string.format(
			"[MessagingService] SubscribeAsync('%s') attempt %d failed: %s",
			msTopic, attempt, tostring(conn)))
		task.wait(math.min(MAX_BACKOFF, BASE_BACKOFF * (2 ^ (attempt - 1))))
	end
	return false
end

local function ensureInit()
	if inboxReady and (legacyReady or not LEGACY_COMPAT) then
		startRegistry()
		return
	end
	while initLock do task.wait() end
	if inboxReady and (legacyReady or not LEGACY_COMPAT) then return end
	initLock = true

	if not inboxReady then
		if game.JobId == "" then
			inboxReady = true
		elseif subscribeReal(SERVER_TOPIC_PREFIX .. game.JobId) then
			inboxReady = true
		end
	end
	if LEGACY_COMPAT and not legacyReady then
		if subscribeReal(LEGACY_MAIN_TOPIC) then legacyReady = true end
	end

	initLock = false
	startRegistry()
end

local function buildBatch(q)
	if qSize(q) == 0 then return nil, 0 end

	local head    = q.items[q.head]
	local msTopic = head.msTopic

	local items          = {}
	local estimatedBytes = 15
	local i              = q.head
	while i <= q.tail do
		local entry = q.items[i]
		if entry.msTopic ~= msTopic then break end
		local add = entry.size + 1
		if #items > 0 and estimatedBytes + add > MAX_MESSAGE_BYTES then break end
		estimatedBytes = estimatedBytes + add
		items[#items + 1] = entry.packet
		i = i + 1
		if not ALLOW_BATCHING then break end
	end

	local n = #items
	if n == 0 then return nil, 0 end
	local packet
	if n == 1 then packet = items[1] else packet = { Batch = items } end
	return packet, n, msTopic
end

local function runProcessor(stream)
	if stream.running then return end
	stream.running = true
	local q = stream.queue

	task.spawn(function()
		while not shuttingDown do
			while isThrottled(stream) and not shuttingDown do
				local remaining = stream.throttleUntil - os.clock()
				task.wait(math.min(remaining, POLL_STEP))
			end
			if shuttingDown then break end

			if qSize(q) == 0 then break end

			acquire(stream.isBroadcast)
			if shuttingDown then break end

			if qSize(q) == 0 then break end

			local packet, consumed, msTopic = buildBatch(q)
			if not packet then break end

			local headTopic = (type(packet) == "table" and packet.Batch
				and packet.Batch[1] and packet.Batch[1].Topic) or packet.Topic or "?"
			local headId = (type(packet) == "table" and packet.Batch
				and packet.Batch[1] and packet.Batch[1].Id) or packet.Id

			local ok, err = pcall(function()
				MS:PublishAsync(msTopic, packet)
			end)

			if ok then
				qAdvance(q, consumed)
				onPublishSuccess(stream)
				if stream.isBroadcast then
					bcastSent[headTopic] = (bcastSent[headTopic] or 0) + 1
				end
				stream.lastFailId    = nil
				stream.sameFailCount = 0

			elseif isSizeError(err) then
				warn(string.format(
					"[MessagingService] DROPPED oversized %s message — topic '%s' (real channel '%s'): %s",
					stream.name, tostring(headTopic), tostring(msTopic), tostring(err)))
				qAdvance(q, consumed)
				stream.lastFailId    = nil
				stream.sameFailCount = 0

			elseif isThrottleError(err) then
				if stream.isBroadcast then
					bcastThrottled[headTopic] = (bcastThrottled[headTopic] or 0) + 1
				end
				if headId and stream.lastFailId == headId then
					stream.sameFailCount = (stream.sameFailCount or 0) + 1
				else
					stream.lastFailId    = headId
					stream.sameFailCount = 1
				end

				local hint = parseRetryAfter(err)
				onPublishThrottled(stream, hint, headTopic, msTopic, err)

				if stream.sameFailCount >= POISON_DROP_AFTER then
					warn(string.format(
						"[MessagingService] DROPPING stuck %s message — topic '%s' (real channel '%s') after %d throttled retries; draining queue so other topics can send. Last error: %s",
						stream.name, tostring(headTopic), tostring(msTopic),
						stream.sameFailCount, tostring(err)))
					qAdvance(q, consumed)
					stream.lastFailId    = nil
					stream.sameFailCount = 0
				end

			else
				stream.networkFailures += 1
				local delay = math.min(MAX_BACKOFF,
					BASE_BACKOFF * (2 ^ math.min(stream.networkFailures - 1, 5)))
				warn(string.format(
					"[MessagingService] %s publish failed — topic '%s' (real channel '%s') (%d): %s — retry in %.1fs",
					stream.name, tostring(headTopic), tostring(msTopic),
					stream.networkFailures, tostring(err), delay))
				task.wait(jittered(delay))
			end
		end

		stream.running = false

		if qSize(q) > 0 and not shuttingDown then
			runProcessor(stream)
		end
	end)
end

function MessagingService:SubscribeAsync(topic, callback)
	assert(type(topic)    == "string",   "topic must be a string")
	assert(type(callback) == "function", "callback must be a function")

	ensureInit()

	local subs       = localSubs[topic]
	local isNewTopic = (subs == nil)
	if not subs then subs = {}; localSubs[topic] = subs end
	table.insert(subs, callback)

	local ch = channelFor(topic)
	if isNewTopic then
		channelRefs[ch] = (channelRefs[ch] or 0) + 1
		subscribeReal(ch)
	end

	local connection = {}
	function connection:Disconnect()
		local list = localSubs[topic]
		if not list then return end
		for i = #list, 1, -1 do
			if list[i] == callback then table.remove(list, i); break end
		end
		if #list == 0 then
			localSubs[topic] = nil
			local n = (channelRefs[ch] or 1) - 1
			channelRefs[ch] = n > 0 and n or nil
			if not channelRefs[ch] then
				local conn = realSubscriptions[ch]
				if conn then
					pcall(function() conn:Disconnect() end)
					realSubscriptions[ch] = nil
				end
			end
		end
	end
	connection.disconnect = connection.Disconnect
	return connection
end

function MessagingService:PublishAsync(topic, payload, jobid)
	assert(type(topic) == "string", "topic must be a string")
	if shuttingDown then return false end

	ensureInit()

	local msTopic, isBroadcast

	if jobid ~= nil then
		if type(jobid) ~= "string" or jobid == "" then
			warn("[MessagingService] jobid must be a non-empty string; dropping publish")
			return false
		end
		if jobid == game.JobId then
			dispatch(topic, payload)
			return true
		end
		if not isKnownJobId(jobid) then
			warn(string.format("[MessagingService] unknown jobid '%s'; dropping publish", jobid))
			return false
		end
		msTopic     = SERVER_TOPIC_PREFIX .. jobid
		isBroadcast = false
	else
		msTopic     = channelFor(topic)
		isBroadcast = true
	end

	local packet = { Topic = topic, Payload = payload, Id = newMessageId() }

	local size = encodedSize(packet)
	if size > MAX_MESSAGE_BYTES then
		warn(string.format(
			"[MessagingService] Message for '%s' is %d bytes (>%d). Dropping.",
			topic, size, MAX_MESSAGE_BYTES))
		return false
	end

	local stream = isBroadcast and bcast or direct
	local q      = stream.queue

	if qSize(q) >= MAX_QUEUE_SIZE then
		qDropOldest(q)
		warn(string.format("[MessagingService] %s queue at cap; dropping oldest", stream.name))
	end

	qPush(q, { packet = packet, size = size, msTopic = msTopic })
	runProcessor(stream)
	return true
end

function MessagingService:IsKnownJobId(jobid)  return isKnownJobId(jobid) end

function MessagingService:GetKnownJobIds()
	local list, now = {}, os.clock()
	if game.JobId ~= "" then list[#list + 1] = game.JobId end
	for jid, exp in pairs(localKnown) do
		if exp > now then list[#list + 1] = jid end
	end
	return list
end

function MessagingService:AddKnownJobId(jobid, ttl)
	if type(jobid) ~= "string" or jobid == "" then return end
	if jobid == game.JobId then return end
	localKnown[jobid] = os.clock() + (tonumber(ttl) or REGISTER_TTL)
end

function MessagingService:GetQueueSize()
	return qSize(direct.queue) + qSize(bcast.queue)
end

function MessagingService:GetRateInfo()
	return {
		TargetedQueue          = qSize(direct.queue),
		BroadcastQueue         = qSize(bcast.queue),
		ServerCount            = liveServerEstimate(),
		Subscriptions          = realSubscriptionCount(),
		MaxSubscriptions       = maxSubscriptions(),
		BroadcastChannels      = BCAST_CHANNELS,
		SendPerMin             = math.floor(sendPerSecond() * 60 + 0.5),
		BroadcastPerMin        = math.floor(currentBroadcastRate() * 60 + 0.5),
		SendTokens             = math.floor(sendBucket.tokens * 100) / 100,
		BroadcastTokens        = math.floor(bcastBucket.tokens * 100) / 100,
		TargetedThrottles      = direct.throttleFailures,
		BroadcastThrottles     = bcast.throttleFailures,
		RegistryActive         = (getRegistry() ~= nil),
		TopBroadcastTopics     = topBroadcastTopics(5),
	}
end

function MessagingService:GetBroadcastTopicStats()
	local out = {}
	for topic, sent in pairs(bcastSent) do
		out[topic] = { Sent = sent, Throttled = bcastThrottled[topic] or 0 }
	end	
	for topic, thr in pairs(bcastThrottled) do
		if not out[topic] then out[topic] = { Sent = 0, Throttled = thr } end
	end
	return out
end

local debugRunning = true
function MessagingService:SetDebug(enabled, intervalSeconds)
	if enabled == false then debugRunning = false; return end
	if debugRunning then return end
	debugRunning = true
	intervalSeconds = tonumber(intervalSeconds) or 5
	task.spawn(function()
		while debugRunning and not shuttingDown do
			local i = self:GetRateInfo()
			print(string.format(
				"[MessagingService] q(direct=%d, bcast=%d) | bcast≈%d/min | subs=%d/%d | chans=%d | "
					.. "tokens(send=%.1f, bcast=%.1f) | throttles(d=%d, b=%d) | registry=%s",
				i.TargetedQueue, i.BroadcastQueue, i.BroadcastPerMin,
				i.Subscriptions, i.MaxSubscriptions, i.BroadcastChannels,
				i.SendTokens, i.BroadcastTokens,
				i.TargetedThrottles, i.BroadcastThrottles,
				tostring(i.RegistryActive)))
			print("[MessagingService] " .. topBroadcastTopics(6))
			task.wait(intervalSeconds)
		end
	end)
end

function MessagingService:Start()
	task.spawn(function()
		ensureInit()
	end)
end

game:BindToClose(function()
	shuttingDown = true
	pcall(function()
		local map = getRegistry()
		if map and game.JobId ~= "" then map:RemoveAsync(game.JobId) end
	end)
	local deadline = os.clock() + SHUTDOWN_BUDGET
	while (qSize(direct.queue) > 0 or qSize(bcast.queue) > 0
		or direct.running or bcast.running) and os.clock() < deadline do
		runProcessor(direct)
		runProcessor(bcast)
		task.wait(0.1)
	end
end)

return MessagingService
