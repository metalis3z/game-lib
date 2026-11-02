--credit to leon games studio
local Networking = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("Networking"))
local Players = game:GetService("Players")

game:GetService("RunService")

local TweenService = game:GetService("TweenService")
local Zone = require(game.ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("Zone"))
local t = {
	Color3.fromRGB(231, 71, 204),
	Color3.fromRGB(47, 121, 231),
	Color3.fromRGB(55, 231, 126),
	Color3.fromRGB(190, 231, 55),
	Color3.fromRGB(231, 129, 46),
	Color3.fromRGB(231, 55, 55),
	Color3.fromRGB(120, 55, 231),
	Color3.fromRGB(55, 210, 231),
	Color3.fromRGB(231, 55, 120),
	Color3.fromRGB(231, 210, 55)
}

local function clampVariantId(p1) --[[ clampVariantId | Line: 20 | Upvalues: t (copy) ]]
	local v1 = #t

	if v1 <= 0 then
		return 1
	end

	return (math.floor(tonumber(p1) or 1) - 1) % v1 + 1
end

local function parseVariantId(p1) --[[ parseVariantId | Line: 29 | Upvalues: t (copy) ]]
	if type(p1) == "number" then
		local v1 = #t

		if v1 <= 0 then
			return 1
		end

		return (math.floor(tonumber(p1) or 1) - 1) % v1 + 1
	end

	if type(p1) ~= "string" then
		return 1
	end

	local v4 = tonumber((p1:match("(%d+)"))) or 1
	local v5 = #t

	if v5 <= 0 then
		return 1
	end

	return (math.floor(tonumber(v4) or 1) - 1) % v5 + 1
end

local function findRandomPartnerPad(p1) --[[ findRandomPartnerPad | Line: 40 | Upvalues: t (copy) ]]
	local v1 = p1:GetAttribute("ExtraData")
	local v2

	if type(v1) == "number" then
		local v3 = #t

		v2 = if v3 <= 0 then 1 else (math.floor(tonumber(v1) or 1) - 1) % v3 + 1
	elseif type(v1) == "string" then
		local v8 = #t

		v2 = if v8 <= 0 then 1 else (math.floor(tonumber(tonumber((v1:match("(%d+)"))) or 1) or 1) - 1) % v8 + 1
	else
		v2 = 1
	end

	local v11 = p1:GetAttribute("PropId")
	local count = 0
	local count2 = 0
	local count3 = 0
	local t2 = {}
	local count4 = 0

	for v13, v14 in p1.Parent:GetDescendants() do
		local v12

		if v14:IsA("Model") then
			count = count + 1

			local v15 = v14:GetAttribute("PropName")

			if v15 and string.find(v15, "Teleport Pad") then
				count2 = count2 + 1

				local v16 = v14:GetAttribute("ExtraData")

				if type(v16) == "number" then
					local v17 = #t

					v12 = if v17 <= 0 then 1 else (math.floor(tonumber(v16) or 1) - 1) % v17 + 1
				elseif type(v16) == "string" then
					local v22 = #t

					v12 = if v22 <= 0 then 1 else (math.floor(tonumber(tonumber((v16:match("(%d+)"))) or 1) or 1) - 1) % v22 + 1
				else
					v12 = 1
				end

				if v14:GetAttribute("PropId") == v11 then
					count3 = count3 + 1

					continue
				end

				if v12 == v2 then
					table.insert(t2, v14)

					continue
				end

				count4 = count4 + 1
			end
		end
	end

	return if #t2 > 0 then t2[math.random(1, #t2)] or nil else nil
end

local Teleport = game.SoundService.SFX.Teleport

return function(p1) --[[ Line: 78 | Upvalues: Players (copy), t (copy), Networking (copy), Zone (copy), TweenService (copy), findRandomPartnerPad (copy), Teleport (copy) ]]
	local v1

	repeat
		v1 = game:GetService("Players"):GetPlayerByUserId(p1:GetAttribute("UserId"))
	until v1 and p1:IsDescendantOf(workspace)

	local TouchPart = p1:FindFirstChild("TouchPart")

	if v1 == Players.LocalPlayer then
		p1:WaitForChild("ProximityPromptPart"):WaitForChild("ProximityPrompt").Triggered:Connect(function() --[[ Line: 90 | Upvalues: p1 (copy), t (ref), Networking (ref) ]]
			local v1 = p1:GetAttribute("ExtraData")
			local v2

			if type(v1) == "number" then
				local v3 = #t

				v2 = if v3 <= 0 then 1 else (math.floor(tonumber(v1) or 1) - 1) % v3 + 1
			elseif type(v1) == "string" then
				local v8 = #t

				v2 = if v8 <= 0 then 1 else (math.floor(tonumber(tonumber((v1:match("(%d+)"))) or 1) or 1) - 1) % v8 + 1
			else
				v2 = 1
			end

			local v12 = #t
			local v13 = if v12 <= 0 then 1 else (math.floor(tonumber(v2 + 1) or 1) - 1) % v12 + 1

			Networking.Prop.SetPropExtraData:Fire(p1:GetAttribute("PropId") or p1.Name, (tostring(v13)))
		end)
	end

	p1:FindFirstChild("Zone")

	local v2 = Zone.new({ p1:WaitForChild("Zone") })

	local function applyFromAttribute() --[[ applyFromAttribute | Line: 101 | Upvalues: p1 (copy), t (ref), TouchPart (copy) ]]
		local v1 = p1:GetAttribute("ExtraData")
		local v2

		if type(v1) == "number" then
			local v3 = #t

			v2 = if v3 <= 0 then 1 else (math.floor(tonumber(v1) or 1) - 1) % v3 + 1
		elseif type(v1) == "string" then
			local v8 = #t

			v2 = if v8 <= 0 then 1 else (math.floor(tonumber(tonumber((v1:match("(%d+)"))) or 1) or 1) - 1) % v8 + 1
		else
			v2 = 1
		end

		TouchPart.Color = t[v2]
	end

	local v3 = p1.PrimaryPart or p1:FindFirstChildWhichIsA("BasePart")
	local v4 = v3.CFrame:ToObjectSpace(TouchPart.CFrame)
	local v5 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local v6 = nil

	v2.localPlayerEntered:Connect(function() --[[ Line: 112 | Upvalues: p1 (copy), v3 (copy), v4 (copy), TweenService (ref), TouchPart (copy), v5 (copy), Players (ref), v6 (ref), findRandomPartnerPad (ref), Teleport (ref), v1 (ref) ]]
		if not p1:GetAttribute("IsBeingMoved") then
			TweenService:Create(TouchPart, v5, {
				CFrame = v3.CFrame * v4 * CFrame.new(0, -0.1, 0)
			}):Play()
		end

		local Character = Players.LocalPlayer.Character
		local v12 = if Character then Character:GetAttribute("_TelepadArrival") else Character

		if v12 then
			Character:SetAttribute("_TelepadArrival", nil)
		end

		v6 = task.delay(if v12 then 5 else 0.1, function() --[[ Line: 128 | Upvalues: findRandomPartnerPad (ref), p1 (ref), TouchPart (ref), Teleport (ref), v6 (ref), Character (copy), v1 (ref), Players (ref) ]]
			local v12 = findRandomPartnerPad(p1)

			if v12 then
				local Break = TouchPart:FindFirstChild("Break")

				Teleport.PlaybackSpeed = 1 + math.random(-15, 15) / 100
				Teleport.TimePosition = 0
				Teleport.Playing = true

				if Break then
					Break:Emit(5)
				end
			end

			task.wait(0.2)
			v6 = nil

			if v12 then
				if not (Character and (Character and Character:FindFirstChild("HumanoidRootPart"))) then
					return
				end

				local v3 = v12:FindFirstChild("TouchPart") or (v12.PrimaryPart or v12:FindFirstChildWhichIsA("BasePart"))

				if v3 then
					local v4 = v3.CFrame * CFrame.new(0, 3.5, 0)

					Character:SetAttribute("_TelepadArrival", true)
					Character:PivotTo(v4)
				end
			else
				if v1 ~= Players.LocalPlayer then
					return
				end

				game.ReplicatedStorage.Notify:Fire("This teleport pad has no destination!")
			end
		end)
	end)
	v2.localPlayerExited:Connect(function() --[[ Line: 164 | Upvalues: p1 (copy), v3 (copy), v4 (copy), TweenService (ref), TouchPart (copy), v5 (copy), v6 (ref) ]]
		if not p1:GetAttribute("IsBeingMoved") then
			TweenService:Create(TouchPart, v5, {
				CFrame = v3.CFrame * v4
			}):Play()
		end

		if not v6 then
			return
		end

		task.cancel(v6)
		v6 = nil
	end)

	local v7 = p1:GetAttribute("ExtraData")
	local v8

	if type(v7) == "number" then
		local v9 = #t

		v8 = if v9 <= 0 then 1 else (math.floor(tonumber(v7) or 1) - 1) % v9 + 1
	elseif type(v7) == "string" then
		local v14 = #t

		v8 = if v14 <= 0 then 1 else (math.floor(tonumber(tonumber((v7:match("(%d+)"))) or 1) or 1) - 1) % v14 + 1
	else
		v8 = 1
	end

	TouchPart.Color = t[v8]
	p1:GetAttributeChangedSignal("ExtraData"):Connect(applyFromAttribute)
end