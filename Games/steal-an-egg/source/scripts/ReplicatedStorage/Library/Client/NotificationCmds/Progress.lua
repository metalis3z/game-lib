-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NotificationInstance = require(script.Parent.NotificationInstance)
local Functions = require(ReplicatedStorage.Library.Functions)
local Wiggle = require(ReplicatedStorage.Library.Client.GUIFX.Wiggle)
local Shimmer = require(ReplicatedStorage.Library.Client.GUIFX.Shimmer)
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local Audio = require(ReplicatedStorage.Library.Audio)
local Progress = ReplicatedStorage.Assets.UI.Notifications.Top.Progress
local Task = Progress.Tasks.Task
local t2 = {}
local t3 = {
	102750162720807,
	139149259758312,
	119928278928582,
	78616358641574
}
local v1 = t.interface({
	Progress = t.number,
	Maximum = t.number,
	Desc = t.string,
	Segments = t.optional(t.number)
})
local v2 = t.interface({
	Title = t.string,
	SideIcon = t.optional(t.string),
	Bars = t.array(v1),
	AnimateWhenCompleted = t.optional(t.boolean)
})

function t2.Top(p1, p2) --[[ Top | Line: 53 | Upvalues: v2 (copy), t3 (copy), Task (copy), Functions (copy), Progress (copy), Audio (copy), Shimmer (copy), Wiggle (copy), NotificationInstance (copy) ]]
	assert(v2(p1))

	local v22 = 0
	local list = {}
	local v3 = nil

	for i, v in ipairs(p1.Bars) do
		local v4
		local v5 = math.clamp(v.Progress, 0, v.Maximum)
		local v6 = math.max(v.Maximum, 1)

		if v.Segments and v.Segments > 1 then
			local v7 = math.floor(v.Segments)
			local v8 = math.floor(v5 / (v6 / v7))

			if not (v8 <= 0 or v8 <= (v.LastChunks or 0)) then
				v.LastChunks = v8
				v3 = t3[v8]

				if v7 <= v8 then
					local v9 = Task:Clone()

					v9.Amount.Text = "Done!"
					v9.Progress.Bar.Size = UDim2.new(1, 0, 1, 0)
					v4, v22 = v9, v22 + 1
				else
					local v10 = Task:Clone()

					v10.Amount.Text = ("%s/%s"):format(Functions.Commas(v5), Functions.Commas(v6))
					v10.Progress.Bar.Size = UDim2.new(v8 / v7, 0, 1, 0)
					v4 = v10
				end

				if v4 then
					v4.Label.Text = v.Desc
					v4.LayoutOrder = i
					table.insert(list, v4)
				end
			end
		else
			local v11 = v5 / v6
			local v12 = Task:Clone()

			if v11 < 1 then
				v12.Amount.Text = ("%s/%s"):format(Functions.Commas(v5), Functions.Commas(v6))
				v12.Progress.Bar.Size = UDim2.new(v11, 0, 1, 0)
				v4 = v12
			else
				v12.Amount.Text = "Done!"
				v12.Progress.Bar.Size = UDim2.new(1, 0, 1, 0)
				v4, v22 = v12, v22 + 1
			end

			if v4 then
				v4.Label.Text = v.Desc
				v4.LayoutOrder = i
				table.insert(list, v4)
			end
		end
	end

	if #list == 0 then
		return
	end

	local v13 = Progress:Clone()
	local SideIcon = v13.Message.SideIcon

	v13.Tasks.Task:Destroy()
	v13.Message.Text.Title.Text = p1.Title

	if p1.SideIcon then
		SideIcon.Visible = true
		SideIcon.Image = p1.SideIcon
	else
		SideIcon.Visible = false
	end

	for i, v in ipairs(list) do
		v.Parent = v13.Tasks
	end

	local function onAppear() --[[ onAppear | Line: 144 | Upvalues: Audio (ref), v3 (ref) ]]
		Audio.Play(96726510123679, script, nil, 2)

		if v3 then
			Audio.Play(v3, script, nil, 2)
		end
	end

	local function onAllBarsCompleted() --[[ onAllBarsCompleted | Line: 153 | Upvalues: Audio (ref), Shimmer (ref), v13 (copy), Wiggle (ref) ]]
		Audio.Play(96726510123679, script, nil, 2)
		task.wait(0.65)

		local v1 = Shimmer(v13)

		Wiggle(v13)
		task.delay(5, v1)
	end

	local v15, v16

	if p1.AnimateWhenCompleted and v22 >= 1 then
		v15 = v13
		v16 = onAllBarsCompleted
	else
		v15 = v13
		v16 = onAppear
	end

	return NotificationInstance.new(NotificationInstance.Locations.Top, v15, v16, p2)
end

return t2