--[[ QuestController — Client-side quest progress notification
     Watches data.mapQuests via ReplicaService and shows toast notifications
     when individual quests complete, and "go to wall" hint when all are done.

     Rewritten from decompiled Konstant V2.1 output for readability.
     No logic changes — only variable names cleaned up.

     Original decompiler artifacts in the source:
     - Obfuscated upvalue names (var4_upvw, var5_upvw, etc.)
     - Unused require of Shared.Util (var43_upvw) — removed
     - Backtick interpolated strings were valid Luau, kept as-is logic-wise
]]

local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)

local QuestController = Knit.CreateController({
	Name = "QuestController",
	_completed = {},   -- tracks which quest notifications have already fired this session
	_mapsOnJoin = {},  -- snapshot of data.maps at join time (to suppress stale notifications)
})

local DataController
local SoundController
local UIController
local MapController
local Maps

------------------------------------------------------------------------
-- hasMapQuestBeenCompleted(silent)
-- Checks current quest progress against the next target map.
-- If a quest just completed and hasn't been notified yet, shows a toast.
-- silent=true: marks as completed without showing any notification (used on startup
--              to suppress notifications for quests already done before this session).
------------------------------------------------------------------------
function QuestController:hasMapQuestBeenCompleted(silent)
	local data = DataController.data
	if not data then return end

	-- Determine which map the player is working toward (next unlocked)
	local nextMapId = #data.maps + 1
	local mapDef = Maps[nextMapId]
	if not mapDef or not mapDef.quests then return end

	-- Gate: only show notifications if the player had the previous map on join
	-- OR has physically visited it. Prevents stale startup notifications.
	local hadPreviousOnJoin = self._mapsOnJoin[nextMapId - 1]
	if not hadPreviousOnJoin then
		hadPreviousOnJoin = MapController:hasVisitedMap(nextMapId - 1)
		if not hadPreviousOnJoin then return end
	end

	-- Count how many quests are complete
	local completedCount = 0
	for i, quest in mapDef.quests do
		if (data.mapQuests[i] or 0) >= quest.amount then
			completedCount += 1
		end
	end

	-- Fire notifications for newly completed quests
	for i, quest in mapDef.quests do
		if data.mapQuests[i] and data.mapQuests[i] >= quest.amount then
			local key = "map" .. nextMapId .. i
			if not self._completed[key] then
				if not silent then
					task.spawn(function()
						-- Wait until no other frame is open before showing toast
						repeat task.wait() until not UIController:isFrameOpen()
						UIController:createNotification(
							"Custom",
							string.format(
								'<font color="#%s"><stroke color="#000000" thickness="3">%s </stroke></font>'
								.. '<font color="#ffffff"><stroke color="#000000" thickness="3">quest has been completed! </stroke></font>'
								.. '<font color="#%s"><stroke color="#000000" thickness="3">(%d/%d)</stroke></font>',
								mapDef.color:ToHex(), mapDef.name,
								mapDef.color:ToHex(), completedCount, #mapDef.quests
							),
							5
						)
						SoundController:play("Quest Completed")
						if #mapDef.quests <= completedCount then
							task.delay(2, function()
								UIController:createNotification(
									"Custom",
									'<font color="#ffffff"><stroke color="#000000" thickness="3">Go to the wall to unlock the next map!</stroke></font>',
									4
								)
							end)
						end
					end)
				end
				self._completed[key] = true
			end
		end
	end
end

------------------------------------------------------------------------
-- setMapsOnJoin: snapshot of data.maps taken at startup
-- Used to gate "first completed quest" notifications for maps the player
-- already had when they joined (so we don't spam stale toasts on login).
------------------------------------------------------------------------
function QuestController:setMapsOnJoin()
	self._mapsOnJoin = DataController:getData().maps
end

------------------------------------------------------------------------
-- onSet: subscribe to replica changes for mapQuests
------------------------------------------------------------------------
function QuestController:onSet()
	DataController.replica:OnSet({"mapQuests"}, function()
		self:hasMapQuestBeenCompleted()
	end)
end

------------------------------------------------------------------------
-- Lifecycle
------------------------------------------------------------------------
function QuestController:KnitStart()
	task.spawn(function()
		DataController:waitForData()
		self:onSet()
		self:setMapsOnJoin()
		self:hasMapQuestBeenCompleted(true) -- silent pass: mark existing completions without notifying
	end)
end

function QuestController:KnitInit()
	DataController   = Knit.GetController("DataController")
	SoundController  = Knit.GetController("SoundController")
	UIController     = Knit.GetController("UIController")
	MapController    = Knit.GetController("MapController")
	Maps             = require(game:GetService("ReplicatedStorage").Shared.List.Maps)
end

return QuestController
