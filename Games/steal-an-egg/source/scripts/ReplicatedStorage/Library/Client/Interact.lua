-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = ReplicatedStorage.Assets
local Functions = require(ReplicatedStorage.Library.Functions)
local v1 = require(ReplicatedStorage.Library.Modules.Event)
local TabController = require(ReplicatedStorage.Library.Client.TabController)
local Player = require(ReplicatedStorage.Library.Player)
local Variables = require(ReplicatedStorage.Library.Variables)
local Audio = require(ReplicatedStorage.Library.Audio)
local SpatialTable = require(ReplicatedStorage.Library.Modules.SpatialTable)
local ScaleUDim2 = require(ReplicatedStorage.Library.Functions.ScaleUDim2)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local v2 = table.freeze({
	MobileButtonImage = "rbxassetid://5083554875",
	DesktopButtonImage = "rbxassetid://5083555193",
	XboxButtonImage = "rbxasset://textures/ui/Controls/XboxController/ButtonX@2x.png",
	PressDownSound = "rbxassetid://82144450256926",
	PressUpSound = "rbxassetid://99086493947576",
	StepTime = 0.15,
	PlaystationButtonImage = UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonX)
})
local v3 = SpatialTable.new(10)
local t = {}
local v4 = nil
local v5 = if UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonX) == "ButtonSquare" then "Playstation" else "Xbox"
local v6 = 0
local t2 = {
	GetInteractIcon = function() --[[ GetInteractIcon | Line: 39 | Upvalues: Variables (copy), Constants (copy), v2 (copy), v5 (copy) ]]
		if Variables.Console then
			if v5 == "Playstation" then
				return v2.PlaystationButtonImage
			end

			return v2.XboxButtonImage
		end

		if Constants.IS_MOBILE then
			return v2.MobileButtonImage
		end

		return v2.DesktopButtonImage
	end,
	Activate = function(p1) --[[ Activate | Line: 53 ]]
		p1.event:FireAsync()
	end
}

function t2.Show(p1) --[[ Show | Line: 57 | Upvalues: Assets (copy), ScaleUDim2 (copy), t2 (copy), Variables (copy), Functions (copy), Player (copy), Audio (copy), v2 (copy), UserInputService (copy), TabController (copy), t (copy) ]]
	if p1.billboard or p1.tweening then
		return
	end

	local v1 = Assets.Billboards.Interact:Clone()

	v1.Size = ScaleUDim2(v1.Size, p1.billboardScale)
	v1.Button.Back.Icon.Image = t2.GetInteractIcon()

	if Variables.Console then
		v1.Button.Back.Icon.ImageColor3 = Color3.new()
	end

	v1.Label.Text = p1.label
	v1.Label.Visible = p1.label ~= ""
	v1.Button.Back.CustomIcon.Visible = p1.customIcon ~= ""
	v1.Button.Back.CustomIcon.Image = p1.customIcon

	local Size = v1.Size

	v1.Size = UDim2.new()
	Functions.Tween(v1, {
		Size = Size
	}, { 0.2, "Back", "Out" }).Completed:Connect(function() --[[ Line: 72 | Upvalues: p1 (copy) ]]
		p1.tweening = false
	end)
	p1.tweening = true
	v1.Adornee = p1.host
	v1.Parent = Player.PlayerGui()
	p1.billboard = v1

	local v22 = false

	local function onButtonReleased() --[[ onButtonReleased | Line: 82 | Upvalues: v22 (ref), Audio (ref), v2 (ref), v1 (copy), Functions (ref), t2 (ref), p1 (copy) ]]
		if v22 then
			return
		end

		v22 = true
		Audio.Play(v2.PressUpSound, script, 1.75, 1)

		if not v1:FindFirstChild("Button") then
			t2.Activate(p1)
			v22 = false

			return
		end

		v1.Button.Back.BackgroundColor3 = Color3.new(255/255, 255/255, 255/255)
		v1.Button.Back.Fill.Visible = false
		Functions.Tween(v1.Button.Back, {
			Size = UDim2.new(1, 0, 1, 0)
		}, { 0.3, "Elastic", "Out" })
		t2.Activate(p1)
		v22 = false
	end

	local function onButtonPressed() --[[ onButtonPressed | Line: 98 | Upvalues: v22 (ref), Audio (ref), v2 (ref), Functions (ref), v1 (copy) ]]
		if not v22 then
			v22 = true
			Audio.Play(v2.PressDownSound, script, 1.75, 0.1)
			Functions.Tween(v1.Button.Back, {
				Size = UDim2.new(0.85, 0, 0.85, 0)
			}, { 0.3, "Elastic", "Out" })
			v1.Button.Back.Fill.Visible = false
			v1.Button.Back.BackgroundColor3 = Color3.new(0.75, 0.75, 0.75)
			v22 = false
		end
	end

	local function f3(p12) --[[ Line: 117 | Upvalues: TabController (ref), p1 (copy), Variables (ref), t (ref), onButtonPressed (copy) ]]
		if not (if TabController.Get() == nil then not Variables.Typing and (not Variables.MessageOpen and (if t[p1.uid] == nil then false elseif p1.customEnableCheck then p1.customEnableCheck() else true)) else false) then
			return
		end

		if p12.KeyCode ~= Enum.KeyCode.ButtonX and p12.KeyCode ~= Enum.KeyCode.E then
			return
		end

		onButtonPressed()
	end

	table.insert(p1.events, UserInputService.InputBegan:Connect(f3))

	local function f4(p12) --[[ Line: 151 | Upvalues: TabController (ref), p1 (copy), Variables (ref), t (ref), onButtonReleased (copy) ]]
		if not (if TabController.Get() == nil then not Variables.Typing and (not Variables.MessageOpen and (if t[p1.uid] == nil then false elseif p1.customEnableCheck then p1.customEnableCheck() else true)) else false) then
			return
		end

		if p12.KeyCode ~= Enum.KeyCode.ButtonX and p12.KeyCode ~= Enum.KeyCode.E then
			return
		end

		onButtonReleased()
	end

	table.insert(p1.events, UserInputService.InputEnded:Connect(f4))

	local function f5(p12) --[[ Line: 185 | Upvalues: TabController (ref), p1 (copy), Variables (ref), t (ref), onButtonPressed (copy) ]]
		if not (if TabController.Get() == nil then not Variables.Typing and (not Variables.MessageOpen and (if t[p1.uid] == nil then false elseif p1.customEnableCheck then p1.customEnableCheck() else true)) else false) then
			return
		end

		local UserInputType = p12.UserInputType

		if UserInputType ~= Enum.UserInputType.MouseButton1 and (UserInputType ~= Enum.UserInputType.Touch or p12.UserInputState ~= Enum.UserInputState.Begin) and p12.KeyCode ~= Enum.KeyCode.ButtonX then
			return
		end

		onButtonPressed()
	end

	table.insert(p1.event, v1.Button.InputBegan:Connect(f5))

	local function f6(p12) --[[ Line: 227 | Upvalues: TabController (ref), p1 (copy), Variables (ref), t (ref), onButtonReleased (copy) ]]
		if not (if TabController.Get() == nil then not Variables.Typing and (not Variables.MessageOpen and (if t[p1.uid] == nil then false elseif p1.customEnableCheck then p1.customEnableCheck() else true)) else false) then
			return
		end

		local UserInputType = p12.UserInputType

		if UserInputType ~= Enum.UserInputType.MouseButton1 and (UserInputType ~= Enum.UserInputType.Touch or p12.UserInputState ~= Enum.UserInputState.End) and p12.KeyCode ~= Enum.KeyCode.ButtonX then
			return
		end

		onButtonReleased()
	end

	table.insert(p1.event, v1.Button.InputEnded:Connect(f6))
	v1.Destroying:Connect(function() --[[ Line: 268 | Upvalues: p1 (copy) ]]
		for i, v in ipairs(p1.events) do
			v:Disconnect()
		end

		p1.events = {}
	end)
end
function t2.Hide(p1) --[[ Hide | Line: 280 | Upvalues: Functions (copy) ]]
	if p1.billboard then
		Functions.Tween(p1.billboard, {
			Size = UDim2.new()
		}, { 0.15, "Back", "In" }).Completed:Connect(function() --[[ Line: 283 | Upvalues: p1 (copy) ]]
			p1.tweening = false

			if not p1.billboard then
				return
			end

			p1.billboard:Destroy()
			p1.billboard = nil
		end)
		p1.tweening = true
	end
end
function t2.Add(p1, p2) --[[ Add | Line: 324 | Upvalues: Functions (copy), v1 (copy), v6 (ref), t (copy), v3 (copy), v4 (ref) ]]
	local v12 = if p2 then p2 else {}
	local v32 = false
	local v42 = nil

	if typeof(p1) == "Instance" then
		if p1:IsA("Model") then
			local PrimaryPart = p1.PrimaryPart

			assert(PrimaryPart, "interact: model has no primary part")
			v42 = PrimaryPart
		elseif p1:IsA("BasePart") then
			v42 = p1
		else
			error("interact: unknown host type")
		end
	else
		v42 = Functions.CreateParticleHost(p1)
		v32 = true
	end

	local v5 = v1.new()
	local v62 = v6

	v6 = v6 + 1

	local t2 = {
		tweening = false,
		deleted = false,
		resumeTimestamp = nil,
		billboard = nil,
		uid = v62,
		host = v42,
		position = v42.Position,
		dist = v12.dist or 30,
		event = v5,
		events = {},
		label = v12.label or "",
		customIcon = v12.icon or "",
		customEnableCheck = v12.customEnableCheck,
		customShowCheck = v12.customShowCheck,
		billboardScale = v12.billboardScale or 1
	}

	t[v62] = t2
	v3:Insert(t2.position, t2)

	local function onDestroy() --[[ onDestroy | Line: 372 | Upvalues: t2 (copy), v32 (ref), v42 (ref), t (ref), v62 (copy), v3 (ref), v4 (ref) ]]
		if t2.deleted then
			return
		end

		t2.deleted = true

		if v32 then
			v42:Destroy()
		end

		if t2.billboard then
			t2.billboard:Destroy()
		end

		t[v62] = nil
		v3:Remove(t2.position, t2)

		if v4 ~= t2 then
			return
		end

		v4 = nil
	end

	local function setResumeTimestamp(p1) --[[ setResumeTimestamp | Line: 392 | Upvalues: t2 (copy) ]]
		t2.resumeTimestamp = workspace:GetServerTimeNow() + p1
	end

	v42.Destroying:Connect(onDestroy)

	return v5, onDestroy, setResumeTimestamp
end
function t2.Step() --[[ Step | Line: 400 | Upvalues: Player (copy), v3 (copy), v4 (ref), t2 (copy) ]]
	local v1 = Player.Optional.Position()

	if not v1 then
		return
	end

	local v2 = v3:Query(v1)
	local v32 = workspace:GetServerTimeNow()

	if v4 then
		local v42 = if v4 == v2 and (v4.position - v1).Magnitude <= v4.dist then if v4.resumeTimestamp == nil then false elseif v32 < v4.resumeTimestamp then true else false else true

		if not v42 and v4.customShowCheck then
			v42 = not v4.customShowCheck()
		end

		if v42 then
			t2.Hide(v4)
			v4 = nil
		end
	end

	if v2 and not v2.billboard then
		local v5 = if (v2.position - v1).Magnitude < v2.dist then if v2.resumeTimestamp == nil then true elseif v2.resumeTimestamp < v32 then true else false else false

		if v5 and v2.customShowCheck then
			v5 = v2.customShowCheck()
		end

		if v5 then
			t2.Show(v2)
		end
	end

	v4 = v2
end
task.spawn(function() --[[ Line: 452 | Upvalues: v2 (copy), t2 (copy) ]]
	while task.wait(v2.StepTime) do
		t2.Step()
	end
end)

return t2