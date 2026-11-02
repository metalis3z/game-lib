-- DialogueTree (pattern module, written for this library)
-- What it does: server-authoritative, data-driven NPC conversations. Each NPC has a tree of nodes;
-- a node has text and choices; a choice can jump to another node, end the talk, require a
-- condition (quest done, enough coins...) and run a server action (give item, start quest...).
-- The server keeps who is talking to which NPC and on which node, so a client can only pick a
-- choice that is actually on screen, and only while standing near the NPC.
--
-- Credit / ideas taken from:
--   steal-a-brainrot        DialogModule  ({text, responses} entries, response.next jumps, exit quips,
--                                         close when the player walks away)
--   work-at-a-pizza-place   NPCDialog     (server sends choices, client sends back the picked one,
--                                         one player per NPC, 30-stud conversation distance)
--
-- Usage (server Script):
--   local DialogueTree = require(path.to.DialogueTree)
--   local talk = DialogueTree.new(ReplicatedStorage.Remotes.Dialogue) -- a RemoteEvent
--   talk:Register(workspace.NPCs.Baker, {
--       start = "hello",
--       nodes = {
--           hello = { text = "Fresh bread! Want some?", choices = {
--               { text = "Yes please (5 coins)", next = "thanks",
--                 condition = function(player) return player.leaderstats.Coins.Value >= 5 end,
--                 action = function(player) player.leaderstats.Coins.Value -= 5 end },
--               { text = "Who are you?", next = "about" },
--               { text = "Bye", exitText = "See you!" },
--           }},
--           about = { text = "I've baked here for 40 years.", choices = { { text = "Back", next = "hello" } } },
--           thanks = { text = "Enjoy!" }, -- no choices = conversation ends after this line
--       },
--   })
--   -- Add a ProximityPrompt to the NPC and call talk:Start(player, npc) from Triggered.
--
-- Client side (LocalScript), very small:
--   remote.OnClientEvent:Connect(function(kind, npc, payload)
--       if kind == "Node" then  -- payload = { text = "...", choices = { "Yes please", "Bye" } }
--           -- show payload.text with a typewriter, make one button per choice;
--           -- on click: remote:FireServer("Choose", npc, choiceIndex)
--       elseif kind == "End" then -- payload = optional goodbye text
--           -- hide the UI
--       end
--   end)

local Players = game:GetService("Players")

local DialogueTree = {}
DialogueTree.__index = DialogueTree

export type Choice = {
	text: string,
	next: string?,                         -- node id to go to; nil = end conversation
	exitText: string?,                     -- goodbye line shown when this choice ends the talk
	condition: ((Player) -> boolean)?,     -- hide the choice unless this returns true
	action: ((Player, Instance) -> ())?,   -- runs on the server when the choice is picked
}
export type Node = { text: string | ((Player) -> string), choices: { Choice }? }
export type Tree = { start: string, nodes: { [string]: Node } }

function DialogueTree.new(remote: RemoteEvent, opts: { MaxDistance: number?, OnePlayerPerNpc: boolean? }?)
	local self = setmetatable({}, DialogueTree)
	self.Remote = remote
	self.MaxDistance = (opts and opts.MaxDistance) or 15
	self.OnePlayerPerNpc = if opts and opts.OnePlayerPerNpc ~= nil then opts.OnePlayerPerNpc else false
	self.Trees = {} :: { [Instance]: Tree }
	-- sessions[player] = { npc = Instance, node = string, visible = { [number]: Choice } }
	self.Sessions = {} :: { [Player]: any }

	remote.OnServerEvent:Connect(function(player, kind, npc, index)
		if kind == "Choose" then
			self:_choose(player, npc, index)
		elseif kind == "Leave" then
			self:End(player)
		end
	end)
	Players.PlayerRemoving:Connect(function(player)
		self.Sessions[player] = nil
	end)

	-- Close conversations of players who walked away.
	task.spawn(function()
		while true do
			task.wait(0.5)
			for player, session in pairs(self.Sessions) do
				if not self:_near(player, session.npc) then
					self:End(player, "")
				end
			end
		end
	end)
	return self
end

function DialogueTree:Register(npc: Instance, tree: Tree)
	assert(tree.nodes[tree.start], "DialogueTree: start node missing")
	self.Trees[npc] = tree
end

local function npcPosition(npc: Instance): Vector3?
	if npc:IsA("Model") then
		return npc:GetPivot().Position
	elseif npc:IsA("BasePart") then
		return npc.Position
	end
	return nil
end

function DialogueTree:_near(player: Player, npc: Instance): boolean
	local pos = npcPosition(npc)
	local character = player.Character
	local hrp = character and character:FindFirstChild("HumanoidRootPart") :: BasePart?
	return pos ~= nil and hrp ~= nil and (hrp.Position - pos).Magnitude <= self.MaxDistance
end

function DialogueTree:_busy(npc: Instance, except: Player): boolean
	for player, session in pairs(self.Sessions) do
		if player ~= except and session.npc == npc then
			return true
		end
	end
	return false
end

-- Send a node to the player, keeping only the choices whose condition passes.
function DialogueTree:_show(player: Player, npc: Instance, nodeId: string)
	local tree = self.Trees[npc]
	local node = tree and tree.nodes[nodeId]
	if not node then
		warn("[DialogueTree] missing node", nodeId)
		self:End(player)
		return
	end
	local text = if type(node.text) == "function" then node.text(player) else node.text
	local visible, labels = {}, {}
	for _, choice in ipairs(node.choices or {}) do
		local ok = choice.condition == nil or choice.condition(player)
		if ok then
			table.insert(visible, choice)
			table.insert(labels, choice.text)
		end
	end
	self.Sessions[player] = { npc = npc, node = nodeId, visible = visible }
	self.Remote:FireClient(player, "Node", npc, { text = text, choices = labels })
	if #visible == 0 then
		-- Last line: let the client read it, then close.
		task.delay(math.clamp(#text * 0.05, 1.5, 6), function()
			local s = self.Sessions[player]
			if s and s.npc == npc and s.node == nodeId then
				self:End(player)
			end
		end)
	end
end

function DialogueTree:Start(player: Player, npc: Instance): boolean
	local tree = self.Trees[npc]
	if not tree or not self:_near(player, npc) then
		return false
	end
	if self.OnePlayerPerNpc and self:_busy(npc, player) then
		self.Remote:FireClient(player, "End", npc, "I'm talking to someone else right now.")
		return false
	end
	self:_show(player, npc, tree.start)
	return true
end

function DialogueTree:_choose(player: Player, npc: any, index: any)
	-- Validate everything the client sent: right NPC, a number, a choice that is on screen.
	local session = self.Sessions[player]
	if not session or session.npc ~= npc or type(index) ~= "number" then
		return
	end
	local choice: Choice? = session.visible[index]
	if not choice or not self:_near(player, npc) then
		return
	end
	-- Re-check the condition: state may have changed since the node was shown.
	if choice.condition and not choice.condition(player) then
		self:_show(player, npc, session.node)
		return
	end
	if choice.action then
		local ok, err = pcall(choice.action, player, npc)
		if not ok then
			warn("[DialogueTree] action error:", err)
		end
	end
	if choice.next then
		self:_show(player, npc, choice.next)
	else
		self:End(player, choice.exitText)
	end
end

function DialogueTree:End(player: Player, goodbye: string?)
	local session = self.Sessions[player]
	if not session then
		return
	end
	self.Sessions[player] = nil
	if player.Parent then
		self.Remote:FireClient(player, "End", session.npc, goodbye)
	end
end

return DialogueTree
