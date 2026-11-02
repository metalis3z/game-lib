local module = {}

function module:Bookshelf(v)
	local Animation = Instance.new("Animation")
	Animation.AnimationId = "rbxassetid://13401085851"
	
	local AnimationController = v:FindFirstChild("AnimationController")
	
	local Sound = script.Fall:Clone()
	Sound.Parent = v.Collision
	
	local Sound2 = script.Books:Clone()
	Sound2.Parent = v.Collision

	task.delay(1.1, function()
		local LoadAnimation1 = AnimationController:LoadAnimation(Animation)
		
		LoadAnimation1:Play()
		LoadAnimation1:AdjustSpeed(1)
		Sound2:Play()
		v.Model.AnimatedBookshelf2.ParticleEmitter:Emit(27)
		task.wait(1.2)
		game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(1, 20, 0, 1)
		Sound:Play()
		wait(3)
		LoadAnimation1:AdjustSpeed(0)
	end)
end

return module
