





local acti = false

local uses = 10

local idle



script.Parent.Activated:Connect(function()

	local plr = game.Players:GetPlayerFromCharacter(script.Parent.Parent)

	if acti == false then

		acti = true

		local sound = script.Parent.Handle.Sound

		sound:Play()
		wait(.1)
		local animation = plr.Character.Humanoid:LoadAnimation(script.Parent.Take)
		animation:Play()




		uses = uses - 1

		script.Parent.ToolTip = uses.." Uses"


		wait(1.8)





		local a = game.ServerStorage.Mentos:Clone()

		a.Parent = plr.Backpack





		if uses == 0 then
			if idle then
				idle:Stop()

			end

			script.Parent:Destroy()


		end

		wait(.2)

		acti = false

	end
end)


script.Parent.Equipped:Connect(function()

	local plr = game.Players:GetPlayerFromCharacter(script.Parent.Parent)

	idle = plr.Character.Humanoid:LoadAnimation(script.Parent.Hold)


	idle:Play()


end)


script.Parent.Unequipped:Connect(function()

	if idle then

		idle:Stop()

	end

end)

