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
-- CQNIDHNldG1ldGF0YWJsZQdoZWxwZXJzBnR3ZWVucw5Mb2FkU3R5bGVzaGVldARJbml0BUNsb25lBlBhcmVudAVwYWlycwtoYXNQcm9wZXJ0eQRQbGF5ClRpbWVMZW5ndGgHQWRkSXRlbQlwbGF5U291bmQJcGxheVR3ZWVuC0xlZnRBcnJvd0JnCVR3ZWVuSW5mbwNuZXcERW51bQtFYXNpbmdTdHlsZQRTaW5lD0Vhc2luZ0RpcmVjdGlvbgVJbk91dAtBbmNob3JQb2ludAdWZWN0b3IyDFJpZ2h0QXJyb3dCZwR3YWl0BkNhbmNlbAV0YWJsZQZyZW1vdmULR2V0Q2hpbGRyZW4FRnJhbWUDSXNBA0tleQdVSVNjYWxlBVNjYWxlCEluYWN0aXZlBEdsb3cRSW1hZ2VUcmFuc3BhcmVuY3kHVmlzaWJsZQZDb2xvcjMHZnJvbVJHQgtJbWFnZUNvbG9yMwZpbnNlcnQMZmxhc2hpbmdHbG93C1Byb2dyZXNzQmFyC0V4cG9uZW50aWFsCFBvc2l0aW9uBVVEaW0yCWZyb21TY2FsZQR0YXNrBnNoaXZlcglkaXJlY3Rpb24MR2V0QXR0cmlidXRlDnVwZGF0ZUZsYXNoaW5nBXByaW50DHNhdmVJbml0aWFscwVzcGF3bhlHZXRBdHRyaWJ1dGVDaGFuZ2VkU2lnbmFsB0Nvbm5lY3QHaXNTdGF0ZQhnZXRTdGF0ZQ1hZGRDb25uZWN0aW9uEGNsZWFyQ29ubmVjdGlvbnMEZ2FtZQZEZWJyaXMKR2V0U2VydmljZQRiYXNlDXRlbXBsYXRlU3RhdGUGc3RhdGVzDHRlbXBsYXRlRmxhZwVmbGFncwdfX2luZGV4AAwFAgEAAAAS/wMCAAAAAAD7BAAAnj0DAwQAAACkAgEAAAAAQJ8CAwIwAQJ2AgAAAE0DATwDAAAAMAMCPAMAAAC8AwJ7BAAAAJ8DAgGCAgIABQMBBAAAAEADAgMDAwQABQUBGAAAAAAAAAAAAgABAAAAAgAAAgcAAAAACwICAAAAJCsBAgD/AQAAAAAAALwCADoAAAAAnwICAk0DACQBAAAAMAMCJAEAAACkAwMAAAAgQFIEAQCfAwIEFwMIAPsIAABNCAgvBAAAAFIJAgBSCgYAnwgDAg4IAQBqBwIGbgP3/wIAAAC8AwLuBQAA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

-- https://lua.expert/
local t = {}

t.__index = t
function t.Init(p1, p2) --[[ Init | Line: 5 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2.helpers = p2
	v2.tweens = p2.tweens
	v2:LoadStylesheet()

	return v2
end
function t.LoadStylesheet(p1) --[[ LoadStylesheet | Line: 18 | Upvalues: t (copy) ]]
	local tweens = p1.tweens
	local isState = p1.helpers.isState
	local getState = p1.helpers.getState
	local addConnection = p1.helpers.addConnection
	local clearConnections = p1.helpers.clearConnections
	local Debris = game:GetService("Debris")

	local function playSound(p1, p2) --[[ playSound | Line: 30 | Upvalues: tweens (copy), Debris (copy) ]]
		if not p2 then
			p2 = {}
		end

		local v1 = p1:Clone()

		v1.Parent = p1.Parent

		for k, v in pairs(p2) do
			if tweens.hasProperty(v1, k) then
				v1[k] = v
			end
		end

		v1:Play()
		Debris:AddItem(v1, v1.TimeLength)
	end

	function t.base(p1, p2) --[[ Line: 51 | Upvalues: tweens (copy), Debris (copy) ]]
		tweens.saveInitials(p1)
		tweens.saveInitials(p1.Parent.ProgressBar)
		task.spawn(function() --[[ Line: 58 | Upvalues: tweens (ref), p1 (copy) ]]
			while true do
				tweens.playTween(p1.LeftArrowBg, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
					AnchorPoint = Vector2.new(0.45, 0)
				})
				tweens.playTween(p1.RightArrowBg, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
					AnchorPoint = Vector2.new(0.45, 0)
				})
				wait(0.25)
				tweens.playTween(p1.LeftArrowBg, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
					AnchorPoint = Vector2.new(0.55, 0)
				})
				tweens.playTween(p1.RightArrowBg, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
					AnchorPoint = Vector2.new(0.55, 0)
				})
				wait(0.25)
			end
		end)

		local t = {}

		local function flashingGlow(p1) --[[ flashingGlow | Line: 79 | Upvalues: t (copy), tweens (ref), Debris (ref) ]]
			for k, v in pairs(t) do
				v:Cancel()
				table.remove(t, k)
			end

			for k, v in pairs(p1.Parent:GetChildren()) do
				if v:IsA("Frame") then
					local v1 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
					local t2 = {}

					t2.Scale = if v == p1 then 1 else 0.8
					tweens.playTween(v.Key.UIScale, v1, t2)

					local v3 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
					local t3 = {}

					t3.Scale = if v == p1 then 1 else 0.8
					tweens.playTween(v.Inactive.UIScale, v3, t3)

					if v ~= p1 then
						tweens.playTween(v.Glow, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
							ImageTransparency = 1
						})
						tweens.playTween(v.Glow.UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, false), {
							Scale = 1.5
						})
						v.Inactive.Visible = true

						local v5 = v.Glow:Clone()

						v5.Parent = v
						v5.ImageTransparency = 0.5
						v5.UIScale.Scale = 1
						v5.ImageColor3 = Color3.fromRGB(255, 209, 23)
						tweens.playTween(v5, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
							ImageTransparency = 1
						})
						tweens.playTween(v5.UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, false), {
							Scale = 1.5
						})
						Debris:AddItem(v5, 0.15)
					end
				end
			end

			p1.Glow.ImageTransparency = 0.25
			p1.Glow.UIScale.Scale = 1
			p1.Inactive.Visible = false
			table.insert(t, tweens.playTween(p1.Glow, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, false), {
				ImageTransparency = 0.9
			}))
			table.insert(t, tweens.playTween(p1.Glow.UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, false), {
				Scale = 1.25
			}))
		end

		local v1 = 0

		local function updateFlashing() --[[ updateFlashing | Line: 131 | Upvalues: v1 (ref), tweens (ref), p1 (copy), flashingGlow (copy) ]]
			v1 = v1 + 0.01
			(function() --[[ shiver | Line: 138 | Upvalues: tweens (ref), p1 (ref) ]]
				tweens.playTween(p1.Parent.ProgressBar, TweenInfo.new(0.025, Enum.EasingStyle.Exponential), {
					Position = UDim2.fromScale(0.525, 0.5)
				})
				task.wait(0.025)
				tweens.playTween(p1.Parent.ProgressBar, TweenInfo.new(0.05, Enum.EasingStyle.Exponential), {
					Position = UDim2.fromScale(0.475, 0.5)
				})
				task.wait(0.05)
				tweens.playTween(p1.Parent.ProgressBar, TweenInfo.new(0.025, Enum.EasingStyle.Exponential), {
					Position = UDim2.fromScale(0.5, 0.5)
				})
			end)()

			if p1:GetAttribute("direction") == 0 then
				flashingGlow(p1.LeftArrowBg)

				return
			end

			if p1:GetAttribute("direction") ~= 1 then
				return
			end

			flashingGlow(p1.RightArrowBg)
		end

		updateFlashing()
		p1:GetAttributeChangedSignal("direction"):Connect(function() --[[ Line: 158 | Upvalues: updateFlashing (copy), p1 (copy) ]]
			updateFlashing()
			print(p1:GetAttribute("direction"))
		end)
	end
	t.states = {
		templateState = function(p1, p2) --[[ Line: 177 ]] end
	}
	t.flags = {
		templateFlag = function(p1, p2, p3) --[[ Line: 198 ]] end
	}
end

return t