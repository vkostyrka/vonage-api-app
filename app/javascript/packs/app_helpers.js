const emoji = require('node-emoji');

export function screenshareMode(session, mode) {
    if (mode == 'on') {
        window.location = '/screenshare?name=' + name;
        session.signal({
            type: 'screenshare',
            data: 'on'
        });
    } else if (mode == 'off') {
        window.location = '/party?name=' + name;
        session.signal({
            type: 'screenshare',
            data: 'off'
        });
    };
};

export function setButtonDisplay(element) {
    if (name == moderator_env_name) {
        element.style.display = "block";
    } else {
        element.style.display = "none";
    };
};

export function formatChatMsg(message) {
    var message_arr;
    message_arr = message.split(' ').map(function(word) {
        if (word.match(/(?:\:)\b(\w*)\b(?=\:)/g)) {
            return word = emoji.get(word);
        } else {
            return word;
        }
    })
    message = message_arr.join(' ');
    return `${name}: ${message}`
};

export function streamLayout(element, count) {
    if (count >= 6) {
        element.classList.add("grid9");
    } else if (count == 5) {
        element.classList.remove("grid9");
        element.classList.add("grid4");
    } else if (count < 5) {
        element.classList.remove("grid4");
    }
};