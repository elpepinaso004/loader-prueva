-- Pepinaso Loader - Versión Premium Green Style con scripts personalizados y paginación cada 4 botones
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Limpiar versiones anteriores si existen
if playerGui:FindFirstChild("PepinasoLoaderGui") then
    playerGui.PepinasoLoaderGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PepinasoiLoaderGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Frame Principal
local navFrame = Instance.new("Frame")
navFrame.Name = "MainFrame"
navFrame.Size = UDim2.new(0, 420, 0, 320)
navFrame.Position = UDim2.new(0.5, -210, 0.5, -160)
navFrame.BackgroundColor3 = Color3.fromRGB(15, 30, 15) -- Fondo ultra oscuro
navFrame.BorderSizePixel = 0
navFrame.ClipsDescendants = true
navFrame.Parent = screenGui

local navCorner = Instance.new("UICorner")
navCorner.CornerRadius = UDim.new(0, 12)
navCorner.Parent = navFrame

-- Borde de Neón
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(40, 180, 80)
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = navFrame

-- Barra de Título
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 60, 35)
titleBar.BorderSizePixel = 0
titleBar.Parent = navFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0.7, 0, 1, 0)
titleLabel.Position = UDim2.new(0.05, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "PEPINASOI LOADER"
titleLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Botón Minimizar
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 35, 0, 30)
minimizeButton.Position = UDim2.new(1, -45, 0.5, -15)
minimizeButton.Text = "-"
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 20
minimizeButton.BackgroundColor3 = Color3.fromRGB(40, 100, 50)
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.Parent = titleBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = minimizeButton

-- Contenedor de Botones
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, 0, 1, -40)
contentFrame.Position = UDim2.new(0, 0, 0, 40)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = navFrame

-- Paginación y Variables
local allButtons = {}
local scriptsPerPage = 4 -- Cambia de página cada 4 botones
local currentPage = 1

-- Botones de Navegación Inferiores
local prevButton = Instance.new("TextButton")
prevButton.Size = UDim2.new(0, 40, 0, 35)
prevButton.Position = UDim2.new(0.05, 0, 0.85, 0)
prevButton.Text = "<"
prevButton.BackgroundColor3 = Color3.fromRGB(30, 80, 40)
prevButton.TextColor3 = Color3.new(1,1,1)
prevButton.Font = Enum.Font.GothamBold
prevButton.Parent = contentFrame

local nextButton = Instance.new("TextButton")
nextButton.Size = UDim2.new(0, 40, 0, 35)
nextButton.Position = UDim2.new(0.85, 0, 0.85, 0)
nextButton.Text = ">"
nextButton.BackgroundColor3 = Color3.fromRGB(30, 80, 40)
nextButton.TextColor3 = Color3.new(1,1,1)
nextButton.Font = Enum.Font.GothamBold
nextButton.Parent = contentFrame

local pageLabel = Instance.new("TextLabel")
pageLabel.Size = UDim2.new(0, 100, 0, 35)
pageLabel.Position = UDim2.new(0.5, -50, 0.85, 0)
pageLabel.BackgroundTransparency = 1
pageLabel.TextColor3 = Color3.fromRGB(100, 200, 100)
pageLabel.Text = "1/1"
pageLabel.Font = Enum.Font.GothamBold
pageLabel.TextSize = 16
pageLabel.Parent = contentFrame

-- Función para mostrar notificación temporal
local function ShowNotification(text)
    local notif = Instance.new("TextLabel")
    notif.Size = UDim2.new(0, 200, 0, 40)
    notif.Position = UDim2.new(0.5, -100, 0, 10)
    notif.BackgroundColor3 = Color3.fromRGB(40, 100, 40)
    notif.TextColor3 = Color3.new(1,1,1)
    notif.Font = Enum.Font.GothamBold
    notif.TextSize = 18
    notif.Text = text
    notif.BackgroundTransparency = 0.2
    notif.Parent = navFrame
    notif.ZIndex = 10
    local tweenIn = game:GetService("TweenService"):Create(notif, TweenInfo.new(0.3), {BackgroundTransparency = 0})
    local tweenOut = game:GetService("TweenService"):Create(notif, TweenInfo.new(0.3), {BackgroundTransparency = 1})
    tweenIn:Play()
    tweenIn.Completed:Wait()
    task.wait(1.5)
    tweenOut:Play()
    tweenOut.Completed:Wait()
    notif:Destroy()
end

-- Función para actualizar la vista
local function UpdatePage()
    local maxPage = math.ceil(#allButtons / scriptsPerPage)
    if maxPage == 0 then maxPage = 1 end
    currentPage = math.clamp(currentPage, 1, maxPage)
    
    pageLabel.Text = currentPage .. " / " .. maxPage

    for i, btn in ipairs(allButtons) do
        local startRange = (currentPage - 1) * scriptsPerPage + 1
        local endRange = currentPage * scriptsPerPage
        
        if i >= startRange and i <= endRange then
            btn.Visible = true
            btn.Position = UDim2.new(0.1, 0, 0, ((i - startRange) * 45) + 15)
        else
            btn.Visible = false
        end
    end
end

-- Función para Crear Botones de Script
local function AddScript(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.8, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(35, 110, 55)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.AutoButtonColor = false
    btn.Parent = contentFrame
    btn.Visible = false
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn

    -- Efectos Hover
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 180, 80)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 110, 55)}):Play()
    end)

    btn.MouseButton1Click:Connect(function()
        ShowNotification("oh yeah el script se ejecuto osi osi")
        callback()
    end)

    table.insert(allButtons, btn)
    UpdatePage()
end

-- Controles de Navegación
prevButton.MouseButton1Click:Connect(function()
    currentPage = currentPage - 1
    UpdatePage()
end)

nextButton.MouseButton1Click:Connect(function()
    currentPage = currentPage + 1
    UpdatePage()
end)

-- Dragging (Arrastrar GUI)
local dragging, dragInput, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = navFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        navFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Minimizar
local isMinimized = false
minimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        contentFrame.Visible = false
        navFrame:TweenSize(UDim2.new(0, 420, 0, 40), "Out", "Quad", 0.3, true)
        minimizeButton.Text = "+"
    else
        navFrame:TweenSize(UDim2.new(0, 420, 0, 320), "Out", "Quad", 0.3, true)
        task.wait(0.3)
        contentFrame.Visible = true
        minimizeButton.Text = "-"
    end
end)

-- Scripts a añadir (SpeedHub y Infinite Yield se mantienen, los demás se reemplazan)

AddScript("SpeedHub X", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"))()
end)

AddScript("Infinite Yield (Admin)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

AddScript("Clover (roba un huevo)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Ryuun0x/Clover/refs/heads/main/main.lua"))()
end)

AddScript("Rivals", function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/8a30cd5907985a2b8d68c8010312f185.lua"))()
end)

AddScript("Muscle Legends", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Young0xHUB/Young0x-HUB/refs/heads/main/loader.lua"))()
end)

AddScript("99 Noches", function()
    loadstring(game:HttpGet("https://files.vapevoidware.xyz/VapeVoidware/VW-Add/main/loader.lua", true))()
end)

AddScript("Brookhaven", function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Brookhaven-RP-Dark-Hub-214104"))()
end)

AddScript("Anti AFK", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/hassanxzayn-lua/Anti-afk/main/antiafkbyhassanxzyn"))()
end)

AddScript("Ninja Legends", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MADMONEYDISTRO/feather-hub/refs/heads/main/feather%20hub%20ninja%20legends"))()
end)

AddScript("Duelos", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/imshrak/knifeduels/refs/heads/main/menu"))()
end)

-- Inicializar primera vista
UpdatePage()
