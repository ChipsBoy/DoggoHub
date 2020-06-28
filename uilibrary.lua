--// game checker \\--

if not game.Loaded then
	game:IsLoaded():wait()
end

local library = {}
local tabcount = 0
local countforthing = 0
local Tweens = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
local uionline = true

local function create(obj, properties)
	obj = Instance.new(obj)
	for i,v in pairs(properties) do
		if i ~= "Parent" then
			obj[i] = v
		end
	end
	obj.Parent = properties.Parent
	return obj
end

for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do
	if v.Name == "uilib" then
		v:Destroy()
	end
end

for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetChildren()) do
	if v.Name == "uilib" then
		v:Destroy()
	end
end

local uilib = create("ScreenGui", {
	Name = "uilib",
	Parent = game:GetService("RunService"):IsStudio() and game:GetService("Players").LocalPlayer.PlayerGui or game:GetService("CoreGui"),
})

uis.InputBegan:connect(function(key, processed)
	if key.KeyCode == Enum.KeyCode.LeftControl then
		uionline = not uionline
		uilib.Enabled = uionline
	end
end)

game:GetService('StarterGui'):SetCore('SendNotification', {
	Title = 'Doggo Hub Loaded!';
	Text = 'Press CTRL to toggle the UI'
})

function library:AddTab(title, color)
	local functions = {}
	local tabcount = 8
	local tabname = 1
	local tabopened
	
	local TopBar = create("ImageLabel", {
		Name = "TopBar",
		Parent = uilib,
		BackgroundTransparency = 1.000,
		Position = UDim2.new(0.00664621685, 0, 0.00917431153, 0),
		Size = UDim2.new(0, 184, 0, 43),
		ZIndex = 0,
		Image = "rbxassetid://3570695787",
		ImageColor3 = color or Color3.fromRGB(255, 0, 0),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.070,
	})
	
	local Background = create("Frame", {
		Name = "Background",
		Parent = TopBar,
		BackgroundColor3 = Color3.fromRGB(49, 49, 49),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0, 33),
		Size = UDim2.new(0, 184, 0, 9),
	})
	
	local BottomBar = create("ImageLabel", {
		Name = "BottomBar",
		Parent = Background,
		BackgroundTransparency = 1.000,
		Position = UDim2.new(0, 0, 1, -9),
		Size = UDim2.new(0, 184, 0, 43),
		ZIndex = 0,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(49, 49, 49),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.070,
		AnchorPoint = Vector2.new(0,0.5),
	})
	
	local MainName = create("TextLabel", {
		Name = "MainName",
		Parent = Background,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0, -33),
		Size = UDim2.new(0, 184, 0, 33),
		Font = Enum.Font.SciFi,
		Text = title,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 18.000,
    })
    
    TopBar.InputBegan:connect(function(key)
        local mouse = game:GetService('Players').LocalPlayer:GetMouse()
        local mb1 = Enum.UserInputType.MouseButton1
        local m = {
            x = 0;
            y = 0;
        }
        if key.UserInputType == mb1 then
            local as = TopBar.AbsolutePosition
            local pos = Vector2.new(mouse.X-as.X,mouse.Y-as.Y)
            while pos.Y < 20 and game:GetService('RunService').Heartbeat:wait() and game:GetService('UserInputService'):IsMouseButtonPressed(mb1) do
                local obj = {
                    mouse.X-pos.X,
                    TopBar.Size.X.Offset*TopBar.AnchorPoint.X,
                    mouse.Y-pos.Y,
                    TopBar.Size.Y.Offset*TopBar.AnchorPoint.Y
                }
                if m.X ~= mouse.X or m.Y ~= mouse.Y then
                    TopBar:TweenPosition(UDim2.new(0,obj[1]+obj[2],0,obj[3]+obj[4]),'Out','Quad',.2,true)
                end
                m.X = mouse.X
                m.Y = mouse.Y
            end
        end
    end)

	function functions:AddCategory(text)
		local tabfunctions = {}
		local count = 8
		local Tab = create("ImageLabel", {
			Name = "Tab",
			Parent = Background,
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0, 8, 0, tabcount),
			Size = UDim2.new(0, 168, 0, 37),
			Image = "rbxassetid://3570695787",
			ImageColor3 = Color3.fromRGB(84, 84, 84),
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(100, 100, 100, 100),
			SliceScale = 0.070,
		})
		local TabName = create("TextLabel", {
			Name = "TabName",
			Parent = Tab,
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0.047619015, 0, 0, 0),
			Size = UDim2.new(0, 160, 0, 37),
			Font = Enum.Font.GothamSemibold,
			Text = text,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 16.000,
			TextXAlignment = Enum.TextXAlignment.Left,
		})
		local Open = create("TextButton", {
			Name = "Open",
			Parent = Tab,
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0.809523821, 0, 0, 0),
			Size = UDim2.new(0, 32, 0, 37),
			Font = Enum.Font.SourceSansBold,
			Text = ">",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 26.000,
		})
		local CategoryTopBar = create("ImageLabel", {
			Name = "CategoryTopBar",
			Parent = Tab,
			BackgroundTransparency = 1.000,
			Position = UDim2.new(1.13690472, 0, -0.936771691, 0),
			Size = UDim2.new(0, 0, 0, 43),
			ZIndex = 0,
			Image = "rbxassetid://3570695787",
			ImageColor3 = color or Color3.fromRGB(255, 0, 0),
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(100, 100, 100, 100),
			SliceScale = 0.070,
        })

		local CategoryBackground = create("Frame", {
			Name = "CategoryBackground",
			Parent = CategoryTopBar,
			BackgroundColor3 = Color3.fromRGB(49, 49, 49),
			BorderSizePixel = 0,
			ClipsDescendants = true,
			Position = UDim2.new(0, 0, 0, 34),
			Size = UDim2.new(0, 0, 0, 9),
			Visible = false,
		})
		local CategoryName = create("TextLabel", {
			Name = "CategoryName",
			Parent = CategoryTopBar,
			BackgroundTransparency = 1.000,
			Size = UDim2.new(0, 0, 0, 34),
			Font = Enum.Font.SciFi,
			Text = text,
			TextTransparency = 1,
			TextSize = 16.000,
			TextColor3 = Color3.fromRGB(255, 255, 255),
		})
		local CategoryBottomBar = create("ImageLabel", {
			Name = "CategoryBottomBar",
			Parent = CategoryTopBar,
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundTransparency = 1.000,
			ClipsDescendants = true,
			Position = UDim2.new(0, 0, 1, 60),
			Size = UDim2.new(0, 0, 0, 9),
			ZIndex = 0,
			Image = "rbxassetid://3570695787",
			ImageColor3 = Color3.fromRGB(49, 49, 49),
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(100, 100, 100, 100),
			SliceScale = 0.070,
			AnchorPoint = Vector2.new(0,0.5)
		})
		local opend = false
		Open.MouseButton1Click:Connect(function()
			opend = not opend
			if tabopened then
				Tweens:Create(tabopened.Open, TweenInfo.new(0.3), {Rotation = 0}):Play()
				Tweens:Create(tabopened.CategoryTopBar.CategoryBackground, TweenInfo.new(0.3), {Size = UDim2.new(0, 173, 0, 9)}):Play()
				Tweens:Create(tabopened.CategoryTopBar.CategoryBottomBar, TweenInfo.new(0.3), {Size = UDim2.new(0, 173, 0, 0), Position = UDim2.new(0,0,1,-10)}):Play()
				wait(0.35)
				Tweens:Create(tabopened.CategoryTopBar.CategoryName, TweenInfo.new(0.1), {TextTransparency = 1}):Play()
				Tweens:Create(tabopened.CategoryTopBar.CategoryName, TweenInfo.new(0.2), {Size = UDim2.new(0,0,0,34)}):Play()
				Tweens:Create(tabopened.CategoryTopBar, TweenInfo.new(0.2), {Size = UDim2.new(0,0,0,43)}):Play()
				Tweens:Create(tabopened.CategoryTopBar.CategoryBackground, TweenInfo.new(0.2), {Size = UDim2.new(0,0,0,9)}):Play()
				wait(0.2)
				tabopened.CategoryTopBar.CategoryBackground.Visible = false
				tabopened.CategoryTopBar.Visible = false
				tabopened.CategoryTopBar.CategoryName.Visible = false
				tabopened.CategoryTopBar.CategoryBottomBar.Visible = false
				opend = false
			end
			if opend == true then
				CategoryBackground.Visible = true
				CategoryTopBar.Visible = true
				CategoryName.Visible = true
				CategoryBottomBar.Visible = true
				Tweens:Create(Open, TweenInfo.new(0.3), {Rotation = 180}):Play()
				Tweens:Create(CategoryName, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
				Tweens:Create(CategoryName, TweenInfo.new(0.2), {Size = UDim2.new(0,173,0,34)}):Play()
				Tweens:Create(CategoryTopBar, TweenInfo.new(0.2), {Size = UDim2.new(0,173,0,43), Position = UDim2.new(1.137,0,-0.937,0)}):Play()
				Tweens:Create(CategoryBackground, TweenInfo.new(0.2), {Size = UDim2.new(0,173,0,9)}):Play()
				wait(0.35)
				Tweens:Create(CategoryBackground, TweenInfo.new(0.3), {Size = UDim2.new(0, 173, 0, count), Position = UDim2.new(0,0,0,34)}):Play()
				Tweens:Create(CategoryBottomBar, TweenInfo.new(0.3), {Position = UDim2.new(0, 0, 1, count + -20)}):Play()
				wait(0.1)
				Tweens:Create(CategoryBottomBar, TweenInfo.new(0.3), {Size = UDim2.new(0, 173, 0, 43)}):Play()
				tabopened = Tab
			end
			if opend == false then
				Tweens:Create(Open, TweenInfo.new(0.3), {Rotation = 0}):Play()
				Tweens:Create(CategoryBackground, TweenInfo.new(0.3), {Size = UDim2.new(0, 173, 0, 9)}):Play()
				Tweens:Create(CategoryBottomBar, TweenInfo.new(0.3), {Size = UDim2.new(0, 173, 0, 0), Position = UDim2.new(0,0,1,-10)}):Play()
				wait(0.35)
				Tweens:Create(CategoryName, TweenInfo.new(0.1), {TextTransparency = 1}):Play()
				Tweens:Create(CategoryName, TweenInfo.new(0.2), {Size = UDim2.new(0,0,0,34)}):Play()
				Tweens:Create(CategoryTopBar, TweenInfo.new(0.2), {Size = UDim2.new(0,0,0,43)}):Play()
				Tweens:Create(CategoryBackground, TweenInfo.new(0.2), {Size = UDim2.new(0,0,0,9)}):Play()
				wait(0.2)
				CategoryBackground.Visible = false
				CategoryTopBar.Visible = false
				CategoryName.Visible = false
				CategoryBottomBar.Visible = false
				tabopened = nil
			end
		end)
		countforthing = countforthing + 37 + 9
		tabcount = tabcount + 45
		Background.Size = UDim2.new(0,184,0,countforthing)
		function tabfunctions:AddToggle(text, default, callback)
			local ToggleHolder = create("ImageLabel", {
				Name = "ToggleHolder",
				Parent = CategoryBackground,
				BackgroundTransparency = 1.000,
				Position = UDim2.new(0, 9, 0, count),
				Size = UDim2.new(0, 155, 0, 32),
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(66, 66, 66),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.070,
				Active = true,
				Visible = false
			})
			local ToggleButton = create("TextButton", {
				Name = "ToggleButton",
				Parent = ToggleHolder,
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 155, 0, 32),
				Position = UDim2.new(0,0,0,0),
				ZIndex = 4,
				Font = Enum.Font.SourceSans,
				TextTransparency = 1.000,
			})
			local ToggleButtonArea = create("ImageLabel", {
				Name = "ToggleButtonArea",
				Parent = ToggleButton,
				Active = true,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1.000,
				Position = UDim2.new(0.825806439, 0, 0.5, 0),
				Selectable = true,
				Size = UDim2.new(0, 40, 0, 20),
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(109, 109, 109),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.070
			})
			local ToggleSlide = create("ImageLabel", {
				Name = "ToggleSlide",
				Parent = ToggleButton,
				BackgroundTransparency = 1.000,
				Position = UDim2.new(0.696774185, 0, 0.1875, 0),
				Size = UDim2.new(0, 20, 0, 20),
				ZIndex = 3,
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(255, 0, 0),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.070,
			})
			local ToggleName = create("TextLabel", {
				Name = "ToggleName",
				Parent = ToggleHolder,
				BackgroundTransparency = 1.000,
				Position = UDim2.new(0.0344210304, 0, -0.0221412554, 0),
				Size = UDim2.new(0, 149, 0, 32),
				Font = Enum.Font.SourceSansSemibold,
				Text = text or "Invalid Name!",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 16.000,
				TextXAlignment = Enum.TextXAlignment.Left,
			})
			
			local toggled = default or false
			
			ToggleButton.MouseButton1Click:Connect(function()
				toggled = not toggled
				if toggled == true then
					Tweens:Create(ToggleSlide, TweenInfo.new(0.2), {Position = UDim2.new(0.826,0,0.188,0)}):Play()
					ToggleSlide.ImageColor3 = Color3.fromRGB(0,255,0)
				end
				if toggled == false then
					Tweens:Create(ToggleSlide, TweenInfo.new(0.2), {Position = UDim2.new(0.697,0,0.188,0)}):Play()
					ToggleSlide.ImageColor3 = Color3.fromRGB(255,0,0)
				end
				callback(toggled)
			end)
			
			Open.MouseButton1Click:Connect(function()
				wait(0.1)
				if CategoryBackground.Visible == true then
					ToggleHolder.Visible = true
				end
				if CategoryBackground.Visible == false then
					ToggleHolder.Visible = false
				end
			end)
			count = count + 36
			CategoryBackground.Size = UDim2.new(0,173,0,count)
		end
		function tabfunctions:AddButton(text, callback)
			local ButtonHolder = create("ImageLabel", {
				Name = "ButtonHolder",
				Parent = CategoryBackground,
				BackgroundTransparency = 1.000,
				Position = UDim2.new(0, 9, 0, count),
				Size = UDim2.new(0, 155, 0, 32),
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(66, 66, 66),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.070,
				Active = true,
				Visible = false,
			})
			local Button = create("TextButton", {
				Name = "Button",
				Parent = ButtonHolder,
				BackgroundTransparency = 1.000,
				Size = UDim2.new(0, 155, 0, 32),
				TextTransparency = 1.000,
				ZIndex = 4,
			})
			local ButtonRound = create("ImageLabel", {
				Name = "ButtonRound",
				Parent = Button,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1.000,
				Position = UDim2.new(0.497775078, 0, 0.476902246, 0),
				Selectable = true,
				Size = UDim2.new(0, 147, 0, 24),
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(255, 0, 0),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.070,
			})
			local ButtonName = create("TextLabel", {
				Name = "ButtonName",
				Parent = ButtonRound,
				BackgroundTransparency = 1.000,
				Size = UDim2.new(0, 147, 0, 24),
				Font = Enum.Font.SciFi,
				Text = text,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 14.000,
			})
			
			Open.MouseButton1Click:Connect(function()
				wait(0.1)
				if CategoryBackground.Visible == true then
					ButtonHolder.Visible = true
				end
				if CategoryBackground.Visible == false then
					ButtonHolder.Visible = false
				end
			end)
			
			Button.MouseButton1Click:Connect(function()
				Tweens:Create(ButtonRound, TweenInfo.new(0.1), {Size = UDim2.new(0,143,0,20)}):Play()
				Tweens:Create(ButtonName, TweenInfo.new(0.1), {Size = UDim2.new(0,143,0,20), TextSize = 0}):Play()
				wait(0.1)
				Tweens:Create(ButtonName, TweenInfo.new(0.1), {Size = UDim2.new(0,147,0,24), TextSize = 14}):Play()
				Tweens:Create(ButtonRound, TweenInfo.new(0.1), {Size = UDim2.new(0,147,0,24)}):Play()
			end)
			Button.MouseButton1Click:Connect(callback)
			count = count + 36
			CategoryBackground.Size = UDim2.new(0,173,0,count)
		end
        function tabfunctions:AddSlider(text, min, max, callback)
            local value = 0
			local SliderHolder = create("ImageLabel", {
				Name = "SliderHolder",
				Parent = CategoryBackground,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 8, 0, count),
				Size = UDim2.new(0, 155, 0, 42),
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(66, 66, 66),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.070
			})
			local SliderName = create("TextLabel", {
				Name = "SliderName",
				Parent = SliderHolder,
				BackgroundTransparency = 1,
				Position = UDim2.new(0.045161292, 0, 0, 0),
				Size = UDim2.new(0, 149, 0, 24),
				Font = Enum.Font.SourceSansSemibold,
				Text = text,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 16,
				TextXAlignment = Enum.TextXAlignment.Left
			})
			local ValueHolder = create("ImageLabel", {
				Name = "ValueHolder",
				Parent = SliderHolder,
				BackgroundTransparency = 1.000,
				Position = UDim2.new(0.703225791, 0, 0.097883597, 0),
				Size = UDim2.new(0, 40, 0, 15),
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(154, 154, 154),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.070
			})
			local Value = create("TextLabel", {
				Name = "Value",
				Parent = ValueHolder,
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 40, 0, 15),
				Font = Enum.Font.SourceSansSemibold,
				Text = "0",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 14.000,
				TextWrapped = true,
			})
			local SlidingArea = create("TextButton", {
				Name = "SlidingArea",
				Parent = SliderHolder,
				BackgroundTransparency = 1.000,
				Position = UDim2.new(0, 9, 0, 30),
				Size = UDim2.new(0, 140, 0, 5),
				TextTransparency = 1,
			})
			local SlidingAreaRound = create("ImageLabel", {
				Name = "SlidingAreaRound",
				Parent = SlidingArea,
				Active = true,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 69, 0, 2),
				Selectable = true,
				Size = UDim2.new(0, 140, 0, 5),
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(148, 148, 148),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.090,
			})
			local Slider = create("TextButton", {
				Name = "Slider",
				Parent = SlidingAreaRound,
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 0, 0, 5),
				TextTransparency = 1,
			})
			local SliderRound = create("ImageLabel", {
				Name = "SliderRound",
				Parent = Slider,
				Active = true,
				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundTransparency = 1,
				Position = UDim2.new(0.5, 0, -3.87430191e-07, 0),
				Selectable = true,
				Size = UDim2.new(1, 0, 1, 0),
				Image = "rbxassetid://3570695787",
				ImageColor3 = color or Color3.fromRGB(255,0,0),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.090
			})
			local MouseDown = false

			local UIStart = SlidingArea.AbsolutePosition.X
			local UIEnd = SlidingArea.AbsolutePosition.X + SlidingArea.AbsoluteSize.X

          		function map(x, in_min, in_max, out_min, out_max)
			    return out_min + (x - in_min)*(out_max - out_min)/(in_max - in_min)
			end

			Slider.MouseButton1Down:Connect(function()
			    MouseDown = true
			end)
		
			SlidingArea.MouseButton1Down:Connect(function()
			    MouseDown = true	
			end)

			uis.InputEnded:Connect(function(input)
			     if input.UserInputType == Enum.UserInputType.MouseButton1 then
				 MouseDown = false
			     end
			end)

			game:GetService("RunService").RenderStepped:Connect(function()
			     if MouseDown then
				 local range = map(game:GetService("Players").LocalPlayer:GetMouse().X, UIStart, UIEnd, 0, 1)
			         range = math.clamp(range, 0, 1)
			         value = math.floor(map(range, 0, 1, min, max))
				 Slider:TweenSize(UDim2.new(range,0,0,5), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, .2, true)
				 Value.Text = value
				 callback(value)
			     end
			end)
			count = count + 46
			CategoryBackground.Size = UDim2.new(0,173,0,count)
		end
		function tabfunctions:AddLabel(text)
			local LabelHolder = create("ImageLabel", {
				Name = "LabelHolder",
				Parent = CategoryBackground,
				BackgroundTransparency = 1.000,
				Position = UDim2.new(0, 9, 0, count),
				Size = UDim2.new(0, 155, 0, 32),
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(66, 66, 66),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.070,
			})
			local LabelRound = create("ImageLabel", {
				Name = "LabelRound",
				Parent = LabelHolder,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1.000,
				Position = UDim2.new(0.497775078, 0, 0.476902246, 0),
				Size = UDim2.new(0, 147, 0, 24),
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(99, 99, 99),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.070,
			})
			local TextLabel = create("TextLabel", {
				Name = "TextLabel",
				Parent = LabelRound,
				BackgroundTransparency = 1.000,
				Size = UDim2.new(0, 147, 0, 24),
				Position = UDim2.new(0,0,0,0),
				Text =  text,
				Font = Enum.Font.SourceSansSemibold,
				TextColor3 = Color3.fromRGB(255,255,255),
				TextSize = 16
			})
			count = count + 36
			CategoryBackground.Size = UDim2.new(0,173,0,count)
		end
		function tabfunctions:AddTextbox(placeholder, callback)
			local TextboxHolder = create("ImageLabel", {
				Name = "TextboxHolder",
				Parent = CategoryBackground,
				BackgroundTransparency = 1.000,
				Position = UDim2.new(0, 9, 0, count),
				Size = UDim2.new(0, 155, 0, 32),
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(66, 66, 66),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.070
			})
			local Textbox = create("TextBox", {
				Name = "Textbox",
				Parent = TextboxHolder,
				BackgroundTransparency = 1.000,
				Position = UDim2.new(0.0258064307, 0, 0.125, 0),
				Size = UDim2.new(0, 147, 0, 24),
				ZIndex = 6,
				Font = Enum.Font.SourceSans,
				PlaceholderColor3 = Color3.fromRGB(255, 255, 255),
				PlaceholderText = placeholder,
				Text = "",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 14.000
			})
			local TextboxRound = create("ImageLabel", {
				Name = "TextboxRound",
				Parent = Textbox,
				Active = true,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Selectable = true,
				Size = UDim2.new(1, 0, 1, 0),
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(108, 108, 108),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.070
			})
			Textbox.FocusLost:Connect(function()
				callback(Textbox.Text)
			end)
			count = count + 36
			CategoryBackground.Size = UDim2.new(0,173,0,count)
		end
		function tabfunctions:AddKeybind(text, callback)
			local KeybindHolder = create("ImageLabel", {
				Name = "Keybind Holder",
				Parent = CategoryBackground,
				BackgroundTransparency = 1.000,
				Position = UDim2.new(0, 9, 0, count),
				Size = UDim2.new(0, 155, 0, 32),
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(66, 66, 66),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.070
			}) 
			local Keybind = create("TextBox", {
				Name = "Keybind",
				Parent = KeybindHolder,
				BackgroundTransparency = 1,
				Position = UDim2.new(0.665000021, 0, 0.100000001, 0),
				Size = UDim2.new(0, 45, 0, 25),
				ZIndex = 3,
				Font = Enum.Font.SourceSansSemibold,
				Text = "",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 16.000
			})
			local KeybindRound = create("ImageLabel", {
				Name = "KeybindRound",
				Parent = Keybind,
				Active = true,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1.000,
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Selectable = true,
				Size = UDim2.new(1, 0, 1, 0),
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(154, 154, 154),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.070,
			})
			local KeybindName = create("TextLabel", {
				Name = "KeybindName",
				Parent = KeybindHolder,
				BackgroundTransparency = 1.000,
				Position = UDim2.new(0.0387096778, 0, 0.0403585434, 0),
				Size = UDim2.new(0, 148, 0, 32),
				Font = Enum.Font.SourceSansSemibold,
				Text = text,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 16.000,
				TextXAlignment = Enum.TextXAlignment.Left
			})
			Keybind.FocusLost:Connect(function()
				callback(Keybind.Text)
			end)
			count = count + 36
			CategoryBackground.Size = UDim2.new(0,173,0,count)
		end
		return tabfunctions
	end
	return functions
end
return library
