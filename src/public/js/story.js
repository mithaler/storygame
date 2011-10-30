$(function() {
    $('#name-entry').submit(function(e) {
        e.preventDefault();
        var name = $('#player-name').val();

        if (name.length === 0) {
            return false; // TODO: show an error of some sort
        }

        $.post(window.location.pathname + '/post/name', {name: $('#player-name').val()}, function(data) {
            alert('Name successfully set to ' + data.name);
        }, 'json');
    });
});
