-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BBFromArrayVisibleOnly = require(ReplicatedStorage.Library.Functions.BBFromArrayVisibleOnly)
local FastTween = require(ReplicatedStorage.Library.Functions.FastTween)
local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)
local Cash = ReplicatedStorage.Assets.Extra.Cash

assert(Cash:IsA("BillboardGui"), "Assets.Extra.Cash must be a BillboardGui")

local t = {}

local function scaleBillboardSize(p1, p2) --[[ scaleBillboardSize | Line: 37 ]]
	return UDim2.new(p1.X.Scale * p2, p1.X.Offset * p2, p1.Y.Scale * p2, p1.Y.Offset * p2)
end

local function getBillboardScale(p1) --[[ getBillboardScale | Line: 41 ]]
	local v4 = math.min(p1.X / 2, p1.Y / 5.72646427154541, p1.Z / 5.299603462219238)

	if v4 <= 0 then
		return 0.9
	end

	return math.clamp(v4, 0.9, 5)
end

local function fadeTextLabel(p1, p2, p3, p4) --[[ fadeTextLabel | Line: 54 | Upvalues: FastTween (copy) ]]
	p1.Text = p2
	p1.TextTransparency = 1
	FastTween(p1, p3, {
		TextTransparency = 0
	})
	task.delay(0.8499999999999999, function() --[[ Line: 60 | Upvalues: p1 (copy), FastTween (ref), p4 (copy) ]]
		if not p1.Parent then
			return
		end

		FastTween(p1, p4, {
			TextTransparency = 1
		})
	end)
end

local function fadeTextButton(p1, p2, p3, p4) --[[ fadeTextButton | Line: 69 | Upvalues: FastTween (copy) ]]
	p1.Text = p2
	p1.TextTransparency = 1
	FastTween(p1, p3, {
		TextTransparency = 0
	})
	task.delay(0.8499999999999999, function() --[[ Line: 75 | Upvalues: p1 (copy), FastTween (ref), p4 (copy) ]]
		if not p1.Parent then
			return
		end

		FastTween(p1, p4, {
			TextTransparency = 1
		})
	end)
end

local function fadeTextBox(p1, p2, p3, p4) --[[ fadeTextBox | Line: 84 | Upvalues: FastTween (copy) ]]
	p1.Text = p2
	p1.TextTransparency = 1
	FastTween(p1, p3, {
		TextTransparency = 0
	})
	task.delay(0.8499999999999999, function() --[[ Line: 90 | Upvalues: p1 (copy), FastTween (ref), p4 (copy) ]]
		if not p1.Parent then
			return
		end

		FastTween(p1, p4, {
			TextTransparency = 1
		})
	end)
end

local function fadeImageObject(p1, p2, p3) --[[ fadeImageObject | Line: 99 | Upvalues: FastTween (copy) ]]
	p1.ImageTransparency = 1
	FastTween(p1, p2, {
		ImageTransparency = 0
	})
	task.delay(0.8499999999999999, function() --[[ Line: 105 | Upvalues: p1 (copy), FastTween (ref), p3 (copy) ]]
		if not p1.Parent then
			return
		end

		FastTween(p1, p3, {
			ImageTransparency = 1
		})
	end)
end

local function fadePopupDescendants(p1, p2, p3, p4) --[[ fadePopupDescendants | Line: 114 | Upvalues: fadeTextLabel (copy), fadeTextButton (copy), fadeTextBox (copy), FastTween (copy), fadeImageObject (copy) ]]
	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("TextLabel") then
			fadeTextLabel(v, p2, p3, p4)

			continue
		end

		if v:IsA("TextButton") then
			fadeTextButton(v, p2, p3, p4)

			continue
		end

		if v:IsA("TextBox") then
			fadeTextBox(v, p2, p3, p4)

			continue
		end

		if v:IsA("UIStroke") then
			v.Transparency = 1
			FastTween(v, p3, {
				Transparency = 0
			})
			task.delay(0.8499999999999999, function() --[[ Line: 132 | Upvalues: v (copy), FastTween (ref), p4 (copy) ]]
				if not v.Parent then
					return
				end

				FastTween(v, p4, {
					Transparency = 1
				})
			end)

			continue
		end

		if v:IsA("ImageLabel") or v:IsA("ImageButton") then
			fadeImageObject(v, p3, p4)
		end
	end
end

local function showAtCFrame(p1, p2, p3, p4, p5) --[[ showAtCFrame | Line: 145 | Upvalues: Cash (copy), fadePopupDescendants (copy), Simple (copy), FastTween (copy), Debris (copy) ]]
	local SyncedIncomeCashAttachment = Instance.new("Attachment")

	SyncedIncomeCashAttachment.Name = "SyncedIncomeCashAttachment"
	SyncedIncomeCashAttachment.WorldCFrame = p1
	SyncedIncomeCashAttachment.Parent = workspace.Terrain

	local SyncedIncomeCash = Cash:Clone()

	SyncedIncomeCash.Name = "SyncedIncomeCash"
	SyncedIncomeCash.Adornee = SyncedIncomeCashAttachment
	SyncedIncomeCash.Parent = SyncedIncomeCashAttachment
	SyncedIncomeCash.AlwaysOnTop = if p3 and p3.alwaysOnTop ~= nil then p3.alwaysOnTop else true

	local Size = SyncedIncomeCash.Size

	SyncedIncomeCash.Size = UDim2.new(Size.X.Scale * p5, Size.X.Offset * p5, Size.Y.Scale * p5, Size.Y.Offset * p5)
	fadePopupDescendants(SyncedIncomeCash, ("+$%*"):format((Simple.FormatCompact((math.round(p2))))), TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
	FastTween(SyncedIncomeCashAttachment, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		WorldPosition = p1.Position + Vector3.new(0, p4, 0)
	})
	Debris:AddItem(SyncedIncomeCash, 1.4)
	Debris:AddItem(SyncedIncomeCashAttachment, 1.4)
end

function t.Show(p1, p2, p3) --[[ Show | Line: 183 | Upvalues: BBFromArrayVisibleOnly (copy), Cash (copy), showAtCFrame (copy) ]]
	local v1, v2 = BBFromArrayVisibleOnly(p1)
	local v4 = v1 - Vector3.new(0, v2.Y / 1.5, 0)
	local v5 = assert(workspace.CurrentCamera, "Active asset income popup requires Workspace.CurrentCamera")
	local MaxDistance = Cash.MaxDistance

	if MaxDistance > 0 and MaxDistance < (v5.CFrame.Position - v4.Position).Magnitude then
		return
	end

	local v11 = math.min(v2.X / 2, v2.Y / 5.72646427154541, v2.Z / 5.299603462219238)

	showAtCFrame(v4, p2, p3, v2.Y - v2.Y * 0.25, if v11 <= 0 then 0.9 else math.clamp(v11, 0.9, 5))
end

return t