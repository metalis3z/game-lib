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
-- CQMdBnNjcmlwdAZQYXJlbnQISHVtYW5vaWQVRmluZEZpcnN0Q2hpbGRPZkNsYXNzE0FuaW1hdGlvbkNvbnRyb2xsZXIEd2FybjtbQW5pbWF0aW9uU2NyaXB0XSBObyBIdW1hbm9pZCBvciBBbmltYXRpb25Db250cm9sbGVyIGZvdW5kIQhBbmltYXRvcghJbnN0YW5jZQNuZXcETmFtZQlBbmltYXRpb24GU2NyaXB0CkFuaW1hdGlvbnMORmluZEZpcnN0Q2hpbGQESWRsZQ9BbmltYXRpb25zLklkbGULR2V0Q2hpbGRyZW4DSXNBC0FuaW1hdGlvbnMuRFtBbmltYXRpb25TY3JpcHRdIE5vIEFuaW1hdGlvbiBmb3VuZCBpbiBzY3JpcHQgb3IgQW5pbWF0aW9ucyBmb2xkZXIhGUdldFBsYXlpbmdBbmltYXRpb25UcmFja3MEU3RvcA1Mb2FkQW5pbWF0aW9uBkxvb3BlZARQbGF5BXByaW50MVtBbmltYXRpb25TY3JpcHRdIFBsYXlpbmcgYW5pbWF0aW9uICclKicgZnJvbTogJSoGZm9ybWF0AAEOAAABAABvowAAAKQAAQAAAABATQAAJAIAAAArAAEAggABAG8DAwC8AQC4BAAAAJ8BAwIrAQQAbwMFALwBALgEAAAAnwEDAisBBQCkAgcAAABgQG8DCACfAgIBggABAG8ECQC8AgG4BAAAAJ8CAwIrAgoApAMMAAAsoIBvBAkAnwMCAlICAwBvAwkAMAMCug0AAAAwAQIkAgAAAKQDAQAAAABAbwUOALwDA7gEAAAAnwMDAm8EDwArAx4AbwcQALwFAAMRAAAAnwUDAg4FGQBvCBIAvAYFAxEAAACfBgMCUgMGAA4DAgBvBBMAZQARALwGBWgUAAAAnwYCBGQGCwBvDQ4AvAsK/hUAAACfCwMCDgsGAFIDCgBvCxYATQwKug0AAABzBAsMZQACAG4G9P8CAAAAKwMFAKQFBwAAAGBAbwYXAJ8FAgGCAAEAvAUCzRgAAACfBQIEZAUDALwKCfoZAAAAnwoCAW4F/P8CAAAAUgcDALwFApQaAAAAnwUDAqkGAQAwBgW1GwAAALwGBe4cAAAAnwYCAaQGHgAAANBBbwcfAE0JA7oNAAAAUgoEALwHB40gAAAAnwcEAp8GAgGCAAEAIQMBBAAAAEADAgMDAwQDBQMGBAAAYEADBwMIAwkDCgQALKCAAwsDDAMNAw4DDwMQAxEDEgMTAxQDFQMWAxcDGAMZAxoDGwQAANBBAxwDHQABAAEYAAMAAAABAAMAAAAAAAAAAAEBAAAAAQQAAAABAQAAAAABAAABAAQAAAAAAAEDAQAAAAEBAAAAAAEBAAMAAAABAAAAAAEBAAAAAfwADAEAAAABBAAAAAEAAP8ABQAAAAEAAAEAAAIAAAAAAAAAAAABAQAAAAAADi6HIPir2/Oo97PZUkVeJ342kFQ86u0h

-- https://lua.expert/
local v1 = script.Parent

if not v1 then
	return
end

local v2 = v1:FindFirstChildOfClass("Humanoid") or v1:FindFirstChildOfClass("AnimationController")

if not v2 then
	warn("[AnimationScript] No Humanoid or AnimationController found!")

	return
end

local Animator = v2:FindFirstChildOfClass("Animator")

if not Animator then
	local Animator2 = Instance.new("Animator")

	Animator2.Name = "Animator"
	Animator2.Parent = v2
	Animator = Animator2
end

local Animation = script:FindFirstChildOfClass("Animation")
local v3 = "Script"

if not Animation then
	local Animations = v1:FindFirstChild("Animations")

	if Animations then
		local Idle = Animations:FindFirstChild("Idle")

		if Idle then
			Animation = Idle
			v3 = "Animations.Idle"
		else
			Animation = Idle

			for v4, v5 in Animations:GetChildren() do
				if v5:IsA("Animation") then
					v3 = "Animations." .. v5.Name
					Animation = v5

					break
				end
			end
		end
	end
end

if not Animation then
	warn("[AnimationScript] No Animation found in script or Animations folder!")

	return
end

for v6, v7 in Animator:GetPlayingAnimationTracks() do
	v7:Stop()
end

local v8 = Animator:LoadAnimation(Animation)

v8.Looped = true
v8:Play()
print((("[AnimationScript] Playing animation \'%*\' from: %*"):format(Animation.Name, v3)))