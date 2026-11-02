-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

require(script.Types)

local Specials = require(script.Specials)
local EaseFuncs = require(script.EaseFuncs)
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local v1, v2, v3, v4, _, v5, v6, v7, v8, v9, v10, v11, v12, v13, _2, v14, v15, v16, v17, v18, v19

if not RunService:IsServer() then
	v1 = {}
	v1.__index = v1
	v2 = {
		Instance = true,
		boolean = true,
		string = true,
		["nil"] = true
	}
	v3 = {}
	v4 = function(p13, p23, p33) --[[ lerp | Line: 84 ]]
		if type(p13) ~= "number" then
			return p13:Lerp(p23, p33)
		end

		assert(type(p23) == "number", "lerp: Expected b to be a number, got " .. type(p23))

		return p13 + (p23 - p13) * p33
	end
	_ = function(p13) --[[ toPath | Line: 93 ]]
		return table.concat(p13.InstanceNames, ".")
	end
	v5 = function(p13, p23) --[[ resolveAnimPath | Line: 97 ]]
		if not p13 then
			return nil
		end

		local v1 = #p13.InstanceNames
		local v2 = p23 or game

		if pcall(function() --[[ Line: 105 | Upvalues: v1 (copy), p13 (copy), v2 (ref) ]]
			for i = 2, v1 do
				local v12 = p13.InstanceNames[i]
				local v22 = p13.InstanceTypes[i]
				local v3 = v2[v12]

				assert(typeof(v3) == "Instance", "resolveAnimPath: Expected " .. v12 .. " to be an Instance, got " .. typeof(v3))
				assert(if v3.ClassName == v22 then true else false, "resolveAnimPath: Expected instance of class " .. v22 .. " but got " .. v3.ClassName)
				v2 = v3
			end
		end) then
			return v2
		end

		warn("!! PATH RESOLVE FAILED:", table.concat(p13.InstanceNames, "."))

		return nil
	end
	v6 = function(p13) --[[ resolveJoints | Line: 131 ]]
		local t2 = {}

		for v1, v2 in p13:GetDescendants() do
			if v2:IsA("Motor6D") and v2.Active then
				local Part1 = v2.Part1
				local v3 = if Part1 then Part1.Name else Part1

				if v3 then
					t2[v3] = {
						Name = v3,
						Joint = v2,
						Children = {}
					}
				end
			end
		end

		for v4, v5 in t2 do
			local Part0 = v5.Joint.Part0

			if Part0 then
				local v6 = t2[Part0.Name]

				if v6 then
					v6.Children[v4] = v5
					v5.Parent = v6
				end
			end
		end

		return t2
	end
	v7 = function(p13) --[[ parseEase | Line: 169 ]]
		local Type = p13:FindFirstChild("Type")
		local Params = p13:FindFirstChild("Params")
		local t2 = {}

		t2.Type = assert(if Type and Type:IsA("StringValue") then Type.Value else nil, "")
		t2.Params = {}

		if Params then
			for v2, v3 in Params:GetChildren() do
				if v3:IsA("ValueBase") then
					t2.Params[v3.Name] = v3.Value
				end
			end
		end

		return t2
	end
	v8 = function(p13) --[[ parseEaseOld | Line: 193 ]]
		local Style = p13:FindFirstChild("Style")

		assert(if Style then Style:IsA("StringValue") else Style, "parseEaseOld: No style in legacy ease!")

		local Direction = p13:FindFirstChild("Direction")

		assert(if Direction then Direction:IsA("StringValue") else Direction, "parseEaseOld: No direction in legacy ease!")

		return {
			Type = Style.Value,
			Params = {
				Direction = Direction.Value
			}
		}
	end
	v9 = function(p13) --[[ readValue | Line: 208 ]]
		if not p13:IsA("ValueBase") then
			return p13:GetAttribute("Value")
		end

		local v2 = if tonumber(p13.Name) then assert(p13.Parent, "readValue: Expected a parent for numbered value") else p13
		local v4 = p13.Value
		local EnumType = v2:FindFirstChild("EnumType")

		if EnumType and EnumType:IsA("StringValue") then
			return Enum[EnumType.Value][v4]
		end

		if v2:FindFirstChild("Vector2") then
			return Vector2.new(v4.X, v4.Y)
		end

		if v2:FindFirstChild("ColorSequence") then
			return ColorSequence.new(v4)
		end

		if v2:FindFirstChild("NumberSequence") then
			return NumberSequence.new(v4)
		end

		if v2:FindFirstChild("NumberRange") then
			v4 = NumberRange.new(v4)
		end

		return v4
	end
	v10 = function(p13, p23, p33) --[[ getPropValue | Line: 236 | Upvalues: Specials (copy) ]]
		if p23 then
			local v1 = Specials.Get(p13._scratch, p23, p33)

			if v1 then
				local Get = v1.Get

				if Get then
					return pcall(Get, p23)
				end

				return true, v1.Default
			end
		end

		return pcall(function() --[[ Line: 251 | Upvalues: p23 (copy), p33 (copy) ]]
			return p23[p33]
		end)
	end
	v11 = function(p13, p23, p33, p43, p53) --[[ setPropValue | Line: 256 | Upvalues: Specials (copy) ]]
		if p23 then
			local v1 = Specials.Get(p13._scratch, p23, p33)

			if v1 then
				if v1.Get == nil and (p53 and p43 == true) then
					p43 = false
				end

				return pcall(v1.Set, p43)
			end
		end

		return pcall(function() --[[ Line: 273 | Upvalues: p23 (copy), p33 (copy), p43 (ref) ]]
			p23[p33] = p43
		end)
	end
	v12 = function(p13) --[[ parseKeyframePack | Line: 278 | Upvalues: v9 (copy), v7 (copy), v8 (copy) ]]
		local v2 = tonumber(p13.Name)

		assert(v2, "parseKeyframePack: Bad frame number")

		local Values = p13:FindFirstChild("Values")

		assert(Values, "parseKeyframePack: No value folder!")
		assert(Values:FindFirstChild("0"), "parseKeyframePack: No starting value!")

		local t2 = {}
		local v4 = 0

		for v5, v6 in Values:GetChildren() do
			local v82 = tonumber(v6.Name)

			if v82 then
				local ok, result = pcall(v9, v6)

				if ok then
					t2[v82] = result
					v4 = math.max(v82, v4)
				end
			end
		end

		local Eases = p13:FindFirstChild("Eases")
		local Ease = p13:FindFirstChild("Ease")
		local t22 = {}

		if Eases then
			for v10, v11 in Eases:GetChildren() do
				local v13 = tonumber(v11.Name)

				assert(v13, "parseKeyframePack: Bad index on ease at " .. v11:GetFullName())
				t22[v13] = v7(v11)
			end
		elseif Ease then
			t22[v4] = v8(Ease)
		end

		return {
			FrameIndex = v2,
			FrameCount = v4,
			Values = t2,
			Eases = t22
		}
	end
	v13 = function(p13, p23) --[[ unpackKeyframes | Line: 328 | Upvalues: v12 (copy) ]]
		local t2 = {}
		local t22 = {}
		local t3 = {}

		for v1, v2 in p13:GetChildren() do
			local v4 = tonumber(v2.Name)

			if v4 then
				t2[v4] = v12(v2)
				table.insert(t22, v4)
			end
		end

		table.sort(t22)

		for i = 2, #t22 do
			local v5 = t2[t22[i - 1]]
			local v6 = t2[t22[i]]

			v5.Next = v6
			v6.Prev = v5
		end

		local v7 = t2[t22[1]]

		while v7 do
			local FrameIndex = v7.FrameIndex
			local v8 = nil

			for j = 0, v7.FrameCount do
				local v9 = v7.Eases[j] or v8
				local v10 = v7.Values[j]

				if v10 ~= nil then
					if p23 then
						v10 = p23(v10)
					end

					table.insert(t3, {
						Time = FrameIndex + j,
						Value = v10,
						Ease = v9
					})

					if v9 then
						v8 = v9
					end
				end
			end

			v7 = v7.Next
		end

		return t3
	end
	_2 = function(p13, p23) --[[ readValueBase | Line: 386 ]]
		local v1 = p13:FindFirstChild(p23)

		assert(if v1 then v1:IsA("ValueBase") else v1, "readValueBase: Expected a ValueBase named " .. p23 .. " in " .. p13:GetFullName())

		return v1.Value
	end
	v14 = function(p13, p23, p33) --[[ compileItem | Line: 395 | Upvalues: v5 (copy), v6 (copy), v9 (copy), v13 (copy), Specials (copy) ]]
		local v1 = table.find(p13._data.Items, p23)

		if not v1 then
			return
		end

		local Path = p23.Path
		local v2 = p23.Override or v5(Path, p13._root)
		local v3 = p13._save:FindFirstChild((tostring(v1)))

		assert(v2, "compileItem: Target instance not found for path: " .. table.concat(Path.InstanceNames, "."))
		assert(v3, "compileItem: Frame not found for item with id " .. tostring(v1))

		local Rig = v3:FindFirstChild("Rig")
		local MarkerTrack = v3:FindFirstChild("MarkerTrack")

		if Rig and Path.ItemType == "Rig" then
			local v62 = v6(v2)

			for v7, v8 in Rig:GetChildren() do
				if v8.Name == "_joint" then
					local _hier = v8:FindFirstChild("_hier")
					local default = v8:FindFirstChild("default")
					local _keyframes = v8:FindFirstChild("_keyframes")

					if default then
						default = v9(default)
					end

					if _hier and _keyframes then
						local v92 = v9(_hier)
						local v10 = v92:gmatch("[^%.]+")
						local v11 = v62[v10()]

						while v11 do
							local Children = v11.Children
							local v122 = v10()

							if v122 == nil then
								break
							end

							if Children[v122] then
								v11 = Children[v122]
							else
								warn((("failed to resolve joint \'%*\' (could not find child \'%*\' in %*!)"):format(v92, v122, v11.Name)))
								v11 = nil
							end
						end

						if v11 then
							local Joint = v11.Joint

							p33[Joint] = {
								Props = {
									Transform = {
										Static = false,
										Default = CFrame.identity,
										Sequence = v13(_keyframes, function(p13) --[[ Line: 458 | Upvalues: default (ref) ]]
											return p13:Inverse() * default
										end)
									}
								},
								Target = Joint
							}
						else
							continue
						end
					end
				end
			end
		end

		local t2 = {}

		for v132, v14 in v3:GetChildren() do
			if v14:IsA("Folder") and (v14 ~= MarkerTrack and v14.Name ~= "Rig") then
				local default = v14:FindFirstChild("default")
				local v15 = v14.Name

				if default then
					default = v9(default)
				end

				t2[v15] = {
					Default = default,
					Static = Specials.Static(v2, v15),
					Sequence = v13(v14)
				}
			end
		end

		p33[v2] = {
			Props = t2,
			Target = v2
		}

		if not MarkerTrack then
			return
		end

		local t22 = {}

		p13._markers[v2] = t22

		for v17, v18 in MarkerTrack:GetChildren() do
			if v18:FindFirstChild("name") then
				local v21 = assert(tonumber(v18.Name), "compileItem: Expected marker name to be a number")
				local width = v18:FindFirstChild("width")

				assert(if width then width:IsA("ValueBase") else width, "readValueBase: Expected a ValueBase named " .. "width" .. " in " .. v18:GetFullName())

				local v24 = width.Value
				local name = v18:FindFirstChild("name")

				assert(if name then name:IsA("ValueBase") else name, "readValueBase: Expected a ValueBase named " .. "name" .. " in " .. v18:GetFullName())

				local v27 = name.Value
				local t3 = {}
				local KFMarkers = v18:FindFirstChild("KFMarkers")

				if KFMarkers then
					for v28, v29 in KFMarkers:GetChildren() do
						if v29:IsA("ValueBase") then
							local Val = v29:FindFirstChild("Val")

							assert(if Val then Val:IsA("ValueBase") else Val, "readValueBase: Expected a ValueBase named " .. "Val" .. " in " .. v29:GetFullName())
							t3[v29.Value] = Val.Value
						end
					end
				end

				local v33 = t22[v21]

				if not v33 then
					local t4 = {
						StartMarkers = {},
						EndMarkers = {}
					}

					t22[v21] = t4
					v33 = t4
				end

				if v24 > 0 then
					local v34 = math.min(v21 + v24, p13.Frames)
					local v35 = t22[v34]

					if not v35 then
						local t4 = {
							StartMarkers = {},
							EndMarkers = {}
						}

						t22[v34] = t4
						v35 = t4
					end

					v35.EndMarkers[v27] = t3
				end

				v33.StartMarkers[v27] = t3
			end
		end
	end
	v15 = function(p13) --[[ getInterpolator | Line: 556 | Upvalues: v2 (copy), v4 (copy) ]]
		if typeof(p13) == "ColorSequence" then
			return function(p13, p23, p33) --[[ Line: 558 ]]
				local v1 = p13.Keypoints[1].Value
				local v2 = p23.Keypoints[1].Value
				local v3

				if type(v1) == "number" then
					assert(type(v2) == "number", "lerp: Expected b to be a number, got " .. type(v2))
					v3 = v1 + (v2 - v1) * p33
				else
					v3 = v1:Lerp(v2, p33)
				end

				return ColorSequence.new(v3)
			end
		end

		if typeof(p13) == "NumberSequence" then
			return function(p13, p23, p33) --[[ Line: 563 ]]
				local v1 = p13.Keypoints[1].Value
				local v2 = p23.Keypoints[1].Value
				local v3

				if type(v1) == "number" then
					assert(type(v2) == "number", "lerp: Expected b to be a number, got " .. type(v2))
					v3 = v1 + (v2 - v1) * p33
				else
					v3 = v1:Lerp(v2, p33)
				end

				return NumberSequence.new(v3)
			end
		end

		if typeof(p13) == "NumberRange" then
			return function(p13, p23, p33) --[[ Line: 568 ]]
				local Min = p13.Min
				local Min2 = p23.Min
				local v1

				if type(Min) == "number" then
					assert(type(Min2) == "number", "lerp: Expected b to be a number, got " .. type(Min2))
					v1 = Min + (Min2 - Min) * p33
				else
					v1 = Min:Lerp(Min2, p33)
				end

				return NumberRange.new(v1)
			end
		end

		if v2[typeof(p13)] then
			return function(p13, p23, p33) --[[ Line: 573 ]]
				if p33 >= 1 then
					return p23
				end

				return p13
			end
		end

		return v4
	end
	v16 = function(p13, p23) --[[ compileFrames | Line: 585 | Upvalues: v15 (copy), EaseFuncs (copy) ]]
		local _buffer = p13._buffer

		for v1, v2 in p23 do
			local t2 = {}

			_buffer[v1] = t2

			for v3, v4 in v2.Props do
				if v4.Sequence[1] then
					local Default = v4.Default
					local v5 = v15(v4.Sequence[1].Value)
					local v6 = nil
					local v7 = 0

					for v8, v9 in v4.Sequence do
						if not t2[v9.Time] then
							t2[v9.Time] = {}
						end

						local v10 = v9.Time - v7

						t2[v9.Time][v3] = v9.Value

						if v10 <= 1 then
							Default = v9.Value
							v6 = v9.Ease
							v7 = v9.Time

							continue
						end

						if not v4.Static then
							local v11 = EaseFuncs.Get(v6)

							for i = 0, v10 do
								local v122 = v11(i / v10)
								local v13 = v7 + i

								if not t2[v13] then
									t2[v13] = {}
								end

								t2[v13][v3] = v5(Default, v9.Value, v122)
							end
						end

						v6 = v9.Ease
						Default = v9.Value
						v7 = v9.Time
					end

					if not v4.Static and v7 < p13.Frames then
						local v14 = t2[v7][v3]

						for j = v7, p13.FrameRate do
							if not t2[j] then
								t2[j] = {}
							end

							t2[j][v3] = v14
						end
					end
				end
			end
		end
	end
	v17 = function(p13) --[[ compileRouting | Line: 652 | Upvalues: v14 (copy), v16 (copy) ]]
		table.clear(p13._buffer)
		table.clear(p13._elements)
		table.clear(p13._markers)

		local t2 = {}

		for v1, v2 in p13._data.Items do
			v14(p13, v2, t2)
		end

		v16(p13, t2)
		p13._compiled = true
	end
	v18 = function(p13) --[[ restoreTrack | Line: 667 | Upvalues: v3 (copy), v11 (copy) ]]
		local v1 = v3[p13]

		if not v1 then
			return
		end

		if p13.RestoreDefaults then
			for v2, v32 in v1 do
				for v4, v5 in v32 do
					v11(p13, v2, v4, v5)
				end
			end
		end

		v3[p13] = nil
	end
	v19 = function(p13, p23) --[[ stepTrack | Line: 685 | Upvalues: v11 (copy) ]]
		local v2 = math.floor(p13.TimePosition * p13.FrameRate)
		local v4 = math.min(p23, 1 / p13.FrameRate)

		if p13.Frames < v2 then
			if not p13.Looped then
				p13._completed:Fire(Enum.PlaybackState.Completed)

				return true
			end

			p13.TimePosition = 0
			v2 = 0
		end

		for v6, v7 in p13._buffer do
			if p13._locks[v6] == nil then
				local v8 = v7[v2]

				if v8 then
					for v9, v10 in v8 do
						v11(p13, v6, v9, v10)
					end
				end
			end
		end

		for v112, v122 in p13._markers do
			local v13 = v122[v2]

			if v13 then
				for v14, v15 in v13.StartMarkers do
					if p13._markerSignals[v14] then
						p13._markerSignals[v14]:Fire(v112, v15)
					end
				end

				for v16, v17 in v13.EndMarkers do
					if p13._endMarkerSignals[v16] then
						p13._endMarkerSignals[v16]:Fire(v112, v17)
					end
				end
			end
		end

		p13.TimePosition = p13.TimePosition + v4

		return false
	end
	function t.CreatePlayer(p13, p23) --[[ CreatePlayer | Line: 738 | Upvalues: HttpService (copy), v1 (copy), v17 (copy) ]]
		local v12 = HttpService:JSONDecode(p13.Value)
		local v2 = Instance.new("BindableEvent")
		local v4 = setmetatable({
			RestoreDefaults = true,
			TimePosition = 0,
			_compiled = false,
			Completed = v2.Event,
			Looped = v12.Information.Looped,
			Frames = v12.Information.Length,
			FrameRate = v12.Information.FPS or 60,
			_save = p13,
			_data = v12,
			_completed = v2,
			_markers = {},
			_markerSignals = {},
			_endMarkerSignals = {},
			_locks = {},
			_elements = {},
			_buffer = {},
			_scratch = {},
			_root = p23
		}, v1)

		v17(v4)

		return v4
	end
	function v1.Destroy(p13) --[[ Destroy | Line: 772 ]]
		for v1, v2 in p13._markerSignals do
			v2:Destroy()
		end

		for v3, v4 in p13._endMarkerSignals do
			v4:Destroy()
		end

		p13._completed:Destroy()
		table.clear(p13._markerSignals)
		table.clear(p13._endMarkerSignals)
	end
	function v1.IsPlaying(p13) --[[ IsPlaying | Line: 786 | Upvalues: v3 (copy) ]]
		return v3[p13] ~= nil
	end
	function v1.GetTimeLength(p13) --[[ GetTimeLength | Line: 790 ]]
		return p13.Frames / p13.FrameRate
	end
	function v1.GetMarkerReachedSignal(p13, p23) --[[ GetMarkerReachedSignal | Line: 794 ]]
		if not p13._markerSignals[p23] then
			p13._markerSignals[p23] = Instance.new("BindableEvent")
		end

		return p13._markerSignals[p23].Event
	end
	function v1.GetMarkerEndedSignal(p13, p23) --[[ GetMarkerEndedSignal | Line: 802 ]]
		if not p13._endMarkerSignals[p23] then
			p13._endMarkerSignals[p23] = Instance.new("BindableEvent")
		end

		return p13._endMarkerSignals[p23].Event
	end
	function v1.GetSetting(p13, p23) --[[ GetSetting | Line: 810 ]]
		return p13._scratch[p23]
	end
	function v1.SetSetting(p13, p23, p33) --[[ SetSetting | Line: 814 ]]
		p13._scratch[p23] = p33
	end
	function v1.GetElements(p13) --[[ GetElements | Line: 818 ]]
		return table.clone(p13._elements)
	end
	function v1.LockElement(p13, p23, p33) --[[ LockElement | Line: 822 ]]
		if not p13._locks[p23] then
			p13._locks[p23] = {}
		end

		if not p33 then
			return true
		end

		p13._locks[p23][p33 or "Default"] = true

		return true
	end
	function v1.UnlockElement(p13, p23, p33) --[[ UnlockElement | Line: 834 ]]
		local v1 = p13._locks[p23]

		if not v1 then
			return true
		end

		v1[p33 or "Default"] = nil

		if next(v1) then
			return true
		end

		p13._locks[p23] = nil

		return true
	end
	function v1.IsElementLocked(p13, p23) --[[ IsElementLocked | Line: 848 ]]
		return p13._locks[p23] ~= nil
	end
	function v1.ReplaceElementByPath(p13, p23, p33) --[[ ReplaceElementByPath | Line: 852 | Upvalues: v17 (copy) ]]
		for v1, v2 in p13._data.Items do
			local Path = v2.Path
			local v3 = table.concat(Path.InstanceNames, ".")

			if p23:lower() == v3:lower() and (Path.ItemType == "Rig" or p33:IsA(Path.ItemType)) then
				v2.Override = p33
				v17(p13)

				return true
			end
		end

		return false
	end
	function v1.FindElement(p13, p23) --[[ FindElement | Line: 872 ]]
		for v1, v2 in p13._elements do
			if v2 and v2.Name == p23 then
				return v2
			end
		end

		return nil
	end
	function v1.FindElementOfType(p13, p23) --[[ FindElementOfType | Line: 882 ]]
		for v1, v2 in p13._elements do
			if v2 and v2:IsA(p23) then
				return v2
			end
		end

		return nil
	end
	function v1.Stop(p13) --[[ Stop | Line: 892 | Upvalues: v18 (copy) ]]
		p13.TimePosition = 0
		task.spawn(v18, p13)
		p13._completed:Fire(Enum.PlaybackState.Cancelled)
	end
	function v1.Reset(p13) --[[ Reset | Line: 898 | Upvalues: v19 (copy) ]]
		p13.TimePosition = 0
		v19(p13, 0)

		return true
	end
	function v1.Play(p13) --[[ Play | Line: 905 | Upvalues: v3 (copy), v10 (copy) ]]
		if v3[p13] then
			return
		end

		if p13.TimePosition >= p13:GetTimeLength() then
			p13.TimePosition = 0
		end

		local t2 = {}

		for v1, v2 in p13._buffer do
			if v2[0] then
				local t22 = {}

				t2[v1] = t22

				for v32 in v2[0] do
					local v4, v5 = v10(p13, v1, v32)

					if v4 then
						t22[v32] = v5
					end
				end
			end
		end

		v3[p13] = t2
		p13._completed:Fire(Enum.PlaybackState.Playing)
	end
	RunService:BindToRenderStep("__UPDATE_MOONLITE_TRACKS", Enum.RenderPriority.Camera.Value + 1, function(p13) --[[ Line: 935 | Upvalues: v3 (copy), v19 (copy), v18 (copy) ]]
		for v1 in v3 do
			if v19(v1, p13) then
				v18(v1)
			end
		end
	end)

	return t
end

warn("Moonlite should NOT be used on the server! Rig transforms will not be replicated.")
v1 = {}
v1.__index = v1
v2 = {
	Instance = true,
	boolean = true,
	string = true,
	["nil"] = true
}
v3 = {}
v4 = function(p13, p23, p33) --[[ lerp | Line: 84 ]]
	if type(p13) ~= "number" then
		return p13:Lerp(p23, p33)
	end

	assert(type(p23) == "number", "lerp: Expected b to be a number, got " .. type(p23))

	return p13 + (p23 - p13) * p33
end
_ = function(p13) --[[ toPath | Line: 93 ]]
	return table.concat(p13.InstanceNames, ".")
end
v5 = function(p13, p23) --[[ resolveAnimPath | Line: 97 ]]
	if not p13 then
		return nil
	end

	local v1 = #p13.InstanceNames
	local v2 = p23 or game

	if pcall(function() --[[ Line: 105 | Upvalues: v1 (copy), p13 (copy), v2 (ref) ]]
		for i = 2, v1 do
			local v12 = p13.InstanceNames[i]
			local v22 = p13.InstanceTypes[i]
			local v3 = v2[v12]

			assert(typeof(v3) == "Instance", "resolveAnimPath: Expected " .. v12 .. " to be an Instance, got " .. typeof(v3))
			assert(if v3.ClassName == v22 then true else false, "resolveAnimPath: Expected instance of class " .. v22 .. " but got " .. v3.ClassName)
			v2 = v3
		end
	end) then
		return v2
	end

	warn("!! PATH RESOLVE FAILED:", table.concat(p13.InstanceNames, "."))

	return nil
end
v6 = function(p13) --[[ resolveJoints | Line: 131 ]]
	local t2 = {}

	for v1, v2 in p13:GetDescendants() do
		if v2:IsA("Motor6D") and v2.Active then
			local Part1 = v2.Part1
			local v3 = if Part1 then Part1.Name else Part1

			if v3 then
				t2[v3] = {
					Name = v3,
					Joint = v2,
					Children = {}
				}
			end
		end
	end

	for v4, v5 in t2 do
		local Part0 = v5.Joint.Part0

		if Part0 then
			local v6 = t2[Part0.Name]

			if v6 then
				v6.Children[v4] = v5
				v5.Parent = v6
			end
		end
	end

	return t2
end
v7 = function(p13) --[[ parseEase | Line: 169 ]]
	local Type = p13:FindFirstChild("Type")
	local Params = p13:FindFirstChild("Params")
	local t2 = {}

	t2.Type = assert(if Type and Type:IsA("StringValue") then Type.Value else nil, "")
	t2.Params = {}

	if Params then
		for v2, v3 in Params:GetChildren() do
			if v3:IsA("ValueBase") then
				t2.Params[v3.Name] = v3.Value
			end
		end
	end

	return t2
end
v8 = function(p13) --[[ parseEaseOld | Line: 193 ]]
	local Style = p13:FindFirstChild("Style")

	assert(if Style then Style:IsA("StringValue") else Style, "parseEaseOld: No style in legacy ease!")

	local Direction = p13:FindFirstChild("Direction")

	assert(if Direction then Direction:IsA("StringValue") else Direction, "parseEaseOld: No direction in legacy ease!")

	return {
		Type = Style.Value,
		Params = {
			Direction = Direction.Value
		}
	}
end
v9 = function(p13) --[[ readValue | Line: 208 ]]
	if not p13:IsA("ValueBase") then
		return p13:GetAttribute("Value")
	end

	local v2 = if tonumber(p13.Name) then assert(p13.Parent, "readValue: Expected a parent for numbered value") else p13
	local v4 = p13.Value
	local EnumType = v2:FindFirstChild("EnumType")

	if EnumType and EnumType:IsA("StringValue") then
		return Enum[EnumType.Value][v4]
	end

	if v2:FindFirstChild("Vector2") then
		return Vector2.new(v4.X, v4.Y)
	end

	if v2:FindFirstChild("ColorSequence") then
		return ColorSequence.new(v4)
	end

	if v2:FindFirstChild("NumberSequence") then
		return NumberSequence.new(v4)
	end

	if v2:FindFirstChild("NumberRange") then
		v4 = NumberRange.new(v4)
	end

	return v4
end
v10 = function(p13, p23, p33) --[[ getPropValue | Line: 236 | Upvalues: Specials (copy) ]]
	if p23 then
		local v1 = Specials.Get(p13._scratch, p23, p33)

		if v1 then
			local Get = v1.Get

			if Get then
				return pcall(Get, p23)
			end

			return true, v1.Default
		end
	end

	return pcall(function() --[[ Line: 251 | Upvalues: p23 (copy), p33 (copy) ]]
		return p23[p33]
	end)
end
v11 = function(p13, p23, p33, p43, p53) --[[ setPropValue | Line: 256 | Upvalues: Specials (copy) ]]
	if p23 then
		local v1 = Specials.Get(p13._scratch, p23, p33)

		if v1 then
			if v1.Get == nil and (p53 and p43 == true) then
				p43 = false
			end

			return pcall(v1.Set, p43)
		end
	end

	return pcall(function() --[[ Line: 273 | Upvalues: p23 (copy), p33 (copy), p43 (ref) ]]
		p23[p33] = p43
	end)
end
v12 = function(p13) --[[ parseKeyframePack | Line: 278 | Upvalues: v9 (copy), v7 (copy), v8 (copy) ]]
	local v2 = tonumber(p13.Name)

	assert(v2, "parseKeyframePack: Bad frame number")

	local Values = p13:FindFirstChild("Values")

	assert(Values, "parseKeyframePack: No value folder!")
	assert(Values:FindFirstChild("0"), "parseKeyframePack: No starting value!")

	local t2 = {}
	local v4 = 0

	for v5, v6 in Values:GetChildren() do
		local v82 = tonumber(v6.Name)

		if v82 then
			local ok, result = pcall(v9, v6)

			if ok then
				t2[v82] = result
				v4 = math.max(v82, v4)
			end
		end
	end

	local Eases = p13:FindFirstChild("Eases")
	local Ease = p13:FindFirstChild("Ease")
	local t22 = {}

	if Eases then
		for v10, v11 in Eases:GetChildren() do
			local v13 = tonumber(v11.Name)

			assert(v13, "parseKeyframePack: Bad index on ease at " .. v11:GetFullName())
			t22[v13] = v7(v11)
		end
	elseif Ease then
		t22[v4] = v8(Ease)
	end

	return {
		FrameIndex = v2,
		FrameCount = v4,
		Values = t2,
		Eases = t22
	}
end
v13 = function(p13, p23) --[[ unpackKeyframes | Line: 328 | Upvalues: v12 (copy) ]]
	local t2 = {}
	local t22 = {}
	local t3 = {}

	for v1, v2 in p13:GetChildren() do
		local v4 = tonumber(v2.Name)

		if v4 then
			t2[v4] = v12(v2)
			table.insert(t22, v4)
		end
	end

	table.sort(t22)

	for i = 2, #t22 do
		local v5 = t2[t22[i - 1]]
		local v6 = t2[t22[i]]

		v5.Next = v6
		v6.Prev = v5
	end

	local v7 = t2[t22[1]]

	while v7 do
		local FrameIndex = v7.FrameIndex
		local v8 = nil

		for j = 0, v7.FrameCount do
			local v9 = v7.Eases[j] or v8
			local v10 = v7.Values[j]

			if v10 ~= nil then
				if p23 then
					v10 = p23(v10)
				end

				table.insert(t3, {
					Time = FrameIndex + j,
					Value = v10,
					Ease = v9
				})

				if v9 then
					v8 = v9
				end
			end
		end

		v7 = v7.Next
	end

	return t3
end
_2 = function(p13, p23) --[[ readValueBase | Line: 386 ]]
	local v1 = p13:FindFirstChild(p23)

	assert(if v1 then v1:IsA("ValueBase") else v1, "readValueBase: Expected a ValueBase named " .. p23 .. " in " .. p13:GetFullName())

	return v1.Value
end
v14 = function(p13, p23, p33) --[[ compileItem | Line: 395 | Upvalues: v5 (copy), v6 (copy), v9 (copy), v13 (copy), Specials (copy) ]]
	local v1 = table.find(p13._data.Items, p23)

	if not v1 then
		return
	end

	local Path = p23.Path
	local v2 = p23.Override or v5(Path, p13._root)
	local v3 = p13._save:FindFirstChild((tostring(v1)))

	assert(v2, "compileItem: Target instance not found for path: " .. table.concat(Path.InstanceNames, "."))
	assert(v3, "compileItem: Frame not found for item with id " .. tostring(v1))

	local Rig = v3:FindFirstChild("Rig")
	local MarkerTrack = v3:FindFirstChild("MarkerTrack")

	if Rig and Path.ItemType == "Rig" then
		local v62 = v6(v2)

		for v7, v8 in Rig:GetChildren() do
			if v8.Name == "_joint" then
				local _hier = v8:FindFirstChild("_hier")
				local default = v8:FindFirstChild("default")
				local _keyframes = v8:FindFirstChild("_keyframes")

				if default then
					default = v9(default)
				end

				if _hier and _keyframes then
					local v92 = v9(_hier)
					local v10 = v92:gmatch("[^%.]+")
					local v11 = v62[v10()]

					while v11 do
						local Children = v11.Children
						local v122 = v10()

						if v122 == nil then
							break
						end

						if Children[v122] then
							v11 = Children[v122]
						else
							warn((("failed to resolve joint \'%*\' (could not find child \'%*\' in %*!)"):format(v92, v122, v11.Name)))
							v11 = nil
						end
					end

					if v11 then
						local Joint = v11.Joint

						p33[Joint] = {
							Props = {
								Transform = {
									Static = false,
									Default = CFrame.identity,
									Sequence = v13(_keyframes, function(p13) --[[ Line: 458 | Upvalues: default (ref) ]]
										return p13:Inverse() * default
									end)
								}
							},
							Target = Joint
						}
					else
						continue
					end
				end
			end
		end
	end

	local t2 = {}

	for v132, v14 in v3:GetChildren() do
		if v14:IsA("Folder") and (v14 ~= MarkerTrack and v14.Name ~= "Rig") then
			local default = v14:FindFirstChild("default")
			local v15 = v14.Name

			if default then
				default = v9(default)
			end

			t2[v15] = {
				Default = default,
				Static = Specials.Static(v2, v15),
				Sequence = v13(v14)
			}
		end
	end

	p33[v2] = {
		Props = t2,
		Target = v2
	}

	if not MarkerTrack then
		return
	end

	local t22 = {}

	p13._markers[v2] = t22

	for v17, v18 in MarkerTrack:GetChildren() do
		if v18:FindFirstChild("name") then
			local v21 = assert(tonumber(v18.Name), "compileItem: Expected marker name to be a number")
			local width = v18:FindFirstChild("width")

			assert(if width then width:IsA("ValueBase") else width, "readValueBase: Expected a ValueBase named " .. "width" .. " in " .. v18:GetFullName())

			local v24 = width.Value
			local name = v18:FindFirstChild("name")

			assert(if name then name:IsA("ValueBase") else name, "readValueBase: Expected a ValueBase named " .. "name" .. " in " .. v18:GetFullName())

			local v27 = name.Value
			local t3 = {}
			local KFMarkers = v18:FindFirstChild("KFMarkers")

			if KFMarkers then
				for v28, v29 in KFMarkers:GetChildren() do
					if v29:IsA("ValueBase") then
						local Val = v29:FindFirstChild("Val")

						assert(if Val then Val:IsA("ValueBase") else Val, "readValueBase: Expected a ValueBase named " .. "Val" .. " in " .. v29:GetFullName())
						t3[v29.Value] = Val.Value
					end
				end
			end

			local v33 = t22[v21]

			if not v33 then
				local t4 = {
					StartMarkers = {},
					EndMarkers = {}
				}

				t22[v21] = t4
				v33 = t4
			end

			if v24 > 0 then
				local v34 = math.min(v21 + v24, p13.Frames)
				local v35 = t22[v34]

				if not v35 then
					local t4 = {
						StartMarkers = {},
						EndMarkers = {}
					}

					t22[v34] = t4
					v35 = t4
				end

				v35.EndMarkers[v27] = t3
			end

			v33.StartMarkers[v27] = t3
		end
	end
end
v15 = function(p13) --[[ getInterpolator | Line: 556 | Upvalues: v2 (copy), v4 (copy) ]]
	if typeof(p13) == "ColorSequence" then
		return function(p13, p23, p33) --[[ Line: 558 ]]
			local v1 = p13.Keypoints[1].Value
			local v2 = p23.Keypoints[1].Value
			local v3

			if type(v1) == "number" then
				assert(type(v2) == "number", "lerp: Expected b to be a number, got " .. type(v2))
				v3 = v1 + (v2 - v1) * p33
			else
				v3 = v1:Lerp(v2, p33)
			end

			return ColorSequence.new(v3)
		end
	end

	if typeof(p13) == "NumberSequence" then
		return function(p13, p23, p33) --[[ Line: 563 ]]
			local v1 = p13.Keypoints[1].Value
			local v2 = p23.Keypoints[1].Value
			local v3

			if type(v1) == "number" then
				assert(type(v2) == "number", "lerp: Expected b to be a number, got " .. type(v2))
				v3 = v1 + (v2 - v1) * p33
			else
				v3 = v1:Lerp(v2, p33)
			end

			return NumberSequence.new(v3)
		end
	end

	if typeof(p13) == "NumberRange" then
		return function(p13, p23, p33) --[[ Line: 568 ]]
			local Min = p13.Min
			local Min2 = p23.Min
			local v1

			if type(Min) == "number" then
				assert(type(Min2) == "number", "lerp: Expected b to be a number, got " .. type(Min2))
				v1 = Min + (Min2 - Min) * p33
			else
				v1 = Min:Lerp(Min2, p33)
			end

			return NumberRange.new(v1)
		end
	end

	if v2[typeof(p13)] then
		return function(p13, p23, p33) --[[ Line: 573 ]]
			if p33 >= 1 then
				return p23
			end

			return p13
		end
	end

	return v4
end
v16 = function(p13, p23) --[[ compileFrames | Line: 585 | Upvalues: v15 (copy), EaseFuncs (copy) ]]
	local _buffer = p13._buffer

	for v1, v2 in p23 do
		local t2 = {}

		_buffer[v1] = t2

		for v3, v4 in v2.Props do
			if v4.Sequence[1] then
				local Default = v4.Default
				local v5 = v15(v4.Sequence[1].Value)
				local v6 = nil
				local v7 = 0

				for v8, v9 in v4.Sequence do
					if not t2[v9.Time] then
						t2[v9.Time] = {}
					end

					local v10 = v9.Time - v7

					t2[v9.Time][v3] = v9.Value

					if v10 <= 1 then
						Default = v9.Value
						v6 = v9.Ease
						v7 = v9.Time

						continue
					end

					if not v4.Static then
						local v11 = EaseFuncs.Get(v6)

						for i = 0, v10 do
							local v122 = v11(i / v10)
							local v13 = v7 + i

							if not t2[v13] then
								t2[v13] = {}
							end

							t2[v13][v3] = v5(Default, v9.Value, v122)
						end
					end

					v6 = v9.Ease
					Default = v9.Value
					v7 = v9.Time
				end

				if not v4.Static and v7 < p13.Frames then
					local v14 = t2[v7][v3]

					for j = v7, p13.FrameRate do
						if not t2[j] then
							t2[j] = {}
						end

						t2[j][v3] = v14
					end
				end
			end
		end
	end
end
v17 = function(p13) --[[ compileRouting | Line: 652 | Upvalues: v14 (copy), v16 (copy) ]]
	table.clear(p13._buffer)
	table.clear(p13._elements)
	table.clear(p13._markers)

	local t2 = {}

	for v1, v2 in p13._data.Items do
		v14(p13, v2, t2)
	end

	v16(p13, t2)
	p13._compiled = true
end
v18 = function(p13) --[[ restoreTrack | Line: 667 | Upvalues: v3 (copy), v11 (copy) ]]
	local v1 = v3[p13]

	if not v1 then
		return
	end

	if p13.RestoreDefaults then
		for v2, v32 in v1 do
			for v4, v5 in v32 do
				v11(p13, v2, v4, v5)
			end
		end
	end

	v3[p13] = nil
end
v19 = function(p13, p23) --[[ stepTrack | Line: 685 | Upvalues: v11 (copy) ]]
	local v2 = math.floor(p13.TimePosition * p13.FrameRate)
	local v4 = math.min(p23, 1 / p13.FrameRate)

	if p13.Frames < v2 then
		if not p13.Looped then
			p13._completed:Fire(Enum.PlaybackState.Completed)

			return true
		end

		p13.TimePosition = 0
		v2 = 0
	end

	for v6, v7 in p13._buffer do
		if p13._locks[v6] == nil then
			local v8 = v7[v2]

			if v8 then
				for v9, v10 in v8 do
					v11(p13, v6, v9, v10)
				end
			end
		end
	end

	for v112, v122 in p13._markers do
		local v13 = v122[v2]

		if v13 then
			for v14, v15 in v13.StartMarkers do
				if p13._markerSignals[v14] then
					p13._markerSignals[v14]:Fire(v112, v15)
				end
			end

			for v16, v17 in v13.EndMarkers do
				if p13._endMarkerSignals[v16] then
					p13._endMarkerSignals[v16]:Fire(v112, v17)
				end
			end
		end
	end

	p13.TimePosition = p13.TimePosition + v4

	return false
end
function t.CreatePlayer(p13, p23) --[[ CreatePlayer | Line: 738 | Upvalues: HttpService (copy), v1 (copy), v17 (copy) ]]
	local v12 = HttpService:JSONDecode(p13.Value)
	local v2 = Instance.new("BindableEvent")
	local v4 = setmetatable({
		RestoreDefaults = true,
		TimePosition = 0,
		_compiled = false,
		Completed = v2.Event,
		Looped = v12.Information.Looped,
		Frames = v12.Information.Length,
		FrameRate = v12.Information.FPS or 60,
		_save = p13,
		_data = v12,
		_completed = v2,
		_markers = {},
		_markerSignals = {},
		_endMarkerSignals = {},
		_locks = {},
		_elements = {},
		_buffer = {},
		_scratch = {},
		_root = p23
	}, v1)

	v17(v4)

	return v4
end
function v1.Destroy(p13) --[[ Destroy | Line: 772 ]]
	for v1, v2 in p13._markerSignals do
		v2:Destroy()
	end

	for v3, v4 in p13._endMarkerSignals do
		v4:Destroy()
	end

	p13._completed:Destroy()
	table.clear(p13._markerSignals)
	table.clear(p13._endMarkerSignals)
end
function v1.IsPlaying(p13) --[[ IsPlaying | Line: 786 | Upvalues: v3 (copy) ]]
	return v3[p13] ~= nil
end
function v1.GetTimeLength(p13) --[[ GetTimeLength | Line: 790 ]]
	return p13.Frames / p13.FrameRate
end
function v1.GetMarkerReachedSignal(p13, p23) --[[ GetMarkerReachedSignal | Line: 794 ]]
	if not p13._markerSignals[p23] then
		p13._markerSignals[p23] = Instance.new("BindableEvent")
	end

	return p13._markerSignals[p23].Event
end
function v1.GetMarkerEndedSignal(p13, p23) --[[ GetMarkerEndedSignal | Line: 802 ]]
	if not p13._endMarkerSignals[p23] then
		p13._endMarkerSignals[p23] = Instance.new("BindableEvent")
	end

	return p13._endMarkerSignals[p23].Event
end
function v1.GetSetting(p13, p23) --[[ GetSetting | Line: 810 ]]
	return p13._scratch[p23]
end
function v1.SetSetting(p13, p23, p33) --[[ SetSetting | Line: 814 ]]
	p13._scratch[p23] = p33
end
function v1.GetElements(p13) --[[ GetElements | Line: 818 ]]
	return table.clone(p13._elements)
end
function v1.LockElement(p13, p23, p33) --[[ LockElement | Line: 822 ]]
	if not p13._locks[p23] then
		p13._locks[p23] = {}
	end

	if not p33 then
		return true
	end

	p13._locks[p23][p33 or "Default"] = true

	return true
end
function v1.UnlockElement(p13, p23, p33) --[[ UnlockElement | Line: 834 ]]
	local v1 = p13._locks[p23]

	if not v1 then
		return true
	end

	v1[p33 or "Default"] = nil

	if next(v1) then
		return true
	end

	p13._locks[p23] = nil

	return true
end
function v1.IsElementLocked(p13, p23) --[[ IsElementLocked | Line: 848 ]]
	return p13._locks[p23] ~= nil
end
function v1.ReplaceElementByPath(p13, p23, p33) --[[ ReplaceElementByPath | Line: 852 | Upvalues: v17 (copy) ]]
	for v1, v2 in p13._data.Items do
		local Path = v2.Path
		local v3 = table.concat(Path.InstanceNames, ".")

		if p23:lower() == v3:lower() and (Path.ItemType == "Rig" or p33:IsA(Path.ItemType)) then
			v2.Override = p33
			v17(p13)

			return true
		end
	end

	return false
end
function v1.FindElement(p13, p23) --[[ FindElement | Line: 872 ]]
	for v1, v2 in p13._elements do
		if v2 and v2.Name == p23 then
			return v2
		end
	end

	return nil
end
function v1.FindElementOfType(p13, p23) --[[ FindElementOfType | Line: 882 ]]
	for v1, v2 in p13._elements do
		if v2 and v2:IsA(p23) then
			return v2
		end
	end

	return nil
end
function v1.Stop(p13) --[[ Stop | Line: 892 | Upvalues: v18 (copy) ]]
	p13.TimePosition = 0
	task.spawn(v18, p13)
	p13._completed:Fire(Enum.PlaybackState.Cancelled)
end
function v1.Reset(p13) --[[ Reset | Line: 898 | Upvalues: v19 (copy) ]]
	p13.TimePosition = 0
	v19(p13, 0)

	return true
end
function v1.Play(p13) --[[ Play | Line: 905 | Upvalues: v3 (copy), v10 (copy) ]]
	if v3[p13] then
		return
	end

	if p13.TimePosition >= p13:GetTimeLength() then
		p13.TimePosition = 0
	end

	local t2 = {}

	for v1, v2 in p13._buffer do
		if v2[0] then
			local t22 = {}

			t2[v1] = t22

			for v32 in v2[0] do
				local v4, v5 = v10(p13, v1, v32)

				if v4 then
					t22[v32] = v5
				end
			end
		end
	end

	v3[p13] = t2
	p13._completed:Fire(Enum.PlaybackState.Playing)
end
RunService:BindToRenderStep("__UPDATE_MOONLITE_TRACKS", Enum.RenderPriority.Camera.Value + 1, function(p13) --[[ Line: 935 | Upvalues: v3 (copy), v19 (copy), v18 (copy) ]]
	for v1 in v3 do
		if v19(v1, p13) then
			v18(v1)
		end
	end
end)

return t