-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local AdminRemotes = ReplicatedStorage:WaitForChild("AdminRemotes")

if not AdminRemotes:WaitForChild("IsAdmin"):InvokeServer() then
	return
end

local BaseRemotes = ReplicatedStorage:WaitForChild("BaseRemotes")
local UnlockBase = BaseRemotes:WaitForChild("UnlockBase")
local EquipBase = BaseRemotes:WaitForChild("EquipBase")
local Admin = PlayerGui:WaitForChild("GUI").Frames:WaitForChild("Admin")

-- Toggle button (moved into the HUD grid) to open/close the admin panel
local AdminToggle = PlayerGui:WaitForChild("GUI").HUD.Left.Buttons:WaitForChild("Admin")
AdminToggle.Visible = true
AdminToggle.MouseButton1Click:Connect(function()
	Admin.Visible = not Admin.Visible
end)

local Pages = Admin:WaitForChild("Frame"):WaitForChild("Pages")
local Brainrots = Pages:WaitForChild("Brainrots")
local BrainrotList = Brainrots:WaitForChild("BrainrotList")
local TypeList = Brainrots:WaitForChild("TypeList")
local Start = Brainrots:WaitForChild("Start")
local Template = BrainrotList:WaitForChild("Template")
local Events = Pages:WaitForChild("Events")
local List = Events:WaitForChild("List")
local Start2 = Events:WaitForChild("Start")
local Template2 = List:WaitForChild("Template")
local Modded = Pages:WaitForChild("Modded")
local BaseSkin = Modded:WaitForChild("BaseSkin")
local BaseUnlock = Modded:WaitForChild("BaseUnlock")
local List2 = BaseUnlock:WaitForChild("Frame"):WaitForChild("List")
local DataReset = Modded:WaitForChild("DataReset")
local MoneyGiver = Modded:WaitForChild("MoneyGiver")
local Amount = MoneyGiver:WaitForChild("Amount")
local MoneySet = MoneyGiver:WaitForChild("MoneySet")
local RebirthGiver = Modded:WaitForChild("RebirthGiver")
local Amount2 = RebirthGiver:WaitForChild("Amount")
local RebirthSet = RebirthGiver:WaitForChild("RebirthSet")
local Brainrots2 = (ReplicatedStorage:FindFirstChild("Items") and ReplicatedStorage.Items:FindFirstChild("Normal")) or ReplicatedStorage:FindFirstChild("Brainrots")
local YoutuberTagRemote = ReplicatedStorage:WaitForChild("YoutuberTagRemote")
local Brainrots3 = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Brainrots"))
local EventConfig = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("EventConfig"))
local RarityColor = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("RarityColor"))
local AdminSpawnBrainrot = AdminRemotes:WaitForChild("AdminSpawnBrainrot")
local AdminWorldSpawnBrainrot = AdminRemotes:WaitForChild("AdminWorldSpawnBrainrot", 10)
local AdminRandomServerSpawnBrainrotV2 = AdminRemotes:WaitForChild("AdminRandomServerSpawnBrainrotV2", 10)
local StartEventAdmin = AdminRemotes:WaitForChild("StartEventAdmin")
local EndEventAdmin = AdminRemotes:WaitForChild("EndEventAdmin")
local AdminAction = AdminRemotes:WaitForChild("AdminAction")
local AdminAnnounce = AdminRemotes:WaitForChild("AdminAnnounce")
local AdminPrivateServer = AdminRemotes:WaitForChild("AdminPrivateServer")
local AdminPrivateServerResult = AdminRemotes:WaitForChild("AdminPrivateServerResult")
local AdminActionResult = AdminRemotes:WaitForChild("AdminActionResult")
local Frame = Admin.Frame:WaitForChild("Global"):WaitForChild("Frame")
local On = Frame:WaitForChild("On")

Frame:WaitForChild("Off")

local function findFirstTextBox(p1) --[[ findFirstTextBox | Line: 64 ]]
	if not p1 then
		return nil
	end

	if p1:IsA("TextBox") then
		return p1
	end

	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("TextBox") then
			return v
		end
	end

	return nil
end

local function findClickable(p1) --[[ findClickable | Line: 75 ]]
	if not p1 then
		return nil
	end

	if p1:IsA("GuiButton") then
		return p1
	end

	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("GuiButton") then
			return v
		end
	end

	return nil
end

local Search = Brainrots:FindFirstChild("Search")
local v1 = nil
local v2 = nil
local v3 = nil
local v4 = (if Search then Search:FindFirstChild("SpawnWorld", true) else nil) or Brainrots:FindFirstChild("SpawnWorld", true)

if v4 then
	v1 = v4:FindFirstChild("Box", true)

	if v1 and not v1:IsA("TextBox") then
		v1 = findFirstTextBox(v4)
	end

	v2 = findClickable(v4:FindFirstChild("Button", true) or v4)
end

if Search then
	for i, v in ipairs(Search:GetDescendants()) do
		if v:IsA("TextBox") and v ~= v1 then
			v3 = v

			break
		end
	end
end

if v1 then
	v1.ClearTextOnFocus = false

	if v1.Text == "" then
		v1.PlaceholderText = "Servidores"
	end
end

if v3 then
	v3.ClearTextOnFocus = false
end

local v5 = nil
local v6 = "Normal"
local t = {}
local t2 = {}
local t3 = {}

local function isGlobalMode() --[[ isGlobalMode | Line: 137 | Upvalues: On (copy) ]]
	return On.Visible
end

local function getSelectedTraitList() --[[ getSelectedTraitList | Line: 141 | Upvalues: t (ref) ]]
	local t2 = {}

	for k, v in pairs(t) do
		if v then
			table.insert(t2, k)
		end
	end

	table.sort(t2)

	return t2
end

local function getWorldServerCount() --[[ getWorldServerCount | Line: 152 | Upvalues: v1 (ref) ]]
	if v1 then
		local v6 = math.clamp(math.floor((math.abs(tonumber((tostring(v1.Text or ""):gsub("[^%d]", ""))) or 1))), 1, 100)

		v1.Text = tostring(v6)

		return v6
	end

	return 1
end

local function setTypeSelection(p1) --[[ setTypeSelection | Line: 165 | Upvalues: v6 (ref), TypeList (copy) ]]
	v6 = p1 or "Normal"

	for i, v in ipairs(TypeList:GetChildren()) do
		if v:IsA("GuiObject") then
			local Icon = v:FindFirstChild("Icon", true)

			if Icon and Icon:IsA("GuiObject") then
				Icon.Visible = v.Name == v6
			end
		end
	end
end

local function resetBrainrotTraits() --[[ resetBrainrotTraits | Line: 177 | Upvalues: t (ref), setTypeSelection (copy) ]]
	t = {}
	setTypeSelection("Normal")
end

local function setActiveEvent(p1, p2) --[[ setActiveEvent | Line: 182 | Upvalues: t3 (copy) ]]
	t3[p1] = if p2 == true then true else nil
end

local Announcement = Pages:WaitForChild("Announcement")
local Box = Announcement:WaitForChild("Message"):WaitForChild("Frame"):WaitForChild("Box")
local Announce = Announcement:WaitForChild("Announce")
local CustomAnnouncementName = nil
local v7 = if LocalPlayer.UserId == 71866637 then true else false

local function trimText(p1) --[[ trimText | Line: 192 ]]
	return tostring(p1 or ""):match("^%s*(.-)%s*$")
end

local function showAdminToast(p1, p2) --[[ showAdminToast | Line: 196 | Upvalues: StarterGui (copy) ]]
	pcall(function() --[[ Line: 197 | Upvalues: StarterGui (ref), p1 (copy), p2 (copy) ]]
		local t2 = {
			Title = "Admin"
		}

		t2.Text = tostring(p1 or "")
		t2.Duration = p2 or 4
		StarterGui:SetCore("SendNotification", t2)
	end)
end

if v7 then
	local Y = Box.AbsoluteSize.Y

	if not Y or Y <= 0 then
		Y = Box.Size.Y.Offset
	end

	if not Y or Y <= 0 then
		Y = 36
	end

	CustomAnnouncementName = Box:Clone()
	CustomAnnouncementName.Name = "CustomAnnouncementName"
	CustomAnnouncementName.Parent = Announcement
	CustomAnnouncementName.Text = ""
	CustomAnnouncementName.PlaceholderText = "Nome para aparecer no anuncio"
	CustomAnnouncementName.ClearTextOnFocus = false
	CustomAnnouncementName.AutomaticSize = Enum.AutomaticSize.None
	CustomAnnouncementName.Size = UDim2.new(Box.Size.X.Scale, Box.Size.X.Offset, 0, 34)
	CustomAnnouncementName.TextScaled = false
	CustomAnnouncementName.TextSize = 18
	CustomAnnouncementName.Position = UDim2.new(Box.Position.X.Scale, Box.Position.X.Offset, Box.Position.Y.Scale, Box.Position.Y.Offset + Y + 8)
	Announce.Position = UDim2.new(Announce.Position.X.Scale, Announce.Position.X.Offset, Announce.Position.Y.Scale, Announce.Position.Y.Offset + Y + 8)
end

local PrivateServer = Pages:WaitForChild("PrivateServer")
local Box2 = PrivateServer:WaitForChild("Message"):WaitForChild("Frame"):WaitForChild("Box")
local Announce2 = PrivateServer:WaitForChild("Announce")
local Status = PrivateServer:WaitForChild("Status")

local function hidePrivateServerLocks(p1) --[[ hidePrivateServerLocks | Line: 244 ]]
	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("GuiObject") then
			local v1 = string.lower(v.Name)

			if v1:find("lock") or (v1:find("locked") or v1:find("cadeado")) then
				v.Visible = false

				if v:IsA("GuiButton") then
					v.Active = false
				end
			end
		end
	end
end

local function showPrivateServerPage() --[[ showPrivateServerPage | Line: 258 | Upvalues: Pages (copy), PrivateServer (copy), hidePrivateServerLocks (copy) ]]
	for i, v in ipairs(Pages:GetChildren()) do
		if v:IsA("GuiObject") then
			v.Visible = v == PrivateServer
		end
	end

	PrivateServer.Visible = true
	PrivateServer.Active = true
	hidePrivateServerLocks(PrivateServer)
end

PrivateServer:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 269 | Upvalues: PrivateServer (copy), hidePrivateServerLocks (copy) ]]
	if not PrivateServer.Visible then
		return
	end

	hidePrivateServerLocks(PrivateServer)
end)

local Buttons = Admin.Frame:FindFirstChild("Buttons")

if Buttons then
	local v8 = Buttons:FindFirstChild("PrivateServer", true) or Buttons:FindFirstChild("Private Server", true)

	if v8 then
		local v9 = v8:IsA("GuiButton") and v8 or v8:FindFirstChildWhichIsA("GuiButton", true)

		if v9 then
			v9.MouseButton1Click:Connect(showPrivateServerPage)
		end

		hidePrivateServerLocks(v8)
	end
end

local ContentCreator = Pages:WaitForChild("ContentCreator")
local PlayerList = ContentCreator:WaitForChild("PlayerList")
local Template3 = PlayerList:WaitForChild("Template")
local Status2 = ContentCreator:WaitForChild("Status")
local Fun = Pages:WaitForChild("Fun")
local Box3 = Fun:WaitForChild("SingleMessage"):WaitForChild("Frame"):WaitForChild("Box")
local Box4 = Fun:WaitForChild("Player"):WaitForChild("Frame"):WaitForChild("Box")
local Box5 = Fun:WaitForChild("BrainrotName"):WaitForChild("Frame"):WaitForChild("Box")
local SingleAnnounce = Fun:WaitForChild("SingleAnnounce")
local Sound = Fun:WaitForChild("Sound")

if not Fun:FindFirstChild("Rocket") then
	local Rocket = Fun:WaitForChild("Dash"):Clone()

	Rocket.Name = "Rocket"
	Rocket.Parent = Fun
	Rocket.Position = UDim2.new(0.827, 0, 0.707000017, 0)

	local Title = Rocket:FindFirstChild("Title", true)

	if Title and Title:IsA("TextLabel") then
		Title.Text = "Rocket"
	end
end

local TopGlobal = Pages:WaitForChild("TopGlobal")
local Status3 = TopGlobal:WaitForChild("Status")
local Refresh = TopGlobal:WaitForChild("Refresh")
local Reset = TopGlobal:WaitForChild("Reset")
local Box6 = TopGlobal:WaitForChild("Message"):WaitForChild("Frame"):WaitForChild("Box")
local BlacklistAdd = TopGlobal:WaitForChild("BlacklistAdd")
local BlacklistRemove = TopGlobal:WaitForChild("BlacklistRemove")
local BlacklistList = TopGlobal:WaitForChild("BlacklistList")
local TopGlobalAdmin = AdminRemotes:WaitForChild("TopGlobalAdmin")
local TopGlobalGetState = AdminRemotes:WaitForChild("TopGlobalGetState")
local ServerLuck = Pages:WaitForChild("ServerLuck")
local List3 = ServerLuck:WaitForChild("List")
local tbl = {
	["2xServerLuck"] = false,
	["4xServerLuck"] = false,
	["8xServerLuck"] = false
}
local t4 = {
	["2xServerLuck"] = "ServerLuck2x",
	["4xServerLuck"] = "ServerLuck4x",
	["8xServerLuck"] = "ServerLuck8x"
}
local v10 = nil
local Start3 = ServerLuck:WaitForChild("Start")

local function setServerLuckChecked(p1, p2) --[[ setServerLuckChecked | Line: 337 | Upvalues: List3 (copy), tbl (copy), v10 (ref) ]]
	local v1 = List3:FindFirstChild(p1)

	if not v1 then
		return
	end

	local Frame = v1:FindFirstChild("Frame")

	if not Frame then
		return
	end

	local Button = Frame:FindFirstChild("Button")
	local v2 = if Button then Button:FindFirstChild("Icon") else Button

	if v2 then
		v2.Visible = p2 and true or false
	end

	tbl[p1] = if p2 == true then true else false

	if p2 then
		v10 = p1

		return
	end

	if v10 ~= p1 then
		return
	end

	v10 = nil
end

local function clearServerLuckSelection() --[[ clearServerLuckSelection | Line: 358 | Upvalues: tbl (copy), List3 (copy), v10 (ref) ]]
	for k, v in pairs(tbl) do
		local v1 = List3:FindFirstChild(k)

		if v1 then
			local Frame = v1:FindFirstChild("Frame")

			if Frame then
				local Button = Frame:FindFirstChild("Button")
				local v2 = if Button then Button:FindFirstChild("Icon") else Button

				if v2 then
					v2.Visible = false
				end

				tbl[k] = false

				if v10 == k then
					v10 = nil
				end
			end
		end
	end

	v10 = nil
end

local function toggleServerLuckOption(p1) --[[ toggleServerLuckOption | Line: 365 | Upvalues: v10 (ref), tbl (copy), List3 (copy) ]]
	if v10 == p1 then
		for k, v in pairs(tbl) do
			local v1 = List3:FindFirstChild(k)

			if v1 then
				local Frame = v1:FindFirstChild("Frame")

				if Frame then
					local Button = Frame:FindFirstChild("Button")
					local v2 = if Button then Button:FindFirstChild("Icon") else Button

					if v2 then
						v2.Visible = false
					end

					tbl[k] = false

					if v10 == k then
						v10 = nil
					end
				end
			end
		end

		v10 = nil
	else
		for k, v in pairs(tbl) do
			local v3 = List3:FindFirstChild(k)

			if v3 then
				local Frame = v3:FindFirstChild("Frame")

				if Frame then
					local Button = Frame:FindFirstChild("Button")
					local v4 = if Button then Button:FindFirstChild("Icon") else Button

					if v4 then
						v4.Visible = false
					end

					tbl[k] = false

					if v10 == k then
						v10 = nil
					end
				end
			end
		end

		v10 = nil

		local v5 = List3:FindFirstChild(p1)

		if not v5 then
			return
		end

		local Frame = v5:FindFirstChild("Frame")

		if not Frame then
			return
		end

		local Button = Frame:FindFirstChild("Button")
		local v6 = if Button then Button:FindFirstChild("Icon") else Button

		if v6 then
			v6.Visible = true
		end

		tbl[p1] = true
		v10 = p1
	end
end

for k, v in pairs(tbl) do
	local Frame2 = List3:WaitForChild(k):WaitForChild("Frame")

	Frame2:WaitForChild("Button"):WaitForChild("Icon").Visible = false

	local v11 = List3:FindFirstChild(k)

	if v11 then
		local Frame3 = v11:FindFirstChild("Frame")

		if Frame3 then
			local Button = Frame3:FindFirstChild("Button")
			local v12 = if Button then Button:FindFirstChild("Icon") else Button

			if v12 then
				v12.Visible = false
			end

			tbl[k] = false

			if v10 == k then
				v10 = nil
			end
		end
	end

	Frame2.MouseButton1Click:Connect(function() --[[ Line: 382 | Upvalues: k (copy), v10 (ref), tbl (copy), List3 (copy) ]]
		local v1 = k

		if v10 == v1 then
			for k2, v in pairs(tbl) do
				local v2 = List3:FindFirstChild(k2)

				if v2 then
					local Frame = v2:FindFirstChild("Frame")

					if Frame then
						local Button = Frame:FindFirstChild("Button")
						local v3 = if Button then Button:FindFirstChild("Icon") else Button

						if v3 then
							v3.Visible = false
						end

						tbl[k2] = false

						if v10 == k2 then
							v10 = nil
						end
					end
				end
			end

			v10 = nil
		else
			for k2, v in pairs(tbl) do
				local v4 = List3:FindFirstChild(k2)

				if v4 then
					local Frame = v4:FindFirstChild("Frame")

					if Frame then
						local Button = Frame:FindFirstChild("Button")
						local v5 = if Button then Button:FindFirstChild("Icon") else Button

						if v5 then
							v5.Visible = false
						end

						tbl[k2] = false

						if v10 == k2 then
							v10 = nil
						end
					end
				end
			end

			v10 = nil

			local v6 = List3:FindFirstChild(v1)

			if not v6 then
				return
			end

			local Frame = v6:FindFirstChild("Frame")

			if not Frame then
				return
			end

			local Button = Frame:FindFirstChild("Button")
			local v7 = if Button then Button:FindFirstChild("Icon") else Button

			if v7 then
				v7.Visible = true
			end

			tbl[v1] = true
			v10 = v1
		end
	end)
end

Start3.MouseButton1Click:Connect(function() --[[ Line: 387 | Upvalues: On (copy), v10 (ref), t4 (copy), StartEventAdmin (copy), t3 (copy), tbl (copy), List3 (copy) ]]
	local v1 = v10
	local v2 = if v1 then t4[v1] or nil else nil

	if not v2 then
		return
	end

	StartEventAdmin:FireServer(v2, nil, On.Visible)
	t3[v2] = true

	for k, v in pairs(tbl) do
		local v3 = List3:FindFirstChild(k)

		if v3 then
			local Frame = v3:FindFirstChild("Frame")

			if Frame then
				local Button = Frame:FindFirstChild("Button")
				local v4 = if Button then Button:FindFirstChild("Icon") else Button

				if v4 then
					v4.Visible = false
				end

				tbl[k] = false

				if v10 == k then
					v10 = nil
				end
			end
		end
	end

	v10 = nil
end)
Announce.MouseButton1Click:Connect(function() --[[ Line: 400 | Upvalues: Box (copy), CustomAnnouncementName (ref), AdminAnnounce (copy), On (copy) ]]
	local Text = Box.Text

	if not Text or Text == "" then
		return
	end

	local v1

	if CustomAnnouncementName then
		local v3 = tostring(CustomAnnouncementName.Text or ""):match("^%s*(.-)%s*$")

		v1 = if v3 == "" then nil else v3
	else
		v1 = nil
	end

	AdminAnnounce:FireServer(Text, On.Visible, v1)
	Box.Text = ""

	if not CustomAnnouncementName then
		return
	end

	CustomAnnouncementName.Text = ""
end)

local function getAnimator(p1) --[[ getAnimator | Line: 417 ]]
	local Brainrot = p1:FindFirstChild("Brainrot", true)

	if Brainrot then
		local AnimationController = Brainrot:FindFirstChildOfClass("AnimationController")

		if AnimationController then
			local Animator = AnimationController:FindFirstChildOfClass("Animator")

			if not Animator then
				local Animator2 = Instance.new("Animator")

				Animator2.Parent = AnimationController
				Animator = Animator2
			end

			return Animator
		end
	end

	local v1 = p1:FindFirstChildWhichIsA("Humanoid")

	if not v1 then
		return nil
	end

	local Animator = v1:FindFirstChildOfClass("Animator")

	if not Animator then
		local Animator2 = Instance.new("Animator")

		Animator2.Parent = v1
		Animator = Animator2
	end

	return Animator
end

local function showNotification(p1, p2, p3) --[[ showNotification | Line: 436 ]]
	if p1 then
		p1.Text = p2
		p1.Visible = true
		task.delay(p3 or 0, function() --[[ Line: 440 | Upvalues: p1 (copy) ]]
			p1.Visible = false
		end)
	end
end

local t5 = {}
local t6 = {}
local v13 = false

local function isGuiActuallyVisible(p1) --[[ isGuiActuallyVisible | Line: 456 | Upvalues: PlayerGui (copy) ]]
	local v1 = p1

	while v1 and v1 ~= PlayerGui do
		if v1:IsA("GuiObject") and v1.Visible == false then
			return false
		end

		v1 = v1.Parent
	end

	return true
end

local function isCardNearScrollView(p1, p2) --[[ isCardNearScrollView | Line: 467 ]]
	if not (p1 and p1.Parent) then
		return false
	end

	if not (p2 and p2:IsA("ScrollingFrame")) then
		return true
	end

	local Y = p1.AbsolutePosition.Y

	return if p2.AbsolutePosition.Y - 220 <= Y + p1.AbsoluteSize.Y then Y <= p2.AbsolutePosition.Y + p2.AbsoluteSize.Y + 220 else false
end

local function clearBrainrotViewport(p1) --[[ clearBrainrotViewport | Line: 483 ]]
	if not p1 then
		return
	end

	p1:SetAttribute("BrainrotViewportLoaded", nil)

	local WorldModel = p1:FindFirstChild("WorldModel", true)

	if WorldModel then
		for i, v in ipairs(WorldModel:GetChildren()) do
			v:Destroy()
		end
	end

	local ViewportFrame = p1:FindFirstChild("ViewportFrame", true)

	if not ViewportFrame then
		return
	end

	for i, v in ipairs(ViewportFrame:GetChildren()) do
		if v:IsA("Camera") or (v:IsA("WorldModel") or (v:IsA("Model") or (v:IsA("Folder") or v:IsA("BasePart")))) then
			v:Destroy()
		end
	end

	ViewportFrame.CurrentCamera = nil
end

local function getOrCreateViewportWorldModel(p1) --[[ getOrCreateViewportWorldModel | Line: 509 ]]
	local v1 = if p1 then p1:FindFirstChild("ViewportFrame", true) else p1

	if not (v1 and v1:IsA("ViewportFrame")) then
		return nil, nil
	end

	local WorldModel = v1:FindFirstChild("WorldModel")

	if not (WorldModel and WorldModel:IsA("WorldModel")) then
		local WorldModel2 = Instance.new("WorldModel")

		WorldModel2.Name = "WorldModel"
		WorldModel2.Parent = v1
		WorldModel = WorldModel2
	end

	return v1, WorldModel
end

local function hasRenderableViewportDescendant(p1) --[[ hasRenderableViewportDescendant | Line: 525 ]]
	if not p1 then
		return false
	end

	if p1:IsA("BasePart") then
		return true
	end

	return p1:FindFirstChildWhichIsA("BasePart", true) ~= nil
end

local function findViewportModelSource(p1) --[[ findViewportModelSource | Line: 537 | Upvalues: Brainrots2 (copy) ]]
	local v1 = Brainrots2:FindFirstChild((tostring(p1 or "")))

	if not v1 then
		return nil, nil
	end

	local Model = v1:FindFirstChild("Model")

	if Model and (if Model then if Model:IsA("BasePart") then true elseif Model:FindFirstChildWhichIsA("BasePart", true) == nil then false else true else false) then
		return Model, v1
	end

	for i, v in ipairs(v1:GetChildren()) do
		if (v:IsA("Model") or v:IsA("Folder")) and (if v then if v:IsA("BasePart") then true elseif v:FindFirstChildWhichIsA("BasePart", true) == nil then false else true else false) then
			return v, v1
		end
	end

	local v4 = v1:FindFirstChildWhichIsA("Model", true)

	if v4 and (if v4 then if v4:IsA("BasePart") then true elseif v4:FindFirstChildWhichIsA("BasePart", true) == nil then false else true else false) then
		return v4, v1
	end

	return nil, v1
end

local function prepareViewportModel(p1) --[[ prepareViewportModel | Line: 566 ]]
	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Anchored = true
			v.CanCollide = false
			v.CanTouch = false
			v.CanQuery = false
			v.CastShadow = false

			continue
		end

		if v:IsA("Script") or (v:IsA("LocalScript") or (v:IsA("ModuleScript") or (v:IsA("ProximityPrompt") or (v:IsA("BillboardGui") or v:IsA("SurfaceGui"))))) then
			v:Destroy()
		end
	end
end

local function tryPlayViewportIdle(p1, p2) --[[ tryPlayViewportIdle | Line: 585 ]] end

local function renderBrainrotViewport(p1, p2) --[[ renderBrainrotViewport | Line: 612 | Upvalues: getOrCreateViewportWorldModel (copy), findViewportModelSource (copy), prepareViewportModel (copy) ]]
	if not p1 or (not p1.Parent or p1:GetAttribute("BrainrotViewportLoaded") == true) then
		return
	end

	local v1, v2 = getOrCreateViewportWorldModel(p1)

	if not (v1 and v2) then
		return
	end

	v1.Visible = true
	v1.BackgroundTransparency = 1
	v1.LightColor = Color3.fromRGB(255, 255, 255)
	v1.Ambient = Color3.fromRGB(255, 255, 255)

	local v3, _ = findViewportModelSource(p2)

	if not v3 then
		return
	end

	for i, v in ipairs(v2:GetChildren()) do
		v:Destroy()
	end

	for i, v in ipairs(v1:GetChildren()) do
		if v:IsA("Camera") then
			v:Destroy()
		end
	end

	local ok, result = pcall(function() --[[ Line: 642 | Upvalues: v3 (copy) ]]
		return v3:Clone()
	end)

	if not (ok and result) then
		return
	end

	local v4

	if result:IsA("Model") then
		v4 = result
	else
		v4 = Instance.new("Model")
		v4.Name = tostring(p2 or result.Name or "Preview")

		for i, v in ipairs(result:GetChildren()) do
			v.Parent = v4
		end

		result:Destroy()
	end

	local v6 = v4

	if not (if v6 then if v6:IsA("BasePart") then true elseif v6:FindFirstChildWhichIsA("BasePart", true) == nil then false else true else false) then
		v4:Destroy()
	else
		local v8 = p2 or v4.Name

		v4.Name = tostring(v8)
		v4.Parent = v2
		prepareViewportModel(v4)

		local ok2, result2, result3 = pcall(function() --[[ Line: 671 | Upvalues: v4 (ref) ]]
			local v1, v2 = v4:GetBoundingBox()

			return v1, v2
		end)

		if not (ok2 and (result2 and result3)) then
			v4:Destroy()
		else
			pcall(function() --[[ Line: 681 | Upvalues: v4 (ref), result2 (ref) ]]
				v4:PivotTo(result2 * CFrame.Angles(0, 2.530727415391778, 0))
			end)

			local ok3, result4, result5 = pcall(function() --[[ Line: 685 | Upvalues: v4 (ref) ]]
				local v1, v2 = v4:GetBoundingBox()

				return v1, v2
			end)
			local v9 = result4

			if ok3 and (v9 and result5) then
				local Camera = Instance.new("Camera")

				Camera.FieldOfView = 38
				Camera.Parent = v1
				v1.CurrentCamera = Camera

				local v12 = math.max(math.max(result5.X, result5.Y, result5.Z, 1) * 2.05, result5.Magnitude * 0.85, 4)
				local v14 = v9.Position + Vector3.new(0, result5.Y * 0.05, 0)

				Camera.CFrame = CFrame.new(v9.Position + Vector3.new(0, result5.Y * 0.18, v12), v14)
				p1:SetAttribute("BrainrotViewportLoaded", true)
			else
				v4:Destroy()
			end
		end
	end
end

local function requestViewportQueueProcess() --[[ requestViewportQueueProcess | Line: 709 | Upvalues: v13 (ref), t5 (copy), t6 (copy), renderBrainrotViewport (copy) ]]
	if not v13 then
		v13 = true
		task.spawn(function() --[[ Line: 715 | Upvalues: t5 (ref), t6 (ref), renderBrainrotViewport (ref), v13 (ref) ]]
			while #t5 > 0 do
				local v1 = table.remove(t5, 1)
				local card = v1.card

				t6[card] = nil

				if not card or (not card.Parent or (card.Visible ~= true or card:GetAttribute("BrainrotViewportLoaded") == true)) then
					continue
				end

				renderBrainrotViewport(card, v1.brainrotId)
				task.wait(0.035)
			end

			v13 = false
		end)
	end
end

local function queueBrainrotViewport(p1, p2, p3) --[[ queueBrainrotViewport | Line: 734 | Upvalues: t6 (copy), t5 (copy), v13 (ref), renderBrainrotViewport (copy) ]]
	if not p1 or (not p1.Parent or p1:GetAttribute("BrainrotViewportLoaded") == true) then
		return
	end

	if t6[p1] then
		return
	end

	t6[p1] = true

	local v1 = t5

	table.insert(v1, {
		card = p1,
		brainrotId = p2,
		container = p3
	})

	if not v13 then
		v13 = true
		task.spawn(function() --[[ Line: 715 | Upvalues: t5 (ref), t6 (ref), renderBrainrotViewport (ref), v13 (ref) ]]
			while #t5 > 0 do
				local v1 = table.remove(t5, 1)
				local card = v1.card

				t6[card] = nil

				if not card or (not card.Parent or (card.Visible ~= true or card:GetAttribute("BrainrotViewportLoaded") == true)) then
					continue
				end

				renderBrainrotViewport(card, v1.brainrotId)
				task.wait(0.035)
			end

			v13 = false
		end)
	end
end

local function getTrimmedBoxText(p1) --[[ getTrimmedBoxText | Line: 753 | Upvalues: trimText (copy) ]]
	if p1 then
		return trimText(p1.Text)
	end

	return ""
end

local function fireFunAction(p1, ...) --[[ fireFunAction | Line: 760 | Upvalues: AdminAction (copy) ]]
	AdminAction:FireServer(p1, ...)
end

AdminPrivateServerResult.OnClientEvent:Connect(function(p1, p2) --[[ Line: 764 | Upvalues: Status (copy) ]]
	local v1 = Status
	local v2 = tostring(p1 or "")
	local v3 = p2 or 4

	if v1 then
		v1.Text = v2
		v1.Visible = true
		task.delay(v3 or 0, function() --[[ Line: 440 | Upvalues: v1 (copy) ]]
			v1.Visible = false
		end)
	end
end)

if AdminActionResult and AdminActionResult:IsA("RemoteEvent") then
	AdminActionResult.OnClientEvent:Connect(function(p1, p2) --[[ Line: 769 | Upvalues: StarterGui (copy) ]]
		local v1 = p2 or 4

		pcall(function() --[[ Line: 197 | Upvalues: StarterGui (ref), p1 (copy), v1 (copy) ]]
			local t2 = {
				Title = "Admin"
			}

			t2.Text = tostring(p1 or "")
			t2.Duration = v1 or 4
			StarterGui:SetCore("SendNotification", t2)
		end)
	end)
end

YoutuberTagRemote.OnClientEvent:Connect(function(p1, p2) --[[ Line: 774 | Upvalues: Status2 (copy) ]]
	if p1 == "GrantResult" then
		local v2 = Status2
		local v3 = tostring(if p2 then p2.message or "" else "")

		if v2 then
			v2.Text = v3
			v2.Visible = true
			task.delay(4, function() --[[ Line: 440 | Upvalues: v2 (copy) ]]
				v2.Visible = false
			end)
		end
	else
		if p1 ~= "ShowWarningYoutuber" then
			return
		end

		local v5 = Status2
		local v6 = "Content Creator aplicado para @" .. tostring(if p2 then p2.displayName or (p2.name or "") else "") .. "."

		if not v5 then
			return
		end

		v5.Text = v6
		v5.Visible = true
		task.delay(4, function() --[[ Line: 440 | Upvalues: v5 (copy) ]]
			v5.Visible = false
		end)
	end
end)
Announce2.MouseButton1Click:Connect(function() --[[ Line: 787 | Upvalues: Box2 (copy), Status (copy), AdminPrivateServer (copy) ]]
	local v2 = tostring(Box2.Text or ""):match("^%s*(.-)%s*$")

	if v2 == "" then
		local v3 = Status

		if v3 then
			v3.Text = "Digite o nick do player."
			v3.Visible = true
			task.delay(3, function() --[[ Line: 440 | Upvalues: v3 (copy) ]]
				v3.Visible = false
			end)
		end
	else
		local v4 = Status

		if v4 then
			v4.Text = "Processando servidor reservado..."
			v4.Visible = true
			task.delay(2, function() --[[ Line: 440 | Upvalues: v4 (copy) ]]
				v4.Visible = false
			end)
		end

		AdminPrivateServer:FireServer(v2)
	end
end)

local function refreshContentCreatorList() --[[ refreshContentCreatorList | Line: 798 | Upvalues: PlayerList (copy), Players (copy), Template3 (copy), YoutuberTagRemote (copy), Status2 (copy) ]]
	for i, v in ipairs(PlayerList:GetChildren()) do
		if v:IsA("GuiButton") and v.Name ~= "Template" then
			v:Destroy()
		end
	end

	local v1 = Players:GetPlayers()

	table.sort(v1, function(p1, p2) --[[ Line: 806 ]]
		return string.lower(p1.Name) < string.lower(p2.Name)
	end)

	for i, v in ipairs(v1) do
		local v2 = Template3:Clone()

		v2.Name = tostring(v.UserId)
		v2.Visible = true
		v2.Parent = PlayerList

		local Avatar = v2:FindFirstChild("Avatar")

		if Avatar then
			Avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. v.UserId .. "&w=150&h=150"
		end

		local PlayerName = v2:FindFirstChild("PlayerName")

		if PlayerName then
			PlayerName.Text = v.DisplayName
		end

		local Meta = v2:FindFirstChild("Meta")

		if Meta then
			Meta.Text = "@" .. v.Name
		end

		v2.MouseButton1Click:Connect(function() --[[ Line: 831 | Upvalues: YoutuberTagRemote (ref), v (copy), Status2 (ref) ]]
			YoutuberTagRemote:FireServer("GrantYoutuberTag", v.UserId)

			local v1 = Status2
			local v2 = "Enviando Content Creator para @" .. v.Name .. "..."

			if v1 then
				v1.Text = v2
				v1.Visible = true
				task.delay(4, function() --[[ Line: 440 | Upvalues: v1 (copy) ]]
					v1.Visible = false
				end)
			end
		end)
	end

	local UIListLayout = PlayerList:FindFirstChildOfClass("UIListLayout")

	if not UIListLayout then
		return
	end

	PlayerList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 12)
end

ContentCreator:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 843 | Upvalues: ContentCreator (copy), refreshContentCreatorList (copy) ]]
	if not ContentCreator.Visible then
		return
	end

	refreshContentCreatorList()
end)

local function clearGuiChildren(p1) --[[ clearGuiChildren | Line: 849 ]]
	for i, v in ipairs(p1:GetChildren()) do
		if v:IsA("GuiObject") and (v.Name ~= "Template" and not (v:IsA("UIListLayout") or (v:IsA("UIPadding") or (v:IsA("UIStroke") or v:IsA("UICorner"))))) then
			v:Destroy()
		end
	end
end

local function tryResolveUserId(p1) --[[ tryResolveUserId | Line: 857 | Upvalues: Players (copy) ]]
	local v1 = tostring(p1 or ""):gsub("^%s+", ""):gsub("%s+$", "")

	if v1 == "" then
		return nil
	end

	local v2 = tonumber(v1)

	if v2 and v2 > 0 then
		return math.floor(v2)
	end

	local v5 = string.lower(if v1:sub(1, 1) == "@" then v1:sub(2) else v1)

	for i, v in ipairs(Players:GetPlayers()) do
		if string.lower(v.Name) == v5 or string.lower(v.DisplayName) == v5 then
			return v.UserId
		end
	end

	return nil
end

local function renderBlacklist(p1) --[[ renderBlacklist | Line: 883 | Upvalues: clearGuiChildren (copy), BlacklistList (copy), TopGlobalAdmin (copy), Status3 (copy), Players (copy) ]]
	clearGuiChildren(BlacklistList)

	local Template = BlacklistList:FindFirstChild("Template")
	local UIListLayout = BlacklistList:FindFirstChildOfClass("UIListLayout")

	if not (Template and Template:IsA("GuiButton")) then
		return
	end

	for v3, v4 in ipairs(if p1 then p1 else {}) do
		local v5 = Template:Clone()

		v5.Name = tostring(v4)
		v5.Visible = true
		v5.Parent = BlacklistList

		local PlayerName = v5:FindFirstChild("PlayerName")

		if PlayerName and PlayerName:IsA("TextLabel") then
			PlayerName.Text = tostring(v4)
		end

		local Meta = v5:FindFirstChild("Meta")

		if Meta and Meta:IsA("TextLabel") then
			Meta.Text = "BLACKLIST"
		end

		local Action = v5:FindFirstChild("Action")

		if Action and Action:IsA("TextLabel") then
			Action.Text = "REMOVE"
		end

		v5.MouseButton1Click:Connect(function() --[[ Line: 913 | Upvalues: TopGlobalAdmin (ref), v4 (copy), Status3 (ref) ]]
			TopGlobalAdmin:FireServer("BlacklistRemove", v4)

			local v1 = Status3
			local v3 = "Removido da blacklist: " .. tostring(v4)

			if v1 then
				v1.Text = v3
				v1.Visible = true
				task.delay(3, function() --[[ Line: 440 | Upvalues: v1 (copy) ]]
					v1.Visible = false
				end)
			end

			refreshTopGlobalState()
		end)
		task.spawn(function() --[[ Line: 919 | Upvalues: Players (ref), v4 (copy), v5 (copy), PlayerName (copy), Meta (copy) ]]
			local ok, result = pcall(function() --[[ Line: 920 | Upvalues: Players (ref), v4 (ref) ]]
				return Players:GetNameFromUserIdAsync(v4)
			end)

			if not ok or (type(result) ~= "string" or (result == "" or not (v5 and v5.Parent))) then
				return
			end

			if PlayerName and PlayerName.Parent then
				PlayerName.Text = "@" .. result
			end

			if not (Meta and Meta.Parent) then
				return
			end

			local v1 = v4

			Meta.Text = tostring(v1)
		end)
	end

	if not UIListLayout then
		return
	end

	BlacklistList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 12)
end

local function refreshTopGlobalState() --[[ refreshTopGlobalState | Line: 939 | Upvalues: TopGlobalGetState (copy), Status3 (copy), renderBlacklist (copy) ]]
	local v1 = TopGlobalGetState:InvokeServer()

	if v1 then
		renderBlacklist(v1.blacklist or {})

		local v4 = Status3
		local v7 = tostring(v1.storeName or "?")
		local v10 = "Store: " .. v7 .. " | BL: " .. tostring(#(v1.blacklist or {}))

		if v4 then
			v4.Text = v10
			v4.Visible = true
			task.delay(3, function() --[[ Line: 440 | Upvalues: v4 (copy) ]]
				v4.Visible = false
			end)
		end
	else
		local v11 = Status3

		if v11 then
			v11.Text = "Sem permissao."
			v11.Visible = true
			task.delay(3, function() --[[ Line: 440 | Upvalues: v11 (copy) ]]
				v11.Visible = false
			end)
		end
	end
end

Refresh.MouseButton1Click:Connect(function() --[[ Line: 950 | Upvalues: TopGlobalAdmin (copy), refreshTopGlobalState (copy) ]]
	TopGlobalAdmin:FireServer("Refresh")
	refreshTopGlobalState()
end)
Reset.MouseButton1Click:Connect(function() --[[ Line: 955 | Upvalues: TopGlobalAdmin (copy), Status3 (copy), refreshTopGlobalState (copy) ]]
	TopGlobalAdmin:FireServer("Reset")

	local v1 = Status3

	if v1 then
		v1.Text = "Reset enviado (novo top)."
		v1.Visible = true
		task.delay(4, function() --[[ Line: 440 | Upvalues: v1 (copy) ]]
			v1.Visible = false
		end)
	end

	refreshTopGlobalState()
end)
BlacklistAdd.MouseButton1Click:Connect(function() --[[ Line: 961 | Upvalues: tryResolveUserId (copy), Box6 (copy), Status3 (copy), TopGlobalAdmin (copy), refreshTopGlobalState (copy) ]]
	local v1 = tryResolveUserId(Box6.Text)

	if v1 then
		TopGlobalAdmin:FireServer("BlacklistAdd", v1)
		Box6.Text = ""

		local v2 = Status3
		local v3 = "Adicionado na blacklist: " .. tostring(v1)

		if v2 then
			v2.Text = v3
			v2.Visible = true
			task.delay(3, function() --[[ Line: 440 | Upvalues: v2 (copy) ]]
				v2.Visible = false
			end)
		end

		refreshTopGlobalState()
	else
		local v4 = Status3

		if v4 then
			v4.Text = "Digite UserId ou @Nome (online)."
			v4.Visible = true
			task.delay(4, function() --[[ Line: 440 | Upvalues: v4 (copy) ]]
				v4.Visible = false
			end)
		end
	end
end)
BlacklistRemove.MouseButton1Click:Connect(function() --[[ Line: 973 | Upvalues: tryResolveUserId (copy), Box6 (copy), Status3 (copy), TopGlobalAdmin (copy), refreshTopGlobalState (copy) ]]
	local v1 = tryResolveUserId(Box6.Text)

	if v1 then
		TopGlobalAdmin:FireServer("BlacklistRemove", v1)
		Box6.Text = ""

		local v2 = Status3
		local v3 = "Removido da blacklist: " .. tostring(v1)

		if v2 then
			v2.Text = v3
			v2.Visible = true
			task.delay(3, function() --[[ Line: 440 | Upvalues: v2 (copy) ]]
				v2.Visible = false
			end)
		end

		refreshTopGlobalState()
	else
		local v4 = Status3

		if v4 then
			v4.Text = "Digite UserId ou @Nome (online)."
			v4.Visible = true
			task.delay(4, function() --[[ Line: 440 | Upvalues: v4 (copy) ]]
				v4.Visible = false
			end)
		end
	end
end)
TopGlobal:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 985 | Upvalues: TopGlobal (copy), refreshTopGlobalState (copy) ]]
	if not TopGlobal.Visible then
		return
	end

	refreshTopGlobalState()
end)
SingleAnnounce.MouseButton1Click:Connect(function() --[[ Line: 991 | Upvalues: Box3 (copy), fireFunAction (copy), Box4 (copy) ]]
	local v1 = Box3
	local v2 = if v1 then tostring(v1.Text or ""):match("^%s*(.-)%s*$") else ""

	if v2 == "" then
		return
	end

	local v7 = Box4

	fireFunAction("SingleAnnounce", if v7 then tostring(v7.Text or ""):match("^%s*(.-)%s*$") else "", v2)
end)
Sound.MouseButton1Click:Connect(function() --[[ Line: 1000 | Upvalues: Box5 (copy), fireFunAction (copy), Box4 (copy) ]]
	local v1 = Box5
	local v2 = if v1 then tostring(v1.Text or ""):match("^%s*(.-)%s*$") else ""

	if v2 == "" then
		return
	end

	local v7 = Box4

	fireFunAction("Sound", if v7 then tostring(v7.Text or ""):match("^%s*(.-)%s*$") else "", v2)
end)

for i, v in ipairs({ "Rainbow", "Big", "Tiny", "Invert", "Avatar", "Jump", "Dash", "Rocket" }) do
	local v14 = Fun:FindFirstChild(v)

	if v14 and v14:IsA("GuiButton") then
		v14.MouseButton1Click:Connect(function() --[[ Line: 1012 | Upvalues: fireFunAction (copy), v (copy), getTrimmedBoxText (copy), Box4 (copy) ]]
			fireFunAction(v, getTrimmedBoxText(Box4))
		end)
	end
end

Players.PlayerAdded:Connect(function() --[[ Line: 1018 | Upvalues: ContentCreator (copy), refreshContentCreatorList (copy) ]]
	if not ContentCreator.Visible then
		return
	end

	refreshContentCreatorList()
end)
Players.PlayerRemoving:Connect(function() --[[ Line: 1024 | Upvalues: ContentCreator (copy), refreshContentCreatorList (copy) ]]
	if not ContentCreator.Visible then
		return
	end

	refreshContentCreatorList()
end)
BaseUnlock.Visible = false
BaseSkin.MouseButton1Click:Connect(function() --[[ Line: 1031 | Upvalues: BaseUnlock (copy) ]]
	BaseUnlock.Visible = not BaseUnlock.Visible
end)

for i, v in ipairs(List2:GetChildren()) do
	if v:IsA("Frame") then
		local v15 = v.Name
		local Frame2 = v:FindFirstChild("Frame")

		if Frame2 then
			local Unlock = Frame2:FindFirstChild("Unlock")

			if Unlock then
				Unlock.MouseButton1Click:Connect(function() --[[ Line: 1043 | Upvalues: UnlockBase (copy), v15 (copy), EquipBase (copy), Unlock (copy) ]]
					UnlockBase:FireServer(v15)
					EquipBase:FireServer(v15)
					Unlock.Text = "Equipado!"
					task.delay(2, function() --[[ Line: 1047 | Upvalues: Unlock (ref) ]]
						Unlock.Text = "Unlock"
					end)
				end)
			end
		end
	end
end

DataReset.MouseButton1Click:Connect(function() --[[ Line: 1053 | Upvalues: AdminAction (copy) ]]
	AdminAction:FireServer("ResetData")
end)
MoneySet.MouseButton1Click:Connect(function() --[[ Line: 1057 | Upvalues: Amount (copy), AdminAction (copy) ]]
	local v1 = tonumber(Amount.Text)

	if v1 then
		AdminAction:FireServer("SetMoney", (math.floor((math.abs(v1)))))
	end
end)
RebirthSet.MouseButton1Click:Connect(function() --[[ Line: 1064 | Upvalues: Amount2 (copy), AdminAction (copy) ]]
	local v1 = tonumber(Amount2.Text)

	if not v1 then
		return
	end

	local v3 = math.floor((math.abs(v1)))

	if not (v3 > 12) then
		AdminAction:FireServer("SetRebirth", v3)
	end
end)

local list = {}

for k, v in pairs(Brainrots3) do
	table.insert(list, {
		id = k,
		data = v
	})
end

table.sort(list, function(p1, p2) --[[ Line: 1080 | Upvalues: RarityColor (copy) ]]
	local v1 = RarityColor.RARITY_ORDER[p1.data.Rarity] or 999
	local v2 = RarityColor.RARITY_ORDER[p2.data.Rarity] or 999

	if v1 == v2 then
		return p1.data.Name < p2.data.Name
	end

	return v1 < v2
end)

local t7 = {}
local v16 = 0

for i, v in ipairs(list) do
	local v17 = Template:Clone()

	v17.Name = v.id
	v17.Visible = true
	v17.Parent = BrainrotList

	local t8 = {
		card = v17
	}

	t8.id = tostring(v.id or "")
	t8.name = tostring(v.data and v.data.Name or (v.id or ""))
	t8.rarity = tostring(v.data and v.data.Rarity or "")
	table.insert(t7, t8)

	local BrainrotName = v17:FindFirstChild("BrainrotName", true)

	if BrainrotName then
		BrainrotName.Text = v.data.Name
	end

	local BrainrotRarity = v17:FindFirstChild("BrainrotRarity", true)

	if BrainrotRarity then
		BrainrotRarity.Text = v.data.Rarity or "Common"
		BrainrotRarity.TextColor3 = RarityColor.GetRarityColor(v.data.Rarity)
		RarityColor.ApplyStroke(BrainrotRarity, v.data.Rarity)
	end

	local Equipped = v17:FindFirstChild("Equipped", true)

	if Equipped then
		Equipped.Visible = false
	end

	clearBrainrotViewport(v17)

	local Frame2 = v17:FindFirstChild("Frame", true)

	if Frame2 then
		Frame2.MouseButton1Click:Connect(function() --[[ Line: 1124 | Upvalues: BrainrotList (copy), Equipped (copy), v5 (ref), v (copy), t (ref), setTypeSelection (copy) ]]
			for i, v2 in ipairs(BrainrotList:GetChildren()) do
				if v2:IsA("Frame") and v2.Name ~= "Template" then
					local Equipped2 = v2:FindFirstChild("Equipped", true)

					if Equipped2 then
						Equipped2.Visible = false
					end
				end
			end

			if Equipped then
				Equipped.Visible = true
			end

			v5 = v.id
			t = {}
			setTypeSelection("Normal")
		end)
	end
end

local v21 = BrainrotList:FindFirstChildOfClass("UIGridLayout") or BrainrotList:FindFirstChildOfClass("UIListLayout")

if v21 then
	BrainrotList.CanvasSize = UDim2.new(0, 0, 0, v21.AbsoluteContentSize.Y + 10)
end

local function cleanSearchText(p1) --[[ cleanSearchText | Line: 1143 ]]
	local v1 = tostring(p1 or ""):lower()

	for k, v in pairs({
		["\195\161"] = "a",
		["\195\160"] = "a",
		["\195\163"] = "a",
		["\195\162"] = "a",
		["\195\169"] = "e",
		["\195\170"] = "e",
		["\195\173"] = "i",
		["\195\179"] = "o",
		["\195\180"] = "o",
		["\195\181"] = "o",
		["\195\186"] = "u",
		["\195\167"] = "c"
	}) do
		v1 = v1:gsub(k, v)
	end

	return v1:gsub("[^%w]+", " "):gsub("^%s+", ""):gsub("%s+$", ""):gsub("%s+", " ")
end

local v22 = false

local function queueVisibleBrainrotViewports() --[[ queueVisibleBrainrotViewports | Line: 1163 | Upvalues: t7 (copy), queueBrainrotViewport (copy), BrainrotList (copy) ]]
	for i, v in ipairs(t7) do
		local card = v.card

		if card and (card.Parent and card.Visible == true) then
			queueBrainrotViewport(card, v.id, BrainrotList)
		end
	end
end

local function scheduleBrainrotViewportQueue() --[[ scheduleBrainrotViewportQueue | Line: 1172 | Upvalues: v22 (ref), queueVisibleBrainrotViewports (copy) ]]
	if not v22 then
		v22 = true
		task.defer(function() --[[ Line: 1178 | Upvalues: v22 (ref), queueVisibleBrainrotViewports (ref) ]]
			v22 = false
			queueVisibleBrainrotViewports()
		end)
	end
end

local function applyBrainrotSearch() --[[ applyBrainrotSearch | Line: 1184 | Upvalues: v3 (ref), cleanSearchText (copy), t7 (copy), v22 (ref), queueVisibleBrainrotViewports (copy) ]]
	if not v3 then
		return
	end

	local list = {}

	for v1 in cleanSearchText(v3.Text):gmatch("%S+") do
		table.insert(list, v1)
	end

	for i, v in ipairs(t7) do
		local card = v.card

		if card and card.Parent then
			local v32 = tostring(v.id)
			local v4 = tostring(v.name)
			local v5 = cleanSearchText(v32 .. " " .. v4 .. " " .. tostring(v.rarity))
			local v6 = true

			for i2, v7 in ipairs(list) do
				if not v5:find(v7, 1, true) then
					v6 = false

					break
				end
			end

			card.Visible = v6
		end
	end

	if not v22 then
		v22 = true
		task.defer(function() --[[ Line: 1178 | Upvalues: v22 (ref), queueVisibleBrainrotViewports (ref) ]]
			v22 = false
			queueVisibleBrainrotViewports()
		end)
	end
end

if v3 then
	v3:GetPropertyChangedSignal("Text"):Connect(applyBrainrotSearch)
	applyBrainrotSearch()
else
	scheduleBrainrotViewportQueue()
end

BrainrotList:GetPropertyChangedSignal("CanvasPosition"):Connect(scheduleBrainrotViewportQueue)
BrainrotList:GetPropertyChangedSignal("AbsoluteSize"):Connect(scheduleBrainrotViewportQueue)
Brainrots:GetPropertyChangedSignal("Visible"):Connect(scheduleBrainrotViewportQueue)
Admin:GetPropertyChangedSignal("Visible"):Connect(scheduleBrainrotViewportQueue)
task.defer(scheduleBrainrotViewportQueue)
task.delay(0.35, scheduleBrainrotViewportQueue)
task.delay(1.2, scheduleBrainrotViewportQueue)

for i, v in ipairs(TypeList:GetChildren()) do
	if v:IsA("GuiObject") then
		local v23 = v:FindFirstChildWhichIsA("GuiButton", true)

		if not v23 and v:IsA("GuiButton") then
			v23 = v
		end

		if v23 then
			v23.MouseButton1Click:Connect(function() --[[ Line: 1236 | Upvalues: v6 (ref), v (copy), setTypeSelection (copy) ]]
				if v6 == v.Name then
					setTypeSelection("Normal")
				else
					setTypeSelection(v.Name)
				end
			end)
		end
	end
end

setTypeSelection("Normal")

local MutationsList = Brainrots:WaitForChild("MutationsList")
local Template4 = MutationsList:WaitForChild("Template")

local function getTraitIcon(p1) --[[ getTraitIcon | Line: 1249 | Upvalues: EventConfig (copy) ]]
	local v1 = EventConfig.Events[p1]

	if v1 and v1.Icon then
		return v1.Icon
	end

	return ({
		Ice = "rbxassetid://108593102772285",
		Sound = "rbxassetid://109371748822715",
		Stars = "rbxassetid://135213133507900",
		Flower = "rbxassetid://108991520533746",
		Hacker = "rbxassetid://82477760525511",
		Taco = "rbxassetid://131727959396765",
		Fire = "rbxassetid://80190608432780",
		Cupcake = "rbxassetid://114009704386698"
	})[p1] or ""
end

local function getTraitDisplayName(p1) --[[ getTraitDisplayName | Line: 1267 | Upvalues: EventConfig (copy) ]]
	local v1 = EventConfig.Events[p1]

	if v1 and v1.Name then
		return v1.Name
	end

	return p1
end

for k, v in pairs(EventConfig.Events) do
	if k ~= "Lava" and k ~= "Galaxy" then
		local v24 = Template4:Clone()

		v24.Name = k
		v24.Visible = true
		v24.Parent = MutationsList

		local Frame2 = v24:FindFirstChild("Frame")

		if Frame2 then
			local Title = Frame2:FindFirstChild("Title")

			if Title then
				Title.Text = getTraitDisplayName(k)
			end

			local Button = Frame2:FindFirstChild("Button")
			local v25 = Button and Button:FindFirstChild("Icon")

			if v25 then
				v25.Visible = false
			end

			Frame2.MouseButton1Click:Connect(function() --[[ Line: 1295 | Upvalues: Frame2 (copy), t (ref), k (copy) ]]
				local Button = Frame2:FindFirstChild("Button")
				local v1 = if Button then Button:FindFirstChild("Icon") else Button

				if t[k] then
					t[k] = nil

					if v1 then
						v1.Visible = false
					end
				else
					t[k] = true

					if not v1 then
						return
					end

					v1.Visible = true
				end
			end)
		end
	end
end

local UIListLayout = MutationsList:FindFirstChildOfClass("UIListLayout")

if UIListLayout then
	MutationsList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end

Start.MouseButton1Click:Connect(function() --[[ Line: 1314 | Upvalues: v5 (ref), v16 (ref), AdminSpawnBrainrot (copy), v6 (ref), getSelectedTraitList (copy), On (copy), t (ref), setTypeSelection (copy) ]]
	if not v5 then
		return
	end

	local v1 = tick()

	if not (v1 - v16 < 1) then
		v16 = v1
		AdminSpawnBrainrot:FireServer(v5, v6, getSelectedTraitList(), On.Visible)
		t = {}
		setTypeSelection("Normal")
	end
end)

if v2 then
	v2.Active = true
	v2.MouseButton1Click:Connect(function() --[[ Line: 1327 | Upvalues: v5 (ref), StarterGui (copy), AdminWorldSpawnBrainrot (copy), v16 (ref), v6 (ref), getSelectedTraitList (copy), v1 (ref), t (ref), setTypeSelection (copy) ]]
		if not v5 then
			local v12 = "Selecione um brainrot primeiro."
			local v2 = 3

			pcall(function() --[[ Line: 197 | Upvalues: StarterGui (ref), v12 (copy), v2 (copy) ]]
				local t2 = {
					Title = "Admin"
				}

				t2.Text = tostring(v12 or "")
				t2.Duration = v2 or 4
				StarterGui:SetCore("SendNotification", t2)
			end)

			return
		end

		if not AdminWorldSpawnBrainrot then
			local v3 = "Remote AdminWorldSpawnBrainrot nao encontrado no servidor."
			local v4 = 4

			pcall(function() --[[ Line: 197 | Upvalues: StarterGui (ref), v3 (copy), v4 (copy) ]]
				local t2 = {
					Title = "Admin"
				}

				t2.Text = tostring(v3 or "")
				t2.Duration = v4 or 4
				StarterGui:SetCore("SendNotification", t2)
			end)

			return
		end

		local v52 = tick()

		if v52 - v16 < 1 then
			return
		end

		v16 = v52

		local v9 = getSelectedTraitList()
		local v10

		if v1 then
			local v162 = math.clamp(math.floor((math.abs(tonumber((tostring(v1.Text or ""):gsub("[^%d]", ""))) or 1))), 1, 100)

			v1.Text = tostring(v162)
			v10 = v162
		else
			v10 = 1
		end

		AdminWorldSpawnBrainrot:FireServer(v5, v6, v9, v10)
		t = {}
		setTypeSelection("Normal")
	end)
else
	warn("[AdminPanel] SpawnWorld nao encontrado. Caminho esperado: Brainrots > Search > SpawnWorld > Button/Box")
end

(function() --[[ setupRandomServerPage | Line: 1352 | Upvalues: Pages (copy), findFirstTextBox (copy), StarterGui (copy), queueBrainrotViewport (copy), clearBrainrotViewport (copy), cleanSearchText (copy), list (copy), RarityColor (copy), findClickable (copy), EventConfig (copy), AdminRandomServerSpawnBrainrotV2 (copy) ]]
	local RandomServer = Pages:FindFirstChild("RandomServer")

	if not RandomServer then
		warn("[AdminPanel] Pagina RandomServer nao encontrada dentro de Pages.")

		return
	end

	local BrainrotList = RandomServer:FindFirstChild("BrainrotList")
	local TypeList = RandomServer:FindFirstChild("TypeList")
	local MutationsList = RandomServer:FindFirstChild("MutationsList")
	local Start = RandomServer:FindFirstChild("Start")
	local Select = RandomServer:FindFirstChild("Select")

	if not (BrainrotList and (TypeList and (MutationsList and Start))) then
		warn("[AdminPanel] RandomServer incompleto. Precisa ter BrainrotList, TypeList, MutationsList e Start.")

		return
	end

	local Template = BrainrotList:FindFirstChild("Template")
	local Template2 = MutationsList:FindFirstChild("Template")

	if not (Template and Template2) then
		warn("[AdminPanel] RandomServer precisa de Template em BrainrotList e MutationsList.")

		return
	end

	local v1 = nil

	if Select then
		local Frame = Select:FindFirstChild("Frame", true)

		if Frame then
			v1 = Frame:FindFirstChild("Box")
		end

		if not (v1 and v1:IsA("TextBox")) then
			v1 = findFirstTextBox(Select)
		end
	end

	if v1 then
		v1.ClearTextOnFocus = false

		if v1.Text == "" then
			v1.PlaceholderText = "Servidores"
		end
	end

	local v2 = nil
	local Search = RandomServer:FindFirstChild("Search", true)

	if Search then
		for i, v in ipairs(Search:GetDescendants()) do
			if v:IsA("TextBox") and v ~= v1 then
				v2 = v

				break
			end
		end
	end

	if v2 then
		v2.ClearTextOnFocus = false
	end

	local v3 = nil
	local v4 = "Normal"
	local t = {}
	local t2 = {}
	local v5 = 0

	local function clearGeneratedGui(p1, p2) --[[ clearGeneratedGui | Line: 1419 ]]
		for i, v in ipairs(p1:GetChildren()) do
			if v:IsA("GuiObject") and (v ~= p2 and v.Name ~= "Template") then
				v:Destroy()
			end
		end
	end

	local function updateCanvasSize(p1) --[[ updateCanvasSize | Line: 1427 ]]
		local v1 = p1:FindFirstChildOfClass("UIGridLayout") or p1:FindFirstChildOfClass("UIListLayout")

		if not v1 then
			return
		end

		p1.CanvasSize = UDim2.new(0, 0, 0, v1.AbsoluteContentSize.Y + 12)
	end

	local function rsHideAllBrainrotEquipped() --[[ rsHideAllBrainrotEquipped | Line: 1434 | Upvalues: BrainrotList (copy) ]]
		for i, v in ipairs(BrainrotList:GetChildren()) do
			if v:IsA("GuiObject") and v.Name ~= "Template" then
				local Equipped = v:FindFirstChild("Equipped", true)

				if Equipped and Equipped:IsA("GuiObject") then
					Equipped.Visible = false
				end
			end
		end
	end

	local function rsGetMutationIcon(p1) --[[ rsGetMutationIcon | Line: 1445 ]]
		local Frame = p1:FindFirstChild("Frame")

		if Frame then
			local Button = Frame:FindFirstChild("Button")
			local v1 = if Button then Button:FindFirstChild("Icon") else Button

			if v1 and v1:IsA("GuiObject") then
				return v1
			end

			local Icon = Frame:FindFirstChild("Icon")

			if Icon and Icon:IsA("GuiObject") then
				return Icon
			end
		end

		local Icon = p1:FindFirstChild("Icon", true)

		if Icon and Icon:IsA("GuiObject") then
			return Icon
		end

		return nil
	end

	local function rsSetMutationSelection(p1) --[[ rsSetMutationSelection | Line: 1468 | Upvalues: v4 (ref), TypeList (copy), rsGetMutationIcon (copy) ]]
		v4 = p1 or "Normal"

		for i, v in ipairs(TypeList:GetChildren()) do
			if v:IsA("GuiObject") then
				local v1 = rsGetMutationIcon(v)

				if v1 then
					v1.Visible = v.Name == v4
				end
			end
		end
	end

	local function rsResetTraits() --[[ rsResetTraits | Line: 1481 | Upvalues: t (ref), rsSetMutationSelection (copy), MutationsList (copy) ]]
		t = {}
		rsSetMutationSelection("Normal")

		for i, v in ipairs(MutationsList:GetChildren()) do
			if v:IsA("GuiObject") and v.Name ~= "Template" then
				local Icon = v:FindFirstChild("Icon", true)

				if Icon and Icon:IsA("GuiObject") then
					Icon.Visible = false
				end
			end
		end
	end

	local function getRsSelectedTraitList() --[[ getRsSelectedTraitList | Line: 1495 | Upvalues: t (ref) ]]
		local t2 = {}

		for k, v in pairs(t) do
			if v then
				table.insert(t2, k)
			end
		end

		table.sort(t2)

		return t2
	end

	local function getRsServerCount() --[[ getRsServerCount | Line: 1508 | Upvalues: v1 (ref), StarterGui (ref) ]]
		if not v1 then
			local v12 = "Digite a quantidade de servidores."
			local v2 = 3

			pcall(function() --[[ Line: 197 | Upvalues: StarterGui (ref), v12 (copy), v2 (copy) ]]
				local t2 = {
					Title = "Admin"
				}

				t2.Text = tostring(v12 or "")
				t2.Duration = v2 or 4
				StarterGui:SetCore("SendNotification", t2)
			end)

			return nil
		end

		local v5 = tonumber((tostring(v1.Text or ""):gsub("[^%d]", "")))

		if v5 and not (v5 < 1) then
			local v8 = math.clamp(math.floor((math.abs(v5))), 1, 100)

			v1.Text = tostring(v8)

			return v8
		end

		local v9 = "Digite a quantidade de servidores."
		local v10 = 3

		pcall(function() --[[ Line: 197 | Upvalues: StarterGui (ref), v9 (copy), v10 (copy) ]]
			local t2 = {
				Title = "Admin"
			}

			t2.Text = tostring(v9 or "")
			t2.Duration = v10 or 4
			StarterGui:SetCore("SendNotification", t2)
		end)

		return nil
	end

	local v6 = false

	local function queueVisibleRsViewports() --[[ queueVisibleRsViewports | Line: 1529 | Upvalues: t2 (copy), queueBrainrotViewport (ref), BrainrotList (copy) ]]
		for i, v in ipairs(t2) do
			local card = v.card

			if card and (card.Parent and card.Visible == true) then
				queueBrainrotViewport(card, v.id, BrainrotList)
			end
		end
	end

	local function scheduleRsViewportQueue() --[[ scheduleRsViewportQueue | Line: 1538 | Upvalues: v6 (ref), queueVisibleRsViewports (copy) ]]
		if not v6 then
			v6 = true
			task.defer(function() --[[ Line: 1544 | Upvalues: v6 (ref), queueVisibleRsViewports (ref) ]]
				v6 = false
				queueVisibleRsViewports()
			end)
		end
	end

	local function cloneRandomServerViewport(p1, p2) --[[ cloneRandomServerViewport | Line: 1550 | Upvalues: clearBrainrotViewport (ref), queueBrainrotViewport (ref), BrainrotList (copy) ]]
		clearBrainrotViewport(p1)
		queueBrainrotViewport(p1, p2, BrainrotList)
	end

	local function applyRsSearch() --[[ applyRsSearch | Line: 1555 | Upvalues: v2 (ref), cleanSearchText (ref), t2 (copy), BrainrotList (copy), v6 (ref), queueVisibleRsViewports (copy) ]]
		if not v2 then
			return
		end

		local list = {}

		for v1 in cleanSearchText(v2.Text):gmatch("%S+") do
			table.insert(list, v1)
		end

		for i, v in ipairs(t2) do
			local card = v.card

			if card and card.Parent then
				local v3 = tostring(v.id)
				local v4 = tostring(v.name)
				local v5 = cleanSearchText(v3 .. " " .. v4 .. " " .. tostring(v.rarity))
				local v62 = true

				for i2, v7 in ipairs(list) do
					if not v5:find(v7, 1, true) then
						v62 = false

						break
					end
				end

				card.Visible = v62
			end
		end

		local v7 = BrainrotList
		local v8 = v7:FindFirstChildOfClass("UIGridLayout") or v7:FindFirstChildOfClass("UIListLayout")

		if v8 then
			v7.CanvasSize = UDim2.new(0, 0, 0, v8.AbsoluteContentSize.Y + 12)
		end

		if not v6 then
			v6 = true
			task.defer(function() --[[ Line: 1544 | Upvalues: v6 (ref), queueVisibleRsViewports (ref) ]]
				v6 = false
				queueVisibleRsViewports()
			end)
		end
	end

	Template.Visible = false
	Template2.Visible = false
	clearGeneratedGui(BrainrotList, Template)
	clearGeneratedGui(MutationsList, Template2)

	for i, v in ipairs(list) do
		local v7 = Template:Clone()

		v7.Name = v.id
		v7.Visible = true
		v7.Parent = BrainrotList

		local t3 = {
			card = v7
		}

		t3.id = tostring(v.id or "")
		t3.name = tostring(v.data and v.data.Name or (v.id or ""))
		t3.rarity = tostring(v.data and v.data.Rarity or "")
		table.insert(t2, t3)

		local BrainrotName = v7:FindFirstChild("BrainrotName", true)

		if BrainrotName and BrainrotName:IsA("TextLabel") then
			BrainrotName.Text = v.data.Name or v.id
		end

		local BrainrotRarity = v7:FindFirstChild("BrainrotRarity", true)

		if BrainrotRarity and BrainrotRarity:IsA("TextLabel") then
			BrainrotRarity.Text = v.data.Rarity or "Common"
			BrainrotRarity.TextColor3 = RarityColor.GetRarityColor(v.data.Rarity)
			RarityColor.ApplyStroke(BrainrotRarity, v.data.Rarity)
		end

		local Equipped = v7:FindFirstChild("Equipped", true)

		if Equipped and Equipped:IsA("GuiObject") then
			Equipped.Visible = false
		end

		clearBrainrotViewport(v7)
		queueBrainrotViewport(v7, v.id, BrainrotList)

		local v12 = findClickable(v7:FindFirstChild("Frame", true) or v7) or findClickable(v7)

		if v12 then
			v12.MouseButton1Click:Connect(function() --[[ Line: 1631 | Upvalues: rsHideAllBrainrotEquipped (copy), Equipped (copy), v3 (ref), v (copy) ]]
				rsHideAllBrainrotEquipped()

				if Equipped and Equipped:IsA("GuiObject") then
					Equipped.Visible = true
				end

				v3 = v.id
			end)
		end
	end

	for i, v in ipairs(TypeList:GetChildren()) do
		if v:IsA("GuiObject") then
			local v13 = findClickable(v:FindFirstChild("Frame") or v)

			if v13 then
				v13.MouseButton1Click:Connect(function() --[[ Line: 1648 | Upvalues: v4 (ref), v (copy), rsSetMutationSelection (copy) ]]
					if v4 == v.Name and v.Name ~= "Normal" then
						rsSetMutationSelection("Normal")
					else
						rsSetMutationSelection(v.Name)
					end
				end)
			end
		end
	end

	rsSetMutationSelection("Normal")

	local list2 = {}

	for k, v in pairs(EventConfig.Events) do
		if k ~= "Lava" and k ~= "Galaxy" then
			table.insert(list2, {
				name = k,
				config = v
			})
		end
	end

	table.sort(list2, function(p1, p2) --[[ Line: 1671 | Upvalues: EventConfig (ref) ]]
		local name = p1.name
		local v1 = EventConfig.Events[name]
		local v3 = tostring(if v1 and v1.Name then v1.Name else name)
		local name2 = p2.name
		local v4 = EventConfig.Events[name2]

		return v3 < tostring(if v4 and v4.Name then v4.Name else name2)
	end)

	for i, v in ipairs(list2) do
		local name = v.name
		local v14 = Template2:Clone()

		v14.Name = name
		v14.Visible = true
		v14.Parent = MutationsList

		local Frame = v14:FindFirstChild("Frame")

		if Frame then
			local Title = Frame:FindFirstChild("Title")

			if Title and Title:IsA("TextLabel") then
				local v15 = EventConfig.Events[name]

				Title.Text = if v15 and v15.Name then v15.Name else name
			end

			local Button = Frame:FindFirstChild("Button")
			local v17 = if Button then Button:FindFirstChild("Icon") else Button

			if v17 and v17:IsA("GuiObject") then
				v17.Visible = false
			end
		end

		local v18 = findClickable(Frame or v14)

		if v18 then
			v18.MouseButton1Click:Connect(function() --[[ Line: 1698 | Upvalues: t (ref), name (copy), v14 (copy) ]]
				t[name] = not t[name]

				local Icon = v14:FindFirstChild("Icon", true)

				if not (Icon and Icon:IsA("GuiObject")) then
					return
				end

				Icon.Visible = t[name] == true
			end)
		end
	end

	if v2 then
		v2:GetPropertyChangedSignal("Text"):Connect(applyRsSearch)
		applyRsSearch()
	elseif not v6 then
		v6 = true
		task.defer(function() --[[ Line: 1544 | Upvalues: v6 (ref), queueVisibleRsViewports (copy) ]]
			v6 = false
			queueVisibleRsViewports()
		end)
	end

	BrainrotList:GetPropertyChangedSignal("CanvasPosition"):Connect(scheduleRsViewportQueue)
	BrainrotList:GetPropertyChangedSignal("AbsoluteSize"):Connect(scheduleRsViewportQueue)
	RandomServer:GetPropertyChangedSignal("Visible"):Connect(scheduleRsViewportQueue)
	task.defer(scheduleRsViewportQueue)
	task.delay(0.35, scheduleRsViewportQueue)
	task.delay(1.2, scheduleRsViewportQueue)

	local v19 = BrainrotList:FindFirstChildOfClass("UIGridLayout") or BrainrotList:FindFirstChildOfClass("UIListLayout")

	if v19 then
		BrainrotList.CanvasSize = UDim2.new(0, 0, 0, v19.AbsoluteContentSize.Y + 12)
	end

	local v20 = MutationsList:FindFirstChildOfClass("UIGridLayout") or MutationsList:FindFirstChildOfClass("UIListLayout")

	if not v20 then
		Start.MouseButton1Click:Connect(function() --[[ Line: 1726 | Upvalues: v3 (ref), StarterGui (ref), getRsServerCount (copy), AdminRandomServerSpawnBrainrotV2 (ref), v5 (ref), v4 (ref), getRsSelectedTraitList (copy), rsResetTraits (copy) ]]
			if not v3 then
				local v1 = "Selecione um brainrot primeiro."
				local v2 = 3

				pcall(function() --[[ Line: 197 | Upvalues: StarterGui (ref), v1 (copy), v2 (copy) ]]
					local t2 = {
						Title = "Admin"
					}

					t2.Text = tostring(v1 or "")
					t2.Duration = v2 or 4
					StarterGui:SetCore("SendNotification", t2)
				end)

				return
			end

			local v32 = getRsServerCount()

			if not v32 then
				return
			end

			local v42 = AdminRandomServerSpawnBrainrotV2

			if not v42 then
				local v52 = "Remote novo de RandomServer nao encontrado no servidor."
				local v6 = 4

				pcall(function() --[[ Line: 197 | Upvalues: StarterGui (ref), v52 (copy), v6 (copy) ]]
					local t2 = {
						Title = "Admin"
					}

					t2.Text = tostring(v52 or "")
					t2.Duration = v6 or 4
					StarterGui:SetCore("SendNotification", t2)
				end)

				return
			end

			local v7 = tick()

			if not (v7 - v5 < 1) then
				v5 = v7
				v42:FireServer(v3, v4, getRsSelectedTraitList(), v32)

				local v8 = "Spawn enviado para " .. tostring(v32) .. " servidor(es)."
				local v9 = 3

				pcall(function() --[[ Line: 197 | Upvalues: StarterGui (ref), v8 (copy), v9 (copy) ]]
					local t2 = {
						Title = "Admin"
					}

					t2.Text = tostring(v8 or "")
					t2.Duration = v9 or 4
					StarterGui:SetCore("SendNotification", t2)
				end)
				rsResetTraits()
			end
		end)

		return
	end

	MutationsList.CanvasSize = UDim2.new(0, 0, 0, v20.AbsoluteContentSize.Y + 12)
	Start.MouseButton1Click:Connect(function() --[[ Line: 1726 | Upvalues: v3 (ref), StarterGui (ref), getRsServerCount (copy), AdminRandomServerSpawnBrainrotV2 (ref), v5 (ref), v4 (ref), getRsSelectedTraitList (copy), rsResetTraits (copy) ]]
		if not v3 then
			local v1 = "Selecione um brainrot primeiro."
			local v2 = 3

			pcall(function() --[[ Line: 197 | Upvalues: StarterGui (ref), v1 (copy), v2 (copy) ]]
				local t2 = {
					Title = "Admin"
				}

				t2.Text = tostring(v1 or "")
				t2.Duration = v2 or 4
				StarterGui:SetCore("SendNotification", t2)
			end)

			return
		end

		local v32 = getRsServerCount()

		if not v32 then
			return
		end

		local v42 = AdminRandomServerSpawnBrainrotV2

		if not v42 then
			local v52 = "Remote novo de RandomServer nao encontrado no servidor."
			local v6 = 4

			pcall(function() --[[ Line: 197 | Upvalues: StarterGui (ref), v52 (copy), v6 (copy) ]]
				local t2 = {
					Title = "Admin"
				}

				t2.Text = tostring(v52 or "")
				t2.Duration = v6 or 4
				StarterGui:SetCore("SendNotification", t2)
			end)

			return
		end

		local v7 = tick()

		if not (v7 - v5 < 1) then
			v5 = v7
			v42:FireServer(v3, v4, getRsSelectedTraitList(), v32)

			local v8 = "Spawn enviado para " .. tostring(v32) .. " servidor(es)."
			local v9 = 3

			pcall(function() --[[ Line: 197 | Upvalues: StarterGui (ref), v8 (copy), v9 (copy) ]]
				local t2 = {
					Title = "Admin"
				}

				t2.Text = tostring(v8 or "")
				t2.Duration = v9 or 4
				StarterGui:SetCore("SendNotification", t2)
			end)
			rsResetTraits()
		end
	end)
end)()

local v26 = BrainrotList:FindFirstChildOfClass("UIGridLayout") or BrainrotList:FindFirstChildOfClass("UIListLayout")

if v26 then
	BrainrotList.CanvasSize = UDim2.new(0, 0, 0, v26.AbsoluteContentSize.Y + 10)
end

local t8 = {}

for k, v in pairs(EventConfig.Events) do
	if v.Admin then
		local v27 = Template2:Clone()

		v27.Name = k
		v27.Visible = true
		v27.Parent = List

		local Frame2 = v27:FindFirstChild("Frame")

		if Frame2 then
			local Title = Frame2:FindFirstChild("Title")

			if Title then
				Title.Text = v.Name or k
			end

			local Button = Frame2:FindFirstChild("Button")
			local v28 = Button and Button:FindFirstChild("Icon")

			if v28 then
				v28.Visible = false
			end

			t8[k] = v27
			Frame2.MouseButton1Click:Connect(function() --[[ Line: 1783 | Upvalues: t2 (ref), k (copy), v28 (copy) ]]
				if t2[k] then
					t2[k] = nil

					if v28 then
						v28.Visible = false
					end
				else
					t2[k] = true

					if not v28 then
						return
					end

					v28.Visible = true
				end
			end)

			if Button then
				Button.MouseButton1Click:Connect(function() --[[ Line: 1794 | Upvalues: t2 (ref), k (copy), v28 (copy) ]]
					t2[k] = nil

					if not v28 then
						return
					end

					v28.Visible = false
				end)
			end
		end
	end
end

local UIListLayout2 = List:FindFirstChildOfClass("UIListLayout")

if UIListLayout2 then
	List.CanvasSize = UDim2.new(0, 0, 0, UIListLayout2.AbsoluteContentSize.Y + 10)
end

local v29 = 0

Start2.MouseButton1Click:Connect(function() --[[ Line: 1809 | Upvalues: v29 (ref), On (copy), t2 (ref), t3 (copy), EndEventAdmin (copy), StartEventAdmin (copy), v10 (ref), t4 (copy), tbl (copy), List3 (copy), t8 (copy) ]]
	local v1 = tick()

	if v1 - v29 < 3 then
		return
	end

	v29 = v1

	local Visible = On.Visible
	local v2 = false

	for k, v in pairs(t2) do
		v2 = true

		if t3 and t3[k] == true then
			EndEventAdmin:FireServer(k, Visible)
			t3[k] = nil

			continue
		end

		StartEventAdmin:FireServer(k, nil, Visible)
		t3[k] = true
	end

	if v10 then
		local v3 = t4[v10]

		if v3 then
			v2 = true

			if t3 and t3[v3] == true then
				EndEventAdmin:FireServer(v3, Visible)
				t3[v3] = nil
			else
				StartEventAdmin:FireServer(v3, nil, Visible)
				t3[v3] = true
			end
		end
	end

	if not v2 then
		return
	end

	t2 = {}

	for k, v in pairs(tbl) do
		local v4 = List3:FindFirstChild(k)

		if v4 then
			local Frame = v4:FindFirstChild("Frame")

			if Frame then
				local Button = Frame:FindFirstChild("Button")
				local v5 = if Button then Button:FindFirstChild("Icon") else Button

				if v5 then
					v5.Visible = false
				end

				tbl[k] = false

				if v10 == k then
					v10 = nil
				end
			end
		end
	end

	v10 = nil
	v10 = nil

	for k, v in pairs(t8) do
		local Frame = v:FindFirstChild("Frame")

		if Frame then
			local Button = Frame:FindFirstChild("Button")

			if Button then
				local Icon = Button:FindFirstChild("Icon")

				if Icon then
					Icon.Visible = false
				end
			end
		end
	end
end)

local EventRemotes = ReplicatedStorage:WaitForChild("EventRemotes")

EventRemotes:WaitForChild("EndEvent").OnClientEvent:Connect(function(p1) --[[ Line: 1857 | Upvalues: t3 (copy) ]]
	t3[p1] = nil
end)
EventRemotes:WaitForChild("StartEvent").OnClientEvent:Connect(function(p1) --[[ Line: 1860 | Upvalues: t3 (copy) ]]
	t3[p1] = true
end)

local TweenService = game:GetService("TweenService")

game:GetService("StarterGui")

local function addHoverAnimation(p1) --[[ addHoverAnimation | Line: 1868 | Upvalues: TweenService (copy) ]]
	if not p1:IsA("GuiButton") then
		return
	end

	local HoverUIScale = p1:FindFirstChild("HoverUIScale")

	if not HoverUIScale then
		HoverUIScale = Instance.new("UIScale")
		HoverUIScale.Name = "HoverUIScale"
		HoverUIScale.Parent = p1
	end

	local v1 = false

	p1.MouseEnter:Connect(function() --[[ Line: 1880 | Upvalues: v1 (ref), TweenService (ref), HoverUIScale (ref) ]]
		v1 = true
		TweenService:Create(HoverUIScale, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Scale = 1.05
		}):Play()
	end)
	p1.MouseLeave:Connect(function() --[[ Line: 1885 | Upvalues: v1 (ref), TweenService (ref), HoverUIScale (ref) ]]
		v1 = false
		TweenService:Create(HoverUIScale, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Scale = 1
		}):Play()
	end)
	p1.MouseButton1Down:Connect(function() --[[ Line: 1890 | Upvalues: TweenService (ref), HoverUIScale (ref) ]]
		TweenService:Create(HoverUIScale, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Scale = 0.95
		}):Play()
	end)
	p1.MouseButton1Up:Connect(function() --[[ Line: 1894 | Upvalues: v1 (ref), TweenService (ref), HoverUIScale (ref) ]]
		TweenService:Create(HoverUIScale, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Scale = if v1 then 1.05 else 1
		}):Play()
	end)
end

for i, v in ipairs(Admin:GetDescendants()) do
	if v:IsA("GuiButton") then
		addHoverAnimation(v)
	end
end

Admin.DescendantAdded:Connect(function(p1) --[[ Line: 1905 | Upvalues: addHoverAnimation (copy) ]]
	if not p1:IsA("GuiButton") then
		return
	end

	addHoverAnimation(p1)
end)

local function _() --[[ Unreferenced function | Upvalues: v1 (ref), v2 (ref) ]]
	return v1:LoadAnimation(v2)
end