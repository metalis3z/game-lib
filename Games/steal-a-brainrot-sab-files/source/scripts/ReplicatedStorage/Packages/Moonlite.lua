
local t1 = {}

require(script.Types)

local Specials = require(script.Specials)
local EaseFuncs = require(script.EaseFuncs)
local RunService = game:GetService("RunService")

game:GetService("HttpService")

if RunService:IsServer() and RunService:IsStudio() then
	warn("Moonlite should NOT be used on the server! Rig transforms will not be replicated.")
end

local t2 = {}

t2.__index = t2

local t3 = {
	Instance = true,
	boolean = true,
	string = true,
	["nil"] = true
}
local t4 = {}

local function lerp(p1, p2, n1: number)
	if type(p1) == "number" then
		return (math.lerp(p1, p2, n1))
	end

	return p1:Lerp(p2, n1)
end
local function deepCopy(p3)
	local t5 = {}

	for k, v in next, p3 do
		t5[if type(k) ~= "table" then k else deepCopy(k)] = if type(v) ~= "table" then v else deepCopy(v)
	end

	return t5
end
local function toPath(p4)
	return table.concat(p4.InstanceNames, ".")
end
local function resolveAnimPath(p5, p6)
	if not p5 then
		return nil
	end

	local v40 = #p5.InstanceNames
	local u41 = p6 or game
	local ok, result = pcall(function()
		for i = 2, v40 do
			local v297 = p5.InstanceNames[i]
			local v298 = p5.InstanceTypes[i]

			if v297 == "CoreGui" then
				p5.InstanceNames[i] = "ReplicatedStorage"
				p5.InstanceTypes[i] = "ReplicatedStorage"
				v297 = p5.InstanceNames[i]
				v298 = p5.InstanceTypes[i]
			end

			local v299 = u41:FindFirstChild(v297)

			assert(typeof(v299) == "Instance")
			assert(v298 == v299.ClassName)
			u41 = v299
		end
	end)

	if ok then
		return u41
	end

	warn("!! PATH RESOLVE FAILED:", table.concat(p5.InstanceNames, "."), "\n", result)

	return nil
end
local function resolveJoints(p7)
	local t6 = {}
	local t7 = {}

	for _, v48 in p7:GetDescendants() do
		if v48:IsA("Motor6D") and v48.Active then
			local Part1 = v48.Part1
			local v50 = Part1 and Part1.Name

			if v50 then
				t6[v50] = {
					Name = v50,
					Joint = v48,
					Children = {}
				}
			end
		elseif v48:IsA("Bone") then
			local Name = v48.Name

			t6[Name] = {
				Name = Name,
				Joint = v48,
				Children = {}
			}
		end
	end

	for v52, v53 in t6 do
		local Joint = v53.Joint

		if Joint:IsA("Motor6D") then
			local JointPart0 = Joint.Part0

			if JointPart0 then
				local v56 = t6[JointPart0.Name]

				if v56 then
					v56.Children[v52] = v53
					v53.Parent = v56
				end
			end
		elseif Joint:IsA("Bone") then
			local JointParent = Joint.Parent

			if JointParent then
				local v58 = t6[JointParent.Name]

				if v58 then
					v58.Children[v52] = v53
					v53.Parent = v58
				end
			end
		end
	end

	for _, v60 in t6 do
		local Name = v60.Name
		local Parent = v60.Parent

		while Parent do
			Name = `{ Parent.Name }.{ Name }`
			Parent = Parent.Parent
		end

		t7[Name] = v60
	end

	return t7
end
local function parseEase(p8)
	local Type = p8:FindFirstChild("Type")
	local Params = p8:FindFirstChild("Params")
	local t8 = {
		Type = assert(if not Type or not Type:IsA("StringValue") then nil else Type.Value),
		Params = {}
	}

	if Params then
		for _, v68 in Params:GetChildren() do
			if v68:IsA("ValueBase") then
				local Value = v68.Value

				t8.Params[v68.Name] = Value
			end
		end
	end

	return t8
end
local function parseEaseOld(p9)
	local Style = p9:FindFirstChild("Style")

	assert(Style and Style:IsA("StringValue"), "No style in legacy ease!")

	local Direction = p9:FindFirstChild("Direction")

	assert(Direction and Direction:IsA("StringValue"), "No direction in legacy ease!")

	return {
		Type = Style.Value,
		Params = {
			Direction = Direction.Value
		}
	}
end
local function readValue(p10)
	if p10:IsA("ValueBase") then
		local v74 = if not tonumber(p10.Name) then p10 else assert(p10.Parent)
		local p10Value = p10.Value
		local EnumType = v74:FindFirstChild("EnumType")

		if EnumType and EnumType:IsA("StringValue") then
			return Enum[EnumType.Value][p10Value]
		end

		if v74:FindFirstChild("Vector2") then
			return (Vector2.new(p10Value.X, p10Value.Y))
		end

		if v74:FindFirstChild("ColorSequence") then
			return (ColorSequence.new(p10Value))
		end

		if v74:FindFirstChild("NumberSequence") then
			return (NumberSequence.new(p10Value))
		end

		if v74:FindFirstChild("NumberRange") then
			p10Value = NumberRange.new(p10Value)
		end

		return p10Value
	end

	return p10:GetAttribute("Value")
end
local function getPropValue(p11, p12, s1: string)
	if p12 then
		local v80 = Specials.Get(p11._scratch, p12, s1)

		if v80 then
			local Get = v80.Get

			if Get then
				return pcall(Get, p12)
			end

			return true, v80.Default
		end
	end

	return pcall(function()
		return p12[s1]
	end)
end
local function setPropValue(p13, p14, s2: string, p15, b1: boolean?)
	if p14 then
		local v88 = Specials.Get(p13._scratch, p14, s2)

		if v88 then
			if v88.Get == nil and b1 and p15 == true then
				p15 = false
			end

			return pcall(v88.Set, p15)
		end
	end

	return pcall(function()
		p14[s2] = p15
	end)
end
local function parseKeyframePack(p16)
	local num = tonumber(p16.Name)

	assert(num, "Bad frame number")

	local Values = p16:FindFirstChild("Values")

	assert(Values, "No value folder!")
	assert(Values:FindFirstChild("0"), "No starting value!")

	local t9 = {}
	local n2 = 0

	for _, v95 in Values:GetChildren() do
		local num2 = tonumber(v95.Name)

		if num2 then
			local ok, result = pcall(readValue, v95)

			if ok then
				t9[num2] = result
				n2 = math.max(num2, n2)
			end
		end
	end

	local Eases = p16:FindFirstChild("Eases")
	local Ease = p16:FindFirstChild("Ease")
	local t10 = {}

	if Eases then
		for _, v103 in Eases:GetChildren() do
			local num3 = tonumber(v103.Name)

			assert(num3, `Bad index on ease @{ v103:GetFullName() }`)
			t10[num3] = parseEase(v103)
		end
	elseif Ease then
		t10[n2] = parseEaseOld(Ease)
	end

	return {
		FrameIndex = num,
		FrameCount = n2,
		Values = t9,
		Eases = t10
	}
end
local function unpackKeyframes(p17, p18: ((...any) -> ...any)?)
	local t11 = {}
	local t12 = {}
	local t13 = {}

	for _, v111 in p17:GetChildren() do
		local num = tonumber(v111.Name)

		if num then
			t11[num] = parseKeyframePack(v111)
			table.insert(t12, num)
		end
	end

	table.sort(t12)

	for i = 2, #t12 do
		local v114 = t11[t12[i - 1]]
		local v115 = t11[t12[i]]

		v114.Next = v115
		v115.Prev = v114
	end

	local v116 = t11[t12[1]]

	while v116 do
		local FrameIndex = v116.FrameIndex
		local v118 = nil

		for i = 0, v116.FrameCount do
			local v120 = v116.Eases[i] or v118
			local v121 = v116.Values[i]

			if v121 ~= nil then
				if p18 then
					v121 = p18(v121)
				end

				table.insert(t13, {
					Time = FrameIndex + i,
					Value = v121,
					Ease = v120
				})

				if v120 then
					v118 = v120
				end
			end
		end

		v116 = v116.Next
	end

	return t13
end
local function compileItem(p19, p20, p21)
	assert(p19._data and p19._save, "This track is already compiled from source")

	local v128 = table.find(p19._data.Items, p20)

	if not v128 then
		return
	end

	local Path = p20.Path
	local ItemType = Path.ItemType
	local v131 = p20.Override or resolveAnimPath(Path, p19._root)
	local v132 = p19._save:FindFirstChild((tostring(v128)))

	if not v131 or not v132 then
		return
	end

	assert(v131)
	assert(v132)

	local Rig = v132:FindFirstChild("Rig")
	local MarkerTrack = v132:FindFirstChild("MarkerTrack")

	if Rig and ItemType == "Rig" then
		local v135 = resolveJoints(v131)

		for _, v137 in Rig:GetChildren() do
			if v137.Name == "_joint" then
				local _hier = v137:FindFirstChild("_hier")
				local default = v137:FindFirstChild("default")
				local _keyframes = v137:FindFirstChild("_keyframes")

				if default then
					default = readValue(default)
				end

				if _hier and _keyframes then
					local v141 = v135[readValue(_hier)]

					if v141 then
						local Joint = v141.Joint

						p21[Joint] = {
							Props = {
								Transform = {
									Default = CFrame.identity,
									Sequence = if not Joint:IsA("Motor6D") then unpackKeyframes(_keyframes, function(cFrame: CFrame)
										return cFrame
									end) else unpackKeyframes(_keyframes, function(cFrame: CFrame)
										return cFrame:Inverse() * default
									end)
								}
							},
							Target = Joint
						}
					end
				end
			end
		end
	end

	local t14 = {}

	for _, v145 in v132:GetChildren() do
		if v145:IsA("Folder") and v145 ~= MarkerTrack and v145.Name ~= "Rig" then
			local default = v145:FindFirstChild("default")
			local Name = v145.Name

			if default then
				default = readValue(default)
			end

			local v148 = Specials.Static(v131, Name)

			t14[Name] = {
				Default = default,
				Static = if v148 ~= false then v148 else nil,
				Sequence = unpackKeyframes(v145)
			}
		end
	end

	p21[v131] = {
		Props = t14,
		Target = v131
	}

	if MarkerTrack then
		local t15 = {}

		p19._markers[v131] = t15

		for _, v151 in MarkerTrack:GetChildren() do
			if v151:FindFirstChild("name") then
				local v152 = assert((tonumber(v151.Name)))
				local width = v151:FindFirstChild("width")

				assert(width and width:IsA("ValueBase"))

				local widthValue = width.Value
				local name = v151:FindFirstChild("name")

				assert(name and name:IsA("ValueBase"))

				local nameValue = name.Value
				local t16 = {}
				local KFMarkers = v151:FindFirstChild("KFMarkers")

				if KFMarkers then
					for _, v160 in KFMarkers:GetChildren() do
						if v160:IsA("ValueBase") then
							local Value = v160.Value
							local Val = v160:FindFirstChild("Val")

							assert(Val and Val:IsA("ValueBase"))
							t16[Value] = Val.Value
						end
					end
				end

				local v163 = t15[v152]

				if not v163 then
					v163 = {
						StartMarkers = {},
						EndMarkers = {}
					}
					t15[v152] = v163
				end

				if widthValue > 0 then
					local v164 = math.min(v152 + widthValue, p19.Frames)
					local v165 = t15[v164]

					if not v165 then
						v165 = {
							StartMarkers = {},
							EndMarkers = {}
						}
						t15[v164] = v165
					end

					v165.EndMarkers[nameValue] = t16
				end

				v163.StartMarkers[nameValue] = t16
			end
		end
	end
end
local function getInterpolator(p22)
	if typeof(p22) == "ColorSequence" then
		return function(p23, p24, n3: number)
			local Value = p23.Keypoints[1].Value
			local Value2 = p24.Keypoints[1].Value
			local v307 = if type(Value) ~= "number" then Value:Lerp(Value2, n3) else math.lerp(Value, Value2, n3)

			return ColorSequence.new(v307)
		end
	end

	if typeof(p22) == "NumberSequence" then
		return function(p25, p26, n4: number)
			local Value = p25.Keypoints[1].Value
			local Value3 = p26.Keypoints[1].Value
			local v313 = if type(Value) ~= "number" then Value:Lerp(Value3, n4) else math.lerp(Value, Value3, n4)

			return NumberSequence.new(v313)
		end
	end

	if typeof(p22) == "NumberRange" then
		return function(numberRange: NumberRange, numberRange2: NumberRange, n5: number)
			local Min = numberRange.Min
			local Min2 = numberRange2.Min
			local v319 = if type(Min) ~= "number" then Min:Lerp(Min2, n5) else math.lerp(Min, Min2, n5)

			return NumberRange.new(v319)
		end
	end

	if t3[typeof(p22)] then
		return function(p27, p28, n6: number)
			if n6 >= 1 then
				return p28
			end

			return p27
		end
	end

	return lerp
end
local function compileFrames(p29, p30)
	local _buffer = p29._buffer
	local _elements = p29._elements

	for v171, v172 in p30 do
		local t17 = {}

		_buffer[v171] = t17
		table.insert(_elements, v171)

		for v174, v175 in v172.Props do
			if v175.Sequence[1] then
				local Ease = nil
				local n7 = 0
				local Default = v175.Default
				local v179 = getInterpolator(v175.Sequence[1].Value)

				for _, v181 in v175.Sequence do
					if not t17[v181.Time] then
						t17[v181.Time] = {}
					end

					local v182 = v181.Time - n7

					t17[v181.Time][v174] = v181.Value

					if v182 <= 1 then
						Default = v181.Value
						Ease = v181.Ease
						n7 = v181.Time
					else
						if not v175.Static then
							local v183 = EaseFuncs.Get(Ease)

							for i = 0, v182 do
								local v185 = v183(i / v182)
								local v186 = n7 + i

								if not t17[v186] then
									t17[v186] = {}
								end

								t17[v186][v174] = v179(Default, v181.Value, v185)
							end
						end

						Ease = v181.Ease
						Default = v181.Value
						n7 = v181.Time
					end
				end

				if not v175.Static and n7 < p29.Frames then
					local v187 = t17[n7][v174]

					for i = n7, p29.Frames do
						if not t17[i] then
							t17[i] = {}
						end

						t17[i][v174] = v187
					end
				end
			end
		end
	end
end
local function compileRouting(p31)
	assert(p31._data and p31._save, "This track is already compiled from source")
	table.clear(p31._buffer)
	table.clear(p31._elements)
	table.clear(p31._markers)

	local t18 = {}

	for _, v192 in p31._data.Items do
		compileItem(p31, v192, t18)
	end

	compileFrames(p31, t18)
	p31._compiled = true
end
local function restoreTrack(p32)
	local v194 = t4[p32]

	if not v194 then
		return
	end

	if p32.RestoreDefaults then
		for v195, v196 in v194 do
			for v197, v198 in v196 do
				setPropValue(p32, v195, v197, v198)
			end
		end

		setPropValue(p32, workspace.CurrentCamera, "AttachToPart", nil)
		setPropValue(p32, workspace.CurrentCamera, "LookAtPart", nil)
	end

	table.clear(p32._lastSteppedFrames)
	t4[p32] = nil
end
local function stepTrack(p33, n8: number)
	local v201 = math.floor(p33.TimePosition * p33.FrameRate)

	if v201 > p33.Frames then
		if not p33.Looped then
			p33._completed:Fire(Enum.PlaybackState.Completed)

			return true
		end

		v201 = 0
		p33.TimePosition = 0
		p33.CurrentFrame = 0
		table.clear(p33._lastSteppedFrames)
		p33._onLoop:Fire()
	end

	for i = p33.CurrentFrame, v201 do
		for v203, v204 in p33._buffer do
			if p33._locks[v203] == nil then
				local v205 = v204[i] or p33._lastSteppedFrames[v203]

				if v205 then
					p33._lastSteppedFrames[v203] = v205

					for v206, v207 in v205 do
						setPropValue(p33, v203, v206, v207)
					end
				end
			end
		end

		for v208, v209 in p33._markers do
			local v210 = v209[i]

			if v210 then
				for v211, v212 in v210.StartMarkers do
					if p33._markerSignals[v211] then
						p33._markerSignals[v211]:Fire(v208, v212)
					end
				end

				for v213, v214 in v210.EndMarkers do
					if p33._endMarkerSignals[v213] then
						p33._endMarkerSignals[v213]:Fire(v208, v214)
					end
				end
			end
		end
	end

	p33.CurrentFrame = v201
	p33.TimePosition = p33.TimePosition + n8

	return false
end

function t1.CreatePlayer(t19: {[any]: any}, p34)
	local BindableEvent = Instance.new("BindableEvent")
	local BindableEvent2 = Instance.new("BindableEvent")
	local v219 = deepCopy(t19)

	return (setmetatable({
		RestoreDefaults = true,
		TimePosition = 0,
		CurrentFrame = 0,
		_compiled = false,
		Completed = BindableEvent.Event,
		OnLoop = BindableEvent2.Event,
		Looped = v219.Information.Looped,
		Frames = v219.Information.Length,
		FrameRate = v219.Information.FPS or 60,
		_moduleInfo = v219,
		_completed = BindableEvent,
		_onLoop = BindableEvent2,
		_markers = {},
		_markerSignals = {},
		_endMarkerSignals = {},
		_locks = {},
		_elements = {},
		_buffer = {},
		_lastSteppedFrames = {},
		_scratch = {},
		_root = p34
	}, t2))
end
function t2.Compile(p35)
	if p35._save then
		compileRouting(p35)

		return p35
	end

	if p35._moduleInfo then
		local t20 = {}

		for v222, v223 in p35._moduleInfo.Compiled do
			local v224 = v223.Path or v222
			local v225 = v223.Override or resolveAnimPath(v224, p35._root)

			if v225 then
				for _, v227 in v223.Props do
					local Default = v227.Default

					if type(Default) == "table" and type(Default.ItemType) == "string" then
						Default = Default.Override or resolveAnimPath(Default, p35._root)
					end

					v227.Default = Default

					for _, v230 in v227.Sequence do
						local Value = v230.Value

						if type(Value) == "table" and type(Value.ItemType) == "string" then
							Value = Value.Override or resolveAnimPath(Value, p35._root)
						end

						v230.Value = Value
					end
				end

				t20[v225] = v223
			end
		end

		compileFrames(p35, t20)
		p35._compiled = true
	end

	return p35
end
function t2.Destroy(p36)
	for _, v234 in p36._markerSignals do
		v234:Destroy()
	end

	for _, v236 in p36._endMarkerSignals do
		v236:Destroy()
	end

	p36._completed:Destroy()
	table.clear(p36._markerSignals)
	table.clear(p36._endMarkerSignals)
end
function t2.IsPlaying(p37)
	return t4[p37] ~= nil
end
function t2.GetTimeLength(p38)
	return p38.Frames / p38.FrameRate
end
function t2.GetMarkerReachedSignal(p39, s3: string)
	if not p39._markerSignals[s3] then
		p39._markerSignals[s3] = Instance.new("BindableEvent")
	end

	return p39._markerSignals[s3].Event
end
function t2.GetMarkerEndedSignal(p40, s4: string)
	if not p40._endMarkerSignals[s4] then
		p40._endMarkerSignals[s4] = Instance.new("BindableEvent")
	end

	return p40._endMarkerSignals[s4].Event
end
function t2.GetSetting(p41, s5: string)
	return p41._scratch[s5]
end
function t2.SetSetting(p42, s6: string, p43)
	p42._scratch[s6] = p43
end
function t2.GetElements(p44)
	return table.clone(p44._elements)
end
function t2.LockElement(p45, p46, p47)
	if not p45._locks[p46] then
		p45._locks[p46] = {}
	end

	if p47 then
		p45._locks[p46][p47 or "Default"] = true
	end

	return true
end
function t2.UnlockElement(p48, p49, p50)
	local v255 = p48._locks[p49]

	if v255 then
		v255[p50 or "Default"] = nil

		if not next(v255) then
			p48._locks[p49] = nil
		end
	end

	return true
end
function t2.IsElementLocked(p51, p52)
	return p51._locks[p52] ~= nil
end
function t2.ReplaceElementByPath(p53, s7: string, p54)
	local v261 = string.lower(s7)

	if p53._data then
		for _, v263 in p53._data.Items do
			local Path = v263.Path

			if v261 == string.lower(toPath(Path)) and (Path.ItemType == "Rig" or p54:IsA(Path.ItemType)) then
				v263.Override = p54

				return true
			end
		end
	elseif p53._moduleInfo then
		local v265 = false

		for v266, v267 in p53._moduleInfo.Compiled do
			local v268 = v267.Path or v266
			local ItemType = v268.ItemType

			if v261 == string.lower(toPath(v268)) and (ItemType == "Rig" or p54:IsA(v268.ItemType)) then
				v267.Override = p54
				v265 = true
			end

			for _, v271 in v267.Props do
				local Default = v271.Default

				if type(Default) == "table" and type(Default.ItemType) == "string" and v261 == string.lower(toPath(Default)) and (Default.ItemType == "Rig" or p54:IsA(Default.ItemType)) then
					v267.Override = p54
					v265 = true
				end

				for _, v274 in v271.Sequence do
					local Value = v274.Value

					if type(Value) == "table" and type(Value.ItemType) == "string" and v261 == string.lower(toPath(Value)) and (Value.ItemType == "Rig" or p54:IsA(Value.ItemType)) then
						v267.Override = p54
						v265 = true
					end
				end
			end
		end

		return v265
	end

	return false
end
function t2.FindElement(p55, s8: string)
	for _, v279 in p55._elements do
		if v279 and s8 == v279.Name then
			return v279
		end
	end

	return nil
end
function t2.FindElementOfType(p56, s9: string)
	for _, v283 in p56._elements do
		if v283 and v283:IsA(s9) then
			return v283
		end
	end

	return nil
end
function t2.Stop(p57)
	p57.TimePosition = 0
	p57.CurrentFrame = 0
	table.clear(p57._lastSteppedFrames)
	task.spawn(restoreTrack, p57)
	p57._completed:Fire(Enum.PlaybackState.Cancelled)
end
function t2.Reset(p58)
	p58.TimePosition = 0
	p58.CurrentFrame = 0
	stepTrack(p58, 0)

	return true
end
function t2.Play(p59)
	assert(p59._compiled, "Track is not compiled.")

	if t4[p59] then
		return
	end

	if p59.TimePosition >= p59:GetTimeLength() then
		p59.TimePosition = 0
		p59.CurrentFrame = 0
	end

	table.clear(p59._lastSteppedFrames)

	local t21 = {}

	for v288, v289 in p59._buffer do
		if v289[0] then
			local t22 = {}

			t21[v288] = t22

			for v291 in v289[0] do
				local v292, v293 = getPropValue(p59, v288, v291)

				if v292 then
					t22[v291] = v293
				end
			end
		end
	end

	t4[p59] = t21
	p59._completed:Fire(Enum.PlaybackState.Playing)
end

RunService.PreSimulation:Connect(function(p60)
	debug.profilebegin("Moonlite:stepTracks")

	for v295 in t4 do
		if stepTrack(v295, p60) then
			restoreTrack(v295)
		end
	end

	debug.profileend()
end)

function t1.instanceToMoonAnimPath(p61)
	if not p61:IsDescendantOf(game) then
		error("Instance is not descendant of game")
	end

	local t23 = {}
	local t24 = {}
	local v37 = p61

	while v37 ~= game do
		table.insert(t23, 1, v37.Name)
		table.insert(t24, 1, v37.ClassName)
		v37 = v37.Parent
	end

	table.insert(t23, 1, "game")
	table.insert(t24, 1, "DataModel")

	return {
		InstanceTypes = t24,
		ItemType = p61.ClassName,
		InstanceNames = t23
	}
end

t1.resolveAnimPath = resolveAnimPath
t1.toPathString = toPath

return t1
