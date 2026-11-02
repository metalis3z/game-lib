local t = {}
local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))
local LocalPlayer = game.Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local Frame = Lib.UI.Get("Pointer"):WaitForChild("Frame")
local Pointer = Frame:WaitForChild("Pointer")

RaycastParams.new().FilterType = Enum.RaycastFilterType.Blacklist

local v1 = nil

local function SetTarget(p1) --[[ SetTarget | Line: 15 | Upvalues: v1 (ref) ]]
	v1 = p1
end

local function ClearTarget() --[[ ClearTarget | Line: 19 | Upvalues: v1 (ref), Frame (copy) ]]
	v1 = nil
	Frame.Visible = false
end

local v2 = 0

local function Update() --[[ Update | Line: 25 | Upvalues: Lib (copy), v2 (ref), Pointer (copy), v1 (ref), LocalPlayer (copy), Frame (copy), CurrentCamera (copy) ]]
	if Lib.IsConsole then
		return
	end

	while true do
		local v12, v22

		while true do
			local v3

			while true do
				local v4

				while true do
					local v5

					while true do
						while true do
							task.wait(0.1)
							v2 = v2 + 0.1

							if v2 >= 0.2 then
								v2 = 0
								Pointer.Visible = not Pointer.Visible
							end

							if v1 and (v1:IsA("Model") and v1.PrimaryPart) then
								break
							end

							Frame.Visible = false
						end

						v5 = LocalPlayer.Character

						if v5 then
							break
						end

						Frame.Visible = false
					end

					v4 = v5:FindFirstChild("Head")

					if v4 then
						break
					end

					Frame.Visible = false
				end

				v12 = CurrentCamera.CFrame.LookVector
				v3 = v1.PrimaryPart.Position

				local Position = v4.Position
				local Unit = (v3 - Position).Unit

				if not ((v3 - Position).Magnitude > 20) then
					break
				end

				Frame.Visible = false
			end

			v22 = (v3 - CurrentCamera.CFrame.Position).Unit

			local v6 = v22:Dot(v12)

			if v6 < math.cos(math.rad(CurrentCamera.FieldOfView) / 2) then
				break
			end

			Frame.Visible = false
		end

		if v12:Cross(v22).Y > 0 then
			Pointer.Position = UDim2.new(0, 0, 0.5, 0)
		else
			Pointer.Position = UDim2.new(1, -0, 0.5, 0)
		end

		Frame.Visible = true
	end
end

task.spawn(Update)
t.SetTarget = SetTarget
t.ClearTarget = ClearTarget
Lib.Inject("SetPointerTarget", SetTarget)
Lib.Inject("ClearPointerTarget", ClearTarget)

return t