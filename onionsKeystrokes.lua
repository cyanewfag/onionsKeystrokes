local fonts = { renderer.create_font("Arial", 15, false) }
local colors = { color.new(20, 20, 20, 255), color.new(20, 20, 20, 220), color.new(255, 255, 255, 255), color.new(125, 125, 125, 255), color.new(35, 35, 35, 220) }

local function drawBlock(text, x, y, size, key)
    if (keys.key_down(key)) then
        renderer.filled_rect(x, y, size, size, colors[5]);
    else
        renderer.filled_rect(x, y, size, size, colors[1]);
    end
    renderer.rect(x, y, size, size, colors[4]);

    local textSize = renderer.get_text_size(text, fonts[1]);
    renderer.text(x + ((size / 2) - (textSize.x / 2)), y + ((size / 2) - (textSize.y / 2)), text, colors[3], fonts[1]);
end

local mousePos;
local mouseDown = { false, 0, 0, false, 0, 0 }
local blockInfo = { 100, 100, 40, 6 };
function on_render()
    mousePos = keys.get_mouse();

    if (keys.key_down(0x01)) then
        if (not mouseDown[1]) then
            mouseDown[1] = true;
            mouseDown[2], mouseDown[3] = mousePos.x, mousePos.y;

            if (mouseDown[2] >= blockInfo[1] and mouseDown[2] <= blockInfo[1] + ((blockInfo[3] * 3) + (blockInfo[4] * 2) + 10) and mouseDown[3] >= blockInfo[2] and mouseDown[3] <= blockInfo[2] + ((blockInfo[3] * 2) + blockInfo[4] + 10)) then
                mouseDown[4] = true;
                mouseDown[5], mouseDown[6] = mouseDown[2] - blockInfo[1], mouseDown[3] - blockInfo[2];
            end
        else
            if (mouseDown[4]) then
                blockInfo[1], blockInfo[2] = mousePos.x - mouseDown[5], mousePos.y - mouseDown[6];
            end
        end
    else
        mouseDown = { false, 0, 0, false, 0, 0 };
    end

    if (not mouseDown[4]) then
        renderer.filled_rect(blockInfo[1] - 5, blockInfo[2] - 5, (blockInfo[3] * 3) + (blockInfo[4] * 2) + 10, (blockInfo[3] * 2) + blockInfo[4] + 10, colors[2]);
    else
        renderer.filled_rect(blockInfo[1] - 5, blockInfo[2] - 5, (blockInfo[3] * 3) + (blockInfo[4] * 2) + 10, (blockInfo[3] * 2) + blockInfo[4] + 10, colors[5]);
    end

    renderer.rect(blockInfo[1] - 5, blockInfo[2] - 5, (blockInfo[3] * 3) + (blockInfo[4] * 2) + 10, (blockInfo[3] * 2) + blockInfo[4] + 10, colors[4]);
    
    drawBlock("W", blockInfo[1] + blockInfo[3] + blockInfo[4], blockInfo[2], blockInfo[3], 0x57)
    drawBlock("S", blockInfo[1] + blockInfo[3] + blockInfo[4], blockInfo[2] + blockInfo[3] + blockInfo[4], blockInfo[3], 0x53)
    drawBlock("A", blockInfo[1], blockInfo[2] + blockInfo[3] + blockInfo[4], blockInfo[3], 0x41)
    drawBlock("D", blockInfo[1] + ((blockInfo[3] + blockInfo[4]) * 2), blockInfo[2] + blockInfo[3] + blockInfo[4], blockInfo[3], 0x44)
end