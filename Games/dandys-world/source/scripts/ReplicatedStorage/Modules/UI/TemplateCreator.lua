--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- CQMpCFRlbXBsYXRlDkZpbmRGaXJzdENoaWxkDFRvb25UZW1wbGF0ZQdWaXNpYmxlCEluc3RhbmNlA25ldwpUZXh0QnV0dG9uBE5hbWUFVURpbTIEU2l6ZQZDb2xvcjMQQmFja2dyb3VuZENvbG9yMxZCYWNrZ3JvdW5kVHJhbnNwYXJlbmN5D0JvcmRlclNpemVQaXhlbAAEVGV4dAZQYXJlbnQJVGV4dExhYmVsDUNoYXJhY3Rlck5hbWUIUG9zaXRpb24KVGV4dENvbG9yMwpUZXh0U2NhbGVkBEVudW0ERm9udApTb3VyY2VTYW5zCkltYWdlTGFiZWwOQ2hhcmFjdGVySW1hZ2UJU2NhbGVUeXBlA0ZpdBJjcmVhdGVUb29uVGVtcGxhdGUMVGVhbVRlbXBsYXRlASAKUGxheWVyTmFtZQ5UZXh0WEFsaWdubWVudARMZWZ0EmNyZWF0ZVRlYW1UZW1wbGF0ZQ9Ucmlua2V0VGVtcGxhdGUHZnJvbVJHQgxCb3JkZXJDb2xvcjMJQ2hlY2ttYXJrFWNyZWF0ZVRyaW5rZXRUZW1wbGF0ZQAECQEAAAAAhQFvAwAAvAEAAwEAAACfAQMCKwEEAG8DAgC8AQADAQAAAJ8BAwIOAQQAqQIAADACAYADAAAAggECAKQCBgAAFECAbwMHAJ8CAgJSAQIAbwIAADACAboIAAAApAIKAAAUkIBvAwsAjAQAAG8FDACMBgAAnwIFAjACAS8NAAAApAIPAAAU4ICMAwEAjAQBAIwFAQCfAgQCMAIBnxAAAACMAgEAMAIBOhEAAACMAgAAMAIBjhIAAACpAgAAMAIBgAMAAABvAhMAMAIB9RQAAAAwAAEkFQAAAKQCBgAAFECAbwMWAJ8CAgJvAxcAMAMCuggAAACkAwoAABSQgIwEAQCMBQAAbwYYAIwHAACfAwUCMAMCLw0AAACkAwoAABSQgIwEAACMBQAAbwYZAIwHAACfAwUCMAMCOxoAAACMAwEAMAMCOhEAAACkAw8AABTggIwEAQCMBQEAjAYBAJ8DBAIwAwJzGwAAAKkDAQAwAwLeHAAAAKQDIAAfeNDBMAMCOR4AAAAwAQIkFQAAAKQDBgAAFECAbwQhAJ8DAgJvBCIAMAQDuggAAACkBAoAABSQgG8FIwCMBgAAbwckAIwIAACfBAUCMAQDLw0AAACkBAoAABSQgG8FJQCMBgAAbwclAIwIAACfBAUCMAQDOxoAAACMBAEAMAQDOhEAAACkBCgAJ5jQwTAEA9EmAAAAMAEDJBUAAACCAQIAKQMBAwIDAwMEAwUDBgQAFECAAwcDCAMJBAAUkIAC8TH6/6g1xj8C4Cjcn0nqwz8DCgMLBAAU4IADDAMNAw4DDwMQAxEDEgMTAjMzMzMzM9M/AmZmZmZmZuY/AxQDFQMWAxcDGAMZBB940MEDGgMbApqZmZmZmek/AjMzMzMzM+M/ApqZmZmZmbk/AxwDHQQnmNDBAAMeARgAAAAAAAAAAAABAgAAAAIAAAAAAQAAAQAAAAAAAAAAAQAAAAAAAAABAAABAAABAAABAAABAAMAAAABAAABAAAAAAAAAAABAAAAAAAAAAABAAABAAAAAAAAAAEAAAEAAAABAAMAAAABAAABAAAAAAAAAAABAAAAAAAAAAABAAABAAAAAQACBAAAAAAKAQAAAACzAW8DAAC8AQADAQAAAJ8BAwIrAQQAbwMCALwBAAMBAAAAnwEDAg4BBACpAgAAMAIBgAMAAACCAQIApAIGAAAUQIBvAwcAnwICAlIBAgBvAgAAMAIBuggAAACkAgoAABSQgIwDAQCMBAAAbwULAIwGAACfAgUCMAIBLwwAAABvAg0AMAIB9Q4AAACkAhIAEUDwwDACATkQAAAAjAIBADACAToTAAAAqQIAADACAYADAAAAMAABJBQAAACkAgYAABRAgG8DFQCfAgICbwMWADADAroIAAAApAMKAAAUkIBvBBcAjAUAAIwGAQCMBwAAnwMFAjADAi8MAAAApAMKAAAUkICMBAAAjAUAAIwGAACMBwAAnwMFAjADAjsYAAAAjAMBADADAjoTAAAApAMaAAAUkIGMBAEAjAUBAIwGAQCfAwQCMAMCcxsAAACpAwEAMAMC3hwAAACkAxIAEUDwwDADAjkQAAAApAMfAB508MAwAwJ7HQAAADABAiQUAAAApAMGAAAUQIBvBBUAnwMCAm8EIAAwBAO6CAAAAKQECgAAFJCAbwUXAIwGAACMBwEAjAgAAJ8EBQIwBAMvDAAAAKQECgAAFJCAbwUXAIwGAACMBwAAjAgAAJ8EBQIwBAM7GAAAAIwEAQAwBAM6EwAAAKQEGgAAFJCBjAUBAIwGAQCMBwEAnwQEAjAEA3MbAAAAqQQBADAEA94cAAAApAQSABFA8MAwBAM5EAAAAKQEHwAedPDAMAQDex0AAAAwAQMkFAAAAKQEBgAAFECAbwUhAJ8EAgJvBSIAMAUEuggAAACkBQoAABSQgG8GIwCMBwAAbwgkAIwJAACfBQUCMAUELwwAAACkBQoAABSQgG8GJACMBwAAbwglAIwJAACfBQUCMAUEOxgAAACMBQEAMAUEOhMAAACkBSgAJ5jwwDAFBNEmAAAAMAEEJBQAAACCAQIAKQMBAwIDHwMEAwUDBgQAFECAAwcDCAMJBAAUkIACAAAAAAAAwD8DCgMgAxADFwMYAxkEEUDwwAMNAxEDEgMhAgAAAAAAAOA/AxQDCwQAFJCBAxUDFgMiAyMEHnTwwAMTAxoDGwKamZmZmZnJPwKamZmZmZnpPwKamZmZmZm5PwMcAx0EJ5jwwAAqJAEYAAAAAAAAAAAAAQIAAAACAAAAAAEAAAEAAAAAAAAAAAEAAAEAAAABAAABAAABAAMAAAABAAABAAAAAAAAAAABAAAAAAAAAAABAAABAAAAAAAAAAEAAAEAAAABAAAAAQADAAAAAQAAAQAAAAAAAAAAAQAAAAAAAAAAAQAAAQAAAAAAAAABAAABAAAAAQAAAAEAAwAAAAEAAAEAAAAAAAAAAAEAAAAAAAAAAAEAAAEAAAABAAIrAAAAAAoBAAAAAK4BbwMAALwBAAMBAAAAnwEDAisBBABvAwIAvAEAAwEAAACfAQMCDgEEAKkCAAAwAgGAAwAAAIIBAgCkAgYAABRAgG8DBwCfAgICUgECAG8CAAAwAgG6CAAAAKQCCgAAFJCAbwMLAIwEAABvBQwAjAYAAJ8CBQIwAgEvDQAAAKQCEAAAPOCAjAM8AIwEPACMBTwAnwIEAjACAZ8RAAAAjAIBADACAToSAAAAjAICADACAY4TAAAApAIQAAA84ICMA2QAjARkAIwFZACfAgQCMAIBNBQAAACpAgAAMAIBgAMAAABvAhUAMAIB9RYAAAAwAAEkFwAAAKQCBgAAFECAbwMYAJ8CAgJvAxkAMAMCuggAAACkAwoAABSQgIwEAQCMBQAAbwYaAIwHAACfAwUCMAMCLw0AAACkAwoAABSQgIwEAACMBQAAbwYbAIwHAACfAwUCMAMCOxwAAACMAwEAMAMCOhIAAACkAx0AABTggIwEAQCMBQEAjAYBAJ8DBAIwAwJzHgAAAKkDAQAwAwLeHwAAAKQDIwAihADCMAMCOSEAAAAwAQIkFwAAAKQDBgAAFECAbwQkAJ8DAgJvBCUAMAQDuggAAACkBAoAABSQgG8FJgCMBgAAbwcnAIwIAACfBAUCMAQDLw0AAACkBAoAABSQgG8FKACMBgAAbwcoAIwIAACfBAUCMAQDOxwAAACMBAEAMAQDOhIAAACkBCsAKqQAwjAEA9EpAAAAMAEDJBcAAACkBAYAABRAgG8FJACfBAICbwUsADAFBLoIAAAApAUKAAAUkIBvBhoAjAcAAG8IGgCMCQAAnwUFAjAFBC8NAAAApAUKAAAUkIBvBhsAjAcAAIwIAACMCQAAnwUFAjAFBDscAAAAjAUBADAFBDoSAAAAqQUAADAFBIADAAAAMAEEJBcAAACCAQIALQMBAwIDJQMEAwUDBgQAFECAAwcDCAMJBAAUkIACKVyPwvUozD8CMzMzMzMzwz8DCgMLAyYEADzggAMMAw0DDgMnAw8DEAMRAxIDEwIzMzMzMzPTPwJmZmZmZmbmPwMUBAAU4IADFQMWAxcDGAMZBCKEAMIDGgMbApqZmZmZmek/AjMzMzMzM+M/ApqZmZmZmbk/AxwDHQQqpADCAygAXSkBGAAAAAAAAAAAAAECAAAAAgAAAAABAAABAAAAAAAAAAABAAAAAAAAAAEAAAEAAAEAAAAAAAAAAQAAAQAAAQADAAAAAQAAAQAAAAAAAAAAAQAAAAAAAAAAAQAAAQAAAAAAAAABAAABAAAAAQADAAAAAQAAAQAAAAAAAAAAAQAAAAAAAAAAAQAAAQAAAAEAAwAAAAEAAAEAAAAAAAAAAAEAAAAAAAAAAAEAAAEAAAEAAl4AAAAAAgAAAQIADaMAAAD/AAMAAAAAAMABAAAwAQDDAQAAAMABAgAwAQBIAwAAAMABBAAwAQBtBQAAAIIAAgAGBgADHgYBAyQGAgMpAwABAgEAARgAAAACAAAnAAAzAAAxAQAAAAADXI+bs3XeEl/HiQ2eyggKdyyXjMduS/Gy

-- https://lua.expert/
return {
	createToonTemplate = function(p1) --[[ createToonTemplate | Line: 3 ]]
		local v1 = p1:FindFirstChild("Template") or p1:FindFirstChild("ToonTemplate")

		if v1 then
			v1.Visible = false

			return v1
		end

		local Template = Instance.new("TextButton")

		Template.Name = "Template"
		Template.Size = UDim2.new(0.173512578, 0, 0.15558739, 0)
		Template.BackgroundColor3 = Color3.new(255/255, 255/255, 255/255)
		Template.BackgroundTransparency = 1
		Template.BorderSizePixel = 0
		Template.Visible = false
		Template.Text = ""
		Template.Parent = p1

		local CharacterName = Instance.new("TextLabel")

		CharacterName.Name = "CharacterName"
		CharacterName.Size = UDim2.new(1, 0, 0.3, 0)
		CharacterName.Position = UDim2.new(0, 0, 0.7, 0)
		CharacterName.BackgroundTransparency = 1
		CharacterName.TextColor3 = Color3.new(255/255, 255/255, 255/255)
		CharacterName.TextScaled = true
		CharacterName.Font = Enum.Font.SourceSans
		CharacterName.Parent = Template

		local CharacterImage = Instance.new("ImageLabel")

		CharacterImage.Name = "CharacterImage"
		CharacterImage.Size = UDim2.new(0.8, 0, 0.6, 0)
		CharacterImage.Position = UDim2.new(0.1, 0, 0.1, 0)
		CharacterImage.BackgroundTransparency = 1
		CharacterImage.ScaleType = Enum.ScaleType.Fit
		CharacterImage.Parent = Template

		return Template
	end,
	createTeamTemplate = function(p1) --[[ createTeamTemplate | Line: 42 ]]
		local v1 = p1:FindFirstChild("Template") or p1:FindFirstChild("TeamTemplate")

		if v1 then
			v1.Visible = false

			return v1
		end

		local Template = Instance.new("TextButton")

		Template.Name = "Template"
		Template.Size = UDim2.new(1, 0, 0.125, 0)
		Template.Text = " "
		Template.Font = Enum.Font.SourceSans
		Template.BackgroundTransparency = 1
		Template.Visible = false
		Template.Parent = p1

		local PlayerName = Instance.new("TextLabel")

		PlayerName.Name = "PlayerName"
		PlayerName.Size = UDim2.new(0.5, 0, 1, 0)
		PlayerName.Position = UDim2.new(0, 0, 0, 0)
		PlayerName.BackgroundTransparency = 1
		PlayerName.TextColor3 = Color3.new(255/255, 255/255, 255/255)
		PlayerName.TextScaled = true
		PlayerName.Font = Enum.Font.SourceSans
		PlayerName.TextXAlignment = Enum.TextXAlignment.Left
		PlayerName.Parent = Template

		local CharacterName = Instance.new("TextLabel")

		CharacterName.Name = "CharacterName"
		CharacterName.Size = UDim2.new(0.5, 0, 1, 0)
		CharacterName.Position = UDim2.new(0.5, 0, 0, 0)
		CharacterName.BackgroundTransparency = 1
		CharacterName.TextColor3 = Color3.new(255/255, 255/255, 255/255)
		CharacterName.TextScaled = true
		CharacterName.Font = Enum.Font.SourceSans
		CharacterName.TextXAlignment = Enum.TextXAlignment.Left
		CharacterName.Parent = Template

		local CharacterImage = Instance.new("ImageLabel")

		CharacterImage.Name = "CharacterImage"
		CharacterImage.Size = UDim2.new(0.2, 0, 0.8, 0)
		CharacterImage.Position = UDim2.new(0.8, 0, 0.1, 0)
		CharacterImage.BackgroundTransparency = 1
		CharacterImage.ScaleType = Enum.ScaleType.Fit
		CharacterImage.Parent = Template

		return Template
	end,
	createTrinketTemplate = function(p1) --[[ createTrinketTemplate | Line: 93 ]]
		local v1 = p1:FindFirstChild("Template") or p1:FindFirstChild("TrinketTemplate")

		if v1 then
			v1.Visible = false

			return v1
		end

		local Template = Instance.new("TextButton")

		Template.Name = "Template"
		Template.Size = UDim2.new(0.22, 0, 0.15, 0)
		Template.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		Template.BackgroundTransparency = 1
		Template.BorderSizePixel = 2
		Template.BorderColor3 = Color3.fromRGB(100, 100, 100)
		Template.Visible = false
		Template.Text = ""
		Template.Parent = p1

		local CharacterName = Instance.new("TextLabel")

		CharacterName.Name = "CharacterName"
		CharacterName.Size = UDim2.new(1, 0, 0.3, 0)
		CharacterName.Position = UDim2.new(0, 0, 0.7, 0)
		CharacterName.BackgroundTransparency = 1
		CharacterName.TextColor3 = Color3.new(255/255, 255/255, 255/255)
		CharacterName.TextScaled = true
		CharacterName.Font = Enum.Font.SourceSans
		CharacterName.Parent = Template

		local CharacterImage = Instance.new("ImageLabel")

		CharacterImage.Name = "CharacterImage"
		CharacterImage.Size = UDim2.new(0.8, 0, 0.6, 0)
		CharacterImage.Position = UDim2.new(0.1, 0, 0.1, 0)
		CharacterImage.BackgroundTransparency = 1
		CharacterImage.ScaleType = Enum.ScaleType.Fit
		CharacterImage.Parent = Template

		local Checkmark = Instance.new("ImageLabel")

		Checkmark.Name = "Checkmark"
		Checkmark.Size = UDim2.new(0.3, 0, 0.3, 0)
		Checkmark.Position = UDim2.new(0.7, 0, 0, 0)
		Checkmark.BackgroundTransparency = 1
		Checkmark.Visible = false
		Checkmark.Parent = Template

		return Template
	end
}