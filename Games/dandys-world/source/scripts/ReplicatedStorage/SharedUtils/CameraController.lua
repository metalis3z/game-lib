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
-- 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

-- https://lua.expert/
if game:GetService("RunService"):IsClient() then
	local TweenService = game:GetService("TweenService")
	local Players = game:GetService("Players")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Signal = require(ReplicatedStorage.SharedUtils.Signal)
	local t = {}
	local v1 = nil
	local v2 = nil
	local v3 = nil
	local v4 = "Idle"

	local function getCamera() --[[ getCamera | Line: 20 ]]
		return workspace.CurrentCamera
	end

	local function cleanupActiveTween() --[[ cleanupActiveTween | Line: 24 | Upvalues: v3 (ref), v1 (ref), v2 (ref) ]]
		if v3 then
			v3:Disconnect()
			v3 = nil
		end

		if v1 then
			v1:Cancel()
			v1:Destroy()
			v1 = nil
		end

		if not v2 then
			return
		end

		v2:Fire(false)
		v2:Destroy()
		v2 = nil
	end

	function t.TweenTo(p1, p2, p3, p4, p5) --[[ TweenTo | Line: 43 | Upvalues: v3 (ref), v1 (ref), v2 (ref), v4 (ref), Signal (copy), TweenService (copy) ]]
		if v3 then
			v3:Disconnect()
			v3 = nil
		end

		if v1 then
			v1:Cancel()
			v1:Destroy()
			v1 = nil
		end

		if v2 then
			v2:Fire(false)
			v2:Destroy()
			v2 = nil
		end

		local CurrentCamera = workspace.CurrentCamera

		if not CurrentCamera then
			return nil
		end

		CurrentCamera.CameraType = Enum.CameraType.Scriptable
		v4 = "Tweening"

		local v12 = if p4 then p4 else Enum.EasingStyle.Quad
		local v22 = if p5 then p5 else Enum.EasingDirection.InOut
		local v32 = Signal.new()

		v2 = v32

		local v42 = TweenService:Create(CurrentCamera, TweenInfo.new(p3, v12, v22), {
			CFrame = p2
		})

		v1 = v42
		v3 = v42.Completed:Connect(function() --[[ Line: 64 | Upvalues: v1 (ref), v42 (copy), v3 (ref), v4 (ref), v2 (ref) ]]
			if v1 ~= v42 then
				return
			end

			v3:Disconnect()
			v3 = nil
			v1:Destroy()
			v1 = nil
			v4 = "Scriptable"

			local v12 = v2

			v2 = nil

			if not v12 then
				return
			end

			v12:Fire(true)
			v12:Destroy()
		end)
		v42:Play()

		return v32
	end
	function t.SetCFrame(p1, p2) --[[ SetCFrame | Line: 89 | Upvalues: v3 (ref), v1 (ref), v2 (ref), v4 (ref) ]]
		if v3 then
			v3:Disconnect()
			v3 = nil
		end

		if v1 then
			v1:Cancel()
			v1:Destroy()
			v1 = nil
		end

		if v2 then
			v2:Fire(false)
			v2:Destroy()
			v2 = nil
		end

		local CurrentCamera = workspace.CurrentCamera

		if CurrentCamera then
			CurrentCamera.CameraType = Enum.CameraType.Scriptable
			CurrentCamera.CFrame = p2
			v4 = "Scriptable"
		end
	end
	function t.FitPartInView(p1, p2, p3) --[[ FitPartInView | Line: 102 ]]
		local CurrentCamera = workspace.CurrentCamera

		if not CurrentCamera then
			return
		end

		CurrentCamera.FieldOfView = 1

		local v1 = p2.Size * 0.5
		local t = {
			p2.CFrame * CFrame.new(v1.X, v1.Y, v1.Z),
			p2.CFrame * CFrame.new(-v1.X, v1.Y, v1.Z),
			p2.CFrame * CFrame.new(v1.X, -v1.Y, v1.Z),
			p2.CFrame * CFrame.new(-v1.X, -v1.Y, v1.Z),
			p2.CFrame * CFrame.new(v1.X, v1.Y, -v1.Z),
			p2.CFrame * CFrame.new(-v1.X, v1.Y, -v1.Z),
			p2.CFrame * CFrame.new(v1.X, -v1.Y, -v1.Z),
			p2.CFrame * CFrame.new(-v1.X, -v1.Y, -v1.Z)
		}

		repeat
			CurrentCamera.FieldOfView = CurrentCamera.FieldOfView + 1

			local v3 = true

			for v4, v5 in t do
				local _, v6 = CurrentCamera:WorldToViewportPoint(v5.Position)

				if not v6 then
					v3 = false

					break
				end
			end
		until v3 or CurrentCamera.FieldOfView >= 120

		CurrentCamera.FieldOfView = CurrentCamera.FieldOfView + (p3 or 5)
	end
	function t.Interrupt(p1) --[[ Interrupt | Line: 139 | Upvalues: v4 (ref), v3 (ref), v1 (ref), v2 (ref) ]]
		if v4 ~= "Tweening" then
			return
		end

		if v3 then
			v3:Disconnect()
			v3 = nil
		end

		if v1 then
			v1:Cancel()
			v1:Destroy()
			v1 = nil
		end

		if not v2 then
			v4 = "Scriptable"

			return
		end

		v2:Fire(false)
		v2:Destroy()
		v2 = nil
		v4 = "Scriptable"
	end
	function t.Reset(p1) --[[ Reset | Line: 148 | Upvalues: v3 (ref), v1 (ref), v2 (ref), Players (copy), v4 (ref) ]]
		if v3 then
			v3:Disconnect()
			v3 = nil
		end

		if v1 then
			v1:Cancel()
			v1:Destroy()
			v1 = nil
		end

		if v2 then
			v2:Fire(false)
			v2:Destroy()
			v2 = nil
		end

		local CurrentCamera = workspace.CurrentCamera

		if not CurrentCamera then
			return
		end

		local LocalPlayer = Players.LocalPlayer
		local v12 = if LocalPlayer then LocalPlayer.Character else LocalPlayer

		CurrentCamera.CameraSubject = if v12 then v12:FindFirstChild("Humanoid") else v12
		CurrentCamera.CameraType = Enum.CameraType.Custom
		v4 = "Idle"
	end
	function t.GetState(p1) --[[ GetState | Line: 165 | Upvalues: v4 (ref) ]]
		return v4
	end
	function t.IsActive(p1) --[[ IsActive | Line: 169 | Upvalues: v4 (ref) ]]
		return v4 ~= "Idle"
	end

	return t
end

return {}