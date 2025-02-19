var maximizeWindow = function(client) {
    if (client.fullScreen) {
        client.maximizedVertically = true;
        client.maximizedHorizontally = true;
    }
};

workspace.clientFullScreenSet.connect(maximizeWindow);
// qdbus org.kde.KWin /Scripting loadScript ~/.local/share/kwin/scripts/hide_titlebar
