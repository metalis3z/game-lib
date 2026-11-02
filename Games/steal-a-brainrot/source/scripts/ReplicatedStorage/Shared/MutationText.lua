-- Reconstructed module (was missing from ReplicatedStorage.Shared)
-- Writes a mutation's display text onto a TextLabel and colors it to match
-- (with an animated gradient via the Gradients package for mutations that
-- define a GradientPreset, e.g. "Rainbow"). Used by GlossaryController and
-- AnimalOverheadController.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Mutations = require(ReplicatedStorage.Datas.Mutations)

local ok_Gradients, Gradients = pcall(require, ReplicatedStorage.Packages.Gradients)
if not ok_Gradients then
	Gradients = nil
end

local MutationText = {}

-- Resets a label back to a neutral, non-mutated appearance.
function MutationText.clear(label: TextLabel)
	if not label then
		return
	end
	label.Text = ""
	label.TextColor3 = Color3.new(1, 1, 1)
end

-- Sets `label`'s text/color for `mutationName`. `mode` is currently only
-- used to decide between rich text and plain text ("Auto" = use rich text
-- when the mutation defines it). Returns a cleanup function (to be added to
-- a Trove) when an animated gradient effect was started, or nil otherwise.
function MutationText.ApplyToLabel(label: TextLabel, mutationName: string?, mode: string?)
	if not label then
		return nil
	end

	if not mutationName then
		MutationText.clear(label)
		return nil
	end

	local data = Mutations[mutationName]
	if not data then
		MutationText.clear(label)
		return nil
	end

	if data.UseRichText and data.DisplayWithRichText then
		label.RichText = true
		label.Text = data.DisplayWithRichText
	else
		label.RichText = false
		label.Text = data.DisplayText or mutationName
	end

	label.TextColor3 = data.MainColor or Color3.new(1, 1, 1)

	if data.GradientPreset and Gradients then
		local ok, cleanup = pcall(Gradients.apply, label, data.GradientPreset)
		if ok then
			return cleanup
		end
	end

	return nil
end

MutationText.apply = MutationText.ApplyToLabel

return MutationText
