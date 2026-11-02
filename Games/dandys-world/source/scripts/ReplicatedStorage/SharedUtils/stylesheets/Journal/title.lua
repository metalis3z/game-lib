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
-- 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

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

	function t.base(p1, p2) --[[ Line: 28 | Upvalues: tweens (copy) ]]
		tweens.saveInitials(p1)

		local v2 = p1.Display:FindFirstChild((p1:GetAttribute("Difficulty")))

		if v2 then
			for k, v in pairs(p1.Display:GetChildren()) do
				if v:IsA("ImageLabel") then
					v.Visible = false
				end
			end

			v2.Visible = true
		end

		p2:Apply(p1.Pinned, "Shared.Journal.pin")
		p2:Apply(p1.TextButton, "Shared.Journal.textButton")
	end
	t.states = {
		equipped = function(p1, p2) --[[ Line: 66 | Upvalues: tweens (copy) ]]
			tweens.playTween(p1.UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Circular), {
				Scale = 1.045
			})

			for k, v in pairs(p1.Parent:GetChildren()) do
				if v:IsA("Frame") and v ~= p1 then
					p2:SetState(v, "unEquipped")
				end
			end

			p1.TextButton.Inactive.Visible = true
			p1.TextButton.Title.Text = "EQUIPPED"
			p1.Display.Equipped.Visible = true
			p1.Fade.Visible = true
			p2:SetState(p1.Pinned, "open")
			p2:SetState(p1.TextButton, "inactive")
		end,
		unEquipped = function(p1, p2) --[[ Line: 96 | Upvalues: tweens (copy) ]]
			tweens.playTween(p1.UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Circular), {
				Scale = 1
			})
			p1.TextButton.Inactive.Visible = false
			p1.TextButton.Title.Text = "EQUIP"
			p1.Display.Equipped.Visible = false
			p1.Fade.Visible = false
			p2:SetState(p1.Pinned, "closed")
			p2:SetState(p1.TextButton, "active")
		end
	}
	t.flags = {
		templateFlag = function(p1, p2, p3) --[[ Line: 125 ]] end
	}
end

return t