local gcgui = {}

function gcgui.newGroupe()
    -- 📁📁 gestion des groupes 
    local myGroup = {
        elements = {}
    }
    
    -- 📇📇--> 📂📂 function d'ajout 
    function myGroup:addElement(pElement)
        -- on ajoute un element au groupe
        table.insert(self.elements, pElement)
    end
    
    -- function pour rendre visible nos elements
    function myGroup:setVisible(pVisible)
        for key, value in pairs(myGroup.elements) do
            value:setVisible(pVisible)
        end
    end

    function myGroup:update(dt)
        for key, value in pairs(myGroup.element) do
            value.update(dt)
        end
    end
        
        --On dessine le groupe 
        function myGroup:draw()
            -- permet de sauvegarder le contexte graphique à l'entrée et de le restaurer à la fin
            love.graphics.push()
            for key, value in pairs(myGroup.elements) do
                value:draw()
            end
            --  restaure le contexte graphique
            love.graphics.pop()
        end

        return myGroup
end

-- fonction de creation d'un element
-- parm 1 posX
-- param 2  posY
local function newElement(pX, pY)

    local element = {
        x = pX,
        y = pY
    }

    function element.update(dt)
        print("newElement / update / Not implemented")
    end

    function element:draw()
        print("newElement / draw / Not implemented")
    end

    function element:setVisible(pVisible)
        self.visible = pVisible
    end

    return element
end

function gcgui.newPanel(pX, pY, pWidth, pHeight)

    -- on ajoute un nouvel element a notre panel
    local panel = newElement(pX, pY)
    panel.width = pWidth
    panel.height = pHeight
    panel.image = nil

    -- on set l'image et ses dimensions
    function panel:setImage(pImage)
        self.image = pImage
        self.width = pImage:getWidth()
        self.Height = pImage:getHeight()
    end


   function panel:drawPanel()
    -- on passe un couleur a notre panel
    love.graphics.setColor(255, 255 ,255)
    
        if self.image == nil then
            love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
        else
            love.graphics.draw(self.image, self.x, self.y)
        end
   end

    function panel:draw()
        if self.visible == false then
            return 
        end
        self:drawPanel()
    end

    return panel

end

-- param 1 posX du text
-- param 2 posY //
-- param 3 largeur
-- param 4 hauteur 
-- param 5 text sur le panel
-- param 6 font
-- param 7 alignement du text horizontal
-- param 8 alignementdu text vertical
function gcgui.newText(pX, pY, pWidth, pHeight, pText, pFont, pWAlign, pHAlign)
    -- Text du panel
    local text = gcgui.newPanel(pX, pY, pWidth, pHeight)
    text.text = pText
    text.font = pFont
    text.textWidth = pFont:getWidth(pText)
    text.textHeight = pFont:getHeight(pText)
    text.widthAlign = PWAlign
    text.heightAlign = pHAlign

    function text:drawText(red, green, blue)
        love.graphics.setColor(red, green, blue)
        love.graphics.setFont(self.font)
        local x = self.x
        local y = self.y
        -- // gestion de l'aglinement du text
        if self.widthAlign == "center" then
            x = x + ((self.width - self.textWidth) / 2)
        end
        if self.heightAlign == "center" then
            y = y + ((self.height - self.textHeight) / 2)
        end
        love.graphics.print(self.text, x, y)
        love.graphics.setColor(255, 255, 255)
    end


    function text:draw(red, green, blue)
        if self.visible == false then
            return
        end
        self:drawText(red, green, blue)
    end

    return text

end

-- param 1 posX du button
-- param 2 posY //
-- param 3 largeur
-- param 4 hauteur 
-- param 5 text sur le button
-- param 6 font
-- param 7 color
function gcgui.newButton(pX, pY, PW, Ph, Ptext, Pfont, Pcolor)
    local button = gcgui.newPanel(pX, pY,pWidth, pHeight)
    button.text = pText
    button.font = pFont
    button.label = gcgui.newText(pX, pY, pWidth, pHeight, pText, pFont, pWAlign, pHAlign)

    button.isHover = false
    button.isPressed = false
    button.oldButtonState = false

    function button.draw()
        if self.isPressed then
            self.drawPanel()
            love.graphics.setColor(255, 255, 255)
            love.graphics.rectangle("line", self.x + 2, self.y + 2, self.width - 4, self.height - 4)
        else
            self.drawPanel()
        end
        self.label:draw()
    end
    return button
end

return gcgui