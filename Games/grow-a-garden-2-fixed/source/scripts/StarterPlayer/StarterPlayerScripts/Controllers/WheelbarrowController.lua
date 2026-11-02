--credit to prince games studio
local t = {}
local LocalPlayer = game:GetService("Players").LocalPlayer
local NotificationController = require(LocalPlayer.PlayerScripts.Controllers.NotificationController)

local function HasFriendInServer() --[[ HasFriendInServer | Line: 13 | Upvalues: LocalPlayer (copy) ]]
	local v1 = LocalPlayer:GetAttribute("Friends")

	return if type(v1) == "number" then v1 > 0 else false
end

local function IsWheelbarrowTool(p1) --[[ IsWheelbarrowTool | Line: 18 ]]
	if not p1:IsA("Tool") then
		return false
	end

	return if p1:GetAttribute("Wheelbarrow") == nil then p1.Name == "Wheelbarrow" else true
end

local function UnequipCurrentTool(p1) --[[ UnequipCurrentTool | Line: 24 ]]
	local Humanoid = p1:FindFirstChildOfClass("Humanoid")

	if not Humanoid then
		return
	end

	Humanoid:UnequipTools()
end

local function HandleEquipped(p1) --[[ HandleEquipped | Line: 31 | Upvalues: LocalPlayer (copy), NotificationController (copy) ]]
	local v1 = LocalPlayer:GetAttribute("Friends")

	if if type(v1) == "number" then v1 > 0 else false then
		return
	end

	local v3 = p1.Parent

	if not (v3 and v3:IsA("Model")) then
		return
	end

	local Humanoid = v3:FindFirstChildOfClass("Humanoid")

	if not Humanoid then
		NotificationController:CreateNotification("Friend in Server Required!")

		return
	end

	Humanoid:UnequipTools()
	NotificationController:CreateNotification("Friend in Server Required!")
end

local function ConnectTool(p1) --[[ ConnectTool | Line: 43 | Upvalues: LocalPlayer (copy), NotificationController (copy) ]]
	p1.Equipped:Connect(function() --[[ Line: 44 | Upvalues: p1 (copy), LocalPlayer (ref), NotificationController (ref) ]]
		local v2 = LocalPlayer:GetAttribute("Friends")

		if if type(v2) == "number" then v2 > 0 else false then
			return
		end

		local v4 = p1.Parent

		if not v4 then
			return
		end

		if not v4:IsA("Model") then
			return
		end

		local Humanoid = v4:FindFirstChildOfClass("Humanoid")

		if Humanoid then
			Humanoid:UnequipTools()
		end

		NotificationController:CreateNotification("Friend in Server Required!")
	end)
end

local t2 = {}

local function TryConnect(p1) --[[ TryConnect | Line: 51 | Upvalues: t2 (copy), LocalPlayer (copy), NotificationController (copy) ]]
	if not (if p1:IsA("Tool") then if p1:GetAttribute("Wheelbarrow") == nil then if p1.Name == "Wheelbarrow" then true else false else true else false) then
		return
	end

	if not t2[p1] then
		t2[p1] = true
		p1.Equipped:Connect(function() --[[ Line: 44 | Upvalues: p1 (copy), LocalPlayer (ref), NotificationController (ref) ]]
			local v2 = LocalPlayer:GetAttribute("Friends")

			if if type(v2) == "number" then v2 > 0 else false then
				return
			end

			local v4 = p1.Parent

			if not v4 then
				return
			end

			if not v4:IsA("Model") then
				return
			end

			local Humanoid = v4:FindFirstChildOfClass("Humanoid")

			if Humanoid then
				Humanoid:UnequipTools()
			end

			NotificationController:CreateNotification("Friend in Server Required!")
		end)
		p1.AncestryChanged:Connect(function(p12, p2) --[[ Line: 57 | Upvalues: t2 (ref), p1 (copy) ]]
			if p2 ~= nil then
				return
			end

			t2[p1] = nil
		end)
	end
end

local function WatchContainer(p1) --[[ WatchContainer | Line: 64 | Upvalues: TryConnect (copy) ]]
	p1.ChildAdded:Connect(TryConnect)

	for v1, v2 in p1:GetChildren() do
		TryConnect(v2)
	end
end

function t.Init(p1) --[[ Init | Line: 71 ]] end
function t.Start(p1) --[[ Start | Line: 74 | Upvalues: LocalPlayer (copy), TryConnect (copy) ]]
	local Backpack = LocalPlayer:WaitForChild("Backpack")

	Backpack.ChildAdded:Connect(TryConnect)

	for v1, v2 in Backpack:GetChildren() do
		TryConnect(v2)
	end

	local function onCharacter(p1) --[[ onCharacter | Line: 80 | Upvalues: TryConnect (ref) ]]
		p1.ChildAdded:Connect(TryConnect)

		for v1, v2 in p1:GetChildren() do
			TryConnect(v2)
		end
	end

	if LocalPlayer.Character then
		local Character = LocalPlayer.Character

		Character.ChildAdded:Connect(TryConnect)

		for v3, v4 in Character:GetChildren() do
			TryConnect(v4)
		end
	end

	LocalPlayer.CharacterAdded:Connect(onCharacter)
end

return t