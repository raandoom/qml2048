// show tile with animation
function show() {
    updateColor()
    labelContainer.x = cell.width / 2
    labelContainer.y = cell.height / 2
    labelContainer.center_x = x
    labelContainer.center_y = y
    show_anim.to = cell.width
    show_anim.start()
}

// move tile with animation (with merged tile if needed)
function move() {
    if (merged_cell)
        merged_cell.move()
    if (new_x && new_y) {
        move_anim.to = Qt.point(new_x,new_y)
        move_anim.start()
    }
}

// resize label if it is too large
function updateTextSize() {
    if (label.width > cell.width)
        label.scale = cell.width / label.width * 0.9
}

// set tile color (depend on current value)
function updateColor() {
    switch (value) {
    case 2      : labelContainer.color = "#eee4da"; break;
    case 4      : labelContainer.color = "#ede0c8"; break;
    case 8      : labelContainer.color = "#f2b179"; break;
    case 16     : labelContainer.color = "#f59563"; break;
    case 32     : labelContainer.color = "#f67c5f"; break;
    case 64     : labelContainer.color = "#f65e3b"; break;
    case 128    : labelContainer.color = "#edcf72"; break;
    case 256    : labelContainer.color = "#edcc61"; break;
    case 512    : labelContainer.color = "#edc850"; break;
    case 1024   : labelContainer.color = "#edc53f"; break;
    case 2048   : labelContainer.color = "#edc22e"; break;
    default     :
        labelContainer.color = "#3c3a32";
        label.color = "#eee4da";
        break;
    }
}
