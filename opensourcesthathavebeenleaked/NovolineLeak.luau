local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local TextService = game:GetService("TextService")
local LocalPlayer = Players.LocalPlayer
local Novo = {}
Novo.Guis = {}

do
local Theme = {
	Panel        = Color3.fromRGB(23, 23, 26),
	PanelDeep    = Color3.fromRGB(15, 15, 17),
	Raise        = Color3.fromRGB(29, 29, 33),
	Divider      = Color3.fromRGB(44, 44, 50),
	Track        = Color3.fromRGB(47, 47, 47),

	Stroke       = Color3.fromRGB(55, 55, 61),
	StrokeSoft   = Color3.fromRGB(60, 60, 68),
	StrokeNav    = Color3.fromRGB(40, 40, 46),
	StrokeDot    = Color3.fromRGB(24, 24, 28),

	Text         = Color3.fromRGB(244, 244, 246),
	TextBright   = Color3.fromRGB(255, 255, 255),
	TextMuted    = Color3.fromRGB(156, 156, 166),
	TextDim      = Color3.fromRGB(180, 180, 180),
	TextFaint    = Color3.fromRGB(205, 205, 212),

	Accent       = Color3.fromRGB(52, 116, 204),
	AccentLight  = Color3.fromRGB(76, 143, 230),
	AccentDark   = Color3.fromRGB(35, 82, 153),
	AccentDeep   = Color3.fromRGB(41, 90, 159),
	Good         = Color3.fromRGB(64, 200, 120),

	R_Panel      = UDim.new(0, 14),
	R_Card       = UDim.new(0, 12),
	R_Button     = UDim.new(0, 10),
	R_Nav        = UDim.new(0, 8),
	R_Pill       = UDim.new(1, 0),

	T_Overlay    = 0.38,
	T_Stroke     = 0.45,
	T_StrokeSoft = 0.70,
	T_StrokeNav  = 0.72,
	T_Card       = 0.85,

	Wallpaper    = "rbxassetid://84947831307834",
	Shadow       = "rbxassetid://6014261993",
	ShadowSlice  = Rect.new(49, 49, 450, 450),
}

local function gotham(weight)
	return Font.new("rbxasset://fonts/families/GothamSSm.json", weight, Enum.FontStyle.Normal)
end

Theme.Font = {
	Regular  = gotham(Enum.FontWeight.Regular),
	Medium   = gotham(Enum.FontWeight.Medium),
	SemiBold = gotham(Enum.FontWeight.SemiBold),
	Bold     = gotham(Enum.FontWeight.Bold),
}

Theme.Icon = {
	Home      = "rbxassetid://127423679155445",
	Commands  = "rbxassetid://80224450231681",
	Players   = "rbxassetid://90813744897378",
	Music     = "rbxassetid://122449170161975",
	Scripts   = "rbxassetid://116337355510336",
	Settings  = "rbxassetid://127213529537158",
	Plus      = "rbxassetid://91305247413991",
	Close     = "rbxassetid://124858252806023",
	Minimize  = "rbxassetid://136052598813918",
	Resize    = "rbxassetid://132772681347890",
	Cross     = "rbxassetid://82927197777156",
	Fab       = "rbxassetid://137047199953006",
}

Novo.Theme = Theme
end

do
local Util = {}

function Util.new(class, props, children)
	local inst = Instance.new(class)
	local parent = nil
	for k, v in pairs(props or {}) do
		if k == "Parent" then
			parent = v
		else
			inst[k] = v
		end
	end
	for _, child in ipairs(children or {}) do
		child.Parent = inst
	end
	inst.Parent = parent
	return inst
end

local new = Util.new

function Util.corner(radius, parent)
	return new("UICorner", { CornerRadius = radius, Parent = parent })
end

function Util.stroke(color, thickness, transparency, mode, parent)
	return new("UIStroke", {
		Color = color,
		Thickness = thickness,
		Transparency = transparency,
		ApplyStrokeMode = mode or Enum.ApplyStrokeMode.Border,
		LineJoinMode = Enum.LineJoinMode.Round,
		Parent = parent,
	})
end

function Util.padding(t, b, l, r, parent)
	return new("UIPadding", {
		PaddingTop = UDim.new(0, t),
		PaddingBottom = UDim.new(0, b),
		PaddingLeft = UDim.new(0, l),
		PaddingRight = UDim.new(0, r),
		Parent = parent,
	})
end

function Util.list(dir, pad, halign, valign, parent)
	return new("UIListLayout", {
		FillDirection = dir,
		Padding = UDim.new(0, pad),
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = halign or Enum.HorizontalAlignment.Left,
		VerticalAlignment = valign or Enum.VerticalAlignment.Top,
		Parent = parent,
	})
end

function Util.surfaceShine(parent, height, radius, fillTransparency, keypoints, zindex)
	local group = new("CanvasGroup", {
		Size = typeof(height) == "UDim2" and height or UDim2.new(1, 0, 0, height),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = zindex or 40,
		Name = "SurfaceShine",
		Parent = parent,
	})
	Util.corner(radius, group)
	local fill = new("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = fillTransparency,
		BorderSizePixel = 0,
		Name = "Fill",
		Parent = group,
	})
	new("UIGradient", {
		Color = ColorSequence.new(Color3.new(1, 1, 1)),
		Transparency = NumberSequence.new(keypoints),
		Rotation = 90,
		Parent = fill,
	})
	return group
end

function Util.frostedBacking(parent, radius, overlayTransparency)
	local wall = new("ImageLabel", {
		Name = "Wallpaper",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = Novo.Theme.Wallpaper,
		ScaleType = Enum.ScaleType.Crop,
		ZIndex = 1,
		Parent = parent,
	})
	Util.corner(radius, wall)
	local wash = new("Frame", {
		Name = "WpOverlay",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Novo.Theme.PanelDeep,
		BackgroundTransparency = overlayTransparency or Novo.Theme.T_Overlay,
		BorderSizePixel = 0,
		ZIndex = 2,
		Parent = parent,
	})
	Util.corner(radius, wash)
	return wall, wash
end

Util.Motion = {
	Snap   = TweenInfo.new(0.16, Enum.EasingStyle.Quad,  Enum.EasingDirection.Out),
	Quick  = TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
	Glide  = TweenInfo.new(0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
	Settle = TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
}

function Util.tween(inst, info, goal)
	local t = TweenService:Create(inst, info, goal)
	t:Play()
	return t
end

local function pointInside(inst, x, y)
	local pos, size = inst.AbsolutePosition, inst.AbsoluteSize
	return x >= pos.X and x <= pos.X + size.X
		and y >= pos.Y and y <= pos.Y + size.Y
end

local function overGrabBlocker(handle, x, y)
	for _, d in ipairs(handle:GetDescendants()) do
		if (d:IsA("ScrollingFrame") or d:IsA("TextBox")) and d.Visible then
			if pointInside(d, x, y) then
				return true
			end
		end
	end
	return false
end

function Util.draggable(handle, target)
	local dragging, startPos, startInput = false, nil, nil

	handle.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1
			and input.UserInputType ~= Enum.UserInputType.Touch then return end
		if overGrabBlocker(handle, input.Position.X, input.Position.Y) then return end
		dragging = true
		startPos = target.Position
		startInput = input.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end)

	UserInputService.InputChanged:Connect(function(input)
		if not dragging then return end
		if input.UserInputType ~= Enum.UserInputType.MouseMovement
			and input.UserInputType ~= Enum.UserInputType.Touch then return end
		local delta = input.Position - startInput
		target.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end)
end

Novo.Util = Util
end

do
local Util  = Novo.Util
local Theme = Novo.Theme
local new   = Util.new

local Window = {}
Novo.Window = Window
Novo.Pages = {}

local TABS = {
	{ id = "Home",      icon = Theme.Icon.Home,     size = 44 },
	{ id = "Commands",  icon = Theme.Icon.Commands, size = 26 },
	{ id = "Playerlist",icon = Theme.Icon.Players,  size = 26 },
	{ id = "Music",     icon = Theme.Icon.Music,    size = 26 },
	{ id = "Scripts",   icon = Theme.Icon.Scripts,  size = 26 },
	{ id = "Settings",  icon = Theme.Icon.Settings, size = 26 },
	{ id = "Plus",      icon = Theme.Icon.Plus,     size = 26 },
}

local MASK_SLIDE = TweenInfo.new(0.18, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
local ICON_FADE  = TweenInfo.new(0.20, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

function Window.build()
	local screen = new("ScreenGui", {
		Name = "NovoMain",
		DisplayOrder = 55,
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	})
	Novo.Guis[#Novo.Guis + 1] = screen

	local wrap = new("Frame", {
		Name = "Wrap",
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromOffset(570, 418),
		BackgroundTransparency = 1,
		ZIndex = 11,
		Parent = screen,
	})
	local wrapScale = new("UIScale", { Scale = 1, Parent = wrap })

	local panel = new("Frame", {
		Name = "ContentPanel",
		Size = UDim2.fromOffset(570, 350),
		BackgroundColor3 = Theme.Panel,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 12,
		Parent = wrap,
	})
	Util.corner(Theme.R_Panel, panel)
	Util.surfaceShine(panel, 28, Theme.R_Panel, 0.88,
		{
			NumberSequenceKeypoint.new(0, 0.14),
			NumberSequenceKeypoint.new(0.30, 0.62),
			NumberSequenceKeypoint.new(0.62, 0.94),
			NumberSequenceKeypoint.new(1, 1),
		}, 40)

	local area = new("Frame", {
		Name = "ContentArea",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		ZIndex = 16,
		Parent = panel,
	})

	local tabBg = new("ImageLabel", {
		Name = "GlobalTabBg",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		Image = Theme.Wallpaper,
		ScaleType = Enum.ScaleType.Crop,
		Visible = false,
		ZIndex = 13,
		Parent = panel,
	})
	Util.corner(Theme.R_Panel, tabBg)

	local tabOverlay = new("Frame", {
		Name = "GlobalTabOverlay",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Theme.PanelDeep,
		BackgroundTransparency = Theme.T_Overlay,
		BorderSizePixel = 0,
		ZIndex = 14,
		Parent = panel,
	})
	Util.corner(Theme.R_Panel, tabOverlay)

	local nav = new("Frame", {
		Name = "Navbar",
		Position = UDim2.new(0.5, 0, 0, 360),
		AnchorPoint = Vector2.new(0.5, 0),
		Size = UDim2.fromOffset(420, 56),
		BackgroundColor3 = Theme.Panel,
		BorderSizePixel = 0,
		ZIndex = 50,
		Parent = wrap,
	})
	Util.corner(Theme.R_Nav, nav)
	local navStroke = Util.stroke(Theme.StrokeNav, 1, Theme.T_StrokeNav, Enum.ApplyStrokeMode.Border, nav)
	navStroke.Name = "NavStroke"
	Util.frostedBacking(nav, Theme.R_Nav, Theme.T_Overlay)

	local navShine = Util.surfaceShine(nav, UDim2.fromScale(1, 1), Theme.R_Nav, 0.92,
		{
			NumberSequenceKeypoint.new(0, 0.16),
			NumberSequenceKeypoint.new(0.42, 0.72),
			NumberSequenceKeypoint.new(1, 1),
		}, 51)
	navShine.Fill.Size = UDim2.new(1, 0, 0, 6)

	new("ImageLabel", {
		Name = "Dropshadow",
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.new(1, 40, 1, 40),
		BackgroundTransparency = 1,
		Image = Theme.Shadow,
		ImageColor3 = Color3.new(0, 0, 0),
		ImageTransparency = 0.75,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Theme.ShadowSlice,
		ZIndex = 48,
		Parent = nav,
	})

	local mask = new("Frame", {
		Name = "NavMask",
		Size = UDim2.fromOffset(60, 56),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		ZIndex = 51,
		Parent = nav,
	})
	local maskFill = new("Frame", {
		Size = UDim2.fromOffset(420, 56),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.95,
		BorderSizePixel = 0,
		ZIndex = 51,
		Parent = mask,
	})
	Util.corner(Theme.R_Nav, maskFill)

	local buttons = new("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ZIndex = 52,
		Parent = nav,
	})

	local icons = {}
	for i, tab in ipairs(TABS) do
		local btn = new("TextButton", {
			Position = UDim2.fromOffset((i - 1) * 60, 0),
			Size = UDim2.fromOffset(60, 56),
			BackgroundTransparency = 1,
			Text = "",
			TextSize = 8,
			AutoButtonColor = true,
			ZIndex = 53,
			Parent = buttons,
		})
		local icon = new("ImageLabel", {
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.fromOffset(tab.size, tab.size),
			BackgroundTransparency = 1,
			Image = tab.icon,
			ImageColor3 = Theme.TextDim,
			ImageTransparency = 0.75,
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 54,
			Parent = btn,
		})
		icons[i] = icon
		btn.MouseButton1Click:Connect(function()
			Window.select(i)
		end)
	end

	Util.draggable(panel, wrap)
	Util.draggable(nav, wrap)

	Window.screen = screen
	Window.wrap = wrap
	Window.scale = wrapScale
	Window.panel = panel
	Window.area = area
	Window.tabBg = tabBg
	Window.tabOverlay = tabOverlay
	Window.nav = nav
	Window.mask = mask
	Window.maskFill = maskFill
	Window.icons = icons
	Window.tabs = TABS
	Window.current = nil
	Window.pageCache = {}

	Window.select(1, true)
	return screen
end

function Window.select(index, instant)
	if Window.current == index then return end
	local prev = Window.current
	Window.current = index

	local maskGoal = UDim2.fromOffset((index - 1) * 60, 0)
	local fillGoal = UDim2.fromOffset(-(index - 1) * 60, 0)
	if instant then
		Window.mask.Position = maskGoal
		Window.maskFill.Position = fillGoal
	else
		Util.tween(Window.mask, MASK_SLIDE, { Position = maskGoal })
		Util.tween(Window.maskFill, MASK_SLIDE, { Position = fillGoal })
	end

	for i, icon in ipairs(Window.icons) do
		local on = (i == index)
		local goal = {
			ImageTransparency = on and 0 or 0.75,
			ImageColor3 = on and Theme.TextBright or Theme.TextDim,
		}
		if instant then
			icon.ImageTransparency = goal.ImageTransparency
			icon.ImageColor3 = goal.ImageColor3
		else
			Util.tween(icon, ICON_FADE, goal)
		end
	end

	local isHome = (index == 1)
	Window.tabBg.Visible = not isHome
	Window.tabOverlay.Visible = not isHome

	if prev and Window.pageCache[prev] then
		Window.pageCache[prev].Visible = false
	end

	local id = Window.tabs[index].id
	local page = Window.pageCache[index]
	if not page then
		local builder = Novo.Pages[id]
		if builder then
			page = builder(Window.area)
			Window.pageCache[index] = page
		end
	end
	if page then
		page.Visible = true
	end
end
end

do
local Util  = Novo.Util
local Theme = Novo.Theme
local new   = Util.new

local CAPTION   = Color3.fromRGB(150, 152, 166)
local SUBTITLE  = Color3.fromRGB(180, 180, 190)
local USERNAME  = Color3.fromRGB(140, 142, 158)
local CARD_DIM  = Color3.fromRGB(15, 15, 18)
local AVA_RING  = Color3.fromRGB(22, 22, 26)

local ICON_CLOCK    = "rbxassetid://8992234911"
local ICON_BED      = "rbxassetid://8992234911"
local ICON_BYPASSER = "rbxassetid://114697945255264"
local ICON_CHAT     = "rbxassetid://94277343080125"
local ICON_EXPAND   = "rbxassetid://82907879206637"

local STRIP = {
	{ value = "Fly",  caption = "Off", action = "fly" },
	{ icon = ICON_BYPASSER, caption = "Bypasser", action = "mic" },
	{ value = "ESP",  caption = "Panel", action = "esp" },
}

local function placeThumb(placeId)
	return ("https://www.roblox.com/asset-thumbnail/image?assetId=%d&width=768&height=432&format=png")
		:format(placeId)
end

local function headshot(userId, size)
	return ("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=%d&height=%d&format=png")
		:format(userId, size, size)
end

local function hoverLift(button, target, base, hover)
	button.MouseEnter:Connect(function()
		Util.tween(target, Util.Motion.Snap, { BackgroundTransparency = hover })
	end)
	button.MouseLeave:Connect(function()
		Util.tween(target, Util.Motion.Snap, { BackgroundTransparency = base })
	end)
end

local function label(props)
	if props.BackgroundTransparency == nil then
		props.BackgroundTransparency = 1
	end
	props.TextYAlignment = props.TextYAlignment or Enum.TextYAlignment.Center
	return new("TextLabel", props)
end

local function stripCell(parent, index, spec)
	local third = 1 / 3
	local cell = new("Frame", {
		Position = UDim2.fromScale(third * (index - 1), 0),
		Size = UDim2.new(third, 0, 1, 0),
		BackgroundTransparency = 1,
		ZIndex = 35,
		Parent = parent,
	})

	local value = label({
		Name = "Value",
		Position = UDim2.fromOffset(4, 9),
		Size = UDim2.new(1, -8, 0, 21),
		Text = spec.value or "",
		TextColor3 = Theme.TextBright,
		TextSize = 15,
		FontFace = Theme.Font.Bold,
		TextXAlignment = Enum.TextXAlignment.Center,
		Visible = spec.value ~= nil,
		ZIndex = 36,
		Parent = cell,
	})

	if spec.icon then
		new("ImageLabel", {
			Name = "Icon",
			Position = UDim2.new(0.5, 0, 0, 19),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.fromOffset(18, 18),
			BackgroundTransparency = 1,
			Image = spec.icon,
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 36,
			Parent = cell,
		})
	end

	local capt = label({
		Name = "Caption",
		Position = UDim2.fromOffset(4, 32),
		Size = UDim2.new(1, -8, 0, 14),
		Text = spec.caption,
		TextColor3 = CAPTION,
		TextSize = 10,
		FontFace = Theme.Font.Medium,
		TextXAlignment = Enum.TextXAlignment.Center,
		ZIndex = 36,
		Parent = cell,
	})

	local hit = new("TextButton", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = "",
		TextSize = 8,
		AutoButtonColor = false,
		ZIndex = 37,
		Parent = cell,
	})

	hit.MouseEnter:Connect(function()
		Util.tween(value, Util.Motion.Snap, { TextTransparency = 0.25 })
	end)
	hit.MouseLeave:Connect(function()
		Util.tween(value, Util.Motion.Snap, { TextTransparency = 0 })
	end)

	return { cell = cell, value = value, caption = capt, hit = hit }
end

local function activityCard(parent, order, spec, onClick)
	local card = new("Frame", {
		Size = UDim2.new(1, -14, 0, 100),
		BackgroundTransparency = 1,
		LayoutOrder = order,
		ZIndex = 35,
		Parent = parent,
	})

	local thumb = new("ImageLabel", {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = CARD_DIM,
		BackgroundTransparency = 0,
		Image = spec.thumb,
		ScaleType = Enum.ScaleType.Crop,
		ZIndex = 35,
		Parent = card,
	})
	Util.corner(Theme.R_Nav, thumb)

	local avatar = new("ImageLabel", {
		Position = UDim2.new(0, 10, 1, -10),
		AnchorPoint = Vector2.new(0, 1),
		Size = UDim2.fromOffset(32, 32),
		BackgroundTransparency = 1,
		Image = spec.headshot or ("rbxthumb://type=AvatarHeadShot&id=%d&w=48&h=48"):format(spec.user),
		ZIndex = 38,
		Parent = card,
	})
	Util.corner(Theme.R_Pill, avatar)
	Util.stroke(AVA_RING, 2, 0, Enum.ApplyStrokeMode.Contextual, avatar)

	label({
		Position = UDim2.new(0, 50, 1, -10),
		AnchorPoint = Vector2.new(0, 1),
		Size = UDim2.new(1, -60, 0, 32),
		Text = spec.game,
		TextColor3 = Theme.TextBright,
		TextSize = 13,
		FontFace = Theme.Font.Bold,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 37,
		Parent = card,
	})
	label({
		Position = UDim2.new(0, 51, 1, -9),
		AnchorPoint = Vector2.new(0, 1),
		Size = UDim2.new(1, -60, 0, 32),
		Text = spec.game,
		TextColor3 = Color3.new(0, 0, 0),
		TextTransparency = 0.5,
		TextSize = 13,
		FontFace = Theme.Font.Bold,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 36,
		Parent = card,
	})

	card.MouseEnter:Connect(function()
		Util.tween(thumb, Util.Motion.Snap, { ImageTransparency = 0.15 })
	end)
	card.MouseLeave:Connect(function()
		Util.tween(thumb, Util.Motion.Snap, { ImageTransparency = 0 })
	end)

	if onClick then
		card.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
				onClick()
			end
		end)
	end
	return card
end

Novo.Pages.Home = function(parent)
	local page = new("Frame", {
		Name = "Content_Home",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 22,
		Parent = parent,
	})

	local landing = new("Frame", {
		Name = "HomeLanding",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Theme.Panel,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 30,
		Parent = page,
	})
	Util.corner(Theme.R_Panel, landing)

	local bg = new("ImageLabel", {
		Name = "HomeBg",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = Theme.Wallpaper,
		ScaleType = Enum.ScaleType.Crop,
		ZIndex = 31,
		Parent = landing,
	})
	Util.corner(Theme.R_Panel, bg)

	local wash = new("Frame", {
		Name = "DarkOverlay",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Theme.PanelDeep,
		BackgroundTransparency = 0.45,
		BorderSizePixel = 0,
		ZIndex = 32,
		Parent = landing,
	})
	Util.corner(Theme.R_Panel, wash)

	local displayName = LocalPlayer and LocalPlayer.DisplayName or "Player"
	local userName = LocalPlayer and LocalPlayer.Name or "Player"

	label({
		Position = UDim2.fromOffset(14, 14),
		Size = UDim2.new(1, -28, 0, 22),
		Text = "Welcome home, " .. displayName,
		TextColor3 = Theme.TextBright,
		TextSize = 17,
		FontFace = Theme.Font.Bold,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 34,
		Parent = landing,
	})
	label({
		Position = UDim2.fromOffset(14, 36),
		Size = UDim2.new(1, -28, 0, 14),
		Text = "Novoline",
		TextColor3 = SUBTITLE,
		TextSize = 11,
		FontFace = Theme.Font.Medium,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 34,
		Parent = landing,
	})

	local clock = new("Frame", {
		Name = "HomeClock",
		Position = UDim2.new(1, -14, 0, 14),
		AnchorPoint = Vector2.new(1, 0),
		Size = UDim2.fromOffset(0, 36),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 34,
		Parent = landing,
	})
	Util.corner(Theme.R_Nav, clock)
	Util.padding(0, 0, 10, 14, clock)
	local clockLayout = Util.list(Enum.FillDirection.Horizontal, 8,
		Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center, clock)
	clockLayout.SortOrder = Enum.SortOrder.Name

	local iconSlot = new("Frame", {
		Name = "ClockIconSlot",
		Size = UDim2.fromOffset(24, 24),
		BackgroundTransparency = 1,
		ZIndex = 35,
		Parent = clock,
	})
	new("ImageLabel", {
		Name = "ClockGlyph",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Image = ICON_CLOCK,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 35,
		Parent = iconSlot,
	})
	new("ImageLabel", {
		Name = "BedGlyph",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Image = ICON_BED,
		ImageTransparency = 1,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 36,
		Parent = iconSlot,
	})

	local clockText = label({
		Size = UDim2.new(0, 0, 1, 0),
		AutomaticSize = Enum.AutomaticSize.X,
		Text = os.date("%I:%M %p"):gsub("^0", ""),
		TextColor3 = Theme.TextBright,
		TextSize = 15,
		FontFace = Theme.Font.Bold,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 35,
		Parent = clock,
	})
	task.spawn(function()
		while clockText.Parent do
			clockText.Text = os.date("%I:%M %p"):gsub("^0", "")
			task.wait(5)
		end
	end)

	local widgets = new("Frame", {
		Name = "WidgetRow",
		Position = UDim2.fromOffset(14, 60),
		Size = UDim2.new(1, -28, 0, 52),
		BackgroundTransparency = 1,
		ZIndex = 34,
		Parent = landing,
	})

	local strip = new("Frame", {
		Name = "ServerStrip",
		Size = UDim2.new(1, 0, 0, 52),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = Theme.T_Card,
		BorderSizePixel = 0,
		ZIndex = 34,
		Parent = widgets,
	})
	Util.corner(Theme.R_Card, strip)
	Util.stroke(Theme.StrokeSoft, 1, Theme.T_StrokeSoft, Enum.ApplyStrokeMode.Contextual, strip)
	local cells = {}
	for i, spec in ipairs(STRIP) do
		cells[spec.action or i] = stripCell(strip, i, spec)
	end

	local F = Novo.Features
	if F then
		local flyCell = cells.fly
		if flyCell then
			local function paintFly()
				local on = F.Fly.enabled
				flyCell.caption.Text = on and "On" or "Off"
				Util.tween(flyCell.value, Util.Motion.Snap, {
					TextColor3 = on and Theme.AccentLight or Theme.TextBright,
				})
			end
			flyCell.hit.MouseButton1Click:Connect(function()
				F.Fly.toggle()
			end)
			F.Fly.changed.Event:Connect(paintFly)
			paintFly()
		end

		if cells.mic then
			cells.mic.hit.MouseButton1Click:Connect(function()
				if Novo.Panels and Novo.Panels.toggle then
					Novo.Panels.toggle("VCBypass")
				else
					F.Mic.run()
				end
			end)
		end

		if cells.esp then
			cells.esp.hit.MouseButton1Click:Connect(function()
				if Novo.Panels and Novo.Panels.toggle then
					Novo.Panels.toggle("Esp")
				end
			end)
		end
	end

	local profile = new("Frame", {
		Name = "ProfileCard",
		Position = UDim2.fromOffset(0, 62),
		Size = UDim2.new(0.5, -5, 0, 212),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = Theme.T_Card,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 34,
		Parent = widgets,
	})
	Util.corner(Theme.R_Card, profile)
	Util.stroke(Theme.StrokeSoft, 1, Theme.T_StrokeSoft, Enum.ApplyStrokeMode.Contextual, profile)

	local ring = new("Frame", {
		Name = "ProfileRing",
		Position = UDim2.new(0.5, 0, 0, 14),
		AnchorPoint = Vector2.new(0.5, 0),
		Size = UDim2.fromOffset(84, 84),
		BackgroundTransparency = 1,
		ZIndex = 35,
		Parent = profile,
	})
	Util.corner(Theme.R_Pill, ring)
	local ringStroke = Util.stroke(Theme.TextBright, 2, 0, Enum.ApplyStrokeMode.Contextual, ring)
	new("UIGradient", {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Theme.AccentLight),
			ColorSequenceKeypoint.new(0.55, Theme.Accent),
			ColorSequenceKeypoint.new(1, Theme.AccentDark),
		}),
		Rotation = 45,
		Parent = ringStroke,
	})

	local avatar = new("ImageLabel", {
		Name = "ProfileAvatar",
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.new(1, -8, 1, -8),
		BackgroundTransparency = 1,
		Image = ("rbxthumb://type=AvatarHeadShot&id=%d&w=100&h=100")
			:format(LocalPlayer and LocalPlayer.UserId or 1),
		ScaleType = Enum.ScaleType.Crop,
		ZIndex = 35,
		Parent = ring,
	})
	Util.corner(Theme.R_Pill, avatar)

	local dot = new("Frame", {
		Name = "StatusDot",
		Position = UDim2.new(0.5, 30, 0, 86),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromOffset(15, 15),
		BackgroundColor3 = Theme.Good,
		BorderSizePixel = 0,
		ZIndex = 37,
		Parent = profile,
	})
	Util.corner(Theme.R_Pill, dot)
	Util.stroke(Theme.StrokeDot, 3, 0, Enum.ApplyStrokeMode.Contextual, dot)

	label({
		Position = UDim2.fromOffset(0, 106),
		Size = UDim2.new(1, 0, 0, 16),
		Text = displayName,
		TextColor3 = Theme.TextBright,
		TextSize = 14,
		FontFace = Theme.Font.Bold,
		TextXAlignment = Enum.TextXAlignment.Center,
		ZIndex = 36,
		Parent = profile,
	})
	label({
		Position = UDim2.fromOffset(0, 124),
		Size = UDim2.new(1, 0, 0, 14),
		Text = userName,
		TextColor3 = USERNAME,
		TextSize = 11,
		FontFace = Theme.Font.Medium,
		TextXAlignment = Enum.TextXAlignment.Center,
		ZIndex = 36,
		Parent = profile,
	})

	local function statHolder(name, value)
		return label({
			Name = name,
			Size = UDim2.new(),
			BackgroundTransparency = 0,
			Text = value,
			TextColor3 = Color3.fromRGB(27, 42, 53),
			TextSize = 8,
			TextXAlignment = Enum.TextXAlignment.Center,
			Visible = false,
			ZIndex = 1,
			Parent = profile,
		})
	end
	statHolder("StatOnlineVal", "0")
	statHolder("StatInServerVal", "0")

	local chatBar = new("Frame", {
		Name = "ChatBar",
		Position = UDim2.new(0.5, 0, 1, -16),
		AnchorPoint = Vector2.new(0.5, 1),
		Size = UDim2.new(1, -32, 0, 40),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = Theme.T_Card,
		BorderSizePixel = 0,
		ZIndex = 35,
		Parent = profile,
	})
	Util.corner(Theme.R_Button, chatBar)
	Util.stroke(Theme.StrokeSoft, 1, Theme.T_StrokeSoft, Enum.ApplyStrokeMode.Contextual, chatBar)

	new("ImageLabel", {
		Name = "ChatIcon",
		Position = UDim2.new(0, 12, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.fromOffset(18, 18),
		BackgroundTransparency = 1,
		Image = ICON_CHAT,
		ImageColor3 = CAPTION,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 36,
		Parent = chatBar,
	})
	local placeholder = label({
		Name = "ChatPlaceholder",
		Position = UDim2.new(0, 42, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.new(1, -54, 0, 18),
		Text = "Chat...",
		TextColor3 = USERNAME,
		TextSize = 12,
		FontFace = Theme.Font.Medium,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 36,
		Parent = chatBar,
	})

	local inputHolder = new("Frame", {
		Name = "HomeChatInputContainer",
		Position = UDim2.new(0, 42, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.new(1, -54, 1, 0),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		ZIndex = 1,
		Parent = chatBar,
	})
	local input = new("TextBox", {
		Name = "HomeChatInput",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Text = "",
		PlaceholderText = "Message...",
		PlaceholderColor3 = Theme.TextMuted,
		TextColor3 = Theme.Text,
		TextSize = 12,
		FontFace = Theme.Font.Medium,
		TextXAlignment = Enum.TextXAlignment.Left,
		ClearTextOnFocus = false,
		Visible = false,
		ZIndex = 37,
		Parent = inputHolder,
	})

	local chatOpen = new("TextButton", {
		Name = "HomeChatOpen",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = "",
		TextSize = 8,
		AutoButtonColor = false,
		ZIndex = 38,
		Parent = chatBar,
	})
	hoverLift(chatOpen, chatBar, Theme.T_Card, 0.78)
	chatOpen.MouseButton1Click:Connect(function()
		placeholder.Visible = false
		input.Visible = true
		input:CaptureFocus()
	end)
	input.FocusLost:Connect(function()
		if input.Text == "" then
			input.Visible = false
			placeholder.Visible = true
		end
	end)

	local feed = new("ScrollingFrame", {
		Name = "HomeChatFeed",
		Position = UDim2.fromOffset(12, 44),
		Size = UDim2.new(1, -24, 0, 114),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ScrollBarThickness = 0,
		CanvasSize = UDim2.new(),
		ScrollingDirection = Enum.ScrollingDirection.Y,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Visible = false,
		ZIndex = 36,
		Parent = profile,
	})
	Util.list(Enum.FillDirection.Vertical, 9, nil, nil, feed)
	label({
		Size = UDim2.new(1, 0, 0, 30),
		Text = "Connected to chat. Say hi",
		TextColor3 = Theme.TextMuted,
		TextTransparency = 1,
		TextSize = 11,
		FontFace = Theme.Font.Medium,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		TextWrapped = true,
		ZIndex = 36,
		Parent = feed,
	})

	label({
		Name = "HomeChatTitle",
		Position = UDim2.fromOffset(14, 12),
		Size = UDim2.new(1, -80, 0, 16),
		Text = "Chat",
		TextColor3 = Theme.TextBright,
		TextSize = 13,
		FontFace = Theme.Font.Bold,
		TextXAlignment = Enum.TextXAlignment.Left,
		Visible = false,
		ZIndex = 39,
		Parent = profile,
	})

	local glass = new("Frame", {
		Name = "HomeChatBtnGlass",
		Position = UDim2.new(1, -8, 0, 8),
		AnchorPoint = Vector2.new(1, 0),
		Size = UDim2.fromOffset(64, 34),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 38,
		Parent = profile,
	})
	Util.corner(Theme.R_Card, glass)
	Util.stroke(Theme.StrokeSoft, 1, 1, Enum.ApplyStrokeMode.Contextual, glass)

	local function chipButton(name, xOffset, iconId, iconSize)
		local btn = new("TextButton", {
			Name = name,
			Position = UDim2.new(1, xOffset, 0, 12),
			AnchorPoint = Vector2.new(1, 0),
			Size = UDim2.fromOffset(26, 26),
			BackgroundTransparency = 1,
			Text = "",
			TextSize = 8,
			AutoButtonColor = false,
			Visible = false,
			ZIndex = 39,
			Parent = profile,
		})
		new("ImageLabel", {
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.fromOffset(iconSize, iconSize),
			BackgroundTransparency = 1,
			Image = iconId,
			ImageColor3 = Theme.TextMuted,
			ImageTransparency = 1,
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 40,
			Parent = btn,
		})
		return btn
	end
	chipButton("HomeChatOpenMain", -42, ICON_EXPAND, 18)
	chipButton("HomeChatClose", -12, Theme.Icon.Cross, 16)

	local activity = new("Frame", {
		Name = "FriendActivityCard",
		Position = UDim2.new(0.5, 5, 0, 62),
		Size = UDim2.new(0.5, -5, 0, 212),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = Theme.T_Card,
		BorderSizePixel = 0,
		ZIndex = 34,
		Parent = widgets,
	})
	Util.corner(Theme.R_Card, activity)
	Util.stroke(Theme.StrokeSoft, 1, Theme.T_StrokeSoft, Enum.ApplyStrokeMode.Contextual, activity)

	label({
		Position = UDim2.fromOffset(14, 12),
		Size = UDim2.new(1, -28, 0, 16),
		Text = "Friend Activity",
		TextColor3 = Theme.TextBright,
		TextSize = 13,
		FontFace = Theme.Font.Bold,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 36,
		Parent = activity,
	})

	local scroll = new("ScrollingFrame", {
		Name = "ActivityScroll",
		Position = UDim2.fromOffset(14, 36),
		Size = UDim2.new(1, -14, 1, -50),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ScrollBarThickness = 0,
		ScrollBarImageColor3 = Color3.fromRGB(160, 162, 178),
		ScrollBarImageTransparency = 1,
		CanvasSize = UDim2.fromOffset(0, 442),
		ScrollingDirection = Enum.ScrollingDirection.Y,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ZIndex = 35,
		Parent = activity,
	})
	Util.list(Enum.FillDirection.Vertical, 14, nil, nil, scroll)

	local empty = label({
		Position = UDim2.fromOffset(14, 36),
		Size = UDim2.new(1, -28, 1, -50),
		Text = "Your friends will appear here when they're in-game.",
		TextColor3 = USERNAME,
		TextSize = 11,
		FontFace = Theme.Font.Medium,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextWrapped = true,
		Visible = false,
		ZIndex = 36,
		Parent = activity,
	})

	local function fillFriends()
		if not Novo.Features then return end
		local list = Novo.Features.Friends.online()

		for _, child in ipairs(scroll:GetChildren()) do
			if child:IsA("Frame") then child:Destroy() end
		end

		for i, friend in ipairs(list) do
			activityCard(scroll, i, {
				game = friend.location,
				thumb = placeThumb(friend.placeId),
				user = friend.userId,
				headshot = headshot(friend.userId, 48),
			}, function()
				Novo.Features.Friends.join(friend)
			end)
		end

		empty.Visible = #list == 0
		scroll.CanvasSize = UDim2.fromOffset(0, #list * 114)
	end

	task.spawn(function()
		while page.Parent do
			fillFriends()
			task.wait(#scroll:GetChildren() > 1 and 30 or 5)
		end
	end)

	return page
end
end

do
local Util  = Novo.Util
local Theme = Novo.Theme
local new   = Util.new

local SLIDE = TweenInfo.new(0.18, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
local FADE  = TweenInfo.new(0.20, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local SNAP  = Util.Motion.Snap

local SUBTITLE   = Color3.fromRGB(180, 180, 190)
local ROW_TINT   = Color3.fromRGB(88, 75, 10)
local PIN_GOLD   = Color3.fromRGB(255, 190, 30)
local PIN_TEXT   = Color3.fromRGB(220, 170, 30)
local SWITCH_RIM = Color3.fromRGB(18, 18, 20)
local THUMB_OFF_TOP = Color3.fromRGB(40, 40, 44)
local THUMB_ON_TOP  = Color3.fromRGB(91, 160, 245)
local THUMB_ON_BOT  = Color3.fromRGB(29, 67, 147)

local WHITE = Color3.fromRGB(255, 255, 255)

local PIN_ICON = "rbxassetid://102437792716891"

local ROW_STEP     = 40
local ROW_H        = 38
local FEATURED_TOP = 28
local ALL_TOP      = 336
local CANVAS_H     = 4060

local THUMB_OFF = UDim2.new(0, 15, 0.5, 0)
local THUMB_ON  = UDim2.new(0, 33, 0.5, 0)

local ROW_REST  = 1
local ROW_HOVER = 0.93
local ROW_PRESS = 0.88

local CATEGORIES = {
	{ label = "All",       width = 32 },
	{ label = "Toggles",   width = 57 },
	{ label = "Character", width = 67 },
	{ label = "Movement",  width = 73 },
	{ label = "Troll",     width = 41 },
	{ label = "Exploit",   width = 53 },
	{ label = "Misc",      width = 42 },
	{ label = "Custom",    width = 57 },
}

local FEATURED = {
	{ "reanim ", "Open reanim animations panel" },
	{ "togglefly [tf] ", "Toggle fly on/off" },
	{ "speed [ws, walkspeed] <n>", "Set walk speed" },
	{ "stationarywalk [swalk, statwalk] ", "Full-speed walk anims while moving slower", toggle = true },
	{ "vcbooster [vcboost, boostvc] <p>", "Open voice chat booster" },
	{ "chatedit [chateditor, fechat, fcedit] <cover> <text>", "Open FE chat editor" },
	{ "vcbypasser [vcb] ", "Open VC bypasser panel" },
}

local ALL = {
	{ "adonisbypass [adonis, ab] ", "Bypass Adonis admin detection" },
	{ "age <p>", "Show a player's account age" },
	{ "aimbot [aim] ", "Open Aimbot panel", toggle = true },
	{ "airwalk [aw] ", "Walk on air (Space to go up)", toggle = true },
	{ "anim [ani] <s>", "Play animation by name or ID" },
	{ "animbundle [ab, anims] ", "Open Animation Bundles menu" },
	{ "animlogger [al] ", "Toggle animation spy logger" },
	{ "annoy [an] <p>", "Teleport around a player" },
	{ "antiafk [aafk] ", "Prevent AFK kick", toggle = true },
	{ "antifling [af] ", "Disable others' collision", toggle = true },
	{ "antikick [ak] ", "Client-side anti-kick hook" },
	{ "antisit [as2] ", "Prevent being sat in a seat", toggle = true },
	{ "antiteleport [at] ", "Block TeleportService from moving you", toggle = true },
	{ "ass <n>", "Big ass (visual). Optional size 1-8" },
	{ "asseat [as] ", "Open asseat panel, make people eat your ass.", toggle = true },
	{ "asseat2 [as2] ", "Open asseat2 panel - weld method. Do not use on shitty executors.", toggle = true },
	{ "attach [att] <p>", "Weld yourself to a player" },
	{ "autoexecute [ae] <s>", "Toggle a command on/off the auto-run list" },
	{ "autograbtools ", "Auto-grab tools dropped into workspace", toggle = true },
	{ "automate [autoif] ", "Open automate rule builder" },
	{ "backpack [bp] <p>", "Ride on player's back" },
	{ "backpack2 <p>", "Ride on player's back - weld method. Do not use on shitty executors." },
	{ "bang [bng] ", "Open bang control panel" },
	{ "bang2 [bng2] ", "Open bang2 panel - weld method. Do not use on shitty executors." },
	{ "brightness <n>", "Set lighting brightness" },
	{ "btools [bt] ", "Give client building tools. Does not replicate." },
	{ "carpet [cp] <p>", "Lie under player" },
	{ "chat ", "Open cross-server chat panel" },
	{ "chatmute [cm] <p>", "Mute a player in your chat" },
	{ "clearprofiles [cpf] ", "Delete every saved Novoline profile" },
	{ "clearsettings [cs] ", "Disable active toggles and restore default settings" },
	{ "clearwaypoints [cwp] ", "Delete all saved waypoints" },
	{ "clearwearing ", "Remove all worn accessories" },
	{ "clickfling [cf] ", "Click a player to fling them (SkidFling)", toggle = true },
	{ "clip ", "Disable noclip" },
	{ "cobalt ", "Improved RemoteSpy" },
	{ "console ", "Open dev console" },
	{ "copycoords [copycoord, coords, copycframe] ", "Copy current xyz and cframe" },
	{ "copyemote [syncemote, copyanim] <p>", "Copy target player's animation" },
	{ "copyid [cid] <p>", "Copy a player's UserID to clipboard" },
	{ "copyname [cn] <p>", "Copy a player's username to clipboard" },
	{ "copyuser [cu] <p>", "Copy player username" },
	{ "creepywalk [cw] ", "Creepy looped walk/run anim", toggle = true },
	{ "day ", "Set time to day" },
	{ "delete [del, remove] <p>", "Hide a player's character" },
	{ "deletewaypoint [dwp] <n>", "Delete a named waypoint" },
	{ "dex ", "Load Dex Explorer" },
	{ "dick <n>", "Dick (visual). Optional length 0.5-6" },
	{ "disableanims ", "Disable character animations", toggle = true },
	{ "disablebinds <permanent|session-wise>", "Disable keybind execution", toggle = true },
	{ "disableproximityprompts ", "Disable all ProximityPrompts" },
	{ "disablesit [ds] ", "Prevent your character from sitting", toggle = true },
	{ "discord ", "Copy Discord invite" },
	{ "drift [ice, slide] <s>", "Sit and ice-slide with WASD", toggle = true },
	{ "drophats [dh] ", "Drop hats as physical objects" },
	{ "droptools [dt] ", "Drop all tools from your backpack" },
	{ "enableanims ", "Enable character animations" },
	{ "enablebinds ", "Enable keybind execution" },
	{ "enableproximityprompts ", "Enable all ProximityPrompts" },
	{ "enablesit ", "Re-enable sitting" },
	{ "equiptools [et] ", "Equip every tool from backpack", toggle = true },
	{ "esp [wallhack, wh] ", "Open ESP panel", toggle = true, on = true },
	{ "facebang [fb] ", "Open facebang control panel" },
	{ "facebang2 ", "Open facebang2 panel - weld method. Do not use on shitty executors." },
	{ "fakelag [lag] ", "Open fakelag panel", toggle = true },
	{ "fakeout [fo] ", "Briefly void yourself then snap back" },
	{ "fcgoto [fctp] <p>", "Move freecam to player" },
	{ "fcspeed <n>", "Set freecam nav speed" },
	{ "findfriendgroups ", "Find groups of friends in the server" },
	{ "fireclickdetectors ", "Fire all ClickDetectors in workspace" },
	{ "fireproximityprompts ", "Fire all proximity prompts" },
	{ "fireproximitypromptsfind <s>", "Fire proximity prompts matching name" },
	{ "firework ", "Launch into the air spinning like a firework then explode and reset" },
	{ "fling [fl] ", "Spin fling yourself", toggle = true },
	{ "float [plat, platform] ", "Spawn a platform beneath you (Q=down, E=up)", toggle = true },
	{ "fly [f] <s>", "Start flying; optional speed", toggle = true, bind = "F" },
	{ "flyspeed [fs, flysp] <s>", "Set fly speed (default 1)" },
	{ "fov [cam] <n>", "Set field of view" },
	{ "fps ", "Show current framerate" },
	{ "freecam [fc] ", "Enter free camera", toggle = true },
	{ "freecamspeed [fcs] <n>", "Set freecam nav speed" },
	{ "freeze [fr] ", "Anchor all your character parts (client)", toggle = true },
	{ "friend [fr2] <p>", "Send friend request" },
	{ "friends [fr] ", "Open friends online panel" },
	{ "ftp [mousetp] ", "Teleport to mouse (F key)", toggle = true },
	{ "fullbright ", "Maximize all light ranges", toggle = true },
	{ "gamepass ", "Open purchase toggler / gamepass event catcher" },
	{ "gamma <n>", "Set lighting exposure/gamma" },
	{ "generate <n>", "Generate an item" },
	{ "globalshadows [gs] ", "Enable global shadows", toggle = true },
	{ "goto [tp, to] <p>", "Teleport to player" },
	{ "gotowaypoint [gwp, wp] <n>", "Teleport to a saved waypoint" },
	{ "grabtools [gt] ", "Grab dropped tools from workspace" },
}

local function switchGlow(parent, transparency)
	local ok, shadow = pcall(function()
		return new("UIShadow", {
			Color = Theme.Accent,
			Transparency = transparency,
			Parent = parent,
		})
	end)
	return ok and shadow or nil
end

local function buildCaption(parent, opts)
	local holder = new("Frame", {
		Name = "Caption",
		Position = UDim2.new(0, 0, 0, opts.y),
		Size = UDim2.new(1, 0, 0, 28),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Visible = opts.visible ~= false,
		ZIndex = 13,
		Parent = parent,
	})

	if opts.rule then
		new("Frame", {
			Name = "Rule",
			Position = UDim2.new(0, 10, 0, 0),
			Size = UDim2.new(1, -20, 0, 1),
			BackgroundColor3 = Theme.Divider,
			BorderSizePixel = 0,
			Visible = false,
			ZIndex = 13,
			Parent = holder,
		})
	end

	if opts.icon then
		new("ImageLabel", {
			Name = "Glyph",
			Position = UDim2.new(0, 10, 0.5, 0),
			Size = UDim2.fromOffset(opts.iconSize, opts.iconSize),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundTransparency = 1,
			Image = opts.icon,
			ImageColor3 = opts.iconColor,
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 14,
			Parent = holder,
		})
	end

	new("TextLabel", {
		Name = "Label",
		Position = UDim2.new(0, opts.textX, 0.5, 0),
		Size = opts.textSize,
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Text = opts.text,
		TextColor3 = opts.color,
		TextSize = 10,
		TextTransparency = opts.textTransparency or 0,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		FontFace = Theme.Font.Bold,
		ZIndex = 14,
		Parent = holder,
	})

	return holder
end

local function buildRow(parent, data, y)
	local hasSwitch = data.toggle == true
	local textInset = hasSwitch and -140 or -84
	local chipX = hasSwitch and -88 or -32

	local row = new("Frame", {
		Name = "Row",
		Position = UDim2.new(0, 6, 0, y),
		Size = UDim2.new(1, -14, 0, ROW_H),
		BackgroundColor3 = WHITE,
		BackgroundTransparency = ROW_REST,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 13,
		Parent = parent,
	})
	Util.corner(Theme.R_Button, row)
	new("UIGradient", {
		Color = ColorSequence.new(WHITE),
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.32),
			NumberSequenceKeypoint.new(0.42, 0.62),
			NumberSequenceKeypoint.new(1, 0.92),
		}),
		Rotation = 90,
		Parent = row,
	})

	local tint = new("Frame", {
		Name = "PinTint",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = ROW_TINT,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 13,
		Parent = row,
	})
	Util.corner(Theme.R_Button, tint)

	new("TextLabel", {
		Name = "Title",
		Position = UDim2.new(0, 10, 0, 5),
		Size = UDim2.new(1, textInset, 0, 16),
		BackgroundTransparency = 1,
		Text = data[1],
		TextColor3 = Theme.Text,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		TextTruncate = Enum.TextTruncate.AtEnd,
		FontFace = Theme.Font.Bold,
		ZIndex = 14,
		Parent = row,
	})

	new("TextLabel", {
		Name = "Desc",
		Position = UDim2.new(0, 10, 0, 22),
		Size = UDim2.new(1, textInset, 0, 12),
		BackgroundTransparency = 1,
		Text = data[2],
		TextColor3 = Theme.TextMuted,
		TextSize = 10,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		TextTruncate = Enum.TextTruncate.AtEnd,
		FontFace = Theme.Font.Medium,
		ZIndex = 14,
		Parent = row,
	})

	local pin = new("ImageButton", {
		Name = "Pin",
		Position = UDim2.new(1, -8, 0.5, 0),
		Size = UDim2.fromOffset(16, 16),
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = PIN_ICON,
		ImageColor3 = Theme.TextMuted,
		ImageTransparency = 0.4,
		ScaleType = Enum.ScaleType.Stretch,
		AutoButtonColor = false,
		ZIndex = 16,
		Parent = row,
	})

	local track = new("Frame", {
		Name = "SwitchTrack",
		Position = UDim2.new(1, -32, 0.5, 0),
		Size = UDim2.fromOffset(48, 22),
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundColor3 = Theme.PanelDeep,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		Visible = hasSwitch,
		ZIndex = 16,
		Parent = row,
	})
	Util.corner(Theme.R_Pill, track)
	Util.stroke(SWITCH_RIM, 1, Theme.T_Stroke, Enum.ApplyStrokeMode.Contextual, track)

	local on = data.on == true

	local thumb = new("Frame", {
		Name = "SwitchThumb",
		Position = on and THUMB_ON or THUMB_OFF,
		Size = UDim2.fromOffset(26, 18),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = WHITE,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ZIndex = 18,
		Parent = track,
	})
	Util.corner(Theme.R_Pill, thumb)
	local thumbGrad = new("UIGradient", {
		Color = on
			and ColorSequence.new(THUMB_ON_TOP, THUMB_ON_BOT)
			or ColorSequence.new(THUMB_OFF_TOP, Theme.Panel),
		Transparency = NumberSequence.new(0, 0),
		Rotation = 90,
		Parent = thumb,
	})
	local glow = switchGlow(thumb, on and 0.28 or 0.94)

	local thumbScale = new("UIScale", { Scale = 1, Parent = track })

	local switchHit = new("TextButton", {
		Name = "SwitchHit",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = "",
		TextSize = 8,
		AutoButtonColor = false,
		ZIndex = 18,
		Parent = track,
	})

	local hit = new("TextButton", {
		Name = "Hit",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = "",
		TextSize = 8,
		AutoButtonColor = false,
		ZIndex = 14,
		Parent = row,
	})

	local chip = new("Frame", {
		Name = "Bind",
		Position = UDim2.new(1, chipX, 0.5, 0),
		Size = UDim2.fromOffset(48, 22),
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 15,
		Parent = row,
	})
	Util.corner(Theme.R_Button, chip)

	local bound = data.bind ~= nil
	local chipLabel = new("TextLabel", {
		Name = "Label",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = data.bind or "+ bind",
		TextColor3 = bound and Theme.Text or Theme.TextFaint,
		TextSize = 10,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		TextTruncate = Enum.TextTruncate.AtEnd,
		FontFace = Theme.Font.Medium,
		ZIndex = 16,
		Parent = chip,
	})

	local chipHit = new("TextButton", {
		Name = "Hit",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = "",
		TextSize = 8,
		AutoButtonColor = true,
		ZIndex = 17,
		Parent = chip,
	})

	local hovered, held = false, false
	local function paint()
		local goal = ROW_REST
		if held then
			goal = ROW_PRESS
		elseif hovered then
			goal = ROW_HOVER
		end
		Util.tween(row, SNAP, { BackgroundTransparency = goal })
	end

	hit.MouseEnter:Connect(function()
		hovered = true
		paint()
	end)
	hit.MouseLeave:Connect(function()
		hovered, held = false, false
		paint()
	end)
	hit.MouseButton1Down:Connect(function()
		held = true
		paint()
	end)
	hit.MouseButton1Up:Connect(function()
		held = false
		paint()
	end)

	local pinned = false
	pin.MouseEnter:Connect(function()
		if pinned then return end
		Util.tween(pin, SNAP, { ImageTransparency = 0.05 })
	end)
	pin.MouseLeave:Connect(function()
		if pinned then return end
		Util.tween(pin, SNAP, { ImageTransparency = 0.4 })
	end)
	pin.MouseButton1Click:Connect(function()
		pinned = not pinned
		Util.tween(pin, FADE, {
			ImageTransparency = pinned and 0 or 0.4,
			ImageColor3 = pinned and PIN_GOLD or Theme.TextMuted,
		})
		Util.tween(tint, FADE, { BackgroundTransparency = pinned and 0.88 or 1 })
	end)

	chipHit.MouseEnter:Connect(function()
		Util.tween(chip, SNAP, { BackgroundTransparency = 0.9 })
		Util.tween(chipLabel, SNAP, { TextColor3 = Theme.Text })
	end)
	chipHit.MouseLeave:Connect(function()
		Util.tween(chip, SNAP, { BackgroundTransparency = 1 })
		Util.tween(chipLabel, SNAP, { TextColor3 = bound and Theme.Text or Theme.TextFaint })
	end)

	local state = on
	local function applySwitch(animate)
		local info = animate and Util.Motion.Quick or SNAP
		if animate then
			Util.tween(thumb, info, { Position = state and THUMB_ON or THUMB_OFF })
		else
			thumb.Position = state and THUMB_ON or THUMB_OFF
		end
		thumbGrad.Color = state
			and ColorSequence.new(THUMB_ON_TOP, THUMB_ON_BOT)
			or ColorSequence.new(THUMB_OFF_TOP, Theme.Panel)
		if glow then
			Util.tween(glow, FADE, { Transparency = state and 0.28 or 0.94 })
		end
	end

	switchHit.MouseButton1Down:Connect(function()
		Util.tween(thumbScale, SNAP, { Scale = 0.94 })
	end)
	switchHit.MouseButton1Up:Connect(function()
		Util.tween(thumbScale, SNAP, { Scale = 1 })
	end)
	switchHit.MouseLeave:Connect(function()
		Util.tween(thumbScale, SNAP, { Scale = 1 })
	end)
	switchHit.MouseButton1Click:Connect(function()
		state = not state
		applySwitch(true)
	end)

	return row
end

Novo.Pages.Commands = function(parent)
	local page = Util.new("Frame", {
		Name = "Content_Commands",
		Position = UDim2.fromOffset(0, 0),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 22,
		Parent = parent,
	})

	local tabFill = new("Frame", {
		Name = "TabFill",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 1,
		Parent = page,
	})
	Util.corner(Theme.R_Panel, tabFill)
	local wall, wash = Util.frostedBacking(tabFill, Theme.R_Panel, Theme.T_Overlay)
	wall.ZIndex = 2
	wash.ZIndex = 3

	local header = new("Frame", {
		Name = "Header",
		Size = UDim2.new(1, 0, 0, 54),
		BackgroundTransparency = 1,
		ZIndex = 12,
		Parent = page,
	})

	new("ImageLabel", {
		Name = "Glyph",
		Position = UDim2.fromOffset(14, 17),
		Size = UDim2.fromOffset(18, 18),
		BackgroundTransparency = 1,
		Image = Theme.Icon.Commands,
		ImageTransparency = 0,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 13,
		Parent = header,
	})

	local title = new("TextLabel", {
		Name = "Title",
		Position = UDim2.fromOffset(40, 14),
		Size = UDim2.new(1, -50, 0, 22),
		BackgroundTransparency = 1,
		Text = "Commands",
		TextColor3 = Theme.Text,
		TextSize = 17,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		FontFace = Theme.Font.Bold,
		ZIndex = 13,
		Parent = header,
	})

	local subtitle = new("TextLabel", {
		Name = "Subtitle",
		Position = UDim2.fromOffset(14, 36),
		Size = UDim2.new(1, -24, 0, 14),
		BackgroundTransparency = 1,
		Text = "Commands List",
		TextColor3 = SUBTITLE,
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		FontFace = Theme.Font.Medium,
		ZIndex = 13,
		Parent = header,
	})

	local backing = new("Frame", {
		Name = "ListBacking",
		Position = UDim2.fromOffset(8, 140),
		Size = UDim2.new(1, -16, 1, -148),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = 0.82,
		BorderSizePixel = 0,
		ZIndex = 11,
		Parent = page,
	})
	Util.corner(Theme.R_Button, backing)

	local scrollHost = new("Frame", {
		Name = "ListHost",
		Position = UDim2.fromOffset(10, 142),
		Size = UDim2.new(1, -20, 1, -150),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 12,
		Parent = page,
	})

	local scroll = new("ScrollingFrame", {
		Name = "Scroll",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		CanvasSize = UDim2.fromOffset(0, CANVAS_H),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollBarThickness = 0,
		ScrollBarImageTransparency = 0,
		ScrollingDirection = Enum.ScrollingDirection.XY,
		VerticalScrollBarInset = Enum.ScrollBarInset.None,
		ZIndex = 11,
		Parent = scrollHost,
	})

	new("TextLabel", {
		Name = "Empty",
		Position = UDim2.new(0.5, 0, 0, 32),
		Size = UDim2.new(1, -32, 0, 0),
		AnchorPoint = Vector2.new(0.5, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Text = "No custom commands found.\nAdd .lua or .txt files to Novoline/Scripts/ to add.",
		TextColor3 = Theme.TextFaint,
		TextSize = 12,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		FontFace = Theme.Font.Medium,
		Visible = false,
		ZIndex = 13,
		Parent = scroll,
	})

	local content = new("Frame", {
		Name = "Content",
		Size = UDim2.new(1, 0, 0, CANVAS_H),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 12,
		Parent = scroll,
	})

	buildCaption(content, {
		y = 0,
		text = "FEATURED COMMANDS",
		color = Theme.Accent,
		textX = 30,
		textSize = UDim2.new(1, -30, 1, 0),
		icon = Theme.Icon.Commands,
		iconSize = 14,
		iconColor = Theme.Accent,
	})

	buildCaption(content, {
		y = 0,
		text = "PINNED",
		color = PIN_TEXT,
		textX = 28,
		textSize = UDim2.new(1, -28, 1, 0),
		icon = PIN_ICON,
		iconSize = 12,
		iconColor = PIN_GOLD,
		visible = false,
	})

	buildCaption(content, {
		y = 308,
		text = "ALL",
		color = Theme.TextMuted,
		textX = 10,
		textSize = UDim2.new(1, -10, 0, 14),
		textTransparency = 0.3,
		rule = true,
	})

	for i, data in ipairs(FEATURED) do
		buildRow(content, data, FEATURED_TOP + (i - 1) * ROW_STEP)
	end
	for i, data in ipairs(ALL) do
		buildRow(content, data, ALL_TOP + (i - 1) * ROW_STEP)
	end

	local search = new("Frame", {
		Name = "Search",
		Position = UDim2.fromOffset(10, 96),
		Size = UDim2.new(1, -20, 0, 34),
		BackgroundColor3 = Theme.Raise,
		BackgroundTransparency = 0.55,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 15,
		Parent = page,
	})
	Util.corner(Theme.R_Nav, search)
	local searchStroke = Util.stroke(Theme.Stroke, 1, 0.6, Enum.ApplyStrokeMode.Border, search)

	local searchShine = Util.surfaceShine(search, 34, Theme.R_Nav, 0.88, {
		NumberSequenceKeypoint.new(0, 0.22),
		NumberSequenceKeypoint.new(0.55, 0.78),
		NumberSequenceKeypoint.new(1, 1),
	}, 16)
	searchShine.Fill.Size = UDim2.new(1, 0, 0, 6)

	local box = new("TextBox", {
		Name = "Input",
		Position = UDim2.fromOffset(12, 0),
		Size = UDim2.new(1, -24, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		PlaceholderText = "Search / Execute",
		PlaceholderColor3 = Theme.TextFaint,
		TextColor3 = Theme.Text,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		FontFace = Theme.Font.Medium,
		ClearTextOnFocus = false,
		MultiLine = false,
		ZIndex = 16,
		Parent = search,
	})

	box.Focused:Connect(function()
		Util.tween(search, SNAP, { BackgroundTransparency = 0.44 })
		Util.tween(searchStroke, SNAP, { Transparency = 0.25 })
	end)
	box.FocusLost:Connect(function()
		Util.tween(search, SNAP, { BackgroundTransparency = 0.55 })
		Util.tween(searchStroke, SNAP, { Transparency = 0.6 })
	end)

	local catRow = new("Frame", {
		Name = "Categories",
		Position = UDim2.fromOffset(10, 62),
		Size = UDim2.new(1, -20, 0, 26),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 13,
		Parent = page,
	})

	local catTrack = new("Frame", {
		Name = "Track",
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.new(0, 477, 1, 0),
		BackgroundColor3 = Theme.Raise,
		BackgroundTransparency = 0.55,
		BorderSizePixel = 0,
		ZIndex = 12,
		Parent = catRow,
	})
	Util.corner(UDim.new(0, 13), catTrack)
	Util.stroke(Theme.Divider, 1, 0.55, Enum.ApplyStrokeMode.Contextual, catTrack)

	local catInner = new("Frame", {
		Name = "Inner",
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.new(0, 461, 1, 0),
		BackgroundTransparency = 1,
		ZIndex = 13,
		Parent = catRow,
	})

	local catHolder = new("Frame", {
		Name = "Holder",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ZIndex = 13,
		Parent = catInner,
	})
	Util.padding(0, 0, 2, 2, catHolder)
	Util.list(Enum.FillDirection.Horizontal, 5, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center, catHolder)

	local catPill = new("Frame", {
		Name = "Pill",
		Position = UDim2.new(0, 2, 0.5, 0),
		Size = UDim2.fromOffset(CATEGORIES[1].width, 20),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Theme.Accent,
		BackgroundTransparency = 0.42,
		BorderSizePixel = 0,
		ZIndex = 13,
		Parent = catInner,
	})
	Util.corner(Theme.R_Pill, catPill)
	new("UIGradient", {
		Color = ColorSequence.new(WHITE),
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.7),
			NumberSequenceKeypoint.new(0.5, 0),
			NumberSequenceKeypoint.new(1, 0.7),
		}),
		Rotation = 0,
		Parent = catPill,
	})

	local catButtons = {}
	local catActive = 1
	local catX = {}
	do
		local x = 2
		for i, cat in ipairs(CATEGORIES) do
			catX[i] = x
			x = x + cat.width + 5
		end
	end

	local function selectCategory(index)
		if catActive == index then return end
		catActive = index
		Util.tween(catPill, SLIDE, {
			Position = UDim2.new(0, catX[index], 0.5, 0),
			Size = UDim2.fromOffset(CATEGORIES[index].width, 20),
		})
		for i, btn in ipairs(catButtons) do
			Util.tween(btn, FADE, { TextColor3 = (i == index) and Theme.Text or Theme.TextMuted })
		end
	end

	for i, cat in ipairs(CATEGORIES) do
		local btn = new("TextButton", {
			Name = cat.label,
			Size = UDim2.fromOffset(cat.width, 24),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Text = cat.label,
			TextColor3 = (i == 1) and Theme.Text or Theme.TextMuted,
			TextSize = 11,
			TextTransparency = 0,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			FontFace = Theme.Font.Medium,
			AutoButtonColor = false,
			LayoutOrder = i,
			ZIndex = 14,
			Parent = catHolder,
		})
		Util.corner(UDim.new(0, 12), btn)
		catButtons[i] = btn

		btn.MouseEnter:Connect(function()
			if catActive == i then return end
			Util.tween(btn, SNAP, { TextColor3 = Theme.TextFaint })
		end)
		btn.MouseLeave:Connect(function()
			if catActive == i then return end
			Util.tween(btn, SNAP, { TextColor3 = Theme.TextMuted })
		end)
		btn.MouseButton1Click:Connect(function()
			selectCategory(i)
		end)
	end

	local bands = {
		{ inst = header,     rest = UDim2.new(0, 0, 0, 0) },
		{ inst = catRow,     rest = UDim2.fromOffset(10, 62) },
		{ inst = search,     rest = UDim2.fromOffset(10, 96) },
		{ inst = backing,    rest = UDim2.fromOffset(8, 140) },
		{ inst = scrollHost, rest = UDim2.fromOffset(10, 142) },
	}

	local function playOpen()
		for i, band in ipairs(bands) do
			band.inst.Position = band.rest + UDim2.fromOffset(0, 8)
			Util.tween(band.inst, SLIDE, { Position = band.rest })
		end
		title.TextTransparency = 1
		subtitle.TextTransparency = 1
		backing.BackgroundTransparency = 1
		Util.tween(title, FADE, { TextTransparency = 0 })
		Util.tween(subtitle, FADE, { TextTransparency = 0 })
		Util.tween(backing, FADE, { BackgroundTransparency = 0.82 })
	end

	page:GetPropertyChangedSignal("Visible"):Connect(function()
		if page.Visible then
			playOpen()
		end
	end)

	return page
end
end

do
do
	local Util  = Novo.Util
	local Theme = Novo.Theme
	local new   = Util.new

	local SLIDE = TweenInfo.new(0.18, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
	local FADE  = TweenInfo.new(0.20, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
	local SNAP  = Util.Motion.Snap

	local ROW_INSET = 8
	local ROW_H     = 62
	local ROW_GAP   = 8
	local ACTIONS_H = 68

	local ROW_BG_IDLE  = 0.55
	local ROW_BG_HOVER = 0.46
	local ROW_BG_DOWN  = 0.62
	local ROW_STROKE_IDLE  = 1
	local ROW_STROKE_HOVER = 0.45

	local BAR_BG_IDLE  = 0.55
	local BAR_BG_HOVER = 0.50
	local BAR_ST_IDLE  = 0.60
	local BAR_ST_HOVER = 0.45
	local BAR_ST_FOCUS = 0.30

	local CHEVRON = "rbxassetid://95260093888388"

	local function rosterNow()
		local list = {}
		for _, plr in ipairs(Players:GetPlayers()) do
			list[#list + 1] = {
				name = plr.DisplayName,
				handle = "@" .. plr.Name,
				id = plr.UserId,
				player = plr,
			}
		end
		table.sort(list, function(a, b)
			if a.player == LocalPlayer then return true end
			if b.player == LocalPlayer then return false end
			return string.lower(a.name) < string.lower(b.name)
		end)
		return list
	end

	local ACTIONS = {
		{ text = "Goto", icon = "rbxassetid://95909101617107" },
		{ text = "Hide", icon = "rbxassetid://88775304681055" },
		{ text = "Mute", icon = "rbxassetid://114697945255264" },
		{ text = "ESP",  icon = "rbxassetid://91355941104015" },
	}

	local function collectFade(root, out)
		for _, d in ipairs(root:GetDescendants()) do
			if d:IsA("TextLabel") or d:IsA("TextBox") then
				out[#out + 1] = { d, "TextTransparency", d.TextTransparency }
			elseif d:IsA("ImageLabel") then
				out[#out + 1] = { d, "ImageTransparency", d.ImageTransparency }
			elseif d:IsA("UIStroke") then
				out[#out + 1] = { d, "Transparency", d.Transparency }
			elseif d:IsA("Frame") and d.BackgroundTransparency < 1 then
				out[#out + 1] = { d, "BackgroundTransparency", d.BackgroundTransparency }
			end
		end
	end

	local function buildAction(parent, spec, slot)
		local btn = new("TextButton", {
			Position = UDim2.new(0.25 * slot, 0, 0, 0),
			Size = UDim2.new(0.25, 0, 1, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			Text = "",
			TextSize = 8,
			AutoButtonColor = false,
			ZIndex = 15,
			Parent = parent,
		})

		local content = new("Frame", {
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.new(1, -4, 1, 0),
			BackgroundTransparency = 1,
			ZIndex = 16,
			Parent = btn,
		})
		local layout = Util.list(Enum.FillDirection.Horizontal, 4,
			Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center, content)
		layout.SortOrder = Enum.SortOrder.Name

		local icon = new("ImageLabel", {
			Size = UDim2.fromOffset(12, 12),
			BackgroundTransparency = 1,
			Image = spec.icon,
			ImageColor3 = Theme.TextMuted,
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 17,
			Parent = content,
		})

		local label = new("TextLabel", {
			Size = UDim2.new(0, 0, 1, 0),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			Text = spec.text,
			TextColor3 = Theme.TextFaint,
			TextSize = 10,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			FontFace = Theme.Font.Bold,
			ZIndex = 17,
			Parent = content,
		})

		local function paint(iconColor, textColor, iconAlpha)
			Util.tween(icon, SNAP, { ImageColor3 = iconColor, ImageTransparency = iconAlpha })
			Util.tween(label, SNAP, { TextColor3 = textColor })
		end

		local hovering = false
		btn.MouseEnter:Connect(function()
			hovering = true
			paint(Theme.TextFaint, Theme.Text, 0)
		end)
		btn.MouseLeave:Connect(function()
			hovering = false
			paint(Theme.TextMuted, Theme.TextFaint, 0)
		end)
		btn.MouseButton1Down:Connect(function()
			paint(Theme.TextBright, Theme.TextBright, 0.25)
		end)
		btn.MouseButton1Up:Connect(function()
			if hovering then
				paint(Theme.TextFaint, Theme.Text, 0)
			else
				paint(Theme.TextMuted, Theme.TextFaint, 0)
			end
		end)

		return btn, function(on)
			if on then
				paint(Theme.AccentLight, Theme.AccentLight, 0)
			else
				paint(Theme.TextMuted, Theme.TextFaint, 0)
			end
		end
	end

	local function buildRow(scroll, data)
		local row = new("Frame", {
			Position = UDim2.new(0, ROW_INSET, 0, ROW_INSET),
			Size = UDim2.new(1, -ROW_INSET * 2, 0, ROW_H),
			BackgroundColor3 = Theme.Raise,
			BackgroundTransparency = ROW_BG_IDLE,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			ZIndex = 12,
			Parent = scroll,
		})
		Util.corner(Theme.R_Button, row)
		local rowStroke = Util.stroke(Theme.Divider, 1, ROW_STROKE_IDLE,
			Enum.ApplyStrokeMode.Contextual, row)

		local avatar = new("Frame", {
			Position = UDim2.new(0, 12, 0, 31),
			Size = UDim2.fromOffset(36, 36),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Color3.fromRGB(18, 18, 20),
			BackgroundTransparency = 0.3,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			ZIndex = 13,
			Parent = row,
		})
		Util.corner(Theme.R_Pill, avatar)

		local headshot = new("ImageLabel", {
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Image = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150", data.id),
			ScaleType = Enum.ScaleType.Crop,
			ZIndex = 14,
			Parent = avatar,
		})
		Util.corner(Theme.R_Pill, headshot)

		new("TextLabel", {
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Visible = false,
			Text = string.upper(string.sub(data.name, 1, 1)),
			TextColor3 = Theme.Accent,
			TextSize = 17,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			FontFace = Theme.Font.Medium,
			ZIndex = 13,
			Parent = avatar,
		})

		new("TextLabel", {
			Position = UDim2.new(0, 58, 0, 31),
			Size = UDim2.new(1, -76, 0, 16),
			AnchorPoint = Vector2.new(0, 1),
			BackgroundTransparency = 1,
			Text = data.name,
			TextColor3 = Theme.Text,
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
			TextTruncate = Enum.TextTruncate.AtEnd,
			FontFace = Theme.Font.Medium,
			ZIndex = 13,
			Parent = row,
		})

		new("TextLabel", {
			Position = UDim2.new(0, 58, 0, 32),
			Size = UDim2.new(1, -76, 0, 13),
			BackgroundTransparency = 1,
			Text = data.handle,
			TextColor3 = Theme.TextMuted,
			TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
			TextTruncate = Enum.TextTruncate.AtEnd,
			FontFace = Theme.Font.Medium,
			ZIndex = 13,
			Parent = row,
		})

		local chevron = new("ImageLabel", {
			Position = UDim2.new(1, -18, 0, 31),
			Size = UDim2.fromOffset(10, 10),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			Image = CHEVRON,
			ImageColor3 = Theme.TextMuted,
			ImageTransparency = 0.6,
			ScaleType = Enum.ScaleType.Stretch,
			ZIndex = 13,
			Parent = row,
		})

		local actions = new("Frame", {
			Position = UDim2.new(0, 0, 0, ROW_H),
			Size = UDim2.new(1, 0, 0, ACTIONS_H),
			BackgroundTransparency = 1,
			ZIndex = 13,
			Parent = row,
		})

		local divider = new("Frame", {
			Position = UDim2.new(0, 8, 0, 0),
			Size = UDim2.new(1, -16, 0, 1),
			BackgroundColor3 = Theme.Stroke,
			BackgroundTransparency = 0.5,
			BorderSizePixel = 0,
			Visible = false,
			ZIndex = 13,
			Parent = actions,
		})

		local strip = new("Frame", {
			Position = UDim2.new(0, 12, 0, 17),
			Size = UDim2.new(1, -24, 0, 34),
			BackgroundColor3 = Theme.Raise,
			BackgroundTransparency = 0.55,
			BorderSizePixel = 0,
			ZIndex = 14,
			Parent = actions,
		})
		Util.corner(Theme.R_Nav, strip)
		Util.stroke(Theme.Divider, 1, 0.5, Enum.ApplyStrokeMode.Contextual, strip)

		local plr = data.player
		for i, spec in ipairs(ACTIONS) do
			local btn, setLit = buildAction(strip, spec, i - 1)
			local F = Novo.Features
			if F and plr then
				local T = F.Target
				if spec.text == "Goto" then
					btn.MouseButton1Click:Connect(function() T.goTo(plr) end)
				elseif spec.text == "Hide" then
					setLit(T.hidden[plr] == true)
					btn.MouseButton1Click:Connect(function()
						setLit(T.toggleHidden(plr))
					end)
				elseif spec.text == "Mute" then
					setLit(T.muted[plr] == true)
					btn.MouseButton1Click:Connect(function()
						setLit(T.toggleMuted(plr))
					end)
				elseif spec.text == "ESP" then
					setLit(T.tagged[plr] ~= nil)
					btn.MouseButton1Click:Connect(function()
						setLit(T.toggleTagged(plr))
					end)
				end
			end
		end

		local hit = new("TextButton", {
			Size = UDim2.new(1, 0, 0, ROW_H),
			BackgroundTransparency = 1,
			Text = "",
			TextSize = 8,
			AutoButtonColor = false,
			ZIndex = 14,
			Parent = row,
		})

		local state = {
			data = data,
			frame = row,
			stroke = rowStroke,
			chevron = chevron,
			divider = divider,
			hit = hit,
			expanded = false,
			visible = true,
			hovering = false,
		}

		local function repaint(bg, strokeAlpha, chevAlpha)
			Util.tween(row, SNAP, { BackgroundTransparency = bg })
			Util.tween(rowStroke, SNAP, { Transparency = strokeAlpha })
			Util.tween(chevron, SNAP, { ImageTransparency = chevAlpha })
		end

		hit.MouseEnter:Connect(function()
			state.hovering = true
			repaint(ROW_BG_HOVER, ROW_STROKE_HOVER, 0.3)
		end)
		hit.MouseLeave:Connect(function()
			state.hovering = false
			repaint(ROW_BG_IDLE, ROW_STROKE_IDLE, 0.6)
		end)
		hit.MouseButton1Down:Connect(function()
			repaint(ROW_BG_DOWN, ROW_STROKE_HOVER, 0.2)
		end)
		hit.MouseButton1Up:Connect(function()
			if state.hovering then
				repaint(ROW_BG_HOVER, ROW_STROKE_HOVER, 0.3)
			else
				repaint(ROW_BG_IDLE, ROW_STROKE_IDLE, 0.6)
			end
		end)

		return state
	end

	Novo.Pages.Playerlist = function(parent)
		local page = new("Frame", {
			Name = "Content_Playerlist",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ClipsDescendants = true,
			ZIndex = 22,
			Parent = parent,
		})

		local fill = new("Frame", {
			Name = "TabFill",
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Theme.Panel,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			ZIndex = 1,
			Parent = page,
		})
		Util.corner(Theme.R_Panel, fill)
		local wall, wash = Util.frostedBacking(fill, Theme.R_Panel, Theme.T_Overlay)
		wall.ZIndex = 2
		wash.ZIndex = 3

		local header = new("Frame", {
			Name = "Header",
			Size = UDim2.new(1, 0, 0, 54),
			BackgroundTransparency = 1,
			ZIndex = 12,
			Parent = page,
		})

		new("ImageLabel", {
			Position = UDim2.new(0, 14, 0, 17),
			Size = UDim2.fromOffset(18, 18),
			BackgroundTransparency = 1,
			Image = Theme.Icon.Players,
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 13,
			Parent = header,
		})

		new("TextLabel", {
			Position = UDim2.new(0, 40, 0, 14),
			Size = UDim2.new(1, -50, 0, 22),
			BackgroundTransparency = 1,
			Text = "Players",
			TextColor3 = Theme.Text,
			TextSize = 17,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
			FontFace = Theme.Font.Bold,
			ZIndex = 13,
			Parent = header,
		})

		new("TextLabel", {
			Position = UDim2.new(0, 14, 0, 36),
			Size = UDim2.new(1, -24, 0, 14),
			BackgroundTransparency = 1,
			Text = "Server player list",
			TextColor3 = Color3.fromRGB(180, 180, 190),
			TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
			FontFace = Theme.Font.Medium,
			ZIndex = 13,
			Parent = header,
		})

		local bar = new("Frame", {
			Position = UDim2.new(0, 10, 0, 62),
			Size = UDim2.new(1, -20, 0, 34),
			BackgroundColor3 = Theme.Raise,
			BackgroundTransparency = BAR_BG_IDLE,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			ZIndex = 15,
			Parent = page,
		})
		Util.corner(Theme.R_Nav, bar)
		local barStroke = Util.stroke(Theme.Stroke, 1, BAR_ST_IDLE, Enum.ApplyStrokeMode.Border, bar)

		local barShine = Util.surfaceShine(bar, UDim2.fromScale(1, 1), Theme.R_Nav, 0.88,
			{
				NumberSequenceKeypoint.new(0, 0.22),
				NumberSequenceKeypoint.new(0.55, 0.78),
				NumberSequenceKeypoint.new(1, 1),
			}, 16)
		barShine.Fill.Size = UDim2.new(1, 0, 0, 6)

		local box = new("TextBox", {
			Position = UDim2.new(0, 12, 0, 0),
			Size = UDim2.new(1, -24, 1, 0),
			BackgroundTransparency = 1,
			Text = "",
			PlaceholderText = "Search players...",
			PlaceholderColor3 = Theme.TextFaint,
			TextColor3 = Theme.Text,
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			FontFace = Theme.Font.Medium,
			ClearTextOnFocus = false,
			ZIndex = 16,
			Parent = bar,
		})

		local barHover, barFocus = false, false
		local function paintBar()
			local bg = (barHover or barFocus) and BAR_BG_HOVER or BAR_BG_IDLE
			local st = barFocus and BAR_ST_FOCUS or (barHover and BAR_ST_HOVER or BAR_ST_IDLE)
			Util.tween(bar, SNAP, { BackgroundTransparency = bg })
			Util.tween(barStroke, SNAP, { Transparency = st })
		end
		bar.MouseEnter:Connect(function() barHover = true  paintBar() end)
		bar.MouseLeave:Connect(function() barHover = false paintBar() end)
		box.Focused:Connect(function() barFocus = true  paintBar() end)
		box.FocusLost:Connect(function() barFocus = false paintBar() end)

		local listArea = new("Frame", {
			Position = UDim2.new(0, 10, 0, 104),
			Size = UDim2.new(1, -20, 1, -112),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 12,
			Parent = page,
		})

		local scroll = new("ScrollingFrame", {
			Name = "Scroll",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			CanvasSize = UDim2.new(0, 0, 0, 139),
			ScrollBarThickness = 0,
			ScrollBarImageColor3 = Theme.Accent,
			ScrollBarImageTransparency = 0.6,
			ScrollingDirection = Enum.ScrollingDirection.XY,
			AutomaticCanvasSize = Enum.AutomaticSize.None,
			VerticalScrollBarInset = Enum.ScrollBarInset.None,
			ZIndex = 11,
			Parent = listArea,
		})
		Util.padding(6, 10, 0, 0, scroll)

		local rows = {}

		local function relayout(instant)
			local y = ROW_INSET
			local shown, anyOpen = 0, false
			for _, st in ipairs(rows) do
				if st.visible then
					shown += 1
					local h = st.expanded and (ROW_H + ACTIONS_H) or ROW_H
					if st.expanded then anyOpen = true end
					local pos = UDim2.new(0, ROW_INSET, 0, y)
					local size = UDim2.new(1, -ROW_INSET * 2, 0, h)
					if instant then
						st.frame.Position = pos
						st.frame.Size = size
					else
						Util.tween(st.frame, SLIDE, { Position = pos, Size = size })
					end
					y += h + ROW_GAP
				end
			end
			local canvas = 0
			if shown > 0 then
				canvas = y - ROW_GAP + 1 + (anyOpen and 0 or ACTIONS_H)
			end
			scroll.CanvasSize = UDim2.new(0, 0, 0, canvas)
		end

		local function setExpanded(target, open)
			for _, st in ipairs(rows) do
				local want = (st == target) and open or false
				if st.expanded ~= want then
					st.expanded = want
					st.divider.Visible = want
					Util.tween(st.chevron, SLIDE, { Rotation = want and 180 or 0 })
				end
			end
			relayout(false)
		end

		local rowFade = {}

		local function applyFilter()
			local q = string.lower(box.Text)
			for _, st in ipairs(rows) do
				local hit = q == ""
					or string.find(string.lower(st.data.name), q, 1, true) ~= nil
					or string.find(string.lower(st.data.handle), q, 1, true) ~= nil
				st.visible = hit
				st.frame.Visible = hit
			end
		end

		local function refreshRoster()
			for _, st in ipairs(rows) do
				st.frame:Destroy()
			end
			table.clear(rows)
			table.clear(rowFade)

			for _, data in ipairs(rosterNow()) do
				local st = buildRow(scroll, data)
				rows[#rows + 1] = st
				st.hit.MouseButton1Click:Connect(function()
					setExpanded(st, not st.expanded)
				end)

				local targets = {}
				collectFade(st.frame, targets)
				targets[#targets + 1] = { st.frame, "BackgroundTransparency", st.frame.BackgroundTransparency }
				rowFade[#rowFade + 1] = targets
			end

			applyFilter()
			relayout(true)
		end

		refreshRoster()

		box:GetPropertyChangedSignal("Text"):Connect(function()
			applyFilter()
			relayout(false)
		end)

		local chrome = {}
		collectFade(header, chrome)
		collectFade(bar, chrome)

		local introToken = 0
		local function playIntro()
			introToken += 1
			local token = introToken

			for _, t in ipairs(chrome) do
				t[1][t[2]] = 1
				Util.tween(t[1], FADE, { [t[2]] = t[3] })
			end

			for i, targets in ipairs(rowFade) do
				local st = rows[i]
				for _, t in ipairs(targets) do
					t[1][t[2]] = 1
				end
				local rest = st.frame.Position
				st.frame.Position = rest + UDim2.fromOffset(0, 10)
				task.delay(0.03 * (i - 1), function()
					if introToken ~= token then return end
					Util.tween(st.frame, SLIDE, { Position = rest })
					for _, t in ipairs(targets) do
						Util.tween(t[1], FADE, { [t[2]] = t[3] })
					end
				end)
			end
		end

		page:GetPropertyChangedSignal("Visible"):Connect(function()
			if page.Visible then
				playIntro()
			end
		end)
		playIntro()

		local function onRosterChanged()
			if not page.Parent then return end
			refreshRoster()
			if page.Visible then
				playIntro()
			end
		end

		local joined = Players.PlayerAdded:Connect(onRosterChanged)
		local left = Players.PlayerRemoving:Connect(function()
			task.defer(onRosterChanged)
		end)

		page.Destroying:Connect(function()
			joined:Disconnect()
			left:Disconnect()
		end)

		return page
	end
end
end

do
do
	local Util   = Novo.Util
	local Theme  = Novo.Theme
	local Motion = Util.Motion
	local new    = Util.new

	local ART_PLACEHOLDER = "rbxasset://textures/7hVlykd5yGxS/Novoline/mp3_art_placeholder.png"
	local IC_SHUFFLE      = "rbxasset://textures/7hVlykd5yGxS/Novoline/ic_fluent_arrow_swap_24_filled.png"
	local IC_SEARCH       = "rbxasset://textures/7hVlykd5yGxS/Novoline/ic_fluent_search_24_filled.png"
	local IC_PREV         = "rbxassetid://85355697402002"
	local IC_PLAY         = "rbxassetid://106742462148923"
	local IC_NEXT         = "rbxassetid://84091844910353"

	local SLIDE = TweenInfo.new(0.18, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
	local FADE  = TweenInfo.new(0.20, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

	local C_SUBHEAD  = Color3.fromRGB(180, 180, 190)
	local C_PROG     = Color3.fromRGB(40, 40, 44)
	local C_PLAYWRAP = Color3.fromRGB(245, 245, 248)
	local C_WHITE    = Color3.fromRGB(255, 255, 255)
	local C_ARTTINT  = Color3.fromRGB(186, 186, 196)
	local C_ARTBACK  = Color3.fromRGB(26, 26, 32)
	local C_SLIDER   = Color3.fromRGB(46, 46, 52)
	local C_CHIP     = Color3.fromRGB(18, 18, 20)

	local TRANSPORT = {
		{ name = "ShuffleBtn", x = -80, size = 20, image = IC_SHUFFLE, color = C_WHITE,    base = 0.12 },
		{ name = "PrevBtn",    x = -46, size = 24, image = IC_PREV,    color = Theme.Text, base = 0.12 },
		{ name = "NextBtn",    x =  46, size = 24, image = IC_NEXT,    color = Theme.Text, base = 0.12 },
		{ name = "SearchBtn",  x =  80, size = 20, image = IC_SEARCH,  color = C_WHITE,    base = 0.12 },
	}

	local BIG_TRANSPORT = {
		{ name = "PrevBtn", x = -56, size = 26, image = IC_PREV },
		{ name = "PlayBtn", x =   0, size = 34, image = IC_PLAY },
		{ name = "NextBtn", x =  56, size = 26, image = IC_NEXT },
	}

	local TRACKS = {
		{ title = "Neon Rain",     artist = "Kasumi",          len = 204 },
		{ title = "Afterglow",     artist = "Vaults",          len = 251 },
		{ title = "Low Orbit",     artist = "Sable",           len = 178 },
		{ title = "Paper Streets", artist = "Mono Lake",       len = 227 },
		{ title = "Static Bloom",  artist = "Ivory Coastline", len = 302 },
		{ title = "Halcyon",       artist = "Vera Nine",       len = 195 },
		{ title = "Undertow",      artist = "Kasumi",          len = 276 },
		{ title = "Cold Signal",   artist = "Delta Rooms",     len = 161 },
	}

	local function fmtTime(t)
		if t < 0 then t = 0 end
		local m = math.floor(t / 60)
		local s = math.floor(t % 60)
		return string.format("%d:%02d", m, s)
	end

	local function collectFade(roots)
		local list = {}
		for _, root in ipairs(roots) do
			local kids = root:GetDescendants()
			table.insert(kids, root)
			for _, d in ipairs(kids) do
				if d:IsA("GuiObject") then
					if d.BackgroundTransparency < 1 then
						list[#list + 1] = { inst = d, prop = "BackgroundTransparency", base = d.BackgroundTransparency }
					end
					if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
						list[#list + 1] = { inst = d, prop = "TextTransparency", base = d.TextTransparency }
					end
					if d:IsA("ImageLabel") or d:IsA("ImageButton") then
						list[#list + 1] = { inst = d, prop = "ImageTransparency", base = d.ImageTransparency }
					end
				elseif d:IsA("UIStroke") then
					list[#list + 1] = { inst = d, prop = "Transparency", base = d.Transparency }
				end
			end
		end
		return list
	end

	local function applyFade(list, alpha, info)
		for _, e in ipairs(list) do
			local goal = e.base + (1 - e.base) * alpha
			if info then
				Util.tween(e.inst, info, { [e.prop] = goal })
			else
				e.inst[e.prop] = goal
			end
		end
	end

	local function iconHover(btn, base)
		local held = false
		btn.MouseEnter:Connect(function()
			if not held then Util.tween(btn, Motion.Snap, { ImageTransparency = 0 }) end
		end)
		btn.MouseLeave:Connect(function()
			held = false
			Util.tween(btn, Motion.Snap, { ImageTransparency = base })
		end)
		btn.MouseButton1Down:Connect(function()
			held = true
			Util.tween(btn, Motion.Snap, { ImageTransparency = base + 0.24 })
		end)
		btn.MouseButton1Up:Connect(function()
			held = false
			Util.tween(btn, Motion.Snap, { ImageTransparency = 0 })
		end)
	end

	Novo.Pages.Music = function(parent)
		local page = new("Frame", {
			Name = "Content_Music",
			Position = UDim2.new(0, 0, 0, 0),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			ZIndex = 22,
			Parent = parent,
		})

		local tabFill = new("Frame", {
			Name = "TabFill",
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Theme.Panel,
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			ZIndex = 1,
			Parent = page,
		})
		Util.corner(Theme.R_Panel, tabFill)
		local wall, wash = Util.frostedBacking(tabFill, Theme.R_Panel, Theme.T_Overlay)
		wall.ZIndex = 2
		wash.ZIndex = 3

		local header = new("Frame", {
			Name = "Header",
			Position = UDim2.new(0, 0, 0, 0),
			Size = UDim2.new(1, 0, 0, 58),
			BackgroundTransparency = 1,
			ZIndex = 12,
			Parent = page,
		})

		new("ImageLabel", {
			Position = UDim2.new(0, 18, 0, 19),
			Size = UDim2.new(0, 18, 0, 18),
			BackgroundTransparency = 1,
			Image = Theme.Icon.Music,
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 13,
			Parent = header,
		})

		new("TextLabel", {
			Position = UDim2.new(0, 44, 0, 16),
			Size = UDim2.new(1, -54, 0, 22),
			BackgroundTransparency = 1,
			Text = "Music",
			TextColor3 = Theme.Text,
			TextSize = 17,
			FontFace = Theme.Font.Bold,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
			ZIndex = 13,
			Parent = header,
		})

		local headSub = new("TextLabel", {
			Position = UDim2.new(0, 18, 0, 38),
			Size = UDim2.new(1, -36, 0, 14),
			BackgroundTransparency = 1,
			Text = "Now playing",
			TextColor3 = C_SUBHEAD,
			TextSize = 11,
			FontFace = Theme.Font.Medium,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
			ZIndex = 13,
			Parent = header,
		})

		local tokenSec = new("Frame", {
			Name = "TokenSec",
			Position = UDim2.new(0, 0, 0, 58),
			Size = UDim2.new(1, 0, 1, -58),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 11,
			Parent = page,
		})

		local nowPlaying = new("Frame", {
			Name = "NowPlaying",
			Position = UDim2.new(0, 20, 0, 6),
			Size = UDim2.new(1, -40, 1, -22),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 12,
			Parent = tokenSec,
		})

		local mediaStack = new("Frame", {
			Name = "MediaStack",
			Position = UDim2.new(0.5, 0, 0, 0),
			AnchorPoint = Vector2.new(0.5, 0),
			Size = UDim2.new(0, 136, 0, 203),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 12,
			Parent = nowPlaying,
		})

		local artRing = new("Frame", {
			Name = "ArtRing",
			Position = UDim2.new(0, 0, 0, 0),
			Size = UDim2.new(0, 136, 0, 136),
			BackgroundColor3 = Theme.Raise,
			BackgroundTransparency = 0.35,
			BorderSizePixel = 0,
			ZIndex = 13,
			Parent = mediaStack,
		})
		Util.corner(Theme.R_Card, artRing)
		Util.stroke(Theme.Stroke, 1.5, Theme.T_Stroke, Enum.ApplyStrokeMode.Contextual, artRing)
		local artScale = new("UIScale", { Scale = 1, Parent = artRing })

		new("ImageLabel", {
			Name = "AlbumArt",
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Image = ART_PLACEHOLDER,
			ImageColor3 = C_ARTTINT,
			ImageTransparency = 0.08,
			ScaleType = Enum.ScaleType.Crop,
			ZIndex = 14,
			Parent = artRing,
		}, { Util.new("UICorner", { CornerRadius = Theme.R_Button }) })

		local trackTitle = new("TextLabel", {
			Position = UDim2.new(0, 0, 0, 144),
			Size = UDim2.new(1, 0, 0, 20),
			BackgroundTransparency = 1,
			Text = "No Track",
			TextColor3 = Theme.Text,
			TextSize = 18,
			FontFace = Theme.Font.Bold,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			TextTruncate = Enum.TextTruncate.AtEnd,
			ZIndex = 13,
			Parent = mediaStack,
		})

		local trackSub = new("TextLabel", {
			Position = UDim2.new(0, 0, 0, 166),
			Size = UDim2.new(1, 0, 0, 15),
			BackgroundTransparency = 1,
			Text = "Open library to add songs",
			TextColor3 = Theme.TextFaint,
			TextSize = 12,
			FontFace = Theme.Font.Medium,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			TextTruncate = Enum.TextTruncate.AtEnd,
			ZIndex = 13,
			Parent = mediaStack,
		})

		local elapsedLbl = new("TextLabel", {
			Position = UDim2.new(0, 0, 0, 189),
			Size = UDim2.new(0, 34, 0, 14),
			BackgroundTransparency = 1,
			Text = "0:00",
			TextColor3 = Theme.TextMuted,
			TextSize = 11,
			FontFace = Theme.Font.Medium,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
			ZIndex = 13,
			Parent = mediaStack,
		})

		local totalLbl = new("TextLabel", {
			Position = UDim2.new(1, 0, 0, 189),
			AnchorPoint = Vector2.new(1, 0),
			Size = UDim2.new(0, 34, 0, 14),
			BackgroundTransparency = 1,
			Text = "0:00",
			TextColor3 = Theme.TextMuted,
			TextSize = 11,
			FontFace = Theme.Font.Medium,
			TextXAlignment = Enum.TextXAlignment.Right,
			TextYAlignment = Enum.TextYAlignment.Center,
			ZIndex = 13,
			Parent = mediaStack,
		})

		local progTrack = new("Frame", {
			Name = "ProgTrack",
			Position = UDim2.new(0, 40, 0, 194),
			Size = UDim2.new(1, -80, 0, 4),
			BackgroundColor3 = C_PROG,
			BackgroundTransparency = 0.25,
			BorderSizePixel = 0,
			ZIndex = 13,
			Parent = mediaStack,
		})
		Util.corner(Theme.R_Pill, progTrack)

		local progFill = new("Frame", {
			Name = "Fill",
			Position = UDim2.new(0, 0, 0, 0),
			Size = UDim2.new(0, 0, 1, 0),
			BackgroundColor3 = C_WHITE,
			BackgroundTransparency = 0.05,
			BorderSizePixel = 0,
			ZIndex = 14,
			Parent = progTrack,
		})
		Util.corner(Theme.R_Pill, progFill)

		local seekBtn = new("TextButton", {
			Name = "SeekHit",
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.new(1, 14, 1, 16),
			BackgroundTransparency = 1,
			Text = "",
			TextSize = 8,
			AutoButtonColor = false,
			ZIndex = 15,
			Parent = progTrack,
		})

		local ctrl = {}
		for _, spec in ipairs(TRANSPORT) do
			local btn = new("ImageButton", {
				Name = spec.name,
				Position = UDim2.new(0.5, spec.x, 0, 235),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.new(0, spec.size, 0, spec.size),
				BackgroundTransparency = 1,
				Image = spec.image,
				ImageColor3 = spec.color,
				ImageTransparency = spec.base,
				ScaleType = Enum.ScaleType.Fit,
				AutoButtonColor = false,
				ZIndex = 14,
				Parent = nowPlaying,
			})
			iconHover(btn, spec.base)
			ctrl[spec.name] = btn
		end

		local playWrap = new("Frame", {
			Name = "PlayWrap",
			Position = UDim2.new(0.5, 0, 0, 235),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.new(0, 44, 0, 44),
			BackgroundColor3 = C_PLAYWRAP,
			BackgroundTransparency = 0.05,
			BorderSizePixel = 0,
			ZIndex = 14,
			Parent = nowPlaying,
		})
		Util.corner(Theme.R_Pill, playWrap)
		local playScale = new("UIScale", { Scale = 1, Parent = playWrap })

		local playIcon = new("ImageButton", {
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.new(0, 22, 0, 22),
			BackgroundTransparency = 1,
			Image = IC_PLAY,
			ImageColor3 = Theme.Accent,
			ImageTransparency = 0,
			ScaleType = Enum.ScaleType.Fit,
			AutoButtonColor = false,
			ZIndex = 15,
			Parent = playWrap,
		})

		local pauseGlyph = new("Frame", {
			Name = "PauseGlyph",
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.new(0, 22, 0, 22),
			BackgroundTransparency = 1,
			ZIndex = 16,
			Parent = playWrap,
		})
		local pauseBars = {}
		for i = 1, 2 do
			local bar = new("Frame", {
				Position = UDim2.new(0.5, (i == 1) and -5 or 5, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.new(0, 4, 0, 14),
				BackgroundColor3 = Theme.Accent,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ZIndex = 16,
				Parent = pauseGlyph,
			})
			Util.corner(UDim.new(0, 1), bar)
			pauseBars[i] = bar
		end

		local playerSec = new("Frame", {
			Name = "PlayerSec",
			Position = UDim2.new(0, 0, 0, 0),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Visible = false,
			ZIndex = 11,
			Parent = page,
		})

		new("ImageLabel", {
			Name = "AlbumArt",
			Position = UDim2.new(0.5, 0, 0, 60),
			AnchorPoint = Vector2.new(0.5, 0),
			Size = UDim2.new(0, 154, 0, 154),
			BackgroundColor3 = C_ARTBACK,
			BackgroundTransparency = 0.55,
			BorderSizePixel = 0,
			Image = "",
			ScaleType = Enum.ScaleType.Crop,
			ZIndex = 11,
			Parent = playerSec,
		}, { Util.new("UICorner", { CornerRadius = Theme.R_Button }) })

		new("Frame", {
			Position = UDim2.new(0, 0, 0, 259),
			Size = UDim2.new(1, 0, 0, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Visible = false,
			ZIndex = 12,
			Parent = playerSec,
		})

		new("TextLabel", {
			Position = UDim2.new(0.5, 0, 0, 220),
			AnchorPoint = Vector2.new(0.5, 0),
			Size = UDim2.new(1, -32, 0, 18),
			BackgroundTransparency = 1,
			Text = "No song playing",
			TextColor3 = Theme.Text,
			TextSize = 14,
			FontFace = Theme.Font.Medium,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			TextTruncate = Enum.TextTruncate.AtEnd,
			ZIndex = 12,
			Parent = playerSec,
		})

		new("TextLabel", {
			Position = UDim2.new(0.5, 0, 0, 240),
			AnchorPoint = Vector2.new(0.5, 0),
			Size = UDim2.new(1, -32, 0, 14),
			BackgroundTransparency = 1,
			Text = "Start playing on Spotify...",
			TextColor3 = Theme.TextFaint,
			TextSize = 12,
			FontFace = Theme.Font.Medium,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			TextTruncate = Enum.TextTruncate.AtEnd,
			ZIndex = 12,
			Parent = playerSec,
		})

		local bigSlider = new("Frame", {
			Position = UDim2.new(0.5, 0, 0, 266),
			AnchorPoint = Vector2.new(0.5, 0),
			Size = UDim2.new(1, -44, 0, 10),
			BackgroundColor3 = C_SLIDER,
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			ZIndex = 12,
			Parent = playerSec,
		})
		Util.corner(Theme.R_Pill, bigSlider)

		local bigFill = new("Frame", {
			Position = UDim2.new(0, 0, 0, 0),
			Size = UDim2.new(0, 0, 1, 0),
			BackgroundColor3 = Theme.AccentLight,
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			ZIndex = 13,
			Parent = bigSlider,
		})
		Util.corner(Theme.R_Pill, bigFill)
		new("UIGradient", {
			Color = ColorSequence.new(C_WHITE, C_WHITE),
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0.55),
				NumberSequenceKeypoint.new(1, 0),
			}),
			Rotation = 0,
			Parent = bigFill,
		})

		local bigKnob = new("Frame", {
			Position = UDim2.new(0, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.new(0, 26, 0, 18),
			BackgroundColor3 = C_WHITE,
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			ZIndex = 14,
			Parent = bigSlider,
		})
		Util.corner(Theme.R_Pill, bigKnob)
		local knobScale = new("UIScale", { Scale = 1, Parent = bigKnob })

		local bigSeek = new("TextButton", {
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.new(1, 16, 1, 30),
			BackgroundTransparency = 1,
			Text = "",
			TextSize = 8,
			AutoButtonColor = false,
			ZIndex = 15,
			Parent = bigSlider,
		})
		bigSeek.MouseEnter:Connect(function()
			Util.tween(knobScale, Motion.Snap, { Scale = 1.12 })
		end)
		bigSeek.MouseLeave:Connect(function()
			Util.tween(knobScale, Motion.Snap, { Scale = 1 })
		end)

		new("TextLabel", {
			Position = UDim2.new(0, 16, 0, 282),
			Size = UDim2.new(0, 38, 0, 12),
			BackgroundTransparency = 1,
			Text = "0:00",
			TextColor3 = Theme.TextFaint,
			TextSize = 10,
			FontFace = Theme.Font.Medium,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
			ZIndex = 12,
			Parent = playerSec,
		})

		new("TextLabel", {
			Position = UDim2.new(1, -16, 0, 282),
			AnchorPoint = Vector2.new(1, 0),
			Size = UDim2.new(0, 38, 0, 12),
			BackgroundTransparency = 1,
			Text = "0:00",
			TextColor3 = Theme.TextFaint,
			TextSize = 10,
			FontFace = Theme.Font.Medium,
			TextXAlignment = Enum.TextXAlignment.Right,
			TextYAlignment = Enum.TextYAlignment.Center,
			ZIndex = 12,
			Parent = playerSec,
		})

		for _, spec in ipairs(BIG_TRANSPORT) do
			local btn = new("ImageButton", {
				Name = spec.name,
				Position = UDim2.new(0.5, spec.x, 0, 316),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.new(0, spec.size, 0, spec.size),
				BackgroundTransparency = 1,
				Image = spec.image,
				ImageColor3 = Theme.Text,
				ImageTransparency = 0.15,
				ScaleType = Enum.ScaleType.Fit,
				AutoButtonColor = false,
				ZIndex = 12,
				Parent = playerSec,
			})
			iconHover(btn, 0.15)
		end

		local librarySec = new("Frame", {
			Name = "LibrarySec",
			Position = UDim2.new(0, 0, 0, 58),
			Size = UDim2.new(1, 0, 1, -58),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Visible = false,
			ZIndex = 11,
			Parent = page,
		})

		new("TextButton", {
			Name = "Blocker",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Text = "",
			TextSize = 8,
			AutoButtonColor = false,
			ZIndex = 11,
			Parent = librarySec,
		})

		local searchBox = new("Frame", {
			Name = "Search",
			Position = UDim2.new(0, 10, 0, 4),
			Size = UDim2.new(1, -20, 0, 34),
			BackgroundColor3 = Theme.Raise,
			BackgroundTransparency = 0.55,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			ZIndex = 15,
			Parent = librarySec,
		})
		Util.corner(Theme.R_Nav, searchBox)
		local searchStroke = Util.stroke(Theme.Stroke, 1, 0.6, Enum.ApplyStrokeMode.Border, searchBox)
		local searchShine = Util.surfaceShine(searchBox, 34, Theme.R_Nav, 0.88,
			{
				NumberSequenceKeypoint.new(0, 0.22),
				NumberSequenceKeypoint.new(0.55, 0.78),
				NumberSequenceKeypoint.new(1, 1),
			}, 16)
		searchShine.Fill.Size = UDim2.new(1, 0, 0, 6)

		local searchInput = new("TextBox", {
			Position = UDim2.new(0, 12, 0, 0),
			Size = UDim2.new(1, -24, 1, 0),
			BackgroundTransparency = 1,
			Text = "",
			PlaceholderText = "Search tracks...",
			PlaceholderColor3 = Theme.TextFaint,
			TextColor3 = Theme.Text,
			TextSize = 13,
			FontFace = Theme.Font.Medium,
			TextXAlignment = Enum.TextXAlignment.Left,
			ClearTextOnFocus = false,
			ZIndex = 16,
			Parent = searchBox,
		})
		searchInput.Focused:Connect(function()
			Util.tween(searchStroke, Motion.Snap, { Transparency = 0.25 })
		end)
		searchInput.FocusLost:Connect(function()
			Util.tween(searchStroke, Motion.Snap, { Transparency = 0.6 })
		end)

		local listHolder = new("Frame", {
			Position = UDim2.new(0, 10, 0, 46),
			Size = UDim2.new(1, -20, 1, -56),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 12,
			Parent = librarySec,
		})

		local scroll = new("ScrollingFrame", {
			Name = "Scroll",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			ScrollBarThickness = 0,
			ScrollBarImageColor3 = Theme.Accent,
			ScrollBarImageTransparency = 0.6,
			VerticalScrollBarInset = Enum.ScrollBarInset.None,
			ZIndex = 11,
			Parent = listHolder,
		})
		Util.padding(6, 10, 8, 8, scroll)
		Util.list(Enum.FillDirection.Vertical, 8, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Top, scroll)

		local rows      = {}
		local current   = nil
		local playing   = false
		local elapsed   = 0
		local shuffle   = false
		local libOpen   = false

		local function setProgress(alpha)
			progFill.Size = UDim2.new(math.clamp(alpha, 0, 1), 0, 1, 0)
			bigFill.Size = UDim2.new(math.clamp(alpha, 0, 1), 0, 1, 0)
			bigKnob.Position = UDim2.new(math.clamp(alpha, 0, 1), 0, 0.5, 0)
		end

		local function paintRows()
			for i, row in ipairs(rows) do
				local on = (current == i)
				row.eq.Visible = on
				Util.tween(row.title, Motion.Snap, { TextColor3 = on and Theme.TextBright or Theme.Text })
				Util.tween(row.frame, Motion.Snap, { BackgroundTransparency = on and 0.4 or 0.55 })
				Util.tween(row.stroke, Motion.Snap, { Transparency = on and 0.45 or 1 })
			end
		end

		local function setPlaying(state)
			playing = state
			Util.tween(playIcon, Motion.Snap, { ImageTransparency = state and 1 or 0 })
			for _, bar in ipairs(pauseBars) do
				Util.tween(bar, Motion.Snap, { BackgroundTransparency = state and 0 or 1 })
			end
			headSub.Text = state and "Now playing" or "Paused"
			if not current then
				headSub.Text = "Now playing"
			end
		end

		local function selectTrack(index, autoplay)
			if #TRACKS == 0 then return end
			current = ((index - 1) % #TRACKS) + 1
			local track = TRACKS[current]
			elapsed = 0
			trackTitle.Text = track.title
			trackSub.Text = track.artist
			elapsedLbl.Text = "0:00"
			totalLbl.Text = fmtTime(track.len)
			setProgress(0)
			paintRows()
			artScale.Scale = 0.955
			Util.tween(artScale, Motion.Quick, { Scale = 1 })
			if autoplay ~= false then setPlaying(true) end
		end

		local function buildRow(track, index)
			local frame = new("Frame", {
				Name = "Track" .. index,
				Size = UDim2.new(1, -16, 0, 48),
				BackgroundColor3 = Theme.Raise,
				BackgroundTransparency = 0.55,
				BorderSizePixel = 0,
				ClipsDescendants = true,
				LayoutOrder = index,
				ZIndex = 12,
				Parent = scroll,
			})
			Util.corner(Theme.R_Button, frame)
			local stroke = Util.stroke(Theme.Divider, 1, 1, Enum.ApplyStrokeMode.Contextual, frame)

			local chip = new("Frame", {
				Position = UDim2.new(0, 10, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				Size = UDim2.new(0, 32, 0, 32),
				BackgroundColor3 = C_CHIP,
				BackgroundTransparency = 0.3,
				BorderSizePixel = 0,
				ClipsDescendants = true,
				ZIndex = 13,
				Parent = frame,
			})
			Util.corner(Theme.R_Nav, chip)

			new("TextLabel", {
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				Text = string.sub(track.title, 1, 1),
				TextColor3 = Theme.Accent,
				TextSize = 15,
				FontFace = Theme.Font.Bold,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center,
				ZIndex = 14,
				Parent = chip,
			})

			local title = new("TextLabel", {
				Position = UDim2.new(0, 52, 0, 24),
				AnchorPoint = Vector2.new(0, 1),
				Size = UDim2.new(1, -120, 0, 16),
				BackgroundTransparency = 1,
				Text = track.title,
				TextColor3 = Theme.Text,
				TextSize = 13,
				FontFace = Theme.Font.Medium,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center,
				TextTruncate = Enum.TextTruncate.AtEnd,
				ZIndex = 13,
				Parent = frame,
			})

			new("TextLabel", {
				Position = UDim2.new(0, 52, 0, 25),
				Size = UDim2.new(1, -120, 0, 13),
				BackgroundTransparency = 1,
				Text = track.artist,
				TextColor3 = Theme.TextMuted,
				TextSize = 11,
				FontFace = Theme.Font.Medium,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center,
				TextTruncate = Enum.TextTruncate.AtEnd,
				ZIndex = 13,
				Parent = frame,
			})

			new("TextLabel", {
				Position = UDim2.new(1, -14, 0.5, 0),
				AnchorPoint = Vector2.new(1, 0.5),
				Size = UDim2.new(0, 40, 0, 13),
				BackgroundTransparency = 1,
				Text = fmtTime(track.len),
				TextColor3 = Theme.TextMuted,
				TextSize = 11,
				FontFace = Theme.Font.Medium,
				TextXAlignment = Enum.TextXAlignment.Right,
				TextYAlignment = Enum.TextYAlignment.Center,
				ZIndex = 13,
				Parent = frame,
			})

			local eq = new("Frame", {
				Name = "Eq",
				Position = UDim2.new(1, -62, 0.5, 0),
				AnchorPoint = Vector2.new(1, 0.5),
				Size = UDim2.new(0, 14, 0, 12),
				BackgroundTransparency = 1,
				Visible = false,
				ZIndex = 13,
				Parent = frame,
			})
			local bars = {}
			for i = 1, 3 do
				local bar = new("Frame", {
					Position = UDim2.new(0, (i - 1) * 5, 1, 0),
					AnchorPoint = Vector2.new(0, 1),
					Size = UDim2.new(0, 3, 0, 4 + i * 2),
					BackgroundColor3 = Theme.Accent,
					BackgroundTransparency = 0,
					BorderSizePixel = 0,
					ZIndex = 13,
					Parent = eq,
				})
				Util.corner(UDim.new(0, 1), bar)
				bars[i] = bar
			end

			local hit = new("TextButton", {
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				Text = "",
				TextSize = 8,
				AutoButtonColor = false,
				ZIndex = 15,
				Parent = frame,
			})

			local entry = { frame = frame, stroke = stroke, title = title, eq = eq, bars = bars, data = track }

			hit.MouseEnter:Connect(function()
				if current ~= index then
					Util.tween(frame, Motion.Snap, { BackgroundTransparency = 0.42 })
					Util.tween(stroke, Motion.Snap, { Transparency = 0.45 })
				end
			end)
			hit.MouseLeave:Connect(function()
				if current ~= index then
					Util.tween(frame, Motion.Snap, { BackgroundTransparency = 0.55 })
					Util.tween(stroke, Motion.Snap, { Transparency = 1 })
				end
			end)
			hit.MouseButton1Down:Connect(function()
				Util.tween(frame, Motion.Snap, { BackgroundTransparency = 0.3 })
			end)
			hit.MouseButton1Up:Connect(function()
				Util.tween(frame, Motion.Snap, { BackgroundTransparency = current == index and 0.4 or 0.42 })
			end)

			rows[index] = entry
			return entry, hit
		end

		local rowHits = {}
		for i, track in ipairs(TRACKS) do
			local _, hit = buildRow(track, i)
			rowHits[i] = hit
		end

		local headFade = collectFade({ header })
		local tokFade  = collectFade({ tokenSec })
		local libFade  = collectFade({ librarySec })

		local function setLibrary(open)
			if libOpen == open then return end
			libOpen = open
			if open then
				librarySec.Visible = true
				librarySec.Position = UDim2.new(0, 0, 0, 70)
				applyFade(libFade, 1, nil)
				Util.tween(librarySec, SLIDE, { Position = UDim2.new(0, 0, 0, 58) })
				applyFade(libFade, 0, FADE)
				applyFade(tokFade, 1, FADE)
				Util.tween(tokenSec, SLIDE, { Position = UDim2.new(0, 0, 0, 48) })
				Util.tween(ctrl.SearchBtn, Motion.Snap, { ImageColor3 = Theme.AccentLight })
				headSub.Text = "Library"
				task.delay(0.22, function()
					if libOpen then tokenSec.Visible = false end
				end)
			else
				tokenSec.Visible = true
				tokenSec.Position = UDim2.new(0, 0, 0, 66)
				Util.tween(tokenSec, SLIDE, { Position = UDim2.new(0, 0, 0, 58) })
				applyFade(tokFade, 0, FADE)
				applyFade(libFade, 1, FADE)
				Util.tween(librarySec, SLIDE, { Position = UDim2.new(0, 0, 0, 70) })
				Util.tween(ctrl.SearchBtn, Motion.Snap, { ImageColor3 = C_WHITE })
				headSub.Text = (current and playing) and "Now playing" or (current and "Paused" or "Now playing")
				task.delay(0.22, function()
					if not libOpen then librarySec.Visible = false end
				end)
			end
		end

		for i, hit in ipairs(rowHits) do
			hit.MouseButton1Click:Connect(function()
				selectTrack(i, true)
				setLibrary(false)
			end)
		end

		searchInput:GetPropertyChangedSignal("Text"):Connect(function()
			local q = string.lower(searchInput.Text)
			for _, row in ipairs(rows) do
				local hay = string.lower(row.data.title .. " " .. row.data.artist)
				row.frame.Visible = (q == "" or string.find(hay, q, 1, true) ~= nil)
			end
		end)

		ctrl.SearchBtn.MouseButton1Click:Connect(function()
			setLibrary(not libOpen)
		end)

		ctrl.ShuffleBtn.MouseButton1Click:Connect(function()
			shuffle = not shuffle
			Util.tween(ctrl.ShuffleBtn, Motion.Snap, {
				ImageColor3 = shuffle and Theme.AccentLight or C_WHITE,
				ImageTransparency = shuffle and 0 or 0.12,
			})
		end)

		ctrl.PrevBtn.MouseButton1Click:Connect(function()
			if not current then
				selectTrack(#TRACKS, true)
			elseif elapsed > 3 then
				elapsed = 0
				setProgress(0)
				elapsedLbl.Text = "0:00"
			else
				selectTrack(current - 1, true)
			end
		end)

		ctrl.NextBtn.MouseButton1Click:Connect(function()
			if shuffle and #TRACKS > 1 then
				local pick = current
				while pick == current do
					pick = math.random(1, #TRACKS)
				end
				selectTrack(pick, true)
			else
				selectTrack((current or 0) + 1, true)
			end
		end)

		playIcon.MouseEnter:Connect(function()
			Util.tween(playWrap, Motion.Snap, { BackgroundTransparency = 0 })
			Util.tween(playScale, Motion.Snap, { Scale = 1.06 })
		end)
		playIcon.MouseLeave:Connect(function()
			Util.tween(playWrap, Motion.Snap, { BackgroundTransparency = 0.05 })
			Util.tween(playScale, Motion.Snap, { Scale = 1 })
		end)
		playIcon.MouseButton1Down:Connect(function()
			Util.tween(playScale, Motion.Snap, { Scale = 0.94 })
		end)
		playIcon.MouseButton1Up:Connect(function()
			Util.tween(playScale, Motion.Snap, { Scale = 1.06 })
		end)
		playIcon.MouseButton1Click:Connect(function()
			if not current then
				selectTrack(1, true)
			else
				setPlaying(not playing)
			end
		end)

		seekBtn.MouseEnter:Connect(function()
			Util.tween(progTrack, Motion.Snap, { BackgroundTransparency = 0.1 })
		end)
		seekBtn.MouseLeave:Connect(function()
			Util.tween(progTrack, Motion.Snap, { BackgroundTransparency = 0.25 })
		end)
		seekBtn.InputBegan:Connect(function(input)
			if input.UserInputType ~= Enum.UserInputType.MouseButton1
				and input.UserInputType ~= Enum.UserInputType.Touch then return end
			if not current then return end
			local width = math.max(progTrack.AbsoluteSize.X, 1)
			local alpha = math.clamp((input.Position.X - progTrack.AbsolutePosition.X) / width, 0, 1)
			elapsed = alpha * TRACKS[current].len
			elapsedLbl.Text = fmtTime(elapsed)
			setProgress(alpha)
		end)

		local function playIntro()
			applyFade(headFade, 1, nil)
			applyFade(tokFade, 1, nil)
			mediaStack.Position = UDim2.new(0.5, 0, 0, 12)
			applyFade(headFade, 0, FADE)
			applyFade(tokFade, 0, FADE)
			Util.tween(mediaStack, SLIDE, { Position = UDim2.new(0.5, 0, 0, 0) })
		end

		page:GetPropertyChangedSignal("Visible"):Connect(function()
			if page.Visible then
				if libOpen then setLibrary(false) end
				playIntro()
			end
		end)

		local conn
		conn = RunService.Heartbeat:Connect(function(dt)
			if not page.Visible then return end
			local row = current and rows[current] or nil
			if playing and current then
				local track = TRACKS[current]
				elapsed = elapsed + dt
				if elapsed >= track.len then
					if shuffle and #TRACKS > 1 then
						local pick = current
						while pick == current do
							pick = math.random(1, #TRACKS)
						end
						selectTrack(pick, true)
					else
						selectTrack(current + 1, true)
					end
					return
				end
				elapsedLbl.Text = fmtTime(elapsed)
				setProgress(elapsed / track.len)
				artScale.Scale = 1 + math.sin(os.clock() * 1.6) * 0.006
				if row then
					for i, bar in ipairs(row.bars) do
						local h = 4 + (math.sin(os.clock() * (5 + i * 1.7) + i) * 0.5 + 0.5) * 8
						bar.Size = UDim2.new(0, 3, 0, h)
					end
				end
			elseif row then
				for i, bar in ipairs(row.bars) do
					bar.Size = UDim2.new(0, 3, 0, 4 + i)
				end
			end
		end)
		page.Destroying:Connect(function()
			if conn then conn:Disconnect() end
		end)

		playIntro()
		return page
	end
end
end

do
local Util  = Novo.Util
local Theme = Novo.Theme
local new   = Util.new

local SLIDE = TweenInfo.new(0.18, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
local FADE  = TweenInfo.new(0.20, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local SNAP  = Util.Motion.Snap

local ICON_RUN   = "rbxassetid://107167710829183"
local ICON_CLEAR = "rbxassetid://116075495129071"

local WHITE = Color3.fromRGB(255, 255, 255)

local CARD_FILL  = Color3.fromRGB(26, 26, 30)
local THUMB_FILL = Color3.fromRGB(24, 24, 30)
local CARD_SUB   = Color3.fromRGB(180, 182, 200)
local KEY_GOLD   = Color3.fromRGB(180, 130, 30)
local HEAD_SUB   = Color3.fromRGB(180, 180, 190)

local CARD_BG_REST   = 0.55
local CARD_BG_HOVER  = 0.35
local CARD_BG_PRESS  = 0.22
local CARD_STROKE_T  = 0.60
local CARD_STROKE_H  = 0.30
local SCRIM_REST     = 0
local SCRIM_HOVER    = 0.12

local BAR_BG_REST    = 0.55
local BAR_BG_HOVER   = 0.46
local BAR_STROKE_T   = 0.60
local BAR_STROKE_H   = 0.45
local BAR_STROKE_F   = 0.30

local THUMBS = {
	"rbxassetid://8992291444",
	"rbxassetid://8992290931",
	"rbxassetid://8992290714",
	"rbxassetid://8992290314",
	"rbxassetid://8992291779",
	"rbxassetid://8992292381",
	"rbxassetid://8992292705",
}

local CARDS = {
	{ title = "Venven Scripts",                             game = "" },
	{ title = "Adopt Me Fake Trade Visual Script +200 Hub", game = "[🏰] Adopt Me!" },
	{ title = "MURDER MYSTERY 1",                           game = "Murder Mystery 2" },
	{ title = "omen",                                       game = "", key = true },
	{ title = "adopt me",                                   game = "[🏰] Adopt Me!" },
	{ title = "Kioto's Universal Hub (premium / Paid V1)",  game = "", key = true },
	{ title = "the omen",                                   game = "", key = true },
	{ title = "MM2 FREEZE TRADE SCRIPT",                    game = "Murder Mystery 2" },
	{ title = "OverdriveH",                                 game = "Murder Mystery 2" },
	{ title = "Hair hub",                                   game = "" },
	{ title = "Hair hub",                                   game = "", key = true },
	{ title = "Rivals",                                     game = "[😾] RIVALS" },
	{ title = "❄️ MM2 Trade Freeze",                         game = "Murder Mystery 2" },
	{ title = "Evade Hub",                                  game = "Evade ", key = true },
	{ title = "💚 MM2 AutoFarm Hub",                         game = "Murder Mystery 2" },
	{ title = "❄️ MM2 Freeze Trades",                        game = "Murder Mystery 2" },
	{ title = "⚡ MM2 AutoFarm + AutoKill",                   game = "Murder Mystery 2" },
	{ title = "[SUMMER🏖️] 💕 MM2 AUTOFARM 💕",                 game = "Murder Mystery 2" },
	{ title = "AIMBOT MM2 2026",                            game = "Murder Mystery 2" },
	{ title = "MM2 TRADE FREEZER [ 2026 WORK !! ] NO KEY",  game = "Murder Mystery 2" },
}

local function mark(sink, inst, prop)
	sink[#sink + 1] = { inst = inst, prop = prop, rest = inst[prop] }
end

local function hide(sink)
	for _, item in ipairs(sink) do
		item.inst[item.prop] = 1
	end
end

local function show(sink, delay)
	if delay and delay > 0 then
		task.delay(delay, function()
			for _, item in ipairs(sink) do
				Util.tween(item.inst, FADE, { [item.prop] = item.rest })
			end
		end)
	else
		for _, item in ipairs(sink) do
			Util.tween(item.inst, FADE, { [item.prop] = item.rest })
		end
	end
end

local function buildCard(scroll, index, data, sink)
	local tile = new("TextButton", {
		Name = "Tile_" .. index,
		BackgroundColor3 = CARD_FILL,
		BackgroundTransparency = CARD_BG_REST,
		BorderSizePixel = 0,
		ZIndex = 12,
		LayoutOrder = index,
		Text = "",
		TextSize = 8,
		AutoButtonColor = false,
		Parent = scroll,
	})
	Util.corner(Theme.R_Button, tile)

	local stroke = Util.stroke(Theme.Stroke, 1, CARD_STROKE_T, Enum.ApplyStrokeMode.Contextual, tile)

	local thumb = new("ImageLabel", {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = THUMB_FILL,
		BackgroundTransparency = 0.55,
		Image = THUMBS[(index - 1) % #THUMBS + 1],
		ImageColor3 = WHITE,
		ImageTransparency = 0,
		ScaleType = Enum.ScaleType.Crop,
		ZIndex = 13,
		Parent = tile,
	})
	Util.corner(Theme.R_Button, thumb)

	local scrim = new("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Theme.PanelDeep,
		BackgroundTransparency = SCRIM_REST,
		BorderSizePixel = 0,
		ZIndex = 14,
		Parent = tile,
	})
	Util.corner(Theme.R_Button, scrim)
	new("UIGradient", {
		Color = ColorSequence.new(WHITE),
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.92),
			NumberSequenceKeypoint.new(0.42, 0.6),
			NumberSequenceKeypoint.new(1, 0),
		}),
		Rotation = 90,
		Parent = scrim,
	})

	if data.key then
		local badge = new("Frame", {
			Name = "KeyBadge",
			Position = UDim2.fromOffset(5, 5),
			Size = UDim2.fromOffset(32, 14),
			BackgroundColor3 = KEY_GOLD,
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			ZIndex = 16,
			Parent = tile,
		})
		Util.corner(UDim.new(0, 4), badge)

		local badgeText = new("TextLabel", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ZIndex = 17,
			Text = "KEY",
			TextColor3 = Theme.TextBright,
			TextSize = 7,
			TextTransparency = 0,
			TextWrapped = false,
			TextScaled = false,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			TextStrokeTransparency = 1,
			RichText = false,
			LineHeight = 1,
			FontFace = Theme.Font.Bold,
			TextTruncate = Enum.TextTruncate.None,
			Parent = badge,
		})
		mark(sink, badge, "BackgroundTransparency")
		mark(sink, badgeText, "TextTransparency")
	end

	local title = new("TextLabel", {
		Position = UDim2.new(0, 8, 1, -22),
		Size = UDim2.new(1, -16, 0, 17),
		AnchorPoint = Vector2.new(0, 1),
		BackgroundTransparency = 1,
		ZIndex = 16,
		Text = data.title,
		TextColor3 = Theme.TextBright,
		TextSize = 13,
		TextTransparency = 0,
		TextWrapped = false,
		TextScaled = false,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		RichText = false,
		LineHeight = 1,
		FontFace = Theme.Font.Bold,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = tile,
	})

	local sub = new("TextLabel", {
		Position = UDim2.new(0, 8, 1, -6),
		Size = UDim2.new(1, -16, 0, 14),
		AnchorPoint = Vector2.new(0, 1),
		BackgroundTransparency = 1,
		ZIndex = 16,
		Text = data.game,
		TextColor3 = CARD_SUB,
		TextSize = 11,
		TextTransparency = 0,
		TextWrapped = false,
		TextScaled = false,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		RichText = false,
		LineHeight = 1,
		FontFace = Theme.Font.Medium,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = tile,
	})

	mark(sink, tile, "BackgroundTransparency")
	mark(sink, stroke, "Transparency")
	mark(sink, thumb, "ImageTransparency")
	mark(sink, scrim, "BackgroundTransparency")
	mark(sink, title, "TextTransparency")
	mark(sink, sub, "TextTransparency")

	local held = false
	local function paint(bg, strokeT, scrimT)
		Util.tween(tile, SNAP, { BackgroundTransparency = bg })
		Util.tween(stroke, SNAP, { Transparency = strokeT })
		Util.tween(scrim, SNAP, { BackgroundTransparency = scrimT })
	end

	tile.MouseEnter:Connect(function()
		if held then return end
		paint(CARD_BG_HOVER, CARD_STROKE_H, SCRIM_HOVER)
	end)
	tile.MouseLeave:Connect(function()
		held = false
		paint(CARD_BG_REST, CARD_STROKE_T, SCRIM_REST)
	end)
	tile.MouseButton1Down:Connect(function()
		held = true
		paint(CARD_BG_PRESS, CARD_STROKE_H, SCRIM_REST)
	end)
	tile.MouseButton1Up:Connect(function()
		held = false
		paint(CARD_BG_HOVER, CARD_STROKE_H, SCRIM_HOVER)
	end)

	return tile
end

local function iconButton(parent, xOffset, image, rest, sink)
	local btn = new("TextButton", {
		Position = UDim2.new(1, xOffset, 0, 8),
		Size = UDim2.fromOffset(18, 18),
		AnchorPoint = Vector2.new(1, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 18,
		Text = "",
		TextSize = 8,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		RichText = false,
		AutoButtonColor = false,
		Parent = parent,
	})

	local icon = new("ImageLabel", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = image,
		ImageColor3 = WHITE,
		ImageTransparency = rest,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 19,
		Parent = btn,
	})

	mark(sink, icon, "ImageTransparency")

	local hover = rest > 0.3 and 0.2 or 0.22
	local press = rest > 0.3 and 0.4 or 0.45

	btn.MouseEnter:Connect(function()
		Util.tween(icon, SNAP, { ImageTransparency = hover })
	end)
	btn.MouseLeave:Connect(function()
		Util.tween(icon, SNAP, { ImageTransparency = rest })
	end)
	btn.MouseButton1Down:Connect(function()
		Util.tween(icon, SNAP, { ImageTransparency = press })
	end)
	btn.MouseButton1Up:Connect(function()
		Util.tween(icon, SNAP, { ImageTransparency = hover })
	end)

	return btn, icon
end

Novo.Pages.Scripts = function(parent)
	local page = new("Frame", {
		Name = "Content_Scripts",
		Position = UDim2.fromOffset(0, 0),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 22,
		Parent = parent,
	})

	local tabFill = new("Frame", {
		Name = "TabFill",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 1,
		Parent = page,
	})
	Util.corner(Theme.R_Panel, tabFill)

	local wall, wash = Util.frostedBacking(tabFill, Theme.R_Panel, Theme.T_Overlay)
	wall.ZIndex = 2
	wash.ZIndex = 3

	local header = new("Frame", {
		Name = "Header",
		Size = UDim2.new(1, 0, 0, 54),
		BackgroundTransparency = 1,
		ZIndex = 12,
		Parent = page,
	})

	local headIcon = new("ImageLabel", {
		Position = UDim2.fromOffset(14, 17),
		Size = UDim2.fromOffset(18, 18),
		BackgroundTransparency = 1,
		Image = Theme.Icon.Scripts,
		ImageColor3 = WHITE,
		ImageTransparency = 0,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 13,
		Parent = header,
	})

	local headTitle = new("TextLabel", {
		Position = UDim2.fromOffset(40, 14),
		Size = UDim2.new(1, -50, 0, 22),
		BackgroundTransparency = 1,
		ZIndex = 13,
		Text = "Scripts",
		TextColor3 = Theme.Text,
		TextSize = 17,
		TextTransparency = 0,
		TextWrapped = false,
		TextScaled = false,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		RichText = false,
		LineHeight = 1,
		FontFace = Theme.Font.Bold,
		TextTruncate = Enum.TextTruncate.None,
		Parent = header,
	})

	local headSub = new("TextLabel", {
		Position = UDim2.fromOffset(14, 36),
		Size = UDim2.new(1, -24, 0, 14),
		BackgroundTransparency = 1,
		ZIndex = 13,
		Text = "Search scripts",
		TextColor3 = HEAD_SUB,
		TextSize = 11,
		TextTransparency = 0,
		TextWrapped = false,
		TextScaled = false,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		RichText = false,
		LineHeight = 1,
		FontFace = Theme.Font.Medium,
		TextTruncate = Enum.TextTruncate.None,
		Parent = header,
	})

	local search = new("Frame", {
		Name = "SearchBar",
		Position = UDim2.fromOffset(10, 62),
		Size = UDim2.new(1, -20, 0, 34),
		BackgroundColor3 = Theme.Raise,
		BackgroundTransparency = BAR_BG_REST,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 15,
		Parent = page,
	})
	Util.corner(Theme.R_Nav, search)

	local searchStroke = Util.stroke(Theme.Stroke, 1, BAR_STROKE_T, Enum.ApplyStrokeMode.Border, search)

	local barShine = Util.surfaceShine(search, 34, Theme.R_Nav, 0.88,
		{
			NumberSequenceKeypoint.new(0, 0.22),
			NumberSequenceKeypoint.new(0.55, 0.78),
			NumberSequenceKeypoint.new(1, 1),
		}, 16)
	barShine.Size = UDim2.fromScale(1, 1)
	barShine.Fill.Size = UDim2.new(1, 0, 0, 6)

	local divider = new("Frame", {
		Name = "Divider",
		Position = UDim2.new(1, -62, 0, 8),
		Size = UDim2.fromOffset(1, 18),
		AnchorPoint = Vector2.new(1, 0),
		BackgroundColor3 = Theme.Stroke,
		BackgroundTransparency = 0.3,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 17,
		Parent = search,
	})

	local iconSink = {}
	local runBtn = iconButton(search, -8, ICON_RUN, 0, iconSink)
	local clearBtn = iconButton(search, -34, ICON_CLEAR, 0.6, iconSink)

	local box = new("TextBox", {
		Position = UDim2.fromOffset(12, 0),
		Size = UDim2.new(1, -68, 1, 0),
		BackgroundTransparency = 1,
		ZIndex = 16,
		Text = "",
		PlaceholderText = "Search scripts...",
		PlaceholderColor3 = Theme.TextFaint,
		TextColor3 = Theme.Text,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		FontFace = Theme.Font.Medium,
		ClearTextOnFocus = false,
		MultiLine = false,
		Parent = search,
	})

	local focused = false
	search.MouseEnter:Connect(function()
		if focused then return end
		Util.tween(search, SNAP, { BackgroundTransparency = BAR_BG_HOVER })
		Util.tween(searchStroke, SNAP, { Transparency = BAR_STROKE_H })
	end)
	search.MouseLeave:Connect(function()
		if focused then return end
		Util.tween(search, SNAP, { BackgroundTransparency = BAR_BG_REST })
		Util.tween(searchStroke, SNAP, { Transparency = BAR_STROKE_T })
	end)
	box.Focused:Connect(function()
		focused = true
		Util.tween(search, SNAP, { BackgroundTransparency = BAR_BG_HOVER })
		Util.tween(searchStroke, SNAP, { Transparency = BAR_STROKE_F })
	end)
	box.FocusLost:Connect(function()
		focused = false
		Util.tween(search, SNAP, { BackgroundTransparency = BAR_BG_REST })
		Util.tween(searchStroke, SNAP, { Transparency = BAR_STROKE_T })
	end)

	box:GetPropertyChangedSignal("Text"):Connect(function()
		divider.Visible = box.Text ~= ""
	end)

	local caption = new("TextLabel", {
		Name = "Caption",
		Position = UDim2.fromOffset(18, 102),
		Size = UDim2.new(1, -36, 0, 16),
		BackgroundTransparency = 1,
		ZIndex = 13,
		Text = "Recent uploads · Powered by RoScripts.io",
		TextColor3 = Theme.TextMuted,
		TextSize = 11,
		TextTransparency = 0,
		TextWrapped = false,
		TextScaled = false,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		RichText = false,
		LineHeight = 1,
		FontFace = Theme.Font.Medium,
		TextTruncate = Enum.TextTruncate.None,
		Parent = page,
	})

	local holder = new("Frame", {
		Name = "GridHolder",
		Position = UDim2.fromOffset(10, 122),
		Size = UDim2.new(1, -20, 1, -130),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 12,
		Parent = page,
	})

	local scroll = new("ScrollingFrame", {
		Name = "ScriptScroll",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 11,
		CanvasSize = UDim2.fromOffset(0, 0),
		ScrollBarThickness = 0,
		ScrollBarImageColor3 = WHITE,
		ScrollBarImageTransparency = 1,
		ScrollingDirection = Enum.ScrollingDirection.XY,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		VerticalScrollBarInset = Enum.ScrollBarInset.None,
		Parent = holder,
	})

	new("UIGridLayout", {
		CellSize = UDim2.new(0.5, -5, 0, 116),
		CellPadding = UDim2.new(0, 6, 0, 8),
		FillDirection = Enum.FillDirection.Horizontal,
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		VerticalAlignment = Enum.VerticalAlignment.Top,
		StartCorner = Enum.StartCorner.TopLeft,
		FillDirectionMaxCells = 0,
		Parent = scroll,
	})
	Util.padding(4, 10, 2, 2, scroll)

	local rowSinks = {}
	local function renderCards(list)
		for _, child in ipairs(scroll:GetChildren()) do
			if child:IsA("GuiObject") then child:Destroy() end
		end
		table.clear(rowSinks)

		for i, entry in ipairs(list) do
			local row = math.ceil(i / 2)
			local sink = rowSinks[row]
			if not sink then
				sink = {}
				rowSinks[row] = sink
			end
			local tile = buildCard(scroll, i, entry, sink)
			if entry.source and tile then
				tile.MouseButton1Click:Connect(function()
					if Novo.Features then
						task.spawn(Novo.Features.Scripts.run, entry)
					end
				end)
			end
		end
	end

	renderCards(CARDS)

	local searching = false
	local searchToken = 0
	local results = {}

	local function runSearch(query)
		if not Novo.Features then return end
		searchToken += 1
		local token = searchToken
		searching = true
		task.spawn(function()
			local found = Novo.Features.Scripts.search(query, 20)
			if token ~= searchToken then return end
			searching = false
			results = found
			if #found == 0 then
				Novo.notify("Scripts", "Nothing found for that search.")
				return
			end
			renderCards(found)
		end)
	end

	box.FocusLost:Connect(function(enter)
		if enter then
			runSearch(box.Text)
		end
	end)

	runBtn.MouseButton1Click:Connect(function()
		if box.Text ~= "" then
			runSearch(box.Text)
		elseif results[1] then
			task.spawn(Novo.Features.Scripts.run, results[1])
		else
			runSearch("")
		end
	end)

	clearBtn.MouseButton1Click:Connect(function()
		box.Text = ""
		runSearch("")
	end)

	task.spawn(function()
		task.wait(0.8)
		runSearch("")
	end)

	local chromeSink = {}
	mark(chromeSink, headIcon, "ImageTransparency")
	mark(chromeSink, headTitle, "TextTransparency")
	mark(chromeSink, headSub, "TextTransparency")

	local barSink = { table.unpack(iconSink) }
	mark(barSink, search, "BackgroundTransparency")
	mark(barSink, searchStroke, "Transparency")
	mark(barSink, barShine, "GroupTransparency")
	mark(barSink, box, "TextTransparency")

	local captionSink = {}
	mark(captionSink, caption, "TextTransparency")

	local playing = false
	local function playIn()
		if playing then return end
		playing = true

		hide(chromeSink)
		hide(barSink)
		hide(captionSink)
		for _, sink in ipairs(rowSinks) do
			hide(sink)
		end

		search.Position = UDim2.fromOffset(10, 70)
		caption.Position = UDim2.fromOffset(18, 110)
		scroll.CanvasPosition = Vector2.new(0, 0)

		Util.tween(search, SLIDE, { Position = UDim2.fromOffset(10, 62) })
		Util.tween(caption, SLIDE, { Position = UDim2.fromOffset(18, 102) })

		show(chromeSink, 0)
		show(barSink, 0.04)
		show(captionSink, 0.08)
		for row, sink in ipairs(rowSinks) do
			show(sink, 0.10 + math.min(row, 8) * 0.035)
		end

		task.delay(0.6, function()
			playing = false
		end)
	end

	page:GetPropertyChangedSignal("Visible"):Connect(function()
		if page.Visible then
			playIn()
		end
	end)

	playIn()
	return page
end
end

do
local Util  = Novo.Util
local Theme = Novo.Theme
local new   = Util.new

local HEADER = {
	icon     = Theme.Icon.Settings,
	title    = "Settings",
	subtitle = "Configure Novoline",
}

local ROW_H = 36

local SWITCH_ON = {
	thumbX   = 33,
	gradient = ColorSequence.new(Color3.fromRGB(91, 160, 245), Color3.fromRGB(29, 67, 147)),
	glow     = 0.28,
}
local SWITCH_OFF = {
	thumbX   = 15,
	gradient = ColorSequence.new(Color3.fromRGB(40, 40, 44), Theme.Panel),
	glow     = 0.94,
}

local ROW_REST  = 1
local ROW_HOVER = 0.965
local ROW_PRESS = 0.94

local SLIDE = TweenInfo.new(0.18, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
local FADE  = TweenInfo.new(0.20, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

local function slideAfter(index)
	return TweenInfo.new(0.18, Enum.EasingStyle.Circular, Enum.EasingDirection.Out,
		0, false, (index - 1) * 0.02)
end

local GENERAL = {
	{ kind = "input", label = "Prefix", labelScale = 0.55, labelPad = -18,
		boxSize = UDim2.fromOffset(52, 24), boxTransparency = 0.55, boxInset = 0,
		text = ";", placeholder = ";", boxTextSize = 13,
		boxAlign = Enum.TextXAlignment.Center, clearOnFocus = true, divider = true },
	{ kind = "switch", label = "Notifications", on = true },
	{ kind = "switch", label = "Welcome Message", on = true },
	{ kind = "switch", label = "Auto-Exec on Teleport", on = true },
	{ kind = "switch", label = "Unlock FPS", on = false },
	{ kind = "switch", label = "Cap FPS in Background", on = false },
	{ kind = "switch", label = "Keep music after closing player", on = false },
	{ kind = "value", label = "Boot Sound", value = "Stalkie", divider = true, dividerFlush = true },
	{ kind = "value", label = "Theme", value = "Fluent" },
}

local KEYBINDS = {
	{ label = "Toggle Sidebar", key = "K" },
	{ label = "Command Bar", key = "F6" },
}

local SPOOFER = {
	{ kind = "input", label = "Display", labelScale = 0.4, labelPad = -20,
		boxSize = UDim2.fromOffset(140, 24), boxTransparency = 0.55, boxInset = 4,
		text = "", placeholder = "display name\u{2026}", boxTextSize = 12,
		boxAlign = Enum.TextXAlignment.Left, clearOnFocus = false },
	{ kind = "input", label = "User", labelScale = 0.4, labelPad = -20,
		boxSize = UDim2.fromOffset(140, 24), boxTransparency = 0.55, boxInset = 4,
		text = "", placeholder = "username\u{2026}", boxTextSize = 12,
		boxAlign = Enum.TextXAlignment.Left, clearOnFocus = false },
	{ kind = "switch", label = "Verified", on = false },
}

local NAMETAGS = {
	{ kind = "switch", label = "Hide Nametags", on = false },
}

local AK_ADMIN = {
	{ kind = "value", label = "Copy AK Emotes", value = "copy", divider = true, dividerFlush = true },
	{ kind = "value", label = "Copy M7 Emotes", value = "copy", divider = true, dividerFlush = true },
	{ kind = "value", label = "Copy Slate/Onyx Emotes", value = "copy" },
}

local CHAT_SAFETY = {
	{ kind = "switch", label = "Anti-Spam Bot", on = true },
	{ kind = "switch", label = "Spam Notifications", on = true },
	{ kind = "switch", label = "Spatial Shield", on = false },
}

local WEBHOOK_URL = "https://discord.com/api/webhooks/\u{2026}"

local WEBHOOK = {
	{ kind = "switch", label = "Log Chat Messages", on = false },
	{ kind = "input", label = "Chat URL", labelScale = 0.35, labelPad = 0, labelTextSize = 12,
		boxSize = UDim2.new(0.62, 0, 0, 24), boxTransparency = 0.55, boxInset = 4,
		text = "", placeholder = WEBHOOK_URL, boxTextSize = 11,
		boxAlign = Enum.TextXAlignment.Left, clearOnFocus = false },
	{ kind = "rule", y = 72 },
	{ kind = "switch", label = "Log Player Join/Leave", on = false },
	{ kind = "input", label = "Join URL", labelScale = 0.35, labelPad = 0, labelTextSize = 12,
		boxSize = UDim2.new(0.62, 0, 0, 24), boxTransparency = 0.55, boxInset = 4,
		text = "", placeholder = WEBHOOK_URL, boxTextSize = 11,
		boxAlign = Enum.TextXAlignment.Left, clearOnFocus = false },
	{ kind = "rule", y = 144 },
}

local function accentGlow(parent, transparency)
	local ok, shadow = pcall(Instance.new, "UIShadow")
	if not ok or not shadow then return nil end
	shadow.Color = Theme.Accent
	shadow.Transparency = transparency
	pcall(function() shadow.Offset = UDim2.fromOffset(0, 0) end)
	pcall(function() shadow.Spread = UDim2.fromOffset(0, 0) end)
	shadow.Enabled = true
	shadow.Parent = parent
	return shadow
end

local function card(parent, y, height, clips)
	local frame = new("Frame", {
		Position = UDim2.new(0, 10, 0, y),
		Size = UDim2.new(1, -20, 0, height),
		BackgroundColor3 = Theme.Raise,
		BackgroundTransparency = 0.35,
		BorderSizePixel = 0,
		ClipsDescendants = clips,
		ZIndex = 12,
		Parent = parent,
	})
	Util.corner(Theme.R_Nav, frame)
	Util.stroke(Theme.Stroke, 1, 0.55, Enum.ApplyStrokeMode.Border, frame)
	return frame
end

local function caption(parent, y, height, text, color, textSize)
	return new("TextLabel", {
		Position = UDim2.new(0, 20, 0, y),
		Size = UDim2.new(1, -40, 0, height),
		BackgroundTransparency = 1,
		Text = text,
		TextColor3 = color,
		TextSize = textSize,
		TextTransparency = 0,
		TextWrapped = false,
		TextScaled = false,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		RichText = false,
		LineHeight = 1,
		FontFace = Theme.Font.Medium,
		TextTruncate = Enum.TextTruncate.None,
		ZIndex = 12,
		Parent = parent,
	})
end

local function rowFrame(parent, y)
	return new("Frame", {
		Position = UDim2.new(0, 0, 0, y),
		Size = UDim2.new(1, 0, 0, ROW_H),
		BackgroundTransparency = ROW_REST,
		ZIndex = 13,
		Parent = parent,
	})
end

local function rowLabel(parent, text, scale, pad, textSize, truncate)
	return new("TextLabel", {
		Position = UDim2.new(0, 14, 0.5, 0),
		Size = UDim2.new(scale, pad, 1, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Text = text,
		TextColor3 = Theme.Text,
		TextSize = textSize,
		TextTransparency = 0,
		TextWrapped = false,
		TextScaled = false,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		RichText = false,
		LineHeight = 1,
		FontFace = Theme.Font.Medium,
		TextTruncate = truncate,
		ZIndex = 14,
		Parent = parent,
	})
end

local function rowDivider(parent, flush)
	return new("Frame", {
		Position = UDim2.new(0, 14, 1, flush and 0 or -1),
		Size = UDim2.new(1, -28, 0, 1),
		AnchorPoint = Vector2.new(0, 1),
		BackgroundColor3 = Theme.Divider,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 14,
		Parent = parent,
	})
end

local function hitButton(parent, zindex)
	return new("TextButton", {
		Position = UDim2.fromOffset(0, 0),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = "",
		TextSize = 8,
		TextTransparency = 0,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		RichText = false,
		AutoButtonColor = true,
		ZIndex = zindex,
		Parent = parent,
	})
end

local function bindRow(button, row, onClick)
	local inside, held = false, false
	local function refresh()
		local goal = ROW_REST
		if held then
			goal = ROW_PRESS
		elseif inside then
			goal = ROW_HOVER
		end
		Util.tween(row, Util.Motion.Snap, { BackgroundTransparency = goal })
	end
	button.MouseEnter:Connect(function()
		inside = true
		refresh()
	end)
	button.MouseLeave:Connect(function()
		inside = false
		held = false
		refresh()
	end)
	button.MouseButton1Down:Connect(function()
		held = true
		refresh()
	end)
	button.MouseButton1Up:Connect(function()
		held = false
		refresh()
	end)
	if onClick then
		button.MouseButton1Click:Connect(onClick)
	end
end

local function buildSwitch(row, on)
	local track = new("Frame", {
		Name = "SwitchTrack",
		Position = UDim2.new(1, -14, 0.5, 0),
		Size = UDim2.fromOffset(48, 22),
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundColor3 = Theme.PanelDeep,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ZIndex = 14,
		Parent = row,
	})
	Util.corner(Theme.R_Pill, track)
	Util.stroke(Color3.fromRGB(18, 18, 20), 1, 0.45, Enum.ApplyStrokeMode.Contextual, track)

	local art = on and SWITCH_ON or SWITCH_OFF

	local thumb = new("Frame", {
		Name = "SwitchThumb",
		Position = UDim2.new(0, art.thumbX, 0.5, 0),
		Size = UDim2.fromOffset(26, 18),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Theme.TextBright,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ZIndex = 16,
		Parent = track,
	})
	Util.corner(Theme.R_Pill, thumb)

	local gradient = new("UIGradient", {
		Color = art.gradient,
		Transparency = NumberSequence.new(0, 0),
		Rotation = 90,
		Offset = Vector2.new(0, 0),
		Enabled = true,
		Parent = thumb,
	})
	local glow = accentGlow(thumb, art.glow)

	local scale = new("UIScale", { Scale = 1, Parent = track })

	local state = on
	local function apply(instant)
		local nextArt = state and SWITCH_ON or SWITCH_OFF
		gradient.Color = nextArt.gradient
		if instant then
			thumb.Position = UDim2.new(0, nextArt.thumbX, 0.5, 0)
			if glow then glow.Transparency = nextArt.glow end
		else
			Util.tween(thumb, Util.Motion.Snap, { Position = UDim2.new(0, nextArt.thumbX, 0.5, 0) })
			if glow then
				Util.tween(glow, Util.Motion.Snap, { Transparency = nextArt.glow })
			end
		end
	end

	return {
		track = track,
		thumb = thumb,
		scale = scale,
		toggle = function()
			state = not state
			apply(false)
		end,
		press = function(down)
			Util.tween(scale, Util.Motion.Snap, { Scale = down and 0.92 or 1 })
		end,
	}
end

local function switchRow(cardFrame, y, data)
	local row = rowFrame(cardFrame, y)
	rowLabel(row, data.label, 0.6, -18, 13, Enum.TextTruncate.None)
	local sw = buildSwitch(row, data.on)
	local button = hitButton(row, 16)
	rowDivider(row, false)

	bindRow(button, row, sw.toggle)
	button.MouseButton1Down:Connect(function() sw.press(true) end)
	button.MouseButton1Up:Connect(function() sw.press(false) end)
	button.MouseLeave:Connect(function() sw.press(false) end)
	return row
end

local function inputRow(cardFrame, y, data)
	local row = rowFrame(cardFrame, y)
	rowLabel(row, data.label, data.labelScale, data.labelPad,
		data.labelTextSize or 13, Enum.TextTruncate.None)

	local box = new("Frame", {
		Position = UDim2.new(1, -14, 0.5, 0),
		Size = data.boxSize,
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundColor3 = Theme.Raise,
		BackgroundTransparency = data.boxTransparency,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 14,
		Parent = row,
	})
	Util.corner(Theme.R_Button, box)
	local boxStroke = Util.stroke(Theme.Stroke, 1, 0.3, Enum.ApplyStrokeMode.Contextual, box)

	local inset = data.boxInset
	local field = new("TextBox", {
		Position = UDim2.fromOffset(inset, 0),
		Size = UDim2.new(1, -inset * 2, 1, 0),
		BackgroundTransparency = 1,
		Text = data.text,
		PlaceholderText = data.placeholder,
		PlaceholderColor3 = Theme.TextMuted,
		TextColor3 = Theme.TextFaint,
		TextSize = data.boxTextSize,
		TextXAlignment = data.boxAlign,
		FontFace = Theme.Font.Medium,
		ClearTextOnFocus = data.clearOnFocus,
		MultiLine = false,
		ZIndex = 15,
		Parent = box,
	})

	field.Focused:Connect(function()
		Util.tween(boxStroke, Util.Motion.Snap, { Transparency = 0.1 })
		Util.tween(box, Util.Motion.Snap, { BackgroundTransparency = data.boxTransparency - 0.15 })
	end)
	field.FocusLost:Connect(function()
		Util.tween(boxStroke, Util.Motion.Snap, { Transparency = 0.3 })
		Util.tween(box, Util.Motion.Snap, { BackgroundTransparency = data.boxTransparency })
	end)
	box.MouseEnter:Connect(function()
		Util.tween(boxStroke, Util.Motion.Snap, { Transparency = 0.18 })
	end)
	box.MouseLeave:Connect(function()
		if not field:IsFocused() then
			Util.tween(boxStroke, Util.Motion.Snap, { Transparency = 0.3 })
		end
	end)

	if data.divider then
		rowDivider(row, false)
	end
	return row
end

local function valueRow(cardFrame, y, data)
	local row = rowFrame(cardFrame, y)
	rowLabel(row, data.label, 0.58, -18, 13, Enum.TextTruncate.AtEnd)

	local value = new("TextLabel", {
		Position = UDim2.new(1, -14, 0.5, 0),
		Size = UDim2.new(0.42, -18, 1, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		Text = data.value,
		TextColor3 = Theme.TextMuted,
		TextSize = 12,
		TextTransparency = 0,
		TextWrapped = false,
		TextScaled = false,
		TextXAlignment = Enum.TextXAlignment.Right,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		RichText = false,
		LineHeight = 1,
		FontFace = Theme.Font.Medium,
		TextTruncate = Enum.TextTruncate.AtEnd,
		ZIndex = 14,
		Parent = row,
	})

	if data.divider then
		rowDivider(row, data.dividerFlush)
	end
	local button = hitButton(row, 15)

	bindRow(button, row, function()
		Util.tween(value, Util.Motion.Snap, { TextTransparency = 0.65 })
		task.delay(0.12, function()
			Util.tween(value, Util.Motion.Quick, { TextTransparency = 0 })
		end)
	end)
	button.MouseEnter:Connect(function()
		Util.tween(value, Util.Motion.Snap, { TextColor3 = Theme.TextFaint })
	end)
	button.MouseLeave:Connect(function()
		Util.tween(value, Util.Motion.Snap, { TextColor3 = Theme.TextMuted })
	end)
	return row
end

local function keybindRow(cardFrame, y, data, listening)
	local row = rowFrame(cardFrame, y)
	rowLabel(row, data.label, 0.55, -20, 13, Enum.TextTruncate.None)

	local badge = new("Frame", {
		Position = UDim2.new(1, -14, 0.5, 0),
		Size = UDim2.fromOffset(52, 24),
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundColor3 = Theme.Raise,
		BackgroundTransparency = 0.5,
		BorderSizePixel = 0,
		ZIndex = 14,
		Parent = row,
	})
	Util.corner(Theme.R_Button, badge)
	local badgeStroke = Util.stroke(Theme.Stroke, 1, 0.3, Enum.ApplyStrokeMode.Contextual, badge)

	local keyText = new("TextLabel", {
		Position = UDim2.fromOffset(0, 0),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = data.key,
		TextColor3 = Theme.TextFaint,
		TextSize = 11,
		TextTransparency = 0,
		TextWrapped = false,
		TextScaled = false,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		RichText = false,
		LineHeight = 1,
		FontFace = Theme.Font.Medium,
		TextTruncate = Enum.TextTruncate.AtEnd,
		ZIndex = 15,
		Parent = badge,
	})

	local button = hitButton(row, 16)
	local bound = data.key

	local function rest()
		Util.tween(badge, Util.Motion.Snap, { BackgroundTransparency = 0.5 })
		Util.tween(badgeStroke, Util.Motion.Snap, { Transparency = 0.3, Color = Theme.Stroke })
		keyText.Text = bound
		Util.tween(keyText, Util.Motion.Snap, { TextColor3 = Theme.TextFaint })
	end

	local function arm()
		if listening.entry and listening.entry ~= keyText then
			listening.cancel()
		end
		listening.entry = keyText
		listening.cancel = rest
		listening.accept = function(name)
			if name then
				bound = name
			end
			rest()
			listening.entry = nil
		end
		keyText.Text = "\u{2026}"
		Util.tween(badge, Util.Motion.Snap, { BackgroundTransparency = 0.32 })
		Util.tween(badgeStroke, Util.Motion.Snap, { Transparency = 0.12, Color = Theme.Accent })
		Util.tween(keyText, Util.Motion.Snap, { TextColor3 = Theme.TextBright })
	end

	bindRow(button, row, arm)
	button.MouseEnter:Connect(function()
		if listening.entry ~= keyText then
			Util.tween(badge, Util.Motion.Snap, { BackgroundTransparency = 0.38 })
		end
	end)
	button.MouseLeave:Connect(function()
		if listening.entry ~= keyText then
			Util.tween(badge, Util.Motion.Snap, { BackgroundTransparency = 0.5 })
		end
	end)
	return row
end

local function cardRule(cardFrame, y)
	return new("Frame", {
		Position = UDim2.new(0, 14, 0, y),
		Size = UDim2.new(1, -28, 0, 1),
		BackgroundColor3 = Theme.Stroke,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 12,
		Parent = cardFrame,
	})
end

local function collectFades(root, out)
	for _, inst in ipairs(root:GetDescendants()) do
		if inst:IsA("GuiObject") then
			if inst.BackgroundTransparency < 1 then
				out[#out + 1] = { inst, "BackgroundTransparency", inst.BackgroundTransparency }
			end
			if inst:IsA("TextLabel") or inst:IsA("TextBox") then
				out[#out + 1] = { inst, "TextTransparency", inst.TextTransparency }
			elseif inst:IsA("ImageLabel") then
				out[#out + 1] = { inst, "ImageTransparency", inst.ImageTransparency }
			end
		elseif inst:IsA("UIStroke") or inst.ClassName == "UIShadow" then
			out[#out + 1] = { inst, "Transparency", inst.Transparency }
		end
	end
end

Novo.Pages.Settings = function(parent)
	local page = new("Frame", {
		Name = "Content_Settings",
		Position = UDim2.fromOffset(0, 0),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 22,
		Parent = parent,
	})

	local tabFill = new("Frame", {
		Name = "TabFill",
		Position = UDim2.fromOffset(0, 0),
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 1,
		Parent = page,
	})
	Util.corner(Theme.R_Panel, tabFill)

	local wall, wash = Util.frostedBacking(tabFill, Theme.R_Panel, Theme.T_Overlay)
	wall.ZIndex = 2
	wash.ZIndex = 3

	local header = new("Frame", {
		Name = "Header",
		Position = UDim2.fromOffset(0, 0),
		Size = UDim2.new(1, 0, 0, 54),
		BackgroundTransparency = 1,
		ZIndex = 12,
		Parent = page,
	})

	new("ImageLabel", {
		Position = UDim2.fromOffset(14, 17),
		Size = UDim2.fromOffset(18, 18),
		BackgroundTransparency = 1,
		Image = HEADER.icon,
		ImageColor3 = Theme.TextBright,
		ImageTransparency = 0,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 13,
		Parent = header,
	})

	new("TextLabel", {
		Position = UDim2.fromOffset(40, 14),
		Size = UDim2.new(1, -50, 0, 22),
		BackgroundTransparency = 1,
		Text = HEADER.title,
		TextColor3 = Theme.Text,
		TextSize = 17,
		TextTransparency = 0,
		TextWrapped = false,
		TextScaled = false,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		RichText = false,
		LineHeight = 1,
		FontFace = Theme.Font.Bold,
		TextTruncate = Enum.TextTruncate.None,
		ZIndex = 13,
		Parent = header,
	})

	new("TextLabel", {
		Position = UDim2.fromOffset(14, 36),
		Size = UDim2.new(1, -24, 0, 14),
		BackgroundTransparency = 1,
		Text = HEADER.subtitle,
		TextColor3 = Color3.fromRGB(180, 180, 190),
		TextSize = 11,
		TextTransparency = 0,
		TextWrapped = false,
		TextScaled = false,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		RichText = false,
		LineHeight = 1,
		FontFace = Theme.Font.Medium,
		TextTruncate = Enum.TextTruncate.None,
		ZIndex = 13,
		Parent = header,
	})

	local scroll = new("ScrollingFrame", {
		Name = "Scroll",
		Position = UDim2.fromOffset(0, 54),
		Size = UDim2.new(1, 0, 1, -54),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		CanvasSize = UDim2.new(0, 0, 0, 1202),
		ScrollBarThickness = 0,
		ScrollBarImageColor3 = Theme.Accent,
		ScrollBarImageTransparency = 0.6,
		ScrollingDirection = Enum.ScrollingDirection.XY,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		VerticalScrollBarInset = Enum.ScrollBarInset.None,
		ZIndex = 11,
		Parent = page,
	})

	local listening = { entry = nil, cancel = function() end, accept = function() end }

	local function fillCard(cardFrame, rows)
		local y = 0
		for _, data in ipairs(rows) do
			if data.kind == "switch" then
				switchRow(cardFrame, y, data)
				y = y + ROW_H
			elseif data.kind == "input" then
				inputRow(cardFrame, y, data)
				y = y + ROW_H
			elseif data.kind == "value" then
				valueRow(cardFrame, y, data)
				y = y + ROW_H
			elseif data.kind == "rule" then
				cardRule(cardFrame, data.y)
			end
		end
	end

	local sections = {}
	local function track(inst)
		sections[#sections + 1] = { frame = inst, rest = inst.Position }
		return inst
	end

	local general = track(card(scroll, 14, 324, false))
	fillCard(general, GENERAL)

	track(caption(scroll, 352, 18, "KEYBINDS", Theme.TextFaint, 12))
	local keys = track(card(scroll, 378, 72, true))
	for i, data in ipairs(KEYBINDS) do
		keybindRow(keys, (i - 1) * ROW_H, data, listening)
	end
	track(caption(scroll, 456, 16, "Click the badge, then press any key.  Esc = cancel.",
		Color3.fromRGB(70, 70, 85), 10))

	track(caption(scroll, 478, 16, "SPOOFER", Theme.TextFaint, 10))
	fillCard(track(card(scroll, 504, 108, true)), SPOOFER)

	track(caption(scroll, 630, 16, "NAMETAGS", Theme.TextFaint, 10))
	fillCard(track(card(scroll, 656, 36, true)), NAMETAGS)

	track(caption(scroll, 710, 18, "AK ADMIN", Theme.TextFaint, 12))
	fillCard(track(card(scroll, 736, 108, true)), AK_ADMIN)

	track(caption(scroll, 874, 16, "CHAT SAFETY", Theme.TextFaint, 10))
	fillCard(track(card(scroll, 900, 108, true)), CHAT_SAFETY)

	track(caption(scroll, 1022, 16, "WEBHOOK LOGGING", Theme.TextFaint, 10))
	fillCard(track(card(scroll, 1048, 144, true)), WEBHOOK)

	UserInputService.InputBegan:Connect(function(input, processed)
		if not listening.entry then return end
		if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
		if input.KeyCode == Enum.KeyCode.Escape then
			listening.accept(nil)
		elseif input.KeyCode ~= Enum.KeyCode.Unknown then
			listening.accept(input.KeyCode.Name)
		end
	end)

	local fades = {}
	collectFades(header, fades)
	collectFades(scroll, fades)

	local headerRest = header.Position

	local function playIntro()
		header.Position = headerRest + UDim2.fromOffset(0, -6)
		for i, entry in ipairs(sections) do
			entry.frame.Position = entry.rest + UDim2.fromOffset(0, 14)
			Util.tween(entry.frame, slideAfter(i), { Position = entry.rest })
		end
		for _, entry in ipairs(fades) do
			entry[1][entry[2]] = 1
		end

		Util.tween(header, SLIDE, { Position = headerRest })
		for _, entry in ipairs(fades) do
			Util.tween(entry[1], FADE, { [entry[2]] = entry[3] })
		end
	end

	page:GetPropertyChangedSignal("Visible"):Connect(function()
		if page.Visible then
			playIntro()
		end
	end)
	playIntro()

	return page
end
end

do
local Util  = Novo.Util
local Theme = Novo.Theme
local new   = Util.new

local PLUS_AVATAR = "rbxassetid://134691196710952"

local HEADER = {
	icon     = Theme.Icon.Plus,
	title    = "Plus",
	subtitle = "Novoline Plus commands",
}

local UPSELL = {
	title = "Novoline Plus",
	body  = "Gives access to trolling that can be\nused on other Novoline Users.",
	cta   = "Get Plus",
}

local function bindSurface(button, target, base, hover, press)
	local inside, held = false, false
	local function refresh()
		local goal = base
		if held then
			goal = press
		elseif inside then
			goal = hover
		end
		Util.tween(target, Util.Motion.Snap, { BackgroundTransparency = goal })
	end
	button.MouseEnter:Connect(function()
		inside = true
		refresh()
	end)
	button.MouseLeave:Connect(function()
		inside = false
		held = false
		refresh()
	end)
	button.MouseButton1Down:Connect(function()
		held = true
		refresh()
	end)
	button.MouseButton1Up:Connect(function()
		held = false
		refresh()
	end)
	return refresh
end

Novo.Pages.Plus = function(parent)
	local page = Util.new("Frame", {
		Name = "Content_Plus",
		Position = UDim2.fromOffset(0, 0),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 22,
		Parent = parent,
	})

	local tabFill = new("Frame", {
		Name = "TabFill",
		Position = UDim2.fromOffset(0, 0),
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 1,
		Parent = page,
	})
	Util.corner(Theme.R_Panel, tabFill)

	local wall, wash = Util.frostedBacking(tabFill, Theme.R_Panel, Theme.T_Overlay)
	wall.ZIndex = 2
	wash.ZIndex = 3

	local header = new("Frame", {
		Name = "Header",
		Position = UDim2.fromOffset(0, 0),
		Size = UDim2.new(1, 0, 0, 54),
		BackgroundTransparency = 1,
		ZIndex = 12,
		Parent = page,
	})

	local headerIcon = new("ImageLabel", {
		Position = UDim2.fromOffset(14, 17),
		Size = UDim2.fromOffset(18, 18),
		BackgroundTransparency = 1,
		Image = HEADER.icon,
		ImageColor3 = Theme.TextBright,
		ImageTransparency = 0,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 13,
		Parent = header,
	})

	local headerTitle = new("TextLabel", {
		Position = UDim2.fromOffset(40, 14),
		Size = UDim2.new(1, -50, 0, 22),
		BackgroundTransparency = 1,
		Text = HEADER.title,
		TextColor3 = Theme.Text,
		TextSize = 17,
		TextTransparency = 0,
		TextWrapped = false,
		TextScaled = false,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		RichText = false,
		LineHeight = 1,
		FontFace = Theme.Font.Bold,
		TextTruncate = Enum.TextTruncate.None,
		ZIndex = 13,
		Parent = header,
	})

	local headerSub = new("TextLabel", {
		Position = UDim2.fromOffset(14, 36),
		Size = UDim2.new(1, -24, 0, 14),
		BackgroundTransparency = 1,
		Text = HEADER.subtitle,
		TextColor3 = Color3.fromRGB(180, 180, 190),
		TextSize = 11,
		TextTransparency = 0,
		TextWrapped = false,
		TextScaled = false,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		RichText = false,
		LineHeight = 1,
		FontFace = Theme.Font.Medium,
		TextTruncate = Enum.TextTruncate.None,
		ZIndex = 13,
		Parent = header,
	})

	local overlay = new("Frame", {
		Name = "_PlusUpsellOverlay",
		Position = UDim2.fromOffset(0, 0),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Visible = true,
		ZIndex = 20,
		Parent = page,
	})

	local card = new("Frame", {
		Position = UDim2.new(0.5, 0, 0, 24),
		AnchorPoint = Vector2.new(0.5, 0),
		Size = UDim2.new(1, -32, 0, 250),
		BackgroundTransparency = 1,
		ZIndex = 21,
		Parent = overlay,
	})

	local avatarPuck = new("Frame", {
		Position = UDim2.new(0.5, 0, 0, 20),
		AnchorPoint = Vector2.new(0.5, 0),
		Size = UDim2.fromOffset(72, 72),
		BackgroundColor3 = Color3.fromRGB(18, 18, 20),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 22,
		Parent = card,
	})
	Util.corner(Theme.R_Pill, avatarPuck)

	local avatarIcon = new("ImageLabel", {
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromOffset(58, 58),
		BackgroundTransparency = 1,
		Image = PLUS_AVATAR,
		ImageColor3 = Theme.TextBright,
		ImageTransparency = 0,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 23,
		Parent = avatarPuck,
	})

	local upsellTitle = new("TextLabel", {
		Position = UDim2.new(0.5, 0, 0, 104),
		AnchorPoint = Vector2.new(0.5, 0),
		Size = UDim2.new(1, 0, 0, 28),
		BackgroundTransparency = 1,
		Text = UPSELL.title,
		TextColor3 = Theme.Text,
		TextSize = 17,
		TextTransparency = 0,
		TextWrapped = false,
		TextScaled = false,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		RichText = false,
		LineHeight = 1,
		FontFace = Theme.Font.Bold,
		TextTruncate = Enum.TextTruncate.None,
		ZIndex = 22,
		Parent = card,
	})

	local upsellBody = new("TextLabel", {
		Position = UDim2.new(0.5, 0, 0, 136),
		AnchorPoint = Vector2.new(0.5, 0),
		Size = UDim2.new(1, -8, 0, 64),
		BackgroundTransparency = 1,
		Text = UPSELL.body,
		TextColor3 = Theme.TextMuted,
		TextSize = 13,
		TextTransparency = 0,
		TextWrapped = true,
		TextScaled = false,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Top,
		TextStrokeTransparency = 1,
		RichText = false,
		LineHeight = 1,
		FontFace = Theme.Font.Regular,
		TextTruncate = Enum.TextTruncate.None,
		ZIndex = 22,
		Parent = card,
	})

	local cta = new("TextButton", {
		Position = UDim2.new(0.5, 0, 0, 190),
		AnchorPoint = Vector2.new(0.5, 0),
		Size = UDim2.new(1, -32, 0, 42),
		BackgroundColor3 = Color3.fromRGB(40, 40, 44),
		BackgroundTransparency = 0.6,
		BorderSizePixel = 0,
		Text = UPSELL.cta,
		TextColor3 = Theme.Text,
		TextSize = 14,
		TextTransparency = 0,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		RichText = false,
		FontFace = Theme.Font.Bold,
		AutoButtonColor = false,
		ZIndex = 22,
		Parent = card,
	})
	Util.corner(Theme.R_Button, cta)
	bindSurface(cta, cta, 0.6, 0.44, 0.32)

	local content = new("Frame", {
		Name = "_PlusContent",
		Position = UDim2.fromOffset(0, 0),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 11,
		Parent = page,
	})

	local searchBox = new("Frame", {
		Position = UDim2.fromOffset(10, 62),
		Size = UDim2.new(1, -20, 0, 34),
		BackgroundColor3 = Theme.Raise,
		BackgroundTransparency = 0.35,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 15,
		Parent = content,
	})
	Util.corner(Theme.R_Nav, searchBox)
	local searchStroke = Util.stroke(Theme.Stroke, 1, 0.6, Enum.ApplyStrokeMode.Border, searchBox)

	local searchShine = Util.surfaceShine(searchBox, 34, Theme.R_Nav, 0.88,
		{
			NumberSequenceKeypoint.new(0, 0.22),
			NumberSequenceKeypoint.new(0.55, 0.78),
			NumberSequenceKeypoint.new(1, 1),
		}, 16)
	searchShine.Size = UDim2.fromScale(1, 1)
	searchShine.Fill.Size = UDim2.new(1, 0, 0, 6)

	local searchInput = new("TextBox", {
		Position = UDim2.fromOffset(12, 0),
		Size = UDim2.new(1, -24, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		PlaceholderText = "Search targets...",
		PlaceholderColor3 = Theme.TextFaint,
		TextColor3 = Theme.Text,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		FontFace = Theme.Font.Medium,
		ClearTextOnFocus = false,
		MultiLine = false,
		ZIndex = 16,
		Parent = searchBox,
	})

	do
		local inside, focused = false, false
		local function refresh()
			local lit = inside or focused
			Util.tween(searchBox, Util.Motion.Snap, { BackgroundTransparency = lit and 0.26 or 0.35 })
			Util.tween(searchStroke, Util.Motion.Snap, { Transparency = lit and 0.38 or 0.6 })
		end
		searchBox.MouseEnter:Connect(function()
			inside = true
			refresh()
		end)
		searchBox.MouseLeave:Connect(function()
			inside = false
			refresh()
		end)
		searchInput.Focused:Connect(function()
			focused = true
			refresh()
		end)
		searchInput.FocusLost:Connect(function()
			focused = false
			refresh()
		end)
	end

	local listHolder = new("Frame", {
		Position = UDim2.fromOffset(10, 104),
		Size = UDim2.new(1, -20, 1, -112),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 12,
		Parent = content,
	})

	new("ScrollingFrame", {
		Name = "Scroll",
		Position = UDim2.fromOffset(0, 0),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		CanvasSize = UDim2.new(0, 0, 0, 120),
		ScrollBarThickness = 0,
		ScrollBarImageColor3 = Theme.Accent,
		ScrollBarImageTransparency = 0.6,
		ScrollingDirection = Enum.ScrollingDirection.XY,
		AutomaticCanvasSize = Enum.AutomaticSize.None,
		VerticalScrollBarInset = Enum.ScrollBarInset.None,
		ZIndex = 11,
		Parent = listHolder,
	})

	new("TextLabel", {
		Name = "_PlusEmpty",
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.new(1, -24, 0, 40),
		BackgroundTransparency = 1,
		Text = "No users here are using Novoline.",
		TextColor3 = Theme.TextMuted,
		TextSize = 13,
		TextTransparency = 0,
		TextWrapped = true,
		TextScaled = false,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		RichText = false,
		LineHeight = 1,
		FontFace = Theme.Font.Medium,
		TextTruncate = Enum.TextTruncate.None,
		Visible = false,
		ZIndex = 13,
		Parent = listHolder,
	})

	local SLIDE = TweenInfo.new(0.18, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
	local FADE  = TweenInfo.new(0.20, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

	local fadeTargets = {
		{ headerIcon,  "ImageTransparency", 0 },
		{ headerTitle, "TextTransparency", 0 },
		{ headerSub,   "TextTransparency", 0 },
		{ avatarIcon,  "ImageTransparency", 0 },
		{ upsellTitle, "TextTransparency", 0 },
		{ upsellBody,  "TextTransparency", 0 },
		{ cta,         "TextTransparency", 0 },
	}

	local function playIntro()
		card.Position = UDim2.new(0.5, 0, 0, 34)
		header.Position = UDim2.fromOffset(0, -6)
		cta.BackgroundTransparency = 1
		for _, entry in ipairs(fadeTargets) do
			entry[1][entry[2]] = 1
		end

		Util.tween(card, SLIDE, { Position = UDim2.new(0.5, 0, 0, 24) })
		Util.tween(header, SLIDE, { Position = UDim2.fromOffset(0, 0) })
		Util.tween(cta, FADE, { BackgroundTransparency = 0.6 })
		for _, entry in ipairs(fadeTargets) do
			Util.tween(entry[1], FADE, { [entry[2]] = entry[3] })
		end
	end

	page:GetPropertyChangedSignal("Visible"):Connect(function()
		if page.Visible then
			playIntro()
		end
	end)
	playIntro()

	return page
end
end

do
local Util  = Novo.Util
local Theme = Novo.Theme
local new   = Util.new

Novo.Panels = Novo.Panels or {}
local Panels = Novo.Panels
Panels.order   = Panels.order   or {}
Panels.chassis = Panels.chassis or {}
Panels.built   = Panels.built   or {}

local PANEL_SLIDE = TweenInfo.new(0.18, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
local PANEL_FADE  = TweenInfo.new(0.20, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

local PANEL_MIN = Vector2.new(180, 160)
local PANEL_MAX = Vector2.new(420, 520)

local function uishadow(color, transparency, parent)
	local ok, sh = pcall(Instance.new, "UIShadow")
	if not ok or not sh then return nil end
	pcall(function() sh.Color = color end)
	pcall(function() sh.Transparency = transparency end)
	pcall(function() sh.Offset = UDim2.new(0, 0, 0, 0) end)
	pcall(function() sh.Spread = UDim2.new(0, 0, 0, 0) end)
	sh.Parent = parent
	return sh
end

local function hoverFade(btn, target, prop, base, over, down)
	local hovering = false
	local function to(v)
		Util.tween(target, Util.Motion.Snap, { [prop] = v })
	end
	btn.MouseEnter:Connect(function()
		hovering = true
		to(over)
	end)
	btn.MouseLeave:Connect(function()
		hovering = false
		to(base)
	end)
	btn.MouseButton1Down:Connect(function() to(down) end)
	btn.MouseButton1Up:Connect(function() to(hovering and over or base) end)
end

Panels.hoverFade = hoverFade

local function panelHost()
	if Panels.layer then return Panels.layer end
	local screen = new("ScreenGui", {
		Name = "NovoPanels",
		DisplayOrder = 50,
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	})
	Novo.Guis[#Novo.Guis + 1] = screen
	Panels.layer = screen
	return screen
end
Panels.host = Panels.host or panelHost

function Panels.makePanel(opts)
	local size = opts.size or UDim2.fromOffset(220, 270)

	local frame = new("Frame", {
		Name = opts.name,
		Position = opts.position,
		Size = size,
		AnchorPoint = opts.anchor or Vector2.new(0.5, 0.5),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 150,
		Parent = opts.parent or Panels.host(),
	})
	Util.corner(Theme.R_Panel, frame)

	local shine = Util.surfaceShine(frame, 28, Theme.R_Panel, 0.88,
		{
			NumberSequenceKeypoint.new(0, 0.14),
			NumberSequenceKeypoint.new(0.30, 0.62),
			NumberSequenceKeypoint.new(0.62, 0.94),
			NumberSequenceKeypoint.new(1, 1),
		}, 151)

	local wall, wash = Util.frostedBacking(frame, Theme.R_Panel, Theme.T_Overlay)
	local stroke = Util.stroke(Theme.Stroke, 1, Theme.T_Stroke, Enum.ApplyStrokeMode.Border, frame)
	local scale = new("UIScale", { Scale = 1, Parent = frame })

	local resizeHandle = new("TextButton", {
		Name = "ResizeHandle",
		Position = UDim2.new(1, 16, 1, 16),
		Size = UDim2.fromOffset(44, 44),
		AnchorPoint = Vector2.new(1, 1),
		BackgroundTransparency = 1,
		Text = "",
		TextSize = 8,
		AutoButtonColor = false,
		ZIndex = 900,
		Parent = frame,
	})
	local resizeGrip = new("ImageLabel", {
		Name = "ResizeGrip",
		Position = UDim2.new(1, -2, 1, -2),
		Size = UDim2.fromOffset(22, 22),
		AnchorPoint = Vector2.new(1, 1),
		BackgroundTransparency = 1,
		Image = Theme.Icon.Resize,
		ImageColor3 = Theme.TextFaint,
		ImageTransparency = 0.1,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 901,
		Parent = frame,
	})

	local titleBar = new("Frame", {
		Name = "TitleBar",
		Size = UDim2.new(1, 0, 0, 34),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 151,
		Parent = frame,
	})

	new("TextLabel", {
		Name = "Title",
		Position = UDim2.fromOffset(12, 0),
		Size = UDim2.new(1, -64, 1, 0),
		BackgroundTransparency = 1,
		Text = opts.title,
		TextColor3 = Theme.TextMuted,
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		FontFace = Theme.Font.Medium,
		TextTruncate = Enum.TextTruncate.AtEnd,
		ZIndex = 152,
		Parent = titleBar,
	})

	local function titleButton(name, x, icon)
		local btn = new("TextButton", {
			Name = name,
			Position = UDim2.new(1, x, 0.5, -11),
			Size = UDim2.fromOffset(22, 22),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Text = "",
			TextSize = 8,
			AutoButtonColor = false,
			ZIndex = 153,
			Parent = titleBar,
		})
		local img = new("ImageLabel", {
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(13, 13),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			Image = icon,
			ImageTransparency = 0.45,
			ScaleType = Enum.ScaleType.Stretch,
			ZIndex = 154,
			Parent = btn,
		})
		hoverFade(btn, img, "ImageTransparency", 0.45, 0.1, 0.3)
		return btn, img
	end

	local closeBtn = titleButton("CloseBtn", -28, Theme.Icon.Close)
	local minimizeBtn = titleButton("MinimizeBtn", -54, Theme.Icon.Minimize)

	local body = new("Frame", {
		Position = UDim2.fromOffset(0, 34),
		Size = UDim2.new(1, 0, 1, -34),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 151,
		Parent = frame,
	})
	Util.corner(Theme.R_Panel, body)

	local chassis = {
		frame = frame,
		shine = shine,
		wallpaper = wall,
		wash = wash,
		stroke = stroke,
		scale = scale,
		titleBar = titleBar,
		closeBtn = closeBtn,
		minimizeBtn = minimizeBtn,
		resizeHandle = resizeHandle,
		resizeGrip = resizeGrip,
		body = body,
		fullSize = size,
		minimized = false,
		open = false,
	}

	local openToken = 0

	local function fadeChassis(hidden, instant)
		local goals = {
			{ frame, "BackgroundTransparency", 0 },
			{ wall, "ImageTransparency", 0 },
			{ wash, "BackgroundTransparency", Theme.T_Overlay },
			{ stroke, "Transparency", Theme.T_Stroke },
			{ shine, "GroupTransparency", 0 },
		}
		for _, g in ipairs(goals) do
			local target = hidden and 1 or g[3]
			if instant then
				g[1][g[2]] = target
			else
				Util.tween(g[1], PANEL_FADE, { [g[2]] = target })
			end
		end
	end

	function chassis.setOpen(open, instant)
		openToken += 1
		local token = openToken
		chassis.open = open
		if open then
			frame.Visible = true
			if instant then
				scale.Scale = 1
				fadeChassis(false, true)
				return
			end
			scale.Scale = 0.92
			fadeChassis(true, true)
			Util.tween(scale, PANEL_SLIDE, { Scale = 1 })
			fadeChassis(false, false)
		else
			if instant then
				frame.Visible = false
				return
			end
			Util.tween(scale, PANEL_FADE, { Scale = 0.94 })
			fadeChassis(true, false)
			task.delay(0.20, function()
				if openToken == token and not chassis.open then
					frame.Visible = false
					scale.Scale = 1
					fadeChassis(false, true)
				end
			end)
		end
	end

	function chassis.toggle()
		chassis.setOpen(not chassis.open)
	end

	function chassis.setMinimized(min)
		chassis.minimized = min
		if min then
			chassis.fullSize = frame.Size
			body.Visible = false
			resizeHandle.Visible = false
			resizeGrip.Visible = false
			Util.tween(frame, PANEL_SLIDE, { Size = UDim2.new(frame.Size.X.Scale, frame.Size.X.Offset, 0, 34) })
		else
			body.Visible = true
			resizeHandle.Visible = true
			resizeGrip.Visible = true
			Util.tween(frame, PANEL_SLIDE, { Size = chassis.fullSize })
		end
	end

	closeBtn.MouseButton1Click:Connect(function()
		chassis.setOpen(false)
	end)
	minimizeBtn.MouseButton1Click:Connect(function()
		chassis.setMinimized(not chassis.minimized)
	end)

	Util.draggable(titleBar, frame)

	hoverFade(resizeHandle, resizeGrip, "ImageTransparency", 0.1, 0, 0.25)

	local sizing, startSize, startPos, startPoint = false, nil, nil, nil
	resizeHandle.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1
			and input.UserInputType ~= Enum.UserInputType.Touch then return end
		if chassis.minimized then return end
		sizing = true
		startSize = frame.Size
		startPos = frame.Position
		startPoint = input.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then sizing = false end
		end)
	end)
	UserInputService.InputChanged:Connect(function(input)
		if not sizing then return end
		if input.UserInputType ~= Enum.UserInputType.MouseMovement
			and input.UserInputType ~= Enum.UserInputType.Touch then return end
		local delta = input.Position - startPoint
		local w = math.clamp(startSize.X.Offset + delta.X, PANEL_MIN.X, PANEL_MAX.X)
		local h = math.clamp(startSize.Y.Offset + delta.Y, PANEL_MIN.Y, PANEL_MAX.Y)
		local grownX = (w - startSize.X.Offset) * frame.AnchorPoint.X
		local grownY = (h - startSize.Y.Offset) * frame.AnchorPoint.Y
		frame.Size = UDim2.new(startSize.X.Scale, w, startSize.Y.Scale, h)
		frame.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + grownX,
			startPos.Y.Scale, startPos.Y.Offset + grownY
		)
		chassis.fullSize = frame.Size
	end)

	return chassis
end

local function buildSlider(parent, spec)
	local card = new("Frame", {
		Name = spec.name,
		Position = UDim2.new(0, 10, 0, spec.y),
		Size = UDim2.new(1, -20, 0, 56),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ZIndex = 12,
		Parent = parent,
	})
	Util.corner(Theme.R_Panel, card)
	Util.stroke(Theme.Stroke, 1, Theme.T_Stroke, Enum.ApplyStrokeMode.Border, card)

	local labels = new("Frame", {
		Position = UDim2.new(0, 14, 0.5, 0),
		Size = UDim2.fromOffset(72, 33),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 20,
		Parent = card,
	})
	Util.list(Enum.FillDirection.Vertical, 2,
		Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center, labels)

	new("TextLabel", {
		Size = UDim2.new(1, 0, 0, 16),
		BackgroundTransparency = 1,
		Text = spec.label,
		TextColor3 = Theme.TextBright,
		TextSize = 15,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		FontFace = Theme.Font.Medium,
		TextTruncate = Enum.TextTruncate.AtEnd,
		LayoutOrder = 0,
		ZIndex = 21,
		Parent = labels,
	})
	local valueLabel = new("TextLabel", {
		Size = UDim2.new(1, 0, 0, 15),
		BackgroundTransparency = 1,
		Text = spec.value,
		TextColor3 = Theme.TextBright,
		TextSize = 14,
		TextTransparency = 0.3,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		FontFace = Theme.Font.Medium,
		TextTruncate = Enum.TextTruncate.None,
		LayoutOrder = 1,
		ZIndex = 21,
		Parent = labels,
	})

	local track = new("Frame", {
		Position = UDim2.new(1, -12, 0.5, 0),
		Size = UDim2.new(1, -114, 0, 14),
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundColor3 = Theme.Track,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ZIndex = 13,
		Parent = card,
	})
	Util.corner(UDim.new(0, 13), track)

	local fill = new("Frame", {
		Position = UDim2.new(0, 0, 0.5, 0),
		Size = UDim2.new(spec.fill, 0, 1, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ZIndex = 14,
		Parent = track,
	})
	Util.corner(UDim.new(0, 13), fill)
	new("UIGradient", {
		Color = ColorSequence.new(Theme.Accent, Theme.AccentDeep),
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.85),
			NumberSequenceKeypoint.new(1, 0),
		}),
		Rotation = 2,
		Offset = Vector2.new(0, 0.5),
		Parent = fill,
	})
	uishadow(Theme.Accent, 0.55, fill)

	local knob = new("Frame", {
		Position = UDim2.new(1, 20, 0.5, 0),
		Size = UDim2.fromOffset(35, 20),
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ZIndex = 50,
		Parent = fill,
	})
	Util.corner(Theme.R_Pill, knob)
	uishadow(Color3.fromRGB(255, 255, 255), 0.8, knob)
	local knobStroke = Util.stroke(Color3.fromRGB(255, 255, 255), 1, 1,
		Enum.ApplyStrokeMode.Contextual, knob)

	local hit = new("TextButton", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = "",
		TextSize = 8,
		TextTransparency = 1,
		AutoButtonColor = false,
		ZIndex = 10,
		Parent = track,
	})

	local overlay = new("Frame", {
		Name = "PanelOverlay",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Theme.PanelDeep,
		BackgroundTransparency = 0.55,
		BorderSizePixel = 0,
		ZIndex = 12,
		Parent = card,
	})
	Util.corner(Theme.R_Panel, overlay)

	local glow = new("Frame", {
		Name = "BlueCornerGlow",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Theme.Accent,
		BackgroundTransparency = 0.78,
		BorderSizePixel = 0,
		ZIndex = 12,
		Parent = card,
	})
	Util.corner(Theme.R_Panel, glow)
	new("UIGradient", {
		Color = ColorSequence.new(Color3.fromRGB(255, 255, 255)),
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.35),
			NumberSequenceKeypoint.new(0.18, 0.72),
			NumberSequenceKeypoint.new(0.48, 0.94),
			NumberSequenceKeypoint.new(0.72, 1),
			NumberSequenceKeypoint.new(1, 1),
		}),
		Rotation = 35,
		Parent = glow,
	})

	local dragging = false

	local function applyAt(x)
		local left = track.AbsolutePosition.X
		local width = math.max(track.AbsoluteSize.X, 1)
		local alpha = math.clamp((x - left) / width, 0, 1)
		fill.Size = UDim2.new(alpha, 0, 1, 0)
		valueLabel.Text = tostring(math.floor(spec.min + (spec.max - spec.min) * alpha + 0.5))
	end

	hit.MouseEnter:Connect(function()
		Util.tween(glow, Util.Motion.Snap, { BackgroundTransparency = 0.72 })
		Util.tween(knobStroke, Util.Motion.Snap, { Transparency = 0.6 })
	end)
	hit.MouseLeave:Connect(function()
		if dragging then return end
		Util.tween(glow, Util.Motion.Snap, { BackgroundTransparency = 0.78 })
		Util.tween(knobStroke, Util.Motion.Snap, { Transparency = 1 })
	end)

	hit.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1
			and input.UserInputType ~= Enum.UserInputType.Touch then return end
		dragging = true
		Util.tween(knobStroke, Util.Motion.Snap, { Transparency = 0.35 })
		applyAt(input.Position.X)
	end)
	hit.InputEnded:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1
			and input.UserInputType ~= Enum.UserInputType.Touch then return end
		dragging = false
		Util.tween(knobStroke, Util.Motion.Snap, { Transparency = 1 })
	end)
	UserInputService.InputEnded:Connect(function(input)
		if not dragging then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
			Util.tween(glow, Util.Motion.Snap, { BackgroundTransparency = 0.78 })
			Util.tween(knobStroke, Util.Motion.Snap, { Transparency = 1 })
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if not dragging then return end
		if input.UserInputType ~= Enum.UserInputType.MouseMovement
			and input.UserInputType ~= Enum.UserInputType.Touch then return end
		applyAt(input.Position.X)
	end)

	return card
end

local BANG_PANELS = {
	{
		key = "Facebang",
		name = "FacebangPanel",
		title = "FACEBANG",
		position = UDim2.new(0, 960, 0, 482),
		anchor = Vector2.new(0.5, 0.4),
		spacerTinted = true,
		divider = true,
		sliders = {
			{ name = "Speed",    label = "Speed",    value = "10", fill = 0.2,               y = 44,  min = 0,   max = 50 },
			{ name = "Distance", label = "Distance", value = "19", fill = 0.260869562625885, y = 104, min = 1,   max = 70 },
			{ name = "Height",   label = "Height",   value = "8",  fill = 0.56,              y = 164, min = -20, max = 30 },
		},
	},
	{
		key = "Facebang2",
		name = "Facebang2Panel",
		title = "FACEBANG2",
		position = UDim2.new(0, 960, 0, 662),
		anchor = Vector2.new(0.5, 0.55),
		spacerTinted = false,
		divider = true,
		sliders = {
			{ name = "Speed",    label = "Speed",    value = "10", fill = 0.2,               y = 44,  min = 0,   max = 50 },
			{ name = "Distance", label = "Distance", value = "19", fill = 0.260869562625885, y = 104, min = 1,   max = 70 },
			{ name = "Height",   label = "Height",   value = "8",  fill = 0.56,              y = 164, min = -20, max = 30 },
		},
	},
	{
		key = "Bang",
		name = "BangPanel",
		title = "BANG",
		position = UDim2.new(0, 960, 0, 385),
		anchor = Vector2.new(0.5, 0.32),
		spacerTinted = true,
		divider = true,
		sliders = {
			{ name = "Speed",    label = "Speed",    value = "10", fill = 0.2,               y = 44,  min = 0,   max = 50 },
			{ name = "Distance", label = "Distance", value = "19", fill = 0.260869562625885, y = 104, min = 1,   max = 70 },
			{ name = "Height",   label = "Height",   value = "3",  fill = 0.46,              y = 164, min = -20, max = 30 },
		},
	},
	{
		key = "Bang2",
		name = "Bang2Panel",
		title = "BANG2",
		position = UDim2.new(0, 960, 0, 457),
		anchor = Vector2.new(0.5, 0.38),
		spacerTinted = false,
		divider = false,
		sliders = {
			{ name = "Speed",    label = "Speed",    value = "10", fill = 0.2,               y = 44,  min = 0,   max = 50 },
			{ name = "Distance", label = "Distance", value = "19", fill = 0.260869562625885, y = 104, min = 1,   max = 70 },
			{ name = "Height",   label = "Height",   value = "3",  fill = 0.46,              y = 164, min = -20, max = 30 },
		},
	},
}

local function buildBangBody(chassis, spec)
	local body = chassis.body

	local spacer = new("Frame", {
		Size = UDim2.new(1, 0, 0, 14),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 151,
		Parent = body,
	})
	if spec.spacerTinted then
		spacer.BackgroundColor3 = Theme.Panel
	end

	if spec.divider then
		local divider = new("Frame", {
			Size = UDim2.new(1, 0, 0, 1),
			BackgroundColor3 = Theme.Divider,
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			Visible = false,
			ZIndex = 152,
			Parent = body,
		})
		new("UIGradient", {
			Color = ColorSequence.new(Color3.fromRGB(255, 255, 255)),
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0.8),
				NumberSequenceKeypoint.new(0.15, 0),
				NumberSequenceKeypoint.new(0.85, 0),
				NumberSequenceKeypoint.new(1, 0.8),
			}),
			Rotation = 0,
			Parent = divider,
		})
	end

	local start = new("TextButton", {
		Position = UDim2.fromOffset(12, 8),
		Size = UDim2.new(1, -24, 0, 28),
		BackgroundColor3 = Theme.Raise,
		BackgroundTransparency = 0.6,
		BorderSizePixel = 0,
		Text = "Start",
		TextColor3 = Theme.Text,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		FontFace = Theme.Font.Bold,
		AutoButtonColor = false,
		ZIndex = 152,
		Parent = body,
	})
	Util.corner(Theme.R_Button, start)
	hoverFade(start, start, "BackgroundTransparency", 0.6, 0.44, 0.7)

	for _, slider in ipairs(spec.sliders) do
		buildSlider(body, slider)
	end

	chassis.startButton = start
	return body
end

for _, spec in ipairs(BANG_PANELS) do
	Panels[spec.key] = function(parent)
		local chassis = Panels.makePanel({
			name = spec.name,
			title = spec.title,
			position = spec.position,
			anchor = spec.anchor,
			size = UDim2.fromOffset(220, 270),
			parent = parent or Panels.host(),
		})
		buildBangBody(chassis, spec)
		Panels.chassis[spec.key] = chassis
		return chassis.frame
	end
	Panels.order[#Panels.order + 1] = spec.key
end

function Panels.setOpen(key, open, instant)
	local chassis = Panels.chassis[key]
	if not chassis then return end
	chassis.setOpen(open, instant)
end

function Panels.toggle(key)
	local chassis = Panels.chassis[key]
	if not chassis then return end
	chassis.toggle()
end

local previousBuild = Panels.build
function Panels.build()
	if previousBuild then previousBuild() end
	local layer = Panels.host()
	for _, key in ipairs(Panels.order) do
		local builder = Panels[key]
		if type(builder) == "function" and not Panels.built[key] then
			Panels.built[key] = builder(layer)
		end
	end
end
end

do
local Util  = Novo.Util
local Theme = Novo.Theme
local new   = Util.new

local Panels = Novo.Panels
local hoverFade = Panels.hoverFade

local LOG_BG = Color3.fromRGB(18, 18, 20)

local MIC_ICON = "rbxassetid://114697945255264"

local function hairline(parent, position, size)
	local line = new("Frame", {
		Position = position,
		Size = size,
		BackgroundColor3 = Theme.Divider,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 152,
		Parent = parent,
	})
	new("UIGradient", {
		Color = ColorSequence.new(Color3.fromRGB(255, 255, 255)),
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.8),
			NumberSequenceKeypoint.new(0.15, 0),
			NumberSequenceKeypoint.new(0.85, 0),
			NumberSequenceKeypoint.new(1, 0.8),
		}),
		Rotation = 0,
		Parent = line,
	})
	return line
end

local function pillButton(parent, spec)
	local btn = new("TextButton", {
		Position = spec.position,
		Size = spec.size,
		AnchorPoint = spec.anchor,
		BackgroundColor3 = spec.bgColor,
		BackgroundTransparency = spec.bgTransparency,
		BorderSizePixel = 0,
		Text = spec.text,
		TextColor3 = spec.textColor,
		TextSize = spec.textSize,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		FontFace = spec.font,
		AutoButtonColor = false,
		ZIndex = 152,
		Parent = parent,
	})
	Util.corner(Theme.R_Button, btn)

	if spec.bgTransparency < 1 then
		hoverFade(btn, btn, "BackgroundTransparency", spec.bgTransparency,
			math.max(spec.bgTransparency - 0.16, 0),
			math.min(spec.bgTransparency + 0.1, 1))
	end
	return btn
end

local function statusChip(parent, spec)
	local chip = new("Frame", {
		Position = UDim2.new(0, 12, 0, 46),
		Size = spec.size,
		BackgroundColor3 = Theme.Raise,
		BackgroundTransparency = spec.transparency,
		BorderSizePixel = 0,
		ZIndex = 152,
		Parent = parent,
	})
	Util.corner(Theme.R_Button, chip)
	Util.stroke(Theme.Divider, 1, spec.strokeTransparency, Enum.ApplyStrokeMode.Contextual, chip)

	local dot = new("Frame", {
		Position = UDim2.new(0, 10, 0.5, 0),
		Size = UDim2.fromOffset(6, 6),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = spec.dot,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ZIndex = 153,
		Parent = chip,
	})
	Util.corner(Theme.R_Pill, dot)

	new("TextLabel", {
		Position = UDim2.new(0, 22, 0, 0),
		Size = UDim2.new(1, -26, 1, 0),
		BackgroundTransparency = 1,
		Text = spec.text,
		TextColor3 = Theme.TextFaint,
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		FontFace = Theme.Font.Medium,
		TextTruncate = Enum.TextTruncate.None,
		ZIndex = 153,
		Parent = chip,
	})
	return chip
end

local function hideWithBody(chassis, parts)
	if not parts or #parts == 0 then return end
	local inner = chassis.setMinimized
	chassis.setMinimized = function(min)
		for _, part in ipairs(parts) do
			part.Visible = not min
		end
		inner(min)
	end
end

local function buildVCBypass(chassis)
	local body = chassis.body

	new("Frame", {
		Size = UDim2.new(1, 0, 0, 14),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 151,
		Parent = body,
	})

	hairline(body, UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 0, 1))

	local execute = pillButton(body, {
		position = UDim2.new(0, 12, 0, 8),
		size = UDim2.new(1, -62, 0, 30),
		bgColor = Theme.Raise,
		bgTransparency = 0.6,
		text = "Execute Bypass",
		textColor = Theme.Text,
		textSize = 11,
		font = Theme.Font.Bold,
	})

	execute.MouseButton1Click:Connect(function()
		if Novo.Features and Novo.Features.Mic then
			Novo.Features.Mic.run()
		end
	end)

	local mic = pillButton(chassis.frame, {
		position = UDim2.new(1, -42, 0, 42),
		size = UDim2.fromOffset(30, 30),
		bgTransparency = 1,
		text = "",
		textSize = 8,
	})
	local micIcon = new("ImageLabel", {
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(20, 20),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Image = MIC_ICON,
		ImageTransparency = 0,
		ScaleType = Enum.ScaleType.Stretch,
		ZIndex = 153,
		Parent = mic,
	})
	hoverFade(mic, micIcon, "ImageTransparency", 0, 0, 0.3)

	local F = Novo.Features
	if F and F.Mic then
		local function paint()
			local live = F.Mic.enabled and not F.Mic.muted
			Util.tween(micIcon, Util.Motion.Snap, {
				ImageColor3 = live and Theme.AccentLight or Theme.TextBright,
				ImageTransparency = F.Mic.enabled and 0 or 0.45,
			})
		end
		mic.MouseButton1Click:Connect(function()
			if F.Mic.enabled then
				F.Mic.toggleMute()
			else
				F.Mic.run()
			end
		end)
		F.Mic.changed.Event:Connect(paint)
		paint()
	end

	return { mic }
end

local function buildInvisible(chassis)
	local frame = chassis.frame

	local enable = pillButton(frame, {
		position = UDim2.new(0, 12, 0, 44),
		size = UDim2.new(1, -62, 0, 30),
		bgColor = Theme.Raise,
		bgTransparency = 0.6,
		text = "Enable",
		textColor = Theme.Text,
		textSize = 11,
		font = Theme.Font.Bold,
	})
	local keybind = pillButton(frame, {
		position = UDim2.new(1, -42, 0, 44),
		size = UDim2.fromOffset(30, 30),
		bgColor = Theme.Raise,
		bgTransparency = 0.6,
		text = ", ",
		textColor = Theme.TextFaint,
		textSize = 11,
		font = Theme.Font.Medium,
	})

	return { enable, keybind }
end

local function buildGamepass(chassis)
	local frame = chassis.frame

	local chip = statusChip(frame, {
		size = UDim2.fromOffset(140, 28),
		transparency = 0.6,
		strokeTransparency = 0.5,
		dot = Theme.Divider,
		text = "0 events",
	})

	local amount = new("TextBox", {
		Position = UDim2.new(0, 160, 0, 46),
		Size = UDim2.fromOffset(64, 28),
		BackgroundColor3 = Theme.Raise,
		BackgroundTransparency = 0.6,
		BorderSizePixel = 0,
		Text = "100",
		PlaceholderText = "100",
		PlaceholderColor3 = Theme.TextMuted,
		TextColor3 = Theme.Text,
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		FontFace = Theme.Font.Medium,
		ClearTextOnFocus = false,
		MultiLine = false,
		ZIndex = 152,
		Parent = frame,
	})
	Util.corner(Theme.R_Button, amount)

	local stop = pillButton(frame, {
		position = UDim2.new(1, -96, 0, 46),
		size = UDim2.fromOffset(76, 28),
		anchor = Vector2.new(1, 0),
		bgColor = Theme.Raise,
		bgTransparency = 0.6,
		text = "Stop",
		textColor = Theme.TextFaint,
		textSize = 11,
		font = Theme.Font.Bold,
	})
	local clear = pillButton(frame, {
		position = UDim2.new(1, -14, 0, 46),
		size = UDim2.fromOffset(72, 28),
		anchor = Vector2.new(1, 0),
		bgColor = Theme.Raise,
		bgTransparency = 0.6,
		text = "Clear",
		textColor = Theme.TextFaint,
		textSize = 11,
		font = Theme.Font.Bold,
	})

	local line = hairline(frame, UDim2.new(0, 12, 0, 80), UDim2.new(1, -24, 0, 1))

	local well = new("Frame", {
		Position = UDim2.new(0, 12, 0, 88),
		Size = UDim2.new(1, -24, 0, 322),
		BackgroundColor3 = LOG_BG,
		BackgroundTransparency = 0.6,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 152,
		Parent = frame,
	})
	Util.corner(Theme.R_Button, well)
	Util.stroke(Theme.Divider, 1, 0.6, Enum.ApplyStrokeMode.Contextual, well)

	local scroll = new("ScrollingFrame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ScrollBarThickness = 0,
		ScrollBarImageColor3 = Theme.Accent,
		ScrollBarImageTransparency = 0.6,
		ScrollingDirection = Enum.ScrollingDirection.XY,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
		VerticalScrollBarInset = Enum.ScrollBarInset.None,
		ZIndex = 152,
		Parent = well,
	})
	Util.list(Enum.FillDirection.Vertical, 5,
		Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Top, scroll)
	Util.padding(8, 8, 4, 4, scroll)

	new("TextLabel", {
		Name = "_GP_Empty",
		Size = UDim2.new(1, -8, 0, 260),
		BackgroundTransparency = 1,
		Text = "Waiting for marketplace events...\n\nProduct  -  Gamepass  -  Bulk  -  Purchase\nevents will appear here.",
		TextColor3 = Theme.TextMuted,
		TextSize = 12,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		FontFace = Theme.Font.Medium,
		TextTruncate = Enum.TextTruncate.None,
		LayoutOrder = 99999,
		ZIndex = 153,
		Parent = scroll,
	})

	return { chip, amount, stop, clear, line, well }
end

local function buildServerhop(chassis)
	local frame = chassis.frame

	local chip = statusChip(frame, {
		size = UDim2.fromOffset(148, 26),
		transparency = 0,
		strokeTransparency = 1,
		dot = Theme.TextMuted,
		text = "Idle",
	})

	local badge = new("TextLabel", {
		Position = UDim2.new(1, -12, 0, 46),
		Size = UDim2.fromOffset(100, 26),
		AnchorPoint = Vector2.new(1, 0),
		BackgroundColor3 = Theme.Accent,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		Text = "MOST",
		TextColor3 = Theme.Text,
		TextSize = 10,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		FontFace = Theme.Font.Bold,
		TextTruncate = Enum.TextTruncate.None,
		ZIndex = 152,
		Parent = frame,
	})
	Util.corner(Theme.R_Button, badge)
	Util.stroke(Theme.Accent, 1, 1, Enum.ApplyStrokeMode.Contextual, badge)

	local line = hairline(frame, UDim2.new(0, 12, 0, 78), UDim2.new(1, -24, 0, 1))

	local track = new("Frame", {
		Position = UDim2.new(0, 12, 0, 88),
		Size = UDim2.new(1, -24, 0, 3),
		BackgroundColor3 = Theme.Divider,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ZIndex = 152,
		Parent = frame,
	})
	Util.corner(Theme.R_Pill, track)

	local fill = new("Frame", {
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.new(0, 0, 1, 0),
		BackgroundColor3 = Theme.Accent,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ZIndex = 153,
		Parent = track,
	})
	Util.corner(Theme.R_Pill, fill)

	local status = new("TextLabel", {
		Position = UDim2.new(0, 12, 0, 97),
		Size = UDim2.new(1, -24, 0, 14),
		BackgroundTransparency = 1,
		Text = "",
		TextColor3 = Theme.TextMuted,
		TextSize = 10,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		FontFace = Theme.Font.Regular,
		TextTruncate = Enum.TextTruncate.None,
		ZIndex = 152,
		Parent = frame,
	})

	local again = pillButton(frame, {
		position = UDim2.new(0, 12, 0, 122),
		size = UDim2.new(1, -24, 0, 28),
		bgColor = Theme.Accent,
		bgTransparency = 0.6,
		text = "Search Again",
		textColor = Theme.Text,
		textSize = 11,
		font = Theme.Font.Bold,
	})

	return { chip, badge, line, track, status, again }
end

local SMALL_PANELS = {
	{
		key = "VCBypass",
		usesBody = true,
		name = "VCBypassPanel",
		title = "VC BYPASSER [No Xeno/Solara]",
		position = UDim2.new(0, 960, 0, 68),
		anchor = Vector2.new(0.5, 0),
		size = UDim2.fromOffset(220, 90),
		build = buildVCBypass,
	},
	{
		key = "Invisible",
		name = "InvisiblePanel",
		title = "INVISIBLE",
		position = UDim2.new(0, 960, 0, 903),
		anchor = Vector2.new(0.5, 0.75),
		size = UDim2.fromOffset(220, 90),
		build = buildInvisible,
	},
	{
		key = "Gamepass",
		name = "GamepassPanel",
		title = "GAMEPASS",
		position = UDim2.new(0, 960, 0, 542),
		anchor = Vector2.new(0.5, 0.45),
		size = UDim2.fromOffset(500, 420),
		build = buildGamepass,
	},
	{
		key = "Serverhop",
		name = "ServerhopPanel",
		title = "SERVERHOP",
		position = UDim2.new(0, 960, 0, 457),
		anchor = Vector2.new(0.5, 0.38),
		size = UDim2.fromOffset(300, 158),
		build = buildServerhop,
	},
}

for _, spec in ipairs(SMALL_PANELS) do
	Panels[spec.key] = function(parent)
		local chassis = Panels.makePanel({
			name = spec.name,
			title = spec.title,
			position = spec.position,
			anchor = spec.anchor,
			size = spec.size,
			parent = parent or Panels.host(),
		})
		if not spec.usesBody and chassis.body then
			chassis.body:Destroy()
			chassis.body = nil
		end
		hideWithBody(chassis, spec.build(chassis))
		Panels.chassis[spec.key] = chassis
		return chassis.frame
	end
	Panels.order[#Panels.order + 1] = spec.key
end
end

do
local Util  = Novo.Util
local Theme = Novo.Theme
local new   = Util.new

Novo.Panels = Novo.Panels or {}
local Panels = Novo.Panels
Panels.order   = Panels.order   or {}
Panels.chassis = Panels.chassis or {}
Panels.built   = Panels.built   or {}

local BUBBLE     = Color3.fromRGB(26, 26, 34)
local SEND_FILL  = Color3.fromRGB(18, 18, 20)

local R_BUBBLE = UDim.new(0, 9)

local ROW_ICON = "rbxassetid://81697585086530"

local ROW_ICON_REST  = 1
local ROW_ICON_HOVER = 0.2

local PANEL_SLIDE = TweenInfo.new(0.18, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)

local DIVIDER_FADE = {
	NumberSequenceKeypoint.new(0, 0.8),
	NumberSequenceKeypoint.new(0.15, 0),
	NumberSequenceKeypoint.new(0.85, 0),
	NumberSequenceKeypoint.new(1, 0.8),
}

local function tweenTo(inst, prop, value)
	Util.tween(inst, Util.Motion.Snap, { [prop] = value })
end

local function hoverProp(btn, target, prop, base, over, down)
	local hovering = false
	btn.MouseEnter:Connect(function()
		hovering = true
		tweenTo(target, prop, over)
	end)
	btn.MouseLeave:Connect(function()
		hovering = false
		tweenTo(target, prop, base)
	end)
	btn.MouseButton1Down:Connect(function() tweenTo(target, prop, down) end)
	btn.MouseButton1Up:Connect(function() tweenTo(target, prop, hovering and over or base) end)
end

local function headshot(userId)
	return string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=48&h=48", userId)
end

local MESSAGES = {
	{ u = "arcline",       t = "- 06:42", m = "hello there",                              id = 1 },
	{ u = "bluepine_",     t = "- 06:53", m = "morning",                                  id = 156 },
	{ u = "quietfox",      t = "- 07:03", m = "anyone else getting the lag spike",        id = 2 },
	{ m = "every couple of minutes" },
	{ u = "tester07",      t = "- 07:04", m = "yeah same here",                           id = 3 },
	{ m = "thought it was my end" },
	{ m = "guess not" },
	{ u = "pixelmoth",     t = "- 07:11", m = "server is pretty full right now",          id = 13 },
	{ u = "gray_owl",      t = "- 07:12", m = "that would do it",                         id = 16 },
	{ m = "give it a minute" },
	{ u = "static_hum",    t = "- 07:15", m = "who is up for a round",                    id = 18 },
	{ m = "i can host" },
	{ u = "roundabout",    t = "- 07:16", m = "in",                                       id = 261 },
	{ m = "same" },
	{ m = "count me in too" },
	{ u = "low_orbit",     t = "- 07:18", m = "give me two minutes, brb",                 id = 1 },
	{ m = "back" },
	{ u = "paper_kite",    t = "- 07:22", m = "what is the plan",                         id = 156 },
	{ u = "ember9",        t = "- 07:23", m = "same as last time, meet at the fountain",  id = 2 },
	{ u = "sandbox_ok",    t = "- 07:24", m = "on my way",                                id = 3 },
	{ u = "halfstep",      t = "- 07:25", m = "which fountain",                           id = 13 },
	{ m = "the one by the shop" },
	{ u = "wanderwire",    t = "- 07:27", m = "got it",                                   id = 16 },
	{ u = "halfstep",      t = "- 07:28", m = "thanks",                                   id = 13 },
	{ u = "nullcase",      t = "- 07:30", m = "nice run everyone",                        id = 18 },
	{ u = "halfstep",      t = "- 07:31", m = "that was close at the end",                id = 13 },
	{ m = "too close" },
	{ u = "driftwood",     t = "- 07:33", m = "one more?",                                id = 261 },
	{ m = "sure" },
	{ u = "plainsight",    t = "- 07:34", m = "give me a sec to restock",                 id = 1 },
	{ u = "opal_road",     t = "- 07:36", m = "ready when you are",                       id = 156 },
	{ u = "sunkline",      t = "- 07:37", m = "same",                                     id = 2 },
	{ u = "cadence_",      t = "- 07:38", m = "starting now",                             id = 3 },
	{ u = "greenroom",     t = "- 07:40", m = "good luck",                                id = 13 },
	{ u = "orbitfall",     t = "- 07:41", m = "you too",                                  id = 16 },
	{ u = "slowclap",      t = "- 07:43", m = "watch the left side, it is wide open",     id = 18 },
	{ u = "greenroom",     t = "- 07:44", m = "noted",                                    id = 13 },
	{ u = "mint_ok",       t = "- 07:45", m = "covering it",                              id = 261 },
	{ m = "clear" },
	{ u = "dust_devil",    t = "- 07:48", m = "that worked a lot better",                 id = 1 },
	{ u = "greenroom",     t = "- 07:49", m = "told you",                                 id = 13 },
	{ u = "echo_park",     t = "- 07:51", m = "gg",                                       id = 156 },
	{ u = "ninelives",     t = "- 07:52", m = "gg all",                                   id = 2 },
	{ m = "same time tomorrow?" },
	{ u = "waypoint7",     t = "- 07:54", m = "works for me",                             id = 3 },
	{ u = "clearsky",      t = "- 07:55", m = "i will be around",                         id = 18 },
	{ u = "waypoint7",     t = "- 07:56", m = "see you then",                             id = 3 },
	{ u = "brassband",     t = "- 07:58", m = "later",                                    id = 261 },
	{ u = "lastcall",      t = "- 08:01", m = "night everyone",                           id = 16 },
	{ m = "night" },
}

local function buildMessageRow(parent, msg, order)
	local header = msg.u ~= nil

	local row = new("Frame", {
		Name = header and "Message" or "MessageMore",
		Size = UDim2.new(1, 0, 0, header and 50 or 28),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		LayoutOrder = order,
		ZIndex = 153,
		Parent = parent,
	})

	if header then
		local ring = new("Frame", {
			Name = "AvatarRing",
			Position = UDim2.fromOffset(0, 8),
			Size = UDim2.fromOffset(26, 26),
			BackgroundColor3 = Theme.Raise,
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			ZIndex = 153,
			Parent = row,
		})
		Util.corner(Theme.R_Pill, ring)
		Util.stroke(Theme.Accent, 1, 0.6, Enum.ApplyStrokeMode.Contextual, ring)

		local avatar = new("ImageLabel", {
			Name = "Avatar",
			Position = UDim2.fromOffset(0, 8),
			Size = UDim2.fromOffset(26, 26),
			BackgroundColor3 = Theme.Raise,
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			Image = headshot(msg.id),
			ScaleType = Enum.ScaleType.Crop,
			ZIndex = 154,
			Parent = row,
		})
		Util.corner(Theme.R_Pill, avatar)

		local strip = new("Frame", {
			Name = "Meta",
			Position = UDim2.fromOffset(32, 8),
			Size = UDim2.new(1, -32, 0, 14),
			BackgroundTransparency = 1,
			ClipsDescendants = true,
			ZIndex = 154,
			Parent = row,
		})
		Util.list(Enum.FillDirection.Horizontal, 3,
			Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center, strip)

		new("TextLabel", {
			Name = "User",
			Size = UDim2.new(0, 0, 1, 0),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			Text = msg.u,
			TextColor3 = Theme.Accent,
			TextSize = 10,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			FontFace = Theme.Font.Bold,
			TextTruncate = Enum.TextTruncate.AtEnd,
			LayoutOrder = 1,
			ZIndex = 155,
			Parent = strip,
		})
		new("TextLabel", {
			Name = "Time",
			Size = UDim2.new(0, 0, 1, 0),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			Text = msg.t,
			TextColor3 = Theme.TextMuted,
			TextSize = 10,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			FontFace = Theme.Font.Medium,
			TextTruncate = Enum.TextTruncate.None,
			LayoutOrder = 3,
			ZIndex = 155,
			Parent = strip,
		})
	end

	local bubble = new("Frame", {
		Name = "Bubble",
		Position = UDim2.fromOffset(32, header and 24 or 2),
		Size = UDim2.fromOffset(218, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = BUBBLE,
		BackgroundTransparency = 0.55,
		BorderSizePixel = 0,
		ZIndex = 154,
		Parent = row,
	})
	Util.corner(R_BUBBLE, bubble)
	Util.stroke(Theme.Divider, 1, 0.65, Enum.ApplyStrokeMode.Contextual, bubble)
	Util.padding(6, 6, 9, 9, bubble)

	new("TextLabel", {
		Name = "Body",
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Text = msg.m,
		TextColor3 = Theme.TextBright,
		TextSize = 12,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		FontFace = Theme.Font.Medium,
		TextTruncate = Enum.TextTruncate.None,
		ZIndex = 155,
		Parent = bubble,
	})

	local action = new("ImageButton", {
		Name = "RowAction",
		Position = UDim2.new(1, -2, 0, header and 30 or 8),
		Size = UDim2.fromOffset(14, 14),
		AnchorPoint = Vector2.new(1, 0),
		BackgroundTransparency = 1,
		Image = ROW_ICON,
		ImageColor3 = Theme.TextMuted,
		ImageTransparency = ROW_ICON_REST,
		ScaleType = Enum.ScaleType.Fit,
		AutoButtonColor = false,
		ZIndex = 157,
		Parent = row,
	})

	row.MouseEnter:Connect(function()
		tweenTo(action, "ImageTransparency", ROW_ICON_HOVER)
	end)
	row.MouseLeave:Connect(function()
		tweenTo(action, "ImageTransparency", ROW_ICON_REST)
	end)

	return row
end

local function divider(parent, y, zindex)
	local line = new("Frame", {
		Name = "Divider",
		Position = UDim2.fromOffset(12, y),
		Size = UDim2.new(1, -24, 0, 1),
		BackgroundColor3 = Theme.Divider,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = zindex,
		Parent = parent,
	})
	new("UIGradient", {
		Color = ColorSequence.new(Color3.fromRGB(255, 255, 255)),
		Transparency = NumberSequence.new(DIVIDER_FADE),
		Rotation = 0,
		Parent = line,
	})
	return line
end

local function buildChatBody(chassis)
	local frame = chassis.frame

	local status = new("Frame", {
		Name = "StatusRow",
		Position = UDim2.fromOffset(12, 48),
		Size = UDim2.new(1, -24, 0, 26),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = Theme.T_Card,
		BorderSizePixel = 0,
		ZIndex = 152,
		Parent = frame,
	})
	Util.corner(Theme.R_Button, status)
	Util.stroke(Theme.StrokeSoft, 1, Theme.T_StrokeSoft, Enum.ApplyStrokeMode.Contextual, status)

	local dot = new("Frame", {
		Name = "Dot",
		Position = UDim2.new(0, 10, 0.5, 0),
		Size = UDim2.fromOffset(6, 6),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Theme.AccentLight,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ZIndex = 153,
		Parent = status,
	})
	Util.corner(Theme.R_Pill, dot)

	local statusText = new("TextLabel", {
		Name = "StatusText",
		Position = UDim2.fromOffset(22, 0),
		Size = UDim2.new(1, -26, 1, 0),
		BackgroundTransparency = 1,
		Text = "Connected",
		TextColor3 = Theme.TextFaint,
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		FontFace = Theme.Font.Medium,
		TextTruncate = Enum.TextTruncate.None,
		ZIndex = 153,
		Parent = status,
	})

	local topLine = divider(frame, 82, 162)

	local scroll = new("ScrollingFrame", {
		Name = "ChatMsgScroll",
		Position = UDim2.fromOffset(0, 88),
		Size = UDim2.new(1, 0, 0, 351),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Visible = false,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ScrollBarThickness = 0,
		ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
		ScrollBarImageTransparency = 0,
		ScrollingDirection = Enum.ScrollingDirection.XY,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
		VerticalScrollBarInset = Enum.ScrollBarInset.None,
		ZIndex = 152,
		Parent = frame,
	})
	Util.list(Enum.FillDirection.Vertical, 2,
		Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Top, scroll)
	Util.padding(8, 8, 10, 10, scroll)

	for i, msg in ipairs(MESSAGES) do
		buildMessageRow(scroll, msg, i)
	end

	local bottomLine = divider(frame, 443, 152)

	local inputBox = new("Frame", {
		Name = "InputBox",
		Position = UDim2.fromOffset(12, 452),
		Size = UDim2.new(1, -58, 0, 30),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = Theme.T_Card,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 152,
		Parent = frame,
	})
	Util.corner(R_BUBBLE, inputBox)
	Util.stroke(Theme.StrokeSoft, 1, Theme.T_StrokeSoft, Enum.ApplyStrokeMode.Contextual, inputBox)

	local entry = new("TextBox", {
		Name = "Entry",
		Position = UDim2.fromOffset(10, 0),
		Size = UDim2.new(1, -26, 1, 0),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		Text = "",
		PlaceholderText = "Message... or :assetid: for image",
		PlaceholderColor3 = Theme.TextMuted,
		TextColor3 = Theme.Text,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		FontFace = Theme.Font.Medium,
		ClearTextOnFocus = false,
		MultiLine = false,
		ZIndex = 153,
		Parent = inputBox,
	})

	local send = new("ImageButton", {
		Name = "SendBtn",
		Position = UDim2.new(1, -12, 0, 452),
		Size = UDim2.fromOffset(30, 30),
		AnchorPoint = Vector2.new(1, 0),
		BackgroundColor3 = SEND_FILL,
		BackgroundTransparency = 0.6,
		BorderSizePixel = 0,
		Image = "",
		ScaleType = Enum.ScaleType.Stretch,
		AutoButtonColor = false,
		ZIndex = 153,
		Parent = frame,
	})
	Util.corner(R_BUBBLE, send)
	Util.stroke(Theme.Divider, 1, 0.5, Enum.ApplyStrokeMode.Contextual, send)
	hoverProp(send, send, "BackgroundTransparency", 0.6, 0.44, 0.7)

	chassis.status = status
	chassis.statusDot = dot
	chassis.statusText = statusText
	chassis.scroll = scroll
	chassis.entry = entry
	chassis.sendBtn = send

	local bands = { status, topLine, scroll, bottomLine, inputBox, send }
	if chassis.body then
		chassis.body:Destroy()
		chassis.body = nil
	end

	local hidden = {}
	function chassis.setMinimized(min)
		chassis.minimized = min
		if min then
			chassis.fullSize = frame.Size
			for _, band in ipairs(bands) do
				hidden[band] = band.Visible
				band.Visible = false
			end
			chassis.resizeHandle.Visible = false
			chassis.resizeGrip.Visible = false
			Util.tween(frame, Util.Motion.Quick,
				{ Size = UDim2.new(frame.Size.X.Scale, frame.Size.X.Offset, 0, 34) })
		else
			for _, band in ipairs(bands) do
				band.Visible = hidden[band] ~= false
			end
			chassis.resizeHandle.Visible = true
			chassis.resizeGrip.Visible = true
			Util.tween(frame, Util.Motion.Quick, { Size = chassis.fullSize })
		end
	end

	local baseSetOpen = chassis.setOpen
	function chassis.setOpen(open, instant)
		if open then scroll.Visible = true end
		baseSetOpen(open, instant)
	end

	return frame
end

Panels.Chat = function(parent)
	local chassis = Panels.makePanel({
		name = "ChatPanel",
		title = "CHAT",
		position = UDim2.new(0, 960, 0, 457),
		anchor = Vector2.new(0.5, 0.38),
		size = UDim2.fromOffset(300, 492),
		parent = parent or Panels.host(),
	})
	chassis.frame.ClipsDescendants = true
	buildChatBody(chassis)
	Panels.chassis.Chat = chassis
	return chassis.frame
end
Panels.order[#Panels.order + 1] = "Chat"
end

do
do
	local Util  = Novo.Util
	local Theme = Novo.Theme
	local new   = Util.new

	Novo.Panels = Novo.Panels or {}
	local Panels = Novo.Panels
	Panels.order   = Panels.order   or {}
	Panels.chassis = Panels.chassis or {}

	local SLIDE = TweenInfo.new(0.18, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
	local SNAP  = Util.Motion.Snap

	local PANEL_SIZE = UDim2.fromOffset(280, 264)
	local PANEL_H    = 264
	local CARD_H     = 190
	local ROW_H      = 38

	local SHINE_FILL = 0.84

	local SWITCH_ON = {
		thumbX = 33,
		gradient = ColorSequence.new(Color3.fromRGB(91, 160, 245), Color3.fromRGB(29, 67, 147)),
		glow = 0.28,
	}
	local SWITCH_OFF = {
		thumbX = 15,
		gradient = ColorSequence.new(Color3.fromRGB(40, 40, 44), Theme.Panel),
		glow = 0.94,
	}

	local SWITCH_ROWS = {
		{ label = "ESP",         on = false, option = "Enabled" },
		{ label = "Chams",       on = false, option = "Chams" },
		{ label = "Hitboxes",    on = false, option = "Hitboxes" },
		{ label = "Team Colors", on = false, option = "TeamColors" },
	}

	local TEAM_ROWS = {
		{ label = "No Team", on = false, option = "HideTeams" },
	}

	local TEAMS_H = #TEAM_ROWS * ROW_H

	local function accentGlow(parent, transparency)
		local ok, shadow = pcall(Instance.new, "UIShadow")
		if not ok or not shadow then return nil end
		shadow.Color = Theme.Accent
		shadow.Transparency = transparency
		pcall(function() shadow.Offset = UDim2.fromOffset(0, 0) end)
		pcall(function() shadow.Spread = UDim2.fromOffset(0, 0) end)
		shadow.Enabled = true
		shadow.Parent = parent
		return shadow
	end

	local function hoverFade(btn, target, prop, base, over, down)
		local hovering = false
		local function to(v)
			Util.tween(target, SNAP, { [prop] = v })
		end
		btn.MouseEnter:Connect(function()
			hovering = true
			to(over)
		end)
		btn.MouseLeave:Connect(function()
			hovering = false
			to(base)
		end)
		btn.MouseButton1Down:Connect(function() to(down) end)
		btn.MouseButton1Up:Connect(function() to(hovering and over or base) end)
	end

	local function rowLabel(parent, text, zindex, truncate)
		return new("TextLabel", {
			Position = UDim2.new(0, 16, 0.5, 0),
			Size = UDim2.new(0.6, -20, 1, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundTransparency = 1,
			Text = text,
			TextColor3 = Theme.Text,
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
			FontFace = Theme.Font.Medium,
			TextTruncate = truncate,
			ZIndex = zindex,
			Parent = parent,
		})
	end

	local function hitButton(parent, zindex)
		return new("TextButton", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Text = "",
			TextSize = 8,
			AutoButtonColor = true,
			ZIndex = zindex,
			Parent = parent,
		})
	end

	local function rowDivider(parent, zindex)
		return new("Frame", {
			Position = UDim2.new(0, 16, 1, -1),
			Size = UDim2.new(1, -32, 0, 1),
			AnchorPoint = Vector2.new(0, 1),
			BackgroundColor3 = Theme.Divider,
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			Visible = false,
			ZIndex = zindex,
			Parent = parent,
		})
	end

	local function buildSwitch(parent, on, trackZ, thumbZ)
		local track = new("Frame", {
			Name = "SwitchTrack",
			Position = UDim2.new(1, -14, 0.5, 0),
			Size = UDim2.fromOffset(48, 22),
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundColor3 = Theme.PanelDeep,
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			ZIndex = trackZ,
			Parent = parent,
		})
		Util.corner(Theme.R_Pill, track)
		Util.stroke(Color3.fromRGB(18, 18, 20), 1, 0.45, Enum.ApplyStrokeMode.Contextual, track)

		local art = on and SWITCH_ON or SWITCH_OFF

		local thumb = new("Frame", {
			Name = "SwitchThumb",
			Position = UDim2.new(0, art.thumbX, 0.5, 0),
			Size = UDim2.fromOffset(26, 18),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Theme.TextBright,
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			ZIndex = thumbZ,
			Parent = track,
		})
		Util.corner(Theme.R_Pill, thumb)

		local gradient = new("UIGradient", {
			Color = art.gradient,
			Transparency = NumberSequence.new(0, 0),
			Rotation = 90,
			Offset = Vector2.new(0, 0),
			Enabled = true,
			Parent = thumb,
		})
		local glow = accentGlow(thumb, art.glow)
		local scale = new("UIScale", { Scale = 1, Parent = track })

		local state = on

		return {
			track = track,
			thumb = thumb,
			toggle = function()
				state = not state
				local nextArt = state and SWITCH_ON or SWITCH_OFF
				gradient.Color = nextArt.gradient
				Util.tween(thumb, SNAP, { Position = UDim2.new(0, nextArt.thumbX, 0.5, 0) })
				if glow then
					Util.tween(glow, SNAP, { Transparency = nextArt.glow })
				end
			end,
			press = function(down)
				Util.tween(scale, SNAP, { Scale = down and 0.92 or 1 })
			end,
		}
	end

	local function switchRow(parent, spec)
		local row = new("Frame", {
			Position = UDim2.fromOffset(0, spec.y or 0),
			Size = UDim2.new(1, 0, 0, ROW_H),
			BackgroundTransparency = 1,
			LayoutOrder = spec.layoutOrder or 0,
			ZIndex = spec.z,
			Parent = parent,
		})

		rowLabel(row, spec.label, spec.z + 1, spec.truncate)
		local sw = buildSwitch(row, spec.on, spec.z + 1, spec.z + 3)
		local hit = hitButton(row, spec.z + 3)
		if spec.divider then
			rowDivider(row, spec.z + 1)
		end

		local state = spec.on

		hit.MouseButton1Click:Connect(function()
			sw.toggle()
			state = not state
			if spec.option and Novo.Features and Novo.Features.Esp then
				Novo.Features.Esp.setOption(spec.option, state)
			end
		end)
		hit.MouseButton1Down:Connect(function() sw.press(true) end)
		hit.MouseButton1Up:Connect(function() sw.press(false) end)
		hit.MouseLeave:Connect(function() sw.press(false) end)
		return row, sw
	end

	local function buildBody(chassis)
		local frame = chassis.frame

		local card = new("Frame", {
			Position = UDim2.fromOffset(12, 50),
			Size = UDim2.new(1, -24, 0, CARD_H),
			BackgroundColor3 = Theme.Raise,
			BackgroundTransparency = 0.6,
			BorderSizePixel = 0,
			ZIndex = 152,
			Parent = frame,
		})
		Util.corner(Theme.R_Button, card)
		Util.stroke(Theme.Divider, 1, 0.55, Enum.ApplyStrokeMode.Contextual, card)

		for i, spec in ipairs(SWITCH_ROWS) do
			switchRow(card, {
				y = (i - 1) * ROW_H,
				label = spec.label,
				on = spec.on,
				option = spec.option,
				z = 152,
				truncate = Enum.TextTruncate.None,
				divider = true,
			})
		end

		local hideTeams = new("Frame", {
			Name = "HideTeams",
			Position = UDim2.fromOffset(0, #SWITCH_ROWS * ROW_H),
			Size = UDim2.new(1, 0, 0, ROW_H),
			BackgroundTransparency = 1,
			ClipsDescendants = true,
			ZIndex = 160,
			Parent = card,
		})

		local header = new("Frame", {
			Position = UDim2.fromOffset(0, 0),
			Size = UDim2.new(1, 0, 0, ROW_H),
			BackgroundTransparency = 1,
			ZIndex = 160,
			Parent = hideTeams,
		})
		rowLabel(header, "Hide Teams", 161, Enum.TextTruncate.None)

		local chevronBtn = new("TextButton", {
			Position = UDim2.new(1, -14, 0.5, 0),
			Size = UDim2.fromOffset(22, 22),
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Text = "",
			TextSize = 8,
			AutoButtonColor = false,
			ZIndex = 162,
			Parent = header,
		})
		local chevron = new("ImageLabel", {
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(13, 13),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			Image = Theme.Icon.Minimize,
			ImageTransparency = 0.45,
			ScaleType = Enum.ScaleType.Stretch,
			ZIndex = 163,
			Parent = chevronBtn,
		})
		hoverFade(chevronBtn, chevron, "ImageTransparency", 0.45, 0.1, 0.3)

		local headerHit = hitButton(header, 164)

		local teams = new("ScrollingFrame", {
			Position = UDim2.fromOffset(0, ROW_H),
			Size = UDim2.new(1, 0, 0, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			CanvasSize = UDim2.new(0, 0, 0, TEAMS_H),
			ScrollBarThickness = 3,
			ScrollBarImageColor3 = Theme.Accent,
			ScrollBarImageTransparency = 0,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			AutomaticCanvasSize = Enum.AutomaticSize.None,
			ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
			VerticalScrollBarInset = Enum.ScrollBarInset.None,
			ZIndex = 161,
			Parent = hideTeams,
		})
		Util.list(Enum.FillDirection.Vertical, 0,
			Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Top, teams)

		for i, spec in ipairs(TEAM_ROWS) do
			switchRow(teams, {
				label = spec.label,
				on = spec.on,
				option = spec.option,
				z = 162,
				truncate = Enum.TextTruncate.AtEnd,
				divider = false,
				layoutOrder = i,
			})
		end

		local expanded = false

		local function setExpanded(open, instant)
			expanded = open
			local grow = open and TEAMS_H or 0
			local width = frame.Size.X.Offset
			local panelGoal = UDim2.new(0, width, 0, PANEL_H + grow)
			local goals = {
				{ teams,     { Size = UDim2.new(1, 0, 0, grow) } },
				{ hideTeams, { Size = UDim2.new(1, 0, 0, ROW_H + grow) } },
				{ card,      { Size = UDim2.new(1, -24, 0, CARD_H + grow) } },
				{ frame,     { Size = panelGoal } },
				{ chevron,   { Rotation = open and 180 or 0 } },
			}
			for _, g in ipairs(goals) do
				if instant then
					for prop, value in pairs(g[2]) do
						g[1][prop] = value
					end
				else
					Util.tween(g[1], SLIDE, g[2])
				end
			end
			chassis.fullSize = panelGoal
		end

		headerHit.MouseButton1Click:Connect(function()
			setExpanded(not expanded)
		end)
		chevronBtn.MouseButton1Click:Connect(function()
			setExpanded(not expanded)
		end)

		local chassisMinimize = chassis.setMinimized
		function chassis.setMinimized(min)
			card.Visible = not min
			chassisMinimize(min)
		end

		chassis.card = card
		chassis.hideTeams = hideTeams
		chassis.teams = teams
		chassis.setExpanded = setExpanded
		return card
	end

	Novo.Panels.Esp = function(parent)
		local chassis = Panels.makePanel({
			name = "EspPanel",
			title = "ESP",
			position = UDim2.new(0, 1255, 0, 336),
			anchor = Vector2.new(0, 0),
			size = PANEL_SIZE,
			parent = parent or Panels.host(),
		})
		chassis.shine.Fill.BackgroundTransparency = SHINE_FILL
		if chassis.body then
			chassis.body:Destroy()
			chassis.body = nil
		end
		buildBody(chassis)
		Panels.chassis.Esp = chassis
		return chassis.frame
	end
	Panels.order[#Panels.order + 1] = "Esp"
end
end

do
local Util  = Novo.Util
local Theme = Novo.Theme
local new   = Util.new

local CmdBar = {}
Novo.CmdBar = CmdBar

local BAR_W, BAR_H       = 580, 43
local SHADOW_W, SHADOW_H = 627, 90
local BAR_Y              = 0.82
local LIST_GAP           = 26

local ROW_H     = 38
local ROW_INSET = 4
local MAX_ROWS  = 5

local STROKE       = Color3.fromRGB(72, 72, 78)
local T_STROKE     = 0.5
local ICON_TINT    = Color3.fromRGB(150, 150, 150)
local PLACEHOLDER  = Color3.fromRGB(80, 80, 90)
local T_ROW_HOVER  = 0.95
local T_SHADOW     = 0.75

local GROW = TweenInfo.new(0.18, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
local FADE = TweenInfo.new(0.20, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

local TOGGLE_KEY = Enum.KeyCode.F6

local SUGGESTIONS = {
	{ name = "togglefly [tf]",                  desc = "Toggle fly on/off" },
	{ name = "speed [ws, walkspeed] <n>",       desc = "Set walk speed" },
	{ name = "reanim",                          desc = "Open reanim animations panel" },
	{ name = "aimbot [aim]",                    desc = "Open Aimbot panel" },
	{ name = "airwalk [aw]",                    desc = "Walk on air (Space to go up)" },
	{ name = "anim [ani] <s>",                  desc = "Play animation by name or ID" },
	{ name = "animlogger [al]",                 desc = "Toggle animation spy logger" },
	{ name = "antiafk [aafk]",                  desc = "Prevent AFK kick" },
	{ name = "antifling [af]",                  desc = "Disable others' collision" },
	{ name = "antikick [ak]",                   desc = "Client-side anti-kick hook" },
	{ name = "antiteleport [at]",               desc = "Block TeleportService from moving you" },
	{ name = "attach [att] <p>",                desc = "Weld yourself to a player" },
	{ name = "backpack [bp] <p>",               desc = "Ride on player's back" },
	{ name = "autoexecute [ae] <s>",            desc = "Toggle a command on/off the auto-run list" },
	{ name = "vcbypasser [vcb]",                desc = "Open VC bypasser panel" },
	{ name = "adonisbypass [adonis, ab]",       desc = "Bypass Adonis admin detection" },
}

local function makeRow(parent, entry, order, onPick)
	local row = new("TextButton", {
		Name = "Row",
		Size = UDim2.new(1, 0, 0, ROW_H),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Text = "",
		TextSize = 8,
		LayoutOrder = order,
		ZIndex = 7,
		Parent = parent,
	})
	Util.corner(Theme.R_Button, row)

	new("TextLabel", {
		Name = "Title",
		Position = UDim2.fromOffset(10, 5),
		Size = UDim2.new(1, -84, 0, 16),
		BackgroundTransparency = 1,
		Text = entry.name,
		TextColor3 = Theme.Text,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextTruncate = Enum.TextTruncate.AtEnd,
		FontFace = Theme.Font.Bold,
		ZIndex = 8,
		Parent = row,
	})

	new("TextLabel", {
		Name = "Desc",
		Position = UDim2.fromOffset(10, 22),
		Size = UDim2.new(1, -84, 0, 12),
		BackgroundTransparency = 1,
		Text = entry.desc,
		TextColor3 = Theme.TextMuted,
		TextSize = 10,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextTruncate = Enum.TextTruncate.AtEnd,
		FontFace = Theme.Font.Medium,
		ZIndex = 8,
		Parent = row,
	})

	row.MouseEnter:Connect(function()
		Util.tween(row, Util.Motion.Snap, { BackgroundTransparency = T_ROW_HOVER })
	end)
	row.MouseLeave:Connect(function()
		Util.tween(row, Util.Motion.Snap, { BackgroundTransparency = 1 })
	end)
	row.MouseButton1Click:Connect(function()
		onPick(entry)
	end)

	return row
end

local listToken = 0
local function setListHeight(height)
	local outer = CmdBar.outer
	if not outer then return end
	listToken += 1
	local mine = listToken
	if height > 0 then
		outer.Visible = true
		Util.tween(outer, GROW, { Size = UDim2.fromOffset(BAR_W, height) })
	else
		local t = Util.tween(outer, GROW, { Size = UDim2.fromOffset(BAR_W, 0) })
		t.Completed:Connect(function()
			if listToken == mine then
				outer.Visible = false
			end
		end)
	end
end

local function pick(entry)
	local word = string.match(entry.name, "^%S+") or entry.name
	CmdBar.box.Text = word .. " "
	CmdBar.box.CursorPosition = #CmdBar.box.Text + 1
	CmdBar.box:CaptureFocus()
end

local function matches(entry, query)
	if query == "" then return true end
	return string.find(string.lower(entry.name), query, 1, true) ~= nil
		or string.find(string.lower(entry.desc), query, 1, true) ~= nil
end

function CmdBar.refresh()
	local scroll = CmdBar.scroll
	if not scroll then return end

	for _, child in ipairs(scroll:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end

	local query = string.lower((string.gsub(CmdBar.box.Text, "^%s+", "")))
	local shown = 0
	for _, entry in ipairs(SUGGESTIONS) do
		if matches(entry, query) then
			shown += 1
			makeRow(scroll, entry, shown, pick)
		end
	end
	scroll.CanvasPosition = Vector2.new(0, 0)

	if not CmdBar.opened or shown == 0 then
		setListHeight(0)
	else
		setListHeight(math.min(shown, MAX_ROWS) * ROW_H + ROW_INSET * 2)
	end
end

local barToken = 0

function CmdBar.open()
	if CmdBar.opened or not CmdBar.bar then return end
	CmdBar.opened = true
	barToken += 1

	CmdBar.shadowFrame.Visible = true
	CmdBar.shadow.ImageTransparency = 1
	Util.tween(CmdBar.shadow, FADE, { ImageTransparency = T_SHADOW })

	CmdBar.bar.Size = UDim2.fromOffset(BAR_W, 0)
	CmdBar.bar.Visible = true
	Util.tween(CmdBar.bar, GROW, { Size = UDim2.fromOffset(BAR_W, BAR_H) })

	CmdBar.icon.ImageTransparency = 1
	CmdBar.box.TextTransparency = 1
	Util.tween(CmdBar.icon, FADE, { ImageTransparency = 0 })
	Util.tween(CmdBar.box, FADE, { TextTransparency = 0 })

	CmdBar.box.Text = ""
	CmdBar.box:CaptureFocus()
	CmdBar.refresh()
end

function CmdBar.close()
	if not CmdBar.opened or not CmdBar.bar then return end
	CmdBar.opened = false
	barToken += 1
	local mine = barToken

	CmdBar.box:ReleaseFocus()
	Util.tween(CmdBar.icon, FADE, { ImageTransparency = 1 })
	Util.tween(CmdBar.box, FADE, { TextTransparency = 1 })
	Util.tween(CmdBar.shadow, FADE, { ImageTransparency = 1 })

	local shrink = Util.tween(CmdBar.bar, GROW, { Size = UDim2.fromOffset(BAR_W, 0) })
	shrink.Completed:Connect(function()
		if barToken ~= mine then return end
		CmdBar.bar.Visible = false
		CmdBar.bar.Size = UDim2.fromOffset(BAR_W, BAR_H)
		CmdBar.shadowFrame.Visible = false
	end)

	setListHeight(0)
end

function CmdBar.toggle()
	if CmdBar.opened then
		CmdBar.close()
	else
		CmdBar.open()
	end
end

function CmdBar.build()
	local screen = new("ScreenGui", {
		Name = "NovoCmdBar",
		DisplayOrder = 60,
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	})
	Novo.Guis[#Novo.Guis + 1] = screen

	local shadowFrame = new("Frame", {
		Name = "ShadowFrame",
		Position = UDim2.new(0.5, 0, BAR_Y, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromOffset(SHADOW_W, SHADOW_H),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 3,
		Parent = screen,
	})

	local shadow = new("ImageLabel", {
		Name = "Shadow",
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Image = Theme.Shadow,
		ImageColor3 = Color3.new(0, 0, 0),
		ImageTransparency = 1,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Theme.ShadowSlice,
		SliceScale = 1,
		ZIndex = 3,
		Parent = shadowFrame,
	})

	local bar = new("Frame", {
		Name = "CmdBar",
		Position = UDim2.new(0.5, 0, BAR_Y, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromOffset(BAR_W, BAR_H),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 5,
		Parent = screen,
	})
	Util.corner(Theme.R_Button, bar)

	local shine = Util.surfaceShine(bar, UDim2.fromScale(1, 1), Theme.R_Button, 0.88,
		{
			NumberSequenceKeypoint.new(0, 0.22),
			NumberSequenceKeypoint.new(0.55, 0.78),
			NumberSequenceKeypoint.new(1, 1),
		}, 11)
	shine.Fill.Size = UDim2.new(1, 0, 0, 6)

	Util.frostedBacking(bar, Theme.R_Button, Theme.T_Overlay)
	Util.stroke(STROKE, 1, T_STROKE, Enum.ApplyStrokeMode.Border, bar)

	local icon = new("ImageLabel", {
		Name = "Icon",
		Position = UDim2.new(0, 24, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromOffset(26, 26),
		BackgroundTransparency = 1,
		Image = Theme.Icon.Home,
		ImageColor3 = ICON_TINT,
		ImageTransparency = 1,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 12,
		Parent = bar,
	})

	local box = new("TextBox", {
		Name = "SearchBox",
		Position = UDim2.fromOffset(48, 0),
		Size = UDim2.new(1, -56, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		PlaceholderText = "Type a command...",
		PlaceholderColor3 = PLACEHOLDER,
		TextColor3 = ICON_TINT,
		TextSize = 15,
		TextTransparency = 1,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		FontFace = Theme.Font.Medium,
		ClearTextOnFocus = false,
		MultiLine = false,
		ZIndex = 12,
		Parent = bar,
	})

	local outer = new("Frame", {
		Name = "SugOuter",
		Position = UDim2.new(0.5, 0, BAR_Y, -LIST_GAP),
		AnchorPoint = Vector2.new(0.5, 1),
		Size = UDim2.fromOffset(BAR_W, 0),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Visible = false,
		ZIndex = 5,
		Parent = screen,
	})
	Util.corner(Theme.R_Button, outer)
	Util.frostedBacking(outer, Theme.R_Button, Theme.T_Overlay)
	Util.stroke(STROKE, 1, T_STROKE, Enum.ApplyStrokeMode.Border, outer)

	local scroll = new("ScrollingFrame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ScrollBarThickness = 0,
		ScrollBarImageTransparency = 1,
		ScrollingDirection = Enum.ScrollingDirection.XY,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
		VerticalScrollBarInset = Enum.ScrollBarInset.None,
		ZIndex = 6,
		Parent = outer,
	})
	Util.list(Enum.FillDirection.Vertical, 0,
		Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Top, scroll)
	Util.padding(ROW_INSET, ROW_INSET, ROW_INSET, ROW_INSET, scroll)

	CmdBar.screen = screen
	CmdBar.shadowFrame = shadowFrame
	CmdBar.shadow = shadow
	CmdBar.bar = bar
	CmdBar.icon = icon
	CmdBar.box = box
	CmdBar.outer = outer
	CmdBar.scroll = scroll
	CmdBar.opened = false

	box:GetPropertyChangedSignal("Text"):Connect(function()
		if CmdBar.opened then
			CmdBar.refresh()
		end
	end)
	box.FocusLost:Connect(function()
		CmdBar.close()
	end)

	UserInputService.InputBegan:Connect(function(input, typing)
		if typing then return end
		if input.KeyCode == TOGGLE_KEY then
			CmdBar.toggle()
		end
	end)

	return screen
end
end

do
local Util  = Novo.Util
local Theme = Novo.Theme
local new   = Util.new

Novo.Notify = {}
local Notify = Novo.Notify

local CARD_W       = 300
local TEXT_LEFT    = 56
local TEXT_W       = CARD_W - 72
local TITLE_Y      = 12
local TITLE_H      = 17
local BODY_Y       = 31
local BODY_MIN_H   = 28
local BOTTOM_PAD   = 13

local CARD_RADIUS  = UDim.new(0, 18)
local BODY_COLOR   = Color3.fromRGB(178, 178, 186)

local SHADOW_IMG   = "rbxassetid://3523728077"
local SHADOW_SLICE = Rect.new(50, 50, 50, 50)

local GROW = TweenInfo.new(0.30, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local FADE = TweenInfo.new(0.20, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local SHUT = TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.In)

local container

local function measureBody(text)
	local ok, size = pcall(function()
		return TextService:GetTextSize(text, 14, Enum.Font.Gotham, Vector2.new(TEXT_W, 10000))
	end)
	if not ok or not size then return BODY_MIN_H end
	return math.max(BODY_MIN_H, math.ceil(size.Y))
end

function Notify.build()
	local screen = new("ScreenGui", {
		Name = "NovoNotify",
		DisplayOrder = 60,
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	})
	Novo.Guis[#Novo.Guis + 1] = screen

	container = new("Frame", {
		Name = "NotifyContainer",
		Position = UDim2.new(1, -316, 0, 16),
		Size = UDim2.new(0, CARD_W, 1, -16),
		BackgroundTransparency = 1,
		ZIndex = 200,
		Parent = screen,
	})
	Util.list(Enum.FillDirection.Vertical, 8, nil, nil, container)
	return screen
end

function Notify.push(title, body, duration)
	if not container then return end
	title = tostring(title or "Novoline")
	body = tostring(body or "")
	duration = duration or 5

	local bodyH = measureBody(body)
	local height = BODY_Y + bodyH + BOTTOM_PAD

	local card = new("Frame", {
		Name = "Notification",
		Size = UDim2.new(1, 0, 0, 0),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 200,
		Parent = container,
	})
	Util.corner(CARD_RADIUS, card)

	local wallpaper = new("ImageLabel", {
		Name = "Wallpaper",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Image = Theme.Wallpaper,
		ImageTransparency = 1,
		ScaleType = Enum.ScaleType.Crop,
		ZIndex = 200,
		Parent = card,
	})
	Util.corner(CARD_RADIUS, wallpaper)

	local wash = new("Frame", {
		Name = "WpOverlay",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Theme.PanelDeep,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 201,
		Parent = card,
	})
	Util.corner(CARD_RADIUS, wash)

	local stroke = Util.stroke(Theme.TextBright, 1, 1, Enum.ApplyStrokeMode.Contextual, card)

	local shine = new("CanvasGroup", {
		Name = "SurfaceShine",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		GroupTransparency = 1,
		ZIndex = 201,
		Parent = card,
	})
	Util.corner(CARD_RADIUS, shine)
	local fill = new("Frame", {
		Name = "Fill",
		Size = UDim2.new(1, 0, 0, 6),
		BackgroundColor3 = Theme.TextBright,
		BackgroundTransparency = 0.86,
		BorderSizePixel = 0,
		ZIndex = 1,
		Parent = shine,
	})
	new("UIGradient", {
		Color = ColorSequence.new(Color3.new(1, 1, 1)),
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.22),
			NumberSequenceKeypoint.new(0.55, 0.78),
			NumberSequenceKeypoint.new(1, 1),
		}),
		Parent = fill,
	})

	local shadow = new("ImageLabel", {
		Name = "Shadow",
		Position = UDim2.fromOffset(-15, -15),
		Size = UDim2.new(1, 30, 1, 30),
		BackgroundTransparency = 1,
		Image = SHADOW_IMG,
		ImageColor3 = Color3.new(0, 0, 0),
		ImageTransparency = 1,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = SHADOW_SLICE,
		ZIndex = 199,
		Parent = card,
	})

	local icon = new("ImageLabel", {
		Name = "Icon",
		Position = UDim2.new(0, 18, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.fromOffset(24, 24),
		BackgroundTransparency = 1,
		Image = Theme.Icon.Commands,
		ImageTransparency = 1,
		ScaleType = Enum.ScaleType.Stretch,
		ZIndex = 202,
		Parent = card,
	})

	local titleLabel = new("TextLabel", {
		Position = UDim2.fromOffset(TEXT_LEFT, TITLE_Y),
		Size = UDim2.new(1, -72, 0, TITLE_H),
		BackgroundTransparency = 1,
		Text = title,
		TextColor3 = Theme.Text,
		TextTransparency = 1,
		TextSize = 14,
		FontFace = Theme.Font.Medium,
		RichText = true,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		ZIndex = 202,
		Parent = card,
	})

	local bodyLabel = new("TextLabel", {
		Position = UDim2.fromOffset(TEXT_LEFT, BODY_Y),
		Size = UDim2.new(1, -72, 0, bodyH),
		BackgroundTransparency = 1,
		Text = body,
		TextColor3 = BODY_COLOR,
		TextTransparency = 1,
		TextSize = 14,
		FontFace = Theme.Font.Regular,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		ZIndex = 202,
		Parent = card,
	})

	Util.tween(card, GROW, { Size = UDim2.new(1, 0, 0, height) })
	Util.tween(card, FADE, { BackgroundTransparency = 0 })
	Util.tween(wallpaper, FADE, { ImageTransparency = 0 })
	Util.tween(wash, FADE, { BackgroundTransparency = 0.38 })
	Util.tween(stroke, FADE, { Transparency = 0.88 })
	Util.tween(shine, FADE, { GroupTransparency = 0 })
	Util.tween(shadow, FADE, { ImageTransparency = 0.9 })
	Util.tween(icon, FADE, { ImageTransparency = 0 })
	Util.tween(titleLabel, FADE, { TextTransparency = 0 })
	Util.tween(bodyLabel, FADE, { TextTransparency = 0 })

	local closed = false
	local function dismiss()
		if closed then return end
		closed = true
		Util.tween(card, SHUT, { Size = UDim2.new(1, 0, 0, 0), BackgroundTransparency = 1 })
		Util.tween(wallpaper, SHUT, { ImageTransparency = 1 })
		Util.tween(wash, SHUT, { BackgroundTransparency = 1 })
		Util.tween(stroke, SHUT, { Transparency = 1 })
		Util.tween(shine, SHUT, { GroupTransparency = 1 })
		Util.tween(shadow, SHUT, { ImageTransparency = 1 })
		Util.tween(icon, SHUT, { ImageTransparency = 1 })
		Util.tween(titleLabel, SHUT, { TextTransparency = 1 })
		Util.tween(bodyLabel, SHUT, { TextTransparency = 1 })
		task.delay(0.3, function()
			card:Destroy()
		end)
	end

	card.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dismiss()
		end
	end)

	task.delay(duration, dismiss)
	return card
end
end

do
local Util  = Novo.Util
local Theme = Novo.Theme
local new   = Util.new

local FADE = TweenInfo.new(0.20, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

local function overlayGui(name, displayOrder)
	local screen = new("ScreenGui", {
		Name = name,
		DisplayOrder = displayOrder,
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Global,
		Enabled = true,
		ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,
		ClipToDeviceSafeArea = true,
	})
	Novo.Guis[#Novo.Guis + 1] = screen
	return screen
end

local function hoverFade(btn, target, prop, base, over, down)
	local hovering = false
	local function to(v)
		Util.tween(target, Util.Motion.Snap, { [prop] = v })
	end
	btn.MouseEnter:Connect(function()
		hovering = true
		to(over)
	end)
	btn.MouseLeave:Connect(function()
		hovering = false
		to(base)
	end)
	btn.MouseButton1Down:Connect(function() to(down) end)
	btn.MouseButton1Up:Connect(function() to(hovering and over or base) end)
end

local ImageViewer = {}
Novo.ImageViewer = ImageViewer

function ImageViewer.build()
	if ImageViewer.screen then return ImageViewer.screen end

	local screen = overlayGui("NovoImageViewer", 90)

	local backdrop = new("Frame", {
		Name = "Backdrop",
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 1,
		Parent = screen,
	})

	local card = new("Frame", {
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromOffset(360, 360),
		BackgroundColor3 = Theme.Raise,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ZIndex = 2,
		Parent = backdrop,
	})
	Util.corner(Theme.R_Panel, card)
	Util.stroke(Theme.Stroke, 1, 0.4, Enum.ApplyStrokeMode.Contextual, card)

	local photo = new("ImageLabel", {
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.new(1, -20, 1, -20),
		BackgroundColor3 = Color3.fromRGB(18, 18, 20),
		BackgroundTransparency = 0.2,
		BorderSizePixel = 0,
		Image = "",
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 3,
		Parent = card,
	})
	Util.corner(Theme.R_Button, photo)

	local close = new("TextButton", {
		Name = "Close",
		Position = UDim2.new(1, -2, 0, -6),
		AnchorPoint = Vector2.new(1, 1),
		Size = UDim2.fromOffset(26, 26),
		BackgroundColor3 = Color3.fromRGB(18, 18, 22),
		BackgroundTransparency = 0.25,
		Text = "",
		TextSize = 8,
		AutoButtonColor = false,
		ZIndex = 4,
		Parent = card,
	})
	Util.corner(Theme.R_Pill, close)
	Util.stroke(Color3.fromRGB(255, 255, 255), 1, 0.85, Enum.ApplyStrokeMode.Contextual, close)

	local closeIcon = new("ImageLabel", {
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromOffset(14, 14),
		BackgroundTransparency = 1,
		Image = Theme.Icon.Cross,
		ImageColor3 = Theme.Text,
		ImageTransparency = 0.15,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 5,
		Parent = close,
	})

	hoverFade(close, close, "BackgroundTransparency", 0.25, 0.1, 0.35)
	hoverFade(close, closeIcon, "ImageTransparency", 0.15, 0, 0.3)
	close.MouseButton1Click:Connect(function()
		ImageViewer.hide()
	end)

	ImageViewer.screen = screen
	ImageViewer.backdrop = backdrop
	ImageViewer.card = card
	ImageViewer.photo = photo
	ImageViewer.close = close
	return screen
end

function ImageViewer.show(image)
	if not ImageViewer.backdrop then return end
	if image then
		ImageViewer.photo.Image = image
	end
	ImageViewer.backdrop.Visible = true
	ImageViewer.card.BackgroundTransparency = 1
	ImageViewer.photo.ImageTransparency = 1
	Util.tween(ImageViewer.card, FADE, { BackgroundTransparency = 0 })
	Util.tween(ImageViewer.photo, FADE, { ImageTransparency = 0 })
end

function ImageViewer.hide()
	if not ImageViewer.backdrop then return end
	ImageViewer.backdrop.Visible = false
end

function ImageViewer.toggle(image)
	if ImageViewer.backdrop and ImageViewer.backdrop.Visible then
		ImageViewer.hide()
	else
		ImageViewer.show(image)
	end
end

local MobileFab = {}
Novo.MobileFab = MobileFab

function MobileFab.build()
	if MobileFab.screen then return MobileFab.screen end

	local screen = overlayGui("NovoMobileFab", 51)

	local fab = new("Frame", {
		Name = "MobileFAB",
		Position = UDim2.new(0, 1848, 0, 575),
		Size = UDim2.fromOffset(54, 54),
		BackgroundColor3 = Theme.Raise,
		BackgroundTransparency = 0,
		Visible = false,
		ZIndex = 200,
		Parent = screen,
	})
	Util.corner(Theme.R_Pill, fab)
	local ring = Util.stroke(Color3.fromRGB(50, 50, 75), 1.5, 0.35, Enum.ApplyStrokeMode.Border, fab)

	new("UIGradient", {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 36)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 22)),
		}),
		Transparency = NumberSequence.new(0),
		Rotation = 135,
		Offset = Vector2.new(0, 0),
		Parent = fab,
	})

	new("ImageLabel", {
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromOffset(26, 26),
		BackgroundTransparency = 1,
		Image = Theme.Icon.Fab,
		ImageColor3 = Color3.fromRGB(255, 255, 255),
		ImageTransparency = 0,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 201,
		Parent = fab,
	})

	local hit = new("TextButton", {
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = "",
		TextSize = 8,
		AutoButtonColor = false,
		ZIndex = 202,
		Parent = fab,
	})

	hoverFade(hit, ring, "Transparency", 0.35, 0.18, 0.45)
	hit.MouseButton1Click:Connect(function()
		if Novo.setOpen then
			Novo.setOpen(not Novo.open)
		end
	end)
	Util.draggable(hit, fab)

	MobileFab.screen = screen
	MobileFab.frame = fab
	MobileFab.button = hit
	MobileFab.stroke = ring
	return screen
end

function MobileFab.setVisible(on)
	if MobileFab.frame then
		MobileFab.frame.Visible = on and true or false
	end
end

function MobileFab.show() MobileFab.setVisible(true) end
function MobileFab.hide() MobileFab.setVisible(false) end
end

do
local Util  = Novo.Util
local Theme = Novo.Theme
local new   = Util.new

Novo.Features = {}
local Features = Novo.Features

local function character()
	local plr = LocalPlayer
	if not plr then return nil end
	local char = plr.Character
	if not char then return nil end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hrp or not hum then return nil end
	return char, hrp, hum
end

local Fly = {}
Features.Fly = Fly
Fly.enabled = false
Fly.speed = 60
Fly.changed = Instance.new("BindableEvent")

local flyVelocity, flyGyro, flyLoop, flyRespawn
local flyUp, flyDown = false, false

local function stopFly()
	if flyLoop then
		flyLoop:Disconnect()
		flyLoop = nil
	end
	if flyVelocity then
		flyVelocity:Destroy()
		flyVelocity = nil
	end
	if flyGyro then
		flyGyro:Destroy()
		flyGyro = nil
	end
	local _, _, hum = character()
	if hum then
		hum.PlatformStand = false
	end
end

local function startFly()
	local char, hrp, hum = character()
	if not hrp then return false end

	stopFly()
	hum.PlatformStand = true

	flyVelocity = new("BodyVelocity", {
		Name = "NovoFlyVelocity",
		MaxForce = Vector3.new(1e5, 1e5, 1e5),
		Velocity = Vector3.zero,
		P = 1250,
		Parent = hrp,
	})
	flyGyro = new("BodyGyro", {
		Name = "NovoFlyGyro",
		MaxTorque = Vector3.new(4e5, 4e5, 4e5),
		P = 9e4,
		D = 500,
		CFrame = hrp.CFrame,
		Parent = hrp,
	})

	flyLoop = RunService.RenderStepped:Connect(function()
		if not Fly.enabled then return end
		local c, root, humanoid = character()
		if not root or not flyVelocity or not flyGyro then return end
		if flyVelocity.Parent ~= root then
			flyVelocity.Parent = root
			flyGyro.Parent = root
		end
		humanoid.PlatformStand = true

		local camera = workspace.CurrentCamera
		local move = humanoid.MoveDirection * Fly.speed

		local lift = 0
		if flyUp then lift += Fly.speed end
		if flyDown then lift -= Fly.speed end

		flyVelocity.Velocity = Vector3.new(move.X, lift, move.Z)
		if camera then
			flyGyro.CFrame = camera.CFrame
		end
	end)
	return true
end

function Fly.set(on)
	if Fly.enabled == on then return end
	Fly.enabled = on
	if on then
		if not startFly() then
			Fly.enabled = false
			return
		end
		if not flyRespawn and LocalPlayer then
			flyRespawn = LocalPlayer.CharacterAdded:Connect(function()
				if not Fly.enabled then return end
				task.wait(0.6)
				startFly()
			end)
		end
	else
		stopFly()
	end
	Fly.changed:Fire(Fly.enabled)
end

function Fly.toggle()
	Fly.set(not Fly.enabled)
end

UserInputService.InputBegan:Connect(function(input, typing)
	if typing then return end
	if input.KeyCode == Enum.KeyCode.Space then flyUp = true end
	if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.LeftShift then
		flyDown = true
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Space then flyUp = false end
	if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.LeftShift then
		flyDown = false
	end
end)

local Esp = {}
Features.Esp = Esp
Esp.options = {
	Enabled = false,
	Chams = false,
	Hitboxes = false,
	TeamColors = false,
	HideTeams = false,
}

local espFolder, espLoop
local espEntries = {}
local hitboxOriginal = {}

local BOX_SIZE = Vector2.new(190, 46)

local function espHost()
	if espFolder and espFolder.Parent then return espFolder end
	espFolder = new("Folder", { Name = "NovoEsp" })
	espFolder:SetAttribute("NovoReplica", true)
	local ok, hidden = pcall(function() return gethui and gethui() end)
	espFolder.Parent = (ok and hidden) or CoreGui
	return espFolder
end

local function teamColorOf(plr)
	if Esp.options.TeamColors and plr.Team then
		return plr.TeamColor.Color
	end
	return Theme.Accent
end

local function buildEntry(plr)
	local host = espHost()

	local billboard = new("BillboardGui", {
		Name = "NovoTag_" .. plr.Name,
		Size = UDim2.fromOffset(BOX_SIZE.X, BOX_SIZE.Y),
		StudsOffset = Vector3.new(0, 3.1, 0),
		AlwaysOnTop = true,
		ClipsDescendants = false,
		Parent = host,
	})

	local name = new("TextLabel", {
		Name = "Name",
		Size = UDim2.new(1, 0, 0, 16),
		BackgroundTransparency = 1,
		Text = plr.DisplayName,
		TextColor3 = Theme.TextBright,
		TextSize = 14,
		FontFace = Theme.Font.Bold,
		TextStrokeColor3 = Color3.new(0, 0, 0),
		TextStrokeTransparency = 0.4,
		Parent = billboard,
	})

	local detail = new("TextLabel", {
		Name = "Detail",
		Position = UDim2.fromOffset(0, 16),
		Size = UDim2.new(1, 0, 0, 13),
		BackgroundTransparency = 1,
		Text = "",
		TextColor3 = Theme.TextMuted,
		TextSize = 11,
		FontFace = Theme.Font.Medium,
		TextStrokeColor3 = Color3.new(0, 0, 0),
		TextStrokeTransparency = 0.55,
		Parent = billboard,
	})

	local barBack = new("Frame", {
		Name = "HealthBack",
		Position = UDim2.new(0.5, 0, 0, 32),
		AnchorPoint = Vector2.new(0.5, 0),
		Size = UDim2.fromOffset(74, 4),
		BackgroundColor3 = Color3.fromRGB(12, 12, 14),
		BackgroundTransparency = 0.25,
		BorderSizePixel = 0,
		Parent = billboard,
	})
	Util.corner(Theme.R_Pill, barBack)

	local barFill = new("Frame", {
		Name = "HealthFill",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Theme.Good,
		BorderSizePixel = 0,
		Parent = barBack,
	})
	Util.corner(Theme.R_Pill, barFill)

	local highlight = new("Highlight", {
		Name = "NovoChams_" .. plr.Name,
		FillColor = Theme.Accent,
		OutlineColor = Theme.AccentLight,
		FillTransparency = 0.62,
		OutlineTransparency = 0,
		DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
		Enabled = false,
		Parent = host,
	})

	return {
		player = plr,
		billboard = billboard,
		name = name,
		detail = detail,
		barBack = barBack,
		barFill = barFill,
		highlight = highlight,
	}
end

local function clearEntry(plr)
	local entry = espEntries[plr]
	if not entry then return end
	entry.billboard:Destroy()
	entry.highlight:Destroy()
	espEntries[plr] = nil
end

local function restoreHitbox(plr)
	local saved = hitboxOriginal[plr]
	if not saved then return end
	local char = plr.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.Size = saved.size
		hrp.Transparency = saved.transparency
		hrp.CanCollide = saved.canCollide
	end
	hitboxOriginal[plr] = nil
end

local function applyHitbox(plr)
	local char = plr.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	if not hitboxOriginal[plr] then
		hitboxOriginal[plr] = {
			size = hrp.Size,
			transparency = hrp.Transparency,
			canCollide = hrp.CanCollide,
		}
	end
	hrp.Size = Vector3.new(9, 9, 9)
	hrp.Transparency = 0.72
	hrp.CanCollide = false
end

local function shouldShow(plr)
	if plr == LocalPlayer then return false end
	if Esp.options.HideTeams and plr.Team and LocalPlayer.Team and plr.Team == LocalPlayer.Team then
		return false
	end
	return true
end

local function updateEsp()
	local camera = workspace.CurrentCamera
	local myChar, myRoot = character()

	for _, plr in ipairs(Players:GetPlayers()) do
		if not shouldShow(plr) then
			clearEntry(plr)
			restoreHitbox(plr)
		else
			local char = plr.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			local hum = char and char:FindFirstChildOfClass("Humanoid")

			if not hrp or not hum or hum.Health <= 0 then
				clearEntry(plr)
			else
				local entry = espEntries[plr]
				if not entry then
					entry = buildEntry(plr)
					espEntries[plr] = entry
				end

				local colour = teamColorOf(plr)
				entry.billboard.Adornee = hrp
				entry.name.TextColor3 = Esp.options.TeamColors and colour or Theme.TextBright

				local distance = 0
				if myRoot then
					distance = math.floor((hrp.Position - myRoot.Position).Magnitude)
				end
				entry.detail.Text = string.format("%d hp  %d m", math.floor(hum.Health), distance)

				local pct = math.clamp(hum.Health / math.max(hum.MaxHealth, 1), 0, 1)
				entry.barFill.Size = UDim2.fromScale(pct, 1)
				entry.barFill.BackgroundColor3 = Color3.fromRGB(
					math.floor(255 * (1 - pct)),
					math.floor(200 * pct),
					math.floor(120 * pct)
				)

				entry.highlight.Adornee = char
				entry.highlight.Enabled = Esp.options.Chams
				entry.highlight.FillColor = colour
				entry.highlight.OutlineColor = Esp.options.TeamColors and colour or Theme.AccentLight

				if Esp.options.Hitboxes then
					applyHitbox(plr)
				else
					restoreHitbox(plr)
				end
			end
		end
	end

	for plr in pairs(espEntries) do
		if not plr.Parent then
			clearEntry(plr)
			restoreHitbox(plr)
		end
	end
end

local function teardownEsp()
	if espLoop then
		espLoop:Disconnect()
		espLoop = nil
	end
	for plr in pairs(espEntries) do
		clearEntry(plr)
	end
	for plr in pairs(hitboxOriginal) do
		restoreHitbox(plr)
	end
	if espFolder then
		espFolder:Destroy()
		espFolder = nil
	end
end

function Esp.setOption(key, value)
	Esp.options[key] = value
	if key == "Enabled" then
		if value then
			if not espLoop then
				espHost()
				espLoop = RunService.Heartbeat:Connect(updateEsp)
			end
		else
			teardownEsp()
		end
	elseif not Esp.options.Enabled then
		return
	elseif key == "Hitboxes" and not value then
		for plr in pairs(hitboxOriginal) do
			restoreHitbox(plr)
		end
	end
end

function Esp.set(on)
	Esp.setOption("Enabled", on)
end

function Esp.toggle()
	Esp.set(not Esp.options.Enabled)
end

local Mic = {}
Features.Mic = Mic
Mic.enabled = false
Mic.running = false
Mic.muted = true
Mic.changed = Instance.new("BindableEvent")

local micDevice, micInternal, micIconClone, micLiveIcon, micMutedIcon

local function notify(title, text)
	if Novo.Notify and Novo.Notify.push then
		Novo.Notify.push(title, text, 4)
	else
		pcall(function()
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = title, Text = text, Duration = 4,
			})
		end)
	end
end

function Mic.setMuted(value)
	Mic.muted = value
	local lp = LocalPlayer
	local device = lp and lp:FindFirstChildWhichIsA("AudioDeviceInput", true)
	if device then
		device.Active = not value
	elseif micInternal then
		pcall(function() micInternal:PublishPause(value) end)
	end
	if micIconClone then
		micIconClone.Image = value and micMutedIcon or micLiveIcon
	end
	Mic.changed:Fire(Mic.enabled)
end

function Mic.toggleMute()
	if not Mic.enabled then return end
	Mic.setMuted(not Mic.muted)
end

function Mic.run()
	if Mic.running then
		notify("Mic bypasser", "Already running.")
		return
	end
	Mic.running = true

	task.spawn(function()
		local ok, err = pcall(function()
			local clone = cloneref or function(v) return v end
			local vcs = clone(game:GetService("VoiceChatService"))
			local vci = clone(game:GetService("VoiceChatInternal"))
			local lp = Players.LocalPlayer
			local getconns = (clonefunction and clonefunction(getconnections)) or getconnections

			local mutedIcon = "rbxasset://textures/ui/VoiceChat/MicLight/Muted.png"
			local stash = new("Folder", {
				Name = "NovoMicStash",
				Parent = game:GetService("RobloxReplicatedStorage"),
			})

			local hasVoice = select(2, pcall(vcs.IsVoiceEnabledForUserIdAsync, vcs, lp.UserId))
			if not hasVoice then
				notify("Mic bypasser", "Voice chat is not enabled on this account.")
				return
			end

			local topbar = CoreGui:WaitForChild("TopBarApp", 15):WaitForChild("TopBarApp", 15)
			local leftFrame = topbar:WaitForChild("UnibarLeftFrame", 15)
			local menu = leftFrame:WaitForChild("UnibarMenu", 15) or leftFrame:WaitForChild("ChromeMenu", 15)
			local container = menu:WaitForChild("2", 15):WaitForChild("3", 15)
			local micBtn = container:FindFirstChild("toggle_mic_mute", true)

			if not micBtn then
				vcs:joinVoice()
				micBtn = container:WaitForChild("toggle_mic_mute", 15)
			end

			if micBtn.IntegrationIconFrame.IntegrationIcon["1"].Image == mutedIcon then
				notify("Mic bypasser", "Unmute your mic first, then it will continue.")
				repeat
					task.wait(0.1)
				until micBtn.IntegrationIconFrame.IntegrationIcon["1"].Image ~= mutedIcon
			end

			notify("Mic bypasser", "Rejoining voice, hold on.")

			vcs:leaveVoice()
			task.wait(2)

			local conns = getconns(vci.StateChanged)
			for i = 7, #conns do
				if conns[i] then conns[i]:Disable() end
			end
			task.wait(1.5)

			vcs:joinVoice()
			task.wait(2)

			container = menu:WaitForChild("2", 15):WaitForChild("3", 15)
			micBtn = container:WaitForChild("toggle_mic_mute", 15)

			local replacement = micBtn:Clone()
			micBtn.Parent = stash
			replacement.Name = "toggle_mic_mute_new"
			replacement.Parent = container

			local cloneIcon = replacement.IntegrationIconFrame.IntegrationIcon["1"]
			local liveIcon = micBtn.IntegrationIconFrame.IntegrationIcon["1"]

			micInternal = vci
			micIconClone = cloneIcon
			micLiveIcon = liveIcon.Image
			micMutedIcon = mutedIcon

			Mic.setMuted(true)

			replacement.IconHitArea_toggle_mic_mute.Activated:Connect(function()
				Mic.toggleMute()
			end)

			Mic.enabled = true
			Mic.changed:Fire(true)
			notify("Mic bypasser", "Active. Your mic reads as muted to everyone else.")
		end)

		Mic.running = false
		if not ok then
			notify("Mic bypasser", "Failed: " .. tostring(err))
		end
	end)
end

local Target = {}
Features.Target = Target
Target.hidden = {}
Target.muted = {}
Target.tagged = {}
Target.conns = {}

local tagFolder

local function tagHost()
	if tagFolder and tagFolder.Parent then return tagFolder end
	tagFolder = new("Folder", { Name = "NovoTargets" })
	tagFolder:SetAttribute("NovoReplica", true)
	local ok, hidden = pcall(function() return gethui and gethui() end)
	tagFolder.Parent = (ok and hidden) or CoreGui
	return tagFolder
end

function Target.goTo(plr)
	local _, myRoot = character()
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	if not myRoot or not root then
		Novo.notify("Goto", "That player has no character right now.")
		return false
	end
	myRoot.CFrame = root.CFrame * CFrame.new(0, 0, 3.5)
	return true
end

local function paintCharacter(char, hide)
	for _, part in ipairs(char:GetDescendants()) do
		if part:IsA("BasePart") then
			part.LocalTransparencyModifier = hide and 1 or 0
		elseif part:IsA("Decal") or part:IsA("Texture") then
			part.LocalTransparencyModifier = hide and 1 or 0
		elseif part:IsA("BillboardGui") or part:IsA("SurfaceGui") then
			part.Enabled = not hide
		end
	end
end

function Target.setHidden(plr, hide)
	Target.hidden[plr] = hide or nil
	local char = plr and plr.Character
	if char then
		paintCharacter(char, hide)
	end
	if hide and plr and not Target.conns[plr] then
		Target.conns[plr] = plr.CharacterAdded:Connect(function(newChar)
			task.wait(0.4)
			if Target.hidden[plr] then
				paintCharacter(newChar, true)
			end
			local h = Target.tagged[plr]
			if h then h.Adornee = newChar end
		end)
	end
	return hide
end

function Target.toggleHidden(plr)
	local now = not Target.hidden[plr]
	Target.setHidden(plr, now)
	return now
end

local function voiceParts(plr)
	local found = {}
	local char = plr and plr.Character
	for _, root in ipairs({ plr, char }) do
		if root then
			for _, d in ipairs(root:GetDescendants()) do
				if d:IsA("AudioDeviceInput") or d:IsA("AudioEmitter") then
					found[#found + 1] = d
				end
			end
		end
	end
	return found
end

function Target.setMuted(plr, mute)
	Target.muted[plr] = mute or nil
	local parts = voiceParts(plr)
	for _, d in ipairs(parts) do
		if d:IsA("AudioDeviceInput") then
			pcall(function() d.Muted = mute end)
		elseif d:IsA("AudioEmitter") then
			pcall(function() d.AudioInteractionGroup = mute and "NovoMuted" or "Default" end)
		end
	end
	if #parts == 0 then
		pcall(function()
			local vci = (cloneref or function(v) return v end)(game:GetService("VoiceChatInternal"))
			vci:SubscribePause(plr.UserId, mute)
		end)
	end
	return mute
end

function Target.toggleMuted(plr)
	local now = not Target.muted[plr]
	Target.setMuted(plr, now)
	return now
end

function Target.setTagged(plr, on)
	if on then
		local host = tagHost()
		local existing = Target.tagged[plr]
		if not existing then
			existing = new("Highlight", {
				Name = "NovoTag_" .. plr.Name,
				FillColor = Theme.AccentLight,
				OutlineColor = Theme.TextBright,
				FillTransparency = 0.55,
				OutlineTransparency = 0,
				DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
				Parent = host,
			})
			Target.tagged[plr] = existing
		end
		existing.Adornee = plr.Character
		if not Target.conns[plr] then
			Target.conns[plr] = plr.CharacterAdded:Connect(function(char)
				task.wait(0.4)
				if Target.hidden[plr] then
					paintCharacter(char, true)
				end
				local h = Target.tagged[plr]
				if h then h.Adornee = char end
			end)
		end
	else
		local h = Target.tagged[plr]
		if h then
			h:Destroy()
			Target.tagged[plr] = nil
		end
	end
	return on
end

function Target.toggleTagged(plr)
	local now = Target.tagged[plr] == nil
	Target.setTagged(plr, now)
	return now
end

local Scripts = {}
Features.Scripts = Scripts

Scripts.sources = { "scriptblox", "roscripts" }

local function httpGet(url)
    local ok, res = pcall(function() return game:HttpGet(url) end)
    if ok then return res end
    return nil
end

local function decode(raw)
    if not raw then return nil end
    local ok, data = pcall(function() return HttpService:JSONDecode(raw) end)
    if ok then return data end
    return nil
end

local function scriptbloxSearch(query, limit)
    local url
    if query == "" then
        url = ("https://scriptblox.com/api/script/fetch?page=1&max=%d"):format(limit)
    else
        url = ("https://scriptblox.com/api/script/search?q=%s&max=%d")
            :format(HttpService:UrlEncode(query), limit)
    end
    local data = decode(httpGet(url))
    local list = data and data.result and data.result.scripts
    if type(list) ~= "table" then return {} end

    local out = {}
    for _, s in ipairs(list) do
        out[#out + 1] = {
            title = s.title or "Untitled",
            game = (s.game and s.game.name) or "",
            key = s.key == true,
            verified = s.verified == true,
            patched = s.isPatched == true,
            views = s.views or 0,
            source = "scriptblox",
            slug = s.slug,
            script = s.script,
        }
    end
    return out
end

local function roscriptsSearch(query, limit)
    local url
    if query == "" then
        url = ("https://api.roscripts.io/v1/scripts/trending?limit=%d"):format(limit)
    else
        url = ("https://api.roscripts.io/v1/scripts/search?q=%s&limit=%d")
            :format(HttpService:UrlEncode(query), limit)
    end
    local data = decode(httpGet(url))
    local list = data and data.result and data.result.scripts
    if type(list) ~= "table" then return {} end

    local out = {}
    for _, s in ipairs(list) do
        out[#out + 1] = {
            title = s.title or "Untitled",
            game = (s.game and s.game.name) or "",
            key = s.key == true,
            verified = s.verified == true,
            patched = s.patched == true,
            views = s.views or s.viewsTotal or 0,
            source = "roscripts",
            slug = s.slug or s.shortId or s.id,
            rawUrl = s.rawUrl,
        }
    end
    return out
end

function Scripts.search(query, limit)
    query = query or ""
    limit = limit or 20
    local half = math.max(4, math.floor(limit / 2))

    local results = {}
    local okA, a = pcall(scriptbloxSearch, query, half)
    local okB, b = pcall(roscriptsSearch, query, half)

    local function absorb(list)
        for _, entry in ipairs(list or {}) do
            results[#results + 1] = entry
        end
    end

    if okA then absorb(a) end
    if okB then absorb(b) end

    table.sort(results, function(x, y)
        return (x.views or 0) > (y.views or 0)
    end)
    return results
end

function Scripts.fetchSource(entry)
    if not entry then return nil, "no script selected" end
    if entry.script and #entry.script > 0 then
        return entry.script
    end

    if entry.source == "roscripts" then
        local url = entry.rawUrl
            or ("https://api.roscripts.io/v1/scripts/%s/raw"):format(tostring(entry.slug))
        local body = httpGet(url)
        if body and #body > 0 then return body end
        return nil, "could not download the source"
    end

    local data = decode(httpGet(("https://scriptblox.com/api/script/%s"):format(tostring(entry.slug))))
    local s = data and data.script
    if s and s.script then return s.script end
    return nil, "could not download the source"
end

function Scripts.run(entry)
    local source, err = Scripts.fetchSource(entry)
    if not source then
        Novo.notify("Scripts", err or "Nothing to run.")
        return false
    end

    local chunk, compileErr = loadstring(source)
    if not chunk then
        Novo.notify("Scripts", "Would not compile: " .. tostring(compileErr))
        return false
    end

    Novo.notify("Scripts", "Running " .. (entry.title or "script"))
    task.spawn(function()
        local ok, runErr = pcall(chunk)
        if not ok then
            Novo.notify("Scripts", "Errored: " .. tostring(runErr))
        end
    end)
    return true
end

local Friends = {}
Features.Friends = Friends

function Friends.online()
	local plr = LocalPlayer
	if not plr then return {} end
	local ok, list = pcall(function() return plr:GetFriendsOnline(200) end)
	if not ok or type(list) ~= "table" then return {} end

	local inGame = {}
	for _, f in ipairs(list) do
		if f.PlaceId and f.GameId then
			inGame[#inGame + 1] = {
				userId = f.VisitorId or f.UserId,
				name = f.DisplayName or f.UserName or "Friend",
				placeId = f.PlaceId,
				gameId = f.GameId,
				location = f.LastLocation or "In game",
			}
		end
	end
	return inGame
end

function Friends.join(entry)
	if not entry or not entry.placeId or not entry.gameId then
		notify("Join friend", "That friend is not in a joinable server.")
		return false
	end
	local ok, err = pcall(function()
		game:GetService("TeleportService")
			:TeleportToPlaceInstance(entry.placeId, entry.gameId, LocalPlayer)
	end)
	if not ok then
		notify("Join friend", "Teleport failed: " .. tostring(err))
	end
	return ok
end

Novo.notify = notify
end

do
local Util  = Novo.Util
local Theme = Novo.Theme

local TOGGLE_KEY = Enum.KeyCode.RightShift

local function host()
	local ok, hidden = pcall(function()
		return gethui and gethui() or nil
	end)
	if ok and hidden then return hidden end
	local ok2 = pcall(function()
		return CoreGui.Name
	end)
	if ok2 then return CoreGui end
	return LocalPlayer:WaitForChild("PlayerGui")
end

local function protect(gui)
	pcall(function()
		if syn and syn.protect_gui then
			syn.protect_gui(gui)
		elseif protect_gui then
			protect_gui(gui)
		end
	end)
end

local function cleanup(parent)
	for _, child in ipairs(parent:GetChildren()) do
		if child:GetAttribute("NovoReplica") then
			child:Destroy()
		end
	end
end

local OPEN_SCALE  = TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local OPEN_FADE   = TweenInfo.new(0.20, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local CLOSE_SCALE = TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.In)

function Novo.setOpen(open, instant)
	local wrap = Novo.Window.wrap
	local scale = Novo.Window.scale
	if open then
		wrap.Visible = true
		if instant then
			scale.Scale = 1
			return
		end
		scale.Scale = 0.88
		Util.tween(scale, OPEN_SCALE, { Scale = 1 })
		Novo.Window.panel.BackgroundTransparency = 1
		Novo.Window.nav.BackgroundTransparency = 1
		Util.tween(Novo.Window.panel, OPEN_FADE, { BackgroundTransparency = 0 })
		task.delay(0.06, function()
			Util.tween(Novo.Window.nav, OPEN_FADE, { BackgroundTransparency = 0 })
		end)
	else
		if instant then
			wrap.Visible = false
			return
		end
		local t = Util.tween(scale, CLOSE_SCALE, { Scale = 0.9 })
		t.Completed:Connect(function()
			wrap.Visible = false
		end)
	end
	Novo.open = open
end

local function boot()
	local parent = host()
	cleanup(parent)

	Novo.Window.build()

	if Novo.Panels and Novo.Panels.build then Novo.Panels.build() end
	if Novo.CmdBar and Novo.CmdBar.build then Novo.CmdBar.build() end
	if Novo.Notify and Novo.Notify.build then Novo.Notify.build() end
	if Novo.ImageViewer and Novo.ImageViewer.build then Novo.ImageViewer.build() end
	if Novo.MobileFab and Novo.MobileFab.build then Novo.MobileFab.build() end

	for _, gui in ipairs(Novo.Guis) do
		gui:SetAttribute("NovoReplica", true)
		protect(gui)
		gui.Parent = parent
	end

	Novo.open = true
	Novo.setOpen(true)

	UserInputService.InputBegan:Connect(function(input, typing)
		if typing then return end
		if input.KeyCode == TOGGLE_KEY then
			Novo.setOpen(not Novo.open)
		end
	end)
end

boot()

return Novo
end

