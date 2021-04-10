local Vendor = script.Parent.Parent.Parent
local Roact = require(Vendor.Roact)

local withTheme = require(script.Parent.Parent.withTheme)

local ScrollBar = Roact.Component:extend("ScrollBar")

function ScrollBar:init()
	self:setState({ Hover = false })
	self.onInputBegan = function(_, inputObject)
		if inputObject.UserInputType == Enum.UserInputType.MouseMovement then
			self:setState({ Hover = true })
		end
	end
	self.onInputEnded = function(_, inputObject)
		if inputObject.UserInputType == Enum.UserInputType.MouseMovement then
			self:setState({ Hover = false })
		end
	end
end

function ScrollBar:render()
	local modifier = Enum.StudioStyleGuideModifier.Default
	if self.props.Disabled then
		modifier = Enum.StudioStyleGuideModifier.Disabled
	elseif self.state.Hover then
		modifier = Enum.StudioStyleGuideModifier.Hover
	end
	return withTheme(function(theme)
		local newProps = {
			Position = self.props.Position,
			AnchorPoint = self.props.AnchorPoint,
			Size = self.props.Size,
			BackgroundColor3 = theme:GetColor(Enum.StudioStyleGuideColor.ScrollBar, modifier),
			BorderColor3 = theme:GetColor(Enum.StudioStyleGuideColor.Border, modifier),
		}
		if not self.props.Disabled then
			newProps[Roact.Event.InputBegan] = self.onInputBegan
			newProps[Roact.Event.InputEnded] = self.onInputEnded
		end
		return Roact.createElement("Frame", newProps)
	end)
end

return ScrollBar
