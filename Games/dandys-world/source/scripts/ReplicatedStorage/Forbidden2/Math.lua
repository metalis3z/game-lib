--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- CQNBBlBsYXllcglDaGFyYWN0ZXIFcHJpbnQYY2hhcmFjdGVyIGRvZXMgbm90IGV4aXN0BU1vZGVsBFBhcnQLUHJpbWFyeVBhcnQISHVtYW5vaWQORmluZEZpcnN0Q2hpbGQQSHVtYW5vaWRSb290UGFydAtHZXRDaGlsZHJlbgxmaW5kQmFzZVBhcnQaRmlsdGVyRGVzY2VuZGFudHNJbnN0YW5jZXMJd29ya3NwYWNlCFBvc2l0aW9uBXJhbmdlB1JheWNhc3QISW5zdGFuY2UFcGFpcnMOR2V0RGVzY2VuZGFudHMHcmF5Y2FzdAxUcmFuc3BhcmVuY3kaU2VlVGhyb3VnaFRyYW5zcGFyZW50UGFydHMLZmlsdGVyVGFibGUHZGVmYXVsdAdHZXRUeXBlBHdhcm4EVW5pdA1SYXljYXN0UGFyYW1zA25ldwZQYXJlbnQERW51bRFSYXljYXN0RmlsdGVyVHlwZQdFeGNsdWRlCkZpbHRlclR5cGUFcGNhbGwFdGFibGUGaW5zZXJ0B1ZlY3RvcjMBWARtYXRoBXJvdW5kAVoGTnVtYmVyB0ludGVnZXIGQ0ZyYW1lAVkEZ2FtZQdQbGF5ZXJzC0xvY2FsUGxheWVyCVdvcmtzcGFjZQ1DdXJyZW50Q2FtZXJhA0lzQRRXb3JsZFRvVmlld3BvcnRQb2ludBJWaWV3cG9ydFBvaW50VG9SYXkGT3JpZ2luCURpcmVjdGlvbgtMaW5lT2ZTaWdodAZzY3JpcHQHcmVxdWlyZQhTdGFuZGFyZAxXYWl0Rm9yQ2hpbGQMc3RkZnVuY3Rpb25zBVJvdW5kC0luTG9jYWxWaWV3AAcHAgQAAAcEAAAFAgcDRPsCAACVAgIA3gIAAPABDAABAACATQAAaQIAAABHAAcAAAAAgKQCBAAAADBAbwMFAJ8CAgGpAgAAggICAG8BBgDwAQUABwAAgPsCAQD7AwAAagACA4IAAQDwASwABgAAgPsCAAANAgQACAAAgKkCAQDeAgIA3gADAE0CAJsJAAAARwIHAAAAAAD7AgEA+wMAAE0EAJsJAAAAagQCA4IAAQBvBAoAvAIAAwsAAACfAgMCDgIPAG8EDAC8AgADCwAAAJ8CAwIOAgQAqQMAAN4DAgDGAwAA3gMDAEcCBQAAAAAA+wMBAPsEAABqAgMEggABAPsCAQD7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

-- https://lua.expert/
local t = {}
local stdfunctions = require(script.Parent:WaitForChild("Standard"):WaitForChild("stdfunctions"))

function t.LineOfSight(p1, p2, p3, p4) --[[ Line: 6 | Upvalues: stdfunctions (copy) ]]
	local t = {
		range = 50,
		SeeThroughTransparentParts = false,
		filterTable = "default"
	}

	for k, v in pairs(p3 or {}) do
		t[k] = v
	end

	local v3 = 0
	local t2 = {}
	local v4 = false
	local v5 = nil

	local function findBasePart(p1, p2) --[[ findBasePart | Line: 30 | Upvalues: v3 (ref), t2 (copy), v4 (ref), v5 (ref) ]]
		v3 = v3 + 1

		if p2 == "Player" then
			p1 = p1.Character

			if p1 == nil then
				print("character does not exist")

				return false
			end

			p2 = "Model"
		end

		if p2 == "Part" then
			t2[v3] = p1

			return
		end

		if p2 ~= "Model" then
			return
		end

		if v3 == 2 then
			v4 = true
			v5 = p1
		end

		if p1.PrimaryPart ~= nil then
			t2[v3] = p1.PrimaryPart

			return
		end

		if p1:FindFirstChild("Humanoid") then
			local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")

			if HumanoidRootPart then
				v4 = false
				v5 = nil
			end

			if HumanoidRootPart ~= nil then
				t2[v3] = HumanoidRootPart

				return
			end
		end

		t2[v3] = p1:GetChildren()[1]
	end

	local v6 = stdfunctions.GetType(p1)
	local v7 = stdfunctions.GetType(p2)
	local v8 = findBasePart(p1, v6)
	local v9 = findBasePart(p2, v7)

	if not (p4 or false) then
		if v8 ~= nil then
			warn(v8)

			return v8
		end

		if v9 ~= nil then
			warn(v9)

			return v9
		end
	end

	local v10 = t2[1]
	local v11 = t2[2]
	local Unit = (v11.Position - v10.Position).Unit
	local v12 = RaycastParams.new()
	local t3 = { v10.Parent }

	if t.filterTable == "default" then
		v12.FilterDescendantsInstances = t3
	else
		v12.FilterDescendantsInstances = t.filterTable
	end

	v12.FilterType = Enum.RaycastFilterType.Exclude

	local v13 = nil

	local function raycast() --[[ raycast | Line: 84 | Upvalues: v13 (ref), v12 (copy), t3 (copy), v10 (copy), Unit (copy), t (copy), v11 (copy), v4 (ref), v5 (ref) ]]
		v13 = nil
		v12.FilterDescendantsInstances = t3
		v13 = workspace:Raycast(v10.Position, Unit * t.range, v12)

		if v13 then
			if v13.Instance == v11 then
				return true
			end

			if not v4 then
				return false
			end

			for k, v in pairs(v5:GetDescendants()) do
				if v == v13.Instance then
					return true
				end
			end

			return false
		end

		if v13 == nil or not v13 then
			return false
		end
	end

	if not t.SeeThroughTransparentParts or t.SeeThroughTransparentParts == nil then
		return raycast()
	end

	if not t.SeeThroughTransparentParts then
		return
	end

	local v14 = false
	local v15

	repeat
		if v14 then
			return
		end

		v15 = raycast()

		if not v15 then
			local v16 = 0
			local _, _2 = pcall(function() --[[ Line: 135 | Upvalues: v16 (ref), v13 (ref) ]]
				v16 = v13.Instance.Transparency
			end)

			if v16 > 0 then
				table.insert(t3, v13.Instance)
			end

			if not (v16 > 0) then
				break
			end
		end
	until v15

	return v15
end
function t.Round(p1) --[[ Line: 161 | Upvalues: stdfunctions (copy) ]]
	local v1 = stdfunctions.GetType(p1)

	if v1 == "Vector3" then
		return Vector3.new(math.round(p1.X), math.round(p1.X), (math.round(p1.Z)))
	end

	if v1 == "Number" then
		return math.round(p1)
	end

	if v1 == "Integer" then
		return p1
	end

	if v1 == "CFrame" then
		p1.X = math.round(p1.X)
		p1.Y = math.round(p1.Y)
		p1.Z = math.round(p1.Z)

		return p1
	end
end
function t.InLocalView(p1, p2) --[[ Line: 194 | Upvalues: t (copy) ]]
	local v1 = false
	local v2 = true
	local LocalPlayer = game.Players.LocalPlayer
	local CurrentCamera = game.Workspace.CurrentCamera

	if p1:IsA("Model") and p1.PrimaryPart ~= nil then
		local PrimaryPart = p1.PrimaryPart
	end

	local v3, v4 = CurrentCamera:WorldToViewportPoint(p1.Position)
	local v5 = CurrentCamera:ViewportPointToRay(v3.X, v3.Y, 0)
	local v6 = RaycastParams.new()

	v6.FilterType = Enum.RaycastFilterType.Exclude
	v6.FilterDescendantsInstances = { LocalPlayer.Character }

	local v7 = workspace:Raycast(v5.Origin, v5.Direction * 1000, v6)

	if v7 == nil then
		return false
	end

	if v7.Instance == p1 then
		v1 = true
	end

	if p2 then
		v2 = t.LineOfSight(LocalPlayer.Character, p1, {
			range = 100,
			SeeThroughTransparentParts = true,
			filterTable = { LocalPlayer.Character }
		})
	end

	return (if v4 then if v1 then v2 else v1 else v4) and true or false
end

return t