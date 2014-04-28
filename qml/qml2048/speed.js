function saveSpeed() {
    Storage.setState("speed",speedButton.checkedButton.speed)
}

function loadSpeed() {
    switch (Storage.getState("speed")) {
    case '400'  :   slowSpeedButton.checked = true;     break
    case '100'  :   fastSpeedButton.checked = true;     break
    default     :   normalSpeedButton.checked = true;   break
    }
}
