local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))
local v1 = RaycastParams.new()

v1.FilterType = Enum.RaycastFilterType.Whitelist

local Frame = Lib.UI.Get("DontLookUp"):WaitForChild("Frame")
local LocalPlayer = game.Players.LocalPlayer
local v2 = nil
local v3 = nil
local CurrentCamera = workspace.CurrentCamera
local v4 = os.time()
local v5 = Random.new()

local function onLookUp() --[[ onLookUp | Line: 16 | Upvalues: LocalPlayer (copy), v1 (copy), Lib (copy), v2 (ref), Frame (copy), v3 (ref) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if not HumanoidRootPart then
		return
	end

	v1.FilterDescendantsInstances = Lib.CS:GetTagged("DontLookUp")

	local v12 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, 100, 0), v1)

	if v12 and (v12.Instance and not v2) then
		Frame.Visible = true
		Frame.text.TextTransparency = 0
		Frame.text.Text = "Don\'t look up"
		Frame.text.UIStroke.Transparency = 0
		v2 = Lib.TS:Create(Frame.text, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true), {
			TextTransparency = 1
		})
		v2:Play()
		v3 = Lib.TS:Create(Frame.text.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true), {
			Transparency = 1
		})
		v3:Play()
	elseif not (v12 and v12.Instance) and v2 then
		v2:Cancel()
		v3:Cancel()
		Frame.Visible = false
		v2 = nil
	end

	return if v12 then v12.Instance else v12
end

local function monsterEffect(p1) --[[ monsterEffect | Line: 46 | Upvalues: Lib (copy) ]]
	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("SpecialMesh") then
			v.VertexColor = Vector3.new(5, 3, 3)
			Lib.TS:Create(v, TweenInfo.new(0.6000000000000001, Enum.EasingStyle.Linear), {
				VertexColor = Vector3.new(1, 1, 1)
			}):Play()
		end
	end
end

local function shakeCamera(p1) --[[ shakeCamera | Line: 55 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if not Humanoid then
		return
	end

	for i = 1, 5 do
		local v1 = (math.random() - 0.5) * 0.15 * 2

		Humanoid.CameraOffset = Vector3.new(v1, (math.random() - 0.5) * 0.15 * 2, 0)
		task.wait(p1 / 5)
	end

	Humanoid.CameraOffset = Vector3.new(0, 0, 0)
end

task.spawn(function() --[[ Line: 74 | Upvalues: LocalPlayer (copy), onLookUp (copy), CurrentCamera (copy), Lib (copy), v5 (copy), monsterEffect (copy), shakeCamera (copy), v4 (ref) ]]
	local count = 0

	while true do
		task.wait(0.1)

		if LocalPlayer.Character then
			local v1 = onLookUp()

			if v1 then
				local v2 = v1.Parent
				local Position = v1.Position
				local t = { LocalPlayer.Character, v2 }
				local _, v3 = CurrentCamera:WorldToScreenPoint(Position)

				if v3 then
					if #CurrentCamera:GetPartsObscuringTarget({ Position }, t) == 0 then
						if count == 0 then
							Lib.PlayerLostSanity(v5:NextInteger(2, 5), "Eye contact")
							monsterEffect(v2)
							task.spawn(shakeCamera, 0.1)
							v4 = os.time()
							count = 0
						end

						count = count + 1

						if count >= 6 then
							count = 0
						end

						continue
					end

					count = 0
				end

				continue
			end

			task.wait(0.5)
			count = 0
		else
			count = 0
		end
	end
end)

return {}