-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("ContentProvider");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local v4 = require(l_ReplicatedStorage_0.Packages.Synchronizer);
local v5 = require(l_ReplicatedStorage_0.Packages.Observers);
local v6 = require(l_ReplicatedStorage_0.Packages.Gradients);
local v7 = require(l_ReplicatedStorage_0.Packages.Signal);
local v8 = require(l_ReplicatedStorage_0.Packages.Trove);
local v9 = require(l_ReplicatedStorage_0.Packages.Timer);
local v10 = require(l_ReplicatedStorage_0.Packages.Net);
local v11 = require(l_ReplicatedStorage_0.Shared.VFX);
local v12 = require(l_ReplicatedStorage_0.Controllers.InterfaceController);
local v13 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v14 = require(l_ReplicatedStorage_0.Classes.AnimatedButton);
local v15 = require(l_ReplicatedStorage_0.Shared.Animals);
local v16 = require(l_ReplicatedStorage_0.Utils.NumberUtils);
local v17 = require(l_ReplicatedStorage_0.Utils.TimeUtils);
local v18 = require(l_ReplicatedStorage_0.Datas.Mutations);
local v19 = require(l_ReplicatedStorage_0.Datas.Rarities);
local v20 = require(l_ReplicatedStorage_0.Datas.Animals);
local v21 = require(l_ReplicatedStorage_0.Datas.Traits);
local v22 = v10:RemoteEvent("CupidsMachineService/CraftDone");
local v23 = v10:RemoteEvent("CupidsMachineService/Update");
local v24 = v10:RemoteEvent("CupidsMachineService/Return");
local v25 = v10:RemoteEvent("CupidsMachineService/Claim");
local v26 = v10:RemoteEvent("CupidsMachineService/Skip");
local v27 = v10:RemoteFunction("CupidsMachineService/Delivery");
local v28 = v10:RemoteFunction("CupidsMachineService/Start");
local v29 = v10:RemoteFunction("CupidsMachineService/Fetch");
local v30 = v10:RemoteEvent("ShopService/Purchase");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_CupidsMachine_0 = l_LocalPlayer_0.PlayerGui:WaitForChild("CupidsMachine").CupidsMachine;
local l_Left_0 = l_CupidsMachine_0.Left;
local l_Right_0 = l_CupidsMachine_0.Right;
local l_Buy_0 = l_CupidsMachine_0.Buy;
local l_Time_0 = l_CupidsMachine_0.Time;
local l_Title_0 = l_CupidsMachine_0.Title;
local l_Close_0 = l_CupidsMachine_0.Header.Close;
local l_Outputs_0 = l_CupidsMachine_0.Outputs;
local l_Template_0 = l_Outputs_0.Template;
local v41 = nil;
local v43 = {
	OnRecipeChanged = v7.new(), 
	GetCurrentRecipe = function(_) --[[ Line: 90 ]] --[[ Name: GetCurrentRecipe ]]
		-- upvalues: v41 (ref)
		return v41;
	end
};
local function v50(v44, v45, v46) --[[ Line: 94 ]] --[[ Name: applyRarityStyle ]]
	-- upvalues: v20 (copy), v19 (copy), v6 (copy)
	local v47 = v20[v45];
	if not v47 then
		return;
	else
		local v48 = v19[v47.Rarity];
		if not v48 then
			return;
		else
			if v48.GradientPreset then
				v44.TextColor3 = Color3.new(1, 1, 1);
				local v49 = v6.apply(v44, v48.GradientPreset);
				if v46 and v49 then
					v46:Add(v49);
					return;
				end;
			else
				v44.TextColor3 = v48.Color;
			end;
			return;
		end;
	end;
end;
local function v58(v51, v52) --[[ Line: 116 ]] --[[ Name: getBrainrotsInMachineForSlot ]]
	-- upvalues: v4 (copy), l_LocalPlayer_0 (copy)
	local v53 = v4:Get(l_LocalPlayer_0);
	if not v53 then
		return {};
	else
		local v54 = v53:Get("AnimalPodiums");
		if not v54 then
			return {};
		else
			local v55 = {};
			for v56, v57 in v54 do
				if typeof(v57) == "table" and v57.Machine and v57.Machine.Type == "Cupids" and (not v57.Machine.Active or v52) and v57.Index == v51 then
					table.insert(v55, {
						Index = v57.Index, 
						Podium = v56
					});
				end;
			end;
			return v55;
		end;
	end;
end;
local v59 = v8.new();
local v60 = v8.new();
local function v71(v61, v62, v63) --[[ Line: 152 ]] --[[ Name: update3DModel ]]
	-- upvalues: l_CollectionService_0 (copy), v15 (copy)
	v63:Clean();
	if not v62 then
		return nil;
	else
		for _, v65 in (l_CollectionService_0:GetTagged(v61)) do
			local l_v15_AnimatedModel_0 = v15:GetAnimatedModel(v62, "Idle");
			if l_v15_AnimatedModel_0 then
				v63:Add(l_v15_AnimatedModel_0);
				local l_Size_0 = v65.Size;
				local l_l_v15_AnimatedModel_0_ExtentsSize_0 = l_v15_AnimatedModel_0:GetExtentsSize();
				local v69 = math.min(l_Size_0.X / l_l_v15_AnimatedModel_0_ExtentsSize_0.X, l_Size_0.Y / l_l_v15_AnimatedModel_0_ExtentsSize_0.Y, l_Size_0.Z / l_l_v15_AnimatedModel_0_ExtentsSize_0.Z);
				l_v15_AnimatedModel_0:ScaleTo(l_v15_AnimatedModel_0:GetScale() * v69);
				l_v15_AnimatedModel_0:PivotTo(v65:GetPivot());
				if l_v15_AnimatedModel_0.PrimaryPart then
					l_v15_AnimatedModel_0.PrimaryPart.Anchored = false;
					local l_WeldConstraint_0 = Instance.new("WeldConstraint");
					l_WeldConstraint_0.Part0 = l_v15_AnimatedModel_0.PrimaryPart;
					l_WeldConstraint_0.Part1 = v65;
					l_WeldConstraint_0.Parent = l_v15_AnimatedModel_0.PrimaryPart;
					v63:Add(l_WeldConstraint_0);
				end;
			end;
		end;
		return v62;
	end;
end;
local v72 = nil;
local v73 = v8.new();
local v74 = v8.new();
local v75 = v8.new();
local v76 = v8.new();
local v77 = false;
local function v88(v78, v79, v80, v81) --[[ Line: 201 ]] --[[ Name: updateSlotFrame ]]
	-- upvalues: v20 (copy), v15 (copy), v50 (copy), v14 (copy), v58 (copy), v24 (copy)
	v81:Clean();
	local l_ViewportFrame_0 = v78:FindFirstChild("ViewportFrame");
	if l_ViewportFrame_0 then
		if v79 and v20[v79] then
			local v83 = v15:AttachOnViewportWithOptimizations(v79, l_ViewportFrame_0);
			if v83 then
				v81:Add(v83);
			end;
		end;
		l_ViewportFrame_0.ImageColor3 = if v80 then Color3.new(1, 1, 1) else Color3.new(0, 0, 0);
	end;
	local l_BrainrotLabel_0 = v78:FindFirstChild("BrainrotLabel");
	if l_BrainrotLabel_0 then
		l_BrainrotLabel_0.Text = v79 or "Empty";
		if v79 then
			v50(l_BrainrotLabel_0, v79, v81);
		else
			l_BrainrotLabel_0.TextColor3 = Color3.fromRGB(200, 200, 200);
		end;
	end;
	local l_Return_0 = v78:FindFirstChild("Return");
	if l_Return_0 then
		l_Return_0.Visible = v80;
		if v80 and v79 then
			local v86 = v81:Add(v14.new(l_Return_0));
			v86:Animate();
			v81:Add(v86.OnActivated:Connect(function() --[[ Line: 236 ]]
				-- upvalues: v58 (ref), v79 (copy), v24 (ref)
				local v87 = v58(v79);
				if #v87 > 0 then
					v24:FireServer(v87[1].Podium);
				end;
			end));
		end;
	end;
end;
local v89 = {
	left = {
		name = nil, 
		filled = nil
	}, 
	right = {
		name = nil, 
		filled = nil
	}
};
local function v99() --[[ Line: 250 ]] --[[ Name: UpdateTimer ]]
	-- upvalues: l_Title_0 (copy), v41 (ref), v17 (copy), l_Time_0 (copy), v4 (copy), l_LocalPlayer_0 (copy)
	if l_Title_0 then
		local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
		local v91 = math.max((v41 and v41.Refresh or 0) - l_workspace_ServerTimeNow_0, 0);
		l_Title_0.Text = ("New possible match in <font color='#ffff00'>%*</font>"):format((v17:E(v91)));
	end;
	if l_Time_0 then
		local v92 = v4:Get(l_LocalPlayer_0);
		local v93 = v92 and v92:Get("CupidsMachine");
		local v94 = v93 and v93.StartTime and v93.StartTime ~= 0;
		local v95 = v93 and v93.FinishTime;
		local v96 = v95 and v95 <= workspace:GetServerTimeNow();
		if v94 and not v96 then
			local l_workspace_ServerTimeNow_1 = workspace:GetServerTimeNow();
			local v98 = math.max((v95 or 0) - l_workspace_ServerTimeNow_1, 0);
			l_Time_0.Text = ("Matching... (<font color='#ffff00'>%*</font>)"):format((v17:E(v98)));
			return;
		else
			l_Time_0.Text = "Match Time (<font color='#ffff00'>5m</font>)";
		end;
	end;
end;
local function v127() --[[ Line: 277 ]] --[[ Name: UpdateMutationsAndTraits ]]
	-- upvalues: l_CupidsMachine_0 (copy), v4 (copy), l_LocalPlayer_0 (copy), v18 (copy), v6 (copy), v21 (copy)
	for _, v101 in l_CupidsMachine_0.Lists.Mutations.ScrollingFrame:GetChildren() do
		if v101:IsA("Frame") and v101.Name ~= "Template" then
			v101:Destroy();
		end;
	end;
	for _, v103 in l_CupidsMachine_0.Lists.Traits.ScrollingFrame:GetChildren() do
		if v103:IsA("Frame") and v103.Name ~= "Template" then
			v103:Destroy();
		end;
	end;
	local v104 = v4:Get(l_LocalPlayer_0);
	if not v104 then
		l_CupidsMachine_0.Lists.Mutations.Visible = false;
		l_CupidsMachine_0.Lists.Traits.Visible = false;
		return;
	else
		local v105 = v104:Get("AnimalPodiums");
		if not v105 then
			l_CupidsMachine_0.Lists.Mutations.Visible = false;
			l_CupidsMachine_0.Lists.Traits.Visible = false;
			return;
		else
			local v106 = {};
			local v107 = {};
			for _, v109 in v105 do
				if typeof(v109) == "table" and v109.Machine and v109.Machine.Type == "Cupids" then
					if v109.Mutation then
						v106[v109.Mutation] = (v106[v109.Mutation] or 0) + 15;
					end;
					if typeof(v109.Traits) == "table" then
						for _, v111 in v109.Traits do
							v107[v111] = (v107[v111] or 0) + 1;
						end;
					end;
				end;
			end;
			local v112 = false;
			for v113, v114 in v106 do
				local v115 = v18[v113];
				if v115 then
					local v116 = l_CupidsMachine_0.Lists.Mutations.ScrollingFrame.Template:Clone();
					v116.Name = v113;
					v116.LayoutOrder = -v114;
					v116.Vector.Image = v115.Icon or "";
					v116.Title.Text = if v115.UseRichText then v115.DisplayWithRichText else v115.DisplayText;
					v116.Title.RichText = v115.UseRichText;
					if v115.GradientPreset then
						v116.Title.TextColor3 = Color3.fromRGB(255, 255, 255);
						v6.apply(v116.Title, v115.GradientPreset);
					else
						v116.Title.TextColor3 = v115.MainColor;
					end;
					local _, v118 = math.modf(v114);
					v116.Chance.Text = ("%*%%"):format((string.format(v118 == 0 and "%d" or "%.2f", v114)));
					v116.Visible = true;
					v116.Parent = l_CupidsMachine_0.Lists.Mutations.ScrollingFrame;
					v112 = true;
				end;
			end;
			l_CupidsMachine_0.Lists.Mutations.Visible = v112;
			local v119 = false;
			for v120, v121 in v107 do
				local v122 = v21[v120];
				if v122 then
					local v123 = math.clamp(v121 / 4, 0, 1) * 40;
					local v124 = l_CupidsMachine_0.Lists.Traits.ScrollingFrame.Template:Clone();
					v124.Name = v120;
					v124.LayoutOrder = -v123;
					v124.Vector.Image = v122.Icon or "";
					v124.Title.Text = v122.DisplayWithRichText;
					v124.Title.TextColor3 = v122.Color;
					v124.Title.RichText = true;
					local _, v126 = math.modf(v123);
					v124.Chance.Text = ("%*%%"):format((string.format(v126 == 0 and "%d" or "%.2f", v123)));
					v124.Visible = true;
					v124.Parent = l_CupidsMachine_0.Lists.Traits.ScrollingFrame;
					v119 = true;
				end;
			end;
			l_CupidsMachine_0.Lists.Traits.Visible = v119;
			return;
		end;
	end;
end;
local v128 = true;
local function v135() --[[ Line: 390 ]] --[[ Name: UpdateSurfaceGuis ]]
	-- upvalues: v128 (ref)
	local l_CupidsMachine_1 = workspace:FindFirstChild("CupidsMachine");
	local v130 = l_CupidsMachine_1 and l_CupidsMachine_1:FindFirstChild("ResultText");
	if v130 and v128 then
		local l_Fail_0 = v130:FindFirstChild("Fail");
		local l_Match_0 = v130:FindFirstChild("Match");
		local l_Waiting_0 = v130:FindFirstChild("Waiting");
		local l_Matching_0 = v130:FindFirstChild("Matching");
		if l_Fail_0 and l_Match_0 and l_Waiting_0 then
			l_Fail_0.Enabled = false;
			l_Match_0.Enabled = false;
			l_Waiting_0.Enabled = false;
			l_Matching_0.Enabled = false;
			if isCrafting and not isFinished then
				l_Matching_0.Enabled = true;
				return;
			elseif leftFilled and rightFilled then
				l_Match_0.Enabled = true;
				return;
			else
				l_Waiting_0.Enabled = true;
			end;
		end;
	end;
end;
local function v161() --[[ Line: 416 ]] --[[ Name: UpdateAll ]]
	-- upvalues: v73 (copy), v74 (copy), v4 (copy), l_LocalPlayer_0 (copy), v41 (ref), v99 (copy), v58 (copy), v89 (copy), v77 (ref), v88 (copy), l_Left_0 (copy), v75 (copy), v71 (copy), v59 (copy), l_Right_0 (copy), v76 (copy), v60 (copy), l_Buy_0 (copy), v16 (copy), v14 (copy), v28 (copy), v12 (copy), l_Outputs_0 (copy), l_Template_0 (copy), v50 (copy), v15 (copy), v127 (copy), v135 (copy)
	v73:Clean();
	v74:Clean();
	local v136 = v4:Get(l_LocalPlayer_0);
	if not v136 then
		return;
	else
		local v137 = v41 and v41.Recipe;
		v99();
		local v138 = v137 and v137.Recipe[1] or nil;
		local v139 = v137 and v137.Recipe[2] or nil;
		local v140 = v136:Get("CupidsMachine");
		local v141 = v140 and v140.StartTime and v140.StartTime ~= 0;
		local v142 = false;
		local v143 = false;
		if v138 then
			v142 = #v58(v138, v141) > 0;
		end;
		if v139 then
			v143 = #v58(v139, v141) > 0;
		end;
		local v144 = v140 and v140.FinishTime;
		if v144 then
			local _ = v144 <= workspace:GetServerTimeNow();
		end;
		if (v89.left.name ~= v138 or v89.left.filled ~= v142) and not v77 then
			v89.left.name = v138;
			v89.left.filled = v142;
			v88(l_Left_0, v138, v142, v75);
			v71("CupidsMachineLeft", if v142 then v138 else nil, v59);
		end;
		if (v89.right.name ~= v139 or v89.right.filled ~= v143) and not v77 then
			v89.right.name = v139;
			v89.right.filled = v143;
			v88(l_Right_0, v139, v143, v76);
			v71("CupidsMachineRight", if v143 then v139 else nil, v60);
		end;
		l_Buy_0.Visible = false;
		if v137 and v142 and v143 and not v141 then
			l_Buy_0.Visible = true;
			local l_Price_0 = l_Buy_0:FindFirstChild("Price");
			if l_Price_0 then
				l_Price_0.Text = ("$%*"):format((v16:ToString(v137.Cost)));
			end;
			local v147 = v74:Add(v14.new(l_Buy_0));
			v147:Animate();
			v74:Add(v147.OnActivated:Connect(function() --[[ Line: 485 ]]
				-- upvalues: v28 (ref), v137 (copy), v12 (ref)
				if v28:InvokeServer(v137.Name) then
					v12:SetState("CupidsMachine", false);
				end;
			end));
		end;
		if l_Outputs_0 and l_Template_0 then
			for _, v149 in l_Outputs_0:GetChildren() do
				if v149:IsA("Frame") and v149 ~= l_Template_0 then
					v149:Destroy();
				end;
			end;
			l_Template_0.Visible = false;
			if v41 and v41.Recipe ~= nil and v41 and v41.Outputs then
				for v150, v151 in v41.Outputs do
					local v152 = l_Template_0:Clone();
					v152.Name = ("Output_%*"):format(v150);
					v152.Visible = true;
					local l_BrainrotLabel_1 = v152:FindFirstChild("BrainrotLabel");
					local l_ViewportFrame_1 = v152:FindFirstChild("ViewportFrame");
					local l_Vector_0 = v152:FindFirstChild("Vector");
					local l_Weight_0 = v152:FindFirstChild("Weight");
					if l_Vector_0 then
						l_Vector_0.Visible = v151.Name == "Nothing";
					end;
					if v151.Name == "Nothing" then
						if l_BrainrotLabel_1 then
							l_BrainrotLabel_1.Text = "Nothing";
						end;
						if l_ViewportFrame_1 then
							for _, v158 in l_ViewportFrame_1:GetChildren() do
								if v158:IsA("Model") or v158:IsA("BasePart") then
									v158:Destroy();
								end;
							end;
							l_ViewportFrame_1.ImageTransparency = 1;
						end;
					else
						if l_BrainrotLabel_1 then
							l_BrainrotLabel_1.Text = v151.Name;
							v50(l_BrainrotLabel_1, v151.Name, v73);
						end;
						if l_ViewportFrame_1 then
							l_ViewportFrame_1.ImageTransparency = 0;
							local v159 = v15:AttachOnViewportWithOptimizations(v151.Name, l_ViewportFrame_1);
							if v159 then
								v73:Add(v159);
							end;
						end;
					end;
					if l_Weight_0 then
						local l_Chance_0 = v151.Chance;
						if l_Chance_0 == math.floor(l_Chance_0) then
							l_Weight_0.Text = ("%*%%"):format(l_Chance_0);
						else
							l_Weight_0.Text = string.format("%.2f%%", l_Chance_0);
						end;
					end;
					v152.Parent = l_Outputs_0;
				end;
			end;
		end;
		v127();
		v135();
		return;
	end;
end;
local v162 = {
	isFinished = nil, 
	isCrafting = nil
};
local function v168() --[[ Line: 573 ]] --[[ Name: CheckForUpdateAll ]]
	-- upvalues: v4 (copy), l_LocalPlayer_0 (copy), v162 (copy), v161 (copy)
	local v163 = v4:Get(l_LocalPlayer_0);
	if not v163 then
		return;
	else
		local v164 = v163:Get("CupidsMachine");
		local v165 = v164 and v164.StartTime and v164.StartTime ~= 0;
		local v166 = v164 and v164.FinishTime;
		local v167 = v166 and v166 <= workspace:GetServerTimeNow();
		if v162.isFinished ~= v167 or v162.isCrafting ~= v165 then
			v162.isCrafting = v165;
			v162.isFinished = v167;
			v161();
		end;
		return;
	end;
end;
v43.Start = function(v169) --[[ Line: 591 ]] --[[ Name: Start ]]
	-- upvalues: v4 (copy), l_LocalPlayer_0 (copy), l_CupidsMachine_0 (copy), v72 (ref), v12 (copy), l_Close_0 (copy), v23 (copy), v41 (ref), v161 (copy), v22 (copy), v77 (ref), v71 (copy), v59 (copy), v60 (copy), v11 (copy), l_ReplicatedStorage_0 (copy), v13 (copy), v128 (ref), v135 (copy), v29 (copy), v9 (copy), v168 (copy), v99 (copy), v5 (copy), v8 (copy), v25 (copy), v26 (copy), v30 (copy), v17 (copy), v58 (copy), l_Players_0 (copy), v27 (copy)
	v4:Wait(l_LocalPlayer_0);
	l_CupidsMachine_0.Visible = false;
	v72 = v12:Register("CupidsMachine", l_CupidsMachine_0, "TopQuint");
	if l_Close_0 then
		v72:AttachCloseButton(l_Close_0);
	end;
	v72:Close();
	v23.OnClientEvent:Connect(function(v170) --[[ Line: 603 ]]
		-- upvalues: v41 (ref), v169 (copy), v161 (ref)
		v41 = v170;
		v169.OnRecipeChanged:Fire(v41);
		task.spawn(v161);
	end);
	v22.OnClientEvent:Connect(function(v171, v172) --[[ Line: 610 ]]
		-- upvalues: v77 (ref), v12 (ref), v71 (ref), v59 (ref), v60 (ref), v11 (ref), l_ReplicatedStorage_0 (ref), v13 (ref), v128 (ref), v135 (ref), v161 (ref)
		v77 = true;
		v12:SetState("CupidsMachine", false);
		if v172 then
			local v173 = v172[1];
			local v174 = v172[2];
			if v173 then
				v71("CupidsMachineLeft", v173, v59);
			end;
			if v174 then
				v71("CupidsMachineRight", v174, v60);
			end;
		end;
		local l_CupidsMachine_2 = workspace:FindFirstChild("CupidsMachine");
		if not l_CupidsMachine_2 then
			v77 = false;
			return;
		else
			local l_AnimatedMesh_0 = l_CupidsMachine_2:FindFirstChild("AnimatedMesh");
			if not l_AnimatedMesh_0 then
				v77 = false;
				return;
			else
				local l_AnimationController_0 = l_AnimatedMesh_0:FindFirstChildWhichIsA("AnimationController");
				if not l_AnimationController_0 then
					v77 = false;
					return;
				else
					local l_Animator_0 = l_AnimationController_0:FindFirstChildWhichIsA("Animator");
					if not l_Animator_0 then
						v77 = false;
						return;
					else
						local v179 = v171 and "Success" or "Fail";
						local l_l_AnimatedMesh_0_FirstChild_0 = l_AnimatedMesh_0:FindFirstChild(v179);
						if l_l_AnimatedMesh_0_FirstChild_0 and l_l_AnimatedMesh_0_FirstChild_0:IsA("Animation") then
							local v181 = l_Animator_0:LoadAnimation(l_l_AnimatedMesh_0_FirstChild_0);
							v181.Priority = Enum.AnimationPriority.Action;
							v181:Play(0);
							local v182 = 5;
							while v181.Length == 0 and v182 > 0 do
								v182 = v182 - task.wait();
							end;
							if v179 == "Success" then
								v11.emit(l_AnimatedMesh_0);
								for _, v184 in l_AnimatedMesh_0:GetDescendants() do
									if v184:IsA("Trail") then
										v184.Enabled = true;
									end;
								end;
							end;
						end;
						task.spawn(function() --[[ Line: 675 ]]
							-- upvalues: l_ReplicatedStorage_0 (ref), v179 (copy), v13 (ref), l_CupidsMachine_2 (copy)
							local l_FirstChild_0 = l_ReplicatedStorage_0.Sounds.Sfx:FindFirstChild("Cupids Machine");
							local v186 = l_FirstChild_0 and l_FirstChild_0:FindFirstChild(v179);
							if v186 then
								v13:PlaySound(v186, l_CupidsMachine_2:GetPivot().Position);
							end;
						end);
						local v187 = v179 == "Success" and 7.5 or 4.7;
						local l_ResultText_0 = l_CupidsMachine_2:FindFirstChild("ResultText");
						if l_ResultText_0 then
							local l_Fail_1 = l_ResultText_0:FindFirstChild("Fail");
							local l_Match_1 = l_ResultText_0:FindFirstChild("Match");
							local l_Waiting_1 = l_ResultText_0:FindFirstChild("Waiting");
							local l_Matching_1 = l_ResultText_0:FindFirstChild("Matching");
							if l_Fail_1 and l_Match_1 and l_Waiting_1 then
								v128 = false;
								l_Fail_1.Enabled = false;
								l_Match_1.Enabled = false;
								l_Waiting_1.Enabled = false;
								l_Matching_1.Enabled = false;
								task.delay(4.6, function() --[[ Line: 702 ]]
									-- upvalues: l_Fail_1 (copy), v171 (copy), l_Match_1 (copy), v128 (ref), v135 (ref)
									l_Fail_1.Enabled = not v171;
									l_Match_1.Enabled = v171 ~= nil;
									task.delay(3, function() --[[ Line: 706 ]]
										-- upvalues: v128 (ref), v135 (ref)
										v128 = true;
										v135();
									end);
								end);
							end;
						end;
						task.delay(v187, function() --[[ Line: 714 ]]
							-- upvalues: l_AnimatedMesh_0 (copy)
							for _, v194 in l_AnimatedMesh_0:GetDescendants() do
								if v194:IsA("Trail") then
									v194.Enabled = true;
								end;
							end;
						end);
						task.delay(v187, function() --[[ Line: 722 ]]
							-- upvalues: v77 (ref), v161 (ref)
							v77 = false;
							v161();
						end);
						return;
					end;
				end;
			end;
		end;
	end);
	v41 = v29:InvokeServer() or v41;
	v169.OnRecipeChanged:Fire(v41);
	v4:WaitAndCall(l_LocalPlayer_0, function(v195) --[[ Line: 733 ]]
		-- upvalues: v161 (ref)
		local function v196() --[[ Line: 734 ]] --[[ Name: update ]]
			-- upvalues: v161 (ref)
			task.spawn(v161);
		end;
		v195:OnChanged("CupidsMachine", v196);
		v195:OnChanged("CupidsMachine.Brainrot", v196);
		v195:OnChanged("CupidsMachine.StartTime", v196);
		v195:OnChanged("CupidsMachine.FinishTime", v196);
		v195:OnChanged("AnimalAddedOrRemoved", v196);
		task.spawn(v196);
	end);
	v9.Simple(1, function() --[[ Line: 747 ]]
		-- upvalues: v168 (ref), v99 (ref)
		v168();
		v99();
	end);
	v5.observeTag("CupidsMachinePrompt", function(v197) --[[ Line: 752 ]]
		-- upvalues: v8 (ref), v4 (ref), l_LocalPlayer_0 (ref), v77 (ref), v9 (ref), v25 (ref), v26 (ref), v30 (ref), v12 (ref)
		local v198 = v8.new();
		local function v204() --[[ Line: 755 ]] --[[ Name: updatePrompt ]]
			-- upvalues: v4 (ref), l_LocalPlayer_0 (ref), v77 (ref), v197 (copy)
			local v199 = v4:Wait(l_LocalPlayer_0);
			if not v199 then
				return;
			else
				local v200 = v199:Get("CupidsMachine.StartTime");
				local v201 = v199:Get("CupidsMachine.FinishTime");
				local v202 = v201 and v201 ~= 0 and v201 <= workspace:GetServerTimeNow();
				local v203 = v200 and v200 ~= 0 and not v202;
				if v77 then
					v197.Enabled = false;
					return;
				elseif v202 then
					v197.Enabled = true;
					v197.ActionText = "Claim";
					return;
				elseif v203 then
					v197.Enabled = true;
					if (v199:Get("CupidsMachine.InstantSkips") or 0) >= 1 then
						v197.ActionText = "Reveal Now (FREE)";
						return;
					else
						v197.ActionText = "Reveal Now";
						return;
					end;
				else
					v197.Enabled = true;
					v197.ActionText = "Cupid's Machine";
					return;
				end;
			end;
		end;
		v198:Add(task.spawn(function() --[[ Line: 784 ]]
			-- upvalues: v4 (ref), l_LocalPlayer_0 (ref), v204 (copy), v198 (copy), v9 (ref)
			local v205 = v4:Wait(l_LocalPlayer_0);
			if not v205 then
				return;
			else
				v205:OnChanged("CupidsMachine.Brainrot", v204);
				v205:OnChanged("CupidsMachine.StartTime", v204);
				v205:OnChanged("CupidsMachine.FinishTime", v204);
				v198:Add(v9.Simple(1, v204));
				task.spawn(v204);
				return;
			end;
		end));
		v198:Add(v197.Triggered:Connect(function() --[[ Line: 797 ]]
			-- upvalues: v77 (ref), v4 (ref), l_LocalPlayer_0 (ref), v25 (ref), v26 (ref), v30 (ref), v12 (ref)
			if v77 then
				return;
			else
				local v206 = v4:Get(l_LocalPlayer_0);
				if not v206 then
					return;
				else
					local v207 = v206:Get("CupidsMachine.StartTime");
					local v208 = v206:Get("CupidsMachine.FinishTime");
					if v208 and v208 ~= 0 and v208 <= workspace:GetServerTimeNow() then
						v25:FireServer();
						return;
					elseif v207 and v207 ~= 0 then
						if (v206:Get("CupidsMachine.InstantSkips") or 0) >= 1 then
							v26:FireServer();
							return;
						else
							v30:FireServer(3532165598);
							return;
						end;
					else
						v12:Toggle("CupidsMachine");
						return;
					end;
				end;
			end;
		end));
		return function() --[[ Line: 822 ]]
			-- upvalues: v198 (copy)
			v198:Destroy();
		end;
	end);
	v5.observeTag("CupidsMachineTimerLabel", function(v209) --[[ Line: 827 ]]
		-- upvalues: v8 (ref), v4 (ref), l_LocalPlayer_0 (ref), v17 (ref), v41 (ref), v58 (ref), v9 (ref)
		local v210 = v8.new();
		local function v219() --[[ Line: 830 ]] --[[ Name: updateTimerLabel ]]
			-- upvalues: v4 (ref), l_LocalPlayer_0 (ref), v209 (copy), v17 (ref), v41 (ref), v58 (ref)
			local v211 = v4:Get(l_LocalPlayer_0);
			if not v211 then
				v209.Text = "";
				return;
			else
				local l_workspace_ServerTimeNow_2 = workspace:GetServerTimeNow();
				local v213 = v211:Get("CupidsMachine.StartTime");
				local v214 = v211:Get("CupidsMachine.FinishTime");
				local v215 = v214 and v214 ~= 0 and v214 <= l_workspace_ServerTimeNow_2;
				local v216 = v213 and v213 ~= 0 and not v215;
				if v215 then
					v209.Text = "READY";
					return;
				elseif v216 then
					local v217 = math.max((v214 or 0) - l_workspace_ServerTimeNow_2, 0);
					v209.Text = v17:E(v217);
					return;
				else
					local _ = math.max((v41 and v41.Refresh or 0) - l_workspace_ServerTimeNow_2, 0);
					v209.Text = ("%*/2"):format(#v58(v211:Get("AnimalPodiums")));
					return;
				end;
			end;
		end;
		v210:Add(task.spawn(function() --[[ Line: 856 ]]
			-- upvalues: v4 (ref), l_LocalPlayer_0 (ref), v219 (copy), v210 (copy), v9 (ref)
			local v220 = v4:Wait(l_LocalPlayer_0);
			if not v220 then
				return;
			else
				v220:OnChanged("CupidsMachine.Brainrot", v219);
				v220:OnChanged("CupidsMachine.StartTime", v219);
				v220:OnChanged("CupidsMachine.FinishTime", v219);
				v220:OnChanged("AnimalPodiums", v219);
				v220:OnChanged("AnimalAddedOrRemoved", v219);
				v210:Add(v9.Simple(1, v219));
				task.spawn(v219);
				return;
			end;
		end));
		return function() --[[ Line: 871 ]]
			-- upvalues: v210 (copy)
			v210:Destroy();
		end;
	end);
	local function _(v221, v222) --[[ Line: 876 ]] --[[ Name: observeBrainrotStatus ]]
		-- upvalues: v5 (ref), v8 (ref), v4 (ref), l_LocalPlayer_0 (ref), v41 (ref), v58 (ref), v9 (ref)
		v5.observeTag(v221, function(v223) --[[ Line: 877 ]]
			-- upvalues: v8 (ref), v4 (ref), l_LocalPlayer_0 (ref), v41 (ref), v222 (copy), v58 (ref), v9 (ref)
			local v224 = v8.new();
			local function v230() --[[ Line: 880 ]] --[[ Name: updateStatus ]]
				-- upvalues: v4 (ref), l_LocalPlayer_0 (ref), v223 (copy), v41 (ref), v222 (ref), v58 (ref)
				local v225 = v4:Get(l_LocalPlayer_0);
				if not v225 then
					v223.Text = "ADD BRAINROT...";
					return;
				else
					local v226 = v41 and v41.Recipe;
					local v227 = v226 and v226.Recipe[v222] or nil;
					if not v227 then
						v223.Text = "ADD BRAINROT...";
						return;
					else
						local v228 = v225:Get("CupidsMachine");
						local v229 = v228 and v228.StartTime and v228.StartTime ~= 0;
						v223.Text = if not (#v58(v227, v229) > 0) or v229 then v229 and "MATCHING..." or "ADD BRAINROT..." else "WAITING...";
						return;
					end;
				end;
			end;
			v224:Add(task.spawn(function() --[[ Line: 900 ]]
				-- upvalues: v4 (ref), l_LocalPlayer_0 (ref), v230 (copy), v224 (copy), v9 (ref)
				local v231 = v4:Wait(l_LocalPlayer_0);
				if not v231 then
					return;
				else
					v231:OnChanged("CupidsMachine.Brainrot", v230);
					v231:OnChanged("CupidsMachine.StartTime", v230);
					v231:OnChanged("CupidsMachine.FinishTime", v230);
					v231:OnChanged("AnimalPodiums", v230);
					v231:OnChanged("AnimalAddedOrRemoved", v230);
					v224:Add(v9.Simple(1, v230));
					task.spawn(v230);
					return;
				end;
			end));
			return function() --[[ Line: 915 ]]
				-- upvalues: v224 (copy)
				v224:Destroy();
			end;
		end);
	end;
	local l_observeTag_0 = v5.observeTag;
	local v234 = "CupidsMachineLeftBrainrotStatus";
	local v235 = 1;
	local l_v235_0 = v235 --[[ copy: 5 -> 6 ]];
	l_observeTag_0(v234, function(v237) --[[ Line: 877 ]]
		-- upvalues: v8 (ref), v4 (ref), l_LocalPlayer_0 (ref), v41 (ref), l_v235_0 (copy), v58 (ref), v9 (ref)
		local v238 = v8.new();
		local function v244() --[[ Line: 880 ]] --[[ Name: updateStatus ]]
			-- upvalues: v4 (ref), l_LocalPlayer_0 (ref), v237 (copy), v41 (ref), l_v235_0 (ref), v58 (ref)
			local v239 = v4:Get(l_LocalPlayer_0);
			if not v239 then
				v237.Text = "ADD BRAINROT...";
				return;
			else
				local v240 = v41 and v41.Recipe;
				local v241 = v240 and v240.Recipe[l_v235_0] or nil;
				if not v241 then
					v237.Text = "ADD BRAINROT...";
					return;
				else
					local v242 = v239:Get("CupidsMachine");
					local v243 = v242 and v242.StartTime and v242.StartTime ~= 0;
					v237.Text = if not (#v58(v241, v243) > 0) or v243 then v243 and "MATCHING..." or "ADD BRAINROT..." else "WAITING...";
					return;
				end;
			end;
		end;
		v238:Add(task.spawn(function() --[[ Line: 900 ]]
			-- upvalues: v4 (ref), l_LocalPlayer_0 (ref), v244 (copy), v238 (copy), v9 (ref)
			local v245 = v4:Wait(l_LocalPlayer_0);
			if not v245 then
				return;
			else
				v245:OnChanged("CupidsMachine.Brainrot", v244);
				v245:OnChanged("CupidsMachine.StartTime", v244);
				v245:OnChanged("CupidsMachine.FinishTime", v244);
				v245:OnChanged("AnimalPodiums", v244);
				v245:OnChanged("AnimalAddedOrRemoved", v244);
				v238:Add(v9.Simple(1, v244));
				task.spawn(v244);
				return;
			end;
		end));
		return function() --[[ Line: 915 ]]
			-- upvalues: v238 (copy)
			v238:Destroy();
		end;
	end);
	l_observeTag_0 = v5.observeTag;
	v234 = "CupidsMachineRightBrainrotStatus";
	v235 = 2;
	l_observeTag_0(v234, function(v246) --[[ Line: 877 ]]
		-- upvalues: v8 (ref), v4 (ref), l_LocalPlayer_0 (ref), v41 (ref), v235 (copy), v58 (ref), v9 (ref)
		local v247 = v8.new();
		local function v253() --[[ Line: 880 ]] --[[ Name: updateStatus ]]
			-- upvalues: v4 (ref), l_LocalPlayer_0 (ref), v246 (copy), v41 (ref), v235 (ref), v58 (ref)
			local v248 = v4:Get(l_LocalPlayer_0);
			if not v248 then
				v246.Text = "ADD BRAINROT...";
				return;
			else
				local v249 = v41 and v41.Recipe;
				local v250 = v249 and v249.Recipe[v235] or nil;
				if not v250 then
					v246.Text = "ADD BRAINROT...";
					return;
				else
					local v251 = v248:Get("CupidsMachine");
					local v252 = v251 and v251.StartTime and v251.StartTime ~= 0;
					v246.Text = if not (#v58(v250, v252) > 0) or v252 then v252 and "MATCHING..." or "ADD BRAINROT..." else "WAITING...";
					return;
				end;
			end;
		end;
		v247:Add(task.spawn(function() --[[ Line: 900 ]]
			-- upvalues: v4 (ref), l_LocalPlayer_0 (ref), v253 (copy), v247 (copy), v9 (ref)
			local v254 = v4:Wait(l_LocalPlayer_0);
			if not v254 then
				return;
			else
				v254:OnChanged("CupidsMachine.Brainrot", v253);
				v254:OnChanged("CupidsMachine.StartTime", v253);
				v254:OnChanged("CupidsMachine.FinishTime", v253);
				v254:OnChanged("AnimalPodiums", v253);
				v254:OnChanged("AnimalAddedOrRemoved", v253);
				v247:Add(v9.Simple(1, v253));
				task.spawn(v253);
				return;
			end;
		end));
		return function() --[[ Line: 915 ]]
			-- upvalues: v247 (copy)
			v247:Destroy();
		end;
	end);
	v5.observeTag("CupidsMachine", function(v255) --[[ Line: 924 ]]
		-- upvalues: v8 (ref), l_Players_0 (ref), l_LocalPlayer_0 (ref), v27 (ref), v13 (ref), l_ReplicatedStorage_0 (ref), v161 (ref)
		local v256 = v8.new();
		local l_AnimatedMesh_1 = v255:FindFirstChild("AnimatedMesh");
		local v258 = l_AnimatedMesh_1 and l_AnimatedMesh_1:FindFirstChildWhichIsA("AnimationController");
		local v259 = v258 and v258:FindFirstChildWhichIsA("Animator");
		if l_AnimatedMesh_1 and v258 and v259 then
			local l_Idle_0 = l_AnimatedMesh_1:FindFirstChild("Idle");
			if l_Idle_0 and l_Idle_0:IsA("Animation") then
				local v261 = v259:LoadAnimation(l_Idle_0);
				v261.Priority = Enum.AnimationPriority.Idle;
				v261.Looped = true;
				v261:Play();
				v256:Add(function() --[[ Line: 937 ]]
					-- upvalues: v261 (copy)
					v261:Stop();
					v261:Destroy();
				end);
			end;
		end;
		local l_DeliveryHitbox_0 = v255:FindFirstChild("DeliveryHitbox");
		if l_DeliveryHitbox_0 and l_DeliveryHitbox_0:IsA("BasePart") then
			v256:Add(l_DeliveryHitbox_0.Touched:Connect(function(v263) --[[ Line: 947 ]]
				-- upvalues: l_Players_0 (ref), l_LocalPlayer_0 (ref), v27 (ref), l_DeliveryHitbox_0 (copy), v13 (ref), l_ReplicatedStorage_0 (ref), v161 (ref)
				if v263.Name ~= "HumanoidRootPart" then
					return;
				else
					local l_l_Players_0_PlayerFromCharacter_0 = l_Players_0:GetPlayerFromCharacter(v263.Parent);
					if not l_l_Players_0_PlayerFromCharacter_0 or l_l_Players_0_PlayerFromCharacter_0 ~= l_LocalPlayer_0 then
						return;
					else
						if l_l_Players_0_PlayerFromCharacter_0:GetAttribute("StealingIndex") then
							if not v27:InvokeServer(l_DeliveryHitbox_0) then
								return;
							else
								task.spawn(function() --[[ Line: 964 ]]
									-- upvalues: v13 (ref), l_ReplicatedStorage_0 (ref)
									v13:PlaySound(l_ReplicatedStorage_0.Sounds.Sfx["Fuse Machine"].Deposit);
								end);
								task.spawn(v161);
							end;
						end;
						return;
					end;
				end;
			end));
		end;
		return function() --[[ Line: 973 ]]
			-- upvalues: v256 (copy)
			v256:Destroy();
		end;
	end);
end;
return v43;