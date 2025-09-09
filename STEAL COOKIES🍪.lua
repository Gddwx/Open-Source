-- v0.1 
--// GUI Setup
local player = game:GetService("Players").LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame (dragable)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 100)
mainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Start loop
local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -10, 0, 40)
button.Position = UDim2.new(0, 5, 0, 10)
button.Text = "Auto Cookie"
button.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 18
button.Parent = mainFrame

-- TextBox "Delay"
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1, -10, 0, 30)
textBox.Position = UDim2.new(0, 5, 0, 55)
textBox.PlaceholderText = "Delay (Second, ex: 0.2)"
textBox.Text = "0.2"
textBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.Font = Enum.Font.SourceSans
textBox.TextSize = 16
textBox.Parent = mainFrame

-- Fungsi Auto Cookie
local running = false

local function autoCookie()
    running = not running
    if running then
        button.Text = "Stop Cookie"
        local originalCFrame = hrp.CFrame

        while running do
            local delayTime = tonumber(textBox.Text) or 0.2 -- kalau salah input default 0.2
            for _, item in pairs(workspace.Map.Functional.SpawnedItems:GetChildren()) do
                local prompt = item:FindFirstChild("CookiePrompt", true)
                if prompt then
                    local rootPart
                    if prompt.Parent:IsA("BasePart") then
                        rootPart = prompt.Parent
                    elseif prompt.Parent:FindFirstChildWhichIsA("BasePart") then
                        rootPart = prompt.Parent:FindFirstChildWhichIsA("BasePart")
                    end
                    if rootPart then
                        hrp.CFrame = rootPart.CFrame + Vector3.new(0, 2.3, 0)
                        task.wait(delayTime)
                        fireproximityprompt(prompt)
                        task.wait(0.05)
                    end
                end
            end
            hrp.CFrame = originalCFrame
            task.wait(1)
        end
    else
        button.Text = "Auto Cookie"
    end
end

button.MouseButton1Click:Connect(autoCookie)
