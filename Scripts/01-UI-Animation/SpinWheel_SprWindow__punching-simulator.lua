-- Reference copy for study. Game: Punching Simulator (punching-simulator)
-- Original: StarterPlayer/StarterPlayerScripts/Client/Modules/UI/Wheel.lua  (luau, 237 lines)
-- Categories: rng-gacha 13.3
-- What it does: Reward wheel spin landing on a slot (5 full turns + slot offset, Quint out, 5 s) and window open/close driven by spr springs on Position, camera FOV and Blur.
-- Excerpt of lines 163-237 (rest of the file is game-specific wiring)

	task.spawn(function()
		local spinReward = props.reward
		local spinId = props.id

		local wheelRewardId = spinReward.id

		local wheelRewardInfo = WheelRewardUtility.getInfo(wheelRewardId)

		self._is_spinning:Set(true)
		
		local offset = (8 - wheelRewardId + 1) * 45
		
		FastTween(self.object.Main.Background.Inner, {
			Rotation = (360 * 5) + offset
		}, {5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out}).Completed:Wait()
		
		self.object.Main.Background.Inner.Rotation = offset
		
		local success = Network.Remote.Invoke("S_Wheel_Spin_Confirm", spinId)
		
		if success then
			if UI._current:Get() ~= "Trade" then
				UI.Open({
					name = "Reward", 
					props = {
						data = {
							{
								reward_name = wheelRewardInfo.reward_name,
								name = wheelRewardInfo.name,
								value = wheelRewardInfo.value
							}
						}
					}
				})
			end
		end
		
		self._is_spinning:Set(false)
	end)
end

function Wheel:Open()
	Spr.Stop(self.object.Main)
	
	
	self.object.Main.Visible = true
	self.object.Main.Position = UDim2.fromScale(0.5, 0.55)
	
	Spr.Target(self.object.Main, 1, 4, {
		Position = UDim2.fromScale(0.5, 0.5)
	})
	
	Spr.Target(workspace.CurrentCamera, 0.7, 4, {
		FieldOfView = 80
	})

	Spr.Target(Services.Lighting.Blur, 0.7, 4, {
		Size = 20
	})
end

function Wheel:Close()
	self.object.Main.Visible = false
	
	
	Spr.Target(workspace.CurrentCamera, 0.7, 4, {
		FieldOfView = 70
	})
	
	Spr.Target(Services.Lighting.Blur, 0.7, 4, {
		Size = 0
	})
end

return Wheel