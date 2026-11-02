--[[
 	  _______  ___________   ___________ ____________  _   ______
 	 / __/ _ \/  _/ ___/ /  /  _/ ___/ // /_  __/ __/ | | / /_  /
 	/ _// ___// // /__/ /___/ // (_ / _  / / / _\ \   | |/ //_ < 
   /___/_/  /___/\___/____/___/\___/_//_/ /_/ /___/   |___/____/ 
   
   https://discord.gg/Vk7uGNnX9M
   join the discord for any questions or support relating to my plugins
    
]]--

local F = {}
local TweenService = game:GetService("TweenService")
local DriveSeat = script.Parent.Parent:WaitForChild("DriveSeat")
local car = DriveSeat.Parent
local event = script.Parent
local leaveseatevent = script.Parent.OnLeave

local lights = car.Body.Lights
local misc = car.Misc
local PHeadlights = misc:FindFirstChild("Popups")
local trunk = misc:FindFirstChild("TK")
local isSetupCompleted = false
local doors = {}
local mirrorL
local mirrorR
local intlights
local doorFunction

for i, v in pairs(misc:GetDescendants()) do
	if v.Name == "FL" or v.Name == "FR" or v.Name == "RL" or v.Name == "RR" then
		table.insert(doors, v)
	end
end

local rl_loc
local l_tweeninfo
local ind_tweeninfo

F.Setup = function(lowbeamc, highbeamc, runninglightc, frontindc, rearindc, foglightc, popupe, platelighte, platelightc, trunklighte, mirrorinde, run_loc, ft, ind_fr, intlightse, intlightsc, doorFunctione)
	if not isSetupCompleted then
		l_tweeninfo = TweenInfo.new(ft, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0)
		ind_tweeninfo = TweenInfo.new(ind_fr / 2.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0)
		event.IndicatorsAfterLeave.Disabled = true
		
		intlights = intlightse
		doorFunction = doorFunctione
		
		if trunklighte and trunk ~= nil then
			for i, v in pairs(trunk.Brake:GetChildren()) do
				if v.Name == "L" and v.Parent.Name == "Brake" and #v:GetChildren() < 1  then
					local spot = Instance.new("SpotLight", v)
					spot.Name = "L"
					spot.Brightness = 0
					spot.Range = 38
					spot.Face = Enum.NormalId.Front
					spot.Color = Color3.fromRGB(255, 0, 0)
					spot.Shadows = true
					spot.Angle = 180
				elseif v.Name == "LN" then
					if v:IsA("MeshPart") then
						v.TextureID = ""
					end
					v.Material = Enum.Material.Neon
					v.Color = Color3.fromRGB(248, 87, 73)
					v.Transparency = 1					
				end	 
			end
			for i, v in pairs(trunk.Rear:GetChildren()) do
				if v.Name == "L" and v.Parent.Name == "Rear" and #v:GetChildren() < 1 then
					local spot = Instance.new("SpotLight", v)
					spot.Name = "L"
					spot.Brightness = 0
					spot.Range = 25
					spot.Face = Enum.NormalId.Front
					spot.Color = Color3.fromRGB(255, 0, 0)
					spot.Shadows = true
					spot.Angle = 180
				elseif v.Name == "LN" then
					if v:IsA("MeshPart") then
						v.TextureID = ""
					end
					v.Material = Enum.Material.Neon
					v.Color = Color3.fromRGB(248, 87, 73)
					v.Transparency = 1				
				end	 
			end
			for i, v in pairs(trunk.Reverse:GetChildren()) do
				if v.Name == "L" and v.Parent.Name == "Reverse" and #v:GetChildren() < 1 then		
					local spot = Instance.new("SpotLight", v)
					spot.Name = "L"
					spot.Brightness = 0
					spot.Range = 20
					spot.Face = Enum.NormalId.Front
					spot.Color = Color3.fromRGB(255, 255, 255)
					spot.Shadows = true
					spot.Angle = 180
				elseif v.Name == "LN" then
					if v:IsA("MeshPart") then
						v.TextureID = ""
					end
					v.Material = Enum.Material.Neon
					v.Color = Color3.fromRGB(255, 255, 255)
					v.Transparency = 1				
				end	 
			end
		end
		
		for i, v in pairs(lights.Brake:GetChildren()) do
			if v.Name == "L" and v.Parent.Name == "Brake" and #v:GetChildren() < 1  then
				local spot = Instance.new("SpotLight", v)
				spot.Name = "L"
				spot.Brightness = 0
				spot.Range = 38
				spot.Face = Enum.NormalId.Front
				spot.Color = Color3.fromRGB(255, 0, 0)
				spot.Shadows = true
				spot.Angle = 180
			elseif v.Name == "LN" then
				if v:IsA("MeshPart") then
					v.TextureID = ""
				end
				v.Material = Enum.Material.ForceField
				v.Color = Color3.fromRGB(248, 87, 73)
				v.Transparency = 1					
			end	 
		end
		
		for i, v in pairs(lights.Rear:GetChildren()) do
			if v.Name == "L" and v.Parent.Name == "Rear" and #v:GetChildren() < 1 then
				local spot = Instance.new("SpotLight", v)
				spot.Name = "L"
				spot.Brightness = 0
				spot.Range = 25
				spot.Face = Enum.NormalId.Front
				spot.Color = Color3.fromRGB(255, 0, 0)
				spot.Shadows = true
				spot.Angle = 180
			elseif v.Name == "LN" then
				if v:IsA("MeshPart") then
					v.TextureID = ""
				end
				v.Material = Enum.Material.Neon
				v.Color = Color3.fromRGB(248, 87, 73)
				v.Transparency = 1				
			end	 
		end
		
		for i, v in pairs(lights.Reverse:GetChildren()) do
			if v.Name == "L" and v.Parent.Name == "Reverse" and #v:GetChildren() < 1 then		
				local spot = Instance.new("SpotLight", v)
				spot.Name = "L"
				spot.Brightness = 0
				spot.Range = 20
				spot.Face = Enum.NormalId.Front
				spot.Color = Color3.fromRGB(255, 255, 255)
				spot.Shadows = true
				spot.Angle = 180
			elseif v.Name == "LN" then
				if v:IsA("MeshPart") then
					v.TextureID = ""
				end
				v.Material = Enum.Material.Neon
				v.Color = Color3.fromRGB(255, 255, 255)
				v.Transparency = 1				
			end	 
		end
		
		for i, v in pairs(lights.LeftInd:GetDescendants()) do
			if v.Name == "L"  and v.Parent.Parent.Name == "LeftInd" and #v:GetChildren() < 1 then
				local sfc = Instance.new("SurfaceLight", v)
				sfc.Name = "L"
				sfc.Brightness = 0
				sfc.Range = 16
				sfc.Face = Enum.NormalId.Front
				sfc.Angle = 180
				if v.Parent.Name == "Front" or v.Parent.Name == "Side" then
					if frontindc == "Light Orange" then
						sfc.Color = Color3.fromRGB(255, 130, 80) 
					elseif frontindc == "Yellow" then
						sfc.Color = Color3.fromRGB(181, 154, 45) 
					elseif frontindc == "Red" then
						sfc.Color = Color3.fromRGB(241, 57, 60) 
					elseif frontindc == "Dark Orange" then
						sfc.Color = Color3.fromRGB(198, 107, 54) 
					else
						sfc.Color = frontindc
					end	
				elseif v.Parent.Name == "Rear" then
					if rearindc == "Light Orange" then
						sfc.Color = Color3.fromRGB(255, 130, 80) 
					elseif rearindc == "Yellow" then
					sfc.Color = Color3.fromRGB(181, 154, 45) 
					elseif rearindc == "Red" then
						sfc.Color = Color3.fromRGB(241, 57, 60) 
					elseif rearindc == "Dark Orange" then
						sfc.Color = Color3.fromRGB(198, 107, 54) 
					else
						sfc.Color = rearindc
					end	
				end
			elseif v.Name == "LN" then
				if v:IsA("MeshPart") then
					v.TextureID = ""
				end
				v.Material = Enum.Material.Neon
				if v.Parent.Name == "Front" or v.Parent.Name == "Side" then
					if frontindc == "Light Orange" then
						v.Color = Color3.fromRGB(255, 130, 80) 
					elseif frontindc == "Yellow" then
						v.Color = Color3.fromRGB(181, 154, 45) 
					elseif frontindc == "Red" then
						v.Color = Color3.fromRGB(241, 57, 60) 
					elseif frontindc == "Dark Orange" then
						v.Color = Color3.fromRGB(198, 107, 54) 
					else
						v.Color = frontindc
					end	
				elseif v.Parent.Name == "Rear" then
					if rearindc == "Light Orange" then
						v.Color = Color3.fromRGB(255, 130, 80) 
					elseif rearindc == "Yellow" then
						v.Color = Color3.fromRGB(181, 154, 45) 
					elseif rearindc == "Red" then
						v.Color = Color3.fromRGB(241, 57, 60) 
					elseif rearindc == "Dark Orange" then
						v.Color = Color3.fromRGB(198, 107, 54) 
					else
						v.Color = rearindc
					end	
				end
				v.Transparency = 1							
			elseif string.sub(v.Name, 1, 2) == "SI" then
				if v:IsA("MeshPart") then
					v.TextureID = ""
				end
				v.Material = Enum.Material.Neon
				if v.Parent.Name == "Front" or v.Parent.Name == "Side" then
					if frontindc == "Light Orange" then
						v.Color = Color3.fromRGB(255, 130, 80) 
					elseif frontindc == "Yellow" then
						v.Color = Color3.fromRGB(181, 154, 45) 
					elseif frontindc == "Red" then
						v.Color = Color3.fromRGB(241, 57, 60) 
					elseif frontindc == "Dark Orange" then
						v.Color = Color3.fromRGB(198, 107, 54) 
					else
						v.Color = frontindc
					end	
				elseif v.Parent.Name == "Rear" then
					if rearindc == "Light Orange" then
						v.Color = Color3.fromRGB(255, 130, 80) 
					elseif rearindc == "Yellow" then
						v.Color = Color3.fromRGB(181, 154, 45) 
					elseif rearindc == "Red" then
						v.Color = Color3.fromRGB(241, 57, 60) 
					elseif rearindc == "Dark Orange" then
						v.Color = Color3.fromRGB(198, 107, 54) 
					else
						v.Color = rearindc
					end	
				end
				v.Transparency = 1	
			end	 
		end
	
		for i, v in pairs(lights.RightInd:GetDescendants()) do
			if v.Name == "L"  and v.Parent.Parent.Name == "RightInd" and #v:GetChildren() < 1 then
				local sfc = Instance.new("SurfaceLight", v)
				sfc.Name = "L"
				sfc.Brightness = 0
				sfc.Range = 16
				sfc.Face = Enum.NormalId.Front
				sfc.Angle = 180
				if v.Parent.Name == "Front" or v.Parent.Name == "Side" then
					if frontindc == "Light Orange" then
						sfc.Color = Color3.fromRGB(255, 130, 80) 
					elseif frontindc == "Yellow" then
						sfc.Color = Color3.fromRGB(181, 154, 45) 
					elseif frontindc == "Red" then
						sfc.Color = Color3.fromRGB(241, 57, 60) 
					elseif frontindc == "Dark Orange" then
						sfc.Color = Color3.fromRGB(198, 107, 54) 
					else
						sfc.Color = frontindc
					end	
				elseif v.Parent.Name == "Rear" then
					if rearindc == "Light Orange" then
						sfc.Color = Color3.fromRGB(255, 130, 80) 
					elseif rearindc == "Yellow" then
						sfc.Color = Color3.fromRGB(181, 154, 45) 
					elseif rearindc == "Red" then
						sfc.Color = Color3.fromRGB(241, 57, 60) 
					elseif rearindc == "Dark Orange" then
						sfc.Color = Color3.fromRGB(198, 107, 54) 
					else
						sfc.Color = rearindc
					end	
				end
			elseif v.Name == "LN" then
				if v:IsA("MeshPart") then
					v.TextureID = ""
				end
				v.Material = Enum.Material.Neon
				if v.Parent.Name == "Front" or v.Parent.Name == "Side" then
					if frontindc == "Light Orange" then
						v.Color = Color3.fromRGB(255, 130, 80) 
					elseif frontindc == "Yellow" then
						v.Color = Color3.fromRGB(181, 154, 45) 
					elseif frontindc == "Red" then
						v.Color = Color3.fromRGB(241, 57, 60) 
					elseif frontindc == "Dark Orange" then
						v.Color = Color3.fromRGB(198, 107, 54) 
					else
						v.Color = frontindc
					end	
				elseif v.Parent.Name == "Rear" then
					if rearindc == "Light Orange" then
						v.Color = Color3.fromRGB(255, 130, 80) 
					elseif rearindc == "Yellow" then
						v.Color = Color3.fromRGB(181, 154, 45) 
					elseif rearindc == "Red" then
						v.Color = Color3.fromRGB(241, 57, 60) 
					elseif rearindc == "Dark Orange" then
						v.Color = Color3.fromRGB(198, 107, 54) 
					else
						v.Color = rearindc
					end	
				end
				v.Transparency = 1							
			elseif string.sub(v.Name, 1, 2) == "SI" then
				if v:IsA("MeshPart") then
					v.TextureID = ""
				end
				v.Material = Enum.Material.Neon
				if v.Parent.Name == "Front" or v.Parent.Name == "Side" then
					if frontindc == "Light Orange" then
						v.Color = Color3.fromRGB(255, 130, 80) 
					elseif frontindc == "Yellow" then
						v.Color = Color3.fromRGB(181, 154, 45) 
					elseif frontindc == "Red" then
						v.Color = Color3.fromRGB(241, 57, 60) 
					elseif frontindc == "Dark Orange" then
						v.Color = Color3.fromRGB(198, 107, 54) 
					else
						v.Color = frontindc
					end	
				elseif v.Parent.Name == "Rear" then
					if rearindc == "Light Orange" then
						v.Color = Color3.fromRGB(255, 130, 80) 
					elseif rearindc == "Yellow" then
						v.Color = Color3.fromRGB(181, 154, 45) 
					elseif rearindc == "Red" then
						v.Color = Color3.fromRGB(241, 57, 60) 
					elseif rearindc == "Dark Orange" then
						v.Color = Color3.fromRGB(198, 107, 54) 
					else
						v.Color = rearindc
					end	
				end
				v.Transparency = 1	
			end	
		end	
	
		if platelighte then
			for i, v in pairs(lights.Plate:GetDescendants()) do
				if v.Name == "L" and v.Parent.Name == "Plate" and #v:GetChildren() < 1 then
					local sfc = Instance.new("SurfaceLight", v)
					sfc.Name = "L"
					sfc.Angle = 135
					sfc.Brightness = 0
					sfc.Range = 1
					sfc.Face = Enum.NormalId.Bottom
					sfc.Shadows = true
					if lowbeamc == "Pure White" then
						sfc.Color = Color3.fromRGB(255, 255, 255) 
					elseif lowbeamc == "OEM White" then
						sfc.Color = Color3.fromRGB(255, 237, 199)
					elseif lowbeamc == "Xenon" then
						sfc.Color = Color3.fromRGB(205, 227, 255) 
					elseif lowbeamc == "Brilliant Blue" then
						sfc.Color = Color3.fromRGB(74, 137, 255)
					elseif lowbeamc == "Light Green" then
						sfc.Color = Color3.fromRGB(175, 196, 196)
					elseif lowbeamc == "Golden Yellow" then
						sfc.Color = Color3.fromRGB(255, 239, 193)
					elseif lowbeamc == "Bubu's Purple" then
						sfc.Color = Color3.fromRGB(197, 197, 255)
					elseif lowbeamc == "Yellow" then
						sfc.Color = Color3.fromRGB(181, 178, 87) 
					else
						sfc.Color = lowbeamc
					end	
					sfc.Shadows = true
				elseif v.Name == "LN" then
					if v:IsA("MeshPart") then
						v.TextureID = ""
					end
					v.Material = Enum.Material.Neon
					if lowbeamc == "Pure White" then
						v.Color = Color3.fromRGB(255, 255, 255) 
					elseif lowbeamc == "OEM White" then
						v.Color = Color3.fromRGB(255, 180, 161) 
					elseif lowbeamc == "Xenon" then
						v.Color = Color3.fromRGB(226, 231, 255) 
					elseif lowbeamc == "Brilliant Blue" then
						v.Color = Color3.fromRGB(97, 126, 255)
					elseif lowbeamc == "Light Green" then
						v.Color = Color3.fromRGB(165, 195, 196)
					elseif lowbeamc == "Golden Yellow" then
						v.Color = Color3.fromRGB(255, 169, 140)
					elseif lowbeamc == "Bubu's Purple" then
						v.Color = Color3.fromRGB(150, 146, 255)
					elseif lowbeamc == "Yellow" then
						v.Color = Color3.fromRGB(181, 178, 87) 
					else
						v.Color = lowbeamc
					end
					v.Transparency = 1	
				end	 
			end
		end		
		
		if run_loc == "Low Beam / Indicators" then
			rl_loc = 1
		elseif run_loc == "Low Beam" then
			rl_loc = 2
		elseif run_loc == "Custom DRL" then	
			rl_loc = 3
			for i, v in pairs(lights.Headlights.Running:GetDescendants()) do
				if v.Name == "LN" then
					if v:IsA("MeshPart") then
						v.TextureID = ""
					end
					v.Material = Enum.Material.Neon
					if runninglightc == "Pure White" then
						v.Color = Color3.fromRGB(255, 255, 255) 
					elseif runninglightc == "OEM White" then
						v.Color = Color3.fromRGB(255, 180, 161) 
					elseif runninglightc == "Xenon" then
						v.Color = Color3.fromRGB(226, 231, 255) 
					elseif runninglightc == "Brilliant Blue" then
						v.Color = Color3.fromRGB(97, 126, 255)
					elseif runninglightc == "Light Green" then
						v.Color = Color3.fromRGB(165, 195, 196)
					elseif runninglightc == "Golden Yellow" then
						v.Color = Color3.fromRGB(255, 169, 140)
					elseif runninglightc == "Bubu's Purple" then
						v.Color = Color3.fromRGB(150, 146, 255)
					elseif runninglightc == "Yellow" then
						v.Color = Color3.fromRGB(181, 178, 87) 
					else
						v.Color = runninglightc
					end
					v.Transparency = 1				
				end	 
			end
		end	
	
		for i, v in pairs(lights.Headlights.Low:GetChildren()) do
			if v.Name == "L" and v.Parent.Name == "Low" and #v:GetChildren() < 1 then		
				local spot = Instance.new("SpotLight", v)
				spot.Angle = 180
				spot.Name = "L"
				spot.Brightness = 0
				spot.Range = 0
				spot.Face = Enum.NormalId.Front
				if lowbeamc == "Pure White" then
					spot.Color = Color3.fromRGB(255, 255, 255) 
				elseif lowbeamc == "OEM White" then
					spot.Color = Color3.fromRGB(255, 237, 199)
				elseif lowbeamc == "Xenon" then
					spot.Color = Color3.fromRGB(205, 227, 255) 
				elseif lowbeamc == "Brilliant Blue" then
					spot.Color = Color3.fromRGB(74, 137, 255)
				elseif lowbeamc == "Light Green" then
					spot.Color = Color3.fromRGB(175, 196, 196)
				elseif lowbeamc == "Golden Yellow" then
					spot.Color = Color3.fromRGB(255, 239, 193)
				elseif lowbeamc == "Bubu's Purple" then
					spot.Color = Color3.fromRGB(197, 197, 255)
				elseif lowbeamc == "Yellow" then
					spot.Color = Color3.fromRGB(181, 178, 87) 
				else
					spot.Color = lowbeamc
				end	
				spot.Shadows = true
			elseif v.Name == "LN" then
				if v:IsA("MeshPart") then
					v.TextureID = ""
				end
				v.Material = Enum.Material.Neon
				if lowbeamc == "Pure White" then
					v.Color = Color3.fromRGB(255, 255, 255) 
				elseif lowbeamc == "OEM White" then
					v.Color = Color3.fromRGB(255, 180, 161) 
				elseif lowbeamc == "Xenon" then
					v.Color = Color3.fromRGB(226, 231, 255) 
				elseif lowbeamc == "Brilliant Blue" then
					v.Color = Color3.fromRGB(97, 126, 255)
				elseif lowbeamc == "Light Green" then
					v.Color = Color3.fromRGB(165, 195, 196)
				elseif lowbeamc == "Golden Yellow" then
					v.Color = Color3.fromRGB(255, 169, 140)
				elseif lowbeamc == "Bubu's Purple" then
					v.Color = Color3.fromRGB(150, 146, 255)
				elseif lowbeamc == "Yellow" then
					v.Color = Color3.fromRGB(181, 178, 87) 
				else
					v.Color = lowbeamc
				end
				v.Transparency = 1					
			end	 
		end
		
		for i, v in pairs(lights.Headlights.High:GetChildren()) do
			if v.Name == "L" and v.Parent.Name == "High" and #v:GetChildren() < 1 then		
				local spot = Instance.new("SpotLight", v)
				spot.Name = "L"
				spot.Angle = 180
				spot.Brightness = 0
				spot.Range = 0
				spot.Face = Enum.NormalId.Front
				if highbeamc == "Pure White" then
					spot.Color = Color3.fromRGB(255, 255, 255) 
				elseif highbeamc == "OEM White" then
					spot.Color = Color3.fromRGB(255, 237, 199)
				elseif highbeamc == "Xenon" then
					spot.Color = Color3.fromRGB(205, 227, 255) 
				elseif highbeamc == "Brilliant Blue" then
					spot.Color = Color3.fromRGB(74, 137, 255)
				elseif highbeamc == "Light Green" then
					spot.Color = Color3.fromRGB(175, 196, 196)
				elseif highbeamc == "Golden Yellow" then
					spot.Color = Color3.fromRGB(255, 239, 193)
				elseif highbeamc == "Bubu's Purple" then
					spot.Color = Color3.fromRGB(197, 197, 255)
				elseif highbeamc == "Yellow" then
					spot.Color = Color3.fromRGB(181, 178, 87) 
				else
					spot.Color = highbeamc
				end	
				spot.Shadows = true
			elseif v.Name == "LN" then
				if v:IsA("MeshPart") then
					v.TextureID = ""
				end
				v.Material = Enum.Material.Neon
				if highbeamc == "Pure White" then
					v.Color = Color3.fromRGB(255, 255, 255) 
				elseif highbeamc == "OEM White" then
					v.Color = Color3.fromRGB(255, 180, 161) 
				elseif highbeamc == "Xenon" then
					v.Color = Color3.fromRGB(226, 231, 255) 
				elseif highbeamc == "Brilliant Blue" then
					v.Color = Color3.fromRGB(97, 126, 255)
				elseif highbeamc == "Light Green" then
					v.Color = Color3.fromRGB(165, 195, 196)
				elseif highbeamc == "Golden Yellow" then
					v.Color = Color3.fromRGB(255, 169, 140)
				elseif highbeamc == "Bubu's Purple" then
					v.Color = Color3.fromRGB(150, 146, 255)
				elseif highbeamc == "Yellow" then
					v.Color = Color3.fromRGB(181, 178, 87) 
				else
					v.Color = highbeamc
				end
				v.Transparency = 1					
			end	 
		end		
		
		if popupe and PHeadlights ~= nil then
			for i, v in pairs(PHeadlights.Parts.Headlights:GetChildren()) do
				if v.Name == "L" and #v:GetChildren() < 1 then		
					local spot = Instance.new("SpotLight", v)
					spot.Name = "L"
					spot.Angle = 180
					spot.Brightness = 0
					spot.Range = 0
					spot.Face = Enum.NormalId.Front
					if lowbeamc == "Pure White" then
						spot.Color = Color3.fromRGB(255, 255, 255) 
					elseif lowbeamc == "OEM White" then
						spot.Color = Color3.fromRGB(255, 237, 199)
					elseif lowbeamc == "Xenon" then
						spot.Color = Color3.fromRGB(205, 227, 255) 
					elseif lowbeamc == "Brilliant Blue" then
						spot.Color = Color3.fromRGB(74, 137, 255)
					elseif lowbeamc == "Light Green" then
						spot.Color = Color3.fromRGB(175, 196, 196)
					elseif lowbeamc == "Golden Yellow" then
						spot.Color = Color3.fromRGB(255, 239, 193)
					elseif lowbeamc == "Bubu's Purple" then
						spot.Color = Color3.fromRGB(197, 197, 255)
					elseif lowbeamc == "Yellow" then
						spot.Color = Color3.fromRGB(181, 178, 87) 
					else
						spot.Color = lowbeamc
					end	
					spot.Shadows = true
				elseif v.Name == "LN" then
					if v:IsA("MeshPart") then
						v.TextureID = ""
					end
					v.Material = Enum.Material.Neon
					if lowbeamc == "Pure White" then
						v.Color = Color3.fromRGB(255, 255, 255) 
					elseif lowbeamc == "OEM White" then
						v.Color = Color3.fromRGB(255, 180, 161) 
					elseif lowbeamc == "Xenon" then
						v.Color = Color3.fromRGB(226, 231, 255) 
					elseif lowbeamc == "Brilliant Blue" then
						v.Color = Color3.fromRGB(97, 126, 255)
					elseif lowbeamc == "Light Green" then
						v.Color = Color3.fromRGB(165, 195, 196)
					elseif lowbeamc == "Golden Yellow" then
						v.Color = Color3.fromRGB(255, 169, 140)
					elseif lowbeamc == "Bubu's Purple" then
						v.Color = Color3.fromRGB(150, 146, 255)
					elseif lowbeamc == "Yellow" then
						v.Color = Color3.fromRGB(181, 178, 87) 
					else
						v.Color = lowbeamc
					end
					v.Transparency = 1					
				end	 
			end			
		end
		for i, v in pairs(lights.Fog:GetChildren()) do
			if v.Name == "L" and v.Parent.Name == "Fog" and #v:GetChildren() < 1 then
				local spot = Instance.new("SpotLight", v)
				spot.Name = "L"
				spot.Angle = 180
				spot.Brightness = 0
				spot.Range = 48
				spot.Face = Enum.NormalId.Front
				if foglightc == "Pure White" then
					spot.Color = Color3.fromRGB(255, 255, 255) 
				elseif foglightc == "OEM White" then
					spot.Color = Color3.fromRGB(255, 237, 199)
				elseif foglightc == "Xenon" then
					spot.Color = Color3.fromRGB(205, 227, 255) 
				elseif foglightc == "Brilliant Blue" then
					spot.Color = Color3.fromRGB(74, 137, 255)
				elseif foglightc == "Light Green" then
					spot.Color = Color3.fromRGB(175, 196, 196)
				elseif foglightc == "Golden Yellow" then
					spot.Color = Color3.fromRGB(255, 239, 193)
				elseif foglightc == "Bubu's Purple" then
					spot.Color = Color3.fromRGB(197, 197, 255)
				elseif foglightc == "Yellow" then
					spot.Color = Color3.fromRGB(181, 178, 87) 
				else
					spot.Color = foglightc
				end	
				spot.Shadows = true
			elseif v.Name == "LN" then
				if v:IsA("MeshPart") then
					v.TextureID = ""
				end
				v.Material = Enum.Material.Neon
				if foglightc == "Pure White" then
					v.Color = Color3.fromRGB(255, 255, 255) 
				elseif foglightc == "OEM White" then
					v.Color = Color3.fromRGB(255, 180, 161) 
				elseif foglightc == "Xenon" then
					v.Color = Color3.fromRGB(226, 231, 255) 
				elseif foglightc == "Brilliant Blue" then
					v.Color = Color3.fromRGB(97, 126, 255)
				elseif foglightc == "Light Green" then
					v.Color = Color3.fromRGB(165, 195, 196)
				elseif foglightc == "Golden Yellow" then
					v.Color = Color3.fromRGB(255, 169, 140)
				elseif foglightc == "Bubu's Purple" then
					v.Color = Color3.fromRGB(150, 146, 255)
				elseif foglightc == "Yellow" then
					v.Color = Color3.fromRGB(181, 178, 87) 
				else
					v.Color = foglightc
				end
				v.Transparency = 1
			end	
		end
		
		if intlightse then
			for i, v in pairs(lights.Interior:GetChildren()) do
				if v.Name == "FrontL" then		
					local spot = Instance.new("SpotLight", v)
					spot.Name = "L"
					print(spot.Parent.Name)
					spot.Angle = 135
					spot.Brightness = 0
					spot.Range = 0
					spot.Face = Enum.NormalId.Bottom
					if intlightsc == "Pure White" then
						spot.Color = Color3.fromRGB(255, 255, 255) 
					elseif intlightsc == "OEM White" then
						spot.Color = Color3.fromRGB(255, 237, 199)
					elseif intlightsc == "Xenon" then
						spot.Color = Color3.fromRGB(205, 227, 255) 
					elseif intlightsc == "Brilliant Blue" then
						spot.Color = Color3.fromRGB(74, 137, 255)
					elseif intlightsc == "Light Green" then
						spot.Color = Color3.fromRGB(175, 196, 196)
					elseif intlightsc == "Golden Yellow" then
						spot.Color = Color3.fromRGB(255, 239, 193)
					elseif intlightsc == "Bubu's Purple" then
						spot.Color = Color3.fromRGB(197, 197, 255)
					elseif intlightsc == "Yellow" then
						spot.Color = Color3.fromRGB(181, 178, 87) 
					else
						spot.Color = intlightsc
					end	
					spot.Shadows = true
				elseif v.Name == "CenterL" then
					local point = Instance.new("PointLight", v)
					point.Name = "L"
					point.Brightness = 0
					point.Range = 0
					if intlightsc == "Pure White" then
						point.Color = Color3.fromRGB(255, 255, 255) 
					elseif intlightsc == "OEM White" then
						point.Color = Color3.fromRGB(255, 237, 199)
					elseif intlightsc == "Xenon" then
						point.Color = Color3.fromRGB(205, 227, 255) 
					elseif intlightsc == "Brilliant Blue" then
						point.Color = Color3.fromRGB(74, 137, 255)
					elseif intlightsc == "Light Green" then
						point.Color = Color3.fromRGB(175, 196, 196)
					elseif intlightsc == "Golden Yellow" then
						point.Color = Color3.fromRGB(255, 239, 193)
					elseif intlightsc == "Bubu's Purple" then
						point.Color = Color3.fromRGB(197, 197, 255)
					elseif intlightsc == "Yellow" then
						point.Color = Color3.fromRGB(181, 178, 87) 
					else
						point.Color = intlightsc
					end	
					point.Shadows = true
				elseif v.Name == "CLN" or v.Name == "FLN" then
					if v:IsA("MeshPart") then
						v.TextureID = ""
					end
					v.Material = Enum.Material.Neon
					if highbeamc == "Pure White" then
						v.Color = Color3.fromRGB(255, 255, 255) 
					elseif highbeamc == "OEM White" then
						v.Color = Color3.fromRGB(255, 180, 161) 
					elseif highbeamc == "Xenon" then
						v.Color = Color3.fromRGB(226, 231, 255) 
					elseif highbeamc == "Brilliant Blue" then
						v.Color = Color3.fromRGB(97, 126, 255)
					elseif highbeamc == "Light Green" then
						v.Color = Color3.fromRGB(165, 195, 196)
					elseif highbeamc == "Golden Yellow" then
						v.Color = Color3.fromRGB(255, 169, 140)
					elseif highbeamc == "Bubu's Purple" then
						v.Color = Color3.fromRGB(150, 146, 255)
					elseif highbeamc == "Yellow" then
						v.Color = Color3.fromRGB(181, 178, 87) 
					else
						v.Color = highbeamc
					end
					v.Transparency = 1					
				end	
			end
		end
		print("EpicLights Version 3 // Setup completed!")
		isSetupCompleted = true		
	end
	intLights()
end	
	
F.SignalLeft = function(b, tp, t, seq, iseg)
	if tp == 0.71 then
		if t == "Halogen" then
			for i, v in pairs(lights.LeftInd:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					TweenService:Create(v, ind_tweeninfo, {Brightness = b}):Play()
				elseif v.Name == "LN" and v.Parent.Name == "Rear" then
					TweenService:Create(v, ind_tweeninfo, {Transparency = 1}):Play()
				elseif v.Name == "LN" and v.Parent.Name == "Front" then
					TweenService:Create(v, ind_tweeninfo, {Transparency = tp}):Play()
				end
			end
		elseif t == "LED" then
			for i, v in pairs(lights.LeftInd:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					v.Brightness = b
				elseif v.Name == "LN" and v.Parent.Name == "Rear" then
					v.Transparency = 1
				elseif v.Name == "LN" and v.Parent.Name == "Front" then
					v.Transparency = tp
				end
			end
		end
	else
		if t == "Halogen" then
			if not seq then
				for i, v in pairs(lights.LeftInd:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						TweenService:Create(v, ind_tweeninfo, {Brightness = b}):Play()
					elseif v.Name == "LN" then
						TweenService:Create(v, ind_tweeninfo, {Transparency = tp}):Play()
					end
				end
			else
				for i, v in pairs(lights.LeftInd:GetDescendants()) do
					if v:IsA("BasePart") or v:IsA("MeshPart") then
						if tp < 1 then
							if v.Name == "SI"..tostring(iseg) then
								TweenService:Create(v, ind_tweeninfo, {Transparency = tp}):Play()
							end
						else
							if string.sub(v.Name, 1, 2) == "SI" then
								TweenService:Create(v, ind_tweeninfo, {Transparency = tp}):Play()
							end
						end 
					end	
				end
			end
		elseif t == "LED" then
			if not seq then
				for i, v in pairs(lights.LeftInd:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						v.Brightness = b
					elseif v.Name == "LN" then
						v.Transparency = tp
					end
				end
			else
				for i, v in pairs(lights.LeftInd:GetDescendants()) do
					if v:IsA("BasePart") or v:IsA("MeshPart") then
						if tp < 1 then
							if v.Name == "SI"..tostring(iseg) then
								v.Transparency = tp	
							end
						else
							v.Transparency = tp
						end
					end	
				end
			end	
		end
	end	
end

F.SignalRight = function(b, tp, t, seq, iseg)
	if tp == 0.71 then
		if t == "Halogen" then
			for i, v in pairs(lights.RightInd:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					TweenService:Create(v, ind_tweeninfo, {Brightness = b}):Play()
				elseif v.Name == "LN" and v.Parent.Name == "Rear" then
					TweenService:Create(v, ind_tweeninfo, {Transparency = 1}):Play()
				elseif v.Name == "LN" and v.Parent.Name == "Front" then
					TweenService:Create(v, ind_tweeninfo, {Transparency = tp}):Play()
				end
			end
		elseif t == "LED" then
			for i, v in pairs(lights.RightInd:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					v.Brightness = b
				elseif v.Name == "LN" and v.Parent.Name == "Rear" then
					v.Transparency = 1
				elseif v.Name == "LN" and v.Parent.Name == "Front" then
					v.Transparency = tp
				end
			end
		end
	else
		if t == "Halogen" then
			if not seq then
				for i, v in pairs(lights.RightInd:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						TweenService:Create(v, ind_tweeninfo, {Brightness = b}):Play()
					elseif v.Name == "LN" then
						TweenService:Create(v, ind_tweeninfo, {Transparency = tp}):Play()
					end
				end
			else
				for i, v in pairs(lights.RightInd:GetDescendants()) do
					if v:IsA("BasePart") or v:IsA("MeshPart") then
						if tp < 1 then
							if v.Name == "SI"..tostring(iseg) then
								TweenService:Create(v, ind_tweeninfo, {Transparency = tp}):Play()
							end
						else
							if string.sub(v.Name, 1, 2) == "SI" then
								TweenService:Create(v, ind_tweeninfo, {Transparency = tp}):Play()
							end
						end	
					end			
				end
			end
		elseif t == "LED" then
			if not seq then
				for i, v in pairs(lights.RightInd:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						v.Brightness = b
					elseif v.Name == "LN" then
						v.Transparency = tp
					end
				end
			else
				for i, v in pairs(lights.RightInd:GetDescendants()) do
					if tp < 1 then
						if v.Name == "SI"..tostring(iseg) then
							v.Transparency = tp	
						end
					else
						v.Transparency = tp
					end	
				end
			end	
		end
	end	
end

F.Hazards = function(b, tp, t, seq, iseg)
	if tp == 0.71 then
		if t == "Halogen" then
			for i, v in pairs(lights.LeftInd:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					TweenService:Create(v, ind_tweeninfo, {Brightness = b}):Play()
				elseif v.Name == "LN" and v.Parent.Name == "Rear" then
					TweenService:Create(v, ind_tweeninfo, {Transparency = 1}):Play()
				elseif v.Name == "LN" and v.Parent.Name == "Front" then
					TweenService:Create(v, ind_tweeninfo, {Transparency = tp}):Play()
				end
			end
			for i, v in pairs(lights.RightInd:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					TweenService:Create(v, ind_tweeninfo, {Brightness = b}):Play()
				elseif v.Name == "LN" and v.Parent.Name == "Rear" then
					TweenService:Create(v, ind_tweeninfo, {Transparency = 1}):Play()
				elseif v.Name == "LN" and v.Parent.Name == "Front" then
					TweenService:Create(v, ind_tweeninfo, {Transparency = tp}):Play()
				end
			end
		elseif t == "LED" then
			for i, v in pairs(lights.LeftInd:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					v.Brightness = b
				elseif v.Name == "LN" and v.Parent.Name == "Rear" then
					v.Transparency = 1
				elseif v.Name == "LN" and v.Parent.Name == "Front" then
					v.Transparency = tp
				end
			end
			for i, v in pairs(lights.RightInd:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					v.Brightness = b
				elseif v.Name == "LN" and v.Parent.Name == "Rear" then
					v.Transparency = 1
				elseif v.Name == "LN" and v.Parent.Name == "Front" then
					v.Transparency = tp
				end
			end
		end
	else
		if t == "Halogen" then
			if not seq then
				for i, v in pairs(lights.LeftInd:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						TweenService:Create(v, ind_tweeninfo, {Brightness = b}):Play()
					elseif v.Name == "LN" then
						TweenService:Create(v, ind_tweeninfo, {Transparency = tp}):Play()
					end
				end
				for i, v in pairs(lights.RightInd:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						TweenService:Create(v, ind_tweeninfo, {Brightness = b}):Play()
					elseif v.Name == "LN" then
						TweenService:Create(v, ind_tweeninfo, {Transparency = tp}):Play()
					end
				end
			else
				for i, v in pairs(lights.LeftInd:GetDescendants()) do
					if v:IsA("BasePart") or v:IsA("MeshPart") then
						if tp < 1 then
							if v.Name == "SI"..tostring(iseg) then
								TweenService:Create(v, ind_tweeninfo, {Transparency = tp}):Play()
							end
						else
							if string.sub(v.Name, 1, 2) == "SI" then
								TweenService:Create(v, ind_tweeninfo, {Transparency = tp}):Play()
							end
						end	
					end	
				end
				for i, v in pairs(lights.RightInd:GetDescendants()) do
					if v:IsA("BasePart") or v:IsA("MeshPart") then
						if tp < 1 then
							if v.Name == "SI"..tostring(iseg) then
								TweenService:Create(v, ind_tweeninfo, {Transparency = tp}):Play()
							end
						else
							if string.sub(v.Name, 1, 2) == "SI" then
								TweenService:Create(v, ind_tweeninfo, {Transparency = tp}):Play()
							end
						end
					end	
				end
			end
		elseif t == "LED" then
			if not seq then
				for i, v in pairs(lights.LeftInd:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						v.Brightness = b
					elseif v.Name == "LN" then
						v.Transparency = tp
					end
				end
				for i, v in pairs(lights.RightInd:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						v.Brightness = b
					elseif v.Name == "LN" then
						v.Transparency = tp
					end
				end
			else
				for i, v in pairs(lights.LeftInd:GetDescendants()) do
					if v:IsA("BasePart") or v:IsA("MeshPart") then
						if tp < 1 then
							if v.Name == "SI"..tostring(iseg) then
								v.Transparency = tp	
							end
						else
							v.Transparency = tp
						end	
					end
				end	
				for i, v in pairs(lights.RightInd:GetDescendants()) do
					if v:IsA("BasePart") or v:IsA("MeshPart") then
						if tp < 1 then
							if v.Name == "SI"..tostring(iseg) then
								v.Transparency = tp	
							end
						else
							v.Transparency = tp
						end	
					end	
				end
			end	
		end
	end	
end

F.Headlights = function(b, tp, r, rl_a, pe, t, ls)
	if not pe then
		if t == "Halogen" then	
			if rl_a and ls == 0 then
				if rl_loc == 1 then
					for i, v in pairs(lights.LeftInd.Front:GetChildren()) do
						if v:IsA("MeshPart") and v.Name == "LN" then
							TweenService:Create(v, l_tweeninfo, {Transparency = 0.71}):Play()
						end
					end
					for i, v in pairs(lights.RightInd.Front:GetChildren()) do
						if v:IsA("MeshPart") and v.Name == "LN" then
							TweenService:Create(v, l_tweeninfo, {Transparency = 0.71}):Play()
						end
					end
					for i, v in pairs(lights.Headlights.Low:GetChildren()) do
						if v:IsA("MeshPart") and v.Name == "LN" then
							TweenService:Create(v, l_tweeninfo, {Transparency = 0.71}):Play()
						end
					end
					for i, v in pairs(lights.Headlights.High:GetChildren()) do
						if v:IsA("MeshPart") and v.Name == "LN" then
							TweenService:Create(v, l_tweeninfo, {Transparency = 1}):Play()
						end
					end
				elseif rl_loc == 2 then
					for i, v in pairs(lights.Headlights.Low:GetChildren()) do
						if v:IsA("MeshPart") and v.Name == "LN" then
							TweenService:Create(v, l_tweeninfo, {Transparency = 0.71}):Play()
						end
					end
					for i, v in pairs(lights.Headlights.High:GetChildren()) do
						if v:IsA("MeshPart") and v.Name == "LN" then
							TweenService:Create(v, l_tweeninfo, {Transparency = 1}):Play()
						end
					end
				end
				for i, v in pairs(lights.Headlights:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						TweenService:Create(v, l_tweeninfo, {Brightness = b}):Play()
						v.Range = r
					elseif v:IsA("MeshPart") and v.Name == "LN" then
						if v.Parent.Name == "High" then
							TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
						elseif v.Parent.Name == "Low" and rl_loc ~= 2 and rl_loc ~= 1 then
							TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
						end	
					end
				end
			elseif not rl_a and ls == 0 then
				if rl_loc == 1 then
					for i, v in pairs(lights.LeftInd.Front:GetChildren()) do
						if v:IsA("MeshPart") and v.Name == "LN" then
							TweenService:Create(v, l_tweeninfo, {Transparency = 1}):Play()
						end
					end
					for i, v in pairs(lights.RightInd.Front:GetChildren()) do
						if v:IsA("MeshPart") and v.Name == "LN" then
							TweenService:Create(v, l_tweeninfo, {Transparency = 1}):Play()
						end
					end
					for i, v in pairs(lights.Headlights.Low:GetChildren()) do
						if v:IsA("MeshPart") and v.Name == "LN" then
							TweenService:Create(v, l_tweeninfo, {Transparency = 1}):Play()
						end
					end
				elseif rl_loc == 2 then
					for i, v in pairs(lights.Headlights.Low:GetChildren()) do
						if v:IsA("MeshPart") and v.Name == "LN" then
							TweenService:Create(v, l_tweeninfo, {Transparency = 1}):Play()
						end
					end
				end
				for i, v in pairs(lights.Headlights:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						TweenService:Create(v, l_tweeninfo, {Brightness = b}):Play()
						v.Range = r
					elseif v:IsA("MeshPart") and v.Name == "LN" then
						if v.Parent.Name == "High" then
							TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
						elseif v.Parent.Name == "Low" and rl_loc ~= 2 and rl_loc ~= 1 then
							TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
						end	
					end
				end
			elseif ls == 1 then
				if rl_loc == 1 then
					for i, v in pairs(lights.LeftInd.Front:GetChildren()) do
						if v:IsA("MeshPart") and v.Name == "LN" then
							TweenService:Create(v, l_tweeninfo, {Transparency = 0.71}):Play()
						end
					end
					for i, v in pairs(lights.RightInd.Front:GetChildren()) do
						if v:IsA("MeshPart") and v.Name == "LN" then
							TweenService:Create(v, l_tweeninfo, {Transparency = 0.71}):Play()
						end
					end
				end
				for i, v in pairs(lights.Headlights.Low:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						TweenService:Create(v, l_tweeninfo, {Brightness = b}):Play()
						v.Range = r
					elseif v:IsA("MeshPart") and v.Name == "LN" then
						TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
					end
				end	
				for i, v in pairs(lights.Headlights.High:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						TweenService:Create(v, l_tweeninfo, {Transparency = 1}):Play()
					end
				end
			elseif ls == 2 then
				for i, v in pairs(lights.Headlights.Low:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						TweenService:Create(v, l_tweeninfo, {Brightness = b}):Play()
						v.Range = r
					elseif v:IsA("MeshPart") and v.Name == "LN" then
						TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
					end
				end	
				for i, v in pairs(lights.Headlights.High:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						TweenService:Create(v, l_tweeninfo, {Brightness = b}):Play()
						v.Range = r
					elseif v:IsA("MeshPart") and v.Name == "LN" then
						TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
					end
				end	
			end
		elseif t == "LED" then
			if rl_a and ls == 0 then
				if rl_loc == 1 then
					for i, v in pairs(lights.LeftInd.Front:GetChildren()) do
						if v:IsA("MeshPart") and v.Name == "LN" then
							v.Transparency = 0.71
						end
					end
					for i, v in pairs(lights.RightInd.Front:GetChildren()) do
						if v:IsA("MeshPart") and v.Name == "LN" then
							v.Transparency = 0.71
						end
					end
					for i, v in pairs(lights.Headlights.Low:GetChildren()) do
						if v:IsA("MeshPart") and v.Name == "LN" then
							v.Transparency = 0.71
						end
					end
					for i, v in pairs(lights.Headlights.High:GetChildren()) do
						if v:IsA("MeshPart") and v.Name == "LN" then
							v.Transparency = 1
						end
					end
				elseif rl_loc == 2 then
					for i, v in pairs(lights.Headlights.Low:GetChildren()) do
						if v:IsA("MeshPart") and v.Name == "LN" then
							v.Transparency = 0.71
						end
					end
					for i, v in pairs(lights.Headlights.High:GetChildren()) do
						if v:IsA("MeshPart") and v.Name == "LN" then
							v.Transparency = 1
						end
					end
				end
				for i, v in pairs(lights.Headlights:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						v.Brightness = b
						v.Range = r
					elseif v:IsA("MeshPart") and v.Name == "LN" then
						if v.Parent.Name == "High" then
							v.Transparency = tp
						elseif v.Parent.Name == "Low" and rl_loc ~= 2 and rl_loc ~= 1 then
							v.Transparency = tp
						end	
					end
				end
			elseif not rl_a and ls == 0 then
				if rl_loc == 1 then
					for i, v in pairs(lights.LeftInd.Front:GetChildren()) do
						if v:IsA("MeshPart") and v.Name == "LN" then
							v.Transparency = 1
						end
					end
					for i, v in pairs(lights.RightInd.Front:GetChildren()) do
						if v:IsA("MeshPart") and v.Name == "LN" then
							v.Transparency = 1
						end
					end
					for i, v in pairs(lights.Headlights.Low:GetChildren()) do
						if v:IsA("MeshPart") and v.Name == "LN" then
							v.Transparency = 1
						end
					end
				elseif rl_loc == 2 then
					for i, v in pairs(lights.Headlights.Low:GetChildren()) do
						if v:IsA("MeshPart") and v.Name == "LN" then
							v.Transparency = 1
						end
					end
				end
				for i, v in pairs(lights.Headlights:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						v.Brightness = b
						v.Range = r
					elseif v:IsA("MeshPart") and v.Name == "LN" then
						if v.Parent.Name == "High" then
							v.Transparency = tp
						elseif v.Parent.Name == "Low" and rl_loc ~= 2 and rl_loc ~= 1 then
							v.Transparency = tp
						end	
					end
				end
			elseif ls == 1 then
				if rl_loc == 1 then
					for i, v in pairs(lights.LeftInd.Front:GetChildren()) do
						if v:IsA("MeshPart") and v.Name == "LN" then
							v.Transparency = 0.71
						end
					end
					for i, v in pairs(lights.RightInd.Front:GetChildren()) do
						if v:IsA("MeshPart") and v.Name == "LN" then
							v.Transparency = 0.71
						end
					end
				end
				for i, v in pairs(lights.Headlights.Low:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						v.Brightness = b
						v.Range = r
					elseif v:IsA("MeshPart") and v.Name == "LN" then
						v.Transparency = tp
					end
				end	
				for i, v in pairs(lights.Headlights.High:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						v.Transparency = 1
					end
				end
			elseif ls == 2 then
				for i, v in pairs(lights.Headlights.Low:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						v.Brightness = b
						v.Range = r
					elseif v:IsA("MeshPart") and v.Name == "LN" then
						v.Transparency = tp
					end
				end	
				for i, v in pairs(lights.Headlights.High:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						v.Brightness = b
						v.Range = r
					elseif v:IsA("MeshPart") and v.Name == "LN" then
						v.Transparency = tp
					end
				end	
			end
		elseif not rl_a and ls == 0 then
			if rl_loc == 1 then
				for i, v in pairs(lights.LeftInd.Front:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						v.Transparency = 1
					end
				end
				for i, v in pairs(lights.RightInd.Front:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						v.Transparency = 1
					end
				end
				for i, v in pairs(lights.Headlights.Low:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						v.Transparency = 1
					end
				end
			elseif rl_loc == 2 then
				for i, v in pairs(lights.Headlights.Low:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						v.Transparency = 1
					end
				end
			end
			for i, v in pairs(lights.Headlights:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					v.Brightness = b
					v.Range = r
				elseif v:IsA("MeshPart") and v.Name == "LN" then
					if v.Parent.Name == "High" then
						v.Transparency = tp
					elseif v.Parent.Name == "Low" and rl_loc ~= 2 and rl_loc ~= 1 then
						v.Transparency = tp
					end	
				end
			end
			if ls == 1 then
				for i, v in pairs(lights.Headlights.Low:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						v.Brightness = b
						v.Range = r
					elseif v:IsA("MeshPart") and v.Name == "LN" then
						v.Transparency = tp
					end
				end
				for i, v in pairs(lights.Headlights.High:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						v.Brightness = 0
						v.Range = 0
					elseif v:IsA("MeshPart") and v.Name == "LN" then
						v.Transparency = 1
					end
				end
				
			end	
		end	
	else
		if rl_a and ls == 0 then
			if rl_loc == 1 then
				for i, v in pairs(lights.LeftInd.Front:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						TweenService:Create(v, l_tweeninfo, {Transparency = 0.71}):Play()
					end
				end
				for i, v in pairs(lights.RightInd.Front:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						TweenService:Create(v, l_tweeninfo, {Transparency = 0.71}):Play()
					end
				end
				for i, v in pairs(lights.Headlights.Low:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						TweenService:Create(v, l_tweeninfo, {Transparency = 0.71}):Play()
					end
				end
				for i, v in pairs(PHeadlights.Parts.Headlights:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						TweenService:Create(v, l_tweeninfo, {Transparency = 1}):Play()
					end
				end
			elseif rl_loc == 2 then
				for i, v in pairs(lights.Headlights.Low:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						TweenService:Create(v, l_tweeninfo, {Transparency = 0.71}):Play()
					end
				end
				for i, v in pairs(PHeadlights.Parts.Headlights:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						TweenService:Create(v, l_tweeninfo, {Transparency = 1}):Play()
					end
				end
			else
				for i, v in pairs(lights.Headlights.Running:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						TweenService:Create(v, l_tweeninfo, {Transparency = 0.71}):Play()
					end
				end
				for i, v in pairs(PHeadlights.Parts.Headlights:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						TweenService:Create(v, l_tweeninfo, {Transparency = 1}):Play()
					end
				end
			end
			for i, v in pairs(lights.Headlights:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					TweenService:Create(v, l_tweeninfo, {Brightness = b}):Play()
					v.Range = r
				elseif v:IsA("MeshPart") and v.Name == "LN" then
					if v.Parent.Name == "High" then
						TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
					elseif v.Parent.Name == "Low" and rl_loc ~= 2 and rl_loc ~= 1 then
						TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
					end	
				end
			end
			for i, v in pairs(PHeadlights.Parts.Headlights:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					TweenService:Create(v, l_tweeninfo, {Brightness = b}):Play()
					v.Range = r
				end
			end
		elseif not rl_a and ls == 0 then
			if rl_loc == 1 then
				for i, v in pairs(lights.LeftInd.Front:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						TweenService:Create(v, l_tweeninfo, {Transparency = 1}):Play()
					end
				end
				for i, v in pairs(lights.RightInd.Front:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						TweenService:Create(v, l_tweeninfo, {Transparency = 1}):Play()
					end
				end
				for i, v in pairs(lights.Headlights.Low:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						TweenService:Create(v, l_tweeninfo, {Transparency = 1}):Play()
					end
				end
				for i, v in pairs(PHeadlights.Parts.Headlights:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						TweenService:Create(v, l_tweeninfo, {Transparency = 1}):Play()
					end
				end
			elseif rl_loc == 2 then
				for i, v in pairs(lights.Headlights.Low:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						TweenService:Create(v, l_tweeninfo, {Transparency = 1}):Play()
					end
				end
				for i, v in pairs(PHeadlights.Parts.Headlights:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						TweenService:Create(v, l_tweeninfo, {Transparency = 1}):Play()
					end
				end
			else
				for i, v in pairs(lights.Headlights.Running:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						TweenService:Create(v, l_tweeninfo, {Transparency = 1}):Play()
					end
				end
				for i, v in pairs(PHeadlights.Parts.Headlights:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						TweenService:Create(v, l_tweeninfo, {Transparency = 1}):Play()
					end
				end
			end
			for i, v in pairs(lights.Headlights:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					TweenService:Create(v, l_tweeninfo, {Brightness = b}):Play()
					v.Range = r
				elseif v:IsA("MeshPart") and v.Name == "LN" then
					if v.Parent.Name == "High" then
						TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
					elseif v.Parent.Name == "Low" and rl_loc ~= 2 and rl_loc ~= 1 then
						TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
					end	
				end
			end
			for i, v in pairs(PHeadlights.Parts.Headlights:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					TweenService:Create(v, l_tweeninfo, {Brightness = b}):Play()
					v.Range = r
				end
			end
		elseif ls == 1 then
			if rl_loc == 1 then
				for i, v in pairs(lights.LeftInd.Front:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						TweenService:Create(v, l_tweeninfo, {Transparency = 0.71}):Play()
					end
				end
				for i, v in pairs(lights.RightInd.Front:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						TweenService:Create(v, l_tweeninfo, {Transparency = 0.71}):Play()
					end
				end
			elseif rl_loc == 3 then
				for i, v in pairs(lights.Headlights.Running:GetChildren()) do
					if v:IsA("MeshPart") and v.Name == "LN" then
						TweenService:Create(v, l_tweeninfo, {Transparency = 0.71}):Play()
					end
				end
			end
			for i, v in pairs(lights.Headlights.Low:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					TweenService:Create(v, l_tweeninfo, {Brightness = b}):Play()
					v.Range = r
				elseif v:IsA("MeshPart") and v.Name == "LN" then
					TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
				end
			end	
			for i, v in pairs(PHeadlights.Parts.Headlights:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					TweenService:Create(v, l_tweeninfo, {Brightness = b}):Play()
					v.Range = r
				elseif v:IsA("MeshPart") and v.Name == "LN" then
					TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
				end
			end
		elseif ls == 2 then
			for i, v in pairs(lights.Headlights.Low:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					TweenService:Create(v, l_tweeninfo, {Brightness = b}):Play()
					v.Range = r
				elseif v:IsA("MeshPart") and v.Name == "LN" then
					TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
				end
			end	
			for i, v in pairs(lights.Headlights.High:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					TweenService:Create(v, l_tweeninfo, {Brightness = b}):Play()
					v.Range = r
				elseif v:IsA("MeshPart") and v.Name == "LN" then
					TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
				end
			end	
			for i, v in pairs(PHeadlights.Parts.Headlights:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					TweenService:Create(v, l_tweeninfo, {Brightness = b}):Play()
					v.Range = r
				elseif v:IsA("MeshPart") and v.Name == "LN" then
					TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
				end
			end
		end
	end
end

F.CustomDRL = function(s, t)
	if t == "Halogen" then
		if s then
			for i, v in pairs(lights.Headlights.Running:GetDescendants()) do
				if v:IsA("MeshPart") and v.Name == "LN" then
					TweenService:Create(v, l_tweeninfo, {Transparency = 0.02}):Play()
				end
			end
		else
			for i, v in pairs(lights.Headlights.Running:GetDescendants()) do
				if v:IsA("MeshPart") and v.Name == "LN" then
					TweenService:Create(v, l_tweeninfo, {Transparency = 1}):Play()
				end
			end
		end
	else
		if s then
			for i, v in pairs(lights.Headlights.Running:GetDescendants()) do
				if v:IsA("MeshPart") and v.Name == "LN" then
					v.Transparency = 0.02
				end
			end
		else
			for i, v in pairs(lights.Headlights.Running:GetDescendants()) do
				if v:IsA("MeshPart") and v.Name == "LN" then
					v.Transparency = 1
				end
			end
		end
	end	
end

F.PlateLights = function(s, t)
	if s then
		if t == "Halogen" then
			for i, v in pairs(lights.Plate:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					TweenService:Create(v, l_tweeninfo, {Brightness = 1}):Play()
				elseif v.Name == "LN" then
					TweenService:Create(v, l_tweeninfo, {Transparency = 0}):Play()
				end
			end
		elseif t == "LED" then
			for i, v in pairs(lights.Plate:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					v.Brightness = 1
				elseif v.Name == "LN" then
					v.Transparency = 0
				end
			end
		end
	else
		if t == "Halogen" then
			for i, v in pairs(lights.Plate:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					TweenService:Create(v, l_tweeninfo, {Brightness = 0}):Play()
				elseif v.Name == "LN" then
					TweenService:Create(v, l_tweeninfo, {Transparency = 1}):Play()
				end
			end
		elseif t == "LED" then
			for i, v in pairs(lights.Plate:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					v.Brightness = 0
				elseif v.Name == "LN" then
					v.Transparency = 1
				end
			end
		end
	end
end

F.Popups = function(state, enabled, hinge_angle)
	if enabled then
		local motor = PHeadlights.Hinge:WaitForChild("Motor")
		motor.MaxVelocity = 0.06
		
		if state then
			motor.DesiredAngle = hinge_angle
		elseif not state then
			motor.DesiredAngle = 0
		end
	end
end

F.FogLights = function(b, tp, t)
	if t == "Halogen" then
		for i, v in pairs(lights.Fog:GetDescendants()) do
			if v:IsA("Light") and v.Name == "L" then
				TweenService:Create(v, ind_tweeninfo, {Brightness = b}):Play()
			elseif v.Name == "LN" then
				TweenService:Create(v, ind_tweeninfo, {Transparency = tp}):Play()
			end
		end
	elseif t == "LED" then
		for i, v in pairs(lights.Fog:GetDescendants()) do
			if v:IsA("Light") and v.Name == "L" then
				v.Brightness = b
			elseif v.Name == "LN" then
				v.Transparency = tp
			end
		end
	end
end

F.BrakeLights = function(t, b, tp, te)
	if not te then
		if t == "Halogen" then
			for i, v in pairs(lights.Brake:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					TweenService:Create(v, l_tweeninfo, {Brightness = b}):Play()
				elseif v.Name == "LN" then
					TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
				end
			end
		elseif t == "LED" then
			for i, v in pairs(lights.Brake:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					v.Brightness = b
				elseif v.Name == "LN" then
					v.Transparency = tp
				end
			end
		end
	else
		if t == "Halogen" then
			for i, v in pairs(lights.Brake:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					TweenService:Create(v, l_tweeninfo, {Brightness = b}):Play()
				elseif v.Name == "LN" then
					TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
				end
			end
			for i, v in pairs(trunk.Brake:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					TweenService:Create(v, l_tweeninfo, {Brightness = b}):Play()
				elseif v.Name == "LN" then
					TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
				end
			end
		elseif t == "LED" then
			for i, v in pairs(lights.Brake:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					v.Brightness = b
				elseif v.Name == "LN" then
					v.Transparency = tp
				end
			end
			for i, v in pairs(trunk.Brake:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					v.Brightness = b
				elseif v.Name == "LN" then
					v.Transparency = tp
				end
			end
		end
	end	
end

F.RearLights = function(t, b, tp, te)
	if not te then
		if t == "Halogen" then
			for i, v in pairs(lights.Rear:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					TweenService:Create(v, l_tweeninfo, {Brightness = b}):Play()
				elseif v.Name == "LN" then
					TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
				end
			end
		elseif t == "LED" then
			for i, v in pairs(lights.Rear:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					v.Brightness = b
				elseif v.Name == "LN" then
					v.Transparency = tp
				end
			end
		end
	else
		if t == "Halogen" then
			for i, v in pairs(lights.Rear:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					TweenService:Create(v, l_tweeninfo, {Brightness = b}):Play()
				elseif v.Name == "LN" then
					TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
				end
			end
			for i, v in pairs(trunk.Rear:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					TweenService:Create(v, l_tweeninfo, {Brightness = b}):Play()
				elseif v.Name == "LN" then
					TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
				end
			end
		elseif t == "LED" then
			for i, v in pairs(lights.Rear:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					v.Brightness = b
				elseif v.Name == "LN" then
					v.Transparency = tp
				end
			end
			for i, v in pairs(trunk.Rear:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					v.Brightness = b
				elseif v.Name == "LN" then
					v.Transparency = tp
				end
			end
		end
	end	
end	

F.DashboardIndicators = function(headlights, indicators, parklights)
	
end

F.Reverse = function(t, b, tp, te)
	if not te then
		if t == "Halogen" then
			for i, v in pairs(lights.Reverse:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					TweenService:Create(v, l_tweeninfo, {Brightness = b}):Play()
				elseif v.Name == "LN" then
					TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
				end
			end
		elseif t == "LED" then
			for i, v in pairs(lights.Reverse:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					v.Brightness = b
				elseif v.Name == "LN" then
					v.Transparency = tp
				end
			end
		end
	else
		if t == "Halogen" then
			for i, v in pairs(lights.Reverse:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					TweenService:Create(v, l_tweeninfo, {Brightness = b}):Play()
				elseif v.Name == "LN" then
					TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
				end
			end
			for i, v in pairs(trunk.Reverse:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					TweenService:Create(v, l_tweeninfo, {Brightness = b}):Play()
				elseif v.Name == "LN" then
					TweenService:Create(v, l_tweeninfo, {Transparency = tp}):Play()
				end
			end
		elseif t == "LED" then
			for i, v in pairs(lights.Reverse:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					v.Brightness = b
				elseif v.Name == "LN" then
					v.Transparency = tp
				end
			end
			for i, v in pairs(trunk.Reverse:GetDescendants()) do
				if v:IsA("Light") and v.Name == "L" then
					v.Brightness = b
				elseif v.Name == "LN" then
					v.Transparency = tp
				end
			end
		end
	end	
end

function intLights()
	if intlights then
		local center_override = false
		local front_override = false
		local door_open = false
		local int_triggers = car.Body:FindFirstChild("InteriorTriggers")
		local event1 = int_triggers:FindFirstChild("OverrideTriggers")
		if #doors > 0 and doorFunction then
			for i, v in pairs(doors) do
				local event2 = v:FindFirstChild("EpicLightsDoor")
				event2.Event:Connect(function(s)
					door_open = s
					if s then
						for i, v in pairs(lights.Interior:GetDescendants()) do
							if v.Name == "L" and v:IsA("SpotLight") and not front_override then
								TweenService:Create(v, l_tweeninfo, {Brightness = 0.5, Range = 9}):Play()
							elseif v.Name == "L" and v:IsA("PointLight") and not center_override then
								TweenService:Create(v, l_tweeninfo, {Brightness = 0.5, Range = 9}):Play()
							elseif v.Name == "FLN" and not front_override then
								TweenService:Create(v, l_tweeninfo, {Transparency = 0.2}):Play()
							elseif v.Name == "CLN" and not center_override then
								TweenService:Create(v, l_tweeninfo, {Transparency = 0.2}):Play()
							end
						end
					else
						for i, v in pairs(lights.Interior:GetDescendants()) do
							if v.Name == "L" and v:IsA("SpotLight") and not front_override then
								TweenService:Create(v, l_tweeninfo, {Brightness = 0, Range = 0}):Play()
							elseif v.Name == "L" and v:IsA("PointLight") and not center_override then
								TweenService:Create(v, l_tweeninfo, {Brightness = 0, Range = 0}):Play()
							elseif v.Name == "FLN" and not front_override then
								TweenService:Create(v, l_tweeninfo, {Transparency = 1}):Play()
							elseif v.Name == "CLN" and not center_override then
								TweenService:Create(v, l_tweeninfo, {Transparency = 1}):Play()
							end
						end
					end
				end)
			end
		end	
		event1.Event:Connect(function(s, t)
			if t == "Center" then
				center_override = s
				if not door_open then
					if s then
						for i, v in pairs(lights.Interior:GetDescendants()) do
							if v.Parent.Name == "CenterL" and v:IsA("PointLight") then
								TweenService:Create(v, l_tweeninfo, {Brightness = 0.5, Range = 9}):Play()
							elseif v.Name == "CLN" then
								TweenService:Create(v, l_tweeninfo, {Transparency = 0.2}):Play()
							end
						end
					else
						for i, v in pairs(lights.Interior:GetDescendants()) do
							if v.Parent.Name == "CenterL" and v:IsA("PointLight") then
								TweenService:Create(v, l_tweeninfo, {Brightness = 0, Range = 0}):Play()
							elseif v.Name == "CLN" then
								TweenService:Create(v, l_tweeninfo, {Transparency = 1}):Play()
							end
						end
					end
				end	
			elseif t == "Front" then
				front_override = s
				if not door_open then
					if s then
						for i, v in pairs(lights.Interior:GetDescendants()) do
							if v.Parent.Name == "FrontL" and v:IsA("SpotLight") then
								TweenService:Create(v, l_tweeninfo, {Brightness = 0.5, Range = 9}):Play()
							elseif v.Name == "FLN" then
								TweenService:Create(v, l_tweeninfo, {Transparency = 0.2}):Play()
							end
						end
					else
						for i, v in pairs(lights.Interior:GetDescendants()) do
							if v.Parent.Name == "FrontL" and v:IsA("SpotLight") then
								TweenService:Create(v, l_tweeninfo, {Brightness = 0, Range = 0}):Play()
							elseif v.Name == "FLN" then
								TweenService:Create(v, l_tweeninfo, {Transparency = 1}):Play()
							end
						end
					end
				end	
			end
		end)	
	end	
end	
	
F.IndsOnLeave = function(left, right, hazard, sequential, segs, fr, type)
	event.IndicatorsAfterLeave.Disabled = false
	wait()
	leaveseatevent:Fire(left, right, hazard, sequential, segs, fr, type)
end

event.OnServerEvent:Connect(function(pl, Fnc, ...)
	F[Fnc](...)
end) -- 1627 lines previously