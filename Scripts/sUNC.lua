local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")

local aliteralbaseplateJoinID = 4483381587

StarterGui:SetCore("SendNotification", {
	Title = "Impulse",
	Text = "IMPULSE ON TOP! dsc.gg/impulserbx",
	Duration = 9
})

if game.PlaceId ~= aliteralbaseplateJoinID then
	StarterGui:SetCore("SendNotification", {
		Title = "Impulse",
		Text = "A custom prompt is appearing to recommend joining the baseplate.",
		Duration = 5
	})

	local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "TeleportPromptGui"
	ScreenGui.Parent = PlayerGui
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "TeleportPromptFrame"
	MainFrame.Size = UDim2.new(0, 350, 0, 180) 
	MainFrame.Position = UDim2.new(0.5, -175, 0.5, -90) 
	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45) 
	MainFrame.BorderSizePixel = 0
	MainFrame.ClipsDescendants = true 
	MainFrame.Parent = ScreenGui

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 16) 
	UICorner.Parent = MainFrame

	local UIGradient = Instance.new("UIGradient")
	UIGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 70)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 45)) 
	}
	UIGradient.Rotation = 90
	UIGradient.Parent = MainFrame

	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.fromRGB(70, 70, 90)
	UIStroke.Thickness = 1.5
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.Parent = MainFrame

	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint.AspectRatio = MainFrame.Size.X.Offset / MainFrame.Size.Y.Offset
	UIAspectRatioConstraint.Parent = MainFrame

	local TitleBar = Instance.new("Frame")
	TitleBar.Name = "TitleBar"
	TitleBar.Size = UDim2.new(1, 0, 0, 30) 
	TitleBar.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
	TitleBar.BorderSizePixel = 0
	TitleBar.Parent = MainFrame

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Name = "TitleLabel"
	TitleLabel.Size = UDim2.new(1, 0, 1, 0)
	TitleLabel.Text = "Impulse Teleport"
	TitleLabel.TextColor3 = Color3.new(1, 1, 1)
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.TextSize = 18
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Parent = TitleBar

	local MessageLabel = Instance.new("TextLabel")
	MessageLabel.Name = "MessageLabel"
	MessageLabel.Size = UDim2.new(0.9, 0, 0.4, 0) 
	MessageLabel.Position = UDim2.new(0.5, 0, 0.5, -20) 
	MessageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	MessageLabel.Text = "To get the most accurate results, Would you like to teleport to a literal baseplate?"
	MessageLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	MessageLabel.Font = Enum.Font.Gotham
	MessageLabel.TextSize = 16
	MessageLabel.TextWrapped = true
	MessageLabel.TextXAlignment = Enum.TextXAlignment.Center
	MessageLabel.BackgroundTransparency = 1
	MessageLabel.Parent = MainFrame

	local ButtonsFrame = Instance.new("Frame")
	ButtonsFrame.Name = "ButtonsFrame"
	ButtonsFrame.Size = UDim2.new(1, -20, 0, 40)
	ButtonsFrame.Position = UDim2.new(0.5, 0, 1, -50)
	ButtonsFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	ButtonsFrame.BackgroundTransparency = 1
	ButtonsFrame.Parent = MainFrame

	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.Padding = UDim.new(0, 15) 
	UIListLayout.Parent = ButtonsFrame

	local YesButton = Instance.new("TextButton")
	YesButton.Name = "YesButton"
	YesButton.Size = UDim2.new(0.45, 0, 1, 0) 
	YesButton.Text = "Yes"
	YesButton.Font = Enum.Font.GothamBold
	YesButton.TextSize = 18
	YesButton.TextColor3 = Color3.new(1, 1, 1)
	YesButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
	YesButton.BorderSizePixel = 0
	YesButton.Parent = ButtonsFrame

	local YesUICorner = Instance.new("UICorner")
	YesUICorner.CornerRadius = UDim.new(0, 8)
	YesUICorner.Parent = YesButton

	local NoButton = Instance.new("TextButton")
	NoButton.Name = "NoButton"
	NoButton.Size = UDim2.new(0.45, 0, 1, 0)
	NoButton.Text = "No"
	NoButton.Font = Enum.Font.GothamBold
	NoButton.TextSize = 18
	NoButton.TextColor3 = Color3.new(1, 1, 1)
	NoButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50) 
	NoButton.BorderSizePixel = 0
	NoButton.Parent = ButtonsFrame

	local NoUICorner = Instance.new("UICorner")
	NoUICorner.CornerRadius = UDim.new(0, 8)
	NoUICorner.Parent = NoButton

	local dragging = false
	local dragStart = Vector2.new(0, 0)
	local initialPosition = UDim2.new(0, 0, 0, 0)

	TitleBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			initialPosition = MainFrame.Position
			MainFrame:SetZIndex(10)
		end
	end)

	TitleBar.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
			MainFrame:SetZIndex(1)
		end
	end)

	Players.LocalPlayer:GetMouse().Move:Connect(function()
		if dragging then
			local delta = Players.LocalPlayer:GetMouse().X - dragStart.X
			local deltaY = Players.LocalPlayer:GetMouse().Y - dragStart.Y

			MainFrame.Position = UDim2.new(
				initialPosition.X.Scale,
				initialPosition.X.Offset + delta,
				initialPosition.Y.Scale,
				initialPosition.Y.Offset + deltaY
			)
		end
	end)

	local function createButtonHoverEffect(button)
		local defaultColor = button.BackgroundColor3
		local hoverColor = defaultColor:Lerp(Color3.new(1, 1, 1), 0.15)
		local pressedColor = defaultColor:Lerp(Color3.new(0, 0, 0), 0.15) 

		local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		button.MouseEnter:Connect(function()
			TweenService:Create(button, tweenInfo, { BackgroundColor3 = hoverColor }):Play()
		end)

		button.MouseLeave:Connect(function()
			TweenService:Create(button, tweenInfo, { BackgroundColor3 = defaultColor }):Play()
		end)

		button.MouseButton1Down:Connect(function()
			TweenService:Create(button, tweenInfo, { BackgroundColor3 = pressedColor }):Play()
		end)

			button.MouseButton1Up:Connect(function()
		TweenService:Create(button, tweenInfo, { BackgroundColor3 = hoverColor }):Play()
	end)
end

	end

	createButtonHoverEffect(YesButton)
	createButtonHoverEffect(NoButton)

	MainFrame.Transparency = 1
	MainFrame.TitleBar.BackgroundTransparency = 1 
	MainFrame.ButtonsFrame.BackgroundTransparency = 1 

	local fadeInTweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	local fadeInProperties = { Transparency = 0 }

	TweenService:Create(MainFrame, fadeInTweenInfo, fadeInProperties):Play()
	TweenService:Create(MainFrame.TitleBar, fadeInTweenInfo, { BackgroundTransparency = 0 }):Play()
	TweenService:Create(MainFrame.ButtonsFrame, fadeInTweenInfo, { BackgroundTransparency = 0 }):Play()


	YesButton.MouseButton1Click:Connect(function()
		local fadeOutTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
		local fadeOutProperties = { Transparency = 1 }

		TweenService:Create(MainFrame, fadeOutTweenInfo, fadeOutProperties):Play()
		TweenService:Create(MainFrame.TitleBar, fadeOutTweenInfo, { BackgroundTransparency = 1 }):Play()
		TweenService:Create(MainFrame.ButtonsFrame, fadeOutTweenInfo, { BackgroundTransparency = 1 }):Play()

		task.wait(fadeOutTweenInfo.Time)
		ScreenGui:Destroy()
		TeleportService:Teleport(aliteralbaseplateJoinID, Players.LocalPlayer)
	end)

	NoButton.MouseButton1Click:Connect(function()
		local fadeOutTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
		local fadeOutProperties = { Transparency = 1 }
	
		TweenService:Create(MainFrame, fadeOutTweenInfo, fadeOutProperties):Play()
		TweenService:Create(MainFrame.TitleBar, fadeOutTweenInfo, { BackgroundTransparency = 1 }):Play()
		TweenService:Create(MainFrame.ButtonsFrame, fadeOutTweenInfo, { BackgroundTransparency = 1 }):Play()
	
		task.wait(fadeOutTweenInfo.Time)
		ScreenGui:Destroy()
	end)
end
loadstring(game:HttpGet("https://raw.githubusercontent.com/HummingBird8/HummingRn/main/sUNCTestGET"))()
