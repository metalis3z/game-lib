-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:04
-- Luau version 6, Types version 3
-- Time taken: 0.003545 seconds

local tbl_upvr = {}
local function _(arg1) -- Line 8, Named "remove"
	--[[ Upvalues[1]:
		[1]: tbl_upvr (readonly)
	]]
	local var2 = tbl_upvr[arg1]
	if var2 then
		var2.ShaderFrame:Destroy()
		var2.ShadowImage:Destroy()
		tbl_upvr[arg1] = nil
	end
end
if not game:FindService("NetworkServer") then
	game:GetService("RunService").RenderStepped:connect(function() -- Line 18
		--[[ Upvalues[1]:
			[1]: tbl_upvr (readonly)
		]]
		for i, v in next, tbl_upvr do
			local minimum = math.min((tick() - v.StartedAt) / v.Length, 1)
			v.ShaderFrame.Position = UDim2.new(0, 0, minimum, 0)
			v.ShaderFrame.Size = UDim2.new(1, 0, 1 - minimum, 0)
			v.ShadowImage.Position = UDim2.new(0, 0, 0, -minimum * v.ShaderFrame.AbsoluteSize.x)
			if minimum == 1 then
				local var11 = tbl_upvr[i]
				if var11 then
					var11.ShaderFrame:Destroy()
					var11.ShadowImage:Destroy()
					tbl_upvr[i] = nil
				end
			end
		end
	end)
end
local ContextActionService_upvr = game:GetService("ContextActionService")
return function(arg1, arg2) -- Line 31
	--[[ Upvalues[2]:
		[1]: tbl_upvr (readonly)
		[2]: ContextActionService_upvr (readonly)
	]]
	local var14 = tbl_upvr[arg1]
	if var14 then
		var14.ShaderFrame:Destroy()
		var14.ShadowImage:Destroy()
		tbl_upvr[arg1] = nil
	end
	if arg2 and 0 < arg2 then
		local Parent = require(script.Parent)
		local any_GetButton_result1 = ContextActionService_upvr:GetButton(arg1)
		local tbl = {
			StartedAt = tick();
		}
		tbl.Length = arg2
		tbl.ShaderFrame = Parent.Create("Frame")({
			Name = "Shader";
			BackgroundTransparency = 1;
			Parent = any_GetButton_result1;
			Size = UDim2.new(1, 0, 1, 0);
			ClipsDescendants = true;
		})
		tbl.ShadowImage = Parent.Create("ImageLabel")({
			Name = "Image";
			BackgroundTransparency = 1;
			Image = any_GetButton_result1.Image;
			ImageRectSize = any_GetButton_result1.ImageRectSize;
			ImageRectOffset = any_GetButton_result1.ImageRectOffset;
			Size = any_GetButton_result1.Size;
			ZIndex = any_GetButton_result1.ZIndex + 1;
		})
		tbl.Button = any_GetButton_result1
		tbl.ShadowImage.ImageColor3 = Color3.new(0.5, 0.5, 0.5)
		tbl.ShadowImage.Parent = tbl.ShaderFrame
		tbl_upvr[arg1] = tbl
	end
end