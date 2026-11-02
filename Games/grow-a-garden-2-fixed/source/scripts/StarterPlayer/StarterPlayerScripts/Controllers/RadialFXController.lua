--credit to leon games studio
local t = {}
local TweenService = game:GetService("TweenService")
local v1 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
local v2 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0)
local RadialScreenFlash = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("RadialScreenFlash")
local Networking = require(game.ReplicatedStorage.SharedModules.Networking)

function t.Start(p1) --[[ Start | Line: 13 ]] end
function t.Init(p1) --[[ Init | Line: 17 | Upvalues: Networking (copy), t (copy) ]]
	Networking.Flash.Flash.OnClientEvent:Connect(function(p1) --[[ Line: 18 | Upvalues: t (ref) ]]
		t:PlayFX(p1)
	end)
end
function t.PlayFX(p1, p2) --[[ PlayFX | Line: 23 | Upvalues: RadialScreenFlash (copy), TweenService (copy), v1 (copy), v2 (copy) ]]
	local v12 = RadialScreenFlash:FindFirstChild(p2)

	if not v12 then
		return
	end

	local v22 = TweenService:Create(v12, v1, {
		ImageTransparency = 0
	})

	v22:Play()
	game.Debris:AddItem(v22, v1.Time)
	task.spawn(function() --[[ Line: 29 | Upvalues: v1 (ref), TweenService (ref), v12 (copy), v2 (ref) ]]
		task.wait(v1.Time + 0.7)

		local v13 = TweenService:Create(v12, v2, {
			ImageTransparency = 1
		})

		v13:Play()
		game.Debris:AddItem(v13, v2.Time)
	end)
end

return t