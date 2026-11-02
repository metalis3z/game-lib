-- Where the original server kept its CollisionsService. The shared Finisher module requires it here
-- at require time on the server (Finishers.Ragdoll -> Finisher:_AnchorModel calls
-- ClearSetDescendantsLogic; Finishers.Bubble Ball calls SetDescendants), so without it no finisher
-- -- the dummies' death ragdoll included -- can run on the server.
--
--   :SetDescendants(root, group)          every BasePart under root, and any added later, -> group
--   :ClearSetDescendantsLogic(part, deep) stop keeping part (and, if deep, what's under it) in a group

local CollisionsService = {}

-- [root] = { group = string, connection = RBXScriptConnection }
local watched: { [Instance]: any } = {}

local function setGroup(part: Instance, group: string)
	if part:IsA("BasePart") then
		pcall(function()
			part.CollisionGroup = group
		end)
	end
end

function CollisionsService.SetDescendants(_self, root: Instance, group: string)
	CollisionsService.ClearSetDescendantsLogic(_self, root, false)
	setGroup(root, group)
	for _, descendant in root:GetDescendants() do
		setGroup(descendant, group)
	end
	watched[root] = {
		group = group,
		connection = root.DescendantAdded:Connect(function(descendant)
			setGroup(descendant, group)
		end),
	}
end

function CollisionsService.ClearSetDescendantsLogic(_self, root: Instance, deep: boolean?)
	local entry = watched[root]
	if entry then
		entry.connection:Disconnect()
		watched[root] = nil
	end
	if deep then
		for watchedRoot, other in watched do
			if watchedRoot:IsDescendantOf(root) then
				other.connection:Disconnect()
				watched[watchedRoot] = nil
			end
		end
	end
end

function CollisionsService.SetCollisionGroup(_self, part: Instance, group: string)
	setGroup(part, group)
end

return CollisionsService
