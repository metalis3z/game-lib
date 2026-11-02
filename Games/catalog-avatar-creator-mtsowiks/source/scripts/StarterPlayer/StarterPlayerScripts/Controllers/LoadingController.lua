-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local LoadingOverlay = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("LoadingOverlay");
local container = LoadingOverlay:WaitForChild("container");
local u1 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u2 = nil;
local loading = script:FindFirstChild("loading");
local footLoading = script:FindFirstChild("footLoading");
local graphic = script:FindFirstChild("graphic");
local u3 = {
    reachedEnd = {
        images = { "rbxassetid://114057074300923", "rbxassetid://95868755749018" },
        topText = { "You\'ve reached the end.", "No more items left.", "That\'s all." },
        bottomText = { "This is a dead end. There\'s nothing left.", "Try using different words or searching for something else.", "There\'s no more items related to your search." }
    },
    noResults = {
        images = { "rbxassetid://91886330245395", "rbxassetid://98232732323904" },
        topText = { "We couldn\'t find anything related to your search.", "Nothing matched your search.", "We didn\'t find any results for that query." },
        bottomText = { "Try adjusting your keywords or checking your spelling.", "Using broader terms can help discover more items.", "Try searching for something similar." }
    },
    searchWasFiltered = {
        images = { "rbxassetid://130463517094670", "rbxassetid://120745988404539" },
        topText = { "Your search term was blocked by our filter.", "That search query isn\'t allowed.", "These words break our content rules." },
        bottomText = { "The words you used were deemed to be inappropriate.", "Use a different set of words to continue.", "Please remove any restricted terms and try again." }
    },
    serverError = {
        images = { "rbxassetid://116560339250462", "rbxassetid://97849971417899" },
        topText = { "Something went wrong during your request.", "There was an internal error while processing your request.", "An unexpected error occurred." },
        bottomText = { "This may be an issue on Roblox\'s side, please be patient.", "Roblox might be experiencing temporary problems. Try again shortly.", "There may be a temporary issue on Roblox\'s side, please try again later." }
    }
};
local u4 = {
    CurrentLoadingOverlay = nil,
    CurrentGraphics = {}
};

local function getRandomGraphicProperty(p5, p6) -- Line: 88
    return p5[p6] and p5[p6][math.random(#p5[p6])] or "";
end;

local function getPositionByFrame(p7) -- Line: 92
    local v8 = p7 - 1;
    local v9 = math.floor(v8 / 2);

    return UDim2.fromScale(-(v8 % 2), -v9);
end;

function u4.RemoveLoading() -- Line: 99
    -- upvalues: u4 (copy), u2 (ref), LoadingOverlay (copy), TweenService (copy), u1 (copy)
    local CurrentLoadingOverlay = u4.CurrentLoadingOverlay;

    if not CurrentLoadingOverlay then
        return;
    end;

    u4.CurrentLoadingOverlay = nil;
    task.spawn(function() -- Line: 104
        -- upvalues: u2 (ref), CurrentLoadingOverlay (copy), LoadingOverlay (ref), TweenService (ref), u1 (ref), u4 (ref)
        pcall(task.cancel, u2);
        local v10;

        if CurrentLoadingOverlay == LoadingOverlay then
            v10 = CurrentLoadingOverlay.container.runnerContainer;
        else
            v10 = CurrentLoadingOverlay:FindFirstChild("container");
        end;

        if v10 then
            v10 = v10:FindFirstChild("runner");
        end;

        if v10 then
            local v11 = TweenService:Create(v10, u1, {
                ImageTransparency = 1
            });

            if CurrentLoadingOverlay == LoadingOverlay then
                TweenService:Create(LoadingOverlay.container, u1, {
                    BackgroundTransparency = 1
                }):Play();
            end;

            v11:Play();
            v11.Completed:Wait();

            if CurrentLoadingOverlay == LoadingOverlay then
                v10:Destroy();
            end;
        end;

        if CurrentLoadingOverlay == LoadingOverlay then
            if u4.CurrentLoadingOverlay == nil then
                LoadingOverlay.Enabled = false;
            end;
        else
            CurrentLoadingOverlay:Destroy();
        end;
    end);
end;

function u4.DisplayLoading(u12, u13) -- Line: 130
    -- upvalues: u4 (copy), LoadingOverlay (copy), container (copy), loading (copy), TweenService (copy), u1 (copy), footLoading (copy), u2 (ref)
    print("displaying loading");
    task.spawn(function() -- Line: 132
        -- upvalues: u4 (ref), u13 (copy), u12 (copy), LoadingOverlay (ref), container (ref), loading (ref), TweenService (ref), u1 (ref), footLoading (ref), u2 (ref)
        if u4.CurrentLoadingOverlay ~= nil then
            u4.RemoveLoading();
        end;

        local v14, u15;

        if u13 == "overlay" and u12 == nil then
            LoadingOverlay.Enabled = true;
            v14 = LoadingOverlay;
            container.BackgroundTransparency = 1;
            u15 = container.runnerContainer:FindFirstChild("runner");

            if not u15 then
                u15 = loading:FindFirstChild("container"):FindFirstChild("runner"):Clone();
                u15.Parent = container.runnerContainer;
                TweenService:Create(LoadingOverlay.container, u1, {
                    BackgroundTransparency = 0.5
                }):Play();
            end;
        else
            local v16;

            if u13 == "overlay" then
                v16 = loading;
            else
                v16 = footLoading;
            end;

            v14 = v16:Clone();
            u15 = v14:FindFirstChild("container"):FindFirstChild("runner");
            v14.Parent = u12;
        end;

        u4.CurrentLoadingOverlay = v14;
        u15.ImageTransparency = 1;
        local v17 = TweenService:Create(u15, u1, {
            ImageTransparency = 0
        });
        u2 = task.spawn(function() -- Line: 164
            -- upvalues: u15 (ref)
            local v18 = 1;
            local v19 = true;

            while true do
                while true do
                    local v20 = v18 - 1;
                    local v21 = math.floor(v20 / 2);
                    u15.Position = UDim2.fromScale(-(v20 % 2), -v21);
                    task.wait(0.06);

                    if not v19 then
                        break;
                    end;

                    v18 = v18 + 1;

                    if v18 > 6 then
                        v18 = 5;
                        v19 = false;
                    end;
                end;

                v18 = v18 - 1;

                if v18 < 1 then
                    v18 = 2;
                    v19 = true;
                end;
            end;
        end);
        v17:Play();
    end);
end;

function u4.ClearGraphics(p22) -- Line: 191
    -- upvalues: u4 (copy)
    local v23 = u4.CurrentGraphics[p22];

    if v23 then
        v23:Destroy();
        u4.CurrentGraphics[p22] = nil;
    end;
end;

function u4.DisplayGraphic(p24, p25, p26) -- Line: 199
    -- upvalues: u4 (copy), u3 (copy), graphic (copy)
    if u4.CurrentGraphics[p25] then
        u4.ClearGraphics(p25);
    end;

    local v27 = u3[p26];
    local v28 = graphic:Clone();
    local v29 = v27.images and (v27.images[math.random(#v27.images)] or "") or "";
    local v30 = v27.topText and (v27.topText[math.random(#v27.topText)] or "") or "";
    local v31 = v27.bottomText and v27.bottomText[math.random(#v27.bottomText)] or "";
    v28.image.Image = v29;
    v28.topLabel.Text = v30;
    v28.bottomLabel.Text = v31;
    u4.CurrentGraphics[p25] = v28;
    v28.Parent = p24;
end;

return u4;