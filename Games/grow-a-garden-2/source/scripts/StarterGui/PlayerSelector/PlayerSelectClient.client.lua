--credit to prince games studio
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local LocalPlayer = Players.LocalPlayer
local v1 = script.Parent
local ScrollingFrame = v1.Frame.ScrollingFrame
local PlayerCard = ScrollingFrame:WaitForChild("PlayerCard")

PlayerCard.Visible = false

local GiftBar = v1:FindFirstChild("GiftBar", true)
local SearchBox = v1:FindFirstChild("SearchBox", true)
local v2 = if SearchBox and SearchBox:IsA("TextBox") then SearchBox else nil

if GiftBar then
	GiftBar.Visible = false
end

local t = {}
local t2 = {}
local v3 = false
local v4 = nil
local v5 = nil
local v6 = 0
local v7 = (-1 / 0)

local function buildCard(p1, p2, p3, p4, p5, p6) --[[ buildCard | Line: 56 | Upvalues: t (copy), PlayerCard (copy), v3 (ref), Players (copy), v1 (copy), ScrollingFrame (copy), t2 (copy) ]]
	if t[p1] and t[p1].Parent then
		return t[p1]
	end

	local v12 = PlayerCard:Clone()

	v12.Name = p3
	v12.Visible = not v3 or (if p5 == "Server" then true else false)
	v12.LayoutOrder = p4

	local Holder = v12.Holder

	Holder.Username.Text = ("@%*"):format(p3)
	Holder.DisplayName.Text = p2
	Holder.DisplayName.TextLabel.Text = p2
	Holder.PlayerDisplay.PlayerIcon.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(p1)
	Holder.TextButton.Activated:Connect(function() --[[ Line: 79 | Upvalues: p1 (copy), p3 (copy), p2 (copy), p6 (copy), Players (ref), v1 (ref) ]]
		local t = {
			UserId = p1,
			Name = p3,
			DisplayName = p2
		}

		t.Player = p6 or Players:GetPlayerByUserId(p1)
		v1.PlayerSelected:Fire(t)
		v1.Enabled = false
	end)
	v12.Parent = ScrollingFrame
	t[p1] = v12
	t2[p1] = p5

	return v12
end

local function removeCard(p1) --[[ removeCard | Line: 96 | Upvalues: t (copy), t2 (copy) ]]
	local v1 = t[p1]

	if v1 then
		v1:Destroy()
		t[p1] = nil
	end

	t2[p1] = nil
end

local function applyMode() --[[ applyMode | Line: 107 | Upvalues: t (copy), v4 (ref), v3 (ref), t2 (copy) ]]
	for v1, v2 in t do
		if v4 then
			v2.Visible = v1 == v4

			continue
		end

		v2.Visible = not v3 or t2[v1] == "Server"
	end
end

local function setHeaderTitle(p1) --[[ setHeaderTitle | Line: 117 | Upvalues: v1 (copy) ]]
	local Header = v1.Frame:FindFirstChild("Header")
	local v12 = if Header then Header:FindFirstChild("TextLabel") else Header

	if not (v12 and v12:IsA("TextLabel")) then
		return
	end

	v12.Text = p1

	local TextLabel = v12:FindFirstChild("TextLabel")

	if not (TextLabel and TextLabel:IsA("TextLabel")) then
		return
	end

	TextLabel.Text = p1
end

local function clearSearch() --[[ clearSearch | Line: 130 | Upvalues: v6 (ref), v5 (ref), v4 (ref), t2 (copy), t (copy), applyMode (copy) ]]
	v6 = v6 + 1

	if v5 then
		task.cancel(v5)
		v5 = nil
	end

	if v4 then
		if t2[v4] == "Search" then
			local v1 = v4
			local v2 = t[v1]

			if v2 then
				v2:Destroy()
				t[v1] = nil
			end

			t2[v1] = nil
		end

		v4 = nil
	end

	applyMode()
end

local function isValidUsernameLocal(p1) --[[ isValidUsernameLocal | Line: 145 ]]
	if #p1 < 3 or #p1 > 20 then
		return false
	end

	return string.match(p1, "^[%w_]+$") ~= nil
end

local function runSearch(p1, p2) --[[ runSearch | Line: 150 | Upvalues: v7 (ref), v6 (ref), Networking (copy), v1 (copy), LocalPlayer (copy), v4 (ref), t2 (copy), t (copy), buildCard (copy), applyMode (copy) ]]
	task.spawn(function() --[[ Line: 151 | Upvalues: v7 (ref), p2 (copy), v6 (ref), Networking (ref), p1 (copy), v1 (ref), LocalPlayer (ref), v4 (ref), t2 (ref), t (ref), buildCard (ref), applyMode (ref) ]]
		local v122 = os.clock() - v7

		if v122 < 2 then
			task.wait(2 - v122)
		end

		if p2 ~= v6 then
			return
		end

		v7 = os.clock()

		local ok, result, result2 = pcall(function() --[[ Line: 161 | Upvalues: Networking (ref), p1 (ref) ]]
			return Networking.Mailbox.LookupPlayer:Fire(p1)
		end)

		if p2 ~= v6 then
			return
		end

		if not ok or (typeof(result) ~= "number" or result <= 0) then
			return
		end

		if not v1.Enabled then
			return
		end

		if result == LocalPlayer.UserId then
			return
		end

		if v4 and (v4 ~= result and t2[v4] == "Search") then
			local v22 = v4
			local v3 = t[v22]

			if v3 then
				v3:Destroy()
				t[v22] = nil
			end

			t2[v22] = nil
		end

		local v42 = t[result]

		if v42 then
			v42.LayoutOrder = -1
		else
			local v62, v72

			if result2 == "" or not result2 then
				v62 = p1
				v72 = result
			else
				v72 = result
				v62 = result2
			end

			buildCard(v72, v62, p1, -1, "Search", nil)
		end

		v4 = result
		applyMode()
	end)
end

local function onSearchChanged() --[[ onSearchChanged | Line: 188 | Upvalues: v2 (copy), v6 (ref), v5 (ref), v4 (ref), t2 (copy), t (copy), applyMode (copy), v7 (ref), Networking (copy), v1 (copy), LocalPlayer (copy), buildCard (copy) ]]
	if not v2 then
		return
	end

	local v22 = string.gsub(v2.Text or "", "^%s*@?(.-)%s*$", "%1")

	v6 = v6 + 1

	local v3 = v6

	if v5 then
		task.cancel(v5)
		v5 = nil
	end

	if v22 == "" then
		v6 = v6 + 1

		if v5 then
			task.cancel(v5)
			v5 = nil
		end

		if v4 then
			if t2[v4] == "Search" then
				local v42 = v4
				local v52 = t[v42]

				if v52 then
					v52:Destroy()
					t[v42] = nil
				end

				t2[v42] = nil
			end

			v4 = nil
		end

		applyMode()
	elseif if #v22 < 3 or #v22 > 20 then false elseif string.match(v22, "^[%w_]+$") == nil then false else true then
		v5 = task.delay(1, function() --[[ Line: 210 | Upvalues: v5 (ref), v22 (copy), v3 (copy), v7 (ref), v6 (ref), Networking (ref), v1 (ref), LocalPlayer (ref), v4 (ref), t2 (ref), t (ref), buildCard (ref), applyMode (ref) ]]
			v5 = nil

			local v12 = v22
			local v2 = v3

			task.spawn(function() --[[ Line: 151 | Upvalues: v7 (ref), v2 (copy), v6 (ref), Networking (ref), v12 (copy), v1 (ref), LocalPlayer (ref), v4 (ref), t2 (ref), t (ref), buildCard (ref), applyMode (ref) ]]
				local v122 = os.clock() - v7

				if v122 < 2 then
					task.wait(2 - v122)
				end

				if v2 ~= v6 then
					return
				end

				v7 = os.clock()

				local ok, result, result2 = pcall(function() --[[ Line: 161 | Upvalues: Networking (ref), v12 (ref) ]]
					return Networking.Mailbox.LookupPlayer:Fire(p1)
				end)

				if v2 ~= v6 then
					return
				end

				if not ok or (typeof(result) ~= "number" or result <= 0) then
					return
				end

				if not v1.Enabled then
					return
				end

				if result == LocalPlayer.UserId then
					return
				end

				if v4 and (v4 ~= result and t2[v4] == "Search") then
					local v22 = v4
					local v3 = t[v22]

					if v3 then
						v3:Destroy()
						t[v22] = nil
					end

					t2[v22] = nil
				end

				local v42 = t[result]

				if v42 then
					v42.LayoutOrder = -1
				else
					local v62, v72

					if result2 == "" or not result2 then
						v62 = v12
						v72 = result
					else
						v72 = result
						v62 = result2
					end

					buildCard(v72, v62, v12, -1, "Search", nil)
				end

				v4 = result
				applyMode()
			end)
		end)
	end
end

v1:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 220 | Upvalues: v1 (copy), v3 (ref), setHeaderTitle (copy), v2 (copy), v6 (ref), v5 (ref), v4 (ref), t2 (copy), t (copy), applyMode (copy), GiftBar (copy) ]]
	if not v1.Enabled then
		return
	end

	v3 = v1:GetAttribute("OnlineOnly") == true
	v1:SetAttribute("OnlineOnly", false)
	setHeaderTitle(if v3 then "Gift A Player" else "Gift A Friend")

	if v2 then
		v2.Text = ""
	end

	v6 = v6 + 1

	if v5 then
		task.cancel(v5)
		v5 = nil
	end

	if v4 then
		if t2[v4] == "Search" then
			local v42 = v4
			local v52 = t[v42]

			if v52 then
				v52:Destroy()
				t[v42] = nil
			end

			t2[v42] = nil
		end

		v4 = nil
	end

	applyMode()

	if not GiftBar then
		applyMode()

		return
	end

	GiftBar.Visible = not v3
	applyMode()
end)

local function indexServerPlayer(p1) --[[ indexServerPlayer | Line: 239 | Upvalues: LocalPlayer (copy), t (copy), t2 (copy), buildCard (copy), Players (copy), applyMode (copy) ]]
	if p1 == LocalPlayer then
		return
	end

	if t[p1.UserId] then
		local UserId = p1.UserId
		local v1 = t[UserId]

		if v1 then
			v1:Destroy()
			t[UserId] = nil
		end

		t2[UserId] = nil
	end

	buildCard(p1.UserId, p1.DisplayName, p1.Name, 0, "Server", p1)
	p1.AncestryChanged:Connect(function() --[[ Line: 251 | Upvalues: p1 (copy), Players (ref), t (ref), t2 (ref) ]]
		if p1:IsDescendantOf(Players) then
			return
		end

		local UserId = p1.UserId
		local v1 = t[UserId]

		if v1 then
			v1:Destroy()
			t[UserId] = nil
		end

		t2[UserId] = nil
	end)
	applyMode()
end

v1.Frame.Header.ExitButton.Activated:Connect(function() --[[ Line: 260 | Upvalues: v1 (copy) ]]
	v1.PlayerSelected:Fire(nil)
	v1.Enabled = false
end)

if v2 then
	v2:GetPropertyChangedSignal("Text"):Connect(onSearchChanged)
end

for v8, v9 in Players:GetPlayers() do
	indexServerPlayer(v9)
end

Players.PlayerAdded:Connect(indexServerPlayer)
task.spawn(function() --[[ Line: 274 | Upvalues: Players (copy), LocalPlayer (copy), t (copy), buildCard (copy) ]]
	local ok, result = pcall(function() --[[ Line: 275 | Upvalues: Players (ref), LocalPlayer (ref) ]]
		return Players:GetFriendsAsync(LocalPlayer.UserId)
	end)

	if not (ok and result) then
		return
	end

	local count = 0

	repeat
		if not (count < 50) then
			break
		end

		for v1, v2 in result:GetCurrentPage() do
			if count >= 50 then
				break
			end

			local Id = v2.Id

			if Id and (Id ~= LocalPlayer.UserId and not t[Id]) then
				local Username = v2.Username

				if buildCard(Id, v2.DisplayName or Username, Username, 1000, "Friend", nil) then
					count = count + 1
				end
			end
		end
	until result.IsFinished or not pcall(function() --[[ Line: 299 | Upvalues: result (copy) ]]
		result:AdvanceToNextPageAsync()
	end)
end)