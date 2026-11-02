--credit to prince games studio
local BehaviorBase = {}

BehaviorBase.__index = BehaviorBase
BehaviorBase.Name = "BehaviorBase"
function BehaviorBase.New(p1, p2) --[[ New | Line: 9 ]]
	local v1 = setmetatable({}, p1)

	v1.Player = p2.Player
	v1.PetId = p2.PetId
	v1.Slot = p2.Slot
	v1.Species = p2.Species
	v1.Module = p2.Module
	v1.Config = p2.Config or {}
	v1.Control = p2.Control
	v1.State = nil
	v1.StateEnteredAt = 0
	v1.StartedAt = 0
	v1.Done = false
	v1.StopReason = nil
	v1.States = v1.States or {}

	return v1
end
function BehaviorBase.CanStart(p1) --[[ CanStart | Line: 37 ]]
	return true
end
function BehaviorBase.GetInitialState(p1) --[[ GetInitialState | Line: 42 ]]
	return nil
end
function BehaviorBase.Start(p1) --[[ Start | Line: 47 ]]
	p1.StartedAt = os.clock()
	p1.Done = false
	p1.StopReason = nil

	if p1.Slot then
		p1.Slot:SetAttribute("PetClaim", p1.Name)
	end

	local v1 = p1:GetInitialState()

	if not v1 then
		return
	end

	p1:TransitionTo(v1)
end
function BehaviorBase.Update(p1, p2, p3) --[[ Update | Line: 65 ]]
	if p1.Done then
		return
	end

	if p1.Slot and p1.Slot.Parent then
		if p1.Player and p1.Player.Parent then
			local v1 = p1.State and p1.States[p1.State]

			if not (v1 and v1.Update) then
				return
			end

			v1.Update(p1, p2, p3)
		else
			p1:Stop("PlayerLeft")
		end
	else
		p1:Stop("SlotGone")
	end
end
function BehaviorBase.TransitionTo(p1, p2) --[[ TransitionTo | Line: 87 ]]
	local v1 = p1.State and p1.States[p1.State]

	if v1 and v1.Exit then
		v1.Exit(p1)
	end

	p1.State = p2
	p1.StateEnteredAt = os.clock()

	local v2 = p1.States[p2]

	if not (v2 and v2.Enter) then
		return
	end

	v2.Enter(p1)
end
function BehaviorBase.TimeInState(p1) --[[ TimeInState | Line: 103 ]]
	return os.clock() - p1.StateEnteredAt
end
function BehaviorBase.Stop(p1, p2) --[[ Stop | Line: 108 ]]
	if p1.Done then
		return
	end

	p1.Done = true
	p1.StopReason = p2 or "Unknown"

	local v1 = p1.State and p1.States[p1.State]

	if v1 and v1.Exit then
		v1.Exit(p1)
	end

	if p1.OnStop then
		p1:OnStop(p1.StopReason)
	end

	if p1.Control and p1.Control.ClearGoal then
		p1.Control:ClearGoal()
	end

	if not (p1.Slot and p1.Slot.Parent) then
		return
	end

	p1.Slot:SetAttribute("PetClaim", nil)
end
function BehaviorBase.OnEvent(p1, p2, p3) --[[ OnEvent | Line: 136 ]]
	local v1 = p1.State and p1.States[p1.State]

	if not (v1 and v1.OnEvent) then
		return
	end

	v1.OnEvent(p1, p2, p3)
end
function BehaviorBase.IsDone(p1) --[[ IsDone | Line: 147 ]]
	return p1.Done
end

return BehaviorBase