-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local FuncWrapper = require(ReplicatedStorage.Library.Modules.FuncWrapper)
local CallbackQueue = require(ReplicatedStorage.Library.Modules.CallbackQueue)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local t = {}

t.__index = t
t.__class = "WorkspaceRainbowParts"

local insert = table.insert
local remove = table.remove
local find = table.find
local fromHSV = Color3.fromHSV
local toHSV = Color3.toHSV
local v2 = Vector3.new
local v3 = typeof
local min = math.min
local clock = os.clock

local function getTargetColor(p1) --[[ getTargetColor | Line: 53 ]]
	local _ = p1:IsA("BasePart")

	return p1.Color
end

local function setTargetColor(p1, p2) --[[ setTargetColor | Line: 60 ]]
	local _ = p1:IsA("BasePart")

	p1.Color = p2
end

function t._build() --[[ _build | Line: 72 | Upvalues: t (copy), CallbackQueue (copy), FuncWrapper (copy), clock (copy) ]]
	local v2 = setmetatable({}, t)

	v2._activeParts = {}
	v2._currentHue = math.random()
	v2._streamCallbackQueue = CallbackQueue.new()
	v2._funcWrapper = FuncWrapper.CreateWrapper(v2)
	v2._startTime = clock()
	v2._progressTime = 0
	v2._batchIndex = 1
	v2:_init()

	return v2
end
function t._preRender(p1, p2) --[[ _preRender | Line: 91 | Upvalues: min (copy), clock (copy), v3 (copy), toHSV (copy), v2 (copy), fromHSV (copy) ]]
	local v1 = min(p2, 0.06666666666666667)

	p1._currentHue = (clock() - p1._startTime) * 0.5 % 1
	p1._progressTime = min(p1._progressTime + v1, 0.25)

	if p1._progressTime < 0.05 then
		return
	end

	debug.profilebegin("WorkspaceRainbowParts :: PreRender")
	p1._progressTime = p1._progressTime - 0.05

	local v22 = #p1._activeParts

	if not (v22 > 0) then
		debug.profileend()

		return
	end

	local _batchIndex = p1._batchIndex
	local v32 = min(_batchIndex + 50 - 1, v22)

	for i = _batchIndex, v32 do
		local v4 = p1._activeParts[i]

		if v4 and v4.Parent then
			local v5 = v4:GetAttribute("OriginalColor")

			if v3(v5) ~= "Vector3" then
				local v8, v9, v10 = toHSV(if v4:IsA("BasePart") then v4.Color else v4.Color)
				local v11 = v2(v8, v9, v10)

				v4:SetAttribute("OriginalColor", v11)
				v5 = v11
			end

			assert(v5, "luau")

			local Y = v5.Y
			local Z = v5.Z

			if Y <= 0.05 then
				Y = 1

				if Z >= 0.9725490196078431 then
					Z = 1
				end
			end

			local v12 = fromHSV(p1._currentHue % 1, Y, Z)

			if v4:IsA("BasePart") then
				v4.Color = v12

				continue
			end

			v4.Color = v12
		end
	end

	p1._batchIndex = v32 + 1

	if not (v22 < p1._batchIndex) then
		debug.profileend()

		return
	end

	p1._batchIndex = 1
	debug.profileend()
end
function t.Remove(p1, p2) --[[ Remove | Line: 143 | Upvalues: find (copy), v1 (copy), remove (copy), fromHSV (copy) ]]
	local v12 = find(p1._activeParts, p2)

	if not v12 then
		v1:AtWarning():Log((("Rainbow target %* not found in active targets."):format((p2:GetFullName()))))

		return
	end

	remove(p1._activeParts, v12)

	local v2 = p2:GetAttribute("OriginalColor")

	if v2 then
		local v3 = fromHSV(v2.X, v2.Y, v2.Z)
		local _ = p2:IsA("BasePart")

		p2.Color = v3
	end

	if not (p1._batchIndex > #p1._activeParts) then
		return
	end

	p1._batchIndex = 1
end
function t.Add(p1, p2) --[[ Add | Line: 161 | Upvalues: find (copy), v3 (copy), toHSV (copy), v2 (copy), insert (copy) ]]
	if find(p1._activeParts, p2) then
		return
	end

	if v3(p2:GetAttribute("OriginalColor")) ~= "Vector3" then
		local v32, v4, v5 = toHSV(if p2:IsA("BasePart") then p2.Color else p2.Color)

		p2:SetAttribute("OriginalColor", (v2(v32, v4, v5)))
	end

	insert(p1._activeParts, p2)
end
function t._init(p1) --[[ _init | Line: 175 | Upvalues: CollectionService (copy), ReplicatedStorage (copy), RunService (copy) ]]
	local v1 = CollectionService
	local v2 = ReplicatedStorage

	v1:GetInstanceAddedSignal("RainbowPart"):Connect(function(p12) --[[ Line: 179 | Upvalues: v2 (copy), p1 (copy) ]]
		if p12:IsDescendantOf(v2) then
			return
		end

		local v1 = p12:IsA("BasePart") or p12:IsA("SurfaceAppearance")

		assert(v1, (("RainbowPart tag requires a BasePart or SurfaceAppearance, got %*"):format(p12.ClassName)))
		p1._streamCallbackQueue:Add(function() --[[ Line: 189 | Upvalues: p1 (ref), p12 (copy) ]]
			p1:Add(p12)
		end)
	end)
	v1:GetInstanceRemovedSignal("RainbowPart"):Connect(function(p12) --[[ Line: 194 | Upvalues: p1 (copy) ]]
		local v1 = p12:IsA("BasePart") or p12:IsA("SurfaceAppearance")

		assert(v1, (("RainbowPart tag requires a BasePart or SurfaceAppearance, got %*"):format(p12.ClassName)))
		p1._streamCallbackQueue:Add(function() --[[ Line: 200 | Upvalues: p1 (ref), p12 (copy) ]]
			p1:Remove(p12)
		end)
	end)

	for i, v in ipairs(v1:GetTagged("RainbowPart")) do
		if not v:IsDescendantOf(v2) then
			local v3 = v:IsA("BasePart") or v:IsA("SurfaceAppearance")

			assert(v3, (("RainbowPart tag requires a BasePart or SurfaceAppearance, got %*"):format(v.ClassName)))
			p1:Add(v)
		end
	end

	RunService.PreRender:Connect(p1._funcWrapper(p1._preRender))
end
t._build()