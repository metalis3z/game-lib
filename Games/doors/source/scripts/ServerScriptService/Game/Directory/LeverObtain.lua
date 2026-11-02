local module = {}

-- Created and Fixed by BUILDG Studios

function module:Create(v)
	local Lever = v
	
	local Prompt = Lever:FindFirstChildOfClass("ProximityPrompt")
	
	Prompt.Triggered:Connect(function()
		if Lever:GetAttribute("Triggered", true) then
			return
		else
			Lever:SetAttribute("Triggered", true)
		end
		
		local Gate = Lever.Parent.Parent.Gate
		local Main = Lever.Main
		
		Main.SoundToPlay:Play()
		Main.ToUnanchor.Anchored = false
		
		Gate.ThingToOpen.Anchored = false
		Gate.ThingToOpen.CanCollide = false
		Gate.GateWall.CanCollide = false
		Gate.ThingToOpen.SoundToPlay:Play()
	end)
end

return module
