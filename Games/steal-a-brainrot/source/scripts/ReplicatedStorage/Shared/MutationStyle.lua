-- Reconstructed module (was missing from ReplicatedStorage.Shared)
-- Applies a mutation's brand color to a TextLabel (used e.g. for the
-- "X Exist" counter label in the Glossary UI).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Mutations = require(ReplicatedStorage.Datas.Mutations)

local MutationStyle = {}

-- Colors `label`'s text (and its UIStroke, if any) to match the given
-- mutation. Silently does nothing if the mutation is unknown.
function MutationStyle.ApplyToLabel(label: TextLabel, mutationName: string?)
	if not label or not mutationName then
		return
	end

	local data = Mutations[mutationName]
	if not data then
		return
	end

	label.TextColor3 = data.MainColor

	local stroke = label:FindFirstChildOfClass("UIStroke")
	if stroke then
		local palette = data.Palettes and data.Palettes[1]
		stroke.Color = (palette and palette[3]) or Color3.new(0, 0, 0)
	end
end

return MutationStyle
