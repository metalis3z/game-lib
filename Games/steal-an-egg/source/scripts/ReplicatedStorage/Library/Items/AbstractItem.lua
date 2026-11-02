-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local t2 = {}
local t3 = {}
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Library = ReplicatedStorage:WaitForChild("Library")
local Types = Library:WaitForChild("Types")
local Modules = Library:WaitForChild("Modules")
local Functions = Library:WaitForChild("Functions")
local Asserts = require(Library.Asserts)
local Items = require(Types.Items)
local v1 = require(Modules.Event)
local DeepCopyUnsafe = require(Functions.DeepCopyUnsafe)
local DeepFreezeUnsafe = require(Functions.DeepFreezeUnsafe)
local SHA256 = require(Functions.SHA256)
local BinaryToInt = require(Functions.BinaryToInt)
local JSON = require(Functions.JSON)
local FastJSON = require(Functions.FastJSON)
local CRC32 = require(Functions.CRC32)
local BinaryToUUIDv4 = require(Functions.BinaryToUUIDv4)
local DeepEqualsUnsafe = require(Functions.DeepEqualsUnsafe)
local Order = require(script.Parent.Order)

require(ReplicatedStorage.Library.Util.ItemUtil.Types.Interface)
t.TrackingEnabled = true
t.AmountLimit = 1000000000000000
t.StackLimit = 1000000000000000
t.TypeStackLimit = 1000000000000000
t.LockingEnabled = true
t.TradingEnabled = true
t.CreationTimeEnabled = true
t.CreationUserEnabled = true
t.OwnerCountEnabled = true
t.OwnerLogEnabled = true
t.OwnerLogLimit = 6
t.NicknameEnabled = true
t.NicknameLimit = 16
t.SignedByEnabled = true

local function AbstractPatch(p1) --[[ AbstractPatch | Line: 127 ]]
	error("unimplemented")
end

t.Patch = AbstractPatch
t3.Class = {
	Abstract = true,
	Name = "",
	Script = script,
	Module = t3
}
t3.Globals = t2
t3.Prototype = t
setmetatable(t3, {
	__index = t2,
	__call = function(...) --[[ __call | Line: 162 ]]
		error("NOP")
	end
})
function t3.Define(p1, p2, p3) --[[ Define | Line: 170 | Upvalues: t2 (copy), v1 (copy) ]]
	assert(if type(p3) == "table" then true else false, "Module must be a table")

	for k, v in pairs(t2) do
		if v1.IsA(v) then
			p3[k] = v1.new()
		end
	end

	return {
		Abstract = false,
		Name = p1,
		Script = p2,
		Module = p3
	}, t2
end
function t.Clone(p1) --[[ Clone | Line: 190 | Upvalues: DeepCopyUnsafe (copy) ]]
	local t = {
		_uid = p1._uid,
		_data = DeepCopyUnsafe(p1._data),
		_tracked = p1._tracked,
		_silent = p1._silent,
		_spawned = p1._spawned,
		_tag = p1._tag,
		_traceback = p1._traceback,
		_exchangeBlacklisted = p1._exchangeBlacklisted,
		_deleted = p1._deleted
	}

	return setmetatable(t, (getmetatable(p1)))
end
function t.IsA(p1, p2) --[[ IsA | Line: 207 ]]
	return p1.Class.Name == p2
end
function t.IsFrozen(p1) --[[ IsFrozen | Line: 211 ]]
	return table.isfrozen(p1)
end
function t.Freeze(p1) --[[ Freeze | Line: 215 | Upvalues: DeepFreezeUnsafe (copy) ]]
	if not table.isfrozen(p1) then
		if p1._stackKey == nil then
			p1._stackKey = p1:StackKey()
		end

		if p1._exactStackKey == nil then
			p1._exactStackKey = p1:ExactStackKey()
		end

		if p1._maxAmount == nil then
			p1._maxAmount = p1:GetMaxAmount()
		end

		p1:AbstractFreeze()
		DeepFreezeUnsafe(p1)
	end

	return p1
end
function t.AbstractFreeze(p1) --[[ AbstractFreeze | Line: 232 ]] end
function t.IsTracked(p1) --[[ IsTracked | Line: 234 ]]
	return p1._tracked
end
function t.SetTracked(p1, p2) --[[ SetTracked | Line: 238 | Upvalues: Asserts (copy) ]]
	Asserts.optional.boolean(p2)
	p1._tracked = p2

	return p1
end
function t.IsSilent(p1) --[[ IsSilent | Line: 244 ]]
	return p1._silent
end
function t.SetSilent(p1, p2) --[[ SetSilent | Line: 248 | Upvalues: Asserts (copy) ]]
	Asserts.optional.boolean(p2)
	p1._silent = p2

	return p1
end
function t.IsSpawned(p1) --[[ IsSpawned | Line: 254 ]]
	return p1._spawned == true
end
function t.SetSpawned(p1, p2) --[[ SetSpawned | Line: 258 | Upvalues: Asserts (copy) ]]
	Asserts.optional.boolean(p2)

	if p2 == true then
		p1._spawned = true
	else
		p1._spawned = nil
	end

	return p1
end
function t.Tag(p1, p2) --[[ Tag | Line: 269 | Upvalues: Asserts (copy) ]]
	Asserts.optional.string(p2)
	p1._tag = p2

	return p1
end
function t.GetTag(p1) --[[ GetTag | Line: 275 ]]
	return p1._tag
end
function t.SetTraceback(p1, p2) --[[ SetTraceback | Line: 279 | Upvalues: Asserts (copy) ]]
	Asserts.optional.string(p2)
	p1._traceback = p2

	return p1
end
function t.GetTraceback(p1) --[[ GetTraceback | Line: 285 ]]
	return p1._traceback
end
function t.IsExchangeBlacklisted(p1) --[[ IsExchangeBlacklisted | Line: 289 ]]
	return p1._exchangeBlacklisted == true
end
function t.SetExchangeBlacklisted(p1, p2) --[[ SetExchangeBlacklisted | Line: 293 | Upvalues: Asserts (copy) ]]
	Asserts.optional.boolean(p2)

	if p2 == true then
		p1._exchangeBlacklisted = true
	else
		p1._exchangeBlacklisted = nil
	end

	return p1
end
function t.SetDeleted(p1, p2) --[[ SetDeleted | Line: 304 | Upvalues: Asserts (copy) ]]
	Asserts.boolean(p2)

	if p2 == true then
		p1._deleted = true
	else
		p1._deleted = nil
	end

	return p1
end
function t.MarkDeleted(p1) --[[ MarkDeleted | Line: 315 ]]
	p1._deleted = true

	return p1
end
function t.IsDeleted(p1) --[[ IsDeleted | Line: 320 ]]
	return p1._deleted == true
end
function t.GetUID(p1) --[[ GetUID | Line: 324 ]]
	local _uid = p1._uid

	assert(_uid, "UID is not set for this item")

	return _uid
end
function t.GetOptionalUID(p1) --[[ GetOptionalUID | Line: 330 ]]
	return p1._uid
end
function t.SetUID(p1, p2) --[[ SetUID | Line: 334 | Upvalues: t3 (copy) ]]
	t3.AssertOptionalUIDFast(p2)
	p1._uid = p2

	return p1
end
function t.StripUID(p1) --[[ StripUID | Line: 340 ]]
	p1._uid = nil

	return p1
end
function t.PopulateUID(p1) --[[ PopulateUID | Line: 345 | Upvalues: t3 (copy) ]]
	if p1._uid then
		return false
	end

	p1._uid = t3.GenerateUID()

	return true
end
function t.CreateSeed(p1, p2) --[[ CreateSeed | Line: 354 | Upvalues: CRC32 (copy) ]]
	assert(if type(p2) == "string" then if #p2 > 0 then true else false else false, "Invalid seed provided to CreateSeed")

	return CRC32(("Seed/%*/%*"):format(p1:GetUID(), p2))
end
function t.CreateRandom(p1, p2) --[[ CreateRandom | Line: 363 ]]
	return Random.new(p1:CreateSeed(p2))
end
function t.CreateSecureSeed(p1, p2) --[[ CreateSecureSeed | Line: 367 | Upvalues: BinaryToInt (copy), SHA256 (copy), t3 (copy) ]]
	assert(if type(p2) == "string" then if #p2 > 0 then true else false else false, "Invalid seed provided to CreateSecureSeed")

	return BinaryToInt(SHA256(("%*%*"):format(t3.HashedSalt(), SHA256(("Seed/%*/%*"):format(p1:GetUID(), p2)))):sub(1, 4))
end
function t.CreateSecureRandom(p1, p2) --[[ CreateSecureRandom | Line: 378 | Upvalues: t (copy) ]]
	return Random.new(t.CreateSecureSeed(p1, p2))
end
function t.GenerateSecureUID(p1, p2) --[[ GenerateSecureUID | Line: 382 | Upvalues: BinaryToUUIDv4 (copy), SHA256 (copy), t3 (copy) ]]
	assert(if type(p2) == "string" then if #p2 > 0 then true else false else false, "Invalid seed provided to GenerateSecureUID")

	return BinaryToUUIDv4(SHA256(("%*%*"):format(t3.HashedSalt(), SHA256(("UID/%*/%*"):format(p1:GetUID(), p2)))))
end
function t.GetData(p1) --[[ GetData | Line: 393 ]]
	return p1._data
end
function t.SetData(p1, p2) --[[ SetData | Line: 397 | Upvalues: Asserts (copy) ]]
	Asserts.table(p2)
	p1._data = p2

	return p1
end
function t.ToString(p1) --[[ ToString | Line: 403 | Upvalues: JSON (copy) ]]
	return JSON.stringify({
		class = p1.Class.Name,
		uid = p1:GetOptionalUID(),
		data = p1:GetData()
	})
end
function t.CompareTo(p1, p2) --[[ CompareTo | Line: 411 | Upvalues: Asserts (copy), t (copy), Order (copy) ]]
	if p1 == p2 then
		return 0
	end

	Asserts.table(p2)
	assert(p2.GetData == t.GetData, "Other item does not implement GetData correctly")

	local Class = p1.Class
	local Class2 = p2.Class

	if Class == Class2 then
		local v1 = p1:AbstractCompareTo(p2)

		if v1 ~= 0 then
			return v1
		end

		local v2 = p1:IsTradableRaw()

		if v2 == p2:IsTradableRaw() then
			local v3 = p1:GetRarity()
			local v4 = p2:GetRarity()

			if v3 ~= v4 then
				return v4.RarityNumber - v3.RarityNumber
			end

			local v5 = p2:GetTier() - p1:GetTier()

			if v5 ~= 0 then
				return v5
			end

			local v6 = p1:GetId()
			local v7 = p2:GetId()

			if v6 == v7 then
				local v8 = p1:IsLocked()

				if v8 == p2:IsLocked() then
					local v9 = p1:IsUnique()

					if v9 == p2:IsUnique() then
						local v10 = p2:GetAmount() - p1:GetAmount()

						if v10 ~= 0 then
							return v10
						end

						local v11 = p1:GetSignedBy()
						local v12 = p2:GetSignedBy()

						if v11 == v12 then
							local v13 = p1:GetNickname()
							local v14 = p2:GetNickname()

							if v13 and v14 then
								if v13 < v14 then
									return -1
								end

								if v14 < v13 then
									return 1
								end
							else
								if v13 then
									return -1
								end

								if v14 then
									return 1
								end
							end

							local v15 = p1:GetCreationTime()
							local v16 = p2:GetCreationTime()

							if v15 == v16 then
								local v17 = p1:GetOwnerCount()
								local v18 = p2:GetOwnerCount()

								if v17 == v18 then
									local v19 = p1:GetOptionalUID()
									local v20 = p2:GetOptionalUID()

									if v19 and v20 then
										if v19 < v20 then
											return -1
										end

										if v20 < v19 then
											return 1
										end
									else
										if v19 then
											return -1
										end

										if v20 then
											return 1
										end
									end

									return 0
								end

								if v17 and v18 then
									return v17 - v18
								end

								if v17 then
									return -1
								end

								return 1
							end

							if v15 and v16 then
								return v16 - v15
							end

							if v15 then
								return -1
							end

							return 1
						end

						if v11 and v12 then
							return v11 - v12
						end

						if v11 then
							return -1
						end

						return 1
					end

					if v9 then
						return -1
					end

					return 1
				end

				if v8 then
					return -1
				end

				return 1
			end

			local v21 = p1:GetName()
			local v22 = p2:GetName()

			if v21 == v22 then
				if v6 < v7 then
					return -1
				end

				return 1
			end

			if v21 < v22 then
				return -1
			end

			return 1
		end

		if v2 then
			return -1
		end

		return 1
	end

	local v23 = p1:IsTradableRaw()

	if v23 == p2:IsTradableRaw() then
		local v24 = p1:GetRarity()
		local v25 = p2:GetRarity()

		if v24 == v25 then
			return (Order.Order[Class.Name] or (1 / 0)) - (Order.Order[Class2.Name] or (1 / 0))
		end

		return v25.RarityNumber - v24.RarityNumber
	end

	if v23 then
		return -1
	end

	return 1
end
function t.AbstractCompareTo(p1, p2) --[[ AbstractCompareTo | Line: 551 ]]
	return 0
end
function t.GetNetworkPacket(p1) --[[ GetNetworkPacket | Line: 556 ]]
	return {
		class = p1.Class.Name,
		uid = p1:GetOptionalUID(),
		data = p1:GetData()
	}
end
function t.ModifyUnique(p1, p2) --[[ ModifyUnique | Line: 564 ]]
	local v1 = p1._data._uq or {}

	p2(v1)

	if not next(v1) then
		p1._data._uq = nil

		return
	end

	assert(p1:GetAmount() == 1, "Item amount must be 1 when unique data is present")
	p1._data._uq = v1
end
function t.IsForcedUnique(p1) --[[ IsForcedUnique | Line: 577 ]]
	local _uq = p1._data._uq

	return if _uq then _uq._fu or false else false
end
function t.SetForcedUnique(p1, p2) --[[ SetForcedUnique | Line: 582 ]]
	p1:ModifyUnique(function(p1) --[[ Line: 583 | Upvalues: p2 (copy) ]]
		p1._fu = p2
	end)

	return p1
end
function t.IsUnique(p1) --[[ IsUnique | Line: 589 ]]
	return p1._data._uq ~= nil
end
function t.GetMaxAmount(p1) --[[ GetMaxAmount | Line: 593 ]]
	local _maxAmount = p1._maxAmount

	if _maxAmount then
		return _maxAmount
	end

	if p1._data._uq then
		return 1
	end

	local v1 = p1:AbstractGetMaxAmount()

	if v1 then
		return v1
	end

	return p1.AmountLimit
end
function t.AbstractGetMaxAmount(p1) --[[ AbstractGetMaxAmount | Line: 609 ]]
	return p1.AmountLimit
end
function t.IsStackable(p1) --[[ IsStackable | Line: 613 ]]
	return p1:GetMaxAmount() > 1
end
function t.CanClearUnique(p1) --[[ CanClearUnique | Line: 617 | Upvalues: Items (copy) ]]
	if p1:IsForcedUnique() then
		return false
	end

	if (p1:AbstractGetMaxAmount() or p1.AmountLimit) <= 1 then
		return false
	end

	local v2 = p1:AbstractCanClearUnique()

	if v2 ~= nil then
		return v2
	end

	local v3 = false
	local _uq = p1._data._uq

	if not _uq then
		return true
	end

	for k, v in pairs(_uq) do
		if not Items.PointlessUniques[k] then
			v3 = true

			break
		end
	end

	if v3 then
		return false
	end

	return true
end
function t.AbstractCanClearUnique(p1) --[[ AbstractCanClearUnique | Line: 645 ]]
	return nil
end
function t.ClearUnique(p1) --[[ ClearUnique | Line: 649 ]]
	if not p1._data._uq then
		return false
	end

	if p1:CanClearUnique() then
		p1._data._uq = nil

		return true
	end

	return false
end
function t.GetAmount(p1) --[[ GetAmount | Line: 660 ]]
	return p1._data._am or 1
end
function t.SetAmount(p1, p2) --[[ SetAmount | Line: 664 | Upvalues: Asserts (copy) ]]
	Asserts.positiveInteger(p2)
	assert(p2 <= p1:GetMaxAmount(), "Amount exceeds maximum allowed")
	p1._data._am = if p2 == 1 or not p2 then nil else p2

	return p1
end
function t.Populate(p1, p2, p3, p4) --[[ Populate | Line: 671 ]]
	p1:AbstractPopulate(p2)

	if not p1:IsStackable() then
		local v1 = nil

		if p3 or p4 then
			if p2 and (not p1:GetCreationUser() and p1.CreationUserEnabled) then
				p1:SetCreationUser(p2.UserId)
			end

			if not p1:GetCreationTime() and p1.CreationTimeEnabled then
				if not v1 then
					v1 = math.floor((workspace:GetServerTimeNow()))
				end

				p1:SetCreationTime(v1)
			end
		end

		if p2 and p1.OwnerLogEnabled then
			p1:AddOwnerLog(p2.UserId, v1)
		end
	end

	p1:ClearUnique()

	return p1
end
function t.AbstractPopulate(p1, p2) --[[ AbstractPopulate | Line: 694 ]] end
function t.IsLocked(p1) --[[ IsLocked | Line: 698 ]]
	return p1._data._lk == true
end
function t.SetLocked(p1, p2) --[[ SetLocked | Line: 702 ]]
	assert(if type(p2) == "boolean" then true else false, "Locked must be a boolean")
	assert(not p2 or p1.LockingEnabled, "Locking is disabled for this item")
	p1._data._lk = if p2 then true else nil

	return p1
end
function t.GetTradableOverride(p1) --[[ GetTradableOverride | Line: 709 ]]
	return p1._data._to
end
function t.SetTradableOverride(p1, p2) --[[ SetTradableOverride | Line: 713 ]]
	p1._data._to = p2

	return p1
end
function t.AbstractIsRAPVisible(p1) --[[ AbstractIsRAPVisible | Line: 718 ]]
	return nil
end
function t.IsRAPVisible(p1) --[[ IsRAPVisible | Line: 722 ]]
	local v1 = p1:AbstractIsRAPVisible()

	if v1 == nil then
		return p1:IsTradableRaw() and true or false
	end

	return v1
end
function t.AbstractIsTradable(p1) --[[ AbstractIsTradable | Line: 733 ]]
	return nil
end
function t.IsTradable(p1) --[[ IsTradable | Line: 737 ]]
	if p1:IsLocked() then
		return false
	end

	return p1:IsTradableRaw()
end
function t.IsTradableRaw(p1) --[[ IsTradableRaw | Line: 745 ]]
	local v1 = p1:GetTradableOverride()

	if v1 ~= nil then
		return v1
	end

	local v2 = p1:AbstractIsTradable()

	if v2 == nil then
		return p1.TradingEnabled
	end

	return v2
end
function t.GetCreationTime(p1) --[[ GetCreationTime | Line: 759 ]]
	local _uq = p1._data._uq

	return if _uq then _uq._ct else _uq
end
function t.SetCreationTime(p1, p2) --[[ SetCreationTime | Line: 764 | Upvalues: Asserts (copy) ]]
	Asserts.optional.integer(p2)
	assert(not p2 or p1.CreationTimeEnabled, "CreationTime is not enabled for this item")
	p1:ModifyUnique(function(p1) --[[ Line: 767 | Upvalues: p2 (copy) ]]
		p1._ct = p2
	end)

	return p1
end
function t.GetCreationUser(p1) --[[ GetCreationUser | Line: 773 ]]
	local _uq = p1._data._uq

	return if _uq then _uq._cu else _uq
end
function t.SetCreationUser(p1, p2) --[[ SetCreationUser | Line: 778 | Upvalues: Asserts (copy) ]]
	Asserts.optional.integer(p2)
	assert(not p2 or p1.CreationUserEnabled, "CreationUser is not enabled for this item")
	p1:ModifyUnique(function(p1) --[[ Line: 781 | Upvalues: p2 (copy) ]]
		p1._cu = p2
	end)

	return p1
end
function t.GetOwnerCount(p1) --[[ GetOwnerCount | Line: 787 ]]
	local _uq = p1._data._uq

	return if _uq then _uq._oc else _uq
end
function t.SetOwnerCount(p1, p2) --[[ SetOwnerCount | Line: 792 | Upvalues: Asserts (copy) ]]
	Asserts.optional.nonNegativeInteger(p2)
	assert(if p2 == nil then true else p1.OwnerCountEnabled, "OwnerCount is not enabled for this item")
	p1:ModifyUnique(function(p1) --[[ Line: 799 | Upvalues: p2 (copy) ]]
		p1._oc = p2
	end)

	return p1
end
function t.GetOwnerLog(p1) --[[ GetOwnerLog | Line: 805 ]]
	local _uq = p1._data._uq

	return if _uq then _uq._ol or {} else {}
end
function t.SetOwnerLog(p1, p2) --[[ SetOwnerLog | Line: 810 | Upvalues: Asserts (copy) ]]
	if p2 ~= nil then
		local count = 0
		local t = {}

		for i, v in ipairs(p2) do
			count = count + 1
			assert(if i == count then true else false, "OwnerLog index mismatch at entry " .. i)
			assert(if type(v) == "table" then true else false, "OwnerLog entry at index " .. i .. " is not a table")
			assert(if #v == 2 then true else false, "OwnerLog entry at index " .. i .. " must have exactly 2 elements")

			local v4 = v[1]
			local v5 = v[2]

			Asserts.integer(v4)
			Asserts.integer(v5)
			table.insert(t, { v4, v5 })
		end

		p2 = if #t > 0 then t else nil
	end

	local v7 = not p2 or p1.OwnerLogEnabled

	assert(v7, "OwnerLog is not enabled for this item")
	p1:ModifyUnique(function(p1) --[[ Line: 830 | Upvalues: p2 (ref) ]]
		p1._ol = p2
	end)

	return p1
end
function t.AddOwnerLog(p1, p2, p3) --[[ AddOwnerLog | Line: 836 | Upvalues: Asserts (copy) ]]
	Asserts.integer(p2)
	Asserts.optional.integer(p3)
	assert(p1.OwnerLogEnabled, "OwnerLog is not enabled for this item")
	p1:ModifyUnique(function(p12) --[[ Line: 840 | Upvalues: p2 (copy), p3 (copy), p1 (copy) ]]
		local _ol = p12._ol

		if not _ol then
			_ol = {}
			p12._ol = _ol
		end

		assert(_ol, "Expected ownerLog to be non-nil")

		if if #_ol > 0 and _ol[1][1] == p2 then false else true then
			p12._oc = (p12._oc or 0) + 1

			local t = {}
			local v4 = p3

			if not v4 then
				v4 = math.floor((workspace:GetServerTimeNow()))
			end

			t[1] = p2
			t[2] = v4
			table.insert(_ol, 1, t)
		end

		while p1.OwnerLogLimit < #_ol do
			table.remove(_ol, #_ol)
		end
	end)

	return p1
end
function t.GetNickname(p1) --[[ GetNickname | Line: 862 ]]
	local _uq = p1._data._uq

	return if _uq then _uq._nk else _uq
end
function t.SetNickname(p1, p2) --[[ SetNickname | Line: 867 | Upvalues: Asserts (copy) ]]
	if p2 ~= nil then
		assert(#p2 > 0, "Nickname must not be empty")
		assert(#p2 <= p1.NicknameLimit, "Nickname exceeds maximum length")
		Asserts.ascii(p2)
	end

	assert(not p2 or p1.NicknameEnabled, "Nickname is not enabled for this item")
	p1:ModifyUnique(function(p1) --[[ Line: 874 | Upvalues: p2 (copy) ]]
		p1._nk = p2
	end)

	return p1
end
function t.GetSignedBy(p1) --[[ GetSignedBy | Line: 880 ]]
	local _uq = p1._data._uq

	return if _uq then _uq._sb else _uq
end
function t.SetSignedBy(p1, p2) --[[ SetSignedBy | Line: 885 | Upvalues: Asserts (copy) ]]
	Asserts.optional.integer(p2)
	assert(not p2 or p1.SignedByEnabled, "SignedBy is not enabled for this item")
	p1:ModifyUnique(function(p1) --[[ Line: 888 | Upvalues: p2 (copy) ]]
		p1._sb = p2
	end)

	return p1
end
function t.GetPurchaseData(p1) --[[ GetPurchaseData | Line: 894 ]]
	local _uq = p1._data._uq

	return if _uq then _uq._pd else _uq
end
function t.SetPurchaseData(p1, p2) --[[ SetPurchaseData | Line: 899 | Upvalues: Asserts (copy), DeepEqualsUnsafe (copy) ]]
	if p2 ~= nil then
		assert(type(p2) == "table", "Purchase data must be a table")
		assert(if type(p2.pu) == "string" then true else false, "Purchase id must be a string")
		assert(if #p2.pu == 32 then true else false, "Purchase id must be 32 characters long")
		assert(p2.pu:find("^[0-9a-f]+$"), "Purchase id must be in hexadecimal format")
		Asserts.integer(p2.us)
		Asserts.integer(p2.pr)
		Asserts.integer(p2.pi)
		Asserts.integer(p2.cs)
		Asserts.integer(p2.ts)

		local t = {
			pu = p2.pu,
			us = p2.us,
			pr = p2.pr,
			pi = p2.pi,
			cs = p2.cs,
			ts = p2.ts
		}

		assert(DeepEqualsUnsafe(t, p2), "Purchase data does not match expected structure")
		table.freeze(t)
		p2 = t
	end

	p1:ModifyUnique(function(p1) --[[ Line: 924 | Upvalues: p2 (ref) ]]
		p1._pd = p2
	end)

	return p1
end
function t.GetMerchData(p1) --[[ GetMerchData | Line: 930 ]]
	local _uq = p1._data._uq

	return if _uq then _uq._md else _uq
end
function t.SetMerchData(p1, p2) --[[ SetMerchData | Line: 935 | Upvalues: Asserts (copy), DeepEqualsUnsafe (copy) ]]
	if p2 ~= nil then
		Asserts.table(p2)
		Asserts.ascii(p2.cd)
		assert(#p2.cd <= 100, "Merch data code must not exceed the limit.")
		Asserts.optional.integer(p2.us)
		Asserts.optional.nonNegativeInteger(p2.sr)

		if p2.sk ~= nil then
			Asserts.ascii(p2.sk)
			assert(#p2.sk <= 100, "Merch data sk field must not exceed 100 characters")
		end

		Asserts.optional.boolean(p2.pi)

		local t = {
			cd = p2.cd,
			us = p2.us,
			sr = p2.sr,
			sk = p2.sk,
			pi = p2.pi
		}

		assert(DeepEqualsUnsafe(t, p2), "Merch data does not match expected structure")
		table.freeze(t)
		p2 = t
	end

	p1:ModifyUnique(function(p1) --[[ Line: 961 | Upvalues: p2 (ref) ]]
		p1._md = p2
	end)

	return p1
end
function t.GetSerialData(p1) --[[ GetSerialData | Line: 967 ]]
	local _uq = p1._data._uq

	return if _uq then _uq._sd else _uq
end
function t.SetSerialData(p1, p2) --[[ SetSerialData | Line: 972 | Upvalues: Asserts (copy), DeepEqualsUnsafe (copy) ]]
	if p2 ~= nil then
		assert(type(p2) == "table", "Serial data must be a table")
		Asserts.integer(p2.us)
		Asserts.nonNegativeInteger(p2.sr)

		local t = {
			us = p2.us,
			sr = p2.sr
		}

		assert(DeepEqualsUnsafe(t, p2), "Serial data does not match expected structure")
		table.freeze(t)
		p2 = t
	end

	p1:ModifyUnique(function(p1) --[[ Line: 985 | Upvalues: p2 (ref) ]]
		p1._sd = p2
	end)

	return p1
end
function t.GetTransferData(p1) --[[ GetTransferData | Line: 991 ]]
	local _uq = p1._data._uq

	return if _uq then _uq._tr else _uq
end
function t.SetTransferData(p1, p2) --[[ SetTransferData | Line: 996 | Upvalues: Asserts (copy), DeepEqualsUnsafe (copy) ]]
	if p2 ~= nil then
		assert(type(p2) == "table", "Transfer data must be a table")
		Asserts.integer(p2.us)
		Asserts.finite(p2.ts)

		local t = {
			us = p2.us
		}

		t.ts = math.round(p2.ts)
		assert(DeepEqualsUnsafe(t, p2), "Transfer data does not match expected structure")
		table.freeze(t)
		p2 = t
	end

	p1:ModifyUnique(function(p1) --[[ Line: 1009 | Upvalues: p2 (ref) ]]
		p1._tr = p2
	end)

	return p1
end
function IsLikeGeneric(p1, p2, p3) --[[ IsLikeGeneric | Line: 1015 | Upvalues: t (copy), DeepEqualsUnsafe (copy) ]]
	assert(if p2.GetData == t.GetData then true else false, "Other item does not implement GetData correctly")

	if p1 == p2 then
		return true
	end

	if p1.Class ~= p2.Class then
		return false
	end

	local _data = p1._data
	local _data2 = p2._data

	for k, v in pairs(_data) do
		if not p3[k] then
			local v2 = _data2[k]

			if v2 == nil or not DeepEqualsUnsafe(v, v2) then
				return false
			end
		end
	end

	for k in pairs(_data2) do
		if not p3[k] and _data[k] == nil then
			return false
		end
	end

	return true
end
function t.IsLikeExact(p1, p2) --[[ IsLikeExact | Line: 1042 | Upvalues: Items (copy) ]]
	return IsLikeGeneric(p1, p2, Items.ExactStackKeyIgnoredFields)
end
function t.IsLikeAny(p1, p2) --[[ IsLikeAny | Line: 1046 | Upvalues: Items (copy) ]]
	return IsLikeGeneric(p1, p2, Items.StackKeyIgnoredFields)
end
function t.StackKeyData(p1) --[[ StackKeyData | Line: 1050 | Upvalues: DeepCopyUnsafe (copy) ]]
	local v1 = DeepCopyUnsafe(p1._data)

	v1._am = nil
	v1._lk = nil
	v1._to = nil
	v1._uq = nil

	return v1
end
function t.StackKey(p1) --[[ StackKey | Line: 1059 | Upvalues: FastJSON (copy) ]]
	local _stackKey = p1._stackKey

	if _stackKey then
		return _stackKey
	end

	local _data = p1._data

	if table.isfrozen(_data) then
		_data = table.clone(_data)
	end

	local _am = _data._am
	local _lk = _data._lk
	local _to = _data._to
	local _uq = _data._uq

	_data._am = nil
	_data._lk = nil
	_data._to = nil
	_data._uq = nil

	local ok, result = pcall(function() --[[ Line: 1079 | Upvalues: FastJSON (ref), _data (ref) ]]
		return FastJSON.Encode(_data)
	end)

	_data._am = _am
	_data._lk = _lk
	_data._to = _to
	_data._uq = _uq

	if not ok then
		error("Error encoding stack key data: " .. tostring(result))
	end

	return result
end
function t.ExactStackKeyData(p1) --[[ ExactStackKeyData | Line: 1095 | Upvalues: DeepCopyUnsafe (copy) ]]
	local v1 = DeepCopyUnsafe(p1._data)

	v1._am = nil
	v1._lk = nil

	return v1
end
function t.ExactStackKey(p1) --[[ ExactStackKey | Line: 1102 | Upvalues: FastJSON (copy) ]]
	local _exactStackKey = p1._exactStackKey

	if _exactStackKey then
		return _exactStackKey
	end

	local _data = p1._data

	if table.isfrozen(_data) then
		_data = table.clone(_data)
	end

	local _am = _data._am
	local _lk = _data._lk

	_data._am = nil
	_data._lk = nil

	local ok, result = pcall(function() --[[ Line: 1115 | Upvalues: FastJSON (ref), _data (ref) ]]
		return FastJSON.Encode(_data)
	end)

	_data._am = _am
	_data._lk = _lk

	if not ok then
		error("Error encoding exact stack key data: " .. tostring(result))
	end

	return result
end
function t.GetId(p1) --[[ GetId | Line: 1127 ]]
	error("Unimplemented")
end
function t.SetId(p1, p2) --[[ SetId | Line: 1131 ]]
	error("Unimplemented")
end
function t.GetTier(p1) --[[ GetTier | Line: 1135 ]]
	return 0
end
function t.Directory(p1) --[[ Directory | Line: 1139 ]]
	error("Unimplemented")
end
function t.SetDirectory(p1, p2) --[[ SetDirectory | Line: 1143 ]]
	error("Unimplemented")
end
function t.GetRarity(p1) --[[ GetRarity | Line: 1147 | Upvalues: ReplicatedStorage (copy) ]]
	return require(ReplicatedStorage.Directory.Rarity).Rarities.Basic
end
function t.GetIcon(p1) --[[ GetIcon | Line: 1151 ]]
	return ""
end
function t.GetOrbIcon(p1) --[[ GetOrbIcon | Line: 1155 ]]
	return p1:GetIcon()
end
function t.GetName(p1) --[[ GetName | Line: 1159 ]]
	return ""
end
function t.GetDesc(p1) --[[ GetDesc | Line: 1163 ]]
	return ""
end
function t.GiveStrict(p1, p2) --[[ GiveStrict | Line: 1167 ]]
	error("Unimplemented")
end
function t.GiveRelaxed(p1, p2) --[[ GiveRelaxed | Line: 1171 ]]
	error("Unimplemented")
end
function t.CollectAny(p1, p2) --[[ CollectAny | Line: 1175 ]]
	error("Unimplemented")
end
function t.CollectExact(p1, p2) --[[ CollectExact | Line: 1179 ]]
	error("Unimplemented")
end
function t.HasExact(p1, p2) --[[ HasExact | Line: 1183 ]]
	error("Unimplemented")
end
function t.HasAny(p1, p2) --[[ HasAny | Line: 1187 ]]
	error("Unimplemented")
end
function t.CountExact(p1, p2) --[[ CountExact | Line: 1191 ]]
	error("Unimplemented")
end
function t.CountAny(p1, p2) --[[ CountAny | Line: 1195 ]]
	error("Unimplemented")
end
function t.FindExact(p1, p2) --[[ FindExact | Line: 1199 ]]
	error("Unimplemented")
end
function t.FindAny(p1, p2) --[[ FindAny | Line: 1203 ]]
	error("Unimplemented")
end
function t.GetRAP(p1) --[[ GetRAP | Line: 1207 ]]
	error("Unimplemented")
end
function t.GetDevRAP(p1) --[[ GetDevRAP | Line: 1211 ]]
	error("Unimplemented")
end
function t.GetExistCount(p1) --[[ GetExistCount | Line: 1215 ]]
	error("Unimplemented")
end
function t.ToRewardFormat(p1, p2) --[[ ToRewardFormat | Line: 1219 ]]
	error("Unimplemented")
end
function t.ToItemUtilFormat(p1) --[[ ToItemUtilFormat | Line: 1223 ]]
	error("Unimplemented")
end
t2.Added = v1.new()
t2.Removed = v1.new()
t2.Tracked = v1.new()
function t2.IsA(p1, p2) --[[ IsA | Line: 1232 | Upvalues: t (copy), t3 (copy) ]]
	return if type(p2) == "table" and p2.GetData == t.GetData then if p2.Class == p1.Class then true else p1 == t3 else false
end
function t2.IsAWithErrMsg(p1, p2) --[[ IsAWithErrMsg | Line: 1246 | Upvalues: t2 (copy) ]]
	if t2.IsA(p1, p2) then
		return true
	end

	return false, ("Item is not of type %*. Expected item to have GetData method matching AbstractPrototype.GetData, got: %*"):format(p1.Class.Name, p2)
end
function t2.WrapForTCheck(p1) --[[ WrapForTCheck | Line: 1256 ]]
	return function(p12) --[[ Line: 1257 | Upvalues: p1 (copy) ]]
		return p1:IsAWithErrMsg(p12)
	end
end
function t2.TryCast(p1, p2) --[[ TryCast | Line: 1262 | Upvalues: t2 (copy) ]]
	return if t2.IsA(p1, p2) and p2 then p2 else nil
end
function t2.Assert(p1, p2) --[[ Assert | Line: 1266 | Upvalues: t (copy), t3 (copy) ]]
	assert(if p2.GetData == t.GetData then true else false, "Item does not implement GetData")

	if p1 ~= t3 then
		assert(p2.Class == p1.Class, "Item class mismatch")
	end

	return p2
end
function t2.Cast(p1, p2) --[[ Cast | Line: 1274 | Upvalues: t2 (copy) ]]
	t2.Assert(p1, p2)

	return p2
end
function t2.From(p1, p2) --[[ From | Line: 1279 | Upvalues: AbstractPatch (copy) ]]
	assert(if type(p2) == "table" then true else false, "Data must be a table")

	local v2 = setmetatable({
		_data = p2
	}, {
		__index = p1.Prototype,
		__tostring = p1.Prototype.ToString
	})
	local Patch = v2.Patch

	if Patch and (Patch ~= AbstractPatch and not table.isfrozen(p2)) then
		pcall(Patch, v2)
	end

	return v2
end
function t2.Find(p1, p2) --[[ Find | Line: 1298 ]]
	error("Unimplemented")
end
function t2.Get(p1, p2, p3) --[[ Get | Line: 1302 ]]
	error("Unimplemented")
end
function t2.All(p1, p2) --[[ All | Line: 1306 ]]
	error("Unimplemented")
end
function t2.Each(p1, p2, p3, ...) --[[ Each | Line: 1310 ]]
	error("Unimplemented")
end
function t3.IsAnyItem(p1) --[[ IsAnyItem | Line: 1315 | Upvalues: t (copy) ]]
	return if type(p1) == "table" then p1.GetData == t.GetData else false
end
function t3.AssertAnyItem(p1) --[[ AssertAnyItem | Line: 1323 | Upvalues: t (copy) ]]
	assert(if type(p1) == "table" then if p1.GetData == t.GetData then true else false else false, "Item is not a valid abstract item")

	return p1
end
function t3.AssertModule(p1) --[[ AssertModule | Line: 1332 | Upvalues: t2 (copy) ]]
	assert(p1.IsA == t2.IsA, "Module does not have the correct IsA function")
end
function t3.AssertUID(p1) --[[ AssertUID | Line: 1336 | Upvalues: Asserts (copy) ]]
	Asserts.UUIDv4StrippedLower(p1)

	return p1
end
function t3.AssertOptionalUID(p1) --[[ AssertOptionalUID | Line: 1341 | Upvalues: Asserts (copy) ]]
	Asserts.optional.UUIDv4StrippedLower(p1)

	return p1
end
function t3.AssertUIDFast(p1) --[[ AssertUIDFast | Line: 1346 | Upvalues: Asserts (copy) ]]
	Asserts.UUIDv4StrippedLowerFast(p1)

	return p1
end
function t3.AssertOptionalUIDFast(p1) --[[ AssertOptionalUIDFast | Line: 1351 | Upvalues: Asserts (copy) ]]
	Asserts.optional.UUIDv4StrippedLowerFast(p1)
end
function t3.AssertUniqueUIDs(p1) --[[ AssertUniqueUIDs | Line: 1355 | Upvalues: Asserts (copy) ]]
	Asserts.array.uniqueUUIDv4StrippedLower(p1)

	return p1
end
function t3.AssertUniqueUIDsFast(p1) --[[ AssertUniqueUIDsFast | Line: 1360 | Upvalues: Asserts (copy) ]]
	Asserts.array.uniqueUUIDv4StrippedLowerFast(p1)

	return p1
end
function t3.GenerateUID() --[[ GenerateUID | Line: 1365 | Upvalues: HttpService (copy) ]]
	return HttpService:GenerateGUID(false):gsub("%-", ""):lower()
end
function t3.AssertOrGenerateUID(p1) --[[ AssertOrGenerateUID | Line: 1369 | Upvalues: t3 (copy) ]]
	if p1 == nil then
		return t3.GenerateUID()
	end

	t3.AssertUID(p1)

	return p1
end
function t3.AssertUniqueItems(p1) --[[ AssertUniqueItems | Line: 1378 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.array.custom(p1, function(p1, p2) --[[ Line: 1379 | Upvalues: Asserts (ref), t (ref) ]]
		Asserts.cassert(if type(p1) == "table" then true else false, p2)
		Asserts.cassert(p1.GetData == t.GetData, p2)
	end)

	local t2 = {}

	for i, v in ipairs(p1) do
		local v1 = v:GetUID()

		assert(not t2[v1], "Duplicate UID found: " .. v1)
		t2[v1] = true
	end

	return p1
end
t3.Nil = nil
function t3.HashedSalt() --[[ Line: 1393 ]]
	return ""
end

local v2 = SHA256(("AbstractItem/%*"):format(game.GameId))

function t3.HashedSalt() --[[ Line: 1399 | Upvalues: v2 (copy) ]]
	return v2
end

return t3