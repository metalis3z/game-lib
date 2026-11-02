local RunService = game:GetService('RunService');

local function SpawnBezierProjectile(Config)
	local Projectile = Config.Projectile
	local StartPosition = Config.StartPosition
	local EndPosition = Config.EndPosition
	local Duration = Config.Duration or .5
	local ArcHeight = Config.ArcHeight or 1.75
	local Rotate = Config.Rotate ~= false
	local Parent = Config.Parent or workspace.IGNORE
	local Lifetime = Config.Lifetime or 0
	local OnHit = Config.OnHit or function() end
	local TickFunc = Config.TickFunc or function() end
	local InitialDirection = Config.InitialDirection

	if not Projectile then
		return nil
	end

	local ControlPoint = Config.ControlPoint or StartPosition:Lerp(EndPosition, 0.5) + Vector3.new(0, ArcHeight, 0);
	
	if Rotate and InitialDirection and InitialDirection.Magnitude > 0.001 then
		Projectile.CFrame = CFrame.lookAt(StartPosition, StartPosition + InitialDirection.Unit);
	else
		Projectile.CFrame = CFrame.new(StartPosition);
	end

	Projectile.Parent = Parent

	local Elapsed = 0
	local Connection

	Connection = RunService.Heartbeat:Connect(function(DeltaTime: number): ()
		if not Projectile or not Projectile.Parent then
			if Connection then
				Connection:Disconnect();
			end

			return
		end

		Elapsed += DeltaTime
		
		local Alpha = math.clamp(Elapsed / Duration, 0, 1);
		local InvdAlpha = 1 - Alpha
		local Position = InvdAlpha * InvdAlpha * StartPosition + 2 * InvdAlpha * Alpha * ControlPoint + Alpha * Alpha * EndPosition
		local Tangent = 2 * InvdAlpha * (ControlPoint - StartPosition) + 2 * Alpha * (EndPosition - ControlPoint)


		if Rotate and Tangent.Magnitude > 0.001 then
			Projectile.CFrame = CFrame.lookAt(Position, Position + Tangent.Unit);
		else
			Projectile.CFrame = CFrame.new(Position);
		end

	--	TickFunc(Projectile, Alpha, EasedAlpha);

		if Alpha >= 1 then
			Connection:Disconnect();

			OnHit(Position, Projectile);

			if Lifetime <= 0 then
				if Projectile and Projectile.Parent then
					Projectile:Destroy();
				end
			else
				task.delay(Lifetime, function(): ()
					if Projectile and Projectile.Parent then
						Projectile:Destroy();
					end
				end)
			end
		end
	end)

	return Projectile, Connection
end

return {
	SpawnBezierProjectile = SpawnBezierProjectile,
}