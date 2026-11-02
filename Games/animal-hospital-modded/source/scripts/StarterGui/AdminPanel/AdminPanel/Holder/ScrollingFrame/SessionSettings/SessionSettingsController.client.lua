-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local CurrentCamera = workspace.CurrentCamera
local Frame = script.Parent.Frame
local ResetData = Frame:WaitForChild("ResetData")
local Freecam = Frame:WaitForChild("Freecam")
local Hide = Frame:WaitForChild("Hide")
local v1 = nil

local function showNotif(p1, p2) --[[ showNotif | Line: 24 | Upvalues: v1 (ref) ]]
	if not v1 then
		local AdminPanel = script:FindFirstAncestor("AdminPanel")
		local v12 = if AdminPanel then AdminPanel:FindFirstChild("NotifModule") else AdminPanel

		if v12 then
			local ok, result = pcall(require, v12)

			if ok then
				v1 = result
			end
		end
	end

	if not v1 then
		return
	end

	v1(p1, p2 ~= false)
end

local v2 = ReplicatedStorage:FindFirstChild("RemoteEvents") and ReplicatedStorage.RemoteEvents:FindFirstChild("ResetDataCommand")
local v3 = false
local v4 = nil

ResetData.MouseButton1Click:Connect(function() --[[ Line: 41 | Upvalues: v2 (copy), showNotif (copy), v3 (ref), v4 (ref) ]]
	if not v2 then
		showNotif("Reset remote missing", false)

		return
	end

	if v3 then
		v3 = false

		if v4 then
			task.cancel(v4)
			v4 = nil
		end

		v2:FireServer({
			Confirm = "CONFIRM"
		})
		showNotif("Profile reset", true)
	else
		v3 = true
		showNotif("Click again to confirm reset (5s)", false)

		if v4 then
			task.cancel(v4)
		end

		v4 = task.delay(5, function() --[[ Line: 50 | Upvalues: v3 (ref) ]]
			v3 = false
		end)
	end
end)

if v2 then
	v2.OnClientEvent:Connect(function(p1) --[[ Line: 62 | Upvalues: showNotif (copy) ]]
		if typeof(p1) ~= "table" or p1.success ~= false then
			return
		end

		showNotif(p1.message or "Reset failed", false)
	end)
end

local v5 = false
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil

local function getControlsModule() --[[ getControlsModule | Line: 84 | Upvalues: v10 (ref), LocalPlayer (copy) ]]
	if v10 then
		return v10
	end

	local ok, result = pcall(function() --[[ Line: 86 | Upvalues: LocalPlayer (ref) ]]
		local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts", 5)

		return if PlayerScripts then require(PlayerScripts:WaitForChild("PlayerModule", 5)) else PlayerScripts
	end)

	if not (ok and result) then
		return v10
	end

	v10 = result:GetControls()

	return v10
end

local function freezeCharacter() --[[ freezeCharacter | Line: 96 | Upvalues: LocalPlayer (copy), v9 (ref), v10 (ref) ]]
	local Character = LocalPlayer.Character
	local v1 = Character and Character:FindFirstChild("HumanoidRootPart")

	if v1 then
		local Anchored = v1.Anchored

		v1.Anchored = true
		v9 = function() --[[ Line: 102 | Upvalues: v1 (copy), Anchored (copy) ]]
			if not (v1 and v1.Parent) then
				return
			end

			v1.Anchored = Anchored
		end
	end

	if not v10 then
		local ok, result = pcall(function() --[[ Line: 86 | Upvalues: LocalPlayer (ref) ]]
			local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts", 5)

			return if PlayerScripts then require(PlayerScripts:WaitForChild("PlayerModule", 5)) else PlayerScripts
		end)

		if ok and result then
			v10 = result:GetControls()
		end
	end

	local v2 = v10

	if not v2 then
		return
	end

	v2:Disable()
end

local function unfreezeCharacter() --[[ unfreezeCharacter | Line: 110 | Upvalues: v9 (ref), v10 (ref), LocalPlayer (copy) ]]
	if v9 then
		v9()
		v9 = nil
	end

	if not v10 then
		local ok, result = pcall(function() --[[ Line: 86 | Upvalues: LocalPlayer (ref) ]]
			local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts", 5)

			return if PlayerScripts then require(PlayerScripts:WaitForChild("PlayerModule", 5)) else PlayerScripts
		end)

		if ok and result then
			v10 = result:GetControls()
		end
	end

	local v1 = v10

	if not v1 then
		return
	end

	v1:Enable()
end

local function setFreecam(p1) --[[ setFreecam | Line: 116 | Upvalues: v5 (ref), v7 (ref), CurrentCamera (copy), v8 (ref), freezeCharacter (copy), v6 (ref), RunService (copy), UserInputService (copy), showNotif (copy), v9 (ref), v10 (ref), LocalPlayer (copy) ]]
	if p1 == v5 then
		return
	end

	v5 = p1

	if p1 then
		v7 = CurrentCamera.CameraSubject
		v8 = CurrentCamera.CameraType
		CurrentCamera.CameraType = Enum.CameraType.Scriptable
		freezeCharacter()
		v6 = RunService.RenderStepped:Connect(function(p1) --[[ Line: 124 | Upvalues: UserInputService (ref), CurrentCamera (ref) ]]
			local sum = Vector3.new(0, 0, 0)

			if UserInputService:IsKeyDown(Enum.KeyCode.W) then
				sum = sum + CurrentCamera.CFrame.LookVector
			end

			if UserInputService:IsKeyDown(Enum.KeyCode.S) then
				sum = sum - CurrentCamera.CFrame.LookVector
			end

			if UserInputService:IsKeyDown(Enum.KeyCode.D) then
				sum = sum + CurrentCamera.CFrame.RightVector
			end

			if UserInputService:IsKeyDown(Enum.KeyCode.A) then
				sum = sum - CurrentCamera.CFrame.RightVector
			end

			if UserInputService:IsKeyDown(Enum.KeyCode.E) then
				sum = sum + Vector3.new(0, 1, 0)
			end

			if UserInputService:IsKeyDown(Enum.KeyCode.Q) then
				sum = sum - Vector3.new(0, 1, 0)
			end

			if not (sum.Magnitude > 0) then
				return
			end

			CurrentCamera.CFrame = CurrentCamera.CFrame + sum.Unit * 60 * (if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then 3 else 1) * p1
		end)
		showNotif("Freecam ON (WASD/QE, Shift = sprint)", true)

		return
	end

	if v6 then
		v6:Disconnect()
		v6 = nil
	end

	local v1 = CurrentCamera

	v1.CameraType = v8 or Enum.CameraType.Custom
	CurrentCamera.CameraSubject = v7

	if v9 then
		v9()
		v9 = nil
	end

	if not v10 then
		local ok, result = pcall(function() --[[ Line: 86 | Upvalues: LocalPlayer (ref) ]]
			local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts", 5)

			return if PlayerScripts then require(PlayerScripts:WaitForChild("PlayerModule", 5)) else PlayerScripts
		end)

		if ok and result then
			v10 = result:GetControls()
		end
	end

	local v3 = v10

	if v3 then
		v3:Enable()
	end

	showNotif("Freecam OFF", true)
end

Freecam.MouseButton1Click:Connect(function() --[[ Line: 147 | Upvalues: setFreecam (copy), v5 (ref) ]]
	setFreecam(not v5)
end)
LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 152 | Upvalues: v9 (ref), v10 (ref), v5 (ref), v6 (ref), CurrentCamera (copy), v8 (ref), v7 (ref), LocalPlayer (copy), showNotif (copy) ]]
	v9 = nil
	v10 = nil

	if v5 == false then
		return
	end

	v5 = false

	if v6 then
		v6:Disconnect()
		v6 = nil
	end

	CurrentCamera.CameraType = v8 or Enum.CameraType.Custom
	CurrentCamera.CameraSubject = v7

	if v9 then
		v9()
		v9 = nil
	end

	if not v10 then
		local ok, result = pcall(function() --[[ Line: 86 | Upvalues: LocalPlayer (ref) ]]
			local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts", 5)

			return if PlayerScripts then require(PlayerScripts:WaitForChild("PlayerModule", 5)) else PlayerScripts
		end)

		if ok and result then
			v10 = result:GetControls()
		end
	end

	local v3 = v10

	if not v3 then
		showNotif("Freecam OFF", true)

		return
	end

	v3:Enable()
	showNotif("Freecam OFF", true)
end)

local HUD = PlayerGui:WaitForChild("HUD", 10)
local v11 = if HUD then HUD:FindFirstChild("LeftPanel") else HUD
local v12 = v11 and v11:FindFirstChild("AdminPanel")

Hide.MouseButton1Click:Connect(function() --[[ Line: 167 | Upvalues: v12 (copy), showNotif (copy) ]]
	if v12 then
		v12.Visible = false
	end

	showNotif("HUD button hidden. Type /admin to bring back", true)
end)
LocalPlayer.Chatted:Connect(function(p1) --[[ Line: 172 | Upvalues: v12 (copy) ]]
	if not (p1:lower():match("^/admin%s*$") and v12) then
		return
	end

	v12.Visible = true
end)