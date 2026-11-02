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
-- CQNTCmRlYnVnUHJpbnQJaGlnaGxpZ2h0BlBhcmVudAdEZXN0cm95C3dhcm5pbmdJY29uD3JlbW92ZUhpZ2hsaWdodAtQcmltYXJ5UGFydAtHZXRGdWxsTmFtZQhJbnN0YW5jZQNuZXcJSGlnaGxpZ2h0EEZpbGxUcmFuc3BhcmVuY3kGQ29sb3IzB2Zyb21SR0IMT3V0bGluZUNvbG9yE091dGxpbmVUcmFuc3BhcmVuY3kUUGFydHlQb3BwZXJIaWdobGlnaHQETmFtZQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlA0dVSQtXYXJuaW5nSWNvbgVDbG9uZQVNb2RlbANJc0EMQXN0cm9Nb25zdGVyDUV4dGVudHNPZmZzZXQFVURpbTIEU2l6ZQVGcmFtZQlUZXh0TGFiZWwHVFdJU1RFRARUZXh0ClRleHRDb2xvcjMKSW1hZ2VMYWJlbAtJbWFnZUNvbG9yMxJQYXJ0eVBvcHBlcldhcm5pbmcIbGFzdFNlZW4Cb3MFY2xvY2sQaGlnaGxpZ2h0TW9uc3RlcgVwYWlycwl3b3Jrc3BhY2ULQ3VycmVudFJvb20ORmluZEZpcnN0Q2hpbGQWRmluZEZpcnN0Q2hpbGRXaGljaElzQQhNb25zdGVycwZpcGFpcnMLR2V0Q2hpbGRyZW4FdGFibGUFY2xlYXIdQ2xlYW5lZCB1cCBwbGF5ZXIgc3RhdGUgZm9yOiAIUG9zaXRpb24ESW5mbwtGbG9vckFjdGl2ZQVWYWx1ZQZzdHJpbmcEZmluZAZSb2RnZXIJTWFnbml0dWRlCFNjYW5BcmVhEGltbWVkaWF0ZUNsZWFudXAEdGFzawR3YWl0EGhpZ2hsaWdodEVuZFRpbWUObGFzdEFjdGl2ZVRpbWUNd2FzRXh0cmFjdGluZyxTdGFydGluZyBuZXcgaGlnaGxpZ2h0IHNlc3Npb247IHdpbGwgZW5kIGF0IAVzcGF3bhVzdGFydEhpZ2hsaWdodFNlc3Npb24KRGlzY29ubmVjdAZVc2VySWQFU3RhdHMIRGVjb2RpbmcHQ2hhbmdlZAdDb25uZWN0D0FuY2VzdHJ5Q2hhbmdlZA1DbGllbnRBYmlsaXR5DFR3ZWVuU2VydmljZQpHZXRTZXJ2aWNlBkRlYnJpcwdQbGF5ZXJzClJ1blNlcnZpY2UADgEB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

-- https://lua.expert/
local t = {}

game:GetService("TweenService")
game:GetService("Debris")
game:GetService("Players")
game:GetService("RunService")

local t2 = {}
local t3 = {}

local function debugPrint(p1) --[[ debugPrint | Line: 24 ]] end

local function removeHighlight(p1) --[[ removeHighlight | Line: 29 | Upvalues: t2 (copy) ]]
	if not t2[p1] then
		return
	end

	if t2[p1].highlight and t2[p1].highlight.Parent then
		t2[p1].highlight:Destroy()
	end

	if t2[p1].warningIcon and t2[p1].warningIcon.Parent then
		t2[p1].warningIcon:Destroy()
	end

	t2[p1] = nil
end

local function highlightMonster(p1, p2) --[[ highlightMonster | Line: 42 | Upvalues: t2 (copy) ]]
	if not (p1 and (p1.Parent and p1.PrimaryPart)) then
		return
	end

	local v1 = p1:GetFullName()

	if t2[v1] then
		t2[v1].lastSeen = os.clock()

		return
	end

	local PartyPopperHighlight = Instance.new("Highlight")

	PartyPopperHighlight.FillTransparency = 1
	PartyPopperHighlight.OutlineColor = Color3.fromRGB(255, 132, 203)
	PartyPopperHighlight.OutlineTransparency = 0
	PartyPopperHighlight.Name = "PartyPopperHighlight"
	PartyPopperHighlight.Parent = p1

	local PartyPopperWarning = game.ReplicatedStorage.GUI.WarningIcon:Clone()

	if p1:IsA("Model") then
		if p1.Name == "AstroMonster" then
			PartyPopperWarning.ExtentsOffset = Vector3.new(0, 0.5, 0)
		else
			PartyPopperWarning.ExtentsOffset = Vector3.new(0, 1.5, 0)
		end
	end

	PartyPopperWarning.Size = UDim2.new(16, 0, 16, 0)
	PartyPopperWarning.Frame.TextLabel.Text = "TWISTED"
	PartyPopperWarning.Frame.TextLabel.TextColor3 = Color3.fromRGB(255, 132, 203)
	PartyPopperWarning.Frame.ImageLabel.ImageColor3 = Color3.fromRGB(255, 132, 203)
	PartyPopperWarning.Name = "PartyPopperWarning"
	PartyPopperWarning.Parent = p1
	t2[v1] = {
		highlight = PartyPopperHighlight,
		warningIcon = PartyPopperWarning,
		lastSeen = os.clock()
	}
end

local function f1() --[[ Line: 81 | Upvalues: t2 (copy), removeHighlight (copy) ]]
	for k, v in pairs(t2) do
		removeHighlight(k)
	end

	if not workspace:FindFirstChild("CurrentRoom") then
		table.clear(t2)

		return
	end

	local v1 = workspace.CurrentRoom:FindFirstChildWhichIsA("Model")

	if not v1 then
		table.clear(t2)

		return
	end

	local Monsters = v1:FindFirstChild("Monsters")

	if not Monsters then
		table.clear(t2)

		return
	end

	for i, v in ipairs(Monsters:GetChildren()) do
		local PartyPopperHighlight = v:FindFirstChild("PartyPopperHighlight")

		if PartyPopperHighlight then
			PartyPopperHighlight:Destroy()
		end

		if v.PrimaryPart then
			for k, v2 in pairs(v.PrimaryPart:GetChildren()) do
				if v2.Name == "PartyPopperWarning" then
					v2:Destroy()
				end
			end
		end
	end

	table.clear(t2)
end

local function f2(p1) --[[ Line: 116 | Upvalues: t3 (copy) ]]
	if not t3[p1] then
		return
	end

	t3[p1] = nil
end

function t.ScanArea(p1, p2) --[[ ScanArea | Line: 124 | Upvalues: highlightMonster (copy), removeHighlight (copy) ]]
	if not (p2 and (p2.Parent and p2.PrimaryPart)) then
		return
	end

	local Position = p2.PrimaryPart.Position
	local v1 = workspace.CurrentRoom:FindFirstChildWhichIsA("Model")

	if not (v1 and workspace.Info.FloorActive.Value) then
		return
	end

	local Monsters = v1:FindFirstChild("Monsters")

	if not Monsters then
		return
	end

	for i, v in ipairs(Monsters:GetChildren()) do
		if v:IsA("Model") and (v.PrimaryPart and (v:GetChildren()[1] and not string.find(v.Name, "Rodger"))) then
			local v2 = v:GetFullName()

			if (Position - v.PrimaryPart.Position).Magnitude <= 100 then
				highlightMonster(v, Position)

				continue
			end

			removeHighlight(v2)
		end
	end
end
function t.ClientAbility(p1, p2) --[[ ClientAbility | Line: 155 | Upvalues: f1 (ref), f2 (ref), t3 (copy), t (copy) ]]
	local t2 = {}
	local v1 = false
	local UserId = p1.UserId

	if not (p2 and p2:FindFirstChild("Stats")) then
		return
	end

	local Stats = p2.Stats
	local Decoding = p2:FindFirstChild("Decoding")

	if not Decoding then
		return
	end

	local function immediateCleanup() --[[ immediateCleanup | Line: 173 | Upvalues: v1 (ref), f1 (ref), f2 (ref), UserId (copy) ]]
		v1 = false
		f1()
		f2(UserId)
	end

	local function startHighlightSession() --[[ startHighlightSession | Line: 181 | Upvalues: v1 (ref), f1 (ref), f2 (ref), UserId (copy), t3 (ref), p2 (copy), Decoding (copy), t (ref), p1 (copy) ]]
		v1 = false
		f1()
		f2(UserId)

		local v12 = os.clock()

		t3[UserId] = {
			wasExtracting = true,
			highlightEndTime = v12 + 5,
			lastActiveTime = v12
		}

		local v2 = v12 + 5

		v1 = true
		task.spawn(function() --[[ Line: 195 | Upvalues: p2 (ref), v1 (ref), v2 (copy), Decoding (ref), t (ref), p1 (ref), f1 (ref), f2 (ref), UserId (ref) ]]
			while p2 and (p2.Parent and (v1 and (os.clock() < v2 and Decoding.Value ~= nil))) do
				t.ScanArea(p1, p2)
				task.wait(0.5)
			end

			v1 = false
			f1()
			f2(UserId)
		end)
	end

	t2[1] = Decoding.Changed:Connect(function() --[[ Line: 210 | Upvalues: Decoding (copy), startHighlightSession (copy), v1 (ref), f1 (ref), f2 (ref), UserId (copy) ]]
		if Decoding.Value then
			startHighlightSession()
		else
			v1 = false
			f1()
			f2(UserId)
		end
	end)

	if not Decoding.Value then
		t2[2] = p2.AncestryChanged:Connect(function(p13, p23) --[[ Line: 224 | Upvalues: t2 (copy), v1 (ref), f1 (ref), f2 (ref), UserId (copy) ]]
			if p23 then
				return
			end

			for i2, v in ipairs(t2) do
				if v then
					v:Disconnect()
				end
			end

			v1 = false
			f1()
			f2(UserId)
		end)
		t2[3] = p1.AncestryChanged:Connect(function(p13, p23) --[[ Line: 236 | Upvalues: t2 (copy), v1 (ref), f1 (ref), f2 (ref), UserId (copy) ]]
			if p23 then
				return
			end

			for i2, v in ipairs(t2) do
				if v then
					v:Disconnect()
				end
			end

			v1 = false
			f1()
			f2(UserId)
		end)

		return
	end

	startHighlightSession()
	t2[2] = p2.AncestryChanged:Connect(function(p13, p23) --[[ Line: 224 | Upvalues: t2 (copy), v1 (ref), f1 (ref), f2 (ref), UserId (copy) ]]
		if p23 then
			return
		end

		for i2, v in ipairs(t2) do
			if v then
				v:Disconnect()
			end
		end

		v1 = false
		f1()
		f2(UserId)
	end)
	t2[3] = p1.AncestryChanged:Connect(function(p13, p23) --[[ Line: 236 | Upvalues: t2 (copy), v1 (ref), f1 (ref), f2 (ref), UserId (copy) ]]
		if p23 then
			return
		end

		for i2, v in ipairs(t2) do
			if v then
				v:Disconnect()
			end
		end

		v1 = false
		f1()
		f2(UserId)
	end)
end

return t