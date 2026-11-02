local module = {}

-- Created and Fixed by BUILDG Studios

function module:LoadRooms()
	local roomsfolder = game.ServerScriptService.Server.Rooms:GetChildren()
	
	local random = Random.new()
	local letters = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'}

	local function getRandomLetter()
		return letters[random:NextInteger(1,#letters)]
	end

	local function getRandomString(length, includeCapitals)
		local length = length or 10
		local str = ''
		for i=1,length do
			local randomLetter = getRandomLetter()
			if includeCapitals and random:NextNumber() > .5 then
				randomLetter = string.upper(randomLetter)
			end
			str = str .. randomLetter
		end
		return str
	end
	
	for v7, v8 in pairs(roomsfolder) do
		--print(v8.Name)
		
		for v9, v10 in pairs(v8:GetChildren()) do
			--print(v10.Name)
			
			if v10:IsA("Model") and string.find(v10.Name, "Hotel_") then
				if v10:GetAttribute("OriginalName") then

				else
					for v34, v35 in pairs(v10:GetDescendants()) do
						if v35:IsA("Light") then
							v35:SetAttribute("ToTurnOn", true)
						end;
					end;
					
					local part = Instance.new("Part")

                    part.Material = Enum.Material.Plastic
					part.Name = "CollideRoom"

					local orientation, size = v10:GetBoundingBox()
					part.Size = size
					part.CFrame = orientation

					part.Parent = v10
					
					--require(game.ServerScriptService.Game.Directory.EntryRoomNodes).Path(v10)

					part.Anchored = true
					part.CanCollide = false
					part.Transparency = 1

					v10:SetAttribute("OriginalName", v10.Name)
					task.wait()
					v10.Name = getRandomString(6, true).."_RandomRoom"
					
					if not v10:GetAttribute("Difficulty") then
						v10:SetAttribute("Difficulty", 1)
					end
				end
			end
		end
	end
end

function module:RoomsStatusGetReady()
	local roomsfolder = game.ServerScriptService.Server.Rooms:GetChildren()
	
	for v7, v8 in pairs(roomsfolder) do
		print(v8.Name)

		for v9, v10 in pairs(v8:GetChildren()) do
			print(v10.Name)

			if v10:IsA("Model") and string.find(v10.Name, "Hotel_") then
				for v34, v35 in pairs(v10:GetDescendants()) do
					if v35.Name == "RoomStart" then
						
					end
				end
			end
		end
	end
end

return module
