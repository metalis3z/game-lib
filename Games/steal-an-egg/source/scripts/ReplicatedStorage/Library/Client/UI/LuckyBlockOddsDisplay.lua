-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local OddsBillboard = require(ReplicatedStorage.Library.Client.UI.OddsBillboard)
local t = {}

t.__index = t

local function isStateUsable(p1) --[[ isStateUsable | Line: 53 ]]
	if not p1 then
		return false
	end

	local parent = p1.parent

	if parent and parent.Parent then
		local dropTable = p1.dropTable

		return dropTable and #dropTable ~= 0 and true or false
	end

	return false
end

function t.new(p1) --[[ new | Line: 71 | Upvalues: t (copy) ]]
	local t2 = {
		_state = nil,
		_handle = nil,
		_visible = false,
		_destroyed = false
	}

	t2._defaultThreshold = if p1 then if typeof(p1.defaultThreshold) == "number" then p1.defaultThreshold else 30 else 30
	t2._defaultMaxDistance = if p1 then if typeof(p1.defaultMaxDistance) == "number" then p1.defaultMaxDistance else 75 else 75
	t2._defaultStudsOffset = if p1 then if typeof(p1.defaultStudsOffset) == "Vector3" then p1.defaultStudsOffset else Vector3.new(0, 0, 0) else Vector3.new(0, 0, 0)

	return setmetatable(t2, t)
end
function t.GetBillboard(p1) --[[ GetBillboard | Line: 89 ]]
	local _handle = p1._handle

	if _handle then
		return _handle:GetBillboard()
	end

	return nil
end
function t.SetVisible(p1, p2) --[[ SetVisible | Line: 98 ]]
	if p1._destroyed then
		return
	end

	if p1._visible == p2 then
		return
	end

	p1._visible = p2

	local _handle = p1._handle

	if not _handle then
		return
	end

	local v1

	if p2 then
		local _state = p1._state

		if _state then
			local parent = _state.parent

			if parent and parent.Parent then
				local dropTable = _state.dropTable

				v1 = if dropTable and #dropTable ~= 0 then true else false
			else
				v1 = false
			end
		else
			v1 = false
		end
	else
		v1 = p2
	end

	_handle:SetVisible(v1)
end
function t.Update(p1, p2) --[[ Update | Line: 115 | Upvalues: OddsBillboard (copy) ]]
	if p1._destroyed then
		return
	end

	p1._state = p2

	local _handle = p1._handle
	local v1

	if p2 then
		local parent = p2.parent

		if parent and parent.Parent then
			local dropTable = p2.dropTable

			v1 = if dropTable and #dropTable ~= 0 then true else false
		else
			v1 = false
		end
	else
		v1 = false
	end

	if v1 then
		if not _handle then
			local v2 = OddsBillboard.new()

			p1._handle = v2
			_handle = v2
		end

		assert(_handle, "luau")

		local t = {
			parent = p2.parent,
			dropTable = p2.dropTable,
			title = p2.title,
			scale = p2.scale
		}

		t.studsOffsetWorldSpace = p2.studsOffsetWorldSpace or p1._defaultStudsOffset
		t.maxDistance = p2.maxDistance or p1._defaultMaxDistance
		t.adornee = p2.adornee
		t.animate = p2.animate or true
		t.normalizedOdds = p2.normalizedOdds

		if not t.adornee and p2.parent then
			t.adornee = p2.parent
		end

		_handle:Update(t)
		_handle:SetVisible(p1._visible)
	else
		if _handle then
			_handle:Update(nil)
			_handle:SetVisible(false)
		end

		p1._visible = false
	end
end
function t.IsBillboardVisible(p1) --[[ IsBillboardVisible | Line: 159 ]]
	if p1._destroyed then
		return false
	end

	local _handle = p1._handle

	if not _handle then
		return false
	end

	local v1 = _handle:GetBillboard()

	if v1 then
		return v1.Enabled
	end

	return false
end
function t.UpdateVisibility(p1, p2, p3) --[[ UpdateVisibility | Line: 177 ]]
	if p1._destroyed then
		return
	end

	if p3 then
		p1:SetVisible(false)

		return
	end

	local _state = p1._state

	if _state then
		local v1

		if _state then
			local parent = _state.parent

			if parent and parent.Parent then
				local dropTable = _state.dropTable

				v1 = if dropTable and #dropTable ~= 0 then true else false
			else
				v1 = false
			end
		else
			v1 = false
		end

		if v1 then
			local _handle = p1._handle

			if not _handle then
				return
			end

			local v2 = _handle:GetBillboard()

			if not (v2 and v2.Parent) then
				p1:SetVisible(false)

				return
			end

			local rangePart = _state.rangePart
			local v3 = if rangePart and rangePart.Parent then rangePart.Position else nil

			if not v3 then
				local rangeCFrame = _state.rangeCFrame

				if rangeCFrame then
					v3 = rangeCFrame.Position
				end
			end

			if not v3 then
				local parent = _state.parent

				if parent and (parent:IsA("BasePart") and parent.Parent) then
					v3 = parent.Position
				end
			end

			if v3 and (p2 and p2.Parent) then
				p1:SetVisible(if (v3 - p2.Position).Magnitude <= (_state.threshold or p1._defaultThreshold) then true else false)
			else
				p1:SetVisible(false)
			end

			return
		end
	end

	p1:SetVisible(false)
end
function t.Destroy(p1) --[[ Destroy | Line: 239 ]]
	if p1._destroyed then
		return
	end

	p1._destroyed = true
	p1._state = nil

	local _handle = p1._handle

	if not _handle then
		return
	end

	p1._handle = nil
	_handle:Destroy()
end

return t