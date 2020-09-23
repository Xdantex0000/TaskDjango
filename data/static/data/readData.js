const dataRead = function () {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', 'https://testenglish.spdns.eu/api/task?type=unread', false);
    xhr.send();
    console.log(xhr.status + '-' + xhr.statusText + ': ' + xhr.responseText)
}