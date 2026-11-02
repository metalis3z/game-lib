-- Reference copy for study. Game: steal-a-brainrot-sab-files
-- Original: ReplicatedStorage/Controllers/CameraController.lua  (ModuleScript, 59 lines)
-- What it does: Tiny helper: tween the camera FOV or a camera BlurEffect to a value over a time (0 = instant).
-- (an advertising comment line from the original was removed)

local TweenService = game:GetService("TweenService")
local t1 = {
	GetDefaultFov = function(_)
		return 70
	end,
	Get = function(_)
		local CurrentCamera = workspace.CurrentCamera

		while not CurrentCamera do
			task.wait()
			CurrentCamera = workspace.CurrentCamera
		end

		return CurrentCamera
	end
}

function t1.Fov(_: {[any]: any}, n1: number, n2: number?, b1: boolean?)
	if b1 == true then
		n1 = 70
	end

	if n2 == 0 then
		t1:Get().FieldOfView = n1

		return
	end

	local tweenInfo = TweenInfo.new(n2, Enum.EasingStyle.Linear)

	TweenService:Create(t1:Get(), tweenInfo, {
		FieldOfView = n1
	}):Play()
end
function t1.Blur(_: {[any]: any}, n3: number, n4: number?)
	local Blur = t1:Get():FindFirstChild("Blur")

	if not Blur then
		Blur = Instance.new("BlurEffect")
		Blur.Size = 0
		Blur.Parent = t1:Get()
	end

	if n4 == 0 then
		Blur.Size = n3

		return
	end

	local tweenInfo = TweenInfo.new(n4, Enum.EasingStyle.Linear)

	TweenService:Create(Blur, tweenInfo, {
		Size = n3
	}):Play()
end

return t1
