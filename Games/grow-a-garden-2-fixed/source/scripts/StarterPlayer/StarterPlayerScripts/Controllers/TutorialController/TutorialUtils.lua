--credit to quartz games studio
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local v1 = assert(LocalPlayer)
local TutorialUI = v1.PlayerGui:WaitForChild("TutorialUI")
local Pointer = TutorialUI:WaitForChild("Pointer")
local Focus = TutorialUI:WaitForChild("Focus")

local function createTween(p1, p2, p3, p4) --[[ createTween | Line: 19 | Upvalues: TweenService (copy) ]]
	local v2 = TweenService:Create(p1, p2, p3)

	v2.Completed:Once(function() --[[ Line: 28 | Upvalues: v2 (copy) ]]
		v2:Destroy()
	end)

	if if p4 == false then false else true then
		v2:Play()
	end

	return v2
end

local v2 = 0
local v3 = nil

local function getFullScreenFocus() --[[ getFullScreenFocus | Line: 42 ]]
	local ViewportSize = workspace.CurrentCamera.ViewportSize

	return UDim2.fromOffset(ViewportSize.X * 0.5, ViewportSize.Y * 0.5), UDim2.fromOffset(ViewportSize.X * 2, ViewportSize.Y * 2)
end

local function focusObject(p1) --[[ focusObject | Line: 48 | Upvalues: Focus (copy), v2 (ref), v3 (ref), createTween (copy), RunService (copy) ]]
	local Visible = Focus.Visible

	v2 = v2 + 1

	local v1 = v2

	local function getTarget() --[[ getTarget | Line: 53 | Upvalues: p1 (copy) ]]
		if type(p1) ~= "function" then
			local AbsoluteSize = p1.AbsoluteSize

			return p1.AbsolutePosition + AbsoluteSize * 0.5, AbsoluteSize
		end

		local v2 = p1()

		if v2 == nil then
			return nil, nil
		end

		return v2.Position + v2.Size * 0.5, v2.Size
	end

	if not Visible then
		local ViewportSize = workspace.CurrentCamera.ViewportSize
		local v22 = UDim2.fromOffset(ViewportSize.X * 0.5, ViewportSize.Y * 0.5)
		local v32 = UDim2.fromOffset(ViewportSize.X * 2, ViewportSize.Y * 2)

		Focus.Position = v22
		Focus.Size = v32
		Focus.UIStroke.Transparency = 0.3
	end

	Focus.Visible = true

	if v3 then
		v3:Cancel()
	end

	local v4, v5

	if type(p1) == "function" then
		local v6 = p1()

		if v6 == nil then
			v4 = nil
			v5 = nil
		else
			v4 = v6.Position + v6.Size * 0.5
			v5 = v6.Size
		end
	else
		local AbsoluteSize = p1.AbsoluteSize

		v4 = p1.AbsolutePosition + AbsoluteSize * 0.5
		v5 = AbsoluteSize
	end

	if v4 and v5 then
		v3 = createTween(Focus, TweenInfo.new(if Visible then 0.25 else 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Position = UDim2.fromOffset(v4.X, v4.Y),
			Size = UDim2.fromOffset(v5.X, v5.Y)
		})
	end

	local v11 = RunService.PreRender:Connect(function() --[[ Line: 90 | Upvalues: v3 (ref), p1 (copy), Focus (ref) ]]
		if v3 and v3.PlaybackState == Enum.PlaybackState.Playing then
			return
		end

		local v2, v32

		if type(p1) == "function" then
			local v4 = p1()

			if v4 == nil then
				v2 = nil
				v32 = nil
			else
				v2 = v4.Position + v4.Size * 0.5
				v32 = v4.Size
			end
		else
			local AbsoluteSize = p1.AbsoluteSize

			v2 = p1.AbsolutePosition + AbsoluteSize * 0.5
			v32 = AbsoluteSize
		end

		if v2 and v32 then
			Focus.Position = UDim2.fromOffset(v2.X, v2.Y)
			Focus.Size = UDim2.fromOffset(v32.X, v32.Y)
		end
	end)

	return function(p1) --[[ Line: 102 | Upvalues: v11 (copy), v3 (ref), createTween (ref), Focus (ref), v2 (ref), v1 (copy) ]]
		if not v11.Connected then
			return
		end

		v11:Disconnect()

		local v12, v22, v32

		if not v3 then
			local v4

			v12 = workspace.CurrentCamera.ViewportSize
			v22 = UDim2.fromOffset(v12.X * 0.5, v12.Y * 0.5)
			v32 = UDim2.fromOffset(v12.X * 2, v12.Y * 2)
			v3 = createTween(Focus, TweenInfo.new(p1 or 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Position = v22,
				Size = v32
			})
			v4 = v3
			assert(v3).Completed:Once(function() --[[ Line: 120 | Upvalues: v2 (ref), v1 (ref), Focus (ref) ]]
				if v2 ~= v1 then
					return
				end

				Focus.Visible = false
			end)

			return
		end

		v3:Cancel()
		v12 = workspace.CurrentCamera.ViewportSize
		v22 = UDim2.fromOffset(v12.X * 0.5, v12.Y * 0.5)
		v32 = UDim2.fromOffset(v12.X * 2, v12.Y * 2)
		v3 = createTween(Focus, TweenInfo.new(p1 or 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Position = v22,
			Size = v32
		})
		assert(v3).Completed:Once(function() --[[ Line: 120 | Upvalues: v2 (ref), v1 (ref), Focus (ref) ]]
			if v2 ~= v1 then
				return
			end

			Focus.Visible = false
		end)
	end
end

local function createArrow(p1, p2, p3) --[[ createArrow | Line: 128 | Upvalues: HttpService (copy), RunService (copy), TweenService (copy) ]]
	HttpService:GenerateGUID(false)

	local v1 = p3 or 10
	local v2 = script.Arrow:Clone()

	v2.CFrame = p2
	v2.Parent = workspace

	local v3 = v2:FindFirstChildWhichIsA("Beam")
	local v4 = if v3 then v3.Width0 else 0
	local v5 = if v3 then v3.Width1 else 0
	local v6 = false

	local function onCharacterAdded(p1) --[[ onCharacterAdded | Line: 141 | Upvalues: v2 (copy) ]]
		local HumanoidRootPart = p1:WaitForChild("HumanoidRootPart")

		if typeof(HumanoidRootPart) ~= "Instance" or not HumanoidRootPart:IsA("BasePart") then
			return
		end

		local RootAttachment = HumanoidRootPart:WaitForChild("RootAttachment")

		if typeof(RootAttachment) == "Instance" and RootAttachment:IsA("Attachment") then
			v2.Beam.Attachment1 = RootAttachment
		end
	end

	local v7 = p1.CharacterAdded:Connect(onCharacterAdded)

	if p1.Character then
		task.spawn(onCharacterAdded, p1.Character)
	end

	local v8 = RunService.PreRender:Connect(function() --[[ Line: 160 | Upvalues: v3 (copy), p1 (copy), v2 (copy), v1 (copy), v6 (ref), TweenService (ref), v4 (copy), v5 (copy) ]]
		if not v3 then
			return
		end

		local v12 = p1:DistanceFromCharacter(v2.Position)
		local v22 = if v12 > 0 then v12 <= v1 else false

		if v22 == v6 then
			return
		end

		v6 = v22

		if v22 then
			TweenService:Create(v3, TweenInfo.new(0.3), {
				Width0 = 0,
				Width1 = 0
			}):Play()
		else
			TweenService:Create(v3, TweenInfo.new(0.3), {
				Width0 = v4,
				Width1 = v5
			}):Play()
		end
	end)

	return table.freeze({
		move = function(p1) --[[ move | Line: 178 | Upvalues: v2 (copy) ]]
			v2.CFrame = p1
		end,
		destroy = function() --[[ destroy | Line: 182 | Upvalues: v8 (copy), v7 (copy), v2 (copy) ]]
			v8:Disconnect()
			v7:Disconnect()
			v2:Destroy()
		end
	})
end

local function waitUntilDistance(p1, p2) --[[ waitUntilDistance | Line: 190 | Upvalues: v1 (copy) ]]
	while not (v1.Character and v1:DistanceFromCharacter(p1()) <= p2) do
		task.wait(0.1)
	end
end

function observeTag(p1, p2, p3) --[[ observeTag | Line: 249 | Upvalues: CollectionService (copy) ]]
	local t = {}
	local t2 = {}
	local v1 = nil

	local function isGoodAncestor(p1) --[[ isGoodAncestor | Line: 256 | Upvalues: p3 (copy) ]]
		if p3 == nil then
			return true
		end

		for v1, v2 in p3 do
			if p1:IsDescendantOf(v2) then
				return true
			end
		end

		return false
	end

	local function attemptStartup(p1) --[[ attemptStartup | Line: 270 | Upvalues: t (copy), p2 (copy) ]]
		t[p1] = "__inflight__"
		task.defer(function() --[[ Line: 275 | Upvalues: t (ref), p1 (copy), p2 (ref) ]]
			if t[p1] ~= "__inflight__" then
				return
			end

			local ok, result = xpcall(function(p13) --[[ Line: 281 | Upvalues: p2 (ref) ]]
				local v1 = p2(p13)

				if v1 ~= nil then
					assert(typeof(v1) == "function", "callback must return a function or nil")
				end

				return v1
			end, debug.traceback, p1)

			if ok then
				if t[p1] == "__inflight__" then
					t[p1] = result
				elseif result ~= nil then
					task.spawn(result)
				end
			else
				local v12 = string.split(result, "\n")[1]
				local v2 = string.find(v12, ": ")

				if not v2 then
					return
				end

				v12:sub(v2 + 1)
			end
		end)
	end

	local function attemptCleanup(p1) --[[ attemptCleanup | Line: 312 | Upvalues: t (copy) ]]
		local v1 = t[p1]

		t[p1] = "__dead__"

		if typeof(v1) ~= "function" then
			return
		end

		task.spawn(v1)
	end

	local function onAncestryChanged(p1) --[[ onAncestryChanged | Line: 321 | Upvalues: p3 (copy), t (copy), p2 (copy) ]]
		local v1

		if p3 == nil then
			v1 = true
		else
			v1 = false

			for v2, v3 in p3 do
				if p1:IsDescendantOf(v3) then
					v1 = true

					break
				end
			end
		end

		if v1 then
			if t[p1] == "__dead__" then
				t[p1] = "__inflight__"
				task.defer(function() --[[ Line: 275 | Upvalues: t (ref), p1 (copy), p2 (ref) ]]
					if t[p1] ~= "__inflight__" then
						return
					end

					local ok, result = xpcall(function(p13) --[[ Line: 281 | Upvalues: p2 (ref) ]]
						local v1 = p2(p13)

						if v1 ~= nil then
							assert(typeof(v1) == "function", "callback must return a function or nil")
						end

						return v1
					end, debug.traceback, p1)

					if ok then
						if t[p1] == "__inflight__" then
							t[p1] = result
						elseif result ~= nil then
							task.spawn(result)
						end
					else
						local v12 = string.split(result, "\n")[1]
						local v2 = string.find(v12, ": ")

						if not v2 then
							return
						end

						v12:sub(v2 + 1)
					end
				end)
			end
		else
			local v4 = t[p1]

			t[p1] = "__dead__"

			if typeof(v4) ~= "function" then
				return
			end

			task.spawn(v4)
		end
	end

	local function onInstanceAdded(p1) --[[ onInstanceAdded | Line: 331 | Upvalues: v1 (ref), t (copy), t2 (copy), p3 (copy), p2 (copy) ]]
		if not v1.Connected then
			return
		end

		if t[p1] ~= nil then
			return
		end

		t[p1] = "__dead__"
		t2[p1] = p1.AncestryChanged:Connect(function() --[[ Line: 341 | Upvalues: p1 (copy), p3 (ref), t (ref), p2 (ref) ]]
			local v1 = p1
			local v2

			if p3 == nil then
				v2 = true
			else
				v2 = false

				for v3, v4 in p3 do
					if v1:IsDescendantOf(v4) then
						v2 = true

						break
					end
				end
			end

			if v2 then
				if t[v1] == "__dead__" then
					t[v1] = "__inflight__"
					task.defer(function() --[[ Line: 275 | Upvalues: t (ref), v1 (copy), p2 (ref) ]]
						if t[v1] ~= "__inflight__" then
							return
						end

						local ok, result = xpcall(function(p13) --[[ Line: 281 | Upvalues: p2 (ref) ]]
							local v1 = p2(p13)

							if v1 ~= nil then
								assert(typeof(v1) == "function", "callback must return a function or nil")
							end

							return v1
						end, debug.traceback, v1)

						if ok then
							if t[v1] == "__inflight__" then
								t[v1] = result
							elseif result ~= nil then
								task.spawn(result)
							end
						else
							local v12 = string.split(result, "\n")[1]
							local v2 = string.find(v12, ": ")

							if not v2 then
								return
							end

							v12:sub(v2 + 1)
						end
					end)
				end
			else
				local v5 = t[v1]

				t[v1] = "__dead__"

				if typeof(v5) ~= "function" then
					return
				end

				task.spawn(v5)
			end
		end)

		local v12

		if p3 == nil then
			v12 = true
		else
			v12 = false

			for v2, v3 in p3 do
				if p1:IsDescendantOf(v3) then
					v12 = true

					break
				end
			end
		end

		if v12 then
			if t[p1] == "__dead__" then
				t[p1] = "__inflight__"
				task.defer(function() --[[ Line: 275 | Upvalues: t (ref), p1 (copy), p2 (ref) ]]
					if t[p1] ~= "__inflight__" then
						return
					end

					local ok, result = xpcall(function(p13) --[[ Line: 281 | Upvalues: p2 (ref) ]]
						local v1 = p2(p13)

						if v1 ~= nil then
							assert(typeof(v1) == "function", "callback must return a function or nil")
						end

						return v1
					end, debug.traceback, p1)

					if ok then
						if t[p1] == "__inflight__" then
							t[p1] = result
						elseif result ~= nil then
							task.spawn(result)
						end
					else
						local v12 = string.split(result, "\n")[1]
						local v2 = string.find(v12, ": ")

						if not v2 then
							return
						end

						v12:sub(v2 + 1)
					end
				end)
			end
		else
			local v4 = t[p1]

			t[p1] = "__dead__"

			if typeof(v4) ~= "function" then
				return
			end

			task.spawn(v4)
		end
	end

	local function onInstanceRemoved(p1) --[[ onInstanceRemoved | Line: 347 | Upvalues: t (copy), t2 (copy) ]]
		local v1 = t[p1]

		t[p1] = "__dead__"

		if typeof(v1) == "function" then
			task.spawn(v1)
		end

		local v2 = t2[p1]

		if v2 then
			v2:Disconnect()
			t2[p1] = nil
		end

		t[p1] = nil
	end

	v1 = CollectionService:GetInstanceAddedSignal(p1):Connect(onInstanceAdded)

	local v2 = CollectionService:GetInstanceRemovedSignal(p1):Connect(onInstanceRemoved)

	task.defer(function() --[[ Line: 364 | Upvalues: v1 (ref), CollectionService (ref), p1 (copy), onInstanceAdded (copy) ]]
		if not v1.Connected then
			return
		end

		for v12, v2 in CollectionService:GetTagged(p1) do
			task.spawn(onInstanceAdded, v2)
		end
	end)

	return function() --[[ Line: 375 | Upvalues: v1 (ref), v2 (ref), t (copy), t2 (copy) ]]
		v1:Disconnect()
		v2:Disconnect()

		local v12 = next(t)

		while v12 do
			local v22 = t[v12]

			t[v12] = "__dead__"

			if typeof(v22) == "function" then
				task.spawn(v22)
			end

			local v3 = t2[v12]

			if v3 then
				v3:Disconnect()
				t2[v12] = nil
			end

			t[v12] = nil
			v12 = next(t)
		end
	end
end

local Gardens = workspace:WaitForChild("Gardens")

local function getPlayerPlot() --[[ getPlayerPlot | Line: 390 | Upvalues: v1 (copy), Gardens (copy) ]]
	local v12 = v1:GetAttribute("PlotId")

	if not v12 then
		return nil
	end

	local v2 = Gardens:FindFirstChild((("Plot%*"):format(v12)))

	if v2 and v2:IsA("Model") then
		return v2
	end

	return nil
end

local FruitProxyUtil = require(game.ReplicatedStorage.SharedModules.FruitProxyUtil)

local function getTools() --[[ getTools | Line: 404 | Upvalues: v1 (copy), FruitProxyUtil (copy) ]]
	local t = {}

	for v12, v2 in v1.Backpack:GetChildren() do
		if v2:IsA("Tool") or FruitProxyUtil.IsFruitProxy(v2) then
			table.insert(t, v2)
		end
	end

	local Character = v1.Character

	if Character then
		local v3 = Character:FindFirstChildWhichIsA("Tool")

		if v3 then
			table.insert(t, v3)
		end
	end

	return t
end

local function isSeedTool(p1) --[[ isSeedTool | Line: 422 ]]
	if p1:GetAttribute("SeedTool") then
		return true
	end

	return string.find(p1.Name, "Seed") and true or false
end

local function hasSeed() --[[ hasSeed | Line: 432 | Upvalues: getTools (copy) ]]
	for v1, v2 in getTools() do
		if if v2:GetAttribute("SeedTool") then true else string.find(v2.Name, "Seed") and true or false then
			return true
		end
	end

	return false
end

local function waitForSeed() --[[ waitForSeed | Line: 441 | Upvalues: getTools (copy), v1 (copy) ]]
	local v12 = false

	for v2, v3 in getTools() do
		if if v3:GetAttribute("SeedTool") then true else string.find(v3.Name, "Seed") and true or false then
			v12 = true

			break
		end
	end

	if v12 then
		return
	end

	local v5 = false
	local v6 = nil

	v6 = v1.Backpack.ChildAdded:Connect(function(p1) --[[ Line: 448 | Upvalues: v5 (ref), v6 (ref) ]]
		if not p1:IsA("Tool") then
			return
		end

		if not (if p1:GetAttribute("SeedTool") then true else string.find(p1.Name, "Seed") and true or false) then
			return
		end

		v5 = true

		if not v6 then
			return
		end

		v6:Disconnect()
		v6 = nil
	end)

	while not v5 do
		local v7 = false

		for v8, v9 in getTools() do
			if if v9:GetAttribute("SeedTool") then true elseif string.find(v9.Name, "Seed") then true else false then
				v7 = true

				break
			end
		end

		if v7 then
			v5 = true

			break
		end

		task.wait(0.2)
	end

	if not v6 then
		return
	end

	v6:Disconnect()
	v6 = nil
end

local function waitUntilSeedEquipped() --[[ waitUntilSeedEquipped | Line: 472 | Upvalues: v1 (copy) ]]
	while true do
		local Character = v1.Character
		local v12 = if Character then Character:FindFirstChildWhichIsA("Tool") else nil

		if v12 and v12:GetAttribute("SeedTool") then
			break
		end

		task.wait(0.1)
	end
end

local function isInsidePlot(p1) --[[ isInsidePlot | Line: 483 | Upvalues: v1 (copy) ]]
	local Character = v1.Character

	if not Character then
		return false
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if not (HumanoidRootPart and HumanoidRootPart:IsA("BasePart")) then
		return false
	end

	local v12, v2 = p1:GetBoundingBox()
	local v3 = v12:PointToObjectSpace(HumanoidRootPart.Position)
	local v4 = v2 * 0.5

	return if math.abs(v3.X) <= v4.X + 5 then math.abs(v3.Z) <= v4.Z + 5 else false
end

local v4 = false

local function pointToUI(p1, p2, p3, p4) --[[ pointToUI | Line: 501 | Upvalues: TutorialUI (copy), v4 (ref), Pointer (copy), createTween (copy), RunService (copy) ]]
	local v1 = if p2 then p2 else TutorialUI
	local v3 = p3 or 1

	while v4 do
		task.wait()
	end

	v4 = true

	local function updatePosition() --[[ updatePosition | Line: 517 | Upvalues: p1 (copy), Pointer (ref) ]]
		local v1 = p1(Pointer)

		if v1 then
			Pointer.Position = UDim2.fromOffset(v1.X, v1.Y)
		end
	end

	task.spawn(updatePosition)
	Pointer.Image = p4 or "rbxassetid://7553620727"
	Pointer.Parent = v1

	local v42 = Pointer:FindFirstChildWhichIsA("UIScale")

	if v42 then
		v42.Scale = v3
	end

	Pointer.Visible = true
	createTween(Pointer, TweenInfo.new(0.3), {
		ImageTransparency = 0
	})

	local v5 = if v42 then createTween(v42, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
	Scale = v3 * 1.1
}, true) else nil
	local v6 = RunService.PreRender:Connect(updatePosition)

	return function() --[[ Line: 546 | Upvalues: v6 (copy), v5 (copy), createTween (ref), Pointer (ref), TutorialUI (ref), v4 (ref) ]]
		if not v6.Connected then
			return
		end

		v6:Disconnect()

		if v5 then
			v5:Cancel()
		end

		createTween(Pointer, TweenInfo.new(0.3), {
			ImageTransparency = 1
		}).Completed:Wait()
		Pointer.Visible = false
		Pointer.Parent = TutorialUI
		v4 = false
	end
end

return table.freeze({
	waitUntilDistance = waitUntilDistance,
	focusObject = focusObject,
	createArrow = createArrow,
	observeTag = observeTag,
	pointToUI = pointToUI,
	getPlayerPlot = getPlayerPlot,
	getTools = getTools,
	hasSeed = hasSeed,
	waitForSeed = waitForSeed,
	waitUntilSeedEquipped = waitUntilSeedEquipped,
	isInsidePlot = isInsidePlot
})