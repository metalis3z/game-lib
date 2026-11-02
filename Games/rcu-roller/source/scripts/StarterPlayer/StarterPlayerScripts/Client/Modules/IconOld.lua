-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw


-- Decompiler will be improved VERY SOON!

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)

-- Decompiled on 2025-03-27 06:21:21

-- Luau version 6, Types version 3

-- Time taken: 0.080249 seconds


local TweenService_upvr = game:GetService("TweenService")

local UserInputService_upvr = game:GetService("UserInputService")

local TextService_upvr = game:GetService("TextService")

local IconController_upvr = require(script.IconController)

local Signal_upvr = require(script.Signal)

local Maid_upvr = require(script.Maid)

local TopbarPlusGui_upvr = require(script.TopbarPlusGui)

local ActiveItems_upvr = TopbarPlusGui_upvr.ActiveItems

local TopbarContainer_upvr = TopbarPlusGui_upvr.TopbarContainer

local tbl_4_upvr = {}

local module_upvr = {}

module_upvr.__index = module_upvr

local IconContainer_upvr = TopbarContainer_upvr.IconContainer

local StarterGui_upvr = game:GetService("StarterGui")

local Default_upvr = require(script.Themes).Default

local RunService_upvr = game:GetService("RunService")

function module_upvr.new() -- Line 605

	--[[ Upvalues[12]:

		[1]: module_upvr (readonly)

		[2]: Maid_upvr (readonly)

		[3]: IconContainer_upvr (readonly)

		[4]: TopbarContainer_upvr (readonly)

		[5]: tbl_4_upvr (readonly)

		[6]: StarterGui_upvr (readonly)

		[7]: IconController_upvr (readonly)

		[8]: TweenService_upvr (readonly)

		[9]: Signal_upvr (readonly)

		[10]: Default_upvr (readonly)

		[11]: UserInputService_upvr (readonly)

		[12]: RunService_upvr (readonly)

	]]

	local module_upvr_2 = {}

	setmetatable(module_upvr_2, module_upvr)

	local any_new_result1_5 = Maid_upvr.new()

	module_upvr_2._maid = any_new_result1_5

	module_upvr_2._hoveringMaid = any_new_result1_5:give(Maid_upvr.new())

	module_upvr_2._dropdownClippingMaid = any_new_result1_5:give(Maid_upvr.new())

	module_upvr_2._menuClippingMaid = any_new_result1_5:give(Maid_upvr.new())

	local tbl_16_upvr = {}

	module_upvr_2.instances = tbl_16_upvr

	local any_give_result1 = any_new_result1_5:give(IconContainer_upvr:Clone())

	any_give_result1.Visible = true

	any_give_result1.Parent = TopbarContainer_upvr

	tbl_16_upvr.iconContainer = any_give_result1

	tbl_16_upvr.iconButton = any_give_result1.IconButton

	tbl_16_upvr.iconImage = tbl_16_upvr.iconButton.IconImage

	tbl_16_upvr.iconLabel = tbl_16_upvr.iconButton.IconLabel

	tbl_16_upvr.iconGradient = tbl_16_upvr.iconButton.IconGradient

	tbl_16_upvr.iconCorner = tbl_16_upvr.iconButton.IconCorner

	tbl_16_upvr.iconOverlay = any_give_result1.IconOverlay

	tbl_16_upvr.iconOverlayCorner = tbl_16_upvr.iconOverlay.IconOverlayCorner

	tbl_16_upvr.noticeFrame = tbl_16_upvr.iconButton.NoticeFrame

	tbl_16_upvr.noticeLabel = tbl_16_upvr.noticeFrame.NoticeLabel

	tbl_16_upvr.captionContainer = any_give_result1.CaptionContainer

	tbl_16_upvr.captionFrame = tbl_16_upvr.captionContainer.CaptionFrame

	tbl_16_upvr.captionLabel = tbl_16_upvr.captionContainer.CaptionLabel

	tbl_16_upvr.captionCorner = tbl_16_upvr.captionFrame.CaptionCorner

	tbl_16_upvr.captionOverlineContainer = tbl_16_upvr.captionContainer.CaptionOverlineContainer

	tbl_16_upvr.captionOverline = tbl_16_upvr.captionOverlineContainer.CaptionOverline

	tbl_16_upvr.captionOverlineCorner = tbl_16_upvr.captionOverline.CaptionOverlineCorner

	tbl_16_upvr.captionVisibilityBlocker = tbl_16_upvr.captionFrame.CaptionVisibilityBlocker

	tbl_16_upvr.captionVisibilityCorner = tbl_16_upvr.captionVisibilityBlocker.CaptionVisibilityCorner

	tbl_16_upvr.tipFrame = any_give_result1.TipFrame

	tbl_16_upvr.tipLabel = tbl_16_upvr.tipFrame.TipLabel

	tbl_16_upvr.tipCorner = tbl_16_upvr.tipFrame.TipCorner

	tbl_16_upvr.dropdownContainer = any_give_result1.DropdownContainer

	tbl_16_upvr.dropdownFrame = tbl_16_upvr.dropdownContainer.DropdownFrame

	tbl_16_upvr.dropdownList = tbl_16_upvr.dropdownFrame.DropdownList

	tbl_16_upvr.menuContainer = any_give_result1.MenuContainer

	tbl_16_upvr.menuFrame = tbl_16_upvr.menuContainer.MenuFrame

	tbl_16_upvr.menuList = tbl_16_upvr.menuFrame.MenuList

	tbl_16_upvr.clickSound = any_give_result1.ClickSound

	module_upvr_2._settings = {

		action = {

			toggleTransitionInfo = {};

			resizeInfo = {};

			repositionInfo = {};

			captionFadeInfo = {};

			tipFadeInfo = {};

			dropdownSlideInfo = {};

			menuSlideInfo = {};

		};

		toggleable = {

			iconBackgroundColor = {

				instanceNames = {"iconButton"};

				propertyName = "BackgroundColor3";

			};

			iconBackgroundTransparency = {

				instanceNames = {"iconButton"};

				propertyName = "BackgroundTransparency";

			};

			iconCornerRadius = {

				instanceNames = {"iconCorner", "iconOverlayCorner"};

				propertyName = "CornerRadius";

			};

			iconGradientColor = {

				instanceNames = {"iconGradient"};

				propertyName = "Color";

			};

			iconGradientRotation = {

				instanceNames = {"iconGradient"};

				propertyName = "Rotation";

			};

			iconImage = {

				callMethods = {module_upvr_2._updateIconSize};

				instanceNames = {"iconImage"};

				propertyName = "Image";

			};

			iconImageColor = {

				instanceNames = {"iconImage"};

				propertyName = "ImageColor3";

			};

			iconImageTransparency = {

				instanceNames = {"iconImage"};

				propertyName = "ImageTransparency";

			};

			iconScale = {

				instanceNames = {"iconButton"};

				propertyName = "Size";

			};

			forcedIconSize = {};

			iconSize = {

				callSignals = {module_upvr_2.updated};

				callMethods = {module_upvr_2._updateIconSize};

				instanceNames = {"iconContainer"};

				propertyName = "Size";

				tweenAction = "resizeInfo";

			};

			iconOffset = {

				instanceNames = {"iconButton"};

				propertyName = "Position";

			};

			iconText = {

				callMethods = {module_upvr_2._updateIconSize};

				instanceNames = {"iconLabel"};

				propertyName = "Text";

			};

			iconTextColor = {

				instanceNames = {"iconLabel"};

				propertyName = "TextColor3";

			};

			iconFont = {

				instanceNames = {"iconLabel"};

				propertyName = "Font";

			};

			iconImageYScale = {

				callMethods = {module_upvr_2._updateIconSize};

			};

			iconImageRatio = {

				callMethods = {module_upvr_2._updateIconSize};

			};

			iconLabelYScale = {

				callMethods = {module_upvr_2._updateIconSize};

			};

			noticeCircleColor = {

				instanceNames = {"noticeFrame"};

				propertyName = "ImageColor3";

			};

			noticeCircleImage = {

				instanceNames = {"noticeFrame"};

				propertyName = "Image";

			};

			noticeTextColor = {

				instanceNames = {"noticeLabel"};

				propertyName = "TextColor3";

			};

			noticeImageTransparency = {

				instanceNames = {"noticeFrame"};

				propertyName = "ImageTransparency";

			};

			noticeTextTransparency = {

				instanceNames = {"noticeLabel"};

				propertyName = "TextTransparency";

			};

			baseZIndex = {

				callMethods = {module_upvr_2._updateBaseZIndex};

			};

			order = {

				callSignals = {module_upvr_2.updated};

				instanceNames = {"iconContainer"};

				propertyName = "LayoutOrder";

			};

			alignment = {

				callSignals = {module_upvr_2.updated};

				callMethods = {module_upvr_2._updateDropdown};

			};

			iconImageVisible = {

				instanceNames = {"iconImage"};

				propertyName = "Visible";

			};

			iconImageAnchorPoint = {

				instanceNames = {"iconImage"};

				propertyName = "AnchorPoint";

			};

			iconImagePosition = {

				instanceNames = {"iconImage"};

				propertyName = "Position";

				tweenAction = "resizeInfo";

			};

			iconImageSize = {

				instanceNames = {"iconImage"};

				propertyName = "Size";

				tweenAction = "resizeInfo";

			};

			iconImageTextXAlignment = {

				instanceNames = {"iconImage"};

				propertyName = "TextXAlignment";

			};

			iconLabelVisible = {

				instanceNames = {"iconLabel"};

				propertyName = "Visible";

			};

			iconLabelAnchorPoint = {

				instanceNames = {"iconLabel"};

				propertyName = "AnchorPoint";

			};

			iconLabelPosition = {

				instanceNames = {"iconLabel"};

				propertyName = "Position";

				tweenAction = "resizeInfo";

			};

			iconLabelSize = {

				instanceNames = {"iconLabel"};

				propertyName = "Size";

				tweenAction = "resizeInfo";

			};

			iconLabelTextXAlignment = {

				instanceNames = {"iconLabel"};

				propertyName = "TextXAlignment";

			};

			iconLabelTextSize = {

				instanceNames = {"iconLabel"};

				propertyName = "TextSize";

			};

			noticeFramePosition = {

				instanceNames = {"noticeFrame"};

				propertyName = "Position";

			};

			clickSoundId = {

				instanceNames = {"clickSound"};

				propertyName = "SoundId";

			};

			clickVolume = {

				instanceNames = {"clickSound"};

				propertyName = "Volume";

			};

			clickPlaybackSpeed = {

				instanceNames = {"clickSound"};

				propertyName = "PlaybackSpeed";

			};

			clickTimePosition = {

				instanceNames = {"clickSound"};

				propertyName = "TimePosition";

			};

		};

		other = {

			captionBackgroundColor = {

				instanceNames = {"captionFrame"};

				propertyName = "BackgroundColor3";

			};

			captionBackgroundTransparency = {

				instanceNames = {"captionFrame"};

				propertyName = "BackgroundTransparency";

				group = "caption";

			};

			captionBlockerTransparency = {

				instanceNames = {"captionVisibilityBlocker"};

				propertyName = "BackgroundTransparency";

				group = "caption";

			};

			captionOverlineColor = {

				instanceNames = {"captionOverline"};

				propertyName = "BackgroundColor3";

			};

			captionOverlineTransparency = {

				instanceNames = {"captionOverline"};

				propertyName = "BackgroundTransparency";

				group = "caption";

			};

			captionTextColor = {

				instanceNames = {"captionLabel"};

				propertyName = "TextColor3";

			};

			captionTextTransparency = {

				instanceNames = {"captionLabel"};

				propertyName = "TextTransparency";

				group = "caption";

			};

			captionFont = {

				instanceNames = {"captionLabel"};

				propertyName = "Font";

			};

			captionCornerRadius = {

				instanceNames = {"captionCorner", "captionOverlineCorner", "captionVisibilityCorner"};

				propertyName = "CornerRadius";

			};

			tipBackgroundColor = {

				instanceNames = {"tipFrame"};

				propertyName = "BackgroundColor3";

			};

			tipBackgroundTransparency = {

				instanceNames = {"tipFrame"};

				propertyName = "BackgroundTransparency";

				group = "tip";

			};

			tipTextColor = {

				instanceNames = {"tipLabel"};

				propertyName = "TextColor3";

			};

			tipTextTransparency = {

				instanceNames = {"tipLabel"};

				propertyName = "TextTransparency";

				group = "tip";

			};

			tipFont = {

				instanceNames = {"tipLabel"};

				propertyName = "Font";

			};

			tipCornerRadius = {

				instanceNames = {"tipCorner"};

				propertyName = "CornerRadius";

			};

			dropdownSize = {

				instanceNames = {"dropdownContainer"};

				propertyName = "Size";

				unique = "dropdown";

			};

			dropdownCanvasSize = {

				instanceNames = {"dropdownFrame"};

				propertyName = "CanvasSize";

			};

			dropdownMaxIconsBeforeScroll = {

				callMethods = {module_upvr_2._updateDropdown};

			};

			dropdownMinWidth = {

				callMethods = {module_upvr_2._updateDropdown};

			};

			dropdownSquareCorners = {

				callMethods = {module_upvr_2._updateDropdown};

			};

			dropdownBindToggleToIcon = {};

			dropdownToggleOnLongPress = {};

			dropdownToggleOnRightClick = {};

			dropdownCloseOnTapAway = {};

			dropdownHidePlayerlistOnOverlap = {};

			dropdownListPadding = {

				callMethods = {module_upvr_2._updateDropdown};

				instanceNames = {"dropdownList"};

				propertyName = "Padding";

			};

			dropdownAlignment = {

				callMethods = {module_upvr_2._updateDropdown};

			};

			dropdownScrollBarColor = {

				instanceNames = {"dropdownFrame"};

				propertyName = "ScrollBarImageColor3";

			};

			dropdownScrollBarTransparency = {

				instanceNames = {"dropdownFrame"};

				propertyName = "ScrollBarImageTransparency";

			};

			dropdownScrollBarThickness = {

				instanceNames = {"dropdownFrame"};

				propertyName = "ScrollBarThickness";

			};

			dropdownIgnoreClipping = {

				callMethods = {module_upvr_2._dropdownIgnoreClipping};

			};

			menuSize = {

				instanceNames = {"menuContainer"};

				propertyName = "Size";

				unique = "menu";

			};

			menuCanvasSize = {

				instanceNames = {"menuFrame"};

				propertyName = "CanvasSize";

			};

			menuMaxIconsBeforeScroll = {

				callMethods = {module_upvr_2._updateMenu};

			};

			menuBindToggleToIcon = {};

			menuToggleOnLongPress = {};

			menuToggleOnRightClick = {};

			menuCloseOnTapAway = {};

			menuListPadding = {

				callMethods = {module_upvr_2._updateMenu};

				instanceNames = {"menuList"};

				propertyName = "Padding";

			};

			menuDirection = {

				callMethods = {module_upvr_2._updateMenu};

			};

			menuScrollBarColor = {

				instanceNames = {"menuFrame"};

				propertyName = "ScrollBarImageColor3";

			};

			menuScrollBarTransparency = {

				instanceNames = {"menuFrame"};

				propertyName = "ScrollBarImageTransparency";

			};

			menuScrollBarThickness = {

				instanceNames = {"menuFrame"};

				propertyName = "ScrollBarThickness";

			};

			menuIgnoreClipping = {

				callMethods = {module_upvr_2._menuIgnoreClipping};

			};

		};

	}

	module_upvr_2._groupSettings = {}

	for _, v in pairs(module_upvr_2._settings) do

		for i_2, v_2 in pairs(v) do

			local group = v_2.group

			if group then

				local var207 = module_upvr_2._groupSettings[group]

				if not var207 then

					var207 = {}

					module_upvr_2._groupSettings[group] = var207

				end

				table.insert(var207, i_2)

				v_2.forcedGroupValue = tbl_4_upvr[group]

				v_2.useForcedGroupValue = true

			end

		end

	end

	module_upvr_2._settingsDictionary = {}

	module_upvr_2._uniqueSettings = {}

	module_upvr_2._uniqueSettingsDictionary = {}

	module_upvr_2.uniqueValues = {}

	for i_3, v_3 in pairs(module_upvr_2._settings) do

		for i_4, v_4 in pairs(v_3) do

			if i_3 == "toggleable" then

				if not v_4.values then

				end

				v_4.values = {

					deselected = nil;

					selected = nil;

				}

			else

				v_4.value = nil

			end

			v_4.additionalValues = {}

			v_4.type = i_3

			module_upvr_2._settingsDictionary[i_4] = v_4

			local unique = v_4.unique

			if unique then

				local var259 = module_upvr_2._uniqueSettings[unique]

				if not var259 then

					var259 = {}

				end

				table.insert(var259, i_4)

				module_upvr_2._uniqueSettings[unique] = var259

				module_upvr_2._uniqueSettingsDictionary[i_4] = ({

					dropdown = function(arg1, arg2, arg3, arg4) -- Line 783

						--[[ Upvalues[4]:

							[1]: module_upvr_2 (readonly)

							[2]: StarterGui_upvr (copied, readonly)

							[3]: IconController_upvr (copied, readonly)

							[4]: TweenService_upvr (copied, readonly)

						]]

						-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

						local var221

						if module_upvr_2:get("dropdownHidePlayerlistOnOverlap") == true then

							if module_upvr_2:get("alignment") ~= "right" then

							else

							end

						end

						var221 = not module_upvr_2.isSelected

						if module_upvr_2:get("dropdownBindToggleToIcon") == false then

							var221 = not module_upvr_2.dropdownOpen

						end

						if not module_upvr_2._longPressing then

							local _rightClicking_2 = module_upvr_2._rightClicking

						end

						local var223

						local function INLINED_4() -- Internal function, doesn't exist in bytecode

							var223 = module_upvr_2

							return var223.dropdownOpen

						end

						if module_upvr_2._tappingAway or var221 and not _rightClicking_2 or _rightClicking_2 and INLINED_4() then

							local any_get_result1_9 = module_upvr_2:get("dropdownSize")

							local function INLINED_5() -- Internal function, doesn't exist in bytecode

								var223 = any_get_result1_9.X.Offset / 1

								return var223

							end

							if not any_get_result1_9 or not INLINED_5() then

								var223 = 0

							end

							local var225 = false

						end

						var223 = module_upvr_2.dropdownIcons

						var223 = 0

						if var223 < #var223 then

							local var226

							if var225 and true then

								if StarterGui_upvr:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList) then

									StarterGui_upvr:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)

								end

								local function INLINED_6() -- Internal function, doesn't exist in bytecode

									var226 = IconController_upvr._bringBackPlayerlist + 1

									return var226

								end

								if not IconController_upvr._bringBackPlayerlist or not INLINED_6() then

									var226 = 1

								end

								IconController_upvr._bringBackPlayerlist = var226

								var226 = true

								module_upvr_2._bringBackPlayerlist = var226

								-- KONSTANTWARNING: GOTO [166] #126

							end

						end

						if module_upvr_2._bringBackPlayerlist and not var225 then

							if IconController_upvr._bringBackPlayerlist then

								local var227 = IconController_upvr

								var227._bringBackPlayerlist -= 1

								if IconController_upvr._bringBackPlayerlist <= 0 then

									IconController_upvr._bringBackPlayerlist = nil

									StarterGui_upvr:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)

								end

								module_upvr_2._bringBackPlayerlist = nil

							end

						end

						local any_Create_result1_4 = TweenService_upvr:Create(arg2, module_upvr_2:get("dropdownSlideInfo"), {

							[arg3] = UDim2.new(0, var223, 0, 0);

						})

						local var231_upvw

						var231_upvw = any_Create_result1_4.Completed:Connect(function() -- Line 818

							--[[ Upvalues[1]:

								[1]: var231_upvw (read and write)

							]]

							var231_upvw:Disconnect()

						end)

						any_Create_result1_4:Play()

						if var225 then

							module_upvr_2.instances.dropdownFrame.CanvasPosition = module_upvr_2._dropdownCanvasPos

						else

							-- KONSTANTERROR: Expression was reused, decompilation is incorrect

							module_upvr_2._dropdownCanvasPos = module_upvr_2.instances.dropdownFrame.CanvasPosition

						end

						module_upvr_2.dropdownOpen = var225

						module_upvr_2:_decideToCallSignal("dropdown")

					end;

					menu = function(arg1, arg2, arg3, arg4) -- Line 831

						--[[ Upvalues[2]:

							[1]: module_upvr_2 (readonly)

							[2]: TweenService_upvr (copied, readonly)

						]]

						-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

						-- KONSTANTERROR: [0] 1. Error Block 39 start (CF ANALYSIS FAILED)

						local any_get_result1_4 = module_upvr_2:get("menuSlideInfo")

						local var243

						if module_upvr_2:get("menuBindToggleToIcon") == false then

							var243 = not module_upvr_2.menuOpen

						end

						if not module_upvr_2._longPressing then

							local _rightClicking = module_upvr_2._rightClicking

						end

						local var245_upvw

						local function INLINED_9() -- Internal function, doesn't exist in bytecode

							var245_upvw = module_upvr_2

							return var245_upvw.menuOpen

						end

						if module_upvr_2._tappingAway or var243 and not _rightClicking or _rightClicking and INLINED_9() then

							local any_get_result1_11 = module_upvr_2:get("menuSize")

							local function INLINED_10() -- Internal function, doesn't exist in bytecode

								var245_upvw = any_get_result1_11.Y.Offset / 1

								return var245_upvw

							end

							if not any_get_result1_11 or not INLINED_10() then

								var245_upvw = 0

							end

							local var247 = false

						end

						var245_upvw = module_upvr_2

						if var247 ~= var245_upvw.menuOpen then

							var245_upvw = module_upvr_2

							var245_upvw.updated:Fire()

						end

						if var247 then

							var245_upvw = Enum.EasingDirection.Out

							if any_get_result1_4.EasingDirection == var245_upvw then

								var245_upvw = any_get_result1_4.Time

							end

						end

						local any_Create_result1_3 = TweenService_upvr:Create(arg2, TweenInfo.new(var245_upvw, any_get_result1_4.EasingStyle, Enum.EasingDirection.In), {

							[arg3] = UDim2.new(0, 0, 0, var245_upvw);

						})

						var245_upvw = nil

						var245_upvw = any_Create_result1_3.Completed:Connect(function() -- Line 857

							--[[ Upvalues[1]:

								[1]: var245_upvw (read and write)

							]]

							var245_upvw:Disconnect()

						end)

						any_Create_result1_3:Play()

						if var247 then

							if module_upvr_2._menuCanvasPos then

								module_upvr_2.instances.menuFrame.CanvasPosition = module_upvr_2._menuCanvasPos

								-- KONSTANTWARNING: GOTO [137] #100

							end

						else

							-- KONSTANTERROR: Expression was reused, decompilation is incorrect

							module_upvr_2._menuCanvasPos = module_upvr_2.instances.menuFrame.CanvasPosition

						end

						-- KONSTANTERROR: [0] 1. Error Block 39 end (CF ANALYSIS FAILED)

						-- KONSTANTERROR: [137] 100. Error Block 26 start (CF ANALYSIS FAILED)

						module_upvr_2.menuOpen = var247

						module_upvr_2:_decideToCallSignal("menu")

						-- KONSTANTERROR: [137] 100. Error Block 26 end (CF ANALYSIS FAILED)

					end;

				})[unique]

			end

		end

	end

	module_upvr_2.updated = any_new_result1_5:give(Signal_upvr.new())

	module_upvr_2.selected = any_new_result1_5:give(Signal_upvr.new())

	module_upvr_2.deselected = any_new_result1_5:give(Signal_upvr.new())

	module_upvr_2.toggled = any_new_result1_5:give(Signal_upvr.new())

	module_upvr_2.hoverStarted = any_new_result1_5:give(Signal_upvr.new())

	module_upvr_2.hoverEnded = any_new_result1_5:give(Signal_upvr.new())

	module_upvr_2.dropdownOpened = any_new_result1_5:give(Signal_upvr.new())

	module_upvr_2.dropdownClosed = any_new_result1_5:give(Signal_upvr.new())

	module_upvr_2.menuOpened = any_new_result1_5:give(Signal_upvr.new())

	module_upvr_2.menuClosed = any_new_result1_5:give(Signal_upvr.new())

	module_upvr_2.notified = any_new_result1_5:give(Signal_upvr.new())

	module_upvr_2._endNotices = any_new_result1_5:give(Signal_upvr.new())

	module_upvr_2._ignoreClippingChanged = any_new_result1_5:give(Signal_upvr.new())

	local function setFeatureChange_upvr(arg1, arg2) -- Line 915, Named "setFeatureChange"

		--[[ Upvalues[1]:

			[1]: module_upvr_2 (readonly)

		]]

		local _parentIcon_2 = module_upvr_2._parentIcon

		module_upvr_2:set(arg1.."IgnoreClipping", arg2)

		if arg2 == true and _parentIcon_2 then

			local var263_upvw

			local any_Connect_result1_upvr = _parentIcon_2._ignoreClippingChanged:Connect(function(arg1_2, arg2_2) -- Line 919

				--[[ Upvalues[2]:

					[1]: module_upvr_2 (copied, readonly)

					[2]: arg1 (readonly)

				]]

				module_upvr_2:set(arg1.."IgnoreClipping", arg2_2)

			end)

			var263_upvw = module_upvr_2[arg1.."Closed"]:Connect(function() -- Line 923

				--[[ Upvalues[2]:

					[1]: var263_upvw (read and write)

					[2]: any_Connect_result1_upvr (readonly)

				]]

				var263_upvw:Disconnect()

				any_Connect_result1_upvr:Disconnect()

			end)

		end

	end

	module_upvr_2.dropdownOpened:Connect(function() -- Line 929

		--[[ Upvalues[1]:

			[1]: setFeatureChange_upvr (readonly)

		]]

		setFeatureChange_upvr("dropdown", true)

	end)

	module_upvr_2.dropdownClosed:Connect(function() -- Line 932

		--[[ Upvalues[1]:

			[1]: setFeatureChange_upvr (readonly)

		]]

		setFeatureChange_upvr("dropdown", false)

	end)

	module_upvr_2.menuOpened:Connect(function() -- Line 935

		--[[ Upvalues[1]:

			[1]: setFeatureChange_upvr (readonly)

		]]

		setFeatureChange_upvr("menu", true)

	end)

	module_upvr_2.menuClosed:Connect(function() -- Line 938

		--[[ Upvalues[1]:

			[1]: setFeatureChange_upvr (readonly)

		]]

		setFeatureChange_upvr("menu", false)

	end)

	module_upvr_2.deselectWhenOtherIconSelected = true

	module_upvr_2.name = ""

	module_upvr_2.isSelected = false

	module_upvr_2.presentOnTopbar = true

	module_upvr_2.accountForWhenDisabled = false

	module_upvr_2.enabled = true

	module_upvr_2.hovering = false

	module_upvr_2.tipText = nil

	module_upvr_2.captionText = nil

	module_upvr_2.totalNotices = 0

	module_upvr_2.notices = {}

	module_upvr_2.dropdownIcons = {}

	module_upvr_2.menuIcons = {}

	module_upvr_2.dropdownOpen = false

	module_upvr_2.menuOpen = false

	module_upvr_2.locked = false

	module_upvr_2.topPadding = UDim.new(0, 4)

	module_upvr_2.targetPosition = nil

	module_upvr_2.toggleItems = {}

	module_upvr_2.lockedSettings = {}

	module_upvr_2._draggingFinger = false

	module_upvr_2._updatingIconSize = true

	module_upvr_2._previousDropdownOpen = false

	module_upvr_2._previousMenuOpen = false

	module_upvr_2._bindedToggleKeys = {}

	module_upvr_2._bindedEvents = {}

	module_upvr_2:setName("UnnamedIcon")

	module_upvr_2:setTheme(Default_upvr, true)

	tbl_16_upvr.iconButton.MouseButton1Click:Connect(function() -- Line 988

		--[[ Upvalues[1]:

			[1]: module_upvr_2 (readonly)

		]]

		if module_upvr_2.isSelected then

			module_upvr_2:deselect()

			return true

		end

		module_upvr_2:select()

	end)

	tbl_16_upvr.iconButton.MouseButton2Click:Connect(function() -- Line 995

		--[[ Upvalues[1]:

			[1]: module_upvr_2 (readonly)

		]]

		module_upvr_2._rightClicking = true

		if module_upvr_2:get("dropdownToggleOnRightClick") == true then

			module_upvr_2:_update("dropdownSize")

		end

		if module_upvr_2:get("menuToggleOnRightClick") == true then

			module_upvr_2:_update("menuSize")

		end

		module_upvr_2._rightClicking = false

	end)

	tbl_16_upvr.iconButton.MouseButton1Down:Connect(function() -- Line 1007

		--[[ Upvalues[1]:

			[1]: module_upvr_2 (readonly)

		]]

		if module_upvr_2.locked then

		else

			module_upvr_2:_updateStateOverlay(0.7, Color3.new(0, 0, 0))

		end

	end)

	tbl_16_upvr.iconButton.MouseButton1Up:Connect(function() -- Line 1011

		--[[ Upvalues[1]:

			[1]: module_upvr_2 (readonly)

		]]

		if module_upvr_2.locked then

		else

			module_upvr_2:_updateStateOverlay(0.9, Color3.new(1, 1, 1))

		end

	end)

	UserInputService_upvr.InputBegan:Connect(function(arg1, arg2) -- Line 1017

		--[[ Upvalues[1]:

			[1]: module_upvr_2 (readonly)

		]]

		if not arg2 and ({

			[Enum.UserInputType.MouseButton1] = true;

			[Enum.UserInputType.MouseButton2] = true;

			[Enum.UserInputType.MouseButton3] = true;

			[Enum.UserInputType.Touch] = true;

		})[arg1.UserInputType] then

			module_upvr_2._tappingAway = true

			if module_upvr_2.dropdownOpen and module_upvr_2:get("dropdownCloseOnTapAway") == true then

				module_upvr_2:_update("dropdownSize")

			end

			if module_upvr_2.menuOpen and module_upvr_2:get("menuCloseOnTapAway") == true then

				module_upvr_2:_update("menuSize")

			end

			module_upvr_2._tappingAway = false

		end

		if module_upvr_2._bindedToggleKeys[arg1.KeyCode] and not arg2 then

			if module_upvr_2.isSelected then

				module_upvr_2:deselect()

				return

			end

			module_upvr_2:select()

		end

	end)

	module_upvr_2.hoverStarted:Connect(function(arg1, arg2) -- Line 1048

		--[[ Upvalues[1]:

			[1]: module_upvr_2 (readonly)

		]]

		module_upvr_2.hovering = true

		if not module_upvr_2.locked then

			module_upvr_2:_updateStateOverlay(0.9, Color3.fromRGB(255, 255, 255))

		end

		module_upvr_2:_updateHovering()

	end)

	module_upvr_2.hoverEnded:Connect(function() -- Line 1055

		--[[ Upvalues[1]:

			[1]: module_upvr_2 (readonly)

		]]

		module_upvr_2.hovering = false

		module_upvr_2:_updateStateOverlay(1)

		module_upvr_2._hoveringMaid:clean()

		module_upvr_2:_updateHovering()

	end)

	tbl_16_upvr.iconButton.MouseEnter:Connect(function(arg1, arg2) -- Line 1061

		--[[ Upvalues[1]:

			[1]: module_upvr_2 (readonly)

		]]

		module_upvr_2.hoverStarted:Fire(arg1, arg2)

	end)

	tbl_16_upvr.iconButton.MouseLeave:Connect(function() -- Line 1064

		--[[ Upvalues[1]:

			[1]: module_upvr_2 (readonly)

		]]

		module_upvr_2.hoverEnded:Fire()

	end)

	tbl_16_upvr.iconButton.SelectionGained:Connect(function() -- Line 1067

		--[[ Upvalues[1]:

			[1]: module_upvr_2 (readonly)

		]]

		module_upvr_2.hoverStarted:Fire()

	end)

	tbl_16_upvr.iconButton.SelectionLost:Connect(function() -- Line 1070

		--[[ Upvalues[1]:

			[1]: module_upvr_2 (readonly)

		]]

		module_upvr_2.hoverEnded:Fire()

	end)

	tbl_16_upvr.iconButton.MouseButton1Down:Connect(function() -- Line 1073

		--[[ Upvalues[3]:

			[1]: module_upvr_2 (readonly)

			[2]: RunService_upvr (copied, readonly)

			[3]: tbl_16_upvr (readonly)

		]]

		if module_upvr_2._draggingFinger then

			module_upvr_2.hoverStarted:Fire()

		end

		local var282_upvw

		local var284_upvr = tick() + 0.7

		local var285_upvw

		var285_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 1082

			--[[ Upvalues[4]:

				[1]: var284_upvr (readonly)

				[2]: var282_upvw (read and write)

				[3]: var285_upvw (read and write)

				[4]: module_upvr_2 (copied, readonly)

			]]

			if var284_upvr <= tick() then

				var282_upvw:Disconnect()

				var285_upvw:Disconnect()

				module_upvr_2._longPressing = true

				if module_upvr_2:get("dropdownToggleOnLongPress") == true then

					module_upvr_2:_update("dropdownSize")

				end

				if module_upvr_2:get("menuToggleOnLongPress") == true then

					module_upvr_2:_update("menuSize")

				end

				module_upvr_2._longPressing = false

			end

		end)

		var282_upvw = tbl_16_upvr.iconButton.MouseButton1Up:Connect(function() -- Line 1096

			--[[ Upvalues[2]:

				[1]: var282_upvw (read and write)

				[2]: var285_upvw (read and write)

			]]

			var282_upvw:Disconnect()

			var285_upvw:Disconnect()

		end)

	end)

	if UserInputService_upvr.TouchEnabled then

		tbl_16_upvr.iconButton.MouseButton1Up:Connect(function() -- Line 1102

			--[[ Upvalues[1]:

				[1]: module_upvr_2 (readonly)

			]]

			if module_upvr_2.hovering then

				module_upvr_2.hoverEnded:Fire()

			end

		end)

		UserInputService_upvr.TouchMoved:Connect(function(arg1, arg2) -- Line 1110

			--[[ Upvalues[1]:

				[1]: module_upvr_2 (readonly)

			]]

			if arg2 then

			else

				module_upvr_2._draggingFinger = true

			end

		end)

		UserInputService_upvr.TouchEnded:Connect(function() -- Line 1116

			--[[ Upvalues[1]:

				[1]: module_upvr_2 (readonly)

			]]

			module_upvr_2._draggingFinger = false

		end)

	end

	module_upvr_2._updatingIconSize = false

	module_upvr_2:_updateIconSize()

	IconController_upvr.iconAdded:Fire(module_upvr_2)

	return module_upvr_2

end

function module_upvr.mimic(arg1) -- Line 1130

	--[[ Upvalues[2]:

		[1]: IconController_upvr (readonly)

		[2]: module_upvr (readonly)

	]]

	local var290 = arg1.."Mimic"

	local any_getIcon_result1 = IconController_upvr.getIcon(var290)

	if any_getIcon_result1 then

		return any_getIcon_result1

	end

	local any_new_result1_2 = module_upvr.new()

	any_new_result1_2:setName(var290)

	if arg1 == "Chat" then

		any_new_result1_2:setOrder(-1)

		any_new_result1_2:setImage("rbxasset://textures/ui/TopBar/chatOff.png", "deselected")

		any_new_result1_2:setImage("rbxasset://textures/ui/TopBar/chatOn.png", "selected")

		any_new_result1_2:setImageYScale(0.625)

	end

	return any_new_result1_2

end

function module_upvr.set(arg1, arg2, arg3, arg4, arg5) -- Line 1241

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	-- KONSTANTERROR: [0] 1. Error Block 105 start (CF ANALYSIS FAILED)

	local var357 = arg1._settingsDictionary[arg2]

	local var358

	if var357 == nil then

		var358 = false

	else

		var358 = true

	end

	assert(var358, string.format("setting '%s' does not exist", arg2))

	var358 = arg4

	if type(var358) == "string" then

		local any_lower_result1 = arg4:lower()

	end

	local any_get_result1_3 = arg1:get(arg2, any_lower_result1)

	if any_lower_result1 == "hovering" then

		var357.hoveringValue = arg3

		if arg5 ~= "_ignorePrevious" then

			var358 = var357.additionalValues

			var358["previous_"..any_lower_result1] = any_get_result1_3

		end

		var358 = type(arg5)

		if var358 == "string" then

			var358 = var357.additionalValues

			var358[arg5..'_'..any_lower_result1] = any_get_result1_3

		end

		var358 = arg1._update

		var358(arg1, arg2)

		-- KONSTANTWARNING: GOTO [199] #143

	end

	-- KONSTANTERROR: [0] 1. Error Block 105 end (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [63] 48. Error Block 103 start (CF ANALYSIS FAILED)

	var358 = any_lower_result1

	if var357.type == "toggleable" then

		local tbl_3 = {}

		if var358 == "deselected" or var358 == "selected" then

			table.insert(tbl_3, var358)

		else

			table.insert(tbl_3, "deselected")

			table.insert(tbl_3, "selected")

			var358 = nil

		end

		for i_5, v_5 in pairs(tbl_3) do

			var357.values[v_5] = arg3

			if arg5 ~= "_ignorePrevious" then

				var357.additionalValues["previous_"..v_5] = any_get_result1_3

			end

			if type(arg5) == "string" then

				var357.additionalValues[arg5..'_'..v_5] = any_get_result1_3

			end

		end

	else

		var357.value = arg3

		if type(arg5) == "string" then

			if arg5 ~= "_ignorePrevious" then

				var357.additionalValues.previous = any_get_result1_3

			end

			var357.additionalValues[arg5] = any_get_result1_3

		end

	end

	if any_get_result1_3 == arg3 then

		return arg1, "Value was already set"

	end

	local function INLINED_12() -- Internal function, doesn't exist in bytecode

		local var365

		return var357.instanceNames

	end

	if not arg1._updateAfterSettingAll and INLINED_12() and (arg1:getToggleState() == var358 or var358 == nil) then

		local var366 = false

		if arg2 == "iconSize" then

			var366 = any_get_result1_3

			if var366 then

				var365 = any_get_result1_3.X.Scale

				if var365 ~= 1 then

					var366 = false

				else

					var366 = true

				end

			end

		end

		local function INLINED_13() -- Internal function, doesn't exist in bytecode

			var365 = arg1:get(i_5)

			i_5 = var357.tweenAction

			return var365

		end

		if not var357.tweenAction or var366 or not INLINED_13() then

			var365 = TweenInfo.new(0)

		end

		v_5 = arg2

		-- KONSTANTERROR: Expression was reused, decompilation is incorrect

		arg1:_update(v_5, arg1:getToggleState(), var365)

	end

	var358 = var357.callMethods

	if var358 then

		var358 = pairs(var357.callMethods)

		local pairs_result1, pairs_result2_7, pairs_result3_25 = pairs(var357.callMethods)

		for _, v_6 in pairs_result1, pairs_result2_7, pairs_result3_25 do

			i_5 = arg1

			v_5 = arg3

			v_6(i_5, v_5, any_lower_result1)

		end

	end

	pairs_result1 = var357.callSignals

	if pairs_result1 then

		pairs_result1 = pairs(var357.callSignals)

		for _, v_7 in pairs(var357.callSignals) do

			v_7:Fire()

		end

	end

	do

		return arg1

	end

	-- KONSTANTERROR: [63] 48. Error Block 103 end (CF ANALYSIS FAILED)

end

function module_upvr.setAdditionalValue(arg1, arg2, arg3, arg4, arg5) -- Line 1322

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	local var381 = arg1._settingsDictionary[arg2]

	local var382

	if var381 == nil then

		var382 = false

	else

		var382 = true

	end

	assert(var382, string.format("setting '%s' does not exist", arg2))

	var382 = arg3

	if arg5 then

		var382 = var382..'_'

	end

	var382 = pairs(var381.additionalValues)

	for i_8, _ in pairs(var381.additionalValues) do

		if string.match(i_8, var382..arg5) then

			var381.additionalValues[i_8] = arg4

		end

	end

end

function module_upvr.get(arg1, arg2, arg3, arg4) -- Line 1336

	-- KONSTANTERROR: [0] 1. Error Block 45 start (CF ANALYSIS FAILED)

	local var386

	if arg1._settingsDictionary[arg2] == nil then

		var386 = false

	else

		var386 = true

	end

	assert(var386, string.format("setting '%s' does not exist", arg2))

	var386 = nil

	-- KONSTANTERROR: [0] 1. Error Block 45 end (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [25] 20. Error Block 6 start (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [25] 20. Error Block 6 end (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [29] 23. Error Block 7 start (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [29] 23. Error Block 7 end (CF ANALYSIS FAILED)

end

function module_upvr.getHovering(arg1, arg2) -- Line 1372

	local var387 = arg1._settingsDictionary[arg2]

	local var388

	if var387 == nil then

		var388 = false

	else

		var388 = true

	end

	assert(var388, string.format("setting '%s' does not exist", arg2))

	return var387.hoveringValue

end

function module_upvr.getToggleState(arg1, arg2) -- Line 1378

	local var389 = arg2

	if not var389 then

		var389 = arg1.isSelected

	end

	if var389 then

		return "selected"

	end

	return "deselected"

end

function module_upvr.getIconState(arg1) -- Line 1383

	if arg1.hovering then

		return "hovering"

	end

	return arg1:getToggleState()

end

function module_upvr._update(arg1, arg2, arg3, arg4) -- Line 1391

	--[[ Upvalues[1]:

		[1]: TweenService_upvr (readonly)

	]]

	-- KONSTANTERROR: [0] 1. Error Block 50 start (CF ANALYSIS FAILED)

	local var390 = arg1._settingsDictionary[arg2]

	local var391

	if var390 == nil then

		var391 = false

	else

		var391 = true

	end

	assert(var391, string.format("setting '%s' does not exist", arg2))

	-- KONSTANTERROR: [0] 1. Error Block 50 end (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [18] 15. Error Block 6 start (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [18] 15. Error Block 6 end (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [21] 17. Error Block 7 start (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [21] 17. Error Block 7 end (CF ANALYSIS FAILED)

end

function module_upvr._updateAll(arg1, arg2, arg3) -- Line 1435

	for i_9, v_9 in pairs(arg1._settingsDictionary) do

		if v_9.instanceNames then

			arg1:_update(i_9, arg2, arg3)

		end

	end

end

function module_upvr._updateHovering(arg1, arg2) -- Line 1443

	for i_10, v_10 in pairs(arg1._settingsDictionary) do

		if v_10.instanceNames and v_10.hoveringValue ~= nil then

			arg1:_update(i_10, nil, arg2)

		end

	end

end

function module_upvr._updateStateOverlay(arg1, arg2, arg3) -- Line 1451

	local iconOverlay = arg1.instances.iconOverlay

	iconOverlay.BackgroundTransparency = arg2 or 1

	local var403 = arg3

	if not var403 then

		var403 = Color3.new(1, 1, 1)

	end

	iconOverlay.BackgroundColor3 = var403

end

function module_upvr.setTheme(arg1, arg2, arg3) -- Line 1457
	if not arg2 then return end
	arg1._updateAfterSettingAll = arg3
	for categoryName, details in pairs(arg2) do
		if type(details) == "table" then
			if categoryName == "toggleable" then
				if details.deselected then
					for key, value in pairs(details.deselected) do
						if not arg1.lockedSettings[key] then
							arg1:set(key, value, "deselected")
						end
					end
				end
				if details.selected then
					for key, value in pairs(details.selected) do
						if not arg1.lockedSettings[key] then
							arg1:set(key, value, "selected")
						end
					end
				end
			else
				for key, value in pairs(details) do
					if not arg1.lockedSettings[key] then
						arg1:set(key, value)
					end
				end
			end
		end
	end
	arg1._updateAfterSettingAll = nil
end

function module_upvr.getInstance(arg1, arg2) -- Line 1491

	return arg1.instances[arg2]

end

function module_upvr.setInstance(arg1, arg2, arg3) -- Line 1495

	local var419 = arg1.instances[arg2]

	arg1.instances[arg2] = arg3

	if var419 then

		var419:Destroy()

	end

	return arg1

end

function module_upvr.getSettingDetail(arg1, arg2) -- Line 1504

	for _, v_14 in pairs(arg1._settings) do

		for i_15, v_15 in pairs(v_14) do

			if i_15 == arg2 then

				return v_15

			end

		end

	end

	return false

end

function module_upvr.modifySetting(arg1, arg2, arg3) -- Line 1515

	local any_getSettingDetail_result1 = arg1:getSettingDetail(arg2)

	for i_16, v_16 in pairs(arg3) do

		any_getSettingDetail_result1[i_16] = v_16

	end

	return arg1

end

function module_upvr.convertLabelToNumberSpinner(arg1, arg2) -- Line 1523

	arg1:set("iconLabelSize", UDim2.new(1, 0, 1, 0))

	arg2.Parent = arg1:getInstance("iconButton")

	local tbl_15 = {}

	setmetatable(tbl_15, {

		__newindex = function(arg1_3, arg2_3, arg3) -- Line 1530, Named "__newindex"

			--[[ Upvalues[1]:

				[1]: arg2 (readonly)

			]]

			for _, v_17 in pairs(arg2.Frame:GetDescendants()) do

				if v_17:IsA("TextLabel") then

					v_17[arg2_3] = arg3

				end

			end

		end;

	})

	arg1:getInstance("iconButton").ZIndex = 0

	arg1:setInstance("iconLabel", tbl_15)

	arg1:modifySetting("iconText", {

		instanceNames = {};

	})

	arg1:setInstance("iconLabelSpinner", arg2.Frame)

	for _, v_18 in pairs({"iconLabelVisible", "iconLabelAnchorPoint", "iconLabelPosition", "iconLabelSize"}) do

		arg1:modifySetting(v_18, {

			instanceNames = {"iconLabelSpinner"};

		})

	end

	arg1:_updateAll()

	return arg1

end

function module_upvr.setEnabled(arg1, arg2) -- Line 1554

	arg1.enabled = arg2

	arg1.instances.iconContainer.Visible = arg2

	arg1.updated:Fire()

	return arg1

end

function module_upvr.setName(arg1, arg2) -- Line 1561

	arg1.name = arg2

	arg1.instances.iconContainer.Name = arg2

	return arg1

end

function module_upvr.setProperty(arg1, arg2, arg3) -- Line 1567

	arg1[arg2] = arg3

	return arg1

end

local Debris_upvr = game:GetService("Debris")

function module_upvr._playClickSound(arg1) -- Line 1572

	--[[ Upvalues[1]:

		[1]: Debris_upvr (readonly)

	]]

	local clickSound = arg1.instances.clickSound

	if clickSound.SoundId ~= nil and 0 < #clickSound.SoundId and 0 < clickSound.Volume then

		local clone = clickSound:Clone()

		clone.Parent = clickSound.Parent

		clone:Play()

		Debris_upvr:AddItem(clone, clickSound.TimeLength)

	end

end

function module_upvr.select(arg1, arg2) -- Line 1582

	--[[ Upvalues[1]:

		[1]: IconController_upvr (readonly)

	]]

	if arg1.locked then

		return arg1

	end

	arg1.isSelected = true

	arg1:_setToggleItemsVisible(true, arg2)

	arg1:_updateNotice()

	arg1:_updateAll()

	arg1:_playClickSound()

	if 0 < #arg1.dropdownIcons or 0 < #arg1.menuIcons then

		IconController_upvr:_updateSelectionGroup()

	end

	arg1.selected:Fire()

	arg1.toggled:Fire(arg1.isSelected)

	return arg1

end

function module_upvr.deselect(arg1, arg2, arg3) -- Line 1597

	--[[ Upvalues[1]:

		[1]: IconController_upvr (readonly)

	]]

	if arg1.locked then

		return arg1

	end

	arg1.isSelected = false

	arg1:_setToggleItemsVisible(false, arg2)

	arg1:_updateNotice()

	arg1:_updateAll()

	arg1:_playClickSound()

	if 0 < #arg1.dropdownIcons or 0 < #arg1.menuIcons then

		IconController_upvr:_updateSelectionGroup()

	end

	if not arg3 then

		arg1.deselected:Fire()

	end

	arg1.toggled:Fire(arg1.isSelected)

	return arg1

end

local HttpService_upvr = game:GetService("HttpService")

function module_upvr.notify(arg1, arg2, arg3) -- Line 1614

	--[[ Upvalues[2]:

		[1]: Signal_upvr (readonly)

		[2]: HttpService_upvr (readonly)

	]]

	coroutine.wrap(function() -- Line 1615

		--[[ Upvalues[5]:

			[1]: arg2 (read and write)

			[2]: arg1 (readonly)

			[3]: Signal_upvr (copied, readonly)

			[4]: arg3 (read and write)

			[5]: HttpService_upvr (copied, readonly)

		]]

		if not arg2 then

			arg2 = arg1.deselected

		end

		if arg1._parentIcon then

			arg1._parentIcon:notify(arg2)

		end

		local any_new_result1_3_upvr = Signal_upvr.new()

		local function var460() -- Line 1624

			--[[ Upvalues[1]:

				[1]: any_new_result1_3_upvr (readonly)

			]]

			any_new_result1_3_upvr:Fire()

		end

		var460 = arg3

		local var462 = var460

		if not var462 then

			var462 = HttpService_upvr:GenerateGUID(true)

		end

		arg3 = var462

		local tbl_14 = {

			completeSignal = any_new_result1_3_upvr;

		}

		tbl_14.clearNoticeEvent = arg2

		arg1.notices[arg3] = tbl_14

		local var464 = arg1

		var464.totalNotices += 1

		arg1:_updateNotice()

		arg1.notified:Fire(arg3)

		any_new_result1_3_upvr:Wait()

		arg1._endNotices:Connect(var460):Disconnect()

		arg2:Connect(function() -- Line 1627

			--[[ Upvalues[1]:

				[1]: any_new_result1_3_upvr (readonly)

			]]

			any_new_result1_3_upvr:Fire()

		end):Disconnect()

		any_new_result1_3_upvr:Disconnect()

		local var465 = arg1

		var465.totalNotices -= 1

		arg1.notices[arg3] = nil

		arg1:_updateNotice()

	end)()

	return arg1

end

function module_upvr._updateNotice(arg1) -- Line 1653

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	if arg1.totalNotices < 1 then

	end

	if not arg1.isSelected and (0 < #arg1.dropdownIcons or 0 < #arg1.menuIcons) or 0 < arg1.totalNotices then

	end

	local var466

	if arg1.isSelected and (0 < #arg1.dropdownIcons or 0 < #arg1.menuIcons) then

		var466 = false

	end

	if var466 then

		local _ = 0

	else

	end

	arg1:set("noticeImageTransparency", 1)

	-- KONSTANTERROR: Expression was reused, decompilation is incorrect

	arg1:set("noticeTextTransparency", 1)

	if arg1.totalNotices >= 100 or not arg1.totalNotices then

	end

	arg1.instances.noticeLabel.Text = "99+"

end

function module_upvr.clearNotices(arg1) -- Line 1676

	arg1._endNotices:Fire()

	return arg1

end

function module_upvr.disableStateOverlay(arg1, arg2) -- Line 1681

	if arg2 == nil then

	end

	arg1.instances.iconOverlay.Visible = not true

	return arg1

end

function module_upvr.setLabel(arg1, arg2, arg3) -- Line 1693

	arg1:set("iconText", arg2 or "", arg3)

	return arg1

end

function module_upvr.setCornerRadius(arg1, arg2, arg3, arg4) -- Line 1699

	local CornerRadius = arg1.instances.iconCorner.CornerRadius

	local var469 = arg2

	if not var469 then

		var469 = CornerRadius.Scale

	end

	local var470 = arg3

	if not var470 then

		var470 = CornerRadius.Offset

	end

	arg1:set("iconCornerRadius", UDim.new(var469, var470), arg4)

	return arg1

end

function module_upvr.setImage(arg1, arg2, arg3) -- Line 1706

	local var471

	local function INLINED_14() -- Internal function, doesn't exist in bytecode

		var471 = "http://www.roblox.com/asset/?id="..arg2

		return var471

	end

	if not tonumber(arg2) or not INLINED_14() then

		var471 = arg2

		if not var471 then

			var471 = ""

		end

	end

	return arg1:set("iconImage", var471, arg3)

end

function module_upvr.setOrder(arg1, arg2, arg3) -- Line 1711

	return arg1:set("order", tonumber(arg2) or 1, arg3)

end

function module_upvr.setLeft(arg1, arg2) -- Line 1716

	return arg1:set("alignment", "left", arg2)

end

function module_upvr.setMid(arg1, arg2) -- Line 1720

	return arg1:set("alignment", "mid", arg2)

end

function module_upvr.setRight(arg1, arg2) -- Line 1724

	--[[ Upvalues[1]:

		[1]: IconController_upvr (readonly)

	]]

	if not arg1.internalIcon then

		IconController_upvr.setupHealthbar()

	end

	return arg1:set("alignment", "right", arg2)

end

function module_upvr.setImageYScale(arg1, arg2, arg3) -- Line 1731

	return arg1:set("iconImageYScale", tonumber(arg2) or 0.63, arg3)

end

function module_upvr.setImageRatio(arg1, arg2, arg3) -- Line 1736

	return arg1:set("iconImageRatio", tonumber(arg2) or 1, arg3)

end

function module_upvr.setLabelYScale(arg1, arg2, arg3) -- Line 1741

	return arg1:set("iconLabelYScale", tonumber(arg2) or 0.45, arg3)

end

function module_upvr.setBaseZIndex(arg1, arg2, arg3) -- Line 1746

	return arg1:set("baseZIndex", tonumber(arg2) or 1, arg3)

end

function module_upvr._updateBaseZIndex(arg1, arg2) -- Line 1751

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	local iconContainer = arg1.instances.iconContainer

	local tonumber_result1 = tonumber(arg2)

	if not tonumber_result1 then

		tonumber_result1 = iconContainer.ZIndex

	end

	local var482 = tonumber_result1 - iconContainer.ZIndex

	if var482 == 0 then

		return "The baseValue is the same"

	end

	for _, v_19 in pairs(arg1.instances) do

		v_19.ZIndex += var482

		local _

	end

	return true

end

function module_upvr.setSize(arg1, arg2, arg3, arg4) -- Line 1762

	local var487 = tonumber(arg2) or 32

	local var488 = tonumber(arg3) or var487

	arg1:set("forcedIconSize", UDim2.new(0, var487, 0, var488), arg4)

	arg1:set("iconSize", UDim2.new(0, var487, 0, var488), arg4)

	return arg1

end

function module_upvr._updateIconSize(arg1, arg2, arg3) -- Line 1770

	--[[ Upvalues[1]:

		[1]: TextService_upvr (readonly)

	]]

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	-- KONSTANTERROR: [0] 1. Error Block 79 start (CF ANALYSIS FAILED)

	local var522

	if arg1._destroyed then

	else

		local tbl_5 = {

			iconImage = arg1:get("iconImage", arg3) or "_NIL";

			iconText = arg1:get("iconText", arg3) or "_NIL";

			iconFont = arg1:get("iconFont", arg3) or "_NIL";

			iconSize = arg1:get("iconSize", arg3) or "_NIL";

			forcedIconSize = arg1:get("forcedIconSize", arg3) or "_NIL";

			iconImageYScale = arg1:get("iconImageYScale", arg3) or "_NIL";

			iconImageRatio = arg1:get("iconImageRatio", arg3) or "_NIL";

			iconLabelYScale = arg1:get("iconLabelYScale", arg3) or "_NIL";

		}

		for _, v_33 in pairs(tbl_5) do

			if v_33 == "_NIL" then return end

		end

		local iconContainer_4 = arg1.instances.iconContainer

		if not iconContainer_4.Parent then return end

		local Scale_2 = tbl_5.iconSize.X.Scale

		if 0 >= Scale_2 or not (tbl_5.iconSize.X.Offset + Scale_2 * iconContainer_4.Parent.AbsoluteSize.X) then

		end

		var522 = iconContainer_4.Parent

		local var529 = tbl_5.iconSize.Y.Offset + tbl_5.iconSize.Y.Scale * var522.AbsoluteSize.Y

		local var530 = var529 * tbl_5.iconLabelYScale

		var522 = var529 * tbl_5.iconImageYScale

		local var531 = var522 * tbl_5.iconImageRatio

		if tbl_5.iconImage == "" then

			var522 = false

		else

			var522 = true

		end

		if tbl_5.iconText == "" then

			local _ = false

			-- KONSTANTWARNING: Skipped task `defvar` above

		else

		end

		if var522 and not true then

			arg1:set("iconImageVisible", true, arg3)

			arg1:set("iconImageAnchorPoint", Vector2.new(0.5, 0.5), arg3)

			arg1:set("iconImagePosition", UDim2.new(0.5, 0, 0.5, 0), arg3)

			arg1:set("iconImageSize", UDim2.new(tbl_5.iconImageYScale * tbl_5.iconImageRatio, 0, tbl_5.iconImageYScale, 0), arg3)

			arg1:set("iconLabelVisible", false, arg3)

			-- KONSTANTWARNING: GOTO [389] #293

		end

		-- KONSTANTERROR: [0] 1. Error Block 79 end (CF ANALYSIS FAILED)

		-- KONSTANTERROR: [234] 167. Error Block 80 start (CF ANALYSIS FAILED)

		if not var522 then

			-- KONSTANTERROR: Expression was reused, decompilation is incorrect

			if true then

				arg1:set("iconLabelVisible", true, arg3)

				arg1:set("iconLabelAnchorPoint", Vector2.new(0, 0.5), arg3)

				arg1:set("iconLabelPosition", UDim2.new(0, 12, 0.5, 0), arg3)

				arg1:set("iconLabelSize", UDim2.new(1, -24, tbl_5.iconLabelYScale, var530 / 2), arg3)

				arg1:set("iconLabelTextXAlignment", Enum.TextXAlignment.Center, arg3)

				arg1:set("iconImageVisible", false, arg3)

				-- KONSTANTWARNING: GOTO [389] #293

			end

		end

		if var522 then

			-- KONSTANTERROR: Expression was reused, decompilation is incorrect

			if true then

				local var533 = 12 + var531 + 8

				-- KONSTANTERROR: Expression was reused, decompilation is incorrect

				local var534 = var533 + TextService_upvr:GetTextSize(tbl_5.iconText, var530, tbl_5.iconFont, Vector2.new(10000, var530)).X + 12

				arg1:set("iconImageVisible", true, arg3)

				arg1:set("iconImageAnchorPoint", Vector2.new(0, 0.5), arg3)

				arg1:set("iconImagePosition", UDim2.new(0, 12, 0.5, 0), arg3)

				arg1:set("iconImageSize", UDim2.new(0, var531, tbl_5.iconImageYScale, 0), arg3)

				arg1:set("iconLabelVisible", true, arg3)

				arg1:set("iconLabelAnchorPoint", Vector2.new(0, 0.5), arg3)

				arg1:set("iconLabelPosition", UDim2.new(0, var533, 0.5, 0), arg3)

				-- KONSTANTERROR: Expression was reused, decompilation is incorrect

				arg1:set("iconLabelSize", UDim2.new(1, -var533 - 12, tbl_5.iconLabelYScale, var530 / 2), arg3)

				arg1:set("iconLabelTextXAlignment", Enum.TextXAlignment.Left, arg3)

			end

		end

		if var534 then

			var533 = arg1._updatingIconSize

			local var535

			if not var535 then

				var535 = true

				arg1._updatingIconSize = var535

				local var536 = 0

				local function INLINED_16() -- Internal function, doesn't exist in bytecode

					var535 = Scale_2

					return var535

				end

				if var536 >= Scale_2 or not INLINED_16() then

					var535 = 0

				end

				if 0 < Scale_2 then

					var536 = 0

				else

					var536 = math.clamp(var534, tbl_5.forcedIconSize.X.Offset, 9999)

				end

				arg1:set("iconSize", UDim2.new(var535, var536, tbl_5.iconSize.Y.Scale, tbl_5.iconSize.Y.Offset), arg3, "_ignorePrevious")

				local _parentIcon = arg1._parentIcon

				if _parentIcon then

					local udim2 = UDim2.new(0, var534, 0, tbl_5.iconSize.Y.Offset)

					if 0 < #_parentIcon.dropdownIcons then

						arg1:setAdditionalValue("iconSize", "beforeDropdown", udim2, arg3)

						_parentIcon:_updateDropdown()

					end

					if 0 < #_parentIcon.menuIcons then

						arg1:setAdditionalValue("iconSize", "beforeMenu", udim2, arg3)

						_parentIcon:_updateMenu()

					end

				end

				arg1._updatingIconSize = false

			end

		end

		arg1:set("iconLabelTextSize", var530, arg3)

		arg1:set("noticeFramePosition", UDim2.new(0.45, 0, 0, -2), arg3)

		arg1._updatingIconSize = false

		-- KONSTANTERROR: [234] 167. Error Block 80 end (CF ANALYSIS FAILED)

	end

end

function module_upvr.bindEvent(arg1, arg2, arg3) -- Line 1879

	local var542 = arg1[arg2]

	local var543

	if var543 then

		var543 = false

		if typeof(var542) == "table" then

			var543 = var542.Connect

		end

	end

	assert(var543, "argument[1] must be a valid topbarplus icon event name!")

	if typeof(arg3) ~= "function" then

		var543 = false

	else

		var543 = true

	end

	assert(var543, "argument[2] must be a function!")

	var543 = var542:Connect(function(...) -- Line 1883

		--[[ Upvalues[2]:

			[1]: arg3 (readonly)

			[2]: arg1 (readonly)

		]]

		arg3(arg1, ...)

	end)

	arg1._bindedEvents[arg2] = var543

	return arg1

end

function module_upvr.unbindEvent(arg1, arg2) -- Line 1889

	local var545 = arg1._bindedEvents[arg2]

	if var545 then

		var545:Disconnect()

		arg1._bindedEvents[arg2] = nil

	end

	return arg1

end

function module_upvr.bindToggleKey(arg1, arg2) -- Line 1898

	local var546

	if typeof(arg2) ~= "EnumItem" then

		var546 = false

	else

		var546 = true

	end

	assert(var546, "argument[1] must be a KeyCode EnumItem!")

	var546 = true

	arg1._bindedToggleKeys[arg2] = var546

	return arg1

end

function module_upvr.unbindToggleKey(arg1, arg2) -- Line 1904

	local var547

	if typeof(arg2) ~= "EnumItem" then

		var547 = false

	else

		var547 = true

	end

	assert(var547, "argument[1] must be a KeyCode EnumItem!")

	var547 = nil

	arg1._bindedToggleKeys[arg2] = var547

	return arg1

end

function module_upvr.lock(arg1) -- Line 1910

	arg1.locked = true

	return arg1

end

function module_upvr.unlock(arg1) -- Line 1915

	arg1.locked = false

	return arg1

end

function module_upvr.setTopPadding(arg1, arg2, arg3) -- Line 1920

	arg1.topPadding = UDim.new(arg3 or 0, arg2 or 4)

	arg1.updated:Fire()

	return arg1

end

function module_upvr.bindToggleItem(arg1, arg2) -- Line 1928

	if not arg2:IsA("GuiObject") and not arg2:IsA("LayerCollector") then

		error("Toggle item must be a GuiObject or LayerCollector!")

	end

	arg1.toggleItems[arg2] = true

	return arg1

end

function module_upvr.unbindToggleItem(arg1, arg2) -- Line 1936

	arg1.toggleItems[arg2] = nil

	return arg1

end

function module_upvr._setToggleItemsVisible(arg1, arg2, arg3) -- Line 1941

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	local _

	for i_20, _ in pairs(arg1.toggleItems) do

		if not arg3 or arg3.toggleItems[i_20] == nil then

			if i_20:IsA("LayerCollector") then

			end

			i_20.Enabled = arg2

		end

	end

end

function module_upvr.give(arg1, arg2) -- Line 1953

	local var560 = arg2

	if typeof(arg2) == "function" then

		if typeof(arg2) ~= "function" then

			var560 = arg2(arg1)

		else

			var560 = nil

		end

	end

	if var560 ~= nil then

		arg1._maid:give(var560)

	end

	return arg1

end

tbl_4_upvr.tip = 1

function module_upvr.setTip(arg1, arg2) -- Line 1972

	--[[ Upvalues[3]:

		[1]: TextService_upvr (readonly)

		[2]: ActiveItems_upvr (readonly)

		[3]: Maid_upvr (readonly)

	]]

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	local var561 = true

	if typeof(arg2) ~= "string" then

		if arg2 ~= nil then

			var561 = false

		else

			var561 = true

		end

	end

	assert(var561, "Expected string, got "..typeof(arg2))

	local var562 = arg2 or ""

	if var562 == "" then

		var561 = false

	else

		var561 = true

	end

	arg1.instances.tipLabel.Text = var562

	if not var561 or not UDim2.new(0, TextService_upvr:GetTextSize(var562, 12, Enum.Font.GothamSemibold, Vector2.new(1000, 14)).X + 6, 0, 20) then

	end

	arg1.instances.tipFrame.Size = UDim2.new(0, 0, 0, 0)

	if not var561 or not ActiveItems_upvr then

	end

	arg1.instances.tipFrame.Parent = arg1.instances.iconContainer

	arg1._maid.tipFrame = arg1.instances.tipFrame

	arg1.tipText = arg2

	local any_new_result1_4 = Maid_upvr.new()

	arg1._maid.tipMaid = any_new_result1_4

	if var561 then

		any_new_result1_4:give(arg1.hoverStarted:Connect(function() -- Line 1986

			--[[ Upvalues[1]:

				[1]: arg1 (readonly)

			]]

			if not arg1.isSelected then

				arg1:displayTip(true)

			end

		end))

		any_new_result1_4:give(arg1.hoverEnded:Connect(function() -- Line 1991

			--[[ Upvalues[1]:

				[1]: arg1 (readonly)

			]]

			arg1:displayTip(false)

		end))

		any_new_result1_4:give(arg1.selected:Connect(function() -- Line 1994

			--[[ Upvalues[1]:

				[1]: arg1 (readonly)

			]]

			if arg1.hovering then

				arg1:displayTip(false)

			end

		end))

	end

	arg1:displayTip(arg1.hovering and var561)

	return arg1

end

function module_upvr.displayTip(arg1, arg2) -- Line 2004

	--[[ Upvalues[3]:

		[1]: UserInputService_upvr (readonly)

		[2]: IconController_upvr (readonly)

		[3]: TopbarPlusGui_upvr (readonly)

	]]

	local var571

	if var571 then

		var571 = arg1._draggingFinger

		if not var571 then return end

	end

	var571 = arg1.tipVisible or false

	if typeof(arg2) == "boolean" then

		var571 = arg2

	end

	arg1.tipVisible = var571

	if var571 then

		local tipFrame_upvr = arg1.instances.tipFrame

		local function updateTipPositon(arg1_4, arg2_4) -- Line 2018

			--[[ Upvalues[4]:

				[1]: UserInputService_upvr (copied, readonly)

				[2]: tipFrame_upvr (readonly)

				[3]: IconController_upvr (copied, readonly)

				[4]: TopbarPlusGui_upvr (copied, readonly)

			]]

			-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

			-- KONSTANTERROR: [0] 1. Error Block 16 start (CF ANALYSIS FAILED)

			local var574

			if var574 then

				var574 = workspace.CurrentCamera.ViewportSize

			end

			if UserInputService_upvr.TouchEnabled then

				-- KONSTANTWARNING: GOTO [143] #101

			end

			-- KONSTANTERROR: [0] 1. Error Block 16 end (CF ANALYSIS FAILED)

			-- KONSTANTERROR: [72] 52. Error Block 13 start (CF ANALYSIS FAILED)

			if IconController_upvr.controllerModeEnabled then

				local _ = TopbarPlusGui_upvr.Indicator.AbsolutePosition

			else

			end

			-- KONSTANTERROR: [72] 52. Error Block 13 end (CF ANALYSIS FAILED)

		end

		local any_GetMouseLocation_result1 = UserInputService_upvr:GetMouseLocation()

		if any_GetMouseLocation_result1 then

			updateTipPositon(any_GetMouseLocation_result1.X, any_GetMouseLocation_result1.Y)

		end

		arg1._hoveringMaid:give(arg1.instances.iconButton.MouseMoved:Connect(updateTipPositon))

	end

	for _, v_21 in pairs(arg1._groupSettings.tip) do

		arg1._settingsDictionary[v_21].useForcedGroupValue = not var571

		arg1:_update(v_21)

	end

end

tbl_4_upvr.caption = 1

function module_upvr.setCaption(arg1, arg2) -- Line 2073

	--[[ Upvalues[3]:

		[1]: ActiveItems_upvr (readonly)

		[2]: Maid_upvr (readonly)

		[3]: TextService_upvr (readonly)

	]]

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	local var581 = true

	if typeof(arg2) ~= "string" then

		if arg2 ~= nil then

			var581 = false

		else

			var581 = true

		end

	end

	assert(var581, "Expected string, got "..typeof(arg2))

	local var582 = arg2 or ""

	if var582 == "" then

		var581 = false

	else

		var581 = true

	end

	arg1.captionText = arg2

	arg1.instances.captionLabel.Text = var582

	if not var581 or not ActiveItems_upvr then

	end

	arg1.instances.captionContainer.Parent = arg1.instances.iconContainer

	arg1._maid.captionContainer = arg1.instances.captionContainer

	arg1:_updateIconSize(nil, arg1:getIconState())

	local any_new_result1 = Maid_upvr.new()

	arg1._maid.captionMaid = any_new_result1

	if var581 then

		any_new_result1:give(arg1.hoverStarted:Connect(function() -- Line 2085

			--[[ Upvalues[1]:

				[1]: arg1 (readonly)

			]]

			if not arg1.isSelected then

				arg1:displayCaption(true)

			end

		end))

		any_new_result1:give(arg1.hoverEnded:Connect(function() -- Line 2090

			--[[ Upvalues[1]:

				[1]: arg1 (readonly)

			]]

			arg1:displayCaption(false)

		end))

		any_new_result1:give(arg1.selected:Connect(function() -- Line 2093

			--[[ Upvalues[1]:

				[1]: arg1 (readonly)

			]]

			if arg1.hovering then

				arg1:displayCaption(false)

			end

		end))

		local iconContainer_3 = arg1.instances.iconContainer

		any_new_result1:give(iconContainer_3:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line 2099

			--[[ Upvalues[1]:

				[1]: arg1 (readonly)

			]]

			if arg1.hovering then

				arg1:displayCaption()

			end

		end))

		any_new_result1:give(iconContainer_3:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line 2104

			--[[ Upvalues[1]:

				[1]: arg1 (readonly)

			]]

			if arg1.hovering then

				arg1:displayCaption()

			end

		end))

	end

	local any_get_result1_10 = arg1:get("iconSize")

	local any_get_result1_2 = arg1:get("captionFont")

	if any_get_result1_10 and any_get_result1_2 then

		if var581 then

			local var592 = any_get_result1_10.Y.Offset + any_get_result1_10.Y.Scale * arg1.instances.iconContainer.Parent.AbsoluteSize.Y

			local captionLabel = arg1.instances.captionLabel

			local var594 = var592 * 0.8 * 0.58

			local X = TextService_upvr:GetTextSize(arg1.captionText, var594, any_get_result1_2, Vector2.new(10000, var594)).X

			captionLabel.TextSize = var594

			captionLabel.Size = UDim2.new(0, X, 0.58, 0)

			arg1.instances.captionContainer.Size = UDim2.new(0, X + 12, 0, var592 * 0.8)

		else

			-- KONSTANTERROR: Expression was reused, decompilation is incorrect

			arg1.instances.captionContainer.Size = UDim2.new(0, 0, 0, 0)

		end

	end

	arg1:displayCaption(arg1.hovering and var581)

	return arg1

end

function module_upvr.displayCaption(arg1, arg2) -- Line 2140

	--[[ Upvalues[1]:

		[1]: UserInputService_upvr (readonly)

	]]

	local var600

	if UserInputService_upvr.TouchEnabled then

		if not arg1._draggingFinger then return end

	end

	local var601 = 8

	if arg1._draggingFinger then

		var601 += 55

	end

	local iconContainer_2 = arg1.instances.iconContainer

	local captionContainer = arg1.instances.captionContainer

	var600 = 0

	captionContainer.Position = UDim2.new(var600, iconContainer_2.AbsolutePosition.X + iconContainer_2.AbsoluteSize.X / 2 - captionContainer.AbsoluteSize.X / 2, 0, iconContainer_2.AbsolutePosition.Y + iconContainer_2.AbsoluteSize.Y * 2 + var601)

	var600 = arg1.captionVisible or false

	if typeof(arg2) == "boolean" then

		var600 = arg2

	end

	arg1.captionVisible = var600

	for _, v_22 in pairs(arg1._groupSettings.caption) do

		arg1._settingsDictionary[v_22].useForcedGroupValue = not var600

		arg1:_update(v_22)

	end

end

function module_upvr.join(arg1, arg2, arg3, arg4) -- Line 2170

	--[[ Upvalues[1]:

		[1]: IconController_upvr (readonly)

	]]

	local var611

	if var611 then

		var611 = arg1.leave

		var611(arg1)

	end

	local function INLINED_17() -- Internal function, doesn't exist in bytecode

		var611 = arg3:lower()

		return var611

	end

	if not arg3 or not INLINED_17() then

		var611 = "dropdown"

	end

	local var612 = "before"..arg3:sub(1, 1):upper()..arg3:sub(2)

	arg1.presentOnTopbar = false

	arg1.joinedFeatureName = arg3

	arg1._parentIcon = arg2

	arg1.instances.iconContainer.Parent = arg2.instances[arg3.."Frame"]

	for i_23, v_23 in pairs(arg1.notices) do

		arg2:notify(v_23.clearNoticeEvent, i_23)

	end

	if arg3 == "dropdown" then

		i_23 = "iconSize"

		v_23 = UDim2.new(1, 0, 0, arg1:get("iconSize", "deselected").Y.Offset)

		arg1:set(i_23, v_23, "deselected", var612)

		i_23 = "iconSize"

		v_23 = UDim2.new(1, 0, 0, arg1:get("iconSize", "selected").Y.Offset)

		arg1:set(i_23, v_23, "selected", var612)

		if arg2:get("dropdownSquareCorners") then

			i_23 = "iconCornerRadius"

			v_23 = UDim.new(0, 0)

			arg1:set(i_23, v_23, "deselected", var612)

			i_23 = "iconCornerRadius"

			v_23 = UDim.new(0, 0)

			arg1:set(i_23, v_23, "selected", var612)

		end

		i_23 = "captionBlockerTransparency"

		v_23 = 0.4

		arg1:set(i_23, v_23, nil, var612)

	end

	table.insert(arg2[var611.."Icons"], arg1)

	if not arg4 then

		arg2:_updateDropdown()

	end

	arg2.deselectWhenOtherIconSelected = false

	IconController_upvr:_updateSelectionGroup()

	arg1:_decideToCallSignal("dropdown")

	arg1:_decideToCallSignal("menu")

	return arg1

end

function module_upvr.leave(arg1) -- Line 2210

	--[[ Upvalues[2]:

		[1]: TopbarContainer_upvr (readonly)

		[2]: IconController_upvr (readonly)

	]]

	if arg1._destroyed or arg1.instances.iconContainer.Parent == nil then return end

	local tbl_13_upvr = {"iconSize", "captionBlockerTransparency", "iconCornerRadius"}

	local _parentIcon_3_upvr = arg1._parentIcon

	arg1.instances.iconContainer.Parent = TopbarContainer_upvr

	arg1.presentOnTopbar = true

	arg1.joinedFeatureName = nil

	local function scanFeature(arg1_5, arg2, arg3) -- Line 2219

		--[[ Upvalues[3]:

			[1]: arg1 (readonly)

			[2]: tbl_13_upvr (readonly)

			[3]: _parentIcon_3_upvr (readonly)

		]]

		-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)

		local pairs_result1_15, pairs_result2_12, pairs_result3_7 = pairs(arg1_5)

		-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)

		-- KONSTANTERROR: [61] 48. Error Block 11 start (CF ANALYSIS FAILED)

		-- KONSTANTERROR: [61] 48. Error Block 11 end (CF ANALYSIS FAILED)

		-- KONSTANTERROR: [5] 5. Error Block 2 start (CF ANALYSIS FAILED)

		-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [61.7]

		-- KONSTANTERROR: [5] 5. Error Block 2 end (CF ANALYSIS FAILED)

	end

	scanFeature(_parentIcon_3_upvr.dropdownIcons, "beforeDropdown", _parentIcon_3_upvr._updateDropdown)

	scanFeature(_parentIcon_3_upvr.menuIcons, "beforeMenu", _parentIcon_3_upvr._updateMenu)

	for i_24, _ in pairs(arg1.notices) do

		local var626 = _parentIcon_3_upvr.notices[i_24]

		if var626 then

			var626.completeSignal:Fire()

		end

	end

	arg1._parentIcon = nil

	IconController_upvr:_updateSelectionGroup()

	arg1:_decideToCallSignal("dropdown")

	arg1:_decideToCallSignal("menu")

	return arg1

end

function module_upvr._decideToCallSignal(arg1, arg2) -- Line 2259

	local var627 = arg1[arg2.."Open"]

	local var628 = "_previous"..string.sub(arg2, 1, 1):upper()..arg2:sub(2).."Open"

	if var627 and 0 < #arg1[arg2.."Icons"] and arg1[var628] == false then

		arg1[var628] = true

		arg1[arg2.."Opened"]:Fire()

	else

		local function INLINED_18() -- Internal function, doesn't exist in bytecode

			-- KONSTANTERROR: Expression was reused, decompilation is incorrect

			return #arg1[arg2.."Icons"] == 0

		end

		local function INLINED_19() -- Internal function, doesn't exist in bytecode

			-- KONSTANTERROR: Expression was reused, decompilation is incorrect

			return arg1[var628] == true

		end

		if not var627 or INLINED_18() or INLINED_19() then

			arg1[var628] = false

			arg1[arg2.."Closed"]:Fire()

		end

	end

end

function module_upvr._ignoreClipping(arg1, arg2) -- Line 2273

	--[[ Upvalues[1]:

		[1]: ActiveItems_upvr (readonly)

	]]

	local any_get_result1 = arg1:get(arg2.."IgnoreClipping")

	if arg1._parentIcon then

		local var659 = arg1['_'..arg2.."ClippingMaid"]

		local var660_upvr = arg1.instances[arg2.."Container"]

		var659:clean()

		if any_get_result1 then

			local Frame = Instance.new("Frame")

			Frame.Name = var660_upvr.Name.."FakeFrame"

			Frame.ClipsDescendants = true

			Frame.BackgroundTransparency = 1

			Frame.Size = var660_upvr.Size

			Frame.Position = var660_upvr.Position

			Frame.Parent = ActiveItems_upvr

			for _, v_25 in pairs(var660_upvr:GetChildren()) do

				v_25.Parent = Frame

				local var665_upvr

			end

			local function _() -- Line 2292, Named "updateSize"

				--[[ Upvalues[2]:

					[1]: var660_upvr (readonly)

					[2]: var665_upvr (readonly)

				]]

				local AbsoluteSize_6 = var660_upvr.AbsoluteSize

				var665_upvr.Size = UDim2.new(0, AbsoluteSize_6.X, 0, AbsoluteSize_6.Y)

			end

			var659:give(var660_upvr:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line 2296

				--[[ Upvalues[2]:

					[1]: var660_upvr (readonly)

					[2]: var665_upvr (readonly)

				]]

				local AbsoluteSize_2 = var660_upvr.AbsoluteSize

				var665_upvr.Size = UDim2.new(0, AbsoluteSize_2.X, 0, AbsoluteSize_2.Y)

			end))

			local AbsoluteSize_5 = var660_upvr.AbsoluteSize

			var665_upvr.Size = UDim2.new(0, AbsoluteSize_5.X, 0, AbsoluteSize_5.Y)

			local function _() -- Line 2300, Named "updatePos"

				--[[ Upvalues[2]:

					[1]: var660_upvr (readonly)

					[2]: var665_upvr (readonly)

				]]

				local absolutePosition_4 = var660_upvr.absolutePosition

				var665_upvr.Position = UDim2.new(0, absolutePosition_4.X, 0, absolutePosition_4.Y + 36)

			end

			var659:give(var660_upvr:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line 2304

				--[[ Upvalues[2]:

					[1]: var660_upvr (readonly)

					[2]: var665_upvr (readonly)

				]]

				local absolutePosition_2 = var660_upvr.absolutePosition

				var665_upvr.Position = UDim2.new(0, absolutePosition_2.X, 0, absolutePosition_2.Y + 36)

			end))

			local absolutePosition_3 = var660_upvr.absolutePosition

			var665_upvr.Position = UDim2.new(0, absolutePosition_3.X, 0, absolutePosition_3.Y + 36)

			var659:give(function() -- Line 2308

				--[[ Upvalues[2]:

					[1]: var665_upvr (readonly)

					[2]: var660_upvr (readonly)

				]]

				for _, v_26 in pairs(var665_upvr:GetChildren()) do

					v_26.Parent = var660_upvr

				end

				var665_upvr.Name = "Destroying..."

				var665_upvr:Destroy()

			end)

		end

	end

	var665_upvr = arg2

	arg1._ignoreClippingChanged:Fire(var665_upvr, any_get_result1)

end

function module_upvr.setDropdown(arg1, arg2) -- Line 2321

	for _, v_27 in pairs(arg1.dropdownIcons) do

		v_27:leave()

	end

	if type(arg2) == "table" then

		for _, v_28 in pairs(arg2) do

			v_28:join(arg1, "dropdown", true)

		end

	end

	arg1:_updateDropdown()

	return arg1

end

function module_upvr._updateDropdown(arg1) -- Line 2337

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	local tbl_2 = {

		maxIconsBeforeScroll = arg1:get("dropdownMaxIconsBeforeScroll") or "_NIL";

		minWidth = arg1:get("dropdownMinWidth") or "_NIL";

		padding = arg1:get("dropdownListPadding") or "_NIL";

		dropdownAlignment = arg1:get("dropdownAlignment") or "_NIL";

		iconAlignment = arg1:get("alignment") or "_NIL";

		scrollBarThickness = arg1:get("dropdownScrollBarThickness") or "_NIL";

	}

	local var706

	for _, v_29 in pairs(tbl_2) do

		if v_29 == "_NIL" then return end

	end

	local Offset = tbl_2.padding.Offset

	local dropdownContainer = arg1.instances.dropdownContainer

	local dropdownFrame = arg1.instances.dropdownFrame

	var706 = arg1.dropdownIcons

	local len_2 = #var706

	local function INLINED_20() -- Internal function, doesn't exist in bytecode

		var706 = tbl_2.maxIconsBeforeScroll

		return var706

	end

	if tbl_2.maxIconsBeforeScroll >= len_2 or not INLINED_20() then

		var706 = len_2

	end

	table.sort(arg1.dropdownIcons, function(arg1_6, arg2) -- Line 2358

		local var712

		if arg1_6:get("order") >= arg2:get("order") then

			var712 = false

		else

			var712 = true

		end

		return var712

	end)

	for i_30 = 1, len_2 do

		local _, any_get_result2 = arg1.dropdownIcons[i_30]:get("iconSize", nil, "beforeDropdown")

		local var715 = any_get_result2.Y.Offset + Offset

		local var716

		if i_30 <= var706 then

			var716 += var715

		end

		if i_30 == len_2 then

			var716 += var715 / 4

		end

		local Offset_3 = any_get_result2.X.Offset

		if tbl_2.minWidth < Offset_3 then

		end

	end

	if var706 == len_2 then

	else

	end

	arg1:set("dropdownCanvasSize", UDim2.new(0, 0, 0, -Offset + var715))

	arg1:set("dropdownSize", UDim2.new(0, (Offset_3 + 4) * 2, 0, var716))

	local tbl_10 = {

		left = {

			AnchorPoint = Vector2.new(0, 0);

			PositionXScale = 0;

			ThicknessMultiplier = 0;

		};

		mid = {

			AnchorPoint = Vector2.new(0.5, 0);

			PositionXScale = 0.5;

			ThicknessMultiplier = 0.5;

		};

	}

	local tbl_9 = {

		AnchorPoint = Vector2.new(0.5, 0);

		PositionXScale = 1;

		FrameAnchorPoint = Vector2.new(0, 0);

		FramePositionXScale = 0;

		ThicknessMultiplier = 1;

	}

	tbl_10.right = tbl_9

	tbl_9 = tbl_10[tbl_2.dropdownAlignment:lower()]

	local var722 = tbl_9

	if not var722 then

		var722 = tbl_10[tbl_2.iconAlignment:lower()]

	end

	dropdownContainer.AnchorPoint = var722.AnchorPoint

	dropdownContainer.Position = UDim2.new(var722.PositionXScale, 0, 1, Offset + 0)

	local var723 = tbl_2.scrollBarThickness * var722.ThicknessMultiplier

	if dropdownFrame.VerticalScrollBarPosition ~= Enum.VerticalScrollBarPosition.Right or not var723 then

	end

	if not var722.FrameAnchorPoint then

	end

	dropdownFrame.AnchorPoint = var722.AnchorPoint

	local FramePositionXScale = var722.FramePositionXScale

	if not FramePositionXScale then

		FramePositionXScale = var722.PositionXScale

	end

	dropdownFrame.Position = UDim2.new(FramePositionXScale, -var723, 0, 0)

	arg1._dropdownCanvasPos = Vector2.new(0, 0)

end

function module_upvr._dropdownIgnoreClipping(arg1) -- Line 2415

	arg1:_ignoreClipping("dropdown")

end

function module_upvr.setMenu(arg1, arg2) -- Line 2421

	for _, v_30 in pairs(arg1.menuIcons) do

		v_30:leave()

	end

	if type(arg2) == "table" then

		for _, v_31 in pairs(arg2) do

			v_31:join(arg1, "menu", true)

		end

	end

	arg1:_updateMenu()

	return arg1

end

function module_upvr._getMenuDirection(arg1) -- Line 2437

	local var735

	local var736

	if var735 ~= "left" and var735 ~= "right" then

		if arg1:get("alignment") or string.lower("_NIL") == "left" then

			var736 = "right"

		else

			var736 = "left"

		end

		var735 = var736

	end

	return var735

end

function module_upvr._updateMenu(arg1) -- Line 2446

	--[[ Upvalues[1]:

		[1]: IconController_upvr (readonly)

	]]

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	local tbl_8 = {

		maxIconsBeforeScroll = arg1:get("menuMaxIconsBeforeScroll") or "_NIL";

		direction = arg1:get("menuDirection") or "_NIL";

		iconAlignment = arg1:get("alignment") or "_NIL";

		scrollBarThickness = arg1:get("menuScrollBarThickness") or "_NIL";

	}

	local var761

	for _, v_32 in pairs(tbl_8) do

		if v_32 == "_NIL" then return end

	end

	local var754 = IconController_upvr[tbl_8.iconAlignment.."Gap"]

	local menuContainer = arg1.instances.menuContainer

	local len = #arg1.menuIcons

	local any__getMenuDirection_result1 = arg1:_getMenuDirection()

	if tbl_8.maxIconsBeforeScroll >= len or not tbl_8.maxIconsBeforeScroll then

		local var758 = len

	end

	local function INLINED_21() -- Internal function, doesn't exist in bytecode

		function var761(arg1_7, arg2) -- Line 2466

			local var760

			if arg1_7:get("order") >= arg2:get("order") then

				var760 = false

			else

				var760 = true

			end

			return var760

		end

		return var761

	end

	if any__getMenuDirection_result1 ~= "right" or not INLINED_21() then

		function var761(arg1_8, arg2) -- Line 2466

			local var762

			if arg2:get("order") >= arg1_8:get("order") then

				var762 = false

			else

				var762 = true

			end

			return var762

		end

	end

	table.sort(arg1.menuIcons, var761)

	for i_34 = 1, len do

		local any_get_result1_5 = arg1.menuIcons[i_34]:get("iconSize")

		local var764

		if i_34 <= var758 then

			var764 += any_get_result1_5.X.Offset + var754

		end

		if i_34 == var758 then

			if i_34 ~= len then

				var764 -= 2

			end

		end

		-- KONSTANTERROR: Expression was reused, decompilation is incorrect

		local Offset_2 = any_get_result1_5.Y.Offset

		if 0 < Offset_2 then

		end

	end

	if var758 == len then

		local _ = 0

	else

	end

	arg1:set("menuCanvasSize", UDim2.new(0, (-var754) + (any_get_result1_5.X.Offset + var754) + var754, 0, 0))

	arg1:set("menuSize", UDim2.new(0, var764, 0, Offset_2 + tbl_8.scrollBarThickness + 3))

	local tbl_6 = {}

	local tbl_7 = {

		containerAnchorPoint = Vector2.new(1, 0);

		containerPosition = UDim2.new(0, -4, 0, 0);

	}

	-- KONSTANTERROR: Expression was reused, decompilation is incorrect

	tbl_7.canvasPosition = Vector2.new((-var754) + (any_get_result1_5.X.Offset + var754) + var754, 0)

	tbl_6.left = tbl_7

	tbl_6.right = {

		containerAnchorPoint = Vector2.new(0, 0);

		containerPosition = UDim2.new(1, var754 - 2, 0, 0);

		canvasPosition = Vector2.new(0, 0);

	}

	local var770 = tbl_6[any__getMenuDirection_result1]

	menuContainer.AnchorPoint = var770.containerAnchorPoint

	menuContainer.Position = var770.containerPosition

	arg1.instances.menuFrame.CanvasPosition = var770.canvasPosition

	arg1._menuCanvasPos = var770.canvasPosition

	arg1.instances.menuList.Padding = UDim.new(0, var754)

end

function module_upvr._menuIgnoreClipping(arg1) -- Line 2511

	arg1:_ignoreClipping("menu")

end

function module_upvr.destroy(arg1) -- Line 2518

	--[[ Upvalues[1]:

		[1]: IconController_upvr (readonly)

	]]

	if arg1._destroyed then

	else

		IconController_upvr.iconRemoved:Fire(arg1)

		arg1:clearNotices()

		if arg1._parentIcon then

			arg1:leave()

		end

		arg1:setDropdown()

		arg1:setMenu()

		arg1._destroyed = true

		arg1._maid:clean()

	end

end

module_upvr.Destroy = module_upvr.destroy

return module_upvr
