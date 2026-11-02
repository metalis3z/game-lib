local team = game.Teams.Guards

local door = script.Parent

local on = false

door.Touched:connect(function(hit)
 local humanoid = hit.Parent:FindFirstChild("Humanoid")
 if humanoid then
  local plr = game.Players:GetPlayerFromCharacter(hit.Parent)
		if plr.Team == team then
			if on == false then
				on = true
				script.Parent.Parent.Parent.scn.cardScanner.Sound:Play()
	  		script.Parent.Parent.Parent.scn.glow.brickColor = BrickColor.new("Lime green")
	  		script.Parent.CanCollide = false
	  		script.Parent.Parent.Part.CanCollide = false
	  		script.Parent.Parent.Part.Transparency = 1  
	  		script.Parent.Parent.Part1.Transparency = 1
	  		script.Parent.Parent.Part2.Transparency = 1
	  		script.Parent.Parent.Part3.Transparency = 1
	  		script.Parent.Parent.Part4.Transparency = 1
	  		script.Parent.Parent.Part5.Transparency = 1
	  		script.Parent.Parent.Part1.CanCollide = false
	  		script.Parent.Parent.Part2.CanCollide = false
	  		script.Parent.Parent.Part3.CanCollide = false
	  		script.Parent.Parent.Part4.CanCollide = false
	  		script.Parent.Parent.Part5.CanCollide = false
				wait(3)
				on = false
				script.Parent.Parent.Parent.scn.glow.brickColor = BrickColor.new("Bright red")
				script.Parent.CanCollide = true
	  		script.Parent.Parent.Part.Transparency = 0 
	  		script.Parent.Parent.Part1.Transparency = 0
	  		script.Parent.Parent.Part2.Transparency = 0.5
	  		script.Parent.Parent.Part3.Transparency = 0
	  		script.Parent.Parent.Part4.Transparency = 0
	  		script.Parent.Parent.Part5.Transparency = 0
	  		script.Parent.Parent.Part1.CanCollide = true
	  		script.Parent.Parent.Part2.CanCollide = true
	  		script.Parent.Parent.Part3.CanCollide = true
	  		script.Parent.Parent.Part4.CanCollide = true
	  		script.Parent.Parent.Part5.CanCollide = true
			end
		end
 	end
end)