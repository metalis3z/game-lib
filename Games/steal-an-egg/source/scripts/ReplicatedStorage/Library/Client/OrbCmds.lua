-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Library = ReplicatedStorage:WaitForChild("Library")
local Types = Library:WaitForChild("Types")
local Items = Library:WaitForChild("Items")
local Client = Library:WaitForChild("Client")
local Orbs = require(Types.Orbs)
local CurrencyItem = require(Items.CurrencyItem)
local Types2 = require(Items.Types)
local BindToRenderStep = require(Library.Functions.BindToRenderStep)
local Network = require(Client.Network)
local GraphicsQuality = require(Library.Functions.GraphicsQuality)
local Orb = require(script.Orb)
local InsertOrReplace = require(ReplicatedStorage.Library.Functions.InsertOrReplace)
local TrimArray = require(ReplicatedStorage.Library.Functions.TrimArray)
local LocalPlayer = Players.LocalPlayer
local v1 = Random.new()
local t = {}
local v2 = 0
local v3 = 0
local v4 = 0
local t2 = {}
local t3 = {}

local function hashPosition(p1) --[[ hashPosition | Line: 33 ]]
	local v1 = bit32.band(p1.X, 262143) * 262144
	local v2 = (v1 + bit32.band(p1.Z, 262143)) * 131072

	return v2 + bit32.band(p1.Y, 131071)
end

local function combineScale(p1, p2) --[[ combineScale | Line: 38 ]]
	if p2 <= 5 then
		return math.max(1, 10 - p1 / 10)
	end

	return math.max(1, 20 - p1 / 10)
end

BindToRenderStep("Orbs", Enum.RenderPriority.Last.Value, function(p1) --[[ Line: 45 | Upvalues: GraphicsQuality (copy), v3 (ref), v4 (ref), Orb (copy), v2 (ref), LocalPlayer (copy), t (ref), InsertOrReplace (copy), t2 (copy), t3 (copy), TrimArray (copy), Network (copy) ]]
	debug.profilebegin("OrbCmds :: RenderStep")

	local v1 = GraphicsQuality()

	v3 = v3 + p1
	v4 = v4 + 1

	local t4 = {}

	if v4 >= 1 then
		local count = 0
		local CombineDistance = Orb.CombineDistance
		local v22 = 1
		local v32 = v3
		local v42

		if v1 <= 5 then
			v42 = CombineDistance / math.max(1, 4 - v2 / 10)
			v22 = 0.5
		else
			v42 = CombineDistance / math.max(1, 8 - v2 / 20)
		end

		v3 = 0
		v4 = 0

		local t5 = {}
		local t6 = {}
		local Gravity = workspace.Gravity
		local v7 = workspace:GetServerTimeNow()
		local Character = LocalPlayer.Character
		local v8 = Character and Character.PrimaryPart and Character.PrimaryPart.CFrame or nil
		local DefaultPickupDistance = Orb.DefaultPickupDistance

		for k, v in pairs(t) do
			local function safeRenderStepped() --[[ safeRenderStepped | Line: 84 | Upvalues: v (copy), v32 (copy), v7 (copy), Gravity (copy), Character (copy), v8 (copy), DefaultPickupDistance (copy) ]]
				return v:RenderStepped(v32, v7, Gravity, 1, Character, v8, DefaultPickupDistance)
			end

			local ok, result = pcall(safeRenderStepped)

			if ok and result then
				local _cframePhysics = v._cframePhysics
				local _cframeRender = v._cframeRender

				if _cframePhysics ~= _cframeRender then
					v._cframeRender = _cframePhysics
					count = count + 1
					InsertOrReplace(t2, v._part, count)
					InsertOrReplace(t3, _cframeRender * v._pivotOffsetInv, count)
				end

				local Position = _cframePhysics.Position

				if v._anchored or v7 - v._timestamp > 5 then
					local _combineKey = v._combineKey

					if _combineKey and v._combineDelay * v22 <= v7 - v._timestamp then
						local v10 = t5[_combineKey] or {}

						t5[_combineKey] = v10

						local v11 = Position // v42
						local v12 = bit32.band(v11.X, 262143) * 262144
						local v13 = (v12 + bit32.band(v11.Z, 262143)) * 131072
						local v14 = v13 + bit32.band(v11.Y, 131071)
						local v15 = v10[v14] or {}

						v10[v14] = v15
						table.insert(v15, v)
					end
				end

				local v16 = Position // 300
				local v17 = bit32.band(v16.X, 262143) * 262144
				local v18 = (v17 + bit32.band(v16.Z, 262143)) * 131072
				local v19 = v18 + bit32.band(v16.Y, 131071)

				t6[v19] = (t6[v19] or 0) + 1

				continue
			end

			if not ok then
				warn("[OrbCmds] Error:", result)
			end

			t[k] = nil
			v2 = v2 - 1
			v:Destroy()

			if v._collected then
				table.insert(t4, v._id)
				table.move(v._combinedIds, 1, #v._combinedIds, #t4 + 1, t4)
			end
		end

		TrimArray(t2, count)
		TrimArray(t3, count)

		if count > 0 then
			workspace:BulkMoveTo(t2, t3, Enum.BulkMoveMode.FireCFrameChanged)
		end

		for k, v in pairs(t) do
			local v20
			local _combineKey = v._combineKey

			if _combineKey then
				local v21 = t5[_combineKey]

				if v21 then
					local v222 = v7 - v._timestamp

					if v._combineDelay <= v222 then
						local Position = v._cframePhysics.Position
						local v23 = Position // v42
						local v25 = Position // 300
						local v26 = bit32.band(v25.X, 262143) * 262144
						local v27 = (v26 + bit32.band(v25.Z, 262143)) * 131072
						local v28 = t6[v27 + bit32.band(v25.Y, 131071)] or 0

						v20 = if v1 <= 5 then math.max(1, 10 - v28 / 10) else math.max(1, 20 - v28 / 10)

						if v._pickupDelay + (v._combineDelay - v._pickupDelay) * v20 <= v222 then
							for i = -1, 1 do
								for j = -1, 1 do
									for k2 = -1, 1 do
										local v31 = v23 + Vector3.new(i, j, k2)
										local v322 = bit32.band(v31.X, 262143) * 262144
										local v33 = (v322 + bit32.band(v31.Z, 262143)) * 131072
										local v34 = v21[v33 + bit32.band(v31.Y, 131071)]

										if v34 then
											for i2, v5 in ipairs(v34) do
												local v35

												if v ~= v5 and not v5._destroyed then
													local Position2 = v5._cframePhysics.Position
													local v37 = Position2 // 300
													local v38 = bit32.band(v37.X, 262143) * 262144
													local v39 = (v38 + bit32.band(v37.Z, 262143)) * 131072
													local v40 = t6[v39 + bit32.band(v37.Y, 131071)] or 0

													v35 = if v1 <= 5 then math.max(1, 10 - v40 / 10) else math.max(1, 20 - v40 / 10)

													if v5._pickupDelay + (v5._combineDelay - v5._pickupDelay) * v35 <= v7 - v5._timestamp and ((Position2 - Position).Magnitude <= v42 and v:Combine(v5)) then
														t[v5._id] = nil
														v2 = v2 - 1
														v5:Destroy()
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	local CurrentCamera = workspace.CurrentCamera
	local Position = CurrentCamera.CFrame.Position
	local v44 = math.tan(math.rad(CurrentCamera.FieldOfView) * 0.5) * 2 / CurrentCamera.ViewportSize.Y

	for k, v in pairs(t) do
		v:RenderParticles(Position, v44)
	end

	if not (#t4 > 0) then
		debug.profileend()

		return
	end

	Network.Fire("Orbs: Collect", t4)
	debug.profileend()
end)

local function ProcessCreate(p1) --[[ ProcessCreate | Line: 234 | Upvalues: Orbs (copy), Orb (copy), LocalPlayer (copy), CurrencyItem (copy), Types2 (copy), t (ref), v2 (ref) ]]
	local v1 = p1.config or {}

	if not v1.Type then
		v1.Type = Orbs.Types.Orb
	end

	local v22 = Orb.ComputeInitialCFrame(p1)

	if not v22 then
		return warn("[OrbCmds] No CFrame!", p1)
	end

	local Character = LocalPlayer.Character
	local v4 = Orb.ComputeInitialVelocity(v22, if Character and Character.PrimaryPart then Character:GetPivot() else nil, v1)
	local t2 = {}

	if p1.i then
		for i, v in ipairs(p1.i) do
			table.insert(t2, Types2.DecodeNetwork(v))
		end
	else
		assert(p1.ct and p1.ca, "Invalid orbConfig")

		local v7 = CurrencyItem(Orbs.OrbTypesInverse[p1.ct])

		table.insert(t2, v7:SetAmount(p1.ca))
	end

	local v8 = Orb.new(p1.id, p1.t, t2, v1, v22, v4, Orbs.OrbTypesInverse[p1.ct])
	local v9 = t[p1.id]

	t[p1.id] = v8

	if v9 then
		v9:Destroy()
	else
		v2 = v2 + 1
	end
end

Network.Fired("Orbs: Create"):Connect(function(p1) --[[ Line: 278 | Upvalues: v1 (copy), ProcessCreate (copy) ]]
	for i, v in ipairs(p1) do
		task.delay(v1:NextNumber(0, 0.1), ProcessCreate, v)
	end
end)
Network.Fired("Orbs: Clear"):Connect(function() --[[ Line: 284 | Upvalues: t (ref), v2 (ref) ]]
	local v1 = t

	t = {}
	v2 = 0

	for k, v in pairs(v1) do
		v:Destroy()
	end
end)

return {}